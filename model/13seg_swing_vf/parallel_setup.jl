using DelimitedFiles, Statistics
using StaticArrays, Parameters, Setfield
using OrdinaryDiffEq, Plots
using SimulatedAnnealing

include("eom.jl")
include("parameters.jl")
include("specifieds.jl")
include("functions.jl")
include("contact_force.jl")
include("setup.jl")
include("callbacks.jl")
include("optimisation.jl")

# set up model
const p, u₀, matching_data = setup()

# time span
const tspan = (0.0, 0.484)

# set up problem
const prob = ODEProblem(eom, u₀, tspan, p)
