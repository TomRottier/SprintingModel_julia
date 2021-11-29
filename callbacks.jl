## vector of callbacks doesn't seem to work when only one 
# condition(u, t, integrator) = u[2]
# affect!(integrator) = terminate!(integrator)
# affect_neg!(integrator) = nothing
# cb = ContinuousCallback(condition, affect!, affect_neg!, save_positions = (false, true))

## condition for callbacks - save result for each callback in `out` at appropiate index
function condition(out, u, t, integrator)

    # stance ends when toe q2 = 0 (mtp unlikely to ever lose contact last)
    out[1] = u[2]

    # second contact occurs when CoM height equal or lower to that at touchdown
    out[2] = pocmy(integrator.sol, t) - saved_values.saveval[1][1]

    # end of integration when stance leg touches down again
    # also uses out[1] (q2 y position)
    out[3] = pop2y(integrator.sol, t)
end

## affect integrator when condition met and upcrossing (-ve to +ve)
function affect!(integrator, idx)

    if idx == 1
        # fit spline to cmy-grf values when stance ends
        # when stance ends fit function to pocmy-grf 
        cmy = [x[1] for x in saved_values.savevals]
        rx = [x[2] for x in saved_values.savevals]
        ry = [x[3] for x in saved_values.savevals]

        _vrx = Spline1D(cmy, rx)
        _vry = Spline1D(cmy, ry)

        vrx(s) = evaluate(_vrx, s)
        vry(s) = evaluate(_vry, s)

        integrator.prob.p.vrx = vrx
        integrator.prob.p.vry = vry

    elseif idx == 2
        # do nothing if (CoM height - initial CoM height) increases to zero
        return nothing

    elseif idx == 3
        # do nothing if q2 increases to zero
        return nothing

    end

end

## affect integrator when condition met and downcrossing (+ve to -ve)
function affect_neg!(integrator, idx)

    if idx == 1
        # terminate integration if q2 decreases to zero
        terminate!(integrator)

    elseif idx == 2
        # when virtual stance occuring set virtual_stance to true 
        integrator.prob.p.virtual_stance = true

    elseif idx == 3
        # terminate integration if mtpy decreases to zero
        terminate!(integrator)
    end

end

## saving callback
# function to calculate saved values
function save_func(u, t, integrator)
    @inbounds q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7 = u
    @unpack k1, k2, k3, k4, k5, k6, k7, k8, l2, pop1xi, pop2xi = integrator.prob.p

    pop2y = q2 - l2 * sin(q3 - q4 - q5 - q6 - q7)

    # grf
    if q2 < 0.0
        dp1x = q1 - pop1xi
        ry1 = -k3 * q2 - k4 * abs(q2) * u2
        rx1 = -ry1 * (k1 * dp1x + k2 * u1)

    else
        rx1 = 0.0
        ry1 = 0.0
    end

    if pop2y < 0.0
        pop2x = q1 - l2 * cos(q3 - q4 - q5 - q6 - q7)
        vop2x = u1 - l2 * sin(q3 - q4 - q5 - q6 - q7) * (u3 - u4 - u5 - u6 - u7)
        vop2y = u2 - l2 * cos(q3 - q4 - q5 - q6 - q7) * (u3 - u4 - u5 - u6 - u7)
        dp2x = pop2x - pop2xi
        ry2 = -k7 * pop2y - k8 * abs(pop2y) * vop2y
        rx2 = -ry2 * (k5 * dp2x + k6 * vop2x)
    else
        rx2 = 0.0
        ry2 = 0.0
    end

    rx = rx1 + rx2
    ry = ry1 + ry2

    # pocmy
    cmy = pocmy(integrator.sol, t)

    return (cmy, rx, ry)
end
# saved values
const saved_values = SavedValues(Float64, Tuple{Float64,Float64,Float64})
# would prefer to stop the saving callback once takeoff occurs but not sure if possible
scb = SavingCallback(save_func, saved_values, saveat = 0:0.001:0.1)

## callback function to pass 
cb = VectorContinuousCallback(condition, affect!, affect_neg!, 3, save_positions = (false, true))
cbs = CallbackSet(cb, scb)
