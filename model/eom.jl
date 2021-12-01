# Automatically generated
function eom(u, p, t)
    @unpack ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l11, l12, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mtpb, mtpk, pop1xi, pop2xi, mt, u8, u9, z = p
    @unpack ea, fa, gs, eap, fap, gsp, eapp, fapp, gspp = p
    @unpack vrx, vry, virtual_stance = p
    @inbounds q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7, θhe, θke, θae, θhf, θkf, θaf = u

    # specified variables
    ea = ea(t)
    fa = fa(t)
    gs = gs(t)
    eap = eap(t)
    fapp = fapp(t)
    eapp = eapp(t)
    fap = fap(t)
    gsp = gsp(t)
    gspp = gspp(t)


    # calculated variables
    θh = π + q7
    θk = π - q6
    θa = π + q5
    θm = q4
    ωh = u7
    ωk = -u6
    ωa = u5
    ωm = u4
    pop2y = q2 - l2 * sin(q3 - q4 - q5 - q6 - q7)


    # torques
    hetor = update_torque_generator!(he, t, 2π - θh, -ωh, θhe)
    ketor = update_torque_generator!(ke, t, 2π - θk, -ωk, θke)
    aetor = update_torque_generator!(ae, t, 2π - θa, -ωa, θae)
    hftor = update_torque_generator!(hf, t, θh, ωh, θhf)
    kftor = update_torque_generator!(kf, t, θk, ωk, θkf)
    aftor = update_torque_generator!(af, t, θa, ωa, θaf)

    # passive torques
    hpass, kpass, apass = PEtorque(θh, θk, θa)

    htor = hetor - hftor - hpass
    ktor = ketor - kftor - kpass
    ator = aetor - aftor + apass
    mtor = mtpk * (π - θm) - mtpb * ωm

    # grf
    if q2 < 0.0
        dp1x = q1 - pop1xi
        ry1 = -k3 * q2 - k4 * abs(q2) * u2
        rx1 = -ry1 * (k1 * dp1x + k2 * u1)

    else
        rx1 = 0.0
        ry1 = 0.0
    end

    if pop2y < 0.0
        pop2x = q1 - l2 * cos(q3 - q4 - q5 - q6 - q7)
        vop2x = u1 - l2 * sin(q3 - q4 - q5 - q6 - q7) * (u3 - u4 - u5 - u6 - u7)
        vop2y = u2 - l2 * cos(q3 - q4 - q5 - q6 - q7) * (u3 - u4 - u5 - u6 - u7)
        dp2x = pop2x - pop2xi
        ry2 = -k7 * pop2y - k8 * abs(pop2y) * vop2y
        rx2 = -ry2 * (k5 * dp2x + k6 * vop2x)
    else
        rx2 = 0.0
        ry2 = 0.0
    end

    # virtual grf
    vrx = virtual_stance ? vrx(t) : 0.0
    vry = virtual_stance ? vry(t) : 0.0

    # z variables
    z[153] = ator + ktor
    z[154] = -htor - ktor
    z[3] = cos(q4)
    z[5] = cos(q5)
    z[4] = sin(q4)
    z[6] = sin(q5)
    z[18] = z[3] * z[5] - z[4] * z[6]
    z[1] = cos(q3)
    z[7] = cos(q6)
    z[10] = sin(q7)
    z[8] = sin(q6)
    z[9] = cos(q7)
    z[22] = -(z[7]) * z[10] - z[8] * z[9]
    z[2] = sin(q3)
    z[21] = z[7] * z[9] - z[8] * z[10]
    z[25] = z[1] * z[22] + z[2] * z[21]
    z[19] = -(z[3]) * z[6] - z[4] * z[5]
    z[23] = z[7] * z[10] + z[8] * z[9]
    z[27] = z[1] * z[21] + z[2] * z[23]
    z[29] = z[18] * z[25] + z[19] * z[27]
    z[20] = z[3] * z[6] + z[4] * z[5]
    z[31] = z[18] * z[27] + z[20] * z[25]
    z[24] = z[1] * z[21] - z[2] * z[22]
    z[26] = z[1] * z[23] - z[2] * z[21]
    z[28] = z[18] * z[24] + z[19] * z[26]
    z[30] = z[18] * z[26] + z[20] * z[24]
    z[32] = z[15] * z[3] - z[16] * z[4]
    z[33] = z[15] * z[4] + z[16] * z[3]
    z[34] = -(z[15]) * z[4] - z[16] * z[3]
    z[35] = z[28] * z[32] + z[30] * z[33]
    z[36] = z[29] * z[32] + z[31] * z[33]
    z[37] = z[28] * z[34] + z[30] * z[32]
    z[38] = z[29] * z[34] + z[31] * z[32]
    z[39] = z[3] * z[28] + z[4] * z[30]
    z[40] = z[3] * z[29] + z[4] * z[31]
    z[41] = z[3] * z[30] - z[4] * z[28]
    z[42] = z[3] * z[31] - z[4] * z[29]
    z[43] = z[7] * z[24] + z[8] * z[26]
    z[44] = z[7] * z[25] + z[8] * z[27]
    z[45] = z[7] * z[26] - z[8] * z[24]
    z[46] = z[7] * z[27] - z[8] * z[25]
    z[77] = z[1] * z[30] + z[2] * z[31]
    z[78] = z[1] * z[29] - z[2] * z[28]
    z[79] = z[1] * z[31] - z[2] * z[30]
    z[82] = z[1] * z[41] + z[2] * z[42]
    z[83] = z[1] * z[40] - z[2] * z[39]
    z[84] = z[1] * z[42] - z[2] * z[41]
    z[106] = l1 * ((((u3 - u4) - u5) - u6) - u7)
    z[107] = ((((u3 - u4) - u5) - u6) - u7) * z[106]
    z[108] = l2 * ((((u3 - u4) - u5) - u6) - u7)
    z[109] = ((((u3 - u4) - u5) - u6) - u7) * z[108]
    z[110] = l4 * (((u3 - u5) - u6) - u7)
    z[111] = l3 * (((u3 - u5) - u6) - u7)
    z[112] = (((u3 - u5) - u6) - u7) * z[110]
    z[113] = (((u3 - u5) - u6) - u7) * z[111]
    z[116] = l6 * (((u3 - u5) - u6) - u7)
    z[117] = (((u3 - u5) - u6) - u7) * z[116]
    z[118] = l7 * ((u3 - u6) - u7)
    z[119] = ((u3 - u6) - u7) * z[118]
    z[120] = l8 * ((u3 - u6) - u7)
    z[121] = ((u3 - u6) - u7) * z[120]
    z[122] = l9 * (u3 - u7)
    z[123] = (u3 - u7) * z[122]
    z[124] = l10 * (u3 - u7)
    z[125] = (u3 - u7) * z[124]
    z[152] = mtor - ator
    z[157] = z[7] * z[18] + z[8] * z[19]
    z[158] = z[7] * z[19] - z[8] * z[18]
    z[159] = z[7] * z[20] + z[8] * z[18]
    z[160] = z[7] * z[18] - z[8] * z[20]
    z[162] = z[3] * z[158] + z[4] * z[160]
    z[163] = z[3] * z[159] - z[4] * z[157]
    z[164] = z[3] * z[160] - z[4] * z[158]
    z[303] = rx1 + rx2 + vrx
    z[305] = z[304] + ry1 + ry2 + vry
    z[314] = mtor + z[306] * z[31] + z[308] * z[31] + z[309] * z[31] + z[310] * z[31] + z[311] * z[31] + z[312] * z[31] + z[313] * z[31] + l2 * (rx2 * z[30] + ry2 * z[31]) + z[54] * (vrx * z[30] + vry * z[31])
    z[315] = (((((mtor + z[306] * z[31] + z[54] * vrx * z[30] + z[54] * vry * z[31] + l2 * (rx2 * z[30] + ry2 * z[31]) + z[147] * (l2 * z[31] - l6 * z[42]) + z[148] * (l2 * z[31] - l6 * z[42]) + z[149] * (l2 * z[31] - l6 * z[42]) + z[150] * (l2 * z[31] - l6 * z[42]) + z[151] * (l2 * z[31] - l6 * z[42]) + 0.5 * z[146] * ((2 * l2 * z[31] - l3 * z[38]) - l4 * z[42])) - z[152]) - 0.5 * z[55] * vrx * z[41]) - 0.5 * z[55] * vry * z[42]) - 0.5 * z[61] * vrx * z[37]) - 0.5 * z[61] * vry * z[38]
    z[316] = ((((((((mtor + z[306] * z[31] + z[54] * vrx * z[30] + z[54] * vry * z[31] + l2 * (rx2 * z[30] + ry2 * z[31]) + z[147] * ((l2 * z[31] - l6 * z[42]) - l7 * z[27]) + z[148] * ((l2 * z[31] - l6 * z[42]) - l8 * z[27]) + z[149] * ((l2 * z[31] - l6 * z[42]) - l8 * z[27]) + z[150] * ((l2 * z[31] - l6 * z[42]) - l8 * z[27]) + z[151] * ((l2 * z[31] - l6 * z[42]) - l8 * z[27]) + 0.5 * z[146] * ((2 * l2 * z[31] - l3 * z[38]) - l4 * z[42])) - z[152]) - z[153]) - z[56] * vrx * z[26]) - z[56] * vry * z[27]) - 0.5 * z[55] * vrx * z[41]) - 0.5 * z[55] * vry * z[42]) - 0.5 * z[61] * vrx * z[37]) - 0.5 * z[61] * vry * z[38]
    z[317] = (((((((((((mtor + z[306] * z[31] + z[54] * vrx * z[30] + z[54] * vry * z[31] + l2 * (rx2 * z[30] + ry2 * z[31]) + z[147] * ((l2 * z[31] - l6 * z[42]) - l7 * z[27]) + 0.5 * z[146] * ((2 * l2 * z[31] - l3 * z[38]) - l4 * z[42]) + z[148] * (((l2 * z[31] - l6 * z[42]) - l8 * z[27]) - l9 * z[46]) + z[149] * (((l2 * z[31] - l10 * z[46]) - l6 * z[42]) - l8 * z[27]) + z[150] * (((l2 * z[31] - l10 * z[46]) - l6 * z[42]) - l8 * z[27]) + z[151] * (((l2 * z[31] - l10 * z[46]) - l6 * z[42]) - l8 * z[27])) - z[152]) - z[153]) - z[154]) - z[56] * vrx * z[26]) - z[56] * vry * z[27]) - z[57] * vrx * z[45]) - z[57] * vry * z[46]) - 0.5 * z[55] * vrx * z[41]) - 0.5 * z[55] * vry * z[42]) - 0.5 * z[61] * vrx * z[37]) - 0.5 * z[61] * vry * z[38]
    z[336] = z[335] * z[30]
    z[337] = z[273] * z[30] + mc * (l2 * z[30] - l6 * z[41]) + md * (l2 * z[30] - l6 * z[41]) + me * (l2 * z[30] - l6 * z[41]) + mf * (l2 * z[30] - l6 * z[41]) + mg * (l2 * z[30] - l6 * z[41]) + 0.5 * mb * ((2 * l2 * z[30] - l3 * z[37]) - l4 * z[41])
    z[338] = z[273] * z[30] + mc * ((l2 * z[30] - l6 * z[41]) - l7 * z[26]) + md * ((l2 * z[30] - l6 * z[41]) - l8 * z[26]) + me * ((l2 * z[30] - l6 * z[41]) - l8 * z[26]) + mf * ((l2 * z[30] - l6 * z[41]) - l8 * z[26]) + mg * ((l2 * z[30] - l6 * z[41]) - l8 * z[26]) + 0.5 * mb * ((2 * l2 * z[30] - l3 * z[37]) - l4 * z[41])
    z[339] = z[273] * z[30] + mc * ((l2 * z[30] - l6 * z[41]) - l7 * z[26]) + 0.5 * mb * ((2 * l2 * z[30] - l3 * z[37]) - l4 * z[41]) + md * (((l2 * z[30] - l6 * z[41]) - l8 * z[26]) - l9 * z[45]) + me * (((l2 * z[30] - l10 * z[45]) - l6 * z[41]) - l8 * z[26]) + mf * (((l2 * z[30] - l10 * z[45]) - l6 * z[41]) - l8 * z[26]) + mg * (((l2 * z[30] - l10 * z[45]) - l6 * z[41]) - l8 * z[26])
    z[342] = z[335] * z[31]
    z[343] = z[273] * z[31] + mc * (l2 * z[31] - l6 * z[42]) + md * (l2 * z[31] - l6 * z[42]) + me * (l2 * z[31] - l6 * z[42]) + mf * (l2 * z[31] - l6 * z[42]) + mg * (l2 * z[31] - l6 * z[42]) + 0.5 * mb * ((2 * l2 * z[31] - l3 * z[38]) - l4 * z[42])
    z[344] = z[273] * z[31] + mc * ((l2 * z[31] - l6 * z[42]) - l7 * z[27]) + md * ((l2 * z[31] - l6 * z[42]) - l8 * z[27]) + me * ((l2 * z[31] - l6 * z[42]) - l8 * z[27]) + mf * ((l2 * z[31] - l6 * z[42]) - l8 * z[27]) + mg * ((l2 * z[31] - l6 * z[42]) - l8 * z[27]) + 0.5 * mb * ((2 * l2 * z[31] - l3 * z[38]) - l4 * z[42])
    z[345] = z[273] * z[31] + mc * ((l2 * z[31] - l6 * z[42]) - l7 * z[27]) + 0.5 * mb * ((2 * l2 * z[31] - l3 * z[38]) - l4 * z[42]) + md * (((l2 * z[31] - l6 * z[42]) - l8 * z[27]) - l9 * z[46]) + me * (((l2 * z[31] - l10 * z[46]) - l6 * z[42]) - l8 * z[27]) + mf * (((l2 * z[31] - l10 * z[46]) - l6 * z[42]) - l8 * z[27]) + mg * (((l2 * z[31] - l10 * z[46]) - l6 * z[42]) - l8 * z[27])
    z[390] = z[389] + z[277] * (l2 - l6 * z[3]) + z[280] * (l2 - l6 * z[3]) + z[284] * (l2 - l6 * z[3]) + z[290] * (l2 - l6 * z[3]) + z[297] * (l2 - l6 * z[3]) + 0.5 * z[274] * ((2l2 - l3 * z[32]) - l4 * z[3])
    z[391] = z[389] + z[277] * ((l2 - l6 * z[3]) - l7 * z[18]) + z[280] * ((l2 - l6 * z[3]) - l8 * z[18]) + z[284] * ((l2 - l6 * z[3]) - l8 * z[18]) + z[290] * ((l2 - l6 * z[3]) - l8 * z[18]) + z[297] * ((l2 - l6 * z[3]) - l8 * z[18]) + 0.5 * z[274] * ((2l2 - l3 * z[32]) - l4 * z[3])
    z[392] = z[389] + z[277] * ((l2 - l6 * z[3]) - l7 * z[18]) + 0.5 * z[274] * ((2l2 - l3 * z[32]) - l4 * z[3]) + z[280] * (((l2 - l6 * z[3]) - l8 * z[18]) - l9 * z[160]) + z[284] * (((l2 - l10 * z[160]) - l6 * z[3]) - l8 * z[18]) + z[290] * (((l2 - l10 * z[160]) - l6 * z[3]) - l8 * z[18]) + z[297] * (((l2 - l10 * z[160]) - l6 * z[3]) - l8 * z[18])
    z[396] = z[394] + mc * (z[395] - 2 * z[351] * z[3]) + md * (z[395] - 2 * z[351] * z[3]) + me * (z[395] - 2 * z[351] * z[3]) + mf * (z[395] - 2 * z[351] * z[3]) + mg * (z[395] - 2 * z[351] * z[3]) + 0.25 * mb * ((z[348] - 4 * z[349] * z[32]) - 4 * z[350] * z[3])
    z[397] = (((((z[394] + 0.25 * mb * ((z[348] - 4 * z[349] * z[32]) - 4 * z[350] * z[3])) - mc * ((((z[352] * z[18] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[356] * z[5])) - md * ((((z[357] * z[18] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[361] * z[5])) - me * ((((z[357] * z[18] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[361] * z[5])) - mf * ((((z[357] * z[18] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[361] * z[5])) - mg * ((((z[357] * z[18] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[361] * z[5])
    z[398] = (((((z[394] + 0.25 * mb * ((z[348] - 4 * z[349] * z[32]) - 4 * z[350] * z[3])) - mc * ((((z[352] * z[18] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[356] * z[5])) - md * (((((z[357] * z[18] + z[358] * z[160] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[361] * z[5]) - z[362] * z[164])) - me * (((((z[357] * z[18] + z[364] * z[160] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[361] * z[5]) - z[368] * z[164])) - mf * (((((z[357] * z[18] + z[364] * z[160] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[361] * z[5]) - z[368] * z[164])) - mg * (((((z[357] * z[18] + z[364] * z[160] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[361] * z[5]) - z[368] * z[164])
    z[401] = (((((z[400] + 0.25 * mb * ((z[348] - 4 * z[349] * z[32]) - 4 * z[350] * z[3])) - mc * (((((2 * z[351] * z[3] + 2 * z[352] * z[18]) - z[353]) - z[354]) - z[355]) - 2 * z[356] * z[5])) - md * (((((2 * z[351] * z[3] + 2 * z[357] * z[18]) - z[353]) - z[354]) - z[359]) - 2 * z[361] * z[5])) - me * (((((2 * z[351] * z[3] + 2 * z[357] * z[18]) - z[353]) - z[354]) - z[359]) - 2 * z[361] * z[5])) - mf * (((((2 * z[351] * z[3] + 2 * z[357] * z[18]) - z[353]) - z[354]) - z[359]) - 2 * z[361] * z[5])) - mg * (((((2 * z[351] * z[3] + 2 * z[357] * z[18]) - z[353]) - z[354]) - z[359]) - 2 * z[361] * z[5])
    z[402] = (((((z[400] + 0.25 * mb * ((z[348] - 4 * z[349] * z[32]) - 4 * z[350] * z[3])) - mc * (((((2 * z[351] * z[3] + 2 * z[352] * z[18]) - z[353]) - z[354]) - z[355]) - 2 * z[356] * z[5])) - md * (((((((z[358] * z[160] + 2 * z[351] * z[3] + 2 * z[357] * z[18]) - z[353]) - z[354]) - z[359]) - 2 * z[361] * z[5]) - z[362] * z[164]) - z[363] * z[7])) - me * (((((((z[364] * z[160] + 2 * z[351] * z[3] + 2 * z[357] * z[18]) - z[353]) - z[354]) - z[359]) - 2 * z[361] * z[5]) - z[368] * z[164]) - z[369] * z[7])) - mf * (((((((z[364] * z[160] + 2 * z[351] * z[3] + 2 * z[357] * z[18]) - z[353]) - z[354]) - z[359]) - 2 * z[361] * z[5]) - z[368] * z[164]) - z[369] * z[7])) - mg * (((((((z[364] * z[160] + 2 * z[351] * z[3] + 2 * z[357] * z[18]) - z[353]) - z[354]) - z[359]) - 2 * z[361] * z[5]) - z[368] * z[164]) - z[369] * z[7])
    z[405] = (((((z[404] + 0.25 * mb * ((z[348] - 4 * z[349] * z[32]) - 4 * z[350] * z[3])) - mc * (((((2 * z[351] * z[3] + 2 * z[352] * z[18]) - z[353]) - z[354]) - z[355]) - 2 * z[356] * z[5])) - md * ((((((((2 * z[351] * z[3] + 2 * z[357] * z[18] + 2 * z[358] * z[160]) - z[353]) - z[354]) - z[359]) - z[360]) - 2 * z[361] * z[5]) - 2 * z[362] * z[164]) - 2 * z[363] * z[7])) - me * ((((((((2 * z[351] * z[3] + 2 * z[357] * z[18] + 2 * z[364] * z[160]) - z[353]) - z[354]) - z[359]) - z[366]) - 2 * z[361] * z[5]) - 2 * z[368] * z[164]) - 2 * z[369] * z[7])) - mf * ((((((((2 * z[351] * z[3] + 2 * z[357] * z[18] + 2 * z[364] * z[160]) - z[353]) - z[354]) - z[359]) - z[366]) - 2 * z[361] * z[5]) - 2 * z[368] * z[164]) - 2 * z[369] * z[7])) - mg * ((((((((2 * z[351] * z[3] + 2 * z[357] * z[18] + 2 * z[364] * z[160]) - z[353]) - z[354]) - z[359]) - z[366]) - 2 * z[361] * z[5]) - 2 * z[368] * z[164]) - 2 * z[369] * z[7])
    z[11] = cos(ea)
    z[12] = sin(ea)
    z[13] = cos(fa)
    z[14] = sin(fa)
    z[47] = z[11] * z[1] + z[12] * z[2]
    z[48] = z[11] * z[2] - z[12] * z[1]
    z[49] = z[12] * z[1] - z[11] * z[2]
    z[50] = -(z[13]) * z[47] - z[14] * z[49]
    z[51] = -(z[13]) * z[48] - z[14] * z[47]
    z[52] = z[14] * z[47] - z[13] * z[49]
    z[53] = z[14] * z[48] - z[13] * z[47]
    z[60] = (mg * gs) / mt
    z[86] = u8 - eap
    z[88] = fapp - eapp
    z[97] = z[17] * eap
    z[98] = l10 * eap
    z[99] = l12 * (eap - fap)
    z[126] = (z[17] * u3 + z[17] * u8) - z[97]
    z[127] = z[17] * eapp
    z[128] = z[126] * (u3 + z[86])
    z[129] = (l10 * u3 + l10 * u8) - z[98]
    z[130] = l10 * eapp
    z[131] = z[129] * (u3 + z[86])
    z[132] = (l12 * u3 + l12 * u8 + l12 * u9) - z[99]
    z[133] = l12 * (eapp - fapp)
    z[134] = fap + u9
    z[135] = z[132] * (u3 + z[86] + z[134])
    z[139] = gs * u3
    z[140] = gsp * u3
    z[141] = gspp - u3 * z[139]
    z[142] = gsp * u3 + z[140]
    z[165] = z[28] * z[47] + z[29] * z[48]
    z[166] = z[28] * z[49] + z[29] * z[47]
    z[167] = z[30] * z[47] + z[31] * z[48]
    z[168] = z[30] * z[49] + z[31] * z[47]
    z[169] = z[3] * z[165] + z[4] * z[167]
    z[170] = z[3] * z[166] + z[4] * z[168]
    z[171] = z[3] * z[167] - z[4] * z[165]
    z[172] = z[3] * z[168] - z[4] * z[166]
    z[173] = z[5] * z[169] + z[6] * z[171]
    z[174] = z[5] * z[170] + z[6] * z[172]
    z[175] = z[5] * z[171] - z[6] * z[169]
    z[176] = z[5] * z[172] - z[6] * z[170]
    z[178] = z[7] * z[174] + z[8] * z[176]
    z[179] = z[7] * z[175] - z[8] * z[173]
    z[180] = z[7] * z[176] - z[8] * z[174]
    z[181] = z[28] * z[50] + z[29] * z[51]
    z[182] = z[28] * z[52] + z[29] * z[53]
    z[183] = z[30] * z[50] + z[31] * z[51]
    z[184] = z[30] * z[52] + z[31] * z[53]
    z[185] = z[3] * z[181] + z[4] * z[183]
    z[186] = z[3] * z[182] + z[4] * z[184]
    z[187] = z[3] * z[183] - z[4] * z[181]
    z[188] = z[3] * z[184] - z[4] * z[182]
    z[189] = z[5] * z[185] + z[6] * z[187]
    z[190] = z[5] * z[186] + z[6] * z[188]
    z[191] = z[5] * z[187] - z[6] * z[185]
    z[192] = z[5] * z[188] - z[6] * z[186]
    z[194] = z[7] * z[190] + z[8] * z[192]
    z[195] = z[7] * z[191] - z[8] * z[189]
    z[196] = z[7] * z[192] - z[8] * z[190]
    z[331] = ine * eapp
    z[333] = inf * z[88]
    z[334] = (((((mg * (((l10 * z[45] + l6 * z[41] + l8 * z[26]) - l2 * z[30]) - gs * z[2]) - z[273] * z[30]) - mc * ((l2 * z[30] - l6 * z[41]) - l7 * z[26])) - 0.5 * mb * ((2 * l2 * z[30] - l3 * z[37]) - l4 * z[41])) - md * (((l2 * z[30] - l6 * z[41]) - l8 * z[26]) - l9 * z[45])) - me * ((((l2 * z[30] - l10 * z[45]) - l6 * z[41]) - l8 * z[26]) - z[17] * z[49])) - mf * (((((l2 * z[30] - l10 * z[45]) - l10 * z[49]) - l12 * z[52]) - l6 * z[41]) - l8 * z[26])
    z[340] = ma * z[28] * z[107] + mc * ((z[28] * z[109] - z[24] * z[119]) - z[39] * z[117]) + 0.5 * mb * ((2 * z[28] * z[109] - z[35] * z[113]) - z[39] * z[112]) + md * (((z[28] * z[109] - z[24] * z[121]) - z[39] * z[117]) - z[43] * z[123]) + mg * (((((z[1] * z[141] + z[28] * z[109]) - z[2] * z[142]) - z[24] * z[121]) - z[39] * z[117]) - z[43] * z[125]) + me * (((((z[28] * z[109] - z[127] * z[49]) - z[24] * z[121]) - z[39] * z[117]) - z[43] * z[125]) - z[47] * z[128]) + mf * (((((((z[28] * z[109] - z[130] * z[49]) - z[133] * z[52]) - z[24] * z[121]) - z[39] * z[117]) - z[43] * z[125]) - z[47] * z[131]) - z[50] * z[135])
    z[341] = (((((-(z[273]) * z[31] - mc * ((l2 * z[31] - l6 * z[42]) - l7 * z[27])) - 0.5 * mb * ((2 * l2 * z[31] - l3 * z[38]) - l4 * z[42])) - md * (((l2 * z[31] - l6 * z[42]) - l8 * z[27]) - l9 * z[46])) - me * ((((l2 * z[31] - l10 * z[46]) - l6 * z[42]) - l8 * z[27]) - z[17] * z[47])) - mg * ((((l2 * z[31] - l10 * z[46]) - l6 * z[42]) - l8 * z[27]) - gs * z[1])) - mf * (((((l2 * z[31] - l10 * z[46]) - l10 * z[47]) - l12 * z[53]) - l6 * z[42]) - l8 * z[27])
    z[346] = ma * z[29] * z[107] + mc * ((z[29] * z[109] - z[25] * z[119]) - z[40] * z[117]) + 0.5 * mb * ((2 * z[29] * z[109] - z[36] * z[113]) - z[40] * z[112]) + md * (((z[29] * z[109] - z[25] * z[121]) - z[40] * z[117]) - z[44] * z[123]) + mg * ((((z[1] * z[142] + z[2] * z[141] + z[29] * z[109]) - z[25] * z[121]) - z[40] * z[117]) - z[44] * z[125]) + me * (((((z[29] * z[109] - z[127] * z[47]) - z[25] * z[121]) - z[40] * z[117]) - z[44] * z[125]) - z[48] * z[128]) + mf * (((((((z[29] * z[109] - z[130] * z[47]) - z[133] * z[53]) - z[25] * z[121]) - z[40] * z[117]) - z[44] * z[125]) - z[48] * z[131]) - z[51] * z[135])
    z[378] = (((((z[347] + 0.25 * mb * ((z[348] - 4 * z[349] * z[32]) - 4 * z[350] * z[3])) - mc * (((((2 * z[351] * z[3] + 2 * z[352] * z[18]) - z[353]) - z[354]) - z[355]) - 2 * z[356] * z[5])) - md * ((((((((2 * z[351] * z[3] + 2 * z[357] * z[18] + 2 * z[358] * z[160]) - z[353]) - z[354]) - z[359]) - z[360]) - 2 * z[361] * z[5]) - 2 * z[362] * z[164]) - 2 * z[363] * z[7])) - me * ((((((((((((2 * z[351] * z[3] + 2 * z[357] * z[18] + 2 * z[364] * z[160] + 2 * z[365] * z[168]) - z[353]) - z[354]) - z[359]) - z[366]) - z[367]) - 2 * z[361] * z[5]) - 2 * z[368] * z[164]) - 2 * z[369] * z[7]) - 2 * z[370] * z[180]) - 2 * z[371] * z[172]) - 2 * z[372] * z[176])) - mg * ((((((((((((2 * z[351] * z[3] + 2 * z[357] * z[18] + 2 * z[364] * z[160] + 2 * l2 * gs * z[79]) - z[353]) - z[354]) - z[359]) - z[366]) - gs^2) - 2 * z[361] * z[5]) - 2 * z[368] * z[164]) - 2 * z[369] * z[7]) - 2 * l10 * gs * z[9]) - 2 * l6 * gs * z[84]) - 2 * l8 * gs * z[21])) - mf * (((((((((((((((2 * z[373] * z[13] + 2 * z[351] * z[3] + 2 * z[357] * z[18] + 2 * z[364] * z[160] + 2 * z[364] * z[168] + 2 * z[374] * z[184]) - 2 * z[366]) - z[353]) - z[354]) - z[359]) - z[375]) - 2 * z[361] * z[5]) - 2 * z[366] * z[180]) - 2 * z[368] * z[164]) - 2 * z[368] * z[172]) - 2 * z[369] * z[7]) - 2 * z[369] * z[176]) - 2 * z[373] * z[196]) - 2 * z[376] * z[188]) - 2 * z[377] * z[192])
    z[380] = (((((z[379] - z[277] * ((l2 - l6 * z[3]) - l7 * z[18])) - 0.5 * z[274] * ((2l2 - l3 * z[32]) - l4 * z[3])) - z[280] * (((l2 - l6 * z[3]) - l8 * z[18]) - l9 * z[160])) - z[284] * ((((l2 - l10 * z[160]) - l6 * z[3]) - l8 * z[18]) - z[17] * z[168])) - z[297] * ((((l2 - l10 * z[160]) - l6 * z[3]) - l8 * z[18]) - gs * z[79])) - z[290] * (((((l2 - l10 * z[160]) - l10 * z[168]) - l12 * z[184]) - l6 * z[3]) - l8 * z[18])
    z[382] = ((((mc * ((((z[352] * z[18] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[356] * z[5]) + md * (((((z[357] * z[18] + z[358] * z[160] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[361] * z[5]) - z[362] * z[164]) + me * ((((((z[357] * z[18] + z[364] * z[160] + z[365] * z[168] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[361] * z[5]) - z[368] * z[164]) - z[371] * z[172]) + mg * ((((((z[357] * z[18] + z[364] * z[160] + 2 * z[351] * z[3] + l2 * gs * z[79]) - z[353]) - z[354]) - z[361] * z[5]) - z[368] * z[164]) - l6 * gs * z[84]) + mf * (((((((z[357] * z[18] + z[364] * z[160] + z[364] * z[168] + z[374] * z[184] + 2 * z[351] * z[3]) - z[353]) - z[354]) - z[361] * z[5]) - z[368] * z[164]) - z[368] * z[172]) - z[376] * z[188])) - ina) - inb) - z[381]) - 0.25 * mb * ((z[348] - 4 * z[349] * z[32]) - 4 * z[350] * z[3])
    z[383] = (((((mc * (((((2 * z[351] * z[3] + 2 * z[352] * z[18]) - z[353]) - z[354]) - z[355]) - 2 * z[356] * z[5]) + md * (((((((z[358] * z[160] + 2 * z[351] * z[3] + 2 * z[357] * z[18]) - z[353]) - z[354]) - z[359]) - 2 * z[361] * z[5]) - z[362] * z[164]) - z[363] * z[7]) + me * (((((((((z[364] * z[160] + z[365] * z[168] + 2 * z[351] * z[3] + 2 * z[357] * z[18]) - z[353]) - z[354]) - z[359]) - 2 * z[361] * z[5]) - z[368] * z[164]) - z[369] * z[7]) - z[371] * z[172]) - z[372] * z[176]) + mg * (((((((((z[364] * z[160] + 2 * z[351] * z[3] + 2 * z[357] * z[18] + l2 * gs * z[79]) - z[353]) - z[354]) - z[359]) - 2 * z[361] * z[5]) - z[368] * z[164]) - z[369] * z[7]) - l6 * gs * z[84]) - l8 * gs * z[21]) + mf * (((((((((((z[364] * z[160] + z[364] * z[168] + z[374] * z[184] + 2 * z[351] * z[3] + 2 * z[357] * z[18]) - z[353]) - z[354]) - z[359]) - 2 * z[361] * z[5]) - z[368] * z[164]) - z[368] * z[172]) - z[369] * z[7]) - z[369] * z[176]) - z[376] * z[188]) - z[377] * z[192])) - ina) - inb) - inc) - z[381]) - 0.25 * mb * ((z[348] - 4 * z[349] * z[32]) - 4 * z[350] * z[3])
    z[384] = ((((((mc * (((((2 * z[351] * z[3] + 2 * z[352] * z[18]) - z[353]) - z[354]) - z[355]) - 2 * z[356] * z[5]) + md * ((((((((2 * z[351] * z[3] + 2 * z[357] * z[18] + 2 * z[358] * z[160]) - z[353]) - z[354]) - z[359]) - z[360]) - 2 * z[361] * z[5]) - 2 * z[362] * z[164]) - 2 * z[363] * z[7]) + me * (((((((((((z[365] * z[168] + 2 * z[351] * z[3] + 2 * z[357] * z[18] + 2 * z[364] * z[160]) - z[353]) - z[354]) - z[359]) - z[366]) - 2 * z[361] * z[5]) - 2 * z[368] * z[164]) - 2 * z[369] * z[7]) - z[370] * z[180]) - z[371] * z[172]) - z[372] * z[176]) + mg * (((((((((((2 * z[351] * z[3] + 2 * z[357] * z[18] + 2 * z[364] * z[160] + l2 * gs * z[79]) - z[353]) - z[354]) - z[359]) - z[366]) - 2 * z[361] * z[5]) - 2 * z[368] * z[164]) - 2 * z[369] * z[7]) - l10 * gs * z[9]) - l6 * gs * z[84]) - l8 * gs * z[21]) + mf * ((((((((((((((z[364] * z[168] + z[374] * z[184] + 2 * z[351] * z[3] + 2 * z[357] * z[18] + 2 * z[364] * z[160]) - z[353]) - z[354]) - z[359]) - z[366]) - 2 * z[361] * z[5]) - 2 * z[368] * z[164]) - 2 * z[369] * z[7]) - z[366] * z[180]) - z[368] * z[172]) - z[369] * z[176]) - z[373] * z[196]) - z[376] * z[188]) - z[377] * z[192])) - ina) - inb) - inc) - ind) - z[381]) - 0.25 * mb * ((z[348] - 4 * z[349] * z[32]) - 4 * z[350] * z[3])
    z[387] = ((z[333] + 0.25 * mb * (((z[385] * z[112] + 2 * l2 * z[4] * z[112] + 2 * l2 * z[33] * z[113] + 2 * l3 * z[34] * z[109]) - z[386] * z[113]) - 2 * l4 * z[4] * z[109]) + md * ((((((l2 * z[4] * z[117] + l2 * z[20] * z[121] + l2 * z[159] * z[123] + l8 * z[6] * z[117] + l8 * z[19] * z[109] + l9 * z[8] * z[121] + l9 * z[158] * z[109]) - l6 * z[4] * z[109]) - l6 * z[6] * z[121]) - l6 * z[163] * z[123]) - l8 * z[8] * z[123]) - l9 * z[162] * z[117]) + mg * ((((((((((gs * z[142] + l10 * z[8] * z[121] + l10 * z[9] * z[142] + l10 * z[10] * z[141] + l10 * z[158] * z[109] + l2 * z[4] * z[117] + l2 * z[20] * z[121] + l2 * z[159] * z[125] + l6 * z[82] * z[141] + l6 * z[84] * z[142] + l8 * z[6] * z[117] + l8 * z[19] * z[109] + l8 * z[21] * z[142] + l8 * z[23] * z[141] + gs * z[10] * z[125] + gs * z[78] * z[109]) - l10 * z[162] * z[117]) - l2 * z[77] * z[141]) - l2 * z[79] * z[142]) - l6 * z[4] * z[109]) - l6 * z[6] * z[121]) - l6 * z[163] * z[125]) - l8 * z[8] * z[125]) - gs * z[22] * z[121]) - gs * z[83] * z[117]) + me * ((((((((((((((((l2 * z[127] * z[168] + l10 * z[8] * z[121] + l10 * z[158] * z[109] + l2 * z[4] * z[117] + l2 * z[20] * z[121] + l2 * z[159] * z[125] + l2 * z[167] * z[128] + l8 * z[6] * z[117] + l8 * z[19] * z[109] + z[17] * z[166] * z[109]) - z[17] * z[127]) - l10 * z[127] * z[180]) - l6 * z[127] * z[172]) - l8 * z[127] * z[176]) - l10 * z[162] * z[117]) - l10 * z[179] * z[128]) - l6 * z[4] * z[109]) - l6 * z[6] * z[121]) - l6 * z[163] * z[125]) - l6 * z[171] * z[128]) - l8 * z[8] * z[125]) - l8 * z[175] * z[128]) - z[17] * z[170] * z[117]) - z[17] * z[174] * z[121]) - z[17] * z[178] * z[125]) + mf * (((((((((((((((((((((((((((l10 * z[13] * z[133] + l12 * z[13] * z[130] + l2 * z[130] * z[168] + l2 * z[133] * z[184] + l10 * z[14] * z[135] + l10 * z[8] * z[121] + l10 * z[158] * z[109] + l10 * z[166] * z[109] + l12 * z[182] * z[109] + l2 * z[4] * z[117] + l2 * z[20] * z[121] + l2 * z[159] * z[125] + l2 * z[167] * z[131] + l2 * z[183] * z[135] + l8 * z[6] * z[117] + l8 * z[19] * z[109]) - l10 * z[130]) - l12 * z[133]) - l10 * z[130] * z[180]) - l10 * z[133] * z[196]) - l6 * z[130] * z[172]) - l6 * z[133] * z[188]) - l8 * z[130] * z[176]) - l8 * z[133] * z[192]) - l10 * z[162] * z[117]) - l10 * z[170] * z[117]) - l10 * z[174] * z[121]) - l10 * z[178] * z[125]) - l10 * z[179] * z[131]) - l10 * z[195] * z[135]) - l12 * z[14] * z[131]) - l12 * z[186] * z[117]) - l12 * z[190] * z[121]) - l12 * z[194] * z[125]) - l6 * z[4] * z[109]) - l6 * z[6] * z[121]) - l6 * z[163] * z[125]) - l6 * z[171] * z[131]) - l6 * z[187] * z[135]) - l8 * z[8] * z[125]) - l8 * z[175] * z[131]) - l8 * z[191] * z[135])) - z[331]) - mc * (((((l6 * z[4] * z[109] + l6 * z[6] * z[119]) - l2 * z[4] * z[117]) - l2 * z[20] * z[119]) - l7 * z[6] * z[117]) - l7 * z[19] * z[109])
    z[393] = l2 * (((((2 * mg * ((((z[77] * z[141] + z[79] * z[142]) - z[4] * z[117]) - z[20] * z[121]) - z[159] * z[125]) - 2 * mc * (z[4] * z[117] + z[20] * z[119])) - mb * (z[4] * z[112] + z[33] * z[113])) - 2 * md * (z[4] * z[117] + z[20] * z[121] + z[159] * z[123])) - 2 * me * (z[127] * z[168] + z[4] * z[117] + z[20] * z[121] + z[159] * z[125] + z[167] * z[128])) - 2 * mf * (z[130] * z[168] + z[133] * z[184] + z[4] * z[117] + z[20] * z[121] + z[159] * z[125] + z[167] * z[131] + z[183] * z[135]))
    z[399] = ((((-mc * (((l2 * z[4] * z[117] + l2 * z[20] * z[119]) - l6 * z[4] * z[109]) - l6 * z[6] * z[119]) - md * ((((l2 * z[4] * z[117] + l2 * z[20] * z[121] + l2 * z[159] * z[123]) - l6 * z[4] * z[109]) - l6 * z[6] * z[121]) - l6 * z[163] * z[123])) - 0.25 * mb * (((z[385] * z[112] + 2 * l2 * z[4] * z[112] + 2 * l2 * z[33] * z[113] + 2 * l3 * z[34] * z[109]) - z[386] * z[113]) - 2 * l4 * z[4] * z[109])) - me * ((((((l2 * z[127] * z[168] + l2 * z[4] * z[117] + l2 * z[20] * z[121] + l2 * z[159] * z[125] + l2 * z[167] * z[128]) - l6 * z[127] * z[172]) - l6 * z[4] * z[109]) - l6 * z[6] * z[121]) - l6 * z[163] * z[125]) - l6 * z[171] * z[128])) - mg * ((((((l2 * z[4] * z[117] + l2 * z[20] * z[121] + l2 * z[159] * z[125] + l6 * z[82] * z[141] + l6 * z[84] * z[142]) - l2 * z[77] * z[141]) - l2 * z[79] * z[142]) - l6 * z[4] * z[109]) - l6 * z[6] * z[121]) - l6 * z[163] * z[125])) - mf * ((((((((l2 * z[130] * z[168] + l2 * z[133] * z[184] + l2 * z[4] * z[117] + l2 * z[20] * z[121] + l2 * z[159] * z[125] + l2 * z[167] * z[131] + l2 * z[183] * z[135]) - l6 * z[130] * z[172]) - l6 * z[133] * z[188]) - l6 * z[4] * z[109]) - l6 * z[6] * z[121]) - l6 * z[163] * z[125]) - l6 * z[171] * z[131]) - l6 * z[187] * z[135])
    z[403] = (((mc * (((((l6 * z[4] * z[109] + l6 * z[6] * z[119]) - l2 * z[4] * z[117]) - l2 * z[20] * z[119]) - l7 * z[6] * z[117]) - l7 * z[19] * z[109]) + md * ((((((l6 * z[4] * z[109] + l6 * z[6] * z[121] + l6 * z[163] * z[123] + l8 * z[8] * z[123]) - l2 * z[4] * z[117]) - l2 * z[20] * z[121]) - l2 * z[159] * z[123]) - l8 * z[6] * z[117]) - l8 * z[19] * z[109]) + mg * ((((((((((l2 * z[77] * z[141] + l2 * z[79] * z[142] + l6 * z[4] * z[109] + l6 * z[6] * z[121] + l6 * z[163] * z[125] + l8 * z[8] * z[125]) - l2 * z[4] * z[117]) - l2 * z[20] * z[121]) - l2 * z[159] * z[125]) - l6 * z[82] * z[141]) - l6 * z[84] * z[142]) - l8 * z[6] * z[117]) - l8 * z[19] * z[109]) - l8 * z[21] * z[142]) - l8 * z[23] * z[141])) - 0.25 * mb * (((z[385] * z[112] + 2 * l2 * z[4] * z[112] + 2 * l2 * z[33] * z[113] + 2 * l3 * z[34] * z[109]) - z[386] * z[113]) - 2 * l4 * z[4] * z[109])) - me * (((((((((l2 * z[127] * z[168] + l2 * z[4] * z[117] + l2 * z[20] * z[121] + l2 * z[159] * z[125] + l2 * z[167] * z[128] + l8 * z[6] * z[117] + l8 * z[19] * z[109]) - l6 * z[127] * z[172]) - l8 * z[127] * z[176]) - l6 * z[4] * z[109]) - l6 * z[6] * z[121]) - l6 * z[163] * z[125]) - l6 * z[171] * z[128]) - l8 * z[8] * z[125]) - l8 * z[175] * z[128])) - mf * (((((((((((((l2 * z[130] * z[168] + l2 * z[133] * z[184] + l2 * z[4] * z[117] + l2 * z[20] * z[121] + l2 * z[159] * z[125] + l2 * z[167] * z[131] + l2 * z[183] * z[135] + l8 * z[6] * z[117] + l8 * z[19] * z[109]) - l6 * z[130] * z[172]) - l6 * z[133] * z[188]) - l8 * z[130] * z[176]) - l8 * z[133] * z[192]) - l6 * z[4] * z[109]) - l6 * z[6] * z[121]) - l6 * z[163] * z[125]) - l6 * z[171] * z[131]) - l6 * z[187] * z[135]) - l8 * z[8] * z[125]) - l8 * z[175] * z[131]) - l8 * z[191] * z[135])
    z[406] = ((((mc * (((((l6 * z[4] * z[109] + l6 * z[6] * z[119]) - l2 * z[4] * z[117]) - l2 * z[20] * z[119]) - l7 * z[6] * z[117]) - l7 * z[19] * z[109]) + mg * ((((((((((((((l10 * z[162] * z[117] + l2 * z[77] * z[141] + l2 * z[79] * z[142] + l6 * z[4] * z[109] + l6 * z[6] * z[121] + l6 * z[163] * z[125] + l8 * z[8] * z[125]) - l10 * z[8] * z[121]) - l10 * z[9] * z[142]) - l10 * z[10] * z[141]) - l10 * z[158] * z[109]) - l2 * z[4] * z[117]) - l2 * z[20] * z[121]) - l2 * z[159] * z[125]) - l6 * z[82] * z[141]) - l6 * z[84] * z[142]) - l8 * z[6] * z[117]) - l8 * z[19] * z[109]) - l8 * z[21] * z[142]) - l8 * z[23] * z[141])) - 0.25 * mb * (((z[385] * z[112] + 2 * l2 * z[4] * z[112] + 2 * l2 * z[33] * z[113] + 2 * l3 * z[34] * z[109]) - z[386] * z[113]) - 2 * l4 * z[4] * z[109])) - md * ((((((l2 * z[4] * z[117] + l2 * z[20] * z[121] + l2 * z[159] * z[123] + l8 * z[6] * z[117] + l8 * z[19] * z[109] + l9 * z[8] * z[121] + l9 * z[158] * z[109]) - l6 * z[4] * z[109]) - l6 * z[6] * z[121]) - l6 * z[163] * z[123]) - l8 * z[8] * z[123]) - l9 * z[162] * z[117])) - me * ((((((((((((l2 * z[127] * z[168] + l10 * z[8] * z[121] + l10 * z[158] * z[109] + l2 * z[4] * z[117] + l2 * z[20] * z[121] + l2 * z[159] * z[125] + l2 * z[167] * z[128] + l8 * z[6] * z[117] + l8 * z[19] * z[109]) - l10 * z[127] * z[180]) - l6 * z[127] * z[172]) - l8 * z[127] * z[176]) - l10 * z[162] * z[117]) - l10 * z[179] * z[128]) - l6 * z[4] * z[109]) - l6 * z[6] * z[121]) - l6 * z[163] * z[125]) - l6 * z[171] * z[128]) - l8 * z[8] * z[125]) - l8 * z[175] * z[128])) - mf * ((((((((((((((((((l2 * z[130] * z[168] + l2 * z[133] * z[184] + l10 * z[8] * z[121] + l10 * z[158] * z[109] + l2 * z[4] * z[117] + l2 * z[20] * z[121] + l2 * z[159] * z[125] + l2 * z[167] * z[131] + l2 * z[183] * z[135] + l8 * z[6] * z[117] + l8 * z[19] * z[109]) - l10 * z[130] * z[180]) - l10 * z[133] * z[196]) - l6 * z[130] * z[172]) - l6 * z[133] * z[188]) - l8 * z[130] * z[176]) - l8 * z[133] * z[192]) - l10 * z[162] * z[117]) - l10 * z[179] * z[131]) - l10 * z[195] * z[135]) - l6 * z[4] * z[109]) - l6 * z[6] * z[121]) - l6 * z[163] * z[125]) - l6 * z[171] * z[131]) - l6 * z[187] * z[135]) - l8 * z[8] * z[125]) - l8 * z[175] * z[131]) - l8 * z[191] * z[135])
    z[425] = z[303] - z[340]
    z[426] = z[305] - z[346]
    z[428] = z[314] - 0.5 * z[393]
    z[429] = z[315] - z[399]
    z[430] = z[316] - z[403]
    z[431] = z[317] - z[406]
    z[435] = (((((((((((((htor + z[152] + z[153] + z[154] + z[56] * vrx * z[26] + z[56] * vry * z[27] + z[57] * vrx * z[45] + z[57] * vry * z[46] + z[58] * vrx * z[49] + z[58] * vry * z[47] + z[59] * vrx * z[52] + z[59] * vry * z[53] + z[60] * vry * z[1] + 0.5 * z[55] * vrx * z[41] + 0.5 * z[55] * vry * z[42] + 0.5 * z[61] * vrx * z[37] + 0.5 * z[61] * vry * z[38]) - mtor) - z[306] * z[31]) - z[54] * vrx * z[30]) - z[54] * vry * z[31]) - z[60] * vrx * z[2]) - l2 * (rx2 * z[30] + ry2 * z[31])) - z[147] * ((l2 * z[31] - l6 * z[42]) - l7 * z[27])) - 0.5 * z[146] * ((2 * l2 * z[31] - l3 * z[38]) - l4 * z[42])) - z[148] * (((l2 * z[31] - l6 * z[42]) - l8 * z[27]) - l9 * z[46])) - z[149] * ((((l2 * z[31] - l10 * z[46]) - l6 * z[42]) - l8 * z[27]) - z[17] * z[47])) - z[151] * ((((l2 * z[31] - l10 * z[46]) - l6 * z[42]) - l8 * z[27]) - gs * z[1])) - z[150] * (((((l2 * z[31] - l10 * z[46]) - l10 * z[47]) - l12 * z[53]) - l6 * z[42]) - l8 * z[27])) - z[387]

    # coef
    coef11 = -mt
    coef12 = 0
    coef13 = -(z[334])
    coef14 = -(z[336])
    coef15 = -(z[337])
    coef16 = -(z[338])
    coef17 = -(z[339])
    coef21 = 0
    coef22 = -mt
    coef23 = -(z[341])
    coef24 = -(z[342])
    coef25 = -(z[343])
    coef26 = -(z[344])
    coef27 = -(z[345])
    coef31 = -(z[334])
    coef32 = -(z[341])
    coef33 = -(z[378])
    coef34 = -(z[380])
    coef35 = -(z[382])
    coef36 = -(z[383])
    coef37 = -(z[384])
    coef41 = -(z[336])
    coef42 = -(z[342])
    coef43 = -(z[380])
    coef44 = -(z[388])
    coef45 = -(z[390])
    coef46 = -(z[391])
    coef47 = -(z[392])
    coef51 = -(z[337])
    coef52 = -(z[343])
    coef53 = -(z[382])
    coef54 = -(z[390])
    coef55 = -(z[396])
    coef56 = -(z[397])
    coef57 = -(z[398])
    coef61 = -(z[338])
    coef62 = -(z[344])
    coef63 = -(z[383])
    coef64 = -(z[391])
    coef65 = -(z[397])
    coef66 = -(z[401])
    coef67 = -(z[402])
    coef71 = -(z[339])
    coef72 = -(z[345])
    coef73 = -(z[384])
    coef74 = -(z[392])
    coef75 = -(z[398])
    coef76 = -(z[402])
    coef77 = -(z[405])

    # rhs
    rhs1 = -(z[425])
    rhs2 = -(z[426])
    rhs3 = -(z[435])
    rhs4 = -(z[428])
    rhs5 = -(z[429])
    rhs6 = -(z[430])
    rhs7 = -(z[431])

    # set up system of equations
    coef = @SMatrix [coef11 coef12 coef13 coef14 coef15 coef16 coef17; coef21 coef22 coef23 coef24 coef25 coef26 coef27; coef31 coef32 coef33 coef34 coef35 coef36 coef37; coef41 coef42 coef43 coef44 coef45 coef46 coef47; coef51 coef52 coef53 coef54 coef55 coef56 coef57; coef61 coef62 coef63 coef64 coef65 coef66 coef67; coef71 coef72 coef73 coef74 coef75 coef76 coef77]
    rhs = @SVector [rhs1, rhs2, rhs3, rhs4, rhs5, rhs6, rhs7]

    # derivatives
    q1p = u1
    q2p = u2
    q3p = u3
    q4p = u4
    q5p = u5
    q6p = u6
    q7p = u7
    @inbounds u1p, u2p, u3p, u4p, u5p, u6p, u7p = coef \ rhs

    return @SVector [q1p, q2p, q3p, q4p, q5p, q6p, q7p, u1p, u2p, u3p, u4p, u5p, u6p, u7p, he.cc.ω, ke.cc.ω, ae.cc.ω, hf.cc.ω, kf.cc.ω, af.cc.ω]
end
