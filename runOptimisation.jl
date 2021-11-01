using DelimitedFiles
using StaticArrays, Parameters, Dierckx, SimulatedAnnealing
using OrdinaryDiffEq, Plots

include("musclemodel/torque_generator.jl")
include("model/parameters.jl")
include("model/eom.jl")
include("model/functions.jl")
include("model/plotting.jl")
include("model/functions_ext.jl")
include("setup.jl")
include("callbacks.jl")

# expects α input as a vector
function updateActivations!(p, x::Vector{Float64})
    @unpack he, hf, ke, kf, ae, af = p

    n = length(x) ÷ 6 # number of activation parameters per torque generator
    αs = [x[i:i + n - 1] for i in 1:n:length(x)] # vector of vectors of activation parameters

    # update torque generators CC with activation parameters from αs
    return [tqgen.cc.α_p = ActivationProfile(α...) for (tqgen, α) in zip([he,ke,ae,hf,kf,af], αs)]
end

function optimiseModel()

    # set up model
    p, u₀ = setup(activation_parameters="data/stance_evaluation_opt_activation.csv")

    # time span
    tspan = (0.0, 0.111)

    # matching variables
    VCMX = 9.67
    TSW = 0.375

    # initialise problem
    prob = ODEProblem(eom, u₀, tspan, p)

    # cost function
    function cost(x)

        # update activation parameters
        p, u₀ = setup(activation_parameters="data/stance_evaluation_opt_activation.csv")
        updateActivations!(p, x)
        prob = ODEProblem(eom, u₀, tspan, p)
        # newprob = remake(prob, p=p) # z values not being reset?


        # solve
        sol = solve(prob, Tsit5(), abstol=1e-5, reltol=1e-5, save_everystep=false, callback=cb)

        # cost
        tc = sol.t[end]     # contact time
        lc = pocmx(sol, tc) - pocmx(sol, 0.0)   # contact length
        vcmyto = vocmy(sol, tc)
        discrim = vcmyto^2 + 4 * p.g * (pocmy(sol, 0.0) - pocmy(sol, tc))
        discrim ≥ 0.0 ? ta = (-vcmyto - sqrt(discrim)) / p.g : return 1000.0 # aerial time, return if none
        la = vocmx(sol, tc) * ta    # aerial length
        tsw = tc + 2ta
        vcmx = (lc + la) / (ta + tc) # step averaged velocity

        return 10(abs(VCMX - vcmx)) + abs(TSW - tsw)
    end

    # set up simulated annealing
    x₀ = vcat(Vector.([p.he.cc.α_p, p.ke.cc.α_p, p.ae.cc.α_p, p.hf.cc.α_p, p.kf.cc.α_p, p.af.cc.α_p])...)
    f₀ = cost(x₀)
    ub = ones(length(x₀))
    lb = repeat([0.0,0.0,0.1,0.0,0.0,0.1,0.0], 6)
    v = ub .- lb

    T₀ = 5.0
    N = length(x₀)
    Ns = 24
    Nt = 5

    current = State(f₀, x₀, v, T₀)
    options = Options(func=cost, N=N, Ns=Ns, Nt=Nt, lb=lb, ub=ub, tol=1e-4, print_status=true)
    result = Result(f₀, x₀)

    # run sa
    sa!(current, result, options)

end
