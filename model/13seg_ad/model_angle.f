C**   The name of this program is model/arms/model_angle.f
C**   Created by AUTOLEV 3.2 on Tue Jun 21 13:23:13 2022

      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          ILOOP, IPRINT, PRINTINT
      CHARACTER        MESSAGE(99)
      EXTERNAL         EQNS1
      DIMENSION        VAR(6)
      COMMON/CONSTNTS/ FOOTANG,G,IFF,IHAT,ILLA,ILUA,IRF,IRLA,IRUA,ISH,IT
     &H,K1,K2,K3,K4,K5,K6,K7,K8,LFF,LFFO,LHAT,LHATO,LLA,LLAO,LMTPXI,LRF,
     &LRFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,LTOEXI,LUA,LUAO,MFF,MHAT,MLLA,ML
     &UA,MRF,MRLA,MRUA,MSH,MTH,MTPB,MTPK,RMTPXI,RTOEXI
      COMMON/SPECFIED/ LA,LE,LH,LK,LMTP,LS,RA,RE,RH,RK,RMTP,RS,LAp,LEp,L
     &Hp,LKp,LMTPp,LSp,RAp,REp,RHp,RKp,RMTPp,RSp,LApp,LEpp,LHpp,LKpp,LMT
     &Ppp,LSpp,RApp,REpp,RHpp,RKpp,RMTPpp,RSpp
      COMMON/VARIBLES/ Q1,Q2,Q3,U1,U2,U3
      COMMON/ALGBRAIC/ HZ,KECM,LATQ,LETQ,LHTQ,LKTQ,LRX1,LRX2,LRY1,LRY2,L
     &STQ,PX,PY,RATQ,RETQ,RHTQ,RKTQ,RRX1,RRX2,RRY1,RRY2,RSTQ,U10,U11,U12
     &,U13,U4,U5,U6,U7,U8,U9,Q1p,Q2p,Q3p,U1p,U2p,U3p,DLX1,DLX2,DRX1,DRX2
     &,LMTQ,LRX,LRY,POCMX,POCMY,POP10X,POP10Y,POP11X,POP11Y,POP12X,POP12
     &Y,POP13X,POP13Y,POP14X,POP14Y,POP15X,POP15Y,POP16X,POP16Y,POP1X,PO
     &P1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,PO
     &P7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,RMTQ,RRX,RRY,VOCMX,VOCMY,VOP10X,
     &VOP10Y,VOP11X,VOP11Y,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(1299),COEF(3,3),RHS(3)

C**   Open input and output files
      OPEN(UNIT=20, FILE='model/arms/model_angle.in', STATUS='OLD')
      OPEN(UNIT=21, FILE='model/arms/model_angle.1',  STATUS='UNKNOWN')
      OPEN(UNIT=22, FILE='model/arms/model_angle.2',  STATUS='UNKNOWN')
      OPEN(UNIT=23, FILE='model/arms/model_angle.3',  STATUS='UNKNOWN')
      OPEN(UNIT=24, FILE='model/arms/model_angle.4',  STATUS='UNKNOWN')
      OPEN(UNIT=25, FILE='model/arms/model_angle.5',  STATUS='UNKNOWN')
      OPEN(UNIT=26, FILE='model/arms/model_angle.6',  STATUS='UNKNOWN')

C**   Read message from input file
      READ(20,7000,END=7100,ERR=7101) (MESSAGE(ILOOP),ILOOP = 1,99)

C**   Read values of constants from input file
      READ(20,7010,END=7100,ERR=7101) FOOTANG,G,IFF,IHAT,ILLA,ILUA,IRF,I
     &RLA,IRUA,ISH,ITH,K1,K2,K3,K4,K5,K6,K7,K8,LFF,LFFO,LHAT,LHATO,LLA,L
     &LAO,LMTPXI,LRF,LRFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,LTOEXI,LUA,LUAO,M
     &FF,MHAT,MLLA,MLUA,MRF,MRLA,MRUA,MSH,MTH,MTPB,MTPK,RMTPXI,RTOEXI

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

C**   Evaluate constants
      U4 = 0
      U5 = 0
      U6 = 0
      U7 = 0
      U8 = 0
      U9 = 0
      U10 = 0
      U11 = 0
      U12 = 0
      U13 = 0
      Z(548) = G*MSH
      Z(545) = G*MFF
      Z(1166) = LFFO*Z(545)
      Z(547) = G*MRF
      Z(27) = COS(FOOTANG)
      Z(1089) = LLAO*MRLA
      Z(1007) = LLAO*MLLA
      Z(28) = SIN(FOOTANG)
      Z(90) = LFF - LFFO
      Z(91) = LRF - 0.5D0*LRFO
      Z(92) = LSH - LSHO
      Z(93) = LTH - LTHO
      Z(94) = MHAT + MLLA + MLUA + MRLA + MRUA + 2*MFF + 2*MRF + 2*MSH +
     & 2*MTH
      Z(95) = (LHAT*MLLA+LHAT*MLUA+LHAT*MRLA+LHAT*MRUA+LHATO*MHAT)/Z(94)
      Z(96) = (LFF*MFF+LFF*MHAT+LFF*MLLA+LFF*MLUA+LFF*MRLA+LFF*MRUA+LFFO
     &*MFF+2*LFF*MRF+2*LFF*MSH+2*LFF*MTH)/Z(94)
      Z(97) = LLAO*MLLA/Z(94)
      Z(98) = (LRFO*MRF+2*LRF*MFF+2*LRF*MHAT+2*LRF*MLLA+2*LRF*MLUA+2*LRF
     &*MRF+2*LRF*MRLA+2*LRF*MRUA+4*LRF*MSH+4*LRF*MTH)/Z(94)
      Z(99) = LRFFO*MRF/Z(94)
      Z(100) = (LSH*MFF+LSH*MHAT+LSH*MLLA+LSH*MLUA+LSH*MRF+LSH*MRLA+LSH*
     &MRUA+LSH*MSH+LSHO*MSH+2*LSH*MTH)/Z(94)
      Z(101) = (LTH*MFF+LTH*MHAT+LTH*MLLA+LTH*MLUA+LTH*MRF+LTH*MRLA+LTH*
     &MRUA+LTH*MSH+LTH*MTH+LTHO*MTH)/Z(94)
      Z(102) = (LUA*MLLA+LUAO*MLUA)/Z(94)
      Z(103) = MFF*Z(90)/Z(94)
      Z(104) = LLAO*MRLA/Z(94)
      Z(105) = (LRF*MFF+MRF*Z(91))/Z(94)
      Z(106) = (LSH*MFF+LSH*MRF+MSH*Z(92))/Z(94)
      Z(107) = (LTH*MFF+LTH*MRF+LTH*MSH+MTH*Z(93))/Z(94)
      Z(108) = (LUA*MRLA+LUAO*MRUA)/Z(94)
      Z(544) = G*MHAT
      Z(546) = G*MLLA
      Z(549) = G*MTH
      Z(550) = G*MLUA
      Z(551) = G*MRLA
      Z(552) = G*MRUA
      Z(582) = LSH - Z(100)
      Z(583) = LTH - Z(101)
      Z(584) = LFF - Z(96)
      Z(585) = 2*LRF - Z(98)
      Z(678) = LUA - Z(102)
      Z(679) = LHAT - Z(95)
      Z(684) = Z(96) - LFF
      Z(685) = 0.5D0*Z(98) - 0.5D0*LRFO
      Z(686) = 0.5D0*Z(99) - 0.5D0*LRFFO
      Z(876) = LSH - Z(106)
      Z(877) = LTH - Z(107)
      Z(878) = LRF - Z(105)
      Z(899) = LUA - Z(108)
      Z(904) = 0.5D0*Z(98) - LRF
      Z(905) = Z(100) - LSH
      Z(906) = Z(101) - LTH
      Z(907) = LRF - 0.5D0*LRFO - Z(105)
      Z(954) = 2*Z(685) + 2*Z(27)*Z(686)
      Z(956) = 2*Z(686) + 2*Z(27)*Z(685)
      Z(968) = Z(27)*Z(686)
      Z(970) = Z(27)*Z(907)
      Z(997) = LFFO*MFF
      Z(1020) = LFF*MRF
      Z(1022) = LRFO*MRF
      Z(1024) = LRFFO*MRF
      Z(1053) = LUAO*MLUA
      Z(1098) = MRF*Z(91)
      Z(1109) = LSH*MRF
      Z(1126) = MSH*Z(92)
      Z(1141) = MTH*Z(93)
      Z(1156) = LUAO*MRUA
      Z(1168) = Z(93)*Z(549)
      Z(1171) = Z(92)*Z(548)
      Z(1176) = LUAO*Z(552)
      Z(1178) = LUAO*Z(550)
      Z(1180) = LLAO*Z(551)
      Z(1182) = LLAO*Z(546)
      Z(1211) = IHAT + ILLA + ILUA + IRLA + IRUA + 2*IFF + 2*IRF + 2*ISH
     & + 2*ITH + MFF*LFFO**2
      Z(1212) = LRFFO**2 + LRFO**2 + 4*LFF**2 + 2*LRFFO*LRFO*Z(27)
      Z(1213) = LFF*LRFFO
      Z(1214) = LFF*LRFO
      Z(1215) = LRFFO**2 + 4*Z(91)**2
      Z(1216) = LRFFO*Z(27)*Z(91)
      Z(1218) = LRFFO*Z(27)
      Z(1219) = LRFO*Z(27)
      Z(1220) = LRFFO*Z(28)
      Z(1221) = LRFO*Z(28)
      Z(1222) = Z(27)*Z(91)
      Z(1223) = Z(28)*Z(91)
      Z(1225) = IFF + IRF + ISH + ITH
      Z(1226) = LRFFO**2
      Z(1227) = Z(91)**2
      Z(1232) = IFF + IRF + ISH + ITH + MFF*LFFO**2
      Z(1237) = IFF + IRF + ISH
      Z(1238) = LSH*Z(91)
      Z(1239) = LRFFO*LSH
      Z(1244) = IFF + IRF + ISH + MFF*LFFO**2
      Z(1249) = IFF + IRF
      Z(1250) = LRFFO**2 + 4*Z(91)**2 - 4*LRFFO*Z(27)*Z(91)
      Z(1255) = IFF + IRF + MFF*LFFO**2
      Z(1260) = IRLA + IRUA
      Z(1265) = ILLA + ILUA

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

