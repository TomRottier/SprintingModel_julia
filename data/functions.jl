function event_detection(data, threshold)
    i = 1
    n = size(data, 1)
    events = []

    # check if starting above or below threshold
    findfirst(data .> threshold) == 1 ? above_thresh = true : above_thresh = false
    above_thresh && push!(events, [-1, -1])

    while i < n
        if above_thresh
            I = findfirst(data[i:n] .< threshold)
            if I !== nothing
                idx = (i - 1) + I # actual index into data
                events[end][2] = idx # add to output
                i = idx # update starting point
                above_thresh = false
            else
                break # no more crossings so break from loop
            end

        else
            I = findfirst(data[i:n] .> threshold)
            if I !== nothing
                idx = (i - 1) + I
                push!(events, [idx, -1]) # idx before crossing?
                i = idx
                above_thresh = true
            else
                break # no more crossings so break from loop
            end
        end
    end

    return events
end

# clean force data by setting any points outside of events to zero
function clean_forces(data, events)
    clean = similar(data)
    for i in 1:size(data, 1)
        clean[i, :] .= any(first.(events) .≤ i .≤ last.(events)) ? data[i, :] : 0.0
    end

    return clean
end

# express data in new timebase
function change_timebase(data, fold, fnew)
    nold = size(data, 1)
    nnew = nold * (fnew / fold) |> Int
    old_time = range(0, length=nold, step=(1 / fold))
    new_time = range(0, length=nnew, step=(1 / fnew))

    out = similar(data, (length(new_time), size(data, 2)))

    for (i, d) in enumerate(eachcol(data))
        spl = CubicSplineInterpolation(old_time, d, extrapolation_bc=Linear())
        out[:, i] = spl(new_time)
    end

    return out
end

function normalise_data(time, data)
    tend = time[end]
    tnorm = time / tend * 100
    tpc = 0:0.1:100

    dnorm = similar(data, length(tpc), size(data, 2))

    for (i, d) in enumerate(eachcol(data))
        spl = CubicSplineInterpolation(tnorm, d, extrapolation_bc=Linear())
        dnorm[:, i] = spl(tpc)
    end

    return dnorm
end

normalise_data(data; hz) = normalise_data(range(0, length=size(data, 1), step=(1 / hz)), data)
