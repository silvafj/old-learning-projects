{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{|  PROGRAMA            => Lissajous V3.0                                  |}
{*  PROGRAMADO EM       => Turbo Pascal 6.0                                *}
{|  AUTOR               => Fernando Jorge de Almeida da Silva              |}
{*  ENDERE€O            => Juncal - Assequins 3750 †gueda                  *}
{|  TELEFONE            => (034) 602800                                    |}
{*  DATA DA PROGRAMA€ŽO => Fevereiro/96                                    *}
{|  FUN€ŽO DO PROGRAMA  => Unit gr fica do Lissajous V3.0                  |}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
UNIT grafica;

INTERFACE


{=======================> Procedures e Fun‡”es da unit <=====================}

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

{==========> Procedures de linkagem de fontes e do driver gr fico <==========}

Procedure EgaVgaDriverProc;external;
  {$L egavga.obj}

Procedure LittProc;external;
  {$L litt.obj}

Procedure SansProc;external;
  {$L sans.obj}

Procedure TripProc;external;
  {$L trip.obj}



{========> Procedure que aborta o programa em caso de falha Gr fica <========}

Procedure Aborta(Msg : string);

begin
  Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
  Halt(1);
end;

{=================> Procedure de inicia‡„o dos gr ficos <====================}

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
END;

BEGIN

END.