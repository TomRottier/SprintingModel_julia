### series elastic component

# SEC parameters
struct SECParameters
    k::Float64  # SEC stiffness
end

# SEC struct
mutable struct SEC
    τ::Float64  # torque
    θ::Float64  # SEC angle
    ω::Float64  # SEC angular velocity
    sec_p::SECParameters # SEC parameters

    SEC(θ₀, ω₀, p::SECParameters) = new(θ₀ * p.k, θ₀, ω₀, p)
end

# calculate SEC torque
torque(sec::SEC) = sec.sec_p.k * sec.θ
torque!(sec::SEC) = sec.τ =  torque(sec)
torque(θ, p::SECParameters) = p.k * θ
