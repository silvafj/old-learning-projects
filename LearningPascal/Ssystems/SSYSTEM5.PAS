UNIT SSYSTEM5;

INTERFACE
 USES
    CRT,GRAPH,SSYSTEM1,SSYSTEM2,SSYSTEM3,SSYSTEM4;

  FUNCTION Let2Bin(Valor:STRING):STRING;
  FUNCTION Tabelas_Let2Bin:BOOLEAN;
  FUNCTION VerifyTableForTabelas:BOOLEAN;
  PROCEDURE MakeSimplifTables;
  FUNCTION GiveInExpression(Tabela:BYTE):STRING;
  PROCEDURE DesignTabelasScreen;
  PROCEDURE DesignTabelasScreen2;
  PROCEDURE DesignTabelasScreen3;
  PROCEDURE DesignTabelasScreen4;

IMPLEMENTATION

{*****}
  FUNCTION Let2Bin(Valor:STRING):STRING;
   { Transformes a letra in a bin rio }

    BEGIN
      Let2Bin:='';
      IF (Estados > 0) AND (Estados <= 4) THEN
        BEGIN
          IF Valor='A' THEN Let2Bin:='00';
          IF Valor='B' THEN Let2Bin:='01';
          IF Valor='C' THEN Let2Bin:='11';
          IF Valor='D' THEN Let2Bin:='10';
          IF Valor='' THEN Let2Bin:='--';
        END;
      IF (Estados > 4) AND (Estados <= 8) THEN
        BEGIN
          IF Valor='A' THEN Let2Bin:='000';
          IF Valor='B' THEN Let2Bin:='001';
          IF Valor='C' THEN Let2Bin:='010';
          IF Valor='D' THEN Let2Bin:='011';
          IF Valor='E' THEN Let2Bin:='110';
          IF Valor='F' THEN Let2Bin:='111';
          IF Valor='G' THEN Let2Bin:='100';
          IF Valor='H' THEN Let2Bin:='101';
          IF Valor='' THEN Let2Bin:='---';
        END;
    END; { Let2Bin }

{*****}
  FUNCTION Tabelas_Let2Bin:BOOLEAN;
   { Transformes tabela_letras in tabela_bin ria }

    VAR
       A,B:INTEGER;

    BEGIN
      Tabelas_Let2Bin:=TRUE;
      IF (Estados > 0) AND (Estados <= 4) THEN
        BEGIN
          FOR A:=1 TO 4 DO
            BEGIN
              FOR B:=1 TO 4 DO
                BEGIN
                  Tabela_Estados_Bin4[A,B]:='';
                END;
            END;
          IF ((Estados=4) AND ((Tabela_Estados_Letras[5,1]<>'') OR (Tabela_Estados_Letras[5,2]<>'') OR
              (Tabela_Estados_Letras[5,3]<>'') OR (Tabela_Estados_Letras[5,4]<>''))) THEN Tabelas_Let2Bin:=FALSE;
          IF ((Estados=3) AND ((Tabela_Estados_Letras[6,1]<>'') OR (Tabela_Estados_Letras[6,2]<>'') OR
              (Tabela_Estados_Letras[6,3]<>'') OR (Tabela_Estados_Letras[6,4]<>''))) THEN Tabelas_Let2Bin:=FALSE;
          IF ((Estados=2) AND ((Tabela_Estados_Letras[7,1]<>'') OR (Tabela_Estados_Letras[7,2]<>'') OR
              (Tabela_Estados_Letras[7,3]<>'') OR (Tabela_Estados_Letras[7,4]<>''))) THEN Tabelas_Let2Bin:=FALSE;
          IF ((Estados=1) AND ((Tabela_Estados_Letras[8,1]<>'') OR (Tabela_Estados_Letras[8,2]<>'') OR
              (Tabela_Estados_Letras[8,3]<>'') OR (Tabela_Estados_Letras[8,4]<>''))) THEN Tabelas_Let2Bin:=FALSE;
          FOR A:=1 TO 4 DO
            BEGIN
              FOR B:=1 TO 4 DO
                BEGIN
                  Tabela_Estados_Bin4[A,B]:=Let2Bin(Tabela_Estados_Letras[A,B]);
                END;
            END;
        END;
      IF (Estados > 4) AND (Estados <= 8) THEN
        BEGIN
          FOR A:=1 TO 4 DO
            BEGIN
              FOR B:=1 TO 4 DO
                BEGIN
                  Tabela_Estados_Bin8[A,B]:='';
                END;
            END;
          IF (((Tabela_Estados_Letras[5,1]<>'') OR (Tabela_Estados_Letras[5,2]<>'') OR
               (Tabela_Estados_Letras[6,1]<>'') OR (Tabela_Estados_Letras[6,2]<>'') OR
               (Tabela_Estados_Letras[7,1]<>'') OR (Tabela_Estados_Letras[7,2]<>'') OR
               (Tabela_Estados_Letras[8,1]<>'') OR (Tabela_Estados_Letras[8,2]<>'')) AND
              ((Tabela_Estados_Letras[1,3]<>'') OR (Tabela_Estados_Letras[1,4]<>'') OR
               (Tabela_Estados_Letras[2,3]<>'') OR (Tabela_Estados_Letras[2,4]<>'') OR
               (Tabela_Estados_Letras[3,3]<>'') OR (Tabela_Estados_Letras[3,4]<>'') OR
               (Tabela_Estados_Letras[4,3]<>'') OR (Tabela_Estados_Letras[4,4]<>''))) THEN Tabelas_Let2Bin:=FALSE;
           Tabela_Estados_Bin8[1,1]:=Let2Bin(Tabela_Estados_Letras[1,1]);
           Tabela_Estados_Bin8[1,2]:=Let2Bin(Tabela_Estados_Letras[1,2]);
           Tabela_Estados_Bin8[1,3]:=Let2Bin(Tabela_Estados_Letras[2,2]);
           Tabela_Estados_Bin8[1,4]:=Let2Bin(Tabela_Estados_Letras[2,1]);
           Tabela_Estados_Bin8[2,1]:=Let2Bin(Tabela_Estados_Letras[3,1]);
           Tabela_Estados_Bin8[2,2]:=Let2Bin(Tabela_Estados_Letras[3,2]);
           Tabela_Estados_Bin8[2,3]:=Let2Bin(Tabela_Estados_Letras[4,2]);
           Tabela_Estados_Bin8[2,4]:=Let2Bin(Tabela_Estados_Letras[4,1]);
           Tabela_Estados_Bin8[3,1]:=Let2Bin(Tabela_Estados_Letras[5,1]);
           Tabela_Estados_Bin8[3,2]:=Let2Bin(Tabela_Estados_Letras[5,2]);
           Tabela_Estados_Bin8[3,3]:=Let2Bin(Tabela_Estados_Letras[6,2]);
           Tabela_Estados_Bin8[3,4]:=Let2Bin(Tabela_Estados_Letras[6,1]);
           Tabela_Estados_Bin8[4,1]:=Let2Bin(Tabela_Estados_Letras[7,1]);
           Tabela_Estados_Bin8[4,2]:=Let2Bin(Tabela_Estados_Letras[7,2]);
           Tabela_Estados_Bin8[4,3]:=Let2Bin(Tabela_Estados_Letras[8,2]);
           Tabela_Estados_Bin8[4,4]:=Let2Bin(Tabela_Estados_Letras[8,1]);
        END;
    END; { Tabelas_Let2Bin }

