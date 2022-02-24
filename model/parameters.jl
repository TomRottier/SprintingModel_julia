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

end

# initialise with constant values
function Params(ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap, eapp, fapp, gspp, happ, iapp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, inh, ini, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l11, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mh, mi, mtpb, mtpk, pop1xi, pop2xi)
    z = Vector{Float64}(undef, 687)
    mt = ma + mb + mc + md + me + mf + mg
	u8 = 0
	u9 = 0
	u10 = 0
	u11 = 0
    z[21] = l10 - l9
	z[222] = g * me
	z[521] = z[21] * z[222]
	z[650] = inf + inh + ini
	z[22] = l8 - l7
	z[480] = mf * z[22]
	z[659] = inh + ini
	z[25] = l2 - l1
	z[502] = mi * z[25]
	z[7] = cos(footang)
	z[8] = sin(footang)
	z[23] = l6 - l4
	z[24] = 0.5l6 + 0.5 * z[23]
	z[74] = ma + mb + mc + md + me + mf + mg + mh + mi
	z[75] = (l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg + l2 * mh + l2 * mi) / z[74]
	z[76] = (l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg + 2 * l6 * mh + 2 * l6 * mi) / z[74]
	z[77] = (l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg + l8 * mh + l8 * mi) / z[74]
	z[78] = (l10 * me + l10 * mf + l10 * mg + l10 * mh + l10 * mi + l9 * md) / z[74]
	z[79] = (l10 * mf + l10 * mh + me * z[21]) / z[74]
	z[80] = (l8 * mh + mf * z[22]) / z[74]
	z[81] = l11 * mi
	z[83] = (mh * z[24]) / z[74]
	z[84] = (mi * z[25]) / z[74]
	z[85] = (l3 * mh) / z[74]
	z[86] = (l3 * mb) / z[74]
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
	z[98] = (l10 * mf + l10 * mh + me * z[21]) / z[93]
	z[99] = (l8 * mh + mf * z[22]) / z[93]
	z[100] = (l11 * mi) / z[93]
	z[101] = (mh * z[24]) / z[93]
	z[102] = (mi * z[25]) / z[93]
	z[103] = (l3 * mh) / z[93]
	z[218] = g * ma
	z[219] = g * mb
	z[220] = g * mc
	z[221] = g * md
	z[223] = g * mf
	z[224] = g * mg
	z[225] = g * mh
	z[226] = g * mi
	z[338] = z[75] - l1
	z[339] = z[75] - l2
	z[340] = 0.5l4 - 0.5 * z[76]
	z[341] = 0.5l3 - 0.5 * z[86]
	z[369] = l6 - 0.5 * z[76]
	z[370] = l7 - z[77]
	z[371] = l8 - z[77]
	z[372] = l9 - z[78]
	z[373] = l10 - z[78]
	z[374] = z[21] - z[79]
	z[379] = l10 - z[79]
	z[380] = z[22] - z[80]
	z[385] = l8 - z[80]
	z[386] = z[24] - z[83]
	z[387] = 0.5 * z[85] - 0.5l3
	z[392] = z[25] - z[84]
	z[397] = 2 * z[340] + 2 * z[7] * z[341]
	z[401] = 2 * z[341] + 2 * z[7] * z[340]
	z[404] = z[7] * z[86]
	z[444] = 2 * z[386] + 2 * z[7] * z[387]
	z[448] = 2 * z[387] + 2 * z[7] * z[386]
	z[458] = l1 * ma
	z[459] = l2 * mb
	z[460] = l4 * mb
	z[461] = l3 * mb
	z[462] = l2 * mc
	z[463] = l6 * mc
	z[464] = l7 * mc
	z[465] = l2 * md
	z[466] = l6 * md
	z[467] = l8 * md
	z[468] = l9 * md
	z[469] = l2 * me
	z[470] = l6 * me
	z[471] = l8 * me
	z[472] = l10 * me
	z[473] = me * z[21]
	z[475] = l2 * mf
	z[476] = l6 * mf
	z[477] = l8 * mf
	z[478] = l10 * mf
	z[482] = l2 * mg
	z[483] = l6 * mg
	z[484] = l8 * mg
	z[485] = l10 * mg
	z[488] = l2 * mh
	z[489] = l6 * mh
	z[490] = l8 * mh
	z[491] = l10 * mh
	z[494] = mh * z[24]
	z[496] = l3 * mh
	z[498] = l2 * mi
	z[499] = l6 * mi
	z[500] = l8 * mi
	z[501] = l10 * mi
	z[505] = z[218] + z[219] + z[220] + z[221] + z[222] + z[223] + z[224] + z[225] + z[226]
	z[507] = l1 * z[218]
	z[509] = l2 * z[219]
	z[510] = l2 * z[220]
	z[511] = l2 * z[221]
	z[512] = l2 * z[222]
	z[513] = l2 * z[223]
	z[514] = l2 * z[224]
	z[515] = l2 * z[225]
	z[516] = l2 * z[226]
	z[522] = z[25] * z[226]
	z[524] = z[22] * z[223]
	z[545] = l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg + l2 * mh + l2 * mi
	z[557] = ina + inb + inc + ind + ine + inf + ing + inh + ini + ma * l1 ^ 2
	z[558] = l3 ^ 2 + l4 ^ 2 + 4 * l2 ^ 2 + 2 * l3 * l4 * z[7]
	z[559] = l2 * l3
	z[560] = l2 * l4
	z[561] = l2 * l6
	z[562] = l2 * l7
	z[563] = l2 ^ 2
	z[564] = l6 ^ 2
	z[565] = l7 ^ 2
	z[566] = l6 * l7
	z[567] = l2 * l8
	z[568] = l2 * l9
	z[569] = l8 ^ 2
	z[570] = l9 ^ 2
	z[571] = l6 * l8
	z[572] = l6 * l9
	z[573] = l8 * l9
	z[574] = l10 * l2
	z[575] = l2 * z[21]
	z[576] = l10 ^ 2
	z[577] = z[21] ^ 2
	z[578] = l10 * l6
	z[579] = l10 * l8
	z[580] = l10 * z[21]
	z[581] = l6 * z[21]
	z[582] = l8 * z[21]
	z[583] = l10 * z[22]
	z[584] = l2 * z[22]
	z[585] = z[22] ^ 2
	z[586] = l6 * z[22]
	z[587] = l8 * z[22]
	z[588] = l11 * l2
	z[589] = l2 * z[25]
	z[590] = l11 ^ 2
	z[591] = z[25] ^ 2
	z[592] = l10 * l11
	z[593] = l10 * z[25]
	z[594] = l11 * l6
	z[595] = l11 * l8
	z[596] = l11 * z[25]
	z[597] = l6 * z[25]
	z[598] = l8 * z[25]
	z[599] = l3 * z[7] * z[24]
	z[600] = l8 * z[24]
	z[601] = l10 * l3
	z[602] = l3 * l6
	z[603] = l3 * l8
	z[604] = l2 * z[24]
	z[605] = l3 ^ 2
	z[606] = z[24] ^ 2
	z[607] = l10 * z[24]
	z[608] = l6 * z[24]
	z[610] = -ina - ma * l1 ^ 2
	z[612] = ma * l1 ^ 2
	z[616] = l3 * z[8]
	z[617] = l4 * z[8]
	z[618] = z[8] * z[24]
	z[619] = l3 * z[7]
	z[620] = z[7] * z[24]
	z[622] = ina + ma * l1 ^ 2 + mb * l2 ^ 2 + mc * l2 ^ 2 + md * l2 ^ 2 + me * l2 ^ 2 + mf * l2 ^ 2 + mg * l2 ^ 2 + mh * l2 ^ 2 + mi * l2 ^ 2
	z[623] = ina + ma * l1 ^ 2
	z[628] = ina + inb + ma * l1 ^ 2
	z[629] = l2 ^ 2 + l6 ^ 2
	z[634] = ina + inb + inc + ma * l1 ^ 2
	z[638] = ina + inb + inc + ind + ma * l1 ^ 2
	z[641] = ine + inf + inh + ini
	z[674] = l2 * mi * z[25]

    return Params(z, ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap, eapp, fapp, gspp, happ, iapp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, inh, ini, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l11, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mh, mi, mtpb, mtpk, pop1xi, pop2xi, mt, u8, u9, u10, u11)
end
