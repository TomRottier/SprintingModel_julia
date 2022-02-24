C**   The name of this program is model/7segsprint.f
C**   Created by AUTOLEV 3.2 on Thu Feb 24 18:12:57 2022

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
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(688),COEF(7,7),RHS(7)

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
      Z(222) = G*ME
      Z(528) = Z(21)*Z(222)
      Z(651) = INF + INH + INI
      Z(22) = L8 - L7
      Z(484) = MF*Z(22)
      Z(660) = INH + INI
      Z(578) = L6*L8
      Z(25) = L2 - L1
      Z(509) = MI*Z(25)
      Z(7) = COS(FOOTANG)
      Z(8) = SIN(FOOTANG)
      Z(23) = L6 - L4
      Z(24) = 0.5D0*L6 + 0.5D0*Z(23)
      Z(74) = MA + MB + MC + MD + ME + MF + MG + MH + MI
      Z(75) = (L1*MA+L2*MB+L2*MC+L2*MD+L2*ME+L2*MF+L2*MG+L2*MH+L2*MI)/Z(
     &74)
      Z(76) = (L4*MB+2*L6*MC+2*L6*MD+2*L6*ME+2*L6*MF+2*L6*MG+2*L6*MH+2*L
     &6*MI)/Z(74)
      Z(77) = (L7*MC+L8*MD+L8*ME+L8*MF+L8*MG+L8*MH+L8*MI)/Z(74)
      Z(78) = (L10*ME+L10*MF+L10*MG+L10*MH+L10*MI+L9*MD)/Z(74)
      Z(79) = (L10*MF+L10*MH+L10*MI+ME*Z(21))/Z(74)
      Z(80) = (L8*MH+L8*MI+MF*Z(22))/Z(74)
      Z(82) = (L6*MI+MH*Z(24))/Z(74)
      Z(83) = MI*Z(25)/Z(74)
      Z(84) = L3*MH/Z(74)
      Z(85) = L3*MB/Z(74)
      Z(86) = MA + MB + MC + MD
      Z(87) = (L1*MA+L2*MB+L2*MC+L2*MD)/Z(86)
      Z(88) = (L4*MB+2*L6*MC+2*L6*MD)/Z(86)
      Z(89) = (L7*MC+L8*MD)/Z(86)
      Z(90) = L9*MD/Z(86)
      Z(91) = L3*MB/Z(86)
      Z(92) = ME + MF + MH + MI
      Z(93) = L2*(ME+MF+MH+MI)/Z(92)
      Z(94) = L6*(ME+MF+MH+MI)/Z(92)
      Z(95) = L8*(ME+MF+MH+MI)/Z(92)
      Z(96) = L10*(ME+MF+MH+MI)/Z(92)
      Z(97) = (L10*MF+L10*MH+L10*MI+ME*Z(21))/Z(92)
      Z(98) = (L8*MH+L8*MI+MF*Z(22))/Z(92)
      Z(99) = (L6*MI+MH*Z(24))/Z(92)
      Z(100) = MI*Z(25)/Z(92)
      Z(101) = L3*MH/Z(92)
      Z(218) = G*MA
      Z(219) = G*MB
      Z(220) = G*MC
      Z(221) = G*MD
      Z(223) = G*MF
      Z(224) = G*MG
      Z(225) = G*MH
      Z(226) = G*MI
      Z(346) = Z(75) - L1
      Z(347) = Z(75) - L2
      Z(348) = 0.5D0*L4 - 0.5D0*Z(76)
      Z(349) = 0.5D0*L3 - 0.5D0*Z(85)
      Z(377) = L6 - 0.5D0*Z(76)
      Z(378) = L7 - Z(77)
      Z(379) = L8 - Z(77)
      Z(380) = L9 - Z(78)
      Z(381) = L10 - Z(78)
      Z(382) = Z(21) - Z(79)
      Z(383) = L10 - Z(79)
      Z(384) = Z(22) - Z(80)
      Z(386) = L8 - Z(80)
      Z(387) = Z(24) - Z(82)
      Z(388) = 0.5D0*Z(84) - 0.5D0*L3
      Z(392) = L6 - Z(82)
      Z(393) = Z(25) - Z(83)
      Z(398) = 2*Z(348) + 2*Z(7)*Z(349)
      Z(402) = 2*Z(349) + 2*Z(7)*Z(348)
      Z(405) = Z(7)*Z(85)
      Z(445) = 2*Z(387) + 2*Z(7)*Z(388)
      Z(449) = 2*Z(388) + 2*Z(7)*Z(387)
      Z(457) = 2*Z(392) + Z(7)*Z(84)
      Z(462) = L1*MA
      Z(463) = L2*MB
      Z(464) = L4*MB
      Z(465) = L3*MB
      Z(466) = L2*MC
      Z(467) = L6*MC
      Z(468) = L7*MC
      Z(469) = L2*MD
      Z(470) = L6*MD
      Z(471) = L8*MD
      Z(472) = L9*MD
      Z(473) = L2*ME
      Z(474) = L6*ME
      Z(475) = L8*ME
      Z(476) = L10*ME
      Z(477) = ME*Z(21)
      Z(479) = L2*MF
      Z(480) = L6*MF
      Z(481) = L8*MF
      Z(482) = L10*MF
      Z(486) = L2*MG
      Z(487) = L6*MG
      Z(488) = L8*MG
      Z(489) = L10*MG
      Z(492) = L2*MH
      Z(493) = L6*MH
      Z(494) = L8*MH
      Z(495) = L10*MH
      Z(498) = MH*Z(24)
      Z(500) = L3*MH
      Z(502) = L2*MI
      Z(503) = L6*MI
      Z(504) = L8*MI
      Z(505) = L10*MI
      Z(512) = Z(218) + Z(219) + Z(220) + Z(221) + Z(222) + Z(223) + Z(2
     &24) + Z(225) + Z(226)
      Z(514) = L1*Z(218)
      Z(516) = L2*Z(219)
      Z(517) = L2*Z(220)
      Z(518) = L2*Z(221)
      Z(519) = L2*Z(222)
      Z(520) = L2*Z(223)
      Z(521) = L2*Z(224)
      Z(522) = L2*Z(225)
      Z(523) = L2*Z(226)
      Z(530) = Z(22)*Z(223)
      Z(533) = Z(25)*Z(226)
      Z(552) = L1*MA + L2*MB + L2*MC + L2*MD + L2*ME + L2*MF + L2*MG + L
     &2*MH + L2*MI
      Z(564) = INA + INB + INC + IND + INE + INF + ING + INH + INI + MA*
     &L1**2
      Z(565) = L3**2 + L4**2 + 4*L2**2 + 2*L3*L4*Z(7)
      Z(566) = L2*L3
      Z(567) = L2*L4
      Z(568) = L2*L6
      Z(569) = L2*L7
      Z(570) = L2**2
      Z(571) = L6**2
      Z(572) = L7**2
      Z(573) = L6*L7
      Z(574) = L2*L8
      Z(575) = L2*L9
      Z(576) = L8**2
      Z(577) = L9**2
      Z(579) = L6*L9
      Z(580) = L8*L9
      Z(581) = L10*L2
      Z(582) = L2*Z(21)
      Z(583) = L10**2
      Z(584) = Z(21)**2
      Z(585) = L10*L6
      Z(586) = L10*L8
      Z(587) = L10*Z(21)
      Z(588) = L6*Z(21)
      Z(589) = L8*Z(21)
      Z(590) = L10*Z(22)
      Z(591) = L2*Z(22)
      Z(592) = Z(22)**2
      Z(593) = L6*Z(22)
      Z(594) = L8*Z(22)
      Z(595) = L6*Z(25)
      Z(596) = L2*Z(25)
      Z(597) = Z(25)**2
      Z(598) = L10*Z(25)
      Z(599) = L8*Z(25)
      Z(600) = L3*Z(7)*Z(24)
      Z(601) = L8*Z(24)
      Z(602) = L10*L3
      Z(603) = L3*L6
      Z(604) = L3*L8
      Z(605) = L2*Z(24)
      Z(606) = L3**2
      Z(607) = Z(24)**2
      Z(608) = L10*Z(24)
      Z(609) = L6*Z(24)
      Z(611) = -INA - MA*L1**2
      Z(613) = MA*L1**2
      Z(617) = L3*Z(8)
      Z(618) = L4*Z(8)
      Z(619) = Z(8)*Z(24)
      Z(620) = L3*Z(7)
      Z(621) = Z(7)*Z(24)
      Z(623) = INA + MA*L1**2 + MB*L2**2 + MC*L2**2 + MD*L2**2 + ME*L2**
     &2 + MF*L2**2 + MG*L2**2 + MH*L2**2 + MI*L2**2
      Z(624) = INA + MA*L1**2
      Z(629) = INA + INB + MA*L1**2
      Z(630) = L2**2 + L6**2
      Z(635) = INA + INB + INC + MA*L1**2
      Z(639) = INA + INB + INC + IND + MA*L1**2
      Z(642) = INE + INF + INH + INI
      Z(675) = L2*MI*Z(25)

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
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(688),COEF(7,7),RHS(7)

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
      Z(227) = VRX2 + VRY2
      Z(229) = ATOR + KTOR
      Z(230) = -HTOR - KTOR

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
      Z(26) = Z(3)*Z(5) - Z(4)*Z(6)
      Z(1) = COS(Q3)
      Z(9) = COS(Q6)
      Z(12) = SIN(Q7)
      Z(10) = SIN(Q6)
      Z(11) = COS(Q7)
      Z(30) = -Z(9)*Z(12) - Z(10)*Z(11)
      Z(2) = SIN(Q3)
      Z(29) = Z(9)*Z(11) - Z(10)*Z(12)
      Z(33) = Z(1)*Z(30) + Z(2)*Z(29)
      Z(27) = -Z(3)*Z(6) - Z(4)*Z(5)
      Z(31) = Z(9)*Z(12) + Z(10)*Z(11)
      Z(35) = Z(1)*Z(29) + Z(2)*Z(31)
      Z(37) = Z(26)*Z(33) + Z(27)*Z(35)
      POP2Y = Q2 - L2*Z(37)
      Z(28) = Z(3)*Z(6) + Z(4)*Z(5)
      Z(39) = Z(26)*Z(35) + Z(28)*Z(33)
      VOP2Y = U2 - L2*Z(39)*(U3-U4-U5-U6-U7)
      RY2 = -K7*POP2Y - K8*ABS(POP2Y)*VOP2Y
      Z(32) = Z(1)*Z(29) - Z(2)*Z(30)
      Z(34) = Z(1)*Z(31) - Z(2)*Z(29)
      Z(36) = Z(26)*Z(32) + Z(27)*Z(34)
      POP2X = Q1 - L2*Z(36)
      DP2X = POP2X - POP2XI
      Z(38) = Z(26)*Z(34) + Z(28)*Z(32)
      VOP2X = U1 - L2*Z(38)*(U3-U4-U5-U6-U7)
      RX2 = -RY2*(K5*DP2X+K6*VOP2X)
      MANG = Q4
      MANGVEL = U4
      MTOR = MTPK*(3.141592653589793D0-MANG) - MTPB*MANGVEL
      Z(40) = Z(7)*Z(3) - Z(8)*Z(4)
      Z(41) = Z(7)*Z(4) + Z(8)*Z(3)
      Z(42) = -Z(7)*Z(4) - Z(8)*Z(3)
      Z(43) = Z(36)*Z(40) + Z(38)*Z(41)
      Z(44) = Z(37)*Z(40) + Z(39)*Z(41)
      Z(45) = Z(36)*Z(42) + Z(38)*Z(40)
      Z(46) = Z(37)*Z(42) + Z(39)*Z(40)
      Z(47) = Z(3)*Z(36) + Z(4)*Z(38)
      Z(48) = Z(3)*Z(37) + Z(4)*Z(39)
      Z(49) = Z(3)*Z(38) - Z(4)*Z(36)
      Z(50) = Z(3)*Z(39) - Z(4)*Z(37)
      Z(51) = Z(9)*Z(32) + Z(10)*Z(34)
      Z(52) = Z(9)*Z(33) + Z(10)*Z(35)
      Z(53) = Z(9)*Z(34) - Z(10)*Z(32)
      Z(54) = Z(9)*Z(35) - Z(10)*Z(33)
      Z(104) = Z(1)*Z(38) + Z(2)*Z(39)
      Z(105) = Z(1)*Z(37) - Z(2)*Z(36)
      Z(106) = Z(1)*Z(39) - Z(2)*Z(38)
      Z(109) = Z(1)*Z(49) + Z(2)*Z(50)
      Z(110) = Z(1)*Z(48) - Z(2)*Z(47)
      Z(111) = Z(1)*Z(50) - Z(2)*Z(49)
      Z(161) = L1*(U3-U4-U5-U6-U7)
      Z(162) = (U3-U4-U5-U6-U7)*Z(161)
      Z(163) = L2*(U3-U4-U5-U6-U7)
      Z(164) = (U3-U4-U5-U6-U7)*Z(163)
      Z(165) = L4*(U3-U5-U6-U7)
      Z(166) = L3*(U3-U5-U6-U7)
      Z(167) = (U3-U5-U6-U7)*Z(165)
      Z(168) = (U3-U5-U6-U7)*Z(166)
      Z(171) = L6*(U3-U5-U6-U7)
      Z(172) = (U3-U5-U6-U7)*Z(171)
      Z(173) = L7*(U3-U6-U7)
      Z(174) = (U3-U6-U7)*Z(173)
      Z(175) = L8*(U3-U6-U7)
      Z(176) = (U3-U6-U7)*Z(175)
      Z(177) = L9*(U3-U7)
      Z(178) = (U3-U7)*Z(177)
      Z(179) = L10*(U3-U7)
      Z(180) = (U3-U7)*Z(179)
      Z(228) = MTOR - ATOR
      Z(231) = Z(9)*Z(26) + Z(10)*Z(27)
      Z(232) = Z(9)*Z(27) - Z(10)*Z(26)
      Z(233) = Z(9)*Z(28) + Z(10)*Z(26)
      Z(234) = Z(9)*Z(26) - Z(10)*Z(28)
      Z(236) = Z(3)*Z(232) + Z(4)*Z(234)
      Z(237) = Z(3)*Z(233) - Z(4)*Z(231)
      Z(238) = Z(3)*Z(234) - Z(4)*Z(232)
      Z(511) = RX1 + RX2 + VRX1
      Z(513) = Z(512) + RY1 + RY2 + VRY1 + Z(227)
      Z(524) = MTOR + Z(514)*Z(39) + Z(516)*Z(39) + Z(517)*Z(39) + Z(518
     &)*Z(39) + Z(519)*Z(39) + Z(520)*Z(39) + Z(521)*Z(39) + Z(522)*Z(39
     &) + Z(523)*Z(39) + L2*Z(39)*Z(227) + L2*(RX2*Z(38)+RY2*Z(39)) + L2
     &*(VRX1*Z(38)+VRY1*Z(39))
      Z(525) = MTOR + Z(514)*Z(39) + L2*VRX1*Z(38) + L2*VRY1*Z(39) + L2*
     &(RX2*Z(38)+RY2*Z(39)) + Z(220)*(L2*Z(39)-L6*Z(50)) + Z(221)*(L2*Z(
     &39)-L6*Z(50)) + Z(222)*(L2*Z(39)-L6*Z(50)) + Z(223)*(L2*Z(39)-L6*Z
     &(50)) + Z(224)*(L2*Z(39)-L6*Z(50)) + Z(225)*(L2*Z(39)-L6*Z(50)) + 
     &Z(226)*(L2*Z(39)-L6*Z(50)) + Z(227)*(L2*Z(39)-L6*Z(50)) + 0.5D0*Z(
     &219)*(2*L2*Z(39)-L3*Z(46)-L4*Z(50)) - Z(228) - L6*VRX1*Z(49) - L6*
     &VRY1*Z(50)
      Z(526) = MTOR + Z(514)*Z(39) + L2*VRX1*Z(38) + L2*VRY1*Z(39) + L2*
     &(RX2*Z(38)+RY2*Z(39)) + Z(220)*(L2*Z(39)-L6*Z(50)-L7*Z(35)) + Z(22
     &1)*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + Z(222)*(L2*Z(39)-L6*Z(50)-L8*Z(3
     &5)) + Z(223)*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + Z(224)*(L2*Z(39)-L6*Z(
     &50)-L8*Z(35)) + Z(225)*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + Z(226)*(L2*Z
     &(39)-L6*Z(50)-L8*Z(35)) + Z(227)*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + 0.
     &5D0*Z(219)*(2*L2*Z(39)-L3*Z(46)-L4*Z(50)) - Z(228) - Z(229) - L6*V
     &RX1*Z(49) - L6*VRY1*Z(50) - L8*VRX1*Z(34) - L8*VRY1*Z(35)
      Z(527) = MTOR + Z(514)*Z(39) + L2*VRX1*Z(38) + L2*VRY1*Z(39) + L2*
     &(RX2*Z(38)+RY2*Z(39)) + Z(220)*(L2*Z(39)-L6*Z(50)-L7*Z(35)) + 0.5D
     &0*Z(219)*(2*L2*Z(39)-L3*Z(46)-L4*Z(50)) + Z(221)*(L2*Z(39)-L6*Z(50
     &)-L8*Z(35)-L9*Z(54)) + Z(222)*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35
     &)) + Z(223)*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + Z(224)*(L2*Z(
     &39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + Z(225)*(L2*Z(39)-L10*Z(54)-L6*Z
     &(50)-L8*Z(35)) + Z(226)*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + Z
     &(227)*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) - Z(228) - Z(229) - Z
     &(230) - L10*VRX1*Z(53) - L10*VRY1*Z(54) - L6*VRX1*Z(49) - L6*VRY1*
     &Z(50) - L8*VRX1*Z(34) - L8*VRY1*Z(35)
      Z(553) = Z(552)*Z(38)
      Z(554) = Z(462)*Z(38) + MC*(L2*Z(38)-L6*Z(49)) + MD*(L2*Z(38)-L6*Z
     &(49)) + ME*(L2*Z(38)-L6*Z(49)) + MF*(L2*Z(38)-L6*Z(49)) + MG*(L2*Z
     &(38)-L6*Z(49)) + MH*(L2*Z(38)-L6*Z(49)) + MI*(L2*Z(38)-L6*Z(49)) +
     & 0.5D0*MB*(2*L2*Z(38)-L3*Z(45)-L4*Z(49))
      Z(555) = Z(462)*Z(38) + MC*(L2*Z(38)-L6*Z(49)-L7*Z(34)) + MD*(L2*Z
     &(38)-L6*Z(49)-L8*Z(34)) + ME*(L2*Z(38)-L6*Z(49)-L8*Z(34)) + MF*(L2
     &*Z(38)-L6*Z(49)-L8*Z(34)) + MG*(L2*Z(38)-L6*Z(49)-L8*Z(34)) + MH*(
     &L2*Z(38)-L6*Z(49)-L8*Z(34)) + MI*(L2*Z(38)-L6*Z(49)-L8*Z(34)) + 0.
     &5D0*MB*(2*L2*Z(38)-L3*Z(45)-L4*Z(49))
      Z(556) = Z(462)*Z(38) + MC*(L2*Z(38)-L6*Z(49)-L7*Z(34)) + 0.5D0*MB
     &*(2*L2*Z(38)-L3*Z(45)-L4*Z(49)) + MD*(L2*Z(38)-L6*Z(49)-L8*Z(34)-L
     &9*Z(53)) + ME*(L2*Z(38)-L10*Z(53)-L6*Z(49)-L8*Z(34)) + MF*(L2*Z(38
     &)-L10*Z(53)-L6*Z(49)-L8*Z(34)) + MG*(L2*Z(38)-L10*Z(53)-L6*Z(49)-L
     &8*Z(34)) + MH*(L2*Z(38)-L10*Z(53)-L6*Z(49)-L8*Z(34)) + MI*(L2*Z(38
     &)-L10*Z(53)-L6*Z(49)-L8*Z(34))
      Z(559) = Z(552)*Z(39)
      Z(560) = Z(462)*Z(39) + MC*(L2*Z(39)-L6*Z(50)) + MD*(L2*Z(39)-L6*Z
     &(50)) + ME*(L2*Z(39)-L6*Z(50)) + MF*(L2*Z(39)-L6*Z(50)) + MG*(L2*Z
     &(39)-L6*Z(50)) + MH*(L2*Z(39)-L6*Z(50)) + MI*(L2*Z(39)-L6*Z(50)) +
     & 0.5D0*MB*(2*L2*Z(39)-L3*Z(46)-L4*Z(50))
      Z(561) = Z(462)*Z(39) + MC*(L2*Z(39)-L6*Z(50)-L7*Z(35)) + MD*(L2*Z
     &(39)-L6*Z(50)-L8*Z(35)) + ME*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + MF*(L2
     &*Z(39)-L6*Z(50)-L8*Z(35)) + MG*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + MH*(
     &L2*Z(39)-L6*Z(50)-L8*Z(35)) + MI*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + 0.
     &5D0*MB*(2*L2*Z(39)-L3*Z(46)-L4*Z(50))
      Z(562) = Z(462)*Z(39) + MC*(L2*Z(39)-L6*Z(50)-L7*Z(35)) + 0.5D0*MB
     &*(2*L2*Z(39)-L3*Z(46)-L4*Z(50)) + MD*(L2*Z(39)-L6*Z(50)-L8*Z(35)-L
     &9*Z(54)) + ME*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + MF*(L2*Z(39
     &)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + MG*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L
     &8*Z(35)) + MH*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + MI*(L2*Z(39
     &)-L10*Z(54)-L6*Z(50)-L8*Z(35))
      Z(625) = Z(624) + Z(466)*(L2-L6*Z(3)) + Z(469)*(L2-L6*Z(3)) + Z(47
     &3)*(L2-L6*Z(3)) + Z(479)*(L2-L6*Z(3)) + Z(486)*(L2-L6*Z(3)) + Z(49
     &2)*(L2-L6*Z(3)) + Z(502)*(L2-L6*Z(3)) + 0.5D0*Z(463)*(2*L2-L3*Z(40
     &)-L4*Z(3))
      Z(626) = Z(624) + Z(466)*(L2-L6*Z(3)-L7*Z(26)) + Z(469)*(L2-L6*Z(3
     &)-L8*Z(26)) + Z(473)*(L2-L6*Z(3)-L8*Z(26)) + Z(479)*(L2-L6*Z(3)-L8
     &*Z(26)) + Z(486)*(L2-L6*Z(3)-L8*Z(26)) + Z(492)*(L2-L6*Z(3)-L8*Z(2
     &6)) + Z(502)*(L2-L6*Z(3)-L8*Z(26)) + 0.5D0*Z(463)*(2*L2-L3*Z(40)-L
     &4*Z(3))
      Z(627) = Z(624) + Z(466)*(L2-L6*Z(3)-L7*Z(26)) + 0.5D0*Z(463)*(2*L
     &2-L3*Z(40)-L4*Z(3)) + Z(469)*(L2-L6*Z(3)-L8*Z(26)-L9*Z(234)) + Z(4
     &73)*(L2-L10*Z(234)-L6*Z(3)-L8*Z(26)) + Z(479)*(L2-L10*Z(234)-L6*Z(
     &3)-L8*Z(26)) + Z(486)*(L2-L10*Z(234)-L6*Z(3)-L8*Z(26)) + Z(492)*(L
     &2-L10*Z(234)-L6*Z(3)-L8*Z(26)) + Z(502)*(L2-L10*Z(234)-L6*Z(3)-L8*
     &Z(26))
      Z(631) = Z(629) + MC*(Z(630)-2*Z(568)*Z(3)) + MD*(Z(630)-2*Z(568)*
     &Z(3)) + ME*(Z(630)-2*Z(568)*Z(3)) + MF*(Z(630)-2*Z(568)*Z(3)) + MG
     &*(Z(630)-2*Z(568)*Z(3)) + MH*(Z(630)-2*Z(568)*Z(3)) + MI*(Z(630)-2
     &*Z(568)*Z(3)) + 0.25D0*MB*(Z(565)-4*Z(566)*Z(40)-4*Z(567)*Z(3))
      Z(632) = Z(629) + 0.25D0*MB*(Z(565)-4*Z(566)*Z(40)-4*Z(567)*Z(3)) 
     &- MC*(Z(569)*Z(26)+2*Z(568)*Z(3)-Z(570)-Z(571)-Z(573)*Z(5)) - MD*(
     &Z(574)*Z(26)+2*Z(568)*Z(3)-Z(570)-Z(571)-Z(578)*Z(5)) - ME*(Z(574)
     &*Z(26)+2*Z(568)*Z(3)-Z(570)-Z(571)-Z(578)*Z(5)) - MF*(Z(574)*Z(26)
     &+2*Z(568)*Z(3)-Z(570)-Z(571)-Z(578)*Z(5)) - MG*(Z(574)*Z(26)+2*Z(5
     &68)*Z(3)-Z(570)-Z(571)-Z(578)*Z(5)) - MH*(Z(574)*Z(26)+2*Z(568)*Z(
     &3)-Z(570)-Z(571)-Z(578)*Z(5)) - MI*(Z(574)*Z(26)+2*Z(568)*Z(3)-Z(5
     &70)-Z(571)-Z(578)*Z(5))
      Z(633) = Z(629) + 0.25D0*MB*(Z(565)-4*Z(566)*Z(40)-4*Z(567)*Z(3)) 
     &- MC*(Z(569)*Z(26)+2*Z(568)*Z(3)-Z(570)-Z(571)-Z(573)*Z(5)) - MD*(
     &Z(574)*Z(26)+Z(575)*Z(234)+2*Z(568)*Z(3)-Z(570)-Z(571)-Z(578)*Z(5)
     &-Z(579)*Z(238)) - ME*(Z(574)*Z(26)+Z(581)*Z(234)+2*Z(568)*Z(3)-Z(5
     &70)-Z(571)-Z(578)*Z(5)-Z(585)*Z(238)) - MF*(Z(574)*Z(26)+Z(581)*Z(
     &234)+2*Z(568)*Z(3)-Z(570)-Z(571)-Z(578)*Z(5)-Z(585)*Z(238)) - MG*(
     &Z(574)*Z(26)+Z(581)*Z(234)+2*Z(568)*Z(3)-Z(570)-Z(571)-Z(578)*Z(5)
     &-Z(585)*Z(238)) - MH*(Z(574)*Z(26)+Z(581)*Z(234)+2*Z(568)*Z(3)-Z(5
     &70)-Z(571)-Z(578)*Z(5)-Z(585)*Z(238)) - MI*(Z(574)*Z(26)+Z(581)*Z(
     &234)+2*Z(568)*Z(3)-Z(570)-Z(571)-Z(578)*Z(5)-Z(585)*Z(238))
      Z(636) = Z(635) + 0.25D0*MB*(Z(565)-4*Z(566)*Z(40)-4*Z(567)*Z(3)) 
     &- MC*(2*Z(568)*Z(3)+2*Z(569)*Z(26)-Z(570)-Z(571)-Z(572)-2*Z(573)*Z
     &(5)) - MD*(2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z(570)-Z(571)-Z(576)-2*Z(5
     &78)*Z(5)) - ME*(2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z(570)-Z(571)-Z(576)-
     &2*Z(578)*Z(5)) - MF*(2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z(570)-Z(571)-Z(
     &576)-2*Z(578)*Z(5)) - MG*(2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z(570)-Z(57
     &1)-Z(576)-2*Z(578)*Z(5)) - MH*(2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z(570)
     &-Z(571)-Z(576)-2*Z(578)*Z(5)) - MI*(2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z
     &(570)-Z(571)-Z(576)-2*Z(578)*Z(5))
      Z(637) = Z(635) + 0.25D0*MB*(Z(565)-4*Z(566)*Z(40)-4*Z(567)*Z(3)) 
     &- MC*(2*Z(568)*Z(3)+2*Z(569)*Z(26)-Z(570)-Z(571)-Z(572)-2*Z(573)*Z
     &(5)) - MD*(Z(575)*Z(234)+2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z(570)-Z(571
     &)-Z(576)-2*Z(578)*Z(5)-Z(579)*Z(238)-Z(580)*Z(9)) - ME*(Z(581)*Z(2
     &34)+2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z(570)-Z(571)-Z(576)-2*Z(578)*Z(5
     &)-Z(585)*Z(238)-Z(586)*Z(9)) - MF*(Z(581)*Z(234)+2*Z(568)*Z(3)+2*Z
     &(574)*Z(26)-Z(570)-Z(571)-Z(576)-2*Z(578)*Z(5)-Z(585)*Z(238)-Z(586
     &)*Z(9)) - MG*(Z(581)*Z(234)+2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z(570)-Z(
     &571)-Z(576)-2*Z(578)*Z(5)-Z(585)*Z(238)-Z(586)*Z(9)) - MH*(Z(581)*
     &Z(234)+2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z(570)-Z(571)-Z(576)-2*Z(578)*
     &Z(5)-Z(585)*Z(238)-Z(586)*Z(9)) - MI*(Z(581)*Z(234)+2*Z(568)*Z(3)+
     &2*Z(574)*Z(26)-Z(570)-Z(571)-Z(576)-2*Z(578)*Z(5)-Z(585)*Z(238)-Z(
     &586)*Z(9))
      Z(640) = Z(639) + 0.25D0*MB*(Z(565)-4*Z(566)*Z(40)-4*Z(567)*Z(3)) 
     &- MC*(2*Z(568)*Z(3)+2*Z(569)*Z(26)-Z(570)-Z(571)-Z(572)-2*Z(573)*Z
     &(5)) - MD*(2*Z(568)*Z(3)+2*Z(574)*Z(26)+2*Z(575)*Z(234)-Z(570)-Z(5
     &71)-Z(576)-Z(577)-2*Z(578)*Z(5)-2*Z(579)*Z(238)-2*Z(580)*Z(9)) - M
     &E*(2*Z(568)*Z(3)+2*Z(574)*Z(26)+2*Z(581)*Z(234)-Z(570)-Z(571)-Z(57
     &6)-Z(583)-2*Z(578)*Z(5)-2*Z(585)*Z(238)-2*Z(586)*Z(9)) - MF*(2*Z(5
     &68)*Z(3)+2*Z(574)*Z(26)+2*Z(581)*Z(234)-Z(570)-Z(571)-Z(576)-Z(583
     &)-2*Z(578)*Z(5)-2*Z(585)*Z(238)-2*Z(586)*Z(9)) - MG*(2*Z(568)*Z(3)
     &+2*Z(574)*Z(26)+2*Z(581)*Z(234)-Z(570)-Z(571)-Z(576)-Z(583)-2*Z(57
     &8)*Z(5)-2*Z(585)*Z(238)-2*Z(586)*Z(9)) - MH*(2*Z(568)*Z(3)+2*Z(574
     &)*Z(26)+2*Z(581)*Z(234)-Z(570)-Z(571)-Z(576)-Z(583)-2*Z(578)*Z(5)-
     &2*Z(585)*Z(238)-2*Z(586)*Z(9)) - MI*(2*Z(568)*Z(3)+2*Z(574)*Z(26)+
     &2*Z(581)*Z(234)-Z(570)-Z(571)-Z(576)-Z(583)-2*Z(578)*Z(5)-2*Z(585)
     &*Z(238)-2*Z(586)*Z(9))

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
      Z(55) = Z(13)*Z(1) + Z(14)*Z(2)
      Z(56) = Z(13)*Z(2) - Z(14)*Z(1)
      Z(57) = Z(14)*Z(1) - Z(13)*Z(2)
      Z(58) = -Z(15)*Z(55) - Z(16)*Z(57)
      Z(59) = -Z(15)*Z(56) - Z(16)*Z(55)
      Z(60) = Z(16)*Z(55) - Z(15)*Z(57)
      Z(61) = Z(16)*Z(56) - Z(15)*Z(55)
      Z(62) = Z(18)*Z(60) - Z(17)*Z(58)
      Z(63) = Z(18)*Z(61) - Z(17)*Z(59)
      Z(64) = -Z(17)*Z(60) - Z(18)*Z(58)
      Z(65) = -Z(17)*Z(61) - Z(18)*Z(59)
      Z(66) = Z(7)*Z(62) - Z(8)*Z(64)
      Z(67) = Z(7)*Z(63) - Z(8)*Z(65)
      Z(68) = Z(7)*Z(64) + Z(8)*Z(62)
      Z(69) = Z(7)*Z(65) + Z(8)*Z(63)
      Z(70) = Z(20)*Z(64) - Z(19)*Z(62)
      Z(71) = Z(20)*Z(65) - Z(19)*Z(63)
      Z(72) = -Z(19)*Z(64) - Z(20)*Z(62)
      Z(73) = -Z(19)*Z(65) - Z(20)*Z(63)
      Z(113) = U8 - EAp
      Z(115) = FApp - EApp
      Z(121) = FApp - EApp - HApp
      Z(122) = Z(1)*Z(62) + Z(2)*Z(63)
      Z(123) = Z(1)*Z(64) + Z(2)*Z(65)
      Z(124) = Z(1)*Z(63) - Z(2)*Z(62)
      Z(125) = Z(1)*Z(65) - Z(2)*Z(64)
      Z(127) = FApp - EApp - HApp - IApp
      Z(128) = Z(1)*Z(70) + Z(2)*Z(71)
      Z(129) = Z(1)*Z(72) + Z(2)*Z(73)
      Z(130) = Z(1)*Z(71) - Z(2)*Z(70)
      Z(131) = Z(1)*Z(73) - Z(2)*Z(72)
      Z(136) = Z(21)*EAp
      Z(137) = L10*EAp
      Z(138) = Z(22)*(EAp-FAp)
      Z(139) = L8*(EAp-FAp)
      Z(140) = L6*(FAp-EAp-HAp)
      Z(141) = Z(1)*Z(66) + Z(2)*Z(67)
      Z(142) = Z(1)*Z(68) + Z(2)*Z(69)
      Z(143) = Z(1)*Z(67) - Z(2)*Z(66)
      Z(144) = Z(1)*Z(69) - Z(2)*Z(68)
      Z(145) = Z(24)*(FAp-EAp-HAp)
      Z(146) = L3*(FAp-EAp-HAp)
      Z(148) = Z(25)*(FAp-EAp-HAp-IAp)
      Z(181) = Z(21)*U3 + Z(21)*U8 - Z(136)
      Z(182) = Z(21)*EApp
      Z(183) = Z(181)*(U3+Z(113))
      Z(184) = L10*U3 + L10*U8 - Z(137)
      Z(185) = L10*EApp
      Z(186) = Z(184)*(U3+Z(113))
      Z(187) = Z(22)*U3 + Z(22)*U8 + Z(22)*U9 - Z(138)
      Z(188) = Z(22)*(EApp-FApp)
      Z(189) = FAp + U9
      Z(190) = Z(187)*(U3+Z(113)+Z(189))
      Z(191) = L8*U3 + L8*U8 + L8*U9 - Z(139)
      Z(192) = L8*(EApp-FApp)
      Z(193) = Z(191)*(U3+Z(113)+Z(189))
      Z(194) = GS*U3
      Z(195) = GSp*U3
      Z(196) = GSpp - U3*Z(194)
      Z(197) = GSp*U3 + Z(195)
      Z(198) = Z(140) + L6*U10 + L6*U3 + L6*U8 + L6*U9
      Z(199) = L6*(FApp-EApp-HApp)
      Z(200) = U10 - HAp
      Z(201) = Z(198)*(U3+Z(113)+Z(189)+Z(200))
      Z(202) = Z(145) + Z(24)*U10 + Z(24)*U3 + Z(24)*U8 + Z(24)*U9
      Z(203) = -0.5D0*Z(146) - 0.5D0*L3*U10 - 0.5D0*L3*U3 - 0.5D0*L3*U8 
     &- 0.5D0*L3*U9
      Z(204) = Z(24)*(FApp-EApp-HApp)
      Z(205) = L3*(FApp-EApp-HApp)
      Z(206) = Z(202)*(U3+Z(113)+Z(189)+Z(200))
      Z(207) = Z(203)*(U3+Z(113)+Z(189)+Z(200))
      Z(211) = Z(148) + Z(25)*U10 + Z(25)*U11 + Z(25)*U3 + Z(25)*U8 + Z(
     &25)*U9
      Z(212) = Z(25)*(FApp-EApp-HApp-IApp)
      Z(213) = U11 - IAp
      Z(214) = Z(211)*(U3+Z(113)+Z(189)+Z(200)+Z(213))
      Z(239) = Z(36)*Z(55) + Z(37)*Z(56)
      Z(240) = Z(36)*Z(57) + Z(37)*Z(55)
      Z(241) = Z(38)*Z(55) + Z(39)*Z(56)
      Z(242) = Z(38)*Z(57) + Z(39)*Z(55)
      Z(243) = Z(3)*Z(239) + Z(4)*Z(241)
      Z(244) = Z(3)*Z(240) + Z(4)*Z(242)
      Z(245) = Z(3)*Z(241) - Z(4)*Z(239)
      Z(246) = Z(3)*Z(242) - Z(4)*Z(240)
      Z(247) = Z(5)*Z(243) + Z(6)*Z(245)
      Z(248) = Z(5)*Z(244) + Z(6)*Z(246)
      Z(249) = Z(5)*Z(245) - Z(6)*Z(243)
      Z(250) = Z(5)*Z(246) - Z(6)*Z(244)
      Z(252) = Z(9)*Z(248) + Z(10)*Z(250)
      Z(253) = Z(9)*Z(249) - Z(10)*Z(247)
      Z(254) = Z(9)*Z(250) - Z(10)*Z(248)
      Z(255) = Z(36)*Z(58) + Z(37)*Z(59)
      Z(256) = Z(36)*Z(60) + Z(37)*Z(61)
      Z(257) = Z(38)*Z(58) + Z(39)*Z(59)
      Z(258) = Z(38)*Z(60) + Z(39)*Z(61)
      Z(259) = Z(3)*Z(255) + Z(4)*Z(257)
      Z(260) = Z(3)*Z(256) + Z(4)*Z(258)
      Z(261) = Z(3)*Z(257) - Z(4)*Z(255)
      Z(262) = Z(3)*Z(258) - Z(4)*Z(256)
      Z(263) = Z(5)*Z(259) + Z(6)*Z(261)
      Z(264) = Z(5)*Z(260) + Z(6)*Z(262)
      Z(265) = Z(5)*Z(261) - Z(6)*Z(259)
      Z(266) = Z(5)*Z(262) - Z(6)*Z(260)
      Z(268) = Z(9)*Z(264) + Z(10)*Z(266)
      Z(269) = Z(9)*Z(265) - Z(10)*Z(263)
      Z(270) = Z(9)*Z(266) - Z(10)*Z(264)
      Z(271) = Z(36)*Z(62) + Z(37)*Z(63)
      Z(272) = Z(36)*Z(64) + Z(37)*Z(65)
      Z(273) = Z(38)*Z(62) + Z(39)*Z(63)
      Z(274) = Z(38)*Z(64) + Z(39)*Z(65)
      Z(275) = Z(36)*Z(66) + Z(37)*Z(67)
      Z(276) = Z(36)*Z(68) + Z(37)*Z(69)
      Z(277) = Z(38)*Z(66) + Z(39)*Z(67)
      Z(278) = Z(38)*Z(68) + Z(39)*Z(69)
      Z(279) = Z(3)*Z(271) + Z(4)*Z(273)
      Z(280) = Z(3)*Z(272) + Z(4)*Z(274)
      Z(281) = Z(3)*Z(273) - Z(4)*Z(271)
      Z(282) = Z(3)*Z(274) - Z(4)*Z(272)
      Z(283) = Z(3)*Z(275) + Z(4)*Z(277)
      Z(284) = Z(3)*Z(276) + Z(4)*Z(278)
      Z(285) = Z(3)*Z(277) - Z(4)*Z(275)
      Z(286) = Z(3)*Z(278) - Z(4)*Z(276)
      Z(287) = Z(5)*Z(279) + Z(6)*Z(281)
      Z(288) = Z(5)*Z(280) + Z(6)*Z(282)
      Z(289) = Z(5)*Z(281) - Z(6)*Z(279)
      Z(290) = Z(5)*Z(282) - Z(6)*Z(280)
      Z(291) = Z(5)*Z(283) + Z(6)*Z(285)
      Z(292) = Z(5)*Z(284) + Z(6)*Z(286)
      Z(293) = Z(5)*Z(285) - Z(6)*Z(283)
      Z(294) = Z(5)*Z(286) - Z(6)*Z(284)
      Z(296) = Z(9)*Z(288) + Z(10)*Z(290)
      Z(297) = Z(9)*Z(289) - Z(10)*Z(287)
      Z(298) = Z(9)*Z(290) - Z(10)*Z(288)
      Z(300) = Z(9)*Z(292) + Z(10)*Z(294)
      Z(301) = Z(9)*Z(293) - Z(10)*Z(291)
      Z(302) = Z(9)*Z(294) - Z(10)*Z(292)
      Z(304) = Z(13)*Z(123) - Z(14)*Z(125)
      Z(305) = Z(13)*Z(124) + Z(14)*Z(122)
      Z(306) = Z(13)*Z(125) + Z(14)*Z(123)
      Z(307) = Z(13)*Z(141) - Z(14)*Z(143)
      Z(308) = Z(13)*Z(142) - Z(14)*Z(144)
      Z(309) = Z(13)*Z(143) + Z(14)*Z(141)
      Z(310) = Z(13)*Z(144) + Z(14)*Z(142)
      Z(312) = -Z(15)*Z(308) - Z(16)*Z(310)
      Z(313) = Z(16)*Z(307) - Z(15)*Z(309)
      Z(314) = Z(16)*Z(308) - Z(15)*Z(310)
      Z(315) = Z(36)*Z(70) + Z(37)*Z(71)
      Z(316) = Z(36)*Z(72) + Z(37)*Z(73)
      Z(317) = Z(38)*Z(70) + Z(39)*Z(71)
      Z(318) = Z(38)*Z(72) + Z(39)*Z(73)
      Z(319) = Z(3)*Z(315) + Z(4)*Z(317)
      Z(320) = Z(3)*Z(316) + Z(4)*Z(318)
      Z(321) = Z(3)*Z(317) - Z(4)*Z(315)
      Z(322) = Z(3)*Z(318) - Z(4)*Z(316)
      Z(323) = Z(5)*Z(319) + Z(6)*Z(321)
      Z(324) = Z(5)*Z(320) + Z(6)*Z(322)
      Z(325) = Z(5)*Z(321) - Z(6)*Z(319)
      Z(326) = Z(5)*Z(322) - Z(6)*Z(320)
      Z(328) = Z(9)*Z(324) + Z(10)*Z(326)
      Z(329) = Z(9)*Z(325) - Z(10)*Z(323)
      Z(330) = Z(9)*Z(326) - Z(10)*Z(324)
      Z(331) = Z(13)*Z(128) - Z(14)*Z(130)
      Z(332) = Z(13)*Z(129) - Z(14)*Z(131)
      Z(333) = Z(13)*Z(130) + Z(14)*Z(128)
      Z(334) = Z(13)*Z(131) + Z(14)*Z(129)
      Z(336) = -Z(15)*Z(332) - Z(16)*Z(334)
      Z(337) = Z(16)*Z(331) - Z(15)*Z(333)
      Z(338) = Z(16)*Z(332) - Z(15)*Z(334)
      Z(515) = HTOR + Z(228) + Z(229) + Z(230) + L10*VRX1*Z(53) + L10*VR
     &X1*Z(57) + L10*VRY1*Z(54) + L10*VRY1*Z(55) + L6*VRX1*Z(49) + L6*VR
     &X1*Z(64) + L6*VRY1*Z(50) + L6*VRY1*Z(65) + L8*VRX1*Z(34) + L8*VRX1
     &*Z(60) + L8*VRY1*Z(35) + L8*VRY1*Z(61) - MTOR - Z(514)*Z(39) - L2*
     &VRX1*Z(38) - L2*VRY1*Z(39) - L2*(RX2*Z(38)+RY2*Z(39)) - Z(220)*(L2
     &*Z(39)-L6*Z(50)-L7*Z(35)) - 0.5D0*Z(219)*(2*L2*Z(39)-L3*Z(46)-L4*Z
     &(50)) - Z(221)*(L2*Z(39)-L6*Z(50)-L8*Z(35)-L9*Z(54)) - Z(222)*(L2*
     &Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)-Z(21)*Z(55)) - Z(224)*(L2*Z(39)-
     &L10*Z(54)-L6*Z(50)-L8*Z(35)-GS*Z(1)) - Z(223)*(L2*Z(39)-L10*Z(54)-
     &L10*Z(55)-L6*Z(50)-L8*Z(35)-Z(22)*Z(61)) - Z(226)*(L2*Z(39)-L10*Z(
     &54)-L10*Z(55)-L6*Z(50)-L6*Z(65)-L8*Z(35)-L8*Z(61)-Z(25)*Z(73)) - Z
     &(227)*(L2*Z(39)-L10*Z(54)-L10*Z(55)-L2*Z(73)-L6*Z(50)-L6*Z(65)-L8*
     &Z(35)-L8*Z(61)) - 0.5D0*Z(225)*(L3*Z(69)+2*L2*Z(39)-2*L10*Z(54)-2*
     &L10*Z(55)-2*L6*Z(50)-2*L8*Z(35)-2*L8*Z(61)-2*Z(24)*Z(65))
      Z(544) = INE*EApp
      Z(546) = INF*Z(115)
      Z(548) = INH*Z(121)
      Z(550) = INI*Z(127)
      Z(551) = MG*(L10*Z(53)+L6*Z(49)+L8*Z(34)-L2*Z(38)-GS*Z(2)) - Z(462
     &)*Z(38) - MC*(L2*Z(38)-L6*Z(49)-L7*Z(34)) - 0.5D0*MB*(2*L2*Z(38)-L
     &3*Z(45)-L4*Z(49)) - MD*(L2*Z(38)-L6*Z(49)-L8*Z(34)-L9*Z(53)) - ME*
     &(L2*Z(38)-L10*Z(53)-L6*Z(49)-L8*Z(34)-Z(21)*Z(57)) - MF*(L2*Z(38)-
     &L10*Z(53)-L10*Z(57)-L6*Z(49)-L8*Z(34)-Z(22)*Z(60)) - MI*(L2*Z(38)-
     &L10*Z(53)-L10*Z(57)-L6*Z(49)-L6*Z(64)-L8*Z(34)-L8*Z(60)-Z(25)*Z(72
     &)) - 0.5D0*MH*(L3*Z(68)+2*L2*Z(38)-2*L10*Z(53)-2*L10*Z(57)-2*L6*Z(
     &49)-2*L8*Z(34)-2*L8*Z(60)-2*Z(24)*Z(64))
      Z(557) = MA*Z(36)*Z(162) + MC*(Z(36)*Z(164)-Z(32)*Z(174)-Z(47)*Z(1
     &72)) + 0.5D0*MB*(2*Z(36)*Z(164)-Z(43)*Z(168)-Z(47)*Z(167)) + MD*(Z
     &(36)*Z(164)-Z(32)*Z(176)-Z(47)*Z(172)-Z(51)*Z(178)) + MG*(Z(1)*Z(1
     &96)+Z(36)*Z(164)-Z(2)*Z(197)-Z(32)*Z(176)-Z(47)*Z(172)-Z(51)*Z(180
     &)) + ME*(Z(36)*Z(164)-Z(182)*Z(57)-Z(32)*Z(176)-Z(47)*Z(172)-Z(51)
     &*Z(180)-Z(55)*Z(183)) + MF*(Z(36)*Z(164)-Z(185)*Z(57)-Z(188)*Z(60)
     &-Z(32)*Z(176)-Z(47)*Z(172)-Z(51)*Z(180)-Z(55)*Z(186)-Z(58)*Z(190))
     & + MI*(Z(199)*Z(64)+Z(212)*Z(72)+Z(36)*Z(164)-Z(185)*Z(57)-Z(192)*
     &Z(60)-Z(32)*Z(176)-Z(47)*Z(172)-Z(51)*Z(180)-Z(55)*Z(186)-Z(58)*Z(
     &193)-Z(62)*Z(201)-Z(70)*Z(214)) + 0.5D0*MH*(2*Z(204)*Z(64)+2*Z(36)
     &*Z(164)-2*Z(185)*Z(57)-2*Z(192)*Z(60)-Z(205)*Z(68)-2*Z(32)*Z(176)-
     &2*Z(47)*Z(172)-2*Z(51)*Z(180)-2*Z(55)*Z(186)-2*Z(58)*Z(193)-2*Z(62
     &)*Z(206)-2*Z(66)*Z(207))
      Z(558) = -Z(462)*Z(39) - MC*(L2*Z(39)-L6*Z(50)-L7*Z(35)) - 0.5D0*M
     &B*(2*L2*Z(39)-L3*Z(46)-L4*Z(50)) - MD*(L2*Z(39)-L6*Z(50)-L8*Z(35)-
     &L9*Z(54)) - ME*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)-Z(21)*Z(55)) 
     &- MG*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)-GS*Z(1)) - MF*(L2*Z(39)
     &-L10*Z(54)-L10*Z(55)-L6*Z(50)-L8*Z(35)-Z(22)*Z(61)) - MI*(L2*Z(39)
     &-L10*Z(54)-L10*Z(55)-L6*Z(50)-L6*Z(65)-L8*Z(35)-L8*Z(61)-Z(25)*Z(7
     &3)) - 0.5D0*MH*(L3*Z(69)+2*L2*Z(39)-2*L10*Z(54)-2*L10*Z(55)-2*L6*Z
     &(50)-2*L8*Z(35)-2*L8*Z(61)-2*Z(24)*Z(65))
      Z(563) = MA*Z(37)*Z(162) + MC*(Z(37)*Z(164)-Z(33)*Z(174)-Z(48)*Z(1
     &72)) + 0.5D0*MB*(2*Z(37)*Z(164)-Z(44)*Z(168)-Z(48)*Z(167)) + MD*(Z
     &(37)*Z(164)-Z(33)*Z(176)-Z(48)*Z(172)-Z(52)*Z(178)) + MG*(Z(1)*Z(1
     &97)+Z(2)*Z(196)+Z(37)*Z(164)-Z(33)*Z(176)-Z(48)*Z(172)-Z(52)*Z(180
     &)) + ME*(Z(37)*Z(164)-Z(182)*Z(55)-Z(33)*Z(176)-Z(48)*Z(172)-Z(52)
     &*Z(180)-Z(56)*Z(183)) + MF*(Z(37)*Z(164)-Z(185)*Z(55)-Z(188)*Z(61)
     &-Z(33)*Z(176)-Z(48)*Z(172)-Z(52)*Z(180)-Z(56)*Z(186)-Z(59)*Z(190))
     & + MI*(Z(199)*Z(65)+Z(212)*Z(73)+Z(37)*Z(164)-Z(185)*Z(55)-Z(192)*
     &Z(61)-Z(33)*Z(176)-Z(48)*Z(172)-Z(52)*Z(180)-Z(56)*Z(186)-Z(59)*Z(
     &193)-Z(63)*Z(201)-Z(71)*Z(214)) + 0.5D0*MH*(2*Z(204)*Z(65)+2*Z(37)
     &*Z(164)-2*Z(185)*Z(55)-2*Z(192)*Z(61)-Z(205)*Z(69)-2*Z(33)*Z(176)-
     &2*Z(48)*Z(172)-2*Z(52)*Z(180)-2*Z(56)*Z(186)-2*Z(59)*Z(193)-2*Z(63
     &)*Z(206)-2*Z(67)*Z(207))
      Z(610) = Z(564) + 0.25D0*MB*(Z(565)-4*Z(566)*Z(40)-4*Z(567)*Z(3)) 
     &- MC*(2*Z(568)*Z(3)+2*Z(569)*Z(26)-Z(570)-Z(571)-Z(572)-2*Z(573)*Z
     &(5)) - MD*(2*Z(568)*Z(3)+2*Z(574)*Z(26)+2*Z(575)*Z(234)-Z(570)-Z(5
     &71)-Z(576)-Z(577)-2*Z(578)*Z(5)-2*Z(579)*Z(238)-2*Z(580)*Z(9)) - M
     &E*(2*Z(568)*Z(3)+2*Z(574)*Z(26)+2*Z(581)*Z(234)+2*Z(582)*Z(242)-Z(
     &570)-Z(571)-Z(576)-Z(583)-Z(584)-2*Z(578)*Z(5)-2*Z(585)*Z(238)-2*Z
     &(586)*Z(9)-2*Z(587)*Z(254)-2*Z(588)*Z(246)-2*Z(589)*Z(250)) - MG*(
     &2*Z(568)*Z(3)+2*Z(574)*Z(26)+2*Z(581)*Z(234)+2*L2*GS*Z(106)-Z(570)
     &-Z(571)-Z(576)-Z(583)-GS**2-2*Z(578)*Z(5)-2*Z(585)*Z(238)-2*Z(586)
     &*Z(9)-2*L10*GS*Z(11)-2*L6*GS*Z(111)-2*L8*GS*Z(29)) - MF*(2*Z(590)*
     &Z(15)+2*Z(568)*Z(3)+2*Z(574)*Z(26)+2*Z(581)*Z(234)+2*Z(581)*Z(242)
     &+2*Z(591)*Z(258)-2*Z(583)-Z(570)-Z(571)-Z(576)-Z(592)-2*Z(578)*Z(5
     &)-2*Z(583)*Z(254)-2*Z(585)*Z(238)-2*Z(585)*Z(246)-2*Z(586)*Z(9)-2*
     &Z(586)*Z(250)-2*Z(590)*Z(270)-2*Z(593)*Z(262)-2*Z(594)*Z(266)) - M
     &I*(2*Z(578)*Z(17)+2*Z(586)*Z(15)+2*Z(595)*Z(19)+2*Z(568)*Z(3)+2*Z(
     &568)*Z(274)+2*Z(574)*Z(26)+2*Z(574)*Z(258)+2*Z(581)*Z(234)+2*Z(581
     &)*Z(242)+2*Z(596)*Z(318)-2*Z(571)-2*Z(576)-2*Z(583)-Z(570)-Z(597)-
     &2*Z(571)*Z(282)-2*Z(576)*Z(266)-2*Z(578)*Z(5)-2*Z(578)*Z(262)-2*Z(
     &578)*Z(290)-2*Z(583)*Z(254)-2*Z(585)*Z(238)-2*Z(585)*Z(246)-2*Z(58
     &5)*Z(298)-2*Z(585)*Z(306)-2*Z(586)*Z(9)-2*Z(586)*Z(250)-2*Z(586)*Z
     &(270)-2*Z(595)*Z(322)-2*Z(598)*Z(330)-2*Z(598)*Z(334)-2*Z(599)*Z(3
     &26)-2*Z(599)*Z(338)) - 0.25D0*MH*(4*Z(600)+8*Z(586)*Z(15)+8*Z(601)
     &*Z(17)+4*Z(602)*Z(302)+4*Z(602)*Z(310)+4*Z(603)*Z(286)+4*Z(604)*Z(
     &294)+4*Z(604)*Z(314)+8*Z(568)*Z(3)+8*Z(574)*Z(26)+8*Z(574)*Z(258)+
     &8*Z(581)*Z(234)+8*Z(581)*Z(242)+8*Z(605)*Z(274)-8*Z(576)-8*Z(583)-
     &4*Z(570)-4*Z(571)-4*Z(607)-Z(606)-8*Z(576)*Z(266)-8*Z(578)*Z(5)-8*
     &Z(578)*Z(262)-8*Z(583)*Z(254)-8*Z(585)*Z(238)-8*Z(585)*Z(246)-8*Z(
     &586)*Z(9)-8*Z(586)*Z(250)-8*Z(586)*Z(270)-8*Z(601)*Z(290)-8*Z(608)
     &*Z(298)-8*Z(608)*Z(306)-8*Z(609)*Z(282)-4*Z(566)*Z(278))
      Z(612) = Z(611) - Z(466)*(L2-L6*Z(3)-L7*Z(26)) - 0.5D0*Z(463)*(2*L
     &2-L3*Z(40)-L4*Z(3)) - Z(469)*(L2-L6*Z(3)-L8*Z(26)-L9*Z(234)) - Z(4
     &73)*(L2-L10*Z(234)-L6*Z(3)-L8*Z(26)-Z(21)*Z(242)) - Z(486)*(L2-L10
     &*Z(234)-L6*Z(3)-L8*Z(26)-GS*Z(106)) - Z(479)*(L2-L10*Z(234)-L10*Z(
     &242)-L6*Z(3)-L8*Z(26)-Z(22)*Z(258)) - Z(502)*(L2-L10*Z(234)-L10*Z(
     &242)-L6*Z(3)-L6*Z(274)-L8*Z(26)-L8*Z(258)-Z(25)*Z(318)) - 0.5D0*Z(
     &492)*(2*L2+L3*Z(278)-2*L10*Z(234)-2*L10*Z(242)-2*L6*Z(3)-2*L8*Z(26
     &)-2*L8*Z(258)-2*Z(24)*Z(274))
      Z(614) = MC*(Z(569)*Z(26)+2*Z(568)*Z(3)-Z(570)-Z(571)-Z(573)*Z(5))
     & + MD*(Z(574)*Z(26)+Z(575)*Z(234)+2*Z(568)*Z(3)-Z(570)-Z(571)-Z(57
     &8)*Z(5)-Z(579)*Z(238)) + ME*(Z(574)*Z(26)+Z(581)*Z(234)+Z(582)*Z(2
     &42)+2*Z(568)*Z(3)-Z(570)-Z(571)-Z(578)*Z(5)-Z(585)*Z(238)-Z(588)*Z
     &(246)) + MG*(Z(574)*Z(26)+Z(581)*Z(234)+2*Z(568)*Z(3)+L2*GS*Z(106)
     &-Z(570)-Z(571)-Z(578)*Z(5)-Z(585)*Z(238)-L6*GS*Z(111)) + MF*(Z(574
     &)*Z(26)+Z(581)*Z(234)+Z(581)*Z(242)+Z(591)*Z(258)+2*Z(568)*Z(3)-Z(
     &570)-Z(571)-Z(578)*Z(5)-Z(585)*Z(238)-Z(585)*Z(246)-Z(593)*Z(262))
     & + 0.5D0*MH*(Z(603)*Z(286)+2*Z(574)*Z(26)+2*Z(574)*Z(258)+2*Z(581)
     &*Z(234)+2*Z(581)*Z(242)+2*Z(605)*Z(274)+4*Z(568)*Z(3)-2*Z(570)-2*Z
     &(571)-2*Z(578)*Z(5)-2*Z(578)*Z(262)-2*Z(585)*Z(238)-2*Z(585)*Z(246
     &)-2*Z(609)*Z(282)-Z(566)*Z(278)) - INA - INB - Z(613) - 0.25D0*MB*
     &(Z(565)-4*Z(566)*Z(40)-4*Z(567)*Z(3)) - MI*(Z(570)+Z(571)+Z(571)*Z
     &(282)+Z(578)*Z(5)+Z(578)*Z(262)+Z(585)*Z(238)+Z(585)*Z(246)+Z(595)
     &*Z(322)-2*Z(568)*Z(3)-Z(568)*Z(274)-Z(574)*Z(26)-Z(574)*Z(258)-Z(5
     &81)*Z(234)-Z(581)*Z(242)-Z(596)*Z(318))
      Z(615) = MC*(2*Z(568)*Z(3)+2*Z(569)*Z(26)-Z(570)-Z(571)-Z(572)-2*Z
     &(573)*Z(5)) + MD*(Z(575)*Z(234)+2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z(570
     &)-Z(571)-Z(576)-2*Z(578)*Z(5)-Z(579)*Z(238)-Z(580)*Z(9)) + ME*(Z(5
     &81)*Z(234)+Z(582)*Z(242)+2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z(570)-Z(571
     &)-Z(576)-2*Z(578)*Z(5)-Z(585)*Z(238)-Z(586)*Z(9)-Z(588)*Z(246)-Z(5
     &89)*Z(250)) + MG*(Z(581)*Z(234)+2*Z(568)*Z(3)+2*Z(574)*Z(26)+L2*GS
     &*Z(106)-Z(570)-Z(571)-Z(576)-2*Z(578)*Z(5)-Z(585)*Z(238)-Z(586)*Z(
     &9)-L6*GS*Z(111)-L8*GS*Z(29)) + MF*(Z(581)*Z(234)+Z(581)*Z(242)+Z(5
     &91)*Z(258)+2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z(570)-Z(571)-Z(576)-2*Z(5
     &78)*Z(5)-Z(585)*Z(238)-Z(585)*Z(246)-Z(586)*Z(9)-Z(586)*Z(250)-Z(5
     &93)*Z(262)-Z(594)*Z(266)) + MI*(Z(568)*Z(274)+Z(574)*Z(258)+Z(581)
     &*Z(234)+Z(581)*Z(242)+Z(596)*Z(318)+2*Z(568)*Z(3)+2*Z(574)*Z(26)-Z
     &(570)-Z(571)-Z(576)-2*Z(578)*Z(5)-Z(571)*Z(282)-Z(576)*Z(266)-Z(57
     &8)*Z(262)-Z(578)*Z(290)-Z(585)*Z(238)-Z(585)*Z(246)-Z(586)*Z(9)-Z(
     &586)*Z(250)-Z(595)*Z(322)-Z(599)*Z(326)) + 0.5D0*MH*(Z(603)*Z(286)
     &+Z(604)*Z(294)+2*Z(574)*Z(258)+2*Z(581)*Z(234)+2*Z(581)*Z(242)+2*Z
     &(605)*Z(274)+4*Z(568)*Z(3)+4*Z(574)*Z(26)-2*Z(570)-2*Z(571)-2*Z(57
     &6)-4*Z(578)*Z(5)-2*Z(576)*Z(266)-2*Z(578)*Z(262)-2*Z(585)*Z(238)-2
     &*Z(585)*Z(246)-2*Z(586)*Z(9)-2*Z(586)*Z(250)-2*Z(601)*Z(290)-2*Z(6
     &09)*Z(282)-Z(566)*Z(278)) - INA - INB - INC - Z(613) - 0.25D0*MB*(
     &Z(565)-4*Z(566)*Z(40)-4*Z(567)*Z(3))
      Z(616) = MC*(2*Z(568)*Z(3)+2*Z(569)*Z(26)-Z(570)-Z(571)-Z(572)-2*Z
     &(573)*Z(5)) + MD*(2*Z(568)*Z(3)+2*Z(574)*Z(26)+2*Z(575)*Z(234)-Z(5
     &70)-Z(571)-Z(576)-Z(577)-2*Z(578)*Z(5)-2*Z(579)*Z(238)-2*Z(580)*Z(
     &9)) + ME*(Z(582)*Z(242)+2*Z(568)*Z(3)+2*Z(574)*Z(26)+2*Z(581)*Z(23
     &4)-Z(570)-Z(571)-Z(576)-Z(583)-2*Z(578)*Z(5)-2*Z(585)*Z(238)-2*Z(5
     &86)*Z(9)-Z(587)*Z(254)-Z(588)*Z(246)-Z(589)*Z(250)) + MG*(2*Z(568)
     &*Z(3)+2*Z(574)*Z(26)+2*Z(581)*Z(234)+L2*GS*Z(106)-Z(570)-Z(571)-Z(
     &576)-Z(583)-2*Z(578)*Z(5)-2*Z(585)*Z(238)-2*Z(586)*Z(9)-L10*GS*Z(1
     &1)-L6*GS*Z(111)-L8*GS*Z(29)) + MF*(Z(581)*Z(242)+Z(591)*Z(258)+2*Z
     &(568)*Z(3)+2*Z(574)*Z(26)+2*Z(581)*Z(234)-Z(570)-Z(571)-Z(576)-Z(5
     &83)-2*Z(578)*Z(5)-2*Z(585)*Z(238)-2*Z(586)*Z(9)-Z(583)*Z(254)-Z(58
     &5)*Z(246)-Z(586)*Z(250)-Z(590)*Z(270)-Z(593)*Z(262)-Z(594)*Z(266))
     & + MI*(Z(568)*Z(274)+Z(574)*Z(258)+Z(581)*Z(242)+Z(596)*Z(318)+2*Z
     &(568)*Z(3)+2*Z(574)*Z(26)+2*Z(581)*Z(234)-Z(570)-Z(571)-Z(576)-Z(5
     &83)-2*Z(578)*Z(5)-2*Z(585)*Z(238)-2*Z(586)*Z(9)-Z(571)*Z(282)-Z(57
     &6)*Z(266)-Z(578)*Z(262)-Z(578)*Z(290)-Z(583)*Z(254)-Z(585)*Z(246)-
     &Z(585)*Z(298)-Z(586)*Z(250)-Z(586)*Z(270)-Z(595)*Z(322)-Z(598)*Z(3
     &30)-Z(599)*Z(326)) + 0.5D0*MH*(Z(602)*Z(302)+Z(603)*Z(286)+Z(604)*
     &Z(294)+2*Z(574)*Z(258)+2*Z(581)*Z(242)+2*Z(605)*Z(274)+4*Z(568)*Z(
     &3)+4*Z(574)*Z(26)+4*Z(581)*Z(234)-2*Z(570)-2*Z(571)-2*Z(576)-2*Z(5
     &83)-4*Z(578)*Z(5)-4*Z(585)*Z(238)-4*Z(586)*Z(9)-2*Z(576)*Z(266)-2*
     &Z(578)*Z(262)-2*Z(583)*Z(254)-2*Z(585)*Z(246)-2*Z(586)*Z(250)-2*Z(
     &586)*Z(270)-2*Z(601)*Z(290)-2*Z(608)*Z(298)-2*Z(609)*Z(282)-Z(566)
     &*Z(278)) - INA - INB - INC - IND - Z(613) - 0.25D0*MB*(Z(565)-4*Z(
     &566)*Z(40)-4*Z(567)*Z(3))
      Z(622) = Z(546) + Z(548) + Z(550) + 0.25D0*MB*(Z(617)*Z(167)+2*L2*
     &Z(4)*Z(167)+2*L2*Z(41)*Z(168)+2*L3*Z(42)*Z(164)-Z(618)*Z(168)-2*L4
     &*Z(4)*Z(164)) + MD*(L2*Z(4)*Z(172)+L2*Z(28)*Z(176)+L2*Z(233)*Z(178
     &)+L8*Z(6)*Z(172)+L8*Z(27)*Z(164)+L9*Z(10)*Z(176)+L9*Z(232)*Z(164)-
     &L6*Z(4)*Z(164)-L6*Z(6)*Z(176)-L6*Z(237)*Z(178)-L8*Z(10)*Z(178)-L9*
     &Z(236)*Z(172)) + MG*(GS*Z(197)+L10*Z(10)*Z(176)+L10*Z(11)*Z(197)+L
     &10*Z(12)*Z(196)+L10*Z(232)*Z(164)+L2*Z(4)*Z(172)+L2*Z(28)*Z(176)+L
     &2*Z(233)*Z(180)+L6*Z(109)*Z(196)+L6*Z(111)*Z(197)+L8*Z(6)*Z(172)+L
     &8*Z(27)*Z(164)+L8*Z(29)*Z(197)+L8*Z(31)*Z(196)+GS*Z(12)*Z(180)+GS*
     &Z(105)*Z(164)-L10*Z(236)*Z(172)-L2*Z(104)*Z(196)-L2*Z(106)*Z(197)-
     &L6*Z(4)*Z(164)-L6*Z(6)*Z(176)-L6*Z(237)*Z(180)-L8*Z(10)*Z(180)-GS*
     &Z(30)*Z(176)-GS*Z(110)*Z(172)) + ME*(L2*Z(182)*Z(242)+L10*Z(10)*Z(
     &176)+L10*Z(232)*Z(164)+L2*Z(4)*Z(172)+L2*Z(28)*Z(176)+L2*Z(233)*Z(
     &180)+L2*Z(241)*Z(183)+L8*Z(6)*Z(172)+L8*Z(27)*Z(164)+Z(21)*Z(240)*
     &Z(164)-Z(21)*Z(182)-L10*Z(182)*Z(254)-L6*Z(182)*Z(246)-L8*Z(182)*Z
     &(250)-L10*Z(236)*Z(172)-L10*Z(253)*Z(183)-L6*Z(4)*Z(164)-L6*Z(6)*Z
     &(176)-L6*Z(237)*Z(180)-L6*Z(245)*Z(183)-L8*Z(10)*Z(180)-L8*Z(249)*
     &Z(183)-Z(21)*Z(244)*Z(172)-Z(21)*Z(248)*Z(176)-Z(21)*Z(252)*Z(180)
     &) + MF*(L10*Z(15)*Z(188)+Z(22)*Z(15)*Z(185)+L2*Z(185)*Z(242)+L2*Z(
     &188)*Z(258)+L10*Z(16)*Z(190)+L10*Z(10)*Z(176)+L10*Z(232)*Z(164)+L1
     &0*Z(240)*Z(164)+L2*Z(4)*Z(172)+L2*Z(28)*Z(176)+L2*Z(233)*Z(180)+L2
     &*Z(241)*Z(186)+L2*Z(257)*Z(190)+L8*Z(6)*Z(172)+L8*Z(27)*Z(164)+Z(2
     &2)*Z(256)*Z(164)-L10*Z(185)-Z(22)*Z(188)-L10*Z(185)*Z(254)-L10*Z(1
     &88)*Z(270)-L6*Z(185)*Z(246)-L6*Z(188)*Z(262)-L8*Z(185)*Z(250)-L8*Z
     &(188)*Z(266)-L10*Z(236)*Z(172)-L10*Z(244)*Z(172)-L10*Z(248)*Z(176)
     &-L10*Z(252)*Z(180)-L10*Z(253)*Z(186)-L10*Z(269)*Z(190)-L6*Z(4)*Z(1
     &64)-L6*Z(6)*Z(176)-L6*Z(237)*Z(180)-L6*Z(245)*Z(186)-L6*Z(261)*Z(1
     &90)-L8*Z(10)*Z(180)-L8*Z(249)*Z(186)-L8*Z(265)*Z(190)-Z(22)*Z(16)*
     &Z(186)-Z(22)*Z(260)*Z(172)-Z(22)*Z(264)*Z(176)-Z(22)*Z(268)*Z(180)
     &) + MI*(L6*Z(199)+Z(25)*Z(212)+L10*Z(15)*Z(192)+L6*Z(17)*Z(192)+L8
     &*Z(15)*Z(185)+L10*Z(199)*Z(298)+L10*Z(199)*Z(306)+L10*Z(212)*Z(330
     &)+L10*Z(212)*Z(334)+L2*Z(185)*Z(242)+L2*Z(192)*Z(258)+L6*Z(199)*Z(
     &282)+L6*Z(212)*Z(322)+L8*Z(199)*Z(290)+L8*Z(212)*Z(326)+L8*Z(212)*
     &Z(338)+L10*Z(16)*Z(193)+L10*Z(10)*Z(176)+L10*Z(232)*Z(164)+L10*Z(2
     &40)*Z(164)+L2*Z(4)*Z(172)+L2*Z(28)*Z(176)+L2*Z(233)*Z(180)+L2*Z(24
     &1)*Z(186)+L2*Z(257)*Z(193)+L2*Z(273)*Z(201)+L2*Z(317)*Z(214)+L6*Z(
     &18)*Z(193)+L6*Z(272)*Z(164)+L8*Z(6)*Z(172)+L8*Z(27)*Z(164)+L8*Z(25
     &6)*Z(164)+Z(25)*Z(20)*Z(201)+Z(25)*Z(316)*Z(164)-L10*Z(185)-L8*Z(1
     &92)-L6*Z(19)*Z(212)-L8*Z(17)*Z(199)-Z(25)*Z(19)*Z(199)-L10*Z(185)*
     &Z(254)-L10*Z(192)*Z(270)-L2*Z(199)*Z(274)-L2*Z(212)*Z(318)-L6*Z(18
     &5)*Z(246)-L6*Z(185)*Z(306)-L6*Z(192)*Z(262)-L8*Z(185)*Z(250)-L8*Z(
     &192)*Z(266)-Z(25)*Z(185)*Z(334)-Z(25)*Z(192)*Z(338)-L10*Z(236)*Z(1
     &72)-L10*Z(244)*Z(172)-L10*Z(248)*Z(176)-L10*Z(252)*Z(180)-L10*Z(25
     &3)*Z(186)-L10*Z(269)*Z(193)-L10*Z(297)*Z(201)-L10*Z(305)*Z(201)-L1
     &0*Z(329)*Z(214)-L10*Z(333)*Z(214)-L6*Z(20)*Z(214)-L6*Z(4)*Z(164)-L
     &6*Z(6)*Z(176)-L6*Z(237)*Z(180)-L6*Z(245)*Z(186)-L6*Z(261)*Z(193)-L
     &6*Z(280)*Z(172)-L6*Z(281)*Z(201)-L6*Z(288)*Z(176)-L6*Z(296)*Z(180)
     &-L6*Z(304)*Z(186)-L6*Z(321)*Z(214)-L8*Z(16)*Z(186)-L8*Z(18)*Z(201)
     &-L8*Z(10)*Z(180)-L8*Z(249)*Z(186)-L8*Z(260)*Z(172)-L8*Z(264)*Z(176
     &)-L8*Z(265)*Z(193)-L8*Z(268)*Z(180)-L8*Z(289)*Z(201)-L8*Z(325)*Z(2
     &14)-L8*Z(337)*Z(214)-Z(25)*Z(320)*Z(172)-Z(25)*Z(324)*Z(176)-Z(25)
     &*Z(328)*Z(180)-Z(25)*Z(332)*Z(186)-Z(25)*Z(336)*Z(193)) + 0.25D0*M
     &H*(L3*Z(205)+4*Z(24)*Z(204)+4*L10*Z(15)*Z(192)+4*L8*Z(15)*Z(185)+4
     &*Z(24)*Z(17)*Z(192)+2*L2*Z(205)*Z(278)+2*L3*Z(185)*Z(310)+2*L3*Z(1
     &92)*Z(314)+4*L10*Z(204)*Z(298)+4*L10*Z(204)*Z(306)+4*L2*Z(185)*Z(2
     &42)+4*L2*Z(192)*Z(258)+4*L6*Z(204)*Z(282)+4*L8*Z(204)*Z(290)+2*Z(6
     &17)*Z(206)+4*Z(619)*Z(207)+2*L3*Z(284)*Z(172)+2*L3*Z(292)*Z(176)+2
     &*L3*Z(300)*Z(180)+2*L3*Z(308)*Z(186)+2*L3*Z(312)*Z(193)+4*L10*Z(16
     &)*Z(193)+4*L10*Z(10)*Z(176)+4*L10*Z(232)*Z(164)+4*L10*Z(240)*Z(164
     &)+4*L2*Z(4)*Z(172)+4*L2*Z(28)*Z(176)+4*L2*Z(233)*Z(180)+4*L2*Z(241
     &)*Z(186)+4*L2*Z(257)*Z(193)+4*L2*Z(273)*Z(206)+4*L2*Z(277)*Z(207)+
     &4*L8*Z(6)*Z(172)+4*L8*Z(27)*Z(164)+4*L8*Z(256)*Z(164)+4*Z(24)*Z(18
     &)*Z(193)+4*Z(24)*Z(272)*Z(164)-4*L10*Z(185)-4*L8*Z(192)-2*Z(620)*Z
     &(204)-2*Z(621)*Z(205)-4*L8*Z(17)*Z(204)-4*L10*Z(185)*Z(254)-4*L10*
     &Z(192)*Z(270)-4*L2*Z(204)*Z(274)-4*L6*Z(185)*Z(246)-4*L6*Z(192)*Z(
     &262)-4*L8*Z(185)*Z(250)-4*L8*Z(192)*Z(266)-4*Z(24)*Z(185)*Z(306)-2
     &*L10*Z(205)*Z(302)-2*L10*Z(205)*Z(310)-2*L6*Z(205)*Z(286)-2*L8*Z(2
     &05)*Z(294)-2*L8*Z(205)*Z(314)-4*L10*Z(236)*Z(172)-4*L10*Z(244)*Z(1
     &72)-4*L10*Z(248)*Z(176)-4*L10*Z(252)*Z(180)-4*L10*Z(253)*Z(186)-4*
     &L10*Z(269)*Z(193)-4*L10*Z(297)*Z(206)-4*L10*Z(301)*Z(207)-4*L10*Z(
     &305)*Z(206)-4*L10*Z(309)*Z(207)-4*L6*Z(4)*Z(164)-4*L6*Z(6)*Z(176)-
     &4*L6*Z(237)*Z(180)-4*L6*Z(245)*Z(186)-4*L6*Z(261)*Z(193)-4*L6*Z(28
     &1)*Z(206)-4*L6*Z(285)*Z(207)-4*L8*Z(16)*Z(186)-4*L8*Z(18)*Z(206)-4
     &*L8*Z(10)*Z(180)-4*L8*Z(249)*Z(186)-4*L8*Z(260)*Z(172)-4*L8*Z(264)
     &*Z(176)-4*L8*Z(265)*Z(193)-4*L8*Z(268)*Z(180)-4*L8*Z(289)*Z(206)-4
     &*L8*Z(293)*Z(207)-4*L8*Z(313)*Z(207)-4*Z(24)*Z(280)*Z(172)-4*Z(24)
     &*Z(288)*Z(176)-4*Z(24)*Z(296)*Z(180)-4*Z(24)*Z(304)*Z(186)-2*L3*Z(
     &276)*Z(164)) - Z(544) - MC*(L6*Z(4)*Z(164)+L6*Z(6)*Z(174)-L2*Z(4)*
     &Z(172)-L2*Z(28)*Z(174)-L7*Z(6)*Z(172)-L7*Z(27)*Z(164))
      Z(628) = L2*(MB*(Z(4)*Z(167)+Z(41)*Z(168))+2*MC*(Z(4)*Z(172)+Z(28)
     &*Z(174))+2*MD*(Z(4)*Z(172)+Z(28)*Z(176)+Z(233)*Z(178))+2*ME*(Z(182
     &)*Z(242)+Z(4)*Z(172)+Z(28)*Z(176)+Z(233)*Z(180)+Z(241)*Z(183))+2*M
     &F*(Z(185)*Z(242)+Z(188)*Z(258)+Z(4)*Z(172)+Z(28)*Z(176)+Z(233)*Z(1
     &80)+Z(241)*Z(186)+Z(257)*Z(190))-2*MG*(Z(104)*Z(196)+Z(106)*Z(197)
     &-Z(4)*Z(172)-Z(28)*Z(176)-Z(233)*Z(180))-2*MI*(Z(199)*Z(274)+Z(212
     &)*Z(318)-Z(185)*Z(242)-Z(192)*Z(258)-Z(4)*Z(172)-Z(28)*Z(176)-Z(23
     &3)*Z(180)-Z(241)*Z(186)-Z(257)*Z(193)-Z(273)*Z(201)-Z(317)*Z(214))
     &-MH*(2*Z(204)*Z(274)-2*Z(185)*Z(242)-2*Z(192)*Z(258)-Z(205)*Z(278)
     &-2*Z(4)*Z(172)-2*Z(28)*Z(176)-2*Z(233)*Z(180)-2*Z(241)*Z(186)-2*Z(
     &257)*Z(193)-2*Z(273)*Z(206)-2*Z(277)*Z(207)))
      Z(634) = -MC*(L2*Z(4)*Z(172)+L2*Z(28)*Z(174)-L6*Z(4)*Z(164)-L6*Z(6
     &)*Z(174)) - MD*(L2*Z(4)*Z(172)+L2*Z(28)*Z(176)+L2*Z(233)*Z(178)-L6
     &*Z(4)*Z(164)-L6*Z(6)*Z(176)-L6*Z(237)*Z(178)) - 0.25D0*MB*(Z(617)*
     &Z(167)+2*L2*Z(4)*Z(167)+2*L2*Z(41)*Z(168)+2*L3*Z(42)*Z(164)-Z(618)
     &*Z(168)-2*L4*Z(4)*Z(164)) - ME*(L2*Z(182)*Z(242)+L2*Z(4)*Z(172)+L2
     &*Z(28)*Z(176)+L2*Z(233)*Z(180)+L2*Z(241)*Z(183)-L6*Z(182)*Z(246)-L
     &6*Z(4)*Z(164)-L6*Z(6)*Z(176)-L6*Z(237)*Z(180)-L6*Z(245)*Z(183)) - 
     &MG*(L2*Z(4)*Z(172)+L2*Z(28)*Z(176)+L2*Z(233)*Z(180)+L6*Z(109)*Z(19
     &6)+L6*Z(111)*Z(197)-L2*Z(104)*Z(196)-L2*Z(106)*Z(197)-L6*Z(4)*Z(16
     &4)-L6*Z(6)*Z(176)-L6*Z(237)*Z(180)) - MF*(L2*Z(185)*Z(242)+L2*Z(18
     &8)*Z(258)+L2*Z(4)*Z(172)+L2*Z(28)*Z(176)+L2*Z(233)*Z(180)+L2*Z(241
     &)*Z(186)+L2*Z(257)*Z(190)-L6*Z(185)*Z(246)-L6*Z(188)*Z(262)-L6*Z(4
     &)*Z(164)-L6*Z(6)*Z(176)-L6*Z(237)*Z(180)-L6*Z(245)*Z(186)-L6*Z(261
     &)*Z(190)) - MI*(L2*Z(185)*Z(242)+L2*Z(192)*Z(258)+L6*Z(199)*Z(282)
     &+L6*Z(212)*Z(322)+L2*Z(4)*Z(172)+L2*Z(28)*Z(176)+L2*Z(233)*Z(180)+
     &L2*Z(241)*Z(186)+L2*Z(257)*Z(193)+L2*Z(273)*Z(201)+L2*Z(317)*Z(214
     &)-L2*Z(199)*Z(274)-L2*Z(212)*Z(318)-L6*Z(185)*Z(246)-L6*Z(192)*Z(2
     &62)-L6*Z(4)*Z(164)-L6*Z(6)*Z(176)-L6*Z(237)*Z(180)-L6*Z(245)*Z(186
     &)-L6*Z(261)*Z(193)-L6*Z(281)*Z(201)-L6*Z(321)*Z(214)) - 0.5D0*MH*(
     &L2*Z(205)*Z(278)+2*L2*Z(185)*Z(242)+2*L2*Z(192)*Z(258)+2*L6*Z(204)
     &*Z(282)+2*L2*Z(4)*Z(172)+2*L2*Z(28)*Z(176)+2*L2*Z(233)*Z(180)+2*L2
     &*Z(241)*Z(186)+2*L2*Z(257)*Z(193)+2*L2*Z(273)*Z(206)+2*L2*Z(277)*Z
     &(207)-2*L2*Z(204)*Z(274)-2*L6*Z(185)*Z(246)-2*L6*Z(192)*Z(262)-L6*
     &Z(205)*Z(286)-2*L6*Z(4)*Z(164)-2*L6*Z(6)*Z(176)-2*L6*Z(237)*Z(180)
     &-2*L6*Z(245)*Z(186)-2*L6*Z(261)*Z(193)-2*L6*Z(281)*Z(206)-2*L6*Z(2
     &85)*Z(207))
      Z(638) = MC*(L6*Z(4)*Z(164)+L6*Z(6)*Z(174)-L2*Z(4)*Z(172)-L2*Z(28)
     &*Z(174)-L7*Z(6)*Z(172)-L7*Z(27)*Z(164)) + MD*(L6*Z(4)*Z(164)+L6*Z(
     &6)*Z(176)+L6*Z(237)*Z(178)+L8*Z(10)*Z(178)-L2*Z(4)*Z(172)-L2*Z(28)
     &*Z(176)-L2*Z(233)*Z(178)-L8*Z(6)*Z(172)-L8*Z(27)*Z(164)) + MG*(L2*
     &Z(104)*Z(196)+L2*Z(106)*Z(197)+L6*Z(4)*Z(164)+L6*Z(6)*Z(176)+L6*Z(
     &237)*Z(180)+L8*Z(10)*Z(180)-L2*Z(4)*Z(172)-L2*Z(28)*Z(176)-L2*Z(23
     &3)*Z(180)-L6*Z(109)*Z(196)-L6*Z(111)*Z(197)-L8*Z(6)*Z(172)-L8*Z(27
     &)*Z(164)-L8*Z(29)*Z(197)-L8*Z(31)*Z(196)) - 0.25D0*MB*(Z(617)*Z(16
     &7)+2*L2*Z(4)*Z(167)+2*L2*Z(41)*Z(168)+2*L3*Z(42)*Z(164)-Z(618)*Z(1
     &68)-2*L4*Z(4)*Z(164)) - ME*(L2*Z(182)*Z(242)+L2*Z(4)*Z(172)+L2*Z(2
     &8)*Z(176)+L2*Z(233)*Z(180)+L2*Z(241)*Z(183)+L8*Z(6)*Z(172)+L8*Z(27
     &)*Z(164)-L6*Z(182)*Z(246)-L8*Z(182)*Z(250)-L6*Z(4)*Z(164)-L6*Z(6)*
     &Z(176)-L6*Z(237)*Z(180)-L6*Z(245)*Z(183)-L8*Z(10)*Z(180)-L8*Z(249)
     &*Z(183)) - MF*(L2*Z(185)*Z(242)+L2*Z(188)*Z(258)+L2*Z(4)*Z(172)+L2
     &*Z(28)*Z(176)+L2*Z(233)*Z(180)+L2*Z(241)*Z(186)+L2*Z(257)*Z(190)+L
     &8*Z(6)*Z(172)+L8*Z(27)*Z(164)-L6*Z(185)*Z(246)-L6*Z(188)*Z(262)-L8
     &*Z(185)*Z(250)-L8*Z(188)*Z(266)-L6*Z(4)*Z(164)-L6*Z(6)*Z(176)-L6*Z
     &(237)*Z(180)-L6*Z(245)*Z(186)-L6*Z(261)*Z(190)-L8*Z(10)*Z(180)-L8*
     &Z(249)*Z(186)-L8*Z(265)*Z(190)) - MI*(L2*Z(185)*Z(242)+L2*Z(192)*Z
     &(258)+L6*Z(199)*Z(282)+L6*Z(212)*Z(322)+L8*Z(199)*Z(290)+L8*Z(212)
     &*Z(326)+L2*Z(4)*Z(172)+L2*Z(28)*Z(176)+L2*Z(233)*Z(180)+L2*Z(241)*
     &Z(186)+L2*Z(257)*Z(193)+L2*Z(273)*Z(201)+L2*Z(317)*Z(214)+L8*Z(6)*
     &Z(172)+L8*Z(27)*Z(164)-L2*Z(199)*Z(274)-L2*Z(212)*Z(318)-L6*Z(185)
     &*Z(246)-L6*Z(192)*Z(262)-L8*Z(185)*Z(250)-L8*Z(192)*Z(266)-L6*Z(4)
     &*Z(164)-L6*Z(6)*Z(176)-L6*Z(237)*Z(180)-L6*Z(245)*Z(186)-L6*Z(261)
     &*Z(193)-L6*Z(281)*Z(201)-L6*Z(321)*Z(214)-L8*Z(10)*Z(180)-L8*Z(249
     &)*Z(186)-L8*Z(265)*Z(193)-L8*Z(289)*Z(201)-L8*Z(325)*Z(214)) - 0.5
     &D0*MH*(L2*Z(205)*Z(278)+2*L2*Z(185)*Z(242)+2*L2*Z(192)*Z(258)+2*L6
     &*Z(204)*Z(282)+2*L8*Z(204)*Z(290)+2*L2*Z(4)*Z(172)+2*L2*Z(28)*Z(17
     &6)+2*L2*Z(233)*Z(180)+2*L2*Z(241)*Z(186)+2*L2*Z(257)*Z(193)+2*L2*Z
     &(273)*Z(206)+2*L2*Z(277)*Z(207)+2*L8*Z(6)*Z(172)+2*L8*Z(27)*Z(164)
     &-2*L2*Z(204)*Z(274)-2*L6*Z(185)*Z(246)-2*L6*Z(192)*Z(262)-2*L8*Z(1
     &85)*Z(250)-2*L8*Z(192)*Z(266)-L6*Z(205)*Z(286)-L8*Z(205)*Z(294)-2*
     &L6*Z(4)*Z(164)-2*L6*Z(6)*Z(176)-2*L6*Z(237)*Z(180)-2*L6*Z(245)*Z(1
     &86)-2*L6*Z(261)*Z(193)-2*L6*Z(281)*Z(206)-2*L6*Z(285)*Z(207)-2*L8*
     &Z(10)*Z(180)-2*L8*Z(249)*Z(186)-2*L8*Z(265)*Z(193)-2*L8*Z(289)*Z(2
     &06)-2*L8*Z(293)*Z(207))
      Z(641) = MC*(L6*Z(4)*Z(164)+L6*Z(6)*Z(174)-L2*Z(4)*Z(172)-L2*Z(28)
     &*Z(174)-L7*Z(6)*Z(172)-L7*Z(27)*Z(164)) + MG*(L10*Z(236)*Z(172)+L2
     &*Z(104)*Z(196)+L2*Z(106)*Z(197)+L6*Z(4)*Z(164)+L6*Z(6)*Z(176)+L6*Z
     &(237)*Z(180)+L8*Z(10)*Z(180)-L10*Z(10)*Z(176)-L10*Z(11)*Z(197)-L10
     &*Z(12)*Z(196)-L10*Z(232)*Z(164)-L2*Z(4)*Z(172)-L2*Z(28)*Z(176)-L2*
     &Z(233)*Z(180)-L6*Z(109)*Z(196)-L6*Z(111)*Z(197)-L8*Z(6)*Z(172)-L8*
     &Z(27)*Z(164)-L8*Z(29)*Z(197)-L8*Z(31)*Z(196)) - 0.25D0*MB*(Z(617)*
     &Z(167)+2*L2*Z(4)*Z(167)+2*L2*Z(41)*Z(168)+2*L3*Z(42)*Z(164)-Z(618)
     &*Z(168)-2*L4*Z(4)*Z(164)) - MD*(L2*Z(4)*Z(172)+L2*Z(28)*Z(176)+L2*
     &Z(233)*Z(178)+L8*Z(6)*Z(172)+L8*Z(27)*Z(164)+L9*Z(10)*Z(176)+L9*Z(
     &232)*Z(164)-L6*Z(4)*Z(164)-L6*Z(6)*Z(176)-L6*Z(237)*Z(178)-L8*Z(10
     &)*Z(178)-L9*Z(236)*Z(172)) - ME*(L2*Z(182)*Z(242)+L10*Z(10)*Z(176)
     &+L10*Z(232)*Z(164)+L2*Z(4)*Z(172)+L2*Z(28)*Z(176)+L2*Z(233)*Z(180)
     &+L2*Z(241)*Z(183)+L8*Z(6)*Z(172)+L8*Z(27)*Z(164)-L10*Z(182)*Z(254)
     &-L6*Z(182)*Z(246)-L8*Z(182)*Z(250)-L10*Z(236)*Z(172)-L10*Z(253)*Z(
     &183)-L6*Z(4)*Z(164)-L6*Z(6)*Z(176)-L6*Z(237)*Z(180)-L6*Z(245)*Z(18
     &3)-L8*Z(10)*Z(180)-L8*Z(249)*Z(183)) - MF*(L2*Z(185)*Z(242)+L2*Z(1
     &88)*Z(258)+L10*Z(10)*Z(176)+L10*Z(232)*Z(164)+L2*Z(4)*Z(172)+L2*Z(
     &28)*Z(176)+L2*Z(233)*Z(180)+L2*Z(241)*Z(186)+L2*Z(257)*Z(190)+L8*Z
     &(6)*Z(172)+L8*Z(27)*Z(164)-L10*Z(185)*Z(254)-L10*Z(188)*Z(270)-L6*
     &Z(185)*Z(246)-L6*Z(188)*Z(262)-L8*Z(185)*Z(250)-L8*Z(188)*Z(266)-L
     &10*Z(236)*Z(172)-L10*Z(253)*Z(186)-L10*Z(269)*Z(190)-L6*Z(4)*Z(164
     &)-L6*Z(6)*Z(176)-L6*Z(237)*Z(180)-L6*Z(245)*Z(186)-L6*Z(261)*Z(190
     &)-L8*Z(10)*Z(180)-L8*Z(249)*Z(186)-L8*Z(265)*Z(190)) - MI*(L10*Z(1
     &99)*Z(298)+L10*Z(212)*Z(330)+L2*Z(185)*Z(242)+L2*Z(192)*Z(258)+L6*
     &Z(199)*Z(282)+L6*Z(212)*Z(322)+L8*Z(199)*Z(290)+L8*Z(212)*Z(326)+L
     &10*Z(10)*Z(176)+L10*Z(232)*Z(164)+L2*Z(4)*Z(172)+L2*Z(28)*Z(176)+L
     &2*Z(233)*Z(180)+L2*Z(241)*Z(186)+L2*Z(257)*Z(193)+L2*Z(273)*Z(201)
     &+L2*Z(317)*Z(214)+L8*Z(6)*Z(172)+L8*Z(27)*Z(164)-L10*Z(185)*Z(254)
     &-L10*Z(192)*Z(270)-L2*Z(199)*Z(274)-L2*Z(212)*Z(318)-L6*Z(185)*Z(2
     &46)-L6*Z(192)*Z(262)-L8*Z(185)*Z(250)-L8*Z(192)*Z(266)-L10*Z(236)*
     &Z(172)-L10*Z(253)*Z(186)-L10*Z(269)*Z(193)-L10*Z(297)*Z(201)-L10*Z
     &(329)*Z(214)-L6*Z(4)*Z(164)-L6*Z(6)*Z(176)-L6*Z(237)*Z(180)-L6*Z(2
     &45)*Z(186)-L6*Z(261)*Z(193)-L6*Z(281)*Z(201)-L6*Z(321)*Z(214)-L8*Z
     &(10)*Z(180)-L8*Z(249)*Z(186)-L8*Z(265)*Z(193)-L8*Z(289)*Z(201)-L8*
     &Z(325)*Z(214)) - 0.5D0*MH*(L2*Z(205)*Z(278)+2*L10*Z(204)*Z(298)+2*
     &L2*Z(185)*Z(242)+2*L2*Z(192)*Z(258)+2*L6*Z(204)*Z(282)+2*L8*Z(204)
     &*Z(290)+2*L10*Z(10)*Z(176)+2*L10*Z(232)*Z(164)+2*L2*Z(4)*Z(172)+2*
     &L2*Z(28)*Z(176)+2*L2*Z(233)*Z(180)+2*L2*Z(241)*Z(186)+2*L2*Z(257)*
     &Z(193)+2*L2*Z(273)*Z(206)+2*L2*Z(277)*Z(207)+2*L8*Z(6)*Z(172)+2*L8
     &*Z(27)*Z(164)-2*L10*Z(185)*Z(254)-2*L10*Z(192)*Z(270)-2*L2*Z(204)*
     &Z(274)-2*L6*Z(185)*Z(246)-2*L6*Z(192)*Z(262)-2*L8*Z(185)*Z(250)-2*
     &L8*Z(192)*Z(266)-L10*Z(205)*Z(302)-L6*Z(205)*Z(286)-L8*Z(205)*Z(29
     &4)-2*L10*Z(236)*Z(172)-2*L10*Z(253)*Z(186)-2*L10*Z(269)*Z(193)-2*L
     &10*Z(297)*Z(206)-2*L10*Z(301)*Z(207)-2*L6*Z(4)*Z(164)-2*L6*Z(6)*Z(
     &176)-2*L6*Z(237)*Z(180)-2*L6*Z(245)*Z(186)-2*L6*Z(261)*Z(193)-2*L6
     &*Z(281)*Z(206)-2*L6*Z(285)*Z(207)-2*L8*Z(10)*Z(180)-2*L8*Z(249)*Z(
     &186)-2*L8*Z(265)*Z(193)-2*L8*Z(289)*Z(206)-2*L8*Z(293)*Z(207))
      Z(678) = Z(511) - Z(557)
      Z(679) = Z(513) - Z(563)
      Z(680) = Z(515) - Z(622)
      Z(681) = Z(524) + 0.5D0*Z(628)
      Z(682) = Z(525) - Z(634)
      Z(683) = Z(526) - Z(638)
      Z(684) = Z(527) - Z(641)

      COEF(1,1) = -Z(74)
      COEF(1,2) = 0
      COEF(1,3) = -Z(551)
      COEF(1,4) = -Z(553)
      COEF(1,5) = -Z(554)
      COEF(1,6) = -Z(555)
      COEF(1,7) = -Z(556)
      COEF(2,1) = 0
      COEF(2,2) = -Z(74)
      COEF(2,3) = -Z(558)
      COEF(2,4) = -Z(559)
      COEF(2,5) = -Z(560)
      COEF(2,6) = -Z(561)
      COEF(2,7) = -Z(562)
      COEF(3,1) = -Z(551)
      COEF(3,2) = -Z(558)
      COEF(3,3) = -Z(610)
      COEF(3,4) = -Z(612)
      COEF(3,5) = -Z(614)
      COEF(3,6) = -Z(615)
      COEF(3,7) = -Z(616)
      COEF(4,1) = -Z(553)
      COEF(4,2) = -Z(559)
      COEF(4,3) = -Z(612)
      COEF(4,4) = -Z(623)
      COEF(4,5) = -Z(625)
      COEF(4,6) = -Z(626)
      COEF(4,7) = -Z(627)
      COEF(5,1) = -Z(554)
      COEF(5,2) = -Z(560)
      COEF(5,3) = -Z(614)
      COEF(5,4) = -Z(625)
      COEF(5,5) = -Z(631)
      COEF(5,6) = -Z(632)
      COEF(5,7) = -Z(633)
      COEF(6,1) = -Z(555)
      COEF(6,2) = -Z(561)
      COEF(6,3) = -Z(615)
      COEF(6,4) = -Z(626)
      COEF(6,5) = -Z(632)
      COEF(6,6) = -Z(636)
      COEF(6,7) = -Z(637)
      COEF(7,1) = -Z(556)
      COEF(7,2) = -Z(562)
      COEF(7,3) = -Z(616)
      COEF(7,4) = -Z(627)
      COEF(7,5) = -Z(633)
      COEF(7,6) = -Z(637)
      COEF(7,7) = -Z(640)
      RHS(1) = -Z(678)
      RHS(2) = -Z(679)
      RHS(3) = -Z(680)
      RHS(4) = -Z(681)
      RHS(5) = -Z(682)
      RHS(6) = -Z(683)
      RHS(7) = -Z(684)
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
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(688),COEF(7,7),RHS(7)

