# include("../musclemodel/torque_generator.jl")
function getTorque(sol, t)
    @inbounds θhe, θke, θae, θhf, θkf, θaf = sol(t)[15:end]
    @unpack he, ke, ae, hf, kf, af = sol.prob.p

    τhe = torque(he, θhe)
    τke = torque(ke, θke)
    τae = torque(ae, θae)
    τhf = torque(hf, θhf)
    τkf = torque(kf, θkf)
    τaf = torque(af, θaf)

    return τhe, τke, τae, τhf, τkf, τaf
end

getTorque(sol) = reduce(hcat, [[getTorque(sol, t)...] for t in sol.t])'


function get_torque_generator(sol, t)
    @inbounds q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7, θhe, θke, θae, θhf, θkf, θaf = sol(t)
    @unpack he, hf, ke, kf, ae, af = sol.prob.p

    # update torque generators
    θh = π + q7
    θk = π - q6
    θa = π + q5
    θm = q4
    ωh = u7
    ωk = -u6
    ωa = u5
    ωm = u4

    # get values from torque generators 
    d_he = get_torque_generator(he, t, 2π - θh, -ωh, θhe)
    d_ke = get_torque_generator(ke, t, 2π - θk, -ωk, θke)
    d_ae = get_torque_generator(ae, t, 2π - θa, -ωa, θae)
    d_hf = get_torque_generator(hf, t, θh, ωh, θhf)
    d_kf = get_torque_generator(kf, t, θk, ωk, θkf)
    d_af = get_torque_generator(af, t, θa, ωa, θaf)

    # CC torque relevant values
    out = map([d_he, d_hf, d_ke, d_kf, d_ae, d_af]) do d
        [d[:cc][:α], d[:cc][:τ_θ], d[:cc][:τ_ω]]
    end

    return out
end

get_torque_generator(sol) = [get_torque_generator(sol, t) for t in sol.t]

function get_forces(sol, t)
    @inbounds q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7 = sol(t)
    @unpack k1, k2, k3, k4, k5, k6, k7, k8, l2, pop1xi, pop2xi, virtual_force = sol.prob.p

    pop2y = q2 - l2 * sin(q3 - q4 - q5 - q6 - q7)

    if q2 < 0.0
        dp1x = q1 - pop1xi
        ry1 = -k3 * q2 - k4 * abs(q2) * u2
        rx1 = -ry1 * (k1 * dp1x + k2 * u1)

    else
        rx1 = 0.0
        ry1 = 0.0
    end

    if pop2y < 0.0
        pop2x = q1 - l2 * cos(q3 - q4 - q5 - q6 - q7)
        vop2x = u1 - l2 * sin(q3 - q4 - q5 - q6 - q7) * (u3 - u4 - u5 - u6 - u7)
        vop2y = u2 - l2 * cos(q3 - q4 - q5 - q6 - q7) * (u3 - u4 - u5 - u6 - u7)
        dp2x = pop2x - pop2xi
        ry2 = -k7 * pop2y - k8 * abs(pop2y) * vop2y
        rx2 = -ry2 * (k5 * dp2x + k6 * vop2x)
    else
        rx2 = 0.0
        ry2 = 0.0
    end

    vrx::Float64 = virtual_force.flag ? virtual_force.vrx(t) : 0.0
    vry::Float64 = virtual_force.flag ? virtual_force.vry(t) : 0.0

    return rx1 + rx2 + vrx, ry1 + ry2 + vry
end


get_forces(sol) = [get_forces(sol, t) for t in sol.t]
rx(sol) = [first(x) for x in get_forces(sol)]
ry(sol) = [last(x) for x in get_forces(sol)]


## for stance simulation
# contact_time(sol) = sol.t[end]
# function aerial_time(sol)
#     @unpack g = sol.prob.p
#     tc = contact_time(sol)
#     vcmyto = vocmy(sol, tc)
#     discrim = vcmyto^2 + 4.0g * (pocmy(sol, 0.0) - pocmy(sol, tc))
#     discrim ≥ 0.0 ? ta = (-vcmyto - sqrt(discrim)) / g : ta = 100_000.0

#     return ta
# end

# # swing time
# swing_time(sol) = contact_time(sol) + 2aerial_time(sol)

# # step averaged velocity
# function step_velocity(sol)
#     tc = contact_time(sol)
#     ta = aerial_time(sol)
#     lc = pocmx(sol, tc) - pocmx(sol, 0.0)   # contact length
#     vcmyto = vocmy(sol, tc)
#     la = vocmx(sol, tc) * ta    # aerial length

#     return (lc + la) / (ta + tc) # step averaged velocity
# end

## for stride simulation
contact_idx(sv) = findfirst(x -> x ≥ 0.0, @view sv[2:end, 2])
aerial_idx(sv) = findfirst(x -> x ≥ 0.0, @view sv[:, 4]) - contact_idx(sv)
swing_time(sol, sv) = sol.t[contact_idx(sv)] + 2 * sol.t[aerial_idx(sv)]
stride_velocity(sol) = mean(vocmx(sol))