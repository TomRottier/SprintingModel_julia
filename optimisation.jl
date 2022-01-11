# functions for optimisations

# update and run simulation with new parameters
function simulate(x, p, prob, u₀)
    # new parameter struct with updated parameters from x and reset torque generators
    pnew, unew = updateParameters(p, x, u₀)

    # remake problem with updated parameters
    newprob = remake(prob, u0 = unew, p = pnew)

    # solve
    sol = solve(newprob, Tsit5(), callback = vcb, abstol = 1e-5, reltol = 1e-5, saveat = 0.001, verbose = false)

    # cost 
    return cost(sol)
end

# cost function
cost(sol) = 10(abs(VCMX - step_velocity(sol))) + abs(TSW - swing_time(sol))

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
    he_α_p = ActivationProfile(x[1:7])
    ke_α_p = ActivationProfile(x[8:14])
    ae_α_p = ActivationProfile(x[15:21])
    hf_α_p = ActivationProfile(x[22:28])
    kf_α_p = ActivationProfile(x[29:35])
    af_α_p = ActivationProfile(x[36:42])

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

