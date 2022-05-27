C**   The name of this program is model/angle_driven/model_ang
     &le.f
C**   Created by AUTOLEV 3.2 on Fri May 27 14:47:50 2022

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
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(827),COEF(3,3),RHS(3)

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
      Z(380) = G*MSH
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
      Z(74) = (LFF*MFF+LFF*MHAT+LFFO*MFF+2*LFF*MRF+2*LFF*MSH+2*LFF*MTH)/
     &Z(72)
      Z(75) = (LRFO*MRF+2*LRF*MFF+2*LRF*MHAT+2*LRF*MRF+4*LRF*MSH+4*LRF*M
     &TH)/Z(72)
      Z(76) = LRFFO*MRF/Z(72)
      Z(77) = (LSH*MFF+LSH*MHAT+LSH*MRF+LSH*MSH+LSHO*MSH+2*LSH*MTH)/Z(72
     &)
      Z(78) = (LTH*MFF+LTH*MHAT+LTH*MRF+LTH*MSH+LTH*MTH+LTHO*MTH)/Z(72)
      Z(79) = MFF*Z(68)/Z(72)
      Z(80) = (LRF*MFF+MRF*Z(69))/Z(72)
      Z(81) = (LSH*MFF+LSH*MRF+MSH*Z(70))/Z(72)
      Z(82) = (LTH*MFF+LTH*MRF+LTH*MSH+MTH*Z(71))/Z(72)
      Z(377) = G*MHAT
      Z(381) = G*MTH
      Z(411) = Z(74) - LFF
      Z(412) = 0.5D0*Z(75) - LRF
      Z(413) = Z(77) - LSH
      Z(414) = Z(78) - LTH
      Z(499) = 0.5D0*Z(75) - 0.5D0*LRFO
      Z(500) = 0.5D0*Z(76) - 0.5D0*LRFFO
      Z(524) = 2*LRF - Z(75)
      Z(525) = LFF - Z(74)
      Z(530) = LSH - Z(77)
      Z(545) = LSH - Z(81)
      Z(546) = LTH - Z(82)
      Z(547) = LRF - Z(80)
      Z(548) = LTH - Z(78)
      Z(553) = LRF - 0.5D0*LRFO - Z(80)
      Z(576) = Z(19)*Z(76)
      Z(586) = 2*Z(499) + 2*Z(19)*Z(500)
      Z(588) = 2*Z(500) + 2*Z(19)*Z(499)
      Z(596) = 2*Z(553) + 2*Z(19)*Z(500)
      Z(598) = 2*Z(500) + 2*Z(19)*Z(553)
      Z(608) = LFF*MHAT
      Z(610) = LRF*MHAT
      Z(612) = LSH*MHAT
      Z(614) = LTH*MHAT
      Z(620) = LFFO*MFF
      Z(626) = LFF*MRF
      Z(628) = LRFO*MRF
      Z(630) = LRFFO*MRF
      Z(672) = MRF*Z(69)
      Z(683) = LSH*MRF
      Z(700) = MSH*Z(70)
      Z(715) = MTH*Z(71)
      Z(727) = Z(71)*Z(381)
      Z(730) = Z(70)*Z(380)
      Z(754) = IHAT + 2*IFF + 2*IRF + 2*ISH + 2*ITH + MFF*LFFO**2
      Z(755) = LRFFO**2 + LRFO**2 + 4*LFF**2 + 2*LRFFO*LRFO*Z(19)
      Z(756) = LFF*LRFFO
      Z(757) = LFF*LRFO
      Z(758) = LRFFO**2 + 4*Z(69)**2
      Z(759) = LRFFO*Z(19)*Z(69)
      Z(760) = LFF**2 + LRF**2 + LSH**2 + LTH**2
      Z(761) = LFF*LSH
      Z(762) = LFF*LTH
      Z(763) = LRF*LTH
      Z(764) = LFF*LRF
      Z(765) = LRF*LSH
      Z(766) = LSH*LTH
      Z(768) = LRFFO*Z(19)
      Z(769) = LRFO*Z(19)
      Z(770) = LRFFO*Z(20)
      Z(771) = LRFO*Z(20)
      Z(772) = Z(19)*Z(69)
      Z(773) = Z(20)*Z(69)
      Z(775) = IFF + IRF + ISH + ITH
      Z(776) = LRFFO**2
      Z(777) = Z(69)**2
      Z(782) = IFF + IRF + ISH + ITH + MFF*LFFO**2
      Z(787) = IFF + IRF + ISH
      Z(788) = LSH*Z(69)
      Z(789) = LRFFO*LSH
      Z(794) = IFF + IRF + ISH + MFF*LFFO**2
      Z(795) = LFF**2 + LRF**2 + LSH**2
      Z(800) = IFF + IRF
      Z(801) = LRFFO**2 + 4*Z(69)**2 - 4*LRFFO*Z(19)*Z(69)
      Z(806) = IFF + IRF + MFF*LFFO**2
      Z(807) = LFF**2 + LRF**2

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
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(827),COEF(3,3),RHS(3)

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
      LRY1 = -K3*Q2 - K4*ABS(Q2)*U2
      DLX1 = Q1 - LTOEXI
      LRX1 = -LRY1*(K1*DLX1+K2*U1)
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

      Z(16) = SIN(RMTP)
      Z(11) = COS(RA)
      Z(8) = SIN(RK)
      Z(3) = COS(RH)
      Z(4) = SIN(RH)
      Z(50) = Z(3)*Z(2) - Z(4)*Z(1)
      Z(7) = COS(RK)
      Z(49) = Z(3)*Z(1) + Z(4)*Z(2)
      Z(55) = Z(8)*Z(50) - Z(7)*Z(49)
      Z(12) = SIN(RA)
      Z(53) = -Z(7)*Z(50) - Z(8)*Z(49)
      Z(59) = -Z(11)*Z(55) - Z(12)*Z(53)
      Z(15) = COS(RMTP)
      Z(57) = Z(12)*Z(55) - Z(11)*Z(53)
      Z(65) = Z(16)*Z(59) - Z(15)*Z(57)
      Z(13) = COS(LA)
      Z(17) = COS(LMTP)
      Z(14) = SIN(LA)
      Z(18) = SIN(LMTP)
      Z(21) = Z(13)*Z(17) - Z(14)*Z(18)
      Z(5) = COS(LH)
      Z(9) = COS(LK)
      Z(6) = SIN(LH)
      Z(10) = SIN(LK)
      Z(24) = -Z(5)*Z(9) - Z(6)*Z(10)
      Z(25) = Z(6)*Z(9) - Z(5)*Z(10)
      Z(28) = Z(24)*Z(2) + Z(25)*Z(1)
      Z(22) = -Z(13)*Z(18) - Z(14)*Z(17)
      Z(26) = Z(5)*Z(10) - Z(6)*Z(9)
      Z(30) = Z(24)*Z(1) + Z(26)*Z(2)
      Z(32) = Z(21)*Z(28) + Z(22)*Z(30)
      Z(43) = Z(14)*Z(30) - Z(13)*Z(28)
      Z(47) = Z(5)*Z(2) - Z(6)*Z(1)
      POP11Y = Q2 + LFF*Z(65) + LRF*Z(57) + LSH*Z(53) + LTH*Z(50) - LFF*
     &Z(32) - LRF*Z(43) - LSH*Z(28) - LTH*Z(47)
      Z(169) = Z(3)*Z(5) + Z(4)*Z(6)
      Z(117) = LKp - LAp - LHp - LMTPp
      Z(119) = LFF*Z(117)
      Z(130) = Z(18)*Z(119)
      Z(134) = Z(17)*Z(119)
      Z(120) = LKp - LAp - LHp
      Z(135) = LRF*Z(120)
      Z(137) = Z(134) - Z(135)
      Z(145) = Z(14)*Z(130) - Z(13)*Z(137)
      Z(146) = LKp - LHp
      Z(150) = LSH*Z(146)
      Z(152) = Z(145) - Z(150)
      Z(141) = -Z(13)*Z(130) - Z(14)*Z(137)
      Z(157) = Z(10)*Z(152) - Z(9)*Z(141)
      Z(171) = Z(3)*Z(6) - Z(4)*Z(5)
      Z(162) = -Z(9)*Z(152) - Z(10)*Z(141)
      Z(166) = LTH*LHp
      Z(168) = Z(162) + Z(166)
      Z(177) = Z(169)*Z(157) + Z(171)*Z(168)
      Z(170) = Z(4)*Z(5) - Z(3)*Z(6)
      Z(183) = Z(169)*Z(168) + Z(170)*Z(157)
      Z(187) = LTH*RHp
      Z(189) = Z(183) - Z(187)
      Z(205) = Z(8)*Z(177) - Z(7)*Z(189)
      Z(206) = RKp - RHp
      Z(211) = LSH*Z(206)
      Z(214) = Z(205) + Z(211)
      Z(197) = -Z(7)*Z(177) - Z(8)*Z(189)
      Z(239) = -Z(11)*Z(214) - Z(12)*Z(197)
      Z(215) = RKp - RAp - RHp
      Z(240) = LRF*Z(215)
      Z(244) = Z(239) + Z(240)
      Z(230) = Z(12)*Z(214) - Z(11)*Z(197)
      Z(254) = Z(16)*Z(244) - Z(15)*Z(230)
      Z(245) = LRF*Z(16)
      Z(127) = LFF*Z(18)
      Z(133) = LFF*Z(17)
      Z(136) = Z(133) - LRF
      Z(142) = Z(14)*Z(127) - Z(13)*Z(136)
      Z(138) = -Z(13)*Z(127) - Z(14)*Z(136)
      Z(153) = Z(10)*Z(142) - Z(9)*Z(138)
      Z(158) = -Z(9)*Z(142) - Z(10)*Z(138)
      Z(172) = Z(153)*Z(169) + Z(158)*Z(171)
      Z(178) = Z(153)*Z(170) + Z(158)*Z(169)
      Z(198) = Z(8)*Z(172) - Z(7)*Z(178)
      Z(190) = -Z(7)*Z(172) - Z(8)*Z(178)
      Z(232) = -Z(11)*Z(198) - Z(12)*Z(190)
      Z(223) = Z(12)*Z(198) - Z(11)*Z(190)
      Z(246) = Z(16)*Z(232) - Z(15)*Z(223)
      Z(151) = Z(142) - LSH
      Z(154) = Z(10)*Z(151) - Z(9)*Z(138)
      Z(159) = -Z(9)*Z(151) - Z(10)*Z(138)
      Z(167) = Z(159) - LTH
      Z(173) = Z(154)*Z(169) + Z(167)*Z(171)
      Z(180) = Z(154)*Z(170) + Z(167)*Z(169)
      Z(200) = Z(8)*Z(173) - Z(7)*Z(180)
      Z(192) = -Z(7)*Z(173) - Z(8)*Z(180)
      Z(234) = -Z(11)*Z(200) - Z(12)*Z(192)
      Z(224) = Z(12)*Z(200) - Z(11)*Z(192)
      Z(247) = Z(16)*Z(234) - Z(15)*Z(224)
      Z(174) = Z(154)*Z(169) + Z(159)*Z(171)
      Z(179) = Z(154)*Z(170) + Z(159)*Z(169)
      Z(201) = Z(8)*Z(174) - Z(7)*Z(179)
      Z(193) = -Z(7)*Z(174) - Z(8)*Z(179)
      Z(235) = -Z(11)*Z(201) - Z(12)*Z(193)
      Z(225) = Z(12)*Z(201) - Z(11)*Z(193)
      Z(248) = Z(16)*Z(235) - Z(15)*Z(225)
      Z(188) = LTH + Z(180)
      Z(199) = Z(8)*Z(173) - Z(7)*Z(188)
      Z(212) = LSH + Z(199)
      Z(191) = -Z(7)*Z(173) - Z(8)*Z(188)
      Z(233) = -Z(11)*Z(212) - Z(12)*Z(191)
      Z(241) = LRF + Z(233)
      Z(226) = Z(12)*Z(212) - Z(11)*Z(191)
      Z(249) = Z(16)*Z(241) - Z(15)*Z(226)
      Z(196) = LTH*Z(8)
      Z(204) = LTH*Z(7)
      Z(213) = LSH - Z(204)
      Z(231) = Z(12)*Z(196) - Z(11)*Z(213)
      Z(242) = LRF + Z(231)
      Z(227) = Z(11)*Z(196) + Z(12)*Z(213)
      Z(250) = Z(16)*Z(242) - Z(15)*Z(227)
      Z(238) = LSH*Z(11)
      Z(243) = LRF - Z(238)
      Z(222) = LSH*Z(12)
      Z(251) = Z(16)*Z(243) - Z(15)*Z(222)
      Z(27) = Z(24)*Z(1) - Z(25)*Z(2)
      Z(29) = Z(26)*Z(1) - Z(24)*Z(2)
      Z(31) = Z(21)*Z(27) + Z(22)*Z(29)
      Z(23) = Z(13)*Z(18) + Z(14)*Z(17)
      Z(33) = Z(21)*Z(29) + Z(23)*Z(27)
      Z(128) = -Z(17)*Z(31) - Z(18)*Z(33)
      Z(131) = Z(18)*Z(31) - Z(17)*Z(33)
      Z(143) = Z(14)*Z(128) - Z(13)*Z(131)
      Z(139) = -Z(13)*Z(128) - Z(14)*Z(131)
      Z(155) = Z(10)*Z(143) - Z(9)*Z(139)
      Z(160) = -Z(9)*Z(143) - Z(10)*Z(139)
      Z(175) = Z(169)*Z(155) + Z(171)*Z(160)
      Z(181) = Z(169)*Z(160) + Z(170)*Z(155)
      Z(202) = Z(8)*Z(175) - Z(7)*Z(181)
      Z(194) = -Z(7)*Z(175) - Z(8)*Z(181)
      Z(236) = -Z(11)*Z(202) - Z(12)*Z(194)
      Z(228) = Z(12)*Z(202) - Z(11)*Z(194)
      Z(252) = Z(16)*Z(236) - Z(15)*Z(228)
      Z(34) = Z(21)*Z(30) + Z(23)*Z(28)
      Z(129) = -Z(17)*Z(32) - Z(18)*Z(34)
      Z(132) = Z(18)*Z(32) - Z(17)*Z(34)
      Z(144) = Z(14)*Z(129) - Z(13)*Z(132)
      Z(140) = -Z(13)*Z(129) - Z(14)*Z(132)
      Z(156) = Z(10)*Z(144) - Z(9)*Z(140)
      Z(161) = -Z(9)*Z(144) - Z(10)*Z(140)
      Z(176) = Z(169)*Z(156) + Z(171)*Z(161)
      Z(182) = Z(169)*Z(161) + Z(170)*Z(156)
      Z(203) = Z(8)*Z(176) - Z(7)*Z(182)
      Z(195) = -Z(7)*Z(176) - Z(8)*Z(182)
      Z(237) = -Z(11)*Z(203) - Z(12)*Z(195)
      Z(229) = Z(12)*Z(203) - Z(11)*Z(195)
      Z(253) = Z(16)*Z(237) - Z(15)*Z(229)
      Z(67) = -Z(15)*Z(59) - Z(16)*Z(57)
      Z(264) = -Z(15)*Z(244) - Z(16)*Z(230)
      Z(265) = RKp - RAp - RHp - RMTPp
      Z(272) = LFF*Z(265)
      Z(277) = Z(264) + Z(272)
      Z(256) = -Z(15)*Z(232) - Z(16)*Z(223)
      Z(257) = -Z(15)*Z(234) - Z(16)*Z(224)
      Z(258) = -Z(15)*Z(235) - Z(16)*Z(225)
      Z(259) = -Z(15)*Z(241) - Z(16)*Z(226)
      Z(273) = LFF + Z(259)
      Z(260) = -Z(15)*Z(242) - Z(16)*Z(227)
      Z(274) = LFF + Z(260)
      Z(255) = -Z(15)*Z(243) - Z(16)*Z(222)
      Z(275) = LFF + Z(255)
      Z(263) = LRF*Z(15)
      Z(276) = LFF - Z(263)
      Z(261) = -Z(15)*Z(236) - Z(16)*Z(228)
      Z(262) = -Z(15)*Z(237) - Z(16)*Z(229)
      VOP11Y = Z(65)*(Z(254)+Z(245)*U8+Z(246)*U9+Z(247)*U5+Z(248)*U7+Z(2
     &49)*U3+Z(250)*U4+Z(251)*U6+Z(252)*U1+Z(253)*U2) + Z(67)*(Z(277)+Z(
     &256)*U9+Z(257)*U5+Z(258)*U7+Z(273)*U3+Z(274)*U4+Z(275)*U6+Z(276)*U
     &8+Z(261)*U1+Z(262)*U2)
      RRY1 = -K3*POP11Y - K4*ABS(POP11Y)*VOP11Y
      Z(51) = Z(4)*Z(1) - Z(3)*Z(2)
      Z(54) = Z(8)*Z(49) - Z(7)*Z(51)
      Z(52) = -Z(7)*Z(49) - Z(8)*Z(51)
      Z(58) = -Z(11)*Z(54) - Z(12)*Z(52)
      Z(56) = Z(12)*Z(54) - Z(11)*Z(52)
      Z(64) = Z(16)*Z(58) - Z(15)*Z(56)
      Z(42) = Z(14)*Z(29) - Z(13)*Z(27)
      Z(46) = Z(5)*Z(1) + Z(6)*Z(2)
      POP11X = Q1 + LFF*Z(64) + LRF*Z(56) + LSH*Z(52) + LTH*Z(49) - LFF*
     &Z(31) - LRF*Z(42) - LSH*Z(27) - LTH*Z(46)
      DRX1 = POP11X - RTOEXI
      Z(66) = -Z(15)*Z(58) - Z(16)*Z(56)
      VOP11X = Z(64)*(Z(254)+Z(245)*U8+Z(246)*U9+Z(247)*U5+Z(248)*U7+Z(2
     &49)*U3+Z(250)*U4+Z(251)*U6+Z(252)*U1+Z(253)*U2) + Z(66)*(Z(277)+Z(
     &256)*U9+Z(257)*U5+Z(258)*U7+Z(273)*U3+Z(274)*U4+Z(275)*U6+Z(276)*U
     &8+Z(261)*U1+Z(262)*U2)
      RRX1 = -RRY1*(K1*DRX1+K2*VOP11X)
      POP10Y = Q2 + LRF*Z(57) + LSH*Z(53) + LTH*Z(50) - LFF*Z(32) - LRF*
     &Z(43) - LSH*Z(28) - LTH*Z(47)
      VOP10Y = Z(57)*(Z(230)+Z(222)*U6+Z(223)*U9+Z(224)*U5+Z(225)*U7+Z(2
     &26)*U3+Z(227)*U4+Z(228)*U1+Z(229)*U2) + Z(59)*(Z(244)+LRF*U8+Z(232
     &)*U9+Z(234)*U5+Z(235)*U7+Z(241)*U3+Z(242)*U4+Z(243)*U6+Z(236)*U1+Z
     &(237)*U2)
      RRY2 = -K7*POP10Y - K8*ABS(POP10Y)*VOP10Y
      POP10X = Q1 + LRF*Z(56) + LSH*Z(52) + LTH*Z(49) - LFF*Z(31) - LRF*
     &Z(42) - LSH*Z(27) - LTH*Z(46)
      DRX2 = POP10X - RMTPXI
      VOP10X = Z(56)*(Z(230)+Z(222)*U6+Z(223)*U9+Z(224)*U5+Z(225)*U7+Z(2
     &26)*U3+Z(227)*U4+Z(228)*U1+Z(229)*U2) + Z(58)*(Z(244)+LRF*U8+Z(232
     &)*U9+Z(234)*U5+Z(235)*U7+Z(241)*U3+Z(242)*U4+Z(243)*U6+Z(236)*U1+Z
     &(237)*U2)
      RRX2 = -RRY2*(K5*DRX2+K6*VOP10X)
      POP2Y = Q2 - LFF*Z(32)
      VOP2Y = Z(32)*(Z(31)*U1+Z(32)*U2) - Z(34)*(Z(119)+LFF*U3+LFF*U5+LF
     &F*U7+LFF*U9-Z(33)*U1-Z(34)*U2)
      LRY2 = -K7*POP2Y - K8*ABS(POP2Y)*VOP2Y
      POP2X = Q1 - LFF*Z(31)
      DLX2 = POP2X - LMTPXI
      VOP2X = Z(31)*(Z(31)*U1+Z(32)*U2) - Z(33)*(Z(119)+LFF*U3+LFF*U5+LF
     &F*U7+LFF*U9-Z(33)*U1-Z(34)*U2)
      LRX2 = -LRY2*(K5*DLX2+K6*VOP2X)
      Z(35) = -Z(19)*Z(13) - Z(20)*Z(14)
      Z(37) = Z(20)*Z(13) - Z(19)*Z(14)
      Z(41) = Z(35)*Z(30) + Z(37)*Z(28)
      Z(44) = -Z(13)*Z(29) - Z(14)*Z(27)
      Z(45) = -Z(13)*Z(30) - Z(14)*Z(28)
      Z(48) = Z(6)*Z(1) - Z(5)*Z(2)
      Z(63) = Z(19)*Z(59) - Z(20)*Z(57)
      Z(83) = U4 - RHp
      Z(84) = U5 - LHp
      Z(86) = RKpp - RHpp
      Z(92) = LKpp - LHpp
      Z(94) = RKpp - RApp - RHpp
      Z(100) = LKpp - LApp - LHpp
      Z(102) = Z(1)*Z(44) + Z(2)*Z(45)
      Z(103) = Z(1)*Z(43) - Z(2)*Z(42)
      Z(104) = Z(1)*Z(45) - Z(2)*Z(44)
      Z(106) = RKpp - RApp - RHpp - RMTPpp
      Z(112) = LKpp - LApp - LHpp - LMTPpp
      Z(114) = Z(1)*Z(33) + Z(2)*Z(34)
      Z(115) = Z(1)*Z(32) - Z(2)*Z(31)
      Z(116) = Z(1)*Z(34) - Z(2)*Z(33)
      Z(118) = LFFO*Z(117)
      Z(125) = LRFO*Z(120)
      Z(126) = LRFFO*Z(120)
      Z(147) = LSHO*Z(146)
      Z(148) = Z(142) - LSHO
      Z(163) = LTHO*LHp
      Z(164) = Z(159) - LTHO
      Z(184) = Z(71)*RHp
      Z(185) = Z(71) + Z(180)
      Z(207) = Z(70)*Z(206)
      Z(208) = Z(70) + Z(199)
      Z(220) = Z(69)*Z(215)
      Z(221) = LRFFO*Z(215)
      Z(266) = Z(68)*Z(265)
      Z(267) = Z(68) + Z(259)
      Z(278) = LFF*(LKp-LAp-LHp-LMTPp)
      Z(279) = LRF*(LAp+LHp-LKp)
      Z(280) = LSH*(LHp-LKp)
      Z(292) = LFFO*Z(112)
      Z(293) = Z(117) + U5 + U7 + U9
      Z(294) = (Z(118)+LFFO*U3+LFFO*U5+LFFO*U7+LFFO*U9)*(U3+Z(293))
      Z(295) = LFF*Z(112)
      Z(296) = (Z(119)+LFF*U3+LFF*U5+LFF*U7+LFF*U9)*(U3+Z(293))
      Z(297) = LRFO*Z(100)
      Z(298) = LRFFO*Z(100)
      Z(299) = Z(120) + U5 + U7 + U9
      Z(300) = (Z(125)+LRFO*U3+LRFO*U5+LRFO*U7+LRFO*U9)*(U3+Z(299))
      Z(301) = (Z(126)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)*(U3+Z(299))
      Z(302) = Z(18)*Z(295) - Z(17)*Z(296)
      Z(303) = Z(17)*Z(295) + Z(18)*Z(296)
      Z(304) = LRF*Z(100)
      Z(305) = Z(302) + (Z(135)+LRF*U3+LRF*U5+LRF*U7+LRF*U9)*(U3+Z(299))
      Z(306) = Z(303) - Z(304)
      Z(307) = -Z(13)*Z(305) - Z(14)*Z(306)
      Z(308) = Z(14)*Z(305) - Z(13)*Z(306)
      Z(309) = LSHO*Z(92)
      Z(310) = Z(146) + U5 + U7
      Z(311) = Z(307) + (Z(147)+LSHO*U3+LSHO*U5+LSHO*U7)*(U3+Z(310))
      Z(312) = Z(308) - Z(309)
      Z(313) = LSH*Z(92)
      Z(314) = Z(307) + (Z(150)+LSH*U3+LSH*U5+LSH*U7)*(U3+Z(310))
      Z(315) = Z(308) - Z(313)
      Z(316) = Z(10)*Z(315) - Z(9)*Z(314)
      Z(317) = -Z(9)*Z(315) - Z(10)*Z(314)
      Z(318) = LTHO*LHpp
      Z(319) = Z(316) - (Z(163)-LTHO*U3-LTHO*U5)*(U3+Z(84))
      Z(320) = Z(318) + Z(317)
      Z(321) = LTH*LHpp
      Z(322) = Z(316) - (Z(166)-LTH*U3-LTH*U5)*(U3+Z(84))
      Z(323) = Z(321) + Z(317)
      Z(324) = Z(169)*Z(322) + Z(171)*Z(323)
      Z(325) = Z(169)*Z(323) + Z(170)*Z(322)
      Z(326) = Z(71)*RHpp
      Z(327) = Z(324) + (Z(184)-Z(71)*U3-Z(71)*U4)*(U3+Z(83))
      Z(328) = Z(325) - Z(326)
      Z(329) = LTH*RHpp
      Z(330) = Z(324) + (Z(187)-LTH*U3-LTH*U4)*(U3+Z(83))
      Z(331) = Z(325) - Z(329)
      Z(332) = -Z(7)*Z(330) - Z(8)*Z(331)
      Z(333) = Z(8)*Z(330) - Z(7)*Z(331)
      Z(334) = Z(70)*Z(86)
      Z(335) = Z(206) + U4 + U6
      Z(336) = Z(332) - (Z(207)+Z(70)*U3+Z(70)*U4+Z(70)*U6)*(U3+Z(335))
      Z(337) = Z(334) + Z(333)
      Z(338) = LSH*Z(86)
      Z(339) = Z(332) - (Z(211)+LSH*U3+LSH*U4+LSH*U6)*(U3+Z(335))
      Z(340) = Z(338) + Z(333)
      Z(341) = Z(69)*Z(94)
      Z(342) = LRFFO*Z(94)
      Z(343) = Z(215) + U4 + U6 + U8
      Z(344) = (Z(220)+Z(69)*U3+Z(69)*U4+Z(69)*U6+Z(69)*U8)*(U3+Z(343))
      Z(345) = (Z(221)+LRFFO*U3+LRFFO*U4+LRFFO*U6+LRFFO*U8)*(U3+Z(343))
      Z(346) = Z(12)*Z(340) - Z(11)*Z(339)
      Z(347) = -Z(11)*Z(340) - Z(12)*Z(339)
      Z(348) = LRF*Z(94)
      Z(349) = Z(346) - (Z(240)+LRF*U3+LRF*U4+LRF*U6+LRF*U8)*(U3+Z(343))
      Z(350) = Z(348) + Z(347)
      Z(351) = Z(16)*Z(350) - Z(15)*Z(349)
      Z(352) = -Z(15)*Z(350) - Z(16)*Z(349)
      Z(353) = Z(68)*Z(106)
      Z(354) = Z(265) + U4 + U6 + U8
      Z(355) = Z(351) - (Z(266)+Z(68)*U3+Z(68)*U4+Z(68)*U6+Z(68)*U8)*(U3
     &+Z(354))
      Z(356) = Z(353) + Z(352)
      Z(360) = HATO*U3
      Z(361) = -Z(278) - LFF*U3 - LFF*U5 - LFF*U7 - LFF*U9
      Z(362) = Z(279) - LRF*U3 - LRF*U5 - LRF*U7 - LRF*U9
      Z(363) = Z(280) - LSH*U3 - LSH*U5 - LSH*U7
      Z(364) = Z(166) - LTH*U3 - LTH*U5
      Z(365) = HATOp*U3
      Z(366) = LFF*(LKpp-LApp-LHpp-LMTPpp)
      Z(367) = U9 - LAp
      Z(368) = LKp + U7
      Z(369) = LRF*(LApp+LHpp-LKpp)
      Z(370) = LSH*(LHpp-LKpp)
      Z(371) = HATOpp - U3*Z(360)
      Z(372) = HATOp*U3 + Z(365)
      Z(373) = Z(361)*(LMTPp-U3-Z(84)-Z(367)-Z(368))
      Z(374) = Z(362)*(U3+Z(84)+Z(367)+Z(368))
      Z(375) = Z(363)*(U3+Z(84)+Z(368))
      Z(376) = Z(364)*(U3+Z(84))
      Z(390) = -Z(9)*Z(22) - Z(10)*Z(21)
      Z(391) = Z(10)*Z(21) - Z(9)*Z(23)
      Z(392) = -Z(9)*Z(21) - Z(10)*Z(23)
      Z(393) = Z(9)*Z(13) + Z(10)*Z(14)
      Z(394) = Z(10)*Z(13) - Z(9)*Z(14)
      Z(395) = Z(9)*Z(14) - Z(10)*Z(13)
      Z(396) = Z(20)*Z(18) - Z(19)*Z(17)
      Z(397) = Z(19)*Z(18) + Z(20)*Z(17)
      Z(398) = -Z(19)*Z(18) - Z(20)*Z(17)
      Z(399) = -Z(19)*Z(11) - Z(20)*Z(12)
      Z(400) = Z(19)*Z(12) - Z(20)*Z(11)
      Z(401) = Z(20)*Z(11) - Z(19)*Z(12)
      Z(723) = LRX1 + LRX2*Z(31)**2 + LRX2*Z(33)**2 + LRY2*Z(31)*Z(32) +
     & LRY2*Z(33)*Z(34) + RRX1*Z(64)*Z(252) + RRX1*Z(66)*Z(261) + RRX2*Z
     &(56)*Z(228) + RRX2*Z(58)*Z(236) + RRY1*Z(65)*Z(252) + RRY1*Z(67)*Z
     &(261) + RRY2*Z(57)*Z(228) + RRY2*Z(59)*Z(236) + Z(378)*(Z(31)*Z(32
     &)+Z(33)*Z(34)) + Z(378)*(Z(65)*Z(252)+Z(67)*Z(261)) + Z(379)*(Z(31
     &)*Z(32)+Z(33)*Z(34)) + Z(379)*(Z(53)*Z(194)+Z(55)*Z(202)) + Z(380)
     &*(Z(28)*Z(139)+Z(30)*Z(143)) + Z(380)*(Z(53)*Z(194)+Z(55)*Z(202)) 
     &+ Z(381)*(Z(46)*Z(160)+Z(47)*Z(155)) + Z(381)*(Z(49)*Z(181)+Z(50)*
     &Z(175))
      Z(724) = Z(377) + LRY1 + LRX2*Z(31)*Z(32) + LRX2*Z(33)*Z(34) + LRY
     &2*Z(32)**2 + LRY2*Z(34)**2 + RRX1*Z(64)*Z(253) + RRX1*Z(66)*Z(262)
     & + RRX2*Z(56)*Z(229) + RRX2*Z(58)*Z(237) + RRY1*Z(65)*Z(253) + RRY
     &1*Z(67)*Z(262) + RRY2*Z(57)*Z(229) + RRY2*Z(59)*Z(237) + Z(378)*(Z
     &(32)**2+Z(34)**2) + Z(378)*(Z(65)*Z(253)+Z(67)*Z(262)) + Z(379)*(Z
     &(32)**2+Z(34)**2) + Z(379)*(Z(53)*Z(195)+Z(55)*Z(203)) + Z(380)*(Z
     &(28)*Z(140)+Z(30)*Z(144)) + Z(380)*(Z(53)*Z(195)+Z(55)*Z(203)) + Z
     &(381)*(Z(46)*Z(161)+Z(47)*Z(156)) + Z(381)*(Z(49)*Z(182)+Z(50)*Z(1
     &76))
      Z(736) = IFF*Z(112)
      Z(738) = IRF*Z(100)
      Z(740) = ISH*Z(92)
      Z(742) = ITH*LHpp
      Z(743) = IFF*Z(106)
      Z(744) = IRF*Z(94)
      Z(745) = ISH*Z(86)
      Z(746) = ITH*RHpp
      Z(747) = MHAT + MFF*(Z(31)**2+Z(33)**2) + MFF*(Z(252)**2+Z(261)**2
     &) + MRF*(Z(31)**2+Z(33)**2) + MRF*(Z(194)**2+Z(202)**2) + MSH*(Z(1
     &39)**2+Z(143)**2) + MSH*(Z(194)**2+Z(202)**2) + MTH*(Z(155)**2+Z(1
     &60)**2) + MTH*(Z(175)**2+Z(181)**2)
      Z(748) = MFF*(Z(249)*Z(252)+Z(267)*Z(261)) + MSH*(Z(138)*Z(139)+Z(
     &148)*Z(143)) + MSH*(Z(191)*Z(194)+Z(208)*Z(202)) + MTH*(Z(154)*Z(1
     &55)+Z(164)*Z(160)) + MTH*(Z(173)*Z(175)+Z(185)*Z(181)) + 0.5D0*MRF
     &*(LRFO*Z(17)*Z(33)-2*LFF*Z(33)-LRFFO*Z(396)*Z(33)-LRFFO*Z(397)*Z(3
     &1)-LRFO*Z(18)*Z(31)) + 0.5D0*MRF*(2*Z(191)*Z(194)+2*Z(212)*Z(202)-
     &2*Z(69)*Z(11)*Z(202)-2*Z(69)*Z(12)*Z(194)-LRFFO*Z(399)*Z(202)-LRFF
     &O*Z(401)*Z(194)) - Z(620)*Z(33) - MHAT*(LFF*Z(33)+LRF*Z(44)+LSH*Z(
     &29)+LTH*Z(48)+HATO*Z(2))
      Z(749) = MFF*(Z(31)*Z(32)+Z(33)*Z(34)) + MFF*(Z(252)*Z(253)+Z(261)
     &*Z(262)) + MRF*(Z(31)*Z(32)+Z(33)*Z(34)) + MRF*(Z(194)*Z(195)+Z(20
     &2)*Z(203)) + MSH*(Z(139)*Z(140)+Z(143)*Z(144)) + MSH*(Z(194)*Z(195
     &)+Z(202)*Z(203)) + MTH*(Z(155)*Z(156)+Z(160)*Z(161)) + MTH*(Z(175)
     &*Z(176)+Z(181)*Z(182))
      Z(750) = MFF*(Z(252)*Z(355)+Z(261)*Z(356)) + MSH*(Z(139)*Z(311)+Z(
     &143)*Z(312)) + MSH*(Z(194)*Z(336)+Z(202)*Z(337)) + MTH*(Z(155)*Z(3
     &19)+Z(160)*Z(320)) + MTH*(Z(175)*Z(327)+Z(181)*Z(328)) + MHAT*(Z(3
     &21)*Z(48)+Z(369)*Z(44)+Z(370)*Z(29)+Z(1)*Z(371)+Z(31)*Z(373)-Z(366
     &)*Z(33)-Z(2)*Z(372)-Z(27)*Z(375)-Z(42)*Z(374)-Z(46)*Z(376)) - MFF*
     &(Z(292)*Z(33)-Z(31)*Z(294)) - 0.5D0*MRF*(2*Z(295)*Z(33)+Z(18)*Z(29
     &7)*Z(31)+Z(396)*Z(298)*Z(33)+Z(397)*Z(298)*Z(31)+Z(17)*Z(31)*Z(300
     &)+Z(18)*Z(33)*Z(300)-Z(17)*Z(297)*Z(33)-2*Z(31)*Z(296)-Z(396)*Z(31
     &)*Z(301)-Z(398)*Z(33)*Z(301)) - 0.5D0*MRF*(Z(399)*Z(342)*Z(202)+Z(
     &401)*Z(342)*Z(194)+2*Z(11)*Z(341)*Z(202)+2*Z(12)*Z(341)*Z(194)+2*Z
     &(12)*Z(202)*Z(344)-2*Z(194)*Z(339)-2*Z(202)*Z(340)-2*Z(11)*Z(194)*
     &Z(344)-Z(399)*Z(194)*Z(345)-Z(400)*Z(202)*Z(345))
      Z(751) = MHAT + MFF*(Z(32)**2+Z(34)**2) + MFF*(Z(253)**2+Z(262)**2
     &) + MRF*(Z(32)**2+Z(34)**2) + MRF*(Z(195)**2+Z(203)**2) + MSH*(Z(1
     &40)**2+Z(144)**2) + MSH*(Z(195)**2+Z(203)**2) + MTH*(Z(156)**2+Z(1
     &61)**2) + MTH*(Z(176)**2+Z(182)**2)
      Z(752) = MFF*(Z(249)*Z(253)+Z(267)*Z(262)) + MSH*(Z(138)*Z(140)+Z(
     &148)*Z(144)) + MSH*(Z(191)*Z(195)+Z(208)*Z(203)) + MTH*(Z(154)*Z(1
     &56)+Z(164)*Z(161)) + MTH*(Z(173)*Z(176)+Z(185)*Z(182)) + 0.5D0*MRF
     &*(LRFO*Z(17)*Z(34)-2*LFF*Z(34)-LRFFO*Z(396)*Z(34)-LRFFO*Z(397)*Z(3
     &2)-LRFO*Z(18)*Z(32)) + 0.5D0*MRF*(2*Z(191)*Z(195)+2*Z(212)*Z(203)-
     &2*Z(69)*Z(11)*Z(203)-2*Z(69)*Z(12)*Z(195)-LRFFO*Z(399)*Z(203)-LRFF
     &O*Z(401)*Z(195)) - Z(620)*Z(34) - MHAT*(LFF*Z(34)+LRF*Z(45)+LSH*Z(
     &30)+LTH*Z(46)-HATO*Z(1))
      Z(753) = MFF*(Z(253)*Z(355)+Z(262)*Z(356)) + MSH*(Z(140)*Z(311)+Z(
     &144)*Z(312)) + MSH*(Z(195)*Z(336)+Z(203)*Z(337)) + MTH*(Z(156)*Z(3
     &19)+Z(161)*Z(320)) + MTH*(Z(176)*Z(327)+Z(182)*Z(328)) + MHAT*(Z(3
     &21)*Z(46)+Z(369)*Z(45)+Z(370)*Z(30)+Z(1)*Z(372)+Z(2)*Z(371)+Z(32)*
     &Z(373)-Z(366)*Z(34)-Z(28)*Z(375)-Z(43)*Z(374)-Z(47)*Z(376)) - MFF*
     &(Z(292)*Z(34)-Z(32)*Z(294)) - 0.5D0*MRF*(2*Z(295)*Z(34)+Z(18)*Z(29
     &7)*Z(32)+Z(396)*Z(298)*Z(34)+Z(397)*Z(298)*Z(32)+Z(17)*Z(32)*Z(300
     &)+Z(18)*Z(34)*Z(300)-Z(17)*Z(297)*Z(34)-2*Z(32)*Z(296)-Z(396)*Z(32
     &)*Z(301)-Z(398)*Z(34)*Z(301)) - 0.5D0*MRF*(Z(399)*Z(342)*Z(203)+Z(
     &401)*Z(342)*Z(195)+2*Z(11)*Z(341)*Z(203)+2*Z(12)*Z(341)*Z(195)+2*Z
     &(12)*Z(203)*Z(344)-2*Z(195)*Z(339)-2*Z(203)*Z(340)-2*Z(11)*Z(195)*
     &Z(344)-Z(399)*Z(195)*Z(345)-Z(400)*Z(203)*Z(345))
      Z(767) = Z(754) + MFF*(Z(249)**2+Z(267)**2) + MSH*(Z(138)**2+Z(148
     &)**2) + MSH*(Z(191)**2+Z(208)**2) + MTH*(Z(154)**2+Z(164)**2) + MT
     &H*(Z(173)**2+Z(185)**2) + 0.25D0*MRF*(Z(755)+4*Z(756)*Z(396)-4*Z(7
     &57)*Z(17)) + 0.25D0*MRF*(Z(758)+4*Z(191)**2+4*Z(212)**2-4*Z(759)-8
     &*Z(69)*Z(11)*Z(212)-8*Z(69)*Z(12)*Z(191)-4*LRFFO*Z(191)*Z(401)-4*L
     &RFFO*Z(212)*Z(399)) + MHAT*(Z(760)+HATO**2+2*Z(761)*Z(21)+2*Z(762)
     &*Z(392)+2*Z(763)*Z(393)-2*Z(764)*Z(17)-2*Z(765)*Z(13)-2*Z(766)*Z(9
     &)-2*LSH*HATO*Z(24)-2*LTH*HATO*Z(5)-2*LFF*HATO*Z(116)-2*LRF*HATO*Z(
     &104))
      Z(774) = Z(736) + Z(738) + Z(740) + Z(743) + Z(744) + Z(745) + Z(6
     &20)*Z(292) + MFF*(Z(249)*Z(355)+Z(267)*Z(356)) + MSH*(Z(138)*Z(311
     &)+Z(148)*Z(312)) + MSH*(Z(191)*Z(336)+Z(208)*Z(337)) + MTH*(Z(154)
     &*Z(319)+Z(164)*Z(320)) + MTH*(Z(173)*Z(327)+Z(185)*Z(328)) + 0.25D
     &0*MRF*(LRFFO*Z(298)+LRFO*Z(297)+Z(768)*Z(297)+Z(769)*Z(298)+4*LFF*
     &Z(295)+2*LFF*Z(396)*Z(298)+2*LRFFO*Z(396)*Z(295)+Z(770)*Z(300)+2*L
     &FF*Z(18)*Z(300)-2*LFF*Z(17)*Z(297)-2*LRFO*Z(17)*Z(295)-Z(771)*Z(30
     &1)-2*LFF*Z(398)*Z(301)-2*LRFFO*Z(397)*Z(296)-2*LRFO*Z(18)*Z(296)) 
     &- Z(742) - Z(746) - 0.25D0*MRF*(2*Z(768)*Z(341)+2*Z(772)*Z(342)+2*
     &Z(191)*Z(401)*Z(342)+2*Z(212)*Z(399)*Z(342)+4*Z(11)*Z(212)*Z(341)+
     &4*Z(12)*Z(191)*Z(341)+2*Z(770)*Z(344)+2*LRFFO*Z(399)*Z(340)+2*LRFF
     &O*Z(401)*Z(339)+4*Z(69)*Z(11)*Z(340)+4*Z(69)*Z(12)*Z(339)+4*Z(12)*
     &Z(212)*Z(344)-4*Z(69)*Z(341)-LRFFO*Z(342)-4*Z(191)*Z(339)-4*Z(212)
     &*Z(340)-2*Z(773)*Z(345)-4*Z(11)*Z(191)*Z(344)-2*Z(191)*Z(399)*Z(34
     &5)-2*Z(212)*Z(400)*Z(345)) - MHAT*(LRF*Z(369)+LSH*Z(370)+LTH*Z(321
     &)+LFF*Z(21)*Z(370)+LFF*Z(392)*Z(321)+LRF*Z(17)*Z(366)+LRF*Z(393)*Z
     &(321)+LTH*Z(393)*Z(369)+HATO*Z(366)*Z(116)+LFF*Z(18)*Z(374)+LFF*Z(
     &114)*Z(371)+LFF*Z(116)*Z(372)+LRF*Z(14)*Z(375)+LRF*Z(18)*Z(373)+LR
     &F*Z(102)*Z(371)+LRF*Z(104)*Z(372)+LSH*Z(22)*Z(373)+LSH*Z(24)*Z(372
     &)+LSH*Z(26)*Z(371)+LTH*Z(5)*Z(372)+LTH*Z(6)*Z(371)+LTH*Z(10)*Z(375
     &)+LTH*Z(390)*Z(373)+HATO*Z(25)*Z(375)+HATO*Z(103)*Z(374)-LFF*Z(366
     &)-LFF*Z(17)*Z(369)-LRF*Z(13)*Z(370)-LSH*Z(9)*Z(321)-LSH*Z(13)*Z(36
     &9)-LSH*Z(21)*Z(366)-LTH*Z(9)*Z(370)-LTH*Z(392)*Z(366)-HATO*Z(5)*Z(
     &321)-HATO*Z(24)*Z(370)-HATO*Z(369)*Z(104)-HATO*Z(372)-LFF*Z(23)*Z(
     &375)-LFF*Z(391)*Z(376)-LRF*Z(395)*Z(376)-LSH*Z(10)*Z(376)-LSH*Z(14
     &)*Z(374)-LTH*Z(394)*Z(374)-HATO*Z(6)*Z(376)-HATO*Z(115)*Z(373))
      Z(812) = Z(723) - Z(750)
      Z(813) = Z(724) - Z(753)
      Z(827) = Z(226)*RRX2*Z(56) + Z(226)*RRY2*Z(57) + Z(241)*RRX2*Z(58)
     & + Z(241)*RRY2*Z(59) + Z(249)*RRX1*Z(64) + Z(249)*RRY1*Z(65) + Z(2
     &73)*RRX1*Z(66) + Z(273)*RRY1*Z(67) + Z(378)*(Z(249)*Z(65)+Z(267)*Z
     &(67)) + Z(380)*(Z(138)*Z(28)+Z(148)*Z(30)) + Z(380)*(Z(191)*Z(53)+
     &Z(208)*Z(55)) + Z(381)*(Z(154)*Z(47)+Z(164)*Z(46)) + Z(381)*(Z(173
     &)*Z(50)+Z(185)*Z(49)) - Z(725)*Z(34) - LFF*(LRX2*Z(33)+LRY2*Z(34))
     & - 0.5D0*Z(379)*(LRFFO*Z(41)+LRFO*Z(45)+2*LFF*Z(34)) - Z(377)*(LFF
     &*Z(34)+LRF*Z(45)+LSH*Z(30)+LTH*Z(46)-HATO*Z(1)) - 0.5D0*Z(379)*(LR
     &FFO*Z(63)-2*Z(69)*Z(59)-2*Z(191)*Z(53)-2*Z(212)*Z(55)) - Z(774)

      COEF(1,1) = -Z(747)
      COEF(1,2) = -Z(749)
      COEF(1,3) = -Z(748)
      COEF(2,1) = -Z(749)
      COEF(2,2) = -Z(751)
      COEF(2,3) = -Z(752)
      COEF(3,1) = -Z(748)
      COEF(3,2) = -Z(752)
      COEF(3,3) = -Z(767)
      RHS(1) = -Z(812)
      RHS(2) = -Z(813)
      RHS(3) = -Z(827)
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
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(827),COEF(3,3),RHS(3)

