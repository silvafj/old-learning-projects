program Genio;
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
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\GENIO_1.PIC');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(10+1,10+1,p^,0);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\GENIO_3.pic');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(10+1,60+1,p^,0);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\GENIO_4.pic');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(10+1,110+1,p^,0);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\GENIO_5.PIC');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(10+1,160+1,p^,0);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\GENIO_6.pic');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(10+1,210+1,p^,0);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\GENIO_7.pic');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(10+1,260+1,p^,0);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\GENIO_8.pic');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(10+1,310+1,p^,0);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\GL_1.pic');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(5+10,370+10,p^,0);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\GL_2.pic');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'D:\PASCAL\IMAGENS\GENIO\preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(315+10,370+10,p^,0);
        close(fiche);
        pause:=readkey;
closegraph;
end.