C**   Evaluate output quantities
      KECM = 0.5D0*ING*U3**2 + 0.5D0*IND*(U3-U7)**2 + 0.5D0*INC*(U3-U6-U
     &7)**2 + 0.5D0*INE*(EAp-U3-U8)**2 + 0.5D0*INB*(U3-U5-U6-U7)**2 + 0.
     &5D0*INA*(U3-U4-U5-U6-U7)**2 + 0.5D0*INF*(EAp-FAp-U3-U8-U9)**2 + 0.
     &5D0*INH*(EAp+HAp-FAp-U10-U3-U8-U9)**2 + 0.5D0*INI*(EAp+HAp+IAp-FAp
     &-U10-U11-U3-U8-U9)**2 + 0.5D0*MC*(U1**2+U2**2+L7**2*(U3-U6-U7)**2+
     &2*L7*Z(34)*U1*(U3-U6-U7)+2*L7*Z(35)*U2*(U3-U6-U7)+L6**2*(U3-U5-U6-
     &U7)**2+2*L6*Z(49)*U1*(U3-U5-U6-U7)+2*L6*Z(50)*U2*(U3-U5-U6-U7)+L2*
     &*2*(U3-U4-U5-U6-U7)**2+2*L6*L7*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-2*L2*
     &Z(38)*U1*(U3-U4-U5-U6-U7)-2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-2*L2*L7*Z
     &(26)*(U3-U6-U7)*(U3-U4-U5-U6-U7)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4
     &-U5-U6-U7)) + 0.125D0*MB*(4*U1**2+4*U2**2+L3**2*(U3-U5-U6-U7)**2+L
     &4**2*(U3-U5-U6-U7)**2+4*L3*Z(45)*U1*(U3-U5-U6-U7)+4*L3*Z(46)*U2*(U
     &3-U5-U6-U7)+4*L4*Z(49)*U1*(U3-U5-U6-U7)+4*L4*Z(50)*U2*(U3-U5-U6-U7
     &)+2*L3*L4*Z(7)*(U3-U5-U6-U7)**2+4*L2**2*(U3-U4-U5-U6-U7)**2-8*L2*Z
     &(38)*U1*(U3-U4-U5-U6-U7)-8*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-4*L2*L3*Z(
     &40)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)-4*L2*L4*Z(3)*(U3-U5-U6-U7)*(U3-
     &U4-U5-U6-U7)) + 0.5D0*MD*(U1**2+U2**2+L9**2*(U3-U7)**2+2*L9*Z(53)*
     &U1*(U3-U7)+2*L9*Z(54)*U2*(U3-U7)+L8**2*(U3-U6-U7)**2+2*L8*Z(34)*U1
     &*(U3-U6-U7)+2*L8*Z(35)*U2*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)**2+2*L6*Z
     &(49)*U1*(U3-U5-U6-U7)+2*L6*Z(50)*U2*(U3-U5-U6-U7)+L2**2*(U3-U4-U5-
     &U6-U7)**2+2*L8*L9*Z(9)*(U3-U7)*(U3-U6-U7)+2*L6*L9*Z(238)*(U3-U7)*(
     &U3-U5-U6-U7)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-2*L2*Z(38)*U1*(
     &U3-U4-U5-U6-U7)-2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-2*L2*L9*Z(234)*(U3-
     &U7)*(U3-U4-U5-U6-U7)-2*L2*L8*Z(26)*(U3-U6-U7)*(U3-U4-U5-U6-U7)-2*L
     &2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)) + 0.5D0*ME*(U1**2+U2**2+
     &L10**2*(U3-U7)**2+2*L10*Z(53)*U1*(U3-U7)+2*L10*Z(54)*U2*(U3-U7)+(Z
     &(136)-Z(21)*U3-Z(21)*U8)**2+L8**2*(U3-U6-U7)**2+2*L8*Z(34)*U1*(U3-
     &U6-U7)+2*L8*Z(35)*U2*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)**2+2*L6*Z(49)*
     &U1*(U3-U5-U6-U7)+2*L6*Z(50)*U2*(U3-U5-U6-U7)+L2**2*(U3-U4-U5-U6-U7
     &)**2+2*L10*L8*Z(9)*(U3-U7)*(U3-U6-U7)+2*L10*L6*Z(238)*(U3-U7)*(U3-
     &U5-U6-U7)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)+2*L2*Z(242)*(Z(136
     &)-Z(21)*U3-Z(21)*U8)*(U3-U4-U5-U6-U7)-2*Z(55)*U2*(Z(136)-Z(21)*U3-
     &Z(21)*U8)-2*Z(57)*U1*(Z(136)-Z(21)*U3-Z(21)*U8)-2*L2*Z(38)*U1*(U3-
     &U4-U5-U6-U7)-2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-2*L10*Z(254)*(U3-U7)*(
     &Z(136)-Z(21)*U3-Z(21)*U8)-2*L8*Z(250)*(U3-U6-U7)*(Z(136)-Z(21)*U3-
     &Z(21)*U8)-2*L10*L2*Z(234)*(U3-U7)*(U3-U4-U5-U6-U7)-2*L6*Z(246)*(Z(
     &136)-Z(21)*U3-Z(21)*U8)*(U3-U5-U6-U7)-2*L2*L8*Z(26)*(U3-U6-U7)*(U3
     &-U4-U5-U6-U7)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)) + 0.5D0
     &*MG*(GSp**2+U1**2+U2**2+2*GSp*Z(1)*U1+2*GSp*Z(2)*U2+GS**2*U3**2+2*
     &GS*Z(1)*U2*U3+L10**2*(U3-U7)**2+2*L10*GSp*Z(12)*(U3-U7)+2*L10*Z(53
     &)*U1*(U3-U7)+2*L10*Z(54)*U2*(U3-U7)+2*L10*GS*Z(11)*U3*(U3-U7)+L8**
     &2*(U3-U6-U7)**2+2*L8*GSp*Z(31)*(U3-U6-U7)+2*L8*Z(34)*U1*(U3-U6-U7)
     &+2*L8*Z(35)*U2*(U3-U6-U7)+2*L8*GS*Z(29)*U3*(U3-U6-U7)+L6**2*(U3-U5
     &-U6-U7)**2+2*L6*GSp*Z(109)*(U3-U5-U6-U7)+2*L6*Z(49)*U1*(U3-U5-U6-U
     &7)+2*L6*Z(50)*U2*(U3-U5-U6-U7)+2*L6*GS*Z(111)*U3*(U3-U5-U6-U7)+L2*
     &*2*(U3-U4-U5-U6-U7)**2+2*L10*L8*Z(9)*(U3-U7)*(U3-U6-U7)+2*L10*L6*Z
     &(238)*(U3-U7)*(U3-U5-U6-U7)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-
     &2*GS*Z(2)*U1*U3-2*L2*GSp*Z(104)*(U3-U4-U5-U6-U7)-2*L2*Z(38)*U1*(U3
     &-U4-U5-U6-U7)-2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-2*L2*GS*Z(106)*U3*(U3
     &-U4-U5-U6-U7)-2*L10*L2*Z(234)*(U3-U7)*(U3-U4-U5-U6-U7)-2*L2*L8*Z(2
     &6)*(U3-U6-U7)*(U3-U4-U5-U6-U7)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U
     &5-U6-U7)) + 0.5D0*MI*(U1**2+U2**2+L10**2*(U3-U7)**2+2*L10*Z(53)*U1
     &*(U3-U7)+2*L10*Z(54)*U2*(U3-U7)+(Z(137)-L10*U3-L10*U8)**2+L8**2*(U
     &3-U6-U7)**2+2*L8*Z(34)*U1*(U3-U6-U7)+2*L8*Z(35)*U2*(U3-U6-U7)+(Z(1
     &40)+L6*U10+L6*U3+L6*U8+L6*U9)**2+L6**2*(U3-U5-U6-U7)**2+(Z(139)-L8
     &*U3-L8*U8-L8*U9)**2+2*L6*Z(49)*U1*(U3-U5-U6-U7)+2*L6*Z(50)*U2*(U3-
     &U5-U6-U7)+(Z(148)+Z(25)*U10+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)*
     &*2+2*Z(64)*U1*(Z(140)+L6*U10+L6*U3+L6*U8+L6*U9)+2*Z(65)*U2*(Z(140)
     &+L6*U10+L6*U3+L6*U8+L6*U9)+L2**2*(U3-U4-U5-U6-U7)**2+2*L10*L8*Z(9)
     &*(U3-U7)*(U3-U6-U7)+2*Z(72)*U1*(Z(148)+Z(25)*U10+Z(25)*U11+Z(25)*U
     &3+Z(25)*U8+Z(25)*U9)+2*Z(73)*U2*(Z(148)+Z(25)*U10+Z(25)*U11+Z(25)*
     &U3+Z(25)*U8+Z(25)*U9)+2*L10*L6*Z(238)*(U3-U7)*(U3-U5-U6-U7)+2*L10*
     &Z(298)*(U3-U7)*(Z(140)+L6*U10+L6*U3+L6*U8+L6*U9)+2*L6*L8*Z(5)*(U3-
     &U6-U7)*(U3-U5-U6-U7)+2*L10*Z(330)*(U3-U7)*(Z(148)+Z(25)*U10+Z(25)*
     &U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)+2*L8*Z(290)*(U3-U6-U7)*(Z(140)+L6*
     &U10+L6*U3+L6*U8+L6*U9)+2*L2*Z(242)*(Z(137)-L10*U3-L10*U8)*(U3-U4-U
     &5-U6-U7)+2*L6*Z(282)*(U3-U5-U6-U7)*(Z(140)+L6*U10+L6*U3+L6*U8+L6*U
     &9)+2*L8*Z(326)*(U3-U6-U7)*(Z(148)+Z(25)*U10+Z(25)*U11+Z(25)*U3+Z(2
     &5)*U8+Z(25)*U9)+2*L6*Z(322)*(U3-U5-U6-U7)*(Z(148)+Z(25)*U10+Z(25)*
     &U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)+2*Z(17)*(Z(140)+L6*U10+L6*U3+L6*U8
     &+L6*U9)*(Z(139)-L8*U3-L8*U8-L8*U9)+2*L2*Z(258)*(U3-U4-U5-U6-U7)*(Z
     &(139)-L8*U3-L8*U8-L8*U9)-2*Z(55)*U2*(Z(137)-L10*U3-L10*U8)-2*Z(57)
     &*U1*(Z(137)-L10*U3-L10*U8)-2*L2*Z(38)*U1*(U3-U4-U5-U6-U7)-2*L2*Z(3
     &9)*U2*(U3-U4-U5-U6-U7)-2*Z(60)*U1*(Z(139)-L8*U3-L8*U8-L8*U9)-2*Z(6
     &1)*U2*(Z(139)-L8*U3-L8*U8-L8*U9)-2*L10*Z(254)*(U3-U7)*(Z(137)-L10*
     &U3-L10*U8)-2*L8*Z(250)*(U3-U6-U7)*(Z(137)-L10*U3-L10*U8)-2*L10*L2*
     &Z(234)*(U3-U7)*(U3-U4-U5-U6-U7)-2*L10*Z(270)*(U3-U7)*(Z(139)-L8*U3
     &-L8*U8-L8*U9)-2*L6*Z(246)*(Z(137)-L10*U3-L10*U8)*(U3-U5-U6-U7)-2*L
     &2*L8*Z(26)*(U3-U6-U7)*(U3-U4-U5-U6-U7)-2*L8*Z(266)*(U3-U6-U7)*(Z(1
     &39)-L8*U3-L8*U8-L8*U9)-2*Z(306)*(Z(137)-L10*U3-L10*U8)*(Z(140)+L6*
     &U10+L6*U3+L6*U8+L6*U9)-2*Z(15)*(Z(137)-L10*U3-L10*U8)*(Z(139)-L8*U
     &3-L8*U8-L8*U9)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)-2*L6*Z(
     &262)*(U3-U5-U6-U7)*(Z(139)-L8*U3-L8*U8-L8*U9)-2*Z(334)*(Z(137)-L10
     &*U3-L10*U8)*(Z(148)+Z(25)*U10+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9
     &)-2*L2*Z(274)*(Z(140)+L6*U10+L6*U3+L6*U8+L6*U9)*(U3-U4-U5-U6-U7)-2
     &*Z(19)*(Z(140)+L6*U10+L6*U3+L6*U8+L6*U9)*(Z(148)+Z(25)*U10+Z(25)*U
     &11+Z(25)*U3+Z(25)*U8+Z(25)*U9)-2*L2*Z(318)*(U3-U4-U5-U6-U7)*(Z(148
     &)+Z(25)*U10+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)-2*Z(338)*(Z(139)
     &-L8*U3-L8*U8-L8*U9)*(Z(148)+Z(25)*U10+Z(25)*U11+Z(25)*U3+Z(25)*U8+
     &Z(25)*U9)) - 0.5D0*MA*(2*L1*Z(38)*U1*(U3-U4-U5-U6-U7)+2*L1*Z(39)*U
     &2*(U3-U4-U5-U6-U7)-U1**2-U2**2-L1**2*(U3-U4-U5-U6-U7)**2) - 0.5D0*
     &MF*(2*Z(55)*U2*(Z(137)-L10*U3-L10*U8)+2*Z(57)*U1*(Z(137)-L10*U3-L1
     &0*U8)+2*L2*Z(38)*U1*(U3-U4-U5-U6-U7)+2*L2*Z(39)*U2*(U3-U4-U5-U6-U7
     &)+2*Z(60)*U1*(Z(138)-Z(22)*U3-Z(22)*U8-Z(22)*U9)+2*Z(61)*U2*(Z(138
     &)-Z(22)*U3-Z(22)*U8-Z(22)*U9)+2*L10*Z(254)*(U3-U7)*(Z(137)-L10*U3-
     &L10*U8)+2*L8*Z(250)*(U3-U6-U7)*(Z(137)-L10*U3-L10*U8)+2*L10*L2*Z(2
     &34)*(U3-U7)*(U3-U4-U5-U6-U7)+2*L10*Z(270)*(U3-U7)*(Z(138)-Z(22)*U3
     &-Z(22)*U8-Z(22)*U9)+2*L6*Z(246)*(Z(137)-L10*U3-L10*U8)*(U3-U5-U6-U
     &7)+2*L2*L8*Z(26)*(U3-U6-U7)*(U3-U4-U5-U6-U7)+2*L8*Z(266)*(U3-U6-U7
     &)*(Z(138)-Z(22)*U3-Z(22)*U8-Z(22)*U9)+2*Z(15)*(Z(137)-L10*U3-L10*U
     &8)*(Z(138)-Z(22)*U3-Z(22)*U8-Z(22)*U9)+2*L2*L6*Z(3)*(U3-U5-U6-U7)*
     &(U3-U4-U5-U6-U7)+2*L6*Z(262)*(U3-U5-U6-U7)*(Z(138)-Z(22)*U3-Z(22)*
     &U8-Z(22)*U9)-U1**2-U2**2-2*L10*Z(53)*U1*(U3-U7)-2*L10*Z(54)*U2*(U3
     &-U7)-L10**2*(U3-U7)**2-2*L8*Z(34)*U1*(U3-U6-U7)-2*L8*Z(35)*U2*(U3-
     &U6-U7)-(Z(137)-L10*U3-L10*U8)**2-L8**2*(U3-U6-U7)**2-2*L6*Z(49)*U1
     &*(U3-U5-U6-U7)-2*L6*Z(50)*U2*(U3-U5-U6-U7)-L6**2*(U3-U5-U6-U7)**2-
     &(Z(138)-Z(22)*U3-Z(22)*U8-Z(22)*U9)**2-2*L10*L8*Z(9)*(U3-U7)*(U3-U
     &6-U7)-L2**2*(U3-U4-U5-U6-U7)**2-2*L10*L6*Z(238)*(U3-U7)*(U3-U5-U6-
     &U7)-2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-2*L2*Z(242)*(Z(137)-L10*
     &U3-L10*U8)*(U3-U4-U5-U6-U7)-2*L2*Z(258)*(U3-U4-U5-U6-U7)*(Z(138)-Z
     &(22)*U3-Z(22)*U8-Z(22)*U9)) - 0.125D0*MH*(8*Z(55)*U2*(Z(137)-L10*U
     &3-L10*U8)+8*Z(57)*U1*(Z(137)-L10*U3-L10*U8)+4*Z(68)*U1*(Z(146)+L3*
     &U10+L3*U3+L3*U8+L3*U9)+4*Z(69)*U2*(Z(146)+L3*U10+L3*U3+L3*U8+L3*U9
     &)+8*L2*Z(38)*U1*(U3-U4-U5-U6-U7)+8*L2*Z(39)*U2*(U3-U4-U5-U6-U7)+8*
     &Z(60)*U1*(Z(139)-L8*U3-L8*U8-L8*U9)+8*Z(61)*U2*(Z(139)-L8*U3-L8*U8
     &-L8*U9)+8*L10*Z(254)*(U3-U7)*(Z(137)-L10*U3-L10*U8)+4*L10*Z(302)*(
     &U3-U7)*(Z(146)+L3*U10+L3*U3+L3*U8+L3*U9)+8*L8*Z(250)*(U3-U6-U7)*(Z
     &(137)-L10*U3-L10*U8)+8*L10*L2*Z(234)*(U3-U7)*(U3-U4-U5-U6-U7)+8*L1
     &0*Z(270)*(U3-U7)*(Z(139)-L8*U3-L8*U8-L8*U9)+4*L8*Z(294)*(U3-U6-U7)
     &*(Z(146)+L3*U10+L3*U3+L3*U8+L3*U9)+8*L6*Z(246)*(Z(137)-L10*U3-L10*
     &U8)*(U3-U5-U6-U7)+8*L2*L8*Z(26)*(U3-U6-U7)*(U3-U4-U5-U6-U7)+8*L8*Z
     &(266)*(U3-U6-U7)*(Z(139)-L8*U3-L8*U8-L8*U9)+8*Z(306)*(Z(137)-L10*U
     &3-L10*U8)*(Z(145)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)+4*L6*Z(286
     &)*(U3-U5-U6-U7)*(Z(146)+L3*U10+L3*U3+L3*U8+L3*U9)+8*Z(15)*(Z(137)-
     &L10*U3-L10*U8)*(Z(139)-L8*U3-L8*U8-L8*U9)+4*Z(7)*(Z(145)+Z(24)*U10
     &+Z(24)*U3+Z(24)*U8+Z(24)*U9)*(Z(146)+L3*U10+L3*U3+L3*U8+L3*U9)+8*L
     &2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)+8*L6*Z(262)*(U3-U5-U6-U7)
     &*(Z(139)-L8*U3-L8*U8-L8*U9)+8*L2*Z(274)*(Z(145)+Z(24)*U10+Z(24)*U3
     &+Z(24)*U8+Z(24)*U9)*(U3-U4-U5-U6-U7)-4*U1**2-4*U2**2-8*L10*Z(53)*U
     &1*(U3-U7)-8*L10*Z(54)*U2*(U3-U7)-4*L10**2*(U3-U7)**2-8*L8*Z(34)*U1
     &*(U3-U6-U7)-8*L8*Z(35)*U2*(U3-U6-U7)-4*(Z(137)-L10*U3-L10*U8)**2-4
     &*L8**2*(U3-U6-U7)**2-8*L6*Z(49)*U1*(U3-U5-U6-U7)-8*L6*Z(50)*U2*(U3
     &-U5-U6-U7)-4*(Z(145)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)**2-4*L6
     &**2*(U3-U5-U6-U7)**2-(Z(146)+L3*U10+L3*U3+L3*U8+L3*U9)**2-8*Z(64)*
     &U1*(Z(145)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)-8*Z(65)*U2*(Z(145
     &)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)-4*(Z(139)-L8*U3-L8*U8-L8*U
     &9)**2-8*L10*L8*Z(9)*(U3-U7)*(U3-U6-U7)-4*L2**2*(U3-U4-U5-U6-U7)**2
     &-8*L10*L6*Z(238)*(U3-U7)*(U3-U5-U6-U7)-8*L10*Z(298)*(U3-U7)*(Z(145
     &)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)-8*L6*L8*Z(5)*(U3-U6-U7)*(U
     &3-U5-U6-U7)-8*L8*Z(290)*(U3-U6-U7)*(Z(145)+Z(24)*U10+Z(24)*U3+Z(24
     &)*U8+Z(24)*U9)-4*Z(310)*(Z(137)-L10*U3-L10*U8)*(Z(146)+L3*U10+L3*U
     &3+L3*U8+L3*U9)-8*L2*Z(242)*(Z(137)-L10*U3-L10*U8)*(U3-U4-U5-U6-U7)
     &-8*L6*Z(282)*(U3-U5-U6-U7)*(Z(145)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(2
     &4)*U9)-8*Z(17)*(Z(145)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)*(Z(13
     &9)-L8*U3-L8*U8-L8*U9)-4*L2*Z(278)*(Z(146)+L3*U10+L3*U3+L3*U8+L3*U9
     &)*(U3-U4-U5-U6-U7)-4*Z(314)*(Z(146)+L3*U10+L3*U3+L3*U8+L3*U9)*(Z(1
     &39)-L8*U3-L8*U8-L8*U9)-8*L2*Z(258)*(U3-U4-U5-U6-U7)*(Z(139)-L8*U3-
     &L8*U8-L8*U9))
      Z(81) = MG*GS/Z(74)
      POCMY = Q2 + Z(77)*Z(33) + Z(78)*Z(52) + Z(79)*Z(56) + Z(80)*Z(59)
     & + Z(82)*Z(63) + Z(83)*Z(71) + Z(81)*Z(2) + 0.5D0*Z(76)*Z(48) + 0.
     &5D0*Z(85)*Z(44) - Z(75)*Z(37) - 0.5D0*Z(84)*Z(67)
      PECM = 0.5D0*K1*Q1**2 + 0.5D0*K3*Q2**2 - G*MT*POCMY
      TE = KECM + PECM
      Z(340) = FAp - EAp
      Z(341) = INF*Z(340)
      Z(342) = FAp - EAp - HAp
      Z(343) = INH*Z(342)
      Z(344) = FAp - EAp - HAp - IAp
      Z(345) = INI*Z(344)
      Z(395) = MA*(Z(84)*Z(66)+2*Z(346)*Z(36)-2*Z(77)*Z(32)-2*Z(78)*Z(51
     &)-2*Z(79)*Z(55)-2*Z(80)*Z(58)-2*Z(82)*Z(62)-2*Z(83)*Z(70)-2*Z(81)*
     &Z(1)-Z(76)*Z(47)-Z(85)*Z(43))
      Z(401) = MB*(Z(84)*Z(66)+2*Z(347)*Z(36)+2*Z(348)*Z(47)+2*Z(349)*Z(
     &43)-2*Z(77)*Z(32)-2*Z(78)*Z(51)-2*Z(79)*Z(55)-2*Z(80)*Z(58)-2*Z(82
     &)*Z(62)-2*Z(83)*Z(70)-2*Z(81)*Z(1))
      Z(409) = MC*(Z(84)*Z(66)+2*Z(347)*Z(36)+2*Z(377)*Z(47)+2*Z(378)*Z(
     &32)-2*Z(78)*Z(51)-2*Z(79)*Z(55)-2*Z(80)*Z(58)-2*Z(82)*Z(62)-2*Z(83
     &)*Z(70)-2*Z(81)*Z(1)-Z(85)*Z(43))
      Z(415) = MD*(Z(84)*Z(66)+2*Z(347)*Z(36)+2*Z(377)*Z(47)+2*Z(379)*Z(
     &32)+2*Z(380)*Z(51)-2*Z(79)*Z(55)-2*Z(80)*Z(58)-2*Z(82)*Z(62)-2*Z(8
     &3)*Z(70)-2*Z(81)*Z(1)-Z(85)*Z(43))
      Z(422) = ME*(Z(84)*Z(66)+2*Z(347)*Z(36)+2*Z(377)*Z(47)+2*Z(379)*Z(
     &32)+2*Z(381)*Z(51)+2*Z(382)*Z(55)-2*Z(80)*Z(58)-2*Z(82)*Z(62)-2*Z(
     &83)*Z(70)-2*Z(81)*Z(1)-Z(85)*Z(43))
      Z(430) = MF*(Z(84)*Z(66)+2*Z(347)*Z(36)+2*Z(377)*Z(47)+2*Z(379)*Z(
     &32)+2*Z(381)*Z(51)+2*Z(383)*Z(55)+2*Z(384)*Z(58)-2*Z(82)*Z(62)-2*Z
     &(83)*Z(70)-2*Z(81)*Z(1)-Z(85)*Z(43))
      Z(385) = GS - Z(81)
      Z(438) = MG*(Z(85)*Z(44)+2*Z(79)*Z(56)+2*Z(80)*Z(59)+2*Z(82)*Z(63)
     &+2*Z(83)*Z(71)-2*Z(347)*Z(37)-2*Z(377)*Z(48)-2*Z(379)*Z(33)-2*Z(38
     &1)*Z(52)-2*Z(385)*Z(2)-Z(84)*Z(67))
      Z(447) = MH*(2*Z(347)*Z(36)+2*Z(377)*Z(47)+2*Z(379)*Z(32)+2*Z(381)
     &*Z(51)+2*Z(383)*Z(55)+2*Z(386)*Z(58)+2*Z(387)*Z(62)+2*Z(388)*Z(66)
     &-2*Z(83)*Z(70)-2*Z(81)*Z(1)-Z(85)*Z(43))
      Z(461) = MI*(Z(84)*Z(66)+2*Z(347)*Z(36)+2*Z(377)*Z(47)+2*Z(379)*Z(
     &32)+2*Z(381)*Z(51)+2*Z(383)*Z(55)+2*Z(386)*Z(58)+2*Z(392)*Z(62)+2*
     &Z(393)*Z(70)-2*Z(81)*Z(1)-Z(85)*Z(43))
      Z(235) = Z(3)*Z(231) + Z(4)*Z(233)
      Z(108) = Z(1)*Z(47) + Z(2)*Z(48)
      Z(399) = MB*(Z(398)+Z(84)*Z(283)+2*Z(347)*Z(3)-2*Z(77)*Z(5)-2*Z(78
     &)*Z(235)-2*Z(79)*Z(243)-2*Z(80)*Z(259)-2*Z(82)*Z(279)-2*Z(83)*Z(31
     &9)-2*Z(81)*Z(108))
      Z(132) = Z(1)*Z(43) + Z(2)*Z(44)
      Z(134) = Z(1)*Z(44) - Z(2)*Z(43)
      Z(357) = Z(13)*Z(132) - Z(14)*Z(134)
      Z(359) = Z(13)*Z(134) + Z(14)*Z(132)
      Z(363) = Z(16)*Z(357) - Z(15)*Z(359)
      Z(361) = -Z(15)*Z(357) - Z(16)*Z(359)
      Z(365) = Z(18)*Z(363) - Z(17)*Z(361)
      Z(367) = -Z(17)*Z(363) - Z(18)*Z(361)
      Z(373) = Z(7)*Z(365) - Z(8)*Z(367)
      Z(350) = Z(7)*Z(5) + Z(8)*Z(6)
      Z(352) = Z(8)*Z(5) - Z(7)*Z(6)
      Z(353) = Z(9)*Z(350) + Z(10)*Z(352)
      Z(369) = Z(20)*Z(367) - Z(19)*Z(365)
      Z(403) = MB*(Z(402)+Z(84)*Z(373)+2*Z(347)*Z(40)-2*Z(77)*Z(350)-2*Z
     &(78)*Z(353)-2*Z(79)*Z(357)-2*Z(80)*Z(361)-2*Z(82)*Z(365)-2*Z(83)*Z
     &(369)-2*Z(81)*Z(132))
      Z(406) = MC*(2*Z(377)+Z(84)*Z(283)+2*Z(347)*Z(3)+2*Z(378)*Z(5)-Z(4
     &05)-2*Z(78)*Z(235)-2*Z(79)*Z(243)-2*Z(80)*Z(259)-2*Z(82)*Z(279)-2*
     &Z(83)*Z(319)-2*Z(81)*Z(108))
      Z(407) = MC*(2*Z(378)+Z(84)*Z(291)+2*Z(347)*Z(26)+2*Z(377)*Z(5)-2*
     &Z(78)*Z(9)-2*Z(79)*Z(247)-2*Z(80)*Z(263)-2*Z(82)*Z(287)-2*Z(83)*Z(
     &323)-2*Z(81)*Z(29)-Z(85)*Z(350))
      Z(411) = MD*(2*Z(377)+Z(84)*Z(283)+2*Z(347)*Z(3)+2*Z(379)*Z(5)+2*Z
     &(380)*Z(235)-Z(405)-2*Z(79)*Z(243)-2*Z(80)*Z(259)-2*Z(82)*Z(279)-2
     &*Z(83)*Z(319)-2*Z(81)*Z(108))
      Z(412) = MD*(2*Z(379)+Z(84)*Z(291)+2*Z(347)*Z(26)+2*Z(377)*Z(5)+2*
     &Z(380)*Z(9)-2*Z(79)*Z(247)-2*Z(80)*Z(263)-2*Z(82)*Z(287)-2*Z(83)*Z
     &(323)-2*Z(81)*Z(29)-Z(85)*Z(350))
      Z(299) = Z(9)*Z(291) + Z(10)*Z(293)
      Z(251) = Z(9)*Z(247) + Z(10)*Z(249)
      Z(267) = Z(9)*Z(263) + Z(10)*Z(265)
      Z(295) = Z(9)*Z(287) + Z(10)*Z(289)
      Z(327) = Z(9)*Z(323) + Z(10)*Z(325)
      Z(413) = MD*(2*Z(380)+Z(84)*Z(299)+2*Z(347)*Z(231)+2*Z(377)*Z(235)
     &+2*Z(379)*Z(9)-2*Z(79)*Z(251)-2*Z(80)*Z(267)-2*Z(82)*Z(295)-2*Z(83
     &)*Z(327)-2*Z(81)*Z(11)-Z(85)*Z(353))
      Z(417) = ME*(2*Z(377)+Z(84)*Z(283)+2*Z(347)*Z(3)+2*Z(379)*Z(5)+2*Z
     &(381)*Z(235)+2*Z(382)*Z(243)-Z(405)-2*Z(80)*Z(259)-2*Z(82)*Z(279)-
     &2*Z(83)*Z(319)-2*Z(81)*Z(108))
      Z(418) = ME*(2*Z(379)+Z(84)*Z(291)+2*Z(347)*Z(26)+2*Z(377)*Z(5)+2*
     &Z(381)*Z(9)+2*Z(382)*Z(247)-2*Z(80)*Z(263)-2*Z(82)*Z(287)-2*Z(83)*
     &Z(323)-2*Z(81)*Z(29)-Z(85)*Z(350))
      Z(419) = ME*(2*Z(381)+Z(84)*Z(299)+2*Z(347)*Z(231)+2*Z(377)*Z(235)
     &+2*Z(379)*Z(9)+2*Z(382)*Z(251)-2*Z(80)*Z(267)-2*Z(82)*Z(295)-2*Z(8
     &3)*Z(327)-2*Z(81)*Z(11)-Z(85)*Z(353))
      Z(424) = MF*(2*Z(377)+Z(84)*Z(283)+2*Z(347)*Z(3)+2*Z(379)*Z(5)+2*Z
     &(381)*Z(235)+2*Z(383)*Z(243)+2*Z(384)*Z(259)-Z(405)-2*Z(82)*Z(279)
     &-2*Z(83)*Z(319)-2*Z(81)*Z(108))
      Z(425) = MF*(2*Z(379)+Z(84)*Z(291)+2*Z(347)*Z(26)+2*Z(377)*Z(5)+2*
     &Z(381)*Z(9)+2*Z(383)*Z(247)+2*Z(384)*Z(263)-2*Z(82)*Z(287)-2*Z(83)
     &*Z(323)-2*Z(81)*Z(29)-Z(85)*Z(350))
      Z(426) = MF*(2*Z(381)+Z(84)*Z(299)+2*Z(347)*Z(231)+2*Z(377)*Z(235)
     &+2*Z(379)*Z(9)+2*Z(383)*Z(251)+2*Z(384)*Z(267)-2*Z(82)*Z(295)-2*Z(
     &83)*Z(327)-2*Z(81)*Z(11)-Z(85)*Z(353))
      Z(311) = -Z(15)*Z(307) - Z(16)*Z(309)
      Z(335) = -Z(15)*Z(331) - Z(16)*Z(333)
      Z(116) = Z(1)*Z(58) + Z(2)*Z(59)
      Z(428) = MF*(2*Z(384)+2*Z(82)*Z(17)+Z(84)*Z(311)+2*Z(347)*Z(255)+2
     &*Z(377)*Z(259)+2*Z(379)*Z(263)+2*Z(381)*Z(267)-2*Z(383)*Z(15)-2*Z(
     &83)*Z(335)-2*Z(81)*Z(116)-Z(85)*Z(361))
      Z(103) = Z(1)*Z(36) + Z(2)*Z(37)
      Z(431) = MG*(Z(85)*Z(40)+2*Z(79)*Z(239)+2*Z(80)*Z(255)+2*Z(82)*Z(2
     &71)+2*Z(83)*Z(315)-2*Z(347)-2*Z(377)*Z(3)-2*Z(379)*Z(26)-2*Z(381)*
     &Z(231)-2*Z(385)*Z(103)-Z(84)*Z(275))
      Z(440) = MH*(2*Z(377)+2*Z(347)*Z(3)+2*Z(379)*Z(5)+2*Z(381)*Z(235)+
     &2*Z(383)*Z(243)+2*Z(386)*Z(259)+2*Z(387)*Z(279)+2*Z(388)*Z(283)-Z(
     &405)-2*Z(83)*Z(319)-2*Z(81)*Z(108))
      Z(441) = MH*(2*Z(379)+2*Z(347)*Z(26)+2*Z(377)*Z(5)+2*Z(381)*Z(9)+2
     &*Z(383)*Z(247)+2*Z(386)*Z(263)+2*Z(387)*Z(287)+2*Z(388)*Z(291)-2*Z
     &(83)*Z(323)-2*Z(81)*Z(29)-Z(85)*Z(350))
      Z(442) = MH*(2*Z(381)+2*Z(347)*Z(231)+2*Z(377)*Z(235)+2*Z(379)*Z(9
     &)+2*Z(383)*Z(251)+2*Z(386)*Z(267)+2*Z(387)*Z(295)+2*Z(388)*Z(299)-
     &2*Z(83)*Z(327)-2*Z(81)*Z(11)-Z(85)*Z(353))
      Z(444) = MH*(2*Z(386)+2*Z(347)*Z(255)+2*Z(377)*Z(259)+2*Z(379)*Z(2
     &63)+2*Z(381)*Z(267)+2*Z(388)*Z(311)-2*Z(383)*Z(15)-2*Z(387)*Z(17)-
     &2*Z(83)*Z(335)-2*Z(81)*Z(116)-Z(85)*Z(361))
      Z(303) = Z(13)*Z(122) - Z(14)*Z(124)
      Z(446) = MH*(Z(445)+2*Z(83)*Z(19)+2*Z(347)*Z(271)+2*Z(377)*Z(279)+
     &2*Z(379)*Z(287)+2*Z(381)*Z(295)+2*Z(383)*Z(303)-2*Z(386)*Z(17)-2*Z
     &(81)*Z(122)-Z(85)*Z(365))
      Z(389) = -Z(7)*Z(19) - Z(8)*Z(20)
      Z(450) = MH*(Z(449)+2*Z(347)*Z(275)+2*Z(377)*Z(283)+2*Z(379)*Z(291
     &)+2*Z(381)*Z(299)+2*Z(383)*Z(307)+2*Z(386)*Z(311)-2*Z(83)*Z(389)-2
     &*Z(81)*Z(141)-Z(85)*Z(373))
      Z(452) = MI*(2*Z(377)+Z(84)*Z(283)+2*Z(347)*Z(3)+2*Z(379)*Z(5)+2*Z
     &(381)*Z(235)+2*Z(383)*Z(243)+2*Z(386)*Z(259)+2*Z(392)*Z(279)+2*Z(3
     &93)*Z(319)-Z(405)-2*Z(81)*Z(108))
      Z(453) = MI*(2*Z(379)+Z(84)*Z(291)+2*Z(347)*Z(26)+2*Z(377)*Z(5)+2*
     &Z(381)*Z(9)+2*Z(383)*Z(247)+2*Z(386)*Z(263)+2*Z(392)*Z(287)+2*Z(39
     &3)*Z(323)-2*Z(81)*Z(29)-Z(85)*Z(350))
      Z(454) = MI*(2*Z(381)+Z(84)*Z(299)+2*Z(347)*Z(231)+2*Z(377)*Z(235)
     &+2*Z(379)*Z(9)+2*Z(383)*Z(251)+2*Z(386)*Z(267)+2*Z(392)*Z(295)+2*Z
     &(393)*Z(327)-2*Z(81)*Z(11)-Z(85)*Z(353))
      Z(456) = MI*(2*Z(386)+Z(84)*Z(311)+2*Z(347)*Z(255)+2*Z(377)*Z(259)
     &+2*Z(379)*Z(263)+2*Z(381)*Z(267)+2*Z(393)*Z(335)-2*Z(383)*Z(15)-2*
     &Z(392)*Z(17)-2*Z(81)*Z(116)-Z(85)*Z(361))
      Z(458) = MI*(Z(457)+2*Z(347)*Z(271)+2*Z(377)*Z(279)+2*Z(379)*Z(287
     &)+2*Z(381)*Z(295)+2*Z(383)*Z(303)-2*Z(386)*Z(17)-2*Z(393)*Z(19)-2*
     &Z(81)*Z(122)-Z(85)*Z(365))
      Z(459) = MI*(2*Z(393)+Z(84)*Z(389)+2*Z(347)*Z(315)+2*Z(377)*Z(319)
     &+2*Z(379)*Z(323)+2*Z(381)*Z(327)+2*Z(383)*Z(331)+2*Z(386)*Z(335)-2
     &*Z(392)*Z(19)-2*Z(81)*Z(128)-Z(85)*Z(369))
      Z(339) = INE*EAp
      Z(118) = Z(1)*Z(59) - Z(2)*Z(58)
      Z(436) = MG*GSp*(2*Z(79)*Z(14)+Z(84)*Z(143)+2*Z(347)*Z(105)+2*Z(37
     &7)*Z(110)+2*Z(379)*Z(30)-2*Z(80)*Z(118)-2*Z(82)*Z(124)-2*Z(83)*Z(1
     &30)-2*Z(381)*Z(12)-Z(85)*Z(134))
      Z(396) = MA*(Z(84)*Z(67)+2*Z(346)*Z(37)-2*Z(77)*Z(33)-2*Z(78)*Z(52
     &)-2*Z(79)*Z(56)-2*Z(80)*Z(59)-2*Z(82)*Z(63)-2*Z(83)*Z(71)-2*Z(81)*
     &Z(2)-Z(76)*Z(48)-Z(85)*Z(44))
      Z(400) = MB*(Z(84)*Z(67)+2*Z(347)*Z(37)+2*Z(348)*Z(48)+2*Z(349)*Z(
     &44)-2*Z(77)*Z(33)-2*Z(78)*Z(52)-2*Z(79)*Z(56)-2*Z(80)*Z(59)-2*Z(82
     &)*Z(63)-2*Z(83)*Z(71)-2*Z(81)*Z(2))
      Z(408) = MC*(Z(84)*Z(67)+2*Z(347)*Z(37)+2*Z(377)*Z(48)+2*Z(378)*Z(
     &33)-2*Z(78)*Z(52)-2*Z(79)*Z(56)-2*Z(80)*Z(59)-2*Z(82)*Z(63)-2*Z(83
     &)*Z(71)-2*Z(81)*Z(2)-Z(85)*Z(44))
      Z(414) = MD*(Z(84)*Z(67)+2*Z(347)*Z(37)+2*Z(377)*Z(48)+2*Z(379)*Z(
     &33)+2*Z(380)*Z(52)-2*Z(79)*Z(56)-2*Z(80)*Z(59)-2*Z(82)*Z(63)-2*Z(8
     &3)*Z(71)-2*Z(81)*Z(2)-Z(85)*Z(44))
      Z(421) = ME*(Z(84)*Z(67)+2*Z(347)*Z(37)+2*Z(377)*Z(48)+2*Z(379)*Z(
     &33)+2*Z(381)*Z(52)+2*Z(382)*Z(56)-2*Z(80)*Z(59)-2*Z(82)*Z(63)-2*Z(
     &83)*Z(71)-2*Z(81)*Z(2)-Z(85)*Z(44))
      Z(429) = MF*(Z(84)*Z(67)+2*Z(347)*Z(37)+2*Z(377)*Z(48)+2*Z(379)*Z(
     &33)+2*Z(381)*Z(52)+2*Z(383)*Z(56)+2*Z(384)*Z(59)-2*Z(82)*Z(63)-2*Z
     &(83)*Z(71)-2*Z(81)*Z(2)-Z(85)*Z(44))
      Z(437) = MG*(Z(85)*Z(43)+2*Z(79)*Z(55)+2*Z(80)*Z(58)+2*Z(82)*Z(62)
     &+2*Z(83)*Z(70)-2*Z(347)*Z(36)-2*Z(377)*Z(47)-2*Z(379)*Z(32)-2*Z(38
     &1)*Z(51)-2*Z(385)*Z(1)-Z(84)*Z(66))
      Z(448) = MH*(2*Z(347)*Z(37)+2*Z(377)*Z(48)+2*Z(379)*Z(33)+2*Z(381)
     &*Z(52)+2*Z(383)*Z(56)+2*Z(386)*Z(59)+2*Z(387)*Z(63)+2*Z(388)*Z(67)
     &-2*Z(83)*Z(71)-2*Z(81)*Z(2)-Z(85)*Z(44))
      Z(460) = MI*(Z(84)*Z(67)+2*Z(347)*Z(37)+2*Z(377)*Z(48)+2*Z(379)*Z(
     &33)+2*Z(381)*Z(52)+2*Z(383)*Z(56)+2*Z(386)*Z(59)+2*Z(392)*Z(63)+2*
     &Z(393)*Z(71)-2*Z(81)*Z(2)-Z(85)*Z(44))
      Z(394) = MA*(2*Z(346)+Z(84)*Z(275)-2*Z(77)*Z(26)-2*Z(78)*Z(231)-2*
     &Z(79)*Z(239)-2*Z(80)*Z(255)-2*Z(82)*Z(271)-2*Z(83)*Z(315)-2*Z(81)*
     &Z(103)-Z(76)*Z(3)-Z(85)*Z(40))
      Z(397) = MB*(2*Z(347)+Z(84)*Z(275)+2*Z(348)*Z(3)+2*Z(349)*Z(40)-2*
     &Z(77)*Z(26)-2*Z(78)*Z(231)-2*Z(79)*Z(239)-2*Z(80)*Z(255)-2*Z(82)*Z
     &(271)-2*Z(83)*Z(315)-2*Z(81)*Z(103))
      Z(404) = MC*(2*Z(347)+Z(84)*Z(275)+2*Z(377)*Z(3)+2*Z(378)*Z(26)-2*
     &Z(78)*Z(231)-2*Z(79)*Z(239)-2*Z(80)*Z(255)-2*Z(82)*Z(271)-2*Z(83)*
     &Z(315)-2*Z(81)*Z(103)-Z(85)*Z(40))
      Z(410) = MD*(2*Z(347)+Z(84)*Z(275)+2*Z(377)*Z(3)+2*Z(379)*Z(26)+2*
     &Z(380)*Z(231)-2*Z(79)*Z(239)-2*Z(80)*Z(255)-2*Z(82)*Z(271)-2*Z(83)
     &*Z(315)-2*Z(81)*Z(103)-Z(85)*Z(40))
      Z(416) = ME*(2*Z(347)+Z(84)*Z(275)+2*Z(377)*Z(3)+2*Z(379)*Z(26)+2*
     &Z(381)*Z(231)+2*Z(382)*Z(239)-2*Z(80)*Z(255)-2*Z(82)*Z(271)-2*Z(83
     &)*Z(315)-2*Z(81)*Z(103)-Z(85)*Z(40))
      Z(420) = ME*(2*Z(13)*Z(81)+Z(85)*Z(357)+2*Z(82)*Z(303)+2*Z(83)*Z(3
     &31)-2*Z(382)-2*Z(80)*Z(15)-2*Z(347)*Z(239)-2*Z(377)*Z(243)-2*Z(379
     &)*Z(247)-2*Z(381)*Z(251)-Z(84)*Z(307))
      Z(423) = MF*(2*Z(347)+Z(84)*Z(275)+2*Z(377)*Z(3)+2*Z(379)*Z(26)+2*
     &Z(381)*Z(231)+2*Z(383)*Z(239)+2*Z(384)*Z(255)-2*Z(82)*Z(271)-2*Z(8
     &3)*Z(315)-2*Z(81)*Z(103)-Z(85)*Z(40))
      Z(427) = MF*(2*Z(384)*Z(15)+2*Z(13)*Z(81)+Z(85)*Z(357)+2*Z(82)*Z(3
     &03)+2*Z(83)*Z(331)-2*Z(383)-2*Z(347)*Z(239)-2*Z(377)*Z(243)-2*Z(37
     &9)*Z(247)-2*Z(381)*Z(251)-Z(84)*Z(307))
      Z(432) = MG*(Z(405)+2*Z(79)*Z(243)+2*Z(80)*Z(259)+2*Z(82)*Z(279)+2
     &*Z(83)*Z(319)-2*Z(377)-2*Z(347)*Z(3)-2*Z(379)*Z(5)-2*Z(381)*Z(235)
     &-2*Z(385)*Z(108)-Z(84)*Z(283))
      Z(433) = MG*(Z(85)*Z(350)+2*Z(79)*Z(247)+2*Z(80)*Z(263)+2*Z(82)*Z(
     &287)+2*Z(83)*Z(323)-2*Z(379)-2*Z(347)*Z(26)-2*Z(377)*Z(5)-2*Z(381)
     &*Z(9)-2*Z(385)*Z(29)-Z(84)*Z(291))
      Z(434) = MG*(Z(85)*Z(353)+2*Z(79)*Z(251)+2*Z(80)*Z(267)+2*Z(82)*Z(
     &295)+2*Z(83)*Z(327)-2*Z(381)-2*Z(347)*Z(231)-2*Z(377)*Z(235)-2*Z(3
     &79)*Z(9)-2*Z(385)*Z(11)-Z(84)*Z(299))
      Z(435) = MG*(2*Z(79)*Z(13)+Z(85)*Z(132)+2*Z(80)*Z(116)+2*Z(82)*Z(1
     &22)+2*Z(83)*Z(128)-2*Z(385)-2*Z(347)*Z(103)-2*Z(377)*Z(108)-2*Z(37
     &9)*Z(29)-2*Z(381)*Z(11)-Z(84)*Z(141))
      Z(439) = MH*(2*Z(347)+2*Z(377)*Z(3)+2*Z(379)*Z(26)+2*Z(381)*Z(231)
     &+2*Z(383)*Z(239)+2*Z(386)*Z(255)+2*Z(387)*Z(271)+2*Z(388)*Z(275)-2
     &*Z(83)*Z(315)-2*Z(81)*Z(103)-Z(85)*Z(40))
      Z(443) = MH*(2*Z(386)*Z(15)+2*Z(13)*Z(81)+Z(85)*Z(357)+2*Z(83)*Z(3
     &31)-2*Z(383)-2*Z(347)*Z(239)-2*Z(377)*Z(243)-2*Z(379)*Z(247)-2*Z(3
     &81)*Z(251)-2*Z(387)*Z(303)-2*Z(388)*Z(307))
      Z(451) = MI*(2*Z(347)+Z(84)*Z(275)+2*Z(377)*Z(3)+2*Z(379)*Z(26)+2*
     &Z(381)*Z(231)+2*Z(383)*Z(239)+2*Z(386)*Z(255)+2*Z(392)*Z(271)+2*Z(
     &393)*Z(315)-2*Z(81)*Z(103)-Z(85)*Z(40))
      Z(455) = MI*(2*Z(386)*Z(15)+2*Z(13)*Z(81)+Z(85)*Z(357)-2*Z(383)-2*
     &Z(347)*Z(239)-2*Z(377)*Z(243)-2*Z(379)*Z(247)-2*Z(381)*Z(251)-2*Z(
     &392)*Z(303)-2*Z(393)*Z(331)-Z(84)*Z(307))
      HZ = Z(341) + Z(343) + Z(345) + INA*U3 + INB*U3 + INC*U3 + IND*U3 
     &+ INE*U3 + INE*U8 + INF*U3 + INF*U8 + INF*U9 + ING*U3 + INH*U10 + 
     &INH*U3 + INH*U8 + INH*U9 + INI*U10 + INI*U11 + INI*U3 + INI*U8 + I
     &NI*U9 + 0.5D0*Z(395)*U2 + 0.5D0*Z(401)*U2 + 0.5D0*Z(409)*U2 + 0.5D
     &0*Z(415)*U2 + 0.5D0*Z(422)*U2 + 0.5D0*Z(430)*U2 + 0.5D0*Z(438)*U1 
     &+ 0.5D0*Z(447)*U2 + 0.5D0*Z(461)*U2 + 0.25D0*Z(399)*Z(165) + 0.25D
     &0*Z(403)*Z(166) + 0.5D0*Z(406)*Z(171) + 0.5D0*Z(407)*Z(173) + 0.5D
     &0*Z(411)*Z(171) + 0.5D0*Z(412)*Z(175) + 0.5D0*Z(413)*Z(177) + 0.5D
     &0*Z(417)*Z(171) + 0.5D0*Z(418)*Z(175) + 0.5D0*Z(419)*Z(179) + 0.5D
     &0*Z(424)*Z(171) + 0.5D0*Z(425)*Z(175) + 0.5D0*Z(426)*Z(179) + 0.5D
     &0*Z(428)*Z(187) + 0.5D0*Z(431)*Z(163) + 0.5D0*Z(440)*Z(171) + 0.5D
     &0*Z(441)*Z(175) + 0.5D0*Z(442)*Z(179) + 0.5D0*Z(444)*Z(191) + 0.5D
     &0*Z(446)*Z(202) + 0.5D0*Z(450)*Z(203) + 0.5D0*Z(452)*Z(171) + 0.5D
     &0*Z(453)*Z(175) + 0.5D0*Z(454)*Z(179) + 0.5D0*Z(456)*Z(191) + 0.5D
     &0*Z(458)*Z(198) + 0.5D0*Z(459)*Z(211) - Z(339) - 0.5D0*Z(436) - IN
     &D*U7 - 0.5D0*Z(396)*U1 - 0.5D0*Z(400)*U1 - 0.5D0*Z(408)*U1 - 0.5D0
     &*Z(414)*U1 - 0.5D0*Z(421)*U1 - 0.5D0*Z(429)*U1 - 0.5D0*Z(437)*U2 -
     & 0.5D0*Z(448)*U1 - 0.5D0*Z(460)*U1 - INC*(U6+U7) - INB*(U5+U6+U7) 
     &- INA*(U4+U5+U6+U7) - 0.5D0*Z(394)*Z(161) - 0.5D0*Z(397)*Z(163) - 
     &0.5D0*Z(404)*Z(163) - 0.5D0*Z(410)*Z(163) - 0.5D0*Z(416)*Z(163) - 
     &0.5D0*Z(420)*Z(181) - 0.5D0*Z(423)*Z(163) - 0.5D0*Z(427)*Z(184) - 
     &0.5D0*Z(432)*Z(171) - 0.5D0*Z(433)*Z(175) - 0.5D0*Z(434)*Z(179) - 
     &0.5D0*Z(435)*Z(194) - 0.5D0*Z(439)*Z(163) - 0.5D0*Z(443)*Z(184) - 
     &0.5D0*Z(451)*Z(163) - 0.5D0*Z(455)*Z(184)
      Z(490) = MG*GSp
      Z(510) = MI*Z(148)
      Z(499) = MH*Z(145)
      Z(508) = MI*Z(140)
      Z(491) = MG*GS
      Z(501) = MH*Z(146)
      Z(478) = ME*Z(136)
      Z(483) = MF*Z(137)
      Z(496) = MH*Z(137)
      Z(506) = MI*Z(137)
      Z(485) = MF*Z(138)
      Z(497) = MH*Z(139)
      Z(507) = MI*Z(139)
      PX = Z(490)*Z(1) + (MA+MB+MC+MD+ME+MF+MG+MH+MI)*U1 + 0.5D0*Z(465)*
     &Z(45)*(U3-U5-U6-U7) + (Z(472)+Z(476)+Z(482)+Z(489)+Z(495)+Z(505))*
     &Z(53)*(U3-U7) + Z(72)*(Z(510)+Z(509)*U10+Z(509)*U11+Z(509)*U3+Z(50
     &9)*U8+Z(509)*U9) + (Z(468)+Z(471)+Z(475)+Z(481)+Z(488)+Z(494)+Z(50
     &4))*Z(34)*(U3-U6-U7) + Z(64)*(Z(499)+Z(508)+Z(498)*U10+Z(498)*U3+Z
     &(498)*U8+Z(498)*U9+Z(503)*U10+Z(503)*U3+Z(503)*U8+Z(503)*U9) + 0.5
     &D0*(Z(464)+2*Z(467)+2*Z(470)+2*Z(474)+2*Z(480)+2*Z(487)+2*Z(493)+2
     &*Z(503))*Z(49)*(U3-U5-U6-U7) - Z(491)*Z(2)*U3 - 0.5D0*Z(68)*(Z(501
     &)+Z(500)*U10+Z(500)*U3+Z(500)*U8+Z(500)*U9) - (Z(462)+Z(463)+Z(466
     &)+Z(469)+Z(473)+Z(479)+Z(486)+Z(492)+Z(502))*Z(38)*(U3-U4-U5-U6-U7
     &) - Z(57)*(Z(478)+Z(483)+Z(496)+Z(506)-Z(477)*U3-Z(477)*U8-Z(482)*
     &U3-Z(482)*U8-Z(495)*U3-Z(495)*U8-Z(505)*U3-Z(505)*U8) - Z(60)*(Z(4
     &85)+Z(497)+Z(507)-Z(484)*U3-Z(484)*U8-Z(484)*U9-Z(494)*U3-Z(494)*U
     &8-Z(494)*U9-Z(504)*U3-Z(504)*U8-Z(504)*U9)
      PY = Z(490)*Z(2) + Z(491)*Z(1)*U3 + (MA+MB+MC+MD+ME+MF+MG+MH+MI)*U
     &2 + 0.5D0*Z(465)*Z(46)*(U3-U5-U6-U7) + (Z(472)+Z(476)+Z(482)+Z(489
     &)+Z(495)+Z(505))*Z(54)*(U3-U7) + Z(73)*(Z(510)+Z(509)*U10+Z(509)*U
     &11+Z(509)*U3+Z(509)*U8+Z(509)*U9) + (Z(468)+Z(471)+Z(475)+Z(481)+Z
     &(488)+Z(494)+Z(504))*Z(35)*(U3-U6-U7) + Z(65)*(Z(499)+Z(508)+Z(498
     &)*U10+Z(498)*U3+Z(498)*U8+Z(498)*U9+Z(503)*U10+Z(503)*U3+Z(503)*U8
     &+Z(503)*U9) + 0.5D0*(Z(464)+2*Z(467)+2*Z(470)+2*Z(474)+2*Z(480)+2*
     &Z(487)+2*Z(493)+2*Z(503))*Z(50)*(U3-U5-U6-U7) - 0.5D0*Z(69)*(Z(501
     &)+Z(500)*U10+Z(500)*U3+Z(500)*U8+Z(500)*U9) - (Z(462)+Z(463)+Z(466
     &)+Z(469)+Z(473)+Z(479)+Z(486)+Z(492)+Z(502))*Z(39)*(U3-U4-U5-U6-U7
     &) - Z(55)*(Z(478)+Z(483)+Z(496)+Z(506)-Z(477)*U3-Z(477)*U8-Z(482)*
     &U3-Z(482)*U8-Z(495)*U3-Z(495)*U8-Z(505)*U3-Z(505)*U8) - Z(61)*(Z(4
     &85)+Z(497)+Z(507)-Z(484)*U3-Z(484)*U8-Z(484)*U9-Z(494)*U3-Z(494)*U
     &8-Z(494)*U9-Z(504)*U3-Z(504)*U8-Z(504)*U9)
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
      Z(529) = Z(528)*Z(55) + L10*VRX1*Z(57) + L10*VRY1*Z(55) + L6*VRX1*
     &Z(64) + L6*VRY1*Z(65) + L8*VRX1*Z(60) + L8*VRY1*Z(61) + Z(223)*(L1
     &0*Z(55)+Z(22)*Z(61)) + Z(226)*(L10*Z(55)+L6*Z(65)+L8*Z(61)+Z(25)*Z
     &(73)) + Z(227)*(L10*Z(55)+L2*Z(73)+L6*Z(65)+L8*Z(61)) - 0.5D0*Z(22
     &5)*(L3*Z(69)-2*L10*Z(55)-2*L8*Z(61)-2*Z(24)*Z(65))
      Z(650) = Z(546) + Z(548) + Z(550) + Z(477)*(Z(240)*Z(164)-Z(182)-Z
     &(244)*Z(172)-Z(248)*Z(176)-Z(252)*Z(180)) + MF*(L10*Z(15)*Z(188)+Z
     &(22)*Z(15)*Z(185)+L10*Z(16)*Z(190)+L10*Z(240)*Z(164)+Z(22)*Z(256)*
     &Z(164)-L10*Z(185)-Z(22)*Z(188)-L10*Z(244)*Z(172)-L10*Z(248)*Z(176)
     &-L10*Z(252)*Z(180)-Z(22)*Z(16)*Z(186)-Z(22)*Z(260)*Z(172)-Z(22)*Z(
     &264)*Z(176)-Z(22)*Z(268)*Z(180)) + MI*(L6*Z(199)+Z(25)*Z(212)+L10*
     &Z(15)*Z(192)+L6*Z(17)*Z(192)+L8*Z(15)*Z(185)+L10*Z(199)*Z(306)+L10
     &*Z(212)*Z(334)+L8*Z(212)*Z(338)+L10*Z(16)*Z(193)+L10*Z(240)*Z(164)
     &+L6*Z(18)*Z(193)+L6*Z(272)*Z(164)+L8*Z(256)*Z(164)+Z(25)*Z(20)*Z(2
     &01)+Z(25)*Z(316)*Z(164)-L10*Z(185)-L8*Z(192)-L6*Z(19)*Z(212)-L8*Z(
     &17)*Z(199)-Z(25)*Z(19)*Z(199)-L6*Z(185)*Z(306)-Z(25)*Z(185)*Z(334)
     &-Z(25)*Z(192)*Z(338)-L10*Z(244)*Z(172)-L10*Z(248)*Z(176)-L10*Z(252
     &)*Z(180)-L10*Z(305)*Z(201)-L10*Z(333)*Z(214)-L6*Z(20)*Z(214)-L6*Z(
     &280)*Z(172)-L6*Z(288)*Z(176)-L6*Z(296)*Z(180)-L6*Z(304)*Z(186)-L8*
     &Z(16)*Z(186)-L8*Z(18)*Z(201)-L8*Z(260)*Z(172)-L8*Z(264)*Z(176)-L8*
     &Z(268)*Z(180)-L8*Z(337)*Z(214)-Z(25)*Z(320)*Z(172)-Z(25)*Z(324)*Z(
     &176)-Z(25)*Z(328)*Z(180)-Z(25)*Z(332)*Z(186)-Z(25)*Z(336)*Z(193)) 
     &+ 0.25D0*MH*(L3*Z(205)+4*Z(24)*Z(204)+4*L10*Z(15)*Z(192)+4*L8*Z(15
     &)*Z(185)+4*Z(24)*Z(17)*Z(192)+2*L3*Z(185)*Z(310)+2*L3*Z(192)*Z(314
     &)+4*L10*Z(204)*Z(306)+2*Z(617)*Z(206)+4*Z(619)*Z(207)+2*L3*Z(284)*
     &Z(172)+2*L3*Z(292)*Z(176)+2*L3*Z(300)*Z(180)+2*L3*Z(308)*Z(186)+2*
     &L3*Z(312)*Z(193)+4*L10*Z(16)*Z(193)+4*L10*Z(240)*Z(164)+4*L8*Z(256
     &)*Z(164)+4*Z(24)*Z(18)*Z(193)+4*Z(24)*Z(272)*Z(164)-4*L10*Z(185)-4
     &*L8*Z(192)-2*Z(620)*Z(204)-2*Z(621)*Z(205)-4*L8*Z(17)*Z(204)-4*Z(2
     &4)*Z(185)*Z(306)-2*L10*Z(205)*Z(310)-2*L8*Z(205)*Z(314)-4*L10*Z(24
     &4)*Z(172)-4*L10*Z(248)*Z(176)-4*L10*Z(252)*Z(180)-4*L10*Z(305)*Z(2
     &06)-4*L10*Z(309)*Z(207)-4*L8*Z(16)*Z(186)-4*L8*Z(18)*Z(206)-4*L8*Z
     &(260)*Z(172)-4*L8*Z(264)*Z(176)-4*L8*Z(268)*Z(180)-4*L8*Z(313)*Z(2
     &07)-4*Z(24)*Z(280)*Z(172)-4*Z(24)*Z(288)*Z(176)-4*Z(24)*Z(296)*Z(1
     &80)-4*Z(24)*Z(304)*Z(186)-2*L3*Z(276)*Z(164)) - Z(544)
      Z(685) = Z(529) - Z(650)
      Z(643) = Z(642) - Z(477)*(L2*Z(242)-Z(21)-L10*Z(254)-L6*Z(246)-L8*
     &Z(250)) - MF*(2*Z(590)*Z(15)+Z(581)*Z(242)+Z(591)*Z(258)-Z(583)-Z(
     &592)-Z(583)*Z(254)-Z(585)*Z(246)-Z(586)*Z(250)-Z(590)*Z(270)-Z(593
     &)*Z(262)-Z(594)*Z(266)) - MI*(2*Z(578)*Z(17)+2*Z(586)*Z(15)+2*Z(59
     &5)*Z(19)+Z(568)*Z(274)+Z(574)*Z(258)+Z(581)*Z(242)+Z(596)*Z(318)-Z
     &(571)-Z(576)-Z(583)-Z(597)-2*Z(585)*Z(306)-2*Z(598)*Z(334)-2*Z(599
     &)*Z(338)-Z(571)*Z(282)-Z(576)*Z(266)-Z(578)*Z(262)-Z(578)*Z(290)-Z
     &(583)*Z(254)-Z(585)*Z(246)-Z(585)*Z(298)-Z(586)*Z(250)-Z(586)*Z(27
     &0)-Z(595)*Z(322)-Z(598)*Z(330)-Z(599)*Z(326)) - 0.25D0*MH*(4*Z(600
     &)+8*Z(586)*Z(15)+8*Z(601)*Z(17)+2*Z(602)*Z(302)+2*Z(603)*Z(286)+2*
     &Z(604)*Z(294)+4*Z(574)*Z(258)+4*Z(581)*Z(242)+4*Z(602)*Z(310)+4*Z(
     &604)*Z(314)+4*Z(605)*Z(274)-4*Z(576)-4*Z(583)-4*Z(607)-Z(606)-8*Z(
     &608)*Z(306)-4*Z(576)*Z(266)-4*Z(578)*Z(262)-4*Z(583)*Z(254)-4*Z(58
     &5)*Z(246)-4*Z(586)*Z(250)-4*Z(586)*Z(270)-4*Z(601)*Z(290)-4*Z(608)
     &*Z(298)-4*Z(609)*Z(282)-2*Z(566)*Z(278))
      Z(644) = Z(477)*Z(55) + MF*(L10*Z(55)+Z(22)*Z(61)) + MI*(L10*Z(55)
     &+L6*Z(65)+L8*Z(61)+Z(25)*Z(73)) - 0.5D0*MH*(L3*Z(69)-2*L10*Z(55)-2
     &*L8*Z(61)-2*Z(24)*Z(65))
      Z(645) = Z(477)*Z(57) + MF*(L10*Z(57)+Z(22)*Z(60)) + MI*(L10*Z(57)
     &+L6*Z(64)+L8*Z(60)+Z(25)*Z(72)) - 0.5D0*MH*(L3*Z(68)-2*L10*Z(57)-2
     &*L8*Z(60)-2*Z(24)*Z(64))
      Z(646) = Z(477)*(L2*Z(242)-L10*Z(254)-L6*Z(246)-L8*Z(250)) + MF*(Z
     &(581)*Z(242)+Z(591)*Z(258)-Z(583)*Z(254)-Z(585)*Z(246)-Z(586)*Z(25
     &0)-Z(590)*Z(270)-Z(593)*Z(262)-Z(594)*Z(266)) + MI*(Z(568)*Z(274)+
     &Z(574)*Z(258)+Z(581)*Z(242)+Z(596)*Z(318)-Z(571)*Z(282)-Z(576)*Z(2
     &66)-Z(578)*Z(262)-Z(578)*Z(290)-Z(583)*Z(254)-Z(585)*Z(246)-Z(585)
     &*Z(298)-Z(586)*Z(250)-Z(586)*Z(270)-Z(595)*Z(322)-Z(598)*Z(330)-Z(
     &599)*Z(326)) + 0.5D0*MH*(Z(602)*Z(302)+Z(603)*Z(286)+Z(604)*Z(294)
     &+2*Z(574)*Z(258)+2*Z(581)*Z(242)+2*Z(605)*Z(274)-2*Z(576)*Z(266)-2
     &*Z(578)*Z(262)-2*Z(583)*Z(254)-2*Z(585)*Z(246)-2*Z(586)*Z(250)-2*Z
     &(586)*Z(270)-2*Z(601)*Z(290)-2*Z(608)*Z(298)-2*Z(609)*Z(282)-Z(566
     &)*Z(278))
      Z(647) = Z(477)*(L2*Z(242)-L6*Z(246)-L8*Z(250)) + MF*(Z(581)*Z(242
     &)+Z(591)*Z(258)-Z(585)*Z(246)-Z(586)*Z(250)-Z(593)*Z(262)-Z(594)*Z
     &(266)) + MI*(Z(568)*Z(274)+Z(574)*Z(258)+Z(581)*Z(242)+Z(596)*Z(31
     &8)-Z(571)*Z(282)-Z(576)*Z(266)-Z(578)*Z(262)-Z(578)*Z(290)-Z(585)*
     &Z(246)-Z(586)*Z(250)-Z(595)*Z(322)-Z(599)*Z(326)) + 0.5D0*MH*(Z(60
     &3)*Z(286)+Z(604)*Z(294)+2*Z(574)*Z(258)+2*Z(581)*Z(242)+2*Z(605)*Z
     &(274)-2*Z(576)*Z(266)-2*Z(578)*Z(262)-2*Z(585)*Z(246)-2*Z(586)*Z(2
     &50)-2*Z(601)*Z(290)-2*Z(609)*Z(282)-Z(566)*Z(278))
      Z(648) = Z(477)*(L2*Z(242)-L6*Z(246)) + MF*(Z(581)*Z(242)+Z(591)*Z
     &(258)-Z(585)*Z(246)-Z(593)*Z(262)) + 0.5D0*MH*(Z(603)*Z(286)+2*Z(5
     &74)*Z(258)+2*Z(581)*Z(242)+2*Z(605)*Z(274)-2*Z(578)*Z(262)-2*Z(585
     &)*Z(246)-2*Z(609)*Z(282)-Z(566)*Z(278)) - MI*(Z(571)*Z(282)+Z(578)
     &*Z(262)+Z(585)*Z(246)+Z(595)*Z(322)-Z(568)*Z(274)-Z(574)*Z(258)-Z(
     &581)*Z(242)-Z(596)*Z(318))
      Z(649) = L2*(2*Z(477)*Z(242)+2*MF*(L10*Z(242)+Z(22)*Z(258))+2*MI*(
     &L10*Z(242)+L6*Z(274)+L8*Z(258)+Z(25)*Z(318))-MH*(L3*Z(278)-2*L10*Z
     &(242)-2*L8*Z(258)-2*Z(24)*Z(274)))
      SHTOR = Z(685) - Z(643)*U3p - Z(644)*U2p - Z(645)*U1p - Z(646)*U7p
     & - Z(647)*U6p - Z(648)*U5p - 0.5D0*Z(649)*U4p
      Z(652) = Z(651) - Z(484)*(L10*Z(15)+L2*Z(258)-Z(22)-L10*Z(270)-L6*
     &Z(262)-L8*Z(266)) - MI*(Z(586)*Z(15)+2*Z(578)*Z(17)+2*Z(595)*Z(19)
     &+Z(568)*Z(274)+Z(574)*Z(258)+Z(596)*Z(318)-Z(571)-Z(576)-Z(597)-2*
     &Z(599)*Z(338)-Z(571)*Z(282)-Z(576)*Z(266)-Z(578)*Z(262)-Z(578)*Z(2
     &90)-Z(585)*Z(298)-Z(585)*Z(306)-Z(586)*Z(270)-Z(595)*Z(322)-Z(598)
     &*Z(330)-Z(598)*Z(334)-Z(599)*Z(326)) - 0.25D0*MH*(4*Z(600)+4*Z(586
     &)*Z(15)+8*Z(601)*Z(17)+2*Z(602)*Z(302)+2*Z(602)*Z(310)+2*Z(603)*Z(
     &286)+2*Z(604)*Z(294)+4*Z(574)*Z(258)+4*Z(604)*Z(314)+4*Z(605)*Z(27
     &4)-4*Z(576)-4*Z(607)-Z(606)-4*Z(576)*Z(266)-4*Z(578)*Z(262)-4*Z(58
     &6)*Z(270)-4*Z(601)*Z(290)-4*Z(608)*Z(298)-4*Z(608)*Z(306)-4*Z(609)
     &*Z(282)-2*Z(566)*Z(278))
      Z(653) = Z(484)*Z(60) + MI*(L6*Z(64)+L8*Z(60)+Z(25)*Z(72)) - 0.5D0
     &*MH*(L3*Z(68)-2*L8*Z(60)-2*Z(24)*Z(64))
      Z(654) = Z(484)*Z(61) + MI*(L6*Z(65)+L8*Z(61)+Z(25)*Z(73)) - 0.5D0
     &*MH*(L3*Z(69)-2*L8*Z(61)-2*Z(24)*Z(65))
      Z(655) = Z(484)*(L2*Z(258)-L10*Z(270)-L6*Z(262)-L8*Z(266)) + MI*(Z
     &(568)*Z(274)+Z(574)*Z(258)+Z(596)*Z(318)-Z(571)*Z(282)-Z(576)*Z(26
     &6)-Z(578)*Z(262)-Z(578)*Z(290)-Z(585)*Z(298)-Z(586)*Z(270)-Z(595)*
     &Z(322)-Z(598)*Z(330)-Z(599)*Z(326)) + 0.5D0*MH*(Z(602)*Z(302)+Z(60
     &3)*Z(286)+Z(604)*Z(294)+2*Z(574)*Z(258)+2*Z(605)*Z(274)-2*Z(576)*Z
     &(266)-2*Z(578)*Z(262)-2*Z(586)*Z(270)-2*Z(601)*Z(290)-2*Z(608)*Z(2
     &98)-2*Z(609)*Z(282)-Z(566)*Z(278))
      Z(656) = Z(484)*(L2*Z(258)-L6*Z(262)-L8*Z(266)) + MI*(Z(568)*Z(274
     &)+Z(574)*Z(258)+Z(596)*Z(318)-Z(571)*Z(282)-Z(576)*Z(266)-Z(578)*Z
     &(262)-Z(578)*Z(290)-Z(595)*Z(322)-Z(599)*Z(326)) + 0.5D0*MH*(Z(603
     &)*Z(286)+Z(604)*Z(294)+2*Z(574)*Z(258)+2*Z(605)*Z(274)-2*Z(576)*Z(
     &266)-2*Z(578)*Z(262)-2*Z(601)*Z(290)-2*Z(609)*Z(282)-Z(566)*Z(278)
     &)
      Z(657) = Z(484)*(L2*Z(258)-L6*Z(262)) + 0.5D0*MH*(Z(603)*Z(286)+2*
     &Z(574)*Z(258)+2*Z(605)*Z(274)-2*Z(578)*Z(262)-2*Z(609)*Z(282)-Z(56
     &6)*Z(278)) - MI*(Z(571)*Z(282)+Z(578)*Z(262)+Z(595)*Z(322)-Z(568)*
     &Z(274)-Z(574)*Z(258)-Z(596)*Z(318))
      Z(658) = L2*(2*Z(484)*Z(258)+2*MI*(L6*Z(274)+L8*Z(258)+Z(25)*Z(318
     &))-MH*(L3*Z(278)-2*L8*Z(258)-2*Z(24)*Z(274)))
      Z(531) = Z(530)*Z(61) + L6*VRX1*Z(64) + L6*VRY1*Z(65) + L8*VRX1*Z(
     &60) + L8*VRY1*Z(61) + Z(226)*(L6*Z(65)+L8*Z(61)+Z(25)*Z(73)) + Z(2
     &27)*(L2*Z(73)+L6*Z(65)+L8*Z(61)) - 0.5D0*Z(225)*(L3*Z(69)-2*L8*Z(6
     &1)-2*Z(24)*Z(65))
      Z(659) = Z(546) + Z(548) + Z(550) + Z(484)*(Z(15)*Z(185)+Z(256)*Z(
     &164)-Z(188)-Z(16)*Z(186)-Z(260)*Z(172)-Z(264)*Z(176)-Z(268)*Z(180)
     &) + MI*(L6*Z(199)+Z(25)*Z(212)+L6*Z(17)*Z(192)+L8*Z(15)*Z(185)+L8*
     &Z(212)*Z(338)+L6*Z(18)*Z(193)+L6*Z(272)*Z(164)+L8*Z(256)*Z(164)+Z(
     &25)*Z(20)*Z(201)+Z(25)*Z(316)*Z(164)-L8*Z(192)-L6*Z(19)*Z(212)-L8*
     &Z(17)*Z(199)-Z(25)*Z(19)*Z(199)-L6*Z(185)*Z(306)-Z(25)*Z(185)*Z(33
     &4)-Z(25)*Z(192)*Z(338)-L6*Z(20)*Z(214)-L6*Z(280)*Z(172)-L6*Z(288)*
     &Z(176)-L6*Z(296)*Z(180)-L6*Z(304)*Z(186)-L8*Z(16)*Z(186)-L8*Z(18)*
     &Z(201)-L8*Z(260)*Z(172)-L8*Z(264)*Z(176)-L8*Z(268)*Z(180)-L8*Z(337
     &)*Z(214)-Z(25)*Z(320)*Z(172)-Z(25)*Z(324)*Z(176)-Z(25)*Z(328)*Z(18
     &0)-Z(25)*Z(332)*Z(186)-Z(25)*Z(336)*Z(193)) + 0.25D0*MH*(L3*Z(205)
     &+4*Z(24)*Z(204)+4*L8*Z(15)*Z(185)+4*Z(24)*Z(17)*Z(192)+2*L3*Z(185)
     &*Z(310)+2*L3*Z(192)*Z(314)+2*Z(617)*Z(206)+4*Z(619)*Z(207)+2*L3*Z(
     &284)*Z(172)+2*L3*Z(292)*Z(176)+2*L3*Z(300)*Z(180)+2*L3*Z(308)*Z(18
     &6)+2*L3*Z(312)*Z(193)+4*L8*Z(256)*Z(164)+4*Z(24)*Z(18)*Z(193)+4*Z(
     &24)*Z(272)*Z(164)-4*L8*Z(192)-2*Z(620)*Z(204)-2*Z(621)*Z(205)-4*L8
     &*Z(17)*Z(204)-4*Z(24)*Z(185)*Z(306)-2*L8*Z(205)*Z(314)-4*L8*Z(16)*
     &Z(186)-4*L8*Z(18)*Z(206)-4*L8*Z(260)*Z(172)-4*L8*Z(264)*Z(176)-4*L
     &8*Z(268)*Z(180)-4*L8*Z(313)*Z(207)-4*Z(24)*Z(280)*Z(172)-4*Z(24)*Z
     &(288)*Z(176)-4*Z(24)*Z(296)*Z(180)-4*Z(24)*Z(304)*Z(186)-2*L3*Z(27
     &6)*Z(164))
      Z(686) = Z(531) - Z(659)
      SKTOR = Z(652)*U3p + Z(653)*U1p + Z(654)*U2p + Z(655)*U7p + Z(656)
     &*U6p + Z(657)*U5p + 0.5D0*Z(658)*U4p - Z(686)
      Z(661) = Z(660) - MI*(Z(578)*Z(17)+2*Z(595)*Z(19)+Z(568)*Z(274)+Z(
     &596)*Z(318)-Z(571)-Z(597)-Z(571)*Z(282)-Z(578)*Z(290)-Z(585)*Z(298
     &)-Z(585)*Z(306)-Z(595)*Z(322)-Z(598)*Z(330)-Z(598)*Z(334)-Z(599)*Z
     &(326)-Z(599)*Z(338)) - 0.25D0*MH*(4*Z(600)+4*Z(601)*Z(17)+2*Z(602)
     &*Z(302)+2*Z(602)*Z(310)+2*Z(603)*Z(286)+2*Z(604)*Z(294)+2*Z(604)*Z
     &(314)+4*Z(605)*Z(274)-4*Z(607)-Z(606)-4*Z(601)*Z(290)-4*Z(608)*Z(2
     &98)-4*Z(608)*Z(306)-4*Z(609)*Z(282)-2*Z(566)*Z(278))
      Z(662) = MI*(L6*Z(64)+Z(25)*Z(72)) - 0.5D0*MH*(L3*Z(68)-2*Z(24)*Z(
     &64))
      Z(663) = MI*(L6*Z(65)+Z(25)*Z(73)) - 0.5D0*MH*(L3*Z(69)-2*Z(24)*Z(
     &65))
      Z(664) = 0.5D0*MH*(Z(602)*Z(302)+Z(603)*Z(286)+Z(604)*Z(294)+2*Z(6
     &05)*Z(274)-2*Z(601)*Z(290)-2*Z(608)*Z(298)-2*Z(609)*Z(282)-Z(566)*
     &Z(278)) + MI*(Z(568)*Z(274)+Z(596)*Z(318)-Z(571)*Z(282)-Z(578)*Z(2
     &90)-Z(585)*Z(298)-Z(595)*Z(322)-Z(598)*Z(330)-Z(599)*Z(326))
      Z(665) = MI*(Z(568)*Z(274)+Z(596)*Z(318)-Z(571)*Z(282)-Z(578)*Z(29
     &0)-Z(595)*Z(322)-Z(599)*Z(326)) + 0.5D0*MH*(Z(603)*Z(286)+Z(604)*Z
     &(294)+2*Z(605)*Z(274)-2*Z(601)*Z(290)-2*Z(609)*Z(282)-Z(566)*Z(278
     &))
      Z(666) = 0.5D0*MH*(Z(603)*Z(286)+2*Z(605)*Z(274)-2*Z(609)*Z(282)-Z
     &(566)*Z(278)) - MI*(Z(571)*Z(282)+Z(595)*Z(322)-Z(568)*Z(274)-Z(59
     &6)*Z(318))
      Z(667) = L2*(2*MI*(L6*Z(274)+Z(25)*Z(318))-MH*(L3*Z(278)-2*Z(24)*Z
     &(274)))
      Z(532) = L6*(VRX1*Z(64)+VRY1*Z(65)) + Z(226)*(L6*Z(65)+Z(25)*Z(73)
     &) + Z(227)*(L2*Z(73)+L6*Z(65)) - 0.5D0*Z(225)*(L3*Z(69)-2*Z(24)*Z(
     &65))
      Z(668) = Z(548) + Z(550) + MI*(L6*Z(199)+Z(25)*Z(212)+L6*Z(17)*Z(1
     &92)+L6*Z(18)*Z(193)+L6*Z(272)*Z(164)+Z(25)*Z(20)*Z(201)+Z(25)*Z(31
     &6)*Z(164)-L6*Z(19)*Z(212)-Z(25)*Z(19)*Z(199)-L6*Z(185)*Z(306)-Z(25
     &)*Z(185)*Z(334)-Z(25)*Z(192)*Z(338)-L6*Z(20)*Z(214)-L6*Z(280)*Z(17
     &2)-L6*Z(288)*Z(176)-L6*Z(296)*Z(180)-L6*Z(304)*Z(186)-Z(25)*Z(320)
     &*Z(172)-Z(25)*Z(324)*Z(176)-Z(25)*Z(328)*Z(180)-Z(25)*Z(332)*Z(186
     &)-Z(25)*Z(336)*Z(193)) + 0.25D0*MH*(L3*Z(205)+4*Z(24)*Z(204)+4*Z(2
     &4)*Z(17)*Z(192)+2*L3*Z(185)*Z(310)+2*L3*Z(192)*Z(314)+2*Z(617)*Z(2
     &06)+4*Z(619)*Z(207)+2*L3*Z(284)*Z(172)+2*L3*Z(292)*Z(176)+2*L3*Z(3
     &00)*Z(180)+2*L3*Z(308)*Z(186)+2*L3*Z(312)*Z(193)+4*Z(24)*Z(18)*Z(1
     &93)+4*Z(24)*Z(272)*Z(164)-2*Z(620)*Z(204)-2*Z(621)*Z(205)-4*Z(24)*
     &Z(185)*Z(306)-4*Z(24)*Z(280)*Z(172)-4*Z(24)*Z(288)*Z(176)-4*Z(24)*
     &Z(296)*Z(180)-4*Z(24)*Z(304)*Z(186)-2*L3*Z(276)*Z(164))
      Z(687) = Z(532) - Z(668)
      SATOR = Z(661)*U3p + Z(662)*U1p + Z(663)*U2p + Z(664)*U7p + Z(665)
     &*U6p + Z(666)*U5p + 0.5D0*Z(667)*U4p - Z(687)
      Z(669) = INI - Z(509)*(L6*Z(19)+L2*Z(318)-Z(25)-L10*Z(330)-L10*Z(3
     &34)-L6*Z(322)-L8*Z(326)-L8*Z(338))
      Z(670) = Z(509)*Z(72)
      Z(671) = Z(509)*Z(73)
      Z(672) = Z(509)*(L2*Z(318)-L10*Z(330)-L6*Z(322)-L8*Z(326))
      Z(673) = Z(509)*(L2*Z(318)-L6*Z(322)-L8*Z(326))
      Z(674) = Z(509)*(L2*Z(318)-L6*Z(322))
      Z(676) = Z(675)*Z(318)
      Z(534) = Z(73)*(Z(533)+L2*Z(227))
      Z(677) = Z(550) + Z(509)*(Z(212)+Z(20)*Z(201)+Z(316)*Z(164)-Z(19)*
     &Z(199)-Z(185)*Z(334)-Z(192)*Z(338)-Z(320)*Z(172)-Z(324)*Z(176)-Z(3
     &28)*Z(180)-Z(332)*Z(186)-Z(336)*Z(193))
      Z(688) = Z(534) - Z(677)
      SMTOR = Z(669)*U3p + Z(670)*U1p + Z(671)*U2p + Z(672)*U7p + Z(673)
     &*U6p + Z(674)*U5p + Z(676)*U4p - Z(688)
      POP1X = Q1
      POP1Y = Q2
      POP3X = Q1 + L5*Z(43) - L2*Z(36)
      POP3Y = Q2 + L5*Z(44) - L2*Z(37)
      POP4X = Q1 + L6*Z(47) - L2*Z(36)
      POP4Y = Q2 + L6*Z(48) - L2*Z(37)
      POP5X = Q1 + L6*Z(47) + L8*Z(32) - L2*Z(36)
      POP5Y = Q2 + L6*Z(48) + L8*Z(33) - L2*Z(37)
      POP6X = Q1 + L10*Z(51) + L6*Z(47) + L8*Z(32) - L2*Z(36)
      POP6Y = Q2 + L10*Z(52) + L6*Z(48) + L8*Z(33) - L2*Z(37)
      POP7X = Q1 + L10*Z(51) + L10*Z(55) + L6*Z(47) + L8*Z(32) - L2*Z(36
     &)
      POP7Y = Q2 + L10*Z(52) + L10*Z(56) + L6*Z(48) + L8*Z(33) - L2*Z(37
     &)
      POP8X = Q1 + L10*Z(51) + L10*Z(55) + L6*Z(47) + L8*Z(32) + L8*Z(58
     &) - L2*Z(36)
      POP8Y = Q2 + L10*Z(52) + L10*Z(56) + L6*Z(48) + L8*Z(33) + L8*Z(59
     &) - L2*Z(37)
      POP9X = Q1 + L10*Z(51) + L10*Z(55) + L6*Z(47) + L6*Z(62) + L8*Z(32
     &) + L8*Z(58) - L2*Z(36)
      POP9Y = Q2 + L10*Z(52) + L10*Z(56) + L6*Z(48) + L6*Z(63) + L8*Z(33
     &) + L8*Z(59) - L2*Z(37)
      POGOX = Q1 + L10*Z(51) + L6*Z(47) + L8*Z(32) + GS*Z(1) - L2*Z(36)
      POGOY = Q2 + L10*Z(52) + L6*Z(48) + L8*Z(33) + GS*Z(2) - L2*Z(37)
      POP10X = Q1 + L10*Z(51) + L10*Z(55) + L6*Z(47) + L6*Z(62) + L8*Z(3
     &2) + L8*Z(58) - L2*Z(36) - L5*Z(66)
      POP10Y = Q2 + L10*Z(52) + L10*Z(56) + L6*Z(48) + L6*Z(63) + L8*Z(3
     &3) + L8*Z(59) - L2*Z(37) - L5*Z(67)
      POP11X = Q1 + L10*Z(51) + L10*Z(55) + L2*Z(70) + L6*Z(47) + L6*Z(6
     &2) + L8*Z(32) + L8*Z(58) - L2*Z(36)
      POP11Y = Q2 + L10*Z(52) + L10*Z(56) + L2*Z(71) + L6*Z(48) + L6*Z(6
     &3) + L8*Z(33) + L8*Z(59) - L2*Z(37)
      POCMX = Q1 + Z(77)*Z(32) + Z(78)*Z(51) + Z(79)*Z(55) + Z(80)*Z(58)
     & + Z(82)*Z(62) + Z(83)*Z(70) + Z(81)*Z(1) + 0.5D0*Z(76)*Z(47) + 0.
     &5D0*Z(85)*Z(43) - Z(75)*Z(36) - 0.5D0*Z(84)*Z(66)
      POCMSTANCEX = Q1 + Z(89)*Z(32) + Z(90)*Z(51) + 0.5D0*Z(88)*Z(47) +
     & 0.5D0*Z(91)*Z(43) - Z(87)*Z(36)
      POCMSTANCEY = Q2 + Z(89)*Z(33) + Z(90)*Z(52) + 0.5D0*Z(88)*Z(48) +
     & 0.5D0*Z(91)*Z(44) - Z(87)*Z(37)
      POCMSWINGX = Q1 + Z(94)*Z(47) + Z(95)*Z(32) + Z(96)*Z(51) + Z(97)*
     &Z(55) + Z(98)*Z(58) + Z(99)*Z(62) + Z(100)*Z(70) - Z(93)*Z(36) - 0
     &.5D0*Z(101)*Z(66)
      POCMSWINGY = Q2 + Z(94)*Z(48) + Z(95)*Z(33) + Z(96)*Z(52) + Z(97)*
     &Z(56) + Z(98)*Z(59) + Z(99)*Z(63) + Z(100)*Z(71) - Z(93)*Z(37) - 0
     &.5D0*Z(101)*Z(67)
      Z(150) = MG*GSp/Z(74)
      Z(151) = Z(79)*EAp
      Z(152) = Z(80)*(EAp-FAp)
      Z(153) = Z(82)*(FAp-EAp-HAp)
      Z(154) = Z(83)*(FAp-EAp-HAp-IAp)
      Z(155) = Z(84)*(FAp-EAp-HAp)
      Z(156) = Z(97)*EAp
      Z(157) = Z(98)*(EAp-FAp)
      Z(158) = Z(99)*(FAp-EAp-HAp)
      Z(159) = Z(100)*(FAp-EAp-HAp-IAp)
      Z(160) = Z(101)*(FAp-EAp-HAp)
      VOCMX = Z(150)*Z(1) + U1 + Z(78)*Z(53)*(U3-U7) + Z(77)*Z(34)*(U3-U
     &6-U7) + 0.5D0*Z(76)*Z(49)*(U3-U5-U6-U7) + 0.5D0*Z(85)*Z(45)*(U3-U5
     &-U6-U7) + Z(64)*(Z(153)+Z(82)*U10+Z(82)*U3+Z(82)*U8+Z(82)*U9) + Z(
     &72)*(Z(154)+Z(83)*U10+Z(83)*U11+Z(83)*U3+Z(83)*U8+Z(83)*U9) - Z(81
     &)*Z(2)*U3 - Z(57)*(Z(151)-Z(79)*U3-Z(79)*U8) - 0.5D0*Z(68)*(Z(155)
     &+Z(84)*U10+Z(84)*U3+Z(84)*U8+Z(84)*U9) - Z(75)*Z(38)*(U3-U4-U5-U6-
     &U7) - Z(60)*(Z(152)-Z(80)*U3-Z(80)*U8-Z(80)*U9)
      VOCMY = Z(150)*Z(2) + U2 + Z(81)*Z(1)*U3 + Z(78)*Z(54)*(U3-U7) + Z
     &(77)*Z(35)*(U3-U6-U7) + 0.5D0*Z(76)*Z(50)*(U3-U5-U6-U7) + 0.5D0*Z(
     &85)*Z(46)*(U3-U5-U6-U7) + Z(65)*(Z(153)+Z(82)*U10+Z(82)*U3+Z(82)*U
     &8+Z(82)*U9) + Z(73)*(Z(154)+Z(83)*U10+Z(83)*U11+Z(83)*U3+Z(83)*U8+
     &Z(83)*U9) - Z(55)*(Z(151)-Z(79)*U3-Z(79)*U8) - 0.5D0*Z(69)*(Z(155)
     &+Z(84)*U10+Z(84)*U3+Z(84)*U8+Z(84)*U9) - Z(75)*Z(39)*(U3-U4-U5-U6-
     &U7) - Z(61)*(Z(152)-Z(80)*U3-Z(80)*U8-Z(80)*U9)
      VOCMSTANCEX = U1 + Z(90)*Z(53)*(U3-U7) + Z(89)*Z(34)*(U3-U6-U7) + 
     &0.5D0*Z(88)*Z(49)*(U3-U5-U6-U7) + 0.5D0*Z(91)*Z(45)*(U3-U5-U6-U7) 
     &- Z(87)*Z(38)*(U3-U4-U5-U6-U7)
      VOCMSTANCEY = U2 + Z(90)*Z(54)*(U3-U7) + Z(89)*Z(35)*(U3-U6-U7) + 
     &0.5D0*Z(88)*Z(50)*(U3-U5-U6-U7) + 0.5D0*Z(91)*Z(46)*(U3-U5-U6-U7) 
     &- Z(87)*Z(39)*(U3-U4-U5-U6-U7)
      VOCMSWINGX = U1 + Z(96)*Z(53)*(U3-U7) + Z(95)*Z(34)*(U3-U6-U7) + Z
     &(94)*Z(49)*(U3-U5-U6-U7) + Z(64)*(Z(158)+Z(99)*U10+Z(99)*U3+Z(99)*
     &U8+Z(99)*U9) + Z(72)*(Z(159)+Z(100)*U10+Z(100)*U11+Z(100)*U3+Z(100
     &)*U8+Z(100)*U9) - Z(57)*(Z(156)-Z(97)*U3-Z(97)*U8) - 0.5D0*Z(68)*(
     &Z(160)+Z(101)*U10+Z(101)*U3+Z(101)*U8+Z(101)*U9) - Z(93)*Z(38)*(U3
     &-U4-U5-U6-U7) - Z(60)*(Z(157)-Z(98)*U3-Z(98)*U8-Z(98)*U9)
      VOCMSWINGY = U2 + Z(96)*Z(54)*(U3-U7) + Z(95)*Z(35)*(U3-U6-U7) + Z
     &(94)*Z(50)*(U3-U5-U6-U7) + Z(65)*(Z(158)+Z(99)*U10+Z(99)*U3+Z(99)*
     &U8+Z(99)*U9) + Z(73)*(Z(159)+Z(100)*U10+Z(100)*U11+Z(100)*U3+Z(100
     &)*U8+Z(100)*U9) - Z(55)*(Z(156)-Z(97)*U3-Z(97)*U8) - 0.5D0*Z(69)*(
     &Z(160)+Z(101)*U10+Z(101)*U3+Z(101)*U8+Z(101)*U9) - Z(93)*Z(39)*(U3
     &-U4-U5-U6-U7) - Z(61)*(Z(157)-Z(98)*U3-Z(98)*U8-Z(98)*U9)
      SAANG = HA
      SMANG = IA
      SAANGVEL = HAp
      SMANGVEL = IAp
      PSWINGX = (ME+MF)*U1 + (Z(476)+Z(482))*Z(53)*(U3-U7) + (Z(475)+Z(4
     &81))*Z(34)*(U3-U6-U7) + (Z(474)+Z(480))*Z(49)*(U3-U5-U6-U7) - Z(60
     &)*(Z(485)-Z(484)*U3-Z(484)*U8-Z(484)*U9) - (Z(473)+Z(479))*Z(38)*(
     &U3-U4-U5-U6-U7) - Z(57)*(Z(478)+Z(483)-Z(477)*U3-Z(477)*U8-Z(482)*
     &U3-Z(482)*U8)
      PSWINGY = (ME+MF)*U2 + (Z(476)+Z(482))*Z(54)*(U3-U7) + (Z(475)+Z(4
     &81))*Z(35)*(U3-U6-U7) + (Z(474)+Z(480))*Z(50)*(U3-U5-U6-U7) - Z(61
     &)*(Z(485)-Z(484)*U3-Z(484)*U8-Z(484)*U9) - (Z(473)+Z(479))*Z(39)*(
     &U3-U4-U5-U6-U7) - Z(55)*(Z(478)+Z(483)-Z(477)*U3-Z(477)*U8-Z(482)*
     &U3-Z(482)*U8)
      PSTANCEX = (MA+MB+MC+MD)*U1 + Z(472)*Z(53)*(U3-U7) + (Z(468)+Z(471
     &))*Z(34)*(U3-U6-U7) + 0.5D0*Z(465)*Z(45)*(U3-U5-U6-U7) + 0.5D0*(Z(
     &464)+2*Z(467)+2*Z(470))*Z(49)*(U3-U5-U6-U7) - (Z(462)+Z(463)+Z(466
     &)+Z(469))*Z(38)*(U3-U4-U5-U6-U7)
      PSTANCEY = (MA+MB+MC+MD)*U2 + Z(472)*Z(54)*(U3-U7) + (Z(468)+Z(471
     &))*Z(35)*(U3-U6-U7) + 0.5D0*Z(465)*Z(46)*(U3-U5-U6-U7) + 0.5D0*(Z(
     &464)+2*Z(467)+2*Z(470))*Z(50)*(U3-U5-U6-U7) - (Z(462)+Z(463)+Z(466
     &)+Z(469))*Z(39)*(U3-U4-U5-U6-U7)

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


