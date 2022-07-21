## functions used to optimise model
const INTEGRATOR = Tsit5()
const INT_OPTIONS = (saveat=0.001, abstol=1e-8, reltol=1e-8, verbose=false, maxiters=2e4)

# to get progress bar
#=using Logging: global_logger
using TerminalLoggers: TerminalLogger
global_logger(TerminalLogger())

then add progress=true and progress_steps=x to solve call

=#

# objective
objective(x) = cost(simulate(prob, x)...)
# try
#     cost(simulate(prob, x))
# catch
#     return 10000.0
# end

# simulate with new parameters
function simulate(prob::ODEProblem, x)
    # new parameter struct with updated parameters from x
    pnew = update_parameters(prob.p, x)

    # new ODEProblem
    newprob = remake(prob, p=pnew)

    # solve new problem
    return simulate(newprob)
end

# simulate a stride from an ODEProblem
function simulate(prob1::ODEProblem)
    # simulate step 1
    sol1 = solve(deepcopy(prob1), INTEGRATOR; callback=cb1, INT_OPTIONS...)

    # check if need to simulate second step - NOT TYPE STABLE
    # unusual termination
    sol1.retcode ≠ :Terminated && return sol1, -1
    # stop first contact ending early
    sol1.t[end] < 0.1 && return sol1, -2
    # second step can't be too negative
    # vocmy(sol1, sol1.t[end]) ≤ -1.0 && return sol1, -3

    # fit splines to grf
    splx1, sply1, splx2, sply2 = grf_spl(sol1)

    # update parameters, initial conditions and time span
    pnew = setproperties(prob1.p, (vrx1=splx1, vry1=sply1, vrx2=splx2, vry2=sply2))
    unew = sol1.u[end]
    tnew = (sol1.t[end], prob1.tspan[end])

    # create prob for step 2
    prob2 = remake(prob1, u0=unew, p=pnew, tspan=tnew)

    # simulate step 2
    sol2 = solve(prob2, INTEGRATOR; INT_OPTIONS...)
    sol2.retcode ∉ (:Success, :Terminated) && return sol1, -4

    return sol1, sol2
end

# fit splines to grf during first step
function grf_spl(sol)
    T = sol.t[end]
    t = sol.t[1]:0.001:T
    splx1 = CubicSplineInterpolation(t .+ T, [rx1(sol, _t) for _t in t], extrapolation_bc=0.0)
    sply1 = CubicSplineInterpolation(t .+ T, [ry1(sol, _t) for _t in t], extrapolation_bc=0.0)
    splx2 = CubicSplineInterpolation(t .+ T, [rx2(sol, _t) for _t in t], extrapolation_bc=0.0)
    sply2 = CubicSplineInterpolation(t .+ T, [ry2(sol, _t) for _t in t], extrapolation_bc=0.0)

    return splx1, sply1, splx2, sply2
end

# mean squared error between two vectors
mse(x, y) = (x .- y) .^ 2 |> mean

# cost function for simulation
function cost(sim_data)
    global matching_data

    # # CoM position and HAT orientation
    # # sim_cmx = pocmx(sim_data)
    # sim_cmy = pocmy(sim_data)
    # sim_θ = sim_data[3, :] .|> rad2deg
    # # exp_cmx = matching_data[:cmx]
    # exp_cmy = matching_data[:cmy]
    # exp_θ = matching_data[:lhat]

    # # mse between simulation and experimental data
    # cmx_mse = 0.0 #mse(sim_cmx, exp_cmx)
    # cmy_mse = mse(sim_cmy, exp_cmy)
    # θ_mse = mse(sim_θ, exp_θ)

    # # scale by range 
    # # cmx_mse /= abs(reduce(-, extrema(sim_cmx)))
    # cmy_mse /= abs(reduce(-, extrema(sim_cmy)))
    # θ_mse /= abs(reduce(-, extrema(sim_θ)))

    # # cost function
    # return cmx_mse + cmy_mse + θ_mse

    # CoM velocity and HAT orientation
    # sim_vcmx = vocmx(sim_data)
    # sim_vcmy = vocmy(sim_data)
    sim_vcmx = Vector{Float64}(undef, size(sim_data, 2))
    sim_vcmy = Vector{Float64}(undef, size(sim_data, 2))
    for i in 1:size(sim_data, 2)
        sim_vcmx[i] = vocmx(sim_data[:, i], prob.p, (i - 1) / 1000)
        sim_vcmy[i] = vocmy(sim_data[:, i], prob.p, (i - 1) / 1000)
    end

    sim_θ = sim_data[3, :] .|> rad2deg
    exp_vcmx = matching_data[:vcmx]
    exp_vcmy = matching_data[:vcmy]
    exp_θ = matching_data[:ht]

    # mse between simulation and experimental data
    vcmx_mse = mse(sim_vcmx, exp_vcmx)
    vcmy_mse = mse(sim_vcmy, exp_vcmy)
    θ_mse = mse(sim_θ, exp_θ)

    # scale by range 
    vcmx_mse /= abs(reduce(-, extrema(sim_vcmx)))
    vcmy_mse /= abs(reduce(-, extrema(sim_vcmy)))
    θ_mse /= abs(reduce(-, extrema(sim_θ)))

    # cost function
    return vcmx_mse + vcmy_mse + θ_mse
end

cost(sol1, sol2) = cost([Array(sol1(0:0.001:sol1.t[end-1])) Array(sol2(sol1.t[end-1]+0.001:0.001:sol2.t[end]))])
cost(sol1, err::Int) = 10000 - err
cost(err1::Int, err2::Int) = 10000.0 - 10err1 - err2

# update parameters from vector
function update_parameters(p, x)
    k1, k2, k3, k4, k5, k6, k7, k8 = x

    # copy p but with new parameters
    new_p = setproperties(p, (k1=k1, k2=k2, k3=k3, k4=k4, k5=k5, k6=k6, k7=k7, k8=k8))

    return new_p
end