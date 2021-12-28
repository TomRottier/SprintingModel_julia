## vector of callbacks doesn't seem to work when only one 
# condition(u, t, integrator) = u[2]
# affect!(integrator) = terminate!(integrator)
# affect_neg!(integrator) = nothing
# cb = ContinuousCallback(condition, affect!, affect_neg!, save_positions = (false, true))

## condition for callbacks - save result for each callback in `out` at appropiate index
# function condition(out, u, t, integrator)

#     # stance ends when toe q2 = 0 (mtp unlikely to ever lose contact last)
#     out[1] = u[2]

#     # second contact occurs when CoM height equal or lower to that at touchdown
#     out[2] = pocmy(integrator.sol, t) - pocmy(integrator.sol, 0.0)

#     # end of integration when stance leg touches down again
#     # also uses out[1] (q2 y position)
#     out[3] = pop2y(integrator.sol, t)
# end

# ## affect integrator when condition met and upcrossing (-ve to +ve)
# function affect!(integrator, idx)

#     if idx == 1
#         # do nothing when stance ends
#         # println("stance ended at $(integrator.t)")
#         return nothing

#     elseif idx == 2
#         # do nothing if (CoM height - initial CoM height) increases to zero
#         return nothing

#     elseif idx == 3
#         # do nothing if mtpy increases to zero
#         return nothing

#     end

# end

# ## affect integrator when condition met and downcrossing (+ve to -ve)
# function affect_neg!(integrator, idx)

#     if idx == 1 && integrator.t > 0.1 # terminate integration if q2 decreases to zero (toe begins above the ground)
#         # println("terminating due to condition 1")
#         terminate!(integrator)
#     elseif idx == 2
#         if integrator.p.virtual[3] == false # fit spline to grf relative to start of stance
#             T = integrator.t
#             _t = saved_values.t
#             _rx = [x[1] for x in saved_values.saveval]
#             _ry = [x[2] for x in saved_values.saveval]

#             length(_t) < 10 && (terminate!(integrator), return)

#             _vrx = Spline1D(_t, _rx)
#             _vry = Spline1D(_t, _ry)

#             vrx(t) = evaluate(_vrx, t - T)
#             vry(t) = evaluate(_vry, t - T)
#             integrator.p.virtual[1] = vrx
#             integrator.p.virtual[2] = vry
#             integrator.p.virtual[3] = true
#             # println("virtual stance begin at $(integrator.t)")
#         else # terminate integration once com y lower than touchdown after virtual stance
#             terminate!(integrator)
#         end
#     elseif idx == 3
#         # terminate integration if mtpy decreases to zero
#         terminate!(integrator)
#         # println("terminating due to condition 3, pop2y = $(pop2y(integrator.sol, integrator.t))")
#     end

# end

# ## callback function to pass 
# cb = VectorContinuousCallback(condition, affect!, affect_neg!, 3, save_positions = (false, false))


## end of step 1 callback, end simluation early if com gets too low
function condition_end_step1(out, u, t, integrator) # TODO: is it "safe" to use sol.u rather than u?
    out[1] = pocmy(integrator.sol, t) - pocmy(integrator.sol, 0.0) # com at touchdown height
    out[2] = pocmy(integrator.sol, t) - com_drop # com drops below certain amount - should mean unsuccessful stance phase
end
affect_step1!(integrator, idx) = nothing
affect_neg_step1!(integrator, idx) = terminate!(integrator)
end_step1 = VectorContinuousCallback(condition_end_step1, affect_step1!, affect_neg_step1!, 2, save_positions = (false, true))

## end of step 2 callback
function condition_end_step2(out, u, t, integrator)
    out[1] = u[2] # toe touches ground
    out[2] = u[2] - integrator.p.l2 * sin(u[3] - u[4] - u[5] - u[6] - u[7]) # mtp touches ground
    # not sure why pop2y(integrator.sol, t) doesn't work but it crashes julia
end
affect_step2!(integrator, idx) = nothing
affect_neg_step2!(integrator, idx) = terminate!(integrator)
end_step2 = VectorContinuousCallback(condition_end_step2, affect_step2!, affect_neg_step2!, 2, save_positions = (false, true))
