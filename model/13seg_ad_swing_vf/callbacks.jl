## callbacks for integration
condition_step1(u, t, int) = pocmy(u, int.p, t) - pocmy(u, int.p, 0.0)
affect_step1!(int) = nothing # println("+ve crossing")
affect_neg_step1!(int) = terminate!(int)
cb1 = ContinuousCallback(condition_step1, affect_step1!, affect_neg_step1!, save_positions=(false, true), repeat_nudge=1 // 10)

condition_step2(u, t, int) = u[2]
affect_step2!(int) = nothing
affect_neg_step2!(int) = terminate!(int) # end when foot touches down again
cb2 = ContinuousCallback(condition_step2, affect_step2!, affect_neg_step2!; save_positions=(false, true), repeat_nudge=1 // 10)