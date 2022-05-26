# Automatically generated
function kecm(sol, t)
    @unpack z, ihat, ith, u5, u4, ish, u7, u6, irf, u9, u8, iff, mff, lffo, msh, mth, mrf, lrffo, lsh, lrfo, lff, mhat, lth, lrf = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)
    lhp, rhp, lkp, rkp, lap, rap, lmtpp, rmtpp, hato, hatop = _lhp(t), _rhp(t), _lkp(t), _rkp(t), _lap(t), _rap(t), _lmtpp(t), _rmtpp(t), _hato(t), _hatop(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((0.5 * ihat * u3^2 + 0.5 * ith * (lhp + u3 + u5)^2 + 0.5 * ith * (rhp + u3 + u4)^2 + 0.5 * ish * (lhp + lkp + u3 + u5 + u7)^2 + 0.5 * ish * (rhp + rkp + u3 + u4 + u6)^2 + 0.5 * irf * (lap + lhp + lkp + u3 + u5 + u7 + u9)^2 + 0.5 * irf * (rap + rhp + rkp + u3 + u4 + u6 + u8)^2 + 0.5 * iff * (lap + lhp + lkp + lmtpp + u3 + u5 + u7 + u9)^2 + 0.5 * iff * (rap + rhp + rkp + rmtpp + u3 + u4 + u6 + u8)^2 + 0.5 * mff * ((z[31] * u1 + z[32] * u2)^2 + (((z[118] + lffo * u3 + lffo * u4 + lffo * u6 + lffo * u8) - z[33] * u1) - z[34] * u2)^2) + 0.5 * msh * ((z[141] + z[138] * u3 + z[138] * u4 + z[138] * u6 + z[138] * u8 + z[139] * u1 + z[140] * u2)^2 + (z[149] + z[142] * u8 + z[148] * u3 + z[148] * u4 + z[148] * u6 + z[143] * u1 + z[144] * u2)^2) + 0.5 * mth * ((z[157] + z[153] * u3 + z[153] * u4 + z[153] * u6 + z[154] * u8 + z[155] * u1 + z[156] * u2)^2 + (z[165] + z[158] * u8 + z[159] * u6 + z[164] * u3 + z[164] * u4 + z[160] * u1 + z[161] * u2)^2) + 0.5 * mth * ((z[177] + z[172] * u3 + z[172] * u4 + z[173] * u6 + z[174] * u8 + z[175] * u1 + z[176] * u2)^2 + (z[186] + z[71] * u5 + z[178] * u8 + z[179] * u6 + z[180] * u4 + z[185] * u3 + z[181] * u1 + z[182] * u2)^2) + 0.5 * msh * ((z[197] + z[190] * u3 + z[191] * u4 + z[192] * u6 + z[193] * u8 + z[196] * u5 + z[194] * u1 + z[195] * u2)^2 + (z[210] + z[70] * u7 + z[199] * u8 + z[200] * u6 + z[201] * u4 + z[208] * u3 + z[209] * u5 + z[203] * u1 + z[204] * u2)^2) + 0.5 * mff * ((z[254] + z[245] * u3 + z[246] * u4 + z[247] * u6 + z[248] * u8 + z[249] * u5 + z[250] * u7 + z[253] * u9 + z[251] * u1 + z[252] * u2)^2 + (z[271] + z[256] * u8 + z[257] * u6 + z[258] * u4 + z[267] * u3 + z[268] * u5 + z[269] * u7 + z[270] * u9 + z[262] * u1 + z[263] * u2)^2) + 0.125 * mrf * ((((((z[221] + lrffo * u3 + lrffo * u5 + lrffo * u7 + lrffo * u9)^2 + 4 * (z[220] + z[69] * u3 + z[69] * u5 + z[69] * u7 + z[69] * u9)^2 + 4 * (z[197] + z[190] * u3 + z[191] * u4 + z[192] * u6 + z[193] * u8 + z[196] * u5 + z[194] * u1 + z[195] * u2)^2 + 4 * (z[214] + lsh * u7 + z[199] * u8 + z[200] * u6 + z[201] * u4 + z[212] * u3 + z[213] * u5 + z[203] * u1 + z[204] * u2)^2 + 8 * z[13] * (z[220] + z[69] * u3 + z[69] * u5 + z[69] * u7 + z[69] * u9) * (z[214] + lsh * u7 + z[199] * u8 + z[200] * u6 + z[201] * u4 + z[212] * u3 + z[213] * u5 + z[203] * u1 + z[204] * u2)) - 4 * z[19] * (z[220] + z[69] * u3 + z[69] * u5 + z[69] * u7 + z[69] * u9) * (z[221] + lrffo * u3 + lrffo * u5 + lrffo * u7 + lrffo * u9)) - 8 * z[14] * (z[220] + z[69] * u3 + z[69] * u5 + z[69] * u7 + z[69] * u9) * (z[197] + z[190] * u3 + z[191] * u4 + z[192] * u6 + z[193] * u8 + z[196] * u5 + z[194] * u1 + z[195] * u2)) - 4 * z[398] * (z[221] + lrffo * u3 + lrffo * u5 + lrffo * u7 + lrffo * u9) * (z[197] + z[190] * u3 + z[191] * u4 + z[192] * u6 + z[193] * u8 + z[196] * u5 + z[194] * u1 + z[195] * u2)) - 4 * z[396] * (z[221] + lrffo * u3 + lrffo * u5 + lrffo * u7 + lrffo * u9) * (z[214] + lsh * u7 + z[199] * u8 + z[200] * u6 + z[201] * u4 + z[212] * u3 + z[213] * u5 + z[203] * u1 + z[204] * u2))) - 0.125 * mrf * ((((((((4 * z[16] * (z[31] * u1 + z[32] * u2) * (z[125] + lrfo * u3 + lrfo * u4 + lrfo * u6 + lrfo * u8) + 4 * z[400] * (z[31] * u1 + z[32] * u2) * (z[126] + lrffo * u3 + lrffo * u4 + lrffo * u6 + lrffo * u8)) - 4 * (z[31] * u1 + z[32] * u2)^2) - (z[125] + lrfo * u3 + lrfo * u4 + lrfo * u6 + lrfo * u8)^2) - (z[126] + lrffo * u3 + lrffo * u4 + lrffo * u6 + lrffo * u8)^2) - 4 * (((z[119] + lff * u3 + lff * u4 + lff * u6 + lff * u8) - z[33] * u1) - z[34] * u2)^2) - 2 * z[19] * (z[125] + lrfo * u3 + lrfo * u4 + lrfo * u6 + lrfo * u8) * (z[126] + lrffo * u3 + lrffo * u4 + lrffo * u6 + lrffo * u8)) - 4 * z[15] * (z[125] + lrfo * u3 + lrfo * u4 + lrfo * u6 + lrfo * u8) * (((z[119] + lff * u3 + lff * u4 + lff * u6 + lff * u8) - z[33] * u1) - z[34] * u2)) - 4 * z[399] * (z[126] + lrffo * u3 + lrffo * u4 + lrffo * u6 + lrffo * u8) * (((z[119] + lff * u3 + lff * u4 + lff * u6 + lff * u8) - z[33] * u1) - z[34] * u2))) - 0.5 * mhat * (((((((((((((((((((2 * hato * z[2] * u1 * u3 + 2 * z[46] * u2 * (z[166] + lth * u3 + lth * u4) + 2 * z[48] * u1 * (z[166] + lth * u3 + lth * u4) + 2 * hato * z[3] * u3 * (z[166] + lth * u3 + lth * u4) + 2 * z[26] * hatop * (z[280] + lsh * u3 + lsh * u4 + lsh * u6) + 2 * z[29] * u1 * (z[280] + lsh * u3 + lsh * u4 + lsh * u6) + 2 * z[30] * u2 * (z[280] + lsh * u3 + lsh * u4 + lsh * u6) + 2 * hato * z[24] * u3 * (z[280] + lsh * u3 + lsh * u4 + lsh * u6) + 2 * hatop * z[96] * (z[279] + lrf * u3 + lrf * u4 + lrf * u6 + lrf * u8) + 2 * hatop * z[108] * (z[278] + lff * u3 + lff * u4 + lff * u6 + lff * u8) + 2 * z[33] * u1 * (z[278] + lff * u3 + lff * u4 + lff * u6 + lff * u8) + 2 * z[34] * u2 * (z[278] + lff * u3 + lff * u4 + lff * u6 + lff * u8) + 2 * z[44] * u1 * (z[279] + lrf * u3 + lrf * u4 + lrf * u6 + lrf * u8) + 2 * z[45] * u2 * (z[279] + lrf * u3 + lrf * u4 + lrf * u6 + lrf * u8) + 2 * hato * z[98] * u3 * (z[279] + lrf * u3 + lrf * u4 + lrf * u6 + lrf * u8) + 2 * hato * z[110] * u3 * (z[278] + lff * u3 + lff * u4 + lff * u6 + lff * u8)) - hatop^2) - u1^2) - u2^2) - 2 * hatop * z[1] * u1) - 2 * hatop * z[2] * u2) - 2 * hato * z[1] * u2 * u3) - hato^2 * u3^2) - (z[166] + lth * u3 + lth * u4)^2) - 2 * z[4] * hatop * (z[166] + lth * u3 + lth * u4)) - (z[280] + lsh * u3 + lsh * u4 + lsh * u6)^2) - (z[278] + lff * u3 + lff * u4 + lff * u6 + lff * u8)^2) - (z[279] + lrf * u3 + lrf * u4 + lrf * u6 + lrf * u8)^2) - 2 * z[7] * (z[166] + lth * u3 + lth * u4) * (z[280] + lsh * u3 + lsh * u4 + lsh * u6)) - 2 * z[392] * (z[166] + lth * u3 + lth * u4) * (z[278] + lff * u3 + lff * u4 + lff * u6 + lff * u8)) - 2 * z[393] * (z[166] + lth * u3 + lth * u4) * (z[279] + lrf * u3 + lrf * u4 + lrf * u6 + lrf * u8)) - 2 * z[11] * (z[280] + lsh * u3 + lsh * u4 + lsh * u6) * (z[279] + lrf * u3 + lrf * u4 + lrf * u6 + lrf * u8)) - 2 * z[21] * (z[280] + lsh * u3 + lsh * u4 + lsh * u6) * (z[278] + lff * u3 + lff * u4 + lff * u6 + lff * u8)) - 2 * z[15] * (z[278] + lff * u3 + lff * u4 + lff * u6 + lff * u8) * (z[279] + lrf * u3 + lrf * u4 + lrf * u6 + lrf * u8))
end

kecm(sol) = [kecm(sol, t) for t in sol.t]


function pocmy(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((((q2 + z[74] * z[65] + z[75] * z[57] + z[77] * z[53] + z[78] * z[50] + z[73] * z[2]) - z[79] * z[32]) - z[81] * z[28]) - z[82] * z[47]) - 0.5 * z[76] * z[39]) - 0.5 * z[76] * z[61]) - 0.5 * z[80] * z[43]
end

