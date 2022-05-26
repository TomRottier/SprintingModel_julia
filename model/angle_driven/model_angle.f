C**   The name of this program is model/angle_driven/model_ang
     &le.f
C**   Created by AUTOLEV 3.2 on Thu May 26 19:12:47 2022

      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          ILOOP, IPRINT, PRINTINT
      CHARACTER        MESSAGE(99)
      EXTERNAL         EQNS1
      DIMENSION        VAR(6)
      COMMON/CONSTNTS/ FOOTANG,G,IFF,IHAT,IRF,ISH,ITH,K1,K2,K3,K4,K5,K6,
     &K7,K8,LFF,LFFO,LHAT,LMTPXI,LRF,LRFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,L
     &TOEXI,MFF,MHAT,MRF,MSH,MTH,MTPB,MTPK,RMTPXI,RTOEXI
      COMMON/SPECFIED/ HATO,LA,LH,LK,LMTP,RA,RH,RK,RMTP,HATOp,LAp,LHp,LK
     &p,LMTPp,RAp,RHp,RKp,RMTPp,HATOpp,LApp,LHpp,LKpp,LMTPpp,RApp,RHpp,R
     &Kpp,RMTPpp
      COMMON/VARIBLES/ Q1,Q2,Q3,U1,U2,U3
      COMMON/ALGBRAIC/ HZ,KECM,LATQ,LHTQ,LKTQ,LRX1,LRX2,LRY1,LRY2,PECM,P
     &X,PY,RATQ,RHTQ,RKTQ,RRX1,RRX2,RRY1,RRY2,TE,U4,U5,U6,U7,U8,U9,Q1p,Q
     &2p,Q3p,U1p,U2p,U3p,DLX1,DLX2,DRX1,DRX2,LMTQ,LRX,LRY,POCMX,POCMY,PO
     &HATOX,POHATOY,POP10X,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP1X,POP1
     &Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7
     &X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,RMTQ,RRX,RRY,VOCMX,VOCMY,VOP10X,VO
     &P10Y,VOP11X,VOP11Y,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(824),COEF(3,3),RHS(3)

