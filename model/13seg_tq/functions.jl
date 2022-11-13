# Automatically generated
function kecm(sol, t)
    @unpack z, ihat, ith, ish, iua, u13, u12, irf, iff, ila, u15, u14, mff, lffo, mhat, msh, mth, mua, luao, mla, llao, mrf, lrffo, lrfo, lff, lsh = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)
    lsp, rsp, lep, rep = _lsp(t), _rsp(t), _lep(t), _rep(t)

    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return (0.5 * ihat * u3^2 + 0.5 * ith * (u3 - u4)^2 + 0.5 * ith * (u3 - u8)^2 + 0.5 * ish * ((u4 - u3) - u5)^2 + 0.5 * ish * ((u8 - u3) - u9)^2 + 0.5 * iua * ((lsp - u13) - u3)^2 + 0.5 * iua * ((rsp - u12) - u3)^2 + 0.5 * irf * (((u10 + u8) - u3) - u9)^2 + 0.5 * irf * (((u3 + u5) - u4) - u6)^2 + 0.5 * iff * (((u10 + u11 + u8) - u3) - u9)^2 + 0.5 * iff * ((((u3 + u5) - u4) - u6) - u7)^2 + 0.5 * ila * ((((lsp - lep) - u13) - u15) - u3)^2 + 0.5 * ila * ((((rsp - rep) - u12) - u14) - u3)^2 + 0.5 * mff * ((z[39] * u1 + z[40] * u2)^2 + ((((((lffo * u3 + lffo * u5) - lffo * u4) - lffo * u6) - lffo * u7) - z[41] * u1) - z[42] * u2)^2) + 0.5 * mhat * ((z[281] * u7 + z[282] * u1 + z[283] * u2 + z[284] * u6 + z[285] * u3 + z[286] * u5 + z[287] * u4)^2 + (z[288] * u7 + z[289] * u1 + z[290] * u2 + z[291] * u6 + z[292] * u5 + z[294] * u4 + z[295] * u3)^2) + 0.5 * msh * ((z[159] * u4 + z[159] * u6 + z[160] * u7 + z[161] * u3 + z[161] * u5 + z[162] * u1 + z[163] * u2)^2 + (z[164] * u7 + z[165] * u1 + z[166] * u2 + z[168] * u6 + z[169] * u3 + z[169] * u5 + z[170] * u4)^2) + 0.5 * mth * ((z[173] * u7 + z[174] * u1 + z[175] * u2 + z[176] * u6 + z[177] * u3 + z[177] * u5 + z[178] * u4)^2 + (z[179] * u7 + z[180] * u1 + z[181] * u2 + z[182] * u6 + z[183] * u5 + z[185] * u3 + z[186] * u4)^2) + 0.5 * msh * ((z[208] * u8 + z[209] * u7 + z[210] * u1 + z[211] * u2 + z[212] * u6 + z[213] * u5 + z[214] * u4 + z[215] * u3)^2 + (z[92] * u9 + z[216] * u7 + z[217] * u1 + z[218] * u2 + z[219] * u6 + z[221] * u5 + z[222] * u4 + z[224] * u3 + z[225] * u8)^2) + 0.5 * mth * ((z[192] * u7 + z[193] * u1 + z[194] * u2 + z[195] * u6 + z[196] * u3 + z[197] * u5 + z[198] * u4)^2 + (((((((z[93] * u8 - z[199] * u7) - z[200] * u1) - z[201] * u2) - z[202] * u6) - z[203] * u5) - z[205] * u4) - z[206] * u3)^2) + 0.5 * mua * ((z[297] * u7 + z[298] * u1 + z[299] * u2 + z[300] * u6 + z[301] * u5 + z[302] * u4 + z[303] * u3)^2 + ((((((((z[311] - luao * u12) - z[304] * u7) - z[305] * u1) - z[306] * u2) - z[307] * u6) - z[308] * u5) - z[309] * u4) - z[312] * u3)^2) + 0.5 * mua * ((z[342] * u7 + z[343] * u1 + z[344] * u2 + z[345] * u6 + z[346] * u5 + z[347] * u4 + z[348] * u3)^2 + ((((((((z[356] - luao * u13) - z[349] * u7) - z[350] * u1) - z[351] * u2) - z[352] * u6) - z[353] * u5) - z[354] * u4) - z[357] * u3)^2) + 0.5 * mla * ((z[337] + llao * u14 + z[335] * u12 + z[324] * u7 + z[325] * u1 + z[326] * u2 + z[327] * u6 + z[328] * u5 + z[329] * u4 + z[336] * u3)^2 + ((((((((z[315] * u12 - z[323]) - z[316] * u7) - z[317] * u1) - z[318] * u2) - z[319] * u6) - z[320] * u5) - z[321] * u4) - z[322] * u3)^2) + 0.5 * mla * ((z[382] + llao * u15 + z[380] * u13 + z[369] * u7 + z[370] * u1 + z[371] * u2 + z[372] * u6 + z[373] * u5 + z[374] * u4 + z[381] * u3)^2 + ((((((((z[360] * u13 - z[368]) - z[361] * u7) - z[362] * u1) - z[363] * u2) - z[364] * u6) - z[365] * u5) - z[366] * u4) - z[367] * u3)^2) + 0.5 * mff * (((z[253] * u9 + z[254] * u7 + z[255] * u1 + z[256] * u2 + z[257] * u6 + z[258] * u5 + z[259] * u4 + z[260] * u3 + z[261] * u8) - z[262] * u10)^2 + ((((((((((z[90] * u11 - z[264] * u7) - z[265] * u1) - z[266] * u2) - z[267] * u6) - z[268] * u5) - z[269] * u4) - z[273] * u10) - z[274] * u8) - z[275] * u3) - z[276] * u9)^2) + 0.125 * mrf * ((((4 * (z[39] * u1 + z[40] * u2)^2 + lrffo^2 * (((u3 + u5) - u4) - u6)^2 + lrfo^2 * (((u3 + u5) - u4) - u6)^2 + 2 * lrffo * lrfo * z[27] * (((u3 + u5) - u4) - u6)^2 + 4 * ((((((lff * u3 + lff * u5) - lff * u4) - lff * u6) - lff * u7) - z[41] * u1) - z[42] * u2)^2 + 4 * lrffo * z[481] * (((u3 + u5) - u4) - u6) * ((((((lff * u3 + lff * u5) - lff * u4) - lff * u6) - lff * u7) - z[41] * u1) - z[42] * u2)) - 4 * lrffo * z[482] * (z[39] * u1 + z[40] * u2) * (((u3 + u5) - u4) - u6)) - 4 * lrfo * z[18] * (z[39] * u1 + z[40] * u2) * (((u3 + u5) - u4) - u6)) - 4 * lrfo * z[17] * (((u3 + u5) - u4) - u6) * ((((((lff * u3 + lff * u5) - lff * u4) - lff * u6) - lff * u7) - z[41] * u1) - z[42] * u2))) - 0.125 * mrf * ((((((((4 * lrffo * z[27] * z[91] * (((u10 + u8) - u3) - u9)^2 - 4 * z[91]^2 * (((u10 + u8) - u3) - u9)^2) - lrffo^2 * (((u10 + u8) - u3) - u9)^2) - 4 * (z[208] * u8 + z[209] * u7 + z[210] * u1 + z[211] * u2 + z[212] * u6 + z[213] * u5 + z[214] * u4 + z[215] * u3)^2) - 4 * (lsh * u9 + z[216] * u7 + z[217] * u1 + z[218] * u2 + z[219] * u6 + z[221] * u5 + z[222] * u4 + z[226] * u3 + z[227] * u8)^2) - 8 * z[91] * z[12] * (((u10 + u8) - u3) - u9) * (z[208] * u8 + z[209] * u7 + z[210] * u1 + z[211] * u2 + z[212] * u6 + z[213] * u5 + z[214] * u4 + z[215] * u3)) - 4 * lrffo * z[486] * (((u10 + u8) - u3) - u9) * (z[208] * u8 + z[209] * u7 + z[210] * u1 + z[211] * u2 + z[212] * u6 + z[213] * u5 + z[214] * u4 + z[215] * u3)) - 8 * z[91] * z[11] * (((u10 + u8) - u3) - u9) * (lsh * u9 + z[216] * u7 + z[217] * u1 + z[218] * u2 + z[219] * u6 + z[221] * u5 + z[222] * u4 + z[226] * u3 + z[227] * u8)) - 4 * lrffo * z[484] * (((u10 + u8) - u3) - u9) * (lsh * u9 + z[216] * u7 + z[217] * u1 + z[218] * u2 + z[219] * u6 + z[221] * u5 + z[222] * u4 + z[226] * u3 + z[227] * u8))
end

kecm(sol) = [kecm(sol, t) for t in sol.t]


function hz(sol, t)
    @unpack z, ihat, ila, u12, u13, u14, u15, iua, iff, irf, ish, ith = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((((((((((((((((((((z[487] + z[489] + ihat * u3 + ila * u12 + ila * u13 + ila * u14 + ila * u15 + iua * u12 + iua * u13 + 2 * iff * u3 + 2 * ila * u3 + 2 * irf * u3 + 2 * ish * u3 + 2 * ith * u3 + 2 * iua * u3 + irf * ((u5 - u4) - u6) + iff * (((u5 - u4) - u6) - u7) + z[854] * z[498] + z[856] * z[542] + z[858] * z[592] + z[866] * z[706] + z[868] * z[736] + z[870] * z[766] + z[872] * z[791] + z[874] * z[811] + z[882] * z[842] + z[884] * z[849] + z[886] * z[853] + 0.25 * z[865] * z[598] + 0.5 * z[861] * z[541] + 0.5 * z[877] * z[816] + 0.5 * z[880] * z[819] + 0.5 * z[881] * z[818]) - z[488]) - z[490]) - ith * u4) - ith * u8) - ish * (u4 - u5)) - ish * (u8 - u9)) - irf * ((u10 + u8) - u9)) - iff * ((u10 + u11 + u8) - u9)) - z[855] * z[497]) - z[857] * z[541]) - z[859] * z[591]) - z[867] * z[705]) - z[869] * z[735]) - z[871] * z[765]) - z[873] * z[790]) - z[875] * z[810]) - z[883] * z[818]) - z[885] * z[848]) - z[887] * z[852]) - 0.5 * z[860] * z[596]) - 0.25 * z[863] * z[597]) - 0.25 * z[879] * z[817]
end

hz(sol) = [hz(sol, t) for t in sol.t]


