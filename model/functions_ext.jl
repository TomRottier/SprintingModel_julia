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

function plotTorques(t, v)

    n = 6
    plts = Vector{Any}(undef, n)
    titles = ["he", "hf", "ke", "kf", "ae", "af"]
    labels = ["α" "τ_θ" "τ_ω"]
    for i in 1:n
        data = hcat([tup[i] for tup in v]...)'
        plts[i] = plot(t, data, label=labels, title=titles[i], legend=:outertopright, xaxis="time (s)")
    end

    plot(size=(600, 600), plts..., layout=(3, 2), ylims=(-.1, 1.7), yticks=0:0.3:1.5)
    
end

plotTorques(sol) = plotTorques(sol.t, get_torque_generator(sol))
