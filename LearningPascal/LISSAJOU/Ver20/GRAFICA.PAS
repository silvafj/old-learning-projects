UNIT grafica;

INTERFACE


{/////////////////////Procedures e Fun‡äes da unit///////////////////////////}



Procedure Inicia_graficos;
Procedure EgaVgaDriverProc;
Procedure LittProc;
Procedure SansProc;
Procedure TripProc;
Procedure Aborta(Msg : string);

IMPLEMENTATION

USES crt,graph;

CONST
     gd   : INTEGER = 9;
     gm   : INTEGER = 2;

{////////////Procedures de linkagem de fontes e do driver gr fico////////////}



Procedure EgaVgaDriverProc;external;
  {$L egavga.obj}

Procedure LittProc;external;
  {$L litt.obj}

Procedure SansProc;external;
  {$L sans.obj}

Procedure TripProc;external;
  {$L trip.obj}



{//////////Procedure que aborta o programa em caso de falha Gr fica//////////}



Procedure Aborta(Msg : string);

begin
  Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
  Halt(1);
end;

Procedure Inicia_graficos;
begin
  IF RegisterBGIdriver(@EGAVGADriverProc) < 0 THEN
  Aborta('EGAVGA');
  if RegisterBGIfont(@TripProc) < 0 then
  Aborta('Triplex');
  if RegisterBGIfont(@littProc) < 0 then
  Aborta('Little');
  if RegisterBGIfont(@sansProc) < 0 then
  Aborta('Sans Serif');
  INITGRAPH(gd,gm,'');
  IF GROK<>0 THEN BEGIN
    WRITELN('Necessita de placa VGA');
  HALT;
END;
end;


BEGIN

END.