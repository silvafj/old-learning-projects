program Rolling_Stones;
{$M 4000,0,45000}
  uses crt,graph;

CONST
      gd   : INTEGER = 9;
      gm   : INTEGER = 2;

VAR
   a : INTEGER;
          resp,pause :char;
          x1, y1, x2, y2 : Integer;
          fiche:file;
          p,pr:pointer;
          tam,aesc,esc,lidos:word;
          COR : word;


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
        assign(fiche,'ROLL_1.PIC');
        reset(fiche);
        tam:=Imagesize(1,1,639,100);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(1,1,639,100);
        PutImage(14+1,9+10,p^,4);
        close(fiche);
        assign(fiche,'ROLL_2.pic');
        reset(fiche);
        tam:=Imagesize(1,100,630,191);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(1,100,630,191);
        PutImage(14+1,100+10,p^,4);
        close(fiche);
        assign(fiche,'ROLL_3.pic');
        reset(fiche);
        tam:=Imagesize(1,191,630,282);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(1,191,630,282);
        PutImage(14+1,191+10,p^,4);
        close(fiche);
        assign(fiche,'ROLL_4.pic');
        reset(fiche);
        tam:=Imagesize(1,282,630,373);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(1,282,630,373);
        PutImage(14+1,282+10,p^,4);
        close(fiche);
        assign(fiche,'ROLL_5.PIC');
        reset(fiche);
        tam:=Imagesize(1,373,630,442);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(1,373,630,442);
        PutImage(14+1,373+10,p^,4);
        close(fiche);
        SETFILLSTYLE(0,0);
        BAR(0,427,639,479);
        assign(fiche,'ROLL_6.PIC');
        reset(fiche);
        tam:=Imagesize(1,427,630,442);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(1,427,630,442);
        PutImage(14+1,417+10,p^,4);
        close(fiche);
        pause:=readkey;
        assign(fiche,'ROLL_1.PIC');
        reset(fiche);
        tam:=Imagesize(1,1,639,100);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(1,1,639,100);
        PutImage(14+1,9+10,p^,0);
        close(fiche);
        assign(fiche,'ROLL_2.pic');
        reset(fiche);
        tam:=Imagesize(1,100,630,191);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(1,100,630,191);
        PutImage(14+1,100+10,p^,0);
        close(fiche);
        assign(fiche,'ROLL_3.pic');
        reset(fiche);
        tam:=Imagesize(1,191,630,282);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(1,191,630,282);
        PutImage(14+1,191+10,p^,0);
        close(fiche);
        assign(fiche,'ROLL_4.pic');
        reset(fiche);
        tam:=Imagesize(1,282,630,373);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(1,282,630,373);
        PutImage(14+1,282+10,p^,0);
        close(fiche);
        assign(fiche,'ROLL_5.PIC');
        reset(fiche);
        tam:=Imagesize(1,373,630,442);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(1,373,630,442);
        PutImage(14+1,373+10,p^,0);
        close(fiche);
        SETFILLSTYLE(0,0);
        BAR(0,427,639,479);
        assign(fiche,'ROLL_6.PIC');
        reset(fiche);
        tam:=Imagesize(1,427,630,442);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(1,427,630,442);
        PutImage(14+1,417+10,p^,0);
        close(fiche);
        pause:=readkey;
closegraph;
end.