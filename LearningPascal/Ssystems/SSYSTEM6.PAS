UNIT SSYSTEM6;

INTERFACE
 USES
    CRT,GRAPH,SSYSTEM1,SSYSTEM2,SSYSTEM3,SSYSTEM4,SSYSTEM5;

  FUNCTION VerifyTableForCircuito:BOOLEAN;
  PROCEDURE DesignCircuitoScreen;

IMPLEMENTATION

{*****}
  FUNCTION VerifyTableForCircuito:BOOLEAN;
   { Verifies the table for tabelas }

    BEGIN
      VerifyTableForCircuito:=VerifyTableForCaracteristicas;
      Erro:='';
      IF NOT VerifyTableForCaracteristicas THEN
        BEGIN
          Erro:='Tabela Vazia';
          Exit;
        END;
    END; { VerifyTableForCircuito }

{*****}
  PROCEDURE DesignCircuitoScreen;
   { This procedure will design the tabelas screen }

    BEGIN
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
      OutTextXY(80,75,'Circuito Electr¢nico');
      SetColor(3);
      OutTextXY(80,15,'Tabela de Estados');
      OutTextXY(80,35,'Diagrama de Estados');
      OutTextXY(80,55,'Tabelas Bin rias');
      OutTextXY(80,95,'Sair do Programa');
      SetColor(14);
      SetTextJustify(0,0);
      SetTextStyle(8,0,1);
      OutTextXY(365,15,'');
      SetTextStyle(6,0,1);
      SetTextJustify(1,0);
      SetColor(6);
      OutTextXY(320,440,'Sequencial Systems  V1.0');
      OutTextXY(320,458,'Copyright (c) 1995-97');
      OutTextXY(320,475,'Bullion MultiSoft Company');
      SetColor(12);
      SetTextStyle(5,0,3);
      OutTextXY(320,240,'Fun‡ao Nao');
      OutTextXY(320,260,'Implementada');
      OutTextXY(320,280,'Nesta Versao');
      SetTextJustify(1,0);
      OutTextXY(320,240,'Fun‡~o N~o');
      OutTextXY(320,260,'Implementada');
      OutTextXY(320,280,'Nesta Vers~o');
    END; { DesignCircuitoScreen }
END.