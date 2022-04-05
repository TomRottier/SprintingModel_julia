C**   The name of this program is 7segsprint.f
C**   Created by AUTOLEV 3.2 on Tue Apr 05 17:29:15 2022

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
     &,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP1X,POP1Y,POP2X,POP2Y,POP3X,
     &POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,
     &POP9X,POP9Y,PSTANCEX,PSTANCEY,PSWINGX,PSWINGY,SAANG,SAANGVEL,SMANG
     &,SMANGVEL,VOCMSTANCEX,VOCMSTANCEY,VOCMSWINGX,VOCMSWINGY,VOCMX,VOCM
     &Y,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(884),COEF(7,7),RHS(7)

C**   Open input and output files
      OPEN(UNIT=20, FILE='7segsprint.in', STATUS='OLD')
      OPEN(UNIT=21, FILE='7segsprint.1',  STATUS='UNKNOWN')
      OPEN(UNIT=22, FILE='7segsprint.2',  STATUS='UNKNOWN')
      OPEN(UNIT=23, FILE='7segsprint.3',  STATUS='UNKNOWN')
      OPEN(UNIT=24, FILE='7segsprint.4',  STATUS='UNKNOWN')
      OPEN(UNIT=25, FILE='7segsprint.5',  STATUS='UNKNOWN')
      OPEN(UNIT=26, FILE='7segsprint.6',  STATUS='UNKNOWN')

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
      Z(394) = G*ME
      Z(749) = Z(21)*Z(394)
      Z(846) = INF + INH + INI
      Z(22) = L8 - L7
      Z(677) = MF*Z(22)
      Z(857) = INH + INI
      Z(26) = L2 - L1
      Z(727) = MI*Z(26)
      Z(7) = COS(FOOTANG)
      Z(8) = SIN(FOOTANG)
      Z(23) = L6 - L4
      Z(24) = 0.5D0*L6 + 0.5D0*Z(23)
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
      Z(390) = G*MA
      Z(391) = G*MB
      Z(392) = G*MC
      Z(393) = G*MD
      Z(395) = G*MF
      Z(396) = G*MG
      Z(397) = G*MH
      Z(398) = G*MI
      Z(438) = Z(76) - L1
      Z(443) = Z(76) - L2
      Z(444) = 0.5D0*L4 - 0.5D0*Z(77)
      Z(445) = 0.5D0*L3 - 0.5D0*Z(86)
      Z(516) = 2*L6 - Z(77)
      Z(517) = L2 - Z(76)
      Z(538) = L8 - Z(78)
      Z(554) = L10 - Z(79)
      Z(562) = L10 - Z(80)
      Z(567) = L6 - 0.5D0*Z(77)
      Z(569) = L8 - Z(81)
      Z(570) = Z(24) - Z(83)
      Z(571) = Z(25) - Z(85)
      Z(578) = L6 - Z(83)
      Z(587) = Z(444) + Z(7)*Z(445)
      Z(589) = Z(445) + Z(7)*Z(444)
      Z(600) = Z(7)*Z(86)
      Z(610) = 2*Z(570) + 2*Z(7)*Z(571)
      Z(612) = 2*Z(571) + 2*Z(7)*Z(570)
      Z(618) = L1*MA
      Z(623) = L2*MB
      Z(626) = L4*MB
      Z(627) = L3*MB
      Z(659) = ME*Z(21)
      Z(687) = L2*MG
      Z(688) = L6*MG
      Z(689) = L8*MG
      Z(690) = L10*MG
      Z(702) = L8*MH
      Z(712) = MH*Z(24)
      Z(714) = MH*Z(25)
      Z(741) = L1*Z(390)
      Z(743) = L2*Z(391)
      Z(744) = L2*Z(396)
      Z(751) = Z(22)*Z(395)
      Z(754) = Z(26)*Z(398)
      Z(787) = INA + INB + INC + IND + INE + INF + ING + INH + INI + MA*
     &L1**2
      Z(788) = L3**2 + L4**2 + 4*L2**2 + 2*L3*L4*Z(7)
      Z(789) = L2*L3
      Z(790) = L2*L4
      Z(791) = Z(24)**2
      Z(792) = Z(25)**2
      Z(793) = Z(7)*Z(24)*Z(25)
      Z(794) = L10*L2
      Z(795) = L2*L6
      Z(796) = L2*L8
      Z(797) = L10**2
      Z(798) = L2**2
      Z(799) = L6**2
      Z(800) = L8**2
      Z(801) = L10*L6
      Z(802) = L10*L8
      Z(803) = L6*L8
      Z(805) = MA*L1**2
      Z(810) = L3*Z(8)
      Z(811) = L4*Z(8)
      Z(812) = Z(7)*Z(24)
      Z(813) = Z(7)*Z(25)
      Z(814) = Z(8)*Z(25)
      Z(815) = Z(8)*Z(24)
      Z(817) = INA + MA*L1**2 + MB*L2**2 + MG*L2**2
      Z(819) = INA + MA*L1**2
      Z(824) = INA + INB + MA*L1**2
      Z(825) = L2**2 + L6**2
      Z(830) = INA + INB + INC + MA*L1**2
      Z(834) = INA + INB + INC + IND + MA*L1**2
      Z(837) = INE + INF + INH + INI
      Z(847) = L8*Z(24)
      Z(848) = L8*Z(25)

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

6021  FORMAT(1X,'FILE: 7segsprint.1 ',//1X,'*** ',99A1,///,8X,'T',12X,'P
     &OP1X',10X,'POP1Y',10X,'POP2X',10X,'POP2Y',10X,'POP3X',10X,'POP3Y',
     &10X,'POP4X',10X,'POP4Y',10X,'POP5X',10X,'POP5Y',10X,'POP6X',10X,'P
     &OP6Y',10X,'POP7X',10X,'POP7Y',10X,'POP8X',10X,'POP8Y',10X,'POP9X',
     &10X,'POP9Y',9X,'POP10X',9X,'POP10Y',9X,'POP11X',9X,'POP11Y',9X,'PO
     &P12X',9X,'POP12Y',/,7X,'(S)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M
     &)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X
     &,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)'
     &,12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',10X,'(UNITS)',8
     &X,'(UNITS)',/)
6022  FORMAT(1X,'FILE: 7segsprint.2 ',//1X,'*** ',99A1,///,8X,'T',12X,'P
     &OGOX',10X,'POGOY',7X,'POCMSTANCEX',4X,'POCMSTANCEY',4X,'POCMSWINGX
     &',5X,'POCMSWINGY',8X,'POCMX',10X,'POCMY',10X,'VOCMX',10X,'VOCMY',8
     &X,'PSTANCEX',7X,'PSTANCEY',8X,'PSWINGX',8X,'PSWINGY',6X,'VOCMSTANC
     &EX',4X,'VOCMSTANCEY',4X,'VOCMSWINGX',5X,'VOCMSWINGY',/,7X,'(S)',12
     &X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)
     &',12X,'(M)',11X,'(M/S)',10X,'(M/S)',9X,'(UNITS)',8X,'(UNITS)',8X,'
     &(UNITS)',8X,'(UNITS)',9X,'(M/S)',10X,'(M/S)',10X,'(M/S)',10X,'(M/S
     &)',/)
6023  FORMAT(1X,'FILE: 7segsprint.3 ',//1X,'*** ',99A1,///,8X,'T',13X,'Q
     &1',13X,'Q2',13X,'Q3',13X,'Q4',13X,'Q5',13X,'Q6',13X,'Q7',13X,'U1',
     &13X,'U2',13X,'U3',13X,'U4',13X,'U5',13X,'U6',13X,'U7',/,7X,'(S)',1
     &2X,'(M)',12X,'(M)',11X,'(DEG)',10X,'(DEG)',10X,'(DEG)',10X,'(DEG)'
     &,10X,'(DEG)',10X,'(M/S)',10X,'(M/S)',9X,'(DEG/S)',8X,'(DEG/S)',8X,
     &'(DEG/S)',8X,'(DEG/S)',8X,'(DEG/S)',/)
6024  FORMAT(1X,'FILE: 7segsprint.4 ',//1X,'*** ',99A1,///,8X,'T',13X,'R
     &X1',12X,'RY1',12X,'RX2',12X,'RY2',11X,'VRX1',11X,'VRY1',11X,'VRX2'
     &,11X,'VRY2',11X,'HTOR',11X,'KTOR',11X,'ATOR',11X,'MTOR',11X,'SHTOR
     &',10X,'SKTOR',10X,'SATOR',10X,'SMTOR',/,7X,'(S)',12X,'(N)',12X,'(N
     &)',12X,'(N)',12X,'(N)',10X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,
     &'(UNITS)',9X,'(N/M)',10X,'(N/M)',10X,'(N/M)',10X,'(N/M)',10X,'(N/M
     &)',10X,'(N/M)',9X,'(UNITS)',8X,'(UNITS)',/)
6025  FORMAT(1X,'FILE: 7segsprint.5 ',//1X,'*** ',99A1,///,8X,'T',13X,'Q
     &3',12X,'HANG',11X,'KANG',11X,'AANG',11X,'MANG',11X,'SHANG',10X,'SK
     &ANG',10X,'SAANG',10X,'SMANG',11X,'U3',11X,'HANGVEL',8X,'KANGVEL',8
     &X,'AANGVEL',8X,'MANGVEL',7X,'SHANGVEL',7X,'SKANGVEL',7X,'SAANGVEL'
     &,7X,'SMANGVEL',/,7X,'(S)',11X,'(DEG)',10X,'(DEG)',10X,'(DEG)',10X,
     &'(DEG)',10X,'(DEG)',10X,'(DEG)',10X,'(DEG)',9X,'(UNITS)',8X,'(UNIT
     &S)',8X,'(DEG/S)',8X,'(DEG/S)',8X,'(DEG/S)',8X,'(DEG/S)',8X,'(DEG/S
     &)',8X,'(DEG/S)',8X,'(DEG/S)',8X,'(UNITS)',8X,'(UNITS)',/)
6026  FORMAT(1X,'FILE: 7segsprint.6 ',//1X,'*** ',99A1,///,8X,'T',12X,'K
     &ECM',11X,'PECM',12X,'TE',13X,'HZ',13X,'PX',13X,'PY',/,7X,'(S)',12X
     &,'(J)',12X,'(J)',12X,'(J)',8X,'(KG.M^2/S)',6X,'(KG.M/S)',7X,'(KG.M
     &/S)',/)
