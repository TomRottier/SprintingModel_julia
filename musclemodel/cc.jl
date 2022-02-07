### contractile component
# using Parameters
# CC parameter struct
@with_kw struct CCParameters
    @deftype Float64
    Tmax
    T0
    ωmax
    ωc
    Amin
    ω1
    ωr
    θopt
    R
end
# create from dictionary
CCParameters(d::Dict{Symbol,Float64}) = CCParameters(Tmax = d[:Tmax], T0 = d[:T0], ωmax = d[:wmax], ωc = d[:wc], Amin = d[:Amin], ω1 = d[:w1], ωr = d[:wr], θopt = d[:theta_opt], R = d[:R])


# CC struct
mutable struct CC
    α::Float64  # activation level
    τ::Float64  # torque
    θ::Float64  # CC angle
    ω::Float64  # CC angular velocity
    τ_θ::Float64 # normalised torque angle value for current CC angle
    τ_ω::Float64 # normalised torque angular velocity value for current CC ang vel
    cc_p::CCParameters # 9 CC parameters
    α_p::ActivationProfile # activation parameters

    function CC(θ, ω, cc_p::CCParameters, α_p::ActivationProfile)
        α = α_p.a0
        τ_θ = torque_angle(θ, cc_p.θopt, cc_p.R)
        τ_ω = torque_angvel_norm(-ω, cc_p)
        τ = α * τ_θ * τ_ω * cc_p.T0

        return new(α, τ, θ, ω, τ_θ, τ_ω, cc_p, α_p)
    end
end



# calculate torque from CC angle
torque_angle(θ, θopt, R) = exp((-(θ - θopt)^2) / (2.0 * R^2))
torque_angle(cc::CC) = torque_angle(cc.θ, cc.cc_p.θopt, cc.cc_p.R)
torque_angle!(cc::CC) = cc.τ_θ = torque_angle(cc)
torque_angle(θ, p::CCParameters) = torque_angle(θ, p.θopt, p.R)

# caluate torque given CC angular velocity
function torque_angvel(ω, Tmax, T0, ωmax, ωc, Amin, ω1, ωr)
    # constants
    k = 4.3
    Amax = 1.0 # for differential activation

    # intermediate values
    Tc = T0 * ωc / ωmax
    C = Tc * (ωmax + ωc)
    ωe = ((Tmax - T0) / (k * T0)) * (ωmax * ωc / (ωmax + ωc))
    E = -(Tmax - T0) * ωe

    # differential activation
    α = Amin + (Amax - Amin) / (1 + exp(-(ω - ω1) / ωr))

    # torque zero when greater than ωmax
    ω > ωmax && return 0.0

    # otherwise calculate torque
    if ω > 0.0
        T = C / (ωc + ω) - Tc   # concentric torque
    else
        T = E / (ωe - ω) + Tmax
    end

    return T * α
end

# reverse sign for τ-ω function if passing CC, leave as is if passing ω
torque_angvel(cc::CC) = torque_angvel(-cc.ω, cc.cc_p.Tmax, cc.cc_p.T0, cc.cc_p.ωmax, cc.cc_p.ωc, cc.cc_p.Amin, cc.cc_p.ω1, cc.cc_p.ωr)
torque_angvel(ω, p::CCParameters) = torque_angvel(ω, p.Tmax, p.T0, p.ωmax, p.ωc, p.Amin, p.ω1, p.ωr)
torque_angvel_norm(cc::CC) = torque_angvel(-cc.ω, cc.cc_p.Tmax / cc.cc_p.T0, 1.0, cc.cc_p.ωmax, cc.cc_p.ωc, cc.cc_p.Amin, cc.cc_p.ω1, cc.cc_p.ωr)
torque_angvel_norm(ω, p::CCParameters) = torque_angvel(ω, p.Tmax / p.T0, 1.0, p.ωmax, p.ωc, p.Amin, p.ω1, p.ωr)
torque_angvel!(cc::CC) = cc.τ_ω = torque_angvel_norm(cc)