pocmy(sol) = [pocmy(sol, t) for t in sol.t]


function pecm(sol, t)
    @unpack z, k1, k3, g, mhat, mff, mrf, msh, mth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (0.5 * k1 * q1^2 + 0.5 * k3 * q2^2) - g * (mhat + 2mff + 2mrf + 2msh + 2mth) * pocmy
end

pecm(sol) = [pecm(sol, t) for t in sol.t]


function te(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return kecm + pecm
end

te(sol) = [te(sol, t) for t in sol.t]


function hz(sol, t)
    @unpack z, iff, u4, u5, u6, u7, u8, u9, ihat, irf, ish, ith = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((((((((((((z[402] + z[403] + z[404] + z[405] + z[406] + z[407] + z[408] + z[409] + 0.5 * z[574] + iff * u4 + iff * u5 + iff * u6 + iff * u7 + iff * u8 + iff * u9 + ihat * u3 + irf * u4 + irf * u5 + irf * u6 + irf * u7 + irf * u8 + irf * u9 + ish * u4 + ish * u5 + ish * u6 + ish * u7 + ith * u4 + ith * u5 + 0.5 * z[576] * u1 + 2 * iff * u3 + 2 * irf * u3 + 2 * ish * u3 + 2 * ith * u3 + z[582] * z[519] + z[590] * z[548] + z[592] * z[556] + z[594] * z[560] + z[602] * z[568] + z[604] * z[572] + 0.5 * z[580] * z[363] + 0.5 * z[585] * z[522] + 0.5 * z[587] * z[523] + 0.5 * z[589] * z[525] + 0.5 * z[597] * z[562] + 0.5 * z[599] * z[563] + 0.5 * z[601] * z[564]) - 0.5 * z[575] * u2) - z[583] * z[518]) - z[591] * z[524]) - z[593] * z[555]) - z[595] * z[559]) - z[603] * z[567]) - z[605] * z[571]) - 0.5 * z[573] * z[360]) - 0.5 * z[577] * z[361]) - 0.5 * z[579] * z[362]) - 0.5 * z[581] * z[364]) - 0.5 * z[588] * z[524]) - 0.5 * z[596] * z[559]
end

hz(sol) = [hz(sol, t) for t in sol.t]


function px(sol, t)
    @unpack z, mhat, u5, u7, u9, u4, u6, u8 = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((((((z[606] * z[1] + mhat * u1 + z[31] * (z[688] * u1 + z[689] * u2 + z[694] * u1 + z[695] * u2) + z[58] * (z[637] + z[636] * u3 + z[636] * u5 + z[636] * u7 + z[636] * u9) + z[27] * (z[706] + z[703] * u3 + z[703] * u4 + z[703] * u6 + z[703] * u8 + z[704] * u1 + z[705] * u2) + z[46] * (z[716] + z[712] * u3 + z[712] * u4 + z[712] * u6 + z[713] * u8 + z[714] * u1 + z[715] * u2) + z[49] * (z[679] + z[674] * u3 + z[674] * u4 + z[675] * u6 + z[676] * u8 + z[677] * u1 + z[678] * u2) + z[51] * (z[687] + z[680] * u5 + z[681] * u8 + z[682] * u6 + z[683] * u4 + z[684] * u3 + z[685] * u1 + z[686] * u2) + z[64] * (z[625] + z[616] * u3 + z[617] * u4 + z[618] * u6 + z[619] * u8 + z[620] * u5 + z[621] * u7 + z[622] * u9 + z[623] * u1 + z[624] * u2) + z[66] * (z[635] + z[626] * u8 + z[627] * u6 + z[628] * u4 + z[629] * u3 + z[630] * u5 + z[631] * u7 + z[632] * u9 + z[633] * u1 + z[634] * u2) + z[52] * (z[647] + z[664] + z[640] * u3 + z[641] * u4 + z[642] * u6 + z[643] * u8 + z[644] * u5 + z[657] * u3 + z[658] * u4 + z[659] * u6 + z[660] * u8 + z[661] * u5 + z[645] * u1 + z[646] * u2 + z[662] * u1 + z[663] * u2) + z[54] * (z[656] + z[673] + z[648] * u7 + z[665] * u7 + z[649] * u8 + z[650] * u6 + z[651] * u4 + z[652] * u3 + z[653] * u5 + z[666] * u8 + z[667] * u6 + z[668] * u4 + z[669] * u3 + z[670] * u5 + z[654] * u1 + z[655] * u2 + z[671] * u1 + z[672] * u2)) - z[607] * z[2] * u3) - 0.5 * z[40] * (z[702] + z[638] * u3 + z[638] * u4 + z[638] * u6 + z[638] * u8)) - 0.5 * z[62] * (z[639] + z[638] * u3 + z[638] * u5 + z[638] * u7 + z[638] * u9)) - 0.5 * z[44] * (z[701] + 2 * z[611] + z[700] * u3 + z[700] * u4 + z[700] * u6 + z[700] * u8 + 2 * z[610] * u3 + 2 * z[610] * u4 + 2 * z[610] * u6 + 2 * z[610] * u8)) - z[48] * ((((((((z[615] + z[614] * u3 + z[614] * u4) - z[722]) - z[717] * u8) - z[718] * u6) - z[719] * u3) - z[719] * u4) - z[720] * u1) - z[721] * u2)) - z[29] * ((((((((z[613] + z[612] * u3 + z[612] * u4 + z[612] * u6) - z[711]) - z[707] * u8) - z[708] * u3) - z[708] * u4) - z[708] * u6) - z[709] * u1) - z[710] * u2)) - z[33] * (((((z[609] + z[693] + z[699] + z[608] * u3 + z[608] * u4 + z[608] * u6 + z[608] * u8 + z[692] * u3 + z[692] * u4 + z[692] * u6 + z[692] * u8 + z[698] * u3 + z[698] * u4 + z[698] * u6 + z[698] * u8) - z[690] * u1) - z[691] * u2) - z[696] * u1) - z[697] * u2)
end

px(sol) = [px(sol, t) for t in sol.t]


function py(sol, t)
    @unpack z, mhat, u5, u7, u9, u4, u6, u8 = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((((z[606] * z[2] + mhat * u2 + z[607] * z[1] * u3 + z[32] * (z[688] * u1 + z[689] * u2 + z[694] * u1 + z[695] * u2) + z[59] * (z[637] + z[636] * u3 + z[636] * u5 + z[636] * u7 + z[636] * u9) + z[28] * (z[706] + z[703] * u3 + z[703] * u4 + z[703] * u6 + z[703] * u8 + z[704] * u1 + z[705] * u2) + z[47] * (z[716] + z[712] * u3 + z[712] * u4 + z[712] * u6 + z[713] * u8 + z[714] * u1 + z[715] * u2) + z[50] * (z[679] + z[674] * u3 + z[674] * u4 + z[675] * u6 + z[676] * u8 + z[677] * u1 + z[678] * u2) + z[49] * (z[687] + z[680] * u5 + z[681] * u8 + z[682] * u6 + z[683] * u4 + z[684] * u3 + z[685] * u1 + z[686] * u2) + z[65] * (z[625] + z[616] * u3 + z[617] * u4 + z[618] * u6 + z[619] * u8 + z[620] * u5 + z[621] * u7 + z[622] * u9 + z[623] * u1 + z[624] * u2) + z[67] * (z[635] + z[626] * u8 + z[627] * u6 + z[628] * u4 + z[629] * u3 + z[630] * u5 + z[631] * u7 + z[632] * u9 + z[633] * u1 + z[634] * u2) + z[53] * (z[647] + z[664] + z[640] * u3 + z[641] * u4 + z[642] * u6 + z[643] * u8 + z[644] * u5 + z[657] * u3 + z[658] * u4 + z[659] * u6 + z[660] * u8 + z[661] * u5 + z[645] * u1 + z[646] * u2 + z[662] * u1 + z[663] * u2) + z[55] * (z[656] + z[673] + z[648] * u7 + z[665] * u7 + z[649] * u8 + z[650] * u6 + z[651] * u4 + z[652] * u3 + z[653] * u5 + z[666] * u8 + z[667] * u6 + z[668] * u4 + z[669] * u3 + z[670] * u5 + z[654] * u1 + z[655] * u2 + z[671] * u1 + z[672] * u2)) - 0.5 * z[41] * (z[702] + z[638] * u3 + z[638] * u4 + z[638] * u6 + z[638] * u8)) - 0.5 * z[63] * (z[639] + z[638] * u3 + z[638] * u5 + z[638] * u7 + z[638] * u9)) - 0.5 * z[45] * (z[701] + 2 * z[611] + z[700] * u3 + z[700] * u4 + z[700] * u6 + z[700] * u8 + 2 * z[610] * u3 + 2 * z[610] * u4 + 2 * z[610] * u6 + 2 * z[610] * u8)) - z[46] * ((((((((z[615] + z[614] * u3 + z[614] * u4) - z[722]) - z[717] * u8) - z[718] * u6) - z[719] * u3) - z[719] * u4) - z[720] * u1) - z[721] * u2)) - z[30] * ((((((((z[613] + z[612] * u3 + z[612] * u4 + z[612] * u6) - z[711]) - z[707] * u8) - z[708] * u3) - z[708] * u4) - z[708] * u6) - z[709] * u1) - z[710] * u2)) - z[34] * (((((z[609] + z[693] + z[699] + z[608] * u3 + z[608] * u4 + z[608] * u6 + z[608] * u8 + z[692] * u3 + z[692] * u4 + z[692] * u6 + z[692] * u8 + z[698] * u3 + z[698] * u4 + z[698] * u6 + z[698] * u8) - z[690] * u1) - z[691] * u2) - z[696] * u1) - z[697] * u2)
end

py(sol) = [py(sol, t) for t in sol.t]


