# Automatically generated
struct Params{T,F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15}
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
    ae::T
	af::T
	footang::T
	g::T
	he::T
	hf::T
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
	ke::T
	kf::T
	l1::T
	l10::T
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

end

# initialise with constant values
function Params(ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap, eapp, fapp, gspp, happ, iapp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, inh, ini, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mh, mi, mtpb, mtpk, pop1xi, pop2xi)
    z = Vector{Float64}(undef, 688)
    mt = ma + mb + mc + md + me + mf + mg
	u8 = 0
	u9 = 0
	u10 = 0
	u11 = 0
    z[21] = l10 - l9
	z[222] = g * me
	z[528] = z[21] * z[222]
	z[651] = inf + inh + ini
	z[22] = l8 - l7
	z[484] = mf * z[22]
	z[660] = inh + ini
	z[578] = l6 * l8
	z[25] = l2 - l1
	z[509] = mi * z[25]
	z[7] = cos(footang)
	z[8] = sin(footang)
	z[23] = l6 - l4
	z[24] = 0.5l6 + 0.5 * z[23]
	z[74] = ma + mb + mc + md + me + mf + mg + mh + mi
	z[75] = (l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg + l2 * mh + l2 * mi) / z[74]
	z[76] = (l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg + 2 * l6 * mh + 2 * l6 * mi) / z[74]
	z[77] = (l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg + l8 * mh + l8 * mi) / z[74]
	z[78] = (l10 * me + l10 * mf + l10 * mg + l10 * mh + l10 * mi + l9 * md) / z[74]
	z[79] = (l10 * mf + l10 * mh + l10 * mi + me * z[21]) / z[74]
	z[80] = (l8 * mh + l8 * mi + mf * z[22]) / z[74]
	z[82] = (l6 * mi + mh * z[24]) / z[74]
	z[83] = (mi * z[25]) / z[74]
	z[84] = (l3 * mh) / z[74]
	z[85] = (l3 * mb) / z[74]
	z[86] = ma + mb + mc + md
	z[87] = (l1 * ma + l2 * mb + l2 * mc + l2 * md) / z[86]
	z[88] = (l4 * mb + 2 * l6 * mc + 2 * l6 * md) / z[86]
	z[89] = (l7 * mc + l8 * md) / z[86]
	z[90] = (l9 * md) / z[86]
	z[91] = (l3 * mb) / z[86]
	z[92] = me + mf + mh + mi
	z[93] = (l2 * (me + mf + mh + mi)) / z[92]
	z[94] = (l6 * (me + mf + mh + mi)) / z[92]
	z[95] = (l8 * (me + mf + mh + mi)) / z[92]
	z[96] = (l10 * (me + mf + mh + mi)) / z[92]
	z[97] = (l10 * mf + l10 * mh + l10 * mi + me * z[21]) / z[92]
	z[98] = (l8 * mh + l8 * mi + mf * z[22]) / z[92]
	z[99] = (l6 * mi + mh * z[24]) / z[92]
	z[100] = (mi * z[25]) / z[92]
	z[101] = (l3 * mh) / z[92]
	z[218] = g * ma
	z[219] = g * mb
	z[220] = g * mc
	z[221] = g * md
	z[223] = g * mf
	z[224] = g * mg
	z[225] = g * mh
	z[226] = g * mi
	z[346] = z[75] - l1
	z[347] = z[75] - l2
	z[348] = 0.5l4 - 0.5 * z[76]
	z[349] = 0.5l3 - 0.5 * z[85]
	z[377] = l6 - 0.5 * z[76]
	z[378] = l7 - z[77]
	z[379] = l8 - z[77]
	z[380] = l9 - z[78]
	z[381] = l10 - z[78]
	z[382] = z[21] - z[79]
	z[383] = l10 - z[79]
	z[384] = z[22] - z[80]
	z[386] = l8 - z[80]
	z[387] = z[24] - z[82]
	z[388] = 0.5 * z[84] - 0.5l3
	z[392] = l6 - z[82]
	z[393] = z[25] - z[83]
	z[398] = 2 * z[348] + 2 * z[7] * z[349]
	z[402] = 2 * z[349] + 2 * z[7] * z[348]
	z[405] = z[7] * z[85]
	z[445] = 2 * z[387] + 2 * z[7] * z[388]
	z[449] = 2 * z[388] + 2 * z[7] * z[387]
	z[457] = 2 * z[392] + z[7] * z[84]
	z[462] = l1 * ma
	z[463] = l2 * mb
	z[464] = l4 * mb
	z[465] = l3 * mb
	z[466] = l2 * mc
	z[467] = l6 * mc
	z[468] = l7 * mc
	z[469] = l2 * md
	z[470] = l6 * md
	z[471] = l8 * md
	z[472] = l9 * md
	z[473] = l2 * me
	z[474] = l6 * me
	z[475] = l8 * me
	z[476] = l10 * me
	z[477] = me * z[21]
	z[479] = l2 * mf
	z[480] = l6 * mf
	z[481] = l8 * mf
	z[482] = l10 * mf
	z[486] = l2 * mg
	z[487] = l6 * mg
	z[488] = l8 * mg
	z[489] = l10 * mg
	z[492] = l2 * mh
	z[493] = l6 * mh
	z[494] = l8 * mh
	z[495] = l10 * mh
	z[498] = mh * z[24]
	z[500] = l3 * mh
	z[502] = l2 * mi
	z[503] = l6 * mi
	z[504] = l8 * mi
	z[505] = l10 * mi
	z[512] = z[218] + z[219] + z[220] + z[221] + z[222] + z[223] + z[224] + z[225] + z[226]
	z[514] = l1 * z[218]
	z[516] = l2 * z[219]
	z[517] = l2 * z[220]
	z[518] = l2 * z[221]
	z[519] = l2 * z[222]
	z[520] = l2 * z[223]
	z[521] = l2 * z[224]
	z[522] = l2 * z[225]
	z[523] = l2 * z[226]
	z[530] = z[22] * z[223]
	z[533] = z[25] * z[226]
	z[552] = l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg + l2 * mh + l2 * mi
	z[564] = ina + inb + inc + ind + ine + inf + ing + inh + ini + ma * l1 ^ 2
	z[565] = l3 ^ 2 + l4 ^ 2 + 4 * l2 ^ 2 + 2 * l3 * l4 * z[7]
	z[566] = l2 * l3
	z[567] = l2 * l4
	z[568] = l2 * l6
	z[569] = l2 * l7
	z[570] = l2 ^ 2
	z[571] = l6 ^ 2
	z[572] = l7 ^ 2
	z[573] = l6 * l7
	z[574] = l2 * l8
	z[575] = l2 * l9
	z[576] = l8 ^ 2
	z[577] = l9 ^ 2
	z[579] = l6 * l9
	z[580] = l8 * l9
	z[581] = l10 * l2
	z[582] = l2 * z[21]
	z[583] = l10 ^ 2
	z[584] = z[21] ^ 2
	z[585] = l10 * l6
	z[586] = l10 * l8
	z[587] = l10 * z[21]
	z[588] = l6 * z[21]
	z[589] = l8 * z[21]
	z[590] = l10 * z[22]
	z[591] = l2 * z[22]
	z[592] = z[22] ^ 2
	z[593] = l6 * z[22]
	z[594] = l8 * z[22]
	z[595] = l6 * z[25]
	z[596] = l2 * z[25]
	z[597] = z[25] ^ 2
	z[598] = l10 * z[25]
	z[599] = l8 * z[25]
	z[600] = l3 * z[7] * z[24]
	z[601] = l8 * z[24]
	z[602] = l10 * l3
	z[603] = l3 * l6
	z[604] = l3 * l8
	z[605] = l2 * z[24]
	z[606] = l3 ^ 2
	z[607] = z[24] ^ 2
	z[608] = l10 * z[24]
	z[609] = l6 * z[24]
	z[611] = -ina - ma * l1 ^ 2
	z[613] = ma * l1 ^ 2
	z[617] = l3 * z[8]
	z[618] = l4 * z[8]
	z[619] = z[8] * z[24]
	z[620] = l3 * z[7]
	z[621] = z[7] * z[24]
	z[623] = ina + ma * l1 ^ 2 + mb * l2 ^ 2 + mc * l2 ^ 2 + md * l2 ^ 2 + me * l2 ^ 2 + mf * l2 ^ 2 + mg * l2 ^ 2 + mh * l2 ^ 2 + mi * l2 ^ 2
	z[624] = ina + ma * l1 ^ 2
	z[629] = ina + inb + ma * l1 ^ 2
	z[630] = l2 ^ 2 + l6 ^ 2
	z[635] = ina + inb + inc + ma * l1 ^ 2
	z[639] = ina + inb + inc + ind + ma * l1 ^ 2
	z[642] = ine + inf + inh + ini
	z[675] = l2 * mi * z[25]

    return Params(z, ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap, eapp, fapp, gspp, happ, iapp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, inh, ini, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mh, mi, mtpb, mtpk, pop1xi, pop2xi, mt, u8, u9, u10, u11)
end