# calculate CC angular velocity given NORMALISED torque - NO DIFFERENTIAL ACTIVATION
function angvel_torque(τ_ω, Tmax, T0, ωmax, ωc)
    # constants
    k = 4.3

    # intermediate values
    Tc = T0 * ωc / ωmax
    C = Tc * (ωmax + ωc)
    ωe = ((Tmax - T0) / (k * T0)) * (ωmax * ωc / (ωmax + ωc))
    E = -(Tmax - T0) * ωe

    # error check
    τ_ω < 0 && error("normalised torque less than zero: $τ_ω")

    # find angular velocity
    if τ_ω ≤ T0
        ω = C / (τ_ω + Tc) - ωc   # concentric, +ve angvel
    elseif τ_ω > T0 && τ_ω < Tmax
        ω = ωe - E / (τ_ω - Tmax) # eccentric, -ve angvel
        ω < -ωmax && (ω = -ωmax)  # limit max eccentric angvel
    else
        ω = -ωmax   # τ_ω > Tmax, set to ωmax to prevent it blowing up
    end

    return ω
end

# reverse sign of ω if passing CC, keep as if passing τ_ω
angvel_torque(cc::CC) = -angvel_torque(cc.τ_ω, cc.cc_p.Tmax, cc.cc_p.T0, cc.cc_p.ωmax, cc.cc_p.ωc)
angvel_torque(τ_ω, p::CCParameters) = angvel_torque(τ_ω, p.Tmax, p.To, p.ωmax, p.ωc)
angvel_torque!(cc::CC) = cc.ω = angvel_torque(cc) # not negated as called function negates
angvel_torque_norm(cc::CC) = -angvel_torque(cc.τ_ω, cc.cc_p.Tmax / cc.cc_p.T0, 1.0, cc.cc_p.ωmax, cc.cc_p.ωc)
angvel_torque_norm(τ_ω, p::CCParameters) = angvel_torque(τ_ω, p.Tmax / p.T0, 1.0, p.ωmax, p.ωc)
angvel_torque_norm!(cc::CC) = cc.ω = angvel_torque_norm(cc) # not negated as called function negates

# calculate CC activation
activation(cc::CC, t) = activation(t, cc.α_p)
activation!(cc::CC, t) = cc.α = activation(cc, t)

# calculate contractile component torque from its current state (angle and angvel) and activation
torque(cc::CC, t) = activation(t, cc.α_p) * torque_angle(cc) * torque_angvel(cc)
torque!(cc::CC, t) = cc.τ = torque(cc, t)
# ω sign not reversed as a specific value being called
torque(t, θ, ω, cc_p::CCParameters, α_p::ActivationProfile) = activation(t, α_p) * torque_angle(θ, cc_p) * torque_angvel(ω, cc_p)
torque(α, θ, ω, p::CCParameters) = α * torque_angle(θ, p) * torque_angvel(ω, p)
torque_norm_tet(θ, ω, p::CCParameters) = torque_angle(θ, p) * torque_angvel_norm(ω, p)

# extend plots
function Plots.plot(p::CCParameters)
    p1 = plot(ω -> torque_angvel_norm(ω, p), -p.ωmax:0.01:p.ωmax, xaxis = "angular velocity", yaxis = "normalised torque", legend = :none)
    p2 = plot(θ -> torque_angle(θ, p), (p.θopt-3p.θopt):0.01:(p.θopt+3p.θopt), xaxis = "angle", yaxis = "normalised torque", legend = :none)
    p3 = plot(τ -> angvel_torque_norm(τ, p), 0.0:0.01:2.0, xaxis = "normalised torque", yaxis = "CC angular velocity", legend = :none)
    plot(p1, p2, p3, layout = (1, 3))
end

Plots.surface(p::CCParameters) = surface((p.θopt-3p.θopt):0.01:(p.θopt+3p.θopt), -p.ωmax:0.01:p.ωmax, (θ, ω) -> torque_norm_tet(θ, ω, p), xaxis = "angle", yaxis = "angular velocity", zaxis = "normalised torque")