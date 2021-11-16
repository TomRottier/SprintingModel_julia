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
inputs = load_inputs(swing="data/college_swing.csv")
p, u₀ = set_values(inputs)

# time span
const tspan = (0.0, 0.111)

# initialise problem
prob = ODEProblem(eom, u₀, tspan, p)

# swing time
TSW = 0.374
