function plot_model(sol, t)
    fns = [pop1x,pop1y,pop2x,pop2y,pop3x,pop3y,pop4x,pop4y,pop5x,pop5y,pop6x,pop6y,pop7x,pop7y,pop8x,pop8y,pop9x,pop9y]
    ps = [fn(sol, t) for fn in fns]

    plot(legend=:none, grid=:off, xlims=(-.8, 5.0), ylims=(-.1, 5.7), axis=nothing, border=:none)
    plot!(ps[1:2:16], ps[2:2:16], lw=2, color=:black)       # main skeleton
    plot!(ps[[11,17]], ps[[12,18]], lw=2, color=:black)     # HAT
    plot!(ps[[3,7]], ps[[4,8]], lw=2, color=:black)         # connect foot

end

function animate_model(sol; fps=60)
    anim = @animate for t in sol.t
        plot_model(sol, t)
    end

    gif(anim, "model.gif", fps=fps)
end