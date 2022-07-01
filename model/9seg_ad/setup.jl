# setup model
# struct to hold values
struct Inputs
    parameters::Dict{Symbol,Float64}
    initial_conditions::Dict{Symbol,Float64}
    torque_parameters::Dict{Symbol,Dict{Symbol,Float64}}
    activation_parameters::Dict{Symbol,Vector{Float64}}
    matching_data::Dict{Symbol,Vector{Float64}}
end

function load_inputs(;
    parameters="data/parameters.csv",
    initial_conditions="data/initial_conditions.csv",
    matching="data/matchingData.csv")

    # load parameters
    input_p, headers_p = readdlm(parameters, ',', header=true)
    input_p = Vector{Float64}(input_p[2, :]) # remove units row
    p = Dict(Symbol(h) => v for (h, v) in zip(headers_p, input_p))

    # load initial conditions
    input_u, headers_u = readdlm(initial_conditions, ',', header=true)
    input_u = Vector{Float64}(input_u[2, :]) # remove units row
    u = Dict(Symbol(h) => v for (h, v) in zip(headers_u, input_u))

    # load matching data
    input_matching, headers_matching = readdlm(matching_data, ',', header=true)
    input_matching = Matrix{Float64}(input_matching[2:end, :]) # remove units row
    matching_data = Dict(Symbol(h) => ts for (h, ts) in zip(headers_matching, eachcol(input_matching)))

    # return in struct
    return Inputs(p, u, tq, α, matching_data)
end

# returns the parameters for a given speed from a csv file
function read_from_results(fname, speed)
    p, header = readdlm(fname, ',', Float64, header=true)
    row = p[p[:, 1].==speed, :]

    return row[3:end]
end

# returns u₀ and p created from results.csv
function load_from_results(inputs, fname, speed)
    p = read_from_results(fname, speed)

    # create new inputs
    _inputs = deepcopy(inputs)
    _inputs.initial_conditions[:vcmx] = speed
    # _inputs.activation_parameters[:, 2:end] = reshape(p, :, 6) |> permutedims # reshape to 6xn matrix, row major
    n = length(p)
    m = n ÷ 6
    [_inputs.activation_parameters[k] = p[i:i+m-1] for (k, i) in zip([:he, :ke, :ae, :hf, :kf, :af], collect(1:m:n))]

    p, u₀ = set_values(_inputs)
    return p, u₀
end

