C**   The name of this program is model/7segsprint.f
C**   Created by AUTOLEV 3.2 on Wed Feb 16 18:08:44 2022

      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          ILOOP, IPRINT, PRINTINT
      CHARACTER        MESSAGE(99)
      EXTERNAL         EQNS1
      DIMENSION        VAR(14)
      COMMON/CONSTNTS/ AE,AF,FOOTANG,G,HE,HF,INA,INB,INC,IND,INE,INF,ING
     &,INH,INI,K1,K2,K3,K4,K5,K6,K7,K8,KE,KF,L1,L10,L11,L2,L3,L4,L5,L6,L
     &7,L8,L9,MA,MB,MC,MD,ME,MF,MG,MH,MI,MTPB,MTPK,POP1XI,POP2XI
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
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(693),COEF(7,7),RHS(7)

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
     &IND,INE,INF,ING,INH,INI,K1,K2,K3,K4,K5,K6,K7,K8,KE,KF,L1,L10,L11,L
     &2,L3,L4,L5,L6,L7,L8,L9,MA,MB,MC,MD,ME,MF,MG,MH,MI,MTPB,MTPK,POP1XI
     &,POP2XI

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
      Z(520) = Z(21)*Z(222)
      Z(649) = INF + INH + INI
      Z(22) = L8 - L7
      Z(479) = MF*Z(22)
      Z(225) = G*MH
      Z(7) = COS(FOOTANG)
      Z(25) = L2 - L1
      Z(501) = MI*Z(25)
      Z(8) = SIN(FOOTANG)
      Z(23) = L6 - L4
      Z(24) = 0.5D0*L6 + 0.5D0*Z(23)
      Z(70) = MA + MB + MC + MD + ME + MF + MG + MH + MI
      Z(71) = (L1*MA+L2*MB+L2*MC+L2*MD+L2*ME+L2*MF+L2*MG+L2*MH+L2*MI)/Z(
     &70)
      Z(72) = (L4*MB+2*L6*MC+2*L6*MD+2*L6*ME+2*L6*MF+2*L6*MG+2*L6*MH+2*L
     &6*MI)/Z(70)
      Z(73) = (L7*MC+L8*MD+L8*ME+L8*MF+L8*MG+L8*MH+L8*MI)/Z(70)
      Z(74) = (L10*ME+L10*MF+L10*MG+L10*MH+L10*MI+L9*MD)/Z(70)
      Z(75) = (L10*MF+L10*MH+ME*Z(21))/Z(70)
      Z(76) = (L8*MH+MF*Z(22))/Z(70)
      Z(77) = L11*MI
      Z(79) = MH*Z(24)/Z(70)
      Z(80) = MI*Z(25)/Z(70)
      Z(81) = L3*MH/Z(70)
      Z(82) = L3*MB/Z(70)
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
      Z(98) = (L10*MF+L10*MH+ME*Z(21))/Z(93)
      Z(99) = (L8*MH+MF*Z(22))/Z(93)
      Z(100) = L11*MI/Z(93)
      Z(101) = MH*Z(24)/Z(93)
      Z(102) = MI*Z(25)/Z(93)
      Z(103) = L3*MH/Z(93)
      Z(218) = G*MA
      Z(219) = G*MB
      Z(220) = G*MC
      Z(221) = G*MD
      Z(223) = G*MF
      Z(224) = G*MG
      Z(226) = G*MI
      Z(337) = Z(71) - L1
      Z(338) = Z(71) - L2
      Z(339) = 0.5D0*L4 - 0.5D0*Z(72)
      Z(340) = 0.5D0*L3 - 0.5D0*Z(82)
      Z(368) = L6 - 0.5D0*Z(72)
      Z(369) = L7 - Z(73)
      Z(370) = L8 - Z(73)
      Z(371) = L9 - Z(74)
      Z(372) = L10 - Z(74)
      Z(373) = Z(21) - Z(75)
      Z(378) = L10 - Z(75)
      Z(379) = Z(22) - Z(76)
      Z(384) = L8 - Z(76)
      Z(385) = Z(24) - Z(79)
      Z(386) = 0.5D0*Z(81) - 0.5D0*L3
      Z(391) = Z(25) - Z(80)
      Z(396) = 2*Z(339) + 2*Z(7)*Z(340)
      Z(400) = 2*Z(340) + 2*Z(7)*Z(339)
      Z(403) = Z(7)*Z(82)
      Z(443) = 2*Z(385) + 2*Z(7)*Z(386)
      Z(447) = 2*Z(386) + 2*Z(7)*Z(385)
      Z(457) = L1*MA
      Z(458) = L2*MB
      Z(459) = L4*MB
      Z(460) = L3*MB
      Z(461) = L2*MC
      Z(462) = L6*MC
      Z(463) = L7*MC
      Z(464) = L2*MD
      Z(465) = L6*MD
      Z(466) = L8*MD
      Z(467) = L9*MD
      Z(468) = L2*ME
      Z(469) = L6*ME
      Z(470) = L8*ME
      Z(471) = L10*ME
      Z(472) = ME*Z(21)
      Z(474) = L2*MF
      Z(475) = L6*MF
      Z(476) = L8*MF
      Z(477) = L10*MF
      Z(481) = L2*MG
      Z(482) = L6*MG
      Z(483) = L8*MG
      Z(484) = L10*MG
      Z(487) = L2*MH
      Z(488) = L6*MH
      Z(489) = L8*MH
      Z(490) = L10*MH
      Z(493) = MH*Z(24)
      Z(495) = L3*MH
      Z(497) = L2*MI
      Z(498) = L6*MI
      Z(499) = L8*MI
      Z(500) = L10*MI
      Z(504) = Z(218) + Z(219) + Z(220) + Z(221) + Z(222) + Z(223) + Z(2
     &24) + Z(225) + Z(226)
      Z(506) = L1*Z(218)
      Z(508) = L2*Z(219)
      Z(509) = L2*Z(220)
      Z(510) = L2*Z(221)
      Z(511) = L2*Z(222)
      Z(512) = L2*Z(223)
      Z(513) = L2*Z(224)
      Z(514) = L2*Z(225)
      Z(515) = L2*Z(226)
      Z(521) = Z(25)*Z(226)
      Z(523) = Z(22)*Z(223)
      Z(544) = L1*MA + L2*MB + L2*MC + L2*MD + L2*ME + L2*MF + L2*MG + L
     &2*MH + L2*MI
      Z(556) = INA + INB + INC + IND + INE + INF + ING + INH + INI + MA*
     &L1**2
      Z(557) = L3**2 + L4**2 + 4*L2**2 + 2*L3*L4*Z(7)
      Z(558) = L2*L3
      Z(559) = L2*L4
      Z(560) = L2*L6
      Z(561) = L2*L7
      Z(562) = L2**2
      Z(563) = L6**2
      Z(564) = L7**2
      Z(565) = L6*L7
      Z(566) = L2*L8
      Z(567) = L2*L9
      Z(568) = L8**2
      Z(569) = L9**2
      Z(570) = L6*L8
      Z(571) = L6*L9
      Z(572) = L8*L9
      Z(573) = L10*L2
      Z(574) = L2*Z(21)
      Z(575) = L10**2
      Z(576) = Z(21)**2
      Z(577) = L10*L6
      Z(578) = L10*L8
      Z(579) = L10*Z(21)
      Z(580) = L6*Z(21)
      Z(581) = L8*Z(21)
      Z(582) = L10*Z(22)
      Z(583) = L2*Z(22)
      Z(584) = Z(22)**2
      Z(585) = L6*Z(22)
      Z(586) = L8*Z(22)
      Z(587) = L11*L2
      Z(588) = L2*Z(25)
      Z(589) = L11**2
      Z(590) = Z(25)**2
      Z(591) = L10*L11
      Z(592) = L10*Z(25)
      Z(593) = L11*L6
      Z(594) = L11*L8
      Z(595) = L11*Z(25)
      Z(596) = L6*Z(25)
      Z(597) = L8*Z(25)
      Z(598) = L3*Z(7)*Z(24)
      Z(599) = L8*Z(24)
      Z(600) = L10*L3
      Z(601) = L3*L6
      Z(602) = L3*L8
      Z(603) = L2*Z(24)
      Z(604) = L3**2
      Z(605) = Z(24)**2
      Z(606) = L10*Z(24)
      Z(607) = L6*Z(24)
      Z(609) = -INA - MA*L1**2
      Z(611) = MA*L1**2
      Z(615) = L3*Z(8)
      Z(616) = L4*Z(8)
      Z(617) = Z(8)*Z(24)
      Z(618) = L3*Z(7)
      Z(619) = Z(7)*Z(24)
      Z(621) = INA + MA*L1**2 + MB*L2**2 + MC*L2**2 + MD*L2**2 + ME*L2**
     &2 + MF*L2**2 + MG*L2**2 + MH*L2**2 + MI*L2**2
      Z(622) = INA + MA*L1**2
      Z(627) = INA + INB + MA*L1**2
      Z(628) = L2**2 + L6**2
      Z(633) = INA + INB + INC + MA*L1**2
      Z(637) = INA + INB + INC + IND + MA*L1**2
      Z(640) = INE + INF + INH + INI
      Z(672) = L2*MI*Z(25)

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
     &,INH,INI,K1,K2,K3,K4,K5,K6,K7,K8,KE,KF,L1,L10,L11,L2,L3,L4,L5,L6,L
     &7,L8,L9,MA,MB,MC,MD,ME,MF,MG,MH,MI,MTPB,MTPK,POP1XI,POP2XI
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
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(693),COEF(7,7),RHS(7)

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
      Z(50) = Z(3)*Z(36) + Z(4)*Z(38)
      Z(51) = Z(3)*Z(37) + Z(4)*Z(39)
      Z(52) = Z(3)*Z(38) - Z(4)*Z(36)
      Z(53) = Z(3)*Z(39) - Z(4)*Z(37)
      Z(54) = Z(9)*Z(32) + Z(10)*Z(34)
      Z(55) = Z(9)*Z(33) + Z(10)*Z(35)
      Z(56) = Z(9)*Z(34) - Z(10)*Z(32)
      Z(57) = Z(9)*Z(35) - Z(10)*Z(33)
      Z(83) = Z(7)*Z(50) + Z(8)*Z(52)
      Z(84) = Z(7)*Z(51) + Z(8)*Z(53)
      Z(85) = Z(7)*Z(52) - Z(8)*Z(50)
      Z(86) = Z(7)*Z(53) - Z(8)*Z(51)
      Z(106) = Z(1)*Z(38) + Z(2)*Z(39)
      Z(107) = Z(1)*Z(37) - Z(2)*Z(36)
      Z(108) = Z(1)*Z(39) - Z(2)*Z(38)
      Z(111) = Z(1)*Z(52) + Z(2)*Z(53)
      Z(112) = Z(1)*Z(51) - Z(2)*Z(50)
      Z(113) = Z(1)*Z(53) - Z(2)*Z(52)
      Z(162) = L1*(U3-U4-U5-U6-U7)
      Z(163) = (U3-U4-U5-U6-U7)*Z(162)
      Z(164) = L2*(U3-U4-U5-U6-U7)
      Z(165) = (U3-U4-U5-U6-U7)*Z(164)
      Z(166) = L4*(U3-U5-U6-U7)
      Z(167) = L3*(U3-U5-U6-U7)
      Z(168) = (U3-U5-U6-U7)*Z(166)
      Z(169) = (U3-U5-U6-U7)*Z(167)
      Z(175) = L6*(U3-U5-U6-U7)
      Z(176) = (U3-U5-U6-U7)*Z(175)
      Z(177) = L7*(U3-U6-U7)
      Z(178) = (U3-U6-U7)*Z(177)
      Z(179) = L8*(U3-U6-U7)
      Z(180) = (U3-U6-U7)*Z(179)
      Z(181) = L9*(U3-U7)
      Z(182) = (U3-U7)*Z(181)
      Z(183) = L10*(U3-U7)
      Z(184) = (U3-U7)*Z(183)
      Z(201) = L11*U3
      Z(202) = U3*Z(201)
      Z(228) = MTOR - ATOR
      Z(231) = Z(7)*Z(3) - Z(8)*Z(4)
      Z(232) = -Z(7)*Z(4) - Z(8)*Z(3)
      Z(233) = Z(7)*Z(4) + Z(8)*Z(3)
      Z(234) = Z(9)*Z(26) + Z(10)*Z(27)
      Z(235) = Z(9)*Z(27) - Z(10)*Z(26)
      Z(236) = Z(9)*Z(28) + Z(10)*Z(26)
      Z(237) = Z(9)*Z(26) - Z(10)*Z(28)
      Z(239) = Z(3)*Z(235) + Z(4)*Z(237)
      Z(240) = Z(3)*Z(236) - Z(4)*Z(234)
      Z(241) = Z(3)*Z(237) - Z(4)*Z(235)
      Z(503) = RX1 + RX2 + VRX1
      Z(505) = Z(504) + RY1 + RY2 + VRY1 + Z(227)
      Z(516) = MTOR + Z(506)*Z(39) + Z(508)*Z(39) + Z(509)*Z(39) + Z(510
     &)*Z(39) + Z(511)*Z(39) + Z(512)*Z(39) + Z(513)*Z(39) + Z(514)*Z(39
     &) + Z(515)*Z(39) + L2*Z(39)*Z(227) + L2*(RX2*Z(38)+RY2*Z(39)) + L2
     &*(VRX1*Z(38)+VRY1*Z(39))
      Z(517) = MTOR + Z(506)*Z(39) + L2*VRX1*Z(38) + L2*VRY1*Z(39) + L2*
     &(RX2*Z(38)+RY2*Z(39)) + Z(220)*(L2*Z(39)-L6*Z(53)) + Z(221)*(L2*Z(
     &39)-L6*Z(53)) + Z(222)*(L2*Z(39)-L6*Z(53)) + Z(223)*(L2*Z(39)-L6*Z
     &(53)) + Z(224)*(L2*Z(39)-L6*Z(53)) + Z(225)*(L2*Z(39)-L6*Z(53)) + 
     &Z(226)*(L2*Z(39)-L6*Z(53)) + Z(227)*(L2*Z(39)-L6*Z(53)) + 0.5D0*Z(
     &219)*(2*L2*Z(39)-L3*Z(86)-L4*Z(53)) - Z(228) - L6*VRX1*Z(52) - L6*
     &VRY1*Z(53)
      Z(518) = MTOR + Z(506)*Z(39) + L2*VRX1*Z(38) + L2*VRY1*Z(39) + L2*
     &(RX2*Z(38)+RY2*Z(39)) + Z(220)*(L2*Z(39)-L6*Z(53)-L7*Z(35)) + Z(22
     &1)*(L2*Z(39)-L6*Z(53)-L8*Z(35)) + Z(222)*(L2*Z(39)-L6*Z(53)-L8*Z(3
     &5)) + Z(223)*(L2*Z(39)-L6*Z(53)-L8*Z(35)) + Z(224)*(L2*Z(39)-L6*Z(
     &53)-L8*Z(35)) + Z(225)*(L2*Z(39)-L6*Z(53)-L8*Z(35)) + Z(226)*(L2*Z
     &(39)-L6*Z(53)-L8*Z(35)) + Z(227)*(L2*Z(39)-L6*Z(53)-L8*Z(35)) + 0.
     &5D0*Z(219)*(2*L2*Z(39)-L3*Z(86)-L4*Z(53)) - Z(228) - Z(229) - L6*V
     &RX1*Z(52) - L6*VRY1*Z(53) - L8*VRX1*Z(34) - L8*VRY1*Z(35)
      Z(519) = MTOR + Z(506)*Z(39) + L2*VRX1*Z(38) + L2*VRY1*Z(39) + L2*
     &(RX2*Z(38)+RY2*Z(39)) + Z(220)*(L2*Z(39)-L6*Z(53)-L7*Z(35)) + 0.5D
     &0*Z(219)*(2*L2*Z(39)-L3*Z(86)-L4*Z(53)) + Z(221)*(L2*Z(39)-L6*Z(53
     &)-L8*Z(35)-L9*Z(57)) + Z(222)*(L2*Z(39)-L10*Z(57)-L6*Z(53)-L8*Z(35
     &)) + Z(223)*(L2*Z(39)-L10*Z(57)-L6*Z(53)-L8*Z(35)) + Z(224)*(L2*Z(
     &39)-L10*Z(57)-L6*Z(53)-L8*Z(35)) + Z(225)*(L2*Z(39)-L10*Z(57)-L6*Z
     &(53)-L8*Z(35)) + Z(226)*(L2*Z(39)-L10*Z(57)-L6*Z(53)-L8*Z(35)) + Z
     &(227)*(L2*Z(39)-L10*Z(57)-L6*Z(53)-L8*Z(35)) - Z(228) - Z(229) - Z
     &(230) - L10*VRX1*Z(56) - L10*VRY1*Z(57) - L6*VRX1*Z(52) - L6*VRY1*
     &Z(53) - L8*VRX1*Z(34) - L8*VRY1*Z(35)
      Z(545) = Z(544)*Z(38)
      Z(546) = Z(457)*Z(38) + MC*(L2*Z(38)-L6*Z(52)) + MD*(L2*Z(38)-L6*Z
     &(52)) + ME*(L2*Z(38)-L6*Z(52)) + MF*(L2*Z(38)-L6*Z(52)) + MG*(L2*Z
     &(38)-L6*Z(52)) + MH*(L2*Z(38)-L6*Z(52)) + MI*(L2*Z(38)-L6*Z(52)) +
     & 0.5D0*MB*(2*L2*Z(38)-L3*Z(85)-L4*Z(52))
      Z(547) = Z(457)*Z(38) + MC*(L2*Z(38)-L6*Z(52)-L7*Z(34)) + MD*(L2*Z
     &(38)-L6*Z(52)-L8*Z(34)) + ME*(L2*Z(38)-L6*Z(52)-L8*Z(34)) + MF*(L2
     &*Z(38)-L6*Z(52)-L8*Z(34)) + MG*(L2*Z(38)-L6*Z(52)-L8*Z(34)) + MH*(
     &L2*Z(38)-L6*Z(52)-L8*Z(34)) + MI*(L2*Z(38)-L6*Z(52)-L8*Z(34)) + 0.
     &5D0*MB*(2*L2*Z(38)-L3*Z(85)-L4*Z(52))
      Z(548) = Z(457)*Z(38) + MC*(L2*Z(38)-L6*Z(52)-L7*Z(34)) + 0.5D0*MB
     &*(2*L2*Z(38)-L3*Z(85)-L4*Z(52)) + MD*(L2*Z(38)-L6*Z(52)-L8*Z(34)-L
     &9*Z(56)) + ME*(L2*Z(38)-L10*Z(56)-L6*Z(52)-L8*Z(34)) + MF*(L2*Z(38
     &)-L10*Z(56)-L6*Z(52)-L8*Z(34)) + MG*(L2*Z(38)-L10*Z(56)-L6*Z(52)-L
     &8*Z(34)) + MH*(L2*Z(38)-L10*Z(56)-L6*Z(52)-L8*Z(34)) + MI*(L2*Z(38
     &)-L10*Z(56)-L6*Z(52)-L8*Z(34))
      Z(551) = Z(544)*Z(39)
      Z(552) = Z(457)*Z(39) + MC*(L2*Z(39)-L6*Z(53)) + MD*(L2*Z(39)-L6*Z
     &(53)) + ME*(L2*Z(39)-L6*Z(53)) + MF*(L2*Z(39)-L6*Z(53)) + MG*(L2*Z
     &(39)-L6*Z(53)) + MH*(L2*Z(39)-L6*Z(53)) + MI*(L2*Z(39)-L6*Z(53)) +
     & 0.5D0*MB*(2*L2*Z(39)-L3*Z(86)-L4*Z(53))
      Z(553) = Z(457)*Z(39) + MC*(L2*Z(39)-L6*Z(53)-L7*Z(35)) + MD*(L2*Z
     &(39)-L6*Z(53)-L8*Z(35)) + ME*(L2*Z(39)-L6*Z(53)-L8*Z(35)) + MF*(L2
     &*Z(39)-L6*Z(53)-L8*Z(35)) + MG*(L2*Z(39)-L6*Z(53)-L8*Z(35)) + MH*(
     &L2*Z(39)-L6*Z(53)-L8*Z(35)) + MI*(L2*Z(39)-L6*Z(53)-L8*Z(35)) + 0.
     &5D0*MB*(2*L2*Z(39)-L3*Z(86)-L4*Z(53))
      Z(554) = Z(457)*Z(39) + MC*(L2*Z(39)-L6*Z(53)-L7*Z(35)) + 0.5D0*MB
     &*(2*L2*Z(39)-L3*Z(86)-L4*Z(53)) + MD*(L2*Z(39)-L6*Z(53)-L8*Z(35)-L
     &9*Z(57)) + ME*(L2*Z(39)-L10*Z(57)-L6*Z(53)-L8*Z(35)) + MF*(L2*Z(39
     &)-L10*Z(57)-L6*Z(53)-L8*Z(35)) + MG*(L2*Z(39)-L10*Z(57)-L6*Z(53)-L
     &8*Z(35)) + MH*(L2*Z(39)-L10*Z(57)-L6*Z(53)-L8*Z(35)) + MI*(L2*Z(39
     &)-L10*Z(57)-L6*Z(53)-L8*Z(35))
      Z(623) = Z(622) + Z(461)*(L2-L6*Z(3)) + Z(464)*(L2-L6*Z(3)) + Z(46
     &8)*(L2-L6*Z(3)) + Z(474)*(L2-L6*Z(3)) + Z(481)*(L2-L6*Z(3)) + Z(48
     &7)*(L2-L6*Z(3)) + Z(497)*(L2-L6*Z(3)) + 0.5D0*Z(458)*(2*L2-L3*Z(23
     &1)-L4*Z(3))
      Z(624) = Z(622) + Z(461)*(L2-L6*Z(3)-L7*Z(26)) + Z(464)*(L2-L6*Z(3
     &)-L8*Z(26)) + Z(468)*(L2-L6*Z(3)-L8*Z(26)) + Z(474)*(L2-L6*Z(3)-L8
     &*Z(26)) + Z(481)*(L2-L6*Z(3)-L8*Z(26)) + Z(487)*(L2-L6*Z(3)-L8*Z(2
     &6)) + Z(497)*(L2-L6*Z(3)-L8*Z(26)) + 0.5D0*Z(458)*(2*L2-L3*Z(231)-
     &L4*Z(3))
      Z(625) = Z(622) + Z(461)*(L2-L6*Z(3)-L7*Z(26)) + 0.5D0*Z(458)*(2*L
     &2-L3*Z(231)-L4*Z(3)) + Z(464)*(L2-L6*Z(3)-L8*Z(26)-L9*Z(237)) + Z(
     &468)*(L2-L10*Z(237)-L6*Z(3)-L8*Z(26)) + Z(474)*(L2-L10*Z(237)-L6*Z
     &(3)-L8*Z(26)) + Z(481)*(L2-L10*Z(237)-L6*Z(3)-L8*Z(26)) + Z(487)*(
     &L2-L10*Z(237)-L6*Z(3)-L8*Z(26)) + Z(497)*(L2-L10*Z(237)-L6*Z(3)-L8
     &*Z(26))
      Z(629) = Z(627) + MC*(Z(628)-2*Z(560)*Z(3)) + MD*(Z(628)-2*Z(560)*
     &Z(3)) + ME*(Z(628)-2*Z(560)*Z(3)) + MF*(Z(628)-2*Z(560)*Z(3)) + MG
     &*(Z(628)-2*Z(560)*Z(3)) + MH*(Z(628)-2*Z(560)*Z(3)) + MI*(Z(628)-2
     &*Z(560)*Z(3)) + 0.25D0*MB*(Z(557)-4*Z(558)*Z(231)-4*Z(559)*Z(3))
      Z(630) = Z(627) + 0.25D0*MB*(Z(557)-4*Z(558)*Z(231)-4*Z(559)*Z(3))
     & - MC*(Z(561)*Z(26)+2*Z(560)*Z(3)-Z(562)-Z(563)-Z(565)*Z(5)) - MD*
     &(Z(566)*Z(26)+2*Z(560)*Z(3)-Z(562)-Z(563)-Z(570)*Z(5)) - ME*(Z(566
     &)*Z(26)+2*Z(560)*Z(3)-Z(562)-Z(563)-Z(570)*Z(5)) - MF*(Z(566)*Z(26
     &)+2*Z(560)*Z(3)-Z(562)-Z(563)-Z(570)*Z(5)) - MG*(Z(566)*Z(26)+2*Z(
     &560)*Z(3)-Z(562)-Z(563)-Z(570)*Z(5)) - MH*(Z(566)*Z(26)+2*Z(560)*Z
     &(3)-Z(562)-Z(563)-Z(570)*Z(5)) - MI*(Z(566)*Z(26)+2*Z(560)*Z(3)-Z(
     &562)-Z(563)-Z(570)*Z(5))
      Z(631) = Z(627) + 0.25D0*MB*(Z(557)-4*Z(558)*Z(231)-4*Z(559)*Z(3))
     & - MC*(Z(561)*Z(26)+2*Z(560)*Z(3)-Z(562)-Z(563)-Z(565)*Z(5)) - MD*
     &(Z(566)*Z(26)+Z(567)*Z(237)+2*Z(560)*Z(3)-Z(562)-Z(563)-Z(570)*Z(5
     &)-Z(571)*Z(241)) - ME*(Z(566)*Z(26)+Z(573)*Z(237)+2*Z(560)*Z(3)-Z(
     &562)-Z(563)-Z(570)*Z(5)-Z(577)*Z(241)) - MF*(Z(566)*Z(26)+Z(573)*Z
     &(237)+2*Z(560)*Z(3)-Z(562)-Z(563)-Z(570)*Z(5)-Z(577)*Z(241)) - MG*
     &(Z(566)*Z(26)+Z(573)*Z(237)+2*Z(560)*Z(3)-Z(562)-Z(563)-Z(570)*Z(5
     &)-Z(577)*Z(241)) - MH*(Z(566)*Z(26)+Z(573)*Z(237)+2*Z(560)*Z(3)-Z(
     &562)-Z(563)-Z(570)*Z(5)-Z(577)*Z(241)) - MI*(Z(566)*Z(26)+Z(573)*Z
     &(237)+2*Z(560)*Z(3)-Z(562)-Z(563)-Z(570)*Z(5)-Z(577)*Z(241))
      Z(634) = Z(633) + 0.25D0*MB*(Z(557)-4*Z(558)*Z(231)-4*Z(559)*Z(3))
     & - MC*(2*Z(560)*Z(3)+2*Z(561)*Z(26)-Z(562)-Z(563)-Z(564)-2*Z(565)*
     &Z(5)) - MD*(2*Z(560)*Z(3)+2*Z(566)*Z(26)-Z(562)-Z(563)-Z(568)-2*Z(
     &570)*Z(5)) - ME*(2*Z(560)*Z(3)+2*Z(566)*Z(26)-Z(562)-Z(563)-Z(568)
     &-2*Z(570)*Z(5)) - MF*(2*Z(560)*Z(3)+2*Z(566)*Z(26)-Z(562)-Z(563)-Z
     &(568)-2*Z(570)*Z(5)) - MG*(2*Z(560)*Z(3)+2*Z(566)*Z(26)-Z(562)-Z(5
     &63)-Z(568)-2*Z(570)*Z(5)) - MH*(2*Z(560)*Z(3)+2*Z(566)*Z(26)-Z(562
     &)-Z(563)-Z(568)-2*Z(570)*Z(5)) - MI*(2*Z(560)*Z(3)+2*Z(566)*Z(26)-
     &Z(562)-Z(563)-Z(568)-2*Z(570)*Z(5))
      Z(635) = Z(633) + 0.25D0*MB*(Z(557)-4*Z(558)*Z(231)-4*Z(559)*Z(3))
     & - MC*(2*Z(560)*Z(3)+2*Z(561)*Z(26)-Z(562)-Z(563)-Z(564)-2*Z(565)*
     &Z(5)) - MD*(Z(567)*Z(237)+2*Z(560)*Z(3)+2*Z(566)*Z(26)-Z(562)-Z(56
     &3)-Z(568)-2*Z(570)*Z(5)-Z(571)*Z(241)-Z(572)*Z(9)) - ME*(Z(573)*Z(
     &237)+2*Z(560)*Z(3)+2*Z(566)*Z(26)-Z(562)-Z(563)-Z(568)-2*Z(570)*Z(
     &5)-Z(577)*Z(241)-Z(578)*Z(9)) - MF*(Z(573)*Z(237)+2*Z(560)*Z(3)+2*
     &Z(566)*Z(26)-Z(562)-Z(563)-Z(568)-2*Z(570)*Z(5)-Z(577)*Z(241)-Z(57
     &8)*Z(9)) - MG*(Z(573)*Z(237)+2*Z(560)*Z(3)+2*Z(566)*Z(26)-Z(562)-Z
     &(563)-Z(568)-2*Z(570)*Z(5)-Z(577)*Z(241)-Z(578)*Z(9)) - MH*(Z(573)
     &*Z(237)+2*Z(560)*Z(3)+2*Z(566)*Z(26)-Z(562)-Z(563)-Z(568)-2*Z(570)
     &*Z(5)-Z(577)*Z(241)-Z(578)*Z(9)) - MI*(Z(573)*Z(237)+2*Z(560)*Z(3)
     &+2*Z(566)*Z(26)-Z(562)-Z(563)-Z(568)-2*Z(570)*Z(5)-Z(577)*Z(241)-Z
     &(578)*Z(9))
      Z(638) = Z(637) + 0.25D0*MB*(Z(557)-4*Z(558)*Z(231)-4*Z(559)*Z(3))
     & - MC*(2*Z(560)*Z(3)+2*Z(561)*Z(26)-Z(562)-Z(563)-Z(564)-2*Z(565)*
     &Z(5)) - MD*(2*Z(560)*Z(3)+2*Z(566)*Z(26)+2*Z(567)*Z(237)-Z(562)-Z(
     &563)-Z(568)-Z(569)-2*Z(570)*Z(5)-2*Z(571)*Z(241)-2*Z(572)*Z(9)) - 
     &ME*(2*Z(560)*Z(3)+2*Z(566)*Z(26)+2*Z(573)*Z(237)-Z(562)-Z(563)-Z(5
     &68)-Z(575)-2*Z(570)*Z(5)-2*Z(577)*Z(241)-2*Z(578)*Z(9)) - MF*(2*Z(
     &560)*Z(3)+2*Z(566)*Z(26)+2*Z(573)*Z(237)-Z(562)-Z(563)-Z(568)-Z(57
     &5)-2*Z(570)*Z(5)-2*Z(577)*Z(241)-2*Z(578)*Z(9)) - MG*(2*Z(560)*Z(3
     &)+2*Z(566)*Z(26)+2*Z(573)*Z(237)-Z(562)-Z(563)-Z(568)-Z(575)-2*Z(5
     &70)*Z(5)-2*Z(577)*Z(241)-2*Z(578)*Z(9)) - MH*(2*Z(560)*Z(3)+2*Z(56
     &6)*Z(26)+2*Z(573)*Z(237)-Z(562)-Z(563)-Z(568)-Z(575)-2*Z(570)*Z(5)
     &-2*Z(577)*Z(241)-2*Z(578)*Z(9)) - MI*(2*Z(560)*Z(3)+2*Z(566)*Z(26)
     &+2*Z(573)*Z(237)-Z(562)-Z(563)-Z(568)-Z(575)-2*Z(570)*Z(5)-2*Z(577
     &)*Z(241)-2*Z(578)*Z(9))

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
      Z(40) = Z(15)*Z(17) + Z(16)*Z(18)
      Z(41) = Z(16)*Z(17) - Z(15)*Z(18)
      Z(42) = Z(15)*Z(18) - Z(16)*Z(17)
      Z(43) = Z(13)*Z(1) + Z(14)*Z(2)
      Z(44) = Z(13)*Z(2) - Z(14)*Z(1)
      Z(45) = Z(14)*Z(1) - Z(13)*Z(2)
      Z(46) = Z(40)*Z(43) + Z(41)*Z(45)
      Z(47) = Z(40)*Z(44) + Z(41)*Z(43)
      Z(48) = Z(40)*Z(45) + Z(42)*Z(43)
      Z(49) = Z(40)*Z(43) + Z(42)*Z(44)
      Z(58) = -Z(15)*Z(43) - Z(16)*Z(45)
      Z(59) = -Z(15)*Z(44) - Z(16)*Z(43)
      Z(60) = Z(16)*Z(43) - Z(15)*Z(45)
      Z(61) = Z(16)*Z(44) - Z(15)*Z(43)
      Z(62) = Z(7)*Z(46) - Z(8)*Z(48)
      Z(63) = Z(7)*Z(47) - Z(8)*Z(49)
      Z(64) = Z(7)*Z(48) + Z(8)*Z(46)
      Z(65) = Z(7)*Z(49) + Z(8)*Z(47)
      Z(66) = Z(20)*Z(48) - Z(19)*Z(46)
      Z(67) = Z(20)*Z(49) - Z(19)*Z(47)
      Z(68) = -Z(19)*Z(48) - Z(20)*Z(46)
      Z(69) = -Z(19)*Z(49) - Z(20)*Z(47)
      Z(115) = U8 - EAp
      Z(117) = FApp - EApp
      Z(123) = FApp - EApp - HApp
      Z(129) = FApp - EApp - IApp
      Z(131) = Z(1)*Z(68) + Z(2)*Z(69)
      Z(132) = Z(1)*Z(67) - Z(2)*Z(66)
      Z(133) = Z(1)*Z(69) - Z(2)*Z(68)
      Z(139) = Z(21)*EAp
      Z(140) = L10*EAp
      Z(141) = Z(22)*(EAp-FAp)
      Z(142) = L8*(EAp-FAp)
      Z(143) = Z(1)*Z(62) + Z(2)*Z(63)
      Z(144) = Z(1)*Z(64) + Z(2)*Z(65)
      Z(145) = Z(1)*Z(63) - Z(2)*Z(62)
      Z(146) = Z(1)*Z(65) - Z(2)*Z(64)
      Z(147) = Z(24)*(FAp-EAp-HAp)
      Z(148) = L3*(FAp-EAp-HAp)
      Z(149) = Z(25)*(FAp-EAp-IAp)
      Z(172) = U10 - HAp
      Z(173) = FAp + U9
      Z(185) = Z(21)*U3 + Z(21)*U8 - Z(139)
      Z(186) = Z(21)*EApp
      Z(187) = Z(185)*(U3+Z(115))
      Z(188) = L10*U3 + L10*U8 - Z(140)
      Z(189) = L10*EApp
      Z(190) = Z(188)*(U3+Z(115))
      Z(191) = Z(22)*U3 + Z(22)*U8 + Z(22)*U9 - Z(141)
      Z(192) = Z(22)*(EApp-FApp)
      Z(193) = Z(191)*(U3+Z(115)+Z(173))
      Z(194) = L8*U3 + L8*U8 + L8*U9 - Z(142)
      Z(195) = L8*(EApp-FApp)
      Z(196) = Z(194)*(U3+Z(115)+Z(173))
      Z(197) = GS*U3
      Z(198) = GSp*U3
      Z(199) = GSpp - U3*Z(197)
      Z(200) = GSp*U3 + Z(198)
      Z(203) = Z(147) + Z(24)*U10 + Z(24)*U3 + Z(24)*U8 + Z(24)*U9
      Z(204) = -0.5D0*Z(148) - 0.5D0*L3*U10 - 0.5D0*L3*U3 - 0.5D0*L3*U8 
     &- 0.5D0*L3*U9
      Z(205) = Z(24)*(FApp-EApp-HApp)
      Z(206) = L3*(FApp-EApp-HApp)
      Z(207) = Z(203)*(U3+Z(115)+Z(172)+Z(173))
      Z(208) = Z(204)*(U3+Z(115)+Z(172)+Z(173))
      Z(211) = Z(149) + Z(25)*U11 + Z(25)*U3 + Z(25)*U8 + Z(25)*U9
      Z(212) = Z(25)*(FApp-EApp-IApp)
      Z(213) = U11 - IAp
      Z(214) = Z(211)*(U3+Z(115)+Z(173)+Z(213))
      Z(242) = Z(36)*Z(43) + Z(37)*Z(44)
      Z(243) = Z(36)*Z(45) + Z(37)*Z(43)
      Z(244) = Z(38)*Z(43) + Z(39)*Z(44)
      Z(245) = Z(38)*Z(45) + Z(39)*Z(43)
      Z(246) = Z(3)*Z(242) + Z(4)*Z(244)
      Z(247) = Z(3)*Z(243) + Z(4)*Z(245)
      Z(248) = Z(3)*Z(244) - Z(4)*Z(242)
      Z(249) = Z(3)*Z(245) - Z(4)*Z(243)
      Z(250) = Z(5)*Z(246) + Z(6)*Z(248)
      Z(251) = Z(5)*Z(247) + Z(6)*Z(249)
      Z(252) = Z(5)*Z(248) - Z(6)*Z(246)
      Z(253) = Z(5)*Z(249) - Z(6)*Z(247)
      Z(255) = Z(9)*Z(251) + Z(10)*Z(253)
      Z(256) = Z(9)*Z(252) - Z(10)*Z(250)
      Z(257) = Z(9)*Z(253) - Z(10)*Z(251)
      Z(258) = Z(36)*Z(58) + Z(37)*Z(59)
      Z(259) = Z(36)*Z(60) + Z(37)*Z(61)
      Z(260) = Z(38)*Z(58) + Z(39)*Z(59)
      Z(261) = Z(38)*Z(60) + Z(39)*Z(61)
      Z(262) = Z(3)*Z(258) + Z(4)*Z(260)
      Z(263) = Z(3)*Z(259) + Z(4)*Z(261)
      Z(264) = Z(3)*Z(260) - Z(4)*Z(258)
      Z(265) = Z(3)*Z(261) - Z(4)*Z(259)
      Z(266) = Z(5)*Z(262) + Z(6)*Z(264)
      Z(267) = Z(5)*Z(263) + Z(6)*Z(265)
      Z(268) = Z(5)*Z(264) - Z(6)*Z(262)
      Z(269) = Z(5)*Z(265) - Z(6)*Z(263)
      Z(271) = Z(9)*Z(267) + Z(10)*Z(269)
      Z(272) = Z(9)*Z(268) - Z(10)*Z(266)
      Z(273) = Z(9)*Z(269) - Z(10)*Z(267)
      Z(274) = Z(36)*Z(46) + Z(37)*Z(47)
      Z(275) = Z(36)*Z(48) + Z(37)*Z(49)
      Z(276) = Z(38)*Z(46) + Z(39)*Z(47)
      Z(277) = Z(38)*Z(48) + Z(39)*Z(49)
      Z(278) = Z(36)*Z(62) + Z(37)*Z(63)
      Z(279) = Z(36)*Z(64) + Z(37)*Z(65)
      Z(280) = Z(38)*Z(62) + Z(39)*Z(63)
      Z(281) = Z(38)*Z(64) + Z(39)*Z(65)
      Z(282) = Z(3)*Z(274) + Z(4)*Z(276)
      Z(283) = Z(3)*Z(275) + Z(4)*Z(277)
      Z(284) = Z(3)*Z(276) - Z(4)*Z(274)
      Z(285) = Z(3)*Z(277) - Z(4)*Z(275)
      Z(286) = Z(3)*Z(278) + Z(4)*Z(280)
      Z(287) = Z(3)*Z(279) + Z(4)*Z(281)
      Z(288) = Z(3)*Z(280) - Z(4)*Z(278)
      Z(289) = Z(3)*Z(281) - Z(4)*Z(279)
      Z(290) = Z(5)*Z(282) + Z(6)*Z(284)
      Z(291) = Z(5)*Z(283) + Z(6)*Z(285)
      Z(292) = Z(5)*Z(284) - Z(6)*Z(282)
      Z(293) = Z(5)*Z(285) - Z(6)*Z(283)
      Z(294) = Z(5)*Z(286) + Z(6)*Z(288)
      Z(295) = Z(5)*Z(287) + Z(6)*Z(289)
      Z(296) = Z(5)*Z(288) - Z(6)*Z(286)
      Z(297) = Z(5)*Z(289) - Z(6)*Z(287)
      Z(299) = Z(9)*Z(291) + Z(10)*Z(293)
      Z(300) = Z(9)*Z(292) - Z(10)*Z(290)
      Z(301) = Z(9)*Z(293) - Z(10)*Z(291)
      Z(303) = Z(9)*Z(295) + Z(10)*Z(297)
      Z(304) = Z(9)*Z(296) - Z(10)*Z(294)
      Z(305) = Z(9)*Z(297) - Z(10)*Z(295)
      Z(306) = Z(13)*Z(143) - Z(14)*Z(145)
      Z(307) = Z(13)*Z(144) - Z(14)*Z(146)
      Z(308) = Z(13)*Z(145) + Z(14)*Z(143)
      Z(309) = Z(13)*Z(146) + Z(14)*Z(144)
      Z(311) = -Z(15)*Z(307) - Z(16)*Z(309)
      Z(312) = Z(16)*Z(306) - Z(15)*Z(308)
      Z(313) = Z(16)*Z(307) - Z(15)*Z(309)
      Z(314) = Z(36)*Z(66) + Z(37)*Z(67)
      Z(315) = Z(36)*Z(68) + Z(37)*Z(69)
      Z(316) = Z(38)*Z(66) + Z(39)*Z(67)
      Z(317) = Z(38)*Z(68) + Z(39)*Z(69)
      Z(318) = Z(3)*Z(314) + Z(4)*Z(316)
      Z(319) = Z(3)*Z(315) + Z(4)*Z(317)
      Z(320) = Z(3)*Z(316) - Z(4)*Z(314)
      Z(321) = Z(3)*Z(317) - Z(4)*Z(315)
      Z(322) = Z(5)*Z(318) + Z(6)*Z(320)
      Z(323) = Z(5)*Z(319) + Z(6)*Z(321)
      Z(324) = Z(5)*Z(320) - Z(6)*Z(318)
      Z(325) = Z(5)*Z(321) - Z(6)*Z(319)
      Z(327) = Z(9)*Z(323) + Z(10)*Z(325)
      Z(328) = Z(9)*Z(324) - Z(10)*Z(322)
      Z(329) = Z(9)*Z(325) - Z(10)*Z(323)
      Z(507) = HTOR + Z(228) + Z(229) + Z(230) + L10*VRX1*Z(56) + L10*VR
     &Y1*Z(57) + L11*VRY1*Z(1) + L6*VRX1*Z(52) + L6*VRY1*Z(53) + L8*VRX1
     &*Z(34) + L8*VRY1*Z(35) - MTOR - Z(506)*Z(39) - L11*VRX1*Z(2) - L2*
     &VRX1*Z(38) - L2*VRY1*Z(39) - L2*(RX2*Z(38)+RY2*Z(39)) - Z(220)*(L2
     &*Z(39)-L6*Z(53)-L7*Z(35)) - 0.5D0*Z(219)*(2*L2*Z(39)-L3*Z(86)-L4*Z
     &(53)) - Z(221)*(L2*Z(39)-L6*Z(53)-L8*Z(35)-L9*Z(57)) - Z(222)*(L2*
     &Z(39)-L10*Z(57)-L6*Z(53)-L8*Z(35)-Z(21)*Z(43)) - Z(224)*(L2*Z(39)-
     &L10*Z(57)-L6*Z(53)-L8*Z(35)-GS*Z(1)) - Z(223)*(L2*Z(39)-L10*Z(43)-
     &L10*Z(57)-L6*Z(53)-L8*Z(35)-Z(22)*Z(61)) - Z(226)*(L2*Z(39)-L10*Z(
     &57)-L11*Z(1)-L6*Z(53)-L8*Z(35)-Z(25)*Z(69)) - Z(227)*(L2*Z(39)-L10
     &*Z(57)-L11*Z(1)-L2*Z(69)-L6*Z(53)-L8*Z(35)) - 0.5D0*Z(225)*(L3*Z(6
     &5)+2*L2*Z(39)-2*L10*Z(43)-2*L10*Z(57)-2*L6*Z(53)-2*L8*Z(35)-2*L8*Z
     &(61)-2*Z(24)*Z(49))
      Z(536) = INE*EApp
      Z(538) = INF*Z(117)
      Z(540) = INH*Z(123)
      Z(542) = INI*Z(129)
      Z(543) = MG*(L10*Z(56)+L6*Z(52)+L8*Z(34)-L2*Z(38)-GS*Z(2)) - Z(457
     &)*Z(38) - MC*(L2*Z(38)-L6*Z(52)-L7*Z(34)) - 0.5D0*MB*(2*L2*Z(38)-L
     &3*Z(85)-L4*Z(52)) - MD*(L2*Z(38)-L6*Z(52)-L8*Z(34)-L9*Z(56)) - ME*
     &(L2*Z(38)-L10*Z(56)-L6*Z(52)-L8*Z(34)-Z(21)*Z(45)) - MI*(L11*Z(2)+
     &L2*Z(38)-L10*Z(56)-L6*Z(52)-L8*Z(34)-Z(25)*Z(68)) - MF*(L2*Z(38)-L
     &10*Z(45)-L10*Z(56)-L6*Z(52)-L8*Z(34)-Z(22)*Z(60)) - 0.5D0*MH*(L3*Z
     &(64)+2*L2*Z(38)-2*L10*Z(45)-2*L10*Z(56)-2*L6*Z(52)-2*L8*Z(34)-2*L8
     &*Z(60)-2*Z(24)*Z(48))
      Z(549) = MA*Z(36)*Z(163) + MC*(Z(36)*Z(165)-Z(32)*Z(178)-Z(50)*Z(1
     &76)) + 0.5D0*MB*(2*Z(36)*Z(165)-Z(50)*Z(168)-Z(83)*Z(169)) + MD*(Z
     &(36)*Z(165)-Z(32)*Z(180)-Z(50)*Z(176)-Z(54)*Z(182)) + MG*(Z(1)*Z(1
     &99)+Z(36)*Z(165)-Z(2)*Z(200)-Z(32)*Z(180)-Z(50)*Z(176)-Z(54)*Z(184
     &)) + ME*(Z(36)*Z(165)-Z(186)*Z(45)-Z(32)*Z(180)-Z(43)*Z(187)-Z(50)
     &*Z(176)-Z(54)*Z(184)) + MI*(Z(212)*Z(68)+Z(36)*Z(165)-Z(1)*Z(202)-
     &Z(32)*Z(180)-Z(50)*Z(176)-Z(54)*Z(184)-Z(66)*Z(214)) + MF*(Z(36)*Z
     &(165)-Z(189)*Z(45)-Z(192)*Z(60)-Z(32)*Z(180)-Z(43)*Z(190)-Z(50)*Z(
     &176)-Z(54)*Z(184)-Z(58)*Z(193)) + 0.5D0*MH*(2*Z(205)*Z(48)+2*Z(36)
     &*Z(165)-2*Z(189)*Z(45)-2*Z(195)*Z(60)-Z(206)*Z(64)-2*Z(32)*Z(180)-
     &2*Z(43)*Z(190)-2*Z(46)*Z(207)-2*Z(50)*Z(176)-2*Z(54)*Z(184)-2*Z(58
     &)*Z(196)-2*Z(62)*Z(208))
      Z(550) = -Z(457)*Z(39) - MC*(L2*Z(39)-L6*Z(53)-L7*Z(35)) - 0.5D0*M
     &B*(2*L2*Z(39)-L3*Z(86)-L4*Z(53)) - MD*(L2*Z(39)-L6*Z(53)-L8*Z(35)-
     &L9*Z(57)) - ME*(L2*Z(39)-L10*Z(57)-L6*Z(53)-L8*Z(35)-Z(21)*Z(43)) 
     &- MG*(L2*Z(39)-L10*Z(57)-L6*Z(53)-L8*Z(35)-GS*Z(1)) - MF*(L2*Z(39)
     &-L10*Z(43)-L10*Z(57)-L6*Z(53)-L8*Z(35)-Z(22)*Z(61)) - MI*(L2*Z(39)
     &-L10*Z(57)-L11*Z(1)-L6*Z(53)-L8*Z(35)-Z(25)*Z(69)) - 0.5D0*MH*(L3*
     &Z(65)+2*L2*Z(39)-2*L10*Z(43)-2*L10*Z(57)-2*L6*Z(53)-2*L8*Z(35)-2*L
     &8*Z(61)-2*Z(24)*Z(49))
      Z(555) = MA*Z(37)*Z(163) + MC*(Z(37)*Z(165)-Z(33)*Z(178)-Z(51)*Z(1
     &76)) + 0.5D0*MB*(2*Z(37)*Z(165)-Z(51)*Z(168)-Z(84)*Z(169)) + MD*(Z
     &(37)*Z(165)-Z(33)*Z(180)-Z(51)*Z(176)-Z(55)*Z(182)) + MG*(Z(1)*Z(2
     &00)+Z(2)*Z(199)+Z(37)*Z(165)-Z(33)*Z(180)-Z(51)*Z(176)-Z(55)*Z(184
     &)) + ME*(Z(37)*Z(165)-Z(186)*Z(43)-Z(33)*Z(180)-Z(44)*Z(187)-Z(51)
     &*Z(176)-Z(55)*Z(184)) + MI*(Z(212)*Z(69)+Z(37)*Z(165)-Z(2)*Z(202)-
     &Z(33)*Z(180)-Z(51)*Z(176)-Z(55)*Z(184)-Z(67)*Z(214)) + MF*(Z(37)*Z
     &(165)-Z(189)*Z(43)-Z(192)*Z(61)-Z(33)*Z(180)-Z(44)*Z(190)-Z(51)*Z(
     &176)-Z(55)*Z(184)-Z(59)*Z(193)) + 0.5D0*MH*(2*Z(205)*Z(49)+2*Z(37)
     &*Z(165)-2*Z(189)*Z(43)-2*Z(195)*Z(61)-Z(206)*Z(65)-2*Z(33)*Z(180)-
     &2*Z(44)*Z(190)-2*Z(47)*Z(207)-2*Z(51)*Z(176)-2*Z(55)*Z(184)-2*Z(59
     &)*Z(196)-2*Z(63)*Z(208))
      Z(608) = Z(556) + 0.25D0*MB*(Z(557)-4*Z(558)*Z(231)-4*Z(559)*Z(3))
     & - MC*(2*Z(560)*Z(3)+2*Z(561)*Z(26)-Z(562)-Z(563)-Z(564)-2*Z(565)*
     &Z(5)) - MD*(2*Z(560)*Z(3)+2*Z(566)*Z(26)+2*Z(567)*Z(237)-Z(562)-Z(
     &563)-Z(568)-Z(569)-2*Z(570)*Z(5)-2*Z(571)*Z(241)-2*Z(572)*Z(9)) - 
     &ME*(2*Z(560)*Z(3)+2*Z(566)*Z(26)+2*Z(573)*Z(237)+2*Z(574)*Z(245)-Z
     &(562)-Z(563)-Z(568)-Z(575)-Z(576)-2*Z(570)*Z(5)-2*Z(577)*Z(241)-2*
     &Z(578)*Z(9)-2*Z(579)*Z(257)-2*Z(580)*Z(249)-2*Z(581)*Z(253)) - MG*
     &(2*Z(560)*Z(3)+2*Z(566)*Z(26)+2*Z(573)*Z(237)+2*L2*GS*Z(108)-Z(562
     &)-Z(563)-Z(568)-Z(575)-GS**2-2*Z(570)*Z(5)-2*Z(577)*Z(241)-2*Z(578
     &)*Z(9)-2*L10*GS*Z(11)-2*L6*GS*Z(113)-2*L8*GS*Z(29)) - MF*(2*Z(582)
     &*Z(15)+2*Z(560)*Z(3)+2*Z(566)*Z(26)+2*Z(573)*Z(237)+2*Z(573)*Z(245
     &)+2*Z(583)*Z(261)-2*Z(575)-Z(562)-Z(563)-Z(568)-Z(584)-2*Z(570)*Z(
     &5)-2*Z(575)*Z(257)-2*Z(577)*Z(241)-2*Z(577)*Z(249)-2*Z(578)*Z(9)-2
     &*Z(578)*Z(253)-2*Z(582)*Z(273)-2*Z(585)*Z(265)-2*Z(586)*Z(269)) - 
     &MI*(2*Z(560)*Z(3)+2*Z(566)*Z(26)+2*Z(573)*Z(237)+2*Z(587)*Z(108)+2
     &*Z(588)*Z(317)-Z(562)-Z(563)-Z(568)-Z(575)-Z(589)-Z(590)-2*Z(570)*
     &Z(5)-2*Z(577)*Z(241)-2*Z(578)*Z(9)-2*Z(591)*Z(11)-2*Z(592)*Z(329)-
     &2*Z(593)*Z(113)-2*Z(594)*Z(29)-2*Z(595)*Z(133)-2*Z(596)*Z(321)-2*Z
     &(597)*Z(325)) - 0.25D0*MH*(4*Z(598)+8*Z(578)*Z(15)+8*Z(599)*Z(17)+
     &4*Z(600)*Z(305)+4*Z(600)*Z(309)+4*Z(601)*Z(289)+4*Z(602)*Z(297)+4*
     &Z(602)*Z(313)+8*Z(560)*Z(3)+8*Z(566)*Z(26)+8*Z(566)*Z(261)+8*Z(573
     &)*Z(237)+8*Z(573)*Z(245)+8*Z(603)*Z(277)-8*Z(568)-8*Z(575)-4*Z(562
     &)-4*Z(563)-4*Z(605)-Z(604)-8*Z(606)*Z(40)-8*Z(568)*Z(269)-8*Z(570)
     &*Z(5)-8*Z(570)*Z(265)-8*Z(575)*Z(257)-8*Z(577)*Z(241)-8*Z(577)*Z(2
     &49)-8*Z(578)*Z(9)-8*Z(578)*Z(253)-8*Z(578)*Z(273)-8*Z(599)*Z(293)-
     &8*Z(606)*Z(301)-8*Z(607)*Z(285)-4*Z(558)*Z(281))
      Z(610) = Z(609) - Z(461)*(L2-L6*Z(3)-L7*Z(26)) - 0.5D0*Z(458)*(2*L
     &2-L3*Z(231)-L4*Z(3)) - Z(464)*(L2-L6*Z(3)-L8*Z(26)-L9*Z(237)) - Z(
     &468)*(L2-L10*Z(237)-L6*Z(3)-L8*Z(26)-Z(21)*Z(245)) - Z(481)*(L2-L1
     &0*Z(237)-L6*Z(3)-L8*Z(26)-GS*Z(108)) - Z(474)*(L2-L10*Z(237)-L10*Z
     &(245)-L6*Z(3)-L8*Z(26)-Z(22)*Z(261)) - Z(497)*(L2-L10*Z(237)-L11*Z
     &(108)-L6*Z(3)-L8*Z(26)-Z(25)*Z(317)) - 0.5D0*Z(487)*(2*L2+L3*Z(281
     &)-2*L10*Z(237)-2*L10*Z(245)-2*L6*Z(3)-2*L8*Z(26)-2*L8*Z(261)-2*Z(2
     &4)*Z(277))
      Z(612) = MC*(Z(561)*Z(26)+2*Z(560)*Z(3)-Z(562)-Z(563)-Z(565)*Z(5))
     & + MD*(Z(566)*Z(26)+Z(567)*Z(237)+2*Z(560)*Z(3)-Z(562)-Z(563)-Z(57
     &0)*Z(5)-Z(571)*Z(241)) + ME*(Z(566)*Z(26)+Z(573)*Z(237)+Z(574)*Z(2
     &45)+2*Z(560)*Z(3)-Z(562)-Z(563)-Z(570)*Z(5)-Z(577)*Z(241)-Z(580)*Z
     &(249)) + MG*(Z(566)*Z(26)+Z(573)*Z(237)+2*Z(560)*Z(3)+L2*GS*Z(108)
     &-Z(562)-Z(563)-Z(570)*Z(5)-Z(577)*Z(241)-L6*GS*Z(113)) + MF*(Z(566
     &)*Z(26)+Z(573)*Z(237)+Z(573)*Z(245)+Z(583)*Z(261)+2*Z(560)*Z(3)-Z(
     &562)-Z(563)-Z(570)*Z(5)-Z(577)*Z(241)-Z(577)*Z(249)-Z(585)*Z(265))
     & + MI*(Z(566)*Z(26)+Z(573)*Z(237)+Z(587)*Z(108)+Z(588)*Z(317)+2*Z(
     &560)*Z(3)-Z(562)-Z(563)-Z(570)*Z(5)-Z(577)*Z(241)-Z(593)*Z(113)-Z(
     &596)*Z(321)) + 0.5D0*MH*(Z(601)*Z(289)+2*Z(566)*Z(26)+2*Z(566)*Z(2
     &61)+2*Z(573)*Z(237)+2*Z(573)*Z(245)+2*Z(603)*Z(277)+4*Z(560)*Z(3)-
     &2*Z(562)-2*Z(563)-2*Z(570)*Z(5)-2*Z(570)*Z(265)-2*Z(577)*Z(241)-2*
     &Z(577)*Z(249)-2*Z(607)*Z(285)-Z(558)*Z(281)) - INA - INB - Z(611) 
     &- 0.25D0*MB*(Z(557)-4*Z(558)*Z(231)-4*Z(559)*Z(3))
      Z(613) = MC*(2*Z(560)*Z(3)+2*Z(561)*Z(26)-Z(562)-Z(563)-Z(564)-2*Z
     &(565)*Z(5)) + MD*(Z(567)*Z(237)+2*Z(560)*Z(3)+2*Z(566)*Z(26)-Z(562
     &)-Z(563)-Z(568)-2*Z(570)*Z(5)-Z(571)*Z(241)-Z(572)*Z(9)) + ME*(Z(5
     &73)*Z(237)+Z(574)*Z(245)+2*Z(560)*Z(3)+2*Z(566)*Z(26)-Z(562)-Z(563
     &)-Z(568)-2*Z(570)*Z(5)-Z(577)*Z(241)-Z(578)*Z(9)-Z(580)*Z(249)-Z(5
     &81)*Z(253)) + MG*(Z(573)*Z(237)+2*Z(560)*Z(3)+2*Z(566)*Z(26)+L2*GS
     &*Z(108)-Z(562)-Z(563)-Z(568)-2*Z(570)*Z(5)-Z(577)*Z(241)-Z(578)*Z(
     &9)-L6*GS*Z(113)-L8*GS*Z(29)) + MF*(Z(573)*Z(237)+Z(573)*Z(245)+Z(5
     &83)*Z(261)+2*Z(560)*Z(3)+2*Z(566)*Z(26)-Z(562)-Z(563)-Z(568)-2*Z(5
     &70)*Z(5)-Z(577)*Z(241)-Z(577)*Z(249)-Z(578)*Z(9)-Z(578)*Z(253)-Z(5
     &85)*Z(265)-Z(586)*Z(269)) + MI*(Z(573)*Z(237)+Z(587)*Z(108)+Z(588)
     &*Z(317)+2*Z(560)*Z(3)+2*Z(566)*Z(26)-Z(562)-Z(563)-Z(568)-2*Z(570)
     &*Z(5)-Z(577)*Z(241)-Z(578)*Z(9)-Z(593)*Z(113)-Z(594)*Z(29)-Z(596)*
     &Z(321)-Z(597)*Z(325)) + 0.5D0*MH*(Z(601)*Z(289)+Z(602)*Z(297)+2*Z(
     &566)*Z(261)+2*Z(573)*Z(237)+2*Z(573)*Z(245)+2*Z(603)*Z(277)+4*Z(56
     &0)*Z(3)+4*Z(566)*Z(26)-2*Z(562)-2*Z(563)-2*Z(568)-4*Z(570)*Z(5)-2*
     &Z(568)*Z(269)-2*Z(570)*Z(265)-2*Z(577)*Z(241)-2*Z(577)*Z(249)-2*Z(
     &578)*Z(9)-2*Z(578)*Z(253)-2*Z(599)*Z(293)-2*Z(607)*Z(285)-Z(558)*Z
     &(281)) - INA - INB - INC - Z(611) - 0.25D0*MB*(Z(557)-4*Z(558)*Z(2
     &31)-4*Z(559)*Z(3))
      Z(614) = MC*(2*Z(560)*Z(3)+2*Z(561)*Z(26)-Z(562)-Z(563)-Z(564)-2*Z
     &(565)*Z(5)) + MD*(2*Z(560)*Z(3)+2*Z(566)*Z(26)+2*Z(567)*Z(237)-Z(5
     &62)-Z(563)-Z(568)-Z(569)-2*Z(570)*Z(5)-2*Z(571)*Z(241)-2*Z(572)*Z(
     &9)) + ME*(Z(574)*Z(245)+2*Z(560)*Z(3)+2*Z(566)*Z(26)+2*Z(573)*Z(23
     &7)-Z(562)-Z(563)-Z(568)-Z(575)-2*Z(570)*Z(5)-2*Z(577)*Z(241)-2*Z(5
     &78)*Z(9)-Z(579)*Z(257)-Z(580)*Z(249)-Z(581)*Z(253)) + MG*(2*Z(560)
     &*Z(3)+2*Z(566)*Z(26)+2*Z(573)*Z(237)+L2*GS*Z(108)-Z(562)-Z(563)-Z(
     &568)-Z(575)-2*Z(570)*Z(5)-2*Z(577)*Z(241)-2*Z(578)*Z(9)-L10*GS*Z(1
     &1)-L6*GS*Z(113)-L8*GS*Z(29)) + MF*(Z(573)*Z(245)+Z(583)*Z(261)+2*Z
     &(560)*Z(3)+2*Z(566)*Z(26)+2*Z(573)*Z(237)-Z(562)-Z(563)-Z(568)-Z(5
     &75)-2*Z(570)*Z(5)-2*Z(577)*Z(241)-2*Z(578)*Z(9)-Z(575)*Z(257)-Z(57
     &7)*Z(249)-Z(578)*Z(253)-Z(582)*Z(273)-Z(585)*Z(265)-Z(586)*Z(269))
     & + MI*(Z(587)*Z(108)+Z(588)*Z(317)+2*Z(560)*Z(3)+2*Z(566)*Z(26)+2*
     &Z(573)*Z(237)-Z(562)-Z(563)-Z(568)-Z(575)-2*Z(570)*Z(5)-2*Z(577)*Z
     &(241)-2*Z(578)*Z(9)-Z(591)*Z(11)-Z(592)*Z(329)-Z(593)*Z(113)-Z(594
     &)*Z(29)-Z(596)*Z(321)-Z(597)*Z(325)) + 0.5D0*MH*(Z(600)*Z(305)+Z(6
     &01)*Z(289)+Z(602)*Z(297)+2*Z(566)*Z(261)+2*Z(573)*Z(245)+2*Z(603)*
     &Z(277)+4*Z(560)*Z(3)+4*Z(566)*Z(26)+4*Z(573)*Z(237)-2*Z(562)-2*Z(5
     &63)-2*Z(568)-2*Z(575)-4*Z(570)*Z(5)-4*Z(577)*Z(241)-4*Z(578)*Z(9)-
     &2*Z(568)*Z(269)-2*Z(570)*Z(265)-2*Z(575)*Z(257)-2*Z(577)*Z(249)-2*
     &Z(578)*Z(253)-2*Z(578)*Z(273)-2*Z(599)*Z(293)-2*Z(606)*Z(301)-2*Z(
     &607)*Z(285)-Z(558)*Z(281)) - INA - INB - INC - IND - Z(611) - 0.25
     &D0*MB*(Z(557)-4*Z(558)*Z(231)-4*Z(559)*Z(3))
      Z(620) = Z(538) + Z(540) + Z(542) + 0.25D0*MB*(Z(615)*Z(168)+2*L2*
     &Z(4)*Z(168)+2*L2*Z(233)*Z(169)+2*L3*Z(232)*Z(165)-Z(616)*Z(169)-2*
     &L4*Z(4)*Z(165)) + MD*(L2*Z(4)*Z(176)+L2*Z(28)*Z(180)+L2*Z(236)*Z(1
     &82)+L8*Z(6)*Z(176)+L8*Z(27)*Z(165)+L9*Z(10)*Z(180)+L9*Z(235)*Z(165
     &)-L6*Z(4)*Z(165)-L6*Z(6)*Z(180)-L6*Z(240)*Z(182)-L8*Z(10)*Z(182)-L
     &9*Z(239)*Z(176)) + MG*(GS*Z(200)+L10*Z(10)*Z(180)+L10*Z(11)*Z(200)
     &+L10*Z(12)*Z(199)+L10*Z(235)*Z(165)+L2*Z(4)*Z(176)+L2*Z(28)*Z(180)
     &+L2*Z(236)*Z(184)+L6*Z(111)*Z(199)+L6*Z(113)*Z(200)+L8*Z(6)*Z(176)
     &+L8*Z(27)*Z(165)+L8*Z(29)*Z(200)+L8*Z(31)*Z(199)+GS*Z(12)*Z(184)+G
     &S*Z(107)*Z(165)-L10*Z(239)*Z(176)-L2*Z(106)*Z(199)-L2*Z(108)*Z(200
     &)-L6*Z(4)*Z(165)-L6*Z(6)*Z(180)-L6*Z(240)*Z(184)-L8*Z(10)*Z(184)-G
     &S*Z(30)*Z(180)-GS*Z(112)*Z(176)) + ME*(L2*Z(186)*Z(245)+L10*Z(10)*
     &Z(180)+L10*Z(235)*Z(165)+L2*Z(4)*Z(176)+L2*Z(28)*Z(180)+L2*Z(236)*
     &Z(184)+L2*Z(244)*Z(187)+L8*Z(6)*Z(176)+L8*Z(27)*Z(165)+Z(21)*Z(243
     &)*Z(165)-Z(21)*Z(186)-L10*Z(186)*Z(257)-L6*Z(186)*Z(249)-L8*Z(186)
     &*Z(253)-L10*Z(239)*Z(176)-L10*Z(256)*Z(187)-L6*Z(4)*Z(165)-L6*Z(6)
     &*Z(180)-L6*Z(240)*Z(184)-L6*Z(248)*Z(187)-L8*Z(10)*Z(184)-L8*Z(252
     &)*Z(187)-Z(21)*Z(247)*Z(176)-Z(21)*Z(251)*Z(180)-Z(21)*Z(255)*Z(18
     &4)) + MI*(Z(25)*Z(212)+L10*Z(212)*Z(329)+L11*Z(212)*Z(133)+L6*Z(21
     &2)*Z(321)+L8*Z(212)*Z(325)+L10*Z(10)*Z(180)+L10*Z(235)*Z(165)+L11*
     &Z(12)*Z(184)+L11*Z(107)*Z(165)+L2*Z(4)*Z(176)+L2*Z(28)*Z(180)+L2*Z
     &(106)*Z(202)+L2*Z(236)*Z(184)+L2*Z(316)*Z(214)+L8*Z(6)*Z(176)+L8*Z
     &(27)*Z(165)+Z(25)*Z(315)*Z(165)-L2*Z(212)*Z(317)-L10*Z(12)*Z(202)-
     &L10*Z(239)*Z(176)-L10*Z(328)*Z(214)-L11*Z(30)*Z(180)-L11*Z(112)*Z(
     &176)-L11*Z(132)*Z(214)-L6*Z(4)*Z(165)-L6*Z(6)*Z(180)-L6*Z(111)*Z(2
     &02)-L6*Z(240)*Z(184)-L6*Z(320)*Z(214)-L8*Z(10)*Z(184)-L8*Z(31)*Z(2
     &02)-L8*Z(324)*Z(214)-Z(25)*Z(131)*Z(202)-Z(25)*Z(319)*Z(176)-Z(25)
     &*Z(323)*Z(180)-Z(25)*Z(327)*Z(184)) + MF*(L10*Z(15)*Z(192)+Z(22)*Z
     &(15)*Z(189)+L2*Z(189)*Z(245)+L2*Z(192)*Z(261)+L10*Z(16)*Z(193)+L10
     &*Z(10)*Z(180)+L10*Z(235)*Z(165)+L10*Z(243)*Z(165)+L2*Z(4)*Z(176)+L
     &2*Z(28)*Z(180)+L2*Z(236)*Z(184)+L2*Z(244)*Z(190)+L2*Z(260)*Z(193)+
     &L8*Z(6)*Z(176)+L8*Z(27)*Z(165)+Z(22)*Z(259)*Z(165)-L10*Z(189)-Z(22
     &)*Z(192)-L10*Z(189)*Z(257)-L10*Z(192)*Z(273)-L6*Z(189)*Z(249)-L6*Z
     &(192)*Z(265)-L8*Z(189)*Z(253)-L8*Z(192)*Z(269)-L10*Z(239)*Z(176)-L
     &10*Z(247)*Z(176)-L10*Z(251)*Z(180)-L10*Z(255)*Z(184)-L10*Z(256)*Z(
     &190)-L10*Z(272)*Z(193)-L6*Z(4)*Z(165)-L6*Z(6)*Z(180)-L6*Z(240)*Z(1
     &84)-L6*Z(248)*Z(190)-L6*Z(264)*Z(193)-L8*Z(10)*Z(184)-L8*Z(252)*Z(
     &190)-L8*Z(268)*Z(193)-Z(22)*Z(16)*Z(190)-Z(22)*Z(263)*Z(176)-Z(22)
     &*Z(267)*Z(180)-Z(22)*Z(271)*Z(184)) + 0.25D0*MH*(L3*Z(206)+4*Z(24)
     &*Z(205)+4*L10*Z(15)*Z(195)+4*L10*Z(40)*Z(205)+4*L8*Z(15)*Z(189)+4*
     &Z(24)*Z(17)*Z(195)+2*L2*Z(206)*Z(281)+2*L3*Z(189)*Z(309)+2*L3*Z(19
     &5)*Z(313)+4*L10*Z(205)*Z(301)+4*L2*Z(189)*Z(245)+4*L2*Z(195)*Z(261
     &)+4*L6*Z(205)*Z(285)+4*L8*Z(205)*Z(293)+2*Z(615)*Z(207)+4*Z(617)*Z
     &(208)+2*L3*Z(287)*Z(176)+2*L3*Z(295)*Z(180)+2*L3*Z(303)*Z(184)+2*L
     &3*Z(307)*Z(190)+2*L3*Z(311)*Z(196)+4*L10*Z(16)*Z(196)+4*L10*Z(10)*
     &Z(180)+4*L10*Z(235)*Z(165)+4*L10*Z(243)*Z(165)+4*L2*Z(4)*Z(176)+4*
     &L2*Z(28)*Z(180)+4*L2*Z(236)*Z(184)+4*L2*Z(244)*Z(190)+4*L2*Z(260)*
     &Z(196)+4*L2*Z(276)*Z(207)+4*L2*Z(280)*Z(208)+4*L8*Z(6)*Z(176)+4*L8
     &*Z(27)*Z(165)+4*L8*Z(259)*Z(165)+4*Z(24)*Z(18)*Z(196)+4*Z(24)*Z(27
     &5)*Z(165)-4*L10*Z(189)-4*L8*Z(195)-2*Z(618)*Z(205)-2*Z(619)*Z(206)
     &-4*L8*Z(17)*Z(205)-4*Z(24)*Z(40)*Z(189)-4*L10*Z(189)*Z(257)-4*L10*
     &Z(195)*Z(273)-4*L2*Z(205)*Z(277)-4*L6*Z(189)*Z(249)-4*L6*Z(195)*Z(
     &265)-4*L8*Z(189)*Z(253)-4*L8*Z(195)*Z(269)-2*L10*Z(206)*Z(305)-2*L
     &10*Z(206)*Z(309)-2*L6*Z(206)*Z(289)-2*L8*Z(206)*Z(297)-2*L8*Z(206)
     &*Z(313)-4*L10*Z(41)*Z(207)-4*L10*Z(239)*Z(176)-4*L10*Z(247)*Z(176)
     &-4*L10*Z(251)*Z(180)-4*L10*Z(255)*Z(184)-4*L10*Z(256)*Z(190)-4*L10
     &*Z(272)*Z(196)-4*L10*Z(300)*Z(207)-4*L10*Z(304)*Z(208)-4*L10*Z(308
     &)*Z(208)-4*L6*Z(4)*Z(165)-4*L6*Z(6)*Z(180)-4*L6*Z(240)*Z(184)-4*L6
     &*Z(248)*Z(190)-4*L6*Z(264)*Z(196)-4*L6*Z(284)*Z(207)-4*L6*Z(288)*Z
     &(208)-4*L8*Z(16)*Z(190)-4*L8*Z(18)*Z(207)-4*L8*Z(10)*Z(184)-4*L8*Z
     &(252)*Z(190)-4*L8*Z(263)*Z(176)-4*L8*Z(267)*Z(180)-4*L8*Z(268)*Z(1
     &96)-4*L8*Z(271)*Z(184)-4*L8*Z(292)*Z(207)-4*L8*Z(296)*Z(208)-4*L8*
     &Z(312)*Z(208)-4*Z(24)*Z(42)*Z(190)-4*Z(24)*Z(283)*Z(176)-4*Z(24)*Z
     &(291)*Z(180)-4*Z(24)*Z(299)*Z(184)-2*L3*Z(279)*Z(165)) - Z(536) - 
     &MC*(L6*Z(4)*Z(165)+L6*Z(6)*Z(178)-L2*Z(4)*Z(176)-L2*Z(28)*Z(178)-L
     &7*Z(6)*Z(176)-L7*Z(27)*Z(165))
      Z(626) = L2*(MB*(Z(4)*Z(168)+Z(233)*Z(169))+2*MC*(Z(4)*Z(176)+Z(28
     &)*Z(178))+2*MD*(Z(4)*Z(176)+Z(28)*Z(180)+Z(236)*Z(182))+2*ME*(Z(18
     &6)*Z(245)+Z(4)*Z(176)+Z(28)*Z(180)+Z(236)*Z(184)+Z(244)*Z(187))+2*
     &MF*(Z(189)*Z(245)+Z(192)*Z(261)+Z(4)*Z(176)+Z(28)*Z(180)+Z(236)*Z(
     &184)+Z(244)*Z(190)+Z(260)*Z(193))-2*MG*(Z(106)*Z(199)+Z(108)*Z(200
     &)-Z(4)*Z(176)-Z(28)*Z(180)-Z(236)*Z(184))-2*MI*(Z(212)*Z(317)-Z(4)
     &*Z(176)-Z(28)*Z(180)-Z(106)*Z(202)-Z(236)*Z(184)-Z(316)*Z(214))-MH
     &*(2*Z(205)*Z(277)-2*Z(189)*Z(245)-2*Z(195)*Z(261)-Z(206)*Z(281)-2*
     &Z(4)*Z(176)-2*Z(28)*Z(180)-2*Z(236)*Z(184)-2*Z(244)*Z(190)-2*Z(260
     &)*Z(196)-2*Z(276)*Z(207)-2*Z(280)*Z(208)))
      Z(632) = -MC*(L2*Z(4)*Z(176)+L2*Z(28)*Z(178)-L6*Z(4)*Z(165)-L6*Z(6
     &)*Z(178)) - MD*(L2*Z(4)*Z(176)+L2*Z(28)*Z(180)+L2*Z(236)*Z(182)-L6
     &*Z(4)*Z(165)-L6*Z(6)*Z(180)-L6*Z(240)*Z(182)) - 0.25D0*MB*(Z(615)*
     &Z(168)+2*L2*Z(4)*Z(168)+2*L2*Z(233)*Z(169)+2*L3*Z(232)*Z(165)-Z(61
     &6)*Z(169)-2*L4*Z(4)*Z(165)) - ME*(L2*Z(186)*Z(245)+L2*Z(4)*Z(176)+
     &L2*Z(28)*Z(180)+L2*Z(236)*Z(184)+L2*Z(244)*Z(187)-L6*Z(186)*Z(249)
     &-L6*Z(4)*Z(165)-L6*Z(6)*Z(180)-L6*Z(240)*Z(184)-L6*Z(248)*Z(187)) 
     &- MG*(L2*Z(4)*Z(176)+L2*Z(28)*Z(180)+L2*Z(236)*Z(184)+L6*Z(111)*Z(
     &199)+L6*Z(113)*Z(200)-L2*Z(106)*Z(199)-L2*Z(108)*Z(200)-L6*Z(4)*Z(
     &165)-L6*Z(6)*Z(180)-L6*Z(240)*Z(184)) - MI*(L6*Z(212)*Z(321)+L2*Z(
     &4)*Z(176)+L2*Z(28)*Z(180)+L2*Z(106)*Z(202)+L2*Z(236)*Z(184)+L2*Z(3
     &16)*Z(214)-L2*Z(212)*Z(317)-L6*Z(4)*Z(165)-L6*Z(6)*Z(180)-L6*Z(111
     &)*Z(202)-L6*Z(240)*Z(184)-L6*Z(320)*Z(214)) - MF*(L2*Z(189)*Z(245)
     &+L2*Z(192)*Z(261)+L2*Z(4)*Z(176)+L2*Z(28)*Z(180)+L2*Z(236)*Z(184)+
     &L2*Z(244)*Z(190)+L2*Z(260)*Z(193)-L6*Z(189)*Z(249)-L6*Z(192)*Z(265
     &)-L6*Z(4)*Z(165)-L6*Z(6)*Z(180)-L6*Z(240)*Z(184)-L6*Z(248)*Z(190)-
     &L6*Z(264)*Z(193)) - 0.5D0*MH*(L2*Z(206)*Z(281)+2*L2*Z(189)*Z(245)+
     &2*L2*Z(195)*Z(261)+2*L6*Z(205)*Z(285)+2*L2*Z(4)*Z(176)+2*L2*Z(28)*
     &Z(180)+2*L2*Z(236)*Z(184)+2*L2*Z(244)*Z(190)+2*L2*Z(260)*Z(196)+2*
     &L2*Z(276)*Z(207)+2*L2*Z(280)*Z(208)-2*L2*Z(205)*Z(277)-2*L6*Z(189)
     &*Z(249)-2*L6*Z(195)*Z(265)-L6*Z(206)*Z(289)-2*L6*Z(4)*Z(165)-2*L6*
     &Z(6)*Z(180)-2*L6*Z(240)*Z(184)-2*L6*Z(248)*Z(190)-2*L6*Z(264)*Z(19
     &6)-2*L6*Z(284)*Z(207)-2*L6*Z(288)*Z(208))
      Z(636) = MC*(L6*Z(4)*Z(165)+L6*Z(6)*Z(178)-L2*Z(4)*Z(176)-L2*Z(28)
     &*Z(178)-L7*Z(6)*Z(176)-L7*Z(27)*Z(165)) + MD*(L6*Z(4)*Z(165)+L6*Z(
     &6)*Z(180)+L6*Z(240)*Z(182)+L8*Z(10)*Z(182)-L2*Z(4)*Z(176)-L2*Z(28)
     &*Z(180)-L2*Z(236)*Z(182)-L8*Z(6)*Z(176)-L8*Z(27)*Z(165)) + MG*(L2*
     &Z(106)*Z(199)+L2*Z(108)*Z(200)+L6*Z(4)*Z(165)+L6*Z(6)*Z(180)+L6*Z(
     &240)*Z(184)+L8*Z(10)*Z(184)-L2*Z(4)*Z(176)-L2*Z(28)*Z(180)-L2*Z(23
     &6)*Z(184)-L6*Z(111)*Z(199)-L6*Z(113)*Z(200)-L8*Z(6)*Z(176)-L8*Z(27
     &)*Z(165)-L8*Z(29)*Z(200)-L8*Z(31)*Z(199)) - 0.25D0*MB*(Z(615)*Z(16
     &8)+2*L2*Z(4)*Z(168)+2*L2*Z(233)*Z(169)+2*L3*Z(232)*Z(165)-Z(616)*Z
     &(169)-2*L4*Z(4)*Z(165)) - ME*(L2*Z(186)*Z(245)+L2*Z(4)*Z(176)+L2*Z
     &(28)*Z(180)+L2*Z(236)*Z(184)+L2*Z(244)*Z(187)+L8*Z(6)*Z(176)+L8*Z(
     &27)*Z(165)-L6*Z(186)*Z(249)-L8*Z(186)*Z(253)-L6*Z(4)*Z(165)-L6*Z(6
     &)*Z(180)-L6*Z(240)*Z(184)-L6*Z(248)*Z(187)-L8*Z(10)*Z(184)-L8*Z(25
     &2)*Z(187)) - MI*(L6*Z(212)*Z(321)+L8*Z(212)*Z(325)+L2*Z(4)*Z(176)+
     &L2*Z(28)*Z(180)+L2*Z(106)*Z(202)+L2*Z(236)*Z(184)+L2*Z(316)*Z(214)
     &+L8*Z(6)*Z(176)+L8*Z(27)*Z(165)-L2*Z(212)*Z(317)-L6*Z(4)*Z(165)-L6
     &*Z(6)*Z(180)-L6*Z(111)*Z(202)-L6*Z(240)*Z(184)-L6*Z(320)*Z(214)-L8
     &*Z(10)*Z(184)-L8*Z(31)*Z(202)-L8*Z(324)*Z(214)) - MF*(L2*Z(189)*Z(
     &245)+L2*Z(192)*Z(261)+L2*Z(4)*Z(176)+L2*Z(28)*Z(180)+L2*Z(236)*Z(1
     &84)+L2*Z(244)*Z(190)+L2*Z(260)*Z(193)+L8*Z(6)*Z(176)+L8*Z(27)*Z(16
     &5)-L6*Z(189)*Z(249)-L6*Z(192)*Z(265)-L8*Z(189)*Z(253)-L8*Z(192)*Z(
     &269)-L6*Z(4)*Z(165)-L6*Z(6)*Z(180)-L6*Z(240)*Z(184)-L6*Z(248)*Z(19
     &0)-L6*Z(264)*Z(193)-L8*Z(10)*Z(184)-L8*Z(252)*Z(190)-L8*Z(268)*Z(1
     &93)) - 0.5D0*MH*(L2*Z(206)*Z(281)+2*L2*Z(189)*Z(245)+2*L2*Z(195)*Z
     &(261)+2*L6*Z(205)*Z(285)+2*L8*Z(205)*Z(293)+2*L2*Z(4)*Z(176)+2*L2*
     &Z(28)*Z(180)+2*L2*Z(236)*Z(184)+2*L2*Z(244)*Z(190)+2*L2*Z(260)*Z(1
     &96)+2*L2*Z(276)*Z(207)+2*L2*Z(280)*Z(208)+2*L8*Z(6)*Z(176)+2*L8*Z(
     &27)*Z(165)-2*L2*Z(205)*Z(277)-2*L6*Z(189)*Z(249)-2*L6*Z(195)*Z(265
     &)-2*L8*Z(189)*Z(253)-2*L8*Z(195)*Z(269)-L6*Z(206)*Z(289)-L8*Z(206)
     &*Z(297)-2*L6*Z(4)*Z(165)-2*L6*Z(6)*Z(180)-2*L6*Z(240)*Z(184)-2*L6*
     &Z(248)*Z(190)-2*L6*Z(264)*Z(196)-2*L6*Z(284)*Z(207)-2*L6*Z(288)*Z(
     &208)-2*L8*Z(10)*Z(184)-2*L8*Z(252)*Z(190)-2*L8*Z(268)*Z(196)-2*L8*
     &Z(292)*Z(207)-2*L8*Z(296)*Z(208))
      Z(639) = MC*(L6*Z(4)*Z(165)+L6*Z(6)*Z(178)-L2*Z(4)*Z(176)-L2*Z(28)
     &*Z(178)-L7*Z(6)*Z(176)-L7*Z(27)*Z(165)) + MG*(L10*Z(239)*Z(176)+L2
     &*Z(106)*Z(199)+L2*Z(108)*Z(200)+L6*Z(4)*Z(165)+L6*Z(6)*Z(180)+L6*Z
     &(240)*Z(184)+L8*Z(10)*Z(184)-L10*Z(10)*Z(180)-L10*Z(11)*Z(200)-L10
     &*Z(12)*Z(199)-L10*Z(235)*Z(165)-L2*Z(4)*Z(176)-L2*Z(28)*Z(180)-L2*
     &Z(236)*Z(184)-L6*Z(111)*Z(199)-L6*Z(113)*Z(200)-L8*Z(6)*Z(176)-L8*
     &Z(27)*Z(165)-L8*Z(29)*Z(200)-L8*Z(31)*Z(199)) - 0.25D0*MB*(Z(615)*
     &Z(168)+2*L2*Z(4)*Z(168)+2*L2*Z(233)*Z(169)+2*L3*Z(232)*Z(165)-Z(61
     &6)*Z(169)-2*L4*Z(4)*Z(165)) - MD*(L2*Z(4)*Z(176)+L2*Z(28)*Z(180)+L
     &2*Z(236)*Z(182)+L8*Z(6)*Z(176)+L8*Z(27)*Z(165)+L9*Z(10)*Z(180)+L9*
     &Z(235)*Z(165)-L6*Z(4)*Z(165)-L6*Z(6)*Z(180)-L6*Z(240)*Z(182)-L8*Z(
     &10)*Z(182)-L9*Z(239)*Z(176)) - ME*(L2*Z(186)*Z(245)+L10*Z(10)*Z(18
     &0)+L10*Z(235)*Z(165)+L2*Z(4)*Z(176)+L2*Z(28)*Z(180)+L2*Z(236)*Z(18
     &4)+L2*Z(244)*Z(187)+L8*Z(6)*Z(176)+L8*Z(27)*Z(165)-L10*Z(186)*Z(25
     &7)-L6*Z(186)*Z(249)-L8*Z(186)*Z(253)-L10*Z(239)*Z(176)-L10*Z(256)*
     &Z(187)-L6*Z(4)*Z(165)-L6*Z(6)*Z(180)-L6*Z(240)*Z(184)-L6*Z(248)*Z(
     &187)-L8*Z(10)*Z(184)-L8*Z(252)*Z(187)) - MI*(L10*Z(212)*Z(329)+L6*
     &Z(212)*Z(321)+L8*Z(212)*Z(325)+L10*Z(10)*Z(180)+L10*Z(235)*Z(165)+
     &L2*Z(4)*Z(176)+L2*Z(28)*Z(180)+L2*Z(106)*Z(202)+L2*Z(236)*Z(184)+L
     &2*Z(316)*Z(214)+L8*Z(6)*Z(176)+L8*Z(27)*Z(165)-L2*Z(212)*Z(317)-L1
     &0*Z(12)*Z(202)-L10*Z(239)*Z(176)-L10*Z(328)*Z(214)-L6*Z(4)*Z(165)-
     &L6*Z(6)*Z(180)-L6*Z(111)*Z(202)-L6*Z(240)*Z(184)-L6*Z(320)*Z(214)-
     &L8*Z(10)*Z(184)-L8*Z(31)*Z(202)-L8*Z(324)*Z(214)) - MF*(L2*Z(189)*
     &Z(245)+L2*Z(192)*Z(261)+L10*Z(10)*Z(180)+L10*Z(235)*Z(165)+L2*Z(4)
     &*Z(176)+L2*Z(28)*Z(180)+L2*Z(236)*Z(184)+L2*Z(244)*Z(190)+L2*Z(260
     &)*Z(193)+L8*Z(6)*Z(176)+L8*Z(27)*Z(165)-L10*Z(189)*Z(257)-L10*Z(19
     &2)*Z(273)-L6*Z(189)*Z(249)-L6*Z(192)*Z(265)-L8*Z(189)*Z(253)-L8*Z(
     &192)*Z(269)-L10*Z(239)*Z(176)-L10*Z(256)*Z(190)-L10*Z(272)*Z(193)-
     &L6*Z(4)*Z(165)-L6*Z(6)*Z(180)-L6*Z(240)*Z(184)-L6*Z(248)*Z(190)-L6
     &*Z(264)*Z(193)-L8*Z(10)*Z(184)-L8*Z(252)*Z(190)-L8*Z(268)*Z(193)) 
     &- 0.5D0*MH*(L2*Z(206)*Z(281)+2*L10*Z(205)*Z(301)+2*L2*Z(189)*Z(245
     &)+2*L2*Z(195)*Z(261)+2*L6*Z(205)*Z(285)+2*L8*Z(205)*Z(293)+2*L10*Z
     &(10)*Z(180)+2*L10*Z(235)*Z(165)+2*L2*Z(4)*Z(176)+2*L2*Z(28)*Z(180)
     &+2*L2*Z(236)*Z(184)+2*L2*Z(244)*Z(190)+2*L2*Z(260)*Z(196)+2*L2*Z(2
     &76)*Z(207)+2*L2*Z(280)*Z(208)+2*L8*Z(6)*Z(176)+2*L8*Z(27)*Z(165)-2
     &*L10*Z(189)*Z(257)-2*L10*Z(195)*Z(273)-2*L2*Z(205)*Z(277)-2*L6*Z(1
     &89)*Z(249)-2*L6*Z(195)*Z(265)-2*L8*Z(189)*Z(253)-2*L8*Z(195)*Z(269
     &)-L10*Z(206)*Z(305)-L6*Z(206)*Z(289)-L8*Z(206)*Z(297)-2*L10*Z(239)
     &*Z(176)-2*L10*Z(256)*Z(190)-2*L10*Z(272)*Z(196)-2*L10*Z(300)*Z(207
     &)-2*L10*Z(304)*Z(208)-2*L6*Z(4)*Z(165)-2*L6*Z(6)*Z(180)-2*L6*Z(240
     &)*Z(184)-2*L6*Z(248)*Z(190)-2*L6*Z(264)*Z(196)-2*L6*Z(284)*Z(207)-
     &2*L6*Z(288)*Z(208)-2*L8*Z(10)*Z(184)-2*L8*Z(252)*Z(190)-2*L8*Z(268
     &)*Z(196)-2*L8*Z(292)*Z(207)-2*L8*Z(296)*Z(208))
      Z(675) = Z(503) - Z(549)
      Z(676) = Z(505) - Z(555)
      Z(677) = Z(507) - Z(620)
      Z(678) = Z(516) + 0.5D0*Z(626)
      Z(679) = Z(517) - Z(632)
      Z(680) = Z(518) - Z(636)
      Z(681) = Z(519) - Z(639)

      COEF(1,1) = -Z(70)
      COEF(1,2) = 0
      COEF(1,3) = -Z(543)
      COEF(1,4) = -Z(545)
      COEF(1,5) = -Z(546)
      COEF(1,6) = -Z(547)
      COEF(1,7) = -Z(548)
      COEF(2,1) = 0
      COEF(2,2) = -Z(70)
      COEF(2,3) = -Z(550)
      COEF(2,4) = -Z(551)
      COEF(2,5) = -Z(552)
      COEF(2,6) = -Z(553)
      COEF(2,7) = -Z(554)
      COEF(3,1) = -Z(543)
      COEF(3,2) = -Z(550)
      COEF(3,3) = -Z(608)
      COEF(3,4) = -Z(610)
      COEF(3,5) = -Z(612)
      COEF(3,6) = -Z(613)
      COEF(3,7) = -Z(614)
      COEF(4,1) = -Z(545)
      COEF(4,2) = -Z(551)
      COEF(4,3) = -Z(610)
      COEF(4,4) = -Z(621)
      COEF(4,5) = -Z(623)
      COEF(4,6) = -Z(624)
      COEF(4,7) = -Z(625)
      COEF(5,1) = -Z(546)
      COEF(5,2) = -Z(552)
      COEF(5,3) = -Z(612)
      COEF(5,4) = -Z(623)
      COEF(5,5) = -Z(629)
      COEF(5,6) = -Z(630)
      COEF(5,7) = -Z(631)
      COEF(6,1) = -Z(547)
      COEF(6,2) = -Z(553)
      COEF(6,3) = -Z(613)
      COEF(6,4) = -Z(624)
      COEF(6,5) = -Z(630)
      COEF(6,6) = -Z(634)
      COEF(6,7) = -Z(635)
      COEF(7,1) = -Z(548)
      COEF(7,2) = -Z(554)
      COEF(7,3) = -Z(614)
      COEF(7,4) = -Z(625)
      COEF(7,5) = -Z(631)
      COEF(7,6) = -Z(635)
      COEF(7,7) = -Z(638)
      RHS(1) = -Z(675)
      RHS(2) = -Z(676)
      RHS(3) = -Z(677)
      RHS(4) = -Z(678)
      RHS(5) = -Z(679)
      RHS(6) = -Z(680)
      RHS(7) = -Z(681)
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
     &,INH,INI,K1,K2,K3,K4,K5,K6,K7,K8,KE,KF,L1,L10,L11,L2,L3,L4,L5,L6,L
     &7,L8,L9,MA,MB,MC,MD,ME,MF,MG,MH,MI,MTPB,MTPK,POP1XI,POP2XI
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
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(693),COEF(7,7),RHS(7)

