using DelimitedFiles
using StaticArrays, Parameters, Dierckx, Setfield
using OrdinaryDiffEq, Plots, DiffEqCallbacks

include("musclemodel/torque_generator.jl")
include("model/parameters.jl")
include("model/eom.jl")
include("model/functions.jl")
include("model/plotting.jl")
include("model/functions_ext.jl")
include("setup.jl")
include("callbacks.jl")

# set up model
inputs = load_inputs(swing = "data/sprinter_swing.csv")
p, u₀ = load_from_results(inputs, "optimisations/sprinter/results.csv", 10.1)

# time span
tspan = (0.0, 0.111)

# set up problem
prob = ODEProblem(eom, u₀, tspan, p)

# solve
sol = solve(prob, Tsit5(), reltol = 1e-5, abstol = 1e-5, saveat = 0.001, callback = cbs)

# plot solution
animate_model(sol)


function run_simulation(;
    parameters = "data/parameters.csv",
    initial_conditions = "data/initial_conditions.csv",
    torque_generator_parameters = "data/torque_generator_parameters.csv",
    activation_parameters = "data/activation_parameters.csv",
    swing = "data/matching_swing.csv",
    hat = "data/HAT.csv",
    speed = 0.0,
    results = "")

    # set up model
    inputs = load_inputs(parameters = parameters,
        initial_conditions = initial_conditions,
        torque_generator_parameters = torque_generator_parameters,
        activation_parameters = activation_parameters,
        swing = swing,
        hat = hat)
    if speed == 0
        p, u₀ = set_values(inputs)
    else
        p, u₀ = load_from_results(inputs, results, speed)
    end

    # time span
    tspan = (0.0, 0.111)

    # set up problem
    prob = ODEProblem(eom, u₀, tspan, p)

    # solve
    return solve(prob, Tsit5(), reltol = 1e-5, abstol = 1e-5, saveat = 0.001, callback = cb)

end
