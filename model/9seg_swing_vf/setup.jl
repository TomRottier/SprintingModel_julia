# setup model
# struct to hold values
struct Inputs
    parameters::Dict{Symbol,Float64}
    initial_conditions::Dict{Symbol,Float64}
    torque_parameters::Dict{Symbol,Dict{Symbol,Float64}}
    activation_parameters::Dict{Symbol,Vector{Float64}}
    swing_data::Dict{Symbol,Vector{Float64}}
    hat_data::Dict{Symbol,Vector{Float64}}
    matching_data::Dict{Symbol,Vector{Float64}}
end

function load_inputs(;
    parameters="data/parameters.csv",
    initial_conditions="data/initial_conditions.csv",
    torque_generators="data/torque_generator_parameters.csv",
    activations="data/activation_parameters.csv",
    swing="data/matching_swing.csv",
    hat="data/HAT.csv",
    matching="data/matchingData.csv")

    # load parameters
    input_p, headers_p = readdlm(parameters, ',', header=true)
    input_p = Vector{Float64}(input_p[2, :]) # remove units row
    p = Dict(Symbol(h) => v for (h, v) in zip(headers_p, input_p))

    # load initial conditions
    input_u, headers_u = readdlm(initial_conditions, ',', header=true)
    input_u = Vector{Float64}(input_u[2, :]) # remove units row
    u = Dict(Symbol(h) => v for (h, v) in zip(headers_u, input_u))

    # load torque generator parameters
    input_tq, headers_tq = readdlm(torque_generators, ',', header=true)
    tq = Dict(
        Symbol(x[1]) => Dict(
            Symbol(h) => Float64(v) for (h, v) in zip(headers_tq[2:end], x[2:end])
        ) for x in eachrow(input_tq)
    )

    # load activation profiles
    input_act, headers_act = readdlm(activations, ',', header=true)
    α = Dict(Symbol(x[1]) => Vector{Float64}(x[2:end]) for x in eachrow(input_act))

    # load swing leg and HAT data
    input_swing, headers_swing = readdlm(swing, ',', header=true)
    input_swing = Matrix{Float64}(input_swing[2:end, :]) # remove units row
    swing_data = Dict(Symbol(h) => ts for (h, ts) in zip(headers_swing, eachcol(input_swing)))
    input_hat, headers_hat = readdlm(hat, ',', header=true)
    input_hat = Matrix{Float64}(input_hat[2:end, :]) # remove units row
    hat_data = Dict(Symbol(h) => ts for (h, ts) in zip(headers_hat, eachcol(input_hat)))

    # load matching data
    input_matching, headers_matching = readdlm(matching, ',', header=true)
    input_matching = Matrix{Float64}(input_matching[2:end, :]) # remove units row
    matching_data = Dict(Symbol(h) => ts for (h, ts) in zip(headers_matching, eachcol(input_matching)))

    # return in struct
    return Inputs(p, u, tq, α, swing_data, hat_data, matching_data)
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
    @unpack parameters, initial_conditions, torque_parameters, activation_parameters, swing_data, hat_data = inputs
    parameters = NamedTuple(parameters)
    initial_conditions = NamedTuple(initial_conditions)

    # set parameters
    @inbounds (; footang, g, ina, inb, inc, ind, ine, inf, ing, inh, ini, k1, k2, k3, k4, k5, k6, k7, k8, l1, l10, l11, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mh, mi, mtpb, mtpk, pop1xi, pop2xi) = parameters
    mt = ma + mb + mc + md + me + mf + mg
    u8 = u9 = u10 = u11 = 0.0
    footang = deg2rad(footang)

    # set intial conditions
    @inbounds (; mtp_x, mtp_y, q3, mtp_angle, ankle_angle, knee_angle, hip_angle, vcmx, vcmy, u3, mtp_angular_velocity, ankle_angular_velocity, knee_angular_velocity, hip_angular_velocity) = initial_conditions

    # set torque parameters
    tq_p = Dict(k => [CCParameters(v), SECParameters(v)] for (k, v) in torque_parameters)

    # load activation profiles
    α_p = Dict(k => ActivationProfile(v) for (k, v) in activation_parameters)

    # set swing and hat splines
    # time = swing_data[:time]
    # hip_spl = Spline1D(time, swing_data[:hip_angle], k = 5)
    # knee_spl = Spline1D(time, swing_data[:knee_angle], k = 5)
    # ankle_spl = Spline1D(time, swing_data[:ankle_angle], k = 5)
    # mtp_spl = Spline1D(time, swing_data[:mtp_angle], k = 5)
    # # swing thigh angle
    # ea(t) = evaluate(hip_spl, t) |> deg2rad
    # eap(t) = derivative(hip_spl, t, 1) |> deg2rad
    # eapp(t) = derivative(hip_spl, t, 2) |> deg2rad
    # # swing shank angle
    # fa(t) = evaluate(knee_spl, t) |> deg2rad
    # fap(t) = derivative(knee_spl, t, 1) |> deg2rad
    # fapp(t) = derivative(knee_spl, t, 2) |> deg2rad
    # # HAT CoM location
    # hat_spl = Spline1D(hat_data[:time], hat_data[:hat_com_distance], k = 5)
    # gs(t) = evaluate(hat_spl, t)
    # gsp(t) = derivative(hat_spl, t, 1)
    # gspp(t) = derivative(hat_spl, t, 2)
    # # swing ankle angle
    # ha(t) = evaluate(ankle_spl, t) |> deg2rad
    # hap(t) = derivative(ankle_spl, t, 1) |> deg2rad
    # happ(t) = derivative(ankle_spl, t, 2) |> deg2rad
    # # swing mtp angle
    # ia(t) = evaluate(mtp_spl, t) |> deg2rad
    # iap(t) = derivative(mtp_spl, t, 1) |> deg2rad
    # iapp(t) = derivative(mtp_spl, t, 2) |> deg2rad

    # fit splines and evaluate derivatives 
    time = swing_data[:time]
    hip_spl = Spline1D(time, swing_data[:hip_angle], k=5)
    knee_spl = Spline1D(time, swing_data[:knee_angle], k=5)
    ankle_spl = Spline1D(time, swing_data[:ankle_angle], k=5)
    mtp_spl = Spline1D(time, swing_data[:mtp_angle], k=5)
    hat_spl = Spline1D(hat_data[:time], hat_data[:hat_com_distance])
    # get data for 0,1,2 derivatives
    swing = [swing_data[:hip_angle] swing_data[:knee_angle] swing_data[:ankle_angle] swing_data[:mtp_angle]]
    swingp = [derivative(hip_spl, time, 1) derivative(knee_spl, time, 1) derivative(ankle_spl, time, 1) derivative(mtp_spl, time, 1)]
    swingpp = [derivative(hip_spl, time, 2) derivative(knee_spl, time, 2) derivative(ankle_spl, time, 2) derivative(mtp_spl, time, 2)]
    hat = [hat_data[:time] hat_data[:hat_com_distance]]
    hatp = [hat_data[:time] derivative(hat_spl, hat_data[:time], 1)]
    hatpp = [hat_data[:time] derivative(hat_spl, hat_data[:time], 2)]

    # interpolate 0th derivatives
    dt = time[2] - time[1]
    t = time[1]:dt:time[end] # need x values as a range 
    hip_spl = CubicSplineInterpolation(t, swing[:, 1])
    knee_spl = CubicSplineInterpolation(t, swing[:, 2])
    ankle_spl = CubicSplineInterpolation(t, swing[:, 3])
    mtp_spl = CubicSplineInterpolation(t, swing[:, 4])
    hat_spl = CubicSplineInterpolation(t, hat[:, 2])
    # 1st derivatives
    hipp_spl = CubicSplineInterpolation(t, swingp[:, 1])
    kneep_spl = CubicSplineInterpolation(t, swingp[:, 2])
    anklep_spl = CubicSplineInterpolation(t, swingp[:, 3])
    mtpp_spl = CubicSplineInterpolation(t, swingp[:, 4])
    hatp_spl = CubicSplineInterpolation(t, hatp[:, 2])
    # 2nd dervatives
    hippp_spl = CubicSplineInterpolation(t, swingpp[:, 1])
    kneepp_spl = CubicSplineInterpolation(t, swingpp[:, 2])
    anklepp_spl = CubicSplineInterpolation(t, swingpp[:, 3])
    mtppp_spl = CubicSplineInterpolation(t, swingpp[:, 4])
    hatpp_spl = CubicSplineInterpolation(t, hatpp[:, 2])

    # evaluation functions
    ea(t)::Float64 = hip_spl(t) |> deg2rad
    fa(t)::Float64 = knee_spl(t) |> deg2rad
    gs(t)::Float64 = hat_spl(t) |> deg2rad
    ha(t)::Float64 = ankle_spl(t) |> deg2rad
    ia(t)::Float64 = mtp_spl(t) |> deg2rad
    eap(t)::Float64 = hipp_spl(t) |> deg2rad
    fap(t)::Float64 = kneep_spl(t) |> deg2rad
    gsp(t)::Float64 = hatp_spl(t) |> deg2rad
    hap(t)::Float64 = anklep_spl(t) |> deg2rad
    iap(t)::Float64 = mtpp_spl(t) |> deg2rad
    eapp(t)::Float64 = hippp_spl(t) |> deg2rad
    fapp(t)::Float64 = kneepp_spl(t) |> deg2rad
    gspp(t)::Float64 = hatpp_spl(t) |> deg2rad
    happ(t)::Float64 = anklepp_spl(t) |> deg2rad
    iapp(t)::Float64 = mtppp_spl(t) |> deg2rad

    # convert initial conditions into generalised coordinates and speeds
    q3 = q3 |> deg2rad              # q3 = q3
    q4 = mtp_angle |> deg2rad              # mang = q4
    q5 = (ankle_angle - 180) |> deg2rad      # aang = 180 + q5
    q6 = (180 - knee_angle) |> deg2rad      # kang = 180 - q6 
    q7 = (hip_angle - 180) |> deg2rad      # hang = 180 + q7
    q1 = mtp_x + l2 * cos(q3 - q4 - q5 - q6 - q7)   # pop2x = q1 - l2*cos(q3-q4-q5-q6-q7)  (MTP contacts first)
    q2 = mtp_y + l2 * sin(q3 - q4 - q5 - q6 - q7)   # pop2y = q2 - l2*sin(q3-q4-q5-q6-q7)
    u3 = u3 |> deg2rad              # u3 = u3
    u4 = mtp_angular_velocity |> deg2rad              # mangvel = u4
    u5 = ankle_angular_velocity |> deg2rad              # aangvel = u5
    u6 = -knee_angular_velocity |> deg2rad             # kangvel = -u6
    u7 = hip_angular_velocity |> deg2rad              # hangvel = u7

    # initial angle driven values
    ea₀ = ea(0.0)
    fa₀ = fa(0.0)
    gs₀ = gs(0.0)
    ha₀ = ha(0.0)
    ia₀ = ia(0.0)
    eap₀ = eap(0.0)
    fap₀ = fap(0.0)
    gsp₀ = gsp(0.0)
    hap₀ = hap(0.0)
    iap₀ = iap(0.0)

    u1_fun(ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap) = vcmx - 0.5 * (2 * mg * gsp * cos(q3) + 2 * (l8 * mh + l8 * mi - mf * (l7 - l8)) * sin(ea - fa - q3) * (eap - fap - u3 - u8 - u9) + 2 * (l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg + l2 * mh + l2 * mi) * sin(q3 - q4 - q5 - q6 - q7) * (u3 - u4 - u5 - u6 - u7) - 2 * mg * gs * sin(q3) * u3 - l3 * mb * sin(footang + q3 - q5 - q6 - q7) * (u3 - u5 - u6 - u7) - 2 * (l10 * me + l10 * mf + l10 * mg + l10 * mh + l10 * mi + l9 * md) * sin(q3 - q7) * (u3 - u7) - 2 * (l10 * mf + l10 * mh + l10 * mi + me * (l10 - l9)) * sin(ea - q3) * (eap - u3 - u8) - 2 * (l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg + l8 * mh + l8 * mi) * sin(q3 - q6 - q7) * (u3 - u6 - u7) - mh * (l3 - l5) * sin(ea + ha - footang - fa - q3) * (eap + hap - fap - u10 - u3 - u8 - u9) - 2 * mi * (l1 - l2) * sin(ea + ha + ia - fa - q3) * (eap + hap + iap - fap - u10 - u11 - u3 - u8 - u9) - (2 * l6 * mi - mh * (l4 - 2 * l6)) * sin(ea + ha - fa - q3) * (eap + hap - fap - u10 - u3 - u8 - u9) - (l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg + 2 * l6 * mh + 2 * l6 * mi) * sin(q3 - q5 - q6 - q7) * (u3 - u5 - u6 - u7)) / (ma + mb + mc + md + me + mf + mg + mh + mi)
    u2_fun(ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap) = vcmy + 0.5 * (2 * (l10 * mf + l10 * mh + l10 * mi + me * (l10 - l9)) * cos(ea - q3) * (eap - u3 - u8) + mh * (l3 - l5) * cos(ea + ha - footang - fa - q3) * (eap + hap - fap - u10 - u3 - u8 - u9) + (2 * l6 * mi - mh * (l4 - 2 * l6)) * cos(ea + ha - fa - q3) * (eap + hap - fap - u10 - u3 - u8 - u9) + 2 * mi * (l1 - l2) * cos(ea + ha + ia - fa - q3) * (eap + hap + iap - fap - u10 - u11 - u3 - u8 - u9) + 2 * (l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg + l2 * mh + l2 * mi) * cos(q3 - q4 - q5 - q6 - q7) * (u3 - u4 - u5 - u6 - u7) - 2 * mg * gsp * sin(q3) - 2 * mg * gs * cos(q3) * u3 - l3 * mb * cos(footang + q3 - q5 - q6 - q7) * (u3 - u5 - u6 - u7) - 2 * (l10 * me + l10 * mf + l10 * mg + l10 * mh + l10 * mi + l9 * md) * cos(q3 - q7) * (u3 - u7) - 2 * (l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg + l8 * mh + l8 * mi) * cos(q3 - q6 - q7) * (u3 - u6 - u7) - 2 * (l8 * mh + l8 * mi - mf * (l7 - l8)) * cos(ea - fa - q3) * (eap - fap - u3 - u8 - u9) - (l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg + 2 * l6 * mh + 2 * l6 * mi) * cos(q3 - q5 - q6 - q7) * (u3 - u5 - u6 - u7)) / (ma + mb + mc + md + me + mf + mg + mh + mi)
    u1 = u1_fun(ea₀, fa₀, gs₀, ha₀, ia₀, eap₀, fap₀, gsp₀, hap₀, iap₀)
    u2 = u2_fun(ea₀, fa₀, gs₀, ha₀, ia₀, eap₀, fap₀, gsp₀, hap₀, iap₀)

    # set up torque generators
    he = TorqueGenerator(2π - deg2rad(hip_angle), deg2rad(-hip_angular_velocity), tq_p[:he][1], tq_p[:he][2], α_p[:he])
    ke = TorqueGenerator(2π - deg2rad(knee_angle), deg2rad(-knee_angular_velocity), tq_p[:ke][1], tq_p[:ke][2], α_p[:ke])
    ae = TorqueGenerator(2π - deg2rad(ankle_angle), deg2rad(-ankle_angular_velocity), tq_p[:ae][1], tq_p[:ae][2], α_p[:ae])
    hf = TorqueGenerator(deg2rad(hip_angle), deg2rad(hip_angular_velocity), tq_p[:hf][1], tq_p[:hf][2], α_p[:hf])
    kf = TorqueGenerator(deg2rad(knee_angle), deg2rad(knee_angular_velocity), tq_p[:kf][1], tq_p[:kf][2], α_p[:kf])
    af = TorqueGenerator(deg2rad(ankle_angle), deg2rad(ankle_angular_velocity), tq_p[:af][1], tq_p[:af][2], α_p[:af])

    # intial CC angles
    θcc₀ = map(x -> x.cc.θ, [he, ke, ae, hf, kf, af])

    # parameters
    p = Params(ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap, eapp, fapp, gspp, happ, iapp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, inh, ini, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l11, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mh, mi, mtpb, mtpk, pop1xi, pop2xi)

    # intial conditions
    u₀ = SVector(q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7, θcc₀...)

    return p, u₀

