# Automatically generated
struct VirtualForce{F1<:Function,F2<:Function,F3<:Function,F4<:Function}
    vrx1::F1
    vry1::F2
    vrx2::F3
    vry2::F4
end

struct Params{T,F1<:Function,F2<:Function,F3<:Function,F4<:Function,F5<:Function,F6<:Function,F7<:Function,F8<:Function,F9<:Function,F10<:Function,F11<:Function,F12<:Function,F13<:Function,F14<:Function,F15<:Function}
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
function Params(ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap, eapp, fapp, gspp, happ, iapp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, inh, ini, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l11, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mh, mi, mtpb, mtpk, pop1xi, pop2xi)
    z = Vector{Float64}(undef, 884)
    mt = ma + mb + mc + md + me + mf + mg
    u8 = 0.0
    u9 = 0.0
    u10 = 0.0
    u11 = 0.0

    virtual_force = VirtualForce(t -> 0.0, t -> 0.0, t -> 0.0, t -> 0.0)

    z[21] = l10 - l9
    z[394] = g * me
    z[749] = z[21] * z[394]
    z[846] = inf + inh + ini
    z[22] = l8 - l7
    z[677] = mf * z[22]
    z[857] = inh + ini
    z[26] = l2 - l1
    z[727] = mi * z[26]
    z[7] = cos(footang)
    z[8] = sin(footang)
    z[23] = l6 - l4
    z[24] = 0.5l6 + 0.5 * z[23]
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
    z[390] = g * ma
    z[391] = g * mb
    z[392] = g * mc
    z[393] = g * md
    z[395] = g * mf
    z[396] = g * mg
    z[397] = g * mh
    z[398] = g * mi
    z[438] = z[76] - l1
    z[443] = z[76] - l2
    z[444] = 0.5l4 - 0.5 * z[77]
    z[445] = 0.5l3 - 0.5 * z[86]
    z[516] = 2l6 - z[77]
    z[517] = l2 - z[76]
    z[538] = l8 - z[78]
    z[554] = l10 - z[79]
    z[562] = l10 - z[80]
    z[567] = l6 - 0.5 * z[77]
    z[569] = l8 - z[81]
    z[570] = z[24] - z[83]
    z[571] = z[25] - z[85]
    z[578] = l6 - z[83]
    z[587] = z[444] + z[7] * z[445]
    z[589] = z[445] + z[7] * z[444]
    z[600] = z[7] * z[86]
    z[610] = 2 * z[570] + 2 * z[7] * z[571]
    z[612] = 2 * z[571] + 2 * z[7] * z[570]
    z[618] = l1 * ma
    z[623] = l2 * mb
    z[626] = l4 * mb
    z[627] = l3 * mb
    z[659] = me * z[21]
    z[687] = l2 * mg
    z[688] = l6 * mg
    z[689] = l8 * mg
    z[690] = l10 * mg
    z[702] = l8 * mh
    z[712] = mh * z[24]
    z[714] = mh * z[25]
    z[741] = l1 * z[390]
    z[743] = l2 * z[391]
    z[744] = l2 * z[396]
    z[751] = z[22] * z[395]
    z[754] = z[26] * z[398]
    z[787] = ina + inb + inc + ind + ine + inf + ing + inh + ini + ma * l1^2
    z[788] = l3^2 + l4^2 + 4 * l2^2 + 2 * l3 * l4 * z[7]
    z[789] = l2 * l3
    z[790] = l2 * l4
    z[791] = z[24]^2
    z[792] = z[25]^2
    z[793] = z[7] * z[24] * z[25]
    z[794] = l10 * l2
    z[795] = l2 * l6
    z[796] = l2 * l8
    z[797] = l10^2
    z[798] = l2^2
    z[799] = l6^2
    z[800] = l8^2
    z[801] = l10 * l6
    z[802] = l10 * l8
    z[803] = l6 * l8
    z[805] = ma * l1^2
    z[810] = l3 * z[8]
    z[811] = l4 * z[8]
    z[812] = z[7] * z[24]
    z[813] = z[7] * z[25]
    z[814] = z[8] * z[25]
    z[815] = z[8] * z[24]
    z[817] = ina + ma * l1^2 + mb * l2^2 + mg * l2^2
    z[819] = ina + ma * l1^2
    z[824] = ina + inb + ma * l1^2
    z[825] = l2^2 + l6^2
    z[830] = ina + inb + inc + ma * l1^2
    z[834] = ina + inb + inc + ind + ma * l1^2
    z[837] = ine + inf + inh + ini
    z[847] = l8 * z[24]
    z[848] = l8 * z[25]


    return Params(z, ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap, eapp, fapp, gspp, happ, iapp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, inh, ini, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l11, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mh, mi, mtpb, mtpk, pop1xi, pop2xi, mt, u8, u9, u10, u11, virtual_force)
end
