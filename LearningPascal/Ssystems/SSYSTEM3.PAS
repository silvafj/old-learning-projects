UNIT SSYSTEM3;

INTERFACE
 USES
    CRT,GRAPH,SSYSTEM1,SSYSTEM2;

  PROCEDURE DesignSquare(X1,Y1,X2,Y2,Color:INTEGER;On:BOOLEAN);
  PROCEDURE DesignSquareNumber(Number:INTEGER;On:BOOLEAN);
  PROCEDURE WriteSquareNumber(Number,Color:INTEGER;Texto:STRING);
  PROCEDURE InsertSquareNumber(Number:INTEGER);
  FUNCTION Look(Estado:STRING):BOOLEAN;
  FUNCTION VerifyTableForCaracteristicas:BOOLEAN;
  PROCEDURE DesignFirstScreen(Number:INTEGER;On:BOOLEAN);
  PROCEDURE DesignCaracteristicasScreen;

IMPLEMENTATION
{*****}
  PROCEDURE DesignSquare(X1,Y1,X2,Y2,Color:INTEGER;On:BOOLEAN);
   { Designs the square for locating position }

    BEGIN
      IF On THEN
        BEGIN
          SetColor(Color);
          Rectangle(X1,Y1,X2,Y2);
          Rectangle(X1+1,Y1+1,X2-1,Y2-1);
          Rectangle(X1+2,Y1+2,X2-2,Y2-2);
        END
       ELSE
        BEGIN
          SetColor(0);
          Rectangle(X1,Y1,X2,Y2);
          Rectangle(X1+1,Y1+1,X2-1,Y2-1);
          Rectangle(X1+2,Y1+2,X2-2,Y2-2);
        END;
    END; { DesignSquare }

{*****}
  PROCEDURE DesignSquareNumber(Number:INTEGER;On:BOOLEAN);
   { Designs the square number X }

    BEGIN
      CASE Number OF
        1:BEGIN
            DesignSquare(111,86,163,122,13,On); { Quadrado 1 | Estado A }
          END;
        2:BEGIN
            DesignSquare(165,86,217,122,13,On); { Quadrado 2 |          }
          END;
        3:BEGIN
            DesignSquare(219,86,271,122,13,On); { Quadrado 3 |          }
          END;
        4:BEGIN
            DesignSquare(273,86,325,122,13,On);  { Quadrado 4 |          }
          END;
        5:BEGIN
            DesignSquare(111,124,163,160,13,On);  { Quadrado 1 | Estado B }
          END;
        6:BEGIN
            DesignSquare(165,124,217,160,13,On);  { Quadrado 2 |          }
          END;
        7:BEGIN
            DesignSquare(219,124,271,160,13,On);  { Quadrado 3 |          }
          END;
        8:BEGIN
            DesignSquare(273,124,325,160,13,On);  { Quadrado 4 |          }
          END;
        9:BEGIN
            DesignSquare(111,162,163,198,13,On);  { Quadrado 1 | Estado C }
          END;
       10:BEGIN
            DesignSquare(165,162,217,198,13,On);  { Quadrado 2 |          }
          END;
       11:BEGIN
            DesignSquare(219,162,271,198,13,On);  { Quadrado 3 |          }
          END;
       12:BEGIN
            DesignSquare(273,162,325,198,13,On);  { Quadrado 4 |          }
          END;
       13:BEGIN
            DesignSquare(111,200,163,236,13,On);  { Quadrado 1 | Estado D }
          END;
       14:BEGIN
            DesignSquare(165,200,217,236,13,On);  { Quadrado 2 |          }
          END;
       15:BEGIN
            DesignSquare(219,200,271,236,13,On);  { Quadrado 3 |          }
          END;
       16:BEGIN
            DesignSquare(273,200,325,236,13,On);  { Quadrado 4 |          }
          END;
       17:BEGIN
            DesignSquare(111,238,163,274,13,On);  { Quadrado 1 | Estado E }
          END;
       18:BEGIN
            DesignSquare(165,238,217,274,13,On);  { Quadrado 2 |          }
          END;
       19:BEGIN
            DesignSquare(219,238,271,274,13,On);  { Quadrado 3 |          }
          END;
       20:BEGIN
            DesignSquare(273,238,325,274,13,On);  { Quadrado 4 |          }
          END;
       21:BEGIN
            DesignSquare(111,276,163,312,13,On);  { Quadrado 1 | Estado F }
          END;
       22:BEGIN
            DesignSquare(165,276,217,312,13,On);  { Quadrado 2 |          }
          END;
       23:BEGIN
            DesignSquare(219,276,271,312,13,On);  { Quadrado 3 |          }
          END;
       24:BEGIN
            DesignSquare(273,276,325,312,13,On);  { Quadrado 4 |          }
          END;
       25:BEGIN
            DesignSquare(111,314,163,350,13,On);  { Quadrado 1 | Estado G }
          END;
       26:BEGIN
            DesignSquare(165,314,217,350,13,On);  { Quadrado 2 |          }
          END;
       27:BEGIN
            DesignSquare(219,314,271,350,13,On);  { Quadrado 3 |          }
          END;
       28:BEGIN
            DesignSquare(273,314,325,350,13,On);  { Quadrado 4 |          }
          END;
       29:BEGIN
            DesignSquare(111,352,163,388,13,On);  { Quadrado 1 | Estado H }
          END;
       30:BEGIN
            DesignSquare(165,352,217,388,13,On);  { Quadrado 2 |          }
          END;
       31:BEGIN
            DesignSquare(219,352,271,388,13,On);  { Quadrado 3 |          }
          END;
       32:BEGIN
            DesignSquare(273,352,325,388,13,On);  { Quadrado 4 |          }
          END;
      END; { End Case Number }
    END; { DesignSquareNumber }

