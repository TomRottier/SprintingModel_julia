% Model used to determine the interplay between swing leg motion, touchdown conditions
% and maximum running speed
%
% Segments: 
%   - HAT with varying CoM position from hip joint (F) 
%   - Stance leg thigh (D), shank (C), rear foot (B), toes (A)
%   - Swing leg thigh (E), shank (F), rear foot (H) and toes (I)
%
% Torque-driven stance leg and angle-driven swing leg
%
% EA is the swing hip angle, FA swing knee angle etc
%
%   Tom Rottier 2020
% ------------------------------------------------------------------------------
DEGREES OFF         % Sometimes get problems with using PI if not specified
AUTOZ ON          % May speed up simulation?
% Physical declarations
NEWTONIAN N
BODIES A,B,C,D,E,F,G,H,I
FRAMES Z,Y            % Frame for rear foot
POINTS O,P{12},CM,CMSTANCE,CMSWING,BO1,BO2,CO1,CO2
% 
% Mathematical declarations
MASS A=MA, B=MB, C=MC, D=MD, E=ME, F=MF, G=MG, H=MH, I=MI
MT = MA+MB+MC+MD+ME+MF+MG
INERTIA A,0,0,INA
INERTIA B,0,0,INB
INERTIA C,0,0,INC
INERTIA D,0,0,IND
INERTIA E,0,0,INE    
INERTIA F,0,0,INF   
INERTIA G,0,0,ING
INERTIA H,0,0,INH
INERTIA I,0,0,INI
VARIABLES Q{7}'		        % Generalised coordinates: 2 global positions, 1 global HAT angle, 4 joint angles
VARIABLES U{11}'             % Generalised speeds, U7,U8 auxiliary speeds for swing leg torques
VARIABLES RX{2},RY{2}		% One spring under toe, one under MTP
VARIABLES VRX{2},VRY{2}
VARIABLES RX,RY,GRF,COP
VARIABLES KECM,PECM,TE,HZ,PX,PY
VARIABLES HANG,KANG,AANG,MANG,HANGVEL,KANGVEL,AANGVEL,MANGVEL,SHANG,SKANG,SHANGVEL,SKANGVEL
VARIABLES HETOR,HFTOR,KETOR,KFTOR,AETOR,AFTOR,METOR,MFTOR
VARIABLES HTOR,KTOR,ATOR,MTOR,SHTOR,SKTOR,SATOR,SMTOR
CONSTANTS L{12}		   % 2 lengths per segment plus extra for rear foot
CONSTANTS K{8}		   % Vertical and horizontal stiffness and damping
CONSTANTS MTPK,MTPB    % Rotational stiffness and damping for MTP joint 
CONSTANTS G
CONSTANTS FOOTANG      % Angle of MTP-HEEL line relative to MTP-AJC line
CONSTANTS POP1XI,POP2XI
CONSTANTS HE,HF,KE,KF,AE,AF % Parameters of torque generators
SPECIFIED EA'',FA'',HA'',IA''    % Swing leg specified angles
SPECIFIED GS''         % Distance from hip to HAT CoM
%
%
% ------------------------------------------------------------------------------
% Geometry relating unit vectors
SIMPROT(N,G,3,Q3)         % Global orientation/trunk angle
SIMPROT(A,B,3,Q4)         % Rear foot about toes
SIMPROT(B,C,3,Q5)         % Shank about rear foot
SIMPROT(B,Z,3,FOOTANG)    % MTP-HEEL line about MTP-AJC line
SIMPROT(C,D,3,Q6)         % Thigh about shank
SIMPROT(D,G,3,Q7)         % HAT about thigh
SIMPROT(G,E,3,2*PI-EA)    % Swing thigh about HAT
SIMPROT(E,F,3,FA-PI)      % Swing shank about swing thigh
SIMPROT(F,H,3,PI-HA)      % Swing rear foot about swing shank
SIMPROT(H,I,3,PI-IA)      % Swing toes about swing rear foot   
SIMPROT(H,Y,3,FOOTANG)    % Swing MTP-HEEL line about MTP-AJC line
%
% ------------------------------------------------------------------------------
% Position vectors
% global position
P_O_P1>   = Q1*N1> + Q2*N2>		            % Origin to toes