function set_values(inputs)
    @unpack parameters, initial_conditions, torque_parameters, activation_parameters = inputs
    parameters = NamedTuple(parameters)
    initial_conditions = NamedTuple(initial_conditions)

    # set parameters
    @inbounds (; footang, g, ina, inb, inc, ind, ine, inf, ing, inh, ini, k1, k2, k3, k4, k5, k6, k7, k8, l1, l10, l11, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mh, mi, mtpb, mtpk, pop1xi, pop2xi) = parameters
    mt = ma + mb + mc + md + me + mf + mg
    u8 = u9 = u10 = u11 = 0.0
    footang = deg2rad(footang)

    # set intial conditions
    @inbounds (; mtp_x, mtp_y, q3, mtp_angle, ankle_angle, knee_angle, hip_angle, vcmx, vcmy, u3, mtp_angular_velocity, ankle_angular_velocity, knee_angular_velocity, hip_angular_velocity) = initial_conditions

    # convert initial conditions into generalised coordinates and speeds
    q3 = q3 |> deg2rad              # q3 = q3
    q1 = mtp_x + l2 * cos(q3 - q4 - q5 - q6 - q7)   # pop2x = q1 - l2*cos(q3-q4-q5-q6-q7)  (MTP contacts first)
    q2 = mtp_y + l2 * sin(q3 - q4 - q5 - q6 - q7)   # pop2y = q2 - l2*sin(q3-q4-q5-q6-q7)
    u3 = u3 |> deg2rad              # u3 = u3

    # initial angle driven values
    ra₀ = _ra(0.0)
    la₀ = _la(0.0)
    rk₀ = _rk(0.0)
    lk₀ = _lk(0.0)
    rh₀ = _rh(0.0)
    lh₀ = _lh(0.0)
    rap₀ = _rap(0.0)
    lap₀ = _lap(0.0)
    rkp₀ = _rkp(0.0)
    lkp₀ = _lkp(0.0)
    rhp₀ = _rhp(0.0)
    lhp₀ = _lhp(0.0)
    hato₀ = _hato(0.0)
    hatop₀ = _hatop(0.0)

    # u1 = 1.78872
    # u2 = -3.877485
    u1_fun(ra, la, rk, lk, rh, lh, hato, rap, lap, rkp, lkp, rhp, lhp, hatop) = vcmx + 0.5 * (2 * mhat * hato * sin(q3) * u3 + 2 * (lth * mff + lth * mrf + lth * msh + mth * (lth - ltho)) * sin(lh + q3) * (lhp + u3 + u5) + 2 * (lsh * mff + lsh * mrf + msh * (lsh - lsho)) * sin(lh + lk + q3) * (lhp + lkp + u3 + u5 + u7) + 2 * mff * (lff - lffo) * sin(la + lh + lk + lmtp + q3) * (lap + lhp + lkp + lmtpp + u3 + u5 + u7 + u9) + (2 * lrf * mff + mrf * (2 * lrf - lrfo)) * sin(la + lh + lk + q3) * (lap + lhp + lkp + u3 + u5 + u7 + u9) - 2 * mhat * hatop * cos(q3) - lrffo * mrf * sin(footang + la + lh + lk + q3) * (lap + lhp + lkp + u3 + u5 + u7 + u9) - lrffo * mrf * sin(footang + ra + rh + rk + q3) * (rap + rhp + rkp + u3 + u4 + u6 + u8) - 2 * (lth * mff + lth * mhat + lth * mrf + lth * msh + lth * mth + ltho * mth) * sin(rh + q3) * (rhp + u3 + u4) - 2 * (lsh * mff + lsh * mhat + lsh * mrf + lsh * msh + lsho * msh + 2 * lsh * mth) * sin(rh + rk + q3) * (rhp + rkp + u3 + u4 + u6) - 2 * (lff * mff + lff * mhat + lffo * mff + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth) * sin(ra + rh + rk + rmtp + q3) * (rap + rhp + rkp + rmtpp + u3 + u4 + u6 + u8) - (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mrf + 4 * lrf * msh + 4 * lrf * mth) * sin(ra + rh + rk + q3) * (rap + rhp + rkp + u3 + u4 + u6 + u8)) / (mhat + 2 * mff + 2 * mrf + 2 * msh + 2 * mth)
    u2_fun(ra, la, rk, lk, rh, lh, hato, rap, lap, rkp, lkp, rhp, lhp, hatop) = vcmy - 0.5 * (2 * mhat * hatop * sin(q3) + 2 * mhat * hato * cos(q3) * u3 + 2 * (lth * mff + lth * mrf + lth * msh + mth * (lth - ltho)) * cos(lh + q3) * (lhp + u3 + u5) + 2 * (lsh * mff + lsh * mrf + msh * (lsh - lsho)) * cos(lh + lk + q3) * (lhp + lkp + u3 + u5 + u7) + 2 * mff * (lff - lffo) * cos(la + lh + lk + lmtp + q3) * (lap + lhp + lkp + lmtpp + u3 + u5 + u7 + u9) + (2 * lrf * mff + mrf * (2 * lrf - lrfo)) * cos(la + lh + lk + q3) * (lap + lhp + lkp + u3 + u5 + u7 + u9) - lrffo * mrf * cos(footang + la + lh + lk + q3) * (lap + lhp + lkp + u3 + u5 + u7 + u9) - lrffo * mrf * cos(footang + ra + rh + rk + q3) * (rap + rhp + rkp + u3 + u4 + u6 + u8) - 2 * (lth * mff + lth * mhat + lth * mrf + lth * msh + lth * mth + ltho * mth) * cos(rh + q3) * (rhp + u3 + u4) - 2 * (lsh * mff + lsh * mhat + lsh * mrf + lsh * msh + lsho * msh + 2 * lsh * mth) * cos(rh + rk + q3) * (rhp + rkp + u3 + u4 + u6) - 2 * (lff * mff + lff * mhat + lffo * mff + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth) * cos(ra + rh + rk + rmtp + q3) * (rap + rhp + rkp + rmtpp + u3 + u4 + u6 + u8) - (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mrf + 4 * lrf * msh + 4 * lrf * mth) * cos(ra + rh + rk + q3) * (rap + rhp + rkp + u3 + u4 + u6 + u8)) / (mhat + 2 * mff + 2 * mrf + 2 * msh + 2 * mth)
    u1 = u1_fun(ra₀, la₀, rk₀, lk₀, rh₀, lh₀, hato₀, rap₀, lap₀, rkp₀, lkp₀, rhp₀, lhp₀, hatop₀)
    u2 = u2_fun(ra₀, la₀, rk₀, lk₀, rh₀, lh₀, hato₀, rap₀, lap₀, rkp₀, lkp₀, rhp₀, lhp₀, hatop₀)

    # parameters
    p = Params(footang, g, iff, ihat, irf, ish, ith, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lmtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, ltoexi, mff, mhat, mrf, msh, mth, mtpb, mtpk, rmtpxi, rtoexi)

    # intial conditions
    u₀ = SVector(q1, q2, q3, u1, u2, u3)

    return p, u₀

