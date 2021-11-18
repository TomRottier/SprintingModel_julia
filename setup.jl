# setup model
# struct to hold values
struct Inputs
    parameters::Vector{Any}
    initial_conditions::Vector{Float64}
    torque_parameters::Matrix{Any}
    activation_parameters::Matrix{Any}
    swing_data::Matrix{Float64}
    hat_data::Matrix{Float64}
end

function load_inputs(;
    parameters = "data/parameters.csv",
    initial_conditions = "data/initial_conditions.csv",
    torque_generator_parameters = "data/torque_generator_parameters.csv",
    activation_parameters = "data/activation_parameters.csv",
    swing = "data/matching_swing.csv",
    hat = "data/HAT.csv")

    # load parameters
    input_p, headers_p = readdlm(parameters, ',', Float64, header = true)

    # load initial conditions
    input_u, headers_u = readdlm(initial_conditions, ',', Float64, header = true)

    # load torque generator parameters
    tq_p, headers_tq = readdlm(torque_generator_parameters, ',', header = true)

    # load activation profiles
    α_p, headers_α = readdlm(activation_parameters, ',', header = true)

    # load swing leg and HAT data
    swing_data = readdlm(swing, ',', Float64, skipstart = 1)
    hat_data = readdlm(hat, ',', Float64, skipstart = 1)

    # return in struct
    return Inputs(vec(input_p), vec(input_u), tq_p, α_p, swing_data, hat_data)
end

# returns the parameters for a given speed from a csv file
function read_from_results(fname, speed)
    p, header = readdlm(fname, ',', Float64, header = true)
    row = p[p[:, 1].==speed, :]

    return row[3:end]
end

# returns u₀ and p created from results.csv
function load_from_results(inputs, fname, speed)
    p = read_from_results(fname, speed)

    # create new inputs
    _inputs = deepcopy(inputs)
    _inputs.initial_conditions[8] = speed
    _inputs.activation_parameters[:, 2:end] = reshape(p, :, 6) |> permutedims # reshape to 6xn matrix, row major

    p, u₀ = set_values(_inputs)
    return p, u₀
end

