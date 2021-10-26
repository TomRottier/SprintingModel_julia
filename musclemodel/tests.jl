using Test
using Plots, Parameters, OrdinaryDiffEq

# hip extensor parameters, single ramp from 0.5 to 1.0 over 0.1 s
cc_p = CCParameters(838.2, 645.0, 26.0, 7.94, 1.0, 1.0, 1.0, 4.93, 1.64)
sec_p = SECParameters(2854.48)
α_p = ActivationProfile(0.5, ActivationRamp(0.0, 0.1, 1.0))

## TorqueGenerator
include("torque_generator.jl")
θ₀ = π / 2    # inital torque generator angle
ω₀ = 2π     # intial torque generator angular velocity
tqgen = TorqueGenerator(θ₀, ω₀, α_p, cc_p, sec_p)
@testset "torque generator" verbose = true begin
    # @test abs(tqgen.sec.τ - tqgen.cc.τ * tqgen.α) < 1e-6 # initial CC and SEC matching
    error = 0
    for θ₀ in 0:0.001:2π
        tqgen = TorqueGenerator(θ₀, ω₀, α_p, cc_p, sec_p)
        match = !(abs(tqgen.sec.τ - tqgen.cc.τ * tqgen.α) < 1e-6)
        error += match
    end
    @test error == 0
   θ₀ = rand(0.:.001:2π); tqgen = TorqueGenerator(θ₀, ω₀, α_p, cc_p, sec_p)
   @test tqgen.θ == tqgen.sec.θ + tqgen.cc.θ
   @test tqgen.ω == tqgen.sec.ω + tqgen.cc.ω
end

# test integration - he inital conditions
θ₀ = 215.89 |> deg2rad
ω₀ = -429.803 |> deg2rad
cc_p = CCParameters(838.2, 645.0, 26.0, 7.94, 1.0, 1.0, 1.0, 4.93, 1.64)
sec_p = SECParameters(2854.48)
α_p = ActivationProfile(0.9994277764, 0.6317965682e-01, 0.2115428829, 0.9106166714, 0.8071698914e-03, 0.1604915461, 0.1002353143)
tqgen = TorqueGenerator(θ₀, ω₀, cc_p, sec_p, α_p)
# θcc = tqgen.cc.θ
# t = 0.000
# dt = 0.001
# while t < 0.01
#     println("original values: t=$t, θ=$θ₀, ω=$ω₀, θcc=$θcc, ωcc=$(tqgen.cc.ω) τ=$(-tqgen.τ)")
#     τ = -update_torque_generator!(tqgen, t, θ₀, ω₀, θcc)
#     θ₀ += ω₀ * dt
#     ω₀ += τ * dt
#     θcc = tqgen.cc.θ + tqgen.cc.ω * dt
#     t += dt
#     println("updated values: t=$t, θ=$θ₀, ω=$ω₀, θcc=$θcc, ωcc=$(tqgen.cc.ω), τ=$(-tqgen.τ)")

# end

u₀ = [θ₀, ω₀, tqgen.cc.θ]
f(u,p,t) = begin
    τ = update_torque_generator!(p, t, u...)
    return [u[2],τ, p.cc.ω]
end
prob = ODEProblem(f, u₀, (0., 0.111), tqgen)
sol = solve(prob, Tsit5(), saveat=0.001)
tq = [torque(sol.prob.p, sol(t)[1], sol(t)[3]) for t in sol.t]

## CC
include("cc.jl")
# plot relationships
plot(cc_p)

## activations 
t1 = collect(0:0.001:0.2); t2 = collect(0:0.001:0.1); t3 = collect(0:0.001:0.2)
r1 = ramp.(t1, 0.0, 0.2, 1.0); r2 = ramp.(t2, 1.0, 0.1, 0.5); r3 = ramp.(t3, 0.5, 0.2, 0.0)
t_true = collect(0:0.001:1.0)
a_true = [repeat([0.0], 99); r1; repeat([1.0], 199); r2; r3; repeat([0.0], 199)]

a0 = 0.0
r1 = ActivationRamp(0.1, 0.2, 1.0)
r2 = ActivationRamp(0.2, 0.1, 0.5)
r3 = ActivationRamp(0.0, 0.2, 0.0)
p = ActivationProfile(a0, [r1,r2,r3])


## PEC
include("pec.jl")
# recreate figures from Reiner and Edrich (1999)
ϕh = range(-40, 120, length=1000)
ϕk = range(-10, 150, length=1000)
ϕa = range(-30, 60, length=1000)

# hip
knee_angles = [0,45,90]
hip_plt = plot(title="hip", xticks=[-40:20:120...], yticks=[-80:20:60...], ylims=(-90, 70))
for knee_angle in knee_angles
    plot!(ϕh, torqueHip.(ϕh, knee_angle), label="ϕk = $knee_angle")
    
end
# knee
hip_angles = [0,45,90,120]
knee_plt = plot(title="knee", ylims=(-30, 30), xticks=[0:50:150...], yticks=[-20:10:30...])
for hip_angle in hip_angles
    plot!(ϕk, torqueKnee.(hip_angle, ϕk, 0), label="ϕh = $hip_angle")
end
# ankle
knee_angles = [0,60]
ankle_plt = plot(title="ankle", ylims=(-20, 30), xticks=[-30:10:60...], yticks=[-20:5:30...])
for knee_angle in knee_angles
    plot!(ϕa, torqueAnkle.(knee_angle, ϕa), label="ϕk = $knee_angle")
end
plot(hip_plt, knee_plt, ankle_plt)


θh = deg2rad.(0:0.1:220) # range(50, 220, length=1000) .|> deg2rad
θk = deg2rad.(0:0.1:220) # range(0, 180, length=1000) .|> deg2rad
θa = deg2rad.(0:0.1:220) # range(50, 180, length=1000) .|> deg2rad
# hip
knee_angles = [45,90, 180] .|> deg2rad
hip_plt = plot(title="hip", ylims=(-100, 100), legend=:topleft)
for knee_angle in knee_angles
    plot!(rad2deg.(θh), torqueHip.(convertHip.(θh), convertKnee(knee_angle)), label="θk = $(rad2deg(knee_angle))")
end
hip_plt
# knee
hip_angles = [45,90,135,180] .|> deg2rad
knee_plt = plot(title="knee", ylims=(-100, 100), legend=:topleft)
for hip_angle in hip_angles
    plot!(rad2deg.(θk), torqueKnee.(convertHip(hip_angle), convertKnee.(θk), convertKnee.(0)), label="θh = $(rad2deg(hip_angle))")
end
# ankle
knee_angles = [45, 135] .|> deg2rad
ankle_plt = plot(title="ankle", ylims=(-100, 100))
for knee_angle in knee_angles
    plot!(rad2deg.(θa), torqueAnkle.(convertKnee(knee_angle), convertAnkle.(θa)), label="θk = $(rad2deg(knee_angle))")
end
plot(hip_plt, knee_plt, ankle_plt)
