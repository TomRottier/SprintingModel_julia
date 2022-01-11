# using Parameters

include("activations.jl")
include("cc.jl")
include("sec.jl")
include("pec.jl")

# torque generator
mutable struct TorqueGenerator
    τ::Float64  # torque
    θ::Float64  # angle
    ω::Float64  # angular velocity
    cc::CC      # contractile component
    sec::SEC    # series elastic component
    # pec::PEC    # parallel elastic component

    function TorqueGenerator(θ₀, ω₀, cc_p, sec_p, α_p)
        # initialise CC with joint angle and angular velocity
        cc = CC(θ₀, ω₀, cc_p, α_p)

        # SEC therefore has zero angle and angular velocity
        sec = SEC(0., 0., sec_p)

        # create new torque generator
        tqgen = new(0., θ₀, ω₀, cc, sec)

        # initialise CC, SEC angle and torque
        initccang!(tqgen)                   # CC angle
        tqgen.sec.θ = tqgen.θ - tqgen.cc.θ  # SEC angle
        torque!(tqgen.cc, 0.0)    # CC torque
        torque!(tqgen.sec) # SEC torque
        tqgen.τ = tqgen.sec.τ               # torque generator torque

        return tqgen
    end
end


# find initial CC angle
function initccang!(tqgen::TorqueGenerator)
    @unpack θ, cc, sec = tqgen

    # initial activation
    α = activation(0.0, cc.α_p)

    # catch if activation zero
    α == 0 && (cc.θ = 0; return θ)

    # closure returns difference in torque between CC and SEC for given CC angle
    f(θcc) = torque(θ - θcc, sec.sec_p) - torque(α, θcc, -cc.ω, cc.cc_p)

    # ensure CC angle +ve - not sure why needed?
    _θ = abs(θ)

    # set up min and max bounds of CC angle
    max_stretch = cc.cc_p.Tmax / sec.sec_p.k
    θmin = _θ - max_stretch
    θmax = _θ

    # solve for CC ang
    tol = 1e-6
    maxiters = 50
    θcc = bisection(f, θmin, θmax, tol, maxiters)

    # assign to CC
    θ < 0.0 && (θcc *= -1)    # resets sign
    cc.θ = θcc

    return cc.θ
end

# bisection method for root finding, stops after maxiters iterations or interval smaller than tol
function bisection(f, a, b, tol, maxiters)
    n = 1
    midpoint = 0.
    while n ≤ maxiters
        midpoint = a + (b - a) / 2
        # abs(b - a) < tol && return midpoint    # return midpoint if interval smaller than tol
        abs(f(midpoint)) < tol && return midpoint # return midpoint if it is smaller than tol
        f(a) * f(midpoint) < 0 ? b = midpoint : a = midpoint  # update interval
        n += 1
    end
    
    return midpoint
end 

# numerically integrate the CC angle independently 
function update_torque_generator_ind!(tqgen::TorqueGenerator, dt)
    @unpack θ, ω, cc, sec = tqgen

    # integrate CC angle to next time step
    # solve it here easy but inaccurate, otherwise add CC angles to integrator
    cc.θ += cc.ω * dt
    cc.θ ≥ θ && (cc.θ = θ)

    ### checks on cc angle? ###

    # calculate SEC angle
    sec.θ = θ - cc.θ

    # determine SEC torque and set to torque generator torque
    tqgen.τ = torque!(sec)

    # set SEC and CC torque equal
    cc.τ = sec.τ

    # determine CC angular velocity from torque
    τ_θ = torque_angle(cc.θ)
    τ_θ < 0.01 && (τ_θ = 0.01)    # stop τ_v blowing up if too small
    α < 0.01 && no_activation!(tqgen) # conditions for when activation low
    τ_ω = τ / (cc + p.T0 * α * τ_θ)   # calculate normalised torque from τ-ω relationship
    Tmax_norm = cc_p.Tmax / cc_p.T0
    τ_ω > Tmax_norm && (τ_ω = Tmax_norm)  # constrain normalised torque to realistic values
    τ_ω < 0.0 && (τ_ω = 0.0)
    cc.τ = τ_ω  # set CC torque
    cc.ω = -angvel(cc, cc_p)   # calculate CC angular velocity (opposite sign to function)    
    sec.ω = ω - cc.ω    # update SEC angvel
    
    return tqgen.τ
