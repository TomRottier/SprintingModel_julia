# Automatically generated
function kecm(sol, t)
    @unpack z, ihat, ith, u5, u4, ish, u7, u6, irf, u9, u8, iff, mff, lffo, msh, mth, mhat, lth, lff, lsh, lrf, mrf, lrfo, lrffo = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)
    lhp, rhp, lkp, rkp, lap, rap, lmtpp, rmtpp, hatop, hato = _lhp(t), _rhp(t), _lkp(t), _rkp(t), _lap(t), _rap(t), _lmtpp(t), _rmtpp(t), _hatop(t), _hato(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((0.5 * ihat * u3^2 + 0.5 * ith * ((lhp - u3) - u5)^2 + 0.5 * ith * ((rhp - u3) - u4)^2 + 0.5 * ish * ((((lhp - lkp) - u3) - u5) - u7)^2 + 0.5 * ish * ((((rhp - rkp) - u3) - u4) - u6)^2 + 0.5 * irf * ((((((lap + lhp) - lkp) - u3) - u5) - u7) - u9)^2 + 0.5 * irf * ((((((rap + rhp) - rkp) - u3) - u4) - u6) - u8)^2 + 0.5 * iff * ((((((lap + lhp + lmtpp) - lkp) - u3) - u5) - u7) - u9)^2 + 0.5 * iff * ((((((rap + rhp + rmtpp) - rkp) - u3) - u4) - u6) - u8)^2 + 0.5 * mff * ((z[31] * u1 + z[32] * u2)^2 + (((z[118] + lffo * u3 + lffo * u5 + lffo * u7 + lffo * u9) - z[33] * u1) - z[34] * u2)^2) + 0.5 * msh * ((z[141] + z[138] * u3 + z[138] * u5 + z[138] * u7 + z[138] * u9 + z[139] * u1 + z[140] * u2)^2 + (z[149] + z[142] * u9 + z[148] * u3 + z[148] * u5 + z[148] * u7 + z[143] * u1 + z[144] * u2)^2) + 0.5 * mth * ((z[157] + z[153] * u9 + z[154] * u3 + z[154] * u5 + z[154] * u7 + z[155] * u1 + z[156] * u2)^2 + (z[165] + z[158] * u9 + z[159] * u7 + z[164] * u3 + z[164] * u5 + z[160] * u1 + z[161] * u2)^2) + 0.5 * mth * ((z[177] + z[172] * u9 + z[173] * u3 + z[173] * u5 + z[174] * u7 + z[175] * u1 + z[176] * u2)^2 + (z[186] + z[71] * u4 + z[178] * u9 + z[179] * u7 + z[180] * u5 + z[185] * u3 + z[181] * u1 + z[182] * u2)^2) + 0.5 * mff * ((z[254] + z[245] * u8 + z[246] * u9 + z[247] * u5 + z[248] * u7 + z[249] * u3 + z[250] * u4 + z[251] * u6 + z[252] * u1 + z[253] * u2)^2 + (z[271] + z[256] * u9 + z[257] * u5 + z[258] * u7 + z[267] * u3 + z[268] * u4 + z[269] * u6 + z[270] * u8 + z[261] * u1 + z[262] * u2)^2) + 0.5 * msh * ((z[210] + z[70] * u6 + z[198] * u9 + z[200] * u5 + z[201] * u7 + z[208] * u3 + z[209] * u4 + z[202] * u1 + z[203] * u2)^2 + (((((((z[196] * u4 - z[197]) - z[190] * u9) - z[191] * u3) - z[192] * u5) - z[193] * u7) - z[194] * u1) - z[195] * u2)^2) + 0.5 * mhat * ((((((((((hatop^2 + u1^2 + u2^2 + 2 * hatop * z[1] * u1 + 2 * hatop * z[2] * u2 + hato^2 * u3^2 + 2 * hato * z[1] * u2 * u3 + ((z[166] - lth * u3) - lth * u5)^2 + (z[278] + lff * u3 + lff * u5 + lff * u7 + lff * u9)^2 + 2 * z[6] * hatop * ((z[166] - lth * u3) - lth * u5) + 2 * z[46] * u2 * ((z[166] - lth * u3) - lth * u5) + 2 * z[48] * u1 * ((z[166] - lth * u3) - lth * u5) + (((z[280] - lsh * u3) - lsh * u5) - lsh * u7)^2 + 2 * hato * z[5] * u3 * ((z[166] - lth * u3) - lth * u5) + 2 * z[26] * hatop * (((z[280] - lsh * u3) - lsh * u5) - lsh * u7) + 2 * z[29] * u1 * (((z[280] - lsh * u3) - lsh * u5) - lsh * u7) + 2 * z[30] * u2 * (((z[280] - lsh * u3) - lsh * u5) - lsh * u7) + ((((z[279] - lrf * u3) - lrf * u5) - lrf * u7) - lrf * u9)^2 + 2 * hato * z[24] * u3 * (((z[280] - lsh * u3) - lsh * u5) - lsh * u7) + 2 * hatop * z[102] * ((((z[279] - lrf * u3) - lrf * u5) - lrf * u7) - lrf * u9) + 2 * z[44] * u1 * ((((z[279] - lrf * u3) - lrf * u5) - lrf * u7) - lrf * u9) + 2 * z[45] * u2 * ((((z[279] - lrf * u3) - lrf * u5) - lrf * u7) - lrf * u9) + 2 * hato * z[104] * u3 * ((((z[279] - lrf * u3) - lrf * u5) - lrf * u7) - lrf * u9) + 2 * z[393] * ((z[166] - lth * u3) - lth * u5) * ((((z[279] - lrf * u3) - lrf * u5) - lrf * u7) - lrf * u9) + 2 * z[17] * (z[278] + lff * u3 + lff * u5 + lff * u7 + lff * u9) * ((((z[279] - lrf * u3) - lrf * u5) - lrf * u7) - lrf * u9)) - 2 * hato * z[2] * u1 * u3) - 2 * hatop * z[114] * (z[278] + lff * u3 + lff * u5 + lff * u7 + lff * u9)) - 2 * z[33] * u1 * (z[278] + lff * u3 + lff * u5 + lff * u7 + lff * u9)) - 2 * z[34] * u2 * (z[278] + lff * u3 + lff * u5 + lff * u7 + lff * u9)) - 2 * hato * z[116] * u3 * (z[278] + lff * u3 + lff * u5 + lff * u7 + lff * u9)) - 2 * z[392] * ((z[166] - lth * u3) - lth * u5) * (z[278] + lff * u3 + lff * u5 + lff * u7 + lff * u9)) - 2 * z[9] * ((z[166] - lth * u3) - lth * u5) * (((z[280] - lsh * u3) - lsh * u5) - lsh * u7)) - 2 * z[21] * (z[278] + lff * u3 + lff * u5 + lff * u7 + lff * u9) * (((z[280] - lsh * u3) - lsh * u5) - lsh * u7)) - 2 * z[13] * (((z[280] - lsh * u3) - lsh * u5) - lsh * u7) * ((((z[279] - lrf * u3) - lrf * u5) - lrf * u7) - lrf * u9))) - 0.125 * mrf * (((((((4 * z[18] * (z[31] * u1 + z[32] * u2) * (z[125] + lrfo * u3 + lrfo * u5 + lrfo * u7 + lrfo * u9) + 4 * z[397] * (z[31] * u1 + z[32] * u2) * (z[126] + lrffo * u3 + lrffo * u5 + lrffo * u7 + lrffo * u9) + 4 * z[17] * (z[125] + lrfo * u3 + lrfo * u5 + lrfo * u7 + lrfo * u9) * (((z[119] + lff * u3 + lff * u5 + lff * u7 + lff * u9) - z[33] * u1) - z[34] * u2)) - 4 * (z[31] * u1 + z[32] * u2)^2) - (z[125] + lrfo * u3 + lrfo * u5 + lrfo * u7 + lrfo * u9)^2) - (z[126] + lrffo * u3 + lrffo * u5 + lrffo * u7 + lrffo * u9)^2) - 4 * (((z[119] + lff * u3 + lff * u5 + lff * u7 + lff * u9) - z[33] * u1) - z[34] * u2)^2) - 2 * z[19] * (z[125] + lrfo * u3 + lrfo * u5 + lrfo * u7 + lrfo * u9) * (z[126] + lrffo * u3 + lrffo * u5 + lrffo * u7 + lrffo * u9)) - 4 * z[396] * (z[126] + lrffo * u3 + lrffo * u5 + lrffo * u7 + lrffo * u9) * (((z[119] + lff * u3 + lff * u5 + lff * u7 + lff * u9) - z[33] * u1) - z[34] * u2))) - 0.125 * mrf * (((((((4 * z[19] * (z[220] + z[69] * u3 + z[69] * u4 + z[69] * u6 + z[69] * u8) * (z[221] + lrffo * u3 + lrffo * u4 + lrffo * u6 + lrffo * u8) + 4 * z[399] * (z[221] + lrffo * u3 + lrffo * u4 + lrffo * u6 + lrffo * u8) * (z[214] + lsh * u6 + z[198] * u9 + z[200] * u5 + z[201] * u7 + z[212] * u3 + z[213] * u4 + z[202] * u1 + z[203] * u2) + 8 * z[11] * (z[220] + z[69] * u3 + z[69] * u4 + z[69] * u6 + z[69] * u8) * (z[214] + lsh * u6 + z[198] * u9 + z[200] * u5 + z[201] * u7 + z[212] * u3 + z[213] * u4 + z[202] * u1 + z[203] * u2)) - 4 * (z[220] + z[69] * u3 + z[69] * u4 + z[69] * u6 + z[69] * u8)^2) - (z[221] + lrffo * u3 + lrffo * u4 + lrffo * u6 + lrffo * u8)^2) - 4 * (z[214] + lsh * u6 + z[198] * u9 + z[200] * u5 + z[201] * u7 + z[212] * u3 + z[213] * u4 + z[202] * u1 + z[203] * u2)^2) - 4 * (((((((z[196] * u4 - z[197]) - z[190] * u9) - z[191] * u3) - z[192] * u5) - z[193] * u7) - z[194] * u1) - z[195] * u2)^2) - 8 * z[12] * (z[220] + z[69] * u3 + z[69] * u4 + z[69] * u6 + z[69] * u8) * (((((((z[196] * u4 - z[197]) - z[190] * u9) - z[191] * u3) - z[192] * u5) - z[193] * u7) - z[194] * u1) - z[195] * u2)) - 4 * z[401] * (z[221] + lrffo * u3 + lrffo * u4 + lrffo * u6 + lrffo * u8) * (((((((z[196] * u4 - z[197]) - z[190] * u9) - z[191] * u3) - z[192] * u5) - z[193] * u7) - z[194] * u1) - z[195] * u2))
end

kecm(sol) = [kecm(sol, t) for t in sol.t]


function pocmy(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((((q2 + z[79] * z[65] + z[80] * z[57] + z[81] * z[53] + z[82] * z[50] + z[73] * z[2]) - z[74] * z[32]) - z[77] * z[28]) - z[78] * z[47]) - 0.5 * z[75] * z[43]) - 0.5 * z[76] * z[39]) - 0.5 * z[76] * z[61]
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

    return ((((((((((((((z[402] + z[403] + z[404] + z[406] + z[407] + z[408] + 0.5 * z[574] + iff * u4 + iff * u5 + iff * u6 + iff * u7 + iff * u8 + iff * u9 + ihat * u3 + irf * u4 + irf * u5 + irf * u6 + irf * u7 + irf * u8 + irf * u9 + ish * u4 + ish * u5 + ish * u6 + ish * u7 + ith * u4 + ith * u5 + 0.5 * z[581] * u1 + 2 * iff * u3 + 2 * irf * u3 + 2 * ish * u3 + 2 * ith * u3 + z[582] * z[498] + z[590] * z[529] + z[592] * z[534] + z[594] * z[552] + z[602] * z[568] + z[604] * z[572] + 0.5 * z[578] * z[363] + 0.5 * z[579] * z[364] + 0.5 * z[585] * z[501] + 0.5 * z[587] * z[502] + 0.5 * z[589] * z[503] + 0.5 * z[597] * z[554] + 0.5 * z[599] * z[555] + 0.5 * z[601] * z[557]) - z[405]) - z[409]) - 0.5 * z[580] * u2) - z[583] * z[497]) - z[591] * z[528]) - z[593] * z[533]) - z[595] * z[551]) - z[603] * z[556]) - z[605] * z[571]) - 0.5 * z[573] * z[360]) - 0.5 * z[575] * z[361]) - 0.5 * z[577] * z[362]) - 0.5 * z[584] * z[497]) - 0.5 * z[600] * z[556]
