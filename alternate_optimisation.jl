using DelimitedFiles, Statistics
using StaticArrays, Parameters, Dierckx, Setfield
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

# set up model
const inputs = load_inputs()
const p, u₀ = set_values(inputs)
const matching_data = inputs.matching_data

# time span
const tspan = (0.0, 0.1)

# set up problem
const prob = ODEProblem{false}(eom, u₀, tspan, p)

# bounds and initial value
const ub = repeat([2.0, repeat([0.5, 0.5, 2.0], 3)...], 6)
const lb = repeat([0.01, repeat([0.0, 0.1, 0.01], 3)...], 6) # constrain lb of activation to 0.01
const x₀ = [rand(lb:0.001:ub) for (lb, ub) in zip(lb, ub)]


## Optim.jl
using Optim
res = Optim.optimize(objective, lb, ub, x₀, SAMIN(f_tol = 1.0, verbosity = 2), Optim.Options(iterations = 10^6))

## Evolutionary.jl
using Evolutionary
using Distributed, SharedArrays
addprocs(6, exeflags = "--project")   # create worker processes with current project activated
@everywhere include("parallel_setup.jl")

# genetic algortihm options
ga = GA(
    populationSize=200,
    selection=uniformranking(3),
    mutation=gaussian(),
    crossover=uniformbin(),
    metrics=ConvergenceMetric[Evolutionary.AbsDiff{Float64}(0.1)]
)

# optimisation options
opt_cb(record) = begin display(plot!(plt, [record.iteration], [record.value], st=:scatter, mc=:black)); return false; end
opts = Evolutionary.Options(
    parallelization = :distributed, # :thread for multi-threaded but errors with model
    #time_limit = 3600.0, # 1 hour
    iterations = 150,
    show_trace = false,
    callback = opt_cb
)

# multi process function - needs to take the obj and calculate the fitness in F for each member in population in xs
function Evolutionary.value!(obj::EvolutionaryObjective{TC,TF,TX,Val{:distributed}},
                    F::AbstractVector, xs::AbstractVector{TX}) where {TC,TF<:Real,TX}
    n = length(xs)
    F_shared = SharedArray{Float64}(copy(F))
    @sync @distributed for i in 1:n
        F_shared[i] = value(obj, xs[i])
    end
    F .= copy(F_shared)
end

# optimise
const plt = plot(title="optimisation", yaxis="cost", xaxis="iteration", legend=false)
results = Evolutionary.optimize(objective, BoxConstraints(lb, ub), x₀, ga, opts)



# plot result
xopt = Evolutionary.minimizer(results)
sol1, sol2 = simulate(xopt, prob)
animate_model(sol1, sol2)

# fortran best
sol1_f, sol2_f = simulate(prob)
cost(sol1_f, sol2_f)
animate_model(sol1_f, sol2_f)


# test
@everywhere f(x)=(x[1]+2x[2]-7)^2+(2x[1]+x[2]-5)^2
ga = GA(populationSize=600,selection=uniformranking(3),
        mutation=gaussian(),crossover=uniformbin(), metrics=ConvergenceMetric[Evolutionary.AbsDiff{Float64}(1e-10)])
opts = Evolutionary.Options(parallelization=:distributed)
x0 = [0., 0.]
results = Evolutionary.optimize(f, x0, ga, opts)
