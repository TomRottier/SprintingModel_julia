using Distributed

addprocs(6, exeflags="--project")   # create worker processes with current project activated
@everywhere include("parallel_setup.jl")

# set initial speed
@everywhere VCMX = 10.0

# imulated annealing parameters
T₀ = 0.5
N = 42
Ns = 12
Nt = 5

# initial guess
x₀ = rand(N)
f₀ = simulate(x₀, p, prob)

# bounds and step length
ub = ones(N)
lb = repeat([0.01,0.0,0.1,0.01,0.0,0.1,0.01], 6) # constrain lb of activation to 0.01
v = ub .- lb

# optimisation loop
condition = true
while condition
    # set velocity and reinitialise initial conditions and prob
    @everywhere begin 
        VCMX += 0.1
        inputs.initial_conditions[8] = VCMX
        p, u₀ = set_values(inputs)
        prob = ODEProblem(eom, u₀, tspan, p)
    end

    # (re)initialise sa
    x₀ = result.xopt    # use previous optimal x as starting point for next optimisation
    f₀ = simulate(x₀, p, prob)
    current = State(f₀, x₀, v, T₀)
    options = Options(func=x -> simulate(x, p, prob), N=N, Ns=Ns, Nt=Nt, lb=lb, ub=ub, tol=1e-4, print_status=true)
    result = Result(f₀, x₀)

    # run sa
    @time sa!(current, result, options)

    # write results to file
    open("optimisations/sprinter/results.csv", "a") do io 
        writedlm(io, [VCMX result.fopt result.xopt...], ',')
    end

    # check if conditions met to be able to run at VCMX
    popt = updateParameters(p, result.xopt, u₀)
    sol = solve(ODEProblem(eom, u₀, tspan, popt), Tsit5(), abstol=1e-5, reltol=1e-5, callback=cb, saveat=0.001)
    condition = abs(swing_time(sol) - TSW) < 0.001 && abs(step_velocity(sol) - VCMX) < 0.01
end