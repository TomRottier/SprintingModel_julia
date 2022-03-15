######
# can pass a Dict to kwarg "userdata" in the solve function, this can be accessed via integrator.opts.userdata
# may be useful for something
######

# functions for optimisations
# objective function
objective(x) =
    try
        cost(simulate(x, prob))
    catch
        return 10000.0
    end

# simulate a stride from prob
# Vern6() > Tsit5() > Vern7() > Vern8() > DP5()
simulate(prob) = solve(deepcopy(prob), Vern6(), callback = vcb, abstol = 1e-5, reltol = 1e-5, saveat = 0.001, verbose = false)

# run a simulate with new parameters
function simulate(x, prob)
    global prob
    # new parameter struct with updated parameters from x and reset torque generators, updated intial CC angles 
    pnew, unew = updateParameters(prob.p, x, prob.u0)

    # remake problem with updated parameters and initial conditions
    newprob = remake(prob, u0 = unew, p = pnew)

    # integrate new problem
    return simulate(newprob)
end
simulate(x::Vector{Float64}) = simulate(x, prob)

# cost function
# cost(sol) = 10(abs(VCMX - step_velocity(sol))) + abs(TSW - swing_time(sol))
mse(x, y) = (x .- y) .^ 2 |> mean
function cost(sol)::Float64
    global matching_data

    ## match hip and knee angles
    N = size(sol, 2)

    # calculate hip and knee angles
    θhip = π .+ view(sol, 7, :) .|> rad2deg
    θknee = π .- view(sol, 6, :) .|> rad2deg
    θhat = view(sol, 3, :) .|> rad2deg
    θankle = π .+ view(sol, 5, :) .|> rad2deg

    # calculate mse
    hip_mse = mse(θhip, view(matching_data[:lhip], 1:N))
    knee_mse = mse(θknee, view(matching_data[:lknee], 1:N))
    hat_mse = mse(θhat, view(matching_data[:lhat], 1:N))
    ankle_mse = mse(θankle, view(matching_data[:lankle], 1:N))

    # scale by range
    sf_hip = view(matching_data[:lhip], :) |> extrema |> collect |> diff
    sf_knee = view(matching_data[:lknee], :) |> extrema |> collect |> diff
    sf_hat = view(matching_data[:lhat], :) |> extrema |> collect |> diff
    hip_mse /= sf_hip[1]
    knee_mse /= sf_knee[1]
    hat_mse /= sf_hat[1]
    angles_cost = hip_mse + knee_mse + hat_mse + 0.1ankle_mse

    # time cost
    time_cost = 1000abs(sol.t[end] - 0.484)

    # periodicity cost
    weights = [0.0, 1.0, 0.8, 0.2, 0.5, 1.0, 1.0, 0.5, 0.5, 0.4, 0.1, 0.25, 0.5, 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0] # weighting of state components
    periodicity_cost = (sol.prob.u0 .- sol.u[end]) .^ 2 .* weights |> mean

    return angles_cost #+ 0.5time_cost #+ 0.8periodicity_cost

    # ## mse between start and end of simulation
    # weights = [0.0, 0.0, 1.0, 0.1, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.25, 0.7, 0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0] # weights vector
    # return ((sol.u[end] .- u₀).^2) .* weights |> mean
end

# converts input vector to parameters to be optimised and resets torque generators to inital values
function updateParameters(p, x, u₀)
    @unpack he, ke, ae, hf, kf, af = p
    @inbounds q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7 = u₀

    θh = π + q7
    θk = π - q6
    θa = π + q5

    ωh = u7
    ωk = -u6
    ωa = u5

    # manually separate out
    # he_α_p = ActivationProfile(x[1:7])
    # ke_α_p = ActivationProfile(x[8:14])
    # ae_α_p = ActivationProfile(x[15:21])
    # hf_α_p = ActivationProfile(x[22:28])
    # kf_α_p = ActivationProfile(x[29:35])
    # af_α_p = ActivationProfile(x[36:42])
    he_α_p = ActivationProfile(x[1:10])
    ke_α_p = ActivationProfile(x[11:20])
    ae_α_p = ActivationProfile(x[21:30])
    hf_α_p = ActivationProfile(x[31:40])
    kf_α_p = ActivationProfile(x[41:50])
    af_α_p = ActivationProfile(x[51:60])
    # he_α_p = ActivationProfile(x[1:13])
    # ke_α_p = ActivationProfile(x[14:26])
    # ae_α_p = ActivationProfile(x[27:39])
    # hf_α_p = ActivationProfile(x[40:52])
    # kf_α_p = ActivationProfile(x[53:65])
    # af_α_p = ActivationProfile(x[66:78])

    # torque generators with inital values and new activation parameters
    _he = TorqueGenerator(2π - θh, -ωh, he.cc.cc_p, he.sec.sec_p, he_α_p)
    _ke = TorqueGenerator(2π - θk, -ωk, ke.cc.cc_p, ke.sec.sec_p, ke_α_p)
    _ae = TorqueGenerator(2π - θa, -ωa, ae.cc.cc_p, ae.sec.sec_p, ae_α_p)
    _hf = TorqueGenerator(θh, ωh, hf.cc.cc_p, hf.sec.sec_p, hf_α_p)
    _kf = TorqueGenerator(θk, ωk, kf.cc.cc_p, kf.sec.sec_p, kf_α_p)
    _af = TorqueGenerator(θa, ωa, af.cc.cc_p, af.sec.sec_p, af_α_p)

    # get new initial CC angles
    _u₀ = SVector(u₀[1:14]..., map(x -> x.cc.θ, [_he, _ke, _ae, _hf, _kf, _af])...)


    # returns new Params struct with torque generators ready for next simulation
    _p = setproperties(p, (he = _he, ke = _ke, ae = _ae, hf = _hf, kf = _kf, af = _af))

    return _p, _u₀
end

# reutns parameters from an Params struct
get_parameters(p) = mapreduce(tqgen -> tqgen.cc.α_p |> Vector, vcat, [p.he, p.ke, p.ae, p.hf, p.kf, p.af])
