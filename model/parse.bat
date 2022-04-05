@echo off 
set a=%1.2.json
:: parse to json
dotnet "C:\Users\rottier\fortran parser\fortran-parser.dll" %1

:: parse to julia
julia --project="C:\Users\rottier\fortran parser" "C:\Users\rottiers\fortran parser\parse.jl" %a%

