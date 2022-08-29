% torque driven model of sprinting
% two four segment legs and two two segment arms
% virtual force applied during second stance
%
% tom rottier 2022
% ------------------------------------------------------------------------------
autoz on          
degrees off         % sometimes get problems with using pi if not specified
% physical declarations
newtonian n
bodies rff,rrf,rsh,rth,lff,lrf,lsh,lth,hat,rua,rla,lua,lla
frames rrff,lrff            % frame for rear foot
points o,p{16},cm,rrf{2}o,lrf{2}o
mass rff=mff,rrf=mrf,rsh=msh,rth=mth,lff=mff,lrf=mrf,lsh=msh,lth=mth,hat=mhat
mass rua=mua,rla=mla,lua=mua,lla=mla
inertia rff,0,0,iff
inertia rrf,0,0,irf
inertia rsh,0,0,ish
inertia rth,0,0,ith
inertia lff,0,0,iff    
inertia lrf,0,0,irf   
inertia lsh,0,0,ish
inertia lth,0,0,ith
inertia hat,0,0,ihat
inertia rua,0,0,iua
inertia rla,0,0,ila
inertia lua,0,0,iua
inertia lla,0,0,ila

% 
% mathematical declarations
variables q{7}'		        % global position (x,y) and orientation of HAT
variables u{14}'            % generalised speeds, u8-u14 to determine torques at joints
variables lh'',lk'',la'',lmtp''
variables vrx{2},vry{2},rx{2},ry{2}		% one spring under toe, one under mtp for both feet
variables kecm,pecm,te,hz,px,py
variables rhtq,rktq,ratq,rstq,lstq,retq,letq
constants lff,lrf,lsh,lth,lhat,lua,lla % length of segments
constants lffo,lrfo,lsho,ltho,lhato,luao,llao  % lengths from distal joint to CoM
constants lrff, lrffo          % lenghts for rear foot frame
constants k{8}		   % vertical and horizontal stiffness and damping
constants mtpk,mtpb    % rotational stiffness and damping for mtp joint 
constants g
constants footang      % angle of mtp-heel line relative to mtp-ajc line
constants toexi,mtpxi % initial x positions for springs
constants he,ke,ae,hf,kf,af % parameters of torque generators
specified rh'',rk'',ra'',rmtp'',rs'',ls'',re'',le'' % specified joint angles
specified lhtq,lktq,latq,lmtq
%
%
% ------------------------------------------------------------------------------
% geometry
simprot(n,hat,3,q3)         % global orientation/trunk angle
simprot(hat,rth,3,2*pi - rh)
simprot(hat,lth,3,2*pi - q4)
simprot(rth,rsh,3,rk - pi)
simprot(lth,lsh,3,q5 - pi)
simprot(rsh,rrf,3,pi - ra)
simprot(lsh,lrf,3,pi - q6)
simprot(rrf,rff,3,pi - rmtp)
simprot(lrf,lff,3,pi - q7)
simprot(hat,rua,3,pi - rs)
simprot(hat,lua,3,pi - ls)
simprot(rua,rla,3,re - pi)
simprot(lua,lla,3,le - pi)

simprot(rrf,rrff,3,footang)    % rear foot frame rotated about rear foot
simprot(lrf,lrff,3,footang)
%
% ------------------------------------------------------------------------------
% position vectors
p_o_p1>   = q1*n1> + q2*n2>		            % origin to toes
p_p6_hato> = lhato*hat1>
p_p6_p12> = lhat*hat1>  % hip joint to shoulder joint

% left leg - initially stance
p_p1_lffo> = -lffo*lff1>
p_p1_p2> = -lff*lff1>
p_p2_lrf1o> = -lrfo*lrf1>   % mtp to position along mtp-ajc line
p_p2_lrf2o> = -lrffo*lrff1> % mtp to position along mtp-heel line
p_p2_lrfo> = (p_p2_lrf1o> + p_p2_lrf2o>) / 2 % com of rear foot as average between two points
p_p2_p3> = -lrff*lrff1>     % mtp to heel
p_p2_p4> = -lrf*lrf1>       % mtp to ajc
p_p4_lsho> = -lsho*lsh1>
p_p4_p5> = -lsh*lsh1>
p_p5_ltho> = -ltho*lth1>
p_p5_p6> = -lth*lth1>

