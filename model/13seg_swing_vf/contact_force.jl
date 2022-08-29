function contact_forces(u, p, t)
    @unpack k1, k2, k3, k4, k5, k6, k7, k8, lff, mtpxi, toexi = p
    @inbounds q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7 = u

    # specified variables

    # grf
    pop2y = q2 + lff * sin(q3 + q5 - q4 - q6 - q7)

    if q2 < 0.0
        dp1x = q1 - toexi
        ry1 = -k3 * q2 - k4 * abs(q2) * u2
        rx1 = ry1 * (-k1 * dp1x - k2 * u1) # (-k1*(q1-pop1xi) - k2*u1)*ry1
    else
        rx1 = 0.0
        ry1 = 0.0
    end

    if pop2y < 0.0
        pop2x = q1 + lff * cos(q3 + q5 - q4 - q6 - q7)
        vop2x = u1 - lff * sin(q3 + q5 - q4 - q6 - q7) * (u3 + u5 - u4 - u6 - u7)
        vop2y = u2 + lff * cos(q3 + q5 - q4 - q6 - q7) * (u3 + u5 - u4 - u6 - u7)
        dp2x = pop2x - mtpxi
        ry2 = -k7 * pop2y - k8 * abs(pop2y) * vop2y
        rx2 = ry2 * (-k5 * dp2x - k6 * vop2x)
    else
        rx2 = 0.0
        ry2 = 0.0
    end


    # virtual grf
    vrx1::Float64 = p.vrx1(t)
    vry1::Float64 = p.vry1(t)
    vrx2::Float64 = p.vrx2(t)
    vry2::Float64 = p.vry2(t)

    return SA[rx1, ry1, rx2, ry2, vrx1, vry1, vrx2, vry2]
end

contact_forces(sol, t) = contact_forces(sol(t), sol.prob.p, t)
contact_forces(sol) = [contact_forces(sol, t) for t in sol.t]