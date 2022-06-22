# inertia parameters from McErlain-Naylor thesis
struct Inertia
    length::Float64
    mass::Float64
    com_loc::Float64 # from proximal joint
    moi::Float64 # about com
end
unpack(s::Inertia) = s.length, s.mass, s.com_loc, s.moi

mcerlain_inertia = [0.085 0.477 0.035 0.0003
    0.139 2.293 0.063 0.0059
    0.453 10.542 0.192 0.1584
    0.447 25.073 0.189 0.4245
    0.418 24.433 0.323 0.5218
    0.182 10.860 0.085 0.0701
    0.269 5.611 0.136 0.0344
    0.323 6.323 0.138 0.0588
    0.469 3.710 0.168 0.0568]

# half masses and inertias to get seperate limbs then scale by change in body mass
mcerlain_inertia_scaled = copy(mcerlain_inertia)
mcerlain_inertia_scaled[[1:4; [8, 9]], [2, 4]] ./= 2
mcerlain_inertia_scaled[[1:4; [8, 9]], [2, 4]] .*= 1.02

forefoot = Inertia(mcerlain_inertia_scaled[1, :]...)
rearfoot = Inertia(mcerlain_inertia_scaled[2, :]...)
shank = Inertia(mcerlain_inertia_scaled[3, :]...)
thigh = Inertia(mcerlain_inertia_scaled[4, :]...)
lower_trunk = Inertia(mcerlain_inertia_scaled[5, :]...)
upper_trunk = Inertia(mcerlain_inertia_scaled[6, :]...)
head_neck = Inertia(mcerlain_inertia_scaled[7, :]...)
upper_arm = Inertia(mcerlain_inertia_scaled[8, :]...)
lower_arm = Inertia(mcerlain_inertia_scaled[9, :]...)

# combined torso segments length, angles relative to N frame, 90 deg equal vertical, only taking component in N2> direction
combined_length(q0, q1, q2, llt, lut, lh) = (lh * sin(q2) + llt * sin(q0) + lut * sin(q1))
head_trunk_length = combined_length(π / 2, π / 2, π / 2, lower_trunk.length, upper_trunk.length, head_neck.length) # all segments alligned

# combined torso mass
head_trunk_mass = lower_trunk.mass + upper_trunk.mass + head_neck.mass

# calculate inertia for combined torso segments, angles relative to N frame, 90 deg equal vertical
function combined_moi(q0, q1, q2, lower_trunk, upper_trunk, head_neck)
    llt, mlt, llto, ilt = unpack(lower_trunk)
    lut, mut, luto, iut = unpack(upper_trunk)
    lh, mh, lho, ih = unpack(head_neck)
    return ih + ilt + iut + mlt * ((llto - (llt * mh + llt * mut + llto * mlt) / (mh + mlt + mut))^2 + (lho^2 * mh^2 + (lut * mh + luto * mut)^2 + 2 * lho * mh * (lut * mh + luto * mut) * cos(q1 - q2) + 2 * lho * mh * (llt * mh + llt * mut + llto * mlt - llto * (mh + mlt + mut)) * cos(q0 - q2) + 2 * (lut * mh + luto * mut) * (llt * mh + llt * mut + llto * mlt - llto * (mh + mlt + mut)) * cos(q0 - q1)) / (mh + mlt + mut)^2) + mut * ((luto - (lut * mh + luto * mut) / (mh + mlt + mut))^2 + (llt - (llt * mh + llt * mut + llto * mlt) / (mh + mlt + mut))^2 + 2 * (luto - (lut * mh + luto * mut) / (mh + mlt + mut)) * (llt - (llt * mh + llt * mut + llto * mlt) / (mh + mlt + mut)) * cos(q0 - q1) + lho * mh * (lho * mh + 2 * (lut * mh + luto * mut - luto * (mh + mlt + mut)) * cos(q1 - q2) + 2 * (llt * mh + llt * mut + llto * mlt - llt * (mh + mlt + mut)) * cos(q0 - q2)) / (mh + mlt + mut)^2) - mh * (2 * lho * (-1 + mh / (mh + mlt + mut)) * (lut - (lut * mh + luto * mut) / (mh + mlt + mut)) * cos(q1 - q2) + 2 * lho * (-1 + mh / (mh + mlt + mut)) * (llt - (llt * mh + llt * mut + llto * mlt) / (mh + mlt + mut)) * cos(q0 - q2) - lho^2 * (-1 + mh / (mh + mlt + mut))^2 - (lut - (lut * mh + luto * mut) / (mh + mlt + mut))^2 - (llt - (llt * mh + llt * mut + llto * mlt) / (mh + mlt + mut))^2 - 2 * (lut - (lut * mh + luto * mut) / (mh + mlt + mut)) * (llt - (llt * mh + llt * mut + llto * mlt) / (mh + mlt + mut)) * cos(q0 - q1))
end
head_trunk_moi = combined_moi(π / 2, π / 2, π / 2, lower_trunk, upper_trunk, head_neck) # all segments alligned

# calculate com location for combined torso segments, angles relative to N frame, 90 deg equal vertical, only taking component in N2> direction
function combined_comloc(q0, q1, q2, lower_trunk, upper_trunk, head_neck)
    llt, mlt, llto, ilt = unpack(lower_trunk)
    lut, mut, luto, iut = unpack(upper_trunk)
    lh, mh, lho, iht = unpack(head_neck)
    return (lho * mh * sin(q2) + (lut * mh + luto * mut) * sin(q1) + (llt * mh + llt * mut + llto * mlt) * sin(q0)) / (mh + mlt + mut)
end
head_trunk_comloc = combined_comloc(π / 2, π / 2, π / 2, lower_trunk, upper_trunk, head_neck) # all segments alligned


# combine torso segments
head_trunk = Inertia(head_trunk_length, head_trunk_mass, head_trunk_comloc, head_trunk_moi)

# rest of values: footang,g,k1:k8,mtpb,mtpk,ltoexi,rtoexi,lmtpxi,rmtpxi,lrffo,lrff
rest_vals = [19.58, -9.81, 9.74E-03, 1155.282193, 14435.41606, 4.75E-02, 323.3806231, 2.15E-07, 149018.3201, 66196.28963, 0.701068939, 6.463830463, 0.083614267, 0.0, 0.0, 0.0, 0.121, 0.222]
# output
names = ["lff", "mff", "lffo", "iff", "lrf", "mrf", "lrfo", "irf", "lsh", "msh", "lsho", "ish", "lth", "mth", "ltho", "ith", "lht", "mht", "lhto", "iht", "lua", "mua", "luao", "iua", "lla", "mla", "llao", "ila", "footang", "g", "k1", "k2", "k3", "k4", "k5", "k6", "k7", "k8", "mtpb", "mtpk", "ltoexi", "rtoexi", "lmtpxi", "rmtpxi", "lrffo", "lrff"]
units = [repeat(["m", "kg", "m", "kg.m^2"], 7); "deg"; "m/s^2"; "m^-1"; "s/m"; "N/m"; "N.s/m"; "m^-1"; "s/m"; "N/m"; "N.s/m"; "N.m.s/rad"; "N.m/rad"; fill("m", 4); "m"; "m"]
values = [unpack(forefoot)...; unpack(rearfoot)...; unpack(shank)...; unpack(thigh)...; unpack(head_trunk)...; unpack(upper_arm)...; unpack(lower_arm)...; rest_vals]

# output
open("model\\13seg_ad\\parameters.csv", "w") do io
    writedlm(io, [["parameter" "unit" "value"]; names units values], ',')
end