% right leg - intially swing
p_p7_rtho> = -ltho*rth1>
p_p7_p6> = -lth*rth1>
p_p8_rsho> = -lsho*rsh1>
p_p8_p7> = -lsh*rsh1>
p_p10_rrf1o> = -lrfo*rrf1>
p_p10_rrf2o> = -lrffo*rrff1>
p_p10_rrfo> = (p_p10_rrf1o> + p_p10_rrf2o>) / 2
p_p10_p9> = -lrff*rrff1>
p_p10_p8> = -lrf*rrf1>
p_p11_rffo> = -lffo*rff1>
p_p11_p10> = -lff*rff1>

% right arm
p_p12_ruao> = luao*rua1>
p_p12_p13> = lua*rua1>
p_p13_rlao> = llao*rla1>
p_p13_p14> = lla*rla1>

% left arm
p_p12_luao> = luao*lua1>
p_p12_p15> = lua*lua1>
p_p15_llao> = llao*lla1>
p_p15_p16> = lla*lla1>

%
% xy of points
pop1x = dot(p_o_p1>,n1>)
pop1y = dot(p_o_p1>,n2>)
pop2x = dot(p_o_p2>,n1>)
pop2y = dot(p_o_p2>,n2>)
pop3x = dot(p_o_p3>,n1>)
pop3y = dot(p_o_p3>,n2>)
pop4x = dot(p_o_p4>,n1>)
pop4y = dot(p_o_p4>,n2>)
pop5x = dot(p_o_p5>,n1>)
pop5y = dot(p_o_p5>,n2>)
pop6x = dot(p_o_p6>,n1>)
pop6y = dot(p_o_p6>,n2>)
pop7x = dot(p_o_p7>,n1>)
pop7y = dot(p_o_p7>,n2>)
pop8x = dot(p_o_p8>,n1>)
pop8y = dot(p_o_p8>,n2>)
pop9x = dot(p_o_p9>,n1>)
pop9y = dot(p_o_p9>,n2>)
pop10x = dot(p_o_p10>,n1>)
pop10y = dot(p_o_p10>,n2>)
pop11x = dot(p_o_p11>,n1>)
pop11y = dot(p_o_p11>,n2>)
pop12x = dot(p_o_p12>,n1>)
pop12y = dot(p_o_p12>,n2>)
pop13x = dot(p_o_p13>,n1>)
pop13y = dot(p_o_p13>,n2>)
pop14x = dot(p_o_p14>,n1>)
pop14y = dot(p_o_p14>,n2>)
pop15x = dot(p_o_p15>,n1>)
pop15y = dot(p_o_p15>,n2>)
pop16x = dot(p_o_p16>,n1>)
pop16y = dot(p_o_p16>,n2>)
%
% position of com of system
p_o_cm> = cm(o)
pocmx = dot(p_o_cm>,n1>)
pocmy = dot(p_o_cm>,n2>)
%
% ------------------------------------------------------------------------------
% kinematical differential equations
q1' = u1
q2' = u2
q3' = u3
q4' = u4
q5' = u5
q6' = u6
q7' = u7
%
% ------------------------------------------------------------------------------
% angular velocities and accelerations
w_hat_n> = u3*n3>
w_rth_hat> = -rh'*n3> + u8*n3>
w_lth_hat> = -u4*n3>
w_rsh_rth> = rk'*n3> + u9*n3>
w_lsh_lth> = u5*n3>
w_rrf_rsh> = -ra'*n3> + u10*n3>
w_lrf_lsh> = -u6*n3>
w_rff_rrf> = -rmtp'*n3>
w_lff_lrf> = -u7*n3>
w_rua_hat> = -rs'*n3> + u11*n3>
w_lua_hat> = -ls'*n3> + u12*n3>
w_rla_rua> = re'*n3> + u13*n3>
w_lla_lua> = le'*n3> + u14*n3>
w_rrff_rrf> = 0>
w_lrff_lrf> = 0>

