{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{|  PROGRAMA            => Geral V P˜1.1  IntroduáÑo                     |}
{*  PROGRAMADO EM       => Turbo Pascal 6.0                              *}
{|  AUTOR               => Fernando Jorge de Almeida da Silva            |}
{*  ENDEREÄO            => Juncal - Assequins 3750 Ügueda                *}
{|  TELEFONE            => (034) 602800                                  |}
{*  DATA DA PROGRAMAÄéO => Setembro/95                                   *}
{|  COM PARTICIPAÄéO DE =>                                               |}
{*                                                                       *}
{|  FUNÄéO DO PROGRAMA  => Unit para o Geral                             |}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}



UNIT gerintro;

INTERFACE

{*-*-*-*-*-*-*-*-*-*-*-*-| PROCEDURES E FUNÄôES DA |-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| UNIT |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}


PROCEDURE Intro;
PROCEDURE EgaVgaDriverProc;
PROCEDURE LittProc;
PROCEDURE SansProc;
PROCEDURE TripProc;
PROCEDURE Aborta(Msg : string);


IMPLEMENTATION

USES
      CRT,GRAPH,DOS;


{*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURES DE LINKAGEM DAS |*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*| FONTES E DO DRIVER GRÜFICO |*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE EgaVgaDriverProc;EXTERNAL;
  {$L egavga.obj}

PROCEDURE LittProc;EXTERNAL;
  {$L litt.obj}

PROCEDURE SansProc;EXTERNAL;
  {$L sans.obj}

PROCEDURE TripProc;EXTERNAL;
  {$L trip.obj}



{*-*-*-*-*-*-*-*-*-*-*| PROCEDURE QUE ABORTA O PROGRAMA |*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*| EM CASO DE FALHA GRÜFICA |*-*-*-*-*-*-*-*-*-*-*-*}



PROCEDURE Aborta(Msg : string);

BEGIN
  WRITELN(Msg, ': ', GRAPHERRORMSG(GRAPHRESULT));
  HALT(1);
END;



{*-*-*-*-*-*-*-*-*-*-*| PROCEDURE QUE FAZ UM DELAYPRESS |*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-| ATê UMA TECLA SER PREMIDA |-*-*-*-*-*-*-*-*-*-*-*-}



PROCEDURE DELAYpress(time:integer);
  VAR
      cont:INTEGER;
      c:CHAR;
  BEGIN
    FOR cont:=1 TO time DO
    BEGIN
      DELAY(1);
      IF KEYPRESSED THEN EXIT;
    END;
  END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| INTRODUÄéO 2 |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE Intro_2;

VAR
   i :INTEGER;

BEGIN
  CLEARDEVICE;
  SETCOLOR(1);
  SETTEXTSTYLE(1,0,20);
  FOR i := 1 TO 10 DO
    BEGIN
      OUTTEXTXY(130+i,100-i,'G');
      OUTTEXTXY(200+i,100-i,'E');
      OUTTEXTXY(270+i,100-i,'R');
      OUTTEXTXY(340+i,100-i,'A');
      OUTTEXTXY(410+i,100-i,'L');
    END;
  SETCOLOR(2);
  OUTTEXTXY(130,100,'G');
  DELAY(800);
  OUTTEXTXY(200,100,'E');
  DELAY(800);
  OUTTEXTXY(270,100,'R');
  DELAY(800);
  OUTTEXTXY(340,100,'A');
  DELAY(800);
  OUTTEXTXY(410,100,'L');
  DELAY(50);
  SETCOLOR(15);
  SETTEXTSTYLE(3,0,3);
  OUTTEXTXY(450,140,'VersÑo P˜1.1');
  OUTTEXTXY(450,160, '* 1995 *');
  DELAY(2000);
  SETCOLOR(0);
  SETTEXTSTYLE(1,0,20);
  FOR i := 1 TO 10 DO
    BEGIN
      OUTTEXTXY(130+i,100-i,'G');
      OUTTEXTXY(200+i,100-i,'E');
      OUTTEXTXY(270+i,100-i,'R');
      OUTTEXTXY(340+i,100-i,'A');
      OUTTEXTXY(410+i,100-i,'L');
    END;
  DELAY(2000);
END;




{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| INTRODUÄéO |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}


PROCEDURE Intro;

 VAR
      cor :INTEGER;
BEGIN
  CLEARDEVICE;
    BEGIN
      SETCOLOR(2);
      SETTEXTSTYLE(1,0,5);
      OUTTEXTXY(215,100,'Fernando');
      SETTEXTSTYLE(1,0,5);
      DELAY(2500);
      OUTTEXTXY(255,150,'Jorge');
      DELAYpress(2000);
    END;
      SETCOLOR(15);
      SETTEXTSTYLE(1,0,7);
      OUTTEXTXY(150,250,'APRESENTA');
      DELAYpress(3000);
      Intro_2;
      IF KEYPRESSED THEN EXIT;
END;

BEGIN

END.