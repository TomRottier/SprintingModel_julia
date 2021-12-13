# functions for optimisations

# update and run simulation with new parameters
function simulate(x, p, prob, u₀)
    # new parameter struct with updated parameters from x and reset torque generators
    pnew, unew = updateParameters(p, x, u₀)
    pnew.virtual[3] = false

    # remake problem with updated parameters
    newprob = remake(prob, u0 = unew, p = pnew)

    # TODO: means saved_values no longer accessible to outside this function e.g in affect_neg!
    # reset values in saving callback
    global saved_values
    saved_values = SavedValues(Float64, Tuple{Float64,Float64,Float64,Float64})
    scb = SavingCallback(save_func, saved_values)
    cbs = CallbackSet(cb, scb)

    # solve
    sol = solve(newprob, Tsit5(), abstol = 1e-5, reltol = 1e-5, saveat = 0.001, callback = cbs, dense=false)

    # cost 
    return cost(sol)
    # return sol
end

# cost function
# cost(sol) = 10(abs(VCMX - step_velocity(sol))) + abs(TSW - swing_time(sol))
function cost(sol)
    global matching_data

    # sol.retcode ∉ [:Success, :Terminated] && return 1.0e6

    # orientation and configuration angles
    N = length(sol.t)
    hat_mse = mse(hang(sol), view(matching_data[:lhat], 1:N))
    hip_mse = mse(view(sol, 3, :), view(matching_data[:lhip], 1:N))
    knee_mse = mse(hang(sol), view(matching_data[:lknee], 1:N))
    ankle_mse = mse(hang(sol), view(matching_data[:lankle], 1:N))

    angles_cost = hat_mse + hip_mse + knee_mse #+ ankle_mse

    # stride parameters
    # speed_cost = stride_velocity(sol)
    time_cost = 1000* abs(sol.t[end] - 0.484)

    return angles_cost #+ time_cost


end
mse(x, y) = (x .- y) .^ 2 |> mean

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


# compare joint angle plot
function plot_jointangles(sol)
    global matching_data

    # simulated data
    θhat = sol[3,:] .|> rad2deg
    θhip = hang(sol) .|> rad2deg
    θknee = kang(sol) .|> rad2deg
    θankle = aang(sol) .|> rad2deg

    # actual data
    time = matching_data[:time]
    data = [matching_data[:lhat] matching_data[:lhip] matching_data[:lknee] matching_data[:lankle]]

    # plot
    plt = plot(time, data, ls=:solid, labels=["hat" "hip" "knee" "ankle"])
    plot!(sol.t, [θhat θhip θknee θankle], ls=:dash, lc=[1 2 3 4], label="")
    title!("cost: $( round(cost(sol), digits=1) )")    
    return plt
end