C**   Evaluate output quantities
      Z(149) = Z(145) - Z(147)
      Z(165) = Z(162) + Z(163)
      Z(186) = Z(183) - Z(184)
      Z(271) = Z(264) + Z(266)
      Z(268) = Z(68) + Z(260)
      Z(269) = Z(68) + Z(255)
      Z(270) = Z(68) - Z(263)
      Z(210) = Z(205) + Z(207)
      Z(209) = Z(70) - Z(204)
      KECM = 0.5D0*IHAT*U3**2 + 0.5D0*ITH*(LHp-U3-U5)**2 + 0.5D0*ITH*(RH
     &p-U3-U4)**2 + 0.5D0*ISH*(LHp-LKp-U3-U5-U7)**2 + 0.5D0*ISH*(RHp-RKp
     &-U3-U4-U6)**2 + 0.5D0*IRF*(LAp+LHp-LKp-U3-U5-U7-U9)**2 + 0.5D0*IRF
     &*(RAp+RHp-RKp-U3-U4-U6-U8)**2 + 0.5D0*IFF*(LAp+LHp+LMTPp-LKp-U3-U5
     &-U7-U9)**2 + 0.5D0*IFF*(RAp+RHp+RMTPp-RKp-U3-U4-U6-U8)**2 + 0.5D0*
     &MFF*((Z(31)*U1+Z(32)*U2)**2+(Z(118)+LFFO*U3+LFFO*U5+LFFO*U7+LFFO*U
     &9-Z(33)*U1-Z(34)*U2)**2) + 0.5D0*MSH*((Z(141)+Z(138)*U3+Z(138)*U5+
     &Z(138)*U7+Z(138)*U9+Z(139)*U1+Z(140)*U2)**2+(Z(149)+Z(142)*U9+Z(14
     &8)*U3+Z(148)*U5+Z(148)*U7+Z(143)*U1+Z(144)*U2)**2) + 0.5D0*MTH*((Z
     &(157)+Z(153)*U9+Z(154)*U3+Z(154)*U5+Z(154)*U7+Z(155)*U1+Z(156)*U2)
     &**2+(Z(165)+Z(158)*U9+Z(159)*U7+Z(164)*U3+Z(164)*U5+Z(160)*U1+Z(16
     &1)*U2)**2) + 0.5D0*MTH*((Z(177)+Z(172)*U9+Z(173)*U3+Z(173)*U5+Z(17
     &4)*U7+Z(175)*U1+Z(176)*U2)**2+(Z(186)+Z(71)*U4+Z(178)*U9+Z(179)*U7
     &+Z(180)*U5+Z(185)*U3+Z(181)*U1+Z(182)*U2)**2) + 0.5D0*MFF*((Z(254)
     &+Z(245)*U8+Z(246)*U9+Z(247)*U5+Z(248)*U7+Z(249)*U3+Z(250)*U4+Z(251
     &)*U6+Z(252)*U1+Z(253)*U2)**2+(Z(271)+Z(256)*U9+Z(257)*U5+Z(258)*U7
     &+Z(267)*U3+Z(268)*U4+Z(269)*U6+Z(270)*U8+Z(261)*U1+Z(262)*U2)**2) 
     &+ 0.5D0*MSH*((Z(210)+Z(70)*U6+Z(198)*U9+Z(200)*U5+Z(201)*U7+Z(208)
     &*U3+Z(209)*U4+Z(202)*U1+Z(203)*U2)**2+(Z(196)*U4-Z(197)-Z(190)*U9-
     &Z(191)*U3-Z(192)*U5-Z(193)*U7-Z(194)*U1-Z(195)*U2)**2) + 0.5D0*MHA
     &T*(HATOp**2+U1**2+U2**2+2*HATOp*Z(1)*U1+2*HATOp*Z(2)*U2+HATO**2*U3
     &**2+2*HATO*Z(1)*U2*U3+(Z(166)-LTH*U3-LTH*U5)**2+(Z(278)+LFF*U3+LFF
     &*U5+LFF*U7+LFF*U9)**2+2*Z(6)*HATOp*(Z(166)-LTH*U3-LTH*U5)+2*Z(46)*
     &U2*(Z(166)-LTH*U3-LTH*U5)+2*Z(48)*U1*(Z(166)-LTH*U3-LTH*U5)+(Z(280
     &)-LSH*U3-LSH*U5-LSH*U7)**2+2*HATO*Z(5)*U3*(Z(166)-LTH*U3-LTH*U5)+2
     &*Z(26)*HATOp*(Z(280)-LSH*U3-LSH*U5-LSH*U7)+2*Z(29)*U1*(Z(280)-LSH*
     &U3-LSH*U5-LSH*U7)+2*Z(30)*U2*(Z(280)-LSH*U3-LSH*U5-LSH*U7)+(Z(279)
     &-LRF*U3-LRF*U5-LRF*U7-LRF*U9)**2+2*HATO*Z(24)*U3*(Z(280)-LSH*U3-LS
     &H*U5-LSH*U7)+2*HATOp*Z(102)*(Z(279)-LRF*U3-LRF*U5-LRF*U7-LRF*U9)+2
     &*Z(44)*U1*(Z(279)-LRF*U3-LRF*U5-LRF*U7-LRF*U9)+2*Z(45)*U2*(Z(279)-
     &LRF*U3-LRF*U5-LRF*U7-LRF*U9)+2*HATO*Z(104)*U3*(Z(279)-LRF*U3-LRF*U
     &5-LRF*U7-LRF*U9)+2*Z(393)*(Z(166)-LTH*U3-LTH*U5)*(Z(279)-LRF*U3-LR
     &F*U5-LRF*U7-LRF*U9)+2*Z(17)*(Z(278)+LFF*U3+LFF*U5+LFF*U7+LFF*U9)*(
     &Z(279)-LRF*U3-LRF*U5-LRF*U7-LRF*U9)-2*HATO*Z(2)*U1*U3-2*HATOp*Z(11
     &4)*(Z(278)+LFF*U3+LFF*U5+LFF*U7+LFF*U9)-2*Z(33)*U1*(Z(278)+LFF*U3+
     &LFF*U5+LFF*U7+LFF*U9)-2*Z(34)*U2*(Z(278)+LFF*U3+LFF*U5+LFF*U7+LFF*
     &U9)-2*HATO*Z(116)*U3*(Z(278)+LFF*U3+LFF*U5+LFF*U7+LFF*U9)-2*Z(392)
     &*(Z(166)-LTH*U3-LTH*U5)*(Z(278)+LFF*U3+LFF*U5+LFF*U7+LFF*U9)-2*Z(9
     &)*(Z(166)-LTH*U3-LTH*U5)*(Z(280)-LSH*U3-LSH*U5-LSH*U7)-2*Z(21)*(Z(
     &278)+LFF*U3+LFF*U5+LFF*U7+LFF*U9)*(Z(280)-LSH*U3-LSH*U5-LSH*U7)-2*
     &Z(13)*(Z(280)-LSH*U3-LSH*U5-LSH*U7)*(Z(279)-LRF*U3-LRF*U5-LRF*U7-L
     &RF*U9)) - 0.125D0*MRF*(4*Z(18)*(Z(31)*U1+Z(32)*U2)*(Z(125)+LRFO*U3
     &+LRFO*U5+LRFO*U7+LRFO*U9)+4*Z(397)*(Z(31)*U1+Z(32)*U2)*(Z(126)+LRF
     &FO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)+4*Z(17)*(Z(125)+LRFO*U3+LRFO*U5+
     &LRFO*U7+LRFO*U9)*(Z(119)+LFF*U3+LFF*U5+LFF*U7+LFF*U9-Z(33)*U1-Z(34
     &)*U2)-4*(Z(31)*U1+Z(32)*U2)**2-(Z(125)+LRFO*U3+LRFO*U5+LRFO*U7+LRF
     &O*U9)**2-(Z(126)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)**2-4*(Z(119)
     &+LFF*U3+LFF*U5+LFF*U7+LFF*U9-Z(33)*U1-Z(34)*U2)**2-2*Z(19)*(Z(125)
     &+LRFO*U3+LRFO*U5+LRFO*U7+LRFO*U9)*(Z(126)+LRFFO*U3+LRFFO*U5+LRFFO*
     &U7+LRFFO*U9)-4*Z(396)*(Z(126)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)
     &*(Z(119)+LFF*U3+LFF*U5+LFF*U7+LFF*U9-Z(33)*U1-Z(34)*U2)) - 0.125D0
     &*MRF*(4*Z(19)*(Z(220)+Z(69)*U3+Z(69)*U4+Z(69)*U6+Z(69)*U8)*(Z(221)
     &+LRFFO*U3+LRFFO*U4+LRFFO*U6+LRFFO*U8)+4*Z(399)*(Z(221)+LRFFO*U3+LR
     &FFO*U4+LRFFO*U6+LRFFO*U8)*(Z(214)+LSH*U6+Z(198)*U9+Z(200)*U5+Z(201
     &)*U7+Z(212)*U3+Z(213)*U4+Z(202)*U1+Z(203)*U2)+8*Z(11)*(Z(220)+Z(69
     &)*U3+Z(69)*U4+Z(69)*U6+Z(69)*U8)*(Z(214)+LSH*U6+Z(198)*U9+Z(200)*U
     &5+Z(201)*U7+Z(212)*U3+Z(213)*U4+Z(202)*U1+Z(203)*U2)-4*(Z(220)+Z(6
     &9)*U3+Z(69)*U4+Z(69)*U6+Z(69)*U8)**2-(Z(221)+LRFFO*U3+LRFFO*U4+LRF
     &FO*U6+LRFFO*U8)**2-4*(Z(214)+LSH*U6+Z(198)*U9+Z(200)*U5+Z(201)*U7+
     &Z(212)*U3+Z(213)*U4+Z(202)*U1+Z(203)*U2)**2-4*(Z(196)*U4-Z(197)-Z(
     &190)*U9-Z(191)*U3-Z(192)*U5-Z(193)*U7-Z(194)*U1-Z(195)*U2)**2-8*Z(
     &12)*(Z(220)+Z(69)*U3+Z(69)*U4+Z(69)*U6+Z(69)*U8)*(Z(196)*U4-Z(197)
     &-Z(190)*U9-Z(191)*U3-Z(192)*U5-Z(193)*U7-Z(194)*U1-Z(195)*U2)-4*Z(
     &401)*(Z(221)+LRFFO*U3+LRFFO*U4+LRFFO*U6+LRFFO*U8)*(Z(196)*U4-Z(197
     &)-Z(190)*U9-Z(191)*U3-Z(192)*U5-Z(193)*U7-Z(194)*U1-Z(195)*U2))
      Z(73) = MHAT*HATO/Z(72)
      Z(36) = Z(19)*Z(14) - Z(20)*Z(13)
      Z(39) = Z(35)*Z(28) + Z(36)*Z(30)
      Z(61) = Z(19)*Z(57) + Z(20)*Z(59)
      POCMY = Q2 + Z(79)*Z(65) + Z(80)*Z(57) + Z(81)*Z(53) + Z(82)*Z(50)
     & + Z(73)*Z(2) - Z(74)*Z(32) - Z(77)*Z(28) - Z(78)*Z(47) - 0.5D0*Z(
     &75)*Z(43) - 0.5D0*Z(76)*Z(39) - 0.5D0*Z(76)*Z(61)
      PECM = 0.5D0*K1*Q1**2 + 0.5D0*K3*Q2**2 - G*(MHAT+2*MFF+2*MRF+2*MSH
     &+2*MTH)*POCMY
      TE = KECM + PECM
      Z(402) = IFF*Z(117)
      Z(403) = IRF*Z(120)
      Z(404) = ISH*Z(146)
      Z(406) = IFF*Z(265)
      Z(407) = IRF*Z(215)
      Z(408) = ISH*Z(206)
      Z(109) = Z(1)*Z(65) - Z(2)*Z(64)
      Z(97) = Z(1)*Z(57) - Z(2)*Z(56)
      Z(89) = Z(1)*Z(53) - Z(2)*Z(52)
      Z(38) = Z(35)*Z(27) + Z(36)*Z(29)
      Z(123) = Z(1)*Z(39) - Z(2)*Z(38)
      Z(60) = Z(19)*Z(56) + Z(20)*Z(58)
      Z(218) = Z(1)*Z(61) - Z(2)*Z(60)
      Z(574) = MHAT*HATOp*(2*Z(414)*Z(6)+2*Z(79)*Z(109)+2*Z(80)*Z(97)+2*
     &Z(81)*Z(89)-2*Z(82)*Z(4)-2*Z(413)*Z(25)-2*Z(411)*Z(115)-2*Z(412)*Z
     &(103)-Z(76)*Z(123)-Z(76)*Z(218))
      Z(410) = HATO - Z(73)
      Z(581) = MHAT*(2*Z(79)*Z(65)+2*Z(80)*Z(57)+2*Z(81)*Z(53)+2*Z(82)*Z
     &(50)-2*Z(411)*Z(32)-2*Z(412)*Z(43)-2*Z(413)*Z(28)-2*Z(414)*Z(47)-2
     &*Z(410)*Z(2)-Z(76)*Z(39)-Z(76)*Z(61))
      Z(389) = Z(10)*Z(22) - Z(9)*Z(21)
      Z(419) = Z(31)*Z(64) + Z(32)*Z(65)
      Z(421) = Z(31)*Z(66) + Z(32)*Z(67)
      Z(435) = -Z(15)*Z(419) - Z(16)*Z(421)
      Z(437) = Z(16)*Z(419) - Z(15)*Z(421)
      Z(451) = Z(19)*Z(435) + Z(20)*Z(437)
      Z(467) = -Z(11)*Z(435) - Z(12)*Z(437)
      Z(113) = Z(1)*Z(31) + Z(2)*Z(32)
      Z(483) = Z(3)*Z(113) - Z(4)*Z(115)
      Z(495) = Z(74) + Z(77)*Z(21) + Z(78)*Z(389) + 0.5D0*Z(76)*Z(396) +
     & 0.5D0*Z(76)*Z(451) - LFFO - 0.5D0*Z(75)*Z(17) - Z(79)*Z(419) - Z(
     &80)*Z(435) - Z(81)*Z(467) - Z(82)*Z(483) - Z(73)*Z(113)
      Z(582) = MFF*Z(495)
      Z(498) = Z(33)*U1 + Z(34)*U2 - Z(118) - LFFO*U3 - LFFO*U5 - LFFO*U
     &7 - LFFO*U9
      Z(427) = Z(27)*Z(64) + Z(28)*Z(65)
      Z(429) = Z(27)*Z(66) + Z(28)*Z(67)
      Z(443) = -Z(15)*Z(427) - Z(16)*Z(429)
      Z(445) = Z(16)*Z(427) - Z(15)*Z(429)
      Z(459) = Z(19)*Z(443) + Z(20)*Z(445)
      Z(491) = Z(3)*Z(24) - Z(4)*Z(25)
      Z(475) = -Z(11)*Z(443) - Z(12)*Z(445)
      Z(526) = Z(77) + 0.5D0*Z(76)*Z(35) + 0.5D0*Z(524)*Z(13) + 0.5D0*Z(
     &76)*Z(459) - LSHO - Z(78)*Z(9) - Z(82)*Z(491) - Z(525)*Z(21) - Z(2
     &4)*Z(73) - Z(79)*Z(427) - Z(80)*Z(443) - Z(81)*Z(475)
      Z(590) = MSH*Z(526)
      Z(529) = Z(149) + Z(142)*U9 + Z(148)*U3 + Z(148)*U5 + Z(148)*U7 + 
     &Z(143)*U1 + Z(144)*U2
      Z(415) = Z(19)*Z(393) + Z(20)*Z(395)
      Z(431) = Z(46)*Z(64) + Z(47)*Z(65)
      Z(433) = Z(46)*Z(66) + Z(47)*Z(67)
      Z(447) = -Z(15)*Z(431) - Z(16)*Z(433)
      Z(449) = Z(16)*Z(431) - Z(15)*Z(433)
      Z(463) = Z(19)*Z(447) + Z(20)*Z(449)
      Z(479) = -Z(7)*Z(169) - Z(8)*Z(170)
      Z(531) = Z(78) + Z(530)*Z(9) + 0.5D0*Z(76)*Z(415) + 0.5D0*Z(76)*Z(
     &463) - LTHO - Z(81)*Z(479) - Z(82)*Z(169) - Z(525)*Z(389) - Z(5)*Z
     &(73) - 0.5D0*Z(524)*Z(393) - Z(79)*Z(431) - Z(80)*Z(447)
      Z(592) = MTH*Z(531)
      Z(534) = Z(165) + Z(158)*U9 + Z(159)*U7 + Z(164)*U3 + Z(164)*U5 + 
     &Z(160)*U1 + Z(161)*U2
      Z(538) = Z(11)*Z(15) - Z(12)*Z(16)
      Z(535) = Z(20)*Z(16) - Z(19)*Z(15)
      Z(107) = Z(1)*Z(64) + Z(2)*Z(65)
      Z(541) = Z(3)*Z(107) - Z(4)*Z(109)
      Z(504) = Z(38)*Z(64) + Z(39)*Z(65)
      Z(423) = Z(42)*Z(64) + Z(43)*Z(65)
      Z(549) = LFF + Z(545)*Z(538) + 0.5D0*Z(76)*Z(535) + Z(546)*Z(541) 
     &+ 0.5D0*Z(76)*Z(504) - LFFO - Z(79) - Z(547)*Z(15) - Z(525)*Z(419)
     & - Z(530)*Z(427) - Z(548)*Z(431) - Z(73)*Z(107) - 0.5D0*Z(524)*Z(4
     &23)
      Z(594) = MFF*Z(549)
      Z(552) = Z(271) + Z(256)*U9 + Z(257)*U5 + Z(258)*U7 + Z(267)*U3 + 
     &Z(268)*U4 + Z(269)*U6 + Z(270)*U8 + Z(261)*U1 + Z(262)*U2
      Z(506) = Z(38)*Z(66) + Z(39)*Z(67)
      Z(508) = -Z(15)*Z(504) - Z(16)*Z(506)
      Z(510) = Z(16)*Z(504) - Z(15)*Z(506)
      Z(516) = -Z(11)*Z(508) - Z(12)*Z(510)
      Z(87) = Z(1)*Z(52) + Z(2)*Z(53)
      Z(425) = Z(42)*Z(66) + Z(43)*Z(67)
      Z(439) = -Z(15)*Z(423) - Z(16)*Z(425)
      Z(441) = Z(16)*Z(423) - Z(15)*Z(425)
      Z(471) = -Z(11)*Z(439) - Z(12)*Z(441)
      Z(566) = LSH + Z(80)*Z(11) + 0.5D0*Z(76)*Z(399) + 0.5D0*Z(76)*Z(51
     &6) - LSHO - Z(81) - Z(79)*Z(538) - Z(546)*Z(7) - Z(548)*Z(479) - Z
     &(525)*Z(467) - Z(530)*Z(475) - Z(73)*Z(87) - 0.5D0*Z(524)*Z(471)
      Z(602) = MSH*Z(566)
      Z(568) = Z(210) + Z(70)*U6 + Z(198)*U9 + Z(200)*U5 + Z(201)*U7 + Z
     &(208)*U3 + Z(209)*U4 + Z(202)*U1 + Z(203)*U2
      Z(121) = Z(1)*Z(38) + Z(2)*Z(39)
      Z(520) = Z(3)*Z(121) - Z(4)*Z(123)
      Z(216) = Z(1)*Z(60) + Z(2)*Z(61)
      Z(562) = Z(3)*Z(216) - Z(4)*Z(218)
      Z(95) = Z(1)*Z(56) + Z(2)*Z(57)
      Z(558) = Z(3)*Z(95) - Z(4)*Z(97)
      Z(101) = Z(1)*Z(42) + Z(2)*Z(43)
      Z(487) = Z(3)*Z(101) - Z(4)*Z(103)
      Z(569) = LTH + Z(81)*Z(7) + 0.5D0*Z(76)*Z(520) + 0.5D0*Z(76)*Z(562
     &) - LTHO - Z(82) - Z(530)*Z(491) - Z(548)*Z(169) - Z(3)*Z(73) - Z(
     &79)*Z(541) - Z(80)*Z(558) - Z(525)*Z(483) - 0.5D0*Z(524)*Z(487)
      Z(604) = MTH*Z(569)
      Z(572) = Z(186) + Z(71)*U4 + Z(178)*U9 + Z(179)*U7 + Z(180)*U5 + Z
     &(185)*U3 + Z(181)*U1 + Z(182)*U2
      Z(578) = MHAT*(2*Z(413)+Z(76)*Z(35)+2*Z(411)*Z(21)+2*Z(24)*Z(410)+
     &Z(76)*Z(459)-2*Z(82)*Z(491)-2*Z(412)*Z(13)-2*Z(414)*Z(9)-2*Z(79)*Z
     &(427)-2*Z(80)*Z(443)-2*Z(81)*Z(475))
      Z(579) = MHAT*(2*Z(414)+Z(76)*Z(415)+2*Z(411)*Z(389)+2*Z(412)*Z(39
     &3)+2*Z(5)*Z(410)+Z(76)*Z(463)-2*Z(81)*Z(479)-2*Z(82)*Z(169)-2*Z(41
     &3)*Z(9)-2*Z(79)*Z(431)-2*Z(80)*Z(447))
      Z(585) = MRF*(2*Z(411)+2*Z(77)*Z(21)+2*Z(78)*Z(389)+2*Z(500)*Z(396
     &)+Z(76)*Z(451)-2*Z(499)*Z(17)-2*Z(79)*Z(419)-2*Z(80)*Z(435)-2*Z(81
     &)*Z(467)-2*Z(82)*Z(483)-2*Z(73)*Z(113))
      Z(501) = Z(33)*U1 + Z(34)*U2 - Z(119) - LFF*U3 - LFF*U5 - LFF*U7 -
     & LFF*U9
      Z(455) = Z(19)*Z(439) + Z(20)*Z(441)
      Z(587) = MRF*(Z(586)+2*Z(78)*Z(393)+Z(76)*Z(455)-2*Z(77)*Z(13)-2*Z
     &(411)*Z(17)-2*Z(79)*Z(423)-2*Z(80)*Z(439)-2*Z(81)*Z(471)-2*Z(82)*Z
     &(487)-2*Z(73)*Z(101))
      Z(502) = -0.5D0*Z(125) - 0.5D0*LRFO*U3 - 0.5D0*LRFO*U5 - 0.5D0*LRF
     &O*U7 - 0.5D0*LRFO*U9
      Z(512) = Z(19)*Z(508) + Z(20)*Z(510)
      Z(589) = MRF*(Z(588)+2*Z(77)*Z(35)+2*Z(78)*Z(415)+2*Z(411)*Z(396)+
     &Z(76)*Z(512)-2*Z(79)*Z(504)-2*Z(80)*Z(508)-2*Z(81)*Z(516)-2*Z(82)*
     &Z(520)-2*Z(73)*Z(121))
      Z(503) = -0.5D0*Z(126) - 0.5D0*LRFFO*U3 - 0.5D0*LRFFO*U5 - 0.5D0*L
     &RFFO*U7 - 0.5D0*LRFFO*U9
      Z(597) = MRF*(Z(596)+2*Z(79)*Z(15)+Z(76)*Z(508)+2*Z(411)*Z(435)+2*
     &Z(412)*Z(439)+2*Z(413)*Z(443)+2*Z(414)*Z(447)+2*Z(546)*Z(558)-2*Z(
     &545)*Z(11)-2*Z(73)*Z(95))
      Z(554) = Z(220) + Z(69)*U3 + Z(69)*U4 + Z(69)*U6 + Z(69)*U8
      Z(599) = MRF*(Z(598)+2*Z(545)*Z(399)+Z(76)*Z(512)+2*Z(411)*Z(451)+
     &2*Z(412)*Z(455)+2*Z(413)*Z(459)+2*Z(414)*Z(463)+2*Z(546)*Z(562)-2*
     &Z(79)*Z(535)-2*Z(73)*Z(216))
      Z(555) = -0.5D0*Z(221) - 0.5D0*LRFFO*U3 - 0.5D0*LRFFO*U4 - 0.5D0*L
     &RFFO*U6 - 0.5D0*LRFFO*U8
      Z(601) = MRF*(2*Z(545)+2*Z(414)*Z(479)+2*Z(500)*Z(399)+Z(76)*Z(516
     &)+2*Z(411)*Z(467)+2*Z(412)*Z(471)+2*Z(413)*Z(475)-2*Z(79)*Z(538)-2
     &*Z(546)*Z(7)-2*Z(553)*Z(11)-2*Z(73)*Z(87))
      Z(557) = Z(214) + LSH*U6 + Z(198)*U9 + Z(200)*U5 + Z(201)*U7 + Z(2
     &12)*U3 + Z(213)*U4 + Z(202)*U1 + Z(203)*U2
      Z(405) = ITH*LHp
      Z(409) = ITH*RHp
      Z(580) = MHAT*(2*Z(79)*Z(64)+2*Z(80)*Z(56)+2*Z(81)*Z(52)+2*Z(82)*Z
     &(49)-2*Z(411)*Z(31)-2*Z(412)*Z(42)-2*Z(413)*Z(27)-2*Z(414)*Z(46)-2
     &*Z(410)*Z(1)-Z(76)*Z(38)-Z(76)*Z(60))
      Z(420) = Z(33)*Z(64) + Z(34)*Z(65)
      Z(422) = Z(33)*Z(66) + Z(34)*Z(67)
      Z(436) = -Z(15)*Z(420) - Z(16)*Z(422)
      Z(438) = Z(16)*Z(420) - Z(15)*Z(422)
      Z(452) = Z(19)*Z(436) + Z(20)*Z(438)
      Z(468) = -Z(11)*Z(436) - Z(12)*Z(438)
      Z(484) = Z(3)*Z(114) - Z(4)*Z(116)
      Z(496) = Z(77)*Z(23) + Z(78)*Z(391) + 0.5D0*Z(76)*Z(398) + 0.5D0*Z
     &(76)*Z(452) - 0.5D0*Z(75)*Z(18) - Z(79)*Z(420) - Z(80)*Z(436) - Z(
     &81)*Z(468) - Z(82)*Z(484) - Z(73)*Z(114)
      Z(583) = MFF*Z(496)
      Z(497) = Z(31)*U1 + Z(32)*U2
      Z(428) = Z(29)*Z(64) + Z(30)*Z(65)
      Z(430) = Z(29)*Z(66) + Z(30)*Z(67)
      Z(444) = -Z(15)*Z(428) - Z(16)*Z(430)
      Z(446) = Z(16)*Z(428) - Z(15)*Z(430)
      Z(460) = Z(19)*Z(444) + Z(20)*Z(446)
      Z(492) = Z(3)*Z(26) - Z(4)*Z(24)
      Z(476) = -Z(11)*Z(444) - Z(12)*Z(446)
      Z(527) = Z(78)*Z(10) + 0.5D0*Z(76)*Z(36) + 0.5D0*Z(76)*Z(460) - Z(
     &82)*Z(492) - Z(525)*Z(22) - Z(26)*Z(73) - 0.5D0*Z(524)*Z(14) - Z(7
     &9)*Z(428) - Z(80)*Z(444) - Z(81)*Z(476)
      Z(591) = MSH*Z(527)
      Z(528) = Z(141) + Z(138)*U3 + Z(138)*U5 + Z(138)*U7 + Z(138)*U9 + 
     &Z(139)*U1 + Z(140)*U2
      Z(416) = Z(19)*Z(394) + Z(20)*Z(393)
      Z(432) = Z(46)*Z(65) + Z(48)*Z(64)
      Z(434) = Z(46)*Z(67) + Z(48)*Z(66)
      Z(448) = -Z(15)*Z(432) - Z(16)*Z(434)
      Z(450) = Z(16)*Z(432) - Z(15)*Z(434)
      Z(464) = Z(19)*Z(448) + Z(20)*Z(450)
      Z(480) = -Z(7)*Z(171) - Z(8)*Z(169)
      Z(532) = Z(530)*Z(10) + 0.5D0*Z(76)*Z(416) + 0.5D0*Z(76)*Z(464) - 
     &Z(81)*Z(480) - Z(82)*Z(171) - Z(525)*Z(390) - Z(6)*Z(73) - 0.5D0*Z
     &(524)*Z(394) - Z(79)*Z(432) - Z(80)*Z(448)
      Z(593) = MTH*Z(532)
      Z(533) = Z(157) + Z(153)*U9 + Z(154)*U3 + Z(154)*U5 + Z(154)*U7 + 
     &Z(155)*U1 + Z(156)*U2
      Z(539) = Z(11)*Z(16) + Z(12)*Z(15)
      Z(536) = -Z(19)*Z(16) - Z(20)*Z(15)
      Z(108) = Z(1)*Z(66) + Z(2)*Z(67)
      Z(110) = Z(1)*Z(67) - Z(2)*Z(66)
      Z(542) = Z(3)*Z(108) - Z(4)*Z(110)
      Z(550) = Z(545)*Z(539) + 0.5D0*Z(76)*Z(536) + Z(546)*Z(542) + 0.5D
     &0*Z(76)*Z(506) - Z(547)*Z(16) - Z(525)*Z(421) - Z(530)*Z(429) - Z(
     &548)*Z(433) - Z(73)*Z(108) - 0.5D0*Z(524)*Z(425)
      Z(595) = MFF*Z(550)
      Z(551) = Z(254) + Z(245)*U8 + Z(246)*U9 + Z(247)*U5 + Z(248)*U7 + 
     &Z(249)*U3 + Z(250)*U4 + Z(251)*U6 + Z(252)*U1 + Z(253)*U2
      Z(518) = Z(12)*Z(508) - Z(11)*Z(510)
      Z(540) = -Z(11)*Z(16) - Z(12)*Z(15)
      Z(481) = Z(8)*Z(169) - Z(7)*Z(170)
      Z(469) = Z(12)*Z(435) - Z(11)*Z(437)
      Z(477) = Z(12)*Z(443) - Z(11)*Z(445)
      Z(88) = Z(1)*Z(54) + Z(2)*Z(55)
      Z(473) = Z(12)*Z(439) - Z(11)*Z(441)
      Z(567) = Z(546)*Z(8) + 0.5D0*Z(76)*Z(400) + 0.5D0*Z(76)*Z(518) - Z
     &(79)*Z(540) - Z(80)*Z(12) - Z(548)*Z(481) - Z(525)*Z(469) - Z(530)
     &*Z(477) - Z(73)*Z(88) - 0.5D0*Z(524)*Z(473)
      Z(603) = MSH*Z(567)
      Z(556) = Z(197) + Z(190)*U9 + Z(191)*U3 + Z(192)*U5 + Z(193)*U7 + 
     &Z(194)*U1 + Z(195)*U2 - Z(196)*U4
      Z(522) = Z(3)*Z(123) + Z(4)*Z(121)
      Z(564) = Z(3)*Z(218) + Z(4)*Z(216)
      Z(493) = Z(3)*Z(25) + Z(4)*Z(24)
      Z(543) = Z(3)*Z(109) + Z(4)*Z(107)
      Z(560) = Z(3)*Z(97) + Z(4)*Z(95)
      Z(485) = Z(3)*Z(115) + Z(4)*Z(113)
      Z(489) = Z(3)*Z(103) + Z(4)*Z(101)
      Z(570) = Z(81)*Z(8) + 0.5D0*Z(76)*Z(522) + 0.5D0*Z(76)*Z(564) - Z(
     &530)*Z(493) - Z(548)*Z(170) - Z(4)*Z(73) - Z(79)*Z(543) - Z(80)*Z(
     &560) - Z(525)*Z(485) - 0.5D0*Z(524)*Z(489)
      Z(605) = MTH*Z(570)
      Z(571) = Z(177) + Z(172)*U9 + Z(173)*U3 + Z(173)*U5 + Z(174)*U7 + 
     &Z(175)*U1 + Z(176)*U2
      Z(573) = MHAT*(2*Z(82)*Z(3)+2*Z(79)*Z(107)+2*Z(80)*Z(95)+2*Z(81)*Z
     &(87)-2*Z(410)-2*Z(413)*Z(24)-2*Z(414)*Z(5)-2*Z(411)*Z(113)-2*Z(412
     &)*Z(101)-Z(76)*Z(121)-Z(76)*Z(216))
      Z(575) = MHAT*(2*Z(412)*Z(17)+2*Z(79)*Z(419)+2*Z(80)*Z(435)+2*Z(81
     &)*Z(467)+2*Z(82)*Z(483)-2*Z(411)-2*Z(413)*Z(21)-2*Z(414)*Z(389)-Z(
     &76)*Z(396)-2*Z(410)*Z(113)-Z(76)*Z(451))
      Z(577) = MHAT*(2*Z(411)*Z(17)+2*Z(413)*Z(13)+2*Z(79)*Z(423)+2*Z(80
     &)*Z(439)+2*Z(81)*Z(471)+2*Z(82)*Z(487)-2*Z(412)-Z(576)-2*Z(414)*Z(
     &393)-2*Z(410)*Z(101)-Z(76)*Z(455))
      Z(584) = MRF*(2*Z(77)*Z(23)+2*Z(78)*Z(391)+2*Z(500)*Z(398)+Z(76)*Z
     &(452)-2*Z(499)*Z(18)-2*Z(79)*Z(420)-2*Z(80)*Z(436)-2*Z(81)*Z(468)-
     &2*Z(82)*Z(484)-2*Z(73)*Z(114))
      Z(600) = MRF*(2*Z(414)*Z(481)+2*Z(500)*Z(400)+2*Z(546)*Z(8)+2*Z(55
     &3)*Z(12)+Z(76)*Z(518)+2*Z(411)*Z(469)+2*Z(412)*Z(473)+2*Z(413)*Z(4
     &77)-2*Z(79)*Z(540)-2*Z(73)*Z(88))
      HZ = Z(402) + Z(403) + Z(404) + Z(406) + Z(407) + Z(408) + 0.5D0*Z
     &(574) + IFF*U4 + IFF*U5 + IFF*U6 + IFF*U7 + IFF*U8 + IFF*U9 + IHAT
     &*U3 + IRF*U4 + IRF*U5 + IRF*U6 + IRF*U7 + IRF*U8 + IRF*U9 + ISH*U4
     & + ISH*U5 + ISH*U6 + ISH*U7 + ITH*U4 + ITH*U5 + 0.5D0*Z(581)*U1 + 
     &2*IFF*U3 + 2*IRF*U3 + 2*ISH*U3 + 2*ITH*U3 + Z(582)*Z(498) + Z(590)
     &*Z(529) + Z(592)*Z(534) + Z(594)*Z(552) + Z(602)*Z(568) + Z(604)*Z
     &(572) + 0.5D0*Z(578)*Z(363) + 0.5D0*Z(579)*Z(364) + 0.5D0*Z(585)*Z
     &(501) + 0.5D0*Z(587)*Z(502) + 0.5D0*Z(589)*Z(503) + 0.5D0*Z(597)*Z
     &(554) + 0.5D0*Z(599)*Z(555) + 0.5D0*Z(601)*Z(557) - Z(405) - Z(409
     &) - 0.5D0*Z(580)*U2 - Z(583)*Z(497) - Z(591)*Z(528) - Z(593)*Z(533
     &) - Z(595)*Z(551) - Z(603)*Z(556) - Z(605)*Z(571) - 0.5D0*Z(573)*Z
     &(360) - 0.5D0*Z(575)*Z(361) - 0.5D0*Z(577)*Z(362) - 0.5D0*Z(584)*Z
     &(497) - 0.5D0*Z(600)*Z(556)
      Z(606) = MHAT*HATOp
      Z(616) = MFF*Z(31)
      Z(617) = MFF*Z(32)
      Z(622) = MRF*Z(31)
      Z(623) = MRF*Z(32)
      Z(673) = MRF*Z(220)
      Z(635) = MSH*Z(141)
      Z(632) = MSH*Z(138)
      Z(633) = MSH*Z(139)
      Z(634) = MSH*Z(140)
      Z(645) = MTH*Z(157)
      Z(641) = MTH*Z(153)
      Z(642) = MTH*Z(154)
      Z(643) = MTH*Z(155)
      Z(644) = MTH*Z(156)
      Z(714) = MTH*Z(177)
      Z(709) = MTH*Z(172)
      Z(710) = MTH*Z(173)
      Z(711) = MTH*Z(174)
      Z(712) = MTH*Z(175)
      Z(713) = MTH*Z(176)
      Z(722) = MTH*Z(186)
      Z(716) = MTH*Z(178)
      Z(717) = MTH*Z(179)
      Z(718) = MTH*Z(180)
      Z(719) = MTH*Z(185)
      Z(720) = MTH*Z(181)
      Z(721) = MTH*Z(182)
      Z(661) = MFF*Z(254)
      Z(652) = MFF*Z(245)
      Z(653) = MFF*Z(246)
      Z(654) = MFF*Z(247)
      Z(655) = MFF*Z(248)
      Z(656) = MFF*Z(249)
      Z(657) = MFF*Z(250)
      Z(658) = MFF*Z(251)
      Z(659) = MFF*Z(252)
      Z(660) = MFF*Z(253)
      Z(671) = MFF*Z(271)
      Z(662) = MFF*Z(256)
      Z(663) = MFF*Z(257)
      Z(664) = MFF*Z(258)
      Z(665) = MFF*Z(267)
      Z(666) = MFF*Z(268)
      Z(667) = MFF*Z(269)
      Z(668) = MFF*Z(270)
      Z(669) = MFF*Z(261)
      Z(670) = MFF*Z(262)
      Z(611) = MHAT*Z(279)
      Z(629) = MRF*Z(125)
      Z(691) = MRF*Z(214)
      Z(708) = MSH*Z(210)
      Z(684) = MRF*Z(198)
      Z(685) = MRF*Z(200)
      Z(686) = MRF*Z(201)
      Z(687) = MRF*Z(212)
      Z(688) = MRF*Z(213)
      Z(701) = MSH*Z(198)
      Z(702) = MSH*Z(200)
      Z(703) = MSH*Z(201)
      Z(704) = MSH*Z(208)
      Z(705) = MSH*Z(209)
      Z(689) = MRF*Z(202)
      Z(690) = MRF*Z(203)
      Z(706) = MSH*Z(202)
      Z(707) = MSH*Z(203)
      Z(607) = MHAT*HATO
      Z(40) = Z(35)*Z(29) + Z(37)*Z(27)
      Z(631) = MRF*Z(126)
      Z(62) = Z(19)*Z(58) - Z(20)*Z(56)
      Z(674) = MRF*Z(221)
      Z(615) = MHAT*Z(166)
      Z(651) = MTH*Z(165)
      Z(646) = MTH*Z(158)
      Z(647) = MTH*Z(159)
      Z(648) = MTH*Z(164)
      Z(649) = MTH*Z(160)
      Z(650) = MTH*Z(161)
      Z(613) = MHAT*Z(280)
      Z(640) = MSH*Z(149)
      Z(636) = MSH*Z(142)
      Z(637) = MSH*Z(148)
      Z(638) = MSH*Z(143)
      Z(639) = MSH*Z(144)
      Z(609) = MHAT*Z(278)
      Z(621) = MFF*Z(118)
      Z(627) = MRF*Z(119)
      Z(618) = MFF*Z(33)
      Z(619) = MFF*Z(34)
      Z(624) = MRF*Z(33)
      Z(625) = MRF*Z(34)
      Z(681) = MRF*Z(196)
      Z(698) = MSH*Z(196)
      Z(682) = MRF*Z(197)
      Z(699) = MSH*Z(197)
      Z(675) = MRF*Z(190)
      Z(676) = MRF*Z(191)
      Z(677) = MRF*Z(192)
      Z(678) = MRF*Z(193)
      Z(692) = MSH*Z(190)
      Z(693) = MSH*Z(191)
      Z(694) = MSH*Z(192)
      Z(695) = MSH*Z(193)
      Z(679) = MRF*Z(194)
      Z(680) = MRF*Z(195)
      Z(696) = MSH*Z(194)
      Z(697) = MSH*Z(195)
      PX = Z(606)*Z(1) + MHAT*U1 + Z(31)*(Z(616)*U1+Z(617)*U2+Z(622)*U1+
     &Z(623)*U2) + Z(58)*(Z(673)+Z(672)*U3+Z(672)*U4+Z(672)*U6+Z(672)*U8
     &) + Z(27)*(Z(635)+Z(632)*U3+Z(632)*U5+Z(632)*U7+Z(632)*U9+Z(633)*U
     &1+Z(634)*U2) + Z(46)*(Z(645)+Z(641)*U9+Z(642)*U3+Z(642)*U5+Z(642)*
     &U7+Z(643)*U1+Z(644)*U2) + Z(49)*(Z(714)+Z(709)*U9+Z(710)*U3+Z(710)
     &*U5+Z(711)*U7+Z(712)*U1+Z(713)*U2) + Z(51)*(Z(722)+Z(715)*U4+Z(716
     &)*U9+Z(717)*U7+Z(718)*U5+Z(719)*U3+Z(720)*U1+Z(721)*U2) + Z(64)*(Z
     &(661)+Z(652)*U8+Z(653)*U9+Z(654)*U5+Z(655)*U7+Z(656)*U3+Z(657)*U4+
     &Z(658)*U6+Z(659)*U1+Z(660)*U2) + Z(66)*(Z(671)+Z(662)*U9+Z(663)*U5
     &+Z(664)*U7+Z(665)*U3+Z(666)*U4+Z(667)*U6+Z(668)*U8+Z(669)*U1+Z(670
     &)*U2) + 0.5D0*Z(44)*(2*Z(611)-Z(629)-2*Z(610)*U3-2*Z(610)*U5-2*Z(6
     &10)*U7-2*Z(610)*U9-Z(628)*U3-Z(628)*U5-Z(628)*U7-Z(628)*U9) + Z(54
     &)*(Z(691)+Z(708)+Z(683)*U6+Z(700)*U6+Z(684)*U9+Z(685)*U5+Z(686)*U7
     &+Z(687)*U3+Z(688)*U4+Z(701)*U9+Z(702)*U5+Z(703)*U7+Z(704)*U3+Z(705
     &)*U4+Z(689)*U1+Z(690)*U2+Z(706)*U1+Z(707)*U2) - Z(607)*Z(2)*U3 - 0
     &.5D0*Z(40)*(Z(631)+Z(630)*U3+Z(630)*U5+Z(630)*U7+Z(630)*U9) - 0.5D
     &0*Z(62)*(Z(674)+Z(630)*U3+Z(630)*U4+Z(630)*U6+Z(630)*U8) - Z(48)*(
     &Z(614)*U3+Z(614)*U5-Z(615)-Z(651)-Z(646)*U9-Z(647)*U7-Z(648)*U3-Z(
     &648)*U5-Z(649)*U1-Z(650)*U2) - Z(29)*(Z(612)*U3+Z(612)*U5+Z(612)*U
     &7-Z(613)-Z(640)-Z(636)*U9-Z(637)*U3-Z(637)*U5-Z(637)*U7-Z(638)*U1-
     &Z(639)*U2) - Z(33)*(Z(609)+Z(621)+Z(627)+Z(608)*U3+Z(608)*U5+Z(608
     &)*U7+Z(608)*U9+Z(620)*U3+Z(620)*U5+Z(620)*U7+Z(620)*U9+Z(626)*U3+Z
     &(626)*U5+Z(626)*U7+Z(626)*U9-Z(618)*U1-Z(619)*U2-Z(624)*U1-Z(625)*
     &U2) - Z(52)*(Z(681)*U4+Z(698)*U4-Z(682)-Z(699)-Z(675)*U9-Z(676)*U3
     &-Z(677)*U5-Z(678)*U7-Z(692)*U9-Z(693)*U3-Z(694)*U5-Z(695)*U7-Z(679
     &)*U1-Z(680)*U2-Z(696)*U1-Z(697)*U2)
      PY = Z(606)*Z(2) + MHAT*U2 + Z(607)*Z(1)*U3 + Z(32)*(Z(616)*U1+Z(6
     &17)*U2+Z(622)*U1+Z(623)*U2) + Z(59)*(Z(673)+Z(672)*U3+Z(672)*U4+Z(
     &672)*U6+Z(672)*U8) + Z(28)*(Z(635)+Z(632)*U3+Z(632)*U5+Z(632)*U7+Z
     &(632)*U9+Z(633)*U1+Z(634)*U2) + Z(47)*(Z(645)+Z(641)*U9+Z(642)*U3+
     &Z(642)*U5+Z(642)*U7+Z(643)*U1+Z(644)*U2) + Z(50)*(Z(714)+Z(709)*U9
     &+Z(710)*U3+Z(710)*U5+Z(711)*U7+Z(712)*U1+Z(713)*U2) + Z(49)*(Z(722
     &)+Z(715)*U4+Z(716)*U9+Z(717)*U7+Z(718)*U5+Z(719)*U3+Z(720)*U1+Z(72
     &1)*U2) + Z(65)*(Z(661)+Z(652)*U8+Z(653)*U9+Z(654)*U5+Z(655)*U7+Z(6
     &56)*U3+Z(657)*U4+Z(658)*U6+Z(659)*U1+Z(660)*U2) + Z(67)*(Z(671)+Z(
     &662)*U9+Z(663)*U5+Z(664)*U7+Z(665)*U3+Z(666)*U4+Z(667)*U6+Z(668)*U
     &8+Z(669)*U1+Z(670)*U2) + 0.5D0*Z(45)*(2*Z(611)-Z(629)-2*Z(610)*U3-
     &2*Z(610)*U5-2*Z(610)*U7-2*Z(610)*U9-Z(628)*U3-Z(628)*U5-Z(628)*U7-
     &Z(628)*U9) + Z(55)*(Z(691)+Z(708)+Z(683)*U6+Z(700)*U6+Z(684)*U9+Z(
     &685)*U5+Z(686)*U7+Z(687)*U3+Z(688)*U4+Z(701)*U9+Z(702)*U5+Z(703)*U
     &7+Z(704)*U3+Z(705)*U4+Z(689)*U1+Z(690)*U2+Z(706)*U1+Z(707)*U2) - 0
     &.5D0*Z(41)*(Z(631)+Z(630)*U3+Z(630)*U5+Z(630)*U7+Z(630)*U9) - 0.5D
     &0*Z(63)*(Z(674)+Z(630)*U3+Z(630)*U4+Z(630)*U6+Z(630)*U8) - Z(46)*(
     &Z(614)*U3+Z(614)*U5-Z(615)-Z(651)-Z(646)*U9-Z(647)*U7-Z(648)*U3-Z(
     &648)*U5-Z(649)*U1-Z(650)*U2) - Z(30)*(Z(612)*U3+Z(612)*U5+Z(612)*U
     &7-Z(613)-Z(640)-Z(636)*U9-Z(637)*U3-Z(637)*U5-Z(637)*U7-Z(638)*U1-
     &Z(639)*U2) - Z(34)*(Z(609)+Z(621)+Z(627)+Z(608)*U3+Z(608)*U5+Z(608
     &)*U7+Z(608)*U9+Z(620)*U3+Z(620)*U5+Z(620)*U7+Z(620)*U9+Z(626)*U3+Z
     &(626)*U5+Z(626)*U7+Z(626)*U9-Z(618)*U1-Z(619)*U2-Z(624)*U1-Z(625)*
     &U2) - Z(53)*(Z(681)*U4+Z(698)*U4-Z(682)-Z(699)-Z(675)*U9-Z(676)*U3
     &-Z(677)*U5-Z(678)*U7-Z(692)*U9-Z(693)*U3-Z(694)*U5-Z(695)*U7-Z(679
     &)*U1-Z(680)*U2-Z(696)*U1-Z(697)*U2)
      Z(781) = Z(743) + Z(744) + Z(745) + Z(715)*Z(328) + MFF*(Z(250)*Z(
     &355)+Z(268)*Z(356)) - Z(746) - MSH*(Z(196)*Z(336)-Z(209)*Z(337)) -
     & 0.25D0*MRF*(2*Z(768)*Z(341)+2*Z(772)*Z(342)+2*Z(213)*Z(399)*Z(342
     &)+4*Z(11)*Z(213)*Z(341)+2*Z(770)*Z(344)+4*Z(196)*Z(339)+2*LRFFO*Z(
     &399)*Z(340)+2*LRFFO*Z(401)*Z(339)+2*Z(196)*Z(399)*Z(345)+4*Z(69)*Z
     &(11)*Z(340)+4*Z(69)*Z(12)*Z(339)+4*Z(11)*Z(196)*Z(344)+4*Z(12)*Z(2
     &13)*Z(344)-4*Z(69)*Z(341)-LRFFO*Z(342)-4*Z(12)*Z(196)*Z(341)-2*Z(1
     &96)*Z(401)*Z(342)-4*Z(213)*Z(340)-2*Z(773)*Z(345)-2*Z(213)*Z(400)*
     &Z(345))
      Z(821) = Z(380)*(Z(196)*Z(53)-Z(209)*Z(55)) + 0.5D0*Z(379)*(LRFFO*
     &Z(63)+2*Z(196)*Z(53)-2*Z(69)*Z(59)-2*Z(213)*Z(55)) + Z(781) - Z(72
     &7)*Z(49) - Z(227)*RRX2*Z(56) - Z(227)*RRY2*Z(57) - Z(242)*RRX2*Z(5
     &8) - Z(242)*RRY2*Z(59) - Z(250)*RRX1*Z(64) - Z(250)*RRY1*Z(65) - Z
     &(274)*RRX1*Z(66) - Z(274)*RRY1*Z(67) - Z(378)*(Z(250)*Z(65)+Z(268)
     &*Z(67))
      Z(778) = Z(775) + Z(715)*Z(185) + MFF*(Z(249)*Z(250)+Z(267)*Z(268)
     &) - MSH*(Z(191)*Z(196)-Z(208)*Z(209)) - 0.25D0*MRF*(4*Z(759)+4*Z(1
     &91)*Z(196)+2*LRFFO*Z(191)*Z(401)+2*LRFFO*Z(212)*Z(399)+2*LRFFO*Z(2
     &13)*Z(399)+4*Z(69)*Z(11)*Z(212)+4*Z(69)*Z(11)*Z(213)+4*Z(69)*Z(12)
     &*Z(191)-4*Z(777)-Z(776)-4*Z(212)*Z(213)-4*Z(69)*Z(12)*Z(196)-2*LRF
     &FO*Z(196)*Z(401))
      Z(779) = Z(715)*Z(181) + MFF*(Z(250)*Z(252)+Z(268)*Z(261)) + 0.5D0
     &*MRF*(2*Z(213)*Z(202)-2*Z(196)*Z(194)-2*Z(69)*Z(11)*Z(202)-2*Z(69)
     &*Z(12)*Z(194)-LRFFO*Z(399)*Z(202)-LRFFO*Z(401)*Z(194)) - MSH*(Z(19
     &6)*Z(194)-Z(209)*Z(202))
      Z(780) = Z(715)*Z(182) + MFF*(Z(250)*Z(253)+Z(268)*Z(262)) + 0.5D0
     &*MRF*(2*Z(213)*Z(203)-2*Z(196)*Z(195)-2*Z(69)*Z(11)*Z(203)-2*Z(69)
     &*Z(12)*Z(195)-LRFFO*Z(399)*Z(203)-LRFFO*Z(401)*Z(195)) - MSH*(Z(19
     &6)*Z(195)-Z(209)*Z(203))
      RHTQ = Z(821) + Z(778)*U3p + Z(779)*U1p + Z(780)*U2p
      Z(786) = Z(736) + Z(738) + Z(740) + Z(620)*Z(292) + MFF*(Z(247)*Z(
     &355)+Z(257)*Z(356)) + MSH*(Z(138)*Z(311)+Z(148)*Z(312)) + MSH*(Z(1
     &92)*Z(336)+Z(200)*Z(337)) + MTH*(Z(154)*Z(319)+Z(164)*Z(320)) + MT
     &H*(Z(173)*Z(327)+Z(180)*Z(328)) + 0.25D0*MRF*(LRFFO*Z(298)+LRFO*Z(
     &297)+Z(768)*Z(297)+Z(769)*Z(298)+4*LFF*Z(295)+2*LFF*Z(396)*Z(298)+
     &2*LRFFO*Z(396)*Z(295)+Z(770)*Z(300)+2*LFF*Z(18)*Z(300)-2*LFF*Z(17)
     &*Z(297)-2*LRFO*Z(17)*Z(295)-Z(771)*Z(301)-2*LFF*Z(398)*Z(301)-2*LR
     &FFO*Z(397)*Z(296)-2*LRFO*Z(18)*Z(296)) - Z(742) - 0.5D0*MRF*(Z(192
     &)*Z(401)*Z(342)+Z(200)*Z(399)*Z(342)+2*Z(11)*Z(200)*Z(341)+2*Z(12)
     &*Z(192)*Z(341)+2*Z(12)*Z(200)*Z(344)-2*Z(192)*Z(339)-2*Z(200)*Z(34
     &0)-2*Z(11)*Z(192)*Z(344)-Z(192)*Z(399)*Z(345)-Z(200)*Z(400)*Z(345)
     &) - MHAT*(LRF*Z(369)+LSH*Z(370)+LTH*Z(321)+LFF*Z(21)*Z(370)+LFF*Z(
     &392)*Z(321)+LRF*Z(17)*Z(366)+LRF*Z(393)*Z(321)+LTH*Z(393)*Z(369)+L
     &FF*Z(18)*Z(374)+LFF*Z(114)*Z(371)+LFF*Z(116)*Z(372)+LRF*Z(14)*Z(37
     &5)+LRF*Z(18)*Z(373)+LRF*Z(102)*Z(371)+LRF*Z(104)*Z(372)+LSH*Z(22)*
     &Z(373)+LSH*Z(24)*Z(372)+LSH*Z(26)*Z(371)+LTH*Z(5)*Z(372)+LTH*Z(6)*
     &Z(371)+LTH*Z(10)*Z(375)+LTH*Z(390)*Z(373)-LFF*Z(366)-LFF*Z(17)*Z(3
     &69)-LRF*Z(13)*Z(370)-LSH*Z(9)*Z(321)-LSH*Z(13)*Z(369)-LSH*Z(21)*Z(
     &366)-LTH*Z(9)*Z(370)-LTH*Z(392)*Z(366)-LFF*Z(23)*Z(375)-LFF*Z(391)
     &*Z(376)-LRF*Z(395)*Z(376)-LSH*Z(10)*Z(376)-LSH*Z(14)*Z(374)-LTH*Z(
     &394)*Z(374))
      Z(822) = Z(725)*Z(34) + LFF*(LRX2*Z(33)+LRY2*Z(34)) + 0.5D0*Z(379)
     &*(LRFFO*Z(41)+LRFO*Z(45)+2*LFF*Z(34)) + Z(377)*(LFF*Z(34)+LRF*Z(45
     &)+LSH*Z(30)+LTH*Z(46)) + Z(786) - Z(224)*RRX2*Z(56) - Z(224)*RRY2*
     &Z(57) - Z(234)*RRX2*Z(58) - Z(234)*RRY2*Z(59) - Z(247)*RRX1*Z(64) 
     &- Z(247)*RRY1*Z(65) - Z(257)*RRX1*Z(66) - Z(257)*RRY1*Z(67) - Z(37
     &8)*(Z(247)*Z(65)+Z(257)*Z(67)) - Z(379)*(Z(192)*Z(53)+Z(200)*Z(55)
     &) - Z(380)*(Z(138)*Z(28)+Z(148)*Z(30)) - Z(380)*(Z(192)*Z(53)+Z(20
     &0)*Z(55)) - Z(381)*(Z(154)*Z(47)+Z(164)*Z(46)) - Z(381)*(Z(173)*Z(
     &50)+Z(180)*Z(49))
      Z(783) = Z(782) + MFF*(Z(247)*Z(249)+Z(257)*Z(267)) + MSH*(Z(138)*
     &*2+Z(148)**2) + MSH*(Z(191)*Z(192)+Z(200)*Z(208)) + MTH*(Z(154)**2
     &+Z(164)**2) + MTH*(Z(173)**2+Z(180)*Z(185)) + 0.25D0*MRF*(Z(755)+4
     &*Z(756)*Z(396)-4*Z(757)*Z(17)) + 0.5D0*MRF*(2*Z(191)*Z(192)+2*Z(20
     &0)*Z(212)-2*Z(69)*Z(11)*Z(200)-2*Z(69)*Z(12)*Z(192)-LRFFO*Z(192)*Z
     &(401)-LRFFO*Z(200)*Z(399)) + MHAT*(Z(760)+2*Z(761)*Z(21)+2*Z(762)*
     &Z(392)+2*Z(763)*Z(393)-2*Z(764)*Z(17)-2*Z(765)*Z(13)-2*Z(766)*Z(9)
     &-LSH*HATO*Z(24)-LTH*HATO*Z(5)-LFF*HATO*Z(116)-LRF*HATO*Z(104))
      Z(784) = MFF*(Z(247)*Z(252)+Z(257)*Z(261)) + MRF*(Z(192)*Z(194)+Z(
     &200)*Z(202)) + MSH*(Z(138)*Z(139)+Z(148)*Z(143)) + MSH*(Z(192)*Z(1
     &94)+Z(200)*Z(202)) + MTH*(Z(154)*Z(155)+Z(164)*Z(160)) + MTH*(Z(17
     &3)*Z(175)+Z(180)*Z(181)) + 0.5D0*MRF*(LRFO*Z(17)*Z(33)-2*LFF*Z(33)
     &-LRFFO*Z(396)*Z(33)-LRFFO*Z(397)*Z(31)-LRFO*Z(18)*Z(31)) - Z(620)*
     &Z(33) - MHAT*(LFF*Z(33)+LRF*Z(44)+LSH*Z(29)+LTH*Z(48))
      Z(785) = MFF*(Z(247)*Z(253)+Z(257)*Z(262)) + MRF*(Z(192)*Z(195)+Z(
     &200)*Z(203)) + MSH*(Z(138)*Z(140)+Z(148)*Z(144)) + MSH*(Z(192)*Z(1
     &95)+Z(200)*Z(203)) + MTH*(Z(154)*Z(156)+Z(164)*Z(161)) + MTH*(Z(17
     &3)*Z(176)+Z(180)*Z(182)) + 0.5D0*MRF*(LRFO*Z(17)*Z(34)-2*LFF*Z(34)
     &-LRFFO*Z(396)*Z(34)-LRFFO*Z(397)*Z(32)-LRFO*Z(18)*Z(32)) - Z(620)*
     &Z(34) - MHAT*(LFF*Z(34)+LRF*Z(45)+LSH*Z(30)+LTH*Z(46))
      LHTQ = Z(822) + Z(783)*U3p + Z(784)*U1p + Z(785)*U2p
      Z(793) = Z(743) + Z(744) + Z(745) + Z(700)*Z(337) + MFF*(Z(251)*Z(
     &355)+Z(269)*Z(356)) + 0.25D0*MRF*(LRFFO*Z(342)+4*Z(69)*Z(341)+2*Z(
     &773)*Z(345)+4*LSH*Z(340)+2*LSH*Z(400)*Z(345)-2*Z(768)*Z(341)-2*Z(7
     &72)*Z(342)-4*LSH*Z(11)*Z(341)-2*LSH*Z(399)*Z(342)-2*Z(770)*Z(344)-
     &4*LSH*Z(12)*Z(344)-4*Z(69)*Z(11)*Z(340)-4*Z(69)*Z(12)*Z(339)-2*LRF
     &FO*Z(399)*Z(340)-2*LRFFO*Z(401)*Z(339))
      Z(823) = 0.5D0*Z(379)*(LRFFO*Z(63)-2*LSH*Z(55)-2*Z(69)*Z(59)) + Z(
     &793) - Z(730)*Z(55) - Z(222)*RRX2*Z(56) - Z(222)*RRY2*Z(57) - Z(24
     &3)*RRX2*Z(58) - Z(243)*RRY2*Z(59) - Z(251)*RRX1*Z(64) - Z(251)*RRY
     &1*Z(65) - Z(275)*RRX1*Z(66) - Z(275)*RRY1*Z(67) - Z(378)*(Z(251)*Z
     &(65)+Z(269)*Z(67))
      Z(790) = Z(787) + Z(700)*Z(208) + MFF*(Z(249)*Z(251)+Z(267)*Z(269)
     &) + 0.25D0*MRF*(Z(758)+4*LSH*Z(212)-4*Z(759)-4*Z(788)*Z(11)-2*Z(78
     &9)*Z(399)-4*Z(69)*Z(11)*Z(212)-4*Z(69)*Z(12)*Z(191)-2*LRFFO*Z(191)
     &*Z(401)-2*LRFFO*Z(212)*Z(399))
      Z(791) = Z(700)*Z(202) + MFF*(Z(251)*Z(252)+Z(269)*Z(261)) + 0.5D0
     &*MRF*(2*LSH*Z(202)-2*Z(69)*Z(11)*Z(202)-2*Z(69)*Z(12)*Z(194)-LRFFO
     &*Z(399)*Z(202)-LRFFO*Z(401)*Z(194))
      Z(792) = Z(700)*Z(203) + MFF*(Z(251)*Z(253)+Z(269)*Z(262)) + 0.5D0
     &*MRF*(2*LSH*Z(203)-2*Z(69)*Z(11)*Z(203)-2*Z(69)*Z(12)*Z(195)-LRFFO
     &*Z(399)*Z(203)-LRFFO*Z(401)*Z(195))
      RKTQ = Z(823) + Z(790)*U3p + Z(791)*U1p + Z(792)*U2p
      Z(799) = Z(736) + Z(738) + Z(740) + Z(620)*Z(292) + MFF*(Z(248)*Z(
     &355)+Z(258)*Z(356)) + MSH*(Z(138)*Z(311)+Z(148)*Z(312)) + MSH*(Z(1
     &93)*Z(336)+Z(201)*Z(337)) + MTH*(Z(154)*Z(319)+Z(159)*Z(320)) + MT
     &H*(Z(174)*Z(327)+Z(179)*Z(328)) + 0.25D0*MRF*(LRFFO*Z(298)+LRFO*Z(
     &297)+Z(768)*Z(297)+Z(769)*Z(298)+4*LFF*Z(295)+2*LFF*Z(396)*Z(298)+
     &2*LRFFO*Z(396)*Z(295)+Z(770)*Z(300)+2*LFF*Z(18)*Z(300)-2*LFF*Z(17)
     &*Z(297)-2*LRFO*Z(17)*Z(295)-Z(771)*Z(301)-2*LFF*Z(398)*Z(301)-2*LR
     &FFO*Z(397)*Z(296)-2*LRFO*Z(18)*Z(296)) + MHAT*(LFF*Z(366)+LFF*Z(17
     &)*Z(369)+LRF*Z(13)*Z(370)+LSH*Z(9)*Z(321)+LSH*Z(13)*Z(369)+LSH*Z(2
     &1)*Z(366)+LFF*Z(23)*Z(375)+LFF*Z(391)*Z(376)+LRF*Z(395)*Z(376)+LSH
     &*Z(10)*Z(376)+LSH*Z(14)*Z(374)-LRF*Z(369)-LSH*Z(370)-LFF*Z(21)*Z(3
     &70)-LFF*Z(392)*Z(321)-LRF*Z(17)*Z(366)-LRF*Z(393)*Z(321)-LFF*Z(18)
     &*Z(374)-LFF*Z(114)*Z(371)-LFF*Z(116)*Z(372)-LRF*Z(14)*Z(375)-LRF*Z
     &(18)*Z(373)-LRF*Z(102)*Z(371)-LRF*Z(104)*Z(372)-LSH*Z(22)*Z(373)-L
     &SH*Z(24)*Z(372)-LSH*Z(26)*Z(371)) - 0.5D0*MRF*(Z(193)*Z(401)*Z(342
     &)+Z(201)*Z(399)*Z(342)+2*Z(11)*Z(201)*Z(341)+2*Z(12)*Z(193)*Z(341)
     &+2*Z(12)*Z(201)*Z(344)-2*Z(193)*Z(339)-2*Z(201)*Z(340)-2*Z(11)*Z(1
     &93)*Z(344)-Z(193)*Z(399)*Z(345)-Z(201)*Z(400)*Z(345))
      Z(824) = Z(725)*Z(34) + LFF*(LRX2*Z(33)+LRY2*Z(34)) + Z(377)*(LFF*
     &Z(34)+LRF*Z(45)+LSH*Z(30)) + 0.5D0*Z(379)*(LRFFO*Z(41)+LRFO*Z(45)+
     &2*LFF*Z(34)) + Z(799) - Z(225)*RRX2*Z(56) - Z(225)*RRY2*Z(57) - Z(
     &235)*RRX2*Z(58) - Z(235)*RRY2*Z(59) - Z(248)*RRX1*Z(64) - Z(248)*R
     &RY1*Z(65) - Z(258)*RRX1*Z(66) - Z(258)*RRY1*Z(67) - Z(378)*(Z(248)
     &*Z(65)+Z(258)*Z(67)) - Z(379)*(Z(193)*Z(53)+Z(201)*Z(55)) - Z(380)
     &*(Z(138)*Z(28)+Z(148)*Z(30)) - Z(380)*(Z(193)*Z(53)+Z(201)*Z(55)) 
     &- Z(381)*(Z(154)*Z(47)+Z(159)*Z(46)) - Z(381)*(Z(174)*Z(50)+Z(179)
     &*Z(49))
      Z(796) = Z(794) + MFF*(Z(248)*Z(249)+Z(258)*Z(267)) + MSH*(Z(138)*
     &*2+Z(148)**2) + MSH*(Z(191)*Z(193)+Z(201)*Z(208)) + MTH*(Z(154)**2
     &+Z(159)*Z(164)) + MTH*(Z(173)*Z(174)+Z(179)*Z(185)) + 0.25D0*MRF*(
     &Z(755)+4*Z(756)*Z(396)-4*Z(757)*Z(17)) + 0.5D0*MRF*(2*Z(191)*Z(193
     &)+2*Z(201)*Z(212)-2*Z(69)*Z(11)*Z(201)-2*Z(69)*Z(12)*Z(193)-LRFFO*
     &Z(193)*Z(401)-LRFFO*Z(201)*Z(399)) + MHAT*(Z(795)+Z(762)*Z(392)+Z(
     &763)*Z(393)+2*Z(761)*Z(21)-2*Z(764)*Z(17)-2*Z(765)*Z(13)-Z(766)*Z(
     &9)-LSH*HATO*Z(24)-LFF*HATO*Z(116)-LRF*HATO*Z(104))
      Z(797) = MFF*(Z(248)*Z(252)+Z(258)*Z(261)) + MRF*(Z(193)*Z(194)+Z(
     &201)*Z(202)) + MSH*(Z(138)*Z(139)+Z(148)*Z(143)) + MSH*(Z(193)*Z(1
     &94)+Z(201)*Z(202)) + MTH*(Z(154)*Z(155)+Z(159)*Z(160)) + MTH*(Z(17
     &4)*Z(175)+Z(179)*Z(181)) + 0.5D0*MRF*(LRFO*Z(17)*Z(33)-2*LFF*Z(33)
     &-LRFFO*Z(396)*Z(33)-LRFFO*Z(397)*Z(31)-LRFO*Z(18)*Z(31)) - Z(620)*
     &Z(33) - MHAT*(LFF*Z(33)+LRF*Z(44)+LSH*Z(29))
      Z(798) = MFF*(Z(248)*Z(253)+Z(258)*Z(262)) + MRF*(Z(193)*Z(195)+Z(
     &201)*Z(203)) + MSH*(Z(138)*Z(140)+Z(148)*Z(144)) + MSH*(Z(193)*Z(1
     &95)+Z(201)*Z(203)) + MTH*(Z(154)*Z(156)+Z(159)*Z(161)) + MTH*(Z(17
     &4)*Z(176)+Z(179)*Z(182)) + 0.5D0*MRF*(LRFO*Z(17)*Z(34)-2*LFF*Z(34)
     &-LRFFO*Z(396)*Z(34)-LRFFO*Z(397)*Z(32)-LRFO*Z(18)*Z(32)) - Z(620)*
     &Z(34) - MHAT*(LFF*Z(34)+LRF*Z(45)+LSH*Z(30))
      LKTQ = Z(824) + Z(796)*U3p + Z(797)*U1p + Z(798)*U2p
      Z(805) = Z(743) + Z(744) + MFF*(Z(245)*Z(355)+Z(270)*Z(356)) + 0.2
     &5D0*MRF*(LRFFO*Z(342)+4*Z(69)*Z(341)+2*Z(773)*Z(345)-2*Z(768)*Z(34
     &1)-2*Z(772)*Z(342)-2*Z(770)*Z(344)-4*Z(69)*Z(11)*Z(340)-4*Z(69)*Z(
     &12)*Z(339)-2*LRFFO*Z(399)*Z(340)-2*LRFFO*Z(401)*Z(339))
      Z(825) = 0.5D0*Z(379)*(LRFFO*Z(63)-2*Z(69)*Z(59)) + Z(805) - Z(245
     &)*RRX1*Z(64) - Z(245)*RRY1*Z(65) - Z(276)*RRX1*Z(66) - Z(276)*RRY1
     &*Z(67) - LRF*(RRX2*Z(58)+RRY2*Z(59)) - Z(378)*(Z(245)*Z(65)+Z(270)
     &*Z(67))
      Z(802) = Z(800) + MFF*(Z(245)*Z(249)+Z(267)*Z(270)) + 0.25D0*MRF*(
     &Z(801)-4*Z(69)*Z(11)*Z(212)-4*Z(69)*Z(12)*Z(191)-2*LRFFO*Z(191)*Z(
     &401)-2*LRFFO*Z(212)*Z(399))
      Z(803) = MFF*(Z(245)*Z(252)+Z(270)*Z(261)) - 0.5D0*MRF*(LRFFO*Z(39
     &9)*Z(202)+LRFFO*Z(401)*Z(194)+2*Z(69)*Z(11)*Z(202)+2*Z(69)*Z(12)*Z
     &(194))
      Z(804) = MFF*(Z(245)*Z(253)+Z(270)*Z(262)) - 0.5D0*MRF*(LRFFO*Z(39
     &9)*Z(203)+LRFFO*Z(401)*Z(195)+2*Z(69)*Z(11)*Z(203)+2*Z(69)*Z(12)*Z
     &(195))
      RATQ = Z(825) + Z(802)*U3p + Z(803)*U1p + Z(804)*U2p
      Z(811) = Z(736) + Z(738) + Z(620)*Z(292) + MFF*(Z(246)*Z(355)+Z(25
     &6)*Z(356)) + MSH*(Z(138)*Z(311)+Z(142)*Z(312)) + MSH*(Z(190)*Z(336
     &)+Z(198)*Z(337)) + MTH*(Z(153)*Z(319)+Z(158)*Z(320)) + MTH*(Z(172)
     &*Z(327)+Z(178)*Z(328)) + 0.25D0*MRF*(LRFFO*Z(298)+LRFO*Z(297)+Z(76
     &8)*Z(297)+Z(769)*Z(298)+4*LFF*Z(295)+2*LFF*Z(396)*Z(298)+2*LRFFO*Z
     &(396)*Z(295)+Z(770)*Z(300)+2*LFF*Z(18)*Z(300)-2*LFF*Z(17)*Z(297)-2
     &*LRFO*Z(17)*Z(295)-Z(771)*Z(301)-2*LFF*Z(398)*Z(301)-2*LRFFO*Z(397
     &)*Z(296)-2*LRFO*Z(18)*Z(296)) + MHAT*(LFF*Z(366)+LFF*Z(17)*Z(369)+
     &LRF*Z(13)*Z(370)+LFF*Z(23)*Z(375)+LFF*Z(391)*Z(376)+LRF*Z(395)*Z(3
     &76)-LRF*Z(369)-LFF*Z(21)*Z(370)-LFF*Z(392)*Z(321)-LRF*Z(17)*Z(366)
     &-LRF*Z(393)*Z(321)-LFF*Z(18)*Z(374)-LFF*Z(114)*Z(371)-LFF*Z(116)*Z
     &(372)-LRF*Z(14)*Z(375)-LRF*Z(18)*Z(373)-LRF*Z(102)*Z(371)-LRF*Z(10
     &4)*Z(372)) - 0.5D0*MRF*(Z(190)*Z(401)*Z(342)+Z(198)*Z(399)*Z(342)+
     &2*Z(11)*Z(198)*Z(341)+2*Z(12)*Z(190)*Z(341)+2*Z(12)*Z(198)*Z(344)-
     &2*Z(190)*Z(339)-2*Z(198)*Z(340)-2*Z(11)*Z(190)*Z(344)-Z(190)*Z(399
     &)*Z(345)-Z(198)*Z(400)*Z(345))
      Z(826) = Z(725)*Z(34) + LFF*(LRX2*Z(33)+LRY2*Z(34)) + Z(377)*(LFF*
     &Z(34)+LRF*Z(45)) + 0.5D0*Z(379)*(LRFFO*Z(41)+LRFO*Z(45)+2*LFF*Z(34
     &)) + Z(811) - Z(223)*RRX2*Z(56) - Z(223)*RRY2*Z(57) - Z(232)*RRX2*
     &Z(58) - Z(232)*RRY2*Z(59) - Z(246)*RRX1*Z(64) - Z(246)*RRY1*Z(65) 
     &- Z(256)*RRX1*Z(66) - Z(256)*RRY1*Z(67) - Z(378)*(Z(246)*Z(65)+Z(2
     &56)*Z(67)) - Z(379)*(Z(190)*Z(53)+Z(198)*Z(55)) - Z(380)*(Z(138)*Z
     &(28)+Z(142)*Z(30)) - Z(380)*(Z(190)*Z(53)+Z(198)*Z(55)) - Z(381)*(
     &Z(153)*Z(47)+Z(158)*Z(46)) - Z(381)*(Z(172)*Z(50)+Z(178)*Z(49))
      Z(808) = Z(806) + MFF*(Z(246)*Z(249)+Z(256)*Z(267)) + MSH*(Z(138)*
     &*2+Z(142)*Z(148)) + MSH*(Z(190)*Z(191)+Z(198)*Z(208)) + MTH*(Z(153
     &)*Z(154)+Z(158)*Z(164)) + MTH*(Z(172)*Z(173)+Z(178)*Z(185)) + 0.25
     &D0*MRF*(Z(755)+4*Z(756)*Z(396)-4*Z(757)*Z(17)) + 0.5D0*MRF*(2*Z(19
     &0)*Z(191)+2*Z(198)*Z(212)-2*Z(69)*Z(11)*Z(198)-2*Z(69)*Z(12)*Z(190
     &)-LRFFO*Z(190)*Z(401)-LRFFO*Z(198)*Z(399)) + MHAT*(Z(807)+Z(761)*Z
     &(21)+Z(762)*Z(392)+Z(763)*Z(393)-2*Z(764)*Z(17)-Z(765)*Z(13)-LFF*H
     &ATO*Z(116)-LRF*HATO*Z(104))
      Z(809) = MFF*(Z(246)*Z(252)+Z(256)*Z(261)) + MRF*(Z(190)*Z(194)+Z(
     &198)*Z(202)) + MSH*(Z(138)*Z(139)+Z(142)*Z(143)) + MSH*(Z(190)*Z(1
     &94)+Z(198)*Z(202)) + MTH*(Z(153)*Z(155)+Z(158)*Z(160)) + MTH*(Z(17
     &2)*Z(175)+Z(178)*Z(181)) + 0.5D0*MRF*(LRFO*Z(17)*Z(33)-2*LFF*Z(33)
     &-LRFFO*Z(396)*Z(33)-LRFFO*Z(397)*Z(31)-LRFO*Z(18)*Z(31)) - Z(620)*
     &Z(33) - MHAT*(LFF*Z(33)+LRF*Z(44))
      Z(810) = MFF*(Z(246)*Z(253)+Z(256)*Z(262)) + MRF*(Z(190)*Z(195)+Z(
     &198)*Z(203)) + MSH*(Z(138)*Z(140)+Z(142)*Z(144)) + MSH*(Z(190)*Z(1
     &95)+Z(198)*Z(203)) + MTH*(Z(153)*Z(156)+Z(158)*Z(161)) + MTH*(Z(17
     &2)*Z(176)+Z(178)*Z(182)) + 0.5D0*MRF*(LRFO*Z(17)*Z(34)-2*LFF*Z(34)
     &-LRFFO*Z(396)*Z(34)-LRFFO*Z(397)*Z(32)-LRFO*Z(18)*Z(32)) - Z(620)*
     &Z(34) - MHAT*(LFF*Z(34)+LRF*Z(45))
      LATQ = Z(826) + Z(808)*U3p + Z(809)*U1p + Z(810)*U2p
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
      POCMX = Q1 + Z(79)*Z(64) + Z(80)*Z(56) + Z(81)*Z(52) + Z(82)*Z(49)
     & + Z(73)*Z(1) - Z(74)*Z(31) - Z(77)*Z(27) - Z(78)*Z(46) - 0.5D0*Z(
     &75)*Z(42) - 0.5D0*Z(76)*Z(38) - 0.5D0*Z(76)*Z(60)
      Z(281) = MHAT*HATOp/Z(72)
      Z(282) = Z(74)*(LKp-LAp-LHp-LMTPp)
      Z(283) = Z(75)*(LAp+LHp-LKp)
      Z(284) = Z(76)*(LAp+LHp-LKp)
      Z(285) = Z(77)*(LHp-LKp)
      Z(286) = Z(78)*LHp
      Z(287) = Z(79)*(RKp-RAp-RHp-RMTPp)
      Z(288) = Z(80)*(RAp+RHp-RKp)
      Z(289) = Z(76)*(RAp+RHp-RKp)
      Z(290) = Z(81)*(RHp-RKp)
      Z(291) = Z(82)*RHp
      VOCMX = Z(281)*Z(1) + U1 + Z(48)*(Z(286)-Z(78)*U3-Z(78)*U5) + Z(66
     &)*(Z(287)+Z(79)*U3+Z(79)*U4+Z(79)*U6+Z(79)*U8) + Z(29)*(Z(285)-Z(7
     &7)*U3-Z(77)*U5-Z(77)*U7) + 0.5D0*Z(40)*(Z(284)-Z(76)*U3-Z(76)*U5-Z
     &(76)*U7-Z(76)*U9) + 0.5D0*Z(44)*(Z(283)-Z(75)*U3-Z(75)*U5-Z(75)*U7
     &-Z(75)*U9) + 0.5D0*Z(62)*(Z(289)-Z(76)*U3-Z(76)*U4-Z(76)*U6-Z(76)*
     &U8) - Z(73)*Z(2)*U3 - Z(51)*(Z(291)-Z(82)*U3-Z(82)*U4) - Z(33)*(Z(
     &282)+Z(74)*U3+Z(74)*U5+Z(74)*U7+Z(74)*U9) - Z(54)*(Z(290)-Z(81)*U3
     &-Z(81)*U4-Z(81)*U6) - Z(58)*(Z(288)-Z(80)*U3-Z(80)*U4-Z(80)*U6-Z(8
     &0)*U8)
      VOCMY = Z(281)*Z(2) + U2 + Z(73)*Z(1)*U3 + Z(46)*(Z(286)-Z(78)*U3-
     &Z(78)*U5) + Z(67)*(Z(287)+Z(79)*U3+Z(79)*U4+Z(79)*U6+Z(79)*U8) + Z
     &(30)*(Z(285)-Z(77)*U3-Z(77)*U5-Z(77)*U7) + 0.5D0*Z(41)*(Z(284)-Z(7
     &6)*U3-Z(76)*U5-Z(76)*U7-Z(76)*U9) + 0.5D0*Z(45)*(Z(283)-Z(75)*U3-Z
     &(75)*U5-Z(75)*U7-Z(75)*U9) + 0.5D0*Z(63)*(Z(289)-Z(76)*U3-Z(76)*U4
     &-Z(76)*U6-Z(76)*U8) - Z(49)*(Z(291)-Z(82)*U3-Z(82)*U4) - Z(34)*(Z(
     &282)+Z(74)*U3+Z(74)*U5+Z(74)*U7+Z(74)*U9) - Z(55)*(Z(290)-Z(81)*U3
     &-Z(81)*U4-Z(81)*U6) - Z(59)*(Z(288)-Z(80)*U3-Z(80)*U4-Z(80)*U6-Z(8
     &0)*U8)
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


