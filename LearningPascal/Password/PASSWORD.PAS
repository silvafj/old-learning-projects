{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{|  PROGRAMA            => Password V1.0                                   |}
{*  PROGRAMADO EM       => Turbo Pascal 6.0                                *}
{|  AUTOR               => Fernando Jorge de Almeida da Silva              |}
{*  ENDERE€O            => Juncal - Assequins 3750 †gueda                  *}
{|  TELEFONE            => (034) 602800                                    |}
{*  DATA DA PROGRAMA€ŽO => Fevereiro/96                                    *}
{|  FUN€ŽO DO PROGRAMA  => Programa Principal                              |}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
PROGRAM Password;
{$M 10000,100000,180000}

  USES
     Crt,Dos,Graph,Grafica,Glib1,Goldplay;

{=========================> Vari veis do Programa <==========================}

  VAR
     arq : TEXT;
     a : INTEGER;
     pause :CHAR;
     x1, y1, x2, y2 : INTEGER;
     fiche:FILE;
     p,pr:POINTER;
     tam,aesc,esc,lidos:WORD;
     nome_do_utilizador,codigo_do_utilizador,Nome,Codigo,S:STRING[40];
     Ficheiro_de_musica:STRING[40];
     out:BYTE;
     utilizadores : STRING;
     n_util,erro : INTEGER;
     regs:registers;
     Dispositivo,Timerspeed,SBDMA,SBIRQ,SBPORT:STRING;
     dis,tim,sbd,sbi,sbp:INTEGER;

{===============================> PROGRAMA <=================================}

  BEGIN
    Checkbreak:=false;
    Setcbreak(checkbreak);
    If paramcount > 1 then
      begin
        writeln('Demasiados parametros');
        Delay(2000);
        halt;
      end;
    If paramcount=0 then
      begin
        writeln('Faltando parametro da localiza‡„o do ficheiro PASSWORD.CFG');;
        Delay(2000);
        Halt;
      end
    else
     begin
       Assign(arq,Paramstr(1));
       Reset(arq);
     end;
    Inicia_graficos;
    Readln(arq,s);
    dispositivo:=copy(s,1,1);
    Timerspeed:=copy(s,3,2);
    SBDMA:=copy(s,6,1);
    SBIRQ:=copy(s,8,1);
    SBPORT:=copy(s,10,3);
    Val(dispositivo,dis,erro);
    Val(Timerspeed,tim,erro);
    Val(sbdma,sbd,erro);
    Val(sbirq,sbi,erro);
    Val(sbport,sbp,erro);
    Readln(arq,s);
    Ficheiro_de_musica:=Copy(s,1,40);
    LoadOvl('GOLDPLAY.OVL');
    LoadModule(Ficheiro_de_musica);
    SetSys(dis,tim,sbd,sbi,sbp);
    Initialize;
    StartPlaying;
    Mastervolume(64);
    Cleardevice;
    Assign(fiche,'LAB_1.PIC');
    Reset(fiche);
    tam:=Imagesize(200,29,324,231);
    GetMem(p,tam);
    BlockRead(fiche,p^,tam,lidos);
    Close(fiche);
    Assign(fiche,'PRETO.IMG');
    Reset(fiche);
    tam:=Imagesize(200,29,324,231);
    PutImage(10+1,10+1,p^,0);
    Close(fiche);
    Assign(fiche,'LAB_2.PIC');
    Reset(fiche);
    tam:=Imagesize(200,29,324,231);
    BlockRead(fiche,p^,tam,lidos);
    close(fiche);
    assign(fiche,'PRETO.IMG');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    PutImage(10+1,60+1,p^,0);
    close(fiche);
    assign(fiche,'LAB_3.PIC');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    BlockRead(fiche,p^,tam,lidos);
    close(fiche);
    assign(fiche,'PRETO.IMG');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    PutImage(10+1,110+1,p^,0);
    close(fiche);
    assign(fiche,'LAB_4.PIC');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    BlockRead(fiche,p^,tam,lidos);
    close(fiche);
    assign(fiche,'PRETO.IMG');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    PutImage(10+1,160+1,p^,0);
    close(fiche);
    assign(fiche,'LAB_5.PIC');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    BlockRead(fiche,p^,tam,lidos);
    close(fiche);
    assign(fiche,'PRETO.IMG');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    PutImage(10+1,210+1,p^,0);
    close(fiche);
    assign(fiche,'LAB_6.PIC');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    BlockRead(fiche,p^,tam,lidos);
    close(fiche);
    assign(fiche,'PRETO.IMG');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    PutImage(10+1,260+1,p^,0);
    close(fiche);
    assign(fiche,'LAB_7.PIC');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    BlockRead(fiche,p^,tam,lidos);
    close(fiche);
    assign(fiche,'PRETO.IMG');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    PutImage(10+1,310+1,p^,0);
    close(fiche);
    assign(fiche,'LAB_8.PIC');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    BlockRead(fiche,p^,tam,lidos);
    close(fiche);
    assign(fiche,'PRETO.IMG');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    PutImage(10+1,360+1,p^,0);
    close(fiche);
    assign(fiche,'LAB_9.PIC');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    BlockRead(fiche,p^,tam,lidos);
    close(fiche);
    assign(fiche,'PRETO.IMG');
    reset(fiche);
    tam:=Imagesize(200,29,324,231);
    PutImage(10+1,410+1,p^,0);
    close(fiche);
    Setcolor(0);
    for a:= 0 to 100 do
      begin
        Rectangle(120+a,150+a,540-a,350-a);
      end;
    Setcolor(1);
    for a:= 0 to 100 do
      begin
        Rectangle(110+a,140+a,530-a,340-a);
      end;
    Setcolor(0);
    for a:= 0 to 40 do
      begin
        Rectangle(465+a,435+a,625-a,475-a);
      end;
    Setcolor(1);
    for a:= 0 to 40 do
      begin
        Rectangle(460+a,430+a,620-a,470-a);
      end;
    Setcolor(15);
    Settextstyle(0,0,0);
    Settextjustify(1,2);
    Outtextxy(320,160,'Laborat¢rio de Electricidade');
    Outtextxy(320,180,'Acesso restricto a utilizadores autorizados');
    Outtextxy(540,435,'Password V1.0');
    Outtextxy(540,450,'Fernando J.A. Silva');
    Outtextxy(540,460,'GL corp.');
    Nome:= RStrM(120,230,0,40,'','Nome : ',out,False);
    Nome:= RStrM(120,230,0,40,'','Nome : ',out,True);
    Readln(arq,s);
    utilizadores := copy(s,1,1);
    val(utilizadores,n_util,erro);
    For a:=1 to n_util do
      Begin
       Readln(arq,s);
       nome_do_utilizador := copy(s,1,40);
       If nome=nome_do_utilizador then
         Begin
           Codigo:= RStrM(120,260,0,40,'','C¢digo :',out,False);
           Codigo:= RStrM(120,260,0,40,'','C¢digo :',out,True);
           Close(arq);
           Assign(arq,Paramstr(1));
           Reset(arq);
           Readln(arq,s);
           utilizadores := copy(s,1,1);
           val(utilizadores,n_util,erro);
           For a:=1 to n_util+4 do Readln(arq,s);
           codigo_do_utilizador:=copy(s,1,40);
           If codigo=codigo_do_utilizador then
             Begin
              Setcolor(12);
              Settextjustify(1,2);
              Outtextxy(320,300,'Acesso Concedido');
              Delay(1500);
              StopPlaying;
              DeAlloc;
              RemoveOvl;
              Closegraph;
              Halt;
             End
            else
             Begin
              Setcolor(12);
              Settextjustify(1,2);
              Outtextxy(320,300,'Acesso Negado');
              Delay(1500);
              Setcolor(12);
              Outtextxy(320,310,'Reiniciando Sistema');
              Delay(1500);
              regs.ah:=$25;
              regs.al:=$19;
              regs.ds:=$ffff;
              regs.dx:=0;
              msdos (regs);
              intr ($19, regs)
             End;
          end;
         end;
    Setcolor(12);
    Settextjustify(1,2);
    Outtextxy(320,300,'Utilizador n„o reconhecido');
    Delay(1500);
    Setcolor(12);
    Outtextxy(320,310,'Reiniciando Sistema');
    Delay(1500);
    regs.ah:=$25;
    regs.al:=$19;
    regs.ds:=$ffff;
    regs.dx:=0;
    msdos (regs);
    intr ($19, regs);
    Closegraph;
  END.