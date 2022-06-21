## fit splines to angle data to drive joints
using Dierckx, Interpolations

# fit quintic splines to data
joint_data = readdlm("data\\matchingData.csv", ',', Float64, skipstart=2)
hat_data = readdlm("data\\HAT.csv", ',', Float64, skipstart=2)

## define functions
const _time = joint_data[:, 1]
const rh_spl = Spline1D(_time, joint_data[:, 4], k=5, s=0.0)
const lh_spl = Spline1D(_time, joint_data[:, 5], k=5, s=0.0)
const rk_spl = Spline1D(_time, joint_data[:, 6], k=5, s=0.0)
const lk_spl = Spline1D(_time, joint_data[:, 7], k=5, s=0.0)
const ra_spl = Spline1D(_time, joint_data[:, 8], k=5, s=0.0)
const la_spl = Spline1D(_time, joint_data[:, 9], k=5, s=0.0)
const rmtp_spl = Spline1D(_time, joint_data[:, 10], k=5, s=0.0)
const lmtp_spl = Spline1D(_time, joint_data[:, 11], k=5, s=0.0)
const rs_spl = Spline1D(_time, joint_data[:, 8], k=5, s=0.0)
const ls_spl = Spline1D(_time, joint_data[:, 9], k=5, s=0.0)
const re_spl = Spline1D(_time, joint_data[:, 8], k=5, s=0.0)
const le_spl = Spline1D(_time, joint_data[:, 9], k=5, s=0.0)

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

# left hip
data0 = evaluate(lh_spl, new_time)
data1 = derivative(lh_spl, new_time, 1)
data2 = derivative(lh_spl, new_time, 2)

const lh_spl0 = CubicSplineInterpolation(new_time, data0)
const lh_spl1 = CubicSplineInterpolation(new_time, data1)
const lh_spl2 = CubicSplineInterpolation(new_time, data2)

_lh(t) = lh_spl0(t) |> deg2rad
_lhp(t) = lh_spl1(t) |> deg2rad
_lhpp(t) = lh_spl2(t) |> deg2rad

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


# left knee
data0 = evaluate(lk_spl, new_time)
data1 = derivative(lk_spl, new_time, 1)
data2 = derivative(lk_spl, new_time, 2)

const lk_spl0 = CubicSplineInterpolation(new_time, data0)
const lk_spl1 = CubicSplineInterpolation(new_time, data1)
const lk_spl2 = CubicSplineInterpolation(new_time, data2)

_lk(t) = lk_spl0(t) |> deg2rad
_lkp(t) = lk_spl1(t) |> deg2rad
_lkpp(t) = lk_spl2(t) |> deg2rad


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

# left ankle
data0 = evaluate(la_spl, new_time)
data1 = derivative(la_spl, new_time, 1)
data2 = derivative(la_spl, new_time, 2)

const la_spl0 = CubicSplineInterpolation(new_time, data0)
const la_spl1 = CubicSplineInterpolation(new_time, data1)
const la_spl2 = CubicSplineInterpolation(new_time, data2)

_la(t) = la_spl0(t) |> deg2rad
_lap(t) = la_spl1(t) |> deg2rad
_lapp(t) = la_spl2(t) |> deg2rad


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

# left mtp
data0 = evaluate(lmtp_spl, new_time)
data1 = derivative(lmtp_spl, new_time, 1)
data2 = derivative(lmtp_spl, new_time, 2)

const lmtp_spl0 = CubicSplineInterpolation(new_time, data0)
const lmtp_spl1 = CubicSplineInterpolation(new_time, data1)
const lmtp_spl2 = CubicSplineInterpolation(new_time, data2)

_lmtp(t) = lmtp_spl0(t) |> deg2rad
_lmtpp(t) = lmtp_spl1(t) |> deg2rad
_lmtppp(t) = lmtp_spl2(t) |> deg2rad

# hat com
data0 = evaluate(hat_spl, new_time)
data1 = derivative(hat_spl, new_time, 1)
data2 = derivative(hat_spl, new_time, 2)

const hat_spl0 = CubicSplineInterpolation(new_time, data0)
const hat_spl1 = CubicSplineInterpolation(new_time, data1)
const hat_spl2 = CubicSplineInterpolation(new_time, data2)

_hato(t) = hat_spl0(t)
_hatop(t) = hat_spl1(t)
_hatopp(t) = hat_spl2(t)

