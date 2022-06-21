using DelimitedFiles
using StaticArrays, Parameters
using OrdinaryDiffEq, Plots

include("eom.jl")
include("parameters.jl")
include("specifieds.jl")
include("functions.jl")
include("contact_force.jl")
include("setup.jl")
include("callbacks.jl")
include("../plotting.jl")

# set up model
p, u₀ = setup()

# time span
tspan = (0.0, 0.484)

# set up problem
prob = ODEProblem(eom, u₀, tspan, p)

# solve
sol = solve(prob, Tsit5(), callback=vcb, reltol=1e-8, abstol=1e-8, saveat=0.001)

# animate
animate_model(sol)