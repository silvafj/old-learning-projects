program copos;

  uses crt,graph,tp;

CONST
      gd   : INTEGER = 9;
      gm   : INTEGER = 2;

VAR
   a : INTEGER;



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




BEGIN
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
         { copo 1 }
    setcolor(15);
    line(150,300,250,300);
    line(150,300,125,150);
    line(250,300,275,150);
    setcolor(9);
    line(151,299,249,299);
    line(151,299,130,175);
    line(249,299,270,175);
    line(130,175,270,175);
    floodfill(152,298,9);
    readln;
         { copo 2}
    setcolor(15);
    line(350,300,450,300);
    line(350,300,325,150);
    line(450,300,475,150);
    setcolor(9);
    line(351,299,449,299);
    line(351,299,330,165);
    line(449,299,470,165);
    line(330,165,470,165);
    floodfill(352,298,9);
    readln;
   setcolor(12);
   line(370,295,400,110);
   line(380,295,410,113);
   line(400,110,460,95);
   line(410,113,460,100);
   readln;
   for a := 1 to 135 do
    begin
      setcolor(0);
      line(330,164+a,470,164+a);
      setcolor(15);
      line(350,300,450,300);
      line(350,300,325,150);
      line(450,300,475,150);
      setcolor(12);
      line(370,295,400,110);
      line(380,295,410,113);
    end;
    readln;
   setcolor(0);
   line(370,295,400,110);
   line(380,295,410,113);
   line(400,110,460,95);
   line(410,113,460,100);
   setcolor(12);
   line(170,295,200,110);
   line(180,295,210,113);
   line(200,110,260,95);
   line(210,113,260,100);
   readln;
   for a := 1 to 135 do
    begin
      setcolor(0);
      line(130,164+a,270,164+a);
      setcolor(15);
      line(150,300,250,300);
      line(150,300,125,150);
      line(250,300,275,150);
      setcolor(12);
      line(170,295,200,110);
      line(180,295,210,113);
    end;
    readln;
    closegraph;

END.