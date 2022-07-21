# Automatically generated
function kecm(sol, t)
    @unpack z, ihat, ith, u5, u4, iua, u11, u10, ila, u13, u12, ish, u7, u6, irf, u9, u8, iff, mff, lffo, mhat, msh, mth, mua, luao, mla, llao, mrf, lrfo, lrffo, lff, lsh = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)
    lhp, rhp, lsp, rsp, lep, rep, lkp, rkp, lap, rap, lmtpp, rmtpp = _lhp(t), _rhp(t), _lsp(t), _rsp(t), _lep(t), _rep(t), _lkp(t), _rkp(t), _lap(t), _rap(t), _lmtpp(t), _rmtpp(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((0.5 * ihat * u3^2 + 0.5 * ith * ((lhp - u3) - u5)^2 + 0.5 * ith * ((rhp - u3) - u4)^2 + 0.5 * iua * ((lsp - u11) - u3)^2 + 0.5 * iua * ((rsp - u10) - u3)^2 + 0.5 * ila * ((((lsp - lep) - u11) - u13) - u3)^2 + 0.5 * ila * ((((rsp - rep) - u10) - u12) - u3)^2 + 0.5 * ish * ((((lhp - lkp) - u3) - u5) - u7)^2 + 0.5 * ish * ((((rhp - rkp) - u3) - u4) - u6)^2 + 0.5 * irf * ((((((lap + lhp) - lkp) - u3) - u5) - u7) - u9)^2 + 0.5 * irf * ((((((rap + rhp) - rkp) - u3) - u4) - u6) - u8)^2 + 0.5 * iff * ((((((lap + lhp + lmtpp) - lkp) - u3) - u5) - u7) - u9)^2 + 0.5 * iff * ((((((rap + rhp + rmtpp) - rkp) - u3) - u4) - u6) - u8)^2 + 0.5 * mff * ((z[39] * u1 + z[40] * u2)^2 + (((z[156] + lffo * u3 + lffo * u5 + lffo * u7 + lffo * u9) - z[41] * u1) - z[42] * u2)^2) + 0.5 * mhat * ((z[321] + z[316] * u9 + z[317] * u3 + z[317] * u5 + z[318] * u7 + z[319] * u1 + z[320] * u2)^2 + (z[327] + z[322] * u9 + z[323] * u7 + z[324] * u5 + z[328] * u3 + z[325] * u1 + z[326] * u2)^2) + 0.5 * msh * ((z[179] + z[176] * u3 + z[176] * u5 + z[176] * u7 + z[176] * u9 + z[177] * u1 + z[178] * u2)^2 + (z[187] + z[180] * u9 + z[186] * u3 + z[186] * u5 + z[186] * u7 + z[181] * u1 + z[182] * u2)^2) + 0.5 * mth * ((z[195] + z[191] * u9 + z[192] * u3 + z[192] * u5 + z[192] * u7 + z[193] * u1 + z[194] * u2)^2 + (z[203] + z[196] * u9 + z[197] * u7 + z[202] * u3 + z[202] * u5 + z[198] * u1 + z[199] * u2)^2) + 0.5 * mth * ((z[215] + z[210] * u9 + z[211] * u3 + z[211] * u5 + z[212] * u7 + z[213] * u1 + z[214] * u2)^2 + (z[224] + z[93] * u4 + z[216] * u9 + z[217] * u7 + z[218] * u5 + z[223] * u3 + z[219] * u1 + z[220] * u2)^2) + 0.5 * mua * ((z[336] + z[330] * u9 + z[331] * u7 + z[332] * u5 + z[333] * u3 + z[334] * u1 + z[335] * u2)^2 + (z[346] + luao * u10 + z[337] * u9 + z[338] * u7 + z[339] * u5 + z[345] * u3 + z[341] * u1 + z[342] * u2)^2) + 0.5 * mua * ((z[381] + z[375] * u9 + z[376] * u7 + z[377] * u5 + z[378] * u3 + z[379] * u1 + z[380] * u2)^2 + (z[391] + luao * u11 + z[382] * u9 + z[383] * u7 + z[384] * u5 + z[390] * u3 + z[386] * u1 + z[387] * u2)^2) + 0.5 * mff * ((z[292] + z[283] * u8 + z[284] * u9 + z[285] * u5 + z[286] * u7 + z[287] * u3 + z[288] * u4 + z[289] * u6 + z[290] * u1 + z[291] * u2)^2 + (z[309] + z[294] * u9 + z[295] * u5 + z[296] * u7 + z[305] * u3 + z[306] * u4 + z[307] * u6 + z[308] * u8 + z[299] * u1 + z[300] * u2)^2) + 0.5 * mla * ((z[370] + llao * u12 + z[358] * u9 + z[359] * u7 + z[360] * u5 + z[368] * u10 + z[369] * u3 + z[362] * u1 + z[363] * u2)^2 + (((((((z[356] * u10 - z[357]) - z[350] * u9) - z[351] * u7) - z[352] * u5) - z[353] * u3) - z[354] * u1) - z[355] * u2)^2) + 0.5 * mla * ((z[415] + llao * u13 + z[403] * u9 + z[404] * u7 + z[405] * u5 + z[413] * u11 + z[414] * u3 + z[407] * u1 + z[408] * u2)^2 + (((((((z[401] * u11 - z[402]) - z[395] * u9) - z[396] * u7) - z[397] * u5) - z[398] * u3) - z[399] * u1) - z[400] * u2)^2) + 0.5 * msh * ((z[248] + z[92] * u6 + z[236] * u9 + z[238] * u5 + z[239] * u7 + z[246] * u3 + z[247] * u4 + z[240] * u1 + z[241] * u2)^2 + (((((((z[234] * u4 - z[235]) - z[228] * u9) - z[229] * u3) - z[230] * u5) - z[231] * u7) - z[232] * u1) - z[233] * u2)^2)) - 0.125 * mrf * (((((((4 * z[18] * (z[39] * u1 + z[40] * u2) * (z[163] + lrfo * u3 + lrfo * u5 + lrfo * u7 + lrfo * u9) + 4 * z[561] * (z[39] * u1 + z[40] * u2) * (z[164] + lrffo * u3 + lrffo * u5 + lrffo * u7 + lrffo * u9) + 4 * z[17] * (z[163] + lrfo * u3 + lrfo * u5 + lrfo * u7 + lrfo * u9) * (((z[157] + lff * u3 + lff * u5 + lff * u7 + lff * u9) - z[41] * u1) - z[42] * u2)) - 4 * (z[39] * u1 + z[40] * u2)^2) - (z[163] + lrfo * u3 + lrfo * u5 + lrfo * u7 + lrfo * u9)^2) - (z[164] + lrffo * u3 + lrffo * u5 + lrffo * u7 + lrffo * u9)^2) - 4 * (((z[157] + lff * u3 + lff * u5 + lff * u7 + lff * u9) - z[41] * u1) - z[42] * u2)^2) - 2 * z[27] * (z[163] + lrfo * u3 + lrfo * u5 + lrfo * u7 + lrfo * u9) * (z[164] + lrffo * u3 + lrffo * u5 + lrffo * u7 + lrffo * u9)) - 4 * z[560] * (z[164] + lrffo * u3 + lrffo * u5 + lrffo * u7 + lrffo * u9) * (((z[157] + lff * u3 + lff * u5 + lff * u7 + lff * u9) - z[41] * u1) - z[42] * u2))) - 0.125 * mrf * (((((((4 * z[27] * (z[258] + z[91] * u3 + z[91] * u4 + z[91] * u6 + z[91] * u8) * (z[259] + lrffo * u3 + lrffo * u4 + lrffo * u6 + lrffo * u8) + 4 * z[563] * (z[259] + lrffo * u3 + lrffo * u4 + lrffo * u6 + lrffo * u8) * (z[252] + lsh * u6 + z[236] * u9 + z[238] * u5 + z[239] * u7 + z[250] * u3 + z[251] * u4 + z[240] * u1 + z[241] * u2) + 8 * z[11] * (z[258] + z[91] * u3 + z[91] * u4 + z[91] * u6 + z[91] * u8) * (z[252] + lsh * u6 + z[236] * u9 + z[238] * u5 + z[239] * u7 + z[250] * u3 + z[251] * u4 + z[240] * u1 + z[241] * u2)) - 4 * (z[258] + z[91] * u3 + z[91] * u4 + z[91] * u6 + z[91] * u8)^2) - (z[259] + lrffo * u3 + lrffo * u4 + lrffo * u6 + lrffo * u8)^2) - 4 * (z[252] + lsh * u6 + z[236] * u9 + z[238] * u5 + z[239] * u7 + z[250] * u3 + z[251] * u4 + z[240] * u1 + z[241] * u2)^2) - 4 * (((((((z[234] * u4 - z[235]) - z[228] * u9) - z[229] * u3) - z[230] * u5) - z[231] * u7) - z[232] * u1) - z[233] * u2)^2) - 8 * z[12] * (z[258] + z[91] * u3 + z[91] * u4 + z[91] * u6 + z[91] * u8) * (((((((z[234] * u4 - z[235]) - z[228] * u9) - z[229] * u3) - z[230] * u5) - z[231] * u7) - z[232] * u1) - z[233] * u2)) - 4 * z[565] * (z[259] + lrffo * u3 + lrffo * u4 + lrffo * u6 + lrffo * u8) * (((((((z[234] * u4 - z[235]) - z[228] * u9) - z[229] * u3) - z[230] * u5) - z[231] * u7) - z[232] * u1) - z[233] * u2))
end

kecm(sol) = [kecm(sol, t) for t in sol.t]


function hz(sol, t)
    @unpack z, iff, u4, u5, u6, u7, u8, u9, ihat, ila, u10, u11, u12, u13, irf, ish, ith, iua = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((((((((((((((((((z[566] + z[567] + z[568] + z[569] + z[572] + z[573] + z[574] + z[575] + iff * u4 + iff * u5 + iff * u6 + iff * u7 + iff * u8 + iff * u9 + ihat * u3 + ila * u10 + ila * u11 + ila * u12 + ila * u13 + irf * u4 + irf * u5 + irf * u6 + irf * u7 + irf * u8 + irf * u9 + ish * u4 + ish * u5 + ish * u6 + ish * u7 + ith * u4 + ith * u5 + iua * u10 + iua * u11 + 2 * iff * u3 + 2 * ila * u3 + 2 * irf * u3 + 2 * ish * u3 + 2 * ith * u3 + 2 * iua * u3 + z[941] * z[585] + z[943] * z[629] + z[945] * z[679] + z[953] * z[793] + z[955] * z[823] + z[957] * z[853] + z[959] * z[878] + z[961] * z[898] + z[969] * z[929] + z[971] * z[936] + z[973] * z[940] + 0.5 * z[947] * z[683] + 0.5 * z[950] * z[684] + 0.5 * z[952] * z[685] + 0.5 * z[968] * z[905]) - z[570]) - z[571]) - z[576]) - z[577]) - z[942] * z[584]) - z[944] * z[628]) - z[946] * z[678]) - z[954] * z[792]) - z[956] * z[822]) - z[958] * z[852]) - z[960] * z[877]) - z[962] * z[897]) - z[970] * z[905]) - z[972] * z[935]) - z[974] * z[939]) - 0.5 * z[948] * z[628]) - 0.5 * z[964] * z[903]) - 0.5 * z[966] * z[904]) - 0.5 * z[967] * z[906]
end

hz(sol) = [hz(sol, t) for t in sol.t]


function px(sol, t)
    @unpack z, u4, u6, u8, u9, u5, u7, u10, u11, u12, u13 = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((((((z[39] * (z[988] * u1 + z[989] * u2 + z[1011] * u1 + z[1012] * u2) + z[66] * (z[1093] + z[1092] * u3 + z[1092] * u4 + z[1092] * u6 + z[1092] * u8) + z[1] * (z[980] + z[975] * u9 + z[976] * u3 + z[976] * u5 + z[977] * u7 + z[978] * u1 + z[979] * u2) + z[35] * (z[1024] + z[1021] * u3 + z[1021] * u5 + z[1021] * u7 + z[1021] * u9 + z[1022] * u1 + z[1023] * u2) + z[37] * (z[1029] + z[1025] * u9 + z[1026] * u3 + z[1026] * u5 + z[1026] * u7 + z[1027] * u1 + z[1028] * u2) + z[54] * (z[1034] + z[1030] * u9 + z[1031] * u3 + z[1031] * u5 + z[1031] * u7 + z[1032] * u1 + z[1033] * u2) + z[56] * (z[1040] + z[1035] * u9 + z[1036] * u7 + z[1037] * u3 + z[1037] * u5 + z[1038] * u1 + z[1039] * u2) + z[57] * (z[1134] + z[1129] * u9 + z[1130] * u3 + z[1130] * u5 + z[1131] * u7 + z[1132] * u1 + z[1133] * u2) + z[76] * (z[1149] + z[1143] * u9 + z[1144] * u7 + z[1145] * u5 + z[1146] * u3 + z[1147] * u1 + z[1148] * u2) + z[83] * (z[1047] + z[1041] * u9 + z[1042] * u7 + z[1043] * u5 + z[1044] * u3 + z[1045] * u1 + z[1046] * u2) + z[59] * (z[1142] + z[1135] * u4 + z[1136] * u9 + z[1137] * u7 + z[1138] * u5 + z[1139] * u3 + z[1140] * u1 + z[1141] * u2) + z[78] * (z[1156] + z[1048] * u10 + z[1150] * u9 + z[1151] * u7 + z[1152] * u5 + z[1153] * u3 + z[1154] * u1 + z[1155] * u2) + z[85] * (z[1055] + z[1048] * u11 + z[1049] * u9 + z[1050] * u7 + z[1051] * u5 + z[1052] * u3 + z[1053] * u1 + z[1054] * u2) + z[81] * (z[1091] + z[1002] * u12 + z[1084] * u9 + z[1085] * u7 + z[1086] * u5 + z[1087] * u10 + z[1088] * u3 + z[1089] * u1 + z[1090] * u2) + z[88] * (z[1010] + z[1002] * u13 + z[1003] * u9 + z[1004] * u7 + z[1005] * u5 + z[1006] * u11 + z[1007] * u3 + z[1008] * u1 + z[1009] * u2) + z[72] * (z[1065] + z[1056] * u8 + z[1057] * u9 + z[1058] * u5 + z[1059] * u7 + z[1060] * u3 + z[1061] * u4 + z[1062] * u6 + z[1063] * u1 + z[1064] * u2) + z[74] * (z[1075] + z[1066] * u9 + z[1067] * u5 + z[1068] * u7 + z[1069] * u3 + z[1070] * u4 + z[1071] * u6 + z[1072] * u8 + z[1073] * u1 + z[1074] * u2) + z[62] * (z[1111] + z[1128] + z[1103] * u6 + z[1120] * u6 + z[1104] * u9 + z[1105] * u5 + z[1106] * u7 + z[1107] * u3 + z[1108] * u4 + z[1121] * u9 + z[1122] * u5 + z[1123] * u7 + z[1124] * u3 + z[1125] * u4 + z[1109] * u1 + z[1110] * u2 + z[1126] * u1 + z[1127] * u2)) - 0.5 * z[48] * (z[1020] + z[1019] * u3 + z[1019] * u5 + z[1019] * u7 + z[1019] * u9)) - 0.5 * z[52] * (z[1018] + z[1017] * u3 + z[1017] * u5 + z[1017] * u7 + z[1017] * u9)) - 0.5 * z[70] * (z[1094] + z[1019] * u3 + z[1019] * u4 + z[1019] * u6 + z[1019] * u8)) - z[2] * (z[987] + z[981] * u9 + z[982] * u7 + z[983] * u5 + z[984] * u3 + z[985] * u1 + z[986] * u2)) - z[79] * (((((((z[1082] * u10 - z[1083]) - z[1076] * u9) - z[1077] * u7) - z[1078] * u5) - z[1079] * u3) - z[1080] * u1) - z[1081] * u2)) - z[86] * (((((((z[1000] * u11 - z[1001]) - z[994] * u9) - z[995] * u7) - z[996] * u5) - z[997] * u3) - z[998] * u1) - z[999] * u2)) - z[41] * (((((z[993] + z[1016] + z[992] * u3 + z[992] * u5 + z[992] * u7 + z[992] * u9 + z[1015] * u3 + z[1015] * u5 + z[1015] * u7 + z[1015] * u9) - z[990] * u1) - z[991] * u2) - z[1013] * u1) - z[1014] * u2)) - z[60] * (((((((((((((((z[1101] * u4 + z[1118] * u4) - z[1102]) - z[1119]) - z[1095] * u9) - z[1096] * u3) - z[1097] * u5) - z[1098] * u7) - z[1112] * u9) - z[1113] * u3) - z[1114] * u5) - z[1115] * u7) - z[1099] * u1) - z[1100] * u2) - z[1116] * u1) - z[1117] * u2)
