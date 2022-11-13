C**   The name of this program is model/13seg_tq/model.f
C**   Created by AUTOLEV 3.2 on Sat Oct 29 20:02:54 2022

      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          ILOOP, IPRINT, PRINTINT
      CHARACTER        MESSAGE(99)
      EXTERNAL         EQNS1
      DIMENSION        VAR(22)
      COMMON/CONSTNTS/ FOOTANG,G,IFF,IHAT,ILA,IRF,ISH,ITH,IUA,K1,K2,K3,K
     &4,K5,K6,K7,K8,LAE,LAF,LFF,LFFO,LHAT,LHATO,LHE,LHF,LKE,LKF,LLA,LLAO
     &,LRF,LRFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,LUA,LUAO,MFF,MHAT,MLA,MRF,M
     &SH,MTH,MTPB,MTPK,MTPXI,MUA,RAE,RAF,RHE,RHF,RKE,RKF,TOEXI
      COMMON/SPECFIED/ LE,LS,RE,RS,LEp,LSp,REp,RSp,LEpp,LSpp,REpp,RSpp
      COMMON/VARIBLES/ Q1,Q10,Q11,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,U1,U10,U11,U2,
     &U3,U4,U5,U6,U7,U8,U9
      COMMON/ALGBRAIC/ HZ,KECM,LA,LETQ,LH,LK,LMTP,LSTQ,PX,PY,RA,RETQ,RH,
     &RK,RMTP,RSTQ,U12,U13,U14,U15,LAp,LHp,LKp,LMTPp,Q1p,Q10p,Q11p,Q2p,Q
     &3p,Q4p,Q5p,Q6p,Q7p,Q8p,Q9p,RAp,RHp,RKp,RMTPp,U1p,U10p,U11p,U2p,U3p
     &,U4p,U5p,U6p,U7p,U8p,U9p,LApp,LHpp,LKpp,LMTPpp,RApp,RHpp,RKpp,RMTP
     &pp,LATQ,LHTQ,LKTQ,LMTQ,RATQ,RHTQ,RKTQ,RMTQ,DX1,DX2,POCMX,POCMY,POP
     &10X,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP13X,POP13Y,POP14X,POP14Y
     &,POP15X,POP15Y,POP16X,POP16Y,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,P
     &OP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,P
     &OP9Y,RX,RX1,RX2,RY,RY1,RY2,VOCMX,VOCMY,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(1272),COEF(11,11),RHS(11)

C**   Open input and output files
      OPEN(UNIT=20, FILE='model/13seg_tq/model.in', STATUS='OLD')
      OPEN(UNIT=21, FILE='model/13seg_tq/model.1',  STATUS='UNKNOWN')
      OPEN(UNIT=22, FILE='model/13seg_tq/model.2',  STATUS='UNKNOWN')
      OPEN(UNIT=23, FILE='model/13seg_tq/model.3',  STATUS='UNKNOWN')
      OPEN(UNIT=24, FILE='model/13seg_tq/model.4',  STATUS='UNKNOWN')
      OPEN(UNIT=25, FILE='model/13seg_tq/model.5',  STATUS='UNKNOWN')
      OPEN(UNIT=26, FILE='model/13seg_tq/model.6',  STATUS='UNKNOWN')

C**   Read message from input file
      READ(20,7000,END=7100,ERR=7101) (MESSAGE(ILOOP),ILOOP = 1,99)

C**   Read values of constants from input file
      READ(20,7010,END=7100,ERR=7101) FOOTANG,G,IFF,IHAT,ILA,IRF,ISH,ITH
     &,IUA,K1,K2,K3,K4,K5,K6,K7,K8,LAE,LAF,LFF,LFFO,LHAT,LHATO,LHE,LHF,L
     &KE,LKF,LLA,LLAO,LRF,LRFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,LUA,LUAO,MFF
     &,MHAT,MLA,MRF,MSH,MTH,MTPB,MTPK,MTPXI,MUA,RAE,RAF,RHE,RHF,RKE,RKF,
     &TOEXI

C**   Read the initial value of each variable from input file
      READ(20,7010,END=7100,ERR=7101) Q1,Q10,Q11,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9
     &,U1,U10,U11,U2,U3,U4,U5,U6,U7,U8,U9

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
      U12 = 0
      U13 = 0
      U14 = 0
      U15 = 0
      Z(932) = LRFFO*MRF
      Z(27) = COS(FOOTANG)
      Z(465) = G*MLA
      Z(1096) = LLAO*Z(465)
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
      Z(463) = G*MHAT
      Z(464) = G*MFF
      Z(466) = G*MRF
      Z(467) = G*MSH
      Z(468) = G*MTH
      Z(469) = G*MUA
      Z(491) = LFF - Z(96)
      Z(492) = LSH - Z(100)
      Z(493) = LTH - Z(101)
      Z(494) = 2*LRF - Z(98)
      Z(587) = LHAT - Z(95)
      Z(588) = LUA - Z(102)
      Z(593) = Z(96) - LFF
      Z(594) = 0.5D0*Z(98) - 0.5D0*LRFO
      Z(595) = 0.5D0*Z(99) - 0.5D0*LRFFO
      Z(785) = LSH - Z(105)
      Z(786) = LTH - Z(106)
      Z(787) = LRF - Z(104)
      Z(812) = 0.5D0*Z(98) - LRF
      Z(813) = Z(100) - LSH
      Z(814) = Z(101) - LTH
      Z(815) = LRF - 0.5D0*LRFO - Z(104)
      Z(862) = 2*Z(594) + 2*Z(27)*Z(595)
      Z(864) = Z(27)*Z(594)
      Z(876) = Z(27)*Z(595)
      Z(878) = Z(27)*Z(815)
      Z(904) = LFFO*MFF
      Z(916) = LLAO*MLA
      Z(928) = LFF*MRF
      Z(931) = LRFO*MRF
      Z(964) = LUAO*MUA
      Z(993) = MFF*Z(90)
      Z(1012) = MRF*Z(91)
      Z(1021) = LSH*MRF
      Z(1038) = MSH*Z(92)
      Z(1061) = MTH*Z(93)
      Z(1079) = LFFO*Z(464)
      Z(1084) = LFF*Z(466)
      Z(1086) = Z(93)*Z(468)
      Z(1088) = Z(92)*Z(467)
      Z(1091) = Z(90)*Z(464)
      Z(1093) = LUAO*Z(469)
      Z(1140) = IHAT + 2*IFF + 2*ILA + 2*IRF + 2*ISH + 2*ITH + 2*IUA + M
     &FF*LFFO**2
      Z(1141) = LRFFO**2 + LRFO**2 + 4*LFF**2 + 2*LRFFO*LRFO*Z(27)
      Z(1142) = LFF*LRFFO
      Z(1143) = LFF*LRFO
      Z(1144) = LRFFO**2 + 4*Z(91)**2
      Z(1145) = LRFFO*Z(27)*Z(91)
      Z(1147) = IFF + IRF + ISH + MFF*LFFO**2
      Z(1149) = MFF*LFFO**2
      Z(1153) = -IFF - IRF
      Z(1154) = LRFFO**2 + 4*Z(91)**2 - 4*LRFFO*Z(27)*Z(91)
      Z(1158) = IFF + IRF + ISH
      Z(1159) = LSH*Z(91)
      Z(1160) = LRFFO*LSH
      Z(1162) = LRFFO*Z(28)
      Z(1163) = LRFO*Z(28)
      Z(1164) = Z(28)*Z(91)
      Z(1167) = IFF + IRF + ISH + ITH + MFF*LFFO**2
      Z(1169) = IFF + IRF + MFF*LFFO**2
      Z(1171) = IFF + MFF*LFFO**2
      Z(1193) = IFF + MFF*LFFO**2 + MRF*LFF**2
      Z(1200) = IFF + IRF
      Z(1201) = 4*LRFFO*Z(27)*Z(91) - LRFFO**2 - 4*Z(91)**2
      Z(1204) = IFF + IRF + ISH + ITH + MTH*Z(93)**2
      Z(1206) = LRFFO**2
      Z(1207) = Z(91)**2
      Z(1212) = IFF + IRF + ISH + MSH*Z(92)**2
      Z(1213) = LRFFO**2 + 4*LSH**2 + 4*Z(91)**2 - 4*LRFFO*Z(27)*Z(91)
      Z(1216) = IFF + IRF + 0.25D0*MRF*(LRFFO**2+4*Z(91)**2-4*LRFFO*Z(27
     &)*Z(91))
      Z(1220) = IFF + MFF*Z(90)**2
      Z(1222) = ILA + IUA

C**   Initialize time, print counter, variables array for integrator
      T      = TINITIAL
      IPRINT = 0
      VAR(1) = Q1
      VAR(2) = Q10
      VAR(3) = Q11
      VAR(4) = Q2
      VAR(5) = Q3
      VAR(6) = Q4
      VAR(7) = Q5
      VAR(8) = Q6
      VAR(9) = Q7
      VAR(10) = Q8
      VAR(11) = Q9
      VAR(12) = U1
      VAR(13) = U10
      VAR(14) = U11
      VAR(15) = U2
      VAR(16) = U3
      VAR(17) = U4
      VAR(18) = U5
      VAR(19) = U6
      VAR(20) = U7
      VAR(21) = U8
      VAR(22) = U9

C**   Initalize numerical integrator with call to EQNS1 at T=TINITIAL
      CALL KUTTA(EQNS1, 22, VAR, T, INTEGSTP, ABSERR, RELERR, 0, *5920)

C**   Numerically integrate; print results
5900  IF( TFINAL.GE.TINITIAL .AND. T+.01D0*INTEGSTP.GE.TFINAL) IPRINT=-7
      IF( TFINAL.LE.TINITIAL .AND. T+.01D0*INTEGSTP.LE.TFINAL) IPRINT=-7
      IF( IPRINT .LE. 0 ) THEN
        CALL IO(T)
        IF( IPRINT .EQ. -7 ) GOTO 5930
        IPRINT = PRINTINT
      ENDIF
      CALL KUTTA(EQNS1, 22, VAR, T, INTEGSTP, ABSERR, RELERR, 1, *5920)
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

