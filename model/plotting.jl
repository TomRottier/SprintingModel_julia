## functions for plotting 

# plot model at time t
function plot_model(sol, t)
    fns = [pop1x, pop1y, pop2x, pop2y, pop3x, pop3y, pop4x, pop4y, pop5x, pop5y, pop6x, pop6y, pop7x, pop7y, pop8x, pop8y, pop9x, pop9y, pop10x, pop10y, pop11x, pop11y, pop12x, pop12y]
    ps = [fn(sol, t) for fn in fns]

    plot(legend=:none, grid=:off, xlims=(-1.0, 5.0), ylims=(-0.1, 5.9), axis=nothing, border=:none)
    plot!(ps[1:2:22], ps[2:2:22], lw=2, color=:black)       # main skeleton
    plot!(ps[[11, 23]], ps[[12, 24]], lw=2, color=:black)     # HAT
    plot!(ps[[3, 7]], ps[[4, 8]], lw=2, color=:black)         # connect foot
    plot!(ps[[19, 15]], ps[[20, 16]], lw=2, color=:black)         # connect foot

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

# plot torque generator activation and components
function _plotTorques(t, v)

    n = 6
    plts = Vector{Any}(undef, n)
    titles = ["he", "hf", "ke", "kf", "ae", "af"]
    labels = ["α" "τ_θ" "τ_ω" "τ"]
    for i = 1:n
        data = hcat([tup[i] for tup in v]...)'
        plts[i] = plot(t, data, label=labels, title=titles[i], legend=:outertopright, xaxis="time (s)")
    end

    plot(size=(600, 600), plts..., layout=(3, 2), ylims=(-0.1, 3.0))

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
    data = [matching_data[:lhat] matching_data[:lhip] matching_data[:lknee] matching_data[:lankle]]

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
    θhip = π .+ view(full, 7, :) .|> rad2deg
    θknee = π .- view(full, 6, :) .|> rad2deg
    θankle = π .+ view(full, 5, :) .|> rad2deg

    # actual data
    time = matching_data[:time]
    data = [matching_data[:lhat] matching_data[:lhip] matching_data[:lknee] matching_data[:lankle]]

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