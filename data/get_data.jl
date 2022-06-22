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
tor = seg_angle(_hjc, _sjc)
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
rhip = 180 .- rth + rtr
lhip = 180 .- lth + ltr
rsho = 180 .- rtr + rua
lsho = 180 .- rtr + rua
relb = 180 .+ rla - rua
lelb = 180 .+ rla - rua


# output
header = ["time" "torso" "rhip" "lhip" "rknee" "lknee" "rankle" "lankle" "rmtp" "lmtp" "rshoulder" "lshoulder" "relbow" "lelbow"]
time = range(0, step=0.001, length=size(points, 1))
open("matching_data.csv", 'w') do io
      write(io, [header; [time tor rhip lhip rkne lkne rank lank rmtp lmtp rsho lsho relb lelb]])
end



# # dx,dy
# rd1 = rMTP - rTOE; ld1 = lMTP - lTOE;
# rd2 = rAJC - rMTP; ld2 = lAJC - lMTP;
# rd3 = rKJC - rAJC; ld3 = lKJC - lAJC;
# rd4 = HJC - rKJC;  ld4 = HJC - lKJC;    # Combined HJC
# rd5 = hatCM - rHJC; ld5 = hatCM - lHJC; # HAT CoM

# # Segment angles
# rFFoot  = atan2d(rd1(:,3), rd1(:,2)); rFFoot(rFFoot < 0) = rFFoot(rFFoot < 0) + 360;
# lFFoot  = atan2d(ld1(:,3), ld1(:,2)); lFFoot(lFFoot < 0) = lFFoot(lFFoot < 0) + 360;
# rRFoot  = atan2d(rd2(:,3), rd2(:,2)); rRFoot(rRFoot < 0) = rRFoot(rRFoot < 0) + 360;
# lRFoot  = atan2d(ld2(:,3), ld2(:,2)); lRFoot(lRFoot < 0) = lRFoot(lRFoot < 0) + 360;
# rShank = atan2d(rd3(:,3), rd3(:,2)); #rShank(rShank < 0) = rShank(rShank < 0) + 360;
# lShank = atan2d(ld3(:,3), ld3(:,2)); #lShank(lShank < 0) = lShank(lShank < 0) + 360;
# rThigh = atan2d(rd4(:,3), rd4(:,2)); 
# lThigh = atan2d(ld4(:,3), ld4(:,2)); 
# rHAT = atan2d(rd5(:,3), rd5(:,2)); 
# lHAT = atan2d(ld5(:,3), ld5(:,2));

# segs = cat(2, rHAT,lHAT,rThigh,lThigh,rShank,lShank,rRFoot,lRFoot,rFFoot,lFFoot);
# segsvel = tr_diff(segs, dt);

# # Joint angles - both hips defined relative to stance side (lHAT)
# rMTPa = 180 - rFFoot + rRFoot; lMTPa = 180 - lFFoot + lRFoot;
# rAnkle = 180 - rRFoot + rShank; lAnkle = 180 - lRFoot + lShank;
# rKnee = 180 + rShank - rThigh; lKnee = 180 + lShank - lThigh;
# rHip = 180 - rThigh + lHAT; lHip = 180 - lThigh + lHAT; 
# joints =  cat(2, rHip,lHip,rKnee,lKnee,rAnkle,lAnkle,rMTPa,lMTPa);
# jointvel = tr_diff(joints, dt);


# # Output
# n = size(points, 1); m = size(joints, 2) + 3;
# out = [n m strings(1,m-2); 
#       ["Time","rHAT","lHAT","RHip","LHip","RKnee","LKnee","RAnkle","LAnkle","RMTP","LMTP"];
#       time_10 rHAT lHAT joints]; 
# writematrix(out, 'matchingData2_10.csv');