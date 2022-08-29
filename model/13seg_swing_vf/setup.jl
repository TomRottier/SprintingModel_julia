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
    parameters="model/13seg_swing_vf/parameters.csv",
    initial_conditions="model/13seg_swing_vf/initial_conditions.csv",
    torque_generator_parameters="data/torque_generator_parameters.csv",
    activation_parameters="data/activation_parameters.csv",
    matching_data="data/matching_data.csv")

    # load parameters
    inputs = readdlm(parameters, ',', header=true)
    input_p, headers_p = convert(Vector{Float64}, inputs[1][:, 3]), Symbol.(inputs[1][:, 1])

    lff, mff, lffo, iff, lrf, mrf, lrfo, irf, lsh, msh, lsho, ish, lth, mth, ltho, ith, lhat, mhat, lhato, ihat, lua, mua, luao, iua, lla, mla, llao, ila, footang, g, k1, k2, k3, k4, k5, k6, k7, k8, mtpb, mtpk, toexi, mtpxi, lrffo, lrff = input_p
    u8 = u9 = u10 = u11 = u12 = u13 = u14 = 0.0
    footang = deg2rad(footang)

    # load initial conditions
    inputs = readdlm(initial_conditions, ',', header=true)
    input_u, header_u = convert(Vector{Float64}, inputs[1][:, 3]), Symbol.(inputs[1][:, 1])
    @inbounds Xmtp, Ymtp, q3, q7, q6, q5, q4, vcmx, vcmy, u3, u7, u6, u5, u4 = input_u

    # load torque generator parameters
    tq_p, headers_tq = readdlm(torque_generator_parameters, ',', header=true)
    tq_p = map(eachrow(tq_p)) do x
        x = x[2:end] .|> Float64    # remove row names, convert to float
        [CCParameters(x[1:end-1]...), SECParameters(x[end])]
    end

    # load activation profiles
    α_p, headers_α = readdlm(activation_parameters, ',', header=true)
    α_p = map(eachrow(α_p)) do x
        x = x[2:end] .|> Float64    # remove row names, convert to float
        ActivationProfile(x...)
    end

    # load matching data
    input_matching, headers_matching = readdlm(matching_data, ',', header=true)
    input_matching = Matrix{Float64}(input_matching[2:end, :]) # remove units row
    matching_data = Dict(Symbol(h) => ts for (h, ts) in zip(headers_matching, eachcol(input_matching)))

    # intial specified angles
    rmtp₀ = _rmtp(0.0)
    ra₀ = _ra(0.0)
    rk₀ = _rk(0.0)
    rh₀ = _rh(0.0)
    rs₀ = _rs(0.0)
    ls₀ = _ls(0.0)
    re₀ = _re(0.0)
    le₀ = _le(0.0)
    rmtpp₀ = _rmtpp(0.0)
    rap₀ = _rap(0.0)
    rkp₀ = _rkp(0.0)
    rhp₀ = _rhp(0.0)
    rsp₀ = _rsp(0.0)
    lsp₀ = _lsp(0.0)
    rep₀ = _rep(0.0)
    lep₀ = _lep(0.0)

    # convert initial conditions into generalised coordinates and speeds
    q3 = q3 |> deg2rad              # q3 = q3
    q4 = q4 |> deg2rad
    q5 = q5 |> deg2rad
    q6 = q6 |> deg2rad
    q7 = q7 |> deg2rad
    q1 = Xmtp - lff * cos(q3 + q5 - q4 - q6 - q7)
    q2 = Ymtp - lff * sin(q3 + q5 - q4 - q6 - q7)
    u3 = u3 |> deg2rad
    u4 = u4 |> deg2rad
    u5 = u5 |> deg2rad
    u6 = u6 |> deg2rad
    u7 = u7 |> deg2rad

    # u1 = 1.78872
    # u2 = -3.877485
    u1_fun(rmtp, ra, rk, rh, rs, ls, re, le, rmtpp, rap, rkp, rhp, rsp, lsp, rep, lep) = vcmx - 0.5 * (2 * (lua * mla + luao * mua) * sin(ls - q3) * (lsp - u12 - u3) + 2 * (lua * mla + luao * mua) * sin(rs - q3) * (rsp - u11 - u3) + lrffo * mrf * sin(footang + q3 + q5 - q4 - q6) * (u3 + u5 - u4 - u6) + lrffo * mrf * sin(ra + rh - footang - rk - q3) * (rap + rhp - rkp - u10 - u3 - u8 - u9) + 2 * (lsh * mff + lsh * mrf + msh * (lsh - lsho)) * sin(rh - rk - q3) * (rhp - rkp - u3 - u8 - u9) + 2 * (lth * mff + lth * mhat + lth * mrf + lth * msh + lth * mth + ltho * mth + 2 * lth * mla + 2 * lth * mua) * sin(q3 - q4) * (u3 - u4) + 2 * mff * (lff - lffo) * sin(ra + rh + rmtp - rk - q3) * (rap + rhp + rmtpp - rkp - u10 - u3 - u8 - u9) + (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mrf + 4 * lrf * mla + 4 * lrf * msh + 4 * lrf * mth + 4 * lrf * mua) * sin(q3 + q5 - q4 - q6) * (u3 + u5 - u4 - u6) - 2 * (lhato * mhat + 2 * lhat * mla + 2 * lhat * mua) * sin(q3) * u3 - 2 * llao * mla * sin(ls - le - q3) * (lsp - lep - u12 - u14 - u3) - 2 * llao * mla * sin(rs - re - q3) * (rsp - rep - u11 - u13 - u3) - 2 * (lth * mff + lth * mrf + lth * msh + mth * (lth - ltho)) * sin(rh - q3) * (rhp - u3 - u8) - (2 * lrf * mff + mrf * (2 * lrf - lrfo)) * sin(ra + rh - rk - q3) * (rap + rhp - rkp - u10 - u3 - u8 - u9) - 2 * (lsh * mff + lsh * mhat + lsh * mrf + lsh * msh + lsho * msh + 2 * lsh * mla + 2 * lsh * mth + 2 * lsh * mua) * sin(q4 - q3 - q5) * (u4 - u3 - u5) - 2 * (lff * mff + lff * mhat + lffo * mff + 2 * lff * mla + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth + 2 * lff * mua) * sin(q3 + q5 - q4 - q6 - q7) * (u3 + u5 - u4 - u6 - u7)) / (mhat + 2 * mff + 2 * mla + 2 * mrf + 2 * msh + 2 * mth + 2 * mua)
    u2_fun(rmtp, ra, rk, rh, rs, ls, re, le, rmtpp, rap, rkp, rhp, rsp, lsp, rep, lep) = vcmy + 0.5 * (lrffo * mrf * cos(footang + q3 + q5 - q4 - q6) * (u3 + u5 - u4 - u6) + 2 * llao * mla * cos(ls - le - q3) * (lsp - lep - u12 - u14 - u3) + 2 * llao * mla * cos(rs - re - q3) * (rsp - rep - u11 - u13 - u3) + 2 * (lth * mff + lth * mrf + lth * msh + mth * (lth - ltho)) * cos(rh - q3) * (rhp - u3 - u8) + 2 * (lth * mff + lth * mhat + lth * mrf + lth * msh + lth * mth + ltho * mth + 2 * lth * mla + 2 * lth * mua) * cos(q3 - q4) * (u3 - u4) + (2 * lrf * mff + mrf * (2 * lrf - lrfo)) * cos(ra + rh - rk - q3) * (rap + rhp - rkp - u10 - u3 - u8 - u9) + 2 * (lsh * mff + lsh * mhat + lsh * mrf + lsh * msh + lsho * msh + 2 * lsh * mla + 2 * lsh * mth + 2 * lsh * mua) * cos(q4 - q3 - q5) * (u4 - u3 - u5) + (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mrf + 4 * lrf * mla + 4 * lrf * msh + 4 * lrf * mth + 4 * lrf * mua) * cos(q3 + q5 - q4 - q6) * (u3 + u5 - u4 - u6) - 2 * (lhato * mhat + 2 * lhat * mla + 2 * lhat * mua) * cos(q3) * u3 - 2 * (lua * mla + luao * mua) * cos(ls - q3) * (lsp - u12 - u3) - 2 * (lua * mla + luao * mua) * cos(rs - q3) * (rsp - u11 - u3) - lrffo * mrf * cos(ra + rh - footang - rk - q3) * (rap + rhp - rkp - u10 - u3 - u8 - u9) - 2 * (lsh * mff + lsh * mrf + msh * (lsh - lsho)) * cos(rh - rk - q3) * (rhp - rkp - u3 - u8 - u9) - 2 * mff * (lff - lffo) * cos(ra + rh + rmtp - rk - q3) * (rap + rhp + rmtpp - rkp - u10 - u3 - u8 - u9) - 2 * (lff * mff + lff * mhat + lffo * mff + 2 * lff * mla + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth + 2 * lff * mua) * cos(q3 + q5 - q4 - q6 - q7) * (u3 + u5 - u4 - u6 - u7)) / (mhat + 2 * mff + 2 * mla + 2 * mrf + 2 * msh + 2 * mth + 2 * mua)
    u1 = u1_fun(rmtp₀, ra₀, rk₀, rh₀, rs₀, ls₀, re₀, le₀, rmtpp₀, rap₀, rkp₀, rhp₀, rsp₀, lsp₀, rep₀, lep₀)
    u2 = u2_fun(rmtp₀, ra₀, rk₀, rh₀, rs₀, ls₀, re₀, le₀, rmtpp₀, rap₀, rkp₀, rhp₀, rsp₀, lsp₀, rep₀, lep₀)

    # set up torque generators
    he = TorqueGenerator(2π - q4, -u4, tq_p[1][1], tq_p[1][2], α_p[1])
    ke = TorqueGenerator(2π - q5, -u5, tq_p[2][1], tq_p[2][2], α_p[2])
    ae = TorqueGenerator(2π - q6, -u6, tq_p[3][1], tq_p[3][2], α_p[3])
    hf = TorqueGenerator(q4, u4, tq_p[4][1], tq_p[4][2], α_p[4])
    kf = TorqueGenerator(q5, u5, tq_p[5][1], tq_p[5][2], α_p[5])
    af = TorqueGenerator(q6, u6, tq_p[6][1], tq_p[6][2], α_p[6])

    # intial CC angles
    θcc₀ = map(x -> x.cc.θ, [he, ke, ae, hf, kf, af])

    # parameters
    p = Params(ae, af, footang, g, he, hf, iff, ihat, ila, irf, ish, ith, iua, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, lff, lffo, lhat, lhato, lla, llao, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, lua, luao, mff, mhat, mla, mrf, msh, mth, mtpb, mtpk, mtpxi, mua, toexi)

    # intial conditions
    u₀ = SVector(q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7, θcc₀...)

    return p, u₀, matching_data
end