function px(sol, t)
    @unpack z, u14, u12, u15, u13 = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return (((((((((((0.5 * z[932] * z[70] * (((u10 + u8) - u3) - u9) + z[39] * (z[902] * u1 + z[903] * u2 + z[926] * u1 + z[927] * u2) + z[1] * (z[888] * u7 + z[889] * u1 + z[890] * u2 + z[891] * u6 + z[892] * u3 + z[893] * u5 + z[894] * u4) + z[35] * (z[933] * u4 + z[933] * u6 + z[934] * u7 + z[935] * u3 + z[935] * u5 + z[936] * u1 + z[937] * u2) + z[37] * (z[938] * u7 + z[939] * u1 + z[940] * u2 + z[941] * u6 + z[942] * u3 + z[942] * u5 + z[943] * u4) + z[54] * (z[944] * u7 + z[945] * u1 + z[946] * u2 + z[947] * u6 + z[948] * u3 + z[948] * u5 + z[949] * u4) + z[56] * (z[950] * u7 + z[951] * u1 + z[952] * u2 + z[953] * u6 + z[954] * u5 + z[955] * u3 + z[956] * u4) + z[57] * (z[1047] * u7 + z[1048] * u1 + z[1049] * u2 + z[1050] * u6 + z[1051] * u3 + z[1052] * u5 + z[1053] * u4) + z[76] * (z[1062] * u7 + z[1063] * u1 + z[1064] * u2 + z[1065] * u6 + z[1066] * u5 + z[1067] * u4 + z[1068] * u3) + z[83] * (z[957] * u7 + z[958] * u1 + z[959] * u2 + z[960] * u6 + z[961] * u5 + z[962] * u4 + z[963] * u3) + z[81] * (z[1011] + z[916] * u14 + z[1003] * u12 + z[1004] * u7 + z[1005] * u1 + z[1006] * u2 + z[1007] * u6 + z[1008] * u5 + z[1009] * u4 + z[1010] * u3) + z[88] * (z[925] + z[916] * u15 + z[917] * u13 + z[918] * u7 + z[919] * u1 + z[920] * u2 + z[921] * u6 + z[922] * u5 + z[923] * u4 + z[924] * u3) + z[72] * ((z[973] * u9 + z[974] * u7 + z[975] * u1 + z[976] * u2 + z[977] * u6 + z[978] * u5 + z[979] * u4 + z[980] * u3 + z[981] * u8) - z[982] * u10) + z[60] * (z[1013] * u8 + z[1014] * u7 + z[1015] * u1 + z[1016] * u2 + z[1017] * u6 + z[1018] * u5 + z[1019] * u4 + z[1020] * u3 + z[1030] * u8 + z[1031] * u7 + z[1032] * u1 + z[1033] * u2 + z[1034] * u6 + z[1035] * u5 + z[1036] * u4 + z[1037] * u3) + z[62] * (z[1021] * u9 + z[1038] * u9 + z[1022] * u7 + z[1023] * u1 + z[1024] * u2 + z[1025] * u6 + z[1026] * u5 + z[1027] * u4 + z[1028] * u3 + z[1029] * u8 + z[1039] * u7 + z[1040] * u1 + z[1041] * u2 + z[1042] * u6 + z[1043] * u5 + z[1044] * u4 + z[1045] * u3 + z[1046] * u8)) - z[1012] * z[66] * (((u10 + u8) - u3) - u9)) - 0.5 * z[931] * z[52] * (((u3 + u5) - u4) - u6)) - 0.5 * z[932] * z[48] * (((u3 + u5) - u4) - u6)) - z[2] * (z[895] * u7 + z[896] * u1 + z[897] * u2 + z[898] * u6 + z[899] * u5 + z[900] * u4 + z[901] * u3)) - z[59] * (((((((z[1061] * u8 - z[1054] * u7) - z[1055] * u1) - z[1056] * u2) - z[1057] * u6) - z[1058] * u5) - z[1059] * u4) - z[1060] * u3)) - z[78] * ((((((((z[1076] - z[964] * u12) - z[1069] * u7) - z[1070] * u1) - z[1071] * u2) - z[1072] * u6) - z[1073] * u5) - z[1074] * u4) - z[1075] * u3)) - z[79] * ((((((((z[1001] * u12 - z[1002]) - z[994] * u7) - z[995] * u1) - z[996] * u2) - z[997] * u6) - z[998] * u5) - z[999] * u4) - z[1000] * u3)) - z[85] * ((((((((z[972] - z[964] * u13) - z[965] * u7) - z[966] * u1) - z[967] * u2) - z[968] * u6) - z[969] * u5) - z[970] * u4) - z[971] * u3)) - z[86] * ((((((((z[914] * u13 - z[915]) - z[907] * u7) - z[908] * u1) - z[909] * u2) - z[910] * u6) - z[911] * u5) - z[912] * u4) - z[913] * u3)) - z[74] * ((((((((((z[993] * u11 - z[983] * u7) - z[984] * u1) - z[985] * u2) - z[986] * u6) - z[987] * u5) - z[988] * u4) - z[989] * u10) - z[990] * u8) - z[991] * u3) - z[992] * u9)) - z[41] * (((((((((((z[904] * u3 + z[904] * u5 + z[928] * u3 + z[928] * u5) - z[904] * u4) - z[904] * u6) - z[904] * u7) - z[928] * u4) - z[928] * u6) - z[928] * u7) - z[905] * u1) - z[906] * u2) - z[929] * u1) - z[930] * u2)
end

px(sol) = [px(sol, t) for t in sol.t]


function py(sol, t)
    @unpack z, u14, u12, u15, u13 = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((((((((0.5 * z[932] * z[71] * (((u10 + u8) - u3) - u9) + z[40] * (z[902] * u1 + z[903] * u2 + z[926] * u1 + z[927] * u2) + z[1] * (z[895] * u7 + z[896] * u1 + z[897] * u2 + z[898] * u6 + z[899] * u5 + z[900] * u4 + z[901] * u3) + z[2] * (z[888] * u7 + z[889] * u1 + z[890] * u2 + z[891] * u6 + z[892] * u3 + z[893] * u5 + z[894] * u4) + z[36] * (z[933] * u4 + z[933] * u6 + z[934] * u7 + z[935] * u3 + z[935] * u5 + z[936] * u1 + z[937] * u2) + z[38] * (z[938] * u7 + z[939] * u1 + z[940] * u2 + z[941] * u6 + z[942] * u3 + z[942] * u5 + z[943] * u4) + z[54] * (z[950] * u7 + z[951] * u1 + z[952] * u2 + z[953] * u6 + z[954] * u5 + z[955] * u3 + z[956] * u4) + z[55] * (z[944] * u7 + z[945] * u1 + z[946] * u2 + z[947] * u6 + z[948] * u3 + z[948] * u5 + z[949] * u4) + z[58] * (z[1047] * u7 + z[1048] * u1 + z[1049] * u2 + z[1050] * u6 + z[1051] * u3 + z[1052] * u5 + z[1053] * u4) + z[77] * (z[1062] * u7 + z[1063] * u1 + z[1064] * u2 + z[1065] * u6 + z[1066] * u5 + z[1067] * u4 + z[1068] * u3) + z[84] * (z[957] * u7 + z[958] * u1 + z[959] * u2 + z[960] * u6 + z[961] * u5 + z[962] * u4 + z[963] * u3) + z[82] * (z[1011] + z[916] * u14 + z[1003] * u12 + z[1004] * u7 + z[1005] * u1 + z[1006] * u2 + z[1007] * u6 + z[1008] * u5 + z[1009] * u4 + z[1010] * u3) + z[89] * (z[925] + z[916] * u15 + z[917] * u13 + z[918] * u7 + z[919] * u1 + z[920] * u2 + z[921] * u6 + z[922] * u5 + z[923] * u4 + z[924] * u3) + z[73] * ((z[973] * u9 + z[974] * u7 + z[975] * u1 + z[976] * u2 + z[977] * u6 + z[978] * u5 + z[979] * u4 + z[980] * u3 + z[981] * u8) - z[982] * u10) + z[61] * (z[1013] * u8 + z[1014] * u7 + z[1015] * u1 + z[1016] * u2 + z[1017] * u6 + z[1018] * u5 + z[1019] * u4 + z[1020] * u3 + z[1030] * u8 + z[1031] * u7 + z[1032] * u1 + z[1033] * u2 + z[1034] * u6 + z[1035] * u5 + z[1036] * u4 + z[1037] * u3) + z[63] * (z[1021] * u9 + z[1038] * u9 + z[1022] * u7 + z[1023] * u1 + z[1024] * u2 + z[1025] * u6 + z[1026] * u5 + z[1027] * u4 + z[1028] * u3 + z[1029] * u8 + z[1039] * u7 + z[1040] * u1 + z[1041] * u2 + z[1042] * u6 + z[1043] * u5 + z[1044] * u4 + z[1045] * u3 + z[1046] * u8)) - z[1012] * z[67] * (((u10 + u8) - u3) - u9)) - 0.5 * z[931] * z[53] * (((u3 + u5) - u4) - u6)) - 0.5 * z[932] * z[49] * (((u3 + u5) - u4) - u6)) - z[57] * (((((((z[1061] * u8 - z[1054] * u7) - z[1055] * u1) - z[1056] * u2) - z[1057] * u6) - z[1058] * u5) - z[1059] * u4) - z[1060] * u3)) - z[76] * ((((((((z[1076] - z[964] * u12) - z[1069] * u7) - z[1070] * u1) - z[1071] * u2) - z[1072] * u6) - z[1073] * u5) - z[1074] * u4) - z[1075] * u3)) - z[80] * ((((((((z[1001] * u12 - z[1002]) - z[994] * u7) - z[995] * u1) - z[996] * u2) - z[997] * u6) - z[998] * u5) - z[999] * u4) - z[1000] * u3)) - z[83] * ((((((((z[972] - z[964] * u13) - z[965] * u7) - z[966] * u1) - z[967] * u2) - z[968] * u6) - z[969] * u5) - z[970] * u4) - z[971] * u3)) - z[87] * ((((((((z[914] * u13 - z[915]) - z[907] * u7) - z[908] * u1) - z[909] * u2) - z[910] * u6) - z[911] * u5) - z[912] * u4) - z[913] * u3)) - z[75] * ((((((((((z[993] * u11 - z[983] * u7) - z[984] * u1) - z[985] * u2) - z[986] * u6) - z[987] * u5) - z[988] * u4) - z[989] * u10) - z[990] * u8) - z[991] * u3) - z[992] * u9)) - z[42] * (((((((((((z[904] * u3 + z[904] * u5 + z[928] * u3 + z[928] * u5) - z[904] * u4) - z[904] * u6) - z[904] * u7) - z[928] * u4) - z[928] * u6) - z[928] * u7) - z[905] * u1) - z[906] * u2) - z[929] * u1) - z[930] * u2)
end

py(sol) = [py(sol, t) for t in sol.t]


function rstq(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((((-(z[1270]) - z[1223] * u3p) - z[1224] * u7p) - z[1225] * u1p) - z[1226] * u2p) - z[1227] * u6p) - z[1228] * u5p) - z[1229] * u4p
end

rstq(sol) = [rstq(sol, t) for t in sol.t]


function lstq(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((((-(z[1271]) - z[1231] * u3p) - z[1232] * u7p) - z[1233] * u1p) - z[1234] * u2p) - z[1235] * u6p) - z[1236] * u5p) - z[1237] * u4p
end

lstq(sol) = [lstq(sol, t) for t in sol.t]


function retq(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((((z[1268] - z[1239] * u3p) - z[1240] * u7p) - z[1241] * u1p) - z[1242] * u2p) - z[1243] * u6p) - z[1244] * u5p) - z[1245] * u4p
end

retq(sol) = [retq(sol, t) for t in sol.t]


function letq(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((((z[1269] - z[1247] * u3p) - z[1248] * u7p) - z[1249] * u1p) - z[1250] * u2p) - z[1251] * u6p) - z[1252] * u5p) - z[1253] * u4p
end

letq(sol) = [letq(sol, t) for t in sol.t]