{*****}
  FUNCTION VerifyTableForTabelas:BOOLEAN;
   { Verifies the table for tabelas }

    BEGIN
      VerifyTableForTabelas:=TRUE;
      Erro:='';
      IF NOT VerifyTableForCaracteristicas THEN
        BEGIN
          Erro:='Tabela Vazia';
          VerifyTableForTabelas:=FALSE;
          Exit;
        END;
      IF NOT Tabelas_Let2Bin THEN
        BEGIN
          Erro:='Tabela Inv lida';
          VerifyTableForTabelas:=FALSE;
          Exit;
        END;
    END; { VerifyTableForTabelas }

{*****}
  PROCEDURE MakeSimplifTables;
   { This procedure makes the corresponding simplify tables for }
   { the main table  }

      VAR
        Strin:STRING;

    FUNCTION GiveSimplifValores(Valor:STRING):STRING;
     { Returns the valor correspondente }

      BEGIN
        IF Biestavel=1 THEN   { JK }
          BEGIN
            IF Valor='00' THEN GiveSimplifValores:='0X';
            IF Valor='01' THEN GiveSimplifValores:='1X';
            IF Valor='11' THEN GiveSimplifValores:='X0';
            IF Valor='10' THEN GiveSimplifValores:='X1';
            IF Valor[2]='-' THEN GiveSimplifValores:=Valor[2];
          END;
        IF Biestavel=2 THEN  { SR }
          BEGIN
            IF Valor='00' THEN GiveSimplifValores:='0X';
            IF Valor='01' THEN GiveSimplifValores:='10';
            IF Valor='11' THEN GiveSimplifValores:='X0';
            IF Valor='10' THEN GiveSimplifValores:='01';
            IF Valor[2]='-' THEN GiveSimplifValores:=Valor[2];
          END;
        IF Biestavel=3 THEN { D }
          BEGIN
            GiveSimplifValores:=Valor[2];
          END;
        IF Biestavel=4 THEN { T }
          BEGIN
            IF Valor[1]=Valor[2] THEN GiveSimplifValores:='0';
            IF Valor[1]<>Valor[2] THEN GiveSimplifValores:='1';
            IF Valor[2]='-' THEN GiveSimplifValores:=Valor[2];
          END;
      END; { GiveSimplifValores }

    BEGIN
      FOR A:=1 TO 4 DO   { Set an empty table of Binario1 }
        BEGIN
          FOR B:=1 TO 4 DO
            BEGIN
              Tabela_Simplif_Bin1[A,B]:='';
            END;
        END;
      FOR A:=1 TO 4 DO   { Set an empty table of Binario2 }
        BEGIN
          FOR B:=1 TO 4 DO
            BEGIN
              Tabela_Simplif_Bin2[A,B]:='';
            END;
        END;
      FOR A:=1 TO 4 DO   { Set an empty table of Binario3 }
        BEGIN
          FOR B:=1 TO 4 DO
            BEGIN
              Tabela_Simplif_Bin3[A,B]:='';
            END;
        END;
      FOR A:=1 TO 4 DO   { Set an empty table of Binario4 }
        BEGIN
          FOR B:=1 TO 4 DO
            BEGIN
              Tabela_Simplif_Bin4[A,B]:='';
            END;
        END;
      FOR A:=1 TO 4 DO   { Set an empty table of Binario5 }
        BEGIN
          FOR B:=1 TO 4 DO
            BEGIN
              Tabela_Simplif_Bin5[A,B]:='';
            END;
        END;
      FOR A:=1 TO 4 DO   { Set an empty table of Binario6 }
        BEGIN
          FOR B:=1 TO 4 DO
            BEGIN
              Tabela_Simplif_Bin6[A,B]:='';
            END;
        END;
      IF (Estados > 0) AND (Estados <= 4) THEN
        BEGIN
          IF (Biestavel=3) OR (Biestavel=4) THEN  { D ou T }
            BEGIN
              FOR A:=1 TO 4 DO
                BEGIN
                  Tabela_Simplif_Bin1[1,A]:=GiveSimplifValores('0'+Tabela_Estados_Bin4[1,A][1]);
                  Tabela_Simplif_Bin1[2,A]:=GiveSimplifValores('0'+Tabela_Estados_Bin4[2,A][1]);
                  Tabela_Simplif_Bin1[3,A]:=GiveSimplifValores('1'+Tabela_Estados_Bin4[3,A][1]);
                  Tabela_Simplif_Bin1[4,A]:=GiveSimplifValores('1'+Tabela_Estados_Bin4[4,A][1]);
                  Tabela_Simplif_Bin2[1,A]:=GiveSimplifValores('0'+Tabela_Estados_Bin4[1,A][2]);
                  Tabela_Simplif_Bin2[2,A]:=GiveSimplifValores('1'+Tabela_Estados_Bin4[2,A][2]);
                  Tabela_Simplif_Bin2[3,A]:=GiveSimplifValores('1'+Tabela_Estados_Bin4[3,A][2]);
                  Tabela_Simplif_Bin2[4,A]:=GiveSimplifValores('0'+Tabela_Estados_Bin4[4,A][2]);
                END;
            END;
          IF (Biestavel=1) OR (Biestavel=2) THEN  { JK ou SR }
            BEGIN
              FOR A:=1 TO 4 DO
                BEGIN
                  Strin:=GiveSimplifValores('0'+Tabela_Estados_Bin4[1,A][1]);
                  Tabela_Simplif_Bin1[1,A]:=Strin[1];
                  Tabela_Simplif_Bin2[1,A]:=Strin[2];
                  Strin:=GiveSimplifValores('0'+Tabela_Estados_Bin4[2,A][1]);
                  Tabela_Simplif_Bin1[2,A]:=Strin[1];
                  Tabela_Simplif_Bin2[2,A]:=Strin[2];
                  Strin:=GiveSimplifValores('1'+Tabela_Estados_Bin4[3,A][1]);
                  Tabela_Simplif_Bin1[3,A]:=Strin[1];
                  Tabela_Simplif_Bin2[3,A]:=Strin[2];
                  Strin:=GiveSimplifValores('1'+Tabela_Estados_Bin4[4,A][1]);
                  Tabela_Simplif_Bin1[4,A]:=Strin[1];
                  Tabela_Simplif_Bin2[4,A]:=Strin[2];
                  Strin:=GiveSimplifValores('0'+Tabela_Estados_Bin4[1,A][2]);
                  Tabela_Simplif_Bin3[1,A]:=Strin[1];
                  Tabela_Simplif_Bin4[1,A]:=Strin[2];
                  Strin:=GiveSimplifValores('1'+Tabela_Estados_Bin4[2,A][2]);
                  Tabela_Simplif_Bin3[2,A]:=Strin[1];
                  Tabela_Simplif_Bin4[2,A]:=Strin[2];
                  Strin:=GiveSimplifValores('1'+Tabela_Estados_Bin4[3,A][2]);
                  Tabela_Simplif_Bin3[3,A]:=Strin[1];
                  Tabela_Simplif_Bin4[3,A]:=Strin[2];
                  Strin:=GiveSimplifValores('0'+Tabela_Estados_Bin4[4,A][2]);
                  Tabela_Simplif_Bin3[4,A]:=Strin[1];
                  Tabela_Simplif_Bin4[4,A]:=Strin[2];
                END;
            END;
        END;
      IF (Estados > 4) AND (Estados <= 8) THEN
        BEGIN
          IF (Biestavel=3) OR (Biestavel=4) THEN  { D ou T }
            BEGIN
              FOR A:=1 TO 4 DO
                BEGIN
                  Tabela_Simplif_Bin1[1,A]:=GiveSimplifValores('0'+Tabela_Estados_Bin8[1,A][1]);
                  Tabela_Simplif_Bin1[2,A]:=GiveSimplifValores('0'+Tabela_Estados_Bin8[2,A][1]);
                  Tabela_Simplif_Bin1[3,A]:=GiveSimplifValores('1'+Tabela_Estados_Bin8[3,A][1]);
                  Tabela_Simplif_Bin1[4,A]:=GiveSimplifValores('1'+Tabela_Estados_Bin8[4,A][1]);
                  Tabela_Simplif_Bin2[1,A]:=GiveSimplifValores('0'+Tabela_Estados_Bin8[1,A][2]);
                  Tabela_Simplif_Bin2[2,A]:=GiveSimplifValores('1'+Tabela_Estados_Bin8[2,A][2]);
                  Tabela_Simplif_Bin2[3,A]:=GiveSimplifValores('1'+Tabela_Estados_Bin8[3,A][2]);
                  Tabela_Simplif_Bin2[4,A]:=GiveSimplifValores('0'+Tabela_Estados_Bin8[4,A][2]);
                  Tabela_Simplif_Bin3[A,1]:=GiveSimplifValores('0'+Tabela_Estados_Bin8[A,1][3]);
                  Tabela_Simplif_Bin3[A,2]:=GiveSimplifValores('0'+Tabela_Estados_Bin8[A,2][3]);
                  Tabela_Simplif_Bin3[A,3]:=GiveSimplifValores('1'+Tabela_Estados_Bin8[A,3][3]);
                  Tabela_Simplif_Bin3[A,4]:=GiveSimplifValores('1'+Tabela_Estados_Bin8[A,4][3]);
                END;
            END;
          IF (Biestavel=1) OR (Biestavel=2) THEN  { JK ou SR }
            BEGIN
              FOR A:=1 TO 4 DO
                BEGIN
                  Strin:=GiveSimplifValores('0'+Tabela_Estados_Bin8[1,A][1]);
                  Tabela_Simplif_Bin1[1,A]:=Strin[1];
                  Tabela_Simplif_Bin2[1,A]:=Strin[2];
                  Strin:=GiveSimplifValores('0'+Tabela_Estados_Bin8[2,A][1]);
                  Tabela_Simplif_Bin1[2,A]:=Strin[1];
                  Tabela_Simplif_Bin2[2,A]:=Strin[2];
                  Strin:=GiveSimplifValores('1'+Tabela_Estados_Bin8[3,A][1]);
                  Tabela_Simplif_Bin1[3,A]:=Strin[1];
                  Tabela_Simplif_Bin2[3,A]:=Strin[2];
                  Strin:=GiveSimplifValores('1'+Tabela_Estados_Bin8[4,A][1]);
                  Tabela_Simplif_Bin1[4,A]:=Strin[1];
                  Tabela_Simplif_Bin2[4,A]:=Strin[2];
                  Strin:=GiveSimplifValores('0'+Tabela_Estados_Bin8[1,A][2]);
                  Tabela_Simplif_Bin3[1,A]:=Strin[1];
                  Tabela_Simplif_Bin4[1,A]:=Strin[2];
                  Strin:=GiveSimplifValores('1'+Tabela_Estados_Bin8[2,A][2]);
                  Tabela_Simplif_Bin3[2,A]:=Strin[1];
                  Tabela_Simplif_Bin4[2,A]:=Strin[2];
                  Strin:=GiveSimplifValores('1'+Tabela_Estados_Bin8[3,A][2]);
                  Tabela_Simplif_Bin3[3,A]:=Strin[1];
                  Tabela_Simplif_Bin4[3,A]:=Strin[2];
                  Strin:=GiveSimplifValores('0'+Tabela_Estados_Bin8[4,A][2]);
                  Tabela_Simplif_Bin3[4,A]:=Strin[1];
                  Tabela_Simplif_Bin4[4,A]:=Strin[2];
                  Strin:=GiveSimplifValores('0'+Tabela_Estados_Bin8[A,1][3]);
                  Tabela_Simplif_Bin5[A,1]:=Strin[1];
                  Tabela_Simplif_Bin6[A,1]:=Strin[2];
                  Strin:=GiveSimplifValores('0'+Tabela_Estados_Bin8[A,2][3]);
                  Tabela_Simplif_Bin5[A,2]:=Strin[1];
                  Tabela_Simplif_Bin6[A,2]:=Strin[2];
                  Strin:=GiveSimplifValores('1'+Tabela_Estados_Bin8[A,3][3]);
                  Tabela_Simplif_Bin5[A,3]:=Strin[1];
                  Tabela_Simplif_Bin6[A,3]:=Strin[2];
                  Strin:=GiveSimplifValores('1'+Tabela_Estados_Bin8[A,4][3]);
                  Tabela_Simplif_Bin5[A,4]:=Strin[1];
                  Tabela_Simplif_Bin6[A,4]:=Strin[2];
                END;
            END;
        END;
    END; { MakeSimplifTables }

