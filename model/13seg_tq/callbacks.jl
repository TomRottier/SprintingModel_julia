## callbacks for integration
function condition(out, u, t, int)
    # swing mtp touches down
    out[1] = pop10y(u, int.sol.prob.p, t)

    # swing toe touches down
    out[2] = pop11y(u, int.sol.prob.p, t)


    return nothing
end

function affect!(int, idx)
    if idx == 1
        nothing
    elseif idx == 2
        nothing
    end
end

function affect_neg!(int, idx)
    if idx == 1
        terminate!(int)
    elseif idx == 2
        terminate!(int)
    end
end

vcb = VectorContinuousCallback(condition, affect!, affect_neg!, 2)