end

function setup(;
    parameters="data/parameters.csv",
    initial_conditions="data/initial_conditions.csv",
    torque_generator_parameters="data/torque_generator_parameters.csv",
    activation_parameters="data/activation_parameters.csv",
    swing="data/matching_swing.csv",
    hat="data/HAT.csv",
    matching_data="data/matchingData.csv")

    # load parameters
    input_p, headers_p = readdlm(parameters, ',', Float64, header=true)
    @inbounds footang, g, ina, inb, inc, ind, ine, inf, ing, k1, k2, k3, k4, k5, k6, k7, k8, l1, l10, l11, l12, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mtpb, mtpk, pop1xi, pop2xi = input_p
    mt = ma + mb + mc + md + me + mf + mg
    u8 = u9 = 0.0
    footang = deg2rad(footang)

    # load initial conditions
    input_u, headers_u = readdlm(initial_conditions, ',', Float64, header=true)
    @inbounds Xmtp, Ymtp, q3, θm, θa, θk, θh, vcmx, vcmy, u3, ωm, ωa, ωk, ωh = input_u


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

    # load swing leg and HAT data
    swing_data = readdlm(swing, ',', Float64, skipstart=1)
    hip_spl = Spline1D(swing_data[:, 1], swing_data[:, 2], k=5)
    knee_spl = Spline1D(swing_data[:, 1], swing_data[:, 3], k=5)
    # set swing and hat splines
    time = swing_data[:time]
    hip_spl = Spline1D(time, swing_data[:hip_angle], k=5)
    knee_spl = Spline1D(time, swing_data[:knee_angle], k=5)
    ankle_spl = Spline1D(time, swing_data[:ankle_angle], k=5)
    mtp_spl = Spline1D(time, swing_data[:mtp_angle], k=5)
    # swing thigh angle
    ea(t) = evaluate(hip_spl, t) |> deg2rad
    eap(t) = derivative(hip_spl, t, 1) |> deg2rad
    eapp(t) = derivative(hip_spl, t, 2) |> deg2rad
    # swing shank angle
    fa(t) = evaluate(knee_spl, t) |> deg2rad
    fap(t) = derivative(knee_spl, t, 1) |> deg2rad
    fapp(t) = derivative(knee_spl, t, 2) |> deg2rad
    # HAT CoM location
    hat_spl = Spline1D(hat_data[:time], hat_data[:hat_com_distance], k=5)
    gs(t) = evaluate(hat_spl, t)
    gsp(t) = derivative(hat_spl, t, 1)
    gspp(t) = derivative(hat_spl, t, 2)
    # swing ankle angle
    ha(t) = evaluate(ankle_spl, t) |> deg2rad
    hap(t) = derivative(ankle_spl, t, 1) |> deg2rad
    happ(t) = derivative(ankle_spl, t, 2) |> deg2rad
    # swing mtp angle
    ia(t) = evaluate(mtp_spl, t) |> deg2rad
    iap(t) = derivative(mtp_spl, t, 1) |> deg2rad
    iapp(t) = derivative(mtp_spl, t, 2) |> deg2rad

    # load matching data
    matching_data, headers_matching = readdlm(matching_data, ',', Float64, skipstart=1, header=true)
    matching_data = matching_data[1:2:end-2] # only use left side data

    # convert initial conditions into generalised coordinates and speeds
    q3 = q3 |> deg2rad              # q3 = q3
    q4 = θm |> deg2rad              # mang = q4
    q5 = (θa - 180) |> deg2rad      # aang = 180 + q5
    q6 = (180 - θk) |> deg2rad      # kang = 180 - q6 
    q7 = (θh - 180) |> deg2rad      # hang = 180 + q7
    q1 = Xmtp + l2 * cos(q3 - q4 - q5 - q6 - q7)   # pop2x = q1 - l2*cos(q3-q4-q5-q6-q7)  (MTP contacts first)
    q2 = Ymtp + l2 * sin(q3 - q4 - q5 - q6 - q7)   # pop2y = q2 - l2*sin(q3-q4-q5-q6-q7)
    u3 = u3 |> deg2rad              # u3 = u3
    u4 = ωm |> deg2rad              # mangvel = u4
    u5 = ωa |> deg2rad              # aangvel = u5
    u6 = -ωk |> deg2rad             # kangvel = -u6
    u7 = ωh |> deg2rad              # hangevl = u7

    ea₀ = ea(0.0)
    fa₀ = fa(0.0)
    gs₀ = gs(0.0)
    ha₀ = ha(0.0)
    ia₀ = ia(0.0)
    eap₀ = eap(0.0)
    fap₀ = fap(0.0)
    gsp₀ = gsp(0.0)
    hap₀ = hap(0.0)
    iap₀ = iap(0.0)

    # u1 = 1.78872
    # u2 = -3.877485
    u1_fun(ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap) = vcmx - 0.5 * (2 * mg * gsp * cos(q3) + 2 * (l8 * mh + l8 * mi - mf * (l7 - l8)) * sin(ea - fa - q3) * (eap - fap - u3 - u8 - u9) + 2 * (l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg + l2 * mh + l2 * mi) * sin(q3 - q4 - q5 - q6 - q7) * (u3 - u4 - u5 - u6 - u7) - 2 * mg * gs * sin(q3) * u3 - l3 * mb * sin(footang + q3 - q5 - q6 - q7) * (u3 - u5 - u6 - u7) - 2 * (l10 * me + l10 * mf + l10 * mg + l10 * mh + l10 * mi + l9 * md) * sin(q3 - q7) * (u3 - u7) - 2 * (l10 * mf + l10 * mh + l10 * mi + me * (l10 - l9)) * sin(ea - q3) * (eap - u3 - u8) - 2 * (l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg + l8 * mh + l8 * mi) * sin(q3 - q6 - q7) * (u3 - u6 - u7) - mh * (l3 - l5) * sin(ea + ha - footang - fa - q3) * (eap + hap - fap - u10 - u3 - u8 - u9) - 2 * mi * (l1 - l2) * sin(ea + ha + ia - fa - q3) * (eap + hap + iap - fap - u10 - u11 - u3 - u8 - u9) - (2 * l6 * mi - mh * (l4 - 2 * l6)) * sin(ea + ha - fa - q3) * (eap + hap - fap - u10 - u3 - u8 - u9) - (l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg + 2 * l6 * mh + 2 * l6 * mi) * sin(q3 - q5 - q6 - q7) * (u3 - u5 - u6 - u7)) / (ma + mb + mc + md + me + mf + mg + mh + mi)
    u2_fun(ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap) = vcmy + 0.5 * (2 * (l10 * mf + l10 * mh + l10 * mi + me * (l10 - l9)) * cos(ea - q3) * (eap - u3 - u8) + mh * (l3 - l5) * cos(ea + ha - footang - fa - q3) * (eap + hap - fap - u10 - u3 - u8 - u9) + (2 * l6 * mi - mh * (l4 - 2 * l6)) * cos(ea + ha - fa - q3) * (eap + hap - fap - u10 - u3 - u8 - u9) + 2 * mi * (l1 - l2) * cos(ea + ha + ia - fa - q3) * (eap + hap + iap - fap - u10 - u11 - u3 - u8 - u9) + 2 * (l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg + l2 * mh + l2 * mi) * cos(q3 - q4 - q5 - q6 - q7) * (u3 - u4 - u5 - u6 - u7) - 2 * mg * gsp * sin(q3) - 2 * mg * gs * cos(q3) * u3 - l3 * mb * cos(footang + q3 - q5 - q6 - q7) * (u3 - u5 - u6 - u7) - 2 * (l10 * me + l10 * mf + l10 * mg + l10 * mh + l10 * mi + l9 * md) * cos(q3 - q7) * (u3 - u7) - 2 * (l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg + l8 * mh + l8 * mi) * cos(q3 - q6 - q7) * (u3 - u6 - u7) - 2 * (l8 * mh + l8 * mi - mf * (l7 - l8)) * cos(ea - fa - q3) * (eap - fap - u3 - u8 - u9) - (l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg + 2 * l6 * mh + 2 * l6 * mi) * cos(q3 - q5 - q6 - q7) * (u3 - u5 - u6 - u7)) / (ma + mb + mc + md + me + mf + mg + mh + mi)
    u1 = u1_fun(ea₀, fa₀, gs₀, ha₀, ia₀, eap₀, fap₀, gsp₀, hap₀, iap₀)
    u2 = u2_fun(ea₀, fa₀, gs₀, ha₀, ia₀, eap₀, fap₀, gsp₀, hap₀, iap₀)

    # set up torque generators
    he = TorqueGenerator(2π - deg2rad(θh), deg2rad(-ωh), tq_p[1][1], tq_p[1][2], α_p[1])
    ke = TorqueGenerator(2π - deg2rad(θk), deg2rad(-ωk), tq_p[2][1], tq_p[2][2], α_p[2])
    ae = TorqueGenerator(2π - deg2rad(θa), deg2rad(-ωa), tq_p[3][1], tq_p[3][2], α_p[3])
    hf = TorqueGenerator(deg2rad(θh), deg2rad(ωh), tq_p[4][1], tq_p[4][2], α_p[4])
    kf = TorqueGenerator(deg2rad(θk), deg2rad(ωk), tq_p[5][1], tq_p[5][2], α_p[5])
    af = TorqueGenerator(deg2rad(θa), deg2rad(ωa), tq_p[6][1], tq_p[6][2], α_p[6])
    θcc₀ = map(x -> x.cc.θ, [he, ke, ae, hf, kf, af])

    # parameters
    p = Params(ea, fa, gs, ha, ia, eap, fap, gsp, hap, iap, eapp, fapp, gspp, happ, iapp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, inh, ini, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l11, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mh, mi, mtpb, mtpk, pop1xi, pop2xi)

    # intial conditions
    u₀ = SVector(q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7, θcc₀...)

    return p, u₀, matching_data
end