end

# accepts CC angle as argument, so included in model integration
function update_torque_generator!(tqgen::TorqueGenerator, t, θ, ω, θcc)
    @unpack cc, sec = tqgen
    cc_p, sec_p = cc.cc_p, sec.sec_p

    # update torque generator angle and angular velocity
    tqgen.θ = θ
    tqgen.ω = ω
    
    # update CC angle 
    θcc > tqgen.θ ? cc.θ = θcc : cc.θ = tqgen.θ
    cc.θ = θcc

    # calculate activation level
    α = activation(t, cc.α_p)
    cc.α = α
    α < 0.01 && (α = 0.01) #no_activation!(tqgen) 

    ### when rising above α = 0.01 get sudden change in cc angle and angular velocity ###

    ### what if constrained activations to be min of 0.01 ###

    # calculate SEC angle
    θsec_max = cc_p.Tmax / sec_p.k
    sec.θ = θ - cc.θ
    sec.θ > θsec_max && (sec.θ = θsec_max)  # constrain SEC angle to max stretch

    # determine SEC torque and set to torque generator torque
    tqgen.τ = torque!(sec)
     
    # set SEC and CC torque equal
    cc.τ = sec.τ

    # calculate τ_θ component from CC angle
    torque_angle!(cc)
    cc.τ_θ < 0.01 && (cc.τ_θ = 0.01)    # stop τ_ω blowing up if too small
    
    # calculate τ-ω component from CC angular velocity
    cc.τ_ω = cc.τ / (cc_p.T0 * α * cc.τ_θ)   
    (cc.τ_ω * cc_p.T0) > cc_p.Tmax && (cc.τ_ω = cc_p.Tmax / cc_p.T0)  # constrain τ_ω to realistic values
    cc.τ_ω < 0.0 && (cc.τ_ω = 0.0)

    # calculate CC angular velocity (opposite sign to function)  
    angvel_torque_norm!(cc)     
    sec.ω = ω - cc.ω    # update SEC angvel for completeness but not needed

    return tqgen.τ
end

# returns dictionary of CC and SEC components for given t, θ, ω and θcc
function get_torque_generator(tqgen, t, θ, ω, θcc)
    _tqgen = deepcopy(tqgen)
    update_torque_generator!(_tqgen, t, θ, ω, θcc)

    return Dict(
        :cc => Dict(
            field => getfield(_tqgen.cc, field) for field in fieldnames(CC)[1:end - 2]
        ),

        :sec => Dict(
            field => getfield(_tqgen.sec, field) for field in fieldnames(SEC)[1:end - 1]
        )
    )
end

function torque(tqgen::TorqueGenerator, θ, θcc) 
    θsec = θ - θcc 
    # constrain maximum SEC stretch to Tmax/k
    θsec_max = tqgen.cc.cc_p.Tmax / tqgen.sec.sec_p.k
    θsec > θsec_max ? τ = θsec_max : τ = torque(θsec, tqgen.sec.sec_p)

    return τ
end

# state of torque generator when no activation
function no_activation!(tqgen::TorqueGenerator)
    @unpack cc, sec = tqgen
    cc.α = 0.0
    cc.τ = 0.0
    sec.θ = 0.0     # no torque ∴ no SEC stretch
    torque!(sec)    
    cc.θ = tqgen.θ  # CC angle must make up torque generator angle
    sec.ω = 0.0     # SEC angle not changing ∴ ang vel = 0
    cc.ω = tqgen.ω  # CC ang vel must make up torque generator ang vel

    # update CC torque components
    torque_angle!(cc)
    torque_angvel!(cc)
end
