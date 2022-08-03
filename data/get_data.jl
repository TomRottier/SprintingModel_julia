using MAT, DSP

# load data 
data = matread("data\\data.mat")["dout"]
points = data["Average"]["Markers"]["Data"]["Avg"]
mnames = data["Average"]["Markers"]["Names"] |> vec
leg = data["Average"]["Information"]["Leg"]

# points
origin = zeros(size(points)[1:2])  #points(:,:,contains(mnames, [leg 'TOE']));
_rtoe = points[:, :, findfirst(mnames .== "RTOE")] - origin
_ltoe = points[:, :, findfirst(mnames .== "LTOE")] - origin
_rmtp = points[:, :, findfirst(mnames .== "RMTP")] - origin
_lmtp = points[:, :, findfirst(mnames .== "LMTP")] - origin
_rhel = points[:, :, findfirst(mnames .== "RHEL")] - origin
_lhel = points[:, :, findfirst(mnames .== "LHEL")] - origin
_rajc = points[:, :, findfirst(mnames .== "RAJC")] - origin
_lajc = points[:, :, findfirst(mnames .== "LAJC")] - origin
_rkjc = points[:, :, findfirst(mnames .== "RKJC")] - origin
_lkjc = points[:, :, findfirst(mnames .== "LKJC")] - origin
_rhjc = points[:, :, findfirst(mnames .== "RHJC")] - origin
_lhjc = points[:, :, findfirst(mnames .== "LHJC")] - origin
_rsjc = points[:, :, findfirst(mnames .== "RSJC")] - origin
_lsjc = points[:, :, findfirst(mnames .== "LSJC")] - origin
_rejc = points[:, :, findfirst(mnames .== "REJC")] - origin
_lejc = points[:, :, findfirst(mnames .== "LEJC")] - origin
_rwjc = points[:, :, findfirst(mnames .== "RWJC")] - origin
_lwjc = points[:, :, findfirst(mnames .== "LWJC")] - origin
_ltjc = points[:, :, findfirst(mnames .== "LTJC")] - origin
_utjc = points[:, :, findfirst(mnames .== "UTJC")] - origin
_apex = points[:, :, findfirst(mnames .== "APEX")] - origin
_hjc = (_rhjc + _lhjc) ./ 2
_sjc = (_rsjc + _lsjc) ./ 2

# find of vector connecting points
Δ(p1, p2) = eachcol(p2 - p1) |> collect
angle(Δ) = atand.(Δ[3], Δ[2])
seg_angle = unwrap ∘ angle ∘ Δ

# segment angles
tr = seg_angle(_hjc, _sjc)
rff = seg_angle(_rtoe, _rmtp)
lff = seg_angle(_ltoe, _lmtp)
rrf = seg_angle(_rmtp, _rajc)
lrf = seg_angle(_lmtp, _lajc)
rsh = seg_angle(_rajc, _rkjc)
lsh = seg_angle(_lajc, _lkjc)
rth = seg_angle(_rkjc, _hjc)
lth = seg_angle(_lkjc, _hjc)
rua = seg_angle(_sjc, _rejc)
lua = seg_angle(_sjc, _lejc)
rla = seg_angle(_rejc, _rwjc)
lla = seg_angle(_lejc, _lwjc)

# joint angles
rmtp = 180 .- rff + rrf
lmtp = 180 .- lff + lrf
rank = 180 .- rrf + rsh
lank = 180 .- lrf + lsh
rkne = 180 .+ rsh - rth
lkne = 180 .+ lsh - lth
rhip = 180 .- rth + tr
lhip = 180 .- lth + tr
rsho = 180 .- tr + rua
lsho = 180 .- tr + rua
relb = 180 .+ rla - rua
lelb = 180 .+ rla - rua

## forces
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
                        push!(events, [idx, -1])
                        i = idx
                        above_thresh = true
                  else
                        break # no more crossings so break from loop
                  end
            end
      end

      return events
end

# forces = readdlm("C:/Users/rottier/Desktop/laptop/Data/Treadmill/Force9.7_1000_unfiltered.csv", ',')
forces = readdlm("data/force.tsv")[:, 1:3] # only fx,fy,fz

# get events - only larger than 50 frames (0.025 s)
events = event_detection(forces[:, 3], 80)
filter!(events) do (td, to)
      return (to - td) > 50
end


# remove any data not durings events
forces_clean = similar(forces)
for i in 1:size(forces, 1)
      forces_clean[i, :] .= any(first.(events) .≤ i .≤ last.(events)) ? forces[i, :] : 0.0
end

# separate out into strides, only use six strides (12 event pairs)
events_used = events[10:end-3]
start1 = map(first, events_used[1:2:end-2])
end1 = map(first, events_used[3:2:end-1])
stride1 = [forces_clean[s:e-1, :] for (s, e) in zip(start1, end1)]
start2 = map(first, events_used[2:2:end-1])
end2 = map(first, events_used[4:2:end])
stride2 = [forces_clean[s:e-1, :] for (s, e) in zip(start2, end2)]



# output
header = ["time" "torso" "rhip" "lhip" "rknee" "lknee" "rankle" "lankle" "rmtp" "lmtp" "rshoulder" "lshoulder" "relbow" "lelbow"]
time = range(0, step=0.001, length=size(points, 1))
open("matching_data.csv", 'w') do io
      write(io, [header; [time tor rhip lhip rkne lkne rank lank rmtp lmtp rsho lsho relb lelb]])
end
