C**   The name of this program is model/13seg_swing_vf/model.f
C**   Created by AUTOLEV 3.2 on Mon Aug 29 17:05:26 2022

      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          ILOOP, IPRINT, PRINTINT
      CHARACTER        MESSAGE(99)
      EXTERNAL         EQNS1
      DIMENSION        VAR(14)
      COMMON/CONSTNTS/ AE,AF,FOOTANG,G,HE,HF,IFF,IHAT,ILA,IRF,ISH,ITH,IU
     &A,K1,K2,K3,K4,K5,K6,K7,K8,KE,KF,LFF,LFFO,LHAT,LHATO,LLA,LLAO,LRF,L
     &RFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,LUA,LUAO,MFF,MHAT,MLA,MRF,MSH,MTH
     &,MTPB,MTPK,MTPXI,MUA,TOEXI
      COMMON/SPECFIED/ LE,LS,RA,RE,RH,RK,RMTP,RS,LEp,LSp,RAp,REp,RHp,RKp
     &,RMTPp,RSp,LEpp,LSpp,RApp,REpp,RHpp,RKpp,RMTPpp,RSpp
      COMMON/VARIBLES/ Q1,Q2,Q3,Q4,Q5,Q6,Q7,U1,U2,U3,U4,U5,U6,U7
      COMMON/ALGBRAIC/ HZ,KECM,LA,LETQ,LH,LK,LMTP,LSTQ,PX,PY,RATQ,RETQ,R
     &HTQ,RKTQ,RSTQ,RX1,RX2,RY1,RY2,U10,U11,U12,U13,U14,U8,U9,VRX1,VRX2,
     &VRY1,VRY2,LAp,LHp,LKp,LMTPp,Q1p,Q2p,Q3p,Q4p,Q5p,Q6p,Q7p,U1p,U2p,U3
     &p,U4p,U5p,U6p,U7p,LApp,LHpp,LKpp,LMTPpp,LATQ,LHTQ,LKTQ,LMTQ,DLX1,D
     &LX2,POCMX,POCMY,POP10X,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP13X,P
     &OP13Y,POP14X,POP14Y,POP15X,POP15Y,POP16X,POP16Y,POP1X,POP1Y,POP2X,
     &POP2Y,POP3X,POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,
     &POP8X,POP8Y,POP9X,POP9Y,RMTQ,RX,RY,VOCMX,VOCMY,VOP2X,VOP2Y,VRX,VRY
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(1312),COEF(7,7),RHS(7)

