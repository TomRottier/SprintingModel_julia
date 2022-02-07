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
            T = int.t
            splX = Spline1D(sol.t, rx(sol))
            splY = Spline1D(sol.t, ry(sol))
            vrx(t) = evaluate(splX, t - T)
            vry(t) = evaluate(splY, t - T)

            # update parameters
            sol.prob.p.virtual_force.flag = true
            sol.prob.p.virtual_force.vrx = vrx
            sol.prob.p.virtual_force.vry = vry 

        end

    elseif idx == 2
        # end of step 2
        int.t > 0.05 ? terminate!(int) : nothing # q2 starts above the ground

    elseif idx == 3
        # end of step 2
        terminate!(int)

    end
end


vcb = VectorContinuousCallback(condition, affect!, affect_neg!, 3, save_positions = (false, false))

# pocmy and pop2y with u
function pocmy(u, t, p)
    @unpack l7, mc, l8, md, me, mf, mg, mt, l10, l9, l12, l4, mb, l6, l3, footang, l1, ma, l2 = p
    @unpack ea, fa, gs = p
    @inbounds q1, q2, q3, q4, q5, q6, q7 = u

    ea = ea(t); fa = fa(t); gs = gs(t)

    return (q2 + ((l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg) / mt) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + ((l10 * me + l10 * mf + l10 * mg + l9 * md) / mt) * (cos(q6) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + sin(q6) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)))) + ((l10 * mf + me * (l10 - l9)) / mt) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) + ((l12 * mf) / mt) * (-(cos(fa)) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - sin(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3))) + ((mg * gs) / mt) * sin(q3) + 0.5 * ((l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg) / mt) * (cos(q4) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)))) + sin(q4) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))))) + 0.5 * ((l3 * mb) / mt) * (((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)))) * (cos(footang) * cos(q4) - sin(footang) * sin(q4)) + ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)))) * (cos(footang) * sin(q4) + sin(footang) * cos(q4)))) - ((l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg) / mt) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))))
end

function pop2y(u,t,p)
    @unpack l2 = p
    @inbounds q1, q2, q3, q4, q5, q6, q7 = u

    return q2 - l2 * sin(q3 - q4 - q5 - q6 - q7)

end