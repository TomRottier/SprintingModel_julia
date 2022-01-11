## end of step 1 callback, end simluation early if com gets too low
# function condition_end_step1(out, u, t, integrator) # TODO: is it "safe" to use sol.u rather than u?
#     out[1] = pocmy(integrator.sol, t) - pocmy(integrator.sol, 0.0) # com at touchdown height
#     out[2] = pocmy(integrator.sol, t) - com_drop # com drops below certain amount - should mean unsuccessful stance phase
# end
# affect_step1!(integrator, idx) = nothing
# affect_neg_step1!(integrator, idx) = terminate!(integrator)
# end_step1 = VectorContinuousCallback(condition_end_step1, affect_step1!, affect_neg_step1!, 2, save_positions = (false, true))

# no checks during step 1
condition_end_step1(u, t, integrator) = pocmy(integrator.sol, t) - pocmy(integrator.sol, 0.0) # com at touchdown
affect_step1!(integrator) = nothing
affect_neg_step1!(integrator) = terminate!(integrator)
end_step1 = ContinuousCallback(condition_end_step1, affect_step1!, affect_neg_step1!, save_positions = (false, false))

## end of step 2 callback
function condition_end_step2(out, u, t, integrator)
    out[1] = u[2] # toe touches ground
    out[2] = u[2] - integrator.p.l2 * sin(u[3] - u[4] - u[5] - u[6] - u[7]) # mtp touches ground
    # not sure why pop2y(integrator.sol, t) doesn't work but it crashes julia
end
affect_step2!(integrator, idx) = nothing
affect_neg_step2!(integrator, idx) = terminate!(integrator)
end_step2 = VectorContinuousCallback(condition_end_step2, affect_step2!, affect_neg_step2!, 2, save_positions = (false, false))