{*****}
  PROCEDURE WriteSquareNumber(Number,Color:INTEGER;Texto:STRING);
   { Writes the information in the square number X }

    BEGIN
      SetColor(Color);
      SetTextJustify(1,1);
      CASE Number OF
        1:BEGIN
            OutTextXY(137,104,Texto); { Quadrado 1 | Estado A }
          END;
        2:BEGIN
            OutTextXY(191,104,Texto); { Quadrado 2 |          }
          END;
        3:BEGIN
            OutTextXY(245,104,Texto); { Quadrado 3 |          }
          END;
        4:BEGIN
            OutTextXY(299,104,Texto);  { Quadrado 4 |          }
          END;
        5:BEGIN
            OutTextXY(137,142,Texto);  { Quadrado 1 | Estado B }
          END;
        6:BEGIN
            OutTextXY(191,142,Texto);  { Quadrado 2 |          }
          END;
        7:BEGIN
            OutTextXY(245,142,Texto);  { Quadrado 3 |          }
          END;
        8:BEGIN
            OutTextXY(299,142,Texto);  { Quadrado 4 |          }
          END;
        9:BEGIN
            OutTextXY(137,180,Texto);  { Quadrado 1 | Estado C }
          END;
       10:BEGIN
            OutTextXY(191,180,Texto);  { Quadrado 2 |          }
          END;
       11:BEGIN
            OutTextXY(245,180,Texto);  { Quadrado 3 |          }
          END;
       12:BEGIN
            OutTextXY(299,180,Texto);  { Quadrado 4 |          }
          END;
       13:BEGIN
            OutTextXY(137,216,Texto);  { Quadrado 1 | Estado D }
          END;
       14:BEGIN
            OutTextXY(191,216,Texto);  { Quadrado 2 |          }
          END;
       15:BEGIN
            OutTextXY(245,216,Texto);  { Quadrado 3 |          }
          END;
       16:BEGIN
            OutTextXY(299,216,Texto);  { Quadrado 4 |          }
          END;
       17:BEGIN
            OutTextXY(137,254,Texto);  { Quadrado 1 | Estado E }
          END;
       18:BEGIN
            OutTextXY(191,254,Texto);  { Quadrado 2 |          }
          END;
       19:BEGIN
            OutTextXY(245,254,Texto);  { Quadrado 3 |          }
          END;
       20:BEGIN
            OutTextXY(299,254,Texto);  { Quadrado 4 |          }
          END;
       21:BEGIN
            OutTextXY(137,294,Texto);  { Quadrado 1 | Estado F }
          END;
       22:BEGIN
            OutTextXY(191,294,Texto);  { Quadrado 2 |          }
          END;
       23:BEGIN
            OutTextXY(245,294,Texto);  { Quadrado 3 |          }
          END;
       24:BEGIN
            OutTextXY(299,294,Texto);  { Quadrado 4 |          }
          END;
       25:BEGIN
            OutTextXY(137,332,Texto);  { Quadrado 1 | Estado G }
          END;
       26:BEGIN
            OutTextXY(191,332,Texto);  { Quadrado 2 |          }
          END;
       27:BEGIN
            OutTextXY(245,332,Texto);  { Quadrado 3 |          }
          END;
       28:BEGIN
            OutTextXY(299,332,Texto);  { Quadrado 4 |          }
          END;
       29:BEGIN
            OutTextXY(137,370,Texto);  { Quadrado 1 | Estado H }
          END;
       30:BEGIN
            OutTextXY(191,370,Texto);  { Quadrado 2 |          }
          END;
       31:BEGIN
            OutTextXY(245,370,Texto);  { Quadrado 3 |          }
          END;
       32:BEGIN
            OutTextXY(299,370,Texto);  { Quadrado 4 |          }
          END;
      END; { End Case Number }
    END; { WriteSquareNumber }

