using DelimitedFiles, Statistics
using StaticArrays, Parameters, Setfield
using OrdinaryDiffEq, Plots

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
tspan = (0.0, 0.484)

# set up problem
prob = ODEProblem(eom, u₀, tspan, p)

# solve
sol = solve(prob, Tsit5(), callback=vcb, reltol=1e-6, abstol=1e-6, saveat=0.001)

# animate
animate_model(sol)



## run optimisation
# using Distributed
# addprocs(12, exeflags="--project")   # create worker processes with current project activated
# @everywhere include("parallel_setup.jl")

# # simulated annealing parameters
# T₀ = 0.5
# N = 8
# Ns = 36
# Nt = 10
# tol = 1e-3

# # bounds and step length
# ub = [20_000.0, 2000, 200_000, 100_000, 20_000, 1000, 200_000, 100_000]
# lb = zeros(8)
# v = ub .- lb

# # initial guess
# randx(lb, ub) = [rand(lb:0.001:ub) for (lb, ub) in zip(lb, ub)]
# x₀ = [rand(lb:0.001:ub) for (lb, ub) in zip(lb, ub)]
# f₀ = objective(x₀)

# # initial structs
# current = State(f=f₀, x=x₀, v=v, T=T₀)
# result = Result(fopt=f₀, xopt=x₀)
# options = Options(func=objective, N=N, Ns=Ns, Nt=Nt, lb=lb, ub=ub, tol=tol, print_status=true)
# @time sa!(current, result, options)

# open("model\\angle_driven\\results.csv", "a") do io
#     writedlm(io, [result.fopt result.xopt...], ',')
# end

# x_broken = [7812.966, 1132.816, 41799.709, 9315.251, 14642.844, 615.068, 78583.638, 87395.747]
# x_broken = [2485.413, 959.797, 191384.276, 52362.824, 12128.12, 322.839, 19558.24, 76850.179]

