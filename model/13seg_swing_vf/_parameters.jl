# Automatically generated
struct Params{T}
    z::Vector{T}
    ae::T
    af::T
    footang::T
    g::T
    he::T
    hf::T
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
    ke::T
    kf::T
    lff::T
    lffo::T
    lhat::T
    lhato::T
    lla::T
    llao::T
    lrf::T
    lrff::T
    lrffo::T
    lrfo::T
    lsh::T
    lsho::T
    lth::T
    ltho::T
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
    mtpxi::T
    mua::T
    toexi::T
    u8::T
    u9::T
    u10::T
    u11::T
    u12::T
    u13::T
    u14::T

end

# initialise with constant values
function Params(ae, af, footang, g, he, hf, iff, ihat, ila, irf, ish, ith, iua, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, lff, lffo, lhat, lhato, lla, llao, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, lua, luao, mff, mhat, mla, mrf, msh, mth, mtpb, mtpk, mtpxi, mua, toexi)
    z = Vector{Float64}(undef, 1312)
    u8 = 0
    u9 = 0
    u10 = 0
    u11 = 0
    u12 = 0
    u13 = 0
    u14 = 0
    z[518] = g * msh
    z[517] = g * mrf
    z[27] = cos(footang)
    z[516] = g * mla
    z[1157] = llao * z[516]
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
    z[514] = g * mhat
    z[515] = g * mff
    z[519] = g * mth
    z[520] = g * mua
    z[546] = lff - z[96]
    z[547] = lsh - z[100]
    z[548] = lth - z[101]
    z[549] = 2lrf - z[98]
    z[642] = lhat - z[95]
    z[643] = lua - z[102]
    z[648] = z[96] - lff
    z[649] = 0.5 * z[98] - 0.5lrfo
    z[650] = 0.5 * z[99] - 0.5lrffo
    z[840] = lsh - z[105]
    z[841] = lth - z[106]
    z[842] = lrf - z[104]
    z[867] = 0.5 * z[98] - lrf
    z[868] = z[100] - lsh
    z[869] = z[101] - lth
    z[870] = (lrf - 0.5lrfo) - z[104]
    z[917] = 2 * z[649] + 2 * z[27] * z[650]
    z[919] = z[27] * z[649]
    z[931] = z[27] * z[650]
    z[933] = z[27] * z[870]
    z[959] = lffo * mff
    z[971] = llao * mla
    z[983] = lff * mrf
    z[986] = lrfo * mrf
    z[987] = lrffo * mrf
    z[1019] = luao * mua
    z[1068] = mrf * z[91]
    z[1080] = lsh * mrf
    z[1099] = msh * z[92]
    z[1116] = mth * z[93]
    z[1142] = lffo * z[515]
    z[1147] = lff * z[517]
    z[1149] = z[93] * z[519]
    z[1151] = z[92] * z[518]
    z[1154] = luao * z[520]
    z[1193] = ihat + 2iff + 2ila + 2irf + 2ish + 2ith + 2iua + mff * lffo^2
    z[1194] = lrffo^2 + lrfo^2 + 4 * lff^2 + 2 * lrffo * lrfo * z[27]
    z[1195] = lff * lrffo
    z[1196] = lff * lrfo
    z[1197] = lrffo^2 + 4 * z[91]^2
    z[1198] = lrffo * z[27] * z[91]
    z[1200] = iff + irf + ish + mff * lffo^2
    z[1202] = mff * lffo^2
    z[1206] = lrffo * z[28]
    z[1207] = lrfo * z[28]
    z[1208] = lrffo * z[27]
    z[1209] = z[27] * z[91]
    z[1210] = z[28] * z[91]
    z[1213] = iff + irf + ish + ith + mff * lffo^2
    z[1215] = iff + irf + mff * lffo^2
    z[1217] = iff + mff * lffo^2
    z[1227] = iff + mff * lffo^2 + mrf * lff^2
    z[1230] = iff + irf + ish + ith
    z[1239] = iff + irf + ish
    z[1240] = lsh * z[91]
    z[1241] = lrffo * lsh
    z[1250] = iff + irf
    z[1251] = (lrffo^2 + 4 * z[91]^2) - 4 * lrffo * z[27] * z[91]
    z[1260] = ila + iua

    return Params(z, ae, af, footang, g, he, hf, iff, ihat, ila, irf, ish, ith, iua, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, lff, lffo, lhat, lhato, lla, llao, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, lua, luao, mff, mhat, mla, mrf, msh, mth, mtpb, mtpk, mtpxi, mua, toexi, u8, u9, u10, u11, u12, u13, u14)
end