alf_hat_n> = dt(w_hat_n>,n)
alf_rth_n> = dt(w_rth_n>,n)
alf_lth_n> = dt(w_lth_n>,n)
alf_rsh_n> = dt(w_rsh_n>,n)
alf_lsh_n> = dt(w_lsh_n>,n)
alf_rrf_n> = dt(w_rrf_n>,n)
alf_lrf_n> = dt(w_lrf_n>,n)
alf_rff_n> = dt(w_rff_n>,n)
alf_lff_n> = dt(w_lff_n>,n)
alf_rua_n> = dt(w_rua_n>,n)
alf_lua_n> = dt(w_lua_n>,n)
alf_rla_n> = dt(w_rla_n>,n)
alf_lla_n> = dt(w_lla_n>,n)
alf_rrff_rrf> = 0>
alf_lrff_lrf> = 0>
%
% -----------------------------------------------------------------------------
% linear velocities and accelerations
v_o_n> = 0>
v_p1_n> = dt(p_o_p1>,n)
v2pts(n,lff,p1,lffo)
v2pts(n,lff,p1,p2)
v2pts(n,lrf,p2,lrfo)
v2pts(n,lrf,p2,p4)
v2pts(n,lsh,p4,lsho)
v2pts(n,lsh,p4,p5)
v2pts(n,lth,p5,ltho)
v2pts(n,lth,p5,p6)
v2pts(n,rth,p6,rtho)
v2pts(n,rth,p6,p7)
v2pts(n,rsh,p7,rsho)
v2pts(n,rsh,p7,p8)
v2pts(n,rrf,p8,rrfo)
v2pts(n,rrf,p8,p10)
v2pts(n,rff,p10,rffo)
v2pts(n,rff,p10,p11)
v2pts(n,hat,p6,hato)
v2pts(n,hat,p6,p12)
v2pts(n,rua,p12,ruao)
v2pts(n,rua,p12,p13)
v2pts(n,rla,p13,rlao)
v2pts(n,rla,p13,p14)
v2pts(n,lua,p12,luao)
v2pts(n,lua,p12,p15)
v2pts(n,lla,p15,llao)
v2pts(n,lla,p15,p16)
v_cm_n> = dt(p_o_cm>,n)
%
vop1x = dot(v_p1_n>,n1>)
vop1y = dot(v_p1_n>,n2>)
vop2x = dot(v_p2_n>,n1>)
vop2y = dot(v_p2_n>,n2>)
vop10x = dot(v_p10_n>,n1>)
vop10y = dot(v_p10_n>,n2>)
vop11x = dot(v_p11_n>,n1>)
vop11y = dot(v_p11_n>,n2>)
vocmx = dot(v_cm_n>,n1>)
vocmy = dot(v_cm_n>,n2>)
%
a_o_n> = 0>
a_p1_n> = dt(v_p1_n>,n)
a2pts(n,lff,p1,lffo)
a2pts(n,lff,p1,p2)
a2pts(n,lrf,p2,lrfo)
a2pts(n,lrf,p2,p4)
a2pts(n,lsh,p4,lsho)
a2pts(n,lsh,p4,p5)
a2pts(n,lth,p5,ltho)
a2pts(n,lth,p5,p6)
a2pts(n,rth,p6,rtho)
a2pts(n,rth,p6,p7)
a2pts(n,rsh,p7,rsho)
a2pts(n,rsh,p7,p8)
a2pts(n,rrf,p8,rrfo)
a2pts(n,rrf,p8,p10)
a2pts(n,rff,p10,rffo)
a2pts(n,rff,p10,p11)
a2pts(n,hat,p6,hato)
a2pts(n,hat,p6,p12)
a2pts(n,rua,p12,ruao)
a2pts(n,rua,p12,p13)
a2pts(n,rla,p13,rlao)
a2pts(n,rla,p13,p14)
a2pts(n,lua,p12,luao)
a2pts(n,lua,p12,p15)
a2pts(n,lla,p15,llao)
a2pts(n,lla,p15,p16)
%
% ------------------------------------------------------------------------------
% joint kinematics
lh = q4
lk = q5
la = q6
lmtp = q7
lh' = u4
lk' = u5
la' = u6
lmtp' = u7
lh'' = u4'
lk'' = u5'
la'' = u6'
lmtp'' = u7'
% ------------------------------------------------------------------------------
% forces and torques
% mtp torques
rmtq = mtpk*(pi-rmtp) - mtpb*rmtp'
lmtq = mtpk*(pi-q7) - mtpb*u7
lhtq = he*hf*t^3
lktq = ke*kf*t^3
latq = ae*af*t^3
%
% reaction forces
% real force
dlx1 = pop1x - toexi
dlx2 = pop2x - mtpxi
ry1 = -k3*pop1y-k4*vop1y*abs(pop1y)         % toe
rx1 = (-k1*dlx1-k2*vop1x)*ry1
ry2 = -k7*pop2y-k8*vop2y*abs(pop2y)         % mtp
rx2 = (-k5*dlx2-k6*vop2x)*ry2
% virtual force
vry1 = T^3         % toe
vrx1 = T^3
vry2 = T^3         % mtp
vrx2 = T^3

