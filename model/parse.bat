@echo off 
set a=%1.2.json
:: parse to json
dotnet C:\Users\tomro\projects\fortran2julia\fortran-parser.dll %1

:: parse to julia
julia --project="C:\Users\tomro\projects\fortran2julia" "C:\Users\tomro\projects\fortran2julia\parse.jl" %a% %2

