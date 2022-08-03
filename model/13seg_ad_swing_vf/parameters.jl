# Automatically generated
@with_kw struct Params{T,F1,F2,F3,F4}
    z::Vector{T}
    footang::T
    g::T
    iff::T
    ihat::T
    ila::T
    irf::T
    ish::T
    ith::T
    iua::T
    k1::T
    k2::T
    k3::T
    k4::T
    k5::T
    k6::T
    k7::T
    k8::T
    lff::T
    lffo::T
    lhat::T
    lhato::T
    lla::T
    llao::T
    mtpxi::T
    lrf::T
    lrff::T
    lrffo::T
    lrfo::T
    lsh::T
    lsho::T
    lth::T
    ltho::T
    toexi::T
    lua::T
    luao::T
    mff::T
    mhat::T
    mla::T
    mrf::T
    msh::T
    mth::T
    mtpb::T
    mtpk::T
    mua::T
    u4::T
    u5::T
    u6::T
    u7::T
    u8::T
    u9::T
    u10::T
    u11::T
    u12::T
    u13::T
    vrx1::F1
    vry1::F2
    vrx2::F3
    vry2::F4

end

# initialise with constant values
function Params(footang, g, iff, ihat, ila, irf, ish, ith, iua, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lhato, lla, llao, lmtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, ltoexi, lua, luao, mff, mhat, mla, mrf, msh, mth, mtpb, mtpk, mua)
    z = Vector{Float64}(undef, 1287)
    vrx1(t) = 0.0
    vry1(t) = 0.0
    vrx2(t) = 0.0
    vry2(t) = 0.0

    u4 = 0.0
    u5 = 0.0
    u6 = 0.0
    u7 = 0.0
    u8 = 0.0
    u9 = 0.0
    u10 = 0.0
    u11 = 0.0
    u12 = 0.0
    u13 = 0.0
    z[546] = g * msh
    z[543] = g * mff
    z[1159] = lffo * z[543]
    z[545] = g * mrf
    z[27] = cos(footang)
    z[544] = g * mla
    z[1002] = llao * mla
    z[28] = sin(footang)
    z[90] = lff - lffo
    z[91] = lrf - 0.5lrfo
    z[92] = lsh - lsho
    z[93] = lth - ltho
    z[94] = mhat + 2mff + 2mla + 2mrf + 2msh + 2mth + 2mua
    z[95] = (lhato * mhat + 2 * lhat * mla + 2 * lhat * mua) / z[94]
    z[96] = (lff * mff + lff * mhat + lffo * mff + 2 * lff * mla + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth + 2 * lff * mua) / z[94]
    z[97] = (llao * mla) / z[94]
    z[98] = (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mrf + 4 * lrf * mla + 4 * lrf * msh + 4 * lrf * mth + 4 * lrf * mua) / z[94]
    z[99] = (lrffo * mrf) / z[94]
    z[100] = (lsh * mff + lsh * mhat + lsh * mrf + lsh * msh + lsho * msh + 2 * lsh * mla + 2 * lsh * mth + 2 * lsh * mua) / z[94]
    z[101] = (lth * mff + lth * mhat + lth * mrf + lth * msh + lth * mth + ltho * mth + 2 * lth * mla + 2 * lth * mua) / z[94]
    z[102] = (lua * mla + luao * mua) / z[94]
    z[103] = (mff * z[90]) / z[94]
    z[104] = (lrf * mff + mrf * z[91]) / z[94]
    z[105] = (lsh * mff + lsh * mrf + msh * z[92]) / z[94]
    z[106] = (lth * mff + lth * mrf + lth * msh + mth * z[93]) / z[94]
    z[542] = g * mhat
    z[547] = g * mth
    z[548] = g * mua
    z[578] = lsh - z[100]
    z[579] = lth - z[101]
    z[580] = lff - z[96]
    z[581] = 2lrf - z[98]
    z[674] = lhat - z[95]
    z[675] = lua - z[102]
    z[680] = z[96] - lff
    z[681] = 0.5 * z[98] - 0.5lrfo
    z[682] = 0.5 * z[99] - 0.5lrffo
    z[872] = lsh - z[105]
    z[873] = lth - z[106]
    z[874] = lrf - z[104]
    z[899] = 0.5 * z[98] - lrf
    z[900] = z[100] - lsh
    z[901] = z[101] - lth
    z[902] = (lrf - 0.5lrfo) - z[104]
    z[949] = 2 * z[681] + 2 * z[27] * z[682]
    z[951] = 2 * z[682] + 2 * z[27] * z[681]
    z[963] = z[27] * z[682]
    z[965] = z[27] * z[902]
    z[992] = lffo * mff
    z[1015] = lff * mrf
    z[1017] = lrfo * mrf
    z[1019] = lrffo * mrf
    z[1048] = luao * mua
    z[1092] = mrf * z[91]
    z[1103] = lsh * mrf
    z[1120] = msh * z[92]
    z[1135] = mth * z[93]
    z[1161] = z[93] * z[547]
    z[1164] = z[92] * z[546]
    z[1169] = luao * z[548]
    z[1172] = llao * z[544]
    z[1200] = ihat + 2iff + 2ila + 2irf + 2ish + 2ith + 2iua + mff * lffo^2
    z[1201] = lrffo^2 + lrfo^2 + 4 * lff^2 + 2 * lrffo * lrfo * z[27]
    z[1202] = lff * lrffo
    z[1203] = lff * lrfo
    z[1204] = lrffo^2 + 4 * z[91]^2
    z[1205] = lrffo * z[27] * z[91]
    z[1207] = lrffo * z[27]
    z[1208] = lrfo * z[27]
    z[1209] = lrffo * z[28]
    z[1210] = lrfo * z[28]
    z[1211] = z[27] * z[91]
    z[1212] = z[28] * z[91]
    z[1214] = iff + irf + ish + ith
    z[1215] = lrffo^2
    z[1216] = z[91]^2
    z[1221] = iff + irf + ish + ith + mff * lffo^2
    z[1226] = iff + irf + ish
    z[1227] = lsh * z[91]
    z[1228] = lrffo * lsh
    z[1233] = iff + irf + ish + mff * lffo^2
    z[1238] = iff + irf
    z[1239] = (lrffo^2 + 4 * z[91]^2) - 4 * lrffo * z[27] * z[91]
    z[1244] = iff + irf + mff * lffo^2
    z[1249] = ila + iua

    return Params(z, footang, g, iff, ihat, ila, irf, ish, ith, iua, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lhato, lla, llao, mtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, toexi, lua, luao, mff, mhat, mla, mrf, msh, mth, mtpb, mtpk, mua, u4, u5, u6, u7, u8, u9, u10, u11, u12, u13, vrx1, vry1, vrx2, vry2)
end
