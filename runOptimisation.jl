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

# setup
p, u₀ = setup(activation_parameters="data/stance_evaluation_opt_activation.csv")
tspan = (0., 0.11)
prob = ODEProblem(eom, u₀, tspan, p)
VCMX = 9.67
TSW = 0.374

# setup simulated annealing
x₀ = rand(42)
f₀ = simulate(x₀, p, prob)
ub = ones(length(x₀))
lb = repeat([0.0,0.0,0.1,0.0,0.0,0.1,0.0], 6)
v = ub .- lb

T₀ = 5.0
N = length(x₀)
Ns = 24
Nt = 5

current = State(f₀, x₀, v, T₀)
options = Options(func=x -> simulate(x, p, prob), N=N, Ns=Ns, Nt=Nt, lb=lb, ub=ub, tol=1e-4, print_status=true)
result = Result(f₀, x₀)

# run sa
sa!(current, result, options)
