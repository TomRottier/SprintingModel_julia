######
# can pass a Dict to kwarg "userdata" in the solve function, this can be accessed via integrator.opts.userdata
# may be useful for something
######

# functions for optimisations
# objective function
objective(x) = cost(simulate(x, prob)...)

# simulate a stride from prob
function simulate(prob)
    # integrate step 1 to touchdown of step 2
    sol1 = solve(prob, Tsit5(), callback = end_step1, abstol = 1e-5, reltol = 1e-5, saveat = 0.001, verbose=false)

    # check if a second step will occur
    # pocmy(sol1, sol1.t[end]) ≤ com_drop && return 2e6 # or cost(sol1)
    vocmy(sol1, sol1.t[end]) ≤ -1.0 && return sol1, -1
    sol1.t[end] < 0.1 && return sol1, -1

    # fit splines to grf
    T = sol1.t[end]
    spl_x = Spline1D(sol1.t, rx(sol1))
    spl_y = Spline1D(sol1.t, ry(sol1))
    vrx(t) = evaluate(spl_x, t - T)
    vry(t) = evaluate(spl_y, t - T)

    # update parameters and initial conditions for step 2
    pnew = setproperties(prob.p, (vrx = vrx, vry = vry))
    unew = sol1.u[end]
    tnew = (sol1.t[end], 0.484) # TODO: make the end of integration time a global variable?
    newprob = remake(prob, u0 = unew, p = pnew, tspan = tnew)

    # integrate step 2
    saveats = sol1.t[end-1]+0.001:0.001:tnew[2] # start saving at next value after end of last integration
    sol2 = solve(newprob, Tsit5(), callback = end_step2, abstol = 1e-5, reltol = 1e-5, saveat = saveats, verbose=false)

    return sol1, sol2
end

# run a simulate with new parameters
function simulate(x, prob)
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

    # calculate mse
    hip_mse = mse(θhip, view(matching_data[:lhip], 1:N))
    knee_mse = mse(θknee, view(matching_data[:lknee], 1:N))

    # scale by range
    sf_hip = view(matching_data[:lhip], :) |> extrema |> collect |> diff
    sf_knee = view(matching_data[:lknee], :) |> extrema |> collect |> diff
    hip_mse /= sf_hip[1]
    knee_mse /= sf_knee[1]
    
    return hip_mse + knee_mse

    # ## mse between start and end of simulation
    # weights = [0.0, 0.0, 1.0, 0.1, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.25, 0.7, 0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0] # weights vector
    # return ((sol.u[end] .- u₀).^2) .* weights |> mean
end

function cost(sol1, sol2)::Float64
    global matching_data

    ## match hip and knee angles
    # combine results into array
    full = [Array(sol1)[:, 1:end-1] Array(sol2)]
    N = size(full, 2)

    # calculate hip and knee angles
    θhip = π .+ view(full, 7, :) .|> rad2deg
    θknee = π .- view(full, 6, :) .|> rad2deg

    # calculate mse
    hip_mse = mse(θhip, view(matching_data[:lhip], 1:N))
    knee_mse = mse(θknee, view(matching_data[:lknee], 1:N))

    # scale by range
    sf_hip = view(matching_data[:lhip], :) |> extrema |> collect |> diff 
    sf_knee = view(matching_data[:lknee], :) |> extrema |> collect |> diff
    hip_mse /= sf_hip[1]
    knee_mse /= sf_knee[1]
    
    return hip_mse + knee_mse

    # ## mse between start and end of simulation
    # weights = [0.0, 0.0, 1.0, 0.1, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.25, 0.7, 0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0] # weights vector
    # return ((sol2.u[end] .- u₀).^2) .* weights |> mean
end
cost(sol1, err::Int) = cost(sol1) + 100

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

    # manually seperate out
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
