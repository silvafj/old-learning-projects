{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{|  PROGRAMA            => Geral V3.0  IntroduáÑo                          |}
{*  PROGRAMADO EM       => Turbo Pascal 7.0                                *}
{|  AUTOR               => Fernando Jorge de Almeida da Silva              |}
{*  ENDEREÄO            => Juncal - Assequins 3750 Ügueda                  *}
{|  TELEFONE            => (034) 602800                                    |}
{*  DATA DA PROGRAMAÄéO => Setembro/95                                     *}
{|  COM PARTICIPAÄéO DE =>                                                 |}
{*                                                                         *}
{|  FUNÄéO DO PROGRAMA  => Jogo do GALO para o GERAL                       |}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROGRAM GALO;
USES

    TP,GRAPH,DRIVERS,OBJECTS,CRT,DOS;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| CONSTANTES |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| GLOBAIS |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

CONST
   COR_O=2;
   COR_X=4;

TYPE
    QUADRADO=(NULO,_O_,_X_);
    JOGADOR=(__O__,__X__);

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| VARIÜVEIS |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| GLOBAIS |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

VAR
      H,J:SHORTINT;
      PATH:DIRSTR;
      NAME:NAMESTR;
      EXT:EXTSTR;
      MAT:ARRAY[1..3,1..3] OF QUADRADO;
      JOG:JOGADOR;
      FINDOU,AINDA_NAO:BOOLEAN;
      JOGOS_GANHOS:ARRAY[JOGADOR] OF WORD;
      gd,gm:integer;


{( 1 )-*-*-*-*-*-*-*-*-*-*-*-*-*-*| GALO |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

PROCEDURE PRINCIPAL;FORWARD;

PROCEDURE NORM;
BEGIN
     REGS.AH:=$01;
     REGS.CH:=$06;
     REGS.CL:=$07;
     INTR($10,REGS);
END;
PROCEDURE OFF;
BEGIN
     REGS.AH:=$01;
     REGS.CH:=$70;
     REGS.CL:=$00;
     INTR($10,REGS);
END;
PROCEDURE DESENHA(TIPO:QUADRADO;H,J:SHORTINT);
VAR
   X,Y:BYTE;
BEGIN
     DONEEVENTS;
     CASE H OF
          1:X:=23;
          2:X:=36;
          3:X:=49;
     END;
     CASE J OF
          1:Y:=6;
          2:Y:=11;
          3:Y:=16;
     END;
     CASE TIPO OF
          NULO:FILLSCR(X,Y,X+10,Y+3,7);
          _O_:FILLSCR(X,Y,X+10,Y+3,COR_O);
          _X_:FILLSCR(X,Y,X+10,Y+3,COR_X);
     END;
     WINDOW(1,1,80,25);
     TEXTBACKGROUND(1);
     INITEVENTS;
END;
PROCEDURE GANHOU(TIPO:SHORTINT;JOG:QUADRADO);
VAR
   X,Y:BYTE;
BEGIN
     DONEEVENTS;
     CASE JOG OF
          _O_:JOGOS_GANHOS[__O__]:=JOGOS_GANHOS[__O__]+1;
          _X_:JOGOS_GANHOS[__X__]:=JOGOS_GANHOS[__X__]+1;
     END;
     TEXTBACKGROUND(1);
     TEXTCOLOR(COR_O);
     WRITEXY('€€',4,5);
     TEXTCOLOR(14);
     WRITE(' = ',JOGOS_GANHOS[__O__]);
     TEXTCOLOR(COR_X);
     WRITEXY('€€',66,5);
     TEXTCOLOR(14);
     WRITE(' = ',JOGOS_GANHOS[__X__]);
     CASE JOG OF
          _O_:TEXTCOLOR(COR_O+128);
          _X_:TEXTCOLOR(COR_X+128);
     END;
     CASE TIPO OF
          1:BEGIN
                 FOR X:=23 TO 33 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
                 FOR X:=23 TO 33 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
                 FOR X:=23 TO 33 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
            END;
          2:BEGIN
                 FOR X:=36 TO 46 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
            END;
          3:BEGIN
                 FOR X:=49 TO 59 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
                 FOR X:=49 TO 59 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
                 FOR X:=49 TO 59 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
            END;
          4:BEGIN
                 FOR X:=23 TO 33 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
                 FOR X:=49 TO 59 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
            END;
          5:BEGIN
                 FOR X:=23 TO 33 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
                 FOR X:=49 TO 59 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
            END;
          6:BEGIN
                 FOR X:=23 TO 33 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
                 FOR X:=49 TO 59 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
            END;
          7:BEGIN
                 FOR X:=23 TO 33 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
                 FOR X:=49 TO 59 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
            END;
          8:BEGIN
                 FOR X:=49 TO 59 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
                 FOR X:=23 TO 33 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
            END;
     END;
     INITEVENTS;
     GOTOXY(1,22);
     CLREOL;
     TEXTCOLOR(14);
     WRITEXY('Ganhou o',8,11);
     WRITEXY('jogador:',8,12);
     CASE JOG OF
          _O_:BEGIN
               TEXTCOLOR(COR_O);
               SND(1000,150);
               NO(100);
               SND(1000,150);
               NO(100);
               SND(1000,150);
               NOSOUND;
              END;
          _X_:BEGIN
               TEXTCOLOR(COR_X);
               SND(50,150);
               NO(100);
               SND(50,150);
               NO(100);
               SND(50,150);
               NOSOUND;
              END;
     END;
     WRITEXY('€€',11,14);
     TEXTCOLOR(15);
     TEXTBACKGROUND(3);
     WRITEXY('  Continuar  ',65,11);
     WRITEXY('  Cancelar   ',65,14);
     REPEAT
           IF (MOUSEBUTTONS=$01) AND (MOUSEWHERE.X+1 IN [65..77]) THEN CASE MOUSEWHERE.Y+1 OF
                                                                            11:PRINCIPAL;
                                                                            14:BEGIN
                                                                                    NORM;
                                                                                    DONEEVENTS;
                                                                                    TEXTCOLOR(7);
                                                                                    FILLSCR(1,1,80,25,0);
                                                                                    HALT;
                                                                               END;
                                                                       END;
           DELAY(100);
     UNTIL FALSE;
END;

PROCEDURE PRINCIPAL;
BEGIN
     DONEEVENTS;
     FOR H:=1 TO 3 DO
         FOR J:=1 TO 3 DO
             MAT[H,J]:=NULO;
     JOG:=__O__;
     AINDA_NAO:=TRUE;
     FILLSCR(1,1,80,25,1);
     TEXTCOLOR(15);
     HORIZONTAL(4,3,73,'Õ');
     HORIZONTAL(4,23,73,'Õ');
     WRITEXY('GALO V1.0',4,2);
     TEXTCOLOR(0);
     FILLSCR(21,5,61,20,7);
     WINDOW(21,5,61,21);
     HORIZONTAL(1,1,40,'€');
     HORIZONTAL(1,6,40,'€');
     HORIZONTAL(1,11,40,'€');
     HORIZONTAL(1,16,40,'€');
     VERTICAL(1,2,14,0,'€€');
     VERTICAL(14,2,14,0,'€€');
     VERTICAL(27,2,14,0,'€€');
     VERTICAL(40,2,14,0,'€€');
     WINDOW(1,1,80,25);
     TEXTBACKGROUND(1);
     TEXTCOLOR(COR_O);
     WRITEXY('€€',4,5);
     TEXTCOLOR(14);
     WRITE(' = ',JOGOS_GANHOS[__O__]);
     TEXTCOLOR(COR_X);
     WRITEXY('€€',66,5);
     TEXTCOLOR(14);
     WRITE(' = ',JOGOS_GANHOS[__X__]);
     TEXTCOLOR(0);
     TEXTBACKGROUND(1);
     INITEVENTS;
     REPEAT
           FINDOU:=TRUE;
           H:=0;
           J:=0;
           TEXTCOLOR(14);
           WINDOW(1,1,80,25);
           S:='Jogador actual:   ';
           WRITEXY(S,40-(LENGTH(S) DIV 2),22);
           CASE JOG OF
                __O__:TEXTCOLOR(COR_O);
                __X__:TEXTCOLOR(COR_X);
           END;
           WRITEXY('€€',WHEREX-2,WHEREY);
           IF MOUSEBUTTONS=$01 THEN BEGIN
                                         IF MOUSEWHERE.X+1 IN [23..33] THEN H:=1;
                                         IF MOUSEWHERE.X+1 IN [36..46] THEN H:=2;
                                         IF MOUSEWHERE.X+1 IN [49..59] THEN H:=3;
                                         IF MOUSEWHERE.Y+1 IN [6..9] THEN J:=1;
                                         IF MOUSEWHERE.Y+1 IN [11..14] THEN J:=2;
                                         IF MOUSEWHERE.Y+1 IN [16..19] THEN J:=3;
                                         IF (H<>0) AND (J<>0) AND (MAT[H,J]=NULO) THEN BEGIN
                                                                                            CASE JOG OF
                                                                                                 __O__:BEGIN
                                                                                                            SND(1000,150);
                                                                                                            NOSOUND;
                                                                                                            MAT[H,J]:=_O_;
                                                                                                            JOG:=__X__;
                                                                                                       END;
                                                                                                 __X__:BEGIN
                                                                                                            SND(50,150);
                                                                                                            NOSOUND;
                                                                                                            MAT[H,J]:=_X_;
                                                                                                            JOG:=__O__;
                                                                                                       END;
                                                                                            END;
                                                                                            DESENHA(MAT[H,J],H,J);
                                                                                       END;
                                         IF (MAT[1,1]=MAT[1,2]) AND (MAT[1,2]=MAT[1,3]) AND (MAT[1,1]<>NULO)
                                            THEN GANHOU(1,MAT[1,1]);
                                         IF (MAT[2,1]=MAT[2,2]) AND (MAT[2,2]=MAT[2,3]) AND (MAT[2,1]<>NULO)
                                            THEN GANHOU(2,MAT[2,1]);
                                         IF (MAT[3,1]=MAT[3,2]) AND (MAT[3,2]=MAT[3,3]) AND (MAT[3,1]<>NULO)
                                            THEN GANHOU(3,MAT[3,1]);
                                         IF (MAT[1,1]=MAT[2,1]) AND (MAT[2,1]=MAT[3,1]) AND (MAT[1,1]<>NULO)
                                            THEN GANHOU(4,MAT[1,1]);
                                         IF (MAT[1,2]=MAT[2,2]) AND (MAT[2,2]=MAT[3,2]) AND (MAT[1,2]<>NULO)
                                            THEN GANHOU(5,MAT[1,2]);
                                         IF (MAT[1,3]=MAT[2,3]) AND (MAT[2,3]=MAT[3,3]) AND (MAT[1,3]<>NULO)
                                            THEN GANHOU(6,MAT[1,3]);
                                         IF (MAT[1,1]=MAT[2,2]) AND (MAT[2,2]=MAT[3,3]) AND (MAT[1,1]<>NULO)
                                            THEN GANHOU(7,MAT[1,1]);
                                         IF (MAT[3,1]=MAT[2,2]) AND (MAT[2,2]=MAT[1,3]) AND (MAT[3,1]<>NULO)
                                            THEN GANHOU(8,MAT[3,1]);
                                    END;
           FOR H:=1 TO 3 DO
               FOR J:=1 TO 3 DO
                   IF MAT[H,J]=NULO THEN FINDOU:=FALSE;
           IF FINDOU THEN BEGIN
                               IF AINDA_NAO THEN BEGIN
                                                      GOTOXY(1,22);
                                                      CLREOL;
                                                      TEXTCOLOR(14);
                                                      WRITEXY('  NÑo h†',6,12);
                                                      WRITEXY('vencedores.',6,13);
                                                      TEXTCOLOR(15);
                                                      TEXTBACKGROUND(3);
                                                      WRITEXY('  Continuar  ',65,11);
                                                      WRITEXY('  Cancelar   ',65,14);
                                                      AINDA_NAO:=FALSE;
                                                 END;
                               REPEAT
                                    IF (MOUSEBUTTONS=$01) AND (MOUSEWHERE.X+1 IN [65..77])
                                        THEN CASE MOUSEWHERE.Y+1 OF
                                                  11:PRINCIPAL;
                                                  14:BEGIN
                                                          NORM;
                                                          DONEEVENTS;
                                                          TEXTCOLOR(7);
                                                          FILLSCR(1,1,80,25,0);
                                                     END;
                                             END;
                                     DELAY(100);
                               UNTIL FALSE;
                          END;
           DELAY(150);
     UNTIL MOUSEBUTTONS=$02;
     DONEEVENTS;
     NORM;
     TEXTCOLOR(7);
     FILLSCR(1,1,80,25,0);
     HALT;
END;

BEGIN
      CHECKBREAK:=FALSE;
      FSPLIT(PARAMSTR(0),PATH,NAME,EXT);
      OFF;
      JOGOS_GANHOS[__O__]:=0;
      JOGOS_GANHOS[__X__]:=0;
      PRINCIPAL;
    END.