end

hz(sol) = [hz(sol, t) for t in sol.t]


function px(sol, t)
    @unpack z, mhat, u4, u6, u8, u5, u7, u9 = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((((((z[606] * z[1] + mhat * u1 + z[31] * (z[616] * u1 + z[617] * u2 + z[622] * u1 + z[623] * u2) + z[58] * (z[673] + z[672] * u3 + z[672] * u4 + z[672] * u6 + z[672] * u8) + z[27] * (z[635] + z[632] * u3 + z[632] * u5 + z[632] * u7 + z[632] * u9 + z[633] * u1 + z[634] * u2) + z[46] * (z[645] + z[641] * u9 + z[642] * u3 + z[642] * u5 + z[642] * u7 + z[643] * u1 + z[644] * u2) + z[49] * (z[714] + z[709] * u9 + z[710] * u3 + z[710] * u5 + z[711] * u7 + z[712] * u1 + z[713] * u2) + z[51] * (z[722] + z[715] * u4 + z[716] * u9 + z[717] * u7 + z[718] * u5 + z[719] * u3 + z[720] * u1 + z[721] * u2) + z[64] * (z[661] + z[652] * u8 + z[653] * u9 + z[654] * u5 + z[655] * u7 + z[656] * u3 + z[657] * u4 + z[658] * u6 + z[659] * u1 + z[660] * u2) + z[66] * (z[671] + z[662] * u9 + z[663] * u5 + z[664] * u7 + z[665] * u3 + z[666] * u4 + z[667] * u6 + z[668] * u8 + z[669] * u1 + z[670] * u2) + 0.5 * z[44] * (((((((((2 * z[611] - z[629]) - 2 * z[610] * u3) - 2 * z[610] * u5) - 2 * z[610] * u7) - 2 * z[610] * u9) - z[628] * u3) - z[628] * u5) - z[628] * u7) - z[628] * u9) + z[54] * (z[691] + z[708] + z[683] * u6 + z[700] * u6 + z[684] * u9 + z[685] * u5 + z[686] * u7 + z[687] * u3 + z[688] * u4 + z[701] * u9 + z[702] * u5 + z[703] * u7 + z[704] * u3 + z[705] * u4 + z[689] * u1 + z[690] * u2 + z[706] * u1 + z[707] * u2)) - z[607] * z[2] * u3) - 0.5 * z[40] * (z[631] + z[630] * u3 + z[630] * u5 + z[630] * u7 + z[630] * u9)) - 0.5 * z[62] * (z[674] + z[630] * u3 + z[630] * u4 + z[630] * u6 + z[630] * u8)) - z[48] * (((((((((z[614] * u3 + z[614] * u5) - z[615]) - z[651]) - z[646] * u9) - z[647] * u7) - z[648] * u3) - z[648] * u5) - z[649] * u1) - z[650] * u2)) - z[29] * (((((((((z[612] * u3 + z[612] * u5 + z[612] * u7) - z[613]) - z[640]) - z[636] * u9) - z[637] * u3) - z[637] * u5) - z[637] * u7) - z[638] * u1) - z[639] * u2)) - z[33] * (((((z[609] + z[621] + z[627] + z[608] * u3 + z[608] * u5 + z[608] * u7 + z[608] * u9 + z[620] * u3 + z[620] * u5 + z[620] * u7 + z[620] * u9 + z[626] * u3 + z[626] * u5 + z[626] * u7 + z[626] * u9) - z[618] * u1) - z[619] * u2) - z[624] * u1) - z[625] * u2)) - z[52] * (((((((((((((((z[681] * u4 + z[698] * u4) - z[682]) - z[699]) - z[675] * u9) - z[676] * u3) - z[677] * u5) - z[678] * u7) - z[692] * u9) - z[693] * u3) - z[694] * u5) - z[695] * u7) - z[679] * u1) - z[680] * u2) - z[696] * u1) - z[697] * u2)
end

px(sol) = [px(sol, t) for t in sol.t]


function py(sol, t)
    @unpack z, mhat, u4, u6, u8, u5, u7, u9 = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((((z[606] * z[2] + mhat * u2 + z[607] * z[1] * u3 + z[32] * (z[616] * u1 + z[617] * u2 + z[622] * u1 + z[623] * u2) + z[59] * (z[673] + z[672] * u3 + z[672] * u4 + z[672] * u6 + z[672] * u8) + z[28] * (z[635] + z[632] * u3 + z[632] * u5 + z[632] * u7 + z[632] * u9 + z[633] * u1 + z[634] * u2) + z[47] * (z[645] + z[641] * u9 + z[642] * u3 + z[642] * u5 + z[642] * u7 + z[643] * u1 + z[644] * u2) + z[50] * (z[714] + z[709] * u9 + z[710] * u3 + z[710] * u5 + z[711] * u7 + z[712] * u1 + z[713] * u2) + z[49] * (z[722] + z[715] * u4 + z[716] * u9 + z[717] * u7 + z[718] * u5 + z[719] * u3 + z[720] * u1 + z[721] * u2) + z[65] * (z[661] + z[652] * u8 + z[653] * u9 + z[654] * u5 + z[655] * u7 + z[656] * u3 + z[657] * u4 + z[658] * u6 + z[659] * u1 + z[660] * u2) + z[67] * (z[671] + z[662] * u9 + z[663] * u5 + z[664] * u7 + z[665] * u3 + z[666] * u4 + z[667] * u6 + z[668] * u8 + z[669] * u1 + z[670] * u2) + 0.5 * z[45] * (((((((((2 * z[611] - z[629]) - 2 * z[610] * u3) - 2 * z[610] * u5) - 2 * z[610] * u7) - 2 * z[610] * u9) - z[628] * u3) - z[628] * u5) - z[628] * u7) - z[628] * u9) + z[55] * (z[691] + z[708] + z[683] * u6 + z[700] * u6 + z[684] * u9 + z[685] * u5 + z[686] * u7 + z[687] * u3 + z[688] * u4 + z[701] * u9 + z[702] * u5 + z[703] * u7 + z[704] * u3 + z[705] * u4 + z[689] * u1 + z[690] * u2 + z[706] * u1 + z[707] * u2)) - 0.5 * z[41] * (z[631] + z[630] * u3 + z[630] * u5 + z[630] * u7 + z[630] * u9)) - 0.5 * z[63] * (z[674] + z[630] * u3 + z[630] * u4 + z[630] * u6 + z[630] * u8)) - z[46] * (((((((((z[614] * u3 + z[614] * u5) - z[615]) - z[651]) - z[646] * u9) - z[647] * u7) - z[648] * u3) - z[648] * u5) - z[649] * u1) - z[650] * u2)) - z[30] * (((((((((z[612] * u3 + z[612] * u5 + z[612] * u7) - z[613]) - z[640]) - z[636] * u9) - z[637] * u3) - z[637] * u5) - z[637] * u7) - z[638] * u1) - z[639] * u2)) - z[34] * (((((z[609] + z[621] + z[627] + z[608] * u3 + z[608] * u5 + z[608] * u7 + z[608] * u9 + z[620] * u3 + z[620] * u5 + z[620] * u7 + z[620] * u9 + z[626] * u3 + z[626] * u5 + z[626] * u7 + z[626] * u9) - z[618] * u1) - z[619] * u2) - z[624] * u1) - z[625] * u2)) - z[53] * (((((((((((((((z[681] * u4 + z[698] * u4) - z[682]) - z[699]) - z[675] * u9) - z[676] * u3) - z[677] * u5) - z[678] * u7) - z[692] * u9) - z[693] * u3) - z[694] * u5) - z[695] * u7) - z[679] * u1) - z[680] * u2) - z[696] * u1) - z[697] * u2)
end

py(sol) = [py(sol, t) for t in sol.t]


