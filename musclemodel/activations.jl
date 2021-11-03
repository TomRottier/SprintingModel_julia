# activation structs
struct ActivationRamp
    t0::Float64     # onset time relative to end of last ramp
    r::Float64      # ramp time
    a1::Float64     # new activation level
end

struct ActivationProfile
    a0::Float64     # starting activation level
    ramps::Vector{ActivationRamp}
end
ActivationProfile(a0, r::ActivationRamp) = ActivationProfile(a0, [r])
ActivationProfile(a0, ramps...) = ActivationProfile(a0, [ActivationRamp(ramps[i:i + 2]...) for i in 1:3:length(ramps)])
ActivationProfile(x::AbstractArray) = ActivationProfile(x[1], x[2:end]...)

# ramp function - time relative to onset time (t-t0)
ramp(t, a0, r, a1) = a0 + (a1 - a0) * (t / r)^3 * (6 * (t / r)^2 - 15 * (t / r) + 10)
ramp(t, a0, p::ActivationRamp) = ramp(t, a0, p.r, p.a1)

# calculate activation from time - t relative to end of last ramp
activation(t, a0, p::ActivationRamp) = t < p.t0 ? a0 : t ≤ p.t0 + p.r ? ramp(t - p.t0, a0, p) : p.a1

function activation(t, p::ActivationProfile)
    a0 = p.a0   # previous activation level
    _t = 0.0    # end of last ramp time
    for ramp in p.ramps
        if t < _t + ramp.t0 + ramp.r
            return activation(t - _t, a0, ramp)
        else
            _t += ramp.t0 + ramp.r
            a0 = ramp.a1
        end
    end

    return p.ramps[end].a1
end

# custom plotting
Plots.plot(t, p::ActivationProfile) = plot(x -> activation(x, p), t)

# convert ActivationProfile to vec
Base.Vector(a::ActivationProfile) = [a.a0, vcat([[b.t0,b.r,b.a1] for b in a.ramps]...)... ]