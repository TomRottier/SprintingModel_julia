using DelimitedFiles
using StaticArrays, Parameters
using OrdinaryDiffEq, Plots

include("eom.jl")
include("parameters.jl")
include("specifieds.jl")
include("functions.jl")
include("../plotting.jl")
include("setup.jl")

# set up model
p, u₀ = setup()

# time span
tspan = (0.0, 0.485)

# set up problem
prob = ODEProblem(eom, u₀, tspan, p)

# solve
sol = solve(prob, Tsit5(), reltol=1e-6, abstol=1e-6, saveat=0.001)

