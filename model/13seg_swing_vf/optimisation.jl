## functions used to optimise model
const INTEGRATOR = Tsit5()
const INT_OPTIONS = (saveat=0.001, abstol=1e-8, reltol=1e-8, verbose=false, maxiters=2e4)

# to get progress bar
#=using Logging: global_logger
using TerminalLoggers: TerminalLogger
global_logger(TerminalLogger())

then add progress=true and progress_steps=x to solve call

=#

# objective
objective(x) = #cost(simulate(prob, x)...)
    try
        cost(simulate(prob, x)...)
    catch
        return 1e7
    end

# simulate with new parameters
function simulate(prob::ODEProblem, x)
    # new parameter struct with updated parameters from x
    pnew, unew = update_parameters(prob.p, x, prob.u0)

    # new ODEProblem
    newprob = remake(prob, u0=unew, p=pnew)

    # solve new problem
    return simulate(newprob)
end

# simulate a stride from an ODEProblem
function simulate(prob1::ODEProblem)
    # simulate step 1
    sol1 = solve(deepcopy(prob1), INTEGRATOR; callback=cb1, INT_OPTIONS...)

    # check if need to simulate second step - NOT TYPE STABLE
    # unusual termination
    sol1.retcode ≠ :Terminated && return sol1, -1
    # stop first contact ending early
    sol1.t[end] < 0.1 && return sol1, -2
    # second step can't be too negative
    # vocmy(sol1, sol1.t[end]) ≤ -1.0 && return sol1, -3

    # fit splines to grf
    splx1, sply1, splx2, sply2 = grf_spl(sol1)

    # update parameters, initial conditions and time span
    pnew = setproperties(prob1.p, (vrx1=splx1, vry1=sply1, vrx2=splx2, vry2=sply2))
    unew = sol1.u[end]
    tnew = (sol1.t[end], prob1.tspan[end])

    # create prob for step 2
    prob2 = remake(prob1, u0=unew, p=pnew, tspan=tnew)

    # simulate step 2
    sol2 = solve(prob2, INTEGRATOR; INT_OPTIONS...)
    sol2.retcode ∉ (:Success, :Terminated) && return sol1, -4

    return sol1, sol2
end

# fit splines to grf during first step
function grf_spl(sol)
    T = sol.t[end]
    t = sol.t[1]:0.001:T
    splx1 = CubicSplineInterpolation(t .+ T, [rx1(sol, _t) for _t in t], extrapolation_bc=0.0)
    sply1 = CubicSplineInterpolation(t .+ T, [ry1(sol, _t) for _t in t], extrapolation_bc=0.0)
    splx2 = CubicSplineInterpolation(t .+ T, [rx2(sol, _t) for _t in t], extrapolation_bc=0.0)
    sply2 = CubicSplineInterpolation(t .+ T, [ry2(sol, _t) for _t in t], extrapolation_bc=0.0)

    return splx1, sply1, splx2, sply2
end

# mean squared error between two vectors
mse(x, y) = (x .- y) .^ 2 |> mean

# cost function for simulation
function cost(sim_data)
    # global matching_data

    # calculate hip and knee angles
    θhat = view(sim_data, 3, :) .|> rad2deg
    θhip = view(sim_data, 4, :) .|> rad2deg
    θknee = view(sim_data, 5, :) .|> rad2deg
    θankle = view(sim_data, 6, :) .|> rad2deg

    # calculate mse
    hip_mse = mse(θhip, matching_data[:lhip])
    knee_mse = mse(θknee, matching_data[:lknee])
    hat_mse = mse(θhat, matching_data[:ht])
    ankle_mse = mse(θankle, matching_data[:lankle])

    # scale by range
    sf_hip = view(matching_data[:lhip], :) |> extrema |> collect |> diff
    sf_knee = view(matching_data[:lknee], :) |> extrema |> collect |> diff
    sf_hat = view(matching_data[:ht], :) |> extrema |> collect |> diff
    hip_mse /= sf_hip[1]
    knee_mse /= sf_knee[1]
    hat_mse /= sf_hat[1]

    return hip_mse + knee_mse + hat_mse + 0.1ankle_mse
end

cost(sol1, sol2) = cost([Array(sol1(0:0.001:sol1.t[end-1])) Array(sol2(sol1.t[end-1]+0.001:0.001:sol2.t[end]))])
cost(sol1, err::Int) = 1e7 - err
cost(err1::Int, err2::Int) = 1e7 - 10err1 - err2

# update parameters from vector
function update_parameters(p, x, u₀)
    @unpack he, ke, ae, hf, kf, af = p
    @inbounds q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7 = u₀

    θh = q7
    θk = q6
    θa = q5

    ωh = u7
    ωk = u6
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
    _k1, _k2, _k3, _k4, _k5, _k6, _k7, _k8 = x[61:68]

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
    _p = setproperties(p, (he=_he, ke=_ke, ae=_ae, hf=_hf, kf=_kf, af=_af, k1=_k1, k2=_k2, k3=_k3, k4=_k4, k5=_k5, k6=_k6, k7=_k7, k8=_k8))

    return _p, _u₀
end