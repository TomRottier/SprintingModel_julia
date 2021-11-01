# # condition for callbacks - save result for each callback in out at appropiate index
# function condition(out, u, t, integrator)

#     # stance ends when toe q2 ≥ 0 (mtp unlikely to ever lose contact last)
#     out[1] = u[2]

# end

# # affect integrator when condition met and upcrossing (-ve to +ve)
# function affect!(integrator, idx)
   
#     if idx == 1
#         # terminate simulation when stance ends
#         terminate!(integrator)
#     end

# end

# # affect integrator when condition met and downcrossing
# function affect_neg!(integrator, idx)

#     if idx == 1
#         return nothing
#     end
    
# end

# # callback function to pass 
# cb = VectorContinuousCallback(condition, affect!, affect_neg!, 1, save_positions=(false, true))

condition(u, t, integrator) = u[2]
affect!(integrator) = terminate!(integrator)
affect_neg!(integrator) = nothing
cb = ContinuousCallback(condition, affect!, affect_neg!, save_positions=(false, true))