{*****}
  PROCEDURE InsertSquareNumber(Number:INTEGER);
   { Inserts the information in the square number X }

    VAR
      Texto:STRING;
      Out:BYTE;
      Ok:BOOLEAN;
      Tecla,Esta,Entr,Num:INTEGER;

    BEGIN
      CASE Number OF
        1:BEGIN
            Esta:=1;
            Entr:=1;
          END;
        2:BEGIN
            Esta:=1;
            Entr:=2;
          END;
        3:BEGIN
            Esta:=1;
            Entr:=3;
          END;
        4:BEGIN
            Esta:=1;
            Entr:=4;
          END;
        5:BEGIN
            Esta:=2;
            Entr:=1;
          END;
        6:BEGIN
            Esta:=2;
            Entr:=2;
          END;
        7:BEGIN
            Esta:=2;
            Entr:=3;
          END;
        8:BEGIN
            Esta:=2;
            Entr:=4;
          END;
        9:BEGIN
            Esta:=3;
            Entr:=1;
          END;
       10:BEGIN
            Esta:=3;
            Entr:=2;
          END;
       11:BEGIN
            Esta:=3;
            Entr:=3;
          END;
       12:BEGIN
            Esta:=3;
            Entr:=4;
          END;
       13:BEGIN
            Esta:=4;
            Entr:=1;
          END;
       14:BEGIN
            Esta:=4;
            Entr:=2;
          END;
       15:BEGIN
            Esta:=4;
            Entr:=3;
          END;
       16:BEGIN
            Esta:=4;
            Entr:=4;
          END;
       17:BEGIN
            Esta:=5;
            Entr:=1;
          END;
       18:BEGIN
            Esta:=5;
            Entr:=2;
          END;
       19:BEGIN
            Esta:=5;
            Entr:=3;
          END;
       20:BEGIN
            Esta:=5;
            Entr:=4;
          END;
       21:BEGIN
            Esta:=6;
            Entr:=1;
          END;
       22:BEGIN
            Esta:=6;
            Entr:=2;
          END;
       23:BEGIN
            Esta:=6;
            Entr:=3;
          END;
       24:BEGIN
            Esta:=6;
            Entr:=4;
          END;
       25:BEGIN
            Esta:=7;
            Entr:=1;
          END;
       26:BEGIN
            Esta:=7;
            Entr:=2;
          END;
       27:BEGIN
            Esta:=7;
            Entr:=3;
          END;
       28:BEGIN
            Esta:=7;
            Entr:=4;
          END;
       29:BEGIN
            Esta:=8;
            Entr:=1;
          END;
       30:BEGIN
            Esta:=8;
            Entr:=2;
          END;
       31:BEGIN
            Esta:=8;
            Entr:=3;
          END;
       32:BEGIN
            Esta:=8;
            Entr:=4;
          END;
      END; { End Case number }
            SetTextStyle(8,0,1);
            SetTextJustify(1,1);
            Texto:=Tabela_Estados_Letras[Esta,Entr]+'/'+Tabela_Estados_Saidas[Esta,Entr];
            WriteSquareNumber(Number,0,Texto);
            Ok:=FALSE;
            REPEAT
              Tabela_Estados_Letras[Esta,Entr]:=RStrU(380,335,0,1,Tabela_Estados_Letras[Esta,Entr],'Estado : ',Out,FALSE);
              Tabela_Estados_Saidas[Esta,Entr]:=RStrU(380,365,0,1,Tabela_Estados_Saidas[Esta,Entr],'Saida  : ',Out,FALSE);
              Tabela_Estados_Letras[Esta,Entr]:=RStrU(380,335,0,1,Tabela_Estados_Letras[Esta,Entr],'Estado : ',Out,TRUE);
              IF (Tabela_Estados_Letras[Esta,Entr] <> 'A') AND (Tabela_Estados_Letras[Esta,Entr] <> 'B')
                 AND (Tabela_Estados_Letras[Esta,Entr] <> 'C') AND (Tabela_Estados_Letras[Esta,Entr] <> 'D')
                 AND (Tabela_Estados_Letras[Esta,Entr] <> 'E') AND (Tabela_Estados_Letras[Esta,Entr] <> 'F')
                 AND (Tabela_Estados_Letras[Esta,Entr] <> 'G') AND (Tabela_Estados_Letras[Esta,Entr] <> 'H')
                 AND (Tabela_Estados_Letras[Esta,Entr] <> '') THEN
               BEGIN
                 SetColor(4);
                 SetTextJustify(1,1);
                 SetTextStyle(5,0,1);
                 OutTextXY(500,210,'Estado inv†lido');
                 OutTextXY(500,230,'Estados permitidos entre "A" e "H"');
                 OutTextXY(500,250,'Pressione Enter');
                 REPEAT
                   Tecla:=ReadNewKey;
                 UNTIL Tecla=13;
                 SetColor(0);
                 OutTextXY(500,210,'Estado inv†lido');
                 OutTextXY(500,230,'Estados permitidos entre "A" e "H"');
                 OutTextXY(500,250,'Pressione Enter');
               END
              ELSE
                Ok:=TRUE;
            UNTIL Ok;
            Ok:=FALSE;
            REPEAT
              Tabela_Estados_Saidas[Esta,Entr]:=RStrU(380,365,0,1,Tabela_Estados_Saidas[Esta,Entr],'Saida  : ',Out,FALSE);
              Tabela_Estados_Saidas[Esta,Entr]:=RStrU(380,365,0,1,Tabela_Estados_Saidas[Esta,Entr],'Saida  : ',Out,TRUE);
              IF (Tabela_Estados_Saidas[Esta,Entr] <> '0') AND
                 (Tabela_Estados_Saidas[Esta,Entr] <> '1') AND
                 (Tabela_Estados_Saidas[Esta,Entr] <> '')  THEN
                BEGIN
                  SetColor(4);
                  SetTextJustify(1,1);
                  SetTextStyle(5,0,1);
                  OutTextXY(500,210,'Saida inv†lida');
                  OutTextXY(500,230,'Saidas permitidas : "0" ou "1"');
                  OutTextXY(500,250,'Pressione Enter');
                  REPEAT
                    Tecla:=ReadNewKey;
                  UNTIL Tecla=13;
                  SetColor(0);
                  OutTextXY(500,210,'Saida inv†lida');
                  OutTextXY(500,230,'Saidas permitidas : "0" ou "1"');
                  OutTextXY(500,250,'Pressione Enter');
                END
               ELSE
                 Ok:=TRUE;
            UNTIL Ok;
            SetColor(0);
            FOR Out:=0 TO 50 DO Line(349,325+Out,640,325+Out);
            SetTextStyle(8,0,1);
            SetTextJustify(1,1);
            Texto:=Tabela_Estados_Letras[Esta,Entr]+'/'+Tabela_Estados_Saidas[Esta,Entr];
            WriteSquareNumber(Number,11,Texto);
    END; { InsertSquareNumber }