end

px(sol) = [px(sol, t) for t in sol.t]


function py(sol, t)
    @unpack z, u4, u6, u8, u9, u7, u5, u10, u11, u12, u13 = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((((((z[40] * (z[988] * u1 + z[989] * u2 + z[1011] * u1 + z[1012] * u2) + z[67] * (z[1093] + z[1092] * u3 + z[1092] * u4 + z[1092] * u6 + z[1092] * u8) + z[1] * (z[987] + z[981] * u9 + z[982] * u7 + z[983] * u5 + z[984] * u3 + z[985] * u1 + z[986] * u2) + z[2] * (z[980] + z[975] * u9 + z[976] * u3 + z[976] * u5 + z[977] * u7 + z[978] * u1 + z[979] * u2) + z[36] * (z[1024] + z[1021] * u3 + z[1021] * u5 + z[1021] * u7 + z[1021] * u9 + z[1022] * u1 + z[1023] * u2) + z[38] * (z[1029] + z[1025] * u9 + z[1026] * u3 + z[1026] * u5 + z[1026] * u7 + z[1027] * u1 + z[1028] * u2) + z[54] * (z[1040] + z[1035] * u9 + z[1036] * u7 + z[1037] * u3 + z[1037] * u5 + z[1038] * u1 + z[1039] * u2) + z[55] * (z[1034] + z[1030] * u9 + z[1031] * u3 + z[1031] * u5 + z[1031] * u7 + z[1032] * u1 + z[1033] * u2) + z[58] * (z[1134] + z[1129] * u9 + z[1130] * u3 + z[1130] * u5 + z[1131] * u7 + z[1132] * u1 + z[1133] * u2) + z[77] * (z[1149] + z[1143] * u9 + z[1144] * u7 + z[1145] * u5 + z[1146] * u3 + z[1147] * u1 + z[1148] * u2) + z[84] * (z[1047] + z[1041] * u9 + z[1042] * u7 + z[1043] * u5 + z[1044] * u3 + z[1045] * u1 + z[1046] * u2) + z[57] * (z[1142] + z[1135] * u4 + z[1136] * u9 + z[1137] * u7 + z[1138] * u5 + z[1139] * u3 + z[1140] * u1 + z[1141] * u2) + z[76] * (z[1156] + z[1048] * u10 + z[1150] * u9 + z[1151] * u7 + z[1152] * u5 + z[1153] * u3 + z[1154] * u1 + z[1155] * u2) + z[83] * (z[1055] + z[1048] * u11 + z[1049] * u9 + z[1050] * u7 + z[1051] * u5 + z[1052] * u3 + z[1053] * u1 + z[1054] * u2) + z[82] * (z[1091] + z[1002] * u12 + z[1084] * u9 + z[1085] * u7 + z[1086] * u5 + z[1087] * u10 + z[1088] * u3 + z[1089] * u1 + z[1090] * u2) + z[89] * (z[1010] + z[1002] * u13 + z[1003] * u9 + z[1004] * u7 + z[1005] * u5 + z[1006] * u11 + z[1007] * u3 + z[1008] * u1 + z[1009] * u2) + z[73] * (z[1065] + z[1056] * u8 + z[1057] * u9 + z[1058] * u5 + z[1059] * u7 + z[1060] * u3 + z[1061] * u4 + z[1062] * u6 + z[1063] * u1 + z[1064] * u2) + z[75] * (z[1075] + z[1066] * u9 + z[1067] * u5 + z[1068] * u7 + z[1069] * u3 + z[1070] * u4 + z[1071] * u6 + z[1072] * u8 + z[1073] * u1 + z[1074] * u2) + z[63] * (z[1111] + z[1128] + z[1103] * u6 + z[1120] * u6 + z[1104] * u9 + z[1105] * u5 + z[1106] * u7 + z[1107] * u3 + z[1108] * u4 + z[1121] * u9 + z[1122] * u5 + z[1123] * u7 + z[1124] * u3 + z[1125] * u4 + z[1109] * u1 + z[1110] * u2 + z[1126] * u1 + z[1127] * u2)) - 0.5 * z[49] * (z[1020] + z[1019] * u3 + z[1019] * u5 + z[1019] * u7 + z[1019] * u9)) - 0.5 * z[53] * (z[1018] + z[1017] * u3 + z[1017] * u5 + z[1017] * u7 + z[1017] * u9)) - 0.5 * z[71] * (z[1094] + z[1019] * u3 + z[1019] * u4 + z[1019] * u6 + z[1019] * u8)) - z[80] * (((((((z[1082] * u10 - z[1083]) - z[1076] * u9) - z[1077] * u7) - z[1078] * u5) - z[1079] * u3) - z[1080] * u1) - z[1081] * u2)) - z[87] * (((((((z[1000] * u11 - z[1001]) - z[994] * u9) - z[995] * u7) - z[996] * u5) - z[997] * u3) - z[998] * u1) - z[999] * u2)) - z[42] * (((((z[993] + z[1016] + z[992] * u3 + z[992] * u5 + z[992] * u7 + z[992] * u9 + z[1015] * u3 + z[1015] * u5 + z[1015] * u7 + z[1015] * u9) - z[990] * u1) - z[991] * u2) - z[1013] * u1) - z[1014] * u2)) - z[61] * (((((((((((((((z[1101] * u4 + z[1118] * u4) - z[1102]) - z[1119]) - z[1095] * u9) - z[1096] * u3) - z[1097] * u5) - z[1098] * u7) - z[1112] * u9) - z[1113] * u3) - z[1114] * u5) - z[1115] * u7) - z[1099] * u1) - z[1100] * u2) - z[1116] * u1) - z[1117] * u2)
end

py(sol) = [py(sol, t) for t in sol.t]


function rhtq(sol, t)
    @unpack z = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    q1p, q2p, q3p, u1p, u2p, u3p = eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[1279] + z[1217] * u3p + z[1218] * u1p + z[1219] * u2p
end

rhtq(sol) = [rhtq(sol, t) for t in sol.t]


function lhtq(sol, t)
    @unpack z = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    q1p, q2p, q3p, u1p, u2p, u3p = eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[1280] + z[1222] * u3p + z[1223] * u1p + z[1224] * u2p
end

lhtq(sol) = [lhtq(sol, t) for t in sol.t]


function rktq(sol, t)
    @unpack z = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    q1p, q2p, q3p, u1p, u2p, u3p = eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[1281] + z[1229] * u3p + z[1230] * u1p + z[1231] * u2p
end

rktq(sol) = [rktq(sol, t) for t in sol.t]


function lktq(sol, t)
    @unpack z = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    q1p, q2p, q3p, u1p, u2p, u3p = eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[1282] + z[1234] * u3p + z[1235] * u1p + z[1236] * u2p
end

lktq(sol) = [lktq(sol, t) for t in sol.t]


function ratq(sol, t)
    @unpack z = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    q1p, q2p, q3p, u1p, u2p, u3p = eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[1283] + z[1240] * u3p + z[1241] * u1p + z[1242] * u2p
end

ratq(sol) = [ratq(sol, t) for t in sol.t]


function latq(sol, t)
    @unpack z = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    q1p, q2p, q3p, u1p, u2p, u3p = eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[1284] + z[1245] * u3p + z[1246] * u1p + z[1247] * u2p
end

latq(sol) = [latq(sol, t) for t in sol.t]


function rstq(sol, t)
    @unpack z = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    q1p, q2p, q3p, u1p, u2p, u3p = eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[1285] + z[1250] * u3p + z[1251] * u1p + z[1252] * u2p
end

rstq(sol) = [rstq(sol, t) for t in sol.t]


function lstq(sol, t)
    @unpack z = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    q1p, q2p, q3p, u1p, u2p, u3p = eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return z[1286] + z[1254] * u3p + z[1255] * u1p + z[1256] * u2p
end

lstq(sol) = [lstq(sol, t) for t in sol.t]


function retq(sol, t)
    @unpack z = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    q1p, q2p, q3p, u1p, u2p, u3p = eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (z[1258] * u3p + z[1259] * u1p + z[1260] * u2p) - z[1277]
end

retq(sol) = [retq(sol, t) for t in sol.t]


function letq(sol, t)
    @unpack z = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    q1p, q2p, q3p, u1p, u2p, u3p = eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (z[1262] * u3p + z[1263] * u1p + z[1264] * u2p) - z[1278]
end

letq(sol) = [letq(sol, t) for t in sol.t]


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

    return (q1 - lff * z[39]) - lrff * z[46]
end

pop3x(sol) = [pop3x(sol, t) for t in sol.t]


function pop3y(sol, t)
    @unpack z, lff, lrff = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (q2 - lff * z[40]) - lrff * z[47]
end

pop3y(sol) = [pop3y(sol, t) for t in sol.t]


function pop4x(sol, t)
    @unpack z, lff, lrf = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (q1 - lff * z[39]) - lrf * z[50]
end

pop4x(sol) = [pop4x(sol, t) for t in sol.t]


function pop4y(sol, t)
    @unpack z, lff, lrf = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (q2 - lff * z[40]) - lrf * z[51]
end

pop4y(sol) = [pop4y(sol, t) for t in sol.t]


function pop5x(sol, t)
    @unpack z, lff, lrf, lsh = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((q1 - lff * z[39]) - lrf * z[50]) - lsh * z[35]
end

pop5x(sol) = [pop5x(sol, t) for t in sol.t]


function pop5y(sol, t)
    @unpack z, lff, lrf, lsh = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((q2 - lff * z[40]) - lrf * z[51]) - lsh * z[36]
end

pop5y(sol) = [pop5y(sol, t) for t in sol.t]


function pop6x(sol, t)
    @unpack z, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((q1 - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop6x(sol) = [pop6x(sol, t) for t in sol.t]


function pop6y(sol, t)
    @unpack z, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((q2 - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop6y(sol) = [pop6y(sol, t) for t in sol.t]


function pop7x(sol, t)
    @unpack z, lth, lff, lrf, lsh = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lth * z[57]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop7x(sol) = [pop7x(sol, t) for t in sol.t]


function pop7y(sol, t)
    @unpack z, lth, lff, lrf, lsh = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lth * z[58]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop7y(sol) = [pop7y(sol, t) for t in sol.t]


function pop8x(sol, t)
    @unpack z, lsh, lth, lff, lrf = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lsh * z[60] + lth * z[57]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop8x(sol) = [pop8x(sol, t) for t in sol.t]


function pop8y(sol, t)
    @unpack z, lsh, lth, lff, lrf = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lsh * z[61] + lth * z[58]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop8y(sol) = [pop8y(sol, t) for t in sol.t]


function pop9x(sol, t)
    @unpack z, lrf, lsh, lth, lff, lrff = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((((q1 + lrf * z[64] + lsh * z[60] + lth * z[57]) - lff * z[39]) - lrf * z[50]) - lrff * z[68]) - lsh * z[35]) - lth * z[54]
end

pop9x(sol) = [pop9x(sol, t) for t in sol.t]


function pop9y(sol, t)
    @unpack z, lrf, lsh, lth, lff, lrff = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((((q2 + lrf * z[65] + lsh * z[61] + lth * z[58]) - lff * z[40]) - lrf * z[51]) - lrff * z[69]) - lsh * z[36]) - lth * z[55]
end

pop9y(sol) = [pop9y(sol, t) for t in sol.t]


function pop12x(sol, t)
    @unpack z, lhat, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lhat * z[1]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop12x(sol) = [pop12x(sol, t) for t in sol.t]


function pop12y(sol, t)
    @unpack z, lhat, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lhat * z[2]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop12y(sol) = [pop12y(sol, t) for t in sol.t]


function pop13x(sol, t)
    @unpack z, lhat, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lhat * z[1] + lua * z[76]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop13x(sol) = [pop13x(sol, t) for t in sol.t]


function pop13y(sol, t)
    @unpack z, lhat, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lhat * z[2] + lua * z[77]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop13y(sol) = [pop13y(sol, t) for t in sol.t]


function pop14x(sol, t)
    @unpack z, lhat, lla, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lhat * z[1] + lla * z[79] + lua * z[76]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop14x(sol) = [pop14x(sol, t) for t in sol.t]


function pop14y(sol, t)
    @unpack z, lhat, lla, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lhat * z[2] + lla * z[80] + lua * z[77]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop14y(sol) = [pop14y(sol, t) for t in sol.t]


function pop15x(sol, t)
    @unpack z, lhat, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lhat * z[1] + lua * z[83]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop15x(sol) = [pop15x(sol, t) for t in sol.t]


function pop15y(sol, t)
    @unpack z, lhat, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lhat * z[2] + lua * z[84]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop15y(sol) = [pop15y(sol, t) for t in sol.t]


function pop16x(sol, t)
    @unpack z, lhat, lla, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q1 + lhat * z[1] + lla * z[86] + lua * z[83]) - lff * z[39]) - lrf * z[50]) - lsh * z[35]) - lth * z[54]
end

pop16x(sol) = [pop16x(sol, t) for t in sol.t]


function pop16y(sol, t)
    @unpack z, lhat, lla, lua, lff, lrf, lsh, lth = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((q2 + lhat * z[2] + lla * z[87] + lua * z[84]) - lff * z[40]) - lrf * z[51]) - lsh * z[36]) - lth * z[55]
end

pop16y(sol) = [pop16y(sol, t) for t in sol.t]


function pocmx(sol, t)
    @unpack z = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((((q1 + z[95] * z[1] + z[97] * z[79] + z[97] * z[86] + z[102] * z[76] + z[102] * z[83] + z[103] * z[72] + z[104] * z[64] + z[105] * z[60] + z[106] * z[57]) - z[96] * z[39]) - z[100] * z[35]) - z[101] * z[54]) - 0.5 * z[98] * z[50]) - 0.5 * z[99] * z[46]) - 0.5 * z[99] * z[68]
end

pocmx(sol) = [pocmx(sol, t) for t in sol.t]