% stance leg
P_P1_AO>  = -L1*A1>			                % Toes to toe CoM
P_P1_P2>  = -L2*A1>			                % Toes to MTP
P_P2_BO1> = L3*Z1>			                % MTP to CoM position along MTP-HEEL line
P_P2_BO2> = L4*B1>			                % MTP to CoM position along MTP-AJC line
P_P2_BO>  = (P_P2_BO1> + P_P2_BO2>) / 2     % MTP to rear foot CoM (average of the two)
P_P2_P3>  = L5*Z1>                          % MTP to heel
P_P2_P4>  = L6*B1>			                % MTP to AJC
P_P4_CO>  = L7*C1>			                % AJC to shank CoM
P_P4_P5>  = L8*C1>			                % AJC to KJC
P_P5_DO>  = L9*D1>                          % KJC to thigh CoM
P_P5_P6>  = L10*D1>                         % KJC to HJC

% swing leg
P_P6_EO>  = (L10-L9)*E1>                    % HJC to thigh CoM - prox. to dist. length
P_P6_P7>  = L10*E1>                         % HJC to KJC
P_P7_FO>  = (L8-L7)*F1>                     % KJC to shank CoM - prox. to dist. length
P_P7_P8>  = L8*F1>                          % KJC to AJC
P_P8_CO1> = (L6-L4)*H1>                     % AJC to CoM position along AJC-MTP line
P_P8_P10> = L6*H1>                          % AJC to MTP
P_P10_P9> = -L5*Y1>                         % MTP to heel
P_P9_CO2> = L3*Y1>                         % MTP to CoM position along MTP-HEEL line
P_P8_HO>  = (P_P8_CO1> + P_P8_CO2>) / 2      % AJC to rear foot CoM
P_P10_IO>  = (L2-L1)*I1>                     % MTP to toe CoM
P_P10_P11> = L2*I1>                          % MTP to toe