C**   Open input and output files
      OPEN(UNIT=20, FILE='model/13seg_swing_vf/model.in', STATUS='OLD')
      OPEN(UNIT=21, FILE='model/13seg_swing_vf/model.1',  STATUS='UNKNOW
     &N')
      OPEN(UNIT=22, FILE='model/13seg_swing_vf/model.2',  STATUS='UNKNOW
     &N')
      OPEN(UNIT=23, FILE='model/13seg_swing_vf/model.3',  STATUS='UNKNOW
     &N')
      OPEN(UNIT=24, FILE='model/13seg_swing_vf/model.4',  STATUS='UNKNOW
     &N')
      OPEN(UNIT=25, FILE='model/13seg_swing_vf/model.5',  STATUS='UNKNOW
     &N')
      OPEN(UNIT=26, FILE='model/13seg_swing_vf/model.6',  STATUS='UNKNOW
     &N')

C**   Read message from input file
      READ(20,7000,END=7100,ERR=7101) (MESSAGE(ILOOP),ILOOP = 1,99)

C**   Read values of constants from input file
      READ(20,7010,END=7100,ERR=7101) AE,AF,FOOTANG,G,HE,HF,IFF,IHAT,ILA
     &,IRF,ISH,ITH,IUA,K1,K2,K3,K4,K5,K6,K7,K8,KE,KF,LFF,LFFO,LHAT,LHATO
     &,LLA,LLAO,LRF,LRFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,LUA,LUAO,MFF,MHAT,
     &MLA,MRF,MSH,MTH,MTPB,MTPK,MTPXI,MUA,TOEXI

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

C**   Evaluate constants
      U8 = 0
      U9 = 0
      U10 = 0
      U11 = 0
      U12 = 0
      U13 = 0
      U14 = 0
      Z(518) = G*MSH
      Z(517) = G*MRF
      Z(27) = COS(FOOTANG)
      Z(516) = G*MLA
      Z(1157) = LLAO*Z(516)
      Z(28) = SIN(FOOTANG)
      Z(90) = LFF - LFFO
      Z(91) = LRF - 0.5D0*LRFO
      Z(92) = LSH - LSHO
      Z(93) = LTH - LTHO
      Z(94) = MHAT + 2*MFF + 2*MLA + 2*MRF + 2*MSH + 2*MTH + 2*MUA
      Z(95) = (LHATO*MHAT+2*LHAT*MLA+2*LHAT*MUA)/Z(94)
      Z(96) = (LFF*MFF+LFF*MHAT+LFFO*MFF+2*LFF*MLA+2*LFF*MRF+2*LFF*MSH+2
     &*LFF*MTH+2*LFF*MUA)/Z(94)
      Z(97) = LLAO*MLA/Z(94)
      Z(98) = (LRFO*MRF+2*LRF*MFF+2*LRF*MHAT+2*LRF*MRF+4*LRF*MLA+4*LRF*M
     &SH+4*LRF*MTH+4*LRF*MUA)/Z(94)
      Z(99) = LRFFO*MRF/Z(94)
      Z(100) = (LSH*MFF+LSH*MHAT+LSH*MRF+LSH*MSH+LSHO*MSH+2*LSH*MLA+2*LS
     &H*MTH+2*LSH*MUA)/Z(94)
      Z(101) = (LTH*MFF+LTH*MHAT+LTH*MRF+LTH*MSH+LTH*MTH+LTHO*MTH+2*LTH*
     &MLA+2*LTH*MUA)/Z(94)
      Z(102) = (LUA*MLA+LUAO*MUA)/Z(94)
      Z(103) = MFF*Z(90)/Z(94)
      Z(104) = (LRF*MFF+MRF*Z(91))/Z(94)
      Z(105) = (LSH*MFF+LSH*MRF+MSH*Z(92))/Z(94)
      Z(106) = (LTH*MFF+LTH*MRF+LTH*MSH+MTH*Z(93))/Z(94)
      Z(514) = G*MHAT
      Z(515) = G*MFF
      Z(519) = G*MTH
      Z(520) = G*MUA
      Z(546) = LFF - Z(96)
      Z(547) = LSH - Z(100)
      Z(548) = LTH - Z(101)
      Z(549) = 2*LRF - Z(98)
      Z(642) = LHAT - Z(95)
      Z(643) = LUA - Z(102)
      Z(648) = Z(96) - LFF
      Z(649) = 0.5D0*Z(98) - 0.5D0*LRFO
      Z(650) = 0.5D0*Z(99) - 0.5D0*LRFFO
      Z(840) = LSH - Z(105)
      Z(841) = LTH - Z(106)
      Z(842) = LRF - Z(104)
      Z(867) = 0.5D0*Z(98) - LRF
      Z(868) = Z(100) - LSH
      Z(869) = Z(101) - LTH
      Z(870) = LRF - 0.5D0*LRFO - Z(104)
      Z(917) = 2*Z(649) + 2*Z(27)*Z(650)
      Z(919) = Z(27)*Z(649)
      Z(931) = Z(27)*Z(650)
      Z(933) = Z(27)*Z(870)
      Z(959) = LFFO*MFF
      Z(971) = LLAO*MLA
      Z(983) = LFF*MRF
      Z(986) = LRFO*MRF
      Z(987) = LRFFO*MRF
      Z(1019) = LUAO*MUA
      Z(1068) = MRF*Z(91)
      Z(1080) = LSH*MRF
      Z(1099) = MSH*Z(92)
      Z(1116) = MTH*Z(93)
      Z(1142) = LFFO*Z(515)
      Z(1147) = LFF*Z(517)
      Z(1149) = Z(93)*Z(519)
      Z(1151) = Z(92)*Z(518)
      Z(1154) = LUAO*Z(520)
      Z(1193) = IHAT + 2*IFF + 2*ILA + 2*IRF + 2*ISH + 2*ITH + 2*IUA + M
     &FF*LFFO**2
      Z(1194) = LRFFO**2 + LRFO**2 + 4*LFF**2 + 2*LRFFO*LRFO*Z(27)
      Z(1195) = LFF*LRFFO
      Z(1196) = LFF*LRFO
      Z(1197) = LRFFO**2 + 4*Z(91)**2
      Z(1198) = LRFFO*Z(27)*Z(91)
      Z(1200) = IFF + IRF + ISH + MFF*LFFO**2
      Z(1202) = MFF*LFFO**2
      Z(1206) = LRFFO*Z(28)
      Z(1207) = LRFO*Z(28)
      Z(1208) = LRFFO*Z(27)
      Z(1209) = Z(27)*Z(91)
      Z(1210) = Z(28)*Z(91)
      Z(1213) = IFF + IRF + ISH + ITH + MFF*LFFO**2
      Z(1215) = IFF + IRF + MFF*LFFO**2
      Z(1217) = IFF + MFF*LFFO**2
      Z(1227) = IFF + MFF*LFFO**2 + MRF*LFF**2
      Z(1230) = IFF + IRF + ISH + ITH
      Z(1239) = IFF + IRF + ISH
      Z(1240) = LSH*Z(91)
      Z(1241) = LRFFO*LSH
      Z(1250) = IFF + IRF
      Z(1251) = LRFFO**2 + 4*Z(91)**2 - 4*LRFFO*Z(27)*Z(91)
      Z(1260) = ILA + IUA

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

6021  FORMAT(1X,'FILE: model/13seg_swing_vf/model.1 ',//1X,'*** ',99A1,/
     &//,8X,'T',12X,'POP1X',10X,'POP1Y',10X,'POP2X',10X,'POP2Y',10X,'POP
     &3X',10X,'POP3Y',10X,'POP4X',10X,'POP4Y',10X,'POP5X',10X,'POP5Y',10
     &X,'POP6X',10X,'POP6Y',10X,'POP7X',10X,'POP7Y',10X,'POP8X',10X,'POP
     &8Y',10X,'POP9X',10X,'POP9Y',9X,'POP10X',9X,'POP10Y',9X,'POP11X',9X
     &,'POP11Y',9X,'POP12X',9X,'POP12Y',9X,'POP13X',9X,'POP13Y',9X,'POP1
     &4X',9X,'POP14Y',9X,'POP15X',9X,'POP15Y',9X,'POP16X',9X,'POP16Y',10
     &X,'POCMX',10X,'POCMY',10X,'VOCMX',10X,'VOCMY',/,5X,'(UNITS)',8X,'(
     &UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(U
     &NITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UN
     &ITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNI
     &TS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNIT
     &S)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS
     &)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)
     &',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)'
     &,/)
6022  FORMAT(1X,'FILE: model/13seg_swing_vf/model.2 ',//1X,'*** ',99A1,/
     &//,8X,'T',13X,'Q1',13X,'Q2',13X,'Q3',13X,'Q4',13X,'Q5',13X,'Q6',13
     &X,'Q7',13X,'U1',13X,'U2',13X,'U3',13X,'U4',13X,'U5',13X,'U6',13X,'
     &U7',/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNI
     &TS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNIT
     &S)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS
     &)',/)
6023  FORMAT(1X,'FILE: model/13seg_swing_vf/model.3 ',//1X,'*** ',99A1,/
     &//,8X,'T',13X,'VRX',12X,'VRY',12X,'RX',13X,'RY',12X,'VRX1',11X,'VR
     &Y1',11X,'VRX2',11X,'VRY2',12X,'RX1',12X,'RX2',12X,'RY1',12X,'RY2',
     &/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)'
     &,8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',
     &8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6024  FORMAT(1X,'FILE: model/13seg_swing_vf/model.4 ',//1X,'*** ',99A1,/
     &//,8X,'T',12X,'RHTQ',11X,'LHTQ',11X,'RKTQ',11X,'LKTQ',11X,'RATQ',1
     &1X,'LATQ',11X,'RMTQ',11X,'LMTQ',11X,'RSTQ',11X,'LSTQ',11X,'RETQ',1
     &1X,'LETQ',/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X
     &,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,
     &'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6025  FORMAT(1X,'FILE: model/13seg_swing_vf/model.5 ',//1X,'*** ',99A1,/
     &//,8X,'T',13X,'RH',13X,'LH',13X,'RK',13X,'LK',13X,'RA',13X,'LA',12
     &X,'RMTP',11X,'LMTP',12X,'RS',13X,'LS',13X,'RE',13X,'LE',13X,'RH'''
     &,12X,'LH''',12X,'RK''',12X,'LK''',12X,'RA''',12X,'LA''',11X,'RMTP'
     &'',10X,'LMTP''',11X,'RS''',12X,'LS''',12X,'RE''',12X,'LE''',11X,'R
     &H''''',11X,'LH''''',11X,'RK''''',11X,'LK''''',11X,'RA''''',11X,'LA
     &''''',10X,'RMTP''''',9X,'LMTP''''',10X,'RS''''',11X,'LS''''',11X,'
     &RE''''',11X,'LE''''',/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'
     &(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(
     &UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(U
     &NITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UN
     &ITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNI
     &TS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNIT
     &S)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS
     &)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6026  FORMAT(1X,'FILE: model/13seg_swing_vf/model.6 ',//1X,'*** ',99A1,/
     &//,8X,'T',12X,'KECM',12X,'HZ',13X,'PX',13X,'PY',/,5X,'(UNITS)',8X,
     &'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6997  FORMAT(/7X,'Error: Numerical integration failed to converge',/)
6999  FORMAT(//1X,'Input is in the file model/13seg_swing_vf/model.in',/
     &/1X,'Output is in the file(s) model/13seg_swing_vf/model.i  (i=1, 
     &..., 6)',//1X,'The output quantities and associated files are list
     &ed in file model/13seg_swing_vf/model.dir',/)
7000  FORMAT(//,99A1,///)
7010  FORMAT( 1000(59X,E30.0,/) )
7011  FORMAT( 3(59X,E30.0,/), 1(59X,I30,/), 2(59X,E30.0,/) )
      STOP
7100  WRITE(*,*) 'Premature end of file while reading model/13seg_swing_
     &vf/model.in '
7101  WRITE(*,*) 'Error while reading file model/13seg_swing_vf/model.in
     &'
      STOP
      END


C**********************************************************************
      SUBROUTINE       EQNS1(T, VAR, VARp, BOUNDARY)
      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          BOUNDARY
      DIMENSION        VAR(*), VARp(*)
      COMMON/CONSTNTS/ AE,AF,FOOTANG,G,HE,HF,IFF,IHAT,ILA,IRF,ISH,ITH,IU
     &A,K1,K2,K3,K4,K5,K6,K7,K8,KE,KF,LFF,LFFO,LHAT,LHATO,LLA,LLAO,LRF,L
     &RFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,LUA,LUAO,MFF,MHAT,MLA,MRF,MSH,MTH
     &,MTPB,MTPK,MTPXI,MUA,TOEXI
      COMMON/SPECFIED/ LE,LS,RA,RE,RH,RK,RMTP,RS,LEp,LSp,RAp,REp,RHp,RKp
     &,RMTPp,RSp,LEpp,LSpp,RApp,REpp,RHpp,RKpp,RMTPpp,RSpp
      COMMON/VARIBLES/ Q1,Q2,Q3,Q4,Q5,Q6,Q7,U1,U2,U3,U4,U5,U6,U7
      COMMON/ALGBRAIC/ HZ,KECM,LA,LETQ,LH,LK,LMTP,LSTQ,PX,PY,RATQ,RETQ,R
     &HTQ,RKTQ,RSTQ,RX1,RX2,RY1,RY2,U10,U11,U12,U13,U14,U8,U9,VRX1,VRX2,
     &VRY1,VRY2,LAp,LHp,LKp,LMTPp,Q1p,Q2p,Q3p,Q4p,Q5p,Q6p,Q7p,U1p,U2p,U3
     &p,U4p,U5p,U6p,U7p,LApp,LHpp,LKpp,LMTPpp,LATQ,LHTQ,LKTQ,LMTQ,DLX1,D
     &LX2,POCMX,POCMY,POP10X,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP13X,P
     &OP13Y,POP14X,POP14Y,POP15X,POP15Y,POP16X,POP16Y,POP1X,POP1Y,POP2X,
     &POP2Y,POP3X,POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,
     &POP8X,POP8Y,POP9X,POP9Y,RMTQ,RX,RY,VOCMX,VOCMY,VOP2X,VOP2Y,VRX,VRY
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(1312),COEF(7,7),RHS(7)

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

      VRX1 = T**3
      VRX2 = T**3
      VRY1 = T**3
      VRY2 = T**3

      Q1p = U1
      Q2p = U2
      Q3p = U3
      Q4p = U4
      Q5p = U5
      Q6p = U6
      Q7p = U7
      RY1 = -K3*Q2 - K4*ABS(Q2)*U2
      DLX1 = Q1 - TOEXI
      RX1 = -RY1*(K1*DLX1+K2*U1)
      Z(13) = COS(Q6)
      Z(17) = COS(Q7)
      Z(14) = SIN(Q6)
      Z(18) = SIN(Q7)
      Z(29) = Z(13)*Z(17) - Z(14)*Z(18)
      Z(1) = COS(Q3)
      Z(6) = SIN(Q4)
      Z(9) = COS(Q5)
      Z(5) = COS(Q4)
      Z(10) = SIN(Q5)
      Z(33) = Z(6)*Z(9) - Z(5)*Z(10)
      Z(2) = SIN(Q3)
      Z(32) = -Z(5)*Z(9) - Z(6)*Z(10)
      Z(36) = Z(1)*Z(33) + Z(2)*Z(32)
      Z(30) = -Z(13)*Z(18) - Z(14)*Z(17)
      Z(34) = Z(5)*Z(10) - Z(6)*Z(9)
      Z(38) = Z(1)*Z(32) + Z(2)*Z(34)
      Z(40) = Z(29)*Z(36) + Z(30)*Z(38)
      POP2Y = Q2 - LFF*Z(40)
      Z(35) = Z(1)*Z(32) - Z(2)*Z(33)
      Z(37) = Z(1)*Z(34) - Z(2)*Z(32)
      Z(39) = Z(29)*Z(35) + Z(30)*Z(37)
      Z(31) = Z(13)*Z(18) + Z(14)*Z(17)
      Z(42) = Z(29)*Z(38) + Z(31)*Z(36)
      Z(41) = Z(29)*Z(37) + Z(31)*Z(35)
      VOP2Y = Z(40)*(Z(39)*U1+Z(40)*U2) - Z(42)*(LFF*U3+LFF*U5-LFF*U4-LF
     &F*U6-LFF*U7-Z(41)*U1-Z(42)*U2)
      RY2 = -K7*POP2Y - K8*ABS(POP2Y)*VOP2Y
      POP2X = Q1 - LFF*Z(39)
      DLX2 = POP2X - MTPXI
      VOP2X = Z(39)*(Z(39)*U1+Z(40)*U2) - Z(41)*(LFF*U3+LFF*U5-LFF*U4-LF
     &F*U6-LFF*U7-Z(41)*U1-Z(42)*U2)
      RX2 = -RY2*(K5*DLX2+K6*VOP2X)
      Z(43) = -Z(27)*Z(13) - Z(28)*Z(14)
      Z(45) = Z(28)*Z(13) - Z(27)*Z(14)
      Z(49) = Z(36)*Z(45) + Z(38)*Z(43)
      Z(53) = -Z(13)*Z(38) - Z(14)*Z(36)
      Z(54) = Z(1)*Z(5) + Z(2)*Z(6)
      Z(55) = Z(2)*Z(5) - Z(1)*Z(6)
      Z(114) = U5 - U4
      Z(121) = U5 - U4 - U6
      Z(132) = U5 - U4 - U6 - U7
      Z(155) = LFF*Z(18)
      Z(156) = -Z(17)*Z(39) - Z(18)*Z(41)
      Z(157) = -Z(17)*Z(40) - Z(18)*Z(42)
      Z(158) = Z(18)*Z(39) - Z(17)*Z(41)
      Z(159) = Z(18)*Z(40) - Z(17)*Z(42)
      Z(160) = LFF*Z(17)
      Z(161) = Z(160) - LRF
      Z(162) = LRF - Z(160)
      Z(163) = Z(13)*Z(155) - Z(14)*Z(162)
      Z(164) = Z(13)*Z(155) + Z(14)*Z(160)
      Z(165) = -Z(13)*Z(155) - Z(14)*Z(161)
      Z(166) = -Z(13)*Z(156) - Z(14)*Z(158)
      Z(167) = -Z(13)*Z(157) - Z(14)*Z(159)
      Z(168) = Z(13)*Z(160) - Z(14)*Z(155)
      Z(169) = Z(14)*Z(156) - Z(13)*Z(158)
      Z(170) = Z(14)*Z(157) - Z(13)*Z(159)
      Z(171) = Z(14)*Z(155) - Z(13)*Z(161)
      Z(172) = -Z(13)*Z(162) - Z(14)*Z(155)
      Z(173) = Z(171) - LSHO
      Z(174) = LSHO + Z(172)
      Z(175) = Z(171) - LSH
      Z(176) = LSH + Z(172)
      Z(177) = Z(10)*Z(168) - Z(9)*Z(164)
      Z(178) = Z(10)*Z(169) - Z(9)*Z(166)
      Z(179) = Z(10)*Z(170) - Z(9)*Z(167)
      Z(180) = Z(10)*Z(172) - Z(9)*Z(163)
      Z(181) = Z(10)*Z(175) - Z(9)*Z(165)
      Z(182) = Z(10)*Z(176) - Z(9)*Z(163)
      Z(183) = -Z(9)*Z(168) - Z(10)*Z(164)
      Z(184) = -Z(9)*Z(169) - Z(10)*Z(166)
      Z(185) = -Z(9)*Z(170) - Z(10)*Z(167)
      Z(186) = -Z(9)*Z(172) - Z(10)*Z(163)
      Z(187) = -Z(9)*Z(175) - Z(10)*Z(165)
      Z(188) = -Z(9)*Z(176) - Z(10)*Z(163)
      Z(189) = Z(187) - LTHO
      Z(190) = LTHO + Z(188)
      Z(191) = Z(187) - LTH
      Z(192) = LTH + Z(188)
      Z(308) = Z(5)*Z(177) + Z(6)*Z(183)
      Z(309) = Z(5)*Z(178) + Z(6)*Z(184)
      Z(310) = Z(5)*Z(179) + Z(6)*Z(185)
      Z(311) = Z(5)*Z(180) + Z(6)*Z(186)
      Z(312) = Z(5)*Z(181) + Z(6)*Z(191)
      Z(313) = Z(5)*Z(181) + Z(6)*Z(187)
      Z(314) = Z(5)*Z(182) + Z(6)*Z(192)
      Z(315) = Z(5)*Z(183) - Z(6)*Z(177)
      Z(316) = Z(5)*Z(184) - Z(6)*Z(178)
      Z(317) = Z(5)*Z(185) - Z(6)*Z(179)
      Z(318) = Z(5)*Z(186) - Z(6)*Z(180)
      Z(319) = Z(5)*Z(187) - Z(6)*Z(181)
      Z(320) = Z(5)*Z(191) - Z(6)*Z(181)
      Z(321) = Z(5)*Z(192) - Z(6)*Z(182)
      Z(322) = LHATO + Z(320)
      Z(323) = LHAT + Z(320)
      Z(423) = LFFO*(U3+U5-U4-U6-U7)*(U3+Z(132))
      Z(424) = LFF*(U3+U5-U4-U6-U7)*(U3+Z(132))
      Z(425) = LRFO*(U3+U5-U4-U6)*(U3+Z(121))
      Z(426) = LRFFO*(U3+U5-U4-U6)*(U3+Z(121))
      Z(427) = Z(17)*Z(424)
      Z(428) = Z(18)*Z(424)
      Z(429) = LRF*(U3+U5-U4-U6)*(U3+Z(121)) - Z(427)
      Z(430) = -Z(13)*Z(429) - Z(14)*Z(428)
      Z(431) = Z(14)*Z(429) - Z(13)*Z(428)
      Z(432) = Z(430) - LSHO*(U4-U3-U5)*(U3+Z(114))
      Z(433) = Z(430) - LSH*(U4-U3-U5)*(U3+Z(114))
      Z(434) = Z(10)*Z(431) - Z(9)*Z(433)
      Z(435) = -Z(9)*Z(431) - Z(10)*Z(433)
      Z(436) = LTHO*(U3-U4)**2 + Z(434)
      Z(437) = LTH*(U3-U4)**2 + Z(434)
      Z(474) = Z(5)*Z(437) + Z(6)*Z(435)
      Z(475) = Z(5)*Z(435) - Z(6)*Z(437)
      Z(476) = LHATO*U3
      Z(477) = Z(474) - U3*Z(476)
      Z(478) = LHAT*U3
      Z(479) = Z(474) - U3*Z(478)
      Z(532) = Z(28)*Z(18) - Z(27)*Z(17)
      Z(533) = Z(27)*Z(18) + Z(28)*Z(17)
      Z(534) = -Z(27)*Z(18) - Z(28)*Z(17)

C**   Quantities which were specified
      LHTQ = HE*HF*T**3
      LKTQ = KE*KF*T**3
      LATQ = AE*AF*T**3
      LMTQ = MTPK*(3.141592653589793D0-Q7) - MTPB*U7

      Z(523) = -LHTQ - LKTQ
      Z(525) = LATQ + LKTQ
      Z(527) = LMTQ - LATQ

C**   Quantities to be specified
      LE = 0
      LS = 0
      RA = 0
      RE = 0
      RH = 0
      RK = 0
      RMTP = 0
      RS = 0
      LEp = 0
      LSp = 0
      RAp = 0
      REp = 0
      RHp = 0
      RKp = 0
      RMTPp = 0
      RSp = 0
      LEpp = 0
      LSpp = 0
      RApp = 0
      REpp = 0
      RHpp = 0
      RKpp = 0
      RMTPpp = 0
      RSpp = 0

      Z(3) = COS(RH)
      Z(4) = SIN(RH)
      Z(7) = COS(RK)
      Z(8) = SIN(RK)
      Z(11) = COS(RA)
      Z(12) = SIN(RA)
      Z(15) = COS(RMTP)
      Z(16) = SIN(RMTP)
      Z(19) = COS(RS)
      Z(20) = SIN(RS)
      Z(21) = COS(LS)
      Z(22) = SIN(LS)
      Z(23) = COS(RE)
      Z(24) = SIN(RE)
      Z(25) = COS(LE)
      Z(26) = SIN(LE)
      Z(57) = Z(3)*Z(1) + Z(4)*Z(2)
      Z(58) = Z(3)*Z(2) - Z(4)*Z(1)
      Z(59) = Z(4)*Z(1) - Z(3)*Z(2)
      Z(60) = -Z(7)*Z(57) - Z(8)*Z(59)
      Z(61) = -Z(7)*Z(58) - Z(8)*Z(57)
      Z(62) = Z(8)*Z(57) - Z(7)*Z(59)
      Z(63) = Z(8)*Z(58) - Z(7)*Z(57)
      Z(64) = Z(12)*Z(62) - Z(11)*Z(60)
      Z(65) = Z(12)*Z(63) - Z(11)*Z(61)
      Z(66) = -Z(11)*Z(62) - Z(12)*Z(60)
      Z(67) = -Z(11)*Z(63) - Z(12)*Z(61)
      Z(71) = Z(27)*Z(67) - Z(28)*Z(65)
      Z(72) = Z(16)*Z(66) - Z(15)*Z(64)
      Z(73) = Z(16)*Z(67) - Z(15)*Z(65)
      Z(74) = -Z(15)*Z(66) - Z(16)*Z(64)
      Z(75) = -Z(15)*Z(67) - Z(16)*Z(65)
      Z(76) = -Z(19)*Z(1) - Z(20)*Z(2)
      Z(77) = Z(20)*Z(1) - Z(19)*Z(2)
      Z(80) = -Z(23)*Z(77) - Z(24)*Z(76)
      Z(82) = Z(24)*Z(77) - Z(23)*Z(76)
      Z(83) = -Z(21)*Z(1) - Z(22)*Z(2)
      Z(84) = Z(22)*Z(1) - Z(21)*Z(2)
      Z(87) = -Z(25)*Z(84) - Z(26)*Z(83)
      Z(89) = Z(26)*Z(84) - Z(25)*Z(83)
      Z(107) = U8 - RHp
      Z(109) = RKpp - RHpp
      Z(116) = RKpp - RApp - RHpp
      Z(127) = RKpp - RApp - RHpp - RMTPpp
      Z(137) = U11 - RSp
      Z(138) = U12 - LSp
      Z(140) = REpp - RSpp
      Z(146) = LEpp - LSpp
      Z(193) = Z(3)*Z(5) + Z(4)*Z(6)
      Z(194) = Z(4)*Z(5) - Z(3)*Z(6)
      Z(195) = Z(3)*Z(6) - Z(4)*Z(5)
      Z(196) = Z(177)*Z(193) + Z(183)*Z(195)
      Z(197) = Z(178)*Z(193) + Z(184)*Z(195)
      Z(198) = Z(179)*Z(193) + Z(185)*Z(195)
      Z(199) = Z(180)*Z(193) + Z(186)*Z(195)
      Z(200) = Z(181)*Z(193) + Z(191)*Z(195)
      Z(201) = Z(181)*Z(193) + Z(187)*Z(195)
      Z(202) = Z(182)*Z(193) + Z(192)*Z(195)
      Z(203) = Z(177)*Z(194) + Z(183)*Z(193)
      Z(204) = Z(178)*Z(194) + Z(184)*Z(193)
      Z(205) = Z(179)*Z(194) + Z(185)*Z(193)
      Z(206) = Z(180)*Z(194) + Z(186)*Z(193)
      Z(207) = Z(181)*Z(194) + Z(187)*Z(193)
      Z(208) = Z(181)*Z(194) + Z(191)*Z(193)
      Z(209) = Z(182)*Z(194) + Z(192)*Z(193)
      Z(210) = Z(93)*RHp
      Z(211) = Z(93) + Z(208)
      Z(212) = LTH*RHp
      Z(213) = LTH + Z(208)
      Z(215) = -Z(7)*Z(196) - Z(8)*Z(203)
      Z(216) = -Z(7)*Z(197) - Z(8)*Z(204)
      Z(217) = -Z(7)*Z(198) - Z(8)*Z(205)
      Z(218) = -Z(7)*Z(199) - Z(8)*Z(206)
      Z(219) = -Z(7)*Z(201) - Z(8)*Z(207)
      Z(220) = -Z(7)*Z(202) - Z(8)*Z(209)
      Z(221) = -Z(7)*Z(200) - Z(8)*Z(213)
      Z(223) = Z(8)*Z(196) - Z(7)*Z(203)
      Z(224) = Z(8)*Z(197) - Z(7)*Z(204)
      Z(225) = Z(8)*Z(198) - Z(7)*Z(205)
      Z(226) = Z(8)*Z(199) - Z(7)*Z(206)
      Z(227) = Z(8)*Z(200) - Z(7)*Z(213)
      Z(228) = Z(8)*Z(201) - Z(7)*Z(207)
      Z(229) = Z(8)*Z(202) - Z(7)*Z(209)
      Z(232) = RKp - RHp
      Z(233) = Z(92)*Z(232)
      Z(234) = Z(92) + Z(227)
      Z(237) = LSH*Z(232)
      Z(238) = LSH + Z(227)
      Z(241) = RKp - RAp - RHp
      Z(246) = Z(91)*Z(241)
      Z(247) = LRFFO*Z(241)
      Z(250) = Z(12)*Z(223) - Z(11)*Z(215)
      Z(251) = Z(12)*Z(224) - Z(11)*Z(216)
      Z(252) = Z(12)*Z(225) - Z(11)*Z(217)
      Z(253) = Z(12)*Z(226) - Z(11)*Z(218)
      Z(254) = Z(12)*Z(228) - Z(11)*Z(219)
      Z(255) = Z(12)*Z(229) - Z(11)*Z(220)
      Z(256) = Z(12)*Z(238) - Z(11)*Z(221)
      Z(259) = -Z(11)*Z(223) - Z(12)*Z(215)
      Z(260) = -Z(11)*Z(224) - Z(12)*Z(216)
      Z(261) = -Z(11)*Z(225) - Z(12)*Z(217)
      Z(262) = -Z(11)*Z(226) - Z(12)*Z(218)
      Z(263) = -Z(11)*Z(228) - Z(12)*Z(219)
      Z(264) = -Z(11)*Z(229) - Z(12)*Z(220)
      Z(265) = -Z(11)*Z(238) - Z(12)*Z(221)
      Z(268) = LRF*Z(241)
      Z(269) = LRF + Z(265)
      Z(276) = Z(16)*Z(259) - Z(15)*Z(250)
      Z(277) = Z(16)*Z(260) - Z(15)*Z(251)
      Z(278) = Z(16)*Z(261) - Z(15)*Z(252)
      Z(279) = Z(16)*Z(262) - Z(15)*Z(253)
      Z(280) = Z(16)*Z(263) - Z(15)*Z(254)
      Z(281) = Z(16)*Z(264) - Z(15)*Z(255)
      Z(282) = Z(16)*Z(269) - Z(15)*Z(256)
      Z(286) = -Z(15)*Z(259) - Z(16)*Z(250)
      Z(287) = -Z(15)*Z(260) - Z(16)*Z(251)
      Z(288) = -Z(15)*Z(261) - Z(16)*Z(252)
      Z(289) = -Z(15)*Z(262) - Z(16)*Z(253)
      Z(290) = -Z(15)*Z(263) - Z(16)*Z(254)
      Z(291) = -Z(15)*Z(264) - Z(16)*Z(255)
      Z(292) = -Z(15)*Z(269) - Z(16)*Z(256)
      Z(295) = RKp - RAp - RHp - RMTPp
      Z(296) = Z(90)*Z(295)
      Z(298) = Z(90) + Z(292)
      Z(304) = LFF + Z(292)
      Z(324) = Z(20)*Z(315) - Z(19)*Z(308)
      Z(325) = Z(20)*Z(316) - Z(19)*Z(309)
      Z(326) = Z(20)*Z(317) - Z(19)*Z(310)
      Z(327) = Z(20)*Z(318) - Z(19)*Z(311)
      Z(328) = Z(20)*Z(319) - Z(19)*Z(313)
      Z(329) = Z(20)*Z(321) - Z(19)*Z(314)
      Z(330) = Z(20)*Z(323) - Z(19)*Z(312)
      Z(331) = -Z(19)*Z(315) - Z(20)*Z(308)
      Z(332) = -Z(19)*Z(316) - Z(20)*Z(309)
      Z(333) = -Z(19)*Z(317) - Z(20)*Z(310)
      Z(334) = -Z(19)*Z(318) - Z(20)*Z(311)
      Z(335) = -Z(19)*Z(319) - Z(20)*Z(313)
      Z(336) = -Z(19)*Z(321) - Z(20)*Z(314)
      Z(337) = -Z(19)*Z(323) - Z(20)*Z(312)
      Z(338) = LUAO*RSp
      Z(339) = LUAO + Z(337)
      Z(340) = LUA*RSp
      Z(341) = LUA + Z(337)
      Z(343) = -Z(23)*Z(324) - Z(24)*Z(331)
      Z(344) = -Z(23)*Z(325) - Z(24)*Z(332)
      Z(345) = -Z(23)*Z(326) - Z(24)*Z(333)
      Z(346) = -Z(23)*Z(327) - Z(24)*Z(334)
      Z(347) = -Z(23)*Z(328) - Z(24)*Z(335)
      Z(348) = -Z(23)*Z(329) - Z(24)*Z(336)
      Z(349) = -Z(23)*Z(330) - Z(24)*Z(341)
      Z(351) = Z(24)*Z(324) - Z(23)*Z(331)
      Z(352) = Z(24)*Z(325) - Z(23)*Z(332)
      Z(353) = Z(24)*Z(326) - Z(23)*Z(333)
      Z(354) = Z(24)*Z(327) - Z(23)*Z(334)
      Z(355) = Z(24)*Z(328) - Z(23)*Z(335)
      Z(356) = Z(24)*Z(329) - Z(23)*Z(336)
      Z(357) = Z(24)*Z(330) - Z(23)*Z(341)
      Z(360) = REp - RSp
      Z(361) = LLAO*Z(360)
      Z(363) = LLAO + Z(357)
      Z(369) = Z(22)*Z(315) - Z(21)*Z(308)
      Z(370) = Z(22)*Z(316) - Z(21)*Z(309)
      Z(371) = Z(22)*Z(317) - Z(21)*Z(310)
      Z(372) = Z(22)*Z(318) - Z(21)*Z(311)
      Z(373) = Z(22)*Z(319) - Z(21)*Z(313)
      Z(374) = Z(22)*Z(321) - Z(21)*Z(314)
      Z(375) = Z(22)*Z(323) - Z(21)*Z(312)
      Z(376) = -Z(21)*Z(315) - Z(22)*Z(308)
      Z(377) = -Z(21)*Z(316) - Z(22)*Z(309)
      Z(378) = -Z(21)*Z(317) - Z(22)*Z(310)
      Z(379) = -Z(21)*Z(318) - Z(22)*Z(311)
      Z(380) = -Z(21)*Z(319) - Z(22)*Z(313)
      Z(381) = -Z(21)*Z(321) - Z(22)*Z(314)
      Z(382) = -Z(21)*Z(323) - Z(22)*Z(312)
      Z(383) = LUAO*LSp
      Z(384) = LUAO + Z(382)
      Z(385) = LUA*LSp
      Z(386) = LUA + Z(382)
      Z(388) = -Z(25)*Z(369) - Z(26)*Z(376)
      Z(389) = -Z(25)*Z(370) - Z(26)*Z(377)
      Z(390) = -Z(25)*Z(371) - Z(26)*Z(378)
      Z(391) = -Z(25)*Z(372) - Z(26)*Z(379)
      Z(392) = -Z(25)*Z(373) - Z(26)*Z(380)
      Z(393) = -Z(25)*Z(374) - Z(26)*Z(381)
      Z(394) = -Z(25)*Z(375) - Z(26)*Z(386)
      Z(396) = Z(26)*Z(369) - Z(25)*Z(376)
      Z(397) = Z(26)*Z(370) - Z(25)*Z(377)
      Z(398) = Z(26)*Z(371) - Z(25)*Z(378)
      Z(399) = Z(26)*Z(372) - Z(25)*Z(379)
      Z(400) = Z(26)*Z(373) - Z(25)*Z(380)
      Z(401) = Z(26)*Z(374) - Z(25)*Z(381)
      Z(402) = Z(26)*Z(375) - Z(25)*Z(386)
      Z(405) = LEp - LSp
      Z(406) = LLAO*Z(405)
      Z(408) = LLAO + Z(402)
      Z(438) = Z(193)*Z(437) + Z(195)*Z(435)
      Z(439) = Z(193)*Z(435) + Z(194)*Z(437)
      Z(440) = Z(93)*RHpp
      Z(441) = Z(438) + (Z(210)-Z(93)*U3-Z(93)*U8)*(U3+Z(107))
      Z(442) = Z(439) - Z(440)
      Z(443) = LTH*RHpp
      Z(444) = Z(438) + (Z(212)-LTH*U3-LTH*U8)*(U3+Z(107))
      Z(445) = Z(439) - Z(443)
      Z(446) = -Z(7)*Z(444) - Z(8)*Z(445)
      Z(447) = Z(8)*Z(444) - Z(7)*Z(445)
      Z(448) = Z(92)*Z(109)
      Z(449) = Z(232) + U8 + U9
      Z(450) = Z(446) - (Z(233)+Z(92)*U3+Z(92)*U8+Z(92)*U9)*(U3+Z(449))
      Z(451) = Z(448) + Z(447)
      Z(452) = LSH*Z(109)
      Z(453) = Z(446) - (Z(237)+LSH*U3+LSH*U8+LSH*U9)*(U3+Z(449))
      Z(454) = Z(452) + Z(447)
      Z(455) = Z(91)*Z(116)
      Z(456) = LRFFO*Z(116)
      Z(457) = Z(241) + U10 + U8 + U9
      Z(458) = (Z(246)+Z(91)*U10+Z(91)*U3+Z(91)*U8+Z(91)*U9)*(U3+Z(457))
      Z(459) = (Z(247)+LRFFO*U10+LRFFO*U3+LRFFO*U8+LRFFO*U9)*(U3+Z(457))
      Z(460) = Z(12)*Z(454) - Z(11)*Z(453)
      Z(461) = -Z(11)*Z(454) - Z(12)*Z(453)
      Z(462) = LRF*Z(116)
      Z(463) = Z(460) - (Z(268)+LRF*U10+LRF*U3+LRF*U8+LRF*U9)*(U3+Z(457)
     &)
      Z(464) = Z(462) + Z(461)
      Z(465) = Z(16)*Z(464) - Z(15)*Z(463)
      Z(466) = -Z(15)*Z(464) - Z(16)*Z(463)
      Z(467) = Z(90)*Z(127)
      Z(468) = Z(295) + U10 + U8 + U9
      Z(469) = Z(465) - (Z(296)+Z(90)*U10+Z(90)*U3+Z(90)*U8+Z(90)*U9)*(U
     &3+Z(468))
      Z(470) = Z(467) + Z(466)
      Z(480) = Z(20)*Z(475) - Z(19)*Z(479)
      Z(481) = -Z(19)*Z(475) - Z(20)*Z(479)
      Z(482) = LUAO*RSpp
      Z(483) = Z(480) + (Z(338)-LUAO*U11-LUAO*U3)*(U3+Z(137))
      Z(484) = Z(481) - Z(482)
      Z(485) = LUA*RSpp
      Z(486) = Z(480) + (Z(340)-LUA*U11-LUA*U3)*(U3+Z(137))
      Z(487) = Z(481) - Z(485)
      Z(488) = -Z(23)*Z(486) - Z(24)*Z(487)
      Z(489) = Z(24)*Z(486) - Z(23)*Z(487)
      Z(490) = LLAO*Z(140)
      Z(491) = Z(360) + U11 + U13
      Z(492) = Z(488) - (Z(361)+LLAO*U11+LLAO*U13+LLAO*U3)*(U3+Z(491))
      Z(493) = Z(490) + Z(489)
      Z(497) = Z(22)*Z(475) - Z(21)*Z(479)
      Z(498) = -Z(21)*Z(475) - Z(22)*Z(479)
      Z(499) = LUAO*LSpp
      Z(500) = Z(497) + (Z(383)-LUAO*U12-LUAO*U3)*(U3+Z(138))
      Z(501) = Z(498) - Z(499)
      Z(502) = LUA*LSpp
      Z(503) = Z(497) + (Z(385)-LUA*U12-LUA*U3)*(U3+Z(138))
      Z(504) = Z(498) - Z(502)
      Z(505) = -Z(25)*Z(503) - Z(26)*Z(504)
      Z(506) = Z(26)*Z(503) - Z(25)*Z(504)
      Z(507) = LLAO*Z(146)
      Z(508) = Z(405) + U12 + U14
      Z(509) = Z(505) - (Z(406)+LLAO*U12+LLAO*U14+LLAO*U3)*(U3+Z(508))
      Z(510) = Z(507) + Z(506)
      Z(535) = -Z(27)*Z(11) - Z(28)*Z(12)
      Z(536) = Z(27)*Z(12) - Z(28)*Z(11)
      Z(537) = Z(28)*Z(11) - Z(27)*Z(12)
      Z(1140) = RX1 + RX2*Z(39)**2 + RX2*Z(41)**2 + RY2*Z(39)*Z(40) + RY
     &2*Z(41)*Z(42) + VRX1*Z(72)*Z(277) + VRX1*Z(74)*Z(287) + VRX2*Z(64)
     &*Z(251) + VRX2*Z(66)*Z(260) + VRY1*Z(73)*Z(277) + VRY1*Z(75)*Z(287
     &) + VRY2*Z(65)*Z(251) + VRY2*Z(67)*Z(260) + Z(514)*(Z(1)*Z(316)+Z(
     &2)*Z(309)) + Z(515)*(Z(39)*Z(40)+Z(41)*Z(42)) + Z(515)*(Z(73)*Z(27
     &7)+Z(75)*Z(287)) + Z(516)*(Z(80)*Z(344)+Z(82)*Z(352)) + Z(516)*(Z(
     &87)*Z(389)+Z(89)*Z(397)) + Z(517)*(Z(39)*Z(40)+Z(41)*Z(42)) + Z(51
     &7)*(Z(61)*Z(216)+Z(63)*Z(224)) + Z(518)*(Z(36)*Z(166)+Z(38)*Z(169)
     &) + Z(518)*(Z(61)*Z(216)+Z(63)*Z(224)) + Z(519)*(Z(54)*Z(184)+Z(55
     &)*Z(178)) + Z(519)*(Z(57)*Z(204)+Z(58)*Z(197)) + Z(520)*(Z(76)*Z(3
     &32)+Z(77)*Z(325)) + Z(520)*(Z(83)*Z(377)+Z(84)*Z(370))
      Z(1141) = RY1 + RX2*Z(39)*Z(40) + RX2*Z(41)*Z(42) + RY2*Z(40)**2 +
     & RY2*Z(42)**2 + VRX1*Z(72)*Z(278) + VRX1*Z(74)*Z(288) + VRX2*Z(64)
     &*Z(252) + VRX2*Z(66)*Z(261) + VRY1*Z(73)*Z(278) + VRY1*Z(75)*Z(288
     &) + VRY2*Z(65)*Z(252) + VRY2*Z(67)*Z(261) + Z(514)*(Z(1)*Z(317)+Z(
     &2)*Z(310)) + Z(515)*(Z(40)**2+Z(42)**2) + Z(515)*(Z(73)*Z(278)+Z(7
     &5)*Z(288)) + Z(516)*(Z(80)*Z(345)+Z(82)*Z(353)) + Z(516)*(Z(87)*Z(
     &390)+Z(89)*Z(398)) + Z(517)*(Z(40)**2+Z(42)**2) + Z(517)*(Z(61)*Z(
     &217)+Z(63)*Z(225)) + Z(518)*(Z(36)*Z(167)+Z(38)*Z(170)) + Z(518)*(
     &Z(61)*Z(217)+Z(63)*Z(225)) + Z(519)*(Z(54)*Z(185)+Z(55)*Z(179)) + 
     &Z(519)*(Z(57)*Z(205)+Z(58)*Z(198)) + Z(520)*(Z(76)*Z(333)+Z(77)*Z(
     &326)) + Z(520)*(Z(83)*Z(378)+Z(84)*Z(371))
      Z(1144) = LMTQ + Z(1142)*Z(42) + VRX1*Z(72)*Z(281) + VRX1*Z(74)*Z(
     &291) + VRX2*Z(64)*Z(255) + VRX2*Z(66)*Z(264) + VRY1*Z(73)*Z(281) +
     & VRY1*Z(75)*Z(291) + VRY2*Z(65)*Z(255) + VRY2*Z(67)*Z(264) + LFF*(
     &RX2*Z(41)+RY2*Z(42)) + Z(514)*(Z(1)*Z(321)+Z(2)*Z(314)) + Z(515)*(
     &Z(73)*Z(281)+Z(75)*Z(291)) + Z(516)*(Z(80)*Z(348)+Z(82)*Z(356)) + 
     &Z(516)*(Z(87)*Z(393)+Z(89)*Z(401)) + Z(517)*(Z(61)*Z(220)+Z(63)*Z(
     &229)) + Z(518)*(Z(36)*Z(163)+Z(38)*Z(174)) + Z(518)*(Z(61)*Z(220)+
     &Z(63)*Z(229)) + Z(519)*(Z(54)*Z(190)+Z(55)*Z(182)) + Z(519)*(Z(57)
     &*Z(209)+Z(58)*Z(202)) + Z(520)*(Z(76)*Z(336)+Z(77)*Z(329)) + Z(520
     &)*(Z(83)*Z(381)+Z(84)*Z(374)) + 0.5D0*Z(517)*(LRFFO*Z(49)+LRFO*Z(5
     &3)+2*LFF*Z(42)) - Z(523) - Z(525) - Z(527)
      Z(1145) = Z(525) + Z(527) + VRX1*Z(72)*Z(280) + VRX1*Z(74)*Z(290) 
     &+ VRX2*Z(64)*Z(254) + VRX2*Z(66)*Z(263) + VRY1*Z(73)*Z(280) + VRY1
     &*Z(75)*Z(290) + VRY2*Z(65)*Z(254) + VRY2*Z(67)*Z(263) + Z(514)*(Z(
     &1)*Z(319)+Z(2)*Z(313)) + Z(515)*(Z(73)*Z(280)+Z(75)*Z(290)) + Z(51
     &6)*(Z(80)*Z(347)+Z(82)*Z(355)) + Z(516)*(Z(87)*Z(392)+Z(89)*Z(400)
     &) + Z(517)*(Z(61)*Z(219)+Z(63)*Z(228)) + Z(518)*(Z(36)*Z(165)+Z(38
     &)*Z(173)) + Z(518)*(Z(61)*Z(219)+Z(63)*Z(228)) + Z(519)*(Z(54)*Z(1
     &87)+Z(55)*Z(181)) + Z(519)*(Z(57)*Z(207)+Z(58)*Z(201)) + Z(520)*(Z
     &(76)*Z(335)+Z(77)*Z(328)) + Z(520)*(Z(83)*Z(380)+Z(84)*Z(373)) - L
     &MTQ - Z(1142)*Z(42) - LFF*(RX2*Z(41)+RY2*Z(42)) - 0.5D0*Z(517)*(LR
     &FFO*Z(49)+LRFO*Z(53)+2*LFF*Z(42))
      Z(1146) = LMTQ + Z(1142)*Z(42) + VRX1*Z(72)*Z(279) + VRX1*Z(74)*Z(
     &289) + VRX2*Z(64)*Z(253) + VRX2*Z(66)*Z(262) + VRY1*Z(73)*Z(279) +
     & VRY1*Z(75)*Z(289) + VRY2*Z(65)*Z(253) + VRY2*Z(67)*Z(262) + LFF*(
     &RX2*Z(41)+RY2*Z(42)) + Z(514)*(Z(1)*Z(318)+Z(2)*Z(311)) + Z(515)*(
     &Z(73)*Z(279)+Z(75)*Z(289)) + Z(516)*(Z(80)*Z(346)+Z(82)*Z(354)) + 
     &Z(516)*(Z(87)*Z(391)+Z(89)*Z(399)) + Z(517)*(Z(61)*Z(218)+Z(63)*Z(
     &226)) + Z(518)*(Z(36)*Z(163)+Z(38)*Z(172)) + Z(518)*(Z(61)*Z(218)+
     &Z(63)*Z(226)) + Z(519)*(Z(54)*Z(186)+Z(55)*Z(180)) + Z(519)*(Z(57)
     &*Z(206)+Z(58)*Z(199)) + Z(520)*(Z(76)*Z(334)+Z(77)*Z(327)) + Z(520
     &)*(Z(83)*Z(379)+Z(84)*Z(372)) + 0.5D0*Z(517)*(LRFFO*Z(49)+LRFO*Z(5
     &3)+2*LFF*Z(42)) - Z(527)
      Z(1148) = LMTQ + Z(1142)*Z(42) + Z(1147)*Z(42) + VRX1*Z(72)*Z(276)
     & + VRX1*Z(74)*Z(286) + VRX2*Z(64)*Z(250) + VRX2*Z(66)*Z(259) + VRY
     &1*Z(73)*Z(276) + VRY1*Z(75)*Z(286) + VRY2*Z(65)*Z(250) + VRY2*Z(67
     &)*Z(259) + LFF*(RX2*Z(41)+RY2*Z(42)) + Z(514)*(Z(1)*Z(315)+Z(2)*Z(
     &308)) + Z(515)*(Z(73)*Z(276)+Z(75)*Z(286)) + Z(516)*(Z(80)*Z(343)+
     &Z(82)*Z(351)) + Z(516)*(Z(87)*Z(388)+Z(89)*Z(396)) + Z(517)*(Z(61)
     &*Z(215)+Z(63)*Z(223)) + Z(518)*(Z(36)*Z(164)+Z(38)*Z(168)) + Z(518
     &)*(Z(61)*Z(215)+Z(63)*Z(223)) + Z(519)*(Z(54)*Z(183)+Z(55)*Z(177))
     & + Z(519)*(Z(57)*Z(203)+Z(58)*Z(196)) + Z(520)*(Z(76)*Z(331)+Z(77)
     &*Z(324)) + Z(520)*(Z(83)*Z(376)+Z(84)*Z(369))
      Z(1163) = ILA*Z(146)
      Z(1171) = IUA*LSpp
      Z(1172) = IFF*Z(127)
      Z(1173) = ILA*Z(140)
      Z(1174) = IRF*Z(116)
      Z(1175) = ISH*Z(109)
      Z(1176) = ITH*RHpp
      Z(1177) = IUA*RSpp
      Z(1178) = Z(959)*Z(41) + Z(983)*Z(41) + MFF*(Z(276)*Z(277)+Z(286)*
     &Z(287)) + MHAT*(Z(308)*Z(309)+Z(315)*Z(316)) + MLA*(Z(343)*Z(344)+
     &Z(351)*Z(352)) + MLA*(Z(388)*Z(389)+Z(396)*Z(397)) + MRF*(Z(215)*Z
     &(216)+Z(223)*Z(224)) + MSH*(Z(164)*Z(166)+Z(168)*Z(169)) + MSH*(Z(
     &215)*Z(216)+Z(223)*Z(224)) + MTH*(Z(177)*Z(178)+Z(183)*Z(184)) + M
     &TH*(Z(196)*Z(197)+Z(203)*Z(204)) + MUA*(Z(324)*Z(325)+Z(331)*Z(332
     &)) + MUA*(Z(369)*Z(370)+Z(376)*Z(377))
      Z(1179) = MFF*(Z(39)**2+Z(41)**2) + MFF*(Z(277)**2+Z(287)**2) + MH
     &AT*(Z(309)**2+Z(316)**2) + MLA*(Z(344)**2+Z(352)**2) + MLA*(Z(389)
     &**2+Z(397)**2) + MRF*(Z(39)**2+Z(41)**2) + MRF*(Z(216)**2+Z(224)**
     &2) + MSH*(Z(166)**2+Z(169)**2) + MSH*(Z(216)**2+Z(224)**2) + MTH*(
     &Z(178)**2+Z(184)**2) + MTH*(Z(197)**2+Z(204)**2) + MUA*(Z(325)**2+
     &Z(332)**2) + MUA*(Z(370)**2+Z(377)**2)
      Z(1180) = MFF*(Z(39)*Z(40)+Z(41)*Z(42)) + MFF*(Z(277)*Z(278)+Z(287
     &)*Z(288)) + MHAT*(Z(309)*Z(310)+Z(316)*Z(317)) + MLA*(Z(344)*Z(345
     &)+Z(352)*Z(353)) + MLA*(Z(389)*Z(390)+Z(397)*Z(398)) + MRF*(Z(39)*
     &Z(40)+Z(41)*Z(42)) + MRF*(Z(216)*Z(217)+Z(224)*Z(225)) + MSH*(Z(16
     &6)*Z(167)+Z(169)*Z(170)) + MSH*(Z(216)*Z(217)+Z(224)*Z(225)) + MTH
     &*(Z(178)*Z(179)+Z(184)*Z(185)) + MTH*(Z(197)*Z(198)+Z(204)*Z(205))
     & + MUA*(Z(325)*Z(326)+Z(332)*Z(333)) + MUA*(Z(370)*Z(371)+Z(377)*Z
     &(378))
      Z(1181) = Z(959)*Z(41) + MFF*(Z(277)*Z(279)+Z(287)*Z(289)) + MHAT*
     &(Z(309)*Z(311)+Z(316)*Z(318)) + MLA*(Z(344)*Z(346)+Z(352)*Z(354)) 
     &+ MLA*(Z(389)*Z(391)+Z(397)*Z(399)) + MRF*(Z(216)*Z(218)+Z(224)*Z(
     &226)) + MSH*(Z(163)*Z(166)+Z(169)*Z(172)) + MSH*(Z(216)*Z(218)+Z(2
     &24)*Z(226)) + MTH*(Z(178)*Z(180)+Z(184)*Z(186)) + MTH*(Z(197)*Z(19
     &9)+Z(204)*Z(206)) + MUA*(Z(325)*Z(327)+Z(332)*Z(334)) + MUA*(Z(370
     &)*Z(372)+Z(377)*Z(379)) - 0.5D0*MRF*(LRFO*Z(17)*Z(41)-2*LFF*Z(41)-
     &LRFFO*Z(39)*Z(533)-LRFFO*Z(41)*Z(532)-LRFO*Z(18)*Z(39))
      Z(1182) = MFF*(Z(277)*Z(282)+Z(287)*Z(298)) + MHAT*(Z(309)*Z(312)+
     &Z(316)*Z(322)) + MLA*(Z(344)*Z(349)+Z(352)*Z(363)) + MLA*(Z(389)*Z
     &(394)+Z(397)*Z(408)) + MSH*(Z(165)*Z(166)+Z(169)*Z(173)) + MSH*(Z(
     &216)*Z(221)+Z(224)*Z(234)) + MTH*(Z(178)*Z(181)+Z(184)*Z(189)) + M
     &TH*(Z(197)*Z(200)+Z(204)*Z(211)) + MUA*(Z(325)*Z(330)+Z(332)*Z(339
     &)) + MUA*(Z(370)*Z(375)+Z(377)*Z(384)) + 0.5D0*MRF*(LRFO*Z(17)*Z(4
     &1)-2*LFF*Z(41)-LRFFO*Z(39)*Z(533)-LRFFO*Z(41)*Z(532)-LRFO*Z(18)*Z(
     &39)) + 0.5D0*MRF*(2*Z(216)*Z(221)+2*Z(224)*Z(238)-2*Z(91)*Z(11)*Z(
     &224)-2*Z(91)*Z(12)*Z(216)-LRFFO*Z(535)*Z(224)-LRFFO*Z(537)*Z(216))
     & - Z(959)*Z(41)
      Z(1183) = MFF*(Z(277)*Z(280)+Z(287)*Z(290)) + MHAT*(Z(309)*Z(313)+
     &Z(316)*Z(319)) + MLA*(Z(344)*Z(347)+Z(352)*Z(355)) + MLA*(Z(389)*Z
     &(392)+Z(397)*Z(400)) + MRF*(Z(216)*Z(219)+Z(224)*Z(228)) + MSH*(Z(
     &165)*Z(166)+Z(169)*Z(173)) + MSH*(Z(216)*Z(219)+Z(224)*Z(228)) + M
     &TH*(Z(178)*Z(181)+Z(184)*Z(187)) + MTH*(Z(197)*Z(201)+Z(204)*Z(207
     &)) + MUA*(Z(325)*Z(328)+Z(332)*Z(335)) + MUA*(Z(370)*Z(373)+Z(377)
     &*Z(380)) + 0.5D0*MRF*(LRFO*Z(17)*Z(41)-2*LFF*Z(41)-LRFFO*Z(39)*Z(5
     &33)-LRFFO*Z(41)*Z(532)-LRFO*Z(18)*Z(39)) - Z(959)*Z(41)
      Z(1184) = Z(959)*Z(41) + MFF*(Z(277)*Z(281)+Z(287)*Z(291)) + MHAT*
     &(Z(309)*Z(314)+Z(316)*Z(321)) + MLA*(Z(344)*Z(348)+Z(352)*Z(356)) 
     &+ MLA*(Z(389)*Z(393)+Z(397)*Z(401)) + MRF*(Z(216)*Z(220)+Z(224)*Z(
     &229)) + MSH*(Z(163)*Z(166)+Z(169)*Z(174)) + MSH*(Z(216)*Z(220)+Z(2
     &24)*Z(229)) + MTH*(Z(178)*Z(182)+Z(184)*Z(190)) + MTH*(Z(197)*Z(20
     &2)+Z(204)*Z(209)) + MUA*(Z(325)*Z(329)+Z(332)*Z(336)) + MUA*(Z(370
     &)*Z(374)+Z(377)*Z(381)) - 0.5D0*MRF*(LRFO*Z(17)*Z(41)-2*LFF*Z(41)-
     &LRFFO*Z(39)*Z(533)-LRFFO*Z(41)*Z(532)-LRFO*Z(18)*Z(39))
      Z(1185) = MFF*Z(39)*Z(423) + MFF*(Z(277)*Z(469)+Z(287)*Z(470)) + M
     &HAT*(Z(309)*Z(477)+Z(316)*Z(475)) + MLA*(Z(344)*Z(492)+Z(352)*Z(49
     &3)) + MLA*(Z(389)*Z(509)+Z(397)*Z(510)) + MSH*(Z(166)*Z(432)+Z(169
     &)*Z(431)) + MSH*(Z(216)*Z(450)+Z(224)*Z(451)) + MTH*(Z(178)*Z(436)
     &+Z(184)*Z(435)) + MTH*(Z(197)*Z(441)+Z(204)*Z(442)) + MUA*(Z(325)*
     &Z(483)+Z(332)*Z(484)) + MUA*(Z(370)*Z(500)+Z(377)*Z(501)) - 0.5D0*
     &MRF*(Z(17)*Z(39)*Z(425)+Z(18)*Z(41)*Z(425)-2*Z(39)*Z(424)-Z(39)*Z(
     &532)*Z(426)-Z(41)*Z(534)*Z(426)) - 0.5D0*MRF*(Z(535)*Z(456)*Z(224)
     &+Z(537)*Z(456)*Z(216)+2*Z(11)*Z(455)*Z(224)+2*Z(12)*Z(455)*Z(216)+
     &2*Z(12)*Z(224)*Z(458)-2*Z(216)*Z(453)-2*Z(224)*Z(454)-2*Z(11)*Z(21
     &6)*Z(458)-Z(535)*Z(216)*Z(459)-Z(536)*Z(224)*Z(459))
      Z(1186) = Z(959)*Z(42) + Z(983)*Z(42) + MFF*(Z(276)*Z(278)+Z(286)*
     &Z(288)) + MHAT*(Z(308)*Z(310)+Z(315)*Z(317)) + MLA*(Z(343)*Z(345)+
     &Z(351)*Z(353)) + MLA*(Z(388)*Z(390)+Z(396)*Z(398)) + MRF*(Z(215)*Z
     &(217)+Z(223)*Z(225)) + MSH*(Z(164)*Z(167)+Z(168)*Z(170)) + MSH*(Z(
     &215)*Z(217)+Z(223)*Z(225)) + MTH*(Z(177)*Z(179)+Z(183)*Z(185)) + M
     &TH*(Z(196)*Z(198)+Z(203)*Z(205)) + MUA*(Z(324)*Z(326)+Z(331)*Z(333
     &)) + MUA*(Z(369)*Z(371)+Z(376)*Z(378))
      Z(1187) = MFF*(Z(40)**2+Z(42)**2) + MFF*(Z(278)**2+Z(288)**2) + MH
     &AT*(Z(310)**2+Z(317)**2) + MLA*(Z(345)**2+Z(353)**2) + MLA*(Z(390)
     &**2+Z(398)**2) + MRF*(Z(40)**2+Z(42)**2) + MRF*(Z(217)**2+Z(225)**
     &2) + MSH*(Z(167)**2+Z(170)**2) + MSH*(Z(217)**2+Z(225)**2) + MTH*(
     &Z(179)**2+Z(185)**2) + MTH*(Z(198)**2+Z(205)**2) + MUA*(Z(326)**2+
     &Z(333)**2) + MUA*(Z(371)**2+Z(378)**2)
      Z(1188) = Z(959)*Z(42) + MFF*(Z(278)*Z(279)+Z(288)*Z(289)) + MHAT*
     &(Z(310)*Z(311)+Z(317)*Z(318)) + MLA*(Z(345)*Z(346)+Z(353)*Z(354)) 
     &+ MLA*(Z(390)*Z(391)+Z(398)*Z(399)) + MRF*(Z(217)*Z(218)+Z(225)*Z(
     &226)) + MSH*(Z(163)*Z(167)+Z(170)*Z(172)) + MSH*(Z(217)*Z(218)+Z(2
     &25)*Z(226)) + MTH*(Z(179)*Z(180)+Z(185)*Z(186)) + MTH*(Z(198)*Z(19
     &9)+Z(205)*Z(206)) + MUA*(Z(326)*Z(327)+Z(333)*Z(334)) + MUA*(Z(371
     &)*Z(372)+Z(378)*Z(379)) - 0.5D0*MRF*(LRFO*Z(17)*Z(42)-2*LFF*Z(42)-
     &LRFFO*Z(40)*Z(533)-LRFFO*Z(42)*Z(532)-LRFO*Z(18)*Z(40))
      Z(1189) = MFF*(Z(278)*Z(282)+Z(288)*Z(298)) + MHAT*(Z(310)*Z(312)+
     &Z(317)*Z(322)) + MLA*(Z(345)*Z(349)+Z(353)*Z(363)) + MLA*(Z(390)*Z
     &(394)+Z(398)*Z(408)) + MSH*(Z(165)*Z(167)+Z(170)*Z(173)) + MSH*(Z(
     &217)*Z(221)+Z(225)*Z(234)) + MTH*(Z(179)*Z(181)+Z(185)*Z(189)) + M
     &TH*(Z(198)*Z(200)+Z(205)*Z(211)) + MUA*(Z(326)*Z(330)+Z(333)*Z(339
     &)) + MUA*(Z(371)*Z(375)+Z(378)*Z(384)) + 0.5D0*MRF*(LRFO*Z(17)*Z(4
     &2)-2*LFF*Z(42)-LRFFO*Z(40)*Z(533)-LRFFO*Z(42)*Z(532)-LRFO*Z(18)*Z(
     &40)) + 0.5D0*MRF*(2*Z(217)*Z(221)+2*Z(225)*Z(238)-2*Z(91)*Z(11)*Z(
     &225)-2*Z(91)*Z(12)*Z(217)-LRFFO*Z(535)*Z(225)-LRFFO*Z(537)*Z(217))
     & - Z(959)*Z(42)
      Z(1190) = MFF*(Z(278)*Z(280)+Z(288)*Z(290)) + MHAT*(Z(310)*Z(313)+
     &Z(317)*Z(319)) + MLA*(Z(345)*Z(347)+Z(353)*Z(355)) + MLA*(Z(390)*Z
     &(392)+Z(398)*Z(400)) + MRF*(Z(217)*Z(219)+Z(225)*Z(228)) + MSH*(Z(
     &165)*Z(167)+Z(170)*Z(173)) + MSH*(Z(217)*Z(219)+Z(225)*Z(228)) + M
     &TH*(Z(179)*Z(181)+Z(185)*Z(187)) + MTH*(Z(198)*Z(201)+Z(205)*Z(207
     &)) + MUA*(Z(326)*Z(328)+Z(333)*Z(335)) + MUA*(Z(371)*Z(373)+Z(378)
     &*Z(380)) + 0.5D0*MRF*(LRFO*Z(17)*Z(42)-2*LFF*Z(42)-LRFFO*Z(40)*Z(5
     &33)-LRFFO*Z(42)*Z(532)-LRFO*Z(18)*Z(40)) - Z(959)*Z(42)
      Z(1191) = Z(959)*Z(42) + MFF*(Z(278)*Z(281)+Z(288)*Z(291)) + MHAT*
     &(Z(310)*Z(314)+Z(317)*Z(321)) + MLA*(Z(345)*Z(348)+Z(353)*Z(356)) 
     &+ MLA*(Z(390)*Z(393)+Z(398)*Z(401)) + MRF*(Z(217)*Z(220)+Z(225)*Z(
     &229)) + MSH*(Z(163)*Z(167)+Z(170)*Z(174)) + MSH*(Z(217)*Z(220)+Z(2
     &25)*Z(229)) + MTH*(Z(179)*Z(182)+Z(185)*Z(190)) + MTH*(Z(198)*Z(20
     &2)+Z(205)*Z(209)) + MUA*(Z(326)*Z(329)+Z(333)*Z(336)) + MUA*(Z(371
     &)*Z(374)+Z(378)*Z(381)) - 0.5D0*MRF*(LRFO*Z(17)*Z(42)-2*LFF*Z(42)-
     &LRFFO*Z(40)*Z(533)-LRFFO*Z(42)*Z(532)-LRFO*Z(18)*Z(40))
      Z(1192) = MFF*Z(40)*Z(423) + MFF*(Z(278)*Z(469)+Z(288)*Z(470)) + M
     &HAT*(Z(310)*Z(477)+Z(317)*Z(475)) + MLA*(Z(345)*Z(492)+Z(353)*Z(49
     &3)) + MLA*(Z(390)*Z(509)+Z(398)*Z(510)) + MSH*(Z(167)*Z(432)+Z(170
     &)*Z(431)) + MSH*(Z(217)*Z(450)+Z(225)*Z(451)) + MTH*(Z(179)*Z(436)
     &+Z(185)*Z(435)) + MTH*(Z(198)*Z(441)+Z(205)*Z(442)) + MUA*(Z(326)*
     &Z(483)+Z(333)*Z(484)) + MUA*(Z(371)*Z(500)+Z(378)*Z(501)) - 0.5D0*
     &MRF*(Z(17)*Z(40)*Z(425)+Z(18)*Z(42)*Z(425)-2*Z(40)*Z(424)-Z(40)*Z(
     &532)*Z(426)-Z(42)*Z(534)*Z(426)) - 0.5D0*MRF*(Z(535)*Z(456)*Z(225)
     &+Z(537)*Z(456)*Z(217)+2*Z(11)*Z(455)*Z(225)+2*Z(12)*Z(455)*Z(217)+
     &2*Z(12)*Z(225)*Z(458)-2*Z(217)*Z(453)-2*Z(225)*Z(454)-2*Z(11)*Z(21
     &7)*Z(458)-Z(535)*Z(217)*Z(459)-Z(536)*Z(225)*Z(459))
      Z(1199) = Z(1193) + MFF*(Z(282)**2+Z(298)**2) + MHAT*(Z(312)**2+Z(
     &322)**2) + MLA*(Z(349)**2+Z(363)**2) + MLA*(Z(394)**2+Z(408)**2) +
     & MSH*(Z(165)**2+Z(173)**2) + MSH*(Z(221)**2+Z(234)**2) + MTH*(Z(18
     &1)**2+Z(189)**2) + MTH*(Z(200)**2+Z(211)**2) + MUA*(Z(330)**2+Z(33
     &9)**2) + MUA*(Z(375)**2+Z(384)**2) + 0.25D0*MRF*(Z(1194)+4*Z(1195)
     &*Z(532)-4*Z(1196)*Z(17)) + 0.25D0*MRF*(Z(1197)+4*Z(221)**2+4*Z(238
     &)**2-4*Z(1198)-8*Z(91)*Z(11)*Z(238)-8*Z(91)*Z(12)*Z(221)-4*LRFFO*Z
     &(535)*Z(238)-4*LRFFO*Z(537)*Z(221))
      Z(1201) = Z(1200) + MFF*(Z(280)*Z(282)+Z(290)*Z(298)) + MHAT*(Z(31
     &2)*Z(313)+Z(319)*Z(322)) + MLA*(Z(347)*Z(349)+Z(355)*Z(363)) + MLA
     &*(Z(392)*Z(394)+Z(400)*Z(408)) + MSH*(Z(165)**2+Z(173)**2) + MSH*(
     &Z(219)*Z(221)+Z(228)*Z(234)) + MTH*(Z(181)**2+Z(187)*Z(189)) + MTH
     &*(Z(200)*Z(201)+Z(207)*Z(211)) + MUA*(Z(328)*Z(330)+Z(335)*Z(339))
     & + MUA*(Z(373)*Z(375)+Z(380)*Z(384)) + 0.25D0*MRF*(Z(1194)+4*Z(119
     &5)*Z(532)-4*Z(1196)*Z(17)) + 0.5D0*MRF*(2*Z(219)*Z(221)+2*Z(228)*Z
     &(238)-2*Z(91)*Z(11)*Z(228)-2*Z(91)*Z(12)*Z(219)-LRFFO*Z(535)*Z(228
     &)-LRFFO*Z(537)*Z(219))
      Z(1203) = MFF*(Z(281)*Z(282)+Z(291)*Z(298)) + MHAT*(Z(312)*Z(314)+
     &Z(321)*Z(322)) + MLA*(Z(348)*Z(349)+Z(356)*Z(363)) + MLA*(Z(393)*Z
     &(394)+Z(401)*Z(408)) + MSH*(Z(163)*Z(165)+Z(173)*Z(174)) + MSH*(Z(
     &220)*Z(221)+Z(229)*Z(234)) + MTH*(Z(181)*Z(182)+Z(189)*Z(190)) + M
     &TH*(Z(200)*Z(202)+Z(209)*Z(211)) + MUA*(Z(329)*Z(330)+Z(336)*Z(339
     &)) + MUA*(Z(374)*Z(375)+Z(381)*Z(384)) + 0.5D0*MRF*(2*Z(220)*Z(221
     &)+2*Z(229)*Z(238)-2*Z(91)*Z(11)*Z(229)-2*Z(91)*Z(12)*Z(220)-LRFFO*
     &Z(535)*Z(229)-LRFFO*Z(537)*Z(220)) - IFF - IRF - ISH - ITH - Z(120
     &2) - 0.25D0*MRF*(Z(1194)+4*Z(1195)*Z(532)-4*Z(1196)*Z(17))
      Z(1204) = MFF*(Z(279)*Z(282)+Z(289)*Z(298)) + MHAT*(Z(311)*Z(312)+
     &Z(318)*Z(322)) + MLA*(Z(346)*Z(349)+Z(354)*Z(363)) + MLA*(Z(391)*Z
     &(394)+Z(399)*Z(408)) + MSH*(Z(163)*Z(165)+Z(172)*Z(173)) + MSH*(Z(
     &218)*Z(221)+Z(226)*Z(234)) + MTH*(Z(180)*Z(181)+Z(186)*Z(189)) + M
     &TH*(Z(199)*Z(200)+Z(206)*Z(211)) + MUA*(Z(327)*Z(330)+Z(334)*Z(339
     &)) + MUA*(Z(372)*Z(375)+Z(379)*Z(384)) + 0.5D0*MRF*(2*Z(218)*Z(221
     &)+2*Z(226)*Z(238)-2*Z(91)*Z(11)*Z(226)-2*Z(91)*Z(12)*Z(218)-LRFFO*
     &Z(535)*Z(226)-LRFFO*Z(537)*Z(218)) - IFF - IRF - Z(1202) - 0.25D0*
     &MRF*(Z(1194)+4*Z(1195)*Z(532)-4*Z(1196)*Z(17))
      Z(1205) = MFF*(Z(276)*Z(282)+Z(286)*Z(298)) + MHAT*(Z(308)*Z(312)+
     &Z(315)*Z(322)) + MLA*(Z(343)*Z(349)+Z(351)*Z(363)) + MLA*(Z(388)*Z
     &(394)+Z(396)*Z(408)) + MSH*(Z(164)*Z(165)+Z(168)*Z(173)) + MSH*(Z(
     &215)*Z(221)+Z(223)*Z(234)) + MTH*(Z(177)*Z(181)+Z(183)*Z(189)) + M
     &TH*(Z(196)*Z(200)+Z(203)*Z(211)) + MUA*(Z(324)*Z(330)+Z(331)*Z(339
     &)) + MUA*(Z(369)*Z(375)+Z(376)*Z(384)) + 0.5D0*MRF*(2*Z(215)*Z(221
     &)+2*Z(223)*Z(238)-2*Z(91)*Z(11)*Z(223)-2*Z(91)*Z(12)*Z(215)-LRFFO*
     &Z(535)*Z(223)-LRFFO*Z(537)*Z(215)) - IFF - Z(1202) - 0.5D0*Z(983)*
     &(2*LFF+LRFFO*Z(532)-LRFO*Z(17))
      Z(1211) = Z(1163) + Z(1172) + Z(1173) + Z(1174) + Z(1175) + MFF*(Z
     &(282)*Z(469)+Z(298)*Z(470)) + MHAT*(Z(312)*Z(477)+Z(322)*Z(475)) +
     & MLA*(Z(349)*Z(492)+Z(363)*Z(493)) + MLA*(Z(394)*Z(509)+Z(408)*Z(5
     &10)) + MSH*(Z(165)*Z(432)+Z(173)*Z(431)) + MSH*(Z(221)*Z(450)+Z(23
     &4)*Z(451)) + MTH*(Z(181)*Z(436)+Z(189)*Z(435)) + MTH*(Z(200)*Z(441
     &)+Z(211)*Z(442)) + MUA*(Z(330)*Z(483)+Z(339)*Z(484)) + MUA*(Z(375)
     &*Z(500)+Z(384)*Z(501)) + 0.25D0*MRF*(Z(1206)*Z(425)+2*LFF*Z(18)*Z(
     &425)-Z(1207)*Z(426)-2*LFF*Z(534)*Z(426)-2*LRFFO*Z(533)*Z(424)-2*LR
     &FO*Z(18)*Z(424)) - Z(1171) - Z(1176) - Z(1177) - 0.25D0*MRF*(2*Z(1
     &208)*Z(455)+2*Z(1209)*Z(456)+2*Z(535)*Z(456)*Z(238)+2*Z(537)*Z(456
     &)*Z(221)+4*Z(11)*Z(455)*Z(238)+4*Z(12)*Z(455)*Z(221)+2*Z(1206)*Z(4
     &58)+2*LRFFO*Z(535)*Z(454)+2*LRFFO*Z(537)*Z(453)+4*Z(91)*Z(11)*Z(45
     &4)+4*Z(91)*Z(12)*Z(453)+4*Z(12)*Z(238)*Z(458)-4*Z(91)*Z(455)-LRFFO
     &*Z(456)-4*Z(221)*Z(453)-4*Z(238)*Z(454)-2*Z(1210)*Z(459)-4*Z(11)*Z
     &(221)*Z(458)-2*Z(535)*Z(221)*Z(459)-2*Z(536)*Z(238)*Z(459))
      Z(1212) = MFF*(Z(280)*Z(281)+Z(290)*Z(291)) + MHAT*(Z(313)*Z(314)+
     &Z(319)*Z(321)) + MLA*(Z(347)*Z(348)+Z(355)*Z(356)) + MLA*(Z(392)*Z
     &(393)+Z(400)*Z(401)) + MRF*(Z(219)*Z(220)+Z(228)*Z(229)) + MSH*(Z(
     &163)*Z(165)+Z(173)*Z(174)) + MSH*(Z(219)*Z(220)+Z(228)*Z(229)) + M
     &TH*(Z(181)*Z(182)+Z(187)*Z(190)) + MTH*(Z(201)*Z(202)+Z(207)*Z(209
     &)) + MUA*(Z(328)*Z(329)+Z(335)*Z(336)) + MUA*(Z(373)*Z(374)+Z(380)
     &*Z(381)) - IFF - IRF - ISH - Z(1202) - 0.25D0*MRF*(Z(1194)+4*Z(119
     &5)*Z(532)-4*Z(1196)*Z(17))
      Z(1214) = Z(1213) + MFF*(Z(281)**2+Z(291)**2) + MHAT*(Z(314)**2+Z(
     &321)**2) + MLA*(Z(348)**2+Z(356)**2) + MLA*(Z(393)**2+Z(401)**2) +
     & MRF*(Z(220)**2+Z(229)**2) + MSH*(Z(163)**2+Z(174)**2) + MSH*(Z(22
     &0)**2+Z(229)**2) + MTH*(Z(182)**2+Z(190)**2) + MTH*(Z(202)**2+Z(20
     &9)**2) + MUA*(Z(329)**2+Z(336)**2) + MUA*(Z(374)**2+Z(381)**2) + 0
     &.25D0*MRF*(Z(1194)+4*Z(1195)*Z(532)-4*Z(1196)*Z(17))
      Z(1216) = Z(1215) + MFF*(Z(279)*Z(281)+Z(289)*Z(291)) + MHAT*(Z(31
     &1)*Z(314)+Z(318)*Z(321)) + MLA*(Z(346)*Z(348)+Z(354)*Z(356)) + MLA
     &*(Z(391)*Z(393)+Z(399)*Z(401)) + MRF*(Z(218)*Z(220)+Z(226)*Z(229))
     & + MSH*(Z(163)**2+Z(172)*Z(174)) + MSH*(Z(218)*Z(220)+Z(226)*Z(229
     &)) + MTH*(Z(180)*Z(182)+Z(186)*Z(190)) + MTH*(Z(199)*Z(202)+Z(206)
     &*Z(209)) + MUA*(Z(327)*Z(329)+Z(334)*Z(336)) + MUA*(Z(372)*Z(374)+
     &Z(379)*Z(381)) + 0.25D0*MRF*(Z(1194)+4*Z(1195)*Z(532)-4*Z(1196)*Z(
     &17))
      Z(1218) = Z(1217) + MFF*(Z(276)*Z(281)+Z(286)*Z(291)) + MHAT*(Z(30
     &8)*Z(314)+Z(315)*Z(321)) + MLA*(Z(343)*Z(348)+Z(351)*Z(356)) + MLA
     &*(Z(388)*Z(393)+Z(396)*Z(401)) + MRF*(Z(215)*Z(220)+Z(223)*Z(229))
     & + MSH*(Z(163)*Z(164)+Z(168)*Z(174)) + MSH*(Z(215)*Z(220)+Z(223)*Z
     &(229)) + MTH*(Z(177)*Z(182)+Z(183)*Z(190)) + MTH*(Z(196)*Z(202)+Z(
     &203)*Z(209)) + MUA*(Z(324)*Z(329)+Z(331)*Z(336)) + MUA*(Z(369)*Z(3
     &74)+Z(376)*Z(381)) + 0.5D0*Z(983)*(2*LFF+LRFFO*Z(532)-LRFO*Z(17))
      Z(1219) = MFF*(Z(281)*Z(469)+Z(291)*Z(470)) + MHAT*(Z(314)*Z(477)+
     &Z(321)*Z(475)) + MLA*(Z(348)*Z(492)+Z(356)*Z(493)) + MLA*(Z(393)*Z
     &(509)+Z(401)*Z(510)) + MSH*(Z(163)*Z(432)+Z(174)*Z(431)) + MSH*(Z(
     &220)*Z(450)+Z(229)*Z(451)) + MTH*(Z(182)*Z(436)+Z(190)*Z(435)) + M
     &TH*(Z(202)*Z(441)+Z(209)*Z(442)) + MUA*(Z(329)*Z(483)+Z(336)*Z(484
     &)) + MUA*(Z(374)*Z(500)+Z(381)*Z(501)) - 0.25D0*MRF*(Z(1206)*Z(425
     &)+2*LFF*Z(18)*Z(425)-Z(1207)*Z(426)-2*LFF*Z(534)*Z(426)-2*LRFFO*Z(
     &533)*Z(424)-2*LRFO*Z(18)*Z(424)) - 0.5D0*MRF*(Z(535)*Z(456)*Z(229)
     &+Z(537)*Z(456)*Z(220)+2*Z(11)*Z(455)*Z(229)+2*Z(12)*Z(455)*Z(220)+
     &2*Z(12)*Z(229)*Z(458)-2*Z(220)*Z(453)-2*Z(229)*Z(454)-2*Z(11)*Z(22
     &0)*Z(458)-Z(535)*Z(220)*Z(459)-Z(536)*Z(229)*Z(459))
      Z(1220) = Z(1200) + MFF*(Z(280)**2+Z(290)**2) + MHAT*(Z(313)**2+Z(
     &319)**2) + MLA*(Z(347)**2+Z(355)**2) + MLA*(Z(392)**2+Z(400)**2) +
     & MRF*(Z(219)**2+Z(228)**2) + MSH*(Z(165)**2+Z(173)**2) + MSH*(Z(21
     &9)**2+Z(228)**2) + MTH*(Z(181)**2+Z(187)**2) + MTH*(Z(201)**2+Z(20
     &7)**2) + MUA*(Z(328)**2+Z(335)**2) + MUA*(Z(373)**2+Z(380)**2) + 0
     &.25D0*MRF*(Z(1194)+4*Z(1195)*Z(532)-4*Z(1196)*Z(17))
      Z(1221) = MFF*(Z(279)*Z(280)+Z(289)*Z(290)) + MHAT*(Z(311)*Z(313)+
     &Z(318)*Z(319)) + MLA*(Z(346)*Z(347)+Z(354)*Z(355)) + MLA*(Z(391)*Z
     &(392)+Z(399)*Z(400)) + MRF*(Z(218)*Z(219)+Z(226)*Z(228)) + MSH*(Z(
     &163)*Z(165)+Z(172)*Z(173)) + MSH*(Z(218)*Z(219)+Z(226)*Z(228)) + M
     &TH*(Z(180)*Z(181)+Z(186)*Z(187)) + MTH*(Z(199)*Z(201)+Z(206)*Z(207
     &)) + MUA*(Z(327)*Z(328)+Z(334)*Z(335)) + MUA*(Z(372)*Z(373)+Z(379)
     &*Z(380)) - IFF - IRF - Z(1202) - 0.25D0*MRF*(Z(1194)+4*Z(1195)*Z(5
     &32)-4*Z(1196)*Z(17))
      Z(1222) = MFF*(Z(276)*Z(280)+Z(286)*Z(290)) + MHAT*(Z(308)*Z(313)+
     &Z(315)*Z(319)) + MLA*(Z(343)*Z(347)+Z(351)*Z(355)) + MLA*(Z(388)*Z
     &(392)+Z(396)*Z(400)) + MRF*(Z(215)*Z(219)+Z(223)*Z(228)) + MSH*(Z(
     &164)*Z(165)+Z(168)*Z(173)) + MSH*(Z(215)*Z(219)+Z(223)*Z(228)) + M
     &TH*(Z(177)*Z(181)+Z(183)*Z(187)) + MTH*(Z(196)*Z(201)+Z(203)*Z(207
     &)) + MUA*(Z(324)*Z(328)+Z(331)*Z(335)) + MUA*(Z(369)*Z(373)+Z(376)
     &*Z(380)) - IFF - Z(1202) - 0.5D0*Z(983)*(2*LFF+LRFFO*Z(532)-LRFO*Z
     &(17))
      Z(1223) = MFF*(Z(280)*Z(469)+Z(290)*Z(470)) + MHAT*(Z(313)*Z(477)+
     &Z(319)*Z(475)) + MLA*(Z(347)*Z(492)+Z(355)*Z(493)) + MLA*(Z(392)*Z
     &(509)+Z(400)*Z(510)) + MSH*(Z(165)*Z(432)+Z(173)*Z(431)) + MSH*(Z(
     &219)*Z(450)+Z(228)*Z(451)) + MTH*(Z(181)*Z(436)+Z(187)*Z(435)) + M
     &TH*(Z(201)*Z(441)+Z(207)*Z(442)) + MUA*(Z(328)*Z(483)+Z(335)*Z(484
     &)) + MUA*(Z(373)*Z(500)+Z(380)*Z(501)) + 0.25D0*MRF*(Z(1206)*Z(425
     &)+2*LFF*Z(18)*Z(425)-Z(1207)*Z(426)-2*LFF*Z(534)*Z(426)-2*LRFFO*Z(
     &533)*Z(424)-2*LRFO*Z(18)*Z(424)) - 0.5D0*MRF*(Z(535)*Z(456)*Z(228)
     &+Z(537)*Z(456)*Z(219)+2*Z(11)*Z(455)*Z(228)+2*Z(12)*Z(455)*Z(219)+
     &2*Z(12)*Z(228)*Z(458)-2*Z(219)*Z(453)-2*Z(228)*Z(454)-2*Z(11)*Z(21
     &9)*Z(458)-Z(535)*Z(219)*Z(459)-Z(536)*Z(228)*Z(459))
      Z(1224) = Z(1215) + MFF*(Z(279)**2+Z(289)**2) + MHAT*(Z(311)**2+Z(
     &318)**2) + MLA*(Z(346)**2+Z(354)**2) + MLA*(Z(391)**2+Z(399)**2) +
     & MRF*(Z(218)**2+Z(226)**2) + MSH*(Z(163)**2+Z(172)**2) + MSH*(Z(21
     &8)**2+Z(226)**2) + MTH*(Z(180)**2+Z(186)**2) + MTH*(Z(199)**2+Z(20
     &6)**2) + MUA*(Z(327)**2+Z(334)**2) + MUA*(Z(372)**2+Z(379)**2) + 0
     &.25D0*MRF*(Z(1194)+4*Z(1195)*Z(532)-4*Z(1196)*Z(17))
      Z(1225) = Z(1217) + MFF*(Z(276)*Z(279)+Z(286)*Z(289)) + MHAT*(Z(30
     &8)*Z(311)+Z(315)*Z(318)) + MLA*(Z(343)*Z(346)+Z(351)*Z(354)) + MLA
     &*(Z(388)*Z(391)+Z(396)*Z(399)) + MRF*(Z(215)*Z(218)+Z(223)*Z(226))
     & + MSH*(Z(163)*Z(164)+Z(168)*Z(172)) + MSH*(Z(215)*Z(218)+Z(223)*Z
     &(226)) + MTH*(Z(177)*Z(180)+Z(183)*Z(186)) + MTH*(Z(196)*Z(199)+Z(
     &203)*Z(206)) + MUA*(Z(324)*Z(327)+Z(331)*Z(334)) + MUA*(Z(369)*Z(3
     &72)+Z(376)*Z(379)) + 0.5D0*Z(983)*(2*LFF+LRFFO*Z(532)-LRFO*Z(17))
      Z(1226) = MFF*(Z(279)*Z(469)+Z(289)*Z(470)) + MHAT*(Z(311)*Z(477)+
     &Z(318)*Z(475)) + MLA*(Z(346)*Z(492)+Z(354)*Z(493)) + MLA*(Z(391)*Z
     &(509)+Z(399)*Z(510)) + MSH*(Z(163)*Z(432)+Z(172)*Z(431)) + MSH*(Z(
     &218)*Z(450)+Z(226)*Z(451)) + MTH*(Z(180)*Z(436)+Z(186)*Z(435)) + M
     &TH*(Z(199)*Z(441)+Z(206)*Z(442)) + MUA*(Z(327)*Z(483)+Z(334)*Z(484
     &)) + MUA*(Z(372)*Z(500)+Z(379)*Z(501)) - 0.25D0*MRF*(Z(1206)*Z(425
     &)+2*LFF*Z(18)*Z(425)-Z(1207)*Z(426)-2*LFF*Z(534)*Z(426)-2*LRFFO*Z(
     &533)*Z(424)-2*LRFO*Z(18)*Z(424)) - 0.5D0*MRF*(Z(535)*Z(456)*Z(226)
     &+Z(537)*Z(456)*Z(218)+2*Z(11)*Z(455)*Z(226)+2*Z(12)*Z(455)*Z(218)+
     &2*Z(12)*Z(226)*Z(458)-2*Z(218)*Z(453)-2*Z(226)*Z(454)-2*Z(11)*Z(21
     &8)*Z(458)-Z(535)*Z(218)*Z(459)-Z(536)*Z(226)*Z(459))
      Z(1228) = Z(1227) + MFF*(Z(276)**2+Z(286)**2) + MHAT*(Z(308)**2+Z(
     &315)**2) + MLA*(Z(343)**2+Z(351)**2) + MLA*(Z(388)**2+Z(396)**2) +
     & MRF*(Z(215)**2+Z(223)**2) + MSH*(Z(164)**2+Z(168)**2) + MSH*(Z(21
     &5)**2+Z(223)**2) + MTH*(Z(177)**2+Z(183)**2) + MTH*(Z(196)**2+Z(20
     &3)**2) + MUA*(Z(324)**2+Z(331)**2) + MUA*(Z(369)**2+Z(376)**2)
      Z(1229) = MFF*(Z(276)*Z(469)+Z(286)*Z(470)) + MHAT*(Z(308)*Z(477)+
     &Z(315)*Z(475)) + MLA*(Z(343)*Z(492)+Z(351)*Z(493)) + MLA*(Z(388)*Z
     &(509)+Z(396)*Z(510)) + MSH*(Z(164)*Z(432)+Z(168)*Z(431)) + MSH*(Z(
     &215)*Z(450)+Z(223)*Z(451)) + MTH*(Z(177)*Z(436)+Z(183)*Z(435)) + M
     &TH*(Z(196)*Z(441)+Z(203)*Z(442)) + MUA*(Z(324)*Z(483)+Z(331)*Z(484
     &)) + MUA*(Z(369)*Z(500)+Z(376)*Z(501)) - 0.5D0*Z(983)*(Z(18)*Z(425
     &)-Z(534)*Z(426)) - 0.5D0*MRF*(Z(535)*Z(456)*Z(223)+Z(537)*Z(456)*Z
     &(215)+2*Z(11)*Z(455)*Z(223)+2*Z(12)*Z(455)*Z(215)+2*Z(12)*Z(223)*Z
     &(458)-2*Z(215)*Z(453)-2*Z(223)*Z(454)-2*Z(11)*Z(215)*Z(458)-Z(535)
     &*Z(215)*Z(459)-Z(536)*Z(223)*Z(459))
      Z(1293) = Z(1140) - Z(1185)
      Z(1294) = Z(1141) - Z(1192)
      Z(1296) = Z(1144) - Z(1219)
      Z(1297) = Z(1145) - Z(1223)
      Z(1298) = Z(1146) - Z(1226)
      Z(1299) = Z(1148) - Z(1229)
      Z(1312) = LHTQ + Z(523) + Z(525) + Z(527) + VRX1*Z(72)*Z(282) + VR
     &X1*Z(74)*Z(304) + VRX2*Z(64)*Z(256) + VRX2*Z(66)*Z(269) + VRY1*Z(7
     &3)*Z(282) + VRY1*Z(75)*Z(304) + VRY2*Z(65)*Z(256) + VRY2*Z(67)*Z(2
     &69) + Z(514)*(Z(1)*Z(322)+Z(2)*Z(312)) + Z(515)*(Z(73)*Z(282)+Z(75
     &)*Z(298)) + Z(516)*(Z(80)*Z(349)+Z(82)*Z(363)) + Z(516)*(Z(87)*Z(3
     &94)+Z(89)*Z(408)) + Z(518)*(Z(36)*Z(165)+Z(38)*Z(173)) + Z(518)*(Z
     &(61)*Z(221)+Z(63)*Z(234)) + Z(519)*(Z(54)*Z(189)+Z(55)*Z(181)) + Z
     &(519)*(Z(57)*Z(211)+Z(58)*Z(200)) + Z(520)*(Z(76)*Z(339)+Z(77)*Z(3
     &30)) + Z(520)*(Z(83)*Z(384)+Z(84)*Z(375)) - LMTQ - Z(1142)*Z(42) -
     & LFF*(RX2*Z(41)+RY2*Z(42)) - 0.5D0*Z(517)*(LRFFO*Z(49)+LRFO*Z(53)+
     &2*LFF*Z(42)) - 0.5D0*Z(517)*(LRFFO*Z(71)-2*Z(91)*Z(67)-2*Z(61)*Z(2
     &21)-2*Z(63)*Z(238)) - Z(1211)

      COEF(1,1) = -Z(1179)
      COEF(1,2) = -Z(1180)
      COEF(1,3) = -Z(1182)
      COEF(1,4) = -Z(1184)
      COEF(1,5) = -Z(1183)
      COEF(1,6) = -Z(1181)
      COEF(1,7) = -Z(1178)
      COEF(2,1) = -Z(1180)
      COEF(2,2) = -Z(1187)
      COEF(2,3) = -Z(1189)
      COEF(2,4) = -Z(1191)
      COEF(2,5) = -Z(1190)
      COEF(2,6) = -Z(1188)
      COEF(2,7) = -Z(1186)
      COEF(3,1) = -Z(1182)
      COEF(3,2) = -Z(1189)
      COEF(3,3) = -Z(1199)
      COEF(3,4) = -Z(1203)
      COEF(3,5) = -Z(1201)
      COEF(3,6) = -Z(1204)
      COEF(3,7) = -Z(1205)
      COEF(4,1) = -Z(1184)
      COEF(4,2) = -Z(1191)
      COEF(4,3) = -Z(1203)
      COEF(4,4) = -Z(1214)
      COEF(4,5) = -Z(1212)
      COEF(4,6) = -Z(1216)
      COEF(4,7) = -Z(1218)
      COEF(5,1) = -Z(1183)
      COEF(5,2) = -Z(1190)
      COEF(5,3) = -Z(1201)
      COEF(5,4) = -Z(1212)
      COEF(5,5) = -Z(1220)
      COEF(5,6) = -Z(1221)
      COEF(5,7) = -Z(1222)
      COEF(6,1) = -Z(1181)
      COEF(6,2) = -Z(1188)
      COEF(6,3) = -Z(1204)
      COEF(6,4) = -Z(1216)
      COEF(6,5) = -Z(1221)
      COEF(6,6) = -Z(1224)
      COEF(6,7) = -Z(1225)
      COEF(7,1) = -Z(1178)
      COEF(7,2) = -Z(1186)
      COEF(7,3) = -Z(1205)
      COEF(7,4) = -Z(1218)
      COEF(7,5) = -Z(1222)
      COEF(7,6) = -Z(1225)
      COEF(7,7) = -Z(1228)
      RHS(1) = -Z(1293)
      RHS(2) = -Z(1294)
      RHS(3) = -Z(1312)
      RHS(4) = -Z(1296)
      RHS(5) = -Z(1297)
      RHS(6) = -Z(1298)
      RHS(7) = -Z(1299)
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
      COMMON/CONSTNTS/ AE,AF,FOOTANG,G,HE,HF,IFF,IHAT,ILA,IRF,ISH,ITH,IU
     &A,K1,K2,K3,K4,K5,K6,K7,K8,KE,KF,LFF,LFFO,LHAT,LHATO,LLA,LLAO,LRF,L
     &RFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,LUA,LUAO,MFF,MHAT,MLA,MRF,MSH,MTH
     &,MTPB,MTPK,MTPXI,MUA,TOEXI
      COMMON/SPECFIED/ LE,LS,RA,RE,RH,RK,RMTP,RS,LEp,LSp,RAp,REp,RHp,RKp
     &,RMTPp,RSp,LEpp,LSpp,RApp,REpp,RHpp,RKpp,RMTPpp,RSpp
      COMMON/VARIBLES/ Q1,Q2,Q3,Q4,Q5,Q6,Q7,U1,U2,U3,U4,U5,U6,U7
      COMMON/ALGBRAIC/ HZ,KECM,LA,LETQ,LH,LK,LMTP,LSTQ,PX,PY,RATQ,RETQ,R
     &HTQ,RKTQ,RSTQ,RX1,RX2,RY1,RY2,U10,U11,U12,U13,U14,U8,U9,VRX1,VRX2,
     &VRY1,VRY2,LAp,LHp,LKp,LMTPp,Q1p,Q2p,Q3p,Q4p,Q5p,Q6p,Q7p,U1p,U2p,U3
     &p,U4p,U5p,U6p,U7p,LApp,LHpp,LKpp,LMTPpp,LATQ,LHTQ,LKTQ,LMTQ,DLX1,D
     &LX2,POCMX,POCMY,POP10X,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP13X,P
     &OP13Y,POP14X,POP14Y,POP15X,POP15Y,POP16X,POP16Y,POP1X,POP1Y,POP2X,
     &POP2Y,POP3X,POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,
     &POP8X,POP8Y,POP9X,POP9Y,RMTQ,RX,RY,VOCMX,VOCMY,VOP2X,VOP2Y,VRX,VRY
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(1312),COEF(7,7),RHS(7)

C**   Evaluate output quantities
      LH = Q4
      LHp = U4
      LHpp = U4p
      LK = Q5
      LKp = U5
      LKpp = U5p
      LA = Q6
      LAp = U6
      LApp = U6p
      LMTP = Q7
      LMTPp = U7
      LMTPpp = U7p
      Z(231) = Z(7)*Z(212)
      Z(240) = Z(231) + Z(237)
      Z(222) = Z(8)*Z(212)
      Z(267) = -Z(11)*Z(240) - Z(12)*Z(222)
      Z(272) = Z(267) + Z(268)
      Z(257) = Z(12)*Z(240) - Z(11)*Z(222)
      Z(283) = Z(16)*Z(272) - Z(15)*Z(257)
      Z(273) = LRF*Z(16)
      Z(214) = LTH*Z(8)
      Z(230) = LTH*Z(7)
      Z(239) = LSH - Z(230)
      Z(258) = Z(12)*Z(214) - Z(11)*Z(239)
      Z(270) = LRF + Z(258)
      Z(249) = Z(11)*Z(214) + Z(12)*Z(239)
      Z(274) = Z(16)*Z(270) - Z(15)*Z(249)
      Z(266) = LSH*Z(11)
      Z(271) = LRF - Z(266)
      Z(248) = LSH*Z(12)
      Z(275) = Z(16)*Z(271) - Z(15)*Z(248)
      Z(294) = -Z(15)*Z(272) - Z(16)*Z(257)
      Z(301) = Z(294) + Z(296)
      Z(293) = LRF*Z(15)
      Z(297) = Z(90) - Z(293)
      Z(285) = -Z(15)*Z(270) - Z(16)*Z(249)
      Z(299) = Z(90) + Z(285)
      Z(284) = -Z(15)*Z(271) - Z(16)*Z(248)
      Z(300) = Z(90) + Z(284)
      Z(359) = Z(23)*Z(340)
      Z(364) = Z(359) + Z(361)
      Z(358) = LUA*Z(23)
      Z(362) = LLAO - Z(358)
      Z(342) = LUA*Z(24)
      Z(350) = Z(24)*Z(340)
      Z(404) = Z(25)*Z(385)
      Z(409) = Z(404) + Z(406)
      Z(403) = LUA*Z(25)
      Z(407) = LLAO - Z(403)
      Z(387) = LUA*Z(26)
      Z(395) = Z(26)*Z(385)
      Z(236) = Z(231) + Z(233)
      Z(235) = Z(92) - Z(230)
      KECM = 0.5D0*IHAT*U3**2 + 0.5D0*ITH*(U3-U4)**2 + 0.5D0*ISH*(U4-U3-
     &U5)**2 + 0.5D0*ITH*(RHp-U3-U8)**2 + 0.5D0*IUA*(LSp-U12-U3)**2 + 0.
     &5D0*IUA*(RSp-U11-U3)**2 + 0.5D0*IRF*(U3+U5-U4-U6)**2 + 0.5D0*IFF*(
     &U3+U5-U4-U6-U7)**2 + 0.5D0*ILA*(LSp-LEp-U12-U14-U3)**2 + 0.5D0*ILA
     &*(RSp-REp-U11-U13-U3)**2 + 0.5D0*ISH*(RHp-RKp-U3-U8-U9)**2 + 0.5D0
     &*IRF*(RAp+RHp-RKp-U10-U3-U8-U9)**2 + 0.5D0*IFF*(RAp+RHp+RMTPp-RKp-
     &U10-U3-U8-U9)**2 + 0.5D0*MFF*((Z(39)*U1+Z(40)*U2)**2+(LFFO*U3+LFFO
     &*U5-LFFO*U4-LFFO*U6-LFFO*U7-Z(41)*U1-Z(42)*U2)**2) + 0.5D0*MHAT*((
     &Z(308)*U7+Z(309)*U1+Z(310)*U2+Z(311)*U6+Z(312)*U3+Z(313)*U5+Z(314)
     &*U4)**2+(Z(315)*U7+Z(316)*U1+Z(317)*U2+Z(318)*U6+Z(319)*U5+Z(321)*
     &U4+Z(322)*U3)**2) + 0.5D0*MSH*((Z(163)*U4+Z(163)*U6+Z(164)*U7+Z(16
     &5)*U3+Z(165)*U5+Z(166)*U1+Z(167)*U2)**2+(Z(168)*U7+Z(169)*U1+Z(170
     &)*U2+Z(172)*U6+Z(173)*U3+Z(173)*U5+Z(174)*U4)**2) + 0.5D0*MTH*((Z(
     &177)*U7+Z(178)*U1+Z(179)*U2+Z(180)*U6+Z(181)*U3+Z(181)*U5+Z(182)*U
     &4)**2+(Z(183)*U7+Z(184)*U1+Z(185)*U2+Z(186)*U6+Z(187)*U5+Z(189)*U3
     &+Z(190)*U4)**2) + 0.5D0*MTH*((Z(196)*U7+Z(197)*U1+Z(198)*U2+Z(199)
     &*U6+Z(200)*U3+Z(201)*U5+Z(202)*U4)**2+(Z(210)-Z(93)*U8-Z(203)*U7-Z
     &(204)*U1-Z(205)*U2-Z(206)*U6-Z(207)*U5-Z(209)*U4-Z(211)*U3)**2) + 
     &0.5D0*MUA*((Z(324)*U7+Z(325)*U1+Z(326)*U2+Z(327)*U6+Z(328)*U5+Z(32
     &9)*U4+Z(330)*U3)**2+(Z(338)-LUAO*U11-Z(331)*U7-Z(332)*U1-Z(333)*U2
     &-Z(334)*U6-Z(335)*U5-Z(336)*U4-Z(339)*U3)**2) + 0.5D0*MUA*((Z(369)
     &*U7+Z(370)*U1+Z(371)*U2+Z(372)*U6+Z(373)*U5+Z(374)*U4+Z(375)*U3)**
     &2+(Z(383)-LUAO*U12-Z(376)*U7-Z(377)*U1-Z(378)*U2-Z(379)*U6-Z(380)*
     &U5-Z(381)*U4-Z(384)*U3)**2) + 0.5D0*MFF*((Z(283)+Z(273)*U10+Z(274)
     &*U8+Z(275)*U9+Z(276)*U7+Z(277)*U1+Z(278)*U2+Z(279)*U6+Z(280)*U5+Z(
     &281)*U4+Z(282)*U3)**2+(Z(301)+Z(297)*U10+Z(299)*U8+Z(300)*U9+Z(286
     &)*U7+Z(287)*U1+Z(288)*U2+Z(289)*U6+Z(290)*U5+Z(291)*U4+Z(298)*U3)*
     &*2) + 0.5D0*MLA*((Z(364)+LLAO*U13+Z(362)*U11+Z(351)*U7+Z(352)*U1+Z
     &(353)*U2+Z(354)*U6+Z(355)*U5+Z(356)*U4+Z(363)*U3)**2+(Z(342)*U11-Z
     &(350)-Z(343)*U7-Z(344)*U1-Z(345)*U2-Z(346)*U6-Z(347)*U5-Z(348)*U4-
     &Z(349)*U3)**2) + 0.5D0*MLA*((Z(409)+LLAO*U14+Z(407)*U12+Z(396)*U7+
     &Z(397)*U1+Z(398)*U2+Z(399)*U6+Z(400)*U5+Z(401)*U4+Z(408)*U3)**2+(Z
     &(387)*U12-Z(395)-Z(388)*U7-Z(389)*U1-Z(390)*U2-Z(391)*U6-Z(392)*U5
     &-Z(393)*U4-Z(394)*U3)**2) + 0.5D0*MSH*((Z(236)+Z(92)*U9+Z(235)*U8+
     &Z(223)*U7+Z(224)*U1+Z(225)*U2+Z(226)*U6+Z(228)*U5+Z(229)*U4+Z(234)
     &*U3)**2+(Z(214)*U8-Z(222)-Z(215)*U7-Z(216)*U1-Z(217)*U2-Z(218)*U6-
     &Z(219)*U5-Z(220)*U4-Z(221)*U3)**2) + 0.125D0*MRF*(4*(Z(39)*U1+Z(40
     &)*U2)**2+LRFFO**2*(U3+U5-U4-U6)**2+LRFO**2*(U3+U5-U4-U6)**2+2*LRFF
     &O*LRFO*Z(27)*(U3+U5-U4-U6)**2+4*(LFF*U3+LFF*U5-LFF*U4-LFF*U6-LFF*U
     &7-Z(41)*U1-Z(42)*U2)**2+4*LRFFO*Z(532)*(U3+U5-U4-U6)*(LFF*U3+LFF*U
     &5-LFF*U4-LFF*U6-LFF*U7-Z(41)*U1-Z(42)*U2)-4*LRFFO*Z(533)*(Z(39)*U1
     &+Z(40)*U2)*(U3+U5-U4-U6)-4*LRFO*Z(18)*(Z(39)*U1+Z(40)*U2)*(U3+U5-U
     &4-U6)-4*LRFO*Z(17)*(U3+U5-U4-U6)*(LFF*U3+LFF*U5-LFF*U4-LFF*U6-LFF*
     &U7-Z(41)*U1-Z(42)*U2)) - 0.125D0*MRF*(4*Z(27)*(Z(246)+Z(91)*U10+Z(
     &91)*U3+Z(91)*U8+Z(91)*U9)*(Z(247)+LRFFO*U10+LRFFO*U3+LRFFO*U8+LRFF
     &O*U9)+4*Z(535)*(Z(247)+LRFFO*U10+LRFFO*U3+LRFFO*U8+LRFFO*U9)*(Z(24
     &0)+LSH*U9+Z(239)*U8+Z(223)*U7+Z(224)*U1+Z(225)*U2+Z(226)*U6+Z(228)
     &*U5+Z(229)*U4+Z(238)*U3)+8*Z(11)*(Z(246)+Z(91)*U10+Z(91)*U3+Z(91)*
     &U8+Z(91)*U9)*(Z(240)+LSH*U9+Z(239)*U8+Z(223)*U7+Z(224)*U1+Z(225)*U
     &2+Z(226)*U6+Z(228)*U5+Z(229)*U4+Z(238)*U3)-4*(Z(246)+Z(91)*U10+Z(9
     &1)*U3+Z(91)*U8+Z(91)*U9)**2-(Z(247)+LRFFO*U10+LRFFO*U3+LRFFO*U8+LR
     &FFO*U9)**2-4*(Z(240)+LSH*U9+Z(239)*U8+Z(223)*U7+Z(224)*U1+Z(225)*U
     &2+Z(226)*U6+Z(228)*U5+Z(229)*U4+Z(238)*U3)**2-4*(Z(214)*U8-Z(222)-
     &Z(215)*U7-Z(216)*U1-Z(217)*U2-Z(218)*U6-Z(219)*U5-Z(220)*U4-Z(221)
     &*U3)**2-8*Z(12)*(Z(246)+Z(91)*U10+Z(91)*U3+Z(91)*U8+Z(91)*U9)*(Z(2
     &14)*U8-Z(222)-Z(215)*U7-Z(216)*U1-Z(217)*U2-Z(218)*U6-Z(219)*U5-Z(
     &220)*U4-Z(221)*U3)-4*Z(537)*(Z(247)+LRFFO*U10+LRFFO*U3+LRFFO*U8+LR
     &FFO*U9)*(Z(214)*U8-Z(222)-Z(215)*U7-Z(216)*U1-Z(217)*U2-Z(218)*U6-
     &Z(219)*U5-Z(220)*U4-Z(221)*U3))
      Z(538) = ILA*Z(405)
      Z(540) = IFF*Z(295)
      Z(541) = ILA*Z(360)
      Z(542) = IRF*Z(241)
      Z(543) = ISH*Z(232)
      Z(44) = Z(27)*Z(14) - Z(28)*Z(13)
      Z(46) = Z(35)*Z(43) + Z(37)*Z(44)
      Z(47) = Z(36)*Z(43) + Z(38)*Z(44)
      Z(151) = Z(1)*Z(46) + Z(2)*Z(47)
      Z(68) = Z(27)*Z(64) + Z(28)*Z(66)
      Z(69) = Z(27)*Z(65) + Z(28)*Z(67)
      Z(242) = Z(1)*Z(68) + Z(2)*Z(69)
      Z(78) = Z(19)*Z(2) - Z(20)*Z(1)
      Z(79) = -Z(23)*Z(76) - Z(24)*Z(78)
      Z(141) = Z(1)*Z(79) + Z(2)*Z(80)
      Z(85) = Z(21)*Z(2) - Z(22)*Z(1)
      Z(86) = -Z(25)*Z(83) - Z(26)*Z(85)
      Z(147) = Z(1)*Z(86) + Z(2)*Z(87)
      Z(128) = Z(1)*Z(72) + Z(2)*Z(73)
      Z(117) = Z(1)*Z(64) + Z(2)*Z(65)
      Z(110) = Z(1)*Z(60) + Z(2)*Z(61)
      Z(133) = Z(1)*Z(39) + Z(2)*Z(40)
      Z(50) = Z(14)*Z(37) - Z(13)*Z(35)
      Z(51) = Z(14)*Z(38) - Z(13)*Z(36)
      Z(122) = Z(1)*Z(50) + Z(2)*Z(51)
      Z(550) = LHATO + Z(102)*Z(19) + Z(102)*Z(21) + 0.5D0*Z(99)*Z(151) 
     &+ 0.5D0*Z(99)*Z(242) - Z(95) - Z(106)*Z(3) - Z(97)*Z(141) - Z(97)*
     &Z(147) - Z(103)*Z(128) - Z(104)*Z(117) - Z(105)*Z(110) - Z(546)*Z(
     &133) - Z(547)*Z(32) - Z(548)*Z(5) - 0.5D0*Z(549)*Z(122)
      Z(909) = MHAT*Z(550)
      Z(553) = Z(315)*U7 + Z(316)*U1 + Z(317)*U2 + Z(318)*U6 + Z(319)*U5
     & + Z(321)*U4 + Z(322)*U3
      Z(135) = Z(1)*Z(40) - Z(2)*Z(39)
      Z(558) = Z(5)*Z(133) - Z(6)*Z(135)
      Z(566) = Z(39)*Z(72) + Z(40)*Z(73)
      Z(568) = Z(39)*Z(74) + Z(40)*Z(75)
      Z(574) = -Z(15)*Z(566) - Z(16)*Z(568)
      Z(576) = Z(16)*Z(566) - Z(15)*Z(568)
      Z(578) = Z(27)*Z(574) + Z(28)*Z(576)
      Z(554) = Z(39)*Z(86) + Z(40)*Z(87)
      Z(570) = Z(39)*Z(79) + Z(40)*Z(80)
      Z(562) = Z(22)*Z(135) - Z(21)*Z(133)
      Z(590) = Z(20)*Z(135) - Z(19)*Z(133)
      Z(582) = -Z(11)*Z(574) - Z(12)*Z(576)
      Z(586) = Z(3)*Z(133) - Z(4)*Z(135)
      Z(594) = Z(96) + Z(100)*Z(29) + Z(101)*Z(558) + 0.5D0*Z(99)*Z(532)
     & + 0.5D0*Z(99)*Z(578) - LFFO - Z(95)*Z(133) - Z(97)*Z(554) - Z(97)
     &*Z(570) - Z(102)*Z(562) - Z(102)*Z(590) - Z(103)*Z(566) - Z(104)*Z
     &(574) - Z(105)*Z(582) - Z(106)*Z(586) - 0.5D0*Z(98)*Z(17)
      Z(911) = MFF*Z(594)
      Z(597) = LFFO*U4 + LFFO*U6 + LFFO*U7 + Z(41)*U1 + Z(42)*U2 - LFFO*
     &U3 - LFFO*U5
      Z(555) = Z(41)*Z(86) + Z(42)*Z(87)
      Z(598) = -Z(17)*Z(554) - Z(18)*Z(555)
      Z(600) = Z(18)*Z(554) - Z(17)*Z(555)
      Z(602) = Z(27)*Z(598) + Z(28)*Z(600)
      Z(614) = Z(72)*Z(86) + Z(73)*Z(87)
      Z(616) = Z(74)*Z(86) + Z(75)*Z(87)
      Z(622) = -Z(15)*Z(614) - Z(16)*Z(616)
      Z(624) = Z(16)*Z(614) - Z(15)*Z(616)
      Z(626) = Z(27)*Z(622) + Z(28)*Z(624)
      Z(618) = Z(79)*Z(86) + Z(80)*Z(87)
      Z(149) = Z(1)*Z(87) - Z(2)*Z(86)
      Z(638) = Z(20)*Z(149) - Z(19)*Z(147)
      Z(630) = -Z(11)*Z(622) - Z(12)*Z(624)
      Z(634) = Z(3)*Z(147) - Z(4)*Z(149)
      Z(606) = -Z(13)*Z(598) - Z(14)*Z(600)
      Z(610) = Z(5)*Z(147) - Z(6)*Z(149)
      Z(644) = LLAO + Z(642)*Z(147) + 0.5D0*Z(99)*Z(602) + 0.5D0*Z(99)*Z
     &(626) - Z(97) - Z(643)*Z(25) - Z(97)*Z(618) - Z(102)*Z(638) - Z(10
     &3)*Z(614) - Z(104)*Z(622) - Z(105)*Z(630) - Z(106)*Z(634) - Z(546)
     &*Z(554) - Z(547)*Z(606) - Z(548)*Z(610) - 0.5D0*Z(549)*Z(598)
      Z(913) = MLA*Z(644)
      Z(647) = Z(409) + LLAO*U14 + Z(407)*U12 + Z(396)*U7 + Z(397)*U1 + 
     &Z(398)*U2 + Z(399)*U6 + Z(400)*U5 + Z(401)*U4 + Z(408)*U3
      Z(730) = Z(35)*Z(72) + Z(36)*Z(73)
      Z(732) = Z(35)*Z(74) + Z(36)*Z(75)
      Z(738) = -Z(15)*Z(730) - Z(16)*Z(732)
      Z(740) = Z(16)*Z(730) - Z(15)*Z(732)
      Z(742) = Z(27)*Z(738) + Z(28)*Z(740)
      Z(734) = Z(35)*Z(79) + Z(36)*Z(80)
      Z(726) = Z(22)*Z(33) - Z(21)*Z(32)
      Z(754) = Z(20)*Z(33) - Z(19)*Z(32)
      Z(746) = -Z(11)*Z(738) - Z(12)*Z(740)
      Z(750) = Z(3)*Z(32) - Z(4)*Z(33)
      Z(758) = Z(100) + 0.5D0*Z(99)*Z(43) + 0.5D0*Z(99)*Z(742) + 0.5D0*Z
     &(549)*Z(13) - LSHO - Z(95)*Z(32) - Z(97)*Z(606) - Z(97)*Z(734) - Z
     &(101)*Z(9) - Z(102)*Z(726) - Z(102)*Z(754) - Z(103)*Z(730) - Z(104
     &)*Z(738) - Z(105)*Z(746) - Z(106)*Z(750) - Z(546)*Z(29)
      Z(921) = MSH*Z(758)
      Z(761) = Z(168)*U7 + Z(169)*U1 + Z(170)*U2 + Z(172)*U6 + Z(173)*U3
     & + Z(173)*U5 + Z(174)*U4
      Z(153) = Z(1)*Z(47) - Z(2)*Z(46)
      Z(658) = Z(5)*Z(151) - Z(6)*Z(153)
      Z(765) = Z(54)*Z(72) + Z(55)*Z(73)
      Z(767) = Z(54)*Z(74) + Z(55)*Z(75)
      Z(773) = -Z(15)*Z(765) - Z(16)*Z(767)
      Z(775) = Z(16)*Z(765) - Z(15)*Z(767)
      Z(777) = Z(27)*Z(773) + Z(28)*Z(775)
      Z(769) = Z(54)*Z(79) + Z(55)*Z(80)
      Z(762) = -Z(21)*Z(5) - Z(22)*Z(6)
      Z(785) = -Z(19)*Z(5) - Z(20)*Z(6)
      Z(781) = -Z(7)*Z(193) - Z(8)*Z(194)
      Z(124) = Z(1)*Z(51) - Z(2)*Z(50)
      Z(654) = Z(5)*Z(122) - Z(6)*Z(124)
      Z(788) = Z(101) + Z(547)*Z(9) + 0.5D0*Z(99)*Z(658) + 0.5D0*Z(99)*Z
     &(777) - LTHO - Z(95)*Z(5) - Z(97)*Z(610) - Z(97)*Z(769) - Z(102)*Z
     &(762) - Z(102)*Z(785) - Z(103)*Z(765) - Z(104)*Z(773) - Z(105)*Z(7
     &81) - Z(106)*Z(193) - Z(546)*Z(558) - 0.5D0*Z(549)*Z(654)
      Z(923) = MTH*Z(788)
      Z(791) = Z(183)*U7 + Z(184)*U1 + Z(185)*U2 + Z(186)*U6 + Z(187)*U5
     & + Z(189)*U3 + Z(190)*U4
      Z(666) = Z(22)*Z(153) - Z(21)*Z(151)
      Z(792) = Z(72)*Z(83) + Z(73)*Z(84)
      Z(794) = Z(74)*Z(83) + Z(75)*Z(84)
      Z(800) = -Z(15)*Z(792) - Z(16)*Z(794)
      Z(802) = Z(16)*Z(792) - Z(15)*Z(794)
      Z(804) = Z(27)*Z(800) + Z(28)*Z(802)
      Z(815) = Z(19)*Z(21) + Z(20)*Z(22)
      Z(812) = -Z(3)*Z(21) - Z(4)*Z(22)
      Z(796) = Z(79)*Z(83) + Z(80)*Z(84)
      Z(808) = -Z(11)*Z(800) - Z(12)*Z(802)
      Z(662) = Z(22)*Z(124) - Z(21)*Z(122)
      Z(818) = LUAO + Z(97)*Z(25) + 0.5D0*Z(99)*Z(666) + 0.5D0*Z(99)*Z(8
     &04) - Z(102) - Z(102)*Z(815) - Z(106)*Z(812) - Z(642)*Z(21) - Z(97
     &)*Z(796) - Z(103)*Z(792) - Z(104)*Z(800) - Z(105)*Z(808) - Z(546)*
     &Z(562) - Z(547)*Z(726) - Z(548)*Z(762) - 0.5D0*Z(549)*Z(662)
      Z(925) = MUA*Z(818)
      Z(821) = LUAO*U12 + Z(376)*U7 + Z(377)*U1 + Z(378)*U2 + Z(379)*U6 
     &+ Z(380)*U5 + Z(381)*U4 + Z(384)*U3 - Z(383)
      Z(829) = Z(11)*Z(15) - Z(12)*Z(16)
      Z(826) = Z(28)*Z(16) - Z(27)*Z(15)
      Z(130) = Z(1)*Z(73) - Z(2)*Z(72)
      Z(832) = Z(3)*Z(128) - Z(4)*Z(130)
      Z(674) = Z(46)*Z(72) + Z(47)*Z(73)
      Z(822) = Z(72)*Z(79) + Z(73)*Z(80)
      Z(836) = Z(20)*Z(130) - Z(19)*Z(128)
      Z(670) = Z(50)*Z(72) + Z(51)*Z(73)
      Z(843) = LFF + Z(840)*Z(829) + 0.5D0*Z(99)*Z(826) + Z(841)*Z(832) 
     &+ 0.5D0*Z(99)*Z(674) - LFFO - Z(103) - Z(842)*Z(15) - Z(95)*Z(128)
     & - Z(97)*Z(614) - Z(97)*Z(822) - Z(102)*Z(792) - Z(102)*Z(836) - Z
     &(546)*Z(566) - Z(547)*Z(730) - Z(548)*Z(765) - 0.5D0*Z(549)*Z(670)
      Z(927) = MFF*Z(843)
      Z(846) = Z(301) + Z(297)*U10 + Z(299)*U8 + Z(300)*U9 + Z(286)*U7 +
     & Z(287)*U1 + Z(288)*U2 + Z(289)*U6 + Z(290)*U5 + Z(291)*U4 + Z(298
     &)*U3
      Z(682) = Z(46)*Z(79) + Z(47)*Z(80)
      Z(823) = Z(74)*Z(79) + Z(75)*Z(80)
      Z(847) = -Z(15)*Z(822) - Z(16)*Z(823)
      Z(849) = Z(16)*Z(822) - Z(15)*Z(823)
      Z(851) = Z(27)*Z(847) + Z(28)*Z(849)
      Z(855) = -Z(11)*Z(847) - Z(12)*Z(849)
      Z(143) = Z(1)*Z(80) - Z(2)*Z(79)
      Z(859) = Z(3)*Z(141) - Z(4)*Z(143)
      Z(678) = Z(50)*Z(79) + Z(51)*Z(80)
      Z(863) = LLAO + Z(642)*Z(141) + 0.5D0*Z(99)*Z(682) + 0.5D0*Z(99)*Z
     &(851) - Z(97) - Z(643)*Z(23) - Z(97)*Z(618) - Z(102)*Z(796) - Z(10
     &3)*Z(822) - Z(104)*Z(847) - Z(105)*Z(855) - Z(106)*Z(859) - Z(546)
     &*Z(570) - Z(547)*Z(734) - Z(548)*Z(769) - 0.5D0*Z(549)*Z(678)
      Z(929) = MLA*Z(863)
      Z(866) = Z(364) + LLAO*U13 + Z(362)*U11 + Z(351)*U7 + Z(352)*U1 + 
     &Z(353)*U2 + Z(354)*U6 + Z(355)*U5 + Z(356)*U4 + Z(363)*U3
      Z(676) = Z(46)*Z(74) + Z(47)*Z(75)
      Z(690) = -Z(15)*Z(674) - Z(16)*Z(676)
      Z(692) = Z(16)*Z(674) - Z(15)*Z(676)
      Z(706) = -Z(11)*Z(690) - Z(12)*Z(692)
      Z(112) = Z(1)*Z(61) - Z(2)*Z(60)
      Z(891) = Z(20)*Z(112) - Z(19)*Z(110)
      Z(672) = Z(50)*Z(74) + Z(51)*Z(75)
      Z(686) = -Z(15)*Z(670) - Z(16)*Z(672)
      Z(688) = Z(16)*Z(670) - Z(15)*Z(672)
      Z(702) = -Z(11)*Z(686) - Z(12)*Z(688)
      Z(895) = LSH + Z(104)*Z(11) + 0.5D0*Z(99)*Z(535) + 0.5D0*Z(99)*Z(7
     &06) - LSHO - Z(105) - Z(103)*Z(829) - Z(841)*Z(7) - Z(95)*Z(110) -
     & Z(97)*Z(630) - Z(97)*Z(855) - Z(102)*Z(808) - Z(102)*Z(891) - Z(5
     &46)*Z(582) - Z(547)*Z(746) - Z(548)*Z(781) - 0.5D0*Z(549)*Z(702)
      Z(937) = MSH*Z(895)
      Z(897) = Z(236) + Z(92)*U9 + Z(235)*U8 + Z(223)*U7 + Z(224)*U1 + Z
     &(225)*U2 + Z(226)*U6 + Z(228)*U5 + Z(229)*U4 + Z(234)*U3
      Z(714) = Z(3)*Z(151) - Z(4)*Z(153)
      Z(244) = Z(1)*Z(69) - Z(2)*Z(68)
      Z(879) = Z(3)*Z(242) - Z(4)*Z(244)
      Z(898) = -Z(3)*Z(19) - Z(4)*Z(20)
      Z(119) = Z(1)*Z(65) - Z(2)*Z(64)
      Z(875) = Z(3)*Z(117) - Z(4)*Z(119)
      Z(710) = Z(3)*Z(122) - Z(4)*Z(124)
      Z(901) = LTH + Z(105)*Z(7) + 0.5D0*Z(99)*Z(714) + 0.5D0*Z(99)*Z(87
     &9) - LTHO - Z(106) - Z(95)*Z(3) - Z(102)*Z(812) - Z(102)*Z(898) - 
     &Z(97)*Z(634) - Z(97)*Z(859) - Z(103)*Z(832) - Z(104)*Z(875) - Z(54
     &6)*Z(586) - Z(547)*Z(750) - Z(548)*Z(193) - 0.5D0*Z(549)*Z(710)
      Z(939) = MTH*Z(901)
      Z(904) = Z(93)*U8 + Z(203)*U7 + Z(204)*U1 + Z(205)*U2 + Z(206)*U6 
     &+ Z(207)*U5 + Z(209)*U4 + Z(211)*U3 - Z(210)
      Z(722) = Z(20)*Z(153) - Z(19)*Z(151)
      Z(887) = Z(20)*Z(244) - Z(19)*Z(242)
      Z(883) = Z(20)*Z(119) - Z(19)*Z(117)
      Z(718) = Z(20)*Z(124) - Z(19)*Z(122)
      Z(905) = LUAO + Z(97)*Z(23) + 0.5D0*Z(99)*Z(722) + 0.5D0*Z(99)*Z(8
     &87) - Z(102) - Z(102)*Z(815) - Z(106)*Z(898) - Z(642)*Z(19) - Z(97
     &)*Z(638) - Z(103)*Z(836) - Z(104)*Z(883) - Z(105)*Z(891) - Z(546)*
     &Z(590) - Z(547)*Z(754) - Z(548)*Z(785) - 0.5D0*Z(549)*Z(718)
      Z(941) = MUA*Z(905)
      Z(908) = LUAO*U11 + Z(331)*U7 + Z(332)*U1 + Z(333)*U2 + Z(334)*U6 
     &+ Z(335)*U5 + Z(336)*U4 + Z(339)*U3 - Z(338)
      Z(698) = Z(27)*Z(690) + Z(28)*Z(692)
      Z(920) = MRF*(2*Z(95)*Z(151)+2*Z(97)*Z(602)+2*Z(97)*Z(682)+2*Z(102
     &)*Z(666)+2*Z(102)*Z(722)+2*Z(103)*Z(674)+2*Z(104)*Z(690)+2*Z(105)*
     &Z(706)+2*Z(106)*Z(714)-2*Z(650)-2*Z(919)-2*Z(100)*Z(43)-2*Z(101)*Z
     &(658)-2*Z(648)*Z(532)-Z(99)*Z(698))
      Z(653) = LRFFO*(U3+U5-U4-U6)
      Z(134) = Z(1)*Z(41) + Z(2)*Z(42)
      Z(571) = Z(41)*Z(79) + Z(42)*Z(80)
      Z(136) = Z(1)*Z(42) - Z(2)*Z(41)
      Z(563) = Z(22)*Z(136) - Z(21)*Z(134)
      Z(591) = Z(20)*Z(136) - Z(19)*Z(134)
      Z(567) = Z(41)*Z(72) + Z(42)*Z(73)
      Z(569) = Z(41)*Z(74) + Z(42)*Z(75)
      Z(575) = -Z(15)*Z(567) - Z(16)*Z(569)
      Z(577) = Z(16)*Z(567) - Z(15)*Z(569)
      Z(583) = -Z(11)*Z(575) - Z(12)*Z(577)
      Z(587) = Z(3)*Z(134) - Z(4)*Z(136)
      Z(559) = Z(5)*Z(134) - Z(6)*Z(136)
      Z(579) = Z(27)*Z(575) + Z(28)*Z(577)
      Z(916) = MRF*(2*Z(95)*Z(134)+2*Z(97)*Z(555)+2*Z(97)*Z(571)+2*Z(102
     &)*Z(563)+2*Z(102)*Z(591)+2*Z(103)*Z(567)+2*Z(104)*Z(575)+2*Z(105)*
     &Z(583)+2*Z(106)*Z(587)+2*Z(649)*Z(18)-2*Z(100)*Z(31)-2*Z(101)*Z(55
     &9)-2*Z(650)*Z(534)-Z(99)*Z(579))
      Z(596) = Z(39)*U1 + Z(40)*U2
      Z(831) = -Z(11)*Z(16) - Z(12)*Z(15)
      Z(111) = Z(1)*Z(62) + Z(2)*Z(63)
      Z(632) = Z(12)*Z(622) - Z(11)*Z(624)
      Z(857) = Z(12)*Z(847) - Z(11)*Z(849)
      Z(810) = Z(12)*Z(800) - Z(11)*Z(802)
      Z(113) = Z(1)*Z(63) - Z(2)*Z(62)
      Z(892) = Z(20)*Z(113) - Z(19)*Z(111)
      Z(584) = Z(12)*Z(574) - Z(11)*Z(576)
      Z(704) = Z(12)*Z(686) - Z(11)*Z(688)
      Z(748) = Z(12)*Z(738) - Z(11)*Z(740)
      Z(783) = Z(8)*Z(193) - Z(7)*Z(194)
      Z(708) = Z(12)*Z(690) - Z(11)*Z(692)
      Z(936) = MRF*(2*Z(103)*Z(831)+2*Z(95)*Z(111)+2*Z(97)*Z(632)+2*Z(97
     &)*Z(857)+2*Z(102)*Z(810)+2*Z(102)*Z(892)-2*Z(650)*Z(536)-2*Z(841)*
     &Z(8)-2*Z(870)*Z(12)-2*Z(648)*Z(584)-2*Z(867)*Z(704)-2*Z(868)*Z(748
     &)-2*Z(869)*Z(783)-Z(99)*Z(708))
      Z(873) = Z(222) + Z(215)*U7 + Z(216)*U1 + Z(217)*U2 + Z(218)*U6 + 
     &Z(219)*U5 + Z(220)*U4 + Z(221)*U3 - Z(214)*U8
      Z(539) = IUA*LSp
      Z(544) = ITH*RHp
      Z(545) = IUA*RSp
      Z(551) = Z(106)*Z(4) + Z(548)*Z(6) + 0.5D0*Z(99)*Z(153) + 0.5D0*Z(
     &99)*Z(244) - Z(102)*Z(20) - Z(102)*Z(22) - Z(97)*Z(143) - Z(97)*Z(
     &149) - Z(103)*Z(130) - Z(104)*Z(119) - Z(105)*Z(112) - Z(546)*Z(13
     &5) - Z(547)*Z(33) - 0.5D0*Z(549)*Z(124)
      Z(910) = MHAT*Z(551)
      Z(552) = Z(308)*U7 + Z(309)*U1 + Z(310)*U2 + Z(311)*U6 + Z(312)*U3
     & + Z(313)*U5 + Z(314)*U4
      Z(595) = Z(100)*Z(31) + Z(101)*Z(559) + 0.5D0*Z(99)*Z(534) + 0.5D0
     &*Z(99)*Z(579) - Z(95)*Z(134) - Z(97)*Z(555) - Z(97)*Z(571) - Z(102
     &)*Z(563) - Z(102)*Z(591) - Z(103)*Z(567) - Z(104)*Z(575) - Z(105)*
     &Z(583) - Z(106)*Z(587) - 0.5D0*Z(98)*Z(18)
      Z(912) = MFF*Z(595)
      Z(88) = Z(26)*Z(83) - Z(25)*Z(85)
      Z(148) = Z(1)*Z(88) + Z(2)*Z(89)
      Z(556) = Z(39)*Z(88) + Z(40)*Z(89)
      Z(557) = Z(41)*Z(88) + Z(42)*Z(89)
      Z(599) = -Z(17)*Z(556) - Z(18)*Z(557)
      Z(601) = Z(18)*Z(556) - Z(17)*Z(557)
      Z(603) = Z(27)*Z(599) + Z(28)*Z(601)
      Z(615) = Z(72)*Z(88) + Z(73)*Z(89)
      Z(617) = Z(74)*Z(88) + Z(75)*Z(89)
      Z(623) = -Z(15)*Z(615) - Z(16)*Z(617)
      Z(625) = Z(16)*Z(615) - Z(15)*Z(617)
      Z(627) = Z(27)*Z(623) + Z(28)*Z(625)
      Z(619) = Z(79)*Z(88) + Z(80)*Z(89)
      Z(150) = Z(1)*Z(89) - Z(2)*Z(88)
      Z(639) = Z(20)*Z(150) - Z(19)*Z(148)
      Z(631) = -Z(11)*Z(623) - Z(12)*Z(625)
      Z(635) = Z(3)*Z(148) - Z(4)*Z(150)
      Z(607) = -Z(13)*Z(599) - Z(14)*Z(601)
      Z(611) = Z(5)*Z(148) - Z(6)*Z(150)
      Z(645) = Z(643)*Z(26) + Z(642)*Z(148) + 0.5D0*Z(99)*Z(603) + 0.5D0
     &*Z(99)*Z(627) - Z(97)*Z(619) - Z(102)*Z(639) - Z(103)*Z(615) - Z(1
     &04)*Z(623) - Z(105)*Z(631) - Z(106)*Z(635) - Z(546)*Z(556) - Z(547
     &)*Z(607) - Z(548)*Z(611) - 0.5D0*Z(549)*Z(599)
      Z(914) = MLA*Z(645)
      Z(646) = Z(395) + Z(388)*U7 + Z(389)*U1 + Z(390)*U2 + Z(391)*U6 + 
     &Z(392)*U5 + Z(393)*U4 + Z(394)*U3 - Z(387)*U12
      Z(731) = Z(37)*Z(72) + Z(38)*Z(73)
      Z(733) = Z(37)*Z(74) + Z(38)*Z(75)
      Z(739) = -Z(15)*Z(731) - Z(16)*Z(733)
      Z(741) = Z(16)*Z(731) - Z(15)*Z(733)
      Z(743) = Z(27)*Z(739) + Z(28)*Z(741)
      Z(608) = Z(14)*Z(598) - Z(13)*Z(600)
      Z(735) = Z(37)*Z(79) + Z(38)*Z(80)
      Z(727) = Z(22)*Z(32) - Z(21)*Z(34)
      Z(755) = Z(20)*Z(32) - Z(19)*Z(34)
      Z(747) = -Z(11)*Z(739) - Z(12)*Z(741)
      Z(751) = Z(3)*Z(34) - Z(4)*Z(32)
      Z(759) = Z(101)*Z(10) + 0.5D0*Z(99)*Z(44) + 0.5D0*Z(99)*Z(743) - Z
     &(95)*Z(34) - Z(97)*Z(608) - Z(97)*Z(735) - Z(102)*Z(727) - Z(102)*
     &Z(755) - Z(103)*Z(731) - Z(104)*Z(739) - Z(105)*Z(747) - Z(106)*Z(
     &751) - Z(546)*Z(30) - 0.5D0*Z(549)*Z(14)
      Z(922) = MSH*Z(759)
      Z(760) = Z(163)*U4 + Z(163)*U6 + Z(164)*U7 + Z(165)*U3 + Z(165)*U5
     & + Z(166)*U1 + Z(167)*U2
      Z(660) = Z(5)*Z(153) + Z(6)*Z(151)
      Z(56) = Z(1)*Z(6) - Z(2)*Z(5)
      Z(766) = Z(54)*Z(73) + Z(56)*Z(72)
      Z(768) = Z(54)*Z(75) + Z(56)*Z(74)
      Z(774) = -Z(15)*Z(766) - Z(16)*Z(768)
      Z(776) = Z(16)*Z(766) - Z(15)*Z(768)
      Z(778) = Z(27)*Z(774) + Z(28)*Z(776)
      Z(612) = Z(5)*Z(149) + Z(6)*Z(147)
      Z(770) = Z(54)*Z(80) + Z(56)*Z(79)
      Z(763) = Z(22)*Z(5) - Z(21)*Z(6)
      Z(786) = Z(20)*Z(5) - Z(19)*Z(6)
      Z(782) = -Z(7)*Z(195) - Z(8)*Z(193)
      Z(560) = Z(5)*Z(135) + Z(6)*Z(133)
      Z(656) = Z(5)*Z(124) + Z(6)*Z(122)
      Z(789) = Z(547)*Z(10) + 0.5D0*Z(99)*Z(660) + 0.5D0*Z(99)*Z(778) - 
     &Z(95)*Z(6) - Z(97)*Z(612) - Z(97)*Z(770) - Z(102)*Z(763) - Z(102)*
     &Z(786) - Z(103)*Z(766) - Z(104)*Z(774) - Z(105)*Z(782) - Z(106)*Z(
     &195) - Z(546)*Z(560) - 0.5D0*Z(549)*Z(656)
      Z(924) = MTH*Z(789)
      Z(790) = Z(177)*U7 + Z(178)*U1 + Z(179)*U2 + Z(180)*U6 + Z(181)*U3
     & + Z(181)*U5 + Z(182)*U4
      Z(668) = -Z(21)*Z(153) - Z(22)*Z(151)
      Z(793) = Z(72)*Z(85) + Z(73)*Z(83)
      Z(795) = Z(74)*Z(85) + Z(75)*Z(83)
      Z(801) = -Z(15)*Z(793) - Z(16)*Z(795)
      Z(803) = Z(16)*Z(793) - Z(15)*Z(795)
      Z(805) = Z(27)*Z(801) + Z(28)*Z(803)
      Z(816) = Z(19)*Z(22) - Z(20)*Z(21)
      Z(813) = Z(4)*Z(21) - Z(3)*Z(22)
      Z(797) = Z(79)*Z(85) + Z(80)*Z(83)
      Z(809) = -Z(11)*Z(801) - Z(12)*Z(803)
      Z(564) = -Z(21)*Z(135) - Z(22)*Z(133)
      Z(728) = -Z(21)*Z(33) - Z(22)*Z(32)
      Z(764) = Z(21)*Z(6) - Z(22)*Z(5)
      Z(664) = -Z(21)*Z(124) - Z(22)*Z(122)
      Z(819) = Z(97)*Z(26) + 0.5D0*Z(99)*Z(668) + 0.5D0*Z(99)*Z(805) - Z
     &(102)*Z(816) - Z(106)*Z(813) - Z(642)*Z(22) - Z(97)*Z(797) - Z(103
     &)*Z(793) - Z(104)*Z(801) - Z(105)*Z(809) - Z(546)*Z(564) - Z(547)*
     &Z(728) - Z(548)*Z(764) - 0.5D0*Z(549)*Z(664)
      Z(926) = MUA*Z(819)
      Z(820) = Z(369)*U7 + Z(370)*U1 + Z(371)*U2 + Z(372)*U6 + Z(373)*U5
     & + Z(374)*U4 + Z(375)*U3
      Z(830) = Z(11)*Z(16) + Z(12)*Z(15)
      Z(827) = -Z(27)*Z(16) - Z(28)*Z(15)
      Z(129) = Z(1)*Z(74) + Z(2)*Z(75)
      Z(131) = Z(1)*Z(75) - Z(2)*Z(74)
      Z(833) = Z(3)*Z(129) - Z(4)*Z(131)
      Z(837) = Z(20)*Z(131) - Z(19)*Z(129)
      Z(844) = Z(840)*Z(830) + 0.5D0*Z(99)*Z(827) + Z(841)*Z(833) + 0.5D
     &0*Z(99)*Z(676) - Z(842)*Z(16) - Z(95)*Z(129) - Z(97)*Z(616) - Z(97
     &)*Z(823) - Z(102)*Z(794) - Z(102)*Z(837) - Z(546)*Z(568) - Z(547)*
     &Z(732) - Z(548)*Z(767) - 0.5D0*Z(549)*Z(672)
      Z(928) = MFF*Z(844)
      Z(845) = Z(283) + Z(273)*U10 + Z(274)*U8 + Z(275)*U9 + Z(276)*U7 +
     & Z(277)*U1 + Z(278)*U2 + Z(279)*U6 + Z(280)*U5 + Z(281)*U4 + Z(282
     &)*U3
      Z(81) = Z(24)*Z(76) - Z(23)*Z(78)
      Z(142) = Z(1)*Z(81) + Z(2)*Z(82)
      Z(684) = Z(46)*Z(81) + Z(47)*Z(82)
      Z(824) = Z(72)*Z(81) + Z(73)*Z(82)
      Z(825) = Z(74)*Z(81) + Z(75)*Z(82)
      Z(848) = -Z(15)*Z(824) - Z(16)*Z(825)
      Z(850) = Z(16)*Z(824) - Z(15)*Z(825)
      Z(852) = Z(27)*Z(848) + Z(28)*Z(850)
      Z(620) = Z(81)*Z(86) + Z(82)*Z(87)
      Z(798) = Z(81)*Z(83) + Z(82)*Z(84)
      Z(856) = -Z(11)*Z(848) - Z(12)*Z(850)
      Z(144) = Z(1)*Z(82) - Z(2)*Z(81)
      Z(860) = Z(3)*Z(142) - Z(4)*Z(144)
      Z(572) = Z(39)*Z(81) + Z(40)*Z(82)
      Z(736) = Z(35)*Z(81) + Z(36)*Z(82)
      Z(771) = Z(54)*Z(81) + Z(55)*Z(82)
      Z(680) = Z(50)*Z(81) + Z(51)*Z(82)
      Z(864) = Z(643)*Z(24) + Z(642)*Z(142) + 0.5D0*Z(99)*Z(684) + 0.5D0
     &*Z(99)*Z(852) - Z(97)*Z(620) - Z(102)*Z(798) - Z(103)*Z(824) - Z(1
     &04)*Z(848) - Z(105)*Z(856) - Z(106)*Z(860) - Z(546)*Z(572) - Z(547
     &)*Z(736) - Z(548)*Z(771) - 0.5D0*Z(549)*Z(680)
      Z(930) = MLA*Z(864)
      Z(865) = Z(350) + Z(343)*U7 + Z(344)*U1 + Z(345)*U2 + Z(346)*U6 + 
     &Z(347)*U5 + Z(348)*U4 + Z(349)*U3 - Z(342)*U11
      Z(896) = Z(841)*Z(8) + 0.5D0*Z(99)*Z(536) + 0.5D0*Z(99)*Z(708) - Z
     &(103)*Z(831) - Z(104)*Z(12) - Z(95)*Z(111) - Z(97)*Z(632) - Z(97)*
     &Z(857) - Z(102)*Z(810) - Z(102)*Z(892) - Z(546)*Z(584) - Z(547)*Z(
     &748) - Z(548)*Z(783) - 0.5D0*Z(549)*Z(704)
      Z(938) = MSH*Z(896)
      Z(716) = Z(3)*Z(153) + Z(4)*Z(151)
      Z(881) = Z(3)*Z(244) + Z(4)*Z(242)
      Z(814) = Z(3)*Z(22) - Z(4)*Z(21)
      Z(899) = Z(3)*Z(20) - Z(4)*Z(19)
      Z(636) = Z(3)*Z(149) + Z(4)*Z(147)
      Z(861) = Z(3)*Z(143) + Z(4)*Z(141)
      Z(834) = Z(3)*Z(130) + Z(4)*Z(128)
      Z(877) = Z(3)*Z(119) + Z(4)*Z(117)
      Z(588) = Z(3)*Z(135) + Z(4)*Z(133)
      Z(752) = Z(3)*Z(33) + Z(4)*Z(32)
      Z(712) = Z(3)*Z(124) + Z(4)*Z(122)
      Z(902) = Z(105)*Z(8) + 0.5D0*Z(99)*Z(716) + 0.5D0*Z(99)*Z(881) - Z
     &(95)*Z(4) - Z(102)*Z(814) - Z(102)*Z(899) - Z(97)*Z(636) - Z(97)*Z
     &(861) - Z(103)*Z(834) - Z(104)*Z(877) - Z(546)*Z(588) - Z(547)*Z(7
     &52) - Z(548)*Z(194) - 0.5D0*Z(549)*Z(712)
      Z(940) = MTH*Z(902)
      Z(903) = Z(196)*U7 + Z(197)*U1 + Z(198)*U2 + Z(199)*U6 + Z(200)*U3
     & + Z(201)*U5 + Z(202)*U4
      Z(724) = -Z(19)*Z(153) - Z(20)*Z(151)
      Z(889) = -Z(19)*Z(244) - Z(20)*Z(242)
      Z(817) = Z(20)*Z(21) - Z(19)*Z(22)
      Z(900) = Z(4)*Z(19) - Z(3)*Z(20)
      Z(640) = -Z(19)*Z(149) - Z(20)*Z(147)
      Z(838) = -Z(19)*Z(130) - Z(20)*Z(128)
      Z(885) = -Z(19)*Z(119) - Z(20)*Z(117)
      Z(893) = -Z(19)*Z(112) - Z(20)*Z(110)
      Z(592) = -Z(19)*Z(135) - Z(20)*Z(133)
      Z(756) = -Z(19)*Z(33) - Z(20)*Z(32)
      Z(787) = Z(19)*Z(6) - Z(20)*Z(5)
      Z(720) = -Z(19)*Z(124) - Z(20)*Z(122)
      Z(906) = Z(97)*Z(24) + 0.5D0*Z(99)*Z(724) + 0.5D0*Z(99)*Z(889) - Z
     &(102)*Z(817) - Z(106)*Z(900) - Z(642)*Z(20) - Z(97)*Z(640) - Z(103
     &)*Z(838) - Z(104)*Z(885) - Z(105)*Z(893) - Z(546)*Z(592) - Z(547)*
     &Z(756) - Z(548)*Z(787) - 0.5D0*Z(549)*Z(720)
      Z(942) = MUA*Z(906)
      Z(907) = Z(324)*U7 + Z(325)*U1 + Z(326)*U2 + Z(327)*U6 + Z(328)*U5
     & + Z(329)*U4 + Z(330)*U3
      Z(915) = MRF*(2*Z(95)*Z(133)+2*Z(97)*Z(554)+2*Z(97)*Z(570)+2*Z(102
     &)*Z(562)+2*Z(102)*Z(590)+2*Z(103)*Z(566)+2*Z(104)*Z(574)+2*Z(105)*
     &Z(582)+2*Z(106)*Z(586)+2*Z(649)*Z(17)-2*Z(648)-2*Z(100)*Z(29)-2*Z(
     &101)*Z(558)-2*Z(650)*Z(532)-Z(99)*Z(578))
      Z(651) = LFF*U4 + LFF*U6 + LFF*U7 + Z(41)*U1 + Z(42)*U2 - LFF*U3 -
     & LFF*U5
      Z(932) = MRF*(2*Z(840)*Z(11)+2*Z(95)*Z(117)+2*Z(97)*Z(622)+2*Z(97)
     &*Z(847)+2*Z(102)*Z(800)+2*Z(102)*Z(883)-2*Z(870)-2*Z(931)-2*Z(103)
     &*Z(15)-2*Z(648)*Z(574)-2*Z(841)*Z(875)-2*Z(867)*Z(686)-2*Z(868)*Z(
     &738)-2*Z(869)*Z(773)-Z(99)*Z(690))
      Z(871) = Z(246) + Z(91)*U10 + Z(91)*U3 + Z(91)*U8 + Z(91)*U9
      Z(694) = Z(27)*Z(686) + Z(28)*Z(688)
      Z(934) = MRF*(2*Z(103)*Z(826)+2*Z(95)*Z(242)+2*Z(97)*Z(626)+2*Z(97
     &)*Z(851)+2*Z(102)*Z(804)+2*Z(102)*Z(887)-2*Z(650)-2*Z(933)-2*Z(840
     &)*Z(535)-2*Z(648)*Z(578)-2*Z(841)*Z(879)-2*Z(867)*Z(694)-2*Z(868)*
     &Z(742)-2*Z(869)*Z(777)-Z(99)*Z(698))
      Z(872) = -0.5D0*Z(247) - 0.5D0*LRFFO*U10 - 0.5D0*LRFFO*U3 - 0.5D0*
     &LRFFO*U8 - 0.5D0*LRFFO*U9
      Z(935) = MRF*(2*Z(103)*Z(829)+2*Z(841)*Z(7)+2*Z(870)*Z(11)+2*Z(95)
     &*Z(110)+2*Z(97)*Z(630)+2*Z(97)*Z(855)+2*Z(102)*Z(808)+2*Z(102)*Z(8
     &91)-2*Z(840)-2*Z(650)*Z(535)-2*Z(648)*Z(582)-2*Z(867)*Z(702)-2*Z(8
     &68)*Z(746)-2*Z(869)*Z(781)-Z(99)*Z(706))
      Z(874) = Z(240) + LSH*U9 + Z(239)*U8 + Z(223)*U7 + Z(224)*U1 + Z(2
     &25)*U2 + Z(226)*U6 + Z(228)*U5 + Z(229)*U4 + Z(238)*U3
      Z(918) = MRF*(Z(917)+Z(99)*Z(694)+2*Z(101)*Z(654)-2*Z(95)*Z(122)-2
     &*Z(97)*Z(598)-2*Z(97)*Z(678)-2*Z(100)*Z(13)-2*Z(102)*Z(662)-2*Z(10
     &2)*Z(718)-2*Z(103)*Z(670)-2*Z(104)*Z(686)-2*Z(105)*Z(702)-2*Z(106)
     &*Z(710)-2*Z(648)*Z(17))
      Z(652) = LRFO*(U3+U5-U4-U6)
      HZ = Z(538) + Z(540) + Z(541) + Z(542) + Z(543) + IFF*U10 + IFF*U8
     & + IFF*U9 + IHAT*U3 + ILA*U11 + ILA*U12 + ILA*U13 + ILA*U14 + IRF*
     &U10 + IRF*U8 + IRF*U9 + ISH*U8 + ISH*U9 + ITH*U8 + IUA*U11 + IUA*U
     &12 + 2*IFF*U3 + 2*ILA*U3 + 2*IRF*U3 + 2*ISH*U3 + 2*ITH*U3 + 2*IUA*
     &U3 + IRF*(U5-U4-U6) + IFF*(U5-U4-U6-U7) + Z(909)*Z(553) + Z(911)*Z
     &(597) + Z(913)*Z(647) + Z(921)*Z(761) + Z(923)*Z(791) + Z(925)*Z(8
     &21) + Z(927)*Z(846) + Z(929)*Z(866) + Z(937)*Z(897) + Z(939)*Z(904
     &) + Z(941)*Z(908) + 0.25D0*Z(920)*Z(653) + 0.5D0*Z(916)*Z(596) + 0
     &.5D0*Z(936)*Z(873) - Z(539) - Z(544) - Z(545) - ITH*U4 - ISH*(U4-U
     &5) - Z(910)*Z(552) - Z(912)*Z(596) - Z(914)*Z(646) - Z(922)*Z(760)
     & - Z(924)*Z(790) - Z(926)*Z(820) - Z(928)*Z(845) - Z(930)*Z(865) -
     & Z(938)*Z(873) - Z(940)*Z(903) - Z(942)*Z(907) - 0.5D0*Z(915)*Z(65
     &1) - 0.5D0*Z(932)*Z(871) - 0.5D0*Z(934)*Z(872) - 0.5D0*Z(935)*Z(87
     &4) - 0.25D0*Z(918)*Z(652)
      Z(957) = MFF*Z(39)
      Z(958) = MFF*Z(40)
      Z(981) = MRF*Z(39)
      Z(982) = MRF*Z(40)
      Z(1069) = MRF*Z(246)
      Z(943) = MHAT*Z(308)
      Z(944) = MHAT*Z(309)
      Z(945) = MHAT*Z(310)
      Z(946) = MHAT*Z(311)
      Z(947) = MHAT*Z(312)
      Z(948) = MHAT*Z(313)
      Z(949) = MHAT*Z(314)
      Z(988) = MSH*Z(163)
      Z(989) = MSH*Z(164)
      Z(990) = MSH*Z(165)
      Z(991) = MSH*Z(166)
      Z(992) = MSH*Z(167)
      Z(993) = MSH*Z(168)
      Z(994) = MSH*Z(169)
      Z(995) = MSH*Z(170)
      Z(996) = MSH*Z(172)
      Z(997) = MSH*Z(173)
      Z(998) = MSH*Z(174)
      Z(999) = MTH*Z(177)
      Z(1000) = MTH*Z(178)
      Z(1001) = MTH*Z(179)
      Z(1002) = MTH*Z(180)
      Z(1003) = MTH*Z(181)
      Z(1004) = MTH*Z(182)
      Z(1005) = MTH*Z(183)
      Z(1006) = MTH*Z(184)
      Z(1007) = MTH*Z(185)
      Z(1008) = MTH*Z(186)
      Z(1009) = MTH*Z(187)
      Z(1010) = MTH*Z(189)
      Z(1011) = MTH*Z(190)
      Z(1109) = MTH*Z(196)
      Z(1110) = MTH*Z(197)
      Z(1111) = MTH*Z(198)
      Z(1112) = MTH*Z(199)
      Z(1113) = MTH*Z(200)
      Z(1114) = MTH*Z(201)
      Z(1115) = MTH*Z(202)
      Z(1125) = MUA*Z(324)
      Z(1126) = MUA*Z(325)
      Z(1127) = MUA*Z(326)
      Z(1128) = MUA*Z(327)
      Z(1129) = MUA*Z(328)
      Z(1130) = MUA*Z(329)
      Z(1131) = MUA*Z(330)
      Z(1012) = MUA*Z(369)
      Z(1013) = MUA*Z(370)
      Z(1014) = MUA*Z(371)
      Z(1015) = MUA*Z(372)
      Z(1016) = MUA*Z(373)
      Z(1017) = MUA*Z(374)
      Z(1018) = MUA*Z(375)
      Z(1067) = MLA*Z(364)
      Z(1059) = MLA*Z(362)
      Z(1060) = MLA*Z(351)
      Z(1061) = MLA*Z(352)
      Z(1062) = MLA*Z(353)
      Z(1063) = MLA*Z(354)
      Z(1064) = MLA*Z(355)
      Z(1065) = MLA*Z(356)
      Z(1066) = MLA*Z(363)
      Z(980) = MLA*Z(409)
      Z(972) = MLA*Z(407)
      Z(973) = MLA*Z(396)
      Z(974) = MLA*Z(397)
      Z(975) = MLA*Z(398)
      Z(976) = MLA*Z(399)
      Z(977) = MLA*Z(400)
      Z(978) = MLA*Z(401)
      Z(979) = MLA*Z(408)
      Z(1038) = MFF*Z(283)
      Z(1028) = MFF*Z(273)
      Z(1029) = MFF*Z(274)
      Z(1030) = MFF*Z(275)
      Z(1031) = MFF*Z(276)
      Z(1032) = MFF*Z(277)
      Z(1033) = MFF*Z(278)
      Z(1034) = MFF*Z(279)
      Z(1035) = MFF*Z(280)
      Z(1036) = MFF*Z(281)
      Z(1037) = MFF*Z(282)
      Z(1049) = MFF*Z(301)
      Z(1039) = MFF*Z(297)
      Z(1040) = MFF*Z(299)
      Z(1041) = MFF*Z(300)
      Z(1042) = MFF*Z(286)
      Z(1043) = MFF*Z(287)
      Z(1044) = MFF*Z(288)
      Z(1045) = MFF*Z(289)
      Z(1046) = MFF*Z(290)
      Z(1047) = MFF*Z(291)
      Z(1048) = MFF*Z(298)
      Z(1089) = MRF*Z(240)
      Z(1108) = MSH*Z(236)
      Z(1081) = MRF*Z(239)
      Z(1100) = MSH*Z(235)
      Z(1082) = MRF*Z(223)
      Z(1083) = MRF*Z(224)
      Z(1084) = MRF*Z(225)
      Z(1085) = MRF*Z(226)
      Z(1086) = MRF*Z(228)
      Z(1087) = MRF*Z(229)
      Z(1088) = MRF*Z(238)
      Z(1101) = MSH*Z(223)
      Z(1102) = MSH*Z(224)
      Z(1103) = MSH*Z(225)
      Z(1104) = MSH*Z(226)
      Z(1105) = MSH*Z(228)
      Z(1106) = MSH*Z(229)
      Z(1107) = MSH*Z(234)
      Z(52) = -Z(13)*Z(37) - Z(14)*Z(35)
      Z(48) = Z(35)*Z(45) + Z(37)*Z(43)
      Z(70) = Z(27)*Z(66) - Z(28)*Z(64)
      Z(1070) = MRF*Z(247)
      Z(950) = MHAT*Z(315)
      Z(951) = MHAT*Z(316)
      Z(952) = MHAT*Z(317)
      Z(953) = MHAT*Z(318)
      Z(954) = MHAT*Z(319)
      Z(955) = MHAT*Z(321)
      Z(956) = MHAT*Z(322)
      Z(1124) = MTH*Z(210)
      Z(1117) = MTH*Z(203)
      Z(1118) = MTH*Z(204)
      Z(1119) = MTH*Z(205)
      Z(1120) = MTH*Z(206)
      Z(1121) = MTH*Z(207)
      Z(1122) = MTH*Z(209)
      Z(1123) = MTH*Z(211)
      Z(1139) = MUA*Z(338)
      Z(1132) = MUA*Z(331)
      Z(1133) = MUA*Z(332)
      Z(1134) = MUA*Z(333)
      Z(1135) = MUA*Z(334)
      Z(1136) = MUA*Z(335)
      Z(1137) = MUA*Z(336)
      Z(1138) = MUA*Z(339)
      Z(1057) = MLA*Z(342)
      Z(1058) = MLA*Z(350)
      Z(1050) = MLA*Z(343)
      Z(1051) = MLA*Z(344)
      Z(1052) = MLA*Z(345)
      Z(1053) = MLA*Z(346)
      Z(1054) = MLA*Z(347)
      Z(1055) = MLA*Z(348)
      Z(1056) = MLA*Z(349)
      Z(1027) = MUA*Z(383)
      Z(1020) = MUA*Z(376)
      Z(1021) = MUA*Z(377)
      Z(1022) = MUA*Z(378)
      Z(1023) = MUA*Z(379)
      Z(1024) = MUA*Z(380)
      Z(1025) = MUA*Z(381)
      Z(1026) = MUA*Z(384)
      Z(969) = MLA*Z(387)
      Z(970) = MLA*Z(395)
      Z(962) = MLA*Z(388)
      Z(963) = MLA*Z(389)
      Z(964) = MLA*Z(390)
      Z(965) = MLA*Z(391)
      Z(966) = MLA*Z(392)
      Z(967) = MLA*Z(393)
      Z(968) = MLA*Z(394)
      Z(960) = MFF*Z(41)
      Z(961) = MFF*Z(42)
      Z(984) = MRF*Z(41)
      Z(985) = MRF*Z(42)
      Z(1078) = MRF*Z(214)
      Z(1097) = MSH*Z(214)
      Z(1079) = MRF*Z(222)
      Z(1098) = MSH*Z(222)
      Z(1071) = MRF*Z(215)
      Z(1072) = MRF*Z(216)
      Z(1073) = MRF*Z(217)
      Z(1074) = MRF*Z(218)
      Z(1075) = MRF*Z(219)
      Z(1076) = MRF*Z(220)
      Z(1077) = MRF*Z(221)
      Z(1090) = MSH*Z(215)
      Z(1091) = MSH*Z(216)
      Z(1092) = MSH*Z(217)
      Z(1093) = MSH*Z(218)
      Z(1094) = MSH*Z(219)
      Z(1095) = MSH*Z(220)
      Z(1096) = MSH*Z(221)
      PX = Z(39)*(Z(957)*U1+Z(958)*U2+Z(981)*U1+Z(982)*U2) + Z(66)*(Z(10
     &69)+Z(1068)*U10+Z(1068)*U3+Z(1068)*U8+Z(1068)*U9) + Z(1)*(Z(943)*U
     &7+Z(944)*U1+Z(945)*U2+Z(946)*U6+Z(947)*U3+Z(948)*U5+Z(949)*U4) + Z
     &(35)*(Z(988)*U4+Z(988)*U6+Z(989)*U7+Z(990)*U3+Z(990)*U5+Z(991)*U1+
     &Z(992)*U2) + Z(37)*(Z(993)*U7+Z(994)*U1+Z(995)*U2+Z(996)*U6+Z(997)
     &*U3+Z(997)*U5+Z(998)*U4) + Z(54)*(Z(999)*U7+Z(1000)*U1+Z(1001)*U2+
     &Z(1002)*U6+Z(1003)*U3+Z(1003)*U5+Z(1004)*U4) + Z(56)*(Z(1005)*U7+Z
     &(1006)*U1+Z(1007)*U2+Z(1008)*U6+Z(1009)*U5+Z(1010)*U3+Z(1011)*U4) 
     &+ Z(57)*(Z(1109)*U7+Z(1110)*U1+Z(1111)*U2+Z(1112)*U6+Z(1113)*U3+Z(
     &1114)*U5+Z(1115)*U4) + Z(76)*(Z(1125)*U7+Z(1126)*U1+Z(1127)*U2+Z(1
     &128)*U6+Z(1129)*U5+Z(1130)*U4+Z(1131)*U3) + Z(83)*(Z(1012)*U7+Z(10
     &13)*U1+Z(1014)*U2+Z(1015)*U6+Z(1016)*U5+Z(1017)*U4+Z(1018)*U3) + Z
     &(81)*(Z(1067)+Z(971)*U13+Z(1059)*U11+Z(1060)*U7+Z(1061)*U1+Z(1062)
     &*U2+Z(1063)*U6+Z(1064)*U5+Z(1065)*U4+Z(1066)*U3) + Z(88)*(Z(980)+Z
     &(971)*U14+Z(972)*U12+Z(973)*U7+Z(974)*U1+Z(975)*U2+Z(976)*U6+Z(977
     &)*U5+Z(978)*U4+Z(979)*U3) + Z(72)*(Z(1038)+Z(1028)*U10+Z(1029)*U8+
     &Z(1030)*U9+Z(1031)*U7+Z(1032)*U1+Z(1033)*U2+Z(1034)*U6+Z(1035)*U5+
     &Z(1036)*U4+Z(1037)*U3) + Z(74)*(Z(1049)+Z(1039)*U10+Z(1040)*U8+Z(1
     &041)*U9+Z(1042)*U7+Z(1043)*U1+Z(1044)*U2+Z(1045)*U6+Z(1046)*U5+Z(1
     &047)*U4+Z(1048)*U3) + Z(62)*(Z(1089)+Z(1108)+Z(1080)*U9+Z(1099)*U9
     &+Z(1081)*U8+Z(1100)*U8+Z(1082)*U7+Z(1083)*U1+Z(1084)*U2+Z(1085)*U6
     &+Z(1086)*U5+Z(1087)*U4+Z(1088)*U3+Z(1101)*U7+Z(1102)*U1+Z(1103)*U2
     &+Z(1104)*U6+Z(1105)*U5+Z(1106)*U4+Z(1107)*U3) - 0.5D0*Z(986)*Z(52)
     &*(U3+U5-U4-U6) - 0.5D0*Z(987)*Z(48)*(U3+U5-U4-U6) - 0.5D0*Z(70)*(Z
     &(1070)+Z(987)*U10+Z(987)*U3+Z(987)*U8+Z(987)*U9) - Z(2)*(Z(950)*U7
     &+Z(951)*U1+Z(952)*U2+Z(953)*U6+Z(954)*U5+Z(955)*U4+Z(956)*U3) - Z(
     &59)*(Z(1124)-Z(1116)*U8-Z(1117)*U7-Z(1118)*U1-Z(1119)*U2-Z(1120)*U
     &6-Z(1121)*U5-Z(1122)*U4-Z(1123)*U3) - Z(78)*(Z(1139)-Z(1019)*U11-Z
     &(1132)*U7-Z(1133)*U1-Z(1134)*U2-Z(1135)*U6-Z(1136)*U5-Z(1137)*U4-Z
     &(1138)*U3) - Z(79)*(Z(1057)*U11-Z(1058)-Z(1050)*U7-Z(1051)*U1-Z(10
     &52)*U2-Z(1053)*U6-Z(1054)*U5-Z(1055)*U4-Z(1056)*U3) - Z(85)*(Z(102
     &7)-Z(1019)*U12-Z(1020)*U7-Z(1021)*U1-Z(1022)*U2-Z(1023)*U6-Z(1024)
     &*U5-Z(1025)*U4-Z(1026)*U3) - Z(86)*(Z(969)*U12-Z(970)-Z(962)*U7-Z(
     &963)*U1-Z(964)*U2-Z(965)*U6-Z(966)*U5-Z(967)*U4-Z(968)*U3) - Z(41)
     &*(Z(959)*U3+Z(959)*U5+Z(983)*U3+Z(983)*U5-Z(959)*U4-Z(959)*U6-Z(95
     &9)*U7-Z(983)*U4-Z(983)*U6-Z(983)*U7-Z(960)*U1-Z(961)*U2-Z(984)*U1-
     &Z(985)*U2) - Z(60)*(Z(1078)*U8+Z(1097)*U8-Z(1079)-Z(1098)-Z(1071)*
     &U7-Z(1072)*U1-Z(1073)*U2-Z(1074)*U6-Z(1075)*U5-Z(1076)*U4-Z(1077)*
     &U3-Z(1090)*U7-Z(1091)*U1-Z(1092)*U2-Z(1093)*U6-Z(1094)*U5-Z(1095)*
     &U4-Z(1096)*U3)
      PY = Z(40)*(Z(957)*U1+Z(958)*U2+Z(981)*U1+Z(982)*U2) + Z(67)*(Z(10
     &69)+Z(1068)*U10+Z(1068)*U3+Z(1068)*U8+Z(1068)*U9) + Z(1)*(Z(950)*U
     &7+Z(951)*U1+Z(952)*U2+Z(953)*U6+Z(954)*U5+Z(955)*U4+Z(956)*U3) + Z
     &(2)*(Z(943)*U7+Z(944)*U1+Z(945)*U2+Z(946)*U6+Z(947)*U3+Z(948)*U5+Z
     &(949)*U4) + Z(36)*(Z(988)*U4+Z(988)*U6+Z(989)*U7+Z(990)*U3+Z(990)*
     &U5+Z(991)*U1+Z(992)*U2) + Z(38)*(Z(993)*U7+Z(994)*U1+Z(995)*U2+Z(9
     &96)*U6+Z(997)*U3+Z(997)*U5+Z(998)*U4) + Z(54)*(Z(1005)*U7+Z(1006)*
     &U1+Z(1007)*U2+Z(1008)*U6+Z(1009)*U5+Z(1010)*U3+Z(1011)*U4) + Z(55)
     &*(Z(999)*U7+Z(1000)*U1+Z(1001)*U2+Z(1002)*U6+Z(1003)*U3+Z(1003)*U5
     &+Z(1004)*U4) + Z(58)*(Z(1109)*U7+Z(1110)*U1+Z(1111)*U2+Z(1112)*U6+
     &Z(1113)*U3+Z(1114)*U5+Z(1115)*U4) + Z(77)*(Z(1125)*U7+Z(1126)*U1+Z
     &(1127)*U2+Z(1128)*U6+Z(1129)*U5+Z(1130)*U4+Z(1131)*U3) + Z(84)*(Z(
     &1012)*U7+Z(1013)*U1+Z(1014)*U2+Z(1015)*U6+Z(1016)*U5+Z(1017)*U4+Z(
     &1018)*U3) + Z(82)*(Z(1067)+Z(971)*U13+Z(1059)*U11+Z(1060)*U7+Z(106
     &1)*U1+Z(1062)*U2+Z(1063)*U6+Z(1064)*U5+Z(1065)*U4+Z(1066)*U3) + Z(
     &89)*(Z(980)+Z(971)*U14+Z(972)*U12+Z(973)*U7+Z(974)*U1+Z(975)*U2+Z(
     &976)*U6+Z(977)*U5+Z(978)*U4+Z(979)*U3) + Z(73)*(Z(1038)+Z(1028)*U1
     &0+Z(1029)*U8+Z(1030)*U9+Z(1031)*U7+Z(1032)*U1+Z(1033)*U2+Z(1034)*U
     &6+Z(1035)*U5+Z(1036)*U4+Z(1037)*U3) + Z(75)*(Z(1049)+Z(1039)*U10+Z
     &(1040)*U8+Z(1041)*U9+Z(1042)*U7+Z(1043)*U1+Z(1044)*U2+Z(1045)*U6+Z
     &(1046)*U5+Z(1047)*U4+Z(1048)*U3) + Z(63)*(Z(1089)+Z(1108)+Z(1080)*
     &U9+Z(1099)*U9+Z(1081)*U8+Z(1100)*U8+Z(1082)*U7+Z(1083)*U1+Z(1084)*
     &U2+Z(1085)*U6+Z(1086)*U5+Z(1087)*U4+Z(1088)*U3+Z(1101)*U7+Z(1102)*
     &U1+Z(1103)*U2+Z(1104)*U6+Z(1105)*U5+Z(1106)*U4+Z(1107)*U3) - 0.5D0
     &*Z(986)*Z(53)*(U3+U5-U4-U6) - 0.5D0*Z(987)*Z(49)*(U3+U5-U4-U6) - 0
     &.5D0*Z(71)*(Z(1070)+Z(987)*U10+Z(987)*U3+Z(987)*U8+Z(987)*U9) - Z(
     &57)*(Z(1124)-Z(1116)*U8-Z(1117)*U7-Z(1118)*U1-Z(1119)*U2-Z(1120)*U
     &6-Z(1121)*U5-Z(1122)*U4-Z(1123)*U3) - Z(76)*(Z(1139)-Z(1019)*U11-Z
     &(1132)*U7-Z(1133)*U1-Z(1134)*U2-Z(1135)*U6-Z(1136)*U5-Z(1137)*U4-Z
     &(1138)*U3) - Z(80)*(Z(1057)*U11-Z(1058)-Z(1050)*U7-Z(1051)*U1-Z(10
     &52)*U2-Z(1053)*U6-Z(1054)*U5-Z(1055)*U4-Z(1056)*U3) - Z(83)*(Z(102
     &7)-Z(1019)*U12-Z(1020)*U7-Z(1021)*U1-Z(1022)*U2-Z(1023)*U6-Z(1024)
     &*U5-Z(1025)*U4-Z(1026)*U3) - Z(87)*(Z(969)*U12-Z(970)-Z(962)*U7-Z(
     &963)*U1-Z(964)*U2-Z(965)*U6-Z(966)*U5-Z(967)*U4-Z(968)*U3) - Z(42)
     &*(Z(959)*U3+Z(959)*U5+Z(983)*U3+Z(983)*U5-Z(959)*U4-Z(959)*U6-Z(95
     &9)*U7-Z(983)*U4-Z(983)*U6-Z(983)*U7-Z(960)*U1-Z(961)*U2-Z(984)*U1-
     &Z(985)*U2) - Z(61)*(Z(1078)*U8+Z(1097)*U8-Z(1079)-Z(1098)-Z(1071)*
     &U7-Z(1072)*U1-Z(1073)*U2-Z(1074)*U6-Z(1075)*U5-Z(1076)*U4-Z(1077)*
     &U3-Z(1090)*U7-Z(1091)*U1-Z(1092)*U2-Z(1093)*U6-Z(1094)*U5-Z(1095)*
     &U4-Z(1096)*U3)
      Z(1238) = Z(1172) + Z(1174) + Z(1175) + Z(1116)*Z(442) + MFF*(Z(27
     &4)*Z(469)+Z(299)*Z(470)) - Z(1176) - MSH*(Z(214)*Z(450)-Z(235)*Z(4
     &51)) - 0.25D0*MRF*(2*Z(1208)*Z(455)+2*Z(1209)*Z(456)+2*Z(239)*Z(53
     &5)*Z(456)+4*Z(11)*Z(239)*Z(455)+2*Z(1206)*Z(458)+4*Z(214)*Z(453)+2
     &*LRFFO*Z(535)*Z(454)+2*LRFFO*Z(537)*Z(453)+2*Z(214)*Z(535)*Z(459)+
     &4*Z(91)*Z(11)*Z(454)+4*Z(91)*Z(12)*Z(453)+4*Z(11)*Z(214)*Z(458)+4*
     &Z(12)*Z(239)*Z(458)-4*Z(91)*Z(455)-LRFFO*Z(456)-4*Z(12)*Z(214)*Z(4
     &55)-2*Z(214)*Z(537)*Z(456)-4*Z(239)*Z(454)-2*Z(1210)*Z(459)-2*Z(23
     &9)*Z(536)*Z(459))
      Z(305) = LFF + Z(285)
      Z(1307) = Z(518)*(Z(214)*Z(61)-Z(235)*Z(63)) + 0.5D0*Z(517)*(LRFFO
     &*Z(71)+2*Z(214)*Z(61)-2*Z(91)*Z(67)-2*Z(239)*Z(63)) + Z(1238) - Z(
     &1149)*Z(57) - Z(249)*VRX2*Z(64) - Z(249)*VRY2*Z(65) - Z(270)*VRX2*
     &Z(66) - Z(270)*VRY2*Z(67) - Z(274)*VRX1*Z(72) - Z(274)*VRY1*Z(73) 
     &- Z(305)*VRX1*Z(74) - Z(305)*VRY1*Z(75) - Z(515)*(Z(274)*Z(73)+Z(2
     &99)*Z(75))
      Z(1231) = Z(1230) + Z(1116)*Z(211) + MFF*(Z(274)*Z(282)+Z(299)*Z(2
     &98)) + 0.25D0*MRF*(Z(1197)+2*LRFFO*Z(214)*Z(537)+4*Z(91)*Z(12)*Z(2
     &14)+4*Z(239)*Z(238)-4*Z(1198)-4*Z(91)*Z(11)*Z(239)-2*LRFFO*Z(239)*
     &Z(535)-4*Z(214)*Z(221)-4*Z(91)*Z(11)*Z(238)-4*Z(91)*Z(12)*Z(221)-2
     &*LRFFO*Z(535)*Z(238)-2*LRFFO*Z(537)*Z(221)) - MSH*(Z(214)*Z(221)-Z
     &(235)*Z(234))
      Z(1232) = Z(1116)*Z(203) + MFF*(Z(274)*Z(276)+Z(299)*Z(286)) + 0.5
     &D0*MRF*(2*Z(239)*Z(223)-2*Z(214)*Z(215)-2*Z(91)*Z(11)*Z(223)-2*Z(9
     &1)*Z(12)*Z(215)-LRFFO*Z(535)*Z(223)-LRFFO*Z(537)*Z(215)) - MSH*(Z(
     &214)*Z(215)-Z(235)*Z(223))
      Z(1233) = Z(1116)*Z(204) + MFF*(Z(274)*Z(277)+Z(299)*Z(287)) + 0.5
     &D0*MRF*(2*Z(239)*Z(224)-2*Z(214)*Z(216)-2*Z(91)*Z(11)*Z(224)-2*Z(9
     &1)*Z(12)*Z(216)-LRFFO*Z(535)*Z(224)-LRFFO*Z(537)*Z(216)) - MSH*(Z(
     &214)*Z(216)-Z(235)*Z(224))
      Z(1234) = Z(1116)*Z(205) + MFF*(Z(274)*Z(278)+Z(299)*Z(288)) + 0.5
     &D0*MRF*(2*Z(239)*Z(225)-2*Z(214)*Z(217)-2*Z(91)*Z(11)*Z(225)-2*Z(9
     &1)*Z(12)*Z(217)-LRFFO*Z(535)*Z(225)-LRFFO*Z(537)*Z(217)) - MSH*(Z(
     &214)*Z(217)-Z(235)*Z(225))
      Z(1235) = Z(1116)*Z(206) + MFF*(Z(274)*Z(279)+Z(299)*Z(289)) + 0.5
     &D0*MRF*(2*Z(239)*Z(226)-2*Z(214)*Z(218)-2*Z(91)*Z(11)*Z(226)-2*Z(9
     &1)*Z(12)*Z(218)-LRFFO*Z(535)*Z(226)-LRFFO*Z(537)*Z(218)) - MSH*(Z(
     &214)*Z(218)-Z(235)*Z(226))
      Z(1236) = Z(1116)*Z(207) + MFF*(Z(274)*Z(280)+Z(299)*Z(290)) + 0.5
     &D0*MRF*(2*Z(239)*Z(228)-2*Z(214)*Z(219)-2*Z(91)*Z(11)*Z(228)-2*Z(9
     &1)*Z(12)*Z(219)-LRFFO*Z(535)*Z(228)-LRFFO*Z(537)*Z(219)) - MSH*(Z(
     &214)*Z(219)-Z(235)*Z(228))
      Z(1237) = Z(1116)*Z(209) + MFF*(Z(274)*Z(281)+Z(299)*Z(291)) + 0.5
     &D0*MRF*(2*Z(239)*Z(229)-2*Z(214)*Z(220)-2*Z(91)*Z(11)*Z(229)-2*Z(9
     &1)*Z(12)*Z(220)-LRFFO*Z(535)*Z(229)-LRFFO*Z(537)*Z(220)) - MSH*(Z(
     &214)*Z(220)-Z(235)*Z(229))
      RHTQ = -Z(1307) - Z(1231)*U3p - Z(1232)*U7p - Z(1233)*U1p - Z(1234
     &)*U2p - Z(1235)*U6p - Z(1236)*U5p - Z(1237)*U4p
      Z(1249) = Z(1172) + Z(1174) + Z(1175) + Z(1099)*Z(451) + MFF*(Z(27
     &5)*Z(469)+Z(300)*Z(470)) + 0.25D0*MRF*(LRFFO*Z(456)+4*Z(91)*Z(455)
     &+2*Z(1210)*Z(459)+4*LSH*Z(454)+2*LSH*Z(536)*Z(459)-2*Z(1208)*Z(455
     &)-2*Z(1209)*Z(456)-4*LSH*Z(11)*Z(455)-2*LSH*Z(535)*Z(456)-2*Z(1206
     &)*Z(458)-4*LSH*Z(12)*Z(458)-4*Z(91)*Z(11)*Z(454)-4*Z(91)*Z(12)*Z(4
     &53)-2*LRFFO*Z(535)*Z(454)-2*LRFFO*Z(537)*Z(453))
      Z(306) = LFF + Z(284)
      Z(1308) = 0.5D0*Z(517)*(LRFFO*Z(71)-2*LSH*Z(63)-2*Z(91)*Z(67)) + Z
     &(1249) - Z(1151)*Z(63) - Z(248)*VRX2*Z(64) - Z(248)*VRY2*Z(65) - Z
     &(271)*VRX2*Z(66) - Z(271)*VRY2*Z(67) - Z(275)*VRX1*Z(72) - Z(275)*
     &VRY1*Z(73) - Z(306)*VRX1*Z(74) - Z(306)*VRY1*Z(75) - Z(515)*(Z(275
     &)*Z(73)+Z(300)*Z(75))
      Z(1242) = Z(1239) + Z(1099)*Z(234) + MFF*(Z(275)*Z(282)+Z(300)*Z(2
     &98)) + 0.25D0*MRF*(Z(1197)+4*LSH*Z(238)-4*Z(1198)-4*Z(1240)*Z(11)-
     &2*Z(1241)*Z(535)-4*Z(91)*Z(11)*Z(238)-4*Z(91)*Z(12)*Z(221)-2*LRFFO
     &*Z(535)*Z(238)-2*LRFFO*Z(537)*Z(221))
      Z(1243) = Z(1099)*Z(223) + MFF*(Z(275)*Z(276)+Z(300)*Z(286)) + 0.5
     &D0*MRF*(2*LSH*Z(223)-2*Z(91)*Z(11)*Z(223)-2*Z(91)*Z(12)*Z(215)-LRF
     &FO*Z(535)*Z(223)-LRFFO*Z(537)*Z(215))
      Z(1244) = Z(1099)*Z(224) + MFF*(Z(275)*Z(277)+Z(300)*Z(287)) + 0.5
     &D0*MRF*(2*LSH*Z(224)-2*Z(91)*Z(11)*Z(224)-2*Z(91)*Z(12)*Z(216)-LRF
     &FO*Z(535)*Z(224)-LRFFO*Z(537)*Z(216))
      Z(1245) = Z(1099)*Z(225) + MFF*(Z(275)*Z(278)+Z(300)*Z(288)) + 0.5
     &D0*MRF*(2*LSH*Z(225)-2*Z(91)*Z(11)*Z(225)-2*Z(91)*Z(12)*Z(217)-LRF
     &FO*Z(535)*Z(225)-LRFFO*Z(537)*Z(217))
      Z(1246) = Z(1099)*Z(226) + MFF*(Z(275)*Z(279)+Z(300)*Z(289)) + 0.5
     &D0*MRF*(2*LSH*Z(226)-2*Z(91)*Z(11)*Z(226)-2*Z(91)*Z(12)*Z(218)-LRF
     &FO*Z(535)*Z(226)-LRFFO*Z(537)*Z(218))
      Z(1247) = Z(1099)*Z(228) + MFF*(Z(275)*Z(280)+Z(300)*Z(290)) + 0.5
     &D0*MRF*(2*LSH*Z(228)-2*Z(91)*Z(11)*Z(228)-2*Z(91)*Z(12)*Z(219)-LRF
     &FO*Z(535)*Z(228)-LRFFO*Z(537)*Z(219))
      Z(1248) = Z(1099)*Z(229) + MFF*(Z(275)*Z(281)+Z(300)*Z(291)) + 0.5
     &D0*MRF*(2*LSH*Z(229)-2*Z(91)*Z(11)*Z(229)-2*Z(91)*Z(12)*Z(220)-LRF
     &FO*Z(535)*Z(229)-LRFFO*Z(537)*Z(220))
      RKTQ = Z(1308) + Z(1242)*U3p + Z(1243)*U7p + Z(1244)*U1p + Z(1245)
     &*U2p + Z(1246)*U6p + Z(1247)*U5p + Z(1248)*U4p
      Z(1259) = Z(1172) + Z(1174) + MFF*(Z(273)*Z(469)+Z(297)*Z(470)) + 
     &0.25D0*MRF*(LRFFO*Z(456)+4*Z(91)*Z(455)+2*Z(1210)*Z(459)-2*Z(1208)
     &*Z(455)-2*Z(1209)*Z(456)-2*Z(1206)*Z(458)-4*Z(91)*Z(11)*Z(454)-4*Z
     &(91)*Z(12)*Z(453)-2*LRFFO*Z(535)*Z(454)-2*LRFFO*Z(537)*Z(453))
      Z(303) = LFF - Z(293)
      Z(1309) = 0.5D0*Z(517)*(LRFFO*Z(71)-2*Z(91)*Z(67)) + Z(1259) - Z(2
     &73)*VRX1*Z(72) - Z(273)*VRY1*Z(73) - Z(303)*VRX1*Z(74) - Z(303)*VR
     &Y1*Z(75) - LRF*(VRX2*Z(66)+VRY2*Z(67)) - Z(515)*(Z(273)*Z(73)+Z(29
     &7)*Z(75))
      Z(1252) = Z(1250) + MFF*(Z(273)*Z(282)+Z(297)*Z(298)) + 0.25D0*MRF
     &*(Z(1251)-4*Z(91)*Z(11)*Z(238)-4*Z(91)*Z(12)*Z(221)-2*LRFFO*Z(535)
     &*Z(238)-2*LRFFO*Z(537)*Z(221))
      Z(1253) = MFF*(Z(273)*Z(276)+Z(297)*Z(286)) - 0.5D0*MRF*(LRFFO*Z(5
     &35)*Z(223)+LRFFO*Z(537)*Z(215)+2*Z(91)*Z(11)*Z(223)+2*Z(91)*Z(12)*
     &Z(215))
      Z(1254) = MFF*(Z(273)*Z(277)+Z(297)*Z(287)) - 0.5D0*MRF*(LRFFO*Z(5
     &35)*Z(224)+LRFFO*Z(537)*Z(216)+2*Z(91)*Z(11)*Z(224)+2*Z(91)*Z(12)*
     &Z(216))
      Z(1255) = MFF*(Z(273)*Z(278)+Z(297)*Z(288)) - 0.5D0*MRF*(LRFFO*Z(5
     &35)*Z(225)+LRFFO*Z(537)*Z(217)+2*Z(91)*Z(11)*Z(225)+2*Z(91)*Z(12)*
     &Z(217))
      Z(1256) = MFF*(Z(273)*Z(279)+Z(297)*Z(289)) - 0.5D0*MRF*(LRFFO*Z(5
     &35)*Z(226)+LRFFO*Z(537)*Z(218)+2*Z(91)*Z(11)*Z(226)+2*Z(91)*Z(12)*
     &Z(218))
      Z(1257) = MFF*(Z(273)*Z(280)+Z(297)*Z(290)) - 0.5D0*MRF*(LRFFO*Z(5
     &35)*Z(228)+LRFFO*Z(537)*Z(219)+2*Z(91)*Z(11)*Z(228)+2*Z(91)*Z(12)*
     &Z(219))
      Z(1258) = MFF*(Z(273)*Z(281)+Z(297)*Z(291)) - 0.5D0*MRF*(LRFFO*Z(5
     &35)*Z(229)+LRFFO*Z(537)*Z(220)+2*Z(91)*Z(11)*Z(229)+2*Z(91)*Z(12)*
     &Z(220))
      RATQ = -Z(1309) - Z(1252)*U3p - Z(1253)*U7p - Z(1254)*U1p - Z(1255
     &)*U2p - Z(1256)*U6p - Z(1257)*U5p - Z(1258)*U4p
      Z(1268) = Z(1173) + Z(1019)*Z(484) - Z(1177) - MLA*(Z(342)*Z(492)-
     &Z(362)*Z(493))
      Z(1310) = Z(516)*(Z(342)*Z(80)-Z(362)*Z(82)) + Z(1268) - Z(1154)*Z
     &(76)
      Z(1261) = Z(1260) + Z(1019)*Z(339) - MLA*(Z(342)*Z(349)-Z(362)*Z(3
     &63))
      Z(1262) = Z(1019)*Z(331) - MLA*(Z(342)*Z(343)-Z(362)*Z(351))
      Z(1263) = Z(1019)*Z(332) - MLA*(Z(342)*Z(344)-Z(362)*Z(352))
      Z(1264) = Z(1019)*Z(333) - MLA*(Z(342)*Z(345)-Z(362)*Z(353))
      Z(1265) = Z(1019)*Z(334) - MLA*(Z(342)*Z(346)-Z(362)*Z(354))
      Z(1266) = Z(1019)*Z(335) - MLA*(Z(342)*Z(347)-Z(362)*Z(355))
      Z(1267) = Z(1019)*Z(336) - MLA*(Z(342)*Z(348)-Z(362)*Z(356))
      RSTQ = -Z(1310) - Z(1261)*U3p - Z(1262)*U7p - Z(1263)*U1p - Z(1264
     &)*U2p - Z(1265)*U6p - Z(1266)*U5p - Z(1267)*U4p
      Z(1276) = Z(1163) + Z(1019)*Z(501) - Z(1171) - MLA*(Z(387)*Z(509)-
     &Z(407)*Z(510))
      Z(1311) = Z(516)*(Z(387)*Z(87)-Z(407)*Z(89)) + Z(1276) - Z(1154)*Z
     &(83)
      Z(1269) = Z(1260) + Z(1019)*Z(384) - MLA*(Z(387)*Z(394)-Z(407)*Z(4
     &08))
      Z(1270) = Z(1019)*Z(376) - MLA*(Z(387)*Z(388)-Z(407)*Z(396))
      Z(1271) = Z(1019)*Z(377) - MLA*(Z(387)*Z(389)-Z(407)*Z(397))
      Z(1272) = Z(1019)*Z(378) - MLA*(Z(387)*Z(390)-Z(407)*Z(398))
      Z(1273) = Z(1019)*Z(379) - MLA*(Z(387)*Z(391)-Z(407)*Z(399))
      Z(1274) = Z(1019)*Z(380) - MLA*(Z(387)*Z(392)-Z(407)*Z(400))
      Z(1275) = Z(1019)*Z(381) - MLA*(Z(387)*Z(393)-Z(407)*Z(401))
      LSTQ = -Z(1311) - Z(1269)*U3p - Z(1270)*U7p - Z(1271)*U1p - Z(1272
     &)*U2p - Z(1273)*U6p - Z(1274)*U5p - Z(1275)*U4p
      Z(1158) = Z(1157)*Z(82)
      Z(1284) = Z(1173) + Z(971)*Z(493)
      Z(1305) = Z(1158) - Z(1284)
      Z(1277) = ILA + Z(971)*Z(363)
      Z(1278) = Z(971)*Z(351)
      Z(1279) = Z(971)*Z(352)
      Z(1280) = Z(971)*Z(353)
      Z(1281) = Z(971)*Z(354)
      Z(1282) = Z(971)*Z(355)
      Z(1283) = Z(971)*Z(356)
      RETQ = Z(1305) - Z(1277)*U3p - Z(1278)*U7p - Z(1279)*U1p - Z(1280)
     &*U2p - Z(1281)*U6p - Z(1282)*U5p - Z(1283)*U4p
      Z(1159) = Z(1157)*Z(89)
      Z(1292) = Z(1163) + Z(971)*Z(510)
      Z(1306) = Z(1159) - Z(1292)
      Z(1285) = ILA + Z(971)*Z(408)
      Z(1286) = Z(971)*Z(396)
      Z(1287) = Z(971)*Z(397)
      Z(1288) = Z(971)*Z(398)
      Z(1289) = Z(971)*Z(399)
      Z(1290) = Z(971)*Z(400)
      Z(1291) = Z(971)*Z(401)
      LETQ = Z(1306) - Z(1285)*U3p - Z(1286)*U7p - Z(1287)*U1p - Z(1288)
     &*U2p - Z(1289)*U6p - Z(1290)*U5p - Z(1291)*U4p
      POP1X = Q1
      POP1Y = Q2
      POP3X = Q1 - LFF*Z(39) - LRFF*Z(46)
      POP3Y = Q2 - LFF*Z(40) - LRFF*Z(47)
      POP4X = Q1 - LFF*Z(39) - LRF*Z(50)
      POP4Y = Q2 - LFF*Z(40) - LRF*Z(51)
      POP5X = Q1 - LFF*Z(39) - LRF*Z(50) - LSH*Z(35)
      POP5Y = Q2 - LFF*Z(40) - LRF*Z(51) - LSH*Z(36)
      POP6X = Q1 - LFF*Z(39) - LRF*Z(50) - LSH*Z(35) - LTH*Z(54)
      POP6Y = Q2 - LFF*Z(40) - LRF*Z(51) - LSH*Z(36) - LTH*Z(55)
      POP7X = Q1 + LTH*Z(57) - LFF*Z(39) - LRF*Z(50) - LSH*Z(35) - LTH*Z
     &(54)
      POP7Y = Q2 + LTH*Z(58) - LFF*Z(40) - LRF*Z(51) - LSH*Z(36) - LTH*Z
     &(55)
      POP8X = Q1 + LSH*Z(60) + LTH*Z(57) - LFF*Z(39) - LRF*Z(50) - LSH*Z
     &(35) - LTH*Z(54)
      POP8Y = Q2 + LSH*Z(61) + LTH*Z(58) - LFF*Z(40) - LRF*Z(51) - LSH*Z
     &(36) - LTH*Z(55)
      POP9X = Q1 + LRF*Z(64) + LSH*Z(60) + LTH*Z(57) - LFF*Z(39) - LRF*Z
     &(50) - LRFF*Z(68) - LSH*Z(35) - LTH*Z(54)
      POP9Y = Q2 + LRF*Z(65) + LSH*Z(61) + LTH*Z(58) - LFF*Z(40) - LRF*Z
     &(51) - LRFF*Z(69) - LSH*Z(36) - LTH*Z(55)
      POP10X = Q1 + LRF*Z(64) + LSH*Z(60) + LTH*Z(57) - LFF*Z(39) - LRF*
     &Z(50) - LSH*Z(35) - LTH*Z(54)
      POP10Y = Q2 + LRF*Z(65) + LSH*Z(61) + LTH*Z(58) - LFF*Z(40) - LRF*
     &Z(51) - LSH*Z(36) - LTH*Z(55)
      POP11X = Q1 + LFF*Z(72) + LRF*Z(64) + LSH*Z(60) + LTH*Z(57) - LFF*
     &Z(39) - LRF*Z(50) - LSH*Z(35) - LTH*Z(54)
      POP11Y = Q2 + LFF*Z(73) + LRF*Z(65) + LSH*Z(61) + LTH*Z(58) - LFF*
     &Z(40) - LRF*Z(51) - LSH*Z(36) - LTH*Z(55)
      POP12X = Q1 + LHAT*Z(1) - LFF*Z(39) - LRF*Z(50) - LSH*Z(35) - LTH*
     &Z(54)
      POP12Y = Q2 + LHAT*Z(2) - LFF*Z(40) - LRF*Z(51) - LSH*Z(36) - LTH*
     &Z(55)
      POP13X = Q1 + LHAT*Z(1) + LUA*Z(76) - LFF*Z(39) - LRF*Z(50) - LSH*
     &Z(35) - LTH*Z(54)
      POP13Y = Q2 + LHAT*Z(2) + LUA*Z(77) - LFF*Z(40) - LRF*Z(51) - LSH*
     &Z(36) - LTH*Z(55)
      POP14X = Q1 + LHAT*Z(1) + LLA*Z(79) + LUA*Z(76) - LFF*Z(39) - LRF*
     &Z(50) - LSH*Z(35) - LTH*Z(54)
      POP14Y = Q2 + LHAT*Z(2) + LLA*Z(80) + LUA*Z(77) - LFF*Z(40) - LRF*
     &Z(51) - LSH*Z(36) - LTH*Z(55)
      POP15X = Q1 + LHAT*Z(1) + LUA*Z(83) - LFF*Z(39) - LRF*Z(50) - LSH*
     &Z(35) - LTH*Z(54)
      POP15Y = Q2 + LHAT*Z(2) + LUA*Z(84) - LFF*Z(40) - LRF*Z(51) - LSH*
     &Z(36) - LTH*Z(55)
      POP16X = Q1 + LHAT*Z(1) + LLA*Z(86) + LUA*Z(83) - LFF*Z(39) - LRF*
     &Z(50) - LSH*Z(35) - LTH*Z(54)
      POP16Y = Q2 + LHAT*Z(2) + LLA*Z(87) + LUA*Z(84) - LFF*Z(40) - LRF*
     &Z(51) - LSH*Z(36) - LTH*Z(55)
      POCMX = Q1 + Z(95)*Z(1) + Z(97)*Z(79) + Z(97)*Z(86) + Z(102)*Z(76)
     & + Z(102)*Z(83) + Z(103)*Z(72) + Z(104)*Z(64) + Z(105)*Z(60) + Z(1
     &06)*Z(57) - Z(96)*Z(39) - Z(100)*Z(35) - Z(101)*Z(54) - 0.5D0*Z(98
     &)*Z(50) - 0.5D0*Z(99)*Z(46) - 0.5D0*Z(99)*Z(68)
      POCMY = Q2 + Z(95)*Z(2) + Z(97)*Z(80) + Z(97)*Z(87) + Z(102)*Z(77)
     & + Z(102)*Z(84) + Z(103)*Z(73) + Z(104)*Z(65) + Z(105)*Z(61) + Z(1
     &06)*Z(58) - Z(96)*Z(40) - Z(100)*Z(36) - Z(101)*Z(55) - 0.5D0*Z(98
     &)*Z(51) - 0.5D0*Z(99)*Z(47) - 0.5D0*Z(99)*Z(69)
      Z(414) = Z(97)*(LEp-LSp)
      Z(415) = Z(102)*LSp
      Z(416) = Z(103)*(RKp-RAp-RHp-RMTPp)
      Z(417) = Z(97)*(REp-RSp)
      Z(418) = Z(104)*(RAp+RHp-RKp)
      Z(419) = Z(99)*(RAp+RHp-RKp)
      Z(420) = Z(105)*(RHp-RKp)
      Z(421) = Z(106)*RHp
      Z(422) = Z(102)*RSp
      VOCMX = U1 + Z(100)*Z(37)*(U4-U3-U5) + Z(81)*(Z(417)+Z(97)*U11+Z(9
     &7)*U13+Z(97)*U3) + Z(88)*(Z(414)+Z(97)*U12+Z(97)*U14+Z(97)*U3) + Z
     &(74)*(Z(416)+Z(103)*U10+Z(103)*U3+Z(103)*U8+Z(103)*U9) + 0.5D0*Z(7
     &0)*(Z(419)-Z(99)*U10-Z(99)*U3-Z(99)*U8-Z(99)*U9) - Z(95)*Z(2)*U3 -
     & Z(101)*Z(56)*(U3-U4) - Z(59)*(Z(421)-Z(106)*U3-Z(106)*U8) - Z(78)
     &*(Z(422)-Z(102)*U11-Z(102)*U3) - Z(85)*(Z(415)-Z(102)*U12-Z(102)*U
     &3) - 0.5D0*Z(98)*Z(52)*(U3+U5-U4-U6) - 0.5D0*Z(99)*Z(48)*(U3+U5-U4
     &-U6) - Z(96)*Z(41)*(U3+U5-U4-U6-U7) - Z(62)*(Z(420)-Z(105)*U3-Z(10
     &5)*U8-Z(105)*U9) - Z(66)*(Z(418)-Z(104)*U10-Z(104)*U3-Z(104)*U8-Z(
     &104)*U9)
      VOCMY = U2 + Z(95)*Z(1)*U3 + Z(100)*Z(38)*(U4-U3-U5) + Z(82)*(Z(41
     &7)+Z(97)*U11+Z(97)*U13+Z(97)*U3) + Z(89)*(Z(414)+Z(97)*U12+Z(97)*U
     &14+Z(97)*U3) + Z(75)*(Z(416)+Z(103)*U10+Z(103)*U3+Z(103)*U8+Z(103)
     &*U9) + 0.5D0*Z(71)*(Z(419)-Z(99)*U10-Z(99)*U3-Z(99)*U8-Z(99)*U9) -
     & Z(101)*Z(54)*(U3-U4) - Z(57)*(Z(421)-Z(106)*U3-Z(106)*U8) - Z(76)
     &*(Z(422)-Z(102)*U11-Z(102)*U3) - Z(83)*(Z(415)-Z(102)*U12-Z(102)*U
     &3) - 0.5D0*Z(98)*Z(53)*(U3+U5-U4-U6) - 0.5D0*Z(99)*Z(49)*(U3+U5-U4
     &-U6) - Z(96)*Z(42)*(U3+U5-U4-U6-U7) - Z(63)*(Z(420)-Z(105)*U3-Z(10
     &5)*U8-Z(105)*U9) - Z(67)*(Z(418)-Z(104)*U10-Z(104)*U3-Z(104)*U8-Z(
     &104)*U9)
      RMTQ = MTPK*(3.141592653589793D0-RMTP) - MTPB*RMTPp
      VRX = VRX1 + VRX2
      VRY = VRY1 + VRY2
      RX = RX1 + RX2
      RY = RY1 + RY2

C**   Write output to screen and to output file(s)
      WRITE(*, 6020) T,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,P
     &OP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,POP10X,
     &POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP13X,POP13Y,POP14X,POP14Y,POP
     &15X,POP15Y,POP16X,POP16Y,POCMX,POCMY,VOCMX,VOCMY
      WRITE(21,6020) T,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,P
     &OP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,POP10X,
     &POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP13X,POP13Y,POP14X,POP14Y,POP
     &15X,POP15Y,POP16X,POP16Y,POCMX,POCMY,VOCMX,VOCMY
      WRITE(22,6020) T,Q1,Q2,Q3,Q4,Q5,Q6,Q7,U1,U2,U3,U4,U5,U6,U7
      WRITE(23,6020) T,VRX,VRY,RX,RY,VRX1,VRY1,VRX2,VRY2,RX1,RX2,RY1,RY2
     &
      WRITE(24,6020) T,RHTQ,LHTQ,RKTQ,LKTQ,RATQ,LATQ,RMTQ,LMTQ,RSTQ,LSTQ
     &,RETQ,LETQ
      WRITE(25,6020) T,RH,LH,RK,LK,RA,LA,RMTP,LMTP,RS,LS,RE,LE,RHp,LHp,R
     &Kp,LKp,RAp,LAp,RMTPp,LMTPp,RSp,LSp,REp,LEp,RHpp,LHpp,RKpp,LKpp,RAp
     &p,LApp,RMTPpp,LMTPpp,RSpp,LSpp,REpp,LEpp
      WRITE(26,6020) T,KECM,HZ,PX,PY

6020  FORMAT( 99(1X, 1PE14.6E3) )

      RETURN
      END