function pocmy(sol, t)
    @unpack z = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ((((((q2 + z[95] * z[2] + z[97] * z[80] + z[97] * z[87] + z[102] * z[77] + z[102] * z[84] + z[103] * z[73] + z[104] * z[65] + z[105] * z[61] + z[106] * z[58]) - z[96] * z[40]) - z[100] * z[36]) - z[101] * z[55]) - 0.5 * z[98] * z[51]) - 0.5 * z[99] * z[47]) - 0.5 * z[99] * z[69]
end

pocmy(sol) = [pocmy(sol, t) for t in sol.t]


function vocmx(sol, t)
    @unpack z, u5, u10, u12, u11, u13, u4, u6, u8, u7, u9 = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return (((((((u1 + z[56] * ((z[425] - z[101] * u3) - z[101] * u5) + z[81] * (z[428] + z[97] * u10 + z[97] * u12 + z[97] * u3) + z[88] * (z[421] + z[97] * u11 + z[97] * u13 + z[97] * u3) + z[74] * (z[427] + z[103] * u3 + z[103] * u4 + z[103] * u6 + z[103] * u8) + z[37] * (((z[424] - z[100] * u3) - z[100] * u5) - z[100] * u7) + 0.5 * z[48] * ((((z[423] - z[99] * u3) - z[99] * u5) - z[99] * u7) - z[99] * u9) + 0.5 * z[52] * ((((z[422] - z[98] * u3) - z[98] * u5) - z[98] * u7) - z[98] * u9) + 0.5 * z[70] * ((((z[430] - z[99] * u3) - z[99] * u4) - z[99] * u6) - z[99] * u8)) - z[95] * z[2] * u3) - z[59] * ((z[432] - z[106] * u3) - z[106] * u4)) - z[78] * ((z[433] - z[102] * u10) - z[102] * u3)) - z[85] * ((z[426] - z[102] * u11) - z[102] * u3)) - z[41] * (z[420] + z[96] * u3 + z[96] * u5 + z[96] * u7 + z[96] * u9)) - z[62] * (((z[431] - z[105] * u3) - z[105] * u4) - z[105] * u6)) - z[66] * ((((z[429] - z[104] * u3) - z[104] * u4) - z[104] * u6) - z[104] * u8)
end

vocmx(sol) = [vocmx(sol, t) for t in sol.t]


function vocmy(sol, t)
    @unpack z, u5, u10, u12, u11, u13, u4, u6, u8, u7, u9 = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return u2 + z[95] * z[1] * u3 + z[54] * (z[425] - z[101] * u3 - z[101] * u5) + z[82] * (z[428] + z[97] * u10 + z[97] * u12 + z[97] * u3) + z[89] * (z[421] + z[97] * u11 + z[97] * u13 + z[97] * u3) + z[75] * (z[427] + z[103] * u3 + z[103] * u4 + z[103] * u6 + z[103] * u8) + z[38] * (z[424] - z[100] * u3 - z[100] * u5 - z[100] * u7) + 0.5 * z[49] * (z[423] - z[99] * u3 - z[99] * u5 - z[99] * u7 - z[99] * u9) + 0.5 * z[53] * (z[422] - z[98] * u3 - z[98] * u5 - z[98] * u7 - z[98] * u9) + 0.5 * z[71] * (z[430] - z[99] * u3 - z[99] * u4 - z[99] * u6 - z[99] * u8) - z[57] * (z[432] - z[106] * u3 - z[106] * u4) - z[76] * (z[433] - z[102] * u10 - z[102] * u3) - z[83] * (z[426] - z[102] * u11 - z[102] * u3) - z[42] * (z[420] + z[96] * u3 + z[96] * u5 + z[96] * u7 + z[96] * u9) - z[63] * (z[431] - z[105] * u3 - z[105] * u4 - z[105] * u6) - z[67] * (z[429] - z[104] * u3 - z[104] * u4 - z[104] * u6 - z[104] * u8)
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


