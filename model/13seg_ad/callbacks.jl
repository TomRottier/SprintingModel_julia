## callbacks for integration
function pop10x(u, p, t)
    @unpack lth, lsh, lrf, lff = p
    @inbounds q1, q2, q3 = u

    # specified variables
    lh = _lh(t)
    rh = _rh(t)
    lk = _lk(t)
    rk = _rk(t)
    la = _la(t)
    ra = _ra(t)
    lmtp = _lmtp(t)

    return q1 + lth * cos(rh - q3) + lsh * cos(lh - lk - q3) + lrf * cos(ra + rh - rk - q3) + lff * cos(la + lh + lmtp - lk - q3) - lth * cos(lh - q3) - lsh * cos(rh - rk - q3) - lrf * cos(la + lh - lk - q3)
end

function pop10y(u, p, t)
    @unpack lth, lsh, lrf, lff = p
    @inbounds q1, q2, q3 = u

    # specified variables
    lh = _lh(t)
    rh = _rh(t)
    lk = _lk(t)
    rk = _rk(t)
    la = _la(t)
    ra = _ra(t)
    lmtp = _lmtp(t)

    return q2 + lth * sin(lh - q3) + lsh * sin(rh - rk - q3) + lrf * sin(la + lh - lk - q3) - lth * sin(rh - q3) - lsh * sin(lh - lk - q3) - lrf * sin(ra + rh - rk - q3) - lff * sin(la + lh + lmtp - lk - q3)
end

function pop11x(u, p, t)
    @unpack lth, lsh, lrf, lff = p
    @inbounds q1, q2, q3 = u

    # specified variables
    lh = _lh(t)
    rh = _rh(t)
    lk = _lk(t)
    rk = _rk(t)
    la = _la(t)
    ra = _ra(t)
    lmtp = _lmtp(t)
    rmtp = _rmtp(t)

    return q1 + lth * cos(rh - q3) + lsh * cos(lh - lk - q3) + lrf * cos(ra + rh - rk - q3) + lff * cos(la + lh + lmtp - lk - q3) - lth * cos(lh - q3) - lsh * cos(rh - rk - q3) - lrf * cos(la + lh - lk - q3) - lff * cos(ra + rh + rmtp - rk - q3)
end

function pop11y(u, p, t)
    @unpack lth, lsh, lrf, lff = p
    @inbounds q1, q2, q3 = u

    # specified variables
    lh = _lh(t)
    rh = _rh(t)
    lk = _lk(t)
    rk = _rk(t)
    la = _la(t)
    ra = _ra(t)
    lmtp = _lmtp(t)
    rmtp = _rmtp(t)

    return q2 + lth * sin(lh - q3) + lsh * sin(rh - rk - q3) + lrf * sin(la + lh - lk - q3) + lff * sin(ra + rh + rmtp - rk - q3) - lth * sin(rh - q3) - lsh * sin(lh - lk - q3) - lrf * sin(ra + rh - rk - q3) - lff * sin(la + lh + lmtp - lk - q3)
end

function condition(out, u, t, int)
    p = int.p
    out[1] = pop10y(u, p, t)
    out[2] = pop11y(u, p, t)
end

# positive crossing (-ve to +ve)
affect!(int, idx) = nothing

# negative crossing (+ve to -ve)
function affect_neg!(int, idx)
    if idx == 1 # pop10y == 0
        # println("right mtp touchdown at $(int.t)")
        int.p.rmtpxi[1] = pop10x(int.u, int.p, int.t)
    elseif idx == 2 # pop11y == 0
        # println("right toe touchdown at $(int.t)")
        int.p.rtoexi[1] = pop11x(int.u, int.p, int.t)
    else
        error("unknown callback idx")
    end

    return nothing
end

# callback
vcb = VectorContinuousCallback(condition, affect!, affect_neg!, 2, save_positions=(false, false), repeat_nudge=1 // 1)