% hat
P_P6_GO>  = GS*G1>                          % HJC to HAT CoM
P_P6_P12>  = L11*G1>                         % HJC to APEX - does not affect model, just plot
% 
% Position of points relative to origin
P_O_AO> = P_O_P1> + P_P1_AO>
P_O_P2> = P_O_P1> + P_P1_P2>
P_O_BO> = P_O_P2> + P_P2_BO>
P_O_P3> = P_O_P2> + P_P2_P3>
P_O_P4> = P_O_P2> + P_P2_P4>
P_O_CO> = P_O_P4> + P_P4_CO>
P_O_P5> = P_O_P4> + P_P4_P5>
P_O_DO> = P_O_P5> + P_P5_DO>
P_O_P6> = P_O_P5> + P_P5_P6>
P_O_EO> = P_O_P6> + P_P6_EO>
P_O_P7> = P_O_P6> + P_P6_P7>
P_O_FO> = P_O_P7> + P_P7_FO>
P_O_P8> = P_O_P7> + P_P7_P8>
P_O_GO> = P_O_P6> + P_P6_GO>
P_O_P9> = P_O_P6> + P_P6_P9>
%
% XY of points
POP1X = DOT(P_O_P1>,N1>)
POP1Y = DOT(P_O_P1>,N2>)
POP2X = DOT(P_O_P2>,N1>)
POP2Y = DOT(P_O_P2>,N2>)
POP3X = DOT(P_O_P3>,N1>)
POP3Y = DOT(P_O_P3>,N2>)
POP4X = DOT(P_O_P4>,N1>)
POP4Y = DOT(P_O_P4>,N2>)
POP5X = DOT(P_O_P5>,N1>)
POP5Y = DOT(P_O_P5>,N2>)
POP6X = DOT(P_O_P6>,N1>)
POP6Y = DOT(P_O_P6>,N2>)
POP7X = DOT(P_O_P7>,N1>)
POP7Y = DOT(P_O_P7>,N2>)
POP8X = DOT(P_O_P8>,N1>)
POP8Y = DOT(P_O_P8>,N2>)
POP9X = DOT(P_O_P9>,N1>)
POP9Y = DOT(P_O_P9>,N2>)
POGOX = DOT(P_O_GO>,N1>)
POGOY = DOT(P_O_GO>,N2>)
POHOX = DOT(P_O_HO>,N1>)
POHOY = DOT(P_O_HO>,N2>)
POP10X = DOT(P_O_P10>,N1>)
POP10Y = DOT(P_O_P10>,N2>)
POIOX = DOT(P_O_IO>,N1>)
POIOY = DOT(P_O_IO>,N2>)
POP11X = DOT(P_O_P11>,N1>)
POP11Y = DOT(P_O_P11>,N2>)
POP12X = DOT(P_O_P12>,N1>)
POP12Y = DOT(P_O_P12>,N2>)
%
% Position of CoM of system
P_O_CM> = CM(O)
POCMX = DOT(P_O_CM>,N1>)
POCMY = DOT(P_O_CM>,N2>)
% Position of CoM of stance and swing leg
P_O_CMSTANCE> = CM(O,A,B,C,D)
P_O_CMSWING> = CM(O,E,F,H,I)
POCMSTANCEX = DOT(P_O_CMSTANCE>,N1>)
POCMSTANCEY = DOT(P_O_CMSTANCE>,N2>)
POCMSWINGX  = DOT(P_O_CMSWING>,N1>)
POCMSWINGY  = DOT(P_O_CMSWING>,N2>)
%
% ------------------------------------------------------------------------------
% Kinematical differential equations
Q1' = U1
Q2' = U2
Q3' = U3
Q4' = U4
Q5' = U5
Q6' = U6
Q7' = U7
%
% ------------------------------------------------------------------------------
% Angular velocities and accelerations
W_G_N> = U3*N3>
W_B_A> = U4*N3>
W_C_B> = U5*N3>
W_D_C> = U6*N3>
W_G_D> = U7*N3>
W_E_G> = -EA'*N3> + U8*N3>
W_F_E> = FA'*N3> + U9*N3>
W_H_F> = -HA'*N3> + U10*N3>
W_I_H> = -IA'*N3> + U11*N3>
W_Z_B> = 0>                     % Angular velocity of MTP-Heel line relative to MTP-AJC line
W_Y_H> = 0>
ALF_A_N> = DT(W_A_N>,N)
ALF_B_N> = DT(W_B_N>,N)
ALF_C_N> = DT(W_C_N>,N)
ALF_D_N> = DT(W_D_N>,N)
ALF_E_N> = DT(W_E_N>,N)
ALF_F_N> = DT(W_F_N>,N)
ALF_G_N> = DT(W_G_N>,N)
ALF_H_N> = DT(W_H_N>,N)
ALF_I_N> = DT(W_I_N>,N)
ALF_Z_B> = 0>
ALF_Y_H> = 0>
%
% ------------------------------------------------------------------------------
% Linear velocities and accelerations
V_O_N> = 0>
V_P1_N> = DT(P_O_P1>,N)
V2PTS(N,A,P1,AO)
V2PTS(N,A,P1,P2)
V2PTS(N,B,P2,BO)
V2PTS(N,Z,P2,P3)
V2PTS(N,B,P2,P4)
V2PTS(N,C,P4,CO)
V2PTS(N,C,P4,P5)
V2PTS(N,D,P5,DO)
V2PTS(N,D,P5,P6)
V2PTS(N,E,P6,EO)
V2PTS(N,E,P6,P7)
V2PTS(N,F,P7,FO)
V2PTS(N,F,P7,P8)
V2PTS(N,H,P8,HO)
V2PTS(N,Y,P8,P9)
V2PTS(N,H,P8,P10)
V2PTS(N,I,P10,IO)
V2PTS(N,I,P10,P11)
V_GO_N> = DT(P_O_GO>,N)
V2PTS(N,G,P6,P12)
V_CM_N> = DT(P_O_CM>,N)
V_CMSTANCE_N> = DT(P_O_CMSTANCE>,N)
V_CMSWING_N> = DT(P_O_CMSWING>,N)
%
VOP1X = DOT(V_P1_N>,N1>)
VOP1Y = DOT(V_P1_N>,N2>)
VOP2X = DOT(V_P2_N>,N1>)
VOP2Y = DOT(V_P2_N>,N2>)
VOP3X = DOT(V_P3_N>,N1>)
VOP3Y = DOT(V_P3_N>,N2>)
VOP4X = DOT(V_P4_N>,N1>)
VOP4Y = DOT(V_P4_N>,N2>)
VOP5X = DOT(V_P5_N>,N1>)
VOP5Y = DOT(V_P5_N>,N2>)
VOP6X = DOT(V_P6_N>,N1>)
VOP6Y = DOT(V_P6_N>,N2>)
VOP7X = DOT(V_P7_N>,N1>)
VOP7Y = DOT(V_P7_N>,N2>)
VOP8X = DOT(V_P8_N>,N1>)
VOP8Y = DOT(V_P8_N>,N2>)
VOP9X = DOT(V_P9_N>,N1>)
VOP9Y = DOT(V_P9_N>,N2>)
VOP10X = DOT(V_P10_N>,N1>)
VOP10Y = DOT(V_P10_N>,N2>)
VOP11X = DOT(V_P11_N>,N1>)
VOP11Y = DOT(V_P11_N>,N2>)
VOCMX = DOT(V_CM_N>,N1>)
VOCMY = DOT(V_CM_N>,N2>)
VOCMSTANCEX = DOT(V_CMSTANCE_N>,N1>)
VOCMSTANCEY = DOT(V_CMSTANCE_N>,N2>)
VOCMSWINGX = DOT(V_CMSWING_N>,N1>)
VOCMSWINGY = DOT(V_CMSWING_N>,N2>)
%
A_O_N> = 0>
A_P1_N> = DT(V_P1_N>,N)
A2PTS(N,A,P1,AO)
A2PTS(N,A,P1,P2)
A2PTS(N,B,P2,BO)
A2PTS(N,B,P2,P3)
A2PTS(N,B,P2,P4)
A2PTS(N,C,P4,CO)
A2PTS(N,C,P4,P5)
A2PTS(N,D,P5,DO)
A2PTS(N,D,P5,P6)
A2PTS(N,E,P6,EO)
A2PTS(N,E,P6,P7)
A2PTS(N,F,P7,FO)
A2PTS(N,F,P7,P8)
A2PTS(N,H,P8,HO)
A2PTS(N,H,P8,P9)
A2PTS(N,H,P8,P10)
A2PTS(N,I,P10,IO)
A2PTS(N,I,P10,P11)
A_GO_N> = DT(V_GO_N>,N)
A2PTS(N,G,P6,P12)
%
% ------------------------------------------------------------------------------
% Joint angles and angular velocities
MANG = Q4
AANG = PI+Q5
KANG = PI-Q6
HANG = PI+Q7
SHANG = EA
SKANG = FA
SAANG = HA
SMANG = IA
MANGVEL = U4
AANGVEL = U5
KANGVEL = -U6
HANGVEL = U7
SHANGVEL = EA'
SKANGVEL = FA'
SAANGVEL = HA'
SMANGVEL = IA'
%
% ------------------------------------------------------------------------------
% Specified variables for muscle model
%EA   = 0
%EA'  = 0
%EA'' = 0
%FA   = 0
%FA'  = 0
%FA'' = 0
%GS   = 0
%GS'  = 0
%GS'' = 0
%
% ------------------------------------------------------------------------------
% Generalised forces
% Calculate joint torques in fortran code
HETOR = HE*T
HFTOR = HF*T
KETOR = KE*T
KFTOR = KF*T
AETOR = AE*T
AFTOR = AF*T
%
HTOR = HETOR-HFTOR      % All extension torques are positive
KTOR = KETOR-KFTOR
ATOR = AETOR-AFTOR
MTOR = MTPK*(PI-MANG) - MTPB*MANGVEL
%
% Reaction forces
DP1X = POP1X-POP1XI
DP2X = POP2X-POP2XI
RY1 = -K3*POP1Y-K4*VOP1Y*ABS(POP1Y)         % Toe
RX1 = (-K1*DP1X-K2*VOP1X)*RY1
RY2 = -K7*POP2Y-K8*VOP2Y*ABS(POP2Y)         % MTP
RX2 = (-K5*DP2X-K6*VOP2X)*RY2
RX = RX1+RX2
RY = RY1+RY2
GRF = (RX^2+RY^2)^0.5
COP = (RY1*POP1X+RY2*POP2X) / GRF
VRX1 = T
VRY1 = T
VRX2 = T
VRY2 = T
%
% Apply forces/torques
ZEE_NOT = [SHTOR,SKTOR,SATOR,SMTOR]
GRAVITY(G*N2>)
FORCE(P1,RX1*N1>+RY1*N2>)
FORCE(P2,RX2*N1>+RY2*N2>)
FORCE(P9,VRX1*N1>+VRY1*N2>)
FORCE(P11,VRX2*N2>+VRY2*N2>)
TORQUE(A/B, MTOR*N3>)
TORQUE(B/C, ATOR*N3>)
TORQUE(D/C, KTOR*N3>)
TORQUE(D/G, HTOR*N3>)
TORQUE(E/G, SHTOR*N3>)
TORQUE(E/F, SKTOR*N3>)
TORQUE(F/H, SATOR*N3>)
TORQUE(H/I, SMTOR*N3>)
% ------------------------------------------------------------------------------
% Energy and momentum of system
KECM = KE()
PECM = -1*(MT)*G*POCMY + 0.5*K1*POP1X^2 + 0.5*K3*POP1Y^2
TE = KECM + PECM
H> = MOMENTUM(ANGULAR,CM)
HZ = DOT(H>,N3>)
P> = MOMENTUM(LINEAR)
PX = DOT(P>,N1>)
PY = DOT(P>,N2>)
PSWINGX = DOT(MOMENTUM(LINEAR,E,F),N1>)
PSWINGY = DOT(MOMENTUM(LINEAR,E,F),N2>)
PSTANCEX = DOT(MOMENTUM(LINEAR,A,B,C,D),N1>)
PSTANCEY = DOT(MOMENTUM(LINEAR,A,B,C,D),N2>)
%
% ------------------------------------------------------------------------------
% Equations of motion
AUXILIARY[1] = U8
AUXILIARY[2] = U9
AUXILIARY[3] = U10
AUXILIARY[4] = U11
CONSTRAIN(AUXILIARY[U8,U9,U10,U11])
ZERO = FR() + FRSTAR()
KANE(SHTOR,SKTOR,SATOR,SMTOR)
%
% ------------------------------------------------------------------------------
% Input/Output
INPUT TINITIAL=0.0,TFINAL=0.2,INTEGSTP=0.001
INPUT ABSERR=1.0E-08,RELERR=1.0E-07
INPUT G=-9.81
INPUT L1=0.050,L2=0.085,L3=0.121,L4=0.076,L5=0.222,L6=0.139,L7=0.261,L8=0.453,L9=0.258,L10=0.447,L11=0.600
INPUT INA=0.00015,INB=0.00301,INC=0.0808,IND=0.21645,INE=0.21645,INF=0.0808,INH=0.00301,INI=0.00015,ING=4.600
INPUT MA=0.244,MB=1.170,MC=5.375,MD=12.79,ME=12.79,MF=5.375,MG=51.95,MH=1.170,MI=0.244
INPUT FOOTANG=19.58,Q3=81.451,Q4=143.563,Q5=120.502,Q6=157.074,Q7=144.110
INPUT U1=9.67406,U2=-0.72030,U3=-24.9253,U4=1064.10,U5=-650.361,U6=-160.134,U7=429.803
%
OUTPUT T,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,POP10X,POP10Y,POP11X,POP11Y,POP12X,POP12Y
OUTPUT T,POGOX,POGOY,POCMSTANCEX,POCMSTANCEY,POCMSWINGX,POCMSWINGY,POCMX,POCMY,VOCMX,VOCMY,PSTANCEX,PSTANCEY,PSWINGX,PSWINGY,VOCMSTANCEX,VOCMSTANCEY,VOCMSWINGX,VOCMSWINGY
OUTPUT T,Q1,Q2,Q3,Q4,Q5,Q6,Q7,U1,U2,U3,U4,U5,U6,U7
OUTPUT T,RX1,RY1,RX2,RY2,VRX1,VRY1,VRX2,VRY2,HTOR,KTOR,ATOR,MTOR,SHTOR,SKTOR,SATOR,SMTOR
OUTPUT T,Q3,HANG,KANG,AANG,MANG,SHANG,SKANG,SAANG,SMANG,U3,HANGVEL,KANGVEL,AANGVEL,MANGVEL,SHANGVEL,SKANGVEL,SAANGVEL,SMANGVEL
OUTPUT T,KECM,PECM,TE,HZ,PX,PY
%
% Units
UNITS T=S,TINITIAL=S,TFINAL=S
UNITS L1=M,L2=M,L3=M,L4=M,L5=M,L6=M,L7=M,L8=M,L9=M,L10=M,L11=M
UNITS POP1X=M,POP1Y=M,POP2X=M,POP2Y=M,POP3X=M,POP3Y=M,POP4X=M,POP4Y=M,POP5X=M,POP5Y=M,POP6X=M,POP6Y=M,POP7X=M,POP7Y=M,POP8X=M,POP8Y=M,POP9X=M,POP9Y=M,POP10X=M,POP10Y=M,POP11X=M,POP11Y=M,POGOX=M,POGOY=M
UNITS POCMSTANCEX=M,POCMSTANCEY=M,POCMSWINGX=M,POCMSWINGY=M,POCMX=M,POCMY=M,VOCMX=M/S,VOCMY=M/S,VOCMSTANCEX=M/S,VOCMSTANCEY=M/S,VOCMSWINGX=M/S,VOCMSWINGY=M/S
UNITS Q1=M,Q2=M,Q3=DEG,Q4=DEG,Q5=DEG,Q6=DEG,Q7=DEG,U1=M/S,U2=M/S,U3=DEG/S,U4=DEG/S,U5=DEG/S,U6=DEG/S,U7=DEG/S
UNITS RX=N,RY=N,HTOR=N/M,KTOR=N/M,ATOR=N/M,MTOR=N/M,SHTOR=N/M,SKTOR=N/M
UNITS RX1=N,RY1=N,RX2=N,RY2=N,GRF=N,COP=M
UNITS HANG=DEG,KANG=DEG,AANG=DEG,MANG=DEG,SHANG=DEG,SKANG=DEG,HANGVEL=DEG/S,KANGVEL=DEG/S,AANGVEL=DEG/S,MANGVEL=DEG/S,SHANGVEL=DEG/S,SKANGVEL=DEG/S
UNITS KECM=J,PECM=J,TE=J,HZ=KG.M^2/S,PX=KG.M/S,PY=KG.M/S
UNITS MA=KG,MB=KG,MC=KG,MD=KG,ME=KG,MF=KG,MG=KG
UNITS INA=KG.M^2,INB=KG.M^2,INC=KG.M^2,IND=KG.M^2,INE=KG.M^2,INF=KG.M^2,ING=KG.M^2,INH=KG.M^2,INI=KG.M^2
UNITS G=M/S^2,FOOTANG=DEG
UNITS K1=N/M,K2=N/M/S^2,K3=N/M,K4=N/M/S^2,K5=N/M,K6=N/M/S^2,K7=N/M,K8=N/M/S^2
UNITS MTPK=N/M,MTPB=N/M/S^2
%--------------------------------------------------------------
CODE DYNAMICS() model/7segSprint.f, NOSUBS
