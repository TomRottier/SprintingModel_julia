using StaticArrays, OrdinaryDiffEq

f(u, p, t) = SVector(p * u[1])
u0 = SVector(0.1)
p = 0.1
tspan = (0.0, 100.0)
prob = ODEProblem(f, u0, tspan, p)
condition(u, t, int) = 10 - u[1]
affect!(int) = nothing
affect_neg!(int) = terminate!(int)
cb = ContinuousCallback(condition, affect!, affect_neg!)

sol = solve(prob, Tsit5(), abstol=1e-8, reltol=1e-8, callback=cb)
