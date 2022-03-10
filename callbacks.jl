## callbacks for integration
function condition(out, u, t, int)
    # end of step 1 when com == touchdown
    out[1] = pocmy(u, t, int.sol.prob.p) - pocmy(int.sol.prob.u0, 0.0, int.sol.prob.p)
    # end of step 2 when q2 == 0 
    out[2] = u[2]
    # end of step 3 when pop2y == 0
    out[3] = pop2y(u, t, int.p)
end

function affect!(int, idx) # postive crossing (-ve to +ve)
    if idx == 1
        # do nothing
        nothing

    elseif idx == 2
        # do nothing
        nothing

    elseif idx == 3
        # do nothing
        nothing

    end
end

function affect_neg!(int, idx) # negative crossings (+ve to -ve)
    if idx == 1
        if int.sol.prob.p.virtual_force.flag == false
            # end of step 1
            # fit spline to force
            sol = int.sol
            t = sol.t[1]:0.001:int.t
            T = int.t
            splX1 = CubicSplineInterpolation(t, rx1(sol))
            splY1 = CubicSplineInterpolation(t, ry1(sol))
            splX2 = CubicSplineInterpolation(t, rx2(sol))
            splY2 = CubicSplineInterpolation(t, ry2(sol))
            vrx1(t) = splX1(t - T)
            vry1(t) = splY1(t - T)
            vrx2(t) = splX2(t - T)
            vry2(t) = splY2(t - T)

            # update parameters
            sol.prob.p.virtual_force.flag = true
            sol.prob.p.virtual_force.vrx1 = vrx1
            sol.prob.p.virtual_force.vry1 = vry1
            sol.prob.p.virtual_force.vrx2 = vrx2
            sol.prob.p.virtual_force.vry2 = vry2

        end

    elseif idx == 2
        # end of step 2
        # int.t > 0.05 ? terminate!(int) : nothing # q2 starts above the ground

    elseif idx == 3
        # end of step 2
        # terminate!(int)

    end
end


vcb = VectorContinuousCallback(condition, affect!, affect_neg!, 3, save_positions = (false, false))

# pocmy and pop2y with u
function pocmy(u, t, p)
    @unpack l7, mc, l8, md, me, mf, mg, mh, mi, ma, mb, l10, l9, l6, l4, l2, l1, l11, l3, footang = p
    @unpack ea, fa, ha, ia, gs = p
    @inbounds q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7 = u

    ea = ea(t)
    fa = fa(t)
    ha = ha(t)
    ia = ia(t)
    gs = gs(t)

    return ((q2 + ((l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg + l8 * mh + l8 * mi) / (ma + mb + mc + md + me + mf + mg + mh + mi)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + ((l10 * me + l10 * mf + l10 * mg + l10 * mh + l10 * mi + l9 * md) / (ma + mb + mc + md + me + mf + mg + mh + mi)) * (cos(q6) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + sin(q6) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)))) + ((l10 * mf + l10 * mh + me * (l10 - l9)) / (ma + mb + mc + md + me + mf + mg + mh + mi)) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) + ((l8 * mh + mf * (l8 - l7)) / (ma + mb + mc + md + me + mf + mg + mh + mi)) * (-(cos(fa)) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - sin(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3))) + ((mh * (0.5l6 + 0.5 * (l6 - l4))) / (ma + mb + mc + md + me + mf + mg + mh + mi)) * (sin(ha) * (sin(fa) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - cos(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3))) - cos(ha) * (-(cos(fa)) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - sin(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3)))) + ((mi * (l2 - l1)) / (ma + mb + mc + md + me + mf + mg + mh + mi)) * (sin(ia) * (-(cos(ha)) * (sin(fa) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - cos(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3))) - sin(ha) * (-(cos(fa)) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - sin(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3)))) - cos(ia) * (sin(ha) * (sin(fa) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - cos(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3))) - cos(ha) * (-(cos(fa)) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - sin(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3))))) + ((l11 * mi + mg * gs) / (ma + mb + mc + md + me + mf + mg + mh + mi)) * sin(q3) + 0.5 * ((l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg + 2 * l6 * mh + 2 * l6 * mi) / (ma + mb + mc + md + me + mf + mg + mh + mi)) * (cos(q4) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)))) + sin(q4) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))))) + 0.5 * ((l3 * mb) / (ma + mb + mc + md + me + mf + mg + mh + mi)) * (((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)))) * (cos(footang) * cos(q4) - sin(footang) * sin(q4)) + ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)))) * (cos(footang) * sin(q4) + sin(footang) * cos(q4)))) - ((l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg + l2 * mh + l2 * mi) / (ma + mb + mc + md + me + mf + mg + mh + mi)) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))))) - 0.5 * ((l3 * mh) / (ma + mb + mc + md + me + mf + mg + mh + mi)) * (cos(footang) * (sin(ha) * (sin(fa) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - cos(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3))) - cos(ha) * (-(cos(fa)) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - sin(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3)))) - sin(footang) * (-(cos(ha)) * (sin(fa) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - cos(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3))) - sin(ha) * (-(cos(fa)) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - sin(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3)))))
end

function pop2y(u, t, p)
    @unpack l2 = p
    @inbounds q1, q2, q3, q4, q5, q6, q7 = u

    return q2 - l2 * sin(q3 - q4 - q5 - q6 - q7)

end