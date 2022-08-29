## fit splines to angle data to drive joints
using Dierckx, Interpolations

# fit quintic splines to data
joint_data = readdlm("data\\matching_data.csv", ',', Float64, skipstart=2)

## define functions
const _time = joint_data[:, 1]
const rh_spl = Spline1D(_time, joint_data[:, 3], k=5, s=0.0)
const rk_spl = Spline1D(_time, joint_data[:, 5], k=5, s=0.0)
const ra_spl = Spline1D(_time, joint_data[:, 7], k=5, s=0.0)
const rmtp_spl = Spline1D(_time, joint_data[:, 9], k=5, s=10.0)
const rs_spl = Spline1D(_time, joint_data[:, 11], k=5, s=0.0)
const ls_spl = Spline1D(_time, joint_data[:, 12], k=5, s=0.0)
const re_spl = Spline1D(_time, joint_data[:, 13], k=5, s=0.0)
const le_spl = Spline1D(_time, joint_data[:, 14], k=5, s=0.0)

## using Dierckx.jl
# _rh(t) = evaluate(rh_spl, t) .|> deg2rad
# _rhp(t) = derivative(rh_spl, t, 1) .|> deg2rad
# _rhpp(t) = derivative(rh_spl, t, 2) .|> deg2rad
# _lh(t) = evaluate(lh_spl, t) .|> deg2rad
# _lhp(t) = derivative(lh_spl, t, 1) .|> deg2rad
# _lhpp(t) = derivative(lh_spl, t, 2) .|> deg2rad

# _rk(t) = evaluate(rk_spl, t) .|> deg2rad
# _rkp(t) = derivative(rk_spl, t, 1) .|> deg2rad
# _rkpp(t) = derivative(rk_spl, t, 2) .|> deg2rad
# _lk(t) = evaluate(lk_spl, t) .|> deg2rad
# _lkp(t) = derivative(lk_spl, t, 1) .|> deg2rad
# _lkpp(t) = derivative(lk_spl, t, 2) .|> deg2rad

# _ra(t) = evaluate(ra_spl, t) .|> deg2rad
# _rap(t) = derivative(ra_spl, t, 1) .|> deg2rad
# _rapp(t) = derivative(ra_spl, t, 2) .|> deg2rad
# _la(t) = evaluate(la_spl, t) .|> deg2rad
# _lap(t) = derivative(la_spl, t, 1) .|> deg2rad
# _lapp(t) = derivative(la_spl, t, 2) .|> deg2rad

# _rmtp(t) = evaluate(rmtp_spl, t) .|> deg2rad
# _rmtpp(t) = derivative(rmtp_spl, t, 1) .|> deg2rad
# _rmtppp(t) = derivative(rmtp_spl, t, 2) .|> deg2rad
# _lmtp(t) = evaluate(lmtp_spl, t) .|> deg2rad
# _lmtpp(t) = derivative(lmtp_spl, t, 1) .|> deg2rad
# _lmtppp(t) = derivative(lmtp_spl, t, 2) .|> deg2rad

# _hato(t) = evaluate(hat_spl, t) .|> deg2rad
# _hatop(t) = derivative(hat_spl, t, 1) .|> deg2rad
# _hatopp(t) = derivative(hat_spl, t, 2) .|> deg2rad

## using Interpolations.jl
# time base
new_time = 0:0.001:_time[end]

## interpolate data and derivatives
# right hip
data0 = evaluate(rh_spl, new_time)
data1 = derivative(rh_spl, new_time, 1)
data2 = derivative(rh_spl, new_time, 2)

const rh_spl0 = CubicSplineInterpolation(new_time, data0)
const rh_spl1 = CubicSplineInterpolation(new_time, data1)
const rh_spl2 = CubicSplineInterpolation(new_time, data2)

_rh(t) = rh_spl0(t) |> deg2rad
_rhp(t) = rh_spl1(t) |> deg2rad
_rhpp(t) = rh_spl2(t) |> deg2rad

