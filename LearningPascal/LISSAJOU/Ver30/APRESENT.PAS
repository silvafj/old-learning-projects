{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{|  PROGRAMA            => Lissajous V3.0                                  |}
{*  PROGRAMADO EM       => Turbo Pascal 6.0                                *}
{|  AUTOR               => Fernando Jorge de Almeida da Silva              |}
{*  ENDERE€O            => Juncal - Assequins 3750 †gueda                  *}
{|  TELEFONE            => (034) 602800                                    |}
{*  DATA DA PROGRAMA€ŽO => Fevereiro/96                                    *}
{|  FUN€ŽO DO PROGRAMA  => Unit de apresenta‡„o do Lissajous V3.0          |}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
UNIT Apresent;

INTERFACE


{============================> Procedure da unit <===========================}

Procedure Apresentacao;
Procedure Delaypress(tempo:integer);


IMPLEMENTATION

USES crt,graph;

VAR
   a,b : INTEGER;
   cont,cor,x,y:integer;

{=============> Faz uma pausa ou sai se for premida uma tecla <==============}

Procedure delaypress(tempo:integer);
  var cont:integer;
      c:char;
  begin
    for cont:=1 to tempo do
      begin
        delay(1);
        if keypressed then
          BEGIN;
            exit;
            halt;
          end;
      end;
  end;

{=======================> Apresenta o programa <=============================}

PROCEDURE Apresentacao;
BEGIN
   cleardevice;
   setcolor(9);
   settextstyle(1,0,7);
   settextjustify(1,2);
   outtextxy(316,28,'L');
   setcolor(1);
   settextstyle(1,0,7);
   settextjustify(1,2);
   outtextxy(300,2,'G');
   setcolor(14);
   settextstyle(2,1,4);
   outtextxy(320,21,'corporation');
   setcolor(15);
   circle(311,50,50);
   delaypress(200);
   setrgbpalette(2,0,0,0);
   setcolor(15);
   settextstyle(3,0,3);
   settextjustify(1,1);
   outtextxy(50,160,'by');
   delaypress(200);
   setcolor(2);
   settextstyle(3,0,4);
   settextjustify(1,1);
   outtextxy(320,160,'Fernando J. A. Silva');
   cont:=0;
   cor:=2;
   if keypressed then exit;
   repeat
     setrgbpalette(cor,cont,0,0);
     delaypress(10);
     if keypressed then exit;
     cont:=cont+1;
   until cont=50;
  settextstyle(3,0,4);
  settextjustify(1,1);
  setcolor(15);
  outtextxy(320,240,'presents');
  settextjustify(1,1);
  delaypress(1500);
  cont:=10;
  if keypressed then exit;
   repeat
     settextstyle(1,0,cont);
     setcolor(3);
     outtextxy(320,320,'Lissajous');
     if keypressed then exit;
     setcolor(0);
     outtextxy(320,320,'Lissajous');
     cont:=cont-1;
   until cont=4;
   setcolor(3);
   outtextxy(320,320,'Lissajous');
   if keypressed then exit;
   settextstyle(0,0,1);
   cont:=1;
   repeat
       setcolor(15);
       outtextxy(cont*2,360,'Vers„o 3.0');
       setcolor(0);
       outtextxy(cont*2,360,'Vers„o 3.0');
       cont:=cont+2;
       if keypressed then exit;
   until cont=151;
   setcolor(15);
   outtextxy(318,360,'Vers„o 3.0');
   cont:=311;
   for a := 50 downto 0 do
    begin
      setcolor(0);
      circle(311,50,a);
    end;
   for a := 100 downto 0 do
    begin
      setcolor(15);
      line(250,a,365,a);
      delaypress(20);
      setcolor(0);
      line(250,a,365,a);
    end;
   setcolor(15);
   line(250,0,365,0);
   for a:= 0 to 280 do
    begin
     delaypress(5);
     putpixel(360+a,0,15);
    end;
   for a:= 0 to 480 do
    begin
     delaypress(5);
     putpixel(639,0+a,15);
    end;
   for a:= 639 downto 50 do
    begin
     delaypress(5);
     putpixel(a,479,15);
    end;
   setcolor(15);
   settextstyle(1,0,1);
   outtextxy(25,469,'1996');
   delaypress(1000);
 End;



BEGIN

END.