using Distributed

addprocs(6, exeflags = "--project")   # create worker processes with current project activated
@everywhere include("parallel_setup.jl")

# set initial speed
@everywhere VCMX = 9.5704

# simulated annealing parameters
T₀ = 0.5
N = 60
Ns = 12
Nt = 1
tol = 1.0

# bounds and step length
ub = repeat([1.2, repeat([0.5, 0.5, 1.2], 3)...], 6)
lb = repeat([0.01, repeat([0.0, 0.1, 0.01], 3)...], 6) # constrain lb of activation to 0.01
v = ub .- lb

# initial guess
x₀ = [rand(lb:0.001:ub) for (lb, ub) in zip(lb, ub)]
f₀ = simulate(x₀, prob)

# initial structs
current = State(f = f₀, x = x₀, v = v, T = T₀)
result = Result(fopt = f₀, xopt = x₀)
options = Options(func = x -> simulate(x, prob), N = N, Ns = Ns, Nt = Nt, lb = lb, ub = ub, tol = tol, print_status = true)

# optimisation loop
submax_velocity = true
while submax_velocity
    # set velocity and reinitialise initial conditions and prob
    @everywhere begin
        VCMX += 0.1
        inputs.initial_conditions[:vcmx] += 0.1
        p, u₀ = set_values(inputs)
        prob = ODEProblem(eom, u₀, tspan, p)
    end

    println("Rerunning optimisation with vcmx = $VCMX")

    # (re)initialise sa
    x₀ = result.xopt    # use previous optimal x as starting point for next optimisation
    f₀ = simulate(x₀, prob)
    current = State(f = f₀, x = x₀, v = v, T = T₀)
    result = Result(fopt = f₀, xopt = x₀)
    options = Options(func = x -> simulate(x₀, prob), N = N, Ns = Ns, Nt = Nt, lb = lb, ub = ub, tol = tol, print_status = true)

    # run sa
    @time sa!(current, result, options)

    # write results to file
    open("optimisations/matching/results.csv", "a") do io
        writedlm(io, [VCMX result.fopt result.xopt...], ',')
    end

    # check if conditions met to be able to run at VCMX
    popt, u₀opt = updateParameters(p, result.xopt, u₀)
    sol = solve(ODEProblem(eom, u₀, tspan, popt), Tsit5(), abstol = 1e-5, reltol = 1e-5, callback = cbs, saveat = 0.001)
    animate_model(sol)
    # submax_velocity = abs(swing_time(sol) - TSW) < 0.001 && abs(step_velocity(sol) - VCMX) < 0.01
end


# test using Optim.jl
using Optim

ub = repeat([1.2, repeat([0.5, 0.5, 1.2], 3)...], 6)
lb = repeat([0.01, repeat([0.0, 0.1, 0.01], 3)...], 6) # constrain lb of activation to 0.01
x₀ = [rand(lb:0.001:ub) for (lb, ub) in zip(lb, ub)]

res = Optim.optimize(x -> simulate(x, p, prob, u₀), lb, ub, x₀, SAMIN(f_tol = 1.0, verbosity = 2), Optim.Options(iterations = 10^6))