6997  FORMAT(/7X,'Error: Numerical integration failed to converge',/)
6999  FORMAT(//1X,'Input is in the file 7segsprint.in',//1X,'Output is i
     &n the file(s) 7segsprint.i  (i=1, ..., 6)',//1X,'The output quanti
     &ties and associated files are listed in file 7segsprint.dir',/)
7000  FORMAT(//,99A1,///)
7010  FORMAT( 1000(59X,E30.0,/) )
7011  FORMAT( 3(59X,E30.0,/), 1(59X,I30,/), 2(59X,E30.0,/) )
      STOP
7100  WRITE(*,*) 'Premature end of file while reading 7segsprint.in '
7101  WRITE(*,*) 'Error while reading file 7segsprint.in'
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
     &,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP1X,POP1Y,POP2X,POP2Y,POP3X,
     &POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,
     &POP9X,POP9Y,PSTANCEX,PSTANCEY,PSWINGX,PSWINGY,SAANG,SAANGVEL,SMANG
     &,SMANGVEL,VOCMSTANCEX,VOCMSTANCEY,VOCMSWINGX,VOCMSWINGY,VOCMX,VOCM
     &Y,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(884),COEF(7,7),RHS(7)

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
      Z(399) = VRX2 + VRY2
      Z(401) = ATOR + KTOR
      Z(402) = -HTOR - KTOR

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
      Z(33) = Z(1)*Z(30) - Z(2)*Z(31)
      Z(35) = Z(1)*Z(32) - Z(2)*Z(30)
      Z(37) = Z(27)*Z(33) + Z(28)*Z(35)
      Z(29) = Z(3)*Z(6) + Z(4)*Z(5)
      Z(40) = Z(27)*Z(36) + Z(29)*Z(34)
      Z(39) = Z(27)*Z(35) + Z(29)*Z(33)
      VOP2Y = Z(38)*(Z(37)*U1+Z(38)*U2) - Z(40)*(L2*U3-L2*U4-L2*U5-L2*U6
     &-L2*U7-Z(39)*U1-Z(40)*U2)
      RY2 = -K7*POP2Y - K8*ABS(POP2Y)*VOP2Y
      POP2X = Q1 - L2*Z(37)
      DP2X = POP2X - POP2XI
      VOP2X = Z(37)*(Z(37)*U1+Z(38)*U2) - Z(39)*(L2*U3-L2*U4-L2*U5-L2*U6
     &-L2*U7-Z(39)*U1-Z(40)*U2)
      RX2 = -RY2*(K5*DP2X+K6*VOP2X)
      MANG = Q4
      MANGVEL = U4
      MTOR = MTPK*(3.141592653589793D0-MANG) - MTPB*MANGVEL
      Z(41) = Z(7)*Z(3) - Z(8)*Z(4)
      Z(42) = Z(7)*Z(4) + Z(8)*Z(3)
      Z(43) = -Z(7)*Z(4) - Z(8)*Z(3)
      Z(47) = Z(38)*Z(43) + Z(40)*Z(41)
      Z(48) = Z(3)*Z(37) + Z(4)*Z(39)
      Z(49) = Z(3)*Z(38) + Z(4)*Z(40)
      Z(50) = Z(3)*Z(39) - Z(4)*Z(37)
      Z(51) = Z(3)*Z(40) - Z(4)*Z(38)
      Z(52) = Z(9)*Z(33) + Z(10)*Z(35)
      Z(53) = Z(9)*Z(34) + Z(10)*Z(36)
      Z(54) = Z(9)*Z(35) - Z(10)*Z(33)
      Z(55) = Z(9)*Z(36) - Z(10)*Z(34)
      Z(103) = -U4 - U5 - U6 - U7
      Z(105) = Z(1)*Z(39) + Z(2)*Z(40)
      Z(106) = Z(1)*Z(38) - Z(2)*Z(37)
      Z(107) = Z(1)*Z(40) - Z(2)*Z(39)
      Z(108) = -U5 - U6 - U7
      Z(110) = Z(1)*Z(50) + Z(2)*Z(51)
      Z(111) = Z(1)*Z(49) - Z(2)*Z(48)
      Z(112) = Z(1)*Z(51) - Z(2)*Z(50)
      Z(113) = -U6 - U7
      Z(141) = L2*Z(4)
      Z(142) = L2*Z(3)
      Z(143) = Z(142) - L6
      Z(144) = L6 - Z(142)
      Z(145) = Z(5)*Z(48) + Z(6)*Z(50)
      Z(146) = Z(5)*Z(49) + Z(6)*Z(51)
      Z(147) = Z(5)*Z(141) + Z(6)*Z(142)
      Z(148) = Z(5)*Z(141) + Z(6)*Z(143)
      Z(149) = Z(6)*Z(144) - Z(5)*Z(141)
      Z(150) = Z(5)*Z(50) - Z(6)*Z(48)
      Z(151) = Z(5)*Z(51) - Z(6)*Z(49)
      Z(152) = Z(5)*Z(142) - Z(6)*Z(141)
      Z(153) = Z(5)*Z(143) - Z(6)*Z(141)
      Z(154) = Z(5)*Z(144) + Z(6)*Z(141)
      Z(155) = Z(153) - L7
      Z(156) = L7 + Z(154)
      Z(157) = Z(153) - L8
      Z(158) = L8 + Z(154)
      Z(159) = Z(9)*Z(145) + Z(10)*Z(150)
      Z(160) = Z(9)*Z(146) + Z(10)*Z(151)
      Z(161) = Z(9)*Z(147) + Z(10)*Z(152)
      Z(162) = Z(9)*Z(148) + Z(10)*Z(153)
      Z(163) = Z(9)*Z(148) + Z(10)*Z(157)
      Z(164) = Z(9)*Z(149) + Z(10)*Z(158)
      Z(165) = Z(9)*Z(150) - Z(10)*Z(145)
      Z(166) = Z(9)*Z(151) - Z(10)*Z(146)
      Z(167) = Z(9)*Z(152) - Z(10)*Z(147)
      Z(168) = Z(9)*Z(153) - Z(10)*Z(148)
      Z(169) = Z(9)*Z(157) - Z(10)*Z(148)
      Z(170) = Z(9)*Z(158) - Z(10)*Z(149)
      Z(171) = Z(169) - L9
      Z(172) = L9 + Z(170)
      Z(173) = Z(169) - L10
      Z(174) = L10 + Z(170)
      Z(317) = L1*(U3-U4-U5-U6-U7)*(U3+Z(103))
      Z(318) = L2*(U3-U4-U5-U6-U7)*(U3+Z(103))
      Z(319) = L4*(U3-U5-U6-U7)*(U3+Z(108))
      Z(320) = L3*(U3-U5-U6-U7)*(U3+Z(108))
      Z(324) = Z(3)*Z(318)
      Z(325) = Z(4)*Z(318)
      Z(326) = Z(324) - L6*(U3-U5-U6-U7)*(U3+Z(108))
      Z(327) = Z(5)*Z(326) - Z(6)*Z(325)
      Z(328) = -Z(5)*Z(325) - Z(6)*Z(326)
      Z(329) = Z(327) - L7*(U3-U6-U7)*(U3+Z(113))
      Z(330) = Z(327) - L8*(U3-U6-U7)*(U3+Z(113))
      Z(331) = Z(9)*Z(330) + Z(10)*Z(328)
      Z(332) = Z(9)*Z(328) - Z(10)*Z(330)
      Z(333) = Z(331) - L9*(U3-U7)**2
      Z(334) = Z(331) - L10*(U3-U7)**2
      Z(374) = L2*(U3-U4-U5-U6-U7)
      Z(375) = L6*(U3-U5-U6-U7)
      Z(376) = L8*(U3-U6-U7)
      Z(377) = L10*(U3-U7)
      Z(380) = (U3-U4-U5-U6-U7)*Z(374)
      Z(381) = (U3-U5-U6-U7)*Z(375)
      Z(382) = (U3-U6-U7)*Z(376)
      Z(383) = (U3-U7)*Z(377)
      Z(400) = MTOR - ATOR
      Z(403) = Z(9)*Z(27) + Z(10)*Z(28)
      Z(404) = Z(9)*Z(28) - Z(10)*Z(27)
      Z(405) = Z(9)*Z(29) + Z(10)*Z(27)
      Z(406) = Z(9)*Z(27) - Z(10)*Z(29)
      Z(408) = Z(3)*Z(404) + Z(4)*Z(406)
      Z(409) = Z(3)*Z(405) - Z(4)*Z(403)
      Z(410) = Z(3)*Z(406) - Z(4)*Z(404)

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
      Z(70) = Z(7)*Z(66) - Z(8)*Z(64)
      Z(71) = Z(20)*Z(65) - Z(19)*Z(63)
      Z(72) = Z(20)*Z(66) - Z(19)*Z(64)
      Z(73) = -Z(19)*Z(65) - Z(20)*Z(63)
      Z(74) = -Z(19)*Z(66) - Z(20)*Z(64)
      Z(114) = U8 - EAp
      Z(116) = FApp - EApp
      Z(122) = FApp - EApp - HApp
      Z(128) = FApp - EApp - HApp - IApp
      Z(175) = Z(13)*Z(11) + Z(14)*Z(12)
      Z(176) = Z(14)*Z(11) - Z(13)*Z(12)
      Z(177) = Z(13)*Z(12) - Z(14)*Z(11)
      Z(178) = Z(159)*Z(175) + Z(165)*Z(177)
      Z(179) = Z(160)*Z(175) + Z(166)*Z(177)
      Z(180) = Z(161)*Z(175) + Z(167)*Z(177)
      Z(181) = Z(162)*Z(175) + Z(168)*Z(177)
      Z(182) = Z(163)*Z(175) + Z(169)*Z(177)
      Z(183) = Z(163)*Z(175) + Z(173)*Z(177)
      Z(184) = Z(164)*Z(175) + Z(174)*Z(177)
      Z(185) = Z(159)*Z(176) + Z(165)*Z(175)
      Z(186) = Z(160)*Z(176) + Z(166)*Z(175)
      Z(187) = Z(161)*Z(176) + Z(167)*Z(175)
      Z(188) = Z(162)*Z(176) + Z(168)*Z(175)
      Z(189) = Z(163)*Z(176) + Z(169)*Z(175)
      Z(190) = Z(163)*Z(176) + Z(173)*Z(175)
      Z(191) = Z(164)*Z(176) + Z(174)*Z(175)
      Z(192) = Z(21)*EAp
      Z(193) = Z(21) + Z(191)
      Z(194) = L10*EAp
      Z(195) = L10 + Z(191)
      Z(197) = -Z(15)*Z(178) - Z(16)*Z(185)
      Z(198) = -Z(15)*Z(179) - Z(16)*Z(186)
      Z(199) = -Z(15)*Z(180) - Z(16)*Z(187)
      Z(200) = -Z(15)*Z(181) - Z(16)*Z(188)
      Z(201) = -Z(15)*Z(182) - Z(16)*Z(189)
      Z(202) = -Z(15)*Z(183) - Z(16)*Z(190)
      Z(203) = -Z(15)*Z(184) - Z(16)*Z(195)
      Z(205) = Z(16)*Z(178) - Z(15)*Z(185)
      Z(206) = Z(16)*Z(179) - Z(15)*Z(186)
      Z(207) = Z(16)*Z(180) - Z(15)*Z(187)
      Z(208) = Z(16)*Z(181) - Z(15)*Z(188)
      Z(209) = Z(16)*Z(182) - Z(15)*Z(189)
      Z(210) = Z(16)*Z(183) - Z(15)*Z(190)
      Z(211) = Z(16)*Z(184) - Z(15)*Z(195)
      Z(214) = FAp - EAp
      Z(215) = Z(22)*Z(214)
      Z(216) = Z(22) + Z(211)
      Z(219) = L8*Z(214)
      Z(220) = L8 + Z(211)
      Z(223) = FAp - EAp - HAp
      Z(228) = Z(24)*Z(223)
      Z(229) = Z(25)*Z(223)
      Z(230) = L6*Z(223)
      Z(234) = Z(18)*Z(205) - Z(17)*Z(197)
      Z(235) = Z(18)*Z(206) - Z(17)*Z(198)
      Z(236) = Z(18)*Z(207) - Z(17)*Z(199)
      Z(237) = Z(18)*Z(208) - Z(17)*Z(200)
      Z(238) = Z(18)*Z(209) - Z(17)*Z(201)
      Z(239) = Z(18)*Z(210) - Z(17)*Z(202)
      Z(240) = Z(18)*Z(220) - Z(17)*Z(203)
      Z(243) = -Z(17)*Z(205) - Z(18)*Z(197)
      Z(244) = -Z(17)*Z(206) - Z(18)*Z(198)
      Z(245) = -Z(17)*Z(207) - Z(18)*Z(199)
      Z(246) = -Z(17)*Z(208) - Z(18)*Z(200)
      Z(247) = -Z(17)*Z(209) - Z(18)*Z(201)
      Z(248) = -Z(17)*Z(210) - Z(18)*Z(202)
      Z(249) = -Z(17)*Z(220) - Z(18)*Z(203)
      Z(252) = L6 + Z(249)
      Z(259) = Z(20)*Z(243) - Z(19)*Z(234)
      Z(260) = Z(20)*Z(244) - Z(19)*Z(235)
      Z(261) = Z(20)*Z(245) - Z(19)*Z(236)
      Z(262) = Z(20)*Z(246) - Z(19)*Z(237)
      Z(263) = Z(20)*Z(247) - Z(19)*Z(238)
      Z(264) = Z(20)*Z(248) - Z(19)*Z(239)
      Z(265) = Z(20)*Z(252) - Z(19)*Z(240)
      Z(269) = -Z(19)*Z(243) - Z(20)*Z(234)
      Z(270) = -Z(19)*Z(244) - Z(20)*Z(235)
      Z(271) = -Z(19)*Z(245) - Z(20)*Z(236)
      Z(272) = -Z(19)*Z(246) - Z(20)*Z(237)
      Z(273) = -Z(19)*Z(247) - Z(20)*Z(238)
      Z(274) = -Z(19)*Z(248) - Z(20)*Z(239)
      Z(275) = -Z(19)*Z(252) - Z(20)*Z(240)
      Z(278) = FAp - EAp - HAp - IAp
      Z(279) = Z(26)*Z(278)
      Z(281) = Z(26) + Z(275)
      Z(287) = L2 + Z(275)
      Z(335) = Z(175)*Z(334) + Z(177)*Z(332)
      Z(336) = Z(175)*Z(332) + Z(176)*Z(334)
      Z(337) = Z(21)*EApp
      Z(338) = Z(335) + (Z(192)-Z(21)*U3-Z(21)*U8)*(U3+Z(114))
      Z(339) = Z(336) - Z(337)
      Z(340) = L10*EApp
      Z(341) = Z(335) + (Z(194)-L10*U3-L10*U8)*(U3+Z(114))
      Z(342) = Z(336) - Z(340)
      Z(343) = -Z(15)*Z(341) - Z(16)*Z(342)
      Z(344) = Z(16)*Z(341) - Z(15)*Z(342)
      Z(345) = Z(22)*Z(116)
      Z(346) = Z(214) + U8 + U9
      Z(347) = Z(343) - (Z(215)+Z(22)*U3+Z(22)*U8+Z(22)*U9)*(U3+Z(346))
      Z(348) = Z(345) + Z(344)
      Z(349) = L8*Z(116)
      Z(350) = Z(343) - (Z(219)+L8*U3+L8*U8+L8*U9)*(U3+Z(346))
      Z(351) = Z(349) + Z(344)
      Z(352) = Z(24)*Z(122)
      Z(353) = Z(25)*Z(122)
      Z(354) = Z(223) + U10 + U8 + U9
      Z(355) = (Z(228)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)*(U3+Z(354))
      Z(356) = (Z(229)+Z(25)*U10+Z(25)*U3+Z(25)*U8+Z(25)*U9)*(U3+Z(354))
      Z(357) = L6*Z(122)
      Z(361) = Z(18)*Z(351) - Z(17)*Z(350)
      Z(362) = -Z(17)*Z(351) - Z(18)*Z(350)
      Z(363) = Z(361) - (Z(230)+L6*U10+L6*U3+L6*U8+L6*U9)*(U3+Z(354))
      Z(364) = Z(357) + Z(362)
      Z(365) = Z(20)*Z(364) - Z(19)*Z(363)
      Z(366) = -Z(19)*Z(364) - Z(20)*Z(363)
      Z(367) = Z(26)*Z(128)
      Z(368) = Z(278) + U10 + U11 + U8 + U9
      Z(369) = Z(365) - (Z(279)+Z(26)*U10+Z(26)*U11+Z(26)*U3+Z(26)*U8+Z(
     &26)*U9)*(U3+Z(368))
      Z(370) = Z(367) + Z(366)
      Z(378) = GS*U3
      Z(379) = GSp*U3
      Z(384) = GSpp - U3*Z(378)
      Z(385) = GSp*U3 + Z(379)
      Z(411) = -Z(7)*Z(17) - Z(8)*Z(18)
      Z(412) = Z(8)*Z(17) - Z(7)*Z(18)
      Z(413) = Z(7)*Z(18) - Z(8)*Z(17)
      Z(739) = RX1 + RX2*Z(37)**2 + RX2*Z(39)**2 + RY2*Z(37)*Z(38) + RY2
     &*Z(39)*Z(40) + VRX1*Z(71)*Z(259) + VRX1*Z(73)*Z(269) + VRY1*Z(72)*
     &Z(259) + VRY1*Z(74)*Z(269) + Z(390)*(Z(37)*Z(38)+Z(39)*Z(40)) + Z(
     &391)*(Z(37)*Z(38)+Z(39)*Z(40)) + Z(392)*(Z(34)*Z(145)+Z(36)*Z(150)
     &) + Z(393)*(Z(53)*Z(159)+Z(55)*Z(165)) + Z(394)*(Z(56)*Z(185)+Z(57
     &)*Z(178)) + Z(395)*(Z(60)*Z(197)+Z(62)*Z(205)) + Z(397)*(Z(60)*Z(1
     &97)+Z(62)*Z(205)) + Z(398)*(Z(72)*Z(259)+Z(74)*Z(269)) + Z(399)*(Z
     &(64)*Z(234)+Z(66)*Z(243))
      Z(740) = Z(396) + RY1 + RX2*Z(37)*Z(38) + RX2*Z(39)*Z(40) + RY2*Z(
     &38)**2 + RY2*Z(40)**2 + VRX1*Z(71)*Z(260) + VRX1*Z(73)*Z(270) + VR
     &Y1*Z(72)*Z(260) + VRY1*Z(74)*Z(270) + Z(390)*(Z(38)**2+Z(40)**2) +
     & Z(391)*(Z(38)**2+Z(40)**2) + Z(392)*(Z(34)*Z(146)+Z(36)*Z(151)) +
     & Z(393)*(Z(53)*Z(160)+Z(55)*Z(166)) + Z(394)*(Z(56)*Z(186)+Z(57)*Z
     &(179)) + Z(395)*(Z(60)*Z(198)+Z(62)*Z(206)) + Z(397)*(Z(60)*Z(198)
     &+Z(62)*Z(206)) + Z(398)*(Z(72)*Z(260)+Z(74)*Z(270)) + Z(399)*(Z(64
     &)*Z(235)+Z(66)*Z(244))
      Z(742) = HTOR + Z(400) + Z(401) + Z(402) + VRX1*Z(71)*Z(265) + VRX
     &1*Z(73)*Z(287) + VRY1*Z(72)*Z(265) + VRY1*Z(74)*Z(287) + Z(392)*(Z
     &(34)*Z(149)+Z(36)*Z(156)) + Z(393)*(Z(53)*Z(164)+Z(55)*Z(172)) + Z
     &(394)*(Z(56)*Z(193)+Z(57)*Z(184)) + Z(395)*(Z(60)*Z(203)+Z(62)*Z(2
     &16)) + Z(398)*(Z(72)*Z(265)+Z(74)*Z(281)) + Z(399)*(Z(64)*Z(240)+Z
     &(66)*Z(252)) + Z(397)*(Z(24)*Z(66)+Z(25)*Z(70)+Z(60)*Z(203)+Z(62)*
     &Z(220)) - MTOR - Z(741)*Z(40) - L2*(RX2*Z(39)+RY2*Z(40)) - 0.5D0*Z
     &(391)*(2*L2*Z(40)-L3*Z(47)-L4*Z(51)) - Z(396)*(L2*Z(40)-L10*Z(55)-
     &L6*Z(51)-L8*Z(36)-GS*Z(1))
      Z(745) = MTOR + Z(741)*Z(40) + Z(743)*Z(40) + Z(744)*Z(40) + VRX1*
     &Z(71)*Z(261) + VRX1*Z(73)*Z(271) + VRY1*Z(72)*Z(261) + VRY1*Z(74)*
     &Z(271) + L2*(RX2*Z(39)+RY2*Z(40)) + Z(392)*(Z(34)*Z(147)+Z(36)*Z(1
     &52)) + Z(393)*(Z(53)*Z(161)+Z(55)*Z(167)) + Z(394)*(Z(56)*Z(187)+Z
     &(57)*Z(180)) + Z(395)*(Z(60)*Z(199)+Z(62)*Z(207)) + Z(397)*(Z(60)*
     &Z(199)+Z(62)*Z(207)) + Z(398)*(Z(72)*Z(261)+Z(74)*Z(271)) + Z(399)
     &*(Z(64)*Z(236)+Z(66)*Z(245))
      Z(746) = MTOR + Z(741)*Z(40) + VRX1*Z(71)*Z(262) + VRX1*Z(73)*Z(27
     &2) + VRY1*Z(72)*Z(262) + VRY1*Z(74)*Z(272) + L2*(RX2*Z(39)+RY2*Z(4
     &0)) + Z(392)*(Z(34)*Z(148)+Z(36)*Z(153)) + Z(393)*(Z(53)*Z(162)+Z(
     &55)*Z(168)) + Z(394)*(Z(56)*Z(188)+Z(57)*Z(181)) + Z(395)*(Z(60)*Z
     &(200)+Z(62)*Z(208)) + Z(397)*(Z(60)*Z(200)+Z(62)*Z(208)) + Z(398)*
     &(Z(72)*Z(262)+Z(74)*Z(272)) + Z(399)*(Z(64)*Z(237)+Z(66)*Z(246)) +
     & Z(396)*(L2*Z(40)-L6*Z(51)) + 0.5D0*Z(391)*(2*L2*Z(40)-L3*Z(47)-L4
     &*Z(51)) - Z(400)
      Z(747) = MTOR + Z(741)*Z(40) + VRX1*Z(71)*Z(263) + VRX1*Z(73)*Z(27
     &3) + VRY1*Z(72)*Z(263) + VRY1*Z(74)*Z(273) + L2*(RX2*Z(39)+RY2*Z(4
     &0)) + Z(392)*(Z(34)*Z(148)+Z(36)*Z(155)) + Z(393)*(Z(53)*Z(163)+Z(
     &55)*Z(169)) + Z(394)*(Z(56)*Z(189)+Z(57)*Z(182)) + Z(395)*(Z(60)*Z
     &(201)+Z(62)*Z(209)) + Z(397)*(Z(60)*Z(201)+Z(62)*Z(209)) + Z(398)*
     &(Z(72)*Z(263)+Z(74)*Z(273)) + Z(399)*(Z(64)*Z(238)+Z(66)*Z(247)) +
     & Z(396)*(L2*Z(40)-L6*Z(51)-L8*Z(36)) + 0.5D0*Z(391)*(2*L2*Z(40)-L3
     &*Z(47)-L4*Z(51)) - Z(400) - Z(401)
      Z(748) = MTOR + Z(741)*Z(40) + VRX1*Z(71)*Z(264) + VRX1*Z(73)*Z(27
     &4) + VRY1*Z(72)*Z(264) + VRY1*Z(74)*Z(274) + L2*(RX2*Z(39)+RY2*Z(4
     &0)) + Z(392)*(Z(34)*Z(148)+Z(36)*Z(155)) + Z(393)*(Z(53)*Z(163)+Z(
     &55)*Z(171)) + Z(394)*(Z(56)*Z(190)+Z(57)*Z(183)) + Z(395)*(Z(60)*Z
     &(202)+Z(62)*Z(210)) + Z(397)*(Z(60)*Z(202)+Z(62)*Z(210)) + Z(398)*
     &(Z(72)*Z(264)+Z(74)*Z(274)) + Z(399)*(Z(64)*Z(239)+Z(66)*Z(248)) +
     & 0.5D0*Z(391)*(2*L2*Z(40)-L3*Z(47)-L4*Z(51)) + Z(396)*(L2*Z(40)-L1
     &0*Z(55)-L6*Z(51)-L8*Z(36)) - Z(400) - Z(401) - Z(402)
      Z(765) = INE*EApp
      Z(767) = INF*Z(116)
      Z(769) = INH*Z(122)
      Z(771) = INI*Z(128)
      Z(772) = MG + MA*(Z(37)**2+Z(39)**2) + MB*(Z(37)**2+Z(39)**2) + MC
     &*(Z(145)**2+Z(150)**2) + MD*(Z(159)**2+Z(165)**2) + ME*(Z(178)**2+
     &Z(185)**2) + MF*(Z(197)**2+Z(205)**2) + MH*(Z(197)**2+Z(205)**2) +
     & MI*(Z(259)**2+Z(269)**2)
      Z(773) = MA*(Z(37)*Z(38)+Z(39)*Z(40)) + MB*(Z(37)*Z(38)+Z(39)*Z(40
     &)) + MC*(Z(145)*Z(146)+Z(150)*Z(151)) + MD*(Z(159)*Z(160)+Z(165)*Z
     &(166)) + ME*(Z(178)*Z(179)+Z(185)*Z(186)) + MF*(Z(197)*Z(198)+Z(20
     &5)*Z(206)) + MH*(Z(197)*Z(198)+Z(205)*Z(206)) + MI*(Z(259)*Z(260)+
     &Z(269)*Z(270))
      Z(774) = MC*(Z(145)*Z(149)+Z(150)*Z(156)) + MD*(Z(159)*Z(164)+Z(16
     &5)*Z(172)) + ME*(Z(178)*Z(184)+Z(185)*Z(193)) + MF*(Z(197)*Z(203)+
     &Z(205)*Z(216)) + MI*(Z(259)*Z(265)+Z(269)*Z(281)) + MG*(L10*Z(54)+
     &L6*Z(50)+L8*Z(35)-L2*Z(39)-GS*Z(2)) + 0.5D0*MB*(L3*Z(37)*Z(43)+L3*
     &Z(39)*Z(41)+L4*Z(3)*Z(39)-2*L2*Z(39)-L4*Z(4)*Z(37)) - Z(618)*Z(39)
     & - MH*(Z(24)*Z(17)*Z(205)+Z(24)*Z(18)*Z(197)-Z(197)*Z(203)-Z(205)*
     &Z(220)-Z(25)*Z(411)*Z(205)-Z(25)*Z(412)*Z(197))
      Z(775) = Z(618)*Z(39) + Z(623)*Z(39) + Z(687)*Z(39) + MC*(Z(145)*Z
     &(147)+Z(150)*Z(152)) + MD*(Z(159)*Z(161)+Z(165)*Z(167)) + ME*(Z(17
     &8)*Z(180)+Z(185)*Z(187)) + MF*(Z(197)*Z(199)+Z(205)*Z(207)) + MH*(
     &Z(197)*Z(199)+Z(205)*Z(207)) + MI*(Z(259)*Z(261)+Z(269)*Z(271))
      Z(776) = Z(618)*Z(39) + MC*(Z(145)*Z(148)+Z(150)*Z(153)) + MD*(Z(1
     &59)*Z(162)+Z(165)*Z(168)) + ME*(Z(178)*Z(181)+Z(185)*Z(188)) + MF*
     &(Z(197)*Z(200)+Z(205)*Z(208)) + MH*(Z(197)*Z(200)+Z(205)*Z(208)) +
     & MI*(Z(259)*Z(262)+Z(269)*Z(272)) + MG*(L2*Z(39)-L6*Z(50)) - 0.5D0
     &*MB*(L3*Z(37)*Z(43)+L3*Z(39)*Z(41)+L4*Z(3)*Z(39)-2*L2*Z(39)-L4*Z(4
     &)*Z(37))
      Z(777) = Z(618)*Z(39) + MC*(Z(145)*Z(148)+Z(150)*Z(155)) + MD*(Z(1
     &59)*Z(163)+Z(165)*Z(169)) + ME*(Z(178)*Z(182)+Z(185)*Z(189)) + MF*
     &(Z(197)*Z(201)+Z(205)*Z(209)) + MH*(Z(197)*Z(201)+Z(205)*Z(209)) +
     & MI*(Z(259)*Z(263)+Z(269)*Z(273)) + MG*(L2*Z(39)-L6*Z(50)-L8*Z(35)
     &) - 0.5D0*MB*(L3*Z(37)*Z(43)+L3*Z(39)*Z(41)+L4*Z(3)*Z(39)-2*L2*Z(3
     &9)-L4*Z(4)*Z(37))
      Z(778) = Z(618)*Z(39) + MC*(Z(145)*Z(148)+Z(150)*Z(155)) + MD*(Z(1
     &59)*Z(163)+Z(165)*Z(171)) + ME*(Z(178)*Z(183)+Z(185)*Z(190)) + MF*
     &(Z(197)*Z(202)+Z(205)*Z(210)) + MH*(Z(197)*Z(202)+Z(205)*Z(210)) +
     & MI*(Z(259)*Z(264)+Z(269)*Z(274)) + MG*(L2*Z(39)-L10*Z(54)-L6*Z(50
     &)-L8*Z(35)) - 0.5D0*MB*(L3*Z(37)*Z(43)+L3*Z(39)*Z(41)+L4*Z(3)*Z(39
     &)-2*L2*Z(39)-L4*Z(4)*Z(37))
      Z(779) = MA*Z(37)*Z(317) + MC*(Z(145)*Z(329)+Z(150)*Z(328)) + MD*(
     &Z(159)*Z(333)+Z(165)*Z(332)) + ME*(Z(178)*Z(338)+Z(185)*Z(339)) + 
     &MF*(Z(197)*Z(347)+Z(205)*Z(348)) + MI*(Z(259)*Z(369)+Z(269)*Z(370)
     &) + MG*(Z(1)*Z(384)+Z(37)*Z(380)-Z(2)*Z(385)-Z(33)*Z(382)-Z(48)*Z(
     &381)-Z(52)*Z(383)) + 0.5D0*MB*(2*Z(37)*Z(318)-Z(3)*Z(37)*Z(319)-Z(
     &4)*Z(39)*Z(319)-Z(37)*Z(41)*Z(320)-Z(39)*Z(42)*Z(320)) + MH*(Z(411
     &)*Z(353)*Z(205)+Z(412)*Z(353)*Z(197)+Z(197)*Z(350)+Z(205)*Z(351)+Z
     &(17)*Z(197)*Z(355)-Z(17)*Z(352)*Z(205)-Z(18)*Z(352)*Z(197)-Z(18)*Z
     &(205)*Z(355)-Z(411)*Z(197)*Z(356)-Z(413)*Z(205)*Z(356))
      Z(780) = MG + MA*(Z(38)**2+Z(40)**2) + MB*(Z(38)**2+Z(40)**2) + MC
     &*(Z(146)**2+Z(151)**2) + MD*(Z(160)**2+Z(166)**2) + ME*(Z(179)**2+
     &Z(186)**2) + MF*(Z(198)**2+Z(206)**2) + MH*(Z(198)**2+Z(206)**2) +
     & MI*(Z(260)**2+Z(270)**2)
      Z(781) = MC*(Z(146)*Z(149)+Z(151)*Z(156)) + MD*(Z(160)*Z(164)+Z(16
     &6)*Z(172)) + ME*(Z(179)*Z(184)+Z(186)*Z(193)) + MF*(Z(198)*Z(203)+
     &Z(206)*Z(216)) + MI*(Z(260)*Z(265)+Z(270)*Z(281)) + 0.5D0*MB*(L3*Z
     &(38)*Z(43)+L3*Z(40)*Z(41)+L4*Z(3)*Z(40)-2*L2*Z(40)-L4*Z(4)*Z(38)) 
     &- Z(618)*Z(40) - MG*(L2*Z(40)-L10*Z(55)-L6*Z(51)-L8*Z(36)-GS*Z(1))
     & - MH*(Z(24)*Z(17)*Z(206)+Z(24)*Z(18)*Z(198)-Z(198)*Z(203)-Z(206)*
     &Z(220)-Z(25)*Z(411)*Z(206)-Z(25)*Z(412)*Z(198))
      Z(782) = Z(618)*Z(40) + Z(623)*Z(40) + Z(687)*Z(40) + MC*(Z(146)*Z
     &(147)+Z(151)*Z(152)) + MD*(Z(160)*Z(161)+Z(166)*Z(167)) + ME*(Z(17
     &9)*Z(180)+Z(186)*Z(187)) + MF*(Z(198)*Z(199)+Z(206)*Z(207)) + MH*(
     &Z(198)*Z(199)+Z(206)*Z(207)) + MI*(Z(260)*Z(261)+Z(270)*Z(271))
      Z(783) = Z(618)*Z(40) + MC*(Z(146)*Z(148)+Z(151)*Z(153)) + MD*(Z(1
     &60)*Z(162)+Z(166)*Z(168)) + ME*(Z(179)*Z(181)+Z(186)*Z(188)) + MF*
     &(Z(198)*Z(200)+Z(206)*Z(208)) + MH*(Z(198)*Z(200)+Z(206)*Z(208)) +
     & MI*(Z(260)*Z(262)+Z(270)*Z(272)) + MG*(L2*Z(40)-L6*Z(51)) - 0.5D0
     &*MB*(L3*Z(38)*Z(43)+L3*Z(40)*Z(41)+L4*Z(3)*Z(40)-2*L2*Z(40)-L4*Z(4
     &)*Z(38))
      Z(784) = Z(618)*Z(40) + MC*(Z(146)*Z(148)+Z(151)*Z(155)) + MD*(Z(1
     &60)*Z(163)+Z(166)*Z(169)) + ME*(Z(179)*Z(182)+Z(186)*Z(189)) + MF*
     &(Z(198)*Z(201)+Z(206)*Z(209)) + MH*(Z(198)*Z(201)+Z(206)*Z(209)) +
     & MI*(Z(260)*Z(263)+Z(270)*Z(273)) + MG*(L2*Z(40)-L6*Z(51)-L8*Z(36)
     &) - 0.5D0*MB*(L3*Z(38)*Z(43)+L3*Z(40)*Z(41)+L4*Z(3)*Z(40)-2*L2*Z(4
     &0)-L4*Z(4)*Z(38))
      Z(785) = Z(618)*Z(40) + MC*(Z(146)*Z(148)+Z(151)*Z(155)) + MD*(Z(1
     &60)*Z(163)+Z(166)*Z(171)) + ME*(Z(179)*Z(183)+Z(186)*Z(190)) + MF*
     &(Z(198)*Z(202)+Z(206)*Z(210)) + MH*(Z(198)*Z(202)+Z(206)*Z(210)) +
     & MI*(Z(260)*Z(264)+Z(270)*Z(274)) + MG*(L2*Z(40)-L10*Z(55)-L6*Z(51
     &)-L8*Z(36)) - 0.5D0*MB*(L3*Z(38)*Z(43)+L3*Z(40)*Z(41)+L4*Z(3)*Z(40
     &)-2*L2*Z(40)-L4*Z(4)*Z(38))
      Z(786) = MA*Z(38)*Z(317) + MC*(Z(146)*Z(329)+Z(151)*Z(328)) + MD*(
     &Z(160)*Z(333)+Z(166)*Z(332)) + ME*(Z(179)*Z(338)+Z(186)*Z(339)) + 
     &MF*(Z(198)*Z(347)+Z(206)*Z(348)) + MI*(Z(260)*Z(369)+Z(270)*Z(370)
     &) + MG*(Z(1)*Z(385)+Z(2)*Z(384)+Z(38)*Z(380)-Z(34)*Z(382)-Z(49)*Z(
     &381)-Z(53)*Z(383)) + 0.5D0*MB*(2*Z(38)*Z(318)-Z(3)*Z(38)*Z(319)-Z(
     &4)*Z(40)*Z(319)-Z(38)*Z(41)*Z(320)-Z(40)*Z(42)*Z(320)) + MH*(Z(411
     &)*Z(353)*Z(206)+Z(412)*Z(353)*Z(198)+Z(198)*Z(350)+Z(206)*Z(351)+Z
     &(17)*Z(198)*Z(355)-Z(17)*Z(352)*Z(206)-Z(18)*Z(352)*Z(198)-Z(18)*Z
     &(206)*Z(355)-Z(411)*Z(198)*Z(356)-Z(413)*Z(206)*Z(356))
      Z(804) = Z(787) + MC*(Z(149)**2+Z(156)**2) + MD*(Z(164)**2+Z(172)*
     &*2) + ME*(Z(184)**2+Z(193)**2) + MF*(Z(203)**2+Z(216)**2) + MI*(Z(
     &265)**2+Z(281)**2) + 0.25D0*MB*(Z(788)-4*Z(789)*Z(41)-4*Z(790)*Z(3
     &)) - MH*(2*Z(24)*Z(17)*Z(220)+2*Z(24)*Z(18)*Z(203)-2*Z(793)-Z(791)
     &-Z(792)-Z(203)**2-Z(220)**2-2*Z(25)*Z(411)*Z(220)-2*Z(25)*Z(412)*Z
     &(203)) - MG*(2*Z(794)*Z(406)+2*Z(795)*Z(3)+2*Z(796)*Z(27)+2*L2*GS*
     &Z(107)-Z(797)-Z(798)-Z(799)-Z(800)-GS**2-2*Z(801)*Z(410)-2*Z(802)*
     &Z(9)-2*Z(803)*Z(5)-2*L10*GS*Z(11)-2*L6*GS*Z(112)-2*L8*GS*Z(30))
      Z(806) = MC*(Z(147)*Z(149)+Z(152)*Z(156)) + MD*(Z(161)*Z(164)+Z(16
     &7)*Z(172)) + ME*(Z(180)*Z(184)+Z(187)*Z(193)) + MF*(Z(199)*Z(203)+
     &Z(207)*Z(216)) + MI*(Z(261)*Z(265)+Z(271)*Z(281)) - INA - Z(805) -
     & 0.5D0*Z(623)*(2*L2-L3*Z(41)-L4*Z(3)) - Z(687)*(L2-L10*Z(406)-L6*Z
     &(3)-L8*Z(27)-GS*Z(107)) - MH*(Z(24)*Z(17)*Z(207)+Z(24)*Z(18)*Z(199
     &)-Z(199)*Z(203)-Z(207)*Z(220)-Z(25)*Z(411)*Z(207)-Z(25)*Z(412)*Z(1
     &99))
      Z(807) = MC*(Z(148)*Z(149)+Z(153)*Z(156)) + MD*(Z(162)*Z(164)+Z(16
     &8)*Z(172)) + ME*(Z(181)*Z(184)+Z(188)*Z(193)) + MF*(Z(200)*Z(203)+
     &Z(208)*Z(216)) + MI*(Z(262)*Z(265)+Z(272)*Z(281)) + MG*(Z(794)*Z(4
     &06)+Z(796)*Z(27)+2*Z(795)*Z(3)+L2*GS*Z(107)-Z(798)-Z(799)-Z(801)*Z
     &(410)-Z(803)*Z(5)-L6*GS*Z(112)) - INA - INB - Z(805) - 0.25D0*MB*(
     &Z(788)-4*Z(789)*Z(41)-4*Z(790)*Z(3)) - MH*(Z(24)*Z(17)*Z(208)+Z(24
     &)*Z(18)*Z(200)-Z(200)*Z(203)-Z(208)*Z(220)-Z(25)*Z(411)*Z(208)-Z(2
     &5)*Z(412)*Z(200))
      Z(808) = MC*(Z(148)*Z(149)+Z(155)*Z(156)) + MD*(Z(163)*Z(164)+Z(16
     &9)*Z(172)) + ME*(Z(182)*Z(184)+Z(189)*Z(193)) + MF*(Z(201)*Z(203)+
     &Z(209)*Z(216)) + MI*(Z(263)*Z(265)+Z(273)*Z(281)) + MG*(Z(794)*Z(4
     &06)+2*Z(795)*Z(3)+2*Z(796)*Z(27)+L2*GS*Z(107)-Z(798)-Z(799)-Z(800)
     &-2*Z(803)*Z(5)-Z(801)*Z(410)-Z(802)*Z(9)-L6*GS*Z(112)-L8*GS*Z(30))
     & - INA - INB - INC - Z(805) - 0.25D0*MB*(Z(788)-4*Z(789)*Z(41)-4*Z
     &(790)*Z(3)) - MH*(Z(24)*Z(17)*Z(209)+Z(24)*Z(18)*Z(201)-Z(201)*Z(2
     &03)-Z(209)*Z(220)-Z(25)*Z(411)*Z(209)-Z(25)*Z(412)*Z(201))
      Z(809) = MC*(Z(148)*Z(149)+Z(155)*Z(156)) + MD*(Z(163)*Z(164)+Z(17
     &1)*Z(172)) + ME*(Z(183)*Z(184)+Z(190)*Z(193)) + MF*(Z(202)*Z(203)+
     &Z(210)*Z(216)) + MI*(Z(264)*Z(265)+Z(274)*Z(281)) + MG*(2*Z(794)*Z
     &(406)+2*Z(795)*Z(3)+2*Z(796)*Z(27)+L2*GS*Z(107)-Z(797)-Z(798)-Z(79
     &9)-Z(800)-2*Z(801)*Z(410)-2*Z(802)*Z(9)-2*Z(803)*Z(5)-L10*GS*Z(11)
     &-L6*GS*Z(112)-L8*GS*Z(30)) - INA - INB - INC - IND - Z(805) - 0.25
     &D0*MB*(Z(788)-4*Z(789)*Z(41)-4*Z(790)*Z(3)) - MH*(Z(24)*Z(17)*Z(21
     &0)+Z(24)*Z(18)*Z(202)-Z(202)*Z(203)-Z(210)*Z(220)-Z(25)*Z(411)*Z(2
     &10)-Z(25)*Z(412)*Z(202))
      Z(816) = Z(767) + Z(769) + Z(771) + MC*(Z(149)*Z(329)+Z(156)*Z(328
     &)) + MD*(Z(164)*Z(333)+Z(172)*Z(332)) + ME*(Z(184)*Z(338)+Z(193)*Z
     &(339)) + MF*(Z(203)*Z(347)+Z(216)*Z(348)) + MI*(Z(265)*Z(369)+Z(28
     &1)*Z(370)) + 0.25D0*MB*(Z(810)*Z(319)+2*L2*Z(4)*Z(319)+2*L2*Z(42)*
     &Z(320)+2*L3*Z(43)*Z(318)-Z(811)*Z(320)-2*L4*Z(4)*Z(318)) + MH*(Z(2
     &4)*Z(352)+Z(25)*Z(353)+Z(812)*Z(353)+Z(813)*Z(352)+Z(411)*Z(353)*Z
     &(220)+Z(412)*Z(353)*Z(203)+Z(814)*Z(355)+Z(203)*Z(350)+Z(220)*Z(35
     &1)+Z(25)*Z(411)*Z(351)+Z(25)*Z(412)*Z(350)+Z(17)*Z(203)*Z(355)-Z(1
     &7)*Z(352)*Z(220)-Z(18)*Z(352)*Z(203)-Z(815)*Z(356)-Z(24)*Z(17)*Z(3
     &51)-Z(24)*Z(18)*Z(350)-Z(18)*Z(220)*Z(355)-Z(411)*Z(203)*Z(356)-Z(
     &413)*Z(220)*Z(356)) + MG*(GS*Z(385)+L10*Z(10)*Z(382)+L10*Z(11)*Z(3
     &85)+L10*Z(12)*Z(384)+L10*Z(404)*Z(380)+L2*Z(4)*Z(381)+L2*Z(29)*Z(3
     &82)+L2*Z(405)*Z(383)+L6*Z(110)*Z(384)+L6*Z(112)*Z(385)+L8*Z(6)*Z(3
     &81)+L8*Z(28)*Z(380)+L8*Z(30)*Z(385)+L8*Z(32)*Z(384)+GS*Z(12)*Z(383
     &)+GS*Z(106)*Z(380)-L10*Z(408)*Z(381)-L2*Z(105)*Z(384)-L2*Z(107)*Z(
     &385)-L6*Z(4)*Z(380)-L6*Z(6)*Z(382)-L6*Z(409)*Z(383)-L8*Z(10)*Z(383
     &)-GS*Z(31)*Z(382)-GS*Z(111)*Z(381)) - Z(765)
      Z(818) = Z(817) + MC*(Z(147)**2+Z(152)**2) + MD*(Z(161)**2+Z(167)*
     &*2) + ME*(Z(180)**2+Z(187)**2) + MF*(Z(199)**2+Z(207)**2) + MH*(Z(
     &199)**2+Z(207)**2) + MI*(Z(261)**2+Z(271)**2)
      Z(820) = Z(819) + MC*(Z(147)*Z(148)+Z(152)*Z(153)) + MD*(Z(161)*Z(
     &162)+Z(167)*Z(168)) + ME*(Z(180)*Z(181)+Z(187)*Z(188)) + MF*(Z(199
     &)*Z(200)+Z(207)*Z(208)) + MH*(Z(199)*Z(200)+Z(207)*Z(208)) + MI*(Z
     &(261)*Z(262)+Z(271)*Z(272)) + Z(687)*(L2-L6*Z(3)) + 0.5D0*Z(623)*(
     &2*L2-L3*Z(41)-L4*Z(3))
      Z(821) = Z(819) + MC*(Z(147)*Z(148)+Z(152)*Z(155)) + MD*(Z(161)*Z(
     &163)+Z(167)*Z(169)) + ME*(Z(180)*Z(182)+Z(187)*Z(189)) + MF*(Z(199
     &)*Z(201)+Z(207)*Z(209)) + MH*(Z(199)*Z(201)+Z(207)*Z(209)) + MI*(Z
     &(261)*Z(263)+Z(271)*Z(273)) + Z(687)*(L2-L6*Z(3)-L8*Z(27)) + 0.5D0
     &*Z(623)*(2*L2-L3*Z(41)-L4*Z(3))
      Z(822) = Z(819) + MC*(Z(147)*Z(148)+Z(152)*Z(155)) + MD*(Z(161)*Z(
     &163)+Z(167)*Z(171)) + ME*(Z(180)*Z(183)+Z(187)*Z(190)) + MF*(Z(199
     &)*Z(202)+Z(207)*Z(210)) + MH*(Z(199)*Z(202)+Z(207)*Z(210)) + MI*(Z
     &(261)*Z(264)+Z(271)*Z(274)) + 0.5D0*Z(623)*(2*L2-L3*Z(41)-L4*Z(3))
     & + Z(687)*(L2-L10*Z(406)-L6*Z(3)-L8*Z(27))
      Z(823) = MC*(Z(147)*Z(329)+Z(152)*Z(328)) + MD*(Z(161)*Z(333)+Z(16
     &7)*Z(332)) + ME*(Z(180)*Z(338)+Z(187)*Z(339)) + MF*(Z(199)*Z(347)+
     &Z(207)*Z(348)) + MI*(Z(261)*Z(369)+Z(271)*Z(370)) + Z(687)*(Z(105)
     &*Z(384)+Z(107)*Z(385)-Z(4)*Z(381)-Z(29)*Z(382)-Z(405)*Z(383)) + MH
     &*(Z(411)*Z(353)*Z(207)+Z(412)*Z(353)*Z(199)+Z(199)*Z(350)+Z(207)*Z
     &(351)+Z(17)*Z(199)*Z(355)-Z(17)*Z(352)*Z(207)-Z(18)*Z(352)*Z(199)-
     &Z(18)*Z(207)*Z(355)-Z(411)*Z(199)*Z(356)-Z(413)*Z(207)*Z(356)) - 0
     &.5D0*Z(623)*(Z(4)*Z(319)+Z(42)*Z(320))
      Z(826) = Z(824) + MC*(Z(148)**2+Z(153)**2) + MD*(Z(162)**2+Z(168)*
     &*2) + ME*(Z(181)**2+Z(188)**2) + MF*(Z(200)**2+Z(208)**2) + MG*(Z(
     &825)-2*Z(795)*Z(3)) + MH*(Z(200)**2+Z(208)**2) + MI*(Z(262)**2+Z(2
     &72)**2) + 0.25D0*MB*(Z(788)-4*Z(789)*Z(41)-4*Z(790)*Z(3))
      Z(827) = Z(824) + MC*(Z(148)**2+Z(153)*Z(155)) + MD*(Z(162)*Z(163)
     &+Z(168)*Z(169)) + ME*(Z(181)*Z(182)+Z(188)*Z(189)) + MF*(Z(200)*Z(
     &201)+Z(208)*Z(209)) + MH*(Z(200)*Z(201)+Z(208)*Z(209)) + MI*(Z(262
     &)*Z(263)+Z(272)*Z(273)) + 0.25D0*MB*(Z(788)-4*Z(789)*Z(41)-4*Z(790
     &)*Z(3)) - MG*(Z(796)*Z(27)+2*Z(795)*Z(3)-Z(798)-Z(799)-Z(803)*Z(5)
     &)
      Z(828) = Z(824) + MC*(Z(148)**2+Z(153)*Z(155)) + MD*(Z(162)*Z(163)
     &+Z(168)*Z(171)) + ME*(Z(181)*Z(183)+Z(188)*Z(190)) + MF*(Z(200)*Z(
     &202)+Z(208)*Z(210)) + MH*(Z(200)*Z(202)+Z(208)*Z(210)) + MI*(Z(262
     &)*Z(264)+Z(272)*Z(274)) + 0.25D0*MB*(Z(788)-4*Z(789)*Z(41)-4*Z(790
     &)*Z(3)) - MG*(Z(794)*Z(406)+Z(796)*Z(27)+2*Z(795)*Z(3)-Z(798)-Z(79
     &9)-Z(801)*Z(410)-Z(803)*Z(5))
      Z(829) = MC*(Z(148)*Z(329)+Z(153)*Z(328)) + MD*(Z(162)*Z(333)+Z(16
     &8)*Z(332)) + ME*(Z(181)*Z(338)+Z(188)*Z(339)) + MF*(Z(200)*Z(347)+
     &Z(208)*Z(348)) + MI*(Z(262)*Z(369)+Z(272)*Z(370)) + MH*(Z(411)*Z(3
     &53)*Z(208)+Z(412)*Z(353)*Z(200)+Z(200)*Z(350)+Z(208)*Z(351)+Z(17)*
     &Z(200)*Z(355)-Z(17)*Z(352)*Z(208)-Z(18)*Z(352)*Z(200)-Z(18)*Z(208)
     &*Z(355)-Z(411)*Z(200)*Z(356)-Z(413)*Z(208)*Z(356)) - 0.25D0*MB*(Z(
     &810)*Z(319)+2*L2*Z(4)*Z(319)+2*L2*Z(42)*Z(320)+2*L3*Z(43)*Z(318)-Z
     &(811)*Z(320)-2*L4*Z(4)*Z(318)) - MG*(L2*Z(4)*Z(381)+L2*Z(29)*Z(382
     &)+L2*Z(405)*Z(383)+L6*Z(110)*Z(384)+L6*Z(112)*Z(385)-L2*Z(105)*Z(3
     &84)-L2*Z(107)*Z(385)-L6*Z(4)*Z(380)-L6*Z(6)*Z(382)-L6*Z(409)*Z(383
     &))
      Z(831) = Z(830) + MC*(Z(148)**2+Z(155)**2) + MD*(Z(163)**2+Z(169)*
     &*2) + ME*(Z(182)**2+Z(189)**2) + MF*(Z(201)**2+Z(209)**2) + MH*(Z(
     &201)**2+Z(209)**2) + MI*(Z(263)**2+Z(273)**2) + 0.25D0*MB*(Z(788)-
     &4*Z(789)*Z(41)-4*Z(790)*Z(3)) - MG*(2*Z(795)*Z(3)+2*Z(796)*Z(27)-Z
     &(798)-Z(799)-Z(800)-2*Z(803)*Z(5))
      Z(832) = Z(830) + MC*(Z(148)**2+Z(155)**2) + MD*(Z(163)**2+Z(169)*
     &Z(171)) + ME*(Z(182)*Z(183)+Z(189)*Z(190)) + MF*(Z(201)*Z(202)+Z(2
     &09)*Z(210)) + MH*(Z(201)*Z(202)+Z(209)*Z(210)) + MI*(Z(263)*Z(264)
     &+Z(273)*Z(274)) + 0.25D0*MB*(Z(788)-4*Z(789)*Z(41)-4*Z(790)*Z(3)) 
     &- MG*(Z(794)*Z(406)+2*Z(795)*Z(3)+2*Z(796)*Z(27)-Z(798)-Z(799)-Z(8
     &00)-2*Z(803)*Z(5)-Z(801)*Z(410)-Z(802)*Z(9))
      Z(833) = MC*(Z(148)*Z(329)+Z(155)*Z(328)) + MD*(Z(163)*Z(333)+Z(16
     &9)*Z(332)) + ME*(Z(182)*Z(338)+Z(189)*Z(339)) + MF*(Z(201)*Z(347)+
     &Z(209)*Z(348)) + MI*(Z(263)*Z(369)+Z(273)*Z(370)) + MH*(Z(411)*Z(3
     &53)*Z(209)+Z(412)*Z(353)*Z(201)+Z(201)*Z(350)+Z(209)*Z(351)+Z(17)*
     &Z(201)*Z(355)-Z(17)*Z(352)*Z(209)-Z(18)*Z(352)*Z(201)-Z(18)*Z(209)
     &*Z(355)-Z(411)*Z(201)*Z(356)-Z(413)*Z(209)*Z(356)) + MG*(L2*Z(105)
     &*Z(384)+L2*Z(107)*Z(385)+L6*Z(4)*Z(380)+L6*Z(6)*Z(382)+L6*Z(409)*Z
     &(383)+L8*Z(10)*Z(383)-L2*Z(4)*Z(381)-L2*Z(29)*Z(382)-L2*Z(405)*Z(3
     &83)-L6*Z(110)*Z(384)-L6*Z(112)*Z(385)-L8*Z(6)*Z(381)-L8*Z(28)*Z(38
     &0)-L8*Z(30)*Z(385)-L8*Z(32)*Z(384)) - 0.25D0*MB*(Z(810)*Z(319)+2*L
     &2*Z(4)*Z(319)+2*L2*Z(42)*Z(320)+2*L3*Z(43)*Z(318)-Z(811)*Z(320)-2*
     &L4*Z(4)*Z(318))
      Z(835) = Z(834) + MC*(Z(148)**2+Z(155)**2) + MD*(Z(163)**2+Z(171)*
     &*2) + ME*(Z(183)**2+Z(190)**2) + MF*(Z(202)**2+Z(210)**2) + MH*(Z(
     &202)**2+Z(210)**2) + MI*(Z(264)**2+Z(274)**2) + 0.25D0*MB*(Z(788)-
     &4*Z(789)*Z(41)-4*Z(790)*Z(3)) - MG*(2*Z(794)*Z(406)+2*Z(795)*Z(3)+
     &2*Z(796)*Z(27)-Z(797)-Z(798)-Z(799)-Z(800)-2*Z(801)*Z(410)-2*Z(802
     &)*Z(9)-2*Z(803)*Z(5))
      Z(836) = MC*(Z(148)*Z(329)+Z(155)*Z(328)) + MD*(Z(163)*Z(333)+Z(17
     &1)*Z(332)) + ME*(Z(183)*Z(338)+Z(190)*Z(339)) + MF*(Z(202)*Z(347)+
     &Z(210)*Z(348)) + MI*(Z(264)*Z(369)+Z(274)*Z(370)) + MH*(Z(411)*Z(3
     &53)*Z(210)+Z(412)*Z(353)*Z(202)+Z(202)*Z(350)+Z(210)*Z(351)+Z(17)*
     &Z(202)*Z(355)-Z(17)*Z(352)*Z(210)-Z(18)*Z(352)*Z(202)-Z(18)*Z(210)
     &*Z(355)-Z(411)*Z(202)*Z(356)-Z(413)*Z(210)*Z(356)) + MG*(L10*Z(408
     &)*Z(381)+L2*Z(105)*Z(384)+L2*Z(107)*Z(385)+L6*Z(4)*Z(380)+L6*Z(6)*
     &Z(382)+L6*Z(409)*Z(383)+L8*Z(10)*Z(383)-L10*Z(10)*Z(382)-L10*Z(11)
     &*Z(385)-L10*Z(12)*Z(384)-L10*Z(404)*Z(380)-L2*Z(4)*Z(381)-L2*Z(29)
     &*Z(382)-L2*Z(405)*Z(383)-L6*Z(110)*Z(384)-L6*Z(112)*Z(385)-L8*Z(6)
     &*Z(381)-L8*Z(28)*Z(380)-L8*Z(30)*Z(385)-L8*Z(32)*Z(384)) - 0.25D0*
     &MB*(Z(810)*Z(319)+2*L2*Z(4)*Z(319)+2*L2*Z(42)*Z(320)+2*L3*Z(43)*Z(
     &318)-Z(811)*Z(320)-2*L4*Z(4)*Z(318))
      Z(874) = Z(739) - Z(779)
      Z(875) = Z(740) - Z(786)
      Z(876) = Z(742) - Z(816)
      Z(877) = Z(745) - Z(823)
      Z(878) = Z(746) - Z(829)
      Z(879) = Z(747) - Z(833)
      Z(880) = Z(748) - Z(836)

      COEF(1,1) = -Z(772)
      COEF(1,2) = -Z(773)
      COEF(1,3) = -Z(774)
      COEF(1,4) = -Z(775)
      COEF(1,5) = -Z(776)
      COEF(1,6) = -Z(777)
      COEF(1,7) = -Z(778)
      COEF(2,1) = -Z(773)
      COEF(2,2) = -Z(780)
      COEF(2,3) = -Z(781)
      COEF(2,4) = -Z(782)
      COEF(2,5) = -Z(783)
      COEF(2,6) = -Z(784)
      COEF(2,7) = -Z(785)
      COEF(3,1) = -Z(774)
      COEF(3,2) = -Z(781)
      COEF(3,3) = -Z(804)
      COEF(3,4) = -Z(806)
      COEF(3,5) = -Z(807)
      COEF(3,6) = -Z(808)
      COEF(3,7) = -Z(809)
      COEF(4,1) = -Z(775)
      COEF(4,2) = -Z(782)
      COEF(4,3) = -Z(806)
      COEF(4,4) = -Z(818)
      COEF(4,5) = -Z(820)
      COEF(4,6) = -Z(821)
      COEF(4,7) = -Z(822)
      COEF(5,1) = -Z(776)
      COEF(5,2) = -Z(783)
      COEF(5,3) = -Z(807)
      COEF(5,4) = -Z(820)
      COEF(5,5) = -Z(826)
      COEF(5,6) = -Z(827)
      COEF(5,7) = -Z(828)
      COEF(6,1) = -Z(777)
      COEF(6,2) = -Z(784)
      COEF(6,3) = -Z(808)
      COEF(6,4) = -Z(821)
      COEF(6,5) = -Z(827)
      COEF(6,6) = -Z(831)
      COEF(6,7) = -Z(832)
      COEF(7,1) = -Z(778)
      COEF(7,2) = -Z(785)
      COEF(7,3) = -Z(809)
      COEF(7,4) = -Z(822)
      COEF(7,5) = -Z(828)
      COEF(7,6) = -Z(832)
      COEF(7,7) = -Z(835)
      RHS(1) = -Z(874)
      RHS(2) = -Z(875)
      RHS(3) = -Z(876)
      RHS(4) = -Z(877)
      RHS(5) = -Z(878)
      RHS(6) = -Z(879)
      RHS(7) = -Z(880)
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
     &,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP1X,POP1Y,POP2X,POP2Y,POP3X,
     &POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,
     &POP9X,POP9Y,PSTANCEX,PSTANCEY,PSWINGX,PSWINGY,SAANG,SAANGVEL,SMANG
     &,SMANGVEL,VOCMSTANCEX,VOCMSTANCEY,VOCMSWINGX,VOCMSWINGY,VOCMX,VOCM
     &Y,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(884),COEF(7,7),RHS(7)

C**   Evaluate output quantities
      Z(213) = Z(15)*Z(194)
      Z(218) = Z(213) + Z(215)
      Z(212) = L10*Z(15)
      Z(217) = Z(22) - Z(212)
      Z(196) = L10*Z(16)
      Z(204) = Z(16)*Z(194)
      Z(222) = Z(213) + Z(219)
      Z(251) = -Z(17)*Z(222) - Z(18)*Z(204)
      Z(255) = Z(230) + Z(251)
      Z(241) = Z(18)*Z(222) - Z(17)*Z(204)
      Z(266) = Z(20)*Z(255) - Z(19)*Z(241)
      Z(256) = L6*Z(20)
      Z(221) = L8 - Z(212)
      Z(242) = Z(18)*Z(196) - Z(17)*Z(221)
      Z(253) = L6 + Z(242)
      Z(233) = Z(17)*Z(196) + Z(18)*Z(221)
      Z(257) = Z(20)*Z(253) - Z(19)*Z(233)
      Z(250) = L8*Z(17)
      Z(254) = L6 - Z(250)
      Z(232) = L8*Z(18)
      Z(258) = Z(20)*Z(254) - Z(19)*Z(232)
      Z(277) = -Z(19)*Z(255) - Z(20)*Z(241)
      Z(284) = Z(277) + Z(279)
      Z(276) = L6*Z(19)
      Z(280) = Z(26) - Z(276)
      Z(268) = -Z(19)*Z(253) - Z(20)*Z(233)
      Z(282) = Z(26) + Z(268)
      Z(267) = -Z(19)*Z(254) - Z(20)*Z(232)
      Z(283) = Z(26) + Z(267)
      KECM = 0.5D0*ING*U3**2 + 0.5D0*IND*(U3-U7)**2 + 0.5D0*INC*(U3-U6-U
     &7)**2 + 0.5D0*INE*(EAp-U3-U8)**2 + 0.5D0*INB*(U3-U5-U6-U7)**2 + 0.
     &5D0*INA*(U3-U4-U5-U6-U7)**2 + 0.5D0*INF*(EAp-FAp-U3-U8-U9)**2 + 0.
     &5D0*INH*(EAp+HAp-FAp-U10-U3-U8-U9)**2 + 0.5D0*INI*(EAp+HAp+IAp-FAp
     &-U10-U11-U3-U8-U9)**2 + 0.5D0*MA*((Z(37)*U1+Z(38)*U2)**2+(L1*U3-L1
     &*U4-L1*U5-L1*U6-L1*U7-Z(39)*U1-Z(40)*U2)**2) + 0.5D0*MC*((Z(145)*U
     &1+Z(146)*U2+Z(147)*U4+Z(148)*U5+Z(148)*U6+Z(148)*U7+Z(149)*U3)**2+
     &(Z(150)*U1+Z(151)*U2+Z(152)*U4+Z(153)*U5+Z(155)*U6+Z(155)*U7+Z(156
     &)*U3)**2) + 0.5D0*MD*((Z(159)*U1+Z(160)*U2+Z(161)*U4+Z(162)*U5+Z(1
     &63)*U6+Z(163)*U7+Z(164)*U3)**2+(Z(165)*U1+Z(166)*U2+Z(167)*U4+Z(16
     &8)*U5+Z(169)*U6+Z(171)*U7+Z(172)*U3)**2) + 0.5D0*ME*((Z(178)*U1+Z(
     &179)*U2+Z(180)*U4+Z(181)*U5+Z(182)*U6+Z(183)*U7+Z(184)*U3)**2+(Z(1
     &92)-Z(21)*U8-Z(185)*U1-Z(186)*U2-Z(187)*U4-Z(188)*U5-Z(189)*U6-Z(1
     &90)*U7-Z(193)*U3)**2) + 0.5D0*MF*((Z(218)+Z(22)*U9+Z(217)*U8+Z(205
     &)*U1+Z(206)*U2+Z(207)*U4+Z(208)*U5+Z(209)*U6+Z(210)*U7+Z(216)*U3)*
     &*2+(Z(196)*U8-Z(204)-Z(197)*U1-Z(198)*U2-Z(199)*U4-Z(200)*U5-Z(201
     &)*U6-Z(202)*U7-Z(203)*U3)**2) + 0.5D0*MI*((Z(266)+Z(256)*U10+Z(257
     &)*U8+Z(258)*U9+Z(259)*U1+Z(260)*U2+Z(261)*U4+Z(262)*U5+Z(263)*U6+Z
     &(264)*U7+Z(265)*U3)**2+(Z(284)+Z(26)*U11+Z(280)*U10+Z(282)*U8+Z(28
     &3)*U9+Z(269)*U1+Z(270)*U2+Z(271)*U4+Z(272)*U5+Z(273)*U6+Z(274)*U7+
     &Z(281)*U3)**2) + 0.125D0*MB*(4*(Z(37)*U1+Z(38)*U2)**2+L3**2*(U3-U5
     &-U6-U7)**2+L4**2*(U3-U5-U6-U7)**2+2*L3*L4*Z(7)*(U3-U5-U6-U7)**2+4*
     &L3*Z(43)*(Z(37)*U1+Z(38)*U2)*(U3-U5-U6-U7)+4*(L2*U3-L2*U4-L2*U5-L2
     &*U6-L2*U7-Z(39)*U1-Z(40)*U2)**2-4*L4*Z(4)*(Z(37)*U1+Z(38)*U2)*(U3-
     &U5-U6-U7)-4*L3*Z(41)*(U3-U5-U6-U7)*(L2*U3-L2*U4-L2*U5-L2*U6-L2*U7-
     &Z(39)*U1-Z(40)*U2)-4*L4*Z(3)*(U3-U5-U6-U7)*(L2*U3-L2*U4-L2*U5-L2*U
     &6-L2*U7-Z(39)*U1-Z(40)*U2)) + 0.5D0*MH*((Z(228)+Z(24)*U10+Z(24)*U3
     &+Z(24)*U8+Z(24)*U9)**2+(Z(229)+Z(25)*U10+Z(25)*U3+Z(25)*U8+Z(25)*U
     &9)**2+(Z(222)+L8*U9+Z(221)*U8+Z(205)*U1+Z(206)*U2+Z(207)*U4+Z(208)
     &*U5+Z(209)*U6+Z(210)*U7+Z(220)*U3)**2+2*Z(7)*(Z(228)+Z(24)*U10+Z(2
     &4)*U3+Z(24)*U8+Z(24)*U9)*(Z(229)+Z(25)*U10+Z(25)*U3+Z(25)*U8+Z(25)
     &*U9)+(Z(196)*U8-Z(204)-Z(197)*U1-Z(198)*U2-Z(199)*U4-Z(200)*U5-Z(2
     &01)*U6-Z(202)*U7-Z(203)*U3)**2+2*Z(411)*(Z(229)+Z(25)*U10+Z(25)*U3
     &+Z(25)*U8+Z(25)*U9)*(Z(222)+L8*U9+Z(221)*U8+Z(205)*U1+Z(206)*U2+Z(
     &207)*U4+Z(208)*U5+Z(209)*U6+Z(210)*U7+Z(220)*U3)+2*Z(18)*(Z(228)+Z
     &(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)*(Z(196)*U8-Z(204)-Z(197)*U1-Z
     &(198)*U2-Z(199)*U4-Z(200)*U5-Z(201)*U6-Z(202)*U7-Z(203)*U3)-2*Z(17
     &)*(Z(228)+Z(24)*U10+Z(24)*U3+Z(24)*U8+Z(24)*U9)*(Z(222)+L8*U9+Z(22
     &1)*U8+Z(205)*U1+Z(206)*U2+Z(207)*U4+Z(208)*U5+Z(209)*U6+Z(210)*U7+
     &Z(220)*U3)-2*Z(412)*(Z(229)+Z(25)*U10+Z(25)*U3+Z(25)*U8+Z(25)*U9)*
     &(Z(196)*U8-Z(204)-Z(197)*U1-Z(198)*U2-Z(199)*U4-Z(200)*U5-Z(201)*U
     &6-Z(202)*U7-Z(203)*U3)) + 0.5D0*MG*(GSp**2+U1**2+U2**2+2*GSp*Z(1)*
     &U1+2*GSp*Z(2)*U2+GS**2*U3**2+2*GS*Z(1)*U2*U3+L10**2*(U3-U7)**2+2*L
     &10*GSp*Z(12)*(U3-U7)+2*L10*Z(54)*U1*(U3-U7)+2*L10*Z(55)*U2*(U3-U7)
     &+2*L10*GS*Z(11)*U3*(U3-U7)+L8**2*(U3-U6-U7)**2+2*L8*GSp*Z(32)*(U3-
     &U6-U7)+2*L8*Z(35)*U1*(U3-U6-U7)+2*L8*Z(36)*U2*(U3-U6-U7)+2*L8*GS*Z
     &(30)*U3*(U3-U6-U7)+L6**2*(U3-U5-U6-U7)**2+2*L6*GSp*Z(110)*(U3-U5-U
     &6-U7)+2*L6*Z(50)*U1*(U3-U5-U6-U7)+2*L6*Z(51)*U2*(U3-U5-U6-U7)+2*L6
     &*GS*Z(112)*U3*(U3-U5-U6-U7)+L2**2*(U3-U4-U5-U6-U7)**2+2*L10*L8*Z(9
     &)*(U3-U7)*(U3-U6-U7)+2*L10*L6*Z(410)*(U3-U7)*(U3-U5-U6-U7)+2*L6*L8
     &*Z(5)*(U3-U6-U7)*(U3-U5-U6-U7)-2*GS*Z(2)*U1*U3-2*L2*GSp*Z(105)*(U3
     &-U4-U5-U6-U7)-2*L2*Z(39)*U1*(U3-U4-U5-U6-U7)-2*L2*Z(40)*U2*(U3-U4-
     &U5-U6-U7)-2*L2*GS*Z(107)*U3*(U3-U4-U5-U6-U7)-2*L10*L2*Z(406)*(U3-U
     &7)*(U3-U4-U5-U6-U7)-2*L2*L8*Z(27)*(U3-U6-U7)*(U3-U4-U5-U6-U7)-2*L2
     &*L6*Z(3)*(U3-U5-U6-U7)*(U3-U4-U5-U6-U7))
      Z(68) = Z(7)*Z(64) + Z(8)*Z(66)
      Z(82) = MG*GS/Z(75)
      Z(45) = Z(38)*Z(41) + Z(40)*Z(42)
      POCMY = Q2 + Z(78)*Z(34) + Z(79)*Z(53) + Z(80)*Z(57) + Z(81)*Z(60)
     & + Z(83)*Z(64) + Z(84)*Z(72) + Z(85)*Z(68) + Z(82)*Z(2) + 0.5D0*Z(
     &77)*Z(49) + 0.5D0*Z(86)*Z(45) - Z(76)*Z(38)
      PECM = 0.5D0*K1*Q1**2 + 0.5D0*K3*Q2**2 - G*MT*POCMY
      TE = KECM + PECM
      Z(415) = INF*Z(214)
      Z(416) = INH*Z(223)
      Z(417) = INI*Z(278)
      Z(44) = Z(37)*Z(41) + Z(39)*Z(42)
      Z(135) = Z(1)*Z(45) - Z(2)*Z(44)
      Z(119) = Z(1)*Z(60) - Z(2)*Z(59)
      Z(125) = Z(1)*Z(64) - Z(2)*Z(63)
      Z(131) = Z(1)*Z(72) - Z(2)*Z(71)
      Z(67) = Z(7)*Z(63) + Z(8)*Z(65)
      Z(226) = Z(1)*Z(68) - Z(2)*Z(67)
      Z(605) = MG*GSp*(Z(86)*Z(135)+2*Z(81)*Z(119)+2*Z(83)*Z(125)+2*Z(84
     &)*Z(131)+2*Z(85)*Z(226)+2*Z(554)*Z(12)-2*Z(80)*Z(14)-2*Z(443)*Z(10
     &6)-2*Z(538)*Z(31)-2*Z(567)*Z(111))
      Z(568) = GS - Z(82)
      Z(606) = MG*(Z(86)*Z(45)+2*Z(80)*Z(57)+2*Z(81)*Z(60)+2*Z(83)*Z(64)
     &+2*Z(84)*Z(72)+2*Z(85)*Z(68)-2*Z(443)*Z(38)-2*Z(538)*Z(34)-2*Z(554
     &)*Z(53)-2*Z(567)*Z(49)-2*Z(568)*Z(2))
      Z(104) = Z(1)*Z(37) + Z(2)*Z(38)
      Z(418) = Z(13)*Z(104) - Z(14)*Z(106)
      Z(420) = Z(13)*Z(106) + Z(14)*Z(104)
      Z(422) = -Z(15)*Z(418) - Z(16)*Z(420)
      Z(424) = Z(16)*Z(418) - Z(15)*Z(420)
      Z(426) = Z(18)*Z(424) - Z(17)*Z(422)
      Z(428) = -Z(17)*Z(424) - Z(18)*Z(422)
      Z(430) = Z(20)*Z(428) - Z(19)*Z(426)
      Z(434) = Z(7)*Z(426) + Z(8)*Z(428)
      Z(439) = Z(438) - Z(78)*Z(27) - Z(79)*Z(403) - Z(80)*Z(418) - Z(81
     &)*Z(422) - Z(83)*Z(426) - Z(84)*Z(430) - Z(85)*Z(434) - Z(82)*Z(10
     &4) - 0.5D0*Z(77)*Z(3) - 0.5D0*Z(86)*Z(41)
      Z(583) = MA*Z(439)
      Z(442) = L1*U4 + L1*U5 + L1*U6 + L1*U7 + Z(39)*U1 + Z(40)*U2 - L1*
     &U3
      Z(585) = MB*(Z(443)+Z(444)*Z(3)+Z(445)*Z(41)-Z(78)*Z(27)-Z(79)*Z(4
     &03)-Z(80)*Z(418)-Z(81)*Z(422)-Z(83)*Z(426)-Z(84)*Z(430)-Z(85)*Z(43
     &4)-Z(82)*Z(104))
      Z(446) = L2*U4 + L2*U5 + L2*U6 + L2*U7 + Z(39)*U1 + Z(40)*U2 - L2*
     &U3
      Z(496) = Z(13)*Z(30) - Z(14)*Z(31)
      Z(498) = Z(13)*Z(31) + Z(14)*Z(30)
      Z(500) = -Z(15)*Z(496) - Z(16)*Z(498)
      Z(502) = Z(16)*Z(496) - Z(15)*Z(498)
      Z(504) = Z(18)*Z(502) - Z(17)*Z(500)
      Z(506) = -Z(17)*Z(502) - Z(18)*Z(500)
      Z(508) = Z(20)*Z(506) - Z(19)*Z(504)
      Z(512) = Z(7)*Z(504) + Z(8)*Z(506)
      Z(449) = Z(7)*Z(5) + Z(8)*Z(6)
      Z(518) = L7 + 0.5D0*Z(516)*Z(5) - Z(78) - Z(79)*Z(9) - Z(80)*Z(496
     &) - Z(81)*Z(500) - Z(83)*Z(504) - Z(84)*Z(508) - Z(85)*Z(512) - Z(
     &517)*Z(27) - Z(82)*Z(30) - 0.5D0*Z(86)*Z(449)
      Z(591) = MC*Z(518)
      Z(521) = Z(150)*U1 + Z(151)*U2 + Z(152)*U4 + Z(153)*U5 + Z(155)*U6
     & + Z(155)*U7 + Z(156)*U3
      Z(407) = Z(3)*Z(403) + Z(4)*Z(405)
      Z(522) = -Z(15)*Z(175) - Z(16)*Z(176)
      Z(524) = Z(16)*Z(175) - Z(15)*Z(176)
      Z(526) = Z(18)*Z(524) - Z(17)*Z(522)
      Z(528) = -Z(17)*Z(524) - Z(18)*Z(522)
      Z(530) = Z(20)*Z(528) - Z(19)*Z(526)
      Z(534) = Z(7)*Z(526) + Z(8)*Z(528)
      Z(451) = Z(8)*Z(5) - Z(7)*Z(6)
      Z(452) = Z(9)*Z(449) + Z(10)*Z(451)
      Z(539) = L9 + Z(538)*Z(9) + 0.5D0*Z(516)*Z(407) - Z(79) - Z(80)*Z(
     &175) - Z(81)*Z(522) - Z(83)*Z(526) - Z(84)*Z(530) - Z(85)*Z(534) -
     & Z(517)*Z(403) - Z(82)*Z(11) - 0.5D0*Z(86)*Z(452)
      Z(593) = MD*Z(539)
      Z(542) = Z(165)*U1 + Z(166)*U2 + Z(167)*U4 + Z(168)*U5 + Z(169)*U6
     & + Z(171)*U7 + Z(172)*U3
      Z(109) = Z(1)*Z(48) + Z(2)*Z(49)
      Z(456) = Z(13)*Z(109) - Z(14)*Z(111)
      Z(543) = Z(15)*Z(17) + Z(16)*Z(18)
      Z(545) = Z(15)*Z(18) - Z(16)*Z(17)
      Z(546) = Z(20)*Z(545) - Z(19)*Z(543)
      Z(550) = Z(7)*Z(543) + Z(8)*Z(545)
      Z(133) = Z(1)*Z(44) + Z(2)*Z(45)
      Z(460) = Z(13)*Z(133) - Z(14)*Z(135)
      Z(555) = Z(21) + Z(81)*Z(15) + Z(538)*Z(496) + Z(554)*Z(175) + 0.5
     &D0*Z(516)*Z(456) - Z(80) - Z(83)*Z(543) - Z(84)*Z(546) - Z(85)*Z(5
     &50) - Z(13)*Z(82) - Z(517)*Z(418) - 0.5D0*Z(86)*Z(460)
      Z(595) = ME*Z(555)
      Z(558) = Z(21)*U8 + Z(185)*U1 + Z(186)*U2 + Z(187)*U4 + Z(188)*U5 
     &+ Z(189)*U6 + Z(190)*U7 + Z(193)*U3 - Z(192)
      Z(458) = Z(13)*Z(111) + Z(14)*Z(109)
      Z(464) = -Z(15)*Z(456) - Z(16)*Z(458)
      Z(559) = Z(17)*Z(19) - Z(18)*Z(20)
      Z(117) = Z(1)*Z(59) + Z(2)*Z(60)
      Z(462) = Z(13)*Z(135) + Z(14)*Z(133)
      Z(468) = -Z(15)*Z(460) - Z(16)*Z(462)
      Z(563) = Z(22) + Z(83)*Z(17) + Z(538)*Z(500) + Z(554)*Z(522) + 0.5
     &D0*Z(516)*Z(464) - Z(81) - Z(84)*Z(559) - Z(85)*Z(411) - Z(562)*Z(
     &15) - Z(517)*Z(422) - Z(82)*Z(117) - 0.5D0*Z(86)*Z(468)
      Z(597) = MF*Z(563)
      Z(566) = Z(218) + Z(22)*U9 + Z(217)*U8 + Z(205)*U1 + Z(206)*U2 + Z
     &(207)*U4 + Z(208)*U5 + Z(209)*U6 + Z(210)*U7 + Z(216)*U3
      Z(466) = Z(16)*Z(456) - Z(15)*Z(458)
      Z(474) = -Z(17)*Z(466) - Z(18)*Z(464)
      Z(472) = Z(18)*Z(466) - Z(17)*Z(464)
      Z(480) = Z(20)*Z(474) - Z(19)*Z(472)
      Z(575) = Z(8)*Z(20) - Z(7)*Z(19)
      Z(129) = Z(1)*Z(71) + Z(2)*Z(72)
      Z(470) = Z(16)*Z(460) - Z(15)*Z(462)
      Z(478) = -Z(17)*Z(470) - Z(18)*Z(468)
      Z(476) = Z(18)*Z(470) - Z(17)*Z(468)
      Z(484) = Z(20)*Z(478) - Z(19)*Z(476)
      Z(579) = Z(26) + Z(562)*Z(546) + Z(569)*Z(559) + Z(538)*Z(508) + Z
     &(554)*Z(530) + 0.5D0*Z(516)*Z(480) - Z(84) - Z(85)*Z(575) - Z(578)
     &*Z(19) - Z(517)*Z(430) - Z(82)*Z(129) - 0.5D0*Z(86)*Z(484)
      Z(614) = MI*Z(579)
      Z(582) = Z(284) + Z(26)*U11 + Z(280)*U10 + Z(282)*U8 + Z(283)*U9 +
     & Z(269)*U1 + Z(270)*U2 + Z(271)*U4 + Z(272)*U5 + Z(273)*U6 + Z(274
     &)*U7 + Z(281)*U3
      Z(488) = Z(7)*Z(472) + Z(8)*Z(474)
      Z(588) = MB*(Z(587)+Z(443)*Z(3)-Z(78)*Z(5)-Z(79)*Z(407)-Z(80)*Z(45
     &6)-Z(81)*Z(464)-Z(83)*Z(472)-Z(84)*Z(480)-Z(85)*Z(488)-Z(82)*Z(109
     &))
      Z(447) = L4*(U3-U5-U6-U7)
      Z(492) = Z(7)*Z(476) + Z(8)*Z(478)
      Z(590) = MB*(Z(589)+Z(443)*Z(41)-Z(78)*Z(449)-Z(79)*Z(452)-Z(80)*Z
     &(460)-Z(81)*Z(468)-Z(83)*Z(476)-Z(84)*Z(484)-Z(85)*Z(492)-Z(82)*Z(
     &133))
      Z(448) = L3*(U3-U5-U6-U7)
      Z(599) = MG*(Z(86)*Z(41)+2*Z(80)*Z(418)+2*Z(81)*Z(422)+2*Z(83)*Z(4
     &26)+2*Z(84)*Z(430)+2*Z(85)*Z(434)-2*Z(443)-2*Z(538)*Z(27)-2*Z(554)
     &*Z(403)-2*Z(567)*Z(3)-2*Z(568)*Z(104))
      Z(608) = MH*(2*Z(569)+2*Z(571)*Z(411)+2*Z(443)*Z(422)+2*Z(538)*Z(5
     &00)+2*Z(554)*Z(522)+2*Z(567)*Z(464)-2*Z(84)*Z(559)-2*Z(562)*Z(15)-
     &2*Z(570)*Z(17)-2*Z(82)*Z(117)-Z(86)*Z(468))
      Z(572) = Z(222) + L8*U9 + Z(221)*U8 + Z(205)*U1 + Z(206)*U2 + Z(20
     &7)*U4 + Z(208)*U5 + Z(209)*U6 + Z(210)*U7 + Z(220)*U3
      Z(123) = Z(1)*Z(63) + Z(2)*Z(64)
      Z(611) = MH*(Z(610)+2*Z(84)*Z(19)+2*Z(562)*Z(543)+2*Z(443)*Z(426)+
     &2*Z(538)*Z(504)+2*Z(554)*Z(526)+2*Z(567)*Z(472)-2*Z(569)*Z(17)-2*Z
     &(82)*Z(123)-Z(86)*Z(476))
      Z(573) = Z(228) + Z(24)*U10 + Z(24)*U3 + Z(24)*U8 + Z(24)*U9
      Z(224) = Z(1)*Z(67) + Z(2)*Z(68)
      Z(613) = MH*(Z(612)+2*Z(562)*Z(550)+2*Z(569)*Z(411)+2*Z(443)*Z(434
     &)+2*Z(538)*Z(512)+2*Z(554)*Z(534)+2*Z(567)*Z(488)-2*Z(84)*Z(575)-2
     &*Z(82)*Z(224)-Z(86)*Z(492))
      Z(574) = Z(229) + Z(25)*U10 + Z(25)*U3 + Z(25)*U8 + Z(25)*U9
      Z(414) = INE*EAp
      Z(607) = MG*(Z(86)*Z(44)+2*Z(80)*Z(56)+2*Z(81)*Z(59)+2*Z(83)*Z(63)
     &+2*Z(84)*Z(71)+2*Z(85)*Z(67)-2*Z(443)*Z(37)-2*Z(538)*Z(33)-2*Z(554
     &)*Z(52)-2*Z(567)*Z(48)-2*Z(568)*Z(1))
      Z(419) = Z(13)*Z(105) - Z(14)*Z(107)
      Z(421) = Z(13)*Z(107) + Z(14)*Z(105)
      Z(423) = -Z(15)*Z(419) - Z(16)*Z(421)
      Z(425) = Z(16)*Z(419) - Z(15)*Z(421)
      Z(427) = Z(18)*Z(425) - Z(17)*Z(423)
      Z(429) = -Z(17)*Z(425) - Z(18)*Z(423)
      Z(431) = Z(20)*Z(429) - Z(19)*Z(427)
      Z(435) = Z(7)*Z(427) + Z(8)*Z(429)
      Z(440) = -Z(78)*Z(29) - Z(79)*Z(405) - Z(80)*Z(419) - Z(81)*Z(423)
     & - Z(83)*Z(427) - Z(84)*Z(431) - Z(85)*Z(435) - Z(82)*Z(105) - 0.5
     &D0*Z(77)*Z(4) - 0.5D0*Z(86)*Z(42)
      Z(584) = MA*Z(440)
      Z(441) = Z(37)*U1 + Z(38)*U2
      Z(586) = MB*(Z(444)*Z(4)+Z(445)*Z(42)-Z(78)*Z(29)-Z(79)*Z(405)-Z(8
     &0)*Z(419)-Z(81)*Z(423)-Z(83)*Z(427)-Z(84)*Z(431)-Z(85)*Z(435)-Z(82
     &)*Z(105))
      Z(497) = Z(13)*Z(32) - Z(14)*Z(30)
      Z(499) = Z(13)*Z(30) + Z(14)*Z(32)
      Z(501) = -Z(15)*Z(497) - Z(16)*Z(499)
      Z(503) = Z(16)*Z(497) - Z(15)*Z(499)
      Z(505) = Z(18)*Z(503) - Z(17)*Z(501)
      Z(507) = -Z(17)*Z(503) - Z(18)*Z(501)
      Z(509) = Z(20)*Z(507) - Z(19)*Z(505)
      Z(513) = Z(7)*Z(505) + Z(8)*Z(507)
      Z(519) = -Z(79)*Z(10) - Z(80)*Z(497) - Z(81)*Z(501) - Z(83)*Z(505)
     & - Z(84)*Z(509) - Z(85)*Z(513) - Z(517)*Z(28) - Z(82)*Z(32) - 0.5D
     &0*Z(86)*Z(451) - 0.5D0*Z(516)*Z(6)
      Z(592) = MC*Z(519)
      Z(520) = Z(145)*U1 + Z(146)*U2 + Z(147)*U4 + Z(148)*U5 + Z(148)*U6
     & + Z(148)*U7 + Z(149)*U3
      Z(523) = -Z(15)*Z(177) - Z(16)*Z(175)
      Z(525) = Z(16)*Z(177) - Z(15)*Z(175)
      Z(527) = Z(18)*Z(525) - Z(17)*Z(523)
      Z(529) = -Z(17)*Z(525) - Z(18)*Z(523)
      Z(531) = Z(20)*Z(529) - Z(19)*Z(527)
      Z(535) = Z(7)*Z(527) + Z(8)*Z(529)
      Z(454) = Z(9)*Z(451) - Z(10)*Z(449)
      Z(540) = 0.5D0*Z(516)*Z(408) - Z(80)*Z(177) - Z(81)*Z(523) - Z(83)
     &*Z(527) - Z(84)*Z(531) - Z(85)*Z(535) - Z(517)*Z(404) - Z(538)*Z(1
     &0) - Z(82)*Z(12) - 0.5D0*Z(86)*Z(454)
      Z(594) = MD*Z(540)
      Z(541) = Z(159)*U1 + Z(160)*U2 + Z(161)*U4 + Z(162)*U5 + Z(163)*U6
     & + Z(163)*U7 + Z(164)*U3
      Z(544) = Z(16)*Z(17) - Z(15)*Z(18)
      Z(547) = Z(20)*Z(543) - Z(19)*Z(544)
      Z(551) = Z(7)*Z(544) + Z(8)*Z(543)
      Z(556) = Z(81)*Z(16) + Z(538)*Z(498) + Z(554)*Z(176) + 0.5D0*Z(516
     &)*Z(458) - Z(83)*Z(544) - Z(84)*Z(547) - Z(85)*Z(551) - Z(14)*Z(82
     &) - Z(517)*Z(420) - 0.5D0*Z(86)*Z(462)
      Z(596) = ME*Z(556)
      Z(557) = Z(178)*U1 + Z(179)*U2 + Z(180)*U4 + Z(181)*U5 + Z(182)*U6
     & + Z(183)*U7 + Z(184)*U3
      Z(560) = -Z(17)*Z(20) - Z(18)*Z(19)
      Z(118) = Z(1)*Z(61) + Z(2)*Z(62)
      Z(564) = Z(562)*Z(16) + Z(538)*Z(502) + Z(554)*Z(524) + 0.5D0*Z(51
     &6)*Z(466) - Z(83)*Z(18) - Z(84)*Z(560) - Z(85)*Z(413) - Z(517)*Z(4
     &24) - Z(82)*Z(118) - 0.5D0*Z(86)*Z(470)
      Z(598) = MF*Z(564)
      Z(565) = Z(204) + Z(197)*U1 + Z(198)*U2 + Z(199)*U4 + Z(200)*U5 + 
     &Z(201)*U6 + Z(202)*U7 + Z(203)*U3 - Z(196)*U8
      Z(548) = -Z(19)*Z(545) - Z(20)*Z(543)
      Z(561) = Z(17)*Z(20) + Z(18)*Z(19)
      Z(510) = -Z(19)*Z(506) - Z(20)*Z(504)
      Z(532) = -Z(19)*Z(528) - Z(20)*Z(526)
      Z(482) = -Z(19)*Z(474) - Z(20)*Z(472)
      Z(577) = -Z(7)*Z(20) - Z(8)*Z(19)
      Z(432) = -Z(19)*Z(428) - Z(20)*Z(426)
      Z(130) = Z(1)*Z(73) + Z(2)*Z(74)
      Z(486) = -Z(19)*Z(478) - Z(20)*Z(476)
      Z(580) = Z(562)*Z(548) + Z(569)*Z(561) + Z(538)*Z(510) + Z(554)*Z(
     &532) + 0.5D0*Z(516)*Z(482) - Z(85)*Z(577) - Z(578)*Z(20) - Z(517)*
     &Z(432) - Z(82)*Z(130) - 0.5D0*Z(86)*Z(486)
      Z(615) = MI*Z(580)
      Z(581) = Z(266) + Z(256)*U10 + Z(257)*U8 + Z(258)*U9 + Z(259)*U1 +
     & Z(260)*U2 + Z(261)*U4 + Z(262)*U5 + Z(263)*U6 + Z(264)*U7 + Z(265
     &)*U3
      Z(601) = MG*(Z(600)+2*Z(80)*Z(456)+2*Z(81)*Z(464)+2*Z(83)*Z(472)+2
     &*Z(84)*Z(480)+2*Z(85)*Z(488)-2*Z(567)-2*Z(443)*Z(3)-2*Z(538)*Z(5)-
     &2*Z(554)*Z(407)-2*Z(568)*Z(109))
      Z(602) = MG*(Z(86)*Z(449)+2*Z(80)*Z(496)+2*Z(81)*Z(500)+2*Z(83)*Z(
     &504)+2*Z(84)*Z(508)+2*Z(85)*Z(512)-2*Z(538)-2*Z(443)*Z(27)-2*Z(554
     &)*Z(9)-2*Z(567)*Z(5)-2*Z(568)*Z(30))
      Z(603) = MG*(Z(86)*Z(452)+2*Z(80)*Z(175)+2*Z(81)*Z(522)+2*Z(83)*Z(
     &526)+2*Z(84)*Z(530)+2*Z(85)*Z(534)-2*Z(554)-2*Z(443)*Z(403)-2*Z(53
     &8)*Z(9)-2*Z(567)*Z(407)-2*Z(568)*Z(11))
      Z(604) = MG*(2*Z(80)*Z(13)+Z(86)*Z(133)+2*Z(81)*Z(117)+2*Z(83)*Z(1
     &23)+2*Z(84)*Z(129)+2*Z(85)*Z(224)-2*Z(568)-2*Z(443)*Z(104)-2*Z(538
     &)*Z(30)-2*Z(554)*Z(11)-2*Z(567)*Z(109))
      Z(609) = MH*(2*Z(562)*Z(16)+2*Z(570)*Z(18)+2*Z(571)*Z(413)+2*Z(443
     &)*Z(424)+2*Z(538)*Z(502)+2*Z(554)*Z(524)+2*Z(567)*Z(466)-2*Z(84)*Z
     &(560)-2*Z(82)*Z(118)-Z(86)*Z(470))
      HZ = Z(415) + Z(416) + Z(417) + 0.5D0*Z(605) + INA*U3 + INB*U3 + I
     &NC*U3 + IND*U3 + INE*U3 + INE*U8 + INF*U3 + INF*U8 + INF*U9 + ING*
     &U3 + INH*U10 + INH*U3 + INH*U8 + INH*U9 + INI*U10 + INI*U11 + INI*
     &U3 + INI*U8 + INI*U9 + 0.5D0*Z(606)*U1 + Z(583)*Z(442) + Z(585)*Z(
     &446) + Z(591)*Z(521) + Z(593)*Z(542) + Z(595)*Z(558) + Z(597)*Z(56
     &6) + Z(614)*Z(582) + 0.5D0*Z(588)*Z(447) + 0.5D0*Z(590)*Z(448) + 0
     &.5D0*Z(599)*Z(374) + 0.5D0*Z(608)*Z(572) + 0.5D0*Z(611)*Z(573) + 0
     &.5D0*Z(613)*Z(574) - Z(414) - IND*U7 - 0.5D0*Z(607)*U2 - INC*(U6+U
     &7) - INB*(U5+U6+U7) - INA*(U4+U5+U6+U7) - Z(584)*Z(441) - Z(586)*Z
     &(441) - Z(592)*Z(520) - Z(594)*Z(541) - Z(596)*Z(557) - Z(598)*Z(5
     &65) - Z(615)*Z(581) - 0.5D0*Z(601)*Z(375) - 0.5D0*Z(602)*Z(376) - 
     &0.5D0*Z(603)*Z(377) - 0.5D0*Z(604)*Z(378) - 0.5D0*Z(609)*Z(565)
      Z(691) = MG*GSp
      Z(616) = MA*Z(37)
      Z(617) = MA*Z(38)
      Z(621) = MB*Z(37)
      Z(622) = MB*Z(38)
      Z(46) = Z(37)*Z(43) + Z(39)*Z(41)
      Z(713) = MH*Z(228)
      Z(69) = Z(7)*Z(65) - Z(8)*Z(63)
      Z(715) = MH*Z(229)
      Z(628) = MC*Z(145)
      Z(629) = MC*Z(146)
      Z(630) = MC*Z(147)
      Z(631) = MC*Z(148)
      Z(632) = MC*Z(149)
      Z(639) = MD*Z(159)
      Z(640) = MD*Z(160)
      Z(641) = MD*Z(161)
      Z(642) = MD*Z(162)
      Z(643) = MD*Z(163)
      Z(644) = MD*Z(164)
      Z(652) = ME*Z(178)
      Z(653) = ME*Z(179)
      Z(654) = ME*Z(180)
      Z(655) = ME*Z(181)
      Z(656) = ME*Z(182)
      Z(657) = ME*Z(183)
      Z(658) = ME*Z(184)
      Z(645) = MD*Z(165)
      Z(646) = MD*Z(166)
      Z(647) = MD*Z(167)
      Z(648) = MD*Z(168)
      Z(649) = MD*Z(169)
      Z(650) = MD*Z(171)
      Z(651) = MD*Z(172)
      Z(633) = MC*Z(150)
      Z(634) = MC*Z(151)
      Z(635) = MC*Z(152)
      Z(636) = MC*Z(153)
      Z(637) = MC*Z(155)
      Z(638) = MC*Z(156)
      Z(726) = MI*Z(266)
      Z(716) = MI*Z(256)
      Z(717) = MI*Z(257)
      Z(718) = MI*Z(258)
      Z(719) = MI*Z(259)
      Z(720) = MI*Z(260)
      Z(721) = MI*Z(261)
      Z(722) = MI*Z(262)
      Z(723) = MI*Z(263)
      Z(724) = MI*Z(264)
      Z(725) = MI*Z(265)
      Z(738) = MI*Z(284)
      Z(728) = MI*Z(280)
      Z(729) = MI*Z(282)
      Z(730) = MI*Z(283)
      Z(731) = MI*Z(269)
      Z(732) = MI*Z(270)
      Z(733) = MI*Z(271)
      Z(734) = MI*Z(272)
      Z(735) = MI*Z(273)
      Z(736) = MI*Z(274)
      Z(737) = MI*Z(281)
      Z(686) = MF*Z(218)
      Z(711) = MH*Z(222)
      Z(678) = MF*Z(217)
      Z(703) = MH*Z(221)
      Z(679) = MF*Z(205)
      Z(680) = MF*Z(206)
      Z(681) = MF*Z(207)
      Z(682) = MF*Z(208)
      Z(683) = MF*Z(209)
      Z(684) = MF*Z(210)
      Z(685) = MF*Z(216)
      Z(704) = MH*Z(205)
      Z(705) = MH*Z(206)
      Z(706) = MH*Z(207)
      Z(707) = MH*Z(208)
      Z(708) = MH*Z(209)
      Z(709) = MH*Z(210)
      Z(710) = MH*Z(220)
      Z(619) = MA*Z(39)
      Z(620) = MA*Z(40)
      Z(624) = MB*Z(39)
      Z(625) = MB*Z(40)
      Z(692) = MG*GS
      Z(667) = ME*Z(192)
      Z(660) = ME*Z(185)
      Z(661) = ME*Z(186)
      Z(662) = ME*Z(187)
      Z(663) = ME*Z(188)
      Z(664) = ME*Z(189)
      Z(665) = ME*Z(190)
      Z(666) = ME*Z(193)
      Z(675) = MF*Z(196)
      Z(700) = MH*Z(196)
      Z(676) = MF*Z(204)
      Z(701) = MH*Z(204)
      Z(668) = MF*Z(197)
      Z(669) = MF*Z(198)
      Z(670) = MF*Z(199)
      Z(671) = MF*Z(200)
      Z(672) = MF*Z(201)
      Z(673) = MF*Z(202)
      Z(674) = MF*Z(203)
      Z(693) = MH*Z(197)
      Z(694) = MH*Z(198)
      Z(695) = MH*Z(199)
      Z(696) = MH*Z(200)
      Z(697) = MH*Z(201)
      Z(698) = MH*Z(202)
      Z(699) = MH*Z(203)
      PX = Z(691)*Z(1) + MG*U1 + Z(37)*(Z(616)*U1+Z(617)*U2+Z(621)*U1+Z(
     &622)*U2) + 0.5D0*Z(627)*Z(46)*(U3-U5-U6-U7) + Z(65)*(Z(713)+Z(712)
     &*U10+Z(712)*U3+Z(712)*U8+Z(712)*U9) + Z(69)*(Z(715)+Z(714)*U10+Z(7
     &14)*U3+Z(714)*U8+Z(714)*U9) + 0.5D0*(Z(626)+2*Z(688))*Z(50)*(U3-U5
     &-U6-U7) + Z(33)*(Z(628)*U1+Z(629)*U2+Z(630)*U4+Z(631)*U5+Z(631)*U6
     &+Z(631)*U7+Z(632)*U3) + Z(52)*(Z(639)*U1+Z(640)*U2+Z(641)*U4+Z(642
     &)*U5+Z(643)*U6+Z(643)*U7+Z(644)*U3) + Z(56)*(Z(652)*U1+Z(653)*U2+Z
     &(654)*U4+Z(655)*U5+Z(656)*U6+Z(657)*U7+Z(658)*U3) + Z(54)*(Z(645)*
     &U1+Z(646)*U2+Z(647)*U4+Z(648)*U5+Z(649)*U6+Z(650)*U7+Z(651)*U3+Z(6
     &90)*(U3-U7)) + Z(35)*(Z(633)*U1+Z(634)*U2+Z(635)*U4+Z(636)*U5+Z(63
     &7)*U6+Z(637)*U7+Z(638)*U3+Z(689)*(U3-U6-U7)) + Z(71)*(Z(726)+Z(716
     &)*U10+Z(717)*U8+Z(718)*U9+Z(719)*U1+Z(720)*U2+Z(721)*U4+Z(722)*U5+
     &Z(723)*U6+Z(724)*U7+Z(725)*U3) + Z(73)*(Z(738)+Z(727)*U11+Z(728)*U
     &10+Z(729)*U8+Z(730)*U9+Z(731)*U1+Z(732)*U2+Z(733)*U4+Z(734)*U5+Z(7
     &35)*U6+Z(736)*U7+Z(737)*U3) + Z(61)*(Z(686)+Z(711)+Z(677)*U9+Z(702
     &)*U9+Z(678)*U8+Z(703)*U8+Z(679)*U1+Z(680)*U2+Z(681)*U4+Z(682)*U5+Z
     &(683)*U6+Z(684)*U7+Z(685)*U3+Z(704)*U1+Z(705)*U2+Z(706)*U4+Z(707)*
     &U5+Z(708)*U6+Z(709)*U7+Z(710)*U3) + Z(39)*(Z(618)*U4+Z(618)*U5+Z(6
     &18)*U6+Z(618)*U7+Z(623)*U4+Z(623)*U5+Z(623)*U6+Z(623)*U7+Z(619)*U1
     &+Z(620)*U2+Z(624)*U1+Z(625)*U2-Z(618)*U3-Z(623)*U3-Z(687)*(U3-U4-U
     &5-U6-U7)) - Z(692)*Z(2)*U3 - Z(58)*(Z(667)-Z(659)*U8-Z(660)*U1-Z(6
     &61)*U2-Z(662)*U4-Z(663)*U5-Z(664)*U6-Z(665)*U7-Z(666)*U3) - Z(59)*
     &(Z(675)*U8+Z(700)*U8-Z(676)-Z(701)-Z(668)*U1-Z(669)*U2-Z(670)*U4-Z
     &(671)*U5-Z(672)*U6-Z(673)*U7-Z(674)*U3-Z(693)*U1-Z(694)*U2-Z(695)*
     &U4-Z(696)*U5-Z(697)*U6-Z(698)*U7-Z(699)*U3)
      PY = Z(691)*Z(2) + MG*U2 + Z(692)*Z(1)*U3 + Z(38)*(Z(616)*U1+Z(617
     &)*U2+Z(621)*U1+Z(622)*U2) + 0.5D0*Z(627)*Z(47)*(U3-U5-U6-U7) + Z(6
     &6)*(Z(713)+Z(712)*U10+Z(712)*U3+Z(712)*U8+Z(712)*U9) + Z(70)*(Z(71
     &5)+Z(714)*U10+Z(714)*U3+Z(714)*U8+Z(714)*U9) + 0.5D0*(Z(626)+2*Z(6
     &88))*Z(51)*(U3-U5-U6-U7) + Z(34)*(Z(628)*U1+Z(629)*U2+Z(630)*U4+Z(
     &631)*U5+Z(631)*U6+Z(631)*U7+Z(632)*U3) + Z(53)*(Z(639)*U1+Z(640)*U
     &2+Z(641)*U4+Z(642)*U5+Z(643)*U6+Z(643)*U7+Z(644)*U3) + Z(57)*(Z(65
     &2)*U1+Z(653)*U2+Z(654)*U4+Z(655)*U5+Z(656)*U6+Z(657)*U7+Z(658)*U3)
     & + Z(55)*(Z(645)*U1+Z(646)*U2+Z(647)*U4+Z(648)*U5+Z(649)*U6+Z(650)
     &*U7+Z(651)*U3+Z(690)*(U3-U7)) + Z(36)*(Z(633)*U1+Z(634)*U2+Z(635)*
     &U4+Z(636)*U5+Z(637)*U6+Z(637)*U7+Z(638)*U3+Z(689)*(U3-U6-U7)) + Z(
     &72)*(Z(726)+Z(716)*U10+Z(717)*U8+Z(718)*U9+Z(719)*U1+Z(720)*U2+Z(7
     &21)*U4+Z(722)*U5+Z(723)*U6+Z(724)*U7+Z(725)*U3) + Z(74)*(Z(738)+Z(
     &727)*U11+Z(728)*U10+Z(729)*U8+Z(730)*U9+Z(731)*U1+Z(732)*U2+Z(733)
     &*U4+Z(734)*U5+Z(735)*U6+Z(736)*U7+Z(737)*U3) + Z(62)*(Z(686)+Z(711
     &)+Z(677)*U9+Z(702)*U9+Z(678)*U8+Z(703)*U8+Z(679)*U1+Z(680)*U2+Z(68
     &1)*U4+Z(682)*U5+Z(683)*U6+Z(684)*U7+Z(685)*U3+Z(704)*U1+Z(705)*U2+
     &Z(706)*U4+Z(707)*U5+Z(708)*U6+Z(709)*U7+Z(710)*U3) + Z(40)*(Z(618)
     &*U4+Z(618)*U5+Z(618)*U6+Z(618)*U7+Z(623)*U4+Z(623)*U5+Z(623)*U6+Z(
     &623)*U7+Z(619)*U1+Z(620)*U2+Z(624)*U1+Z(625)*U2-Z(618)*U3-Z(623)*U
     &3-Z(687)*(U3-U4-U5-U6-U7)) - Z(56)*(Z(667)-Z(659)*U8-Z(660)*U1-Z(6
     &61)*U2-Z(662)*U4-Z(663)*U5-Z(664)*U6-Z(665)*U7-Z(666)*U3) - Z(60)*
     &(Z(675)*U8+Z(700)*U8-Z(676)-Z(701)-Z(668)*U1-Z(669)*U2-Z(670)*U4-Z
     &(671)*U5-Z(672)*U6-Z(673)*U7-Z(674)*U3-Z(693)*U1-Z(694)*U2-Z(695)*
     &U4-Z(696)*U5-Z(697)*U6-Z(698)*U7-Z(699)*U3)
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
      Z(288) = L2 + Z(268)
      Z(750) = Z(749)*Z(56) + Z(257)*VRX1*Z(71) + Z(257)*VRY1*Z(72) + Z(
     &288)*VRX1*Z(73) + Z(288)*VRY1*Z(74) + Z(398)*(Z(257)*Z(72)+Z(282)*
     &Z(74)) + Z(399)*(Z(233)*Z(64)+Z(253)*Z(66)) - Z(395)*(Z(196)*Z(60)
     &-Z(217)*Z(62)) - Z(397)*(Z(196)*Z(60)-Z(24)*Z(66)-Z(25)*Z(70)-Z(22
     &1)*Z(62))
      Z(845) = Z(767) + Z(769) + Z(771) + Z(659)*Z(339) + MI*(Z(257)*Z(3
     &69)+Z(282)*Z(370)) + MH*(Z(24)*Z(352)+Z(25)*Z(353)+Z(812)*Z(353)+Z
     &(813)*Z(352)+Z(18)*Z(196)*Z(352)+Z(221)*Z(411)*Z(353)+Z(814)*Z(355
     &)+Z(221)*Z(351)+Z(25)*Z(411)*Z(351)+Z(25)*Z(412)*Z(350)+Z(196)*Z(4
     &11)*Z(356)-Z(17)*Z(221)*Z(352)-Z(196)*Z(412)*Z(353)-Z(815)*Z(356)-
     &Z(196)*Z(350)-Z(24)*Z(17)*Z(351)-Z(24)*Z(18)*Z(350)-Z(17)*Z(196)*Z
     &(355)-Z(18)*Z(221)*Z(355)-Z(221)*Z(413)*Z(356)) - Z(765) - MF*(Z(1
     &96)*Z(347)-Z(217)*Z(348))
      Z(881) = Z(750) - Z(845)
      Z(838) = Z(837) + Z(659)*Z(193) + MI*(Z(257)*Z(265)+Z(282)*Z(281))
     & - MF*(Z(196)*Z(203)-Z(217)*Z(216)) - MH*(Z(24)*Z(17)*Z(221)+Z(25)
     &*Z(196)*Z(412)+Z(196)*Z(203)+Z(24)*Z(17)*Z(220)+Z(24)*Z(18)*Z(203)
     &-2*Z(793)-Z(791)-Z(792)-Z(24)*Z(18)*Z(196)-Z(25)*Z(221)*Z(411)-Z(2
     &21)*Z(220)-Z(25)*Z(411)*Z(220)-Z(25)*Z(412)*Z(203))
      Z(839) = Z(659)*Z(185) + MI*(Z(257)*Z(259)+Z(282)*Z(269)) - MF*(Z(
     &196)*Z(197)-Z(217)*Z(205)) - MH*(Z(196)*Z(197)+Z(24)*Z(17)*Z(205)+
     &Z(24)*Z(18)*Z(197)-Z(221)*Z(205)-Z(25)*Z(411)*Z(205)-Z(25)*Z(412)*
     &Z(197))
      Z(840) = Z(659)*Z(186) + MI*(Z(257)*Z(260)+Z(282)*Z(270)) - MF*(Z(
     &196)*Z(198)-Z(217)*Z(206)) - MH*(Z(196)*Z(198)+Z(24)*Z(17)*Z(206)+
     &Z(24)*Z(18)*Z(198)-Z(221)*Z(206)-Z(25)*Z(411)*Z(206)-Z(25)*Z(412)*
     &Z(198))
      Z(841) = Z(659)*Z(187) + MI*(Z(257)*Z(261)+Z(282)*Z(271)) - MF*(Z(
     &196)*Z(199)-Z(217)*Z(207)) - MH*(Z(196)*Z(199)+Z(24)*Z(17)*Z(207)+
     &Z(24)*Z(18)*Z(199)-Z(221)*Z(207)-Z(25)*Z(411)*Z(207)-Z(25)*Z(412)*
     &Z(199))
      Z(842) = Z(659)*Z(188) + MI*(Z(257)*Z(262)+Z(282)*Z(272)) - MF*(Z(
     &196)*Z(200)-Z(217)*Z(208)) - MH*(Z(196)*Z(200)+Z(24)*Z(17)*Z(208)+
     &Z(24)*Z(18)*Z(200)-Z(221)*Z(208)-Z(25)*Z(411)*Z(208)-Z(25)*Z(412)*
     &Z(200))
      Z(843) = Z(659)*Z(189) + MI*(Z(257)*Z(263)+Z(282)*Z(273)) - MF*(Z(
     &196)*Z(201)-Z(217)*Z(209)) - MH*(Z(196)*Z(201)+Z(24)*Z(17)*Z(209)+
     &Z(24)*Z(18)*Z(201)-Z(221)*Z(209)-Z(25)*Z(411)*Z(209)-Z(25)*Z(412)*
     &Z(201))
      Z(844) = Z(659)*Z(190) + MI*(Z(257)*Z(264)+Z(282)*Z(274)) - MF*(Z(
     &196)*Z(202)-Z(217)*Z(210)) - MH*(Z(196)*Z(202)+Z(24)*Z(17)*Z(210)+
     &Z(24)*Z(18)*Z(202)-Z(221)*Z(210)-Z(25)*Z(411)*Z(210)-Z(25)*Z(412)*
     &Z(202))
      SHTOR = Z(881) - Z(838)*U3p - Z(839)*U1p - Z(840)*U2p - Z(841)*U4p
     & - Z(842)*U5p - Z(843)*U6p - Z(844)*U7p
      Z(849) = Z(846) + Z(677)*Z(216) + MI*(Z(258)*Z(265)+Z(283)*Z(281))
     & - MH*(Z(847)*Z(17)+Z(24)*Z(17)*Z(220)+Z(24)*Z(18)*Z(203)-2*Z(793)
     &-Z(791)-Z(792)-Z(848)*Z(411)-L8*Z(220)-Z(25)*Z(411)*Z(220)-Z(25)*Z
     &(412)*Z(203))
      Z(850) = Z(677)*Z(205) + MI*(Z(258)*Z(259)+Z(283)*Z(269)) - MH*(Z(
     &24)*Z(17)*Z(205)+Z(24)*Z(18)*Z(197)-L8*Z(205)-Z(25)*Z(411)*Z(205)-
     &Z(25)*Z(412)*Z(197))
      Z(851) = Z(677)*Z(206) + MI*(Z(258)*Z(260)+Z(283)*Z(270)) - MH*(Z(
     &24)*Z(17)*Z(206)+Z(24)*Z(18)*Z(198)-L8*Z(206)-Z(25)*Z(411)*Z(206)-
     &Z(25)*Z(412)*Z(198))
      Z(852) = Z(677)*Z(207) + MI*(Z(258)*Z(261)+Z(283)*Z(271)) - MH*(Z(
     &24)*Z(17)*Z(207)+Z(24)*Z(18)*Z(199)-L8*Z(207)-Z(25)*Z(411)*Z(207)-
     &Z(25)*Z(412)*Z(199))
      Z(853) = Z(677)*Z(208) + MI*(Z(258)*Z(262)+Z(283)*Z(272)) - MH*(Z(
     &24)*Z(17)*Z(208)+Z(24)*Z(18)*Z(200)-L8*Z(208)-Z(25)*Z(411)*Z(208)-
     &Z(25)*Z(412)*Z(200))
      Z(854) = Z(677)*Z(209) + MI*(Z(258)*Z(263)+Z(283)*Z(273)) - MH*(Z(
     &24)*Z(17)*Z(209)+Z(24)*Z(18)*Z(201)-L8*Z(209)-Z(25)*Z(411)*Z(209)-
     &Z(25)*Z(412)*Z(201))
      Z(855) = Z(677)*Z(210) + MI*(Z(258)*Z(264)+Z(283)*Z(274)) - MH*(Z(
     &24)*Z(17)*Z(210)+Z(24)*Z(18)*Z(202)-L8*Z(210)-Z(25)*Z(411)*Z(210)-
     &Z(25)*Z(412)*Z(202))
      Z(289) = L2 + Z(267)
      Z(752) = Z(751)*Z(62) + Z(258)*VRX1*Z(71) + Z(258)*VRY1*Z(72) + Z(
     &289)*VRX1*Z(73) + Z(289)*VRY1*Z(74) + Z(398)*(Z(258)*Z(72)+Z(283)*
     &Z(74)) + Z(399)*(Z(232)*Z(64)+Z(254)*Z(66)) + Z(397)*(L8*Z(62)+Z(2
     &4)*Z(66)+Z(25)*Z(70))
      Z(856) = Z(767) + Z(769) + Z(771) + Z(677)*Z(348) + MI*(Z(258)*Z(3
     &69)+Z(283)*Z(370)) - MH*(L8*Z(17)*Z(352)+Z(815)*Z(356)+L8*Z(18)*Z(
     &355)+L8*Z(413)*Z(356)+Z(24)*Z(17)*Z(351)+Z(24)*Z(18)*Z(350)-Z(24)*
     &Z(352)-Z(25)*Z(353)-Z(812)*Z(353)-Z(813)*Z(352)-L8*Z(411)*Z(353)-L
     &8*Z(351)-Z(814)*Z(355)-Z(25)*Z(411)*Z(351)-Z(25)*Z(412)*Z(350))
      Z(882) = Z(752) - Z(856)
      SKTOR = Z(849)*U3p + Z(850)*U1p + Z(851)*U2p + Z(852)*U4p + Z(853)
     &*U5p + Z(854)*U6p + Z(855)*U7p - Z(882)
      Z(858) = Z(857) + MI*(Z(256)*Z(265)+Z(280)*Z(281)) - MH*(Z(24)*Z(1
     &7)*Z(220)+Z(24)*Z(18)*Z(203)-2*Z(793)-Z(791)-Z(792)-Z(25)*Z(411)*Z
     &(220)-Z(25)*Z(412)*Z(203))
      Z(859) = MI*(Z(256)*Z(259)+Z(280)*Z(269)) - MH*(Z(24)*Z(17)*Z(205)
     &+Z(24)*Z(18)*Z(197)-Z(25)*Z(411)*Z(205)-Z(25)*Z(412)*Z(197))
      Z(860) = MI*(Z(256)*Z(260)+Z(280)*Z(270)) - MH*(Z(24)*Z(17)*Z(206)
     &+Z(24)*Z(18)*Z(198)-Z(25)*Z(411)*Z(206)-Z(25)*Z(412)*Z(198))
      Z(861) = MI*(Z(256)*Z(261)+Z(280)*Z(271)) - MH*(Z(24)*Z(17)*Z(207)
     &+Z(24)*Z(18)*Z(199)-Z(25)*Z(411)*Z(207)-Z(25)*Z(412)*Z(199))
      Z(862) = MI*(Z(256)*Z(262)+Z(280)*Z(272)) - MH*(Z(24)*Z(17)*Z(208)
     &+Z(24)*Z(18)*Z(200)-Z(25)*Z(411)*Z(208)-Z(25)*Z(412)*Z(200))
      Z(863) = MI*(Z(256)*Z(263)+Z(280)*Z(273)) - MH*(Z(24)*Z(17)*Z(209)
     &+Z(24)*Z(18)*Z(201)-Z(25)*Z(411)*Z(209)-Z(25)*Z(412)*Z(201))
      Z(864) = MI*(Z(256)*Z(264)+Z(280)*Z(274)) - MH*(Z(24)*Z(17)*Z(210)
     &+Z(24)*Z(18)*Z(202)-Z(25)*Z(411)*Z(210)-Z(25)*Z(412)*Z(202))
      Z(286) = L2 - Z(276)
      Z(753) = L6*Z(66)*Z(399) + Z(256)*VRX1*Z(71) + Z(256)*VRY1*Z(72) +
     & Z(286)*VRX1*Z(73) + Z(286)*VRY1*Z(74) + Z(397)*(Z(24)*Z(66)+Z(25)
     &*Z(70)) + Z(398)*(Z(256)*Z(72)+Z(280)*Z(74))
      Z(865) = Z(769) + Z(771) + MI*(Z(256)*Z(369)+Z(280)*Z(370)) - MH*(
     &Z(815)*Z(356)+Z(24)*Z(17)*Z(351)+Z(24)*Z(18)*Z(350)-Z(24)*Z(352)-Z
     &(25)*Z(353)-Z(812)*Z(353)-Z(813)*Z(352)-Z(814)*Z(355)-Z(25)*Z(411)
     &*Z(351)-Z(25)*Z(412)*Z(350))
      Z(883) = Z(753) - Z(865)
      SATOR = Z(858)*U3p + Z(859)*U1p + Z(860)*U2p + Z(861)*U4p + Z(862)
     &*U5p + Z(863)*U6p + Z(864)*U7p - Z(883)
      Z(866) = INI + Z(727)*Z(281)
      Z(867) = Z(727)*Z(269)
      Z(868) = Z(727)*Z(270)
      Z(869) = Z(727)*Z(271)
      Z(870) = Z(727)*Z(272)
      Z(871) = Z(727)*Z(273)
      Z(872) = Z(727)*Z(274)
      Z(755) = Z(754)*Z(74) + L2*(VRX1*Z(73)+VRY1*Z(74))
      Z(873) = Z(771) + Z(727)*Z(370)
      Z(884) = Z(755) - Z(873)
      SMTOR = Z(866)*U3p + Z(867)*U1p + Z(868)*U2p + Z(869)*U4p + Z(870)
     &*U5p + Z(871)*U6p + Z(872)*U7p - Z(884)
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
      POP12X = Q1 + L10*Z(52) + L11*Z(1) + L6*Z(48) + L8*Z(33) - L2*Z(37
     &)
      POP12Y = Q2 + L10*Z(53) + L11*Z(2) + L6*Z(49) + L8*Z(34) - L2*Z(38
     &)
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
      Z(306) = MG*GSp/Z(75)
      Z(307) = Z(80)*EAp
      Z(308) = Z(81)*(EAp-FAp)
      Z(309) = Z(83)*(FAp-EAp-HAp)
      Z(310) = Z(84)*(FAp-EAp-HAp-IAp)
      Z(311) = Z(85)*(FAp-EAp-HAp)
      Z(312) = Z(98)*EAp
      Z(313) = Z(99)*(EAp-FAp)
      Z(314) = Z(100)*(FAp-EAp-HAp)
      Z(315) = Z(101)*(FAp-EAp-HAp-IAp)
      Z(316) = Z(102)*(FAp-EAp-HAp)
      VOCMX = Z(306)*Z(1) + U1 + Z(79)*Z(54)*(U3-U7) + Z(78)*Z(35)*(U3-U
     &6-U7) + 0.5D0*Z(77)*Z(50)*(U3-U5-U6-U7) + 0.5D0*Z(86)*Z(46)*(U3-U5
     &-U6-U7) + Z(65)*(Z(309)+Z(83)*U10+Z(83)*U3+Z(83)*U8+Z(83)*U9) + Z(
     &69)*(Z(311)+Z(85)*U10+Z(85)*U3+Z(85)*U8+Z(85)*U9) + Z(73)*(Z(310)+
     &Z(84)*U10+Z(84)*U11+Z(84)*U3+Z(84)*U8+Z(84)*U9) - Z(82)*Z(2)*U3 - 
     &Z(58)*(Z(307)-Z(80)*U3-Z(80)*U8) - Z(76)*Z(39)*(U3-U4-U5-U6-U7) - 
     &Z(61)*(Z(308)-Z(81)*U3-Z(81)*U8-Z(81)*U9)
      VOCMY = Z(306)*Z(2) + U2 + Z(82)*Z(1)*U3 + Z(79)*Z(55)*(U3-U7) + Z
     &(78)*Z(36)*(U3-U6-U7) + 0.5D0*Z(77)*Z(51)*(U3-U5-U6-U7) + 0.5D0*Z(
     &86)*Z(47)*(U3-U5-U6-U7) + Z(66)*(Z(309)+Z(83)*U10+Z(83)*U3+Z(83)*U
     &8+Z(83)*U9) + Z(70)*(Z(311)+Z(85)*U10+Z(85)*U3+Z(85)*U8+Z(85)*U9) 
     &+ Z(74)*(Z(310)+Z(84)*U10+Z(84)*U11+Z(84)*U3+Z(84)*U8+Z(84)*U9) - 
     &Z(56)*(Z(307)-Z(80)*U3-Z(80)*U8) - Z(76)*Z(40)*(U3-U4-U5-U6-U7) - 
     &Z(62)*(Z(308)-Z(81)*U3-Z(81)*U8-Z(81)*U9)
      VOCMSTANCEX = U1 + Z(91)*Z(54)*(U3-U7) + Z(90)*Z(35)*(U3-U6-U7) + 
     &0.5D0*Z(89)*Z(50)*(U3-U5-U6-U7) + 0.5D0*Z(92)*Z(46)*(U3-U5-U6-U7) 
     &- Z(88)*Z(39)*(U3-U4-U5-U6-U7)
      VOCMSTANCEY = U2 + Z(91)*Z(55)*(U3-U7) + Z(90)*Z(36)*(U3-U6-U7) + 
     &0.5D0*Z(89)*Z(51)*(U3-U5-U6-U7) + 0.5D0*Z(92)*Z(47)*(U3-U5-U6-U7) 
     &- Z(88)*Z(40)*(U3-U4-U5-U6-U7)
      VOCMSWINGX = U1 + Z(97)*Z(54)*(U3-U7) + Z(96)*Z(35)*(U3-U6-U7) + Z
     &(95)*Z(50)*(U3-U5-U6-U7) + Z(65)*(Z(314)+Z(100)*U10+Z(100)*U3+Z(10
     &0)*U8+Z(100)*U9) + Z(69)*(Z(316)+Z(102)*U10+Z(102)*U3+Z(102)*U8+Z(
     &102)*U9) + Z(73)*(Z(315)+Z(101)*U10+Z(101)*U11+Z(101)*U3+Z(101)*U8
     &+Z(101)*U9) - Z(58)*(Z(312)-Z(98)*U3-Z(98)*U8) - Z(94)*Z(39)*(U3-U
     &4-U5-U6-U7) - Z(61)*(Z(313)-Z(99)*U3-Z(99)*U8-Z(99)*U9)
      VOCMSWINGY = U2 + Z(97)*Z(55)*(U3-U7) + Z(96)*Z(36)*(U3-U6-U7) + Z
     &(95)*Z(51)*(U3-U5-U6-U7) + Z(66)*(Z(314)+Z(100)*U10+Z(100)*U3+Z(10
     &0)*U8+Z(100)*U9) + Z(70)*(Z(316)+Z(102)*U10+Z(102)*U3+Z(102)*U8+Z(
     &102)*U9) + Z(74)*(Z(315)+Z(101)*U10+Z(101)*U11+Z(101)*U3+Z(101)*U8
     &+Z(101)*U9) - Z(56)*(Z(312)-Z(98)*U3-Z(98)*U8) - Z(94)*Z(40)*(U3-U
     &4-U5-U6-U7) - Z(62)*(Z(313)-Z(99)*U3-Z(99)*U8-Z(99)*U9)
      SAANG = HA
      SMANG = IA
      SAANGVEL = HAp
      SMANGVEL = IAp
      PSWINGX = Z(56)*(Z(652)*U1+Z(653)*U2+Z(654)*U4+Z(655)*U5+Z(656)*U6
     &+Z(657)*U7+Z(658)*U3) + Z(61)*(Z(686)+Z(677)*U9+Z(678)*U8+Z(679)*U
     &1+Z(680)*U2+Z(681)*U4+Z(682)*U5+Z(683)*U6+Z(684)*U7+Z(685)*U3) - Z
     &(58)*(Z(667)-Z(659)*U8-Z(660)*U1-Z(661)*U2-Z(662)*U4-Z(663)*U5-Z(6
     &64)*U6-Z(665)*U7-Z(666)*U3) - Z(59)*(Z(675)*U8-Z(676)-Z(668)*U1-Z(
     &669)*U2-Z(670)*U4-Z(671)*U5-Z(672)*U6-Z(673)*U7-Z(674)*U3)
      PSWINGY = Z(57)*(Z(652)*U1+Z(653)*U2+Z(654)*U4+Z(655)*U5+Z(656)*U6
     &+Z(657)*U7+Z(658)*U3) + Z(62)*(Z(686)+Z(677)*U9+Z(678)*U8+Z(679)*U
     &1+Z(680)*U2+Z(681)*U4+Z(682)*U5+Z(683)*U6+Z(684)*U7+Z(685)*U3) - Z
     &(56)*(Z(667)-Z(659)*U8-Z(660)*U1-Z(661)*U2-Z(662)*U4-Z(663)*U5-Z(6
     &64)*U6-Z(665)*U7-Z(666)*U3) - Z(60)*(Z(675)*U8-Z(676)-Z(668)*U1-Z(
     &669)*U2-Z(670)*U4-Z(671)*U5-Z(672)*U6-Z(673)*U7-Z(674)*U3)
      PSTANCEX = Z(37)*(Z(616)*U1+Z(617)*U2+Z(621)*U1+Z(622)*U2) + 0.5D0
     &*Z(626)*Z(50)*(U3-U5-U6-U7) + 0.5D0*Z(627)*Z(46)*(U3-U5-U6-U7) + Z
     &(33)*(Z(628)*U1+Z(629)*U2+Z(630)*U4+Z(631)*U5+Z(631)*U6+Z(631)*U7+
     &Z(632)*U3) + Z(35)*(Z(633)*U1+Z(634)*U2+Z(635)*U4+Z(636)*U5+Z(637)
     &*U6+Z(637)*U7+Z(638)*U3) + Z(52)*(Z(639)*U1+Z(640)*U2+Z(641)*U4+Z(
     &642)*U5+Z(643)*U6+Z(643)*U7+Z(644)*U3) + Z(54)*(Z(645)*U1+Z(646)*U
     &2+Z(647)*U4+Z(648)*U5+Z(649)*U6+Z(650)*U7+Z(651)*U3) - Z(39)*(Z(61
     &8)*U3+Z(623)*U3-Z(618)*U4-Z(618)*U5-Z(618)*U6-Z(618)*U7-Z(623)*U4-
     &Z(623)*U5-Z(623)*U6-Z(623)*U7-Z(619)*U1-Z(620)*U2-Z(624)*U1-Z(625)
     &*U2)
      PSTANCEY = Z(38)*(Z(616)*U1+Z(617)*U2+Z(621)*U1+Z(622)*U2) + 0.5D0
     &*Z(626)*Z(51)*(U3-U5-U6-U7) + 0.5D0*Z(627)*Z(47)*(U3-U5-U6-U7) + Z
     &(34)*(Z(628)*U1+Z(629)*U2+Z(630)*U4+Z(631)*U5+Z(631)*U6+Z(631)*U7+
     &Z(632)*U3) + Z(36)*(Z(633)*U1+Z(634)*U2+Z(635)*U4+Z(636)*U5+Z(637)
     &*U6+Z(637)*U7+Z(638)*U3) + Z(53)*(Z(639)*U1+Z(640)*U2+Z(641)*U4+Z(
     &642)*U5+Z(643)*U6+Z(643)*U7+Z(644)*U3) + Z(55)*(Z(645)*U1+Z(646)*U
     &2+Z(647)*U4+Z(648)*U5+Z(649)*U6+Z(650)*U7+Z(651)*U3) - Z(40)*(Z(61
     &8)*U3+Z(623)*U3-Z(618)*U4-Z(618)*U5-Z(618)*U6-Z(618)*U7-Z(623)*U4-
     &Z(623)*U5-Z(623)*U6-Z(623)*U7-Z(619)*U1-Z(620)*U2-Z(624)*U1-Z(625)
     &*U2)

C**   Write output to screen and to output file(s)
      WRITE(*, 6020) T,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,P
     &OP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,POP10X,
     &POP10Y,POP11X,POP11Y,POP12X,POP12Y
      WRITE(21,6020) T,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,P
     &OP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,POP10X,
     &POP10Y,POP11X,POP11Y,POP12X,POP12Y
      WRITE(22,6020) T,POGOX,POGOY,POCMSTANCEX,POCMSTANCEY,POCMSWINGX,PO
     &CMSWINGY,POCMX,POCMY,VOCMX,VOCMY,PSTANCEX,PSTANCEY,PSWINGX,PSWINGY
     &,VOCMSTANCEX,VOCMSTANCEY,VOCMSWINGX,VOCMSWINGY
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


