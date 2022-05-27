function contact_forces(u, p, t)
    @unpack footang, g, iff, ihat, irf, ish, ith, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lmtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, ltoexi, mff, mhat, mrf, msh, mth, mtpb, mtpk, rmtpxi, rtoexi, u4, u5, u6, u7, u8, u9, z = p
    @inbounds q1, q2, q3, u1, u2, u3 = u

    # specified variables
    rmtp = _rmtp(t)
    ra = _ra(t)
    rk = _rk(t)
    rh = _rh(t)
    la = _la(t)
    lmtp = _lmtp(t)
    lh = _lh(t)
    lk = _lk(t)
    lkp = _lkp(t)
    lap = _lap(t)
    lhp = _lhp(t)
    lmtpp = _lmtpp(t)
    rhp = _rhp(t)
    rkp = _rkp(t)
    rap = _rap(t)
    rmtpp = _rmtpp(t)

    # grf
    pop2y = q2 - lff * sin(la + lh + lmtp - lk - q3)
    pop10y = q2 + lth * sin(lh - q3) + lsh * sin(rh - rk - q3) + lrf * sin(la + lh - lk - q3) - lth * sin(rh - q3) - lsh * sin(lh - lk - q3) - lrf * sin(ra + rh - rk - q3) - lff * sin(la + lh + lmtp - lk - q3)
    pop11y = q2 + lth * sin(lh - q3) + lsh * sin(rh - rk - q3) + lrf * sin(la + lh - lk - q3) + lff * sin(ra + rh + rmtp - rk - q3) - lth * sin(rh - q3) - lsh * sin(lh - lk - q3) - lrf * sin(ra + rh - rk - q3) - lff * sin(la + lh + lmtp - lk - q3)

    # left foot 
    if q2 < 0.0
        dp1x = q1 - ltoexi
        lry1 = -k3 * q2 - k4 * abs(q2) * u2
        lrx1 = lry1 * (-k1 * dp1x - k2 * u1) # (-k1*(q1-pop1xi) - k2*u1)*ry1
    else
        lrx1 = 0.0
        lry1 = 0.0
    end

    if pop2y < 0.0
        pop2x = q1 + lff * cos(la + lh + lmtp - lk - q3)
        vop2x = u1 - lff * sin(la + lh + lmtp - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9)
        vop2y = u2 - lff * cos(la + lh + lmtp - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9)
        dp2x = pop2x - lmtpxi
        lry2 = -k7 * pop2y - k8 * abs(pop2y) * vop2y
        lrx2 = lry2 * (-k5 * dp2x - k6 * vop2x)
    else
        lrx2 = 0.0
        lry2 = 0.0
    end

    # right foot
    if pop11y < 0.0
        pop11x = q1 + lth * cos(rh - q3) + lsh * cos(lh - lk - q3) + lrf * cos(ra + rh - rk - q3) + lff * cos(la + lh + lmtp - lk - q3) - lth * cos(lh - q3) - lsh * cos(rh - rk - q3) - lrf * cos(la + lh - lk - q3) - lff * cos(ra + rh + rmtp - rk - q3)
        vop11x = u1 + lth * sin(lh - q3) * (lhp - u3 - u5) + lsh * sin(rh - rk - q3) * (rhp - rkp - u3 - u4 - u6) + lrf * sin(la + lh - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9) + lff * sin(ra + rh + rmtp - rk - q3) * (rap + rhp + rmtpp - rkp - u3 - u4 - u6 - u8) - lth * sin(rh - q3) * (rhp - u3 - u4) - lsh * sin(lh - lk - q3) * (lhp - lkp - u3 - u5 - u7) - lrf * sin(ra + rh - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) - lff * sin(la + lh + lmtp - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9)
        vop11y = u2 + lth * cos(lh - q3) * (lhp - u3 - u5) + lsh * cos(rh - rk - q3) * (rhp - rkp - u3 - u4 - u6) + lrf * cos(la + lh - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9) + lff * cos(ra + rh + rmtp - rk - q3) * (rap + rhp + rmtpp - rkp - u3 - u4 - u6 - u8) - lth * cos(rh - q3) * (rhp - u3 - u4) - lsh * cos(lh - lk - q3) * (lhp - lkp - u3 - u5 - u7) - lrf * cos(ra + rh - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) - lff * cos(la + lh + lmtp - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9)
        dp11x = pop11x - rtoexi
        rry1 = -k3 * pop11y - k4 * abs(pop11y) * vop11y
        rrx1 = rry1 * (-k1 * dp11x - k2 * vop11x) # (-k1*(q1-pop1xi) - k2*u1)*ry1
    else
        rrx1 = 0.0
        rry1 = 0.0
    end

    if pop10y < 0.0
        pop10x = q1 + lth * cos(rh - q3) + lsh * cos(lh - lk - q3) + lrf * cos(ra + rh - rk - q3) + lff * cos(la + lh + lmtp - lk - q3) - lth * cos(lh - q3) - lsh * cos(rh - rk - q3) - lrf * cos(la + lh - lk - q3)
        vop10x = u1 + lth * sin(lh - q3) * (lhp - u3 - u5) + lsh * sin(rh - rk - q3) * (rhp - rkp - u3 - u4 - u6) + lrf * sin(la + lh - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9) - lth * sin(rh - q3) * (rhp - u3 - u4) - lsh * sin(lh - lk - q3) * (lhp - lkp - u3 - u5 - u7) - lrf * sin(ra + rh - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) - lff * sin(la + lh + lmtp - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9)
        vop10y = u2 + lth * cos(lh - q3) * (lhp - u3 - u5) + lsh * cos(rh - rk - q3) * (rhp - rkp - u3 - u4 - u6) + lrf * cos(la + lh - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9) - lth * cos(rh - q3) * (rhp - u3 - u4) - lsh * cos(lh - lk - q3) * (lhp - lkp - u3 - u5 - u7) - lrf * cos(ra + rh - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) - lff * cos(la + lh + lmtp - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9)
        dp10x = pop10x - rmtpxi
        rry2 = -k7 * pop10y - k8 * abs(pop10y) * vop10y
        rrx2 = rry2 * (-k5 * dp10x - k6 * vop10x)
    else
        rrx2 = 0.0
        rry2 = 0.0
    end

    return lrx1, lry1, lrx2, lry2, rrx1, rry1, rrx2, rry2
end