vrx = vrx1+vrx2
vry = vry1+vry2
rx = rx1+rx2
ry = ry1+ry2
%
% apply forces/torques
gravity(g*n2>)
force(p1,rx1*n1>+ry1*n2>)
force(p2,rx2*n1>+ry2*n2>)
force(p11,vrx1*n1>+vry1*n2>)
force(p10,vrx2*n1>+vry2*n2>)
torque(rth/hat, rhtq*n3>)
torque(lth/hat, lhtq*n3>)
torque(rth/rsh, rktq*n3>)
torque(lth/lsh, lktq*n3>)
torque(rrf/rsh, ratq*n3>)
torque(lrf/lsh, latq*n3>)
torque(rff/rrf, rmtq*n3>)
torque(lff/lrf, lmtq*n3>)
torque(rua/hat, rstq*n3>)
torque(lua/hat, lstq*n3>)
torque(rla/rua, retq*n3>)
torque(lla/lua, letq*n3>)
% ------------------------------------------------------------------------------
% energy and momentum of system
kecm = ke()
h> = momentum(angular,cm)
hz = dot(h>,n3>)
p> = momentum(linear)
px = dot(p>,n1>)
py = dot(p>,n2>)
%
% ------------------------------------------------------------------------------
% equations of motion
auxiliary[1] = u8
auxiliary[2] = u9
auxiliary[3] = u10
auxiliary[4] = u11
auxiliary[5] = u12
auxiliary[6] = u13
auxiliary[7] = u14

constrain(auxiliary[u8,u9,u10,u11,u12,u13,u14])
zee_not = [rhtq,rktq,ratq,rstq,lstq,retq,letq]
zero = fr() + frstar()
kane(rhtq,rktq,ratq,rstq,lstq,retq,letq)
%
% ------------------------------------------------------------------------------
% input/output
input tinitial=0.0,tfinal=0.2,integstp=0.001
input abserr=1.0e-08,relerr=1.0e-07
input g=-9.81
input lffo=0.050,lff=0.085,lrffo=0.121,lrfo=0.076,lrff=0.222,lrf=0.139,lsho=0.261,lsh=0.453,ltho=0.258,lth=0.447,lhat=0.600
input iff=0.00015,irf=0.00301,ish=0.0808,ith=0.21645,ihat=4.600
input mff=0.244,mrf=1.170,msh=5.375,mth=12.79,mhat=51.95
input footang=19.58
input q1=0.0,q2=0.0,q3=81.451, u1=9.67406,u2=-0.72030,u3=-24.9253
%
output t,pop1x,pop1y,pop2x,pop2y,pop3x,pop3y,pop4x,pop4y,pop5x,pop5y,pop6x,pop6y,pop7x,pop7y,pop8x,pop8y,pop9x,pop9y,pop10x,pop10y,pop11x,pop11y,pop12x,pop12y,pop13x,pop13y,pop14x,pop14y,pop15x,pop15y,pop16x,pop16y,pocmx,pocmy,vocmx,vocmy
output t,q1,q2,q3,q4,q5,q6,q7,u1,u2,u3,u4,u5,u6,u7
output t,vrx,vry,rx,ry,vrx1,vry1,vrx2,vry2,rx1,rx2,ry1,ry2
output t,rhtq,lhtq,rktq,lktq,ratq,latq,rmtq,lmtq,rstq,lstq,retq,letq
output t,rh,lh,rk,lk,ra,la,rmtp,lmtp,rs,ls,re,le,rh',lh',rk',lk',ra',la',rmtp',lmtp',rs',ls',re',le',rh'',lh'',rk'',lk'',ra'',la'',rmtp'',lmtp'',rs'',ls'',re'',le''
output t,kecm,hz,px,py
%
%--------------------------------------------------------------
code dynamics() model/13seg_swing_vf/model.f, nosubs
