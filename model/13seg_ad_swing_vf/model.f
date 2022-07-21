C**   The name of this program is model/13seg_ad_swing_vf/mode
     &l.f
C**   Created by AUTOLEV 3.2 on Fri Jul 08 21:20:48 2022

      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          ILOOP, IPRINT, PRINTINT
      CHARACTER        MESSAGE(99)
      EXTERNAL         EQNS1
      DIMENSION        VAR(6)
      COMMON/CONSTNTS/ FOOTANG,G,IFF,IHAT,ILA,IRF,ISH,ITH,IUA,K1,K2,K3,K
     &4,K5,K6,K7,K8,LFF,LFFO,LHAT,LHATO,LLA,LLAO,LMTPXI,LRF,LRFF,LRFFO,L
     &RFO,LSH,LSHO,LTH,LTHO,LTOEXI,LUA,LUAO,MFF,MHAT,MLA,MRF,MSH,MTH,MTP
     &B,MTPK,MUA,RMTPXI,RTOEXI
      COMMON/SPECFIED/ LA,LE,LH,LK,LMTP,LS,RA,RE,RH,RK,RMTP,RS,LAp,LEp,L
     &Hp,LKp,LMTPp,LSp,RAp,REp,RHp,RKp,RMTPp,RSp,LApp,LEpp,LHpp,LKpp,LMT
     &Ppp,LSpp,RApp,REpp,RHpp,RKpp,RMTPpp,RSpp
      COMMON/VARIBLES/ Q1,Q2,Q3,U1,U2,U3
      COMMON/ALGBRAIC/ HZ,KECM,LATQ,LETQ,LHTQ,LKTQ,LSTQ,PX,PY,RATQ,RETQ,
     &RHTQ,RKTQ,RSTQ,RX1,RX2,RY1,RY2,U10,U11,U12,U13,U4,U5,U6,U7,U8,U9,V
     &RX1,VRX2,VRY1,VRY2,Q1p,Q2p,Q3p,U1p,U2p,U3p,DLX1,DLX2,DRX1,DRX2,LMT
     &Q,POCMX,POCMY,POP10X,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP13X,POP
     &13Y,POP14X,POP14Y,POP15X,POP15Y,POP16X,POP16Y,POP1X,POP1Y,POP2X,PO
     &P2Y,POP3X,POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,PO
     &P8X,POP8Y,POP9X,POP9Y,RMTQ,RX,RY,VOCMX,VOCMY,VOP10X,VOP10Y,VOP11X,
     &VOP11Y,VOP2X,VOP2Y,VRX,VRY
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(1287),COEF(3,3),RHS(3)

