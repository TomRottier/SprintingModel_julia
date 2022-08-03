using MAT, DSP, Interpolations, Statistics

include("functions.jl")

# load data from processed c3d file (by readC3D.m)
data = matread("data/c3d_processed.mat")["din"]

# get all data on same timebase
hz = 1000
kinematics_f = 250
forceplate_f = 2000
markers = cat([change_timebase(d, kinematics_f, hz) for d in eachslice(data["Markers"]["Data"], dims=3)]..., dims=3)
angles = cat([change_timebase(d, kinematics_f, hz) for d in eachslice(data["ModelOutputs"]["Angles"]["Data"], dims=3)]..., dims=3)
forces = change_timebase(data["ForcePlate"]["Data"], forceplate_f, hz)

# find contacts
events = event_detection(forces[:, 3], 10)
filter!(x -> x[2] - x[1] > 50, events) # only events larger than 50 frames, removes noise from aerial phase

# filter data
force_filt = digitalfilter(Lowpass(50, fs=1000), Butterworth(4))
kinematics_filt = digitalfilter(Lowpass(15, fs=250), Butterworth(4))
forces = filtfilt(force_filt, forces)
angles = filtfilt(kinematics_filt, angles)
markers = filtfilt(kinematics_filt, markers)

# clean force data
forces = clean_forces(forces, events)

# get start and end indicies of strides used for average
used = events[11:end-3]
starts = map(first, used[1:2:end-1])
stops = map(first, used[3:2:end])

# for individual steps
used = events[11:end-3]
starts = first.(used[1:2:end])
stops = first.(used[2:2:end])

# separate out into strides
all_strides = map(zip(starts, stops)) do (start, stop)
    Dict(
        # :angles => angles[start:stop-1, :, :],
        :markers => markers[start:stop-1, :, :],
        :forces => forces[start:stop-1, 1:3]
    )
end

# get average stride
strides_norm = map(all_strides) do stride
    markers_norm = cat([normalise_data(d, hz=hz) for d in eachslice(stride[:markers], dims=3)]..., dims=3)
    # angles_norm = cat([normalise_data(d, hz=hz) for d in eachslice(stride[:angles], dims=3)]..., dims=3)
    forces_norm = normalise_data(stride[:forces], hz=hz)
    Dict(
        # :angles => angles_norm,
        :markers => markers_norm,
        :forces => forces_norm
    )
end

avg_stride = Dict(
    :forces => mapreduce(x -> x[:forces], +, strides_norm) ./ length(strides_norm),
    # :angles => mapreduce(x -> x[:angles], +, strides_norm) ./ length(strides_norm),
    :markers => mapreduce(x -> x[:markers], +, strides_norm) ./ length(strides_norm)
)

# interpolate back to real time
lengths = map(x -> size(x[:forces], 1), all_strides) |> mean
step_times = range(0, lengths / 1000, step=0.001)
tnorm = (0:0.001:1) .* step_times[end]
spl_fy = CubicSplineInterpolation(tnorm, avg_stride[:forces][:, 2])
spl_fz = CubicSplineInterpolation(tnorm, avg_stride[:forces][:, 3])

avg_forces = hcat(spl_fy.(step_times), spl_fz.(step_times))