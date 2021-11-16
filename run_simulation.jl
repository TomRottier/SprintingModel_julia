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
tspan = (0.0, 0.111)

# set up problem
prob = ODEProblem(eom, u₀, tspan, p)

# solve
sol = solve(prob, Tsit5(), reltol=1e-6, abstol=1e-6, saveat=0.001, callback=cb)

# plot solution
animate_model(sol)


function run_simulation(; 
    parameters="data/parameters.csv", 
    initial_conditions="data/initial_conditions.csv",
    torque_generator_parameters="data/torque_generator_parameters.csv",
    activation_parameters="data/activation_parameters.csv",
    swing="data/matching_swing.csv",
    hat="data/HAT.csv")

    # set up model
    p, u₀ = setup(parameters=parameters, 
        initial_conditions=initial_conditions,
        torque_generator_parameters=torque_generator_parameters,
        activation_parameters=activation_parameters,
        swing=swing,
        hat=hat)

    # time span
    tspan = (0.0, 0.111)

    # set up problem
    prob = ODEProblem(eom, u₀, tspan, p)

    # solve
    sol = solve(prob, Tsit5(), reltol=1e-6, abstol=1e-6, saveat=0.001, callback=cb)

end