function lh(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q4
end

lh(sol) = [lh(sol, t) for t in sol.t]


function lhp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u4
end

lhp(sol) = [lhp(sol, t) for t in sol.t]


function lhpp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u4p
end

lhpp(sol) = [lhpp(sol, t) for t in sol.t]


function lk(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q5
end

lk(sol) = [lk(sol, t) for t in sol.t]


function lkp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u5
end

lkp(sol) = [lkp(sol, t) for t in sol.t]


function lkpp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u5p
end

lkpp(sol) = [lkpp(sol, t) for t in sol.t]


function la(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q6
end

la(sol) = [la(sol, t) for t in sol.t]


function lap(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u6
end

lap(sol) = [lap(sol, t) for t in sol.t]


function lapp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u6p
end

lapp(sol) = [lapp(sol, t) for t in sol.t]


function lmtp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q7
end

lmtp(sol) = [lmtp(sol, t) for t in sol.t]


function lmtpp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u7
end

lmtpp(sol) = [lmtpp(sol, t) for t in sol.t]


function lmtppp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u7p
end

lmtppp(sol) = [lmtppp(sol, t) for t in sol.t]


function rh(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q8
end

rh(sol) = [rh(sol, t) for t in sol.t]


function rhp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u8
end

rhp(sol) = [rhp(sol, t) for t in sol.t]


function rhpp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u8p
end

rhpp(sol) = [rhpp(sol, t) for t in sol.t]


function rk(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q9
end

rk(sol) = [rk(sol, t) for t in sol.t]


function rkp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u9
end

rkp(sol) = [rkp(sol, t) for t in sol.t]


function rkpp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u9p
end

rkpp(sol) = [rkpp(sol, t) for t in sol.t]


function ra(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q10
end

ra(sol) = [ra(sol, t) for t in sol.t]


function rap(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u10
end

rap(sol) = [rap(sol, t) for t in sol.t]


function rapp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u10p
end

rapp(sol) = [rapp(sol, t) for t in sol.t]


function rmtpp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u11
end

rmtpp(sol) = [rmtpp(sol, t) for t in sol.t]


function rmtppp(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return u11p
end

rmtppp(sol) = [rmtppp(sol, t) for t in sol.t]


function pop1x(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q1
end

pop1x(sol) = [pop1x(sol, t) for t in sol.t]


function pop1y(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q2
end

pop1y(sol) = [pop1y(sol, t) for t in sol.t]


function pop3x(sol, t)
    @unpack z, lff, lrff = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return (q1 - lff * z[39]) - lrff * z[46]
end

pop3x(sol) = [pop3x(sol, t) for t in sol.t]


function pop3y(sol, t)
    @unpack z, lff, lrff = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return (q2 - lff * z[40]) - lrff * z[47]
end

pop3y(sol) = [pop3y(sol, t) for t in sol.t]


function pop4x(sol, t)
    @unpack z, lff, lrf = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return (q1 - lff * z[39]) - lrf * z[50]
end

pop4x(sol) = [pop4x(sol, t) for t in sol.t]


function pop4y(sol, t)
    @unpack z, lff, lrf = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return (q2 - lff * z[40]) - lrf * z[51]
end

pop4y(sol) = [pop4y(sol, t) for t in sol.t]


function pop5x(sol, t)
    @unpack z, lff, lrf, lsh = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((q1 - lff * z[39]) - lrf * z[50]) - lsh * z[35]
end

pop5x(sol) = [pop5x(sol, t) for t in sol.t]


function pop5y(sol, t)
    @unpack z, lff, lrf, lsh = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((q2 - lff * z[40]) - lrf * z[51]) - lsh * z[36]
end

pop5y(sol) = [pop5y(sol, t) for t in sol.t]


function pop6x(sol, t)
    @unpack z, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return (((q1 - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop6x(sol) = [pop6x(sol, t) for t in sol.t]


function pop6y(sol, t)
    @unpack z, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return (((q2 - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop6y(sol) = [pop6y(sol, t) for t in sol.t]


function pop7x(sol, t)
    @unpack z, lth, lff, lrf, lsh = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lth * z[57]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop7x(sol) = [pop7x(sol, t) for t in sol.t]


function pop7y(sol, t)
    @unpack z, lth, lff, lrf, lsh = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lth * z[58]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop7y(sol) = [pop7y(sol, t) for t in sol.t]


function pop8x(sol, t)
    @unpack z, lsh, lth, lff, lrf = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lsh * z[60] + lth * z[57]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop8x(sol) = [pop8x(sol, t) for t in sol.t]


function pop8y(sol, t)
    @unpack z, lsh, lth, lff, lrf = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lsh * z[61] + lth * z[58]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop8y(sol) = [pop8y(sol, t) for t in sol.t]


function pop9x(sol, t)
    @unpack z, lrf, lsh, lth, lff, lrff = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return (((((q1 + lrf * z[64] + lsh * z[60] + lth * z[57]) - lff * z[39]) - lrf * z[50]) - lrff * z[68]) - lsh * z[35]) - lth * z[54]
end

pop9x(sol) = [pop9x(sol, t) for t in sol.t]


function pop9y(sol, t)
    @unpack z, lrf, lsh, lth, lff, lrff = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return (((((q2 + lrf * z[65] + lsh * z[61] + lth * z[58]) - lff * z[40]) - lrf * z[51]) - lrff * z[69]) - lsh * z[36]) - lth * z[55]
end

pop9y(sol) = [pop9y(sol, t) for t in sol.t]


function pop10x(sol, t)
    @unpack z, lrf, lsh, lth, lff = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lrf * z[64] + lsh * z[60] + lth * z[57]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop10x(sol) = [pop10x(sol, t) for t in sol.t]


function pop10y(sol, t)
    @unpack z, lrf, lsh, lth, lff = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lrf * z[65] + lsh * z[61] + lth * z[58]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop10y(sol) = [pop10y(sol, t) for t in sol.t]


function pop11x(sol, t)
    @unpack z, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lff * z[72] + lrf * z[64] + lsh * z[60] + lth * z[57]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop11x(sol) = [pop11x(sol, t) for t in sol.t]


function pop11y(sol, t)
    @unpack z, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lff * z[73] + lrf * z[65] + lsh * z[61] + lth * z[58]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop11y(sol) = [pop11y(sol, t) for t in sol.t]


function pop12x(sol, t)
    @unpack z, lhat, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lhat * z[1]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop12x(sol) = [pop12x(sol, t) for t in sol.t]


function pop12y(sol, t)
    @unpack z, lhat, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lhat * z[2]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop12y(sol) = [pop12y(sol, t) for t in sol.t]


function pop13x(sol, t)
    @unpack z, lhat, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lhat * z[1] + lua * z[76]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop13x(sol) = [pop13x(sol, t) for t in sol.t]


function pop13y(sol, t)
    @unpack z, lhat, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lhat * z[2] + lua * z[77]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop13y(sol) = [pop13y(sol, t) for t in sol.t]


function pop14x(sol, t)
    @unpack z, lhat, lla, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lhat * z[1] + lla * z[79] + lua * z[76]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop14x(sol) = [pop14x(sol, t) for t in sol.t]


function pop14y(sol, t)
    @unpack z, lhat, lla, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lhat * z[2] + lla * z[80] + lua * z[77]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop14y(sol) = [pop14y(sol, t) for t in sol.t]


function pop15x(sol, t)
    @unpack z, lhat, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lhat * z[1] + lua * z[83]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop15x(sol) = [pop15x(sol, t) for t in sol.t]


function pop15y(sol, t)
    @unpack z, lhat, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lhat * z[2] + lua * z[84]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop15y(sol) = [pop15y(sol, t) for t in sol.t]


function pop16x(sol, t)
    @unpack z, lhat, lla, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lhat * z[1] + lla * z[86] + lua * z[83]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop16x(sol) = [pop16x(sol, t) for t in sol.t]


function pop16y(sol, t)
    @unpack z, lhat, lla, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lhat * z[2] + lla * z[87] + lua * z[84]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop16y(sol) = [pop16y(sol, t) for t in sol.t]


function pocmx(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((((q1 + z[95] * z[1] + z[97] * z[79] + z[97] * z[86] + z[102] * z[76] + z[102] * z[83] + z[103] * z[72] + z[104] * z[64] + z[105] * z[60] + z[106] * z[57]) - z[96] * z[39]) - z[100] * z[35]) - z[101] * z[54]) - 0.5 * z[98] * z[50]) - 0.5 * z[99] * z[46]) - 0.5 * z[99] * z[68]
end

pocmx(sol) = [pocmx(sol, t) for t in sol.t]


function pocmy(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((((q2 + z[95] * z[2] + z[97] * z[80] + z[97] * z[87] + z[102] * z[77] + z[102] * z[84] + z[103] * z[73] + z[104] * z[65] + z[105] * z[61] + z[106] * z[58]) - z[96] * z[40]) - z[100] * z[36]) - z[101] * z[55]) - 0.5 * z[98] * z[51]) - 0.5 * z[99] * z[47]) - 0.5 * z[99] * z[69]
end

pocmy(sol) = [pocmy(sol, t) for t in sol.t]


function vocmx(sol, t)
    @unpack z, u12, u14, u13, u15 = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ((((((((((u1 + z[106] * z[59] * (u3 - u8) + z[100] * z[37] * ((u4 - u3) - u5) + z[81] * (z[389] + z[97] * u12 + z[97] * u14 + z[97] * u3) + z[88] * (z[387] + z[97] * u13 + z[97] * u15 + z[97] * u3) + 0.5 * z[99] * z[70] * (((u10 + u8) - u3) - u9)) - z[95] * z[2] * u3) - z[101] * z[56] * (u3 - u4)) - z[105] * z[62] * ((u8 - u3) - u9)) - z[104] * z[66] * (((u10 + u8) - u3) - u9)) - z[78] * ((z[390] - z[102] * u12) - z[102] * u3)) - z[85] * ((z[388] - z[102] * u13) - z[102] * u3)) - 0.5 * z[98] * z[52] * (((u3 + u5) - u4) - u6)) - 0.5 * z[99] * z[48] * (((u3 + u5) - u4) - u6)) - z[103] * z[74] * (((u10 + u11 + u8) - u3) - u9)) - z[96] * z[41] * ((((u3 + u5) - u4) - u6) - u7)
end

vocmx(sol) = [vocmx(sol, t) for t in sol.t]


function vocmy(sol, t)
    @unpack z, u12, u14, u13, u15 = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return (((((((((u2 + z[95] * z[1] * u3 + z[106] * z[57] * (u3 - u8) + z[100] * z[38] * ((u4 - u3) - u5) + z[82] * (z[389] + z[97] * u12 + z[97] * u14 + z[97] * u3) + z[89] * (z[387] + z[97] * u13 + z[97] * u15 + z[97] * u3) + 0.5 * z[99] * z[71] * (((u10 + u8) - u3) - u9)) - z[101] * z[54] * (u3 - u4)) - z[105] * z[63] * ((u8 - u3) - u9)) - z[104] * z[67] * (((u10 + u8) - u3) - u9)) - z[76] * ((z[390] - z[102] * u12) - z[102] * u3)) - z[83] * ((z[388] - z[102] * u13) - z[102] * u3)) - 0.5 * z[98] * z[53] * (((u3 + u5) - u4) - u6)) - 0.5 * z[99] * z[49] * (((u3 + u5) - u4) - u6)) - z[103] * z[75] * (((u10 + u11 + u8) - u3) - u9)) - z[96] * z[42] * ((((u3 + u5) - u4) - u6) - u7)
end

vocmy(sol) = [vocmy(sol, t) for t in sol.t]


function rx(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return rx1 + rx2
end

rx(sol) = [rx(sol, t) for t in sol.t]


function ry(sol, t)

    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)


    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return ry1 + ry2
end

ry(sol) = [ry(sol, t) for t in sol.t]


function io(sol, t)
    @unpack footang, g, iff, ihat, ila, irf, ish, ith, iua, k1, k2, k3, k4, k5, k6, k7, k8, lae, laf, lff, lffo, lhat, lhato, lhe, lhf, lke, lkf, lla, llao, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, lua, luao, mff, mhat, mla, mrf, msh, mth, mtpb, mtpk, mtpxi, mua, rae, raf, rhe, rhf, rke, rkf, toexi, u12, u13, u14, u15, z = sol.prob.p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = sol(t)

    # specified variables
    rs = _rs(t)
    ls = _ls(t)
    re = _re(t)
    le = _le(t)
    rsp = _rsp(t)
    lsp = _lsp(t)
    repp = _repp(t)
    rspp = _rspp(t)
    lepp = _lepp(t)
    lspp = _lspp(t)
    rep = _rep(t)
    lep = _lep(t)

    # calculated variables
    rx1, ry1, rx2, ry2 = contact_forces(sol(t), p, t)

    u12 = 0
    u13 = 0
    u14 = 0
    u15 = 0
    z[932] = lrffo * mrf
    z[27] = cos(footang)
    z[465] = g * mla
    z[1096] = llao * z[465]
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
    z[463] = g * mhat
    z[464] = g * mff
    z[466] = g * mrf
    z[467] = g * msh
    z[468] = g * mth
    z[469] = g * mua
    z[491] = lff - z[96]
    z[492] = lsh - z[100]
    z[493] = lth - z[101]
    z[494] = 2lrf - z[98]
    z[587] = lhat - z[95]
    z[588] = lua - z[102]
    z[593] = z[96] - lff
    z[594] = 0.5 * z[98] - 0.5lrfo
    z[595] = 0.5 * z[99] - 0.5lrffo
    z[785] = lsh - z[105]
    z[786] = lth - z[106]
    z[787] = lrf - z[104]
    z[812] = 0.5 * z[98] - lrf
    z[813] = z[100] - lsh
    z[814] = z[101] - lth
    z[815] = (lrf - 0.5lrfo) - z[104]
    z[862] = 2 * z[594] + 2 * z[27] * z[595]
    z[864] = z[27] * z[594]
    z[876] = z[27] * z[595]
    z[878] = z[27] * z[815]
    z[904] = lffo * mff
    z[916] = llao * mla
    z[928] = lff * mrf
    z[931] = lrfo * mrf
    z[964] = luao * mua
    z[993] = mff * z[90]
    z[1012] = mrf * z[91]
    z[1021] = lsh * mrf
    z[1038] = msh * z[92]
    z[1061] = mth * z[93]
    z[1079] = lffo * z[464]
    z[1084] = lff * z[466]
    z[1086] = z[93] * z[468]
    z[1088] = z[92] * z[467]
    z[1091] = z[90] * z[464]
    z[1093] = luao * z[469]
    z[1140] = ihat + 2iff + 2ila + 2irf + 2ish + 2ith + 2iua + mff * lffo^2
    z[1141] = lrffo^2 + lrfo^2 + 4 * lff^2 + 2 * lrffo * lrfo * z[27]
    z[1142] = lff * lrffo
    z[1143] = lff * lrfo
    z[1144] = lrffo^2 + 4 * z[91]^2
    z[1145] = lrffo * z[27] * z[91]
    z[1147] = iff + irf + ish + mff * lffo^2
    z[1149] = mff * lffo^2
    z[1153] = -iff - irf
    z[1154] = (lrffo^2 + 4 * z[91]^2) - 4 * lrffo * z[27] * z[91]
    z[1158] = iff + irf + ish
    z[1159] = lsh * z[91]
    z[1160] = lrffo * lsh
    z[1162] = lrffo * z[28]
    z[1163] = lrfo * z[28]
    z[1164] = z[28] * z[91]
    z[1167] = iff + irf + ish + ith + mff * lffo^2
    z[1169] = iff + irf + mff * lffo^2
    z[1171] = iff + mff * lffo^2
    z[1193] = iff + mff * lffo^2 + mrf * lff^2
    z[1200] = iff + irf
    z[1201] = (4 * lrffo * z[27] * z[91] - lrffo^2) - 4 * z[91]^2
    z[1204] = iff + irf + ish + ith + mth * z[93]^2
    z[1206] = lrffo^2
    z[1207] = z[91]^2
    z[1212] = iff + irf + ish + msh * z[92]^2
    z[1213] = (lrffo^2 + 4 * lsh^2 + 4 * z[91]^2) - 4 * lrffo * z[27] * z[91]
    z[1216] = iff + irf + 0.25 * mrf * ((lrffo^2 + 4 * z[91]^2) - 4 * lrffo * z[27] * z[91])
    z[1220] = iff + mff * z[90]^2
    z[1222] = ila + iua
    z[332] = z[23] * z[313]
    z[337] = z[332] + z[334]
    z[331] = lua * z[23]
    z[335] = llao - z[331]
    z[315] = lua * z[24]
    z[323] = z[24] * z[313]
    z[377] = z[25] * z[358]
    z[382] = z[377] + z[379]
    z[376] = lua * z[25]
    z[380] = llao - z[376]
    z[360] = lua * z[26]
    z[368] = z[26] * z[358]
    z[487] = ila * z[378]
    z[489] = ila * z[333]
    z[44] = z[27] * z[14] - z[28] * z[13]
    z[46] = z[35] * z[43] + z[37] * z[44]
    z[47] = z[36] * z[43] + z[38] * z[44]
    z[147] = z[1] * z[46] + z[2] * z[47]
    z[59] = z[1] * z[4] - z[2] * z[3]
    z[62] = z[8] * z[57] - z[7] * z[59]
    z[60] = -(z[7]) * z[57] - z[8] * z[59]
    z[64] = z[12] * z[62] - z[11] * z[60]
    z[66] = -(z[11]) * z[62] - z[12] * z[60]
    z[68] = z[27] * z[64] + z[28] * z[66]
    z[69] = z[27] * z[65] + z[28] * z[67]
    z[228] = z[1] * z[68] + z[2] * z[69]
    z[78] = z[19] * z[2] - z[20] * z[1]
    z[79] = -(z[23]) * z[76] - z[24] * z[78]
    z[137] = z[1] * z[79] + z[2] * z[80]
    z[85] = z[21] * z[2] - z[22] * z[1]
    z[86] = -(z[25]) * z[83] - z[26] * z[85]
    z[143] = z[1] * z[86] + z[2] * z[87]
    z[72] = z[16] * z[66] - z[15] * z[64]
    z[124] = z[1] * z[72] + z[2] * z[73]
    z[114] = z[1] * z[64] + z[2] * z[65]
    z[108] = z[1] * z[60] + z[2] * z[61]
    z[129] = z[1] * z[39] + z[2] * z[40]
    z[50] = z[14] * z[37] - z[13] * z[35]
    z[51] = z[14] * z[38] - z[13] * z[36]
    z[119] = z[1] * z[50] + z[2] * z[51]
    z[495] = (((((((((((lhato + z[102] * z[19] + z[102] * z[21] + 0.5 * z[99] * z[147] + 0.5 * z[99] * z[228]) - z[95]) - z[97] * z[137]) - z[97] * z[143]) - z[103] * z[124]) - z[104] * z[114]) - z[105] * z[108]) - z[106] * z[3]) - z[491] * z[129]) - z[492] * z[32]) - z[493] * z[5]) - 0.5 * z[494] * z[119]
    z[854] = mhat * z[495]
    z[498] = z[288] * u7 + z[289] * u1 + z[290] * u2 + z[291] * u6 + z[292] * u5 + z[294] * u4 + z[295] * u3
    z[131] = z[1] * z[40] - z[2] * z[39]
    z[503] = z[5] * z[129] - z[6] * z[131]
    z[511] = z[39] * z[72] + z[40] * z[73]
    z[74] = -(z[15]) * z[66] - z[16] * z[64]
    z[513] = z[39] * z[74] + z[40] * z[75]
    z[519] = -(z[15]) * z[511] - z[16] * z[513]
    z[521] = z[16] * z[511] - z[15] * z[513]
    z[523] = z[27] * z[519] + z[28] * z[521]
    z[499] = z[39] * z[86] + z[40] * z[87]
    z[515] = z[39] * z[79] + z[40] * z[80]
    z[507] = z[22] * z[131] - z[21] * z[129]
    z[535] = z[20] * z[131] - z[19] * z[129]
    z[527] = -(z[11]) * z[519] - z[12] * z[521]
    z[531] = z[3] * z[129] - z[4] * z[131]
    z[539] = (((((((((((z[96] + z[100] * z[29] + z[101] * z[503] + 0.5 * z[99] * z[481] + 0.5 * z[99] * z[523]) - lffo) - z[95] * z[129]) - z[97] * z[499]) - z[97] * z[515]) - z[102] * z[507]) - z[102] * z[535]) - z[103] * z[511]) - z[104] * z[519]) - z[105] * z[527]) - z[106] * z[531]) - 0.5 * z[98] * z[17]
    z[856] = mff * z[539]
    z[542] = ((lffo * u4 + lffo * u6 + lffo * u7 + z[41] * u1 + z[42] * u2) - lffo * u3) - lffo * u5
    z[500] = z[41] * z[86] + z[42] * z[87]
    z[543] = -(z[17]) * z[499] - z[18] * z[500]
    z[545] = z[18] * z[499] - z[17] * z[500]
    z[547] = z[27] * z[543] + z[28] * z[545]
    z[559] = z[72] * z[86] + z[73] * z[87]
    z[561] = z[74] * z[86] + z[75] * z[87]
    z[567] = -(z[15]) * z[559] - z[16] * z[561]
    z[569] = z[16] * z[559] - z[15] * z[561]
    z[571] = z[27] * z[567] + z[28] * z[569]
    z[563] = z[79] * z[86] + z[80] * z[87]
    z[145] = z[1] * z[87] - z[2] * z[86]
    z[583] = z[20] * z[145] - z[19] * z[143]
    z[575] = -(z[11]) * z[567] - z[12] * z[569]
    z[579] = z[3] * z[143] - z[4] * z[145]
    z[551] = -(z[13]) * z[543] - z[14] * z[545]
    z[555] = z[5] * z[143] - z[6] * z[145]
    z[589] = ((((((((((((llao + z[587] * z[143] + 0.5 * z[99] * z[547] + 0.5 * z[99] * z[571]) - z[97]) - z[588] * z[25]) - z[97] * z[563]) - z[102] * z[583]) - z[103] * z[559]) - z[104] * z[567]) - z[105] * z[575]) - z[106] * z[579]) - z[491] * z[499]) - z[492] * z[551]) - z[493] * z[555]) - 0.5 * z[494] * z[543]
    z[858] = mla * z[589]
    z[592] = z[382] + llao * u15 + z[380] * u13 + z[369] * u7 + z[370] * u1 + z[371] * u2 + z[372] * u6 + z[373] * u5 + z[374] * u4 + z[381] * u3
    z[675] = z[35] * z[72] + z[36] * z[73]
    z[677] = z[35] * z[74] + z[36] * z[75]
    z[683] = -(z[15]) * z[675] - z[16] * z[677]
    z[685] = z[16] * z[675] - z[15] * z[677]
    z[687] = z[27] * z[683] + z[28] * z[685]
    z[679] = z[35] * z[79] + z[36] * z[80]
    z[671] = z[22] * z[33] - z[21] * z[32]
    z[699] = z[20] * z[33] - z[19] * z[32]
    z[691] = -(z[11]) * z[683] - z[12] * z[685]
    z[695] = z[3] * z[32] - z[4] * z[33]
    z[703] = ((((((((((((z[100] + 0.5 * z[99] * z[43] + 0.5 * z[99] * z[687] + 0.5 * z[494] * z[13]) - lsho) - z[95] * z[32]) - z[97] * z[551]) - z[97] * z[679]) - z[101] * z[9]) - z[102] * z[671]) - z[102] * z[699]) - z[103] * z[675]) - z[104] * z[683]) - z[105] * z[691]) - z[106] * z[695]) - z[491] * z[29]
    z[866] = msh * z[703]
    z[706] = z[164] * u7 + z[165] * u1 + z[166] * u2 + z[168] * u6 + z[169] * u3 + z[169] * u5 + z[170] * u4
    z[149] = z[1] * z[47] - z[2] * z[46]
    z[603] = z[5] * z[147] - z[6] * z[149]
    z[710] = z[54] * z[72] + z[55] * z[73]
    z[712] = z[54] * z[74] + z[55] * z[75]
    z[718] = -(z[15]) * z[710] - z[16] * z[712]
    z[720] = z[16] * z[710] - z[15] * z[712]
    z[722] = z[27] * z[718] + z[28] * z[720]
    z[714] = z[54] * z[79] + z[55] * z[80]
    z[707] = -(z[21]) * z[5] - z[22] * z[6]
    z[730] = -(z[19]) * z[5] - z[20] * z[6]
    z[726] = -(z[7]) * z[189] - z[8] * z[190]
    z[121] = z[1] * z[51] - z[2] * z[50]
    z[599] = z[5] * z[119] - z[6] * z[121]
    z[733] = ((((((((((((z[101] + z[492] * z[9] + 0.5 * z[99] * z[603] + 0.5 * z[99] * z[722]) - ltho) - z[95] * z[5]) - z[97] * z[555]) - z[97] * z[714]) - z[102] * z[707]) - z[102] * z[730]) - z[103] * z[710]) - z[104] * z[718]) - z[105] * z[726]) - z[106] * z[189]) - z[491] * z[503]) - 0.5 * z[494] * z[599]
    z[868] = mth * z[733]
    z[736] = z[179] * u7 + z[180] * u1 + z[181] * u2 + z[182] * u6 + z[183] * u5 + z[185] * u3 + z[186] * u4
    z[611] = z[22] * z[149] - z[21] * z[147]
    z[737] = z[72] * z[83] + z[73] * z[84]
    z[739] = z[74] * z[83] + z[75] * z[84]
    z[745] = -(z[15]) * z[737] - z[16] * z[739]
    z[747] = z[16] * z[737] - z[15] * z[739]
    z[749] = z[27] * z[745] + z[28] * z[747]
    z[760] = z[19] * z[21] + z[20] * z[22]
    z[741] = z[79] * z[83] + z[80] * z[84]
    z[753] = -(z[11]) * z[745] - z[12] * z[747]
    z[757] = -(z[21]) * z[3] - z[22] * z[4]
    z[607] = z[22] * z[121] - z[21] * z[119]
    z[763] = ((((((((((((luao + z[97] * z[25] + 0.5 * z[99] * z[611] + 0.5 * z[99] * z[749]) - z[102]) - z[102] * z[760]) - z[587] * z[21]) - z[97] * z[741]) - z[103] * z[737]) - z[104] * z[745]) - z[105] * z[753]) - z[106] * z[757]) - z[491] * z[507]) - z[492] * z[671]) - z[493] * z[707]) - 0.5 * z[494] * z[607]
    z[870] = mua * z[763]
    z[766] = (luao * u13 + z[349] * u7 + z[350] * u1 + z[351] * u2 + z[352] * u6 + z[353] * u5 + z[354] * u4 + z[357] * u3) - z[356]
    z[774] = z[11] * z[15] - z[12] * z[16]
    z[126] = z[1] * z[73] - z[2] * z[72]
    z[777] = z[3] * z[124] - z[4] * z[126]
    z[619] = z[46] * z[72] + z[47] * z[73]
    z[771] = z[28] * z[16] - z[27] * z[15]
    z[767] = z[72] * z[79] + z[73] * z[80]
    z[781] = z[20] * z[126] - z[19] * z[124]
    z[615] = z[50] * z[72] + z[51] * z[73]
    z[788] = ((((((((((((lff + z[785] * z[774] + z[786] * z[777] + 0.5 * z[99] * z[619] + 0.5 * z[99] * z[771]) - lffo) - z[103]) - z[95] * z[124]) - z[97] * z[559]) - z[97] * z[767]) - z[102] * z[737]) - z[102] * z[781]) - z[491] * z[511]) - z[492] * z[675]) - z[493] * z[710]) - z[787] * z[15]) - 0.5 * z[494] * z[615]
    z[872] = mff * z[788]
    z[791] = (z[264] * u7 + z[265] * u1 + z[266] * u2 + z[267] * u6 + z[268] * u5 + z[269] * u4 + z[273] * u10 + z[274] * u8 + z[275] * u3 + z[276] * u9) - z[90] * u11
    z[627] = z[46] * z[79] + z[47] * z[80]
    z[768] = z[74] * z[79] + z[75] * z[80]
    z[792] = -(z[15]) * z[767] - z[16] * z[768]
    z[794] = z[16] * z[767] - z[15] * z[768]
    z[796] = z[27] * z[792] + z[28] * z[794]
    z[800] = -(z[11]) * z[792] - z[12] * z[794]
    z[139] = z[1] * z[80] - z[2] * z[79]
    z[804] = z[3] * z[137] - z[4] * z[139]
    z[623] = z[50] * z[79] + z[51] * z[80]
    z[808] = ((((((((((((llao + z[587] * z[137] + 0.5 * z[99] * z[627] + 0.5 * z[99] * z[796]) - z[97]) - z[588] * z[23]) - z[97] * z[563]) - z[102] * z[741]) - z[103] * z[767]) - z[104] * z[792]) - z[105] * z[800]) - z[106] * z[804]) - z[491] * z[515]) - z[492] * z[679]) - z[493] * z[714]) - 0.5 * z[494] * z[623]
    z[874] = mla * z[808]
    z[811] = z[337] + llao * u14 + z[335] * u12 + z[324] * u7 + z[325] * u1 + z[326] * u2 + z[327] * u6 + z[328] * u5 + z[329] * u4 + z[336] * u3
    z[621] = z[46] * z[74] + z[47] * z[75]
    z[635] = -(z[15]) * z[619] - z[16] * z[621]
    z[637] = z[16] * z[619] - z[15] * z[621]
    z[651] = -(z[11]) * z[635] - z[12] * z[637]
    z[110] = z[1] * z[61] - z[2] * z[60]
    z[836] = z[20] * z[110] - z[19] * z[108]
    z[617] = z[50] * z[74] + z[51] * z[75]
    z[631] = -(z[15]) * z[615] - z[16] * z[617]
    z[633] = z[16] * z[615] - z[15] * z[617]
    z[647] = -(z[11]) * z[631] - z[12] * z[633]
    z[840] = (((((((((((((lsh + z[104] * z[11] + 0.5 * z[99] * z[484] + 0.5 * z[99] * z[651]) - lsho) - z[105]) - z[95] * z[108]) - z[97] * z[575]) - z[97] * z[800]) - z[102] * z[753]) - z[102] * z[836]) - z[103] * z[774]) - z[491] * z[527]) - z[492] * z[691]) - z[493] * z[726]) - z[786] * z[7]) - 0.5 * z[494] * z[647]
    z[882] = msh * z[840]
    z[842] = z[92] * u9 + z[216] * u7 + z[217] * u1 + z[218] * u2 + z[219] * u6 + z[221] * u5 + z[222] * u4 + z[224] * u3 + z[225] * u8
    z[659] = z[3] * z[147] - z[4] * z[149]
    z[230] = z[1] * z[69] - z[2] * z[68]
    z[824] = z[3] * z[228] - z[4] * z[230]
    z[843] = -(z[19]) * z[3] - z[20] * z[4]
    z[116] = z[1] * z[65] - z[2] * z[64]
    z[820] = z[3] * z[114] - z[4] * z[116]
    z[655] = z[3] * z[119] - z[4] * z[121]
    z[846] = (((((((((((((lth + z[105] * z[7] + 0.5 * z[99] * z[659] + 0.5 * z[99] * z[824]) - ltho) - z[106]) - z[95] * z[3]) - z[97] * z[579]) - z[97] * z[804]) - z[102] * z[757]) - z[102] * z[843]) - z[103] * z[777]) - z[104] * z[820]) - z[491] * z[531]) - z[492] * z[695]) - z[493] * z[189]) - 0.5 * z[494] * z[655]
    z[884] = mth * z[846]
    z[849] = (z[199] * u7 + z[200] * u1 + z[201] * u2 + z[202] * u6 + z[203] * u5 + z[205] * u4 + z[206] * u3) - z[93] * u8
    z[667] = z[20] * z[149] - z[19] * z[147]
    z[832] = z[20] * z[230] - z[19] * z[228]
    z[828] = z[20] * z[116] - z[19] * z[114]
    z[663] = z[20] * z[121] - z[19] * z[119]
    z[850] = ((((((((((((luao + z[97] * z[23] + 0.5 * z[99] * z[667] + 0.5 * z[99] * z[832]) - z[102]) - z[102] * z[760]) - z[587] * z[19]) - z[97] * z[583]) - z[103] * z[781]) - z[104] * z[828]) - z[105] * z[836]) - z[106] * z[843]) - z[491] * z[535]) - z[492] * z[699]) - z[493] * z[730]) - 0.5 * z[494] * z[663]
    z[886] = mua * z[850]
    z[853] = (luao * u12 + z[304] * u7 + z[305] * u1 + z[306] * u2 + z[307] * u6 + z[308] * u5 + z[309] * u4 + z[312] * u3) - z[311]
    z[643] = z[27] * z[635] + z[28] * z[637]
    z[865] = mrf * (((((((2 * z[95] * z[147] + 2 * z[97] * z[547] + 2 * z[97] * z[627] + 2 * z[102] * z[611] + 2 * z[102] * z[667] + 2 * z[103] * z[619] + 2 * z[104] * z[635] + 2 * z[105] * z[651] + 2 * z[106] * z[659]) - 2 * z[595]) - 2 * z[864]) - 2 * z[100] * z[43]) - 2 * z[101] * z[603]) - 2 * z[593] * z[481]) - z[99] * z[643])
    z[598] = lrffo * (((u3 + u5) - u4) - u6)
    z[130] = z[1] * z[41] + z[2] * z[42]
    z[516] = z[41] * z[79] + z[42] * z[80]
    z[132] = z[1] * z[42] - z[2] * z[41]
    z[508] = z[22] * z[132] - z[21] * z[130]
    z[536] = z[20] * z[132] - z[19] * z[130]
    z[512] = z[41] * z[72] + z[42] * z[73]
    z[514] = z[41] * z[74] + z[42] * z[75]
    z[520] = -(z[15]) * z[512] - z[16] * z[514]
    z[522] = z[16] * z[512] - z[15] * z[514]
    z[528] = -(z[11]) * z[520] - z[12] * z[522]
    z[532] = z[3] * z[130] - z[4] * z[132]
    z[504] = z[5] * z[130] - z[6] * z[132]
    z[524] = z[27] * z[520] + z[28] * z[522]
    z[861] = mrf * (((((2 * z[95] * z[130] + 2 * z[97] * z[500] + 2 * z[97] * z[516] + 2 * z[102] * z[508] + 2 * z[102] * z[536] + 2 * z[103] * z[512] + 2 * z[104] * z[520] + 2 * z[105] * z[528] + 2 * z[106] * z[532] + 2 * z[594] * z[18]) - 2 * z[100] * z[31]) - 2 * z[101] * z[504]) - 2 * z[595] * z[483]) - z[99] * z[524])
    z[541] = z[39] * u1 + z[40] * u2
    z[877] = mrf * ((((((((((2 * z[95] * z[114] + 2 * z[97] * z[567] + 2 * z[97] * z[792] + 2 * z[102] * z[745] + 2 * z[102] * z[828] + 2 * z[785] * z[11]) - 2 * z[815]) - 2 * z[876]) - 2 * z[103] * z[15]) - 2 * z[593] * z[519]) - 2 * z[786] * z[820]) - 2 * z[812] * z[631]) - 2 * z[813] * z[683]) - 2 * z[814] * z[718]) - z[99] * z[635])
    z[816] = z[91] * (((u10 + u8) - u3) - u9)
    z[880] = mrf * (((((((((2 * z[785] + z[99] * z[651] + 2 * z[593] * z[527] + 2 * z[595] * z[484] + 2 * z[812] * z[647] + 2 * z[813] * z[691] + 2 * z[814] * z[726]) - 2 * z[95] * z[108]) - 2 * z[97] * z[575]) - 2 * z[97] * z[800]) - 2 * z[102] * z[753]) - 2 * z[102] * z[836]) - 2 * z[103] * z[774]) - 2 * z[786] * z[7]) - 2 * z[815] * z[11])
    z[819] = lsh * u9 + z[216] * u7 + z[217] * u1 + z[218] * u2 + z[219] * u6 + z[221] * u5 + z[222] * u4 + z[226] * u3 + z[227] * u8
    z[109] = z[1] * z[62] + z[2] * z[63]
    z[577] = z[12] * z[567] - z[11] * z[569]
    z[802] = z[12] * z[792] - z[11] * z[794]
    z[755] = z[12] * z[745] - z[11] * z[747]
    z[111] = z[1] * z[63] - z[2] * z[62]
    z[837] = z[20] * z[111] - z[19] * z[109]
    z[776] = -(z[11]) * z[16] - z[12] * z[15]
    z[529] = z[12] * z[519] - z[11] * z[521]
    z[649] = z[12] * z[631] - z[11] * z[633]
    z[693] = z[12] * z[683] - z[11] * z[685]
    z[728] = z[8] * z[189] - z[7] * z[190]
    z[653] = z[12] * z[635] - z[11] * z[637]
    z[881] = mrf * (((((((((2 * z[95] * z[109] + 2 * z[97] * z[577] + 2 * z[97] * z[802] + 2 * z[102] * z[755] + 2 * z[102] * z[837] + 2 * z[103] * z[776]) - 2 * z[593] * z[529]) - 2 * z[595] * z[485]) - 2 * z[786] * z[8]) - 2 * z[812] * z[649]) - 2 * z[813] * z[693]) - 2 * z[814] * z[728]) - 2 * z[815] * z[12]) - z[99] * z[653])
    z[818] = z[208] * u8 + z[209] * u7 + z[210] * u1 + z[211] * u2 + z[212] * u6 + z[213] * u5 + z[214] * u4 + z[215] * u3
    z[488] = iua * lsp
    z[490] = iua * rsp
    z[496] = ((((((((((z[106] * z[4] + z[493] * z[6] + 0.5 * z[99] * z[149] + 0.5 * z[99] * z[230]) - z[102] * z[20]) - z[102] * z[22]) - z[97] * z[139]) - z[97] * z[145]) - z[103] * z[126]) - z[104] * z[116]) - z[105] * z[110]) - z[491] * z[131]) - z[492] * z[33]) - 0.5 * z[494] * z[121]
    z[855] = mhat * z[496]
    z[497] = z[281] * u7 + z[282] * u1 + z[283] * u2 + z[284] * u6 + z[285] * u3 + z[286] * u5 + z[287] * u4
    z[540] = ((((((((((z[100] * z[31] + z[101] * z[504] + 0.5 * z[99] * z[483] + 0.5 * z[99] * z[524]) - z[95] * z[130]) - z[97] * z[500]) - z[97] * z[516]) - z[102] * z[508]) - z[102] * z[536]) - z[103] * z[512]) - z[104] * z[520]) - z[105] * z[528]) - z[106] * z[532]) - 0.5 * z[98] * z[18]
    z[857] = mff * z[540]
    z[88] = z[26] * z[83] - z[25] * z[85]
    z[144] = z[1] * z[88] + z[2] * z[89]
    z[501] = z[39] * z[88] + z[40] * z[89]
    z[502] = z[41] * z[88] + z[42] * z[89]
    z[544] = -(z[17]) * z[501] - z[18] * z[502]
    z[546] = z[18] * z[501] - z[17] * z[502]
    z[548] = z[27] * z[544] + z[28] * z[546]
    z[560] = z[72] * z[88] + z[73] * z[89]
    z[562] = z[74] * z[88] + z[75] * z[89]
    z[568] = -(z[15]) * z[560] - z[16] * z[562]
    z[570] = z[16] * z[560] - z[15] * z[562]
    z[572] = z[27] * z[568] + z[28] * z[570]
    z[564] = z[79] * z[88] + z[80] * z[89]
    z[146] = z[1] * z[89] - z[2] * z[88]
    z[584] = z[20] * z[146] - z[19] * z[144]
    z[576] = -(z[11]) * z[568] - z[12] * z[570]
    z[580] = z[3] * z[144] - z[4] * z[146]
    z[552] = -(z[13]) * z[544] - z[14] * z[546]
    z[556] = z[5] * z[144] - z[6] * z[146]
    z[590] = ((((((((((z[588] * z[26] + z[587] * z[144] + 0.5 * z[99] * z[548] + 0.5 * z[99] * z[572]) - z[97] * z[564]) - z[102] * z[584]) - z[103] * z[560]) - z[104] * z[568]) - z[105] * z[576]) - z[106] * z[580]) - z[491] * z[501]) - z[492] * z[552]) - z[493] * z[556]) - 0.5 * z[494] * z[544]
    z[859] = mla * z[590]
    z[591] = (z[368] + z[361] * u7 + z[362] * u1 + z[363] * u2 + z[364] * u6 + z[365] * u5 + z[366] * u4 + z[367] * u3) - z[360] * u13
    z[676] = z[37] * z[72] + z[38] * z[73]
    z[678] = z[37] * z[74] + z[38] * z[75]
    z[684] = -(z[15]) * z[676] - z[16] * z[678]
    z[686] = z[16] * z[676] - z[15] * z[678]
    z[688] = z[27] * z[684] + z[28] * z[686]
    z[553] = z[14] * z[543] - z[13] * z[545]
    z[680] = z[37] * z[79] + z[38] * z[80]
    z[672] = z[22] * z[32] - z[21] * z[34]
    z[700] = z[20] * z[32] - z[19] * z[34]
    z[692] = -(z[11]) * z[684] - z[12] * z[686]
    z[696] = z[3] * z[34] - z[4] * z[32]
    z[704] = (((((((((((z[101] * z[10] + 0.5 * z[99] * z[44] + 0.5 * z[99] * z[688]) - z[95] * z[34]) - z[97] * z[553]) - z[97] * z[680]) - z[102] * z[672]) - z[102] * z[700]) - z[103] * z[676]) - z[104] * z[684]) - z[105] * z[692]) - z[106] * z[696]) - z[491] * z[30]) - 0.5 * z[494] * z[14]
    z[867] = msh * z[704]
    z[705] = z[159] * u4 + z[159] * u6 + z[160] * u7 + z[161] * u3 + z[161] * u5 + z[162] * u1 + z[163] * u2
    z[605] = z[5] * z[149] + z[6] * z[147]
    z[56] = z[1] * z[6] - z[2] * z[5]
    z[711] = z[54] * z[73] + z[56] * z[72]
    z[713] = z[54] * z[75] + z[56] * z[74]
    z[719] = -(z[15]) * z[711] - z[16] * z[713]
    z[721] = z[16] * z[711] - z[15] * z[713]
    z[723] = z[27] * z[719] + z[28] * z[721]
    z[557] = z[5] * z[145] + z[6] * z[143]
    z[715] = z[54] * z[80] + z[56] * z[79]
    z[708] = z[22] * z[5] - z[21] * z[6]
    z[731] = z[20] * z[5] - z[19] * z[6]
    z[727] = -(z[7]) * z[191] - z[8] * z[189]
    z[505] = z[5] * z[131] + z[6] * z[129]
    z[601] = z[5] * z[121] + z[6] * z[119]
    z[734] = (((((((((((z[492] * z[10] + 0.5 * z[99] * z[605] + 0.5 * z[99] * z[723]) - z[95] * z[6]) - z[97] * z[557]) - z[97] * z[715]) - z[102] * z[708]) - z[102] * z[731]) - z[103] * z[711]) - z[104] * z[719]) - z[105] * z[727]) - z[106] * z[191]) - z[491] * z[505]) - 0.5 * z[494] * z[601]
    z[869] = mth * z[734]
    z[735] = z[173] * u7 + z[174] * u1 + z[175] * u2 + z[176] * u6 + z[177] * u3 + z[177] * u5 + z[178] * u4
    z[613] = -(z[21]) * z[149] - z[22] * z[147]
    z[738] = z[72] * z[85] + z[73] * z[83]
    z[740] = z[74] * z[85] + z[75] * z[83]
    z[746] = -(z[15]) * z[738] - z[16] * z[740]
    z[748] = z[16] * z[738] - z[15] * z[740]
    z[750] = z[27] * z[746] + z[28] * z[748]
    z[761] = z[19] * z[22] - z[20] * z[21]
    z[742] = z[79] * z[85] + z[80] * z[83]
    z[754] = -(z[11]) * z[746] - z[12] * z[748]
    z[758] = z[21] * z[4] - z[22] * z[3]
    z[509] = -(z[21]) * z[131] - z[22] * z[129]
    z[673] = -(z[21]) * z[33] - z[22] * z[32]
    z[709] = z[21] * z[6] - z[22] * z[5]
    z[609] = -(z[21]) * z[121] - z[22] * z[119]
    z[764] = (((((((((((z[97] * z[26] + 0.5 * z[99] * z[613] + 0.5 * z[99] * z[750]) - z[102] * z[761]) - z[587] * z[22]) - z[97] * z[742]) - z[103] * z[738]) - z[104] * z[746]) - z[105] * z[754]) - z[106] * z[758]) - z[491] * z[509]) - z[492] * z[673]) - z[493] * z[709]) - 0.5 * z[494] * z[609]
    z[871] = mua * z[764]
    z[765] = z[342] * u7 + z[343] * u1 + z[344] * u2 + z[345] * u6 + z[346] * u5 + z[347] * u4 + z[348] * u3
    z[775] = z[11] * z[16] + z[12] * z[15]
    z[125] = z[1] * z[74] + z[2] * z[75]
    z[127] = z[1] * z[75] - z[2] * z[74]
    z[778] = z[3] * z[125] - z[4] * z[127]
    z[772] = -(z[27]) * z[16] - z[28] * z[15]
    z[782] = z[20] * z[127] - z[19] * z[125]
    z[789] = ((((((((((z[785] * z[775] + z[786] * z[778] + 0.5 * z[99] * z[621] + 0.5 * z[99] * z[772]) - z[95] * z[125]) - z[97] * z[561]) - z[97] * z[768]) - z[102] * z[739]) - z[102] * z[782]) - z[491] * z[513]) - z[492] * z[677]) - z[493] * z[712]) - z[787] * z[16]) - 0.5 * z[494] * z[617]
    z[873] = mff * z[789]
    z[790] = (z[253] * u9 + z[254] * u7 + z[255] * u1 + z[256] * u2 + z[257] * u6 + z[258] * u5 + z[259] * u4 + z[260] * u3 + z[261] * u8) - z[262] * u10
    z[81] = z[24] * z[76] - z[23] * z[78]
    z[138] = z[1] * z[81] + z[2] * z[82]
    z[629] = z[46] * z[81] + z[47] * z[82]
    z[769] = z[72] * z[81] + z[73] * z[82]
    z[770] = z[74] * z[81] + z[75] * z[82]
    z[793] = -(z[15]) * z[769] - z[16] * z[770]
    z[795] = z[16] * z[769] - z[15] * z[770]
    z[797] = z[27] * z[793] + z[28] * z[795]
    z[565] = z[81] * z[86] + z[82] * z[87]
    z[743] = z[81] * z[83] + z[82] * z[84]
    z[801] = -(z[11]) * z[793] - z[12] * z[795]
    z[140] = z[1] * z[82] - z[2] * z[81]
    z[805] = z[3] * z[138] - z[4] * z[140]
    z[517] = z[39] * z[81] + z[40] * z[82]
    z[681] = z[35] * z[81] + z[36] * z[82]
    z[716] = z[54] * z[81] + z[55] * z[82]
    z[625] = z[50] * z[81] + z[51] * z[82]
    z[809] = ((((((((((z[588] * z[24] + z[587] * z[138] + 0.5 * z[99] * z[629] + 0.5 * z[99] * z[797]) - z[97] * z[565]) - z[102] * z[743]) - z[103] * z[769]) - z[104] * z[793]) - z[105] * z[801]) - z[106] * z[805]) - z[491] * z[517]) - z[492] * z[681]) - z[493] * z[716]) - 0.5 * z[494] * z[625]
    z[875] = mla * z[809]
    z[810] = (z[323] + z[316] * u7 + z[317] * u1 + z[318] * u2 + z[319] * u6 + z[320] * u5 + z[321] * u4 + z[322] * u3) - z[315] * u12
    z[841] = (((((((((((z[786] * z[8] + 0.5 * z[99] * z[485] + 0.5 * z[99] * z[653]) - z[95] * z[109]) - z[97] * z[577]) - z[97] * z[802]) - z[102] * z[755]) - z[102] * z[837]) - z[103] * z[776]) - z[104] * z[12]) - z[491] * z[529]) - z[492] * z[693]) - z[493] * z[728]) - 0.5 * z[494] * z[649]
    z[883] = msh * z[841]
    z[661] = z[3] * z[149] + z[4] * z[147]
    z[826] = z[3] * z[230] + z[4] * z[228]
    z[581] = z[3] * z[145] + z[4] * z[143]
    z[806] = z[3] * z[139] + z[4] * z[137]
    z[759] = z[22] * z[3] - z[21] * z[4]
    z[844] = z[20] * z[3] - z[19] * z[4]
    z[779] = z[3] * z[126] + z[4] * z[124]
    z[822] = z[3] * z[116] + z[4] * z[114]
    z[533] = z[3] * z[131] + z[4] * z[129]
    z[697] = z[3] * z[33] + z[4] * z[32]
    z[657] = z[3] * z[121] + z[4] * z[119]
    z[847] = (((((((((((z[105] * z[8] + 0.5 * z[99] * z[661] + 0.5 * z[99] * z[826]) - z[95] * z[4]) - z[97] * z[581]) - z[97] * z[806]) - z[102] * z[759]) - z[102] * z[844]) - z[103] * z[779]) - z[104] * z[822]) - z[491] * z[533]) - z[492] * z[697]) - z[493] * z[190]) - 0.5 * z[494] * z[657]
    z[885] = mth * z[847]
    z[848] = z[192] * u7 + z[193] * u1 + z[194] * u2 + z[195] * u6 + z[196] * u3 + z[197] * u5 + z[198] * u4
    z[669] = -(z[19]) * z[149] - z[20] * z[147]
    z[834] = -(z[19]) * z[230] - z[20] * z[228]
    z[762] = z[20] * z[21] - z[19] * z[22]
    z[585] = -(z[19]) * z[145] - z[20] * z[143]
    z[783] = -(z[19]) * z[126] - z[20] * z[124]
    z[830] = -(z[19]) * z[116] - z[20] * z[114]
    z[838] = -(z[19]) * z[110] - z[20] * z[108]
    z[845] = z[19] * z[4] - z[20] * z[3]
    z[537] = -(z[19]) * z[131] - z[20] * z[129]
    z[701] = -(z[19]) * z[33] - z[20] * z[32]
    z[732] = z[19] * z[6] - z[20] * z[5]
    z[665] = -(z[19]) * z[121] - z[20] * z[119]
    z[851] = (((((((((((z[97] * z[24] + 0.5 * z[99] * z[669] + 0.5 * z[99] * z[834]) - z[102] * z[762]) - z[587] * z[20]) - z[97] * z[585]) - z[103] * z[783]) - z[104] * z[830]) - z[105] * z[838]) - z[106] * z[845]) - z[491] * z[537]) - z[492] * z[701]) - z[493] * z[732]) - 0.5 * z[494] * z[665]
    z[887] = mua * z[851]
    z[852] = z[297] * u7 + z[298] * u1 + z[299] * u2 + z[300] * u6 + z[301] * u5 + z[302] * u4 + z[303] * u3
    z[860] = mrf * ((((((2 * z[95] * z[129] + 2 * z[97] * z[499] + 2 * z[97] * z[515] + 2 * z[102] * z[507] + 2 * z[102] * z[535] + 2 * z[103] * z[511] + 2 * z[104] * z[519] + 2 * z[105] * z[527] + 2 * z[106] * z[531] + 2 * z[594] * z[17]) - 2 * z[593]) - 2 * z[100] * z[29]) - 2 * z[101] * z[503]) - 2 * z[595] * z[481]) - z[99] * z[523])
    z[596] = ((lff * u4 + lff * u6 + lff * u7 + z[41] * u1 + z[42] * u2) - lff * u3) - lff * u5
    z[639] = z[27] * z[631] + z[28] * z[633]
    z[863] = mrf * ((((((((((((z[862] + z[99] * z[639] + 2 * z[101] * z[599]) - 2 * z[95] * z[119]) - 2 * z[97] * z[543]) - 2 * z[97] * z[623]) - 2 * z[100] * z[13]) - 2 * z[102] * z[607]) - 2 * z[102] * z[663]) - 2 * z[103] * z[615]) - 2 * z[104] * z[631]) - 2 * z[105] * z[647]) - 2 * z[106] * z[655]) - 2 * z[593] * z[17])
    z[597] = lrfo * (((u3 + u5) - u4) - u6)
    z[879] = mrf * ((((((((((2 * z[95] * z[228] + 2 * z[97] * z[571] + 2 * z[97] * z[796] + 2 * z[102] * z[749] + 2 * z[102] * z[832] + 2 * z[103] * z[771]) - 2 * z[595]) - 2 * z[878]) - 2 * z[593] * z[523]) - 2 * z[785] * z[484]) - 2 * z[786] * z[824]) - 2 * z[812] * z[639]) - 2 * z[813] * z[687]) - 2 * z[814] * z[722]) - z[99] * z[643])
    z[817] = lrffo * (((u10 + u8) - u3) - u9)
    z[70] = z[27] * z[66] - z[28] * z[64]
    z[902] = mff * z[39]
    z[903] = mff * z[40]
    z[926] = mrf * z[39]
    z[927] = mrf * z[40]
    z[888] = mhat * z[281]
    z[889] = mhat * z[282]
    z[890] = mhat * z[283]
    z[891] = mhat * z[284]
    z[892] = mhat * z[285]
    z[893] = mhat * z[286]
    z[894] = mhat * z[287]
    z[933] = msh * z[159]
    z[934] = msh * z[160]
    z[935] = msh * z[161]
    z[936] = msh * z[162]
    z[937] = msh * z[163]
    z[938] = msh * z[164]
    z[939] = msh * z[165]
    z[940] = msh * z[166]
    z[941] = msh * z[168]
    z[942] = msh * z[169]
    z[943] = msh * z[170]
    z[944] = mth * z[173]
    z[945] = mth * z[174]
    z[946] = mth * z[175]
    z[947] = mth * z[176]
    z[948] = mth * z[177]
    z[949] = mth * z[178]
    z[950] = mth * z[179]
    z[951] = mth * z[180]
    z[952] = mth * z[181]
    z[953] = mth * z[182]
    z[954] = mth * z[183]
    z[955] = mth * z[185]
    z[956] = mth * z[186]
    z[1047] = mth * z[192]
    z[1048] = mth * z[193]
    z[1049] = mth * z[194]
    z[1050] = mth * z[195]
    z[1051] = mth * z[196]
    z[1052] = mth * z[197]
    z[1053] = mth * z[198]
    z[1062] = mua * z[297]
    z[1063] = mua * z[298]
    z[1064] = mua * z[299]
    z[1065] = mua * z[300]
    z[1066] = mua * z[301]
    z[1067] = mua * z[302]
    z[1068] = mua * z[303]
    z[957] = mua * z[342]
    z[958] = mua * z[343]
    z[959] = mua * z[344]
    z[960] = mua * z[345]
    z[961] = mua * z[346]
    z[962] = mua * z[347]
    z[963] = mua * z[348]
    z[1011] = mla * z[337]
    z[1003] = mla * z[335]
    z[1004] = mla * z[324]
    z[1005] = mla * z[325]
    z[1006] = mla * z[326]
    z[1007] = mla * z[327]
    z[1008] = mla * z[328]
    z[1009] = mla * z[329]
    z[1010] = mla * z[336]
    z[925] = mla * z[382]
    z[917] = mla * z[380]
    z[918] = mla * z[369]
    z[919] = mla * z[370]
    z[920] = mla * z[371]
    z[921] = mla * z[372]
    z[922] = mla * z[373]
    z[923] = mla * z[374]
    z[924] = mla * z[381]
    z[973] = mff * z[253]
    z[974] = mff * z[254]
    z[975] = mff * z[255]
    z[976] = mff * z[256]
    z[977] = mff * z[257]
    z[978] = mff * z[258]
    z[979] = mff * z[259]
    z[980] = mff * z[260]
    z[981] = mff * z[261]
    z[982] = mff * z[262]
    z[1013] = mrf * z[208]
    z[1014] = mrf * z[209]
    z[1015] = mrf * z[210]
    z[1016] = mrf * z[211]
    z[1017] = mrf * z[212]
    z[1018] = mrf * z[213]
    z[1019] = mrf * z[214]
    z[1020] = mrf * z[215]
    z[1030] = msh * z[208]
    z[1031] = msh * z[209]
    z[1032] = msh * z[210]
    z[1033] = msh * z[211]
    z[1034] = msh * z[212]
    z[1035] = msh * z[213]
    z[1036] = msh * z[214]
    z[1037] = msh * z[215]
    z[1022] = mrf * z[216]
    z[1023] = mrf * z[217]
    z[1024] = mrf * z[218]
    z[1025] = mrf * z[219]
    z[1026] = mrf * z[221]
    z[1027] = mrf * z[222]
    z[1028] = mrf * z[226]
    z[1029] = mrf * z[227]
    z[1039] = msh * z[216]
    z[1040] = msh * z[217]
    z[1041] = msh * z[218]
    z[1042] = msh * z[219]
    z[1043] = msh * z[221]
    z[1044] = msh * z[222]
    z[1045] = msh * z[224]
    z[1046] = msh * z[225]
    z[52] = -(z[13]) * z[37] - z[14] * z[35]
    z[48] = z[35] * z[45] + z[37] * z[43]
    z[895] = mhat * z[288]
    z[896] = mhat * z[289]
    z[897] = mhat * z[290]
    z[898] = mhat * z[291]
    z[899] = mhat * z[292]
    z[900] = mhat * z[294]
    z[901] = mhat * z[295]
    z[1054] = mth * z[199]
    z[1055] = mth * z[200]
    z[1056] = mth * z[201]
    z[1057] = mth * z[202]
    z[1058] = mth * z[203]
    z[1059] = mth * z[205]
    z[1060] = mth * z[206]
    z[1076] = mua * z[311]
    z[1069] = mua * z[304]
    z[1070] = mua * z[305]
    z[1071] = mua * z[306]
    z[1072] = mua * z[307]
    z[1073] = mua * z[308]
    z[1074] = mua * z[309]
    z[1075] = mua * z[312]
    z[1001] = mla * z[315]
    z[1002] = mla * z[323]
    z[994] = mla * z[316]
    z[995] = mla * z[317]
    z[996] = mla * z[318]
    z[997] = mla * z[319]
    z[998] = mla * z[320]
    z[999] = mla * z[321]
    z[1000] = mla * z[322]
    z[972] = mua * z[356]
    z[965] = mua * z[349]
    z[966] = mua * z[350]
    z[967] = mua * z[351]
    z[968] = mua * z[352]
    z[969] = mua * z[353]
    z[970] = mua * z[354]
    z[971] = mua * z[357]
    z[914] = mla * z[360]
    z[915] = mla * z[368]
    z[907] = mla * z[361]
    z[908] = mla * z[362]
    z[909] = mla * z[363]
    z[910] = mla * z[364]
    z[911] = mla * z[365]
    z[912] = mla * z[366]
    z[913] = mla * z[367]
    z[983] = mff * z[264]
    z[984] = mff * z[265]
    z[985] = mff * z[266]
    z[986] = mff * z[267]
    z[987] = mff * z[268]
    z[988] = mff * z[269]
    z[989] = mff * z[273]
    z[990] = mff * z[274]
    z[991] = mff * z[275]
    z[992] = mff * z[276]
    z[905] = mff * z[41]
    z[906] = mff * z[42]
    z[929] = mrf * z[41]
    z[930] = mrf * z[42]
    z[1230] = ((z[1112] + z[964] * z[433]) - z[1116]) - mla * (z[315] * z[441] - z[335] * z[442])
    z[1270] = (z[465] * (z[315] * z[80] - z[335] * z[82]) + z[1230]) - z[1093] * z[76]
    z[1223] = (z[1222] + z[964] * z[312]) - mla * (z[315] * z[322] - z[335] * z[336])
    z[1224] = z[964] * z[304] - mla * (z[315] * z[316] - z[335] * z[324])
    z[1225] = z[964] * z[305] - mla * (z[315] * z[317] - z[335] * z[325])
    z[1226] = z[964] * z[306] - mla * (z[315] * z[318] - z[335] * z[326])
    z[1227] = z[964] * z[307] - mla * (z[315] * z[319] - z[335] * z[327])
    z[1228] = z[964] * z[308] - mla * (z[315] * z[320] - z[335] * z[328])
    z[1229] = z[964] * z[309] - mla * (z[315] * z[321] - z[335] * z[329])
    z[1238] = ((z[1102] + z[964] * z[450]) - z[1110]) - mla * (z[360] * z[458] - z[380] * z[459])
    z[1271] = (z[465] * (z[360] * z[87] - z[380] * z[89]) + z[1238]) - z[1093] * z[83]
    z[1231] = (z[1222] + z[964] * z[357]) - mla * (z[360] * z[367] - z[380] * z[381])
    z[1232] = z[964] * z[349] - mla * (z[360] * z[361] - z[380] * z[369])
    z[1233] = z[964] * z[350] - mla * (z[360] * z[362] - z[380] * z[370])
    z[1234] = z[964] * z[351] - mla * (z[360] * z[363] - z[380] * z[371])
    z[1235] = z[964] * z[352] - mla * (z[360] * z[364] - z[380] * z[372])
    z[1236] = z[964] * z[353] - mla * (z[360] * z[365] - z[380] * z[373])
    z[1237] = z[964] * z[354] - mla * (z[360] * z[366] - z[380] * z[374])
    z[1097] = z[1096] * z[82]
    z[1246] = z[1112] + z[916] * z[442]
    z[1268] = z[1097] - z[1246]
    z[1239] = ila + z[916] * z[336]
    z[1240] = z[916] * z[324]
    z[1241] = z[916] * z[325]
    z[1242] = z[916] * z[326]
    z[1243] = z[916] * z[327]
    z[1244] = z[916] * z[328]
    z[1245] = z[916] * z[329]
    z[1098] = z[1096] * z[89]
    z[1254] = z[1102] + z[916] * z[459]
    z[1269] = z[1098] - z[1254]
    z[1247] = ila + z[916] * z[381]
    z[1248] = z[916] * z[369]
    z[1249] = z[916] * z[370]
    z[1250] = z[916] * z[371]
    z[1251] = z[916] * z[372]
    z[1252] = z[916] * z[373]
    z[1253] = z[916] * z[374]
    z[387] = z[97] * (lep - lsp)
    z[388] = z[102] * lsp
    z[389] = z[97] * (rep - rsp)
    z[390] = z[102] * rsp

end

function pop2x(sol, t)
    @unpack z, lff = sol.prob.p
    @inbounds q1, q2 = sol(t)

    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q1 - lff * z[39]
end

pop2x(sol) = [pop2x(sol, t) for t in sol.t]

function pop2y(sol, t)
    @unpack z, lff = sol.prob.p
    @inbounds q1, q2 = sol(t)

    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q2 - lff * z[40]
end

pop2y(sol) = [pop2y(sol, t) for t in sol.t]


function pop10x(sol, t)
    @unpack z, lff, lrf, lsh, lth, = sol.prob.p
    @inbounds q1, q2 = sol(t)

    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q1 + lrf * z[64] + lsh * z[60] + lth * z[57] - lff * z[39] - lrf * z[50] - lsh * z[35] - lth * z[54]
end

pop10x(sol) = [pop10x(sol, t) for t in sol.t]

function pop10y(sol, t)
    @unpack z, lff, lrf, lsh, lth, = sol.prob.p
    @inbounds q1, q2 = sol(t)

    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q2 + lrf * z[65] + lsh * z[61] + lth * z[58] - lff * z[40] - lrf * z[51] - lsh * z[36] - lth * z[55]
end

pop10y(sol) = [pop10y(sol, t) for t in sol.t]

function pop11x(sol, t)
    @unpack z, lff, lrf, lsh, lth, = sol.prob.p
    @inbounds q1, q2 = sol(t)

    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q1 + lff * z[72] + lrf * z[64] + lsh * z[60] + lth * z[57] - lff * z[39] - lrf * z[50] - lsh * z[35] - lth * z[54]
end

pop11x(sol) = [pop11x(sol, t) for t in sol.t]

function pop11y(sol, t)
    @unpack z, lff, lrf, lsh, lth, = sol.prob.p
    @inbounds q1, q2 = sol(t)

    # set z array values
    eom(sol(t), sol.prob.p, t)
    io(sol, t)

    return q2 + lff * z[73] + lrf * z[65] + lsh * z[61] + lth * z[58] - lff * z[40] - lrf * z[51] - lsh * z[36] - lth * z[55]
end

pop11y(sol) = [pop11y(sol, t) for t in sol.t]

function pop10y(u, p, t)
    @unpack lff, lrf, lsh, lth = p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, = u
    return q2 + lth * sin(q3 - q8) + lsh * sin(q8 - q3 - q9) + lff * sin(q3 + q5 - q4 - q6 - q7) - lth * sin(q3 - q4) - lsh * sin(q4 - q3 - q5) - lrf * sin(q10 + q8 - q3 - q9) - lrf * sin(q3 + q5 - q4 - q6)

end

function pop11y(u, p, t)
    @unpack lff, lrf, lsh, lth = p
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11 = u

    return q2 + lth * sin(q3 - q8) + lsh * sin(q8 - q3 - q9) + lff * sin(q10 + q11 + q8 - q3 - q9) + lff * sin(q3 + q5 - q4 - q6 - q7) - lth * sin(q3 - q4) - lsh * sin(q4 - q3 - q5) - lrf * sin(q10 + q8 - q3 - q9) - lrf * sin(q3 + q5 - q4 - q6)
end

rx1(sol, t) = contact_forces(sol(t), sol.prob.p, t)[1]
ry1(sol, t) = contact_forces(sol(t), sol.prob.p, t)[2]
rx2(sol, t) = contact_forces(sol(t), sol.prob.p, t)[3]
ry2(sol, t) = contact_forces(sol(t), sol.prob.p, t)[4]

rx(sol, t) = rx1(sol, t) + rx2(sol, t)
ry(sol, t) = ry1(sol, t) + ry2(sol, t)



function getTorque(sol, t)
    @inbounds θlhe, θlke, θlae, θlhf, θlkf, θlaf, θrhe, θrke, θrae, θrhf, θrkf, θraf = sol(t, idxs=23:34)
    @unpack lhe, lke, lae, lhf, lkf, laf, rhe, rke, rae, rhf, rkf, raf = sol.prob.p

    lτhe = torque(lhe, θhe)
    lτke = torque(lke, θke)
    lτae = torque(lae, θae)
    lτhf = torque(lhf, θhf)
    lτkf = torque(lkf, θkf)
    lτaf = torque(laf, θaf)

    rτhe = torque(rhe, θhe)
    rτke = torque(rke, θke)
    rτae = torque(rae, θae)
    rτhf = torque(rhf, θhf)
    rτkf = torque(rkf, θkf)
    rτaf = torque(raf, θaf)

    return lτhe, lτke, lτae, lτhf, lτkf, lτaf, rτhe, rτke, rτae, rτhf, rτkf, rτaf
end

getTorque(sol) = reduce(hcat, [[getTorque(sol, t)...] for t in sol.t])'


function get_torque_generator(sol, t)
    @inbounds q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11, θlhe, θlke, θlae, θlhf, θlkf, θlaf, θrhe, θrke, θrae, θrhf, θrkf, θraf = sol(t)
    @unpack lhe, lke, lae, lhf, lkf, laf, rhe, rke, rae, rhf, rkf, raf = sol.prob.p

    # get values from torque generators 
    d_lhetor = get_torque_generator(lhe, t, 2π - q4, -u4, θlhe)
    d_lketor = get_torque_generator(lke, t, 2π - q5, -u5, θlke)
    d_laetor = get_torque_generator(lae, t, 2π - q6, -u6, θlae)
    d_lhftor = get_torque_generator(lhf, t, q4, u4, θlhf)
    d_lkftor = get_torque_generator(lkf, t, q5, u5, θlkf)
    d_laftor = get_torque_generator(laf, t, q6, u6, θlaf)

    d_rhetor = get_torque_generator(rhe, t, 2π - q8, -u8, θrhe)
    d_rketor = get_torque_generator(rke, t, 2π - q9, -u9, θrke)
    d_raetor = get_torque_generator(rae, t, 2π - q10, -u10, θrae)
    d_rhftor = get_torque_generator(rhf, t, q8, u8, θrhf)
    d_rkftor = get_torque_generator(rkf, t, q9, u9, θrkf)
    d_raftor = get_torque_generator(raf, t, q10, u10, θraf)

    # # CC torque relevant values
    ds = [d_lhetor, d_lketor, d_laetor, d_lhftor, d_lkftor, d_laftor, d_rhetor, d_rketor, d_raetor, d_rhftor, d_rkftor, d_raftor]
    # out = map(ds) do d
    #     α = d[:cc][:α]
    #     τ_θ = d[:cc][:τ_θ]
    #     τ_ω = d[:cc][:τ_ω]
    #     τnorm = α * τ_θ * τ_ω
    #     τ = d[:cc][:τ]

    #     return [α, τ_θ, τ_ω, τnorm, τ]
    # end

    # return out
end

get_torque_generator(sol) = [get_torque_generator(sol, t) for t in sol.t]