C**   Open input and output files
      OPEN(UNIT=20, FILE='model/13seg_ad_swing_vf/model.in', STATUS='OLD
     &')
      OPEN(UNIT=21, FILE='model/13seg_ad_swing_vf/model.1',  STATUS='UNK
     &NOWN')
      OPEN(UNIT=22, FILE='model/13seg_ad_swing_vf/model.2',  STATUS='UNK
     &NOWN')
      OPEN(UNIT=23, FILE='model/13seg_ad_swing_vf/model.3',  STATUS='UNK
     &NOWN')
      OPEN(UNIT=24, FILE='model/13seg_ad_swing_vf/model.4',  STATUS='UNK
     &NOWN')
      OPEN(UNIT=25, FILE='model/13seg_ad_swing_vf/model.5',  STATUS='UNK
     &NOWN')
      OPEN(UNIT=26, FILE='model/13seg_ad_swing_vf/model.6',  STATUS='UNK
     &NOWN')

C**   Read message from input file
      READ(20,7000,END=7100,ERR=7101) (MESSAGE(ILOOP),ILOOP = 1,99)

C**   Read values of constants from input file
      READ(20,7010,END=7100,ERR=7101) FOOTANG,G,IFF,IHAT,ILA,IRF,ISH,ITH
     &,IUA,K1,K2,K3,K4,K5,K6,K7,K8,LFF,LFFO,LHAT,LHATO,LLA,LLAO,LMTPXI,L
     &RF,LRFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,LTOEXI,LUA,LUAO,MFF,MHAT,MLA,
     &MRF,MSH,MTH,MTPB,MTPK,MUA,RMTPXI,RTOEXI

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
      Z(546) = G*MSH
      Z(543) = G*MFF
      Z(1159) = LFFO*Z(543)
      Z(545) = G*MRF
      Z(27) = COS(FOOTANG)
      Z(544) = G*MLA
      Z(1002) = LLAO*MLA
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
      Z(542) = G*MHAT
      Z(547) = G*MTH
      Z(548) = G*MUA
      Z(578) = LSH - Z(100)
      Z(579) = LTH - Z(101)
      Z(580) = LFF - Z(96)
      Z(581) = 2*LRF - Z(98)
      Z(674) = LHAT - Z(95)
      Z(675) = LUA - Z(102)
      Z(680) = Z(96) - LFF
      Z(681) = 0.5D0*Z(98) - 0.5D0*LRFO
      Z(682) = 0.5D0*Z(99) - 0.5D0*LRFFO
      Z(872) = LSH - Z(105)
      Z(873) = LTH - Z(106)
      Z(874) = LRF - Z(104)
      Z(899) = 0.5D0*Z(98) - LRF
      Z(900) = Z(100) - LSH
      Z(901) = Z(101) - LTH
      Z(902) = LRF - 0.5D0*LRFO - Z(104)
      Z(949) = 2*Z(681) + 2*Z(27)*Z(682)
      Z(951) = 2*Z(682) + 2*Z(27)*Z(681)
      Z(963) = Z(27)*Z(682)
      Z(965) = Z(27)*Z(902)
      Z(992) = LFFO*MFF
      Z(1015) = LFF*MRF
      Z(1017) = LRFO*MRF
      Z(1019) = LRFFO*MRF
      Z(1048) = LUAO*MUA
      Z(1092) = MRF*Z(91)
      Z(1103) = LSH*MRF
      Z(1120) = MSH*Z(92)
      Z(1135) = MTH*Z(93)
      Z(1161) = Z(93)*Z(547)
      Z(1164) = Z(92)*Z(546)
      Z(1169) = LUAO*Z(548)
      Z(1172) = LLAO*Z(544)
      Z(1200) = IHAT + 2*IFF + 2*ILA + 2*IRF + 2*ISH + 2*ITH + 2*IUA + M
     &FF*LFFO**2
      Z(1201) = LRFFO**2 + LRFO**2 + 4*LFF**2 + 2*LRFFO*LRFO*Z(27)
      Z(1202) = LFF*LRFFO
      Z(1203) = LFF*LRFO
      Z(1204) = LRFFO**2 + 4*Z(91)**2
      Z(1205) = LRFFO*Z(27)*Z(91)
      Z(1207) = LRFFO*Z(27)
      Z(1208) = LRFO*Z(27)
      Z(1209) = LRFFO*Z(28)
      Z(1210) = LRFO*Z(28)
      Z(1211) = Z(27)*Z(91)
      Z(1212) = Z(28)*Z(91)
      Z(1214) = IFF + IRF + ISH + ITH
      Z(1215) = LRFFO**2
      Z(1216) = Z(91)**2
      Z(1221) = IFF + IRF + ISH + ITH + MFF*LFFO**2
      Z(1226) = IFF + IRF + ISH
      Z(1227) = LSH*Z(91)
      Z(1228) = LRFFO*LSH
      Z(1233) = IFF + IRF + ISH + MFF*LFFO**2
      Z(1238) = IFF + IRF
      Z(1239) = LRFFO**2 + 4*Z(91)**2 - 4*LRFFO*Z(27)*Z(91)
      Z(1244) = IFF + IRF + MFF*LFFO**2
      Z(1249) = ILA + IUA

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

6021  FORMAT(1X,'FILE: model/13seg_ad_swing_vf/model.1 ',//1X,'*** ',99A
     &1,///,8X,'T',12X,'POP1X',10X,'POP1Y',10X,'POP2X',10X,'POP2Y',10X,'
     &POP3X',10X,'POP3Y',10X,'POP4X',10X,'POP4Y',10X,'POP5X',10X,'POP5Y'
     &,10X,'POP6X',10X,'POP6Y',10X,'POP7X',10X,'POP7Y',10X,'POP8X',10X,'
     &POP8Y',10X,'POP9X',10X,'POP9Y',9X,'POP10X',9X,'POP10Y',9X,'POP11X'
     &,9X,'POP11Y',9X,'POP12X',9X,'POP12Y',9X,'POP13X',9X,'POP13Y',9X,'P
     &OP14X',9X,'POP14Y',9X,'POP15X',9X,'POP15Y',9X,'POP16X',9X,'POP16Y'
     &,10X,'POCMX',10X,'POCMY',10X,'VOCMX',10X,'VOCMY',/,5X,'(UNITS)',8X
     &,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,
     &'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'
     &(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(
     &UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(U
     &NITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UN
     &ITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNI
     &TS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNIT
     &S)',/)
6022  FORMAT(1X,'FILE: model/13seg_ad_swing_vf/model.2 ',//1X,'*** ',99A
     &1,///,8X,'T',13X,'Q1',13X,'Q2',13X,'Q3',13X,'U1',13X,'U2',13X,'U3'
     &,/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)
     &',8X,'(UNITS)',8X,'(UNITS)',/)
6023  FORMAT(1X,'FILE: model/13seg_ad_swing_vf/model.3 ',//1X,'*** ',99A
     &1,///,8X,'T',13X,'VRX',12X,'VRY',12X,'RX',13X,'RY',12X,'VRX1',11X,
     &'VRY1',11X,'VRX2',11X,'VRY2',12X,'RX1',12X,'RX2',12X,'RY1',12X,'RY
     &2',/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNIT
     &S)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS
     &)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6024  FORMAT(1X,'FILE: model/13seg_ad_swing_vf/model.4 ',//1X,'*** ',99A
     &1,///,8X,'T',12X,'RHTQ',11X,'LHTQ',11X,'RKTQ',11X,'LKTQ',11X,'RATQ
     &',11X,'LATQ',11X,'RMTQ',11X,'LMTQ',11X,'RSTQ',11X,'LSTQ',11X,'RETQ
     &',11X,'LETQ',/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)'
     &,8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',
     &8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6025  FORMAT(1X,'FILE: model/13seg_ad_swing_vf/model.5 ',//1X,'*** ',99A
     &1,///,8X,'T',13X,'RH',13X,'LH',13X,'RK',13X,'LK',13X,'RA',13X,'LA'
     &,12X,'RMTP',11X,'LMTP',12X,'RS',13X,'LS',13X,'RE',13X,'LE',13X,'RH
     &''',12X,'LH''',12X,'RK''',12X,'LK''',12X,'RA''',12X,'LA''',11X,'RM
     &TP''',10X,'LMTP''',11X,'RS''',12X,'LS''',12X,'RE''',12X,'LE''',11X
     &,'RH''''',11X,'LH''''',11X,'RK''''',11X,'LK''''',11X,'RA''''',11X,
     &'LA''''',10X,'RMTP''''',9X,'LMTP''''',10X,'RS''''',11X,'LS''''',11
     &X,'RE''''',11X,'LE''''',/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8
     &X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X
     &,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,
     &'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'
     &(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(
     &UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(U
     &NITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UN
     &ITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6026  FORMAT(1X,'FILE: model/13seg_ad_swing_vf/model.6 ',//1X,'*** ',99A
     &1,///,8X,'T',12X,'KECM',12X,'HZ',13X,'PX',13X,'PY',/,5X,'(UNITS)',
     &8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6997  FORMAT(/7X,'Error: Numerical integration failed to converge',/)
6999  FORMAT(//1X,'Input is in the file model/13seg_ad_swing_vf/model.in
     &',//1X,'Output is in the file(s) model/13seg_ad_swing_vf/model.i  
     &(i=1, ..., 6)',//1X,'The output quantities and associated files ar
     &e listed in file model/13seg_ad_swing_vf/model.dir',/)
7000  FORMAT(//,99A1,///)
7010  FORMAT( 1000(59X,E30.0,/) )
7011  FORMAT( 3(59X,E30.0,/), 1(59X,I30,/), 2(59X,E30.0,/) )
      STOP
7100  WRITE(*,*) 'Premature end of file while reading model/13seg_ad_swi
     &ng_vf/model.in '
7101  WRITE(*,*) 'Error while reading file model/13seg_ad_swing_vf/model
     &.in'
      STOP
      END


C**********************************************************************
      SUBROUTINE       EQNS1(T, VAR, VARp, BOUNDARY)
      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          BOUNDARY
      DIMENSION        VAR(*), VARp(*)
      COMMON/CONSTNTS/ FOOTANG,G,IFF,IHAT,ILA,IRF,ISH,ITH,IUA,K1,K2,K3,K
     &4,K5,K6,K7,K8,LFF,LFFO,LHAT,LHATO,LLA,LLAO,LMTPXI,LRF,LRFF,LRFFO,L
     &RFO,LSH,LSHO,LTH,LTHO,LTOEXI,LUA,LUAO,MFF,MHAT,MLA,MRF,MSH,MTH,MTP
     &B,MTPK,MUA,RMTPXI,RTOEXI
      COMMON/SPECFIED/ LA,LE,LH,LK,LMTP,LS,RA,RE,RH,RK,RMTP,RS,LAp,LEp,L
     &Hp,LKp,LMTPp,LSp,RAp,REp,RHp,RKp,RMTPp,RSp,LApp,LEpp,LHpp,LKpp,LMT
     &Ppp,LSpp,RApp,REpp,RHpp,RKpp,RMTPpp,RSpp
      COMMON/VARIBLES/ Q1,Q2,Q3,U1,U2,U3
      COMMON/ALGBRAIC/ HZ,KECM,LATQ,LETQ,LHTQ,LKTQ,LSTQ,PX,PY,RATQ,RETQ,
     &RHTQ,RKTQ,RSTQ,RX1,RX2,RY1,RY2,U10,U11,U12,U13,U4,U5,U6,U7,U8,U9,V
     &RX1,VRX2,VRY1,VRY2,Q1p,Q2p,Q3p,U1p,U2p,U3p,DLX1,DLX2,DRX1,DRX2,LMT
     &Q,POCMX,POCMY,POP10X,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP13X,POP
     &13Y,POP14X,POP14Y,POP15X,POP15Y,POP16X,POP16Y,POP1X,POP1Y,POP2X,PO
     &P2Y,POP3X,POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,PO
     &P8X,POP8Y,POP9X,POP9Y,RMTQ,RX,RY,VOCMX,VOCMY,VOP10X,VOP10Y,VOP11X,
     &VOP11Y,VOP2X,VOP2Y,VRX,VRY
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(1287),COEF(3,3),RHS(3)

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
      RY1 = -K3*Q2 - K4*ABS(Q2)*U2
      DLX1 = Q1 - LTOEXI
      RX1 = -RY1*(K1*DLX1+K2*U1)
      Z(1) = COS(Q3)
      Z(2) = SIN(Q3)
      Z(504) = LHATO*U3
      Z(506) = LHAT*U3

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
      Z(207) = Z(3)*Z(5) + Z(4)*Z(6)
      Z(155) = LKp - LAp - LHp - LMTPp
      Z(157) = LFF*Z(155)
      Z(168) = Z(18)*Z(157)
      Z(172) = Z(17)*Z(157)
      Z(158) = LKp - LAp - LHp
      Z(173) = LRF*Z(158)
      Z(175) = Z(172) - Z(173)
      Z(183) = Z(14)*Z(168) - Z(13)*Z(175)
      Z(184) = LKp - LHp
      Z(188) = LSH*Z(184)
      Z(190) = Z(183) - Z(188)
      Z(179) = -Z(13)*Z(168) - Z(14)*Z(175)
      Z(195) = Z(10)*Z(190) - Z(9)*Z(179)
      Z(209) = Z(3)*Z(6) - Z(4)*Z(5)
      Z(200) = -Z(9)*Z(190) - Z(10)*Z(179)
      Z(204) = LTH*LHp
      Z(206) = Z(200) + Z(204)
      Z(215) = Z(207)*Z(195) + Z(209)*Z(206)
      Z(208) = Z(4)*Z(5) - Z(3)*Z(6)
      Z(221) = Z(207)*Z(206) + Z(208)*Z(195)
      Z(225) = LTH*RHp
      Z(227) = Z(221) - Z(225)
      Z(243) = Z(8)*Z(215) - Z(7)*Z(227)
      Z(244) = RKp - RHp
      Z(249) = LSH*Z(244)
      Z(252) = Z(243) + Z(249)
      Z(235) = -Z(7)*Z(215) - Z(8)*Z(227)
      Z(277) = -Z(11)*Z(252) - Z(12)*Z(235)
      Z(253) = RKp - RAp - RHp
      Z(278) = LRF*Z(253)
      Z(282) = Z(277) + Z(278)
      Z(268) = Z(12)*Z(252) - Z(11)*Z(235)
      Z(292) = Z(16)*Z(282) - Z(15)*Z(268)
      Z(283) = LRF*Z(16)
      Z(165) = LFF*Z(18)
      Z(171) = LFF*Z(17)
      Z(174) = Z(171) - LRF
      Z(180) = Z(14)*Z(165) - Z(13)*Z(174)
      Z(176) = -Z(13)*Z(165) - Z(14)*Z(174)
      Z(191) = Z(10)*Z(180) - Z(9)*Z(176)
      Z(196) = -Z(9)*Z(180) - Z(10)*Z(176)
      Z(210) = Z(191)*Z(207) + Z(196)*Z(209)
      Z(216) = Z(191)*Z(208) + Z(196)*Z(207)
      Z(236) = Z(8)*Z(210) - Z(7)*Z(216)
      Z(228) = -Z(7)*Z(210) - Z(8)*Z(216)
      Z(270) = -Z(11)*Z(236) - Z(12)*Z(228)
      Z(261) = Z(12)*Z(236) - Z(11)*Z(228)
      Z(284) = Z(16)*Z(270) - Z(15)*Z(261)
      Z(189) = Z(180) - LSH
      Z(192) = Z(10)*Z(189) - Z(9)*Z(176)
      Z(197) = -Z(9)*Z(189) - Z(10)*Z(176)
      Z(205) = Z(197) - LTH
      Z(211) = Z(192)*Z(207) + Z(205)*Z(209)
      Z(218) = Z(192)*Z(208) + Z(205)*Z(207)
      Z(238) = Z(8)*Z(211) - Z(7)*Z(218)
      Z(230) = -Z(7)*Z(211) - Z(8)*Z(218)
      Z(272) = -Z(11)*Z(238) - Z(12)*Z(230)
      Z(262) = Z(12)*Z(238) - Z(11)*Z(230)
      Z(285) = Z(16)*Z(272) - Z(15)*Z(262)
      Z(212) = Z(192)*Z(207) + Z(197)*Z(209)
      Z(217) = Z(192)*Z(208) + Z(197)*Z(207)
      Z(239) = Z(8)*Z(212) - Z(7)*Z(217)
      Z(231) = -Z(7)*Z(212) - Z(8)*Z(217)
      Z(273) = -Z(11)*Z(239) - Z(12)*Z(231)
      Z(263) = Z(12)*Z(239) - Z(11)*Z(231)
      Z(286) = Z(16)*Z(273) - Z(15)*Z(263)
      Z(226) = LTH + Z(218)
      Z(237) = Z(8)*Z(211) - Z(7)*Z(226)
      Z(250) = LSH + Z(237)
      Z(229) = -Z(7)*Z(211) - Z(8)*Z(226)
      Z(271) = -Z(11)*Z(250) - Z(12)*Z(229)
      Z(279) = LRF + Z(271)
      Z(264) = Z(12)*Z(250) - Z(11)*Z(229)
      Z(287) = Z(16)*Z(279) - Z(15)*Z(264)
      Z(234) = LTH*Z(8)
      Z(242) = LTH*Z(7)
      Z(251) = LSH - Z(242)
      Z(269) = Z(12)*Z(234) - Z(11)*Z(251)
      Z(280) = LRF + Z(269)
      Z(265) = Z(11)*Z(234) + Z(12)*Z(251)
      Z(288) = Z(16)*Z(280) - Z(15)*Z(265)
      Z(276) = LSH*Z(11)
      Z(281) = LRF - Z(276)
      Z(260) = LSH*Z(12)
      Z(289) = Z(16)*Z(281) - Z(15)*Z(260)
      Z(35) = Z(32)*Z(1) - Z(33)*Z(2)
      Z(37) = Z(34)*Z(1) - Z(32)*Z(2)
      Z(39) = Z(29)*Z(35) + Z(30)*Z(37)
      Z(31) = Z(13)*Z(18) + Z(14)*Z(17)
      Z(41) = Z(29)*Z(37) + Z(31)*Z(35)
      Z(166) = -Z(17)*Z(39) - Z(18)*Z(41)
      Z(169) = Z(18)*Z(39) - Z(17)*Z(41)
      Z(181) = Z(14)*Z(166) - Z(13)*Z(169)
      Z(177) = -Z(13)*Z(166) - Z(14)*Z(169)
      Z(193) = Z(10)*Z(181) - Z(9)*Z(177)
      Z(198) = -Z(9)*Z(181) - Z(10)*Z(177)
      Z(213) = Z(207)*Z(193) + Z(209)*Z(198)
      Z(219) = Z(207)*Z(198) + Z(208)*Z(193)
      Z(240) = Z(8)*Z(213) - Z(7)*Z(219)
      Z(232) = -Z(7)*Z(213) - Z(8)*Z(219)
      Z(274) = -Z(11)*Z(240) - Z(12)*Z(232)
      Z(266) = Z(12)*Z(240) - Z(11)*Z(232)
      Z(290) = Z(16)*Z(274) - Z(15)*Z(266)
      Z(42) = Z(29)*Z(38) + Z(31)*Z(36)
      Z(167) = -Z(17)*Z(40) - Z(18)*Z(42)
      Z(170) = Z(18)*Z(40) - Z(17)*Z(42)
      Z(182) = Z(14)*Z(167) - Z(13)*Z(170)
      Z(178) = -Z(13)*Z(167) - Z(14)*Z(170)
      Z(194) = Z(10)*Z(182) - Z(9)*Z(178)
      Z(199) = -Z(9)*Z(182) - Z(10)*Z(178)
      Z(214) = Z(207)*Z(194) + Z(209)*Z(199)
      Z(220) = Z(207)*Z(199) + Z(208)*Z(194)
      Z(241) = Z(8)*Z(214) - Z(7)*Z(220)
      Z(233) = -Z(7)*Z(214) - Z(8)*Z(220)
      Z(275) = -Z(11)*Z(241) - Z(12)*Z(233)
      Z(267) = Z(12)*Z(241) - Z(11)*Z(233)
      Z(291) = Z(16)*Z(275) - Z(15)*Z(267)
      Z(75) = -Z(15)*Z(67) - Z(16)*Z(65)
      Z(302) = -Z(15)*Z(282) - Z(16)*Z(268)
      Z(303) = RKp - RAp - RHp - RMTPp
      Z(310) = LFF*Z(303)
      Z(315) = Z(302) + Z(310)
      Z(294) = -Z(15)*Z(270) - Z(16)*Z(261)
      Z(295) = -Z(15)*Z(272) - Z(16)*Z(262)
      Z(296) = -Z(15)*Z(273) - Z(16)*Z(263)
      Z(297) = -Z(15)*Z(279) - Z(16)*Z(264)
      Z(311) = LFF + Z(297)
      Z(298) = -Z(15)*Z(280) - Z(16)*Z(265)
      Z(312) = LFF + Z(298)
      Z(293) = -Z(15)*Z(281) - Z(16)*Z(260)
      Z(313) = LFF + Z(293)
      Z(301) = LRF*Z(15)
      Z(314) = LFF - Z(301)
      Z(299) = -Z(15)*Z(274) - Z(16)*Z(266)
      Z(300) = -Z(15)*Z(275) - Z(16)*Z(267)
      VOP11Y = Z(73)*(Z(292)+Z(283)*U8+Z(284)*U9+Z(285)*U5+Z(286)*U7+Z(2
     &87)*U3+Z(288)*U4+Z(289)*U6+Z(290)*U1+Z(291)*U2) + Z(75)*(Z(315)+Z(
     &294)*U9+Z(295)*U5+Z(296)*U7+Z(311)*U3+Z(312)*U4+Z(313)*U6+Z(314)*U
     &8+Z(299)*U1+Z(300)*U2)
      VRY1 = -K3*POP11Y - K4*ABS(POP11Y)*VOP11Y
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
      VOP11X = Z(72)*(Z(292)+Z(283)*U8+Z(284)*U9+Z(285)*U5+Z(286)*U7+Z(2
     &87)*U3+Z(288)*U4+Z(289)*U6+Z(290)*U1+Z(291)*U2) + Z(74)*(Z(315)+Z(
     &294)*U9+Z(295)*U5+Z(296)*U7+Z(311)*U3+Z(312)*U4+Z(313)*U6+Z(314)*U
     &8+Z(299)*U1+Z(300)*U2)
      VRX1 = -VRY1*(K1*DRX1+K2*VOP11X)
      POP10Y = Q2 + LRF*Z(65) + LSH*Z(61) + LTH*Z(58) - LFF*Z(40) - LRF*
     &Z(51) - LSH*Z(36) - LTH*Z(55)
      VOP10Y = Z(65)*(Z(268)+Z(260)*U6+Z(261)*U9+Z(262)*U5+Z(263)*U7+Z(2
     &64)*U3+Z(265)*U4+Z(266)*U1+Z(267)*U2) + Z(67)*(Z(282)+LRF*U8+Z(270
     &)*U9+Z(272)*U5+Z(273)*U7+Z(279)*U3+Z(280)*U4+Z(281)*U6+Z(274)*U1+Z
     &(275)*U2)
      VRY2 = -K7*POP10Y - K8*ABS(POP10Y)*VOP10Y
      POP10X = Q1 + LRF*Z(64) + LSH*Z(60) + LTH*Z(57) - LFF*Z(39) - LRF*
     &Z(50) - LSH*Z(35) - LTH*Z(54)
      DRX2 = POP10X - RMTPXI
      VOP10X = Z(64)*(Z(268)+Z(260)*U6+Z(261)*U9+Z(262)*U5+Z(263)*U7+Z(2
     &64)*U3+Z(265)*U4+Z(266)*U1+Z(267)*U2) + Z(66)*(Z(282)+LRF*U8+Z(270
     &)*U9+Z(272)*U5+Z(273)*U7+Z(279)*U3+Z(280)*U4+Z(281)*U6+Z(274)*U1+Z
     &(275)*U2)
      VRX2 = -VRY2*(K5*DRX2+K6*VOP10X)
      POP2Y = Q2 - LFF*Z(40)
      VOP2Y = Z(40)*(Z(39)*U1+Z(40)*U2) - Z(42)*(Z(157)+LFF*U3+LFF*U5+LF
     &F*U7+LFF*U9-Z(41)*U1-Z(42)*U2)
      RY2 = -K7*POP2Y - K8*ABS(POP2Y)*VOP2Y
      POP2X = Q1 - LFF*Z(39)
      DLX2 = POP2X - LMTPXI
      VOP2X = Z(39)*(Z(39)*U1+Z(40)*U2) - Z(41)*(Z(157)+LFF*U3+LFF*U5+LF
     &F*U7+LFF*U9-Z(41)*U1-Z(42)*U2)
      RX2 = -RY2*(K5*DLX2+K6*VOP2X)
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
      Z(76) = -Z(19)*Z(1) - Z(20)*Z(2)
      Z(77) = Z(20)*Z(1) - Z(19)*Z(2)
      Z(80) = -Z(23)*Z(77) - Z(24)*Z(76)
      Z(82) = Z(24)*Z(77) - Z(23)*Z(76)
      Z(83) = -Z(21)*Z(1) - Z(22)*Z(2)
      Z(84) = Z(22)*Z(1) - Z(21)*Z(2)
      Z(87) = -Z(25)*Z(84) - Z(26)*Z(83)
      Z(89) = Z(26)*Z(84) - Z(25)*Z(83)
      Z(107) = U4 - RHp
      Z(108) = U5 - LHp
      Z(110) = RKpp - RHpp
      Z(116) = LKpp - LHpp
      Z(118) = RKpp - RApp - RHpp
      Z(124) = LKpp - LApp - LHpp
      Z(130) = RKpp - RApp - RHpp - RMTPpp
      Z(136) = LKpp - LApp - LHpp - LMTPpp
      Z(141) = U10 - RSp
      Z(142) = U11 - LSp
      Z(144) = REpp - RSpp
      Z(150) = LEpp - LSpp
      Z(156) = LFFO*Z(155)
      Z(163) = LRFO*Z(158)
      Z(164) = LRFFO*Z(158)
      Z(185) = LSHO*Z(184)
      Z(186) = Z(180) - LSHO
      Z(201) = LTHO*LHp
      Z(202) = Z(197) - LTHO
      Z(222) = Z(93)*RHp
      Z(223) = Z(93) + Z(218)
      Z(245) = Z(92)*Z(244)
      Z(246) = Z(92) + Z(237)
      Z(258) = Z(91)*Z(253)
      Z(259) = LRFFO*Z(253)
      Z(304) = Z(90)*Z(303)
      Z(305) = Z(90) + Z(297)
      Z(317) = Z(5)*Z(192) + Z(6)*Z(205)
      Z(319) = Z(5)*Z(193) + Z(6)*Z(198)
      Z(320) = Z(5)*Z(194) + Z(6)*Z(199)
      Z(324) = Z(5)*Z(205) - Z(6)*Z(192)
      Z(325) = Z(5)*Z(198) - Z(6)*Z(193)
      Z(326) = Z(5)*Z(199) - Z(6)*Z(194)
      Z(328) = LHATO + Z(324)
      Z(329) = LHAT + Z(324)
      Z(333) = Z(20)*Z(329) - Z(19)*Z(317)
      Z(334) = Z(20)*Z(325) - Z(19)*Z(319)
      Z(335) = Z(20)*Z(326) - Z(19)*Z(320)
      Z(340) = -Z(19)*Z(329) - Z(20)*Z(317)
      Z(341) = -Z(19)*Z(325) - Z(20)*Z(319)
      Z(342) = -Z(19)*Z(326) - Z(20)*Z(320)
      Z(344) = LUAO*RSp
      Z(345) = LUAO + Z(340)
      Z(347) = LUA*RSp
      Z(348) = LUA + Z(340)
      Z(353) = -Z(23)*Z(333) - Z(24)*Z(348)
      Z(354) = -Z(23)*Z(334) - Z(24)*Z(341)
      Z(355) = -Z(23)*Z(335) - Z(24)*Z(342)
      Z(361) = Z(24)*Z(333) - Z(23)*Z(348)
      Z(362) = Z(24)*Z(334) - Z(23)*Z(341)
      Z(363) = Z(24)*Z(335) - Z(23)*Z(342)
      Z(366) = REp - RSp
      Z(367) = LLAO*Z(366)
      Z(369) = LLAO + Z(361)
      Z(378) = Z(22)*Z(329) - Z(21)*Z(317)
      Z(379) = Z(22)*Z(325) - Z(21)*Z(319)
      Z(380) = Z(22)*Z(326) - Z(21)*Z(320)
      Z(385) = -Z(21)*Z(329) - Z(22)*Z(317)
      Z(386) = -Z(21)*Z(325) - Z(22)*Z(319)
      Z(387) = -Z(21)*Z(326) - Z(22)*Z(320)
      Z(389) = LUAO*LSp
      Z(390) = LUAO + Z(385)
      Z(392) = LUA*LSp
      Z(393) = LUA + Z(385)
      Z(398) = -Z(25)*Z(378) - Z(26)*Z(393)
      Z(399) = -Z(25)*Z(379) - Z(26)*Z(386)
      Z(400) = -Z(25)*Z(380) - Z(26)*Z(387)
      Z(406) = Z(26)*Z(378) - Z(25)*Z(393)
      Z(407) = Z(26)*Z(379) - Z(25)*Z(386)
      Z(408) = Z(26)*Z(380) - Z(25)*Z(387)
      Z(411) = LEp - LSp
      Z(412) = LLAO*Z(411)
      Z(414) = LLAO + Z(406)
      Z(434) = LFFO*Z(136)
      Z(435) = Z(155) + U5 + U7 + U9
      Z(436) = (Z(156)+LFFO*U3+LFFO*U5+LFFO*U7+LFFO*U9)*(U3+Z(435))
      Z(437) = LFF*Z(136)
      Z(438) = (Z(157)+LFF*U3+LFF*U5+LFF*U7+LFF*U9)*(U3+Z(435))
      Z(439) = LRFO*Z(124)
      Z(440) = LRFFO*Z(124)
      Z(441) = Z(158) + U5 + U7 + U9
      Z(442) = (Z(163)+LRFO*U3+LRFO*U5+LRFO*U7+LRFO*U9)*(U3+Z(441))
      Z(443) = (Z(164)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)*(U3+Z(441))
      Z(444) = Z(18)*Z(437) - Z(17)*Z(438)
      Z(445) = Z(17)*Z(437) + Z(18)*Z(438)
      Z(446) = LRF*Z(124)
      Z(447) = Z(444) + (Z(173)+LRF*U3+LRF*U5+LRF*U7+LRF*U9)*(U3+Z(441))
      Z(448) = Z(445) - Z(446)
      Z(449) = -Z(13)*Z(447) - Z(14)*Z(448)
      Z(450) = Z(14)*Z(447) - Z(13)*Z(448)
      Z(451) = LSHO*Z(116)
      Z(452) = Z(184) + U5 + U7
      Z(453) = Z(449) + (Z(185)+LSHO*U3+LSHO*U5+LSHO*U7)*(U3+Z(452))
      Z(454) = Z(450) - Z(451)
      Z(455) = LSH*Z(116)
      Z(456) = Z(449) + (Z(188)+LSH*U3+LSH*U5+LSH*U7)*(U3+Z(452))
      Z(457) = Z(450) - Z(455)
      Z(458) = Z(10)*Z(457) - Z(9)*Z(456)
      Z(459) = -Z(9)*Z(457) - Z(10)*Z(456)
      Z(460) = LTHO*LHpp
      Z(461) = Z(458) - (Z(201)-LTHO*U3-LTHO*U5)*(U3+Z(108))
      Z(462) = Z(460) + Z(459)
      Z(463) = LTH*LHpp
      Z(464) = Z(458) - (Z(204)-LTH*U3-LTH*U5)*(U3+Z(108))
      Z(465) = Z(463) + Z(459)
      Z(466) = Z(207)*Z(464) + Z(209)*Z(465)
      Z(467) = Z(207)*Z(465) + Z(208)*Z(464)
      Z(468) = Z(93)*RHpp
      Z(469) = Z(466) + (Z(222)-Z(93)*U3-Z(93)*U4)*(U3+Z(107))
      Z(470) = Z(467) - Z(468)
      Z(471) = LTH*RHpp
      Z(472) = Z(466) + (Z(225)-LTH*U3-LTH*U4)*(U3+Z(107))
      Z(473) = Z(467) - Z(471)
      Z(474) = -Z(7)*Z(472) - Z(8)*Z(473)
      Z(475) = Z(8)*Z(472) - Z(7)*Z(473)
      Z(476) = Z(92)*Z(110)
      Z(477) = Z(244) + U4 + U6
      Z(478) = Z(474) - (Z(245)+Z(92)*U3+Z(92)*U4+Z(92)*U6)*(U3+Z(477))
      Z(479) = Z(476) + Z(475)
      Z(480) = LSH*Z(110)
      Z(481) = Z(474) - (Z(249)+LSH*U3+LSH*U4+LSH*U6)*(U3+Z(477))
      Z(482) = Z(480) + Z(475)
      Z(483) = Z(91)*Z(118)
      Z(484) = LRFFO*Z(118)
      Z(485) = Z(253) + U4 + U6 + U8
      Z(486) = (Z(258)+Z(91)*U3+Z(91)*U4+Z(91)*U6+Z(91)*U8)*(U3+Z(485))
      Z(487) = (Z(259)+LRFFO*U3+LRFFO*U4+LRFFO*U6+LRFFO*U8)*(U3+Z(485))
      Z(488) = Z(12)*Z(482) - Z(11)*Z(481)
      Z(489) = -Z(11)*Z(482) - Z(12)*Z(481)
      Z(490) = LRF*Z(118)
      Z(491) = Z(488) - (Z(278)+LRF*U3+LRF*U4+LRF*U6+LRF*U8)*(U3+Z(485))
      Z(492) = Z(490) + Z(489)
      Z(493) = Z(16)*Z(492) - Z(15)*Z(491)
      Z(494) = -Z(15)*Z(492) - Z(16)*Z(491)
      Z(495) = Z(90)*Z(130)
      Z(496) = Z(303) + U4 + U6 + U8
      Z(497) = Z(493) - (Z(304)+Z(90)*U3+Z(90)*U4+Z(90)*U6+Z(90)*U8)*(U3
     &+Z(496))
      Z(498) = Z(495) + Z(494)
      Z(502) = Z(5)*Z(464) + Z(6)*Z(465)
      Z(503) = Z(5)*Z(465) - Z(6)*Z(464)
      Z(505) = Z(502) - U3*Z(504)
      Z(507) = Z(502) - U3*Z(506)
      Z(508) = Z(20)*Z(503) - Z(19)*Z(507)
      Z(509) = -Z(19)*Z(503) - Z(20)*Z(507)
      Z(510) = LUAO*RSpp
      Z(511) = Z(508) + (Z(344)-LUAO*U10-LUAO*U3)*(U3+Z(141))
      Z(512) = Z(509) - Z(510)
      Z(513) = LUA*RSpp
      Z(514) = Z(508) + (Z(347)-LUA*U10-LUA*U3)*(U3+Z(141))
      Z(515) = Z(509) - Z(513)
      Z(516) = -Z(23)*Z(514) - Z(24)*Z(515)
      Z(517) = Z(24)*Z(514) - Z(23)*Z(515)
      Z(518) = LLAO*Z(144)
      Z(519) = Z(366) + U10 + U12
      Z(520) = Z(516) - (Z(367)+LLAO*U10+LLAO*U12+LLAO*U3)*(U3+Z(519))
      Z(521) = Z(518) + Z(517)
      Z(525) = Z(22)*Z(503) - Z(21)*Z(507)
      Z(526) = -Z(21)*Z(503) - Z(22)*Z(507)
      Z(527) = LUAO*LSpp
      Z(528) = Z(525) + (Z(389)-LUAO*U11-LUAO*U3)*(U3+Z(142))
      Z(529) = Z(526) - Z(527)
      Z(530) = LUA*LSpp
      Z(531) = Z(525) + (Z(392)-LUA*U11-LUA*U3)*(U3+Z(142))
      Z(532) = Z(526) - Z(530)
      Z(533) = -Z(25)*Z(531) - Z(26)*Z(532)
      Z(534) = Z(26)*Z(531) - Z(25)*Z(532)
      Z(535) = LLAO*Z(150)
      Z(536) = Z(411) + U11 + U13
      Z(537) = Z(533) - (Z(412)+LLAO*U11+LLAO*U13+LLAO*U3)*(U3+Z(536))
      Z(538) = Z(535) + Z(534)
      Z(560) = Z(28)*Z(18) - Z(27)*Z(17)
      Z(561) = Z(27)*Z(18) + Z(28)*Z(17)
      Z(562) = -Z(27)*Z(18) - Z(28)*Z(17)
      Z(563) = -Z(27)*Z(11) - Z(28)*Z(12)
      Z(564) = Z(27)*Z(12) - Z(28)*Z(11)
      Z(565) = Z(28)*Z(11) - Z(27)*Z(12)
      Z(1157) = RX1 + RX2*Z(39)**2 + RX2*Z(41)**2 + RY2*Z(39)*Z(40) + RY
     &2*Z(41)*Z(42) + VRX1*Z(72)*Z(290) + VRX1*Z(74)*Z(299) + VRX2*Z(64)
     &*Z(266) + VRX2*Z(66)*Z(274) + VRY1*Z(73)*Z(290) + VRY1*Z(75)*Z(299
     &) + VRY2*Z(65)*Z(266) + VRY2*Z(67)*Z(274) + Z(542)*(Z(1)*Z(325)+Z(
     &2)*Z(319)) + Z(543)*(Z(39)*Z(40)+Z(41)*Z(42)) + Z(543)*(Z(73)*Z(29
     &0)+Z(75)*Z(299)) + Z(544)*(Z(80)*Z(354)+Z(82)*Z(362)) + Z(544)*(Z(
     &87)*Z(399)+Z(89)*Z(407)) + Z(545)*(Z(39)*Z(40)+Z(41)*Z(42)) + Z(54
     &5)*(Z(61)*Z(232)+Z(63)*Z(240)) + Z(546)*(Z(36)*Z(177)+Z(38)*Z(181)
     &) + Z(546)*(Z(61)*Z(232)+Z(63)*Z(240)) + Z(547)*(Z(54)*Z(198)+Z(55
     &)*Z(193)) + Z(547)*(Z(57)*Z(219)+Z(58)*Z(213)) + Z(548)*(Z(76)*Z(3
     &41)+Z(77)*Z(334)) + Z(548)*(Z(83)*Z(386)+Z(84)*Z(379))
      Z(1158) = RY1 + RX2*Z(39)*Z(40) + RX2*Z(41)*Z(42) + RY2*Z(40)**2 +
     & RY2*Z(42)**2 + VRX1*Z(72)*Z(291) + VRX1*Z(74)*Z(300) + VRX2*Z(64)
     &*Z(267) + VRX2*Z(66)*Z(275) + VRY1*Z(73)*Z(291) + VRY1*Z(75)*Z(300
     &) + VRY2*Z(65)*Z(267) + VRY2*Z(67)*Z(275) + Z(542)*(Z(1)*Z(326)+Z(
     &2)*Z(320)) + Z(543)*(Z(40)**2+Z(42)**2) + Z(543)*(Z(73)*Z(291)+Z(7
     &5)*Z(300)) + Z(544)*(Z(80)*Z(355)+Z(82)*Z(363)) + Z(544)*(Z(87)*Z(
     &400)+Z(89)*Z(408)) + Z(545)*(Z(40)**2+Z(42)**2) + Z(545)*(Z(61)*Z(
     &233)+Z(63)*Z(241)) + Z(546)*(Z(36)*Z(178)+Z(38)*Z(182)) + Z(546)*(
     &Z(61)*Z(233)+Z(63)*Z(241)) + Z(547)*(Z(54)*Z(199)+Z(55)*Z(194)) + 
     &Z(547)*(Z(57)*Z(220)+Z(58)*Z(214)) + Z(548)*(Z(76)*Z(342)+Z(77)*Z(
     &335)) + Z(548)*(Z(83)*Z(387)+Z(84)*Z(380))
      Z(1176) = IFF*Z(136)
      Z(1178) = ILA*Z(150)
      Z(1180) = IRF*Z(124)
      Z(1182) = ISH*Z(116)
      Z(1184) = ITH*LHpp
      Z(1186) = IUA*LSpp
      Z(1187) = IFF*Z(130)
      Z(1188) = ILA*Z(144)
      Z(1189) = IRF*Z(118)
      Z(1190) = ISH*Z(110)
      Z(1191) = ITH*RHpp
      Z(1192) = IUA*RSpp
      Z(1193) = MFF*(Z(287)*Z(290)+Z(305)*Z(299)) + MHAT*(Z(317)*Z(319)+
     &Z(328)*Z(325)) + MLA*(Z(353)*Z(354)+Z(369)*Z(362)) + MLA*(Z(398)*Z
     &(399)+Z(414)*Z(407)) + MSH*(Z(176)*Z(177)+Z(186)*Z(181)) + MSH*(Z(
     &229)*Z(232)+Z(246)*Z(240)) + MTH*(Z(192)*Z(193)+Z(202)*Z(198)) + M
     &TH*(Z(211)*Z(213)+Z(223)*Z(219)) + MUA*(Z(333)*Z(334)+Z(345)*Z(341
     &)) + MUA*(Z(378)*Z(379)+Z(390)*Z(386)) + 0.5D0*MRF*(LRFO*Z(17)*Z(4
     &1)-2*LFF*Z(41)-LRFFO*Z(560)*Z(41)-LRFFO*Z(561)*Z(39)-LRFO*Z(18)*Z(
     &39)) + 0.5D0*MRF*(2*Z(229)*Z(232)+2*Z(250)*Z(240)-2*Z(91)*Z(11)*Z(
     &240)-2*Z(91)*Z(12)*Z(232)-LRFFO*Z(563)*Z(240)-LRFFO*Z(565)*Z(232))
     & - Z(992)*Z(41)
      Z(1194) = MFF*(Z(39)**2+Z(41)**2) + MFF*(Z(290)**2+Z(299)**2) + MH
     &AT*(Z(319)**2+Z(325)**2) + MLA*(Z(354)**2+Z(362)**2) + MLA*(Z(399)
     &**2+Z(407)**2) + MRF*(Z(39)**2+Z(41)**2) + MRF*(Z(232)**2+Z(240)**
     &2) + MSH*(Z(177)**2+Z(181)**2) + MSH*(Z(232)**2+Z(240)**2) + MTH*(
     &Z(193)**2+Z(198)**2) + MTH*(Z(213)**2+Z(219)**2) + MUA*(Z(334)**2+
     &Z(341)**2) + MUA*(Z(379)**2+Z(386)**2)
      Z(1195) = MFF*(Z(39)*Z(40)+Z(41)*Z(42)) + MFF*(Z(290)*Z(291)+Z(299
     &)*Z(300)) + MHAT*(Z(319)*Z(320)+Z(325)*Z(326)) + MLA*(Z(354)*Z(355
     &)+Z(362)*Z(363)) + MLA*(Z(399)*Z(400)+Z(407)*Z(408)) + MRF*(Z(39)*
     &Z(40)+Z(41)*Z(42)) + MRF*(Z(232)*Z(233)+Z(240)*Z(241)) + MSH*(Z(17
     &7)*Z(178)+Z(181)*Z(182)) + MSH*(Z(232)*Z(233)+Z(240)*Z(241)) + MTH
     &*(Z(193)*Z(194)+Z(198)*Z(199)) + MTH*(Z(213)*Z(214)+Z(219)*Z(220))
     & + MUA*(Z(334)*Z(335)+Z(341)*Z(342)) + MUA*(Z(379)*Z(380)+Z(386)*Z
     &(387))
      Z(1196) = MFF*(Z(290)*Z(497)+Z(299)*Z(498)) + MHAT*(Z(319)*Z(505)+
     &Z(325)*Z(503)) + MLA*(Z(354)*Z(520)+Z(362)*Z(521)) + MLA*(Z(399)*Z
     &(537)+Z(407)*Z(538)) + MSH*(Z(177)*Z(453)+Z(181)*Z(454)) + MSH*(Z(
     &232)*Z(478)+Z(240)*Z(479)) + MTH*(Z(193)*Z(461)+Z(198)*Z(462)) + M
     &TH*(Z(213)*Z(469)+Z(219)*Z(470)) + MUA*(Z(334)*Z(511)+Z(341)*Z(512
     &)) + MUA*(Z(379)*Z(528)+Z(386)*Z(529)) - MFF*(Z(434)*Z(41)-Z(39)*Z
     &(436)) - 0.5D0*MRF*(2*Z(437)*Z(41)+Z(18)*Z(439)*Z(39)+Z(560)*Z(440
     &)*Z(41)+Z(561)*Z(440)*Z(39)+Z(17)*Z(39)*Z(442)+Z(18)*Z(41)*Z(442)-
     &Z(17)*Z(439)*Z(41)-2*Z(39)*Z(438)-Z(560)*Z(39)*Z(443)-Z(562)*Z(41)
     &*Z(443)) - 0.5D0*MRF*(Z(563)*Z(484)*Z(240)+Z(565)*Z(484)*Z(232)+2*
     &Z(11)*Z(483)*Z(240)+2*Z(12)*Z(483)*Z(232)+2*Z(12)*Z(240)*Z(486)-2*
     &Z(232)*Z(481)-2*Z(240)*Z(482)-2*Z(11)*Z(232)*Z(486)-Z(563)*Z(232)*
     &Z(487)-Z(564)*Z(240)*Z(487))
      Z(1197) = MFF*(Z(287)*Z(291)+Z(305)*Z(300)) + MHAT*(Z(317)*Z(320)+
     &Z(328)*Z(326)) + MLA*(Z(353)*Z(355)+Z(369)*Z(363)) + MLA*(Z(398)*Z
     &(400)+Z(414)*Z(408)) + MSH*(Z(176)*Z(178)+Z(186)*Z(182)) + MSH*(Z(
     &229)*Z(233)+Z(246)*Z(241)) + MTH*(Z(192)*Z(194)+Z(202)*Z(199)) + M
     &TH*(Z(211)*Z(214)+Z(223)*Z(220)) + MUA*(Z(333)*Z(335)+Z(345)*Z(342
     &)) + MUA*(Z(378)*Z(380)+Z(390)*Z(387)) + 0.5D0*MRF*(LRFO*Z(17)*Z(4
     &2)-2*LFF*Z(42)-LRFFO*Z(560)*Z(42)-LRFFO*Z(561)*Z(40)-LRFO*Z(18)*Z(
     &40)) + 0.5D0*MRF*(2*Z(229)*Z(233)+2*Z(250)*Z(241)-2*Z(91)*Z(11)*Z(
     &241)-2*Z(91)*Z(12)*Z(233)-LRFFO*Z(563)*Z(241)-LRFFO*Z(565)*Z(233))
     & - Z(992)*Z(42)
      Z(1198) = MFF*(Z(40)**2+Z(42)**2) + MFF*(Z(291)**2+Z(300)**2) + MH
     &AT*(Z(320)**2+Z(326)**2) + MLA*(Z(355)**2+Z(363)**2) + MLA*(Z(400)
     &**2+Z(408)**2) + MRF*(Z(40)**2+Z(42)**2) + MRF*(Z(233)**2+Z(241)**
     &2) + MSH*(Z(178)**2+Z(182)**2) + MSH*(Z(233)**2+Z(241)**2) + MTH*(
     &Z(194)**2+Z(199)**2) + MTH*(Z(214)**2+Z(220)**2) + MUA*(Z(335)**2+
     &Z(342)**2) + MUA*(Z(380)**2+Z(387)**2)
      Z(1199) = MFF*(Z(291)*Z(497)+Z(300)*Z(498)) + MHAT*(Z(320)*Z(505)+
     &Z(326)*Z(503)) + MLA*(Z(355)*Z(520)+Z(363)*Z(521)) + MLA*(Z(400)*Z
     &(537)+Z(408)*Z(538)) + MSH*(Z(178)*Z(453)+Z(182)*Z(454)) + MSH*(Z(
     &233)*Z(478)+Z(241)*Z(479)) + MTH*(Z(194)*Z(461)+Z(199)*Z(462)) + M
     &TH*(Z(214)*Z(469)+Z(220)*Z(470)) + MUA*(Z(335)*Z(511)+Z(342)*Z(512
     &)) + MUA*(Z(380)*Z(528)+Z(387)*Z(529)) - MFF*(Z(434)*Z(42)-Z(40)*Z
     &(436)) - 0.5D0*MRF*(2*Z(437)*Z(42)+Z(18)*Z(439)*Z(40)+Z(560)*Z(440
     &)*Z(42)+Z(561)*Z(440)*Z(40)+Z(17)*Z(40)*Z(442)+Z(18)*Z(42)*Z(442)-
     &Z(17)*Z(439)*Z(42)-2*Z(40)*Z(438)-Z(560)*Z(40)*Z(443)-Z(562)*Z(42)
     &*Z(443)) - 0.5D0*MRF*(Z(563)*Z(484)*Z(241)+Z(565)*Z(484)*Z(233)+2*
     &Z(11)*Z(483)*Z(241)+2*Z(12)*Z(483)*Z(233)+2*Z(12)*Z(241)*Z(486)-2*
     &Z(233)*Z(481)-2*Z(241)*Z(482)-2*Z(11)*Z(233)*Z(486)-Z(563)*Z(233)*
     &Z(487)-Z(564)*Z(241)*Z(487))
      Z(1206) = Z(1200) + MFF*(Z(287)**2+Z(305)**2) + MHAT*(Z(317)**2+Z(
     &328)**2) + MLA*(Z(353)**2+Z(369)**2) + MLA*(Z(398)**2+Z(414)**2) +
     & MSH*(Z(176)**2+Z(186)**2) + MSH*(Z(229)**2+Z(246)**2) + MTH*(Z(19
     &2)**2+Z(202)**2) + MTH*(Z(211)**2+Z(223)**2) + MUA*(Z(333)**2+Z(34
     &5)**2) + MUA*(Z(378)**2+Z(390)**2) + 0.25D0*MRF*(Z(1201)+4*Z(1202)
     &*Z(560)-4*Z(1203)*Z(17)) + 0.25D0*MRF*(Z(1204)+4*Z(229)**2+4*Z(250
     &)**2-4*Z(1205)-8*Z(91)*Z(11)*Z(250)-8*Z(91)*Z(12)*Z(229)-4*LRFFO*Z
     &(229)*Z(565)-4*LRFFO*Z(250)*Z(563))
      Z(1213) = Z(1176) + Z(1178) + Z(1180) + Z(1182) + Z(1187) + Z(1188
     &) + Z(1189) + Z(1190) + Z(992)*Z(434) + MFF*(Z(287)*Z(497)+Z(305)*
     &Z(498)) + MHAT*(Z(317)*Z(505)+Z(328)*Z(503)) + MLA*(Z(353)*Z(520)+
     &Z(369)*Z(521)) + MLA*(Z(398)*Z(537)+Z(414)*Z(538)) + MSH*(Z(176)*Z
     &(453)+Z(186)*Z(454)) + MSH*(Z(229)*Z(478)+Z(246)*Z(479)) + MTH*(Z(
     &192)*Z(461)+Z(202)*Z(462)) + MTH*(Z(211)*Z(469)+Z(223)*Z(470)) + M
     &UA*(Z(333)*Z(511)+Z(345)*Z(512)) + MUA*(Z(378)*Z(528)+Z(390)*Z(529
     &)) + 0.25D0*MRF*(LRFFO*Z(440)+LRFO*Z(439)+Z(1207)*Z(439)+Z(1208)*Z
     &(440)+4*LFF*Z(437)+2*LFF*Z(560)*Z(440)+2*LRFFO*Z(560)*Z(437)+Z(120
     &9)*Z(442)+2*LFF*Z(18)*Z(442)-2*LFF*Z(17)*Z(439)-2*LRFO*Z(17)*Z(437
     &)-Z(1210)*Z(443)-2*LFF*Z(562)*Z(443)-2*LRFFO*Z(561)*Z(438)-2*LRFO*
     &Z(18)*Z(438)) - Z(1184) - Z(1186) - Z(1191) - Z(1192) - 0.25D0*MRF
     &*(2*Z(1207)*Z(483)+2*Z(1211)*Z(484)+2*Z(229)*Z(565)*Z(484)+2*Z(250
     &)*Z(563)*Z(484)+4*Z(11)*Z(250)*Z(483)+4*Z(12)*Z(229)*Z(483)+2*Z(12
     &09)*Z(486)+2*LRFFO*Z(563)*Z(482)+2*LRFFO*Z(565)*Z(481)+4*Z(91)*Z(1
     &1)*Z(482)+4*Z(91)*Z(12)*Z(481)+4*Z(12)*Z(250)*Z(486)-4*Z(91)*Z(483
     &)-LRFFO*Z(484)-4*Z(229)*Z(481)-4*Z(250)*Z(482)-2*Z(1212)*Z(487)-4*
     &Z(11)*Z(229)*Z(486)-2*Z(229)*Z(563)*Z(487)-2*Z(250)*Z(564)*Z(487))
      Z(1266) = Z(1157) - Z(1196)
      Z(1267) = Z(1158) - Z(1199)
      Z(1287) = Z(264)*VRX2*Z(64) + Z(264)*VRY2*Z(65) + Z(279)*VRX2*Z(66
     &) + Z(279)*VRY2*Z(67) + Z(287)*VRX1*Z(72) + Z(287)*VRY1*Z(73) + Z(
     &311)*VRX1*Z(74) + Z(311)*VRY1*Z(75) + Z(542)*(Z(317)*Z(2)+Z(328)*Z
     &(1)) + Z(543)*(Z(287)*Z(73)+Z(305)*Z(75)) + Z(544)*(Z(353)*Z(80)+Z
     &(369)*Z(82)) + Z(544)*(Z(398)*Z(87)+Z(414)*Z(89)) + Z(546)*(Z(176)
     &*Z(36)+Z(186)*Z(38)) + Z(546)*(Z(229)*Z(61)+Z(246)*Z(63)) + Z(547)
     &*(Z(192)*Z(55)+Z(202)*Z(54)) + Z(547)*(Z(211)*Z(58)+Z(223)*Z(57)) 
     &+ Z(548)*(Z(333)*Z(77)+Z(345)*Z(76)) + Z(548)*(Z(378)*Z(84)+Z(390)
     &*Z(83)) - Z(1159)*Z(42) - LFF*(RX2*Z(41)+RY2*Z(42)) - 0.5D0*Z(545)
     &*(LRFFO*Z(49)+LRFO*Z(53)+2*LFF*Z(42)) - 0.5D0*Z(545)*(LRFFO*Z(71)-
     &2*Z(91)*Z(67)-2*Z(229)*Z(61)-2*Z(250)*Z(63)) - Z(1213)

      COEF(1,1) = -Z(1194)
      COEF(1,2) = -Z(1195)
      COEF(1,3) = -Z(1193)
      COEF(2,1) = -Z(1195)
      COEF(2,2) = -Z(1198)
      COEF(2,3) = -Z(1197)
      COEF(3,1) = -Z(1193)
      COEF(3,2) = -Z(1197)
      COEF(3,3) = -Z(1206)
      RHS(1) = -Z(1266)
      RHS(2) = -Z(1267)
      RHS(3) = -Z(1287)
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
      COMMON/CONSTNTS/ FOOTANG,G,IFF,IHAT,ILA,IRF,ISH,ITH,IUA,K1,K2,K3,K
     &4,K5,K6,K7,K8,LFF,LFFO,LHAT,LHATO,LLA,LLAO,LMTPXI,LRF,LRFF,LRFFO,L
     &RFO,LSH,LSHO,LTH,LTHO,LTOEXI,LUA,LUAO,MFF,MHAT,MLA,MRF,MSH,MTH,MTP
     &B,MTPK,MUA,RMTPXI,RTOEXI
      COMMON/SPECFIED/ LA,LE,LH,LK,LMTP,LS,RA,RE,RH,RK,RMTP,RS,LAp,LEp,L
     &Hp,LKp,LMTPp,LSp,RAp,REp,RHp,RKp,RMTPp,RSp,LApp,LEpp,LHpp,LKpp,LMT
     &Ppp,LSpp,RApp,REpp,RHpp,RKpp,RMTPpp,RSpp
      COMMON/VARIBLES/ Q1,Q2,Q3,U1,U2,U3
      COMMON/ALGBRAIC/ HZ,KECM,LATQ,LETQ,LHTQ,LKTQ,LSTQ,PX,PY,RATQ,RETQ,
     &RHTQ,RKTQ,RSTQ,RX1,RX2,RY1,RY2,U10,U11,U12,U13,U4,U5,U6,U7,U8,U9,V
     &RX1,VRX2,VRY1,VRY2,Q1p,Q2p,Q3p,U1p,U2p,U3p,DLX1,DLX2,DRX1,DRX2,LMT
     &Q,POCMX,POCMY,POP10X,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP13X,POP
     &13Y,POP14X,POP14Y,POP15X,POP15Y,POP16X,POP16Y,POP1X,POP1Y,POP2X,PO
     &P2Y,POP3X,POP3Y,POP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,PO
     &P8X,POP8Y,POP9X,POP9Y,RMTQ,RX,RY,VOCMX,VOCMY,VOP10X,VOP10Y,VOP11X,
     &VOP11Y,VOP2X,VOP2Y,VRX,VRY
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(1287),COEF(3,3),RHS(3)

C**   Evaluate output quantities
      Z(321) = Z(5)*Z(195) + Z(6)*Z(206)
      Z(316) = Z(5)*Z(191) + Z(6)*Z(196)
      Z(318) = Z(5)*Z(192) + Z(6)*Z(197)
      Z(327) = Z(5)*Z(206) - Z(6)*Z(195)
      Z(322) = Z(5)*Z(196) - Z(6)*Z(191)
      Z(323) = Z(5)*Z(197) - Z(6)*Z(192)
      Z(187) = Z(183) - Z(185)
      Z(203) = Z(200) + Z(201)
      Z(224) = Z(221) - Z(222)
      Z(336) = Z(20)*Z(327) - Z(19)*Z(321)
      Z(330) = Z(20)*Z(322) - Z(19)*Z(316)
      Z(331) = Z(20)*Z(323) - Z(19)*Z(318)
      Z(332) = Z(20)*Z(324) - Z(19)*Z(317)
      Z(343) = -Z(19)*Z(327) - Z(20)*Z(321)
      Z(346) = Z(343) - Z(344)
      Z(337) = -Z(19)*Z(322) - Z(20)*Z(316)
      Z(338) = -Z(19)*Z(323) - Z(20)*Z(318)
      Z(339) = -Z(19)*Z(324) - Z(20)*Z(317)
      Z(381) = Z(22)*Z(327) - Z(21)*Z(321)
      Z(375) = Z(22)*Z(322) - Z(21)*Z(316)
      Z(376) = Z(22)*Z(323) - Z(21)*Z(318)
      Z(377) = Z(22)*Z(324) - Z(21)*Z(317)
      Z(388) = -Z(21)*Z(327) - Z(22)*Z(321)
      Z(391) = Z(388) - Z(389)
      Z(382) = -Z(21)*Z(322) - Z(22)*Z(316)
      Z(383) = -Z(21)*Z(323) - Z(22)*Z(318)
      Z(384) = -Z(21)*Z(324) - Z(22)*Z(317)
      Z(309) = Z(302) + Z(304)
      Z(306) = Z(90) + Z(298)
      Z(307) = Z(90) + Z(293)
      Z(308) = Z(90) - Z(301)
      Z(349) = Z(343) - Z(347)
      Z(365) = Z(24)*Z(336) - Z(23)*Z(349)
      Z(370) = Z(365) + Z(367)
      Z(358) = Z(24)*Z(330) - Z(23)*Z(337)
      Z(359) = Z(24)*Z(331) - Z(23)*Z(338)
      Z(360) = Z(24)*Z(332) - Z(23)*Z(339)
      Z(364) = LUA*Z(23)
      Z(368) = LLAO - Z(364)
      Z(356) = LUA*Z(24)
      Z(357) = -Z(23)*Z(336) - Z(24)*Z(349)
      Z(350) = -Z(23)*Z(330) - Z(24)*Z(337)
      Z(351) = -Z(23)*Z(331) - Z(24)*Z(338)
      Z(352) = -Z(23)*Z(332) - Z(24)*Z(339)
      Z(394) = Z(388) - Z(392)
      Z(410) = Z(26)*Z(381) - Z(25)*Z(394)
      Z(415) = Z(410) + Z(412)
      Z(403) = Z(26)*Z(375) - Z(25)*Z(382)
      Z(404) = Z(26)*Z(376) - Z(25)*Z(383)
      Z(405) = Z(26)*Z(377) - Z(25)*Z(384)
      Z(409) = LUA*Z(25)
      Z(413) = LLAO - Z(409)
      Z(401) = LUA*Z(26)
      Z(402) = -Z(25)*Z(381) - Z(26)*Z(394)
      Z(395) = -Z(25)*Z(375) - Z(26)*Z(382)
      Z(396) = -Z(25)*Z(376) - Z(26)*Z(383)
      Z(397) = -Z(25)*Z(377) - Z(26)*Z(384)
      Z(248) = Z(243) + Z(245)
      Z(247) = Z(92) - Z(242)
      KECM = 0.5D0*IHAT*U3**2 + 0.5D0*ITH*(LHp-U3-U5)**2 + 0.5D0*ITH*(RH
     &p-U3-U4)**2 + 0.5D0*IUA*(LSp-U11-U3)**2 + 0.5D0*IUA*(RSp-U10-U3)**
     &2 + 0.5D0*ILA*(LSp-LEp-U11-U13-U3)**2 + 0.5D0*ILA*(RSp-REp-U10-U12
     &-U3)**2 + 0.5D0*ISH*(LHp-LKp-U3-U5-U7)**2 + 0.5D0*ISH*(RHp-RKp-U3-
     &U4-U6)**2 + 0.5D0*IRF*(LAp+LHp-LKp-U3-U5-U7-U9)**2 + 0.5D0*IRF*(RA
     &p+RHp-RKp-U3-U4-U6-U8)**2 + 0.5D0*IFF*(LAp+LHp+LMTPp-LKp-U3-U5-U7-
     &U9)**2 + 0.5D0*IFF*(RAp+RHp+RMTPp-RKp-U3-U4-U6-U8)**2 + 0.5D0*MFF*
     &((Z(39)*U1+Z(40)*U2)**2+(Z(156)+LFFO*U3+LFFO*U5+LFFO*U7+LFFO*U9-Z(
     &41)*U1-Z(42)*U2)**2) + 0.5D0*MHAT*((Z(321)+Z(316)*U9+Z(317)*U3+Z(3
     &17)*U5+Z(318)*U7+Z(319)*U1+Z(320)*U2)**2+(Z(327)+Z(322)*U9+Z(323)*
     &U7+Z(324)*U5+Z(328)*U3+Z(325)*U1+Z(326)*U2)**2) + 0.5D0*MSH*((Z(17
     &9)+Z(176)*U3+Z(176)*U5+Z(176)*U7+Z(176)*U9+Z(177)*U1+Z(178)*U2)**2
     &+(Z(187)+Z(180)*U9+Z(186)*U3+Z(186)*U5+Z(186)*U7+Z(181)*U1+Z(182)*
     &U2)**2) + 0.5D0*MTH*((Z(195)+Z(191)*U9+Z(192)*U3+Z(192)*U5+Z(192)*
     &U7+Z(193)*U1+Z(194)*U2)**2+(Z(203)+Z(196)*U9+Z(197)*U7+Z(202)*U3+Z
     &(202)*U5+Z(198)*U1+Z(199)*U2)**2) + 0.5D0*MTH*((Z(215)+Z(210)*U9+Z
     &(211)*U3+Z(211)*U5+Z(212)*U7+Z(213)*U1+Z(214)*U2)**2+(Z(224)+Z(93)
     &*U4+Z(216)*U9+Z(217)*U7+Z(218)*U5+Z(223)*U3+Z(219)*U1+Z(220)*U2)**
     &2) + 0.5D0*MUA*((Z(336)+Z(330)*U9+Z(331)*U7+Z(332)*U5+Z(333)*U3+Z(
     &334)*U1+Z(335)*U2)**2+(Z(346)+LUAO*U10+Z(337)*U9+Z(338)*U7+Z(339)*
     &U5+Z(345)*U3+Z(341)*U1+Z(342)*U2)**2) + 0.5D0*MUA*((Z(381)+Z(375)*
     &U9+Z(376)*U7+Z(377)*U5+Z(378)*U3+Z(379)*U1+Z(380)*U2)**2+(Z(391)+L
     &UAO*U11+Z(382)*U9+Z(383)*U7+Z(384)*U5+Z(390)*U3+Z(386)*U1+Z(387)*U
     &2)**2) + 0.5D0*MFF*((Z(292)+Z(283)*U8+Z(284)*U9+Z(285)*U5+Z(286)*U
     &7+Z(287)*U3+Z(288)*U4+Z(289)*U6+Z(290)*U1+Z(291)*U2)**2+(Z(309)+Z(
     &294)*U9+Z(295)*U5+Z(296)*U7+Z(305)*U3+Z(306)*U4+Z(307)*U6+Z(308)*U
     &8+Z(299)*U1+Z(300)*U2)**2) + 0.5D0*MLA*((Z(370)+LLAO*U12+Z(358)*U9
     &+Z(359)*U7+Z(360)*U5+Z(368)*U10+Z(369)*U3+Z(362)*U1+Z(363)*U2)**2+
     &(Z(356)*U10-Z(357)-Z(350)*U9-Z(351)*U7-Z(352)*U5-Z(353)*U3-Z(354)*
     &U1-Z(355)*U2)**2) + 0.5D0*MLA*((Z(415)+LLAO*U13+Z(403)*U9+Z(404)*U
     &7+Z(405)*U5+Z(413)*U11+Z(414)*U3+Z(407)*U1+Z(408)*U2)**2+(Z(401)*U
     &11-Z(402)-Z(395)*U9-Z(396)*U7-Z(397)*U5-Z(398)*U3-Z(399)*U1-Z(400)
     &*U2)**2) + 0.5D0*MSH*((Z(248)+Z(92)*U6+Z(236)*U9+Z(238)*U5+Z(239)*
     &U7+Z(246)*U3+Z(247)*U4+Z(240)*U1+Z(241)*U2)**2+(Z(234)*U4-Z(235)-Z
     &(228)*U9-Z(229)*U3-Z(230)*U5-Z(231)*U7-Z(232)*U1-Z(233)*U2)**2) - 
     &0.125D0*MRF*(4*Z(18)*(Z(39)*U1+Z(40)*U2)*(Z(163)+LRFO*U3+LRFO*U5+L
     &RFO*U7+LRFO*U9)+4*Z(561)*(Z(39)*U1+Z(40)*U2)*(Z(164)+LRFFO*U3+LRFF
     &O*U5+LRFFO*U7+LRFFO*U9)+4*Z(17)*(Z(163)+LRFO*U3+LRFO*U5+LRFO*U7+LR
     &FO*U9)*(Z(157)+LFF*U3+LFF*U5+LFF*U7+LFF*U9-Z(41)*U1-Z(42)*U2)-4*(Z
     &(39)*U1+Z(40)*U2)**2-(Z(163)+LRFO*U3+LRFO*U5+LRFO*U7+LRFO*U9)**2-(
     &Z(164)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)**2-4*(Z(157)+LFF*U3+LF
     &F*U5+LFF*U7+LFF*U9-Z(41)*U1-Z(42)*U2)**2-2*Z(27)*(Z(163)+LRFO*U3+L
     &RFO*U5+LRFO*U7+LRFO*U9)*(Z(164)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U
     &9)-4*Z(560)*(Z(164)+LRFFO*U3+LRFFO*U5+LRFFO*U7+LRFFO*U9)*(Z(157)+L
     &FF*U3+LFF*U5+LFF*U7+LFF*U9-Z(41)*U1-Z(42)*U2)) - 0.125D0*MRF*(4*Z(
     &27)*(Z(258)+Z(91)*U3+Z(91)*U4+Z(91)*U6+Z(91)*U8)*(Z(259)+LRFFO*U3+
     &LRFFO*U4+LRFFO*U6+LRFFO*U8)+4*Z(563)*(Z(259)+LRFFO*U3+LRFFO*U4+LRF
     &FO*U6+LRFFO*U8)*(Z(252)+LSH*U6+Z(236)*U9+Z(238)*U5+Z(239)*U7+Z(250
     &)*U3+Z(251)*U4+Z(240)*U1+Z(241)*U2)+8*Z(11)*(Z(258)+Z(91)*U3+Z(91)
     &*U4+Z(91)*U6+Z(91)*U8)*(Z(252)+LSH*U6+Z(236)*U9+Z(238)*U5+Z(239)*U
     &7+Z(250)*U3+Z(251)*U4+Z(240)*U1+Z(241)*U2)-4*(Z(258)+Z(91)*U3+Z(91
     &)*U4+Z(91)*U6+Z(91)*U8)**2-(Z(259)+LRFFO*U3+LRFFO*U4+LRFFO*U6+LRFF
     &O*U8)**2-4*(Z(252)+LSH*U6+Z(236)*U9+Z(238)*U5+Z(239)*U7+Z(250)*U3+
     &Z(251)*U4+Z(240)*U1+Z(241)*U2)**2-4*(Z(234)*U4-Z(235)-Z(228)*U9-Z(
     &229)*U3-Z(230)*U5-Z(231)*U7-Z(232)*U1-Z(233)*U2)**2-8*Z(12)*(Z(258
     &)+Z(91)*U3+Z(91)*U4+Z(91)*U6+Z(91)*U8)*(Z(234)*U4-Z(235)-Z(228)*U9
     &-Z(229)*U3-Z(230)*U5-Z(231)*U7-Z(232)*U1-Z(233)*U2)-4*Z(565)*(Z(25
     &9)+LRFFO*U3+LRFFO*U4+LRFFO*U6+LRFFO*U8)*(Z(234)*U4-Z(235)-Z(228)*U
     &9-Z(229)*U3-Z(230)*U5-Z(231)*U7-Z(232)*U1-Z(233)*U2))
      Z(566) = IFF*Z(155)
      Z(567) = ILA*Z(411)
      Z(568) = IRF*Z(158)
      Z(569) = ISH*Z(184)
      Z(572) = IFF*Z(303)
      Z(573) = ILA*Z(366)
      Z(574) = IRF*Z(253)
      Z(575) = ISH*Z(244)
      Z(44) = Z(27)*Z(14) - Z(28)*Z(13)
      Z(46) = Z(43)*Z(35) + Z(44)*Z(37)
      Z(47) = Z(43)*Z(36) + Z(44)*Z(38)
      Z(159) = Z(1)*Z(46) + Z(2)*Z(47)
      Z(68) = Z(27)*Z(64) + Z(28)*Z(66)
      Z(69) = Z(27)*Z(65) + Z(28)*Z(67)
      Z(254) = Z(1)*Z(68) + Z(2)*Z(69)
      Z(78) = Z(19)*Z(2) - Z(20)*Z(1)
      Z(79) = -Z(23)*Z(76) - Z(24)*Z(78)
      Z(145) = Z(1)*Z(79) + Z(2)*Z(80)
      Z(85) = Z(21)*Z(2) - Z(22)*Z(1)
      Z(86) = -Z(25)*Z(83) - Z(26)*Z(85)
      Z(151) = Z(1)*Z(86) + Z(2)*Z(87)
      Z(131) = Z(1)*Z(72) + Z(2)*Z(73)
      Z(119) = Z(1)*Z(64) + Z(2)*Z(65)
      Z(111) = Z(1)*Z(60) + Z(2)*Z(61)
      Z(137) = Z(1)*Z(39) + Z(2)*Z(40)
      Z(125) = Z(1)*Z(50) + Z(2)*Z(51)
      Z(582) = LHATO + Z(102)*Z(19) + Z(102)*Z(21) + 0.5D0*Z(99)*Z(159) 
     &+ 0.5D0*Z(99)*Z(254) - Z(95) - Z(106)*Z(3) - Z(578)*Z(32) - Z(579)
     &*Z(5) - Z(97)*Z(145) - Z(97)*Z(151) - Z(103)*Z(131) - Z(104)*Z(119
     &) - Z(105)*Z(111) - Z(580)*Z(137) - 0.5D0*Z(581)*Z(125)
      Z(941) = MHAT*Z(582)
      Z(585) = Z(327) + Z(322)*U9 + Z(323)*U7 + Z(324)*U5 + Z(328)*U3 + 
     &Z(325)*U1 + Z(326)*U2
      Z(139) = Z(1)*Z(40) - Z(2)*Z(39)
      Z(590) = Z(5)*Z(137) - Z(6)*Z(139)
      Z(598) = Z(39)*Z(72) + Z(40)*Z(73)
      Z(600) = Z(39)*Z(74) + Z(40)*Z(75)
      Z(606) = -Z(15)*Z(598) - Z(16)*Z(600)
      Z(608) = Z(16)*Z(598) - Z(15)*Z(600)
      Z(610) = Z(27)*Z(606) + Z(28)*Z(608)
      Z(586) = Z(39)*Z(86) + Z(40)*Z(87)
      Z(602) = Z(39)*Z(79) + Z(40)*Z(80)
      Z(594) = Z(22)*Z(139) - Z(21)*Z(137)
      Z(622) = Z(20)*Z(139) - Z(19)*Z(137)
      Z(614) = -Z(11)*Z(606) - Z(12)*Z(608)
      Z(618) = Z(3)*Z(137) - Z(4)*Z(139)
      Z(626) = Z(96) + Z(100)*Z(29) + 0.5D0*Z(99)*Z(560) + Z(101)*Z(590)
     & + 0.5D0*Z(99)*Z(610) - LFFO - 0.5D0*Z(98)*Z(17) - Z(95)*Z(137) - 
     &Z(97)*Z(586) - Z(97)*Z(602) - Z(102)*Z(594) - Z(102)*Z(622) - Z(10
     &3)*Z(598) - Z(104)*Z(606) - Z(105)*Z(614) - Z(106)*Z(618)
      Z(943) = MFF*Z(626)
      Z(629) = Z(41)*U1 + Z(42)*U2 - Z(156) - LFFO*U3 - LFFO*U5 - LFFO*U
     &7 - LFFO*U9
      Z(587) = Z(41)*Z(86) + Z(42)*Z(87)
      Z(630) = -Z(17)*Z(586) - Z(18)*Z(587)
      Z(632) = Z(18)*Z(586) - Z(17)*Z(587)
      Z(634) = Z(27)*Z(630) + Z(28)*Z(632)
      Z(646) = Z(72)*Z(86) + Z(73)*Z(87)
      Z(648) = Z(74)*Z(86) + Z(75)*Z(87)
      Z(654) = -Z(15)*Z(646) - Z(16)*Z(648)
      Z(656) = Z(16)*Z(646) - Z(15)*Z(648)
      Z(658) = Z(27)*Z(654) + Z(28)*Z(656)
      Z(650) = Z(79)*Z(86) + Z(80)*Z(87)
      Z(153) = Z(1)*Z(87) - Z(2)*Z(86)
      Z(670) = Z(20)*Z(153) - Z(19)*Z(151)
      Z(662) = -Z(11)*Z(654) - Z(12)*Z(656)
      Z(666) = Z(3)*Z(151) - Z(4)*Z(153)
      Z(638) = -Z(13)*Z(630) - Z(14)*Z(632)
      Z(642) = Z(5)*Z(151) - Z(6)*Z(153)
      Z(676) = LLAO + Z(674)*Z(151) + 0.5D0*Z(99)*Z(634) + 0.5D0*Z(99)*Z
     &(658) - Z(97) - Z(675)*Z(25) - Z(97)*Z(650) - Z(102)*Z(670) - Z(10
     &3)*Z(646) - Z(104)*Z(654) - Z(105)*Z(662) - Z(106)*Z(666) - Z(578)
     &*Z(638) - Z(579)*Z(642) - Z(580)*Z(586) - 0.5D0*Z(581)*Z(630)
      Z(945) = MLA*Z(676)
      Z(679) = Z(415) + LLAO*U13 + Z(403)*U9 + Z(404)*U7 + Z(405)*U5 + Z
     &(413)*U11 + Z(414)*U3 + Z(407)*U1 + Z(408)*U2
      Z(762) = Z(35)*Z(72) + Z(36)*Z(73)
      Z(764) = Z(35)*Z(74) + Z(36)*Z(75)
      Z(770) = -Z(15)*Z(762) - Z(16)*Z(764)
      Z(772) = Z(16)*Z(762) - Z(15)*Z(764)
      Z(774) = Z(27)*Z(770) + Z(28)*Z(772)
      Z(758) = Z(22)*Z(33) - Z(21)*Z(32)
      Z(786) = Z(20)*Z(33) - Z(19)*Z(32)
      Z(782) = Z(3)*Z(32) - Z(4)*Z(33)
      Z(766) = Z(35)*Z(79) + Z(36)*Z(80)
      Z(778) = -Z(11)*Z(770) - Z(12)*Z(772)
      Z(790) = Z(100) + 0.5D0*Z(99)*Z(43) + 0.5D0*Z(581)*Z(13) + 0.5D0*Z
     &(99)*Z(774) - LSHO - Z(95)*Z(32) - Z(101)*Z(9) - Z(102)*Z(758) - Z
     &(102)*Z(786) - Z(106)*Z(782) - Z(580)*Z(29) - Z(97)*Z(638) - Z(97)
     &*Z(766) - Z(103)*Z(762) - Z(104)*Z(770) - Z(105)*Z(778)
      Z(953) = MSH*Z(790)
      Z(793) = Z(187) + Z(180)*U9 + Z(186)*U3 + Z(186)*U5 + Z(186)*U7 + 
     &Z(181)*U1 + Z(182)*U2
      Z(161) = Z(1)*Z(47) - Z(2)*Z(46)
      Z(690) = Z(5)*Z(159) - Z(6)*Z(161)
      Z(797) = Z(54)*Z(72) + Z(55)*Z(73)
      Z(799) = Z(54)*Z(74) + Z(55)*Z(75)
      Z(805) = -Z(15)*Z(797) - Z(16)*Z(799)
      Z(807) = Z(16)*Z(797) - Z(15)*Z(799)
      Z(809) = Z(27)*Z(805) + Z(28)*Z(807)
      Z(794) = -Z(5)*Z(21) - Z(6)*Z(22)
      Z(817) = -Z(5)*Z(19) - Z(6)*Z(20)
      Z(813) = -Z(7)*Z(207) - Z(8)*Z(208)
      Z(801) = Z(54)*Z(79) + Z(55)*Z(80)
      Z(127) = Z(1)*Z(51) - Z(2)*Z(50)
      Z(686) = Z(5)*Z(125) - Z(6)*Z(127)
      Z(820) = Z(101) + Z(578)*Z(9) + 0.5D0*Z(99)*Z(690) + 0.5D0*Z(99)*Z
     &(809) - LTHO - Z(95)*Z(5) - Z(102)*Z(794) - Z(102)*Z(817) - Z(105)
     &*Z(813) - Z(106)*Z(207) - Z(97)*Z(642) - Z(97)*Z(801) - Z(103)*Z(7
     &97) - Z(104)*Z(805) - Z(580)*Z(590) - 0.5D0*Z(581)*Z(686)
      Z(955) = MTH*Z(820)
      Z(823) = Z(203) + Z(196)*U9 + Z(197)*U7 + Z(202)*U3 + Z(202)*U5 + 
     &Z(198)*U1 + Z(199)*U2
      Z(698) = Z(22)*Z(161) - Z(21)*Z(159)
      Z(824) = Z(72)*Z(83) + Z(73)*Z(84)
      Z(826) = Z(74)*Z(83) + Z(75)*Z(84)
      Z(832) = -Z(15)*Z(824) - Z(16)*Z(826)
      Z(834) = Z(16)*Z(824) - Z(15)*Z(826)
      Z(836) = Z(27)*Z(832) + Z(28)*Z(834)
      Z(847) = Z(19)*Z(21) + Z(20)*Z(22)
      Z(844) = -Z(3)*Z(21) - Z(4)*Z(22)
      Z(828) = Z(79)*Z(83) + Z(80)*Z(84)
      Z(840) = -Z(11)*Z(832) - Z(12)*Z(834)
      Z(694) = Z(22)*Z(127) - Z(21)*Z(125)
      Z(850) = LUAO + Z(97)*Z(25) + 0.5D0*Z(99)*Z(698) + 0.5D0*Z(99)*Z(8
     &36) - Z(102) - Z(102)*Z(847) - Z(106)*Z(844) - Z(578)*Z(758) - Z(5
     &79)*Z(794) - Z(674)*Z(21) - Z(97)*Z(828) - Z(103)*Z(824) - Z(104)*
     &Z(832) - Z(105)*Z(840) - Z(580)*Z(594) - 0.5D0*Z(581)*Z(694)
      Z(957) = MUA*Z(850)
      Z(853) = Z(391) + LUAO*U11 + Z(382)*U9 + Z(383)*U7 + Z(384)*U5 + Z
     &(390)*U3 + Z(386)*U1 + Z(387)*U2
      Z(861) = Z(11)*Z(15) - Z(12)*Z(16)
      Z(858) = Z(28)*Z(16) - Z(27)*Z(15)
      Z(133) = Z(1)*Z(73) - Z(2)*Z(72)
      Z(864) = Z(3)*Z(131) - Z(4)*Z(133)
      Z(706) = Z(46)*Z(72) + Z(47)*Z(73)
      Z(854) = Z(72)*Z(79) + Z(73)*Z(80)
      Z(868) = Z(20)*Z(133) - Z(19)*Z(131)
      Z(702) = Z(50)*Z(72) + Z(51)*Z(73)
      Z(875) = LFF + Z(872)*Z(861) + 0.5D0*Z(99)*Z(858) + Z(873)*Z(864) 
     &+ 0.5D0*Z(99)*Z(706) - LFFO - Z(103) - Z(874)*Z(15) - Z(95)*Z(131)
     & - Z(97)*Z(646) - Z(97)*Z(854) - Z(102)*Z(824) - Z(102)*Z(868) - Z
     &(578)*Z(762) - Z(579)*Z(797) - Z(580)*Z(598) - 0.5D0*Z(581)*Z(702)
      Z(959) = MFF*Z(875)
      Z(878) = Z(309) + Z(294)*U9 + Z(295)*U5 + Z(296)*U7 + Z(305)*U3 + 
     &Z(306)*U4 + Z(307)*U6 + Z(308)*U8 + Z(299)*U1 + Z(300)*U2
      Z(714) = Z(46)*Z(79) + Z(47)*Z(80)
      Z(855) = Z(74)*Z(79) + Z(75)*Z(80)
      Z(879) = -Z(15)*Z(854) - Z(16)*Z(855)
      Z(881) = Z(16)*Z(854) - Z(15)*Z(855)
      Z(883) = Z(27)*Z(879) + Z(28)*Z(881)
      Z(887) = -Z(11)*Z(879) - Z(12)*Z(881)
      Z(147) = Z(1)*Z(80) - Z(2)*Z(79)
      Z(891) = Z(3)*Z(145) - Z(4)*Z(147)
      Z(710) = Z(50)*Z(79) + Z(51)*Z(80)
      Z(895) = LLAO + Z(674)*Z(145) + 0.5D0*Z(99)*Z(714) + 0.5D0*Z(99)*Z
     &(883) - Z(97) - Z(675)*Z(23) - Z(97)*Z(650) - Z(102)*Z(828) - Z(10
     &3)*Z(854) - Z(104)*Z(879) - Z(105)*Z(887) - Z(106)*Z(891) - Z(578)
     &*Z(766) - Z(579)*Z(801) - Z(580)*Z(602) - 0.5D0*Z(581)*Z(710)
      Z(961) = MLA*Z(895)
      Z(898) = Z(370) + LLAO*U12 + Z(358)*U9 + Z(359)*U7 + Z(360)*U5 + Z
     &(368)*U10 + Z(369)*U3 + Z(362)*U1 + Z(363)*U2
      Z(708) = Z(46)*Z(74) + Z(47)*Z(75)
      Z(722) = -Z(15)*Z(706) - Z(16)*Z(708)
      Z(724) = Z(16)*Z(706) - Z(15)*Z(708)
      Z(738) = -Z(11)*Z(722) - Z(12)*Z(724)
      Z(113) = Z(1)*Z(61) - Z(2)*Z(60)
      Z(923) = Z(20)*Z(113) - Z(19)*Z(111)
      Z(704) = Z(50)*Z(74) + Z(51)*Z(75)
      Z(718) = -Z(15)*Z(702) - Z(16)*Z(704)
      Z(720) = Z(16)*Z(702) - Z(15)*Z(704)
      Z(734) = -Z(11)*Z(718) - Z(12)*Z(720)
      Z(927) = LSH + Z(104)*Z(11) + 0.5D0*Z(99)*Z(563) + 0.5D0*Z(99)*Z(7
     &38) - LSHO - Z(105) - Z(103)*Z(861) - Z(579)*Z(813) - Z(873)*Z(7) 
     &- Z(95)*Z(111) - Z(97)*Z(662) - Z(97)*Z(887) - Z(102)*Z(840) - Z(1
     &02)*Z(923) - Z(578)*Z(778) - Z(580)*Z(614) - 0.5D0*Z(581)*Z(734)
      Z(969) = MSH*Z(927)
      Z(929) = Z(248) + Z(92)*U6 + Z(236)*U9 + Z(238)*U5 + Z(239)*U7 + Z
     &(246)*U3 + Z(247)*U4 + Z(240)*U1 + Z(241)*U2
      Z(746) = Z(3)*Z(159) - Z(4)*Z(161)
      Z(256) = Z(1)*Z(69) - Z(2)*Z(68)
      Z(911) = Z(3)*Z(254) - Z(4)*Z(256)
      Z(930) = -Z(3)*Z(19) - Z(4)*Z(20)
      Z(121) = Z(1)*Z(65) - Z(2)*Z(64)
      Z(907) = Z(3)*Z(119) - Z(4)*Z(121)
      Z(742) = Z(3)*Z(125) - Z(4)*Z(127)
      Z(933) = LTH + Z(105)*Z(7) + 0.5D0*Z(99)*Z(746) + 0.5D0*Z(99)*Z(91
     &1) - LTHO - Z(106) - Z(95)*Z(3) - Z(102)*Z(844) - Z(102)*Z(930) - 
     &Z(578)*Z(782) - Z(579)*Z(207) - Z(97)*Z(666) - Z(97)*Z(891) - Z(10
     &3)*Z(864) - Z(104)*Z(907) - Z(580)*Z(618) - 0.5D0*Z(581)*Z(742)
      Z(971) = MTH*Z(933)
      Z(936) = Z(224) + Z(93)*U4 + Z(216)*U9 + Z(217)*U7 + Z(218)*U5 + Z
     &(223)*U3 + Z(219)*U1 + Z(220)*U2
      Z(754) = Z(20)*Z(161) - Z(19)*Z(159)
      Z(919) = Z(20)*Z(256) - Z(19)*Z(254)
      Z(915) = Z(20)*Z(121) - Z(19)*Z(119)
      Z(750) = Z(20)*Z(127) - Z(19)*Z(125)
      Z(937) = LUAO + Z(97)*Z(23) + 0.5D0*Z(99)*Z(754) + 0.5D0*Z(99)*Z(9
     &19) - Z(102) - Z(102)*Z(847) - Z(106)*Z(930) - Z(578)*Z(786) - Z(5
     &79)*Z(817) - Z(674)*Z(19) - Z(97)*Z(670) - Z(103)*Z(868) - Z(104)*
     &Z(915) - Z(105)*Z(923) - Z(580)*Z(622) - 0.5D0*Z(581)*Z(750)
      Z(973) = MUA*Z(937)
      Z(940) = Z(346) + LUAO*U10 + Z(337)*U9 + Z(338)*U7 + Z(339)*U5 + Z
     &(345)*U3 + Z(341)*U1 + Z(342)*U2
      Z(947) = MRF*(2*Z(680)+2*Z(100)*Z(29)+2*Z(682)*Z(560)+Z(99)*Z(610)
     &+2*Z(101)*Z(590)-2*Z(681)*Z(17)-2*Z(95)*Z(137)-2*Z(97)*Z(586)-2*Z(
     &97)*Z(602)-2*Z(102)*Z(594)-2*Z(102)*Z(622)-2*Z(103)*Z(598)-2*Z(104
     &)*Z(606)-2*Z(105)*Z(614)-2*Z(106)*Z(618))
      Z(683) = Z(41)*U1 + Z(42)*U2 - Z(157) - LFF*U3 - LFF*U5 - LFF*U7 -
     & LFF*U9
      Z(726) = Z(27)*Z(718) + Z(28)*Z(720)
      Z(950) = MRF*(Z(949)+Z(99)*Z(726)+2*Z(101)*Z(686)-2*Z(100)*Z(13)-2
     &*Z(680)*Z(17)-2*Z(95)*Z(125)-2*Z(97)*Z(630)-2*Z(97)*Z(710)-2*Z(102
     &)*Z(694)-2*Z(102)*Z(750)-2*Z(103)*Z(702)-2*Z(104)*Z(718)-2*Z(105)*
     &Z(734)-2*Z(106)*Z(742))
      Z(684) = -0.5D0*Z(163) - 0.5D0*LRFO*U3 - 0.5D0*LRFO*U5 - 0.5D0*LRF
     &O*U7 - 0.5D0*LRFO*U9
      Z(730) = Z(27)*Z(722) + Z(28)*Z(724)
      Z(952) = MRF*(Z(951)+2*Z(100)*Z(43)+2*Z(680)*Z(560)+Z(99)*Z(730)+2
     &*Z(101)*Z(690)-2*Z(95)*Z(159)-2*Z(97)*Z(634)-2*Z(97)*Z(714)-2*Z(10
     &2)*Z(698)-2*Z(102)*Z(754)-2*Z(103)*Z(706)-2*Z(104)*Z(722)-2*Z(105)
     &*Z(738)-2*Z(106)*Z(746))
      Z(685) = -0.5D0*Z(164) - 0.5D0*LRFFO*U3 - 0.5D0*LRFFO*U5 - 0.5D0*L
     &RFFO*U7 - 0.5D0*LRFFO*U9
      Z(863) = -Z(11)*Z(16) - Z(12)*Z(15)
      Z(112) = Z(1)*Z(62) + Z(2)*Z(63)
      Z(664) = Z(12)*Z(654) - Z(11)*Z(656)
      Z(889) = Z(12)*Z(879) - Z(11)*Z(881)
      Z(842) = Z(12)*Z(832) - Z(11)*Z(834)
      Z(114) = Z(1)*Z(63) - Z(2)*Z(62)
      Z(924) = Z(20)*Z(114) - Z(19)*Z(112)
      Z(815) = Z(8)*Z(207) - Z(7)*Z(208)
      Z(616) = Z(12)*Z(606) - Z(11)*Z(608)
      Z(736) = Z(12)*Z(718) - Z(11)*Z(720)
      Z(780) = Z(12)*Z(770) - Z(11)*Z(772)
      Z(740) = Z(12)*Z(722) - Z(11)*Z(724)
      Z(968) = MRF*(2*Z(103)*Z(863)+2*Z(95)*Z(112)+2*Z(97)*Z(664)+2*Z(97
     &)*Z(889)+2*Z(102)*Z(842)+2*Z(102)*Z(924)-2*Z(682)*Z(564)-2*Z(873)*
     &Z(8)-2*Z(901)*Z(815)-2*Z(902)*Z(12)-2*Z(680)*Z(616)-2*Z(899)*Z(736
     &)-2*Z(900)*Z(780)-Z(99)*Z(740))
      Z(905) = Z(235) + Z(228)*U9 + Z(229)*U3 + Z(230)*U5 + Z(231)*U7 + 
     &Z(232)*U1 + Z(233)*U2 - Z(234)*U4
      Z(570) = ITH*LHp
      Z(571) = IUA*LSp
      Z(576) = ITH*RHp
      Z(577) = IUA*RSp
      Z(583) = Z(106)*Z(4) + Z(579)*Z(6) + 0.5D0*Z(99)*Z(161) + 0.5D0*Z(
     &99)*Z(256) - Z(102)*Z(20) - Z(102)*Z(22) - Z(578)*Z(33) - Z(97)*Z(
     &147) - Z(97)*Z(153) - Z(103)*Z(133) - Z(104)*Z(121) - Z(105)*Z(113
     &) - Z(580)*Z(139) - 0.5D0*Z(581)*Z(127)
      Z(942) = MHAT*Z(583)
      Z(584) = Z(321) + Z(316)*U9 + Z(317)*U3 + Z(317)*U5 + Z(318)*U7 + 
     &Z(319)*U1 + Z(320)*U2
      Z(138) = Z(1)*Z(41) + Z(2)*Z(42)
      Z(140) = Z(1)*Z(42) - Z(2)*Z(41)
      Z(591) = Z(5)*Z(138) - Z(6)*Z(140)
      Z(599) = Z(41)*Z(72) + Z(42)*Z(73)
      Z(601) = Z(41)*Z(74) + Z(42)*Z(75)
      Z(607) = -Z(15)*Z(599) - Z(16)*Z(601)
      Z(609) = Z(16)*Z(599) - Z(15)*Z(601)
      Z(611) = Z(27)*Z(607) + Z(28)*Z(609)
      Z(603) = Z(41)*Z(79) + Z(42)*Z(80)
      Z(595) = Z(22)*Z(140) - Z(21)*Z(138)
      Z(623) = Z(20)*Z(140) - Z(19)*Z(138)
      Z(615) = -Z(11)*Z(607) - Z(12)*Z(609)
      Z(619) = Z(3)*Z(138) - Z(4)*Z(140)
      Z(627) = Z(100)*Z(31) + 0.5D0*Z(99)*Z(562) + Z(101)*Z(591) + 0.5D0
     &*Z(99)*Z(611) - 0.5D0*Z(98)*Z(18) - Z(95)*Z(138) - Z(97)*Z(587) - 
     &Z(97)*Z(603) - Z(102)*Z(595) - Z(102)*Z(623) - Z(103)*Z(599) - Z(1
     &04)*Z(607) - Z(105)*Z(615) - Z(106)*Z(619)
      Z(944) = MFF*Z(627)
      Z(628) = Z(39)*U1 + Z(40)*U2
      Z(88) = Z(26)*Z(83) - Z(25)*Z(85)
      Z(152) = Z(1)*Z(88) + Z(2)*Z(89)
      Z(588) = Z(39)*Z(88) + Z(40)*Z(89)
      Z(589) = Z(41)*Z(88) + Z(42)*Z(89)
      Z(631) = -Z(17)*Z(588) - Z(18)*Z(589)
      Z(633) = Z(18)*Z(588) - Z(17)*Z(589)
      Z(635) = Z(27)*Z(631) + Z(28)*Z(633)
      Z(647) = Z(72)*Z(88) + Z(73)*Z(89)
      Z(649) = Z(74)*Z(88) + Z(75)*Z(89)
      Z(655) = -Z(15)*Z(647) - Z(16)*Z(649)
      Z(657) = Z(16)*Z(647) - Z(15)*Z(649)
      Z(659) = Z(27)*Z(655) + Z(28)*Z(657)
      Z(651) = Z(79)*Z(88) + Z(80)*Z(89)
      Z(154) = Z(1)*Z(89) - Z(2)*Z(88)
      Z(671) = Z(20)*Z(154) - Z(19)*Z(152)
      Z(663) = -Z(11)*Z(655) - Z(12)*Z(657)
      Z(667) = Z(3)*Z(152) - Z(4)*Z(154)
      Z(639) = -Z(13)*Z(631) - Z(14)*Z(633)
      Z(643) = Z(5)*Z(152) - Z(6)*Z(154)
      Z(677) = Z(675)*Z(26) + Z(674)*Z(152) + 0.5D0*Z(99)*Z(635) + 0.5D0
     &*Z(99)*Z(659) - Z(97)*Z(651) - Z(102)*Z(671) - Z(103)*Z(647) - Z(1
     &04)*Z(655) - Z(105)*Z(663) - Z(106)*Z(667) - Z(578)*Z(639) - Z(579
     &)*Z(643) - Z(580)*Z(588) - 0.5D0*Z(581)*Z(631)
      Z(946) = MLA*Z(677)
      Z(678) = Z(402) + Z(395)*U9 + Z(396)*U7 + Z(397)*U5 + Z(398)*U3 + 
     &Z(399)*U1 + Z(400)*U2 - Z(401)*U11
      Z(763) = Z(37)*Z(72) + Z(38)*Z(73)
      Z(765) = Z(37)*Z(74) + Z(38)*Z(75)
      Z(771) = -Z(15)*Z(763) - Z(16)*Z(765)
      Z(773) = Z(16)*Z(763) - Z(15)*Z(765)
      Z(775) = Z(27)*Z(771) + Z(28)*Z(773)
      Z(759) = Z(22)*Z(32) - Z(21)*Z(34)
      Z(787) = Z(20)*Z(32) - Z(19)*Z(34)
      Z(783) = Z(3)*Z(34) - Z(4)*Z(32)
      Z(640) = Z(14)*Z(630) - Z(13)*Z(632)
      Z(767) = Z(37)*Z(79) + Z(38)*Z(80)
      Z(779) = -Z(11)*Z(771) - Z(12)*Z(773)
      Z(791) = Z(101)*Z(10) + 0.5D0*Z(99)*Z(44) + 0.5D0*Z(99)*Z(775) - Z
     &(95)*Z(34) - Z(102)*Z(759) - Z(102)*Z(787) - Z(106)*Z(783) - Z(580
     &)*Z(30) - 0.5D0*Z(581)*Z(14) - Z(97)*Z(640) - Z(97)*Z(767) - Z(103
     &)*Z(763) - Z(104)*Z(771) - Z(105)*Z(779)
      Z(954) = MSH*Z(791)
      Z(792) = Z(179) + Z(176)*U3 + Z(176)*U5 + Z(176)*U7 + Z(176)*U9 + 
     &Z(177)*U1 + Z(178)*U2
      Z(692) = Z(5)*Z(161) + Z(6)*Z(159)
      Z(56) = Z(6)*Z(1) - Z(5)*Z(2)
      Z(798) = Z(54)*Z(73) + Z(56)*Z(72)
      Z(800) = Z(54)*Z(75) + Z(56)*Z(74)
      Z(806) = -Z(15)*Z(798) - Z(16)*Z(800)
      Z(808) = Z(16)*Z(798) - Z(15)*Z(800)
      Z(810) = Z(27)*Z(806) + Z(28)*Z(808)
      Z(795) = Z(5)*Z(22) - Z(6)*Z(21)
      Z(818) = Z(5)*Z(20) - Z(6)*Z(19)
      Z(814) = -Z(7)*Z(209) - Z(8)*Z(207)
      Z(644) = Z(5)*Z(153) + Z(6)*Z(151)
      Z(802) = Z(54)*Z(80) + Z(56)*Z(79)
      Z(592) = Z(5)*Z(139) + Z(6)*Z(137)
      Z(688) = Z(5)*Z(127) + Z(6)*Z(125)
      Z(821) = Z(578)*Z(10) + 0.5D0*Z(99)*Z(692) + 0.5D0*Z(99)*Z(810) - 
     &Z(95)*Z(6) - Z(102)*Z(795) - Z(102)*Z(818) - Z(105)*Z(814) - Z(106
     &)*Z(209) - Z(97)*Z(644) - Z(97)*Z(802) - Z(103)*Z(798) - Z(104)*Z(
     &806) - Z(580)*Z(592) - 0.5D0*Z(581)*Z(688)
      Z(956) = MTH*Z(821)
      Z(822) = Z(195) + Z(191)*U9 + Z(192)*U3 + Z(192)*U5 + Z(192)*U7 + 
     &Z(193)*U1 + Z(194)*U2
      Z(700) = -Z(21)*Z(161) - Z(22)*Z(159)
      Z(825) = Z(72)*Z(85) + Z(73)*Z(83)
      Z(827) = Z(74)*Z(85) + Z(75)*Z(83)
      Z(833) = -Z(15)*Z(825) - Z(16)*Z(827)
      Z(835) = Z(16)*Z(825) - Z(15)*Z(827)
      Z(837) = Z(27)*Z(833) + Z(28)*Z(835)
      Z(848) = Z(19)*Z(22) - Z(20)*Z(21)
      Z(845) = Z(4)*Z(21) - Z(3)*Z(22)
      Z(760) = -Z(21)*Z(33) - Z(22)*Z(32)
      Z(796) = Z(6)*Z(21) - Z(5)*Z(22)
      Z(829) = Z(79)*Z(85) + Z(80)*Z(83)
      Z(841) = -Z(11)*Z(833) - Z(12)*Z(835)
      Z(596) = -Z(21)*Z(139) - Z(22)*Z(137)
      Z(696) = -Z(21)*Z(127) - Z(22)*Z(125)
      Z(851) = Z(97)*Z(26) + 0.5D0*Z(99)*Z(700) + 0.5D0*Z(99)*Z(837) - Z
     &(102)*Z(848) - Z(106)*Z(845) - Z(578)*Z(760) - Z(579)*Z(796) - Z(6
     &74)*Z(22) - Z(97)*Z(829) - Z(103)*Z(825) - Z(104)*Z(833) - Z(105)*
     &Z(841) - Z(580)*Z(596) - 0.5D0*Z(581)*Z(696)
      Z(958) = MUA*Z(851)
      Z(852) = Z(381) + Z(375)*U9 + Z(376)*U7 + Z(377)*U5 + Z(378)*U3 + 
     &Z(379)*U1 + Z(380)*U2
      Z(862) = Z(11)*Z(16) + Z(12)*Z(15)
      Z(859) = -Z(27)*Z(16) - Z(28)*Z(15)
      Z(132) = Z(1)*Z(74) + Z(2)*Z(75)
      Z(134) = Z(1)*Z(75) - Z(2)*Z(74)
      Z(865) = Z(3)*Z(132) - Z(4)*Z(134)
      Z(869) = Z(20)*Z(134) - Z(19)*Z(132)
      Z(876) = Z(872)*Z(862) + 0.5D0*Z(99)*Z(859) + Z(873)*Z(865) + 0.5D
     &0*Z(99)*Z(708) - Z(874)*Z(16) - Z(95)*Z(132) - Z(97)*Z(648) - Z(97
     &)*Z(855) - Z(102)*Z(826) - Z(102)*Z(869) - Z(578)*Z(764) - Z(579)*
     &Z(799) - Z(580)*Z(600) - 0.5D0*Z(581)*Z(704)
      Z(960) = MFF*Z(876)
      Z(877) = Z(292) + Z(283)*U8 + Z(284)*U9 + Z(285)*U5 + Z(286)*U7 + 
     &Z(287)*U3 + Z(288)*U4 + Z(289)*U6 + Z(290)*U1 + Z(291)*U2
      Z(81) = Z(24)*Z(76) - Z(23)*Z(78)
      Z(146) = Z(1)*Z(81) + Z(2)*Z(82)
      Z(716) = Z(46)*Z(81) + Z(47)*Z(82)
      Z(856) = Z(72)*Z(81) + Z(73)*Z(82)
      Z(857) = Z(74)*Z(81) + Z(75)*Z(82)
      Z(880) = -Z(15)*Z(856) - Z(16)*Z(857)
      Z(882) = Z(16)*Z(856) - Z(15)*Z(857)
      Z(884) = Z(27)*Z(880) + Z(28)*Z(882)
      Z(652) = Z(81)*Z(86) + Z(82)*Z(87)
      Z(830) = Z(81)*Z(83) + Z(82)*Z(84)
      Z(888) = -Z(11)*Z(880) - Z(12)*Z(882)
      Z(148) = Z(1)*Z(82) - Z(2)*Z(81)
      Z(892) = Z(3)*Z(146) - Z(4)*Z(148)
      Z(768) = Z(35)*Z(81) + Z(36)*Z(82)
      Z(803) = Z(54)*Z(81) + Z(55)*Z(82)
      Z(604) = Z(39)*Z(81) + Z(40)*Z(82)
      Z(712) = Z(50)*Z(81) + Z(51)*Z(82)
      Z(896) = Z(675)*Z(24) + Z(674)*Z(146) + 0.5D0*Z(99)*Z(716) + 0.5D0
     &*Z(99)*Z(884) - Z(97)*Z(652) - Z(102)*Z(830) - Z(103)*Z(856) - Z(1
     &04)*Z(880) - Z(105)*Z(888) - Z(106)*Z(892) - Z(578)*Z(768) - Z(579
     &)*Z(803) - Z(580)*Z(604) - 0.5D0*Z(581)*Z(712)
      Z(962) = MLA*Z(896)
      Z(897) = Z(357) + Z(350)*U9 + Z(351)*U7 + Z(352)*U5 + Z(353)*U3 + 
     &Z(354)*U1 + Z(355)*U2 - Z(356)*U10
      Z(928) = Z(873)*Z(8) + 0.5D0*Z(99)*Z(564) + 0.5D0*Z(99)*Z(740) - Z
     &(103)*Z(863) - Z(104)*Z(12) - Z(579)*Z(815) - Z(95)*Z(112) - Z(97)
     &*Z(664) - Z(97)*Z(889) - Z(102)*Z(842) - Z(102)*Z(924) - Z(578)*Z(
     &780) - Z(580)*Z(616) - 0.5D0*Z(581)*Z(736)
      Z(970) = MSH*Z(928)
      Z(748) = Z(3)*Z(161) + Z(4)*Z(159)
      Z(913) = Z(3)*Z(256) + Z(4)*Z(254)
      Z(846) = Z(3)*Z(22) - Z(4)*Z(21)
      Z(931) = Z(3)*Z(20) - Z(4)*Z(19)
      Z(784) = Z(3)*Z(33) + Z(4)*Z(32)
      Z(668) = Z(3)*Z(153) + Z(4)*Z(151)
      Z(893) = Z(3)*Z(147) + Z(4)*Z(145)
      Z(866) = Z(3)*Z(133) + Z(4)*Z(131)
      Z(909) = Z(3)*Z(121) + Z(4)*Z(119)
      Z(620) = Z(3)*Z(139) + Z(4)*Z(137)
      Z(744) = Z(3)*Z(127) + Z(4)*Z(125)
      Z(934) = Z(105)*Z(8) + 0.5D0*Z(99)*Z(748) + 0.5D0*Z(99)*Z(913) - Z
     &(95)*Z(4) - Z(102)*Z(846) - Z(102)*Z(931) - Z(578)*Z(784) - Z(579)
     &*Z(208) - Z(97)*Z(668) - Z(97)*Z(893) - Z(103)*Z(866) - Z(104)*Z(9
     &09) - Z(580)*Z(620) - 0.5D0*Z(581)*Z(744)
      Z(972) = MTH*Z(934)
      Z(935) = Z(215) + Z(210)*U9 + Z(211)*U3 + Z(211)*U5 + Z(212)*U7 + 
     &Z(213)*U1 + Z(214)*U2
      Z(756) = -Z(19)*Z(161) - Z(20)*Z(159)
      Z(921) = -Z(19)*Z(256) - Z(20)*Z(254)
      Z(849) = Z(20)*Z(21) - Z(19)*Z(22)
      Z(932) = Z(4)*Z(19) - Z(3)*Z(20)
      Z(788) = -Z(19)*Z(33) - Z(20)*Z(32)
      Z(819) = Z(6)*Z(19) - Z(5)*Z(20)
      Z(672) = -Z(19)*Z(153) - Z(20)*Z(151)
      Z(870) = -Z(19)*Z(133) - Z(20)*Z(131)
      Z(917) = -Z(19)*Z(121) - Z(20)*Z(119)
      Z(925) = -Z(19)*Z(113) - Z(20)*Z(111)
      Z(624) = -Z(19)*Z(139) - Z(20)*Z(137)
      Z(752) = -Z(19)*Z(127) - Z(20)*Z(125)
      Z(938) = Z(97)*Z(24) + 0.5D0*Z(99)*Z(756) + 0.5D0*Z(99)*Z(921) - Z
     &(102)*Z(849) - Z(106)*Z(932) - Z(578)*Z(788) - Z(579)*Z(819) - Z(6
     &74)*Z(20) - Z(97)*Z(672) - Z(103)*Z(870) - Z(104)*Z(917) - Z(105)*
     &Z(925) - Z(580)*Z(624) - 0.5D0*Z(581)*Z(752)
      Z(974) = MUA*Z(938)
      Z(939) = Z(336) + Z(330)*U9 + Z(331)*U7 + Z(332)*U5 + Z(333)*U3 + 
     &Z(334)*U1 + Z(335)*U2
      Z(948) = MRF*(2*Z(100)*Z(31)+2*Z(682)*Z(562)+Z(99)*Z(611)+2*Z(101)
     &*Z(591)-2*Z(681)*Z(18)-2*Z(95)*Z(138)-2*Z(97)*Z(587)-2*Z(97)*Z(603
     &)-2*Z(102)*Z(595)-2*Z(102)*Z(623)-2*Z(103)*Z(599)-2*Z(104)*Z(607)-
     &2*Z(105)*Z(615)-2*Z(106)*Z(619))
      Z(964) = MRF*(2*Z(872)*Z(11)+2*Z(95)*Z(119)+2*Z(97)*Z(654)+2*Z(97)
     &*Z(879)+2*Z(102)*Z(832)+2*Z(102)*Z(915)-2*Z(902)-2*Z(963)-2*Z(103)
     &*Z(15)-2*Z(680)*Z(606)-2*Z(873)*Z(907)-2*Z(899)*Z(718)-2*Z(900)*Z(
     &770)-2*Z(901)*Z(805)-Z(99)*Z(722))
      Z(903) = Z(258) + Z(91)*U3 + Z(91)*U4 + Z(91)*U6 + Z(91)*U8
      Z(966) = MRF*(2*Z(103)*Z(858)+2*Z(95)*Z(254)+2*Z(97)*Z(658)+2*Z(97
     &)*Z(883)+2*Z(102)*Z(836)+2*Z(102)*Z(919)-2*Z(682)-2*Z(965)-2*Z(872
     &)*Z(563)-2*Z(680)*Z(610)-2*Z(873)*Z(911)-2*Z(899)*Z(726)-2*Z(900)*
     &Z(774)-2*Z(901)*Z(809)-Z(99)*Z(730))
      Z(904) = -0.5D0*Z(259) - 0.5D0*LRFFO*U3 - 0.5D0*LRFFO*U4 - 0.5D0*L
     &RFFO*U6 - 0.5D0*LRFFO*U8
      Z(967) = MRF*(2*Z(103)*Z(861)+2*Z(873)*Z(7)+2*Z(902)*Z(11)+2*Z(95)
     &*Z(111)+2*Z(97)*Z(662)+2*Z(97)*Z(887)+2*Z(102)*Z(840)+2*Z(102)*Z(9
     &23)-2*Z(872)-2*Z(682)*Z(563)-2*Z(901)*Z(813)-2*Z(680)*Z(614)-2*Z(8
     &99)*Z(734)-2*Z(900)*Z(778)-Z(99)*Z(738))
      Z(906) = Z(252) + LSH*U6 + Z(236)*U9 + Z(238)*U5 + Z(239)*U7 + Z(2
     &50)*U3 + Z(251)*U4 + Z(240)*U1 + Z(241)*U2
      HZ = Z(566) + Z(567) + Z(568) + Z(569) + Z(572) + Z(573) + Z(574) 
     &+ Z(575) + IFF*U4 + IFF*U5 + IFF*U6 + IFF*U7 + IFF*U8 + IFF*U9 + I
     &HAT*U3 + ILA*U10 + ILA*U11 + ILA*U12 + ILA*U13 + IRF*U4 + IRF*U5 +
     & IRF*U6 + IRF*U7 + IRF*U8 + IRF*U9 + ISH*U4 + ISH*U5 + ISH*U6 + IS
     &H*U7 + ITH*U4 + ITH*U5 + IUA*U10 + IUA*U11 + 2*IFF*U3 + 2*ILA*U3 +
     & 2*IRF*U3 + 2*ISH*U3 + 2*ITH*U3 + 2*IUA*U3 + Z(941)*Z(585) + Z(943
     &)*Z(629) + Z(945)*Z(679) + Z(953)*Z(793) + Z(955)*Z(823) + Z(957)*
     &Z(853) + Z(959)*Z(878) + Z(961)*Z(898) + Z(969)*Z(929) + Z(971)*Z(
     &936) + Z(973)*Z(940) + 0.5D0*Z(947)*Z(683) + 0.5D0*Z(950)*Z(684) +
     & 0.5D0*Z(952)*Z(685) + 0.5D0*Z(968)*Z(905) - Z(570) - Z(571) - Z(5
     &76) - Z(577) - Z(942)*Z(584) - Z(944)*Z(628) - Z(946)*Z(678) - Z(9
     &54)*Z(792) - Z(956)*Z(822) - Z(958)*Z(852) - Z(960)*Z(877) - Z(962
     &)*Z(897) - Z(970)*Z(905) - Z(972)*Z(935) - Z(974)*Z(939) - 0.5D0*Z
     &(948)*Z(628) - 0.5D0*Z(964)*Z(903) - 0.5D0*Z(966)*Z(904) - 0.5D0*Z
     &(967)*Z(906)
      Z(988) = MFF*Z(39)
      Z(989) = MFF*Z(40)
      Z(1011) = MRF*Z(39)
      Z(1012) = MRF*Z(40)
      Z(1093) = MRF*Z(258)
      Z(980) = MHAT*Z(321)
      Z(975) = MHAT*Z(316)
      Z(976) = MHAT*Z(317)
      Z(977) = MHAT*Z(318)
      Z(978) = MHAT*Z(319)
      Z(979) = MHAT*Z(320)
      Z(1024) = MSH*Z(179)
      Z(1021) = MSH*Z(176)
      Z(1022) = MSH*Z(177)
      Z(1023) = MSH*Z(178)
      Z(1029) = MSH*Z(187)
      Z(1025) = MSH*Z(180)
      Z(1026) = MSH*Z(186)
      Z(1027) = MSH*Z(181)
      Z(1028) = MSH*Z(182)
      Z(1034) = MTH*Z(195)
      Z(1030) = MTH*Z(191)
      Z(1031) = MTH*Z(192)
      Z(1032) = MTH*Z(193)
      Z(1033) = MTH*Z(194)
      Z(1040) = MTH*Z(203)
      Z(1035) = MTH*Z(196)
      Z(1036) = MTH*Z(197)
      Z(1037) = MTH*Z(202)
      Z(1038) = MTH*Z(198)
      Z(1039) = MTH*Z(199)
      Z(1134) = MTH*Z(215)
      Z(1129) = MTH*Z(210)
      Z(1130) = MTH*Z(211)
      Z(1131) = MTH*Z(212)
      Z(1132) = MTH*Z(213)
      Z(1133) = MTH*Z(214)
      Z(1149) = MUA*Z(336)
      Z(1143) = MUA*Z(330)
      Z(1144) = MUA*Z(331)
      Z(1145) = MUA*Z(332)
      Z(1146) = MUA*Z(333)
      Z(1147) = MUA*Z(334)
      Z(1148) = MUA*Z(335)
      Z(1047) = MUA*Z(381)
      Z(1041) = MUA*Z(375)
      Z(1042) = MUA*Z(376)
      Z(1043) = MUA*Z(377)
      Z(1044) = MUA*Z(378)
      Z(1045) = MUA*Z(379)
      Z(1046) = MUA*Z(380)
      Z(1142) = MTH*Z(224)
      Z(1136) = MTH*Z(216)
      Z(1137) = MTH*Z(217)
      Z(1138) = MTH*Z(218)
      Z(1139) = MTH*Z(223)
      Z(1140) = MTH*Z(219)
      Z(1141) = MTH*Z(220)
      Z(1156) = MUA*Z(346)
      Z(1150) = MUA*Z(337)
      Z(1151) = MUA*Z(338)
      Z(1152) = MUA*Z(339)
      Z(1153) = MUA*Z(345)
      Z(1154) = MUA*Z(341)
      Z(1155) = MUA*Z(342)
      Z(1055) = MUA*Z(391)
      Z(1049) = MUA*Z(382)
      Z(1050) = MUA*Z(383)
      Z(1051) = MUA*Z(384)
      Z(1052) = MUA*Z(390)
      Z(1053) = MUA*Z(386)
      Z(1054) = MUA*Z(387)
      Z(1091) = MLA*Z(370)
      Z(1084) = MLA*Z(358)
      Z(1085) = MLA*Z(359)
      Z(1086) = MLA*Z(360)
      Z(1087) = MLA*Z(368)
      Z(1088) = MLA*Z(369)
      Z(1089) = MLA*Z(362)
      Z(1090) = MLA*Z(363)
      Z(1010) = MLA*Z(415)
      Z(1003) = MLA*Z(403)
      Z(1004) = MLA*Z(404)
      Z(1005) = MLA*Z(405)
      Z(1006) = MLA*Z(413)
      Z(1007) = MLA*Z(414)
      Z(1008) = MLA*Z(407)
      Z(1009) = MLA*Z(408)
      Z(1065) = MFF*Z(292)
      Z(1056) = MFF*Z(283)
      Z(1057) = MFF*Z(284)
      Z(1058) = MFF*Z(285)
      Z(1059) = MFF*Z(286)
      Z(1060) = MFF*Z(287)
      Z(1061) = MFF*Z(288)
      Z(1062) = MFF*Z(289)
      Z(1063) = MFF*Z(290)
      Z(1064) = MFF*Z(291)
      Z(1075) = MFF*Z(309)
      Z(1066) = MFF*Z(294)
      Z(1067) = MFF*Z(295)
      Z(1068) = MFF*Z(296)
      Z(1069) = MFF*Z(305)
      Z(1070) = MFF*Z(306)
      Z(1071) = MFF*Z(307)
      Z(1072) = MFF*Z(308)
      Z(1073) = MFF*Z(299)
      Z(1074) = MFF*Z(300)
      Z(1111) = MRF*Z(252)
      Z(1128) = MSH*Z(248)
      Z(1104) = MRF*Z(236)
      Z(1105) = MRF*Z(238)
      Z(1106) = MRF*Z(239)
      Z(1107) = MRF*Z(250)
      Z(1108) = MRF*Z(251)
      Z(1121) = MSH*Z(236)
      Z(1122) = MSH*Z(238)
      Z(1123) = MSH*Z(239)
      Z(1124) = MSH*Z(246)
      Z(1125) = MSH*Z(247)
      Z(1109) = MRF*Z(240)
      Z(1110) = MRF*Z(241)
      Z(1126) = MSH*Z(240)
      Z(1127) = MSH*Z(241)
      Z(48) = Z(43)*Z(37) + Z(45)*Z(35)
      Z(1020) = MRF*Z(164)
      Z(52) = -Z(13)*Z(37) - Z(14)*Z(35)
      Z(1018) = MRF*Z(163)
      Z(70) = Z(27)*Z(66) - Z(28)*Z(64)
      Z(1094) = MRF*Z(259)
      Z(987) = MHAT*Z(327)
      Z(981) = MHAT*Z(322)
      Z(982) = MHAT*Z(323)
      Z(983) = MHAT*Z(324)
      Z(984) = MHAT*Z(328)
      Z(985) = MHAT*Z(325)
      Z(986) = MHAT*Z(326)
      Z(1082) = MLA*Z(356)
      Z(1083) = MLA*Z(357)
      Z(1076) = MLA*Z(350)
      Z(1077) = MLA*Z(351)
      Z(1078) = MLA*Z(352)
      Z(1079) = MLA*Z(353)
      Z(1080) = MLA*Z(354)
      Z(1081) = MLA*Z(355)
      Z(1000) = MLA*Z(401)
      Z(1001) = MLA*Z(402)
      Z(994) = MLA*Z(395)
      Z(995) = MLA*Z(396)
      Z(996) = MLA*Z(397)
      Z(997) = MLA*Z(398)
      Z(998) = MLA*Z(399)
      Z(999) = MLA*Z(400)
      Z(993) = MFF*Z(156)
      Z(1016) = MRF*Z(157)
      Z(990) = MFF*Z(41)
      Z(991) = MFF*Z(42)
      Z(1013) = MRF*Z(41)
      Z(1014) = MRF*Z(42)
      Z(1101) = MRF*Z(234)
      Z(1118) = MSH*Z(234)
      Z(1102) = MRF*Z(235)
      Z(1119) = MSH*Z(235)
      Z(1095) = MRF*Z(228)
      Z(1096) = MRF*Z(229)
      Z(1097) = MRF*Z(230)
      Z(1098) = MRF*Z(231)
      Z(1112) = MSH*Z(228)
      Z(1113) = MSH*Z(229)
      Z(1114) = MSH*Z(230)
      Z(1115) = MSH*Z(231)
      Z(1099) = MRF*Z(232)
      Z(1100) = MRF*Z(233)
      Z(1116) = MSH*Z(232)
      Z(1117) = MSH*Z(233)
      PX = Z(39)*(Z(988)*U1+Z(989)*U2+Z(1011)*U1+Z(1012)*U2) + Z(66)*(Z(
     &1093)+Z(1092)*U3+Z(1092)*U4+Z(1092)*U6+Z(1092)*U8) + Z(1)*(Z(980)+
     &Z(975)*U9+Z(976)*U3+Z(976)*U5+Z(977)*U7+Z(978)*U1+Z(979)*U2) + Z(3
     &5)*(Z(1024)+Z(1021)*U3+Z(1021)*U5+Z(1021)*U7+Z(1021)*U9+Z(1022)*U1
     &+Z(1023)*U2) + Z(37)*(Z(1029)+Z(1025)*U9+Z(1026)*U3+Z(1026)*U5+Z(1
     &026)*U7+Z(1027)*U1+Z(1028)*U2) + Z(54)*(Z(1034)+Z(1030)*U9+Z(1031)
     &*U3+Z(1031)*U5+Z(1031)*U7+Z(1032)*U1+Z(1033)*U2) + Z(56)*(Z(1040)+
     &Z(1035)*U9+Z(1036)*U7+Z(1037)*U3+Z(1037)*U5+Z(1038)*U1+Z(1039)*U2)
     & + Z(57)*(Z(1134)+Z(1129)*U9+Z(1130)*U3+Z(1130)*U5+Z(1131)*U7+Z(11
     &32)*U1+Z(1133)*U2) + Z(76)*(Z(1149)+Z(1143)*U9+Z(1144)*U7+Z(1145)*
     &U5+Z(1146)*U3+Z(1147)*U1+Z(1148)*U2) + Z(83)*(Z(1047)+Z(1041)*U9+Z
     &(1042)*U7+Z(1043)*U5+Z(1044)*U3+Z(1045)*U1+Z(1046)*U2) + Z(59)*(Z(
     &1142)+Z(1135)*U4+Z(1136)*U9+Z(1137)*U7+Z(1138)*U5+Z(1139)*U3+Z(114
     &0)*U1+Z(1141)*U2) + Z(78)*(Z(1156)+Z(1048)*U10+Z(1150)*U9+Z(1151)*
     &U7+Z(1152)*U5+Z(1153)*U3+Z(1154)*U1+Z(1155)*U2) + Z(85)*(Z(1055)+Z
     &(1048)*U11+Z(1049)*U9+Z(1050)*U7+Z(1051)*U5+Z(1052)*U3+Z(1053)*U1+
     &Z(1054)*U2) + Z(81)*(Z(1091)+Z(1002)*U12+Z(1084)*U9+Z(1085)*U7+Z(1
     &086)*U5+Z(1087)*U10+Z(1088)*U3+Z(1089)*U1+Z(1090)*U2) + Z(88)*(Z(1
     &010)+Z(1002)*U13+Z(1003)*U9+Z(1004)*U7+Z(1005)*U5+Z(1006)*U11+Z(10
     &07)*U3+Z(1008)*U1+Z(1009)*U2) + Z(72)*(Z(1065)+Z(1056)*U8+Z(1057)*
     &U9+Z(1058)*U5+Z(1059)*U7+Z(1060)*U3+Z(1061)*U4+Z(1062)*U6+Z(1063)*
     &U1+Z(1064)*U2) + Z(74)*(Z(1075)+Z(1066)*U9+Z(1067)*U5+Z(1068)*U7+Z
     &(1069)*U3+Z(1070)*U4+Z(1071)*U6+Z(1072)*U8+Z(1073)*U1+Z(1074)*U2) 
     &+ Z(62)*(Z(1111)+Z(1128)+Z(1103)*U6+Z(1120)*U6+Z(1104)*U9+Z(1105)*
     &U5+Z(1106)*U7+Z(1107)*U3+Z(1108)*U4+Z(1121)*U9+Z(1122)*U5+Z(1123)*
     &U7+Z(1124)*U3+Z(1125)*U4+Z(1109)*U1+Z(1110)*U2+Z(1126)*U1+Z(1127)*
     &U2) - 0.5D0*Z(48)*(Z(1020)+Z(1019)*U3+Z(1019)*U5+Z(1019)*U7+Z(1019
     &)*U9) - 0.5D0*Z(52)*(Z(1018)+Z(1017)*U3+Z(1017)*U5+Z(1017)*U7+Z(10
     &17)*U9) - 0.5D0*Z(70)*(Z(1094)+Z(1019)*U3+Z(1019)*U4+Z(1019)*U6+Z(
     &1019)*U8) - Z(2)*(Z(987)+Z(981)*U9+Z(982)*U7+Z(983)*U5+Z(984)*U3+Z
     &(985)*U1+Z(986)*U2) - Z(79)*(Z(1082)*U10-Z(1083)-Z(1076)*U9-Z(1077
     &)*U7-Z(1078)*U5-Z(1079)*U3-Z(1080)*U1-Z(1081)*U2) - Z(86)*(Z(1000)
     &*U11-Z(1001)-Z(994)*U9-Z(995)*U7-Z(996)*U5-Z(997)*U3-Z(998)*U1-Z(9
     &99)*U2) - Z(41)*(Z(993)+Z(1016)+Z(992)*U3+Z(992)*U5+Z(992)*U7+Z(99
     &2)*U9+Z(1015)*U3+Z(1015)*U5+Z(1015)*U7+Z(1015)*U9-Z(990)*U1-Z(991)
     &*U2-Z(1013)*U1-Z(1014)*U2) - Z(60)*(Z(1101)*U4+Z(1118)*U4-Z(1102)-
     &Z(1119)-Z(1095)*U9-Z(1096)*U3-Z(1097)*U5-Z(1098)*U7-Z(1112)*U9-Z(1
     &113)*U3-Z(1114)*U5-Z(1115)*U7-Z(1099)*U1-Z(1100)*U2-Z(1116)*U1-Z(1
     &117)*U2)
      PY = Z(40)*(Z(988)*U1+Z(989)*U2+Z(1011)*U1+Z(1012)*U2) + Z(67)*(Z(
     &1093)+Z(1092)*U3+Z(1092)*U4+Z(1092)*U6+Z(1092)*U8) + Z(1)*(Z(987)+
     &Z(981)*U9+Z(982)*U7+Z(983)*U5+Z(984)*U3+Z(985)*U1+Z(986)*U2) + Z(2
     &)*(Z(980)+Z(975)*U9+Z(976)*U3+Z(976)*U5+Z(977)*U7+Z(978)*U1+Z(979)
     &*U2) + Z(36)*(Z(1024)+Z(1021)*U3+Z(1021)*U5+Z(1021)*U7+Z(1021)*U9+
     &Z(1022)*U1+Z(1023)*U2) + Z(38)*(Z(1029)+Z(1025)*U9+Z(1026)*U3+Z(10
     &26)*U5+Z(1026)*U7+Z(1027)*U1+Z(1028)*U2) + Z(54)*(Z(1040)+Z(1035)*
     &U9+Z(1036)*U7+Z(1037)*U3+Z(1037)*U5+Z(1038)*U1+Z(1039)*U2) + Z(55)
     &*(Z(1034)+Z(1030)*U9+Z(1031)*U3+Z(1031)*U5+Z(1031)*U7+Z(1032)*U1+Z
     &(1033)*U2) + Z(58)*(Z(1134)+Z(1129)*U9+Z(1130)*U3+Z(1130)*U5+Z(113
     &1)*U7+Z(1132)*U1+Z(1133)*U2) + Z(77)*(Z(1149)+Z(1143)*U9+Z(1144)*U
     &7+Z(1145)*U5+Z(1146)*U3+Z(1147)*U1+Z(1148)*U2) + Z(84)*(Z(1047)+Z(
     &1041)*U9+Z(1042)*U7+Z(1043)*U5+Z(1044)*U3+Z(1045)*U1+Z(1046)*U2) +
     & Z(57)*(Z(1142)+Z(1135)*U4+Z(1136)*U9+Z(1137)*U7+Z(1138)*U5+Z(1139
     &)*U3+Z(1140)*U1+Z(1141)*U2) + Z(76)*(Z(1156)+Z(1048)*U10+Z(1150)*U
     &9+Z(1151)*U7+Z(1152)*U5+Z(1153)*U3+Z(1154)*U1+Z(1155)*U2) + Z(83)*
     &(Z(1055)+Z(1048)*U11+Z(1049)*U9+Z(1050)*U7+Z(1051)*U5+Z(1052)*U3+Z
     &(1053)*U1+Z(1054)*U2) + Z(82)*(Z(1091)+Z(1002)*U12+Z(1084)*U9+Z(10
     &85)*U7+Z(1086)*U5+Z(1087)*U10+Z(1088)*U3+Z(1089)*U1+Z(1090)*U2) + 
     &Z(89)*(Z(1010)+Z(1002)*U13+Z(1003)*U9+Z(1004)*U7+Z(1005)*U5+Z(1006
     &)*U11+Z(1007)*U3+Z(1008)*U1+Z(1009)*U2) + Z(73)*(Z(1065)+Z(1056)*U
     &8+Z(1057)*U9+Z(1058)*U5+Z(1059)*U7+Z(1060)*U3+Z(1061)*U4+Z(1062)*U
     &6+Z(1063)*U1+Z(1064)*U2) + Z(75)*(Z(1075)+Z(1066)*U9+Z(1067)*U5+Z(
     &1068)*U7+Z(1069)*U3+Z(1070)*U4+Z(1071)*U6+Z(1072)*U8+Z(1073)*U1+Z(
     &1074)*U2) + Z(63)*(Z(1111)+Z(1128)+Z(1103)*U6+Z(1120)*U6+Z(1104)*U
     &9+Z(1105)*U5+Z(1106)*U7+Z(1107)*U3+Z(1108)*U4+Z(1121)*U9+Z(1122)*U
     &5+Z(1123)*U7+Z(1124)*U3+Z(1125)*U4+Z(1109)*U1+Z(1110)*U2+Z(1126)*U
     &1+Z(1127)*U2) - 0.5D0*Z(49)*(Z(1020)+Z(1019)*U3+Z(1019)*U5+Z(1019)
     &*U7+Z(1019)*U9) - 0.5D0*Z(53)*(Z(1018)+Z(1017)*U3+Z(1017)*U5+Z(101
     &7)*U7+Z(1017)*U9) - 0.5D0*Z(71)*(Z(1094)+Z(1019)*U3+Z(1019)*U4+Z(1
     &019)*U6+Z(1019)*U8) - Z(80)*(Z(1082)*U10-Z(1083)-Z(1076)*U9-Z(1077
     &)*U7-Z(1078)*U5-Z(1079)*U3-Z(1080)*U1-Z(1081)*U2) - Z(87)*(Z(1000)
     &*U11-Z(1001)-Z(994)*U9-Z(995)*U7-Z(996)*U5-Z(997)*U3-Z(998)*U1-Z(9
     &99)*U2) - Z(42)*(Z(993)+Z(1016)+Z(992)*U3+Z(992)*U5+Z(992)*U7+Z(99
     &2)*U9+Z(1015)*U3+Z(1015)*U5+Z(1015)*U7+Z(1015)*U9-Z(990)*U1-Z(991)
     &*U2-Z(1013)*U1-Z(1014)*U2) - Z(61)*(Z(1101)*U4+Z(1118)*U4-Z(1102)-
     &Z(1119)-Z(1095)*U9-Z(1096)*U3-Z(1097)*U5-Z(1098)*U7-Z(1112)*U9-Z(1
     &113)*U3-Z(1114)*U5-Z(1115)*U7-Z(1099)*U1-Z(1100)*U2-Z(1116)*U1-Z(1
     &117)*U2)
      Z(1220) = Z(1187) + Z(1189) + Z(1190) + Z(1135)*Z(470) + MFF*(Z(28
     &8)*Z(497)+Z(306)*Z(498)) - Z(1191) - MSH*(Z(234)*Z(478)-Z(247)*Z(4
     &79)) - 0.25D0*MRF*(2*Z(1207)*Z(483)+2*Z(1211)*Z(484)+2*Z(251)*Z(56
     &3)*Z(484)+4*Z(11)*Z(251)*Z(483)+2*Z(1209)*Z(486)+4*Z(234)*Z(481)+2
     &*LRFFO*Z(563)*Z(482)+2*LRFFO*Z(565)*Z(481)+2*Z(234)*Z(563)*Z(487)+
     &4*Z(91)*Z(11)*Z(482)+4*Z(91)*Z(12)*Z(481)+4*Z(11)*Z(234)*Z(486)+4*
     &Z(12)*Z(251)*Z(486)-4*Z(91)*Z(483)-LRFFO*Z(484)-4*Z(12)*Z(234)*Z(4
     &83)-2*Z(234)*Z(565)*Z(484)-4*Z(251)*Z(482)-2*Z(1212)*Z(487)-2*Z(25
     &1)*Z(564)*Z(487))
      Z(1279) = Z(546)*(Z(234)*Z(61)-Z(247)*Z(63)) + 0.5D0*Z(545)*(LRFFO
     &*Z(71)+2*Z(234)*Z(61)-2*Z(91)*Z(67)-2*Z(251)*Z(63)) + Z(1220) - Z(
     &1161)*Z(57) - Z(265)*VRX2*Z(64) - Z(265)*VRY2*Z(65) - Z(280)*VRX2*
     &Z(66) - Z(280)*VRY2*Z(67) - Z(288)*VRX1*Z(72) - Z(288)*VRY1*Z(73) 
     &- Z(312)*VRX1*Z(74) - Z(312)*VRY1*Z(75) - Z(543)*(Z(288)*Z(73)+Z(3
     &06)*Z(75))
      Z(1217) = Z(1214) + Z(1135)*Z(223) + MFF*(Z(287)*Z(288)+Z(305)*Z(3
     &06)) - MSH*(Z(229)*Z(234)-Z(246)*Z(247)) - 0.25D0*MRF*(4*Z(1205)+4
     &*Z(229)*Z(234)+2*LRFFO*Z(229)*Z(565)+2*LRFFO*Z(250)*Z(563)+2*LRFFO
     &*Z(251)*Z(563)+4*Z(91)*Z(11)*Z(250)+4*Z(91)*Z(11)*Z(251)+4*Z(91)*Z
     &(12)*Z(229)-4*Z(1216)-Z(1215)-4*Z(250)*Z(251)-4*Z(91)*Z(12)*Z(234)
     &-2*LRFFO*Z(234)*Z(565))
      Z(1218) = Z(1135)*Z(219) + MFF*(Z(288)*Z(290)+Z(306)*Z(299)) + 0.5
     &D0*MRF*(2*Z(251)*Z(240)-2*Z(234)*Z(232)-2*Z(91)*Z(11)*Z(240)-2*Z(9
     &1)*Z(12)*Z(232)-LRFFO*Z(563)*Z(240)-LRFFO*Z(565)*Z(232)) - MSH*(Z(
     &234)*Z(232)-Z(247)*Z(240))
      Z(1219) = Z(1135)*Z(220) + MFF*(Z(288)*Z(291)+Z(306)*Z(300)) + 0.5
     &D0*MRF*(2*Z(251)*Z(241)-2*Z(234)*Z(233)-2*Z(91)*Z(11)*Z(241)-2*Z(9
     &1)*Z(12)*Z(233)-LRFFO*Z(563)*Z(241)-LRFFO*Z(565)*Z(233)) - MSH*(Z(
     &234)*Z(233)-Z(247)*Z(241))
      RHTQ = Z(1279) + Z(1217)*U3p + Z(1218)*U1p + Z(1219)*U2p
      Z(1225) = Z(1176) + Z(1180) + Z(1182) + Z(992)*Z(434) + MFF*(Z(285
     &)*Z(497)+Z(295)*Z(498)) + MHAT*(Z(317)*Z(505)+Z(324)*Z(503)) + MLA
     &*(Z(352)*Z(520)+Z(360)*Z(521)) + MLA*(Z(397)*Z(537)+Z(405)*Z(538))
     & + MSH*(Z(176)*Z(453)+Z(186)*Z(454)) + MSH*(Z(230)*Z(478)+Z(238)*Z
     &(479)) + MTH*(Z(192)*Z(461)+Z(202)*Z(462)) + MTH*(Z(211)*Z(469)+Z(
     &218)*Z(470)) + MUA*(Z(332)*Z(511)+Z(339)*Z(512)) + MUA*(Z(377)*Z(5
     &28)+Z(384)*Z(529)) + 0.25D0*MRF*(LRFFO*Z(440)+LRFO*Z(439)+Z(1207)*
     &Z(439)+Z(1208)*Z(440)+4*LFF*Z(437)+2*LFF*Z(560)*Z(440)+2*LRFFO*Z(5
     &60)*Z(437)+Z(1209)*Z(442)+2*LFF*Z(18)*Z(442)-2*LFF*Z(17)*Z(439)-2*
     &LRFO*Z(17)*Z(437)-Z(1210)*Z(443)-2*LFF*Z(562)*Z(443)-2*LRFFO*Z(561
     &)*Z(438)-2*LRFO*Z(18)*Z(438)) - Z(1184) - 0.5D0*MRF*(Z(230)*Z(565)
     &*Z(484)+Z(238)*Z(563)*Z(484)+2*Z(11)*Z(238)*Z(483)+2*Z(12)*Z(230)*
     &Z(483)+2*Z(12)*Z(238)*Z(486)-2*Z(230)*Z(481)-2*Z(238)*Z(482)-2*Z(1
     &1)*Z(230)*Z(486)-Z(230)*Z(563)*Z(487)-Z(238)*Z(564)*Z(487))
      Z(1280) = Z(1159)*Z(42) + LFF*(RX2*Z(41)+RY2*Z(42)) + 0.5D0*Z(545)
     &*(LRFFO*Z(49)+LRFO*Z(53)+2*LFF*Z(42)) + Z(1225) - Z(262)*VRX2*Z(64
     &) - Z(262)*VRY2*Z(65) - Z(272)*VRX2*Z(66) - Z(272)*VRY2*Z(67) - Z(
     &285)*VRX1*Z(72) - Z(285)*VRY1*Z(73) - Z(295)*VRX1*Z(74) - Z(295)*V
     &RY1*Z(75) - Z(542)*(Z(317)*Z(2)+Z(324)*Z(1)) - Z(543)*(Z(285)*Z(73
     &)+Z(295)*Z(75)) - Z(544)*(Z(352)*Z(80)+Z(360)*Z(82)) - Z(544)*(Z(3
     &97)*Z(87)+Z(405)*Z(89)) - Z(545)*(Z(230)*Z(61)+Z(238)*Z(63)) - Z(5
     &46)*(Z(176)*Z(36)+Z(186)*Z(38)) - Z(546)*(Z(230)*Z(61)+Z(238)*Z(63
     &)) - Z(547)*(Z(192)*Z(55)+Z(202)*Z(54)) - Z(547)*(Z(211)*Z(58)+Z(2
     &18)*Z(57)) - Z(548)*(Z(332)*Z(77)+Z(339)*Z(76)) - Z(548)*(Z(377)*Z
     &(84)+Z(384)*Z(83))
      Z(1222) = Z(1221) + MFF*(Z(285)*Z(287)+Z(295)*Z(305)) + MHAT*(Z(31
     &7)**2+Z(324)*Z(328)) + MLA*(Z(352)*Z(353)+Z(360)*Z(369)) + MLA*(Z(
     &397)*Z(398)+Z(405)*Z(414)) + MSH*(Z(176)**2+Z(186)**2) + MSH*(Z(22
     &9)*Z(230)+Z(238)*Z(246)) + MTH*(Z(192)**2+Z(202)**2) + MTH*(Z(211)
     &**2+Z(218)*Z(223)) + MUA*(Z(332)*Z(333)+Z(339)*Z(345)) + MUA*(Z(37
     &7)*Z(378)+Z(384)*Z(390)) + 0.25D0*MRF*(Z(1201)+4*Z(1202)*Z(560)-4*
     &Z(1203)*Z(17)) + 0.5D0*MRF*(2*Z(229)*Z(230)+2*Z(238)*Z(250)-2*Z(91
     &)*Z(11)*Z(238)-2*Z(91)*Z(12)*Z(230)-LRFFO*Z(230)*Z(565)-LRFFO*Z(23
     &8)*Z(563))
      Z(1223) = MFF*(Z(285)*Z(290)+Z(295)*Z(299)) + MHAT*(Z(317)*Z(319)+
     &Z(324)*Z(325)) + MLA*(Z(352)*Z(354)+Z(360)*Z(362)) + MLA*(Z(397)*Z
     &(399)+Z(405)*Z(407)) + MRF*(Z(230)*Z(232)+Z(238)*Z(240)) + MSH*(Z(
     &176)*Z(177)+Z(186)*Z(181)) + MSH*(Z(230)*Z(232)+Z(238)*Z(240)) + M
     &TH*(Z(192)*Z(193)+Z(202)*Z(198)) + MTH*(Z(211)*Z(213)+Z(218)*Z(219
     &)) + MUA*(Z(332)*Z(334)+Z(339)*Z(341)) + MUA*(Z(377)*Z(379)+Z(384)
     &*Z(386)) + 0.5D0*MRF*(LRFO*Z(17)*Z(41)-2*LFF*Z(41)-LRFFO*Z(560)*Z(
     &41)-LRFFO*Z(561)*Z(39)-LRFO*Z(18)*Z(39)) - Z(992)*Z(41)
      Z(1224) = MFF*(Z(285)*Z(291)+Z(295)*Z(300)) + MHAT*(Z(317)*Z(320)+
     &Z(324)*Z(326)) + MLA*(Z(352)*Z(355)+Z(360)*Z(363)) + MLA*(Z(397)*Z
     &(400)+Z(405)*Z(408)) + MRF*(Z(230)*Z(233)+Z(238)*Z(241)) + MSH*(Z(
     &176)*Z(178)+Z(186)*Z(182)) + MSH*(Z(230)*Z(233)+Z(238)*Z(241)) + M
     &TH*(Z(192)*Z(194)+Z(202)*Z(199)) + MTH*(Z(211)*Z(214)+Z(218)*Z(220
     &)) + MUA*(Z(332)*Z(335)+Z(339)*Z(342)) + MUA*(Z(377)*Z(380)+Z(384)
     &*Z(387)) + 0.5D0*MRF*(LRFO*Z(17)*Z(42)-2*LFF*Z(42)-LRFFO*Z(560)*Z(
     &42)-LRFFO*Z(561)*Z(40)-LRFO*Z(18)*Z(40)) - Z(992)*Z(42)
      LHTQ = Z(1280) + Z(1222)*U3p + Z(1223)*U1p + Z(1224)*U2p
      Z(1232) = Z(1187) + Z(1189) + Z(1190) + Z(1120)*Z(479) + MFF*(Z(28
     &9)*Z(497)+Z(307)*Z(498)) + 0.25D0*MRF*(LRFFO*Z(484)+4*Z(91)*Z(483)
     &+2*Z(1212)*Z(487)+4*LSH*Z(482)+2*LSH*Z(564)*Z(487)-2*Z(1207)*Z(483
     &)-2*Z(1211)*Z(484)-4*LSH*Z(11)*Z(483)-2*LSH*Z(563)*Z(484)-2*Z(1209
     &)*Z(486)-4*LSH*Z(12)*Z(486)-4*Z(91)*Z(11)*Z(482)-4*Z(91)*Z(12)*Z(4
     &81)-2*LRFFO*Z(563)*Z(482)-2*LRFFO*Z(565)*Z(481))
      Z(1281) = 0.5D0*Z(545)*(LRFFO*Z(71)-2*LSH*Z(63)-2*Z(91)*Z(67)) + Z
     &(1232) - Z(1164)*Z(63) - Z(260)*VRX2*Z(64) - Z(260)*VRY2*Z(65) - Z
     &(281)*VRX2*Z(66) - Z(281)*VRY2*Z(67) - Z(289)*VRX1*Z(72) - Z(289)*
     &VRY1*Z(73) - Z(313)*VRX1*Z(74) - Z(313)*VRY1*Z(75) - Z(543)*(Z(289
     &)*Z(73)+Z(307)*Z(75))
      Z(1229) = Z(1226) + Z(1120)*Z(246) + MFF*(Z(287)*Z(289)+Z(305)*Z(3
     &07)) + 0.25D0*MRF*(Z(1204)+4*LSH*Z(250)-4*Z(1205)-4*Z(1227)*Z(11)-
     &2*Z(1228)*Z(563)-4*Z(91)*Z(11)*Z(250)-4*Z(91)*Z(12)*Z(229)-2*LRFFO
     &*Z(229)*Z(565)-2*LRFFO*Z(250)*Z(563))
      Z(1230) = Z(1120)*Z(240) + MFF*(Z(289)*Z(290)+Z(307)*Z(299)) + 0.5
     &D0*MRF*(2*LSH*Z(240)-2*Z(91)*Z(11)*Z(240)-2*Z(91)*Z(12)*Z(232)-LRF
     &FO*Z(563)*Z(240)-LRFFO*Z(565)*Z(232))
      Z(1231) = Z(1120)*Z(241) + MFF*(Z(289)*Z(291)+Z(307)*Z(300)) + 0.5
     &D0*MRF*(2*LSH*Z(241)-2*Z(91)*Z(11)*Z(241)-2*Z(91)*Z(12)*Z(233)-LRF
     &FO*Z(563)*Z(241)-LRFFO*Z(565)*Z(233))
      RKTQ = Z(1281) + Z(1229)*U3p + Z(1230)*U1p + Z(1231)*U2p
      Z(1237) = Z(1176) + Z(1180) + Z(1182) + Z(992)*Z(434) + MFF*(Z(286
     &)*Z(497)+Z(296)*Z(498)) + MHAT*(Z(318)*Z(505)+Z(323)*Z(503)) + MLA
     &*(Z(351)*Z(520)+Z(359)*Z(521)) + MLA*(Z(396)*Z(537)+Z(404)*Z(538))
     & + MSH*(Z(176)*Z(453)+Z(186)*Z(454)) + MSH*(Z(231)*Z(478)+Z(239)*Z
     &(479)) + MTH*(Z(192)*Z(461)+Z(197)*Z(462)) + MTH*(Z(212)*Z(469)+Z(
     &217)*Z(470)) + MUA*(Z(331)*Z(511)+Z(338)*Z(512)) + MUA*(Z(376)*Z(5
     &28)+Z(383)*Z(529)) + 0.25D0*MRF*(LRFFO*Z(440)+LRFO*Z(439)+Z(1207)*
     &Z(439)+Z(1208)*Z(440)+4*LFF*Z(437)+2*LFF*Z(560)*Z(440)+2*LRFFO*Z(5
     &60)*Z(437)+Z(1209)*Z(442)+2*LFF*Z(18)*Z(442)-2*LFF*Z(17)*Z(439)-2*
     &LRFO*Z(17)*Z(437)-Z(1210)*Z(443)-2*LFF*Z(562)*Z(443)-2*LRFFO*Z(561
     &)*Z(438)-2*LRFO*Z(18)*Z(438)) - 0.5D0*MRF*(Z(231)*Z(565)*Z(484)+Z(
     &239)*Z(563)*Z(484)+2*Z(11)*Z(239)*Z(483)+2*Z(12)*Z(231)*Z(483)+2*Z
     &(12)*Z(239)*Z(486)-2*Z(231)*Z(481)-2*Z(239)*Z(482)-2*Z(11)*Z(231)*
     &Z(486)-Z(231)*Z(563)*Z(487)-Z(239)*Z(564)*Z(487))
      Z(1282) = Z(1159)*Z(42) + LFF*(RX2*Z(41)+RY2*Z(42)) + 0.5D0*Z(545)
     &*(LRFFO*Z(49)+LRFO*Z(53)+2*LFF*Z(42)) + Z(1237) - Z(263)*VRX2*Z(64
     &) - Z(263)*VRY2*Z(65) - Z(273)*VRX2*Z(66) - Z(273)*VRY2*Z(67) - Z(
     &286)*VRX1*Z(72) - Z(286)*VRY1*Z(73) - Z(296)*VRX1*Z(74) - Z(296)*V
     &RY1*Z(75) - Z(542)*(Z(318)*Z(2)+Z(323)*Z(1)) - Z(543)*(Z(286)*Z(73
     &)+Z(296)*Z(75)) - Z(544)*(Z(351)*Z(80)+Z(359)*Z(82)) - Z(544)*(Z(3
     &96)*Z(87)+Z(404)*Z(89)) - Z(545)*(Z(231)*Z(61)+Z(239)*Z(63)) - Z(5
     &46)*(Z(176)*Z(36)+Z(186)*Z(38)) - Z(546)*(Z(231)*Z(61)+Z(239)*Z(63
     &)) - Z(547)*(Z(192)*Z(55)+Z(197)*Z(54)) - Z(547)*(Z(212)*Z(58)+Z(2
     &17)*Z(57)) - Z(548)*(Z(331)*Z(77)+Z(338)*Z(76)) - Z(548)*(Z(376)*Z
     &(84)+Z(383)*Z(83))
      Z(1234) = Z(1233) + MFF*(Z(286)*Z(287)+Z(296)*Z(305)) + MHAT*(Z(31
     &7)*Z(318)+Z(323)*Z(328)) + MLA*(Z(351)*Z(353)+Z(359)*Z(369)) + MLA
     &*(Z(396)*Z(398)+Z(404)*Z(414)) + MSH*(Z(176)**2+Z(186)**2) + MSH*(
     &Z(229)*Z(231)+Z(239)*Z(246)) + MTH*(Z(192)**2+Z(197)*Z(202)) + MTH
     &*(Z(211)*Z(212)+Z(217)*Z(223)) + MUA*(Z(331)*Z(333)+Z(338)*Z(345))
     & + MUA*(Z(376)*Z(378)+Z(383)*Z(390)) + 0.25D0*MRF*(Z(1201)+4*Z(120
     &2)*Z(560)-4*Z(1203)*Z(17)) + 0.5D0*MRF*(2*Z(229)*Z(231)+2*Z(239)*Z
     &(250)-2*Z(91)*Z(11)*Z(239)-2*Z(91)*Z(12)*Z(231)-LRFFO*Z(231)*Z(565
     &)-LRFFO*Z(239)*Z(563))
      Z(1235) = MFF*(Z(286)*Z(290)+Z(296)*Z(299)) + MHAT*(Z(318)*Z(319)+
     &Z(323)*Z(325)) + MLA*(Z(351)*Z(354)+Z(359)*Z(362)) + MLA*(Z(396)*Z
     &(399)+Z(404)*Z(407)) + MRF*(Z(231)*Z(232)+Z(239)*Z(240)) + MSH*(Z(
     &176)*Z(177)+Z(186)*Z(181)) + MSH*(Z(231)*Z(232)+Z(239)*Z(240)) + M
     &TH*(Z(192)*Z(193)+Z(197)*Z(198)) + MTH*(Z(212)*Z(213)+Z(217)*Z(219
     &)) + MUA*(Z(331)*Z(334)+Z(338)*Z(341)) + MUA*(Z(376)*Z(379)+Z(383)
     &*Z(386)) + 0.5D0*MRF*(LRFO*Z(17)*Z(41)-2*LFF*Z(41)-LRFFO*Z(560)*Z(
     &41)-LRFFO*Z(561)*Z(39)-LRFO*Z(18)*Z(39)) - Z(992)*Z(41)
      Z(1236) = MFF*(Z(286)*Z(291)+Z(296)*Z(300)) + MHAT*(Z(318)*Z(320)+
     &Z(323)*Z(326)) + MLA*(Z(351)*Z(355)+Z(359)*Z(363)) + MLA*(Z(396)*Z
     &(400)+Z(404)*Z(408)) + MRF*(Z(231)*Z(233)+Z(239)*Z(241)) + MSH*(Z(
     &176)*Z(178)+Z(186)*Z(182)) + MSH*(Z(231)*Z(233)+Z(239)*Z(241)) + M
     &TH*(Z(192)*Z(194)+Z(197)*Z(199)) + MTH*(Z(212)*Z(214)+Z(217)*Z(220
     &)) + MUA*(Z(331)*Z(335)+Z(338)*Z(342)) + MUA*(Z(376)*Z(380)+Z(383)
     &*Z(387)) + 0.5D0*MRF*(LRFO*Z(17)*Z(42)-2*LFF*Z(42)-LRFFO*Z(560)*Z(
     &42)-LRFFO*Z(561)*Z(40)-LRFO*Z(18)*Z(40)) - Z(992)*Z(42)
      LKTQ = Z(1282) + Z(1234)*U3p + Z(1235)*U1p + Z(1236)*U2p
      Z(1243) = Z(1187) + Z(1189) + MFF*(Z(283)*Z(497)+Z(308)*Z(498)) + 
     &0.25D0*MRF*(LRFFO*Z(484)+4*Z(91)*Z(483)+2*Z(1212)*Z(487)-2*Z(1207)
     &*Z(483)-2*Z(1211)*Z(484)-2*Z(1209)*Z(486)-4*Z(91)*Z(11)*Z(482)-4*Z
     &(91)*Z(12)*Z(481)-2*LRFFO*Z(563)*Z(482)-2*LRFFO*Z(565)*Z(481))
      Z(1283) = 0.5D0*Z(545)*(LRFFO*Z(71)-2*Z(91)*Z(67)) + Z(1243) - Z(2
     &83)*VRX1*Z(72) - Z(283)*VRY1*Z(73) - Z(314)*VRX1*Z(74) - Z(314)*VR
     &Y1*Z(75) - LRF*(VRX2*Z(66)+VRY2*Z(67)) - Z(543)*(Z(283)*Z(73)+Z(30
     &8)*Z(75))
      Z(1240) = Z(1238) + MFF*(Z(283)*Z(287)+Z(305)*Z(308)) + 0.25D0*MRF
     &*(Z(1239)-4*Z(91)*Z(11)*Z(250)-4*Z(91)*Z(12)*Z(229)-2*LRFFO*Z(229)
     &*Z(565)-2*LRFFO*Z(250)*Z(563))
      Z(1241) = MFF*(Z(283)*Z(290)+Z(308)*Z(299)) - 0.5D0*MRF*(LRFFO*Z(5
     &63)*Z(240)+LRFFO*Z(565)*Z(232)+2*Z(91)*Z(11)*Z(240)+2*Z(91)*Z(12)*
     &Z(232))
      Z(1242) = MFF*(Z(283)*Z(291)+Z(308)*Z(300)) - 0.5D0*MRF*(LRFFO*Z(5
     &63)*Z(241)+LRFFO*Z(565)*Z(233)+2*Z(91)*Z(11)*Z(241)+2*Z(91)*Z(12)*
     &Z(233))
      RATQ = Z(1283) + Z(1240)*U3p + Z(1241)*U1p + Z(1242)*U2p
      Z(1248) = Z(1176) + Z(1180) + Z(992)*Z(434) + MFF*(Z(284)*Z(497)+Z
     &(294)*Z(498)) + MHAT*(Z(316)*Z(505)+Z(322)*Z(503)) + MLA*(Z(350)*Z
     &(520)+Z(358)*Z(521)) + MLA*(Z(395)*Z(537)+Z(403)*Z(538)) + MSH*(Z(
     &176)*Z(453)+Z(180)*Z(454)) + MSH*(Z(228)*Z(478)+Z(236)*Z(479)) + M
     &TH*(Z(191)*Z(461)+Z(196)*Z(462)) + MTH*(Z(210)*Z(469)+Z(216)*Z(470
     &)) + MUA*(Z(330)*Z(511)+Z(337)*Z(512)) + MUA*(Z(375)*Z(528)+Z(382)
     &*Z(529)) + 0.25D0*MRF*(LRFFO*Z(440)+LRFO*Z(439)+Z(1207)*Z(439)+Z(1
     &208)*Z(440)+4*LFF*Z(437)+2*LFF*Z(560)*Z(440)+2*LRFFO*Z(560)*Z(437)
     &+Z(1209)*Z(442)+2*LFF*Z(18)*Z(442)-2*LFF*Z(17)*Z(439)-2*LRFO*Z(17)
     &*Z(437)-Z(1210)*Z(443)-2*LFF*Z(562)*Z(443)-2*LRFFO*Z(561)*Z(438)-2
     &*LRFO*Z(18)*Z(438)) - 0.5D0*MRF*(Z(228)*Z(565)*Z(484)+Z(236)*Z(563
     &)*Z(484)+2*Z(11)*Z(236)*Z(483)+2*Z(12)*Z(228)*Z(483)+2*Z(12)*Z(236
     &)*Z(486)-2*Z(228)*Z(481)-2*Z(236)*Z(482)-2*Z(11)*Z(228)*Z(486)-Z(2
     &28)*Z(563)*Z(487)-Z(236)*Z(564)*Z(487))
      Z(1284) = Z(1159)*Z(42) + LFF*(RX2*Z(41)+RY2*Z(42)) + 0.5D0*Z(545)
     &*(LRFFO*Z(49)+LRFO*Z(53)+2*LFF*Z(42)) + Z(1248) - Z(261)*VRX2*Z(64
     &) - Z(261)*VRY2*Z(65) - Z(270)*VRX2*Z(66) - Z(270)*VRY2*Z(67) - Z(
     &284)*VRX1*Z(72) - Z(284)*VRY1*Z(73) - Z(294)*VRX1*Z(74) - Z(294)*V
     &RY1*Z(75) - Z(542)*(Z(316)*Z(2)+Z(322)*Z(1)) - Z(543)*(Z(284)*Z(73
     &)+Z(294)*Z(75)) - Z(544)*(Z(350)*Z(80)+Z(358)*Z(82)) - Z(544)*(Z(3
     &95)*Z(87)+Z(403)*Z(89)) - Z(545)*(Z(228)*Z(61)+Z(236)*Z(63)) - Z(5
     &46)*(Z(176)*Z(36)+Z(180)*Z(38)) - Z(546)*(Z(228)*Z(61)+Z(236)*Z(63
     &)) - Z(547)*(Z(191)*Z(55)+Z(196)*Z(54)) - Z(547)*(Z(210)*Z(58)+Z(2
     &16)*Z(57)) - Z(548)*(Z(330)*Z(77)+Z(337)*Z(76)) - Z(548)*(Z(375)*Z
     &(84)+Z(382)*Z(83))
      Z(1245) = Z(1244) + MFF*(Z(284)*Z(287)+Z(294)*Z(305)) + MHAT*(Z(31
     &6)*Z(317)+Z(322)*Z(328)) + MLA*(Z(350)*Z(353)+Z(358)*Z(369)) + MLA
     &*(Z(395)*Z(398)+Z(403)*Z(414)) + MSH*(Z(176)**2+Z(180)*Z(186)) + M
     &SH*(Z(228)*Z(229)+Z(236)*Z(246)) + MTH*(Z(191)*Z(192)+Z(196)*Z(202
     &)) + MTH*(Z(210)*Z(211)+Z(216)*Z(223)) + MUA*(Z(330)*Z(333)+Z(337)
     &*Z(345)) + MUA*(Z(375)*Z(378)+Z(382)*Z(390)) + 0.25D0*MRF*(Z(1201)
     &+4*Z(1202)*Z(560)-4*Z(1203)*Z(17)) + 0.5D0*MRF*(2*Z(228)*Z(229)+2*
     &Z(236)*Z(250)-2*Z(91)*Z(11)*Z(236)-2*Z(91)*Z(12)*Z(228)-LRFFO*Z(22
     &8)*Z(565)-LRFFO*Z(236)*Z(563))
      Z(1246) = MFF*(Z(284)*Z(290)+Z(294)*Z(299)) + MHAT*(Z(316)*Z(319)+
     &Z(322)*Z(325)) + MLA*(Z(350)*Z(354)+Z(358)*Z(362)) + MLA*(Z(395)*Z
     &(399)+Z(403)*Z(407)) + MRF*(Z(228)*Z(232)+Z(236)*Z(240)) + MSH*(Z(
     &176)*Z(177)+Z(180)*Z(181)) + MSH*(Z(228)*Z(232)+Z(236)*Z(240)) + M
     &TH*(Z(191)*Z(193)+Z(196)*Z(198)) + MTH*(Z(210)*Z(213)+Z(216)*Z(219
     &)) + MUA*(Z(330)*Z(334)+Z(337)*Z(341)) + MUA*(Z(375)*Z(379)+Z(382)
     &*Z(386)) + 0.5D0*MRF*(LRFO*Z(17)*Z(41)-2*LFF*Z(41)-LRFFO*Z(560)*Z(
     &41)-LRFFO*Z(561)*Z(39)-LRFO*Z(18)*Z(39)) - Z(992)*Z(41)
      Z(1247) = MFF*(Z(284)*Z(291)+Z(294)*Z(300)) + MHAT*(Z(316)*Z(320)+
     &Z(322)*Z(326)) + MLA*(Z(350)*Z(355)+Z(358)*Z(363)) + MLA*(Z(395)*Z
     &(400)+Z(403)*Z(408)) + MRF*(Z(228)*Z(233)+Z(236)*Z(241)) + MSH*(Z(
     &176)*Z(178)+Z(180)*Z(182)) + MSH*(Z(228)*Z(233)+Z(236)*Z(241)) + M
     &TH*(Z(191)*Z(194)+Z(196)*Z(199)) + MTH*(Z(210)*Z(214)+Z(216)*Z(220
     &)) + MUA*(Z(330)*Z(335)+Z(337)*Z(342)) + MUA*(Z(375)*Z(380)+Z(382)
     &*Z(387)) + 0.5D0*MRF*(LRFO*Z(17)*Z(42)-2*LFF*Z(42)-LRFFO*Z(560)*Z(
     &42)-LRFFO*Z(561)*Z(40)-LRFO*Z(18)*Z(40)) - Z(992)*Z(42)
      LATQ = Z(1284) + Z(1245)*U3p + Z(1246)*U1p + Z(1247)*U2p
      Z(1253) = Z(1188) + Z(1048)*Z(512) - Z(1192) - MLA*(Z(356)*Z(520)-
     &Z(368)*Z(521))
      Z(1285) = Z(544)*(Z(356)*Z(80)-Z(368)*Z(82)) + Z(1253) - Z(1169)*Z
     &(76)
      Z(1250) = Z(1249) + Z(1048)*Z(345) - MLA*(Z(353)*Z(356)-Z(368)*Z(3
     &69))
      Z(1251) = Z(1048)*Z(341) - MLA*(Z(356)*Z(354)-Z(368)*Z(362))
      Z(1252) = Z(1048)*Z(342) - MLA*(Z(356)*Z(355)-Z(368)*Z(363))
      RSTQ = Z(1285) + Z(1250)*U3p + Z(1251)*U1p + Z(1252)*U2p
      Z(1257) = Z(1178) + Z(1048)*Z(529) - Z(1186) - MLA*(Z(401)*Z(537)-
     &Z(413)*Z(538))
      Z(1286) = Z(544)*(Z(401)*Z(87)-Z(413)*Z(89)) + Z(1257) - Z(1169)*Z
     &(83)
      Z(1254) = Z(1249) + Z(1048)*Z(390) - MLA*(Z(398)*Z(401)-Z(413)*Z(4
     &14))
      Z(1255) = Z(1048)*Z(386) - MLA*(Z(401)*Z(399)-Z(413)*Z(407))
      Z(1256) = Z(1048)*Z(387) - MLA*(Z(401)*Z(400)-Z(413)*Z(408))
      LSTQ = Z(1286) + Z(1254)*U3p + Z(1255)*U1p + Z(1256)*U2p
      Z(1258) = ILA + Z(1002)*Z(369)
      Z(1259) = Z(1002)*Z(362)
      Z(1260) = Z(1002)*Z(363)
      Z(1173) = Z(1172)*Z(82)
      Z(1261) = Z(1188) + Z(1002)*Z(521)
      Z(1277) = Z(1173) - Z(1261)
      RETQ = Z(1258)*U3p + Z(1259)*U1p + Z(1260)*U2p - Z(1277)
      Z(1262) = ILA + Z(1002)*Z(414)
      Z(1263) = Z(1002)*Z(407)
      Z(1264) = Z(1002)*Z(408)
      Z(1174) = Z(1172)*Z(89)
      Z(1265) = Z(1178) + Z(1002)*Z(538)
      Z(1278) = Z(1174) - Z(1265)
      LETQ = Z(1262)*U3p + Z(1263)*U1p + Z(1264)*U2p - Z(1278)
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
      POCMX = Q1 + Z(95)*Z(1) + Z(97)*Z(79) + Z(97)*Z(86) + Z(102)*Z(76)
     & + Z(102)*Z(83) + Z(103)*Z(72) + Z(104)*Z(64) + Z(105)*Z(60) + Z(1
     &06)*Z(57) - Z(96)*Z(39) - Z(100)*Z(35) - Z(101)*Z(54) - 0.5D0*Z(98
     &)*Z(50) - 0.5D0*Z(99)*Z(46) - 0.5D0*Z(99)*Z(68)
      POCMY = Q2 + Z(95)*Z(2) + Z(97)*Z(80) + Z(97)*Z(87) + Z(102)*Z(77)
     & + Z(102)*Z(84) + Z(103)*Z(73) + Z(104)*Z(65) + Z(105)*Z(61) + Z(1
     &06)*Z(58) - Z(96)*Z(40) - Z(100)*Z(36) - Z(101)*Z(55) - 0.5D0*Z(98
     &)*Z(51) - 0.5D0*Z(99)*Z(47) - 0.5D0*Z(99)*Z(69)
      Z(420) = Z(96)*(LKp-LAp-LHp-LMTPp)
      Z(421) = Z(97)*(LEp-LSp)
      Z(422) = Z(98)*(LAp+LHp-LKp)
      Z(423) = Z(99)*(LAp+LHp-LKp)
      Z(424) = Z(100)*(LHp-LKp)
      Z(425) = Z(101)*LHp
      Z(426) = Z(102)*LSp
      Z(427) = Z(103)*(RKp-RAp-RHp-RMTPp)
      Z(428) = Z(97)*(REp-RSp)
      Z(429) = Z(104)*(RAp+RHp-RKp)
      Z(430) = Z(99)*(RAp+RHp-RKp)
      Z(431) = Z(105)*(RHp-RKp)
      Z(432) = Z(106)*RHp
      Z(433) = Z(102)*RSp
      VOCMX = U1 + Z(56)*(Z(425)-Z(101)*U3-Z(101)*U5) + Z(81)*(Z(428)+Z(
     &97)*U10+Z(97)*U12+Z(97)*U3) + Z(88)*(Z(421)+Z(97)*U11+Z(97)*U13+Z(
     &97)*U3) + Z(74)*(Z(427)+Z(103)*U3+Z(103)*U4+Z(103)*U6+Z(103)*U8) +
     & Z(37)*(Z(424)-Z(100)*U3-Z(100)*U5-Z(100)*U7) + 0.5D0*Z(48)*(Z(423
     &)-Z(99)*U3-Z(99)*U5-Z(99)*U7-Z(99)*U9) + 0.5D0*Z(52)*(Z(422)-Z(98)
     &*U3-Z(98)*U5-Z(98)*U7-Z(98)*U9) + 0.5D0*Z(70)*(Z(430)-Z(99)*U3-Z(9
     &9)*U4-Z(99)*U6-Z(99)*U8) - Z(95)*Z(2)*U3 - Z(59)*(Z(432)-Z(106)*U3
     &-Z(106)*U4) - Z(78)*(Z(433)-Z(102)*U10-Z(102)*U3) - Z(85)*(Z(426)-
     &Z(102)*U11-Z(102)*U3) - Z(41)*(Z(420)+Z(96)*U3+Z(96)*U5+Z(96)*U7+Z
     &(96)*U9) - Z(62)*(Z(431)-Z(105)*U3-Z(105)*U4-Z(105)*U6) - Z(66)*(Z
     &(429)-Z(104)*U3-Z(104)*U4-Z(104)*U6-Z(104)*U8)
      VOCMY = U2 + Z(95)*Z(1)*U3 + Z(54)*(Z(425)-Z(101)*U3-Z(101)*U5) + 
     &Z(82)*(Z(428)+Z(97)*U10+Z(97)*U12+Z(97)*U3) + Z(89)*(Z(421)+Z(97)*
     &U11+Z(97)*U13+Z(97)*U3) + Z(75)*(Z(427)+Z(103)*U3+Z(103)*U4+Z(103)
     &*U6+Z(103)*U8) + Z(38)*(Z(424)-Z(100)*U3-Z(100)*U5-Z(100)*U7) + 0.
     &5D0*Z(49)*(Z(423)-Z(99)*U3-Z(99)*U5-Z(99)*U7-Z(99)*U9) + 0.5D0*Z(5
     &3)*(Z(422)-Z(98)*U3-Z(98)*U5-Z(98)*U7-Z(98)*U9) + 0.5D0*Z(71)*(Z(4
     &30)-Z(99)*U3-Z(99)*U4-Z(99)*U6-Z(99)*U8) - Z(57)*(Z(432)-Z(106)*U3
     &-Z(106)*U4) - Z(76)*(Z(433)-Z(102)*U10-Z(102)*U3) - Z(83)*(Z(426)-
     &Z(102)*U11-Z(102)*U3) - Z(42)*(Z(420)+Z(96)*U3+Z(96)*U5+Z(96)*U7+Z
     &(96)*U9) - Z(63)*(Z(431)-Z(105)*U3-Z(105)*U4-Z(105)*U6) - Z(67)*(Z
     &(429)-Z(104)*U3-Z(104)*U4-Z(104)*U6-Z(104)*U8)
      RMTQ = MTPK*(3.141592653589793D0-RMTP) - MTPB*RMTPp
      LMTQ = MTPK*(3.141592653589793D0-LMTP) - MTPB*LMTPp
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
      WRITE(22,6020) T,Q1,Q2,Q3,U1,U2,U3
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


