UNIT SSYSTEM4;

INTERFACE
 USES
    CRT,GRAPH,SSYSTEM1,SSYSTEM2,SSYSTEM3;

  FUNCTION VerifyTableForDiagrama:BOOLEAN;
  PROCEDURE DesignCircle(Number,Color:INTEGER);
  PROCEDURE WriteInCircle(Number:INTEGER;Text:STRING);
  FUNCTION DetectEstadoSaida(Estado:STRING):STRING;
  PROCEDURE DesignArrows(FirstCircle,SecondCircle,Texto:STRING;ColorArrow,ColorStr:INTEGER);
  FUNCTION LookForEstado(Estado:STRING;Entrada:INTEGER):STRING;
  FUNCTION QueEstadoEsta(Estado:STRING;Entrada:INTEGER):STRING;
  FUNCTION Converte(Estado:STRING):STRING;
  PROCEDURE Valores(Numero:INTEGER);
  PROCEDURE ValoresM(Numero:INTEGER);
  PROCEDURE DesignDiagramScreen;
  PROCEDURE DesignSimulacao;

IMPLEMENTATION
{*****}
  FUNCTION VerifyTableForDiagrama:BOOLEAN;
   { This function verifies the array and turns TRUE if the table is }
   { correct, the number of estados and which. }

    BEGIN
      VerifyTableForDiagrama:=VerifyTableForCaracteristicas;
      IF NOT VerifyTableForCaracteristicas THEN
        BEGIN
          Erro:='Tabela Vazia';
          Exit;
        END;
    END; { VerifyTableForDiagrama }

{*****}
  PROCEDURE DesignCircle(Number,Color:INTEGER);
   { Designs the specified circle with a specified color }

    BEGIN
      SetColor(Color);
      CASE Number OF
        1:BEGIN  { 1 Circle }
            Circle(40,265,30);
          END;
        2:BEGIN  { 2 Circle }
            Circle(120,265,30);
          END;
        3:BEGIN  { 3 Circle }
            Circle(200,265,30);
          END;
        4:BEGIN  { 4 Circle }
            Circle(280,265,30);
          END;
        5:BEGIN  { 5 Circle }
            Circle(360,265,30);
          END;
        6:BEGIN  { 6 Circle }
            Circle(440,265,30);
          END;
        7:BEGIN  { 7 Circle }
            Circle(520,265,30);
          END;
        8:BEGIN  { 8 Circle }
            Circle(600,265,30);
          END;
      END; { End Case Number }
    END; { DesignCircle }

{*****}
  PROCEDURE WriteInCircle(Number:INTEGER;Text:STRING);
   { Writes in the specified circle  a string }

    BEGIN
      SetColor(10);
      SetTextStyle(6,0,3);
      SetTextJustify(1,1);
      CASE Number OF
        1:BEGIN  { 1 Circle }
            OutTextXY(40,257,Text);
          END;
        2:BEGIN  { 2 Circle }
            OutTextXY(120,257,Text);
          END;
        3:BEGIN  { 3 Circle }
            OutTextXY(200,257,Text);
          END;
        4:BEGIN  { 4 Circle }
            OutTextXY(280,257,Text);
          END;
        5:BEGIN  { 5 Circle }
            OutTextXY(360,257,Text);
          END;
        6:BEGIN  { 6 Circle }
            OutTextXY(440,257,Text);
          END;
        7:BEGIN  { 7 Circle }
            OutTextXY(520,257,Text);
          END;
        8:BEGIN  { 8 Circle }
            OutTextXY(600,257,Text);
          END;
      END; { End Case Number }
    END; { DesignCircle }

{*****}
 FUNCTION DetectEstadoSaida(Estado:STRING):STRING;
  { Detect saida of Estado }

   VAR
     A,B:INTEGER;

   BEGIN
     FOR A:=1 TO 8 DO
       BEGIN
         FOR B:=1 TO 4 DO
           BEGIN
             IF (Tabela_Estados_Letras[A,B]=Estado) THEN
               BEGIN
                 DetectEstadoSaida:=Tabela_Estados_Saidas[A,B];
                 Exit;
               END
              ELSE
               DetectEstadoSaida:='0';
           END;
        END;
   END; { DetectEstadoSaida }

