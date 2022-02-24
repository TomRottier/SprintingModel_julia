C**   The name of this program is model/7segsprint.f
C**   Created by AUTOLEV 3.2 on Thu Feb 24 18:42:28 2022

      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          ILOOP, IPRINT, PRINTINT
      CHARACTER        MESSAGE(99)
      EXTERNAL         EQNS1
      DIMENSION        VAR(14)
      COMMON/CONSTNTS/ AE,AF,FOOTANG,G,HE,HF,INA,INB,INC,IND,INE,INF,ING
     &,INH,INI,K1,K2,K3,K4,K5,K6,K7,K8,KE,KF,L1,L10,L2,L3,L4,L5,L6,L7,L8
     &,L9,MA,MB,MC,MD,ME,MF,MG,MH,MI,MTPB,MTPK,POP1XI,POP2XI
      COMMON/SPECFIED/ EA,FA,GS,HA,IA,EAp,FAp,GSp,HAp,IAp,EApp,FApp,GSpp
     &,HApp,IApp
      COMMON/VARIBLES/ Q1,Q2,Q3,Q4,Q5,Q6,Q7,U1,U2,U3,U4,U5,U6,U7
      COMMON/ALGBRAIC/ AANG,AANGVEL,AETOR,AFTOR,ATOR,HANG,HANGVEL,HETOR,
     &HFTOR,HTOR,HZ,KANG,KANGVEL,KECM,KETOR,KFTOR,KTOR,MANG,MANGVEL,MTOR
     &,PECM,PX,PY,RX1,RX2,RY1,RY2,SATOR,SHANG,SHANGVEL,SHTOR,SKANG,SKANG
     &VEL,SKTOR,SMTOR,TE,U10,U11,U8,U9,VRX1,VRX2,VRY1,VRY2,Q1p,Q2p,Q3p,Q
     &4p,Q5p,Q6p,Q7p,U1p,U2p,U3p,U4p,U5p,U6p,U7p,DP1X,DP2X,MT,POCMSTANCE
     &X,POCMSTANCEY,POCMSWINGX,POCMSWINGY,POCMX,POCMY,POGOX,POGOY,POP10X
     &,POP10Y,POP11X,POP11Y,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,PO
     &P4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,PS
     &TANCEX,PSTANCEY,PSWINGX,PSWINGY,SAANG,SAANGVEL,SMANG,SMANGVEL,VOCM
     &STANCEX,VOCMSTANCEY,VOCMSWINGX,VOCMSWINGY,VOCMX,VOCMY,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(691),COEF(7,7),RHS(7)

C**   Open input and output files
      OPEN(UNIT=20, FILE='model/7segsprint.in', STATUS='OLD')
      OPEN(UNIT=21, FILE='model/7segsprint.1',  STATUS='UNKNOWN')
      OPEN(UNIT=22, FILE='model/7segsprint.2',  STATUS='UNKNOWN')
      OPEN(UNIT=23, FILE='model/7segsprint.3',  STATUS='UNKNOWN')
      OPEN(UNIT=24, FILE='model/7segsprint.4',  STATUS='UNKNOWN')
      OPEN(UNIT=25, FILE='model/7segsprint.5',  STATUS='UNKNOWN')
      OPEN(UNIT=26, FILE='model/7segsprint.6',  STATUS='UNKNOWN')

C**   Read message from input file
      READ(20,7000,END=7100,ERR=7101) (MESSAGE(ILOOP),ILOOP = 1,99)

C**   Read values of constants from input file
      READ(20,7010,END=7100,ERR=7101) AE,AF,FOOTANG,G,HE,HF,INA,INB,INC,
     &IND,INE,INF,ING,INH,INI,K1,K2,K3,K4,K5,K6,K7,K8,KE,KF,L1,L10,L2,L3
     &,L4,L5,L6,L7,L8,L9,MA,MB,MC,MD,ME,MF,MG,MH,MI,MTPB,MTPK,POP1XI,POP
     &2XI

C**   Read the initial value of each variable from input file
      READ(20,7010,END=7100,ERR=7101) Q1,Q2,Q3,Q4,Q5,Q6,Q7,U1,U2,U3,U4,U
     &5,U6,U7

C**   Read integration parameters from input file
      READ(20,7011,END=7100,ERR=7101) TINITIAL,TFINAL,INTEGSTP,PRINTINT,
     &ABSERR,RELERR

C**   Write heading(s) to output file(s)
      WRITE(*, 6021) (MESSAGE(ILOOP), ILOOP = 1,99) 
      WRITE(21,6021) (MESSAGE(ILOOP), ILOOP = 1,99) 
      WRITE(22,6022) (MESSAGE(ILOOP), ILOOP = 1,99) 
      WRITE(23,6023) (MESSAGE(ILOOP), ILOOP = 1,99) 
      WRITE(24,6024) (MESSAGE(ILOOP), ILOOP = 1,99) 
      WRITE(25,6025) (MESSAGE(ILOOP), ILOOP = 1,99) 
      WRITE(26,6026) (MESSAGE(ILOOP), ILOOP = 1,99) 

C**   Degree to radian conversion
      PI       = 4*ATAN(1.0D0)
      DEGtoRAD = PI/180.0D0
      RADtoDEG = 180.0D0/PI
      FOOTANG = FOOTANG*DEGtoRAD
      Q3 = Q3*DEGtoRAD
      Q4 = Q4*DEGtoRAD
      Q5 = Q5*DEGtoRAD
      Q6 = Q6*DEGtoRAD
      Q7 = Q7*DEGtoRAD

C**   Evaluate constants
      MT = MA + MB + MC + MD + ME + MF + MG
      U8 = 0
      U9 = 0
      U10 = 0
      U11 = 0
      Z(21) = L10 - L9
      Z(223) = G*ME
      Z(529) = Z(21)*Z(223)
      Z(654) = INF + INH + INI
      Z(22) = L8 - L7
      Z(485) = MF*Z(22)
      Z(663) = INH + INI
      Z(23) = L6 - L4
      Z(24) = 0.5D0*L6 + 0.5D0*Z(23)
      Z(601) = L8*Z(24)
      Z(26) = L2 - L1
      Z(510) = MI*Z(26)
      Z(7) = COS(FOOTANG)
      Z(8) = SIN(FOOTANG)
      Z(25) = 0.5D0*L3 - 0.5D0*L5
      Z(75) = MA + MB + MC + MD + ME + MF + MG + MH + MI
      Z(76) = (L1*MA+L2*MB+L2*MC+L2*MD+L2*ME+L2*MF+L2*MG+L2*MH+L2*MI)/Z(
     &75)
      Z(77) = (L4*MB+2*L6*MC+2*L6*MD+2*L6*ME+2*L6*MF+2*L6*MG+2*L6*MH+2*L
     &6*MI)/Z(75)
      Z(78) = (L7*MC+L8*MD+L8*ME+L8*MF+L8*MG+L8*MH+L8*MI)/Z(75)
      Z(79) = (L10*ME+L10*MF+L10*MG+L10*MH+L10*MI+L9*MD)/Z(75)
      Z(80) = (L10*MF+L10*MH+L10*MI+ME*Z(21))/Z(75)
      Z(81) = (L8*MH+L8*MI+MF*Z(22))/Z(75)
      Z(83) = (L6*MI+MH*Z(24))/Z(75)
      Z(84) = MI*Z(26)/Z(75)
      Z(85) = MH*Z(25)/Z(75)
      Z(86) = L3*MB/Z(75)
      Z(87) = MA + MB + MC + MD
      Z(88) = (L1*MA+L2*MB+L2*MC+L2*MD)/Z(87)
      Z(89) = (L4*MB+2*L6*MC+2*L6*MD)/Z(87)
      Z(90) = (L7*MC+L8*MD)/Z(87)
      Z(91) = L9*MD/Z(87)
      Z(92) = L3*MB/Z(87)
      Z(93) = ME + MF + MH + MI
      Z(94) = L2*(ME+MF+MH+MI)/Z(93)
      Z(95) = L6*(ME+MF+MH+MI)/Z(93)
      Z(96) = L8*(ME+MF+MH+MI)/Z(93)
      Z(97) = L10*(ME+MF+MH+MI)/Z(93)
      Z(98) = (L10*MF+L10*MH+L10*MI+ME*Z(21))/Z(93)
      Z(99) = (L8*MH+L8*MI+MF*Z(22))/Z(93)
      Z(100) = (L6*MI+MH*Z(24))/Z(93)
      Z(101) = MI*Z(26)/Z(93)
      Z(102) = MH*Z(25)/Z(93)
      Z(219) = G*MA
      Z(220) = G*MB
      Z(221) = G*MC
      Z(222) = G*MD
      Z(224) = G*MF
      Z(225) = G*MG
      Z(226) = G*MH
      Z(227) = G*MI
      Z(347) = Z(76) - L1
      Z(348) = Z(76) - L2
      Z(349) = 0.5D0*L4 - 0.5D0*Z(77)
      Z(350) = 0.5D0*L3 - 0.5D0*Z(86)
      Z(378) = L6 - 0.5D0*Z(77)
      Z(379) = L7 - Z(78)
      Z(380) = L8 - Z(78)
      Z(381) = L9 - Z(79)
      Z(382) = L10 - Z(79)
      Z(383) = Z(21) - Z(80)
      Z(384) = L10 - Z(80)
      Z(385) = Z(22) - Z(81)
      Z(387) = L8 - Z(81)
      Z(388) = Z(24) - Z(83)
      Z(389) = Z(25) - Z(85)
      Z(393) = L6 - Z(83)
      Z(394) = Z(26) - Z(84)
      Z(399) = Z(349) + Z(7)*Z(350)
      Z(403) = Z(350) + Z(7)*Z(349)
      Z(406) = Z(7)*Z(86)
      Z(446) = 2*Z(388) + 2*Z(7)*Z(389)
      Z(450) = 2*Z(389) + 2*Z(7)*Z(388)
      Z(458) = Z(7)*Z(85)
      Z(463) = L1*MA
      Z(464) = L2*MB
      Z(465) = L4*MB
      Z(466) = L3*MB
      Z(467) = L2*MC
      Z(468) = L6*MC
      Z(469) = L7*MC
      Z(470) = L2*MD
      Z(471) = L6*MD
      Z(472) = L8*MD
      Z(473) = L9*MD
      Z(474) = L2*ME
      Z(475) = L6*ME
      Z(476) = L8*ME
      Z(477) = L10*ME
      Z(478) = ME*Z(21)
      Z(480) = L2*MF
      Z(481) = L6*MF
      Z(482) = L8*MF
      Z(483) = L10*MF
      Z(487) = L2*MG
      Z(488) = L6*MG
      Z(489) = L8*MG
      Z(490) = L10*MG
      Z(493) = L2*MH
      Z(494) = L6*MH
      Z(495) = L8*MH
      Z(496) = L10*MH
      Z(499) = MH*Z(24)
      Z(501) = MH*Z(25)
      Z(503) = L2*MI
      Z(504) = L6*MI
      Z(505) = L8*MI
      Z(506) = L10*MI
      Z(513) = Z(219) + Z(220) + Z(221) + Z(222) + Z(223) + Z(224) + Z(2
     &25) + Z(226) + Z(227)
      Z(515) = L1*Z(219)
      Z(517) = L2*Z(220)
      Z(518) = L2*Z(221)
      Z(519) = L2*Z(222)
      Z(520) = L2*Z(223)
      Z(521) = L2*Z(224)
      Z(522) = L2*Z(225)
      Z(523) = L2*Z(226)
      Z(524) = L2*Z(227)
      Z(531) = Z(22)*Z(224)
      Z(534) = Z(26)*Z(227)
      Z(553) = L1*MA + L2*MB + L2*MC + L2*MD + L2*ME + L2*MF + L2*MG + L
     &2*MH + L2*MI
      Z(565) = INA + INB + INC + IND + INE + INF + ING + INH + INI + MA*
     &L1**2
      Z(566) = L3**2 + L4**2 + 4*L2**2 + 2*L3*L4*Z(7)
      Z(567) = L2*L3
      Z(568) = L2*L4
      Z(569) = L2*L6
      Z(570) = L2*L7
      Z(571) = L2**2
      Z(572) = L6**2
      Z(573) = L7**2
      Z(574) = L6*L7
      Z(575) = L2*L8
      Z(576) = L2*L9
      Z(577) = L8**2
      Z(578) = L9**2
      Z(579) = L6*L8
      Z(580) = L6*L9
      Z(581) = L8*L9
      Z(582) = L10*L2
      Z(583) = L2*Z(21)
      Z(584) = L10**2
      Z(585) = Z(21)**2
      Z(586) = L10*L6
      Z(587) = L10*L8
      Z(588) = L10*Z(21)
      Z(589) = L6*Z(21)
      Z(590) = L8*Z(21)
      Z(591) = L10*Z(22)
      Z(592) = L2*Z(22)
      Z(593) = Z(22)**2
      Z(594) = L6*Z(22)
      Z(595) = L8*Z(22)
      Z(596) = L6*Z(26)
      Z(597) = L2*Z(26)
      Z(598) = Z(26)**2
      Z(599) = L10*Z(26)
      Z(600) = L8*Z(26)
      Z(602) = L2*Z(24)
      Z(603) = L2*Z(25)
      Z(604) = Z(24)**2
      Z(605) = Z(25)**2
      Z(606) = Z(7)*Z(24)*Z(25)
      Z(607) = L10*Z(24)
      Z(608) = L10*Z(25)
      Z(609) = L6*Z(24)
      Z(610) = L6*Z(25)
      Z(611) = L8*Z(25)
      Z(613) = -INA - MA*L1**2
      Z(615) = MA*L1**2
      Z(619) = L3*Z(8)
      Z(620) = L4*Z(8)
      Z(621) = Z(7)*Z(24)
      Z(622) = Z(7)*Z(25)
      Z(623) = Z(8)*Z(25)
      Z(624) = Z(8)*Z(24)
      Z(626) = INA + MA*L1**2 + MB*L2**2 + MC*L2**2 + MD*L2**2 + ME*L2**
     &2 + MF*L2**2 + MG*L2**2 + MH*L2**2 + MI*L2**2
      Z(627) = INA + MA*L1**2
      Z(632) = INA + INB + MA*L1**2
      Z(633) = L2**2 + L6**2
      Z(638) = INA + INB + INC + MA*L1**2
      Z(642) = INA + INB + INC + IND + MA*L1**2
      Z(645) = INE + INF + INH + INI
      Z(678) = L2*MI*Z(26)

C**   Initialize time, print counter, variables array for integrator
      T      = TINITIAL
      IPRINT = 0
      VAR(1) = Q1
      VAR(2) = Q2
      VAR(3) = Q3
      VAR(4) = Q4
      VAR(5) = Q5
      VAR(6) = Q6
      VAR(7) = Q7
      VAR(8) = U1
      VAR(9) = U2
      VAR(10) = U3
      VAR(11) = U4
      VAR(12) = U5
      VAR(13) = U6
      VAR(14) = U7

C**   Initalize numerical integrator with call to EQNS1 at T=TINITIAL
      CALL KUTTA(EQNS1, 14, VAR, T, INTEGSTP, ABSERR, RELERR, 0, *5920)

C**   Numerically integrate; print results
5900  IF( TFINAL.GE.TINITIAL .AND. T+.01D0*INTEGSTP.GE.TFINAL) IPRINT=-7
      IF( TFINAL.LE.TINITIAL .AND. T+.01D0*INTEGSTP.LE.TFINAL) IPRINT=-7
      IF( IPRINT .LE. 0 ) THEN
        CALL IO(T)
        IF( IPRINT .EQ. -7 ) GOTO 5930
        IPRINT = PRINTINT
      ENDIF
      CALL KUTTA(EQNS1, 14, VAR, T, INTEGSTP, ABSERR, RELERR, 1, *5920)
      IPRINT = IPRINT - 1
      GOTO 5900

C**   Print message if numerical integration fails to converge
5920  CALL IO(T)
      WRITE(*, 6997)
      WRITE(21,6997)
      WRITE(22,6997)
      WRITE(23,6997)
      WRITE(24,6997)
      WRITE(25,6997)
      WRITE(26,6997)

C**   Inform user of input and output filename(s)
5930  WRITE(*,6999)

6021  FORMAT(1X,'FILE: model/7segsprint.1 ',//1X,'*** ',99A1,///,8X,'T',
     &12X,'POP1X',10X,'POP1Y',10X,'POP2X',10X,'POP2Y',10X,'POP3X',10X,'P
     &OP3Y',10X,'POP4X',10X,'POP4Y',10X,'POP5X',10X,'POP5Y',10X,'POP6X',
     &10X,'POP6Y',10X,'POP7X',10X,'POP7Y',10X,'POP8X',10X,'POP8Y',10X,'P
     &OP9X',10X,'POP9Y',9X,'POP10X',9X,'POP10Y',9X,'POP11X',9X,'POP11Y',
     &10X,'POGOX',10X,'POGOY',/,7X,'(S)',12X,'(M)',12X,'(M)',12X,'(M)',1
     &2X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M
     &)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X
     &,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)'
     &,12X,'(M)',/)