# right knee
data0 = evaluate(rk_spl, new_time)
data1 = derivative(rk_spl, new_time, 1)
data2 = derivative(rk_spl, new_time, 2)

const rk_spl0 = CubicSplineInterpolation(new_time, data0)
const rk_spl1 = CubicSplineInterpolation(new_time, data1)
const rk_spl2 = CubicSplineInterpolation(new_time, data2)

_rk(t) = rk_spl0(t) |> deg2rad
_rkp(t) = rk_spl1(t) |> deg2rad
_rkpp(t) = rk_spl2(t) |> deg2rad

# right ankle
data0 = evaluate(ra_spl, new_time)
data1 = derivative(ra_spl, new_time, 1)
data2 = derivative(ra_spl, new_time, 2)

const ra_spl0 = CubicSplineInterpolation(new_time, data0)
const ra_spl1 = CubicSplineInterpolation(new_time, data1)
const ra_spl2 = CubicSplineInterpolation(new_time, data2)

_ra(t) = ra_spl0(t) |> deg2rad
_rap(t) = ra_spl1(t) |> deg2rad
_rapp(t) = ra_spl2(t) |> deg2rad

# right mtp
data0 = evaluate(rmtp_spl, new_time)
data1 = derivative(rmtp_spl, new_time, 1)
data2 = derivative(rmtp_spl, new_time, 2)

const rmtp_spl0 = CubicSplineInterpolation(new_time, data0)
const rmtp_spl1 = CubicSplineInterpolation(new_time, data1)
const rmtp_spl2 = CubicSplineInterpolation(new_time, data2)

_rmtp(t) = rmtp_spl0(t) |> deg2rad
_rmtpp(t) = rmtp_spl1(t) |> deg2rad
_rmtppp(t) = rmtp_spl2(t) |> deg2rad

# right shoulder
data0 = evaluate(rs_spl, new_time)
data1 = derivative(rs_spl, new_time, 1)
data2 = derivative(rs_spl, new_time, 2)

const rs_spl0 = CubicSplineInterpolation(new_time, data0)
const rs_spl1 = CubicSplineInterpolation(new_time, data1)
const rs_spl2 = CubicSplineInterpolation(new_time, data2)

_rs(t) = rs_spl0(t) |> deg2rad
_rsp(t) = rs_spl1(t) |> deg2rad
_rspp(t) = rs_spl2(t) |> deg2rad

# left shoulder
data0 = evaluate(ls_spl, new_time)
data1 = derivative(ls_spl, new_time, 1)
data2 = derivative(ls_spl, new_time, 2)

const ls_spl0 = CubicSplineInterpolation(new_time, data0)
const ls_spl1 = CubicSplineInterpolation(new_time, data1)
const ls_spl2 = CubicSplineInterpolation(new_time, data2)

_ls(t) = ls_spl0(t) |> deg2rad
_lsp(t) = ls_spl1(t) |> deg2rad
_lspp(t) = ls_spl2(t) |> deg2rad


# right elbow
data0 = evaluate(re_spl, new_time)
data1 = derivative(re_spl, new_time, 1)
data2 = derivative(re_spl, new_time, 2)

const re_spl0 = CubicSplineInterpolation(new_time, data0)
const re_spl1 = CubicSplineInterpolation(new_time, data1)
const re_spl2 = CubicSplineInterpolation(new_time, data2)

_re(t) = re_spl0(t) |> deg2rad
_rep(t) = re_spl1(t) |> deg2rad
_repp(t) = re_spl2(t) |> deg2rad

# left elbow
data0 = evaluate(le_spl, new_time)
data1 = derivative(le_spl, new_time, 1)
data2 = derivative(le_spl, new_time, 2)

const le_spl0 = CubicSplineInterpolation(new_time, data0)
const le_spl1 = CubicSplineInterpolation(new_time, data1)
const le_spl2 = CubicSplineInterpolation(new_time, data2)

_le(t) = le_spl0(t) |> deg2rad
_lep(t) = le_spl1(t) |> deg2rad
_lepp(t) = le_spl2(t) |> deg2rad
