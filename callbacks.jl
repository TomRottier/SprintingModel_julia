## callbacks for integration
function condition(out, t, integrator)
    # end of step 1 when com == touchdown
    out[1] = pocmy(integrator.sol, t) - pocmy(integrator.sol, 0.0) 
    # end of step 2 when q2 == 0 
    out[2] == q2
    # end of step 3 when pop2y == 0
    out[3] == pop27(integrator.sol, t)
end

function affect!(integrator, idx) # postive crossing (-ve to +ve)
    if out == 1
        # do nothing
        nothing

    elseif out == 2
        # do nothing
        nothing

    elseif out == 3
        # do nothing
        nothing

    end
end

function affect_neg!(integrator, idx) # negative crossings (+ve to -ve)
    if out == 1
        # end of step 1
        # fit spline to force
        sol = integrator.sol
        T = integrator.t
        splX = Spline1D(sol.t, rx(sol))
        splY = Spline1D(sol.t, ry(sol))
        vrx(t) = evaluate(splX, t - T)
        vry(t) = evaluate(splY, t - T)

        # update parameters
        p.vrx = vrx
        p.vry = vry


    elseif out == 2
        # end of step 2
        terminate!(integrator)

    elseif out == 3
        # end of step 2
        terminate!(integrator)

    end
end


vcb = VectorContinuousCallback(condition, affect!, affect_neg!, 3, save_positions = (false, true))
