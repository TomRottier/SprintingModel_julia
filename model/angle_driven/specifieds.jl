## fit splines to angle data to drive joints
using Dierckx, Interpolations

# fit quintic splines to data
joint_data = readdlm("data\\matchingData.csv", ',', Float64, skipstart=2)
hat_data = readdlm("data\\HAT.csv", ',', Float64, skipstart=2)
_time = joint_data[:, 1]
rh_spl = Spline1D(_time, joint_data[:, 4], k=5, s=0.0)
lh_spl = Spline1D(_time, joint_data[:, 5], k=5, s=0.0)
rk_spl = Spline1D(_time, joint_data[:, 6], k=5, s=0.0)
lk_spl = Spline1D(_time, joint_data[:, 7], k=5, s=0.0)
ra_spl = Spline1D(_time, joint_data[:, 8], k=5, s=0.0)
la_spl = Spline1D(_time, joint_data[:, 9], k=5, s=0.0)
rmtp_spl = Spline1D(_time, joint_data[:, 10], k=5, s=0.0)
lmtp_spl = Spline1D(_time, joint_data[:, 11], k=5, s=0.0)
hat_spl = Spline1D(hat_data[:, 1], hat_data[:, 2], k=5, s=0.0)

# get data for 1st and 2nd derivatives then interpolate
function fit_spl(time, spl; d2r=true)
    # evaluate 0th, 1st and 2nd derivative over time
    if d2r
        data0 = evaluate(spl, time) .|> deg2rad
        data1 = derivative(spl, time, 1) .|> deg2rad
        data2 = derivative(spl, time, 2) .|> deg2rad
    else
        data0 = evaluate(spl, time)
        data1 = derivative(spl, time, 1)
        data2 = derivative(spl, time, 2)
    end

    # interpolate over data
    spl0 = CubicSplineInterpolation(time, data0, extrapolation_bc=Flat())
    spl1 = CubicSplineInterpolation(time, data1, extrapolation_bc=Flat())
    spl2 = CubicSplineInterpolation(time, data2, extrapolation_bc=Flat())

    return spl0, spl1, spl2
end

# generate functions
new_time = _time[1]:0.001:_time[end]
_rh, _rhp, _rhpp = fit_spl(new_time, rh_spl)
_lh, _lhp, _lhpp = fit_spl(new_time, lh_spl)
_rk, _rkp, _rkpp = fit_spl(new_time, rk_spl)
_lk, _lkp, _lkpp = fit_spl(new_time, lk_spl)
_ra, _rap, _rapp = fit_spl(new_time, ra_spl)
_la, _lap, _lapp = fit_spl(new_time, la_spl)
_rmtp, _rmtpp, _rmtppp = fit_spl(new_time, rmtp_spl)
_lmtp, _lmtpp, _lmtppp = fit_spl(new_time, lmtp_spl)
_hato, _hatop, _hatopp = fit_spl(new_time, hat_spl, d2r=false)

