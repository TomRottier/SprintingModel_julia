using Distributed

addprocs(6, exeflags="--project")   # create worker processes with current project activated
@everywhere include("parallel_setup.jl")

# set up simulated annealing
T₀ = 0.5
N = 42
Ns = 12
Nt = 5


x₀ = vcat(Vector.([popt.he.cc.α_p, popt.ke.cc.α_p, popt.ae.cc.α_p, popt.hf.cc.α_p, popt.kf.cc.α_p, popt.af.cc.α_p])...)
# x₀ = rand(N)
f₀ = simulate(x₀, p, prob)

# bounds and step length
ub = ones(N)
lb = repeat([0.01,0.0,0.1,0.01,0.0,0.1,0.01], 6) # constrain lb of activation to 0.01
v = ub .- lb

# initialise
current = State(f₀, x₀, v, T₀)
options = Options(func=x -> simulate(x, p, prob), N=N, Ns=Ns, Nt=Nt, lb=lb, ub=ub, tol=1e-4, print_status=true)
result = Result(f₀, x₀)

# run sa
@time sa!(current, result, options)

open("optimisations/sprinter/results.csv", "a") do io 
    writedlm(io, [VCMX result.fopt result.xopt...], ',')
end


popt = updateParameters(p, result.xopt, u₀)
sol = solve(ODEProblem(eom, u₀, tspan, popt), Tsit5(), abstol=1e-5, reltol=1e-5, callback=cb, saveat=0.001)
swing_time(sol) |> println
step_velocity(sol) |> println
animate_model(sol)
