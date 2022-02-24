# Automatically generated
mutable struct VirtualForce
    flag::Bool
    vrx1::Function
    vry1::Function
    vrx2::Function
    vry2::Function
end

struct Params{T,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15}
    z::Vector{Float64}
    ea::F1
    fa::F2
    gs::F3
    ha::F4
    ia::F5
    eap::F6
    fap::F7
    gsp::F8
    hap::F9
    iap::F10
    eapp::F11
    fapp::F12
    gspp::F13
    happ::F14
    iapp::F15
    ae::TorqueGenerator
    af::TorqueGenerator
    footang::T
    g::T
    he::TorqueGenerator
    hf::TorqueGenerator
    ina::T
    inb::T
    inc::T
    ind::T
    ine::T
    inf::T
    ing::T
    inh::T
    ini::T
    k1::T
    k2::T
    k3::T
    k4::T
    k5::T
    k6::T
    k7::T
    k8::T
    ke::TorqueGenerator
    kf::TorqueGenerator
    l1::T
    l10::T
    l11::T
    l2::T
    l3::T
    l4::T
    l5::T
    l6::T
    l7::T
    l8::T
    l9::T
    ma::T
    mb::T
    mc::T
    md::T
    me::T
    mf::T
    mg::T
    mh::T
    mi::T
    mtpb::T
    mtpk::T
    pop1xi::T
    pop2xi::T
    mt::T
    u8::T
    u9::T
    u10::T
    u11::T
    virtual_force::VirtualForce

end

