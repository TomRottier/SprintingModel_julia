@echo off 
set a=%1.2.json
:: parse to json
C:\Users\rottier\Downloads\dotnet-sdk-5.0.408-win-x64\dotnet C:\Users\rottier\Downloads\dotnet-sdk-5.0.408-win-x64\fortran-parser.dll %1

:: parse to julia
C:\Users\rottier\.julia\juliaup\julia-1.7.1+0~x64\bin\julia.exe --project="C:\Users\rottier\fortran2julia" "C:\Users\rottier\fortran2julia\parse.jl" %a% %2