function rhtq(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[821] + z[778] * u3p + z[779] * u1p + z[780] * u2p
end

rhtq(sol) = [rhtq(sol, t) for t in sol.t]


function lhtq(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[822] + z[783] * u3p + z[784] * u1p + z[785] * u2p
end

lhtq(sol) = [lhtq(sol, t) for t in sol.t]


function rktq(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[823] + z[790] * u3p + z[791] * u1p + z[792] * u2p
end

rktq(sol) = [rktq(sol, t) for t in sol.t]


function lktq(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[824] + z[796] * u3p + z[797] * u1p + z[798] * u2p
end

lktq(sol) = [lktq(sol, t) for t in sol.t]


function ratq(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[825] + z[802] * u3p + z[803] * u1p + z[804] * u2p
end

ratq(sol) = [ratq(sol, t) for t in sol.t]


function latq(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[826] + z[808] * u3p + z[809] * u1p + z[810] * u2p
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

    return ((((((q1 + z[79] * z[64] + z[80] * z[56] + z[81] * z[52] + z[82] * z[49] + z[73] * z[1]) - z[74] * z[31]) - z[77] * z[27]) - z[78] * z[46]) - 0.5 * z[75] * z[42]) - 0.5 * z[76] * z[38]) - 0.5 * z[76] * z[60]
end

pocmx(sol) = [pocmx(sol, t) for t in sol.t]


function vocmx(sol, t)
    @unpack z, u5, u4, u6, u8, u7, u9 = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((((z[281] * z[1] + u1 + z[48] * ((z[286] - z[78] * u3) - z[78] * u5) + z[66] * (z[287] + z[79] * u3 + z[79] * u4 + z[79] * u6 + z[79] * u8) + z[29] * (((z[285] - z[77] * u3) - z[77] * u5) - z[77] * u7) + 0.5 * z[40] * ((((z[284] - z[76] * u3) - z[76] * u5) - z[76] * u7) - z[76] * u9) + 0.5 * z[44] * ((((z[283] - z[75] * u3) - z[75] * u5) - z[75] * u7) - z[75] * u9) + 0.5 * z[62] * ((((z[289] - z[76] * u3) - z[76] * u4) - z[76] * u6) - z[76] * u8)) - z[73] * z[2] * u3) - z[51] * ((z[291] - z[82] * u3) - z[82] * u4)) - z[33] * (z[282] + z[74] * u3 + z[74] * u5 + z[74] * u7 + z[74] * u9)) - z[54] * (((z[290] - z[81] * u3) - z[81] * u4) - z[81] * u6)) - z[58] * ((((z[288] - z[80] * u3) - z[80] * u4) - z[80] * u6) - z[80] * u8)
end

vocmx(sol) = [vocmx(sol, t) for t in sol.t]


function vocmy(sol, t)
    @unpack z, u5, u4, u6, u8, u7, u9 = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((z[281] * z[2] + u2 + z[73] * z[1] * u3 + z[46] * ((z[286] - z[78] * u3) - z[78] * u5) + z[67] * (z[287] + z[79] * u3 + z[79] * u4 + z[79] * u6 + z[79] * u8) + z[30] * (((z[285] - z[77] * u3) - z[77] * u5) - z[77] * u7) + 0.5 * z[41] * ((((z[284] - z[76] * u3) - z[76] * u5) - z[76] * u7) - z[76] * u9) + 0.5 * z[45] * ((((z[283] - z[75] * u3) - z[75] * u5) - z[75] * u7) - z[75] * u9) + 0.5 * z[63] * ((((z[289] - z[76] * u3) - z[76] * u4) - z[76] * u6) - z[76] * u8)) - z[49] * ((z[291] - z[82] * u3) - z[82] * u4)) - z[34] * (z[282] + z[74] * u3 + z[74] * u5 + z[74] * u7 + z[74] * u9)) - z[55] * (((z[290] - z[81] * u3) - z[81] * u4) - z[81] * u6)) - z[59] * ((((z[288] - z[80] * u3) - z[80] * u4) - z[80] * u6) - z[80] * u8)
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
    @unpack footang, g, iff, ihat, irf, ish, ith, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lmtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, ltoexi, mff, mhat, mrf, msh, mth, mtpb, mtpk, rmtpxi, rtoexi, u4, u5, u6, u7, u8, u9, z = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # specified variables
    rmtp = _rmtp(t)
    ra = _ra(t)
    rk = _rk(t)
    rh = _rh(t)
    la = _la(t)
    lmtp = _lmtp(t)
    lh = _lh(t)
    lk = _lk(t)
    lkp = _lkp(t)
    lap = _lap(t)
    lhp = _lhp(t)
    lmtpp = _lmtpp(t)
    rhp = _rhp(t)
    rkp = _rkp(t)
    rap = _rap(t)
    rmtpp = _rmtpp(t)
    rkpp = _rkpp(t)
    rhpp = _rhpp(t)
    lkpp = _lkpp(t)
    lhpp = _lhpp(t)
    rapp = _rapp(t)
    lapp = _lapp(t)
    rmtppp = _rmtppp(t)
    lmtppp = _lmtppp(t)
    hato = _hato(t)
    hatop = _hatop(t)
    hatopp = _hatopp(t)

    # calculated variables
    lrx1, lry1, lrx2, lry2, rrx1, rry1, rrx2, rry2 = zeros(8) # contact_forces(u,p,t)

    u4 = 0
    u5 = 0
    u6 = 0
    u7 = 0
    u8 = 0
    u9 = 0
    z[380] = g * msh
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
    z[74] = (lff * mff + lff * mhat + lffo * mff + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth) / z[72]
    z[75] = (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mrf + 4 * lrf * msh + 4 * lrf * mth) / z[72]
    z[76] = (lrffo * mrf) / z[72]
    z[77] = (lsh * mff + lsh * mhat + lsh * mrf + lsh * msh + lsho * msh + 2 * lsh * mth) / z[72]
    z[78] = (lth * mff + lth * mhat + lth * mrf + lth * msh + lth * mth + ltho * mth) / z[72]
    z[79] = (mff * z[68]) / z[72]
    z[80] = (lrf * mff + mrf * z[69]) / z[72]
    z[81] = (lsh * mff + lsh * mrf + msh * z[70]) / z[72]
    z[82] = (lth * mff + lth * mrf + lth * msh + mth * z[71]) / z[72]
    z[377] = g * mhat
    z[381] = g * mth
    z[411] = z[74] - lff
    z[412] = 0.5 * z[75] - lrf
    z[413] = z[77] - lsh
    z[414] = z[78] - lth
    z[499] = 0.5 * z[75] - 0.5lrfo
    z[500] = 0.5 * z[76] - 0.5lrffo
    z[524] = 2lrf - z[75]
    z[525] = lff - z[74]
    z[530] = lsh - z[77]
    z[545] = lsh - z[81]
    z[546] = lth - z[82]
    z[547] = lrf - z[80]
    z[548] = lth - z[78]
    z[553] = (lrf - 0.5lrfo) - z[80]
    z[576] = z[19] * z[76]
    z[586] = 2 * z[499] + 2 * z[19] * z[500]
    z[588] = 2 * z[500] + 2 * z[19] * z[499]
    z[596] = 2 * z[553] + 2 * z[19] * z[500]
    z[598] = 2 * z[500] + 2 * z[19] * z[553]
    z[608] = lff * mhat
    z[610] = lrf * mhat
    z[612] = lsh * mhat
    z[614] = lth * mhat
    z[620] = lffo * mff
    z[626] = lff * mrf
    z[628] = lrfo * mrf
    z[630] = lrffo * mrf
    z[672] = mrf * z[69]
    z[683] = lsh * mrf
    z[700] = msh * z[70]
    z[715] = mth * z[71]
    z[727] = z[71] * z[381]
    z[730] = z[70] * z[380]
    z[754] = ihat + 2iff + 2irf + 2ish + 2ith + mff * lffo^2
    z[755] = lrffo^2 + lrfo^2 + 4 * lff^2 + 2 * lrffo * lrfo * z[19]
    z[756] = lff * lrffo
    z[757] = lff * lrfo
    z[758] = lrffo^2 + 4 * z[69]^2
    z[759] = lrffo * z[19] * z[69]
    z[760] = lff^2 + lrf^2 + lsh^2 + lth^2
    z[761] = lff * lsh
    z[762] = lff * lth
    z[763] = lrf * lth
    z[764] = lff * lrf
    z[765] = lrf * lsh
    z[766] = lsh * lth
    z[768] = lrffo * z[19]
    z[769] = lrfo * z[19]
    z[770] = lrffo * z[20]
    z[771] = lrfo * z[20]
    z[772] = z[19] * z[69]
    z[773] = z[20] * z[69]
    z[775] = iff + irf + ish + ith
    z[776] = lrffo^2
    z[777] = z[69]^2
    z[782] = iff + irf + ish + ith + mff * lffo^2
    z[787] = iff + irf + ish
    z[788] = lsh * z[69]
    z[789] = lrffo * lsh
    z[794] = iff + irf + ish + mff * lffo^2
    z[795] = lff^2 + lrf^2 + lsh^2
    z[800] = iff + irf
    z[801] = (lrffo^2 + 4 * z[69]^2) - 4 * lrffo * z[19] * z[69]
    z[806] = iff + irf + mff * lffo^2
    z[807] = lff^2 + lrf^2
    z[149] = z[145] - z[147]
    z[165] = z[162] + z[163]
    z[186] = z[183] - z[184]
    z[271] = z[264] + z[266]
    z[268] = z[68] + z[260]
    z[269] = z[68] + z[255]
    z[270] = z[68] - z[263]
    z[210] = z[205] + z[207]
    z[209] = z[70] - z[204]
    z[73] = (mhat * hato) / z[72]
    z[36] = z[19] * z[14] - z[20] * z[13]
    z[39] = z[35] * z[28] + z[36] * z[30]
    z[61] = z[19] * z[57] + z[20] * z[59]
    z[402] = iff * z[117]
    z[403] = irf * z[120]
    z[404] = ish * z[146]
    z[406] = iff * z[265]
    z[407] = irf * z[215]
    z[408] = ish * z[206]
    z[109] = z[1] * z[65] - z[2] * z[64]
    z[97] = z[1] * z[57] - z[2] * z[56]
    z[89] = z[1] * z[53] - z[2] * z[52]
    z[38] = z[35] * z[27] + z[36] * z[29]
    z[123] = z[1] * z[39] - z[2] * z[38]
    z[60] = z[19] * z[56] + z[20] * z[58]
    z[218] = z[1] * z[61] - z[2] * z[60]
    z[574] = mhat * hatop * (((((((2 * z[414] * z[6] + 2 * z[79] * z[109] + 2 * z[80] * z[97] + 2 * z[81] * z[89]) - 2 * z[82] * z[4]) - 2 * z[413] * z[25]) - 2 * z[411] * z[115]) - 2 * z[412] * z[103]) - z[76] * z[123]) - z[76] * z[218])
    z[410] = hato - z[73]
    z[581] = mhat * ((((((((2 * z[79] * z[65] + 2 * z[80] * z[57] + 2 * z[81] * z[53] + 2 * z[82] * z[50]) - 2 * z[411] * z[32]) - 2 * z[412] * z[43]) - 2 * z[413] * z[28]) - 2 * z[414] * z[47]) - 2 * z[410] * z[2]) - z[76] * z[39]) - z[76] * z[61])
    z[389] = z[10] * z[22] - z[9] * z[21]
    z[419] = z[31] * z[64] + z[32] * z[65]
    z[421] = z[31] * z[66] + z[32] * z[67]
    z[435] = -(z[15]) * z[419] - z[16] * z[421]
    z[437] = z[16] * z[419] - z[15] * z[421]
    z[451] = z[19] * z[435] + z[20] * z[437]
    z[467] = -(z[11]) * z[435] - z[12] * z[437]
    z[113] = z[1] * z[31] + z[2] * z[32]
    z[483] = z[3] * z[113] - z[4] * z[115]
    z[495] = (((((((z[74] + z[77] * z[21] + z[78] * z[389] + 0.5 * z[76] * z[396] + 0.5 * z[76] * z[451]) - lffo) - 0.5 * z[75] * z[17]) - z[79] * z[419]) - z[80] * z[435]) - z[81] * z[467]) - z[82] * z[483]) - z[73] * z[113]
    z[582] = mff * z[495]
    z[498] = (((((z[33] * u1 + z[34] * u2) - z[118]) - lffo * u3) - lffo * u5) - lffo * u7) - lffo * u9
    z[427] = z[27] * z[64] + z[28] * z[65]
    z[429] = z[27] * z[66] + z[28] * z[67]
    z[443] = -(z[15]) * z[427] - z[16] * z[429]
    z[445] = z[16] * z[427] - z[15] * z[429]
    z[459] = z[19] * z[443] + z[20] * z[445]
    z[491] = z[3] * z[24] - z[4] * z[25]
    z[475] = -(z[11]) * z[443] - z[12] * z[445]
    z[526] = ((((((((z[77] + 0.5 * z[76] * z[35] + 0.5 * z[524] * z[13] + 0.5 * z[76] * z[459]) - lsho) - z[78] * z[9]) - z[82] * z[491]) - z[525] * z[21]) - z[24] * z[73]) - z[79] * z[427]) - z[80] * z[443]) - z[81] * z[475]
    z[590] = msh * z[526]
    z[529] = z[149] + z[142] * u9 + z[148] * u3 + z[148] * u5 + z[148] * u7 + z[143] * u1 + z[144] * u2
    z[415] = z[19] * z[393] + z[20] * z[395]
    z[431] = z[46] * z[64] + z[47] * z[65]
    z[433] = z[46] * z[66] + z[47] * z[67]
    z[447] = -(z[15]) * z[431] - z[16] * z[433]
    z[449] = z[16] * z[431] - z[15] * z[433]
    z[463] = z[19] * z[447] + z[20] * z[449]
    z[479] = -(z[7]) * z[169] - z[8] * z[170]
    z[531] = ((((((((z[78] + z[530] * z[9] + 0.5 * z[76] * z[415] + 0.5 * z[76] * z[463]) - ltho) - z[81] * z[479]) - z[82] * z[169]) - z[525] * z[389]) - z[5] * z[73]) - 0.5 * z[524] * z[393]) - z[79] * z[431]) - z[80] * z[447]
    z[592] = mth * z[531]
    z[534] = z[165] + z[158] * u9 + z[159] * u7 + z[164] * u3 + z[164] * u5 + z[160] * u1 + z[161] * u2
    z[538] = z[11] * z[15] - z[12] * z[16]
    z[535] = z[20] * z[16] - z[19] * z[15]
    z[107] = z[1] * z[64] + z[2] * z[65]
    z[541] = z[3] * z[107] - z[4] * z[109]
    z[504] = z[38] * z[64] + z[39] * z[65]
    z[423] = z[42] * z[64] + z[43] * z[65]
    z[549] = ((((((((lff + z[545] * z[538] + 0.5 * z[76] * z[535] + z[546] * z[541] + 0.5 * z[76] * z[504]) - lffo) - z[79]) - z[547] * z[15]) - z[525] * z[419]) - z[530] * z[427]) - z[548] * z[431]) - z[73] * z[107]) - 0.5 * z[524] * z[423]
    z[594] = mff * z[549]
    z[552] = z[271] + z[256] * u9 + z[257] * u5 + z[258] * u7 + z[267] * u3 + z[268] * u4 + z[269] * u6 + z[270] * u8 + z[261] * u1 + z[262] * u2
    z[506] = z[38] * z[66] + z[39] * z[67]
    z[508] = -(z[15]) * z[504] - z[16] * z[506]
    z[510] = z[16] * z[504] - z[15] * z[506]
    z[516] = -(z[11]) * z[508] - z[12] * z[510]
    z[87] = z[1] * z[52] + z[2] * z[53]
    z[425] = z[42] * z[66] + z[43] * z[67]
    z[439] = -(z[15]) * z[423] - z[16] * z[425]
    z[441] = z[16] * z[423] - z[15] * z[425]
    z[471] = -(z[11]) * z[439] - z[12] * z[441]
    z[566] = (((((((((lsh + z[80] * z[11] + 0.5 * z[76] * z[399] + 0.5 * z[76] * z[516]) - lsho) - z[81]) - z[79] * z[538]) - z[546] * z[7]) - z[548] * z[479]) - z[525] * z[467]) - z[530] * z[475]) - z[73] * z[87]) - 0.5 * z[524] * z[471]
    z[602] = msh * z[566]
    z[568] = z[210] + z[70] * u6 + z[198] * u9 + z[200] * u5 + z[201] * u7 + z[208] * u3 + z[209] * u4 + z[202] * u1 + z[203] * u2
    z[121] = z[1] * z[38] + z[2] * z[39]
    z[520] = z[3] * z[121] - z[4] * z[123]
    z[216] = z[1] * z[60] + z[2] * z[61]
    z[562] = z[3] * z[216] - z[4] * z[218]
    z[95] = z[1] * z[56] + z[2] * z[57]
    z[558] = z[3] * z[95] - z[4] * z[97]
    z[101] = z[1] * z[42] + z[2] * z[43]
    z[487] = z[3] * z[101] - z[4] * z[103]
    z[569] = (((((((((lth + z[81] * z[7] + 0.5 * z[76] * z[520] + 0.5 * z[76] * z[562]) - ltho) - z[82]) - z[530] * z[491]) - z[548] * z[169]) - z[3] * z[73]) - z[79] * z[541]) - z[80] * z[558]) - z[525] * z[483]) - 0.5 * z[524] * z[487]
    z[604] = mth * z[569]
    z[572] = z[186] + z[71] * u4 + z[178] * u9 + z[179] * u7 + z[180] * u5 + z[185] * u3 + z[181] * u1 + z[182] * u2
    z[578] = mhat * (((((((2 * z[413] + z[76] * z[35] + 2 * z[411] * z[21] + 2 * z[24] * z[410] + z[76] * z[459]) - 2 * z[82] * z[491]) - 2 * z[412] * z[13]) - 2 * z[414] * z[9]) - 2 * z[79] * z[427]) - 2 * z[80] * z[443]) - 2 * z[81] * z[475])
    z[579] = mhat * ((((((2 * z[414] + z[76] * z[415] + 2 * z[411] * z[389] + 2 * z[412] * z[393] + 2 * z[5] * z[410] + z[76] * z[463]) - 2 * z[81] * z[479]) - 2 * z[82] * z[169]) - 2 * z[413] * z[9]) - 2 * z[79] * z[431]) - 2 * z[80] * z[447])
    z[585] = mrf * (((((((2 * z[411] + 2 * z[77] * z[21] + 2 * z[78] * z[389] + 2 * z[500] * z[396] + z[76] * z[451]) - 2 * z[499] * z[17]) - 2 * z[79] * z[419]) - 2 * z[80] * z[435]) - 2 * z[81] * z[467]) - 2 * z[82] * z[483]) - 2 * z[73] * z[113])
    z[501] = (((((z[33] * u1 + z[34] * u2) - z[119]) - lff * u3) - lff * u5) - lff * u7) - lff * u9
    z[455] = z[19] * z[439] + z[20] * z[441]
    z[587] = mrf * ((((((((z[586] + 2 * z[78] * z[393] + z[76] * z[455]) - 2 * z[77] * z[13]) - 2 * z[411] * z[17]) - 2 * z[79] * z[423]) - 2 * z[80] * z[439]) - 2 * z[81] * z[471]) - 2 * z[82] * z[487]) - 2 * z[73] * z[101])
    z[502] = (((-0.5 * z[125] - 0.5 * lrfo * u3) - 0.5 * lrfo * u5) - 0.5 * lrfo * u7) - 0.5 * lrfo * u9
    z[512] = z[19] * z[508] + z[20] * z[510]
    z[589] = mrf * ((((((z[588] + 2 * z[77] * z[35] + 2 * z[78] * z[415] + 2 * z[411] * z[396] + z[76] * z[512]) - 2 * z[79] * z[504]) - 2 * z[80] * z[508]) - 2 * z[81] * z[516]) - 2 * z[82] * z[520]) - 2 * z[73] * z[121])
    z[503] = (((-0.5 * z[126] - 0.5 * lrffo * u3) - 0.5 * lrffo * u5) - 0.5 * lrffo * u7) - 0.5 * lrffo * u9
    z[597] = mrf * (((z[596] + 2 * z[79] * z[15] + z[76] * z[508] + 2 * z[411] * z[435] + 2 * z[412] * z[439] + 2 * z[413] * z[443] + 2 * z[414] * z[447] + 2 * z[546] * z[558]) - 2 * z[545] * z[11]) - 2 * z[73] * z[95])
    z[554] = z[220] + z[69] * u3 + z[69] * u4 + z[69] * u6 + z[69] * u8
    z[599] = mrf * (((z[598] + 2 * z[545] * z[399] + z[76] * z[512] + 2 * z[411] * z[451] + 2 * z[412] * z[455] + 2 * z[413] * z[459] + 2 * z[414] * z[463] + 2 * z[546] * z[562]) - 2 * z[79] * z[535]) - 2 * z[73] * z[216])
    z[555] = (((-0.5 * z[221] - 0.5 * lrffo * u3) - 0.5 * lrffo * u4) - 0.5 * lrffo * u6) - 0.5 * lrffo * u8
    z[601] = mrf * (((((2 * z[545] + 2 * z[414] * z[479] + 2 * z[500] * z[399] + z[76] * z[516] + 2 * z[411] * z[467] + 2 * z[412] * z[471] + 2 * z[413] * z[475]) - 2 * z[79] * z[538]) - 2 * z[546] * z[7]) - 2 * z[553] * z[11]) - 2 * z[73] * z[87])
    z[557] = z[214] + lsh * u6 + z[198] * u9 + z[200] * u5 + z[201] * u7 + z[212] * u3 + z[213] * u4 + z[202] * u1 + z[203] * u2
    z[405] = ith * lhp
    z[409] = ith * rhp
    z[580] = mhat * ((((((((2 * z[79] * z[64] + 2 * z[80] * z[56] + 2 * z[81] * z[52] + 2 * z[82] * z[49]) - 2 * z[411] * z[31]) - 2 * z[412] * z[42]) - 2 * z[413] * z[27]) - 2 * z[414] * z[46]) - 2 * z[410] * z[1]) - z[76] * z[38]) - z[76] * z[60])
    z[420] = z[33] * z[64] + z[34] * z[65]
    z[422] = z[33] * z[66] + z[34] * z[67]
    z[436] = -(z[15]) * z[420] - z[16] * z[422]
    z[438] = z[16] * z[420] - z[15] * z[422]
    z[452] = z[19] * z[436] + z[20] * z[438]
    z[468] = -(z[11]) * z[436] - z[12] * z[438]
    z[484] = z[3] * z[114] - z[4] * z[116]
    z[496] = ((((((z[77] * z[23] + z[78] * z[391] + 0.5 * z[76] * z[398] + 0.5 * z[76] * z[452]) - 0.5 * z[75] * z[18]) - z[79] * z[420]) - z[80] * z[436]) - z[81] * z[468]) - z[82] * z[484]) - z[73] * z[114]
    z[583] = mff * z[496]
    z[497] = z[31] * u1 + z[32] * u2
    z[428] = z[29] * z[64] + z[30] * z[65]
    z[430] = z[29] * z[66] + z[30] * z[67]
    z[444] = -(z[15]) * z[428] - z[16] * z[430]
    z[446] = z[16] * z[428] - z[15] * z[430]
    z[460] = z[19] * z[444] + z[20] * z[446]
    z[492] = z[3] * z[26] - z[4] * z[24]
    z[476] = -(z[11]) * z[444] - z[12] * z[446]
    z[527] = (((((((z[78] * z[10] + 0.5 * z[76] * z[36] + 0.5 * z[76] * z[460]) - z[82] * z[492]) - z[525] * z[22]) - z[26] * z[73]) - 0.5 * z[524] * z[14]) - z[79] * z[428]) - z[80] * z[444]) - z[81] * z[476]
    z[591] = msh * z[527]
    z[528] = z[141] + z[138] * u3 + z[138] * u5 + z[138] * u7 + z[138] * u9 + z[139] * u1 + z[140] * u2
    z[416] = z[19] * z[394] + z[20] * z[393]
    z[432] = z[46] * z[65] + z[48] * z[64]
    z[434] = z[46] * z[67] + z[48] * z[66]
    z[448] = -(z[15]) * z[432] - z[16] * z[434]
    z[450] = z[16] * z[432] - z[15] * z[434]
    z[464] = z[19] * z[448] + z[20] * z[450]
    z[480] = -(z[7]) * z[171] - z[8] * z[169]
    z[532] = (((((((z[530] * z[10] + 0.5 * z[76] * z[416] + 0.5 * z[76] * z[464]) - z[81] * z[480]) - z[82] * z[171]) - z[525] * z[390]) - z[6] * z[73]) - 0.5 * z[524] * z[394]) - z[79] * z[432]) - z[80] * z[448]
    z[593] = mth * z[532]
    z[533] = z[157] + z[153] * u9 + z[154] * u3 + z[154] * u5 + z[154] * u7 + z[155] * u1 + z[156] * u2
    z[539] = z[11] * z[16] + z[12] * z[15]
    z[536] = -(z[19]) * z[16] - z[20] * z[15]
    z[108] = z[1] * z[66] + z[2] * z[67]
    z[110] = z[1] * z[67] - z[2] * z[66]
    z[542] = z[3] * z[108] - z[4] * z[110]
    z[550] = ((((((z[545] * z[539] + 0.5 * z[76] * z[536] + z[546] * z[542] + 0.5 * z[76] * z[506]) - z[547] * z[16]) - z[525] * z[421]) - z[530] * z[429]) - z[548] * z[433]) - z[73] * z[108]) - 0.5 * z[524] * z[425]
    z[595] = mff * z[550]
    z[551] = z[254] + z[245] * u8 + z[246] * u9 + z[247] * u5 + z[248] * u7 + z[249] * u3 + z[250] * u4 + z[251] * u6 + z[252] * u1 + z[253] * u2
    z[518] = z[12] * z[508] - z[11] * z[510]
    z[540] = -(z[11]) * z[16] - z[12] * z[15]
    z[481] = z[8] * z[169] - z[7] * z[170]
    z[469] = z[12] * z[435] - z[11] * z[437]
    z[477] = z[12] * z[443] - z[11] * z[445]
    z[88] = z[1] * z[54] + z[2] * z[55]
    z[473] = z[12] * z[439] - z[11] * z[441]
    z[567] = (((((((z[546] * z[8] + 0.5 * z[76] * z[400] + 0.5 * z[76] * z[518]) - z[79] * z[540]) - z[80] * z[12]) - z[548] * z[481]) - z[525] * z[469]) - z[530] * z[477]) - z[73] * z[88]) - 0.5 * z[524] * z[473]
    z[603] = msh * z[567]
    z[556] = (z[197] + z[190] * u9 + z[191] * u3 + z[192] * u5 + z[193] * u7 + z[194] * u1 + z[195] * u2) - z[196] * u4
    z[522] = z[3] * z[123] + z[4] * z[121]
    z[564] = z[3] * z[218] + z[4] * z[216]
    z[493] = z[3] * z[25] + z[4] * z[24]
    z[543] = z[3] * z[109] + z[4] * z[107]
    z[560] = z[3] * z[97] + z[4] * z[95]
    z[485] = z[3] * z[115] + z[4] * z[113]
    z[489] = z[3] * z[103] + z[4] * z[101]
    z[570] = (((((((z[81] * z[8] + 0.5 * z[76] * z[522] + 0.5 * z[76] * z[564]) - z[530] * z[493]) - z[548] * z[170]) - z[4] * z[73]) - z[79] * z[543]) - z[80] * z[560]) - z[525] * z[485]) - 0.5 * z[524] * z[489]
    z[605] = mth * z[570]
    z[571] = z[177] + z[172] * u9 + z[173] * u3 + z[173] * u5 + z[174] * u7 + z[175] * u1 + z[176] * u2
    z[573] = mhat * ((((((((2 * z[82] * z[3] + 2 * z[79] * z[107] + 2 * z[80] * z[95] + 2 * z[81] * z[87]) - 2 * z[410]) - 2 * z[413] * z[24]) - 2 * z[414] * z[5]) - 2 * z[411] * z[113]) - 2 * z[412] * z[101]) - z[76] * z[121]) - z[76] * z[216])
    z[575] = mhat * (((((((2 * z[412] * z[17] + 2 * z[79] * z[419] + 2 * z[80] * z[435] + 2 * z[81] * z[467] + 2 * z[82] * z[483]) - 2 * z[411]) - 2 * z[413] * z[21]) - 2 * z[414] * z[389]) - z[76] * z[396]) - 2 * z[410] * z[113]) - z[76] * z[451])
    z[577] = mhat * ((((((2 * z[411] * z[17] + 2 * z[413] * z[13] + 2 * z[79] * z[423] + 2 * z[80] * z[439] + 2 * z[81] * z[471] + 2 * z[82] * z[487]) - 2 * z[412]) - z[576]) - 2 * z[414] * z[393]) - 2 * z[410] * z[101]) - z[76] * z[455])
    z[584] = mrf * (((((((2 * z[77] * z[23] + 2 * z[78] * z[391] + 2 * z[500] * z[398] + z[76] * z[452]) - 2 * z[499] * z[18]) - 2 * z[79] * z[420]) - 2 * z[80] * z[436]) - 2 * z[81] * z[468]) - 2 * z[82] * z[484]) - 2 * z[73] * z[114])
    z[600] = mrf * (((2 * z[414] * z[481] + 2 * z[500] * z[400] + 2 * z[546] * z[8] + 2 * z[553] * z[12] + z[76] * z[518] + 2 * z[411] * z[469] + 2 * z[412] * z[473] + 2 * z[413] * z[477]) - 2 * z[79] * z[540]) - 2 * z[73] * z[88])
    z[606] = mhat * hatop
    z[616] = mff * z[31]
    z[617] = mff * z[32]
    z[622] = mrf * z[31]
    z[623] = mrf * z[32]
    z[673] = mrf * z[220]
    z[635] = msh * z[141]
    z[632] = msh * z[138]
    z[633] = msh * z[139]
    z[634] = msh * z[140]
    z[645] = mth * z[157]
    z[641] = mth * z[153]
    z[642] = mth * z[154]
    z[643] = mth * z[155]
    z[644] = mth * z[156]
    z[714] = mth * z[177]
    z[709] = mth * z[172]
    z[710] = mth * z[173]
    z[711] = mth * z[174]
    z[712] = mth * z[175]
    z[713] = mth * z[176]
    z[722] = mth * z[186]
    z[716] = mth * z[178]
    z[717] = mth * z[179]
    z[718] = mth * z[180]
    z[719] = mth * z[185]
    z[720] = mth * z[181]
    z[721] = mth * z[182]
    z[661] = mff * z[254]
    z[652] = mff * z[245]
    z[653] = mff * z[246]
    z[654] = mff * z[247]
    z[655] = mff * z[248]
    z[656] = mff * z[249]
    z[657] = mff * z[250]
    z[658] = mff * z[251]
    z[659] = mff * z[252]
    z[660] = mff * z[253]
    z[671] = mff * z[271]
    z[662] = mff * z[256]
    z[663] = mff * z[257]
    z[664] = mff * z[258]
    z[665] = mff * z[267]
    z[666] = mff * z[268]
    z[667] = mff * z[269]
    z[668] = mff * z[270]
    z[669] = mff * z[261]
    z[670] = mff * z[262]
    z[611] = mhat * z[279]
    z[629] = mrf * z[125]
    z[691] = mrf * z[214]
    z[708] = msh * z[210]
    z[684] = mrf * z[198]
    z[685] = mrf * z[200]
    z[686] = mrf * z[201]
    z[687] = mrf * z[212]
    z[688] = mrf * z[213]
    z[701] = msh * z[198]
    z[702] = msh * z[200]
    z[703] = msh * z[201]
    z[704] = msh * z[208]
    z[705] = msh * z[209]
    z[689] = mrf * z[202]
    z[690] = mrf * z[203]
    z[706] = msh * z[202]
    z[707] = msh * z[203]
    z[607] = mhat * hato
    z[40] = z[35] * z[29] + z[37] * z[27]
    z[631] = mrf * z[126]
    z[62] = z[19] * z[58] - z[20] * z[56]
    z[674] = mrf * z[221]
    z[615] = mhat * z[166]
    z[651] = mth * z[165]
    z[646] = mth * z[158]
    z[647] = mth * z[159]
    z[648] = mth * z[164]
    z[649] = mth * z[160]
    z[650] = mth * z[161]
    z[613] = mhat * z[280]
    z[640] = msh * z[149]
    z[636] = msh * z[142]
    z[637] = msh * z[148]
    z[638] = msh * z[143]
    z[639] = msh * z[144]
    z[609] = mhat * z[278]
    z[621] = mff * z[118]
    z[627] = mrf * z[119]
    z[618] = mff * z[33]
    z[619] = mff * z[34]
    z[624] = mrf * z[33]
    z[625] = mrf * z[34]
    z[681] = mrf * z[196]
    z[698] = msh * z[196]
    z[682] = mrf * z[197]
    z[699] = msh * z[197]
    z[675] = mrf * z[190]
    z[676] = mrf * z[191]
    z[677] = mrf * z[192]
    z[678] = mrf * z[193]
    z[692] = msh * z[190]
    z[693] = msh * z[191]
    z[694] = msh * z[192]
    z[695] = msh * z[193]
    z[679] = mrf * z[194]
    z[680] = mrf * z[195]
    z[696] = msh * z[194]
    z[697] = msh * z[195]
    z[781] = (((z[743] + z[744] + z[745] + z[715] * z[328] + mff * (z[250] * z[355] + z[268] * z[356])) - z[746]) - msh * (z[196] * z[336] - z[209] * z[337])) - 0.25 * mrf * ((((((((2 * z[768] * z[341] + 2 * z[772] * z[342] + 2 * z[213] * z[399] * z[342] + 4 * z[11] * z[213] * z[341] + 2 * z[770] * z[344] + 4 * z[196] * z[339] + 2 * lrffo * z[399] * z[340] + 2 * lrffo * z[401] * z[339] + 2 * z[196] * z[399] * z[345] + 4 * z[69] * z[11] * z[340] + 4 * z[69] * z[12] * z[339] + 4 * z[11] * z[196] * z[344] + 4 * z[12] * z[213] * z[344]) - 4 * z[69] * z[341]) - lrffo * z[342]) - 4 * z[12] * z[196] * z[341]) - 2 * z[196] * z[401] * z[342]) - 4 * z[213] * z[340]) - 2 * z[773] * z[345]) - 2 * z[213] * z[400] * z[345])
    z[821] = ((((((((((z[380] * (z[196] * z[53] - z[209] * z[55]) + 0.5 * z[379] * (((lrffo * z[63] + 2 * z[196] * z[53]) - 2 * z[69] * z[59]) - 2 * z[213] * z[55]) + z[781]) - z[727] * z[49]) - z[227] * rrx2 * z[56]) - z[227] * rry2 * z[57]) - z[242] * rrx2 * z[58]) - z[242] * rry2 * z[59]) - z[250] * rrx1 * z[64]) - z[250] * rry1 * z[65]) - z[274] * rrx1 * z[66]) - z[274] * rry1 * z[67]) - z[378] * (z[250] * z[65] + z[268] * z[67])
    z[778] = ((z[775] + z[715] * z[185] + mff * (z[249] * z[250] + z[267] * z[268])) - msh * (z[191] * z[196] - z[208] * z[209])) - 0.25 * mrf * ((((((4 * z[759] + 4 * z[191] * z[196] + 2 * lrffo * z[191] * z[401] + 2 * lrffo * z[212] * z[399] + 2 * lrffo * z[213] * z[399] + 4 * z[69] * z[11] * z[212] + 4 * z[69] * z[11] * z[213] + 4 * z[69] * z[12] * z[191]) - 4 * z[777]) - z[776]) - 4 * z[212] * z[213]) - 4 * z[69] * z[12] * z[196]) - 2 * lrffo * z[196] * z[401])
    z[779] = (z[715] * z[181] + mff * (z[250] * z[252] + z[268] * z[261]) + 0.5 * mrf * (((((2 * z[213] * z[202] - 2 * z[196] * z[194]) - 2 * z[69] * z[11] * z[202]) - 2 * z[69] * z[12] * z[194]) - lrffo * z[399] * z[202]) - lrffo * z[401] * z[194])) - msh * (z[196] * z[194] - z[209] * z[202])
    z[780] = (z[715] * z[182] + mff * (z[250] * z[253] + z[268] * z[262]) + 0.5 * mrf * (((((2 * z[213] * z[203] - 2 * z[196] * z[195]) - 2 * z[69] * z[11] * z[203]) - 2 * z[69] * z[12] * z[195]) - lrffo * z[399] * z[203]) - lrffo * z[401] * z[195])) - msh * (z[196] * z[195] - z[209] * z[203])
    z[786] = (((z[736] + z[738] + z[740] + z[620] * z[292] + mff * (z[247] * z[355] + z[257] * z[356]) + msh * (z[138] * z[311] + z[148] * z[312]) + msh * (z[192] * z[336] + z[200] * z[337]) + mth * (z[154] * z[319] + z[164] * z[320]) + mth * (z[173] * z[327] + z[180] * z[328]) + 0.25 * mrf * (((((((lrffo * z[298] + lrfo * z[297] + z[768] * z[297] + z[769] * z[298] + 4 * lff * z[295] + 2 * lff * z[396] * z[298] + 2 * lrffo * z[396] * z[295] + z[770] * z[300] + 2 * lff * z[18] * z[300]) - 2 * lff * z[17] * z[297]) - 2 * lrfo * z[17] * z[295]) - z[771] * z[301]) - 2 * lff * z[398] * z[301]) - 2 * lrffo * z[397] * z[296]) - 2 * lrfo * z[18] * z[296])) - z[742]) - 0.5 * mrf * ((((((z[192] * z[401] * z[342] + z[200] * z[399] * z[342] + 2 * z[11] * z[200] * z[341] + 2 * z[12] * z[192] * z[341] + 2 * z[12] * z[200] * z[344]) - 2 * z[192] * z[339]) - 2 * z[200] * z[340]) - 2 * z[11] * z[192] * z[344]) - z[192] * z[399] * z[345]) - z[200] * z[400] * z[345])) - mhat * (((((((((((((((lrf * z[369] + lsh * z[370] + lth * z[321] + lff * z[21] * z[370] + lff * z[392] * z[321] + lrf * z[17] * z[366] + lrf * z[393] * z[321] + lth * z[393] * z[369] + lff * z[18] * z[374] + lff * z[114] * z[371] + lff * z[116] * z[372] + lrf * z[14] * z[375] + lrf * z[18] * z[373] + lrf * z[102] * z[371] + lrf * z[104] * z[372] + lsh * z[22] * z[373] + lsh * z[24] * z[372] + lsh * z[26] * z[371] + lth * z[5] * z[372] + lth * z[6] * z[371] + lth * z[10] * z[375] + lth * z[390] * z[373]) - lff * z[366]) - lff * z[17] * z[369]) - lrf * z[13] * z[370]) - lsh * z[9] * z[321]) - lsh * z[13] * z[369]) - lsh * z[21] * z[366]) - lth * z[9] * z[370]) - lth * z[392] * z[366]) - lff * z[23] * z[375]) - lff * z[391] * z[376]) - lrf * z[395] * z[376]) - lsh * z[10] * z[376]) - lsh * z[14] * z[374]) - lth * z[394] * z[374])
    z[822] = ((((((((((((((z[725] * z[34] + lff * (lrx2 * z[33] + lry2 * z[34]) + 0.5 * z[379] * (lrffo * z[41] + lrfo * z[45] + 2 * lff * z[34]) + z[377] * (lff * z[34] + lrf * z[45] + lsh * z[30] + lth * z[46]) + z[786]) - z[224] * rrx2 * z[56]) - z[224] * rry2 * z[57]) - z[234] * rrx2 * z[58]) - z[234] * rry2 * z[59]) - z[247] * rrx1 * z[64]) - z[247] * rry1 * z[65]) - z[257] * rrx1 * z[66]) - z[257] * rry1 * z[67]) - z[378] * (z[247] * z[65] + z[257] * z[67])) - z[379] * (z[192] * z[53] + z[200] * z[55])) - z[380] * (z[138] * z[28] + z[148] * z[30])) - z[380] * (z[192] * z[53] + z[200] * z[55])) - z[381] * (z[154] * z[47] + z[164] * z[46])) - z[381] * (z[173] * z[50] + z[180] * z[49])
    z[783] = z[782] + mff * (z[247] * z[249] + z[257] * z[267]) + msh * (z[138]^2 + z[148]^2) + msh * (z[191] * z[192] + z[200] * z[208]) + mth * (z[154]^2 + z[164]^2) + mth * (z[173]^2 + z[180] * z[185]) + 0.25 * mrf * ((z[755] + 4 * z[756] * z[396]) - 4 * z[757] * z[17]) + 0.5 * mrf * (((((2 * z[191] * z[192] + 2 * z[200] * z[212]) - 2 * z[69] * z[11] * z[200]) - 2 * z[69] * z[12] * z[192]) - lrffo * z[192] * z[401]) - lrffo * z[200] * z[399]) + mhat * ((((((((z[760] + 2 * z[761] * z[21] + 2 * z[762] * z[392] + 2 * z[763] * z[393]) - 2 * z[764] * z[17]) - 2 * z[765] * z[13]) - 2 * z[766] * z[9]) - lsh * hato * z[24]) - lth * hato * z[5]) - lff * hato * z[116]) - lrf * hato * z[104])
    z[784] = ((mff * (z[247] * z[252] + z[257] * z[261]) + mrf * (z[192] * z[194] + z[200] * z[202]) + msh * (z[138] * z[139] + z[148] * z[143]) + msh * (z[192] * z[194] + z[200] * z[202]) + mth * (z[154] * z[155] + z[164] * z[160]) + mth * (z[173] * z[175] + z[180] * z[181]) + 0.5 * mrf * ((((lrfo * z[17] * z[33] - 2 * lff * z[33]) - lrffo * z[396] * z[33]) - lrffo * z[397] * z[31]) - lrfo * z[18] * z[31])) - z[620] * z[33]) - mhat * (lff * z[33] + lrf * z[44] + lsh * z[29] + lth * z[48])
    z[785] = ((mff * (z[247] * z[253] + z[257] * z[262]) + mrf * (z[192] * z[195] + z[200] * z[203]) + msh * (z[138] * z[140] + z[148] * z[144]) + msh * (z[192] * z[195] + z[200] * z[203]) + mth * (z[154] * z[156] + z[164] * z[161]) + mth * (z[173] * z[176] + z[180] * z[182]) + 0.5 * mrf * ((((lrfo * z[17] * z[34] - 2 * lff * z[34]) - lrffo * z[396] * z[34]) - lrffo * z[397] * z[32]) - lrfo * z[18] * z[32])) - z[620] * z[34]) - mhat * (lff * z[34] + lrf * z[45] + lsh * z[30] + lth * z[46])
    z[793] = z[743] + z[744] + z[745] + z[700] * z[337] + mff * (z[251] * z[355] + z[269] * z[356]) + 0.25 * mrf * (((((((((((lrffo * z[342] + 4 * z[69] * z[341] + 2 * z[773] * z[345] + 4 * lsh * z[340] + 2 * lsh * z[400] * z[345]) - 2 * z[768] * z[341]) - 2 * z[772] * z[342]) - 4 * lsh * z[11] * z[341]) - 2 * lsh * z[399] * z[342]) - 2 * z[770] * z[344]) - 4 * lsh * z[12] * z[344]) - 4 * z[69] * z[11] * z[340]) - 4 * z[69] * z[12] * z[339]) - 2 * lrffo * z[399] * z[340]) - 2 * lrffo * z[401] * z[339])
    z[823] = ((((((((((0.5 * z[379] * ((lrffo * z[63] - 2 * lsh * z[55]) - 2 * z[69] * z[59]) + z[793]) - z[730] * z[55]) - z[222] * rrx2 * z[56]) - z[222] * rry2 * z[57]) - z[243] * rrx2 * z[58]) - z[243] * rry2 * z[59]) - z[251] * rrx1 * z[64]) - z[251] * rry1 * z[65]) - z[275] * rrx1 * z[66]) - z[275] * rry1 * z[67]) - z[378] * (z[251] * z[65] + z[269] * z[67])
    z[790] = z[787] + z[700] * z[208] + mff * (z[249] * z[251] + z[267] * z[269]) + 0.25 * mrf * ((((((((z[758] + 4 * lsh * z[212]) - 4 * z[759]) - 4 * z[788] * z[11]) - 2 * z[789] * z[399]) - 4 * z[69] * z[11] * z[212]) - 4 * z[69] * z[12] * z[191]) - 2 * lrffo * z[191] * z[401]) - 2 * lrffo * z[212] * z[399])
    z[791] = z[700] * z[202] + mff * (z[251] * z[252] + z[269] * z[261]) + 0.5 * mrf * ((((2 * lsh * z[202] - 2 * z[69] * z[11] * z[202]) - 2 * z[69] * z[12] * z[194]) - lrffo * z[399] * z[202]) - lrffo * z[401] * z[194])
    z[792] = z[700] * z[203] + mff * (z[251] * z[253] + z[269] * z[262]) + 0.5 * mrf * ((((2 * lsh * z[203] - 2 * z[69] * z[11] * z[203]) - 2 * z[69] * z[12] * z[195]) - lrffo * z[399] * z[203]) - lrffo * z[401] * z[195])
    z[799] = (z[736] + z[738] + z[740] + z[620] * z[292] + mff * (z[248] * z[355] + z[258] * z[356]) + msh * (z[138] * z[311] + z[148] * z[312]) + msh * (z[193] * z[336] + z[201] * z[337]) + mth * (z[154] * z[319] + z[159] * z[320]) + mth * (z[174] * z[327] + z[179] * z[328]) + 0.25 * mrf * (((((((lrffo * z[298] + lrfo * z[297] + z[768] * z[297] + z[769] * z[298] + 4 * lff * z[295] + 2 * lff * z[396] * z[298] + 2 * lrffo * z[396] * z[295] + z[770] * z[300] + 2 * lff * z[18] * z[300]) - 2 * lff * z[17] * z[297]) - 2 * lrfo * z[17] * z[295]) - z[771] * z[301]) - 2 * lff * z[398] * z[301]) - 2 * lrffo * z[397] * z[296]) - 2 * lrfo * z[18] * z[296]) + mhat * (((((((((((((((((lff * z[366] + lff * z[17] * z[369] + lrf * z[13] * z[370] + lsh * z[9] * z[321] + lsh * z[13] * z[369] + lsh * z[21] * z[366] + lff * z[23] * z[375] + lff * z[391] * z[376] + lrf * z[395] * z[376] + lsh * z[10] * z[376] + lsh * z[14] * z[374]) - lrf * z[369]) - lsh * z[370]) - lff * z[21] * z[370]) - lff * z[392] * z[321]) - lrf * z[17] * z[366]) - lrf * z[393] * z[321]) - lff * z[18] * z[374]) - lff * z[114] * z[371]) - lff * z[116] * z[372]) - lrf * z[14] * z[375]) - lrf * z[18] * z[373]) - lrf * z[102] * z[371]) - lrf * z[104] * z[372]) - lsh * z[22] * z[373]) - lsh * z[24] * z[372]) - lsh * z[26] * z[371])) - 0.5 * mrf * ((((((z[193] * z[401] * z[342] + z[201] * z[399] * z[342] + 2 * z[11] * z[201] * z[341] + 2 * z[12] * z[193] * z[341] + 2 * z[12] * z[201] * z[344]) - 2 * z[193] * z[339]) - 2 * z[201] * z[340]) - 2 * z[11] * z[193] * z[344]) - z[193] * z[399] * z[345]) - z[201] * z[400] * z[345])
    z[824] = ((((((((((((((z[725] * z[34] + lff * (lrx2 * z[33] + lry2 * z[34]) + z[377] * (lff * z[34] + lrf * z[45] + lsh * z[30]) + 0.5 * z[379] * (lrffo * z[41] + lrfo * z[45] + 2 * lff * z[34]) + z[799]) - z[225] * rrx2 * z[56]) - z[225] * rry2 * z[57]) - z[235] * rrx2 * z[58]) - z[235] * rry2 * z[59]) - z[248] * rrx1 * z[64]) - z[248] * rry1 * z[65]) - z[258] * rrx1 * z[66]) - z[258] * rry1 * z[67]) - z[378] * (z[248] * z[65] + z[258] * z[67])) - z[379] * (z[193] * z[53] + z[201] * z[55])) - z[380] * (z[138] * z[28] + z[148] * z[30])) - z[380] * (z[193] * z[53] + z[201] * z[55])) - z[381] * (z[154] * z[47] + z[159] * z[46])) - z[381] * (z[174] * z[50] + z[179] * z[49])
    z[796] = z[794] + mff * (z[248] * z[249] + z[258] * z[267]) + msh * (z[138]^2 + z[148]^2) + msh * (z[191] * z[193] + z[201] * z[208]) + mth * (z[154]^2 + z[159] * z[164]) + mth * (z[173] * z[174] + z[179] * z[185]) + 0.25 * mrf * ((z[755] + 4 * z[756] * z[396]) - 4 * z[757] * z[17]) + 0.5 * mrf * (((((2 * z[191] * z[193] + 2 * z[201] * z[212]) - 2 * z[69] * z[11] * z[201]) - 2 * z[69] * z[12] * z[193]) - lrffo * z[193] * z[401]) - lrffo * z[201] * z[399]) + mhat * (((((((z[795] + z[762] * z[392] + z[763] * z[393] + 2 * z[761] * z[21]) - 2 * z[764] * z[17]) - 2 * z[765] * z[13]) - z[766] * z[9]) - lsh * hato * z[24]) - lff * hato * z[116]) - lrf * hato * z[104])
    z[797] = ((mff * (z[248] * z[252] + z[258] * z[261]) + mrf * (z[193] * z[194] + z[201] * z[202]) + msh * (z[138] * z[139] + z[148] * z[143]) + msh * (z[193] * z[194] + z[201] * z[202]) + mth * (z[154] * z[155] + z[159] * z[160]) + mth * (z[174] * z[175] + z[179] * z[181]) + 0.5 * mrf * ((((lrfo * z[17] * z[33] - 2 * lff * z[33]) - lrffo * z[396] * z[33]) - lrffo * z[397] * z[31]) - lrfo * z[18] * z[31])) - z[620] * z[33]) - mhat * (lff * z[33] + lrf * z[44] + lsh * z[29])
    z[798] = ((mff * (z[248] * z[253] + z[258] * z[262]) + mrf * (z[193] * z[195] + z[201] * z[203]) + msh * (z[138] * z[140] + z[148] * z[144]) + msh * (z[193] * z[195] + z[201] * z[203]) + mth * (z[154] * z[156] + z[159] * z[161]) + mth * (z[174] * z[176] + z[179] * z[182]) + 0.5 * mrf * ((((lrfo * z[17] * z[34] - 2 * lff * z[34]) - lrffo * z[396] * z[34]) - lrffo * z[397] * z[32]) - lrfo * z[18] * z[32])) - z[620] * z[34]) - mhat * (lff * z[34] + lrf * z[45] + lsh * z[30])
    z[805] = z[743] + z[744] + mff * (z[245] * z[355] + z[270] * z[356]) + 0.25 * mrf * ((((((((lrffo * z[342] + 4 * z[69] * z[341] + 2 * z[773] * z[345]) - 2 * z[768] * z[341]) - 2 * z[772] * z[342]) - 2 * z[770] * z[344]) - 4 * z[69] * z[11] * z[340]) - 4 * z[69] * z[12] * z[339]) - 2 * lrffo * z[399] * z[340]) - 2 * lrffo * z[401] * z[339])
    z[825] = ((((((0.5 * z[379] * (lrffo * z[63] - 2 * z[69] * z[59]) + z[805]) - z[245] * rrx1 * z[64]) - z[245] * rry1 * z[65]) - z[276] * rrx1 * z[66]) - z[276] * rry1 * z[67]) - lrf * (rrx2 * z[58] + rry2 * z[59])) - z[378] * (z[245] * z[65] + z[270] * z[67])
    z[802] = z[800] + mff * (z[245] * z[249] + z[267] * z[270]) + 0.25 * mrf * ((((z[801] - 4 * z[69] * z[11] * z[212]) - 4 * z[69] * z[12] * z[191]) - 2 * lrffo * z[191] * z[401]) - 2 * lrffo * z[212] * z[399])
    z[803] = mff * (z[245] * z[252] + z[270] * z[261]) - 0.5 * mrf * (lrffo * z[399] * z[202] + lrffo * z[401] * z[194] + 2 * z[69] * z[11] * z[202] + 2 * z[69] * z[12] * z[194])
    z[804] = mff * (z[245] * z[253] + z[270] * z[262]) - 0.5 * mrf * (lrffo * z[399] * z[203] + lrffo * z[401] * z[195] + 2 * z[69] * z[11] * z[203] + 2 * z[69] * z[12] * z[195])
    z[811] = (z[736] + z[738] + z[620] * z[292] + mff * (z[246] * z[355] + z[256] * z[356]) + msh * (z[138] * z[311] + z[142] * z[312]) + msh * (z[190] * z[336] + z[198] * z[337]) + mth * (z[153] * z[319] + z[158] * z[320]) + mth * (z[172] * z[327] + z[178] * z[328]) + 0.25 * mrf * (((((((lrffo * z[298] + lrfo * z[297] + z[768] * z[297] + z[769] * z[298] + 4 * lff * z[295] + 2 * lff * z[396] * z[298] + 2 * lrffo * z[396] * z[295] + z[770] * z[300] + 2 * lff * z[18] * z[300]) - 2 * lff * z[17] * z[297]) - 2 * lrfo * z[17] * z[295]) - z[771] * z[301]) - 2 * lff * z[398] * z[301]) - 2 * lrffo * z[397] * z[296]) - 2 * lrfo * z[18] * z[296]) + mhat * (((((((((((((lff * z[366] + lff * z[17] * z[369] + lrf * z[13] * z[370] + lff * z[23] * z[375] + lff * z[391] * z[376] + lrf * z[395] * z[376]) - lrf * z[369]) - lff * z[21] * z[370]) - lff * z[392] * z[321]) - lrf * z[17] * z[366]) - lrf * z[393] * z[321]) - lff * z[18] * z[374]) - lff * z[114] * z[371]) - lff * z[116] * z[372]) - lrf * z[14] * z[375]) - lrf * z[18] * z[373]) - lrf * z[102] * z[371]) - lrf * z[104] * z[372])) - 0.5 * mrf * ((((((z[190] * z[401] * z[342] + z[198] * z[399] * z[342] + 2 * z[11] * z[198] * z[341] + 2 * z[12] * z[190] * z[341] + 2 * z[12] * z[198] * z[344]) - 2 * z[190] * z[339]) - 2 * z[198] * z[340]) - 2 * z[11] * z[190] * z[344]) - z[190] * z[399] * z[345]) - z[198] * z[400] * z[345])
    z[826] = ((((((((((((((z[725] * z[34] + lff * (lrx2 * z[33] + lry2 * z[34]) + z[377] * (lff * z[34] + lrf * z[45]) + 0.5 * z[379] * (lrffo * z[41] + lrfo * z[45] + 2 * lff * z[34]) + z[811]) - z[223] * rrx2 * z[56]) - z[223] * rry2 * z[57]) - z[232] * rrx2 * z[58]) - z[232] * rry2 * z[59]) - z[246] * rrx1 * z[64]) - z[246] * rry1 * z[65]) - z[256] * rrx1 * z[66]) - z[256] * rry1 * z[67]) - z[378] * (z[246] * z[65] + z[256] * z[67])) - z[379] * (z[190] * z[53] + z[198] * z[55])) - z[380] * (z[138] * z[28] + z[142] * z[30])) - z[380] * (z[190] * z[53] + z[198] * z[55])) - z[381] * (z[153] * z[47] + z[158] * z[46])) - z[381] * (z[172] * z[50] + z[178] * z[49])
    z[808] = z[806] + mff * (z[246] * z[249] + z[256] * z[267]) + msh * (z[138]^2 + z[142] * z[148]) + msh * (z[190] * z[191] + z[198] * z[208]) + mth * (z[153] * z[154] + z[158] * z[164]) + mth * (z[172] * z[173] + z[178] * z[185]) + 0.25 * mrf * ((z[755] + 4 * z[756] * z[396]) - 4 * z[757] * z[17]) + 0.5 * mrf * (((((2 * z[190] * z[191] + 2 * z[198] * z[212]) - 2 * z[69] * z[11] * z[198]) - 2 * z[69] * z[12] * z[190]) - lrffo * z[190] * z[401]) - lrffo * z[198] * z[399]) + mhat * (((((z[807] + z[761] * z[21] + z[762] * z[392] + z[763] * z[393]) - 2 * z[764] * z[17]) - z[765] * z[13]) - lff * hato * z[116]) - lrf * hato * z[104])
    z[809] = ((mff * (z[246] * z[252] + z[256] * z[261]) + mrf * (z[190] * z[194] + z[198] * z[202]) + msh * (z[138] * z[139] + z[142] * z[143]) + msh * (z[190] * z[194] + z[198] * z[202]) + mth * (z[153] * z[155] + z[158] * z[160]) + mth * (z[172] * z[175] + z[178] * z[181]) + 0.5 * mrf * ((((lrfo * z[17] * z[33] - 2 * lff * z[33]) - lrffo * z[396] * z[33]) - lrffo * z[397] * z[31]) - lrfo * z[18] * z[31])) - z[620] * z[33]) - mhat * (lff * z[33] + lrf * z[44])
    z[810] = ((mff * (z[246] * z[253] + z[256] * z[262]) + mrf * (z[190] * z[195] + z[198] * z[203]) + msh * (z[138] * z[140] + z[142] * z[144]) + msh * (z[190] * z[195] + z[198] * z[203]) + mth * (z[153] * z[156] + z[158] * z[161]) + mth * (z[172] * z[176] + z[178] * z[182]) + 0.5 * mrf * ((((lrfo * z[17] * z[34] - 2 * lff * z[34]) - lrffo * z[396] * z[34]) - lrffo * z[397] * z[32]) - lrfo * z[18] * z[32])) - z[620] * z[34]) - mhat * (lff * z[34] + lrf * z[45])
    z[281] = (mhat * hatop) / z[72]
    z[282] = z[74] * (((lkp - lap) - lhp) - lmtpp)
    z[283] = z[75] * ((lap + lhp) - lkp)
    z[284] = z[76] * ((lap + lhp) - lkp)
    z[285] = z[77] * (lhp - lkp)
    z[286] = z[78] * lhp
    z[287] = z[79] * (((rkp - rap) - rhp) - rmtpp)
    z[288] = z[80] * ((rap + rhp) - rkp)
    z[289] = z[76] * ((rap + rhp) - rkp)
    z[290] = z[81] * (rhp - rkp)
    z[291] = z[82] * rhp

end


function pop2x(sol, t)
    @unpack z, lff = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q1 - lff * z[31]
end

pop2x(sol) = [pop2x(sol, t) for t in sol.t]

function pop2y(sol, t)
    @unpack z, lff = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q2 - lff * z[32]
end

pop2y(sol) = [pop2y(sol, t) for t in sol.t]


function pop10x(sol, t)
    @unpack z, lff, lrf, lsh, lth, = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q1 + lrf * z[56] + lsh * z[52] + lth * z[49] - lff * z[31] - lrf * z[42] - lsh * z[27] - lth * z[46]
end

pop10x(sol) = [pop10x(sol, t) for t in sol.t]

function pop10y(sol, t)
    @unpack z, lff, lrf, lsh, lth, = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q2 + lrf * z[57] + lsh * z[53] + lth * z[50] - lff * z[32] - lrf * z[43] - lsh * z[28] - lth * z[47]
end

pop10y(sol) = [pop10y(sol, t) for t in sol.t]

function pop11x(sol, t)
    @unpack z, lff, lrf, lsh, lth, = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q1 + lff * z[64] + lrf * z[56] + lsh * z[52] + lth * z[49] - lff * z[31] - lrf * z[42] - lsh * z[27] - lth * z[46]
end

pop11x(sol) = [pop11x(sol, t) for t in sol.t]

function pop11y(sol, t)
    @unpack z, lff, lrf, lsh, lth, = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q2 + lff * z[65] + lrf * z[57] + lsh * z[53] + lth * z[50] - lff * z[32] - lrf * z[43] - lsh * z[28] - lth * z[47]
end

pop11y(sol) = [pop11y(sol, t) for t in sol.t]