{*****}
  FUNCTION GiveInExpression(Tabela:BYTE):STRING;
   { Returns a string expresion of the tabela asked }

    FUNCTION Esta(Number1,Number2:INTEGER;Valor:STRING):BOOLEAN;
     { Returns TRUE if Valor is found }

      BEGIN
        Esta:=FALSE;
        CASE Tabela OF
          1:BEGIN
              IF Tabela_Simplif_Bin1[Number1,Number2]=Valor THEN Esta:=TRUE;
            END;
          2:BEGIN
              IF Tabela_Simplif_Bin2[Number1,Number2]=Valor THEN Esta:=TRUE;
            END;
          3:BEGIN
              IF Tabela_Simplif_Bin3[Number1,Number2]=Valor THEN Esta:=TRUE;
            END;
          4:BEGIN
              IF Tabela_Simplif_Bin4[Number1,Number2]=Valor THEN Esta:=TRUE;
            END;
          5:BEGIN
              IF Tabela_Simplif_Bin5[Number1,Number2]=Valor THEN Esta:=TRUE;
            END;
          6:BEGIN
              IF Tabela_Simplif_Bin6[Number1,Number2]=Valor THEN Esta:=TRUE;
            END;
        END; { Case Tabela }
      END; { Esta }

    FUNCTION NaoEsta(Number1,Number2:INTEGER;Valor:STRING):BOOLEAN;
     { Returns TRUE if Valor is not found }

      BEGIN
        NaoEsta:=FALSE;
        CASE Tabela OF
          1:BEGIN
              IF Tabela_Simplif_Bin1[Number1,Number2]<>Valor THEN NaoEsta:=TRUE;
            END;
          2:BEGIN
              IF Tabela_Simplif_Bin2[Number1,Number2]<>Valor THEN NaoEsta:=TRUE;
            END;
          3:BEGIN
              IF Tabela_Simplif_Bin3[Number1,Number2]<>Valor THEN NaoEsta:=TRUE;
            END;
          4:BEGIN
              IF Tabela_Simplif_Bin4[Number1,Number2]<>Valor THEN NaoEsta:=TRUE;
            END;
          5:BEGIN
              IF Tabela_Simplif_Bin5[Number1,Number2]<>Valor THEN NaoEsta:=TRUE;
            END;
          6:BEGIN
              IF Tabela_Simplif_Bin6[Number1,Number2]<>Valor THEN NaoEsta:=TRUE;
            END;
        END; { Case Tabela }
      END; { NaoEsta }

    BEGIN
      IF (Estados > 0) AND ( Estados <= 4 ) THEN
        BEGIN
          IF Biestavel = 4  THEN { T }
            BEGIN
              IF Esta(1,1,'1') AND Esta(1,2,'1') AND Esta(1,3,'1') AND Esta(1,4,'1') AND
                 Esta(2,1,'1') AND Esta(2,2,'1') AND Esta(2,3,'1') AND Esta(2,4,'1') AND
                 Esta(3,1,'1') AND Esta(3,2,'1') AND Esta(3,3,'1') AND Esta(3,4,'1') AND
                 Esta(4,1,'1') AND Esta(4,2,'1') AND Esta(4,3,'1') AND Esta(4,4,'1') THEN
                BEGIN
                  IF Tabela=1 THEN GiveInExpression:='T1:=1';
                  IF Tabela=2 THEN GiveInExpression:='T0:=1';
                END;
            END;
        END;
    END; { GiveInExpression }