function set_values(inputs)
    @unpack parameters, initial_conditions, torque_parameters, activation_parameters, swing_data, hat_data = inputs

    # set parameters
    @inbounds footang, g, ina, inb, inc, ind, ine, inf, ing, k1, k2, k3, k4, k5, k6, k7, k8, l1, l10, l11, l12, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mtpb, mtpk, pop1xi, pop2xi = parameters
    mt = ma + mb + mc + md + me + mf + mg
    u8 = u9 = 0.0
    footang = deg2rad(footang)

    # set intial conditions
    @inbounds Xmtp, Ymtp, q3, θm, θa, θk, θh, vcmx, vcmy, u3, ωm, ωa, ωk, ωh = initial_conditions

    # set torque parameters
    tq_p = map(eachrow(torque_parameters)) do x
        x = x[2:end] .|> Float64    # remove row names, convert to float
        [CCParameters(x[1:end-1]...), SECParameters(x[end])]
    end

    # load activation profiles
    α_p = map(eachrow(activation_parameters)) do x
        x = x[2:end] .|> Float64    # remove row names, convert to float
        ActivationProfile(x...)
    end

    # set swing and hat splines
    hip_spl = Spline1D(swing_data[:, 1], swing_data[:, 2], k = 5)
    knee_spl = Spline1D(swing_data[:, 1], swing_data[:, 3], k = 5)
    # swing thigh angle
    ea(t) = evaluate(hip_spl, t) |> deg2rad
    eap(t) = derivative(hip_spl, t, 1) |> deg2rad
    eapp(t) = derivative(hip_spl, t, 2) |> deg2rad
    # swing shank angle
    fa(t) = evaluate(knee_spl, t) |> deg2rad
    fap(t) = derivative(knee_spl, t, 1) |> deg2rad
    fapp(t) = derivative(knee_spl, t, 2) |> deg2rad
    # HAT CoM location
    hat_spl = Spline1D(hat_data[:, 1], hat_data[:, 2], k = 5)
    gs(t) = evaluate(hat_spl, t)
    gsp(t) = derivative(hat_spl, t, 1)
    gspp(t) = derivative(hat_spl, t, 2)

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
    u7 = ωh |> deg2rad              # hangvel = u7

    # initial angle driven values
    ea₀ = ea(0.0)
    fa₀ = fa(0.0)
    gs₀ = gs(0.0)
    eap₀ = eap(0.0)
    fap₀ = fap(0.0)
    gsp₀ = gsp(0.0)

    u1_fun(ea, fa, gs, eap, fap, gsp) = vcmx - (((((((mg * gsp) / mt) * cos(q3) + ((l10 * me + l10 * mf + l10 * mg + l9 * md) / mt) * (cos(q6) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) - sin(q6) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) - sin(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)))) * (u3 - u7) + ((l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg) / mt) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) * ((u3 - u6) - u7) + 0.5 * ((l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg) / mt) * (cos(q4) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) - sin(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)))) - sin(q4) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) - sin(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))))) * (((u3 - u5) - u6) - u7) + 0.5 * ((l3 * mb) / mt) * (((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) - sin(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)))) * (-(cos(footang)) * sin(q4) - sin(footang) * cos(q4)) + ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) - sin(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)))) * (cos(footang) * cos(q4) - sin(footang) * sin(q4))) * (((u3 - u5) - u6) - u7)) - ((mg * gs) / mt) * sin(q3) * u3) - (sin(ea) * cos(q3) - cos(ea) * sin(q3)) * ((((l10 * mf + me * (l10 - l9)) / mt) * eap - ((l10 * mf + me * (l10 - l9)) / mt) * u3) - ((l10 * mf + me * (l10 - l9)) / mt) * u8)) - ((l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg) / mt) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) - sin(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)))) * ((((u3 - u4) - u5) - u6) - u7)) - (sin(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3)) - cos(fa) * (sin(ea) * cos(q3) - cos(ea) * sin(q3))) * (((((l12 * mf) / mt) * (eap - fap) - ((l12 * mf) / mt) * u3) - ((l12 * mf) / mt) * u8) - ((l12 * mf) / mt) * u9))
    u2_fun(ea, fa, gs, eap, fap, gsp) = vcmy - ((((((mg * gsp) / mt) * sin(q3) + ((mg * gs) / mt) * cos(q3) * u3 + ((l10 * me + l10 * mf + l10 * mg + l9 * md) / mt) * (cos(q6) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) - sin(q6) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)))) * (u3 - u7) + ((l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg) / mt) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) * ((u3 - u6) - u7) + 0.5 * ((l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg) / mt) * (cos(q4) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)))) - sin(q4) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))))) * (((u3 - u5) - u6) - u7) + 0.5 * ((l3 * mb) / mt) * (((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)))) * (-(cos(footang)) * sin(q4) - sin(footang) * cos(q4)) + ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)))) * (cos(footang) * cos(q4) - sin(footang) * sin(q4))) * (((u3 - u5) - u6) - u7)) - (cos(ea) * cos(q3) + sin(ea) * sin(q3)) * ((((l10 * mf + me * (l10 - l9)) / mt) * eap - ((l10 * mf + me * (l10 - l9)) / mt) * u3) - ((l10 * mf + me * (l10 - l9)) / mt) * u8)) - ((l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg) / mt) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)))) * ((((u3 - u4) - u5) - u6) - u7)) - (sin(fa) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - cos(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3))) * (((((l12 * mf) / mt) * (eap - fap) - ((l12 * mf) / mt) * u3) - ((l12 * mf) / mt) * u8) - ((l12 * mf) / mt) * u9))
    u1 = u1_fun(ea₀, fa₀, gs₀, eap₀, fap₀, gsp₀)
    u2 = u2_fun(ea₀, fa₀, gs₀, eap₀, fap₀, gsp₀)

    # set up torque generators
    he = TorqueGenerator(2π - deg2rad(θh), deg2rad(-ωh), tq_p[1][1], tq_p[1][2], α_p[1])
    ke = TorqueGenerator(2π - deg2rad(θk), deg2rad(-ωk), tq_p[2][1], tq_p[2][2], α_p[2])
    ae = TorqueGenerator(2π - deg2rad(θa), deg2rad(-ωa), tq_p[3][1], tq_p[3][2], α_p[3])
    hf = TorqueGenerator(deg2rad(θh), deg2rad(ωh), tq_p[4][1], tq_p[4][2], α_p[4])
    kf = TorqueGenerator(deg2rad(θk), deg2rad(ωk), tq_p[5][1], tq_p[5][2], α_p[5])
    af = TorqueGenerator(deg2rad(θa), deg2rad(ωa), tq_p[6][1], tq_p[6][2], α_p[6])

    # intial CC angles
    θcc₀ = map(x -> x.cc.θ, [he, ke, ae, hf, kf, af])

    # parameters
    p = Params(ea, fa, gs, eap, fap, gsp, eapp, fapp, gspp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l11, l12, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mtpb, mtpk, pop1xi, pop2xi)

    # intial conditions
    u₀ = SVector(q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7, θcc₀...)

    return p, u₀