6022  FORMAT(1X,'FILE: model/7segsprint.2 ',//1X,'*** ',99A1,///,8X,'T',
     &9X,'POCMSTANCEX',4X,'POCMSTANCEY',4X,'POCMSWINGX',5X,'POCMSWINGY',
     &8X,'POCMX',10X,'POCMY',10X,'VOCMX',10X,'VOCMY',8X,'PSTANCEX',7X,'P
     &STANCEY',8X,'PSWINGX',8X,'PSWINGY',6X,'VOCMSTANCEX',4X,'VOCMSTANCE
     &Y',4X,'VOCMSWINGX',5X,'VOCMSWINGY',/,7X,'(S)',12X,'(M)',12X,'(M)',
     &12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',11X,'(M/S)',10X,'(M/S)',9X
     &,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',9X,'(M/S)',10X,'
     &(M/S)',10X,'(M/S)',10X,'(M/S)',/)
6023  FORMAT(1X,'FILE: model/7segsprint.3 ',//1X,'*** ',99A1,///,8X,'T',
     &13X,'Q1',13X,'Q2',13X,'Q3',13X,'Q4',13X,'Q5',13X,'Q6',13X,'Q7',13X
     &,'U1',13X,'U2',13X,'U3',13X,'U4',13X,'U5',13X,'U6',13X,'U7',/,7X,'
     &(S)',12X,'(M)',12X,'(M)',11X,'(DEG)',10X,'(DEG)',10X,'(DEG)',10X,'
     &(DEG)',10X,'(DEG)',10X,'(M/S)',10X,'(M/S)',9X,'(DEG/S)',8X,'(DEG/S
     &)',8X,'(DEG/S)',8X,'(DEG/S)',8X,'(DEG/S)',/)
6024  FORMAT(1X,'FILE: model/7segsprint.4 ',//1X,'*** ',99A1,///,8X,'T',
     &13X,'RX1',12X,'RY1',12X,'RX2',12X,'RY2',11X,'VRX1',11X,'VRY1',11X,
     &'VRX2',11X,'VRY2',11X,'HTOR',11X,'KTOR',11X,'ATOR',11X,'MTOR',11X,
     &'SHTOR',10X,'SKTOR',10X,'SATOR',10X,'SMTOR',/,7X,'(S)',12X,'(N)',1
     &2X,'(N)',12X,'(N)',12X,'(N)',10X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS
     &)',8X,'(UNITS)',9X,'(N/M)',10X,'(N/M)',10X,'(N/M)',10X,'(N/M)',10X
     &,'(N/M)',10X,'(N/M)',9X,'(UNITS)',8X,'(UNITS)',/)
6025  FORMAT(1X,'FILE: model/7segsprint.5 ',//1X,'*** ',99A1,///,8X,'T',
     &13X,'Q3',12X,'HANG',11X,'KANG',11X,'AANG',11X,'MANG',11X,'SHANG',1
     &0X,'SKANG',10X,'SAANG',10X,'SMANG',11X,'U3',11X,'HANGVEL',8X,'KANG
     &VEL',8X,'AANGVEL',8X,'MANGVEL',7X,'SHANGVEL',7X,'SKANGVEL',7X,'SAA
     &NGVEL',7X,'SMANGVEL',/,7X,'(S)',11X,'(DEG)',10X,'(DEG)',10X,'(DEG)
     &',10X,'(DEG)',10X,'(DEG)',10X,'(DEG)',10X,'(DEG)',9X,'(UNITS)',8X,
     &'(UNITS)',8X,'(DEG/S)',8X,'(DEG/S)',8X,'(DEG/S)',8X,'(DEG/S)',8X,'
     &(DEG/S)',8X,'(DEG/S)',8X,'(DEG/S)',8X,'(UNITS)',8X,'(UNITS)',/)
6026  FORMAT(1X,'FILE: model/7segsprint.6 ',//1X,'*** ',99A1,///,8X,'T',
     &12X,'KECM',11X,'PECM',12X,'TE',13X,'HZ',13X,'PX',13X,'PY',/,7X,'(S
     &)',12X,'(J)',12X,'(J)',12X,'(J)',8X,'(KG.M^2/S)',6X,'(KG.M/S)',7X,
     &'(KG.M/S)',/)
6997  FORMAT(/7X,'Error: Numerical integration failed to converge',/)
6999  FORMAT(//1X,'Input is in the file model/7segsprint.in',//1X,'Outpu
     &t is in the file(s) model/7segsprint.i  (i=1, ..., 6)',//1X,'The o
     &utput quantities and associated files are listed in file model/7se
     &gsprint.dir',/)
7000  FORMAT(//,99A1,///)
7010  FORMAT( 1000(59X,E30.0,/) )
7011  FORMAT( 3(59X,E30.0,/), 1(59X,I30,/), 2(59X,E30.0,/) )
      STOP
7100  WRITE(*,*) 'Premature end of file while reading model/7segsprint.i
     &n '
7101  WRITE(*,*) 'Error while reading file model/7segsprint.in'
      STOP
      END


C**********************************************************************
      SUBROUTINE       EQNS1(T, VAR, VARp, BOUNDARY)
      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          BOUNDARY
      DIMENSION        VAR(*), VARp(*)
      COMMON/CONSTNTS/ AE,AF,FOOTANG,G,HE,HF,INA,INB,INC,IND,INE,INF,ING
     &,INH,INI,K1,K2,K3,K4,K5,K6,K7,K8,KE,KF,L1,L10,L2,L3,L4,L5,L6,L7,L8
     &,L9,MA,MB,MC,MD,ME,MF,MG,MH,MI,MTPB,MTPK,POP1XI,POP2XI
      COMMON/SPECFIED/ EA,FA,GS,HA,IA,EAp,FAp,GSp,HAp,IAp,EApp,FApp,GSpp
     &,HApp,IApp
      COMMON/VARIBLES/ Q1,Q2,Q3,Q4,Q5,Q6,Q7,U1,U2,U3,U4,U5,U6,U7
      COMMON/ALGBRAIC/ AANG,AANGVEL,AETOR,AFTOR,ATOR,HANG,HANGVEL,HETOR,
     &HFTOR,HTOR,HZ,KANG,KANGVEL,KECM,KETOR,KFTOR,KTOR,MANG,MANGVEL,MTOR
     &,PECM,PX,PY,RX1,RX2,RY1,RY2,SATOR,SHANG,SHANGVEL,SHTOR,SKANG,SKANG
     &VEL,SKTOR,SMTOR,TE,U10,U11,U8,U9,VRX1,VRX2,VRY1,VRY2,Q1p,Q2p,Q3p,Q
     &4p,Q5p,Q6p,Q7p,U1p,U2p,U3p,U4p,U5p,U6p,U7p,DP1X,DP2X,MT,POCMSTANCE
     &X,POCMSTANCEY,POCMSWINGX,POCMSWINGY,POCMX,POCMY,POGOX,POGOY,POP10X
     &,POP10Y,POP11X,POP11Y,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,PO
     &P4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,PS
     &TANCEX,PSTANCEY,PSWINGX,PSWINGY,SAANG,SAANGVEL,SMANG,SMANGVEL,VOCM
     &STANCEX,VOCMSTANCEY,VOCMSWINGX,VOCMSWINGY,VOCMX,VOCMY,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(691),COEF(7,7),RHS(7)

C**   Update variables after integration step
      Q1 = VAR(1)
      Q2 = VAR(2)
      Q3 = VAR(3)
      Q4 = VAR(4)
      Q5 = VAR(5)
      Q6 = VAR(6)
      Q7 = VAR(7)
      U1 = VAR(8)
      U2 = VAR(9)
      U3 = VAR(10)
      U4 = VAR(11)
      U5 = VAR(12)
      U6 = VAR(13)
      U7 = VAR(14)

      VRX1 = T
      VRX2 = T
      VRY1 = T
      VRY2 = T
      HETOR = HE*T
      HFTOR = HF*T
      KETOR = KE*T
      KFTOR = KF*T
      AETOR = AE*T
      AFTOR = AF*T
      HTOR = HETOR - HFTOR
      KTOR = KETOR - KFTOR
      ATOR = AETOR - AFTOR
      Z(228) = VRX2 + VRY2
      Z(230) = ATOR + KTOR
      Z(231) = -HTOR - KTOR

      Q1p = U1
      Q2p = U2
      Q3p = U3
      Q4p = U4
      Q5p = U5
      Q6p = U6
      Q7p = U7
      RY1 = -K3*Q2 - K4*ABS(Q2)*U2
      DP1X = Q1 - POP1XI
      RX1 = -RY1*(K1*DP1X+K2*U1)
      Z(3) = COS(Q4)
      Z(5) = COS(Q5)
      Z(4) = SIN(Q4)
      Z(6) = SIN(Q5)
      Z(27) = Z(3)*Z(5) - Z(4)*Z(6)
      Z(1) = COS(Q3)
      Z(9) = COS(Q6)
      Z(12) = SIN(Q7)
      Z(10) = SIN(Q6)
      Z(11) = COS(Q7)
      Z(31) = -Z(9)*Z(12) - Z(10)*Z(11)
      Z(2) = SIN(Q3)
      Z(30) = Z(9)*Z(11) - Z(10)*Z(12)
      Z(34) = Z(1)*Z(31) + Z(2)*Z(30)
      Z(28) = -Z(3)*Z(6) - Z(4)*Z(5)
      Z(32) = Z(9)*Z(12) + Z(10)*Z(11)
      Z(36) = Z(1)*Z(30) + Z(2)*Z(32)
      Z(38) = Z(27)*Z(34) + Z(28)*Z(36)
      POP2Y = Q2 - L2*Z(38)
      Z(29) = Z(3)*Z(6) + Z(4)*Z(5)
      Z(40) = Z(27)*Z(36) + Z(29)*Z(34)
      VOP2Y = U2 - L2*Z(40)*(U3-U4-U5-U6-U7)
      RY2 = -K7*POP2Y - K8*ABS(POP2Y)*VOP2Y
      Z(33) = Z(1)*Z(30) - Z(2)*Z(31)
      Z(35) = Z(1)*Z(32) - Z(2)*Z(30)
      Z(37) = Z(27)*Z(33) + Z(28)*Z(35)
      POP2X = Q1 - L2*Z(37)
      DP2X = POP2X - POP2XI
      Z(39) = Z(27)*Z(35) + Z(29)*Z(33)
      VOP2X = U1 - L2*Z(39)*(U3-U4-U5-U6-U7)
      RX2 = -RY2*(K5*DP2X+K6*VOP2X)
      MANG = Q4
      MANGVEL = U4
      MTOR = MTPK*(3.141592653589793D0-MANG) - MTPB*MANGVEL
      Z(41) = Z(7)*Z(3) - Z(8)*Z(4)
      Z(42) = Z(7)*Z(4) + Z(8)*Z(3)
      Z(43) = -Z(7)*Z(4) - Z(8)*Z(3)
      Z(44) = Z(37)*Z(41) + Z(39)*Z(42)
      Z(45) = Z(38)*Z(41) + Z(40)*Z(42)
      Z(46) = Z(37)*Z(43) + Z(39)*Z(41)
      Z(47) = Z(38)*Z(43) + Z(40)*Z(41)
      Z(48) = Z(3)*Z(37) + Z(4)*Z(39)
      Z(49) = Z(3)*Z(38) + Z(4)*Z(40)
      Z(50) = Z(3)*Z(39) - Z(4)*Z(37)
      Z(51) = Z(3)*Z(40) - Z(4)*Z(38)
      Z(52) = Z(9)*Z(33) + Z(10)*Z(35)
      Z(53) = Z(9)*Z(34) + Z(10)*Z(36)
      Z(54) = Z(9)*Z(35) - Z(10)*Z(33)
      Z(55) = Z(9)*Z(36) - Z(10)*Z(34)
      Z(105) = Z(1)*Z(39) + Z(2)*Z(40)
      Z(106) = Z(1)*Z(38) - Z(2)*Z(37)
      Z(107) = Z(1)*Z(40) - Z(2)*Z(39)
      Z(110) = Z(1)*Z(50) + Z(2)*Z(51)
      Z(111) = Z(1)*Z(49) - Z(2)*Z(48)
      Z(112) = Z(1)*Z(51) - Z(2)*Z(50)
      Z(162) = L1*(U3-U4-U5-U6-U7)
      Z(163) = (U3-U4-U5-U6-U7)*Z(162)
      Z(164) = L2*(U3-U4-U5-U6-U7)
      Z(165) = (U3-U4-U5-U6-U7)*Z(164)
      Z(166) = L4*(U3-U5-U6-U7)
      Z(167) = L3*(U3-U5-U6-U7)
      Z(168) = (U3-U5-U6-U7)*Z(166)
      Z(169) = (U3-U5-U6-U7)*Z(167)
      Z(172) = L6*(U3-U5-U6-U7)
      Z(173) = (U3-U5-U6-U7)*Z(172)
      Z(174) = L7*(U3-U6-U7)
      Z(175) = (U3-U6-U7)*Z(174)
      Z(176) = L8*(U3-U6-U7)
      Z(177) = (U3-U6-U7)*Z(176)
      Z(178) = L9*(U3-U7)
      Z(179) = (U3-U7)*Z(178)
      Z(180) = L10*(U3-U7)
      Z(181) = (U3-U7)*Z(180)
      Z(229) = MTOR - ATOR
      Z(232) = Z(9)*Z(27) + Z(10)*Z(28)
      Z(233) = Z(9)*Z(28) - Z(10)*Z(27)
      Z(234) = Z(9)*Z(29) + Z(10)*Z(27)
      Z(235) = Z(9)*Z(27) - Z(10)*Z(29)
      Z(237) = Z(3)*Z(233) + Z(4)*Z(235)
      Z(238) = Z(3)*Z(234) - Z(4)*Z(232)
      Z(239) = Z(3)*Z(235) - Z(4)*Z(233)
      Z(512) = RX1 + RX2 + VRX1
      Z(514) = Z(513) + RY1 + RY2 + VRY1 + Z(228)
      Z(525) = MTOR + Z(515)*Z(40) + Z(517)*Z(40) + Z(518)*Z(40) + Z(519
     &)*Z(40) + Z(520)*Z(40) + Z(521)*Z(40) + Z(522)*Z(40) + Z(523)*Z(40
     &) + Z(524)*Z(40) + L2*Z(40)*Z(228) + L2*(RX2*Z(39)+RY2*Z(40)) + L2
     &*(VRX1*Z(39)+VRY1*Z(40))
      Z(526) = MTOR + Z(515)*Z(40) + L2*VRX1*Z(39) + L2*VRY1*Z(40) + L2*
     &(RX2*Z(39)+RY2*Z(40)) + Z(221)*(L2*Z(40)-L6*Z(51)) + Z(222)*(L2*Z(
     &40)-L6*Z(51)) + Z(223)*(L2*Z(40)-L6*Z(51)) + Z(224)*(L2*Z(40)-L6*Z
     &(51)) + Z(225)*(L2*Z(40)-L6*Z(51)) + Z(226)*(L2*Z(40)-L6*Z(51)) + 
     &Z(227)*(L2*Z(40)-L6*Z(51)) + Z(228)*(L2*Z(40)-L6*Z(51)) + 0.5D0*Z(
     &220)*(2*L2*Z(40)-L3*Z(47)-L4*Z(51)) - Z(229) - L6*VRX1*Z(50) - L6*
     &VRY1*Z(51)
      Z(527) = MTOR + Z(515)*Z(40) + L2*VRX1*Z(39) + L2*VRY1*Z(40) + L2*
     &(RX2*Z(39)+RY2*Z(40)) + Z(221)*(L2*Z(40)-L6*Z(51)-L7*Z(36)) + Z(22
     &2)*(L2*Z(40)-L6*Z(51)-L8*Z(36)) + Z(223)*(L2*Z(40)-L6*Z(51)-L8*Z(3
     &6)) + Z(224)*(L2*Z(40)-L6*Z(51)-L8*Z(36)) + Z(225)*(L2*Z(40)-L6*Z(
     &51)-L8*Z(36)) + Z(226)*(L2*Z(40)-L6*Z(51)-L8*Z(36)) + Z(227)*(L2*Z
     &(40)-L6*Z(51)-L8*Z(36)) + Z(228)*(L2*Z(40)-L6*Z(51)-L8*Z(36)) + 0.
     &5D0*Z(220)*(2*L2*Z(40)-L3*Z(47)-L4*Z(51)) - Z(229) - Z(230) - L6*V
     &RX1*Z(50) - L6*VRY1*Z(51) - L8*VRX1*Z(35) - L8*VRY1*Z(36)
      Z(528) = MTOR + Z(515)*Z(40) + L2*VRX1*Z(39) + L2*VRY1*Z(40) + L2*
     &(RX2*Z(39)+RY2*Z(40)) + Z(221)*(L2*Z(40)-L6*Z(51)-L7*Z(36)) + 0.5D
     &0*Z(220)*(2*L2*Z(40)-L3*Z(47)-L4*Z(51)) + Z(222)*(L2*Z(40)-L6*Z(51
     &)-L8*Z(36)-L9*Z(55)) + Z(223)*(L2*Z(40)-L10*Z(55)-L6*Z(51)-L8*Z(36
     &)) + Z(224)*(L2*Z(40)-L10*Z(55)-L6*Z(51)-L8*Z(36)) + Z(225)*(L2*Z(
     &40)-L10*Z(55)-L6*Z(51)-L8*Z(36)) + Z(226)*(L2*Z(40)-L10*Z(55)-L6*Z
     &(51)-L8*Z(36)) + Z(227)*(L2*Z(40)-L10*Z(55)-L6*Z(51)-L8*Z(36)) + Z
     &(228)*(L2*Z(40)-L10*Z(55)-L6*Z(51)-L8*Z(36)) - Z(229) - Z(230) - Z
     &(231) - L10*VRX1*Z(54) - L10*VRY1*Z(55) - L6*VRX1*Z(50) - L6*VRY1*
     &Z(51) - L8*VRX1*Z(35) - L8*VRY1*Z(36)
      Z(554) = Z(553)*Z(39)
      Z(555) = Z(463)*Z(39) + MC*(L2*Z(39)-L6*Z(50)) + MD*(L2*Z(39)-L6*Z
     &(50)) + ME*(L2*Z(39)-L6*Z(50)) + MF*(L2*Z(39)-L6*Z(50)) + MG*(L2*Z
     &(39)-L6*Z(50)) + MH*(L2*Z(39)-L6*Z(50)) + MI*(L2*Z(39)-L6*Z(50)) +
     & 0.5D0*MB*(2*L2*Z(39)-L3*Z(46)-L4*Z(50))
      Z(556) = Z(463)*Z(39) + MC*(L2*Z(39)-L6*Z(50)-L7*Z(35)) + MD*(L2*Z
     &(39)-L6*Z(50)-L8*Z(35)) + ME*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + MF*(L2
     &*Z(39)-L6*Z(50)-L8*Z(35)) + MG*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + MH*(
     &L2*Z(39)-L6*Z(50)-L8*Z(35)) + MI*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + 0.
     &5D0*MB*(2*L2*Z(39)-L3*Z(46)-L4*Z(50))
      Z(557) = Z(463)*Z(39) + MC*(L2*Z(39)-L6*Z(50)-L7*Z(35)) + 0.5D0*MB
     &*(2*L2*Z(39)-L3*Z(46)-L4*Z(50)) + MD*(L2*Z(39)-L6*Z(50)-L8*Z(35)-L
     &9*Z(54)) + ME*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + MF*(L2*Z(39
     &)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + MG*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L
     &8*Z(35)) + MH*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + MI*(L2*Z(39
     &)-L10*Z(54)-L6*Z(50)-L8*Z(35))
      Z(560) = Z(553)*Z(40)
      Z(561) = Z(463)*Z(40) + MC*(L2*Z(40)-L6*Z(51)) + MD*(L2*Z(40)-L6*Z
     &(51)) + ME*(L2*Z(40)-L6*Z(51)) + MF*(L2*Z(40)-L6*Z(51)) + MG*(L2*Z
     &(40)-L6*Z(51)) + MH*(L2*Z(40)-L6*Z(51)) + MI*(L2*Z(40)-L6*Z(51)) +
     & 0.5D0*MB*(2*L2*Z(40)-L3*Z(47)-L4*Z(51))
      Z(562) = Z(463)*Z(40) + MC*(L2*Z(40)-L6*Z(51)-L7*Z(36)) + MD*(L2*Z
     &(40)-L6*Z(51)-L8*Z(36)) + ME*(L2*Z(40)-L6*Z(51)-L8*Z(36)) + MF*(L2
     &*Z(40)-L6*Z(51)-L8*Z(36)) + MG*(L2*Z(40)-L6*Z(51)-L8*Z(36)) + MH*(
     &L2*Z(40)-L6*Z(51)-L8*Z(36)) + MI*(L2*Z(40)-L6*Z(51)-L8*Z(36)) + 0.
     &5D0*MB*(2*L2*Z(40)-L3*Z(47)-L4*Z(51))
      Z(563) = Z(463)*Z(40) + MC*(L2*Z(40)-L6*Z(51)-L7*Z(36)) + 0.5D0*MB
     &*(2*L2*Z(40)-L3*Z(47)-L4*Z(51)) + MD*(L2*Z(40)-L6*Z(51)-L8*Z(36)-L
     &9*Z(55)) + ME*(L2*Z(40)-L10*Z(55)-L6*Z(51)-L8*Z(36)) + MF*(L2*Z(40
     &)-L10*Z(55)-L6*Z(51)-L8*Z(36)) + MG*(L2*Z(40)-L10*Z(55)-L6*Z(51)-L
     &8*Z(36)) + MH*(L2*Z(40)-L10*Z(55)-L6*Z(51)-L8*Z(36)) + MI*(L2*Z(40
     &)-L10*Z(55)-L6*Z(51)-L8*Z(36))
      Z(628) = Z(627) + Z(467)*(L2-L6*Z(3)) + Z(470)*(L2-L6*Z(3)) + Z(47
     &4)*(L2-L6*Z(3)) + Z(480)*(L2-L6*Z(3)) + Z(487)*(L2-L6*Z(3)) + Z(49
     &3)*(L2-L6*Z(3)) + Z(503)*(L2-L6*Z(3)) + 0.5D0*Z(464)*(2*L2-L3*Z(41
     &)-L4*Z(3))
      Z(629) = Z(627) + Z(467)*(L2-L6*Z(3)-L7*Z(27)) + Z(470)*(L2-L6*Z(3
     &)-L8*Z(27)) + Z(474)*(L2-L6*Z(3)-L8*Z(27)) + Z(480)*(L2-L6*Z(3)-L8
     &*Z(27)) + Z(487)*(L2-L6*Z(3)-L8*Z(27)) + Z(493)*(L2-L6*Z(3)-L8*Z(2
     &7)) + Z(503)*(L2-L6*Z(3)-L8*Z(27)) + 0.5D0*Z(464)*(2*L2-L3*Z(41)-L
     &4*Z(3))
      Z(630) = Z(627) + Z(467)*(L2-L6*Z(3)-L7*Z(27)) + 0.5D0*Z(464)*(2*L
     &2-L3*Z(41)-L4*Z(3)) + Z(470)*(L2-L6*Z(3)-L8*Z(27)-L9*Z(235)) + Z(4
     &74)*(L2-L10*Z(235)-L6*Z(3)-L8*Z(27)) + Z(480)*(L2-L10*Z(235)-L6*Z(
     &3)-L8*Z(27)) + Z(487)*(L2-L10*Z(235)-L6*Z(3)-L8*Z(27)) + Z(493)*(L
     &2-L10*Z(235)-L6*Z(3)-L8*Z(27)) + Z(503)*(L2-L10*Z(235)-L6*Z(3)-L8*
     &Z(27))
      Z(634) = Z(632) + MC*(Z(633)-2*Z(569)*Z(3)) + MD*(Z(633)-2*Z(569)*
     &Z(3)) + ME*(Z(633)-2*Z(569)*Z(3)) + MF*(Z(633)-2*Z(569)*Z(3)) + MG
     &*(Z(633)-2*Z(569)*Z(3)) + MH*(Z(633)-2*Z(569)*Z(3)) + MI*(Z(633)-2
     &*Z(569)*Z(3)) + 0.25D0*MB*(Z(566)-4*Z(567)*Z(41)-4*Z(568)*Z(3))
      Z(635) = Z(632) + 0.25D0*MB*(Z(566)-4*Z(567)*Z(41)-4*Z(568)*Z(3)) 
     &- MC*(Z(570)*Z(27)+2*Z(569)*Z(3)-Z(571)-Z(572)-Z(574)*Z(5)) - MD*(
     &Z(575)*Z(27)+2*Z(569)*Z(3)-Z(571)-Z(572)-Z(579)*Z(5)) - ME*(Z(575)
     &*Z(27)+2*Z(569)*Z(3)-Z(571)-Z(572)-Z(579)*Z(5)) - MF*(Z(575)*Z(27)
     &+2*Z(569)*Z(3)-Z(571)-Z(572)-Z(579)*Z(5)) - MG*(Z(575)*Z(27)+2*Z(5
     &69)*Z(3)-Z(571)-Z(572)-Z(579)*Z(5)) - MH*(Z(575)*Z(27)+2*Z(569)*Z(
     &3)-Z(571)-Z(572)-Z(579)*Z(5)) - MI*(Z(575)*Z(27)+2*Z(569)*Z(3)-Z(5
     &71)-Z(572)-Z(579)*Z(5))
      Z(636) = Z(632) + 0.25D0*MB*(Z(566)-4*Z(567)*Z(41)-4*Z(568)*Z(3)) 
     &- MC*(Z(570)*Z(27)+2*Z(569)*Z(3)-Z(571)-Z(572)-Z(574)*Z(5)) - MD*(
     &Z(575)*Z(27)+Z(576)*Z(235)+2*Z(569)*Z(3)-Z(571)-Z(572)-Z(579)*Z(5)
     &-Z(580)*Z(239)) - ME*(Z(575)*Z(27)+Z(582)*Z(235)+2*Z(569)*Z(3)-Z(5
     &71)-Z(572)-Z(579)*Z(5)-Z(586)*Z(239)) - MF*(Z(575)*Z(27)+Z(582)*Z(
     &235)+2*Z(569)*Z(3)-Z(571)-Z(572)-Z(579)*Z(5)-Z(586)*Z(239)) - MG*(
     &Z(575)*Z(27)+Z(582)*Z(235)+2*Z(569)*Z(3)-Z(571)-Z(572)-Z(579)*Z(5)
     &-Z(586)*Z(239)) - MH*(Z(575)*Z(27)+Z(582)*Z(235)+2*Z(569)*Z(3)-Z(5
     &71)-Z(572)-Z(579)*Z(5)-Z(586)*Z(239)) - MI*(Z(575)*Z(27)+Z(582)*Z(
     &235)+2*Z(569)*Z(3)-Z(571)-Z(572)-Z(579)*Z(5)-Z(586)*Z(239))
      Z(639) = Z(638) + 0.25D0*MB*(Z(566)-4*Z(567)*Z(41)-4*Z(568)*Z(3)) 
     &- MC*(2*Z(569)*Z(3)+2*Z(570)*Z(27)-Z(571)-Z(572)-Z(573)-2*Z(574)*Z
     &(5)) - MD*(2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z(571)-Z(572)-Z(577)-2*Z(5
     &79)*Z(5)) - ME*(2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z(571)-Z(572)-Z(577)-
     &2*Z(579)*Z(5)) - MF*(2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z(571)-Z(572)-Z(
     &577)-2*Z(579)*Z(5)) - MG*(2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z(571)-Z(57
     &2)-Z(577)-2*Z(579)*Z(5)) - MH*(2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z(571)
     &-Z(572)-Z(577)-2*Z(579)*Z(5)) - MI*(2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z
     &(571)-Z(572)-Z(577)-2*Z(579)*Z(5))
      Z(640) = Z(638) + 0.25D0*MB*(Z(566)-4*Z(567)*Z(41)-4*Z(568)*Z(3)) 
     &- MC*(2*Z(569)*Z(3)+2*Z(570)*Z(27)-Z(571)-Z(572)-Z(573)-2*Z(574)*Z
     &(5)) - MD*(Z(576)*Z(235)+2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z(571)-Z(572
     &)-Z(577)-2*Z(579)*Z(5)-Z(580)*Z(239)-Z(581)*Z(9)) - ME*(Z(582)*Z(2
     &35)+2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z(571)-Z(572)-Z(577)-2*Z(579)*Z(5
     &)-Z(586)*Z(239)-Z(587)*Z(9)) - MF*(Z(582)*Z(235)+2*Z(569)*Z(3)+2*Z
     &(575)*Z(27)-Z(571)-Z(572)-Z(577)-2*Z(579)*Z(5)-Z(586)*Z(239)-Z(587
     &)*Z(9)) - MG*(Z(582)*Z(235)+2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z(571)-Z(
     &572)-Z(577)-2*Z(579)*Z(5)-Z(586)*Z(239)-Z(587)*Z(9)) - MH*(Z(582)*
     &Z(235)+2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z(571)-Z(572)-Z(577)-2*Z(579)*
     &Z(5)-Z(586)*Z(239)-Z(587)*Z(9)) - MI*(Z(582)*Z(235)+2*Z(569)*Z(3)+
     &2*Z(575)*Z(27)-Z(571)-Z(572)-Z(577)-2*Z(579)*Z(5)-Z(586)*Z(239)-Z(
     &587)*Z(9))
      Z(643) = Z(642) + 0.25D0*MB*(Z(566)-4*Z(567)*Z(41)-4*Z(568)*Z(3)) 
     &- MC*(2*Z(569)*Z(3)+2*Z(570)*Z(27)-Z(571)-Z(572)-Z(573)-2*Z(574)*Z
     &(5)) - MD*(2*Z(569)*Z(3)+2*Z(575)*Z(27)+2*Z(576)*Z(235)-Z(571)-Z(5
     &72)-Z(577)-Z(578)-2*Z(579)*Z(5)-2*Z(580)*Z(239)-2*Z(581)*Z(9)) - M
     &E*(2*Z(569)*Z(3)+2*Z(575)*Z(27)+2*Z(582)*Z(235)-Z(571)-Z(572)-Z(57
     &7)-Z(584)-2*Z(579)*Z(5)-2*Z(586)*Z(239)-2*Z(587)*Z(9)) - MF*(2*Z(5
     &69)*Z(3)+2*Z(575)*Z(27)+2*Z(582)*Z(235)-Z(571)-Z(572)-Z(577)-Z(584
     &)-2*Z(579)*Z(5)-2*Z(586)*Z(239)-2*Z(587)*Z(9)) - MG*(2*Z(569)*Z(3)
     &+2*Z(575)*Z(27)+2*Z(582)*Z(235)-Z(571)-Z(572)-Z(577)-Z(584)-2*Z(57
     &9)*Z(5)-2*Z(586)*Z(239)-2*Z(587)*Z(9)) - MH*(2*Z(569)*Z(3)+2*Z(575
     &)*Z(27)+2*Z(582)*Z(235)-Z(571)-Z(572)-Z(577)-Z(584)-2*Z(579)*Z(5)-
     &2*Z(586)*Z(239)-2*Z(587)*Z(9)) - MI*(2*Z(569)*Z(3)+2*Z(575)*Z(27)+
     &2*Z(582)*Z(235)-Z(571)-Z(572)-Z(577)-Z(584)-2*Z(579)*Z(5)-2*Z(586)
     &*Z(239)-2*Z(587)*Z(9))

C**   Quantities to be specified
      EA = 0
      FA = 0
      GS = 0
      HA = 0
      IA = 0
      EAp = 0
      FAp = 0
      GSp = 0
      HAp = 0
      IAp = 0
      EApp = 0
      FApp = 0
      GSpp = 0
      HApp = 0
      IApp = 0

      Z(13) = COS(EA)
      Z(14) = SIN(EA)
      Z(15) = COS(FA)
      Z(16) = SIN(FA)
      Z(17) = COS(HA)
      Z(18) = SIN(HA)
      Z(19) = COS(IA)
      Z(20) = SIN(IA)
      Z(56) = Z(13)*Z(1) + Z(14)*Z(2)
      Z(57) = Z(13)*Z(2) - Z(14)*Z(1)
      Z(58) = Z(14)*Z(1) - Z(13)*Z(2)
      Z(59) = -Z(15)*Z(56) - Z(16)*Z(58)
      Z(60) = -Z(15)*Z(57) - Z(16)*Z(56)
      Z(61) = Z(16)*Z(56) - Z(15)*Z(58)
      Z(62) = Z(16)*Z(57) - Z(15)*Z(56)
      Z(63) = Z(18)*Z(61) - Z(17)*Z(59)
      Z(64) = Z(18)*Z(62) - Z(17)*Z(60)
      Z(65) = -Z(17)*Z(61) - Z(18)*Z(59)
      Z(66) = -Z(17)*Z(62) - Z(18)*Z(60)
      Z(67) = Z(7)*Z(63) + Z(8)*Z(65)
      Z(68) = Z(7)*Z(64) + Z(8)*Z(66)
      Z(69) = Z(7)*Z(65) - Z(8)*Z(63)
      Z(70) = Z(7)*Z(66) - Z(8)*Z(64)
      Z(71) = Z(20)*Z(65) - Z(19)*Z(63)
      Z(72) = Z(20)*Z(66) - Z(19)*Z(64)
      Z(73) = -Z(19)*Z(65) - Z(20)*Z(63)
      Z(74) = -Z(19)*Z(66) - Z(20)*Z(64)
      Z(114) = U8 - EAp
      Z(116) = FApp - EApp
      Z(122) = FApp - EApp - HApp
      Z(123) = Z(1)*Z(63) + Z(2)*Z(64)
      Z(124) = Z(1)*Z(65) + Z(2)*Z(66)
      Z(125) = Z(1)*Z(64) - Z(2)*Z(63)
      Z(126) = Z(1)*Z(66) - Z(2)*Z(65)
      Z(128) = FApp - EApp - HApp - IApp
      Z(129) = Z(1)*Z(71) + Z(2)*Z(72)
      Z(130) = Z(1)*Z(73) + Z(2)*Z(74)
      Z(131) = Z(1)*Z(72) - Z(2)*Z(71)
      Z(132) = Z(1)*Z(74) - Z(2)*Z(73)
      Z(137) = Z(21)*EAp
      Z(138) = L10*EAp
      Z(139) = Z(22)*(EAp-FAp)
      Z(140) = L8*(EAp-FAp)
      Z(141) = Z(1)*Z(67) + Z(2)*Z(68)
      Z(142) = Z(1)*Z(69) + Z(2)*Z(70)
      Z(143) = Z(1)*Z(68) - Z(2)*Z(67)
      Z(144) = Z(1)*Z(70) - Z(2)*Z(69)
      Z(145) = L6*(FAp-EAp-HAp)
      Z(147) = Z(24)*(FAp-EAp-HAp)
      Z(148) = Z(25)*(FAp-EAp-HAp)
      Z(149) = Z(26)*(FAp-EAp-HAp-IAp)
      Z(182) = Z(21)*U3 + Z(21)*U8 - Z(137)
      Z(183) = Z(21)*EApp
      Z(184) = Z(182)*(U3+Z(114))
      Z(185) = L10*U3 + L10*U8 - Z(138)
      Z(186) = L10*EApp
      Z(187) = Z(185)*(U3+Z(114))
      Z(188) = Z(22)*U3 + Z(22)*U8 + Z(22)*U9 - Z(139)
      Z(189) = Z(22)*(EApp-FApp)
      Z(190) = FAp + U9
      Z(191) = Z(188)*(U3+Z(114)+Z(190))
      Z(192) = L8*U3 + L8*U8 + L8*U9 - Z(140)
      Z(193) = L8*(EApp-FApp)
      Z(194) = Z(192)*(U3+Z(114)+Z(190))
      Z(195) = GS*U3
      Z(196) = GSp*U3
      Z(197) = GSpp - U3*Z(195)
      Z(198) = GSp*U3 + Z(196)
      Z(199) = Z(145) + L6*U10 + L6*U3 + L6*U8 + L6*U9
      Z(201) = L6*(FApp-EApp-HApp)
      Z(202) = U10 - HAp
      Z(204) = Z(199)*(U3+Z(114)+Z(190)+Z(202))
      Z(206) = Z(147) + Z(24)*U10 + Z(24)*U3 + Z(24)*U8 + Z(24)*U9
      Z(207) = Z(148) + Z(25)*U10 + Z(25)*U3 + Z(25)*U8 + Z(25)*U9
      Z(208) = Z(24)*(FApp-EApp-HApp)
      Z(209) = Z(25)*(FApp-EApp-HApp)
      Z(210) = Z(206)*(U3+Z(114)+Z(190)+Z(202))
      Z(211) = Z(207)*(U3+Z(114)+Z(190)+Z(202))
      Z(212) = Z(149) + Z(26)*U10 + Z(26)*U11 + Z(26)*U3 + Z(26)*U8 + Z(
     &26)*U9
      Z(213) = Z(26)*(FApp-EApp-HApp-IApp)
      Z(214) = U11 - IAp
      Z(215) = Z(212)*(U3+Z(114)+Z(190)+Z(202)+Z(214))
      Z(240) = Z(37)*Z(56) + Z(38)*Z(57)
      Z(241) = Z(37)*Z(58) + Z(38)*Z(56)
      Z(242) = Z(39)*Z(56) + Z(40)*Z(57)
      Z(243) = Z(39)*Z(58) + Z(40)*Z(56)
      Z(244) = Z(3)*Z(240) + Z(4)*Z(242)
      Z(245) = Z(3)*Z(241) + Z(4)*Z(243)
      Z(246) = Z(3)*Z(242) - Z(4)*Z(240)
      Z(247) = Z(3)*Z(243) - Z(4)*Z(241)
      Z(248) = Z(5)*Z(244) + Z(6)*Z(246)
      Z(249) = Z(5)*Z(245) + Z(6)*Z(247)
      Z(250) = Z(5)*Z(246) - Z(6)*Z(244)
      Z(251) = Z(5)*Z(247) - Z(6)*Z(245)
      Z(253) = Z(9)*Z(249) + Z(10)*Z(251)
      Z(254) = Z(9)*Z(250) - Z(10)*Z(248)
      Z(255) = Z(9)*Z(251) - Z(10)*Z(249)
      Z(256) = Z(37)*Z(59) + Z(38)*Z(60)
      Z(257) = Z(37)*Z(61) + Z(38)*Z(62)
      Z(258) = Z(39)*Z(59) + Z(40)*Z(60)
      Z(259) = Z(39)*Z(61) + Z(40)*Z(62)
      Z(260) = Z(3)*Z(256) + Z(4)*Z(258)
      Z(261) = Z(3)*Z(257) + Z(4)*Z(259)
      Z(262) = Z(3)*Z(258) - Z(4)*Z(256)
      Z(263) = Z(3)*Z(259) - Z(4)*Z(257)
      Z(264) = Z(5)*Z(260) + Z(6)*Z(262)
      Z(265) = Z(5)*Z(261) + Z(6)*Z(263)
      Z(266) = Z(5)*Z(262) - Z(6)*Z(260)
      Z(267) = Z(5)*Z(263) - Z(6)*Z(261)
      Z(269) = Z(9)*Z(265) + Z(10)*Z(267)
      Z(270) = Z(9)*Z(266) - Z(10)*Z(264)
      Z(271) = Z(9)*Z(267) - Z(10)*Z(265)
      Z(272) = Z(37)*Z(63) + Z(38)*Z(64)
      Z(273) = Z(37)*Z(65) + Z(38)*Z(66)
      Z(274) = Z(39)*Z(63) + Z(40)*Z(64)
      Z(275) = Z(39)*Z(65) + Z(40)*Z(66)
      Z(276) = Z(37)*Z(67) + Z(38)*Z(68)
      Z(277) = Z(37)*Z(69) + Z(38)*Z(70)
      Z(278) = Z(39)*Z(67) + Z(40)*Z(68)
      Z(279) = Z(39)*Z(69) + Z(40)*Z(70)
      Z(280) = Z(3)*Z(272) + Z(4)*Z(274)
      Z(281) = Z(3)*Z(273) + Z(4)*Z(275)
      Z(282) = Z(3)*Z(274) - Z(4)*Z(272)
      Z(283) = Z(3)*Z(275) - Z(4)*Z(273)
      Z(284) = Z(3)*Z(276) + Z(4)*Z(278)
      Z(285) = Z(3)*Z(277) + Z(4)*Z(279)
      Z(286) = Z(3)*Z(278) - Z(4)*Z(276)
      Z(287) = Z(3)*Z(279) - Z(4)*Z(277)
      Z(288) = Z(5)*Z(280) + Z(6)*Z(282)
      Z(289) = Z(5)*Z(281) + Z(6)*Z(283)
      Z(290) = Z(5)*Z(282) - Z(6)*Z(280)
      Z(291) = Z(5)*Z(283) - Z(6)*Z(281)
      Z(292) = Z(5)*Z(284) + Z(6)*Z(286)
      Z(293) = Z(5)*Z(285) + Z(6)*Z(287)
      Z(294) = Z(5)*Z(286) - Z(6)*Z(284)
      Z(295) = Z(5)*Z(287) - Z(6)*Z(285)
      Z(297) = Z(9)*Z(289) + Z(10)*Z(291)
      Z(298) = Z(9)*Z(290) - Z(10)*Z(288)
      Z(299) = Z(9)*Z(291) - Z(10)*Z(289)
      Z(301) = Z(9)*Z(293) + Z(10)*Z(295)
      Z(302) = Z(9)*Z(294) - Z(10)*Z(292)
      Z(303) = Z(9)*Z(295) - Z(10)*Z(293)
      Z(305) = Z(13)*Z(124) - Z(14)*Z(126)
      Z(306) = Z(13)*Z(125) + Z(14)*Z(123)
      Z(307) = Z(13)*Z(126) + Z(14)*Z(124)
      Z(308) = Z(13)*Z(141) - Z(14)*Z(143)
      Z(309) = Z(13)*Z(142) - Z(14)*Z(144)
      Z(310) = Z(13)*Z(143) + Z(14)*Z(141)
      Z(311) = Z(13)*Z(144) + Z(14)*Z(142)
      Z(313) = -Z(15)*Z(309) - Z(16)*Z(311)
      Z(314) = Z(16)*Z(308) - Z(15)*Z(310)
      Z(315) = Z(16)*Z(309) - Z(15)*Z(311)
      Z(316) = Z(37)*Z(71) + Z(38)*Z(72)
      Z(317) = Z(37)*Z(73) + Z(38)*Z(74)
      Z(318) = Z(39)*Z(71) + Z(40)*Z(72)
      Z(319) = Z(39)*Z(73) + Z(40)*Z(74)
      Z(320) = Z(3)*Z(316) + Z(4)*Z(318)
      Z(321) = Z(3)*Z(317) + Z(4)*Z(319)
      Z(322) = Z(3)*Z(318) - Z(4)*Z(316)
      Z(323) = Z(3)*Z(319) - Z(4)*Z(317)
      Z(324) = Z(5)*Z(320) + Z(6)*Z(322)
      Z(325) = Z(5)*Z(321) + Z(6)*Z(323)
      Z(326) = Z(5)*Z(322) - Z(6)*Z(320)
      Z(327) = Z(5)*Z(323) - Z(6)*Z(321)
      Z(329) = Z(9)*Z(325) + Z(10)*Z(327)
      Z(330) = Z(9)*Z(326) - Z(10)*Z(324)
      Z(331) = Z(9)*Z(327) - Z(10)*Z(325)
      Z(332) = Z(13)*Z(129) - Z(14)*Z(131)
      Z(333) = Z(13)*Z(130) - Z(14)*Z(132)
      Z(334) = Z(13)*Z(131) + Z(14)*Z(129)
      Z(335) = Z(13)*Z(132) + Z(14)*Z(130)
      Z(337) = -Z(15)*Z(333) - Z(16)*Z(335)
      Z(338) = Z(16)*Z(332) - Z(15)*Z(334)
      Z(339) = Z(16)*Z(333) - Z(15)*Z(335)
      Z(516) = HTOR + Z(229) + Z(230) + Z(231) + L10*VRX1*Z(54) + L10*VR
     &X1*Z(58) + L10*VRY1*Z(55) + L10*VRY1*Z(56) + L6*VRX1*Z(50) + L6*VR
     &X1*Z(65) + L6*VRY1*Z(51) + L6*VRY1*Z(66) + L8*VRX1*Z(35) + L8*VRX1
     &*Z(61) + L8*VRY1*Z(36) + L8*VRY1*Z(62) - MTOR - Z(515)*Z(40) - L2*
     &VRX1*Z(39) - L2*VRY1*Z(40) - L5*VRX1*Z(69) - L5*VRY1*Z(70) - L2*(R
     &X2*Z(39)+RY2*Z(40)) - Z(221)*(L2*Z(40)-L6*Z(51)-L7*Z(36)) - 0.5D0*
     &Z(220)*(2*L2*Z(40)-L3*Z(47)-L4*Z(51)) - Z(222)*(L2*Z(40)-L6*Z(51)-
     &L8*Z(36)-L9*Z(55)) - Z(223)*(L2*Z(40)-L10*Z(55)-L6*Z(51)-L8*Z(36)-
     &Z(21)*Z(56)) - Z(225)*(L2*Z(40)-L10*Z(55)-L6*Z(51)-L8*Z(36)-GS*Z(1
     &)) - Z(224)*(L2*Z(40)-L10*Z(55)-L10*Z(56)-L6*Z(51)-L8*Z(36)-Z(22)*
     &Z(62)) - Z(226)*(L2*Z(40)-L10*Z(55)-L10*Z(56)-L6*Z(51)-L8*Z(36)-L8
     &*Z(62)-Z(24)*Z(66)-Z(25)*Z(70)) - Z(227)*(L2*Z(40)-L10*Z(55)-L10*Z
     &(56)-L6*Z(51)-L6*Z(66)-L8*Z(36)-L8*Z(62)-Z(26)*Z(74)) - Z(228)*(L2
     &*Z(40)-L10*Z(55)-L10*Z(56)-L2*Z(74)-L6*Z(51)-L6*Z(66)-L8*Z(36)-L8*
     &Z(62))
      Z(545) = INE*EApp
      Z(547) = INF*Z(116)
      Z(549) = INH*Z(122)
      Z(551) = INI*Z(128)
      Z(552) = MG*(L10*Z(54)+L6*Z(50)+L8*Z(35)-L2*Z(39)-GS*Z(2)) - Z(463
     &)*Z(39) - MC*(L2*Z(39)-L6*Z(50)-L7*Z(35)) - 0.5D0*MB*(2*L2*Z(39)-L
     &3*Z(46)-L4*Z(50)) - MD*(L2*Z(39)-L6*Z(50)-L8*Z(35)-L9*Z(54)) - ME*
     &(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)-Z(21)*Z(58)) - MF*(L2*Z(39)-
     &L10*Z(54)-L10*Z(58)-L6*Z(50)-L8*Z(35)-Z(22)*Z(61)) - MH*(L2*Z(39)-
     &L10*Z(54)-L10*Z(58)-L6*Z(50)-L8*Z(35)-L8*Z(61)-Z(24)*Z(65)-Z(25)*Z
     &(69)) - MI*(L2*Z(39)-L10*Z(54)-L10*Z(58)-L6*Z(50)-L6*Z(65)-L8*Z(35
     &)-L8*Z(61)-Z(26)*Z(73))
      Z(558) = MA*Z(37)*Z(163) + MC*(Z(37)*Z(165)-Z(33)*Z(175)-Z(48)*Z(1
     &73)) + 0.5D0*MB*(2*Z(37)*Z(165)-Z(44)*Z(169)-Z(48)*Z(168)) + MD*(Z
     &(37)*Z(165)-Z(33)*Z(177)-Z(48)*Z(173)-Z(52)*Z(179)) + MG*(Z(1)*Z(1
     &97)+Z(37)*Z(165)-Z(2)*Z(198)-Z(33)*Z(177)-Z(48)*Z(173)-Z(52)*Z(181
     &)) + ME*(Z(37)*Z(165)-Z(183)*Z(58)-Z(33)*Z(177)-Z(48)*Z(173)-Z(52)
     &*Z(181)-Z(56)*Z(184)) + MF*(Z(37)*Z(165)-Z(186)*Z(58)-Z(189)*Z(61)
     &-Z(33)*Z(177)-Z(48)*Z(173)-Z(52)*Z(181)-Z(56)*Z(187)-Z(59)*Z(191))
     & + MH*(Z(208)*Z(65)+Z(209)*Z(69)+Z(37)*Z(165)-Z(186)*Z(58)-Z(193)*
     &Z(61)-Z(33)*Z(177)-Z(48)*Z(173)-Z(52)*Z(181)-Z(56)*Z(187)-Z(59)*Z(
     &194)-Z(63)*Z(210)-Z(67)*Z(211)) + MI*(Z(201)*Z(65)+Z(213)*Z(73)+Z(
     &37)*Z(165)-Z(186)*Z(58)-Z(193)*Z(61)-Z(33)*Z(177)-Z(48)*Z(173)-Z(5
     &2)*Z(181)-Z(56)*Z(187)-Z(59)*Z(194)-Z(63)*Z(204)-Z(71)*Z(215))
      Z(559) = -Z(463)*Z(40) - MC*(L2*Z(40)-L6*Z(51)-L7*Z(36)) - 0.5D0*M
     &B*(2*L2*Z(40)-L3*Z(47)-L4*Z(51)) - MD*(L2*Z(40)-L6*Z(51)-L8*Z(36)-
     &L9*Z(55)) - ME*(L2*Z(40)-L10*Z(55)-L6*Z(51)-L8*Z(36)-Z(21)*Z(56)) 
     &- MG*(L2*Z(40)-L10*Z(55)-L6*Z(51)-L8*Z(36)-GS*Z(1)) - MF*(L2*Z(40)
     &-L10*Z(55)-L10*Z(56)-L6*Z(51)-L8*Z(36)-Z(22)*Z(62)) - MH*(L2*Z(40)
     &-L10*Z(55)-L10*Z(56)-L6*Z(51)-L8*Z(36)-L8*Z(62)-Z(24)*Z(66)-Z(25)*
     &Z(70)) - MI*(L2*Z(40)-L10*Z(55)-L10*Z(56)-L6*Z(51)-L6*Z(66)-L8*Z(3
     &6)-L8*Z(62)-Z(26)*Z(74))
      Z(564) = MA*Z(38)*Z(163) + MC*(Z(38)*Z(165)-Z(34)*Z(175)-Z(49)*Z(1
     &73)) + 0.5D0*MB*(2*Z(38)*Z(165)-Z(45)*Z(169)-Z(49)*Z(168)) + MD*(Z
     &(38)*Z(165)-Z(34)*Z(177)-Z(49)*Z(173)-Z(53)*Z(179)) + MG*(Z(1)*Z(1
     &98)+Z(2)*Z(197)+Z(38)*Z(165)-Z(34)*Z(177)-Z(49)*Z(173)-Z(53)*Z(181
     &)) + ME*(Z(38)*Z(165)-Z(183)*Z(56)-Z(34)*Z(177)-Z(49)*Z(173)-Z(53)
     &*Z(181)-Z(57)*Z(184)) + MF*(Z(38)*Z(165)-Z(186)*Z(56)-Z(189)*Z(62)
     &-Z(34)*Z(177)-Z(49)*Z(173)-Z(53)*Z(181)-Z(57)*Z(187)-Z(60)*Z(191))
     & + MH*(Z(208)*Z(66)+Z(209)*Z(70)+Z(38)*Z(165)-Z(186)*Z(56)-Z(193)*
     &Z(62)-Z(34)*Z(177)-Z(49)*Z(173)-Z(53)*Z(181)-Z(57)*Z(187)-Z(60)*Z(
     &194)-Z(64)*Z(210)-Z(68)*Z(211)) + MI*(Z(201)*Z(66)+Z(213)*Z(74)+Z(
     &38)*Z(165)-Z(186)*Z(56)-Z(193)*Z(62)-Z(34)*Z(177)-Z(49)*Z(173)-Z(5
     &3)*Z(181)-Z(57)*Z(187)-Z(60)*Z(194)-Z(64)*Z(204)-Z(72)*Z(215))
      Z(612) = Z(565) + 0.25D0*MB*(Z(566)-4*Z(567)*Z(41)-4*Z(568)*Z(3)) 
     &- MC*(2*Z(569)*Z(3)+2*Z(570)*Z(27)-Z(571)-Z(572)-Z(573)-2*Z(574)*Z
     &(5)) - MD*(2*Z(569)*Z(3)+2*Z(575)*Z(27)+2*Z(576)*Z(235)-Z(571)-Z(5
     &72)-Z(577)-Z(578)-2*Z(579)*Z(5)-2*Z(580)*Z(239)-2*Z(581)*Z(9)) - M
     &E*(2*Z(569)*Z(3)+2*Z(575)*Z(27)+2*Z(582)*Z(235)+2*Z(583)*Z(243)-Z(
     &571)-Z(572)-Z(577)-Z(584)-Z(585)-2*Z(579)*Z(5)-2*Z(586)*Z(239)-2*Z
     &(587)*Z(9)-2*Z(588)*Z(255)-2*Z(589)*Z(247)-2*Z(590)*Z(251)) - MG*(
     &2*Z(569)*Z(3)+2*Z(575)*Z(27)+2*Z(582)*Z(235)+2*L2*GS*Z(107)-Z(571)
     &-Z(572)-Z(577)-Z(584)-GS**2-2*Z(579)*Z(5)-2*Z(586)*Z(239)-2*Z(587)
     &*Z(9)-2*L10*GS*Z(11)-2*L6*GS*Z(112)-2*L8*GS*Z(30)) - MF*(2*Z(591)*
     &Z(15)+2*Z(569)*Z(3)+2*Z(575)*Z(27)+2*Z(582)*Z(235)+2*Z(582)*Z(243)
     &+2*Z(592)*Z(259)-2*Z(584)-Z(571)-Z(572)-Z(577)-Z(593)-2*Z(579)*Z(5
     &)-2*Z(584)*Z(255)-2*Z(586)*Z(239)-2*Z(586)*Z(247)-2*Z(587)*Z(9)-2*
     &Z(587)*Z(251)-2*Z(591)*Z(271)-2*Z(594)*Z(263)-2*Z(595)*Z(267)) - M
     &I*(2*Z(579)*Z(17)+2*Z(587)*Z(15)+2*Z(596)*Z(19)+2*Z(569)*Z(3)+2*Z(
     &569)*Z(275)+2*Z(575)*Z(27)+2*Z(575)*Z(259)+2*Z(582)*Z(235)+2*Z(582
     &)*Z(243)+2*Z(597)*Z(319)-2*Z(572)-2*Z(577)-2*Z(584)-Z(571)-Z(598)-
     &2*Z(572)*Z(283)-2*Z(577)*Z(267)-2*Z(579)*Z(5)-2*Z(579)*Z(263)-2*Z(
     &579)*Z(291)-2*Z(584)*Z(255)-2*Z(586)*Z(239)-2*Z(586)*Z(247)-2*Z(58
     &6)*Z(299)-2*Z(586)*Z(307)-2*Z(587)*Z(9)-2*Z(587)*Z(251)-2*Z(587)*Z
     &(271)-2*Z(596)*Z(323)-2*Z(599)*Z(331)-2*Z(599)*Z(335)-2*Z(600)*Z(3
     &27)-2*Z(600)*Z(339)) - MH*(2*Z(587)*Z(15)+2*Z(601)*Z(17)+2*Z(569)*
     &Z(3)+2*Z(575)*Z(27)+2*Z(575)*Z(259)+2*Z(582)*Z(235)+2*Z(582)*Z(243
     &)+2*Z(602)*Z(275)+2*Z(603)*Z(279)-2*Z(577)-2*Z(584)-2*Z(606)-Z(571
     &)-Z(572)-Z(604)-Z(605)-2*Z(577)*Z(267)-2*Z(579)*Z(5)-2*Z(579)*Z(26
     &3)-2*Z(584)*Z(255)-2*Z(586)*Z(239)-2*Z(586)*Z(247)-2*Z(587)*Z(9)-2
     &*Z(587)*Z(251)-2*Z(587)*Z(271)-2*Z(601)*Z(291)-2*Z(607)*Z(299)-2*Z
     &(607)*Z(307)-2*Z(608)*Z(303)-2*Z(608)*Z(311)-2*Z(609)*Z(283)-2*Z(6
     &10)*Z(287)-2*Z(611)*Z(295)-2*Z(611)*Z(315))
      Z(614) = Z(613) - Z(467)*(L2-L6*Z(3)-L7*Z(27)) - 0.5D0*Z(464)*(2*L
     &2-L3*Z(41)-L4*Z(3)) - Z(470)*(L2-L6*Z(3)-L8*Z(27)-L9*Z(235)) - Z(4
     &74)*(L2-L10*Z(235)-L6*Z(3)-L8*Z(27)-Z(21)*Z(243)) - Z(487)*(L2-L10
     &*Z(235)-L6*Z(3)-L8*Z(27)-GS*Z(107)) - Z(480)*(L2-L10*Z(235)-L10*Z(
     &243)-L6*Z(3)-L8*Z(27)-Z(22)*Z(259)) - Z(493)*(L2-L10*Z(235)-L10*Z(
     &243)-L6*Z(3)-L8*Z(27)-L8*Z(259)-Z(24)*Z(275)-Z(25)*Z(279)) - Z(503
     &)*(L2-L10*Z(235)-L10*Z(243)-L6*Z(3)-L6*Z(275)-L8*Z(27)-L8*Z(259)-Z
     &(26)*Z(319))
      Z(616) = MC*(Z(570)*Z(27)+2*Z(569)*Z(3)-Z(571)-Z(572)-Z(574)*Z(5))
     & + MD*(Z(575)*Z(27)+Z(576)*Z(235)+2*Z(569)*Z(3)-Z(571)-Z(572)-Z(57
     &9)*Z(5)-Z(580)*Z(239)) + ME*(Z(575)*Z(27)+Z(582)*Z(235)+Z(583)*Z(2
     &43)+2*Z(569)*Z(3)-Z(571)-Z(572)-Z(579)*Z(5)-Z(586)*Z(239)-Z(589)*Z
     &(247)) + MG*(Z(575)*Z(27)+Z(582)*Z(235)+2*Z(569)*Z(3)+L2*GS*Z(107)
     &-Z(571)-Z(572)-Z(579)*Z(5)-Z(586)*Z(239)-L6*GS*Z(112)) + MF*(Z(575
     &)*Z(27)+Z(582)*Z(235)+Z(582)*Z(243)+Z(592)*Z(259)+2*Z(569)*Z(3)-Z(
     &571)-Z(572)-Z(579)*Z(5)-Z(586)*Z(239)-Z(586)*Z(247)-Z(594)*Z(263))
     & + MH*(Z(575)*Z(27)+Z(575)*Z(259)+Z(582)*Z(235)+Z(582)*Z(243)+Z(60
     &2)*Z(275)+Z(603)*Z(279)+2*Z(569)*Z(3)-Z(571)-Z(572)-Z(579)*Z(5)-Z(
     &579)*Z(263)-Z(586)*Z(239)-Z(586)*Z(247)-Z(609)*Z(283)-Z(610)*Z(287
     &)) - INA - INB - Z(615) - 0.25D0*MB*(Z(566)-4*Z(567)*Z(41)-4*Z(568
     &)*Z(3)) - MI*(Z(571)+Z(572)+Z(572)*Z(283)+Z(579)*Z(5)+Z(579)*Z(263
     &)+Z(586)*Z(239)+Z(586)*Z(247)+Z(596)*Z(323)-2*Z(569)*Z(3)-Z(569)*Z
     &(275)-Z(575)*Z(27)-Z(575)*Z(259)-Z(582)*Z(235)-Z(582)*Z(243)-Z(597
     &)*Z(319))
      Z(617) = MC*(2*Z(569)*Z(3)+2*Z(570)*Z(27)-Z(571)-Z(572)-Z(573)-2*Z
     &(574)*Z(5)) + MD*(Z(576)*Z(235)+2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z(571
     &)-Z(572)-Z(577)-2*Z(579)*Z(5)-Z(580)*Z(239)-Z(581)*Z(9)) + ME*(Z(5
     &82)*Z(235)+Z(583)*Z(243)+2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z(571)-Z(572
     &)-Z(577)-2*Z(579)*Z(5)-Z(586)*Z(239)-Z(587)*Z(9)-Z(589)*Z(247)-Z(5
     &90)*Z(251)) + MG*(Z(582)*Z(235)+2*Z(569)*Z(3)+2*Z(575)*Z(27)+L2*GS
     &*Z(107)-Z(571)-Z(572)-Z(577)-2*Z(579)*Z(5)-Z(586)*Z(239)-Z(587)*Z(
     &9)-L6*GS*Z(112)-L8*GS*Z(30)) + MF*(Z(582)*Z(235)+Z(582)*Z(243)+Z(5
     &92)*Z(259)+2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z(571)-Z(572)-Z(577)-2*Z(5
     &79)*Z(5)-Z(586)*Z(239)-Z(586)*Z(247)-Z(587)*Z(9)-Z(587)*Z(251)-Z(5
     &94)*Z(263)-Z(595)*Z(267)) + MH*(Z(575)*Z(259)+Z(582)*Z(235)+Z(582)
     &*Z(243)+Z(602)*Z(275)+Z(603)*Z(279)+2*Z(569)*Z(3)+2*Z(575)*Z(27)-Z
     &(571)-Z(572)-Z(577)-2*Z(579)*Z(5)-Z(577)*Z(267)-Z(579)*Z(263)-Z(58
     &6)*Z(239)-Z(586)*Z(247)-Z(587)*Z(9)-Z(587)*Z(251)-Z(601)*Z(291)-Z(
     &609)*Z(283)-Z(610)*Z(287)-Z(611)*Z(295)) + MI*(Z(569)*Z(275)+Z(575
     &)*Z(259)+Z(582)*Z(235)+Z(582)*Z(243)+Z(597)*Z(319)+2*Z(569)*Z(3)+2
     &*Z(575)*Z(27)-Z(571)-Z(572)-Z(577)-2*Z(579)*Z(5)-Z(572)*Z(283)-Z(5
     &77)*Z(267)-Z(579)*Z(263)-Z(579)*Z(291)-Z(586)*Z(239)-Z(586)*Z(247)
     &-Z(587)*Z(9)-Z(587)*Z(251)-Z(596)*Z(323)-Z(600)*Z(327)) - INA - IN
     &B - INC - Z(615) - 0.25D0*MB*(Z(566)-4*Z(567)*Z(41)-4*Z(568)*Z(3))
      Z(618) = MC*(2*Z(569)*Z(3)+2*Z(570)*Z(27)-Z(571)-Z(572)-Z(573)-2*Z
     &(574)*Z(5)) + MD*(2*Z(569)*Z(3)+2*Z(575)*Z(27)+2*Z(576)*Z(235)-Z(5
     &71)-Z(572)-Z(577)-Z(578)-2*Z(579)*Z(5)-2*Z(580)*Z(239)-2*Z(581)*Z(
     &9)) + ME*(Z(583)*Z(243)+2*Z(569)*Z(3)+2*Z(575)*Z(27)+2*Z(582)*Z(23
     &5)-Z(571)-Z(572)-Z(577)-Z(584)-2*Z(579)*Z(5)-2*Z(586)*Z(239)-2*Z(5
     &87)*Z(9)-Z(588)*Z(255)-Z(589)*Z(247)-Z(590)*Z(251)) + MG*(2*Z(569)
     &*Z(3)+2*Z(575)*Z(27)+2*Z(582)*Z(235)+L2*GS*Z(107)-Z(571)-Z(572)-Z(
     &577)-Z(584)-2*Z(579)*Z(5)-2*Z(586)*Z(239)-2*Z(587)*Z(9)-L10*GS*Z(1
     &1)-L6*GS*Z(112)-L8*GS*Z(30)) + MF*(Z(582)*Z(243)+Z(592)*Z(259)+2*Z
     &(569)*Z(3)+2*Z(575)*Z(27)+2*Z(582)*Z(235)-Z(571)-Z(572)-Z(577)-Z(5
     &84)-2*Z(579)*Z(5)-2*Z(586)*Z(239)-2*Z(587)*Z(9)-Z(584)*Z(255)-Z(58
     &6)*Z(247)-Z(587)*Z(251)-Z(591)*Z(271)-Z(594)*Z(263)-Z(595)*Z(267))
     & + MH*(Z(575)*Z(259)+Z(582)*Z(243)+Z(602)*Z(275)+Z(603)*Z(279)+2*Z
     &(569)*Z(3)+2*Z(575)*Z(27)+2*Z(582)*Z(235)-Z(571)-Z(572)-Z(577)-Z(5
     &84)-2*Z(579)*Z(5)-2*Z(586)*Z(239)-2*Z(587)*Z(9)-Z(577)*Z(267)-Z(57
     &9)*Z(263)-Z(584)*Z(255)-Z(586)*Z(247)-Z(587)*Z(251)-Z(587)*Z(271)-
     &Z(601)*Z(291)-Z(607)*Z(299)-Z(608)*Z(303)-Z(609)*Z(283)-Z(610)*Z(2
     &87)-Z(611)*Z(295)) + MI*(Z(569)*Z(275)+Z(575)*Z(259)+Z(582)*Z(243)
     &+Z(597)*Z(319)+2*Z(569)*Z(3)+2*Z(575)*Z(27)+2*Z(582)*Z(235)-Z(571)
     &-Z(572)-Z(577)-Z(584)-2*Z(579)*Z(5)-2*Z(586)*Z(239)-2*Z(587)*Z(9)-
     &Z(572)*Z(283)-Z(577)*Z(267)-Z(579)*Z(263)-Z(579)*Z(291)-Z(584)*Z(2
     &55)-Z(586)*Z(247)-Z(586)*Z(299)-Z(587)*Z(251)-Z(587)*Z(271)-Z(596)
     &*Z(323)-Z(599)*Z(331)-Z(600)*Z(327)) - INA - INB - INC - IND - Z(6
     &15) - 0.25D0*MB*(Z(566)-4*Z(567)*Z(41)-4*Z(568)*Z(3))
      Z(625) = Z(547) + Z(549) + Z(551) + 0.25D0*MB*(Z(619)*Z(168)+2*L2*
     &Z(4)*Z(168)+2*L2*Z(42)*Z(169)+2*L3*Z(43)*Z(165)-Z(620)*Z(169)-2*L4
     &*Z(4)*Z(165)) + MD*(L2*Z(4)*Z(173)+L2*Z(29)*Z(177)+L2*Z(234)*Z(179
     &)+L8*Z(6)*Z(173)+L8*Z(28)*Z(165)+L9*Z(10)*Z(177)+L9*Z(233)*Z(165)-
     &L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(238)*Z(179)-L8*Z(10)*Z(179)-L9*
     &Z(237)*Z(173)) + MG*(GS*Z(198)+L10*Z(10)*Z(177)+L10*Z(11)*Z(198)+L
     &10*Z(12)*Z(197)+L10*Z(233)*Z(165)+L2*Z(4)*Z(173)+L2*Z(29)*Z(177)+L
     &2*Z(234)*Z(181)+L6*Z(110)*Z(197)+L6*Z(112)*Z(198)+L8*Z(6)*Z(173)+L
     &8*Z(28)*Z(165)+L8*Z(30)*Z(198)+L8*Z(32)*Z(197)+GS*Z(12)*Z(181)+GS*
     &Z(106)*Z(165)-L10*Z(237)*Z(173)-L2*Z(105)*Z(197)-L2*Z(107)*Z(198)-
     &L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(238)*Z(181)-L8*Z(10)*Z(181)-GS*
     &Z(31)*Z(177)-GS*Z(111)*Z(173)) + ME*(L2*Z(183)*Z(243)+L10*Z(10)*Z(
     &177)+L10*Z(233)*Z(165)+L2*Z(4)*Z(173)+L2*Z(29)*Z(177)+L2*Z(234)*Z(
     &181)+L2*Z(242)*Z(184)+L8*Z(6)*Z(173)+L8*Z(28)*Z(165)+Z(21)*Z(241)*
     &Z(165)-Z(21)*Z(183)-L10*Z(183)*Z(255)-L6*Z(183)*Z(247)-L8*Z(183)*Z
     &(251)-L10*Z(237)*Z(173)-L10*Z(254)*Z(184)-L6*Z(4)*Z(165)-L6*Z(6)*Z
     &(177)-L6*Z(238)*Z(181)-L6*Z(246)*Z(184)-L8*Z(10)*Z(181)-L8*Z(250)*
     &Z(184)-Z(21)*Z(245)*Z(173)-Z(21)*Z(249)*Z(177)-Z(21)*Z(253)*Z(181)
     &) + MF*(L10*Z(15)*Z(189)+Z(22)*Z(15)*Z(186)+L2*Z(186)*Z(243)+L2*Z(
     &189)*Z(259)+L10*Z(16)*Z(191)+L10*Z(10)*Z(177)+L10*Z(233)*Z(165)+L1
     &0*Z(241)*Z(165)+L2*Z(4)*Z(173)+L2*Z(29)*Z(177)+L2*Z(234)*Z(181)+L2
     &*Z(242)*Z(187)+L2*Z(258)*Z(191)+L8*Z(6)*Z(173)+L8*Z(28)*Z(165)+Z(2
     &2)*Z(257)*Z(165)-L10*Z(186)-Z(22)*Z(189)-L10*Z(186)*Z(255)-L10*Z(1
     &89)*Z(271)-L6*Z(186)*Z(247)-L6*Z(189)*Z(263)-L8*Z(186)*Z(251)-L8*Z
     &(189)*Z(267)-L10*Z(237)*Z(173)-L10*Z(245)*Z(173)-L10*Z(249)*Z(177)
     &-L10*Z(253)*Z(181)-L10*Z(254)*Z(187)-L10*Z(270)*Z(191)-L6*Z(4)*Z(1
     &65)-L6*Z(6)*Z(177)-L6*Z(238)*Z(181)-L6*Z(246)*Z(187)-L6*Z(262)*Z(1
     &91)-L8*Z(10)*Z(181)-L8*Z(250)*Z(187)-L8*Z(266)*Z(191)-Z(22)*Z(16)*
     &Z(187)-Z(22)*Z(261)*Z(173)-Z(22)*Z(265)*Z(177)-Z(22)*Z(269)*Z(181)
     &) + MH*(Z(24)*Z(208)+Z(25)*Z(209)+Z(621)*Z(209)+Z(622)*Z(208)+L10*
     &Z(15)*Z(193)+L8*Z(15)*Z(186)+Z(24)*Z(17)*Z(193)+L10*Z(208)*Z(299)+
     &L10*Z(208)*Z(307)+L10*Z(209)*Z(303)+L10*Z(209)*Z(311)+L2*Z(186)*Z(
     &243)+L2*Z(193)*Z(259)+L6*Z(208)*Z(283)+L6*Z(209)*Z(287)+L8*Z(208)*
     &Z(291)+L8*Z(209)*Z(295)+L8*Z(209)*Z(315)+Z(623)*Z(210)+L10*Z(16)*Z
     &(194)+L10*Z(10)*Z(177)+L10*Z(233)*Z(165)+L10*Z(241)*Z(165)+L2*Z(4)
     &*Z(173)+L2*Z(29)*Z(177)+L2*Z(234)*Z(181)+L2*Z(242)*Z(187)+L2*Z(258
     &)*Z(194)+L2*Z(274)*Z(210)+L2*Z(278)*Z(211)+L8*Z(6)*Z(173)+L8*Z(28)
     &*Z(165)+L8*Z(257)*Z(165)+Z(24)*Z(18)*Z(194)+Z(24)*Z(273)*Z(165)+Z(
     &25)*Z(277)*Z(165)-L10*Z(186)-L8*Z(193)-L8*Z(17)*Z(208)-L10*Z(186)*
     &Z(255)-L10*Z(193)*Z(271)-L2*Z(208)*Z(275)-L2*Z(209)*Z(279)-L6*Z(18
     &6)*Z(247)-L6*Z(193)*Z(263)-L8*Z(186)*Z(251)-L8*Z(193)*Z(267)-Z(24)
     &*Z(186)*Z(307)-Z(25)*Z(186)*Z(311)-Z(25)*Z(193)*Z(315)-Z(624)*Z(21
     &1)-L10*Z(237)*Z(173)-L10*Z(245)*Z(173)-L10*Z(249)*Z(177)-L10*Z(253
     &)*Z(181)-L10*Z(254)*Z(187)-L10*Z(270)*Z(194)-L10*Z(298)*Z(210)-L10
     &*Z(302)*Z(211)-L10*Z(306)*Z(210)-L10*Z(310)*Z(211)-L6*Z(4)*Z(165)-
     &L6*Z(6)*Z(177)-L6*Z(238)*Z(181)-L6*Z(246)*Z(187)-L6*Z(262)*Z(194)-
     &L6*Z(282)*Z(210)-L6*Z(286)*Z(211)-L8*Z(16)*Z(187)-L8*Z(18)*Z(210)-
     &L8*Z(10)*Z(181)-L8*Z(250)*Z(187)-L8*Z(261)*Z(173)-L8*Z(265)*Z(177)
     &-L8*Z(266)*Z(194)-L8*Z(269)*Z(181)-L8*Z(290)*Z(210)-L8*Z(294)*Z(21
     &1)-L8*Z(314)*Z(211)-Z(24)*Z(281)*Z(173)-Z(24)*Z(289)*Z(177)-Z(24)*
     &Z(297)*Z(181)-Z(24)*Z(305)*Z(187)-Z(25)*Z(285)*Z(173)-Z(25)*Z(293)
     &*Z(177)-Z(25)*Z(301)*Z(181)-Z(25)*Z(309)*Z(187)-Z(25)*Z(313)*Z(194
     &)) + MI*(L6*Z(201)+Z(26)*Z(213)+L10*Z(15)*Z(193)+L6*Z(17)*Z(193)+L
     &8*Z(15)*Z(186)+L10*Z(201)*Z(299)+L10*Z(201)*Z(307)+L10*Z(213)*Z(33
     &1)+L10*Z(213)*Z(335)+L2*Z(186)*Z(243)+L2*Z(193)*Z(259)+L6*Z(201)*Z
     &(283)+L6*Z(213)*Z(323)+L8*Z(201)*Z(291)+L8*Z(213)*Z(327)+L8*Z(213)
     &*Z(339)+L10*Z(16)*Z(194)+L10*Z(10)*Z(177)+L10*Z(233)*Z(165)+L10*Z(
     &241)*Z(165)+L2*Z(4)*Z(173)+L2*Z(29)*Z(177)+L2*Z(234)*Z(181)+L2*Z(2
     &42)*Z(187)+L2*Z(258)*Z(194)+L2*Z(274)*Z(204)+L2*Z(318)*Z(215)+L6*Z
     &(18)*Z(194)+L6*Z(273)*Z(165)+L8*Z(6)*Z(173)+L8*Z(28)*Z(165)+L8*Z(2
     &57)*Z(165)+Z(26)*Z(20)*Z(204)+Z(26)*Z(317)*Z(165)-L10*Z(186)-L8*Z(
     &193)-L6*Z(19)*Z(213)-L8*Z(17)*Z(201)-Z(26)*Z(19)*Z(201)-L10*Z(186)
     &*Z(255)-L10*Z(193)*Z(271)-L2*Z(201)*Z(275)-L2*Z(213)*Z(319)-L6*Z(1
     &86)*Z(247)-L6*Z(186)*Z(307)-L6*Z(193)*Z(263)-L8*Z(186)*Z(251)-L8*Z
     &(193)*Z(267)-Z(26)*Z(186)*Z(335)-Z(26)*Z(193)*Z(339)-L10*Z(237)*Z(
     &173)-L10*Z(245)*Z(173)-L10*Z(249)*Z(177)-L10*Z(253)*Z(181)-L10*Z(2
     &54)*Z(187)-L10*Z(270)*Z(194)-L10*Z(298)*Z(204)-L10*Z(306)*Z(204)-L
     &10*Z(330)*Z(215)-L10*Z(334)*Z(215)-L6*Z(20)*Z(215)-L6*Z(4)*Z(165)-
     &L6*Z(6)*Z(177)-L6*Z(238)*Z(181)-L6*Z(246)*Z(187)-L6*Z(262)*Z(194)-
     &L6*Z(281)*Z(173)-L6*Z(282)*Z(204)-L6*Z(289)*Z(177)-L6*Z(297)*Z(181
     &)-L6*Z(305)*Z(187)-L6*Z(322)*Z(215)-L8*Z(16)*Z(187)-L8*Z(18)*Z(204
     &)-L8*Z(10)*Z(181)-L8*Z(250)*Z(187)-L8*Z(261)*Z(173)-L8*Z(265)*Z(17
     &7)-L8*Z(266)*Z(194)-L8*Z(269)*Z(181)-L8*Z(290)*Z(204)-L8*Z(326)*Z(
     &215)-L8*Z(338)*Z(215)-Z(26)*Z(321)*Z(173)-Z(26)*Z(325)*Z(177)-Z(26
     &)*Z(329)*Z(181)-Z(26)*Z(333)*Z(187)-Z(26)*Z(337)*Z(194)) - Z(545) 
     &- MC*(L6*Z(4)*Z(165)+L6*Z(6)*Z(175)-L2*Z(4)*Z(173)-L2*Z(29)*Z(175)
     &-L7*Z(6)*Z(173)-L7*Z(28)*Z(165))
      Z(631) = L2*(MB*(Z(4)*Z(168)+Z(42)*Z(169))+2*MC*(Z(4)*Z(173)+Z(29)
     &*Z(175))+2*MD*(Z(4)*Z(173)+Z(29)*Z(177)+Z(234)*Z(179))+2*ME*(Z(183
     &)*Z(243)+Z(4)*Z(173)+Z(29)*Z(177)+Z(234)*Z(181)+Z(242)*Z(184))+2*M
     &F*(Z(186)*Z(243)+Z(189)*Z(259)+Z(4)*Z(173)+Z(29)*Z(177)+Z(234)*Z(1
     &81)+Z(242)*Z(187)+Z(258)*Z(191))-2*MG*(Z(105)*Z(197)+Z(107)*Z(198)
     &-Z(4)*Z(173)-Z(29)*Z(177)-Z(234)*Z(181))-2*MH*(Z(208)*Z(275)+Z(209
     &)*Z(279)-Z(186)*Z(243)-Z(193)*Z(259)-Z(4)*Z(173)-Z(29)*Z(177)-Z(23
     &4)*Z(181)-Z(242)*Z(187)-Z(258)*Z(194)-Z(274)*Z(210)-Z(278)*Z(211))
     &-2*MI*(Z(201)*Z(275)+Z(213)*Z(319)-Z(186)*Z(243)-Z(193)*Z(259)-Z(4
     &)*Z(173)-Z(29)*Z(177)-Z(234)*Z(181)-Z(242)*Z(187)-Z(258)*Z(194)-Z(
     &274)*Z(204)-Z(318)*Z(215)))
      Z(637) = -MC*(L2*Z(4)*Z(173)+L2*Z(29)*Z(175)-L6*Z(4)*Z(165)-L6*Z(6
     &)*Z(175)) - MD*(L2*Z(4)*Z(173)+L2*Z(29)*Z(177)+L2*Z(234)*Z(179)-L6
     &*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(238)*Z(179)) - 0.25D0*MB*(Z(619)*
     &Z(168)+2*L2*Z(4)*Z(168)+2*L2*Z(42)*Z(169)+2*L3*Z(43)*Z(165)-Z(620)
     &*Z(169)-2*L4*Z(4)*Z(165)) - ME*(L2*Z(183)*Z(243)+L2*Z(4)*Z(173)+L2
     &*Z(29)*Z(177)+L2*Z(234)*Z(181)+L2*Z(242)*Z(184)-L6*Z(183)*Z(247)-L
     &6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(238)*Z(181)-L6*Z(246)*Z(184)) - 
     &MG*(L2*Z(4)*Z(173)+L2*Z(29)*Z(177)+L2*Z(234)*Z(181)+L6*Z(110)*Z(19
     &7)+L6*Z(112)*Z(198)-L2*Z(105)*Z(197)-L2*Z(107)*Z(198)-L6*Z(4)*Z(16
     &5)-L6*Z(6)*Z(177)-L6*Z(238)*Z(181)) - MF*(L2*Z(186)*Z(243)+L2*Z(18
     &9)*Z(259)+L2*Z(4)*Z(173)+L2*Z(29)*Z(177)+L2*Z(234)*Z(181)+L2*Z(242
     &)*Z(187)+L2*Z(258)*Z(191)-L6*Z(186)*Z(247)-L6*Z(189)*Z(263)-L6*Z(4
     &)*Z(165)-L6*Z(6)*Z(177)-L6*Z(238)*Z(181)-L6*Z(246)*Z(187)-L6*Z(262
     &)*Z(191)) - MH*(L2*Z(186)*Z(243)+L2*Z(193)*Z(259)+L6*Z(208)*Z(283)
     &+L6*Z(209)*Z(287)+L2*Z(4)*Z(173)+L2*Z(29)*Z(177)+L2*Z(234)*Z(181)+
     &L2*Z(242)*Z(187)+L2*Z(258)*Z(194)+L2*Z(274)*Z(210)+L2*Z(278)*Z(211
     &)-L2*Z(208)*Z(275)-L2*Z(209)*Z(279)-L6*Z(186)*Z(247)-L6*Z(193)*Z(2
     &63)-L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(238)*Z(181)-L6*Z(246)*Z(187
     &)-L6*Z(262)*Z(194)-L6*Z(282)*Z(210)-L6*Z(286)*Z(211)) - MI*(L2*Z(1
     &86)*Z(243)+L2*Z(193)*Z(259)+L6*Z(201)*Z(283)+L6*Z(213)*Z(323)+L2*Z
     &(4)*Z(173)+L2*Z(29)*Z(177)+L2*Z(234)*Z(181)+L2*Z(242)*Z(187)+L2*Z(
     &258)*Z(194)+L2*Z(274)*Z(204)+L2*Z(318)*Z(215)-L2*Z(201)*Z(275)-L2*
     &Z(213)*Z(319)-L6*Z(186)*Z(247)-L6*Z(193)*Z(263)-L6*Z(4)*Z(165)-L6*
     &Z(6)*Z(177)-L6*Z(238)*Z(181)-L6*Z(246)*Z(187)-L6*Z(262)*Z(194)-L6*
     &Z(282)*Z(204)-L6*Z(322)*Z(215))
      Z(641) = MC*(L6*Z(4)*Z(165)+L6*Z(6)*Z(175)-L2*Z(4)*Z(173)-L2*Z(29)
     &*Z(175)-L7*Z(6)*Z(173)-L7*Z(28)*Z(165)) + MD*(L6*Z(4)*Z(165)+L6*Z(
     &6)*Z(177)+L6*Z(238)*Z(179)+L8*Z(10)*Z(179)-L2*Z(4)*Z(173)-L2*Z(29)
     &*Z(177)-L2*Z(234)*Z(179)-L8*Z(6)*Z(173)-L8*Z(28)*Z(165)) + MG*(L2*
     &Z(105)*Z(197)+L2*Z(107)*Z(198)+L6*Z(4)*Z(165)+L6*Z(6)*Z(177)+L6*Z(
     &238)*Z(181)+L8*Z(10)*Z(181)-L2*Z(4)*Z(173)-L2*Z(29)*Z(177)-L2*Z(23
     &4)*Z(181)-L6*Z(110)*Z(197)-L6*Z(112)*Z(198)-L8*Z(6)*Z(173)-L8*Z(28
     &)*Z(165)-L8*Z(30)*Z(198)-L8*Z(32)*Z(197)) - 0.25D0*MB*(Z(619)*Z(16
     &8)+2*L2*Z(4)*Z(168)+2*L2*Z(42)*Z(169)+2*L3*Z(43)*Z(165)-Z(620)*Z(1
     &69)-2*L4*Z(4)*Z(165)) - ME*(L2*Z(183)*Z(243)+L2*Z(4)*Z(173)+L2*Z(2
     &9)*Z(177)+L2*Z(234)*Z(181)+L2*Z(242)*Z(184)+L8*Z(6)*Z(173)+L8*Z(28
     &)*Z(165)-L6*Z(183)*Z(247)-L8*Z(183)*Z(251)-L6*Z(4)*Z(165)-L6*Z(6)*
     &Z(177)-L6*Z(238)*Z(181)-L6*Z(246)*Z(184)-L8*Z(10)*Z(181)-L8*Z(250)
     &*Z(184)) - MF*(L2*Z(186)*Z(243)+L2*Z(189)*Z(259)+L2*Z(4)*Z(173)+L2
     &*Z(29)*Z(177)+L2*Z(234)*Z(181)+L2*Z(242)*Z(187)+L2*Z(258)*Z(191)+L
     &8*Z(6)*Z(173)+L8*Z(28)*Z(165)-L6*Z(186)*Z(247)-L6*Z(189)*Z(263)-L8
     &*Z(186)*Z(251)-L8*Z(189)*Z(267)-L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z
     &(238)*Z(181)-L6*Z(246)*Z(187)-L6*Z(262)*Z(191)-L8*Z(10)*Z(181)-L8*
     &Z(250)*Z(187)-L8*Z(266)*Z(191)) - MH*(L2*Z(186)*Z(243)+L2*Z(193)*Z
     &(259)+L6*Z(208)*Z(283)+L6*Z(209)*Z(287)+L8*Z(208)*Z(291)+L8*Z(209)
     &*Z(295)+L2*Z(4)*Z(173)+L2*Z(29)*Z(177)+L2*Z(234)*Z(181)+L2*Z(242)*
     &Z(187)+L2*Z(258)*Z(194)+L2*Z(274)*Z(210)+L2*Z(278)*Z(211)+L8*Z(6)*
     &Z(173)+L8*Z(28)*Z(165)-L2*Z(208)*Z(275)-L2*Z(209)*Z(279)-L6*Z(186)
     &*Z(247)-L6*Z(193)*Z(263)-L8*Z(186)*Z(251)-L8*Z(193)*Z(267)-L6*Z(4)
     &*Z(165)-L6*Z(6)*Z(177)-L6*Z(238)*Z(181)-L6*Z(246)*Z(187)-L6*Z(262)
     &*Z(194)-L6*Z(282)*Z(210)-L6*Z(286)*Z(211)-L8*Z(10)*Z(181)-L8*Z(250
     &)*Z(187)-L8*Z(266)*Z(194)-L8*Z(290)*Z(210)-L8*Z(294)*Z(211)) - MI*
     &(L2*Z(186)*Z(243)+L2*Z(193)*Z(259)+L6*Z(201)*Z(283)+L6*Z(213)*Z(32
     &3)+L8*Z(201)*Z(291)+L8*Z(213)*Z(327)+L2*Z(4)*Z(173)+L2*Z(29)*Z(177
     &)+L2*Z(234)*Z(181)+L2*Z(242)*Z(187)+L2*Z(258)*Z(194)+L2*Z(274)*Z(2
     &04)+L2*Z(318)*Z(215)+L8*Z(6)*Z(173)+L8*Z(28)*Z(165)-L2*Z(201)*Z(27
     &5)-L2*Z(213)*Z(319)-L6*Z(186)*Z(247)-L6*Z(193)*Z(263)-L8*Z(186)*Z(
     &251)-L8*Z(193)*Z(267)-L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(238)*Z(18
     &1)-L6*Z(246)*Z(187)-L6*Z(262)*Z(194)-L6*Z(282)*Z(204)-L6*Z(322)*Z(
     &215)-L8*Z(10)*Z(181)-L8*Z(250)*Z(187)-L8*Z(266)*Z(194)-L8*Z(290)*Z
     &(204)-L8*Z(326)*Z(215))
      Z(644) = MC*(L6*Z(4)*Z(165)+L6*Z(6)*Z(175)-L2*Z(4)*Z(173)-L2*Z(29)
     &*Z(175)-L7*Z(6)*Z(173)-L7*Z(28)*Z(165)) + MG*(L10*Z(237)*Z(173)+L2
     &*Z(105)*Z(197)+L2*Z(107)*Z(198)+L6*Z(4)*Z(165)+L6*Z(6)*Z(177)+L6*Z
     &(238)*Z(181)+L8*Z(10)*Z(181)-L10*Z(10)*Z(177)-L10*Z(11)*Z(198)-L10
     &*Z(12)*Z(197)-L10*Z(233)*Z(165)-L2*Z(4)*Z(173)-L2*Z(29)*Z(177)-L2*
     &Z(234)*Z(181)-L6*Z(110)*Z(197)-L6*Z(112)*Z(198)-L8*Z(6)*Z(173)-L8*
     &Z(28)*Z(165)-L8*Z(30)*Z(198)-L8*Z(32)*Z(197)) - 0.25D0*MB*(Z(619)*
     &Z(168)+2*L2*Z(4)*Z(168)+2*L2*Z(42)*Z(169)+2*L3*Z(43)*Z(165)-Z(620)
     &*Z(169)-2*L4*Z(4)*Z(165)) - MD*(L2*Z(4)*Z(173)+L2*Z(29)*Z(177)+L2*
     &Z(234)*Z(179)+L8*Z(6)*Z(173)+L8*Z(28)*Z(165)+L9*Z(10)*Z(177)+L9*Z(
     &233)*Z(165)-L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(238)*Z(179)-L8*Z(10
     &)*Z(179)-L9*Z(237)*Z(173)) - ME*(L2*Z(183)*Z(243)+L10*Z(10)*Z(177)
     &+L10*Z(233)*Z(165)+L2*Z(4)*Z(173)+L2*Z(29)*Z(177)+L2*Z(234)*Z(181)
     &+L2*Z(242)*Z(184)+L8*Z(6)*Z(173)+L8*Z(28)*Z(165)-L10*Z(183)*Z(255)
     &-L6*Z(183)*Z(247)-L8*Z(183)*Z(251)-L10*Z(237)*Z(173)-L10*Z(254)*Z(
     &184)-L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(238)*Z(181)-L6*Z(246)*Z(18
     &4)-L8*Z(10)*Z(181)-L8*Z(250)*Z(184)) - MF*(L2*Z(186)*Z(243)+L2*Z(1
     &89)*Z(259)+L10*Z(10)*Z(177)+L10*Z(233)*Z(165)+L2*Z(4)*Z(173)+L2*Z(
     &29)*Z(177)+L2*Z(234)*Z(181)+L2*Z(242)*Z(187)+L2*Z(258)*Z(191)+L8*Z
     &(6)*Z(173)+L8*Z(28)*Z(165)-L10*Z(186)*Z(255)-L10*Z(189)*Z(271)-L6*
     &Z(186)*Z(247)-L6*Z(189)*Z(263)-L8*Z(186)*Z(251)-L8*Z(189)*Z(267)-L
     &10*Z(237)*Z(173)-L10*Z(254)*Z(187)-L10*Z(270)*Z(191)-L6*Z(4)*Z(165
     &)-L6*Z(6)*Z(177)-L6*Z(238)*Z(181)-L6*Z(246)*Z(187)-L6*Z(262)*Z(191
     &)-L8*Z(10)*Z(181)-L8*Z(250)*Z(187)-L8*Z(266)*Z(191)) - MH*(L10*Z(2
     &08)*Z(299)+L10*Z(209)*Z(303)+L2*Z(186)*Z(243)+L2*Z(193)*Z(259)+L6*
     &Z(208)*Z(283)+L6*Z(209)*Z(287)+L8*Z(208)*Z(291)+L8*Z(209)*Z(295)+L
     &10*Z(10)*Z(177)+L10*Z(233)*Z(165)+L2*Z(4)*Z(173)+L2*Z(29)*Z(177)+L
     &2*Z(234)*Z(181)+L2*Z(242)*Z(187)+L2*Z(258)*Z(194)+L2*Z(274)*Z(210)
     &+L2*Z(278)*Z(211)+L8*Z(6)*Z(173)+L8*Z(28)*Z(165)-L10*Z(186)*Z(255)
     &-L10*Z(193)*Z(271)-L2*Z(208)*Z(275)-L2*Z(209)*Z(279)-L6*Z(186)*Z(2
     &47)-L6*Z(193)*Z(263)-L8*Z(186)*Z(251)-L8*Z(193)*Z(267)-L10*Z(237)*
     &Z(173)-L10*Z(254)*Z(187)-L10*Z(270)*Z(194)-L10*Z(298)*Z(210)-L10*Z
     &(302)*Z(211)-L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(238)*Z(181)-L6*Z(2
     &46)*Z(187)-L6*Z(262)*Z(194)-L6*Z(282)*Z(210)-L6*Z(286)*Z(211)-L8*Z
     &(10)*Z(181)-L8*Z(250)*Z(187)-L8*Z(266)*Z(194)-L8*Z(290)*Z(210)-L8*
     &Z(294)*Z(211)) - MI*(L10*Z(201)*Z(299)+L10*Z(213)*Z(331)+L2*Z(186)
     &*Z(243)+L2*Z(193)*Z(259)+L6*Z(201)*Z(283)+L6*Z(213)*Z(323)+L8*Z(20
     &1)*Z(291)+L8*Z(213)*Z(327)+L10*Z(10)*Z(177)+L10*Z(233)*Z(165)+L2*Z
     &(4)*Z(173)+L2*Z(29)*Z(177)+L2*Z(234)*Z(181)+L2*Z(242)*Z(187)+L2*Z(
     &258)*Z(194)+L2*Z(274)*Z(204)+L2*Z(318)*Z(215)+L8*Z(6)*Z(173)+L8*Z(
     &28)*Z(165)-L10*Z(186)*Z(255)-L10*Z(193)*Z(271)-L2*Z(201)*Z(275)-L2
     &*Z(213)*Z(319)-L6*Z(186)*Z(247)-L6*Z(193)*Z(263)-L8*Z(186)*Z(251)-
     &L8*Z(193)*Z(267)-L10*Z(237)*Z(173)-L10*Z(254)*Z(187)-L10*Z(270)*Z(
     &194)-L10*Z(298)*Z(204)-L10*Z(330)*Z(215)-L6*Z(4)*Z(165)-L6*Z(6)*Z(
     &177)-L6*Z(238)*Z(181)-L6*Z(246)*Z(187)-L6*Z(262)*Z(194)-L6*Z(282)*
     &Z(204)-L6*Z(322)*Z(215)-L8*Z(10)*Z(181)-L8*Z(250)*Z(187)-L8*Z(266)
     &*Z(194)-L8*Z(290)*Z(204)-L8*Z(326)*Z(215))
      Z(681) = Z(512) - Z(558)
      Z(682) = Z(514) - Z(564)
      Z(683) = Z(516) - Z(625)
      Z(684) = Z(525) + 0.5D0*Z(631)
      Z(685) = Z(526) - Z(637)
      Z(686) = Z(527) - Z(641)
      Z(687) = Z(528) - Z(644)

      COEF(1,1) = -Z(75)
      COEF(1,2) = 0
      COEF(1,3) = -Z(552)
      COEF(1,4) = -Z(554)
      COEF(1,5) = -Z(555)
      COEF(1,6) = -Z(556)
      COEF(1,7) = -Z(557)
      COEF(2,1) = 0
      COEF(2,2) = -Z(75)
      COEF(2,3) = -Z(559)
      COEF(2,4) = -Z(560)
      COEF(2,5) = -Z(561)
      COEF(2,6) = -Z(562)
      COEF(2,7) = -Z(563)
      COEF(3,1) = -Z(552)
      COEF(3,2) = -Z(559)
      COEF(3,3) = -Z(612)
      COEF(3,4) = -Z(614)
      COEF(3,5) = -Z(616)
      COEF(3,6) = -Z(617)
      COEF(3,7) = -Z(618)
      COEF(4,1) = -Z(554)
      COEF(4,2) = -Z(560)
      COEF(4,3) = -Z(614)
      COEF(4,4) = -Z(626)
      COEF(4,5) = -Z(628)
      COEF(4,6) = -Z(629)
      COEF(4,7) = -Z(630)
      COEF(5,1) = -Z(555)
      COEF(5,2) = -Z(561)
      COEF(5,3) = -Z(616)
      COEF(5,4) = -Z(628)
      COEF(5,5) = -Z(634)
      COEF(5,6) = -Z(635)
      COEF(5,7) = -Z(636)
      COEF(6,1) = -Z(556)
      COEF(6,2) = -Z(562)
      COEF(6,3) = -Z(617)
      COEF(6,4) = -Z(629)
      COEF(6,5) = -Z(635)
      COEF(6,6) = -Z(639)
      COEF(6,7) = -Z(640)
      COEF(7,1) = -Z(557)
      COEF(7,2) = -Z(563)
      COEF(7,3) = -Z(618)
      COEF(7,4) = -Z(630)
      COEF(7,5) = -Z(636)
      COEF(7,6) = -Z(640)
      COEF(7,7) = -Z(643)
      RHS(1) = -Z(681)
      RHS(2) = -Z(682)
      RHS(3) = -Z(683)
      RHS(4) = -Z(684)
      RHS(5) = -Z(685)
      RHS(6) = -Z(686)
      RHS(7) = -Z(687)
      CALL SOLVE(7,COEF,RHS,VARp)

C**   Update variables after uncoupling equations
      U1p = VARp(1)
      U2p = VARp(2)
      U3p = VARp(3)
      U4p = VARp(4)
      U5p = VARp(5)
      U6p = VARp(6)
      U7p = VARp(7)

C**   Update derivative array prior to integration step
      VARp(1) = Q1p
      VARp(2) = Q2p
      VARp(3) = Q3p
      VARp(4) = Q4p
      VARp(5) = Q5p
      VARp(6) = Q6p
      VARp(7) = Q7p
      VARp(8) = U1p
      VARp(9) = U2p
      VARp(10) = U3p
      VARp(11) = U4p
      VARp(12) = U5p
      VARp(13) = U6p
      VARp(14) = U7p

      RETURN
      END


C**********************************************************************
      SUBROUTINE       IO(T)
      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          ILOOP
      COMMON/CONSTNTS/ AE,AF,FOOTANG,G,HE,HF,INA,INB,INC,IND,INE,INF,ING
     &,INH,INI,K1,K2,K3,K4,K5,K6,K7,K8,KE,KF,L1,L10,L2,L3,L4,L5,L6,L7,L8
     &,L9,MA,MB,MC,MD,ME,MF,MG,MH,MI,MTPB,MTPK,POP1XI,POP2XI
      COMMON/SPECFIED/ EA,FA,GS,HA,IA,EAp,FAp,GSp,HAp,IAp,EApp,FApp,GSpp
     &,HApp,IApp
      COMMON/VARIBLES/ Q1,Q2,Q3,Q4,Q5,Q6,Q7,U1,U2,U3,U4,U5,U6,U7
      COMMON/ALGBRAIC/ AANG,AANGVEL,AETOR,AFTOR,ATOR,HANG,HANGVEL,HETOR,
     &HFTOR,HTOR,HZ,KANG,KANGVEL,KECM,KETOR,KFTOR,KTOR,MANG,MANGVEL,MTOR
     &,PECM,PX,PY,RX1,RX2,RY1,RY2,SATOR,SHANG,SHANGVEL,SHTOR,SKANG,SKANG
     &VEL,SKTOR,SMTOR,TE,U10,U11,U8,U9,VRX1,VRX2,VRY1,VRY2,Q1p,Q2p,Q3p,Q
     &4p,Q5p,Q6p,Q7p,U1p,U2p,U3p,U4p,U5p,U6p,U7p,DP1X,DP2X,MT,POCMSTANCE
     &X,POCMSTANCEY,POCMSWINGX,POCMSWINGY,POCMX,POCMY,POGOX,POGOY,POP10X
     &,POP10Y,POP11X,POP11Y,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,PO
     &P4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,PS
     &TANCEX,PSTANCEY,PSWINGX,PSWINGY,SAANG,SAANGVEL,SMANG,SMANGVEL,VOCM
     &STANCEX,VOCMSTANCEY,VOCMSWINGX,VOCMSWINGY,VOCMX,VOCMY,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(691),COEF(7,7),RHS(7)

C**   Evaluate output quantities
      KECM = 0.5D0*ING*U3**2 + 0.5D0*IND*(U3-U7)**2 + 0.5D0*INC*(U3-U6-U
     &7)**2 + 0.5D0*INE*(EAp-U3-U8)**2 + 0.5D0*INB*(U3-U5-U6-U7)**2 + 0.
     &5D0*INA*(U3-U4-U5-U6-U7)**2 + 0.5D0*INF*(EAp-FAp-U3-U8-U9)**2 + 0.
     &5D0*INH*(EAp+HAp-FAp-U10-U3-U8-U9)**2 + 0.5D0*INI*(EAp+HAp+IAp-FAp
     &-U10-U11-U3-U8-U9)**2 + 0.5D0*MC*(U1**2+U2**2+L7**2*(U3-U6-U7)**2+
     &2*L7*Z(35)*U1*(U3-U6-U7)+2*L7*Z(36)*U2*(U3-U6-U7)+L6**2*(U3-U5-U6-
     &U7)**2+2*L6*Z(50)*U1*(U3-U5-U6-U7)+2*L6*Z(51)*U2*(U3-U5-U6-U7)+L2*
     &*2*(U3-U4-U5-U6-U7)**2+2*L6*L7*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-2*L2*
     &Z(39)*U1*(U3-U4-U5-U6-U7)-2*L2*Z(40)*U2*(U3-U4-U5-U6-U7)-2*L2*L7*Z
     &(27)*(U3-U6-U7)*(U3-U4-U5-U6-U7)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4
     &-U5-U6-U7)) + 0.125D0*MB*(4*U1**2+4*U2**2+L3**2*(U3-U5-U6-U7)**2+L
     &4**2*(U3-U5-U6-U7)**2+4*L3*Z(46)*U1*(U3-U5-U6-U7)+4*L3*Z(47)*U2*(U
     &3-U5-U6-U7)+4*L4*Z(50)*U1*(U3-U5-U6-U7)+4*L4*Z(51)*U2*(U3-U5-U6-U7
     &)+2*L3*L4*Z(7)*(U3-U5-U6-U7)**2+4*L2**2*(U3-U4-U5-U6-U7)**2-8*L2*Z
     &(39)*U1*(U3-U4-U5-U6-U7)-8*L2*Z(40)*U2*(U3-U4-U5-U6-U7)-4*L2*L3*Z(
     &41)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)-4*L2*L4*Z(3)*(U3-U5-U6-U7)*(U3-
     &U4-U5-U6-U7)) + 0.5D0*MD*(U1**2+U2**2+L9**2*(U3-U7)**2+2*L9*Z(54)*
     &U1*(U3-U7)+2*L9*Z(55)*U2*(U3-U7)+L8**2*(U3-U6-U7)**2+2*L8*Z(35)*U1
     &*(U3-U6-U7)+2*L8*Z(36)*U2*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)**2+2*L6*Z
     &(50)*U1*(U3-U5-U6-U7)+2*L6*Z(51)*U2*(U3-U5-U6-U7)+L2**2*(U3-U4-U5-
     &U6-U7)**2+2*L8*L9*Z(9)*(U3-U7)*(U3-U6-U7)+2*L6*L9*Z(239)*(U3-U7)*(
     &U3-U5-U6-U7)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-2*L2*Z(39)*U1*(
     &U3-U4-U5-U6-U7)-2*L2*Z(40)*U2*(U3-U4-U5-U6-U7)-2*L2*L9*Z(235)*(U3-
     &U7)*(U3-U4-U5-U6-U7)-2*L2*L8*Z(27)*(U3-U6-U7)*(U3-U4-U5-U6-U7)-2*L
     &2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)) + 0.5D0*ME*(U1**2+U2**2+
     &L10**2*(U3-U7)**2+2*L10*Z(54)*U1*(U3-U7)+2*L10*Z(55)*U2*(U3-U7)+(Z
     &(137)-Z(21)*U3-Z(21)*U8)**2+L8**2*(U3-U6-U7)**2+2*L8*Z(35)*U1*(U3-
     &U6-U7)+2*L8*Z(36)*U2*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)**2+2*L6*Z(50)*
     &U1*(U3-U5-U6-U7)+2*L6*Z(51)*U2*(U3-U5-U6-U7)+L2**2*(U3-U4-U5-U6-U7
     &)**2+2*L10*L8*Z(9)*(U3-U7)*(U3-U6-U7)+2*L10*L6*Z(239)*(U3-U7)*(U3-
     &U5-U6-U7)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)+2*L2*Z(243)*(Z(137
     &)-Z(21)*U3-Z(21)*U8)*(U3-U4-U5-U6-U7)-2*Z(56)*U2*(Z(137)-Z(21)*U3-
     &Z(21)*U8)-2*Z(58)*U1*(Z(137)-Z(21)*U3-Z(21)*U8)-2*L2*Z(39)*U1*(U3-
     &U4-U5-U6-U7)-2*L2*Z(40)*U2*(U3-U4-U5-U6-U7)-2*L10*Z(255)*(U3-U7)*(
     &Z(137)-Z(21)*U3-Z(21)*U8)-2*L8*Z(251)*(U3-U6-U7)*(Z(137)-Z(21)*U3-
     &Z(21)*U8)-2*L10*L2*Z(235)*(U3-U7)*(U3-U4-U5-U6-U7)-2*L6*Z(247)*(Z(
     &137)-Z(21)*U3-Z(21)*U8)*(U3-U5-U6-U7)-2*L2*L8*Z(27)*(U3-U6-U7)*(U3
     &-U4-U5-U6-U7)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)) + 0.5D0
     &*MG*(GSp**2+U1**2+U2**2+2*GSp*Z(1)*U1+2*GSp*Z(2)*U2+GS**2*U3**2+2*
     &GS*Z(1)*U2*U3+L10**2*(U3-U7)**2+2*L10*GSp*Z(12)*(U3-U7)+2*L10*Z(54
     &)*U1*(U3-U7)+2*L10*Z(55)*U2*(U3-U7)+2*L10*GS*Z(11)*U3*(U3-U7)+L8**
     &2*(U3-U6-U7)**2+2*L8*GSp*Z(32)*(U3-U6-U7)+2*L8*Z(35)*U1*(U3-U6-U7)
     &+2*L8*Z(36)*U2*(U3-U6-U7)+2*L8*GS*Z(30)*U3*(U3-U6-U7)+L6**2*(U3-U5
     &-U6-U7)**2+2*L6*GSp*Z(110)*(U3-U5-U6-U7)+2*L6*Z(50)*U1*(U3-U5-U6-U
     &7)+2*L6*Z(51)*U2*(U3-U5-U6-U7)+2*L6*GS*Z(112)*U3*(U3-U5-U6-U7)+L2*
     &*2*(U3-U4-U5-U6-U7)**2+2*L10*L8*Z(9)*(U3-U7)*(U3-U6-U7)+2*L10*L6*Z
     &(239)*(U3-U7)*(U3-U5-U6-U7)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-
     &2*GS*Z(2)*U1*U3-2*L2*GSp*Z(105)*(U3-U4-U5-U6-U7)-2*L2*Z(39)*U1*(U3
     &-U4-U5-U6-U7)-2*L2*Z(40)*U2*(U3-U4-U5-U6-U7)-2*L2*GS*Z(107)*U3*(U3
     &-U4-U5-U6-U7)-2*L10*L2*Z(235)*(U3-U7)*(U3-U4-U5-U6-U7)-2*L2*L8*Z(2
     &7)*(U3-U6-U7)*(U3-U4-U5-U6-U7)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U
     &5-U6-U7)) + 0.5D0*MI*(U1**2+U2**2+L10**2*(U3-U7)**2+2*L10*Z(54)*U1
     &*(U3-U7)+2*L10*Z(55)*U2*(U3-U7)+(Z(138)-L10*U3-L10*U8)**2+L8**2*(U
     &3-U6-U7)**2+2*L8*Z(35)*U1*(U3-U6-U7)+2*L8*Z(36)*U2*(U3-U6-U7)+(Z(1
     &45)+L6*U10+L6*U3+L6*U8+L6*U9)**2+L6**2*(U3-U5-U6-U7)**2+(Z(140)-L8
     &*U3-L8*U8-L8*U9)**2+2*L6*Z(50)*U1*(U3-U5-U6-U7)+2*L6*Z(51)*U2*(U3-
     &U5-U6-U7)+(Z(149)+Z(26)*U10+Z(26)*U11+Z(26)*U3+Z(26)*U8+Z(26)*U9)*
     &*2+2*Z(65)*U1*(Z(145)+L6*U10+L6*U3+L6*U8+L6*U9)+2*Z(66)*U2*(Z(145)
     &+L6*U10+L6*U3+L6*U8+L6*U9)+L2**2*(U3-U4-U5-U6-U7)**2+2*L10*L8*Z(9)
     &*(U3-U7)*(U3-U6-U7)+2*Z(73)*U1*(Z(149)+Z(26)*U10+Z(26)*U11+Z(26)*U
     &3+Z(26)*U8+Z(26)*U9)+2*Z(74)*U2*(Z(149)+Z(26)*U10+Z(26)*U11+Z(26)*
     &U3+Z(26)*U8+Z(26)*U9)+2*L10*L6*Z(239)*(U3-U7)*(U3-U5-U6-U7)+2*L10*
     &Z(299)*(U3-U7)*(Z(145)+L6*U10+L6*U3+L6*U8+L6*U9)+2*L6*L8*Z(5)*(U3-
     &U6-U7)*(U3-U5-U6-U7)+2*L10*Z(331)*(U3-U7)*(Z(149)+Z(26)*U10+Z(26)*
     &U11+Z(26)*U3+Z(26)*U8+Z(26)*U9)+2*L8*Z(291)*(U3-U6-U7)*(Z(145)+L6*
     &U10+L6*U3+L6*U8+L6*U9)+2*L2*Z(243)*(Z(138)-L10*U3-L10*U8)*(U3-U4-U
     &5-U6-U7)+2*L6*Z(283)*(U3-U5-U6-U7)*(Z(145)+L6*U10+L6*U3+L6*U8+L6*U
     &9)+2*L8*Z(327)*(U3-U6-U7)*(Z(149)+Z(26)*U10+Z(26)*U11+Z(26)*U3+Z(2
     &6)*U8+Z(26)*U9)+2*L6*Z(323)*(U3-U5-U6-U7)*(Z(149)+Z(26)*U10+Z(26)*
     &U11+Z(26)*U3+Z(26)*U8+Z(26)*U9)+2*Z(17)*(Z(145)+L6*U10+L6*U3+L6*U8
     &+L6*U9)*(Z(140)-L8*U3-L8*U8-L8*U9)+2*L2*Z(259)*(U3-U4-U5-U6-U7)*(Z
     &(140)-L8*U3-L8*U8-L8*U9)-2*Z(56)*U2*(Z(138)-L10*U3-L10*U8)-2*Z(58)
     &*U1*(Z(138)-L10*U3-L10*U8)-2*L2*Z(39)*U1*(U3-U4-U5-U6-U7)-2*L2*Z(4
     &0)*U2*(U3-U4-U5-U6-U7)-2*Z(61)*U1*(Z(140)-L8*U3-L8*U8-L8*U9)-2*Z(6
     &2)*U2*(Z(140)-L8*U3-L8*U8-L8*U9)-2*L10*Z(255)*(U3-U7)*(Z(138)-L10*
     &U3-L10*U8)-2*L8*Z(251)*(U3-U6-U7)*(Z(138)-L10*U3-L10*U8)-2*L10*L2*
     &Z(235)*(U3-U7)*(U3-U4-U5-U6-U7)-2*L10*Z(271)*(U3-U7)*(Z(140)-L8*U3
     &-L8*U8-L8*U9)-2*L6*Z(247)*(Z(138)-L10*U3-L10*U8)*(U3-U5-U6-U7)-2*L
     &2*L8*Z(27)*(U3-U6-U7)*(U3-U4-U5-U6-U7)-2*L8*Z(267)*(U3-U6-U7)*(Z(1
     &40)-L8*U3-L8*U8-L8*U9)-2*Z(307)*(Z(138)-L10*U3-L10*U8)*(Z(145)+L6*
     &U10+L6*U3+L6*U8+L6*U9)-2*Z(15)*(Z(138)-L10*U3-L10*U8)*(Z(140)-L8*U
     &3-L8*U8-L8*U9)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)-2*L6*Z(
     &263)*(U3-U5-U6-U7)*(Z(140)-L8*U3-L8*U8-L8*U9)-2*Z(335)*(Z(138)-L10
     &*U3-L10*U8)*(Z(149)+Z(26)*U10+Z(26)*U11+Z(26)*U3+Z(26)*U8+Z(26)*U9
     &)-2*L2*Z(275)*(Z(145)+L6*U10+L6*U3+L6*U8+L6*U9)*(U3-U4-U5-U6-U7)-2
     &*Z(19)*(Z(145)+L6*U10+L6*U3+L6*U8+L6*U9)*(Z(149)+Z(26)*U10+Z(26)*U
     &11+Z(26)*U3+Z(26)*U8+Z(26)*U9)-2*L2*Z(319)*(U3-U4-U5-U6-U7)*(Z(149
     &)+Z(26)*U10+Z(26)*U11+Z(26)*U3+Z(26)*U8+Z(26)*U9)-2*Z(339)*(Z(140)
     &-L8*U3-L8*U8-L8*U9)*(Z(149)+Z(26)*U10+Z(26)*U11+Z(26)*U3+Z(26)*U8+
     &Z(26)*U9)) - 0.5D0*MA*(2*L1*Z(39)*U1*(U3-U4-U5-U6-U7)+2*L1*Z(40)*U
     &2*(U3-U4-U5-U6-U7)-U1**2-U2**2-L1**2*(U3-U4-U5-U6-U7)**2) - 0.5D0*
     &MF*(2*Z(56)*U2*(Z(138)-L10*U3-L10*U8)+2*Z(58)*U1*(Z(138)-L10*U3-L1
     &0*U8)+2*L2*Z(39)*U1*(U3-U4-U5-U6-U7)+2*L2*Z(40)*U2*(U3-U4-U5-U6-U7
     &)+2*Z(61)*U1*(Z(139)-Z(22)*U3-Z(22)*U8-Z(22)*U9)+2*Z(62)*U2*(Z(139
     &)-Z(22)*U3-Z(22)*U8-Z(22)*U9)+2*L10*Z(255)*(U3-U7)*(Z(138)-L10*U3-
     &L10*U8)+2*L8*Z(251)*(U3-U6-U7)*(Z(138)-L10*U3-L10*U8)+2*L10*L2*Z(2
     &35)*(U3-U7)*(U3-U4-U5-U6-U7)+2*L10*Z(271)*(U3-U7)*(Z(139)-Z(22)*U3
     &-Z(22)*U8-Z(22)*U9)+2*L6*Z(247)*(Z(138)-L10*U3-L10*U8)*(U3-U5-U6-U
     &7)+2*L2*L8*Z(27)*(U3-U6-U7)*(U3-U4-U5-U6-U7)+2*L8*Z(267)*(U3-U6-U7
     &)*(Z(139)-Z(22)*U3-Z(22)*U8-Z(22)*U9)+2*Z(15)*(Z(138)-L10*U3-L10*U
     &8)*(Z(139)-Z(22)*U3-Z(22)*U8-Z(22)*U9)+2*L2*L6*Z(3)*(U3-U5-U6-U7)*
     &(U3-U4-U5-U6-U7)+2*L6*Z(263)*(U3-U5-U6-U7)*(Z(139)-Z(22)*U3-Z(22)*
     &U8-Z(22)*U9)-U1**2-U2**2-2*L10*Z(54)*U1*(U3-U7)-2*L10*Z(55)*U2*(U3
     &-U7)-L10**2*(U3-U7)**2-2*L8*Z(35)*U1*(U3-U6-U7)-2*L8*Z(36)*U2*(U3-
     &U6-U7)-(Z(138)-L10*U3-L10*U8)**2-L8**2*(U3-U6-U7)**2-2*L6*Z(50)*U1
     &*(U3-U5-U6-U7)-2*L6*Z(51)*U2*(U3-U5-U6-U7)-L6**2*(U3-U5-U6-U7)**2-
     &(Z(139)-Z(22)*U3-Z(22)*U8-Z(22)*U9)**2-2*L10*L8*Z(9)*(U3-U7)*(U3-U
     &6-U7)-L2**2*(U3-U4-U5-U6-U7)**2-2*L10*L6*Z(239)*(U3-U7)*(U3-U5-U6-
     &U7)-2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-2*L2*Z(243)*(Z(138)-L10*
     &U3-L10*U8)*(U3-U4-U5-U6-U7)-2*L2*Z(259)*(U3-U4-U5-U6-U7)*(Z(139)-Z
     &(22)*U3-Z(22)*U8-Z(22)*U9)) - 0.5D0*MH*(2*Z(56)*U2*(Z(138)-L10*U3-
     &L10*U8)+2*Z(58)*U1*(Z(138)-L10*U3-L10*U8)+2*L2*Z(39)*U1*(U3-U4-U5-
     &U6-U7)+2*L2*Z(40)*U2*(U3-U4-U5-U6-U7)+2*Z(61)*U1*(Z(140)-L8*U3-L8*
     &U8-L8*U9)+2*Z(62)*U2*(Z(140)-L8*U3-L8*U8-L8*U9)+2*L10*Z(255)*(U3-U
     &7)*(Z(138)-L10*U3-L10*U8)+2*L8*Z(251)*(U3-U6-U7)*(Z(138)-L10*U3-L1
     &0*U8)+2*L10*L2*Z(235)*(U3-U7)*(U3-U4-U5-U6-U7)+2*L10*Z(271)*(U3-U7
     &)*(Z(140)-L8*U3-L8*U8-L8*U9)+2*L6*Z(247)*(Z(138)-L10*U3-L10*U8)*(U
     &3-U5-U6-U7)+2*L2*L8*Z(27)*(U3-U6-U7)*(U3-U4-U5-U6-U7)+2*L8*Z(267)*
     &(U3-U6-U7)*(Z(140)-L8*U3-L8*U8-L8*U9)+2*Z(307)*(Z(138)-L10*U3-L10*
     &U8)*(Z(147)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)+2*Z(311)*(Z(138)
     &-L10*U3-L10*U8)*(Z(148)+Z(25)*U10+Z(25)*U3+Z(25)*U8+Z(25)*U9)+2*Z(
     &15)*(Z(138)-L10*U3-L10*U8)*(Z(140)-L8*U3-L8*U8-L8*U9)+2*L2*L6*Z(3)
     &*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)+2*L6*Z(263)*(U3-U5-U6-U7)*(Z(140)-
     &L8*U3-L8*U8-L8*U9)+2*L2*Z(275)*(Z(147)+Z(24)*U10+Z(24)*U3+Z(24)*U8
     &+Z(24)*U9)*(U3-U4-U5-U6-U7)+2*L2*Z(279)*(Z(148)+Z(25)*U10+Z(25)*U3
     &+Z(25)*U8+Z(25)*U9)*(U3-U4-U5-U6-U7)+2*Z(315)*(Z(148)+Z(25)*U10+Z(
     &25)*U3+Z(25)*U8+Z(25)*U9)*(Z(140)-L8*U3-L8*U8-L8*U9)-U1**2-U2**2-2
     &*L10*Z(54)*U1*(U3-U7)-2*L10*Z(55)*U2*(U3-U7)-L10**2*(U3-U7)**2-2*L
     &8*Z(35)*U1*(U3-U6-U7)-2*L8*Z(36)*U2*(U3-U6-U7)-(Z(138)-L10*U3-L10*
     &U8)**2-L8**2*(U3-U6-U7)**2-2*L6*Z(50)*U1*(U3-U5-U6-U7)-2*L6*Z(51)*
     &U2*(U3-U5-U6-U7)-(Z(147)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)**2-
     &(Z(148)+Z(25)*U10+Z(25)*U3+Z(25)*U8+Z(25)*U9)**2-L6**2*(U3-U5-U6-U
     &7)**2-2*Z(65)*U1*(Z(147)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)-2*Z
     &(66)*U2*(Z(147)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)-2*Z(69)*U1*(
     &Z(148)+Z(25)*U10+Z(25)*U3+Z(25)*U8+Z(25)*U9)-2*Z(70)*U2*(Z(148)+Z(
     &25)*U10+Z(25)*U3+Z(25)*U8+Z(25)*U9)-(Z(140)-L8*U3-L8*U8-L8*U9)**2-
     &2*L10*L8*Z(9)*(U3-U7)*(U3-U6-U7)-L2**2*(U3-U4-U5-U6-U7)**2-2*L10*L
     &6*Z(239)*(U3-U7)*(U3-U5-U6-U7)-2*L10*Z(299)*(U3-U7)*(Z(147)+Z(24)*
     &U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)-2*L10*Z(303)*(U3-U7)*(Z(148)+Z(25)
     &*U10+Z(25)*U3+Z(25)*U8+Z(25)*U9)-2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6
     &-U7)-2*L8*Z(291)*(U3-U6-U7)*(Z(147)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(
     &24)*U9)-2*L8*Z(295)*(U3-U6-U7)*(Z(148)+Z(25)*U10+Z(25)*U3+Z(25)*U8
     &+Z(25)*U9)-2*L2*Z(243)*(Z(138)-L10*U3-L10*U8)*(U3-U4-U5-U6-U7)-2*L
     &6*Z(283)*(U3-U5-U6-U7)*(Z(147)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U
     &9)-2*L6*Z(287)*(U3-U5-U6-U7)*(Z(148)+Z(25)*U10+Z(25)*U3+Z(25)*U8+Z
     &(25)*U9)-2*Z(7)*(Z(147)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)*(Z(1
     &48)+Z(25)*U10+Z(25)*U3+Z(25)*U8+Z(25)*U9)-2*Z(17)*(Z(147)+Z(24)*U1
     &0+Z(24)*U3+Z(24)*U8+Z(24)*U9)*(Z(140)-L8*U3-L8*U8-L8*U9)-2*L2*Z(25
     &9)*(U3-U4-U5-U6-U7)*(Z(140)-L8*U3-L8*U8-L8*U9))
      Z(82) = MG*GS/Z(75)
      POCMY = Q2 + Z(78)*Z(34) + Z(79)*Z(53) + Z(80)*Z(57) + Z(81)*Z(60)
     & + Z(83)*Z(64) + Z(84)*Z(72) + Z(85)*Z(68) + Z(82)*Z(2) + 0.5D0*Z(
     &77)*Z(49) + 0.5D0*Z(86)*Z(45) - Z(76)*Z(38)
      PECM = 0.5D0*K1*Q1**2 + 0.5D0*K3*Q2**2 - G*MT*POCMY
      TE = KECM + PECM
      Z(341) = FAp - EAp
      Z(342) = INF*Z(341)
      Z(343) = FAp - EAp - HAp
      Z(344) = INH*Z(343)
      Z(345) = FAp - EAp - HAp - IAp
      Z(346) = INI*Z(345)
      Z(401) = MB*(Z(348)*Z(37)+Z(349)*Z(48)+Z(350)*Z(44)-Z(78)*Z(33)-Z(
     &79)*Z(52)-Z(80)*Z(56)-Z(81)*Z(59)-Z(83)*Z(63)-Z(84)*Z(71)-Z(85)*Z(
     &67)-Z(82)*Z(1))
      Z(396) = MA*(2*Z(347)*Z(37)-2*Z(78)*Z(33)-2*Z(79)*Z(52)-2*Z(80)*Z(
     &56)-2*Z(81)*Z(59)-2*Z(83)*Z(63)-2*Z(84)*Z(71)-2*Z(85)*Z(67)-2*Z(82
     &)*Z(1)-Z(77)*Z(48)-Z(86)*Z(44))
      Z(409) = MC*(2*Z(348)*Z(37)+2*Z(378)*Z(48)+2*Z(379)*Z(33)-2*Z(79)*
     &Z(52)-2*Z(80)*Z(56)-2*Z(81)*Z(59)-2*Z(83)*Z(63)-2*Z(84)*Z(71)-2*Z(
     &85)*Z(67)-2*Z(82)*Z(1)-Z(86)*Z(44))
      Z(415) = MD*(2*Z(348)*Z(37)+2*Z(378)*Z(48)+2*Z(380)*Z(33)+2*Z(381)
     &*Z(52)-2*Z(80)*Z(56)-2*Z(81)*Z(59)-2*Z(83)*Z(63)-2*Z(84)*Z(71)-2*Z
     &(85)*Z(67)-2*Z(82)*Z(1)-Z(86)*Z(44))
      Z(422) = ME*(2*Z(348)*Z(37)+2*Z(378)*Z(48)+2*Z(380)*Z(33)+2*Z(382)
     &*Z(52)+2*Z(383)*Z(56)-2*Z(81)*Z(59)-2*Z(83)*Z(63)-2*Z(84)*Z(71)-2*
     &Z(85)*Z(67)-2*Z(82)*Z(1)-Z(86)*Z(44))
      Z(430) = MF*(2*Z(348)*Z(37)+2*Z(378)*Z(48)+2*Z(380)*Z(33)+2*Z(382)
     &*Z(52)+2*Z(384)*Z(56)+2*Z(385)*Z(59)-2*Z(83)*Z(63)-2*Z(84)*Z(71)-2
     &*Z(85)*Z(67)-2*Z(82)*Z(1)-Z(86)*Z(44))
      Z(386) = GS - Z(82)
      Z(438) = MG*(Z(86)*Z(45)+2*Z(80)*Z(57)+2*Z(81)*Z(60)+2*Z(83)*Z(64)
     &+2*Z(84)*Z(72)+2*Z(85)*Z(68)-2*Z(348)*Z(38)-2*Z(378)*Z(49)-2*Z(380
     &)*Z(34)-2*Z(382)*Z(53)-2*Z(386)*Z(2))
      Z(448) = MH*(2*Z(348)*Z(37)+2*Z(378)*Z(48)+2*Z(380)*Z(33)+2*Z(382)
     &*Z(52)+2*Z(384)*Z(56)+2*Z(387)*Z(59)+2*Z(388)*Z(63)+2*Z(389)*Z(67)
     &-2*Z(84)*Z(71)-2*Z(82)*Z(1)-Z(86)*Z(44))
      Z(461) = MI*(2*Z(348)*Z(37)+2*Z(378)*Z(48)+2*Z(380)*Z(33)+2*Z(382)
     &*Z(52)+2*Z(384)*Z(56)+2*Z(387)*Z(59)+2*Z(393)*Z(63)+2*Z(394)*Z(71)
     &-2*Z(85)*Z(67)-2*Z(82)*Z(1)-Z(86)*Z(44))
      Z(236) = Z(3)*Z(232) + Z(4)*Z(234)
      Z(109) = Z(1)*Z(48) + Z(2)*Z(49)
      Z(400) = MB*(Z(399)+Z(348)*Z(3)-Z(78)*Z(5)-Z(79)*Z(236)-Z(80)*Z(24
     &4)-Z(81)*Z(260)-Z(83)*Z(280)-Z(84)*Z(320)-Z(85)*Z(284)-Z(82)*Z(109
     &))
      Z(351) = Z(7)*Z(5) + Z(8)*Z(6)
      Z(353) = Z(8)*Z(5) - Z(7)*Z(6)
      Z(354) = Z(9)*Z(351) + Z(10)*Z(353)
      Z(133) = Z(1)*Z(44) + Z(2)*Z(45)
      Z(135) = Z(1)*Z(45) - Z(2)*Z(44)
      Z(358) = Z(13)*Z(133) - Z(14)*Z(135)
      Z(360) = Z(13)*Z(135) + Z(14)*Z(133)
      Z(362) = -Z(15)*Z(358) - Z(16)*Z(360)
      Z(364) = Z(16)*Z(358) - Z(15)*Z(360)
      Z(366) = Z(18)*Z(364) - Z(17)*Z(362)
      Z(368) = -Z(17)*Z(364) - Z(18)*Z(362)
      Z(370) = Z(20)*Z(368) - Z(19)*Z(366)
      Z(374) = Z(7)*Z(366) + Z(8)*Z(368)
      Z(404) = MB*(Z(403)+Z(348)*Z(41)-Z(78)*Z(351)-Z(79)*Z(354)-Z(80)*Z
     &(358)-Z(81)*Z(362)-Z(83)*Z(366)-Z(84)*Z(370)-Z(85)*Z(374)-Z(82)*Z(
     &133))
      Z(407) = MC*(2*Z(378)+2*Z(348)*Z(3)+2*Z(379)*Z(5)-Z(406)-2*Z(79)*Z
     &(236)-2*Z(80)*Z(244)-2*Z(81)*Z(260)-2*Z(83)*Z(280)-2*Z(84)*Z(320)-
     &2*Z(85)*Z(284)-2*Z(82)*Z(109))
      Z(408) = MC*(2*Z(379)+2*Z(348)*Z(27)+2*Z(378)*Z(5)-2*Z(79)*Z(9)-2*
     &Z(80)*Z(248)-2*Z(81)*Z(264)-2*Z(83)*Z(288)-2*Z(84)*Z(324)-2*Z(85)*
     &Z(292)-2*Z(82)*Z(30)-Z(86)*Z(351))
      Z(412) = MD*(2*Z(378)+2*Z(348)*Z(3)+2*Z(380)*Z(5)+2*Z(381)*Z(236)-
     &Z(406)-2*Z(80)*Z(244)-2*Z(81)*Z(260)-2*Z(83)*Z(280)-2*Z(84)*Z(320)
     &-2*Z(85)*Z(284)-2*Z(82)*Z(109))
      Z(413) = MD*(2*Z(380)+2*Z(348)*Z(27)+2*Z(378)*Z(5)+2*Z(381)*Z(9)-2
     &*Z(80)*Z(248)-2*Z(81)*Z(264)-2*Z(83)*Z(288)-2*Z(84)*Z(324)-2*Z(85)
     &*Z(292)-2*Z(82)*Z(30)-Z(86)*Z(351))
      Z(252) = Z(9)*Z(248) + Z(10)*Z(250)
      Z(268) = Z(9)*Z(264) + Z(10)*Z(266)
      Z(296) = Z(9)*Z(288) + Z(10)*Z(290)
      Z(328) = Z(9)*Z(324) + Z(10)*Z(326)
      Z(300) = Z(9)*Z(292) + Z(10)*Z(294)
      Z(414) = MD*(2*Z(381)+2*Z(348)*Z(232)+2*Z(378)*Z(236)+2*Z(380)*Z(9
     &)-2*Z(80)*Z(252)-2*Z(81)*Z(268)-2*Z(83)*Z(296)-2*Z(84)*Z(328)-2*Z(
     &85)*Z(300)-2*Z(82)*Z(11)-Z(86)*Z(354))
      Z(418) = ME*(2*Z(378)+2*Z(348)*Z(3)+2*Z(380)*Z(5)+2*Z(382)*Z(236)+
     &2*Z(383)*Z(244)-Z(406)-2*Z(81)*Z(260)-2*Z(83)*Z(280)-2*Z(84)*Z(320
     &)-2*Z(85)*Z(284)-2*Z(82)*Z(109))
      Z(419) = ME*(2*Z(380)+2*Z(348)*Z(27)+2*Z(378)*Z(5)+2*Z(382)*Z(9)+2
     &*Z(383)*Z(248)-2*Z(81)*Z(264)-2*Z(83)*Z(288)-2*Z(84)*Z(324)-2*Z(85
     &)*Z(292)-2*Z(82)*Z(30)-Z(86)*Z(351))
      Z(420) = ME*(2*Z(382)+2*Z(348)*Z(232)+2*Z(378)*Z(236)+2*Z(380)*Z(9
     &)+2*Z(383)*Z(252)-2*Z(81)*Z(268)-2*Z(83)*Z(296)-2*Z(84)*Z(328)-2*Z
     &(85)*Z(300)-2*Z(82)*Z(11)-Z(86)*Z(354))
      Z(425) = MF*(2*Z(378)+2*Z(348)*Z(3)+2*Z(380)*Z(5)+2*Z(382)*Z(236)+
     &2*Z(384)*Z(244)+2*Z(385)*Z(260)-Z(406)-2*Z(83)*Z(280)-2*Z(84)*Z(32
     &0)-2*Z(85)*Z(284)-2*Z(82)*Z(109))
      Z(426) = MF*(2*Z(380)+2*Z(348)*Z(27)+2*Z(378)*Z(5)+2*Z(382)*Z(9)+2
     &*Z(384)*Z(248)+2*Z(385)*Z(264)-2*Z(83)*Z(288)-2*Z(84)*Z(324)-2*Z(8
     &5)*Z(292)-2*Z(82)*Z(30)-Z(86)*Z(351))
      Z(427) = MF*(2*Z(382)+2*Z(348)*Z(232)+2*Z(378)*Z(236)+2*Z(380)*Z(9
     &)+2*Z(384)*Z(252)+2*Z(385)*Z(268)-2*Z(83)*Z(296)-2*Z(84)*Z(328)-2*
     &Z(85)*Z(300)-2*Z(82)*Z(11)-Z(86)*Z(354))
      Z(336) = -Z(15)*Z(332) - Z(16)*Z(334)
      Z(312) = -Z(15)*Z(308) - Z(16)*Z(310)
      Z(117) = Z(1)*Z(59) + Z(2)*Z(60)
      Z(429) = MF*(2*Z(385)+2*Z(83)*Z(17)+2*Z(348)*Z(256)+2*Z(378)*Z(260
     &)+2*Z(380)*Z(264)+2*Z(382)*Z(268)-2*Z(384)*Z(15)-2*Z(84)*Z(336)-2*
     &Z(85)*Z(312)-2*Z(82)*Z(117)-Z(86)*Z(362))
      Z(104) = Z(1)*Z(37) + Z(2)*Z(38)
      Z(432) = MG*(Z(86)*Z(41)+2*Z(80)*Z(240)+2*Z(81)*Z(256)+2*Z(83)*Z(2
     &72)+2*Z(84)*Z(316)+2*Z(85)*Z(276)-2*Z(348)-2*Z(378)*Z(3)-2*Z(380)*
     &Z(27)-2*Z(382)*Z(232)-2*Z(386)*Z(104))
      Z(441) = MH*(2*Z(378)+2*Z(348)*Z(3)+2*Z(380)*Z(5)+2*Z(382)*Z(236)+
     &2*Z(384)*Z(244)+2*Z(387)*Z(260)+2*Z(388)*Z(280)+2*Z(389)*Z(284)-Z(
     &406)-2*Z(84)*Z(320)-2*Z(82)*Z(109))
      Z(442) = MH*(2*Z(380)+2*Z(348)*Z(27)+2*Z(378)*Z(5)+2*Z(382)*Z(9)+2
     &*Z(384)*Z(248)+2*Z(387)*Z(264)+2*Z(388)*Z(288)+2*Z(389)*Z(292)-2*Z
     &(84)*Z(324)-2*Z(82)*Z(30)-Z(86)*Z(351))
      Z(443) = MH*(2*Z(382)+2*Z(348)*Z(232)+2*Z(378)*Z(236)+2*Z(380)*Z(9
     &)+2*Z(384)*Z(252)+2*Z(387)*Z(268)+2*Z(388)*Z(296)+2*Z(389)*Z(300)-
     &2*Z(84)*Z(328)-2*Z(82)*Z(11)-Z(86)*Z(354))
      Z(445) = MH*(2*Z(387)+2*Z(348)*Z(256)+2*Z(378)*Z(260)+2*Z(380)*Z(2
     &64)+2*Z(382)*Z(268)+2*Z(389)*Z(312)-2*Z(384)*Z(15)-2*Z(388)*Z(17)-
     &2*Z(84)*Z(336)-2*Z(82)*Z(117)-Z(86)*Z(362))
      Z(304) = Z(13)*Z(123) - Z(14)*Z(125)
      Z(447) = MH*(Z(446)+2*Z(84)*Z(19)+2*Z(348)*Z(272)+2*Z(378)*Z(280)+
     &2*Z(380)*Z(288)+2*Z(382)*Z(296)+2*Z(384)*Z(304)-2*Z(387)*Z(17)-2*Z
     &(82)*Z(123)-Z(86)*Z(366))
      Z(390) = Z(8)*Z(20) - Z(7)*Z(19)
      Z(451) = MH*(Z(450)+2*Z(348)*Z(276)+2*Z(378)*Z(284)+2*Z(380)*Z(292
     &)+2*Z(382)*Z(300)+2*Z(384)*Z(308)+2*Z(387)*Z(312)-2*Z(84)*Z(390)-2
     &*Z(82)*Z(141)-Z(86)*Z(374))
      Z(453) = MI*(2*Z(378)+2*Z(348)*Z(3)+2*Z(380)*Z(5)+2*Z(382)*Z(236)+
     &2*Z(384)*Z(244)+2*Z(387)*Z(260)+2*Z(393)*Z(280)+2*Z(394)*Z(320)-Z(
     &406)-2*Z(85)*Z(284)-2*Z(82)*Z(109))
      Z(454) = MI*(2*Z(380)+2*Z(348)*Z(27)+2*Z(378)*Z(5)+2*Z(382)*Z(9)+2
     &*Z(384)*Z(248)+2*Z(387)*Z(264)+2*Z(393)*Z(288)+2*Z(394)*Z(324)-2*Z
     &(85)*Z(292)-2*Z(82)*Z(30)-Z(86)*Z(351))
      Z(455) = MI*(2*Z(382)+2*Z(348)*Z(232)+2*Z(378)*Z(236)+2*Z(380)*Z(9
     &)+2*Z(384)*Z(252)+2*Z(387)*Z(268)+2*Z(393)*Z(296)+2*Z(394)*Z(328)-
     &2*Z(85)*Z(300)-2*Z(82)*Z(11)-Z(86)*Z(354))
      Z(457) = MI*(2*Z(387)+2*Z(348)*Z(256)+2*Z(378)*Z(260)+2*Z(380)*Z(2
     &64)+2*Z(382)*Z(268)+2*Z(394)*Z(336)-2*Z(384)*Z(15)-2*Z(393)*Z(17)-
     &2*Z(85)*Z(312)-2*Z(82)*Z(117)-Z(86)*Z(362))
      Z(459) = MI*(2*Z(393)+2*Z(348)*Z(272)+2*Z(378)*Z(280)+2*Z(380)*Z(2
     &88)+2*Z(382)*Z(296)+2*Z(384)*Z(304)-2*Z(458)-2*Z(387)*Z(17)-2*Z(39
     &4)*Z(19)-2*Z(82)*Z(123)-Z(86)*Z(366))
      Z(460) = MI*(2*Z(394)+2*Z(348)*Z(316)+2*Z(378)*Z(320)+2*Z(380)*Z(3
     &24)+2*Z(382)*Z(328)+2*Z(384)*Z(332)+2*Z(387)*Z(336)-2*Z(85)*Z(390)
     &-2*Z(393)*Z(19)-2*Z(82)*Z(129)-Z(86)*Z(370))
      Z(340) = INE*EAp
      Z(119) = Z(1)*Z(60) - Z(2)*Z(59)
      Z(437) = MG*GSp*(2*Z(80)*Z(14)+2*Z(348)*Z(106)+2*Z(378)*Z(111)+2*Z
     &(380)*Z(31)-2*Z(81)*Z(119)-2*Z(83)*Z(125)-2*Z(84)*Z(131)-2*Z(85)*Z
     &(143)-2*Z(382)*Z(12)-Z(86)*Z(135))
      Z(402) = MB*(Z(348)*Z(38)+Z(349)*Z(49)+Z(350)*Z(45)-Z(78)*Z(34)-Z(
     &79)*Z(53)-Z(80)*Z(57)-Z(81)*Z(60)-Z(83)*Z(64)-Z(84)*Z(72)-Z(85)*Z(
     &68)-Z(82)*Z(2))
      Z(397) = MA*(2*Z(347)*Z(38)-2*Z(78)*Z(34)-2*Z(79)*Z(53)-2*Z(80)*Z(
     &57)-2*Z(81)*Z(60)-2*Z(83)*Z(64)-2*Z(84)*Z(72)-2*Z(85)*Z(68)-2*Z(82
     &)*Z(2)-Z(77)*Z(49)-Z(86)*Z(45))
      Z(410) = MC*(2*Z(348)*Z(38)+2*Z(378)*Z(49)+2*Z(379)*Z(34)-2*Z(79)*
     &Z(53)-2*Z(80)*Z(57)-2*Z(81)*Z(60)-2*Z(83)*Z(64)-2*Z(84)*Z(72)-2*Z(
     &85)*Z(68)-2*Z(82)*Z(2)-Z(86)*Z(45))
      Z(416) = MD*(2*Z(348)*Z(38)+2*Z(378)*Z(49)+2*Z(380)*Z(34)+2*Z(381)
     &*Z(53)-2*Z(80)*Z(57)-2*Z(81)*Z(60)-2*Z(83)*Z(64)-2*Z(84)*Z(72)-2*Z
     &(85)*Z(68)-2*Z(82)*Z(2)-Z(86)*Z(45))
      Z(423) = ME*(2*Z(348)*Z(38)+2*Z(378)*Z(49)+2*Z(380)*Z(34)+2*Z(382)
     &*Z(53)+2*Z(383)*Z(57)-2*Z(81)*Z(60)-2*Z(83)*Z(64)-2*Z(84)*Z(72)-2*
     &Z(85)*Z(68)-2*Z(82)*Z(2)-Z(86)*Z(45))
      Z(431) = MF*(2*Z(348)*Z(38)+2*Z(378)*Z(49)+2*Z(380)*Z(34)+2*Z(382)
     &*Z(53)+2*Z(384)*Z(57)+2*Z(385)*Z(60)-2*Z(83)*Z(64)-2*Z(84)*Z(72)-2
     &*Z(85)*Z(68)-2*Z(82)*Z(2)-Z(86)*Z(45))
      Z(439) = MG*(Z(86)*Z(44)+2*Z(80)*Z(56)+2*Z(81)*Z(59)+2*Z(83)*Z(63)
     &+2*Z(84)*Z(71)+2*Z(85)*Z(67)-2*Z(348)*Z(37)-2*Z(378)*Z(48)-2*Z(380
     &)*Z(33)-2*Z(382)*Z(52)-2*Z(386)*Z(1))
      Z(449) = MH*(2*Z(348)*Z(38)+2*Z(378)*Z(49)+2*Z(380)*Z(34)+2*Z(382)
     &*Z(53)+2*Z(384)*Z(57)+2*Z(387)*Z(60)+2*Z(388)*Z(64)+2*Z(389)*Z(68)
     &-2*Z(84)*Z(72)-2*Z(82)*Z(2)-Z(86)*Z(45))
      Z(462) = MI*(2*Z(348)*Z(38)+2*Z(378)*Z(49)+2*Z(380)*Z(34)+2*Z(382)
     &*Z(53)+2*Z(384)*Z(57)+2*Z(387)*Z(60)+2*Z(393)*Z(64)+2*Z(394)*Z(72)
     &-2*Z(85)*Z(68)-2*Z(82)*Z(2)-Z(86)*Z(45))
      Z(398) = MB*(Z(348)+Z(349)*Z(3)+Z(350)*Z(41)-Z(78)*Z(27)-Z(79)*Z(2
     &32)-Z(80)*Z(240)-Z(81)*Z(256)-Z(83)*Z(272)-Z(84)*Z(316)-Z(85)*Z(27
     &6)-Z(82)*Z(104))
      Z(395) = MA*(2*Z(347)-2*Z(78)*Z(27)-2*Z(79)*Z(232)-2*Z(80)*Z(240)-
     &2*Z(81)*Z(256)-2*Z(83)*Z(272)-2*Z(84)*Z(316)-2*Z(85)*Z(276)-2*Z(82
     &)*Z(104)-Z(77)*Z(3)-Z(86)*Z(41))
      Z(405) = MC*(2*Z(348)+2*Z(378)*Z(3)+2*Z(379)*Z(27)-2*Z(79)*Z(232)-
     &2*Z(80)*Z(240)-2*Z(81)*Z(256)-2*Z(83)*Z(272)-2*Z(84)*Z(316)-2*Z(85
     &)*Z(276)-2*Z(82)*Z(104)-Z(86)*Z(41))
      Z(411) = MD*(2*Z(348)+2*Z(378)*Z(3)+2*Z(380)*Z(27)+2*Z(381)*Z(232)
     &-2*Z(80)*Z(240)-2*Z(81)*Z(256)-2*Z(83)*Z(272)-2*Z(84)*Z(316)-2*Z(8
     &5)*Z(276)-2*Z(82)*Z(104)-Z(86)*Z(41))
      Z(417) = ME*(2*Z(348)+2*Z(378)*Z(3)+2*Z(380)*Z(27)+2*Z(382)*Z(232)
     &+2*Z(383)*Z(240)-2*Z(81)*Z(256)-2*Z(83)*Z(272)-2*Z(84)*Z(316)-2*Z(
     &85)*Z(276)-2*Z(82)*Z(104)-Z(86)*Z(41))
      Z(421) = ME*(2*Z(13)*Z(82)+Z(86)*Z(358)+2*Z(83)*Z(304)+2*Z(84)*Z(3
     &32)+2*Z(85)*Z(308)-2*Z(383)-2*Z(81)*Z(15)-2*Z(348)*Z(240)-2*Z(378)
     &*Z(244)-2*Z(380)*Z(248)-2*Z(382)*Z(252))
      Z(424) = MF*(2*Z(348)+2*Z(378)*Z(3)+2*Z(380)*Z(27)+2*Z(382)*Z(232)
     &+2*Z(384)*Z(240)+2*Z(385)*Z(256)-2*Z(83)*Z(272)-2*Z(84)*Z(316)-2*Z
     &(85)*Z(276)-2*Z(82)*Z(104)-Z(86)*Z(41))
      Z(428) = MF*(2*Z(385)*Z(15)+2*Z(13)*Z(82)+Z(86)*Z(358)+2*Z(83)*Z(3
     &04)+2*Z(84)*Z(332)+2*Z(85)*Z(308)-2*Z(384)-2*Z(348)*Z(240)-2*Z(378
     &)*Z(244)-2*Z(380)*Z(248)-2*Z(382)*Z(252))
      Z(433) = MG*(Z(406)+2*Z(80)*Z(244)+2*Z(81)*Z(260)+2*Z(83)*Z(280)+2
     &*Z(84)*Z(320)+2*Z(85)*Z(284)-2*Z(378)-2*Z(348)*Z(3)-2*Z(380)*Z(5)-
     &2*Z(382)*Z(236)-2*Z(386)*Z(109))
      Z(434) = MG*(Z(86)*Z(351)+2*Z(80)*Z(248)+2*Z(81)*Z(264)+2*Z(83)*Z(
     &288)+2*Z(84)*Z(324)+2*Z(85)*Z(292)-2*Z(380)-2*Z(348)*Z(27)-2*Z(378
     &)*Z(5)-2*Z(382)*Z(9)-2*Z(386)*Z(30))
      Z(435) = MG*(Z(86)*Z(354)+2*Z(80)*Z(252)+2*Z(81)*Z(268)+2*Z(83)*Z(
     &296)+2*Z(84)*Z(328)+2*Z(85)*Z(300)-2*Z(382)-2*Z(348)*Z(232)-2*Z(37
     &8)*Z(236)-2*Z(380)*Z(9)-2*Z(386)*Z(11))
      Z(436) = MG*(2*Z(80)*Z(13)+Z(86)*Z(133)+2*Z(81)*Z(117)+2*Z(83)*Z(1
     &23)+2*Z(84)*Z(129)+2*Z(85)*Z(141)-2*Z(386)-2*Z(348)*Z(104)-2*Z(378
     &)*Z(109)-2*Z(380)*Z(30)-2*Z(382)*Z(11))
      Z(440) = MH*(2*Z(348)+2*Z(378)*Z(3)+2*Z(380)*Z(27)+2*Z(382)*Z(232)
     &+2*Z(384)*Z(240)+2*Z(387)*Z(256)+2*Z(388)*Z(272)+2*Z(389)*Z(276)-2
     &*Z(84)*Z(316)-2*Z(82)*Z(104)-Z(86)*Z(41))
      Z(444) = MH*(2*Z(387)*Z(15)+2*Z(13)*Z(82)+Z(86)*Z(358)+2*Z(84)*Z(3
     &32)-2*Z(384)-2*Z(348)*Z(240)-2*Z(378)*Z(244)-2*Z(380)*Z(248)-2*Z(3
     &82)*Z(252)-2*Z(388)*Z(304)-2*Z(389)*Z(308))
      Z(452) = MI*(2*Z(348)+2*Z(378)*Z(3)+2*Z(380)*Z(27)+2*Z(382)*Z(232)
     &+2*Z(384)*Z(240)+2*Z(387)*Z(256)+2*Z(393)*Z(272)+2*Z(394)*Z(316)-2
     &*Z(85)*Z(276)-2*Z(82)*Z(104)-Z(86)*Z(41))
      Z(456) = MI*(2*Z(387)*Z(15)+2*Z(13)*Z(82)+Z(86)*Z(358)+2*Z(85)*Z(3
     &08)-2*Z(384)-2*Z(348)*Z(240)-2*Z(378)*Z(244)-2*Z(380)*Z(248)-2*Z(3
     &82)*Z(252)-2*Z(393)*Z(304)-2*Z(394)*Z(332))
      HZ = Z(342) + Z(344) + Z(346) + INA*U3 + INB*U3 + INC*U3 + IND*U3 
     &+ INE*U3 + INE*U8 + INF*U3 + INF*U8 + INF*U9 + ING*U3 + INH*U10 + 
     &INH*U3 + INH*U8 + INH*U9 + INI*U10 + INI*U11 + INI*U3 + INI*U8 + I
     &NI*U9 + Z(401)*U2 + 0.5D0*Z(396)*U2 + 0.5D0*Z(409)*U2 + 0.5D0*Z(41
     &5)*U2 + 0.5D0*Z(422)*U2 + 0.5D0*Z(430)*U2 + 0.5D0*Z(438)*U1 + 0.5D
     &0*Z(448)*U2 + 0.5D0*Z(461)*U2 + 0.5D0*Z(400)*Z(166) + 0.5D0*Z(404)
     &*Z(167) + 0.5D0*Z(407)*Z(172) + 0.5D0*Z(408)*Z(174) + 0.5D0*Z(412)
     &*Z(172) + 0.5D0*Z(413)*Z(176) + 0.5D0*Z(414)*Z(178) + 0.5D0*Z(418)
     &*Z(172) + 0.5D0*Z(419)*Z(176) + 0.5D0*Z(420)*Z(180) + 0.5D0*Z(425)
     &*Z(172) + 0.5D0*Z(426)*Z(176) + 0.5D0*Z(427)*Z(180) + 0.5D0*Z(429)
     &*Z(188) + 0.5D0*Z(432)*Z(164) + 0.5D0*Z(441)*Z(172) + 0.5D0*Z(442)
     &*Z(176) + 0.5D0*Z(443)*Z(180) + 0.5D0*Z(445)*Z(192) + 0.5D0*Z(447)
     &*Z(206) + 0.5D0*Z(451)*Z(207) + 0.5D0*Z(453)*Z(172) + 0.5D0*Z(454)
     &*Z(176) + 0.5D0*Z(455)*Z(180) + 0.5D0*Z(457)*Z(192) + 0.5D0*Z(459)
     &*Z(199) + 0.5D0*Z(460)*Z(212) - Z(340) - 0.5D0*Z(437) - IND*U7 - Z
     &(402)*U1 - 0.5D0*Z(397)*U1 - 0.5D0*Z(410)*U1 - 0.5D0*Z(416)*U1 - 0
     &.5D0*Z(423)*U1 - 0.5D0*Z(431)*U1 - 0.5D0*Z(439)*U2 - 0.5D0*Z(449)*
     &U1 - 0.5D0*Z(462)*U1 - INC*(U6+U7) - INB*(U5+U6+U7) - INA*(U4+U5+U
     &6+U7) - Z(398)*Z(164) - 0.5D0*Z(395)*Z(162) - 0.5D0*Z(405)*Z(164) 
     &- 0.5D0*Z(411)*Z(164) - 0.5D0*Z(417)*Z(164) - 0.5D0*Z(421)*Z(182) 
     &- 0.5D0*Z(424)*Z(164) - 0.5D0*Z(428)*Z(185) - 0.5D0*Z(433)*Z(172) 
     &- 0.5D0*Z(434)*Z(176) - 0.5D0*Z(435)*Z(180) - 0.5D0*Z(436)*Z(195) 
     &- 0.5D0*Z(440)*Z(164) - 0.5D0*Z(444)*Z(185) - 0.5D0*Z(452)*Z(164) 
     &- 0.5D0*Z(456)*Z(185)
      Z(491) = MG*GSp
      Z(502) = MH*Z(148)
      Z(511) = MI*Z(149)
      Z(500) = MH*Z(147)
      Z(509) = MI*Z(145)
      Z(492) = MG*GS
      Z(479) = ME*Z(137)
      Z(484) = MF*Z(138)
      Z(497) = MH*Z(138)
      Z(507) = MI*Z(138)
      Z(486) = MF*Z(139)
      Z(498) = MH*Z(140)
      Z(508) = MI*Z(140)
      PX = Z(491)*Z(1) + (MA+MB+MC+MD+ME+MF+MG+MH+MI)*U1 + 0.5D0*Z(466)*
     &Z(46)*(U3-U5-U6-U7) + Z(69)*(Z(502)+Z(501)*U10+Z(501)*U3+Z(501)*U8
     &+Z(501)*U9) + (Z(473)+Z(477)+Z(483)+Z(490)+Z(496)+Z(506))*Z(54)*(U
     &3-U7) + Z(73)*(Z(511)+Z(510)*U10+Z(510)*U11+Z(510)*U3+Z(510)*U8+Z(
     &510)*U9) + (Z(469)+Z(472)+Z(476)+Z(482)+Z(489)+Z(495)+Z(505))*Z(35
     &)*(U3-U6-U7) + Z(65)*(Z(500)+Z(509)+Z(499)*U10+Z(499)*U3+Z(499)*U8
     &+Z(499)*U9+Z(504)*U10+Z(504)*U3+Z(504)*U8+Z(504)*U9) + 0.5D0*(Z(46
     &5)+2*Z(468)+2*Z(471)+2*Z(475)+2*Z(481)+2*Z(488)+2*Z(494)+2*Z(504))
     &*Z(50)*(U3-U5-U6-U7) - Z(492)*Z(2)*U3 - (Z(463)+Z(464)+Z(467)+Z(47
     &0)+Z(474)+Z(480)+Z(487)+Z(493)+Z(503))*Z(39)*(U3-U4-U5-U6-U7) - Z(
     &58)*(Z(479)+Z(484)+Z(497)+Z(507)-Z(478)*U3-Z(478)*U8-Z(483)*U3-Z(4
     &83)*U8-Z(496)*U3-Z(496)*U8-Z(506)*U3-Z(506)*U8) - Z(61)*(Z(486)+Z(
     &498)+Z(508)-Z(485)*U3-Z(485)*U8-Z(485)*U9-Z(495)*U3-Z(495)*U8-Z(49
     &5)*U9-Z(505)*U3-Z(505)*U8-Z(505)*U9)
      PY = Z(491)*Z(2) + Z(492)*Z(1)*U3 + (MA+MB+MC+MD+ME+MF+MG+MH+MI)*U
     &2 + 0.5D0*Z(466)*Z(47)*(U3-U5-U6-U7) + Z(70)*(Z(502)+Z(501)*U10+Z(
     &501)*U3+Z(501)*U8+Z(501)*U9) + (Z(473)+Z(477)+Z(483)+Z(490)+Z(496)
     &+Z(506))*Z(55)*(U3-U7) + Z(74)*(Z(511)+Z(510)*U10+Z(510)*U11+Z(510
     &)*U3+Z(510)*U8+Z(510)*U9) + (Z(469)+Z(472)+Z(476)+Z(482)+Z(489)+Z(
     &495)+Z(505))*Z(36)*(U3-U6-U7) + Z(66)*(Z(500)+Z(509)+Z(499)*U10+Z(
     &499)*U3+Z(499)*U8+Z(499)*U9+Z(504)*U10+Z(504)*U3+Z(504)*U8+Z(504)*
     &U9) + 0.5D0*(Z(465)+2*Z(468)+2*Z(471)+2*Z(475)+2*Z(481)+2*Z(488)+2
     &*Z(494)+2*Z(504))*Z(51)*(U3-U5-U6-U7) - (Z(463)+Z(464)+Z(467)+Z(47
     &0)+Z(474)+Z(480)+Z(487)+Z(493)+Z(503))*Z(40)*(U3-U4-U5-U6-U7) - Z(
     &56)*(Z(479)+Z(484)+Z(497)+Z(507)-Z(478)*U3-Z(478)*U8-Z(483)*U3-Z(4
     &83)*U8-Z(496)*U3-Z(496)*U8-Z(506)*U3-Z(506)*U8) - Z(62)*(Z(486)+Z(
     &498)+Z(508)-Z(485)*U3-Z(485)*U8-Z(485)*U9-Z(495)*U3-Z(495)*U8-Z(49
     &5)*U9-Z(505)*U3-Z(505)*U8-Z(505)*U9)
      HANG = 3.141592653589793D0 + Q7
      KANG = 3.141592653589793D0 - Q6
      AANG = 3.141592653589793D0 + Q5
      HANGVEL = U7
      KANGVEL = -U6
      AANGVEL = U5
      SHANG = EA
      SKANG = FA
      SHANGVEL = EAp
      SKANGVEL = FAp
      Z(530) = Z(529)*Z(56) + L10*VRX1*Z(58) + L10*VRY1*Z(56) + L6*VRX1*
     &Z(65) + L6*VRY1*Z(66) + L8*VRX1*Z(61) + L8*VRY1*Z(62) + Z(224)*(L1
     &0*Z(56)+Z(22)*Z(62)) + Z(226)*(L10*Z(56)+L8*Z(62)+Z(24)*Z(66)+Z(25
     &)*Z(70)) + Z(227)*(L10*Z(56)+L6*Z(66)+L8*Z(62)+Z(26)*Z(74)) + Z(22
     &8)*(L10*Z(56)+L2*Z(74)+L6*Z(66)+L8*Z(62)) - L5*VRX1*Z(69) - L5*VRY
     &1*Z(70)
      Z(653) = Z(547) + Z(549) + Z(551) + Z(478)*(Z(241)*Z(165)-Z(183)-Z
     &(245)*Z(173)-Z(249)*Z(177)-Z(253)*Z(181)) + MF*(L10*Z(15)*Z(189)+Z
     &(22)*Z(15)*Z(186)+L10*Z(16)*Z(191)+L10*Z(241)*Z(165)+Z(22)*Z(257)*
     &Z(165)-L10*Z(186)-Z(22)*Z(189)-L10*Z(245)*Z(173)-L10*Z(249)*Z(177)
     &-L10*Z(253)*Z(181)-Z(22)*Z(16)*Z(187)-Z(22)*Z(261)*Z(173)-Z(22)*Z(
     &265)*Z(177)-Z(22)*Z(269)*Z(181)) + MH*(Z(24)*Z(208)+Z(25)*Z(209)+Z
     &(621)*Z(209)+Z(622)*Z(208)+L10*Z(15)*Z(193)+L8*Z(15)*Z(186)+Z(24)*
     &Z(17)*Z(193)+L10*Z(208)*Z(307)+L10*Z(209)*Z(311)+L8*Z(209)*Z(315)+
     &Z(623)*Z(210)+L10*Z(16)*Z(194)+L10*Z(241)*Z(165)+L8*Z(257)*Z(165)+
     &Z(24)*Z(18)*Z(194)+Z(24)*Z(273)*Z(165)+Z(25)*Z(277)*Z(165)-L10*Z(1
     &86)-L8*Z(193)-L8*Z(17)*Z(208)-Z(24)*Z(186)*Z(307)-Z(25)*Z(186)*Z(3
     &11)-Z(25)*Z(193)*Z(315)-Z(624)*Z(211)-L10*Z(245)*Z(173)-L10*Z(249)
     &*Z(177)-L10*Z(253)*Z(181)-L10*Z(306)*Z(210)-L10*Z(310)*Z(211)-L8*Z
     &(16)*Z(187)-L8*Z(18)*Z(210)-L8*Z(261)*Z(173)-L8*Z(265)*Z(177)-L8*Z
     &(269)*Z(181)-L8*Z(314)*Z(211)-Z(24)*Z(281)*Z(173)-Z(24)*Z(289)*Z(1
     &77)-Z(24)*Z(297)*Z(181)-Z(24)*Z(305)*Z(187)-Z(25)*Z(285)*Z(173)-Z(
     &25)*Z(293)*Z(177)-Z(25)*Z(301)*Z(181)-Z(25)*Z(309)*Z(187)-Z(25)*Z(
     &313)*Z(194)) + MI*(L6*Z(201)+Z(26)*Z(213)+L10*Z(15)*Z(193)+L6*Z(17
     &)*Z(193)+L8*Z(15)*Z(186)+L10*Z(201)*Z(307)+L10*Z(213)*Z(335)+L8*Z(
     &213)*Z(339)+L10*Z(16)*Z(194)+L10*Z(241)*Z(165)+L6*Z(18)*Z(194)+L6*
     &Z(273)*Z(165)+L8*Z(257)*Z(165)+Z(26)*Z(20)*Z(204)+Z(26)*Z(317)*Z(1
     &65)-L10*Z(186)-L8*Z(193)-L6*Z(19)*Z(213)-L8*Z(17)*Z(201)-Z(26)*Z(1
     &9)*Z(201)-L6*Z(186)*Z(307)-Z(26)*Z(186)*Z(335)-Z(26)*Z(193)*Z(339)
     &-L10*Z(245)*Z(173)-L10*Z(249)*Z(177)-L10*Z(253)*Z(181)-L10*Z(306)*
     &Z(204)-L10*Z(334)*Z(215)-L6*Z(20)*Z(215)-L6*Z(281)*Z(173)-L6*Z(289
     &)*Z(177)-L6*Z(297)*Z(181)-L6*Z(305)*Z(187)-L8*Z(16)*Z(187)-L8*Z(18
     &)*Z(204)-L8*Z(261)*Z(173)-L8*Z(265)*Z(177)-L8*Z(269)*Z(181)-L8*Z(3
     &38)*Z(215)-Z(26)*Z(321)*Z(173)-Z(26)*Z(325)*Z(177)-Z(26)*Z(329)*Z(
     &181)-Z(26)*Z(333)*Z(187)-Z(26)*Z(337)*Z(194)) - Z(545)
      Z(688) = Z(530) - Z(653)
      Z(646) = Z(645) - Z(478)*(L2*Z(243)-Z(21)-L10*Z(255)-L6*Z(247)-L8*
     &Z(251)) - MF*(2*Z(591)*Z(15)+Z(582)*Z(243)+Z(592)*Z(259)-Z(584)-Z(
     &593)-Z(584)*Z(255)-Z(586)*Z(247)-Z(587)*Z(251)-Z(591)*Z(271)-Z(594
     &)*Z(263)-Z(595)*Z(267)) - MH*(2*Z(587)*Z(15)+2*Z(601)*Z(17)+Z(575)
     &*Z(259)+Z(582)*Z(243)+Z(602)*Z(275)+Z(603)*Z(279)-2*Z(606)-Z(577)-
     &Z(584)-Z(604)-Z(605)-2*Z(607)*Z(307)-2*Z(608)*Z(311)-2*Z(611)*Z(31
     &5)-Z(577)*Z(267)-Z(579)*Z(263)-Z(584)*Z(255)-Z(586)*Z(247)-Z(587)*
     &Z(251)-Z(587)*Z(271)-Z(601)*Z(291)-Z(607)*Z(299)-Z(608)*Z(303)-Z(6
     &09)*Z(283)-Z(610)*Z(287)-Z(611)*Z(295)) - MI*(2*Z(579)*Z(17)+2*Z(5
     &87)*Z(15)+2*Z(596)*Z(19)+Z(569)*Z(275)+Z(575)*Z(259)+Z(582)*Z(243)
     &+Z(597)*Z(319)-Z(572)-Z(577)-Z(584)-Z(598)-2*Z(586)*Z(307)-2*Z(599
     &)*Z(335)-2*Z(600)*Z(339)-Z(572)*Z(283)-Z(577)*Z(267)-Z(579)*Z(263)
     &-Z(579)*Z(291)-Z(584)*Z(255)-Z(586)*Z(247)-Z(586)*Z(299)-Z(587)*Z(
     &251)-Z(587)*Z(271)-Z(596)*Z(323)-Z(599)*Z(331)-Z(600)*Z(327))
      Z(647) = Z(478)*Z(56) + MF*(L10*Z(56)+Z(22)*Z(62)) + MH*(L10*Z(56)
     &+L8*Z(62)+Z(24)*Z(66)+Z(25)*Z(70)) + MI*(L10*Z(56)+L6*Z(66)+L8*Z(6
     &2)+Z(26)*Z(74))
      Z(648) = Z(478)*Z(58) + MF*(L10*Z(58)+Z(22)*Z(61)) + MH*(L10*Z(58)
     &+L8*Z(61)+Z(24)*Z(65)+Z(25)*Z(69)) + MI*(L10*Z(58)+L6*Z(65)+L8*Z(6
     &1)+Z(26)*Z(73))
      Z(649) = Z(478)*(L2*Z(243)-L10*Z(255)-L6*Z(247)-L8*Z(251)) + MF*(Z
     &(582)*Z(243)+Z(592)*Z(259)-Z(584)*Z(255)-Z(586)*Z(247)-Z(587)*Z(25
     &1)-Z(591)*Z(271)-Z(594)*Z(263)-Z(595)*Z(267)) + MH*(Z(575)*Z(259)+
     &Z(582)*Z(243)+Z(602)*Z(275)+Z(603)*Z(279)-Z(577)*Z(267)-Z(579)*Z(2
     &63)-Z(584)*Z(255)-Z(586)*Z(247)-Z(587)*Z(251)-Z(587)*Z(271)-Z(601)
     &*Z(291)-Z(607)*Z(299)-Z(608)*Z(303)-Z(609)*Z(283)-Z(610)*Z(287)-Z(
     &611)*Z(295)) + MI*(Z(569)*Z(275)+Z(575)*Z(259)+Z(582)*Z(243)+Z(597
     &)*Z(319)-Z(572)*Z(283)-Z(577)*Z(267)-Z(579)*Z(263)-Z(579)*Z(291)-Z
     &(584)*Z(255)-Z(586)*Z(247)-Z(586)*Z(299)-Z(587)*Z(251)-Z(587)*Z(27
     &1)-Z(596)*Z(323)-Z(599)*Z(331)-Z(600)*Z(327))
      Z(650) = Z(478)*(L2*Z(243)-L6*Z(247)-L8*Z(251)) + MF*(Z(582)*Z(243
     &)+Z(592)*Z(259)-Z(586)*Z(247)-Z(587)*Z(251)-Z(594)*Z(263)-Z(595)*Z
     &(267)) + MH*(Z(575)*Z(259)+Z(582)*Z(243)+Z(602)*Z(275)+Z(603)*Z(27
     &9)-Z(577)*Z(267)-Z(579)*Z(263)-Z(586)*Z(247)-Z(587)*Z(251)-Z(601)*
     &Z(291)-Z(609)*Z(283)-Z(610)*Z(287)-Z(611)*Z(295)) + MI*(Z(569)*Z(2
     &75)+Z(575)*Z(259)+Z(582)*Z(243)+Z(597)*Z(319)-Z(572)*Z(283)-Z(577)
     &*Z(267)-Z(579)*Z(263)-Z(579)*Z(291)-Z(586)*Z(247)-Z(587)*Z(251)-Z(
     &596)*Z(323)-Z(600)*Z(327))
      Z(651) = Z(478)*(L2*Z(243)-L6*Z(247)) + MF*(Z(582)*Z(243)+Z(592)*Z
     &(259)-Z(586)*Z(247)-Z(594)*Z(263)) + MH*(Z(575)*Z(259)+Z(582)*Z(24
     &3)+Z(602)*Z(275)+Z(603)*Z(279)-Z(579)*Z(263)-Z(586)*Z(247)-Z(609)*
     &Z(283)-Z(610)*Z(287)) - MI*(Z(572)*Z(283)+Z(579)*Z(263)+Z(586)*Z(2
     &47)+Z(596)*Z(323)-Z(569)*Z(275)-Z(575)*Z(259)-Z(582)*Z(243)-Z(597)
     &*Z(319))
      Z(652) = L2*(Z(478)*Z(243)+MF*(L10*Z(243)+Z(22)*Z(259))+MH*(L10*Z(
     &243)+L8*Z(259)+Z(24)*Z(275)+Z(25)*Z(279))+MI*(L10*Z(243)+L6*Z(275)
     &+L8*Z(259)+Z(26)*Z(319)))
      SHTOR = Z(688) - Z(646)*U3p - Z(647)*U2p - Z(648)*U1p - Z(649)*U7p
     & - Z(650)*U6p - Z(651)*U5p - Z(652)*U4p
      Z(655) = Z(654) - Z(485)*(L10*Z(15)+L2*Z(259)-Z(22)-L10*Z(271)-L6*
     &Z(263)-L8*Z(267)) - MH*(Z(587)*Z(15)+2*Z(601)*Z(17)+Z(575)*Z(259)+
     &Z(602)*Z(275)+Z(603)*Z(279)-2*Z(606)-Z(577)-Z(604)-Z(605)-2*Z(611)
     &*Z(315)-Z(577)*Z(267)-Z(579)*Z(263)-Z(587)*Z(271)-Z(601)*Z(291)-Z(
     &607)*Z(299)-Z(607)*Z(307)-Z(608)*Z(303)-Z(608)*Z(311)-Z(609)*Z(283
     &)-Z(610)*Z(287)-Z(611)*Z(295)) - MI*(Z(587)*Z(15)+2*Z(579)*Z(17)+2
     &*Z(596)*Z(19)+Z(569)*Z(275)+Z(575)*Z(259)+Z(597)*Z(319)-Z(572)-Z(5
     &77)-Z(598)-2*Z(600)*Z(339)-Z(572)*Z(283)-Z(577)*Z(267)-Z(579)*Z(26
     &3)-Z(579)*Z(291)-Z(586)*Z(299)-Z(586)*Z(307)-Z(587)*Z(271)-Z(596)*
     &Z(323)-Z(599)*Z(331)-Z(599)*Z(335)-Z(600)*Z(327))
      Z(656) = Z(485)*Z(61) + MH*(L8*Z(61)+Z(24)*Z(65)+Z(25)*Z(69)) + MI
     &*(L6*Z(65)+L8*Z(61)+Z(26)*Z(73))
      Z(657) = Z(485)*Z(62) + MH*(L8*Z(62)+Z(24)*Z(66)+Z(25)*Z(70)) + MI
     &*(L6*Z(66)+L8*Z(62)+Z(26)*Z(74))
      Z(658) = Z(485)*(L2*Z(259)-L10*Z(271)-L6*Z(263)-L8*Z(267)) + MH*(Z
     &(575)*Z(259)+Z(602)*Z(275)+Z(603)*Z(279)-Z(577)*Z(267)-Z(579)*Z(26
     &3)-Z(587)*Z(271)-Z(601)*Z(291)-Z(607)*Z(299)-Z(608)*Z(303)-Z(609)*
     &Z(283)-Z(610)*Z(287)-Z(611)*Z(295)) + MI*(Z(569)*Z(275)+Z(575)*Z(2
     &59)+Z(597)*Z(319)-Z(572)*Z(283)-Z(577)*Z(267)-Z(579)*Z(263)-Z(579)
     &*Z(291)-Z(586)*Z(299)-Z(587)*Z(271)-Z(596)*Z(323)-Z(599)*Z(331)-Z(
     &600)*Z(327))
      Z(659) = Z(485)*(L2*Z(259)-L6*Z(263)-L8*Z(267)) + MH*(Z(575)*Z(259
     &)+Z(602)*Z(275)+Z(603)*Z(279)-Z(577)*Z(267)-Z(579)*Z(263)-Z(601)*Z
     &(291)-Z(609)*Z(283)-Z(610)*Z(287)-Z(611)*Z(295)) + MI*(Z(569)*Z(27
     &5)+Z(575)*Z(259)+Z(597)*Z(319)-Z(572)*Z(283)-Z(577)*Z(267)-Z(579)*
     &Z(263)-Z(579)*Z(291)-Z(596)*Z(323)-Z(600)*Z(327))
      Z(660) = Z(485)*(L2*Z(259)-L6*Z(263)) + MH*(Z(575)*Z(259)+Z(602)*Z
     &(275)+Z(603)*Z(279)-Z(579)*Z(263)-Z(609)*Z(283)-Z(610)*Z(287)) - M
     &I*(Z(572)*Z(283)+Z(579)*Z(263)+Z(596)*Z(323)-Z(569)*Z(275)-Z(575)*
     &Z(259)-Z(597)*Z(319))
      Z(661) = L2*(Z(485)*Z(259)+MH*(L8*Z(259)+Z(24)*Z(275)+Z(25)*Z(279)
     &)+MI*(L6*Z(275)+L8*Z(259)+Z(26)*Z(319)))
      Z(532) = Z(531)*Z(62) + L6*VRX1*Z(65) + L6*VRY1*Z(66) + L8*VRX1*Z(
     &61) + L8*VRY1*Z(62) + Z(226)*(L8*Z(62)+Z(24)*Z(66)+Z(25)*Z(70)) + 
     &Z(227)*(L6*Z(66)+L8*Z(62)+Z(26)*Z(74)) + Z(228)*(L2*Z(74)+L6*Z(66)
     &+L8*Z(62)) - L5*VRX1*Z(69) - L5*VRY1*Z(70)
      Z(662) = Z(547) + Z(549) + Z(551) + Z(485)*(Z(15)*Z(186)+Z(257)*Z(
     &165)-Z(189)-Z(16)*Z(187)-Z(261)*Z(173)-Z(265)*Z(177)-Z(269)*Z(181)
     &) + MH*(Z(24)*Z(208)+Z(25)*Z(209)+Z(621)*Z(209)+Z(622)*Z(208)+L8*Z
     &(15)*Z(186)+Z(24)*Z(17)*Z(193)+L8*Z(209)*Z(315)+Z(623)*Z(210)+L8*Z
     &(257)*Z(165)+Z(24)*Z(18)*Z(194)+Z(24)*Z(273)*Z(165)+Z(25)*Z(277)*Z
     &(165)-L8*Z(193)-L8*Z(17)*Z(208)-Z(24)*Z(186)*Z(307)-Z(25)*Z(186)*Z
     &(311)-Z(25)*Z(193)*Z(315)-Z(624)*Z(211)-L8*Z(16)*Z(187)-L8*Z(18)*Z
     &(210)-L8*Z(261)*Z(173)-L8*Z(265)*Z(177)-L8*Z(269)*Z(181)-L8*Z(314)
     &*Z(211)-Z(24)*Z(281)*Z(173)-Z(24)*Z(289)*Z(177)-Z(24)*Z(297)*Z(181
     &)-Z(24)*Z(305)*Z(187)-Z(25)*Z(285)*Z(173)-Z(25)*Z(293)*Z(177)-Z(25
     &)*Z(301)*Z(181)-Z(25)*Z(309)*Z(187)-Z(25)*Z(313)*Z(194)) + MI*(L6*
     &Z(201)+Z(26)*Z(213)+L6*Z(17)*Z(193)+L8*Z(15)*Z(186)+L8*Z(213)*Z(33
     &9)+L6*Z(18)*Z(194)+L6*Z(273)*Z(165)+L8*Z(257)*Z(165)+Z(26)*Z(20)*Z
     &(204)+Z(26)*Z(317)*Z(165)-L8*Z(193)-L6*Z(19)*Z(213)-L8*Z(17)*Z(201
     &)-Z(26)*Z(19)*Z(201)-L6*Z(186)*Z(307)-Z(26)*Z(186)*Z(335)-Z(26)*Z(
     &193)*Z(339)-L6*Z(20)*Z(215)-L6*Z(281)*Z(173)-L6*Z(289)*Z(177)-L6*Z
     &(297)*Z(181)-L6*Z(305)*Z(187)-L8*Z(16)*Z(187)-L8*Z(18)*Z(204)-L8*Z
     &(261)*Z(173)-L8*Z(265)*Z(177)-L8*Z(269)*Z(181)-L8*Z(338)*Z(215)-Z(
     &26)*Z(321)*Z(173)-Z(26)*Z(325)*Z(177)-Z(26)*Z(329)*Z(181)-Z(26)*Z(
     &333)*Z(187)-Z(26)*Z(337)*Z(194))
      Z(689) = Z(532) - Z(662)
      SKTOR = Z(655)*U3p + Z(656)*U1p + Z(657)*U2p + Z(658)*U7p + Z(659)
     &*U6p + Z(660)*U5p + Z(661)*U4p - Z(689)
      Z(664) = Z(663) - MH*(Z(601)*Z(17)+Z(602)*Z(275)+Z(603)*Z(279)-2*Z
     &(606)-Z(604)-Z(605)-Z(601)*Z(291)-Z(607)*Z(299)-Z(607)*Z(307)-Z(60
     &8)*Z(303)-Z(608)*Z(311)-Z(609)*Z(283)-Z(610)*Z(287)-Z(611)*Z(295)-
     &Z(611)*Z(315)) - MI*(Z(579)*Z(17)+2*Z(596)*Z(19)+Z(569)*Z(275)+Z(5
     &97)*Z(319)-Z(572)-Z(598)-Z(572)*Z(283)-Z(579)*Z(291)-Z(586)*Z(299)
     &-Z(586)*Z(307)-Z(596)*Z(323)-Z(599)*Z(331)-Z(599)*Z(335)-Z(600)*Z(
     &327)-Z(600)*Z(339))
      Z(665) = MH*(Z(24)*Z(65)+Z(25)*Z(69)) + MI*(L6*Z(65)+Z(26)*Z(73))
      Z(666) = MH*(Z(24)*Z(66)+Z(25)*Z(70)) + MI*(L6*Z(66)+Z(26)*Z(74))
      Z(667) = MH*(Z(602)*Z(275)+Z(603)*Z(279)-Z(601)*Z(291)-Z(607)*Z(29
     &9)-Z(608)*Z(303)-Z(609)*Z(283)-Z(610)*Z(287)-Z(611)*Z(295)) + MI*(
     &Z(569)*Z(275)+Z(597)*Z(319)-Z(572)*Z(283)-Z(579)*Z(291)-Z(586)*Z(2
     &99)-Z(596)*Z(323)-Z(599)*Z(331)-Z(600)*Z(327))
      Z(668) = MH*(Z(602)*Z(275)+Z(603)*Z(279)-Z(601)*Z(291)-Z(609)*Z(28
     &3)-Z(610)*Z(287)-Z(611)*Z(295)) + MI*(Z(569)*Z(275)+Z(597)*Z(319)-
     &Z(572)*Z(283)-Z(579)*Z(291)-Z(596)*Z(323)-Z(600)*Z(327))
      Z(669) = MH*(Z(602)*Z(275)+Z(603)*Z(279)-Z(609)*Z(283)-Z(610)*Z(28
     &7)) - MI*(Z(572)*Z(283)+Z(596)*Z(323)-Z(569)*Z(275)-Z(597)*Z(319))
      Z(670) = L2*(MH*(Z(24)*Z(275)+Z(25)*Z(279))+MI*(L6*Z(275)+Z(26)*Z(
     &319)))
      Z(533) = L6*VRX1*Z(65) + L6*VRY1*Z(66) + Z(226)*(Z(24)*Z(66)+Z(25)
     &*Z(70)) + Z(227)*(L6*Z(66)+Z(26)*Z(74)) + Z(228)*(L2*Z(74)+L6*Z(66
     &)) - L5*VRX1*Z(69) - L5*VRY1*Z(70)
      Z(671) = Z(549) + Z(551) + MH*(Z(24)*Z(208)+Z(25)*Z(209)+Z(621)*Z(
     &209)+Z(622)*Z(208)+Z(24)*Z(17)*Z(193)+Z(623)*Z(210)+Z(24)*Z(18)*Z(
     &194)+Z(24)*Z(273)*Z(165)+Z(25)*Z(277)*Z(165)-Z(24)*Z(186)*Z(307)-Z
     &(25)*Z(186)*Z(311)-Z(25)*Z(193)*Z(315)-Z(624)*Z(211)-Z(24)*Z(281)*
     &Z(173)-Z(24)*Z(289)*Z(177)-Z(24)*Z(297)*Z(181)-Z(24)*Z(305)*Z(187)
     &-Z(25)*Z(285)*Z(173)-Z(25)*Z(293)*Z(177)-Z(25)*Z(301)*Z(181)-Z(25)
     &*Z(309)*Z(187)-Z(25)*Z(313)*Z(194)) + MI*(L6*Z(201)+Z(26)*Z(213)+L
     &6*Z(17)*Z(193)+L6*Z(18)*Z(194)+L6*Z(273)*Z(165)+Z(26)*Z(20)*Z(204)
     &+Z(26)*Z(317)*Z(165)-L6*Z(19)*Z(213)-Z(26)*Z(19)*Z(201)-L6*Z(186)*
     &Z(307)-Z(26)*Z(186)*Z(335)-Z(26)*Z(193)*Z(339)-L6*Z(20)*Z(215)-L6*
     &Z(281)*Z(173)-L6*Z(289)*Z(177)-L6*Z(297)*Z(181)-L6*Z(305)*Z(187)-Z
     &(26)*Z(321)*Z(173)-Z(26)*Z(325)*Z(177)-Z(26)*Z(329)*Z(181)-Z(26)*Z
     &(333)*Z(187)-Z(26)*Z(337)*Z(194))
      Z(690) = Z(533) - Z(671)
      SATOR = Z(664)*U3p + Z(665)*U1p + Z(666)*U2p + Z(667)*U7p + Z(668)
     &*U6p + Z(669)*U5p + Z(670)*U4p - Z(690)
      Z(672) = INI - Z(510)*(L6*Z(19)+L2*Z(319)-Z(26)-L10*Z(331)-L10*Z(3
     &35)-L6*Z(323)-L8*Z(327)-L8*Z(339))
      Z(673) = Z(510)*Z(73)
      Z(674) = Z(510)*Z(74)
      Z(675) = Z(510)*(L2*Z(319)-L10*Z(331)-L6*Z(323)-L8*Z(327))
      Z(676) = Z(510)*(L2*Z(319)-L6*Z(323)-L8*Z(327))
      Z(677) = Z(510)*(L2*Z(319)-L6*Z(323))
      Z(679) = Z(678)*Z(319)
      Z(535) = Z(74)*(Z(534)+L2*Z(228))
      Z(680) = Z(551) + Z(510)*(Z(213)+Z(20)*Z(204)+Z(317)*Z(165)-Z(19)*
     &Z(201)-Z(186)*Z(335)-Z(193)*Z(339)-Z(321)*Z(173)-Z(325)*Z(177)-Z(3
     &29)*Z(181)-Z(333)*Z(187)-Z(337)*Z(194))
      Z(691) = Z(535) - Z(680)
      SMTOR = Z(672)*U3p + Z(673)*U1p + Z(674)*U2p + Z(675)*U7p + Z(676)
     &*U6p + Z(677)*U5p + Z(679)*U4p - Z(691)
      POP1X = Q1
      POP1Y = Q2
      POP3X = Q1 + L5*Z(44) - L2*Z(37)
      POP3Y = Q2 + L5*Z(45) - L2*Z(38)
      POP4X = Q1 + L6*Z(48) - L2*Z(37)
      POP4Y = Q2 + L6*Z(49) - L2*Z(38)
      POP5X = Q1 + L6*Z(48) + L8*Z(33) - L2*Z(37)
      POP5Y = Q2 + L6*Z(49) + L8*Z(34) - L2*Z(38)
      POP6X = Q1 + L10*Z(52) + L6*Z(48) + L8*Z(33) - L2*Z(37)
      POP6Y = Q2 + L10*Z(53) + L6*Z(49) + L8*Z(34) - L2*Z(38)
      POP7X = Q1 + L10*Z(52) + L10*Z(56) + L6*Z(48) + L8*Z(33) - L2*Z(37
     &)
      POP7Y = Q2 + L10*Z(53) + L10*Z(57) + L6*Z(49) + L8*Z(34) - L2*Z(38
     &)
      POP8X = Q1 + L10*Z(52) + L10*Z(56) + L6*Z(48) + L8*Z(33) + L8*Z(59
     &) - L2*Z(37)
      POP8Y = Q2 + L10*Z(53) + L10*Z(57) + L6*Z(49) + L8*Z(34) + L8*Z(60
     &) - L2*Z(38)
      POP9X = Q1 + L10*Z(52) + L10*Z(56) + L6*Z(48) + L6*Z(63) + L8*Z(33
     &) + L8*Z(59) - L2*Z(37) - L5*Z(67)
      POP9Y = Q2 + L10*Z(53) + L10*Z(57) + L6*Z(49) + L6*Z(64) + L8*Z(34
     &) + L8*Z(60) - L2*Z(38) - L5*Z(68)
      POGOX = Q1 + L10*Z(52) + L6*Z(48) + L8*Z(33) + GS*Z(1) - L2*Z(37)
      POGOY = Q2 + L10*Z(53) + L6*Z(49) + L8*Z(34) + GS*Z(2) - L2*Z(38)
      POP10X = Q1 + L10*Z(52) + L10*Z(56) + L6*Z(48) + L6*Z(63) + L8*Z(3
     &3) + L8*Z(59) - L2*Z(37)
      POP10Y = Q2 + L10*Z(53) + L10*Z(57) + L6*Z(49) + L6*Z(64) + L8*Z(3
     &4) + L8*Z(60) - L2*Z(38)
      POP11X = Q1 + L10*Z(52) + L10*Z(56) + L2*Z(71) + L6*Z(48) + L6*Z(6
     &3) + L8*Z(33) + L8*Z(59) - L2*Z(37)
      POP11Y = Q2 + L10*Z(53) + L10*Z(57) + L2*Z(72) + L6*Z(49) + L6*Z(6
     &4) + L8*Z(34) + L8*Z(60) - L2*Z(38)
      POCMX = Q1 + Z(78)*Z(33) + Z(79)*Z(52) + Z(80)*Z(56) + Z(81)*Z(59)
     & + Z(83)*Z(63) + Z(84)*Z(71) + Z(85)*Z(67) + Z(82)*Z(1) + 0.5D0*Z(
     &77)*Z(48) + 0.5D0*Z(86)*Z(44) - Z(76)*Z(37)
      POCMSTANCEX = Q1 + Z(90)*Z(33) + Z(91)*Z(52) + 0.5D0*Z(89)*Z(48) +
     & 0.5D0*Z(92)*Z(44) - Z(88)*Z(37)
      POCMSTANCEY = Q2 + Z(90)*Z(34) + Z(91)*Z(53) + 0.5D0*Z(89)*Z(49) +
     & 0.5D0*Z(92)*Z(45) - Z(88)*Z(38)
      POCMSWINGX = Q1 + Z(95)*Z(48) + Z(96)*Z(33) + Z(97)*Z(52) + Z(98)*
     &Z(56) + Z(99)*Z(59) + Z(100)*Z(63) + Z(101)*Z(71) + Z(102)*Z(67) -
     & Z(94)*Z(37)
      POCMSWINGY = Q2 + Z(95)*Z(49) + Z(96)*Z(34) + Z(97)*Z(53) + Z(98)*
     &Z(57) + Z(99)*Z(60) + Z(100)*Z(64) + Z(101)*Z(72) + Z(102)*Z(68) -
     & Z(94)*Z(38)
      Z(151) = MG*GSp/Z(75)
      Z(152) = Z(80)*EAp
      Z(153) = Z(81)*(EAp-FAp)
      Z(154) = Z(83)*(FAp-EAp-HAp)
      Z(155) = Z(84)*(FAp-EAp-HAp-IAp)
      Z(156) = Z(85)*(FAp-EAp-HAp)
      Z(157) = Z(98)*EAp
      Z(158) = Z(99)*(EAp-FAp)
      Z(159) = Z(100)*(FAp-EAp-HAp)
      Z(160) = Z(101)*(FAp-EAp-HAp-IAp)
      Z(161) = Z(102)*(FAp-EAp-HAp)
      VOCMX = Z(151)*Z(1) + U1 + Z(79)*Z(54)*(U3-U7) + Z(78)*Z(35)*(U3-U
     &6-U7) + 0.5D0*Z(77)*Z(50)*(U3-U5-U6-U7) + 0.5D0*Z(86)*Z(46)*(U3-U5
     &-U6-U7) + Z(65)*(Z(154)+Z(83)*U10+Z(83)*U3+Z(83)*U8+Z(83)*U9) + Z(
     &69)*(Z(156)+Z(85)*U10+Z(85)*U3+Z(85)*U8+Z(85)*U9) + Z(73)*(Z(155)+
     &Z(84)*U10+Z(84)*U11+Z(84)*U3+Z(84)*U8+Z(84)*U9) - Z(82)*Z(2)*U3 - 
     &Z(58)*(Z(152)-Z(80)*U3-Z(80)*U8) - Z(76)*Z(39)*(U3-U4-U5-U6-U7) - 
     &Z(61)*(Z(153)-Z(81)*U3-Z(81)*U8-Z(81)*U9)
      VOCMY = Z(151)*Z(2) + U2 + Z(82)*Z(1)*U3 + Z(79)*Z(55)*(U3-U7) + Z
     &(78)*Z(36)*(U3-U6-U7) + 0.5D0*Z(77)*Z(51)*(U3-U5-U6-U7) + 0.5D0*Z(
     &86)*Z(47)*(U3-U5-U6-U7) + Z(66)*(Z(154)+Z(83)*U10+Z(83)*U3+Z(83)*U
     &8+Z(83)*U9) + Z(70)*(Z(156)+Z(85)*U10+Z(85)*U3+Z(85)*U8+Z(85)*U9) 
     &+ Z(74)*(Z(155)+Z(84)*U10+Z(84)*U11+Z(84)*U3+Z(84)*U8+Z(84)*U9) - 
     &Z(56)*(Z(152)-Z(80)*U3-Z(80)*U8) - Z(76)*Z(40)*(U3-U4-U5-U6-U7) - 
     &Z(62)*(Z(153)-Z(81)*U3-Z(81)*U8-Z(81)*U9)
      VOCMSTANCEX = U1 + Z(91)*Z(54)*(U3-U7) + Z(90)*Z(35)*(U3-U6-U7) + 
     &0.5D0*Z(89)*Z(50)*(U3-U5-U6-U7) + 0.5D0*Z(92)*Z(46)*(U3-U5-U6-U7) 
     &- Z(88)*Z(39)*(U3-U4-U5-U6-U7)
      VOCMSTANCEY = U2 + Z(91)*Z(55)*(U3-U7) + Z(90)*Z(36)*(U3-U6-U7) + 
     &0.5D0*Z(89)*Z(51)*(U3-U5-U6-U7) + 0.5D0*Z(92)*Z(47)*(U3-U5-U6-U7) 
     &- Z(88)*Z(40)*(U3-U4-U5-U6-U7)
      VOCMSWINGX = U1 + Z(97)*Z(54)*(U3-U7) + Z(96)*Z(35)*(U3-U6-U7) + Z
     &(95)*Z(50)*(U3-U5-U6-U7) + Z(65)*(Z(159)+Z(100)*U10+Z(100)*U3+Z(10
     &0)*U8+Z(100)*U9) + Z(69)*(Z(161)+Z(102)*U10+Z(102)*U3+Z(102)*U8+Z(
     &102)*U9) + Z(73)*(Z(160)+Z(101)*U10+Z(101)*U11+Z(101)*U3+Z(101)*U8
     &+Z(101)*U9) - Z(58)*(Z(157)-Z(98)*U3-Z(98)*U8) - Z(94)*Z(39)*(U3-U
     &4-U5-U6-U7) - Z(61)*(Z(158)-Z(99)*U3-Z(99)*U8-Z(99)*U9)
      VOCMSWINGY = U2 + Z(97)*Z(55)*(U3-U7) + Z(96)*Z(36)*(U3-U6-U7) + Z
     &(95)*Z(51)*(U3-U5-U6-U7) + Z(66)*(Z(159)+Z(100)*U10+Z(100)*U3+Z(10
     &0)*U8+Z(100)*U9) + Z(70)*(Z(161)+Z(102)*U10+Z(102)*U3+Z(102)*U8+Z(
     &102)*U9) + Z(74)*(Z(160)+Z(101)*U10+Z(101)*U11+Z(101)*U3+Z(101)*U8
     &+Z(101)*U9) - Z(56)*(Z(157)-Z(98)*U3-Z(98)*U8) - Z(94)*Z(40)*(U3-U
     &4-U5-U6-U7) - Z(62)*(Z(158)-Z(99)*U3-Z(99)*U8-Z(99)*U9)
      SAANG = HA
      SMANG = IA
      SAANGVEL = HAp
      SMANGVEL = IAp
      PSWINGX = (ME+MF)*U1 + (Z(477)+Z(483))*Z(54)*(U3-U7) + (Z(476)+Z(4
     &82))*Z(35)*(U3-U6-U7) + (Z(475)+Z(481))*Z(50)*(U3-U5-U6-U7) - Z(61
     &)*(Z(486)-Z(485)*U3-Z(485)*U8-Z(485)*U9) - (Z(474)+Z(480))*Z(39)*(
     &U3-U4-U5-U6-U7) - Z(58)*(Z(479)+Z(484)-Z(478)*U3-Z(478)*U8-Z(483)*
     &U3-Z(483)*U8)
      PSWINGY = (ME+MF)*U2 + (Z(477)+Z(483))*Z(55)*(U3-U7) + (Z(476)+Z(4
     &82))*Z(36)*(U3-U6-U7) + (Z(475)+Z(481))*Z(51)*(U3-U5-U6-U7) - Z(62
     &)*(Z(486)-Z(485)*U3-Z(485)*U8-Z(485)*U9) - (Z(474)+Z(480))*Z(40)*(
     &U3-U4-U5-U6-U7) - Z(56)*(Z(479)+Z(484)-Z(478)*U3-Z(478)*U8-Z(483)*
     &U3-Z(483)*U8)
      PSTANCEX = (MA+MB+MC+MD)*U1 + Z(473)*Z(54)*(U3-U7) + (Z(469)+Z(472
     &))*Z(35)*(U3-U6-U7) + 0.5D0*Z(466)*Z(46)*(U3-U5-U6-U7) + 0.5D0*(Z(
     &465)+2*Z(468)+2*Z(471))*Z(50)*(U3-U5-U6-U7) - (Z(463)+Z(464)+Z(467
     &)+Z(470))*Z(39)*(U3-U4-U5-U6-U7)
      PSTANCEY = (MA+MB+MC+MD)*U2 + Z(473)*Z(55)*(U3-U7) + (Z(469)+Z(472
     &))*Z(36)*(U3-U6-U7) + 0.5D0*Z(466)*Z(47)*(U3-U5-U6-U7) + 0.5D0*(Z(
     &465)+2*Z(468)+2*Z(471))*Z(51)*(U3-U5-U6-U7) - (Z(463)+Z(464)+Z(467
     &)+Z(470))*Z(40)*(U3-U4-U5-U6-U7)

