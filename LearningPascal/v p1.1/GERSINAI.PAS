{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{|  PROGRAMA            => Geral V P÷1.1  Sinais                         |}
{*  PROGRAMADO EM       => Turbo Pascal 6.0                              *}
{|  AUTOR               => Fernando Jorge de Almeida da Silva            |}
{*  ENDERE€O            => Juncal - Assequins 3750 †gueda                *}
{|  TELEFONE            => (034) 602800                                  |}
{*  DATA DA PROGRAMA€ŽO => Setembro/95                                   *}
{|  COM PARTICIPA€ŽO DE =>                                               |}
{*                                                                       *}
{|  FUN€ŽO DO PROGRAMA  => Unit para o Geral                             |}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}



UNIT gersinai;

INTERFACE

{*-*-*-*-*-*-*-*-*-*-*-*-| PROCEDURES E FUN€™ES DA |-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| UNIT |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

FUNCTION InToStr(num:LONGINT;tam:INTEGER):STRING;
PROCEDURE Sinais_Indicacao;
PROCEDURE Sinais_Obrigacao;
PROCEDURE Sinais_Proibicao;
PROCEDURE Sinais_Perigo;
PROCEDURE Teste;

IMPLEMENTATION

USES
     TP,CRT,GRAPH;

{*-*-*-*-*-*-*-*-*-*-*-*|  FUNCTION QUE TRANSFORMA |-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-| UM N–MERO INTEIRO NUMA |-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-| STRING COM UM DETERMINADO TAMANHO |*-*-*-*-*-*-*-*-*-*}

FUNCTION InToStr(num:LONGINT;tam:INTEGER):STRING;

BEGIN
 STR(num,s);
 IF length(s) < tam THEN
   BEGIN
     MOVE(s[1], s[succ(tam - length(s))],length(s));
     FILLCHAR(s[1],tam - length(s),'0');
   end;
 s[0]:=char(tam);
 intostr:=s;
END;




{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| PERTENCENTE |*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| AOS |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| SINAIS |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{}
{}
{}{( 1 )*-*-*-*-*-*-*-*-*-*-*| PROCEDURE SINAIS DE  |*-*-*-*-*-*-*-*-*-*-*-*-}
{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| INDICA€ŽO |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{}
{}  PROCEDURE Sinais_Indicacao;
{.}
{.}   VAR
{.}       resp,pause :char;
          x1, y1, x2, y2 : Integer;
          fiche:file;
          p,pr:pointer;
          tam,aesc,esc,lidos:word;
          COR : word;

      BEGIN
        assign(fiche,'sinali01.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(20+10,10+10,p^,0);
        settextstyle(0,0,1);
        outtextxy(30,160,'Estacionamento');
        outtextxy(30,170,'  autorizado');
        close(fiche);
        pause:=readkey;

        freemem(p,tam);
        assign(fiche,'sinali02.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(250+10,10+10,p^,0);
        outtextxy(240,160,'Posto de primeiros');
        outtextxy(240,170,'    socorros');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinali03.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(450+10,10+10,p^,0);
        outtextxy(460,160,'Estacionamento au-');
        outtextxy(450,170,'torizado aos ve¡culos');
        outtextxy(460,180,'inscritos no sinal');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinali04.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(20+10,240+10,p^,0);
        outtextxy(0,390,'Estacionamento auto-');
        outtextxy(10,400,'rizado a ve¡culos');
        outtextxy(10,410,'de uma Embaixada');
        close(fiche);
        pause:=READKEY;

        assign(fiche,'sinali05.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(250+10,240+10,p^,0);
        outtextxy(260,390,'  Velocidade');
        outtextxy(260,400,'  recomendada');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinali06.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(450+10,240+10,p^,0);
        outtextxy(460,390,'Estrada sem sa¡da');
        outtextxy(450,400,'   para ve¡culos');
        close(fiche);

                for cor:=0 to getmaxcolor do
                    begin
                         repeat
                          outtextxy(470,430,'Prima uma tecla...');
                          Setcolor(Random(GetMaxColor + 1));
                          delay(80);
                         until KeyPressed;
                     END;

        cleardevice;
        pause:=READKEY;
        freemem(p,tam);
        assign(fiche,'sinali07.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(20+10,10+10,p^,0);
        setcolor(15);
        outtextxy(20,160,'Fim de velocidade');
        outtextxy(20,170,'   recomendada');
        close(fiche);
        pause:=readkey;

        freemem(p,tam);
        assign(fiche,'sinali08.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(250+10,10+10,p^,0);
        outtextxy(240,160,'');                 {falta identifica‡ao de sinal}
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinali09.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(450+10,10+10,p^,0);
        outtextxy(460,160,'Parque de campismo');
        outtextxy(460,170,'     a 300m');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinali10.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(20+10,240+10,p^,0);
        outtextxy(30,390,' Parque de reboques');
        outtextxy(30,400,'    de campismo');
        outtextxy(30,410,'      a 300m');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinali11.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(250+10,240+10,p^,0);
        outtextxy(255,390,'Posto de primeiros');
        outtextxy(260,400,'    socorros');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinali12.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(450+10,240+10,p^,0);
        outtextxy(460,390,'Trƒnsito de sentido');
        outtextxy(460,400,'      £nico');
        close(fiche);

                for cor:=0 to getmaxcolor do
                     begin
                         repeat
                          outtextxy(470,430,'Prima uma tecla...');
                          Setcolor(Random(GetMaxColor + 1));
                          delay(80);
                         until KeyPressed;
                     END;

        cleardevice;
        pause:=READKEY;
        freemem(p,tam);
        assign(fiche,'sinalidl.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(20+10,10+10,p^,0);
{.}     setcolor(15);
{.}     outtextxy(20,160,'Fim de velocidade');
{.}     outtextxy(20,170,'   recomendada');
{}      close(fiche);
{}      pause:=readkey;
{}    END;
{}{( 2 )*-*-*-*-*-*-*-*-*-*-*| PROCEDURE SINAIS DE  |*-*-*-*-*-*-*-*-*-*-*-*-}
{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| OBRIGA€ŽO |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{}
{}  PROCEDURE Sinais_Obrigacao;
{.}
{.}   VAR
{.}       resp,pause :char;
          x1, y1, x2, y2 : Integer;
          fiche:file;
          p,pr:pointer;
          tam,aesc,esc,lidos:word;
          COR : word;

      BEGIN
        assign(fiche,'sinalo01.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(20+10,10+10,p^,0);
        outtextxy(30,160,'Estacionamento');
        outtextxy(30,170,'  autorizado');
        close(fiche);
        pause:=readkey;

        freemem(p,tam);
        assign(fiche,'sinalo02.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(250+10,10+10,p^,0);
        outtextxy(240,160,'Posto de primeiros');
        outtextxy(240,170,'    socorros');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalo03.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(450+10,10+10,p^,0);
        outtextxy(460,160,'Estacionamento au-');
        outtextxy(450,170,'torizado aos ve¡culos');
        outtextxy(460,180,'inscritos no sinal');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalo04.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(20+10,240+10,p^,0);
        outtextxy(0,390,'Estacionamento auto-');
        outtextxy(10,400,'rizado a ve¡culos');
        outtextxy(10,410,'de uma Embaixada');
        close(fiche);
        pause:=READKEY;

        assign(fiche,'sinalo05.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(250+10,240+10,p^,0);
        outtextxy(260,390,'  Velocidade');
{.}     outtextxy(260,400,'  recomendada');
{.}     close(fiche);
{}      pause:=READKEY;
{}    END;
{}{( 3 )*-*-*-*-*-*-*-*-*-*-*| PROCEDURE SINAIS DE  |*-*-*-*-*-*-*-*-*-*-*-*-}
{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| PROIBI€ŽO |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{}
{}  PROCEDURE Sinais_Proibicao;
{.}
{.}   VAR
{.}       resp,pause :char;
          x1, y1, x2, y2 : Integer;
          fiche:file;
          p,pr:pointer;
          tam,aesc,esc,lidos:word;
          COR : word;

      BEGIN
        assign(fiche,'sinalp01.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(20+10,10+10,p^,0);
        outtextxy(30,160,'Estacionamento');
        outtextxy(30,170,'  autorizado');
        close(fiche);
        pause:=readkey;

        freemem(p,tam);
        assign(fiche,'sinalp02.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(250+10,10+10,p^,0);
        outtextxy(240,160,'Posto de primeiros');
        outtextxy(240,170,'    socorros');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp03.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(450+10,10+10,p^,0);
        outtextxy(460,160,'Estacionamento au-');
        outtextxy(450,170,'torizado aos ve¡culos');
        outtextxy(460,180,'inscritos no sinal');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp04.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(20+10,240+10,p^,0);
        outtextxy(0,390,'Estacionamento auto-');
        outtextxy(10,400,'rizado a ve¡culos');
        outtextxy(10,410,'de uma Embaixada');
        close(fiche);
        pause:=READKEY;

        assign(fiche,'sinalp05.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(250+10,240+10,p^,0);
        outtextxy(260,390,'  Velocidade');
        outtextxy(260,400,'  recomendada');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp06.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(450+10,240+10,p^,0);
        outtextxy(460,390,'Estrada sem sa¡da');
        outtextxy(450,400,'   para ve¡culos');
        close(fiche);

                for cor:=0 to getmaxcolor do
                    begin
                         repeat
                          outtextxy(470,430,'Prima uma tecla...');
                          Setcolor(Random(GetMaxColor + 1));
                          delay(80);
                         until KeyPressed;
                     END;

        cleardevice;
        pause:=READKEY;
        freemem(p,tam);
        assign(fiche,'sinalp07.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(20+10,10+10,p^,0);
        setcolor(15);
        outtextxy(20,160,'Fim de velocidade');
        outtextxy(20,170,'   recomendada');
        close(fiche);
        pause:=readkey;

        freemem(p,tam);
        assign(fiche,'sinalp08.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(250+10,10+10,p^,0);
        outtextxy(240,160,'');                 {falta identifica‡ao de sinal}
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp09.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(450+10,10+10,p^,0);
        outtextxy(460,160,'Parque de campismo');
        outtextxy(460,170,'     a 300m');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp10.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(20+10,240+10,p^,0);
        outtextxy(30,390,' Parque de reboques');
        outtextxy(30,400,'    de campismo');
        outtextxy(30,410,'      a 300m');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp11.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(250+10,240+10,p^,0);
        outtextxy(255,390,'Posto de primeiros');
        outtextxy(260,400,'    socorros');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp12.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(450+10,240+10,p^,0);
        outtextxy(460,390,'Trƒnsito de sentido');
        outtextxy(460,400,'      £nico');
        close(fiche);

                for cor:=0 to getmaxcolor do
                     begin
                         repeat
                          outtextxy(470,430,'Prima uma tecla...');
                          Setcolor(Random(GetMaxColor + 1));
                          delay(80);
                         until KeyPressed;
                     END;

        cleardevice;
        pause:=READKEY;
        freemem(p,tam);
        assign(fiche,'sinalp13.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(20+10,10+10,p^,0);
        setcolor(15);
        outtextxy(20,160,'Fim de velocidade');
        outtextxy(20,170,'   recomendada');
        close(fiche);
        pause:=readkey;

        freemem(p,tam);
        assign(fiche,'sinalp15.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(250+10,10+10,p^,0);
        outtextxy(240,160,'');                 {falta identifica‡ao de sinal}
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp16.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(450+10,10+10,p^,0);
        outtextxy(460,160,'Parque de campismo');
        outtextxy(460,170,'     a 300m');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp17.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(20+10,240+10,p^,0);
        outtextxy(30,390,' Parque de reboques');
        outtextxy(30,400,'    de campismo');
        outtextxy(30,410,'      a 300m');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp18.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(250+10,240+10,p^,0);
        outtextxy(255,390,'Posto de primeiros');
        outtextxy(260,400,'    socorros');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp19.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(450+10,240+10,p^,0);
        outtextxy(460,390,'Trƒnsito de sentido');
        outtextxy(460,400,'      £nico');
        close(fiche);

                for cor:=0 to getmaxcolor do
                     begin
                         repeat
                          outtextxy(470,430,'Prima uma tecla...');
                          Setcolor(Random(GetMaxColor + 1));
                          delay(80);
                         until KeyPressed;
                     END;

        cleardevice;
        pause:=READKEY;
        freemem(p,tam);
        assign(fiche,'sinalp20.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(20+10,10+10,p^,0);
        setcolor(15);
        outtextxy(20,160,'Fim de velocidade');
        outtextxy(20,170,'   recomendada');
        close(fiche);
        pause:=readkey;

        freemem(p,tam);
        assign(fiche,'sinalp21.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(250+10,10+10,p^,0);
        outtextxy(240,160,'');                 {falta identifica‡ao de sinal}
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp22.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(450+10,10+10,p^,0);
        outtextxy(460,160,'Parque de campismo');
        outtextxy(460,170,'     a 300m');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp23.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(20+10,240+10,p^,0);
        outtextxy(30,390,' Parque de reboques');
        outtextxy(30,400,'    de campismo');
        outtextxy(30,410,'      a 300m');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp24.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(250+10,240+10,p^,0);
        outtextxy(255,390,'Posto de primeiros');
        outtextxy(260,400,'    socorros');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalp25.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
{.}     PutImage(450+10,240+10,p^,0);
{.}     outtextxy(460,390,'Trƒnsito de sentido');
{.}     outtextxy(460,400,'      £nico');
{}      close(fiche);
{}    END;
{}{( 4 )*-*-*-*-*-*-*-*-*-*-*| PROCEDURE SINAIS DE  |*-*-*-*-*-*-*-*-*-*-*-*-}
{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| PERIGO |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{}
{}  PROCEDURE Sinais_Perigo;
{.}
{.}   VAR
{.}       resp,pause :char;
          x1, y1, x2, y2 : Integer;
          fiche:file;
          p,pr:pointer;
          tam,aesc,esc,lidos:word;
          COR : word;

      BEGIN
        assign(fiche,'sinalt01.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(pr,tam);
        PutImage(20+10,10+10,p^,0);
        outtextxy(30,160,'Estacionamento');
        outtextxy(30,170,'  autorizado');
        close(fiche);
        pause:=readkey;

        freemem(p,tam);
        assign(fiche,'sinalt02.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(250+10,10+10,p^,0);
        outtextxy(240,160,'Posto de primeiros');
        outtextxy(240,170,'    socorros');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalt05.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(450+10,10+10,p^,0);
        outtextxy(460,160,'Estacionamento au-');
        outtextxy(450,170,'torizado aos ve¡culos');
        outtextxy(460,180,'inscritos no sinal');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalt06.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(20+10,240+10,p^,0);
        outtextxy(0,390,'Estacionamento auto-');
        outtextxy(10,400,'rizado a ve¡culos');
        outtextxy(10,410,'de uma Embaixada');
        close(fiche);
        pause:=READKEY;

        assign(fiche,'sinalt09.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(250+10,240+10,p^,0);
        outtextxy(260,390,'  Velocidade');
        outtextxy(260,400,'  recomendada');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalt11.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(450+10,240+10,p^,0);
        outtextxy(460,390,'Estrada sem sa¡da');
        outtextxy(450,400,'   para ve¡culos');
        close(fiche);

                for cor:=0 to getmaxcolor do
                    begin
                         repeat
                          outtextxy(470,430,'Prima uma tecla...');
                          Setcolor(Random(GetMaxColor + 1));
                          delay(80);
                         until KeyPressed;
                     END;

        cleardevice;
        pause:=READKEY;
        freemem(p,tam);
        assign(fiche,'sinalt12.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(20+10,10+10,p^,0);
        setcolor(15);
        outtextxy(20,160,'Fim de velocidade');
        outtextxy(20,170,'   recomendada');
        close(fiche);
        pause:=readkey;

        freemem(p,tam);
        assign(fiche,'sinalt13.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(250+10,10+10,p^,0);
        outtextxy(240,160,'');                 {falta identifica‡ao de sinal}
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalt14.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(450+10,10+10,p^,0);
        outtextxy(460,160,'Parque de campismo');
        outtextxy(460,170,'     a 300m');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalt15.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(20+10,240+10,p^,0);
        outtextxy(30,390,' Parque de reboques');
        outtextxy(30,400,'    de campismo');
        outtextxy(30,410,'      a 300m');
        close(fiche);
        pause:=READKEY;

        freemem(p,tam);
        assign(fiche,'sinalt16.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        GetMem(p,tam);
        BlockRead(fiche,p^,tam,lidos);
        close(fiche);
        assign(fiche,'preto.img');
        reset(fiche);
        tam:=Imagesize(200,29,324,231);
        PutImage(250+10,240+10,p^,0);
{.}     outtextxy(255,390,'Posto de primeiros');
{.}     outtextxy(260,400,'    socorros');
{.}     close(fiche);
{}      pause:=READKEY;
{}    END;
{}{( 5 )*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE TESTE  |*-*-*-*-*-*-*-*-*-*-*-*-*-}
{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*|  |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{}
{}  PROCEDURE Teste;
{.}
{.}   VAR
{.}     k,certas,erradas : Integer;
        pause :char;
        resp:string;
        x1, y1, x2, y2 : Integer;
        s:STRING;

    BEGIN
      certas:=0;
      erradas:=0;
                 { In¡cio do Teste }
      settextstyle(3,0,3);
      outtextxy(175,1,'TESTE A_1');
      setcolor(7);
      settextstyle(2,0,5);
      outtextxy(20,35,'Para efeitos do c¢digo da estrada, considera-se faixa de rodagem: ');
      settextstyle(2,0,4);
      setcolor(15);
      outtextxy(40,50,'1- A parte da via destinada ao trƒnsito de ve¡culos.');
      outtextxy(40,60,'2- A linha longitudinal que divide a via em duas partes sendo cada uma no sentido oposto ao da outra.');
      outtextxy(40,70,'3- A parte da via destinada ao trƒnsito de ve¡culos e pe”es.');
      outtextxy(40,80,'4- A parte da via destinada ao trƒnsito de animais e pe”es.');
  repeat
   resp:=upcase(readkey);
   until((resp = '1') or (resp ='2') or (resp ='3') or (resp='4'));
   if resp='1' then
      begin
           certas:=certas+1;
           setcolor(9);
           outtextxy(40,50,'1');
      end;
   if resp='2' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,60,'2');
           delay(3000);
           setcolor(12);
           outtextxy(40,60,'2');
           setcolor(9);
           outtextxy(40,50,'1');
      end;
   if resp='3' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,70,'3');
           delay(3000);
           setcolor(12);
           outtextxy(40,70,'3');
           setcolor(9);
           outtextxy(40,50,'1');
      end;
   if resp='4' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,80,'4');
           delay(3000);
           setcolor(12);
           outtextxy(40,80,'4');
           setcolor(9);
           outtextxy(40,50,'1');
      end;
   settextstyle(0,0,1);
   setcolor(13);
   outtextxy(470,460, 'Pressione Uma Tecla');
   pause:=readkey;
   setcolor(0); outtextxy(470,460,'Pressione Uma Tecla');
      setcolor(7);
      settextstyle(2,0,5);
      outtextxy(20,90,'Os condutores poder„o inverter o sentido de marcha numa ponte?');
      settextstyle(2,0,4);
      setcolor(15);
      outtextxy(40,105,'5- Sim, desde que o condutor fa‡a os sinais regulamentares.');
      outtextxy(40,115,'6- N„o, neste local nunca podem inverter o sentido de marcha.');
      outtextxy(40,125,'7- Sim, desde que no mesmo sentido sejam poss¡veis duas ou mais filas de tr fego.');
      outtextxy(40,135,'8- Sim, desde que haja largura e visibilidade suficiente.');
  repeat
   resp:=upcase(readkey);
   until((resp = '5') or (resp ='6') or (resp ='7') or (resp='8'));
   if resp='5' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,105,'5');
           delay(3000);
           setcolor(12);
           outtextxy(40,105,'5');
      end;
   if resp='6' then
      begin
           certas:=certas+1;
           setcolor(9);
           outtextxy(40,115,'6');
      end;
   if resp='7' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,125,'7');
           delay(3000);
           setcolor(12);
           outtextxy(40,125,'7');
      end;
   if resp='8' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,135,'8');
           delay(3000);
           setcolor(12);
           outtextxy(40,135,'8');
      end;
   settextstyle(0,0,1);
   setcolor(12);
   outtextxy(470,460, 'Pressione Uma Tecla');
   pause:=readkey;
   setcolor(0); outtextxy(470,460,'Pressione Uma Tecla');
   setcolor(7);
   settextstyle(2,0,5);
   outtextxy(20,145,'Qual a velociade m xima, nas auto-estradas, para os autom. ligeiros de passageiros sem reboque?');
   settextstyle(2,0,4);
   setcolor(15);
   outtextxy(40,160,'9- 60 Km/h.');
   outtextxy(40,170,'10- 90 Km/h.');
   outtextxy(40,180,'11- 120 Km/h.');
   outtextxy(40,190,'12- N„o tem limite fixado.');
  repeat
  begin
     settextstyle(0,0,1);outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
     textcolor(0);
     settextstyle(2,0,4);
     read(resp);
     setcolor(0);settextstyle(0,0,1);outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
  end;
  until((resp = '9') or (resp ='10') or (resp ='11') or (resp='12'));
  settextstyle(2,0,4);
   if resp='9' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,160,'9');
           delay(3000);
           setcolor(12);
           outtextxy(40,160,'9');

      end;
   if resp='10' then
      begin
            erradas:=erradas+1;
            setcolor(9);
            outtextxy(40,170,'10');
            delay(3000);
            setcolor(12);
            outtextxy(40,170,'10');
      end;
   if resp='11' then
      begin
           certas:=certas+1;
           setcolor(9);
           outtextxy(40,180,'11');
      end;
   if resp='12' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,190,'12');
           delay(3000);
           setcolor(12);
           outtextxy(40,190,'12');
      end;
   settextstyle(0,0,1);
   setcolor(13);
   outtextxy(470,460,'Pressione Uma Tecla');
   pause:=readkey;
   setcolor(0); outtextxy(470,460,'Pressione Uma Tecla');
   setcolor(7);
   settextstyle(2,0,5);
   outtextxy(20,200,'Regra geral, por onde devem trƒnsitar os ve¡culos?');
   settextstyle(2,0,4);
   setcolor(15);
   outtextxy(40,215,'13- Sempre junto ao eixo da via, sem utilizar o lado esquerdo da faixa de rodagem.');
   outtextxy(40,225,'14- Pela direita, o mais pr¢ximo das bermas ou passeios, a uma distƒncia que permita evitar');
   outtextxy(577,225,'qualquer');
   outtextxy(1,235,'acidente.');
   outtextxy(40,245,'15- Pela direita, o mais pr¢ximo das bermas ou passeios, ou junto ao eixo da via, sem utilizar');
   outtextxy(590,245,'o lado');
   outtextxy(1,255,'esquerdo da faixa de rodagem.');
   outtextxy(40,265,'16- Pela direita ou pela esquerda da faixa de rodagem, se a via for de um s¢ sentido.');
  repeat
  begin
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
     textcolor(0);
     settextstyle(2,0,4);
     READLN(resp);
  end;
  until((resp ='13') or (resp ='14') or (resp ='15') or (resp='16'));
    setcolor(0);
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
  settextstyle(2,0,4);
   if resp='13' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,215,'13');
           delay(3000);
           setcolor(12);
           outtextxy(40,215,'13');
      end;
   if resp='14' then
      begin
           certas:=certas+1;
           setcolor(9);
           outtextxy(40,225,'14');
      end;
   if resp='15' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,245,'15');
           delay(3000);
           setcolor(12);
           outtextxy(40,245,'15');
      end;
   if resp='16' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,265,'16');
           delay(3000);
           setcolor(12);
           outtextxy(40,265,'16');
      end;
   settextstyle(0,0,1);
   setcolor(13);
   outtextxy(470,460,'Pressione Uma Tecla');
   pause:=readkey;
   setcolor(0); outtextxy(470,460,'Pressione Uma Tecla');
                       {Pergunta n§ 5}
      setcolor(7);
   settextstyle(2,0,5);
   outtextxy(20,275,'Numa auto-estrada o condutor pode prosseguir a sua marcha sem luzes, por motivo');
   outtextxy(1,285,'destas se terem avariado?');
   settextstyle(2,0,4);
   setcolor(15);
   outtextxy(40,300,'17- N„o, porque ‚ proibido circular de noite nas auto-estradas.');
   outtextxy(40,310,'18- Sim, desde que n„o exceda os 30 Km/h.');
   outtextxy(40,320,'19- N„o, porque ‚ pro¡bido circular de noite, sem luzes, na auto-estrada, devendo ser retirado da');
   outtextxy(1,330,'faixa de rodagem em caso de avaria de luzes.');
   outtextxy(40,340,'20- Sim, porque as auto-estradas s„o suficientemente iluminadas.');
  repeat
  begin
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
     textcolor(0);
     settextstyle(2,0,4);
     READLN(resp);
  end;
  until((resp ='17') or (resp ='18') or (resp ='19') or (resp='20'));
    setcolor(0);
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
  settextstyle(2,0,4);
   if resp='17' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,300,'17');
           delay(3000);
           setcolor(12);
           outtextxy(40,300,'17');
      end;
   if resp='18' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,310,'18');
           delay(3000);
           setcolor(12);
           outtextxy(40,310,'18');
      end;
   if resp='19' then
      begin
           certas:=certas+1;
           setcolor(9);
           outtextxy(40,320,'19');
      end;
   if resp='20' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,340,'20');
           delay(3000);
           setcolor(12);
           outtextxy(40,340,'20');
      end;
   settextstyle(0,0,1);
   setcolor(13);
   outtextxy(470,460,'Pressione Uma Tecla');
   pause:=readkey;
   setcolor(0); outtextxy(470,460,'Pressione Uma Tecla');
                           { Pergunta n§ 6 }
   setcolor(7);
   settextstyle(2,0,5);
   outtextxy(20,345,'Quanto tempo pode parar, num local de estacionamento proibido, um autom¢vel de mercadorias?');
   settextstyle(2,0,4);
   setcolor(15);
   outtextxy(40,360,'21- N„o mais de 30 minutos.');
   outtextxy(40,370,'22- N„o pode parar tempo algum.');
   outtextxy(40,380,'23- Pode parar o tempo que o condutor quizer.');
   outtextxy(40,390,'24- O tempo indespens vel para fazer cargas ou descargas.');
  repeat
  begin
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
     textcolor(0);
     settextstyle(2,0,4);
     READLN(resp);
  end;
  until((resp ='21') or (resp ='22') or (resp ='23') or (resp='24'));
    setcolor(0);
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
  settextstyle(2,0,4);
   if resp='21' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,360,'21');
           delay(3000);
           setcolor(12);
           outtextxy(40,360,'21');
      end;
   if resp='22' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,370,'22');
           delay(3000);
           setcolor(12);
           outtextxy(40,370,'22');
      end;
   if resp='23' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,380,'23');
           delay(3000);
           setcolor(12);
           outtextxy(40,380,'23');
      end;
   if resp='24' then
      begin
           certas:=certas+1;
           setcolor(9);
           outtextxy(40,390,'24');
      end;
   settextstyle(0,0,1);
   setcolor(13);
   outtextxy(470,460,'Pressione Uma Tecla');
   pause:=readkey;
   setcolor(0); outtextxy(470,460,'Pressione Uma Tecla');
   setcolor(7);
   settextstyle(2,0,5);
   outtextxy(20,405,'Qual a luz que os tractores agr¡colas devem manter acesas sempre que circulem na via p£blica?');
   settextstyle(2,0,4);
   setcolor(15);
   outtextxy(40,420,'25- As luzes m ximas.');
   outtextxy(40,430,'26- As luzes m‚dias tal como os motociclos.');
   outtextxy(40,440,'27- As luzes m¡nimas.');
   outtextxy(40,450,'28- Um farol de luz amarela, rotativa ou intermitente colocada na sua parte superior.');
  repeat
  begin
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
     textcolor(0);
     settextstyle(2,0,4);
     READLN(resp);
  end;
  until((resp ='25') or (resp ='26') or (resp ='27') or (resp='28'));
    setcolor(0);
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
  settextstyle(2,0,4);
   if resp='25' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,420,'25');
           delay(3000);
           setcolor(12);
           outtextxy(40,420,'25');
      end;
   if resp='26' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,430,'26');
           delay(3000);
           setcolor(12);
           outtextxy(40,430,'26');
      end;
   if resp='27' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,440,'27');
           delay(3000);
           setcolor(12);
           outtextxy(40,440,'27');
      end;
   if resp='28' then
      begin
           certas:=certas+1;
           setcolor(9);
           outtextxy(40,450,'28');
      end;
   settextstyle(0,0,1);
   setcolor(13);
   outtextxy(470,460,'Pressione Uma Tecla');
   pause:=readkey;
   setcolor(0); outtextxy(470,460,'Pressione Uma Tecla');
   cleardevice;
   setcolor(7);
   settextstyle(2,0,5);
   outtextxy(20,35,'Quais dos seguintes ve¡culos pode conduzir o condutor que seja titular da carta');
   outtextxy(1,45,'de condu‡„o de autom¢veis ligeiros?');
   settextstyle(2,0,4);
   setcolor(15);
   outtextxy(40,55,'29- Autom¢veis ligeiros, tractores agr¡colas sem reboque de tara n„o superior a 3.500Kgs.');
   outtextxy(40,70,'30- Motociclos com carro e autom¢veis ligeiros.');
outtextxy(40,80,'31-Autom¢veis ligeiros e tractores agr¡colas com reboque de peso bruto do conjto inferior a');
outtextxy(1,85,'8000Kg.');
   outtextxy(40,95,'32- Autom¢veis ligeiros e pesados de aluguer.');
  repeat
  begin
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
     textcolor(0);
     settextstyle(2,0,4);
     READLN(resp);
  end;
  until((resp ='29') or (resp ='30') or (resp ='31') or (resp='32'));
    setcolor(0);
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
  settextstyle(2,0,4);
   if resp='29' then
      begin
           certas:=certas+1;
           setcolor(9);
           outtextxy(40,35,'29');
      end;
   if resp='30' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,55,'30');
           delay(3000);
           setcolor(12);
           outtextxy(40,55,'30');
      end;
   if resp='31' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,70,'31');
           delay(3000);
           setcolor(12);
           outtextxy(40,70,'31');
      end;
   if resp='32' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,95,'32');
           delay(3000);
           setcolor(12);
           outtextxy(40,95,'32');
      end;
   settextstyle(0,0,1);
   setcolor(13);
   outtextxy(470,460,'Pressione Uma Tecla');
   pause:=readkey;
   setcolor(0); outtextxy(470,460,'Pressione Uma Tecla');
   cleardevice;
   setcolor(7);
   settextstyle(2,0,5);
   outtextxy(20,90,'Que indica a luz amarela constante dos sinais luminosos?');
   settextstyle(2,0,4);
   setcolor(15);
   outtextxy(40,105,'33- Paragem obrigat¢ria.');
   outtextxy(40,115,'34- A transi‡„o da luz verde para a vermelha.');
   outtextxy(40,125,'35- A autoriza‡„o para ultrapassar.');
   outtextxy(40,135,'36- A conveniˆncia em aumentar a velocidade.');
  repeat
  begin
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
     textcolor(0);
     settextstyle(2,0,4);
     READLN(resp);
  end;
  until((resp ='33') or (resp ='34') or (resp ='35') or (resp='36'));
    setcolor(0);
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
  settextstyle(2,0,4);
   if resp='33' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,105,'33');
           delay(3000);
           setcolor(12);
           outtextxy(40,105,'33');
      end;
   if resp='34' then
      begin
           certas:=certas+1;
           setcolor(9);
           outtextxy(40,115,'34');
      end;
   if resp='35' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,125,'35');
           delay(3000);
           setcolor(12);
           outtextxy(40,125,'35');
      end;
   if resp='36' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,135,'36');
           delay(3000);
           setcolor(12);
           outtextxy(40,135,'36');
      end;
   settextstyle(0,0,1);
   setcolor(13);
   outtextxy(470,460,'Pressione Uma Tecla');
   pause:=readkey;
   setcolor(0); outtextxy(470,460,'Pressione Uma Tecla');
   cleardevice;
   setcolor(7);
   settextstyle(2,0,5);
   outtextxy(20,145,'Por que lado os passageiros devem entrar e sair num autom¢vel ligeiro?');
   settextstyle(2,0,4);
   setcolor(15);
   outtextxy(40,160,'37- Pela esquerda quando o volante ‚ do lado esquerdo.');
   outtextxy(40,170,'38- Pela direita incluindo o condutor quando o volante ‚ … esquerda.');
   outtextxy(40,180,'39- Pela direita com excep‡„o do condutor.');
   outtextxy(40,190,'40- Por qualquer lado.');
  repeat
  begin
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
     textcolor(0);
     settextstyle(2,0,4);
     READLN(resp);
  end;
  until((resp ='37') or (resp ='38') or (resp ='39') or (resp='40'));
    setcolor(0);
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
  settextstyle(2,0,4);
   if resp='37' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,160,'37');
           delay(3000);
           setcolor(12);
           outtextxy(40,160,'37');
      end;
   if resp='38' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,170,'38');
           delay(3000);
           setcolor(12);
           outtextxy(40,170,'38');
      end;
   if resp='39' then
      begin
           certas:=certas+1;
           setcolor(9);
           outtextxy(40,180,'39');
      end;
   if resp='40' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,190,'40');
           delay(3000);
           setcolor(12);
           outtextxy(40,190,'40');
      end;
   settextstyle(0,0,1);
   setcolor(13);
   outtextxy(470,460,'Pressione Uma Tecla');
   pause:=readkey;
   setcolor(0); outtextxy(470,460,'Pressione Uma Tecla');
   cleardevice;
   setcolor(7);
   settextstyle(2,0,5);
   outtextxy(20,200,'Quando ‚ que o condutor de autom¢veis pesados deve utilizar o motor como auxiliar');
   outtextxy(1,210,'do trav„o?');
   settextstyle(2,0,4);
   setcolor(15);
   outtextxy(40,225,'41- No atravessamento de pontes, t£neis e passagens de n¡vel.');
   outtextxy(40,245,'42- Nas descidas de inclina‡„o acentuada.');
   outtextxy(40,255,'43- Nas subidas de forte inclina‡„o.');
   outtextxy(40,265,'44- Nas manobras dif¡ceis.');
  repeat
  begin
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
     textcolor(0);
     settextstyle(2,0,4);
     READLN(resp);
  end;
  until((resp ='41') or (resp ='42') or (resp ='43') or (resp='44'));
    setcolor(0);
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
  settextstyle(2,0,4);
   if resp='41' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,225,'41');
           delay(3000);
           setcolor(12);
           outtextxy(40,225,'41');
      end;
   if resp='42' then
      begin
           certas:=certas+1;
           setcolor(9);
           outtextxy(40,445,'42');
      end;
   if resp='43' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,255,'43');
           delay(3000);
           setcolor(12);
           outtextxy(40,255,'43');
      end;
   if resp='44' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,265,'44');
           delay(3000);
           setcolor(12);
           outtextxy(40,265,'44');
      end;
   settextstyle(0,0,1);
   setcolor(13);
   outtextxy(470,460,'Pressione Uma Tecla');
   pause:=readkey;
   setcolor(0); outtextxy(470,460,'Pressione Uma Tecla');
   cleardevice;
   setcolor(7);
   settextstyle(2,0,5);
   outtextxy(20,275,'Que se entende por invers„o de sentido de marcha?');
   settextstyle(2,0,4);
   setcolor(15);
   outtextxy(40,300,'45- Virar para a esquerda.');
   outtextxy(40,315,'46- Virar para a direita.');
   outtextxy(40,330,'47-  o in¡cio de qualquer manobra.');
   outtextxy(40,340,'48- Rodar de meia roda para ficar voltado no sentido contr rio.');
  repeat
  begin
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
     textcolor(0);
     settextstyle(2,0,4);
     READLN(resp);
  end;
  until((resp ='45') or (resp ='46') or (resp ='47') or (resp='48'));
    setcolor(0);
     settextstyle(0,0,1);
     outtextxy(170,460,'Pressione a tecla ENTER depois de indicar a resposta.');
  settextstyle(2,0,4);
   if resp='45' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,300,'45');
           delay(3000);
           setcolor(12);
           outtextxy(40,300,'45');
      end;
   if resp='46' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,315,'46');
           delay(3000);
           setcolor(12);
           outtextxy(40,315,'46');
      end;
   if resp='47' then
      begin
           erradas:=erradas+1;
           setcolor(9);
           outtextxy(40,330,'47');
           delay(3000);
           setcolor(12);
           outtextxy(40,330,'47');
      end;
   if resp='48' then
      begin
           certas:=certas+1;
           setcolor(9);
           outtextxy(40,340,'48');
      end;
   settextstyle(0,0,1);
   setcolor(13);
   outtextxy(470,460,'Pressione Uma Tecla');
   pause:=readkey;
   setcolor(0); outtextxy(470,460,'Pressione Uma Tecla');
   cleardevice;
   setcolor(15);
   settextstyle(3,0,2);
   outtextxy(200,100,'RESULTADO DO TESTE: ');
   settextstyle(2,0,5);
   setcolor(2);
   outtextxy(250,200,'Certas: '+intostr(certas,2));
   setcolor(4);
   outtextxy(250,220,'Erradas: '+intostr(erradas,2));
{.}pause:=READKEY;
{.}
{}
{} END;
{-----------------------------------------------------------------------------}

BEGIN

END.