using MAT, DSP, DelimitedFiles

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
lmtp = 180 .- lff + lrf .- 360
rank = 180 .- rrf + rsh
lank = 180 .- lrf + lsh
rkne = 180 .+ rsh - rth
lkne = 180 .+ lsh - lth
rhip = 180 .- rth + tor
lhip = 180 .- lth + tor
rsho = 180 .- tor + rua
lsho = 180 .- tor + lua
relb = 180 .+ rla - rua
lelb = 180 .+ lla - lua

# centre of mass velocity
vcom = data["Average"]["CoM"]["Data"]["Avg"][:, 2:3, 2] .+ [9.7 0.0]

# force
force = data["Average"]["Force"]["Data"]["Avg"][:, 2:3]

# output
header = ["time" "ht" "rhip" "lhip" "rknee" "lknee" "rankle" "lankle" "rmtp" "lmtp" "rshoulder" "lshoulder" "relbow" "lelbow" "vcmx" "vcmy"]
units = ["s" fill("deg", 1, 13) "m/s" "m/s"]
time = range(0, step=0.001, length=size(points, 1))
open("data\\matching_data.csv", "w") do io
      writedlm(io, [header; units; [time tor rhip lhip rkne lkne rank lank rmtp lmtp rsho lsho relb lelb vcom]], ',')
end
