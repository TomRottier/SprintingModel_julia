% angle driven model of sprinting
% two four segment legs and a combined hat segment
%
% tom rottier 2022
% ------------------------------------------------------------------------------
autoz on          
degrees off         % sometimes get problems with using pi if not specified
% physical declarations
newtonian n
bodies rff,rrf,rsh,rth,lff,lrf,lsh,lth,hat
frames rrff,lrff            % frame for rear foot
points o,p{13},cm,rrf{2}o,lrf{2}o
mass rff=mff,rrf=mrf,rsh=msh,rth=mth,lff=mff,lrf=mrf,lsh=msh,lth=mth,hat=mhat
inertia rff,0,0,iff
inertia rrf,0,0,irf
inertia rsh,0,0,ish
inertia rth,0,0,ith
inertia lff,0,0,iff    
inertia lrf,0,0,irf   
inertia lsh,0,0,ish
inertia lth,0,0,ith
inertia hat,0,0,ihat
% 
% mathematical declarations
variables q{3}'		        % global position (x,y) and orientation of HAT
variables u{9}'            % generalised speeds, u4-u9 to determine torques at joints
variables rrx{2},rry{2},lrx{2},lry{2}		% one spring under toe, one under mtp for both feet
variables kecm,pecm,te,hz,px,py
variables rhtq,lhtq,rktq,lktq,ratq,latq
constants lff,lrf,lsh,lth,lhat % length of segments
constants lffo,lrfo,lsho,ltho  % lengths from distal joint to CoM
constants lrff, lrffo          % lenghts for rear foot frame
constants k{8}		   % vertical and horizontal stiffness and damping
constants mtpk,mtpb    % rotational stiffness and damping for mtp joint 
constants g
constants footang      % angle of mtp-heel line relative to mtp-ajc line
constants rtoexi,rmtpxi,ltoexi,lmtpxi % initial x positions for springs
specified rh'',lh'',rk'',lk'',ra'',la'',rmtp'',lmtp'' % specified joint angles
specified hato''         % distance from hip to hat com
%
%
% ------------------------------------------------------------------------------
% geometry
simprot(n,hat,3,q3)         % global orientation/trunk angle
simprot(hat,rth,3,rh)
simprot(hat,lth,3,lh)
simprot(rth,rsh,3,rk)
simprot(lth,lsh,3,lk)
simprot(rsh,rrf,3,ra)
simprot(lsh,lrf,3,la)
simprot(rrf,rff,3,rmtp)
simprot(lrf,lff,3,lmtp)

simprot(rrf,rrff,3,footang)    % rear foot frame rotated about rear foot
simprot(lrf,lrff,3,footang)
%
% ------------------------------------------------------------------------------
% position vectors
p_o_p1>   = q1*n1> + q2*n2>		            % origin to toes
p_p6_hato> = hato*hat1>
p_p6_p12> = lhat*hat1>

% right leg
p_p1_rffo> = -lffo*rff1>
p_p1_p2> = -lff*rff1>
p_p2_rrf1o> = -lrfo*rrf1>   % mtp to position along mtp-ajc line
p_p2_rrf2o> = -lrffo*rrff1> % mtp to position along mtp-heel line
p_p2_rrfo> = (p_p2_rrf1o> + p_p2_rrf2o>) / 2 % com of rear foot as average between two points
p_p2_p3> = -lrff*rrff1>     % mtp to heel
p_p2_p4> = -lrf*rrf1>       % mtp to ajc
p_p4_rsho> = -lsho*rsh1>
p_p4_p5> = -lsh*rsh1>
p_p5_rtho> = -ltho*rth1>
p_p5_p6> = -lth*rth1>