6021  FORMAT(1X,'FILE: model/13seg_tq/model.1 ',//1X,'*** ',99A1,///,8X,
     &'T',12X,'POP1X',10X,'POP1Y',10X,'POP2X',10X,'POP2Y',10X,'POP3X',10
     &X,'POP3Y',10X,'POP4X',10X,'POP4Y',10X,'POP5X',10X,'POP5Y',10X,'POP
     &6X',10X,'POP6Y',10X,'POP7X',10X,'POP7Y',10X,'POP8X',10X,'POP8Y',10
     &X,'POP9X',10X,'POP9Y',9X,'POP10X',9X,'POP10Y',9X,'POP11X',9X,'POP1
     &1Y',9X,'POP12X',9X,'POP12Y',9X,'POP13X',9X,'POP13Y',9X,'POP14X',9X
     &,'POP14Y',9X,'POP15X',9X,'POP15Y',9X,'POP16X',9X,'POP16Y',10X,'POC
     &MX',10X,'POCMY',10X,'VOCMX',10X,'VOCMY',/,5X,'(UNITS)',8X,'(UNITS)
     &',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)'
     &,8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',
     &8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8
     &X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X
     &,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,
     &'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'
     &(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6022  FORMAT(1X,'FILE: model/13seg_tq/model.2 ',//1X,'*** ',99A1,///,8X,
     &'T',13X,'Q1',13X,'Q2',13X,'Q3',13X,'Q4',13X,'Q5',13X,'Q6',13X,'Q7'
     &,13X,'Q8',13X,'Q9',13X,'Q10',12X,'Q11',12X,'U1',13X,'U2',13X,'U3',
     &13X,'U4',13X,'U5',13X,'U6',13X,'U7',13X,'U8',13X,'U9',13X,'U10',12
     &X,'U11',/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'
     &(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(
     &UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(U
     &NITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UN
     &ITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6023  FORMAT(1X,'FILE: model/13seg_tq/model.3 ',//1X,'*** ',99A1,///,8X,
     &'T',13X,'RX',13X,'RY',13X,'RX1',12X,'RX2',12X,'RY1',12X,'RY2',/,5X
     &,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,
     &'(UNITS)',8X,'(UNITS)',/)
6024  FORMAT(1X,'FILE: model/13seg_tq/model.4 ',//1X,'*** ',99A1,///,8X,
     &'T',12X,'RHTQ',11X,'LHTQ',11X,'RKTQ',11X,'LKTQ',11X,'RATQ',11X,'LA
     &TQ',11X,'RMTQ',11X,'LMTQ',11X,'RSTQ',11X,'LSTQ',11X,'RETQ',11X,'LE
     &TQ',/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNI
     &TS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNIT
     &S)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6025  FORMAT(1X,'FILE: model/13seg_tq/model.5 ',//1X,'*** ',99A1,///,8X,
     &'T',13X,'RH',13X,'LH',13X,'RK',13X,'LK',13X,'RA',13X,'LA',12X,'RMT
     &P',11X,'LMTP',12X,'RS',13X,'LS',13X,'RE',13X,'LE',13X,'RH''',12X,'
     &LH''',12X,'RK''',12X,'LK''',12X,'RA''',12X,'LA''',11X,'RMTP''',10X
     &,'LMTP''',11X,'RS''',12X,'LS''',12X,'RE''',12X,'LE''',11X,'RH'''''
     &,11X,'LH''''',11X,'RK''''',11X,'LK''''',11X,'RA''''',11X,'LA''''',
     &10X,'RMTP''''',9X,'LMTP''''',10X,'RS''''',11X,'LS''''',11X,'RE''''
     &',11X,'LE''''',/,5X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS
     &)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)
     &',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)'
     &,8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',
     &8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8
     &X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X
     &,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',8X,
     &'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6026  FORMAT(1X,'FILE: model/13seg_tq/model.6 ',//1X,'*** ',99A1,///,8X,
     &'T',12X,'KECM',12X,'HZ',13X,'PX',13X,'PY',/,5X,'(UNITS)',8X,'(UNIT
     &S)',8X,'(UNITS)',8X,'(UNITS)',8X,'(UNITS)',/)
6997  FORMAT(/7X,'Error: Numerical integration failed to converge',/)
6999  FORMAT(//1X,'Input is in the file model/13seg_tq/model.in',//1X,'O
     &utput is in the file(s) model/13seg_tq/model.i  (i=1, ..., 6)',//1
     &X,'The output quantities and associated files are listed in file m
     &odel/13seg_tq/model.dir',/)
7000  FORMAT(//,99A1,///)
7010  FORMAT( 1000(59X,E30.0,/) )
7011  FORMAT( 3(59X,E30.0,/), 1(59X,I30,/), 2(59X,E30.0,/) )
      STOP
7100  WRITE(*,*) 'Premature end of file while reading model/13seg_tq/mod
     &el.in '
7101  WRITE(*,*) 'Error while reading file model/13seg_tq/model.in'
      STOP
      END


C**********************************************************************
      SUBROUTINE       EQNS1(T, VAR, VARp, BOUNDARY)
      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          BOUNDARY
      DIMENSION        VAR(*), VARp(*)
      COMMON/CONSTNTS/ FOOTANG,G,IFF,IHAT,ILA,IRF,ISH,ITH,IUA,K1,K2,K3,K
     &4,K5,K6,K7,K8,LAE,LAF,LFF,LFFO,LHAT,LHATO,LHE,LHF,LKE,LKF,LLA,LLAO
     &,LRF,LRFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,LUA,LUAO,MFF,MHAT,MLA,MRF,M
     &SH,MTH,MTPB,MTPK,MTPXI,MUA,RAE,RAF,RHE,RHF,RKE,RKF,TOEXI
      COMMON/SPECFIED/ LE,LS,RE,RS,LEp,LSp,REp,RSp,LEpp,LSpp,REpp,RSpp
      COMMON/VARIBLES/ Q1,Q10,Q11,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,U1,U10,U11,U2,
     &U3,U4,U5,U6,U7,U8,U9
      COMMON/ALGBRAIC/ HZ,KECM,LA,LETQ,LH,LK,LMTP,LSTQ,PX,PY,RA,RETQ,RH,
     &RK,RMTP,RSTQ,U12,U13,U14,U15,LAp,LHp,LKp,LMTPp,Q1p,Q10p,Q11p,Q2p,Q
     &3p,Q4p,Q5p,Q6p,Q7p,Q8p,Q9p,RAp,RHp,RKp,RMTPp,U1p,U10p,U11p,U2p,U3p
     &,U4p,U5p,U6p,U7p,U8p,U9p,LApp,LHpp,LKpp,LMTPpp,RApp,RHpp,RKpp,RMTP
     &pp,LATQ,LHTQ,LKTQ,LMTQ,RATQ,RHTQ,RKTQ,RMTQ,DX1,DX2,POCMX,POCMY,POP
     &10X,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP13X,POP13Y,POP14X,POP14Y
     &,POP15X,POP15Y,POP16X,POP16Y,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,P
     &OP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,P
     &OP9Y,RX,RX1,RX2,RY,RY1,RY2,VOCMX,VOCMY,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(1272),COEF(11,11),RHS(11)

C**   Update variables after integration step
      Q1 = VAR(1)
      Q10 = VAR(2)
      Q11 = VAR(3)
      Q2 = VAR(4)
      Q3 = VAR(5)
      Q4 = VAR(6)
      Q5 = VAR(7)
      Q6 = VAR(8)
      Q7 = VAR(9)
      Q8 = VAR(10)
      Q9 = VAR(11)
      U1 = VAR(12)
      U10 = VAR(13)
      U11 = VAR(14)
      U2 = VAR(15)
      U3 = VAR(16)
      U4 = VAR(17)
      U5 = VAR(18)
      U6 = VAR(19)
      U7 = VAR(20)
      U8 = VAR(21)
      U9 = VAR(22)

      Q1p = U1
      Q2p = U2
      Q3p = U3
      Q4p = U4
      Q5p = U5
      Q6p = U6
      Q7p = U7
      Q8p = U8
      Q9p = U9
      Q10p = U10
      Q11p = U11
      RMTP = Q11
      Z(1) = COS(Q3)
      Z(2) = SIN(Q3)
      Z(3) = COS(Q8)
      Z(4) = SIN(Q8)
      Z(5) = COS(Q4)
      Z(6) = SIN(Q4)
      Z(7) = COS(Q9)
      Z(8) = SIN(Q9)
      Z(9) = COS(Q5)
      Z(10) = SIN(Q5)
      Z(11) = COS(Q10)
      Z(12) = SIN(Q10)
      Z(13) = COS(Q6)
      Z(14) = SIN(Q6)
      Z(15) = COS(Q11)
      Z(16) = SIN(Q11)
      Z(17) = COS(Q7)
      Z(18) = SIN(Q7)
      Z(29) = Z(13)*Z(17) - Z(14)*Z(18)
      Z(30) = -Z(13)*Z(18) - Z(14)*Z(17)
      Z(31) = Z(13)*Z(18) + Z(14)*Z(17)
      Z(32) = -Z(5)*Z(9) - Z(6)*Z(10)
      Z(33) = Z(6)*Z(9) - Z(5)*Z(10)
      Z(34) = Z(5)*Z(10) - Z(6)*Z(9)
      Z(35) = Z(1)*Z(32) - Z(2)*Z(33)
      Z(36) = Z(1)*Z(33) + Z(2)*Z(32)
      Z(37) = Z(1)*Z(34) - Z(2)*Z(32)
      Z(38) = Z(1)*Z(32) + Z(2)*Z(34)
      Z(39) = Z(29)*Z(35) + Z(30)*Z(37)
      Z(40) = Z(29)*Z(36) + Z(30)*Z(38)
      Z(41) = Z(29)*Z(37) + Z(31)*Z(35)
      Z(42) = Z(29)*Z(38) + Z(31)*Z(36)
      POP2X = Q1 - LFF*Z(39)
      POP2Y = Q2 - LFF*Z(40)
      Z(43) = -Z(27)*Z(13) - Z(28)*Z(14)
      Z(45) = Z(28)*Z(13) - Z(27)*Z(14)
      Z(49) = Z(36)*Z(45) + Z(38)*Z(43)
      Z(53) = -Z(13)*Z(38) - Z(14)*Z(36)
      Z(54) = Z(1)*Z(5) + Z(2)*Z(6)
      Z(55) = Z(2)*Z(5) - Z(1)*Z(6)
      Z(57) = Z(1)*Z(3) + Z(2)*Z(4)
      Z(58) = Z(2)*Z(3) - Z(1)*Z(4)
      Z(61) = -Z(7)*Z(58) - Z(8)*Z(57)
      Z(63) = Z(8)*Z(58) - Z(7)*Z(57)
      Z(65) = Z(12)*Z(63) - Z(11)*Z(61)
      Z(67) = -Z(11)*Z(63) - Z(12)*Z(61)
      Z(71) = Z(27)*Z(67) - Z(28)*Z(65)
      Z(73) = Z(16)*Z(67) - Z(15)*Z(65)
      Z(75) = -Z(15)*Z(67) - Z(16)*Z(65)
      Z(107) = U9 - U8
      Z(112) = U5 - U4
      Z(113) = U9 - U10 - U8
      Z(118) = U5 - U4 - U6
      Z(123) = U9 - U10 - U11 - U8
      Z(128) = U5 - U4 - U6 - U7
      Z(151) = LFF*Z(18)
      Z(152) = -Z(17)*Z(39) - Z(18)*Z(41)
      Z(153) = -Z(17)*Z(40) - Z(18)*Z(42)
      Z(154) = Z(18)*Z(39) - Z(17)*Z(41)
      Z(155) = Z(18)*Z(40) - Z(17)*Z(42)
      Z(156) = LFF*Z(17)
      Z(157) = Z(156) - LRF
      Z(158) = LRF - Z(156)
      Z(159) = Z(13)*Z(151) - Z(14)*Z(158)
      Z(160) = Z(13)*Z(151) + Z(14)*Z(156)
      Z(161) = -Z(13)*Z(151) - Z(14)*Z(157)
      Z(162) = -Z(13)*Z(152) - Z(14)*Z(154)
      Z(163) = -Z(13)*Z(153) - Z(14)*Z(155)
      Z(164) = Z(13)*Z(156) - Z(14)*Z(151)
      Z(165) = Z(14)*Z(152) - Z(13)*Z(154)
      Z(166) = Z(14)*Z(153) - Z(13)*Z(155)
      Z(167) = Z(14)*Z(151) - Z(13)*Z(157)
      Z(168) = -Z(13)*Z(158) - Z(14)*Z(151)
      Z(169) = Z(167) - LSHO
      Z(170) = LSHO + Z(168)
      Z(171) = Z(167) - LSH
      Z(172) = LSH + Z(168)
      Z(173) = Z(10)*Z(164) - Z(9)*Z(160)
      Z(174) = Z(10)*Z(165) - Z(9)*Z(162)
      Z(175) = Z(10)*Z(166) - Z(9)*Z(163)
      Z(176) = Z(10)*Z(168) - Z(9)*Z(159)
      Z(177) = Z(10)*Z(171) - Z(9)*Z(161)
      Z(178) = Z(10)*Z(172) - Z(9)*Z(159)
      Z(179) = -Z(9)*Z(164) - Z(10)*Z(160)
      Z(180) = -Z(9)*Z(165) - Z(10)*Z(162)
      Z(181) = -Z(9)*Z(166) - Z(10)*Z(163)
      Z(182) = -Z(9)*Z(168) - Z(10)*Z(159)
      Z(183) = -Z(9)*Z(171) - Z(10)*Z(161)
      Z(184) = -Z(9)*Z(172) - Z(10)*Z(159)
      Z(185) = Z(183) - LTHO
      Z(186) = LTHO + Z(184)
      Z(187) = Z(183) - LTH
      Z(188) = LTH + Z(184)
      Z(189) = Z(3)*Z(5) + Z(4)*Z(6)
      Z(190) = Z(4)*Z(5) - Z(3)*Z(6)
      Z(191) = Z(3)*Z(6) - Z(4)*Z(5)
      Z(192) = Z(173)*Z(189) + Z(179)*Z(191)
      Z(193) = Z(174)*Z(189) + Z(180)*Z(191)
      Z(194) = Z(175)*Z(189) + Z(181)*Z(191)
      Z(195) = Z(176)*Z(189) + Z(182)*Z(191)
      Z(196) = Z(177)*Z(189) + Z(187)*Z(191)
      Z(197) = Z(177)*Z(189) + Z(183)*Z(191)
      Z(198) = Z(178)*Z(189) + Z(188)*Z(191)
      Z(199) = Z(173)*Z(190) + Z(179)*Z(189)
      Z(200) = Z(174)*Z(190) + Z(180)*Z(189)
      Z(201) = Z(175)*Z(190) + Z(181)*Z(189)
      Z(202) = Z(176)*Z(190) + Z(182)*Z(189)
      Z(203) = Z(177)*Z(190) + Z(183)*Z(189)
      Z(204) = Z(177)*Z(190) + Z(187)*Z(189)
      Z(205) = Z(178)*Z(190) + Z(188)*Z(189)
      Z(206) = Z(93) + Z(204)
      Z(207) = LTH + Z(204)
      Z(208) = LTH*Z(8)
      Z(209) = -Z(7)*Z(192) - Z(8)*Z(199)
      Z(210) = -Z(7)*Z(193) - Z(8)*Z(200)
      Z(211) = -Z(7)*Z(194) - Z(8)*Z(201)
      Z(212) = -Z(7)*Z(195) - Z(8)*Z(202)
      Z(213) = -Z(7)*Z(197) - Z(8)*Z(203)
      Z(214) = -Z(7)*Z(198) - Z(8)*Z(205)
      Z(215) = -Z(7)*Z(196) - Z(8)*Z(207)
      Z(216) = Z(8)*Z(192) - Z(7)*Z(199)
      Z(217) = Z(8)*Z(193) - Z(7)*Z(200)
      Z(218) = Z(8)*Z(194) - Z(7)*Z(201)
      Z(219) = Z(8)*Z(195) - Z(7)*Z(202)
      Z(220) = Z(8)*Z(196) - Z(7)*Z(207)
      Z(221) = Z(8)*Z(197) - Z(7)*Z(203)
      Z(222) = Z(8)*Z(198) - Z(7)*Z(205)
      Z(223) = LTH*Z(7)
      Z(224) = Z(92) + Z(220)
      Z(225) = Z(223) - Z(92)
      Z(226) = LSH + Z(220)
      Z(227) = Z(223) - LSH
      Z(232) = LSH*Z(12)
      Z(233) = Z(12)*Z(216) - Z(11)*Z(209)
      Z(234) = Z(12)*Z(217) - Z(11)*Z(210)
      Z(235) = Z(12)*Z(218) - Z(11)*Z(211)
      Z(236) = Z(12)*Z(219) - Z(11)*Z(212)
      Z(237) = Z(12)*Z(221) - Z(11)*Z(213)
      Z(238) = Z(12)*Z(222) - Z(11)*Z(214)
      Z(239) = Z(12)*Z(226) - Z(11)*Z(215)
      Z(240) = Z(12)*Z(227) - Z(11)*Z(208)
      Z(241) = -Z(11)*Z(227) - Z(12)*Z(208)
      Z(242) = -Z(11)*Z(216) - Z(12)*Z(209)
      Z(243) = -Z(11)*Z(217) - Z(12)*Z(210)
      Z(244) = -Z(11)*Z(218) - Z(12)*Z(211)
      Z(245) = -Z(11)*Z(219) - Z(12)*Z(212)
      Z(246) = -Z(11)*Z(221) - Z(12)*Z(213)
      Z(247) = -Z(11)*Z(222) - Z(12)*Z(214)
      Z(248) = -Z(11)*Z(226) - Z(12)*Z(215)
      Z(249) = LSH*Z(11)
      Z(250) = Z(241) - LRF
      Z(251) = LRF + Z(248)
      Z(252) = LRF - Z(249)
      Z(253) = Z(16)*Z(252) - Z(15)*Z(232)
      Z(254) = Z(16)*Z(242) - Z(15)*Z(233)
      Z(255) = Z(16)*Z(243) - Z(15)*Z(234)
      Z(256) = Z(16)*Z(244) - Z(15)*Z(235)
      Z(257) = Z(16)*Z(245) - Z(15)*Z(236)
      Z(258) = Z(16)*Z(246) - Z(15)*Z(237)
      Z(259) = Z(16)*Z(247) - Z(15)*Z(238)
      Z(260) = Z(16)*Z(251) - Z(15)*Z(239)
      Z(261) = Z(16)*Z(250) - Z(15)*Z(240)
      Z(262) = LRF*Z(16)
      Z(263) = LRF*Z(15)
      Z(264) = -Z(15)*Z(242) - Z(16)*Z(233)
      Z(265) = -Z(15)*Z(243) - Z(16)*Z(234)
      Z(266) = -Z(15)*Z(244) - Z(16)*Z(235)
      Z(267) = -Z(15)*Z(245) - Z(16)*Z(236)
      Z(268) = -Z(15)*Z(246) - Z(16)*Z(237)
      Z(269) = -Z(15)*Z(247) - Z(16)*Z(238)
      Z(270) = -Z(15)*Z(250) - Z(16)*Z(240)
      Z(271) = -Z(15)*Z(251) - Z(16)*Z(239)
      Z(272) = -Z(15)*Z(252) - Z(16)*Z(232)
      Z(273) = Z(263) - Z(90)
      Z(274) = Z(270) - Z(90)
      Z(275) = Z(90) + Z(271)
      Z(276) = Z(90) + Z(272)
      Z(281) = Z(5)*Z(173) + Z(6)*Z(179)
      Z(282) = Z(5)*Z(174) + Z(6)*Z(180)
      Z(283) = Z(5)*Z(175) + Z(6)*Z(181)
      Z(284) = Z(5)*Z(176) + Z(6)*Z(182)
      Z(285) = Z(5)*Z(177) + Z(6)*Z(187)
      Z(286) = Z(5)*Z(177) + Z(6)*Z(183)
      Z(287) = Z(5)*Z(178) + Z(6)*Z(188)
      Z(288) = Z(5)*Z(179) - Z(6)*Z(173)
      Z(289) = Z(5)*Z(180) - Z(6)*Z(174)
      Z(290) = Z(5)*Z(181) - Z(6)*Z(175)
      Z(291) = Z(5)*Z(182) - Z(6)*Z(176)
      Z(292) = Z(5)*Z(183) - Z(6)*Z(177)
      Z(293) = Z(5)*Z(187) - Z(6)*Z(177)
      Z(294) = Z(5)*Z(188) - Z(6)*Z(178)
      Z(295) = LHATO + Z(293)
      Z(296) = LHAT + Z(293)
      VOP2X = Z(39)*(Z(39)*U1+Z(40)*U2) - Z(41)*(LFF*U3+LFF*U5-LFF*U4-LF
     &F*U6-LFF*U7-Z(41)*U1-Z(42)*U2)
      VOP2Y = Z(40)*(Z(39)*U1+Z(40)*U2) - Z(42)*(LFF*U3+LFF*U5-LFF*U4-LF
     &F*U6-LFF*U7-Z(41)*U1-Z(42)*U2)
      Z(391) = LFFO*(U3+U5-U4-U6-U7)*(U3+Z(128))
      Z(392) = LFF*(U3+U5-U4-U6-U7)*(U3+Z(128))
      Z(393) = LRFO*(U3+U5-U4-U6)*(U3+Z(118))
      Z(394) = LRFFO*(U3+U5-U4-U6)*(U3+Z(118))
      Z(395) = Z(17)*Z(392)
      Z(396) = Z(18)*Z(392)
      Z(397) = LRF*(U3+U5-U4-U6)*(U3+Z(118)) - Z(395)
      Z(398) = -Z(13)*Z(397) - Z(14)*Z(396)
      Z(399) = Z(14)*Z(397) - Z(13)*Z(396)
      Z(400) = Z(398) - LSHO*(U4-U3-U5)*(U3+Z(112))
      Z(401) = Z(398) - LSH*(U4-U3-U5)*(U3+Z(112))
      Z(402) = Z(10)*Z(399) - Z(9)*Z(401)
      Z(403) = -Z(9)*Z(399) - Z(10)*Z(401)
      Z(404) = LTHO*(U3-U4)**2 + Z(402)
      Z(405) = LTH*(U3-U4)**2 + Z(402)
      Z(406) = Z(189)*Z(405) + Z(191)*Z(403)
      Z(407) = Z(189)*Z(403) + Z(190)*Z(405)
      Z(408) = Z(406) - Z(93)*(U3-U8)**2
      Z(409) = Z(406) - LTH*(U3-U8)**2
      Z(410) = -Z(7)*Z(409) - Z(8)*Z(407)
      Z(411) = Z(8)*Z(409) - Z(7)*Z(407)
      Z(412) = Z(410) + Z(92)*(U8-U3-U9)*(U3+Z(107))
      Z(413) = Z(410) + LSH*(U8-U3-U9)*(U3+Z(107))
      Z(414) = Z(91)*(U10+U8-U3-U9)*(U3+Z(113))
      Z(415) = LRFFO*(U10+U8-U3-U9)*(U3+Z(113))
      Z(416) = Z(12)*Z(411) - Z(11)*Z(413)
      Z(417) = -Z(11)*Z(411) - Z(12)*Z(413)
      Z(418) = Z(416) + LRF*(U10+U8-U3-U9)*(U3+Z(113))
      Z(419) = Z(16)*Z(417) - Z(15)*Z(418)
      Z(420) = -Z(15)*Z(417) - Z(16)*Z(418)
      Z(421) = Z(419) + Z(90)*(U10+U11+U8-U3-U9)*(U3+Z(123))
      Z(423) = Z(5)*Z(405) + Z(6)*Z(403)
      Z(424) = Z(5)*Z(403) - Z(6)*Z(405)
      Z(425) = LHATO*U3
      Z(426) = Z(423) - U3*Z(425)
      Z(427) = LHAT*U3
      Z(428) = Z(423) - U3*Z(427)
      DX1 = Q1 - TOEXI
      DX2 = POP2X - MTPXI
      RY1 = -K3*Q2 - K4*ABS(Q2)*U2
      RX1 = -(K1*DX1+K2*U1)*RY1
      RY2 = -K7*POP2Y - K8*ABS(POP2Y)*VOP2Y
      RX2 = -RY2*(K5*DX2+K6*VOP2X)
      Z(481) = Z(28)*Z(18) - Z(27)*Z(17)
      Z(482) = Z(27)*Z(18) + Z(28)*Z(17)
      Z(483) = -Z(27)*Z(18) - Z(28)*Z(17)
      Z(484) = -Z(27)*Z(11) - Z(28)*Z(12)
      Z(485) = Z(27)*Z(12) - Z(28)*Z(11)
      Z(486) = Z(28)*Z(11) - Z(27)*Z(12)
      Z(1124) = Z(1038)*Z(217) + MFF*(Z(253)*Z(255)+Z(265)*Z(276)) + 0.5
     &D0*MRF*(2*LSH*Z(217)-2*Z(91)*Z(11)*Z(217)-2*Z(91)*Z(12)*Z(210)-LRF
     &FO*Z(210)*Z(486)-LRFFO*Z(217)*Z(484))
      Z(1125) = MFF*(Z(255)*Z(261)+Z(265)*Z(274)) + MSH*(Z(208)*Z(210)+Z
     &(217)*Z(225)) + 0.5D0*MRF*(2*Z(208)*Z(210)+2*Z(217)*Z(227)+LRFFO*Z
     &(210)*Z(486)+LRFFO*Z(217)*Z(484)+2*Z(91)*Z(11)*Z(217)+2*Z(91)*Z(12
     &)*Z(210)) - Z(1061)*Z(200)
      Z(1126) = 0.5D0*MRF*(LRFFO*Z(210)*Z(486)+LRFFO*Z(217)*Z(484)+2*Z(9
     &1)*Z(11)*Z(217)+2*Z(91)*Z(12)*Z(210)) - MFF*(Z(255)*Z(262)-Z(265)*
     &Z(273))
      Z(1127) = Z(993)*Z(265)
      Z(1135) = Z(1038)*Z(218) + MFF*(Z(253)*Z(256)+Z(266)*Z(276)) + 0.5
     &D0*MRF*(2*LSH*Z(218)-2*Z(91)*Z(11)*Z(218)-2*Z(91)*Z(12)*Z(211)-LRF
     &FO*Z(211)*Z(486)-LRFFO*Z(218)*Z(484))
      Z(1136) = MFF*(Z(256)*Z(261)+Z(266)*Z(274)) + MSH*(Z(208)*Z(211)+Z
     &(218)*Z(225)) + 0.5D0*MRF*(2*Z(208)*Z(211)+2*Z(218)*Z(227)+LRFFO*Z
     &(211)*Z(486)+LRFFO*Z(218)*Z(484)+2*Z(91)*Z(11)*Z(218)+2*Z(91)*Z(12
     &)*Z(211)) - Z(1061)*Z(201)
      Z(1137) = 0.5D0*MRF*(LRFFO*Z(211)*Z(486)+LRFFO*Z(218)*Z(484)+2*Z(9
     &1)*Z(11)*Z(218)+2*Z(91)*Z(12)*Z(211)) - MFF*(Z(256)*Z(262)-Z(266)*
     &Z(273))
      Z(1138) = Z(993)*Z(266)
      Z(1155) = Z(1153) - MFF*(Z(260)*Z(262)-Z(273)*Z(275)) - 0.25D0*MRF
     &*(Z(1154)-4*Z(91)*Z(11)*Z(226)-4*Z(91)*Z(12)*Z(215)-2*LRFFO*Z(215)
     &*Z(486)-2*LRFFO*Z(226)*Z(484))
      Z(1156) = -IFF - Z(993)*Z(275)
      Z(1157) = MFF*(Z(260)*Z(261)+Z(274)*Z(275)) + MSH*(Z(208)*Z(215)+Z
     &(224)*Z(225)) - IFF - IRF - ISH - ITH - Z(1061)*Z(206) - 0.25D0*MR
     &F*(Z(1144)+2*LRFFO*Z(208)*Z(486)+2*LRFFO*Z(227)*Z(484)+4*Z(91)*Z(1
     &1)*Z(227)+4*Z(91)*Z(12)*Z(208)-4*Z(1145)-4*Z(208)*Z(215)-4*Z(226)*
     &Z(227)-4*Z(91)*Z(11)*Z(226)-4*Z(91)*Z(12)*Z(215)-2*LRFFO*Z(215)*Z(
     &486)-2*LRFFO*Z(226)*Z(484))
      Z(1161) = Z(1158) + Z(1038)*Z(224) + MFF*(Z(253)*Z(260)+Z(275)*Z(2
     &76)) + 0.25D0*MRF*(Z(1144)+4*LSH*Z(226)-4*Z(1145)-4*Z(1159)*Z(11)-
     &2*Z(1160)*Z(484)-4*Z(91)*Z(11)*Z(226)-4*Z(91)*Z(12)*Z(215)-2*LRFFO
     &*Z(215)*Z(486)-2*LRFFO*Z(226)*Z(484))
      Z(1173) = Z(1038)*Z(222) + MFF*(Z(253)*Z(259)+Z(269)*Z(276)) + 0.5
     &D0*MRF*(2*LSH*Z(222)-2*Z(91)*Z(11)*Z(222)-2*Z(91)*Z(12)*Z(214)-LRF
     &FO*Z(214)*Z(486)-LRFFO*Z(222)*Z(484))
      Z(1174) = MFF*(Z(259)*Z(261)+Z(269)*Z(274)) + MSH*(Z(208)*Z(214)+Z
     &(222)*Z(225)) + 0.5D0*MRF*(2*Z(208)*Z(214)+2*Z(222)*Z(227)+LRFFO*Z
     &(214)*Z(486)+LRFFO*Z(222)*Z(484)+2*Z(91)*Z(11)*Z(222)+2*Z(91)*Z(12
     &)*Z(214)) - Z(1061)*Z(205)
      Z(1175) = 0.5D0*MRF*(LRFFO*Z(214)*Z(486)+LRFFO*Z(222)*Z(484)+2*Z(9
     &1)*Z(11)*Z(222)+2*Z(91)*Z(12)*Z(214)) - MFF*(Z(259)*Z(262)-Z(269)*
     &Z(273))
      Z(1176) = Z(993)*Z(269)
      Z(1181) = Z(1038)*Z(221) + MFF*(Z(253)*Z(258)+Z(268)*Z(276)) + 0.5
     &D0*MRF*(2*LSH*Z(221)-2*Z(91)*Z(11)*Z(221)-2*Z(91)*Z(12)*Z(213)-LRF
     &FO*Z(213)*Z(486)-LRFFO*Z(221)*Z(484))
      Z(1182) = MFF*(Z(258)*Z(261)+Z(268)*Z(274)) + MSH*(Z(208)*Z(213)+Z
     &(221)*Z(225)) + 0.5D0*MRF*(2*Z(208)*Z(213)+2*Z(221)*Z(227)+LRFFO*Z
     &(213)*Z(486)+LRFFO*Z(221)*Z(484)+2*Z(91)*Z(11)*Z(221)+2*Z(91)*Z(12
     &)*Z(213)) - Z(1061)*Z(203)
      Z(1183) = 0.5D0*MRF*(LRFFO*Z(213)*Z(486)+LRFFO*Z(221)*Z(484)+2*Z(9
     &1)*Z(11)*Z(221)+2*Z(91)*Z(12)*Z(213)) - MFF*(Z(258)*Z(262)-Z(268)*
     &Z(273))
      Z(1184) = Z(993)*Z(268)
      Z(1188) = Z(1038)*Z(219) + MFF*(Z(253)*Z(257)+Z(267)*Z(276)) + 0.5
     &D0*MRF*(2*LSH*Z(219)-2*Z(91)*Z(11)*Z(219)-2*Z(91)*Z(12)*Z(212)-LRF
     &FO*Z(212)*Z(486)-LRFFO*Z(219)*Z(484))
      Z(1189) = MFF*(Z(257)*Z(261)+Z(267)*Z(274)) + MSH*(Z(208)*Z(212)+Z
     &(219)*Z(225)) + 0.5D0*MRF*(2*Z(208)*Z(212)+2*Z(219)*Z(227)+LRFFO*Z
     &(212)*Z(486)+LRFFO*Z(219)*Z(484)+2*Z(91)*Z(11)*Z(219)+2*Z(91)*Z(12
     &)*Z(212)) - Z(1061)*Z(202)
      Z(1190) = 0.5D0*MRF*(LRFFO*Z(212)*Z(486)+LRFFO*Z(219)*Z(484)+2*Z(9
     &1)*Z(11)*Z(219)+2*Z(91)*Z(12)*Z(212)) - MFF*(Z(257)*Z(262)-Z(267)*
     &Z(273))
      Z(1191) = Z(993)*Z(267)
      Z(1195) = Z(1038)*Z(216) + MFF*(Z(253)*Z(254)+Z(264)*Z(276)) + 0.5
     &D0*MRF*(2*LSH*Z(216)-2*Z(91)*Z(11)*Z(216)-2*Z(91)*Z(12)*Z(209)-LRF
     &FO*Z(209)*Z(486)-LRFFO*Z(216)*Z(484))
      Z(1196) = MFF*(Z(254)*Z(261)+Z(264)*Z(274)) + MSH*(Z(208)*Z(209)+Z
     &(216)*Z(225)) + 0.5D0*MRF*(2*Z(208)*Z(209)+2*Z(216)*Z(227)+LRFFO*Z
     &(209)*Z(486)+LRFFO*Z(216)*Z(484)+2*Z(91)*Z(11)*Z(216)+2*Z(91)*Z(12
     &)*Z(209)) - Z(1061)*Z(199)
      Z(1197) = 0.5D0*MRF*(LRFFO*Z(209)*Z(486)+LRFFO*Z(216)*Z(484)+2*Z(9
     &1)*Z(11)*Z(216)+2*Z(91)*Z(12)*Z(209)) - MFF*(Z(254)*Z(262)-Z(264)*
     &Z(273))
      Z(1198) = Z(993)*Z(264)
      Z(1202) = Z(1200) - MFF*(Z(261)*Z(262)-Z(273)*Z(274)) - 0.25D0*MRF
     &*(Z(1201)-4*Z(91)*Z(11)*Z(227)-4*Z(91)*Z(12)*Z(208)-2*LRFFO*Z(208)
     &*Z(486)-2*LRFFO*Z(227)*Z(484))
      Z(1203) = IFF - Z(993)*Z(274)
      Z(1205) = Z(1204) + MFF*(Z(261)**2+Z(274)**2) + MSH*(Z(208)**2+Z(2
     &25)**2) - 0.25D0*MRF*(Z(1201)-4*Z(208)**2-4*Z(227)**2-8*Z(91)*Z(11
     &)*Z(227)-8*Z(91)*Z(12)*Z(208)-4*LRFFO*Z(208)*Z(486)-4*LRFFO*Z(227)
     &*Z(484))
      Z(1208) = Z(1038)*Z(225) + MFF*(Z(253)*Z(261)+Z(274)*Z(276)) + 0.2
     &5D0*MRF*(4*Z(1145)+2*Z(1160)*Z(484)+4*LSH*Z(227)+4*Z(1159)*Z(11)-4
     &*Z(1207)-Z(1206)-4*Z(91)*Z(11)*Z(227)-4*Z(91)*Z(12)*Z(208)-2*LRFFO
     &*Z(208)*Z(486)-2*LRFFO*Z(227)*Z(484)) - IFF - IRF - ISH
      Z(1209) = MFF*(Z(261)*Z(421)+Z(274)*Z(420)) + MSH*(Z(208)*Z(412)+Z
     &(225)*Z(411)) + 0.5D0*MRF*(Z(1164)*Z(415)+2*Z(208)*Z(413)+2*Z(227)
     &*Z(411)+LRFFO*Z(484)*Z(411)+LRFFO*Z(486)*Z(413)+2*Z(91)*Z(11)*Z(41
     &1)+2*Z(91)*Z(12)*Z(413)+2*Z(12)*Z(227)*Z(414)-Z(1162)*Z(414)-2*Z(1
     &1)*Z(208)*Z(414)-Z(208)*Z(484)*Z(415)-Z(227)*Z(485)*Z(415)) - Z(10
     &61)*Z(407)
      Z(1210) = Z(1153) - MFF*(Z(253)*Z(262)-Z(273)*Z(276)) - 0.25D0*MRF
     &*(Z(1154)-4*Z(1159)*Z(11)-2*Z(1160)*Z(484))
      Z(1211) = -IFF - Z(993)*Z(276)
      Z(1214) = Z(1212) + MFF*(Z(253)**2+Z(276)**2) + 0.25D0*MRF*(Z(1213
     &)-8*Z(1159)*Z(11)-4*Z(1160)*Z(484))
      Z(1215) = Z(1038)*Z(411) + MFF*(Z(253)*Z(421)+Z(276)*Z(420)) + 0.5
     &D0*MRF*(Z(1162)*Z(414)+2*LSH*Z(411)+2*LSH*Z(12)*Z(414)-Z(1164)*Z(4
     &15)-2*Z(91)*Z(11)*Z(411)-2*Z(91)*Z(12)*Z(413)-LRFFO*Z(484)*Z(411)-
     &LRFFO*Z(486)*Z(413)-LSH*Z(485)*Z(415))
      Z(1217) = Z(1216) + MFF*(Z(262)**2+Z(273)**2)
      Z(1218) = IFF - Z(993)*Z(273)
      Z(1219) = -MFF*(Z(262)*Z(421)-Z(273)*Z(420)) - 0.5D0*MRF*(Z(1162)*
     &Z(414)-Z(1164)*Z(415)-2*Z(91)*Z(11)*Z(411)-2*Z(91)*Z(12)*Z(413)-LR
     &FFO*Z(484)*Z(411)-LRFFO*Z(486)*Z(413))
      Z(1221) = Z(993)*Z(420)

C**   Quantities which were specified
      LHTQ = LHE*LHF*T**3
      LKTQ = LKE*LKF*T**3
      LATQ = LAE*LAF*T**3
      LMTQ = MTPK*(3.141592653589793D0-Q7) - MTPB*U7
      RHTQ = RHE*RHF*T**3
      RKTQ = RKE*RKF*T**3
      RATQ = RAE*RAF*T**3
      RMTQ = MTPK*(3.141592653589793D0-RMTP) - MTPB*U11

      Z(470) = LHTQ + RHTQ
      Z(471) = -RHTQ - RKTQ
      Z(472) = -LHTQ - LKTQ
      Z(473) = RATQ + RKTQ
      Z(474) = LATQ + LKTQ
      Z(475) = RMTQ - RATQ
      Z(476) = LMTQ - LATQ
      Z(1087) = RMTQ + Z(464)*(Z(73)*Z(261)+Z(75)*Z(274)) + Z(467)*(Z(61
     &)*Z(208)+Z(63)*Z(225)) - Z(471) - Z(473) - Z(475) - Z(1086)*Z(57) 
     &- 0.5D0*Z(466)*(2*Z(91)*Z(67)-2*Z(61)*Z(208)-2*Z(63)*Z(227)-LRFFO*
     &Z(71))
      Z(1089) = Z(473) + Z(475) + Z(1088)*Z(63) + Z(464)*(Z(73)*Z(253)+Z
     &(75)*Z(276)) - RMTQ - 0.5D0*Z(466)*(LRFFO*Z(71)-2*LSH*Z(63)-2*Z(91
     &)*Z(67))
      Z(1090) = RMTQ + 0.5D0*Z(466)*(LRFFO*Z(71)-2*Z(91)*Z(67)) - Z(475)
     & - Z(464)*(Z(73)*Z(262)-Z(75)*Z(273))
      Z(1092) = RMTQ - Z(1091)*Z(75)
      Z(1262) = Z(1087) - Z(1209)
      Z(1263) = Z(1089) - Z(1215)
      Z(1264) = Z(1090) - Z(1219)
      Z(1265) = Z(1092) + Z(1221)

C**   Quantities to be specified
      LE = 0
      LS = 0
      RE = 0
      RS = 0
      LEp = 0
      LSp = 0
      REp = 0
      RSp = 0
      LEpp = 0
      LSpp = 0
      REpp = 0
      RSpp = 0

      Z(19) = COS(RS)
      Z(20) = SIN(RS)
      Z(21) = COS(LS)
      Z(22) = SIN(LS)
      Z(23) = COS(RE)
      Z(24) = SIN(RE)
      Z(25) = COS(LE)
      Z(26) = SIN(LE)
      Z(76) = -Z(19)*Z(1) - Z(20)*Z(2)
      Z(77) = Z(20)*Z(1) - Z(19)*Z(2)
      Z(80) = -Z(23)*Z(77) - Z(24)*Z(76)
      Z(82) = Z(24)*Z(77) - Z(23)*Z(76)
      Z(83) = -Z(21)*Z(1) - Z(22)*Z(2)
      Z(84) = Z(22)*Z(1) - Z(21)*Z(2)
      Z(87) = -Z(25)*Z(84) - Z(26)*Z(83)
      Z(89) = Z(26)*Z(84) - Z(25)*Z(83)
      Z(133) = U12 - RSp
      Z(134) = U13 - LSp
      Z(136) = REpp - RSpp
      Z(142) = LEpp - LSpp
      Z(297) = Z(20)*Z(288) - Z(19)*Z(281)
      Z(298) = Z(20)*Z(289) - Z(19)*Z(282)
      Z(299) = Z(20)*Z(290) - Z(19)*Z(283)
      Z(300) = Z(20)*Z(291) - Z(19)*Z(284)
      Z(301) = Z(20)*Z(292) - Z(19)*Z(286)
      Z(302) = Z(20)*Z(294) - Z(19)*Z(287)
      Z(303) = Z(20)*Z(296) - Z(19)*Z(285)
      Z(304) = -Z(19)*Z(288) - Z(20)*Z(281)
      Z(305) = -Z(19)*Z(289) - Z(20)*Z(282)
      Z(306) = -Z(19)*Z(290) - Z(20)*Z(283)
      Z(307) = -Z(19)*Z(291) - Z(20)*Z(284)
      Z(308) = -Z(19)*Z(292) - Z(20)*Z(286)
      Z(309) = -Z(19)*Z(294) - Z(20)*Z(287)
      Z(310) = -Z(19)*Z(296) - Z(20)*Z(285)
      Z(311) = LUAO*RSp
      Z(312) = LUAO + Z(310)
      Z(313) = LUA*RSp
      Z(314) = LUA + Z(310)
      Z(316) = -Z(23)*Z(297) - Z(24)*Z(304)
      Z(317) = -Z(23)*Z(298) - Z(24)*Z(305)
      Z(318) = -Z(23)*Z(299) - Z(24)*Z(306)
      Z(319) = -Z(23)*Z(300) - Z(24)*Z(307)
      Z(320) = -Z(23)*Z(301) - Z(24)*Z(308)
      Z(321) = -Z(23)*Z(302) - Z(24)*Z(309)
      Z(322) = -Z(23)*Z(303) - Z(24)*Z(314)
      Z(324) = Z(24)*Z(297) - Z(23)*Z(304)
      Z(325) = Z(24)*Z(298) - Z(23)*Z(305)
      Z(326) = Z(24)*Z(299) - Z(23)*Z(306)
      Z(327) = Z(24)*Z(300) - Z(23)*Z(307)
      Z(328) = Z(24)*Z(301) - Z(23)*Z(308)
      Z(329) = Z(24)*Z(302) - Z(23)*Z(309)
      Z(330) = Z(24)*Z(303) - Z(23)*Z(314)
      Z(333) = REp - RSp
      Z(334) = LLAO*Z(333)
      Z(336) = LLAO + Z(330)
      Z(342) = Z(22)*Z(288) - Z(21)*Z(281)
      Z(343) = Z(22)*Z(289) - Z(21)*Z(282)
      Z(344) = Z(22)*Z(290) - Z(21)*Z(283)
      Z(345) = Z(22)*Z(291) - Z(21)*Z(284)
      Z(346) = Z(22)*Z(292) - Z(21)*Z(286)
      Z(347) = Z(22)*Z(294) - Z(21)*Z(287)
      Z(348) = Z(22)*Z(296) - Z(21)*Z(285)
      Z(349) = -Z(21)*Z(288) - Z(22)*Z(281)
      Z(350) = -Z(21)*Z(289) - Z(22)*Z(282)
      Z(351) = -Z(21)*Z(290) - Z(22)*Z(283)
      Z(352) = -Z(21)*Z(291) - Z(22)*Z(284)
      Z(353) = -Z(21)*Z(292) - Z(22)*Z(286)
      Z(354) = -Z(21)*Z(294) - Z(22)*Z(287)
      Z(355) = -Z(21)*Z(296) - Z(22)*Z(285)
      Z(356) = LUAO*LSp
      Z(357) = LUAO + Z(355)
      Z(358) = LUA*LSp
      Z(359) = LUA + Z(355)
      Z(361) = -Z(25)*Z(342) - Z(26)*Z(349)
      Z(362) = -Z(25)*Z(343) - Z(26)*Z(350)
      Z(363) = -Z(25)*Z(344) - Z(26)*Z(351)
      Z(364) = -Z(25)*Z(345) - Z(26)*Z(352)
      Z(365) = -Z(25)*Z(346) - Z(26)*Z(353)
      Z(366) = -Z(25)*Z(347) - Z(26)*Z(354)
      Z(367) = -Z(25)*Z(348) - Z(26)*Z(359)
      Z(369) = Z(26)*Z(342) - Z(25)*Z(349)
      Z(370) = Z(26)*Z(343) - Z(25)*Z(350)
      Z(371) = Z(26)*Z(344) - Z(25)*Z(351)
      Z(372) = Z(26)*Z(345) - Z(25)*Z(352)
      Z(373) = Z(26)*Z(346) - Z(25)*Z(353)
      Z(374) = Z(26)*Z(347) - Z(25)*Z(354)
      Z(375) = Z(26)*Z(348) - Z(25)*Z(359)
      Z(378) = LEp - LSp
      Z(379) = LLAO*Z(378)
      Z(381) = LLAO + Z(375)
      Z(429) = Z(20)*Z(424) - Z(19)*Z(428)
      Z(430) = -Z(19)*Z(424) - Z(20)*Z(428)
      Z(431) = LUAO*RSpp
      Z(432) = Z(429) + (Z(311)-LUAO*U12-LUAO*U3)*(U3+Z(133))
      Z(433) = Z(430) - Z(431)
      Z(434) = LUA*RSpp
      Z(435) = Z(429) + (Z(313)-LUA*U12-LUA*U3)*(U3+Z(133))
      Z(436) = Z(430) - Z(434)
      Z(437) = -Z(23)*Z(435) - Z(24)*Z(436)
      Z(438) = Z(24)*Z(435) - Z(23)*Z(436)
      Z(439) = LLAO*Z(136)
      Z(440) = Z(333) + U12 + U14
      Z(441) = Z(437) - (Z(334)+LLAO*U12+LLAO*U14+LLAO*U3)*(U3+Z(440))
      Z(442) = Z(439) + Z(438)
      Z(446) = Z(22)*Z(424) - Z(21)*Z(428)
      Z(447) = -Z(21)*Z(424) - Z(22)*Z(428)
      Z(448) = LUAO*LSpp
      Z(449) = Z(446) + (Z(356)-LUAO*U13-LUAO*U3)*(U3+Z(134))
      Z(450) = Z(447) - Z(448)
      Z(451) = LUA*LSpp
      Z(452) = Z(446) + (Z(358)-LUA*U13-LUA*U3)*(U3+Z(134))
      Z(453) = Z(447) - Z(451)
      Z(454) = -Z(25)*Z(452) - Z(26)*Z(453)
      Z(455) = Z(26)*Z(452) - Z(25)*Z(453)
      Z(456) = LLAO*Z(142)
      Z(457) = Z(378) + U13 + U15
      Z(458) = Z(454) - (Z(379)+LLAO*U13+LLAO*U15+LLAO*U3)*(U3+Z(457))
      Z(459) = Z(456) + Z(455)
      Z(1077) = Z(463)*(Z(1)*Z(289)+Z(2)*Z(282)) + Z(464)*(Z(39)*Z(40)+Z
     &(41)*Z(42)) + Z(464)*(Z(73)*Z(255)+Z(75)*Z(265)) + Z(465)*(Z(80)*Z
     &(317)+Z(82)*Z(325)) + Z(465)*(Z(87)*Z(362)+Z(89)*Z(370)) + Z(466)*
     &(Z(39)*Z(40)+Z(41)*Z(42)) + Z(466)*(Z(61)*Z(210)+Z(63)*Z(217)) + Z
     &(467)*(Z(36)*Z(162)+Z(38)*Z(165)) + Z(467)*(Z(61)*Z(210)+Z(63)*Z(2
     &17)) + Z(468)*(Z(54)*Z(180)+Z(55)*Z(174)) + Z(468)*(Z(57)*Z(200)+Z
     &(58)*Z(193)) + Z(469)*(Z(76)*Z(305)+Z(77)*Z(298)) + Z(469)*(Z(83)*
     &Z(350)+Z(84)*Z(343)) + RX1 + Z(39)*Z(40)*RY2 + Z(39)**2*RX2 + Z(41
     &)*Z(42)*RY2 + Z(41)**2*RX2
      Z(1078) = Z(463)*(Z(1)*Z(290)+Z(2)*Z(283)) + Z(464)*(Z(40)**2+Z(42
     &)**2) + Z(464)*(Z(73)*Z(256)+Z(75)*Z(266)) + Z(465)*(Z(80)*Z(318)+
     &Z(82)*Z(326)) + Z(465)*(Z(87)*Z(363)+Z(89)*Z(371)) + Z(466)*(Z(40)
     &**2+Z(42)**2) + Z(466)*(Z(61)*Z(211)+Z(63)*Z(218)) + Z(467)*(Z(36)
     &*Z(163)+Z(38)*Z(166)) + Z(467)*(Z(61)*Z(211)+Z(63)*Z(218)) + Z(468
     &)*(Z(54)*Z(181)+Z(55)*Z(175)) + Z(468)*(Z(57)*Z(201)+Z(58)*Z(194))
     & + Z(469)*(Z(76)*Z(306)+Z(77)*Z(299)) + Z(469)*(Z(83)*Z(351)+Z(84)
     &*Z(344)) + RY1 + Z(39)*Z(40)*RX2 + Z(40)**2*RY2 + Z(41)*Z(42)*RX2 
     &+ Z(42)**2*RY2
      Z(1081) = LMTQ + Z(1079)*Z(42) + Z(463)*(Z(1)*Z(294)+Z(2)*Z(287)) 
     &+ Z(464)*(Z(73)*Z(259)+Z(75)*Z(269)) + Z(465)*(Z(80)*Z(321)+Z(82)*
     &Z(329)) + Z(465)*(Z(87)*Z(366)+Z(89)*Z(374)) + Z(466)*(Z(61)*Z(214
     &)+Z(63)*Z(222)) + Z(467)*(Z(36)*Z(159)+Z(38)*Z(170)) + Z(467)*(Z(6
     &1)*Z(214)+Z(63)*Z(222)) + Z(468)*(Z(54)*Z(186)+Z(55)*Z(178)) + Z(4
     &68)*(Z(57)*Z(205)+Z(58)*Z(198)) + Z(469)*(Z(76)*Z(309)+Z(77)*Z(302
     &)) + Z(469)*(Z(83)*Z(354)+Z(84)*Z(347)) + 0.5D0*Z(466)*(LRFFO*Z(49
     &)+LRFO*Z(53)+2*LFF*Z(42)) + LFF*(Z(41)*RX2+Z(42)*RY2) - Z(472) - Z
     &(474) - Z(476)
      Z(1082) = Z(474) + Z(476) + Z(463)*(Z(1)*Z(292)+Z(2)*Z(286)) + Z(4
     &64)*(Z(73)*Z(258)+Z(75)*Z(268)) + Z(465)*(Z(80)*Z(320)+Z(82)*Z(328
     &)) + Z(465)*(Z(87)*Z(365)+Z(89)*Z(373)) + Z(466)*(Z(61)*Z(213)+Z(6
     &3)*Z(221)) + Z(467)*(Z(36)*Z(161)+Z(38)*Z(169)) + Z(467)*(Z(61)*Z(
     &213)+Z(63)*Z(221)) + Z(468)*(Z(54)*Z(183)+Z(55)*Z(177)) + Z(468)*(
     &Z(57)*Z(203)+Z(58)*Z(197)) + Z(469)*(Z(76)*Z(308)+Z(77)*Z(301)) + 
     &Z(469)*(Z(83)*Z(353)+Z(84)*Z(346)) - LMTQ - Z(1079)*Z(42) - 0.5D0*
     &Z(466)*(LRFFO*Z(49)+LRFO*Z(53)+2*LFF*Z(42)) - LFF*(Z(41)*RX2+Z(42)
     &*RY2)
      Z(1083) = LMTQ + Z(1079)*Z(42) + Z(463)*(Z(1)*Z(291)+Z(2)*Z(284)) 
     &+ Z(464)*(Z(73)*Z(257)+Z(75)*Z(267)) + Z(465)*(Z(80)*Z(319)+Z(82)*
     &Z(327)) + Z(465)*(Z(87)*Z(364)+Z(89)*Z(372)) + Z(466)*(Z(61)*Z(212
     &)+Z(63)*Z(219)) + Z(467)*(Z(36)*Z(159)+Z(38)*Z(168)) + Z(467)*(Z(6
     &1)*Z(212)+Z(63)*Z(219)) + Z(468)*(Z(54)*Z(182)+Z(55)*Z(176)) + Z(4
     &68)*(Z(57)*Z(202)+Z(58)*Z(195)) + Z(469)*(Z(76)*Z(307)+Z(77)*Z(300
     &)) + Z(469)*(Z(83)*Z(352)+Z(84)*Z(345)) + 0.5D0*Z(466)*(LRFFO*Z(49
     &)+LRFO*Z(53)+2*LFF*Z(42)) + LFF*(Z(41)*RX2+Z(42)*RY2) - Z(476)
      Z(1085) = LMTQ + Z(1079)*Z(42) + Z(1084)*Z(42) + Z(463)*(Z(1)*Z(28
     &8)+Z(2)*Z(281)) + Z(464)*(Z(73)*Z(254)+Z(75)*Z(264)) + Z(465)*(Z(8
     &0)*Z(316)+Z(82)*Z(324)) + Z(465)*(Z(87)*Z(361)+Z(89)*Z(369)) + Z(4
     &66)*(Z(61)*Z(209)+Z(63)*Z(216)) + Z(467)*(Z(36)*Z(160)+Z(38)*Z(164
     &)) + Z(467)*(Z(61)*Z(209)+Z(63)*Z(216)) + Z(468)*(Z(54)*Z(179)+Z(5
     &5)*Z(173)) + Z(468)*(Z(57)*Z(199)+Z(58)*Z(192)) + Z(469)*(Z(76)*Z(
     &304)+Z(77)*Z(297)) + Z(469)*(Z(83)*Z(349)+Z(84)*Z(342)) + LFF*(Z(4
     &1)*RX2+Z(42)*RY2)
      Z(1102) = ILA*Z(142)
      Z(1110) = IUA*LSpp
      Z(1112) = ILA*Z(136)
      Z(1116) = IUA*RSpp
      Z(1117) = Z(904)*Z(41) + Z(928)*Z(41) + MFF*(Z(254)*Z(255)+Z(264)*
     &Z(265)) + MHAT*(Z(281)*Z(282)+Z(288)*Z(289)) + MLA*(Z(316)*Z(317)+
     &Z(324)*Z(325)) + MLA*(Z(361)*Z(362)+Z(369)*Z(370)) + MRF*(Z(209)*Z
     &(210)+Z(216)*Z(217)) + MSH*(Z(160)*Z(162)+Z(164)*Z(165)) + MSH*(Z(
     &209)*Z(210)+Z(216)*Z(217)) + MTH*(Z(173)*Z(174)+Z(179)*Z(180)) + M
     &TH*(Z(192)*Z(193)+Z(199)*Z(200)) + MUA*(Z(297)*Z(298)+Z(304)*Z(305
     &)) + MUA*(Z(342)*Z(343)+Z(349)*Z(350))
      Z(1118) = MFF*(Z(39)**2+Z(41)**2) + MFF*(Z(255)**2+Z(265)**2) + MH
     &AT*(Z(282)**2+Z(289)**2) + MLA*(Z(317)**2+Z(325)**2) + MLA*(Z(362)
     &**2+Z(370)**2) + MRF*(Z(39)**2+Z(41)**2) + MRF*(Z(210)**2+Z(217)**
     &2) + MSH*(Z(162)**2+Z(165)**2) + MSH*(Z(210)**2+Z(217)**2) + MTH*(
     &Z(174)**2+Z(180)**2) + MTH*(Z(193)**2+Z(200)**2) + MUA*(Z(298)**2+
     &Z(305)**2) + MUA*(Z(343)**2+Z(350)**2)
      Z(1119) = MFF*(Z(39)*Z(40)+Z(41)*Z(42)) + MFF*(Z(255)*Z(256)+Z(265
     &)*Z(266)) + MHAT*(Z(282)*Z(283)+Z(289)*Z(290)) + MLA*(Z(317)*Z(318
     &)+Z(325)*Z(326)) + MLA*(Z(362)*Z(363)+Z(370)*Z(371)) + MRF*(Z(39)*
     &Z(40)+Z(41)*Z(42)) + MRF*(Z(210)*Z(211)+Z(217)*Z(218)) + MSH*(Z(16
     &2)*Z(163)+Z(165)*Z(166)) + MSH*(Z(210)*Z(211)+Z(217)*Z(218)) + MTH
     &*(Z(174)*Z(175)+Z(180)*Z(181)) + MTH*(Z(193)*Z(194)+Z(200)*Z(201))
     & + MUA*(Z(298)*Z(299)+Z(305)*Z(306)) + MUA*(Z(343)*Z(344)+Z(350)*Z
     &(351))
      Z(1120) = Z(904)*Z(41) + MFF*(Z(255)*Z(257)+Z(265)*Z(267)) + MHAT*
     &(Z(282)*Z(284)+Z(289)*Z(291)) + MLA*(Z(317)*Z(319)+Z(325)*Z(327)) 
     &+ MLA*(Z(362)*Z(364)+Z(370)*Z(372)) + MRF*(Z(210)*Z(212)+Z(217)*Z(
     &219)) + MSH*(Z(159)*Z(162)+Z(165)*Z(168)) + MSH*(Z(210)*Z(212)+Z(2
     &17)*Z(219)) + MTH*(Z(174)*Z(176)+Z(180)*Z(182)) + MTH*(Z(193)*Z(19
     &5)+Z(200)*Z(202)) + MUA*(Z(298)*Z(300)+Z(305)*Z(307)) + MUA*(Z(343
     &)*Z(345)+Z(350)*Z(352)) - 0.5D0*MRF*(LRFO*Z(17)*Z(41)-2*LFF*Z(41)-
     &LRFFO*Z(39)*Z(482)-LRFFO*Z(41)*Z(481)-LRFO*Z(18)*Z(39))
      Z(1121) = MFF*(Z(255)*Z(260)+Z(265)*Z(275)) + MHAT*(Z(282)*Z(285)+
     &Z(289)*Z(295)) + MLA*(Z(317)*Z(322)+Z(325)*Z(336)) + MLA*(Z(362)*Z
     &(367)+Z(370)*Z(381)) + MSH*(Z(161)*Z(162)+Z(165)*Z(169)) + MSH*(Z(
     &210)*Z(215)+Z(217)*Z(224)) + MTH*(Z(174)*Z(177)+Z(180)*Z(185)) + M
     &TH*(Z(193)*Z(196)+Z(200)*Z(206)) + MUA*(Z(298)*Z(303)+Z(305)*Z(312
     &)) + MUA*(Z(343)*Z(348)+Z(350)*Z(357)) + 0.5D0*MRF*(LRFO*Z(17)*Z(4
     &1)-2*LFF*Z(41)-LRFFO*Z(39)*Z(482)-LRFFO*Z(41)*Z(481)-LRFO*Z(18)*Z(
     &39)) + 0.5D0*MRF*(2*Z(210)*Z(215)+2*Z(217)*Z(226)-2*Z(91)*Z(11)*Z(
     &217)-2*Z(91)*Z(12)*Z(210)-LRFFO*Z(210)*Z(486)-LRFFO*Z(217)*Z(484))
     & - Z(904)*Z(41)
      Z(1122) = MFF*(Z(255)*Z(258)+Z(265)*Z(268)) + MHAT*(Z(282)*Z(286)+
     &Z(289)*Z(292)) + MLA*(Z(317)*Z(320)+Z(325)*Z(328)) + MLA*(Z(362)*Z
     &(365)+Z(370)*Z(373)) + MRF*(Z(210)*Z(213)+Z(217)*Z(221)) + MSH*(Z(
     &161)*Z(162)+Z(165)*Z(169)) + MSH*(Z(210)*Z(213)+Z(217)*Z(221)) + M
     &TH*(Z(174)*Z(177)+Z(180)*Z(183)) + MTH*(Z(193)*Z(197)+Z(200)*Z(203
     &)) + MUA*(Z(298)*Z(301)+Z(305)*Z(308)) + MUA*(Z(343)*Z(346)+Z(350)
     &*Z(353)) + 0.5D0*MRF*(LRFO*Z(17)*Z(41)-2*LFF*Z(41)-LRFFO*Z(39)*Z(4
     &82)-LRFFO*Z(41)*Z(481)-LRFO*Z(18)*Z(39)) - Z(904)*Z(41)
      Z(1123) = Z(904)*Z(41) + MFF*(Z(255)*Z(259)+Z(265)*Z(269)) + MHAT*
     &(Z(282)*Z(287)+Z(289)*Z(294)) + MLA*(Z(317)*Z(321)+Z(325)*Z(329)) 
     &+ MLA*(Z(362)*Z(366)+Z(370)*Z(374)) + MRF*(Z(210)*Z(214)+Z(217)*Z(
     &222)) + MSH*(Z(159)*Z(162)+Z(165)*Z(170)) + MSH*(Z(210)*Z(214)+Z(2
     &17)*Z(222)) + MTH*(Z(174)*Z(178)+Z(180)*Z(186)) + MTH*(Z(193)*Z(19
     &8)+Z(200)*Z(205)) + MUA*(Z(298)*Z(302)+Z(305)*Z(309)) + MUA*(Z(343
     &)*Z(347)+Z(350)*Z(354)) - 0.5D0*MRF*(LRFO*Z(17)*Z(41)-2*LFF*Z(41)-
     &LRFFO*Z(39)*Z(482)-LRFFO*Z(41)*Z(481)-LRFO*Z(18)*Z(39))
      Z(1128) = MFF*Z(39)*Z(391) + MFF*(Z(255)*Z(421)+Z(265)*Z(420)) + M
     &HAT*(Z(282)*Z(426)+Z(289)*Z(424)) + MLA*(Z(317)*Z(441)+Z(325)*Z(44
     &2)) + MLA*(Z(362)*Z(458)+Z(370)*Z(459)) + MSH*(Z(162)*Z(400)+Z(165
     &)*Z(399)) + MSH*(Z(210)*Z(412)+Z(217)*Z(411)) + MTH*(Z(174)*Z(404)
     &+Z(180)*Z(403)) + MTH*(Z(193)*Z(408)+Z(200)*Z(407)) + MUA*(Z(298)*
     &Z(432)+Z(305)*Z(433)) + MUA*(Z(343)*Z(449)+Z(350)*Z(450)) + 0.5D0*
     &MRF*(2*Z(210)*Z(413)+2*Z(217)*Z(411)+2*Z(12)*Z(217)*Z(414)-2*Z(11)
     &*Z(210)*Z(414)-Z(210)*Z(484)*Z(415)-Z(217)*Z(485)*Z(415)) - 0.5D0*
     &MRF*(Z(17)*Z(39)*Z(393)+Z(18)*Z(41)*Z(393)-2*Z(39)*Z(392)-Z(39)*Z(
     &481)*Z(394)-Z(41)*Z(483)*Z(394))
      Z(1129) = Z(904)*Z(42) + Z(928)*Z(42) + MFF*(Z(254)*Z(256)+Z(264)*
     &Z(266)) + MHAT*(Z(281)*Z(283)+Z(288)*Z(290)) + MLA*(Z(316)*Z(318)+
     &Z(324)*Z(326)) + MLA*(Z(361)*Z(363)+Z(369)*Z(371)) + MRF*(Z(209)*Z
     &(211)+Z(216)*Z(218)) + MSH*(Z(160)*Z(163)+Z(164)*Z(166)) + MSH*(Z(
     &209)*Z(211)+Z(216)*Z(218)) + MTH*(Z(173)*Z(175)+Z(179)*Z(181)) + M
     &TH*(Z(192)*Z(194)+Z(199)*Z(201)) + MUA*(Z(297)*Z(299)+Z(304)*Z(306
     &)) + MUA*(Z(342)*Z(344)+Z(349)*Z(351))
      Z(1130) = MFF*(Z(40)**2+Z(42)**2) + MFF*(Z(256)**2+Z(266)**2) + MH
     &AT*(Z(283)**2+Z(290)**2) + MLA*(Z(318)**2+Z(326)**2) + MLA*(Z(363)
     &**2+Z(371)**2) + MRF*(Z(40)**2+Z(42)**2) + MRF*(Z(211)**2+Z(218)**
     &2) + MSH*(Z(163)**2+Z(166)**2) + MSH*(Z(211)**2+Z(218)**2) + MTH*(
     &Z(175)**2+Z(181)**2) + MTH*(Z(194)**2+Z(201)**2) + MUA*(Z(299)**2+
     &Z(306)**2) + MUA*(Z(344)**2+Z(351)**2)
      Z(1131) = Z(904)*Z(42) + MFF*(Z(256)*Z(257)+Z(266)*Z(267)) + MHAT*
     &(Z(283)*Z(284)+Z(290)*Z(291)) + MLA*(Z(318)*Z(319)+Z(326)*Z(327)) 
     &+ MLA*(Z(363)*Z(364)+Z(371)*Z(372)) + MRF*(Z(211)*Z(212)+Z(218)*Z(
     &219)) + MSH*(Z(159)*Z(163)+Z(166)*Z(168)) + MSH*(Z(211)*Z(212)+Z(2
     &18)*Z(219)) + MTH*(Z(175)*Z(176)+Z(181)*Z(182)) + MTH*(Z(194)*Z(19
     &5)+Z(201)*Z(202)) + MUA*(Z(299)*Z(300)+Z(306)*Z(307)) + MUA*(Z(344
     &)*Z(345)+Z(351)*Z(352)) - 0.5D0*MRF*(LRFO*Z(17)*Z(42)-2*LFF*Z(42)-
     &LRFFO*Z(40)*Z(482)-LRFFO*Z(42)*Z(481)-LRFO*Z(18)*Z(40))
      Z(1132) = MFF*(Z(256)*Z(260)+Z(266)*Z(275)) + MHAT*(Z(283)*Z(285)+
     &Z(290)*Z(295)) + MLA*(Z(318)*Z(322)+Z(326)*Z(336)) + MLA*(Z(363)*Z
     &(367)+Z(371)*Z(381)) + MSH*(Z(161)*Z(163)+Z(166)*Z(169)) + MSH*(Z(
     &211)*Z(215)+Z(218)*Z(224)) + MTH*(Z(175)*Z(177)+Z(181)*Z(185)) + M
     &TH*(Z(194)*Z(196)+Z(201)*Z(206)) + MUA*(Z(299)*Z(303)+Z(306)*Z(312
     &)) + MUA*(Z(344)*Z(348)+Z(351)*Z(357)) + 0.5D0*MRF*(LRFO*Z(17)*Z(4
     &2)-2*LFF*Z(42)-LRFFO*Z(40)*Z(482)-LRFFO*Z(42)*Z(481)-LRFO*Z(18)*Z(
     &40)) + 0.5D0*MRF*(2*Z(211)*Z(215)+2*Z(218)*Z(226)-2*Z(91)*Z(11)*Z(
     &218)-2*Z(91)*Z(12)*Z(211)-LRFFO*Z(211)*Z(486)-LRFFO*Z(218)*Z(484))
     & - Z(904)*Z(42)
      Z(1133) = MFF*(Z(256)*Z(258)+Z(266)*Z(268)) + MHAT*(Z(283)*Z(286)+
     &Z(290)*Z(292)) + MLA*(Z(318)*Z(320)+Z(326)*Z(328)) + MLA*(Z(363)*Z
     &(365)+Z(371)*Z(373)) + MRF*(Z(211)*Z(213)+Z(218)*Z(221)) + MSH*(Z(
     &161)*Z(163)+Z(166)*Z(169)) + MSH*(Z(211)*Z(213)+Z(218)*Z(221)) + M
     &TH*(Z(175)*Z(177)+Z(181)*Z(183)) + MTH*(Z(194)*Z(197)+Z(201)*Z(203
     &)) + MUA*(Z(299)*Z(301)+Z(306)*Z(308)) + MUA*(Z(344)*Z(346)+Z(351)
     &*Z(353)) + 0.5D0*MRF*(LRFO*Z(17)*Z(42)-2*LFF*Z(42)-LRFFO*Z(40)*Z(4
     &82)-LRFFO*Z(42)*Z(481)-LRFO*Z(18)*Z(40)) - Z(904)*Z(42)
      Z(1134) = Z(904)*Z(42) + MFF*(Z(256)*Z(259)+Z(266)*Z(269)) + MHAT*
     &(Z(283)*Z(287)+Z(290)*Z(294)) + MLA*(Z(318)*Z(321)+Z(326)*Z(329)) 
     &+ MLA*(Z(363)*Z(366)+Z(371)*Z(374)) + MRF*(Z(211)*Z(214)+Z(218)*Z(
     &222)) + MSH*(Z(159)*Z(163)+Z(166)*Z(170)) + MSH*(Z(211)*Z(214)+Z(2
     &18)*Z(222)) + MTH*(Z(175)*Z(178)+Z(181)*Z(186)) + MTH*(Z(194)*Z(19
     &8)+Z(201)*Z(205)) + MUA*(Z(299)*Z(302)+Z(306)*Z(309)) + MUA*(Z(344
     &)*Z(347)+Z(351)*Z(354)) - 0.5D0*MRF*(LRFO*Z(17)*Z(42)-2*LFF*Z(42)-
     &LRFFO*Z(40)*Z(482)-LRFFO*Z(42)*Z(481)-LRFO*Z(18)*Z(40))
      Z(1139) = MFF*Z(40)*Z(391) + MFF*(Z(256)*Z(421)+Z(266)*Z(420)) + M
     &HAT*(Z(283)*Z(426)+Z(290)*Z(424)) + MLA*(Z(318)*Z(441)+Z(326)*Z(44
     &2)) + MLA*(Z(363)*Z(458)+Z(371)*Z(459)) + MSH*(Z(163)*Z(400)+Z(166
     &)*Z(399)) + MSH*(Z(211)*Z(412)+Z(218)*Z(411)) + MTH*(Z(175)*Z(404)
     &+Z(181)*Z(403)) + MTH*(Z(194)*Z(408)+Z(201)*Z(407)) + MUA*(Z(299)*
     &Z(432)+Z(306)*Z(433)) + MUA*(Z(344)*Z(449)+Z(351)*Z(450)) + 0.5D0*
     &MRF*(2*Z(211)*Z(413)+2*Z(218)*Z(411)+2*Z(12)*Z(218)*Z(414)-2*Z(11)
     &*Z(211)*Z(414)-Z(211)*Z(484)*Z(415)-Z(218)*Z(485)*Z(415)) - 0.5D0*
     &MRF*(Z(17)*Z(40)*Z(393)+Z(18)*Z(42)*Z(393)-2*Z(40)*Z(392)-Z(40)*Z(
     &481)*Z(394)-Z(42)*Z(483)*Z(394))
      Z(1146) = Z(1140) + MFF*(Z(260)**2+Z(275)**2) + MHAT*(Z(285)**2+Z(
     &295)**2) + MLA*(Z(322)**2+Z(336)**2) + MLA*(Z(367)**2+Z(381)**2) +
     & MSH*(Z(161)**2+Z(169)**2) + MSH*(Z(215)**2+Z(224)**2) + MTH*(Z(17
     &7)**2+Z(185)**2) + MTH*(Z(196)**2+Z(206)**2) + MUA*(Z(303)**2+Z(31
     &2)**2) + MUA*(Z(348)**2+Z(357)**2) + 0.25D0*MRF*(Z(1141)+4*Z(1142)
     &*Z(481)-4*Z(1143)*Z(17)) + 0.25D0*MRF*(Z(1144)+4*Z(215)**2+4*Z(226
     &)**2-4*Z(1145)-8*Z(91)*Z(11)*Z(226)-8*Z(91)*Z(12)*Z(215)-4*LRFFO*Z
     &(215)*Z(486)-4*LRFFO*Z(226)*Z(484))
      Z(1148) = Z(1147) + MFF*(Z(258)*Z(260)+Z(268)*Z(275)) + MHAT*(Z(28
     &5)*Z(286)+Z(292)*Z(295)) + MLA*(Z(320)*Z(322)+Z(328)*Z(336)) + MLA
     &*(Z(365)*Z(367)+Z(373)*Z(381)) + MSH*(Z(161)**2+Z(169)**2) + MSH*(
     &Z(213)*Z(215)+Z(221)*Z(224)) + MTH*(Z(177)**2+Z(183)*Z(185)) + MTH
     &*(Z(196)*Z(197)+Z(203)*Z(206)) + MUA*(Z(301)*Z(303)+Z(308)*Z(312))
     & + MUA*(Z(346)*Z(348)+Z(353)*Z(357)) + 0.25D0*MRF*(Z(1141)+4*Z(114
     &2)*Z(481)-4*Z(1143)*Z(17)) + 0.5D0*MRF*(2*Z(213)*Z(215)+2*Z(221)*Z
     &(226)-2*Z(91)*Z(11)*Z(221)-2*Z(91)*Z(12)*Z(213)-LRFFO*Z(213)*Z(486
     &)-LRFFO*Z(221)*Z(484))
      Z(1150) = MFF*(Z(259)*Z(260)+Z(269)*Z(275)) + MHAT*(Z(285)*Z(287)+
     &Z(294)*Z(295)) + MLA*(Z(321)*Z(322)+Z(329)*Z(336)) + MLA*(Z(366)*Z
     &(367)+Z(374)*Z(381)) + MSH*(Z(159)*Z(161)+Z(169)*Z(170)) + MSH*(Z(
     &214)*Z(215)+Z(222)*Z(224)) + MTH*(Z(177)*Z(178)+Z(185)*Z(186)) + M
     &TH*(Z(196)*Z(198)+Z(205)*Z(206)) + MUA*(Z(302)*Z(303)+Z(309)*Z(312
     &)) + MUA*(Z(347)*Z(348)+Z(354)*Z(357)) + 0.5D0*MRF*(2*Z(214)*Z(215
     &)+2*Z(222)*Z(226)-2*Z(91)*Z(11)*Z(222)-2*Z(91)*Z(12)*Z(214)-LRFFO*
     &Z(214)*Z(486)-LRFFO*Z(222)*Z(484)) - IFF - IRF - ISH - ITH - Z(114
     &9) - 0.25D0*MRF*(Z(1141)+4*Z(1142)*Z(481)-4*Z(1143)*Z(17))
      Z(1151) = MFF*(Z(257)*Z(260)+Z(267)*Z(275)) + MHAT*(Z(284)*Z(285)+
     &Z(291)*Z(295)) + MLA*(Z(319)*Z(322)+Z(327)*Z(336)) + MLA*(Z(364)*Z
     &(367)+Z(372)*Z(381)) + MSH*(Z(159)*Z(161)+Z(168)*Z(169)) + MSH*(Z(
     &212)*Z(215)+Z(219)*Z(224)) + MTH*(Z(176)*Z(177)+Z(182)*Z(185)) + M
     &TH*(Z(195)*Z(196)+Z(202)*Z(206)) + MUA*(Z(300)*Z(303)+Z(307)*Z(312
     &)) + MUA*(Z(345)*Z(348)+Z(352)*Z(357)) + 0.5D0*MRF*(2*Z(212)*Z(215
     &)+2*Z(219)*Z(226)-2*Z(91)*Z(11)*Z(219)-2*Z(91)*Z(12)*Z(212)-LRFFO*
     &Z(212)*Z(486)-LRFFO*Z(219)*Z(484)) - IFF - IRF - Z(1149) - 0.25D0*
     &MRF*(Z(1141)+4*Z(1142)*Z(481)-4*Z(1143)*Z(17))
      Z(1152) = MFF*(Z(254)*Z(260)+Z(264)*Z(275)) + MHAT*(Z(281)*Z(285)+
     &Z(288)*Z(295)) + MLA*(Z(316)*Z(322)+Z(324)*Z(336)) + MLA*(Z(361)*Z
     &(367)+Z(369)*Z(381)) + MSH*(Z(160)*Z(161)+Z(164)*Z(169)) + MSH*(Z(
     &209)*Z(215)+Z(216)*Z(224)) + MTH*(Z(173)*Z(177)+Z(179)*Z(185)) + M
     &TH*(Z(192)*Z(196)+Z(199)*Z(206)) + MUA*(Z(297)*Z(303)+Z(304)*Z(312
     &)) + MUA*(Z(342)*Z(348)+Z(349)*Z(357)) + 0.5D0*MRF*(2*Z(209)*Z(215
     &)+2*Z(216)*Z(226)-2*Z(91)*Z(11)*Z(216)-2*Z(91)*Z(12)*Z(209)-LRFFO*
     &Z(209)*Z(486)-LRFFO*Z(216)*Z(484)) - IFF - Z(1149) - 0.5D0*Z(928)*
     &(2*LFF+LRFFO*Z(481)-LRFO*Z(17))
      Z(1165) = Z(1102) + Z(1112) + MFF*(Z(260)*Z(421)+Z(275)*Z(420)) + 
     &MHAT*(Z(285)*Z(426)+Z(295)*Z(424)) + MLA*(Z(322)*Z(441)+Z(336)*Z(4
     &42)) + MLA*(Z(367)*Z(458)+Z(381)*Z(459)) + MSH*(Z(161)*Z(400)+Z(16
     &9)*Z(399)) + MSH*(Z(215)*Z(412)+Z(224)*Z(411)) + MTH*(Z(177)*Z(404
     &)+Z(185)*Z(403)) + MTH*(Z(196)*Z(408)+Z(206)*Z(407)) + MUA*(Z(303)
     &*Z(432)+Z(312)*Z(433)) + MUA*(Z(348)*Z(449)+Z(357)*Z(450)) + 0.25D
     &0*MRF*(Z(1162)*Z(393)+2*LFF*Z(18)*Z(393)-Z(1163)*Z(394)-2*LFF*Z(48
     &3)*Z(394)-2*LRFFO*Z(482)*Z(392)-2*LRFO*Z(18)*Z(392)) + 0.5D0*MRF*(
     &Z(1162)*Z(414)+2*Z(215)*Z(413)+2*Z(226)*Z(411)+2*Z(12)*Z(226)*Z(41
     &4)-Z(1164)*Z(415)-2*Z(91)*Z(11)*Z(411)-2*Z(91)*Z(12)*Z(413)-2*Z(11
     &)*Z(215)*Z(414)-LRFFO*Z(484)*Z(411)-LRFFO*Z(486)*Z(413)-Z(215)*Z(4
     &84)*Z(415)-Z(226)*Z(485)*Z(415)) - Z(1110) - Z(1116)
      Z(1166) = MFF*(Z(258)*Z(259)+Z(268)*Z(269)) + MHAT*(Z(286)*Z(287)+
     &Z(292)*Z(294)) + MLA*(Z(320)*Z(321)+Z(328)*Z(329)) + MLA*(Z(365)*Z
     &(366)+Z(373)*Z(374)) + MRF*(Z(213)*Z(214)+Z(221)*Z(222)) + MSH*(Z(
     &159)*Z(161)+Z(169)*Z(170)) + MSH*(Z(213)*Z(214)+Z(221)*Z(222)) + M
     &TH*(Z(177)*Z(178)+Z(183)*Z(186)) + MTH*(Z(197)*Z(198)+Z(203)*Z(205
     &)) + MUA*(Z(301)*Z(302)+Z(308)*Z(309)) + MUA*(Z(346)*Z(347)+Z(353)
     &*Z(354)) - IFF - IRF - ISH - Z(1149) - 0.25D0*MRF*(Z(1141)+4*Z(114
     &2)*Z(481)-4*Z(1143)*Z(17))
      Z(1168) = Z(1167) + MFF*(Z(259)**2+Z(269)**2) + MHAT*(Z(287)**2+Z(
     &294)**2) + MLA*(Z(321)**2+Z(329)**2) + MLA*(Z(366)**2+Z(374)**2) +
     & MRF*(Z(214)**2+Z(222)**2) + MSH*(Z(159)**2+Z(170)**2) + MSH*(Z(21
     &4)**2+Z(222)**2) + MTH*(Z(178)**2+Z(186)**2) + MTH*(Z(198)**2+Z(20
     &5)**2) + MUA*(Z(302)**2+Z(309)**2) + MUA*(Z(347)**2+Z(354)**2) + 0
     &.25D0*MRF*(Z(1141)+4*Z(1142)*Z(481)-4*Z(1143)*Z(17))
      Z(1170) = Z(1169) + MFF*(Z(257)*Z(259)+Z(267)*Z(269)) + MHAT*(Z(28
     &4)*Z(287)+Z(291)*Z(294)) + MLA*(Z(319)*Z(321)+Z(327)*Z(329)) + MLA
     &*(Z(364)*Z(366)+Z(372)*Z(374)) + MRF*(Z(212)*Z(214)+Z(219)*Z(222))
     & + MSH*(Z(159)**2+Z(168)*Z(170)) + MSH*(Z(212)*Z(214)+Z(219)*Z(222
     &)) + MTH*(Z(176)*Z(178)+Z(182)*Z(186)) + MTH*(Z(195)*Z(198)+Z(202)
     &*Z(205)) + MUA*(Z(300)*Z(302)+Z(307)*Z(309)) + MUA*(Z(345)*Z(347)+
     &Z(352)*Z(354)) + 0.25D0*MRF*(Z(1141)+4*Z(1142)*Z(481)-4*Z(1143)*Z(
     &17))
      Z(1172) = Z(1171) + MFF*(Z(254)*Z(259)+Z(264)*Z(269)) + MHAT*(Z(28
     &1)*Z(287)+Z(288)*Z(294)) + MLA*(Z(316)*Z(321)+Z(324)*Z(329)) + MLA
     &*(Z(361)*Z(366)+Z(369)*Z(374)) + MRF*(Z(209)*Z(214)+Z(216)*Z(222))
     & + MSH*(Z(159)*Z(160)+Z(164)*Z(170)) + MSH*(Z(209)*Z(214)+Z(216)*Z
     &(222)) + MTH*(Z(173)*Z(178)+Z(179)*Z(186)) + MTH*(Z(192)*Z(198)+Z(
     &199)*Z(205)) + MUA*(Z(297)*Z(302)+Z(304)*Z(309)) + MUA*(Z(342)*Z(3
     &47)+Z(349)*Z(354)) + 0.5D0*Z(928)*(2*LFF+LRFFO*Z(481)-LRFO*Z(17))
      Z(1177) = MFF*(Z(259)*Z(421)+Z(269)*Z(420)) + MHAT*(Z(287)*Z(426)+
     &Z(294)*Z(424)) + MLA*(Z(321)*Z(441)+Z(329)*Z(442)) + MLA*(Z(366)*Z
     &(458)+Z(374)*Z(459)) + MSH*(Z(159)*Z(400)+Z(170)*Z(399)) + MSH*(Z(
     &214)*Z(412)+Z(222)*Z(411)) + MTH*(Z(178)*Z(404)+Z(186)*Z(403)) + M
     &TH*(Z(198)*Z(408)+Z(205)*Z(407)) + MUA*(Z(302)*Z(432)+Z(309)*Z(433
     &)) + MUA*(Z(347)*Z(449)+Z(354)*Z(450)) + 0.5D0*MRF*(2*Z(214)*Z(413
     &)+2*Z(222)*Z(411)+2*Z(12)*Z(222)*Z(414)-2*Z(11)*Z(214)*Z(414)-Z(21
     &4)*Z(484)*Z(415)-Z(222)*Z(485)*Z(415)) - 0.25D0*MRF*(Z(1162)*Z(393
     &)+2*LFF*Z(18)*Z(393)-Z(1163)*Z(394)-2*LFF*Z(483)*Z(394)-2*LRFFO*Z(
     &482)*Z(392)-2*LRFO*Z(18)*Z(392))
      Z(1178) = Z(1147) + MFF*(Z(258)**2+Z(268)**2) + MHAT*(Z(286)**2+Z(
     &292)**2) + MLA*(Z(320)**2+Z(328)**2) + MLA*(Z(365)**2+Z(373)**2) +
     & MRF*(Z(213)**2+Z(221)**2) + MSH*(Z(161)**2+Z(169)**2) + MSH*(Z(21
     &3)**2+Z(221)**2) + MTH*(Z(177)**2+Z(183)**2) + MTH*(Z(197)**2+Z(20
     &3)**2) + MUA*(Z(301)**2+Z(308)**2) + MUA*(Z(346)**2+Z(353)**2) + 0
     &.25D0*MRF*(Z(1141)+4*Z(1142)*Z(481)-4*Z(1143)*Z(17))
      Z(1179) = MFF*(Z(257)*Z(258)+Z(267)*Z(268)) + MHAT*(Z(284)*Z(286)+
     &Z(291)*Z(292)) + MLA*(Z(319)*Z(320)+Z(327)*Z(328)) + MLA*(Z(364)*Z
     &(365)+Z(372)*Z(373)) + MRF*(Z(212)*Z(213)+Z(219)*Z(221)) + MSH*(Z(
     &159)*Z(161)+Z(168)*Z(169)) + MSH*(Z(212)*Z(213)+Z(219)*Z(221)) + M
     &TH*(Z(176)*Z(177)+Z(182)*Z(183)) + MTH*(Z(195)*Z(197)+Z(202)*Z(203
     &)) + MUA*(Z(300)*Z(301)+Z(307)*Z(308)) + MUA*(Z(345)*Z(346)+Z(352)
     &*Z(353)) - IFF - IRF - Z(1149) - 0.25D0*MRF*(Z(1141)+4*Z(1142)*Z(4
     &81)-4*Z(1143)*Z(17))
      Z(1180) = MFF*(Z(254)*Z(258)+Z(264)*Z(268)) + MHAT*(Z(281)*Z(286)+
     &Z(288)*Z(292)) + MLA*(Z(316)*Z(320)+Z(324)*Z(328)) + MLA*(Z(361)*Z
     &(365)+Z(369)*Z(373)) + MRF*(Z(209)*Z(213)+Z(216)*Z(221)) + MSH*(Z(
     &160)*Z(161)+Z(164)*Z(169)) + MSH*(Z(209)*Z(213)+Z(216)*Z(221)) + M
     &TH*(Z(173)*Z(177)+Z(179)*Z(183)) + MTH*(Z(192)*Z(197)+Z(199)*Z(203
     &)) + MUA*(Z(297)*Z(301)+Z(304)*Z(308)) + MUA*(Z(342)*Z(346)+Z(349)
     &*Z(353)) - IFF - Z(1149) - 0.5D0*Z(928)*(2*LFF+LRFFO*Z(481)-LRFO*Z
     &(17))
      Z(1185) = MFF*(Z(258)*Z(421)+Z(268)*Z(420)) + MHAT*(Z(286)*Z(426)+
     &Z(292)*Z(424)) + MLA*(Z(320)*Z(441)+Z(328)*Z(442)) + MLA*(Z(365)*Z
     &(458)+Z(373)*Z(459)) + MSH*(Z(161)*Z(400)+Z(169)*Z(399)) + MSH*(Z(
     &213)*Z(412)+Z(221)*Z(411)) + MTH*(Z(177)*Z(404)+Z(183)*Z(403)) + M
     &TH*(Z(197)*Z(408)+Z(203)*Z(407)) + MUA*(Z(301)*Z(432)+Z(308)*Z(433
     &)) + MUA*(Z(346)*Z(449)+Z(353)*Z(450)) + 0.25D0*MRF*(Z(1162)*Z(393
     &)+2*LFF*Z(18)*Z(393)-Z(1163)*Z(394)-2*LFF*Z(483)*Z(394)-2*LRFFO*Z(
     &482)*Z(392)-2*LRFO*Z(18)*Z(392)) + 0.5D0*MRF*(2*Z(213)*Z(413)+2*Z(
     &221)*Z(411)+2*Z(12)*Z(221)*Z(414)-2*Z(11)*Z(213)*Z(414)-Z(213)*Z(4
     &84)*Z(415)-Z(221)*Z(485)*Z(415))
      Z(1186) = Z(1169) + MFF*(Z(257)**2+Z(267)**2) + MHAT*(Z(284)**2+Z(
     &291)**2) + MLA*(Z(319)**2+Z(327)**2) + MLA*(Z(364)**2+Z(372)**2) +
     & MRF*(Z(212)**2+Z(219)**2) + MSH*(Z(159)**2+Z(168)**2) + MSH*(Z(21
     &2)**2+Z(219)**2) + MTH*(Z(176)**2+Z(182)**2) + MTH*(Z(195)**2+Z(20
     &2)**2) + MUA*(Z(300)**2+Z(307)**2) + MUA*(Z(345)**2+Z(352)**2) + 0
     &.25D0*MRF*(Z(1141)+4*Z(1142)*Z(481)-4*Z(1143)*Z(17))
      Z(1187) = Z(1171) + MFF*(Z(254)*Z(257)+Z(264)*Z(267)) + MHAT*(Z(28
     &1)*Z(284)+Z(288)*Z(291)) + MLA*(Z(316)*Z(319)+Z(324)*Z(327)) + MLA
     &*(Z(361)*Z(364)+Z(369)*Z(372)) + MRF*(Z(209)*Z(212)+Z(216)*Z(219))
     & + MSH*(Z(159)*Z(160)+Z(164)*Z(168)) + MSH*(Z(209)*Z(212)+Z(216)*Z
     &(219)) + MTH*(Z(173)*Z(176)+Z(179)*Z(182)) + MTH*(Z(192)*Z(195)+Z(
     &199)*Z(202)) + MUA*(Z(297)*Z(300)+Z(304)*Z(307)) + MUA*(Z(342)*Z(3
     &45)+Z(349)*Z(352)) + 0.5D0*Z(928)*(2*LFF+LRFFO*Z(481)-LRFO*Z(17))
      Z(1192) = MFF*(Z(257)*Z(421)+Z(267)*Z(420)) + MHAT*(Z(284)*Z(426)+
     &Z(291)*Z(424)) + MLA*(Z(319)*Z(441)+Z(327)*Z(442)) + MLA*(Z(364)*Z
     &(458)+Z(372)*Z(459)) + MSH*(Z(159)*Z(400)+Z(168)*Z(399)) + MSH*(Z(
     &212)*Z(412)+Z(219)*Z(411)) + MTH*(Z(176)*Z(404)+Z(182)*Z(403)) + M
     &TH*(Z(195)*Z(408)+Z(202)*Z(407)) + MUA*(Z(300)*Z(432)+Z(307)*Z(433
     &)) + MUA*(Z(345)*Z(449)+Z(352)*Z(450)) + 0.5D0*MRF*(2*Z(212)*Z(413
     &)+2*Z(219)*Z(411)+2*Z(12)*Z(219)*Z(414)-2*Z(11)*Z(212)*Z(414)-Z(21
     &2)*Z(484)*Z(415)-Z(219)*Z(485)*Z(415)) - 0.25D0*MRF*(Z(1162)*Z(393
     &)+2*LFF*Z(18)*Z(393)-Z(1163)*Z(394)-2*LFF*Z(483)*Z(394)-2*LRFFO*Z(
     &482)*Z(392)-2*LRFO*Z(18)*Z(392))
      Z(1194) = Z(1193) + MFF*(Z(254)**2+Z(264)**2) + MHAT*(Z(281)**2+Z(
     &288)**2) + MLA*(Z(316)**2+Z(324)**2) + MLA*(Z(361)**2+Z(369)**2) +
     & MRF*(Z(209)**2+Z(216)**2) + MSH*(Z(160)**2+Z(164)**2) + MSH*(Z(20
     &9)**2+Z(216)**2) + MTH*(Z(173)**2+Z(179)**2) + MTH*(Z(192)**2+Z(19
     &9)**2) + MUA*(Z(297)**2+Z(304)**2) + MUA*(Z(342)**2+Z(349)**2)
      Z(1199) = MFF*(Z(254)*Z(421)+Z(264)*Z(420)) + MHAT*(Z(281)*Z(426)+
     &Z(288)*Z(424)) + MLA*(Z(316)*Z(441)+Z(324)*Z(442)) + MLA*(Z(361)*Z
     &(458)+Z(369)*Z(459)) + MSH*(Z(160)*Z(400)+Z(164)*Z(399)) + MSH*(Z(
     &209)*Z(412)+Z(216)*Z(411)) + MTH*(Z(173)*Z(404)+Z(179)*Z(403)) + M
     &TH*(Z(192)*Z(408)+Z(199)*Z(407)) + MUA*(Z(297)*Z(432)+Z(304)*Z(433
     &)) + MUA*(Z(342)*Z(449)+Z(349)*Z(450)) + 0.5D0*MRF*(2*Z(209)*Z(413
     &)+2*Z(216)*Z(411)+2*Z(12)*Z(216)*Z(414)-2*Z(11)*Z(209)*Z(414)-Z(20
     &9)*Z(484)*Z(415)-Z(216)*Z(485)*Z(415)) - 0.5D0*Z(928)*(Z(18)*Z(393
     &)-Z(483)*Z(394))
      Z(1255) = Z(1077) - Z(1128)
      Z(1256) = Z(1078) - Z(1139)
      Z(1258) = Z(1081) - Z(1177)
      Z(1259) = Z(1082) - Z(1185)
      Z(1260) = Z(1083) - Z(1192)
      Z(1261) = Z(1085) - Z(1199)
      Z(1272) = Z(470) + Z(471) + Z(472) + Z(473) + Z(474) + Z(475) + Z(
     &476) + Z(463)*(Z(1)*Z(295)+Z(2)*Z(285)) + Z(464)*(Z(73)*Z(260)+Z(7
     &5)*Z(275)) + Z(465)*(Z(80)*Z(322)+Z(82)*Z(336)) + Z(465)*(Z(87)*Z(
     &367)+Z(89)*Z(381)) + Z(467)*(Z(36)*Z(161)+Z(38)*Z(169)) + Z(467)*(
     &Z(61)*Z(215)+Z(63)*Z(224)) + Z(468)*(Z(54)*Z(185)+Z(55)*Z(177)) + 
     &Z(468)*(Z(57)*Z(206)+Z(58)*Z(196)) + Z(469)*(Z(76)*Z(312)+Z(77)*Z(
     &303)) + Z(469)*(Z(83)*Z(357)+Z(84)*Z(348)) - LMTQ - RMTQ - Z(1079)
     &*Z(42) - 0.5D0*Z(466)*(LRFFO*Z(49)+LRFO*Z(53)+2*LFF*Z(42)) - 0.5D0
     &*Z(466)*(LRFFO*Z(71)-2*Z(91)*Z(67)-2*Z(61)*Z(215)-2*Z(63)*Z(226)) 
     &- Z(1165) - LFF*(Z(41)*RX2+Z(42)*RY2)

      COEF(1,1) = -Z(1118)
      COEF(1,2) = -Z(1119)
      COEF(1,3) = -Z(1121)
      COEF(1,4) = -Z(1123)
      COEF(1,5) = -Z(1122)
      COEF(1,6) = -Z(1120)
      COEF(1,7) = -Z(1117)
      COEF(1,8) = -Z(1125)
      COEF(1,9) = -Z(1124)
      COEF(1,10) = -Z(1126)
      COEF(1,11) = Z(1127)
      COEF(2,1) = -Z(1119)
      COEF(2,2) = -Z(1130)
      COEF(2,3) = -Z(1132)
      COEF(2,4) = -Z(1134)
      COEF(2,5) = -Z(1133)
      COEF(2,6) = -Z(1131)
      COEF(2,7) = -Z(1129)
      COEF(2,8) = -Z(1136)
      COEF(2,9) = -Z(1135)
      COEF(2,10) = -Z(1137)
      COEF(2,11) = Z(1138)
      COEF(3,1) = -Z(1121)
      COEF(3,2) = -Z(1132)
      COEF(3,3) = -Z(1146)
      COEF(3,4) = -Z(1150)
      COEF(3,5) = -Z(1148)
      COEF(3,6) = -Z(1151)
      COEF(3,7) = -Z(1152)
      COEF(3,8) = -Z(1157)
      COEF(3,9) = -Z(1161)
      COEF(3,10) = -Z(1155)
      COEF(3,11) = -Z(1156)
      COEF(4,1) = -Z(1123)
      COEF(4,2) = -Z(1134)
      COEF(4,3) = -Z(1150)
      COEF(4,4) = -Z(1168)
      COEF(4,5) = -Z(1166)
      COEF(4,6) = -Z(1170)
      COEF(4,7) = -Z(1172)
      COEF(4,8) = -Z(1174)
      COEF(4,9) = -Z(1173)
      COEF(4,10) = -Z(1175)
      COEF(4,11) = Z(1176)
      COEF(5,1) = -Z(1122)
      COEF(5,2) = -Z(1133)
      COEF(5,3) = -Z(1148)
      COEF(5,4) = -Z(1166)
      COEF(5,5) = -Z(1178)
      COEF(5,6) = -Z(1179)
      COEF(5,7) = -Z(1180)
      COEF(5,8) = -Z(1182)
      COEF(5,9) = -Z(1181)
      COEF(5,10) = -Z(1183)
      COEF(5,11) = Z(1184)
      COEF(6,1) = -Z(1120)
      COEF(6,2) = -Z(1131)
      COEF(6,3) = -Z(1151)
      COEF(6,4) = -Z(1170)
      COEF(6,5) = -Z(1179)
      COEF(6,6) = -Z(1186)
      COEF(6,7) = -Z(1187)
      COEF(6,8) = -Z(1189)
      COEF(6,9) = -Z(1188)
      COEF(6,10) = -Z(1190)
      COEF(6,11) = Z(1191)
      COEF(7,1) = -Z(1117)
      COEF(7,2) = -Z(1129)
      COEF(7,3) = -Z(1152)
      COEF(7,4) = -Z(1172)
      COEF(7,5) = -Z(1180)
      COEF(7,6) = -Z(1187)
      COEF(7,7) = -Z(1194)
      COEF(7,8) = -Z(1196)
      COEF(7,9) = -Z(1195)
      COEF(7,10) = -Z(1197)
      COEF(7,11) = Z(1198)
      COEF(8,1) = -Z(1125)
      COEF(8,2) = -Z(1136)
      COEF(8,3) = -Z(1157)
      COEF(8,4) = -Z(1174)
      COEF(8,5) = -Z(1182)
      COEF(8,6) = -Z(1189)
      COEF(8,7) = -Z(1196)
      COEF(8,8) = -Z(1205)
      COEF(8,9) = -Z(1208)
      COEF(8,10) = -Z(1202)
      COEF(8,11) = -Z(1203)
      COEF(9,1) = -Z(1124)
      COEF(9,2) = -Z(1135)
      COEF(9,3) = -Z(1161)
      COEF(9,4) = -Z(1173)
      COEF(9,5) = -Z(1181)
      COEF(9,6) = -Z(1188)
      COEF(9,7) = -Z(1195)
      COEF(9,8) = -Z(1208)
      COEF(9,9) = -Z(1214)
      COEF(9,10) = -Z(1210)
      COEF(9,11) = -Z(1211)
      COEF(10,1) = -Z(1126)
      COEF(10,2) = -Z(1137)
      COEF(10,3) = -Z(1155)
      COEF(10,4) = -Z(1175)
      COEF(10,5) = -Z(1183)
      COEF(10,6) = -Z(1190)
      COEF(10,7) = -Z(1197)
      COEF(10,8) = -Z(1202)
      COEF(10,9) = -Z(1210)
      COEF(10,10) = -Z(1217)
      COEF(10,11) = -Z(1218)
      COEF(11,1) = Z(1127)
      COEF(11,2) = Z(1138)
      COEF(11,3) = -Z(1156)
      COEF(11,4) = Z(1176)
      COEF(11,5) = Z(1184)
      COEF(11,6) = Z(1191)
      COEF(11,7) = Z(1198)
      COEF(11,8) = -Z(1203)
      COEF(11,9) = -Z(1211)
      COEF(11,10) = -Z(1218)
      COEF(11,11) = -Z(1220)
      RHS(1) = -Z(1255)
      RHS(2) = -Z(1256)
      RHS(3) = -Z(1272)
      RHS(4) = -Z(1258)
      RHS(5) = -Z(1259)
      RHS(6) = -Z(1260)
      RHS(7) = -Z(1261)
      RHS(8) = -Z(1262)
      RHS(9) = -Z(1263)
      RHS(10) = -Z(1264)
      RHS(11) = -Z(1265)
      CALL SOLVE(11,COEF,RHS,VARp)

C**   Update variables after uncoupling equations
      U1p = VARp(1)
      U2p = VARp(2)
      U3p = VARp(3)
      U4p = VARp(4)
      U5p = VARp(5)
      U6p = VARp(6)
      U7p = VARp(7)
      U8p = VARp(8)
      U9p = VARp(9)
      U10p = VARp(10)
      U11p = VARp(11)

C**   Update derivative array prior to integration step
      VARp(1) = Q1p
      VARp(2) = Q10p
      VARp(3) = Q11p
      VARp(4) = Q2p
      VARp(5) = Q3p
      VARp(6) = Q4p
      VARp(7) = Q5p
      VARp(8) = Q6p
      VARp(9) = Q7p
      VARp(10) = Q8p
      VARp(11) = Q9p
      VARp(12) = U1p
      VARp(13) = U10p
      VARp(14) = U11p
      VARp(15) = U2p
      VARp(16) = U3p
      VARp(17) = U4p
      VARp(18) = U5p
      VARp(19) = U6p
      VARp(20) = U7p
      VARp(21) = U8p
      VARp(22) = U9p

      RETURN
      END


C**********************************************************************
      SUBROUTINE       IO(T)
      IMPLICIT         DOUBLE PRECISION (A - Z)
      INTEGER          ILOOP
      COMMON/CONSTNTS/ FOOTANG,G,IFF,IHAT,ILA,IRF,ISH,ITH,IUA,K1,K2,K3,K
     &4,K5,K6,K7,K8,LAE,LAF,LFF,LFFO,LHAT,LHATO,LHE,LHF,LKE,LKF,LLA,LLAO
     &,LRF,LRFF,LRFFO,LRFO,LSH,LSHO,LTH,LTHO,LUA,LUAO,MFF,MHAT,MLA,MRF,M
     &SH,MTH,MTPB,MTPK,MTPXI,MUA,RAE,RAF,RHE,RHF,RKE,RKF,TOEXI
      COMMON/SPECFIED/ LE,LS,RE,RS,LEp,LSp,REp,RSp,LEpp,LSpp,REpp,RSpp
      COMMON/VARIBLES/ Q1,Q10,Q11,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,U1,U10,U11,U2,
     &U3,U4,U5,U6,U7,U8,U9
      COMMON/ALGBRAIC/ HZ,KECM,LA,LETQ,LH,LK,LMTP,LSTQ,PX,PY,RA,RETQ,RH,
     &RK,RMTP,RSTQ,U12,U13,U14,U15,LAp,LHp,LKp,LMTPp,Q1p,Q10p,Q11p,Q2p,Q
     &3p,Q4p,Q5p,Q6p,Q7p,Q8p,Q9p,RAp,RHp,RKp,RMTPp,U1p,U10p,U11p,U2p,U3p
     &,U4p,U5p,U6p,U7p,U8p,U9p,LApp,LHpp,LKpp,LMTPpp,RApp,RHpp,RKpp,RMTP
     &pp,LATQ,LHTQ,LKTQ,LMTQ,RATQ,RHTQ,RKTQ,RMTQ,DX1,DX2,POCMX,POCMY,POP
     &10X,POP10Y,POP11X,POP11Y,POP12X,POP12Y,POP13X,POP13Y,POP14X,POP14Y
     &,POP15X,POP15Y,POP16X,POP16Y,POP1X,POP1Y,POP2X,POP2Y,POP3X,POP3Y,P
     &OP4X,POP4Y,POP5X,POP5Y,POP6X,POP6Y,POP7X,POP7Y,POP8X,POP8Y,POP9X,P
     &OP9Y,RX,RX1,RX2,RY,RY1,RY2,VOCMX,VOCMY,VOP2X,VOP2Y
      COMMON/MISCLLNS/ PI,DEGtoRAD,RADtoDEG,Z(1272),COEF(11,11),RHS(11)

C**   Evaluate output quantities
      Z(332) = Z(23)*Z(313)
      Z(337) = Z(332) + Z(334)
      Z(331) = LUA*Z(23)
      Z(335) = LLAO - Z(331)
      Z(315) = LUA*Z(24)
      Z(323) = Z(24)*Z(313)
      Z(377) = Z(25)*Z(358)
      Z(382) = Z(377) + Z(379)
      Z(376) = LUA*Z(25)
      Z(380) = LLAO - Z(376)
      Z(360) = LUA*Z(26)
      Z(368) = Z(26)*Z(358)
      KECM = 0.5D0*IHAT*U3**2 + 0.5D0*ITH*(U3-U4)**2 + 0.5D0*ITH*(U3-U8)
     &**2 + 0.5D0*ISH*(U4-U3-U5)**2 + 0.5D0*ISH*(U8-U3-U9)**2 + 0.5D0*IU
     &A*(LSp-U13-U3)**2 + 0.5D0*IUA*(RSp-U12-U3)**2 + 0.5D0*IRF*(U10+U8-
     &U3-U9)**2 + 0.5D0*IRF*(U3+U5-U4-U6)**2 + 0.5D0*IFF*(U10+U11+U8-U3-
     &U9)**2 + 0.5D0*IFF*(U3+U5-U4-U6-U7)**2 + 0.5D0*ILA*(LSp-LEp-U13-U1
     &5-U3)**2 + 0.5D0*ILA*(RSp-REp-U12-U14-U3)**2 + 0.5D0*MFF*((Z(39)*U
     &1+Z(40)*U2)**2+(LFFO*U3+LFFO*U5-LFFO*U4-LFFO*U6-LFFO*U7-Z(41)*U1-Z
     &(42)*U2)**2) + 0.5D0*MHAT*((Z(281)*U7+Z(282)*U1+Z(283)*U2+Z(284)*U
     &6+Z(285)*U3+Z(286)*U5+Z(287)*U4)**2+(Z(288)*U7+Z(289)*U1+Z(290)*U2
     &+Z(291)*U6+Z(292)*U5+Z(294)*U4+Z(295)*U3)**2) + 0.5D0*MSH*((Z(159)
     &*U4+Z(159)*U6+Z(160)*U7+Z(161)*U3+Z(161)*U5+Z(162)*U1+Z(163)*U2)**
     &2+(Z(164)*U7+Z(165)*U1+Z(166)*U2+Z(168)*U6+Z(169)*U3+Z(169)*U5+Z(1
     &70)*U4)**2) + 0.5D0*MTH*((Z(173)*U7+Z(174)*U1+Z(175)*U2+Z(176)*U6+
     &Z(177)*U3+Z(177)*U5+Z(178)*U4)**2+(Z(179)*U7+Z(180)*U1+Z(181)*U2+Z
     &(182)*U6+Z(183)*U5+Z(185)*U3+Z(186)*U4)**2) + 0.5D0*MSH*((Z(208)*U
     &8+Z(209)*U7+Z(210)*U1+Z(211)*U2+Z(212)*U6+Z(213)*U5+Z(214)*U4+Z(21
     &5)*U3)**2+(Z(92)*U9+Z(216)*U7+Z(217)*U1+Z(218)*U2+Z(219)*U6+Z(221)
     &*U5+Z(222)*U4+Z(224)*U3+Z(225)*U8)**2) + 0.5D0*MTH*((Z(192)*U7+Z(1
     &93)*U1+Z(194)*U2+Z(195)*U6+Z(196)*U3+Z(197)*U5+Z(198)*U4)**2+(Z(93
     &)*U8-Z(199)*U7-Z(200)*U1-Z(201)*U2-Z(202)*U6-Z(203)*U5-Z(205)*U4-Z
     &(206)*U3)**2) + 0.5D0*MUA*((Z(297)*U7+Z(298)*U1+Z(299)*U2+Z(300)*U
     &6+Z(301)*U5+Z(302)*U4+Z(303)*U3)**2+(Z(311)-LUAO*U12-Z(304)*U7-Z(3
     &05)*U1-Z(306)*U2-Z(307)*U6-Z(308)*U5-Z(309)*U4-Z(312)*U3)**2) + 0.
     &5D0*MUA*((Z(342)*U7+Z(343)*U1+Z(344)*U2+Z(345)*U6+Z(346)*U5+Z(347)
     &*U4+Z(348)*U3)**2+(Z(356)-LUAO*U13-Z(349)*U7-Z(350)*U1-Z(351)*U2-Z
     &(352)*U6-Z(353)*U5-Z(354)*U4-Z(357)*U3)**2) + 0.5D0*MLA*((Z(337)+L
     &LAO*U14+Z(335)*U12+Z(324)*U7+Z(325)*U1+Z(326)*U2+Z(327)*U6+Z(328)*
     &U5+Z(329)*U4+Z(336)*U3)**2+(Z(315)*U12-Z(323)-Z(316)*U7-Z(317)*U1-
     &Z(318)*U2-Z(319)*U6-Z(320)*U5-Z(321)*U4-Z(322)*U3)**2) + 0.5D0*MLA
     &*((Z(382)+LLAO*U15+Z(380)*U13+Z(369)*U7+Z(370)*U1+Z(371)*U2+Z(372)
     &*U6+Z(373)*U5+Z(374)*U4+Z(381)*U3)**2+(Z(360)*U13-Z(368)-Z(361)*U7
     &-Z(362)*U1-Z(363)*U2-Z(364)*U6-Z(365)*U5-Z(366)*U4-Z(367)*U3)**2) 
     &+ 0.5D0*MFF*((Z(253)*U9+Z(254)*U7+Z(255)*U1+Z(256)*U2+Z(257)*U6+Z(
     &258)*U5+Z(259)*U4+Z(260)*U3+Z(261)*U8-Z(262)*U10)**2+(Z(90)*U11-Z(
     &264)*U7-Z(265)*U1-Z(266)*U2-Z(267)*U6-Z(268)*U5-Z(269)*U4-Z(273)*U
     &10-Z(274)*U8-Z(275)*U3-Z(276)*U9)**2) + 0.125D0*MRF*(4*(Z(39)*U1+Z
     &(40)*U2)**2+LRFFO**2*(U3+U5-U4-U6)**2+LRFO**2*(U3+U5-U4-U6)**2+2*L
     &RFFO*LRFO*Z(27)*(U3+U5-U4-U6)**2+4*(LFF*U3+LFF*U5-LFF*U4-LFF*U6-LF
     &F*U7-Z(41)*U1-Z(42)*U2)**2+4*LRFFO*Z(481)*(U3+U5-U4-U6)*(LFF*U3+LF
     &F*U5-LFF*U4-LFF*U6-LFF*U7-Z(41)*U1-Z(42)*U2)-4*LRFFO*Z(482)*(Z(39)
     &*U1+Z(40)*U2)*(U3+U5-U4-U6)-4*LRFO*Z(18)*(Z(39)*U1+Z(40)*U2)*(U3+U
     &5-U4-U6)-4*LRFO*Z(17)*(U3+U5-U4-U6)*(LFF*U3+LFF*U5-LFF*U4-LFF*U6-L
     &FF*U7-Z(41)*U1-Z(42)*U2)) - 0.125D0*MRF*(4*LRFFO*Z(27)*Z(91)*(U10+
     &U8-U3-U9)**2-4*Z(91)**2*(U10+U8-U3-U9)**2-LRFFO**2*(U10+U8-U3-U9)*
     &*2-4*(Z(208)*U8+Z(209)*U7+Z(210)*U1+Z(211)*U2+Z(212)*U6+Z(213)*U5+
     &Z(214)*U4+Z(215)*U3)**2-4*(LSH*U9+Z(216)*U7+Z(217)*U1+Z(218)*U2+Z(
     &219)*U6+Z(221)*U5+Z(222)*U4+Z(226)*U3+Z(227)*U8)**2-8*Z(91)*Z(12)*
     &(U10+U8-U3-U9)*(Z(208)*U8+Z(209)*U7+Z(210)*U1+Z(211)*U2+Z(212)*U6+
     &Z(213)*U5+Z(214)*U4+Z(215)*U3)-4*LRFFO*Z(486)*(U10+U8-U3-U9)*(Z(20
     &8)*U8+Z(209)*U7+Z(210)*U1+Z(211)*U2+Z(212)*U6+Z(213)*U5+Z(214)*U4+
     &Z(215)*U3)-8*Z(91)*Z(11)*(U10+U8-U3-U9)*(LSH*U9+Z(216)*U7+Z(217)*U
     &1+Z(218)*U2+Z(219)*U6+Z(221)*U5+Z(222)*U4+Z(226)*U3+Z(227)*U8)-4*L
     &RFFO*Z(484)*(U10+U8-U3-U9)*(LSH*U9+Z(216)*U7+Z(217)*U1+Z(218)*U2+Z
     &(219)*U6+Z(221)*U5+Z(222)*U4+Z(226)*U3+Z(227)*U8))
      Z(487) = ILA*Z(378)
      Z(489) = ILA*Z(333)
      Z(44) = Z(27)*Z(14) - Z(28)*Z(13)
      Z(46) = Z(35)*Z(43) + Z(37)*Z(44)
      Z(47) = Z(36)*Z(43) + Z(38)*Z(44)
      Z(147) = Z(1)*Z(46) + Z(2)*Z(47)
      Z(59) = Z(1)*Z(4) - Z(2)*Z(3)
      Z(62) = Z(8)*Z(57) - Z(7)*Z(59)
      Z(60) = -Z(7)*Z(57) - Z(8)*Z(59)
      Z(64) = Z(12)*Z(62) - Z(11)*Z(60)
      Z(66) = -Z(11)*Z(62) - Z(12)*Z(60)
      Z(68) = Z(27)*Z(64) + Z(28)*Z(66)
      Z(69) = Z(27)*Z(65) + Z(28)*Z(67)
      Z(228) = Z(1)*Z(68) + Z(2)*Z(69)
      Z(78) = Z(19)*Z(2) - Z(20)*Z(1)
      Z(79) = -Z(23)*Z(76) - Z(24)*Z(78)
      Z(137) = Z(1)*Z(79) + Z(2)*Z(80)
      Z(85) = Z(21)*Z(2) - Z(22)*Z(1)
      Z(86) = -Z(25)*Z(83) - Z(26)*Z(85)
      Z(143) = Z(1)*Z(86) + Z(2)*Z(87)
      Z(72) = Z(16)*Z(66) - Z(15)*Z(64)
      Z(124) = Z(1)*Z(72) + Z(2)*Z(73)
      Z(114) = Z(1)*Z(64) + Z(2)*Z(65)
      Z(108) = Z(1)*Z(60) + Z(2)*Z(61)
      Z(129) = Z(1)*Z(39) + Z(2)*Z(40)
      Z(50) = Z(14)*Z(37) - Z(13)*Z(35)
      Z(51) = Z(14)*Z(38) - Z(13)*Z(36)
      Z(119) = Z(1)*Z(50) + Z(2)*Z(51)
      Z(495) = LHATO + Z(102)*Z(19) + Z(102)*Z(21) + 0.5D0*Z(99)*Z(147) 
     &+ 0.5D0*Z(99)*Z(228) - Z(95) - Z(97)*Z(137) - Z(97)*Z(143) - Z(103
     &)*Z(124) - Z(104)*Z(114) - Z(105)*Z(108) - Z(106)*Z(3) - Z(491)*Z(
     &129) - Z(492)*Z(32) - Z(493)*Z(5) - 0.5D0*Z(494)*Z(119)
      Z(854) = MHAT*Z(495)
      Z(498) = Z(288)*U7 + Z(289)*U1 + Z(290)*U2 + Z(291)*U6 + Z(292)*U5
     & + Z(294)*U4 + Z(295)*U3
      Z(131) = Z(1)*Z(40) - Z(2)*Z(39)
      Z(503) = Z(5)*Z(129) - Z(6)*Z(131)
      Z(511) = Z(39)*Z(72) + Z(40)*Z(73)
      Z(74) = -Z(15)*Z(66) - Z(16)*Z(64)
      Z(513) = Z(39)*Z(74) + Z(40)*Z(75)
      Z(519) = -Z(15)*Z(511) - Z(16)*Z(513)
      Z(521) = Z(16)*Z(511) - Z(15)*Z(513)
      Z(523) = Z(27)*Z(519) + Z(28)*Z(521)
      Z(499) = Z(39)*Z(86) + Z(40)*Z(87)
      Z(515) = Z(39)*Z(79) + Z(40)*Z(80)
      Z(507) = Z(22)*Z(131) - Z(21)*Z(129)
      Z(535) = Z(20)*Z(131) - Z(19)*Z(129)
      Z(527) = -Z(11)*Z(519) - Z(12)*Z(521)
      Z(531) = Z(3)*Z(129) - Z(4)*Z(131)
      Z(539) = Z(96) + Z(100)*Z(29) + Z(101)*Z(503) + 0.5D0*Z(99)*Z(481)
     & + 0.5D0*Z(99)*Z(523) - LFFO - Z(95)*Z(129) - Z(97)*Z(499) - Z(97)
     &*Z(515) - Z(102)*Z(507) - Z(102)*Z(535) - Z(103)*Z(511) - Z(104)*Z
     &(519) - Z(105)*Z(527) - Z(106)*Z(531) - 0.5D0*Z(98)*Z(17)
      Z(856) = MFF*Z(539)
      Z(542) = LFFO*U4 + LFFO*U6 + LFFO*U7 + Z(41)*U1 + Z(42)*U2 - LFFO*
     &U3 - LFFO*U5
      Z(500) = Z(41)*Z(86) + Z(42)*Z(87)
      Z(543) = -Z(17)*Z(499) - Z(18)*Z(500)
      Z(545) = Z(18)*Z(499) - Z(17)*Z(500)
      Z(547) = Z(27)*Z(543) + Z(28)*Z(545)
      Z(559) = Z(72)*Z(86) + Z(73)*Z(87)
      Z(561) = Z(74)*Z(86) + Z(75)*Z(87)
      Z(567) = -Z(15)*Z(559) - Z(16)*Z(561)
      Z(569) = Z(16)*Z(559) - Z(15)*Z(561)
      Z(571) = Z(27)*Z(567) + Z(28)*Z(569)
      Z(563) = Z(79)*Z(86) + Z(80)*Z(87)
      Z(145) = Z(1)*Z(87) - Z(2)*Z(86)
      Z(583) = Z(20)*Z(145) - Z(19)*Z(143)
      Z(575) = -Z(11)*Z(567) - Z(12)*Z(569)
      Z(579) = Z(3)*Z(143) - Z(4)*Z(145)
      Z(551) = -Z(13)*Z(543) - Z(14)*Z(545)
      Z(555) = Z(5)*Z(143) - Z(6)*Z(145)
      Z(589) = LLAO + Z(587)*Z(143) + 0.5D0*Z(99)*Z(547) + 0.5D0*Z(99)*Z
     &(571) - Z(97) - Z(588)*Z(25) - Z(97)*Z(563) - Z(102)*Z(583) - Z(10
     &3)*Z(559) - Z(104)*Z(567) - Z(105)*Z(575) - Z(106)*Z(579) - Z(491)
     &*Z(499) - Z(492)*Z(551) - Z(493)*Z(555) - 0.5D0*Z(494)*Z(543)
      Z(858) = MLA*Z(589)
      Z(592) = Z(382) + LLAO*U15 + Z(380)*U13 + Z(369)*U7 + Z(370)*U1 + 
     &Z(371)*U2 + Z(372)*U6 + Z(373)*U5 + Z(374)*U4 + Z(381)*U3
      Z(675) = Z(35)*Z(72) + Z(36)*Z(73)
      Z(677) = Z(35)*Z(74) + Z(36)*Z(75)
      Z(683) = -Z(15)*Z(675) - Z(16)*Z(677)
      Z(685) = Z(16)*Z(675) - Z(15)*Z(677)
      Z(687) = Z(27)*Z(683) + Z(28)*Z(685)
      Z(679) = Z(35)*Z(79) + Z(36)*Z(80)
      Z(671) = Z(22)*Z(33) - Z(21)*Z(32)
      Z(699) = Z(20)*Z(33) - Z(19)*Z(32)
      Z(691) = -Z(11)*Z(683) - Z(12)*Z(685)
      Z(695) = Z(3)*Z(32) - Z(4)*Z(33)
      Z(703) = Z(100) + 0.5D0*Z(99)*Z(43) + 0.5D0*Z(99)*Z(687) + 0.5D0*Z
     &(494)*Z(13) - LSHO - Z(95)*Z(32) - Z(97)*Z(551) - Z(97)*Z(679) - Z
     &(101)*Z(9) - Z(102)*Z(671) - Z(102)*Z(699) - Z(103)*Z(675) - Z(104
     &)*Z(683) - Z(105)*Z(691) - Z(106)*Z(695) - Z(491)*Z(29)
      Z(866) = MSH*Z(703)
      Z(706) = Z(164)*U7 + Z(165)*U1 + Z(166)*U2 + Z(168)*U6 + Z(169)*U3
     & + Z(169)*U5 + Z(170)*U4
      Z(149) = Z(1)*Z(47) - Z(2)*Z(46)
      Z(603) = Z(5)*Z(147) - Z(6)*Z(149)
      Z(710) = Z(54)*Z(72) + Z(55)*Z(73)
      Z(712) = Z(54)*Z(74) + Z(55)*Z(75)
      Z(718) = -Z(15)*Z(710) - Z(16)*Z(712)
      Z(720) = Z(16)*Z(710) - Z(15)*Z(712)
      Z(722) = Z(27)*Z(718) + Z(28)*Z(720)
      Z(714) = Z(54)*Z(79) + Z(55)*Z(80)
      Z(707) = -Z(21)*Z(5) - Z(22)*Z(6)
      Z(730) = -Z(19)*Z(5) - Z(20)*Z(6)
      Z(726) = -Z(7)*Z(189) - Z(8)*Z(190)
      Z(121) = Z(1)*Z(51) - Z(2)*Z(50)
      Z(599) = Z(5)*Z(119) - Z(6)*Z(121)
      Z(733) = Z(101) + Z(492)*Z(9) + 0.5D0*Z(99)*Z(603) + 0.5D0*Z(99)*Z
     &(722) - LTHO - Z(95)*Z(5) - Z(97)*Z(555) - Z(97)*Z(714) - Z(102)*Z
     &(707) - Z(102)*Z(730) - Z(103)*Z(710) - Z(104)*Z(718) - Z(105)*Z(7
     &26) - Z(106)*Z(189) - Z(491)*Z(503) - 0.5D0*Z(494)*Z(599)
      Z(868) = MTH*Z(733)
      Z(736) = Z(179)*U7 + Z(180)*U1 + Z(181)*U2 + Z(182)*U6 + Z(183)*U5
     & + Z(185)*U3 + Z(186)*U4
      Z(611) = Z(22)*Z(149) - Z(21)*Z(147)
      Z(737) = Z(72)*Z(83) + Z(73)*Z(84)
      Z(739) = Z(74)*Z(83) + Z(75)*Z(84)
      Z(745) = -Z(15)*Z(737) - Z(16)*Z(739)
      Z(747) = Z(16)*Z(737) - Z(15)*Z(739)
      Z(749) = Z(27)*Z(745) + Z(28)*Z(747)
      Z(760) = Z(19)*Z(21) + Z(20)*Z(22)
      Z(741) = Z(79)*Z(83) + Z(80)*Z(84)
      Z(753) = -Z(11)*Z(745) - Z(12)*Z(747)
      Z(757) = -Z(21)*Z(3) - Z(22)*Z(4)
      Z(607) = Z(22)*Z(121) - Z(21)*Z(119)
      Z(763) = LUAO + Z(97)*Z(25) + 0.5D0*Z(99)*Z(611) + 0.5D0*Z(99)*Z(7
     &49) - Z(102) - Z(102)*Z(760) - Z(587)*Z(21) - Z(97)*Z(741) - Z(103
     &)*Z(737) - Z(104)*Z(745) - Z(105)*Z(753) - Z(106)*Z(757) - Z(491)*
     &Z(507) - Z(492)*Z(671) - Z(493)*Z(707) - 0.5D0*Z(494)*Z(607)
      Z(870) = MUA*Z(763)
      Z(766) = LUAO*U13 + Z(349)*U7 + Z(350)*U1 + Z(351)*U2 + Z(352)*U6 
     &+ Z(353)*U5 + Z(354)*U4 + Z(357)*U3 - Z(356)
      Z(774) = Z(11)*Z(15) - Z(12)*Z(16)
      Z(126) = Z(1)*Z(73) - Z(2)*Z(72)
      Z(777) = Z(3)*Z(124) - Z(4)*Z(126)
      Z(619) = Z(46)*Z(72) + Z(47)*Z(73)
      Z(771) = Z(28)*Z(16) - Z(27)*Z(15)
      Z(767) = Z(72)*Z(79) + Z(73)*Z(80)
      Z(781) = Z(20)*Z(126) - Z(19)*Z(124)
      Z(615) = Z(50)*Z(72) + Z(51)*Z(73)
      Z(788) = LFF + Z(785)*Z(774) + Z(786)*Z(777) + 0.5D0*Z(99)*Z(619) 
     &+ 0.5D0*Z(99)*Z(771) - LFFO - Z(103) - Z(95)*Z(124) - Z(97)*Z(559)
     & - Z(97)*Z(767) - Z(102)*Z(737) - Z(102)*Z(781) - Z(491)*Z(511) - 
     &Z(492)*Z(675) - Z(493)*Z(710) - Z(787)*Z(15) - 0.5D0*Z(494)*Z(615)
      Z(872) = MFF*Z(788)
      Z(791) = Z(264)*U7 + Z(265)*U1 + Z(266)*U2 + Z(267)*U6 + Z(268)*U5
     & + Z(269)*U4 + Z(273)*U10 + Z(274)*U8 + Z(275)*U3 + Z(276)*U9 - Z(
     &90)*U11
      Z(627) = Z(46)*Z(79) + Z(47)*Z(80)
      Z(768) = Z(74)*Z(79) + Z(75)*Z(80)
      Z(792) = -Z(15)*Z(767) - Z(16)*Z(768)
      Z(794) = Z(16)*Z(767) - Z(15)*Z(768)
      Z(796) = Z(27)*Z(792) + Z(28)*Z(794)
      Z(800) = -Z(11)*Z(792) - Z(12)*Z(794)
      Z(139) = Z(1)*Z(80) - Z(2)*Z(79)
      Z(804) = Z(3)*Z(137) - Z(4)*Z(139)
      Z(623) = Z(50)*Z(79) + Z(51)*Z(80)
      Z(808) = LLAO + Z(587)*Z(137) + 0.5D0*Z(99)*Z(627) + 0.5D0*Z(99)*Z
     &(796) - Z(97) - Z(588)*Z(23) - Z(97)*Z(563) - Z(102)*Z(741) - Z(10
     &3)*Z(767) - Z(104)*Z(792) - Z(105)*Z(800) - Z(106)*Z(804) - Z(491)
     &*Z(515) - Z(492)*Z(679) - Z(493)*Z(714) - 0.5D0*Z(494)*Z(623)
      Z(874) = MLA*Z(808)
      Z(811) = Z(337) + LLAO*U14 + Z(335)*U12 + Z(324)*U7 + Z(325)*U1 + 
     &Z(326)*U2 + Z(327)*U6 + Z(328)*U5 + Z(329)*U4 + Z(336)*U3
      Z(621) = Z(46)*Z(74) + Z(47)*Z(75)
      Z(635) = -Z(15)*Z(619) - Z(16)*Z(621)
      Z(637) = Z(16)*Z(619) - Z(15)*Z(621)
      Z(651) = -Z(11)*Z(635) - Z(12)*Z(637)
      Z(110) = Z(1)*Z(61) - Z(2)*Z(60)
      Z(836) = Z(20)*Z(110) - Z(19)*Z(108)
      Z(617) = Z(50)*Z(74) + Z(51)*Z(75)
      Z(631) = -Z(15)*Z(615) - Z(16)*Z(617)
      Z(633) = Z(16)*Z(615) - Z(15)*Z(617)
      Z(647) = -Z(11)*Z(631) - Z(12)*Z(633)
      Z(840) = LSH + Z(104)*Z(11) + 0.5D0*Z(99)*Z(484) + 0.5D0*Z(99)*Z(6
     &51) - LSHO - Z(105) - Z(95)*Z(108) - Z(97)*Z(575) - Z(97)*Z(800) -
     & Z(102)*Z(753) - Z(102)*Z(836) - Z(103)*Z(774) - Z(491)*Z(527) - Z
     &(492)*Z(691) - Z(493)*Z(726) - Z(786)*Z(7) - 0.5D0*Z(494)*Z(647)
      Z(882) = MSH*Z(840)
      Z(842) = Z(92)*U9 + Z(216)*U7 + Z(217)*U1 + Z(218)*U2 + Z(219)*U6 
     &+ Z(221)*U5 + Z(222)*U4 + Z(224)*U3 + Z(225)*U8
      Z(659) = Z(3)*Z(147) - Z(4)*Z(149)
      Z(230) = Z(1)*Z(69) - Z(2)*Z(68)
      Z(824) = Z(3)*Z(228) - Z(4)*Z(230)
      Z(843) = -Z(19)*Z(3) - Z(20)*Z(4)
      Z(116) = Z(1)*Z(65) - Z(2)*Z(64)
      Z(820) = Z(3)*Z(114) - Z(4)*Z(116)
      Z(655) = Z(3)*Z(119) - Z(4)*Z(121)
      Z(846) = LTH + Z(105)*Z(7) + 0.5D0*Z(99)*Z(659) + 0.5D0*Z(99)*Z(82
     &4) - LTHO - Z(106) - Z(95)*Z(3) - Z(97)*Z(579) - Z(97)*Z(804) - Z(
     &102)*Z(757) - Z(102)*Z(843) - Z(103)*Z(777) - Z(104)*Z(820) - Z(49
     &1)*Z(531) - Z(492)*Z(695) - Z(493)*Z(189) - 0.5D0*Z(494)*Z(655)
      Z(884) = MTH*Z(846)
      Z(849) = Z(199)*U7 + Z(200)*U1 + Z(201)*U2 + Z(202)*U6 + Z(203)*U5
     & + Z(205)*U4 + Z(206)*U3 - Z(93)*U8
      Z(667) = Z(20)*Z(149) - Z(19)*Z(147)
      Z(832) = Z(20)*Z(230) - Z(19)*Z(228)
      Z(828) = Z(20)*Z(116) - Z(19)*Z(114)
      Z(663) = Z(20)*Z(121) - Z(19)*Z(119)
      Z(850) = LUAO + Z(97)*Z(23) + 0.5D0*Z(99)*Z(667) + 0.5D0*Z(99)*Z(8
     &32) - Z(102) - Z(102)*Z(760) - Z(587)*Z(19) - Z(97)*Z(583) - Z(103
     &)*Z(781) - Z(104)*Z(828) - Z(105)*Z(836) - Z(106)*Z(843) - Z(491)*
     &Z(535) - Z(492)*Z(699) - Z(493)*Z(730) - 0.5D0*Z(494)*Z(663)
      Z(886) = MUA*Z(850)
      Z(853) = LUAO*U12 + Z(304)*U7 + Z(305)*U1 + Z(306)*U2 + Z(307)*U6 
     &+ Z(308)*U5 + Z(309)*U4 + Z(312)*U3 - Z(311)
      Z(643) = Z(27)*Z(635) + Z(28)*Z(637)
      Z(865) = MRF*(2*Z(95)*Z(147)+2*Z(97)*Z(547)+2*Z(97)*Z(627)+2*Z(102
     &)*Z(611)+2*Z(102)*Z(667)+2*Z(103)*Z(619)+2*Z(104)*Z(635)+2*Z(105)*
     &Z(651)+2*Z(106)*Z(659)-2*Z(595)-2*Z(864)-2*Z(100)*Z(43)-2*Z(101)*Z
     &(603)-2*Z(593)*Z(481)-Z(99)*Z(643))
      Z(598) = LRFFO*(U3+U5-U4-U6)
      Z(130) = Z(1)*Z(41) + Z(2)*Z(42)
      Z(516) = Z(41)*Z(79) + Z(42)*Z(80)
      Z(132) = Z(1)*Z(42) - Z(2)*Z(41)
      Z(508) = Z(22)*Z(132) - Z(21)*Z(130)
      Z(536) = Z(20)*Z(132) - Z(19)*Z(130)
      Z(512) = Z(41)*Z(72) + Z(42)*Z(73)
      Z(514) = Z(41)*Z(74) + Z(42)*Z(75)
      Z(520) = -Z(15)*Z(512) - Z(16)*Z(514)
      Z(522) = Z(16)*Z(512) - Z(15)*Z(514)
      Z(528) = -Z(11)*Z(520) - Z(12)*Z(522)
      Z(532) = Z(3)*Z(130) - Z(4)*Z(132)
      Z(504) = Z(5)*Z(130) - Z(6)*Z(132)
      Z(524) = Z(27)*Z(520) + Z(28)*Z(522)
      Z(861) = MRF*(2*Z(95)*Z(130)+2*Z(97)*Z(500)+2*Z(97)*Z(516)+2*Z(102
     &)*Z(508)+2*Z(102)*Z(536)+2*Z(103)*Z(512)+2*Z(104)*Z(520)+2*Z(105)*
     &Z(528)+2*Z(106)*Z(532)+2*Z(594)*Z(18)-2*Z(100)*Z(31)-2*Z(101)*Z(50
     &4)-2*Z(595)*Z(483)-Z(99)*Z(524))
      Z(541) = Z(39)*U1 + Z(40)*U2
      Z(877) = MRF*(2*Z(95)*Z(114)+2*Z(97)*Z(567)+2*Z(97)*Z(792)+2*Z(102
     &)*Z(745)+2*Z(102)*Z(828)+2*Z(785)*Z(11)-2*Z(815)-2*Z(876)-2*Z(103)
     &*Z(15)-2*Z(593)*Z(519)-2*Z(786)*Z(820)-2*Z(812)*Z(631)-2*Z(813)*Z(
     &683)-2*Z(814)*Z(718)-Z(99)*Z(635))
      Z(816) = Z(91)*(U10+U8-U3-U9)
      Z(880) = MRF*(2*Z(785)+Z(99)*Z(651)+2*Z(593)*Z(527)+2*Z(595)*Z(484
     &)+2*Z(812)*Z(647)+2*Z(813)*Z(691)+2*Z(814)*Z(726)-2*Z(95)*Z(108)-2
     &*Z(97)*Z(575)-2*Z(97)*Z(800)-2*Z(102)*Z(753)-2*Z(102)*Z(836)-2*Z(1
     &03)*Z(774)-2*Z(786)*Z(7)-2*Z(815)*Z(11))
      Z(819) = LSH*U9 + Z(216)*U7 + Z(217)*U1 + Z(218)*U2 + Z(219)*U6 + 
     &Z(221)*U5 + Z(222)*U4 + Z(226)*U3 + Z(227)*U8
      Z(109) = Z(1)*Z(62) + Z(2)*Z(63)
      Z(577) = Z(12)*Z(567) - Z(11)*Z(569)
      Z(802) = Z(12)*Z(792) - Z(11)*Z(794)
      Z(755) = Z(12)*Z(745) - Z(11)*Z(747)
      Z(111) = Z(1)*Z(63) - Z(2)*Z(62)
      Z(837) = Z(20)*Z(111) - Z(19)*Z(109)
      Z(776) = -Z(11)*Z(16) - Z(12)*Z(15)
      Z(529) = Z(12)*Z(519) - Z(11)*Z(521)
      Z(649) = Z(12)*Z(631) - Z(11)*Z(633)
      Z(693) = Z(12)*Z(683) - Z(11)*Z(685)
      Z(728) = Z(8)*Z(189) - Z(7)*Z(190)
      Z(653) = Z(12)*Z(635) - Z(11)*Z(637)
      Z(881) = MRF*(2*Z(95)*Z(109)+2*Z(97)*Z(577)+2*Z(97)*Z(802)+2*Z(102
     &)*Z(755)+2*Z(102)*Z(837)+2*Z(103)*Z(776)-2*Z(593)*Z(529)-2*Z(595)*
     &Z(485)-2*Z(786)*Z(8)-2*Z(812)*Z(649)-2*Z(813)*Z(693)-2*Z(814)*Z(72
     &8)-2*Z(815)*Z(12)-Z(99)*Z(653))
      Z(818) = Z(208)*U8 + Z(209)*U7 + Z(210)*U1 + Z(211)*U2 + Z(212)*U6
     & + Z(213)*U5 + Z(214)*U4 + Z(215)*U3
      Z(488) = IUA*LSp
      Z(490) = IUA*RSp
      Z(496) = Z(106)*Z(4) + Z(493)*Z(6) + 0.5D0*Z(99)*Z(149) + 0.5D0*Z(
     &99)*Z(230) - Z(102)*Z(20) - Z(102)*Z(22) - Z(97)*Z(139) - Z(97)*Z(
     &145) - Z(103)*Z(126) - Z(104)*Z(116) - Z(105)*Z(110) - Z(491)*Z(13
     &1) - Z(492)*Z(33) - 0.5D0*Z(494)*Z(121)
      Z(855) = MHAT*Z(496)
      Z(497) = Z(281)*U7 + Z(282)*U1 + Z(283)*U2 + Z(284)*U6 + Z(285)*U3
     & + Z(286)*U5 + Z(287)*U4
      Z(540) = Z(100)*Z(31) + Z(101)*Z(504) + 0.5D0*Z(99)*Z(483) + 0.5D0
     &*Z(99)*Z(524) - Z(95)*Z(130) - Z(97)*Z(500) - Z(97)*Z(516) - Z(102
     &)*Z(508) - Z(102)*Z(536) - Z(103)*Z(512) - Z(104)*Z(520) - Z(105)*
     &Z(528) - Z(106)*Z(532) - 0.5D0*Z(98)*Z(18)
      Z(857) = MFF*Z(540)
      Z(88) = Z(26)*Z(83) - Z(25)*Z(85)
      Z(144) = Z(1)*Z(88) + Z(2)*Z(89)
      Z(501) = Z(39)*Z(88) + Z(40)*Z(89)
      Z(502) = Z(41)*Z(88) + Z(42)*Z(89)
      Z(544) = -Z(17)*Z(501) - Z(18)*Z(502)
      Z(546) = Z(18)*Z(501) - Z(17)*Z(502)
      Z(548) = Z(27)*Z(544) + Z(28)*Z(546)
      Z(560) = Z(72)*Z(88) + Z(73)*Z(89)
      Z(562) = Z(74)*Z(88) + Z(75)*Z(89)
      Z(568) = -Z(15)*Z(560) - Z(16)*Z(562)
      Z(570) = Z(16)*Z(560) - Z(15)*Z(562)
      Z(572) = Z(27)*Z(568) + Z(28)*Z(570)
      Z(564) = Z(79)*Z(88) + Z(80)*Z(89)
      Z(146) = Z(1)*Z(89) - Z(2)*Z(88)
      Z(584) = Z(20)*Z(146) - Z(19)*Z(144)
      Z(576) = -Z(11)*Z(568) - Z(12)*Z(570)
      Z(580) = Z(3)*Z(144) - Z(4)*Z(146)
      Z(552) = -Z(13)*Z(544) - Z(14)*Z(546)
      Z(556) = Z(5)*Z(144) - Z(6)*Z(146)
      Z(590) = Z(588)*Z(26) + Z(587)*Z(144) + 0.5D0*Z(99)*Z(548) + 0.5D0
     &*Z(99)*Z(572) - Z(97)*Z(564) - Z(102)*Z(584) - Z(103)*Z(560) - Z(1
     &04)*Z(568) - Z(105)*Z(576) - Z(106)*Z(580) - Z(491)*Z(501) - Z(492
     &)*Z(552) - Z(493)*Z(556) - 0.5D0*Z(494)*Z(544)
      Z(859) = MLA*Z(590)
      Z(591) = Z(368) + Z(361)*U7 + Z(362)*U1 + Z(363)*U2 + Z(364)*U6 + 
     &Z(365)*U5 + Z(366)*U4 + Z(367)*U3 - Z(360)*U13
      Z(676) = Z(37)*Z(72) + Z(38)*Z(73)
      Z(678) = Z(37)*Z(74) + Z(38)*Z(75)
      Z(684) = -Z(15)*Z(676) - Z(16)*Z(678)
      Z(686) = Z(16)*Z(676) - Z(15)*Z(678)
      Z(688) = Z(27)*Z(684) + Z(28)*Z(686)
      Z(553) = Z(14)*Z(543) - Z(13)*Z(545)
      Z(680) = Z(37)*Z(79) + Z(38)*Z(80)
      Z(672) = Z(22)*Z(32) - Z(21)*Z(34)
      Z(700) = Z(20)*Z(32) - Z(19)*Z(34)
      Z(692) = -Z(11)*Z(684) - Z(12)*Z(686)
      Z(696) = Z(3)*Z(34) - Z(4)*Z(32)
      Z(704) = Z(101)*Z(10) + 0.5D0*Z(99)*Z(44) + 0.5D0*Z(99)*Z(688) - Z
     &(95)*Z(34) - Z(97)*Z(553) - Z(97)*Z(680) - Z(102)*Z(672) - Z(102)*
     &Z(700) - Z(103)*Z(676) - Z(104)*Z(684) - Z(105)*Z(692) - Z(106)*Z(
     &696) - Z(491)*Z(30) - 0.5D0*Z(494)*Z(14)
      Z(867) = MSH*Z(704)
      Z(705) = Z(159)*U4 + Z(159)*U6 + Z(160)*U7 + Z(161)*U3 + Z(161)*U5
     & + Z(162)*U1 + Z(163)*U2
      Z(605) = Z(5)*Z(149) + Z(6)*Z(147)
      Z(56) = Z(1)*Z(6) - Z(2)*Z(5)
      Z(711) = Z(54)*Z(73) + Z(56)*Z(72)
      Z(713) = Z(54)*Z(75) + Z(56)*Z(74)
      Z(719) = -Z(15)*Z(711) - Z(16)*Z(713)
      Z(721) = Z(16)*Z(711) - Z(15)*Z(713)
      Z(723) = Z(27)*Z(719) + Z(28)*Z(721)
      Z(557) = Z(5)*Z(145) + Z(6)*Z(143)
      Z(715) = Z(54)*Z(80) + Z(56)*Z(79)
      Z(708) = Z(22)*Z(5) - Z(21)*Z(6)
      Z(731) = Z(20)*Z(5) - Z(19)*Z(6)
      Z(727) = -Z(7)*Z(191) - Z(8)*Z(189)
      Z(505) = Z(5)*Z(131) + Z(6)*Z(129)
      Z(601) = Z(5)*Z(121) + Z(6)*Z(119)
      Z(734) = Z(492)*Z(10) + 0.5D0*Z(99)*Z(605) + 0.5D0*Z(99)*Z(723) - 
     &Z(95)*Z(6) - Z(97)*Z(557) - Z(97)*Z(715) - Z(102)*Z(708) - Z(102)*
     &Z(731) - Z(103)*Z(711) - Z(104)*Z(719) - Z(105)*Z(727) - Z(106)*Z(
     &191) - Z(491)*Z(505) - 0.5D0*Z(494)*Z(601)
      Z(869) = MTH*Z(734)
      Z(735) = Z(173)*U7 + Z(174)*U1 + Z(175)*U2 + Z(176)*U6 + Z(177)*U3
     & + Z(177)*U5 + Z(178)*U4
      Z(613) = -Z(21)*Z(149) - Z(22)*Z(147)
      Z(738) = Z(72)*Z(85) + Z(73)*Z(83)
      Z(740) = Z(74)*Z(85) + Z(75)*Z(83)
      Z(746) = -Z(15)*Z(738) - Z(16)*Z(740)
      Z(748) = Z(16)*Z(738) - Z(15)*Z(740)
      Z(750) = Z(27)*Z(746) + Z(28)*Z(748)
      Z(761) = Z(19)*Z(22) - Z(20)*Z(21)
      Z(742) = Z(79)*Z(85) + Z(80)*Z(83)
      Z(754) = -Z(11)*Z(746) - Z(12)*Z(748)
      Z(758) = Z(21)*Z(4) - Z(22)*Z(3)
      Z(509) = -Z(21)*Z(131) - Z(22)*Z(129)
      Z(673) = -Z(21)*Z(33) - Z(22)*Z(32)
      Z(709) = Z(21)*Z(6) - Z(22)*Z(5)
      Z(609) = -Z(21)*Z(121) - Z(22)*Z(119)
      Z(764) = Z(97)*Z(26) + 0.5D0*Z(99)*Z(613) + 0.5D0*Z(99)*Z(750) - Z
     &(102)*Z(761) - Z(587)*Z(22) - Z(97)*Z(742) - Z(103)*Z(738) - Z(104
     &)*Z(746) - Z(105)*Z(754) - Z(106)*Z(758) - Z(491)*Z(509) - Z(492)*
     &Z(673) - Z(493)*Z(709) - 0.5D0*Z(494)*Z(609)
      Z(871) = MUA*Z(764)
      Z(765) = Z(342)*U7 + Z(343)*U1 + Z(344)*U2 + Z(345)*U6 + Z(346)*U5
     & + Z(347)*U4 + Z(348)*U3
      Z(775) = Z(11)*Z(16) + Z(12)*Z(15)
      Z(125) = Z(1)*Z(74) + Z(2)*Z(75)
      Z(127) = Z(1)*Z(75) - Z(2)*Z(74)
      Z(778) = Z(3)*Z(125) - Z(4)*Z(127)
      Z(772) = -Z(27)*Z(16) - Z(28)*Z(15)
      Z(782) = Z(20)*Z(127) - Z(19)*Z(125)
      Z(789) = Z(785)*Z(775) + Z(786)*Z(778) + 0.5D0*Z(99)*Z(621) + 0.5D
     &0*Z(99)*Z(772) - Z(95)*Z(125) - Z(97)*Z(561) - Z(97)*Z(768) - Z(10
     &2)*Z(739) - Z(102)*Z(782) - Z(491)*Z(513) - Z(492)*Z(677) - Z(493)
     &*Z(712) - Z(787)*Z(16) - 0.5D0*Z(494)*Z(617)
      Z(873) = MFF*Z(789)
      Z(790) = Z(253)*U9 + Z(254)*U7 + Z(255)*U1 + Z(256)*U2 + Z(257)*U6
     & + Z(258)*U5 + Z(259)*U4 + Z(260)*U3 + Z(261)*U8 - Z(262)*U10
      Z(81) = Z(24)*Z(76) - Z(23)*Z(78)
      Z(138) = Z(1)*Z(81) + Z(2)*Z(82)
      Z(629) = Z(46)*Z(81) + Z(47)*Z(82)
      Z(769) = Z(72)*Z(81) + Z(73)*Z(82)
      Z(770) = Z(74)*Z(81) + Z(75)*Z(82)
      Z(793) = -Z(15)*Z(769) - Z(16)*Z(770)
      Z(795) = Z(16)*Z(769) - Z(15)*Z(770)
      Z(797) = Z(27)*Z(793) + Z(28)*Z(795)
      Z(565) = Z(81)*Z(86) + Z(82)*Z(87)
      Z(743) = Z(81)*Z(83) + Z(82)*Z(84)
      Z(801) = -Z(11)*Z(793) - Z(12)*Z(795)
      Z(140) = Z(1)*Z(82) - Z(2)*Z(81)
      Z(805) = Z(3)*Z(138) - Z(4)*Z(140)
      Z(517) = Z(39)*Z(81) + Z(40)*Z(82)
      Z(681) = Z(35)*Z(81) + Z(36)*Z(82)
      Z(716) = Z(54)*Z(81) + Z(55)*Z(82)
      Z(625) = Z(50)*Z(81) + Z(51)*Z(82)
      Z(809) = Z(588)*Z(24) + Z(587)*Z(138) + 0.5D0*Z(99)*Z(629) + 0.5D0
     &*Z(99)*Z(797) - Z(97)*Z(565) - Z(102)*Z(743) - Z(103)*Z(769) - Z(1
     &04)*Z(793) - Z(105)*Z(801) - Z(106)*Z(805) - Z(491)*Z(517) - Z(492
     &)*Z(681) - Z(493)*Z(716) - 0.5D0*Z(494)*Z(625)
      Z(875) = MLA*Z(809)
      Z(810) = Z(323) + Z(316)*U7 + Z(317)*U1 + Z(318)*U2 + Z(319)*U6 + 
     &Z(320)*U5 + Z(321)*U4 + Z(322)*U3 - Z(315)*U12
      Z(841) = Z(786)*Z(8) + 0.5D0*Z(99)*Z(485) + 0.5D0*Z(99)*Z(653) - Z
     &(95)*Z(109) - Z(97)*Z(577) - Z(97)*Z(802) - Z(102)*Z(755) - Z(102)
     &*Z(837) - Z(103)*Z(776) - Z(104)*Z(12) - Z(491)*Z(529) - Z(492)*Z(
     &693) - Z(493)*Z(728) - 0.5D0*Z(494)*Z(649)
      Z(883) = MSH*Z(841)
      Z(661) = Z(3)*Z(149) + Z(4)*Z(147)
      Z(826) = Z(3)*Z(230) + Z(4)*Z(228)
      Z(581) = Z(3)*Z(145) + Z(4)*Z(143)
      Z(806) = Z(3)*Z(139) + Z(4)*Z(137)
      Z(759) = Z(22)*Z(3) - Z(21)*Z(4)
      Z(844) = Z(20)*Z(3) - Z(19)*Z(4)
      Z(779) = Z(3)*Z(126) + Z(4)*Z(124)
      Z(822) = Z(3)*Z(116) + Z(4)*Z(114)
      Z(533) = Z(3)*Z(131) + Z(4)*Z(129)
      Z(697) = Z(3)*Z(33) + Z(4)*Z(32)
      Z(657) = Z(3)*Z(121) + Z(4)*Z(119)
      Z(847) = Z(105)*Z(8) + 0.5D0*Z(99)*Z(661) + 0.5D0*Z(99)*Z(826) - Z
     &(95)*Z(4) - Z(97)*Z(581) - Z(97)*Z(806) - Z(102)*Z(759) - Z(102)*Z
     &(844) - Z(103)*Z(779) - Z(104)*Z(822) - Z(491)*Z(533) - Z(492)*Z(6
     &97) - Z(493)*Z(190) - 0.5D0*Z(494)*Z(657)
      Z(885) = MTH*Z(847)
      Z(848) = Z(192)*U7 + Z(193)*U1 + Z(194)*U2 + Z(195)*U6 + Z(196)*U3
     & + Z(197)*U5 + Z(198)*U4
      Z(669) = -Z(19)*Z(149) - Z(20)*Z(147)
      Z(834) = -Z(19)*Z(230) - Z(20)*Z(228)
      Z(762) = Z(20)*Z(21) - Z(19)*Z(22)
      Z(585) = -Z(19)*Z(145) - Z(20)*Z(143)
      Z(783) = -Z(19)*Z(126) - Z(20)*Z(124)
      Z(830) = -Z(19)*Z(116) - Z(20)*Z(114)
      Z(838) = -Z(19)*Z(110) - Z(20)*Z(108)
      Z(845) = Z(19)*Z(4) - Z(20)*Z(3)
      Z(537) = -Z(19)*Z(131) - Z(20)*Z(129)
      Z(701) = -Z(19)*Z(33) - Z(20)*Z(32)
      Z(732) = Z(19)*Z(6) - Z(20)*Z(5)
      Z(665) = -Z(19)*Z(121) - Z(20)*Z(119)
      Z(851) = Z(97)*Z(24) + 0.5D0*Z(99)*Z(669) + 0.5D0*Z(99)*Z(834) - Z
     &(102)*Z(762) - Z(587)*Z(20) - Z(97)*Z(585) - Z(103)*Z(783) - Z(104
     &)*Z(830) - Z(105)*Z(838) - Z(106)*Z(845) - Z(491)*Z(537) - Z(492)*
     &Z(701) - Z(493)*Z(732) - 0.5D0*Z(494)*Z(665)
      Z(887) = MUA*Z(851)
      Z(852) = Z(297)*U7 + Z(298)*U1 + Z(299)*U2 + Z(300)*U6 + Z(301)*U5
     & + Z(302)*U4 + Z(303)*U3
      Z(860) = MRF*(2*Z(95)*Z(129)+2*Z(97)*Z(499)+2*Z(97)*Z(515)+2*Z(102
     &)*Z(507)+2*Z(102)*Z(535)+2*Z(103)*Z(511)+2*Z(104)*Z(519)+2*Z(105)*
     &Z(527)+2*Z(106)*Z(531)+2*Z(594)*Z(17)-2*Z(593)-2*Z(100)*Z(29)-2*Z(
     &101)*Z(503)-2*Z(595)*Z(481)-Z(99)*Z(523))
      Z(596) = LFF*U4 + LFF*U6 + LFF*U7 + Z(41)*U1 + Z(42)*U2 - LFF*U3 -
     & LFF*U5
      Z(639) = Z(27)*Z(631) + Z(28)*Z(633)
      Z(863) = MRF*(Z(862)+Z(99)*Z(639)+2*Z(101)*Z(599)-2*Z(95)*Z(119)-2
     &*Z(97)*Z(543)-2*Z(97)*Z(623)-2*Z(100)*Z(13)-2*Z(102)*Z(607)-2*Z(10
     &2)*Z(663)-2*Z(103)*Z(615)-2*Z(104)*Z(631)-2*Z(105)*Z(647)-2*Z(106)
     &*Z(655)-2*Z(593)*Z(17))
      Z(597) = LRFO*(U3+U5-U4-U6)
      Z(879) = MRF*(2*Z(95)*Z(228)+2*Z(97)*Z(571)+2*Z(97)*Z(796)+2*Z(102
     &)*Z(749)+2*Z(102)*Z(832)+2*Z(103)*Z(771)-2*Z(595)-2*Z(878)-2*Z(593
     &)*Z(523)-2*Z(785)*Z(484)-2*Z(786)*Z(824)-2*Z(812)*Z(639)-2*Z(813)*
     &Z(687)-2*Z(814)*Z(722)-Z(99)*Z(643))
      Z(817) = LRFFO*(U10+U8-U3-U9)
      HZ = Z(487) + Z(489) + IHAT*U3 + ILA*U12 + ILA*U13 + ILA*U14 + ILA
     &*U15 + IUA*U12 + IUA*U13 + 2*IFF*U3 + 2*ILA*U3 + 2*IRF*U3 + 2*ISH*
     &U3 + 2*ITH*U3 + 2*IUA*U3 + IRF*(U5-U4-U6) + IFF*(U5-U4-U6-U7) + Z(
     &854)*Z(498) + Z(856)*Z(542) + Z(858)*Z(592) + Z(866)*Z(706) + Z(86
     &8)*Z(736) + Z(870)*Z(766) + Z(872)*Z(791) + Z(874)*Z(811) + Z(882)
     &*Z(842) + Z(884)*Z(849) + Z(886)*Z(853) + 0.25D0*Z(865)*Z(598) + 0
     &.5D0*Z(861)*Z(541) + 0.5D0*Z(877)*Z(816) + 0.5D0*Z(880)*Z(819) + 0
     &.5D0*Z(881)*Z(818) - Z(488) - Z(490) - ITH*U4 - ITH*U8 - ISH*(U4-U
     &5) - ISH*(U8-U9) - IRF*(U10+U8-U9) - IFF*(U10+U11+U8-U9) - Z(855)*
     &Z(497) - Z(857)*Z(541) - Z(859)*Z(591) - Z(867)*Z(705) - Z(869)*Z(
     &735) - Z(871)*Z(765) - Z(873)*Z(790) - Z(875)*Z(810) - Z(883)*Z(81
     &8) - Z(885)*Z(848) - Z(887)*Z(852) - 0.5D0*Z(860)*Z(596) - 0.25D0*
     &Z(863)*Z(597) - 0.25D0*Z(879)*Z(817)
      Z(70) = Z(27)*Z(66) - Z(28)*Z(64)
      Z(902) = MFF*Z(39)
      Z(903) = MFF*Z(40)
      Z(926) = MRF*Z(39)
      Z(927) = MRF*Z(40)
      Z(888) = MHAT*Z(281)
      Z(889) = MHAT*Z(282)
      Z(890) = MHAT*Z(283)
      Z(891) = MHAT*Z(284)
      Z(892) = MHAT*Z(285)
      Z(893) = MHAT*Z(286)
      Z(894) = MHAT*Z(287)
      Z(933) = MSH*Z(159)
      Z(934) = MSH*Z(160)
      Z(935) = MSH*Z(161)
      Z(936) = MSH*Z(162)
      Z(937) = MSH*Z(163)
      Z(938) = MSH*Z(164)
      Z(939) = MSH*Z(165)
      Z(940) = MSH*Z(166)
      Z(941) = MSH*Z(168)
      Z(942) = MSH*Z(169)
      Z(943) = MSH*Z(170)
      Z(944) = MTH*Z(173)
      Z(945) = MTH*Z(174)
      Z(946) = MTH*Z(175)
      Z(947) = MTH*Z(176)
      Z(948) = MTH*Z(177)
      Z(949) = MTH*Z(178)
      Z(950) = MTH*Z(179)
      Z(951) = MTH*Z(180)
      Z(952) = MTH*Z(181)
      Z(953) = MTH*Z(182)
      Z(954) = MTH*Z(183)
      Z(955) = MTH*Z(185)
      Z(956) = MTH*Z(186)
      Z(1047) = MTH*Z(192)
      Z(1048) = MTH*Z(193)
      Z(1049) = MTH*Z(194)
      Z(1050) = MTH*Z(195)
      Z(1051) = MTH*Z(196)
      Z(1052) = MTH*Z(197)
      Z(1053) = MTH*Z(198)
      Z(1062) = MUA*Z(297)
      Z(1063) = MUA*Z(298)
      Z(1064) = MUA*Z(299)
      Z(1065) = MUA*Z(300)
      Z(1066) = MUA*Z(301)
      Z(1067) = MUA*Z(302)
      Z(1068) = MUA*Z(303)
      Z(957) = MUA*Z(342)
      Z(958) = MUA*Z(343)
      Z(959) = MUA*Z(344)
      Z(960) = MUA*Z(345)
      Z(961) = MUA*Z(346)
      Z(962) = MUA*Z(347)
      Z(963) = MUA*Z(348)
      Z(1011) = MLA*Z(337)
      Z(1003) = MLA*Z(335)
      Z(1004) = MLA*Z(324)
      Z(1005) = MLA*Z(325)
      Z(1006) = MLA*Z(326)
      Z(1007) = MLA*Z(327)
      Z(1008) = MLA*Z(328)
      Z(1009) = MLA*Z(329)
      Z(1010) = MLA*Z(336)
      Z(925) = MLA*Z(382)
      Z(917) = MLA*Z(380)
      Z(918) = MLA*Z(369)
      Z(919) = MLA*Z(370)
      Z(920) = MLA*Z(371)
      Z(921) = MLA*Z(372)
      Z(922) = MLA*Z(373)
      Z(923) = MLA*Z(374)
      Z(924) = MLA*Z(381)
      Z(973) = MFF*Z(253)
      Z(974) = MFF*Z(254)
      Z(975) = MFF*Z(255)
      Z(976) = MFF*Z(256)
      Z(977) = MFF*Z(257)
      Z(978) = MFF*Z(258)
      Z(979) = MFF*Z(259)
      Z(980) = MFF*Z(260)
      Z(981) = MFF*Z(261)
      Z(982) = MFF*Z(262)
      Z(1013) = MRF*Z(208)
      Z(1014) = MRF*Z(209)
      Z(1015) = MRF*Z(210)
      Z(1016) = MRF*Z(211)
      Z(1017) = MRF*Z(212)
      Z(1018) = MRF*Z(213)
      Z(1019) = MRF*Z(214)
      Z(1020) = MRF*Z(215)
      Z(1030) = MSH*Z(208)
      Z(1031) = MSH*Z(209)
      Z(1032) = MSH*Z(210)
      Z(1033) = MSH*Z(211)
      Z(1034) = MSH*Z(212)
      Z(1035) = MSH*Z(213)
      Z(1036) = MSH*Z(214)
      Z(1037) = MSH*Z(215)
      Z(1022) = MRF*Z(216)
      Z(1023) = MRF*Z(217)
      Z(1024) = MRF*Z(218)
      Z(1025) = MRF*Z(219)
      Z(1026) = MRF*Z(221)
      Z(1027) = MRF*Z(222)
      Z(1028) = MRF*Z(226)
      Z(1029) = MRF*Z(227)
      Z(1039) = MSH*Z(216)
      Z(1040) = MSH*Z(217)
      Z(1041) = MSH*Z(218)
      Z(1042) = MSH*Z(219)
      Z(1043) = MSH*Z(221)
      Z(1044) = MSH*Z(222)
      Z(1045) = MSH*Z(224)
      Z(1046) = MSH*Z(225)
      Z(52) = -Z(13)*Z(37) - Z(14)*Z(35)
      Z(48) = Z(35)*Z(45) + Z(37)*Z(43)
      Z(895) = MHAT*Z(288)
      Z(896) = MHAT*Z(289)
      Z(897) = MHAT*Z(290)
      Z(898) = MHAT*Z(291)
      Z(899) = MHAT*Z(292)
      Z(900) = MHAT*Z(294)
      Z(901) = MHAT*Z(295)
      Z(1054) = MTH*Z(199)
      Z(1055) = MTH*Z(200)
      Z(1056) = MTH*Z(201)
      Z(1057) = MTH*Z(202)
      Z(1058) = MTH*Z(203)
      Z(1059) = MTH*Z(205)
      Z(1060) = MTH*Z(206)
      Z(1076) = MUA*Z(311)
      Z(1069) = MUA*Z(304)
      Z(1070) = MUA*Z(305)
      Z(1071) = MUA*Z(306)
      Z(1072) = MUA*Z(307)
      Z(1073) = MUA*Z(308)
      Z(1074) = MUA*Z(309)
      Z(1075) = MUA*Z(312)
      Z(1001) = MLA*Z(315)
      Z(1002) = MLA*Z(323)
      Z(994) = MLA*Z(316)
      Z(995) = MLA*Z(317)
      Z(996) = MLA*Z(318)
      Z(997) = MLA*Z(319)
      Z(998) = MLA*Z(320)
      Z(999) = MLA*Z(321)
      Z(1000) = MLA*Z(322)
      Z(972) = MUA*Z(356)
      Z(965) = MUA*Z(349)
      Z(966) = MUA*Z(350)
      Z(967) = MUA*Z(351)
      Z(968) = MUA*Z(352)
      Z(969) = MUA*Z(353)
      Z(970) = MUA*Z(354)
      Z(971) = MUA*Z(357)
      Z(914) = MLA*Z(360)
      Z(915) = MLA*Z(368)
      Z(907) = MLA*Z(361)
      Z(908) = MLA*Z(362)
      Z(909) = MLA*Z(363)
      Z(910) = MLA*Z(364)
      Z(911) = MLA*Z(365)
      Z(912) = MLA*Z(366)
      Z(913) = MLA*Z(367)
      Z(983) = MFF*Z(264)
      Z(984) = MFF*Z(265)
      Z(985) = MFF*Z(266)
      Z(986) = MFF*Z(267)
      Z(987) = MFF*Z(268)
      Z(988) = MFF*Z(269)
      Z(989) = MFF*Z(273)
      Z(990) = MFF*Z(274)
      Z(991) = MFF*Z(275)
      Z(992) = MFF*Z(276)
      Z(905) = MFF*Z(41)
      Z(906) = MFF*Z(42)
      Z(929) = MRF*Z(41)
      Z(930) = MRF*Z(42)
      PX = 0.5D0*Z(932)*Z(70)*(U10+U8-U3-U9) + Z(39)*(Z(902)*U1+Z(903)*U
     &2+Z(926)*U1+Z(927)*U2) + Z(1)*(Z(888)*U7+Z(889)*U1+Z(890)*U2+Z(891
     &)*U6+Z(892)*U3+Z(893)*U5+Z(894)*U4) + Z(35)*(Z(933)*U4+Z(933)*U6+Z
     &(934)*U7+Z(935)*U3+Z(935)*U5+Z(936)*U1+Z(937)*U2) + Z(37)*(Z(938)*
     &U7+Z(939)*U1+Z(940)*U2+Z(941)*U6+Z(942)*U3+Z(942)*U5+Z(943)*U4) + 
     &Z(54)*(Z(944)*U7+Z(945)*U1+Z(946)*U2+Z(947)*U6+Z(948)*U3+Z(948)*U5
     &+Z(949)*U4) + Z(56)*(Z(950)*U7+Z(951)*U1+Z(952)*U2+Z(953)*U6+Z(954
     &)*U5+Z(955)*U3+Z(956)*U4) + Z(57)*(Z(1047)*U7+Z(1048)*U1+Z(1049)*U
     &2+Z(1050)*U6+Z(1051)*U3+Z(1052)*U5+Z(1053)*U4) + Z(76)*(Z(1062)*U7
     &+Z(1063)*U1+Z(1064)*U2+Z(1065)*U6+Z(1066)*U5+Z(1067)*U4+Z(1068)*U3
     &) + Z(83)*(Z(957)*U7+Z(958)*U1+Z(959)*U2+Z(960)*U6+Z(961)*U5+Z(962
     &)*U4+Z(963)*U3) + Z(81)*(Z(1011)+Z(916)*U14+Z(1003)*U12+Z(1004)*U7
     &+Z(1005)*U1+Z(1006)*U2+Z(1007)*U6+Z(1008)*U5+Z(1009)*U4+Z(1010)*U3
     &) + Z(88)*(Z(925)+Z(916)*U15+Z(917)*U13+Z(918)*U7+Z(919)*U1+Z(920)
     &*U2+Z(921)*U6+Z(922)*U5+Z(923)*U4+Z(924)*U3) + Z(72)*(Z(973)*U9+Z(
     &974)*U7+Z(975)*U1+Z(976)*U2+Z(977)*U6+Z(978)*U5+Z(979)*U4+Z(980)*U
     &3+Z(981)*U8-Z(982)*U10) + Z(60)*(Z(1013)*U8+Z(1014)*U7+Z(1015)*U1+
     &Z(1016)*U2+Z(1017)*U6+Z(1018)*U5+Z(1019)*U4+Z(1020)*U3+Z(1030)*U8+
     &Z(1031)*U7+Z(1032)*U1+Z(1033)*U2+Z(1034)*U6+Z(1035)*U5+Z(1036)*U4+
     &Z(1037)*U3) + Z(62)*(Z(1021)*U9+Z(1038)*U9+Z(1022)*U7+Z(1023)*U1+Z
     &(1024)*U2+Z(1025)*U6+Z(1026)*U5+Z(1027)*U4+Z(1028)*U3+Z(1029)*U8+Z
     &(1039)*U7+Z(1040)*U1+Z(1041)*U2+Z(1042)*U6+Z(1043)*U5+Z(1044)*U4+Z
     &(1045)*U3+Z(1046)*U8) - Z(1012)*Z(66)*(U10+U8-U3-U9) - 0.5D0*Z(931
     &)*Z(52)*(U3+U5-U4-U6) - 0.5D0*Z(932)*Z(48)*(U3+U5-U4-U6) - Z(2)*(Z
     &(895)*U7+Z(896)*U1+Z(897)*U2+Z(898)*U6+Z(899)*U5+Z(900)*U4+Z(901)*
     &U3) - Z(59)*(Z(1061)*U8-Z(1054)*U7-Z(1055)*U1-Z(1056)*U2-Z(1057)*U
     &6-Z(1058)*U5-Z(1059)*U4-Z(1060)*U3) - Z(78)*(Z(1076)-Z(964)*U12-Z(
     &1069)*U7-Z(1070)*U1-Z(1071)*U2-Z(1072)*U6-Z(1073)*U5-Z(1074)*U4-Z(
     &1075)*U3) - Z(79)*(Z(1001)*U12-Z(1002)-Z(994)*U7-Z(995)*U1-Z(996)*
     &U2-Z(997)*U6-Z(998)*U5-Z(999)*U4-Z(1000)*U3) - Z(85)*(Z(972)-Z(964
     &)*U13-Z(965)*U7-Z(966)*U1-Z(967)*U2-Z(968)*U6-Z(969)*U5-Z(970)*U4-
     &Z(971)*U3) - Z(86)*(Z(914)*U13-Z(915)-Z(907)*U7-Z(908)*U1-Z(909)*U
     &2-Z(910)*U6-Z(911)*U5-Z(912)*U4-Z(913)*U3) - Z(74)*(Z(993)*U11-Z(9
     &83)*U7-Z(984)*U1-Z(985)*U2-Z(986)*U6-Z(987)*U5-Z(988)*U4-Z(989)*U1
     &0-Z(990)*U8-Z(991)*U3-Z(992)*U9) - Z(41)*(Z(904)*U3+Z(904)*U5+Z(92
     &8)*U3+Z(928)*U5-Z(904)*U4-Z(904)*U6-Z(904)*U7-Z(928)*U4-Z(928)*U6-
     &Z(928)*U7-Z(905)*U1-Z(906)*U2-Z(929)*U1-Z(930)*U2)
      PY = 0.5D0*Z(932)*Z(71)*(U10+U8-U3-U9) + Z(40)*(Z(902)*U1+Z(903)*U
     &2+Z(926)*U1+Z(927)*U2) + Z(1)*(Z(895)*U7+Z(896)*U1+Z(897)*U2+Z(898
     &)*U6+Z(899)*U5+Z(900)*U4+Z(901)*U3) + Z(2)*(Z(888)*U7+Z(889)*U1+Z(
     &890)*U2+Z(891)*U6+Z(892)*U3+Z(893)*U5+Z(894)*U4) + Z(36)*(Z(933)*U
     &4+Z(933)*U6+Z(934)*U7+Z(935)*U3+Z(935)*U5+Z(936)*U1+Z(937)*U2) + Z
     &(38)*(Z(938)*U7+Z(939)*U1+Z(940)*U2+Z(941)*U6+Z(942)*U3+Z(942)*U5+
     &Z(943)*U4) + Z(54)*(Z(950)*U7+Z(951)*U1+Z(952)*U2+Z(953)*U6+Z(954)
     &*U5+Z(955)*U3+Z(956)*U4) + Z(55)*(Z(944)*U7+Z(945)*U1+Z(946)*U2+Z(
     &947)*U6+Z(948)*U3+Z(948)*U5+Z(949)*U4) + Z(58)*(Z(1047)*U7+Z(1048)
     &*U1+Z(1049)*U2+Z(1050)*U6+Z(1051)*U3+Z(1052)*U5+Z(1053)*U4) + Z(77
     &)*(Z(1062)*U7+Z(1063)*U1+Z(1064)*U2+Z(1065)*U6+Z(1066)*U5+Z(1067)*
     &U4+Z(1068)*U3) + Z(84)*(Z(957)*U7+Z(958)*U1+Z(959)*U2+Z(960)*U6+Z(
     &961)*U5+Z(962)*U4+Z(963)*U3) + Z(82)*(Z(1011)+Z(916)*U14+Z(1003)*U
     &12+Z(1004)*U7+Z(1005)*U1+Z(1006)*U2+Z(1007)*U6+Z(1008)*U5+Z(1009)*
     &U4+Z(1010)*U3) + Z(89)*(Z(925)+Z(916)*U15+Z(917)*U13+Z(918)*U7+Z(9
     &19)*U1+Z(920)*U2+Z(921)*U6+Z(922)*U5+Z(923)*U4+Z(924)*U3) + Z(73)*
     &(Z(973)*U9+Z(974)*U7+Z(975)*U1+Z(976)*U2+Z(977)*U6+Z(978)*U5+Z(979
     &)*U4+Z(980)*U3+Z(981)*U8-Z(982)*U10) + Z(61)*(Z(1013)*U8+Z(1014)*U
     &7+Z(1015)*U1+Z(1016)*U2+Z(1017)*U6+Z(1018)*U5+Z(1019)*U4+Z(1020)*U
     &3+Z(1030)*U8+Z(1031)*U7+Z(1032)*U1+Z(1033)*U2+Z(1034)*U6+Z(1035)*U
     &5+Z(1036)*U4+Z(1037)*U3) + Z(63)*(Z(1021)*U9+Z(1038)*U9+Z(1022)*U7
     &+Z(1023)*U1+Z(1024)*U2+Z(1025)*U6+Z(1026)*U5+Z(1027)*U4+Z(1028)*U3
     &+Z(1029)*U8+Z(1039)*U7+Z(1040)*U1+Z(1041)*U2+Z(1042)*U6+Z(1043)*U5
     &+Z(1044)*U4+Z(1045)*U3+Z(1046)*U8) - Z(1012)*Z(67)*(U10+U8-U3-U9) 
     &- 0.5D0*Z(931)*Z(53)*(U3+U5-U4-U6) - 0.5D0*Z(932)*Z(49)*(U3+U5-U4-
     &U6) - Z(57)*(Z(1061)*U8-Z(1054)*U7-Z(1055)*U1-Z(1056)*U2-Z(1057)*U
     &6-Z(1058)*U5-Z(1059)*U4-Z(1060)*U3) - Z(76)*(Z(1076)-Z(964)*U12-Z(
     &1069)*U7-Z(1070)*U1-Z(1071)*U2-Z(1072)*U6-Z(1073)*U5-Z(1074)*U4-Z(
     &1075)*U3) - Z(80)*(Z(1001)*U12-Z(1002)-Z(994)*U7-Z(995)*U1-Z(996)*
     &U2-Z(997)*U6-Z(998)*U5-Z(999)*U4-Z(1000)*U3) - Z(83)*(Z(972)-Z(964
     &)*U13-Z(965)*U7-Z(966)*U1-Z(967)*U2-Z(968)*U6-Z(969)*U5-Z(970)*U4-
     &Z(971)*U3) - Z(87)*(Z(914)*U13-Z(915)-Z(907)*U7-Z(908)*U1-Z(909)*U
     &2-Z(910)*U6-Z(911)*U5-Z(912)*U4-Z(913)*U3) - Z(75)*(Z(993)*U11-Z(9
     &83)*U7-Z(984)*U1-Z(985)*U2-Z(986)*U6-Z(987)*U5-Z(988)*U4-Z(989)*U1
     &0-Z(990)*U8-Z(991)*U3-Z(992)*U9) - Z(42)*(Z(904)*U3+Z(904)*U5+Z(92
     &8)*U3+Z(928)*U5-Z(904)*U4-Z(904)*U6-Z(904)*U7-Z(928)*U4-Z(928)*U6-
     &Z(928)*U7-Z(905)*U1-Z(906)*U2-Z(929)*U1-Z(930)*U2)
      Z(1230) = Z(1112) + Z(964)*Z(433) - Z(1116) - MLA*(Z(315)*Z(441)-Z
     &(335)*Z(442))
      Z(1270) = Z(465)*(Z(315)*Z(80)-Z(335)*Z(82)) + Z(1230) - Z(1093)*Z
     &(76)
      Z(1223) = Z(1222) + Z(964)*Z(312) - MLA*(Z(315)*Z(322)-Z(335)*Z(33
     &6))
      Z(1224) = Z(964)*Z(304) - MLA*(Z(315)*Z(316)-Z(335)*Z(324))
      Z(1225) = Z(964)*Z(305) - MLA*(Z(315)*Z(317)-Z(335)*Z(325))
      Z(1226) = Z(964)*Z(306) - MLA*(Z(315)*Z(318)-Z(335)*Z(326))
      Z(1227) = Z(964)*Z(307) - MLA*(Z(315)*Z(319)-Z(335)*Z(327))
      Z(1228) = Z(964)*Z(308) - MLA*(Z(315)*Z(320)-Z(335)*Z(328))
      Z(1229) = Z(964)*Z(309) - MLA*(Z(315)*Z(321)-Z(335)*Z(329))
      RSTQ = -Z(1270) - Z(1223)*U3p - Z(1224)*U7p - Z(1225)*U1p - Z(1226
     &)*U2p - Z(1227)*U6p - Z(1228)*U5p - Z(1229)*U4p
      Z(1238) = Z(1102) + Z(964)*Z(450) - Z(1110) - MLA*(Z(360)*Z(458)-Z
     &(380)*Z(459))
      Z(1271) = Z(465)*(Z(360)*Z(87)-Z(380)*Z(89)) + Z(1238) - Z(1093)*Z
     &(83)
      Z(1231) = Z(1222) + Z(964)*Z(357) - MLA*(Z(360)*Z(367)-Z(380)*Z(38
     &1))
      Z(1232) = Z(964)*Z(349) - MLA*(Z(360)*Z(361)-Z(380)*Z(369))
      Z(1233) = Z(964)*Z(350) - MLA*(Z(360)*Z(362)-Z(380)*Z(370))
      Z(1234) = Z(964)*Z(351) - MLA*(Z(360)*Z(363)-Z(380)*Z(371))
      Z(1235) = Z(964)*Z(352) - MLA*(Z(360)*Z(364)-Z(380)*Z(372))
      Z(1236) = Z(964)*Z(353) - MLA*(Z(360)*Z(365)-Z(380)*Z(373))
      Z(1237) = Z(964)*Z(354) - MLA*(Z(360)*Z(366)-Z(380)*Z(374))
      LSTQ = -Z(1271) - Z(1231)*U3p - Z(1232)*U7p - Z(1233)*U1p - Z(1234
     &)*U2p - Z(1235)*U6p - Z(1236)*U5p - Z(1237)*U4p
      Z(1097) = Z(1096)*Z(82)
      Z(1246) = Z(1112) + Z(916)*Z(442)
      Z(1268) = Z(1097) - Z(1246)
      Z(1239) = ILA + Z(916)*Z(336)
      Z(1240) = Z(916)*Z(324)
      Z(1241) = Z(916)*Z(325)
      Z(1242) = Z(916)*Z(326)
      Z(1243) = Z(916)*Z(327)
      Z(1244) = Z(916)*Z(328)
      Z(1245) = Z(916)*Z(329)
      RETQ = Z(1268) - Z(1239)*U3p - Z(1240)*U7p - Z(1241)*U1p - Z(1242)
     &*U2p - Z(1243)*U6p - Z(1244)*U5p - Z(1245)*U4p
      Z(1098) = Z(1096)*Z(89)
      Z(1254) = Z(1102) + Z(916)*Z(459)
      Z(1269) = Z(1098) - Z(1254)
      Z(1247) = ILA + Z(916)*Z(381)
      Z(1248) = Z(916)*Z(369)
      Z(1249) = Z(916)*Z(370)
      Z(1250) = Z(916)*Z(371)
      Z(1251) = Z(916)*Z(372)
      Z(1252) = Z(916)*Z(373)
      Z(1253) = Z(916)*Z(374)
      LETQ = Z(1269) - Z(1247)*U3p - Z(1248)*U7p - Z(1249)*U1p - Z(1250)
     &*U2p - Z(1251)*U6p - Z(1252)*U5p - Z(1253)*U4p
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
      RH = Q8
      RHp = U8
      RHpp = U8p
      RK = Q9
      RKp = U9
      RKpp = U9p
      RA = Q10
      RAp = U10
      RApp = U10p
      RMTPp = U11
      RMTPpp = U11p
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
      Z(387) = Z(97)*(LEp-LSp)
      Z(388) = Z(102)*LSp
      Z(389) = Z(97)*(REp-RSp)
      Z(390) = Z(102)*RSp
      VOCMX = U1 + Z(106)*Z(59)*(U3-U8) + Z(100)*Z(37)*(U4-U3-U5) + Z(81
     &)*(Z(389)+Z(97)*U12+Z(97)*U14+Z(97)*U3) + Z(88)*(Z(387)+Z(97)*U13+
     &Z(97)*U15+Z(97)*U3) + 0.5D0*Z(99)*Z(70)*(U10+U8-U3-U9) - Z(95)*Z(2
     &)*U3 - Z(101)*Z(56)*(U3-U4) - Z(105)*Z(62)*(U8-U3-U9) - Z(104)*Z(6
     &6)*(U10+U8-U3-U9) - Z(78)*(Z(390)-Z(102)*U12-Z(102)*U3) - Z(85)*(Z
     &(388)-Z(102)*U13-Z(102)*U3) - 0.5D0*Z(98)*Z(52)*(U3+U5-U4-U6) - 0.
     &5D0*Z(99)*Z(48)*(U3+U5-U4-U6) - Z(103)*Z(74)*(U10+U11+U8-U3-U9) - 
     &Z(96)*Z(41)*(U3+U5-U4-U6-U7)
      VOCMY = U2 + Z(95)*Z(1)*U3 + Z(106)*Z(57)*(U3-U8) + Z(100)*Z(38)*(
     &U4-U3-U5) + Z(82)*(Z(389)+Z(97)*U12+Z(97)*U14+Z(97)*U3) + Z(89)*(Z
     &(387)+Z(97)*U13+Z(97)*U15+Z(97)*U3) + 0.5D0*Z(99)*Z(71)*(U10+U8-U3
     &-U9) - Z(101)*Z(54)*(U3-U4) - Z(105)*Z(63)*(U8-U3-U9) - Z(104)*Z(6
     &7)*(U10+U8-U3-U9) - Z(76)*(Z(390)-Z(102)*U12-Z(102)*U3) - Z(83)*(Z
     &(388)-Z(102)*U13-Z(102)*U3) - 0.5D0*Z(98)*Z(53)*(U3+U5-U4-U6) - 0.
     &5D0*Z(99)*Z(49)*(U3+U5-U4-U6) - Z(103)*Z(75)*(U10+U11+U8-U3-U9) - 
     &Z(96)*Z(42)*(U3+U5-U4-U6-U7)
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
      WRITE(22,6020) T,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,U1,U2,U3,U4,U5
     &,U6,U7,U8,U9,U10,U11
      WRITE(23,6020) T,RX,RY,RX1,RX2,RY1,RY2
      WRITE(24,6020) T,RHTQ,LHTQ,RKTQ,LKTQ,RATQ,LATQ,RMTQ,LMTQ,RSTQ,LSTQ
     &,RETQ,LETQ
      WRITE(25,6020) T,RH,LH,RK,LK,RA,LA,RMTP,LMTP,RS,LS,RE,LE,RHp,LHp,R
     &Kp,LKp,RAp,LAp,RMTPp,LMTPp,RSp,LSp,REp,LEp,RHpp,LHpp,RKpp,LKpp,RAp
     &p,LApp,RMTPpp,LMTPpp,RSpp,LSpp,REpp,LEpp
      WRITE(26,6020) T,KECM,HZ,PX,PY

6020  FORMAT( 99(1X, 1PE14.6E3) )

      RETURN
      END


