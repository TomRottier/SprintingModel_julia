C**   The name of this program is model/7segsprint.f
C**   Created by AUTOLEV 3.2 on Thu Feb 24 15:21:59 2022

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
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(694),COEF(7,7),RHS(7)

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
      Z(521) = Z(21)*Z(222)
      Z(650) = INF + INH + INI
      Z(22) = L8 - L7
      Z(480) = MF*Z(22)
      Z(225) = G*MH
      Z(7) = COS(FOOTANG)
      Z(25) = L2 - L1
      Z(502) = MI*Z(25)
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
      Z(79) = (L10*MF+L10*MH+ME*Z(21))/Z(74)
      Z(80) = (L8*MH+MF*Z(22))/Z(74)
      Z(81) = L11*MI
      Z(83) = MH*Z(24)/Z(74)
      Z(84) = MI*Z(25)/Z(74)
      Z(85) = L3*MH/Z(74)
      Z(86) = L3*MB/Z(74)
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
      Z(338) = Z(75) - L1
      Z(339) = Z(75) - L2
      Z(340) = 0.5D0*L4 - 0.5D0*Z(76)
      Z(341) = 0.5D0*L3 - 0.5D0*Z(86)
      Z(369) = L6 - 0.5D0*Z(76)
      Z(370) = L7 - Z(77)
      Z(371) = L8 - Z(77)
      Z(372) = L9 - Z(78)
      Z(373) = L10 - Z(78)
      Z(374) = Z(21) - Z(79)
      Z(379) = L10 - Z(79)
      Z(380) = Z(22) - Z(80)
      Z(385) = L8 - Z(80)
      Z(386) = Z(24) - Z(83)
      Z(387) = 0.5D0*Z(85) - 0.5D0*L3
      Z(392) = Z(25) - Z(84)
      Z(397) = 2*Z(340) + 2*Z(7)*Z(341)
      Z(401) = 2*Z(341) + 2*Z(7)*Z(340)
      Z(404) = Z(7)*Z(86)
      Z(444) = 2*Z(386) + 2*Z(7)*Z(387)
      Z(448) = 2*Z(387) + 2*Z(7)*Z(386)
      Z(458) = L1*MA
      Z(459) = L2*MB
      Z(460) = L4*MB
      Z(461) = L3*MB
      Z(462) = L2*MC
      Z(463) = L6*MC
      Z(464) = L7*MC
      Z(465) = L2*MD
      Z(466) = L6*MD
      Z(467) = L8*MD
      Z(468) = L9*MD
      Z(469) = L2*ME
      Z(470) = L6*ME
      Z(471) = L8*ME
      Z(472) = L10*ME
      Z(473) = ME*Z(21)
      Z(475) = L2*MF
      Z(476) = L6*MF
      Z(477) = L8*MF
      Z(478) = L10*MF
      Z(482) = L2*MG
      Z(483) = L6*MG
      Z(484) = L8*MG
      Z(485) = L10*MG
      Z(488) = L2*MH
      Z(489) = L6*MH
      Z(490) = L8*MH
      Z(491) = L10*MH
      Z(494) = MH*Z(24)
      Z(496) = L3*MH
      Z(498) = L2*MI
      Z(499) = L6*MI
      Z(500) = L8*MI
      Z(501) = L10*MI
      Z(505) = Z(218) + Z(219) + Z(220) + Z(221) + Z(222) + Z(223) + Z(2
     &24) + Z(225) + Z(226)
      Z(507) = L1*Z(218)
      Z(509) = L2*Z(219)
      Z(510) = L2*Z(220)
      Z(511) = L2*Z(221)
      Z(512) = L2*Z(222)
      Z(513) = L2*Z(223)
      Z(514) = L2*Z(224)
      Z(515) = L2*Z(225)
      Z(516) = L2*Z(226)
      Z(522) = Z(25)*Z(226)
      Z(524) = Z(22)*Z(223)
      Z(545) = L1*MA + L2*MB + L2*MC + L2*MD + L2*ME + L2*MF + L2*MG + L
     &2*MH + L2*MI
      Z(557) = INA + INB + INC + IND + INE + INF + ING + INH + INI + MA*
     &L1**2
      Z(558) = L3**2 + L4**2 + 4*L2**2 + 2*L3*L4*Z(7)
      Z(559) = L2*L3
      Z(560) = L2*L4
      Z(561) = L2*L6
      Z(562) = L2*L7
      Z(563) = L2**2
      Z(564) = L6**2
      Z(565) = L7**2
      Z(566) = L6*L7
      Z(567) = L2*L8
      Z(568) = L2*L9
      Z(569) = L8**2
      Z(570) = L9**2
      Z(571) = L6*L8
      Z(572) = L6*L9
      Z(573) = L8*L9
      Z(574) = L10*L2
      Z(575) = L2*Z(21)
      Z(576) = L10**2
      Z(577) = Z(21)**2
      Z(578) = L10*L6
      Z(579) = L10*L8
      Z(580) = L10*Z(21)
      Z(581) = L6*Z(21)
      Z(582) = L8*Z(21)
      Z(583) = L10*Z(22)
      Z(584) = L2*Z(22)
      Z(585) = Z(22)**2
      Z(586) = L6*Z(22)
      Z(587) = L8*Z(22)
      Z(588) = L11*L2
      Z(589) = L2*Z(25)
      Z(590) = L11**2
      Z(591) = Z(25)**2
      Z(592) = L10*L11
      Z(593) = L10*Z(25)
      Z(594) = L11*L6
      Z(595) = L11*L8
      Z(596) = L11*Z(25)
      Z(597) = L6*Z(25)
      Z(598) = L8*Z(25)
      Z(599) = L3*Z(7)*Z(24)
      Z(600) = L8*Z(24)
      Z(601) = L10*L3
      Z(602) = L3*L6
      Z(603) = L3*L8
      Z(604) = L2*Z(24)
      Z(605) = L3**2
      Z(606) = Z(24)**2
      Z(607) = L10*Z(24)
      Z(608) = L6*Z(24)
      Z(610) = -INA - MA*L1**2
      Z(612) = MA*L1**2
      Z(616) = L3*Z(8)
      Z(617) = L4*Z(8)
      Z(618) = Z(8)*Z(24)
      Z(619) = L3*Z(7)
      Z(620) = Z(7)*Z(24)
      Z(622) = INA + MA*L1**2 + MB*L2**2 + MC*L2**2 + MD*L2**2 + ME*L2**
     &2 + MF*L2**2 + MG*L2**2 + MH*L2**2 + MI*L2**2
      Z(623) = INA + MA*L1**2
      Z(628) = INA + INB + MA*L1**2
      Z(629) = L2**2 + L6**2
      Z(634) = INA + INB + INC + MA*L1**2
      Z(638) = INA + INB + INC + IND + MA*L1**2
      Z(641) = INE + INF + INH + INI
      Z(673) = L2*MI*Z(25)

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
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(694),COEF(7,7),RHS(7)

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
      Z(106) = Z(1)*Z(38) + Z(2)*Z(39)
      Z(107) = Z(1)*Z(37) - Z(2)*Z(36)
      Z(108) = Z(1)*Z(39) - Z(2)*Z(38)
      Z(111) = Z(1)*Z(49) + Z(2)*Z(50)
      Z(112) = Z(1)*Z(48) - Z(2)*Z(47)
      Z(113) = Z(1)*Z(50) - Z(2)*Z(49)
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
      Z(199) = L11*U3
      Z(200) = U3*Z(199)
      Z(228) = MTOR - ATOR
      Z(231) = Z(9)*Z(26) + Z(10)*Z(27)
      Z(232) = Z(9)*Z(27) - Z(10)*Z(26)
      Z(233) = Z(9)*Z(28) + Z(10)*Z(26)
      Z(234) = Z(9)*Z(26) - Z(10)*Z(28)
      Z(236) = Z(3)*Z(232) + Z(4)*Z(234)
      Z(237) = Z(3)*Z(233) - Z(4)*Z(231)
      Z(238) = Z(3)*Z(234) - Z(4)*Z(232)
      Z(504) = RX1 + RX2 + VRX1
      Z(506) = Z(505) + RY1 + RY2 + VRY1 + Z(227)
      Z(517) = MTOR + Z(507)*Z(39) + Z(509)*Z(39) + Z(510)*Z(39) + Z(511
     &)*Z(39) + Z(512)*Z(39) + Z(513)*Z(39) + Z(514)*Z(39) + Z(515)*Z(39
     &) + Z(516)*Z(39) + L2*Z(39)*Z(227) + L2*(RX2*Z(38)+RY2*Z(39)) + L2
     &*(VRX1*Z(38)+VRY1*Z(39))
      Z(518) = MTOR + Z(507)*Z(39) + L2*VRX1*Z(38) + L2*VRY1*Z(39) + L2*
     &(RX2*Z(38)+RY2*Z(39)) + Z(220)*(L2*Z(39)-L6*Z(50)) + Z(221)*(L2*Z(
     &39)-L6*Z(50)) + Z(222)*(L2*Z(39)-L6*Z(50)) + Z(223)*(L2*Z(39)-L6*Z
     &(50)) + Z(224)*(L2*Z(39)-L6*Z(50)) + Z(225)*(L2*Z(39)-L6*Z(50)) + 
     &Z(226)*(L2*Z(39)-L6*Z(50)) + Z(227)*(L2*Z(39)-L6*Z(50)) + 0.5D0*Z(
     &219)*(2*L2*Z(39)-L3*Z(46)-L4*Z(50)) - Z(228) - L6*VRX1*Z(49) - L6*
     &VRY1*Z(50)
      Z(519) = MTOR + Z(507)*Z(39) + L2*VRX1*Z(38) + L2*VRY1*Z(39) + L2*
     &(RX2*Z(38)+RY2*Z(39)) + Z(220)*(L2*Z(39)-L6*Z(50)-L7*Z(35)) + Z(22
     &1)*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + Z(222)*(L2*Z(39)-L6*Z(50)-L8*Z(3
     &5)) + Z(223)*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + Z(224)*(L2*Z(39)-L6*Z(
     &50)-L8*Z(35)) + Z(225)*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + Z(226)*(L2*Z
     &(39)-L6*Z(50)-L8*Z(35)) + Z(227)*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + 0.
     &5D0*Z(219)*(2*L2*Z(39)-L3*Z(46)-L4*Z(50)) - Z(228) - Z(229) - L6*V
     &RX1*Z(49) - L6*VRY1*Z(50) - L8*VRX1*Z(34) - L8*VRY1*Z(35)
      Z(520) = MTOR + Z(507)*Z(39) + L2*VRX1*Z(38) + L2*VRY1*Z(39) + L2*
     &(RX2*Z(38)+RY2*Z(39)) + Z(220)*(L2*Z(39)-L6*Z(50)-L7*Z(35)) + 0.5D
     &0*Z(219)*(2*L2*Z(39)-L3*Z(46)-L4*Z(50)) + Z(221)*(L2*Z(39)-L6*Z(50
     &)-L8*Z(35)-L9*Z(54)) + Z(222)*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35
     &)) + Z(223)*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + Z(224)*(L2*Z(
     &39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + Z(225)*(L2*Z(39)-L10*Z(54)-L6*Z
     &(50)-L8*Z(35)) + Z(226)*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + Z
     &(227)*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) - Z(228) - Z(229) - Z
     &(230) - L10*VRX1*Z(53) - L10*VRY1*Z(54) - L6*VRX1*Z(49) - L6*VRY1*
     &Z(50) - L8*VRX1*Z(34) - L8*VRY1*Z(35)
      Z(546) = Z(545)*Z(38)
      Z(547) = Z(458)*Z(38) + MC*(L2*Z(38)-L6*Z(49)) + MD*(L2*Z(38)-L6*Z
     &(49)) + ME*(L2*Z(38)-L6*Z(49)) + MF*(L2*Z(38)-L6*Z(49)) + MG*(L2*Z
     &(38)-L6*Z(49)) + MH*(L2*Z(38)-L6*Z(49)) + MI*(L2*Z(38)-L6*Z(49)) +
     & 0.5D0*MB*(2*L2*Z(38)-L3*Z(45)-L4*Z(49))
      Z(548) = Z(458)*Z(38) + MC*(L2*Z(38)-L6*Z(49)-L7*Z(34)) + MD*(L2*Z
     &(38)-L6*Z(49)-L8*Z(34)) + ME*(L2*Z(38)-L6*Z(49)-L8*Z(34)) + MF*(L2
     &*Z(38)-L6*Z(49)-L8*Z(34)) + MG*(L2*Z(38)-L6*Z(49)-L8*Z(34)) + MH*(
     &L2*Z(38)-L6*Z(49)-L8*Z(34)) + MI*(L2*Z(38)-L6*Z(49)-L8*Z(34)) + 0.
     &5D0*MB*(2*L2*Z(38)-L3*Z(45)-L4*Z(49))
      Z(549) = Z(458)*Z(38) + MC*(L2*Z(38)-L6*Z(49)-L7*Z(34)) + 0.5D0*MB
     &*(2*L2*Z(38)-L3*Z(45)-L4*Z(49)) + MD*(L2*Z(38)-L6*Z(49)-L8*Z(34)-L
     &9*Z(53)) + ME*(L2*Z(38)-L10*Z(53)-L6*Z(49)-L8*Z(34)) + MF*(L2*Z(38
     &)-L10*Z(53)-L6*Z(49)-L8*Z(34)) + MG*(L2*Z(38)-L10*Z(53)-L6*Z(49)-L
     &8*Z(34)) + MH*(L2*Z(38)-L10*Z(53)-L6*Z(49)-L8*Z(34)) + MI*(L2*Z(38
     &)-L10*Z(53)-L6*Z(49)-L8*Z(34))
      Z(552) = Z(545)*Z(39)
      Z(553) = Z(458)*Z(39) + MC*(L2*Z(39)-L6*Z(50)) + MD*(L2*Z(39)-L6*Z
     &(50)) + ME*(L2*Z(39)-L6*Z(50)) + MF*(L2*Z(39)-L6*Z(50)) + MG*(L2*Z
     &(39)-L6*Z(50)) + MH*(L2*Z(39)-L6*Z(50)) + MI*(L2*Z(39)-L6*Z(50)) +
     & 0.5D0*MB*(2*L2*Z(39)-L3*Z(46)-L4*Z(50))
      Z(554) = Z(458)*Z(39) + MC*(L2*Z(39)-L6*Z(50)-L7*Z(35)) + MD*(L2*Z
     &(39)-L6*Z(50)-L8*Z(35)) + ME*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + MF*(L2
     &*Z(39)-L6*Z(50)-L8*Z(35)) + MG*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + MH*(
     &L2*Z(39)-L6*Z(50)-L8*Z(35)) + MI*(L2*Z(39)-L6*Z(50)-L8*Z(35)) + 0.
     &5D0*MB*(2*L2*Z(39)-L3*Z(46)-L4*Z(50))
      Z(555) = Z(458)*Z(39) + MC*(L2*Z(39)-L6*Z(50)-L7*Z(35)) + 0.5D0*MB
     &*(2*L2*Z(39)-L3*Z(46)-L4*Z(50)) + MD*(L2*Z(39)-L6*Z(50)-L8*Z(35)-L
     &9*Z(54)) + ME*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + MF*(L2*Z(39
     &)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + MG*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L
     &8*Z(35)) + MH*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)) + MI*(L2*Z(39
     &)-L10*Z(54)-L6*Z(50)-L8*Z(35))
      Z(624) = Z(623) + Z(462)*(L2-L6*Z(3)) + Z(465)*(L2-L6*Z(3)) + Z(46
     &9)*(L2-L6*Z(3)) + Z(475)*(L2-L6*Z(3)) + Z(482)*(L2-L6*Z(3)) + Z(48
     &8)*(L2-L6*Z(3)) + Z(498)*(L2-L6*Z(3)) + 0.5D0*Z(459)*(2*L2-L3*Z(40
     &)-L4*Z(3))
      Z(625) = Z(623) + Z(462)*(L2-L6*Z(3)-L7*Z(26)) + Z(465)*(L2-L6*Z(3
     &)-L8*Z(26)) + Z(469)*(L2-L6*Z(3)-L8*Z(26)) + Z(475)*(L2-L6*Z(3)-L8
     &*Z(26)) + Z(482)*(L2-L6*Z(3)-L8*Z(26)) + Z(488)*(L2-L6*Z(3)-L8*Z(2
     &6)) + Z(498)*(L2-L6*Z(3)-L8*Z(26)) + 0.5D0*Z(459)*(2*L2-L3*Z(40)-L
     &4*Z(3))
      Z(626) = Z(623) + Z(462)*(L2-L6*Z(3)-L7*Z(26)) + 0.5D0*Z(459)*(2*L
     &2-L3*Z(40)-L4*Z(3)) + Z(465)*(L2-L6*Z(3)-L8*Z(26)-L9*Z(234)) + Z(4
     &69)*(L2-L10*Z(234)-L6*Z(3)-L8*Z(26)) + Z(475)*(L2-L10*Z(234)-L6*Z(
     &3)-L8*Z(26)) + Z(482)*(L2-L10*Z(234)-L6*Z(3)-L8*Z(26)) + Z(488)*(L
     &2-L10*Z(234)-L6*Z(3)-L8*Z(26)) + Z(498)*(L2-L10*Z(234)-L6*Z(3)-L8*
     &Z(26))
      Z(630) = Z(628) + MC*(Z(629)-2*Z(561)*Z(3)) + MD*(Z(629)-2*Z(561)*
     &Z(3)) + ME*(Z(629)-2*Z(561)*Z(3)) + MF*(Z(629)-2*Z(561)*Z(3)) + MG
     &*(Z(629)-2*Z(561)*Z(3)) + MH*(Z(629)-2*Z(561)*Z(3)) + MI*(Z(629)-2
     &*Z(561)*Z(3)) + 0.25D0*MB*(Z(558)-4*Z(559)*Z(40)-4*Z(560)*Z(3))
      Z(631) = Z(628) + 0.25D0*MB*(Z(558)-4*Z(559)*Z(40)-4*Z(560)*Z(3)) 
     &- MC*(Z(562)*Z(26)+2*Z(561)*Z(3)-Z(563)-Z(564)-Z(566)*Z(5)) - MD*(
     &Z(567)*Z(26)+2*Z(561)*Z(3)-Z(563)-Z(564)-Z(571)*Z(5)) - ME*(Z(567)
     &*Z(26)+2*Z(561)*Z(3)-Z(563)-Z(564)-Z(571)*Z(5)) - MF*(Z(567)*Z(26)
     &+2*Z(561)*Z(3)-Z(563)-Z(564)-Z(571)*Z(5)) - MG*(Z(567)*Z(26)+2*Z(5
     &61)*Z(3)-Z(563)-Z(564)-Z(571)*Z(5)) - MH*(Z(567)*Z(26)+2*Z(561)*Z(
     &3)-Z(563)-Z(564)-Z(571)*Z(5)) - MI*(Z(567)*Z(26)+2*Z(561)*Z(3)-Z(5
     &63)-Z(564)-Z(571)*Z(5))
      Z(632) = Z(628) + 0.25D0*MB*(Z(558)-4*Z(559)*Z(40)-4*Z(560)*Z(3)) 
     &- MC*(Z(562)*Z(26)+2*Z(561)*Z(3)-Z(563)-Z(564)-Z(566)*Z(5)) - MD*(
     &Z(567)*Z(26)+Z(568)*Z(234)+2*Z(561)*Z(3)-Z(563)-Z(564)-Z(571)*Z(5)
     &-Z(572)*Z(238)) - ME*(Z(567)*Z(26)+Z(574)*Z(234)+2*Z(561)*Z(3)-Z(5
     &63)-Z(564)-Z(571)*Z(5)-Z(578)*Z(238)) - MF*(Z(567)*Z(26)+Z(574)*Z(
     &234)+2*Z(561)*Z(3)-Z(563)-Z(564)-Z(571)*Z(5)-Z(578)*Z(238)) - MG*(
     &Z(567)*Z(26)+Z(574)*Z(234)+2*Z(561)*Z(3)-Z(563)-Z(564)-Z(571)*Z(5)
     &-Z(578)*Z(238)) - MH*(Z(567)*Z(26)+Z(574)*Z(234)+2*Z(561)*Z(3)-Z(5
     &63)-Z(564)-Z(571)*Z(5)-Z(578)*Z(238)) - MI*(Z(567)*Z(26)+Z(574)*Z(
     &234)+2*Z(561)*Z(3)-Z(563)-Z(564)-Z(571)*Z(5)-Z(578)*Z(238))
      Z(635) = Z(634) + 0.25D0*MB*(Z(558)-4*Z(559)*Z(40)-4*Z(560)*Z(3)) 
     &- MC*(2*Z(561)*Z(3)+2*Z(562)*Z(26)-Z(563)-Z(564)-Z(565)-2*Z(566)*Z
     &(5)) - MD*(2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z(563)-Z(564)-Z(569)-2*Z(5
     &71)*Z(5)) - ME*(2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z(563)-Z(564)-Z(569)-
     &2*Z(571)*Z(5)) - MF*(2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z(563)-Z(564)-Z(
     &569)-2*Z(571)*Z(5)) - MG*(2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z(563)-Z(56
     &4)-Z(569)-2*Z(571)*Z(5)) - MH*(2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z(563)
     &-Z(564)-Z(569)-2*Z(571)*Z(5)) - MI*(2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z
     &(563)-Z(564)-Z(569)-2*Z(571)*Z(5))
      Z(636) = Z(634) + 0.25D0*MB*(Z(558)-4*Z(559)*Z(40)-4*Z(560)*Z(3)) 
     &- MC*(2*Z(561)*Z(3)+2*Z(562)*Z(26)-Z(563)-Z(564)-Z(565)-2*Z(566)*Z
     &(5)) - MD*(Z(568)*Z(234)+2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z(563)-Z(564
     &)-Z(569)-2*Z(571)*Z(5)-Z(572)*Z(238)-Z(573)*Z(9)) - ME*(Z(574)*Z(2
     &34)+2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z(563)-Z(564)-Z(569)-2*Z(571)*Z(5
     &)-Z(578)*Z(238)-Z(579)*Z(9)) - MF*(Z(574)*Z(234)+2*Z(561)*Z(3)+2*Z
     &(567)*Z(26)-Z(563)-Z(564)-Z(569)-2*Z(571)*Z(5)-Z(578)*Z(238)-Z(579
     &)*Z(9)) - MG*(Z(574)*Z(234)+2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z(563)-Z(
     &564)-Z(569)-2*Z(571)*Z(5)-Z(578)*Z(238)-Z(579)*Z(9)) - MH*(Z(574)*
     &Z(234)+2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z(563)-Z(564)-Z(569)-2*Z(571)*
     &Z(5)-Z(578)*Z(238)-Z(579)*Z(9)) - MI*(Z(574)*Z(234)+2*Z(561)*Z(3)+
     &2*Z(567)*Z(26)-Z(563)-Z(564)-Z(569)-2*Z(571)*Z(5)-Z(578)*Z(238)-Z(
     &579)*Z(9))
      Z(639) = Z(638) + 0.25D0*MB*(Z(558)-4*Z(559)*Z(40)-4*Z(560)*Z(3)) 
     &- MC*(2*Z(561)*Z(3)+2*Z(562)*Z(26)-Z(563)-Z(564)-Z(565)-2*Z(566)*Z
     &(5)) - MD*(2*Z(561)*Z(3)+2*Z(567)*Z(26)+2*Z(568)*Z(234)-Z(563)-Z(5
     &64)-Z(569)-Z(570)-2*Z(571)*Z(5)-2*Z(572)*Z(238)-2*Z(573)*Z(9)) - M
     &E*(2*Z(561)*Z(3)+2*Z(567)*Z(26)+2*Z(574)*Z(234)-Z(563)-Z(564)-Z(56
     &9)-Z(576)-2*Z(571)*Z(5)-2*Z(578)*Z(238)-2*Z(579)*Z(9)) - MF*(2*Z(5
     &61)*Z(3)+2*Z(567)*Z(26)+2*Z(574)*Z(234)-Z(563)-Z(564)-Z(569)-Z(576
     &)-2*Z(571)*Z(5)-2*Z(578)*Z(238)-2*Z(579)*Z(9)) - MG*(2*Z(561)*Z(3)
     &+2*Z(567)*Z(26)+2*Z(574)*Z(234)-Z(563)-Z(564)-Z(569)-Z(576)-2*Z(57
     &1)*Z(5)-2*Z(578)*Z(238)-2*Z(579)*Z(9)) - MH*(2*Z(561)*Z(3)+2*Z(567
     &)*Z(26)+2*Z(574)*Z(234)-Z(563)-Z(564)-Z(569)-Z(576)-2*Z(571)*Z(5)-
     &2*Z(578)*Z(238)-2*Z(579)*Z(9)) - MI*(2*Z(561)*Z(3)+2*Z(567)*Z(26)+
     &2*Z(574)*Z(234)-Z(563)-Z(564)-Z(569)-Z(576)-2*Z(571)*Z(5)-2*Z(578)
     &*Z(238)-2*Z(579)*Z(9))

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
      Z(115) = U8 - EAp
      Z(117) = FApp - EApp
      Z(123) = FApp - EApp - HApp
      Z(124) = Z(1)*Z(62) + Z(2)*Z(63)
      Z(125) = Z(1)*Z(64) + Z(2)*Z(65)
      Z(126) = Z(1)*Z(63) - Z(2)*Z(62)
      Z(127) = Z(1)*Z(65) - Z(2)*Z(64)
      Z(129) = FApp - EApp - IApp
      Z(131) = Z(1)*Z(72) + Z(2)*Z(73)
      Z(132) = Z(1)*Z(71) - Z(2)*Z(70)
      Z(133) = Z(1)*Z(73) - Z(2)*Z(72)
      Z(138) = Z(21)*EAp
      Z(139) = L10*EAp
      Z(140) = Z(22)*(EAp-FAp)
      Z(141) = L8*(EAp-FAp)
      Z(142) = Z(1)*Z(66) + Z(2)*Z(67)
      Z(143) = Z(1)*Z(68) + Z(2)*Z(69)
      Z(144) = Z(1)*Z(67) - Z(2)*Z(66)
      Z(145) = Z(1)*Z(69) - Z(2)*Z(68)
      Z(146) = Z(24)*(FAp-EAp-HAp)
      Z(147) = L3*(FAp-EAp-HAp)
      Z(149) = Z(25)*(FAp-EAp-IAp)
      Z(182) = Z(21)*U3 + Z(21)*U8 - Z(138)
      Z(183) = Z(21)*EApp
      Z(184) = Z(182)*(U3+Z(115))
      Z(185) = L10*U3 + L10*U8 - Z(139)
      Z(186) = L10*EApp
      Z(187) = Z(185)*(U3+Z(115))
      Z(188) = Z(22)*U3 + Z(22)*U8 + Z(22)*U9 - Z(140)
      Z(189) = Z(22)*(EApp-FApp)
      Z(190) = FAp + U9
      Z(191) = Z(188)*(U3+Z(115)+Z(190))
      Z(192) = L8*U3 + L8*U8 + L8*U9 - Z(141)
      Z(193) = L8*(EApp-FApp)
      Z(194) = Z(192)*(U3+Z(115)+Z(190))
      Z(195) = GS*U3
      Z(196) = GSp*U3
      Z(197) = GSpp - U3*Z(195)
      Z(198) = GSp*U3 + Z(196)
      Z(201) = Z(146) + Z(24)*U10 + Z(24)*U3 + Z(24)*U8 + Z(24)*U9
      Z(202) = -0.5D0*Z(147) - 0.5D0*L3*U10 - 0.5D0*L3*U3 - 0.5D0*L3*U8 
     &- 0.5D0*L3*U9
      Z(203) = Z(24)*(FApp-EApp-HApp)
      Z(204) = U10 - HAp
      Z(205) = L3*(FApp-EApp-HApp)
      Z(206) = Z(201)*(U3+Z(115)+Z(190)+Z(204))
      Z(207) = Z(202)*(U3+Z(115)+Z(190)+Z(204))
      Z(211) = Z(149) + Z(25)*U11 + Z(25)*U3 + Z(25)*U8 + Z(25)*U9
      Z(212) = Z(25)*(FApp-EApp-IApp)
      Z(213) = U11 - IAp
      Z(214) = Z(211)*(U3+Z(115)+Z(190)+Z(213))
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
      Z(304) = Z(13)*Z(125) - Z(14)*Z(127)
      Z(305) = Z(13)*Z(126) + Z(14)*Z(124)
      Z(306) = Z(13)*Z(127) + Z(14)*Z(125)
      Z(307) = Z(13)*Z(142) - Z(14)*Z(144)
      Z(308) = Z(13)*Z(143) - Z(14)*Z(145)
      Z(309) = Z(13)*Z(144) + Z(14)*Z(142)
      Z(310) = Z(13)*Z(145) + Z(14)*Z(143)
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
      Z(508) = HTOR + Z(228) + Z(229) + Z(230) + L10*VRX1*Z(53) + L10*VR
     &Y1*Z(54) + L11*VRY1*Z(1) + L6*VRX1*Z(49) + L6*VRY1*Z(50) + L8*VRX1
     &*Z(34) + L8*VRY1*Z(35) - MTOR - Z(507)*Z(39) - L11*VRX1*Z(2) - L2*
     &VRX1*Z(38) - L2*VRY1*Z(39) - L2*(RX2*Z(38)+RY2*Z(39)) - Z(220)*(L2
     &*Z(39)-L6*Z(50)-L7*Z(35)) - 0.5D0*Z(219)*(2*L2*Z(39)-L3*Z(46)-L4*Z
     &(50)) - Z(221)*(L2*Z(39)-L6*Z(50)-L8*Z(35)-L9*Z(54)) - Z(222)*(L2*
     &Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)-Z(21)*Z(55)) - Z(224)*(L2*Z(39)-
     &L10*Z(54)-L6*Z(50)-L8*Z(35)-GS*Z(1)) - Z(223)*(L2*Z(39)-L10*Z(54)-
     &L10*Z(55)-L6*Z(50)-L8*Z(35)-Z(22)*Z(61)) - Z(226)*(L2*Z(39)-L10*Z(
     &54)-L11*Z(1)-L6*Z(50)-L8*Z(35)-Z(25)*Z(73)) - Z(227)*(L2*Z(39)-L10
     &*Z(54)-L11*Z(1)-L2*Z(73)-L6*Z(50)-L8*Z(35)) - 0.5D0*Z(225)*(L3*Z(6
     &9)+2*L2*Z(39)-2*L10*Z(54)-2*L10*Z(55)-2*L6*Z(50)-2*L8*Z(35)-2*L8*Z
     &(61)-2*Z(24)*Z(65))
      Z(537) = INE*EApp
      Z(539) = INF*Z(117)
      Z(541) = INH*Z(123)
      Z(543) = INI*Z(129)
      Z(544) = MG*(L10*Z(53)+L6*Z(49)+L8*Z(34)-L2*Z(38)-GS*Z(2)) - Z(458
     &)*Z(38) - MC*(L2*Z(38)-L6*Z(49)-L7*Z(34)) - 0.5D0*MB*(2*L2*Z(38)-L
     &3*Z(45)-L4*Z(49)) - MD*(L2*Z(38)-L6*Z(49)-L8*Z(34)-L9*Z(53)) - ME*
     &(L2*Z(38)-L10*Z(53)-L6*Z(49)-L8*Z(34)-Z(21)*Z(57)) - MI*(L11*Z(2)+
     &L2*Z(38)-L10*Z(53)-L6*Z(49)-L8*Z(34)-Z(25)*Z(72)) - MF*(L2*Z(38)-L
     &10*Z(53)-L10*Z(57)-L6*Z(49)-L8*Z(34)-Z(22)*Z(60)) - 0.5D0*MH*(L3*Z
     &(68)+2*L2*Z(38)-2*L10*Z(53)-2*L10*Z(57)-2*L6*Z(49)-2*L8*Z(34)-2*L8
     &*Z(60)-2*Z(24)*Z(64))
      Z(550) = MA*Z(36)*Z(163) + MC*(Z(36)*Z(165)-Z(32)*Z(175)-Z(47)*Z(1
     &73)) + 0.5D0*MB*(2*Z(36)*Z(165)-Z(43)*Z(169)-Z(47)*Z(168)) + MD*(Z
     &(36)*Z(165)-Z(32)*Z(177)-Z(47)*Z(173)-Z(51)*Z(179)) + MG*(Z(1)*Z(1
     &97)+Z(36)*Z(165)-Z(2)*Z(198)-Z(32)*Z(177)-Z(47)*Z(173)-Z(51)*Z(181
     &)) + ME*(Z(36)*Z(165)-Z(183)*Z(57)-Z(32)*Z(177)-Z(47)*Z(173)-Z(51)
     &*Z(181)-Z(55)*Z(184)) + MI*(Z(212)*Z(72)+Z(36)*Z(165)-Z(1)*Z(200)-
     &Z(32)*Z(177)-Z(47)*Z(173)-Z(51)*Z(181)-Z(70)*Z(214)) + MF*(Z(36)*Z
     &(165)-Z(186)*Z(57)-Z(189)*Z(60)-Z(32)*Z(177)-Z(47)*Z(173)-Z(51)*Z(
     &181)-Z(55)*Z(187)-Z(58)*Z(191)) + 0.5D0*MH*(2*Z(203)*Z(64)+2*Z(36)
     &*Z(165)-2*Z(186)*Z(57)-2*Z(193)*Z(60)-Z(205)*Z(68)-2*Z(32)*Z(177)-
     &2*Z(47)*Z(173)-2*Z(51)*Z(181)-2*Z(55)*Z(187)-2*Z(58)*Z(194)-2*Z(62
     &)*Z(206)-2*Z(66)*Z(207))
      Z(551) = -Z(458)*Z(39) - MC*(L2*Z(39)-L6*Z(50)-L7*Z(35)) - 0.5D0*M
     &B*(2*L2*Z(39)-L3*Z(46)-L4*Z(50)) - MD*(L2*Z(39)-L6*Z(50)-L8*Z(35)-
     &L9*Z(54)) - ME*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)-Z(21)*Z(55)) 
     &- MG*(L2*Z(39)-L10*Z(54)-L6*Z(50)-L8*Z(35)-GS*Z(1)) - MF*(L2*Z(39)
     &-L10*Z(54)-L10*Z(55)-L6*Z(50)-L8*Z(35)-Z(22)*Z(61)) - MI*(L2*Z(39)
     &-L10*Z(54)-L11*Z(1)-L6*Z(50)-L8*Z(35)-Z(25)*Z(73)) - 0.5D0*MH*(L3*
     &Z(69)+2*L2*Z(39)-2*L10*Z(54)-2*L10*Z(55)-2*L6*Z(50)-2*L8*Z(35)-2*L
     &8*Z(61)-2*Z(24)*Z(65))
      Z(556) = MA*Z(37)*Z(163) + MC*(Z(37)*Z(165)-Z(33)*Z(175)-Z(48)*Z(1
     &73)) + 0.5D0*MB*(2*Z(37)*Z(165)-Z(44)*Z(169)-Z(48)*Z(168)) + MD*(Z
     &(37)*Z(165)-Z(33)*Z(177)-Z(48)*Z(173)-Z(52)*Z(179)) + MG*(Z(1)*Z(1
     &98)+Z(2)*Z(197)+Z(37)*Z(165)-Z(33)*Z(177)-Z(48)*Z(173)-Z(52)*Z(181
     &)) + ME*(Z(37)*Z(165)-Z(183)*Z(55)-Z(33)*Z(177)-Z(48)*Z(173)-Z(52)
     &*Z(181)-Z(56)*Z(184)) + MI*(Z(212)*Z(73)+Z(37)*Z(165)-Z(2)*Z(200)-
     &Z(33)*Z(177)-Z(48)*Z(173)-Z(52)*Z(181)-Z(71)*Z(214)) + MF*(Z(37)*Z
     &(165)-Z(186)*Z(55)-Z(189)*Z(61)-Z(33)*Z(177)-Z(48)*Z(173)-Z(52)*Z(
     &181)-Z(56)*Z(187)-Z(59)*Z(191)) + 0.5D0*MH*(2*Z(203)*Z(65)+2*Z(37)
     &*Z(165)-2*Z(186)*Z(55)-2*Z(193)*Z(61)-Z(205)*Z(69)-2*Z(33)*Z(177)-
     &2*Z(48)*Z(173)-2*Z(52)*Z(181)-2*Z(56)*Z(187)-2*Z(59)*Z(194)-2*Z(63
     &)*Z(206)-2*Z(67)*Z(207))
      Z(609) = Z(557) + 0.25D0*MB*(Z(558)-4*Z(559)*Z(40)-4*Z(560)*Z(3)) 
     &- MC*(2*Z(561)*Z(3)+2*Z(562)*Z(26)-Z(563)-Z(564)-Z(565)-2*Z(566)*Z
     &(5)) - MD*(2*Z(561)*Z(3)+2*Z(567)*Z(26)+2*Z(568)*Z(234)-Z(563)-Z(5
     &64)-Z(569)-Z(570)-2*Z(571)*Z(5)-2*Z(572)*Z(238)-2*Z(573)*Z(9)) - M
     &E*(2*Z(561)*Z(3)+2*Z(567)*Z(26)+2*Z(574)*Z(234)+2*Z(575)*Z(242)-Z(
     &563)-Z(564)-Z(569)-Z(576)-Z(577)-2*Z(571)*Z(5)-2*Z(578)*Z(238)-2*Z
     &(579)*Z(9)-2*Z(580)*Z(254)-2*Z(581)*Z(246)-2*Z(582)*Z(250)) - MG*(
     &2*Z(561)*Z(3)+2*Z(567)*Z(26)+2*Z(574)*Z(234)+2*L2*GS*Z(108)-Z(563)
     &-Z(564)-Z(569)-Z(576)-GS**2-2*Z(571)*Z(5)-2*Z(578)*Z(238)-2*Z(579)
     &*Z(9)-2*L10*GS*Z(11)-2*L6*GS*Z(113)-2*L8*GS*Z(29)) - MF*(2*Z(583)*
     &Z(15)+2*Z(561)*Z(3)+2*Z(567)*Z(26)+2*Z(574)*Z(234)+2*Z(574)*Z(242)
     &+2*Z(584)*Z(258)-2*Z(576)-Z(563)-Z(564)-Z(569)-Z(585)-2*Z(571)*Z(5
     &)-2*Z(576)*Z(254)-2*Z(578)*Z(238)-2*Z(578)*Z(246)-2*Z(579)*Z(9)-2*
     &Z(579)*Z(250)-2*Z(583)*Z(270)-2*Z(586)*Z(262)-2*Z(587)*Z(266)) - M
     &I*(2*Z(561)*Z(3)+2*Z(567)*Z(26)+2*Z(574)*Z(234)+2*Z(588)*Z(108)+2*
     &Z(589)*Z(318)-Z(563)-Z(564)-Z(569)-Z(576)-Z(590)-Z(591)-2*Z(571)*Z
     &(5)-2*Z(578)*Z(238)-2*Z(579)*Z(9)-2*Z(592)*Z(11)-2*Z(593)*Z(330)-2
     &*Z(594)*Z(113)-2*Z(595)*Z(29)-2*Z(596)*Z(133)-2*Z(597)*Z(322)-2*Z(
     &598)*Z(326)) - 0.25D0*MH*(4*Z(599)+8*Z(579)*Z(15)+8*Z(600)*Z(17)+4
     &*Z(601)*Z(302)+4*Z(601)*Z(310)+4*Z(602)*Z(286)+4*Z(603)*Z(294)+4*Z
     &(603)*Z(314)+8*Z(561)*Z(3)+8*Z(567)*Z(26)+8*Z(567)*Z(258)+8*Z(574)
     &*Z(234)+8*Z(574)*Z(242)+8*Z(604)*Z(274)-8*Z(569)-8*Z(576)-4*Z(563)
     &-4*Z(564)-4*Z(606)-Z(605)-8*Z(569)*Z(266)-8*Z(571)*Z(5)-8*Z(571)*Z
     &(262)-8*Z(576)*Z(254)-8*Z(578)*Z(238)-8*Z(578)*Z(246)-8*Z(579)*Z(9
     &)-8*Z(579)*Z(250)-8*Z(579)*Z(270)-8*Z(600)*Z(290)-8*Z(607)*Z(298)-
     &8*Z(607)*Z(306)-8*Z(608)*Z(282)-4*Z(559)*Z(278))
      Z(611) = Z(610) - Z(462)*(L2-L6*Z(3)-L7*Z(26)) - 0.5D0*Z(459)*(2*L
     &2-L3*Z(40)-L4*Z(3)) - Z(465)*(L2-L6*Z(3)-L8*Z(26)-L9*Z(234)) - Z(4
     &69)*(L2-L10*Z(234)-L6*Z(3)-L8*Z(26)-Z(21)*Z(242)) - Z(482)*(L2-L10
     &*Z(234)-L6*Z(3)-L8*Z(26)-GS*Z(108)) - Z(475)*(L2-L10*Z(234)-L10*Z(
     &242)-L6*Z(3)-L8*Z(26)-Z(22)*Z(258)) - Z(498)*(L2-L10*Z(234)-L11*Z(
     &108)-L6*Z(3)-L8*Z(26)-Z(25)*Z(318)) - 0.5D0*Z(488)*(2*L2+L3*Z(278)
     &-2*L10*Z(234)-2*L10*Z(242)-2*L6*Z(3)-2*L8*Z(26)-2*L8*Z(258)-2*Z(24
     &)*Z(274))
      Z(613) = MC*(Z(562)*Z(26)+2*Z(561)*Z(3)-Z(563)-Z(564)-Z(566)*Z(5))
     & + MD*(Z(567)*Z(26)+Z(568)*Z(234)+2*Z(561)*Z(3)-Z(563)-Z(564)-Z(57
     &1)*Z(5)-Z(572)*Z(238)) + ME*(Z(567)*Z(26)+Z(574)*Z(234)+Z(575)*Z(2
     &42)+2*Z(561)*Z(3)-Z(563)-Z(564)-Z(571)*Z(5)-Z(578)*Z(238)-Z(581)*Z
     &(246)) + MG*(Z(567)*Z(26)+Z(574)*Z(234)+2*Z(561)*Z(3)+L2*GS*Z(108)
     &-Z(563)-Z(564)-Z(571)*Z(5)-Z(578)*Z(238)-L6*GS*Z(113)) + MF*(Z(567
     &)*Z(26)+Z(574)*Z(234)+Z(574)*Z(242)+Z(584)*Z(258)+2*Z(561)*Z(3)-Z(
     &563)-Z(564)-Z(571)*Z(5)-Z(578)*Z(238)-Z(578)*Z(246)-Z(586)*Z(262))
     & + MI*(Z(567)*Z(26)+Z(574)*Z(234)+Z(588)*Z(108)+Z(589)*Z(318)+2*Z(
     &561)*Z(3)-Z(563)-Z(564)-Z(571)*Z(5)-Z(578)*Z(238)-Z(594)*Z(113)-Z(
     &597)*Z(322)) + 0.5D0*MH*(Z(602)*Z(286)+2*Z(567)*Z(26)+2*Z(567)*Z(2
     &58)+2*Z(574)*Z(234)+2*Z(574)*Z(242)+2*Z(604)*Z(274)+4*Z(561)*Z(3)-
     &2*Z(563)-2*Z(564)-2*Z(571)*Z(5)-2*Z(571)*Z(262)-2*Z(578)*Z(238)-2*
     &Z(578)*Z(246)-2*Z(608)*Z(282)-Z(559)*Z(278)) - INA - INB - Z(612) 
     &- 0.25D0*MB*(Z(558)-4*Z(559)*Z(40)-4*Z(560)*Z(3))
      Z(614) = MC*(2*Z(561)*Z(3)+2*Z(562)*Z(26)-Z(563)-Z(564)-Z(565)-2*Z
     &(566)*Z(5)) + MD*(Z(568)*Z(234)+2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z(563
     &)-Z(564)-Z(569)-2*Z(571)*Z(5)-Z(572)*Z(238)-Z(573)*Z(9)) + ME*(Z(5
     &74)*Z(234)+Z(575)*Z(242)+2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z(563)-Z(564
     &)-Z(569)-2*Z(571)*Z(5)-Z(578)*Z(238)-Z(579)*Z(9)-Z(581)*Z(246)-Z(5
     &82)*Z(250)) + MG*(Z(574)*Z(234)+2*Z(561)*Z(3)+2*Z(567)*Z(26)+L2*GS
     &*Z(108)-Z(563)-Z(564)-Z(569)-2*Z(571)*Z(5)-Z(578)*Z(238)-Z(579)*Z(
     &9)-L6*GS*Z(113)-L8*GS*Z(29)) + MF*(Z(574)*Z(234)+Z(574)*Z(242)+Z(5
     &84)*Z(258)+2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z(563)-Z(564)-Z(569)-2*Z(5
     &71)*Z(5)-Z(578)*Z(238)-Z(578)*Z(246)-Z(579)*Z(9)-Z(579)*Z(250)-Z(5
     &86)*Z(262)-Z(587)*Z(266)) + MI*(Z(574)*Z(234)+Z(588)*Z(108)+Z(589)
     &*Z(318)+2*Z(561)*Z(3)+2*Z(567)*Z(26)-Z(563)-Z(564)-Z(569)-2*Z(571)
     &*Z(5)-Z(578)*Z(238)-Z(579)*Z(9)-Z(594)*Z(113)-Z(595)*Z(29)-Z(597)*
     &Z(322)-Z(598)*Z(326)) + 0.5D0*MH*(Z(602)*Z(286)+Z(603)*Z(294)+2*Z(
     &567)*Z(258)+2*Z(574)*Z(234)+2*Z(574)*Z(242)+2*Z(604)*Z(274)+4*Z(56
     &1)*Z(3)+4*Z(567)*Z(26)-2*Z(563)-2*Z(564)-2*Z(569)-4*Z(571)*Z(5)-2*
     &Z(569)*Z(266)-2*Z(571)*Z(262)-2*Z(578)*Z(238)-2*Z(578)*Z(246)-2*Z(
     &579)*Z(9)-2*Z(579)*Z(250)-2*Z(600)*Z(290)-2*Z(608)*Z(282)-Z(559)*Z
     &(278)) - INA - INB - INC - Z(612) - 0.25D0*MB*(Z(558)-4*Z(559)*Z(4
     &0)-4*Z(560)*Z(3))
      Z(615) = MC*(2*Z(561)*Z(3)+2*Z(562)*Z(26)-Z(563)-Z(564)-Z(565)-2*Z
     &(566)*Z(5)) + MD*(2*Z(561)*Z(3)+2*Z(567)*Z(26)+2*Z(568)*Z(234)-Z(5
     &63)-Z(564)-Z(569)-Z(570)-2*Z(571)*Z(5)-2*Z(572)*Z(238)-2*Z(573)*Z(
     &9)) + ME*(Z(575)*Z(242)+2*Z(561)*Z(3)+2*Z(567)*Z(26)+2*Z(574)*Z(23
     &4)-Z(563)-Z(564)-Z(569)-Z(576)-2*Z(571)*Z(5)-2*Z(578)*Z(238)-2*Z(5
     &79)*Z(9)-Z(580)*Z(254)-Z(581)*Z(246)-Z(582)*Z(250)) + MG*(2*Z(561)
     &*Z(3)+2*Z(567)*Z(26)+2*Z(574)*Z(234)+L2*GS*Z(108)-Z(563)-Z(564)-Z(
     &569)-Z(576)-2*Z(571)*Z(5)-2*Z(578)*Z(238)-2*Z(579)*Z(9)-L10*GS*Z(1
     &1)-L6*GS*Z(113)-L8*GS*Z(29)) + MF*(Z(574)*Z(242)+Z(584)*Z(258)+2*Z
     &(561)*Z(3)+2*Z(567)*Z(26)+2*Z(574)*Z(234)-Z(563)-Z(564)-Z(569)-Z(5
     &76)-2*Z(571)*Z(5)-2*Z(578)*Z(238)-2*Z(579)*Z(9)-Z(576)*Z(254)-Z(57
     &8)*Z(246)-Z(579)*Z(250)-Z(583)*Z(270)-Z(586)*Z(262)-Z(587)*Z(266))
     & + MI*(Z(588)*Z(108)+Z(589)*Z(318)+2*Z(561)*Z(3)+2*Z(567)*Z(26)+2*
     &Z(574)*Z(234)-Z(563)-Z(564)-Z(569)-Z(576)-2*Z(571)*Z(5)-2*Z(578)*Z
     &(238)-2*Z(579)*Z(9)-Z(592)*Z(11)-Z(593)*Z(330)-Z(594)*Z(113)-Z(595
     &)*Z(29)-Z(597)*Z(322)-Z(598)*Z(326)) + 0.5D0*MH*(Z(601)*Z(302)+Z(6
     &02)*Z(286)+Z(603)*Z(294)+2*Z(567)*Z(258)+2*Z(574)*Z(242)+2*Z(604)*
     &Z(274)+4*Z(561)*Z(3)+4*Z(567)*Z(26)+4*Z(574)*Z(234)-2*Z(563)-2*Z(5
     &64)-2*Z(569)-2*Z(576)-4*Z(571)*Z(5)-4*Z(578)*Z(238)-4*Z(579)*Z(9)-
     &2*Z(569)*Z(266)-2*Z(571)*Z(262)-2*Z(576)*Z(254)-2*Z(578)*Z(246)-2*
     &Z(579)*Z(250)-2*Z(579)*Z(270)-2*Z(600)*Z(290)-2*Z(607)*Z(298)-2*Z(
     &608)*Z(282)-Z(559)*Z(278)) - INA - INB - INC - IND - Z(612) - 0.25
     &D0*MB*(Z(558)-4*Z(559)*Z(40)-4*Z(560)*Z(3))
      Z(621) = Z(539) + Z(541) + Z(543) + 0.25D0*MB*(Z(616)*Z(168)+2*L2*
     &Z(4)*Z(168)+2*L2*Z(41)*Z(169)+2*L3*Z(42)*Z(165)-Z(617)*Z(169)-2*L4
     &*Z(4)*Z(165)) + MD*(L2*Z(4)*Z(173)+L2*Z(28)*Z(177)+L2*Z(233)*Z(179
     &)+L8*Z(6)*Z(173)+L8*Z(27)*Z(165)+L9*Z(10)*Z(177)+L9*Z(232)*Z(165)-
     &L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(237)*Z(179)-L8*Z(10)*Z(179)-L9*
     &Z(236)*Z(173)) + MG*(GS*Z(198)+L10*Z(10)*Z(177)+L10*Z(11)*Z(198)+L
     &10*Z(12)*Z(197)+L10*Z(232)*Z(165)+L2*Z(4)*Z(173)+L2*Z(28)*Z(177)+L
     &2*Z(233)*Z(181)+L6*Z(111)*Z(197)+L6*Z(113)*Z(198)+L8*Z(6)*Z(173)+L
     &8*Z(27)*Z(165)+L8*Z(29)*Z(198)+L8*Z(31)*Z(197)+GS*Z(12)*Z(181)+GS*
     &Z(107)*Z(165)-L10*Z(236)*Z(173)-L2*Z(106)*Z(197)-L2*Z(108)*Z(198)-
     &L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(237)*Z(181)-L8*Z(10)*Z(181)-GS*
     &Z(30)*Z(177)-GS*Z(112)*Z(173)) + ME*(L2*Z(183)*Z(242)+L10*Z(10)*Z(
     &177)+L10*Z(232)*Z(165)+L2*Z(4)*Z(173)+L2*Z(28)*Z(177)+L2*Z(233)*Z(
     &181)+L2*Z(241)*Z(184)+L8*Z(6)*Z(173)+L8*Z(27)*Z(165)+Z(21)*Z(240)*
     &Z(165)-Z(21)*Z(183)-L10*Z(183)*Z(254)-L6*Z(183)*Z(246)-L8*Z(183)*Z
     &(250)-L10*Z(236)*Z(173)-L10*Z(253)*Z(184)-L6*Z(4)*Z(165)-L6*Z(6)*Z
     &(177)-L6*Z(237)*Z(181)-L6*Z(245)*Z(184)-L8*Z(10)*Z(181)-L8*Z(249)*
     &Z(184)-Z(21)*Z(244)*Z(173)-Z(21)*Z(248)*Z(177)-Z(21)*Z(252)*Z(181)
     &) + MI*(Z(25)*Z(212)+L10*Z(212)*Z(330)+L11*Z(212)*Z(133)+L6*Z(212)
     &*Z(322)+L8*Z(212)*Z(326)+L10*Z(10)*Z(177)+L10*Z(232)*Z(165)+L11*Z(
     &12)*Z(181)+L11*Z(107)*Z(165)+L2*Z(4)*Z(173)+L2*Z(28)*Z(177)+L2*Z(1
     &06)*Z(200)+L2*Z(233)*Z(181)+L2*Z(317)*Z(214)+L8*Z(6)*Z(173)+L8*Z(2
     &7)*Z(165)+Z(25)*Z(316)*Z(165)-L2*Z(212)*Z(318)-L10*Z(12)*Z(200)-L1
     &0*Z(236)*Z(173)-L10*Z(329)*Z(214)-L11*Z(30)*Z(177)-L11*Z(112)*Z(17
     &3)-L11*Z(132)*Z(214)-L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(111)*Z(200
     &)-L6*Z(237)*Z(181)-L6*Z(321)*Z(214)-L8*Z(10)*Z(181)-L8*Z(31)*Z(200
     &)-L8*Z(325)*Z(214)-Z(25)*Z(131)*Z(200)-Z(25)*Z(320)*Z(173)-Z(25)*Z
     &(324)*Z(177)-Z(25)*Z(328)*Z(181)) + MF*(L10*Z(15)*Z(189)+Z(22)*Z(1
     &5)*Z(186)+L2*Z(186)*Z(242)+L2*Z(189)*Z(258)+L10*Z(16)*Z(191)+L10*Z
     &(10)*Z(177)+L10*Z(232)*Z(165)+L10*Z(240)*Z(165)+L2*Z(4)*Z(173)+L2*
     &Z(28)*Z(177)+L2*Z(233)*Z(181)+L2*Z(241)*Z(187)+L2*Z(257)*Z(191)+L8
     &*Z(6)*Z(173)+L8*Z(27)*Z(165)+Z(22)*Z(256)*Z(165)-L10*Z(186)-Z(22)*
     &Z(189)-L10*Z(186)*Z(254)-L10*Z(189)*Z(270)-L6*Z(186)*Z(246)-L6*Z(1
     &89)*Z(262)-L8*Z(186)*Z(250)-L8*Z(189)*Z(266)-L10*Z(236)*Z(173)-L10
     &*Z(244)*Z(173)-L10*Z(248)*Z(177)-L10*Z(252)*Z(181)-L10*Z(253)*Z(18
     &7)-L10*Z(269)*Z(191)-L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(237)*Z(181
     &)-L6*Z(245)*Z(187)-L6*Z(261)*Z(191)-L8*Z(10)*Z(181)-L8*Z(249)*Z(18
     &7)-L8*Z(265)*Z(191)-Z(22)*Z(16)*Z(187)-Z(22)*Z(260)*Z(173)-Z(22)*Z
     &(264)*Z(177)-Z(22)*Z(268)*Z(181)) + 0.25D0*MH*(L3*Z(205)+4*Z(24)*Z
     &(203)+4*L10*Z(15)*Z(193)+4*L8*Z(15)*Z(186)+4*Z(24)*Z(17)*Z(193)+2*
     &L2*Z(205)*Z(278)+2*L3*Z(186)*Z(310)+2*L3*Z(193)*Z(314)+4*L10*Z(203
     &)*Z(298)+4*L10*Z(203)*Z(306)+4*L2*Z(186)*Z(242)+4*L2*Z(193)*Z(258)
     &+4*L6*Z(203)*Z(282)+4*L8*Z(203)*Z(290)+2*Z(616)*Z(206)+4*Z(618)*Z(
     &207)+2*L3*Z(284)*Z(173)+2*L3*Z(292)*Z(177)+2*L3*Z(300)*Z(181)+2*L3
     &*Z(308)*Z(187)+2*L3*Z(312)*Z(194)+4*L10*Z(16)*Z(194)+4*L10*Z(10)*Z
     &(177)+4*L10*Z(232)*Z(165)+4*L10*Z(240)*Z(165)+4*L2*Z(4)*Z(173)+4*L
     &2*Z(28)*Z(177)+4*L2*Z(233)*Z(181)+4*L2*Z(241)*Z(187)+4*L2*Z(257)*Z
     &(194)+4*L2*Z(273)*Z(206)+4*L2*Z(277)*Z(207)+4*L8*Z(6)*Z(173)+4*L8*
     &Z(27)*Z(165)+4*L8*Z(256)*Z(165)+4*Z(24)*Z(18)*Z(194)+4*Z(24)*Z(272
     &)*Z(165)-4*L10*Z(186)-4*L8*Z(193)-2*Z(619)*Z(203)-2*Z(620)*Z(205)-
     &4*L8*Z(17)*Z(203)-4*L10*Z(186)*Z(254)-4*L10*Z(193)*Z(270)-4*L2*Z(2
     &03)*Z(274)-4*L6*Z(186)*Z(246)-4*L6*Z(193)*Z(262)-4*L8*Z(186)*Z(250
     &)-4*L8*Z(193)*Z(266)-4*Z(24)*Z(186)*Z(306)-2*L10*Z(205)*Z(302)-2*L
     &10*Z(205)*Z(310)-2*L6*Z(205)*Z(286)-2*L8*Z(205)*Z(294)-2*L8*Z(205)
     &*Z(314)-4*L10*Z(236)*Z(173)-4*L10*Z(244)*Z(173)-4*L10*Z(248)*Z(177
     &)-4*L10*Z(252)*Z(181)-4*L10*Z(253)*Z(187)-4*L10*Z(269)*Z(194)-4*L1
     &0*Z(297)*Z(206)-4*L10*Z(301)*Z(207)-4*L10*Z(305)*Z(206)-4*L10*Z(30
     &9)*Z(207)-4*L6*Z(4)*Z(165)-4*L6*Z(6)*Z(177)-4*L6*Z(237)*Z(181)-4*L
     &6*Z(245)*Z(187)-4*L6*Z(261)*Z(194)-4*L6*Z(281)*Z(206)-4*L6*Z(285)*
     &Z(207)-4*L8*Z(16)*Z(187)-4*L8*Z(18)*Z(206)-4*L8*Z(10)*Z(181)-4*L8*
     &Z(249)*Z(187)-4*L8*Z(260)*Z(173)-4*L8*Z(264)*Z(177)-4*L8*Z(265)*Z(
     &194)-4*L8*Z(268)*Z(181)-4*L8*Z(289)*Z(206)-4*L8*Z(293)*Z(207)-4*L8
     &*Z(313)*Z(207)-4*Z(24)*Z(280)*Z(173)-4*Z(24)*Z(288)*Z(177)-4*Z(24)
     &*Z(296)*Z(181)-4*Z(24)*Z(304)*Z(187)-2*L3*Z(276)*Z(165)) - Z(537) 
     &- MC*(L6*Z(4)*Z(165)+L6*Z(6)*Z(175)-L2*Z(4)*Z(173)-L2*Z(28)*Z(175)
     &-L7*Z(6)*Z(173)-L7*Z(27)*Z(165))
      Z(627) = L2*(MB*(Z(4)*Z(168)+Z(41)*Z(169))+2*MC*(Z(4)*Z(173)+Z(28)
     &*Z(175))+2*MD*(Z(4)*Z(173)+Z(28)*Z(177)+Z(233)*Z(179))+2*ME*(Z(183
     &)*Z(242)+Z(4)*Z(173)+Z(28)*Z(177)+Z(233)*Z(181)+Z(241)*Z(184))+2*M
     &F*(Z(186)*Z(242)+Z(189)*Z(258)+Z(4)*Z(173)+Z(28)*Z(177)+Z(233)*Z(1
     &81)+Z(241)*Z(187)+Z(257)*Z(191))-2*MG*(Z(106)*Z(197)+Z(108)*Z(198)
     &-Z(4)*Z(173)-Z(28)*Z(177)-Z(233)*Z(181))-2*MI*(Z(212)*Z(318)-Z(4)*
     &Z(173)-Z(28)*Z(177)-Z(106)*Z(200)-Z(233)*Z(181)-Z(317)*Z(214))-MH*
     &(2*Z(203)*Z(274)-2*Z(186)*Z(242)-2*Z(193)*Z(258)-Z(205)*Z(278)-2*Z
     &(4)*Z(173)-2*Z(28)*Z(177)-2*Z(233)*Z(181)-2*Z(241)*Z(187)-2*Z(257)
     &*Z(194)-2*Z(273)*Z(206)-2*Z(277)*Z(207)))
      Z(633) = -MC*(L2*Z(4)*Z(173)+L2*Z(28)*Z(175)-L6*Z(4)*Z(165)-L6*Z(6
     &)*Z(175)) - MD*(L2*Z(4)*Z(173)+L2*Z(28)*Z(177)+L2*Z(233)*Z(179)-L6
     &*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(237)*Z(179)) - 0.25D0*MB*(Z(616)*
     &Z(168)+2*L2*Z(4)*Z(168)+2*L2*Z(41)*Z(169)+2*L3*Z(42)*Z(165)-Z(617)
     &*Z(169)-2*L4*Z(4)*Z(165)) - ME*(L2*Z(183)*Z(242)+L2*Z(4)*Z(173)+L2
     &*Z(28)*Z(177)+L2*Z(233)*Z(181)+L2*Z(241)*Z(184)-L6*Z(183)*Z(246)-L
     &6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(237)*Z(181)-L6*Z(245)*Z(184)) - 
     &MG*(L2*Z(4)*Z(173)+L2*Z(28)*Z(177)+L2*Z(233)*Z(181)+L6*Z(111)*Z(19
     &7)+L6*Z(113)*Z(198)-L2*Z(106)*Z(197)-L2*Z(108)*Z(198)-L6*Z(4)*Z(16
     &5)-L6*Z(6)*Z(177)-L6*Z(237)*Z(181)) - MI*(L6*Z(212)*Z(322)+L2*Z(4)
     &*Z(173)+L2*Z(28)*Z(177)+L2*Z(106)*Z(200)+L2*Z(233)*Z(181)+L2*Z(317
     &)*Z(214)-L2*Z(212)*Z(318)-L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(111)*
     &Z(200)-L6*Z(237)*Z(181)-L6*Z(321)*Z(214)) - MF*(L2*Z(186)*Z(242)+L
     &2*Z(189)*Z(258)+L2*Z(4)*Z(173)+L2*Z(28)*Z(177)+L2*Z(233)*Z(181)+L2
     &*Z(241)*Z(187)+L2*Z(257)*Z(191)-L6*Z(186)*Z(246)-L6*Z(189)*Z(262)-
     &L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(237)*Z(181)-L6*Z(245)*Z(187)-L6
     &*Z(261)*Z(191)) - 0.5D0*MH*(L2*Z(205)*Z(278)+2*L2*Z(186)*Z(242)+2*
     &L2*Z(193)*Z(258)+2*L6*Z(203)*Z(282)+2*L2*Z(4)*Z(173)+2*L2*Z(28)*Z(
     &177)+2*L2*Z(233)*Z(181)+2*L2*Z(241)*Z(187)+2*L2*Z(257)*Z(194)+2*L2
     &*Z(273)*Z(206)+2*L2*Z(277)*Z(207)-2*L2*Z(203)*Z(274)-2*L6*Z(186)*Z
     &(246)-2*L6*Z(193)*Z(262)-L6*Z(205)*Z(286)-2*L6*Z(4)*Z(165)-2*L6*Z(
     &6)*Z(177)-2*L6*Z(237)*Z(181)-2*L6*Z(245)*Z(187)-2*L6*Z(261)*Z(194)
     &-2*L6*Z(281)*Z(206)-2*L6*Z(285)*Z(207))
      Z(637) = MC*(L6*Z(4)*Z(165)+L6*Z(6)*Z(175)-L2*Z(4)*Z(173)-L2*Z(28)
     &*Z(175)-L7*Z(6)*Z(173)-L7*Z(27)*Z(165)) + MD*(L6*Z(4)*Z(165)+L6*Z(
     &6)*Z(177)+L6*Z(237)*Z(179)+L8*Z(10)*Z(179)-L2*Z(4)*Z(173)-L2*Z(28)
     &*Z(177)-L2*Z(233)*Z(179)-L8*Z(6)*Z(173)-L8*Z(27)*Z(165)) + MG*(L2*
     &Z(106)*Z(197)+L2*Z(108)*Z(198)+L6*Z(4)*Z(165)+L6*Z(6)*Z(177)+L6*Z(
     &237)*Z(181)+L8*Z(10)*Z(181)-L2*Z(4)*Z(173)-L2*Z(28)*Z(177)-L2*Z(23
     &3)*Z(181)-L6*Z(111)*Z(197)-L6*Z(113)*Z(198)-L8*Z(6)*Z(173)-L8*Z(27
     &)*Z(165)-L8*Z(29)*Z(198)-L8*Z(31)*Z(197)) - 0.25D0*MB*(Z(616)*Z(16
     &8)+2*L2*Z(4)*Z(168)+2*L2*Z(41)*Z(169)+2*L3*Z(42)*Z(165)-Z(617)*Z(1
     &69)-2*L4*Z(4)*Z(165)) - ME*(L2*Z(183)*Z(242)+L2*Z(4)*Z(173)+L2*Z(2
     &8)*Z(177)+L2*Z(233)*Z(181)+L2*Z(241)*Z(184)+L8*Z(6)*Z(173)+L8*Z(27
     &)*Z(165)-L6*Z(183)*Z(246)-L8*Z(183)*Z(250)-L6*Z(4)*Z(165)-L6*Z(6)*
     &Z(177)-L6*Z(237)*Z(181)-L6*Z(245)*Z(184)-L8*Z(10)*Z(181)-L8*Z(249)
     &*Z(184)) - MI*(L6*Z(212)*Z(322)+L8*Z(212)*Z(326)+L2*Z(4)*Z(173)+L2
     &*Z(28)*Z(177)+L2*Z(106)*Z(200)+L2*Z(233)*Z(181)+L2*Z(317)*Z(214)+L
     &8*Z(6)*Z(173)+L8*Z(27)*Z(165)-L2*Z(212)*Z(318)-L6*Z(4)*Z(165)-L6*Z
     &(6)*Z(177)-L6*Z(111)*Z(200)-L6*Z(237)*Z(181)-L6*Z(321)*Z(214)-L8*Z
     &(10)*Z(181)-L8*Z(31)*Z(200)-L8*Z(325)*Z(214)) - MF*(L2*Z(186)*Z(24
     &2)+L2*Z(189)*Z(258)+L2*Z(4)*Z(173)+L2*Z(28)*Z(177)+L2*Z(233)*Z(181
     &)+L2*Z(241)*Z(187)+L2*Z(257)*Z(191)+L8*Z(6)*Z(173)+L8*Z(27)*Z(165)
     &-L6*Z(186)*Z(246)-L6*Z(189)*Z(262)-L8*Z(186)*Z(250)-L8*Z(189)*Z(26
     &6)-L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(237)*Z(181)-L6*Z(245)*Z(187)
     &-L6*Z(261)*Z(191)-L8*Z(10)*Z(181)-L8*Z(249)*Z(187)-L8*Z(265)*Z(191
     &)) - 0.5D0*MH*(L2*Z(205)*Z(278)+2*L2*Z(186)*Z(242)+2*L2*Z(193)*Z(2
     &58)+2*L6*Z(203)*Z(282)+2*L8*Z(203)*Z(290)+2*L2*Z(4)*Z(173)+2*L2*Z(
     &28)*Z(177)+2*L2*Z(233)*Z(181)+2*L2*Z(241)*Z(187)+2*L2*Z(257)*Z(194
     &)+2*L2*Z(273)*Z(206)+2*L2*Z(277)*Z(207)+2*L8*Z(6)*Z(173)+2*L8*Z(27
     &)*Z(165)-2*L2*Z(203)*Z(274)-2*L6*Z(186)*Z(246)-2*L6*Z(193)*Z(262)-
     &2*L8*Z(186)*Z(250)-2*L8*Z(193)*Z(266)-L6*Z(205)*Z(286)-L8*Z(205)*Z
     &(294)-2*L6*Z(4)*Z(165)-2*L6*Z(6)*Z(177)-2*L6*Z(237)*Z(181)-2*L6*Z(
     &245)*Z(187)-2*L6*Z(261)*Z(194)-2*L6*Z(281)*Z(206)-2*L6*Z(285)*Z(20
     &7)-2*L8*Z(10)*Z(181)-2*L8*Z(249)*Z(187)-2*L8*Z(265)*Z(194)-2*L8*Z(
     &289)*Z(206)-2*L8*Z(293)*Z(207))
      Z(640) = MC*(L6*Z(4)*Z(165)+L6*Z(6)*Z(175)-L2*Z(4)*Z(173)-L2*Z(28)
     &*Z(175)-L7*Z(6)*Z(173)-L7*Z(27)*Z(165)) + MG*(L10*Z(236)*Z(173)+L2
     &*Z(106)*Z(197)+L2*Z(108)*Z(198)+L6*Z(4)*Z(165)+L6*Z(6)*Z(177)+L6*Z
     &(237)*Z(181)+L8*Z(10)*Z(181)-L10*Z(10)*Z(177)-L10*Z(11)*Z(198)-L10
     &*Z(12)*Z(197)-L10*Z(232)*Z(165)-L2*Z(4)*Z(173)-L2*Z(28)*Z(177)-L2*
     &Z(233)*Z(181)-L6*Z(111)*Z(197)-L6*Z(113)*Z(198)-L8*Z(6)*Z(173)-L8*
     &Z(27)*Z(165)-L8*Z(29)*Z(198)-L8*Z(31)*Z(197)) - 0.25D0*MB*(Z(616)*
     &Z(168)+2*L2*Z(4)*Z(168)+2*L2*Z(41)*Z(169)+2*L3*Z(42)*Z(165)-Z(617)
     &*Z(169)-2*L4*Z(4)*Z(165)) - MD*(L2*Z(4)*Z(173)+L2*Z(28)*Z(177)+L2*
     &Z(233)*Z(179)+L8*Z(6)*Z(173)+L8*Z(27)*Z(165)+L9*Z(10)*Z(177)+L9*Z(
     &232)*Z(165)-L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(237)*Z(179)-L8*Z(10
     &)*Z(179)-L9*Z(236)*Z(173)) - ME*(L2*Z(183)*Z(242)+L10*Z(10)*Z(177)
     &+L10*Z(232)*Z(165)+L2*Z(4)*Z(173)+L2*Z(28)*Z(177)+L2*Z(233)*Z(181)
     &+L2*Z(241)*Z(184)+L8*Z(6)*Z(173)+L8*Z(27)*Z(165)-L10*Z(183)*Z(254)
     &-L6*Z(183)*Z(246)-L8*Z(183)*Z(250)-L10*Z(236)*Z(173)-L10*Z(253)*Z(
     &184)-L6*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(237)*Z(181)-L6*Z(245)*Z(18
     &4)-L8*Z(10)*Z(181)-L8*Z(249)*Z(184)) - MI*(L10*Z(212)*Z(330)+L6*Z(
     &212)*Z(322)+L8*Z(212)*Z(326)+L10*Z(10)*Z(177)+L10*Z(232)*Z(165)+L2
     &*Z(4)*Z(173)+L2*Z(28)*Z(177)+L2*Z(106)*Z(200)+L2*Z(233)*Z(181)+L2*
     &Z(317)*Z(214)+L8*Z(6)*Z(173)+L8*Z(27)*Z(165)-L2*Z(212)*Z(318)-L10*
     &Z(12)*Z(200)-L10*Z(236)*Z(173)-L10*Z(329)*Z(214)-L6*Z(4)*Z(165)-L6
     &*Z(6)*Z(177)-L6*Z(111)*Z(200)-L6*Z(237)*Z(181)-L6*Z(321)*Z(214)-L8
     &*Z(10)*Z(181)-L8*Z(31)*Z(200)-L8*Z(325)*Z(214)) - MF*(L2*Z(186)*Z(
     &242)+L2*Z(189)*Z(258)+L10*Z(10)*Z(177)+L10*Z(232)*Z(165)+L2*Z(4)*Z
     &(173)+L2*Z(28)*Z(177)+L2*Z(233)*Z(181)+L2*Z(241)*Z(187)+L2*Z(257)*
     &Z(191)+L8*Z(6)*Z(173)+L8*Z(27)*Z(165)-L10*Z(186)*Z(254)-L10*Z(189)
     &*Z(270)-L6*Z(186)*Z(246)-L6*Z(189)*Z(262)-L8*Z(186)*Z(250)-L8*Z(18
     &9)*Z(266)-L10*Z(236)*Z(173)-L10*Z(253)*Z(187)-L10*Z(269)*Z(191)-L6
     &*Z(4)*Z(165)-L6*Z(6)*Z(177)-L6*Z(237)*Z(181)-L6*Z(245)*Z(187)-L6*Z
     &(261)*Z(191)-L8*Z(10)*Z(181)-L8*Z(249)*Z(187)-L8*Z(265)*Z(191)) - 
     &0.5D0*MH*(L2*Z(205)*Z(278)+2*L10*Z(203)*Z(298)+2*L2*Z(186)*Z(242)+
     &2*L2*Z(193)*Z(258)+2*L6*Z(203)*Z(282)+2*L8*Z(203)*Z(290)+2*L10*Z(1
     &0)*Z(177)+2*L10*Z(232)*Z(165)+2*L2*Z(4)*Z(173)+2*L2*Z(28)*Z(177)+2
     &*L2*Z(233)*Z(181)+2*L2*Z(241)*Z(187)+2*L2*Z(257)*Z(194)+2*L2*Z(273
     &)*Z(206)+2*L2*Z(277)*Z(207)+2*L8*Z(6)*Z(173)+2*L8*Z(27)*Z(165)-2*L
     &10*Z(186)*Z(254)-2*L10*Z(193)*Z(270)-2*L2*Z(203)*Z(274)-2*L6*Z(186
     &)*Z(246)-2*L6*Z(193)*Z(262)-2*L8*Z(186)*Z(250)-2*L8*Z(193)*Z(266)-
     &L10*Z(205)*Z(302)-L6*Z(205)*Z(286)-L8*Z(205)*Z(294)-2*L10*Z(236)*Z
     &(173)-2*L10*Z(253)*Z(187)-2*L10*Z(269)*Z(194)-2*L10*Z(297)*Z(206)-
     &2*L10*Z(301)*Z(207)-2*L6*Z(4)*Z(165)-2*L6*Z(6)*Z(177)-2*L6*Z(237)*
     &Z(181)-2*L6*Z(245)*Z(187)-2*L6*Z(261)*Z(194)-2*L6*Z(281)*Z(206)-2*
     &L6*Z(285)*Z(207)-2*L8*Z(10)*Z(181)-2*L8*Z(249)*Z(187)-2*L8*Z(265)*
     &Z(194)-2*L8*Z(289)*Z(206)-2*L8*Z(293)*Z(207))
      Z(676) = Z(504) - Z(550)
      Z(677) = Z(506) - Z(556)
      Z(678) = Z(508) - Z(621)
      Z(679) = Z(517) + 0.5D0*Z(627)
      Z(680) = Z(518) - Z(633)
      Z(681) = Z(519) - Z(637)
      Z(682) = Z(520) - Z(640)

      COEF(1,1) = -Z(74)
      COEF(1,2) = 0
      COEF(1,3) = -Z(544)
      COEF(1,4) = -Z(546)
      COEF(1,5) = -Z(547)
      COEF(1,6) = -Z(548)
      COEF(1,7) = -Z(549)
      COEF(2,1) = 0
      COEF(2,2) = -Z(74)
      COEF(2,3) = -Z(551)
      COEF(2,4) = -Z(552)
      COEF(2,5) = -Z(553)
      COEF(2,6) = -Z(554)
      COEF(2,7) = -Z(555)
      COEF(3,1) = -Z(544)
      COEF(3,2) = -Z(551)
      COEF(3,3) = -Z(609)
      COEF(3,4) = -Z(611)
      COEF(3,5) = -Z(613)
      COEF(3,6) = -Z(614)
      COEF(3,7) = -Z(615)
      COEF(4,1) = -Z(546)
      COEF(4,2) = -Z(552)
      COEF(4,3) = -Z(611)
      COEF(4,4) = -Z(622)
      COEF(4,5) = -Z(624)
      COEF(4,6) = -Z(625)
      COEF(4,7) = -Z(626)
      COEF(5,1) = -Z(547)
      COEF(5,2) = -Z(553)
      COEF(5,3) = -Z(613)
      COEF(5,4) = -Z(624)
      COEF(5,5) = -Z(630)
      COEF(5,6) = -Z(631)
      COEF(5,7) = -Z(632)
      COEF(6,1) = -Z(548)
      COEF(6,2) = -Z(554)
      COEF(6,3) = -Z(614)
      COEF(6,4) = -Z(625)
      COEF(6,5) = -Z(631)
      COEF(6,6) = -Z(635)
      COEF(6,7) = -Z(636)
      COEF(7,1) = -Z(549)
      COEF(7,2) = -Z(555)
      COEF(7,3) = -Z(615)
      COEF(7,4) = -Z(626)
      COEF(7,5) = -Z(632)
      COEF(7,6) = -Z(636)
      COEF(7,7) = -Z(639)
      RHS(1) = -Z(676)
      RHS(2) = -Z(677)
      RHS(3) = -Z(678)
      RHS(4) = -Z(679)
      RHS(5) = -Z(680)
      RHS(6) = -Z(681)
      RHS(7) = -Z(682)
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
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(694),COEF(7,7),RHS(7)