{*****}
  PROCEDURE DesignArrows(FirstCircle,SecondCircle,Texto:STRING;ColorArrow,ColorStr:INTEGER);
   { Designs a arrow between two circles and writes the entrada}

    VAR
      CasoStr:STRING;
      CasoNum:INTEGER;
      ErrorCode:INTEGER;

    BEGIN
      CasoStr:='';
      CasoStr:=CasoStr+FirstCircle+SecondCircle;
      VAL(CasoStr,CasoNum,ErrorCode);
      SetColor(ColorArrow);
      CASE CasoNum OF
        11:BEGIN
             Ellipse(20,235,0,200,10,30);
             Line(5,240,10,245);
             Line(10,245,15,240);
             SetTextStyle(2,1,4);
             SetColor(ColorStr);
             OutTextXY(17,192,Texto);
           END;
        12:BEGIN
             Ellipse(81,250,0,180,15,10);
             Line(90,246,95,251);
             Line(95,251,100,246);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(80,230,Texto);
           END;
        13:BEGIN
             Ellipse(128,235,0,180,77,25);
             Line(200,231,205,236);
             Line(205,236,210,231);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(145,205,Texto);
           END;
        14:BEGIN
             Ellipse(160,235,0,180,115,30);
             Line(270,231,275,236);
             Line(275,236,280,231);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(175,200,Texto);
           END;
        15:BEGIN
             Ellipse(201,235,0,180,159,50);
             Line(355,231,360,236);
             Line(360,236,365,231);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(220,175,Texto);
           END;
        16:BEGIN
             Ellipse(242,235,0,180,203,70);
             Line(440,231,445,236);
             Line(445,236,450,231);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(255,155,Texto);
           END;
        17:BEGIN
             Ellipse(280,235,0,180,245,90);
             Line(520,231,525,236);
             Line(525,236,530,231);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(290,135,Texto);
           END;
        18:BEGIN
             Ellipse(322,235,0,180,290,110);
             Line(607,231,613,236);
             Line(613,236,617,231);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(320,115,Texto);
           END;
        21:BEGIN
             Ellipse(81,285,180,360,15,10);
             Line(62,288,67,283);
             Line(67,283,72,288);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(80,300,Texto);
           END;
        22:BEGIN
             Ellipse(110,232,0,200,10,30);
             Line(95,238,100,243);
             Line(100,243,105,238);
             SetTextStyle(2,1,4);
             SetColor(ColorStr);
             OutTextXY(108,187,Texto);
           END;
        23:BEGIN
             Ellipse(161,250,0,180,15,10);
             Line(170,246,175,251);
             Line(175,251,180,246);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(160,230,Texto);
           END;
        24:BEGIN
             Ellipse(210,235,0,180,77,25);
             Line(282,231,287,236);
             Line(287,236,292,231);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(200,205,Texto);
           END;
        25:BEGIN
             Ellipse(240,235,0,180,115,30);
             Line(350,231,355,236);
             Line(355,236,360,231);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(220,200,Texto);
           END;
        26:BEGIN
             Ellipse(280,235,0,180,159,50);
             Line(435,231,440,236);
             Line(440,236,445,231);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(280,175,Texto);
           END;
        27:BEGIN
             Ellipse(325,235,0,180,203,70);
             Line(525,231,530,236);
             Line(530,236,535,231);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(310,155,Texto);
           END;
        28:BEGIN
             Ellipse(370,235,0,180,245,90);
             Line(610,231,615,236);
             Line(615,236,620,231);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(380,135,Texto);
           END;
        31:BEGIN
             Ellipse(125,295,180,360,77,25);
             Line(44,300,49,295);
             Line(49,295,54,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(120,325,Texto);
           END;
        32:BEGIN
             Ellipse(160,285,180,360,15,10);
             Line(140,290,145,285);
             Line(145,285,150,290);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(160,300,Texto);
           END;
        33:BEGIN
             Ellipse(185,232,0,200,10,30);
             Line(170,238,175,243);
             Line(175,243,180,238);
             SetTextStyle(2,1,4);
             SetColor(ColorStr);
             OutTextXY(185,187,Texto);
           END;
        34:BEGIN
             Ellipse(240,250,0,180,15,10);
             Line(250,246,255,251);
             Line(255,251,260,246);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(240,230,Texto);
           END;
        35:BEGIN
             Ellipse(295,240,0,180,77,25);
             Line(365,233,370,238);
             Line(370,238,375,233);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(300,210,Texto);
           END;
        36:BEGIN
             Ellipse(333,237,0,180,115,30);
             Line(445,231,450,236);
             Line(450,236,455,231);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(320,200,Texto);
           END;
        37:BEGIN
             Ellipse(375,237,0,180,159,50);
             Line(530,233,535,238);
             Line(535,238,540,233);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(370,180,Texto);
           END;
        38:BEGIN
             Ellipse(405,235,0,180,203,70);
             Line(602,231,607,236);
             Line(607,236,613,231);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(415,160,Texto);
           END;
        41:BEGIN
             Ellipse(155,295,180,360,110,40);
             Line(40,300,45,295);
             Line(45,295,50,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(150,342,Texto);
           END;
        42:BEGIN
             Ellipse(200,295,180,360,77,25);
             Line(118,300,123,295);
             Line(123,295,128,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(220,325,Texto);
           END;
        43:BEGIN
             Ellipse(240,285,180,360,15,10);
             Line(220,290,225,285);
             Line(225,285,230,290);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(240,300,Texto);
           END;
        44:BEGIN
             Ellipse(260,235,0,200,10,30);
             Line(245,240,250,245);
             Line(250,245,255,240);
             SetTextStyle(2,1,4);
             SetColor(ColorStr);
             OutTextXY(255,187,Texto);
           END;
        45:BEGIN
             Ellipse(320,250,0,180,15,10);
             Line(330,246,335,251);
             Line(335,251,340,246);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(320,230,Texto);
           END;
        46:BEGIN
             Ellipse(380,240,0,185,77,25);
             Line(452,235,457,240);
             Line(457,240,462,235);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(400,210,Texto);
           END;
        47:BEGIN
             Ellipse(410,237,0,180,115,30);
             Line(520,233,525,238);
             Line(525,238,530,233);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(420,200,Texto);
           END;
        48:BEGIN
             Ellipse(445,237,0,180,159,50);
             Line(600,233,605,238);
             Line(605,238,610,233);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(470,180,Texto);
           END;
        51:BEGIN
             Ellipse(198,295,180,360,159,50);
             Line(33,300,38,295);
             Line(38,295,43,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(225,355,Texto);
           END;
        52:BEGIN
             Ellipse(235,295,180,360,115,40);
             Line(115,300,120,295);
             Line(120,295,125,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(220,342,Texto);
           END;
        53:BEGIN
             Ellipse(270,295,180,360,77,25);
             Line(188,300,193,295);
             Line(193,295,198,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(275,325,Texto);
           END;
        54:BEGIN
             Ellipse(320,285,180,360,15,10);
             Line(300,290,305,285);
             Line(305,285,310,290);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(320,300,Texto);
           END;
        55:BEGIN
             Ellipse(340,235,0,200,10,30);
             Line(325,240,330,245);
             Line(330,245,335,240);
             SetTextStyle(2,1,4);
             SetColor(ColorStr);
             OutTextXY(335,187,Texto);
           END;
        56:BEGIN
             Ellipse(400,250,0,180,15,10);
             Line(410,246,415,251);
             Line(415,251,420,246);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(400,230,Texto);
           END;
        57:BEGIN
             Ellipse(450,238,0,185,70,25);
             Line(515,235,520,240);
             Line(520,240,525,235);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(450,206,Texto);
           END;
        58:BEGIN
             Ellipse(487,237,0,180,115,30);
             Line(595,233,600,238);
             Line(600,238,605,233);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(480,200,Texto);
           END;
        61:BEGIN
             Ellipse(240,295,180,360,203,70);
             Line(32,300,37,295);
             Line(37,295,42,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(255,375,Texto);
           END;
        62:BEGIN
             Ellipse(280,295,180,360,159,50);
             Line(115,300,120,295);
             Line(120,295,125,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(280,355,Texto);
           END;
        63:BEGIN
             Ellipse(320,295,180,360,115,40);
             Line(200,300,205,295);
             Line(205,295,210,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(320,342,Texto);
           END;
        64:BEGIN
             Ellipse(355,295,180,360,77,25);
             Line(272,300,277,295);
             Line(277,295,282,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(350,325,Texto);
           END;
        65:BEGIN
             Ellipse(400,285,180,360,15,10);
             Line(380,290,385,285);
             Line(385,285,390,290);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(400,300,Texto);
           END;
        66:BEGIN
             Ellipse(420,235,0,200,10,30);
             Line(405,240,410,245);
             Line(410,245,415,240);
             SetTextStyle(2,1,4);
             SetColor(ColorStr);
             OutTextXY(415,187,Texto);
           END;
        67:BEGIN
             Ellipse(480,250,0,180,15,10);
             Line(490,246,495,251);
             Line(495,251,500,246);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(480,230,Texto);
           END;
        68:BEGIN
             Ellipse(530,238,0,185,70,25);
             Line(595,235,600,240);
             Line(600,240,605,235);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(530,206,Texto);
           END;
        71:BEGIN
             Ellipse(280,295,180,360,245,90);
             Line(30,300,35,295);
             Line(35,295,40,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(290,390,Texto);
           END;
        72:BEGIN
             Ellipse(320,295,180,360,203,70);
             Line(112,300,117,295);
             Line(117,295,122,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(330,375,Texto);
           END;
        73:BEGIN
             Ellipse(360,295,180,360,159,50);
             Line(195,300,200,295);
             Line(200,295,205,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(360,355,Texto);
           END;
        74:BEGIN
             Ellipse(400,295,180,360,115,40);
             Line(280,300,285,295);
             Line(285,295,290,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(400,342,Texto);
           END;
        75:BEGIN
             Ellipse(435,295,180,360,77,25);
             Line(352,300,357,295);
             Line(357,295,362,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(350,325,Texto);
           END;
        76:BEGIN
             Ellipse(480,285,180,360,15,10);
             Line(460,290,465,285);
             Line(465,285,470,290);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(480,300,Texto);
           END;
        77:BEGIN
             Ellipse(500,235,0,200,10,30);
             Line(485,240,490,245);
             Line(490,245,495,240);
             SetTextStyle(2,1,4);
             SetColor(ColorStr);
             OutTextXY(495,187,Texto);
           END;
        78:BEGIN
             Ellipse(560,250,0,180,15,10);
             Line(570,246,575,251);
             Line(575,251,580,246);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(560,230,Texto);
           END;
        81:BEGIN
             Ellipse(322,295,180,360,290,110);
             Line(28,300,33,295);
             Line(33,295,38,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(320,410,Texto);
           END;
        82:BEGIN
             Ellipse(360,295,180,360,245,90);
             Line(110,300,115,295);
             Line(115,295,120,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(370,390,Texto);
           END;
        83:BEGIN
             Ellipse(400,295,180,360,203,70);
             Line(192,300,197,295);
             Line(197,295,202,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(410,375,Texto);
           END;
        84:BEGIN
             Ellipse(440,295,180,360,159,50);
             Line(275,300,280,295);
             Line(280,295,285,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(440,355,Texto);
           END;
        85:BEGIN
             Ellipse(480,295,180,360,115,40);
             Line(360,300,365,295);
             Line(365,295,370,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(480,342,Texto);
           END;
        86:BEGIN
             Ellipse(515,295,180,360,77,25);
             Line(432,300,437,295);
             Line(437,295,442,300);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(430,325,Texto);
           END;
        87:BEGIN
             Ellipse(560,285,180,360,15,10);
             Line(540,290,545,285);
             Line(545,285,550,290);
             SetTextStyle(2,0,4);
             SetColor(ColorStr);
             OutTextXY(560,300,Texto);
           END;
        88:BEGIN
             Ellipse(580,235,0,200,10,30);
             Line(565,240,570,245);
             Line(570,245,575,240);
             SetTextStyle(2,1,4);
             SetColor(ColorStr);
             OutTextXY(575,187,Texto);
           END;
      END; { End case CasoNum }
    END; { DesignArrows }

{*****}
  FUNCTION LookForEstado(Estado:STRING;Entrada:INTEGER):STRING;
   { Returns the estado relationated with the estado and entrada }

    VAR
      Out,ErrorCode:INTEGER;

    BEGIN
      LookForEstado:='0';
      VAL(Estado,Out,ErrorCode);
      IF Tabela_Estados_Letras[Out,Entrada]='A' THEN LookForEstado:='1';
      IF Tabela_Estados_Letras[Out,Entrada]='B' THEN LookForEstado:='2';
      IF Tabela_Estados_Letras[Out,Entrada]='C' THEN LookForEstado:='3';
      IF Tabela_Estados_Letras[Out,Entrada]='D' THEN LookForEstado:='4';
      IF Tabela_Estados_Letras[Out,Entrada]='E' THEN LookForEstado:='5';
      IF Tabela_Estados_Letras[Out,Entrada]='F' THEN LookForEstado:='6';
      IF Tabela_Estados_Letras[Out,Entrada]='G' THEN LookForEstado:='7';
      IF Tabela_Estados_Letras[Out,Entrada]='H' THEN LookForEstado:='8';
      IF Tabela_Estados_Letras[Out,Entrada]='' THEN LookForEstado:='0';
    END; { LookForEstado }

{*****}
  FUNCTION QueEstadoEsta(Estado:STRING;Entrada:INTEGER):STRING;
   { Returns the estado in the square ( number ) }

    VAR
      Out,ErrorCode:INTEGER;

    BEGIN
      QueEstadoEsta:='0';
      VAL(Estado,Out,ErrorCode);
      IF Tabela_Estados_Letras[Out,Entrada]='A' THEN QueEstadoEsta:='1';
      IF Tabela_Estados_Letras[Out,Entrada]='B' THEN QueEstadoEsta:='2';
      IF Tabela_Estados_Letras[Out,Entrada]='C' THEN QueEstadoEsta:='3';
      IF Tabela_Estados_Letras[Out,Entrada]='D' THEN QueEstadoEsta:='4';
      IF Tabela_Estados_Letras[Out,Entrada]='E' THEN QueEstadoEsta:='5';
      IF Tabela_Estados_Letras[Out,Entrada]='F' THEN QueEstadoEsta:='6';
      IF Tabela_Estados_Letras[Out,Entrada]='G' THEN QueEstadoEsta:='7';
      IF Tabela_Estados_Letras[Out,Entrada]='H' THEN QueEstadoEsta:='8';
      IF Tabela_Estados_Letras[Out,Entrada]='' THEN QueEstadoEsta:='0';
    END; { QueEstadoEsta }

{*****}
  FUNCTION Converte(Estado:STRING):STRING;
   { Converte o estado em valor de circulo }

    BEGIN
      Converte:='0';
      CASE Estados OF
        1:BEGIN
            StrCirculos:='4';
            IF Estado=StrNumeros[1] THEN Converte:=StrCirculos[1];
          END;
        2:BEGIN
            StrCirculos:='34';
            IF Estado=StrNumeros[1] THEN Converte:=StrCirculos[1];
            IF Estado=StrNumeros[2] THEN Converte:=StrCirculos[2];
          END;
        3:BEGIN
            StrCirculos:='345';
            IF Estado=StrNumeros[1] THEN Converte:=StrCirculos[1];
            IF Estado=StrNumeros[2] THEN Converte:=StrCirculos[2];
            IF Estado=StrNumeros[3] THEN Converte:=StrCirculos[3];
          END;
        4:BEGIN
            StrCirculos:='3456';
            IF Estado=StrNumeros[1] THEN Converte:=StrCirculos[1];
            IF Estado=StrNumeros[2] THEN Converte:=StrCirculos[2];
            IF Estado=StrNumeros[3] THEN Converte:=StrCirculos[3];
            IF Estado=StrNumeros[4] THEN Converte:=StrCirculos[4];
          END;
        5:BEGIN
            StrCirculos:='23456';
            IF Estado=StrNumeros[1] THEN Converte:=StrCirculos[1];
            IF Estado=StrNumeros[2] THEN Converte:=StrCirculos[2];
            IF Estado=StrNumeros[3] THEN Converte:=StrCirculos[3];
            IF Estado=StrNumeros[4] THEN Converte:=StrCirculos[4];
            IF Estado=StrNumeros[5] THEN Converte:=StrCirculos[5];
          END;
        6:BEGIN
            StrCirculos:='234567';
            IF Estado=StrNumeros[1] THEN Converte:=StrCirculos[1];
            IF Estado=StrNumeros[2] THEN Converte:=StrCirculos[2];
            IF Estado=StrNumeros[3] THEN Converte:=StrCirculos[3];
            IF Estado=StrNumeros[4] THEN Converte:=StrCirculos[4];
            IF Estado=StrNumeros[5] THEN Converte:=StrCirculos[5];
            IF Estado=StrNumeros[6] THEN Converte:=StrCirculos[6];
          END;
        7:BEGIN
            StrCirculos:='1234567';
            IF Estado=StrNumeros[1] THEN Converte:=StrCirculos[1];
            IF Estado=StrNumeros[2] THEN Converte:=StrCirculos[2];
            IF Estado=StrNumeros[3] THEN Converte:=StrCirculos[3];
            IF Estado=StrNumeros[4] THEN Converte:=StrCirculos[4];
            IF Estado=StrNumeros[5] THEN Converte:=StrCirculos[5];
            IF Estado=StrNumeros[6] THEN Converte:=StrCirculos[6];
            IF Estado=StrNumeros[7] THEN Converte:=StrCirculos[7];
          END;
        8:BEGIN
            StrCirculos:='12345678';
            IF Estado=StrNumeros[1] THEN Converte:=StrCirculos[1];
            IF Estado=StrNumeros[2] THEN Converte:=StrCirculos[2];
            IF Estado=StrNumeros[3] THEN Converte:=StrCirculos[3];
            IF Estado=StrNumeros[4] THEN Converte:=StrCirculos[4];
            IF Estado=StrNumeros[5] THEN Converte:=StrCirculos[5];
            IF Estado=StrNumeros[6] THEN Converte:=StrCirculos[6];
            IF Estado=StrNumeros[7] THEN Converte:=StrCirculos[7];
            IF Estado=StrNumeros[8] THEN Converte:=StrCirculos[8];
          END;
      END; { End case Estados }
      IF Estado='0' THEN Converte:='0';
    END; { Converte }

    PROCEDURE Valores(Numero:INTEGER);
     { Retorna os valores necess rios }

      BEGIN
        VEst1:=LookForEstado(StrNumeros[Numero],1);
        VEst2:=LookForEstado(StrNumeros[Numero],2);
        VEst3:=LookForEstado(StrNumeros[Numero],3);
        VEst4:=LookForEstado(StrNumeros[Numero],4);
        VIn1:='In:=0';
        VIn2:='In:=1';
        VIn3:='In:=2';
        VIn4:='In:=3';
        IF ((VEst1=VEst2) AND (VEst2=VEst3) AND (VEst3=Vest4)) THEN
           BEGIN
             VEst2:='0';
             VEst3:='0';
             VEst4:='0';
             VIn1:='In:=0,1,2,3';
             VIn2:='';
             VIn3:='';
             VIn4:='';
           END;
        IF ((VEst1=VEst2) AND (VEst2=VEst3)) THEN
           BEGIN
             VEst2:='0';
             VEst3:='0';
             VIn1:='In:=0,1,2';
             VIn2:='';
             VIn3:='';
           END;
        IF ((VEst1=VEst2) AND (VEst2=VEst4)) THEN
           BEGIN
             VEst2:='0';
             VEst4:='0';
             VIn1:='In:=0,1,3';
             VIn2:='';
             VIn4:='';
           END;
        IF ((VEst1=VEst3) AND (VEst3=VEst4)) THEN
           BEGIN
             VEst3:='0';
             VEst4:='0';
             VIn1:='In:=0,2,3';
             VIn3:='';
             VIn4:='';
           END;
        IF (VEst1=VEst2) THEN
           BEGIN
             VEst2:='0';
             VIn1:='In:=0,1';
             VIn2:='';
           END;
        IF (VEst1=VEst3) THEN
           BEGIN
             VEst3:='0';
             VIn1:='In:=0,2';
             VIn3:='';
           END;
        IF (VEst1=VEst4) THEN
           BEGIN
             VEst4:='0';
             VIn1:='In:=0,3';
             VIn4:='';
           END;
        IF ((VEst2=VEst3) AND (VEst3=VEst4)) THEN
           BEGIN
             VEst3:='0';
             VEst4:='0';
             VIn2:='In:=1,2,3';
             VIn3:='';
             VIn4:='';
           END;
        IF (VEst2=VEst3) THEN
           BEGIN
             VEst3:='0';
             VIn2:='In:=1,2';
             VIn3:='';
           END;
        IF (VEst2=VEst4) THEN
           BEGIN
             VEst4:='0';
             VIn2:='In:=1,3';
             VIn4:='';
           END;
        IF (VEst3=VEst4) THEN
           BEGIN
             VEst4:='0';
             VIn3:='In:=2,3';
             VIn4:='';
           END;
      END; { Valores }

    PROCEDURE ValoresM(Numero:INTEGER);
     { Retorna os valores necess rios, mas para o Mealy }

      VAR
         NumeroVal,Error:INTEGER;

      BEGIN
        VEst1:=LookForEstado(StrNumeros[Numero],1);
        VEst2:=LookForEstado(StrNumeros[Numero],2);
        VEst3:=LookForEstado(StrNumeros[Numero],3);
        VEst4:=LookForEstado(StrNumeros[Numero],4);
        VAL(StrNumeros[Numero],NumeroVal,Error);
        VIn1:='In:=0 / Out:='+Tabela_Estados_Saidas[NumeroVal,1];
        VIn2:='In:=1 / Out:='+Tabela_Estados_Saidas[NumeroVal,2];
        VIn3:='In:=2 / Out:='+Tabela_Estados_Saidas[NumeroVal,3];
        VIn4:='In:=3 / Out:='+Tabela_Estados_Saidas[NumeroVal,4];
        IF ((VEst1=VEst2) AND (VEst2=VEst3) AND (VEst3=Vest4) AND
            (Tabela_Estados_Saidas[NumeroVal,1]=Tabela_Estados_Saidas[NumeroVal,2]) AND
            (Tabela_Estados_Saidas[NumeroVal,2]=Tabela_Estados_Saidas[NumeroVal,3])  AND
            (Tabela_Estados_Saidas[NumeroVal,3]=Tabela_Estados_Saidas[NumeroVal,4])) THEN
           BEGIN
             VEst2:='0';
             VEst3:='0';
             VEst4:='0';
             VIn1:='In:=0,1,2,3 / Out:='+Tabela_Estados_Saidas[NumeroVal,1];
             VIn2:='';
             VIn3:='';
             VIn4:='';
           END;
        IF ((VEst1=VEst2) AND (VEst2=VEst3) AND
            (Tabela_Estados_Saidas[NumeroVal,1]=Tabela_Estados_Saidas[NumeroVal,2]) AND
            (Tabela_Estados_Saidas[NumeroVal,2]=Tabela_Estados_Saidas[NumeroVal,3])) THEN
           BEGIN
             VEst2:='0';
             VEst3:='0';
             VIn1:='In:=0,1,2 / Out:='+Tabela_Estados_Saidas[NumeroVal,1];
             VIn2:='';
             VIn3:='';
           END;
        IF ((VEst1=VEst2) AND (VEst2=VEst4) AND
            (Tabela_Estados_Saidas[NumeroVal,1]=Tabela_Estados_Saidas[NumeroVal,2]) AND
            (Tabela_Estados_Saidas[NumeroVal,2]=Tabela_Estados_Saidas[NumeroVal,4])) THEN
           BEGIN
             VEst2:='0';
             VEst4:='0';
             VIn1:='In:=0,1,3 / Out:='+Tabela_Estados_Saidas[NumeroVal,1];
             VIn2:='';
             VIn4:='';
           END;
        IF ((VEst1=VEst3) AND (VEst3=VEst4) AND
            (Tabela_Estados_Saidas[NumeroVal,1]=Tabela_Estados_Saidas[NumeroVal,3]) AND
            (Tabela_Estados_Saidas[NumeroVal,3]=Tabela_Estados_Saidas[NumeroVal,4])) THEN
           BEGIN
             VEst3:='0';
             VEst4:='0';
             VIn1:='In:=0,2,3 / Out:='+Tabela_Estados_Saidas[NumeroVal,1];
             VIn3:='';
             VIn4:='';
           END;
        IF ((VEst1=VEst2) AND
            (Tabela_Estados_Saidas[NumeroVal,1]=Tabela_Estados_Saidas[NumeroVal,2])) THEN
           BEGIN
             VEst2:='0';
             VIn1:='In:=0,1 / Out:='+Tabela_Estados_Saidas[NumeroVal,1];
             VIn2:='';
           END;
        IF ((VEst1=VEst3) AND
            (Tabela_Estados_Saidas[NumeroVal,1]=Tabela_Estados_Saidas[NumeroVal,3])) THEN
           BEGIN
             VEst3:='0';
             VIn1:='In:=0,2 / Out:='+Tabela_Estados_Saidas[NumeroVal,1];
             VIn3:='';
           END;
        IF ((VEst1=VEst4) AND
            (Tabela_Estados_Saidas[NumeroVal,1]=Tabela_Estados_Saidas[NumeroVal,4])) THEN
           BEGIN
             VEst4:='0';
             VIn1:='In:=0,3 / Out:='+Tabela_Estados_Saidas[NumeroVal,1];
             VIn4:='';
           END;
        IF ((VEst2=VEst3) AND (VEst3=VEst4) AND
            (Tabela_Estados_Saidas[NumeroVal,2]=Tabela_Estados_Saidas[NumeroVal,3]) AND
            (Tabela_Estados_Saidas[NumeroVal,3]=Tabela_Estados_Saidas[NumeroVal,4])) THEN
           BEGIN
             VEst3:='0';
             VEst4:='0';
             VIn2:='In:=1,2,3 / Out:='+Tabela_Estados_Saidas[NumeroVal,2];
             VIn3:='';
             VIn4:='';
           END;
        IF ((VEst2=VEst3) AND
            (Tabela_Estados_Saidas[NumeroVal,2]=Tabela_Estados_Saidas[NumeroVal,3])) THEN
           BEGIN
             VEst3:='0';
             VIn2:='In:=1,2 / Out:='+Tabela_Estados_Saidas[NumeroVal,2];
             VIn3:='';
           END;
        IF ((VEst2=VEst4) AND
            (Tabela_Estados_Saidas[NumeroVal,2]=Tabela_Estados_Saidas[NumeroVal,4])) THEN
           BEGIN
             VEst4:='0';
             VIn2:='In:=1,3 / Out:='+Tabela_Estados_Saidas[NumeroVal,2];
             VIn4:='';
           END;
        IF ((VEst3=VEst4) AND
            (Tabela_Estados_Saidas[NumeroVal,3]=Tabela_Estados_Saidas[NumeroVal,4])) THEN
           BEGIN
             VEst4:='0';
             VIn3:='In:=2,3 / Out:='+Tabela_Estados_Saidas[NumeroVal,3];
             VIn4:='';
           END;
      END; { ValoresM }

{*****}
  PROCEDURE DesignDiagramScreen;
   { This procedure will design the diagram screen }

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
      OutTextXY(80,35,'Diagrama de Estados');
      SetColor(3);
      OutTextXY(80,15,'Tabela de Estados');
      OutTextXY(80,55,'Tabelas Bin rias');
      OutTextXY(80,75,'Circuito Electr¢nico');
      OutTextXY(80,95,'Sair do Programa');
      SetColor(14);
      SetTextJustify(0,0);
      SetTextStyle(8,0,1);
      OutTextXY(365,15,'"F9" Simula');
      SetTextStyle(6,0,1);
      SetTextJustify(1,0);
      SetColor(6);
      OutTextXY(320,440,'Sequencial Systems  V1.0');
      OutTextXY(320,458,'Copyright (c) 1995-97');
      OutTextXY(320,475,'Bullion MultiSoft Company');
      IF TipoCircuito='Circuito Sequencial de Moore' THEN
        BEGIN
          CASE Estados OF
            1:BEGIN { 1 Estado }
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras+'/'+DetectEstadoSaida(StrLetras));
                Valores(1);
                DesignArrows('4',Converte(VEst1),VIn1,3,3);
                DesignArrows('4',Converte(VEst2),VIn2,3,3);
                DesignArrows('4',Converte(VEst3),VIn3,3,3);
                DesignArrows('4',Converte(VEst4),VIn4,3,3);
              END;
            2:BEGIN { 2 Estado }
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[1]+'/'+DetectEstadoSaida(StrLetras[1]));
                Valores(1);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[2]+'/'+DetectEstadoSaida(StrLetras[2]));
                Valores(2);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
              END;
            3:BEGIN { 3 Estado }
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[1]+'/'+DetectEstadoSaida(StrLetras[1]));
                Valores(1);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[2]+'/'+DetectEstadoSaida(StrLetras[2]));
                Valores(2);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
                DesignCircle(5,15);
                WriteInCircle(5,StrLetras[3]+'/'+DetectEstadoSaida(StrLetras[3]));
                Valores(3);
                DesignArrows('5',Converte(VEst1),VIn1,5,5);
                DesignArrows('5',Converte(VEst2),VIn2,5,5);
                DesignArrows('5',Converte(VEst3),VIn3,5,5);
                DesignArrows('5',Converte(VEst4),VIn4,5,5);
              END;
            4:BEGIN { 4 Estado }
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[1]+'/'+DetectEstadoSaida(StrLetras[1]));
                Valores(1);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[2]+'/'+DetectEstadoSaida(StrLetras[2]));
                Valores(2);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
                DesignCircle(5,15);
                WriteInCircle(5,StrLetras[3]+'/'+DetectEstadoSaida(StrLetras[3]));
                Valores(3);
                DesignArrows('5',Converte(VEst1),VIn1,5,5);
                DesignArrows('5',Converte(VEst2),VIn2,5,5);
                DesignArrows('5',Converte(VEst3),VIn3,5,5);
                DesignArrows('5',Converte(VEst4),VIn4,5,5);
                DesignCircle(6,15);
                WriteInCircle(6,StrLetras[4]+'/'+DetectEstadoSaida(StrLetras[4]));
                Valores(4);
                DesignArrows('6',Converte(VEst1),VIn1,6,6);
                DesignArrows('6',Converte(VEst2),VIn2,6,6);
                DesignArrows('6',Converte(VEst3),VIn3,6,6);
                DesignArrows('6',Converte(VEst4),VIn4,6,6);
              END;
            5:BEGIN { 5 Estado }
                DesignCircle(2,15);
                WriteInCircle(2,StrLetras[1]+'/'+DetectEstadoSaida(StrLetras[1]));
                Valores(1);
                DesignArrows('2',Converte(VEst1),VIn1,2,2);
                DesignArrows('2',Converte(VEst2),VIn2,2,2);
                DesignArrows('2',Converte(VEst3),VIn3,2,2);
                DesignArrows('2',Converte(VEst4),VIn4,2,2);
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[2]+'/'+DetectEstadoSaida(StrLetras[2]));
                Valores(2);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[3]+'/'+DetectEstadoSaida(StrLetras[3]));
                Valores(3);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
                DesignCircle(5,15);
                WriteInCircle(5,StrLetras[4]+'/'+DetectEstadoSaida(StrLetras[4]));
                Valores(4);
                DesignArrows('5',Converte(VEst1),VIn1,5,5);
                DesignArrows('5',Converte(VEst2),VIn2,5,5);
                DesignArrows('5',Converte(VEst3),VIn3,5,5);
                DesignArrows('5',Converte(VEst4),VIn4,5,5);
                DesignCircle(6,15);
                WriteInCircle(6,StrLetras[5]+'/'+DetectEstadoSaida(StrLetras[5]));
                Valores(5);
                DesignArrows('6',Converte(VEst1),VIn1,6,6);
                DesignArrows('6',Converte(VEst2),VIn2,6,6);
                DesignArrows('6',Converte(VEst3),VIn3,6,6);
                DesignArrows('6',Converte(VEst4),VIn4,6,6);
              END;
            6:BEGIN { 6 Estado }
                DesignCircle(2,15);
                WriteInCircle(2,StrLetras[1]+'/'+DetectEstadoSaida(StrLetras[1]));
                Valores(1);
                DesignArrows('2',Converte(VEst1),VIn1,2,2);
                DesignArrows('2',Converte(VEst2),VIn2,2,2);
                DesignArrows('2',Converte(VEst3),VIn3,2,2);
                DesignArrows('2',Converte(VEst4),VIn4,2,2);
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[2]+'/'+DetectEstadoSaida(StrLetras[2]));
                Valores(2);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[3]+'/'+DetectEstadoSaida(StrLetras[3]));
                Valores(3);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
                DesignCircle(5,15);
                WriteInCircle(5,StrLetras[4]+'/'+DetectEstadoSaida(StrLetras[4]));
                Valores(4);
                DesignArrows('5',Converte(VEst1),VIn1,5,5);
                DesignArrows('5',Converte(VEst2),VIn2,5,5);
                DesignArrows('5',Converte(VEst3),VIn3,5,5);
                DesignArrows('5',Converte(VEst4),VIn4,5,5);
                DesignCircle(6,15);
                WriteInCircle(6,StrLetras[5]+'/'+DetectEstadoSaida(StrLetras[5]));
                Valores(5);
                DesignArrows('6',Converte(VEst1),VIn1,6,6);
                DesignArrows('6',Converte(VEst2),VIn2,6,6);
                DesignArrows('6',Converte(VEst3),VIn3,6,6);
                DesignArrows('6',Converte(VEst4),VIn4,6,6);
                DesignCircle(7,15);
                WriteInCircle(7,StrLetras[6]+'/'+DetectEstadoSaida(StrLetras[6]));
                Valores(6);
                DesignArrows('7',Converte(VEst1),VIn1,7,7);
                DesignArrows('7',Converte(VEst2),VIn2,7,7);
                DesignArrows('7',Converte(VEst3),VIn3,7,7);
                DesignArrows('7',Converte(VEst4),VIn4,7,7);
              END;
            7:BEGIN { 7 Estado }
                DesignCircle(1,15);
                WriteInCircle(1,StrLetras[1]+'/'+DetectEstadoSaida(StrLetras[1]));
                Valores(1);
                DesignArrows('1',Converte(VEst1),VIn1,1,1);
                DesignArrows('1',Converte(VEst2),VIn2,1,1);
                DesignArrows('1',Converte(VEst3),VIn3,1,1);
                DesignArrows('1',Converte(VEst4),VIn4,1,1);
                DesignCircle(2,15);
                WriteInCircle(2,StrLetras[2]+'/'+DetectEstadoSaida(StrLetras[2]));
                Valores(2);
                DesignArrows('2',Converte(VEst1),VIn1,2,2);
                DesignArrows('2',Converte(VEst2),VIn2,2,2);
                DesignArrows('2',Converte(VEst3),VIn3,2,2);
                DesignArrows('2',Converte(VEst4),VIn4,2,2);
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[3]+'/'+DetectEstadoSaida(StrLetras[3]));
                Valores(3);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[4]+'/'+DetectEstadoSaida(StrLetras[4]));
                Valores(4);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
                DesignCircle(5,15);
                WriteInCircle(5,StrLetras[5]+'/'+DetectEstadoSaida(StrLetras[5]));
                Valores(5);
                DesignArrows('5',Converte(VEst1),VIn1,5,5);
                DesignArrows('5',Converte(VEst2),VIn2,5,5);
                DesignArrows('5',Converte(VEst3),VIn3,5,5);
                DesignArrows('5',Converte(VEst4),VIn4,5,5);
                DesignCircle(6,15);
                WriteInCircle(6,StrLetras[6]+'/'+DetectEstadoSaida(StrLetras[6]));
                Valores(6);
                DesignArrows('6',Converte(VEst1),VIn1,6,6);
                DesignArrows('6',Converte(VEst2),VIn2,6,6);
                DesignArrows('6',Converte(VEst3),VIn3,6,6);
                DesignArrows('6',Converte(VEst4),VIn4,6,6);
                DesignCircle(7,15);
                WriteInCircle(7,StrLetras[7]+'/'+DetectEstadoSaida(StrLetras[7]));
                Valores(7);
                DesignArrows('7',Converte(VEst1),VIn1,7,7);
                DesignArrows('7',Converte(VEst2),VIn2,7,7);
                DesignArrows('7',Converte(VEst3),VIn3,7,7);
                DesignArrows('7',Converte(VEst4),VIn4,7,7);
              END;
            8:BEGIN { 8 Estado }
                DesignCircle(1,15);
                WriteInCircle(1,StrLetras[1]+'/'+DetectEstadoSaida(StrLetras[1]));
                Valores(1);
                DesignArrows('1',Converte(VEst1),VIn1,1,1);
                DesignArrows('1',Converte(VEst2),VIn2,1,1);
                DesignArrows('1',Converte(VEst3),VIn3,1,1);
                DesignArrows('1',Converte(VEst4),VIn4,1,1);
                DesignCircle(2,15);
                WriteInCircle(2,StrLetras[2]+'/'+DetectEstadoSaida(StrLetras[2]));
                Valores(2);
                DesignArrows('2',Converte(VEst1),VIn1,2,2);
                DesignArrows('2',Converte(VEst2),VIn2,2,2);
                DesignArrows('2',Converte(VEst3),VIn3,2,2);
                DesignArrows('2',Converte(VEst4),VIn4,2,2);
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[3]+'/'+DetectEstadoSaida(StrLetras[3]));
                Valores(3);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[4]+'/'+DetectEstadoSaida(StrLetras[4]));
                Valores(4);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
                DesignCircle(5,15);
                WriteInCircle(5,StrLetras[5]+'/'+DetectEstadoSaida(StrLetras[5]));
                Valores(5);
                DesignArrows('5',Converte(VEst1),VIn1,5,5);
                DesignArrows('5',Converte(VEst2),VIn2,5,5);
                DesignArrows('5',Converte(VEst3),VIn3,5,5);
                DesignArrows('5',Converte(VEst4),VIn4,5,5);
                DesignCircle(6,15);
                WriteInCircle(6,StrLetras[6]+'/'+DetectEstadoSaida(StrLetras[6]));
                Valores(6);
                DesignArrows('6',Converte(VEst1),VIn1,6,6);
                DesignArrows('6',Converte(VEst2),VIn2,6,6);
                DesignArrows('6',Converte(VEst3),VIn3,6,6);
                DesignArrows('6',Converte(VEst4),VIn4,6,6);
                DesignCircle(7,15);
                WriteInCircle(7,StrLetras[7]+'/'+DetectEstadoSaida(StrLetras[7]));
                Valores(7);
                DesignArrows('7',Converte(VEst1),VIn1,7,7);
                DesignArrows('7',Converte(VEst2),VIn2,7,7);
                DesignArrows('7',Converte(VEst3),VIn3,7,7);
                DesignArrows('7',Converte(VEst4),VIn4,7,7);
                DesignCircle(8,15);
                WriteInCircle(8,StrLetras[8]+'/'+DetectEstadoSaida(StrLetras[8]));
                Valores(8);
                DesignArrows('8',Converte(VEst1),VIn1,8,8);
                DesignArrows('8',Converte(VEst2),VIn2,8,8);
                DesignArrows('8',Converte(VEst3),VIn3,8,8);
                DesignArrows('8',Converte(VEst4),VIn4,8,8);
              END;
          END; { End Case Estados }
      END; { End if Moore }
      IF TipoCircuito='Circuito Sequencial de Mealy' THEN
        BEGIN
          CASE Estados OF
            1:BEGIN { 1 Estado }
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras);
                ValoresM(1);
                DesignArrows('4',Converte(VEst1),VIn1,3,3);
                DesignArrows('4',Converte(VEst2),VIn2,3,3);
                DesignArrows('4',Converte(VEst3),VIn3,3,3);
                DesignArrows('4',Converte(VEst4),VIn4,3,3);
              END;
            2:BEGIN { 2 Estado }
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[1]);
                ValoresM(1);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[2]);
                ValoresM(2);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
              END;
            3:BEGIN { 3 Estado }
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[1]);
                ValoresM(1);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[2]);
                ValoresM(2);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
                DesignCircle(5,15);
                WriteInCircle(5,StrLetras[3]);
                ValoresM(3);
                DesignArrows('5',Converte(VEst1),VIn1,5,5);
                DesignArrows('5',Converte(VEst2),VIn2,5,5);
                DesignArrows('5',Converte(VEst3),VIn3,5,5);
                DesignArrows('5',Converte(VEst4),VIn4,5,5);
              END;
            4:BEGIN { 4 Estado }
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[1]);
                ValoresM(1);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[2]);
                ValoresM(2);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
                DesignCircle(5,15);
                WriteInCircle(5,StrLetras[3]);
                ValoresM(3);
                DesignArrows('5',Converte(VEst1),VIn1,5,5);
                DesignArrows('5',Converte(VEst2),VIn2,5,5);
                DesignArrows('5',Converte(VEst3),VIn3,5,5);
                DesignArrows('5',Converte(VEst4),VIn4,5,5);
                DesignCircle(6,15);
                WriteInCircle(6,StrLetras[4]);
                ValoresM(4);
                DesignArrows('6',Converte(VEst1),VIn1,6,6);
                DesignArrows('6',Converte(VEst2),VIn2,6,6);
                DesignArrows('6',Converte(VEst3),VIn3,6,6);
                DesignArrows('6',Converte(VEst4),VIn4,6,6);
              END;
            5:BEGIN { 5 Estado }
                DesignCircle(2,15);
                WriteInCircle(2,StrLetras[1]);
                ValoresM(1);
                DesignArrows('2',Converte(VEst1),VIn1,2,2);
                DesignArrows('2',Converte(VEst2),VIn2,2,2);
                DesignArrows('2',Converte(VEst3),VIn3,2,2);
                DesignArrows('2',Converte(VEst4),VIn4,2,2);
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[2]);
                ValoresM(2);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[3]);
                ValoresM(3);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
                DesignCircle(5,15);
                WriteInCircle(5,StrLetras[4]);
                ValoresM(4);
                DesignArrows('5',Converte(VEst1),VIn1,5,5);
                DesignArrows('5',Converte(VEst2),VIn2,5,5);
                DesignArrows('5',Converte(VEst3),VIn3,5,5);
                DesignArrows('5',Converte(VEst4),VIn4,5,5);
                DesignCircle(6,15);
                WriteInCircle(6,StrLetras[5]);
                ValoresM(5);
                DesignArrows('6',Converte(VEst1),VIn1,6,6);
                DesignArrows('6',Converte(VEst2),VIn2,6,6);
                DesignArrows('6',Converte(VEst3),VIn3,6,6);
                DesignArrows('6',Converte(VEst4),VIn4,6,6);
              END;
            6:BEGIN { 6 Estado }
                DesignCircle(2,15);
                WriteInCircle(2,StrLetras[1]);
                ValoresM(1);
                DesignArrows('2',Converte(VEst1),VIn1,2,2);
                DesignArrows('2',Converte(VEst2),VIn2,2,2);
                DesignArrows('2',Converte(VEst3),VIn3,2,2);
                DesignArrows('2',Converte(VEst4),VIn4,2,2);
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[2]);
                ValoresM(2);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[3]);
                ValoresM(3);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
                DesignCircle(5,15);
                WriteInCircle(5,StrLetras[4]);
                ValoresM(4);
                DesignArrows('5',Converte(VEst1),VIn1,5,5);
                DesignArrows('5',Converte(VEst2),VIn2,5,5);
                DesignArrows('5',Converte(VEst3),VIn3,5,5);
                DesignArrows('5',Converte(VEst4),VIn4,5,5);
                DesignCircle(6,15);
                WriteInCircle(6,StrLetras[5]);
                ValoresM(5);
                DesignArrows('6',Converte(VEst1),VIn1,6,6);
                DesignArrows('6',Converte(VEst2),VIn2,6,6);
                DesignArrows('6',Converte(VEst3),VIn3,6,6);
                DesignArrows('6',Converte(VEst4),VIn4,6,6);
                DesignCircle(7,15);
                WriteInCircle(7,StrLetras[6]);
                ValoresM(6);
                DesignArrows('7',Converte(VEst1),VIn1,7,7);
                DesignArrows('7',Converte(VEst2),VIn2,7,7);
                DesignArrows('7',Converte(VEst3),VIn3,7,7);
                DesignArrows('7',Converte(VEst4),VIn4,7,7);
              END;
            7:BEGIN { 7 Estado }
                DesignCircle(1,15);
                WriteInCircle(1,StrLetras[1]);
                ValoresM(1);
                DesignArrows('1',Converte(VEst1),VIn1,1,1);
                DesignArrows('1',Converte(VEst2),VIn2,1,1);
                DesignArrows('1',Converte(VEst3),VIn3,1,1);
                DesignArrows('1',Converte(VEst4),VIn4,1,1);
                DesignCircle(2,15);
                WriteInCircle(2,StrLetras[2]);
                ValoresM(2);
                DesignArrows('2',Converte(VEst1),VIn1,2,2);
                DesignArrows('2',Converte(VEst2),VIn2,2,2);
                DesignArrows('2',Converte(VEst3),VIn3,2,2);
                DesignArrows('2',Converte(VEst4),VIn4,2,2);
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[3]);
                ValoresM(3);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[4]);
                ValoresM(4);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
                DesignCircle(5,15);
                WriteInCircle(5,StrLetras[5]);
                ValoresM(5);
                DesignArrows('5',Converte(VEst1),VIn1,5,5);
                DesignArrows('5',Converte(VEst2),VIn2,5,5);
                DesignArrows('5',Converte(VEst3),VIn3,5,5);
                DesignArrows('5',Converte(VEst4),VIn4,5,5);
                DesignCircle(6,15);
                WriteInCircle(6,StrLetras[6]);
                ValoresM(6);
                DesignArrows('6',Converte(VEst1),VIn1,6,6);
                DesignArrows('6',Converte(VEst2),VIn2,6,6);
                DesignArrows('6',Converte(VEst3),VIn3,6,6);
                DesignArrows('6',Converte(VEst4),VIn4,6,6);
                DesignCircle(7,15);
                WriteInCircle(7,StrLetras[7]);
                ValoresM(7);
                DesignArrows('7',Converte(VEst1),VIn1,7,7);
                DesignArrows('7',Converte(VEst2),VIn2,7,7);
                DesignArrows('7',Converte(VEst3),VIn3,7,7);
                DesignArrows('7',Converte(VEst4),VIn4,7,7);
              END;
            8:BEGIN { 8 Estado }
                DesignCircle(1,15);
                WriteInCircle(1,StrLetras[1]);
                ValoresM(1);
                DesignArrows('1',Converte(VEst1),VIn1,1,1);
                DesignArrows('1',Converte(VEst2),VIn2,1,1);
                DesignArrows('1',Converte(VEst3),VIn3,1,1);
                DesignArrows('1',Converte(VEst4),VIn4,1,1);
                DesignCircle(2,15);
                WriteInCircle(2,StrLetras[2]);
                ValoresM(2);
                DesignArrows('2',Converte(VEst1),VIn1,2,2);
                DesignArrows('2',Converte(VEst2),VIn2,2,2);
                DesignArrows('2',Converte(VEst3),VIn3,2,2);
                DesignArrows('2',Converte(VEst4),VIn4,2,2);
                DesignCircle(3,15);
                WriteInCircle(3,StrLetras[3]);
                ValoresM(3);
                DesignArrows('3',Converte(VEst1),VIn1,3,3);
                DesignArrows('3',Converte(VEst2),VIn2,3,3);
                DesignArrows('3',Converte(VEst3),VIn3,3,3);
                DesignArrows('3',Converte(VEst4),VIn4,3,3);
                DesignCircle(4,15);
                WriteInCircle(4,StrLetras[4]);
                ValoresM(4);
                DesignArrows('4',Converte(VEst1),VIn1,4,4);
                DesignArrows('4',Converte(VEst2),VIn2,4,4);
                DesignArrows('4',Converte(VEst3),VIn3,4,4);
                DesignArrows('4',Converte(VEst4),VIn4,4,4);
                DesignCircle(5,15);
                WriteInCircle(5,StrLetras[5]);
                ValoresM(5);
                DesignArrows('5',Converte(VEst1),VIn1,5,5);
                DesignArrows('5',Converte(VEst2),VIn2,5,5);
                DesignArrows('5',Converte(VEst3),VIn3,5,5);
                DesignArrows('5',Converte(VEst4),VIn4,5,5);
                DesignCircle(6,15);
                WriteInCircle(6,StrLetras[6]);
                ValoresM(6);
                DesignArrows('6',Converte(VEst1),VIn1,6,6);
                DesignArrows('6',Converte(VEst2),VIn2,6,6);
                DesignArrows('6',Converte(VEst3),VIn3,6,6);
                DesignArrows('6',Converte(VEst4),VIn4,6,6);
                DesignCircle(7,15);
                WriteInCircle(7,StrLetras[7]);
                ValoresM(7);
                DesignArrows('7',Converte(VEst1),VIn1,7,7);
                DesignArrows('7',Converte(VEst2),VIn2,7,7);
                DesignArrows('7',Converte(VEst3),VIn3,7,7);
                DesignArrows('7',Converte(VEst4),VIn4,7,7);
                DesignCircle(8,15);
                WriteInCircle(8,StrLetras[8]);
                ValoresM(8);
                DesignArrows('8',Converte(VEst1),VIn1,8,8);
                DesignArrows('8',Converte(VEst2),VIn2,8,8);
                DesignArrows('8',Converte(VEst3),VIn3,8,8);
                DesignArrows('8',Converte(VEst4),VIn4,8,8);
              END;
          END; { End Case Estados }
      END; { End if Mealy }
    END; { DesignDiagramScreen }