C**   Evaluate output quantities
      KECM = 0.5D0*ING*U3**2 + 0.5D0*IND*(U3-U7)**2 + 0.5D0*INC*(U3-U6-U
     &7)**2 + 0.5D0*INE*(EAp-U3-U8)**2 + 0.5D0*INB*(U3-U5-U6-U7)**2 + 0.
     &5D0*INA*(U3-U4-U5-U6-U7)**2 + 0.5D0*INF*(EAp-FAp-U3-U8-U9)**2 + 0.
     &5D0*INH*(EAp+HAp-FAp-U10-U3-U8-U9)**2 + 0.5D0*INI*(EAp+IAp-FAp-U11
     &-U3-U8-U9)**2 + 0.5D0*MC*(U1**2+U2**2+L7**2*(U3-U6-U7)**2+2*L7*Z(3
     &4)*U1*(U3-U6-U7)+2*L7*Z(35)*U2*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)**2+2
     &*L6*Z(52)*U1*(U3-U5-U6-U7)+2*L6*Z(53)*U2*(U3-U5-U6-U7)+L2**2*(U3-U
     &4-U5-U6-U7)**2+2*L6*L7*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-2*L2*Z(38)*U1
     &*(U3-U4-U5-U6-U7)-2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-2*L2*L7*Z(26)*(U3
     &-U6-U7)*(U3-U4-U5-U6-U7)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U
     &7)) + 0.125D0*MB*(4*U1**2+4*U2**2+L3**2*(U3-U5-U6-U7)**2+L4**2*(U3
     &-U5-U6-U7)**2+4*L3*Z(85)*U1*(U3-U5-U6-U7)+4*L3*Z(86)*U2*(U3-U5-U6-
     &U7)+4*L4*Z(52)*U1*(U3-U5-U6-U7)+4*L4*Z(53)*U2*(U3-U5-U6-U7)+2*L3*L
     &4*Z(7)*(U3-U5-U6-U7)**2+4*L2**2*(U3-U4-U5-U6-U7)**2-8*L2*Z(38)*U1*
     &(U3-U4-U5-U6-U7)-8*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-4*L2*L3*Z(231)*(U3
     &-U5-U6-U7)*(U3-U4-U5-U6-U7)-4*L2*L4*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U
     &6-U7)) + 0.5D0*MD*(U1**2+U2**2+L9**2*(U3-U7)**2+2*L9*Z(56)*U1*(U3-
     &U7)+2*L9*Z(57)*U2*(U3-U7)+L8**2*(U3-U6-U7)**2+2*L8*Z(34)*U1*(U3-U6
     &-U7)+2*L8*Z(35)*U2*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)**2+2*L6*Z(52)*U1
     &*(U3-U5-U6-U7)+2*L6*Z(53)*U2*(U3-U5-U6-U7)+L2**2*(U3-U4-U5-U6-U7)*
     &*2+2*L8*L9*Z(9)*(U3-U7)*(U3-U6-U7)+2*L6*L9*Z(241)*(U3-U7)*(U3-U5-U
     &6-U7)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-2*L2*Z(38)*U1*(U3-U4-U
     &5-U6-U7)-2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-2*L2*L9*Z(237)*(U3-U7)*(U3
     &-U4-U5-U6-U7)-2*L2*L8*Z(26)*(U3-U6-U7)*(U3-U4-U5-U6-U7)-2*L2*L6*Z(
     &3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)) + 0.5D0*ME*(U1**2+U2**2+L10**2*
     &(U3-U7)**2+2*L10*Z(56)*U1*(U3-U7)+2*L10*Z(57)*U2*(U3-U7)+(Z(139)-Z
     &(21)*U3-Z(21)*U8)**2+L8**2*(U3-U6-U7)**2+2*L8*Z(34)*U1*(U3-U6-U7)+
     &2*L8*Z(35)*U2*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)**2+2*L6*Z(52)*U1*(U3-
     &U5-U6-U7)+2*L6*Z(53)*U2*(U3-U5-U6-U7)+L2**2*(U3-U4-U5-U6-U7)**2+2*
     &L10*L8*Z(9)*(U3-U7)*(U3-U6-U7)+2*L10*L6*Z(241)*(U3-U7)*(U3-U5-U6-U
     &7)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)+2*L2*Z(245)*(Z(139)-Z(21)
     &*U3-Z(21)*U8)*(U3-U4-U5-U6-U7)-2*Z(43)*U2*(Z(139)-Z(21)*U3-Z(21)*U
     &8)-2*Z(45)*U1*(Z(139)-Z(21)*U3-Z(21)*U8)-2*L2*Z(38)*U1*(U3-U4-U5-U
     &6-U7)-2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-2*L10*Z(257)*(U3-U7)*(Z(139)-
     &Z(21)*U3-Z(21)*U8)-2*L8*Z(253)*(U3-U6-U7)*(Z(139)-Z(21)*U3-Z(21)*U
     &8)-2*L10*L2*Z(237)*(U3-U7)*(U3-U4-U5-U6-U7)-2*L6*Z(249)*(Z(139)-Z(
     &21)*U3-Z(21)*U8)*(U3-U5-U6-U7)-2*L2*L8*Z(26)*(U3-U6-U7)*(U3-U4-U5-
     &U6-U7)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)) + 0.5D0*MG*(GS
     &p**2+U1**2+U2**2+2*GSp*Z(1)*U1+2*GSp*Z(2)*U2+GS**2*U3**2+2*GS*Z(1)
     &*U2*U3+L10**2*(U3-U7)**2+2*L10*GSp*Z(12)*(U3-U7)+2*L10*Z(56)*U1*(U
     &3-U7)+2*L10*Z(57)*U2*(U3-U7)+2*L10*GS*Z(11)*U3*(U3-U7)+L8**2*(U3-U
     &6-U7)**2+2*L8*GSp*Z(31)*(U3-U6-U7)+2*L8*Z(34)*U1*(U3-U6-U7)+2*L8*Z
     &(35)*U2*(U3-U6-U7)+2*L8*GS*Z(29)*U3*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)
     &**2+2*L6*GSp*Z(111)*(U3-U5-U6-U7)+2*L6*Z(52)*U1*(U3-U5-U6-U7)+2*L6
     &*Z(53)*U2*(U3-U5-U6-U7)+2*L6*GS*Z(113)*U3*(U3-U5-U6-U7)+L2**2*(U3-
     &U4-U5-U6-U7)**2+2*L10*L8*Z(9)*(U3-U7)*(U3-U6-U7)+2*L10*L6*Z(241)*(
     &U3-U7)*(U3-U5-U6-U7)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-2*GS*Z(
     &2)*U1*U3-2*L2*GSp*Z(106)*(U3-U4-U5-U6-U7)-2*L2*Z(38)*U1*(U3-U4-U5-
     &U6-U7)-2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-2*L2*GS*Z(108)*U3*(U3-U4-U5-
     &U6-U7)-2*L10*L2*Z(237)*(U3-U7)*(U3-U4-U5-U6-U7)-2*L2*L8*Z(26)*(U3-
     &U6-U7)*(U3-U4-U5-U6-U7)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7
     &)) + 0.5D0*MI*(U1**2+U2**2+L11**2*U3**2+2*L11*Z(1)*U2*U3+L10**2*(U
     &3-U7)**2+2*L10*Z(56)*U1*(U3-U7)+2*L10*Z(57)*U2*(U3-U7)+2*L10*L11*Z
     &(11)*U3*(U3-U7)+L8**2*(U3-U6-U7)**2+2*L8*Z(34)*U1*(U3-U6-U7)+2*L8*
     &Z(35)*U2*(U3-U6-U7)+(Z(149)+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)*
     &*2+2*L11*L8*Z(29)*U3*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)**2+2*L6*Z(52)*
     &U1*(U3-U5-U6-U7)+2*L6*Z(53)*U2*(U3-U5-U6-U7)+2*L11*L6*Z(113)*U3*(U
     &3-U5-U6-U7)+2*Z(68)*U1*(Z(149)+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U
     &9)+2*Z(69)*U2*(Z(149)+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)+L2**2*
     &(U3-U4-U5-U6-U7)**2+2*L10*L8*Z(9)*(U3-U7)*(U3-U6-U7)+2*L11*Z(133)*
     &U3*(Z(149)+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)+2*L10*L6*Z(241)*(
     &U3-U7)*(U3-U5-U6-U7)+2*L10*Z(329)*(U3-U7)*(Z(149)+Z(25)*U11+Z(25)*
     &U3+Z(25)*U8+Z(25)*U9)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)+2*L8*Z
     &(325)*(U3-U6-U7)*(Z(149)+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)+2*L
     &6*Z(321)*(U3-U5-U6-U7)*(Z(149)+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U
     &9)-2*L11*Z(2)*U1*U3-2*L2*Z(38)*U1*(U3-U4-U5-U6-U7)-2*L2*Z(39)*U2*(
     &U3-U4-U5-U6-U7)-2*L11*L2*Z(108)*U3*(U3-U4-U5-U6-U7)-2*L10*L2*Z(237
     &)*(U3-U7)*(U3-U4-U5-U6-U7)-2*L2*L8*Z(26)*(U3-U6-U7)*(U3-U4-U5-U6-U
     &7)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)-2*L2*Z(317)*(Z(149)
     &+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)*(U3-U4-U5-U6-U7)) - 0.5D0*M
     &A*(2*L1*Z(38)*U1*(U3-U4-U5-U6-U7)+2*L1*Z(39)*U2*(U3-U4-U5-U6-U7)-U
     &1**2-U2**2-L1**2*(U3-U4-U5-U6-U7)**2) - 0.5D0*MF*(2*Z(43)*U2*(Z(14
     &0)-L10*U3-L10*U8)+2*Z(45)*U1*(Z(140)-L10*U3-L10*U8)+2*L2*Z(38)*U1*
     &(U3-U4-U5-U6-U7)+2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)+2*Z(60)*U1*(Z(141)
     &-Z(22)*U3-Z(22)*U8-Z(22)*U9)+2*Z(61)*U2*(Z(141)-Z(22)*U3-Z(22)*U8-
     &Z(22)*U9)+2*L10*Z(257)*(U3-U7)*(Z(140)-L10*U3-L10*U8)+2*L8*Z(253)*
     &(U3-U6-U7)*(Z(140)-L10*U3-L10*U8)+2*L10*L2*Z(237)*(U3-U7)*(U3-U4-U
     &5-U6-U7)+2*L10*Z(273)*(U3-U7)*(Z(141)-Z(22)*U3-Z(22)*U8-Z(22)*U9)+
     &2*L6*Z(249)*(Z(140)-L10*U3-L10*U8)*(U3-U5-U6-U7)+2*L2*L8*Z(26)*(U3
     &-U6-U7)*(U3-U4-U5-U6-U7)+2*L8*Z(269)*(U3-U6-U7)*(Z(141)-Z(22)*U3-Z
     &(22)*U8-Z(22)*U9)+2*Z(15)*(Z(140)-L10*U3-L10*U8)*(Z(141)-Z(22)*U3-
     &Z(22)*U8-Z(22)*U9)+2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)+2*L
     &6*Z(265)*(U3-U5-U6-U7)*(Z(141)-Z(22)*U3-Z(22)*U8-Z(22)*U9)-U1**2-U
     &2**2-2*L10*Z(56)*U1*(U3-U7)-2*L10*Z(57)*U2*(U3-U7)-L10**2*(U3-U7)*
     &*2-2*L8*Z(34)*U1*(U3-U6-U7)-2*L8*Z(35)*U2*(U3-U6-U7)-(Z(140)-L10*U
     &3-L10*U8)**2-L8**2*(U3-U6-U7)**2-2*L6*Z(52)*U1*(U3-U5-U6-U7)-2*L6*
     &Z(53)*U2*(U3-U5-U6-U7)-L6**2*(U3-U5-U6-U7)**2-(Z(141)-Z(22)*U3-Z(2
     &2)*U8-Z(22)*U9)**2-2*L10*L8*Z(9)*(U3-U7)*(U3-U6-U7)-L2**2*(U3-U4-U
     &5-U6-U7)**2-2*L10*L6*Z(241)*(U3-U7)*(U3-U5-U6-U7)-2*L6*L8*Z(5)*(U3
     &-U6-U7)*(U3-U5-U6-U7)-2*L2*Z(245)*(Z(140)-L10*U3-L10*U8)*(U3-U4-U5
     &-U6-U7)-2*L2*Z(261)*(U3-U4-U5-U6-U7)*(Z(141)-Z(22)*U3-Z(22)*U8-Z(2
     &2)*U9)) - 0.125D0*MH*(8*Z(43)*U2*(Z(140)-L10*U3-L10*U8)+8*Z(45)*U1
     &*(Z(140)-L10*U3-L10*U8)+4*Z(64)*U1*(Z(148)+L3*U10+L3*U3+L3*U8+L3*U
     &9)+4*Z(65)*U2*(Z(148)+L3*U10+L3*U3+L3*U8+L3*U9)+8*L2*Z(38)*U1*(U3-
     &U4-U5-U6-U7)+8*L2*Z(39)*U2*(U3-U4-U5-U6-U7)+8*Z(60)*U1*(Z(142)-L8*
     &U3-L8*U8-L8*U9)+8*Z(61)*U2*(Z(142)-L8*U3-L8*U8-L8*U9)+8*L10*Z(257)
     &*(U3-U7)*(Z(140)-L10*U3-L10*U8)+4*L10*Z(305)*(U3-U7)*(Z(148)+L3*U1
     &0+L3*U3+L3*U8+L3*U9)+8*L8*Z(253)*(U3-U6-U7)*(Z(140)-L10*U3-L10*U8)
     &+8*L10*L2*Z(237)*(U3-U7)*(U3-U4-U5-U6-U7)+8*L10*Z(273)*(U3-U7)*(Z(
     &142)-L8*U3-L8*U8-L8*U9)+4*L8*Z(297)*(U3-U6-U7)*(Z(148)+L3*U10+L3*U
     &3+L3*U8+L3*U9)+8*L6*Z(249)*(Z(140)-L10*U3-L10*U8)*(U3-U5-U6-U7)+8*
     &L2*L8*Z(26)*(U3-U6-U7)*(U3-U4-U5-U6-U7)+8*L8*Z(269)*(U3-U6-U7)*(Z(
     &142)-L8*U3-L8*U8-L8*U9)+8*Z(40)*(Z(140)-L10*U3-L10*U8)*(Z(147)+Z(2
     &4)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)+4*L6*Z(289)*(U3-U5-U6-U7)*(Z(14
     &8)+L3*U10+L3*U3+L3*U8+L3*U9)+8*Z(15)*(Z(140)-L10*U3-L10*U8)*(Z(142
     &)-L8*U3-L8*U8-L8*U9)+4*Z(7)*(Z(147)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(
     &24)*U9)*(Z(148)+L3*U10+L3*U3+L3*U8+L3*U9)+8*L2*L6*Z(3)*(U3-U5-U6-U
     &7)*(U3-U4-U5-U6-U7)+8*L6*Z(265)*(U3-U5-U6-U7)*(Z(142)-L8*U3-L8*U8-
     &L8*U9)+8*L2*Z(277)*(Z(147)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)*(
     &U3-U4-U5-U6-U7)-4*U1**2-4*U2**2-8*L10*Z(56)*U1*(U3-U7)-8*L10*Z(57)
     &*U2*(U3-U7)-4*L10**2*(U3-U7)**2-8*L8*Z(34)*U1*(U3-U6-U7)-8*L8*Z(35
     &)*U2*(U3-U6-U7)-4*(Z(140)-L10*U3-L10*U8)**2-4*L8**2*(U3-U6-U7)**2-
     &8*L6*Z(52)*U1*(U3-U5-U6-U7)-8*L6*Z(53)*U2*(U3-U5-U6-U7)-4*(Z(147)+
     &Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)**2-4*L6**2*(U3-U5-U6-U7)**2-
     &(Z(148)+L3*U10+L3*U3+L3*U8+L3*U9)**2-8*Z(48)*U1*(Z(147)+Z(24)*U10+
     &Z(24)*U3+Z(24)*U8+Z(24)*U9)-8*Z(49)*U2*(Z(147)+Z(24)*U10+Z(24)*U3+
     &Z(24)*U8+Z(24)*U9)-4*(Z(142)-L8*U3-L8*U8-L8*U9)**2-8*L10*L8*Z(9)*(
     &U3-U7)*(U3-U6-U7)-4*L2**2*(U3-U4-U5-U6-U7)**2-8*L10*L6*Z(241)*(U3-
     &U7)*(U3-U5-U6-U7)-8*L10*Z(301)*(U3-U7)*(Z(147)+Z(24)*U10+Z(24)*U3+
     &Z(24)*U8+Z(24)*U9)-8*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-8*L8*Z(29
     &3)*(U3-U6-U7)*(Z(147)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)-4*Z(30
     &9)*(Z(140)-L10*U3-L10*U8)*(Z(148)+L3*U10+L3*U3+L3*U8+L3*U9)-8*L2*Z
     &(245)*(Z(140)-L10*U3-L10*U8)*(U3-U4-U5-U6-U7)-8*L6*Z(285)*(U3-U5-U
     &6-U7)*(Z(147)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)-8*Z(17)*(Z(147
     &)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)*(Z(142)-L8*U3-L8*U8-L8*U9)
     &-4*L2*Z(281)*(Z(148)+L3*U10+L3*U3+L3*U8+L3*U9)*(U3-U4-U5-U6-U7)-4*
     &Z(313)*(Z(148)+L3*U10+L3*U3+L3*U8+L3*U9)*(Z(142)-L8*U3-L8*U8-L8*U9
     &)-8*L2*Z(261)*(U3-U4-U5-U6-U7)*(Z(142)-L8*U3-L8*U8-L8*U9))
      Z(78) = (Z(77)+MG*GS)/Z(70)
      POCMY = Q2 + Z(73)*Z(33) + Z(74)*Z(55) + Z(75)*Z(44) + Z(76)*Z(59)
     & + Z(79)*Z(47) + Z(80)*Z(67) + Z(78)*Z(2) + 0.5D0*Z(72)*Z(51) + 0.
     &5D0*Z(82)*Z(84) - Z(71)*Z(37) - 0.5D0*Z(81)*Z(63)
      PECM = 0.5D0*K1*Q1**2 + 0.5D0*K3*Q2**2 - G*MT*POCMY
      TE = KECM + PECM
      Z(331) = FAp - EAp
      Z(332) = INF*Z(331)
      Z(333) = FAp - EAp - HAp
      Z(334) = INH*Z(333)
      Z(335) = FAp - EAp - IAp
      Z(336) = INI*Z(335)
      Z(393) = MA*(Z(81)*Z(62)+2*Z(337)*Z(36)-2*Z(73)*Z(32)-2*Z(74)*Z(54
     &)-2*Z(75)*Z(43)-2*Z(76)*Z(58)-2*Z(79)*Z(46)-2*Z(80)*Z(66)-2*Z(78)*
     &Z(1)-Z(72)*Z(50)-Z(82)*Z(83))
      Z(399) = MB*(Z(81)*Z(62)+2*Z(338)*Z(36)+2*Z(339)*Z(50)+2*Z(340)*Z(
     &83)-2*Z(73)*Z(32)-2*Z(74)*Z(54)-2*Z(75)*Z(43)-2*Z(76)*Z(58)-2*Z(79
     &)*Z(46)-2*Z(80)*Z(66)-2*Z(78)*Z(1))
      Z(407) = MC*(Z(81)*Z(62)+2*Z(338)*Z(36)+2*Z(368)*Z(50)+2*Z(369)*Z(
     &32)-2*Z(74)*Z(54)-2*Z(75)*Z(43)-2*Z(76)*Z(58)-2*Z(79)*Z(46)-2*Z(80
     &)*Z(66)-2*Z(78)*Z(1)-Z(82)*Z(83))
      Z(413) = MD*(Z(81)*Z(62)+2*Z(338)*Z(36)+2*Z(368)*Z(50)+2*Z(370)*Z(
     &32)+2*Z(371)*Z(54)-2*Z(75)*Z(43)-2*Z(76)*Z(58)-2*Z(79)*Z(46)-2*Z(8
     &0)*Z(66)-2*Z(78)*Z(1)-Z(82)*Z(83))
      Z(420) = ME*(Z(81)*Z(62)+2*Z(338)*Z(36)+2*Z(368)*Z(50)+2*Z(370)*Z(
     &32)+2*Z(372)*Z(54)+2*Z(373)*Z(43)-2*Z(76)*Z(58)-2*Z(79)*Z(46)-2*Z(
     &80)*Z(66)-2*Z(78)*Z(1)-Z(82)*Z(83))
      Z(428) = MF*(Z(81)*Z(62)+2*Z(338)*Z(36)+2*Z(368)*Z(50)+2*Z(370)*Z(
     &32)+2*Z(372)*Z(54)+2*Z(378)*Z(43)+2*Z(379)*Z(58)-2*Z(79)*Z(46)-2*Z
     &(80)*Z(66)-2*Z(78)*Z(1)-Z(82)*Z(83))
      Z(383) = GS - Z(78)
      Z(436) = MG*(Z(82)*Z(84)+2*Z(75)*Z(44)+2*Z(76)*Z(59)+2*Z(79)*Z(47)
     &+2*Z(80)*Z(67)-2*Z(338)*Z(37)-2*Z(368)*Z(51)-2*Z(370)*Z(33)-2*Z(37
     &2)*Z(55)-2*Z(383)*Z(2)-Z(81)*Z(63))
      Z(445) = MH*(2*Z(338)*Z(36)+2*Z(368)*Z(50)+2*Z(370)*Z(32)+2*Z(372)
     &*Z(54)+2*Z(378)*Z(43)+2*Z(384)*Z(58)+2*Z(385)*Z(46)+2*Z(386)*Z(62)
     &-2*Z(80)*Z(66)-2*Z(78)*Z(1)-Z(82)*Z(83))
      Z(390) = L11 - Z(78)
      Z(456) = MI*(Z(82)*Z(84)+2*Z(75)*Z(44)+2*Z(76)*Z(59)+2*Z(79)*Z(47)
     &-2*Z(338)*Z(37)-2*Z(368)*Z(51)-2*Z(370)*Z(33)-2*Z(372)*Z(55)-2*Z(3
     &91)*Z(67)-2*Z(390)*Z(2)-Z(81)*Z(63))
      Z(238) = Z(3)*Z(234) + Z(4)*Z(236)
      Z(110) = Z(1)*Z(50) + Z(2)*Z(51)
      Z(397) = MB*(Z(396)+Z(81)*Z(286)+2*Z(338)*Z(3)-2*Z(73)*Z(5)-2*Z(74
     &)*Z(238)-2*Z(75)*Z(246)-2*Z(76)*Z(262)-2*Z(79)*Z(282)-2*Z(80)*Z(31
     &8)-2*Z(78)*Z(110))
      Z(134) = Z(1)*Z(83) + Z(2)*Z(84)
      Z(136) = Z(1)*Z(84) - Z(2)*Z(83)
      Z(348) = Z(13)*Z(134) - Z(14)*Z(136)
      Z(350) = Z(13)*Z(136) + Z(14)*Z(134)
      Z(354) = Z(16)*Z(348) - Z(15)*Z(350)
      Z(352) = -Z(15)*Z(348) - Z(16)*Z(350)
      Z(356) = Z(18)*Z(354) - Z(17)*Z(352)
      Z(358) = -Z(17)*Z(354) - Z(18)*Z(352)
      Z(364) = Z(7)*Z(356) - Z(8)*Z(358)
      Z(341) = Z(7)*Z(5) + Z(8)*Z(6)
      Z(343) = Z(8)*Z(5) - Z(7)*Z(6)
      Z(344) = Z(9)*Z(341) + Z(10)*Z(343)
      Z(360) = Z(20)*Z(358) - Z(19)*Z(356)
      Z(401) = MB*(Z(400)+Z(81)*Z(364)+2*Z(338)*Z(231)-2*Z(73)*Z(341)-2*
     &Z(74)*Z(344)-2*Z(75)*Z(348)-2*Z(76)*Z(352)-2*Z(79)*Z(356)-2*Z(80)*
     &Z(360)-2*Z(78)*Z(134))
      Z(404) = MC*(2*Z(368)+Z(81)*Z(286)+2*Z(338)*Z(3)+2*Z(369)*Z(5)-Z(4
     &03)-2*Z(74)*Z(238)-2*Z(75)*Z(246)-2*Z(76)*Z(262)-2*Z(79)*Z(282)-2*
     &Z(80)*Z(318)-2*Z(78)*Z(110))
      Z(405) = MC*(2*Z(369)+Z(81)*Z(294)+2*Z(338)*Z(26)+2*Z(368)*Z(5)-2*
     &Z(74)*Z(9)-2*Z(75)*Z(250)-2*Z(76)*Z(266)-2*Z(79)*Z(290)-2*Z(80)*Z(
     &322)-2*Z(78)*Z(29)-Z(82)*Z(341))
      Z(409) = MD*(2*Z(368)+Z(81)*Z(286)+2*Z(338)*Z(3)+2*Z(370)*Z(5)+2*Z
     &(371)*Z(238)-Z(403)-2*Z(75)*Z(246)-2*Z(76)*Z(262)-2*Z(79)*Z(282)-2
     &*Z(80)*Z(318)-2*Z(78)*Z(110))
      Z(410) = MD*(2*Z(370)+Z(81)*Z(294)+2*Z(338)*Z(26)+2*Z(368)*Z(5)+2*
     &Z(371)*Z(9)-2*Z(75)*Z(250)-2*Z(76)*Z(266)-2*Z(79)*Z(290)-2*Z(80)*Z
     &(322)-2*Z(78)*Z(29)-Z(82)*Z(341))
      Z(302) = Z(9)*Z(294) + Z(10)*Z(296)
      Z(254) = Z(9)*Z(250) + Z(10)*Z(252)
      Z(270) = Z(9)*Z(266) + Z(10)*Z(268)
      Z(298) = Z(9)*Z(290) + Z(10)*Z(292)
      Z(326) = Z(9)*Z(322) + Z(10)*Z(324)
      Z(411) = MD*(2*Z(371)+Z(81)*Z(302)+2*Z(338)*Z(234)+2*Z(368)*Z(238)
     &+2*Z(370)*Z(9)-2*Z(75)*Z(254)-2*Z(76)*Z(270)-2*Z(79)*Z(298)-2*Z(80
     &)*Z(326)-2*Z(78)*Z(11)-Z(82)*Z(344))
      Z(415) = ME*(2*Z(368)+Z(81)*Z(286)+2*Z(338)*Z(3)+2*Z(370)*Z(5)+2*Z
     &(372)*Z(238)+2*Z(373)*Z(246)-Z(403)-2*Z(76)*Z(262)-2*Z(79)*Z(282)-
     &2*Z(80)*Z(318)-2*Z(78)*Z(110))
      Z(416) = ME*(2*Z(370)+Z(81)*Z(294)+2*Z(338)*Z(26)+2*Z(368)*Z(5)+2*
     &Z(372)*Z(9)+2*Z(373)*Z(250)-2*Z(76)*Z(266)-2*Z(79)*Z(290)-2*Z(80)*
     &Z(322)-2*Z(78)*Z(29)-Z(82)*Z(341))
      Z(417) = ME*(2*Z(372)+Z(81)*Z(302)+2*Z(338)*Z(234)+2*Z(368)*Z(238)
     &+2*Z(370)*Z(9)+2*Z(373)*Z(254)-2*Z(76)*Z(270)-2*Z(79)*Z(298)-2*Z(8
     &0)*Z(326)-2*Z(78)*Z(11)-Z(82)*Z(344))
      Z(422) = MF*(2*Z(368)+Z(81)*Z(286)+2*Z(338)*Z(3)+2*Z(370)*Z(5)+2*Z
     &(372)*Z(238)+2*Z(378)*Z(246)+2*Z(379)*Z(262)-Z(403)-2*Z(79)*Z(282)
     &-2*Z(80)*Z(318)-2*Z(78)*Z(110))
      Z(423) = MF*(2*Z(370)+Z(81)*Z(294)+2*Z(338)*Z(26)+2*Z(368)*Z(5)+2*
     &Z(372)*Z(9)+2*Z(378)*Z(250)+2*Z(379)*Z(266)-2*Z(79)*Z(290)-2*Z(80)
     &*Z(322)-2*Z(78)*Z(29)-Z(82)*Z(341))
      Z(424) = MF*(2*Z(372)+Z(81)*Z(302)+2*Z(338)*Z(234)+2*Z(368)*Z(238)
     &+2*Z(370)*Z(9)+2*Z(378)*Z(254)+2*Z(379)*Z(270)-2*Z(79)*Z(298)-2*Z(
     &80)*Z(326)-2*Z(78)*Z(11)-Z(82)*Z(344))
      Z(310) = -Z(15)*Z(306) - Z(16)*Z(308)
      Z(380) = Z(17)*Z(19) - Z(18)*Z(20)
      Z(118) = Z(1)*Z(58) + Z(2)*Z(59)
      Z(426) = MF*(2*Z(379)+2*Z(79)*Z(17)+Z(81)*Z(310)+2*Z(338)*Z(258)+2
     &*Z(368)*Z(262)+2*Z(370)*Z(266)+2*Z(372)*Z(270)-2*Z(80)*Z(380)-2*Z(
     &378)*Z(15)-2*Z(78)*Z(118)-Z(82)*Z(352))
      Z(105) = Z(1)*Z(36) + Z(2)*Z(37)
      Z(429) = MG*(Z(82)*Z(231)+2*Z(75)*Z(242)+2*Z(76)*Z(258)+2*Z(79)*Z(
     &274)+2*Z(80)*Z(314)-2*Z(338)-2*Z(368)*Z(3)-2*Z(370)*Z(26)-2*Z(372)
     &*Z(234)-2*Z(383)*Z(105)-Z(81)*Z(278))
      Z(438) = MH*(2*Z(368)+2*Z(338)*Z(3)+2*Z(370)*Z(5)+2*Z(372)*Z(238)+
     &2*Z(378)*Z(246)+2*Z(384)*Z(262)+2*Z(385)*Z(282)+2*Z(386)*Z(286)-Z(
     &403)-2*Z(80)*Z(318)-2*Z(78)*Z(110))
      Z(439) = MH*(2*Z(370)+2*Z(338)*Z(26)+2*Z(368)*Z(5)+2*Z(372)*Z(9)+2
     &*Z(378)*Z(250)+2*Z(384)*Z(266)+2*Z(385)*Z(290)+2*Z(386)*Z(294)-2*Z
     &(80)*Z(322)-2*Z(78)*Z(29)-Z(82)*Z(341))
      Z(440) = MH*(2*Z(372)+2*Z(338)*Z(234)+2*Z(368)*Z(238)+2*Z(370)*Z(9
     &)+2*Z(378)*Z(254)+2*Z(384)*Z(270)+2*Z(385)*Z(298)+2*Z(386)*Z(302)-
     &2*Z(80)*Z(326)-2*Z(78)*Z(11)-Z(82)*Z(344))
      Z(442) = MH*(2*Z(384)+2*Z(338)*Z(258)+2*Z(368)*Z(262)+2*Z(370)*Z(2
     &66)+2*Z(372)*Z(270)+2*Z(386)*Z(310)-2*Z(80)*Z(380)-2*Z(378)*Z(15)-
     &2*Z(385)*Z(17)-2*Z(78)*Z(118)-Z(82)*Z(352))
      Z(124) = Z(1)*Z(46) + Z(2)*Z(47)
      Z(444) = MH*(Z(443)+2*Z(80)*Z(19)+2*Z(378)*Z(40)+2*Z(338)*Z(274)+2
     &*Z(368)*Z(282)+2*Z(370)*Z(290)+2*Z(372)*Z(298)-2*Z(384)*Z(17)-2*Z(
     &78)*Z(124)-Z(82)*Z(356))
      Z(387) = -Z(7)*Z(19) - Z(8)*Z(20)
      Z(448) = MH*(Z(447)+2*Z(338)*Z(278)+2*Z(368)*Z(286)+2*Z(370)*Z(294
     &)+2*Z(372)*Z(302)+2*Z(378)*Z(306)+2*Z(384)*Z(310)-2*Z(80)*Z(387)-2
     &*Z(78)*Z(143)-Z(82)*Z(364))
      Z(449) = MI*(Z(82)*Z(231)+2*Z(75)*Z(242)+2*Z(76)*Z(258)+2*Z(79)*Z(
     &274)-2*Z(338)-2*Z(368)*Z(3)-2*Z(370)*Z(26)-2*Z(372)*Z(234)-2*Z(391
     &)*Z(314)-2*Z(390)*Z(105)-Z(81)*Z(278))
      Z(330) = INE*EAp
      Z(120) = Z(1)*Z(59) - Z(2)*Z(58)
      Z(126) = Z(1)*Z(47) - Z(2)*Z(46)
      Z(434) = MG*GSp*(2*Z(75)*Z(14)+Z(81)*Z(145)+2*Z(338)*Z(107)+2*Z(36
     &8)*Z(112)+2*Z(370)*Z(30)-2*Z(76)*Z(120)-2*Z(79)*Z(126)-2*Z(80)*Z(1
     &32)-2*Z(372)*Z(12)-Z(82)*Z(136))
      Z(394) = MA*(Z(81)*Z(63)+2*Z(337)*Z(37)-2*Z(73)*Z(33)-2*Z(74)*Z(55
     &)-2*Z(75)*Z(44)-2*Z(76)*Z(59)-2*Z(79)*Z(47)-2*Z(80)*Z(67)-2*Z(78)*
     &Z(2)-Z(72)*Z(51)-Z(82)*Z(84))
      Z(398) = MB*(Z(81)*Z(63)+2*Z(338)*Z(37)+2*Z(339)*Z(51)+2*Z(340)*Z(
     &84)-2*Z(73)*Z(33)-2*Z(74)*Z(55)-2*Z(75)*Z(44)-2*Z(76)*Z(59)-2*Z(79
     &)*Z(47)-2*Z(80)*Z(67)-2*Z(78)*Z(2))
      Z(406) = MC*(Z(81)*Z(63)+2*Z(338)*Z(37)+2*Z(368)*Z(51)+2*Z(369)*Z(
     &33)-2*Z(74)*Z(55)-2*Z(75)*Z(44)-2*Z(76)*Z(59)-2*Z(79)*Z(47)-2*Z(80
     &)*Z(67)-2*Z(78)*Z(2)-Z(82)*Z(84))
      Z(412) = MD*(Z(81)*Z(63)+2*Z(338)*Z(37)+2*Z(368)*Z(51)+2*Z(370)*Z(
     &33)+2*Z(371)*Z(55)-2*Z(75)*Z(44)-2*Z(76)*Z(59)-2*Z(79)*Z(47)-2*Z(8
     &0)*Z(67)-2*Z(78)*Z(2)-Z(82)*Z(84))
      Z(419) = ME*(Z(81)*Z(63)+2*Z(338)*Z(37)+2*Z(368)*Z(51)+2*Z(370)*Z(
     &33)+2*Z(372)*Z(55)+2*Z(373)*Z(44)-2*Z(76)*Z(59)-2*Z(79)*Z(47)-2*Z(
     &80)*Z(67)-2*Z(78)*Z(2)-Z(82)*Z(84))
      Z(427) = MF*(Z(81)*Z(63)+2*Z(338)*Z(37)+2*Z(368)*Z(51)+2*Z(370)*Z(
     &33)+2*Z(372)*Z(55)+2*Z(378)*Z(44)+2*Z(379)*Z(59)-2*Z(79)*Z(47)-2*Z
     &(80)*Z(67)-2*Z(78)*Z(2)-Z(82)*Z(84))
      Z(435) = MG*(Z(82)*Z(83)+2*Z(75)*Z(43)+2*Z(76)*Z(58)+2*Z(79)*Z(46)
     &+2*Z(80)*Z(66)-2*Z(338)*Z(36)-2*Z(368)*Z(50)-2*Z(370)*Z(32)-2*Z(37
     &2)*Z(54)-2*Z(383)*Z(1)-Z(81)*Z(62))
      Z(446) = MH*(2*Z(338)*Z(37)+2*Z(368)*Z(51)+2*Z(370)*Z(33)+2*Z(372)
     &*Z(55)+2*Z(378)*Z(44)+2*Z(384)*Z(59)+2*Z(385)*Z(47)+2*Z(386)*Z(63)
     &-2*Z(80)*Z(67)-2*Z(78)*Z(2)-Z(82)*Z(84))
      Z(455) = MI*(Z(82)*Z(83)+2*Z(75)*Z(43)+2*Z(76)*Z(58)+2*Z(79)*Z(46)
     &-2*Z(338)*Z(36)-2*Z(368)*Z(50)-2*Z(370)*Z(32)-2*Z(372)*Z(54)-2*Z(3
     &91)*Z(66)-2*Z(390)*Z(1)-Z(81)*Z(62))
      Z(392) = MA*(2*Z(337)+Z(81)*Z(278)-2*Z(73)*Z(26)-2*Z(74)*Z(234)-2*
     &Z(75)*Z(242)-2*Z(76)*Z(258)-2*Z(79)*Z(274)-2*Z(80)*Z(314)-2*Z(78)*
     &Z(105)-Z(72)*Z(3)-Z(82)*Z(231))
      Z(395) = MB*(2*Z(338)+Z(81)*Z(278)+2*Z(339)*Z(3)+2*Z(340)*Z(231)-2
     &*Z(73)*Z(26)-2*Z(74)*Z(234)-2*Z(75)*Z(242)-2*Z(76)*Z(258)-2*Z(79)*
     &Z(274)-2*Z(80)*Z(314)-2*Z(78)*Z(105))
      Z(402) = MC*(2*Z(338)+Z(81)*Z(278)+2*Z(368)*Z(3)+2*Z(369)*Z(26)-2*
     &Z(74)*Z(234)-2*Z(75)*Z(242)-2*Z(76)*Z(258)-2*Z(79)*Z(274)-2*Z(80)*
     &Z(314)-2*Z(78)*Z(105)-Z(82)*Z(231))
      Z(408) = MD*(2*Z(338)+Z(81)*Z(278)+2*Z(368)*Z(3)+2*Z(370)*Z(26)+2*
     &Z(371)*Z(234)-2*Z(75)*Z(242)-2*Z(76)*Z(258)-2*Z(79)*Z(274)-2*Z(80)
     &*Z(314)-2*Z(78)*Z(105)-Z(82)*Z(231))
      Z(414) = ME*(2*Z(338)+Z(81)*Z(278)+2*Z(368)*Z(3)+2*Z(370)*Z(26)+2*
     &Z(372)*Z(234)+2*Z(373)*Z(242)-2*Z(76)*Z(258)-2*Z(79)*Z(274)-2*Z(80
     &)*Z(314)-2*Z(78)*Z(105)-Z(82)*Z(231))
      Z(374) = Z(20)*Z(42) - Z(19)*Z(40)
      Z(418) = ME*(2*Z(79)*Z(40)+2*Z(80)*Z(374)+2*Z(13)*Z(78)+Z(82)*Z(34
     &8)-2*Z(373)-2*Z(76)*Z(15)-2*Z(338)*Z(242)-2*Z(368)*Z(246)-2*Z(370)
     &*Z(250)-2*Z(372)*Z(254)-Z(81)*Z(306))
      Z(421) = MF*(2*Z(338)+Z(81)*Z(278)+2*Z(368)*Z(3)+2*Z(370)*Z(26)+2*
     &Z(372)*Z(234)+2*Z(378)*Z(242)+2*Z(379)*Z(258)-2*Z(79)*Z(274)-2*Z(8
     &0)*Z(314)-2*Z(78)*Z(105)-Z(82)*Z(231))
      Z(425) = MF*(2*Z(79)*Z(40)+2*Z(80)*Z(374)+2*Z(379)*Z(15)+2*Z(13)*Z
     &(78)+Z(82)*Z(348)-2*Z(378)-2*Z(338)*Z(242)-2*Z(368)*Z(246)-2*Z(370
     &)*Z(250)-2*Z(372)*Z(254)-Z(81)*Z(306))
      Z(430) = MG*(Z(403)+2*Z(75)*Z(246)+2*Z(76)*Z(262)+2*Z(79)*Z(282)+2
     &*Z(80)*Z(318)-2*Z(368)-2*Z(338)*Z(3)-2*Z(370)*Z(5)-2*Z(372)*Z(238)
     &-2*Z(383)*Z(110)-Z(81)*Z(286))
      Z(431) = MG*(Z(82)*Z(341)+2*Z(75)*Z(250)+2*Z(76)*Z(266)+2*Z(79)*Z(
     &290)+2*Z(80)*Z(322)-2*Z(370)-2*Z(338)*Z(26)-2*Z(368)*Z(5)-2*Z(372)
     &*Z(9)-2*Z(383)*Z(29)-Z(81)*Z(294))
      Z(432) = MG*(Z(82)*Z(344)+2*Z(75)*Z(254)+2*Z(76)*Z(270)+2*Z(79)*Z(
     &298)+2*Z(80)*Z(326)-2*Z(372)-2*Z(338)*Z(234)-2*Z(368)*Z(238)-2*Z(3
     &70)*Z(9)-2*Z(383)*Z(11)-Z(81)*Z(302))
      Z(130) = Z(1)*Z(66) + Z(2)*Z(67)
      Z(433) = MG*(2*Z(75)*Z(13)+Z(82)*Z(134)+2*Z(76)*Z(118)+2*Z(79)*Z(1
     &24)+2*Z(80)*Z(130)-2*Z(383)-2*Z(338)*Z(105)-2*Z(368)*Z(110)-2*Z(37
     &0)*Z(29)-2*Z(372)*Z(11)-Z(81)*Z(143))
      Z(437) = MH*(2*Z(338)+2*Z(368)*Z(3)+2*Z(370)*Z(26)+2*Z(372)*Z(234)
     &+2*Z(378)*Z(242)+2*Z(384)*Z(258)+2*Z(385)*Z(274)+2*Z(386)*Z(278)-2
     &*Z(80)*Z(314)-2*Z(78)*Z(105)-Z(82)*Z(231))
      Z(441) = MH*(2*Z(80)*Z(374)+2*Z(384)*Z(15)+2*Z(13)*Z(78)+Z(82)*Z(3
     &48)-2*Z(378)-2*Z(385)*Z(40)-2*Z(338)*Z(242)-2*Z(368)*Z(246)-2*Z(37
     &0)*Z(250)-2*Z(372)*Z(254)-2*Z(386)*Z(306))
      Z(450) = MI*(Z(403)+2*Z(75)*Z(246)+2*Z(76)*Z(262)+2*Z(79)*Z(282)-2
     &*Z(368)-2*Z(338)*Z(3)-2*Z(370)*Z(5)-2*Z(372)*Z(238)-2*Z(391)*Z(318
     &)-2*Z(390)*Z(110)-Z(81)*Z(286))
      Z(451) = MI*(Z(82)*Z(341)+2*Z(75)*Z(250)+2*Z(76)*Z(266)+2*Z(79)*Z(
     &290)-2*Z(370)-2*Z(338)*Z(26)-2*Z(368)*Z(5)-2*Z(372)*Z(9)-2*Z(391)*
     &Z(322)-2*Z(390)*Z(29)-Z(81)*Z(294))
      Z(452) = MI*(Z(82)*Z(344)+2*Z(75)*Z(254)+2*Z(76)*Z(270)+2*Z(79)*Z(
     &298)-2*Z(372)-2*Z(338)*Z(234)-2*Z(368)*Z(238)-2*Z(370)*Z(9)-2*Z(39
     &1)*Z(326)-2*Z(390)*Z(11)-Z(81)*Z(302))
      Z(453) = MI*(2*Z(75)*Z(13)+Z(82)*Z(134)+2*Z(76)*Z(118)+2*Z(79)*Z(1
     &24)-2*Z(390)-2*Z(338)*Z(105)-2*Z(368)*Z(110)-2*Z(370)*Z(29)-2*Z(37
     &2)*Z(11)-2*Z(391)*Z(130)-Z(81)*Z(143))
      Z(454) = MI*(2*Z(75)*Z(374)+2*Z(76)*Z(380)+Z(82)*Z(360)-2*Z(391)-2
     &*Z(79)*Z(19)-Z(81)*Z(387)-2*Z(338)*Z(314)-2*Z(368)*Z(318)-2*Z(370)
     &*Z(322)-2*Z(372)*Z(326)-2*Z(390)*Z(130))
      HZ = Z(332) + Z(334) + Z(336) + INA*U3 + INB*U3 + INC*U3 + IND*U3 
     &+ INE*U3 + INE*U8 + INF*U3 + INF*U8 + INF*U9 + ING*U3 + INH*U10 + 
     &INH*U3 + INH*U8 + INH*U9 + INI*U11 + INI*U3 + INI*U8 + INI*U9 + 0.
     &5D0*Z(393)*U2 + 0.5D0*Z(399)*U2 + 0.5D0*Z(407)*U2 + 0.5D0*Z(413)*U
     &2 + 0.5D0*Z(420)*U2 + 0.5D0*Z(428)*U2 + 0.5D0*Z(436)*U1 + 0.5D0*Z(
     &445)*U2 + 0.5D0*Z(456)*U1 + 0.25D0*Z(397)*Z(166) + 0.25D0*Z(401)*Z
     &(167) + 0.5D0*Z(404)*Z(175) + 0.5D0*Z(405)*Z(177) + 0.5D0*Z(409)*Z
     &(175) + 0.5D0*Z(410)*Z(179) + 0.5D0*Z(411)*Z(181) + 0.5D0*Z(415)*Z
     &(175) + 0.5D0*Z(416)*Z(179) + 0.5D0*Z(417)*Z(183) + 0.5D0*Z(422)*Z
     &(175) + 0.5D0*Z(423)*Z(179) + 0.5D0*Z(424)*Z(183) + 0.5D0*Z(426)*Z
     &(191) + 0.5D0*Z(429)*Z(164) + 0.5D0*Z(438)*Z(175) + 0.5D0*Z(439)*Z
     &(179) + 0.5D0*Z(440)*Z(183) + 0.5D0*Z(442)*Z(194) + 0.5D0*Z(444)*Z
     &(203) + 0.5D0*Z(448)*Z(204) + 0.5D0*Z(449)*Z(164) - Z(330) - 0.5D0
     &*Z(434) - IND*U7 - 0.5D0*Z(394)*U1 - 0.5D0*Z(398)*U1 - 0.5D0*Z(406
     &)*U1 - 0.5D0*Z(412)*U1 - 0.5D0*Z(419)*U1 - 0.5D0*Z(427)*U1 - 0.5D0
     &*Z(435)*U2 - 0.5D0*Z(446)*U1 - 0.5D0*Z(455)*U2 - INC*(U6+U7) - INB
     &*(U5+U6+U7) - INA*(U4+U5+U6+U7) - 0.5D0*Z(392)*Z(162) - 0.5D0*Z(39
     &5)*Z(164) - 0.5D0*Z(402)*Z(164) - 0.5D0*Z(408)*Z(164) - 0.5D0*Z(41
     &4)*Z(164) - 0.5D0*Z(418)*Z(185) - 0.5D0*Z(421)*Z(164) - 0.5D0*Z(42
     &5)*Z(188) - 0.5D0*Z(430)*Z(175) - 0.5D0*Z(431)*Z(179) - 0.5D0*Z(43
     &2)*Z(183) - 0.5D0*Z(433)*Z(197) - 0.5D0*Z(437)*Z(164) - 0.5D0*Z(44
     &1)*Z(188) - 0.5D0*Z(450)*Z(175) - 0.5D0*Z(451)*Z(179) - 0.5D0*Z(45
     &2)*Z(183) - 0.5D0*Z(453)*Z(201) - 0.5D0*Z(454)*Z(211)
      Z(485) = MG*GSp
      Z(494) = MH*Z(147)
      Z(502) = MI*Z(149)
      Z(486) = MG*GS
      Z(496) = MH*Z(148)
      Z(480) = MF*Z(141)
      Z(492) = MH*Z(142)
      Z(473) = ME*Z(139)
      Z(478) = MF*Z(140)
      Z(491) = MH*Z(140)
      PX = Z(485)*Z(1) + (MA+MB+MC+MD+ME+MF+MG+MH+MI)*U1 + 0.5D0*Z(460)*
     &Z(85)*(U3-U5-U6-U7) + Z(48)*(Z(494)+Z(493)*U10+Z(493)*U3+Z(493)*U8
     &+Z(493)*U9) + Z(68)*(Z(502)+Z(501)*U11+Z(501)*U3+Z(501)*U8+Z(501)*
     &U9) + (Z(467)+Z(471)+Z(477)+Z(484)+Z(490)+Z(500))*Z(56)*(U3-U7) + 
     &(Z(463)+Z(466)+Z(470)+Z(476)+Z(483)+Z(489)+Z(499))*Z(34)*(U3-U6-U7
     &) + 0.5D0*(Z(459)+2*Z(462)+2*Z(465)+2*Z(469)+2*Z(475)+2*Z(482)+2*Z
     &(488)+2*Z(498))*Z(52)*(U3-U5-U6-U7) - (Z(77)+Z(486))*Z(2)*U3 - 0.5
     &D0*Z(64)*(Z(496)+Z(495)*U10+Z(495)*U3+Z(495)*U8+Z(495)*U9) - (Z(45
     &7)+Z(458)+Z(461)+Z(464)+Z(468)+Z(474)+Z(481)+Z(487)+Z(497))*Z(38)*
     &(U3-U4-U5-U6-U7) - Z(60)*(Z(480)+Z(492)-Z(479)*U3-Z(479)*U8-Z(479)
     &*U9-Z(489)*U3-Z(489)*U8-Z(489)*U9) - Z(45)*(Z(473)+Z(478)+Z(491)-Z
     &(472)*U3-Z(472)*U8-Z(477)*U3-Z(477)*U8-Z(490)*U3-Z(490)*U8)
      PY = Z(485)*Z(2) + (Z(77)+Z(486))*Z(1)*U3 + (MA+MB+MC+MD+ME+MF+MG+
     &MH+MI)*U2 + 0.5D0*Z(460)*Z(86)*(U3-U5-U6-U7) + Z(49)*(Z(494)+Z(493
     &)*U10+Z(493)*U3+Z(493)*U8+Z(493)*U9) + Z(69)*(Z(502)+Z(501)*U11+Z(
     &501)*U3+Z(501)*U8+Z(501)*U9) + (Z(467)+Z(471)+Z(477)+Z(484)+Z(490)
     &+Z(500))*Z(57)*(U3-U7) + (Z(463)+Z(466)+Z(470)+Z(476)+Z(483)+Z(489
     &)+Z(499))*Z(35)*(U3-U6-U7) + 0.5D0*(Z(459)+2*Z(462)+2*Z(465)+2*Z(4
     &69)+2*Z(475)+2*Z(482)+2*Z(488)+2*Z(498))*Z(53)*(U3-U5-U6-U7) - 0.5
     &D0*Z(65)*(Z(496)+Z(495)*U10+Z(495)*U3+Z(495)*U8+Z(495)*U9) - (Z(45
     &7)+Z(458)+Z(461)+Z(464)+Z(468)+Z(474)+Z(481)+Z(487)+Z(497))*Z(39)*
     &(U3-U4-U5-U6-U7) - Z(61)*(Z(480)+Z(492)-Z(479)*U3-Z(479)*U8-Z(479)
     &*U9-Z(489)*U3-Z(489)*U8-Z(489)*U9) - Z(43)*(Z(473)+Z(478)+Z(491)-Z
     &(472)*U3-Z(472)*U8-Z(477)*U3-Z(477)*U8-Z(490)*U3-Z(490)*U8)
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
      Z(522) = Z(520)*Z(43) + Z(521)*Z(69) + L2*Z(69)*Z(227) + Z(223)*(L
     &10*Z(43)+Z(22)*Z(61)) - 0.5D0*Z(225)*(L3*Z(65)-2*L10*Z(43)-2*L8*Z(
     &61)-2*Z(24)*Z(49))
      Z(648) = Z(538) + Z(540) + Z(542) + Z(472)*(Z(243)*Z(165)-Z(186)-Z
     &(247)*Z(176)-Z(251)*Z(180)-Z(255)*Z(184)) + Z(501)*(Z(212)+Z(315)*
     &Z(165)-Z(131)*Z(202)-Z(319)*Z(176)-Z(323)*Z(180)-Z(327)*Z(184)) + 
     &MF*(L10*Z(15)*Z(192)+Z(22)*Z(15)*Z(189)+L10*Z(16)*Z(193)+L10*Z(243
     &)*Z(165)+Z(22)*Z(259)*Z(165)-L10*Z(189)-Z(22)*Z(192)-L10*Z(247)*Z(
     &176)-L10*Z(251)*Z(180)-L10*Z(255)*Z(184)-Z(22)*Z(16)*Z(190)-Z(22)*
     &Z(263)*Z(176)-Z(22)*Z(267)*Z(180)-Z(22)*Z(271)*Z(184)) + 0.25D0*MH
     &*(L3*Z(206)+4*Z(24)*Z(205)+4*L10*Z(15)*Z(195)+4*L10*Z(40)*Z(205)+4
     &*L8*Z(15)*Z(189)+4*Z(24)*Z(17)*Z(195)+2*L3*Z(189)*Z(309)+2*L3*Z(19
     &5)*Z(313)+2*Z(615)*Z(207)+4*Z(617)*Z(208)+2*L3*Z(287)*Z(176)+2*L3*
     &Z(295)*Z(180)+2*L3*Z(303)*Z(184)+2*L3*Z(307)*Z(190)+2*L3*Z(311)*Z(
     &196)+4*L10*Z(16)*Z(196)+4*L10*Z(243)*Z(165)+4*L8*Z(259)*Z(165)+4*Z
     &(24)*Z(18)*Z(196)+4*Z(24)*Z(275)*Z(165)-4*L10*Z(189)-4*L8*Z(195)-2
     &*Z(618)*Z(205)-2*Z(619)*Z(206)-4*L8*Z(17)*Z(205)-4*Z(24)*Z(40)*Z(1
     &89)-2*L10*Z(206)*Z(309)-2*L8*Z(206)*Z(313)-4*L10*Z(41)*Z(207)-4*L1
     &0*Z(247)*Z(176)-4*L10*Z(251)*Z(180)-4*L10*Z(255)*Z(184)-4*L10*Z(30
     &8)*Z(208)-4*L8*Z(16)*Z(190)-4*L8*Z(18)*Z(207)-4*L8*Z(263)*Z(176)-4
     &*L8*Z(267)*Z(180)-4*L8*Z(271)*Z(184)-4*L8*Z(312)*Z(208)-4*Z(24)*Z(
     &42)*Z(190)-4*Z(24)*Z(283)*Z(176)-4*Z(24)*Z(291)*Z(180)-4*Z(24)*Z(2
     &99)*Z(184)-2*L3*Z(279)*Z(165)) - Z(536)
      Z(682) = Z(522) - Z(648)
      Z(641) = Z(640) - Z(472)*(L2*Z(245)-Z(21)-L10*Z(257)-L6*Z(249)-L8*
     &Z(253)) - Z(501)*(L2*Z(317)-Z(25)-L10*Z(329)-L11*Z(133)-L6*Z(321)-
     &L8*Z(325)) - MF*(2*Z(582)*Z(15)+Z(573)*Z(245)+Z(583)*Z(261)-Z(575)
     &-Z(584)-Z(575)*Z(257)-Z(577)*Z(249)-Z(578)*Z(253)-Z(582)*Z(273)-Z(
     &585)*Z(265)-Z(586)*Z(269)) - 0.25D0*MH*(4*Z(598)+8*Z(578)*Z(15)+8*
     &Z(599)*Z(17)+2*Z(600)*Z(305)+2*Z(601)*Z(289)+2*Z(602)*Z(297)+4*Z(5
     &66)*Z(261)+4*Z(573)*Z(245)+4*Z(600)*Z(309)+4*Z(602)*Z(313)+4*Z(603
     &)*Z(277)-4*Z(568)-4*Z(575)-4*Z(605)-Z(604)-8*Z(606)*Z(40)-4*Z(568)
     &*Z(269)-4*Z(570)*Z(265)-4*Z(575)*Z(257)-4*Z(577)*Z(249)-4*Z(578)*Z
     &(253)-4*Z(578)*Z(273)-4*Z(599)*Z(293)-4*Z(606)*Z(301)-4*Z(607)*Z(2
     &85)-2*Z(558)*Z(281))
      Z(642) = Z(472)*Z(43) + Z(501)*Z(69) + MF*(L10*Z(43)+Z(22)*Z(61)) 
     &- 0.5D0*MH*(L3*Z(65)-2*L10*Z(43)-2*L8*Z(61)-2*Z(24)*Z(49))
      Z(643) = Z(472)*Z(45) + Z(501)*Z(68) + MF*(L10*Z(45)+Z(22)*Z(60)) 
     &- 0.5D0*MH*(L3*Z(64)-2*L10*Z(45)-2*L8*Z(60)-2*Z(24)*Z(48))
      Z(644) = Z(472)*(L2*Z(245)-L10*Z(257)-L6*Z(249)-L8*Z(253)) + Z(501
     &)*(L2*Z(317)-L10*Z(329)-L6*Z(321)-L8*Z(325)) + MF*(Z(573)*Z(245)+Z
     &(583)*Z(261)-Z(575)*Z(257)-Z(577)*Z(249)-Z(578)*Z(253)-Z(582)*Z(27
     &3)-Z(585)*Z(265)-Z(586)*Z(269)) + 0.5D0*MH*(Z(600)*Z(305)+Z(601)*Z
     &(289)+Z(602)*Z(297)+2*Z(566)*Z(261)+2*Z(573)*Z(245)+2*Z(603)*Z(277
     &)-2*Z(568)*Z(269)-2*Z(570)*Z(265)-2*Z(575)*Z(257)-2*Z(577)*Z(249)-
     &2*Z(578)*Z(253)-2*Z(578)*Z(273)-2*Z(599)*Z(293)-2*Z(606)*Z(301)-2*
     &Z(607)*Z(285)-Z(558)*Z(281))
      Z(645) = Z(472)*(L2*Z(245)-L6*Z(249)-L8*Z(253)) + Z(501)*(L2*Z(317
     &)-L6*Z(321)-L8*Z(325)) + MF*(Z(573)*Z(245)+Z(583)*Z(261)-Z(577)*Z(
     &249)-Z(578)*Z(253)-Z(585)*Z(265)-Z(586)*Z(269)) + 0.5D0*MH*(Z(601)
     &*Z(289)+Z(602)*Z(297)+2*Z(566)*Z(261)+2*Z(573)*Z(245)+2*Z(603)*Z(2
     &77)-2*Z(568)*Z(269)-2*Z(570)*Z(265)-2*Z(577)*Z(249)-2*Z(578)*Z(253
     &)-2*Z(599)*Z(293)-2*Z(607)*Z(285)-Z(558)*Z(281))
      Z(646) = Z(472)*(L2*Z(245)-L6*Z(249)) + Z(501)*(L2*Z(317)-L6*Z(321
     &)) + MF*(Z(573)*Z(245)+Z(583)*Z(261)-Z(577)*Z(249)-Z(585)*Z(265)) 
     &+ 0.5D0*MH*(Z(601)*Z(289)+2*Z(566)*Z(261)+2*Z(573)*Z(245)+2*Z(603)
     &*Z(277)-2*Z(570)*Z(265)-2*Z(577)*Z(249)-2*Z(607)*Z(285)-Z(558)*Z(2
     &81))
      Z(647) = L2*(2*Z(472)*Z(245)+2*Z(501)*Z(317)+2*MF*(L10*Z(245)+Z(22
     &)*Z(261))-MH*(L3*Z(281)-2*L10*Z(245)-2*L8*Z(261)-2*Z(24)*Z(277)))
      SHTOR = Z(682) - Z(641)*U3p - Z(642)*U2p - Z(643)*U1p - Z(644)*U7p
     & - Z(645)*U6p - Z(646)*U5p - 0.5D0*Z(647)*U4p
      Z(650) = Z(649) - Z(479)*(L10*Z(15)+L2*Z(261)-Z(22)-L10*Z(273)-L6*
     &Z(265)-L8*Z(269)) - Z(501)*(L2*Z(317)-Z(25)-L10*Z(329)-L11*Z(133)-
     &L6*Z(321)-L8*Z(325)) - 0.25D0*MH*(4*Z(598)+4*Z(578)*Z(15)+8*Z(599)
     &*Z(17)+2*Z(600)*Z(305)+2*Z(600)*Z(309)+2*Z(601)*Z(289)+2*Z(602)*Z(
     &297)+4*Z(566)*Z(261)+4*Z(602)*Z(313)+4*Z(603)*Z(277)-4*Z(568)-4*Z(
     &605)-Z(604)-4*Z(606)*Z(40)-4*Z(568)*Z(269)-4*Z(570)*Z(265)-4*Z(578
     &)*Z(273)-4*Z(599)*Z(293)-4*Z(606)*Z(301)-4*Z(607)*Z(285)-2*Z(558)*
     &Z(281))
      Z(651) = Z(479)*Z(60) + Z(501)*Z(68) - 0.5D0*MH*(L3*Z(64)-2*L8*Z(6
     &0)-2*Z(24)*Z(48))
      Z(652) = Z(479)*Z(61) + Z(501)*Z(69) - 0.5D0*MH*(L3*Z(65)-2*L8*Z(6
     &1)-2*Z(24)*Z(49))
      Z(653) = Z(479)*(L2*Z(261)-L10*Z(273)-L6*Z(265)-L8*Z(269)) + Z(501
     &)*(L2*Z(317)-L10*Z(329)-L6*Z(321)-L8*Z(325)) + 0.5D0*MH*(Z(600)*Z(
     &305)+Z(601)*Z(289)+Z(602)*Z(297)+2*Z(566)*Z(261)+2*Z(603)*Z(277)-2
     &*Z(568)*Z(269)-2*Z(570)*Z(265)-2*Z(578)*Z(273)-2*Z(599)*Z(293)-2*Z
     &(606)*Z(301)-2*Z(607)*Z(285)-Z(558)*Z(281))
      Z(654) = Z(479)*(L2*Z(261)-L6*Z(265)-L8*Z(269)) + Z(501)*(L2*Z(317
     &)-L6*Z(321)-L8*Z(325)) + 0.5D0*MH*(Z(601)*Z(289)+Z(602)*Z(297)+2*Z
     &(566)*Z(261)+2*Z(603)*Z(277)-2*Z(568)*Z(269)-2*Z(570)*Z(265)-2*Z(5
     &99)*Z(293)-2*Z(607)*Z(285)-Z(558)*Z(281))
      Z(655) = Z(479)*(L2*Z(261)-L6*Z(265)) + Z(501)*(L2*Z(317)-L6*Z(321
     &)) + 0.5D0*MH*(Z(601)*Z(289)+2*Z(566)*Z(261)+2*Z(603)*Z(277)-2*Z(5
     &70)*Z(265)-2*Z(607)*Z(285)-Z(558)*Z(281))
      Z(656) = L2*(2*Z(479)*Z(261)+2*Z(501)*Z(317)-MH*(L3*Z(281)-2*L8*Z(
     &261)-2*Z(24)*Z(277)))
      Z(524) = Z(521)*Z(69) + Z(523)*Z(61) + L2*Z(69)*Z(227) - 0.5D0*Z(2
     &25)*(L3*Z(65)-2*L8*Z(61)-2*Z(24)*Z(49))
      Z(657) = Z(538) + Z(540) + Z(542) + Z(501)*(Z(212)+Z(315)*Z(165)-Z
     &(131)*Z(202)-Z(319)*Z(176)-Z(323)*Z(180)-Z(327)*Z(184)) + Z(479)*(
     &Z(15)*Z(189)+Z(259)*Z(165)-Z(192)-Z(16)*Z(190)-Z(263)*Z(176)-Z(267
     &)*Z(180)-Z(271)*Z(184)) + 0.25D0*MH*(L3*Z(206)+4*Z(24)*Z(205)+4*L8
     &*Z(15)*Z(189)+4*Z(24)*Z(17)*Z(195)+2*L3*Z(189)*Z(309)+2*L3*Z(195)*
     &Z(313)+2*Z(615)*Z(207)+4*Z(617)*Z(208)+2*L3*Z(287)*Z(176)+2*L3*Z(2
     &95)*Z(180)+2*L3*Z(303)*Z(184)+2*L3*Z(307)*Z(190)+2*L3*Z(311)*Z(196
     &)+4*L8*Z(259)*Z(165)+4*Z(24)*Z(18)*Z(196)+4*Z(24)*Z(275)*Z(165)-4*
     &L8*Z(195)-2*Z(618)*Z(205)-2*Z(619)*Z(206)-4*L8*Z(17)*Z(205)-4*Z(24
     &)*Z(40)*Z(189)-2*L8*Z(206)*Z(313)-4*L8*Z(16)*Z(190)-4*L8*Z(18)*Z(2
     &07)-4*L8*Z(263)*Z(176)-4*L8*Z(267)*Z(180)-4*L8*Z(271)*Z(184)-4*L8*
     &Z(312)*Z(208)-4*Z(24)*Z(42)*Z(190)-4*Z(24)*Z(283)*Z(176)-4*Z(24)*Z
     &(291)*Z(180)-4*Z(24)*Z(299)*Z(184)-2*L3*Z(279)*Z(165))
      Z(683) = Z(524) - Z(657)
      SKTOR = Z(650)*U3p + Z(651)*U1p + Z(652)*U2p + Z(653)*U7p + Z(654)
     &*U6p + Z(655)*U5p + 0.5D0*Z(656)*U4p - Z(683)
      Z(525) = Z(225)*(L3*Z(65)-2*Z(24)*Z(49))
      Z(665) = Z(540) + 0.25D0*MH*(L3*Z(206)+4*Z(24)*Z(205)+4*Z(24)*Z(17
     &)*Z(195)+2*L3*Z(189)*Z(309)+2*L3*Z(195)*Z(313)+2*Z(615)*Z(207)+4*Z
     &(617)*Z(208)+2*L3*Z(287)*Z(176)+2*L3*Z(295)*Z(180)+2*L3*Z(303)*Z(1
     &84)+2*L3*Z(307)*Z(190)+2*L3*Z(311)*Z(196)+4*Z(24)*Z(18)*Z(196)+4*Z
     &(24)*Z(275)*Z(165)-2*Z(618)*Z(205)-2*Z(619)*Z(206)-4*Z(24)*Z(40)*Z
     &(189)-4*Z(24)*Z(42)*Z(190)-4*Z(24)*Z(283)*Z(176)-4*Z(24)*Z(291)*Z(
     &180)-4*Z(24)*Z(299)*Z(184)-2*L3*Z(279)*Z(165))
      Z(684) = -0.5D0*Z(525) - Z(665)
      Z(526) = Z(69)*(Z(521)+L2*Z(227))
      Z(674) = Z(542) + Z(501)*(Z(212)+Z(315)*Z(165)-Z(131)*Z(202)-Z(319
     &)*Z(176)-Z(323)*Z(180)-Z(327)*Z(184))
      Z(685) = Z(526) - Z(674)
      Z(693) = -Z(684) - Z(685)
      Z(667) = Z(501)*Z(68)
      Z(659) = MH*(L3*Z(64)-2*Z(24)*Z(48))
      Z(686) = Z(667) - 0.5D0*Z(659)
      Z(668) = Z(501)*Z(69)
      Z(660) = MH*(L3*Z(65)-2*Z(24)*Z(49))
      Z(687) = Z(668) - 0.5D0*Z(660)
      Z(673) = Z(672)*Z(317)
      Z(664) = Z(487)*(L3*Z(281)-2*Z(24)*Z(277))
      Z(688) = Z(673) - 0.5D0*Z(664)
      Z(658) = INH - 0.25D0*MH*(4*Z(598)+4*Z(599)*Z(17)+2*Z(600)*Z(305)+
     &2*Z(600)*Z(309)+2*Z(601)*Z(289)+2*Z(602)*Z(297)+2*Z(602)*Z(313)+4*
     &Z(603)*Z(277)-4*Z(605)-Z(604)-4*Z(606)*Z(40)-4*Z(599)*Z(293)-4*Z(6
     &06)*Z(301)-4*Z(607)*Z(285)-2*Z(558)*Z(281))
      Z(666) = INI - Z(501)*(L2*Z(317)-Z(25)-L10*Z(329)-L11*Z(133)-L6*Z(
     &321)-L8*Z(325))
      Z(689) = Z(658) + Z(666)
      Z(669) = Z(501)*(L2*Z(317)-L10*Z(329)-L6*Z(321)-L8*Z(325))
      Z(661) = MH*(Z(600)*Z(305)+Z(601)*Z(289)+Z(602)*Z(297)+2*Z(603)*Z(
     &277)-2*Z(599)*Z(293)-2*Z(606)*Z(301)-2*Z(607)*Z(285)-Z(558)*Z(281)
     &)
      Z(690) = Z(669) + 0.5D0*Z(661)
      Z(670) = Z(501)*(L2*Z(317)-L6*Z(321)-L8*Z(325))
      Z(662) = MH*(Z(601)*Z(289)+Z(602)*Z(297)+2*Z(603)*Z(277)-2*Z(599)*
     &Z(293)-2*Z(607)*Z(285)-Z(558)*Z(281))
      Z(691) = Z(670) + 0.5D0*Z(662)
      Z(671) = Z(501)*(L2*Z(317)-L6*Z(321))
      Z(663) = MH*(Z(601)*Z(289)+2*Z(603)*Z(277)-2*Z(607)*Z(285)-Z(558)*
     &Z(281))
      Z(692) = Z(671) + 0.5D0*Z(663)
      SATOR = Z(693) + Z(686)*U1p + Z(687)*U2p + Z(688)*U4p + Z(689)*U3p
     & + Z(690)*U7p + Z(691)*U6p + Z(692)*U5p
      SMTOR = Z(666)*U3p + Z(667)*U1p + Z(668)*U2p + Z(669)*U7p + Z(670)
     &*U6p + Z(671)*U5p + Z(673)*U4p - Z(685)
      POP1X = Q1
      POP1Y = Q2
      POP3X = Q1 + L5*Z(46) - L2*Z(36)
      POP3Y = Q2 + L5*Z(47) - L2*Z(37)
      POP4X = Q1 + L6*Z(50) - L2*Z(36)
      POP4Y = Q2 + L6*Z(51) - L2*Z(37)
      POP5X = Q1 + L6*Z(50) + L8*Z(32) - L2*Z(36)
      POP5Y = Q2 + L6*Z(51) + L8*Z(33) - L2*Z(37)
      POP6X = Q1 + L10*Z(54) + L6*Z(50) + L8*Z(32) - L2*Z(36)
      POP6Y = Q2 + L10*Z(55) + L6*Z(51) + L8*Z(33) - L2*Z(37)
      POP7X = Q1 + L10*Z(43) + L10*Z(54) + L6*Z(50) + L8*Z(32) - L2*Z(36
     &)
      POP7Y = Q2 + L10*Z(44) + L10*Z(55) + L6*Z(51) + L8*Z(33) - L2*Z(37
     &)
      POP8X = Q1 + L10*Z(43) + L10*Z(54) + L6*Z(50) + L8*Z(32) + L8*Z(58
     &) - L2*Z(36)
      POP8Y = Q2 + L10*Z(44) + L10*Z(55) + L6*Z(51) + L8*Z(33) + L8*Z(59
     &) - L2*Z(37)
      POP9X = Q1 + L10*Z(54) + L11*Z(1) + L6*Z(50) + L8*Z(32) - L2*Z(36)
      POP9Y = Q2 + L10*Z(55) + L11*Z(2) + L6*Z(51) + L8*Z(33) - L2*Z(37)
      POGOX = Q1 + L10*Z(54) + L6*Z(50) + L8*Z(32) + GS*Z(1) - L2*Z(36)
      POGOY = Q2 + L10*Z(55) + L6*Z(51) + L8*Z(33) + GS*Z(2) - L2*Z(37)
      POP10X = Q1 + L10*Z(54) + L11*Z(1) + L6*Z(50) + L8*Z(32) - L2*Z(36
     &) - L5*Z(62)
      POP10Y = Q2 + L10*Z(55) + L11*Z(2) + L6*Z(51) + L8*Z(33) - L2*Z(37
     &) - L5*Z(63)
      POP11X = Q1 + L10*Z(54) + L11*Z(1) + L2*Z(66) + L6*Z(50) + L8*Z(32
     &) - L2*Z(36)
      POP11Y = Q2 + L10*Z(55) + L11*Z(2) + L2*Z(67) + L6*Z(51) + L8*Z(33
     &) - L2*Z(37)
      POCMX = Q1 + Z(73)*Z(32) + Z(74)*Z(54) + Z(75)*Z(43) + Z(76)*Z(58)
     & + Z(79)*Z(46) + Z(80)*Z(66) + Z(78)*Z(1) + 0.5D0*Z(72)*Z(50) + 0.
     &5D0*Z(82)*Z(83) - Z(71)*Z(36) - 0.5D0*Z(81)*Z(62)
      POCMSTANCEX = Q1 + Z(90)*Z(32) + Z(91)*Z(54) + 0.5D0*Z(89)*Z(50) +
     & 0.5D0*Z(92)*Z(83) - Z(88)*Z(36)
      POCMSTANCEY = Q2 + Z(90)*Z(33) + Z(91)*Z(55) + 0.5D0*Z(89)*Z(51) +
     & 0.5D0*Z(92)*Z(84) - Z(88)*Z(37)
      POCMSWINGX = Q1 + Z(95)*Z(50) + Z(96)*Z(32) + Z(97)*Z(54) + Z(98)*
     &Z(43) + Z(99)*Z(58) + Z(100)*Z(1) + Z(101)*Z(46) + Z(102)*Z(66) - 
     &Z(94)*Z(36) - 0.5D0*Z(103)*Z(62)
      POCMSWINGY = Q2 + Z(95)*Z(51) + Z(96)*Z(33) + Z(97)*Z(55) + Z(98)*
     &Z(44) + Z(99)*Z(59) + Z(100)*Z(2) + Z(101)*Z(47) + Z(102)*Z(67) - 
     &Z(94)*Z(37) - 0.5D0*Z(103)*Z(63)
      Z(151) = MG*GSp/Z(70)
      Z(152) = Z(75)*EAp
      Z(153) = Z(76)*(EAp-FAp)
      Z(154) = Z(79)*(FAp-EAp-HAp)
      Z(155) = Z(80)*(FAp-EAp-IAp)
      Z(156) = Z(81)*(FAp-EAp-HAp)
      Z(157) = Z(98)*EAp
      Z(158) = Z(99)*(EAp-FAp)
      Z(159) = Z(101)*(FAp-EAp-HAp)
      Z(160) = Z(102)*(FAp-EAp-IAp)
      Z(161) = Z(103)*(FAp-EAp-HAp)
      VOCMX = Z(151)*Z(1) + U1 + Z(74)*Z(56)*(U3-U7) + Z(73)*Z(34)*(U3-U
     &6-U7) + 0.5D0*Z(72)*Z(52)*(U3-U5-U6-U7) + 0.5D0*Z(82)*Z(85)*(U3-U5
     &-U6-U7) + Z(48)*(Z(154)+Z(79)*U10+Z(79)*U3+Z(79)*U8+Z(79)*U9) + Z(
     &68)*(Z(155)+Z(80)*U11+Z(80)*U3+Z(80)*U8+Z(80)*U9) - Z(78)*Z(2)*U3 
     &- Z(45)*(Z(152)-Z(75)*U3-Z(75)*U8) - 0.5D0*Z(64)*(Z(156)+Z(81)*U10
     &+Z(81)*U3+Z(81)*U8+Z(81)*U9) - Z(71)*Z(38)*(U3-U4-U5-U6-U7) - Z(60
     &)*(Z(153)-Z(76)*U3-Z(76)*U8-Z(76)*U9)
      VOCMY = Z(151)*Z(2) + U2 + Z(78)*Z(1)*U3 + Z(74)*Z(57)*(U3-U7) + Z
     &(73)*Z(35)*(U3-U6-U7) + 0.5D0*Z(72)*Z(53)*(U3-U5-U6-U7) + 0.5D0*Z(
     &82)*Z(86)*(U3-U5-U6-U7) + Z(49)*(Z(154)+Z(79)*U10+Z(79)*U3+Z(79)*U
     &8+Z(79)*U9) + Z(69)*(Z(155)+Z(80)*U11+Z(80)*U3+Z(80)*U8+Z(80)*U9) 
     &- Z(43)*(Z(152)-Z(75)*U3-Z(75)*U8) - 0.5D0*Z(65)*(Z(156)+Z(81)*U10
     &+Z(81)*U3+Z(81)*U8+Z(81)*U9) - Z(71)*Z(39)*(U3-U4-U5-U6-U7) - Z(61
     &)*(Z(153)-Z(76)*U3-Z(76)*U8-Z(76)*U9)
      VOCMSTANCEX = U1 + Z(91)*Z(56)*(U3-U7) + Z(90)*Z(34)*(U3-U6-U7) + 
     &0.5D0*Z(89)*Z(52)*(U3-U5-U6-U7) + 0.5D0*Z(92)*Z(85)*(U3-U5-U6-U7) 
     &- Z(88)*Z(38)*(U3-U4-U5-U6-U7)
      VOCMSTANCEY = U2 + Z(91)*Z(57)*(U3-U7) + Z(90)*Z(35)*(U3-U6-U7) + 
     &0.5D0*Z(89)*Z(53)*(U3-U5-U6-U7) + 0.5D0*Z(92)*Z(86)*(U3-U5-U6-U7) 
     &- Z(88)*Z(39)*(U3-U4-U5-U6-U7)
      VOCMSWINGX = U1 + Z(97)*Z(56)*(U3-U7) + Z(96)*Z(34)*(U3-U6-U7) + Z
     &(95)*Z(52)*(U3-U5-U6-U7) + Z(48)*(Z(159)+Z(101)*U10+Z(101)*U3+Z(10
     &1)*U8+Z(101)*U9) + Z(68)*(Z(160)+Z(102)*U11+Z(102)*U3+Z(102)*U8+Z(
     &102)*U9) - Z(100)*Z(2)*U3 - Z(45)*(Z(157)-Z(98)*U3-Z(98)*U8) - 0.5
     &D0*Z(64)*(Z(161)+Z(103)*U10+Z(103)*U3+Z(103)*U8+Z(103)*U9) - Z(94)
     &*Z(38)*(U3-U4-U5-U6-U7) - Z(60)*(Z(158)-Z(99)*U3-Z(99)*U8-Z(99)*U9
     &)
      VOCMSWINGY = U2 + Z(100)*Z(1)*U3 + Z(97)*Z(57)*(U3-U7) + Z(96)*Z(3
     &5)*(U3-U6-U7) + Z(95)*Z(53)*(U3-U5-U6-U7) + Z(49)*(Z(159)+Z(101)*U
     &10+Z(101)*U3+Z(101)*U8+Z(101)*U9) + Z(69)*(Z(160)+Z(102)*U11+Z(102
     &)*U3+Z(102)*U8+Z(102)*U9) - Z(43)*(Z(157)-Z(98)*U3-Z(98)*U8) - 0.5
     &D0*Z(65)*(Z(161)+Z(103)*U10+Z(103)*U3+Z(103)*U8+Z(103)*U9) - Z(94)
     &*Z(39)*(U3-U4-U5-U6-U7) - Z(61)*(Z(158)-Z(99)*U3-Z(99)*U8-Z(99)*U9
     &)
      SAANG = HA
      SMANG = IA
      SAANGVEL = HAp
      SMANGVEL = IAp
      PSWINGX = (ME+MF)*U1 + (Z(471)+Z(477))*Z(56)*(U3-U7) + (Z(470)+Z(4
     &76))*Z(34)*(U3-U6-U7) + (Z(469)+Z(475))*Z(52)*(U3-U5-U6-U7) - Z(60
     &)*(Z(480)-Z(479)*U3-Z(479)*U8-Z(479)*U9) - (Z(468)+Z(474))*Z(38)*(
     &U3-U4-U5-U6-U7) - Z(45)*(Z(473)+Z(478)-Z(472)*U3-Z(472)*U8-Z(477)*
     &U3-Z(477)*U8)
      PSWINGY = (ME+MF)*U2 + (Z(471)+Z(477))*Z(57)*(U3-U7) + (Z(470)+Z(4
     &76))*Z(35)*(U3-U6-U7) + (Z(469)+Z(475))*Z(53)*(U3-U5-U6-U7) - Z(61
     &)*(Z(480)-Z(479)*U3-Z(479)*U8-Z(479)*U9) - (Z(468)+Z(474))*Z(39)*(
     &U3-U4-U5-U6-U7) - Z(43)*(Z(473)+Z(478)-Z(472)*U3-Z(472)*U8-Z(477)*
     &U3-Z(477)*U8)
      PSTANCEX = (MA+MB+MC+MD)*U1 + Z(467)*Z(56)*(U3-U7) + (Z(463)+Z(466
     &))*Z(34)*(U3-U6-U7) + 0.5D0*Z(460)*Z(85)*(U3-U5-U6-U7) + 0.5D0*(Z(
     &459)+2*Z(462)+2*Z(465))*Z(52)*(U3-U5-U6-U7) - (Z(457)+Z(458)+Z(461
     &)+Z(464))*Z(38)*(U3-U4-U5-U6-U7)
      PSTANCEY = (MA+MB+MC+MD)*U2 + Z(467)*Z(57)*(U3-U7) + (Z(463)+Z(466
     &))*Z(35)*(U3-U6-U7) + 0.5D0*Z(460)*Z(86)*(U3-U5-U6-U7) + 0.5D0*(Z(
     &459)+2*Z(462)+2*Z(465))*Z(53)*(U3-U5-U6-U7) - (Z(457)+Z(458)+Z(461
     &)+Z(464))*Z(39)*(U3-U4-U5-U6-U7)

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