C**   Evaluate output quantities
      KECM = 0.5D0*ING*U3**2 + 0.5D0*IND*(U3-U7)**2 + 0.5D0*INC*(U3-U6-U
     &7)**2 + 0.5D0*INE*(EAp-U3-U8)**2 + 0.5D0*INB*(U3-U5-U6-U7)**2 + 0.
     &5D0*INA*(U3-U4-U5-U6-U7)**2 + 0.5D0*INF*(EAp-FAp-U3-U8-U9)**2 + 0.
     &5D0*INH*(EAp+HAp-FAp-U10-U3-U8-U9)**2 + 0.5D0*INI*(EAp+IAp-FAp-U11
     &-U3-U8-U9)**2 + 0.5D0*MC*(U1**2+U2**2+L7**2*(U3-U6-U7)**2+2*L7*Z(3
     &4)*U1*(U3-U6-U7)+2*L7*Z(35)*U2*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)**2+2
     &*L6*Z(49)*U1*(U3-U5-U6-U7)+2*L6*Z(50)*U2*(U3-U5-U6-U7)+L2**2*(U3-U
     &4-U5-U6-U7)**2+2*L6*L7*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-2*L2*Z(38)*U1
     &*(U3-U4-U5-U6-U7)-2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-2*L2*L7*Z(26)*(U3
     &-U6-U7)*(U3-U4-U5-U6-U7)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U
     &7)) + 0.125D0*MB*(4*U1**2+4*U2**2+L3**2*(U3-U5-U6-U7)**2+L4**2*(U3
     &-U5-U6-U7)**2+4*L3*Z(45)*U1*(U3-U5-U6-U7)+4*L3*Z(46)*U2*(U3-U5-U6-
     &U7)+4*L4*Z(49)*U1*(U3-U5-U6-U7)+4*L4*Z(50)*U2*(U3-U5-U6-U7)+2*L3*L
     &4*Z(7)*(U3-U5-U6-U7)**2+4*L2**2*(U3-U4-U5-U6-U7)**2-8*L2*Z(38)*U1*
     &(U3-U4-U5-U6-U7)-8*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-4*L2*L3*Z(40)*(U3-
     &U5-U6-U7)*(U3-U4-U5-U6-U7)-4*L2*L4*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6
     &-U7)) + 0.5D0*MD*(U1**2+U2**2+L9**2*(U3-U7)**2+2*L9*Z(53)*U1*(U3-U
     &7)+2*L9*Z(54)*U2*(U3-U7)+L8**2*(U3-U6-U7)**2+2*L8*Z(34)*U1*(U3-U6-
     &U7)+2*L8*Z(35)*U2*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)**2+2*L6*Z(49)*U1*
     &(U3-U5-U6-U7)+2*L6*Z(50)*U2*(U3-U5-U6-U7)+L2**2*(U3-U4-U5-U6-U7)**
     &2+2*L8*L9*Z(9)*(U3-U7)*(U3-U6-U7)+2*L6*L9*Z(238)*(U3-U7)*(U3-U5-U6
     &-U7)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-2*L2*Z(38)*U1*(U3-U4-U5
     &-U6-U7)-2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-2*L2*L9*Z(234)*(U3-U7)*(U3-
     &U4-U5-U6-U7)-2*L2*L8*Z(26)*(U3-U6-U7)*(U3-U4-U5-U6-U7)-2*L2*L6*Z(3
     &)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)) + 0.5D0*ME*(U1**2+U2**2+L10**2*(
     &U3-U7)**2+2*L10*Z(53)*U1*(U3-U7)+2*L10*Z(54)*U2*(U3-U7)+(Z(138)-Z(
     &21)*U3-Z(21)*U8)**2+L8**2*(U3-U6-U7)**2+2*L8*Z(34)*U1*(U3-U6-U7)+2
     &*L8*Z(35)*U2*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)**2+2*L6*Z(49)*U1*(U3-U
     &5-U6-U7)+2*L6*Z(50)*U2*(U3-U5-U6-U7)+L2**2*(U3-U4-U5-U6-U7)**2+2*L
     &10*L8*Z(9)*(U3-U7)*(U3-U6-U7)+2*L10*L6*Z(238)*(U3-U7)*(U3-U5-U6-U7
     &)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)+2*L2*Z(242)*(Z(138)-Z(21)*
     &U3-Z(21)*U8)*(U3-U4-U5-U6-U7)-2*Z(55)*U2*(Z(138)-Z(21)*U3-Z(21)*U8
     &)-2*Z(57)*U1*(Z(138)-Z(21)*U3-Z(21)*U8)-2*L2*Z(38)*U1*(U3-U4-U5-U6
     &-U7)-2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-2*L10*Z(254)*(U3-U7)*(Z(138)-Z
     &(21)*U3-Z(21)*U8)-2*L8*Z(250)*(U3-U6-U7)*(Z(138)-Z(21)*U3-Z(21)*U8
     &)-2*L10*L2*Z(234)*(U3-U7)*(U3-U4-U5-U6-U7)-2*L6*Z(246)*(Z(138)-Z(2
     &1)*U3-Z(21)*U8)*(U3-U5-U6-U7)-2*L2*L8*Z(26)*(U3-U6-U7)*(U3-U4-U5-U
     &6-U7)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)) + 0.5D0*MG*(GSp
     &**2+U1**2+U2**2+2*GSp*Z(1)*U1+2*GSp*Z(2)*U2+GS**2*U3**2+2*GS*Z(1)*
     &U2*U3+L10**2*(U3-U7)**2+2*L10*GSp*Z(12)*(U3-U7)+2*L10*Z(53)*U1*(U3
     &-U7)+2*L10*Z(54)*U2*(U3-U7)+2*L10*GS*Z(11)*U3*(U3-U7)+L8**2*(U3-U6
     &-U7)**2+2*L8*GSp*Z(31)*(U3-U6-U7)+2*L8*Z(34)*U1*(U3-U6-U7)+2*L8*Z(
     &35)*U2*(U3-U6-U7)+2*L8*GS*Z(29)*U3*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)*
     &*2+2*L6*GSp*Z(111)*(U3-U5-U6-U7)+2*L6*Z(49)*U1*(U3-U5-U6-U7)+2*L6*
     &Z(50)*U2*(U3-U5-U6-U7)+2*L6*GS*Z(113)*U3*(U3-U5-U6-U7)+L2**2*(U3-U
     &4-U5-U6-U7)**2+2*L10*L8*Z(9)*(U3-U7)*(U3-U6-U7)+2*L10*L6*Z(238)*(U
     &3-U7)*(U3-U5-U6-U7)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-2*GS*Z(2
     &)*U1*U3-2*L2*GSp*Z(106)*(U3-U4-U5-U6-U7)-2*L2*Z(38)*U1*(U3-U4-U5-U
     &6-U7)-2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)-2*L2*GS*Z(108)*U3*(U3-U4-U5-U
     &6-U7)-2*L10*L2*Z(234)*(U3-U7)*(U3-U4-U5-U6-U7)-2*L2*L8*Z(26)*(U3-U
     &6-U7)*(U3-U4-U5-U6-U7)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)
     &) + 0.5D0*MI*(U1**2+U2**2+L11**2*U3**2+2*L11*Z(1)*U2*U3+L10**2*(U3
     &-U7)**2+2*L10*Z(53)*U1*(U3-U7)+2*L10*Z(54)*U2*(U3-U7)+2*L10*L11*Z(
     &11)*U3*(U3-U7)+L8**2*(U3-U6-U7)**2+2*L8*Z(34)*U1*(U3-U6-U7)+2*L8*Z
     &(35)*U2*(U3-U6-U7)+(Z(149)+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)**
     &2+2*L11*L8*Z(29)*U3*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)**2+2*L6*Z(49)*U
     &1*(U3-U5-U6-U7)+2*L6*Z(50)*U2*(U3-U5-U6-U7)+2*L11*L6*Z(113)*U3*(U3
     &-U5-U6-U7)+2*Z(72)*U1*(Z(149)+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9
     &)+2*Z(73)*U2*(Z(149)+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)+L2**2*(
     &U3-U4-U5-U6-U7)**2+2*L10*L8*Z(9)*(U3-U7)*(U3-U6-U7)+2*L11*Z(133)*U
     &3*(Z(149)+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)+2*L10*L6*Z(238)*(U
     &3-U7)*(U3-U5-U6-U7)+2*L10*Z(330)*(U3-U7)*(Z(149)+Z(25)*U11+Z(25)*U
     &3+Z(25)*U8+Z(25)*U9)+2*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)+2*L8*Z(
     &326)*(U3-U6-U7)*(Z(149)+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)+2*L6
     &*Z(322)*(U3-U5-U6-U7)*(Z(149)+Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9
     &)-2*L11*Z(2)*U1*U3-2*L2*Z(38)*U1*(U3-U4-U5-U6-U7)-2*L2*Z(39)*U2*(U
     &3-U4-U5-U6-U7)-2*L11*L2*Z(108)*U3*(U3-U4-U5-U6-U7)-2*L10*L2*Z(234)
     &*(U3-U7)*(U3-U4-U5-U6-U7)-2*L2*L8*Z(26)*(U3-U6-U7)*(U3-U4-U5-U6-U7
     &)-2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)-2*L2*Z(318)*(Z(149)+
     &Z(25)*U11+Z(25)*U3+Z(25)*U8+Z(25)*U9)*(U3-U4-U5-U6-U7)) - 0.5D0*MA
     &*(2*L1*Z(38)*U1*(U3-U4-U5-U6-U7)+2*L1*Z(39)*U2*(U3-U4-U5-U6-U7)-U1
     &**2-U2**2-L1**2*(U3-U4-U5-U6-U7)**2) - 0.5D0*MF*(2*Z(55)*U2*(Z(139
     &)-L10*U3-L10*U8)+2*Z(57)*U1*(Z(139)-L10*U3-L10*U8)+2*L2*Z(38)*U1*(
     &U3-U4-U5-U6-U7)+2*L2*Z(39)*U2*(U3-U4-U5-U6-U7)+2*Z(60)*U1*(Z(140)-
     &Z(22)*U3-Z(22)*U8-Z(22)*U9)+2*Z(61)*U2*(Z(140)-Z(22)*U3-Z(22)*U8-Z
     &(22)*U9)+2*L10*Z(254)*(U3-U7)*(Z(139)-L10*U3-L10*U8)+2*L8*Z(250)*(
     &U3-U6-U7)*(Z(139)-L10*U3-L10*U8)+2*L10*L2*Z(234)*(U3-U7)*(U3-U4-U5
     &-U6-U7)+2*L10*Z(270)*(U3-U7)*(Z(140)-Z(22)*U3-Z(22)*U8-Z(22)*U9)+2
     &*L6*Z(246)*(Z(139)-L10*U3-L10*U8)*(U3-U5-U6-U7)+2*L2*L8*Z(26)*(U3-
     &U6-U7)*(U3-U4-U5-U6-U7)+2*L8*Z(266)*(U3-U6-U7)*(Z(140)-Z(22)*U3-Z(
     &22)*U8-Z(22)*U9)+2*Z(15)*(Z(139)-L10*U3-L10*U8)*(Z(140)-Z(22)*U3-Z
     &(22)*U8-Z(22)*U9)+2*L2*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7)+2*L6
     &*Z(262)*(U3-U5-U6-U7)*(Z(140)-Z(22)*U3-Z(22)*U8-Z(22)*U9)-U1**2-U2
     &**2-2*L10*Z(53)*U1*(U3-U7)-2*L10*Z(54)*U2*(U3-U7)-L10**2*(U3-U7)**
     &2-2*L8*Z(34)*U1*(U3-U6-U7)-2*L8*Z(35)*U2*(U3-U6-U7)-(Z(139)-L10*U3
     &-L10*U8)**2-L8**2*(U3-U6-U7)**2-2*L6*Z(49)*U1*(U3-U5-U6-U7)-2*L6*Z
     &(50)*U2*(U3-U5-U6-U7)-L6**2*(U3-U5-U6-U7)**2-(Z(140)-Z(22)*U3-Z(22
     &)*U8-Z(22)*U9)**2-2*L10*L8*Z(9)*(U3-U7)*(U3-U6-U7)-L2**2*(U3-U4-U5
     &-U6-U7)**2-2*L10*L6*Z(238)*(U3-U7)*(U3-U5-U6-U7)-2*L6*L8*Z(5)*(U3-
     &U6-U7)*(U3-U5-U6-U7)-2*L2*Z(242)*(Z(139)-L10*U3-L10*U8)*(U3-U4-U5-
     &U6-U7)-2*L2*Z(258)*(U3-U4-U5-U6-U7)*(Z(140)-Z(22)*U3-Z(22)*U8-Z(22
     &)*U9)) - 0.125D0*MH*(8*Z(55)*U2*(Z(139)-L10*U3-L10*U8)+8*Z(57)*U1*
     &(Z(139)-L10*U3-L10*U8)+4*Z(68)*U1*(Z(147)+L3*U10+L3*U3+L3*U8+L3*U9
     &)+4*Z(69)*U2*(Z(147)+L3*U10+L3*U3+L3*U8+L3*U9)+8*L2*Z(38)*U1*(U3-U
     &4-U5-U6-U7)+8*L2*Z(39)*U2*(U3-U4-U5-U6-U7)+8*Z(60)*U1*(Z(141)-L8*U
     &3-L8*U8-L8*U9)+8*Z(61)*U2*(Z(141)-L8*U3-L8*U8-L8*U9)+8*L10*Z(254)*
     &(U3-U7)*(Z(139)-L10*U3-L10*U8)+4*L10*Z(302)*(U3-U7)*(Z(147)+L3*U10
     &+L3*U3+L3*U8+L3*U9)+8*L8*Z(250)*(U3-U6-U7)*(Z(139)-L10*U3-L10*U8)+
     &8*L10*L2*Z(234)*(U3-U7)*(U3-U4-U5-U6-U7)+8*L10*Z(270)*(U3-U7)*(Z(1
     &41)-L8*U3-L8*U8-L8*U9)+4*L8*Z(294)*(U3-U6-U7)*(Z(147)+L3*U10+L3*U3
     &+L3*U8+L3*U9)+8*L6*Z(246)*(Z(139)-L10*U3-L10*U8)*(U3-U5-U6-U7)+8*L
     &2*L8*Z(26)*(U3-U6-U7)*(U3-U4-U5-U6-U7)+8*L8*Z(266)*(U3-U6-U7)*(Z(1
     &41)-L8*U3-L8*U8-L8*U9)+8*Z(306)*(Z(139)-L10*U3-L10*U8)*(Z(146)+Z(2
     &4)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)+4*L6*Z(286)*(U3-U5-U6-U7)*(Z(14
     &7)+L3*U10+L3*U3+L3*U8+L3*U9)+8*Z(15)*(Z(139)-L10*U3-L10*U8)*(Z(141
     &)-L8*U3-L8*U8-L8*U9)+4*Z(7)*(Z(146)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(
     &24)*U9)*(Z(147)+L3*U10+L3*U3+L3*U8+L3*U9)+8*L2*L6*Z(3)*(U3-U5-U6-U
     &7)*(U3-U4-U5-U6-U7)+8*L6*Z(262)*(U3-U5-U6-U7)*(Z(141)-L8*U3-L8*U8-
     &L8*U9)+8*L2*Z(274)*(Z(146)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)*(
     &U3-U4-U5-U6-U7)-4*U1**2-4*U2**2-8*L10*Z(53)*U1*(U3-U7)-8*L10*Z(54)
     &*U2*(U3-U7)-4*L10**2*(U3-U7)**2-8*L8*Z(34)*U1*(U3-U6-U7)-8*L8*Z(35
     &)*U2*(U3-U6-U7)-4*(Z(139)-L10*U3-L10*U8)**2-4*L8**2*(U3-U6-U7)**2-
     &8*L6*Z(49)*U1*(U3-U5-U6-U7)-8*L6*Z(50)*U2*(U3-U5-U6-U7)-4*(Z(146)+
     &Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)**2-4*L6**2*(U3-U5-U6-U7)**2-
     &(Z(147)+L3*U10+L3*U3+L3*U8+L3*U9)**2-8*Z(64)*U1*(Z(146)+Z(24)*U10+
     &Z(24)*U3+Z(24)*U8+Z(24)*U9)-8*Z(65)*U2*(Z(146)+Z(24)*U10+Z(24)*U3+
     &Z(24)*U8+Z(24)*U9)-4*(Z(141)-L8*U3-L8*U8-L8*U9)**2-8*L10*L8*Z(9)*(
     &U3-U7)*(U3-U6-U7)-4*L2**2*(U3-U4-U5-U6-U7)**2-8*L10*L6*Z(238)*(U3-
     &U7)*(U3-U5-U6-U7)-8*L10*Z(298)*(U3-U7)*(Z(146)+Z(24)*U10+Z(24)*U3+
     &Z(24)*U8+Z(24)*U9)-8*L6*L8*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-8*L8*Z(29
     &0)*(U3-U6-U7)*(Z(146)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)-4*Z(31
     &0)*(Z(139)-L10*U3-L10*U8)*(Z(147)+L3*U10+L3*U3+L3*U8+L3*U9)-8*L2*Z
     &(242)*(Z(139)-L10*U3-L10*U8)*(U3-U4-U5-U6-U7)-8*L6*Z(282)*(U3-U5-U
     &6-U7)*(Z(146)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)-8*Z(17)*(Z(146
     &)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)*(Z(141)-L8*U3-L8*U8-L8*U9)
     &-4*L2*Z(278)*(Z(147)+L3*U10+L3*U3+L3*U8+L3*U9)*(U3-U4-U5-U6-U7)-4*
     &Z(314)*(Z(147)+L3*U10+L3*U3+L3*U8+L3*U9)*(Z(141)-L8*U3-L8*U8-L8*U9
     &)-8*L2*Z(258)*(U3-U4-U5-U6-U7)*(Z(141)-L8*U3-L8*U8-L8*U9))
      Z(82) = (Z(81)+MG*GS)/Z(74)
      POCMY = Q2 + Z(77)*Z(33) + Z(78)*Z(52) + Z(79)*Z(56) + Z(80)*Z(59)
     & + Z(83)*Z(63) + Z(84)*Z(71) + Z(82)*Z(2) + 0.5D0*Z(76)*Z(48) + 0.
     &5D0*Z(86)*Z(44) - Z(75)*Z(37) - 0.5D0*Z(85)*Z(67)
      PECM = 0.5D0*K1*Q1**2 + 0.5D0*K3*Q2**2 - G*MT*POCMY
      TE = KECM + PECM
      Z(332) = FAp - EAp
      Z(333) = INF*Z(332)
      Z(334) = FAp - EAp - HAp
      Z(335) = INH*Z(334)
      Z(336) = FAp - EAp - IAp
      Z(337) = INI*Z(336)
      Z(394) = MA*(Z(85)*Z(66)+2*Z(338)*Z(36)-2*Z(77)*Z(32)-2*Z(78)*Z(51
     &)-2*Z(79)*Z(55)-2*Z(80)*Z(58)-2*Z(83)*Z(62)-2*Z(84)*Z(70)-2*Z(82)*
     &Z(1)-Z(76)*Z(47)-Z(86)*Z(43))
      Z(400) = MB*(Z(85)*Z(66)+2*Z(339)*Z(36)+2*Z(340)*Z(47)+2*Z(341)*Z(
     &43)-2*Z(77)*Z(32)-2*Z(78)*Z(51)-2*Z(79)*Z(55)-2*Z(80)*Z(58)-2*Z(83
     &)*Z(62)-2*Z(84)*Z(70)-2*Z(82)*Z(1))
      Z(408) = MC*(Z(85)*Z(66)+2*Z(339)*Z(36)+2*Z(369)*Z(47)+2*Z(370)*Z(
     &32)-2*Z(78)*Z(51)-2*Z(79)*Z(55)-2*Z(80)*Z(58)-2*Z(83)*Z(62)-2*Z(84
     &)*Z(70)-2*Z(82)*Z(1)-Z(86)*Z(43))
      Z(414) = MD*(Z(85)*Z(66)+2*Z(339)*Z(36)+2*Z(369)*Z(47)+2*Z(371)*Z(
     &32)+2*Z(372)*Z(51)-2*Z(79)*Z(55)-2*Z(80)*Z(58)-2*Z(83)*Z(62)-2*Z(8
     &4)*Z(70)-2*Z(82)*Z(1)-Z(86)*Z(43))
      Z(421) = ME*(Z(85)*Z(66)+2*Z(339)*Z(36)+2*Z(369)*Z(47)+2*Z(371)*Z(
     &32)+2*Z(373)*Z(51)+2*Z(374)*Z(55)-2*Z(80)*Z(58)-2*Z(83)*Z(62)-2*Z(
     &84)*Z(70)-2*Z(82)*Z(1)-Z(86)*Z(43))
      Z(429) = MF*(Z(85)*Z(66)+2*Z(339)*Z(36)+2*Z(369)*Z(47)+2*Z(371)*Z(
     &32)+2*Z(373)*Z(51)+2*Z(379)*Z(55)+2*Z(380)*Z(58)-2*Z(83)*Z(62)-2*Z
     &(84)*Z(70)-2*Z(82)*Z(1)-Z(86)*Z(43))
      Z(384) = GS - Z(82)
      Z(437) = MG*(Z(86)*Z(44)+2*Z(79)*Z(56)+2*Z(80)*Z(59)+2*Z(83)*Z(63)
     &+2*Z(84)*Z(71)-2*Z(339)*Z(37)-2*Z(369)*Z(48)-2*Z(371)*Z(33)-2*Z(37
     &3)*Z(52)-2*Z(384)*Z(2)-Z(85)*Z(67))
      Z(446) = MH*(2*Z(339)*Z(36)+2*Z(369)*Z(47)+2*Z(371)*Z(32)+2*Z(373)
     &*Z(51)+2*Z(379)*Z(55)+2*Z(385)*Z(58)+2*Z(386)*Z(62)+2*Z(387)*Z(66)
     &-2*Z(84)*Z(70)-2*Z(82)*Z(1)-Z(86)*Z(43))
      Z(391) = L11 - Z(82)
      Z(457) = MI*(Z(86)*Z(44)+2*Z(79)*Z(56)+2*Z(80)*Z(59)+2*Z(83)*Z(63)
     &-2*Z(339)*Z(37)-2*Z(369)*Z(48)-2*Z(371)*Z(33)-2*Z(373)*Z(52)-2*Z(3
     &92)*Z(71)-2*Z(391)*Z(2)-Z(85)*Z(67))
      Z(235) = Z(3)*Z(231) + Z(4)*Z(233)
      Z(110) = Z(1)*Z(47) + Z(2)*Z(48)
      Z(398) = MB*(Z(397)+Z(85)*Z(283)+2*Z(339)*Z(3)-2*Z(77)*Z(5)-2*Z(78
     &)*Z(235)-2*Z(79)*Z(243)-2*Z(80)*Z(259)-2*Z(83)*Z(279)-2*Z(84)*Z(31
     &9)-2*Z(82)*Z(110))
      Z(134) = Z(1)*Z(43) + Z(2)*Z(44)
      Z(136) = Z(1)*Z(44) - Z(2)*Z(43)
      Z(349) = Z(13)*Z(134) - Z(14)*Z(136)
      Z(351) = Z(13)*Z(136) + Z(14)*Z(134)
      Z(355) = Z(16)*Z(349) - Z(15)*Z(351)
      Z(353) = -Z(15)*Z(349) - Z(16)*Z(351)
      Z(357) = Z(18)*Z(355) - Z(17)*Z(353)
      Z(359) = -Z(17)*Z(355) - Z(18)*Z(353)
      Z(365) = Z(7)*Z(357) - Z(8)*Z(359)
      Z(342) = Z(7)*Z(5) + Z(8)*Z(6)
      Z(344) = Z(8)*Z(5) - Z(7)*Z(6)
      Z(345) = Z(9)*Z(342) + Z(10)*Z(344)
      Z(361) = Z(20)*Z(359) - Z(19)*Z(357)
      Z(402) = MB*(Z(401)+Z(85)*Z(365)+2*Z(339)*Z(40)-2*Z(77)*Z(342)-2*Z
     &(78)*Z(345)-2*Z(79)*Z(349)-2*Z(80)*Z(353)-2*Z(83)*Z(357)-2*Z(84)*Z
     &(361)-2*Z(82)*Z(134))
      Z(405) = MC*(2*Z(369)+Z(85)*Z(283)+2*Z(339)*Z(3)+2*Z(370)*Z(5)-Z(4
     &04)-2*Z(78)*Z(235)-2*Z(79)*Z(243)-2*Z(80)*Z(259)-2*Z(83)*Z(279)-2*
     &Z(84)*Z(319)-2*Z(82)*Z(110))
      Z(406) = MC*(2*Z(370)+Z(85)*Z(291)+2*Z(339)*Z(26)+2*Z(369)*Z(5)-2*
     &Z(78)*Z(9)-2*Z(79)*Z(247)-2*Z(80)*Z(263)-2*Z(83)*Z(287)-2*Z(84)*Z(
     &323)-2*Z(82)*Z(29)-Z(86)*Z(342))
      Z(410) = MD*(2*Z(369)+Z(85)*Z(283)+2*Z(339)*Z(3)+2*Z(371)*Z(5)+2*Z
     &(372)*Z(235)-Z(404)-2*Z(79)*Z(243)-2*Z(80)*Z(259)-2*Z(83)*Z(279)-2
     &*Z(84)*Z(319)-2*Z(82)*Z(110))
      Z(411) = MD*(2*Z(371)+Z(85)*Z(291)+2*Z(339)*Z(26)+2*Z(369)*Z(5)+2*
     &Z(372)*Z(9)-2*Z(79)*Z(247)-2*Z(80)*Z(263)-2*Z(83)*Z(287)-2*Z(84)*Z
     &(323)-2*Z(82)*Z(29)-Z(86)*Z(342))
      Z(299) = Z(9)*Z(291) + Z(10)*Z(293)
      Z(251) = Z(9)*Z(247) + Z(10)*Z(249)
      Z(267) = Z(9)*Z(263) + Z(10)*Z(265)
      Z(295) = Z(9)*Z(287) + Z(10)*Z(289)
      Z(327) = Z(9)*Z(323) + Z(10)*Z(325)
      Z(412) = MD*(2*Z(372)+Z(85)*Z(299)+2*Z(339)*Z(231)+2*Z(369)*Z(235)
     &+2*Z(371)*Z(9)-2*Z(79)*Z(251)-2*Z(80)*Z(267)-2*Z(83)*Z(295)-2*Z(84
     &)*Z(327)-2*Z(82)*Z(11)-Z(86)*Z(345))
      Z(416) = ME*(2*Z(369)+Z(85)*Z(283)+2*Z(339)*Z(3)+2*Z(371)*Z(5)+2*Z
     &(373)*Z(235)+2*Z(374)*Z(243)-Z(404)-2*Z(80)*Z(259)-2*Z(83)*Z(279)-
     &2*Z(84)*Z(319)-2*Z(82)*Z(110))
      Z(417) = ME*(2*Z(371)+Z(85)*Z(291)+2*Z(339)*Z(26)+2*Z(369)*Z(5)+2*
     &Z(373)*Z(9)+2*Z(374)*Z(247)-2*Z(80)*Z(263)-2*Z(83)*Z(287)-2*Z(84)*
     &Z(323)-2*Z(82)*Z(29)-Z(86)*Z(342))
      Z(418) = ME*(2*Z(373)+Z(85)*Z(299)+2*Z(339)*Z(231)+2*Z(369)*Z(235)
     &+2*Z(371)*Z(9)+2*Z(374)*Z(251)-2*Z(80)*Z(267)-2*Z(83)*Z(295)-2*Z(8
     &4)*Z(327)-2*Z(82)*Z(11)-Z(86)*Z(345))
      Z(423) = MF*(2*Z(369)+Z(85)*Z(283)+2*Z(339)*Z(3)+2*Z(371)*Z(5)+2*Z
     &(373)*Z(235)+2*Z(379)*Z(243)+2*Z(380)*Z(259)-Z(404)-2*Z(83)*Z(279)
     &-2*Z(84)*Z(319)-2*Z(82)*Z(110))
      Z(424) = MF*(2*Z(371)+Z(85)*Z(291)+2*Z(339)*Z(26)+2*Z(369)*Z(5)+2*
     &Z(373)*Z(9)+2*Z(379)*Z(247)+2*Z(380)*Z(263)-2*Z(83)*Z(287)-2*Z(84)
     &*Z(323)-2*Z(82)*Z(29)-Z(86)*Z(342))
      Z(425) = MF*(2*Z(373)+Z(85)*Z(299)+2*Z(339)*Z(231)+2*Z(369)*Z(235)
     &+2*Z(371)*Z(9)+2*Z(379)*Z(251)+2*Z(380)*Z(267)-2*Z(83)*Z(295)-2*Z(
     &84)*Z(327)-2*Z(82)*Z(11)-Z(86)*Z(345))
      Z(311) = -Z(15)*Z(307) - Z(16)*Z(309)
      Z(381) = Z(17)*Z(19) - Z(18)*Z(20)
      Z(118) = Z(1)*Z(58) + Z(2)*Z(59)
      Z(427) = MF*(2*Z(380)+2*Z(83)*Z(17)+Z(85)*Z(311)+2*Z(339)*Z(255)+2
     &*Z(369)*Z(259)+2*Z(371)*Z(263)+2*Z(373)*Z(267)-2*Z(84)*Z(381)-2*Z(
     &379)*Z(15)-2*Z(82)*Z(118)-Z(86)*Z(353))
      Z(105) = Z(1)*Z(36) + Z(2)*Z(37)
      Z(430) = MG*(Z(86)*Z(40)+2*Z(79)*Z(239)+2*Z(80)*Z(255)+2*Z(83)*Z(2
     &71)+2*Z(84)*Z(315)-2*Z(339)-2*Z(369)*Z(3)-2*Z(371)*Z(26)-2*Z(373)*
     &Z(231)-2*Z(384)*Z(105)-Z(85)*Z(275))
      Z(439) = MH*(2*Z(369)+2*Z(339)*Z(3)+2*Z(371)*Z(5)+2*Z(373)*Z(235)+
     &2*Z(379)*Z(243)+2*Z(385)*Z(259)+2*Z(386)*Z(279)+2*Z(387)*Z(283)-Z(
     &404)-2*Z(84)*Z(319)-2*Z(82)*Z(110))
      Z(440) = MH*(2*Z(371)+2*Z(339)*Z(26)+2*Z(369)*Z(5)+2*Z(373)*Z(9)+2
     &*Z(379)*Z(247)+2*Z(385)*Z(263)+2*Z(386)*Z(287)+2*Z(387)*Z(291)-2*Z
     &(84)*Z(323)-2*Z(82)*Z(29)-Z(86)*Z(342))
      Z(441) = MH*(2*Z(373)+2*Z(339)*Z(231)+2*Z(369)*Z(235)+2*Z(371)*Z(9
     &)+2*Z(379)*Z(251)+2*Z(385)*Z(267)+2*Z(386)*Z(295)+2*Z(387)*Z(299)-
     &2*Z(84)*Z(327)-2*Z(82)*Z(11)-Z(86)*Z(345))
      Z(443) = MH*(2*Z(385)+2*Z(339)*Z(255)+2*Z(369)*Z(259)+2*Z(371)*Z(2
     &63)+2*Z(373)*Z(267)+2*Z(387)*Z(311)-2*Z(84)*Z(381)-2*Z(379)*Z(15)-
     &2*Z(386)*Z(17)-2*Z(82)*Z(118)-Z(86)*Z(353))
      Z(303) = Z(13)*Z(124) - Z(14)*Z(126)
      Z(445) = MH*(Z(444)+2*Z(84)*Z(19)+2*Z(339)*Z(271)+2*Z(369)*Z(279)+
     &2*Z(371)*Z(287)+2*Z(373)*Z(295)+2*Z(379)*Z(303)-2*Z(385)*Z(17)-2*Z
     &(82)*Z(124)-Z(86)*Z(357))
      Z(388) = -Z(7)*Z(19) - Z(8)*Z(20)
      Z(449) = MH*(Z(448)+2*Z(339)*Z(275)+2*Z(369)*Z(283)+2*Z(371)*Z(291
     &)+2*Z(373)*Z(299)+2*Z(379)*Z(307)+2*Z(385)*Z(311)-2*Z(84)*Z(388)-2
     &*Z(82)*Z(142)-Z(86)*Z(365))
      Z(450) = MI*(Z(86)*Z(40)+2*Z(79)*Z(239)+2*Z(80)*Z(255)+2*Z(83)*Z(2
     &71)-2*Z(339)-2*Z(369)*Z(3)-2*Z(371)*Z(26)-2*Z(373)*Z(231)-2*Z(392)
     &*Z(315)-2*Z(391)*Z(105)-Z(85)*Z(275))
      Z(331) = INE*EAp
      Z(120) = Z(1)*Z(59) - Z(2)*Z(58)
      Z(435) = MG*GSp*(2*Z(79)*Z(14)+Z(85)*Z(144)+2*Z(339)*Z(107)+2*Z(36
     &9)*Z(112)+2*Z(371)*Z(30)-2*Z(80)*Z(120)-2*Z(83)*Z(126)-2*Z(84)*Z(1
     &32)-2*Z(373)*Z(12)-Z(86)*Z(136))
      Z(395) = MA*(Z(85)*Z(67)+2*Z(338)*Z(37)-2*Z(77)*Z(33)-2*Z(78)*Z(52
     &)-2*Z(79)*Z(56)-2*Z(80)*Z(59)-2*Z(83)*Z(63)-2*Z(84)*Z(71)-2*Z(82)*
     &Z(2)-Z(76)*Z(48)-Z(86)*Z(44))
      Z(399) = MB*(Z(85)*Z(67)+2*Z(339)*Z(37)+2*Z(340)*Z(48)+2*Z(341)*Z(
     &44)-2*Z(77)*Z(33)-2*Z(78)*Z(52)-2*Z(79)*Z(56)-2*Z(80)*Z(59)-2*Z(83
     &)*Z(63)-2*Z(84)*Z(71)-2*Z(82)*Z(2))
      Z(407) = MC*(Z(85)*Z(67)+2*Z(339)*Z(37)+2*Z(369)*Z(48)+2*Z(370)*Z(
     &33)-2*Z(78)*Z(52)-2*Z(79)*Z(56)-2*Z(80)*Z(59)-2*Z(83)*Z(63)-2*Z(84
     &)*Z(71)-2*Z(82)*Z(2)-Z(86)*Z(44))
      Z(413) = MD*(Z(85)*Z(67)+2*Z(339)*Z(37)+2*Z(369)*Z(48)+2*Z(371)*Z(
     &33)+2*Z(372)*Z(52)-2*Z(79)*Z(56)-2*Z(80)*Z(59)-2*Z(83)*Z(63)-2*Z(8
     &4)*Z(71)-2*Z(82)*Z(2)-Z(86)*Z(44))
      Z(420) = ME*(Z(85)*Z(67)+2*Z(339)*Z(37)+2*Z(369)*Z(48)+2*Z(371)*Z(
     &33)+2*Z(373)*Z(52)+2*Z(374)*Z(56)-2*Z(80)*Z(59)-2*Z(83)*Z(63)-2*Z(
     &84)*Z(71)-2*Z(82)*Z(2)-Z(86)*Z(44))
      Z(428) = MF*(Z(85)*Z(67)+2*Z(339)*Z(37)+2*Z(369)*Z(48)+2*Z(371)*Z(
     &33)+2*Z(373)*Z(52)+2*Z(379)*Z(56)+2*Z(380)*Z(59)-2*Z(83)*Z(63)-2*Z
     &(84)*Z(71)-2*Z(82)*Z(2)-Z(86)*Z(44))
      Z(436) = MG*(Z(86)*Z(43)+2*Z(79)*Z(55)+2*Z(80)*Z(58)+2*Z(83)*Z(62)
     &+2*Z(84)*Z(70)-2*Z(339)*Z(36)-2*Z(369)*Z(47)-2*Z(371)*Z(32)-2*Z(37
     &3)*Z(51)-2*Z(384)*Z(1)-Z(85)*Z(66))
      Z(447) = MH*(2*Z(339)*Z(37)+2*Z(369)*Z(48)+2*Z(371)*Z(33)+2*Z(373)
     &*Z(52)+2*Z(379)*Z(56)+2*Z(385)*Z(59)+2*Z(386)*Z(63)+2*Z(387)*Z(67)
     &-2*Z(84)*Z(71)-2*Z(82)*Z(2)-Z(86)*Z(44))
      Z(456) = MI*(Z(86)*Z(43)+2*Z(79)*Z(55)+2*Z(80)*Z(58)+2*Z(83)*Z(62)
     &-2*Z(339)*Z(36)-2*Z(369)*Z(47)-2*Z(371)*Z(32)-2*Z(373)*Z(51)-2*Z(3
     &92)*Z(70)-2*Z(391)*Z(1)-Z(85)*Z(66))
      Z(393) = MA*(2*Z(338)+Z(85)*Z(275)-2*Z(77)*Z(26)-2*Z(78)*Z(231)-2*
     &Z(79)*Z(239)-2*Z(80)*Z(255)-2*Z(83)*Z(271)-2*Z(84)*Z(315)-2*Z(82)*
     &Z(105)-Z(76)*Z(3)-Z(86)*Z(40))
      Z(396) = MB*(2*Z(339)+Z(85)*Z(275)+2*Z(340)*Z(3)+2*Z(341)*Z(40)-2*
     &Z(77)*Z(26)-2*Z(78)*Z(231)-2*Z(79)*Z(239)-2*Z(80)*Z(255)-2*Z(83)*Z
     &(271)-2*Z(84)*Z(315)-2*Z(82)*Z(105))
      Z(403) = MC*(2*Z(339)+Z(85)*Z(275)+2*Z(369)*Z(3)+2*Z(370)*Z(26)-2*
     &Z(78)*Z(231)-2*Z(79)*Z(239)-2*Z(80)*Z(255)-2*Z(83)*Z(271)-2*Z(84)*
     &Z(315)-2*Z(82)*Z(105)-Z(86)*Z(40))
      Z(409) = MD*(2*Z(339)+Z(85)*Z(275)+2*Z(369)*Z(3)+2*Z(371)*Z(26)+2*
     &Z(372)*Z(231)-2*Z(79)*Z(239)-2*Z(80)*Z(255)-2*Z(83)*Z(271)-2*Z(84)
     &*Z(315)-2*Z(82)*Z(105)-Z(86)*Z(40))
      Z(415) = ME*(2*Z(339)+Z(85)*Z(275)+2*Z(369)*Z(3)+2*Z(371)*Z(26)+2*
     &Z(373)*Z(231)+2*Z(374)*Z(239)-2*Z(80)*Z(255)-2*Z(83)*Z(271)-2*Z(84
     &)*Z(315)-2*Z(82)*Z(105)-Z(86)*Z(40))
      Z(375) = Z(20)*Z(304) - Z(19)*Z(303)
      Z(419) = ME*(2*Z(13)*Z(82)+Z(86)*Z(349)+2*Z(83)*Z(303)+2*Z(84)*Z(3
     &75)-2*Z(374)-2*Z(80)*Z(15)-2*Z(339)*Z(239)-2*Z(369)*Z(243)-2*Z(371
     &)*Z(247)-2*Z(373)*Z(251)-Z(85)*Z(307))
      Z(422) = MF*(2*Z(339)+Z(85)*Z(275)+2*Z(369)*Z(3)+2*Z(371)*Z(26)+2*
     &Z(373)*Z(231)+2*Z(379)*Z(239)+2*Z(380)*Z(255)-2*Z(83)*Z(271)-2*Z(8
     &4)*Z(315)-2*Z(82)*Z(105)-Z(86)*Z(40))
      Z(426) = MF*(2*Z(380)*Z(15)+2*Z(13)*Z(82)+Z(86)*Z(349)+2*Z(83)*Z(3
     &03)+2*Z(84)*Z(375)-2*Z(379)-2*Z(339)*Z(239)-2*Z(369)*Z(243)-2*Z(37
     &1)*Z(247)-2*Z(373)*Z(251)-Z(85)*Z(307))
      Z(431) = MG*(Z(404)+2*Z(79)*Z(243)+2*Z(80)*Z(259)+2*Z(83)*Z(279)+2
     &*Z(84)*Z(319)-2*Z(369)-2*Z(339)*Z(3)-2*Z(371)*Z(5)-2*Z(373)*Z(235)
     &-2*Z(384)*Z(110)-Z(85)*Z(283))
      Z(432) = MG*(Z(86)*Z(342)+2*Z(79)*Z(247)+2*Z(80)*Z(263)+2*Z(83)*Z(
     &287)+2*Z(84)*Z(323)-2*Z(371)-2*Z(339)*Z(26)-2*Z(369)*Z(5)-2*Z(373)
     &*Z(9)-2*Z(384)*Z(29)-Z(85)*Z(291))
      Z(433) = MG*(Z(86)*Z(345)+2*Z(79)*Z(251)+2*Z(80)*Z(267)+2*Z(83)*Z(
     &295)+2*Z(84)*Z(327)-2*Z(373)-2*Z(339)*Z(231)-2*Z(369)*Z(235)-2*Z(3
     &71)*Z(9)-2*Z(384)*Z(11)-Z(85)*Z(299))
      Z(130) = Z(1)*Z(70) + Z(2)*Z(71)
      Z(434) = MG*(2*Z(79)*Z(13)+Z(86)*Z(134)+2*Z(80)*Z(118)+2*Z(83)*Z(1
     &24)+2*Z(84)*Z(130)-2*Z(384)-2*Z(339)*Z(105)-2*Z(369)*Z(110)-2*Z(37
     &1)*Z(29)-2*Z(373)*Z(11)-Z(85)*Z(142))
      Z(438) = MH*(2*Z(339)+2*Z(369)*Z(3)+2*Z(371)*Z(26)+2*Z(373)*Z(231)
     &+2*Z(379)*Z(239)+2*Z(385)*Z(255)+2*Z(386)*Z(271)+2*Z(387)*Z(275)-2
     &*Z(84)*Z(315)-2*Z(82)*Z(105)-Z(86)*Z(40))
      Z(442) = MH*(2*Z(385)*Z(15)+2*Z(13)*Z(82)+Z(86)*Z(349)+2*Z(84)*Z(3
     &75)-2*Z(379)-2*Z(339)*Z(239)-2*Z(369)*Z(243)-2*Z(371)*Z(247)-2*Z(3
     &73)*Z(251)-2*Z(386)*Z(303)-2*Z(387)*Z(307))
      Z(451) = MI*(Z(404)+2*Z(79)*Z(243)+2*Z(80)*Z(259)+2*Z(83)*Z(279)-2
     &*Z(369)-2*Z(339)*Z(3)-2*Z(371)*Z(5)-2*Z(373)*Z(235)-2*Z(392)*Z(319
     &)-2*Z(391)*Z(110)-Z(85)*Z(283))
      Z(452) = MI*(Z(86)*Z(342)+2*Z(79)*Z(247)+2*Z(80)*Z(263)+2*Z(83)*Z(
     &287)-2*Z(371)-2*Z(339)*Z(26)-2*Z(369)*Z(5)-2*Z(373)*Z(9)-2*Z(392)*
     &Z(323)-2*Z(391)*Z(29)-Z(85)*Z(291))
      Z(453) = MI*(Z(86)*Z(345)+2*Z(79)*Z(251)+2*Z(80)*Z(267)+2*Z(83)*Z(
     &295)-2*Z(373)-2*Z(339)*Z(231)-2*Z(369)*Z(235)-2*Z(371)*Z(9)-2*Z(39
     &2)*Z(327)-2*Z(391)*Z(11)-Z(85)*Z(299))
      Z(454) = MI*(2*Z(79)*Z(13)+Z(86)*Z(134)+2*Z(80)*Z(118)+2*Z(83)*Z(1
     &24)-2*Z(391)-2*Z(339)*Z(105)-2*Z(369)*Z(110)-2*Z(371)*Z(29)-2*Z(37
     &3)*Z(11)-2*Z(392)*Z(130)-Z(85)*Z(142))
      Z(455) = MI*(2*Z(80)*Z(381)+Z(86)*Z(361)+2*Z(79)*Z(375)-2*Z(392)-2
     &*Z(83)*Z(19)-Z(85)*Z(388)-2*Z(339)*Z(315)-2*Z(369)*Z(319)-2*Z(371)
     &*Z(323)-2*Z(373)*Z(327)-2*Z(391)*Z(130))
      HZ = Z(333) + Z(335) + Z(337) + INA*U3 + INB*U3 + INC*U3 + IND*U3 
     &+ INE*U3 + INE*U8 + INF*U3 + INF*U8 + INF*U9 + ING*U3 + INH*U10 + 
     &INH*U3 + INH*U8 + INH*U9 + INI*U11 + INI*U3 + INI*U8 + INI*U9 + 0.
     &5D0*Z(394)*U2 + 0.5D0*Z(400)*U2 + 0.5D0*Z(408)*U2 + 0.5D0*Z(414)*U
     &2 + 0.5D0*Z(421)*U2 + 0.5D0*Z(429)*U2 + 0.5D0*Z(437)*U1 + 0.5D0*Z(
     &446)*U2 + 0.5D0*Z(457)*U1 + 0.25D0*Z(398)*Z(166) + 0.25D0*Z(402)*Z
     &(167) + 0.5D0*Z(405)*Z(172) + 0.5D0*Z(406)*Z(174) + 0.5D0*Z(410)*Z
     &(172) + 0.5D0*Z(411)*Z(176) + 0.5D0*Z(412)*Z(178) + 0.5D0*Z(416)*Z
     &(172) + 0.5D0*Z(417)*Z(176) + 0.5D0*Z(418)*Z(180) + 0.5D0*Z(423)*Z
     &(172) + 0.5D0*Z(424)*Z(176) + 0.5D0*Z(425)*Z(180) + 0.5D0*Z(427)*Z
     &(188) + 0.5D0*Z(430)*Z(164) + 0.5D0*Z(439)*Z(172) + 0.5D0*Z(440)*Z
     &(176) + 0.5D0*Z(441)*Z(180) + 0.5D0*Z(443)*Z(192) + 0.5D0*Z(445)*Z
     &(201) + 0.5D0*Z(449)*Z(202) + 0.5D0*Z(450)*Z(164) - Z(331) - 0.5D0
     &*Z(435) - IND*U7 - 0.5D0*Z(395)*U1 - 0.5D0*Z(399)*U1 - 0.5D0*Z(407
     &)*U1 - 0.5D0*Z(413)*U1 - 0.5D0*Z(420)*U1 - 0.5D0*Z(428)*U1 - 0.5D0
     &*Z(436)*U2 - 0.5D0*Z(447)*U1 - 0.5D0*Z(456)*U2 - INC*(U6+U7) - INB
     &*(U5+U6+U7) - INA*(U4+U5+U6+U7) - 0.5D0*Z(393)*Z(162) - 0.5D0*Z(39
     &6)*Z(164) - 0.5D0*Z(403)*Z(164) - 0.5D0*Z(409)*Z(164) - 0.5D0*Z(41
     &5)*Z(164) - 0.5D0*Z(419)*Z(182) - 0.5D0*Z(422)*Z(164) - 0.5D0*Z(42
     &6)*Z(185) - 0.5D0*Z(431)*Z(172) - 0.5D0*Z(432)*Z(176) - 0.5D0*Z(43
     &3)*Z(180) - 0.5D0*Z(434)*Z(195) - 0.5D0*Z(438)*Z(164) - 0.5D0*Z(44
     &2)*Z(185) - 0.5D0*Z(451)*Z(172) - 0.5D0*Z(452)*Z(176) - 0.5D0*Z(45
     &3)*Z(180) - 0.5D0*Z(454)*Z(199) - 0.5D0*Z(455)*Z(211)
      Z(486) = MG*GSp
      Z(495) = MH*Z(146)
      Z(503) = MI*Z(149)
      Z(487) = MG*GS
      Z(497) = MH*Z(147)
      Z(481) = MF*Z(140)
      Z(493) = MH*Z(141)
      Z(474) = ME*Z(138)
      Z(479) = MF*Z(139)
      Z(492) = MH*Z(139)
      PX = Z(486)*Z(1) + (MA+MB+MC+MD+ME+MF+MG+MH+MI)*U1 + 0.5D0*Z(461)*
     &Z(45)*(U3-U5-U6-U7) + Z(64)*(Z(495)+Z(494)*U10+Z(494)*U3+Z(494)*U8
     &+Z(494)*U9) + Z(72)*(Z(503)+Z(502)*U11+Z(502)*U3+Z(502)*U8+Z(502)*
     &U9) + (Z(468)+Z(472)+Z(478)+Z(485)+Z(491)+Z(501))*Z(53)*(U3-U7) + 
     &(Z(464)+Z(467)+Z(471)+Z(477)+Z(484)+Z(490)+Z(500))*Z(34)*(U3-U6-U7
     &) + 0.5D0*(Z(460)+2*Z(463)+2*Z(466)+2*Z(470)+2*Z(476)+2*Z(483)+2*Z
     &(489)+2*Z(499))*Z(49)*(U3-U5-U6-U7) - (Z(81)+Z(487))*Z(2)*U3 - 0.5
     &D0*Z(68)*(Z(497)+Z(496)*U10+Z(496)*U3+Z(496)*U8+Z(496)*U9) - (Z(45
     &8)+Z(459)+Z(462)+Z(465)+Z(469)+Z(475)+Z(482)+Z(488)+Z(498))*Z(38)*
     &(U3-U4-U5-U6-U7) - Z(60)*(Z(481)+Z(493)-Z(480)*U3-Z(480)*U8-Z(480)
     &*U9-Z(490)*U3-Z(490)*U8-Z(490)*U9) - Z(57)*(Z(474)+Z(479)+Z(492)-Z
     &(473)*U3-Z(473)*U8-Z(478)*U3-Z(478)*U8-Z(491)*U3-Z(491)*U8)
      PY = Z(486)*Z(2) + (Z(81)+Z(487))*Z(1)*U3 + (MA+MB+MC+MD+ME+MF+MG+
     &MH+MI)*U2 + 0.5D0*Z(461)*Z(46)*(U3-U5-U6-U7) + Z(65)*(Z(495)+Z(494
     &)*U10+Z(494)*U3+Z(494)*U8+Z(494)*U9) + Z(73)*(Z(503)+Z(502)*U11+Z(
     &502)*U3+Z(502)*U8+Z(502)*U9) + (Z(468)+Z(472)+Z(478)+Z(485)+Z(491)
     &+Z(501))*Z(54)*(U3-U7) + (Z(464)+Z(467)+Z(471)+Z(477)+Z(484)+Z(490
     &)+Z(500))*Z(35)*(U3-U6-U7) + 0.5D0*(Z(460)+2*Z(463)+2*Z(466)+2*Z(4
     &70)+2*Z(476)+2*Z(483)+2*Z(489)+2*Z(499))*Z(50)*(U3-U5-U6-U7) - 0.5
     &D0*Z(69)*(Z(497)+Z(496)*U10+Z(496)*U3+Z(496)*U8+Z(496)*U9) - (Z(45
     &8)+Z(459)+Z(462)+Z(465)+Z(469)+Z(475)+Z(482)+Z(488)+Z(498))*Z(39)*
     &(U3-U4-U5-U6-U7) - Z(61)*(Z(481)+Z(493)-Z(480)*U3-Z(480)*U8-Z(480)
     &*U9-Z(490)*U3-Z(490)*U8-Z(490)*U9) - Z(55)*(Z(474)+Z(479)+Z(492)-Z
     &(473)*U3-Z(473)*U8-Z(478)*U3-Z(478)*U8-Z(491)*U3-Z(491)*U8)
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
      Z(523) = Z(521)*Z(55) + Z(522)*Z(73) + L2*Z(73)*Z(227) + Z(223)*(L
     &10*Z(55)+Z(22)*Z(61)) - 0.5D0*Z(225)*(L3*Z(69)-2*L10*Z(55)-2*L8*Z(
     &61)-2*Z(24)*Z(65))
      Z(649) = Z(539) + Z(541) + Z(543) + Z(473)*(Z(240)*Z(165)-Z(183)-Z
     &(244)*Z(173)-Z(248)*Z(177)-Z(252)*Z(181)) + Z(502)*(Z(212)+Z(316)*
     &Z(165)-Z(131)*Z(200)-Z(320)*Z(173)-Z(324)*Z(177)-Z(328)*Z(181)) + 
     &MF*(L10*Z(15)*Z(189)+Z(22)*Z(15)*Z(186)+L10*Z(16)*Z(191)+L10*Z(240
     &)*Z(165)+Z(22)*Z(256)*Z(165)-L10*Z(186)-Z(22)*Z(189)-L10*Z(244)*Z(
     &173)-L10*Z(248)*Z(177)-L10*Z(252)*Z(181)-Z(22)*Z(16)*Z(187)-Z(22)*
     &Z(260)*Z(173)-Z(22)*Z(264)*Z(177)-Z(22)*Z(268)*Z(181)) + 0.25D0*MH
     &*(L3*Z(205)+4*Z(24)*Z(203)+4*L10*Z(15)*Z(193)+4*L8*Z(15)*Z(186)+4*
     &Z(24)*Z(17)*Z(193)+2*L3*Z(186)*Z(310)+2*L3*Z(193)*Z(314)+4*L10*Z(2
     &03)*Z(306)+2*Z(616)*Z(206)+4*Z(618)*Z(207)+2*L3*Z(284)*Z(173)+2*L3
     &*Z(292)*Z(177)+2*L3*Z(300)*Z(181)+2*L3*Z(308)*Z(187)+2*L3*Z(312)*Z
     &(194)+4*L10*Z(16)*Z(194)+4*L10*Z(240)*Z(165)+4*L8*Z(256)*Z(165)+4*
     &Z(24)*Z(18)*Z(194)+4*Z(24)*Z(272)*Z(165)-4*L10*Z(186)-4*L8*Z(193)-
     &2*Z(619)*Z(203)-2*Z(620)*Z(205)-4*L8*Z(17)*Z(203)-4*Z(24)*Z(186)*Z
     &(306)-2*L10*Z(205)*Z(310)-2*L8*Z(205)*Z(314)-4*L10*Z(244)*Z(173)-4
     &*L10*Z(248)*Z(177)-4*L10*Z(252)*Z(181)-4*L10*Z(305)*Z(206)-4*L10*Z
     &(309)*Z(207)-4*L8*Z(16)*Z(187)-4*L8*Z(18)*Z(206)-4*L8*Z(260)*Z(173
     &)-4*L8*Z(264)*Z(177)-4*L8*Z(268)*Z(181)-4*L8*Z(313)*Z(207)-4*Z(24)
     &*Z(280)*Z(173)-4*Z(24)*Z(288)*Z(177)-4*Z(24)*Z(296)*Z(181)-4*Z(24)
     &*Z(304)*Z(187)-2*L3*Z(276)*Z(165)) - Z(537)
      Z(683) = Z(523) - Z(649)
      Z(642) = Z(641) - Z(473)*(L2*Z(242)-Z(21)-L10*Z(254)-L6*Z(246)-L8*
     &Z(250)) - Z(502)*(L2*Z(318)-Z(25)-L10*Z(330)-L11*Z(133)-L6*Z(322)-
     &L8*Z(326)) - MF*(2*Z(583)*Z(15)+Z(574)*Z(242)+Z(584)*Z(258)-Z(576)
     &-Z(585)-Z(576)*Z(254)-Z(578)*Z(246)-Z(579)*Z(250)-Z(583)*Z(270)-Z(
     &586)*Z(262)-Z(587)*Z(266)) - 0.25D0*MH*(4*Z(599)+8*Z(579)*Z(15)+8*
     &Z(600)*Z(17)+2*Z(601)*Z(302)+2*Z(602)*Z(286)+2*Z(603)*Z(294)+4*Z(5
     &67)*Z(258)+4*Z(574)*Z(242)+4*Z(601)*Z(310)+4*Z(603)*Z(314)+4*Z(604
     &)*Z(274)-4*Z(569)-4*Z(576)-4*Z(606)-Z(605)-8*Z(607)*Z(306)-4*Z(569
     &)*Z(266)-4*Z(571)*Z(262)-4*Z(576)*Z(254)-4*Z(578)*Z(246)-4*Z(579)*
     &Z(250)-4*Z(579)*Z(270)-4*Z(600)*Z(290)-4*Z(607)*Z(298)-4*Z(608)*Z(
     &282)-2*Z(559)*Z(278))
      Z(643) = Z(473)*Z(55) + Z(502)*Z(73) + MF*(L10*Z(55)+Z(22)*Z(61)) 
     &- 0.5D0*MH*(L3*Z(69)-2*L10*Z(55)-2*L8*Z(61)-2*Z(24)*Z(65))
      Z(644) = Z(473)*Z(57) + Z(502)*Z(72) + MF*(L10*Z(57)+Z(22)*Z(60)) 
     &- 0.5D0*MH*(L3*Z(68)-2*L10*Z(57)-2*L8*Z(60)-2*Z(24)*Z(64))
      Z(645) = Z(473)*(L2*Z(242)-L10*Z(254)-L6*Z(246)-L8*Z(250)) + Z(502
     &)*(L2*Z(318)-L10*Z(330)-L6*Z(322)-L8*Z(326)) + MF*(Z(574)*Z(242)+Z
     &(584)*Z(258)-Z(576)*Z(254)-Z(578)*Z(246)-Z(579)*Z(250)-Z(583)*Z(27
     &0)-Z(586)*Z(262)-Z(587)*Z(266)) + 0.5D0*MH*(Z(601)*Z(302)+Z(602)*Z
     &(286)+Z(603)*Z(294)+2*Z(567)*Z(258)+2*Z(574)*Z(242)+2*Z(604)*Z(274
     &)-2*Z(569)*Z(266)-2*Z(571)*Z(262)-2*Z(576)*Z(254)-2*Z(578)*Z(246)-
     &2*Z(579)*Z(250)-2*Z(579)*Z(270)-2*Z(600)*Z(290)-2*Z(607)*Z(298)-2*
     &Z(608)*Z(282)-Z(559)*Z(278))
      Z(646) = Z(473)*(L2*Z(242)-L6*Z(246)-L8*Z(250)) + Z(502)*(L2*Z(318
     &)-L6*Z(322)-L8*Z(326)) + MF*(Z(574)*Z(242)+Z(584)*Z(258)-Z(578)*Z(
     &246)-Z(579)*Z(250)-Z(586)*Z(262)-Z(587)*Z(266)) + 0.5D0*MH*(Z(602)
     &*Z(286)+Z(603)*Z(294)+2*Z(567)*Z(258)+2*Z(574)*Z(242)+2*Z(604)*Z(2
     &74)-2*Z(569)*Z(266)-2*Z(571)*Z(262)-2*Z(578)*Z(246)-2*Z(579)*Z(250
     &)-2*Z(600)*Z(290)-2*Z(608)*Z(282)-Z(559)*Z(278))
      Z(647) = Z(473)*(L2*Z(242)-L6*Z(246)) + Z(502)*(L2*Z(318)-L6*Z(322
     &)) + MF*(Z(574)*Z(242)+Z(584)*Z(258)-Z(578)*Z(246)-Z(586)*Z(262)) 
     &+ 0.5D0*MH*(Z(602)*Z(286)+2*Z(567)*Z(258)+2*Z(574)*Z(242)+2*Z(604)
     &*Z(274)-2*Z(571)*Z(262)-2*Z(578)*Z(246)-2*Z(608)*Z(282)-Z(559)*Z(2
     &78))
      Z(648) = L2*(2*Z(473)*Z(242)+2*Z(502)*Z(318)+2*MF*(L10*Z(242)+Z(22
     &)*Z(258))-MH*(L3*Z(278)-2*L10*Z(242)-2*L8*Z(258)-2*Z(24)*Z(274)))
      SHTOR = Z(683) - Z(642)*U3p - Z(643)*U2p - Z(644)*U1p - Z(645)*U7p
     & - Z(646)*U6p - Z(647)*U5p - 0.5D0*Z(648)*U4p
      Z(651) = Z(650) - Z(480)*(L10*Z(15)+L2*Z(258)-Z(22)-L10*Z(270)-L6*
     &Z(262)-L8*Z(266)) - Z(502)*(L2*Z(318)-Z(25)-L10*Z(330)-L11*Z(133)-
     &L6*Z(322)-L8*Z(326)) - 0.25D0*MH*(4*Z(599)+4*Z(579)*Z(15)+8*Z(600)
     &*Z(17)+2*Z(601)*Z(302)+2*Z(601)*Z(310)+2*Z(602)*Z(286)+2*Z(603)*Z(
     &294)+4*Z(567)*Z(258)+4*Z(603)*Z(314)+4*Z(604)*Z(274)-4*Z(569)-4*Z(
     &606)-Z(605)-4*Z(569)*Z(266)-4*Z(571)*Z(262)-4*Z(579)*Z(270)-4*Z(60
     &0)*Z(290)-4*Z(607)*Z(298)-4*Z(607)*Z(306)-4*Z(608)*Z(282)-2*Z(559)
     &*Z(278))
      Z(652) = Z(480)*Z(60) + Z(502)*Z(72) - 0.5D0*MH*(L3*Z(68)-2*L8*Z(6
     &0)-2*Z(24)*Z(64))
      Z(653) = Z(480)*Z(61) + Z(502)*Z(73) - 0.5D0*MH*(L3*Z(69)-2*L8*Z(6
     &1)-2*Z(24)*Z(65))
      Z(654) = Z(480)*(L2*Z(258)-L10*Z(270)-L6*Z(262)-L8*Z(266)) + Z(502
     &)*(L2*Z(318)-L10*Z(330)-L6*Z(322)-L8*Z(326)) + 0.5D0*MH*(Z(601)*Z(
     &302)+Z(602)*Z(286)+Z(603)*Z(294)+2*Z(567)*Z(258)+2*Z(604)*Z(274)-2
     &*Z(569)*Z(266)-2*Z(571)*Z(262)-2*Z(579)*Z(270)-2*Z(600)*Z(290)-2*Z
     &(607)*Z(298)-2*Z(608)*Z(282)-Z(559)*Z(278))
      Z(655) = Z(480)*(L2*Z(258)-L6*Z(262)-L8*Z(266)) + Z(502)*(L2*Z(318
     &)-L6*Z(322)-L8*Z(326)) + 0.5D0*MH*(Z(602)*Z(286)+Z(603)*Z(294)+2*Z
     &(567)*Z(258)+2*Z(604)*Z(274)-2*Z(569)*Z(266)-2*Z(571)*Z(262)-2*Z(6
     &00)*Z(290)-2*Z(608)*Z(282)-Z(559)*Z(278))
      Z(656) = Z(480)*(L2*Z(258)-L6*Z(262)) + Z(502)*(L2*Z(318)-L6*Z(322
     &)) + 0.5D0*MH*(Z(602)*Z(286)+2*Z(567)*Z(258)+2*Z(604)*Z(274)-2*Z(5
     &71)*Z(262)-2*Z(608)*Z(282)-Z(559)*Z(278))
      Z(657) = L2*(2*Z(480)*Z(258)+2*Z(502)*Z(318)-MH*(L3*Z(278)-2*L8*Z(
     &258)-2*Z(24)*Z(274)))
      Z(525) = Z(522)*Z(73) + Z(524)*Z(61) + L2*Z(73)*Z(227) - 0.5D0*Z(2
     &25)*(L3*Z(69)-2*L8*Z(61)-2*Z(24)*Z(65))
      Z(658) = Z(539) + Z(541) + Z(543) + Z(502)*(Z(212)+Z(316)*Z(165)-Z
     &(131)*Z(200)-Z(320)*Z(173)-Z(324)*Z(177)-Z(328)*Z(181)) + Z(480)*(
     &Z(15)*Z(186)+Z(256)*Z(165)-Z(189)-Z(16)*Z(187)-Z(260)*Z(173)-Z(264
     &)*Z(177)-Z(268)*Z(181)) + 0.25D0*MH*(L3*Z(205)+4*Z(24)*Z(203)+4*L8
     &*Z(15)*Z(186)+4*Z(24)*Z(17)*Z(193)+2*L3*Z(186)*Z(310)+2*L3*Z(193)*
     &Z(314)+2*Z(616)*Z(206)+4*Z(618)*Z(207)+2*L3*Z(284)*Z(173)+2*L3*Z(2
     &92)*Z(177)+2*L3*Z(300)*Z(181)+2*L3*Z(308)*Z(187)+2*L3*Z(312)*Z(194
     &)+4*L8*Z(256)*Z(165)+4*Z(24)*Z(18)*Z(194)+4*Z(24)*Z(272)*Z(165)-4*
     &L8*Z(193)-2*Z(619)*Z(203)-2*Z(620)*Z(205)-4*L8*Z(17)*Z(203)-4*Z(24
     &)*Z(186)*Z(306)-2*L8*Z(205)*Z(314)-4*L8*Z(16)*Z(187)-4*L8*Z(18)*Z(
     &206)-4*L8*Z(260)*Z(173)-4*L8*Z(264)*Z(177)-4*L8*Z(268)*Z(181)-4*L8
     &*Z(313)*Z(207)-4*Z(24)*Z(280)*Z(173)-4*Z(24)*Z(288)*Z(177)-4*Z(24)
     &*Z(296)*Z(181)-4*Z(24)*Z(304)*Z(187)-2*L3*Z(276)*Z(165))
      Z(684) = Z(525) - Z(658)
      SKTOR = Z(651)*U3p + Z(652)*U1p + Z(653)*U2p + Z(654)*U7p + Z(655)
     &*U6p + Z(656)*U5p + 0.5D0*Z(657)*U4p - Z(684)
      Z(526) = Z(225)*(L3*Z(69)-2*Z(24)*Z(65))
      Z(666) = Z(541) + 0.25D0*MH*(L3*Z(205)+4*Z(24)*Z(203)+4*Z(24)*Z(17
     &)*Z(193)+2*L3*Z(186)*Z(310)+2*L3*Z(193)*Z(314)+2*Z(616)*Z(206)+4*Z
     &(618)*Z(207)+2*L3*Z(284)*Z(173)+2*L3*Z(292)*Z(177)+2*L3*Z(300)*Z(1
     &81)+2*L3*Z(308)*Z(187)+2*L3*Z(312)*Z(194)+4*Z(24)*Z(18)*Z(194)+4*Z
     &(24)*Z(272)*Z(165)-2*Z(619)*Z(203)-2*Z(620)*Z(205)-4*Z(24)*Z(186)*
     &Z(306)-4*Z(24)*Z(280)*Z(173)-4*Z(24)*Z(288)*Z(177)-4*Z(24)*Z(296)*
     &Z(181)-4*Z(24)*Z(304)*Z(187)-2*L3*Z(276)*Z(165))
      Z(685) = -0.5D0*Z(526) - Z(666)
      Z(527) = Z(73)*(Z(522)+L2*Z(227))
      Z(675) = Z(543) + Z(502)*(Z(212)+Z(316)*Z(165)-Z(131)*Z(200)-Z(320
     &)*Z(173)-Z(324)*Z(177)-Z(328)*Z(181))
      Z(686) = Z(527) - Z(675)
      Z(694) = -Z(685) - Z(686)
      Z(668) = Z(502)*Z(72)
      Z(660) = MH*(L3*Z(68)-2*Z(24)*Z(64))
      Z(687) = Z(668) - 0.5D0*Z(660)
      Z(669) = Z(502)*Z(73)
      Z(661) = MH*(L3*Z(69)-2*Z(24)*Z(65))
      Z(688) = Z(669) - 0.5D0*Z(661)
      Z(674) = Z(673)*Z(318)
      Z(665) = Z(488)*(L3*Z(278)-2*Z(24)*Z(274))
      Z(689) = Z(674) - 0.5D0*Z(665)
      Z(659) = INH - 0.25D0*MH*(4*Z(599)+4*Z(600)*Z(17)+2*Z(601)*Z(302)+
     &2*Z(601)*Z(310)+2*Z(602)*Z(286)+2*Z(603)*Z(294)+2*Z(603)*Z(314)+4*
     &Z(604)*Z(274)-4*Z(606)-Z(605)-4*Z(600)*Z(290)-4*Z(607)*Z(298)-4*Z(
     &607)*Z(306)-4*Z(608)*Z(282)-2*Z(559)*Z(278))
      Z(667) = INI - Z(502)*(L2*Z(318)-Z(25)-L10*Z(330)-L11*Z(133)-L6*Z(
     &322)-L8*Z(326))
      Z(690) = Z(659) + Z(667)
      Z(670) = Z(502)*(L2*Z(318)-L10*Z(330)-L6*Z(322)-L8*Z(326))
      Z(662) = MH*(Z(601)*Z(302)+Z(602)*Z(286)+Z(603)*Z(294)+2*Z(604)*Z(
     &274)-2*Z(600)*Z(290)-2*Z(607)*Z(298)-2*Z(608)*Z(282)-Z(559)*Z(278)
     &)
      Z(691) = Z(670) + 0.5D0*Z(662)
      Z(671) = Z(502)*(L2*Z(318)-L6*Z(322)-L8*Z(326))
      Z(663) = MH*(Z(602)*Z(286)+Z(603)*Z(294)+2*Z(604)*Z(274)-2*Z(600)*
     &Z(290)-2*Z(608)*Z(282)-Z(559)*Z(278))
      Z(692) = Z(671) + 0.5D0*Z(663)
      Z(672) = Z(502)*(L2*Z(318)-L6*Z(322))
      Z(664) = MH*(Z(602)*Z(286)+2*Z(604)*Z(274)-2*Z(608)*Z(282)-Z(559)*
     &Z(278))
      Z(693) = Z(672) + 0.5D0*Z(664)
      SATOR = Z(694) + Z(687)*U1p + Z(688)*U2p + Z(689)*U4p + Z(690)*U3p
     & + Z(691)*U7p + Z(692)*U6p + Z(693)*U5p
      SMTOR = Z(667)*U3p + Z(668)*U1p + Z(669)*U2p + Z(670)*U7p + Z(671)
     &*U6p + Z(672)*U5p + Z(674)*U4p - Z(686)
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
      POP9X = Q1 + L10*Z(51) + L11*Z(1) + L6*Z(47) + L8*Z(32) - L2*Z(36)
      POP9Y = Q2 + L10*Z(52) + L11*Z(2) + L6*Z(48) + L8*Z(33) - L2*Z(37)
      POGOX = Q1 + L10*Z(51) + L6*Z(47) + L8*Z(32) + GS*Z(1) - L2*Z(36)
      POGOY = Q2 + L10*Z(52) + L6*Z(48) + L8*Z(33) + GS*Z(2) - L2*Z(37)
      POP10X = Q1 + L10*Z(51) + L11*Z(1) + L6*Z(47) + L8*Z(32) - L2*Z(36
     &) - L5*Z(66)
      POP10Y = Q2 + L10*Z(52) + L11*Z(2) + L6*Z(48) + L8*Z(33) - L2*Z(37
     &) - L5*Z(67)
      POP11X = Q1 + L10*Z(51) + L11*Z(1) + L2*Z(70) + L6*Z(47) + L8*Z(32
     &) - L2*Z(36)
      POP11Y = Q2 + L10*Z(52) + L11*Z(2) + L2*Z(71) + L6*Z(48) + L8*Z(33
     &) - L2*Z(37)
      POCMX = Q1 + Z(77)*Z(32) + Z(78)*Z(51) + Z(79)*Z(55) + Z(80)*Z(58)
     & + Z(83)*Z(62) + Z(84)*Z(70) + Z(82)*Z(1) + 0.5D0*Z(76)*Z(47) + 0.
     &5D0*Z(86)*Z(43) - Z(75)*Z(36) - 0.5D0*Z(85)*Z(66)
      POCMSTANCEX = Q1 + Z(90)*Z(32) + Z(91)*Z(51) + 0.5D0*Z(89)*Z(47) +
     & 0.5D0*Z(92)*Z(43) - Z(88)*Z(36)
      POCMSTANCEY = Q2 + Z(90)*Z(33) + Z(91)*Z(52) + 0.5D0*Z(89)*Z(48) +
     & 0.5D0*Z(92)*Z(44) - Z(88)*Z(37)
      POCMSWINGX = Q1 + Z(95)*Z(47) + Z(96)*Z(32) + Z(97)*Z(51) + Z(98)*
     &Z(55) + Z(99)*Z(58) + Z(100)*Z(1) + Z(101)*Z(62) + Z(102)*Z(70) - 
     &Z(94)*Z(36) - 0.5D0*Z(103)*Z(66)
      POCMSWINGY = Q2 + Z(95)*Z(48) + Z(96)*Z(33) + Z(97)*Z(52) + Z(98)*
     &Z(56) + Z(99)*Z(59) + Z(100)*Z(2) + Z(101)*Z(63) + Z(102)*Z(71) - 
     &Z(94)*Z(37) - 0.5D0*Z(103)*Z(67)
      Z(151) = MG*GSp/Z(74)
      Z(152) = Z(79)*EAp
      Z(153) = Z(80)*(EAp-FAp)
      Z(154) = Z(83)*(FAp-EAp-HAp)
      Z(155) = Z(84)*(FAp-EAp-IAp)
      Z(156) = Z(85)*(FAp-EAp-HAp)
      Z(157) = Z(98)*EAp
      Z(158) = Z(99)*(EAp-FAp)
      Z(159) = Z(101)*(FAp-EAp-HAp)
      Z(160) = Z(102)*(FAp-EAp-IAp)
      Z(161) = Z(103)*(FAp-EAp-HAp)
      VOCMX = Z(151)*Z(1) + U1 + Z(78)*Z(53)*(U3-U7) + Z(77)*Z(34)*(U3-U
     &6-U7) + 0.5D0*Z(76)*Z(49)*(U3-U5-U6-U7) + 0.5D0*Z(86)*Z(45)*(U3-U5
     &-U6-U7) + Z(64)*(Z(154)+Z(83)*U10+Z(83)*U3+Z(83)*U8+Z(83)*U9) + Z(
     &72)*(Z(155)+Z(84)*U11+Z(84)*U3+Z(84)*U8+Z(84)*U9) - Z(82)*Z(2)*U3 
     &- Z(57)*(Z(152)-Z(79)*U3-Z(79)*U8) - 0.5D0*Z(68)*(Z(156)+Z(85)*U10
     &+Z(85)*U3+Z(85)*U8+Z(85)*U9) - Z(75)*Z(38)*(U3-U4-U5-U6-U7) - Z(60
     &)*(Z(153)-Z(80)*U3-Z(80)*U8-Z(80)*U9)
      VOCMY = Z(151)*Z(2) + U2 + Z(82)*Z(1)*U3 + Z(78)*Z(54)*(U3-U7) + Z
     &(77)*Z(35)*(U3-U6-U7) + 0.5D0*Z(76)*Z(50)*(U3-U5-U6-U7) + 0.5D0*Z(
     &86)*Z(46)*(U3-U5-U6-U7) + Z(65)*(Z(154)+Z(83)*U10+Z(83)*U3+Z(83)*U
     &8+Z(83)*U9) + Z(73)*(Z(155)+Z(84)*U11+Z(84)*U3+Z(84)*U8+Z(84)*U9) 
     &- Z(55)*(Z(152)-Z(79)*U3-Z(79)*U8) - 0.5D0*Z(69)*(Z(156)+Z(85)*U10
     &+Z(85)*U3+Z(85)*U8+Z(85)*U9) - Z(75)*Z(39)*(U3-U4-U5-U6-U7) - Z(61
     &)*(Z(153)-Z(80)*U3-Z(80)*U8-Z(80)*U9)
      VOCMSTANCEX = U1 + Z(91)*Z(53)*(U3-U7) + Z(90)*Z(34)*(U3-U6-U7) + 
     &0.5D0*Z(89)*Z(49)*(U3-U5-U6-U7) + 0.5D0*Z(92)*Z(45)*(U3-U5-U6-U7) 
     &- Z(88)*Z(38)*(U3-U4-U5-U6-U7)
      VOCMSTANCEY = U2 + Z(91)*Z(54)*(U3-U7) + Z(90)*Z(35)*(U3-U6-U7) + 
     &0.5D0*Z(89)*Z(50)*(U3-U5-U6-U7) + 0.5D0*Z(92)*Z(46)*(U3-U5-U6-U7) 
     &- Z(88)*Z(39)*(U3-U4-U5-U6-U7)
      VOCMSWINGX = U1 + Z(97)*Z(53)*(U3-U7) + Z(96)*Z(34)*(U3-U6-U7) + Z
     &(95)*Z(49)*(U3-U5-U6-U7) + Z(64)*(Z(159)+Z(101)*U10+Z(101)*U3+Z(10
     &1)*U8+Z(101)*U9) + Z(72)*(Z(160)+Z(102)*U11+Z(102)*U3+Z(102)*U8+Z(
     &102)*U9) - Z(100)*Z(2)*U3 - Z(57)*(Z(157)-Z(98)*U3-Z(98)*U8) - 0.5
     &D0*Z(68)*(Z(161)+Z(103)*U10+Z(103)*U3+Z(103)*U8+Z(103)*U9) - Z(94)
     &*Z(38)*(U3-U4-U5-U6-U7) - Z(60)*(Z(158)-Z(99)*U3-Z(99)*U8-Z(99)*U9
     &)
      VOCMSWINGY = U2 + Z(100)*Z(1)*U3 + Z(97)*Z(54)*(U3-U7) + Z(96)*Z(3
     &5)*(U3-U6-U7) + Z(95)*Z(50)*(U3-U5-U6-U7) + Z(65)*(Z(159)+Z(101)*U
     &10+Z(101)*U3+Z(101)*U8+Z(101)*U9) + Z(73)*(Z(160)+Z(102)*U11+Z(102
     &)*U3+Z(102)*U8+Z(102)*U9) - Z(55)*(Z(157)-Z(98)*U3-Z(98)*U8) - 0.5
     &D0*Z(69)*(Z(161)+Z(103)*U10+Z(103)*U3+Z(103)*U8+Z(103)*U9) - Z(94)
     &*Z(39)*(U3-U4-U5-U6-U7) - Z(61)*(Z(158)-Z(99)*U3-Z(99)*U8-Z(99)*U9
     &)
      SAANG = HA
      SMANG = IA
      SAANGVEL = HAp
      SMANGVEL = IAp
      PSWINGX = (ME+MF)*U1 + (Z(472)+Z(478))*Z(53)*(U3-U7) + (Z(471)+Z(4
     &77))*Z(34)*(U3-U6-U7) + (Z(470)+Z(476))*Z(49)*(U3-U5-U6-U7) - Z(60
     &)*(Z(481)-Z(480)*U3-Z(480)*U8-Z(480)*U9) - (Z(469)+Z(475))*Z(38)*(
     &U3-U4-U5-U6-U7) - Z(57)*(Z(474)+Z(479)-Z(473)*U3-Z(473)*U8-Z(478)*
     &U3-Z(478)*U8)
      PSWINGY = (ME+MF)*U2 + (Z(472)+Z(478))*Z(54)*(U3-U7) + (Z(471)+Z(4
     &77))*Z(35)*(U3-U6-U7) + (Z(470)+Z(476))*Z(50)*(U3-U5-U6-U7) - Z(61
     &)*(Z(481)-Z(480)*U3-Z(480)*U8-Z(480)*U9) - (Z(469)+Z(475))*Z(39)*(
     &U3-U4-U5-U6-U7) - Z(55)*(Z(474)+Z(479)-Z(473)*U3-Z(473)*U8-Z(478)*
     &U3-Z(478)*U8)
      PSTANCEX = (MA+MB+MC+MD)*U1 + Z(468)*Z(53)*(U3-U7) + (Z(464)+Z(467
     &))*Z(34)*(U3-U6-U7) + 0.5D0*Z(461)*Z(45)*(U3-U5-U6-U7) + 0.5D0*(Z(
     &460)+2*Z(463)+2*Z(466))*Z(49)*(U3-U5-U6-U7) - (Z(458)+Z(459)+Z(462
     &)+Z(465))*Z(38)*(U3-U4-U5-U6-U7)
      PSTANCEY = (MA+MB+MC+MD)*U2 + Z(468)*Z(54)*(U3-U7) + (Z(464)+Z(467
     &))*Z(35)*(U3-U6-U7) + 0.5D0*Z(461)*Z(46)*(U3-U5-U6-U7) + 0.5D0*(Z(
     &460)+2*Z(463)+2*Z(466))*Z(50)*(U3-U5-U6-U7) - (Z(458)+Z(459)+Z(462
     &)+Z(465))*Z(39)*(U3-U4-U5-U6-U7)

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