{*****}
  PROCEDURE DesignSimulacao;
   { This procedure will simulate the diagram screen }

    VAR
       Error:INTEGER;

    BEGIN
      DesignDiagramScreen;
      SetColor(0);
      SetTextStyle(7,0,1);
      SetTextJustify(0,0);
      OutTextXY(10,15,'F1 - ');
      OutTextXY(10,35,'F2 - ');
      OutTextXY(10,55,'F3 - ');
      OutTextXY(10,75,'F4 - ');
      OutTextXY(10,95,'ESC - ');
      SetTextStyle(7,0,1);
      OutTextXY(80,35,'Diagrama de Estados');
      OutTextXY(80,15,'Tabela de Estados');
      OutTextXY(80,55,'Tabelas Bin rias');
      OutTextXY(80,75,'Circuito Electr¢nico');
      OutTextXY(80,95,'Sair do Programa');
      SetTextJustify(0,0);
      SetTextStyle(8,0,1);
      OutTextXY(365,15,'"F9" Simula');
      SetColor(14);
      OutTextXY(335,15,'"F9" Stop');
      OutTextXY(335,40,'"0,1,2,3" Teclas de Entrada');
      EstActual:=StrNumeros[1];
      CircActual:=Converte(EstActual);
      VAL(CircActual,CircActualN,Error);
      DesignCircle(CircActualN,9);
    END; { Simulacao }
END.