C**   Write output to screen and to output file(s)
      WRITE(*, 6020) T,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,P
     &OP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,POP10X,
     &POP10Y,POP11X,POP11Y,POGOX,POGOY
      WRITE(21,6020) T,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,P
     &OP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,POP10X,
     &POP10Y,POP11X,POP11Y,POGOX,POGOY
      WRITE(22,6020) T,POCMSTANCEX,POCMSTANCEY,POCMSWINGX,POCMSWINGY,POC
     &MX,POCMY,VOCMX,VOCMY,PSTANCEX,PSTANCEY,PSWINGX,PSWINGY,VOCMSTANCEX
     &,VOCMSTANCEY,VOCMSWINGX,VOCMSWINGY
      WRITE(23,6020) T,Q1,Q2,(Q3*RADtoDEG),(Q4*RADtoDEG),(Q5*RADtoDEG),(
     &Q6*RADtoDEG),(Q7*RADtoDEG),U1,U2,U3,U4,U5,U6,U7
      WRITE(24,6020) T,RX1,RY1,RX2,RY2,VRX1,VRY1,VRX2,VRY2,HTOR,KTOR,ATO
     &R,MTOR,SHTOR,SKTOR,SATOR,SMTOR
      WRITE(25,6020) T,(Q3*RADtoDEG),(HANG*RADtoDEG),(KANG*RADtoDEG),(AA
     &NG*RADtoDEG),(MANG*RADtoDEG),(SHANG*RADtoDEG),(SKANG*RADtoDEG),SAA
     &NG,SMANG,U3,HANGVEL,KANGVEL,AANGVEL,MANGVEL,SHANGVEL,SKANGVEL,SAAN
     &GVEL,SMANGVEL
      WRITE(26,6020) T,KECM,PECM,TE,HZ,PX,PY

6020  FORMAT( 99(1X, 1PE14.6E3) )

      RETURN
      END


