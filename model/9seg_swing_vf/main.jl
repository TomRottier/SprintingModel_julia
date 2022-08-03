using DelimitedFiles
using StaticArrays, Parameters, Dierckx
using OrdinaryDiffEq, Plots

include("musclemodel/torque_generator.jl")
include("model/parameters.jl")
include("model/eom.jl")
include("model/functions.jl")
include("model/plotting.jl")
include("model/functions_ext.jl")
include("setup.jl")
include("callbacks.jl")

# set up model
p, u₀ = setup(activation_parameters="data/stance_evaluation_opt_activation.csv")

# time span
tspan = (0.0, 0.485)

# set up problem
prob = ODEProblem(eom, u₀, tspan, p)

# solve
sol = solve(prob, Tsit5(), reltol=1e-6, abstol=1e-6, saveat=0.001, callback=cb)

