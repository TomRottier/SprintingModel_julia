# Automatically generated
mutable struct Params{T,F1,F2,F3,F4,F5,F6,F7,F8,F9}
    z::Vector{Float64}
    ea::F1
    fa::F2
    gs::F3
    eap::F4
    fap::F5
    gsp::F6
    eapp::F7
    fapp::F8
    gspp::F9
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
    l12::T
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
    mtpb::T
    mtpk::T
    pop1xi::T
    pop2xi::T
    mt::T
    u8::T
    u9::T
    vrx
    vry
    virtual_stance::Bool
end

# initialise with constant values
function Params(ea, fa, gs, eap, fap, gsp, eapp, fapp, gspp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l11, l12, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mtpb, mtpk, pop1xi, pop2xi)
    z = Vector{Float64}(undef, 435)
    mt = ma + mb + mc + md + me + mf + mg
    u8 = 0.0
    u9 = 0.0

    vrx = t -> 0.0
    vry = t -> 0.0
    flag = false

    z[295] = l12 * mf
    z[15] = cos(footang)
    z[16] = sin(footang)
    z[17] = l10 - l9
    z[54] = (l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg) / mt
    z[55] = (l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg) / mt
    z[56] = (l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg) / mt
    z[57] = (l10 * me + l10 * mf + l10 * mg + l9 * md) / mt
    z[58] = (l10 * mf + me * z[17]) / mt
    z[59] = (l12 * mf) / mt
    z[61] = (l3 * mb) / mt
    z[62] = ma + mb + mc + md
    z[63] = (l1 * ma + l2 * mb + l2 * mc + l2 * md) / z[62]
    z[64] = (l4 * mb + 2 * l6 * mc + 2 * l6 * md) / z[62]
    z[65] = (l7 * mc + l8 * md) / z[62]
    z[66] = (l9 * md) / z[62]
    z[67] = (l3 * mb) / z[62]
    z[68] = me + mf
    z[69] = (l2 * (me + mf)) / z[68]
    z[70] = (l6 * (me + mf)) / z[68]
    z[71] = (l8 * (me + mf)) / z[68]
    z[72] = (l10 * (me + mf)) / z[68]
    z[73] = (l10 * mf + me * z[17]) / z[68]
    z[74] = (l12 * mf) / z[68]
    z[145] = g * ma
    z[146] = g * mb
    z[147] = g * mc
    z[148] = g * md
    z[149] = g * me
    z[150] = g * mf
    z[151] = g * mg
    z[200] = z[54] - l1
    z[201] = z[54] - l2
    z[202] = 0.5l4 - 0.5 * z[55]
    z[203] = 0.5l3 - 0.5 * z[61]
    z[219] = l6 - 0.5 * z[55]
    z[220] = l7 - z[56]
    z[221] = l8 - z[56]
    z[222] = l9 - z[57]
    z[223] = l10 - z[57]
    z[224] = z[17] - z[58]
    z[225] = l10 - z[58]
    z[226] = l12 - z[59]
    z[232] = z[202] + z[15] * z[203]
    z[234] = z[203] + z[15] * z[202]
    z[239] = z[15] * z[61]
    z[273] = l1 * ma
    z[274] = l2 * mb
    z[275] = l4 * mb
    z[276] = l3 * mb
    z[277] = l2 * mc
    z[278] = l6 * mc
    z[279] = l7 * mc
    z[280] = l2 * md
    z[281] = l6 * md
    z[282] = l8 * md
    z[283] = l9 * md
    z[284] = l2 * me
    z[285] = l6 * me
    z[286] = l8 * me
    z[287] = l10 * me
    z[288] = me * z[17]
    z[290] = l2 * mf
    z[291] = l6 * mf
    z[292] = l8 * mf
    z[293] = l10 * mf
    z[297] = l2 * mg
    z[298] = l6 * mg
    z[299] = l8 * mg
    z[300] = l10 * mg
    z[304] = z[145] + z[146] + z[147] + z[148] + z[149] + z[150] + z[151]
    z[306] = l1 * z[145]
    z[308] = l2 * z[146]
    z[309] = l2 * z[147]
    z[310] = l2 * z[148]
    z[311] = l2 * z[149]
    z[312] = l2 * z[150]
    z[313] = l2 * z[151]
    z[318] = z[17] * z[149]
    z[320] = l12 * z[150]
    z[335] = l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg
    z[347] = ina + inb + inc + ind + ine + inf + ing + ma * l1^2
    z[348] = l3^2 + l4^2 + 4 * l2^2 + 2 * l3 * l4 * z[15]
    z[349] = l2 * l3
    z[350] = l2 * l4
    z[351] = l2 * l6
    z[352] = l2 * l7
    z[353] = l2^2
    z[354] = l6^2
    z[355] = l7^2
    z[356] = l6 * l7
    z[357] = l2 * l8
    z[358] = l2 * l9
    z[359] = l8^2
    z[360] = l9^2
    z[361] = l6 * l8
    z[362] = l6 * l9
    z[363] = l8 * l9
    z[364] = l10 * l2
    z[365] = l2 * z[17]
    z[366] = l10^2
    z[367] = z[17]^2
    z[368] = l10 * l6
    z[369] = l10 * l8
    z[370] = l10 * z[17]
    z[371] = l6 * z[17]
    z[372] = l8 * z[17]
    z[373] = l10 * l12
    z[374] = l12 * l2
    z[375] = l12^2
    z[376] = l12 * l6
    z[377] = l12 * l8
    z[379] = -ina - ma * l1^2
    z[381] = ma * l1^2
    z[385] = l3 * z[16]
    z[386] = l4 * z[16]
    z[388] = ina + ma * l1^2 + mb * l2^2 + mc * l2^2 + md * l2^2 + me * l2^2 + mf * l2^2 + mg * l2^2
    z[389] = ina + ma * l1^2
    z[394] = ina + inb + ma * l1^2
    z[395] = l2^2 + l6^2
    z[400] = ina + inb + inc + ma * l1^2
    z[404] = ina + inb + inc + ind + ma * l1^2
    z[407] = ine + inf
    z[422] = l12 * l2 * mf

    return Params(z, ea, fa, gs, eap, fap, gsp, eapp, fapp, gspp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l11, l12, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mtpb, mtpk, pop1xi, pop2xi, mt, u8, u9, vrx, vry, flag)
end