6021  FORMAT(1X,'FILE: model/arms/model_angle.1 ',//1X,'*** ',99A1,///,8
     &X,'T',12X,'POP1X',10X,'POP1Y',10X,'POP2X',10X,'POP2Y',10X,'POP3X',
     &10X,'POP3Y',10X,'POP4X',10X,'POP4Y',10X,'POP5X',10X,'POP5Y',10X,'P
     &OP6X',10X,'POP6Y',10X,'POP7X',10X,'POP7Y',10X,'POP8X',10X,'POP8Y',
     &10X,'POP9X',10X,'POP9Y',9X,'POP10X',9X,'POP10Y',9X,'POP11X',9X,'PO
     &P11Y',9X,'POP12X',9X,'POP12Y',9X,'POP13X',9X,'POP13Y',9X,'POP14X',
     &9X,'POP14Y',9X,'POP15X',9X,'POP15Y',9X,'POP16X',9X,'POP16Y',10X,'P
     &OCMX',10X,'POCMY',10X,'VOCMX',10X,'VOCMY',/,5X,'(UNITS)',8X,'(UNIT
     &S)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS
     &)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)
     &',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)'
     &,8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',
     &8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8
     &X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X
     &,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6022  FORMAT(1X,'FILE: model/arms/model_angle.2 ',//1X,'*** ',99A1,///,8
     &X,'T',13X,'Q1',13X,'Q2',13X,'Q3',13X,'U1',13X,'U2',13X,'U3',/,5X,'
     &(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(
     &UNITS)',8X,'(UNITS)',/)
6023  FORMAT(1X,'FILE: model/arms/model_angle.3 ',//1X,'*** ',99A1,///,8
     &X,'T',13X,'RRX',12X,'RRY',12X,'LRX',12X,'LRY',11X,'RRX1',11X,'RRY1
     &',11X,'RRX2',11X,'RRY2',11X,'LRX1',11X,'LRX2',11X,'LRY1',11X,'LRY2
     &',/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS
     &)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)
     &',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6024  FORMAT(1X,'FILE: model/arms/model_angle.4 ',//1X,'*** ',99A1,///,8
     &X,'T',12X,'RHTQ',11X,'LHTQ',11X,'RKTQ',11X,'LKTQ',11X,'RATQ',11X,'
     &LATQ',11X,'RMTQ',11X,'LMTQ',11X,'RSTQ',11X,'LSTQ',11X,'RETQ',11X,'
     &LETQ',/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(U
     &NITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UN
     &ITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6025  FORMAT(1X,'FILE: model/arms/model_angle.5 ',//1X,'*** ',99A1,///,8
     &X,'T',13X,'RH',13X,'LH',13X,'RK',13X,'LK',13X,'RA',13X,'LA',12X,'R
     &MTP',11X,'LMTP',12X,'RS',13X,'LS',13X,'RE',13X,'LE',13X,'RH''',12X
     &,'LH''',12X,'RK''',12X,'LK''',12X,'RA''',12X,'LA''',11X,'RMTP''',1
     &0X,'LMTP''',11X,'RS''',12X,'LS''',12X,'RE''',12X,'LE''',11X,'RH'''
     &'',11X,'LH''''',11X,'RK''''',11X,'LK''''',11X,'RA''''',11X,'LA''''
     &',10X,'RMTP''''',9X,'LMTP''''',10X,'RS''''',11X,'LS''''',11X,'RE''
     &''',11X,'LE''''',/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNI
     &TS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNIT
     &S)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS
     &)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)
     &',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)'
     &,8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',
     &8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8
     &X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6026  FORMAT(1X,'FILE: model/arms/model_angle.6 ',//1X,'*** ',99A1,///,8
     &X,'T',12X,'KECM',12X,'HZ',13X,'PX',13X,'PY',/,5X,'(UNITS)',8X,'(UN
     &ITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6997  FORMAT(/7X,'Error: Numerical integration failed to converge',/)
6999  FORMAT(//1X,'Input is in the file model/arms/model_angle.in',//1X,
     &'Output is in the file(s) model/arms/model_angle.i  (i=1, ..., 6)'
     &,//1X,'The output quantities and associated files are listed in fi
     &le model/arms/model_angle.dir',/)
7000  FORMAT(//,99A1,///)
7010  FORMAT( 1000(59X,E30.0,/) )
7011  FORMAT( 3(59X,E30.0,/), 1(59X,I30,/), 2(59X,E30.0,/) )
      STOP
7100  WRITE(*,*) 'Premature end of file while reading model/arms/model_a
     &ngle.in '
7101  WRITE(*,*) 'Error while reading file model/arms/model_angle.in'
      STOP
      END


C**********************************************************************
      SUBROUTINE       EQNS1(T, VAR, VARp, BOUNDARY)
      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          BOUNDARY
      DIMENSION        VAR(*), VARp(*)
      COMMON/CONSTNTS/ FOOTANG,G,IFF,IHAT,ILLA,ILUA,IRF,IRLA,IRUA,ISH,IT
     &H,K1,K2,K3,K4,K5,K6,K7,K8,LFF,LFFO,LHAT,LHATO,LLA,LLAO,LMTPXI,LRF,
     &LRFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,LTOEXI,LUA,LUAO,MFF,MHAT,MLLA,ML
     &UA,MRF,MRLA,MRUA,MSH,MTH,MTPB,MTPK,RMTPXI,RTOEXI
      COMMON/SPECFIED/ LA,LE,LH,LK,LMTP,LS,RA,RE,RH,RK,RMTP,RS,LAp,LEp,L
     &Hp,LKp,LMTPp,LSp,RAp,REp,RHp,RKp,RMTPp,RSp,LApp,LEpp,LHpp,LKpp,LMT
     &Ppp,LSpp,RApp,REpp,RHpp,RKpp,RMTPpp,RSpp
      COMMON/VARIBLES/ Q1,Q2,Q3,U1,U2,U3
      COMMON/ALGBRAIC/ HZ,KECM,LATQ,LETQ,LHTQ,LKTQ,LRX1,LRX2,LRY1,LRY2,L
     &STQ,PX,PY,RATQ,RETQ,RHTQ,RKTQ,RRX1,RRX2,RRY1,RRY2,RSTQ,U10,U11,U12
     &,U13,U4,U5,U6,U7,U8,U9,Q1p,Q2p,Q3p,U1p,U2p,U3p,DLX1,DLX2,DRX1,DRX2
     &,LMTQ,LRX,LRY,POCMX,POCMY,POP10X,POP10Y,POP11X,POP11Y,POP12X,POP12
     &Y,POP13X,POP13Y,POP14X,POP14Y,POP15X,POP15Y,POP16X,POP16Y,POP1X,PO
     &P1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,PO
     &P7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,RMTQ,RRX,RRY,VOCMX,VOCMY,VOP10X,
     &VOP10Y,VOP11X,VOP11Y,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(1299),COEF(3,3),RHS(3)

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
      Z(506) = LHATO*U3
      Z(508) = LHAT*U3

C**   Quantities to be specified
      LA = 0
      LE = 0
      LH = 0
      LK = 0
      LMTP = 0
      LS = 0
      RA = 0
      RE = 0
      RH = 0
      RK = 0
      RMTP = 0
      RS = 0
      LAp = 0
      LEp = 0
      LHp = 0
      LKp = 0
      LMTPp = 0
      LSp = 0
      RAp = 0
      REp = 0
      RHp = 0
      RKp = 0
      RMTPp = 0
      RSp = 0
      LApp = 0
      LEpp = 0
      LHpp = 0
      LKpp = 0
      LMTPpp = 0
      LSpp = 0
      RApp = 0
      REpp = 0
      RHpp = 0
      RKpp = 0
      RMTPpp = 0
      RSpp = 0

      Z(16) = SIN(RMTP)
      Z(11) = COS(RA)
      Z(8) = SIN(RK)
      Z(3) = COS(RH)
      Z(4) = SIN(RH)
      Z(58) = Z(3)*Z(2) - Z(4)*Z(1)
      Z(7) = COS(RK)
      Z(57) = Z(3)*Z(1) + Z(4)*Z(2)
      Z(63) = Z(8)*Z(58) - Z(7)*Z(57)
      Z(12) = SIN(RA)
      Z(61) = -Z(7)*Z(58) - Z(8)*Z(57)
      Z(67) = -Z(11)*Z(63) - Z(12)*Z(61)
      Z(15) = COS(RMTP)
      Z(65) = Z(12)*Z(63) - Z(11)*Z(61)
      Z(73) = Z(16)*Z(67) - Z(15)*Z(65)
      Z(13) = COS(LA)
      Z(17) = COS(LMTP)
      Z(14) = SIN(LA)
      Z(18) = SIN(LMTP)
      Z(29) = Z(13)*Z(17) - Z(14)*Z(18)
      Z(5) = COS(LH)
      Z(9) = COS(LK)
      Z(6) = SIN(LH)
      Z(10) = SIN(LK)
      Z(32) = -Z(5)*Z(9) - Z(6)*Z(10)
      Z(33) = Z(6)*Z(9) - Z(5)*Z(10)
      Z(36) = Z(32)*Z(2) + Z(33)*Z(1)
      Z(30) = -Z(13)*Z(18) - Z(14)*Z(17)
      Z(34) = Z(5)*Z(10) - Z(6)*Z(9)
      Z(38) = Z(32)*Z(1) + Z(34)*Z(2)
      Z(40) = Z(29)*Z(36) + Z(30)*Z(38)
      Z(51) = Z(14)*Z(38) - Z(13)*Z(36)
      Z(55) = Z(5)*Z(2) - Z(6)*Z(1)
      POP11Y = Q2 + LFF*Z(73) + LRF*Z(65) + LSH*Z(61) + LTH*Z(58) - LFF*
     &Z(40) - LRF*Z(51) - LSH*Z(36) - LTH*Z(55)
      Z(209) = Z(3)*Z(5) + Z(4)*Z(6)
      Z(157) = LKp - LAp - LHp - LMTPp
      Z(159) = LFF*Z(157)
      Z(170) = Z(18)*Z(159)
      Z(174) = Z(17)*Z(159)
      Z(160) = LKp - LAp - LHp
      Z(175) = LRF*Z(160)
      Z(177) = Z(174) - Z(175)
      Z(185) = Z(14)*Z(170) - Z(13)*Z(177)
      Z(186) = LKp - LHp
      Z(190) = LSH*Z(186)
      Z(192) = Z(185) - Z(190)
      Z(181) = -Z(13)*Z(170) - Z(14)*Z(177)
      Z(197) = Z(10)*Z(192) - Z(9)*Z(181)
      Z(211) = Z(3)*Z(6) - Z(4)*Z(5)
      Z(202) = -Z(9)*Z(192) - Z(10)*Z(181)
      Z(206) = LTH*LHp
      Z(208) = Z(202) + Z(206)
      Z(217) = Z(209)*Z(197) + Z(211)*Z(208)
      Z(210) = Z(4)*Z(5) - Z(3)*Z(6)
      Z(223) = Z(209)*Z(208) + Z(210)*Z(197)
      Z(227) = LTH*RHp
      Z(229) = Z(223) - Z(227)
      Z(245) = Z(8)*Z(217) - Z(7)*Z(229)
      Z(246) = RKp - RHp
      Z(251) = LSH*Z(246)
      Z(254) = Z(245) + Z(251)
      Z(237) = -Z(7)*Z(217) - Z(8)*Z(229)
      Z(279) = -Z(11)*Z(254) - Z(12)*Z(237)
      Z(255) = RKp - RAp - RHp
      Z(280) = LRF*Z(255)
      Z(284) = Z(279) + Z(280)
      Z(270) = Z(12)*Z(254) - Z(11)*Z(237)
      Z(294) = Z(16)*Z(284) - Z(15)*Z(270)
      Z(285) = LRF*Z(16)
      Z(167) = LFF*Z(18)
      Z(173) = LFF*Z(17)
      Z(176) = Z(173) - LRF
      Z(182) = Z(14)*Z(167) - Z(13)*Z(176)
      Z(178) = -Z(13)*Z(167) - Z(14)*Z(176)
      Z(193) = Z(10)*Z(182) - Z(9)*Z(178)
      Z(198) = -Z(9)*Z(182) - Z(10)*Z(178)
      Z(212) = Z(193)*Z(209) + Z(198)*Z(211)
      Z(218) = Z(193)*Z(210) + Z(198)*Z(209)
      Z(238) = Z(8)*Z(212) - Z(7)*Z(218)
      Z(230) = -Z(7)*Z(212) - Z(8)*Z(218)
      Z(272) = -Z(11)*Z(238) - Z(12)*Z(230)
      Z(263) = Z(12)*Z(238) - Z(11)*Z(230)
      Z(286) = Z(16)*Z(272) - Z(15)*Z(263)
      Z(191) = Z(182) - LSH
      Z(194) = Z(10)*Z(191) - Z(9)*Z(178)
      Z(199) = -Z(9)*Z(191) - Z(10)*Z(178)
      Z(207) = Z(199) - LTH
      Z(213) = Z(194)*Z(209) + Z(207)*Z(211)
      Z(220) = Z(194)*Z(210) + Z(207)*Z(209)
      Z(240) = Z(8)*Z(213) - Z(7)*Z(220)
      Z(232) = -Z(7)*Z(213) - Z(8)*Z(220)
      Z(274) = -Z(11)*Z(240) - Z(12)*Z(232)
      Z(264) = Z(12)*Z(240) - Z(11)*Z(232)
      Z(287) = Z(16)*Z(274) - Z(15)*Z(264)
      Z(214) = Z(194)*Z(209) + Z(199)*Z(211)
      Z(219) = Z(194)*Z(210) + Z(199)*Z(209)
      Z(241) = Z(8)*Z(214) - Z(7)*Z(219)
      Z(233) = -Z(7)*Z(214) - Z(8)*Z(219)
      Z(275) = -Z(11)*Z(241) - Z(12)*Z(233)
      Z(265) = Z(12)*Z(241) - Z(11)*Z(233)
      Z(288) = Z(16)*Z(275) - Z(15)*Z(265)
      Z(228) = LTH + Z(220)
      Z(239) = Z(8)*Z(213) - Z(7)*Z(228)
      Z(252) = LSH + Z(239)
      Z(231) = -Z(7)*Z(213) - Z(8)*Z(228)
      Z(273) = -Z(11)*Z(252) - Z(12)*Z(231)
      Z(281) = LRF + Z(273)
      Z(266) = Z(12)*Z(252) - Z(11)*Z(231)
      Z(289) = Z(16)*Z(281) - Z(15)*Z(266)
      Z(236) = LTH*Z(8)
      Z(244) = LTH*Z(7)
      Z(253) = LSH - Z(244)
      Z(271) = Z(12)*Z(236) - Z(11)*Z(253)
      Z(282) = LRF + Z(271)
      Z(267) = Z(11)*Z(236) + Z(12)*Z(253)
      Z(290) = Z(16)*Z(282) - Z(15)*Z(267)
      Z(278) = LSH*Z(11)
      Z(283) = LRF - Z(278)
      Z(262) = LSH*Z(12)
      Z(291) = Z(16)*Z(283) - Z(15)*Z(262)
      Z(35) = Z(32)*Z(1) - Z(33)*Z(2)
      Z(37) = Z(34)*Z(1) - Z(32)*Z(2)
      Z(39) = Z(29)*Z(35) + Z(30)*Z(37)
      Z(31) = Z(13)*Z(18) + Z(14)*Z(17)
      Z(41) = Z(29)*Z(37) + Z(31)*Z(35)
      Z(168) = -Z(17)*Z(39) - Z(18)*Z(41)
      Z(171) = Z(18)*Z(39) - Z(17)*Z(41)
      Z(183) = Z(14)*Z(168) - Z(13)*Z(171)
      Z(179) = -Z(13)*Z(168) - Z(14)*Z(171)
      Z(195) = Z(10)*Z(183) - Z(9)*Z(179)
      Z(200) = -Z(9)*Z(183) - Z(10)*Z(179)
      Z(215) = Z(209)*Z(195) + Z(211)*Z(200)
      Z(221) = Z(209)*Z(200) + Z(210)*Z(195)
      Z(242) = Z(8)*Z(215) - Z(7)*Z(221)
      Z(234) = -Z(7)*Z(215) - Z(8)*Z(221)
      Z(276) = -Z(11)*Z(242) - Z(12)*Z(234)
      Z(268) = Z(12)*Z(242) - Z(11)*Z(234)
      Z(292) = Z(16)*Z(276) - Z(15)*Z(268)
      Z(42) = Z(29)*Z(38) + Z(31)*Z(36)
      Z(169) = -Z(17)*Z(40) - Z(18)*Z(42)
      Z(172) = Z(18)*Z(40) - Z(17)*Z(42)
      Z(184) = Z(14)*Z(169) - Z(13)*Z(172)
      Z(180) = -Z(13)*Z(169) - Z(14)*Z(172)
      Z(196) = Z(10)*Z(184) - Z(9)*Z(180)
      Z(201) = -Z(9)*Z(184) - Z(10)*Z(180)
      Z(216) = Z(209)*Z(196) + Z(211)*Z(201)
      Z(222) = Z(209)*Z(201) + Z(210)*Z(196)
      Z(243) = Z(8)*Z(216) - Z(7)*Z(222)
      Z(235) = -Z(7)*Z(216) - Z(8)*Z(222)
      Z(277) = -Z(11)*Z(243) - Z(12)*Z(235)
      Z(269) = Z(12)*Z(243) - Z(11)*Z(235)
      Z(293) = Z(16)*Z(277) - Z(15)*Z(269)
      Z(75) = -Z(15)*Z(67) - Z(16)*Z(65)
      Z(304) = -Z(15)*Z(284) - Z(16)*Z(270)
      Z(305) = RKp - RAp - RHp - RMTPp
      Z(312) = LFF*Z(305)
      Z(317) = Z(304) + Z(312)
      Z(296) = -Z(15)*Z(272) - Z(16)*Z(263)
      Z(297) = -Z(15)*Z(274) - Z(16)*Z(264)
      Z(298) = -Z(15)*Z(275) - Z(16)*Z(265)
      Z(299) = -Z(15)*Z(281) - Z(16)*Z(266)
      Z(313) = LFF + Z(299)
      Z(300) = -Z(15)*Z(282) - Z(16)*Z(267)
      Z(314) = LFF + Z(300)
      Z(295) = -Z(15)*Z(283) - Z(16)*Z(262)
      Z(315) = LFF + Z(295)
      Z(303) = LRF*Z(15)
      Z(316) = LFF - Z(303)
      Z(301) = -Z(15)*Z(276) - Z(16)*Z(268)
      Z(302) = -Z(15)*Z(277) - Z(16)*Z(269)
      VOP11Y = Z(73)*(Z(294)+Z(285)*U8+Z(286)*U9+Z(287)*U5+Z(288)*U7+Z(2
     &89)*U3+Z(290)*U4+Z(291)*U6+Z(292)*U1+Z(293)*U2) + Z(75)*(Z(317)+Z(
     &296)*U9+Z(297)*U5+Z(298)*U7+Z(313)*U3+Z(314)*U4+Z(315)*U6+Z(316)*U
     &8+Z(301)*U1+Z(302)*U2)
      RRY1 = -K3*POP11Y - K4*ABS(POP11Y)*VOP11Y
      Z(59) = Z(4)*Z(1) - Z(3)*Z(2)
      Z(62) = Z(8)*Z(57) - Z(7)*Z(59)
      Z(60) = -Z(7)*Z(57) - Z(8)*Z(59)
      Z(66) = -Z(11)*Z(62) - Z(12)*Z(60)
      Z(64) = Z(12)*Z(62) - Z(11)*Z(60)
      Z(72) = Z(16)*Z(66) - Z(15)*Z(64)
      Z(50) = Z(14)*Z(37) - Z(13)*Z(35)
      Z(54) = Z(5)*Z(1) + Z(6)*Z(2)
      POP11X = Q1 + LFF*Z(72) + LRF*Z(64) + LSH*Z(60) + LTH*Z(57) - LFF*
     &Z(39) - LRF*Z(50) - LSH*Z(35) - LTH*Z(54)
      DRX1 = POP11X - RTOEXI
      Z(74) = -Z(15)*Z(66) - Z(16)*Z(64)
      VOP11X = Z(72)*(Z(294)+Z(285)*U8+Z(286)*U9+Z(287)*U5+Z(288)*U7+Z(2
     &89)*U3+Z(290)*U4+Z(291)*U6+Z(292)*U1+Z(293)*U2) + Z(74)*(Z(317)+Z(
     &296)*U9+Z(297)*U5+Z(298)*U7+Z(313)*U3+Z(314)*U4+Z(315)*U6+Z(316)*U
     &8+Z(301)*U1+Z(302)*U2)
      RRX1 = -RRY1*(K1*DRX1+K2*VOP11X)
      POP10Y = Q2 + LRF*Z(65) + LSH*Z(61) + LTH*Z(58) - LFF*Z(40) - LRF*
     &Z(51) - LSH*Z(36) - LTH*Z(55)
      VOP10Y = Z(65)*(Z(270)+Z(262)*U6+Z(263)*U9+Z(264)*U5+Z(265)*U7+Z(2
     &66)*U3+Z(267)*U4+Z(268)*U1+Z(269)*U2) + Z(67)*(Z(284)+LRF*U8+Z(272
     &)*U9+Z(274)*U5+Z(275)*U7+Z(281)*U3+Z(282)*U4+Z(283)*U6+Z(276)*U1+Z
     &(277)*U2)
      RRY2 = -K7*POP10Y - K8*ABS(POP10Y)*VOP10Y
      POP10X = Q1 + LRF*Z(64) + LSH*Z(60) + LTH*Z(57) - LFF*Z(39) - LRF*
     &Z(50) - LSH*Z(35) - LTH*Z(54)
      DRX2 = POP10X - RMTPXI
      VOP10X = Z(64)*(Z(270)+Z(262)*U6+Z(263)*U9+Z(264)*U5+Z(265)*U7+Z(2
     &66)*U3+Z(267)*U4+Z(268)*U1+Z(269)*U2) + Z(66)*(Z(284)+LRF*U8+Z(272
     &)*U9+Z(274)*U5+Z(275)*U7+Z(281)*U3+Z(282)*U4+Z(283)*U6+Z(276)*U1+Z
     &(277)*U2)
      RRX2 = -RRY2*(K5*DRX2+K6*VOP10X)
      POP2Y = Q2 - LFF*Z(40)
      VOP2Y = Z(40)*(Z(39)*U1+Z(40)*U2) - Z(42)*(Z(159)+LFF*U3+LFF*U5+LF
     &F*U7+LFF*U9-Z(41)*U1-Z(42)*U2)
      LRY2 = -K7*POP2Y - K8*ABS(POP2Y)*VOP2Y
      POP2X = Q1 - LFF*Z(39)
      DLX2 = POP2X - LMTPXI
      VOP2X = Z(39)*(Z(39)*U1+Z(40)*U2) - Z(41)*(Z(159)+LFF*U3+LFF*U5+LF
     &F*U7+LFF*U9-Z(41)*U1-Z(42)*U2)
      LRX2 = -LRY2*(K5*DLX2+K6*VOP2X)
      Z(19) = COS(RS)
      Z(20) = SIN(RS)
      Z(21) = COS(LS)
      Z(22) = SIN(LS)
      Z(23) = COS(RE)
      Z(24) = SIN(RE)
      Z(25) = COS(LE)
      Z(26) = SIN(LE)
      Z(43) = -Z(27)*Z(13) - Z(28)*Z(14)
      Z(45) = Z(28)*Z(13) - Z(27)*Z(14)
      Z(49) = Z(43)*Z(38) + Z(45)*Z(36)
      Z(53) = -Z(13)*Z(38) - Z(14)*Z(36)
      Z(71) = Z(27)*Z(67) - Z(28)*Z(65)
      Z(76) = Z(19)*Z(1) - Z(20)*Z(2)
      Z(77) = Z(19)*Z(2) + Z(20)*Z(1)
      Z(80) = Z(23)*Z(77) + Z(24)*Z(76)
      Z(82) = Z(23)*Z(76) - Z(24)*Z(77)
      Z(83) = Z(21)*Z(1) - Z(22)*Z(2)
      Z(84) = Z(21)*Z(2) + Z(22)*Z(1)
      Z(87) = Z(25)*Z(84) + Z(26)*Z(83)
      Z(89) = Z(25)*Z(83) - Z(26)*Z(84)
      Z(109) = U4 - RHp
      Z(110) = U5 - LHp
      Z(112) = RKpp - RHpp
      Z(118) = LKpp - LHpp
      Z(120) = RKpp - RApp - RHpp
      Z(126) = LKpp - LApp - LHpp
      Z(132) = RKpp - RApp - RHpp - RMTPpp
      Z(138) = LKpp - LApp - LHpp - LMTPpp
      Z(143) = RSp + U10
      Z(144) = LSp + U11
      Z(146) = REpp + RSpp
      Z(152) = LEpp + LSpp
      Z(158) = LFFO*Z(157)
      Z(165) = LRFO*Z(160)
      Z(166) = LRFFO*Z(160)
      Z(187) = LSHO*Z(186)
      Z(188) = Z(182) - LSHO
      Z(203) = LTHO*LHp
      Z(204) = Z(199) - LTHO
      Z(224) = Z(93)*RHp
      Z(225) = Z(93) + Z(220)
      Z(247) = Z(92)*Z(246)
      Z(248) = Z(92) + Z(239)
      Z(260) = Z(91)*Z(255)
      Z(261) = LRFFO*Z(255)
      Z(306) = Z(90)*Z(305)
      Z(307) = Z(90) + Z(299)
      Z(319) = Z(5)*Z(194) + Z(6)*Z(207)
      Z(321) = Z(5)*Z(195) + Z(6)*Z(200)
      Z(322) = Z(5)*Z(196) + Z(6)*Z(201)
      Z(326) = Z(5)*Z(207) - Z(6)*Z(194)
      Z(327) = Z(5)*Z(200) - Z(6)*Z(195)
      Z(328) = Z(5)*Z(201) - Z(6)*Z(196)
      Z(330) = LHATO + Z(326)
      Z(331) = LHAT + Z(326)
      Z(333) = Z(19)*Z(319) + Z(20)*Z(331)
      Z(336) = Z(19)*Z(321) + Z(20)*Z(327)
      Z(337) = Z(19)*Z(322) + Z(20)*Z(328)
      Z(342) = Z(19)*Z(331) - Z(20)*Z(319)
      Z(343) = Z(19)*Z(327) - Z(20)*Z(321)
      Z(344) = Z(19)*Z(328) - Z(20)*Z(322)
      Z(346) = LUAO*RSp
      Z(347) = LUAO + Z(342)
      Z(349) = LUA*RSp
      Z(350) = LUA + Z(342)
      Z(353) = Z(23)*Z(333) + Z(24)*Z(350)
      Z(356) = Z(23)*Z(336) + Z(24)*Z(343)
      Z(357) = Z(23)*Z(337) + Z(24)*Z(344)
      Z(364) = Z(23)*Z(350) - Z(24)*Z(333)
      Z(365) = Z(23)*Z(343) - Z(24)*Z(336)
      Z(366) = Z(23)*Z(344) - Z(24)*Z(337)
      Z(368) = REp + RSp
      Z(369) = LLAO*Z(368)
      Z(371) = LLAO + Z(364)
      Z(378) = Z(21)*Z(319) + Z(22)*Z(331)
      Z(381) = Z(21)*Z(321) + Z(22)*Z(327)
      Z(382) = Z(21)*Z(322) + Z(22)*Z(328)
      Z(387) = Z(21)*Z(331) - Z(22)*Z(319)
      Z(388) = Z(21)*Z(327) - Z(22)*Z(321)
      Z(389) = Z(21)*Z(328) - Z(22)*Z(322)
      Z(391) = LUAO*LSp
      Z(392) = LUAO + Z(387)
      Z(394) = LUA*LSp
      Z(395) = LUA + Z(387)
      Z(398) = Z(25)*Z(378) + Z(26)*Z(395)
      Z(401) = Z(25)*Z(381) + Z(26)*Z(388)
      Z(402) = Z(25)*Z(382) + Z(26)*Z(389)
      Z(409) = Z(25)*Z(395) - Z(26)*Z(378)
      Z(410) = Z(25)*Z(388) - Z(26)*Z(381)
      Z(411) = Z(25)*Z(389) - Z(26)*Z(382)
      Z(413) = LEp + LSp
      Z(414) = LLAO*Z(413)
      Z(416) = LLAO + Z(409)
      Z(436) = LFFO*Z(138)
      Z(437) = Z(157) + U5 + U7 + U9
      Z(438) = (Z(158)+LFFO*U3+LFFO*U5+LFFO*U7+LFFO*U9)*(U3+Z(437))
      Z(439) = LFF*Z(138)
      Z(440) = (Z(159)+LFF*U3+LFF*U5+LFF*U7+LFF*U9)*(U3+Z(437))
      Z(441) = LRFO*Z(126)
      Z(442) = LRFFO*Z(126)
      Z(443) = Z(160) + U5 + U7 + U9
      Z(444) = (Z(165)+LRFO*U3+LRFO*U5+LRFO*U7+LRFO*U9)*(U3+Z(443))
      Z(445) = (Z(166)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)*(U3+Z(443))
      Z(446) = Z(18)*Z(439) - Z(17)*Z(440)
      Z(447) = Z(17)*Z(439) + Z(18)*Z(440)
      Z(448) = LRF*Z(126)
      Z(449) = Z(446) + (Z(175)+LRF*U3+LRF*U5+LRF*U7+LRF*U9)*(U3+Z(443))
      Z(450) = Z(447) - Z(448)
      Z(451) = -Z(13)*Z(449) - Z(14)*Z(450)
      Z(452) = Z(14)*Z(449) - Z(13)*Z(450)
      Z(453) = LSHO*Z(118)
      Z(454) = Z(186) + U5 + U7
      Z(455) = Z(451) + (Z(187)+LSHO*U3+LSHO*U5+LSHO*U7)*(U3+Z(454))
      Z(456) = Z(452) - Z(453)
      Z(457) = LSH*Z(118)
      Z(458) = Z(451) + (Z(190)+LSH*U3+LSH*U5+LSH*U7)*(U3+Z(454))
      Z(459) = Z(452) - Z(457)
      Z(460) = Z(10)*Z(459) - Z(9)*Z(458)
      Z(461) = -Z(9)*Z(459) - Z(10)*Z(458)
      Z(462) = LTHO*LHpp
      Z(463) = Z(460) - (Z(203)-LTHO*U3-LTHO*U5)*(U3+Z(110))
      Z(464) = Z(462) + Z(461)
      Z(465) = LTH*LHpp
      Z(466) = Z(460) - (Z(206)-LTH*U3-LTH*U5)*(U3+Z(110))
      Z(467) = Z(465) + Z(461)
      Z(468) = Z(209)*Z(466) + Z(211)*Z(467)
      Z(469) = Z(209)*Z(467) + Z(210)*Z(466)
      Z(470) = Z(93)*RHpp
      Z(471) = Z(468) + (Z(224)-Z(93)*U3-Z(93)*U4)*(U3+Z(109))
      Z(472) = Z(469) - Z(470)
      Z(473) = LTH*RHpp
      Z(474) = Z(468) + (Z(227)-LTH*U3-LTH*U4)*(U3+Z(109))
      Z(475) = Z(469) - Z(473)
      Z(476) = -Z(7)*Z(474) - Z(8)*Z(475)
      Z(477) = Z(8)*Z(474) - Z(7)*Z(475)
      Z(478) = Z(92)*Z(112)
      Z(479) = Z(246) + U4 + U6
      Z(480) = Z(476) - (Z(247)+Z(92)*U3+Z(92)*U4+Z(92)*U6)*(U3+Z(479))
      Z(481) = Z(478) + Z(477)
      Z(482) = LSH*Z(112)
      Z(483) = Z(476) - (Z(251)+LSH*U3+LSH*U4+LSH*U6)*(U3+Z(479))
      Z(484) = Z(482) + Z(477)
      Z(485) = Z(91)*Z(120)
      Z(486) = LRFFO*Z(120)
      Z(487) = Z(255) + U4 + U6 + U8
      Z(488) = (Z(260)+Z(91)*U3+Z(91)*U4+Z(91)*U6+Z(91)*U8)*(U3+Z(487))
      Z(489) = (Z(261)+LRFFO*U3+LRFFO*U4+LRFFO*U6+LRFFO*U8)*(U3+Z(487))
      Z(490) = Z(12)*Z(484) - Z(11)*Z(483)
      Z(491) = -Z(11)*Z(484) - Z(12)*Z(483)
      Z(492) = LRF*Z(120)
      Z(493) = Z(490) - (Z(280)+LRF*U3+LRF*U4+LRF*U6+LRF*U8)*(U3+Z(487))
      Z(494) = Z(492) + Z(491)
      Z(495) = Z(16)*Z(494) - Z(15)*Z(493)
      Z(496) = -Z(15)*Z(494) - Z(16)*Z(493)
      Z(497) = Z(90)*Z(132)
      Z(498) = Z(305) + U4 + U6 + U8
      Z(499) = Z(495) - (Z(306)+Z(90)*U3+Z(90)*U4+Z(90)*U6+Z(90)*U8)*(U3
     &+Z(498))
      Z(500) = Z(497) + Z(496)
      Z(504) = Z(5)*Z(466) + Z(6)*Z(467)
      Z(505) = Z(5)*Z(467) - Z(6)*Z(466)
      Z(507) = Z(504) - U3*Z(506)
      Z(509) = Z(504) - U3*Z(508)
      Z(510) = Z(19)*Z(509) + Z(20)*Z(505)
      Z(511) = Z(19)*Z(505) - Z(20)*Z(509)
      Z(512) = LUAO*RSpp
      Z(513) = Z(510) - (Z(346)+LUAO*U10+LUAO*U3)*(U3+Z(143))
      Z(514) = Z(512) + Z(511)
      Z(515) = LUA*RSpp
      Z(516) = Z(510) - (Z(349)+LUA*U10+LUA*U3)*(U3+Z(143))
      Z(517) = Z(515) + Z(511)
      Z(518) = Z(23)*Z(516) + Z(24)*Z(517)
      Z(519) = Z(23)*Z(517) - Z(24)*Z(516)
      Z(520) = LLAO*Z(146)
      Z(521) = Z(368) + U10 + U12
      Z(522) = Z(518) - (Z(369)+LLAO*U10+LLAO*U12+LLAO*U3)*(U3+Z(521))
      Z(523) = Z(520) + Z(519)
      Z(527) = Z(21)*Z(509) + Z(22)*Z(505)
      Z(528) = Z(21)*Z(505) - Z(22)*Z(509)
      Z(529) = LUAO*LSpp
      Z(530) = Z(527) - (Z(391)+LUAO*U11+LUAO*U3)*(U3+Z(144))
      Z(531) = Z(529) + Z(528)
      Z(532) = LUA*LSpp
      Z(533) = Z(527) - (Z(394)+LUA*U11+LUA*U3)*(U3+Z(144))
      Z(534) = Z(532) + Z(528)
      Z(535) = Z(25)*Z(533) + Z(26)*Z(534)
      Z(536) = Z(25)*Z(534) - Z(26)*Z(533)
      Z(537) = LLAO*Z(152)
      Z(538) = Z(413) + U11 + U13
      Z(539) = Z(535) - (Z(414)+LLAO*U11+LLAO*U13+LLAO*U3)*(U3+Z(538))
      Z(540) = Z(537) + Z(536)
      Z(564) = Z(28)*Z(18) - Z(27)*Z(17)
      Z(565) = Z(27)*Z(18) + Z(28)*Z(17)
      Z(566) = -Z(27)*Z(18) - Z(28)*Z(17)
      Z(567) = -Z(27)*Z(11) - Z(28)*Z(12)
      Z(568) = Z(27)*Z(12) - Z(28)*Z(11)
      Z(569) = Z(28)*Z(11) - Z(27)*Z(12)
      Z(1164) = LRX1 + LRX2*Z(39)**2 + LRX2*Z(41)**2 + LRY2*Z(39)*Z(40) 
     &+ LRY2*Z(41)*Z(42) + RRX1*Z(72)*Z(292) + RRX1*Z(74)*Z(301) + RRX2*
     &Z(64)*Z(268) + RRX2*Z(66)*Z(276) + RRY1*Z(73)*Z(292) + RRY1*Z(75)*
     &Z(301) + RRY2*Z(65)*Z(268) + RRY2*Z(67)*Z(276) + Z(544)*(Z(1)*Z(32
     &7)+Z(2)*Z(321)) + Z(545)*(Z(39)*Z(40)+Z(41)*Z(42)) + Z(545)*(Z(73)
     &*Z(292)+Z(75)*Z(301)) + Z(546)*(Z(87)*Z(401)+Z(89)*Z(410)) + Z(547
     &)*(Z(39)*Z(40)+Z(41)*Z(42)) + Z(547)*(Z(61)*Z(234)+Z(63)*Z(242)) +
     & Z(548)*(Z(36)*Z(179)+Z(38)*Z(183)) + Z(548)*(Z(61)*Z(234)+Z(63)*Z
     &(242)) + Z(549)*(Z(54)*Z(200)+Z(55)*Z(195)) + Z(549)*(Z(57)*Z(221)
     &+Z(58)*Z(215)) + Z(550)*(Z(83)*Z(388)+Z(84)*Z(381)) + Z(551)*(Z(80
     &)*Z(356)+Z(82)*Z(365)) + Z(552)*(Z(76)*Z(343)+Z(77)*Z(336))
      Z(1165) = LRY1 + LRX2*Z(39)*Z(40) + LRX2*Z(41)*Z(42) + LRY2*Z(40)*
     &*2 + LRY2*Z(42)**2 + RRX1*Z(72)*Z(293) + RRX1*Z(74)*Z(302) + RRX2*
     &Z(64)*Z(269) + RRX2*Z(66)*Z(277) + RRY1*Z(73)*Z(293) + RRY1*Z(75)*
     &Z(302) + RRY2*Z(65)*Z(269) + RRY2*Z(67)*Z(277) + Z(544)*(Z(1)*Z(32
     &8)+Z(2)*Z(322)) + Z(545)*(Z(40)**2+Z(42)**2) + Z(545)*(Z(73)*Z(293
     &)+Z(75)*Z(302)) + Z(546)*(Z(87)*Z(402)+Z(89)*Z(411)) + Z(547)*(Z(4
     &0)**2+Z(42)**2) + Z(547)*(Z(61)*Z(235)+Z(63)*Z(243)) + Z(548)*(Z(3
     &6)*Z(180)+Z(38)*Z(184)) + Z(548)*(Z(61)*Z(235)+Z(63)*Z(243)) + Z(5
     &49)*(Z(54)*Z(201)+Z(55)*Z(196)) + Z(549)*(Z(57)*Z(222)+Z(58)*Z(216
     &)) + Z(550)*(Z(83)*Z(389)+Z(84)*Z(382)) + Z(551)*(Z(80)*Z(357)+Z(8
     &2)*Z(366)) + Z(552)*(Z(76)*Z(344)+Z(77)*Z(337))
      Z(1185) = IFF*Z(138)
      Z(1187) = ILLA*Z(152)
      Z(1189) = IRF*Z(126)
      Z(1191) = ISH*Z(118)
      Z(1193) = ITH*LHpp
      Z(1195) = ILUA*LSpp
      Z(1196) = IFF*Z(132)
      Z(1198) = IRLA*Z(146)
      Z(1199) = IRF*Z(120)
      Z(1200) = ISH*Z(112)
      Z(1201) = ITH*RHpp
      Z(1203) = IRUA*RSpp
      Z(1204) = MFF*(Z(289)*Z(292)+Z(307)*Z(301)) + MHAT*(Z(319)*Z(321)+
     &Z(330)*Z(327)) + MLLA*(Z(398)*Z(401)+Z(416)*Z(410)) + MLUA*(Z(378)
     &*Z(381)+Z(392)*Z(388)) + MRLA*(Z(353)*Z(356)+Z(371)*Z(365)) + MRUA
     &*(Z(333)*Z(336)+Z(347)*Z(343)) + MSH*(Z(178)*Z(179)+Z(188)*Z(183))
     & + MSH*(Z(231)*Z(234)+Z(248)*Z(242)) + MTH*(Z(194)*Z(195)+Z(204)*Z
     &(200)) + MTH*(Z(213)*Z(215)+Z(225)*Z(221)) + 0.5D0*MRF*(LRFO*Z(17)
     &*Z(41)-2*LFF*Z(41)-LRFFO*Z(564)*Z(41)-LRFFO*Z(565)*Z(39)-LRFO*Z(18
     &)*Z(39)) + 0.5D0*MRF*(2*Z(231)*Z(234)+2*Z(252)*Z(242)-2*Z(91)*Z(11
     &)*Z(242)-2*Z(91)*Z(12)*Z(234)-LRFFO*Z(567)*Z(242)-LRFFO*Z(569)*Z(2
     &34)) - Z(997)*Z(41)
      Z(1205) = MFF*(Z(39)**2+Z(41)**2) + MFF*(Z(292)**2+Z(301)**2) + MH
     &AT*(Z(321)**2+Z(327)**2) + MLLA*(Z(401)**2+Z(410)**2) + MLUA*(Z(38
     &1)**2+Z(388)**2) + MRF*(Z(39)**2+Z(41)**2) + MRF*(Z(234)**2+Z(242)
     &**2) + MRLA*(Z(356)**2+Z(365)**2) + MRUA*(Z(336)**2+Z(343)**2) + M
     &SH*(Z(179)**2+Z(183)**2) + MSH*(Z(234)**2+Z(242)**2) + MTH*(Z(195)
     &**2+Z(200)**2) + MTH*(Z(215)**2+Z(221)**2)
      Z(1206) = MFF*(Z(39)*Z(40)+Z(41)*Z(42)) + MFF*(Z(292)*Z(293)+Z(301
     &)*Z(302)) + MHAT*(Z(321)*Z(322)+Z(327)*Z(328)) + MLLA*(Z(401)*Z(40
     &2)+Z(410)*Z(411)) + MLUA*(Z(381)*Z(382)+Z(388)*Z(389)) + MRF*(Z(39
     &)*Z(40)+Z(41)*Z(42)) + MRF*(Z(234)*Z(235)+Z(242)*Z(243)) + MRLA*(Z
     &(356)*Z(357)+Z(365)*Z(366)) + MRUA*(Z(336)*Z(337)+Z(343)*Z(344)) +
     & MSH*(Z(179)*Z(180)+Z(183)*Z(184)) + MSH*(Z(234)*Z(235)+Z(242)*Z(2
     &43)) + MTH*(Z(195)*Z(196)+Z(200)*Z(201)) + MTH*(Z(215)*Z(216)+Z(22
     &1)*Z(222))
      Z(1207) = MFF*(Z(292)*Z(499)+Z(301)*Z(500)) + MHAT*(Z(321)*Z(507)+
     &Z(327)*Z(505)) + MLLA*(Z(401)*Z(539)+Z(410)*Z(540)) + MLUA*(Z(381)
     &*Z(530)+Z(388)*Z(531)) + MRLA*(Z(356)*Z(522)+Z(365)*Z(523)) + MRUA
     &*(Z(336)*Z(513)+Z(343)*Z(514)) + MSH*(Z(179)*Z(455)+Z(183)*Z(456))
     & + MSH*(Z(234)*Z(480)+Z(242)*Z(481)) + MTH*(Z(195)*Z(463)+Z(200)*Z
     &(464)) + MTH*(Z(215)*Z(471)+Z(221)*Z(472)) - MFF*(Z(436)*Z(41)-Z(3
     &9)*Z(438)) - 0.5D0*MRF*(2*Z(439)*Z(41)+Z(18)*Z(441)*Z(39)+Z(564)*Z
     &(442)*Z(41)+Z(565)*Z(442)*Z(39)+Z(17)*Z(39)*Z(444)+Z(18)*Z(41)*Z(4
     &44)-Z(17)*Z(441)*Z(41)-2*Z(39)*Z(440)-Z(564)*Z(39)*Z(445)-Z(566)*Z
     &(41)*Z(445)) - 0.5D0*MRF*(Z(567)*Z(486)*Z(242)+Z(569)*Z(486)*Z(234
     &)+2*Z(11)*Z(485)*Z(242)+2*Z(12)*Z(485)*Z(234)+2*Z(12)*Z(242)*Z(488
     &)-2*Z(234)*Z(483)-2*Z(242)*Z(484)-2*Z(11)*Z(234)*Z(488)-Z(567)*Z(2
     &34)*Z(489)-Z(568)*Z(242)*Z(489))
      Z(1208) = MFF*(Z(289)*Z(293)+Z(307)*Z(302)) + MHAT*(Z(319)*Z(322)+
     &Z(330)*Z(328)) + MLLA*(Z(398)*Z(402)+Z(416)*Z(411)) + MLUA*(Z(378)
     &*Z(382)+Z(392)*Z(389)) + MRLA*(Z(353)*Z(357)+Z(371)*Z(366)) + MRUA
     &*(Z(333)*Z(337)+Z(347)*Z(344)) + MSH*(Z(178)*Z(180)+Z(188)*Z(184))
     & + MSH*(Z(231)*Z(235)+Z(248)*Z(243)) + MTH*(Z(194)*Z(196)+Z(204)*Z
     &(201)) + MTH*(Z(213)*Z(216)+Z(225)*Z(222)) + 0.5D0*MRF*(LRFO*Z(17)
     &*Z(42)-2*LFF*Z(42)-LRFFO*Z(564)*Z(42)-LRFFO*Z(565)*Z(40)-LRFO*Z(18
     &)*Z(40)) + 0.5D0*MRF*(2*Z(231)*Z(235)+2*Z(252)*Z(243)-2*Z(91)*Z(11
     &)*Z(243)-2*Z(91)*Z(12)*Z(235)-LRFFO*Z(567)*Z(243)-LRFFO*Z(569)*Z(2
     &35)) - Z(997)*Z(42)
      Z(1209) = MFF*(Z(40)**2+Z(42)**2) + MFF*(Z(293)**2+Z(302)**2) + MH
     &AT*(Z(322)**2+Z(328)**2) + MLLA*(Z(402)**2+Z(411)**2) + MLUA*(Z(38
     &2)**2+Z(389)**2) + MRF*(Z(40)**2+Z(42)**2) + MRF*(Z(235)**2+Z(243)
     &**2) + MRLA*(Z(357)**2+Z(366)**2) + MRUA*(Z(337)**2+Z(344)**2) + M
     &SH*(Z(180)**2+Z(184)**2) + MSH*(Z(235)**2+Z(243)**2) + MTH*(Z(196)
     &**2+Z(201)**2) + MTH*(Z(216)**2+Z(222)**2)
      Z(1210) = MFF*(Z(293)*Z(499)+Z(302)*Z(500)) + MHAT*(Z(322)*Z(507)+
     &Z(328)*Z(505)) + MLLA*(Z(402)*Z(539)+Z(411)*Z(540)) + MLUA*(Z(382)
     &*Z(530)+Z(389)*Z(531)) + MRLA*(Z(357)*Z(522)+Z(366)*Z(523)) + MRUA
     &*(Z(337)*Z(513)+Z(344)*Z(514)) + MSH*(Z(180)*Z(455)+Z(184)*Z(456))
     & + MSH*(Z(235)*Z(480)+Z(243)*Z(481)) + MTH*(Z(196)*Z(463)+Z(201)*Z
     &(464)) + MTH*(Z(216)*Z(471)+Z(222)*Z(472)) - MFF*(Z(436)*Z(42)-Z(4
     &0)*Z(438)) - 0.5D0*MRF*(2*Z(439)*Z(42)+Z(18)*Z(441)*Z(40)+Z(564)*Z
     &(442)*Z(42)+Z(565)*Z(442)*Z(40)+Z(17)*Z(40)*Z(444)+Z(18)*Z(42)*Z(4
     &44)-Z(17)*Z(441)*Z(42)-2*Z(40)*Z(440)-Z(564)*Z(40)*Z(445)-Z(566)*Z
     &(42)*Z(445)) - 0.5D0*MRF*(Z(567)*Z(486)*Z(243)+Z(569)*Z(486)*Z(235
     &)+2*Z(11)*Z(485)*Z(243)+2*Z(12)*Z(485)*Z(235)+2*Z(12)*Z(243)*Z(488
     &)-2*Z(235)*Z(483)-2*Z(243)*Z(484)-2*Z(11)*Z(235)*Z(488)-Z(567)*Z(2
     &35)*Z(489)-Z(568)*Z(243)*Z(489))
      Z(1217) = Z(1211) + MFF*(Z(289)**2+Z(307)**2) + MHAT*(Z(319)**2+Z(
     &330)**2) + MLLA*(Z(398)**2+Z(416)**2) + MLUA*(Z(378)**2+Z(392)**2)
     & + MRLA*(Z(353)**2+Z(371)**2) + MRUA*(Z(333)**2+Z(347)**2) + MSH*(
     &Z(178)**2+Z(188)**2) + MSH*(Z(231)**2+Z(248)**2) + MTH*(Z(194)**2+
     &Z(204)**2) + MTH*(Z(213)**2+Z(225)**2) + 0.25D0*MRF*(Z(1212)+4*Z(1
     &213)*Z(564)-4*Z(1214)*Z(17)) + 0.25D0*MRF*(Z(1215)+4*Z(231)**2+4*Z
     &(252)**2-4*Z(1216)-8*Z(91)*Z(11)*Z(252)-8*Z(91)*Z(12)*Z(231)-4*LRF
     &FO*Z(231)*Z(569)-4*LRFFO*Z(252)*Z(567))
      Z(1224) = Z(1185) + Z(1187) + Z(1189) + Z(1191) + Z(1195) + Z(1196
     &) + Z(1198) + Z(1199) + Z(1200) + Z(1203) + Z(997)*Z(436) + MFF*(Z
     &(289)*Z(499)+Z(307)*Z(500)) + MHAT*(Z(319)*Z(507)+Z(330)*Z(505)) +
     & MLLA*(Z(398)*Z(539)+Z(416)*Z(540)) + MLUA*(Z(378)*Z(530)+Z(392)*Z
     &(531)) + MRLA*(Z(353)*Z(522)+Z(371)*Z(523)) + MRUA*(Z(333)*Z(513)+
     &Z(347)*Z(514)) + MSH*(Z(178)*Z(455)+Z(188)*Z(456)) + MSH*(Z(231)*Z
     &(480)+Z(248)*Z(481)) + MTH*(Z(194)*Z(463)+Z(204)*Z(464)) + MTH*(Z(
     &213)*Z(471)+Z(225)*Z(472)) + 0.25D0*MRF*(LRFFO*Z(442)+LRFO*Z(441)+
     &Z(1218)*Z(441)+Z(1219)*Z(442)+4*LFF*Z(439)+2*LFF*Z(564)*Z(442)+2*L
     &RFFO*Z(564)*Z(439)+Z(1220)*Z(444)+2*LFF*Z(18)*Z(444)-2*LFF*Z(17)*Z
     &(441)-2*LRFO*Z(17)*Z(439)-Z(1221)*Z(445)-2*LFF*Z(566)*Z(445)-2*LRF
     &FO*Z(565)*Z(440)-2*LRFO*Z(18)*Z(440)) - Z(1193) - Z(1201) - 0.25D0
     &*MRF*(2*Z(1218)*Z(485)+2*Z(1222)*Z(486)+2*Z(231)*Z(569)*Z(486)+2*Z
     &(252)*Z(567)*Z(486)+4*Z(11)*Z(252)*Z(485)+4*Z(12)*Z(231)*Z(485)+2*
     &Z(1220)*Z(488)+2*LRFFO*Z(567)*Z(484)+2*LRFFO*Z(569)*Z(483)+4*Z(91)
     &*Z(11)*Z(484)+4*Z(91)*Z(12)*Z(483)+4*Z(12)*Z(252)*Z(488)-4*Z(91)*Z
     &(485)-LRFFO*Z(486)-4*Z(231)*Z(483)-4*Z(252)*Z(484)-2*Z(1223)*Z(489
     &)-4*Z(11)*Z(231)*Z(488)-2*Z(231)*Z(567)*Z(489)-2*Z(252)*Z(568)*Z(4
     &89))
      Z(1278) = Z(1164) - Z(1207)
      Z(1279) = Z(1165) - Z(1210)
      Z(1299) = Z(266)*RRX2*Z(64) + Z(266)*RRY2*Z(65) + Z(281)*RRX2*Z(66
     &) + Z(281)*RRY2*Z(67) + Z(289)*RRX1*Z(72) + Z(289)*RRY1*Z(73) + Z(
     &313)*RRX1*Z(74) + Z(313)*RRY1*Z(75) + Z(544)*(Z(319)*Z(2)+Z(330)*Z
     &(1)) + Z(545)*(Z(289)*Z(73)+Z(307)*Z(75)) + Z(546)*(Z(398)*Z(87)+Z
     &(416)*Z(89)) + Z(548)*(Z(178)*Z(36)+Z(188)*Z(38)) + Z(548)*(Z(231)
     &*Z(61)+Z(248)*Z(63)) + Z(549)*(Z(194)*Z(55)+Z(204)*Z(54)) + Z(549)
     &*(Z(213)*Z(58)+Z(225)*Z(57)) + Z(550)*(Z(378)*Z(84)+Z(392)*Z(83)) 
     &+ Z(551)*(Z(353)*Z(80)+Z(371)*Z(82)) + Z(552)*(Z(333)*Z(77)+Z(347)
     &*Z(76)) - Z(1166)*Z(42) - LFF*(LRX2*Z(41)+LRY2*Z(42)) - 0.5D0*Z(54
     &7)*(LRFFO*Z(49)+LRFO*Z(53)+2*LFF*Z(42)) - 0.5D0*Z(547)*(LRFFO*Z(71
     &)-2*Z(91)*Z(67)-2*Z(231)*Z(61)-2*Z(252)*Z(63)) - Z(1224)

      COEF(1,1) = -Z(1205)
      COEF(1,2) = -Z(1206)
      COEF(1,3) = -Z(1204)
      COEF(2,1) = -Z(1206)
      COEF(2,2) = -Z(1209)
      COEF(2,3) = -Z(1208)
      COEF(3,1) = -Z(1204)
      COEF(3,2) = -Z(1208)
      COEF(3,3) = -Z(1217)
      RHS(1) = -Z(1278)
      RHS(2) = -Z(1279)
      RHS(3) = -Z(1299)
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
      COMMON/CONSTNTS/ FOOTANG,G,IFF,IHAT,ILLA,ILUA,IRF,IRLA,IRUA,ISH,IT
     &H,K1,K2,K3,K4,K5,K6,K7,K8,LFF,LFFO,LHAT,LHATO,LLA,LLAO,LMTPXI,LRF,
     &LRFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,LTOEXI,LUA,LUAO,MFF,MHAT,MLLA,ML
     &UA,MRF,MRLA,MRUA,MSH,MTH,MTPB,MTPK,RMTPXI,RTOEXI
      COMMON/SPECFIED/ LA,LE,LH,LK,LMTP,LS,RA,RE,RH,RK,RMTP,RS,LAp,LEp,L
     &Hp,LKp,LMTPp,LSp,RAp,REp,RHp,RKp,RMTPp,RSp,LApp,LEpp,LHpp,LKpp,LMT
     &Ppp,LSpp,RApp,REpp,RHpp,RKpp,RMTPpp,RSpp
      COMMON/VARIBLES/ Q1,Q2,Q3,U1,U2,U3
      COMMON/ALGBRAIC/ HZ,KECM,LATQ,LETQ,LHTQ,LKTQ,LRX1,LRX2,LRY1,LRY2,L
     &STQ,PX,PY,RATQ,RETQ,RHTQ,RKTQ,RRX1,RRX2,RRY1,RRY2,RSTQ,U10,U11,U12
     &,U13,U4,U5,U6,U7,U8,U9,Q1p,Q2p,Q3p,U1p,U2p,U3p,DLX1,DLX2,DRX1,DRX2
     &,LMTQ,LRX,LRY,POCMX,POCMY,POP10X,POP10Y,POP11X,POP11Y,POP12X,POP12
     &Y,POP13X,POP13Y,POP14X,POP14Y,POP15X,POP15Y,POP16X,POP16Y,POP1X,PO
     &P1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,PO
     &P7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,RMTQ,RRX,RRY,VOCMX,VOCMY,VOP10X,
     &VOP10Y,VOP11X,VOP11Y,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(1299),COEF(3,3),RHS(3)

C**   Evaluate output quantities
      Z(323) = Z(5)*Z(197) + Z(6)*Z(208)
      Z(318) = Z(5)*Z(193) + Z(6)*Z(198)
      Z(320) = Z(5)*Z(194) + Z(6)*Z(199)
      Z(329) = Z(5)*Z(208) - Z(6)*Z(197)
      Z(324) = Z(5)*Z(198) - Z(6)*Z(193)
      Z(325) = Z(5)*Z(199) - Z(6)*Z(194)
      Z(189) = Z(185) - Z(187)
      Z(205) = Z(202) + Z(203)
      Z(383) = Z(21)*Z(323) + Z(22)*Z(329)
      Z(377) = Z(21)*Z(318) + Z(22)*Z(324)
      Z(379) = Z(21)*Z(319) + Z(22)*Z(326)
      Z(380) = Z(21)*Z(320) + Z(22)*Z(325)
      Z(390) = Z(21)*Z(329) - Z(22)*Z(323)
      Z(393) = Z(390) + Z(391)
      Z(384) = Z(21)*Z(324) - Z(22)*Z(318)
      Z(385) = Z(21)*Z(325) - Z(22)*Z(320)
      Z(386) = Z(21)*Z(326) - Z(22)*Z(319)
      Z(338) = Z(19)*Z(323) + Z(20)*Z(329)
      Z(332) = Z(19)*Z(318) + Z(20)*Z(324)
      Z(334) = Z(19)*Z(319) + Z(20)*Z(326)
      Z(335) = Z(19)*Z(320) + Z(20)*Z(325)
      Z(345) = Z(19)*Z(329) - Z(20)*Z(323)
      Z(348) = Z(345) + Z(346)
      Z(339) = Z(19)*Z(324) - Z(20)*Z(318)
      Z(340) = Z(19)*Z(325) - Z(20)*Z(320)
      Z(341) = Z(19)*Z(326) - Z(20)*Z(319)
      Z(226) = Z(223) - Z(224)
      Z(396) = Z(390) + Z(394)
      Z(404) = Z(25)*Z(383) + Z(26)*Z(396)
      Z(397) = Z(25)*Z(377) + Z(26)*Z(384)
      Z(399) = Z(25)*Z(379) + Z(26)*Z(386)
      Z(400) = Z(25)*Z(380) + Z(26)*Z(385)
      Z(403) = LUA*Z(26)
      Z(412) = Z(25)*Z(396) - Z(26)*Z(383)
      Z(417) = Z(412) + Z(414)
      Z(406) = Z(25)*Z(384) - Z(26)*Z(377)
      Z(407) = Z(25)*Z(385) - Z(26)*Z(380)
      Z(408) = Z(25)*Z(386) - Z(26)*Z(379)
      Z(405) = LUA*Z(25)
      Z(415) = LLAO + Z(405)
      Z(351) = Z(345) + Z(349)
      Z(359) = Z(23)*Z(338) + Z(24)*Z(351)
      Z(352) = Z(23)*Z(332) + Z(24)*Z(339)
      Z(354) = Z(23)*Z(334) + Z(24)*Z(341)
      Z(355) = Z(23)*Z(335) + Z(24)*Z(340)
      Z(358) = LUA*Z(24)
      Z(367) = Z(23)*Z(351) - Z(24)*Z(338)
      Z(372) = Z(367) + Z(369)
      Z(361) = Z(23)*Z(339) - Z(24)*Z(332)
      Z(362) = Z(23)*Z(340) - Z(24)*Z(335)
      Z(363) = Z(23)*Z(341) - Z(24)*Z(334)
      Z(360) = LUA*Z(23)
      Z(370) = LLAO + Z(360)
      Z(311) = Z(304) + Z(306)
      Z(308) = Z(90) + Z(300)
      Z(309) = Z(90) + Z(295)
      Z(310) = Z(90) - Z(303)
      Z(250) = Z(245) + Z(247)
      Z(249) = Z(92) - Z(244)
      KECM = 0.5D0*IHAT*U3**2 + 0.5D0*ILUA*(LSp+U11+U3)**2 + 0.5D0*IRUA*
     &(RSp+U10+U3)**2 + 0.5D0*ILLA*(LEp+LSp+U11+U13+U3)**2 + 0.5D0*IRLA*
     &(REp+RSp+U10+U12+U3)**2 + 0.5D0*ITH*(LHp-U3-U5)**2 + 0.5D0*ITH*(RH
     &p-U3-U4)**2 + 0.5D0*ISH*(LHp-LKp-U3-U5-U7)**2 + 0.5D0*ISH*(RHp-RKp
     &-U3-U4-U6)**2 + 0.5D0*IRF*(LAp+LHp-LKp-U3-U5-U7-U9)**2 + 0.5D0*IRF
     &*(RAp+RHp-RKp-U3-U4-U6-U8)**2 + 0.5D0*IFF*(LAp+LHp+LMTPp-LKp-U3-U5
     &-U7-U9)**2 + 0.5D0*IFF*(RAp+RHp+RMTPp-RKp-U3-U4-U6-U8)**2 + 0.5D0*
     &MFF*((Z(39)*U1+Z(40)*U2)**2+(Z(158)+LFFO*U3+LFFO*U5+LFFO*U7+LFFO*U
     &9-Z(41)*U1-Z(42)*U2)**2) + 0.5D0*MHAT*((Z(323)+Z(318)*U9+Z(319)*U3
     &+Z(319)*U5+Z(320)*U7+Z(321)*U1+Z(322)*U2)**2+(Z(329)+Z(324)*U9+Z(3
     &25)*U7+Z(326)*U5+Z(330)*U3+Z(327)*U1+Z(328)*U2)**2) + 0.5D0*MSH*((
     &Z(181)+Z(178)*U3+Z(178)*U5+Z(178)*U7+Z(178)*U9+Z(179)*U1+Z(180)*U2
     &)**2+(Z(189)+Z(182)*U9+Z(188)*U3+Z(188)*U5+Z(188)*U7+Z(183)*U1+Z(1
     &84)*U2)**2) + 0.5D0*MTH*((Z(197)+Z(193)*U9+Z(194)*U3+Z(194)*U5+Z(1
     &94)*U7+Z(195)*U1+Z(196)*U2)**2+(Z(205)+Z(198)*U9+Z(199)*U7+Z(204)*
     &U3+Z(204)*U5+Z(200)*U1+Z(201)*U2)**2) + 0.5D0*MLUA*((Z(383)+Z(377)
     &*U9+Z(378)*U3+Z(379)*U5+Z(380)*U7+Z(381)*U1+Z(382)*U2)**2+(Z(393)+
     &LUAO*U11+Z(384)*U9+Z(385)*U7+Z(386)*U5+Z(392)*U3+Z(388)*U1+Z(389)*
     &U2)**2) + 0.5D0*MRUA*((Z(338)+Z(332)*U9+Z(333)*U3+Z(334)*U5+Z(335)
     &*U7+Z(336)*U1+Z(337)*U2)**2+(Z(348)+LUAO*U10+Z(339)*U9+Z(340)*U7+Z
     &(341)*U5+Z(347)*U3+Z(343)*U1+Z(344)*U2)**2) + 0.5D0*MTH*((Z(217)+Z
     &(212)*U9+Z(213)*U3+Z(213)*U5+Z(214)*U7+Z(215)*U1+Z(216)*U2)**2+(Z(
     &226)+Z(93)*U4+Z(218)*U9+Z(219)*U7+Z(220)*U5+Z(225)*U3+Z(221)*U1+Z(
     &222)*U2)**2) + 0.5D0*MLLA*((Z(404)+Z(397)*U9+Z(398)*U3+Z(399)*U5+Z
     &(400)*U7+Z(403)*U11+Z(401)*U1+Z(402)*U2)**2+(Z(417)+LLAO*U13+Z(406
     &)*U9+Z(407)*U7+Z(408)*U5+Z(415)*U11+Z(416)*U3+Z(410)*U1+Z(411)*U2)
     &**2) + 0.5D0*MRLA*((Z(359)+Z(352)*U9+Z(353)*U3+Z(354)*U5+Z(355)*U7
     &+Z(358)*U10+Z(356)*U1+Z(357)*U2)**2+(Z(372)+LLAO*U12+Z(361)*U9+Z(3
     &62)*U7+Z(363)*U5+Z(370)*U10+Z(371)*U3+Z(365)*U1+Z(366)*U2)**2) + 0
     &.5D0*MFF*((Z(294)+Z(285)*U8+Z(286)*U9+Z(287)*U5+Z(288)*U7+Z(289)*U
     &3+Z(290)*U4+Z(291)*U6+Z(292)*U1+Z(293)*U2)**2+(Z(311)+Z(296)*U9+Z(
     &297)*U5+Z(298)*U7+Z(307)*U3+Z(308)*U4+Z(309)*U6+Z(310)*U8+Z(301)*U
     &1+Z(302)*U2)**2) + 0.5D0*MSH*((Z(250)+Z(92)*U6+Z(238)*U9+Z(240)*U5
     &+Z(241)*U7+Z(248)*U3+Z(249)*U4+Z(242)*U1+Z(243)*U2)**2+(Z(236)*U4-
     &Z(237)-Z(230)*U9-Z(231)*U3-Z(232)*U5-Z(233)*U7-Z(234)*U1-Z(235)*U2
     &)**2) - 0.125D0*MRF*(4*Z(18)*(Z(39)*U1+Z(40)*U2)*(Z(165)+LRFO*U3+L
     &RFO*U5+LRFO*U7+LRFO*U9)+4*Z(565)*(Z(39)*U1+Z(40)*U2)*(Z(166)+LRFFO
     &*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)+4*Z(17)*(Z(165)+LRFO*U3+LRFO*U5+LR
     &FO*U7+LRFO*U9)*(Z(159)+LFF*U3+LFF*U5+LFF*U7+LFF*U9-Z(41)*U1-Z(42)*
     &U2)-4*(Z(39)*U1+Z(40)*U2)**2-(Z(165)+LRFO*U3+LRFO*U5+LRFO*U7+LRFO*
     &U9)**2-(Z(166)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)**2-4*(Z(159)+L
     &FF*U3+LFF*U5+LFF*U7+LFF*U9-Z(41)*U1-Z(42)*U2)**2-2*Z(27)*(Z(165)+L
     &RFO*U3+LRFO*U5+LRFO*U7+LRFO*U9)*(Z(166)+LRFFO*U3+LRFFO*U5+LRFFO*U7
     &+LRFFO*U9)-4*Z(564)*(Z(166)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)*(
     &Z(159)+LFF*U3+LFF*U5+LFF*U7+LFF*U9-Z(41)*U1-Z(42)*U2)) - 0.125D0*M
     &RF*(4*Z(27)*(Z(260)+Z(91)*U3+Z(91)*U4+Z(91)*U6+Z(91)*U8)*(Z(261)+L
     &RFFO*U3+LRFFO*U4+LRFFO*U6+LRFFO*U8)+4*Z(567)*(Z(261)+LRFFO*U3+LRFF
     &O*U4+LRFFO*U6+LRFFO*U8)*(Z(254)+LSH*U6+Z(238)*U9+Z(240)*U5+Z(241)*
     &U7+Z(252)*U3+Z(253)*U4+Z(242)*U1+Z(243)*U2)+8*Z(11)*(Z(260)+Z(91)*
     &U3+Z(91)*U4+Z(91)*U6+Z(91)*U8)*(Z(254)+LSH*U6+Z(238)*U9+Z(240)*U5+
     &Z(241)*U7+Z(252)*U3+Z(253)*U4+Z(242)*U1+Z(243)*U2)-4*(Z(260)+Z(91)
     &*U3+Z(91)*U4+Z(91)*U6+Z(91)*U8)**2-(Z(261)+LRFFO*U3+LRFFO*U4+LRFFO
     &*U6+LRFFO*U8)**2-4*(Z(254)+LSH*U6+Z(238)*U9+Z(240)*U5+Z(241)*U7+Z(
     &252)*U3+Z(253)*U4+Z(242)*U1+Z(243)*U2)**2-4*(Z(236)*U4-Z(237)-Z(23
     &0)*U9-Z(231)*U3-Z(232)*U5-Z(233)*U7-Z(234)*U1-Z(235)*U2)**2-8*Z(12
     &)*(Z(260)+Z(91)*U3+Z(91)*U4+Z(91)*U6+Z(91)*U8)*(Z(236)*U4-Z(237)-Z
     &(230)*U9-Z(231)*U3-Z(232)*U5-Z(233)*U7-Z(234)*U1-Z(235)*U2)-4*Z(56
     &9)*(Z(261)+LRFFO*U3+LRFFO*U4+LRFFO*U6+LRFFO*U8)*(Z(236)*U4-Z(237)-
     &Z(230)*U9-Z(231)*U3-Z(232)*U5-Z(233)*U7-Z(234)*U1-Z(235)*U2))
      Z(570) = IFF*Z(157)
      Z(571) = ILLA*Z(413)
      Z(572) = IRF*Z(160)
      Z(573) = ISH*Z(186)
      Z(575) = ILUA*LSp
      Z(576) = IFF*Z(305)
      Z(577) = IRLA*Z(368)
      Z(578) = IRF*Z(255)
      Z(579) = ISH*Z(246)
      Z(581) = IRUA*RSp
      Z(44) = Z(27)*Z(14) - Z(28)*Z(13)
      Z(46) = Z(43)*Z(35) + Z(44)*Z(37)
      Z(47) = Z(43)*Z(36) + Z(44)*Z(38)
      Z(161) = Z(1)*Z(46) + Z(2)*Z(47)
      Z(68) = Z(27)*Z(64) + Z(28)*Z(66)
      Z(69) = Z(27)*Z(65) + Z(28)*Z(67)
      Z(256) = Z(1)*Z(68) + Z(2)*Z(69)
      Z(85) = -Z(21)*Z(2) - Z(22)*Z(1)
      Z(86) = Z(25)*Z(83) + Z(26)*Z(85)
      Z(153) = Z(1)*Z(86) + Z(2)*Z(87)
      Z(133) = Z(1)*Z(72) + Z(2)*Z(73)
      Z(78) = -Z(19)*Z(2) - Z(20)*Z(1)
      Z(79) = Z(23)*Z(76) + Z(24)*Z(78)
      Z(147) = Z(1)*Z(79) + Z(2)*Z(80)
      Z(121) = Z(1)*Z(64) + Z(2)*Z(65)
      Z(113) = Z(1)*Z(60) + Z(2)*Z(61)
      Z(139) = Z(1)*Z(39) + Z(2)*Z(40)
      Z(127) = Z(1)*Z(50) + Z(2)*Z(51)
      Z(586) = LHATO + 0.5D0*Z(99)*Z(161) + 0.5D0*Z(99)*Z(256) - Z(95) -
     & Z(102)*Z(21) - Z(107)*Z(3) - Z(108)*Z(19) - Z(582)*Z(32) - Z(583)
     &*Z(5) - Z(97)*Z(153) - Z(103)*Z(133) - Z(104)*Z(147) - Z(105)*Z(12
     &1) - Z(106)*Z(113) - Z(584)*Z(139) - 0.5D0*Z(585)*Z(127)
      Z(946) = MHAT*Z(586)
      Z(589) = Z(329) + Z(324)*U9 + Z(325)*U7 + Z(326)*U5 + Z(330)*U3 + 
     &Z(327)*U1 + Z(328)*U2
      Z(141) = Z(1)*Z(40) - Z(2)*Z(39)
      Z(594) = Z(5)*Z(139) - Z(6)*Z(141)
      Z(602) = Z(39)*Z(72) + Z(40)*Z(73)
      Z(604) = Z(39)*Z(74) + Z(40)*Z(75)
      Z(610) = -Z(15)*Z(602) - Z(16)*Z(604)
      Z(612) = Z(16)*Z(602) - Z(15)*Z(604)
      Z(614) = Z(27)*Z(610) + Z(28)*Z(612)
      Z(590) = Z(39)*Z(86) + Z(40)*Z(87)
      Z(598) = Z(21)*Z(139) + Z(22)*Z(141)
      Z(606) = Z(39)*Z(79) + Z(40)*Z(80)
      Z(618) = -Z(11)*Z(610) - Z(12)*Z(612)
      Z(622) = Z(3)*Z(139) - Z(4)*Z(141)
      Z(626) = Z(19)*Z(139) + Z(20)*Z(141)
      Z(630) = Z(96) + Z(100)*Z(29) + 0.5D0*Z(99)*Z(564) + Z(101)*Z(594)
     & + 0.5D0*Z(99)*Z(614) - LFFO - 0.5D0*Z(98)*Z(17) - Z(95)*Z(139) - 
     &Z(97)*Z(590) - Z(102)*Z(598) - Z(103)*Z(602) - Z(104)*Z(606) - Z(1
     &05)*Z(610) - Z(106)*Z(618) - Z(107)*Z(622) - Z(108)*Z(626)
      Z(948) = MFF*Z(630)
      Z(633) = Z(41)*U1 + Z(42)*U2 - Z(158) - LFFO*U3 - LFFO*U5 - LFFO*U
     &7 - LFFO*U9
      Z(591) = Z(41)*Z(86) + Z(42)*Z(87)
      Z(634) = -Z(17)*Z(590) - Z(18)*Z(591)
      Z(636) = Z(18)*Z(590) - Z(17)*Z(591)
      Z(638) = Z(27)*Z(634) + Z(28)*Z(636)
      Z(650) = Z(72)*Z(86) + Z(73)*Z(87)
      Z(652) = Z(74)*Z(86) + Z(75)*Z(87)
      Z(658) = -Z(15)*Z(650) - Z(16)*Z(652)
      Z(660) = Z(16)*Z(650) - Z(15)*Z(652)
      Z(662) = Z(27)*Z(658) + Z(28)*Z(660)
      Z(654) = Z(79)*Z(86) + Z(80)*Z(87)
      Z(666) = -Z(11)*Z(658) - Z(12)*Z(660)
      Z(155) = Z(1)*Z(87) - Z(2)*Z(86)
      Z(670) = Z(3)*Z(153) - Z(4)*Z(155)
      Z(674) = Z(19)*Z(153) + Z(20)*Z(155)
      Z(642) = -Z(13)*Z(634) - Z(14)*Z(636)
      Z(646) = Z(5)*Z(153) - Z(6)*Z(155)
      Z(680) = LLAO + Z(678)*Z(25) + Z(679)*Z(153) + 0.5D0*Z(99)*Z(638) 
     &+ 0.5D0*Z(99)*Z(662) - Z(97) - Z(103)*Z(650) - Z(104)*Z(654) - Z(1
     &05)*Z(658) - Z(106)*Z(666) - Z(107)*Z(670) - Z(108)*Z(674) - Z(582
     &)*Z(642) - Z(583)*Z(646) - Z(584)*Z(590) - 0.5D0*Z(585)*Z(634)
      Z(950) = MLLA*Z(680)
      Z(683) = Z(417) + LLAO*U13 + Z(406)*U9 + Z(407)*U7 + Z(408)*U5 + Z
     &(415)*U11 + Z(416)*U3 + Z(410)*U1 + Z(411)*U2
      Z(766) = Z(35)*Z(72) + Z(36)*Z(73)
      Z(768) = Z(35)*Z(74) + Z(36)*Z(75)
      Z(774) = -Z(15)*Z(766) - Z(16)*Z(768)
      Z(776) = Z(16)*Z(766) - Z(15)*Z(768)
      Z(778) = Z(27)*Z(774) + Z(28)*Z(776)
      Z(762) = Z(21)*Z(32) + Z(22)*Z(33)
      Z(786) = Z(3)*Z(32) - Z(4)*Z(33)
      Z(790) = Z(19)*Z(32) + Z(20)*Z(33)
      Z(770) = Z(35)*Z(79) + Z(36)*Z(80)
      Z(782) = -Z(11)*Z(774) - Z(12)*Z(776)
      Z(794) = Z(100) + 0.5D0*Z(99)*Z(43) + 0.5D0*Z(585)*Z(13) + 0.5D0*Z
     &(99)*Z(778) - LSHO - Z(95)*Z(32) - Z(101)*Z(9) - Z(102)*Z(762) - Z
     &(107)*Z(786) - Z(108)*Z(790) - Z(584)*Z(29) - Z(97)*Z(642) - Z(103
     &)*Z(766) - Z(104)*Z(770) - Z(105)*Z(774) - Z(106)*Z(782)
      Z(958) = MSH*Z(794)
      Z(797) = Z(189) + Z(182)*U9 + Z(188)*U3 + Z(188)*U5 + Z(188)*U7 + 
     &Z(183)*U1 + Z(184)*U2
      Z(163) = Z(1)*Z(47) - Z(2)*Z(46)
      Z(694) = Z(5)*Z(161) - Z(6)*Z(163)
      Z(801) = Z(54)*Z(72) + Z(55)*Z(73)
      Z(803) = Z(54)*Z(74) + Z(55)*Z(75)
      Z(809) = -Z(15)*Z(801) - Z(16)*Z(803)
      Z(811) = Z(16)*Z(801) - Z(15)*Z(803)
      Z(813) = Z(27)*Z(809) + Z(28)*Z(811)
      Z(798) = Z(5)*Z(21) - Z(6)*Z(22)
      Z(817) = -Z(7)*Z(209) - Z(8)*Z(210)
      Z(821) = Z(5)*Z(19) - Z(6)*Z(20)
      Z(805) = Z(54)*Z(79) + Z(55)*Z(80)
      Z(129) = Z(1)*Z(51) - Z(2)*Z(50)
      Z(690) = Z(5)*Z(127) - Z(6)*Z(129)
      Z(824) = Z(101) + Z(582)*Z(9) + 0.5D0*Z(99)*Z(694) + 0.5D0*Z(99)*Z
     &(813) - LTHO - Z(95)*Z(5) - Z(102)*Z(798) - Z(106)*Z(817) - Z(107)
     &*Z(209) - Z(108)*Z(821) - Z(97)*Z(646) - Z(103)*Z(801) - Z(104)*Z(
     &805) - Z(105)*Z(809) - Z(584)*Z(594) - 0.5D0*Z(585)*Z(690)
      Z(960) = MTH*Z(824)
      Z(827) = Z(205) + Z(198)*U9 + Z(199)*U7 + Z(204)*U3 + Z(204)*U5 + 
     &Z(200)*U1 + Z(201)*U2
      Z(702) = Z(21)*Z(161) + Z(22)*Z(163)
      Z(828) = Z(72)*Z(83) + Z(73)*Z(84)
      Z(830) = Z(74)*Z(83) + Z(75)*Z(84)
      Z(836) = -Z(15)*Z(828) - Z(16)*Z(830)
      Z(838) = Z(16)*Z(828) - Z(15)*Z(830)
      Z(840) = Z(27)*Z(836) + Z(28)*Z(838)
      Z(848) = Z(3)*Z(21) - Z(4)*Z(22)
      Z(851) = Z(19)*Z(21) + Z(20)*Z(22)
      Z(832) = Z(79)*Z(83) + Z(80)*Z(84)
      Z(844) = -Z(11)*Z(836) - Z(12)*Z(838)
      Z(698) = Z(21)*Z(127) + Z(22)*Z(129)
      Z(854) = LUAO + Z(679)*Z(21) + 0.5D0*Z(99)*Z(702) + 0.5D0*Z(99)*Z(
     &840) - Z(102) - Z(97)*Z(25) - Z(107)*Z(848) - Z(108)*Z(851) - Z(58
     &2)*Z(762) - Z(583)*Z(798) - Z(103)*Z(828) - Z(104)*Z(832) - Z(105)
     &*Z(836) - Z(106)*Z(844) - Z(584)*Z(598) - 0.5D0*Z(585)*Z(698)
      Z(962) = MLUA*Z(854)
      Z(857) = Z(393) + LUAO*U11 + Z(384)*U9 + Z(385)*U7 + Z(386)*U5 + Z
     &(392)*U3 + Z(388)*U1 + Z(389)*U2
      Z(865) = Z(11)*Z(15) - Z(12)*Z(16)
      Z(862) = Z(28)*Z(16) - Z(27)*Z(15)
      Z(135) = Z(1)*Z(73) - Z(2)*Z(72)
      Z(868) = Z(3)*Z(133) - Z(4)*Z(135)
      Z(710) = Z(46)*Z(72) + Z(47)*Z(73)
      Z(858) = Z(72)*Z(79) + Z(73)*Z(80)
      Z(872) = Z(19)*Z(133) + Z(20)*Z(135)
      Z(706) = Z(50)*Z(72) + Z(51)*Z(73)
      Z(879) = LFF + Z(876)*Z(865) + 0.5D0*Z(99)*Z(862) + Z(877)*Z(868) 
     &+ 0.5D0*Z(99)*Z(710) - LFFO - Z(103) - Z(878)*Z(15) - Z(95)*Z(133)
     & - Z(97)*Z(650) - Z(102)*Z(828) - Z(104)*Z(858) - Z(108)*Z(872) - 
     &Z(582)*Z(766) - Z(583)*Z(801) - Z(584)*Z(602) - 0.5D0*Z(585)*Z(706
     &)
      Z(964) = MFF*Z(879)
      Z(882) = Z(311) + Z(296)*U9 + Z(297)*U5 + Z(298)*U7 + Z(307)*U3 + 
     &Z(308)*U4 + Z(309)*U6 + Z(310)*U8 + Z(301)*U1 + Z(302)*U2
      Z(718) = Z(46)*Z(79) + Z(47)*Z(80)
      Z(859) = Z(74)*Z(79) + Z(75)*Z(80)
      Z(883) = -Z(15)*Z(858) - Z(16)*Z(859)
      Z(885) = Z(16)*Z(858) - Z(15)*Z(859)
      Z(887) = Z(27)*Z(883) + Z(28)*Z(885)
      Z(891) = -Z(11)*Z(883) - Z(12)*Z(885)
      Z(149) = Z(1)*Z(80) - Z(2)*Z(79)
      Z(895) = Z(3)*Z(147) - Z(4)*Z(149)
      Z(714) = Z(50)*Z(79) + Z(51)*Z(80)
      Z(900) = LLAO + Z(899)*Z(23) + Z(679)*Z(147) + 0.5D0*Z(99)*Z(718) 
     &+ 0.5D0*Z(99)*Z(887) - Z(104) - Z(97)*Z(654) - Z(102)*Z(832) - Z(1
     &03)*Z(858) - Z(105)*Z(883) - Z(106)*Z(891) - Z(107)*Z(895) - Z(582
     &)*Z(770) - Z(583)*Z(805) - Z(584)*Z(606) - 0.5D0*Z(585)*Z(714)
      Z(966) = MRLA*Z(900)
      Z(903) = Z(372) + LLAO*U12 + Z(361)*U9 + Z(362)*U7 + Z(363)*U5 + Z
     &(370)*U10 + Z(371)*U3 + Z(365)*U1 + Z(366)*U2
      Z(712) = Z(46)*Z(74) + Z(47)*Z(75)
      Z(726) = -Z(15)*Z(710) - Z(16)*Z(712)
      Z(728) = Z(16)*Z(710) - Z(15)*Z(712)
      Z(742) = -Z(11)*Z(726) - Z(12)*Z(728)
      Z(115) = Z(1)*Z(61) - Z(2)*Z(60)
      Z(928) = Z(19)*Z(113) + Z(20)*Z(115)
      Z(708) = Z(50)*Z(74) + Z(51)*Z(75)
      Z(722) = -Z(15)*Z(706) - Z(16)*Z(708)
      Z(724) = Z(16)*Z(706) - Z(15)*Z(708)
      Z(738) = -Z(11)*Z(722) - Z(12)*Z(724)
      Z(932) = LSH + Z(105)*Z(11) + 0.5D0*Z(99)*Z(567) + 0.5D0*Z(99)*Z(7
     &42) - LSHO - Z(106) - Z(103)*Z(865) - Z(583)*Z(817) - Z(877)*Z(7) 
     &- Z(95)*Z(113) - Z(97)*Z(666) - Z(102)*Z(844) - Z(104)*Z(891) - Z(
     &108)*Z(928) - Z(582)*Z(782) - Z(584)*Z(618) - 0.5D0*Z(585)*Z(738)
      Z(974) = MSH*Z(932)
      Z(934) = Z(250) + Z(92)*U6 + Z(238)*U9 + Z(240)*U5 + Z(241)*U7 + Z
     &(248)*U3 + Z(249)*U4 + Z(242)*U1 + Z(243)*U2
      Z(750) = Z(3)*Z(161) - Z(4)*Z(163)
      Z(258) = Z(1)*Z(69) - Z(2)*Z(68)
      Z(916) = Z(3)*Z(256) - Z(4)*Z(258)
      Z(935) = Z(3)*Z(19) - Z(4)*Z(20)
      Z(123) = Z(1)*Z(65) - Z(2)*Z(64)
      Z(912) = Z(3)*Z(121) - Z(4)*Z(123)
      Z(746) = Z(3)*Z(127) - Z(4)*Z(129)
      Z(938) = LTH + Z(106)*Z(7) + 0.5D0*Z(99)*Z(750) + 0.5D0*Z(99)*Z(91
     &6) - LTHO - Z(107) - Z(95)*Z(3) - Z(102)*Z(848) - Z(108)*Z(935) - 
     &Z(582)*Z(786) - Z(583)*Z(209) - Z(97)*Z(670) - Z(103)*Z(868) - Z(1
     &04)*Z(895) - Z(105)*Z(912) - Z(584)*Z(622) - 0.5D0*Z(585)*Z(746)
      Z(976) = MTH*Z(938)
      Z(941) = Z(226) + Z(93)*U4 + Z(218)*U9 + Z(219)*U7 + Z(220)*U5 + Z
     &(225)*U3 + Z(221)*U1 + Z(222)*U2
      Z(758) = Z(19)*Z(161) + Z(20)*Z(163)
      Z(924) = Z(19)*Z(256) + Z(20)*Z(258)
      Z(920) = Z(19)*Z(121) + Z(20)*Z(123)
      Z(754) = Z(19)*Z(127) + Z(20)*Z(129)
      Z(942) = LUAO + Z(679)*Z(19) + 0.5D0*Z(99)*Z(758) + 0.5D0*Z(99)*Z(
     &924) - Z(108) - Z(102)*Z(851) - Z(104)*Z(23) - Z(107)*Z(935) - Z(5
     &82)*Z(790) - Z(583)*Z(821) - Z(97)*Z(674) - Z(103)*Z(872) - Z(105)
     &*Z(920) - Z(106)*Z(928) - Z(584)*Z(626) - 0.5D0*Z(585)*Z(754)
      Z(978) = MRUA*Z(942)
      Z(945) = Z(348) + LUAO*U10 + Z(339)*U9 + Z(340)*U7 + Z(341)*U5 + Z
     &(347)*U3 + Z(343)*U1 + Z(344)*U2
      Z(952) = MRF*(2*Z(684)+2*Z(100)*Z(29)+2*Z(686)*Z(564)+Z(99)*Z(614)
     &+2*Z(101)*Z(594)-2*Z(685)*Z(17)-2*Z(95)*Z(139)-2*Z(97)*Z(590)-2*Z(
     &102)*Z(598)-2*Z(103)*Z(602)-2*Z(104)*Z(606)-2*Z(105)*Z(610)-2*Z(10
     &6)*Z(618)-2*Z(107)*Z(622)-2*Z(108)*Z(626))
      Z(687) = Z(41)*U1 + Z(42)*U2 - Z(159) - LFF*U3 - LFF*U5 - LFF*U7 -
     & LFF*U9
      Z(730) = Z(27)*Z(722) + Z(28)*Z(724)
      Z(955) = MRF*(Z(954)+Z(99)*Z(730)+2*Z(101)*Z(690)-2*Z(100)*Z(13)-2
     &*Z(684)*Z(17)-2*Z(95)*Z(127)-2*Z(97)*Z(634)-2*Z(102)*Z(698)-2*Z(10
     &3)*Z(706)-2*Z(104)*Z(714)-2*Z(105)*Z(722)-2*Z(106)*Z(738)-2*Z(107)
     &*Z(746)-2*Z(108)*Z(754))
      Z(688) = -0.5D0*Z(165) - 0.5D0*LRFO*U3 - 0.5D0*LRFO*U5 - 0.5D0*LRF
     &O*U7 - 0.5D0*LRFO*U9
      Z(734) = Z(27)*Z(726) + Z(28)*Z(728)
      Z(957) = MRF*(Z(956)+2*Z(100)*Z(43)+2*Z(684)*Z(564)+Z(99)*Z(734)+2
     &*Z(101)*Z(694)-2*Z(95)*Z(161)-2*Z(97)*Z(638)-2*Z(102)*Z(702)-2*Z(1
     &03)*Z(710)-2*Z(104)*Z(718)-2*Z(105)*Z(726)-2*Z(106)*Z(742)-2*Z(107
     &)*Z(750)-2*Z(108)*Z(758))
      Z(689) = -0.5D0*Z(166) - 0.5D0*LRFFO*U3 - 0.5D0*LRFFO*U5 - 0.5D0*L
     &RFFO*U7 - 0.5D0*LRFFO*U9
      Z(867) = -Z(11)*Z(16) - Z(12)*Z(15)
      Z(114) = Z(1)*Z(62) + Z(2)*Z(63)
      Z(668) = Z(12)*Z(658) - Z(11)*Z(660)
      Z(846) = Z(12)*Z(836) - Z(11)*Z(838)
      Z(893) = Z(12)*Z(883) - Z(11)*Z(885)
      Z(116) = Z(1)*Z(63) - Z(2)*Z(62)
      Z(929) = Z(19)*Z(114) + Z(20)*Z(116)
      Z(819) = Z(8)*Z(209) - Z(7)*Z(210)
      Z(620) = Z(12)*Z(610) - Z(11)*Z(612)
      Z(740) = Z(12)*Z(722) - Z(11)*Z(724)
      Z(784) = Z(12)*Z(774) - Z(11)*Z(776)
      Z(744) = Z(12)*Z(726) - Z(11)*Z(728)
      Z(973) = MRF*(2*Z(103)*Z(867)+2*Z(95)*Z(114)+2*Z(97)*Z(668)+2*Z(10
     &2)*Z(846)+2*Z(104)*Z(893)+2*Z(108)*Z(929)-2*Z(686)*Z(568)-2*Z(877)
     &*Z(8)-2*Z(906)*Z(819)-2*Z(907)*Z(12)-2*Z(684)*Z(620)-2*Z(904)*Z(74
     &0)-2*Z(905)*Z(784)-Z(99)*Z(744))
      Z(910) = Z(237) + Z(230)*U9 + Z(231)*U3 + Z(232)*U5 + Z(233)*U7 + 
     &Z(234)*U1 + Z(235)*U2 - Z(236)*U4
      Z(574) = ITH*LHp
      Z(580) = ITH*RHp
      Z(587) = Z(107)*Z(4) + Z(583)*Z(6) + 0.5D0*Z(99)*Z(163) + 0.5D0*Z(
     &99)*Z(258) - Z(102)*Z(22) - Z(108)*Z(20) - Z(582)*Z(33) - Z(97)*Z(
     &155) - Z(103)*Z(135) - Z(104)*Z(149) - Z(105)*Z(123) - Z(106)*Z(11
     &5) - Z(584)*Z(141) - 0.5D0*Z(585)*Z(129)
      Z(947) = MHAT*Z(587)
      Z(588) = Z(323) + Z(318)*U9 + Z(319)*U3 + Z(319)*U5 + Z(320)*U7 + 
     &Z(321)*U1 + Z(322)*U2
      Z(140) = Z(1)*Z(41) + Z(2)*Z(42)
      Z(142) = Z(1)*Z(42) - Z(2)*Z(41)
      Z(595) = Z(5)*Z(140) - Z(6)*Z(142)
      Z(603) = Z(41)*Z(72) + Z(42)*Z(73)
      Z(605) = Z(41)*Z(74) + Z(42)*Z(75)
      Z(611) = -Z(15)*Z(603) - Z(16)*Z(605)
      Z(613) = Z(16)*Z(603) - Z(15)*Z(605)
      Z(615) = Z(27)*Z(611) + Z(28)*Z(613)
      Z(599) = Z(21)*Z(140) + Z(22)*Z(142)
      Z(607) = Z(41)*Z(79) + Z(42)*Z(80)
      Z(619) = -Z(11)*Z(611) - Z(12)*Z(613)
      Z(623) = Z(3)*Z(140) - Z(4)*Z(142)
      Z(627) = Z(19)*Z(140) + Z(20)*Z(142)
      Z(631) = Z(100)*Z(31) + 0.5D0*Z(99)*Z(566) + Z(101)*Z(595) + 0.5D0
     &*Z(99)*Z(615) - 0.5D0*Z(98)*Z(18) - Z(95)*Z(140) - Z(97)*Z(591) - 
     &Z(102)*Z(599) - Z(103)*Z(603) - Z(104)*Z(607) - Z(105)*Z(611) - Z(
     &106)*Z(619) - Z(107)*Z(623) - Z(108)*Z(627)
      Z(949) = MFF*Z(631)
      Z(632) = Z(39)*U1 + Z(40)*U2
      Z(88) = Z(25)*Z(85) - Z(26)*Z(83)
      Z(154) = Z(1)*Z(88) + Z(2)*Z(89)
      Z(592) = Z(39)*Z(88) + Z(40)*Z(89)
      Z(593) = Z(41)*Z(88) + Z(42)*Z(89)
      Z(635) = -Z(17)*Z(592) - Z(18)*Z(593)
      Z(637) = Z(18)*Z(592) - Z(17)*Z(593)
      Z(639) = Z(27)*Z(635) + Z(28)*Z(637)
      Z(651) = Z(72)*Z(88) + Z(73)*Z(89)
      Z(653) = Z(74)*Z(88) + Z(75)*Z(89)
      Z(659) = -Z(15)*Z(651) - Z(16)*Z(653)
      Z(661) = Z(16)*Z(651) - Z(15)*Z(653)
      Z(663) = Z(27)*Z(659) + Z(28)*Z(661)
      Z(655) = Z(79)*Z(88) + Z(80)*Z(89)
      Z(667) = -Z(11)*Z(659) - Z(12)*Z(661)
      Z(156) = Z(1)*Z(89) - Z(2)*Z(88)
      Z(671) = Z(3)*Z(154) - Z(4)*Z(156)
      Z(675) = Z(19)*Z(154) + Z(20)*Z(156)
      Z(643) = -Z(13)*Z(635) - Z(14)*Z(637)
      Z(647) = Z(5)*Z(154) - Z(6)*Z(156)
      Z(681) = Z(679)*Z(154) + 0.5D0*Z(99)*Z(639) + 0.5D0*Z(99)*Z(663) -
     & Z(678)*Z(26) - Z(103)*Z(651) - Z(104)*Z(655) - Z(105)*Z(659) - Z(
     &106)*Z(667) - Z(107)*Z(671) - Z(108)*Z(675) - Z(582)*Z(643) - Z(58
     &3)*Z(647) - Z(584)*Z(592) - 0.5D0*Z(585)*Z(635)
      Z(951) = MLLA*Z(681)
      Z(682) = Z(404) + Z(397)*U9 + Z(398)*U3 + Z(399)*U5 + Z(400)*U7 + 
     &Z(403)*U11 + Z(401)*U1 + Z(402)*U2
      Z(767) = Z(37)*Z(72) + Z(38)*Z(73)
      Z(769) = Z(37)*Z(74) + Z(38)*Z(75)
      Z(775) = -Z(15)*Z(767) - Z(16)*Z(769)
      Z(777) = Z(16)*Z(767) - Z(15)*Z(769)
      Z(779) = Z(27)*Z(775) + Z(28)*Z(777)
      Z(763) = Z(21)*Z(34) + Z(22)*Z(32)
      Z(787) = Z(3)*Z(34) - Z(4)*Z(32)
      Z(791) = Z(19)*Z(34) + Z(20)*Z(32)
      Z(644) = Z(14)*Z(634) - Z(13)*Z(636)
      Z(771) = Z(37)*Z(79) + Z(38)*Z(80)
      Z(783) = -Z(11)*Z(775) - Z(12)*Z(777)
      Z(795) = Z(101)*Z(10) + 0.5D0*Z(99)*Z(44) + 0.5D0*Z(99)*Z(779) - Z
     &(95)*Z(34) - Z(102)*Z(763) - Z(107)*Z(787) - Z(108)*Z(791) - Z(584
     &)*Z(30) - 0.5D0*Z(585)*Z(14) - Z(97)*Z(644) - Z(103)*Z(767) - Z(10
     &4)*Z(771) - Z(105)*Z(775) - Z(106)*Z(783)
      Z(959) = MSH*Z(795)
      Z(796) = Z(181) + Z(178)*U3 + Z(178)*U5 + Z(178)*U7 + Z(178)*U9 + 
     &Z(179)*U1 + Z(180)*U2
      Z(696) = Z(5)*Z(163) + Z(6)*Z(161)
      Z(56) = Z(6)*Z(1) - Z(5)*Z(2)
      Z(802) = Z(54)*Z(73) + Z(56)*Z(72)
      Z(804) = Z(54)*Z(75) + Z(56)*Z(74)
      Z(810) = -Z(15)*Z(802) - Z(16)*Z(804)
      Z(812) = Z(16)*Z(802) - Z(15)*Z(804)
      Z(814) = Z(27)*Z(810) + Z(28)*Z(812)
      Z(799) = Z(5)*Z(22) + Z(6)*Z(21)
      Z(818) = -Z(7)*Z(211) - Z(8)*Z(209)
      Z(822) = Z(5)*Z(20) + Z(6)*Z(19)
      Z(648) = Z(5)*Z(155) + Z(6)*Z(153)
      Z(806) = Z(54)*Z(80) + Z(56)*Z(79)
      Z(596) = Z(5)*Z(141) + Z(6)*Z(139)
      Z(692) = Z(5)*Z(129) + Z(6)*Z(127)
      Z(825) = Z(582)*Z(10) + 0.5D0*Z(99)*Z(696) + 0.5D0*Z(99)*Z(814) - 
     &Z(95)*Z(6) - Z(102)*Z(799) - Z(106)*Z(818) - Z(107)*Z(211) - Z(108
     &)*Z(822) - Z(97)*Z(648) - Z(103)*Z(802) - Z(104)*Z(806) - Z(105)*Z
     &(810) - Z(584)*Z(596) - 0.5D0*Z(585)*Z(692)
      Z(961) = MTH*Z(825)
      Z(826) = Z(197) + Z(193)*U9 + Z(194)*U3 + Z(194)*U5 + Z(194)*U7 + 
     &Z(195)*U1 + Z(196)*U2
      Z(704) = Z(21)*Z(163) - Z(22)*Z(161)
      Z(829) = Z(72)*Z(85) + Z(73)*Z(83)
      Z(831) = Z(74)*Z(85) + Z(75)*Z(83)
      Z(837) = -Z(15)*Z(829) - Z(16)*Z(831)
      Z(839) = Z(16)*Z(829) - Z(15)*Z(831)
      Z(841) = Z(27)*Z(837) + Z(28)*Z(839)
      Z(849) = -Z(3)*Z(22) - Z(4)*Z(21)
      Z(852) = Z(20)*Z(21) - Z(19)*Z(22)
      Z(764) = Z(21)*Z(33) - Z(22)*Z(32)
      Z(800) = -Z(5)*Z(22) - Z(6)*Z(21)
      Z(833) = Z(79)*Z(85) + Z(80)*Z(83)
      Z(845) = -Z(11)*Z(837) - Z(12)*Z(839)
      Z(600) = Z(21)*Z(141) - Z(22)*Z(139)
      Z(700) = Z(21)*Z(129) - Z(22)*Z(127)
      Z(855) = 0.5D0*Z(99)*Z(704) + 0.5D0*Z(99)*Z(841) - Z(97)*Z(26) - Z
     &(107)*Z(849) - Z(108)*Z(852) - Z(582)*Z(764) - Z(583)*Z(800) - Z(6
     &79)*Z(22) - Z(103)*Z(829) - Z(104)*Z(833) - Z(105)*Z(837) - Z(106)
     &*Z(845) - Z(584)*Z(600) - 0.5D0*Z(585)*Z(700)
      Z(963) = MLUA*Z(855)
      Z(856) = Z(383) + Z(377)*U9 + Z(378)*U3 + Z(379)*U5 + Z(380)*U7 + 
     &Z(381)*U1 + Z(382)*U2
      Z(866) = Z(11)*Z(16) + Z(12)*Z(15)
      Z(863) = -Z(27)*Z(16) - Z(28)*Z(15)
      Z(134) = Z(1)*Z(74) + Z(2)*Z(75)
      Z(136) = Z(1)*Z(75) - Z(2)*Z(74)
      Z(869) = Z(3)*Z(134) - Z(4)*Z(136)
      Z(873) = Z(19)*Z(134) + Z(20)*Z(136)
      Z(880) = Z(876)*Z(866) + 0.5D0*Z(99)*Z(863) + Z(877)*Z(869) + 0.5D
     &0*Z(99)*Z(712) - Z(878)*Z(16) - Z(95)*Z(134) - Z(97)*Z(652) - Z(10
     &2)*Z(830) - Z(104)*Z(859) - Z(108)*Z(873) - Z(582)*Z(768) - Z(583)
     &*Z(803) - Z(584)*Z(604) - 0.5D0*Z(585)*Z(708)
      Z(965) = MFF*Z(880)
      Z(881) = Z(294) + Z(285)*U8 + Z(286)*U9 + Z(287)*U5 + Z(288)*U7 + 
     &Z(289)*U3 + Z(290)*U4 + Z(291)*U6 + Z(292)*U1 + Z(293)*U2
      Z(81) = Z(23)*Z(78) - Z(24)*Z(76)
      Z(148) = Z(1)*Z(81) + Z(2)*Z(82)
      Z(720) = Z(46)*Z(81) + Z(47)*Z(82)
      Z(860) = Z(72)*Z(81) + Z(73)*Z(82)
      Z(861) = Z(74)*Z(81) + Z(75)*Z(82)
      Z(884) = -Z(15)*Z(860) - Z(16)*Z(861)
      Z(886) = Z(16)*Z(860) - Z(15)*Z(861)
      Z(888) = Z(27)*Z(884) + Z(28)*Z(886)
      Z(656) = Z(81)*Z(86) + Z(82)*Z(87)
      Z(834) = Z(81)*Z(83) + Z(82)*Z(84)
      Z(892) = -Z(11)*Z(884) - Z(12)*Z(886)
      Z(150) = Z(1)*Z(82) - Z(2)*Z(81)
      Z(896) = Z(3)*Z(148) - Z(4)*Z(150)
      Z(772) = Z(35)*Z(81) + Z(36)*Z(82)
      Z(807) = Z(54)*Z(81) + Z(55)*Z(82)
      Z(608) = Z(39)*Z(81) + Z(40)*Z(82)
      Z(716) = Z(50)*Z(81) + Z(51)*Z(82)
      Z(901) = Z(679)*Z(148) + 0.5D0*Z(99)*Z(720) + 0.5D0*Z(99)*Z(888) -
     & Z(899)*Z(24) - Z(97)*Z(656) - Z(102)*Z(834) - Z(103)*Z(860) - Z(1
     &05)*Z(884) - Z(106)*Z(892) - Z(107)*Z(896) - Z(582)*Z(772) - Z(583
     &)*Z(807) - Z(584)*Z(608) - 0.5D0*Z(585)*Z(716)
      Z(967) = MRLA*Z(901)
      Z(902) = Z(359) + Z(352)*U9 + Z(353)*U3 + Z(354)*U5 + Z(355)*U7 + 
     &Z(358)*U10 + Z(356)*U1 + Z(357)*U2
      Z(933) = Z(877)*Z(8) + 0.5D0*Z(99)*Z(568) + 0.5D0*Z(99)*Z(744) - Z
     &(103)*Z(867) - Z(105)*Z(12) - Z(583)*Z(819) - Z(95)*Z(114) - Z(97)
     &*Z(668) - Z(102)*Z(846) - Z(104)*Z(893) - Z(108)*Z(929) - Z(582)*Z
     &(784) - Z(584)*Z(620) - 0.5D0*Z(585)*Z(740)
      Z(975) = MSH*Z(933)
      Z(752) = Z(3)*Z(163) + Z(4)*Z(161)
      Z(918) = Z(3)*Z(258) + Z(4)*Z(256)
      Z(850) = Z(3)*Z(22) + Z(4)*Z(21)
      Z(936) = Z(3)*Z(20) + Z(4)*Z(19)
      Z(788) = Z(3)*Z(33) + Z(4)*Z(32)
      Z(672) = Z(3)*Z(155) + Z(4)*Z(153)
      Z(870) = Z(3)*Z(135) + Z(4)*Z(133)
      Z(897) = Z(3)*Z(149) + Z(4)*Z(147)
      Z(914) = Z(3)*Z(123) + Z(4)*Z(121)
      Z(624) = Z(3)*Z(141) + Z(4)*Z(139)
      Z(748) = Z(3)*Z(129) + Z(4)*Z(127)
      Z(939) = Z(106)*Z(8) + 0.5D0*Z(99)*Z(752) + 0.5D0*Z(99)*Z(918) - Z
     &(95)*Z(4) - Z(102)*Z(850) - Z(108)*Z(936) - Z(582)*Z(788) - Z(583)
     &*Z(210) - Z(97)*Z(672) - Z(103)*Z(870) - Z(104)*Z(897) - Z(105)*Z(
     &914) - Z(584)*Z(624) - 0.5D0*Z(585)*Z(748)
      Z(977) = MTH*Z(939)
      Z(940) = Z(217) + Z(212)*U9 + Z(213)*U3 + Z(213)*U5 + Z(214)*U7 + 
     &Z(215)*U1 + Z(216)*U2
      Z(760) = Z(19)*Z(163) - Z(20)*Z(161)
      Z(926) = Z(19)*Z(258) - Z(20)*Z(256)
      Z(853) = Z(19)*Z(22) - Z(20)*Z(21)
      Z(937) = -Z(3)*Z(20) - Z(4)*Z(19)
      Z(792) = Z(19)*Z(33) - Z(20)*Z(32)
      Z(823) = -Z(5)*Z(20) - Z(6)*Z(19)
      Z(676) = Z(19)*Z(155) - Z(20)*Z(153)
      Z(874) = Z(19)*Z(135) - Z(20)*Z(133)
      Z(922) = Z(19)*Z(123) - Z(20)*Z(121)
      Z(930) = Z(19)*Z(115) - Z(20)*Z(113)
      Z(628) = Z(19)*Z(141) - Z(20)*Z(139)
      Z(756) = Z(19)*Z(129) - Z(20)*Z(127)
      Z(943) = 0.5D0*Z(99)*Z(760) + 0.5D0*Z(99)*Z(926) - Z(102)*Z(853) -
     & Z(104)*Z(24) - Z(107)*Z(937) - Z(582)*Z(792) - Z(583)*Z(823) - Z(
     &679)*Z(20) - Z(97)*Z(676) - Z(103)*Z(874) - Z(105)*Z(922) - Z(106)
     &*Z(930) - Z(584)*Z(628) - 0.5D0*Z(585)*Z(756)
      Z(979) = MRUA*Z(943)
      Z(944) = Z(338) + Z(332)*U9 + Z(333)*U3 + Z(334)*U5 + Z(335)*U7 + 
     &Z(336)*U1 + Z(337)*U2
      Z(953) = MRF*(2*Z(100)*Z(31)+2*Z(686)*Z(566)+Z(99)*Z(615)+2*Z(101)
     &*Z(595)-2*Z(685)*Z(18)-2*Z(95)*Z(140)-2*Z(97)*Z(591)-2*Z(102)*Z(59
     &9)-2*Z(103)*Z(603)-2*Z(104)*Z(607)-2*Z(105)*Z(611)-2*Z(106)*Z(619)
     &-2*Z(107)*Z(623)-2*Z(108)*Z(627))
      Z(969) = MRF*(2*Z(876)*Z(11)+2*Z(95)*Z(121)+2*Z(97)*Z(658)+2*Z(102
     &)*Z(836)+2*Z(104)*Z(883)+2*Z(108)*Z(920)-2*Z(907)-2*Z(968)-2*Z(103
     &)*Z(15)-2*Z(684)*Z(610)-2*Z(877)*Z(912)-2*Z(904)*Z(722)-2*Z(905)*Z
     &(774)-2*Z(906)*Z(809)-Z(99)*Z(726))
      Z(908) = Z(260) + Z(91)*U3 + Z(91)*U4 + Z(91)*U6 + Z(91)*U8
      Z(971) = MRF*(2*Z(103)*Z(862)+2*Z(95)*Z(256)+2*Z(97)*Z(662)+2*Z(10
     &2)*Z(840)+2*Z(104)*Z(887)+2*Z(108)*Z(924)-2*Z(686)-2*Z(970)-2*Z(87
     &6)*Z(567)-2*Z(684)*Z(614)-2*Z(877)*Z(916)-2*Z(904)*Z(730)-2*Z(905)
     &*Z(778)-2*Z(906)*Z(813)-Z(99)*Z(734))
      Z(909) = -0.5D0*Z(261) - 0.5D0*LRFFO*U3 - 0.5D0*LRFFO*U4 - 0.5D0*L
     &RFFO*U6 - 0.5D0*LRFFO*U8
      Z(972) = MRF*(2*Z(103)*Z(865)+2*Z(877)*Z(7)+2*Z(907)*Z(11)+2*Z(95)
     &*Z(113)+2*Z(97)*Z(666)+2*Z(102)*Z(844)+2*Z(104)*Z(891)+2*Z(108)*Z(
     &928)-2*Z(876)-2*Z(686)*Z(567)-2*Z(906)*Z(817)-2*Z(684)*Z(618)-2*Z(
     &904)*Z(738)-2*Z(905)*Z(782)-Z(99)*Z(742))
      Z(911) = Z(254) + LSH*U6 + Z(238)*U9 + Z(240)*U5 + Z(241)*U7 + Z(2
     &52)*U3 + Z(253)*U4 + Z(242)*U1 + Z(243)*U2
      HZ = Z(570) + Z(571) + Z(572) + Z(573) + Z(575) + Z(576) + Z(577) 
     &+ Z(578) + Z(579) + Z(581) + IFF*U4 + IFF*U5 + IFF*U6 + IFF*U7 + I
     &FF*U8 + IFF*U9 + IHAT*U3 + ILLA*U11 + ILLA*U13 + ILLA*U3 + ILUA*U1
     &1 + ILUA*U3 + IRF*U4 + IRF*U5 + IRF*U6 + IRF*U7 + IRF*U8 + IRF*U9 
     &+ IRLA*U10 + IRLA*U12 + IRLA*U3 + IRUA*U10 + IRUA*U3 + ISH*U4 + IS
     &H*U5 + ISH*U6 + ISH*U7 + ITH*U4 + ITH*U5 + 2*IFF*U3 + 2*IRF*U3 + 2
     &*ISH*U3 + 2*ITH*U3 + Z(946)*Z(589) + Z(948)*Z(633) + Z(950)*Z(683)
     & + Z(958)*Z(797) + Z(960)*Z(827) + Z(962)*Z(857) + Z(964)*Z(882) +
     & Z(966)*Z(903) + Z(974)*Z(934) + Z(976)*Z(941) + Z(978)*Z(945) + 0
     &.5D0*Z(952)*Z(687) + 0.5D0*Z(955)*Z(688) + 0.5D0*Z(957)*Z(689) + 0
     &.5D0*Z(973)*Z(910) - Z(574) - Z(580) - Z(947)*Z(588) - Z(949)*Z(63
     &2) - Z(951)*Z(682) - Z(959)*Z(796) - Z(961)*Z(826) - Z(963)*Z(856)
     & - Z(965)*Z(881) - Z(967)*Z(902) - Z(975)*Z(910) - Z(977)*Z(940) -
     & Z(979)*Z(944) - 0.5D0*Z(953)*Z(632) - 0.5D0*Z(969)*Z(908) - 0.5D0
     &*Z(971)*Z(909) - 0.5D0*Z(972)*Z(911)
      Z(993) = MFF*Z(39)
      Z(994) = MFF*Z(40)
      Z(1016) = MRF*Z(39)
      Z(1017) = MRF*Z(40)
      Z(1099) = MRF*Z(260)
      Z(985) = MHAT*Z(323)
      Z(980) = MHAT*Z(318)
      Z(981) = MHAT*Z(319)
      Z(982) = MHAT*Z(320)
      Z(983) = MHAT*Z(321)
      Z(984) = MHAT*Z(322)
      Z(1029) = MSH*Z(181)
      Z(1026) = MSH*Z(178)
      Z(1027) = MSH*Z(179)
      Z(1028) = MSH*Z(180)
      Z(1034) = MSH*Z(189)
      Z(1030) = MSH*Z(182)
      Z(1031) = MSH*Z(188)
      Z(1032) = MSH*Z(183)
      Z(1033) = MSH*Z(184)
      Z(1039) = MTH*Z(197)
      Z(1035) = MTH*Z(193)
      Z(1036) = MTH*Z(194)
      Z(1037) = MTH*Z(195)
      Z(1038) = MTH*Z(196)
      Z(1045) = MTH*Z(205)
      Z(1040) = MTH*Z(198)
      Z(1041) = MTH*Z(199)
      Z(1042) = MTH*Z(204)
      Z(1043) = MTH*Z(200)
      Z(1044) = MTH*Z(201)
      Z(1140) = MTH*Z(217)
      Z(1135) = MTH*Z(212)
      Z(1136) = MTH*Z(213)
      Z(1137) = MTH*Z(214)
      Z(1138) = MTH*Z(215)
      Z(1139) = MTH*Z(216)
      Z(1155) = MRUA*Z(338)
      Z(1149) = MRUA*Z(332)
      Z(1150) = MRUA*Z(333)
      Z(1151) = MRUA*Z(334)
      Z(1152) = MRUA*Z(335)
      Z(1153) = MRUA*Z(336)
      Z(1154) = MRUA*Z(337)
      Z(1052) = MLUA*Z(383)
      Z(1046) = MLUA*Z(377)
      Z(1047) = MLUA*Z(378)
      Z(1048) = MLUA*Z(379)
      Z(1049) = MLUA*Z(380)
      Z(1050) = MLUA*Z(381)
      Z(1051) = MLUA*Z(382)
      Z(1148) = MTH*Z(226)
      Z(1142) = MTH*Z(218)
      Z(1143) = MTH*Z(219)
      Z(1144) = MTH*Z(220)
      Z(1145) = MTH*Z(225)
      Z(1146) = MTH*Z(221)
      Z(1147) = MTH*Z(222)
      Z(1163) = MRUA*Z(348)
      Z(1157) = MRUA*Z(339)
      Z(1158) = MRUA*Z(340)
      Z(1159) = MRUA*Z(341)
      Z(1160) = MRUA*Z(347)
      Z(1161) = MRUA*Z(343)
      Z(1162) = MRUA*Z(344)
      Z(1088) = MRLA*Z(359)
      Z(1081) = MRLA*Z(352)
      Z(1082) = MRLA*Z(353)
      Z(1083) = MRLA*Z(354)
      Z(1084) = MRLA*Z(355)
      Z(1085) = MRLA*Z(358)
      Z(1086) = MRLA*Z(356)
      Z(1087) = MRLA*Z(357)
      Z(1060) = MLUA*Z(393)
      Z(1054) = MLUA*Z(384)
      Z(1055) = MLUA*Z(385)
      Z(1056) = MLUA*Z(386)
      Z(1057) = MLUA*Z(392)
      Z(1058) = MLUA*Z(388)
      Z(1059) = MLUA*Z(389)
      Z(1006) = MLLA*Z(404)
      Z(999) = MLLA*Z(397)
      Z(1000) = MLLA*Z(398)
      Z(1001) = MLLA*Z(399)
      Z(1002) = MLLA*Z(400)
      Z(1003) = MLLA*Z(403)
      Z(1004) = MLLA*Z(401)
      Z(1005) = MLLA*Z(402)
      Z(1097) = MRLA*Z(372)
      Z(1090) = MRLA*Z(361)
      Z(1091) = MRLA*Z(362)
      Z(1092) = MRLA*Z(363)
      Z(1093) = MRLA*Z(370)
      Z(1094) = MRLA*Z(371)
      Z(1095) = MRLA*Z(365)
      Z(1096) = MRLA*Z(366)
      Z(1015) = MLLA*Z(417)
      Z(1008) = MLLA*Z(406)
      Z(1009) = MLLA*Z(407)
      Z(1010) = MLLA*Z(408)
      Z(1011) = MLLA*Z(415)
      Z(1012) = MLLA*Z(416)
      Z(1013) = MLLA*Z(410)
      Z(1014) = MLLA*Z(411)
      Z(1070) = MFF*Z(294)
      Z(1061) = MFF*Z(285)
      Z(1062) = MFF*Z(286)
      Z(1063) = MFF*Z(287)
      Z(1064) = MFF*Z(288)
      Z(1065) = MFF*Z(289)
      Z(1066) = MFF*Z(290)
      Z(1067) = MFF*Z(291)
      Z(1068) = MFF*Z(292)
      Z(1069) = MFF*Z(293)
      Z(1080) = MFF*Z(311)
      Z(1071) = MFF*Z(296)
      Z(1072) = MFF*Z(297)
      Z(1073) = MFF*Z(298)
      Z(1074) = MFF*Z(307)
      Z(1075) = MFF*Z(308)
      Z(1076) = MFF*Z(309)
      Z(1077) = MFF*Z(310)
      Z(1078) = MFF*Z(301)
      Z(1079) = MFF*Z(302)
      Z(1117) = MRF*Z(254)
      Z(1134) = MSH*Z(250)
      Z(1110) = MRF*Z(238)
      Z(1111) = MRF*Z(240)
      Z(1112) = MRF*Z(241)
      Z(1113) = MRF*Z(252)
      Z(1114) = MRF*Z(253)
      Z(1127) = MSH*Z(238)
      Z(1128) = MSH*Z(240)
      Z(1129) = MSH*Z(241)
      Z(1130) = MSH*Z(248)
      Z(1131) = MSH*Z(249)
      Z(1115) = MRF*Z(242)
      Z(1116) = MRF*Z(243)
      Z(1132) = MSH*Z(242)
      Z(1133) = MSH*Z(243)
      Z(48) = Z(43)*Z(37) + Z(45)*Z(35)
      Z(1025) = MRF*Z(166)
      Z(52) = -Z(13)*Z(37) - Z(14)*Z(35)
      Z(1023) = MRF*Z(165)
      Z(70) = Z(27)*Z(66) - Z(28)*Z(64)
      Z(1100) = MRF*Z(261)
      Z(992) = MHAT*Z(329)
      Z(986) = MHAT*Z(324)
      Z(987) = MHAT*Z(325)
      Z(988) = MHAT*Z(326)
      Z(989) = MHAT*Z(330)
      Z(990) = MHAT*Z(327)
      Z(991) = MHAT*Z(328)
      Z(998) = MFF*Z(158)
      Z(1021) = MRF*Z(159)
      Z(995) = MFF*Z(41)
      Z(996) = MFF*Z(42)
      Z(1018) = MRF*Z(41)
      Z(1019) = MRF*Z(42)
      Z(1107) = MRF*Z(236)
      Z(1124) = MSH*Z(236)
      Z(1108) = MRF*Z(237)
      Z(1125) = MSH*Z(237)
      Z(1101) = MRF*Z(230)
      Z(1102) = MRF*Z(231)
      Z(1103) = MRF*Z(232)
      Z(1104) = MRF*Z(233)
      Z(1118) = MSH*Z(230)
      Z(1119) = MSH*Z(231)
      Z(1120) = MSH*Z(232)
      Z(1121) = MSH*Z(233)
      Z(1105) = MRF*Z(234)
      Z(1106) = MRF*Z(235)
      Z(1122) = MSH*Z(234)
      Z(1123) = MSH*Z(235)
      PX = Z(39)*(Z(993)*U1+Z(994)*U2+Z(1016)*U1+Z(1017)*U2) + Z(66)*(Z(
     &1099)+Z(1098)*U3+Z(1098)*U4+Z(1098)*U6+Z(1098)*U8) + Z(1)*(Z(985)+
     &Z(980)*U9+Z(981)*U3+Z(981)*U5+Z(982)*U7+Z(983)*U1+Z(984)*U2) + Z(3
     &5)*(Z(1029)+Z(1026)*U3+Z(1026)*U5+Z(1026)*U7+Z(1026)*U9+Z(1027)*U1
     &+Z(1028)*U2) + Z(37)*(Z(1034)+Z(1030)*U9+Z(1031)*U3+Z(1031)*U5+Z(1
     &031)*U7+Z(1032)*U1+Z(1033)*U2) + Z(54)*(Z(1039)+Z(1035)*U9+Z(1036)
     &*U3+Z(1036)*U5+Z(1036)*U7+Z(1037)*U1+Z(1038)*U2) + Z(56)*(Z(1045)+
     &Z(1040)*U9+Z(1041)*U7+Z(1042)*U3+Z(1042)*U5+Z(1043)*U1+Z(1044)*U2)
     & + Z(57)*(Z(1140)+Z(1135)*U9+Z(1136)*U3+Z(1136)*U5+Z(1137)*U7+Z(11
     &38)*U1+Z(1139)*U2) + Z(76)*(Z(1155)+Z(1149)*U9+Z(1150)*U3+Z(1151)*
     &U5+Z(1152)*U7+Z(1153)*U1+Z(1154)*U2) + Z(83)*(Z(1052)+Z(1046)*U9+Z
     &(1047)*U3+Z(1048)*U5+Z(1049)*U7+Z(1050)*U1+Z(1051)*U2) + Z(59)*(Z(
     &1148)+Z(1141)*U4+Z(1142)*U9+Z(1143)*U7+Z(1144)*U5+Z(1145)*U3+Z(114
     &6)*U1+Z(1147)*U2) + Z(78)*(Z(1163)+Z(1156)*U10+Z(1157)*U9+Z(1158)*
     &U7+Z(1159)*U5+Z(1160)*U3+Z(1161)*U1+Z(1162)*U2) + Z(79)*(Z(1088)+Z
     &(1081)*U9+Z(1082)*U3+Z(1083)*U5+Z(1084)*U7+Z(1085)*U10+Z(1086)*U1+
     &Z(1087)*U2) + Z(85)*(Z(1060)+Z(1053)*U11+Z(1054)*U9+Z(1055)*U7+Z(1
     &056)*U5+Z(1057)*U3+Z(1058)*U1+Z(1059)*U2) + Z(86)*(Z(1006)+Z(999)*
     &U9+Z(1000)*U3+Z(1001)*U5+Z(1002)*U7+Z(1003)*U11+Z(1004)*U1+Z(1005)
     &*U2) + Z(81)*(Z(1097)+Z(1089)*U12+Z(1090)*U9+Z(1091)*U7+Z(1092)*U5
     &+Z(1093)*U10+Z(1094)*U3+Z(1095)*U1+Z(1096)*U2) + Z(88)*(Z(1015)+Z(
     &1007)*U13+Z(1008)*U9+Z(1009)*U7+Z(1010)*U5+Z(1011)*U11+Z(1012)*U3+
     &Z(1013)*U1+Z(1014)*U2) + Z(72)*(Z(1070)+Z(1061)*U8+Z(1062)*U9+Z(10
     &63)*U5+Z(1064)*U7+Z(1065)*U3+Z(1066)*U4+Z(1067)*U6+Z(1068)*U1+Z(10
     &69)*U2) + Z(74)*(Z(1080)+Z(1071)*U9+Z(1072)*U5+Z(1073)*U7+Z(1074)*
     &U3+Z(1075)*U4+Z(1076)*U6+Z(1077)*U8+Z(1078)*U1+Z(1079)*U2) + Z(62)
     &*(Z(1117)+Z(1134)+Z(1109)*U6+Z(1126)*U6+Z(1110)*U9+Z(1111)*U5+Z(11
     &12)*U7+Z(1113)*U3+Z(1114)*U4+Z(1127)*U9+Z(1128)*U5+Z(1129)*U7+Z(11
     &30)*U3+Z(1131)*U4+Z(1115)*U1+Z(1116)*U2+Z(1132)*U1+Z(1133)*U2) - 0
     &.5D0*Z(48)*(Z(1025)+Z(1024)*U3+Z(1024)*U5+Z(1024)*U7+Z(1024)*U9) -
     & 0.5D0*Z(52)*(Z(1023)+Z(1022)*U3+Z(1022)*U5+Z(1022)*U7+Z(1022)*U9)
     & - 0.5D0*Z(70)*(Z(1100)+Z(1024)*U3+Z(1024)*U4+Z(1024)*U6+Z(1024)*U
     &8) - Z(2)*(Z(992)+Z(986)*U9+Z(987)*U7+Z(988)*U5+Z(989)*U3+Z(990)*U
     &1+Z(991)*U2) - Z(41)*(Z(998)+Z(1021)+Z(997)*U3+Z(997)*U5+Z(997)*U7
     &+Z(997)*U9+Z(1020)*U3+Z(1020)*U5+Z(1020)*U7+Z(1020)*U9-Z(995)*U1-Z
     &(996)*U2-Z(1018)*U1-Z(1019)*U2) - Z(60)*(Z(1107)*U4+Z(1124)*U4-Z(1
     &108)-Z(1125)-Z(1101)*U9-Z(1102)*U3-Z(1103)*U5-Z(1104)*U7-Z(1118)*U
     &9-Z(1119)*U3-Z(1120)*U5-Z(1121)*U7-Z(1105)*U1-Z(1106)*U2-Z(1122)*U
     &1-Z(1123)*U2)
      PY = Z(40)*(Z(993)*U1+Z(994)*U2+Z(1016)*U1+Z(1017)*U2) + Z(67)*(Z(
     &1099)+Z(1098)*U3+Z(1098)*U4+Z(1098)*U6+Z(1098)*U8) + Z(1)*(Z(992)+
     &Z(986)*U9+Z(987)*U7+Z(988)*U5+Z(989)*U3+Z(990)*U1+Z(991)*U2) + Z(2
     &)*(Z(985)+Z(980)*U9+Z(981)*U3+Z(981)*U5+Z(982)*U7+Z(983)*U1+Z(984)
     &*U2) + Z(36)*(Z(1029)+Z(1026)*U3+Z(1026)*U5+Z(1026)*U7+Z(1026)*U9+
     &Z(1027)*U1+Z(1028)*U2) + Z(38)*(Z(1034)+Z(1030)*U9+Z(1031)*U3+Z(10
     &31)*U5+Z(1031)*U7+Z(1032)*U1+Z(1033)*U2) + Z(54)*(Z(1045)+Z(1040)*
     &U9+Z(1041)*U7+Z(1042)*U3+Z(1042)*U5+Z(1043)*U1+Z(1044)*U2) + Z(55)
     &*(Z(1039)+Z(1035)*U9+Z(1036)*U3+Z(1036)*U5+Z(1036)*U7+Z(1037)*U1+Z
     &(1038)*U2) + Z(58)*(Z(1140)+Z(1135)*U9+Z(1136)*U3+Z(1136)*U5+Z(113
     &7)*U7+Z(1138)*U1+Z(1139)*U2) + Z(77)*(Z(1155)+Z(1149)*U9+Z(1150)*U
     &3+Z(1151)*U5+Z(1152)*U7+Z(1153)*U1+Z(1154)*U2) + Z(84)*(Z(1052)+Z(
     &1046)*U9+Z(1047)*U3+Z(1048)*U5+Z(1049)*U7+Z(1050)*U1+Z(1051)*U2) +
     & Z(57)*(Z(1148)+Z(1141)*U4+Z(1142)*U9+Z(1143)*U7+Z(1144)*U5+Z(1145
     &)*U3+Z(1146)*U1+Z(1147)*U2) + Z(76)*(Z(1163)+Z(1156)*U10+Z(1157)*U
     &9+Z(1158)*U7+Z(1159)*U5+Z(1160)*U3+Z(1161)*U1+Z(1162)*U2) + Z(80)*
     &(Z(1088)+Z(1081)*U9+Z(1082)*U3+Z(1083)*U5+Z(1084)*U7+Z(1085)*U10+Z
     &(1086)*U1+Z(1087)*U2) + Z(83)*(Z(1060)+Z(1053)*U11+Z(1054)*U9+Z(10
     &55)*U7+Z(1056)*U5+Z(1057)*U3+Z(1058)*U1+Z(1059)*U2) + Z(87)*(Z(100
     &6)+Z(999)*U9+Z(1000)*U3+Z(1001)*U5+Z(1002)*U7+Z(1003)*U11+Z(1004)*
     &U1+Z(1005)*U2) + Z(82)*(Z(1097)+Z(1089)*U12+Z(1090)*U9+Z(1091)*U7+
     &Z(1092)*U5+Z(1093)*U10+Z(1094)*U3+Z(1095)*U1+Z(1096)*U2) + Z(89)*(
     &Z(1015)+Z(1007)*U13+Z(1008)*U9+Z(1009)*U7+Z(1010)*U5+Z(1011)*U11+Z
     &(1012)*U3+Z(1013)*U1+Z(1014)*U2) + Z(73)*(Z(1070)+Z(1061)*U8+Z(106
     &2)*U9+Z(1063)*U5+Z(1064)*U7+Z(1065)*U3+Z(1066)*U4+Z(1067)*U6+Z(106
     &8)*U1+Z(1069)*U2) + Z(75)*(Z(1080)+Z(1071)*U9+Z(1072)*U5+Z(1073)*U
     &7+Z(1074)*U3+Z(1075)*U4+Z(1076)*U6+Z(1077)*U8+Z(1078)*U1+Z(1079)*U
     &2) + Z(63)*(Z(1117)+Z(1134)+Z(1109)*U6+Z(1126)*U6+Z(1110)*U9+Z(111
     &1)*U5+Z(1112)*U7+Z(1113)*U3+Z(1114)*U4+Z(1127)*U9+Z(1128)*U5+Z(112
     &9)*U7+Z(1130)*U3+Z(1131)*U4+Z(1115)*U1+Z(1116)*U2+Z(1132)*U1+Z(113
     &3)*U2) - 0.5D0*Z(49)*(Z(1025)+Z(1024)*U3+Z(1024)*U5+Z(1024)*U7+Z(1
     &024)*U9) - 0.5D0*Z(53)*(Z(1023)+Z(1022)*U3+Z(1022)*U5+Z(1022)*U7+Z
     &(1022)*U9) - 0.5D0*Z(71)*(Z(1100)+Z(1024)*U3+Z(1024)*U4+Z(1024)*U6
     &+Z(1024)*U8) - Z(42)*(Z(998)+Z(1021)+Z(997)*U3+Z(997)*U5+Z(997)*U7
     &+Z(997)*U9+Z(1020)*U3+Z(1020)*U5+Z(1020)*U7+Z(1020)*U9-Z(995)*U1-Z
     &(996)*U2-Z(1018)*U1-Z(1019)*U2) - Z(61)*(Z(1107)*U4+Z(1124)*U4-Z(1
     &108)-Z(1125)-Z(1101)*U9-Z(1102)*U3-Z(1103)*U5-Z(1104)*U7-Z(1118)*U
     &9-Z(1119)*U3-Z(1120)*U5-Z(1121)*U7-Z(1105)*U1-Z(1106)*U2-Z(1122)*U
     &1-Z(1123)*U2)
      Z(1231) = Z(1196) + Z(1199) + Z(1200) + Z(1141)*Z(472) + MFF*(Z(29
     &0)*Z(499)+Z(308)*Z(500)) - Z(1201) - MSH*(Z(236)*Z(480)-Z(249)*Z(4
     &81)) - 0.25D0*MRF*(2*Z(1218)*Z(485)+2*Z(1222)*Z(486)+2*Z(253)*Z(56
     &7)*Z(486)+4*Z(11)*Z(253)*Z(485)+2*Z(1220)*Z(488)+4*Z(236)*Z(483)+2
     &*LRFFO*Z(567)*Z(484)+2*LRFFO*Z(569)*Z(483)+2*Z(236)*Z(567)*Z(489)+
     &4*Z(91)*Z(11)*Z(484)+4*Z(91)*Z(12)*Z(483)+4*Z(11)*Z(236)*Z(488)+4*
     &Z(12)*Z(253)*Z(488)-4*Z(91)*Z(485)-LRFFO*Z(486)-4*Z(12)*Z(236)*Z(4
     &85)-2*Z(236)*Z(569)*Z(486)-4*Z(253)*Z(484)-2*Z(1223)*Z(489)-2*Z(25
     &3)*Z(568)*Z(489))
      Z(1291) = Z(548)*(Z(236)*Z(61)-Z(249)*Z(63)) + 0.5D0*Z(547)*(LRFFO
     &*Z(71)+2*Z(236)*Z(61)-2*Z(91)*Z(67)-2*Z(253)*Z(63)) + Z(1231) - Z(
     &1168)*Z(57) - Z(267)*RRX2*Z(64) - Z(267)*RRY2*Z(65) - Z(282)*RRX2*
     &Z(66) - Z(282)*RRY2*Z(67) - Z(290)*RRX1*Z(72) - Z(290)*RRY1*Z(73) 
     &- Z(314)*RRX1*Z(74) - Z(314)*RRY1*Z(75) - Z(545)*(Z(290)*Z(73)+Z(3
     &08)*Z(75))
      Z(1228) = Z(1225) + Z(1141)*Z(225) + MFF*(Z(289)*Z(290)+Z(307)*Z(3
     &08)) - MSH*(Z(231)*Z(236)-Z(248)*Z(249)) - 0.25D0*MRF*(4*Z(1216)+4
     &*Z(231)*Z(236)+2*LRFFO*Z(231)*Z(569)+2*LRFFO*Z(252)*Z(567)+2*LRFFO
     &*Z(253)*Z(567)+4*Z(91)*Z(11)*Z(252)+4*Z(91)*Z(11)*Z(253)+4*Z(91)*Z
     &(12)*Z(231)-4*Z(1227)-Z(1226)-4*Z(252)*Z(253)-4*Z(91)*Z(12)*Z(236)
     &-2*LRFFO*Z(236)*Z(569))
      Z(1229) = Z(1141)*Z(221) + MFF*(Z(290)*Z(292)+Z(308)*Z(301)) + 0.5
     &D0*MRF*(2*Z(253)*Z(242)-2*Z(236)*Z(234)-2*Z(91)*Z(11)*Z(242)-2*Z(9
     &1)*Z(12)*Z(234)-LRFFO*Z(567)*Z(242)-LRFFO*Z(569)*Z(234)) - MSH*(Z(
     &236)*Z(234)-Z(249)*Z(242))
      Z(1230) = Z(1141)*Z(222) + MFF*(Z(290)*Z(293)+Z(308)*Z(302)) + 0.5
     &D0*MRF*(2*Z(253)*Z(243)-2*Z(236)*Z(235)-2*Z(91)*Z(11)*Z(243)-2*Z(9
     &1)*Z(12)*Z(235)-LRFFO*Z(567)*Z(243)-LRFFO*Z(569)*Z(235)) - MSH*(Z(
     &236)*Z(235)-Z(249)*Z(243))
      RHTQ = Z(1291) + Z(1228)*U3p + Z(1229)*U1p + Z(1230)*U2p
      Z(1236) = Z(1185) + Z(1189) + Z(1191) + Z(997)*Z(436) + MFF*(Z(287
     &)*Z(499)+Z(297)*Z(500)) + MHAT*(Z(319)*Z(507)+Z(326)*Z(505)) + MLL
     &A*(Z(399)*Z(539)+Z(408)*Z(540)) + MLUA*(Z(379)*Z(530)+Z(386)*Z(531
     &)) + MRLA*(Z(354)*Z(522)+Z(363)*Z(523)) + MRUA*(Z(334)*Z(513)+Z(34
     &1)*Z(514)) + MSH*(Z(178)*Z(455)+Z(188)*Z(456)) + MSH*(Z(232)*Z(480
     &)+Z(240)*Z(481)) + MTH*(Z(194)*Z(463)+Z(204)*Z(464)) + MTH*(Z(213)
     &*Z(471)+Z(220)*Z(472)) + 0.25D0*MRF*(LRFFO*Z(442)+LRFO*Z(441)+Z(12
     &18)*Z(441)+Z(1219)*Z(442)+4*LFF*Z(439)+2*LFF*Z(564)*Z(442)+2*LRFFO
     &*Z(564)*Z(439)+Z(1220)*Z(444)+2*LFF*Z(18)*Z(444)-2*LFF*Z(17)*Z(441
     &)-2*LRFO*Z(17)*Z(439)-Z(1221)*Z(445)-2*LFF*Z(566)*Z(445)-2*LRFFO*Z
     &(565)*Z(440)-2*LRFO*Z(18)*Z(440)) - Z(1193) - 0.5D0*MRF*(Z(232)*Z(
     &569)*Z(486)+Z(240)*Z(567)*Z(486)+2*Z(11)*Z(240)*Z(485)+2*Z(12)*Z(2
     &32)*Z(485)+2*Z(12)*Z(240)*Z(488)-2*Z(232)*Z(483)-2*Z(240)*Z(484)-2
     &*Z(11)*Z(232)*Z(488)-Z(232)*Z(567)*Z(489)-Z(240)*Z(568)*Z(489))
      Z(1292) = Z(1166)*Z(42) + LFF*(LRX2*Z(41)+LRY2*Z(42)) + 0.5D0*Z(54
     &7)*(LRFFO*Z(49)+LRFO*Z(53)+2*LFF*Z(42)) + Z(1236) - Z(264)*RRX2*Z(
     &64) - Z(264)*RRY2*Z(65) - Z(274)*RRX2*Z(66) - Z(274)*RRY2*Z(67) - 
     &Z(287)*RRX1*Z(72) - Z(287)*RRY1*Z(73) - Z(297)*RRX1*Z(74) - Z(297)
     &*RRY1*Z(75) - Z(544)*(Z(319)*Z(2)+Z(326)*Z(1)) - Z(545)*(Z(287)*Z(
     &73)+Z(297)*Z(75)) - Z(546)*(Z(399)*Z(87)+Z(408)*Z(89)) - Z(547)*(Z
     &(232)*Z(61)+Z(240)*Z(63)) - Z(548)*(Z(178)*Z(36)+Z(188)*Z(38)) - Z
     &(548)*(Z(232)*Z(61)+Z(240)*Z(63)) - Z(549)*(Z(194)*Z(55)+Z(204)*Z(
     &54)) - Z(549)*(Z(213)*Z(58)+Z(220)*Z(57)) - Z(550)*(Z(379)*Z(84)+Z
     &(386)*Z(83)) - Z(551)*(Z(354)*Z(80)+Z(363)*Z(82)) - Z(552)*(Z(334)
     &*Z(77)+Z(341)*Z(76))
      Z(1233) = Z(1232) + MFF*(Z(287)*Z(289)+Z(297)*Z(307)) + MHAT*(Z(31
     &9)**2+Z(326)*Z(330)) + MLLA*(Z(398)*Z(399)+Z(408)*Z(416)) + MLUA*(
     &Z(378)*Z(379)+Z(386)*Z(392)) + MRLA*(Z(353)*Z(354)+Z(363)*Z(371)) 
     &+ MRUA*(Z(333)*Z(334)+Z(341)*Z(347)) + MSH*(Z(178)**2+Z(188)**2) +
     & MSH*(Z(231)*Z(232)+Z(240)*Z(248)) + MTH*(Z(194)**2+Z(204)**2) + M
     &TH*(Z(213)**2+Z(220)*Z(225)) + 0.25D0*MRF*(Z(1212)+4*Z(1213)*Z(564
     &)-4*Z(1214)*Z(17)) + 0.5D0*MRF*(2*Z(231)*Z(232)+2*Z(240)*Z(252)-2*
     &Z(91)*Z(11)*Z(240)-2*Z(91)*Z(12)*Z(232)-LRFFO*Z(232)*Z(569)-LRFFO*
     &Z(240)*Z(567))
      Z(1234) = MFF*(Z(287)*Z(292)+Z(297)*Z(301)) + MHAT*(Z(319)*Z(321)+
     &Z(326)*Z(327)) + MLLA*(Z(399)*Z(401)+Z(408)*Z(410)) + MLUA*(Z(379)
     &*Z(381)+Z(386)*Z(388)) + MRF*(Z(232)*Z(234)+Z(240)*Z(242)) + MRLA*
     &(Z(354)*Z(356)+Z(363)*Z(365)) + MRUA*(Z(334)*Z(336)+Z(341)*Z(343))
     & + MSH*(Z(178)*Z(179)+Z(188)*Z(183)) + MSH*(Z(232)*Z(234)+Z(240)*Z
     &(242)) + MTH*(Z(194)*Z(195)+Z(204)*Z(200)) + MTH*(Z(213)*Z(215)+Z(
     &220)*Z(221)) + 0.5D0*MRF*(LRFO*Z(17)*Z(41)-2*LFF*Z(41)-LRFFO*Z(564
     &)*Z(41)-LRFFO*Z(565)*Z(39)-LRFO*Z(18)*Z(39)) - Z(997)*Z(41)
      Z(1235) = MFF*(Z(287)*Z(293)+Z(297)*Z(302)) + MHAT*(Z(319)*Z(322)+
     &Z(326)*Z(328)) + MLLA*(Z(399)*Z(402)+Z(408)*Z(411)) + MLUA*(Z(379)
     &*Z(382)+Z(386)*Z(389)) + MRF*(Z(232)*Z(235)+Z(240)*Z(243)) + MRLA*
     &(Z(354)*Z(357)+Z(363)*Z(366)) + MRUA*(Z(334)*Z(337)+Z(341)*Z(344))
     & + MSH*(Z(178)*Z(180)+Z(188)*Z(184)) + MSH*(Z(232)*Z(235)+Z(240)*Z
     &(243)) + MTH*(Z(194)*Z(196)+Z(204)*Z(201)) + MTH*(Z(213)*Z(216)+Z(
     &220)*Z(222)) + 0.5D0*MRF*(LRFO*Z(17)*Z(42)-2*LFF*Z(42)-LRFFO*Z(564
     &)*Z(42)-LRFFO*Z(565)*Z(40)-LRFO*Z(18)*Z(40)) - Z(997)*Z(42)
      LHTQ = Z(1292) + Z(1233)*U3p + Z(1234)*U1p + Z(1235)*U2p
      Z(1243) = Z(1196) + Z(1199) + Z(1200) + Z(1126)*Z(481) + MFF*(Z(29
     &1)*Z(499)+Z(309)*Z(500)) + 0.25D0*MRF*(LRFFO*Z(486)+4*Z(91)*Z(485)
     &+2*Z(1223)*Z(489)+4*LSH*Z(484)+2*LSH*Z(568)*Z(489)-2*Z(1218)*Z(485
     &)-2*Z(1222)*Z(486)-4*LSH*Z(11)*Z(485)-2*LSH*Z(567)*Z(486)-2*Z(1220
     &)*Z(488)-4*LSH*Z(12)*Z(488)-4*Z(91)*Z(11)*Z(484)-4*Z(91)*Z(12)*Z(4
     &83)-2*LRFFO*Z(567)*Z(484)-2*LRFFO*Z(569)*Z(483))
      Z(1293) = 0.5D0*Z(547)*(LRFFO*Z(71)-2*LSH*Z(63)-2*Z(91)*Z(67)) + Z
     &(1243) - Z(1171)*Z(63) - Z(262)*RRX2*Z(64) - Z(262)*RRY2*Z(65) - Z
     &(283)*RRX2*Z(66) - Z(283)*RRY2*Z(67) - Z(291)*RRX1*Z(72) - Z(291)*
     &RRY1*Z(73) - Z(315)*RRX1*Z(74) - Z(315)*RRY1*Z(75) - Z(545)*(Z(291
     &)*Z(73)+Z(309)*Z(75))
      Z(1240) = Z(1237) + Z(1126)*Z(248) + MFF*(Z(289)*Z(291)+Z(307)*Z(3
     &09)) + 0.25D0*MRF*(Z(1215)+4*LSH*Z(252)-4*Z(1216)-4*Z(1238)*Z(11)-
     &2*Z(1239)*Z(567)-4*Z(91)*Z(11)*Z(252)-4*Z(91)*Z(12)*Z(231)-2*LRFFO
     &*Z(231)*Z(569)-2*LRFFO*Z(252)*Z(567))
      Z(1241) = Z(1126)*Z(242) + MFF*(Z(291)*Z(292)+Z(309)*Z(301)) + 0.5
     &D0*MRF*(2*LSH*Z(242)-2*Z(91)*Z(11)*Z(242)-2*Z(91)*Z(12)*Z(234)-LRF
     &FO*Z(567)*Z(242)-LRFFO*Z(569)*Z(234))
      Z(1242) = Z(1126)*Z(243) + MFF*(Z(291)*Z(293)+Z(309)*Z(302)) + 0.5
     &D0*MRF*(2*LSH*Z(243)-2*Z(91)*Z(11)*Z(243)-2*Z(91)*Z(12)*Z(235)-LRF
     &FO*Z(567)*Z(243)-LRFFO*Z(569)*Z(235))
      RKTQ = Z(1293) + Z(1240)*U3p + Z(1241)*U1p + Z(1242)*U2p
      Z(1248) = Z(1185) + Z(1189) + Z(1191) + Z(997)*Z(436) + MFF*(Z(288
     &)*Z(499)+Z(298)*Z(500)) + MHAT*(Z(320)*Z(507)+Z(325)*Z(505)) + MLL
     &A*(Z(400)*Z(539)+Z(407)*Z(540)) + MLUA*(Z(380)*Z(530)+Z(385)*Z(531
     &)) + MRLA*(Z(355)*Z(522)+Z(362)*Z(523)) + MRUA*(Z(335)*Z(513)+Z(34
     &0)*Z(514)) + MSH*(Z(178)*Z(455)+Z(188)*Z(456)) + MSH*(Z(233)*Z(480
     &)+Z(241)*Z(481)) + MTH*(Z(194)*Z(463)+Z(199)*Z(464)) + MTH*(Z(214)
     &*Z(471)+Z(219)*Z(472)) + 0.25D0*MRF*(LRFFO*Z(442)+LRFO*Z(441)+Z(12
     &18)*Z(441)+Z(1219)*Z(442)+4*LFF*Z(439)+2*LFF*Z(564)*Z(442)+2*LRFFO
     &*Z(564)*Z(439)+Z(1220)*Z(444)+2*LFF*Z(18)*Z(444)-2*LFF*Z(17)*Z(441
     &)-2*LRFO*Z(17)*Z(439)-Z(1221)*Z(445)-2*LFF*Z(566)*Z(445)-2*LRFFO*Z
     &(565)*Z(440)-2*LRFO*Z(18)*Z(440)) - 0.5D0*MRF*(Z(233)*Z(569)*Z(486
     &)+Z(241)*Z(567)*Z(486)+2*Z(11)*Z(241)*Z(485)+2*Z(12)*Z(233)*Z(485)
     &+2*Z(12)*Z(241)*Z(488)-2*Z(233)*Z(483)-2*Z(241)*Z(484)-2*Z(11)*Z(2
     &33)*Z(488)-Z(233)*Z(567)*Z(489)-Z(241)*Z(568)*Z(489))
      Z(1294) = Z(1166)*Z(42) + LFF*(LRX2*Z(41)+LRY2*Z(42)) + 0.5D0*Z(54
     &7)*(LRFFO*Z(49)+LRFO*Z(53)+2*LFF*Z(42)) + Z(1248) - Z(265)*RRX2*Z(
     &64) - Z(265)*RRY2*Z(65) - Z(275)*RRX2*Z(66) - Z(275)*RRY2*Z(67) - 
     &Z(288)*RRX1*Z(72) - Z(288)*RRY1*Z(73) - Z(298)*RRX1*Z(74) - Z(298)
     &*RRY1*Z(75) - Z(544)*(Z(320)*Z(2)+Z(325)*Z(1)) - Z(545)*(Z(288)*Z(
     &73)+Z(298)*Z(75)) - Z(546)*(Z(400)*Z(87)+Z(407)*Z(89)) - Z(547)*(Z
     &(233)*Z(61)+Z(241)*Z(63)) - Z(548)*(Z(178)*Z(36)+Z(188)*Z(38)) - Z
     &(548)*(Z(233)*Z(61)+Z(241)*Z(63)) - Z(549)*(Z(194)*Z(55)+Z(199)*Z(
     &54)) - Z(549)*(Z(214)*Z(58)+Z(219)*Z(57)) - Z(550)*(Z(380)*Z(84)+Z
     &(385)*Z(83)) - Z(551)*(Z(355)*Z(80)+Z(362)*Z(82)) - Z(552)*(Z(335)
     &*Z(77)+Z(340)*Z(76))
      Z(1245) = Z(1244) + MFF*(Z(288)*Z(289)+Z(298)*Z(307)) + MHAT*(Z(31
     &9)*Z(320)+Z(325)*Z(330)) + MLLA*(Z(398)*Z(400)+Z(407)*Z(416)) + ML
     &UA*(Z(378)*Z(380)+Z(385)*Z(392)) + MRLA*(Z(353)*Z(355)+Z(362)*Z(37
     &1)) + MRUA*(Z(333)*Z(335)+Z(340)*Z(347)) + MSH*(Z(178)**2+Z(188)**
     &2) + MSH*(Z(231)*Z(233)+Z(241)*Z(248)) + MTH*(Z(194)**2+Z(199)*Z(2
     &04)) + MTH*(Z(213)*Z(214)+Z(219)*Z(225)) + 0.25D0*MRF*(Z(1212)+4*Z
     &(1213)*Z(564)-4*Z(1214)*Z(17)) + 0.5D0*MRF*(2*Z(231)*Z(233)+2*Z(24
     &1)*Z(252)-2*Z(91)*Z(11)*Z(241)-2*Z(91)*Z(12)*Z(233)-LRFFO*Z(233)*Z
     &(569)-LRFFO*Z(241)*Z(567))
      Z(1246) = MFF*(Z(288)*Z(292)+Z(298)*Z(301)) + MHAT*(Z(320)*Z(321)+
     &Z(325)*Z(327)) + MLLA*(Z(400)*Z(401)+Z(407)*Z(410)) + MLUA*(Z(380)
     &*Z(381)+Z(385)*Z(388)) + MRF*(Z(233)*Z(234)+Z(241)*Z(242)) + MRLA*
     &(Z(355)*Z(356)+Z(362)*Z(365)) + MRUA*(Z(335)*Z(336)+Z(340)*Z(343))
     & + MSH*(Z(178)*Z(179)+Z(188)*Z(183)) + MSH*(Z(233)*Z(234)+Z(241)*Z
     &(242)) + MTH*(Z(194)*Z(195)+Z(199)*Z(200)) + MTH*(Z(214)*Z(215)+Z(
     &219)*Z(221)) + 0.5D0*MRF*(LRFO*Z(17)*Z(41)-2*LFF*Z(41)-LRFFO*Z(564
     &)*Z(41)-LRFFO*Z(565)*Z(39)-LRFO*Z(18)*Z(39)) - Z(997)*Z(41)
      Z(1247) = MFF*(Z(288)*Z(293)+Z(298)*Z(302)) + MHAT*(Z(320)*Z(322)+
     &Z(325)*Z(328)) + MLLA*(Z(400)*Z(402)+Z(407)*Z(411)) + MLUA*(Z(380)
     &*Z(382)+Z(385)*Z(389)) + MRF*(Z(233)*Z(235)+Z(241)*Z(243)) + MRLA*
     &(Z(355)*Z(357)+Z(362)*Z(366)) + MRUA*(Z(335)*Z(337)+Z(340)*Z(344))
     & + MSH*(Z(178)*Z(180)+Z(188)*Z(184)) + MSH*(Z(233)*Z(235)+Z(241)*Z
     &(243)) + MTH*(Z(194)*Z(196)+Z(199)*Z(201)) + MTH*(Z(214)*Z(216)+Z(
     &219)*Z(222)) + 0.5D0*MRF*(LRFO*Z(17)*Z(42)-2*LFF*Z(42)-LRFFO*Z(564
     &)*Z(42)-LRFFO*Z(565)*Z(40)-LRFO*Z(18)*Z(40)) - Z(997)*Z(42)
      LKTQ = Z(1294) + Z(1245)*U3p + Z(1246)*U1p + Z(1247)*U2p
      Z(1254) = Z(1196) + Z(1199) + MFF*(Z(285)*Z(499)+Z(310)*Z(500)) + 
     &0.25D0*MRF*(LRFFO*Z(486)+4*Z(91)*Z(485)+2*Z(1223)*Z(489)-2*Z(1218)
     &*Z(485)-2*Z(1222)*Z(486)-2*Z(1220)*Z(488)-4*Z(91)*Z(11)*Z(484)-4*Z
     &(91)*Z(12)*Z(483)-2*LRFFO*Z(567)*Z(484)-2*LRFFO*Z(569)*Z(483))
      Z(1295) = 0.5D0*Z(547)*(LRFFO*Z(71)-2*Z(91)*Z(67)) + Z(1254) - Z(2
     &85)*RRX1*Z(72) - Z(285)*RRY1*Z(73) - Z(316)*RRX1*Z(74) - Z(316)*RR
     &Y1*Z(75) - LRF*(RRX2*Z(66)+RRY2*Z(67)) - Z(545)*(Z(285)*Z(73)+Z(31
     &0)*Z(75))
      Z(1251) = Z(1249) + MFF*(Z(285)*Z(289)+Z(307)*Z(310)) + 0.25D0*MRF
     &*(Z(1250)-4*Z(91)*Z(11)*Z(252)-4*Z(91)*Z(12)*Z(231)-2*LRFFO*Z(231)
     &*Z(569)-2*LRFFO*Z(252)*Z(567))
      Z(1252) = MFF*(Z(285)*Z(292)+Z(310)*Z(301)) - 0.5D0*MRF*(LRFFO*Z(5
     &67)*Z(242)+LRFFO*Z(569)*Z(234)+2*Z(91)*Z(11)*Z(242)+2*Z(91)*Z(12)*
     &Z(234))
      Z(1253) = MFF*(Z(285)*Z(293)+Z(310)*Z(302)) - 0.5D0*MRF*(LRFFO*Z(5
     &67)*Z(243)+LRFFO*Z(569)*Z(235)+2*Z(91)*Z(11)*Z(243)+2*Z(91)*Z(12)*
     &Z(235))
      RATQ = Z(1295) + Z(1251)*U3p + Z(1252)*U1p + Z(1253)*U2p
      Z(1259) = Z(1185) + Z(1189) + Z(997)*Z(436) + MFF*(Z(286)*Z(499)+Z
     &(296)*Z(500)) + MHAT*(Z(318)*Z(507)+Z(324)*Z(505)) + MLLA*(Z(397)*
     &Z(539)+Z(406)*Z(540)) + MLUA*(Z(377)*Z(530)+Z(384)*Z(531)) + MRLA*
     &(Z(352)*Z(522)+Z(361)*Z(523)) + MRUA*(Z(332)*Z(513)+Z(339)*Z(514))
     & + MSH*(Z(178)*Z(455)+Z(182)*Z(456)) + MSH*(Z(230)*Z(480)+Z(238)*Z
     &(481)) + MTH*(Z(193)*Z(463)+Z(198)*Z(464)) + MTH*(Z(212)*Z(471)+Z(
     &218)*Z(472)) + 0.25D0*MRF*(LRFFO*Z(442)+LRFO*Z(441)+Z(1218)*Z(441)
     &+Z(1219)*Z(442)+4*LFF*Z(439)+2*LFF*Z(564)*Z(442)+2*LRFFO*Z(564)*Z(
     &439)+Z(1220)*Z(444)+2*LFF*Z(18)*Z(444)-2*LFF*Z(17)*Z(441)-2*LRFO*Z
     &(17)*Z(439)-Z(1221)*Z(445)-2*LFF*Z(566)*Z(445)-2*LRFFO*Z(565)*Z(44
     &0)-2*LRFO*Z(18)*Z(440)) - 0.5D0*MRF*(Z(230)*Z(569)*Z(486)+Z(238)*Z
     &(567)*Z(486)+2*Z(11)*Z(238)*Z(485)+2*Z(12)*Z(230)*Z(485)+2*Z(12)*Z
     &(238)*Z(488)-2*Z(230)*Z(483)-2*Z(238)*Z(484)-2*Z(11)*Z(230)*Z(488)
     &-Z(230)*Z(567)*Z(489)-Z(238)*Z(568)*Z(489))
      Z(1296) = Z(1166)*Z(42) + LFF*(LRX2*Z(41)+LRY2*Z(42)) + 0.5D0*Z(54
     &7)*(LRFFO*Z(49)+LRFO*Z(53)+2*LFF*Z(42)) + Z(1259) - Z(263)*RRX2*Z(
     &64) - Z(263)*RRY2*Z(65) - Z(272)*RRX2*Z(66) - Z(272)*RRY2*Z(67) - 
     &Z(286)*RRX1*Z(72) - Z(286)*RRY1*Z(73) - Z(296)*RRX1*Z(74) - Z(296)
     &*RRY1*Z(75) - Z(544)*(Z(318)*Z(2)+Z(324)*Z(1)) - Z(545)*(Z(286)*Z(
     &73)+Z(296)*Z(75)) - Z(546)*(Z(397)*Z(87)+Z(406)*Z(89)) - Z(547)*(Z
     &(230)*Z(61)+Z(238)*Z(63)) - Z(548)*(Z(178)*Z(36)+Z(182)*Z(38)) - Z
     &(548)*(Z(230)*Z(61)+Z(238)*Z(63)) - Z(549)*(Z(193)*Z(55)+Z(198)*Z(
     &54)) - Z(549)*(Z(212)*Z(58)+Z(218)*Z(57)) - Z(550)*(Z(377)*Z(84)+Z
     &(384)*Z(83)) - Z(551)*(Z(352)*Z(80)+Z(361)*Z(82)) - Z(552)*(Z(332)
     &*Z(77)+Z(339)*Z(76))
      Z(1256) = Z(1255) + MFF*(Z(286)*Z(289)+Z(296)*Z(307)) + MHAT*(Z(31
     &8)*Z(319)+Z(324)*Z(330)) + MLLA*(Z(397)*Z(398)+Z(406)*Z(416)) + ML
     &UA*(Z(377)*Z(378)+Z(384)*Z(392)) + MRLA*(Z(352)*Z(353)+Z(361)*Z(37
     &1)) + MRUA*(Z(332)*Z(333)+Z(339)*Z(347)) + MSH*(Z(178)**2+Z(182)*Z
     &(188)) + MSH*(Z(230)*Z(231)+Z(238)*Z(248)) + MTH*(Z(193)*Z(194)+Z(
     &198)*Z(204)) + MTH*(Z(212)*Z(213)+Z(218)*Z(225)) + 0.25D0*MRF*(Z(1
     &212)+4*Z(1213)*Z(564)-4*Z(1214)*Z(17)) + 0.5D0*MRF*(2*Z(230)*Z(231
     &)+2*Z(238)*Z(252)-2*Z(91)*Z(11)*Z(238)-2*Z(91)*Z(12)*Z(230)-LRFFO*
     &Z(230)*Z(569)-LRFFO*Z(238)*Z(567))
      Z(1257) = MFF*(Z(286)*Z(292)+Z(296)*Z(301)) + MHAT*(Z(318)*Z(321)+
     &Z(324)*Z(327)) + MLLA*(Z(397)*Z(401)+Z(406)*Z(410)) + MLUA*(Z(377)
     &*Z(381)+Z(384)*Z(388)) + MRF*(Z(230)*Z(234)+Z(238)*Z(242)) + MRLA*
     &(Z(352)*Z(356)+Z(361)*Z(365)) + MRUA*(Z(332)*Z(336)+Z(339)*Z(343))
     & + MSH*(Z(178)*Z(179)+Z(182)*Z(183)) + MSH*(Z(230)*Z(234)+Z(238)*Z
     &(242)) + MTH*(Z(193)*Z(195)+Z(198)*Z(200)) + MTH*(Z(212)*Z(215)+Z(
     &218)*Z(221)) + 0.5D0*MRF*(LRFO*Z(17)*Z(41)-2*LFF*Z(41)-LRFFO*Z(564
     &)*Z(41)-LRFFO*Z(565)*Z(39)-LRFO*Z(18)*Z(39)) - Z(997)*Z(41)
      Z(1258) = MFF*(Z(286)*Z(293)+Z(296)*Z(302)) + MHAT*(Z(318)*Z(322)+
     &Z(324)*Z(328)) + MLLA*(Z(397)*Z(402)+Z(406)*Z(411)) + MLUA*(Z(377)
     &*Z(382)+Z(384)*Z(389)) + MRF*(Z(230)*Z(235)+Z(238)*Z(243)) + MRLA*
     &(Z(352)*Z(357)+Z(361)*Z(366)) + MRUA*(Z(332)*Z(337)+Z(339)*Z(344))
     & + MSH*(Z(178)*Z(180)+Z(182)*Z(184)) + MSH*(Z(230)*Z(235)+Z(238)*Z
     &(243)) + MTH*(Z(193)*Z(196)+Z(198)*Z(201)) + MTH*(Z(212)*Z(216)+Z(
     &218)*Z(222)) + 0.5D0*MRF*(LRFO*Z(17)*Z(42)-2*LFF*Z(42)-LRFFO*Z(564
     &)*Z(42)-LRFFO*Z(565)*Z(40)-LRFO*Z(18)*Z(40)) - Z(997)*Z(42)
      LATQ = Z(1296) + Z(1256)*U3p + Z(1257)*U1p + Z(1258)*U2p
      Z(1264) = Z(1198) + Z(1203) + Z(1156)*Z(514) + MRLA*(Z(358)*Z(522)
     &+Z(370)*Z(523))
      Z(1297) = Z(1264) - Z(1176)*Z(76) - Z(551)*(Z(358)*Z(80)+Z(370)*Z(
     &82))
      Z(1261) = Z(1260) + Z(1156)*Z(347) + MRLA*(Z(353)*Z(358)+Z(370)*Z(
     &371))
      Z(1262) = Z(1156)*Z(343) + MRLA*(Z(358)*Z(356)+Z(370)*Z(365))
      Z(1263) = Z(1156)*Z(344) + MRLA*(Z(358)*Z(357)+Z(370)*Z(366))
      RSTQ = Z(1297) + Z(1261)*U3p + Z(1262)*U1p + Z(1263)*U2p
      Z(1269) = Z(1187) + Z(1195) + Z(1053)*Z(531) + MLLA*(Z(403)*Z(539)
     &+Z(415)*Z(540))
      Z(1298) = Z(1269) - Z(1178)*Z(83) - Z(546)*(Z(403)*Z(87)+Z(415)*Z(
     &89))
      Z(1266) = Z(1265) + Z(1053)*Z(392) + MLLA*(Z(398)*Z(403)+Z(415)*Z(
     &416))
      Z(1267) = Z(1053)*Z(388) + MLLA*(Z(403)*Z(401)+Z(415)*Z(410))
      Z(1268) = Z(1053)*Z(389) + MLLA*(Z(403)*Z(402)+Z(415)*Z(411))
      LSTQ = Z(1298) + Z(1266)*U3p + Z(1267)*U1p + Z(1268)*U2p
      Z(1270) = IRLA + Z(1089)*Z(371)
      Z(1271) = Z(1089)*Z(365)
      Z(1272) = Z(1089)*Z(366)
      Z(1181) = Z(1180)*Z(82)
      Z(1273) = Z(1198) + Z(1089)*Z(523)
      Z(1289) = Z(1181) - Z(1273)
      RETQ = Z(1270)*U3p + Z(1271)*U1p + Z(1272)*U2p - Z(1289)
      Z(1274) = ILLA + Z(1007)*Z(416)
      Z(1275) = Z(1007)*Z(410)
      Z(1276) = Z(1007)*Z(411)
      Z(1183) = Z(1182)*Z(89)
      Z(1277) = Z(1187) + Z(1007)*Z(540)
      Z(1290) = Z(1183) - Z(1277)
      LETQ = Z(1274)*U3p + Z(1275)*U1p + Z(1276)*U2p - Z(1290)
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
      POCMX = Q1 + Z(95)*Z(1) + Z(97)*Z(86) + Z(102)*Z(83) + Z(103)*Z(72
     &) + Z(104)*Z(79) + Z(105)*Z(64) + Z(106)*Z(60) + Z(107)*Z(57) + Z(
     &108)*Z(76) - Z(96)*Z(39) - Z(100)*Z(35) - Z(101)*Z(54) - 0.5D0*Z(9
     &8)*Z(50) - 0.5D0*Z(99)*Z(46) - 0.5D0*Z(99)*Z(68)
      POCMY = Q2 + Z(95)*Z(2) + Z(97)*Z(87) + Z(102)*Z(84) + Z(103)*Z(73
     &) + Z(104)*Z(80) + Z(105)*Z(65) + Z(106)*Z(61) + Z(107)*Z(58) + Z(
     &108)*Z(77) - Z(96)*Z(40) - Z(100)*Z(36) - Z(101)*Z(55) - 0.5D0*Z(9
     &8)*Z(51) - 0.5D0*Z(99)*Z(47) - 0.5D0*Z(99)*Z(69)
      Z(422) = Z(96)*(LKp-LAp-LHp-LMTPp)
      Z(423) = Z(97)*(LEp+LSp)
      Z(424) = Z(98)*(LAp+LHp-LKp)
      Z(425) = Z(99)*(LAp+LHp-LKp)
      Z(426) = Z(100)*(LHp-LKp)
      Z(427) = Z(101)*LHp
      Z(428) = Z(102)*LSp
      Z(429) = Z(103)*(RKp-RAp-RHp-RMTPp)
      Z(430) = Z(104)*(REp+RSp)
      Z(431) = Z(105)*(RAp+RHp-RKp)
      Z(432) = Z(99)*(RAp+RHp-RKp)
      Z(433) = Z(106)*(RHp-RKp)
      Z(434) = Z(107)*RHp
      Z(435) = Z(108)*RSp
      VOCMX = U1 + Z(78)*(Z(435)+Z(108)*U10+Z(108)*U3) + Z(85)*(Z(428)+Z
     &(102)*U11+Z(102)*U3) + Z(56)*(Z(427)-Z(101)*U3-Z(101)*U5) + Z(81)*
     &(Z(430)+Z(104)*U10+Z(104)*U12+Z(104)*U3) + Z(88)*(Z(423)+Z(97)*U11
     &+Z(97)*U13+Z(97)*U3) + Z(74)*(Z(429)+Z(103)*U3+Z(103)*U4+Z(103)*U6
     &+Z(103)*U8) + Z(37)*(Z(426)-Z(100)*U3-Z(100)*U5-Z(100)*U7) + 0.5D0
     &*Z(48)*(Z(425)-Z(99)*U3-Z(99)*U5-Z(99)*U7-Z(99)*U9) + 0.5D0*Z(52)*
     &(Z(424)-Z(98)*U3-Z(98)*U5-Z(98)*U7-Z(98)*U9) + 0.5D0*Z(70)*(Z(432)
     &-Z(99)*U3-Z(99)*U4-Z(99)*U6-Z(99)*U8) - Z(95)*Z(2)*U3 - Z(59)*(Z(4
     &34)-Z(107)*U3-Z(107)*U4) - Z(41)*(Z(422)+Z(96)*U3+Z(96)*U5+Z(96)*U
     &7+Z(96)*U9) - Z(62)*(Z(433)-Z(106)*U3-Z(106)*U4-Z(106)*U6) - Z(66)
     &*(Z(431)-Z(105)*U3-Z(105)*U4-Z(105)*U6-Z(105)*U8)
      VOCMY = U2 + Z(95)*Z(1)*U3 + Z(76)*(Z(435)+Z(108)*U10+Z(108)*U3) +
     & Z(83)*(Z(428)+Z(102)*U11+Z(102)*U3) + Z(54)*(Z(427)-Z(101)*U3-Z(1
     &01)*U5) + Z(82)*(Z(430)+Z(104)*U10+Z(104)*U12+Z(104)*U3) + Z(89)*(
     &Z(423)+Z(97)*U11+Z(97)*U13+Z(97)*U3) + Z(75)*(Z(429)+Z(103)*U3+Z(1
     &03)*U4+Z(103)*U6+Z(103)*U8) + Z(38)*(Z(426)-Z(100)*U3-Z(100)*U5-Z(
     &100)*U7) + 0.5D0*Z(49)*(Z(425)-Z(99)*U3-Z(99)*U5-Z(99)*U7-Z(99)*U9
     &) + 0.5D0*Z(53)*(Z(424)-Z(98)*U3-Z(98)*U5-Z(98)*U7-Z(98)*U9) + 0.5
     &D0*Z(71)*(Z(432)-Z(99)*U3-Z(99)*U4-Z(99)*U6-Z(99)*U8) - Z(57)*(Z(4
     &34)-Z(107)*U3-Z(107)*U4) - Z(42)*(Z(422)+Z(96)*U3+Z(96)*U5+Z(96)*U
     &7+Z(96)*U9) - Z(63)*(Z(433)-Z(106)*U3-Z(106)*U4-Z(106)*U6) - Z(67)
     &*(Z(431)-Z(105)*U3-Z(105)*U4-Z(105)*U6-Z(105)*U8)
      RMTQ = MTPK*(3.141592653589793D0-RMTP) - MTPB*RMTPp
      LMTQ = MTPK*(3.141592653589793D0-LMTP) - MTPB*LMTPp
      RRX = RRX1 + RRX2
      RRY = RRY1 + RRY2
      LRX = LRX1 + LRX2
      LRY = LRY1 + LRY2

C**   Write output to screen and to output file(s)
      WRITE(*, 6020) T,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,P
     &OP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,POP10X,
     &POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP13X,POP13Y,POP14X,POP14Y,POP
     &15X,POP15Y,POP16X,POP16Y,POCMX,POCMY,VOCMX,VOCMY
      WRITE(21,6020) T,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,POP4X,POP4Y,P
     &OP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,POP9Y,POP10X,
     &POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP13X,POP13Y,POP14X,POP14Y,POP
     &15X,POP15Y,POP16X,POP16Y,POCMX,POCMY,VOCMX,VOCMY
      WRITE(22,6020) T,Q1,Q2,Q3,U1,U2,U3
      WRITE(23,6020) T,RRX,RRY,LRX,LRY,RRX1,RRY1,RRX2,RRY2,LRX1,LRX2,LRY
     &1,LRY2
      WRITE(24,6020) T,RHTQ,LHTQ,RKTQ,LKTQ,RATQ,LATQ,RMTQ,LMTQ,RSTQ,LSTQ
     &,RETQ,LETQ
      WRITE(25,6020) T,RH,LH,RK,LK,RA,LA,RMTP,LMTP,RS,LS,RE,LE,RHp,LHp,R
     &Kp,LKp,RAp,LAp,RMTPp,LMTPp,RSp,LSp,REp,LEp,RHpp,LHpp,RKpp,LKpp,RAp
     &p,LApp,RMTPpp,LMTPpp,RSpp,LSpp,REpp,LEpp
      WRITE(26,6020) T,KECM,HZ,PX,PY

6020  FORMAT( 99(1X, 1PE14.6E3) )

      RETURN
      END


