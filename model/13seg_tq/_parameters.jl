# Automatically generated
                 struct Params{T}
                     z::Vector{T}
                     footang::T
	g::T
	iff::T
	ihat::T
	ila::T
	irf::T
	ish::T
	ith::T
	iua::T
	k1::T
	k2::T
	k3::T
	k4::T
	k5::T
	k6::T
	k7::T
	k8::T
	lae::T
	laf::T
	lff::T
	lffo::T
	lhat::T
	lhato::T
	lhe::T
	lhf::T
	lke::T
	lkf::T
	lla::T
	llao::T
	lrf::T
	lrff::T
	lrffo::T
	lrfo::T
	lsh::T
	lsho::T
	lth::T
	ltho::T
	lua::T
	luao::T
	mff::T
	mhat::T
	mla::T
	mrf::T
	msh::T
	mth::T
	mtpb::T
	mtpk::T
	mtpxi::T
	mua::T
	rae::T
	raf::T
	rhe::T
	rhf::T
	rke::T
	rkf::T
	toexi::T
	u12::T
	u13::T
	u14::T
	u15::T
                 
                 end
                 
                 # initialise with constant values
                 function Params(footang, g, iff, ihat, ila, irf, ish, ith, iua, k1, k2, k3, k4, k5, k6, k7, k8, lae, laf, lff, lffo, lhat, lhato, lhe, lhf, lke, lkf, lla, llao, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, lua, luao, mff, mhat, mla, mrf, msh, mth, mtpb, mtpk, mtpxi, mua, rae, raf, rhe, rhf, rke, rkf, toexi)
                     z = Vector{Float64}(undef, 1272)
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
	z[1140] = ihat + 2iff + 2ila + 2irf + 2ish + 2ith + 2iua + mff * lffo ^ 2
	z[1141] = lrffo ^ 2 + lrfo ^ 2 + 4 * lff ^ 2 + 2 * lrffo * lrfo * z[27]
	z[1142] = lff * lrffo
	z[1143] = lff * lrfo
	z[1144] = lrffo ^ 2 + 4 * z[91] ^ 2
	z[1145] = lrffo * z[27] * z[91]
	z[1147] = iff + irf + ish + mff * lffo ^ 2
	z[1149] = mff * lffo ^ 2
	z[1153] = -iff - irf
	z[1154] = (lrffo ^ 2 + 4 * z[91] ^ 2) - 4 * lrffo * z[27] * z[91]
	z[1158] = iff + irf + ish
	z[1159] = lsh * z[91]
	z[1160] = lrffo * lsh
	z[1162] = lrffo * z[28]
	z[1163] = lrfo * z[28]
	z[1164] = z[28] * z[91]
	z[1167] = iff + irf + ish + ith + mff * lffo ^ 2
	z[1169] = iff + irf + mff * lffo ^ 2
	z[1171] = iff + mff * lffo ^ 2
	z[1193] = iff + mff * lffo ^ 2 + mrf * lff ^ 2
	z[1200] = iff + irf
	z[1201] = (4 * lrffo * z[27] * z[91] - lrffo ^ 2) - 4 * z[91] ^ 2
	z[1204] = iff + irf + ish + ith + mth * z[93] ^ 2
	z[1206] = lrffo ^ 2
	z[1207] = z[91] ^ 2
	z[1212] = iff + irf + ish + msh * z[92] ^ 2
	z[1213] = (lrffo ^ 2 + 4 * lsh ^ 2 + 4 * z[91] ^ 2) - 4 * lrffo * z[27] * z[91]
	z[1216] = iff + irf + 0.25 * mrf * ((lrffo ^ 2 + 4 * z[91] ^ 2) - 4 * lrffo * z[27] * z[91])
	z[1220] = iff + mff * z[90] ^ 2
	z[1222] = ila + iua
                 
                     return Params(z, footang, g, iff, ihat, ila, irf, ish, ith, iua, k1, k2, k3, k4, k5, k6, k7, k8, lae, laf, lff, lffo, lhat, lhato, lhe, lhf, lke, lkf, lla, llao, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, lua, luao, mff, mhat, mla, mrf, msh, mth, mtpb, mtpk, mtpxi, mua, rae, raf, rhe, rhf, rke, rkf, toexi, u12, u13, u14, u15)
                 end
                 