{*****}
  PROCEDURE DesignTabelasScreen;
   { This procedure will design the tabelas screen }

    BEGIN
      Ecra:=1;
      ClearDevice;
      SetColor(8);
      Line(1,418,639,418);
      Line(1,419,639,419);
      Line(1,420,639,420);
      Line(1,110,639,110);
      Line(1,111,639,111);
      Line(1,112,639,112);
      Line(319,1,319,110);
      Line(320,1,320,110);
      Line(321,1,321,110);
      SetColor(12);
      SetTextStyle(7,0,1);
      SetTextJustify(0,0);
      OutTextXY(10,15,'F1 - ');
      OutTextXY(10,35,'F2 - ');
      OutTextXY(10,55,'F3 - ');
      OutTextXY(10,75,'F4 - ');
      OutTextXY(10,95,'ESC - ');
      SetTextStyle(7,0,1);
      SetColor(13);
      OutTextXY(80,55,'Tabelas Bin rias');
      SetColor(3);
      OutTextXY(80,15,'Tabela de Estados');
      OutTextXY(80,35,'Diagrama de Estados');
      OutTextXY(80,75,'Circuito Electr¢nico');
      OutTextXY(80,95,'Sair do Programa');
      SetColor(14);
      SetTextJustify(0,0);
      SetTextStyle(8,0,1);
      OutTextXY(335,15,'"Seta Direita"  Seguinte');
      OutTextXY(335,40,'"Seta Esquerda" Anterior');
      SetTextStyle(6,0,1);
      SetTextJustify(1,0);
      SetColor(6);
      OutTextXY(320,440,'Sequencial Systems  V1.0');
      OutTextXY(320,458,'Copyright (c) 1995-97');
      OutTextXY(320,475,'Bullion MultiSoft Company');
      SetColor(7);
      SetTextStyle(5,0,3);
      OutTextXY(320,150,'Tabela de Estados');
      IF (Estados > 0) AND (Estados <= 4) THEN
        BEGIN
          EcraMax:=3;
          SetColor(15);
          Line(150,220,470,220);
          Line(150,265,470,265);
          Line(150,310,470,310);
          Line(150,355,470,355);
          Line(150,400,470,400);
          Line(250,170,250,400);
          Line(305,190,305,400);
          Line(360,190,360,400);
          Line(415,190,415,400);
          Line(470,190,470,400);
          SetColor(9);
          SetTextStyle(2,0,6);
          SetTextJustify(0,2);
          OutTextXY(160,195,'Q1n  Q0n');
          OutTextXY(345,170,'XY');
          SetColor(10);
          SetTextStyle(3,0,2);
          SetTextJustify(1,1);
          OutTextXY(280,200,'00');
          OutTextXY(330,200,'01');
          OutTextXY(385,200,'11');
          OutTextXY(440,200,'10');
          OutTextXY(200,240,'0  0');
          OutTextXY(200,280,'0  1');
          OutTextXY(200,325,'1  1');
          OutTextXY(200,370,'1  0');
          SetTextStyle(8,0,1);
          SetColor(11);
          Outtextxy(280,240,Tabela_Estados_Bin4[1,1]);
          Outtextxy(330,240,Tabela_Estados_Bin4[1,2]);
          Outtextxy(385,240,Tabela_Estados_Bin4[1,3]);
          Outtextxy(440,240,Tabela_Estados_Bin4[1,4]);
          Outtextxy(280,280,Tabela_Estados_Bin4[2,1]);
          Outtextxy(330,280,Tabela_Estados_Bin4[2,2]);
          Outtextxy(385,280,Tabela_Estados_Bin4[2,3]);
          Outtextxy(440,280,Tabela_Estados_Bin4[2,4]);
          Outtextxy(280,325,Tabela_Estados_Bin4[3,1]);
          Outtextxy(330,325,Tabela_Estados_Bin4[3,2]);
          Outtextxy(385,325,Tabela_Estados_Bin4[3,3]);
          Outtextxy(440,325,Tabela_Estados_Bin4[3,4]);
          Outtextxy(280,370,Tabela_Estados_Bin4[4,1]);
          Outtextxy(330,370,Tabela_Estados_Bin4[4,2]);
          Outtextxy(385,370,Tabela_Estados_Bin4[4,3]);
          Outtextxy(440,370,Tabela_Estados_Bin4[4,4]);
        END;
      IF (Estados > 4) AND (Estados <= 8) THEN
        BEGIN
          EcraMax:=4;
          SetColor(15);
          Line(150,220,470,220);
          Line(150,265,470,265);
          Line(150,310,470,310);
          Line(150,355,470,355);
          Line(150,400,470,400);
          Line(250,170,250,400);
          Line(305,190,305,400);
          Line(360,190,360,400);
          Line(415,190,415,400);
          Line(470,190,470,400);
          SetColor(9);
          SetTextStyle(2,0,6);
          SetTextJustify(0,2);
          OutTextXY(160,195,'Q2n  Q1n');
          OutTextXY(345,165,'Q0nX');
          SetColor(10);
          SetTextStyle(3,0,2);
          SetTextJustify(1,1);
          OutTextXY(280,200,'00');
          OutTextXY(330,200,'01');
          OutTextXY(385,200,'11');
          OutTextXY(440,200,'10');
          OutTextXY(200,240,'0  0');
          OutTextXY(200,280,'0  1');
          OutTextXY(200,325,'1  1');
          OutTextXY(200,370,'1  0');
          SetTextStyle(8,0,1);
          SetColor(11);
          SetTextStyle(3,0,2);
          SetTextJustify(1,1);
          Outtextxy(280,240,Tabela_Estados_Bin8[1,1]);
          Outtextxy(330,240,Tabela_Estados_Bin8[1,2]);
          Outtextxy(385,240,Tabela_Estados_Bin8[1,3]);
          Outtextxy(440,240,Tabela_Estados_Bin8[1,4]);
          Outtextxy(280,280,Tabela_Estados_Bin8[2,1]);
          Outtextxy(330,280,Tabela_Estados_Bin8[2,2]);
          Outtextxy(385,280,Tabela_Estados_Bin8[2,3]);
          Outtextxy(440,280,Tabela_Estados_Bin8[2,4]);
          Outtextxy(280,325,Tabela_Estados_Bin8[3,1]);
          Outtextxy(330,325,Tabela_Estados_Bin8[3,2]);
          Outtextxy(385,325,Tabela_Estados_Bin8[3,3]);
          Outtextxy(440,325,Tabela_Estados_Bin8[3,4]);
          Outtextxy(280,370,Tabela_Estados_Bin8[4,1]);
          Outtextxy(330,370,Tabela_Estados_Bin8[4,2]);
          Outtextxy(385,370,Tabela_Estados_Bin8[4,3]);
          Outtextxy(440,370,Tabela_Estados_Bin8[4,4]);
        END;
        MakeSimplifTables;
    END; { DesignTabelasScreen }

