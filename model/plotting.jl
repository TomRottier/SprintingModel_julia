## functions for plotting 

# plot model at time t
function plot_model(sol, t)
    fns = [pop1x, pop1y, pop2x, pop2y, pop3x, pop3y, pop4x, pop4y, pop5x, pop5y, pop6x, pop6y, pop7x, pop7y, pop8x, pop8y, pop9x, pop9y]
    ps = [fn(sol, t) for fn in fns]

    plot(legend = :none, grid = :off, xlims = (-.8, 5.0), ylims = (-.1, 5.7), axis = nothing, border = :none)
    plot!(ps[1:2:16], ps[2:2:16], lw = 2, color = :black)       # main skeleton
    plot!(ps[[11, 17]], ps[[12, 18]], lw = 2, color = :black)     # HAT
    plot!(ps[[3, 7]], ps[[4, 8]], lw = 2, color = :black)         # connect foot

end

# create animation of model
function animate_model(sol; fps = 60)
    anim = @animate for t in sol.t
        plot_model(sol, t)
    end

    gif(anim, "model.gif", fps = fps)
end

# animate for whole stride
function animate_model(sol1, sol2; fps = 60)
    anim = @animate for t in [sol1.t[1:end-1]..., sol2.t...]
        t ≤ sol1.t[end] ? plot_model(sol1, t) : plot_model(sol2, t)
    end

    gif(anim, "model.gif", fps = fps)

end

# plot torque generator activation and components
function plotTorques(t, v)

    n = 6
    plts = Vector{Any}(undef, n)
    titles = ["he", "hf", "ke", "kf", "ae", "af"]
    labels = ["α" "τ_θ" "τ_ω"]
    for i = 1:n
        data = hcat([tup[i] for tup in v]...)'
        plts[i] = plot(t, data, label = labels, title = titles[i], legend = :outertopright, xaxis = "time (s)")
    end

    plot(size = (600, 600), plts..., layout = (3, 2), ylims = (-.1, 1.7), yticks = 0:0.3:1.5)

end
plotTorques(sol) = plotTorques(sol.t, get_torque_generator(sol))


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
    plt = plot(time, data, ls = :solid, labels = ["hat" "hip" "knee" "ankle"])
    plot!(sol.t, [θhat θhip θknee θankle], ls = :dash, lc = [1 2 3 4], label = "")
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
    plt = plot(time, data, ls = :solid, labels = ["hat" "hip" "knee" "ankle"])
    plot!(sim_time, [θhat θhip θknee θankle], ls = :dash, lc = [1 2 3 4], label = "")
    title!("cost: $( round(cost(sol1, sol2), digits=1) ) (only calculated to end of simulation time)")
    return plt
end