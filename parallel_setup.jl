# packages and code loaded on all processes
using DelimitedFiles, Statistics
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
const inputs = load_inputs()
const p, u₀ = set_values(inputs)
const matching_data = inputs.matching_data

# time span
tspan = (0.0, 0.125) # only for first step, making shorter stops unecessarily long simulations, original .484

# initialise problem
prob = ODEProblem(eom, u₀, tspan, p)

# swing time
TSW = 0.374