end

function setup(;
    parameters="model/9seg_ad/parameters.csv",
    initial_conditions="model/9seg_ad/initial_conditions.csv",
    matching_data="data/matchingData.csv")

    # load parameters
    inputs = readdlm(parameters, ',', header=true)
    input_p, headers_p = convert(Vector{Float64}, inputs[1][:, 3]), Symbol.(inputs[1][:, 1])

    footang, g, iff, irf, ish, ith, ihat, k1, k2, k3, k4, k5, k6, k7, k8, lffo, lff, lrffo, lrfo, lrff, lrf, lsho, lsh, ltho, lth, lhat, mff, mrf, msh, mth, mhat, mtpb, mtpk, ltoexi, lmtpxi, rtoexi, rmtpxi = input_p
    u4 = u5 = u6 = u6 = u7 = u8 = u9 = 0.0
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
    rmtpp₀ = _rmtpp(0.0)
    lmtpp₀ = _lmtpp(0.0)
    rap₀ = _rap(0.0)
    lap₀ = _lap(0.0)
    rkp₀ = _rkp(0.0)
    lkp₀ = _lkp(0.0)
    rhp₀ = _rhp(0.0)
    lhp₀ = _lhp(0.0)
    hato₀ = _hato(0.0)
    hatop₀ = _hatop(0.0)

    # convert initial conditions into generalised coordinates and speeds
    q3 = q3 |> deg2rad              # q3 = q3
    q1 = Xmtp - lff * cos(ra₀ + rh₀ + lmtp₀ - lk₀ - q3)   # POP2X = Q1 + LFF*COS(LA+LH+LMTP-LK-Q3)  (MTP contacts first)
    q2 = Ymtp + lff * sin(la₀ + lh₀ + lmtp₀ - lk₀ - q3)   # POP2Y = Q2 - LFF*SIN(LA+LH+LMTP-LK-Q3)
    u3 = u3 |> deg2rad              # u3 = u3

    # u1 = 1.78872
    # u2 = -3.877485
    u1_fun(rmtp, lmtp, ra, la, rk, lk, rh, lh, hato, rmtpp, lmtpp, rap, lap, rkp, lkp, rhp, lhp, hatop) = vcmx + 0.5 * (2 * mhat * hato * sin(q3) * u3 + 2 * (lth * mff + lth * mrf + lth * msh + mth * (lth - ltho)) * sin(rh - q3) * (rhp - u3 - u4) + (2 * lrf * mff + mrf * (2 * lrf - lrfo)) * sin(ra + rh - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) + 2 * (lsh * mff + lsh * mhat + lsh * mrf + lsh * msh + lsho * msh + 2 * lsh * mth) * sin(lh - lk - q3) * (lhp - lkp - u3 - u5 - u7) + 2 * (lff * mff + lff * mhat + lffo * mff + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth) * sin(la + lh + lmtp - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9) - 2 * mhat * hatop * cos(q3) - 2 * (lth * mff + lth * mhat + lth * mrf + lth * msh + lth * mth + ltho * mth) * sin(lh - q3) * (lhp - u3 - u5) - lrffo * mrf * sin(la + lh - footang - lk - q3) * (lap + lhp - lkp - u3 - u5 - u7 - u9) - lrffo * mrf * sin(ra + rh - footang - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) - 2 * (lsh * mff + lsh * mrf + msh * (lsh - lsho)) * sin(rh - rk - q3) * (rhp - rkp - u3 - u4 - u6) - 2 * mff * (lff - lffo) * sin(ra + rh + rmtp - rk - q3) * (rap + rhp + rmtpp - rkp - u3 - u4 - u6 - u8) - (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mrf + 4 * lrf * msh + 4 * lrf * mth) * sin(la + lh - lk - q3) * (lap + lhp - lkp - u3 - u5 - u7 - u9)) / (mhat + 2 * mff + 2 * mrf + 2 * msh + 2 * mth)
    u2_fun(rmtp, lmtp, ra, la, rk, lk, rh, lh, hato, rmtpp, lmtpp, rap, lap, rkp, lkp, rhp, lhp, hatop) = vcmy + 0.5 * (2 * (lth * mff + lth * mrf + lth * msh + mth * (lth - ltho)) * cos(rh - q3) * (rhp - u3 - u4) + (2 * lrf * mff + mrf * (2 * lrf - lrfo)) * cos(ra + rh - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) + 2 * (lsh * mff + lsh * mhat + lsh * mrf + lsh * msh + lsho * msh + 2 * lsh * mth) * cos(lh - lk - q3) * (lhp - lkp - u3 - u5 - u7) + 2 * (lff * mff + lff * mhat + lffo * mff + 2 * lff * mrf + 2 * lff * msh + 2 * lff * mth) * cos(la + lh + lmtp - lk - q3) * (lap + lhp + lmtpp - lkp - u3 - u5 - u7 - u9) - 2 * mhat * hatop * sin(q3) - 2 * mhat * hato * cos(q3) * u3 - 2 * (lth * mff + lth * mhat + lth * mrf + lth * msh + lth * mth + ltho * mth) * cos(lh - q3) * (lhp - u3 - u5) - lrffo * mrf * cos(la + lh - footang - lk - q3) * (lap + lhp - lkp - u3 - u5 - u7 - u9) - lrffo * mrf * cos(ra + rh - footang - rk - q3) * (rap + rhp - rkp - u3 - u4 - u6 - u8) - 2 * (lsh * mff + lsh * mrf + msh * (lsh - lsho)) * cos(rh - rk - q3) * (rhp - rkp - u3 - u4 - u6) - 2 * mff * (lff - lffo) * cos(ra + rh + rmtp - rk - q3) * (rap + rhp + rmtpp - rkp - u3 - u4 - u6 - u8) - (lrfo * mrf + 2 * lrf * mff + 2 * lrf * mhat + 2 * lrf * mrf + 4 * lrf * msh + 4 * lrf * mth) * cos(la + lh - lk - q3) * (lap + lhp - lkp - u3 - u5 - u7 - u9)) / (mhat + 2 * mff + 2 * mrf + 2 * msh + 2 * mth)
    u1 = u1_fun(rmtp₀, lmtp₀, ra₀, la₀, rk₀, lk₀, rh₀, lh₀, hato₀, rmtpp₀, lmtpp₀, rap₀, lap₀, rkp₀, lkp₀, rhp₀, lhp₀, hatop₀)
    u2 = u2_fun(rmtp₀, lmtp₀, ra₀, la₀, rk₀, lk₀, rh₀, lh₀, hato₀, rmtpp₀, lmtpp₀, rap₀, lap₀, rkp₀, lkp₀, rhp₀, lhp₀, hatop₀)

    # parameters
    p = Params(footang, g, iff, ihat, irf, ish, ith, k1, k2, k3, k4, k5, k6, k7, k8, lff, lffo, lhat, lmtpxi, lrf, lrff, lrffo, lrfo, lsh, lsho, lth, ltho, ltoexi, mff, mhat, mrf, msh, mth, mtpb, mtpk, rmtpxi, rtoexi)

    # intial conditions
    u₀ = SVector(q1, q2, q3, u1, u2, u3)

    return p, u₀, matching_data
end
