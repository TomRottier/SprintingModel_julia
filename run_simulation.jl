using DelimitedFiles, Statistics
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
inputs = load_inputs()
p, u₀ = load_from_results(inputs, "optimisations/matching/results.csv", 9.6704)
const matching_data = inputs.matching_data
const com_drop = 0.9 # amount com lowers to end step 1 early and skip step 2

# time span
tspan = (0.0, 0.1)

# set up problem
prob = ODEProblem{false}(eom, u₀, tspan, p)

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
    results = "",
    tspan = (0.0, 0.484))

    # set up model
    inputs = load_inputs(parameters = parameters,
        initial_conditions = initial_conditions,
        torque_generators = torque_generator_parameters,
        activations = activation_parameters,
        swing = swing,
        hat = hat)
    if speed == 0
        p, u₀ = set_values(inputs)
    else
        p, u₀ = load_from_results(inputs, results, speed)
    end

    # intialised saved values and callbacks
    saved_values = SavedValues(Float64, Tuple{Float64,Float64,Float64,Float64})
    scb = SavingCallback(save_func, saved_values)
    cbs = CallbackSet(cb, scb)

    # set up problem
    prob = ODEProblem(eom, u₀, tspan, p)

    # solve
    return solve(prob, Tsit5(), reltol = 1e-5, abstol = 1e-5, saveat = 0.001, callback = cbs, dense = false)

end
