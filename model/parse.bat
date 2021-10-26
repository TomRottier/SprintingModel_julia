@echo off 
set a=%1.2.json
:: parse to json
dotnet "C:\Users\tomro\fortran parser\fortran-parser.dll" %1

:: parse to julia
julia "C:\Users\tomro\fortran parser\parse.jl" %a%

