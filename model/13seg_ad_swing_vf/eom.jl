# Automatically generated
function eom(u, p, t)
    @unpack footang, g, iff, ihat, ila, irf, ish, ith, iua, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lhato, lla, llao, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, lua, luao, mff, mhat, mla, mrf, msh, mth, mtpb, mtpk, mtpxi, mua, toexi, u4, u5, u6, u7, u8, u9, u10, u11, u12, u13, z = p
    @inbounds q1, q2, q3, u1, u2, u3 = u

    # specified variables
    la = _la(t)
    lmtp = _lmtp(t)
    lh = _lh(t)
    lk = _lk(t)
    lkp = _lkp(t)
    lap = _lap(t)
    lhp = _lhp(t)
    lmtpp = _lmtpp(t)
    rh = _rh(t)
    rk = _rk(t)
    ra = _ra(t)
    rmtp = _rmtp(t)
    rs = _rs(t)
    ls = _ls(t)
    re = _re(t)
    le = _le(t)
    rhp = _rhp(t)
    rkpp = _rkpp(t)
    rhpp = _rhpp(t)
    lkpp = _lkpp(t)
    lhpp = _lhpp(t)
    rapp = _rapp(t)
    lapp = _lapp(t)
    rmtppp = _rmtppp(t)
    lmtppp = _lmtppp(t)
    rsp = _rsp(t)
    lsp = _lsp(t)
    repp = _repp(t)
    rspp = _rspp(t)
    lepp = _lepp(t)
    lspp = _lspp(t)
    rkp = _rkp(t)
    rap = _rap(t)
    rmtpp = _rmtpp(t)
    rep = _rep(t)
    lep = _lep(t)


    # calculated variables
    rx1, ry1, rx2, ry2, vrx1, vry1, vrx2, vry2 = contact_forces(u, p, t)

    # z variables
    z[1] = cos(q3)
    z[2] = sin(q3)
    z[504] = lhato * u3
    z[506] = lhat * u3
    z[13] = cos(la)
    z[17] = cos(lmtp)
    z[14] = sin(la)
    z[18] = sin(lmtp)
    z[29] = z[13] * z[17] - z[14] * z[18]
    z[5] = cos(lh)
    z[9] = cos(lk)
    z[6] = sin(lh)
    z[10] = sin(lk)
    z[32] = -(z[5]) * z[9] - z[6] * z[10]
    z[33] = z[6] * z[9] - z[5] * z[10]
    z[36] = z[32] * z[2] + z[33] * z[1]
    z[30] = -(z[13]) * z[18] - z[14] * z[17]
    z[34] = z[5] * z[10] - z[6] * z[9]
    z[38] = z[32] * z[1] + z[34] * z[2]
    z[40] = z[29] * z[36] + z[30] * z[38]
    z[35] = z[32] * z[1] - z[33] * z[2]
    z[37] = z[34] * z[1] - z[32] * z[2]
    z[39] = z[29] * z[35] + z[30] * z[37]
    z[31] = z[13] * z[18] + z[14] * z[17]
    z[42] = z[29] * z[38] + z[31] * z[36]
    z[155] = ((lkp - lap) - lhp) - lmtpp
    z[157] = lff * z[155]
    z[41] = z[29] * z[37] + z[31] * z[35]
    z[3] = cos(rh)
    z[4] = sin(rh)
    z[7] = cos(rk)
    z[8] = sin(rk)
    z[11] = cos(ra)
    z[12] = sin(ra)
    z[15] = cos(rmtp)
    z[16] = sin(rmtp)
    z[19] = cos(rs)
    z[20] = sin(rs)
    z[21] = cos(ls)
    z[22] = sin(ls)
    z[23] = cos(re)
    z[24] = sin(re)
    z[25] = cos(le)
    z[26] = sin(le)
    z[43] = -(z[27]) * z[13] - z[28] * z[14]
    z[45] = z[28] * z[13] - z[27] * z[14]
    z[49] = z[43] * z[38] + z[45] * z[36]
    z[53] = -(z[13]) * z[38] - z[14] * z[36]
    z[54] = z[5] * z[1] + z[6] * z[2]
    z[55] = z[5] * z[2] - z[6] * z[1]
    z[57] = z[3] * z[1] + z[4] * z[2]
    z[58] = z[3] * z[2] - z[4] * z[1]
    z[59] = z[4] * z[1] - z[3] * z[2]
    z[60] = -(z[7]) * z[57] - z[8] * z[59]
    z[61] = -(z[7]) * z[58] - z[8] * z[57]
    z[62] = z[8] * z[57] - z[7] * z[59]
    z[63] = z[8] * z[58] - z[7] * z[57]
    z[64] = z[12] * z[62] - z[11] * z[60]
    z[65] = z[12] * z[63] - z[11] * z[61]
    z[66] = -(z[11]) * z[62] - z[12] * z[60]
    z[67] = -(z[11]) * z[63] - z[12] * z[61]
    z[71] = z[27] * z[67] - z[28] * z[65]
    z[72] = z[16] * z[66] - z[15] * z[64]
    z[73] = z[16] * z[67] - z[15] * z[65]
    z[74] = -(z[15]) * z[66] - z[16] * z[64]
    z[75] = -(z[15]) * z[67] - z[16] * z[65]
    z[76] = -(z[19]) * z[1] - z[20] * z[2]
    z[77] = z[20] * z[1] - z[19] * z[2]
    z[80] = -(z[23]) * z[77] - z[24] * z[76]
    z[82] = z[24] * z[77] - z[23] * z[76]
    z[83] = -(z[21]) * z[1] - z[22] * z[2]
    z[84] = z[22] * z[1] - z[21] * z[2]
    z[87] = -(z[25]) * z[84] - z[26] * z[83]
    z[89] = z[26] * z[84] - z[25] * z[83]
    z[107] = u4 - rhp
    z[108] = u5 - lhp
    z[110] = rkpp - rhpp
    z[116] = lkpp - lhpp
    z[118] = (rkpp - rapp) - rhpp
    z[124] = (lkpp - lapp) - lhpp
    z[130] = ((rkpp - rapp) - rhpp) - rmtppp
    z[136] = ((lkpp - lapp) - lhpp) - lmtppp
    z[141] = u10 - rsp
    z[142] = u11 - lsp
    z[144] = repp - rspp
    z[150] = lepp - lspp
    z[156] = lffo * z[155]
    z[158] = (lkp - lap) - lhp
    z[163] = lrfo * z[158]
    z[164] = lrffo * z[158]
    z[165] = lff * z[18]
    z[166] = -(z[17]) * z[39] - z[18] * z[41]
    z[167] = -(z[17]) * z[40] - z[18] * z[42]
    z[169] = z[18] * z[39] - z[17] * z[41]
    z[170] = z[18] * z[40] - z[17] * z[42]
    z[171] = lff * z[17]
    z[173] = lrf * z[158]
    z[174] = z[171] - lrf
    z[176] = -(z[13]) * z[165] - z[14] * z[174]
    z[177] = -(z[13]) * z[166] - z[14] * z[169]
    z[178] = -(z[13]) * z[167] - z[14] * z[170]
    z[180] = z[14] * z[165] - z[13] * z[174]
    z[181] = z[14] * z[166] - z[13] * z[169]
    z[182] = z[14] * z[167] - z[13] * z[170]
    z[184] = lkp - lhp
    z[185] = lsho * z[184]
    z[186] = z[180] - lsho
    z[188] = lsh * z[184]
    z[189] = z[180] - lsh
    z[192] = z[10] * z[189] - z[9] * z[176]
    z[193] = z[10] * z[181] - z[9] * z[177]
    z[194] = z[10] * z[182] - z[9] * z[178]
    z[197] = -(z[9]) * z[189] - z[10] * z[176]
    z[198] = -(z[9]) * z[181] - z[10] * z[177]
    z[199] = -(z[9]) * z[182] - z[10] * z[178]
    z[201] = ltho * lhp
    z[202] = z[197] - ltho
    z[204] = lth * lhp
    z[205] = z[197] - lth
    z[207] = z[3] * z[5] + z[4] * z[6]
    z[208] = z[4] * z[5] - z[3] * z[6]
    z[209] = z[3] * z[6] - z[4] * z[5]
    z[211] = z[192] * z[207] + z[205] * z[209]
    z[213] = z[207] * z[193] + z[209] * z[198]
    z[214] = z[207] * z[194] + z[209] * z[199]
    z[218] = z[192] * z[208] + z[205] * z[207]
    z[219] = z[207] * z[198] + z[208] * z[193]
    z[220] = z[207] * z[199] + z[208] * z[194]
    z[222] = z[93] * rhp
    z[223] = z[93] + z[218]
    z[225] = lth * rhp
    z[226] = lth + z[218]
    z[229] = -(z[7]) * z[211] - z[8] * z[226]
    z[232] = -(z[7]) * z[213] - z[8] * z[219]
    z[233] = -(z[7]) * z[214] - z[8] * z[220]
    z[237] = z[8] * z[211] - z[7] * z[226]
    z[240] = z[8] * z[213] - z[7] * z[219]
    z[241] = z[8] * z[214] - z[7] * z[220]
    z[244] = rkp - rhp
    z[245] = z[92] * z[244]
    z[246] = z[92] + z[237]
    z[249] = lsh * z[244]
    z[250] = lsh + z[237]
    z[253] = (rkp - rap) - rhp
    z[258] = z[91] * z[253]
    z[259] = lrffo * z[253]
    z[264] = z[12] * z[250] - z[11] * z[229]
    z[266] = z[12] * z[240] - z[11] * z[232]
    z[267] = z[12] * z[241] - z[11] * z[233]
    z[271] = -(z[11]) * z[250] - z[12] * z[229]
    z[274] = -(z[11]) * z[240] - z[12] * z[232]
    z[275] = -(z[11]) * z[241] - z[12] * z[233]
    z[278] = lrf * z[253]
    z[279] = lrf + z[271]
    z[287] = z[16] * z[279] - z[15] * z[264]
    z[290] = z[16] * z[274] - z[15] * z[266]
    z[291] = z[16] * z[275] - z[15] * z[267]
    z[297] = -(z[15]) * z[279] - z[16] * z[264]
    z[299] = -(z[15]) * z[274] - z[16] * z[266]
    z[300] = -(z[15]) * z[275] - z[16] * z[267]
    z[303] = ((rkp - rap) - rhp) - rmtpp
    z[304] = z[90] * z[303]
    z[305] = z[90] + z[297]
    z[311] = lff + z[297]
    z[317] = z[5] * z[192] + z[6] * z[205]
    z[319] = z[5] * z[193] + z[6] * z[198]
    z[320] = z[5] * z[194] + z[6] * z[199]
    z[324] = z[5] * z[205] - z[6] * z[192]
    z[325] = z[5] * z[198] - z[6] * z[193]
    z[326] = z[5] * z[199] - z[6] * z[194]
    z[328] = lhato + z[324]
    z[329] = lhat + z[324]
    z[333] = z[20] * z[329] - z[19] * z[317]
    z[334] = z[20] * z[325] - z[19] * z[319]
    z[335] = z[20] * z[326] - z[19] * z[320]
    z[340] = -(z[19]) * z[329] - z[20] * z[317]
    z[341] = -(z[19]) * z[325] - z[20] * z[319]
    z[342] = -(z[19]) * z[326] - z[20] * z[320]
    z[344] = luao * rsp
    z[345] = luao + z[340]
    z[347] = lua * rsp
    z[348] = lua + z[340]
    z[353] = -(z[23]) * z[333] - z[24] * z[348]
    z[354] = -(z[23]) * z[334] - z[24] * z[341]
    z[355] = -(z[23]) * z[335] - z[24] * z[342]
    z[361] = z[24] * z[333] - z[23] * z[348]
    z[362] = z[24] * z[334] - z[23] * z[341]
    z[363] = z[24] * z[335] - z[23] * z[342]
    z[366] = rep - rsp
    z[367] = llao * z[366]
    z[369] = llao + z[361]
    z[378] = z[22] * z[329] - z[21] * z[317]
    z[379] = z[22] * z[325] - z[21] * z[319]
    z[380] = z[22] * z[326] - z[21] * z[320]
    z[385] = -(z[21]) * z[329] - z[22] * z[317]
    z[386] = -(z[21]) * z[325] - z[22] * z[319]
    z[387] = -(z[21]) * z[326] - z[22] * z[320]
    z[389] = luao * lsp
    z[390] = luao + z[385]
    z[392] = lua * lsp
    z[393] = lua + z[385]
    z[398] = -(z[25]) * z[378] - z[26] * z[393]
    z[399] = -(z[25]) * z[379] - z[26] * z[386]
    z[400] = -(z[25]) * z[380] - z[26] * z[387]
    z[406] = z[26] * z[378] - z[25] * z[393]
    z[407] = z[26] * z[379] - z[25] * z[386]
    z[408] = z[26] * z[380] - z[25] * z[387]
    z[411] = lep - lsp
    z[412] = llao * z[411]
    z[414] = llao + z[406]
    z[434] = lffo * z[136]
    z[435] = z[155] + u5 + u7 + u9
    z[436] = (z[156] + lffo * u3 + lffo * u5 + lffo * u7 + lffo * u9) * (u3 + z[435])
    z[437] = lff * z[136]
    z[438] = (z[157] + lff * u3 + lff * u5 + lff * u7 + lff * u9) * (u3 + z[435])
    z[439] = lrfo * z[124]
    z[440] = lrffo * z[124]
    z[441] = z[158] + u5 + u7 + u9
    z[442] = (z[163] + lrfo * u3 + lrfo * u5 + lrfo * u7 + lrfo * u9) * (u3 + z[441])
    z[443] = (z[164] + lrffo * u3 + lrffo * u5 + lrffo * u7 + lrffo * u9) * (u3 + z[441])
    z[444] = z[18] * z[437] - z[17] * z[438]
    z[445] = z[17] * z[437] + z[18] * z[438]
    z[446] = lrf * z[124]
    z[447] = z[444] + (z[173] + lrf * u3 + lrf * u5 + lrf * u7 + lrf * u9) * (u3 + z[441])
    z[448] = z[445] - z[446]
    z[449] = -(z[13]) * z[447] - z[14] * z[448]
    z[450] = z[14] * z[447] - z[13] * z[448]
    z[451] = lsho * z[116]
    z[452] = z[184] + u5 + u7
    z[453] = z[449] + (z[185] + lsho * u3 + lsho * u5 + lsho * u7) * (u3 + z[452])
    z[454] = z[450] - z[451]
    z[455] = lsh * z[116]
    z[456] = z[449] + (z[188] + lsh * u3 + lsh * u5 + lsh * u7) * (u3 + z[452])
    z[457] = z[450] - z[455]
    z[458] = z[10] * z[457] - z[9] * z[456]
    z[459] = -(z[9]) * z[457] - z[10] * z[456]
    z[460] = ltho * lhpp
    z[461] = z[458] - ((z[201] - ltho * u3) - ltho * u5) * (u3 + z[108])
    z[462] = z[460] + z[459]
    z[463] = lth * lhpp
    z[464] = z[458] - ((z[204] - lth * u3) - lth * u5) * (u3 + z[108])
    z[465] = z[463] + z[459]
    z[466] = z[207] * z[464] + z[209] * z[465]
    z[467] = z[207] * z[465] + z[208] * z[464]
    z[468] = z[93] * rhpp
    z[469] = z[466] + ((z[222] - z[93] * u3) - z[93] * u4) * (u3 + z[107])
    z[470] = z[467] - z[468]
    z[471] = lth * rhpp
    z[472] = z[466] + ((z[225] - lth * u3) - lth * u4) * (u3 + z[107])
    z[473] = z[467] - z[471]
    z[474] = -(z[7]) * z[472] - z[8] * z[473]
    z[475] = z[8] * z[472] - z[7] * z[473]
    z[476] = z[92] * z[110]
    z[477] = z[244] + u4 + u6
    z[478] = z[474] - (z[245] + z[92] * u3 + z[92] * u4 + z[92] * u6) * (u3 + z[477])
    z[479] = z[476] + z[475]
    z[480] = lsh * z[110]
    z[481] = z[474] - (z[249] + lsh * u3 + lsh * u4 + lsh * u6) * (u3 + z[477])
    z[482] = z[480] + z[475]
    z[483] = z[91] * z[118]
    z[484] = lrffo * z[118]
    z[485] = z[253] + u4 + u6 + u8
    z[486] = (z[258] + z[91] * u3 + z[91] * u4 + z[91] * u6 + z[91] * u8) * (u3 + z[485])
    z[487] = (z[259] + lrffo * u3 + lrffo * u4 + lrffo * u6 + lrffo * u8) * (u3 + z[485])
    z[488] = z[12] * z[482] - z[11] * z[481]
    z[489] = -(z[11]) * z[482] - z[12] * z[481]
    z[490] = lrf * z[118]
    z[491] = z[488] - (z[278] + lrf * u3 + lrf * u4 + lrf * u6 + lrf * u8) * (u3 + z[485])
    z[492] = z[490] + z[489]
    z[493] = z[16] * z[492] - z[15] * z[491]
    z[494] = -(z[15]) * z[492] - z[16] * z[491]
    z[495] = z[90] * z[130]
    z[496] = z[303] + u4 + u6 + u8
    z[497] = z[493] - (z[304] + z[90] * u3 + z[90] * u4 + z[90] * u6 + z[90] * u8) * (u3 + z[496])
    z[498] = z[495] + z[494]
    z[502] = z[5] * z[464] + z[6] * z[465]
    z[503] = z[5] * z[465] - z[6] * z[464]
    z[505] = z[502] - u3 * z[504]
    z[507] = z[502] - u3 * z[506]
    z[508] = z[20] * z[503] - z[19] * z[507]
    z[509] = -(z[19]) * z[503] - z[20] * z[507]
    z[510] = luao * rspp
    z[511] = z[508] + ((z[344] - luao * u10) - luao * u3) * (u3 + z[141])
    z[512] = z[509] - z[510]
    z[513] = lua * rspp
    z[514] = z[508] + ((z[347] - lua * u10) - lua * u3) * (u3 + z[141])
    z[515] = z[509] - z[513]
    z[516] = -(z[23]) * z[514] - z[24] * z[515]
    z[517] = z[24] * z[514] - z[23] * z[515]
    z[518] = llao * z[144]
    z[519] = z[366] + u10 + u12
    z[520] = z[516] - (z[367] + llao * u10 + llao * u12 + llao * u3) * (u3 + z[519])
    z[521] = z[518] + z[517]
    z[525] = z[22] * z[503] - z[21] * z[507]
    z[526] = -(z[21]) * z[503] - z[22] * z[507]
    z[527] = luao * lspp
    z[528] = z[525] + ((z[389] - luao * u11) - luao * u3) * (u3 + z[142])
    z[529] = z[526] - z[527]
    z[530] = lua * lspp
    z[531] = z[525] + ((z[392] - lua * u11) - lua * u3) * (u3 + z[142])
    z[532] = z[526] - z[530]
    z[533] = -(z[25]) * z[531] - z[26] * z[532]
    z[534] = z[26] * z[531] - z[25] * z[532]
    z[535] = llao * z[150]
    z[536] = z[411] + u11 + u13
    z[537] = z[533] - (z[412] + llao * u11 + llao * u13 + llao * u3) * (u3 + z[536])
    z[538] = z[535] + z[534]
    z[560] = z[28] * z[18] - z[27] * z[17]
    z[561] = z[27] * z[18] + z[28] * z[17]
    z[562] = -(z[27]) * z[18] - z[28] * z[17]
    z[563] = -(z[27]) * z[11] - z[28] * z[12]
    z[564] = z[27] * z[12] - z[28] * z[11]
    z[565] = z[28] * z[11] - z[27] * z[12]
    z[1157] = rx1 + rx2 * z[39]^2 + rx2 * z[41]^2 + ry2 * z[39] * z[40] + ry2 * z[41] * z[42] + vrx1 * z[72] * z[290] + vrx1 * z[74] * z[299] + vrx2 * z[64] * z[266] + vrx2 * z[66] * z[274] + vry1 * z[73] * z[290] + vry1 * z[75] * z[299] + vry2 * z[65] * z[266] + vry2 * z[67] * z[274] + z[542] * (z[1] * z[325] + z[2] * z[319]) + z[543] * (z[39] * z[40] + z[41] * z[42]) + z[543] * (z[73] * z[290] + z[75] * z[299]) + z[544] * (z[80] * z[354] + z[82] * z[362]) + z[544] * (z[87] * z[399] + z[89] * z[407]) + z[545] * (z[39] * z[40] + z[41] * z[42]) + z[545] * (z[61] * z[232] + z[63] * z[240]) + z[546] * (z[36] * z[177] + z[38] * z[181]) + z[546] * (z[61] * z[232] + z[63] * z[240]) + z[547] * (z[54] * z[198] + z[55] * z[193]) + z[547] * (z[57] * z[219] + z[58] * z[213]) + z[548] * (z[76] * z[341] + z[77] * z[334]) + z[548] * (z[83] * z[386] + z[84] * z[379])
    z[1158] = ry1 + rx2 * z[39] * z[40] + rx2 * z[41] * z[42] + ry2 * z[40]^2 + ry2 * z[42]^2 + vrx1 * z[72] * z[291] + vrx1 * z[74] * z[300] + vrx2 * z[64] * z[267] + vrx2 * z[66] * z[275] + vry1 * z[73] * z[291] + vry1 * z[75] * z[300] + vry2 * z[65] * z[267] + vry2 * z[67] * z[275] + z[542] * (z[1] * z[326] + z[2] * z[320]) + z[543] * (z[40]^2 + z[42]^2) + z[543] * (z[73] * z[291] + z[75] * z[300]) + z[544] * (z[80] * z[355] + z[82] * z[363]) + z[544] * (z[87] * z[400] + z[89] * z[408]) + z[545] * (z[40]^2 + z[42]^2) + z[545] * (z[61] * z[233] + z[63] * z[241]) + z[546] * (z[36] * z[178] + z[38] * z[182]) + z[546] * (z[61] * z[233] + z[63] * z[241]) + z[547] * (z[54] * z[199] + z[55] * z[194]) + z[547] * (z[57] * z[220] + z[58] * z[214]) + z[548] * (z[76] * z[342] + z[77] * z[335]) + z[548] * (z[83] * z[387] + z[84] * z[380])
    z[1176] = iff * z[136]
    z[1178] = ila * z[150]
    z[1180] = irf * z[124]
    z[1182] = ish * z[116]
    z[1184] = ith * lhpp
    z[1186] = iua * lspp
    z[1187] = iff * z[130]
    z[1188] = ila * z[144]
    z[1189] = irf * z[118]
    z[1190] = ish * z[110]
    z[1191] = ith * rhpp
    z[1192] = iua * rspp
    z[1193] = (mff * (z[287] * z[290] + z[305] * z[299]) + mhat * (z[317] * z[319] + z[328] * z[325]) + mla * (z[353] * z[354] + z[369] * z[362]) + mla * (z[398] * z[399] + z[414] * z[407]) + msh * (z[176] * z[177] + z[186] * z[181]) + msh * (z[229] * z[232] + z[246] * z[240]) + mth * (z[192] * z[193] + z[202] * z[198]) + mth * (z[211] * z[213] + z[223] * z[219]) + mua * (z[333] * z[334] + z[345] * z[341]) + mua * (z[378] * z[379] + z[390] * z[386]) + 0.5 * mrf * ((((lrfo * z[17] * z[41] - 2 * lff * z[41]) - lrffo * z[560] * z[41]) - lrffo * z[561] * z[39]) - lrfo * z[18] * z[39]) + 0.5 * mrf * (((((2 * z[229] * z[232] + 2 * z[250] * z[240]) - 2 * z[91] * z[11] * z[240]) - 2 * z[91] * z[12] * z[232]) - lrffo * z[563] * z[240]) - lrffo * z[565] * z[232])) - z[992] * z[41]
    z[1194] = mff * (z[39]^2 + z[41]^2) + mff * (z[290]^2 + z[299]^2) + mhat * (z[319]^2 + z[325]^2) + mla * (z[354]^2 + z[362]^2) + mla * (z[399]^2 + z[407]^2) + mrf * (z[39]^2 + z[41]^2) + mrf * (z[232]^2 + z[240]^2) + msh * (z[177]^2 + z[181]^2) + msh * (z[232]^2 + z[240]^2) + mth * (z[193]^2 + z[198]^2) + mth * (z[213]^2 + z[219]^2) + mua * (z[334]^2 + z[341]^2) + mua * (z[379]^2 + z[386]^2)
    z[1195] = mff * (z[39] * z[40] + z[41] * z[42]) + mff * (z[290] * z[291] + z[299] * z[300]) + mhat * (z[319] * z[320] + z[325] * z[326]) + mla * (z[354] * z[355] + z[362] * z[363]) + mla * (z[399] * z[400] + z[407] * z[408]) + mrf * (z[39] * z[40] + z[41] * z[42]) + mrf * (z[232] * z[233] + z[240] * z[241]) + msh * (z[177] * z[178] + z[181] * z[182]) + msh * (z[232] * z[233] + z[240] * z[241]) + mth * (z[193] * z[194] + z[198] * z[199]) + mth * (z[213] * z[214] + z[219] * z[220]) + mua * (z[334] * z[335] + z[341] * z[342]) + mua * (z[379] * z[380] + z[386] * z[387])
    z[1196] = (((mff * (z[290] * z[497] + z[299] * z[498]) + mhat * (z[319] * z[505] + z[325] * z[503]) + mla * (z[354] * z[520] + z[362] * z[521]) + mla * (z[399] * z[537] + z[407] * z[538]) + msh * (z[177] * z[453] + z[181] * z[454]) + msh * (z[232] * z[478] + z[240] * z[479]) + mth * (z[193] * z[461] + z[198] * z[462]) + mth * (z[213] * z[469] + z[219] * z[470]) + mua * (z[334] * z[511] + z[341] * z[512]) + mua * (z[379] * z[528] + z[386] * z[529])) - mff * (z[434] * z[41] - z[39] * z[436])) - 0.5 * mrf * (((((2 * z[437] * z[41] + z[18] * z[439] * z[39] + z[560] * z[440] * z[41] + z[561] * z[440] * z[39] + z[17] * z[39] * z[442] + z[18] * z[41] * z[442]) - z[17] * z[439] * z[41]) - 2 * z[39] * z[438]) - z[560] * z[39] * z[443]) - z[562] * z[41] * z[443])) - 0.5 * mrf * ((((((z[563] * z[484] * z[240] + z[565] * z[484] * z[232] + 2 * z[11] * z[483] * z[240] + 2 * z[12] * z[483] * z[232] + 2 * z[12] * z[240] * z[486]) - 2 * z[232] * z[481]) - 2 * z[240] * z[482]) - 2 * z[11] * z[232] * z[486]) - z[563] * z[232] * z[487]) - z[564] * z[240] * z[487])
    z[1197] = (mff * (z[287] * z[291] + z[305] * z[300]) + mhat * (z[317] * z[320] + z[328] * z[326]) + mla * (z[353] * z[355] + z[369] * z[363]) + mla * (z[398] * z[400] + z[414] * z[408]) + msh * (z[176] * z[178] + z[186] * z[182]) + msh * (z[229] * z[233] + z[246] * z[241]) + mth * (z[192] * z[194] + z[202] * z[199]) + mth * (z[211] * z[214] + z[223] * z[220]) + mua * (z[333] * z[335] + z[345] * z[342]) + mua * (z[378] * z[380] + z[390] * z[387]) + 0.5 * mrf * ((((lrfo * z[17] * z[42] - 2 * lff * z[42]) - lrffo * z[560] * z[42]) - lrffo * z[561] * z[40]) - lrfo * z[18] * z[40]) + 0.5 * mrf * (((((2 * z[229] * z[233] + 2 * z[250] * z[241]) - 2 * z[91] * z[11] * z[241]) - 2 * z[91] * z[12] * z[233]) - lrffo * z[563] * z[241]) - lrffo * z[565] * z[233])) - z[992] * z[42]
    z[1198] = mff * (z[40]^2 + z[42]^2) + mff * (z[291]^2 + z[300]^2) + mhat * (z[320]^2 + z[326]^2) + mla * (z[355]^2 + z[363]^2) + mla * (z[400]^2 + z[408]^2) + mrf * (z[40]^2 + z[42]^2) + mrf * (z[233]^2 + z[241]^2) + msh * (z[178]^2 + z[182]^2) + msh * (z[233]^2 + z[241]^2) + mth * (z[194]^2 + z[199]^2) + mth * (z[214]^2 + z[220]^2) + mua * (z[335]^2 + z[342]^2) + mua * (z[380]^2 + z[387]^2)
    z[1199] = (((mff * (z[291] * z[497] + z[300] * z[498]) + mhat * (z[320] * z[505] + z[326] * z[503]) + mla * (z[355] * z[520] + z[363] * z[521]) + mla * (z[400] * z[537] + z[408] * z[538]) + msh * (z[178] * z[453] + z[182] * z[454]) + msh * (z[233] * z[478] + z[241] * z[479]) + mth * (z[194] * z[461] + z[199] * z[462]) + mth * (z[214] * z[469] + z[220] * z[470]) + mua * (z[335] * z[511] + z[342] * z[512]) + mua * (z[380] * z[528] + z[387] * z[529])) - mff * (z[434] * z[42] - z[40] * z[436])) - 0.5 * mrf * (((((2 * z[437] * z[42] + z[18] * z[439] * z[40] + z[560] * z[440] * z[42] + z[561] * z[440] * z[40] + z[17] * z[40] * z[442] + z[18] * z[42] * z[442]) - z[17] * z[439] * z[42]) - 2 * z[40] * z[438]) - z[560] * z[40] * z[443]) - z[562] * z[42] * z[443])) - 0.5 * mrf * ((((((z[563] * z[484] * z[241] + z[565] * z[484] * z[233] + 2 * z[11] * z[483] * z[241] + 2 * z[12] * z[483] * z[233] + 2 * z[12] * z[241] * z[486]) - 2 * z[233] * z[481]) - 2 * z[241] * z[482]) - 2 * z[11] * z[233] * z[486]) - z[563] * z[233] * z[487]) - z[564] * z[241] * z[487])
    z[1206] = z[1200] + mff * (z[287]^2 + z[305]^2) + mhat * (z[317]^2 + z[328]^2) + mla * (z[353]^2 + z[369]^2) + mla * (z[398]^2 + z[414]^2) + msh * (z[176]^2 + z[186]^2) + msh * (z[229]^2 + z[246]^2) + mth * (z[192]^2 + z[202]^2) + mth * (z[211]^2 + z[223]^2) + mua * (z[333]^2 + z[345]^2) + mua * (z[378]^2 + z[390]^2) + 0.25 * mrf * ((z[1201] + 4 * z[1202] * z[560]) - 4 * z[1203] * z[17]) + 0.25 * mrf * ((((((z[1204] + 4 * z[229]^2 + 4 * z[250]^2) - 4 * z[1205]) - 8 * z[91] * z[11] * z[250]) - 8 * z[91] * z[12] * z[229]) - 4 * lrffo * z[229] * z[565]) - 4 * lrffo * z[250] * z[563])
    z[1213] = (((((z[1176] + z[1178] + z[1180] + z[1182] + z[1187] + z[1188] + z[1189] + z[1190] + z[992] * z[434] + mff * (z[287] * z[497] + z[305] * z[498]) + mhat * (z[317] * z[505] + z[328] * z[503]) + mla * (z[353] * z[520] + z[369] * z[521]) + mla * (z[398] * z[537] + z[414] * z[538]) + msh * (z[176] * z[453] + z[186] * z[454]) + msh * (z[229] * z[478] + z[246] * z[479]) + mth * (z[192] * z[461] + z[202] * z[462]) + mth * (z[211] * z[469] + z[223] * z[470]) + mua * (z[333] * z[511] + z[345] * z[512]) + mua * (z[378] * z[528] + z[390] * z[529]) + 0.25 * mrf * (((((((lrffo * z[440] + lrfo * z[439] + z[1207] * z[439] + z[1208] * z[440] + 4 * lff * z[437] + 2 * lff * z[560] * z[440] + 2 * lrffo * z[560] * z[437] + z[1209] * z[442] + 2 * lff * z[18] * z[442]) - 2 * lff * z[17] * z[439]) - 2 * lrfo * z[17] * z[437]) - z[1210] * z[443]) - 2 * lff * z[562] * z[443]) - 2 * lrffo * z[561] * z[438]) - 2 * lrfo * z[18] * z[438])) - z[1184]) - z[1186]) - z[1191]) - z[1192]) - 0.25 * mrf * (((((((((2 * z[1207] * z[483] + 2 * z[1211] * z[484] + 2 * z[229] * z[565] * z[484] + 2 * z[250] * z[563] * z[484] + 4 * z[11] * z[250] * z[483] + 4 * z[12] * z[229] * z[483] + 2 * z[1209] * z[486] + 2 * lrffo * z[563] * z[482] + 2 * lrffo * z[565] * z[481] + 4 * z[91] * z[11] * z[482] + 4 * z[91] * z[12] * z[481] + 4 * z[12] * z[250] * z[486]) - 4 * z[91] * z[483]) - lrffo * z[484]) - 4 * z[229] * z[481]) - 4 * z[250] * z[482]) - 2 * z[1212] * z[487]) - 4 * z[11] * z[229] * z[486]) - 2 * z[229] * z[563] * z[487]) - 2 * z[250] * z[564] * z[487])
    z[1266] = z[1157] - z[1196]
    z[1267] = z[1158] - z[1199]
    z[1287] = (((((z[264] * vrx2 * z[64] + z[264] * vry2 * z[65] + z[279] * vrx2 * z[66] + z[279] * vry2 * z[67] + z[287] * vrx1 * z[72] + z[287] * vry1 * z[73] + z[311] * vrx1 * z[74] + z[311] * vry1 * z[75] + z[542] * (z[317] * z[2] + z[328] * z[1]) + z[543] * (z[287] * z[73] + z[305] * z[75]) + z[544] * (z[353] * z[80] + z[369] * z[82]) + z[544] * (z[398] * z[87] + z[414] * z[89]) + z[546] * (z[176] * z[36] + z[186] * z[38]) + z[546] * (z[229] * z[61] + z[246] * z[63]) + z[547] * (z[192] * z[55] + z[202] * z[54]) + z[547] * (z[211] * z[58] + z[223] * z[57]) + z[548] * (z[333] * z[77] + z[345] * z[76]) + z[548] * (z[378] * z[84] + z[390] * z[83])) - z[1159] * z[42]) - lff * (rx2 * z[41] + ry2 * z[42])) - 0.5 * z[545] * (lrffo * z[49] + lrfo * z[53] + 2 * lff * z[42])) - 0.5 * z[545] * (((lrffo * z[71] - 2 * z[91] * z[67]) - 2 * z[229] * z[61]) - 2 * z[250] * z[63])) - z[1213]

    # coef
    coef11 = -(z[1194])
    coef12 = -(z[1195])
    coef13 = -(z[1193])
    coef21 = -(z[1195])
    coef22 = -(z[1198])
    coef23 = -(z[1197])
    coef31 = -(z[1193])
    coef32 = -(z[1197])
    coef33 = -(z[1206])

    # rhs
    rhs1 = -(z[1266])
    rhs2 = -(z[1267])
    rhs3 = -(z[1287])

    # set up system of equations
    coef = @SMatrix [coef11 coef12 coef13; coef21 coef22 coef23; coef31 coef32 coef33]
    rhs = @SVector [rhs1, rhs2, rhs3]

    # derivatives
    q1p = u1
    q2p = u2
    q3p = u3
    @inbounds u1p, u2p, u3p = coef \ rhs

    return @SVector [q1p, q2p, q3p, u1p, u2p, u3p]
end
