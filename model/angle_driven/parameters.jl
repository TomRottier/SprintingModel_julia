# Automatically generated
struct Params{T}
    z::Vector{Float64}
    footang::T
    g::T
    iff::T
    ihat::T
    irf::T
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
    mff::T
    mhat::T
    mrf::T
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

end

# initialise with constant values
function Params(footang, g, iff, ihat, irf, ish, ith, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lmtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, ltoexi, mff, mhat, mrf, msh, mth, mtpb, mtpk, rmtpxi, rtoexi)
    z = Vector{Float64}(undef, 824)
    u4 = 0.0
    u5 = 0.0
    u6 = 0.0
    u7 = 0.0
    u8 = 0.0
    u9 = 0.0

    z[378] = g * mff
    z[725] = lffo * z[378]
    z[379] = g * mrf
    z[19] = cos(footang)
    z[20] = sin(footang)
    z[68] = lff - lffo
    z[69] = lrf - 0.5lrfo
    z[70] = lsh - lsho
    z[71] = lth - ltho
    z[72] = mhat + 2mff + 2mrf + 2msh + 2mth
    z[74] = (mff * z[68]) / z[72]
    z[75] = (lrf * mff + mrf * z[69]) / z[72]
    z[76] = (lrffo * mrf) / z[72]
    z[77] = (lsh * mff + lsh * mrf + msh * z[70]) / z[72]
    z[78] = (lth * mff + lth * mrf + lth * msh + mth * z[71]) / z[72]
    z[79] = (lff * mff + lff * mhat + lffo * mff + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth) / z[72]
    z[80] = (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mrf + 4 * lrf * msh + 4 * lrf * mth) / z[72]
    z[81] = (lsh * mff + lsh * mhat + lsh * mrf + lsh * msh + lsho * msh + 2 * lsh * mth) / z[72]
    z[82] = (lth * mff + lth * mhat + lth * mrf + lth * msh + lth * mth + ltho * mth) / z[72]
    z[377] = g * mhat
    z[380] = g * msh
    z[381] = g * mth
    z[411] = z[79] - lff
    z[412] = 0.5 * z[80] - lrf
    z[413] = z[81] - lsh
    z[414] = z[82] - lth
    z[509] = lrf - z[75]
    z[510] = lsh - z[77]
    z[511] = lth - z[78]
    z[512] = lff - z[79]
    z[513] = lsh - z[81]
    z[514] = lth - z[82]
    z[515] = 2lrf - z[80]
    z[520] = (lrf - 0.5lrfo) - z[75]
    z[521] = 0.5 * z[76] - 0.5lrffo
    z[561] = 0.5 * z[80] - 0.5lrfo
    z[578] = z[19] * z[76]
    z[584] = 2 * z[520] + 2 * z[19] * z[521]
    z[586] = 2 * z[521] + 2 * z[19] * z[520]
    z[598] = 2 * z[561] + 2 * z[19] * z[521]
    z[600] = 2 * z[521] + 2 * z[19] * z[561]
    z[608] = lff * mhat
    z[610] = lrf * mhat
    z[612] = lsh * mhat
    z[614] = lth * mhat
    z[636] = mrf * z[69]
    z[638] = lrffo * mrf
    z[648] = lsh * mrf
    z[665] = msh * z[70]
    z[680] = mth * z[71]
    z[692] = lffo * mff
    z[698] = lff * mrf
    z[700] = lrfo * mrf
    z[728] = z[71] * z[381]
    z[731] = z[70] * z[380]
    z[754] = ihat + 2iff + 2irf + 2ish + 2ith + mff * lffo^2
    z[755] = lrffo^2 + lrfo^2 + 4 * lff^2 + 2 * lrffo * lrfo * z[19]
    z[756] = lff * lrffo
    z[757] = lff * lrfo
    z[758] = lrffo^2 + 4 * z[69]^2
    z[759] = lrffo * z[19] * z[69]
    z[760] = lff^2 + lrf^2 + lsh^2 + lth^2
    z[761] = lff * lrf
    z[762] = lff * lsh
    z[763] = lff * lth
    z[764] = lrf * lsh
    z[765] = lrf * lth
    z[766] = lsh * lth
    z[768] = lrffo * z[19]
    z[769] = lrfo * z[19]
    z[770] = lrffo * z[20]
    z[771] = lrfo * z[20]
    z[772] = z[19] * z[69]
    z[773] = z[20] * z[69]
    z[775] = iff + irf + ish + ith + mff * lffo^2
    z[780] = iff + irf + ish + ith
    z[785] = iff + irf + ish + mff * lffo^2
    z[786] = lff^2 + lrf^2 + lsh^2
    z[791] = iff + irf + ish
    z[792] = lsh * z[69]
    z[793] = lrffo * lsh
    z[798] = iff + irf + mff * lffo^2
    z[799] = lff^2 + lrf^2
    z[804] = iff + irf

    return Params(z, footang, g, iff, ihat, irf, ish, ith, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lmtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, ltoexi, mff, mhat, mrf, msh, mth, mtpb, mtpk, rmtpxi, rtoexi, u4, u5, u6, u7, u8, u9)
end
