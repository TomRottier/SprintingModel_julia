# packages and code loaded on all processes
using DelimitedFiles, Statistics
using StaticArrays, Parameters, Dierckx, SimulatedAnnealing, Setfield, Interpolations
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
inputs = load_inputs()#=const =#
inputs.initial_conditions[:vcmx] = 9.2
p, u₀ = set_values(inputs)#=const =#
matching_data = inputs.matching_data#=const =#

# time span
tspan = (0.0, 0.317)

# initialise problem
prob = ODEProblem(eom, u₀, tspan, p)

# swing time
TSW = 0.374