{*****}
  FUNCTION Look(Estado:STRING):BOOLEAN;
   { Look for determinated estado }

    VAR
      EstNum:BYTE;
      A,B:INTEGER;

  PROCEDURE MakeLoop(Number:INTEGER);
   { Makes a loop }

    VAR
      A,B:INTEGER;
    BEGIN
      IF ((Tabela_Estados_Letras[Number,1]='') AND
          (Tabela_Estados_Letras[Number,2]='') AND
          (Tabela_Estados_Letras[Number,3]='') AND
          (Tabela_Estados_Letras[Number,4]='')) THEN
         BEGIN
           Look:=FALSE;
         END
        ELSE
         BEGIN
           Look:=TRUE;
           Exit;
         END;
       FOR A:=1 TO 8 DO
         BEGIN
           FOR B:=1 TO 4 DO
             BEGIN
               IF (Tabela_Estados_Letras[A,B]=Estado) THEN
                 BEGIN
                   Look:=TRUE;
                   Exit;
                 END
                ELSE
                  BEGIN
                    Look:=FALSE;
                  END;
             END;
         END;
    END; { MakeLoop }

    BEGIN
      Look:=FALSE;
      IF Estado='A' THEN EstNum:=1;
      IF Estado='B' THEN EstNum:=2;
      IF Estado='C' THEN EstNum:=3;
      IF Estado='D' THEN EstNum:=4;
      IF Estado='E' THEN EstNum:=5;
      IF Estado='F' THEN EstNum:=6;
      IF Estado='G' THEN EstNum:=7;
      IF Estado='H' THEN EstNum:=8;
      CASE EstNum OF
        1:BEGIN
            MakeLoop(1);
          END;
        2:BEGIN
            MakeLoop(2);
          END;
        3:BEGIN
            MakeLoop(3);
          END;
        4:BEGIN
            MakeLoop(4);
          END;
        5:BEGIN
            MakeLoop(5);
          END;
        6:BEGIN
            MakeLoop(6);
          END;
        7:BEGIN
            MakeLoop(7);
          END;
        8:BEGIN
            MakeLoop(8);
          END;
      END; { End case estnum }
    END;

