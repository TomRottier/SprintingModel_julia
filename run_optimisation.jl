using Distributed

addprocs(6, exeflags = "--project")   # create worker processes with current project activated
@everywhere include("parallel_setup.jl")

# set initial speed
@everywhere VCMX = 8.9

# imulated annealing parameters
T₀ = 0.5
N = 42
Ns = 12
Nt = 5

# initial guess
x₀ = rand(N)
f₀ = simulate(x₀, p, prob, u₀)

# bounds and step length
ub = ones(N)
lb = repeat([0.01, 0.0, 0.1, 0.01, 0.0, 0.1, 0.01], 6) # constrain lb of activation to 0.01
v = ub .- lb

# initial structs
current = State(f=f₀, x=x₀, v=v, T=T₀)
result = Result(fopt=f₀, xopt=x₀)
options = Options(func = x -> simulate(x, p, prob, u₀), N = N, Ns = Ns, Nt = Nt, lb = lb, ub = ub, tol = 1e-4, print_status = true)

# optimisation loop
submax_velocity = true
@time while submax_velocity
    # set velocity and reinitialise initial conditions and prob
    @everywhere begin
        VCMX += 0.1
        inputs.initial_conditions[8] = VCMX
        p, u₀ = set_values(inputs)
        prob = ODEProblem(eom, u₀, tspan, p)
    end

    println("Rerunning optimisation with vcmx = $VCMX")

    # (re)initialise sa
    x₀ = result.xopt    # use previous optimal x as starting point for next optimisation
    f₀ = simulate(x₀, p, prob, u₀)
    current = State(f=f₀, x=x₀, v=v, T=T₀)
    options = Options(func = x -> simulate(x, p, prob, u₀), N = N, Ns = Ns, Nt = Nt, lb = lb, ub = ub, tol = 1e-4, print_status = true)
    result = Result(fopt=f₀, xopt=x₀)

    # run sa
    @time sa!(current, result, options)

    # write results to file
    open("optimisations/college/results.csv", "a") do io
        writedlm(io, [VCMX result.fopt result.xopt...], ',')
    end

    # check if conditions met to be able to run at VCMX
    popt, u₀ = updateParameters(p, result.xopt, u₀)
    sol = solve(ODEProblem(eom, u₀, tspan, popt), Tsit5(), abstol = 1e-5, reltol = 1e-5, callback = cb, saveat = 0.001)
    animate_model(sol)
    submax_velocity = abs(swing_time(sol) - TSW) < 0.001 && abs(step_velocity(sol) - VCMX) < 0.01
end