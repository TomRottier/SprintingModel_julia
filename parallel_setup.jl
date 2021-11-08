# packages and code loaded on all processes
using DelimitedFiles
using StaticArrays, Parameters, Dierckx, SimulatedAnnealing, Setfield
using OrdinaryDiffEq, Plots

include("musclemodel/torque_generator.jl")
include("model/parameters.jl")
include("model/eom.jl")
include("model/functions.jl")
include("model/plotting.jl")
include("model/functions_ext.jl")
include("setup.jl")
include("callbacks.jl")
include("optimisation.jl")

# set up initial model
p, u₀ = setup(initial_conditions="optimisations/sprinter/initial_conditions.csv")

# time span
tspan = (0.0, 0.111)

# matching variables
VCMX = 10.1
TSW = 0.374

# initialise problem
prob = ODEProblem(eom, u₀, tspan, p)
