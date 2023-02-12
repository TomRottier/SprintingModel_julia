## functions used to optimise model
const INTEGRATOR = Tsit5()
const INT_OPTIONS = (saveat=0.001, abstol=1e-8, reltol=1e-8, verbose=false, maxiters=2e4)

# to get progress bar
#=using Logging: global_logger
using TerminalLoggers: TerminalLogger
global_logger(TerminalLogger())

then add progress=true and progress_steps=x to solve call

=#

# objective
objective(x) = #cost(simulate(prob, x)...)
    try
        cost(simulate(prob, x))
    catch
        return 1e7
    end

# simulate with new parameters
function simulate(prob::ODEProblem, x)
    # new parameter struct with updated parameters from x
    pnew, unew = update_parameters(prob.p, x, prob.u0)

    # new ODEProblem
    newprob = remake(prob, u0=unew, p=pnew)

    # solve new problem
    return solve(newprob, INTEGRATOR; callback=vcb, saveat=0.001, abstol=1e-8, reltol=1e-8, verbose=false)
end


# mean squared error between two vectors
mse(x, y) = (x .- y) .^ 2 |> mean

# cost function for simulation
function cost(sol)
    # difference between start and end for opposite legs
    # q1_s, q2_s, q3_s, q4_s, q5_s, q6_s, q7_s, q8_s, q9_s, q10_s, q11_s = sol(0.0)
    # q1_e, q2_e, q3_e, q4_e, q5_e, q6_e, q7_e, q8_e, q9_e, q10_e, q11_e = sol(sol.t[end])
    # j1 = (q3_s - q3_e)^2 # torso
    # j2 = (q4_s - q8_e)^2 # left hip
    # j3 = (q5_s - q9_e)^2 # left knee
    # j4 = (q6_s - q10_e)^2 # left ankle
    # j5 = (q7_s - q11_e)^2 # left mtp
    # j6 = (q8_s - q4_e)^2 # right hip
    # j7 = (q9_s - q5_e)^2 # right knee
    # j8 = (q10_s - q6_e)^2 # right ankle
    # j9 = (q11_s - q7_e)^2 # right mtp

    start = sol(0.0, idxs=1:22)
    stop = sol(sol.t[end], idxs=1:22)

    pairs = [3 => 3, 4 => 8, 5 => 9, 6 => 10, 7 => 11, 8 => 4, 9 => 5, 10 => 6, 11 => 7]
    jθ = 0
    jω = 0
    for (k, v) in pairs
        jθ += (start[k] - stop[v])^2
        # jω += (start[k+11] - stop[v+11])^2
    end

    return jθ
end

cost(sol1, sol2) = cost([Array(sol1(0:0.001:sol1.t[end-1])) Array(sol2(sol1.t[end-1]+0.001:0.001:sol2.t[end]))])
cost(sol1, err::Int) = 1e7 - err
cost(err1::Int, err2::Int) = 1e7 - 10err1 - err2

# update parameters from vector
function update_parameters(p, x, u)
    @unpack lhe, lke, lae, lhf, lkf, laf, rhe, rke, rae, rhf, rkf, raf = p
    q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11 = u

    # manually separate out
    # lhe_α_p = ActivationProfile(x[1:10])
    # lke_α_p = ActivationProfile(x[11:20])
    # lae_α_p = ActivationProfile(x[21:30])
    # lhf_α_p = ActivationProfile(x[31:40])
    # lkf_α_p = ActivationProfile(x[41:50])
    # laf_α_p = ActivationProfile(x[51:60])
    # rhe_α_p = ActivationProfile(x[61:70])
    # rke_α_p = ActivationProfile(x[71:80])
    # rae_α_p = ActivationProfile(x[81:90])
    # rhf_α_p = ActivationProfile(x[91:100])
    # rkf_α_p = ActivationProfile(x[101:110])
    # raf_α_p = ActivationProfile(x[111:120])
    lhe_α_p = ActivationProfile(x[1:7])
    lke_α_p = ActivationProfile(x[8:14])
    lae_α_p = ActivationProfile(x[15:21])
    lhf_α_p = ActivationProfile(x[22:28])
    lkf_α_p = ActivationProfile(x[29:35])
    laf_α_p = ActivationProfile(x[36:42])
    rhe_α_p = ActivationProfile(x[43:49])
    rke_α_p = ActivationProfile(x[50:56])
    rae_α_p = ActivationProfile(x[57:63])
    rhf_α_p = ActivationProfile(x[64:70])
    rkf_α_p = ActivationProfile(x[71:77])
    raf_α_p = ActivationProfile(x[78:84])


    # _k1, _k2, _k3, _k4, _k5, _k6, _k7, _k8 = x[121:128]
    _k1, _k2, _k3, _k4, _k5, _k6, _k7, _k8 = x[85:92]


    # torque generators with inital values and new activation parameters
    _lhe = TorqueGenerator(2π - q4, -u4, lhe.cc.cc_p, lhe.sec.sec_p, lhe_α_p)
    _lke = TorqueGenerator(2π - q5, -u5, lke.cc.cc_p, lke.sec.sec_p, lke_α_p)
    _lae = TorqueGenerator(2π - q6, -u6, lae.cc.cc_p, lae.sec.sec_p, lae_α_p)
    _lhf = TorqueGenerator(q4, u4, lhf.cc.cc_p, lhf.sec.sec_p, lhf_α_p)
    _lkf = TorqueGenerator(q5, u5, lkf.cc.cc_p, lkf.sec.sec_p, lkf_α_p)
    _laf = TorqueGenerator(q6, u6, laf.cc.cc_p, laf.sec.sec_p, laf_α_p)
    _rhe = TorqueGenerator(2π - q8, -u8, rhe.cc.cc_p, rhe.sec.sec_p, rhe_α_p)
    _rke = TorqueGenerator(2π - q9, -u9, rke.cc.cc_p, rke.sec.sec_p, rke_α_p)
    _rae = TorqueGenerator(2π - q10, -u10, rae.cc.cc_p, rae.sec.sec_p, rae_α_p)
    _rhf = TorqueGenerator(q8, u8, rhf.cc.cc_p, rhf.sec.sec_p, rhf_α_p)
    _rkf = TorqueGenerator(q9, u9, rkf.cc.cc_p, rkf.sec.sec_p, rkf_α_p)
    _raf = TorqueGenerator(q10, u10, raf.cc.cc_p, raf.sec.sec_p, raf_α_p)

    # get new initial CC angles
    _u₀ = SVector(u[1:22]..., map(x -> x.cc.θ, [_lhe, _lke, _lae, _lhf, _lkf, _laf, _rhe, _rke, _rae, _rhf, _rkf, _raf])...)


    # returns new Params struct with torque generators ready for next simulation
    _p = setproperties(p, (lhe=_lhe, lke=_lke, lae=_lae, lhf=_lhf, lkf=_lkf, laf=_laf, rhe=_rhe, rke=_rke, rae=_rae, rhf=_rhf, rkf=_rkf, raf=_raf, k1=_k1, k2=_k2, k3=_k3, k4=_k4, k5=_k5, k6=_k6, k7=_k7, k8=_k8))

    return _p, _u₀
end