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
    tnew = (sol1.t[end], 0.5) # TODO: make the end of integration time a global variable?
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

    # sol.retcode ∉ [:Success, :Terminated] && return 1.0e6

    # orientation and configuration angles
    N = length(sol.t)
    hat_mse = mse(hang(sol), view(matching_data[:lhat], 1:N))
    hip_mse = mse(view(sol, 3, :), view(matching_data[:lhip], 1:N))
    knee_mse = mse(hang(sol), view(matching_data[:lknee], 1:N))
    ankle_mse = mse(hang(sol), view(matching_data[:lankle], 1:N))

    angles_cost = #=hat_mse + =#hip_mse + knee_mse + ankle_mse

    # stride parameters
    # speed_cost = stride_velocity(sol)
    time_cost = 1000 * abs(sol.t[end] - 0.484)

    return angles_cost #+ time_cost
end

function cost(sol1, sol2)::Float64
    global matching_data

    # combine solutions into array
    full = [Array(sol1)[:, 1:end-1] Array(sol2)]
    Nsol = size(full, 2) # length of solution
    Ndat = length(matching_data[:lhip]) # length of matching data
    Ndat > Nsol ? N = Nsol : N = Ndat # use shortest length

    θhat = view(full, 3, 1:N)
    θhip = π .+ view(full, 7, 1:N)
    θknee = π .- view(full, 6, 1:N)
    θankle = π .+ view(full, 5, 1:N)

    hat_mse = mse(θhat, view(matching_data[:lhat], 1:N))
    hip_mse = mse(θhip, view(matching_data[:lhip], 1:N))
    knee_mse = mse(θknee, view(matching_data[:lknee], 1:N))
    ankle_mse = mse(θankle, view(matching_data[:lankle], 1:N))

    angles_cost = #=hat_mse +=# hip_mse + knee_mse + ankle_mse

    time_cost = 1000 * abs(sol2.t[end] - 0.484) # TODO: make global const

    return angles_cost + time_cost
end
cost(sol1, err::Int) = cost(sol1) + 1e6

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