{*****}
  FUNCTION VerifyTableForCaracteristicas:BOOLEAN;
   { This function verifies the array and turns TRUE if the table is }
   { correct. }

    LABEL
       1;

    VAR
      A,B,C,D:INTEGER;
      OK:BOOLEAN;


    BEGIN
      VerifyTableForCaracteristicas:=TRUE;
      IF ( (Tabela_Estados_Letras[1,1] = '') AND
           (Tabela_Estados_Letras[1,2] = '') AND
           (Tabela_Estados_Letras[1,3] = '') AND
           (Tabela_Estados_Letras[1,4] = '') AND
           (Tabela_Estados_Letras[2,1] = '') AND
           (Tabela_Estados_Letras[2,2] = '') AND
           (Tabela_Estados_Letras[2,3] = '') AND
           (Tabela_Estados_Letras[2,4] = '') AND
           (Tabela_Estados_Letras[3,1] = '') AND
           (Tabela_Estados_Letras[3,2] = '') AND
           (Tabela_Estados_Letras[3,3] = '') AND
           (Tabela_Estados_Letras[3,4] = '') AND
           (Tabela_Estados_Letras[4,1] = '') AND
           (Tabela_Estados_Letras[4,2] = '') AND
           (Tabela_Estados_Letras[4,3] = '') AND
           (Tabela_Estados_Letras[4,4] = '') AND
           (Tabela_Estados_Letras[5,1] = '') AND
           (Tabela_Estados_Letras[5,2] = '') AND
           (Tabela_Estados_Letras[5,3] = '') AND
           (Tabela_Estados_Letras[5,4] = '') AND
           (Tabela_Estados_Letras[6,1] = '') AND
           (Tabela_Estados_Letras[6,2] = '') AND
           (Tabela_Estados_Letras[6,3] = '') AND
           (Tabela_Estados_Letras[6,4] = '') AND
           (Tabela_Estados_Letras[7,1] = '') AND
           (Tabela_Estados_Letras[7,2] = '') AND
           (Tabela_Estados_Letras[7,3] = '') AND
           (Tabela_Estados_Letras[7,4] = '') AND
           (Tabela_Estados_Letras[8,1] = '') AND
           (Tabela_Estados_Letras[8,2] = '') AND
           (Tabela_Estados_Letras[8,3] = '') AND
           (Tabela_Estados_Letras[8,4] = '')) THEN
         BEGIN
           VerifyTableForCaracteristicas:=FALSE;
           Erro:='';
           Erro:='Tabela Vazia';
         END
        ELSE
         BEGIN
           TipoCircuito:='';
           FOR A:=1 TO 8 DO
             BEGIN
               FOR B:=1 TO 4 DO
                 BEGIN
                   FOR C:=1 TO 8 DO
                     BEGIN
                       FOR D:=1 TO 4 DO
                         BEGIN
                           IF ((A=C) AND (B=D)) THEN
                             BEGIN
                               { Isto aqui n∆o faz nada }
                             END
                            ELSE
                             IF ((Tabela_Estados_Letras[A,B]<>'') AND
                                 (Tabela_Estados_Letras[C,D]<>'')) THEN
                             BEGIN
                               IF ((Tabela_Estados_Letras[A,B]=Tabela_Estados_Letras[C,D]) AND
                                   (Tabela_Estados_Saidas[A,B]<>Tabela_Estados_Saidas[C,D])) THEN
                                 BEGIN
                                   TipoCircuito:='Circuito Sequencial de Mealy';
                                   Goto 1;
                                 END
                                ELSE
                                  TipoCircuito:='Circuito Sequencial de Moore';
                             END;
                         END;
                     END;
                 END;
             END;
             IF TipoCircuito='' THEN TipoCircuito:='Circuito Sequencial de Moore';
         END;
    1:
      StrLetras:='';
      StrNumeros:='';
      Estados:=0;
      IF Look('A') THEN
        BEGIN
          StrLetras:=StrLetras+'A';
          StrNumeros:=StrNumeros+'1';
          Estados:=Estados+1;
        END;
      IF Look('B') THEN
        BEGIN
          StrLetras:=StrLetras+'B';
          StrNumeros:=StrNumeros+'2';
          Estados:=Estados+1;
        END;
      IF Look('C') THEN
        BEGIN
          StrLetras:=StrLetras+'C';
          StrNumeros:=StrNumeros+'3';
          Estados:=Estados+1;
        END;
      IF Look('D') THEN
        BEGIN
          StrLetras:=StrLetras+'D';
          StrNumeros:=StrNumeros+'4';
          Estados:=Estados+1;
        END;
      IF Look('E') THEN
        BEGIN
          StrLetras:=StrLetras+'E';
          StrNumeros:=StrNumeros+'5';
          Estados:=Estados+1;
        END;
      IF Look('F') THEN
        BEGIN
          StrLetras:=StrLetras+'F';
          StrNumeros:=StrNumeros+'6';
          Estados:=Estados+1;
        END;
      IF Look('G') THEN
        BEGIN
          StrLetras:=StrLetras+'G';
          StrNumeros:=StrNumeros+'7';
          Estados:=Estados+1;
        END;
      IF Look('H') THEN
        BEGIN
          StrLetras:=StrLetras+'H';
          StrNumeros:=StrNumeros+'8';
          Estados:=Estados+1;
        END;
    END; { VerifyTableForCaracteristicas }