% left leg
p_p7_ltho> = -ltho*lth1>
p_p7_p6> = -lth*lth1>
p_p8_lsho> = -lsho*lsh1>
p_p8_p7> = -lsh*lsh1>
p_p10_lrf1o> = -lrfo*lrf1>
p_p10_lrf2o> = -lrffo*lrff1>
p_p10_lrfo> = (p_p10_lrf1o> + p_p10_lrf2o>) / 2
p_p10_p9> = -lrff*lrff1>
p_p10_p8> = -lrf*lrf1>
p_p11_lffo> = -lffo*lff1>
p_p11_p10> = -lff*lff1>

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
pohatox = dot(p_o_hato>,n1>)
pohatoy = dot(p_o_hato>,n2>)
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
%
% ------------------------------------------------------------------------------
% angular velocities and accelerations
w_hat_n> = u3*n3>
w_rth_hat> = rh'*n3> + u4*n3>
w_lth_hat> = lh'*n3> + u5*n3>
w_rsh_rth> = rk'*n3> + u6*n3>
w_lsh_lth> = lk'*n3> + u7*n3>
w_rrf_rsh> = ra'*n3> + u8*n3>
w_lrf_lsh> = la'*n3> + u9*n3>
w_rff_rrf> = rmtp'*n3>
w_lff_lrf> = lmtp'*n3>
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
alf_rrff_rrf> = 0>
alf_lrff_lrf> = 0>
%
% -----------------------------------------------------------------------------
% linear velocities and accelerations
v_o_n> = 0>
v_p1_n> = dt(p_o_p1>,n)
v2pts(n,rff,p1,rffo)
v2pts(n,rff,p1,p2)
v2pts(n,rrf,p2,rrfo)
v2pts(n,rff,p2,p4)
v2pts(n,rsh,p4,rsho)
v2pts(n,rsh,p4,p5)
v2pts(n,rth,p5,rtho)
v2pts(n,rth,p5,p6)
v2pts(n,lth,p6,ltho)
v2pts(n,lth,p6,p7)
v2pts(n,lsh,p7,lsho)
v2pts(n,lsh,p7,p8)
v2pts(n,lrf,p8,lrfo)
v2pts(n,lrf,p8,p10)
v2pts(n,lff,p10,lffo)
v2pts(n,lff,p10,p11)
v_hato_n> = dt(p_o_hato>,n)
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
a2pts(n,rff,p1,rffo)
a2pts(n,rff,p1,p2)
a2pts(n,rrf,p2,rrfo)
a2pts(n,rff,p2,p4)
a2pts(n,rsh,p4,rsho)
a2pts(n,rsh,p4,p5)
a2pts(n,rth,p5,rtho)
a2pts(n,rth,p5,p6)
a2pts(n,lth,p6,ltho)
a2pts(n,lth,p6,p7)
a2pts(n,lsh,p7,lsho)
a2pts(n,lsh,p7,p8)
a2pts(n,lrf,p8,lrfo)
a2pts(n,lrf,p8,p10)
a2pts(n,lff,p10,lffo)
a2pts(n,lff,p10,p11)
a_hato_n> = dt(v_hato_n>,n)
%
% ------------------------------------------------------------------------------
% forces and torques
% mtp torques
rmtq = mtpk*(pi-rmtp) - mtpb*rmtp'
lmtq = mtpk*(pi-lmtp) - mtpb*lmtp'
%
% reaction forces
% right foot
drx1 = pop1x - rtoexi
drx2 = pop2x - rmtpxi
rry1 = -k3*pop1y-k4*vop1y*abs(pop1y)         % toe
rrx1 = (-k1*drx1-k2*vop1x)*rry1
rry2 = -k7*pop2y-k8*vop2y*abs(pop2y)         % mtp
rrx2 = (-k5*drx2-k6*vop2x)*rry2
% left foot
dlx1 = pop11x - ltoexi
dlx2 = pop10x - lmtpxi
lry1 = -k3*pop11y-k4*vop11y*abs(pop11y)         % toe
lrx1 = (-k1*dlx1-k2*vop11x)*lry1
lry2 = -k7*pop10y-k8*vop10y*abs(pop10y)         % mtp
lrx2 = (-k5*dlx2-k6*vop10x)*lry2