end

function setup(;
    parameters = "data/parameters.csv",
    initial_conditions = "data/initial_conditions.csv",
    torque_generator_parameters = "data/torque_generator_parameters.csv",
    activation_parameters = "data/activation_parameters.csv",
    swing = "data/matching_swing.csv",
    hat = "data/HAT.csv")

    # load parameters
    input_p, headers_p = readdlm(parameters, ',', Float64, header = true)
    @inbounds footang, g, ina, inb, inc, ind, ine, inf, ing, k1, k2, k3, k4, k5, k6, k7, k8, l1, l10, l11, l12, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mtpb, mtpk, pop1xi, pop2xi = input_p
    mt = ma + mb + mc + md + me + mf + mg
    u8 = u9 = 0.0
    footang = deg2rad(footang)

    # load initial conditions
    input_u, headers_u = readdlm(initial_conditions, ',', Float64, header = true)
    @inbounds Xmtp, Ymtp, q3, θm, θa, θk, θh, vcmx, vcmy, u3, ωm, ωa, ωk, ωh = input_u


    # load torque generator parameters
    tq_p, headers_tq = readdlm(torque_generator_parameters, ',', header = true)
    tq_p = map(eachrow(tq_p)) do x
        x = x[2:end] .|> Float64    # remove row names, convert to float
        [CCParameters(x[1:end-1]...), SECParameters(x[end])]
    end

    # load activation profiles
    α_p, headers_α = readdlm(activation_parameters, ',', header = true)
    α_p = map(eachrow(α_p)) do x
        x = x[2:end] .|> Float64    # remove row names, convert to float
        ActivationProfile(x...)
    end

    # load swing leg and HAT data
    swing_data = readdlm(swing, ',', Float64, skipstart = 1)
    hip_spl = Spline1D(swing_data[:, 1], swing_data[:, 2], k = 5)
    knee_spl = Spline1D(swing_data[:, 1], swing_data[:, 3], k = 5)
    # swing thigh angle
    ea(t) = evaluate(hip_spl, t) |> deg2rad
    eap(t) = derivative(hip_spl, t, 1) |> deg2rad
    eapp(t) = derivative(hip_spl, t, 2) |> deg2rad
    # swing shank angle
    fa(t) = evaluate(knee_spl, t) |> deg2rad
    fap(t) = derivative(knee_spl, t, 1) |> deg2rad
    fapp(t) = derivative(knee_spl, t, 2) |> deg2rad
    # HAT CoM location
    hat_data = readdlm(hat, ',', Float64, skipstart = 1)
    hat_spl = Spline1D(hat_data[:, 1], hat_data[:, 2], k = 5)
    gs(t) = evaluate(hat_spl, t)
    gsp(t) = derivative(hat_spl, t, 1)
    gspp(t) = derivative(hat_spl, t, 2)

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
    eap₀ = eap(0.0)
    fap₀ = fap(0.0)
    gsp₀ = gsp(0.0)

    # u1 = 1.78872
    # u2 = -3.877485
    u1_fun(ea, fa, gs, eap, fap, gsp) = vcmx - (((((((mg * gsp) / mt) * cos(q3) + ((l10 * me + l10 * mf + l10 * mg + l9 * md) / mt) * (cos(q6) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) - sin(q6) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) - sin(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)))) * (u3 - u7) + ((l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg) / mt) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) * ((u3 - u6) - u7) + 0.5 * ((l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg) / mt) * (cos(q4) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) - sin(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)))) - sin(q4) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) - sin(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))))) * (((u3 - u5) - u6) - u7) + 0.5 * ((l3 * mb) / mt) * (((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) - sin(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)))) * (-(cos(footang)) * sin(q4) - sin(footang) * cos(q4)) + ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) - sin(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)))) * (cos(footang) * cos(q4) - sin(footang) * sin(q4))) * (((u3 - u5) - u6) - u7)) - ((mg * gs) / mt) * sin(q3) * u3) - (sin(ea) * cos(q3) - cos(ea) * sin(q3)) * ((((l10 * mf + me * (l10 - l9)) / mt) * eap - ((l10 * mf + me * (l10 - l9)) / mt) * u3) - ((l10 * mf + me * (l10 - l9)) / mt) * u8)) - ((l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg) / mt) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)) - sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) - sin(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)))) * ((((u3 - u4) - u5) - u6) - u7)) - (sin(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3)) - cos(fa) * (sin(ea) * cos(q3) - cos(ea) * sin(q3))) * (((((l12 * mf) / mt) * (eap - fap) - ((l12 * mf) / mt) * u3) - ((l12 * mf) / mt) * u8) - ((l12 * mf) / mt) * u9))
    u2_fun(ea, fa, gs, eap, fap, gsp) = vcmy - ((((((mg * gsp) / mt) * sin(q3) + ((mg * gs) / mt) * cos(q3) * u3 + ((l10 * me + l10 * mf + l10 * mg + l9 * md) / mt) * (cos(q6) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) - sin(q6) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)))) * (u3 - u7) + ((l7 * mc + l8 * md + l8 * me + l8 * mf + l8 * mg) / mt) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) * ((u3 - u6) - u7) + 0.5 * ((l4 * mb + 2 * l6 * mc + 2 * l6 * md + 2 * l6 * me + 2 * l6 * mf + 2 * l6 * mg) / mt) * (cos(q4) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)))) - sin(q4) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))))) * (((u3 - u5) - u6) - u7) + 0.5 * ((l3 * mb) / mt) * (((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7))) + (-(cos(q4)) * sin(q5) - sin(q4) * cos(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7)))) * (-(cos(footang)) * sin(q4) - sin(footang) * cos(q4)) + ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)))) * (cos(footang) * cos(q4) - sin(footang) * sin(q4))) * (((u3 - u5) - u6) - u7)) - (cos(ea) * cos(q3) + sin(ea) * sin(q3)) * ((((l10 * mf + me * (l10 - l9)) / mt) * eap - ((l10 * mf + me * (l10 - l9)) / mt) * u3) - ((l10 * mf + me * (l10 - l9)) / mt) * u8)) - ((l1 * ma + l2 * mb + l2 * mc + l2 * md + l2 * me + l2 * mf + l2 * mg) / mt) * ((cos(q4) * cos(q5) - sin(q4) * sin(q5)) * (cos(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)) + sin(q3) * (cos(q6) * sin(q7) + sin(q6) * cos(q7))) + (cos(q4) * sin(q5) + sin(q4) * cos(q5)) * (cos(q3) * (-(cos(q6)) * sin(q7) - sin(q6) * cos(q7)) + sin(q3) * (cos(q6) * cos(q7) - sin(q6) * sin(q7)))) * ((((u3 - u4) - u5) - u6) - u7)) - (sin(fa) * (cos(ea) * sin(q3) - sin(ea) * cos(q3)) - cos(fa) * (cos(ea) * cos(q3) + sin(ea) * sin(q3))) * (((((l12 * mf) / mt) * (eap - fap) - ((l12 * mf) / mt) * u3) - ((l12 * mf) / mt) * u8) - ((l12 * mf) / mt) * u9))
    u1 = u1_fun(ea₀, fa₀, gs₀, eap₀, fap₀, gsp₀)
    u2 = u2_fun(ea₀, fa₀, gs₀, eap₀, fap₀, gsp₀)

    # set up torque generators
    he = TorqueGenerator(2π - deg2rad(θh), deg2rad(-ωh), tq_p[1][1], tq_p[1][2], α_p[1])
    ke = TorqueGenerator(2π - deg2rad(θk), deg2rad(-ωk), tq_p[2][1], tq_p[2][2], α_p[2])
    ae = TorqueGenerator(2π - deg2rad(θa), deg2rad(-ωa), tq_p[3][1], tq_p[3][2], α_p[3])
    hf = TorqueGenerator(deg2rad(θh), deg2rad(ωh), tq_p[4][1], tq_p[4][2], α_p[4])
    kf = TorqueGenerator(deg2rad(θk), deg2rad(ωk), tq_p[5][1], tq_p[5][2], α_p[5])
    af = TorqueGenerator(deg2rad(θa), deg2rad(ωa), tq_p[6][1], tq_p[6][2], α_p[6])
    θcc₀ = map(x -> x.cc.θ, [he, ke, ae, hf, kf, af])

    # parameters
    p = Params(ea, fa, gs, eap, fap, gsp, eapp, fapp, gspp, ae, af, footang, g, he, hf, ina, inb, inc, ind, ine, inf, ing, k1, k2, k3, k4, k5, k6, k7, k8, ke, kf, l1, l10, l11, l12, l2, l3, l4, l5, l6, l7, l8, l9, ma, mb, mc, md, me, mf, mg, mtpb, mtpk, pop1xi, pop2xi)

    # intial conditions
    u₀ = SVector(q1, q2, q3, q4, q5, q6, q7, u1, u2, u3, u4, u5, u6, u7, θcc₀...)

    return p, u₀
end