{*****}
  PROCEDURE DesignFirstScreen(Number:INTEGER;On:BOOLEAN);
   { This procedure will design the first appering screen }

    BEGIN
      ClearDevice;
      SetColor(15);
      Line(1,1,1,389);  { Init the table }
      Line(1,1,326,1);
      Line(326,1,326,389);
      Line(1,389,326,389);
      Line(1,1,110,85);
      Line(110,1,110,389);
      Line(1,85,326,85);
      Line(1,123,326,123);
      Line(1,161,326,161);
      Line(1,199,326,199);
      Line(1,237,326,237);
      Line(1,275,326,275);
      Line(1,313,326,313);
      Line(1,351,326,351);
      Line(164,1,164,389);
      Line(218,1,218,389);
      Line(272,1,272,389);
      Line(326,1,326,389); { End Table }
      SetColor(9);
      SetTextStyle(2,0,5);
      SetTextJustify(0,2);
      OutTextXY(37,7,'Entradas');
      SetTextStyle(2,1,5);
      OutTextXY(2,20,'Estado');
      SetTextStyle(2,0,5);
      OutTextXY(20,65,'Presente');
      SetTextJustify(1,0);
      OutTextXY(215,410,'Estado Futuro / Sa°da');
      SetColor(10);
      SetTextStyle(3,0,5);
      SetTextJustify(1,1);
      OutTextXY(58,97,'A');
      OutTextXY(58,134,'B');
      OutTextXY(58,173,'C');
      OutTextXY(58,212,'D');
      OutTextXY(58,249,'E');
      OutTextXY(58,286,'F');
      OutTextXY(58,323,'G');
      OutTextXY(58,360,'H');
      OutTextXY(145,42,'0');
      OutTextXY(195,42,'1');
      OutTextXY(245,42,'2');
      OutTextXY(300,42,'3');
      SetTextJustify(0,0);
      SetColor(12);
      SetTextStyle(7,0,1);
      OutTextXY(360,15,'F1 - ');
      OutTextXY(360,35,'F2 - ');
      OutTextXY(360,55,'F3 - ');
      OutTextXY(360,75,'F4 - ');
      OutTextXY(360,95,'ESC - ');
      SetTextJustify(1,0);
      SetTextStyle(7,0,1);
      SetColor(13);
      OutTextXY(520,15,'Tabela de Estados');
      SetColor(3);
      OutTextXY(520,35,'Diagrama de Estados');
      OutTextXY(520,55,'Tabelas Bin†rias');
      OutTextXY(520,75,'Circuito Electr¢nico');
      OutTextXY(520,95,'Sair do Programa');
      SetTextStyle(6,0,1);
      SetColor(6);
      OutTextXY(320,440,'Sequencial Systems  V1.0');
      OutTextXY(320,458,'Copyright (c) 1995-97');
      OutTextXY(320,475,'Bullion MultiSoft Company');
      SetColor(8);
      Line(1,418,639,418);
      Line(1,419,639,419);
      Line(1,420,639,420);
      Line(347,110,639,110);
      Line(347,111,639,111);
      Line(347,112,639,112);
      Line(346,1,346,419);
      Line(347,1,347,419);
      Line(348,1,348,419);
      Line(347,190,639,190);
      Line(347,191,639,191);
      Line(347,192,639,192);
      Line(347,290,639,290);
      Line(347,291,639,291);
      Line(347,292,639,292);
      SetColor(14);
      SetTextJustify(0,0);
      SetTextStyle(8,0,1);
      OutTextXY(365,140,'"Setas" Movimentam');
      OutTextXY(365,160,'"Enter" Introduz valor');
      OutTextXY(365,180,'"F9" Caracter°sticas');
      DesignSquareNumber(Number,On); { Designs first introducing square }
      WriteSquareNumber(1,11,Tabela_Estados_Letras[1,1]+'/'+Tabela_Estados_Saidas[1,1]);
      WriteSquareNumber(2,11,Tabela_Estados_Letras[1,2]+'/'+Tabela_Estados_Saidas[1,2]);
      WriteSquareNumber(3,11,Tabela_Estados_Letras[1,3]+'/'+Tabela_Estados_Saidas[1,3]);
      WriteSquareNumber(4,11,Tabela_Estados_Letras[1,4]+'/'+Tabela_Estados_Saidas[1,4]);
      WriteSquareNumber(5,11,Tabela_Estados_Letras[2,1]+'/'+Tabela_Estados_Saidas[2,1]);
      WriteSquareNumber(6,11,Tabela_Estados_Letras[2,2]+'/'+Tabela_Estados_Saidas[2,2]);
      WriteSquareNumber(7,11,Tabela_Estados_Letras[2,3]+'/'+Tabela_Estados_Saidas[2,3]);
      WriteSquareNumber(8,11,Tabela_Estados_Letras[2,4]+'/'+Tabela_Estados_Saidas[2,4]);
      WriteSquareNumber(9,11,Tabela_Estados_Letras[3,1]+'/'+Tabela_Estados_Saidas[3,1]);
      WriteSquareNumber(10,11,Tabela_Estados_Letras[3,2]+'/'+Tabela_Estados_Saidas[3,2]);
      WriteSquareNumber(11,11,Tabela_Estados_Letras[3,3]+'/'+Tabela_Estados_Saidas[3,3]);
      WriteSquareNumber(12,11,Tabela_Estados_Letras[3,4]+'/'+Tabela_Estados_Saidas[3,4]);
      WriteSquareNumber(13,11,Tabela_Estados_Letras[4,1]+'/'+Tabela_Estados_Saidas[4,1]);
      WriteSquareNumber(14,11,Tabela_Estados_Letras[4,2]+'/'+Tabela_Estados_Saidas[4,2]);
      WriteSquareNumber(15,11,Tabela_Estados_Letras[4,3]+'/'+Tabela_Estados_Saidas[4,3]);
      WriteSquareNumber(16,11,Tabela_Estados_Letras[4,4]+'/'+Tabela_Estados_Saidas[4,4]);
      WriteSquareNumber(17,11,Tabela_Estados_Letras[5,1]+'/'+Tabela_Estados_Saidas[5,1]);
      WriteSquareNumber(18,11,Tabela_Estados_Letras[5,2]+'/'+Tabela_Estados_Saidas[5,2]);
      WriteSquareNumber(19,11,Tabela_Estados_Letras[5,3]+'/'+Tabela_Estados_Saidas[5,3]);
      WriteSquareNumber(20,11,Tabela_Estados_Letras[5,4]+'/'+Tabela_Estados_Saidas[5,4]);
      WriteSquareNumber(21,11,Tabela_Estados_Letras[6,1]+'/'+Tabela_Estados_Saidas[6,1]);
      WriteSquareNumber(22,11,Tabela_Estados_Letras[6,2]+'/'+Tabela_Estados_Saidas[6,2]);
      WriteSquareNumber(23,11,Tabela_Estados_Letras[6,3]+'/'+Tabela_Estados_Saidas[6,3]);
      WriteSquareNumber(24,11,Tabela_Estados_Letras[6,4]+'/'+Tabela_Estados_Saidas[6,4]);
      WriteSquareNumber(25,11,Tabela_Estados_Letras[7,1]+'/'+Tabela_Estados_Saidas[7,1]);
      WriteSquareNumber(26,11,Tabela_Estados_Letras[7,2]+'/'+Tabela_Estados_Saidas[7,2]);
      WriteSquareNumber(27,11,Tabela_Estados_Letras[7,3]+'/'+Tabela_Estados_Saidas[7,3]);
      WriteSquareNumber(28,11,Tabela_Estados_Letras[7,4]+'/'+Tabela_Estados_Saidas[7,4]);
      WriteSquareNumber(29,11,Tabela_Estados_Letras[8,1]+'/'+Tabela_Estados_Saidas[8,1]);
      WriteSquareNumber(30,11,Tabela_Estados_Letras[8,2]+'/'+Tabela_Estados_Saidas[8,2]);
      WriteSquareNumber(31,11,Tabela_Estados_Letras[8,3]+'/'+Tabela_Estados_Saidas[8,3]);
      WriteSquareNumber(32,11,Tabela_Estados_Letras[8,4]+'/'+Tabela_Estados_Saidas[8,4]);
    END; { DesignFirstScreen }