function rhtq(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[818] + z[776] * u3p + z[777] * u1p + z[778] * u2p
end

rhtq(sol) = [rhtq(sol, t) for t in sol.t]


function lhtq(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[819] + z[781] * u3p + z[782] * u1p + z[783] * u2p
end

lhtq(sol) = [lhtq(sol, t) for t in sol.t]


function rktq(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[820] + z[787] * u3p + z[788] * u1p + z[789] * u2p
end

rktq(sol) = [rktq(sol, t) for t in sol.t]


function lktq(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[821] + z[794] * u3p + z[795] * u1p + z[796] * u2p
end

lktq(sol) = [lktq(sol, t) for t in sol.t]


function ratq(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[822] + z[800] * u3p + z[801] * u1p + z[802] * u2p
end

ratq(sol) = [ratq(sol, t) for t in sol.t]


function latq(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[823] + z[805] * u3p + z[806] * u1p + z[807] * u2p
end

latq(sol) = [latq(sol, t) for t in sol.t]


function pop1x(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q1
end

pop1x(sol) = [pop1x(sol, t) for t in sol.t]


function pop1y(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q2
end

pop1y(sol) = [pop1y(sol, t) for t in sol.t]


function pop3x(sol, t)
    @unpack z, lff, lrff = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (q1 - lff * z[31]) - lrff * z[38]
end

pop3x(sol) = [pop3x(sol, t) for t in sol.t]


function pop3y(sol, t)
    @unpack z, lff, lrff = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (q2 - lff * z[32]) - lrff * z[39]
end

pop3y(sol) = [pop3y(sol, t) for t in sol.t]


function pop4x(sol, t)
    @unpack z, lff, lrf = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (q1 - lff * z[31]) - lrf * z[42]
end

pop4x(sol) = [pop4x(sol, t) for t in sol.t]


function pop4y(sol, t)
    @unpack z, lff, lrf = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (q2 - lff * z[32]) - lrf * z[43]
end

pop4y(sol) = [pop4y(sol, t) for t in sol.t]


function pop5x(sol, t)
    @unpack z, lff, lrf, lsh = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((q1 - lff * z[31]) - lrf * z[42]) - lsh * z[27]
end

pop5x(sol) = [pop5x(sol, t) for t in sol.t]


function pop5y(sol, t)
    @unpack z, lff, lrf, lsh = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((q2 - lff * z[32]) - lrf * z[43]) - lsh * z[28]
end

pop5y(sol) = [pop5y(sol, t) for t in sol.t]


function pop6x(sol, t)
    @unpack z, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((q1 - lff * z[31]) - lrf * z[42]) - lsh * z[27]) - lth * z[46]
end

pop6x(sol) = [pop6x(sol, t) for t in sol.t]


function pop6y(sol, t)
    @unpack z, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((q2 - lff * z[32]) - lrf * z[43]) - lsh * z[28]) - lth * z[47]
end

pop6y(sol) = [pop6y(sol, t) for t in sol.t]


function pop7x(sol, t)
    @unpack z, lth, lff, lrf, lsh = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lth * z[49]) - lff * z[31]) - lrf * z[42]) - lsh * z[27]) - lth * z[46]
end

pop7x(sol) = [pop7x(sol, t) for t in sol.t]


function pop7y(sol, t)
    @unpack z, lth, lff, lrf, lsh = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lth * z[50]) - lff * z[32]) - lrf * z[43]) - lsh * z[28]) - lth * z[47]
end

pop7y(sol) = [pop7y(sol, t) for t in sol.t]


function pop8x(sol, t)
    @unpack z, lsh, lth, lff, lrf = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lsh * z[52] + lth * z[49]) - lff * z[31]) - lrf * z[42]) - lsh * z[27]) - lth * z[46]
end

pop8x(sol) = [pop8x(sol, t) for t in sol.t]


function pop8y(sol, t)
    @unpack z, lsh, lth, lff, lrf = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lsh * z[53] + lth * z[50]) - lff * z[32]) - lrf * z[43]) - lsh * z[28]) - lth * z[47]
end

pop8y(sol) = [pop8y(sol, t) for t in sol.t]


function pop9x(sol, t)
    @unpack z, lrf, lsh, lth, lff, lrff = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((((q1 + lrf * z[56] + lsh * z[52] + lth * z[49]) - lff * z[31]) - lrf * z[42]) - lrff * z[60]) - lsh * z[27]) - lth * z[46]
end

pop9x(sol) = [pop9x(sol, t) for t in sol.t]


function pop9y(sol, t)
    @unpack z, lrf, lsh, lth, lff, lrff = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((((q2 + lrf * z[57] + lsh * z[53] + lth * z[50]) - lff * z[32]) - lrf * z[43]) - lrff * z[61]) - lsh * z[28]) - lth * z[47]
end

pop9y(sol) = [pop9y(sol, t) for t in sol.t]


function pop12x(sol, t)
    @unpack z, lhat, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lhat * z[1]) - lff * z[31]) - lrf * z[42]) - lsh * z[27]) - lth * z[46]
end

pop12x(sol) = [pop12x(sol, t) for t in sol.t]


function pop12y(sol, t)
    @unpack z, lhat, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lhat * z[2]) - lff * z[32]) - lrf * z[43]) - lsh * z[28]) - lth * z[47]
end

pop12y(sol) = [pop12y(sol, t) for t in sol.t]


function pohatox(sol, t)
    @unpack z, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)
    hato = _hato(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q1 + hato * z[1]) - lff * z[31]) - lrf * z[42]) - lsh * z[27]) - lth * z[46]
end

pohatox(sol) = [pohatox(sol, t) for t in sol.t]


function pohatoy(sol, t)
    @unpack z, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)
    hato = _hato(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q2 + hato * z[2]) - lff * z[32]) - lrf * z[43]) - lsh * z[28]) - lth * z[47]
end

pohatoy(sol) = [pohatoy(sol, t) for t in sol.t]


function pocmx(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((((q1 + z[74] * z[64] + z[75] * z[56] + z[77] * z[52] + z[78] * z[49] + z[73] * z[1]) - z[79] * z[31]) - z[81] * z[27]) - z[82] * z[46]) - 0.5 * z[76] * z[38]) - 0.5 * z[76] * z[60]) - 0.5 * z[80] * z[42]
end

pocmx(sol) = [pocmx(sol, t) for t in sol.t]


function vocmx(sol, t)
    @unpack z, u5, u7, u9, u4, u6, u8 = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((((((z[281] * z[1] + u1 + z[51] * (z[286] + z[78] * u3 + z[78] * u5) + z[54] * (z[285] + z[77] * u3 + z[77] * u5 + z[77] * u7) + z[58] * (z[283] + z[75] * u3 + z[75] * u5 + z[75] * u7 + z[75] * u9) + z[66] * (z[282] + z[74] * u3 + z[74] * u5 + z[74] * u7 + z[74] * u9)) - z[73] * z[2] * u3) - z[48] * (z[291] + z[82] * u3 + z[82] * u4)) - z[29] * (z[290] + z[81] * u3 + z[81] * u4 + z[81] * u6)) - z[33] * (z[287] + z[79] * u3 + z[79] * u4 + z[79] * u6 + z[79] * u8)) - 0.5 * z[40] * (z[289] + z[76] * u3 + z[76] * u4 + z[76] * u6 + z[76] * u8)) - 0.5 * z[44] * (z[288] + z[80] * u3 + z[80] * u4 + z[80] * u6 + z[80] * u8)) - 0.5 * z[62] * (z[284] + z[76] * u3 + z[76] * u5 + z[76] * u7 + z[76] * u9)
end

vocmx(sol) = [vocmx(sol, t) for t in sol.t]


function vocmy(sol, t)
    @unpack z, u5, u7, u9, u4, u6, u8 = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((((z[281] * z[2] + u2 + z[73] * z[1] * u3 + z[49] * (z[286] + z[78] * u3 + z[78] * u5) + z[55] * (z[285] + z[77] * u3 + z[77] * u5 + z[77] * u7) + z[59] * (z[283] + z[75] * u3 + z[75] * u5 + z[75] * u7 + z[75] * u9) + z[67] * (z[282] + z[74] * u3 + z[74] * u5 + z[74] * u7 + z[74] * u9)) - z[46] * (z[291] + z[82] * u3 + z[82] * u4)) - z[30] * (z[290] + z[81] * u3 + z[81] * u4 + z[81] * u6)) - z[34] * (z[287] + z[79] * u3 + z[79] * u4 + z[79] * u6 + z[79] * u8)) - 0.5 * z[41] * (z[289] + z[76] * u3 + z[76] * u4 + z[76] * u6 + z[76] * u8)) - 0.5 * z[45] * (z[288] + z[80] * u3 + z[80] * u4 + z[80] * u6 + z[80] * u8)) - 0.5 * z[63] * (z[284] + z[76] * u3 + z[76] * u5 + z[76] * u7 + z[76] * u9)
end

vocmy(sol) = [vocmy(sol, t) for t in sol.t]