# initialise with constant values
function Params(ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap, eapp, fapp, gspp, happ, iapp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, inh, ini, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mh, mi, mtpb, mtpk, pop1xi, pop2xi)
    z = Vector{Float64}(undef, 691)
    mt = ma + mb + mc + md + me + mf + mg
    u8 = 0.0
    u9 = 0.0
    u10 = 0.0
    u11 = 0.0

    virtual_force = VirtualForce(false, () -> 0.0, () -> 0.0, () -> 0.0, () -> 0.0)

    z[21] = l10 - l9
    z[223] = g * me
    z[529] = z[21] * z[223]
    z[654] = inf + inh + ini
    z[22] = l8 - l7
    z[485] = mf * z[22]
    z[663] = inh + ini
    z[23] = l6 - l4
    z[24] = 0.5l6 + 0.5 * z[23]
    z[601] = l8 * z[24]
    z[26] = l2 - l1
    z[510] = mi * z[26]
    z[7] = cos(footang)
    z[8] = sin(footang)
    z[25] = 0.5l3 - 0.5l5
    z[75] = ma + mb + mc + md + me + mf + mg + mh + mi
    z[76] = (l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg + l2 * mh + l2 * mi) / z[75]
    z[77] = (l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg + 2 * l6 * mh + 2 * l6 * mi) / z[75]
    z[78] = (l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg + l8 * mh + l8 * mi) / z[75]
    z[79] = (l10 * me + l10 * mf + l10 * mg + l10 * mh + l10 * mi + l9 * md) / z[75]
    z[80] = (l10 * mf + l10 * mh + l10 * mi + me * z[21]) / z[75]
    z[81] = (l8 * mh + l8 * mi + mf * z[22]) / z[75]
    z[83] = (l6 * mi + mh * z[24]) / z[75]
    z[84] = (mi * z[26]) / z[75]
    z[85] = (mh * z[25]) / z[75]
    z[86] = (l3 * mb) / z[75]
    z[87] = ma + mb + mc + md
    z[88] = (l1 * ma + l2 * mb + l2 * mc + l2 * md) / z[87]
    z[89] = (l4 * mb + 2 * l6 * mc + 2 * l6 * md) / z[87]
    z[90] = (l7 * mc + l8 * md) / z[87]
    z[91] = (l9 * md) / z[87]
    z[92] = (l3 * mb) / z[87]
    z[93] = me + mf + mh + mi
    z[94] = (l2 * (me + mf + mh + mi)) / z[93]
    z[95] = (l6 * (me + mf + mh + mi)) / z[93]
    z[96] = (l8 * (me + mf + mh + mi)) / z[93]
    z[97] = (l10 * (me + mf + mh + mi)) / z[93]
    z[98] = (l10 * mf + l10 * mh + l10 * mi + me * z[21]) / z[93]
    z[99] = (l8 * mh + l8 * mi + mf * z[22]) / z[93]
    z[100] = (l6 * mi + mh * z[24]) / z[93]
    z[101] = (mi * z[26]) / z[93]
    z[102] = (mh * z[25]) / z[93]
    z[219] = g * ma
    z[220] = g * mb
    z[221] = g * mc
    z[222] = g * md
    z[224] = g * mf
    z[225] = g * mg
    z[226] = g * mh
    z[227] = g * mi
    z[347] = z[76] - l1
    z[348] = z[76] - l2
    z[349] = 0.5l4 - 0.5 * z[77]
    z[350] = 0.5l3 - 0.5 * z[86]
    z[378] = l6 - 0.5 * z[77]
    z[379] = l7 - z[78]
    z[380] = l8 - z[78]
    z[381] = l9 - z[79]
    z[382] = l10 - z[79]
    z[383] = z[21] - z[80]
    z[384] = l10 - z[80]
    z[385] = z[22] - z[81]
    z[387] = l8 - z[81]
    z[388] = z[24] - z[83]
    z[389] = z[25] - z[85]
    z[393] = l6 - z[83]
    z[394] = z[26] - z[84]
    z[399] = z[349] + z[7] * z[350]
    z[403] = z[350] + z[7] * z[349]
    z[406] = z[7] * z[86]
    z[446] = 2 * z[388] + 2 * z[7] * z[389]
    z[450] = 2 * z[389] + 2 * z[7] * z[388]
    z[458] = z[7] * z[85]
    z[463] = l1 * ma
    z[464] = l2 * mb
    z[465] = l4 * mb
    z[466] = l3 * mb
    z[467] = l2 * mc
    z[468] = l6 * mc
    z[469] = l7 * mc
    z[470] = l2 * md
    z[471] = l6 * md
    z[472] = l8 * md
    z[473] = l9 * md
    z[474] = l2 * me
    z[475] = l6 * me
    z[476] = l8 * me
    z[477] = l10 * me
    z[478] = me * z[21]
    z[480] = l2 * mf
    z[481] = l6 * mf
    z[482] = l8 * mf
    z[483] = l10 * mf
    z[487] = l2 * mg
    z[488] = l6 * mg
    z[489] = l8 * mg
    z[490] = l10 * mg
    z[493] = l2 * mh
    z[494] = l6 * mh
    z[495] = l8 * mh
    z[496] = l10 * mh
    z[499] = mh * z[24]
    z[501] = mh * z[25]
    z[503] = l2 * mi
    z[504] = l6 * mi
    z[505] = l8 * mi
    z[506] = l10 * mi
    z[513] = z[219] + z[220] + z[221] + z[222] + z[223] + z[224] + z[225] + z[226] + z[227]
    z[515] = l1 * z[219]
    z[517] = l2 * z[220]
    z[518] = l2 * z[221]
    z[519] = l2 * z[222]
    z[520] = l2 * z[223]
    z[521] = l2 * z[224]
    z[522] = l2 * z[225]
    z[523] = l2 * z[226]
    z[524] = l2 * z[227]
    z[531] = z[22] * z[224]
    z[534] = z[26] * z[227]
    z[553] = l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg + l2 * mh + l2 * mi
    z[565] = ina + inb + inc + ind + ine + inf + ing + inh + ini + ma * l1^2
    z[566] = l3^2 + l4^2 + 4 * l2^2 + 2 * l3 * l4 * z[7]
    z[567] = l2 * l3
    z[568] = l2 * l4
    z[569] = l2 * l6
    z[570] = l2 * l7
    z[571] = l2^2
    z[572] = l6^2
    z[573] = l7^2
    z[574] = l6 * l7
    z[575] = l2 * l8
    z[576] = l2 * l9
    z[577] = l8^2
    z[578] = l9^2
    z[579] = l6 * l8
    z[580] = l6 * l9
    z[581] = l8 * l9
    z[582] = l10 * l2
    z[583] = l2 * z[21]
    z[584] = l10^2
    z[585] = z[21]^2
    z[586] = l10 * l6
    z[587] = l10 * l8
    z[588] = l10 * z[21]
    z[589] = l6 * z[21]
    z[590] = l8 * z[21]
    z[591] = l10 * z[22]
    z[592] = l2 * z[22]
    z[593] = z[22]^2
    z[594] = l6 * z[22]
    z[595] = l8 * z[22]
    z[596] = l6 * z[26]
    z[597] = l2 * z[26]
    z[598] = z[26]^2
    z[599] = l10 * z[26]
    z[600] = l8 * z[26]
    z[602] = l2 * z[24]
    z[603] = l2 * z[25]
    z[604] = z[24]^2
    z[605] = z[25]^2
    z[606] = z[7] * z[24] * z[25]
    z[607] = l10 * z[24]
    z[608] = l10 * z[25]
    z[609] = l6 * z[24]
    z[610] = l6 * z[25]
    z[611] = l8 * z[25]
    z[613] = -ina - ma * l1^2
    z[615] = ma * l1^2
    z[619] = l3 * z[8]
    z[620] = l4 * z[8]
    z[621] = z[7] * z[24]
    z[622] = z[7] * z[25]
    z[623] = z[8] * z[24]
    z[624] = z[8] * z[25]
    z[626] = ina + ma * l1^2 + mb * l2^2 + mc * l2^2 + md * l2^2 + me * l2^2 + mf * l2^2 + mg * l2^2 + mh * l2^2 + mi * l2^2
    z[627] = ina + ma * l1^2
    z[632] = ina + inb + ma * l1^2
    z[633] = l2^2 + l6^2
    z[638] = ina + inb + inc + ma * l1^2
    z[642] = ina + inb + inc + ind + ma * l1^2
    z[645] = ine + inf + inh + ini
    z[678] = l2 * mi * z[26]

    return Params(z, ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap, eapp, fapp, gspp, happ, iapp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, inh, ini, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mh, mi, mtpb, mtpk, pop1xi, pop2xi, mt, u8, u9, u10, u11, virtual_force)
end