rrx = rrx1+rrx2
rry = rry1+rry2
lrx = lrx1+lrx2
lry = lry1+lry2
%
% apply forces/torques
gravity(g*n2>)
force(p1,rrx1*n1>+rry1*n2>)
force(p2,rrx2*n1>+rry2*n2>)
force(p11,lrx1*n1>+lry1*n2>)
force(p10,lrx2*n1>+lry2*n2>)
torque(hat/rth, rhtq*n3>)
torque(hat/lth, lhtq*n3>)
torque(rth/rsh, rktq*n3>)
torque(lth/lsh, lktq*n3>)
torque(rsh/rrf, ratq*n3>)
torque(lsh/lrf, latq*n3>)
torque(rrf/rff, rmtq*n3>)
torque(lrf/lff, lmtq*n3>)
% ------------------------------------------------------------------------------
% energy and momentum of system
kecm = ke()
pecm = -1*mass()*g*pocmy + 0.5*k1*pop1x^2 + 0.5*k3*pop1y^2
te = kecm + pecm
h> = momentum(angular,cm)
hz = dot(h>,n3>)
p> = momentum(linear)
px = dot(p>,n1>)
py = dot(p>,n2>)
%
% ------------------------------------------------------------------------------
% equations of motion
auxiliary[1] = u4
auxiliary[2] = u5
auxiliary[3] = u6
auxiliary[4] = u7
auxiliary[5] = u8
auxiliary[6] = u9

constrain(auxiliary[u4,u5,u6,u7,u8,u9])
zee_not = [rhtq,lhtq,rktq,lktq,ratq,latq]
zero = fr() + frstar()
kane(rhtq,lhtq,rktq,lktq,ratq,latq)
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
output t,pop1x,pop1y,pop2x,pop2y,pop3x,pop3y,pop4x,pop4y,pop5x,pop5y,pop6x,pop6y,pop7x,pop7y,pop8x,pop8y,pop9x,pop9y,pop10x,pop10y,pop11x,pop11y,pop12x,pop12y,pohatox,pohatoy,pocmx,pocmy,vocmx,vocmy
output t,q1,q2,q3,u1,u2,u3
output t,rrx,rry,lrx,lry,rrx1,rry1,rrx2,rry2,lrx1,lrx2,lry1,lry2
output t,rhtq,lhtq,rktq,lktq,ratq,latq,rmtq,lmtq
output t,rh,lh,rk,lk,ra,la,rmtp,lmtp,rh',lh',rk',lk',ra',la',rmtp',lmtp',rh'',lh'',rk'',lk'',ra'',la'',rmtp'',lmtp''
output t,kecm,pecm,te,hz,px,py
%
% units
units t=s,tinitial=s,tfinal=s
units lffo=m,lff=m,lrffo=m,lrfo=m,lrff=m,lrf=m,lsho=m,lsh=m,ltho=m,lth=m,lhat=m
units pop1x=m,pop1y=m,pop2x=m,pop2y=m,pop3x=m,pop3y=m,pop4x=m,pop4y=m,pop5x=m,pop5y=m,pop6x=m,pop6y=m,pop7x=m,pop7y=m,pop8x=m,pop8y=m,pop9x=m,pop9y=m,pop10x=m,pop10y=m,pop11x=m,pop11y=m,pohatox=m,pohatoy=m
units pocmx=m,pocmy=m,vocmx=m/s,vocmy=m/s
units q1=m,q2=m,q3=deg,u1=m/s,u2=m/s,u3=deg/s
units kecm=j,pecm=j,te=j,hz=kg.m^2/s,px=kg.m/s,py=kg.m/s
units mff=kg,mrf=kg,msh=kg,mth=kg,mhat=kg
units iff=kg.m^2,irf=kg.m^2,ish=kg.m^2,ith=kg.m^2,ihat=kg.m^2
units g=m/s^2,footang=deg
units k1=n/m,k2=n/m/s^2,k3=n/m,k4=n/m/s^2,k5=n/m,k6=n/m/s^2,k7=n/m,k8=n/m/s^2
units mtpk=n/m,mtpb=n/m/s^2
%--------------------------------------------------------------
code dynamics() model/angle_driven/model_angle.f, nosubs
