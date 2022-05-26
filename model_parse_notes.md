# Notes regarding the parsing of the model from fortran to julia

- pop2x/pop2y not included in functions.jl as they are calculated in eom and not io []

- same with joint torques []

- to get specified variables in their own common block in the fortran file, don't specify any value for them - causes some slight inconvenience when building model (e.g. can't build it from command line commands, needs keyboard input) []

- calculated parameters e.g. mt,u8,u9 don't get unpacked in functions.jl [X]

- functions in parameters struct need their own paramteric types - big performance increase [X]
    - don't need to put specified functions inside parameter struct

- could add option to specify which files get output []

- Params struct can't convert u8,u9 to floats which it needs to have same type as other fields

- Have to change torque generator type afterwards as you won't know from al file

- forces in eom.jl use z values which, on intial call, are not set []

- may be useful to have some functions also in z form e.g. when calculating pocmy in eom

- angle-driven joint torque functions need up's and vrx/y

- dont need to unwind IO functions can just have call to eom to set Z array
 - wont have correct values in Z for values set in IO
