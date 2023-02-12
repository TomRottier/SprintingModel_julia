using DelimitedFiles, Statistics
using StaticArrays, Parameters, Setfield, SimulatedAnnealing
using OrdinaryDiffEq, Plots

include("../../musclemodel/torque_generator.jl")
include("eom.jl")
include("parameters.jl")
include("specifieds.jl")
include("functions.jl")
include("contact_force.jl")
include("setup.jl")
include("callbacks.jl")
include("optimisation.jl")
include("plotting.jl")

# set up model
p, u₀, matching_data = setup()

# time span
tspan = (0.0, 0.124)

# set up problem
prob = ODEProblem(eom, u₀, tspan, p)

# solve
sol = solve(prob, Tsit5(), callback=vcb, reltol=1e-6, abstol=1e-6, saveat=0.001)
# sol = simulate(prob)

# animate
animate_model(sol)



## run optimisation
using Distributed
addprocs(10, exeflags="--project")   # create worker processes with current project activated
@everywhere include("parallel_setup.jl")

# simulated annealing parameters
T₀ = 0.05
N = 128
Ns = 20
Nt = 5
tol = 1e-1

# bounds and step length
ub = repeat([1.0, repeat([0.5, 0.5, 1.0], 2)...], 12)
lb = repeat([0.01, repeat([0.0, 0.1, 0.01], 2)...], 12) # constrain lb of activation to 0.01
append!(ub, [20_000, 2000, 200_000, 100_000, 20_000, 1000, 200_000, 100_000])
append!(lb, zeros(8))
v = ub .- lb

# initial guess
randx(lb, ub) = [rand(lb:0.001:ub) for (lb, ub) in zip(lb, ub)]
x₀ = [rand(lb:0.001:ub) for (lb, ub) in zip(lb, ub)]
f₀ = objective(x₀)

# initial structs
current = State(f=f₀, x=x₀, v=v, T=T₀)
result = Result(fopt=f₀, xopt=x₀)
options = Options(func=objective, N=N, Ns=Ns, Nt=Nt, lb=lb, ub=ub, tol=tol, print_status=true)
@time sa!(current, result, options)

open("model\\13seg_tq\\results.csv", "a") do io
    writedlm(io, [result.fopt result.xopt...], ',')
end

xfail = [10439.361, 1233.33, 60349.687, 98505.517, 12915.36, 723.547, 136851.274, 9057.667]



## optimization.jl
using Optimization, OptimizationEvolutionary, OptimizationMultistartOptimization, OptimizationOptimJL, ForwardDiff


ub = repeat([5.0, repeat([0.5, 0.5, 5.0], 2)...], 12)
lb = repeat([0.01, repeat([0.0, 0.1, 0.01], 2)...], 12) # constrain lb of activation to 0.01
append!(ub, [20_000, 2000, 200_000, 100_000, 20_000, 1000, 200_000, 100_000])
append!(lb, zeros(8))

randx(lb, ub) = [rand(lb:0.001:ub) for (lb, ub) in zip(lb, ub)]
x₀ = [rand(lb:0.001:ub) for (lb, ub) in zip(lb, ub)]


function run_opt(prob)
    plt1 = plot(legend=false, xaxis="iterations", yaxis="cost",)# ylims=(0, 1000))
    iterations = 0
    Js = []

    callback = function (x, J)
        # @show J

        # plot cost function change over optimization
        push!(Js, J)
        Plots.scatter!(plt1, [iterations], [J], mc=:black, title="iterations = $iterations, cost = $(round(J, digits=5))")
        display(plt1)

        # update count
        iterations += 1

        return false
    end


    sol = solve(prob, OptimizationOptimJL.SAMIN(), callback=callback, f_tol=0.1, maxiters=1e7)
    # sol = solve(prob, TikTak(100), LBFGS(), callback=callback, abstol=0.1)


    return sol
end

objective(x, p) = objective(x)
f = OptimizationFunction(objective, Optimization.AutoForwardDiff())
opt_prob = OptimizationProblem(f, x₀, lb=lb, ub=ub)
opt_sol = run_opt(opt_prob)

open("model\\13seg_tq\\results.csv", "a") do io
    writedlm(io, [opt_sol.minimum opt_sol.u...], ',')
end


## using Evolutionary.jl
using Evolutionary
ub = repeat([1.0, repeat([0.5, 0.5, 1.0], 2)...], 12)
lb = repeat([0.01, repeat([0.0, 0.1, 0.01], 2)...], 12) # constrain lb of activation to 0.01
append!(ub, [20_000, 2000, 200_000, 100_000, 20_000, 1000, 200_000, 100_000])
append!(lb, zeros(8))

randx(lb, ub) = [rand(lb:0.001:ub) for (lb, ub) in zip(lb, ub)]
x₀ = [rand(lb:0.001:ub) for (lb, ub) in zip(lb, ub)]

res = Evolutionary.optimize(objective, BoxConstraints(lb, ub), x₀, GA(), Evolutionary.Options(abstol=1.0, parallelization=:thread))






## test problem
rosenbrock(x, p) = (p[1] - x[1])^2 + p[2] * (x[2] - x[1]^2)^2
x0 = zeros(2)
_p = [1.0, 100.0]

vals = []
callback = function (x, val)
    push!(vals, val)
    false
end

_prob = OptimizationProblem(rosenbrock, x0, _p)
_sol = solve(_prob, OptimizationOptimJL.SimulatedAnnealing(), callback=callback)