{*****}
  PROCEDURE DesignCaracteristicasScreen;
   { This procedure will design the caracteristicas screen }

    VAR
       Out:STRING;

    BEGIN
      ClearDevice;
      SetTextJustify(1,0);
      SetTextStyle(6,0,1);
      SetColor(6);
      OutTextXY(320,440,'Sequencial Systems  V1.0');
      OutTextXY(320,458,'Copyright (c) 1995-97');
      OutTextXY(320,475,'Bullion MultiSoft Company');
      SetColor(8);
      Line(1,418,639,418);
      Line(1,419,639,419);
      Line(1,420,639,420);
      Line(347,110,639,110);
      Line(347,111,639,111);
      Line(347,112,639,112);
      Line(346,1,346,419);
      Line(347,1,347,419);
      Line(348,1,348,419);
      Line(347,190,639,190);
      Line(347,191,639,191);
      Line(347,192,639,192);
      Line(347,290,639,290);
      Line(347,291,639,291);
      Line(347,292,639,292);
      SetColor(14);
      SetTextJustify(0,0);
      SetTextStyle(8,0,1);
      OutTextXY(365,140,'"1,2,3,4" Hip¢teses');
      OutTextXY(365,160,'"F9" Tabela de Estados');
      SetTextJustify(0,0);
      SetColor(5);
      SetTextStyle(8,0,1);
      OutTextXY(20,55,'Tipo de Circuito :');
      OutTextXY(20,135,'N£mero de Estados :');
      OutTextXY(20,215,'N£mero de Biest†veis :');
      OutTextXY(20,295,'Tipo de Biest†veis a Usar :');
      IF VerifyTableForCaracteristicas THEN
        BEGIN
          SetColor(14);
          SetTextStyle(6,0,1);
          OutTextXY(60,95,TipoCircuito);
          STR(Estados,Out);
          OutTextXY(60,175,Out);
          IF ( Estados >= 1) AND ( Estados <= 2) THEN OutTextXY(60,255,'1 Biest†vel');
          IF ( Estados >  2) AND ( Estados <= 4) THEN OutTextXY(60,255,'2 Biest†veis');
          IF ( Estados >  4) AND ( Estados <= 8) THEN OutTextXY(60,255,'3 Biest†veis');
        END
       ELSE
        BEGIN
          SetColor(4);
          SetTextStyle(6,0,1);
          OutTextXY(80,80,'Indetect†vel !!!');
          OutTextXY(60,100,'Erro : "'+Erro+'"');
          OutTextXY(80,160,'Indetect†vel !!!');
          OutTextXY(60,180,'Erro : "'+Erro+'"');
          OutTextXY(80,240,'Indetect†vel !!!');
          OutTextXY(60,260,'Erro : "'+Erro+'"');
        END;
      SetColor(8);
      SetTextStyle(6,0,1);
      OutTextXY(40,325,'1 - ');
      OutTextXY(40,345,'2 - ');
      OutTextXY(40,365,'3 - ');
      OutTextXY(40,385,'4 - ');
      SetColor(7);
      SetTextStyle(6,0,1);
      OutTextXY(80,325,'JK');
      OutTextXY(80,345,'SR');
      OutTextXY(80,365,'D');
      OutTextXY(80,385,'T');
      CASE Biestavel OF
        1:BEGIN
            SetColor(14);
            SetTextStyle(6,0,1);
            OutTextXY(80,325,'JK');
          END;
        2:BEGIN
            SetColor(14);
            SetTextStyle(6,0,1);
            OutTextXY(80,345,'SR');
          END;
        3:BEGIN
            SetColor(14);
            SetTextStyle(6,0,1);
            OutTextXY(80,365,'D');
          END;
        4:BEGIN
            SetColor(14);
            SetTextStyle(6,0,1);
            OutTextXY(80,385,'T');
          END;
      END; { End case biestavel }
    END; { DesignFirstScreen }
END.