{*****}
  PROCEDURE DesignTabelasScreen2;
   { This procedure will design the tabelas screen number 2}

    BEGIN
      Ecra:=2;
      ClearDevice;
      SetColor(8);
      Line(1,418,639,418);
      Line(1,419,639,419);
      Line(1,420,639,420);
      Line(1,110,639,110);
      Line(1,111,639,111);
      Line(1,112,639,112);
      Line(319,1,319,110);
      Line(320,1,320,110);
      Line(321,1,321,110);
      SetColor(12);
      SetTextStyle(7,0,1);
      SetTextJustify(0,0);
      OutTextXY(10,15,'F1 - ');
      OutTextXY(10,35,'F2 - ');
      OutTextXY(10,55,'F3 - ');
      OutTextXY(10,75,'F4 - ');
      OutTextXY(10,95,'ESC - ');
      SetTextStyle(7,0,1);
      SetColor(13);
      OutTextXY(80,55,'Tabelas Bin rias');
      SetColor(3);
      OutTextXY(80,15,'Tabela de Estados');
      OutTextXY(80,35,'Diagrama de Estados');
      OutTextXY(80,75,'Circuito Electr¢nico');
      OutTextXY(80,95,'Sair do Programa');
      SetColor(14);
      SetTextJustify(0,0);
      SetTextStyle(8,0,1);
      OutTextXY(335,15,'"Seta Direita"  Seguinte');
      OutTextXY(335,40,'"Seta Esquerda" Anterior');
      SetTextStyle(6,0,1);
      SetTextJustify(1,0);
      SetColor(6);
      OutTextXY(320,440,'Sequencial Systems  V1.0');
      OutTextXY(320,458,'Copyright (c) 1995-97');
      OutTextXY(320,475,'Bullion MultiSoft Company');
      IF (Biestavel=3) OR (Biestavel=4) THEN
        BEGIN
          SetColor(15);
          Line(150,180,470,180);
          Line(150,225,470,225);
          Line(150,270,470,270);
          Line(150,315,470,315);
          Line(150,360,470,360);
          Line(250,140,250,360);
          Line(305,160,305,360);
          Line(360,160,360,360);
          Line(415,160,415,360);
          Line(470,160,470,360);
          SetColor(10);
          SetTextStyle(3,0,2);
          SetTextJustify(1,1);
          OutTextXY(280,160,'00');
          OutTextXY(330,160,'01');
          OutTextXY(385,160,'11');
          OutTextXY(440,160,'10');
          OutTextXY(200,200,'0  0');
          OutTextXY(200,240,'0  1');
          OutTextXY(200,285,'1  1');
          OutTextXY(200,330,'1  0');
          SetTextStyle(8,0,1);
          SetColor(11);
          IF (Estados > 0) AND (Estados <= 4) THEN
            BEGIN
              SetColor(9);
              SetTextStyle(2,0,6);
              SetTextJustify(0,2);
              OutTextXY(160,160,'Q1n  Q0n');
              OutTextXY(345,135,'XY');
            END;
          IF (Estados > 4) AND (Estados <= 8) THEN
            BEGIN
              SetColor(9);
              SetTextStyle(2,0,6);
              SetTextJustify(0,2);
              OutTextXY(160,160,'Q2n  Q1n');
              OutTextXY(345,135,'Q0nX');
              SetTextStyle(8,0,1);
              SetColor(11);
            END;
          SetColor(11);
          SetTextStyle(3,0,2);
          SetTextJustify(1,1);
          OutTextXY(280,200,Tabela_Simplif_Bin1[1,1]);
          OutTextXY(330,200,Tabela_Simplif_Bin1[1,2]);
          OutTextXY(385,200,Tabela_Simplif_Bin1[1,3]);
          OutTextXY(440,200,Tabela_Simplif_Bin1[1,4]);
          OutTextXY(280,240,Tabela_Simplif_Bin1[2,1]);
          OutTextXY(330,240,Tabela_Simplif_Bin1[2,2]);
          OutTextXY(385,240,Tabela_Simplif_Bin1[2,3]);
          OutTextXY(440,240,Tabela_Simplif_Bin1[2,4]);
          OutTextXY(280,285,Tabela_Simplif_Bin1[3,1]);
          OutTextXY(330,285,Tabela_Simplif_Bin1[3,2]);
          OutTextXY(385,285,Tabela_Simplif_Bin1[3,3]);
          OutTextXY(440,285,Tabela_Simplif_Bin1[3,4]);
          OutTextXY(280,330,Tabela_Simplif_Bin1[4,1]);
          OutTextXY(330,330,Tabela_Simplif_Bin1[4,2]);
          OutTextXY(385,330,Tabela_Simplif_Bin1[4,3]);
          OutTextXY(440,330,Tabela_Simplif_Bin1[4,4]);
          { OutTextXY(X,Y,GetInExpression(1)); }
          { DesignSimplifGroups( }
        END; { IF biestavel }
      IF (Biestavel=1) OR (Biestavel=2) THEN
        BEGIN
          SetColor(15);
          Line(40,180,280,180);
          Line(40,225,280,225);
          Line(40,270,280,270);
          Line(40,315,280,315);
          Line(40,360,280,360);
          Line(100,140,100,360);
          Line(145,160,145,360);
          Line(190,160,190,360);
          Line(235,160,235,360);
          Line(280,160,280,360);
          SetColor(10);
          SetTextStyle(3,0,1);
          SetTextJustify(1,1);
          OutTextXY(122,160,'00');
          OutTextXY(165,160,'01');
          OutTextXY(210,160,'11');
          OutTextXY(258,160,'10');
          OutTextXY(65,200,'0 0');
          OutTextXY(65,240,'0 1');
          OutTextXY(65,285,'1 1');
          OutTextXY(65,330,'1 0');
          SetColor(15);
          Line(340,180,580,180);
          Line(340,225,580,225);
          Line(340,270,580,270);
          Line(340,315,580,315);
          Line(340,360,580,360);
          Line(400,140,400,360);
          Line(445,160,445,360);
          Line(490,160,490,360);
          Line(535,160,535,360);
          Line(580,160,580,360);
          SetColor(10);
          SetTextStyle(3,0,1);
          SetTextJustify(1,1);
          OutTextXY(422,160,'00');
          OutTextXY(465,160,'01');
          OutTextXY(510,160,'11');
          OutTextXY(558,160,'10');
          OutTextXY(365,200,'0 0');
          OutTextXY(365,240,'0 1');
          OutTextXY(365,285,'1 1');
          OutTextXY(365,330,'1 0');
          IF (Estados > 0) AND (Estados <= 4) THEN
            BEGIN
              EcraMax:=3;
              SetColor(9);
              SetTextStyle(2,0,4);
              SetTextJustify(0,2);
              OutTextXY(45,160,'Q1n  Q0n');
              OutTextXY(190,130,'XY');
              OutTextXY(345,160,'Q1n  Q0n');
              OutTextXY(490,130,'XY');
            END;
          IF (Estados > 4) AND (Estados <= 8) THEN
            BEGIN
              EcraMax:=4;
              SetColor(9);
              SetTextStyle(2,0,4);
              SetTextJustify(0,2);
              OutTextXY(45,160,'Q2n  Q1n');
              OutTextXY(190,130,'Q0nX');
              OutTextXY(345,160,'Q2n  Q1n');
              OutTextXY(490,130,'Q0nX');
            END;
          SetColor(11);
          SetTextStyle(3,0,2);
          SetTextJustify(1,1);
          OutTextXY(122,200,Tabela_Simplif_Bin1[1,1]);
          OutTextXY(165,200,Tabela_Simplif_Bin1[1,2]);
          OutTextXY(210,200,Tabela_Simplif_Bin1[1,3]);
          OutTextXY(258,200,Tabela_Simplif_Bin1[1,4]);
          OutTextXY(122,240,Tabela_Simplif_Bin1[2,1]);
          OutTextXY(165,240,Tabela_Simplif_Bin1[2,2]);
          OutTextXY(210,240,Tabela_Simplif_Bin1[2,3]);
          OutTextXY(258,240,Tabela_Simplif_Bin1[2,4]);
          OutTextXY(122,285,Tabela_Simplif_Bin1[3,1]);
          OutTextXY(165,285,Tabela_Simplif_Bin1[3,2]);
          OutTextXY(210,285,Tabela_Simplif_Bin1[3,3]);
          OutTextXY(258,285,Tabela_Simplif_Bin1[3,4]);
          OutTextXY(122,330,Tabela_Simplif_Bin1[4,1]);
          OutTextXY(165,330,Tabela_Simplif_Bin1[4,2]);
          OutTextXY(210,330,Tabela_Simplif_Bin1[4,3]);
          OutTextXY(258,330,Tabela_Simplif_Bin1[4,4]);
          OutTextXY(422,200,Tabela_Simplif_Bin2[1,1]);
          OutTextXY(465,200,Tabela_Simplif_Bin2[1,2]);
          OutTextXY(510,200,Tabela_Simplif_Bin2[1,3]);
          OutTextXY(558,200,Tabela_Simplif_Bin2[1,4]);
          OutTextXY(422,240,Tabela_Simplif_Bin2[2,1]);
          OutTextXY(465,240,Tabela_Simplif_Bin2[2,2]);
          OutTextXY(510,240,Tabela_Simplif_Bin2[2,3]);
          OutTextXY(558,240,Tabela_Simplif_Bin2[2,4]);
          OutTextXY(422,285,Tabela_Simplif_Bin2[3,1]);
          OutTextXY(465,285,Tabela_Simplif_Bin2[3,2]);
          OutTextXY(510,285,Tabela_Simplif_Bin2[3,3]);
          OutTextXY(558,285,Tabela_Simplif_Bin2[3,4]);
          OutTextXY(422,330,Tabela_Simplif_Bin2[4,1]);
          OutTextXY(465,330,Tabela_Simplif_Bin2[4,2]);
          OutTextXY(510,330,Tabela_Simplif_Bin2[4,3]);
          OutTextXY(558,330,Tabela_Simplif_Bin2[4,4]);
            { OutTextXY(X,Y,GetInExpression(1)); }
            { OutTextXY(X,Y,GetInExpression(2)); }
            { DesignSimplifGroups() }
        END; { IF biestavel }
    END; { DesignTabelasScreen2 }

{*****}
  PROCEDURE DesignTabelasScreen3;
   { This procedure will design the tabelas screen number 3}

    BEGIN
      Ecra:=3;
      ClearDevice;
      SetColor(8);
      Line(1,418,639,418);
      Line(1,419,639,419);
      Line(1,420,639,420);
      Line(1,110,639,110);
      Line(1,111,639,111);
      Line(1,112,639,112);
      Line(319,1,319,110);
      Line(320,1,320,110);
      Line(321,1,321,110);
      SetColor(12);
      SetTextStyle(7,0,1);
      SetTextJustify(0,0);
      OutTextXY(10,15,'F1 - ');
      OutTextXY(10,35,'F2 - ');
      OutTextXY(10,55,'F3 - ');
      OutTextXY(10,75,'F4 - ');
      OutTextXY(10,95,'ESC - ');
      SetTextStyle(7,0,1);
      SetColor(13);
      OutTextXY(80,55,'Tabelas Bin rias');
      SetColor(3);
      OutTextXY(80,15,'Tabela de Estados');
      OutTextXY(80,35,'Diagrama de Estados');
      OutTextXY(80,75,'Circuito Electr¢nico');
      OutTextXY(80,95,'Sair do Programa');
      SetColor(14);
      SetTextJustify(0,0);
      SetTextStyle(8,0,1);
      OutTextXY(335,15,'"Seta Direita"  Seguinte');
      OutTextXY(335,40,'"Seta Esquerda" Anterior');
      SetTextStyle(6,0,1);
      SetTextJustify(1,0);
      SetColor(6);
      OutTextXY(320,440,'Sequencial Systems  V1.0');
      OutTextXY(320,458,'Copyright (c) 1995-97');
      OutTextXY(320,475,'Bullion MultiSoft Company');
      IF (Biestavel=3) OR (Biestavel=4) THEN
        BEGIN
          SetColor(15);
          Line(150,180,470,180);
          Line(150,225,470,225);
          Line(150,270,470,270);
          Line(150,315,470,315);
          Line(150,360,470,360);
          Line(250,140,250,360);
          Line(305,160,305,360);
          Line(360,160,360,360);
          Line(415,160,415,360);
          Line(470,160,470,360);
          SetColor(10);
          SetTextStyle(3,0,2);
          SetTextJustify(1,1);
          OutTextXY(280,160,'00');
          OutTextXY(330,160,'01');
          OutTextXY(385,160,'11');
          OutTextXY(440,160,'10');
          OutTextXY(200,200,'0  0');
          OutTextXY(200,240,'0  1');
          OutTextXY(200,285,'1  1');
          OutTextXY(200,330,'1  0');
          SetTextStyle(8,0,1);
          SetColor(11);
          IF (Estados > 0) AND (Estados <= 4) THEN
            BEGIN
              SetColor(9);
              SetTextStyle(2,0,6);
              SetTextJustify(0,2);
              OutTextXY(160,160,'Q1n  Q0n');
              OutTextXY(345,135,'XY');
            END;
          IF (Estados > 4) AND (Estados <= 8) THEN
            BEGIN
              SetColor(9);
              SetTextStyle(2,0,6);
              SetTextJustify(0,2);
              OutTextXY(160,160,'Q2n  Q1n');
              OutTextXY(345,135,'Q0nX');
              SetTextStyle(8,0,1);
              SetColor(11);
            END;
          SetColor(11);
          SetTextStyle(3,0,2);
          SetTextJustify(1,1);
          OutTextXY(280,200,Tabela_Simplif_Bin2[1,1]);
          OutTextXY(330,200,Tabela_Simplif_Bin2[1,2]);
          OutTextXY(385,200,Tabela_Simplif_Bin2[1,3]);
          OutTextXY(440,200,Tabela_Simplif_Bin2[1,4]);
          OutTextXY(280,240,Tabela_Simplif_Bin2[2,1]);
          OutTextXY(330,240,Tabela_Simplif_Bin2[2,2]);
          OutTextXY(385,240,Tabela_Simplif_Bin2[2,3]);
          OutTextXY(440,240,Tabela_Simplif_Bin2[2,4]);
          OutTextXY(280,285,Tabela_Simplif_Bin2[3,1]);
          OutTextXY(330,285,Tabela_Simplif_Bin2[3,2]);
          OutTextXY(385,285,Tabela_Simplif_Bin2[3,3]);
          OutTextXY(440,285,Tabela_Simplif_Bin2[3,4]);
          OutTextXY(280,330,Tabela_Simplif_Bin2[4,1]);
          OutTextXY(330,330,Tabela_Simplif_Bin2[4,2]);
          OutTextXY(385,330,Tabela_Simplif_Bin2[4,3]);
          OutTextXY(440,330,Tabela_Simplif_Bin2[4,4]);
            { OutTextXY(X,Y,GetInExpression(1)); }
            { DesignSimplifGroups( }
        END; { IF biestavel }
      IF (Biestavel=1) OR (Biestavel=2) THEN
        BEGIN
          SetColor(15);
          Line(40,180,280,180);
          Line(40,225,280,225);
          Line(40,270,280,270);
          Line(40,315,280,315);
          Line(40,360,280,360);
          Line(100,140,100,360);
          Line(145,160,145,360);
          Line(190,160,190,360);
          Line(235,160,235,360);
          Line(280,160,280,360);
          SetColor(10);
          SetTextStyle(3,0,1);
          SetTextJustify(1,1);
          OutTextXY(122,160,'00');
          OutTextXY(165,160,'01');
          OutTextXY(210,160,'11');
          OutTextXY(258,160,'10');
          OutTextXY(65,200,'0 0');
          OutTextXY(65,240,'0 1');
          OutTextXY(65,285,'1 1');
          OutTextXY(65,330,'1 0');
          SetColor(15);
          Line(340,180,580,180);
          Line(340,225,580,225);
          Line(340,270,580,270);
          Line(340,315,580,315);
          Line(340,360,580,360);
          Line(400,140,400,360);
          Line(445,160,445,360);
          Line(490,160,490,360);
          Line(535,160,535,360);
          Line(580,160,580,360);
          SetColor(10);
          SetTextStyle(3,0,1);
          SetTextJustify(1,1);
          OutTextXY(422,160,'00');
          OutTextXY(465,160,'01');
          OutTextXY(510,160,'11');
          OutTextXY(558,160,'10');
          OutTextXY(365,200,'0 0');
          OutTextXY(365,240,'0 1');
          OutTextXY(365,285,'1 1');
          OutTextXY(365,330,'1 0');
          IF (Estados > 0) AND (Estados <= 4) THEN
            BEGIN
              EcraMax:=3;
              SetColor(9);
              SetTextStyle(2,0,4);
              SetTextJustify(0,2);
              OutTextXY(45,160,'Q1n  Q0n');
              OutTextXY(190,130,'XY');
              OutTextXY(345,160,'Q1n  Q0n');
              OutTextXY(490,130,'XY');
            END;
          IF (Estados > 4) AND (Estados <= 8) THEN
            BEGIN
              EcraMax:=4;
              SetColor(9);
              SetTextStyle(2,0,6);
              SetTextJustify(0,2);
              OutTextXY(45,160,'Q2n  Q1n');
              OutTextXY(190,130,'Q0nX');
              OutTextXY(345,160,'Q2n  Q1n');
              OutTextXY(490,130,'Q0nX');
            END;
          SetColor(11);
          SetTextStyle(3,0,2);
          SetTextJustify(1,1);
          OutTextXY(122,200,Tabela_Simplif_Bin3[1,1]);
          OutTextXY(165,200,Tabela_Simplif_Bin3[1,2]);
          OutTextXY(210,200,Tabela_Simplif_Bin3[1,3]);
          OutTextXY(258,200,Tabela_Simplif_Bin3[1,4]);
          OutTextXY(122,240,Tabela_Simplif_Bin3[2,1]);
          OutTextXY(165,240,Tabela_Simplif_Bin3[2,2]);
          OutTextXY(210,240,Tabela_Simplif_Bin3[2,3]);
          OutTextXY(258,240,Tabela_Simplif_Bin3[2,4]);
          OutTextXY(122,285,Tabela_Simplif_Bin3[3,1]);
          OutTextXY(165,285,Tabela_Simplif_Bin3[3,2]);
          OutTextXY(210,285,Tabela_Simplif_Bin3[3,3]);
          OutTextXY(258,285,Tabela_Simplif_Bin3[3,4]);
          OutTextXY(122,330,Tabela_Simplif_Bin3[4,1]);
          OutTextXY(165,330,Tabela_Simplif_Bin3[4,2]);
          OutTextXY(210,330,Tabela_Simplif_Bin3[4,3]);
          OutTextXY(258,330,Tabela_Simplif_Bin3[4,4]);
          OutTextXY(422,200,Tabela_Simplif_Bin4[1,1]);
          OutTextXY(465,200,Tabela_Simplif_Bin4[1,2]);
          OutTextXY(510,200,Tabela_Simplif_Bin4[1,3]);
          OutTextXY(558,200,Tabela_Simplif_Bin4[1,4]);
          OutTextXY(422,240,Tabela_Simplif_Bin4[2,1]);
          OutTextXY(465,240,Tabela_Simplif_Bin4[2,2]);
          OutTextXY(510,240,Tabela_Simplif_Bin4[2,3]);
          OutTextXY(558,240,Tabela_Simplif_Bin4[2,4]);
          OutTextXY(422,285,Tabela_Simplif_Bin4[3,1]);
          OutTextXY(465,285,Tabela_Simplif_Bin4[3,2]);
          OutTextXY(510,285,Tabela_Simplif_Bin4[3,3]);
          OutTextXY(558,285,Tabela_Simplif_Bin4[3,4]);
          OutTextXY(422,330,Tabela_Simplif_Bin4[4,1]);
          OutTextXY(465,330,Tabela_Simplif_Bin4[4,2]);
          OutTextXY(510,330,Tabela_Simplif_Bin4[4,3]);
          OutTextXY(558,330,Tabela_Simplif_Bin4[4,4]);
            { OutTextXY(X,Y,GetInExpression(1)); }
            { OutTextXY(X,Y,GetInExpression(2)); }
            { DesignSimplifGroups() }
        END; { IF biestavel }
    END; { DesignTabelasScreen3 }

{*****}
  PROCEDURE DesignTabelasScreen4;
   { This procedure will design the tabelas screen number 4}

    BEGIN
      Ecra:=4;
      ClearDevice;
      SetColor(8);
      Line(1,418,639,418);
      Line(1,419,639,419);
      Line(1,420,639,420);
      Line(1,110,639,110);
      Line(1,111,639,111);
      Line(1,112,639,112);
      Line(319,1,319,110);
      Line(320,1,320,110);
      Line(321,1,321,110);
      SetColor(12);
      SetTextStyle(7,0,1);
      SetTextJustify(0,0);
      OutTextXY(10,15,'F1 - ');
      OutTextXY(10,35,'F2 - ');
      OutTextXY(10,55,'F3 - ');
      OutTextXY(10,75,'F4 - ');
      OutTextXY(10,95,'ESC - ');
      SetTextStyle(7,0,1);
      SetColor(13);
      OutTextXY(80,55,'Tabelas Bin rias');
      SetColor(3);
      OutTextXY(80,15,'Tabela de Estados');
      OutTextXY(80,35,'Diagrama de Estados');
      OutTextXY(80,75,'Circuito Electr¢nico');
      OutTextXY(80,95,'Sair do Programa');
      SetColor(14);
      SetTextJustify(0,0);
      SetTextStyle(8,0,1);
      OutTextXY(335,15,'"Seta Direita"  Seguinte');
      OutTextXY(335,40,'"Seta Esquerda" Anterior');
      SetTextStyle(6,0,1);
      SetTextJustify(1,0);
      SetColor(6);
      OutTextXY(320,440,'Sequencial Systems  V1.0');
      OutTextXY(320,458,'Copyright (c) 1995-97');
      OutTextXY(320,475,'Bullion MultiSoft Company');
      IF (Biestavel=3) OR (Biestavel=4) THEN
        BEGIN
          SetColor(15);
          Line(150,180,470,180);
          Line(150,225,470,225);
          Line(150,270,470,270);
          Line(150,315,470,315);
          Line(150,360,470,360);
          Line(250,140,250,360);
          Line(305,160,305,360);
          Line(360,160,360,360);
          Line(415,160,415,360);
          Line(470,160,470,360);
          SetColor(10);
          SetTextStyle(3,0,2);
          SetTextJustify(1,1);
          OutTextXY(280,160,'00');
          OutTextXY(330,160,'01');
          OutTextXY(385,160,'11');
          OutTextXY(440,160,'10');
          OutTextXY(200,200,'0  0');
          OutTextXY(200,240,'0  1');
          OutTextXY(200,285,'1  1');
          OutTextXY(200,330,'1  0');
          SetTextStyle(8,0,1);
          SetColor(11);
          IF (Estados > 0) AND (Estados <= 4) THEN
            BEGIN
              SetColor(9);
              SetTextStyle(2,0,6);
              SetTextJustify(0,2);
              OutTextXY(160,160,'Q1n  Q0n');
              OutTextXY(345,135,'XY');
            END;
          IF (Estados > 4) AND (Estados <= 8) THEN
            BEGIN
              SetColor(9);
              SetTextStyle(2,0,6);
              SetTextJustify(0,2);
              OutTextXY(160,160,'Q2n  Q1n');
              OutTextXY(345,135,'Q0nX');
              SetTextStyle(8,0,1);
              SetColor(11);
            END;
          SetColor(11);
          SetTextStyle(3,0,2);
          SetTextJustify(1,1);
          OutTextXY(280,200,Tabela_Simplif_Bin3[1,1]);
          OutTextXY(330,200,Tabela_Simplif_Bin3[1,2]);
          OutTextXY(385,200,Tabela_Simplif_Bin3[1,3]);
          OutTextXY(440,200,Tabela_Simplif_Bin3[1,4]);
          OutTextXY(280,240,Tabela_Simplif_Bin3[2,1]);
          OutTextXY(330,240,Tabela_Simplif_Bin3[2,2]);
          OutTextXY(385,240,Tabela_Simplif_Bin3[2,3]);
          OutTextXY(440,240,Tabela_Simplif_Bin3[2,4]);
          OutTextXY(280,285,Tabela_Simplif_Bin3[3,1]);
          OutTextXY(330,285,Tabela_Simplif_Bin3[3,2]);
          OutTextXY(385,285,Tabela_Simplif_Bin3[3,3]);
          OutTextXY(440,285,Tabela_Simplif_Bin3[3,4]);
          OutTextXY(280,330,Tabela_Simplif_Bin3[4,1]);
          OutTextXY(330,330,Tabela_Simplif_Bin3[4,2]);
          OutTextXY(385,330,Tabela_Simplif_Bin3[4,3]);
          OutTextXY(440,330,Tabela_Simplif_Bin3[4,4]);
            { OutTextXY(X,Y,GetInExpression(1)); }
            { DesignSimplifGroups( }
        END; { IF biestavel }
      IF (Biestavel=1) OR (Biestavel=2) THEN
        BEGIN
          SetColor(15);
          Line(40,180,280,180);
          Line(40,225,280,225);
          Line(40,270,280,270);
          Line(40,315,280,315);
          Line(40,360,280,360);
          Line(100,140,100,360);
          Line(145,160,145,360);
          Line(190,160,190,360);
          Line(235,160,235,360);
          Line(280,160,280,360);
          SetColor(10);
          SetTextStyle(3,0,1);
          SetTextJustify(1,1);
          OutTextXY(122,160,'00');
          OutTextXY(165,160,'01');
          OutTextXY(210,160,'11');
          OutTextXY(258,160,'10');
          OutTextXY(65,200,'0 0');
          OutTextXY(65,240,'0 1');
          OutTextXY(65,285,'1 1');
          OutTextXY(65,330,'1 0');
          SetColor(15);
          Line(340,180,580,180);
          Line(340,225,580,225);
          Line(340,270,580,270);
          Line(340,315,580,315);
          Line(340,360,580,360);
          Line(400,140,400,360);
          Line(445,160,445,360);
          Line(490,160,490,360);
          Line(535,160,535,360);
          Line(580,160,580,360);
          SetColor(10);
          SetTextStyle(3,0,1);
          SetTextJustify(1,1);
          OutTextXY(422,160,'00');
          OutTextXY(465,160,'01');
          OutTextXY(510,160,'11');
          OutTextXY(558,160,'10');
          OutTextXY(365,200,'0 0');
          OutTextXY(365,240,'0 1');
          OutTextXY(365,285,'1 1');
          OutTextXY(365,330,'1 0');
          IF (Estados > 0) AND (Estados <= 4) THEN
            BEGIN
              EcraMax:=3;
              SetColor(9);
              SetTextStyle(2,0,4);
              SetTextJustify(0,2);
              OutTextXY(45,160,'Q1n  Q0n');
              OutTextXY(190,130,'XY');
              OutTextXY(345,160,'Q1n  Q0n');
              OutTextXY(490,130,'XY');
            END;
          IF (Estados > 4) AND (Estados <= 8) THEN
            BEGIN
              EcraMax:=4;
              SetColor(9);
              SetTextStyle(2,0,6);
              SetTextJustify(0,2);
              OutTextXY(45,160,'Q2n  Q1n');
              OutTextXY(190,130,'Q0nX');
              OutTextXY(345,160,'Q2n  Q1n');
              OutTextXY(490,130,'Q0nX');
            END;
          SetColor(11);
          SetTextStyle(3,0,2);
          SetTextJustify(1,1);
          OutTextXY(122,200,Tabela_Simplif_Bin5[1,1]);
          OutTextXY(165,200,Tabela_Simplif_Bin5[1,2]);
          OutTextXY(210,200,Tabela_Simplif_Bin5[1,3]);
          OutTextXY(258,200,Tabela_Simplif_Bin5[1,4]);
          OutTextXY(122,240,Tabela_Simplif_Bin5[2,1]);
          OutTextXY(165,240,Tabela_Simplif_Bin5[2,2]);
          OutTextXY(210,240,Tabela_Simplif_Bin5[2,3]);
          OutTextXY(258,240,Tabela_Simplif_Bin5[2,4]);
          OutTextXY(122,285,Tabela_Simplif_Bin5[3,1]);
          OutTextXY(165,285,Tabela_Simplif_Bin5[3,2]);
          OutTextXY(210,285,Tabela_Simplif_Bin5[3,3]);
          OutTextXY(258,285,Tabela_Simplif_Bin5[3,4]);
          OutTextXY(122,330,Tabela_Simplif_Bin5[4,1]);
          OutTextXY(165,330,Tabela_Simplif_Bin5[4,2]);
          OutTextXY(210,330,Tabela_Simplif_Bin5[4,3]);
          OutTextXY(258,330,Tabela_Simplif_Bin5[4,4]);
          OutTextXY(422,200,Tabela_Simplif_Bin6[1,1]);
          OutTextXY(465,200,Tabela_Simplif_Bin6[1,2]);
          OutTextXY(510,200,Tabela_Simplif_Bin6[1,3]);
          OutTextXY(558,200,Tabela_Simplif_Bin6[1,4]);
          OutTextXY(422,240,Tabela_Simplif_Bin6[2,1]);
          OutTextXY(465,240,Tabela_Simplif_Bin6[2,2]);
          OutTextXY(510,240,Tabela_Simplif_Bin6[2,3]);
          OutTextXY(558,240,Tabela_Simplif_Bin6[2,4]);
          OutTextXY(422,285,Tabela_Simplif_Bin6[3,1]);
          OutTextXY(465,285,Tabela_Simplif_Bin6[3,2]);
          OutTextXY(510,285,Tabela_Simplif_Bin6[3,3]);
          OutTextXY(558,285,Tabela_Simplif_Bin6[3,4]);
          OutTextXY(422,330,Tabela_Simplif_Bin6[4,1]);
          OutTextXY(465,330,Tabela_Simplif_Bin6[4,2]);
          OutTextXY(510,330,Tabela_Simplif_Bin6[4,3]);
          OutTextXY(558,330,Tabela_Simplif_Bin6[4,4]);
            { OutTextXY(X,Y,GetInExpression(1)); }
            { OutTextXY(X,Y,GetInExpression(2)); }
            { DesignSimplifGroups() }
        END; { IF biestavel }
    END; { DesignTabelasScreen4 }
END.