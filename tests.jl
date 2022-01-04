## test objective function works in parallel (distributed and multithreaded)
using Distributed, SharedArrays
addprocs(4, exeflags = "--project")   
@everywhere include("parallel_setup.jl")

# vector of random parameters 
xs = [rand(60) for _ in 1:100]

# dictionaries to hold results
res_ser = Dict{Int, Float64}()
res_thr = copy(res_ser)
res_dis = copy(res_ser)


# serial
[res_ser[i] = objective(x) for (i,x) in enumerate(xs)]

# multi-threaded - NOT WORKING
Threads.@threads for (i,x) in collect(enumerate(xs))
    res_thr[i] = objective(x)
end

# distributed - WORKING
@everywhere begin 
    call_fun(dic, xs) = [dic[i] = objective(x) for (i, x) in enumerate(xs)]
    xs = $(copy(xs))
    res_dis = $(copy(res_dis))
    call_fun(res_dis, xs)
end

# alternative distributed - WORKING
res_dis2 = SharedArray{Float64}(100)
@sync @distributed for (i,x) in collect(enumerate(xs))
    res_dis2[i] = objective(x)
end

@show res_ser[2];
@show res_thr[2];
@everywhere @show res_dis[2]
@show res_dis2[2];