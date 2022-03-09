using Distributed

addprocs(12, exeflags = "--project")   # create worker processes with current project activated
@everywhere include("parallel_setup.jl")

# simulated annealing parameters
T₀ = 0.5
N = 60
Ns = 24
Nt = 5
tol = 1.0

# bounds and step length
ub = repeat([1.0, repeat([0.5, 0.5, 1.0], 3)...], 6)
lb = repeat([0.01, repeat([0.0, 0.1, 0.01], 3)...], 6) # constrain lb of activation to 0.01
v = ub .- lb

# initial guess
randx(lb, ub) = [rand(lb:0.001:ub) for (lb, ub) in zip(lb, ub)]
x₀ = [rand(lb:0.001:ub) for (lb, ub) in zip(lb, ub)] #=vcat(map(x -> inputs.activation_parameters[x], [:he, :ke, :ae, :hf, :kf, :af])...) =#
f₀ = objective(x₀)

# initial structs
current = State(f = f₀, x = x₀, v = v, T = T₀)
result = Result(fopt = f₀, xopt = x₀)
options = Options(func = objective, N = N, Ns = Ns, Nt = Nt, lb = lb, ub = ub, tol = tol, print_status = true)
@time sa!(current, result, options)



# # optimisation loop
# submax_velocity = true
# # set initial speed
# @everywhere VCMX = 9.5704
# while submax_velocity
#     # set velocity and reinitialise initial conditions and prob
#     @everywhere begin
#         VCMX += 0.1
#         inputs.initial_conditions[:vcmx] += 0.1
#         p, u₀ = set_values(inputs)
#         prob = ODEProblem(eom, u₀, tspan, p)
#     end

#     println("Rerunning optimisation with vcmx = $VCMX")

#     # (re)initialise sa
#     x₀ = result.xopt    # use previous optimal x as starting point for next optimisation
#     f₀ = objective(x₀)
#     current = State(f = f₀, x = x₀, v = v, T = T₀)
#     result = Result(fopt = f₀, xopt = x₀)
#     options = Options(func = objective, N = N, Ns = Ns, Nt = Nt, lb = lb, ub = ub, tol = tol, print_status = true)

#     # run sa
#     @time sa!(current, result, options)

#     # write results to file
#     open("optimisations/matching/results.csv", "a") do io
#         writedlm(io, [VCMX result.fopt result.xopt...], ',')
#     end
#     submax_velocity = false

#     # check if conditions met to be able to run at VCMX
#     popt, u₀opt = updateParameters(p, result.xopt, u₀)
#     sol1, sol2 = simulate(result.xopt)
#     # animate_model(sol)
#     # submax_velocity = abs(swing_time(sol) - TSW) < 0.001 && abs(step_velocity(sol) - VCMX) < 0.01
# end
