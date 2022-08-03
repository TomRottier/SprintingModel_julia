## test objective function works in parallel (distributed and multithreaded)
# using Distributed, SharedArrays
# addprocs(4, exeflags = "--project")   
# @everywhere include("parallel_setup.jl")

# vector of random parameters 
xs = [rand(60) for _ in 1:100]

# dictionaries to hold results
res_ser = Dict{Int, Float64}()
res_thr = copy(res_ser)
res_dis = copy(res_ser)


# serial
[res_ser[i] = objective(x) for (i,x) in enumerate(xs)]

# multi-threaded - NOT WORKING
Threads.@threads for (i,x) in collect(enumerate(xs))
    res_thr[i] = objective(x)
end

# distributed - WORKING
@everywhere begin 
    call_fun(dic, xs) = [dic[i] = objective(x) for (i, x) in enumerate(xs)]
    xs = $(copy(xs))
    res_dis = $(copy(res_dis))
    call_fun(res_dis, xs)
end

# alternative distributed - WORKING
res_dis2 = SharedArray{Float64}(100)
@sync @distributed for (i,x) in collect(enumerate(xs))
    res_dis2[i] = objective(x)
end

@show res_ser[2];
@show res_thr[2];
@everywhere @show res_dis[2]
@show res_dis2[2];


## test if better to run two simulations or one big one
function lorenz(u,p,t)
    σ, β, ρ = p
    x,y,z = u

    dx = σ * (y - x)
    dy = x * (ρ  - z) - y
    dz = x * y - β * z

    return SA[dx,dy,dz]
end

p = (10, 8/3, 28)
u₀ = SA[0.0, 1.0, 10.0]
tspan = (0,100)
prob = ODEProblem(lorenz, u₀, tspan, p)

simulate1(prob) = solve(prob, Tsit5(), callback=cb2, abstol=1e-7, reltol=1e-7)

function simulate2(prob)
    sol1 = solve(prob, Tsit5(), callback=cb1, abstol=1e-7, reltol=1e-7)

    u0new = sol1.u[end]
    tnew = (sol1.t[end], 100)

    newprob = remake(prob, u0=u0new, tspan=tnew)
    sol2 = solve(newprob, Tsit5(), callback = cb2, abstol=1e-7, reltol=1e-7)

    return sol1, sol2
end

condition1(u,t,integrator) = u[1]
affect1!(integrator) = terminate!(integrator)
cb1 = ContinuousCallback(condition1, affect1!, save_positions=(false,true))

condition2(u,t,integrator) = u[3] > 45.0
affect2!(int) = terminate!(int)
cb2 = DiscreteCallback(condition2, affect2!, save_positions=(false,true))

## not giving same answer
