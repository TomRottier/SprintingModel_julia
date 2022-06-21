## functions used to optimise model
const INTEGRATOR = Tsit5()
const INT_OPTIONS = (; saveat=0.001, abstol=1e-8, reltol=1e-8, verbose=false, maxiters=2e4, progress=true, progress_steps=1)

# to get progress bar
#=using Logging: global_logger
using TerminalLoggers: TerminalLogger
global_logger(TerminalLogger())

then add progress=true and progress_steps=x to solve call

=#
# mean squared error between two vectors
mse(x, y) = (x .- y) .^ 2 |> mean

# objective
objective(x) =
    try
        cost(simulate(prob, x))
    catch
        return 10000.0
    end

# cost function for simulation
function cost(sim_data)
    global matching_data

    # CoM position and HAT orientation
    # sim_cmx = pocmx(sim_data)
    sim_cmy = pocmy(sim_data)
    sim_θ = sim_data[3, :] .|> rad2deg
    # exp_cmx = matching_data[:cmx]
    exp_cmy = matching_data[:cmy]
    exp_θ = matching_data[:lhat]

    # mse between simulation and experimental data
    cmx_mse = 0.0 #mse(sim_cmx, exp_cmx)
    cmy_mse = mse(sim_cmy, exp_cmy)
    θ_mse = mse(sim_θ, exp_θ)

    # scale by range 
    # cmx_mse /= abs(reduce(-, extrema(sim_cmx)))
    cmy_mse /= abs(reduce(-, extrema(sim_cmy)))
    θ_mse /= abs(reduce(-, extrema(sim_θ)))

    # cost function
    return cmx_mse + cmy_mse + θ_mse
end

# simulate a stride from prob
simulate(prob::ODEProblem) = solve(deepcopy(prob), INTEGRATOR; callback=vcb, INT_OPTIONS...)

# run a simulate with new parameters
simulate(x) = simulate(prob, x)

function simulate(prob, x)
    # new parameter struct with updated parameters from x and reset torque generators, updated intial CC angles 
    pnew = update_parameters(prob.p, x)

    # remake problem with updated parameters and initial conditions
    newprob = remake(prob, p=pnew)

    # integrate new problem
    return simulate(newprob)
end

# update parameters from vector
function update_parameters(p, x)
    k1, k2, k3, k4, k5, k6, k7, k8 = x

    # copy p but with new parameters
    new_p = setproperties(p, (k1=k1, k2=k2, k3=k3, k4=k4, k5=k5, k6=k6, k7=k7, k8=k8))

    return new_p
end