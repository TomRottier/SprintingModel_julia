## functions for plotting 

# plot model at time t
function plot_model(sol, t)
    legs_fns = [pop1x, pop1y, pop2x, pop2y, pop3x, pop3y, pop4x, pop4y, pop5x, pop5y, pop6x, pop6y, pop7x, pop7y, pop8x, pop8y, pop9x, pop9y, pop10x, pop10y, pop11x, pop11y]
    arms_fns = [pop16x, pop16y, pop15x, pop15y, pop12x, pop12y, pop13x, pop13y, pop14x, pop14y]
    torso_fns = [pop6x, pop6y, pop12x, pop12y]
    legs = [fn(sol, t) for fn in legs_fns]
    arms = [fn(sol, t) for fn in arms_fns]
    torso = [fn(sol, t) for fn in torso_fns]


    plot(legend=:none, xlims=(-1.0, 5.0), ylims=(-0.1, 5.9),)#grid=:off, axis=nothing, border=:none)
    plot!(legs[1:2:end], legs[2:2:end], lw=2, color=:black)       # legs
    plot!(arms[1:2:end], arms[2:2:end], lw=2, color=:black)   # arms
    plot!(torso[1:2:end], torso[2:2:end], lw=2, color=:black)   # torso
    plot!(legs[[3, 7]], legs[[4, 8]], lw=2, color=:black)         # connect foot
    plot!(legs[[19, 15]], legs[[20, 16]], lw=2, color=:black)         # connect foot

end

# create animation of model
function animate_model(sol; fps=60)
    anim = @animate for t in sol.t
        plot_model(sol, t)
    end

    gif(anim, "model.gif", fps=fps)
end

# animate for whole stride
function animate_model(sol1, sol2; fps=60)
    anim = @animate for t in [sol1.t[1:end-1]..., sol2.t...]
        t ≤ sol1.t[end] ? plot_model(sol1, t) : plot_model(sol2, t)
    end

    gif(anim, "model.gif", fps=fps)

end
animate_model(sol1, sol2::Int; fps=60) = animate_model(sol1; fps)

# plot torque generator activation and components
function _plotTorques(t, v)
    plts = []

    # variables to get
    vars = [:α, :τ_θ, :τ_ω, :τ]
    titles = ["he", "hf", "ke", "kf", "ae", "af"]

    # get data
    for i in 1:6
        plt = plot(title=titles[i], legend=:outertopright, xaxis="time (s)")
        for var in vars
            data = map(d -> d[i][:cc][var], v)
            plot!(plt, t, data, label=String(var))
        end

        push!(plts, plt)
    end

    plot(size=(600, 600), plts..., layout=(3, 2),)#ylims=(-0.1, 3.0))

end
plotTorques(sol) = _plotTorques(sol.t, get_torque_generator(sol))

plotTorques(sol1, sol2) = _plotTorques(vcat(sol1.t, sol2.t), vcat(get_torque_generator(sol1), get_torque_generator(sol2)))


# compare joint angle plot
function plot_jointangles(sol)
    global matching_data

    # simulated data
    θhat = sol[3, :] .|> rad2deg
    θhip = hang(sol) .|> rad2deg
    θknee = kang(sol) .|> rad2deg
    θankle = aang(sol) .|> rad2deg

    # actual data
    time = matching_data[:time]
    data = [matching_data[:ht] matching_data[:lhip] matching_data[:lknee] matching_data[:lankle]]

    # plot
    plt = plot(time, data, ls=:solid, labels=["hat" "hip" "knee" "ankle"])
    plot!(sol.t, [θhat θhip θknee θankle], ls=:dash, lc=[1 2 3 4], label="")
    title!("cost: $( round(cost(sol), digits=1) )")
    return plt
end

function plot_jointangles(sol1, sol2)
    global matching_data

    # combine solutions into array
    full = [Array(sol1)[:, 1:end-1] Array(sol2)]
    Nsol = size(full, 2) # length of solution
    # Ndat = length(matching_data[:lhip]) # length of matching data
    # Ndat > Nsol ? N = Nsol : N = Ndat # use shortest length

    # simulation data
    sim_time = range(0, step=0.001, length=Nsol)
    θhat = view(full, 3, :) .|> rad2deg
    θhip = view(full, 4, :) .|> rad2deg
    θknee = view(full, 5, :) .|> rad2deg
    θankle = view(full, 6, :) .|> rad2deg

    # actual data
    time = matching_data[:time]
    data = [matching_data[:ht] matching_data[:lhip] matching_data[:lknee] matching_data[:lankle]]

    # plot
    plt = plot(time, data, ls=:solid, labels=["hat" "hip" "knee" "ankle"])
    plot!(sim_time, [θhat θhip θknee θankle], ls=:dash, lc=[1 2 3 4], label="")
    title!("cost: $( round(cost(sol1, sol2), digits=1) )")
    return plt
end

function plot_force(sol1, sol2)
    plt = plot(sol1.t, RY(sol1), label="ry")
    plot!(sol2.t, ry(sol2), color=1, label="")
    plot!(sol2.t, vry(sol2), label="vry")

    return plt
end

function plot_2sol(f, sol1, sol2)
    plt = plot(sol1.t, f(sol1), label="step 1")
    _time = [sol1.t[end], sol2.t...]
    _data = [f(sol2, t) for t in _time]
    plot!(_time, _data, label="step 2")

    return plt
end