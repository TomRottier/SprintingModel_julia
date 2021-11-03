# functions for optimisations

# update and run simulation with new parameters
function simulate(x, p, prob)
    # new parameter struct with updated parameters from x and reset torque generators
    pnew = updateParameters(p, x, prob.u0)

    # remake problem with updated parameters
    newprob = remake(prob, p=pnew) # z values not being reset? - z values dont need to be reset

    # solve
    sol = solve(newprob, Tsit5(), abstol=1e-5, reltol=1e-5, save_everystep=false, callback=cb)

    # cost 
    return cost(sol)
end

# cost function
function cost(sol)
    tc = sol.t[end]     # contact time
    lc = pocmx(sol, tc) - pocmx(sol, 0.0)   # contact length
    vcmyto = vocmy(sol, tc)
    discrim = vcmyto^2 + 4 * p.g * (pocmy(sol, 0.0) - pocmy(sol, tc))
    discrim ≥ 0.0 ? ta = (-vcmyto - sqrt(discrim)) / p.g : return 1000.0 # aerial time, return if none
    la = vocmx(sol, tc) * ta    # aerial length
    tsw = tc + 2ta
    vcmx = (lc + la) / (ta + tc) # step averaged velocity

    return 10(abs(VCMX - vcmx)) + abs(TSW - tsw)
end    


# converts input vector to parameters to be optimised and resets torque generators ot inital values
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

    # returns new Params struct with torque generators ready for next simulation
    return setproperties(p, (he = _he, ke = _ke, ae = _ae, hf = _hf, kf = _kf, af = _af))
end



### old 
# # create new Params struct with torque generators reset to initial values
# function resetTorqueGenerators(p, u₀)
#     @unpack he, ke, ae, hf, kf, af = p
#     @inbounds q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7 = u₀

#     θh = π + q7
#     θk = π - q6
#     θa = π + q5

#     ωh = u7
#     ωk = -u6
#     ωa = u5

#     _he = TorqueGenerator(2π - θh, -ωh, he.cc.cc_p, he.sec.sec_p, he.cc.α_p)
#     _ke = TorqueGenerator(2π - θk, -ωk, ke.cc.cc_p, ke.sec.sec_p, ke.cc.α_p)
#     _ae = TorqueGenerator(2π - θa, -ωa, ae.cc.cc_p, ae.sec.sec_p, ae.cc.α_p)
#     _hf = TorqueGenerator(θh, ωh, hf.cc.cc_p, hf.sec.sec_p, hf.cc.α_p)
#     _kf = TorqueGenerator(θk, ωk, kf.cc.cc_p, kf.sec.sec_p, kf.cc.α_p)
#     _af = TorqueGenerator(θa, ωa, af.cc.cc_p, af.sec.sec_p, af.cc.α_p)

#     return setproperties(p, (he = _he, ke = _ke, ae = _ae, hf = _hf, kf = _kf, af = _af))
# end

# # update activations in parameter struct
# function updateActivations!(p, x::Vector{Float64})
#     @unpack he, hf, ke, kf, ae, af = p

#     n = length(x) ÷ 6 # number of activation parameters per torque generator
#     αs = [x[i:i + n - 1] for i in 1:n:length(x)] # vector of vectors of activation parameters

#     # update torque generators CC with activation parameters from αs
#     return [tqgen.cc.α_p = ActivationProfile(α...) for (tqgen, α) in zip([he,ke,ae,hf,kf,af], αs)]
# end