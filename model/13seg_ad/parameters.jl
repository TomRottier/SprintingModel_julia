# Automatically generated
struct Params{T}
    z::Vector{T}
    footang::T
    g::T
    iff::T
    ihat::T
    illa::T
    ilua::T
    irf::T
    irla::T
    irua::T
    ish::T
    ith::T
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
    lmtpxi::T
    lrf::T
    lrff::T
    lrffo::T
    lrfo::T
    lsh::T
    lsho::T
    lth::T
    ltho::T
    ltoexi::T
    lua::T
    luao::T
    mff::T
    mhat::T
    mlla::T
    mlua::T
    mrf::T
    mrla::T
    mrua::T
    msh::T
    mth::T
    mtpb::T
    mtpk::T
    rmtpxi::T
    rtoexi::T
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

end

# initialise with constant values
function Params(footang, g, iff, ihat, illa, ilua, irf, irla, irua, ish, ith, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lhato, lla, llao, lmtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, ltoexi, lua, luao, mff, mhat, mlla, mlua, mrf, mrla, mrua, msh, mth, mtpb, mtpk, rmtpxi, rtoexi)
    z = Vector{Float64}(undef, 1299)
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
    z[548] = g * msh
    z[545] = g * mff
    z[1166] = lffo * z[545]
    z[547] = g * mrf
    z[27] = cos(footang)
    z[1089] = llao * mrla
    z[1007] = llao * mlla
    z[28] = sin(footang)
    z[90] = lff - lffo
    z[91] = lrf - 0.5lrfo
    z[92] = lsh - lsho
    z[93] = lth - ltho
    z[94] = mhat + mlla + mlua + mrla + mrua + 2mff + 2mrf + 2msh + 2mth
    z[95] = (lhat * mlla + lhat * mlua + lhat * mrla + lhat * mrua + lhato * mhat) / z[94]
    z[96] = (lff * mff + lff * mhat + lff * mlla + lff * mlua + lff * mrla + lff * mrua + lffo * mff + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth) / z[94]
    z[97] = (llao * mlla) / z[94]
    z[98] = (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mlla + 2 * lrf * mlua + 2 * lrf * mrf + 2 * lrf * mrla + 2 * lrf * mrua + 4 * lrf * msh + 4 * lrf * mth) / z[94]
    z[99] = (lrffo * mrf) / z[94]
    z[100] = (lsh * mff + lsh * mhat + lsh * mlla + lsh * mlua + lsh * mrf + lsh * mrla + lsh * mrua + lsh * msh + lsho * msh + 2 * lsh * mth) / z[94]
    z[101] = (lth * mff + lth * mhat + lth * mlla + lth * mlua + lth * mrf + lth * mrla + lth * mrua + lth * msh + lth * mth + ltho * mth) / z[94]
    z[102] = (lua * mlla + luao * mlua) / z[94]
    z[103] = (mff * z[90]) / z[94]
    z[104] = (llao * mrla) / z[94]
    z[105] = (lrf * mff + mrf * z[91]) / z[94]
    z[106] = (lsh * mff + lsh * mrf + msh * z[92]) / z[94]
    z[107] = (lth * mff + lth * mrf + lth * msh + mth * z[93]) / z[94]
    z[108] = (lua * mrla + luao * mrua) / z[94]
    z[544] = g * mhat
    z[546] = g * mlla
    z[549] = g * mth
    z[550] = g * mlua
    z[551] = g * mrla
    z[552] = g * mrua
    z[582] = lsh - z[100]
    z[583] = lth - z[101]
    z[584] = lff - z[96]
    z[585] = 2lrf - z[98]
    z[678] = lua - z[102]
    z[679] = lhat - z[95]
    z[684] = z[96] - lff
    z[685] = 0.5 * z[98] - 0.5lrfo
    z[686] = 0.5 * z[99] - 0.5lrffo
    z[876] = lsh - z[106]
    z[877] = lth - z[107]
    z[878] = lrf - z[105]
    z[899] = lua - z[108]
    z[904] = 0.5 * z[98] - lrf
    z[905] = z[100] - lsh
    z[906] = z[101] - lth
    z[907] = (lrf - 0.5lrfo) - z[105]
    z[954] = 2 * z[685] + 2 * z[27] * z[686]
    z[956] = 2 * z[686] + 2 * z[27] * z[685]
    z[968] = z[27] * z[686]
    z[970] = z[27] * z[907]
    z[997] = lffo * mff
    z[1020] = lff * mrf
    z[1022] = lrfo * mrf
    z[1024] = lrffo * mrf
    z[1053] = luao * mlua
    z[1098] = mrf * z[91]
    z[1109] = lsh * mrf
    z[1126] = msh * z[92]
    z[1141] = mth * z[93]
    z[1156] = luao * mrua
    z[1168] = z[93] * z[549]
    z[1171] = z[92] * z[548]
    z[1176] = luao * z[552]
    z[1178] = luao * z[550]
    z[1180] = llao * z[551]
    z[1182] = llao * z[546]
    z[1211] = ihat + illa + ilua + irla + irua + 2iff + 2irf + 2ish + 2ith + mff * lffo^2
    z[1212] = lrffo^2 + lrfo^2 + 4 * lff^2 + 2 * lrffo * lrfo * z[27]
    z[1213] = lff * lrffo
    z[1214] = lff * lrfo
    z[1215] = lrffo^2 + 4 * z[91]^2
    z[1216] = lrffo * z[27] * z[91]
    z[1218] = lrffo * z[27]
    z[1219] = lrfo * z[27]
    z[1220] = lrffo * z[28]
    z[1221] = lrfo * z[28]
    z[1222] = z[27] * z[91]
    z[1223] = z[28] * z[91]
    z[1225] = iff + irf + ish + ith
    z[1226] = lrffo^2
    z[1227] = z[91]^2
    z[1232] = iff + irf + ish + ith + mff * lffo^2
    z[1237] = iff + irf + ish
    z[1238] = lsh * z[91]
    z[1239] = lrffo * lsh
    z[1244] = iff + irf + ish + mff * lffo^2
    z[1249] = iff + irf
    z[1250] = (lrffo^2 + 4 * z[91]^2) - 4 * lrffo * z[27] * z[91]
    z[1255] = iff + irf + mff * lffo^2
    z[1260] = irla + irua
    z[1265] = illa + ilua

    return Params(z, footang, g, iff, ihat, illa, ilua, irf, irla, irua, ish, ith, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lhato, lla, llao, lmtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, ltoexi, lua, luao, mff, mhat, mlla, mlua, mrf, mrla, mrua, msh, mth, mtpb, mtpk, rmtpxi, rtoexi, u4, u5, u6, u7, u8, u9, u10, u11, u12, u13)
end