C**   Open input and output files
      OPEN(UNIT=20, FILE='model/angle_driven/model_angle.in', STATUS='OL
     &D')
      OPEN(UNIT=21, FILE='model/angle_driven/model_angle.1',  STATUS='UN
     &KNOWN')
      OPEN(UNIT=22, FILE='model/angle_driven/model_angle.2',  STATUS='UN
     &KNOWN')
      OPEN(UNIT=23, FILE='model/angle_driven/model_angle.3',  STATUS='UN
     &KNOWN')
      OPEN(UNIT=24, FILE='model/angle_driven/model_angle.4',  STATUS='UN
     &KNOWN')
      OPEN(UNIT=25, FILE='model/angle_driven/model_angle.5',  STATUS='UN
     &KNOWN')
      OPEN(UNIT=26, FILE='model/angle_driven/model_angle.6',  STATUS='UN
     &KNOWN')

C**   Read message from input file
      READ(20,7000,END=7100,ERR=7101) (MESSAGE(ILOOP),ILOOP = 1,99)

C**   Read values of constants from input file
      READ(20,7010,END=7100,ERR=7101) FOOTANG,G,IFF,IHAT,IRF,ISH,ITH,K1,
     &K2,K3,K4,K5,K6,K7,K8,LFF,LFFO,LHAT,LMTPXI,LRF,LRFF,LRFFO,LRFO,LSH,
     &LSHO,LTH,LTHO,LTOEXI,MFF,MHAT,MRF,MSH,MTH,MTPB,MTPK,RMTPXI,RTOEXI

C**   Read the initial value of each variable from input file
      READ(20,7010,END=7100,ERR=7101) Q1,Q2,Q3,U1,U2,U3

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

C**   Evaluate constants
      U4 = 0
      U5 = 0
      U6 = 0
      U7 = 0
      U8 = 0
      U9 = 0
      Z(378) = G*MFF
      Z(725) = LFFO*Z(378)
      Z(379) = G*MRF
      Z(19) = COS(FOOTANG)
      Z(20) = SIN(FOOTANG)
      Z(68) = LFF - LFFO
      Z(69) = LRF - 0.5D0*LRFO
      Z(70) = LSH - LSHO
      Z(71) = LTH - LTHO
      Z(72) = MHAT + 2*MFF + 2*MRF + 2*MSH + 2*MTH
      Z(74) = MFF*Z(68)/Z(72)
      Z(75) = (LRF*MFF+MRF*Z(69))/Z(72)
      Z(76) = LRFFO*MRF/Z(72)
      Z(77) = (LSH*MFF+LSH*MRF+MSH*Z(70))/Z(72)
      Z(78) = (LTH*MFF+LTH*MRF+LTH*MSH+MTH*Z(71))/Z(72)
      Z(79) = (LFF*MFF+LFF*MHAT+LFFO*MFF+2*LFF*MRF+2*LFF*MSH+2*LFF*MTH)/
     &Z(72)
      Z(80) = (LRFO*MRF+2*LRF*MFF+2*LRF*MHAT+2*LRF*MRF+4*LRF*MSH+4*LRF*M
     &TH)/Z(72)
      Z(81) = (LSH*MFF+LSH*MHAT+LSH*MRF+LSH*MSH+LSHO*MSH+2*LSH*MTH)/Z(72
     &)
      Z(82) = (LTH*MFF+LTH*MHAT+LTH*MRF+LTH*MSH+LTH*MTH+LTHO*MTH)/Z(72)
      Z(377) = G*MHAT
      Z(380) = G*MSH
      Z(381) = G*MTH
      Z(411) = Z(79) - LFF
      Z(412) = 0.5D0*Z(80) - LRF
      Z(413) = Z(81) - LSH
      Z(414) = Z(82) - LTH
      Z(509) = LRF - Z(75)
      Z(510) = LSH - Z(77)
      Z(511) = LTH - Z(78)
      Z(512) = LFF - Z(79)
      Z(513) = LSH - Z(81)
      Z(514) = LTH - Z(82)
      Z(515) = 2*LRF - Z(80)
      Z(520) = LRF - 0.5D0*LRFO - Z(75)
      Z(521) = 0.5D0*Z(76) - 0.5D0*LRFFO
      Z(561) = 0.5D0*Z(80) - 0.5D0*LRFO
      Z(578) = Z(19)*Z(76)
      Z(584) = 2*Z(520) + 2*Z(19)*Z(521)
      Z(586) = 2*Z(521) + 2*Z(19)*Z(520)
      Z(598) = 2*Z(561) + 2*Z(19)*Z(521)
      Z(600) = 2*Z(521) + 2*Z(19)*Z(561)
      Z(608) = LFF*MHAT
      Z(610) = LRF*MHAT
      Z(612) = LSH*MHAT
      Z(614) = LTH*MHAT
      Z(636) = MRF*Z(69)
      Z(638) = LRFFO*MRF
      Z(648) = LSH*MRF
      Z(665) = MSH*Z(70)
      Z(680) = MTH*Z(71)
      Z(692) = LFFO*MFF
      Z(698) = LFF*MRF
      Z(700) = LRFO*MRF
      Z(728) = Z(71)*Z(381)
      Z(731) = Z(70)*Z(380)
      Z(754) = IHAT + 2*IFF + 2*IRF + 2*ISH + 2*ITH + MFF*LFFO**2
      Z(755) = LRFFO**2 + LRFO**2 + 4*LFF**2 + 2*LRFFO*LRFO*Z(19)
      Z(756) = LFF*LRFFO
      Z(757) = LFF*LRFO
      Z(758) = LRFFO**2 + 4*Z(69)**2
      Z(759) = LRFFO*Z(19)*Z(69)
      Z(760) = LFF**2 + LRF**2 + LSH**2 + LTH**2
      Z(761) = LFF*LRF
      Z(762) = LFF*LSH
      Z(763) = LFF*LTH
      Z(764) = LRF*LSH
      Z(765) = LRF*LTH
      Z(766) = LSH*LTH
      Z(768) = LRFFO*Z(19)
      Z(769) = LRFO*Z(19)
      Z(770) = LRFFO*Z(20)
      Z(771) = LRFO*Z(20)
      Z(772) = Z(19)*Z(69)
      Z(773) = Z(20)*Z(69)
      Z(775) = IFF + IRF + ISH + ITH + MFF*LFFO**2
      Z(780) = IFF + IRF + ISH + ITH
      Z(785) = IFF + IRF + ISH + MFF*LFFO**2
      Z(786) = LFF**2 + LRF**2 + LSH**2
      Z(791) = IFF + IRF + ISH
      Z(792) = LSH*Z(69)
      Z(793) = LRFFO*LSH
      Z(798) = IFF + IRF + MFF*LFFO**2
      Z(799) = LFF**2 + LRF**2
      Z(804) = IFF + IRF

C**   Initialize time, print counter, variables array for integrator
      T      = TINITIAL
      IPRINT = 0
      VAR(1) = Q1
      VAR(2) = Q2
      VAR(3) = Q3
      VAR(4) = U1
      VAR(5) = U2
      VAR(6) = U3

C**   Initalize numerical integrator with call to EQNS1 at T=TINITIAL
      CALL KUTTA(EQNS1, 6, VAR, T, INTEGSTP, ABSERR, RELERR, 0, *5920)

C**   Numerically integrate; print results
5900  IF( TFINAL.GE.TINITIAL .AND. T+.01D0*INTEGSTP.GE.TFINAL) IPRINT=-7
      IF( TFINAL.LE.TINITIAL .AND. T+.01D0*INTEGSTP.LE.TFINAL) IPRINT=-7
      IF( IPRINT .LE. 0 ) THEN
        CALL IO(T)
        IF( IPRINT .EQ. -7 ) GOTO 5930
        IPRINT = PRINTINT
      ENDIF
      CALL KUTTA(EQNS1, 6, VAR, T, INTEGSTP, ABSERR, RELERR, 1, *5920)
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

6021  FORMAT(1X,'FILE: model/angle_driven/model_angle.1 ',//1X,'*** ',99
     &A1,///,8X,'T',12X,'POP1X',10X,'POP1Y',10X,'POP2X',10X,'POP2Y',10X,
     &'POP3X',10X,'POP3Y',10X,'POP4X',10X,'POP4Y',10X,'POP5X',10X,'POP5Y
     &',10X,'POP6X',10X,'POP6Y',10X,'POP7X',10X,'POP7Y',10X,'POP8X',10X,
     &'POP8Y',10X,'POP9X',10X,'POP9Y',9X,'POP10X',9X,'POP10Y',9X,'POP11X
     &',9X,'POP11Y',9X,'POP12X',9X,'POP12Y',9X,'POHATOX',8X,'POHATOY',9X
     &,'POCMX',10X,'POCMY',10X,'VOCMX',10X,'VOCMY',/,7X,'(S)',12X,'(M)',
     &12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(
     &M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12
     &X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)',12X,'(M)
     &',12X,'(M)',10X,'(UNITS)',8X,'(UNITS)',10X,'(M)',12X,'(M)',12X,'(M
     &)',12X,'(M)',11X,'(M/S)',10X,'(M/S)',/)
6022  FORMAT(1X,'FILE: model/angle_driven/model_angle.2 ',//1X,'*** ',99
     &A1,///,8X,'T',13X,'Q1',13X,'Q2',13X,'Q3',13X,'U1',13X,'U2',13X,'U3
     &',/,7X,'(S)',12X,'(M)',12X,'(M)',11X,'(DEG)',10X,'(M/S)',10X,'(M/S
     &)',9X,'(DEG/S)',/)
6023  FORMAT(1X,'FILE: model/angle_driven/model_angle.3 ',//1X,'*** ',99
     &A1,///,8X,'T',13X,'RRX',12X,'RRY',12X,'LRX',12X,'LRY',11X,'RRX1',1
     &1X,'RRY1',11X,'RRX2',11X,'RRY2',11X,'LRX1',11X,'LRX2',11X,'LRY1',1
     &1X,'LRY2',/,7X,'(S)',10X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(
     &UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(U
     &NITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6024  FORMAT(1X,'FILE: model/angle_driven/model_angle.4 ',//1X,'*** ',99
     &A1,///,8X,'T',12X,'RHTQ',11X,'LHTQ',11X,'RKTQ',11X,'LKTQ',11X,'RAT
     &Q',11X,'LATQ',11X,'RMTQ',11X,'LMTQ',/,7X,'(S)',10X,'(UNITS)',8X,'(
     &UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(U
     &NITS)',8X,'(UNITS)',/)
6025  FORMAT(1X,'FILE: model/angle_driven/model_angle.5 ',//1X,'*** ',99
     &A1,///,8X,'T',13X,'RH',13X,'LH',13X,'RK',13X,'LK',13X,'RA',13X,'LA
     &',12X,'RMTP',11X,'LMTP',12X,'RH''',12X,'LH''',12X,'RK''',12X,'LK''
     &',12X,'RA''',12X,'LA''',11X,'RMTP''',10X,'LMTP''',10X,'RH''''',11X
     &,'LH''''',11X,'RK''''',11X,'LK''''',11X,'RA''''',11X,'LA''''',10X,
     &'RMTP''''',9X,'LMTP''''',/,7X,'(S)',10X,'(UNITS)',8X,'(UNITS)',8X,
     &'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'
     &(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(
     &UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(U
     &NITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UN
     &ITS)',8X,'(UNITS)',/)
6026  FORMAT(1X,'FILE: model/angle_driven/model_angle.6 ',//1X,'*** ',99
     &A1,///,8X,'T',12X,'KECM',11X,'PECM',12X,'TE',13X,'HZ',13X,'PX',13X
     &,'PY',/,7X,'(S)',12X,'(J)',12X,'(J)',12X,'(J)',8X,'(KG.M^2/S)',6X,
     &'(KG.M/S)',7X,'(KG.M/S)',/)
6997  FORMAT(/7X,'Error: Numerical integration failed to converge',/)
6999  FORMAT(//1X,'Input is in the file model/angle_driven/model_angle.i
     &n',//1X,'Output is in the file(s) model/angle_driven/model_angle.i
     &  (i=1, ..., 6)',//1X,'The output quantities and associated files 
     &are listed in file model/angle_driven/model_angle.dir',/)
7000  FORMAT(//,99A1,///)
7010  FORMAT( 1000(59X,E30.0,/) )
7011  FORMAT( 3(59X,E30.0,/), 1(59X,I30,/), 2(59X,E30.0,/) )
      STOP
7100  WRITE(*,*) 'Premature end of file while reading model/angle_driven
     &/model_angle.in '
7101  WRITE(*,*) 'Error while reading file model/angle_driven/model_angl
     &e.in'
      STOP
      END


C**********************************************************************
      SUBROUTINE       EQNS1(T, VAR, VARp, BOUNDARY)
      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          BOUNDARY
      DIMENSION        VAR(*), VARp(*)
      COMMON/CONSTNTS/ FOOTANG,G,IFF,IHAT,IRF,ISH,ITH,K1,K2,K3,K4,K5,K6,
     &K7,K8,LFF,LFFO,LHAT,LMTPXI,LRF,LRFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,L
     &TOEXI,MFF,MHAT,MRF,MSH,MTH,MTPB,MTPK,RMTPXI,RTOEXI
      COMMON/SPECFIED/ HATO,LA,LH,LK,LMTP,RA,RH,RK,RMTP,HATOp,LAp,LHp,LK
     &p,LMTPp,RAp,RHp,RKp,RMTPp,HATOpp,LApp,LHpp,LKpp,LMTPpp,RApp,RHpp,R
     &Kpp,RMTPpp
      COMMON/VARIBLES/ Q1,Q2,Q3,U1,U2,U3
      COMMON/ALGBRAIC/ HZ,KECM,LATQ,LHTQ,LKTQ,LRX1,LRX2,LRY1,LRY2,PECM,P
     &X,PY,RATQ,RHTQ,RKTQ,RRX1,RRX2,RRY1,RRY2,TE,U4,U5,U6,U7,U8,U9,Q1p,Q
     &2p,Q3p,U1p,U2p,U3p,DLX1,DLX2,DRX1,DRX2,LMTQ,LRX,LRY,POCMX,POCMY,PO
     &HATOX,POHATOY,POP10X,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP1X,POP1
     &Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7
     &X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,RMTQ,RRX,RRY,VOCMX,VOCMY,VOP10X,VO
     &P10Y,VOP11X,VOP11Y,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(824),COEF(3,3),RHS(3)

C**   Update variables after integration step
      Q1 = VAR(1)
      Q2 = VAR(2)
      Q3 = VAR(3)
      U1 = VAR(4)
      U2 = VAR(5)
      U3 = VAR(6)

      Q1p = U1
      Q2p = U2
      Q3p = U3
      RRY1 = -K3*Q2 - K4*ABS(Q2)*U2
      DRX1 = Q1 - RTOEXI
      RRX1 = -RRY1*(K1*DRX1+K2*U1)
      Z(1) = COS(Q3)
      Z(2) = SIN(Q3)

C**   Quantities to be specified
      HATO = 0
      LA = 0
      LH = 0
      LK = 0
      LMTP = 0
      RA = 0
      RH = 0
      RK = 0
      RMTP = 0
      HATOp = 0
      LAp = 0
      LHp = 0
      LKp = 0
      LMTPp = 0
      RAp = 0
      RHp = 0
      RKp = 0
      RMTPp = 0
      HATOpp = 0
      LApp = 0
      LHpp = 0
      LKpp = 0
      LMTPpp = 0
      RApp = 0
      RHpp = 0
      RKpp = 0
      RMTPpp = 0

      Z(11) = COS(RA)
      Z(15) = COS(RMTP)
      Z(12) = SIN(RA)
      Z(16) = SIN(RMTP)
      Z(21) = Z(11)*Z(15) - Z(12)*Z(16)
      Z(3) = COS(RH)
      Z(7) = COS(RK)
      Z(4) = SIN(RH)
      Z(8) = SIN(RK)
      Z(24) = Z(3)*Z(7) - Z(4)*Z(8)
      Z(25) = Z(3)*Z(8) + Z(4)*Z(7)
      Z(28) = Z(24)*Z(2) + Z(25)*Z(1)
      Z(22) = Z(11)*Z(16) + Z(12)*Z(15)
      Z(26) = -Z(3)*Z(8) - Z(4)*Z(7)
      Z(30) = Z(24)*Z(1) + Z(26)*Z(2)
      Z(32) = Z(21)*Z(28) + Z(22)*Z(30)
      POP2Y = Q2 - LFF*Z(32)
      Z(27) = Z(24)*Z(1) - Z(25)*Z(2)
      Z(29) = Z(26)*Z(1) - Z(24)*Z(2)
      Z(31) = Z(21)*Z(27) + Z(22)*Z(29)
      Z(23) = -Z(11)*Z(16) - Z(12)*Z(15)
      Z(34) = Z(21)*Z(30) + Z(23)*Z(28)
      Z(117) = RAp + RHp + RKp + RMTPp
      Z(119) = LFF*Z(117)
      Z(33) = Z(21)*Z(29) + Z(23)*Z(27)
      VOP2Y = Z(32)*(Z(31)*U1+Z(32)*U2) - Z(34)*(Z(119)+LFF*U3+LFF*U4+LF
     &F*U6+LFF*U8-Z(33)*U1-Z(34)*U2)
      RRY2 = -K7*POP2Y - K8*ABS(POP2Y)*VOP2Y
      POP2X = Q1 - LFF*Z(31)
      DRX2 = POP2X - RMTPXI
      VOP2X = Z(31)*(Z(31)*U1+Z(32)*U2) - Z(33)*(Z(119)+LFF*U3+LFF*U4+LF
     &F*U6+LFF*U8-Z(33)*U1-Z(34)*U2)
      RRX2 = -RRY2*(K5*DRX2+K6*VOP2X)
      Z(17) = COS(LMTP)
      Z(13) = COS(LA)
      Z(9) = COS(LK)
      Z(5) = COS(LH)
      Z(6) = SIN(LH)
      Z(50) = Z(5)*Z(2) + Z(6)*Z(1)
      Z(10) = SIN(LK)
      Z(49) = Z(5)*Z(1) - Z(6)*Z(2)
      Z(53) = Z(9)*Z(50) + Z(10)*Z(49)
      Z(14) = SIN(LA)
      Z(55) = Z(9)*Z(49) - Z(10)*Z(50)
      Z(57) = Z(13)*Z(53) + Z(14)*Z(55)
      Z(18) = SIN(LMTP)
      Z(59) = Z(13)*Z(55) - Z(14)*Z(53)
      Z(65) = Z(17)*Z(57) + Z(18)*Z(59)
      Z(43) = Z(11)*Z(28) + Z(12)*Z(30)
      Z(47) = Z(3)*Z(2) + Z(4)*Z(1)
      POP11Y = Q2 + LFF*Z(65) + LRF*Z(57) + LSH*Z(53) + LTH*Z(50) - LFF*
     &Z(32) - LRF*Z(43) - LSH*Z(28) - LTH*Z(47)
      Z(169) = Z(3)*Z(5) + Z(4)*Z(6)
      Z(130) = Z(16)*Z(119)
      Z(134) = Z(15)*Z(119)
      Z(135) = LRF*Z(117)
      Z(137) = -Z(134) - Z(135)
      Z(141) = Z(11)*Z(130) - Z(12)*Z(137)
      Z(145) = Z(11)*Z(137) + Z(12)*Z(130)
      Z(146) = RHp + RKp
      Z(150) = LSH*Z(146)
      Z(152) = Z(145) - Z(150)
      Z(157) = Z(7)*Z(141) - Z(8)*Z(152)
      Z(171) = Z(3)*Z(6) - Z(4)*Z(5)
      Z(162) = Z(7)*Z(152) + Z(8)*Z(141)
      Z(166) = LTH*RHp
      Z(168) = Z(162) - Z(166)
      Z(177) = Z(169)*Z(157) + Z(171)*Z(168)
      Z(170) = Z(4)*Z(5) - Z(3)*Z(6)
      Z(183) = Z(169)*Z(168) + Z(170)*Z(157)
      Z(187) = LTH*LHp
      Z(189) = Z(183) + Z(187)
      Z(197) = Z(9)*Z(177) + Z(10)*Z(189)
      Z(205) = Z(9)*Z(189) - Z(10)*Z(177)
      Z(206) = LHp + LKp
      Z(211) = LSH*Z(206)
      Z(214) = Z(205) + Z(211)
      Z(230) = Z(13)*Z(197) + Z(14)*Z(214)
      Z(239) = Z(13)*Z(214) - Z(14)*Z(197)
      Z(215) = LAp + LHp + LKp
      Z(240) = LRF*Z(215)
      Z(244) = Z(239) + Z(240)
      Z(254) = Z(17)*Z(230) + Z(18)*Z(244)
      Z(129) = LFF*Z(16)
      Z(133) = LFF*Z(15)
      Z(136) = -LRF - Z(133)
      Z(138) = Z(11)*Z(129) - Z(12)*Z(136)
      Z(142) = Z(11)*Z(136) + Z(12)*Z(129)
      Z(151) = Z(142) - LSH
      Z(153) = Z(7)*Z(138) - Z(8)*Z(151)
      Z(159) = Z(7)*Z(151) + Z(8)*Z(138)
      Z(167) = Z(159) - LTH
      Z(172) = Z(153)*Z(169) + Z(167)*Z(171)
      Z(180) = Z(153)*Z(170) + Z(167)*Z(169)
      Z(188) = LTH + Z(180)
      Z(190) = Z(9)*Z(172) + Z(10)*Z(188)
      Z(202) = Z(9)*Z(188) - Z(10)*Z(172)
      Z(212) = LSH + Z(202)
      Z(222) = Z(13)*Z(190) + Z(14)*Z(212)
      Z(235) = Z(13)*Z(212) - Z(14)*Z(190)
      Z(241) = LRF + Z(235)
      Z(245) = Z(17)*Z(222) + Z(18)*Z(241)
      Z(191) = Z(9)*Z(172) + Z(10)*Z(180)
      Z(201) = Z(9)*Z(180) - Z(10)*Z(172)
      Z(223) = Z(13)*Z(191) + Z(14)*Z(201)
      Z(234) = Z(13)*Z(201) - Z(14)*Z(191)
      Z(246) = Z(17)*Z(223) + Z(18)*Z(234)
      Z(173) = Z(153)*Z(169) + Z(159)*Z(171)
      Z(179) = Z(153)*Z(170) + Z(159)*Z(169)
      Z(192) = Z(9)*Z(173) + Z(10)*Z(179)
      Z(200) = Z(9)*Z(179) - Z(10)*Z(173)
      Z(224) = Z(13)*Z(192) + Z(14)*Z(200)
      Z(233) = Z(13)*Z(200) - Z(14)*Z(192)
      Z(247) = Z(17)*Z(224) + Z(18)*Z(233)
      Z(154) = Z(7)*Z(138) - Z(8)*Z(142)
      Z(158) = Z(7)*Z(142) + Z(8)*Z(138)
      Z(174) = Z(154)*Z(169) + Z(158)*Z(171)
      Z(178) = Z(154)*Z(170) + Z(158)*Z(169)
      Z(193) = Z(9)*Z(174) + Z(10)*Z(178)
      Z(199) = Z(9)*Z(178) - Z(10)*Z(174)
      Z(225) = Z(13)*Z(193) + Z(14)*Z(199)
      Z(232) = Z(13)*Z(199) - Z(14)*Z(193)
      Z(248) = Z(17)*Z(225) + Z(18)*Z(232)
      Z(196) = LTH*Z(10)
      Z(198) = LTH*Z(9)
      Z(213) = LSH + Z(198)
      Z(226) = Z(13)*Z(196) + Z(14)*Z(213)
      Z(236) = Z(13)*Z(213) - Z(14)*Z(196)
      Z(242) = LRF + Z(236)
      Z(249) = Z(17)*Z(226) + Z(18)*Z(242)
      Z(229) = LSH*Z(14)
      Z(231) = LSH*Z(13)
      Z(243) = LRF + Z(231)
      Z(250) = Z(17)*Z(229) + Z(18)*Z(243)
      Z(253) = LRF*Z(18)
      Z(127) = Z(15)*Z(31) - Z(16)*Z(33)
      Z(131) = Z(15)*Z(33) + Z(16)*Z(31)
      Z(139) = Z(11)*Z(127) - Z(12)*Z(131)
      Z(143) = Z(11)*Z(131) + Z(12)*Z(127)
      Z(155) = Z(7)*Z(139) - Z(8)*Z(143)
      Z(160) = Z(7)*Z(143) + Z(8)*Z(139)
      Z(175) = Z(169)*Z(155) + Z(171)*Z(160)
      Z(181) = Z(169)*Z(160) + Z(170)*Z(155)
      Z(194) = Z(9)*Z(175) + Z(10)*Z(181)
      Z(203) = Z(9)*Z(181) - Z(10)*Z(175)
      Z(227) = Z(13)*Z(194) + Z(14)*Z(203)
      Z(237) = Z(13)*Z(203) - Z(14)*Z(194)
      Z(251) = Z(17)*Z(227) + Z(18)*Z(237)
      Z(128) = Z(15)*Z(32) - Z(16)*Z(34)
      Z(132) = Z(15)*Z(34) + Z(16)*Z(32)
      Z(140) = Z(11)*Z(128) - Z(12)*Z(132)
      Z(144) = Z(11)*Z(132) + Z(12)*Z(128)
      Z(156) = Z(7)*Z(140) - Z(8)*Z(144)
      Z(161) = Z(7)*Z(144) + Z(8)*Z(140)
      Z(176) = Z(169)*Z(156) + Z(171)*Z(161)
      Z(182) = Z(169)*Z(161) + Z(170)*Z(156)
      Z(195) = Z(9)*Z(176) + Z(10)*Z(182)
      Z(204) = Z(9)*Z(182) - Z(10)*Z(176)
      Z(228) = Z(13)*Z(195) + Z(14)*Z(204)
      Z(238) = Z(13)*Z(204) - Z(14)*Z(195)
      Z(252) = Z(17)*Z(228) + Z(18)*Z(238)
      Z(67) = Z(17)*Z(59) - Z(18)*Z(57)
      Z(264) = Z(17)*Z(244) - Z(18)*Z(230)
      Z(265) = LAp + LHp + LKp + LMTPp
      Z(272) = LFF*Z(265)
      Z(277) = Z(264) + Z(272)
      Z(256) = Z(17)*Z(232) - Z(18)*Z(225)
      Z(257) = Z(17)*Z(233) - Z(18)*Z(224)
      Z(258) = Z(17)*Z(234) - Z(18)*Z(223)
      Z(259) = Z(17)*Z(241) - Z(18)*Z(222)
      Z(273) = LFF + Z(259)
      Z(260) = Z(17)*Z(242) - Z(18)*Z(226)
      Z(274) = LFF + Z(260)
      Z(261) = Z(17)*Z(243) - Z(18)*Z(229)
      Z(275) = LFF + Z(261)
      Z(255) = LRF*Z(17)
      Z(276) = LFF + Z(255)
      Z(262) = Z(17)*Z(237) - Z(18)*Z(227)
      Z(263) = Z(17)*Z(238) - Z(18)*Z(228)
      VOP11Y = Z(65)*(Z(254)+Z(245)*U3+Z(246)*U4+Z(247)*U6+Z(248)*U8+Z(2
     &49)*U5+Z(250)*U7+Z(253)*U9+Z(251)*U1+Z(252)*U2) + Z(67)*(Z(277)+Z(
     &256)*U8+Z(257)*U6+Z(258)*U4+Z(273)*U3+Z(274)*U5+Z(275)*U7+Z(276)*U
     &9+Z(262)*U1+Z(263)*U2)
      LRY1 = -K3*POP11Y - K4*ABS(POP11Y)*VOP11Y
      Z(51) = -Z(5)*Z(2) - Z(6)*Z(1)
      Z(52) = Z(9)*Z(49) + Z(10)*Z(51)
      Z(54) = Z(9)*Z(51) - Z(10)*Z(49)
      Z(56) = Z(13)*Z(52) + Z(14)*Z(54)
      Z(58) = Z(13)*Z(54) - Z(14)*Z(52)
      Z(64) = Z(17)*Z(56) + Z(18)*Z(58)
      Z(42) = Z(11)*Z(27) + Z(12)*Z(29)
      Z(46) = Z(3)*Z(1) - Z(4)*Z(2)
      POP11X = Q1 + LFF*Z(64) + LRF*Z(56) + LSH*Z(52) + LTH*Z(49) - LFF*
     &Z(31) - LRF*Z(42) - LSH*Z(27) - LTH*Z(46)
      DLX1 = POP11X - LTOEXI
      Z(66) = Z(17)*Z(58) - Z(18)*Z(56)
      VOP11X = Z(64)*(Z(254)+Z(245)*U3+Z(246)*U4+Z(247)*U6+Z(248)*U8+Z(2
     &49)*U5+Z(250)*U7+Z(253)*U9+Z(251)*U1+Z(252)*U2) + Z(66)*(Z(277)+Z(
     &256)*U8+Z(257)*U6+Z(258)*U4+Z(273)*U3+Z(274)*U5+Z(275)*U7+Z(276)*U
     &9+Z(262)*U1+Z(263)*U2)
      LRX1 = -LRY1*(K1*DLX1+K2*VOP11X)
      POP10Y = Q2 + LRF*Z(57) + LSH*Z(53) + LTH*Z(50) - LFF*Z(32) - LRF*
     &Z(43) - LSH*Z(28) - LTH*Z(47)
      VOP10Y = Z(57)*(Z(230)+Z(222)*U3+Z(223)*U4+Z(224)*U6+Z(225)*U8+Z(2
     &26)*U5+Z(229)*U7+Z(227)*U1+Z(228)*U2) + Z(59)*(Z(244)+LRF*U9+Z(232
     &)*U8+Z(233)*U6+Z(234)*U4+Z(241)*U3+Z(242)*U5+Z(243)*U7+Z(237)*U1+Z
     &(238)*U2)
      LRY2 = -K7*POP10Y - K8*ABS(POP10Y)*VOP10Y
      POP10X = Q1 + LRF*Z(56) + LSH*Z(52) + LTH*Z(49) - LFF*Z(31) - LRF*
     &Z(42) - LSH*Z(27) - LTH*Z(46)
      DLX2 = POP10X - LMTPXI
      VOP10X = Z(56)*(Z(230)+Z(222)*U3+Z(223)*U4+Z(224)*U6+Z(225)*U8+Z(2
     &26)*U5+Z(229)*U7+Z(227)*U1+Z(228)*U2) + Z(58)*(Z(244)+LRF*U9+Z(232
     &)*U8+Z(233)*U6+Z(234)*U4+Z(241)*U3+Z(242)*U5+Z(243)*U7+Z(237)*U1+Z
     &(238)*U2)
      LRX2 = -LRY2*(K5*DLX2+K6*VOP10X)
      Z(35) = Z(19)*Z(11) - Z(20)*Z(12)
      Z(37) = -Z(19)*Z(12) - Z(20)*Z(11)
      Z(41) = Z(35)*Z(30) + Z(37)*Z(28)
      Z(44) = Z(11)*Z(29) - Z(12)*Z(27)
      Z(45) = Z(11)*Z(30) - Z(12)*Z(28)
      Z(48) = -Z(3)*Z(2) - Z(4)*Z(1)
      Z(63) = Z(19)*Z(59) - Z(20)*Z(57)
      Z(83) = RHp + U4
      Z(84) = LHp + U5
      Z(86) = RHpp + RKpp
      Z(88) = LHpp + LKpp
      Z(94) = RApp + RHpp + RKpp
      Z(96) = Z(1)*Z(44) + Z(2)*Z(45)
      Z(97) = Z(1)*Z(43) - Z(2)*Z(42)
      Z(98) = Z(1)*Z(45) - Z(2)*Z(44)
      Z(100) = LApp + LHpp + LKpp
      Z(106) = RApp + RHpp + RKpp + RMTPpp
      Z(108) = Z(1)*Z(33) + Z(2)*Z(34)
      Z(109) = Z(1)*Z(32) - Z(2)*Z(31)
      Z(110) = Z(1)*Z(34) - Z(2)*Z(33)
      Z(112) = LApp + LHpp + LKpp + LMTPpp
      Z(118) = LFFO*Z(117)
      Z(120) = RAp + RHp + RKp
      Z(125) = LRFO*Z(120)
      Z(126) = LRFFO*Z(120)
      Z(147) = LSHO*Z(146)
      Z(148) = Z(142) - LSHO
      Z(163) = LTHO*RHp
      Z(164) = Z(159) - LTHO
      Z(184) = Z(71)*LHp
      Z(185) = Z(71) + Z(180)
      Z(207) = Z(70)*Z(206)
      Z(208) = Z(70) + Z(202)
      Z(220) = Z(69)*Z(215)
      Z(221) = LRFFO*Z(215)
      Z(266) = Z(68)*Z(265)
      Z(267) = Z(68) + Z(259)
      Z(278) = LFF*(RAp+RHp+RKp+RMTPp)
      Z(279) = LRF*(RAp+RHp+RKp)
      Z(280) = LSH*(RHp+RKp)
      Z(292) = LFFO*Z(106)
      Z(293) = Z(117) + U4 + U6 + U8
      Z(294) = (Z(118)+LFFO*U3+LFFO*U4+LFFO*U6+LFFO*U8)*(U3+Z(293))
      Z(295) = LFF*Z(106)
      Z(296) = (Z(119)+LFF*U3+LFF*U4+LFF*U6+LFF*U8)*(U3+Z(293))
      Z(297) = LRFO*Z(94)
      Z(298) = LRFFO*Z(94)
      Z(299) = Z(120) + U4 + U6 + U8
      Z(300) = (Z(125)+LRFO*U3+LRFO*U4+LRFO*U6+LRFO*U8)*(U3+Z(299))
      Z(301) = (Z(126)+LRFFO*U3+LRFFO*U4+LRFFO*U6+LRFFO*U8)*(U3+Z(299))
      Z(302) = Z(16)*Z(295) + Z(15)*Z(296)
      Z(303) = Z(16)*Z(296) - Z(15)*Z(295)
      Z(304) = LRF*Z(106)
      Z(305) = Z(302) + (Z(135)+LRF*U3+LRF*U4+LRF*U6+LRF*U8)*(U3+Z(293))
      Z(306) = Z(303) - Z(304)
      Z(307) = Z(11)*Z(305) - Z(12)*Z(306)
      Z(308) = Z(11)*Z(306) + Z(12)*Z(305)
      Z(309) = LSHO*Z(86)
      Z(310) = Z(146) + U4 + U6
      Z(311) = Z(307) + (Z(147)+LSHO*U3+LSHO*U4+LSHO*U6)*(U3+Z(310))
      Z(312) = Z(308) - Z(309)
      Z(313) = LSH*Z(86)
      Z(314) = Z(307) + (Z(150)+LSH*U3+LSH*U4+LSH*U6)*(U3+Z(310))
      Z(315) = Z(308) - Z(313)
      Z(316) = Z(7)*Z(314) - Z(8)*Z(315)
      Z(317) = Z(7)*Z(315) + Z(8)*Z(314)
      Z(318) = LTHO*RHpp
      Z(319) = Z(316) + (Z(163)+LTHO*U3+LTHO*U4)*(U3+Z(83))
      Z(320) = Z(317) - Z(318)
      Z(321) = LTH*RHpp
      Z(322) = Z(316) + (Z(166)+LTH*U3+LTH*U4)*(U3+Z(83))
      Z(323) = Z(317) - Z(321)
      Z(324) = Z(169)*Z(322) + Z(171)*Z(323)
      Z(325) = Z(169)*Z(323) + Z(170)*Z(322)
      Z(326) = Z(71)*LHpp
      Z(327) = Z(324) - (Z(184)+Z(71)*U3+Z(71)*U5)*(U3+Z(84))
      Z(328) = Z(326) + Z(325)
      Z(329) = LTH*LHpp
      Z(330) = Z(324) - (Z(187)+LTH*U3+LTH*U5)*(U3+Z(84))
      Z(331) = Z(329) + Z(325)
      Z(332) = Z(9)*Z(330) + Z(10)*Z(331)
      Z(333) = Z(9)*Z(331) - Z(10)*Z(330)
      Z(334) = Z(70)*Z(88)
      Z(335) = Z(206) + U5 + U7
      Z(336) = Z(332) - (Z(207)+Z(70)*U3+Z(70)*U5+Z(70)*U7)*(U3+Z(335))
      Z(337) = Z(334) + Z(333)
      Z(338) = LSH*Z(88)
      Z(339) = Z(332) - (Z(211)+LSH*U3+LSH*U5+LSH*U7)*(U3+Z(335))
      Z(340) = Z(338) + Z(333)
      Z(341) = Z(69)*Z(100)
      Z(342) = LRFFO*Z(100)
      Z(343) = Z(215) + U5 + U7 + U9
      Z(344) = (Z(220)+Z(69)*U3+Z(69)*U5+Z(69)*U7+Z(69)*U9)*(U3+Z(343))
      Z(345) = (Z(221)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)*(U3+Z(343))
      Z(346) = Z(13)*Z(339) + Z(14)*Z(340)
      Z(347) = Z(13)*Z(340) - Z(14)*Z(339)
      Z(348) = LRF*Z(100)
      Z(349) = Z(346) - (Z(240)+LRF*U3+LRF*U5+LRF*U7+LRF*U9)*(U3+Z(343))
      Z(350) = Z(348) + Z(347)
      Z(351) = Z(17)*Z(349) + Z(18)*Z(350)
      Z(352) = Z(17)*Z(350) - Z(18)*Z(349)
      Z(353) = Z(68)*Z(112)
      Z(354) = Z(265) + U5 + U7 + U9
      Z(355) = Z(351) - (Z(266)+Z(68)*U3+Z(68)*U5+Z(68)*U7+Z(68)*U9)*(U3
     &+Z(354))
      Z(356) = Z(353) + Z(352)
      Z(360) = HATO*U3
      Z(361) = -Z(278) - LFF*U3 - LFF*U4 - LFF*U6 - LFF*U8
      Z(362) = -Z(279) - LRF*U3 - LRF*U4 - LRF*U6 - LRF*U8
      Z(363) = -Z(280) - LSH*U3 - LSH*U4 - LSH*U6
      Z(364) = -Z(166) - LTH*U3 - LTH*U4
      Z(365) = HATOp*U3
      Z(366) = LFF*(RApp+RHpp+RKpp+RMTPpp)
      Z(367) = RAp + U8
      Z(368) = RKp + U6
      Z(369) = LRF*(RApp+RHpp+RKpp)
      Z(370) = LSH*(RHpp+RKpp)
      Z(371) = HATOpp - U3*Z(360)
      Z(372) = HATOp*U3 + Z(365)
      Z(373) = Z(361)*(RMTPp+U3+Z(83)+Z(367)+Z(368))
      Z(374) = Z(362)*(U3+Z(83)+Z(367)+Z(368))
      Z(375) = Z(363)*(U3+Z(83)+Z(368))
      Z(376) = Z(364)*(U3+Z(83))
      Z(390) = Z(7)*Z(22) + Z(8)*Z(21)
      Z(391) = Z(7)*Z(23) - Z(8)*Z(21)
      Z(392) = Z(7)*Z(21) + Z(8)*Z(23)
      Z(393) = Z(7)*Z(11) - Z(8)*Z(12)
      Z(394) = Z(7)*Z(12) + Z(8)*Z(11)
      Z(395) = -Z(7)*Z(12) - Z(8)*Z(11)
      Z(396) = Z(19)*Z(13) - Z(20)*Z(14)
      Z(397) = Z(19)*Z(14) + Z(20)*Z(13)
      Z(398) = -Z(19)*Z(14) - Z(20)*Z(13)
      Z(399) = Z(19)*Z(15) + Z(20)*Z(16)
      Z(400) = Z(19)*Z(16) - Z(20)*Z(15)
      Z(401) = Z(20)*Z(15) - Z(19)*Z(16)
      Z(723) = RRX1 + LRX1*Z(64)*Z(251) + LRX1*Z(66)*Z(262) + LRX2*Z(56)
     &*Z(227) + LRX2*Z(58)*Z(237) + LRY1*Z(65)*Z(251) + LRY1*Z(67)*Z(262
     &) + LRY2*Z(57)*Z(227) + LRY2*Z(59)*Z(237) + RRX2*Z(31)**2 + RRX2*Z
     &(33)**2 + RRY2*Z(31)*Z(32) + RRY2*Z(33)*Z(34) + Z(378)*(Z(31)*Z(32
     &)+Z(33)*Z(34)) + Z(378)*(Z(65)*Z(251)+Z(67)*Z(262)) + Z(379)*(Z(31
     &)*Z(32)+Z(33)*Z(34)) + Z(379)*(Z(53)*Z(194)+Z(55)*Z(203)) + Z(380)
     &*(Z(28)*Z(139)+Z(30)*Z(143)) + Z(380)*(Z(53)*Z(194)+Z(55)*Z(203)) 
     &+ Z(381)*(Z(46)*Z(160)+Z(47)*Z(155)) + Z(381)*(Z(49)*Z(181)+Z(50)*
     &Z(175))
      Z(724) = Z(377) + RRY1 + LRX1*Z(64)*Z(252) + LRX1*Z(66)*Z(263) + L
     &RX2*Z(56)*Z(228) + LRX2*Z(58)*Z(238) + LRY1*Z(65)*Z(252) + LRY1*Z(
     &67)*Z(263) + LRY2*Z(57)*Z(228) + LRY2*Z(59)*Z(238) + RRX2*Z(31)*Z(
     &32) + RRX2*Z(33)*Z(34) + RRY2*Z(32)**2 + RRY2*Z(34)**2 + Z(378)*(Z
     &(32)**2+Z(34)**2) + Z(378)*(Z(65)*Z(252)+Z(67)*Z(263)) + Z(379)*(Z
     &(32)**2+Z(34)**2) + Z(379)*(Z(53)*Z(195)+Z(55)*Z(204)) + Z(380)*(Z
     &(28)*Z(140)+Z(30)*Z(144)) + Z(380)*(Z(53)*Z(195)+Z(55)*Z(204)) + Z
     &(381)*(Z(46)*Z(161)+Z(47)*Z(156)) + Z(381)*(Z(49)*Z(182)+Z(50)*Z(1
     &76))
      Z(736) = IFF*Z(112)
      Z(738) = IRF*Z(100)
      Z(740) = ISH*Z(88)
      Z(742) = ITH*LHpp
      Z(743) = IFF*Z(106)
      Z(744) = IRF*Z(94)
      Z(745) = ISH*Z(86)
      Z(746) = ITH*RHpp
      Z(747) = MHAT + MFF*(Z(31)**2+Z(33)**2) + MFF*(Z(251)**2+Z(262)**2
     &) + MRF*(Z(31)**2+Z(33)**2) + MRF*(Z(194)**2+Z(203)**2) + MSH*(Z(1
     &39)**2+Z(143)**2) + MSH*(Z(194)**2+Z(203)**2) + MTH*(Z(155)**2+Z(1
     &60)**2) + MTH*(Z(175)**2+Z(181)**2)
      Z(748) = MFF*(Z(245)*Z(251)+Z(267)*Z(262)) + MSH*(Z(138)*Z(139)+Z(
     &148)*Z(143)) + MSH*(Z(190)*Z(194)+Z(208)*Z(203)) + MTH*(Z(153)*Z(1
     &55)+Z(164)*Z(160)) + MTH*(Z(172)*Z(175)+Z(185)*Z(181)) + 0.5D0*MRF
     &*(2*Z(190)*Z(194)+2*Z(212)*Z(203)+2*Z(69)*Z(13)*Z(203)-2*Z(69)*Z(1
     &4)*Z(194)-LRFFO*Z(396)*Z(203)-LRFFO*Z(398)*Z(194)) - Z(692)*Z(33) 
     &- MHAT*(LFF*Z(33)+LRF*Z(44)+LSH*Z(29)+LTH*Z(48)+HATO*Z(2)) - 0.5D0
     &*MRF*(2*LFF*Z(33)+LRFFO*Z(399)*Z(33)+LRFFO*Z(400)*Z(31)+LRFO*Z(15)
     &*Z(33)+LRFO*Z(16)*Z(31))
      Z(749) = MFF*(Z(31)*Z(32)+Z(33)*Z(34)) + MFF*(Z(251)*Z(252)+Z(262)
     &*Z(263)) + MRF*(Z(31)*Z(32)+Z(33)*Z(34)) + MRF*(Z(194)*Z(195)+Z(20
     &3)*Z(204)) + MSH*(Z(139)*Z(140)+Z(143)*Z(144)) + MSH*(Z(194)*Z(195
     &)+Z(203)*Z(204)) + MTH*(Z(155)*Z(156)+Z(160)*Z(161)) + MTH*(Z(175)
     &*Z(176)+Z(181)*Z(182))
      Z(750) = MFF*(Z(251)*Z(355)+Z(262)*Z(356)) + MSH*(Z(139)*Z(311)+Z(
     &143)*Z(312)) + MSH*(Z(194)*Z(336)+Z(203)*Z(337)) + MTH*(Z(155)*Z(3
     &19)+Z(160)*Z(320)) + MTH*(Z(175)*Z(327)+Z(181)*Z(328)) + MHAT*(Z(1
     &)*Z(371)-Z(321)*Z(48)-Z(366)*Z(33)-Z(369)*Z(44)-Z(370)*Z(29)-Z(2)*
     &Z(372)-Z(27)*Z(375)-Z(31)*Z(373)-Z(42)*Z(374)-Z(46)*Z(376)) - MFF*
     &(Z(292)*Z(33)-Z(31)*Z(294)) - 0.5D0*MRF*(2*Z(295)*Z(33)+Z(15)*Z(29
     &7)*Z(33)+Z(16)*Z(297)*Z(31)+Z(399)*Z(298)*Z(33)+Z(400)*Z(298)*Z(31
     &)+Z(16)*Z(33)*Z(300)-2*Z(31)*Z(296)-Z(15)*Z(31)*Z(300)-Z(399)*Z(31
     &)*Z(301)-Z(401)*Z(33)*Z(301)) - 0.5D0*MRF*(Z(396)*Z(342)*Z(203)+Z(
     &398)*Z(342)*Z(194)+2*Z(14)*Z(341)*Z(194)+2*Z(13)*Z(194)*Z(344)+2*Z
     &(14)*Z(203)*Z(344)-2*Z(13)*Z(341)*Z(203)-2*Z(194)*Z(339)-2*Z(203)*
     &Z(340)-Z(396)*Z(194)*Z(345)-Z(397)*Z(203)*Z(345))
      Z(751) = MHAT + MFF*(Z(32)**2+Z(34)**2) + MFF*(Z(252)**2+Z(263)**2
     &) + MRF*(Z(32)**2+Z(34)**2) + MRF*(Z(195)**2+Z(204)**2) + MSH*(Z(1
     &40)**2+Z(144)**2) + MSH*(Z(195)**2+Z(204)**2) + MTH*(Z(156)**2+Z(1
     &61)**2) + MTH*(Z(176)**2+Z(182)**2)
      Z(752) = MFF*(Z(245)*Z(252)+Z(267)*Z(263)) + MSH*(Z(138)*Z(140)+Z(
     &148)*Z(144)) + MSH*(Z(190)*Z(195)+Z(208)*Z(204)) + MTH*(Z(153)*Z(1
     &56)+Z(164)*Z(161)) + MTH*(Z(172)*Z(176)+Z(185)*Z(182)) + 0.5D0*MRF
     &*(2*Z(190)*Z(195)+2*Z(212)*Z(204)+2*Z(69)*Z(13)*Z(204)-2*Z(69)*Z(1
     &4)*Z(195)-LRFFO*Z(396)*Z(204)-LRFFO*Z(398)*Z(195)) - Z(692)*Z(34) 
     &- MHAT*(LFF*Z(34)+LRF*Z(45)+LSH*Z(30)+LTH*Z(46)-HATO*Z(1)) - 0.5D0
     &*MRF*(2*LFF*Z(34)+LRFFO*Z(399)*Z(34)+LRFFO*Z(400)*Z(32)+LRFO*Z(15)
     &*Z(34)+LRFO*Z(16)*Z(32))
      Z(753) = MFF*(Z(252)*Z(355)+Z(263)*Z(356)) + MSH*(Z(140)*Z(311)+Z(
     &144)*Z(312)) + MSH*(Z(195)*Z(336)+Z(204)*Z(337)) + MTH*(Z(156)*Z(3
     &19)+Z(161)*Z(320)) + MTH*(Z(176)*Z(327)+Z(182)*Z(328)) + MHAT*(Z(1
     &)*Z(372)+Z(2)*Z(371)-Z(321)*Z(46)-Z(366)*Z(34)-Z(369)*Z(45)-Z(370)
     &*Z(30)-Z(28)*Z(375)-Z(32)*Z(373)-Z(43)*Z(374)-Z(47)*Z(376)) - MFF*
     &(Z(292)*Z(34)-Z(32)*Z(294)) - 0.5D0*MRF*(2*Z(295)*Z(34)+Z(15)*Z(29
     &7)*Z(34)+Z(16)*Z(297)*Z(32)+Z(399)*Z(298)*Z(34)+Z(400)*Z(298)*Z(32
     &)+Z(16)*Z(34)*Z(300)-2*Z(32)*Z(296)-Z(15)*Z(32)*Z(300)-Z(399)*Z(32
     &)*Z(301)-Z(401)*Z(34)*Z(301)) - 0.5D0*MRF*(Z(396)*Z(342)*Z(204)+Z(
     &398)*Z(342)*Z(195)+2*Z(14)*Z(341)*Z(195)+2*Z(13)*Z(195)*Z(344)+2*Z
     &(14)*Z(204)*Z(344)-2*Z(13)*Z(341)*Z(204)-2*Z(195)*Z(339)-2*Z(204)*
     &Z(340)-Z(396)*Z(195)*Z(345)-Z(397)*Z(204)*Z(345))
      Z(767) = Z(754) + MFF*(Z(245)**2+Z(267)**2) + MSH*(Z(138)**2+Z(148
     &)**2) + MSH*(Z(190)**2+Z(208)**2) + MTH*(Z(153)**2+Z(164)**2) + MT
     &H*(Z(172)**2+Z(185)**2) + 0.25D0*MRF*(Z(755)+4*Z(756)*Z(399)+4*Z(7
     &57)*Z(15)) + 0.25D0*MRF*(Z(758)+4*Z(190)**2+4*Z(212)**2+8*Z(69)*Z(
     &13)*Z(212)-4*Z(759)-8*Z(69)*Z(14)*Z(190)-4*LRFFO*Z(190)*Z(398)-4*L
     &RFFO*Z(212)*Z(396)) + MHAT*(Z(760)+HATO**2+2*Z(761)*Z(15)+2*Z(762)
     &*Z(21)+2*Z(763)*Z(392)+2*Z(764)*Z(11)+2*Z(765)*Z(393)+2*Z(766)*Z(7
     &)-2*LSH*HATO*Z(24)-2*LTH*HATO*Z(3)-2*LFF*HATO*Z(110)-2*LRF*HATO*Z(
     &98))
      Z(774) = Z(736) + Z(738) + Z(740) + Z(742) + Z(743) + Z(744) + Z(7
     &45) + Z(746) + Z(692)*Z(292) + MFF*(Z(245)*Z(355)+Z(267)*Z(356)) +
     & MSH*(Z(138)*Z(311)+Z(148)*Z(312)) + MSH*(Z(190)*Z(336)+Z(208)*Z(3
     &37)) + MTH*(Z(153)*Z(319)+Z(164)*Z(320)) + MTH*(Z(172)*Z(327)+Z(18
     &5)*Z(328)) + 0.25D0*MRF*(LRFFO*Z(298)+LRFO*Z(297)+Z(768)*Z(297)+Z(
     &769)*Z(298)+4*LFF*Z(295)+2*LFF*Z(15)*Z(297)+2*LFF*Z(399)*Z(298)+2*
     &LRFFO*Z(399)*Z(295)+2*LRFO*Z(15)*Z(295)+Z(770)*Z(300)+2*LFF*Z(16)*
     &Z(300)-Z(771)*Z(301)-2*LFF*Z(401)*Z(301)-2*LRFFO*Z(400)*Z(296)-2*L
     &RFO*Z(16)*Z(296)) + MHAT*(LFF*Z(366)+LRF*Z(369)+LSH*Z(370)+LTH*Z(3
     &21)+LFF*Z(15)*Z(369)+LFF*Z(21)*Z(370)+LFF*Z(392)*Z(321)+LRF*Z(11)*
     &Z(370)+LRF*Z(15)*Z(366)+LRF*Z(393)*Z(321)+LSH*Z(7)*Z(321)+LSH*Z(11
     &)*Z(369)+LSH*Z(21)*Z(366)+LTH*Z(7)*Z(370)+LTH*Z(392)*Z(366)+LTH*Z(
     &393)*Z(369)+HATO*Z(372)+LFF*Z(23)*Z(375)+LFF*Z(391)*Z(376)+LRF*Z(1
     &6)*Z(373)+LRF*Z(395)*Z(376)+LSH*Z(12)*Z(374)+LSH*Z(22)*Z(373)+LTH*
     &Z(4)*Z(371)+LTH*Z(8)*Z(375)+LTH*Z(390)*Z(373)+LTH*Z(394)*Z(374)-HA
     &TO*Z(3)*Z(321)-HATO*Z(24)*Z(370)-HATO*Z(366)*Z(110)-HATO*Z(369)*Z(
     &98)-LFF*Z(16)*Z(374)-LFF*Z(108)*Z(371)-LFF*Z(110)*Z(372)-LRF*Z(12)
     &*Z(375)-LRF*Z(96)*Z(371)-LRF*Z(98)*Z(372)-LSH*Z(8)*Z(376)-LSH*Z(24
     &)*Z(372)-LSH*Z(26)*Z(371)-LTH*Z(3)*Z(372)-HATO*Z(4)*Z(376)-HATO*Z(
     &25)*Z(375)-HATO*Z(97)*Z(374)-HATO*Z(109)*Z(373)) - 0.25D0*MRF*(2*Z
     &(768)*Z(341)+2*Z(772)*Z(342)+2*Z(190)*Z(398)*Z(342)+2*Z(212)*Z(396
     &)*Z(342)+4*Z(14)*Z(190)*Z(341)+2*Z(770)*Z(344)+2*LRFFO*Z(396)*Z(34
     &0)+2*LRFFO*Z(398)*Z(339)+4*Z(69)*Z(14)*Z(339)+4*Z(13)*Z(190)*Z(344
     &)+4*Z(14)*Z(212)*Z(344)-4*Z(69)*Z(341)-LRFFO*Z(342)-4*Z(13)*Z(212)
     &*Z(341)-4*Z(190)*Z(339)-4*Z(212)*Z(340)-2*Z(773)*Z(345)-4*Z(69)*Z(
     &13)*Z(340)-2*Z(190)*Z(396)*Z(345)-2*Z(212)*Z(397)*Z(345))
      Z(809) = Z(723) - Z(750)
      Z(810) = Z(724) - Z(753)
      Z(824) = Z(222)*LRX2*Z(56) + Z(222)*LRY2*Z(57) + Z(241)*LRX2*Z(58)
     & + Z(241)*LRY2*Z(59) + Z(245)*LRX1*Z(64) + Z(245)*LRY1*Z(65) + Z(2
     &73)*LRX1*Z(66) + Z(273)*LRY1*Z(67) + Z(378)*(Z(245)*Z(65)+Z(267)*Z
     &(67)) + Z(380)*(Z(138)*Z(28)+Z(148)*Z(30)) + Z(380)*(Z(190)*Z(53)+
     &Z(208)*Z(55)) + Z(381)*(Z(153)*Z(47)+Z(164)*Z(46)) + Z(381)*(Z(172
     &)*Z(50)+Z(185)*Z(49)) - Z(725)*Z(34) - LFF*(RRX2*Z(33)+RRY2*Z(34))
     & - 0.5D0*Z(379)*(LRFFO*Z(41)+LRFO*Z(45)+2*LFF*Z(34)) - Z(377)*(LFF
     &*Z(34)+LRF*Z(45)+LSH*Z(30)+LTH*Z(46)-HATO*Z(1)) - 0.5D0*Z(379)*(LR
     &FFO*Z(63)-2*Z(69)*Z(59)-2*Z(190)*Z(53)-2*Z(212)*Z(55)) - Z(774)

      COEF(1,1) = -Z(747)
      COEF(1,2) = -Z(749)
      COEF(1,3) = -Z(748)
      COEF(2,1) = -Z(749)
      COEF(2,2) = -Z(751)
      COEF(2,3) = -Z(752)
      COEF(3,1) = -Z(748)
      COEF(3,2) = -Z(752)
      COEF(3,3) = -Z(767)
      RHS(1) = -Z(809)
      RHS(2) = -Z(810)
      RHS(3) = -Z(824)
      CALL SOLVE(3,COEF,RHS,VARp)

C**   Update variables after uncoupling equations
      U1p = VARp(1)
      U2p = VARp(2)
      U3p = VARp(3)

C**   Update derivative array prior to integration step
      VARp(1) = Q1p
      VARp(2) = Q2p
      VARp(3) = Q3p
      VARp(4) = U1p
      VARp(5) = U2p
      VARp(6) = U3p

      RETURN
      END


C**********************************************************************
      SUBROUTINE       IO(T)
      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          ILOOP
      COMMON/CONSTNTS/ FOOTANG,G,IFF,IHAT,IRF,ISH,ITH,K1,K2,K3,K4,K5,K6,
     &K7,K8,LFF,LFFO,LHAT,LMTPXI,LRF,LRFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,L
     &TOEXI,MFF,MHAT,MRF,MSH,MTH,MTPB,MTPK,RMTPXI,RTOEXI
      COMMON/SPECFIED/ HATO,LA,LH,LK,LMTP,RA,RH,RK,RMTP,HATOp,LAp,LHp,LK
     &p,LMTPp,RAp,RHp,RKp,RMTPp,HATOpp,LApp,LHpp,LKpp,LMTPpp,RApp,RHpp,R
     &Kpp,RMTPpp
      COMMON/VARIBLES/ Q1,Q2,Q3,U1,U2,U3
      COMMON/ALGBRAIC/ HZ,KECM,LATQ,LHTQ,LKTQ,LRX1,LRX2,LRY1,LRY2,PECM,P
     &X,PY,RATQ,RHTQ,RKTQ,RRX1,RRX2,RRY1,RRY2,TE,U4,U5,U6,U7,U8,U9,Q1p,Q
     &2p,Q3p,U1p,U2p,U3p,DLX1,DLX2,DRX1,DRX2,LMTQ,LRX,LRY,POCMX,POCMY,PO
     &HATOX,POHATOY,POP10X,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP1X,POP1
     &Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7
     &X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,RMTQ,RRX,RRY,VOCMX,VOCMY,VOP10X,VO
     &P10Y,VOP11X,VOP11Y,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(824),COEF(3,3),RHS(3)

C**   Evaluate output quantities
      Z(149) = Z(145) - Z(147)
      Z(165) = Z(162) - Z(163)
      Z(186) = Z(183) + Z(184)
      Z(210) = Z(205) + Z(207)
      Z(209) = Z(70) + Z(198)
      Z(271) = Z(264) + Z(266)
      Z(268) = Z(68) + Z(260)
      Z(269) = Z(68) + Z(261)
      Z(270) = Z(68) + Z(255)
      KECM = 0.5D0*IHAT*U3**2 + 0.5D0*ITH*(LHp+U3+U5)**2 + 0.5D0*ITH*(RH
     &p+U3+U4)**2 + 0.5D0*ISH*(LHp+LKp+U3+U5+U7)**2 + 0.5D0*ISH*(RHp+RKp
     &+U3+U4+U6)**2 + 0.5D0*IRF*(LAp+LHp+LKp+U3+U5+U7+U9)**2 + 0.5D0*IRF
     &*(RAp+RHp+RKp+U3+U4+U6+U8)**2 + 0.5D0*IFF*(LAp+LHp+LKp+LMTPp+U3+U5
     &+U7+U9)**2 + 0.5D0*IFF*(RAp+RHp+RKp+RMTPp+U3+U4+U6+U8)**2 + 0.5D0*
     &MFF*((Z(31)*U1+Z(32)*U2)**2+(Z(118)+LFFO*U3+LFFO*U4+LFFO*U6+LFFO*U
     &8-Z(33)*U1-Z(34)*U2)**2) + 0.5D0*MSH*((Z(141)+Z(138)*U3+Z(138)*U4+
     &Z(138)*U6+Z(138)*U8+Z(139)*U1+Z(140)*U2)**2+(Z(149)+Z(142)*U8+Z(14
     &8)*U3+Z(148)*U4+Z(148)*U6+Z(143)*U1+Z(144)*U2)**2) + 0.5D0*MTH*((Z
     &(157)+Z(153)*U3+Z(153)*U4+Z(153)*U6+Z(154)*U8+Z(155)*U1+Z(156)*U2)
     &**2+(Z(165)+Z(158)*U8+Z(159)*U6+Z(164)*U3+Z(164)*U4+Z(160)*U1+Z(16
     &1)*U2)**2) + 0.5D0*MTH*((Z(177)+Z(172)*U3+Z(172)*U4+Z(173)*U6+Z(17
     &4)*U8+Z(175)*U1+Z(176)*U2)**2+(Z(186)+Z(71)*U5+Z(178)*U8+Z(179)*U6
     &+Z(180)*U4+Z(185)*U3+Z(181)*U1+Z(182)*U2)**2) + 0.5D0*MSH*((Z(197)
     &+Z(190)*U3+Z(191)*U4+Z(192)*U6+Z(193)*U8+Z(196)*U5+Z(194)*U1+Z(195
     &)*U2)**2+(Z(210)+Z(70)*U7+Z(199)*U8+Z(200)*U6+Z(201)*U4+Z(208)*U3+
     &Z(209)*U5+Z(203)*U1+Z(204)*U2)**2) + 0.5D0*MFF*((Z(254)+Z(245)*U3+
     &Z(246)*U4+Z(247)*U6+Z(248)*U8+Z(249)*U5+Z(250)*U7+Z(253)*U9+Z(251)
     &*U1+Z(252)*U2)**2+(Z(271)+Z(256)*U8+Z(257)*U6+Z(258)*U4+Z(267)*U3+
     &Z(268)*U5+Z(269)*U7+Z(270)*U9+Z(262)*U1+Z(263)*U2)**2) + 0.125D0*M
     &RF*((Z(221)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)**2+4*(Z(220)+Z(69
     &)*U3+Z(69)*U5+Z(69)*U7+Z(69)*U9)**2+4*(Z(197)+Z(190)*U3+Z(191)*U4+
     &Z(192)*U6+Z(193)*U8+Z(196)*U5+Z(194)*U1+Z(195)*U2)**2+4*(Z(214)+LS
     &H*U7+Z(199)*U8+Z(200)*U6+Z(201)*U4+Z(212)*U3+Z(213)*U5+Z(203)*U1+Z
     &(204)*U2)**2+8*Z(13)*(Z(220)+Z(69)*U3+Z(69)*U5+Z(69)*U7+Z(69)*U9)*
     &(Z(214)+LSH*U7+Z(199)*U8+Z(200)*U6+Z(201)*U4+Z(212)*U3+Z(213)*U5+Z
     &(203)*U1+Z(204)*U2)-4*Z(19)*(Z(220)+Z(69)*U3+Z(69)*U5+Z(69)*U7+Z(6
     &9)*U9)*(Z(221)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)-8*Z(14)*(Z(220
     &)+Z(69)*U3+Z(69)*U5+Z(69)*U7+Z(69)*U9)*(Z(197)+Z(190)*U3+Z(191)*U4
     &+Z(192)*U6+Z(193)*U8+Z(196)*U5+Z(194)*U1+Z(195)*U2)-4*Z(398)*(Z(22
     &1)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)*(Z(197)+Z(190)*U3+Z(191)*U
     &4+Z(192)*U6+Z(193)*U8+Z(196)*U5+Z(194)*U1+Z(195)*U2)-4*Z(396)*(Z(2
     &21)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)*(Z(214)+LSH*U7+Z(199)*U8+
     &Z(200)*U6+Z(201)*U4+Z(212)*U3+Z(213)*U5+Z(203)*U1+Z(204)*U2)) - 0.
     &125D0*MRF*(4*Z(16)*(Z(31)*U1+Z(32)*U2)*(Z(125)+LRFO*U3+LRFO*U4+LRF
     &O*U6+LRFO*U8)+4*Z(400)*(Z(31)*U1+Z(32)*U2)*(Z(126)+LRFFO*U3+LRFFO*
     &U4+LRFFO*U6+LRFFO*U8)-4*(Z(31)*U1+Z(32)*U2)**2-(Z(125)+LRFO*U3+LRF
     &O*U4+LRFO*U6+LRFO*U8)**2-(Z(126)+LRFFO*U3+LRFFO*U4+LRFFO*U6+LRFFO*
     &U8)**2-4*(Z(119)+LFF*U3+LFF*U4+LFF*U6+LFF*U8-Z(33)*U1-Z(34)*U2)**2
     &-2*Z(19)*(Z(125)+LRFO*U3+LRFO*U4+LRFO*U6+LRFO*U8)*(Z(126)+LRFFO*U3
     &+LRFFO*U4+LRFFO*U6+LRFFO*U8)-4*Z(15)*(Z(125)+LRFO*U3+LRFO*U4+LRFO*
     &U6+LRFO*U8)*(Z(119)+LFF*U3+LFF*U4+LFF*U6+LFF*U8-Z(33)*U1-Z(34)*U2)
     &-4*Z(399)*(Z(126)+LRFFO*U3+LRFFO*U4+LRFFO*U6+LRFFO*U8)*(Z(119)+LFF
     &*U3+LFF*U4+LFF*U6+LFF*U8-Z(33)*U1-Z(34)*U2)) - 0.5D0*MHAT*(2*HATO*
     &Z(2)*U1*U3+2*Z(46)*U2*(Z(166)+LTH*U3+LTH*U4)+2*Z(48)*U1*(Z(166)+LT
     &H*U3+LTH*U4)+2*HATO*Z(3)*U3*(Z(166)+LTH*U3+LTH*U4)+2*Z(26)*HATOp*(
     &Z(280)+LSH*U3+LSH*U4+LSH*U6)+2*Z(29)*U1*(Z(280)+LSH*U3+LSH*U4+LSH*
     &U6)+2*Z(30)*U2*(Z(280)+LSH*U3+LSH*U4+LSH*U6)+2*HATO*Z(24)*U3*(Z(28
     &0)+LSH*U3+LSH*U4+LSH*U6)+2*HATOp*Z(96)*(Z(279)+LRF*U3+LRF*U4+LRF*U
     &6+LRF*U8)+2*HATOp*Z(108)*(Z(278)+LFF*U3+LFF*U4+LFF*U6+LFF*U8)+2*Z(
     &33)*U1*(Z(278)+LFF*U3+LFF*U4+LFF*U6+LFF*U8)+2*Z(34)*U2*(Z(278)+LFF
     &*U3+LFF*U4+LFF*U6+LFF*U8)+2*Z(44)*U1*(Z(279)+LRF*U3+LRF*U4+LRF*U6+
     &LRF*U8)+2*Z(45)*U2*(Z(279)+LRF*U3+LRF*U4+LRF*U6+LRF*U8)+2*HATO*Z(9
     &8)*U3*(Z(279)+LRF*U3+LRF*U4+LRF*U6+LRF*U8)+2*HATO*Z(110)*U3*(Z(278
     &)+LFF*U3+LFF*U4+LFF*U6+LFF*U8)-HATOp**2-U1**2-U2**2-2*HATOp*Z(1)*U
     &1-2*HATOp*Z(2)*U2-2*HATO*Z(1)*U2*U3-HATO**2*U3**2-(Z(166)+LTH*U3+L
     &TH*U4)**2-2*Z(4)*HATOp*(Z(166)+LTH*U3+LTH*U4)-(Z(280)+LSH*U3+LSH*U
     &4+LSH*U6)**2-(Z(278)+LFF*U3+LFF*U4+LFF*U6+LFF*U8)**2-(Z(279)+LRF*U
     &3+LRF*U4+LRF*U6+LRF*U8)**2-2*Z(7)*(Z(166)+LTH*U3+LTH*U4)*(Z(280)+L
     &SH*U3+LSH*U4+LSH*U6)-2*Z(392)*(Z(166)+LTH*U3+LTH*U4)*(Z(278)+LFF*U
     &3+LFF*U4+LFF*U6+LFF*U8)-2*Z(393)*(Z(166)+LTH*U3+LTH*U4)*(Z(279)+LR
     &F*U3+LRF*U4+LRF*U6+LRF*U8)-2*Z(11)*(Z(280)+LSH*U3+LSH*U4+LSH*U6)*(
     &Z(279)+LRF*U3+LRF*U4+LRF*U6+LRF*U8)-2*Z(21)*(Z(280)+LSH*U3+LSH*U4+
     &LSH*U6)*(Z(278)+LFF*U3+LFF*U4+LFF*U6+LFF*U8)-2*Z(15)*(Z(278)+LFF*U
     &3+LFF*U4+LFF*U6+LFF*U8)*(Z(279)+LRF*U3+LRF*U4+LRF*U6+LRF*U8))
      Z(73) = MHAT*HATO/Z(72)
      Z(36) = Z(19)*Z(12) + Z(20)*Z(11)
      Z(39) = Z(35)*Z(28) + Z(36)*Z(30)
      Z(61) = Z(19)*Z(57) + Z(20)*Z(59)
      POCMY = Q2 + Z(74)*Z(65) + Z(75)*Z(57) + Z(77)*Z(53) + Z(78)*Z(50)
     & + Z(73)*Z(2) - Z(79)*Z(32) - Z(81)*Z(28) - Z(82)*Z(47) - 0.5D0*Z(
     &76)*Z(39) - 0.5D0*Z(76)*Z(61) - 0.5D0*Z(80)*Z(43)
      PECM = 0.5D0*K1*Q1**2 + 0.5D0*K3*Q2**2 - G*(MHAT+2*MFF+2*MRF+2*MSH
     &+2*MTH)*POCMY
      TE = KECM + PECM
      Z(402) = IFF*Z(265)
      Z(403) = IRF*Z(215)
      Z(404) = ISH*Z(206)
      Z(405) = ITH*LHp
      Z(406) = IFF*Z(117)
      Z(407) = IRF*Z(120)
      Z(408) = ISH*Z(146)
      Z(409) = ITH*RHp
      Z(115) = Z(1)*Z(65) - Z(2)*Z(64)
      Z(103) = Z(1)*Z(57) - Z(2)*Z(56)
      Z(91) = Z(1)*Z(53) - Z(2)*Z(52)
      Z(38) = Z(35)*Z(27) + Z(36)*Z(29)
      Z(123) = Z(1)*Z(39) - Z(2)*Z(38)
      Z(60) = Z(19)*Z(56) + Z(20)*Z(58)
      Z(218) = Z(1)*Z(61) - Z(2)*Z(60)
      Z(574) = MHAT*HATOp*(2*Z(78)*Z(6)+2*Z(74)*Z(115)+2*Z(75)*Z(103)+2*
     &Z(77)*Z(91)-2*Z(413)*Z(25)-2*Z(414)*Z(4)-2*Z(411)*Z(109)-2*Z(412)*
     &Z(97)-Z(76)*Z(123)-Z(76)*Z(218))
      Z(410) = HATO - Z(73)
      Z(576) = MHAT*(2*Z(74)*Z(65)+2*Z(75)*Z(57)+2*Z(77)*Z(53)+2*Z(78)*Z
     &(50)-2*Z(411)*Z(32)-2*Z(412)*Z(43)-2*Z(413)*Z(28)-2*Z(414)*Z(47)-2
     &*Z(410)*Z(2)-Z(76)*Z(39)-Z(76)*Z(61))
      Z(498) = Z(13)*Z(17) - Z(14)*Z(18)
      Z(495) = Z(19)*Z(17) + Z(20)*Z(18)
      Z(113) = Z(1)*Z(64) + Z(2)*Z(65)
      Z(501) = Z(5)*Z(113) + Z(6)*Z(115)
      Z(419) = Z(42)*Z(64) + Z(43)*Z(65)
      Z(420) = Z(44)*Z(64) + Z(45)*Z(65)
      Z(505) = Z(19)*Z(419) + Z(20)*Z(420)
      Z(415) = Z(31)*Z(64) + Z(32)*Z(65)
      Z(423) = Z(27)*Z(64) + Z(28)*Z(65)
      Z(427) = Z(46)*Z(64) + Z(47)*Z(65)
      Z(516) = LFF + Z(509)*Z(17) + Z(510)*Z(498) + 0.5D0*Z(76)*Z(495) +
     & Z(511)*Z(501) + 0.5D0*Z(76)*Z(505) - LFFO - Z(74) - Z(512)*Z(415)
     & - Z(513)*Z(423) - Z(514)*Z(427) - Z(73)*Z(113) - 0.5D0*Z(515)*Z(4
     &19)
      Z(582) = MFF*Z(516)
      Z(519) = Z(271) + Z(256)*U8 + Z(257)*U6 + Z(258)*U4 + Z(267)*U3 + 
     &Z(268)*U5 + Z(269)*U7 + Z(270)*U9 + Z(262)*U1 + Z(263)*U2
      Z(421) = Z(42)*Z(66) + Z(43)*Z(67)
      Z(435) = Z(17)*Z(419) - Z(18)*Z(421)
      Z(437) = Z(17)*Z(421) + Z(18)*Z(419)
      Z(467) = Z(13)*Z(435) - Z(14)*Z(437)
      Z(422) = Z(44)*Z(66) + Z(45)*Z(67)
      Z(436) = Z(17)*Z(420) - Z(18)*Z(422)
      Z(438) = Z(17)*Z(422) + Z(18)*Z(420)
      Z(468) = Z(13)*Z(436) - Z(14)*Z(438)
      Z(542) = Z(19)*Z(467) + Z(20)*Z(468)
      Z(475) = Z(9)*Z(169) + Z(10)*Z(170)
      Z(417) = Z(31)*Z(66) + Z(32)*Z(67)
      Z(431) = Z(17)*Z(415) - Z(18)*Z(417)
      Z(433) = Z(17)*Z(417) + Z(18)*Z(415)
      Z(463) = Z(13)*Z(431) - Z(14)*Z(433)
      Z(425) = Z(27)*Z(66) + Z(28)*Z(67)
      Z(439) = Z(17)*Z(423) - Z(18)*Z(425)
      Z(441) = Z(17)*Z(425) + Z(18)*Z(423)
      Z(471) = Z(13)*Z(439) - Z(14)*Z(441)
      Z(89) = Z(1)*Z(52) + Z(2)*Z(53)
      Z(546) = LSH + Z(511)*Z(9) + 0.5D0*Z(76)*Z(396) + 0.5D0*Z(76)*Z(54
     &2) - LSHO - Z(77) - Z(74)*Z(498) - Z(75)*Z(13) - Z(514)*Z(475) - Z
     &(512)*Z(463) - Z(513)*Z(471) - Z(73)*Z(89) - 0.5D0*Z(515)*Z(467)
      Z(590) = MSH*Z(546)
      Z(548) = Z(210) + Z(70)*U7 + Z(199)*U8 + Z(200)*U6 + Z(201)*U4 + Z
     &(208)*U3 + Z(209)*U5 + Z(203)*U1 + Z(204)*U2
      Z(216) = Z(1)*Z(60) + Z(2)*Z(61)
      Z(530) = Z(5)*Z(216) + Z(6)*Z(218)
      Z(95) = Z(1)*Z(42) + Z(2)*Z(43)
      Z(483) = Z(5)*Z(95) + Z(6)*Z(97)
      Z(484) = Z(5)*Z(96) + Z(6)*Z(98)
      Z(549) = Z(19)*Z(483) + Z(20)*Z(484)
      Z(487) = Z(5)*Z(24) + Z(6)*Z(25)
      Z(101) = Z(1)*Z(56) + Z(2)*Z(57)
      Z(526) = Z(5)*Z(101) + Z(6)*Z(103)
      Z(107) = Z(1)*Z(31) + Z(2)*Z(32)
      Z(479) = Z(5)*Z(107) + Z(6)*Z(109)
      Z(553) = LTH + 0.5D0*Z(76)*Z(530) + 0.5D0*Z(76)*Z(549) - LTHO - Z(
     &78) - Z(77)*Z(9) - Z(513)*Z(487) - Z(514)*Z(169) - Z(5)*Z(73) - Z(
     &74)*Z(501) - Z(75)*Z(526) - Z(512)*Z(479) - 0.5D0*Z(515)*Z(483)
      Z(592) = MTH*Z(553)
      Z(556) = Z(186) + Z(71)*U5 + Z(178)*U8 + Z(179)*U6 + Z(180)*U4 + Z
     &(185)*U3 + Z(181)*U1 + Z(182)*U2
      Z(389) = Z(7)*Z(21) - Z(8)*Z(22)
      Z(447) = Z(19)*Z(431) + Z(20)*Z(433)
      Z(557) = Z(79) + Z(81)*Z(21) + Z(82)*Z(389) + 0.5D0*Z(76)*Z(399) +
     & 0.5D0*Z(80)*Z(15) + 0.5D0*Z(76)*Z(447) - LFFO - Z(74)*Z(415) - Z(
     &75)*Z(431) - Z(77)*Z(463) - Z(78)*Z(479) - Z(73)*Z(107)
      Z(594) = MFF*Z(557)
      Z(560) = Z(33)*U1 + Z(34)*U2 - Z(118) - LFFO*U3 - LFFO*U4 - LFFO*U
     &6 - LFFO*U8
      Z(455) = Z(19)*Z(439) + Z(20)*Z(441)
      Z(565) = Z(81) + Z(82)*Z(7) + 0.5D0*Z(76)*Z(35) + 0.5D0*Z(76)*Z(45
     &5) - LSHO - Z(78)*Z(487) - Z(512)*Z(21) - Z(24)*Z(73) - 0.5D0*Z(51
     &5)*Z(11) - Z(74)*Z(423) - Z(75)*Z(439) - Z(77)*Z(471)
      Z(602) = MSH*Z(565)
      Z(568) = Z(149) + Z(142)*U8 + Z(148)*U3 + Z(148)*U4 + Z(148)*U6 + 
     &Z(143)*U1 + Z(144)*U2
      Z(491) = Z(19)*Z(393) + Z(20)*Z(395)
      Z(429) = Z(46)*Z(66) + Z(47)*Z(67)
      Z(443) = Z(17)*Z(427) - Z(18)*Z(429)
      Z(445) = Z(17)*Z(429) + Z(18)*Z(427)
      Z(459) = Z(19)*Z(443) + Z(20)*Z(445)
      Z(569) = Z(82) + 0.5D0*Z(76)*Z(491) + 0.5D0*Z(76)*Z(459) - LTHO - 
     &Z(77)*Z(475) - Z(78)*Z(169) - Z(512)*Z(389) - Z(513)*Z(7) - Z(3)*Z
     &(73) - 0.5D0*Z(515)*Z(393) - Z(74)*Z(427) - Z(75)*Z(443)
      Z(604) = MTH*Z(569)
      Z(572) = Z(165) + Z(158)*U8 + Z(159)*U6 + Z(164)*U3 + Z(164)*U4 + 
     &Z(160)*U1 + Z(161)*U2
      Z(580) = MHAT*(2*Z(413)+Z(76)*Z(35)+2*Z(411)*Z(21)+2*Z(412)*Z(11)+
     &2*Z(414)*Z(7)+2*Z(24)*Z(410)+Z(76)*Z(455)-2*Z(78)*Z(487)-2*Z(74)*Z
     &(423)-2*Z(75)*Z(439)-2*Z(77)*Z(471))
      Z(534) = Z(19)*Z(435) + Z(20)*Z(436)
      Z(585) = MRF*(Z(584)+2*Z(510)*Z(13)+Z(76)*Z(534)+2*Z(411)*Z(431)+2
     &*Z(412)*Z(435)+2*Z(413)*Z(439)+2*Z(414)*Z(443)+2*Z(511)*Z(526)-2*Z
     &(74)*Z(17)-2*Z(73)*Z(101))
      Z(522) = Z(220) + Z(69)*U3 + Z(69)*U5 + Z(69)*U7 + Z(69)*U9
      Z(451) = Z(19)*Z(435) + Z(20)*Z(437)
      Z(452) = Z(19)*Z(436) + Z(20)*Z(438)
      Z(538) = Z(19)*Z(451) + Z(20)*Z(452)
      Z(587) = MRF*(Z(586)+2*Z(510)*Z(396)+Z(76)*Z(538)+2*Z(411)*Z(447)+
     &2*Z(412)*Z(451)+2*Z(413)*Z(455)+2*Z(414)*Z(459)+2*Z(511)*Z(530)-2*
     &Z(74)*Z(495)-2*Z(73)*Z(216))
      Z(523) = -0.5D0*Z(221) - 0.5D0*LRFFO*U3 - 0.5D0*LRFFO*U5 - 0.5D0*L
     &RFFO*U7 - 0.5D0*LRFFO*U9
      Z(589) = MRF*(2*Z(510)+2*Z(414)*Z(475)+2*Z(511)*Z(9)+2*Z(520)*Z(13
     &)+2*Z(521)*Z(396)+Z(76)*Z(542)+2*Z(411)*Z(463)+2*Z(412)*Z(467)+2*Z
     &(413)*Z(471)-2*Z(74)*Z(498)-2*Z(73)*Z(89))
      Z(525) = Z(214) + LSH*U7 + Z(199)*U8 + Z(200)*U6 + Z(201)*U4 + Z(2
     &12)*U3 + Z(213)*U5 + Z(203)*U1 + Z(204)*U2
      Z(597) = MRF*(2*Z(411)+2*Z(81)*Z(21)+2*Z(82)*Z(389)+2*Z(521)*Z(399
     &)+2*Z(561)*Z(15)+Z(76)*Z(447)-2*Z(74)*Z(415)-2*Z(75)*Z(431)-2*Z(77
     &)*Z(463)-2*Z(78)*Z(479)-2*Z(73)*Z(107))
      Z(562) = Z(33)*U1 + Z(34)*U2 - Z(119) - LFF*U3 - LFF*U4 - LFF*U6 -
     & LFF*U8
      Z(599) = MRF*(Z(598)+2*Z(81)*Z(11)+2*Z(82)*Z(393)+2*Z(411)*Z(15)+Z
     &(76)*Z(451)-2*Z(74)*Z(419)-2*Z(75)*Z(435)-2*Z(77)*Z(467)-2*Z(78)*Z
     &(483)-2*Z(73)*Z(95))
      Z(563) = -0.5D0*Z(125) - 0.5D0*LRFO*U3 - 0.5D0*LRFO*U4 - 0.5D0*LRF
     &O*U6 - 0.5D0*LRFO*U8
      Z(121) = Z(1)*Z(38) + Z(2)*Z(39)
      Z(601) = MRF*(Z(600)+2*Z(81)*Z(35)+2*Z(82)*Z(491)+2*Z(411)*Z(399)+
     &Z(76)*Z(538)-2*Z(74)*Z(505)-2*Z(75)*Z(534)-2*Z(77)*Z(542)-2*Z(78)*
     &Z(549)-2*Z(73)*Z(121))
      Z(564) = -0.5D0*Z(126) - 0.5D0*LRFFO*U3 - 0.5D0*LRFFO*U4 - 0.5D0*L
     &RFFO*U6 - 0.5D0*LRFFO*U8
      Z(575) = MHAT*(2*Z(74)*Z(64)+2*Z(75)*Z(56)+2*Z(77)*Z(52)+2*Z(78)*Z
     &(49)-2*Z(411)*Z(31)-2*Z(412)*Z(42)-2*Z(413)*Z(27)-2*Z(414)*Z(46)-2
     &*Z(410)*Z(1)-Z(76)*Z(38)-Z(76)*Z(60))
      Z(499) = -Z(13)*Z(18) - Z(14)*Z(17)
      Z(496) = Z(20)*Z(17) - Z(19)*Z(18)
      Z(114) = Z(1)*Z(66) + Z(2)*Z(67)
      Z(116) = Z(1)*Z(67) - Z(2)*Z(66)
      Z(502) = Z(5)*Z(114) + Z(6)*Z(116)
      Z(506) = Z(19)*Z(421) + Z(20)*Z(422)
      Z(517) = Z(510)*Z(499) + 0.5D0*Z(76)*Z(496) + Z(511)*Z(502) + 0.5D
     &0*Z(76)*Z(506) - Z(509)*Z(18) - Z(512)*Z(417) - Z(513)*Z(425) - Z(
     &514)*Z(429) - Z(73)*Z(114) - 0.5D0*Z(515)*Z(421)
      Z(583) = MFF*Z(517)
      Z(518) = Z(254) + Z(245)*U3 + Z(246)*U4 + Z(247)*U6 + Z(248)*U8 + 
     &Z(249)*U5 + Z(250)*U7 + Z(253)*U9 + Z(251)*U1 + Z(252)*U2
      Z(469) = Z(13)*Z(437) + Z(14)*Z(435)
      Z(470) = Z(13)*Z(438) + Z(14)*Z(436)
      Z(543) = Z(19)*Z(469) + Z(20)*Z(470)
      Z(500) = Z(13)*Z(18) + Z(14)*Z(17)
      Z(477) = Z(9)*Z(170) - Z(10)*Z(169)
      Z(465) = Z(13)*Z(433) + Z(14)*Z(431)
      Z(473) = Z(13)*Z(441) + Z(14)*Z(439)
      Z(90) = Z(1)*Z(54) + Z(2)*Z(55)
      Z(547) = 0.5D0*Z(76)*Z(397) + 0.5D0*Z(76)*Z(543) - Z(74)*Z(500) - 
     &Z(75)*Z(14) - Z(511)*Z(10) - Z(514)*Z(477) - Z(512)*Z(465) - Z(513
     &)*Z(473) - Z(73)*Z(90) - 0.5D0*Z(515)*Z(469)
      Z(591) = MSH*Z(547)
      Z(524) = Z(197) + Z(190)*U3 + Z(191)*U4 + Z(192)*U6 + Z(193)*U8 + 
     &Z(196)*U5 + Z(194)*U1 + Z(195)*U2
      Z(532) = Z(5)*Z(218) - Z(6)*Z(216)
      Z(485) = Z(5)*Z(97) - Z(6)*Z(95)
      Z(486) = Z(5)*Z(98) - Z(6)*Z(96)
      Z(550) = Z(19)*Z(485) + Z(20)*Z(486)
      Z(489) = Z(5)*Z(25) - Z(6)*Z(24)
      Z(503) = Z(5)*Z(115) - Z(6)*Z(113)
      Z(528) = Z(5)*Z(103) - Z(6)*Z(101)
      Z(481) = Z(5)*Z(109) - Z(6)*Z(107)
      Z(554) = Z(6)*Z(73) + 0.5D0*Z(76)*Z(532) + 0.5D0*Z(76)*Z(550) - Z(
     &77)*Z(10) - Z(513)*Z(489) - Z(514)*Z(170) - Z(74)*Z(503) - Z(75)*Z
     &(528) - Z(512)*Z(481) - 0.5D0*Z(515)*Z(485)
      Z(593) = MTH*Z(554)
      Z(555) = Z(177) + Z(172)*U3 + Z(172)*U4 + Z(173)*U6 + Z(174)*U8 + 
     &Z(175)*U1 + Z(176)*U2
      Z(416) = Z(33)*Z(64) + Z(34)*Z(65)
      Z(418) = Z(33)*Z(66) + Z(34)*Z(67)
      Z(432) = Z(17)*Z(416) - Z(18)*Z(418)
      Z(434) = Z(17)*Z(418) + Z(18)*Z(416)
      Z(448) = Z(19)*Z(432) + Z(20)*Z(434)
      Z(464) = Z(13)*Z(432) - Z(14)*Z(434)
      Z(480) = Z(5)*Z(108) + Z(6)*Z(110)
      Z(558) = Z(81)*Z(23) + Z(82)*Z(391) + 0.5D0*Z(76)*Z(401) + 0.5D0*Z
     &(76)*Z(448) - 0.5D0*Z(80)*Z(16) - Z(74)*Z(416) - Z(75)*Z(432) - Z(
     &77)*Z(464) - Z(78)*Z(480) - Z(73)*Z(108)
      Z(595) = MFF*Z(558)
      Z(559) = Z(31)*U1 + Z(32)*U2
      Z(424) = Z(29)*Z(64) + Z(30)*Z(65)
      Z(426) = Z(29)*Z(66) + Z(30)*Z(67)
      Z(440) = Z(17)*Z(424) - Z(18)*Z(426)
      Z(442) = Z(17)*Z(426) + Z(18)*Z(424)
      Z(456) = Z(19)*Z(440) + Z(20)*Z(442)
      Z(488) = Z(5)*Z(26) + Z(6)*Z(24)
      Z(472) = Z(13)*Z(440) - Z(14)*Z(442)
      Z(566) = 0.5D0*Z(76)*Z(36) + 0.5D0*Z(76)*Z(456) - Z(78)*Z(488) - Z
     &(82)*Z(8) - Z(512)*Z(22) - Z(26)*Z(73) - 0.5D0*Z(515)*Z(12) - Z(74
     &)*Z(424) - Z(75)*Z(440) - Z(77)*Z(472)
      Z(603) = MSH*Z(566)
      Z(567) = Z(141) + Z(138)*U3 + Z(138)*U4 + Z(138)*U6 + Z(138)*U8 + 
     &Z(139)*U1 + Z(140)*U2
      Z(492) = Z(19)*Z(394) + Z(20)*Z(393)
      Z(428) = Z(46)*Z(65) + Z(48)*Z(64)
      Z(430) = Z(46)*Z(67) + Z(48)*Z(66)
      Z(444) = Z(17)*Z(428) - Z(18)*Z(430)
      Z(446) = Z(17)*Z(430) + Z(18)*Z(428)
      Z(460) = Z(19)*Z(444) + Z(20)*Z(446)
      Z(476) = Z(9)*Z(171) + Z(10)*Z(169)
      Z(570) = Z(4)*Z(73) + 0.5D0*Z(76)*Z(492) + 0.5D0*Z(76)*Z(460) - Z(
     &77)*Z(476) - Z(78)*Z(171) - Z(512)*Z(390) - Z(513)*Z(8) - 0.5D0*Z(
     &515)*Z(394) - Z(74)*Z(428) - Z(75)*Z(444)
      Z(605) = MTH*Z(570)
      Z(571) = Z(157) + Z(153)*U3 + Z(153)*U4 + Z(153)*U6 + Z(154)*U8 + 
     &Z(155)*U1 + Z(156)*U2
      Z(573) = MHAT*(2*Z(78)*Z(5)+2*Z(74)*Z(113)+2*Z(75)*Z(101)+2*Z(77)*
     &Z(89)-2*Z(410)-2*Z(413)*Z(24)-2*Z(414)*Z(3)-2*Z(411)*Z(107)-2*Z(41
     &2)*Z(95)-Z(76)*Z(121)-Z(76)*Z(216))
      Z(577) = MHAT*(2*Z(74)*Z(415)+2*Z(75)*Z(431)+2*Z(77)*Z(463)+2*Z(78
     &)*Z(479)-2*Z(411)-2*Z(412)*Z(15)-2*Z(413)*Z(21)-2*Z(414)*Z(389)-Z(
     &76)*Z(399)-2*Z(410)*Z(107)-Z(76)*Z(447))
      Z(579) = MHAT*(2*Z(74)*Z(419)+2*Z(75)*Z(435)+2*Z(77)*Z(467)+2*Z(78
     &)*Z(483)-2*Z(412)-Z(578)-2*Z(411)*Z(15)-2*Z(413)*Z(11)-2*Z(414)*Z(
     &393)-2*Z(410)*Z(95)-Z(76)*Z(451))
      Z(581) = MHAT*(2*Z(77)*Z(475)+2*Z(78)*Z(169)+2*Z(74)*Z(427)+2*Z(75
     &)*Z(443)-2*Z(414)-2*Z(411)*Z(389)-2*Z(412)*Z(393)-2*Z(413)*Z(7)-2*
     &Z(3)*Z(410)-Z(76)*Z(491)-Z(76)*Z(459))
      Z(588) = MRF*(2*Z(414)*Z(477)+2*Z(520)*Z(14)+2*Z(521)*Z(397)+Z(76)
     &*Z(543)+2*Z(411)*Z(465)+2*Z(412)*Z(469)+2*Z(413)*Z(473)-2*Z(74)*Z(
     &500)-2*Z(511)*Z(10)-2*Z(73)*Z(90))
      Z(596) = MRF*(2*Z(81)*Z(23)+2*Z(82)*Z(391)+2*Z(521)*Z(401)+Z(76)*Z
     &(448)-2*Z(561)*Z(16)-2*Z(74)*Z(416)-2*Z(75)*Z(432)-2*Z(77)*Z(464)-
     &2*Z(78)*Z(480)-2*Z(73)*Z(108))
      HZ = Z(402) + Z(403) + Z(404) + Z(405) + Z(406) + Z(407) + Z(408) 
     &+ Z(409) + 0.5D0*Z(574) + IFF*U4 + IFF*U5 + IFF*U6 + IFF*U7 + IFF*
     &U8 + IFF*U9 + IHAT*U3 + IRF*U4 + IRF*U5 + IRF*U6 + IRF*U7 + IRF*U8
     & + IRF*U9 + ISH*U4 + ISH*U5 + ISH*U6 + ISH*U7 + ITH*U4 + ITH*U5 + 
     &0.5D0*Z(576)*U1 + 2*IFF*U3 + 2*IRF*U3 + 2*ISH*U3 + 2*ITH*U3 + Z(58
     &2)*Z(519) + Z(590)*Z(548) + Z(592)*Z(556) + Z(594)*Z(560) + Z(602)
     &*Z(568) + Z(604)*Z(572) + 0.5D0*Z(580)*Z(363) + 0.5D0*Z(585)*Z(522
     &) + 0.5D0*Z(587)*Z(523) + 0.5D0*Z(589)*Z(525) + 0.5D0*Z(597)*Z(562
     &) + 0.5D0*Z(599)*Z(563) + 0.5D0*Z(601)*Z(564) - 0.5D0*Z(575)*U2 - 
     &Z(583)*Z(518) - Z(591)*Z(524) - Z(593)*Z(555) - Z(595)*Z(559) - Z(
     &603)*Z(567) - Z(605)*Z(571) - 0.5D0*Z(573)*Z(360) - 0.5D0*Z(577)*Z
     &(361) - 0.5D0*Z(579)*Z(362) - 0.5D0*Z(581)*Z(364) - 0.5D0*Z(588)*Z
     &(524) - 0.5D0*Z(596)*Z(559)
      Z(606) = MHAT*HATOp
      Z(688) = MFF*Z(31)
      Z(689) = MFF*Z(32)
      Z(694) = MRF*Z(31)
      Z(695) = MRF*Z(32)
      Z(637) = MRF*Z(220)
      Z(706) = MSH*Z(141)
      Z(703) = MSH*Z(138)
      Z(704) = MSH*Z(139)
      Z(705) = MSH*Z(140)
      Z(716) = MTH*Z(157)
      Z(712) = MTH*Z(153)
      Z(713) = MTH*Z(154)
      Z(714) = MTH*Z(155)
      Z(715) = MTH*Z(156)
      Z(679) = MTH*Z(177)
      Z(674) = MTH*Z(172)
      Z(675) = MTH*Z(173)
      Z(676) = MTH*Z(174)
      Z(677) = MTH*Z(175)
      Z(678) = MTH*Z(176)
      Z(687) = MTH*Z(186)
      Z(681) = MTH*Z(178)
      Z(682) = MTH*Z(179)
      Z(683) = MTH*Z(180)
      Z(684) = MTH*Z(185)
      Z(685) = MTH*Z(181)
      Z(686) = MTH*Z(182)
      Z(625) = MFF*Z(254)
      Z(616) = MFF*Z(245)
      Z(617) = MFF*Z(246)
      Z(618) = MFF*Z(247)
      Z(619) = MFF*Z(248)
      Z(620) = MFF*Z(249)
      Z(621) = MFF*Z(250)
      Z(622) = MFF*Z(253)
      Z(623) = MFF*Z(251)
      Z(624) = MFF*Z(252)
      Z(635) = MFF*Z(271)
      Z(626) = MFF*Z(256)
      Z(627) = MFF*Z(257)
      Z(628) = MFF*Z(258)
      Z(629) = MFF*Z(267)
      Z(630) = MFF*Z(268)
      Z(631) = MFF*Z(269)
      Z(632) = MFF*Z(270)
      Z(633) = MFF*Z(262)
      Z(634) = MFF*Z(263)
      Z(647) = MRF*Z(197)
      Z(664) = MSH*Z(197)
      Z(640) = MRF*Z(190)
      Z(641) = MRF*Z(191)
      Z(642) = MRF*Z(192)
      Z(643) = MRF*Z(193)
      Z(644) = MRF*Z(196)
      Z(657) = MSH*Z(190)
      Z(658) = MSH*Z(191)
      Z(659) = MSH*Z(192)
      Z(660) = MSH*Z(193)
      Z(661) = MSH*Z(196)
      Z(645) = MRF*Z(194)
      Z(646) = MRF*Z(195)
      Z(662) = MSH*Z(194)
      Z(663) = MSH*Z(195)
      Z(656) = MRF*Z(214)
      Z(673) = MSH*Z(210)
      Z(649) = MRF*Z(199)
      Z(650) = MRF*Z(200)
      Z(651) = MRF*Z(201)
      Z(652) = MRF*Z(212)
      Z(653) = MRF*Z(213)
      Z(666) = MSH*Z(199)
      Z(667) = MSH*Z(200)
      Z(668) = MSH*Z(201)
      Z(669) = MSH*Z(208)
      Z(670) = MSH*Z(209)
      Z(654) = MRF*Z(203)
      Z(655) = MRF*Z(204)
      Z(671) = MSH*Z(203)
      Z(672) = MSH*Z(204)
      Z(607) = MHAT*HATO
      Z(40) = Z(35)*Z(29) + Z(37)*Z(27)
      Z(702) = MRF*Z(126)
      Z(62) = Z(19)*Z(58) - Z(20)*Z(56)
      Z(639) = MRF*Z(221)
      Z(701) = MRF*Z(125)
      Z(611) = MHAT*Z(279)
      Z(615) = MHAT*Z(166)
      Z(722) = MTH*Z(165)
      Z(717) = MTH*Z(158)
      Z(718) = MTH*Z(159)
      Z(719) = MTH*Z(164)
      Z(720) = MTH*Z(160)
      Z(721) = MTH*Z(161)
      Z(613) = MHAT*Z(280)
      Z(711) = MSH*Z(149)
      Z(707) = MSH*Z(142)
      Z(708) = MSH*Z(148)
      Z(709) = MSH*Z(143)
      Z(710) = MSH*Z(144)
      Z(609) = MHAT*Z(278)
      Z(693) = MFF*Z(118)
      Z(699) = MRF*Z(119)
      Z(690) = MFF*Z(33)
      Z(691) = MFF*Z(34)
      Z(696) = MRF*Z(33)
      Z(697) = MRF*Z(34)
      PX = Z(606)*Z(1) + MHAT*U1 + Z(31)*(Z(688)*U1+Z(689)*U2+Z(694)*U1+
     &Z(695)*U2) + Z(58)*(Z(637)+Z(636)*U3+Z(636)*U5+Z(636)*U7+Z(636)*U9
     &) + Z(27)*(Z(706)+Z(703)*U3+Z(703)*U4+Z(703)*U6+Z(703)*U8+Z(704)*U
     &1+Z(705)*U2) + Z(46)*(Z(716)+Z(712)*U3+Z(712)*U4+Z(712)*U6+Z(713)*
     &U8+Z(714)*U1+Z(715)*U2) + Z(49)*(Z(679)+Z(674)*U3+Z(674)*U4+Z(675)
     &*U6+Z(676)*U8+Z(677)*U1+Z(678)*U2) + Z(51)*(Z(687)+Z(680)*U5+Z(681
     &)*U8+Z(682)*U6+Z(683)*U4+Z(684)*U3+Z(685)*U1+Z(686)*U2) + Z(64)*(Z
     &(625)+Z(616)*U3+Z(617)*U4+Z(618)*U6+Z(619)*U8+Z(620)*U5+Z(621)*U7+
     &Z(622)*U9+Z(623)*U1+Z(624)*U2) + Z(66)*(Z(635)+Z(626)*U8+Z(627)*U6
     &+Z(628)*U4+Z(629)*U3+Z(630)*U5+Z(631)*U7+Z(632)*U9+Z(633)*U1+Z(634
     &)*U2) + Z(52)*(Z(647)+Z(664)+Z(640)*U3+Z(641)*U4+Z(642)*U6+Z(643)*
     &U8+Z(644)*U5+Z(657)*U3+Z(658)*U4+Z(659)*U6+Z(660)*U8+Z(661)*U5+Z(6
     &45)*U1+Z(646)*U2+Z(662)*U1+Z(663)*U2) + Z(54)*(Z(656)+Z(673)+Z(648
     &)*U7+Z(665)*U7+Z(649)*U8+Z(650)*U6+Z(651)*U4+Z(652)*U3+Z(653)*U5+Z
     &(666)*U8+Z(667)*U6+Z(668)*U4+Z(669)*U3+Z(670)*U5+Z(654)*U1+Z(655)*
     &U2+Z(671)*U1+Z(672)*U2) - Z(607)*Z(2)*U3 - 0.5D0*Z(40)*(Z(702)+Z(6
     &38)*U3+Z(638)*U4+Z(638)*U6+Z(638)*U8) - 0.5D0*Z(62)*(Z(639)+Z(638)
     &*U3+Z(638)*U5+Z(638)*U7+Z(638)*U9) - 0.5D0*Z(44)*(Z(701)+2*Z(611)+
     &Z(700)*U3+Z(700)*U4+Z(700)*U6+Z(700)*U8+2*Z(610)*U3+2*Z(610)*U4+2*
     &Z(610)*U6+2*Z(610)*U8) - Z(48)*(Z(615)+Z(614)*U3+Z(614)*U4-Z(722)-
     &Z(717)*U8-Z(718)*U6-Z(719)*U3-Z(719)*U4-Z(720)*U1-Z(721)*U2) - Z(2
     &9)*(Z(613)+Z(612)*U3+Z(612)*U4+Z(612)*U6-Z(711)-Z(707)*U8-Z(708)*U
     &3-Z(708)*U4-Z(708)*U6-Z(709)*U1-Z(710)*U2) - Z(33)*(Z(609)+Z(693)+
     &Z(699)+Z(608)*U3+Z(608)*U4+Z(608)*U6+Z(608)*U8+Z(692)*U3+Z(692)*U4
     &+Z(692)*U6+Z(692)*U8+Z(698)*U3+Z(698)*U4+Z(698)*U6+Z(698)*U8-Z(690
     &)*U1-Z(691)*U2-Z(696)*U1-Z(697)*U2)
      PY = Z(606)*Z(2) + MHAT*U2 + Z(607)*Z(1)*U3 + Z(32)*(Z(688)*U1+Z(6
     &89)*U2+Z(694)*U1+Z(695)*U2) + Z(59)*(Z(637)+Z(636)*U3+Z(636)*U5+Z(
     &636)*U7+Z(636)*U9) + Z(28)*(Z(706)+Z(703)*U3+Z(703)*U4+Z(703)*U6+Z
     &(703)*U8+Z(704)*U1+Z(705)*U2) + Z(47)*(Z(716)+Z(712)*U3+Z(712)*U4+
     &Z(712)*U6+Z(713)*U8+Z(714)*U1+Z(715)*U2) + Z(50)*(Z(679)+Z(674)*U3
     &+Z(674)*U4+Z(675)*U6+Z(676)*U8+Z(677)*U1+Z(678)*U2) + Z(49)*(Z(687
     &)+Z(680)*U5+Z(681)*U8+Z(682)*U6+Z(683)*U4+Z(684)*U3+Z(685)*U1+Z(68
     &6)*U2) + Z(65)*(Z(625)+Z(616)*U3+Z(617)*U4+Z(618)*U6+Z(619)*U8+Z(6
     &20)*U5+Z(621)*U7+Z(622)*U9+Z(623)*U1+Z(624)*U2) + Z(67)*(Z(635)+Z(
     &626)*U8+Z(627)*U6+Z(628)*U4+Z(629)*U3+Z(630)*U5+Z(631)*U7+Z(632)*U
     &9+Z(633)*U1+Z(634)*U2) + Z(53)*(Z(647)+Z(664)+Z(640)*U3+Z(641)*U4+
     &Z(642)*U6+Z(643)*U8+Z(644)*U5+Z(657)*U3+Z(658)*U4+Z(659)*U6+Z(660)
     &*U8+Z(661)*U5+Z(645)*U1+Z(646)*U2+Z(662)*U1+Z(663)*U2) + Z(55)*(Z(
     &656)+Z(673)+Z(648)*U7+Z(665)*U7+Z(649)*U8+Z(650)*U6+Z(651)*U4+Z(65
     &2)*U3+Z(653)*U5+Z(666)*U8+Z(667)*U6+Z(668)*U4+Z(669)*U3+Z(670)*U5+
     &Z(654)*U1+Z(655)*U2+Z(671)*U1+Z(672)*U2) - 0.5D0*Z(41)*(Z(702)+Z(6
     &38)*U3+Z(638)*U4+Z(638)*U6+Z(638)*U8) - 0.5D0*Z(63)*(Z(639)+Z(638)
     &*U3+Z(638)*U5+Z(638)*U7+Z(638)*U9) - 0.5D0*Z(45)*(Z(701)+2*Z(611)+
     &Z(700)*U3+Z(700)*U4+Z(700)*U6+Z(700)*U8+2*Z(610)*U3+2*Z(610)*U4+2*
     &Z(610)*U6+2*Z(610)*U8) - Z(46)*(Z(615)+Z(614)*U3+Z(614)*U4-Z(722)-
     &Z(717)*U8-Z(718)*U6-Z(719)*U3-Z(719)*U4-Z(720)*U1-Z(721)*U2) - Z(3
     &0)*(Z(613)+Z(612)*U3+Z(612)*U4+Z(612)*U6-Z(711)-Z(707)*U8-Z(708)*U
     &3-Z(708)*U4-Z(708)*U6-Z(709)*U1-Z(710)*U2) - Z(34)*(Z(609)+Z(693)+
     &Z(699)+Z(608)*U3+Z(608)*U4+Z(608)*U6+Z(608)*U8+Z(692)*U3+Z(692)*U4
     &+Z(692)*U6+Z(692)*U8+Z(698)*U3+Z(698)*U4+Z(698)*U6+Z(698)*U8-Z(690
     &)*U1-Z(691)*U2-Z(696)*U1-Z(697)*U2)
      Z(779) = Z(743) + Z(744) + Z(745) + Z(746) + Z(692)*Z(292) + MFF*(
     &Z(246)*Z(355)+Z(258)*Z(356)) + MSH*(Z(138)*Z(311)+Z(148)*Z(312)) +
     & MSH*(Z(191)*Z(336)+Z(201)*Z(337)) + MTH*(Z(153)*Z(319)+Z(164)*Z(3
     &20)) + MTH*(Z(172)*Z(327)+Z(180)*Z(328)) + 0.25D0*MRF*(LRFFO*Z(298
     &)+LRFO*Z(297)+Z(768)*Z(297)+Z(769)*Z(298)+4*LFF*Z(295)+2*LFF*Z(15)
     &*Z(297)+2*LFF*Z(399)*Z(298)+2*LRFFO*Z(399)*Z(295)+2*LRFO*Z(15)*Z(2
     &95)+Z(770)*Z(300)+2*LFF*Z(16)*Z(300)-Z(771)*Z(301)-2*LFF*Z(401)*Z(
     &301)-2*LRFFO*Z(400)*Z(296)-2*LRFO*Z(16)*Z(296)) - 0.5D0*MRF*(Z(191
     &)*Z(398)*Z(342)+Z(201)*Z(396)*Z(342)+2*Z(14)*Z(191)*Z(341)+2*Z(13)
     &*Z(191)*Z(344)+2*Z(14)*Z(201)*Z(344)-2*Z(13)*Z(201)*Z(341)-2*Z(191
     &)*Z(339)-2*Z(201)*Z(340)-Z(191)*Z(396)*Z(345)-Z(201)*Z(397)*Z(345)
     &) - MHAT*(LFF*Z(16)*Z(374)+LFF*Z(108)*Z(371)+LFF*Z(110)*Z(372)+LRF
     &*Z(12)*Z(375)+LRF*Z(96)*Z(371)+LRF*Z(98)*Z(372)+LSH*Z(8)*Z(376)+LS
     &H*Z(24)*Z(372)+LSH*Z(26)*Z(371)+LTH*Z(3)*Z(372)-LFF*Z(366)-LRF*Z(3
     &69)-LSH*Z(370)-LTH*Z(321)-LFF*Z(15)*Z(369)-LFF*Z(21)*Z(370)-LFF*Z(
     &392)*Z(321)-LRF*Z(11)*Z(370)-LRF*Z(15)*Z(366)-LRF*Z(393)*Z(321)-LS
     &H*Z(7)*Z(321)-LSH*Z(11)*Z(369)-LSH*Z(21)*Z(366)-LTH*Z(7)*Z(370)-LT
     &H*Z(392)*Z(366)-LTH*Z(393)*Z(369)-LFF*Z(23)*Z(375)-LFF*Z(391)*Z(37
     &6)-LRF*Z(16)*Z(373)-LRF*Z(395)*Z(376)-LSH*Z(12)*Z(374)-LSH*Z(22)*Z
     &(373)-LTH*Z(4)*Z(371)-LTH*Z(8)*Z(375)-LTH*Z(390)*Z(373)-LTH*Z(394)
     &*Z(374))
      Z(818) = Z(725)*Z(34) + LFF*(RRX2*Z(33)+RRY2*Z(34)) + 0.5D0*Z(379)
     &*(LRFFO*Z(41)+LRFO*Z(45)+2*LFF*Z(34)) + Z(377)*(LFF*Z(34)+LRF*Z(45
     &)+LSH*Z(30)+LTH*Z(46)) + Z(779) - Z(223)*LRX2*Z(56) - Z(223)*LRY2*
     &Z(57) - Z(234)*LRX2*Z(58) - Z(234)*LRY2*Z(59) - Z(246)*LRX1*Z(64) 
     &- Z(246)*LRY1*Z(65) - Z(258)*LRX1*Z(66) - Z(258)*LRY1*Z(67) - Z(37
     &8)*(Z(246)*Z(65)+Z(258)*Z(67)) - Z(379)*(Z(191)*Z(53)+Z(201)*Z(55)
     &) - Z(380)*(Z(138)*Z(28)+Z(148)*Z(30)) - Z(380)*(Z(191)*Z(53)+Z(20
     &1)*Z(55)) - Z(381)*(Z(153)*Z(47)+Z(164)*Z(46)) - Z(381)*(Z(172)*Z(
     &50)+Z(180)*Z(49))
      Z(776) = Z(775) + MFF*(Z(245)*Z(246)+Z(258)*Z(267)) + MSH*(Z(138)*
     &*2+Z(148)**2) + MSH*(Z(190)*Z(191)+Z(201)*Z(208)) + MTH*(Z(153)**2
     &+Z(164)**2) + MTH*(Z(172)**2+Z(180)*Z(185)) + 0.25D0*MRF*(Z(755)+4
     &*Z(756)*Z(399)+4*Z(757)*Z(15)) + 0.5D0*MRF*(2*Z(190)*Z(191)+2*Z(20
     &1)*Z(212)+2*Z(69)*Z(13)*Z(201)-2*Z(69)*Z(14)*Z(191)-LRFFO*Z(191)*Z
     &(398)-LRFFO*Z(201)*Z(396)) + MHAT*(Z(760)+2*Z(761)*Z(15)+2*Z(762)*
     &Z(21)+2*Z(763)*Z(392)+2*Z(764)*Z(11)+2*Z(765)*Z(393)+2*Z(766)*Z(7)
     &-LSH*HATO*Z(24)-LTH*HATO*Z(3)-LFF*HATO*Z(110)-LRF*HATO*Z(98))
      Z(777) = MFF*(Z(246)*Z(251)+Z(258)*Z(262)) + MRF*(Z(191)*Z(194)+Z(
     &201)*Z(203)) + MSH*(Z(138)*Z(139)+Z(148)*Z(143)) + MSH*(Z(191)*Z(1
     &94)+Z(201)*Z(203)) + MTH*(Z(153)*Z(155)+Z(164)*Z(160)) + MTH*(Z(17
     &2)*Z(175)+Z(180)*Z(181)) - Z(692)*Z(33) - MHAT*(LFF*Z(33)+LRF*Z(44
     &)+LSH*Z(29)+LTH*Z(48)) - 0.5D0*MRF*(2*LFF*Z(33)+LRFFO*Z(399)*Z(33)
     &+LRFFO*Z(400)*Z(31)+LRFO*Z(15)*Z(33)+LRFO*Z(16)*Z(31))
      Z(778) = MFF*(Z(246)*Z(252)+Z(258)*Z(263)) + MRF*(Z(191)*Z(195)+Z(
     &201)*Z(204)) + MSH*(Z(138)*Z(140)+Z(148)*Z(144)) + MSH*(Z(191)*Z(1
     &95)+Z(201)*Z(204)) + MTH*(Z(153)*Z(156)+Z(164)*Z(161)) + MTH*(Z(17
     &2)*Z(176)+Z(180)*Z(182)) - Z(692)*Z(34) - MHAT*(LFF*Z(34)+LRF*Z(45
     &)+LSH*Z(30)+LTH*Z(46)) - 0.5D0*MRF*(2*LFF*Z(34)+LRFFO*Z(399)*Z(34)
     &+LRFFO*Z(400)*Z(32)+LRFO*Z(15)*Z(34)+LRFO*Z(16)*Z(32))
      RHTQ = Z(818) + Z(776)*U3p + Z(777)*U1p + Z(778)*U2p
      Z(784) = Z(736) + Z(738) + Z(740) + Z(742) + Z(680)*Z(328) + MFF*(
     &Z(249)*Z(355)+Z(268)*Z(356)) + MSH*(Z(196)*Z(336)+Z(209)*Z(337)) -
     & 0.25D0*MRF*(2*Z(768)*Z(341)+2*Z(772)*Z(342)+2*Z(196)*Z(398)*Z(342
     &)+2*Z(213)*Z(396)*Z(342)+4*Z(14)*Z(196)*Z(341)+2*Z(770)*Z(344)+2*L
     &RFFO*Z(396)*Z(340)+2*LRFFO*Z(398)*Z(339)+4*Z(69)*Z(14)*Z(339)+4*Z(
     &13)*Z(196)*Z(344)+4*Z(14)*Z(213)*Z(344)-4*Z(69)*Z(341)-LRFFO*Z(342
     &)-4*Z(13)*Z(213)*Z(341)-4*Z(196)*Z(339)-4*Z(213)*Z(340)-2*Z(773)*Z
     &(345)-4*Z(69)*Z(13)*Z(340)-2*Z(196)*Z(396)*Z(345)-2*Z(213)*Z(397)*
     &Z(345))
      Z(819) = 0.5D0*Z(379)*(LRFFO*Z(63)-2*Z(69)*Z(59)-2*Z(196)*Z(53)-2*
     &Z(213)*Z(55)) + Z(784) - Z(728)*Z(49) - Z(226)*LRX2*Z(56) - Z(226)
     &*LRY2*Z(57) - Z(242)*LRX2*Z(58) - Z(242)*LRY2*Z(59) - Z(249)*LRX1*
     &Z(64) - Z(249)*LRY1*Z(65) - Z(274)*LRX1*Z(66) - Z(274)*LRY1*Z(67) 
     &- Z(378)*(Z(249)*Z(65)+Z(268)*Z(67)) - Z(380)*(Z(196)*Z(53)+Z(209)
     &*Z(55))
      Z(781) = Z(780) + Z(680)*Z(185) + MFF*(Z(245)*Z(249)+Z(267)*Z(268)
     &) + MSH*(Z(190)*Z(196)+Z(208)*Z(209)) + 0.25D0*MRF*(Z(758)+4*Z(190
     &)*Z(196)+4*Z(212)*Z(213)+4*Z(69)*Z(13)*Z(212)+4*Z(69)*Z(13)*Z(213)
     &-4*Z(759)-4*Z(69)*Z(14)*Z(190)-4*Z(69)*Z(14)*Z(196)-2*LRFFO*Z(190)
     &*Z(398)-2*LRFFO*Z(196)*Z(398)-2*LRFFO*Z(212)*Z(396)-2*LRFFO*Z(213)
     &*Z(396))
      Z(782) = Z(680)*Z(181) + MFF*(Z(249)*Z(251)+Z(268)*Z(262)) + MSH*(
     &Z(196)*Z(194)+Z(209)*Z(203)) + 0.5D0*MRF*(2*Z(196)*Z(194)+2*Z(213)
     &*Z(203)+2*Z(69)*Z(13)*Z(203)-2*Z(69)*Z(14)*Z(194)-LRFFO*Z(396)*Z(2
     &03)-LRFFO*Z(398)*Z(194))
      Z(783) = Z(680)*Z(182) + MFF*(Z(249)*Z(252)+Z(268)*Z(263)) + MSH*(
     &Z(196)*Z(195)+Z(209)*Z(204)) + 0.5D0*MRF*(2*Z(196)*Z(195)+2*Z(213)
     &*Z(204)+2*Z(69)*Z(13)*Z(204)-2*Z(69)*Z(14)*Z(195)-LRFFO*Z(396)*Z(2
     &04)-LRFFO*Z(398)*Z(195))
      LHTQ = Z(819) + Z(781)*U3p + Z(782)*U1p + Z(783)*U2p
      Z(790) = Z(743) + Z(744) + Z(745) + Z(692)*Z(292) + MFF*(Z(247)*Z(
     &355)+Z(257)*Z(356)) + MSH*(Z(138)*Z(311)+Z(148)*Z(312)) + MSH*(Z(1
     &92)*Z(336)+Z(200)*Z(337)) + MTH*(Z(153)*Z(319)+Z(159)*Z(320)) + MT
     &H*(Z(173)*Z(327)+Z(179)*Z(328)) + 0.25D0*MRF*(LRFFO*Z(298)+LRFO*Z(
     &297)+Z(768)*Z(297)+Z(769)*Z(298)+4*LFF*Z(295)+2*LFF*Z(15)*Z(297)+2
     &*LFF*Z(399)*Z(298)+2*LRFFO*Z(399)*Z(295)+2*LRFO*Z(15)*Z(295)+Z(770
     &)*Z(300)+2*LFF*Z(16)*Z(300)-Z(771)*Z(301)-2*LFF*Z(401)*Z(301)-2*LR
     &FFO*Z(400)*Z(296)-2*LRFO*Z(16)*Z(296)) + MHAT*(LFF*Z(366)+LRF*Z(36
     &9)+LSH*Z(370)+LFF*Z(15)*Z(369)+LFF*Z(21)*Z(370)+LFF*Z(392)*Z(321)+
     &LRF*Z(11)*Z(370)+LRF*Z(15)*Z(366)+LRF*Z(393)*Z(321)+LSH*Z(7)*Z(321
     &)+LSH*Z(11)*Z(369)+LSH*Z(21)*Z(366)+LFF*Z(23)*Z(375)+LFF*Z(391)*Z(
     &376)+LRF*Z(16)*Z(373)+LRF*Z(395)*Z(376)+LSH*Z(12)*Z(374)+LSH*Z(22)
     &*Z(373)-LFF*Z(16)*Z(374)-LFF*Z(108)*Z(371)-LFF*Z(110)*Z(372)-LRF*Z
     &(12)*Z(375)-LRF*Z(96)*Z(371)-LRF*Z(98)*Z(372)-LSH*Z(8)*Z(376)-LSH*
     &Z(24)*Z(372)-LSH*Z(26)*Z(371)) - 0.5D0*MRF*(Z(192)*Z(398)*Z(342)+Z
     &(200)*Z(396)*Z(342)+2*Z(14)*Z(192)*Z(341)+2*Z(13)*Z(192)*Z(344)+2*
     &Z(14)*Z(200)*Z(344)-2*Z(13)*Z(200)*Z(341)-2*Z(192)*Z(339)-2*Z(200)
     &*Z(340)-Z(192)*Z(396)*Z(345)-Z(200)*Z(397)*Z(345))
      Z(820) = Z(725)*Z(34) + LFF*(RRX2*Z(33)+RRY2*Z(34)) + Z(377)*(LFF*
     &Z(34)+LRF*Z(45)+LSH*Z(30)) + 0.5D0*Z(379)*(LRFFO*Z(41)+LRFO*Z(45)+
     &2*LFF*Z(34)) + Z(790) - Z(224)*LRX2*Z(56) - Z(224)*LRY2*Z(57) - Z(
     &233)*LRX2*Z(58) - Z(233)*LRY2*Z(59) - Z(247)*LRX1*Z(64) - Z(247)*L
     &RY1*Z(65) - Z(257)*LRX1*Z(66) - Z(257)*LRY1*Z(67) - Z(378)*(Z(247)
     &*Z(65)+Z(257)*Z(67)) - Z(379)*(Z(192)*Z(53)+Z(200)*Z(55)) - Z(380)
     &*(Z(138)*Z(28)+Z(148)*Z(30)) - Z(380)*(Z(192)*Z(53)+Z(200)*Z(55)) 
     &- Z(381)*(Z(153)*Z(47)+Z(159)*Z(46)) - Z(381)*(Z(173)*Z(50)+Z(179)
     &*Z(49))
      Z(787) = Z(785) + MFF*(Z(245)*Z(247)+Z(257)*Z(267)) + MSH*(Z(138)*
     &*2+Z(148)**2) + MSH*(Z(190)*Z(192)+Z(200)*Z(208)) + MTH*(Z(153)**2
     &+Z(159)*Z(164)) + MTH*(Z(172)*Z(173)+Z(179)*Z(185)) + 0.25D0*MRF*(
     &Z(755)+4*Z(756)*Z(399)+4*Z(757)*Z(15)) + 0.5D0*MRF*(2*Z(190)*Z(192
     &)+2*Z(200)*Z(212)+2*Z(69)*Z(13)*Z(200)-2*Z(69)*Z(14)*Z(192)-LRFFO*
     &Z(192)*Z(398)-LRFFO*Z(200)*Z(396)) + MHAT*(Z(786)+Z(763)*Z(392)+Z(
     &765)*Z(393)+Z(766)*Z(7)+2*Z(761)*Z(15)+2*Z(762)*Z(21)+2*Z(764)*Z(1
     &1)-LSH*HATO*Z(24)-LFF*HATO*Z(110)-LRF*HATO*Z(98))
      Z(788) = MFF*(Z(247)*Z(251)+Z(257)*Z(262)) + MRF*(Z(192)*Z(194)+Z(
     &200)*Z(203)) + MSH*(Z(138)*Z(139)+Z(148)*Z(143)) + MSH*(Z(192)*Z(1
     &94)+Z(200)*Z(203)) + MTH*(Z(153)*Z(155)+Z(159)*Z(160)) + MTH*(Z(17
     &3)*Z(175)+Z(179)*Z(181)) - Z(692)*Z(33) - MHAT*(LFF*Z(33)+LRF*Z(44
     &)+LSH*Z(29)) - 0.5D0*MRF*(2*LFF*Z(33)+LRFFO*Z(399)*Z(33)+LRFFO*Z(4
     &00)*Z(31)+LRFO*Z(15)*Z(33)+LRFO*Z(16)*Z(31))
      Z(789) = MFF*(Z(247)*Z(252)+Z(257)*Z(263)) + MRF*(Z(192)*Z(195)+Z(
     &200)*Z(204)) + MSH*(Z(138)*Z(140)+Z(148)*Z(144)) + MSH*(Z(192)*Z(1
     &95)+Z(200)*Z(204)) + MTH*(Z(153)*Z(156)+Z(159)*Z(161)) + MTH*(Z(17
     &3)*Z(176)+Z(179)*Z(182)) - Z(692)*Z(34) - MHAT*(LFF*Z(34)+LRF*Z(45
     &)+LSH*Z(30)) - 0.5D0*MRF*(2*LFF*Z(34)+LRFFO*Z(399)*Z(34)+LRFFO*Z(4
     &00)*Z(32)+LRFO*Z(15)*Z(34)+LRFO*Z(16)*Z(32))
      RKTQ = Z(820) + Z(787)*U3p + Z(788)*U1p + Z(789)*U2p
      Z(797) = Z(736) + Z(738) + Z(740) + Z(665)*Z(337) + MFF*(Z(250)*Z(
     &355)+Z(269)*Z(356)) + 0.25D0*MRF*(LRFFO*Z(342)+4*Z(69)*Z(341)+4*LS
     &H*Z(13)*Z(341)+2*Z(773)*Z(345)+4*LSH*Z(340)+2*LSH*Z(397)*Z(345)+4*
     &Z(69)*Z(13)*Z(340)-2*Z(768)*Z(341)-2*Z(772)*Z(342)-2*LSH*Z(396)*Z(
     &342)-2*Z(770)*Z(344)-4*LSH*Z(14)*Z(344)-4*Z(69)*Z(14)*Z(339)-2*LRF
     &FO*Z(396)*Z(340)-2*LRFFO*Z(398)*Z(339))
      Z(821) = 0.5D0*Z(379)*(LRFFO*Z(63)-2*LSH*Z(55)-2*Z(69)*Z(59)) + Z(
     &797) - Z(731)*Z(55) - Z(229)*LRX2*Z(56) - Z(229)*LRY2*Z(57) - Z(24
     &3)*LRX2*Z(58) - Z(243)*LRY2*Z(59) - Z(250)*LRX1*Z(64) - Z(250)*LRY
     &1*Z(65) - Z(275)*LRX1*Z(66) - Z(275)*LRY1*Z(67) - Z(378)*(Z(250)*Z
     &(65)+Z(269)*Z(67))
      Z(794) = Z(791) + Z(665)*Z(208) + MFF*(Z(245)*Z(250)+Z(267)*Z(269)
     &) + 0.25D0*MRF*(Z(758)+4*LSH*Z(212)+4*Z(792)*Z(13)+4*Z(69)*Z(13)*Z
     &(212)-4*Z(759)-2*Z(793)*Z(396)-4*Z(69)*Z(14)*Z(190)-2*LRFFO*Z(190)
     &*Z(398)-2*LRFFO*Z(212)*Z(396))
      Z(795) = Z(665)*Z(203) + MFF*(Z(250)*Z(251)+Z(269)*Z(262)) + 0.5D0
     &*MRF*(2*LSH*Z(203)+2*Z(69)*Z(13)*Z(203)-2*Z(69)*Z(14)*Z(194)-LRFFO
     &*Z(396)*Z(203)-LRFFO*Z(398)*Z(194))
      Z(796) = Z(665)*Z(204) + MFF*(Z(250)*Z(252)+Z(269)*Z(263)) + 0.5D0
     &*MRF*(2*LSH*Z(204)+2*Z(69)*Z(13)*Z(204)-2*Z(69)*Z(14)*Z(195)-LRFFO
     &*Z(396)*Z(204)-LRFFO*Z(398)*Z(195))
      LKTQ = Z(821) + Z(794)*U3p + Z(795)*U1p + Z(796)*U2p
      Z(803) = Z(743) + Z(744) + Z(692)*Z(292) + MFF*(Z(248)*Z(355)+Z(25
     &6)*Z(356)) + MSH*(Z(138)*Z(311)+Z(142)*Z(312)) + MSH*(Z(193)*Z(336
     &)+Z(199)*Z(337)) + MTH*(Z(154)*Z(319)+Z(158)*Z(320)) + MTH*(Z(174)
     &*Z(327)+Z(178)*Z(328)) + 0.25D0*MRF*(LRFFO*Z(298)+LRFO*Z(297)+Z(76
     &8)*Z(297)+Z(769)*Z(298)+4*LFF*Z(295)+2*LFF*Z(15)*Z(297)+2*LFF*Z(39
     &9)*Z(298)+2*LRFFO*Z(399)*Z(295)+2*LRFO*Z(15)*Z(295)+Z(770)*Z(300)+
     &2*LFF*Z(16)*Z(300)-Z(771)*Z(301)-2*LFF*Z(401)*Z(301)-2*LRFFO*Z(400
     &)*Z(296)-2*LRFO*Z(16)*Z(296)) + MHAT*(LFF*Z(366)+LRF*Z(369)+LFF*Z(
     &15)*Z(369)+LFF*Z(21)*Z(370)+LFF*Z(392)*Z(321)+LRF*Z(11)*Z(370)+LRF
     &*Z(15)*Z(366)+LRF*Z(393)*Z(321)+LFF*Z(23)*Z(375)+LFF*Z(391)*Z(376)
     &+LRF*Z(16)*Z(373)+LRF*Z(395)*Z(376)-LFF*Z(16)*Z(374)-LFF*Z(108)*Z(
     &371)-LFF*Z(110)*Z(372)-LRF*Z(12)*Z(375)-LRF*Z(96)*Z(371)-LRF*Z(98)
     &*Z(372)) - 0.5D0*MRF*(Z(193)*Z(398)*Z(342)+Z(199)*Z(396)*Z(342)+2*
     &Z(14)*Z(193)*Z(341)+2*Z(13)*Z(193)*Z(344)+2*Z(14)*Z(199)*Z(344)-2*
     &Z(13)*Z(199)*Z(341)-2*Z(193)*Z(339)-2*Z(199)*Z(340)-Z(193)*Z(396)*
     &Z(345)-Z(199)*Z(397)*Z(345))
      Z(822) = Z(725)*Z(34) + LFF*(RRX2*Z(33)+RRY2*Z(34)) + Z(377)*(LFF*
     &Z(34)+LRF*Z(45)) + 0.5D0*Z(379)*(LRFFO*Z(41)+LRFO*Z(45)+2*LFF*Z(34
     &)) + Z(803) - Z(225)*LRX2*Z(56) - Z(225)*LRY2*Z(57) - Z(232)*LRX2*
     &Z(58) - Z(232)*LRY2*Z(59) - Z(248)*LRX1*Z(64) - Z(248)*LRY1*Z(65) 
     &- Z(256)*LRX1*Z(66) - Z(256)*LRY1*Z(67) - Z(378)*(Z(248)*Z(65)+Z(2
     &56)*Z(67)) - Z(379)*(Z(193)*Z(53)+Z(199)*Z(55)) - Z(380)*(Z(138)*Z
     &(28)+Z(142)*Z(30)) - Z(380)*(Z(193)*Z(53)+Z(199)*Z(55)) - Z(381)*(
     &Z(154)*Z(47)+Z(158)*Z(46)) - Z(381)*(Z(174)*Z(50)+Z(178)*Z(49))
      Z(800) = Z(798) + MFF*(Z(245)*Z(248)+Z(256)*Z(267)) + MSH*(Z(138)*
     &*2+Z(142)*Z(148)) + MSH*(Z(190)*Z(193)+Z(199)*Z(208)) + MTH*(Z(153
     &)*Z(154)+Z(158)*Z(164)) + MTH*(Z(172)*Z(174)+Z(178)*Z(185)) + 0.25
     &D0*MRF*(Z(755)+4*Z(756)*Z(399)+4*Z(757)*Z(15)) + 0.5D0*MRF*(2*Z(19
     &0)*Z(193)+2*Z(199)*Z(212)+2*Z(69)*Z(13)*Z(199)-2*Z(69)*Z(14)*Z(193
     &)-LRFFO*Z(193)*Z(398)-LRFFO*Z(199)*Z(396)) + MHAT*(Z(799)+Z(762)*Z
     &(21)+Z(763)*Z(392)+Z(764)*Z(11)+Z(765)*Z(393)+2*Z(761)*Z(15)-LFF*H
     &ATO*Z(110)-LRF*HATO*Z(98))
      Z(801) = MFF*(Z(248)*Z(251)+Z(256)*Z(262)) + MRF*(Z(193)*Z(194)+Z(
     &199)*Z(203)) + MSH*(Z(138)*Z(139)+Z(142)*Z(143)) + MSH*(Z(193)*Z(1
     &94)+Z(199)*Z(203)) + MTH*(Z(154)*Z(155)+Z(158)*Z(160)) + MTH*(Z(17
     &4)*Z(175)+Z(178)*Z(181)) - Z(692)*Z(33) - MHAT*(LFF*Z(33)+LRF*Z(44
     &)) - 0.5D0*MRF*(2*LFF*Z(33)+LRFFO*Z(399)*Z(33)+LRFFO*Z(400)*Z(31)+
     &LRFO*Z(15)*Z(33)+LRFO*Z(16)*Z(31))
      Z(802) = MFF*(Z(248)*Z(252)+Z(256)*Z(263)) + MRF*(Z(193)*Z(195)+Z(
     &199)*Z(204)) + MSH*(Z(138)*Z(140)+Z(142)*Z(144)) + MSH*(Z(193)*Z(1
     &95)+Z(199)*Z(204)) + MTH*(Z(154)*Z(156)+Z(158)*Z(161)) + MTH*(Z(17
     &4)*Z(176)+Z(178)*Z(182)) - Z(692)*Z(34) - MHAT*(LFF*Z(34)+LRF*Z(45
     &)) - 0.5D0*MRF*(2*LFF*Z(34)+LRFFO*Z(399)*Z(34)+LRFFO*Z(400)*Z(32)+
     &LRFO*Z(15)*Z(34)+LRFO*Z(16)*Z(32))
      RATQ = Z(822) + Z(800)*U3p + Z(801)*U1p + Z(802)*U2p
      Z(808) = Z(736) + Z(738) + MFF*(Z(253)*Z(355)+Z(270)*Z(356)) + 0.2
     &5D0*MRF*(LRFFO*Z(342)+4*Z(69)*Z(341)+2*Z(773)*Z(345)+4*Z(69)*Z(13)
     &*Z(340)-2*Z(768)*Z(341)-2*Z(772)*Z(342)-2*Z(770)*Z(344)-4*Z(69)*Z(
     &14)*Z(339)-2*LRFFO*Z(396)*Z(340)-2*LRFFO*Z(398)*Z(339))
      Z(823) = 0.5D0*Z(379)*(LRFFO*Z(63)-2*Z(69)*Z(59)) + Z(808) - Z(253
     &)*LRX1*Z(64) - Z(253)*LRY1*Z(65) - Z(276)*LRX1*Z(66) - Z(276)*LRY1
     &*Z(67) - LRF*(LRX2*Z(58)+LRY2*Z(59)) - Z(378)*(Z(253)*Z(65)+Z(270)
     &*Z(67))
      Z(805) = Z(804) + MFF*(Z(245)*Z(253)+Z(267)*Z(270)) + 0.25D0*MRF*(
     &Z(758)+4*Z(69)*Z(13)*Z(212)-4*Z(759)-4*Z(69)*Z(14)*Z(190)-2*LRFFO*
     &Z(190)*Z(398)-2*LRFFO*Z(212)*Z(396))
      Z(806) = MFF*(Z(253)*Z(251)+Z(270)*Z(262)) + 0.5D0*MRF*(2*Z(69)*Z(
     &13)*Z(203)-2*Z(69)*Z(14)*Z(194)-LRFFO*Z(396)*Z(203)-LRFFO*Z(398)*Z
     &(194))
      Z(807) = MFF*(Z(253)*Z(252)+Z(270)*Z(263)) + 0.5D0*MRF*(2*Z(69)*Z(
     &13)*Z(204)-2*Z(69)*Z(14)*Z(195)-LRFFO*Z(396)*Z(204)-LRFFO*Z(398)*Z
     &(195))
      LATQ = Z(823) + Z(805)*U3p + Z(806)*U1p + Z(807)*U2p
      POP1X = Q1
      POP1Y = Q2
      POP3X = Q1 - LFF*Z(31) - LRFF*Z(38)
      POP3Y = Q2 - LFF*Z(32) - LRFF*Z(39)
      POP4X = Q1 - LFF*Z(31) - LRF*Z(42)
      POP4Y = Q2 - LFF*Z(32) - LRF*Z(43)
      POP5X = Q1 - LFF*Z(31) - LRF*Z(42) - LSH*Z(27)
      POP5Y = Q2 - LFF*Z(32) - LRF*Z(43) - LSH*Z(28)
      POP6X = Q1 - LFF*Z(31) - LRF*Z(42) - LSH*Z(27) - LTH*Z(46)
      POP6Y = Q2 - LFF*Z(32) - LRF*Z(43) - LSH*Z(28) - LTH*Z(47)
      POP7X = Q1 + LTH*Z(49) - LFF*Z(31) - LRF*Z(42) - LSH*Z(27) - LTH*Z
     &(46)
      POP7Y = Q2 + LTH*Z(50) - LFF*Z(32) - LRF*Z(43) - LSH*Z(28) - LTH*Z
     &(47)
      POP8X = Q1 + LSH*Z(52) + LTH*Z(49) - LFF*Z(31) - LRF*Z(42) - LSH*Z
     &(27) - LTH*Z(46)
      POP8Y = Q2 + LSH*Z(53) + LTH*Z(50) - LFF*Z(32) - LRF*Z(43) - LSH*Z
     &(28) - LTH*Z(47)
      POP9X = Q1 + LRF*Z(56) + LSH*Z(52) + LTH*Z(49) - LFF*Z(31) - LRF*Z
     &(42) - LRFF*Z(60) - LSH*Z(27) - LTH*Z(46)
      POP9Y = Q2 + LRF*Z(57) + LSH*Z(53) + LTH*Z(50) - LFF*Z(32) - LRF*Z
     &(43) - LRFF*Z(61) - LSH*Z(28) - LTH*Z(47)
      POP12X = Q1 + LHAT*Z(1) - LFF*Z(31) - LRF*Z(42) - LSH*Z(27) - LTH*
     &Z(46)
      POP12Y = Q2 + LHAT*Z(2) - LFF*Z(32) - LRF*Z(43) - LSH*Z(28) - LTH*
     &Z(47)
      POHATOX = Q1 + HATO*Z(1) - LFF*Z(31) - LRF*Z(42) - LSH*Z(27) - LTH
     &*Z(46)
      POHATOY = Q2 + HATO*Z(2) - LFF*Z(32) - LRF*Z(43) - LSH*Z(28) - LTH
     &*Z(47)
      POCMX = Q1 + Z(74)*Z(64) + Z(75)*Z(56) + Z(77)*Z(52) + Z(78)*Z(49)
     & + Z(73)*Z(1) - Z(79)*Z(31) - Z(81)*Z(27) - Z(82)*Z(46) - 0.5D0*Z(
     &76)*Z(38) - 0.5D0*Z(76)*Z(60) - 0.5D0*Z(80)*Z(42)
      Z(281) = MHAT*HATOp/Z(72)
      Z(282) = Z(74)*(LAp+LHp+LKp+LMTPp)
      Z(283) = Z(75)*(LAp+LHp+LKp)
      Z(284) = Z(76)*(LAp+LHp+LKp)
      Z(285) = Z(77)*(LHp+LKp)
      Z(286) = Z(78)*LHp
      Z(287) = Z(79)*(RAp+RHp+RKp+RMTPp)
      Z(288) = Z(80)*(RAp+RHp+RKp)
      Z(289) = Z(76)*(RAp+RHp+RKp)
      Z(290) = Z(81)*(RHp+RKp)
      Z(291) = Z(82)*RHp
      VOCMX = Z(281)*Z(1) + U1 + Z(51)*(Z(286)+Z(78)*U3+Z(78)*U5) + Z(54
     &)*(Z(285)+Z(77)*U3+Z(77)*U5+Z(77)*U7) + Z(58)*(Z(283)+Z(75)*U3+Z(7
     &5)*U5+Z(75)*U7+Z(75)*U9) + Z(66)*(Z(282)+Z(74)*U3+Z(74)*U5+Z(74)*U
     &7+Z(74)*U9) - Z(73)*Z(2)*U3 - Z(48)*(Z(291)+Z(82)*U3+Z(82)*U4) - Z
     &(29)*(Z(290)+Z(81)*U3+Z(81)*U4+Z(81)*U6) - Z(33)*(Z(287)+Z(79)*U3+
     &Z(79)*U4+Z(79)*U6+Z(79)*U8) - 0.5D0*Z(40)*(Z(289)+Z(76)*U3+Z(76)*U
     &4+Z(76)*U6+Z(76)*U8) - 0.5D0*Z(44)*(Z(288)+Z(80)*U3+Z(80)*U4+Z(80)
     &*U6+Z(80)*U8) - 0.5D0*Z(62)*(Z(284)+Z(76)*U3+Z(76)*U5+Z(76)*U7+Z(7
     &6)*U9)
      VOCMY = Z(281)*Z(2) + U2 + Z(73)*Z(1)*U3 + Z(49)*(Z(286)+Z(78)*U3+
     &Z(78)*U5) + Z(55)*(Z(285)+Z(77)*U3+Z(77)*U5+Z(77)*U7) + Z(59)*(Z(2
     &83)+Z(75)*U3+Z(75)*U5+Z(75)*U7+Z(75)*U9) + Z(67)*(Z(282)+Z(74)*U3+
     &Z(74)*U5+Z(74)*U7+Z(74)*U9) - Z(46)*(Z(291)+Z(82)*U3+Z(82)*U4) - Z
     &(30)*(Z(290)+Z(81)*U3+Z(81)*U4+Z(81)*U6) - Z(34)*(Z(287)+Z(79)*U3+
     &Z(79)*U4+Z(79)*U6+Z(79)*U8) - 0.5D0*Z(41)*(Z(289)+Z(76)*U3+Z(76)*U
     &4+Z(76)*U6+Z(76)*U8) - 0.5D0*Z(45)*(Z(288)+Z(80)*U3+Z(80)*U4+Z(80)
     &*U6+Z(80)*U8) - 0.5D0*Z(63)*(Z(284)+Z(76)*U3+Z(76)*U5+Z(76)*U7+Z(7
     &6)*U9)
      RMTQ = MTPK*(3.141592653589793D0-RMTP) - MTPB*RMTPp
      LMTQ = MTPK*(3.141592653589793D0-LMTP) - MTPB*LMTPp
      RRX = RRX1 + RRX2
      RRY = RRY1 + RRY2
      LRX = LRX1 + LRX2
      LRY = LRY1 + LRY2

C**   Write output to screen and to output file(s)
      WRITE(*, 6020) T,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,P
     &OP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,POP10X,
     &POP10Y,POP11X,POP11Y,POP12X,POP12Y,POHATOX,POHATOY,POCMX,POCMY,VOC
     &MX,VOCMY
      WRITE(21,6020) T,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,P
     &OP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,POP10X,
     &POP10Y,POP11X,POP11Y,POP12X,POP12Y,POHATOX,POHATOY,POCMX,POCMY,VOC
     &MX,VOCMY
      WRITE(22,6020) T,Q1,Q2,(Q3*RADtoDEG),U1,U2,U3
      WRITE(23,6020) T,RRX,RRY,LRX,LRY,RRX1,RRY1,RRX2,RRY2,LRX1,LRX2,LRY
     &1,LRY2
      WRITE(24,6020) T,RHTQ,LHTQ,RKTQ,LKTQ,RATQ,LATQ,RMTQ,LMTQ
      WRITE(25,6020) T,RH,LH,RK,LK,RA,LA,RMTP,LMTP,RHp,LHp,RKp,LKp,RAp,L
     &Ap,RMTPp,LMTPp,RHpp,LHpp,RKpp,LKpp,RApp,LApp,RMTPpp,LMTPpp
      WRITE(26,6020) T,KECM,PECM,TE,HZ,PX,PY

6020  FORMAT( 99(1X, 1PE14.6E3) )

      RETURN
      END


