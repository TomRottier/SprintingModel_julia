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
    z = Vector{Float64}(undef, 863)
    mt = ma + mb + mc + md + me + mf + mg
	u8 = 0
	u9 = 0
	u10 = 0
	u11 = 0
    z[21] = l10 - l9
	z[383] = g * me
	z[739] = z[21] * z[383]
	z[825] = inf + inh + ini
	z[22] = l8 - l7
	z[660] = mf * z[22]
	z[836] = inh + ini
	z[26] = l2 - l1
	z[718] = mi * z[26]
	z[7] = cos(footang)
	z[8] = sin(footang)
	z[23] = l6 - l4
	z[24] = 0.5l6 + 0.5 * z[23]
	z[25] = 0.5l3 - 0.5l5
	z[75] = ma + mb + mc + md + me + mf + mg + mh + mi
	z[76] = (l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg + l2 * mh + l2 * mi) / z[75]
	z[77] = (l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg + 2 * l6 * mh + 2 * l6 * mi) / z[75]
	z[78] = (l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg + l8 * mh + l8 * mi) / z[75]
	z[79] = (l10 * me + l10 * mf + l10 * mg + l10 * mh + l10 * mi + l9 * md) / z[75]
	z[80] = (l10 * mf + l10 * mh + l10 * mi + me * z[21]) / z[75]
	z[81] = (l8 * mh + l8 * mi + mf * z[22]) / z[75]
	z[83] = (l6 * mi + mh * z[24]) / z[75]
	z[84] = (mi * z[26]) / z[75]
	z[85] = (mh * z[25]) / z[75]
	z[86] = (l3 * mb) / z[75]
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
	z[98] = (l10 * mf + l10 * mh + l10 * mi + me * z[21]) / z[93]
	z[99] = (l8 * mh + l8 * mi + mf * z[22]) / z[93]
	z[100] = (l6 * mi + mh * z[24]) / z[93]
	z[101] = (mi * z[26]) / z[93]
	z[102] = (mh * z[25]) / z[93]
	z[379] = g * ma
	z[380] = g * mb
	z[381] = g * mc
	z[382] = g * md
	z[384] = g * mf
	z[385] = g * mg
	z[386] = g * mh
	z[387] = g * mi
	z[423] = z[76] - l1
	z[428] = z[76] - l2
	z[429] = 0.5l4 - 0.5 * z[77]
	z[430] = 0.5l3 - 0.5 * z[86]
	z[504] = 2l6 - z[77]
	z[505] = l2 - z[76]
	z[526] = l8 - z[78]
	z[542] = l10 - z[79]
	z[550] = l10 - z[80]
	z[555] = l6 - 0.5 * z[77]
	z[558] = l8 - z[81]
	z[559] = z[24] - z[83]
	z[560] = z[25] - z[85]
	z[567] = l6 - z[83]
	z[576] = z[429] + z[7] * z[430]
	z[578] = z[430] + z[7] * z[429]
	z[593] = 2 * z[559] + 2 * z[7] * z[560]
	z[595] = 2 * z[560] + 2 * z[7] * z[559]
	z[601] = l1 * ma
	z[606] = l2 * mb
	z[609] = l4 * mb
	z[610] = l3 * mb
	z[642] = me * z[21]
	z[693] = l8 * mh
	z[703] = mh * z[24]
	z[705] = mh * z[25]
	z[732] = l1 * z[379]
	z[734] = l2 * z[380]
	z[741] = z[22] * z[384]
	z[744] = z[26] * z[387]
	z[777] = ina + inb + inc + ind + ine + inf + ing + inh + ini + ma * l1 ^ 2
	z[778] = l3 ^ 2 + l4 ^ 2 + 4 * l2 ^ 2 + 2 * l3 * l4 * z[7]
	z[779] = l2 * l3
	z[780] = l2 * l4
	z[781] = z[24] ^ 2
	z[782] = z[25] ^ 2
	z[783] = z[7] * z[24] * z[25]
	z[785] = ma * l1 ^ 2
	z[790] = l3 * z[8]
	z[791] = l4 * z[8]
	z[792] = z[7] * z[24]
	z[793] = z[7] * z[25]
	z[794] = z[8] * z[25]
	z[795] = z[8] * z[24]
	z[797] = ina + ma * l1 ^ 2 + mb * l2 ^ 2
	z[799] = ina + ma * l1 ^ 2
	z[804] = ina + inb + ma * l1 ^ 2
	z[809] = ina + inb + inc + ma * l1 ^ 2
	z[813] = ina + inb + inc + ind + ma * l1 ^ 2
	z[816] = ine + inf + inh + ini
	z[826] = l8 * z[24]
	z[827] = l8 * z[25]

    return Params(z, ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap, eapp, fapp, gspp, happ, iapp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, inh, ini, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l11, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mh, mi, mtpb, mtpk, pop1xi, pop2xi, mt, u8, u9, u10, u11)
end