function vrx(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return vrx1 + vrx2
end

vrx(sol) = [vrx(sol, t) for t in sol.t]


function vry(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return vry1 + vry2
end

vry(sol) = [vry(sol, t) for t in sol.t]


function rx(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return rx1 + rx2
end

rx(sol) = [rx(sol, t) for t in sol.t]


function ry(sol, t)

    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)


    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return ry1 + ry2
end

ry(sol) = [ry(sol, t) for t in sol.t]


function io(sol, t)
    @unpack footang, g, iff, ihat, ila, irf, ish, ith, iua, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lhato, lla, llao, lmtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, ltoexi, lua, luao, mff, mhat, mla, mrf, msh, mth, mtpb, mtpk, mua, rmtpxi, rtoexi, u4, u5, u6, u7, u8, u9, u10, u11, u12, u13, z = sol.prob.p
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
    rs = _rs(t)
    ls = _ls(t)
    re = _re(t)
    le = _le(t)
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
    rep = _rep(t)
    lep = _lep(t)

    # calculated variables
    rx1, ry1, rx2, ry2, vrx1, vry1, vrx2, vry2 = contact_forces(sol(t), p, t)

    u4 = 0
    u5 = 0
    u6 = 0
    u7 = 0
    u8 = 0
    u9 = 0
    u10 = 0
    u11 = 0
    u12 = 0
    u13 = 0
    z[546] = g * msh
    z[543] = g * mff
    z[1159] = lffo * z[543]
    z[545] = g * mrf
    z[27] = cos(footang)
    z[544] = g * mla
    z[1002] = llao * mla
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
    z[542] = g * mhat
    z[547] = g * mth
    z[548] = g * mua
    z[578] = lsh - z[100]
    z[579] = lth - z[101]
    z[580] = lff - z[96]
    z[581] = 2lrf - z[98]
    z[674] = lhat - z[95]
    z[675] = lua - z[102]
    z[680] = z[96] - lff
    z[681] = 0.5 * z[98] - 0.5lrfo
    z[682] = 0.5 * z[99] - 0.5lrffo
    z[872] = lsh - z[105]
    z[873] = lth - z[106]
    z[874] = lrf - z[104]
    z[899] = 0.5 * z[98] - lrf
    z[900] = z[100] - lsh
    z[901] = z[101] - lth
    z[902] = (lrf - 0.5lrfo) - z[104]
    z[949] = 2 * z[681] + 2 * z[27] * z[682]
    z[951] = 2 * z[682] + 2 * z[27] * z[681]
    z[963] = z[27] * z[682]
    z[965] = z[27] * z[902]
    z[992] = lffo * mff
    z[1015] = lff * mrf
    z[1017] = lrfo * mrf
    z[1019] = lrffo * mrf
    z[1048] = luao * mua
    z[1092] = mrf * z[91]
    z[1103] = lsh * mrf
    z[1120] = msh * z[92]
    z[1135] = mth * z[93]
    z[1161] = z[93] * z[547]
    z[1164] = z[92] * z[546]
    z[1169] = luao * z[548]
    z[1172] = llao * z[544]
    z[1200] = ihat + 2iff + 2ila + 2irf + 2ish + 2ith + 2iua + mff * lffo^2
    z[1201] = lrffo^2 + lrfo^2 + 4 * lff^2 + 2 * lrffo * lrfo * z[27]
    z[1202] = lff * lrffo
    z[1203] = lff * lrfo
    z[1204] = lrffo^2 + 4 * z[91]^2
    z[1205] = lrffo * z[27] * z[91]
    z[1207] = lrffo * z[27]
    z[1208] = lrfo * z[27]
    z[1209] = lrffo * z[28]
    z[1210] = lrfo * z[28]
    z[1211] = z[27] * z[91]
    z[1212] = z[28] * z[91]
    z[1214] = iff + irf + ish + ith
    z[1215] = lrffo^2
    z[1216] = z[91]^2
    z[1221] = iff + irf + ish + ith + mff * lffo^2
    z[1226] = iff + irf + ish
    z[1227] = lsh * z[91]
    z[1228] = lrffo * lsh
    z[1233] = iff + irf + ish + mff * lffo^2
    z[1238] = iff + irf
    z[1239] = (lrffo^2 + 4 * z[91]^2) - 4 * lrffo * z[27] * z[91]
    z[1244] = iff + irf + mff * lffo^2
    z[1249] = ila + iua
    z[321] = z[5] * z[195] + z[6] * z[206]
    z[316] = z[5] * z[191] + z[6] * z[196]
    z[318] = z[5] * z[192] + z[6] * z[197]
    z[327] = z[5] * z[206] - z[6] * z[195]
    z[322] = z[5] * z[196] - z[6] * z[191]
    z[323] = z[5] * z[197] - z[6] * z[192]
    z[187] = z[183] - z[185]
    z[203] = z[200] + z[201]
    z[224] = z[221] - z[222]
    z[336] = z[20] * z[327] - z[19] * z[321]
    z[330] = z[20] * z[322] - z[19] * z[316]
    z[331] = z[20] * z[323] - z[19] * z[318]
    z[332] = z[20] * z[324] - z[19] * z[317]
    z[343] = -(z[19]) * z[327] - z[20] * z[321]
    z[346] = z[343] - z[344]
    z[337] = -(z[19]) * z[322] - z[20] * z[316]
    z[338] = -(z[19]) * z[323] - z[20] * z[318]
    z[339] = -(z[19]) * z[324] - z[20] * z[317]
    z[381] = z[22] * z[327] - z[21] * z[321]
    z[375] = z[22] * z[322] - z[21] * z[316]
    z[376] = z[22] * z[323] - z[21] * z[318]
    z[377] = z[22] * z[324] - z[21] * z[317]
    z[388] = -(z[21]) * z[327] - z[22] * z[321]
    z[391] = z[388] - z[389]
    z[382] = -(z[21]) * z[322] - z[22] * z[316]
    z[383] = -(z[21]) * z[323] - z[22] * z[318]
    z[384] = -(z[21]) * z[324] - z[22] * z[317]
    z[309] = z[302] + z[304]
    z[306] = z[90] + z[298]
    z[307] = z[90] + z[293]
    z[308] = z[90] - z[301]
    z[349] = z[343] - z[347]
    z[365] = z[24] * z[336] - z[23] * z[349]
    z[370] = z[365] + z[367]
    z[358] = z[24] * z[330] - z[23] * z[337]
    z[359] = z[24] * z[331] - z[23] * z[338]
    z[360] = z[24] * z[332] - z[23] * z[339]
    z[364] = lua * z[23]
    z[368] = llao - z[364]
    z[356] = lua * z[24]
    z[357] = -(z[23]) * z[336] - z[24] * z[349]
    z[350] = -(z[23]) * z[330] - z[24] * z[337]
    z[351] = -(z[23]) * z[331] - z[24] * z[338]
    z[352] = -(z[23]) * z[332] - z[24] * z[339]
    z[394] = z[388] - z[392]
    z[410] = z[26] * z[381] - z[25] * z[394]
    z[415] = z[410] + z[412]
    z[403] = z[26] * z[375] - z[25] * z[382]
    z[404] = z[26] * z[376] - z[25] * z[383]
    z[405] = z[26] * z[377] - z[25] * z[384]
    z[409] = lua * z[25]
    z[413] = llao - z[409]
    z[401] = lua * z[26]
    z[402] = -(z[25]) * z[381] - z[26] * z[394]
    z[395] = -(z[25]) * z[375] - z[26] * z[382]
    z[396] = -(z[25]) * z[376] - z[26] * z[383]
    z[397] = -(z[25]) * z[377] - z[26] * z[384]
    z[248] = z[243] + z[245]
    z[247] = z[92] - z[242]
    z[566] = iff * z[155]
    z[567] = ila * z[411]
    z[568] = irf * z[158]
    z[569] = ish * z[184]
    z[572] = iff * z[303]
    z[573] = ila * z[366]
    z[574] = irf * z[253]
    z[575] = ish * z[244]
    z[44] = z[27] * z[14] - z[28] * z[13]
    z[46] = z[43] * z[35] + z[44] * z[37]
    z[47] = z[43] * z[36] + z[44] * z[38]
    z[159] = z[1] * z[46] + z[2] * z[47]
    z[68] = z[27] * z[64] + z[28] * z[66]
    z[69] = z[27] * z[65] + z[28] * z[67]
    z[254] = z[1] * z[68] + z[2] * z[69]
    z[78] = z[19] * z[2] - z[20] * z[1]
    z[79] = -(z[23]) * z[76] - z[24] * z[78]
    z[145] = z[1] * z[79] + z[2] * z[80]
    z[85] = z[21] * z[2] - z[22] * z[1]
    z[86] = -(z[25]) * z[83] - z[26] * z[85]
    z[151] = z[1] * z[86] + z[2] * z[87]
    z[131] = z[1] * z[72] + z[2] * z[73]
    z[119] = z[1] * z[64] + z[2] * z[65]
    z[111] = z[1] * z[60] + z[2] * z[61]
    z[137] = z[1] * z[39] + z[2] * z[40]
    z[125] = z[1] * z[50] + z[2] * z[51]
    z[582] = (((((((((((lhato + z[102] * z[19] + z[102] * z[21] + 0.5 * z[99] * z[159] + 0.5 * z[99] * z[254]) - z[95]) - z[106] * z[3]) - z[578] * z[32]) - z[579] * z[5]) - z[97] * z[145]) - z[97] * z[151]) - z[103] * z[131]) - z[104] * z[119]) - z[105] * z[111]) - z[580] * z[137]) - 0.5 * z[581] * z[125]
    z[941] = mhat * z[582]
    z[585] = z[327] + z[322] * u9 + z[323] * u7 + z[324] * u5 + z[328] * u3 + z[325] * u1 + z[326] * u2
    z[139] = z[1] * z[40] - z[2] * z[39]
    z[590] = z[5] * z[137] - z[6] * z[139]
    z[598] = z[39] * z[72] + z[40] * z[73]
    z[600] = z[39] * z[74] + z[40] * z[75]
    z[606] = -(z[15]) * z[598] - z[16] * z[600]
    z[608] = z[16] * z[598] - z[15] * z[600]
    z[610] = z[27] * z[606] + z[28] * z[608]
    z[586] = z[39] * z[86] + z[40] * z[87]
    z[602] = z[39] * z[79] + z[40] * z[80]
    z[594] = z[22] * z[139] - z[21] * z[137]
    z[622] = z[20] * z[139] - z[19] * z[137]
    z[614] = -(z[11]) * z[606] - z[12] * z[608]
    z[618] = z[3] * z[137] - z[4] * z[139]
    z[626] = (((((((((((z[96] + z[100] * z[29] + 0.5 * z[99] * z[560] + z[101] * z[590] + 0.5 * z[99] * z[610]) - lffo) - 0.5 * z[98] * z[17]) - z[95] * z[137]) - z[97] * z[586]) - z[97] * z[602]) - z[102] * z[594]) - z[102] * z[622]) - z[103] * z[598]) - z[104] * z[606]) - z[105] * z[614]) - z[106] * z[618]
    z[943] = mff * z[626]
    z[629] = (((((z[41] * u1 + z[42] * u2) - z[156]) - lffo * u3) - lffo * u5) - lffo * u7) - lffo * u9
    z[587] = z[41] * z[86] + z[42] * z[87]
    z[630] = -(z[17]) * z[586] - z[18] * z[587]
    z[632] = z[18] * z[586] - z[17] * z[587]
    z[634] = z[27] * z[630] + z[28] * z[632]
    z[646] = z[72] * z[86] + z[73] * z[87]
    z[648] = z[74] * z[86] + z[75] * z[87]
    z[654] = -(z[15]) * z[646] - z[16] * z[648]
    z[656] = z[16] * z[646] - z[15] * z[648]
    z[658] = z[27] * z[654] + z[28] * z[656]
    z[650] = z[79] * z[86] + z[80] * z[87]
    z[153] = z[1] * z[87] - z[2] * z[86]
    z[670] = z[20] * z[153] - z[19] * z[151]
    z[662] = -(z[11]) * z[654] - z[12] * z[656]
    z[666] = z[3] * z[151] - z[4] * z[153]
    z[638] = -(z[13]) * z[630] - z[14] * z[632]
    z[642] = z[5] * z[151] - z[6] * z[153]
    z[676] = ((((((((((((llao + z[674] * z[151] + 0.5 * z[99] * z[634] + 0.5 * z[99] * z[658]) - z[97]) - z[675] * z[25]) - z[97] * z[650]) - z[102] * z[670]) - z[103] * z[646]) - z[104] * z[654]) - z[105] * z[662]) - z[106] * z[666]) - z[578] * z[638]) - z[579] * z[642]) - z[580] * z[586]) - 0.5 * z[581] * z[630]
    z[945] = mla * z[676]
    z[679] = z[415] + llao * u13 + z[403] * u9 + z[404] * u7 + z[405] * u5 + z[413] * u11 + z[414] * u3 + z[407] * u1 + z[408] * u2
    z[762] = z[35] * z[72] + z[36] * z[73]
    z[764] = z[35] * z[74] + z[36] * z[75]
    z[770] = -(z[15]) * z[762] - z[16] * z[764]
    z[772] = z[16] * z[762] - z[15] * z[764]
    z[774] = z[27] * z[770] + z[28] * z[772]
    z[758] = z[22] * z[33] - z[21] * z[32]
    z[786] = z[20] * z[33] - z[19] * z[32]
    z[782] = z[3] * z[32] - z[4] * z[33]
    z[766] = z[35] * z[79] + z[36] * z[80]
    z[778] = -(z[11]) * z[770] - z[12] * z[772]
    z[790] = ((((((((((((z[100] + 0.5 * z[99] * z[43] + 0.5 * z[581] * z[13] + 0.5 * z[99] * z[774]) - lsho) - z[95] * z[32]) - z[101] * z[9]) - z[102] * z[758]) - z[102] * z[786]) - z[106] * z[782]) - z[580] * z[29]) - z[97] * z[638]) - z[97] * z[766]) - z[103] * z[762]) - z[104] * z[770]) - z[105] * z[778]
    z[953] = msh * z[790]
    z[793] = z[187] + z[180] * u9 + z[186] * u3 + z[186] * u5 + z[186] * u7 + z[181] * u1 + z[182] * u2
    z[161] = z[1] * z[47] - z[2] * z[46]
    z[690] = z[5] * z[159] - z[6] * z[161]
    z[797] = z[54] * z[72] + z[55] * z[73]
    z[799] = z[54] * z[74] + z[55] * z[75]
    z[805] = -(z[15]) * z[797] - z[16] * z[799]
    z[807] = z[16] * z[797] - z[15] * z[799]
    z[809] = z[27] * z[805] + z[28] * z[807]
    z[794] = -(z[5]) * z[21] - z[6] * z[22]
    z[817] = -(z[5]) * z[19] - z[6] * z[20]
    z[813] = -(z[7]) * z[207] - z[8] * z[208]
    z[801] = z[54] * z[79] + z[55] * z[80]
    z[127] = z[1] * z[51] - z[2] * z[50]
    z[686] = z[5] * z[125] - z[6] * z[127]
    z[820] = ((((((((((((z[101] + z[578] * z[9] + 0.5 * z[99] * z[690] + 0.5 * z[99] * z[809]) - ltho) - z[95] * z[5]) - z[102] * z[794]) - z[102] * z[817]) - z[105] * z[813]) - z[106] * z[207]) - z[97] * z[642]) - z[97] * z[801]) - z[103] * z[797]) - z[104] * z[805]) - z[580] * z[590]) - 0.5 * z[581] * z[686]
    z[955] = mth * z[820]
    z[823] = z[203] + z[196] * u9 + z[197] * u7 + z[202] * u3 + z[202] * u5 + z[198] * u1 + z[199] * u2
    z[698] = z[22] * z[161] - z[21] * z[159]
    z[824] = z[72] * z[83] + z[73] * z[84]
    z[826] = z[74] * z[83] + z[75] * z[84]
    z[832] = -(z[15]) * z[824] - z[16] * z[826]
    z[834] = z[16] * z[824] - z[15] * z[826]
    z[836] = z[27] * z[832] + z[28] * z[834]
    z[847] = z[19] * z[21] + z[20] * z[22]
    z[844] = -(z[3]) * z[21] - z[4] * z[22]
    z[828] = z[79] * z[83] + z[80] * z[84]
    z[840] = -(z[11]) * z[832] - z[12] * z[834]
    z[694] = z[22] * z[127] - z[21] * z[125]
    z[850] = ((((((((((((luao + z[97] * z[25] + 0.5 * z[99] * z[698] + 0.5 * z[99] * z[836]) - z[102]) - z[102] * z[847]) - z[106] * z[844]) - z[578] * z[758]) - z[579] * z[794]) - z[674] * z[21]) - z[97] * z[828]) - z[103] * z[824]) - z[104] * z[832]) - z[105] * z[840]) - z[580] * z[594]) - 0.5 * z[581] * z[694]
    z[957] = mua * z[850]
    z[853] = z[391] + luao * u11 + z[382] * u9 + z[383] * u7 + z[384] * u5 + z[390] * u3 + z[386] * u1 + z[387] * u2
    z[861] = z[11] * z[15] - z[12] * z[16]
    z[858] = z[28] * z[16] - z[27] * z[15]
    z[133] = z[1] * z[73] - z[2] * z[72]
    z[864] = z[3] * z[131] - z[4] * z[133]
    z[706] = z[46] * z[72] + z[47] * z[73]
    z[854] = z[72] * z[79] + z[73] * z[80]
    z[868] = z[20] * z[133] - z[19] * z[131]
    z[702] = z[50] * z[72] + z[51] * z[73]
    z[875] = ((((((((((((lff + z[872] * z[861] + 0.5 * z[99] * z[858] + z[873] * z[864] + 0.5 * z[99] * z[706]) - lffo) - z[103]) - z[874] * z[15]) - z[95] * z[131]) - z[97] * z[646]) - z[97] * z[854]) - z[102] * z[824]) - z[102] * z[868]) - z[578] * z[762]) - z[579] * z[797]) - z[580] * z[598]) - 0.5 * z[581] * z[702]
    z[959] = mff * z[875]
    z[878] = z[309] + z[294] * u9 + z[295] * u5 + z[296] * u7 + z[305] * u3 + z[306] * u4 + z[307] * u6 + z[308] * u8 + z[299] * u1 + z[300] * u2
    z[714] = z[46] * z[79] + z[47] * z[80]
    z[855] = z[74] * z[79] + z[75] * z[80]
    z[879] = -(z[15]) * z[854] - z[16] * z[855]
    z[881] = z[16] * z[854] - z[15] * z[855]
    z[883] = z[27] * z[879] + z[28] * z[881]
    z[887] = -(z[11]) * z[879] - z[12] * z[881]
    z[147] = z[1] * z[80] - z[2] * z[79]
    z[891] = z[3] * z[145] - z[4] * z[147]
    z[710] = z[50] * z[79] + z[51] * z[80]
    z[895] = ((((((((((((llao + z[674] * z[145] + 0.5 * z[99] * z[714] + 0.5 * z[99] * z[883]) - z[97]) - z[675] * z[23]) - z[97] * z[650]) - z[102] * z[828]) - z[103] * z[854]) - z[104] * z[879]) - z[105] * z[887]) - z[106] * z[891]) - z[578] * z[766]) - z[579] * z[801]) - z[580] * z[602]) - 0.5 * z[581] * z[710]
    z[961] = mla * z[895]
    z[898] = z[370] + llao * u12 + z[358] * u9 + z[359] * u7 + z[360] * u5 + z[368] * u10 + z[369] * u3 + z[362] * u1 + z[363] * u2
    z[708] = z[46] * z[74] + z[47] * z[75]
    z[722] = -(z[15]) * z[706] - z[16] * z[708]
    z[724] = z[16] * z[706] - z[15] * z[708]
    z[738] = -(z[11]) * z[722] - z[12] * z[724]
    z[113] = z[1] * z[61] - z[2] * z[60]
    z[923] = z[20] * z[113] - z[19] * z[111]
    z[704] = z[50] * z[74] + z[51] * z[75]
    z[718] = -(z[15]) * z[702] - z[16] * z[704]
    z[720] = z[16] * z[702] - z[15] * z[704]
    z[734] = -(z[11]) * z[718] - z[12] * z[720]
    z[927] = (((((((((((((lsh + z[104] * z[11] + 0.5 * z[99] * z[563] + 0.5 * z[99] * z[738]) - lsho) - z[105]) - z[103] * z[861]) - z[579] * z[813]) - z[873] * z[7]) - z[95] * z[111]) - z[97] * z[662]) - z[97] * z[887]) - z[102] * z[840]) - z[102] * z[923]) - z[578] * z[778]) - z[580] * z[614]) - 0.5 * z[581] * z[734]
    z[969] = msh * z[927]
    z[929] = z[248] + z[92] * u6 + z[236] * u9 + z[238] * u5 + z[239] * u7 + z[246] * u3 + z[247] * u4 + z[240] * u1 + z[241] * u2
    z[746] = z[3] * z[159] - z[4] * z[161]
    z[256] = z[1] * z[69] - z[2] * z[68]
    z[911] = z[3] * z[254] - z[4] * z[256]
    z[930] = -(z[3]) * z[19] - z[4] * z[20]
    z[121] = z[1] * z[65] - z[2] * z[64]
    z[907] = z[3] * z[119] - z[4] * z[121]
    z[742] = z[3] * z[125] - z[4] * z[127]
    z[933] = (((((((((((((lth + z[105] * z[7] + 0.5 * z[99] * z[746] + 0.5 * z[99] * z[911]) - ltho) - z[106]) - z[95] * z[3]) - z[102] * z[844]) - z[102] * z[930]) - z[578] * z[782]) - z[579] * z[207]) - z[97] * z[666]) - z[97] * z[891]) - z[103] * z[864]) - z[104] * z[907]) - z[580] * z[618]) - 0.5 * z[581] * z[742]
    z[971] = mth * z[933]
    z[936] = z[224] + z[93] * u4 + z[216] * u9 + z[217] * u7 + z[218] * u5 + z[223] * u3 + z[219] * u1 + z[220] * u2
    z[754] = z[20] * z[161] - z[19] * z[159]
    z[919] = z[20] * z[256] - z[19] * z[254]
    z[915] = z[20] * z[121] - z[19] * z[119]
    z[750] = z[20] * z[127] - z[19] * z[125]
    z[937] = ((((((((((((luao + z[97] * z[23] + 0.5 * z[99] * z[754] + 0.5 * z[99] * z[919]) - z[102]) - z[102] * z[847]) - z[106] * z[930]) - z[578] * z[786]) - z[579] * z[817]) - z[674] * z[19]) - z[97] * z[670]) - z[103] * z[868]) - z[104] * z[915]) - z[105] * z[923]) - z[580] * z[622]) - 0.5 * z[581] * z[750]
    z[973] = mua * z[937]
    z[940] = z[346] + luao * u10 + z[337] * u9 + z[338] * u7 + z[339] * u5 + z[345] * u3 + z[341] * u1 + z[342] * u2
    z[947] = mrf * (((((((((((2 * z[680] + 2 * z[100] * z[29] + 2 * z[682] * z[560] + z[99] * z[610] + 2 * z[101] * z[590]) - 2 * z[681] * z[17]) - 2 * z[95] * z[137]) - 2 * z[97] * z[586]) - 2 * z[97] * z[602]) - 2 * z[102] * z[594]) - 2 * z[102] * z[622]) - 2 * z[103] * z[598]) - 2 * z[104] * z[606]) - 2 * z[105] * z[614]) - 2 * z[106] * z[618])
    z[683] = (((((z[41] * u1 + z[42] * u2) - z[157]) - lff * u3) - lff * u5) - lff * u7) - lff * u9
    z[726] = z[27] * z[718] + z[28] * z[720]
    z[950] = mrf * ((((((((((((z[949] + z[99] * z[726] + 2 * z[101] * z[686]) - 2 * z[100] * z[13]) - 2 * z[680] * z[17]) - 2 * z[95] * z[125]) - 2 * z[97] * z[630]) - 2 * z[97] * z[710]) - 2 * z[102] * z[694]) - 2 * z[102] * z[750]) - 2 * z[103] * z[702]) - 2 * z[104] * z[718]) - 2 * z[105] * z[734]) - 2 * z[106] * z[742])
    z[684] = (((-0.5 * z[163] - 0.5 * lrfo * u3) - 0.5 * lrfo * u5) - 0.5 * lrfo * u7) - 0.5 * lrfo * u9
    z[730] = z[27] * z[722] + z[28] * z[724]
    z[952] = mrf * ((((((((((z[951] + 2 * z[100] * z[43] + 2 * z[680] * z[560] + z[99] * z[730] + 2 * z[101] * z[690]) - 2 * z[95] * z[159]) - 2 * z[97] * z[634]) - 2 * z[97] * z[714]) - 2 * z[102] * z[698]) - 2 * z[102] * z[754]) - 2 * z[103] * z[706]) - 2 * z[104] * z[722]) - 2 * z[105] * z[738]) - 2 * z[106] * z[746])
    z[685] = (((-0.5 * z[164] - 0.5 * lrffo * u3) - 0.5 * lrffo * u5) - 0.5 * lrffo * u7) - 0.5 * lrffo * u9
    z[863] = -(z[11]) * z[16] - z[12] * z[15]
    z[112] = z[1] * z[62] + z[2] * z[63]
    z[664] = z[12] * z[654] - z[11] * z[656]
    z[889] = z[12] * z[879] - z[11] * z[881]
    z[842] = z[12] * z[832] - z[11] * z[834]
    z[114] = z[1] * z[63] - z[2] * z[62]
    z[924] = z[20] * z[114] - z[19] * z[112]
    z[815] = z[8] * z[207] - z[7] * z[208]
    z[616] = z[12] * z[606] - z[11] * z[608]
    z[736] = z[12] * z[718] - z[11] * z[720]
    z[780] = z[12] * z[770] - z[11] * z[772]
    z[740] = z[12] * z[722] - z[11] * z[724]
    z[968] = mrf * (((((((((2 * z[103] * z[863] + 2 * z[95] * z[112] + 2 * z[97] * z[664] + 2 * z[97] * z[889] + 2 * z[102] * z[842] + 2 * z[102] * z[924]) - 2 * z[682] * z[564]) - 2 * z[873] * z[8]) - 2 * z[901] * z[815]) - 2 * z[902] * z[12]) - 2 * z[680] * z[616]) - 2 * z[899] * z[736]) - 2 * z[900] * z[780]) - z[99] * z[740])
    z[905] = (z[235] + z[228] * u9 + z[229] * u3 + z[230] * u5 + z[231] * u7 + z[232] * u1 + z[233] * u2) - z[234] * u4
    z[570] = ith * lhp
    z[571] = iua * lsp
    z[576] = ith * rhp
    z[577] = iua * rsp
    z[583] = ((((((((((z[106] * z[4] + z[579] * z[6] + 0.5 * z[99] * z[161] + 0.5 * z[99] * z[256]) - z[102] * z[20]) - z[102] * z[22]) - z[578] * z[33]) - z[97] * z[147]) - z[97] * z[153]) - z[103] * z[133]) - z[104] * z[121]) - z[105] * z[113]) - z[580] * z[139]) - 0.5 * z[581] * z[127]
    z[942] = mhat * z[583]
    z[584] = z[321] + z[316] * u9 + z[317] * u3 + z[317] * u5 + z[318] * u7 + z[319] * u1 + z[320] * u2
    z[138] = z[1] * z[41] + z[2] * z[42]
    z[140] = z[1] * z[42] - z[2] * z[41]
    z[591] = z[5] * z[138] - z[6] * z[140]
    z[599] = z[41] * z[72] + z[42] * z[73]
    z[601] = z[41] * z[74] + z[42] * z[75]
    z[607] = -(z[15]) * z[599] - z[16] * z[601]
    z[609] = z[16] * z[599] - z[15] * z[601]
    z[611] = z[27] * z[607] + z[28] * z[609]
    z[603] = z[41] * z[79] + z[42] * z[80]
    z[595] = z[22] * z[140] - z[21] * z[138]
    z[623] = z[20] * z[140] - z[19] * z[138]
    z[615] = -(z[11]) * z[607] - z[12] * z[609]
    z[619] = z[3] * z[138] - z[4] * z[140]
    z[627] = ((((((((((z[100] * z[31] + 0.5 * z[99] * z[562] + z[101] * z[591] + 0.5 * z[99] * z[611]) - 0.5 * z[98] * z[18]) - z[95] * z[138]) - z[97] * z[587]) - z[97] * z[603]) - z[102] * z[595]) - z[102] * z[623]) - z[103] * z[599]) - z[104] * z[607]) - z[105] * z[615]) - z[106] * z[619]
    z[944] = mff * z[627]
    z[628] = z[39] * u1 + z[40] * u2
    z[88] = z[26] * z[83] - z[25] * z[85]
    z[152] = z[1] * z[88] + z[2] * z[89]
    z[588] = z[39] * z[88] + z[40] * z[89]
    z[589] = z[41] * z[88] + z[42] * z[89]
    z[631] = -(z[17]) * z[588] - z[18] * z[589]
    z[633] = z[18] * z[588] - z[17] * z[589]
    z[635] = z[27] * z[631] + z[28] * z[633]
    z[647] = z[72] * z[88] + z[73] * z[89]
    z[649] = z[74] * z[88] + z[75] * z[89]
    z[655] = -(z[15]) * z[647] - z[16] * z[649]
    z[657] = z[16] * z[647] - z[15] * z[649]
    z[659] = z[27] * z[655] + z[28] * z[657]
    z[651] = z[79] * z[88] + z[80] * z[89]
    z[154] = z[1] * z[89] - z[2] * z[88]
    z[671] = z[20] * z[154] - z[19] * z[152]
    z[663] = -(z[11]) * z[655] - z[12] * z[657]
    z[667] = z[3] * z[152] - z[4] * z[154]
    z[639] = -(z[13]) * z[631] - z[14] * z[633]
    z[643] = z[5] * z[152] - z[6] * z[154]
    z[677] = ((((((((((z[675] * z[26] + z[674] * z[152] + 0.5 * z[99] * z[635] + 0.5 * z[99] * z[659]) - z[97] * z[651]) - z[102] * z[671]) - z[103] * z[647]) - z[104] * z[655]) - z[105] * z[663]) - z[106] * z[667]) - z[578] * z[639]) - z[579] * z[643]) - z[580] * z[588]) - 0.5 * z[581] * z[631]
    z[946] = mla * z[677]
    z[678] = (z[402] + z[395] * u9 + z[396] * u7 + z[397] * u5 + z[398] * u3 + z[399] * u1 + z[400] * u2) - z[401] * u11
    z[763] = z[37] * z[72] + z[38] * z[73]
    z[765] = z[37] * z[74] + z[38] * z[75]
    z[771] = -(z[15]) * z[763] - z[16] * z[765]
    z[773] = z[16] * z[763] - z[15] * z[765]
    z[775] = z[27] * z[771] + z[28] * z[773]
    z[759] = z[22] * z[32] - z[21] * z[34]
    z[787] = z[20] * z[32] - z[19] * z[34]
    z[783] = z[3] * z[34] - z[4] * z[32]
    z[640] = z[14] * z[630] - z[13] * z[632]
    z[767] = z[37] * z[79] + z[38] * z[80]
    z[779] = -(z[11]) * z[771] - z[12] * z[773]
    z[791] = (((((((((((z[101] * z[10] + 0.5 * z[99] * z[44] + 0.5 * z[99] * z[775]) - z[95] * z[34]) - z[102] * z[759]) - z[102] * z[787]) - z[106] * z[783]) - z[580] * z[30]) - 0.5 * z[581] * z[14]) - z[97] * z[640]) - z[97] * z[767]) - z[103] * z[763]) - z[104] * z[771]) - z[105] * z[779]
    z[954] = msh * z[791]
    z[792] = z[179] + z[176] * u3 + z[176] * u5 + z[176] * u7 + z[176] * u9 + z[177] * u1 + z[178] * u2
    z[692] = z[5] * z[161] + z[6] * z[159]
    z[56] = z[6] * z[1] - z[5] * z[2]
    z[798] = z[54] * z[73] + z[56] * z[72]
    z[800] = z[54] * z[75] + z[56] * z[74]
    z[806] = -(z[15]) * z[798] - z[16] * z[800]
    z[808] = z[16] * z[798] - z[15] * z[800]
    z[810] = z[27] * z[806] + z[28] * z[808]
    z[795] = z[5] * z[22] - z[6] * z[21]
    z[818] = z[5] * z[20] - z[6] * z[19]
    z[814] = -(z[7]) * z[209] - z[8] * z[207]
    z[644] = z[5] * z[153] + z[6] * z[151]
    z[802] = z[54] * z[80] + z[56] * z[79]
    z[592] = z[5] * z[139] + z[6] * z[137]
    z[688] = z[5] * z[127] + z[6] * z[125]
    z[821] = (((((((((((z[578] * z[10] + 0.5 * z[99] * z[692] + 0.5 * z[99] * z[810]) - z[95] * z[6]) - z[102] * z[795]) - z[102] * z[818]) - z[105] * z[814]) - z[106] * z[209]) - z[97] * z[644]) - z[97] * z[802]) - z[103] * z[798]) - z[104] * z[806]) - z[580] * z[592]) - 0.5 * z[581] * z[688]
    z[956] = mth * z[821]
    z[822] = z[195] + z[191] * u9 + z[192] * u3 + z[192] * u5 + z[192] * u7 + z[193] * u1 + z[194] * u2
    z[700] = -(z[21]) * z[161] - z[22] * z[159]
    z[825] = z[72] * z[85] + z[73] * z[83]
    z[827] = z[74] * z[85] + z[75] * z[83]
    z[833] = -(z[15]) * z[825] - z[16] * z[827]
    z[835] = z[16] * z[825] - z[15] * z[827]
    z[837] = z[27] * z[833] + z[28] * z[835]
    z[848] = z[19] * z[22] - z[20] * z[21]
    z[845] = z[4] * z[21] - z[3] * z[22]
    z[760] = -(z[21]) * z[33] - z[22] * z[32]
    z[796] = z[6] * z[21] - z[5] * z[22]
    z[829] = z[79] * z[85] + z[80] * z[83]
    z[841] = -(z[11]) * z[833] - z[12] * z[835]
    z[596] = -(z[21]) * z[139] - z[22] * z[137]
    z[696] = -(z[21]) * z[127] - z[22] * z[125]
    z[851] = (((((((((((z[97] * z[26] + 0.5 * z[99] * z[700] + 0.5 * z[99] * z[837]) - z[102] * z[848]) - z[106] * z[845]) - z[578] * z[760]) - z[579] * z[796]) - z[674] * z[22]) - z[97] * z[829]) - z[103] * z[825]) - z[104] * z[833]) - z[105] * z[841]) - z[580] * z[596]) - 0.5 * z[581] * z[696]
    z[958] = mua * z[851]
    z[852] = z[381] + z[375] * u9 + z[376] * u7 + z[377] * u5 + z[378] * u3 + z[379] * u1 + z[380] * u2
    z[862] = z[11] * z[16] + z[12] * z[15]
    z[859] = -(z[27]) * z[16] - z[28] * z[15]
    z[132] = z[1] * z[74] + z[2] * z[75]
    z[134] = z[1] * z[75] - z[2] * z[74]
    z[865] = z[3] * z[132] - z[4] * z[134]
    z[869] = z[20] * z[134] - z[19] * z[132]
    z[876] = ((((((((((z[872] * z[862] + 0.5 * z[99] * z[859] + z[873] * z[865] + 0.5 * z[99] * z[708]) - z[874] * z[16]) - z[95] * z[132]) - z[97] * z[648]) - z[97] * z[855]) - z[102] * z[826]) - z[102] * z[869]) - z[578] * z[764]) - z[579] * z[799]) - z[580] * z[600]) - 0.5 * z[581] * z[704]
    z[960] = mff * z[876]
    z[877] = z[292] + z[283] * u8 + z[284] * u9 + z[285] * u5 + z[286] * u7 + z[287] * u3 + z[288] * u4 + z[289] * u6 + z[290] * u1 + z[291] * u2
    z[81] = z[24] * z[76] - z[23] * z[78]
    z[146] = z[1] * z[81] + z[2] * z[82]
    z[716] = z[46] * z[81] + z[47] * z[82]
    z[856] = z[72] * z[81] + z[73] * z[82]
    z[857] = z[74] * z[81] + z[75] * z[82]
    z[880] = -(z[15]) * z[856] - z[16] * z[857]
    z[882] = z[16] * z[856] - z[15] * z[857]
    z[884] = z[27] * z[880] + z[28] * z[882]
    z[652] = z[81] * z[86] + z[82] * z[87]
    z[830] = z[81] * z[83] + z[82] * z[84]
    z[888] = -(z[11]) * z[880] - z[12] * z[882]
    z[148] = z[1] * z[82] - z[2] * z[81]
    z[892] = z[3] * z[146] - z[4] * z[148]
    z[768] = z[35] * z[81] + z[36] * z[82]
    z[803] = z[54] * z[81] + z[55] * z[82]
    z[604] = z[39] * z[81] + z[40] * z[82]
    z[712] = z[50] * z[81] + z[51] * z[82]
    z[896] = ((((((((((z[675] * z[24] + z[674] * z[146] + 0.5 * z[99] * z[716] + 0.5 * z[99] * z[884]) - z[97] * z[652]) - z[102] * z[830]) - z[103] * z[856]) - z[104] * z[880]) - z[105] * z[888]) - z[106] * z[892]) - z[578] * z[768]) - z[579] * z[803]) - z[580] * z[604]) - 0.5 * z[581] * z[712]
    z[962] = mla * z[896]
    z[897] = (z[357] + z[350] * u9 + z[351] * u7 + z[352] * u5 + z[353] * u3 + z[354] * u1 + z[355] * u2) - z[356] * u10
    z[928] = (((((((((((z[873] * z[8] + 0.5 * z[99] * z[564] + 0.5 * z[99] * z[740]) - z[103] * z[863]) - z[104] * z[12]) - z[579] * z[815]) - z[95] * z[112]) - z[97] * z[664]) - z[97] * z[889]) - z[102] * z[842]) - z[102] * z[924]) - z[578] * z[780]) - z[580] * z[616]) - 0.5 * z[581] * z[736]
    z[970] = msh * z[928]
    z[748] = z[3] * z[161] + z[4] * z[159]
    z[913] = z[3] * z[256] + z[4] * z[254]
    z[846] = z[3] * z[22] - z[4] * z[21]
    z[931] = z[3] * z[20] - z[4] * z[19]
    z[784] = z[3] * z[33] + z[4] * z[32]
    z[668] = z[3] * z[153] + z[4] * z[151]
    z[893] = z[3] * z[147] + z[4] * z[145]
    z[866] = z[3] * z[133] + z[4] * z[131]
    z[909] = z[3] * z[121] + z[4] * z[119]
    z[620] = z[3] * z[139] + z[4] * z[137]
    z[744] = z[3] * z[127] + z[4] * z[125]
    z[934] = (((((((((((z[105] * z[8] + 0.5 * z[99] * z[748] + 0.5 * z[99] * z[913]) - z[95] * z[4]) - z[102] * z[846]) - z[102] * z[931]) - z[578] * z[784]) - z[579] * z[208]) - z[97] * z[668]) - z[97] * z[893]) - z[103] * z[866]) - z[104] * z[909]) - z[580] * z[620]) - 0.5 * z[581] * z[744]
    z[972] = mth * z[934]
    z[935] = z[215] + z[210] * u9 + z[211] * u3 + z[211] * u5 + z[212] * u7 + z[213] * u1 + z[214] * u2
    z[756] = -(z[19]) * z[161] - z[20] * z[159]
    z[921] = -(z[19]) * z[256] - z[20] * z[254]
    z[849] = z[20] * z[21] - z[19] * z[22]
    z[932] = z[4] * z[19] - z[3] * z[20]
    z[788] = -(z[19]) * z[33] - z[20] * z[32]
    z[819] = z[6] * z[19] - z[5] * z[20]
    z[672] = -(z[19]) * z[153] - z[20] * z[151]
    z[870] = -(z[19]) * z[133] - z[20] * z[131]
    z[917] = -(z[19]) * z[121] - z[20] * z[119]
    z[925] = -(z[19]) * z[113] - z[20] * z[111]
    z[624] = -(z[19]) * z[139] - z[20] * z[137]
    z[752] = -(z[19]) * z[127] - z[20] * z[125]
    z[938] = (((((((((((z[97] * z[24] + 0.5 * z[99] * z[756] + 0.5 * z[99] * z[921]) - z[102] * z[849]) - z[106] * z[932]) - z[578] * z[788]) - z[579] * z[819]) - z[674] * z[20]) - z[97] * z[672]) - z[103] * z[870]) - z[104] * z[917]) - z[105] * z[925]) - z[580] * z[624]) - 0.5 * z[581] * z[752]
    z[974] = mua * z[938]
    z[939] = z[336] + z[330] * u9 + z[331] * u7 + z[332] * u5 + z[333] * u3 + z[334] * u1 + z[335] * u2
    z[948] = mrf * (((((((((((2 * z[100] * z[31] + 2 * z[682] * z[562] + z[99] * z[611] + 2 * z[101] * z[591]) - 2 * z[681] * z[18]) - 2 * z[95] * z[138]) - 2 * z[97] * z[587]) - 2 * z[97] * z[603]) - 2 * z[102] * z[595]) - 2 * z[102] * z[623]) - 2 * z[103] * z[599]) - 2 * z[104] * z[607]) - 2 * z[105] * z[615]) - 2 * z[106] * z[619])
    z[964] = mrf * ((((((((((2 * z[872] * z[11] + 2 * z[95] * z[119] + 2 * z[97] * z[654] + 2 * z[97] * z[879] + 2 * z[102] * z[832] + 2 * z[102] * z[915]) - 2 * z[902]) - 2 * z[963]) - 2 * z[103] * z[15]) - 2 * z[680] * z[606]) - 2 * z[873] * z[907]) - 2 * z[899] * z[718]) - 2 * z[900] * z[770]) - 2 * z[901] * z[805]) - z[99] * z[722])
    z[903] = z[258] + z[91] * u3 + z[91] * u4 + z[91] * u6 + z[91] * u8
    z[966] = mrf * ((((((((((2 * z[103] * z[858] + 2 * z[95] * z[254] + 2 * z[97] * z[658] + 2 * z[97] * z[883] + 2 * z[102] * z[836] + 2 * z[102] * z[919]) - 2 * z[682]) - 2 * z[965]) - 2 * z[872] * z[563]) - 2 * z[680] * z[610]) - 2 * z[873] * z[911]) - 2 * z[899] * z[726]) - 2 * z[900] * z[774]) - 2 * z[901] * z[809]) - z[99] * z[730])
    z[904] = (((-0.5 * z[259] - 0.5 * lrffo * u3) - 0.5 * lrffo * u4) - 0.5 * lrffo * u6) - 0.5 * lrffo * u8
    z[967] = mrf * ((((((((2 * z[103] * z[861] + 2 * z[873] * z[7] + 2 * z[902] * z[11] + 2 * z[95] * z[111] + 2 * z[97] * z[662] + 2 * z[97] * z[887] + 2 * z[102] * z[840] + 2 * z[102] * z[923]) - 2 * z[872]) - 2 * z[682] * z[563]) - 2 * z[901] * z[813]) - 2 * z[680] * z[614]) - 2 * z[899] * z[734]) - 2 * z[900] * z[778]) - z[99] * z[738])
    z[906] = z[252] + lsh * u6 + z[236] * u9 + z[238] * u5 + z[239] * u7 + z[250] * u3 + z[251] * u4 + z[240] * u1 + z[241] * u2
    z[988] = mff * z[39]
    z[989] = mff * z[40]
    z[1011] = mrf * z[39]
    z[1012] = mrf * z[40]
    z[1093] = mrf * z[258]
    z[980] = mhat * z[321]
    z[975] = mhat * z[316]
    z[976] = mhat * z[317]
    z[977] = mhat * z[318]
    z[978] = mhat * z[319]
    z[979] = mhat * z[320]
    z[1024] = msh * z[179]
    z[1021] = msh * z[176]
    z[1022] = msh * z[177]
    z[1023] = msh * z[178]
    z[1029] = msh * z[187]
    z[1025] = msh * z[180]
    z[1026] = msh * z[186]
    z[1027] = msh * z[181]
    z[1028] = msh * z[182]
    z[1034] = mth * z[195]
    z[1030] = mth * z[191]
    z[1031] = mth * z[192]
    z[1032] = mth * z[193]
    z[1033] = mth * z[194]
    z[1040] = mth * z[203]
    z[1035] = mth * z[196]
    z[1036] = mth * z[197]
    z[1037] = mth * z[202]
    z[1038] = mth * z[198]
    z[1039] = mth * z[199]
    z[1134] = mth * z[215]
    z[1129] = mth * z[210]
    z[1130] = mth * z[211]
    z[1131] = mth * z[212]
    z[1132] = mth * z[213]
    z[1133] = mth * z[214]
    z[1149] = mua * z[336]
    z[1143] = mua * z[330]
    z[1144] = mua * z[331]
    z[1145] = mua * z[332]
    z[1146] = mua * z[333]
    z[1147] = mua * z[334]
    z[1148] = mua * z[335]
    z[1047] = mua * z[381]
    z[1041] = mua * z[375]
    z[1042] = mua * z[376]
    z[1043] = mua * z[377]
    z[1044] = mua * z[378]
    z[1045] = mua * z[379]
    z[1046] = mua * z[380]
    z[1142] = mth * z[224]
    z[1136] = mth * z[216]
    z[1137] = mth * z[217]
    z[1138] = mth * z[218]
    z[1139] = mth * z[223]
    z[1140] = mth * z[219]
    z[1141] = mth * z[220]
    z[1156] = mua * z[346]
    z[1150] = mua * z[337]
    z[1151] = mua * z[338]
    z[1152] = mua * z[339]
    z[1153] = mua * z[345]
    z[1154] = mua * z[341]
    z[1155] = mua * z[342]
    z[1055] = mua * z[391]
    z[1049] = mua * z[382]
    z[1050] = mua * z[383]
    z[1051] = mua * z[384]
    z[1052] = mua * z[390]
    z[1053] = mua * z[386]
    z[1054] = mua * z[387]
    z[1091] = mla * z[370]
    z[1084] = mla * z[358]
    z[1085] = mla * z[359]
    z[1086] = mla * z[360]
    z[1087] = mla * z[368]
    z[1088] = mla * z[369]
    z[1089] = mla * z[362]
    z[1090] = mla * z[363]
    z[1010] = mla * z[415]
    z[1003] = mla * z[403]
    z[1004] = mla * z[404]
    z[1005] = mla * z[405]
    z[1006] = mla * z[413]
    z[1007] = mla * z[414]
    z[1008] = mla * z[407]
    z[1009] = mla * z[408]
    z[1065] = mff * z[292]
    z[1056] = mff * z[283]
    z[1057] = mff * z[284]
    z[1058] = mff * z[285]
    z[1059] = mff * z[286]
    z[1060] = mff * z[287]
    z[1061] = mff * z[288]
    z[1062] = mff * z[289]
    z[1063] = mff * z[290]
    z[1064] = mff * z[291]
    z[1075] = mff * z[309]
    z[1066] = mff * z[294]
    z[1067] = mff * z[295]
    z[1068] = mff * z[296]
    z[1069] = mff * z[305]
    z[1070] = mff * z[306]
    z[1071] = mff * z[307]
    z[1072] = mff * z[308]
    z[1073] = mff * z[299]
    z[1074] = mff * z[300]
    z[1111] = mrf * z[252]
    z[1128] = msh * z[248]
    z[1104] = mrf * z[236]
    z[1105] = mrf * z[238]
    z[1106] = mrf * z[239]
    z[1107] = mrf * z[250]
    z[1108] = mrf * z[251]
    z[1121] = msh * z[236]
    z[1122] = msh * z[238]
    z[1123] = msh * z[239]
    z[1124] = msh * z[246]
    z[1125] = msh * z[247]
    z[1109] = mrf * z[240]
    z[1110] = mrf * z[241]
    z[1126] = msh * z[240]
    z[1127] = msh * z[241]
    z[48] = z[43] * z[37] + z[45] * z[35]
    z[1020] = mrf * z[164]
    z[52] = -(z[13]) * z[37] - z[14] * z[35]
    z[1018] = mrf * z[163]
    z[70] = z[27] * z[66] - z[28] * z[64]
    z[1094] = mrf * z[259]
    z[987] = mhat * z[327]
    z[981] = mhat * z[322]
    z[982] = mhat * z[323]
    z[983] = mhat * z[324]
    z[984] = mhat * z[328]
    z[985] = mhat * z[325]
    z[986] = mhat * z[326]
    z[1082] = mla * z[356]
    z[1083] = mla * z[357]
    z[1076] = mla * z[350]
    z[1077] = mla * z[351]
    z[1078] = mla * z[352]
    z[1079] = mla * z[353]
    z[1080] = mla * z[354]
    z[1081] = mla * z[355]
    z[1000] = mla * z[401]
    z[1001] = mla * z[402]
    z[994] = mla * z[395]
    z[995] = mla * z[396]
    z[996] = mla * z[397]
    z[997] = mla * z[398]
    z[998] = mla * z[399]
    z[999] = mla * z[400]
    z[993] = mff * z[156]
    z[1016] = mrf * z[157]
    z[990] = mff * z[41]
    z[991] = mff * z[42]
    z[1013] = mrf * z[41]
    z[1014] = mrf * z[42]
    z[1101] = mrf * z[234]
    z[1118] = msh * z[234]
    z[1102] = mrf * z[235]
    z[1119] = msh * z[235]
    z[1095] = mrf * z[228]
    z[1096] = mrf * z[229]
    z[1097] = mrf * z[230]
    z[1098] = mrf * z[231]
    z[1112] = msh * z[228]
    z[1113] = msh * z[229]
    z[1114] = msh * z[230]
    z[1115] = msh * z[231]
    z[1099] = mrf * z[232]
    z[1100] = mrf * z[233]
    z[1116] = msh * z[232]
    z[1117] = msh * z[233]
    z[1220] = (((z[1187] + z[1189] + z[1190] + z[1135] * z[470] + mff * (z[288] * z[497] + z[306] * z[498])) - z[1191]) - msh * (z[234] * z[478] - z[247] * z[479])) - 0.25 * mrf * ((((((((2 * z[1207] * z[483] + 2 * z[1211] * z[484] + 2 * z[251] * z[563] * z[484] + 4 * z[11] * z[251] * z[483] + 2 * z[1209] * z[486] + 4 * z[234] * z[481] + 2 * lrffo * z[563] * z[482] + 2 * lrffo * z[565] * z[481] + 2 * z[234] * z[563] * z[487] + 4 * z[91] * z[11] * z[482] + 4 * z[91] * z[12] * z[481] + 4 * z[11] * z[234] * z[486] + 4 * z[12] * z[251] * z[486]) - 4 * z[91] * z[483]) - lrffo * z[484]) - 4 * z[12] * z[234] * z[483]) - 2 * z[234] * z[565] * z[484]) - 4 * z[251] * z[482]) - 2 * z[1212] * z[487]) - 2 * z[251] * z[564] * z[487])
    z[1279] = ((((((((((z[546] * (z[234] * z[61] - z[247] * z[63]) + 0.5 * z[545] * (((lrffo * z[71] + 2 * z[234] * z[61]) - 2 * z[91] * z[67]) - 2 * z[251] * z[63]) + z[1220]) - z[1161] * z[57]) - z[265] * vrx2 * z[64]) - z[265] * vry2 * z[65]) - z[280] * vrx2 * z[66]) - z[280] * vry2 * z[67]) - z[288] * vrx1 * z[72]) - z[288] * vry1 * z[73]) - z[312] * vrx1 * z[74]) - z[312] * vry1 * z[75]) - z[543] * (z[288] * z[73] + z[306] * z[75])
    z[1217] = ((z[1214] + z[1135] * z[223] + mff * (z[287] * z[288] + z[305] * z[306])) - msh * (z[229] * z[234] - z[246] * z[247])) - 0.25 * mrf * ((((((4 * z[1205] + 4 * z[229] * z[234] + 2 * lrffo * z[229] * z[565] + 2 * lrffo * z[250] * z[563] + 2 * lrffo * z[251] * z[563] + 4 * z[91] * z[11] * z[250] + 4 * z[91] * z[11] * z[251] + 4 * z[91] * z[12] * z[229]) - 4 * z[1216]) - z[1215]) - 4 * z[250] * z[251]) - 4 * z[91] * z[12] * z[234]) - 2 * lrffo * z[234] * z[565])
    z[1218] = (z[1135] * z[219] + mff * (z[288] * z[290] + z[306] * z[299]) + 0.5 * mrf * (((((2 * z[251] * z[240] - 2 * z[234] * z[232]) - 2 * z[91] * z[11] * z[240]) - 2 * z[91] * z[12] * z[232]) - lrffo * z[563] * z[240]) - lrffo * z[565] * z[232])) - msh * (z[234] * z[232] - z[247] * z[240])
    z[1219] = (z[1135] * z[220] + mff * (z[288] * z[291] + z[306] * z[300]) + 0.5 * mrf * (((((2 * z[251] * z[241] - 2 * z[234] * z[233]) - 2 * z[91] * z[11] * z[241]) - 2 * z[91] * z[12] * z[233]) - lrffo * z[563] * z[241]) - lrffo * z[565] * z[233])) - msh * (z[234] * z[233] - z[247] * z[241])
    z[1225] = ((z[1176] + z[1180] + z[1182] + z[992] * z[434] + mff * (z[285] * z[497] + z[295] * z[498]) + mhat * (z[317] * z[505] + z[324] * z[503]) + mla * (z[352] * z[520] + z[360] * z[521]) + mla * (z[397] * z[537] + z[405] * z[538]) + msh * (z[176] * z[453] + z[186] * z[454]) + msh * (z[230] * z[478] + z[238] * z[479]) + mth * (z[192] * z[461] + z[202] * z[462]) + mth * (z[211] * z[469] + z[218] * z[470]) + mua * (z[332] * z[511] + z[339] * z[512]) + mua * (z[377] * z[528] + z[384] * z[529]) + 0.25 * mrf * (((((((lrffo * z[440] + lrfo * z[439] + z[1207] * z[439] + z[1208] * z[440] + 4 * lff * z[437] + 2 * lff * z[560] * z[440] + 2 * lrffo * z[560] * z[437] + z[1209] * z[442] + 2 * lff * z[18] * z[442]) - 2 * lff * z[17] * z[439]) - 2 * lrfo * z[17] * z[437]) - z[1210] * z[443]) - 2 * lff * z[562] * z[443]) - 2 * lrffo * z[561] * z[438]) - 2 * lrfo * z[18] * z[438])) - z[1184]) - 0.5 * mrf * ((((((z[230] * z[565] * z[484] + z[238] * z[563] * z[484] + 2 * z[11] * z[238] * z[483] + 2 * z[12] * z[230] * z[483] + 2 * z[12] * z[238] * z[486]) - 2 * z[230] * z[481]) - 2 * z[238] * z[482]) - 2 * z[11] * z[230] * z[486]) - z[230] * z[563] * z[487]) - z[238] * z[564] * z[487])
    z[1280] = (((((((((((((((((((z[1159] * z[42] + lff * (rx2 * z[41] + ry2 * z[42]) + 0.5 * z[545] * (lrffo * z[49] + lrfo * z[53] + 2 * lff * z[42]) + z[1225]) - z[262] * vrx2 * z[64]) - z[262] * vry2 * z[65]) - z[272] * vrx2 * z[66]) - z[272] * vry2 * z[67]) - z[285] * vrx1 * z[72]) - z[285] * vry1 * z[73]) - z[295] * vrx1 * z[74]) - z[295] * vry1 * z[75]) - z[542] * (z[317] * z[2] + z[324] * z[1])) - z[543] * (z[285] * z[73] + z[295] * z[75])) - z[544] * (z[352] * z[80] + z[360] * z[82])) - z[544] * (z[397] * z[87] + z[405] * z[89])) - z[545] * (z[230] * z[61] + z[238] * z[63])) - z[546] * (z[176] * z[36] + z[186] * z[38])) - z[546] * (z[230] * z[61] + z[238] * z[63])) - z[547] * (z[192] * z[55] + z[202] * z[54])) - z[547] * (z[211] * z[58] + z[218] * z[57])) - z[548] * (z[332] * z[77] + z[339] * z[76])) - z[548] * (z[377] * z[84] + z[384] * z[83])
    z[1222] = z[1221] + mff * (z[285] * z[287] + z[295] * z[305]) + mhat * (z[317]^2 + z[324] * z[328]) + mla * (z[352] * z[353] + z[360] * z[369]) + mla * (z[397] * z[398] + z[405] * z[414]) + msh * (z[176]^2 + z[186]^2) + msh * (z[229] * z[230] + z[238] * z[246]) + mth * (z[192]^2 + z[202]^2) + mth * (z[211]^2 + z[218] * z[223]) + mua * (z[332] * z[333] + z[339] * z[345]) + mua * (z[377] * z[378] + z[384] * z[390]) + 0.25 * mrf * ((z[1201] + 4 * z[1202] * z[560]) - 4 * z[1203] * z[17]) + 0.5 * mrf * (((((2 * z[229] * z[230] + 2 * z[238] * z[250]) - 2 * z[91] * z[11] * z[238]) - 2 * z[91] * z[12] * z[230]) - lrffo * z[230] * z[565]) - lrffo * z[238] * z[563])
    z[1223] = (mff * (z[285] * z[290] + z[295] * z[299]) + mhat * (z[317] * z[319] + z[324] * z[325]) + mla * (z[352] * z[354] + z[360] * z[362]) + mla * (z[397] * z[399] + z[405] * z[407]) + mrf * (z[230] * z[232] + z[238] * z[240]) + msh * (z[176] * z[177] + z[186] * z[181]) + msh * (z[230] * z[232] + z[238] * z[240]) + mth * (z[192] * z[193] + z[202] * z[198]) + mth * (z[211] * z[213] + z[218] * z[219]) + mua * (z[332] * z[334] + z[339] * z[341]) + mua * (z[377] * z[379] + z[384] * z[386]) + 0.5 * mrf * ((((lrfo * z[17] * z[41] - 2 * lff * z[41]) - lrffo * z[560] * z[41]) - lrffo * z[561] * z[39]) - lrfo * z[18] * z[39])) - z[992] * z[41]
    z[1224] = (mff * (z[285] * z[291] + z[295] * z[300]) + mhat * (z[317] * z[320] + z[324] * z[326]) + mla * (z[352] * z[355] + z[360] * z[363]) + mla * (z[397] * z[400] + z[405] * z[408]) + mrf * (z[230] * z[233] + z[238] * z[241]) + msh * (z[176] * z[178] + z[186] * z[182]) + msh * (z[230] * z[233] + z[238] * z[241]) + mth * (z[192] * z[194] + z[202] * z[199]) + mth * (z[211] * z[214] + z[218] * z[220]) + mua * (z[332] * z[335] + z[339] * z[342]) + mua * (z[377] * z[380] + z[384] * z[387]) + 0.5 * mrf * ((((lrfo * z[17] * z[42] - 2 * lff * z[42]) - lrffo * z[560] * z[42]) - lrffo * z[561] * z[40]) - lrfo * z[18] * z[40])) - z[992] * z[42]
    z[1232] = z[1187] + z[1189] + z[1190] + z[1120] * z[479] + mff * (z[289] * z[497] + z[307] * z[498]) + 0.25 * mrf * (((((((((((lrffo * z[484] + 4 * z[91] * z[483] + 2 * z[1212] * z[487] + 4 * lsh * z[482] + 2 * lsh * z[564] * z[487]) - 2 * z[1207] * z[483]) - 2 * z[1211] * z[484]) - 4 * lsh * z[11] * z[483]) - 2 * lsh * z[563] * z[484]) - 2 * z[1209] * z[486]) - 4 * lsh * z[12] * z[486]) - 4 * z[91] * z[11] * z[482]) - 4 * z[91] * z[12] * z[481]) - 2 * lrffo * z[563] * z[482]) - 2 * lrffo * z[565] * z[481])
    z[1281] = ((((((((((0.5 * z[545] * ((lrffo * z[71] - 2 * lsh * z[63]) - 2 * z[91] * z[67]) + z[1232]) - z[1164] * z[63]) - z[260] * vrx2 * z[64]) - z[260] * vry2 * z[65]) - z[281] * vrx2 * z[66]) - z[281] * vry2 * z[67]) - z[289] * vrx1 * z[72]) - z[289] * vry1 * z[73]) - z[313] * vrx1 * z[74]) - z[313] * vry1 * z[75]) - z[543] * (z[289] * z[73] + z[307] * z[75])
    z[1229] = z[1226] + z[1120] * z[246] + mff * (z[287] * z[289] + z[305] * z[307]) + 0.25 * mrf * ((((((((z[1204] + 4 * lsh * z[250]) - 4 * z[1205]) - 4 * z[1227] * z[11]) - 2 * z[1228] * z[563]) - 4 * z[91] * z[11] * z[250]) - 4 * z[91] * z[12] * z[229]) - 2 * lrffo * z[229] * z[565]) - 2 * lrffo * z[250] * z[563])
    z[1230] = z[1120] * z[240] + mff * (z[289] * z[290] + z[307] * z[299]) + 0.5 * mrf * ((((2 * lsh * z[240] - 2 * z[91] * z[11] * z[240]) - 2 * z[91] * z[12] * z[232]) - lrffo * z[563] * z[240]) - lrffo * z[565] * z[232])
    z[1231] = z[1120] * z[241] + mff * (z[289] * z[291] + z[307] * z[300]) + 0.5 * mrf * ((((2 * lsh * z[241] - 2 * z[91] * z[11] * z[241]) - 2 * z[91] * z[12] * z[233]) - lrffo * z[563] * z[241]) - lrffo * z[565] * z[233])
    z[1237] = (z[1176] + z[1180] + z[1182] + z[992] * z[434] + mff * (z[286] * z[497] + z[296] * z[498]) + mhat * (z[318] * z[505] + z[323] * z[503]) + mla * (z[351] * z[520] + z[359] * z[521]) + mla * (z[396] * z[537] + z[404] * z[538]) + msh * (z[176] * z[453] + z[186] * z[454]) + msh * (z[231] * z[478] + z[239] * z[479]) + mth * (z[192] * z[461] + z[197] * z[462]) + mth * (z[212] * z[469] + z[217] * z[470]) + mua * (z[331] * z[511] + z[338] * z[512]) + mua * (z[376] * z[528] + z[383] * z[529]) + 0.25 * mrf * (((((((lrffo * z[440] + lrfo * z[439] + z[1207] * z[439] + z[1208] * z[440] + 4 * lff * z[437] + 2 * lff * z[560] * z[440] + 2 * lrffo * z[560] * z[437] + z[1209] * z[442] + 2 * lff * z[18] * z[442]) - 2 * lff * z[17] * z[439]) - 2 * lrfo * z[17] * z[437]) - z[1210] * z[443]) - 2 * lff * z[562] * z[443]) - 2 * lrffo * z[561] * z[438]) - 2 * lrfo * z[18] * z[438])) - 0.5 * mrf * ((((((z[231] * z[565] * z[484] + z[239] * z[563] * z[484] + 2 * z[11] * z[239] * z[483] + 2 * z[12] * z[231] * z[483] + 2 * z[12] * z[239] * z[486]) - 2 * z[231] * z[481]) - 2 * z[239] * z[482]) - 2 * z[11] * z[231] * z[486]) - z[231] * z[563] * z[487]) - z[239] * z[564] * z[487])
    z[1282] = (((((((((((((((((((z[1159] * z[42] + lff * (rx2 * z[41] + ry2 * z[42]) + 0.5 * z[545] * (lrffo * z[49] + lrfo * z[53] + 2 * lff * z[42]) + z[1237]) - z[263] * vrx2 * z[64]) - z[263] * vry2 * z[65]) - z[273] * vrx2 * z[66]) - z[273] * vry2 * z[67]) - z[286] * vrx1 * z[72]) - z[286] * vry1 * z[73]) - z[296] * vrx1 * z[74]) - z[296] * vry1 * z[75]) - z[542] * (z[318] * z[2] + z[323] * z[1])) - z[543] * (z[286] * z[73] + z[296] * z[75])) - z[544] * (z[351] * z[80] + z[359] * z[82])) - z[544] * (z[396] * z[87] + z[404] * z[89])) - z[545] * (z[231] * z[61] + z[239] * z[63])) - z[546] * (z[176] * z[36] + z[186] * z[38])) - z[546] * (z[231] * z[61] + z[239] * z[63])) - z[547] * (z[192] * z[55] + z[197] * z[54])) - z[547] * (z[212] * z[58] + z[217] * z[57])) - z[548] * (z[331] * z[77] + z[338] * z[76])) - z[548] * (z[376] * z[84] + z[383] * z[83])
    z[1234] = z[1233] + mff * (z[286] * z[287] + z[296] * z[305]) + mhat * (z[317] * z[318] + z[323] * z[328]) + mla * (z[351] * z[353] + z[359] * z[369]) + mla * (z[396] * z[398] + z[404] * z[414]) + msh * (z[176]^2 + z[186]^2) + msh * (z[229] * z[231] + z[239] * z[246]) + mth * (z[192]^2 + z[197] * z[202]) + mth * (z[211] * z[212] + z[217] * z[223]) + mua * (z[331] * z[333] + z[338] * z[345]) + mua * (z[376] * z[378] + z[383] * z[390]) + 0.25 * mrf * ((z[1201] + 4 * z[1202] * z[560]) - 4 * z[1203] * z[17]) + 0.5 * mrf * (((((2 * z[229] * z[231] + 2 * z[239] * z[250]) - 2 * z[91] * z[11] * z[239]) - 2 * z[91] * z[12] * z[231]) - lrffo * z[231] * z[565]) - lrffo * z[239] * z[563])
    z[1235] = (mff * (z[286] * z[290] + z[296] * z[299]) + mhat * (z[318] * z[319] + z[323] * z[325]) + mla * (z[351] * z[354] + z[359] * z[362]) + mla * (z[396] * z[399] + z[404] * z[407]) + mrf * (z[231] * z[232] + z[239] * z[240]) + msh * (z[176] * z[177] + z[186] * z[181]) + msh * (z[231] * z[232] + z[239] * z[240]) + mth * (z[192] * z[193] + z[197] * z[198]) + mth * (z[212] * z[213] + z[217] * z[219]) + mua * (z[331] * z[334] + z[338] * z[341]) + mua * (z[376] * z[379] + z[383] * z[386]) + 0.5 * mrf * ((((lrfo * z[17] * z[41] - 2 * lff * z[41]) - lrffo * z[560] * z[41]) - lrffo * z[561] * z[39]) - lrfo * z[18] * z[39])) - z[992] * z[41]
    z[1236] = (mff * (z[286] * z[291] + z[296] * z[300]) + mhat * (z[318] * z[320] + z[323] * z[326]) + mla * (z[351] * z[355] + z[359] * z[363]) + mla * (z[396] * z[400] + z[404] * z[408]) + mrf * (z[231] * z[233] + z[239] * z[241]) + msh * (z[176] * z[178] + z[186] * z[182]) + msh * (z[231] * z[233] + z[239] * z[241]) + mth * (z[192] * z[194] + z[197] * z[199]) + mth * (z[212] * z[214] + z[217] * z[220]) + mua * (z[331] * z[335] + z[338] * z[342]) + mua * (z[376] * z[380] + z[383] * z[387]) + 0.5 * mrf * ((((lrfo * z[17] * z[42] - 2 * lff * z[42]) - lrffo * z[560] * z[42]) - lrffo * z[561] * z[40]) - lrfo * z[18] * z[40])) - z[992] * z[42]
    z[1243] = z[1187] + z[1189] + mff * (z[283] * z[497] + z[308] * z[498]) + 0.25 * mrf * ((((((((lrffo * z[484] + 4 * z[91] * z[483] + 2 * z[1212] * z[487]) - 2 * z[1207] * z[483]) - 2 * z[1211] * z[484]) - 2 * z[1209] * z[486]) - 4 * z[91] * z[11] * z[482]) - 4 * z[91] * z[12] * z[481]) - 2 * lrffo * z[563] * z[482]) - 2 * lrffo * z[565] * z[481])
    z[1283] = ((((((0.5 * z[545] * (lrffo * z[71] - 2 * z[91] * z[67]) + z[1243]) - z[283] * vrx1 * z[72]) - z[283] * vry1 * z[73]) - z[314] * vrx1 * z[74]) - z[314] * vry1 * z[75]) - lrf * (vrx2 * z[66] + vry2 * z[67])) - z[543] * (z[283] * z[73] + z[308] * z[75])
    z[1240] = z[1238] + mff * (z[283] * z[287] + z[305] * z[308]) + 0.25 * mrf * ((((z[1239] - 4 * z[91] * z[11] * z[250]) - 4 * z[91] * z[12] * z[229]) - 2 * lrffo * z[229] * z[565]) - 2 * lrffo * z[250] * z[563])
    z[1241] = mff * (z[283] * z[290] + z[308] * z[299]) - 0.5 * mrf * (lrffo * z[563] * z[240] + lrffo * z[565] * z[232] + 2 * z[91] * z[11] * z[240] + 2 * z[91] * z[12] * z[232])
    z[1242] = mff * (z[283] * z[291] + z[308] * z[300]) - 0.5 * mrf * (lrffo * z[563] * z[241] + lrffo * z[565] * z[233] + 2 * z[91] * z[11] * z[241] + 2 * z[91] * z[12] * z[233])
    z[1248] = (z[1176] + z[1180] + z[992] * z[434] + mff * (z[284] * z[497] + z[294] * z[498]) + mhat * (z[316] * z[505] + z[322] * z[503]) + mla * (z[350] * z[520] + z[358] * z[521]) + mla * (z[395] * z[537] + z[403] * z[538]) + msh * (z[176] * z[453] + z[180] * z[454]) + msh * (z[228] * z[478] + z[236] * z[479]) + mth * (z[191] * z[461] + z[196] * z[462]) + mth * (z[210] * z[469] + z[216] * z[470]) + mua * (z[330] * z[511] + z[337] * z[512]) + mua * (z[375] * z[528] + z[382] * z[529]) + 0.25 * mrf * (((((((lrffo * z[440] + lrfo * z[439] + z[1207] * z[439] + z[1208] * z[440] + 4 * lff * z[437] + 2 * lff * z[560] * z[440] + 2 * lrffo * z[560] * z[437] + z[1209] * z[442] + 2 * lff * z[18] * z[442]) - 2 * lff * z[17] * z[439]) - 2 * lrfo * z[17] * z[437]) - z[1210] * z[443]) - 2 * lff * z[562] * z[443]) - 2 * lrffo * z[561] * z[438]) - 2 * lrfo * z[18] * z[438])) - 0.5 * mrf * ((((((z[228] * z[565] * z[484] + z[236] * z[563] * z[484] + 2 * z[11] * z[236] * z[483] + 2 * z[12] * z[228] * z[483] + 2 * z[12] * z[236] * z[486]) - 2 * z[228] * z[481]) - 2 * z[236] * z[482]) - 2 * z[11] * z[228] * z[486]) - z[228] * z[563] * z[487]) - z[236] * z[564] * z[487])
    z[1284] = (((((((((((((((((((z[1159] * z[42] + lff * (rx2 * z[41] + ry2 * z[42]) + 0.5 * z[545] * (lrffo * z[49] + lrfo * z[53] + 2 * lff * z[42]) + z[1248]) - z[261] * vrx2 * z[64]) - z[261] * vry2 * z[65]) - z[270] * vrx2 * z[66]) - z[270] * vry2 * z[67]) - z[284] * vrx1 * z[72]) - z[284] * vry1 * z[73]) - z[294] * vrx1 * z[74]) - z[294] * vry1 * z[75]) - z[542] * (z[316] * z[2] + z[322] * z[1])) - z[543] * (z[284] * z[73] + z[294] * z[75])) - z[544] * (z[350] * z[80] + z[358] * z[82])) - z[544] * (z[395] * z[87] + z[403] * z[89])) - z[545] * (z[228] * z[61] + z[236] * z[63])) - z[546] * (z[176] * z[36] + z[180] * z[38])) - z[546] * (z[228] * z[61] + z[236] * z[63])) - z[547] * (z[191] * z[55] + z[196] * z[54])) - z[547] * (z[210] * z[58] + z[216] * z[57])) - z[548] * (z[330] * z[77] + z[337] * z[76])) - z[548] * (z[375] * z[84] + z[382] * z[83])
    z[1245] = z[1244] + mff * (z[284] * z[287] + z[294] * z[305]) + mhat * (z[316] * z[317] + z[322] * z[328]) + mla * (z[350] * z[353] + z[358] * z[369]) + mla * (z[395] * z[398] + z[403] * z[414]) + msh * (z[176]^2 + z[180] * z[186]) + msh * (z[228] * z[229] + z[236] * z[246]) + mth * (z[191] * z[192] + z[196] * z[202]) + mth * (z[210] * z[211] + z[216] * z[223]) + mua * (z[330] * z[333] + z[337] * z[345]) + mua * (z[375] * z[378] + z[382] * z[390]) + 0.25 * mrf * ((z[1201] + 4 * z[1202] * z[560]) - 4 * z[1203] * z[17]) + 0.5 * mrf * (((((2 * z[228] * z[229] + 2 * z[236] * z[250]) - 2 * z[91] * z[11] * z[236]) - 2 * z[91] * z[12] * z[228]) - lrffo * z[228] * z[565]) - lrffo * z[236] * z[563])
    z[1246] = (mff * (z[284] * z[290] + z[294] * z[299]) + mhat * (z[316] * z[319] + z[322] * z[325]) + mla * (z[350] * z[354] + z[358] * z[362]) + mla * (z[395] * z[399] + z[403] * z[407]) + mrf * (z[228] * z[232] + z[236] * z[240]) + msh * (z[176] * z[177] + z[180] * z[181]) + msh * (z[228] * z[232] + z[236] * z[240]) + mth * (z[191] * z[193] + z[196] * z[198]) + mth * (z[210] * z[213] + z[216] * z[219]) + mua * (z[330] * z[334] + z[337] * z[341]) + mua * (z[375] * z[379] + z[382] * z[386]) + 0.5 * mrf * ((((lrfo * z[17] * z[41] - 2 * lff * z[41]) - lrffo * z[560] * z[41]) - lrffo * z[561] * z[39]) - lrfo * z[18] * z[39])) - z[992] * z[41]
    z[1247] = (mff * (z[284] * z[291] + z[294] * z[300]) + mhat * (z[316] * z[320] + z[322] * z[326]) + mla * (z[350] * z[355] + z[358] * z[363]) + mla * (z[395] * z[400] + z[403] * z[408]) + mrf * (z[228] * z[233] + z[236] * z[241]) + msh * (z[176] * z[178] + z[180] * z[182]) + msh * (z[228] * z[233] + z[236] * z[241]) + mth * (z[191] * z[194] + z[196] * z[199]) + mth * (z[210] * z[214] + z[216] * z[220]) + mua * (z[330] * z[335] + z[337] * z[342]) + mua * (z[375] * z[380] + z[382] * z[387]) + 0.5 * mrf * ((((lrfo * z[17] * z[42] - 2 * lff * z[42]) - lrffo * z[560] * z[42]) - lrffo * z[561] * z[40]) - lrfo * z[18] * z[40])) - z[992] * z[42]
    z[1253] = ((z[1188] + z[1048] * z[512]) - z[1192]) - mla * (z[356] * z[520] - z[368] * z[521])
    z[1285] = (z[544] * (z[356] * z[80] - z[368] * z[82]) + z[1253]) - z[1169] * z[76]
    z[1250] = (z[1249] + z[1048] * z[345]) - mla * (z[353] * z[356] - z[368] * z[369])
    z[1251] = z[1048] * z[341] - mla * (z[356] * z[354] - z[368] * z[362])
    z[1252] = z[1048] * z[342] - mla * (z[356] * z[355] - z[368] * z[363])
    z[1257] = ((z[1178] + z[1048] * z[529]) - z[1186]) - mla * (z[401] * z[537] - z[413] * z[538])
    z[1286] = (z[544] * (z[401] * z[87] - z[413] * z[89]) + z[1257]) - z[1169] * z[83]
    z[1254] = (z[1249] + z[1048] * z[390]) - mla * (z[398] * z[401] - z[413] * z[414])
    z[1255] = z[1048] * z[386] - mla * (z[401] * z[399] - z[413] * z[407])
    z[1256] = z[1048] * z[387] - mla * (z[401] * z[400] - z[413] * z[408])
    z[1258] = ila + z[1002] * z[369]
    z[1259] = z[1002] * z[362]
    z[1260] = z[1002] * z[363]
    z[1173] = z[1172] * z[82]
    z[1261] = z[1188] + z[1002] * z[521]
    z[1277] = z[1173] - z[1261]
    z[1262] = ila + z[1002] * z[414]
    z[1263] = z[1002] * z[407]
    z[1264] = z[1002] * z[408]
    z[1174] = z[1172] * z[89]
    z[1265] = z[1178] + z[1002] * z[538]
    z[1278] = z[1174] - z[1265]
    z[420] = z[96] * (((lkp - lap) - lhp) - lmtpp)
    z[421] = z[97] * (lep - lsp)
    z[422] = z[98] * ((lap + lhp) - lkp)
    z[423] = z[99] * ((lap + lhp) - lkp)
    z[424] = z[100] * (lhp - lkp)
    z[425] = z[101] * lhp
    z[426] = z[102] * lsp
    z[427] = z[103] * (((rkp - rap) - rhp) - rmtpp)
    z[428] = z[97] * (rep - rsp)
    z[429] = z[104] * ((rap + rhp) - rkp)
    z[430] = z[99] * ((rap + rhp) - rkp)
    z[431] = z[105] * (rhp - rkp)
    z[432] = z[106] * rhp
    z[433] = z[102] * rsp

end


function pop2x(sol, t)
    @unpack z, lff = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q1 - lff * z[39]
end

pop2x(sol) = [pop2x(sol, t) for t in sol.t]

function pop2y(sol, t)
    @unpack z, lff = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q2 - lff * z[40]
end

pop2y(sol) = [pop2y(sol, t) for t in sol.t]


function pop10x(sol, t)
    @unpack z, lff, lrf, lsh, lth, = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q1 + lrf * z[64] + lsh * z[60] + lth * z[57] - lff * z[39] - lrf * z[50] - lsh * z[35] - lth * z[54]
end

pop10x(sol) = [pop10x(sol, t) for t in sol.t]

function pop10y(sol, t)
    @unpack z, lff, lrf, lsh, lth, = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q2 + lrf * z[65] + lsh * z[61] + lth * z[58] - lff * z[40] - lrf * z[51] - lsh * z[36] - lth * z[55]
end

pop10y(sol) = [pop10y(sol, t) for t in sol.t]

function pop11x(sol, t)
    @unpack z, lff, lrf, lsh, lth, = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q1 + lff * z[72] + lrf * z[64] + lsh * z[60] + lth * z[57] - lff * z[39] - lrf * z[50] - lsh * z[35] - lth * z[54]
end

pop11x(sol) = [pop11x(sol, t) for t in sol.t]

function pop11y(sol, t)
    @unpack z, lff, lrf, lsh, lth, = sol.prob.p
    @inbounds q1, q2, q3, u1, u2, u3 = sol(t)

    # set z array values
    eom(SA[q1, q2, q3, u1, u2, u3], sol.prob.p, t)
    io(sol, t)

    return q2 + lff * z[73] + lrf * z[65] + lsh * z[61] + lth * z[58] - lff * z[40] - lrf * z[51] - lsh * z[36] - lth * z[55]
end

pop11y(sol) = [pop11y(sol, t) for t in sol.t]

rx1(sol, t) = contact_forces(sol(t), sol.prob.p, t)[1]
ry1(sol, t) = contact_forces(sol(t), sol.prob.p, t)[2]
rx2(sol, t) = contact_forces(sol(t), sol.prob.p, t)[3]
ry2(sol, t) = contact_forces(sol(t), sol.prob.p, t)[4]
vrx1(sol, t) = contact_forces(sol(t), sol.prob.p, t)[5]
vry1(sol, t) = contact_forces(sol(t), sol.prob.p, t)[6]
vrx2(sol, t) = contact_forces(sol(t), sol.prob.p, t)[7]
vry2(sol, t) = contact_forces(sol(t), sol.prob.p, t)[8]

rx(sol, t) = rx1(sol, t) + rx2(sol, t)
ry(sol, t) = ry1(sol, t) + ry2(sol, t)
vrx(sol, t) = vrx1(sol, t) + vrx2(sol, t)
vry(sol, t) = vry1(sol, t) + vry2(sol, t)

RX(sol, t) = rx(sol, t) + vrx(sol, t)
RY(sol, t) = ry(sol, t) + vry(sol, t)
RX(sol) = [RX(sol, t) for t in sol.t]
RY(sol) = [RY(sol, t) for t in sol.t]


function vocmx(u, p, t)
    @unpack footang, g, iff, ihat, ila, irf, ish, ith, iua, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lhato, lla, llao, lmtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, ltoexi, lua, luao, mff, mhat, mla, mrf, msh, mth, mtpb, mtpk, mua, rmtpxi, rtoexi, u4, u5, u6, u7, u8, u9, u10, u11, u12, u13, z = p
    @inbounds q1, q2, q3, u1, u2, u3 = u

    # specified variables
    la = _la(t)
    lap = _lap(t)
    le = _le(t)
    lep = _lep(t)
    lh = _lh(t)
    lhp = _lhp(t)
    lk = _lk(t)
    lkp = _lkp(t)
    lmtp = _lmtp(t)
    lmtpp = _lmtpp(t)
    ls = _ls(t)
    lsp = _lsp(t)
    ra = _ra(t)
    rap = _rap(t)
    re = _re(t)
    rep = _rep(t)
    rh = _rh(t)
    rhp = _rhp(t)
    rk = _rk(t)
    rkp = _rkp(t)
    rmtp = _rmtp(t)
    rmtpp = _rmtpp(t)
    rs = _rs(t)
    rsp = _rsp(t)

    return u1 - 0.5 * (2 * (lhato * mhat + 2 * lhat * mla + 2 * lhat * mua) * sin(q3) * u3 + 2 * llao * mla * sin(ls - le - q3) * (lsp - lep - u11 - u13 - u3) + 2 * llao * mla * sin(rs - re - q3) * (rsp - rep - u10 - u12 - u3) + 2 * (lth * mff + lth * mrf + lth * msh + mth * (lth - ltho)) * sin(rh - q3) * (rhp - u3 - u4) + (2 * lrf * mff + mrf * (2 * lrf - lrfo)) * sin(ra + rh - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) + 2 * (lsh * mff + lsh * mhat + lsh * mrf + lsh * msh + lsho * msh + 2 * lsh * mla + 2 * lsh * mth + 2 * lsh * mua) * sin(lh - lk - q3) * (lhp - lkp - u3 - u5 - u7) + 2 * (lff * mff + lff * mhat + lffo * mff + 2 * lff * mla + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth + 2 * lff * mua) * sin(la + lh + lmtp - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9) - 2 * (lua * mla + luao * mua) * sin(ls - q3) * (lsp - u11 - u3) - 2 * (lua * mla + luao * mua) * sin(rs - q3) * (rsp - u10 - u3) - lrffo * mrf * sin(la + lh - footang - lk - q3) * (lap + lhp - lkp - u3 - u5 - u7 - u9) - lrffo * mrf * sin(ra + rh - footang - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) - 2 * (lsh * mff + lsh * mrf + msh * (lsh - lsho)) * sin(rh - rk - q3) * (rhp - rkp - u3 - u4 - u6) - 2 * mff * (lff - lffo) * sin(ra + rh + rmtp - rk - q3) * (rap + rhp + rmtpp - rkp - u3 - u4 - u6 - u8) - 2 * (lth * mff + lth * mhat + lth * mrf + lth * msh + lth * mth + ltho * mth + 2 * lth * mla + 2 * lth * mua) * sin(lh - q3) * (lhp - u3 - u5) - (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mrf + 4 * lrf * mla + 4 * lrf * msh + 4 * lrf * mth + 4 * lrf * mua) * sin(la + lh - lk - q3) * (lap + lhp - lkp - u3 - u5 - u7 - u9)) / (mhat + 2 * mff + 2 * mla + 2 * mrf + 2 * msh + 2 * mth + 2 * mua)
end

function vocmy(u, p, t)
    @unpack footang, g, iff, ihat, ila, irf, ish, ith, iua, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lhato, lla, llao, lmtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, ltoexi, lua, luao, mff, mhat, mla, mrf, msh, mth, mtpb, mtpk, mua, rmtpxi, rtoexi, u4, u5, u6, u7, u8, u9, u10, u11, u12, u13, z = p
    @inbounds q1, q2, q3, u1, u2, u3 = u

    # specified variables
    la = _la(t)
    lap = _lap(t)
    le = _le(t)
    lep = _lep(t)
    lh = _lh(t)
    lhp = _lhp(t)
    lk = _lk(t)
    lkp = _lkp(t)
    lmtp = _lmtp(t)
    lmtpp = _lmtpp(t)
    ls = _ls(t)
    lsp = _lsp(t)
    ra = _ra(t)
    rap = _rap(t)
    re = _re(t)
    rep = _rep(t)
    rh = _rh(t)
    rhp = _rhp(t)
    rk = _rk(t)
    rkp = _rkp(t)
    rmtp = _rmtp(t)
    rmtpp = _rmtpp(t)
    rs = _rs(t)
    rsp = _rsp(t)

    return u2 - 0.5 * (2 * llao * mla * cos(ls - le - q3) * (lsp - lep - u11 - u13 - u3) + 2 * llao * mla * cos(rs - re - q3) * (rsp - rep - u10 - u12 - u3) + 2 * (lth * mff + lth * mrf + lth * msh + mth * (lth - ltho)) * cos(rh - q3) * (rhp - u3 - u4) + (2 * lrf * mff + mrf * (2 * lrf - lrfo)) * cos(ra + rh - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) + 2 * (lsh * mff + lsh * mhat + lsh * mrf + lsh * msh + lsho * msh + 2 * lsh * mla + 2 * lsh * mth + 2 * lsh * mua) * cos(lh - lk - q3) * (lhp - lkp - u3 - u5 - u7) + 2 * (lff * mff + lff * mhat + lffo * mff + 2 * lff * mla + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth + 2 * lff * mua) * cos(la + lh + lmtp - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9) - 2 * (lhato * mhat + 2 * lhat * mla + 2 * lhat * mua) * cos(q3) * u3 - 2 * (lua * mla + luao * mua) * cos(ls - q3) * (lsp - u11 - u3) - 2 * (lua * mla + luao * mua) * cos(rs - q3) * (rsp - u10 - u3) - lrffo * mrf * cos(la + lh - footang - lk - q3) * (lap + lhp - lkp - u3 - u5 - u7 - u9) - lrffo * mrf * cos(ra + rh - footang - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) - 2 * (lsh * mff + lsh * mrf + msh * (lsh - lsho)) * cos(rh - rk - q3) * (rhp - rkp - u3 - u4 - u6) - 2 * mff * (lff - lffo) * cos(ra + rh + rmtp - rk - q3) * (rap + rhp + rmtpp - rkp - u3 - u4 - u6 - u8) - 2 * (lth * mff + lth * mhat + lth * mrf + lth * msh + lth * mth + ltho * mth + 2 * lth * mla + 2 * lth * mua) * cos(lh - q3) * (lhp - u3 - u5) - (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mrf + 4 * lrf * mla + 4 * lrf * msh + 4 * lrf * mth + 4 * lrf * mua) * cos(la + lh - lk - q3) * (lap + lhp - lkp - u3 - u5 - u7 - u9)) / (mhat + 2 * mff + 2 * mla + 2 * mrf + 2 * msh + 2 * mth + 2 * mua)
end