function rmtq(sol, t)
    @unpack z, mtpk, mtpb = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)
    rmtp, rmtpp = _rmtp(t), _rmtpp(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return mtpk * (3.141592653589793 - rmtp) - mtpb * rmtpp
end

rmtq(sol) = [rmtq(sol, t) for t in sol.t]


function lmtq(sol, t)
    @unpack z, mtpk, mtpb = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)
    lmtp, lmtpp = _lmtp(t), _lmtpp(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return mtpk * (3.141592653589793 - lmtp) - mtpb * lmtpp
end

lmtq(sol) = [lmtq(sol, t) for t in sol.t]


function rrx(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return rrx1 + rrx2
end

rrx(sol) = [rrx(sol, t) for t in sol.t]


function rry(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return rry1 + rry2
end

rry(sol) = [rry(sol, t) for t in sol.t]


function lrx(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return lrx1 + lrx2
end

lrx(sol) = [lrx(sol, t) for t in sol.t]


function lry(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return lry1 + lry2
end

lry(sol) = [lry(sol, t) for t in sol.t]


function io(sol, t)
    @unpack z, mhat, iff, irf, ish, ith, lff, lffo, mff, u8, u6, u4, u5, u7, u9, lsh, lsho, msh, lth, ltho, mth, mrf, lrffo, lrfo, lrf = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    u4 = 0
    u5 = 0
    u6 = 0
    u7 = 0
    u8 = 0
    u9 = 0
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
    z[149] = z[145] - z[147]
    z[165] = z[162] - z[163]
    z[186] = z[183] + z[184]
    z[210] = z[205] + z[207]
    z[209] = z[70] + z[198]
    z[271] = z[264] + z[266]
    z[268] = z[68] + z[260]
    z[269] = z[68] + z[261]
    z[270] = z[68] + z[255]
    z[73] = (mhat * hato) / z[72]
    z[36] = z[19] * z[12] + z[20] * z[11]
    z[39] = z[35] * z[28] + z[36] * z[30]
    z[61] = z[19] * z[57] + z[20] * z[59]
    z[402] = iff * z[265]
    z[403] = irf * z[215]
    z[404] = ish * z[206]
    z[405] = ith * lhp
    z[406] = iff * z[117]
    z[407] = irf * z[120]
    z[408] = ish * z[146]
    z[409] = ith * rhp
    z[115] = z[1] * z[65] - z[2] * z[64]
    z[103] = z[1] * z[57] - z[2] * z[56]
    z[91] = z[1] * z[53] - z[2] * z[52]
    z[38] = z[35] * z[27] + z[36] * z[29]
    z[123] = z[1] * z[39] - z[2] * z[38]
    z[60] = z[19] * z[56] + z[20] * z[58]
    z[218] = z[1] * z[61] - z[2] * z[60]
    z[574] = mhat * hatop * (((((((2 * z[78] * z[6] + 2 * z[74] * z[115] + 2 * z[75] * z[103] + 2 * z[77] * z[91]) - 2 * z[413] * z[25]) - 2 * z[414] * z[4]) - 2 * z[411] * z[109]) - 2 * z[412] * z[97]) - z[76] * z[123]) - z[76] * z[218])
    z[410] = hato - z[73]
    z[576] = mhat * ((((((((2 * z[74] * z[65] + 2 * z[75] * z[57] + 2 * z[77] * z[53] + 2 * z[78] * z[50]) - 2 * z[411] * z[32]) - 2 * z[412] * z[43]) - 2 * z[413] * z[28]) - 2 * z[414] * z[47]) - 2 * z[410] * z[2]) - z[76] * z[39]) - z[76] * z[61])
    z[498] = z[13] * z[17] - z[14] * z[18]
    z[495] = z[19] * z[17] + z[20] * z[18]
    z[113] = z[1] * z[64] + z[2] * z[65]
    z[501] = z[5] * z[113] + z[6] * z[115]
    z[419] = z[42] * z[64] + z[43] * z[65]
    z[420] = z[44] * z[64] + z[45] * z[65]
    z[505] = z[19] * z[419] + z[20] * z[420]
    z[415] = z[31] * z[64] + z[32] * z[65]
    z[423] = z[27] * z[64] + z[28] * z[65]
    z[427] = z[46] * z[64] + z[47] * z[65]
    z[516] = (((((((lff + z[509] * z[17] + z[510] * z[498] + 0.5 * z[76] * z[495] + z[511] * z[501] + 0.5 * z[76] * z[505]) - lffo) - z[74]) - z[512] * z[415]) - z[513] * z[423]) - z[514] * z[427]) - z[73] * z[113]) - 0.5 * z[515] * z[419]
    z[582] = mff * z[516]
    z[519] = z[271] + z[256] * u8 + z[257] * u6 + z[258] * u4 + z[267] * u3 + z[268] * u5 + z[269] * u7 + z[270] * u9 + z[262] * u1 + z[263] * u2
    z[421] = z[42] * z[66] + z[43] * z[67]
    z[435] = z[17] * z[419] - z[18] * z[421]
    z[437] = z[17] * z[421] + z[18] * z[419]
    z[467] = z[13] * z[435] - z[14] * z[437]
    z[422] = z[44] * z[66] + z[45] * z[67]
    z[436] = z[17] * z[420] - z[18] * z[422]
    z[438] = z[17] * z[422] + z[18] * z[420]
    z[468] = z[13] * z[436] - z[14] * z[438]
    z[542] = z[19] * z[467] + z[20] * z[468]
    z[475] = z[9] * z[169] + z[10] * z[170]
    z[417] = z[31] * z[66] + z[32] * z[67]
    z[431] = z[17] * z[415] - z[18] * z[417]
    z[433] = z[17] * z[417] + z[18] * z[415]
    z[463] = z[13] * z[431] - z[14] * z[433]
    z[425] = z[27] * z[66] + z[28] * z[67]
    z[439] = z[17] * z[423] - z[18] * z[425]
    z[441] = z[17] * z[425] + z[18] * z[423]
    z[471] = z[13] * z[439] - z[14] * z[441]
    z[89] = z[1] * z[52] + z[2] * z[53]
    z[546] = (((((((((lsh + z[511] * z[9] + 0.5 * z[76] * z[396] + 0.5 * z[76] * z[542]) - lsho) - z[77]) - z[74] * z[498]) - z[75] * z[13]) - z[514] * z[475]) - z[512] * z[463]) - z[513] * z[471]) - z[73] * z[89]) - 0.5 * z[515] * z[467]
    z[590] = msh * z[546]
    z[548] = z[210] + z[70] * u7 + z[199] * u8 + z[200] * u6 + z[201] * u4 + z[208] * u3 + z[209] * u5 + z[203] * u1 + z[204] * u2
    z[216] = z[1] * z[60] + z[2] * z[61]
    z[530] = z[5] * z[216] + z[6] * z[218]
    z[95] = z[1] * z[42] + z[2] * z[43]
    z[483] = z[5] * z[95] + z[6] * z[97]
    z[484] = z[5] * z[96] + z[6] * z[98]
    z[549] = z[19] * z[483] + z[20] * z[484]
    z[487] = z[5] * z[24] + z[6] * z[25]
    z[101] = z[1] * z[56] + z[2] * z[57]
    z[526] = z[5] * z[101] + z[6] * z[103]
    z[107] = z[1] * z[31] + z[2] * z[32]
    z[479] = z[5] * z[107] + z[6] * z[109]
    z[553] = ((((((((((lth + 0.5 * z[76] * z[530] + 0.5 * z[76] * z[549]) - ltho) - z[78]) - z[77] * z[9]) - z[513] * z[487]) - z[514] * z[169]) - z[5] * z[73]) - z[74] * z[501]) - z[75] * z[526]) - z[512] * z[479]) - 0.5 * z[515] * z[483]
    z[592] = mth * z[553]
    z[556] = z[186] + z[71] * u5 + z[178] * u8 + z[179] * u6 + z[180] * u4 + z[185] * u3 + z[181] * u1 + z[182] * u2
    z[389] = z[7] * z[21] - z[8] * z[22]
    z[447] = z[19] * z[431] + z[20] * z[433]
    z[557] = ((((((z[79] + z[81] * z[21] + z[82] * z[389] + 0.5 * z[76] * z[399] + 0.5 * z[80] * z[15] + 0.5 * z[76] * z[447]) - lffo) - z[74] * z[415]) - z[75] * z[431]) - z[77] * z[463]) - z[78] * z[479]) - z[73] * z[107]
    z[594] = mff * z[557]
    z[560] = (((((z[33] * u1 + z[34] * u2) - z[118]) - lffo * u3) - lffo * u4) - lffo * u6) - lffo * u8
    z[455] = z[19] * z[439] + z[20] * z[441]
    z[565] = ((((((((z[81] + z[82] * z[7] + 0.5 * z[76] * z[35] + 0.5 * z[76] * z[455]) - lsho) - z[78] * z[487]) - z[512] * z[21]) - z[24] * z[73]) - 0.5 * z[515] * z[11]) - z[74] * z[423]) - z[75] * z[439]) - z[77] * z[471]
    z[602] = msh * z[565]
    z[568] = z[149] + z[142] * u8 + z[148] * u3 + z[148] * u4 + z[148] * u6 + z[143] * u1 + z[144] * u2
    z[491] = z[19] * z[393] + z[20] * z[395]
    z[429] = z[46] * z[66] + z[47] * z[67]
    z[443] = z[17] * z[427] - z[18] * z[429]
    z[445] = z[17] * z[429] + z[18] * z[427]
    z[459] = z[19] * z[443] + z[20] * z[445]
    z[569] = (((((((((z[82] + 0.5 * z[76] * z[491] + 0.5 * z[76] * z[459]) - ltho) - z[77] * z[475]) - z[78] * z[169]) - z[512] * z[389]) - z[513] * z[7]) - z[3] * z[73]) - 0.5 * z[515] * z[393]) - z[74] * z[427]) - z[75] * z[443]
    z[604] = mth * z[569]
    z[572] = z[165] + z[158] * u8 + z[159] * u6 + z[164] * u3 + z[164] * u4 + z[160] * u1 + z[161] * u2
    z[580] = mhat * (((((2 * z[413] + z[76] * z[35] + 2 * z[411] * z[21] + 2 * z[412] * z[11] + 2 * z[414] * z[7] + 2 * z[24] * z[410] + z[76] * z[455]) - 2 * z[78] * z[487]) - 2 * z[74] * z[423]) - 2 * z[75] * z[439]) - 2 * z[77] * z[471])
    z[534] = z[19] * z[435] + z[20] * z[436]
    z[585] = mrf * (((z[584] + 2 * z[510] * z[13] + z[76] * z[534] + 2 * z[411] * z[431] + 2 * z[412] * z[435] + 2 * z[413] * z[439] + 2 * z[414] * z[443] + 2 * z[511] * z[526]) - 2 * z[74] * z[17]) - 2 * z[73] * z[101])
    z[522] = z[220] + z[69] * u3 + z[69] * u5 + z[69] * u7 + z[69] * u9
    z[451] = z[19] * z[435] + z[20] * z[437]
    z[452] = z[19] * z[436] + z[20] * z[438]
    z[538] = z[19] * z[451] + z[20] * z[452]
    z[587] = mrf * (((z[586] + 2 * z[510] * z[396] + z[76] * z[538] + 2 * z[411] * z[447] + 2 * z[412] * z[451] + 2 * z[413] * z[455] + 2 * z[414] * z[459] + 2 * z[511] * z[530]) - 2 * z[74] * z[495]) - 2 * z[73] * z[216])
    z[523] = (((-0.5 * z[221] - 0.5 * lrffo * u3) - 0.5 * lrffo * u5) - 0.5 * lrffo * u7) - 0.5 * lrffo * u9
    z[589] = mrf * (((2 * z[510] + 2 * z[414] * z[475] + 2 * z[511] * z[9] + 2 * z[520] * z[13] + 2 * z[521] * z[396] + z[76] * z[542] + 2 * z[411] * z[463] + 2 * z[412] * z[467] + 2 * z[413] * z[471]) - 2 * z[74] * z[498]) - 2 * z[73] * z[89])
    z[525] = z[214] + lsh * u7 + z[199] * u8 + z[200] * u6 + z[201] * u4 + z[212] * u3 + z[213] * u5 + z[203] * u1 + z[204] * u2
    z[597] = mrf * ((((((2 * z[411] + 2 * z[81] * z[21] + 2 * z[82] * z[389] + 2 * z[521] * z[399] + 2 * z[561] * z[15] + z[76] * z[447]) - 2 * z[74] * z[415]) - 2 * z[75] * z[431]) - 2 * z[77] * z[463]) - 2 * z[78] * z[479]) - 2 * z[73] * z[107])
    z[562] = (((((z[33] * u1 + z[34] * u2) - z[119]) - lff * u3) - lff * u4) - lff * u6) - lff * u8
    z[599] = mrf * ((((((z[598] + 2 * z[81] * z[11] + 2 * z[82] * z[393] + 2 * z[411] * z[15] + z[76] * z[451]) - 2 * z[74] * z[419]) - 2 * z[75] * z[435]) - 2 * z[77] * z[467]) - 2 * z[78] * z[483]) - 2 * z[73] * z[95])
    z[563] = (((-0.5 * z[125] - 0.5 * lrfo * u3) - 0.5 * lrfo * u4) - 0.5 * lrfo * u6) - 0.5 * lrfo * u8
    z[121] = z[1] * z[38] + z[2] * z[39]
    z[601] = mrf * ((((((z[600] + 2 * z[81] * z[35] + 2 * z[82] * z[491] + 2 * z[411] * z[399] + z[76] * z[538]) - 2 * z[74] * z[505]) - 2 * z[75] * z[534]) - 2 * z[77] * z[542]) - 2 * z[78] * z[549]) - 2 * z[73] * z[121])
    z[564] = (((-0.5 * z[126] - 0.5 * lrffo * u3) - 0.5 * lrffo * u4) - 0.5 * lrffo * u6) - 0.5 * lrffo * u8
    z[575] = mhat * ((((((((2 * z[74] * z[64] + 2 * z[75] * z[56] + 2 * z[77] * z[52] + 2 * z[78] * z[49]) - 2 * z[411] * z[31]) - 2 * z[412] * z[42]) - 2 * z[413] * z[27]) - 2 * z[414] * z[46]) - 2 * z[410] * z[1]) - z[76] * z[38]) - z[76] * z[60])
    z[499] = -(z[13]) * z[18] - z[14] * z[17]
    z[496] = z[20] * z[17] - z[19] * z[18]
    z[114] = z[1] * z[66] + z[2] * z[67]
    z[116] = z[1] * z[67] - z[2] * z[66]
    z[502] = z[5] * z[114] + z[6] * z[116]
    z[506] = z[19] * z[421] + z[20] * z[422]
    z[517] = ((((((z[510] * z[499] + 0.5 * z[76] * z[496] + z[511] * z[502] + 0.5 * z[76] * z[506]) - z[509] * z[18]) - z[512] * z[417]) - z[513] * z[425]) - z[514] * z[429]) - z[73] * z[114]) - 0.5 * z[515] * z[421]
    z[583] = mff * z[517]
    z[518] = z[254] + z[245] * u3 + z[246] * u4 + z[247] * u6 + z[248] * u8 + z[249] * u5 + z[250] * u7 + z[253] * u9 + z[251] * u1 + z[252] * u2
    z[469] = z[13] * z[437] + z[14] * z[435]
    z[470] = z[13] * z[438] + z[14] * z[436]
    z[543] = z[19] * z[469] + z[20] * z[470]
    z[500] = z[13] * z[18] + z[14] * z[17]
    z[477] = z[9] * z[170] - z[10] * z[169]
    z[465] = z[13] * z[433] + z[14] * z[431]
    z[473] = z[13] * z[441] + z[14] * z[439]
    z[90] = z[1] * z[54] + z[2] * z[55]
    z[547] = ((((((((0.5 * z[76] * z[397] + 0.5 * z[76] * z[543]) - z[74] * z[500]) - z[75] * z[14]) - z[511] * z[10]) - z[514] * z[477]) - z[512] * z[465]) - z[513] * z[473]) - z[73] * z[90]) - 0.5 * z[515] * z[469]
    z[591] = msh * z[547]
    z[524] = z[197] + z[190] * u3 + z[191] * u4 + z[192] * u6 + z[193] * u8 + z[196] * u5 + z[194] * u1 + z[195] * u2
    z[532] = z[5] * z[218] - z[6] * z[216]
    z[485] = z[5] * z[97] - z[6] * z[95]
    z[486] = z[5] * z[98] - z[6] * z[96]
    z[550] = z[19] * z[485] + z[20] * z[486]
    z[489] = z[5] * z[25] - z[6] * z[24]
    z[503] = z[5] * z[115] - z[6] * z[113]
    z[528] = z[5] * z[103] - z[6] * z[101]
    z[481] = z[5] * z[109] - z[6] * z[107]
    z[554] = (((((((z[6] * z[73] + 0.5 * z[76] * z[532] + 0.5 * z[76] * z[550]) - z[77] * z[10]) - z[513] * z[489]) - z[514] * z[170]) - z[74] * z[503]) - z[75] * z[528]) - z[512] * z[481]) - 0.5 * z[515] * z[485]
    z[593] = mth * z[554]
    z[555] = z[177] + z[172] * u3 + z[172] * u4 + z[173] * u6 + z[174] * u8 + z[175] * u1 + z[176] * u2
    z[416] = z[33] * z[64] + z[34] * z[65]
    z[418] = z[33] * z[66] + z[34] * z[67]
    z[432] = z[17] * z[416] - z[18] * z[418]
    z[434] = z[17] * z[418] + z[18] * z[416]
    z[448] = z[19] * z[432] + z[20] * z[434]
    z[464] = z[13] * z[432] - z[14] * z[434]
    z[480] = z[5] * z[108] + z[6] * z[110]
    z[558] = ((((((z[81] * z[23] + z[82] * z[391] + 0.5 * z[76] * z[401] + 0.5 * z[76] * z[448]) - 0.5 * z[80] * z[16]) - z[74] * z[416]) - z[75] * z[432]) - z[77] * z[464]) - z[78] * z[480]) - z[73] * z[108]
    z[595] = mff * z[558]
    z[559] = z[31] * u1 + z[32] * u2
    z[424] = z[29] * z[64] + z[30] * z[65]
    z[426] = z[29] * z[66] + z[30] * z[67]
    z[440] = z[17] * z[424] - z[18] * z[426]
    z[442] = z[17] * z[426] + z[18] * z[424]
    z[456] = z[19] * z[440] + z[20] * z[442]
    z[488] = z[5] * z[26] + z[6] * z[24]
    z[472] = z[13] * z[440] - z[14] * z[442]
    z[566] = ((((((((0.5 * z[76] * z[36] + 0.5 * z[76] * z[456]) - z[78] * z[488]) - z[82] * z[8]) - z[512] * z[22]) - z[26] * z[73]) - 0.5 * z[515] * z[12]) - z[74] * z[424]) - z[75] * z[440]) - z[77] * z[472]
    z[603] = msh * z[566]
    z[567] = z[141] + z[138] * u3 + z[138] * u4 + z[138] * u6 + z[138] * u8 + z[139] * u1 + z[140] * u2
    z[492] = z[19] * z[394] + z[20] * z[393]
    z[428] = z[46] * z[65] + z[48] * z[64]
    z[430] = z[46] * z[67] + z[48] * z[66]
    z[444] = z[17] * z[428] - z[18] * z[430]
    z[446] = z[17] * z[430] + z[18] * z[428]
    z[460] = z[19] * z[444] + z[20] * z[446]
    z[476] = z[9] * z[171] + z[10] * z[169]
    z[570] = (((((((z[4] * z[73] + 0.5 * z[76] * z[492] + 0.5 * z[76] * z[460]) - z[77] * z[476]) - z[78] * z[171]) - z[512] * z[390]) - z[513] * z[8]) - 0.5 * z[515] * z[394]) - z[74] * z[428]) - z[75] * z[444]
    z[605] = mth * z[570]
    z[571] = z[157] + z[153] * u3 + z[153] * u4 + z[153] * u6 + z[154] * u8 + z[155] * u1 + z[156] * u2
    z[573] = mhat * ((((((((2 * z[78] * z[5] + 2 * z[74] * z[113] + 2 * z[75] * z[101] + 2 * z[77] * z[89]) - 2 * z[410]) - 2 * z[413] * z[24]) - 2 * z[414] * z[3]) - 2 * z[411] * z[107]) - 2 * z[412] * z[95]) - z[76] * z[121]) - z[76] * z[216])
    z[577] = mhat * ((((((((2 * z[74] * z[415] + 2 * z[75] * z[431] + 2 * z[77] * z[463] + 2 * z[78] * z[479]) - 2 * z[411]) - 2 * z[412] * z[15]) - 2 * z[413] * z[21]) - 2 * z[414] * z[389]) - z[76] * z[399]) - 2 * z[410] * z[107]) - z[76] * z[447])
    z[579] = mhat * ((((((((2 * z[74] * z[419] + 2 * z[75] * z[435] + 2 * z[77] * z[467] + 2 * z[78] * z[483]) - 2 * z[412]) - z[578]) - 2 * z[411] * z[15]) - 2 * z[413] * z[11]) - 2 * z[414] * z[393]) - 2 * z[410] * z[95]) - z[76] * z[451])
    z[581] = mhat * ((((((((2 * z[77] * z[475] + 2 * z[78] * z[169] + 2 * z[74] * z[427] + 2 * z[75] * z[443]) - 2 * z[414]) - 2 * z[411] * z[389]) - 2 * z[412] * z[393]) - 2 * z[413] * z[7]) - 2 * z[3] * z[410]) - z[76] * z[491]) - z[76] * z[459])
    z[588] = mrf * ((((2 * z[414] * z[477] + 2 * z[520] * z[14] + 2 * z[521] * z[397] + z[76] * z[543] + 2 * z[411] * z[465] + 2 * z[412] * z[469] + 2 * z[413] * z[473]) - 2 * z[74] * z[500]) - 2 * z[511] * z[10]) - 2 * z[73] * z[90])
    z[596] = mrf * (((((((2 * z[81] * z[23] + 2 * z[82] * z[391] + 2 * z[521] * z[401] + z[76] * z[448]) - 2 * z[561] * z[16]) - 2 * z[74] * z[416]) - 2 * z[75] * z[432]) - 2 * z[77] * z[464]) - 2 * z[78] * z[480]) - 2 * z[73] * z[108])
    z[606] = mhat * hatop
    z[688] = mff * z[31]
    z[689] = mff * z[32]
    z[694] = mrf * z[31]
    z[695] = mrf * z[32]
    z[637] = mrf * z[220]
    z[706] = msh * z[141]
    z[703] = msh * z[138]
    z[704] = msh * z[139]
    z[705] = msh * z[140]
    z[716] = mth * z[157]
    z[712] = mth * z[153]
    z[713] = mth * z[154]
    z[714] = mth * z[155]
    z[715] = mth * z[156]
    z[679] = mth * z[177]
    z[674] = mth * z[172]
    z[675] = mth * z[173]
    z[676] = mth * z[174]
    z[677] = mth * z[175]
    z[678] = mth * z[176]
    z[687] = mth * z[186]
    z[681] = mth * z[178]
    z[682] = mth * z[179]
    z[683] = mth * z[180]
    z[684] = mth * z[185]
    z[685] = mth * z[181]
    z[686] = mth * z[182]
    z[625] = mff * z[254]
    z[616] = mff * z[245]
    z[617] = mff * z[246]
    z[618] = mff * z[247]
    z[619] = mff * z[248]
    z[620] = mff * z[249]
    z[621] = mff * z[250]
    z[622] = mff * z[253]
    z[623] = mff * z[251]
    z[624] = mff * z[252]
    z[635] = mff * z[271]
    z[626] = mff * z[256]
    z[627] = mff * z[257]
    z[628] = mff * z[258]
    z[629] = mff * z[267]
    z[630] = mff * z[268]
    z[631] = mff * z[269]
    z[632] = mff * z[270]
    z[633] = mff * z[262]
    z[634] = mff * z[263]
    z[647] = mrf * z[197]
    z[664] = msh * z[197]
    z[640] = mrf * z[190]
    z[641] = mrf * z[191]
    z[642] = mrf * z[192]
    z[643] = mrf * z[193]
    z[644] = mrf * z[196]
    z[657] = msh * z[190]
    z[658] = msh * z[191]
    z[659] = msh * z[192]
    z[660] = msh * z[193]
    z[661] = msh * z[196]
    z[645] = mrf * z[194]
    z[646] = mrf * z[195]
    z[662] = msh * z[194]
    z[663] = msh * z[195]
    z[656] = mrf * z[214]
    z[673] = msh * z[210]
    z[649] = mrf * z[199]
    z[650] = mrf * z[200]
    z[651] = mrf * z[201]
    z[652] = mrf * z[212]
    z[653] = mrf * z[213]
    z[666] = msh * z[199]
    z[667] = msh * z[200]
    z[668] = msh * z[201]
    z[669] = msh * z[208]
    z[670] = msh * z[209]
    z[654] = mrf * z[203]
    z[655] = mrf * z[204]
    z[671] = msh * z[203]
    z[672] = msh * z[204]
    z[607] = mhat * hato
    z[40] = z[35] * z[29] + z[37] * z[27]
    z[702] = mrf * z[126]
    z[62] = z[19] * z[58] - z[20] * z[56]
    z[639] = mrf * z[221]
    z[701] = mrf * z[125]
    z[611] = mhat * z[279]
    z[615] = mhat * z[166]
    z[722] = mth * z[165]
    z[717] = mth * z[158]
    z[718] = mth * z[159]
    z[719] = mth * z[164]
    z[720] = mth * z[160]
    z[721] = mth * z[161]
    z[613] = mhat * z[280]
    z[711] = msh * z[149]
    z[707] = msh * z[142]
    z[708] = msh * z[148]
    z[709] = msh * z[143]
    z[710] = msh * z[144]
    z[609] = mhat * z[278]
    z[693] = mff * z[118]
    z[699] = mrf * z[119]
    z[690] = mff * z[33]
    z[691] = mff * z[34]
    z[696] = mrf * z[33]
    z[697] = mrf * z[34]
    z[779] = ((z[743] + z[744] + z[745] + z[746] + z[692] * z[292] + mff * (z[246] * z[355] + z[258] * z[356]) + msh * (z[138] * z[311] + z[148] * z[312]) + msh * (z[191] * z[336] + z[201] * z[337]) + mth * (z[153] * z[319] + z[164] * z[320]) + mth * (z[172] * z[327] + z[180] * z[328]) + 0.25 * mrf * (((((lrffo * z[298] + lrfo * z[297] + z[768] * z[297] + z[769] * z[298] + 4 * lff * z[295] + 2 * lff * z[15] * z[297] + 2 * lff * z[399] * z[298] + 2 * lrffo * z[399] * z[295] + 2 * lrfo * z[15] * z[295] + z[770] * z[300] + 2 * lff * z[16] * z[300]) - z[771] * z[301]) - 2 * lff * z[401] * z[301]) - 2 * lrffo * z[400] * z[296]) - 2 * lrfo * z[16] * z[296])) - 0.5 * mrf * ((((((z[191] * z[398] * z[342] + z[201] * z[396] * z[342] + 2 * z[14] * z[191] * z[341] + 2 * z[13] * z[191] * z[344] + 2 * z[14] * z[201] * z[344]) - 2 * z[13] * z[201] * z[341]) - 2 * z[191] * z[339]) - 2 * z[201] * z[340]) - z[191] * z[396] * z[345]) - z[201] * z[397] * z[345])) - mhat * (((((((((((((((((((((((((((lff * z[16] * z[374] + lff * z[108] * z[371] + lff * z[110] * z[372] + lrf * z[12] * z[375] + lrf * z[96] * z[371] + lrf * z[98] * z[372] + lsh * z[8] * z[376] + lsh * z[24] * z[372] + lsh * z[26] * z[371] + lth * z[3] * z[372]) - lff * z[366]) - lrf * z[369]) - lsh * z[370]) - lth * z[321]) - lff * z[15] * z[369]) - lff * z[21] * z[370]) - lff * z[392] * z[321]) - lrf * z[11] * z[370]) - lrf * z[15] * z[366]) - lrf * z[393] * z[321]) - lsh * z[7] * z[321]) - lsh * z[11] * z[369]) - lsh * z[21] * z[366]) - lth * z[7] * z[370]) - lth * z[392] * z[366]) - lth * z[393] * z[369]) - lff * z[23] * z[375]) - lff * z[391] * z[376]) - lrf * z[16] * z[373]) - lrf * z[395] * z[376]) - lsh * z[12] * z[374]) - lsh * z[22] * z[373]) - lth * z[4] * z[371]) - lth * z[8] * z[375]) - lth * z[390] * z[373]) - lth * z[394] * z[374])
    z[818] = ((((((((((((((z[725] * z[34] + lff * (rrx2 * z[33] + rry2 * z[34]) + 0.5 * z[379] * (lrffo * z[41] + lrfo * z[45] + 2 * lff * z[34]) + z[377] * (lff * z[34] + lrf * z[45] + lsh * z[30] + lth * z[46]) + z[779]) - z[223] * lrx2 * z[56]) - z[223] * lry2 * z[57]) - z[234] * lrx2 * z[58]) - z[234] * lry2 * z[59]) - z[246] * lrx1 * z[64]) - z[246] * lry1 * z[65]) - z[258] * lrx1 * z[66]) - z[258] * lry1 * z[67]) - z[378] * (z[246] * z[65] + z[258] * z[67])) - z[379] * (z[191] * z[53] + z[201] * z[55])) - z[380] * (z[138] * z[28] + z[148] * z[30])) - z[380] * (z[191] * z[53] + z[201] * z[55])) - z[381] * (z[153] * z[47] + z[164] * z[46])) - z[381] * (z[172] * z[50] + z[180] * z[49])
    z[776] = z[775] + mff * (z[245] * z[246] + z[258] * z[267]) + msh * (z[138]^2 + z[148]^2) + msh * (z[190] * z[191] + z[201] * z[208]) + mth * (z[153]^2 + z[164]^2) + mth * (z[172]^2 + z[180] * z[185]) + 0.25 * mrf * (z[755] + 4 * z[756] * z[399] + 4 * z[757] * z[15]) + 0.5 * mrf * ((((2 * z[190] * z[191] + 2 * z[201] * z[212] + 2 * z[69] * z[13] * z[201]) - 2 * z[69] * z[14] * z[191]) - lrffo * z[191] * z[398]) - lrffo * z[201] * z[396]) + mhat * (((((z[760] + 2 * z[761] * z[15] + 2 * z[762] * z[21] + 2 * z[763] * z[392] + 2 * z[764] * z[11] + 2 * z[765] * z[393] + 2 * z[766] * z[7]) - lsh * hato * z[24]) - lth * hato * z[3]) - lff * hato * z[110]) - lrf * hato * z[98])
    z[777] = (((mff * (z[246] * z[251] + z[258] * z[262]) + mrf * (z[191] * z[194] + z[201] * z[203]) + msh * (z[138] * z[139] + z[148] * z[143]) + msh * (z[191] * z[194] + z[201] * z[203]) + mth * (z[153] * z[155] + z[164] * z[160]) + mth * (z[172] * z[175] + z[180] * z[181])) - z[692] * z[33]) - mhat * (lff * z[33] + lrf * z[44] + lsh * z[29] + lth * z[48])) - 0.5 * mrf * (2 * lff * z[33] + lrffo * z[399] * z[33] + lrffo * z[400] * z[31] + lrfo * z[15] * z[33] + lrfo * z[16] * z[31])
    z[778] = (((mff * (z[246] * z[252] + z[258] * z[263]) + mrf * (z[191] * z[195] + z[201] * z[204]) + msh * (z[138] * z[140] + z[148] * z[144]) + msh * (z[191] * z[195] + z[201] * z[204]) + mth * (z[153] * z[156] + z[164] * z[161]) + mth * (z[172] * z[176] + z[180] * z[182])) - z[692] * z[34]) - mhat * (lff * z[34] + lrf * z[45] + lsh * z[30] + lth * z[46])) - 0.5 * mrf * (2 * lff * z[34] + lrffo * z[399] * z[34] + lrffo * z[400] * z[32] + lrfo * z[15] * z[34] + lrfo * z[16] * z[32])
    z[784] = (z[736] + z[738] + z[740] + z[742] + z[680] * z[328] + mff * (z[249] * z[355] + z[268] * z[356]) + msh * (z[196] * z[336] + z[209] * z[337])) - 0.25 * mrf * ((((((((((2 * z[768] * z[341] + 2 * z[772] * z[342] + 2 * z[196] * z[398] * z[342] + 2 * z[213] * z[396] * z[342] + 4 * z[14] * z[196] * z[341] + 2 * z[770] * z[344] + 2 * lrffo * z[396] * z[340] + 2 * lrffo * z[398] * z[339] + 4 * z[69] * z[14] * z[339] + 4 * z[13] * z[196] * z[344] + 4 * z[14] * z[213] * z[344]) - 4 * z[69] * z[341]) - lrffo * z[342]) - 4 * z[13] * z[213] * z[341]) - 4 * z[196] * z[339]) - 4 * z[213] * z[340]) - 2 * z[773] * z[345]) - 4 * z[69] * z[13] * z[340]) - 2 * z[196] * z[396] * z[345]) - 2 * z[213] * z[397] * z[345])
    z[819] = (((((((((((0.5 * z[379] * (((lrffo * z[63] - 2 * z[69] * z[59]) - 2 * z[196] * z[53]) - 2 * z[213] * z[55]) + z[784]) - z[728] * z[49]) - z[226] * lrx2 * z[56]) - z[226] * lry2 * z[57]) - z[242] * lrx2 * z[58]) - z[242] * lry2 * z[59]) - z[249] * lrx1 * z[64]) - z[249] * lry1 * z[65]) - z[274] * lrx1 * z[66]) - z[274] * lry1 * z[67]) - z[378] * (z[249] * z[65] + z[268] * z[67])) - z[380] * (z[196] * z[53] + z[209] * z[55])
    z[781] = z[780] + z[680] * z[185] + mff * (z[245] * z[249] + z[267] * z[268]) + msh * (z[190] * z[196] + z[208] * z[209]) + 0.25 * mrf * ((((((((z[758] + 4 * z[190] * z[196] + 4 * z[212] * z[213] + 4 * z[69] * z[13] * z[212] + 4 * z[69] * z[13] * z[213]) - 4 * z[759]) - 4 * z[69] * z[14] * z[190]) - 4 * z[69] * z[14] * z[196]) - 2 * lrffo * z[190] * z[398]) - 2 * lrffo * z[196] * z[398]) - 2 * lrffo * z[212] * z[396]) - 2 * lrffo * z[213] * z[396])
    z[782] = z[680] * z[181] + mff * (z[249] * z[251] + z[268] * z[262]) + msh * (z[196] * z[194] + z[209] * z[203]) + 0.5 * mrf * ((((2 * z[196] * z[194] + 2 * z[213] * z[203] + 2 * z[69] * z[13] * z[203]) - 2 * z[69] * z[14] * z[194]) - lrffo * z[396] * z[203]) - lrffo * z[398] * z[194])
    z[783] = z[680] * z[182] + mff * (z[249] * z[252] + z[268] * z[263]) + msh * (z[196] * z[195] + z[209] * z[204]) + 0.5 * mrf * ((((2 * z[196] * z[195] + 2 * z[213] * z[204] + 2 * z[69] * z[13] * z[204]) - 2 * z[69] * z[14] * z[195]) - lrffo * z[396] * z[204]) - lrffo * z[398] * z[195])
    z[790] = (z[743] + z[744] + z[745] + z[692] * z[292] + mff * (z[247] * z[355] + z[257] * z[356]) + msh * (z[138] * z[311] + z[148] * z[312]) + msh * (z[192] * z[336] + z[200] * z[337]) + mth * (z[153] * z[319] + z[159] * z[320]) + mth * (z[173] * z[327] + z[179] * z[328]) + 0.25 * mrf * (((((lrffo * z[298] + lrfo * z[297] + z[768] * z[297] + z[769] * z[298] + 4 * lff * z[295] + 2 * lff * z[15] * z[297] + 2 * lff * z[399] * z[298] + 2 * lrffo * z[399] * z[295] + 2 * lrfo * z[15] * z[295] + z[770] * z[300] + 2 * lff * z[16] * z[300]) - z[771] * z[301]) - 2 * lff * z[401] * z[301]) - 2 * lrffo * z[400] * z[296]) - 2 * lrfo * z[16] * z[296]) + mhat * ((((((((((lff * z[366] + lrf * z[369] + lsh * z[370] + lff * z[15] * z[369] + lff * z[21] * z[370] + lff * z[392] * z[321] + lrf * z[11] * z[370] + lrf * z[15] * z[366] + lrf * z[393] * z[321] + lsh * z[7] * z[321] + lsh * z[11] * z[369] + lsh * z[21] * z[366] + lff * z[23] * z[375] + lff * z[391] * z[376] + lrf * z[16] * z[373] + lrf * z[395] * z[376] + lsh * z[12] * z[374] + lsh * z[22] * z[373]) - lff * z[16] * z[374]) - lff * z[108] * z[371]) - lff * z[110] * z[372]) - lrf * z[12] * z[375]) - lrf * z[96] * z[371]) - lrf * z[98] * z[372]) - lsh * z[8] * z[376]) - lsh * z[24] * z[372]) - lsh * z[26] * z[371])) - 0.5 * mrf * ((((((z[192] * z[398] * z[342] + z[200] * z[396] * z[342] + 2 * z[14] * z[192] * z[341] + 2 * z[13] * z[192] * z[344] + 2 * z[14] * z[200] * z[344]) - 2 * z[13] * z[200] * z[341]) - 2 * z[192] * z[339]) - 2 * z[200] * z[340]) - z[192] * z[396] * z[345]) - z[200] * z[397] * z[345])
    z[820] = ((((((((((((((z[725] * z[34] + lff * (rrx2 * z[33] + rry2 * z[34]) + z[377] * (lff * z[34] + lrf * z[45] + lsh * z[30]) + 0.5 * z[379] * (lrffo * z[41] + lrfo * z[45] + 2 * lff * z[34]) + z[790]) - z[224] * lrx2 * z[56]) - z[224] * lry2 * z[57]) - z[233] * lrx2 * z[58]) - z[233] * lry2 * z[59]) - z[247] * lrx1 * z[64]) - z[247] * lry1 * z[65]) - z[257] * lrx1 * z[66]) - z[257] * lry1 * z[67]) - z[378] * (z[247] * z[65] + z[257] * z[67])) - z[379] * (z[192] * z[53] + z[200] * z[55])) - z[380] * (z[138] * z[28] + z[148] * z[30])) - z[380] * (z[192] * z[53] + z[200] * z[55])) - z[381] * (z[153] * z[47] + z[159] * z[46])) - z[381] * (z[173] * z[50] + z[179] * z[49])
    z[787] = z[785] + mff * (z[245] * z[247] + z[257] * z[267]) + msh * (z[138]^2 + z[148]^2) + msh * (z[190] * z[192] + z[200] * z[208]) + mth * (z[153]^2 + z[159] * z[164]) + mth * (z[172] * z[173] + z[179] * z[185]) + 0.25 * mrf * (z[755] + 4 * z[756] * z[399] + 4 * z[757] * z[15]) + 0.5 * mrf * ((((2 * z[190] * z[192] + 2 * z[200] * z[212] + 2 * z[69] * z[13] * z[200]) - 2 * z[69] * z[14] * z[192]) - lrffo * z[192] * z[398]) - lrffo * z[200] * z[396]) + mhat * ((((z[786] + z[763] * z[392] + z[765] * z[393] + z[766] * z[7] + 2 * z[761] * z[15] + 2 * z[762] * z[21] + 2 * z[764] * z[11]) - lsh * hato * z[24]) - lff * hato * z[110]) - lrf * hato * z[98])
    z[788] = (((mff * (z[247] * z[251] + z[257] * z[262]) + mrf * (z[192] * z[194] + z[200] * z[203]) + msh * (z[138] * z[139] + z[148] * z[143]) + msh * (z[192] * z[194] + z[200] * z[203]) + mth * (z[153] * z[155] + z[159] * z[160]) + mth * (z[173] * z[175] + z[179] * z[181])) - z[692] * z[33]) - mhat * (lff * z[33] + lrf * z[44] + lsh * z[29])) - 0.5 * mrf * (2 * lff * z[33] + lrffo * z[399] * z[33] + lrffo * z[400] * z[31] + lrfo * z[15] * z[33] + lrfo * z[16] * z[31])
    z[789] = (((mff * (z[247] * z[252] + z[257] * z[263]) + mrf * (z[192] * z[195] + z[200] * z[204]) + msh * (z[138] * z[140] + z[148] * z[144]) + msh * (z[192] * z[195] + z[200] * z[204]) + mth * (z[153] * z[156] + z[159] * z[161]) + mth * (z[173] * z[176] + z[179] * z[182])) - z[692] * z[34]) - mhat * (lff * z[34] + lrf * z[45] + lsh * z[30])) - 0.5 * mrf * (2 * lff * z[34] + lrffo * z[399] * z[34] + lrffo * z[400] * z[32] + lrfo * z[15] * z[34] + lrfo * z[16] * z[32])
    z[797] = z[736] + z[738] + z[740] + z[665] * z[337] + mff * (z[250] * z[355] + z[269] * z[356]) + 0.25 * mrf * (((((((((lrffo * z[342] + 4 * z[69] * z[341] + 4 * lsh * z[13] * z[341] + 2 * z[773] * z[345] + 4 * lsh * z[340] + 2 * lsh * z[397] * z[345] + 4 * z[69] * z[13] * z[340]) - 2 * z[768] * z[341]) - 2 * z[772] * z[342]) - 2 * lsh * z[396] * z[342]) - 2 * z[770] * z[344]) - 4 * lsh * z[14] * z[344]) - 4 * z[69] * z[14] * z[339]) - 2 * lrffo * z[396] * z[340]) - 2 * lrffo * z[398] * z[339])
    z[821] = ((((((((((0.5 * z[379] * ((lrffo * z[63] - 2 * lsh * z[55]) - 2 * z[69] * z[59]) + z[797]) - z[731] * z[55]) - z[229] * lrx2 * z[56]) - z[229] * lry2 * z[57]) - z[243] * lrx2 * z[58]) - z[243] * lry2 * z[59]) - z[250] * lrx1 * z[64]) - z[250] * lry1 * z[65]) - z[275] * lrx1 * z[66]) - z[275] * lry1 * z[67]) - z[378] * (z[250] * z[65] + z[269] * z[67])
    z[794] = z[791] + z[665] * z[208] + mff * (z[245] * z[250] + z[267] * z[269]) + 0.25 * mrf * ((((((z[758] + 4 * lsh * z[212] + 4 * z[792] * z[13] + 4 * z[69] * z[13] * z[212]) - 4 * z[759]) - 2 * z[793] * z[396]) - 4 * z[69] * z[14] * z[190]) - 2 * lrffo * z[190] * z[398]) - 2 * lrffo * z[212] * z[396])
    z[795] = z[665] * z[203] + mff * (z[250] * z[251] + z[269] * z[262]) + 0.5 * mrf * ((((2 * lsh * z[203] + 2 * z[69] * z[13] * z[203]) - 2 * z[69] * z[14] * z[194]) - lrffo * z[396] * z[203]) - lrffo * z[398] * z[194])
    z[796] = z[665] * z[204] + mff * (z[250] * z[252] + z[269] * z[263]) + 0.5 * mrf * ((((2 * lsh * z[204] + 2 * z[69] * z[13] * z[204]) - 2 * z[69] * z[14] * z[195]) - lrffo * z[396] * z[204]) - lrffo * z[398] * z[195])
    z[803] = (z[743] + z[744] + z[692] * z[292] + mff * (z[248] * z[355] + z[256] * z[356]) + msh * (z[138] * z[311] + z[142] * z[312]) + msh * (z[193] * z[336] + z[199] * z[337]) + mth * (z[154] * z[319] + z[158] * z[320]) + mth * (z[174] * z[327] + z[178] * z[328]) + 0.25 * mrf * (((((lrffo * z[298] + lrfo * z[297] + z[768] * z[297] + z[769] * z[298] + 4 * lff * z[295] + 2 * lff * z[15] * z[297] + 2 * lff * z[399] * z[298] + 2 * lrffo * z[399] * z[295] + 2 * lrfo * z[15] * z[295] + z[770] * z[300] + 2 * lff * z[16] * z[300]) - z[771] * z[301]) - 2 * lff * z[401] * z[301]) - 2 * lrffo * z[400] * z[296]) - 2 * lrfo * z[16] * z[296]) + mhat * (((((((lff * z[366] + lrf * z[369] + lff * z[15] * z[369] + lff * z[21] * z[370] + lff * z[392] * z[321] + lrf * z[11] * z[370] + lrf * z[15] * z[366] + lrf * z[393] * z[321] + lff * z[23] * z[375] + lff * z[391] * z[376] + lrf * z[16] * z[373] + lrf * z[395] * z[376]) - lff * z[16] * z[374]) - lff * z[108] * z[371]) - lff * z[110] * z[372]) - lrf * z[12] * z[375]) - lrf * z[96] * z[371]) - lrf * z[98] * z[372])) - 0.5 * mrf * ((((((z[193] * z[398] * z[342] + z[199] * z[396] * z[342] + 2 * z[14] * z[193] * z[341] + 2 * z[13] * z[193] * z[344] + 2 * z[14] * z[199] * z[344]) - 2 * z[13] * z[199] * z[341]) - 2 * z[193] * z[339]) - 2 * z[199] * z[340]) - z[193] * z[396] * z[345]) - z[199] * z[397] * z[345])
    z[822] = ((((((((((((((z[725] * z[34] + lff * (rrx2 * z[33] + rry2 * z[34]) + z[377] * (lff * z[34] + lrf * z[45]) + 0.5 * z[379] * (lrffo * z[41] + lrfo * z[45] + 2 * lff * z[34]) + z[803]) - z[225] * lrx2 * z[56]) - z[225] * lry2 * z[57]) - z[232] * lrx2 * z[58]) - z[232] * lry2 * z[59]) - z[248] * lrx1 * z[64]) - z[248] * lry1 * z[65]) - z[256] * lrx1 * z[66]) - z[256] * lry1 * z[67]) - z[378] * (z[248] * z[65] + z[256] * z[67])) - z[379] * (z[193] * z[53] + z[199] * z[55])) - z[380] * (z[138] * z[28] + z[142] * z[30])) - z[380] * (z[193] * z[53] + z[199] * z[55])) - z[381] * (z[154] * z[47] + z[158] * z[46])) - z[381] * (z[174] * z[50] + z[178] * z[49])
    z[800] = z[798] + mff * (z[245] * z[248] + z[256] * z[267]) + msh * (z[138]^2 + z[142] * z[148]) + msh * (z[190] * z[193] + z[199] * z[208]) + mth * (z[153] * z[154] + z[158] * z[164]) + mth * (z[172] * z[174] + z[178] * z[185]) + 0.25 * mrf * (z[755] + 4 * z[756] * z[399] + 4 * z[757] * z[15]) + 0.5 * mrf * ((((2 * z[190] * z[193] + 2 * z[199] * z[212] + 2 * z[69] * z[13] * z[199]) - 2 * z[69] * z[14] * z[193]) - lrffo * z[193] * z[398]) - lrffo * z[199] * z[396]) + mhat * (((z[799] + z[762] * z[21] + z[763] * z[392] + z[764] * z[11] + z[765] * z[393] + 2 * z[761] * z[15]) - lff * hato * z[110]) - lrf * hato * z[98])
    z[801] = (((mff * (z[248] * z[251] + z[256] * z[262]) + mrf * (z[193] * z[194] + z[199] * z[203]) + msh * (z[138] * z[139] + z[142] * z[143]) + msh * (z[193] * z[194] + z[199] * z[203]) + mth * (z[154] * z[155] + z[158] * z[160]) + mth * (z[174] * z[175] + z[178] * z[181])) - z[692] * z[33]) - mhat * (lff * z[33] + lrf * z[44])) - 0.5 * mrf * (2 * lff * z[33] + lrffo * z[399] * z[33] + lrffo * z[400] * z[31] + lrfo * z[15] * z[33] + lrfo * z[16] * z[31])
    z[802] = (((mff * (z[248] * z[252] + z[256] * z[263]) + mrf * (z[193] * z[195] + z[199] * z[204]) + msh * (z[138] * z[140] + z[142] * z[144]) + msh * (z[193] * z[195] + z[199] * z[204]) + mth * (z[154] * z[156] + z[158] * z[161]) + mth * (z[174] * z[176] + z[178] * z[182])) - z[692] * z[34]) - mhat * (lff * z[34] + lrf * z[45])) - 0.5 * mrf * (2 * lff * z[34] + lrffo * z[399] * z[34] + lrffo * z[400] * z[32] + lrfo * z[15] * z[34] + lrfo * z[16] * z[32])
    z[808] = z[736] + z[738] + mff * (z[253] * z[355] + z[270] * z[356]) + 0.25 * mrf * (((((((lrffo * z[342] + 4 * z[69] * z[341] + 2 * z[773] * z[345] + 4 * z[69] * z[13] * z[340]) - 2 * z[768] * z[341]) - 2 * z[772] * z[342]) - 2 * z[770] * z[344]) - 4 * z[69] * z[14] * z[339]) - 2 * lrffo * z[396] * z[340]) - 2 * lrffo * z[398] * z[339])
    z[823] = ((((((0.5 * z[379] * (lrffo * z[63] - 2 * z[69] * z[59]) + z[808]) - z[253] * lrx1 * z[64]) - z[253] * lry1 * z[65]) - z[276] * lrx1 * z[66]) - z[276] * lry1 * z[67]) - lrf * (lrx2 * z[58] + lry2 * z[59])) - z[378] * (z[253] * z[65] + z[270] * z[67])
    z[805] = z[804] + mff * (z[245] * z[253] + z[267] * z[270]) + 0.25 * mrf * (((((z[758] + 4 * z[69] * z[13] * z[212]) - 4 * z[759]) - 4 * z[69] * z[14] * z[190]) - 2 * lrffo * z[190] * z[398]) - 2 * lrffo * z[212] * z[396])
    z[806] = mff * (z[253] * z[251] + z[270] * z[262]) + 0.5 * mrf * (((2 * z[69] * z[13] * z[203] - 2 * z[69] * z[14] * z[194]) - lrffo * z[396] * z[203]) - lrffo * z[398] * z[194])
    z[807] = mff * (z[253] * z[252] + z[270] * z[263]) + 0.5 * mrf * (((2 * z[69] * z[13] * z[204] - 2 * z[69] * z[14] * z[195]) - lrffo * z[396] * z[204]) - lrffo * z[398] * z[195])
    z[281] = (mhat * hatop) / z[72]
    z[282] = z[74] * (lap + lhp + lkp + lmtpp)
    z[283] = z[75] * (lap + lhp + lkp)
    z[284] = z[76] * (lap + lhp + lkp)
    z[285] = z[77] * (lhp + lkp)
    z[286] = z[78] * lhp
    z[287] = z[79] * (rap + rhp + rkp + rmtpp)
    z[288] = z[80] * (rap + rhp + rkp)
    z[289] = z[76] * (rap + rhp + rkp)
    z[290] = z[81] * (rhp + rkp)
    z[291] = z[82] * rhp

end


function pop2x(sol, t)
    @unpack lff = sol.prob.parameters
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3],sol.prob.p,t)
    io(sol, t)

    return q1 - lff*z[31]
end

pop2x(sol) = [pop2x(sol, t) for t in sol.t]

function pop2y(sol, t)
    @unpack lff = sol.prob.parameters
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3],sol.prob.p,t)
    io(sol, t)

    return q2 - lff*z[32]
end

pop2y(sol) = [pop2y(sol, t) for t in sol.t]


function pop10x(sol, t)
    @unpack lff = sol.prob.parameters
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3],sol.prob.p,t)
    io(sol, t)

    return q1 - lff*z[31]
end

pop10x(sol) = [pop10x(sol, t) for t in sol.t]

function pop10y(sol, t)
    @unpack lff = sol.prob.parameters
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3],sol.prob.p,t)
    io(sol, t)

    return q2 - lff*z[32]
end

pop10y(sol) = [pop10y(sol, t) for t in sol.t]

function pop11x(sol, t)
    @unpack lff = sol.prob.parameters
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3],sol.prob.p,t)
    io(sol, t)

    return q1 - lff*z[31]
end

pop11x(sol) = [pop11x(sol, t) for t in sol.t]

function pop11y(sol, t)
    @unpack lff = sol.prob.parameters
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3],sol.prob.p,t)
    io(sol, t)

    return q2 - lff*z[32]
end

pop11y(sol) = [pop11y(sol, t) for t in sol.t]