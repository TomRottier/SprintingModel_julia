# setup model
# struct to hold values
struct Inputs
    parameters::Dict{Symbol,Float64}
    initial_conditions::Dict{Symbol,Float64}
    torque_parameters::Dict{Symbol,Dict{Symbol,Float64}}
    activation_parameters::Dict{Symbol,Vector{Float64}}
    matching_data::Dict{Symbol,Vector{Float64}}
end

function setup(;
    parameters="model/13seg_ad/parameters.csv",
    initial_conditions="model/13seg_ad/initial_conditions.csv",
    matching_data="data/matchingData.csv")

    # load parameters
    inputs = readdlm(parameters, ',', header=true)
    input_p, headers_p = convert(Vector{Float64}, inputs[1][:, 3]), Symbol.(inputs[1][:, 1])

    lff, mff, lffo, iff, lrf, mrf, lrfo, irf, lsh, msh, lsho, ish, lth, mth, ltho, ith, lhat, mhat, lhato, ihat, lua, mua, luao, iua, lla, mla, llao, ila, footang, g, k1, k2, k3, k4, k5, k6, k7, k8, mtpb, mtpk, ltoexi, rtoexi, lmtpxi, rmtpxi, lrffo, lrff = input_p
    u4 = u5 = u6 = u6 = u7 = u8 = u9 = u10 = u11 = u12 = u13 = 0.0
    footang = deg2rad(footang)

    # load initial conditions
    inputs = readdlm(initial_conditions, ',', header=true)
    input_u, header_u = convert(Vector{Float64}, inputs[1][:, 3]), Symbol.(inputs[1][:, 1])
    @inbounds Xmtp, Ymtp, q3, vcmx, vcmy, u3 = input_u

    # load matching data
    input_matching, headers_matching = readdlm(matching_data, ',', header=true)
    input_matching = Matrix{Float64}(input_matching[2:end, :]) # remove units row
    matching_data = Dict(Symbol(h) => ts for (h, ts) in zip(headers_matching, eachcol(input_matching)))

    # intial specified angles
    rmtp₀ = _rmtp(0.0)
    lmtp₀ = _lmtp(0.0)
    ra₀ = _ra(0.0)
    la₀ = _la(0.0)
    rk₀ = _rk(0.0)
    lk₀ = _lk(0.0)
    rh₀ = _rh(0.0)
    lh₀ = _lh(0.0)
    rs₀ = _rs(0.0)
    ls₀ = _ls(0.0)
    re₀ = _re(0.0)
    le₀ = _le(0.0)
    rmtpp₀ = _rmtpp(0.0)
    lmtpp₀ = _lmtpp(0.0)
    rap₀ = _rap(0.0)
    lap₀ = _lap(0.0)
    rkp₀ = _rkp(0.0)
    lkp₀ = _lkp(0.0)
    rhp₀ = _rhp(0.0)
    lhp₀ = _lhp(0.0)
    rsp₀ = _rsp(0.0)
    lsp₀ = _lsp(0.0)
    rep₀ = _rep(0.0)
    lep₀ = _lep(0.0)

    # convert initial conditions into generalised coordinates and speeds
    q3 = q3 |> deg2rad              # q3 = q3
    q1 = Xmtp - lff * cos(ra₀ + rh₀ + lmtp₀ - lk₀ - q3)   # POP2X = Q1 + LFF*COS(LA+LH+LMTP-LK-Q3)  (MTP contacts first)
    q2 = Ymtp + lff * sin(la₀ + lh₀ + lmtp₀ - lk₀ - q3)   # POP2Y = Q2 - LFF*SIN(LA+LH+LMTP-LK-Q3)
    u3 = u3 |> deg2rad              # u3 = u3

    # u1 = 1.78872
    # u2 = -3.877485
    u1_fun(rmtp, lmtp, ra, la, rk, lk, rh, lh, rs, ls, re, le, rmtpp, lmtpp, rap, lap, rkp, lkp, rhp, lhp, rsp, lsp, rep, lep) = vcmx + 0.5 * (2 * (lhato * mhat + 2 * lhat * mla + 2 * lhat * mua) * sin(q3) * u3 + 2 * (lua * mla + luao * mua) * sin(ls + q3) * (lsp + u11 + u3) + 2 * (lua * mla + luao * mua) * sin(rs + q3) * (rsp + u10 + u3) + 2 * llao * mla * sin(le + ls + q3) * (lep + lsp + u11 + u13 + u3) + 2 * llao * mla * sin(re + rs + q3) * (rep + rsp + u10 + u12 + u3) + 2 * (lth * mff + lth * mrf + lth * msh + mth * (lth - ltho)) * sin(rh - q3) * (rhp - u3 - u4) + (2 * lrf * mff + mrf * (2 * lrf - lrfo)) * sin(ra + rh - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) + 2 * (lsh * mff + lsh * mhat + lsh * mrf + lsh * msh + lsho * msh + 2 * lsh * mla + 2 * lsh * mth + 2 * lsh * mua) * sin(lh - lk - q3) * (lhp - lkp - u3 - u5 - u7) + 2 * (lff * mff + lff * mhat + lffo * mff + 2 * lff * mla + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth + 2 * lff * mua) * sin(la + lh + lmtp - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9) - lrffo * mrf * sin(la + lh - footang - lk - q3) * (lap + lhp - lkp - u3 - u5 - u7 - u9) - lrffo * mrf * sin(ra + rh - footang - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) - 2 * (lsh * mff + lsh * mrf + msh * (lsh - lsho)) * sin(rh - rk - q3) * (rhp - rkp - u3 - u4 - u6) - 2 * mff * (lff - lffo) * sin(ra + rh + rmtp - rk - q3) * (rap + rhp + rmtpp - rkp - u3 - u4 - u6 - u8) - 2 * (lth * mff + lth * mhat + lth * mrf + lth * msh + lth * mth + ltho * mth + 2 * lth * mla + 2 * lth * mua) * sin(lh - q3) * (lhp - u3 - u5) - (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mrf + 4 * lrf * mla + 4 * lrf * msh + 4 * lrf * mth + 4 * lrf * mua) * sin(la + lh - lk - q3) * (lap + lhp - lkp - u3 - u5 - u7 - u9)) / (mhat + 2 * mff + 2 * mla + 2 * mrf + 2 * msh + 2 * mth + 2 * mua)
    u2_fun(rmtp, lmtp, ra, la, rk, lk, rh, lh, rs, ls, re, le, rmtpp, lmtpp, rap, lap, rkp, lkp, rhp, lhp, rsp, lsp, rep, lep) = vcmy + 0.5 * (2 * (lth * mff + lth * mrf + lth * msh + mth * (lth - ltho)) * cos(rh - q3) * (rhp - u3 - u4) + (2 * lrf * mff + mrf * (2 * lrf - lrfo)) * cos(ra + rh - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) + 2 * (lsh * mff + lsh * mhat + lsh * mrf + lsh * msh + lsho * msh + 2 * lsh * mla + 2 * lsh * mth + 2 * lsh * mua) * cos(lh - lk - q3) * (lhp - lkp - u3 - u5 - u7) + 2 * (lff * mff + lff * mhat + lffo * mff + 2 * lff * mla + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth + 2 * lff * mua) * cos(la + lh + lmtp - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9) - 2 * (lhato * mhat + 2 * lhat * mla + 2 * lhat * mua) * cos(q3) * u3 - 2 * (lua * mla + luao * mua) * cos(ls + q3) * (lsp + u11 + u3) - 2 * (lua * mla + luao * mua) * cos(rs + q3) * (rsp + u10 + u3) - 2 * llao * mla * cos(le + ls + q3) * (lep + lsp + u11 + u13 + u3) - 2 * llao * mla * cos(re + rs + q3) * (rep + rsp + u10 + u12 + u3) - lrffo * mrf * cos(la + lh - footang - lk - q3) * (lap + lhp - lkp - u3 - u5 - u7 - u9) - lrffo * mrf * cos(ra + rh - footang - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) - 2 * (lsh * mff + lsh * mrf + msh * (lsh - lsho)) * cos(rh - rk - q3) * (rhp - rkp - u3 - u4 - u6) - 2 * mff * (lff - lffo) * cos(ra + rh + rmtp - rk - q3) * (rap + rhp + rmtpp - rkp - u3 - u4 - u6 - u8) - 2 * (lth * mff + lth * mhat + lth * mrf + lth * msh + lth * mth + ltho * mth + 2 * lth * mla + 2 * lth * mua) * cos(lh - q3) * (lhp - u3 - u5) - (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mrf + 4 * lrf * mla + 4 * lrf * msh + 4 * lrf * mth + 4 * lrf * mua) * cos(la + lh - lk - q3) * (lap + lhp - lkp - u3 - u5 - u7 - u9)) / (mhat + 2 * mff + 2 * mla + 2 * mrf + 2 * msh + 2 * mth + 2 * mua)
    u1 = u1_fun(rmtp₀, lmtp₀, ra₀, la₀, rk₀, lk₀, rh₀, lh₀, rs₀, ls₀, re₀, le₀, rmtpp₀, lmtpp₀, rap₀, lap₀, rkp₀, lkp₀, rhp₀, lhp₀, rsp₀, lsp₀, rep₀, lep₀)
    u2 = u2_fun(rmtp₀, lmtp₀, ra₀, la₀, rk₀, lk₀, rh₀, lh₀, rs₀, ls₀, re₀, le₀, rmtpp₀, lmtpp₀, rap₀, lap₀, rkp₀, lkp₀, rhp₀, lhp₀, rsp₀, lsp₀, rep₀, lep₀)

    # parameters
    p = Params(footang, g, iff, ihat, ila, irf, ish, ith, iua, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lhato, lla, llao, lmtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, ltoexi, lua, luao, mff, mhat, mla, mrf, msh, mth, mtpb, mtpk, mua, rmtpxi, rtoexi)

    # intial conditions
    u₀ = SVector(q1, q2, q3, u1, u2, u3)

    return p, u₀, matching_data
end
