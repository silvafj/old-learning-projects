PROGRAM Apresenta;
{$M 4000,0,45000}
USES
    crt,dos,graph;

CONST
      gd   : INTEGER = 9;
      gm   : INTEGER = 2;

LABEL
     1;
VAR
   a,b : INTEGER;
   cont,cor,x,y:integer;
   regs:registers;

PROCEDURE EgaVgaDriverProc;EXTERNAL;
  {$L egavga.obj}

PROCEDURE LittProc;EXTERNAL;
  {$L litt.obj}

PROCEDURE SansProc;EXTERNAL;
  {$L sans.obj}

PROCEDURE TripProc;EXTERNAL;
  {$L trip.obj}

PROCEDURE Aborta(Msg : string);

BEGIN
  WRITELN(Msg, ': ', GRAPHERRORMSG(GRAPHRESULT));
  HALT(1);
END;

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


BEGIN
   if paramstr(1)<>'LISúsajous_2' then
     begin
       writeln('Ficheiro de apresenta‡„o alterado');
       delay(2000);
       writeln('Reiniciando sistema');
       delay(2000);
       regs.ah:=$25;
       regs.al:=$19;
       regs.ds:=$ffff;
       regs.dx:=0;
       msdos (regs);
       intr ($19, regs)
     end;
  IF RegisterBGIdriver(@EGAVGADriverProc) < 0 THEN
  Aborta('EGAVGA');
  IF RegisterBGIfont(@TripProc) < 0 THEN
  Aborta('Triplex');
  IF RegisterBGIfont(@littProc) < 0 THEN
  Aborta('Little');
  IF RegisterBGIfont(@sansProc) < 0 THEN
  Aborta('Sans Serif');
  INITGRAPH(gd,gm,'');
  IF GROK<>0 THEN BEGIN
    WRITELN('Necessita de placa VGA');
  HALT;
END;

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
   if keypressed then goto 1;
   repeat
     setrgbpalette(cor,cont,0,0);
     delaypress(10);
     if keypressed then goto 1;
     cont:=cont+1;
   until cont=50;
  settextstyle(3,0,4);
  settextjustify(1,1);
  setcolor(15);
  outtextxy(320,240,'presents');
  settextjustify(1,1);
  delaypress(1500);
  cont:=10;
  if keypressed then goto 1;
   repeat
     settextstyle(1,0,cont);
     setcolor(3);
     outtextxy(320,320,'Lissajous');
     if keypressed then goto 1;
     setcolor(0);
     outtextxy(320,320,'Lissajous');
     cont:=cont-1;
   until cont=4;
   setcolor(3);
   outtextxy(320,320,'Lissajous');
   if keypressed then goto 1;
   settextstyle(0,0,1);
   cont:=1;
   repeat
       setcolor(15);
       outtextxy(cont*2,360,'Vers„o 2.0');
       setcolor(0);
       outtextxy(cont*2,360,'Vers„o 2.0');
       cont:=cont+2;
       if keypressed then goto 1;
   until cont=151;
   setcolor(15);
   outtextxy(318,360,'Vers„o 2.0');
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


 1:BEGIN
     closegraph;
     exit;
     halt;
   END;

END.