using Distributed
using Plots

addprocs(6, exeflags="--project")   # create worker processes with current project activated
@everywhere include("parallel_setup.jl")

# set up simulated annealing
T₀ = 1.0
N = 42
Ns = 12
Nt = 5


# x₀ = vcat(Vector.([p.he.cc.α_p, p.ke.cc.α_p, p.ae.cc.α_p, p.hf.cc.α_p, p.kf.cc.α_p, p.af.cc.α_p])...)
x₀ = rand(N)
f₀ = simulate(x₀, p, prob)
ub = ones(N)
lb = repeat([0.01,0.0,0.1,0.01,0.0,0.1,0.01], 6) # constrain lb of activation to 0.01
v = ub .- lb

current = State(f₀, x₀, v, T₀)
options = Options(func=x -> simulate(x, p, prob), N=N, Ns=Ns, Nt=Nt, lb=lb, ub=ub, tol=1e-4, print_status=true)
result = Result(f₀, x₀)

# run sa
@time sa!(current, result, options)

open("optimisations/matching/results.csv", "a") do io 
    writedlm(io, [VCMX result.fopt result.xopt...], ',')
end
