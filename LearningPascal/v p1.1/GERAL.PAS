{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{|  PROGRAMA            => Geral v P˜1.1                                   |}
{*  PROGRAMADO EM       => Turbo Pascal 7.0                                *}
{|  AUTOR               => Fernando Jorge de Almeida da Silva              |}
{*  ENDEREÄO            => Juncal - Assequins 3750 Ügueda                  *}
{|  TELEFONE            => (034) 602800                                    |}
{*  DATA DA PROGRAMAÄéO => Setembro/95                                     *}
{|  FUNÄéO DO PROGRAMA  => Programa Principal                              |}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROGRAM Geral_V1_1;
USES
    TP,CRT,GRAPH,DOS,DRIVERS,OBJECTS,GERINTRO,GERSINAI;


TYPE
    QUADRADO=(NULO,_O_,_X_);
    JOGADOR=(__O__,__X__);

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| CONSTANTES |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| GLOBAIS |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

CONST
      gd   : INTEGER = 9;
      gm   : INTEGER = 2;
      dias :ARRAY[0..6] OF STRING[7] =
      ('Domingo','Segunda','Teráa','Quarta','Quinta','Sexta','S†bado');
   cr = #13;
   esc = #27;
   bs = #08;
   up = $4800;
   down = $5000;
   left = $4B00;
   right = $4D00;
   pgup = $4900;
   pgdown = $5100;
   home = $4700;
   ends = $4F00;
   insert = $5200;
   delete = $5300;
 {---- Pertencente ao Jogo do Galo ----}
   COR_O=2;
   COR_X=4;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| VARIÜVEIS |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| GLOBAIS |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

VAR
      a,i,x,y,c :INTEGER;
      pause,resp:CHAR;
      x1,x2,y1,y2:INTEGER;
      nome_s :STRING[10];
      codigo_s :STRING[5];
      dia,mes,ano,d_s,hora,minuto,segundo,hund:WORD;
      ch       :CHAR;
      tempo    :WORD;
      year,month,day,dow:word;
      s     :STRING;
      cont  :INTEGER;
 {---- Pertencente ao Jogo do Galo ----}
      H,J:SHORTINT;
      PATH:DIRSTR;
      NAME:NAMESTR;
      EXT:EXTSTR;
      MAT:ARRAY[1..3,1..3] OF QUADRADO;
      JOG:JOGADOR;
      FINDOU,AINDA_NAO:BOOLEAN;
      JOGOS_GANHOS:ARRAY[JOGADOR] OF WORD;



{*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURES DECLARADAS |*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| MAIS Ü FRENTE |*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

PROCEDURE Menu_principal;FORWARD;
PROCEDURE musica;FORWARD;
PROCEDURE opcoes;FORWARD;
PROCEDURE sinais;FORWARD;
PROCEDURE jogos;FORWARD;
PROCEDURE PRINCIPAL;FORWARD;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| SOM |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE som_1;
BEGIN
  DELAY(150);
  SND(900,150);SND(800,150);SND(700,150);SND(600,150);SND(500,150);SND(400,150);
  SND(300,150);SND(400,150);SND(500,150);SND(600,150);SND(700,150);SND(800,150);
  SND(900,150);SND(1000,150);SND(1100,150);SND(1200,150);SND(1300,150);SND(1400,150);
  SND(1500,150);
  NOSOUND;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| SOM 2 |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE som_2;
 BEGIN
  SND(200,150);
  NOSOUND;
 END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE FIM DE |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROGRAMA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE fim;
BEGIN
  CLEARDEVICE;
  SETCOLOR(715);
  SETTEXTSTYLE(2,0,7);
  OUTTEXTXY(10,10,'Obrigado por ter utilizado o GERAL v P˜1.1');
  OUTTEXTXY(10,30,'Fernando Jorge         ** 1995 **');
  DELAY(4000);
  CLOSEGRAPH;
  HALT;
END;

{*-*-*-*-*-*-*-*-*-*-*-| PROCEDURE FIM DE PROGRAMA POR |*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-| NéO ENCONTRAR ÆGERCOD.DATØ , FICHEIRO ONDE ESTÜ O CüDIGO |*-*-*-*-}

PROCEDURE fim_cod;
BEGIN
   CLEARDEVICE;
   SETTEXTSTYLE(0,0,5);
   SETCOLOR(4);
   OUTTEXTXY(150,200,'ALERTA !!!');
   SETTEXTSTYLE(1,0,3);
   OUTTEXTXY(170,240,'Ficheiro do c¢digo apagado ... ');
   SETCOLOR(9);
   SETTEXTSTYLE(2,0,7);
   OUTTEXTXY(140,270,'POR FAVOR !!! Arrange uma nova c¢pia . ');
   DELAY(20000);
   HALT;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE UTILIZADOR |*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-| NéO AUTORIZADO |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE Uti_nao_auto;
BEGIN
   som_1;
   SETTEXTSTYLE(1,0,5);
   SETCOLOR(15);
   OUTTEXTXY(120,180,'Desculpe !!! Utilizador');
   SETCOLOR(4);
   OUTTEXTXY(160,220,'NéO AUTORIZADO');
   DELAY(4000);
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE MUDA |*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| CåR |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

PROCEDURE Muda_cor;

BEGIN
 SETTEXTSTYLE(1,0,5);
 OUTTEXTXY(238,100,'GERAL');
 i:=5;
 REPEAT
 i:=i+10;
 OUTTEXTXY(238-i,100+i,'G');
 UNTIL i=205;
 i:=5;
 REPEAT
 i:=i+10;
 OUTTEXTXY(338+i,100+i,'L');
 UNTIL i=205;
 i:=5;
 REPEAT
 i:=i+20;
 OUTTEXTXY(28+i,305,'G');
 UNTIL i=205;
 i:=5;
 REPEAT
 i:=i+20;
 OUTTEXTXY(558-i,305,'L');
 UNTIL i=205;
 i:=5;
 REPEAT
 i:=i+15;
 OUTTEXTXY(232,305+i,'G');
 UNTIL i=35;
 i:=5;
 REPEAT
 i:=i+15;
 OUTTEXTXY(353,305+i,'L');
 UNTIL i=35;
 OUTTEXTXY(245,370,'GERAL');
 SETCOLOR(15);
 OUTTEXTXY(238,100,'GERAL');
 i:=5;
 REPEAT
 i:=i+10;
 OUTTEXTXY(238-i,100+i,'G');
 UNTIL i=205;
 i:=5;
 REPEAT
 i:=i+10;
 OUTTEXTXY(338+i,100+i,'L');
 UNTIL i=205;
 i:=5;
 REPEAT
 i:=i+20;
 OUTTEXTXY(28+i,305,'G');
 UNTIL i=205;
 i:=5;
 REPEAT
 i:=i+20;
 OUTTEXTXY(558-i,305,'L');
 UNTIL i=205;
 i:=5;
 REPEAT
 i:=i+15;
 OUTTEXTXY(232,305+i,'G');
 UNTIL i=35;
 i:=5;
 REPEAT
 i:=i+15;
 OUTTEXTXY(353,305+i,'L');
 UNTIL i=35;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE QUE ACTUALIZA |*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| A |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-|  HORA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE actua_hora;

  VAR
      h,m,s,hund,oldh,oldm,olds:WORD;

BEGIN
  SETTEXTSTYLE(1,0,3);
  SETFILLSTYLE(0,0);
  SETCOLOR(7);
  oldh:=hora;
  oldm:=minuto;
  olds:=segundo;
  REPEAT
    GETTIME(h,m,s,hund);
    IF (h>oldh) OR (m>oldm) OR (s>olds) THEN
      BEGIN
        SETCOLOR(0);
        DONEEVENTS;
        BAR(250,170,365,210);
        oldh:=h;
        oldm:=m;
        olds:=s;
        SETCOLOR(7);
        INITEVENTS;
        OUTTEXTXY(255,180,intostr(h,2)+':'+intostr(m,2)+':'+intostr(s,2));
       IF (h=h) and (m=00) and (s=00) then
         BEGIN
           snd(1000,200);
           no(200);
           snd(1000,200);
           no(400);
         end;
      end;
  UNTIL (MOUSEBUTTONS=$01) OR (MOUSEBUTTONS=$02);
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE QUE ACTUALIZA |*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| O |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| SOM |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE actua_som;

VAR
   h,m,s,hund,oldh,oldm,olds:WORD;

BEGIN
  oldh:=hora;
  oldm:=minuto;
  olds:=segundo;
  REPEAT
    GETTIME(h,m,s,hund);
    IF (h>oldh) OR (m>oldm) OR (s>olds) THEN
      BEGIN
       IF (h=h) and (m=00) and (s=00) then
         begin
          snd(1000,150);
          no(150);
          snd(1000,150);
          NOSOUND
         end;
      end;
       UNTIL (MOUSEBUTTONS=$01) OR (MOUSEBUTTONS=$02);
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*| FUNCTION QUE TESTA SE |*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| UM ANO ê BISSEXTO |*-*-*-*-*-*-*-*-*-*-*-*-*-}

FUNCTION Bissexto(ano:INTEGER):BOOLEAN;

BEGIN
  IF ((ano MOD 400)=0) OR (((ano MOD 4)=0) AND ((ano MOD 100)<>0)) THEN
    bissexto:=TRUE
   ELSE
    bissexto:=FALSE;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*| FUNCTION QUE Lâ UMA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| TECLA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

FUNCTION Kb:INTEGER;
VAR
   ch1,ch2:INTEGER;

BEGIN
  ch1:=ORD(READKEY);
  IF ch1 = 0 THEN
 BEGIN
  ch2 := ORD(READKEY);
  ch2 := ch2 SHL 8;
  ch2 := ch2 OR ch1;
  kb:=ch2;
  end
 ELSE
  kb := ch1;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE QUE  LIMPA |*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| O TECLADO |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

PROCEDURE LimpTec;
VAR
   xpto:INTEGER;

BEGIN
  xpto:=kb;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE QUE EDITA |*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-| O TIPO DE STRING |*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

PROCEDURE ReadStr(VAR s:STRING;maxchars:INTEGER;delcolor:WORD);

 CONST
    buff2: STRING[5] = 'c_';

 VAR
    i, int, currloc, oldcolor: INTEGER;
    view: VIEWPORTTYPE;
    charbuff: STRING[5];
    ch: CHAR;

 BEGIN
    s[0] := #0;
    currloc := 0;
    charbuff[0] := #1;
    GETVIEWSETTINGS(VIEW);
    IF maxchars <= 0 THEN EXIT;
    OUTTEXTXY(getx,gety,'_');
    int := kb;
    ch:=chr(int);
    ch:=UPCASE(ch);
   REPEAT
    WHILE ch <> cr DO BEGIN
      IF ch=chr(27) THEN ch:=chr(32);
      IF ch=chr(199) THEN ch:=chr(142);
      IF ch=chr(229) THEN ch:=chr(153);
      IF ch=chr(130) THEN ch:=chr(144);
      IF (int=up) OR (int=down) OR (int=left) OR (int=right) OR (int=home)
        OR (int=ends) OR (int=pgup) OR (int=pgdown) OR (int=insert)
        OR (int=delete) THEN ch:=chr(32);
      IF ch = bs THEN BEGIN
        IF currloc > 0 THEN BEGIN
           IF currloc<= maxchars THEN BEGIN
             oldcolor := GETCOLOR;
             SETCOLOR(delcolor);
             charbuff[1] := s[currloc];
             buff2[1] := s[currloc];
             OUTTEXTXY(getx-textwidth(charbuff),gety,buff2);
             SETCOLOR(oldcolor);
             MOVETO(getx-textwidth(charbuff),gety);
             dec(currloc);
             s[0]:=chr(currloc);
           end;
        end;
      end;
      IF ch <> bs THEN BEGIN
        IF currloc < maxchars THEN BEGIN
          oldcolor := GETCOLOR;
          SETCOLOR(delcolor);
          OUTTEXTXY(getx,gety,'_');
          SETCOLOR(oldcolor);
          inc(currloc);
          s[0] := chr(currloc);
          s[currloc] := ch;
          OUTTEXT(ch);
        END
        ELSE BEGIN
          SND(200,100);NOSOUND;
        END
      end;
      IF currloc <= maxchars THEN
        OUTTEXTXY(getx,gety,'_');
      int := kb;
      ch:=chr(int);
      ch:=UPCASE(ch);
    end;
    UNTIL ch=cr;
    IF currloc <= maxchars THEN BEGIN
      oldcolor := GETCOLOR;
      SETCOLOR(GETBKCOLOR);
      OUTTEXTXY(getx,gety,'_');
      SETCOLOR(oldcolor);
    end;
    IF length(s) = 0 THEN BEGIN
       SND(200,100);NOSOUND;
       readstr(s,maxchars,delcolor);
    end;
 END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE  |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| VE A HORA  |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE Ve_hora;

  VAR
      h,m,s,hund,oldh,oldm,olds:WORD;

BEGIN
    GETTIME(h,m,s,hund);
       IF (h=00) or (h=12) and (m>=00) and (s>=00) then
         BEGIN
           SETCOLOR(1);
           Muda_cor;
         end;
       IF (h=01) or (h=13) and (m>=00) and (s>=00) then
         BEGIN
           SETCOLOR(2);
           Muda_cor;
         end;
       IF (h=02) or (h=14) and (m>=00) and (s>=00) then
         BEGIN
           SETCOLOR(3);
           Muda_cor;
         end;
       IF (h=03) or (h=15) and (m>=00) and (s>=00) then
         BEGIN
           SETCOLOR(4);
           Muda_cor;
         end;
       IF (h=04) or (h=16) and (m>=00) and (s>=00) then
         BEGIN
           SETCOLOR(5);
           Muda_cor;
         end;
       IF (h=05) or (h=17) and (m>=00) and (s>=00) then
         BEGIN
           SETCOLOR(6);
           Muda_cor;
         end;
       IF (h=06) or (h=18) and (m>=00) and (s>=00) then
         BEGIN
           SETCOLOR(9);
           Muda_cor;
         end;
       IF (h=07) or (h=19) and (m>=00) and (s>=00) then
         BEGIN
           SETCOLOR(10);
           Muda_cor;
         end;
       IF (h=08) or (h=20) and (m>=00) and (s>=00) then
         BEGIN
           SETCOLOR(11);
           Muda_cor;
         end;
       IF (h=09) or (h=21) and (m>=00) and (s>=00) then
         BEGIN
           SETCOLOR(12);
           Muda_cor;
         end;
       IF (h=10) or (h=22) and (m>=00) and (s>=00) then
         BEGIN
           SETCOLOR(13);
           Muda_cor;
         end;
       IF (h=11) or (h=23) and (m>=00) and (s>=00) then
         BEGIN
           SETCOLOR(14);
           Muda_cor;
         end;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| PERTENCENTE |*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| ÜS |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| OPÄôES |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{}
{}
{}{( 1 )*-*-*-*-*-*-*-*-*-*-*| PROCEDURE DE ALTERAÄéO |*-*-*-*-*-*-*-*-*-*-*-}
{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| DA DATA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{}
{} PROCEDURE alterdata;
{}
{}   VAR
{}       dia,mes,ano,code1,code2,code3:WORD;
{.}       s,s1,s2,s3:STRING;
{.}       ok:BOOLEAN;
{.}
     BEGIN
       SETFILLSTYLE(1,0);
       BAR(0,0,640,480);
       SETTEXTSTYLE(1,0,5);
       SETTEXTJUSTIFY(1,2);
       SETCOLOR(14);
       OUTTEXTXY(320,20,'ALTERAR DATA');
       SETCOLOR(9);
       SETTEXTSTYLE(2,0,6);
       GETDATE(ano,mes,dia,d_s);
       OUTTEXTXY(320,200,'Introduza uma nova data     (actual '+intostr(dia,2)
                         +'/'+intostr(mes,2)+'/'+intostr(ano,4)+')');
       SETTEXTJUSTIFY(0,2);
       SETCOLOR(14);
       RECTANGLE(258,295,377,324);
         REPEAT
          ok:=TRUE;
          SETFILLSTYLE(1,15);
          BAR(260,297,375,322);
          MOVETO(265,300);
          SETCOLOR(9);
          readstr(s,10,15);
          s1:=s[1]+s[2];
          s2:=s[4]+s[5];
          s3:=s[7]+s[8]+s[9]+s[10];
          VAL(s1,dia,code1);
          VAL(s2,mes,code2);
          VAL(s3,ano,code3);
          IF (code1<>0) OR (code2<>0) OR (code3<>0) OR (s[3]<>'/') OR (s[6]<>'/')
              OR (s[0]<chr(10)) THEN ok:=FALSE;
          IF (NOT bissexto(ano)) AND (mes=2) AND (dia>28) THEN ok:=FALSE;
          IF (mes=2) AND (dia>29) THEN ok:=FALSE;
          IF (odd(mes)) AND (dia>30) THEN ok:=FALSE;
          IF (mes>12) OR (mes<1) THEN ok:=FALSE;
          IF (dia>31) OR (dia<1) THEN ok:=FALSE;
          IF ok=FALSE THEN BEGIN
          SETCOLOR(4);
          SETTEXTJUSTIFY(1,1);
          OUTTEXTXY(320,350,'Data Inv†lida : sintaxe correcta DD/MM/AAAA');
          DELAY(2000);
          SETCOLOR(0);
          OUTTEXTXY(320,350,'Data Inv†lida : sintaxe correcta DD/MM/AAAA');
          SETTEXTJUSTIFY(0,2);
                           end;
         UNTIL ok;
         day:=dia;
         month:=mes;
         year:=ano-1900;
         SETDATE(ano,mes,dia);
         Opcoes;
       END;



{}{( 2 )*-*-*-*-*-*-*-*-*-*-*| PROCEDURE DE ALTERAÄéO |*-*-*-*-*-*-*-*-*-*-*-}
{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| DA HORA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

    PROCEDURE alterhora;
      VAR
          h,m,ss,hund,code1,code2:WORD;
          s,s1,s2:STRING;
          ok:BOOLEAN;

      BEGIN
        SETFILLSTYLE(1,0);
        BAR(0,0,640,480);
        SETTEXTSTYLE(1,0,5);
        SETTEXTJUSTIFY(1,2);
        SETCOLOR(14);
        OUTTEXTXY(320,20,'ALTERAR HORA');
        SETCOLOR(9);
        SETTEXTSTYLE(2,0,6);
        GETTIME(h,m,ss,hund);
        OUTTEXTXY(320,200,'Introduza uma nova hora     (actual '+intostr(h,2)+':'+intostr(m,2)+')');
        SETTEXTJUSTIFY(0,2);
        SETCOLOR(14);
        RECTANGLE(283,295,352,324);
        SETCOLOR(9);
       REPEAT
          ok:=TRUE;
          SETFILLSTYLE(1,15);
          BAR(285,297,350,322);
          MOVETO(290,300);
          readstr(s,5,15);
          s1:=s[1]+s[2];
          s2:=s[4]+s[5];
          VAL(s1,h,code1);
          VAL(s2,m,code2);
          IF (code1<>0) OR (code2<>0) OR (h>24) OR (h<0) OR (m>59) OR (m<0)
             OR (s[3]<>':') OR (s[0]<chr(5)) THEN ok:=FALSE;
       UNTIL ok;
        SETTIME(h,m,0,0);
        Opcoes;
      END;

{}{( 3 )*-*-*-*-*-*-*-*-*-*-*| PROCEDURE DE ALTERAÄéO |*-*-*-*-*-*-*-*-*-*-*-}
{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| DO CüDIGO |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

     PROCEDURE altercod;

      CONST
           nomearq = 'gercod.dat';

      TYPE
           registro = RECORD
           nome:STRING[10];
           codigo :STRING[5];
      end;

      VAR
           arquivo :FILE OF registro;
           reg :registro;
           ok:BOOLEAN;

      BEGIN
        CLEARDEVICE;
        ASSIGN(arquivo,nomearq);
        {$I-}
        RESET(arquivo);
        {$I+}
        IF IORESULT <> 0 THEN
           BEGIN
             fim_cod;
             EXIT;
           END
        ELSE
          READ(arquivo,reg);
          SETFILLSTYLE(1,0);
          BAR(0,0,640,480);
          SETTEXTSTYLE(1,0,5);
          SETTEXTJUSTIFY(1,2);
          SETCOLOR(14);
          OUTTEXTXY(300,20,'ALTERAR CODIGO');
          SETCOLOR(9);
          SETTEXTSTYLE(2,0,6);
          OUTTEXTXY(320,200,'Introduza um novo c¢digo     (actual Æ'+reg.codigo+'Ø)');
          SETTEXTJUSTIFY(0,2);
          SETCOLOR(14);
          RECTANGLE(283,295,352,324);
          SETCOLOR(9);
          REWRITE(arquivo);
         REPEAT
            ok:=TRUE;
            SETFILLSTYLE(1,15);
            BAR(285,297,350,322);
            MOVETO(290,300);
            READLN(reg.codigo)
          UNTIL ok;
           WRITE(arquivo,reg);
           CLOSE(arquivo);
           Opcoes;
      END;

{}{( 4 )*-*-*-*-*-*-*-*-*-*-*-*-*-| PROCEDURE DE  |*-*-*-*-*-*-*-*-*-*-*-*-*-}
{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| INFORMÄéO |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

     PROCEDURE Informacao;

       BEGIN
        CLOSEGRAPH;
        TEXTBACKGROUND(1);
        CLRSCR;
        TEXTBACKGROUND(1);
        TEXTCOLOR(7);
        PRINTXY('GERAL',250,38,4,TRUE);
        TEXTCOLOR(15);
        PRINTXY('Esta Ç a versÑo 1.1 em Pascal (P˜1.1), isto porque anteriormente',175,10,8,FALSE);
        PRINTXY('j† foram feitas algumas versîes em QBasic (QuickBasic).',170,1,9,FALSE);
        PRINTXY('Nesta versÑo tive a ajuda e participaáÑo de alguns amigos que me',165,10,10,FALSE);
        PRINTXY('deram algumas ideias, conselhos e alguns pequenos programas que ',160,1,11,FALSE);
        PRINTXY('posteriormente melhorei.',155,1,12,FALSE);
        TEXTCOLOR(7);
        PRINTXY('Por isso agradeáo ao(†):',150,32,15,TRUE);
        TEXTCOLOR(15);
        PRINTXY('Nuno Picado -------- 1¶ VersÑo do jogo do GALO',140,10,16,FALSE);
        PRINTXY('e pelas in£meras explicaáîes ',140,20,17,FALSE);
        PRINTXY('Alberto Moura -------- Pelas ideias que deu',135,10,18,FALSE);
        PRINTXY('Ana Paula N. Almeida -------- Aqueles sinais todos sem fim ...',130,10,19,FALSE);
{.}     DELAY(2500);
{.}     INITGRAPH(gd,gm,'');
{.}     Opcoes;
{}     END;
{}
{}{--------------------------------------------------------------------------}

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| PERTENCENTE |*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| AOS |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| JOGOS |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{}
{}
{}{( 1 )*-*-*-*-*-*-*-*-*-*-*-*-*-*-| JOGO |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| DO |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| GALO |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{}
{}
{.}  PROCEDURE NORM;
{.}   BEGIN
{.}      REGS.AH:=$01;
         REGS.CH:=$06;
         REGS.CL:=$07;
         INTR($10,REGS);
      END;


     PROCEDURE OFF;
      BEGIN
         REGS.AH:=$01;
         REGS.CH:=$70;
         REGS.CL:=$00;
         INTR($10,REGS);
      END;


  PROCEDURE DESENHA(TIPO:QUADRADO;H,J:SHORTINT);

    VAR
       X,Y:BYTE;

    BEGIN
       DONEEVENTS;
       CASE H OF
            1:X:=23;
            2:X:=36;
            3:X:=49;
       END;
       CASE J OF
            1:Y:=6;
            2:Y:=11;
            3:Y:=16;
       END;
       CASE TIPO OF
            NULO:FILLSCR(X,Y,X+10,Y+3,7);
            _O_:FILLSCR(X,Y,X+10,Y+3,COR_O);
            _X_:FILLSCR(X,Y,X+10,Y+3,COR_X);
       END;
       WINDOW(1,1,80,25);
       TEXTBACKGROUND(1);
       INITEVENTS;
    END;

  PROCEDURE GANHOU(TIPO:SHORTINT;JOG:QUADRADO);

    VAR
       X,Y:BYTE;

    BEGIN
       DONEEVENTS;
       CASE JOG OF
            _O_:JOGOS_GANHOS[__O__]:=JOGOS_GANHOS[__O__]+1;
            _X_:JOGOS_GANHOS[__X__]:=JOGOS_GANHOS[__X__]+1;
       END;
       TEXTBACKGROUND(1);
       TEXTCOLOR(COR_O);
       WRITEXY('€€',4,5);
       TEXTCOLOR(14);
       WRITE(' = ',JOGOS_GANHOS[__O__]);
       TEXTCOLOR(COR_X);
       WRITEXY('€€',66,5);
       TEXTCOLOR(14);
       WRITE(' = ',JOGOS_GANHOS[__X__]);
       CASE JOG OF
            _O_:TEXTCOLOR(COR_O+128);
            _X_:TEXTCOLOR(COR_X+128);
       END;
       CASE TIPO OF
            1:BEGIN
                   FOR X:=23 TO 33 DO
                       FOR Y:=6 TO 9 DO
                           WRITEXY('€',X,Y);
                   FOR X:=23 TO 33 DO
                       FOR Y:=11 TO 14 DO
                           WRITEXY('€',X,Y);
                   FOR X:=23 TO 33 DO
                       FOR Y:=16 TO 19 DO
                           WRITEXY('€',X,Y);
              END;
            2:BEGIN
                   FOR X:=36 TO 46 DO
                       FOR Y:=6 TO 9 DO
                           WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
            END;
          3:BEGIN
                 FOR X:=49 TO 59 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
                 FOR X:=49 TO 59 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
                 FOR X:=49 TO 59 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
            END;
          4:BEGIN
                 FOR X:=23 TO 33 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
                 FOR X:=49 TO 59 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
            END;
          5:BEGIN
                 FOR X:=23 TO 33 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
                 FOR X:=49 TO 59 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
            END;
          6:BEGIN
                 FOR X:=23 TO 33 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
                 FOR X:=49 TO 59 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
            END;
          7:BEGIN
                 FOR X:=23 TO 33 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
                 FOR X:=49 TO 59 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
            END;
          8:BEGIN
                 FOR X:=49 TO 59 DO
                     FOR Y:=6 TO 9 DO
                         WRITEXY('€',X,Y);
                 FOR X:=36 TO 46 DO
                     FOR Y:=11 TO 14 DO
                         WRITEXY('€',X,Y);
                 FOR X:=23 TO 33 DO
                     FOR Y:=16 TO 19 DO
                         WRITEXY('€',X,Y);
            END;
     END;
     INITEVENTS;
     GOTOXY(1,22);
     CLREOL;
     TEXTCOLOR(14);
     WRITEXY('Ganhou o',8,11);
     WRITEXY('jogador:',8,12);
     CASE JOG OF
          _O_:BEGIN
               TEXTCOLOR(COR_O);
               SND(1000,150);
               NO(100);
               SND(1000,150);
               NO(100);
               SND(1000,150);
               NOSOUND;
              END;
          _X_:BEGIN
               TEXTCOLOR(COR_X);
               SND(50,150);
               NO(100);
               SND(50,150);
               NO(100);
               SND(50,150);
               NOSOUND;
              END;
     END;
     WRITEXY('€€',11,14);
     TEXTCOLOR(15);
     TEXTBACKGROUND(3);
     WRITEXY('  Continuar  ',65,11);
     WRITEXY('  Cancelar   ',65,14);
     REPEAT
           IF (MOUSEBUTTONS=$01) AND (MOUSEWHERE.X+1 IN [65..77]) THEN CASE MOUSEWHERE.Y+1 OF
                                                                            11:PRINCIPAL;
                                                                            14:BEGIN
                                                                                  NORM;
                                                                                  INITGRAPH(gd,gm,'');
                                                                                  Jogos;
                                                                               END;
                                                                       END;
           DELAY(100);
     UNTIL FALSE;
    END;

  PROCEDURE PRINCIPAL;

    BEGIN
      DONEEVENTS;
      FOR H:=1 TO 3 DO
         FOR J:=1 TO 3 DO
             MAT[H,J]:=NULO;
      JOG:=__O__;
      AINDA_NAO:=TRUE;
      FILLSCR(1,1,80,25,1);
      TEXTCOLOR(15);
      HORIZONTAL(4,3,73,'Õ');
      HORIZONTAL(4,23,73,'Õ');
      WRITEXY('GALO V1.0',4,2);
      TEXTCOLOR(0);
      FILLSCR(21,5,61,20,7);
      WINDOW(21,5,61,21);
      HORIZONTAL(1,1,40,'€');
      HORIZONTAL(1,6,40,'€');
      HORIZONTAL(1,11,40,'€');
      HORIZONTAL(1,16,40,'€');
      VERTICAL(1,2,14,0,'€€');
      VERTICAL(14,2,14,0,'€€');
      VERTICAL(27,2,14,0,'€€');
      VERTICAL(40,2,14,0,'€€');
      WINDOW(1,1,80,25);
      TEXTBACKGROUND(1);
      TEXTCOLOR(COR_O);
      WRITEXY('€€',4,5);
      TEXTCOLOR(14);
      WRITE(' = ',JOGOS_GANHOS[__O__]);
      TEXTCOLOR(COR_X);
      WRITEXY('€€',66,5);
      TEXTCOLOR(14);
      WRITE(' = ',JOGOS_GANHOS[__X__]);
      TEXTCOLOR(0);
      TEXTBACKGROUND(1);
      INITEVENTS;
      REPEAT
            FINDOU:=TRUE;
            H:=0;
            J:=0;
            TEXTCOLOR(14);
            WINDOW(1,1,80,25);
            S:='Jogador actual:   ';
            WRITEXY(S,40-(LENGTH(S) DIV 2),22);
            CASE JOG OF
                 __O__:TEXTCOLOR(COR_O);
                 __X__:TEXTCOLOR(COR_X);
            END;
            WRITEXY('€€',WHEREX-2,WHEREY);
            IF MOUSEBUTTONS=$01 THEN BEGIN
                                          IF MOUSEWHERE.X+1 IN [23..33] THEN H:=1;
                                          IF MOUSEWHERE.X+1 IN [36..46] THEN H:=2;
                                          IF MOUSEWHERE.X+1 IN [49..59] THEN H:=3;
                                          IF MOUSEWHERE.Y+1 IN [6..9] THEN J:=1;
                                          IF MOUSEWHERE.Y+1 IN [11..14] THEN J:=2;
                                          IF MOUSEWHERE.Y+1 IN [16..19] THEN J:=3;
                                          IF (H<>0) AND (J<>0) AND (MAT[H,J]=NULO) THEN BEGIN
                                                                                             CASE JOG OF
                                                                                                  __O__:BEGIN
                                                                                                             SND(1000,150);
                                                                                                             NOSOUND;
                                                                                                             MAT[H,J]:=_O_;
                                                                                                             JOG:=__X__;
                                                                                                        END;
                                                                                                  __X__:BEGIN
                                                                                                             SND(50,150);
                                                                                                             NOSOUND;
                                                                                                             MAT[H,J]:=_X_;
                                                                                                             JOG:=__O__;
                                                                                                        END;
                                                                                             END;
                                                                                             DESENHA(MAT[H,J],H,J);
                                                                                        END;
                                          IF (MAT[1,1]=MAT[1,2]) AND (MAT[1,2]=MAT[1,3]) AND (MAT[1,1]<>NULO)
                                             THEN GANHOU(1,MAT[1,1]);
                                          IF (MAT[2,1]=MAT[2,2]) AND (MAT[2,2]=MAT[2,3]) AND (MAT[2,1]<>NULO)
                                             THEN GANHOU(2,MAT[2,1]);
                                          IF (MAT[3,1]=MAT[3,2]) AND (MAT[3,2]=MAT[3,3]) AND (MAT[3,1]<>NULO)
                                             THEN GANHOU(3,MAT[3,1]);
                                          IF (MAT[1,1]=MAT[2,1]) AND (MAT[2,1]=MAT[3,1]) AND (MAT[1,1]<>NULO)
                                             THEN GANHOU(4,MAT[1,1]);
                                          IF (MAT[1,2]=MAT[2,2]) AND (MAT[2,2]=MAT[3,2]) AND (MAT[1,2]<>NULO)
                                             THEN GANHOU(5,MAT[1,2]);
                                          IF (MAT[1,3]=MAT[2,3]) AND (MAT[2,3]=MAT[3,3]) AND (MAT[1,3]<>NULO)
                                             THEN GANHOU(6,MAT[1,3]);
                                          IF (MAT[1,1]=MAT[2,2]) AND (MAT[2,2]=MAT[3,3]) AND (MAT[1,1]<>NULO)
                                             THEN GANHOU(7,MAT[1,1]);
                                          IF (MAT[3,1]=MAT[2,2]) AND (MAT[2,2]=MAT[1,3]) AND (MAT[3,1]<>NULO)
                                             THEN GANHOU(8,MAT[3,1]);
                                     END;
            FOR H:=1 TO 3 DO
                FOR J:=1 TO 3 DO
                    IF MAT[H,J]=NULO THEN FINDOU:=FALSE;
            IF FINDOU THEN BEGIN
                                IF AINDA_NAO THEN BEGIN
                                                       GOTOXY(1,22);
                                                       CLREOL;
                                                       TEXTCOLOR(14);
                                                       WRITEXY('  NÑo h†',6,12);
                                                       WRITEXY('vencedores.',6,13);
                                                       TEXTCOLOR(15);
                                                       TEXTBACKGROUND(3);
                                                       WRITEXY('  Continuar  ',65,11);
                                                       WRITEXY('  Cancelar   ',65,14);
                                                       AINDA_NAO:=FALSE;
                                                  END;
                                REPEAT
                                     IF (MOUSEBUTTONS=$01) AND (MOUSEWHERE.X+1 IN [65..77])
                                         THEN CASE MOUSEWHERE.Y+1 OF
                                                   11:PRINCIPAL;
                                                   14:BEGIN
                                                           NORM;
                                                           INITGRAPH(gd,gm,'');
                                                           Jogos;
                                                      END;
                                              END;
                                      DELAY(100);
                                UNTIL FALSE;
                           END;
            DELAY(150);
      UNTIL MOUSEBUTTONS=$02;
      DONEEVENTS;
      NORM;
      TEXTCOLOR(7);
      FILLSCR(1,1,80,25,0);
      INITGRAPH(gd,gm,'');
      Jogos;
    END;

  PROCEDURE Galo;

    BEGIN
       CHECKBREAK:=FALSE;
       FSPLIT(PARAMSTR(0),PATH,NAME,EXT);
       OFF;
       JOGOS_GANHOS[__O__]:=0;
       JOGOS_GANHOS[__X__]:=0;
{.}    PRINCIPAL;
{.}    INITGRAPH(gd,gm,'');
{.}    Jogos;
{}  END;
{}
{}{--------------------------------------------------------------------------}


{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PERTENCENTE |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| Ü |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{}{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| MñSICA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{}
{( 2 )*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PIANO |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{}
{}
{.}  FUNCTION letecla:WORD;
{.}    BEGIN
{.}     REPEAT
         ch:=UPCASE(READKEY);
         IF ch = '+' THEN
         IF tempo < 800 THEN
         tempo:=tempo + 50;
         IF ch = '-'THEN
         IF tempo >50 THEN
         tempo:=tempo - 50;
         UNTIL ch IN ['Q','W','E','R','T','Y','U','I','O','P','1','2','3',
                      '4','5','6','7','8','9','0',#92,#27];

          CASE ch OF
            #92 : letecla  := 500;
            '1' : letecla  := 560;
            '2' : letecla  := 630;
            '3' : letecla  := 710;
            '4' : letecla  := 795;
            '5' : letecla  := 890;
            '6' : letecla  := 1000;
            '7' : letecla  := 1129;
            '8' : letecla  := 1260;
            '9' : letecla  := 1415;
            '0' : letecla  := 1625;
            'Q' : letecla  := 530;
            'W' : letecla  := 595;
            'E' : letecla  := 670;
            'R' : letecla  := 750;
            'T' : letecla  := 840;
            'Y' : letecla  := 945;
            'U' : letecla  := 1060;
            'I' : letecla  := 1190;
            'O' : letecla  := 1335;
            'P' : letecla  := 1500;
            #27 : letecla  := 0;
          END;
       END;

     PROCEDURE piano;

       BEGIN
         CLEARDEVICE;
         SETTEXTSTYLE(1,0,5);
         SETCOLOR(14);
         OUTTEXTXY(170,1,'Piano Digital');
         SETCOLOR(7);
        FOR i := 1 TO 5 DO
         BEGIN
          RECTANGLE(i+100,i+100,490-i,200-i);
         END;
          LINE(139,105,139,195);
          LINE(174,105,174,195);
          LINE(208,105,208,195);
          LINE(243,105,243,195);
          LINE(277,105,277,195);
          LINE(312,105,312,195);
          LINE(346,105,346,195);
          LINE(381,105,381,195);
          LINE(415,105,415,195);
          LINE(450,105,450,195);
          LINE(105,150,485,150);
          LINE(450,170,485,170);
         SETCOLOR(15);
         SETTEXTSTYLE(0,0,3);
         OUTTEXTXY(115,120,'\');
         OUTTEXTXY(150,120,'1');
         OUTTEXTXY(184,120,'2');
         OUTTEXTXY(219,120,'3');
         OUTTEXTXY(253,120,'4');
         OUTTEXTXY(288,120,'5');
         OUTTEXTXY(322,120,'6');
         OUTTEXTXY(357,120,'7');
         OUTTEXTXY(391,120,'8');
         OUTTEXTXY(426,120,'9');
         OUTTEXTXY(460,120,'0');
         OUTTEXTXY(115,170,'Q');
         OUTTEXTXY(150,170,'W');
         OUTTEXTXY(184,170,'E');
         OUTTEXTXY(219,170,'R');
         OUTTEXTXY(253,170,'T');
         OUTTEXTXY(288,170,'Y');
         OUTTEXTXY(322,170,'U');
         OUTTEXTXY(357,170,'I');
         OUTTEXTXY(391,170,'O');
         OUTTEXTXY(426,170,'P');
         OUTTEXTXY(460,155,'-');
         OUTTEXTXY(460,175,'+');
         SETCOLOR(2);
         SETTEXTSTYLE(2,0,4);
         OUTTEXTXY(250,250,'Tecle < Esc > para sair');
         tempo := 200;
         REPEAT
           SOUND(letecla);
{.}        DELAY(tempo);
{.}        NOSOUND;
{.}      UNTIL ch = #27;
{}        musica;
{}      END;
{}
{----------------------------------------------------------------------------}

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| MENU |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| SINAIS |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE sinais;

BEGIN
  CLEARDEVICE;
  SETTEXTSTYLE(1,0,5);
  SETCOLOR(15);
  OUTTEXTXY(225,1,'SINAIS');
  SETCOLOR(9);
  FOR i:= 1 TO 10 DO
    BEGIN
    RECTANGLE(i+110,i+70, i+500,i+110);
    RECTANGLE(i+110,i+130,i+500,i+170);
    RECTANGLE(i+110,i+190,i+500,i+230);
    RECTANGLE(i+110,i+250,i+500,i+290);
    RECTANGLE(i+110,i+310,i+500,i+350);
    RECTANGLE(i+110,i+370,i+500,i+410);
    END;
  SETTEXTSTYLE(1,0,4);
  SETCOLOR(2);
  OUTTEXTXY(215,77,'De IndicaáÑo');
  OUTTEXTXY(215,137,'De ObrigaáÑo');
  OUTTEXTXY(215,197,'De ProibiáÑo');
  OUTTEXTXY(220,257,'De Diversos');
  OUTTEXTXY(180,317,'     Teste');
  OUTTEXTXY(177,377,'      Sair');
 REPEAT;
   INITEVENTS;
   actua_som;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [10..14]) then
    BEGIN
        som_2;
         DONEEVENTS;
         SETCOLOR(0);
         FOR a:= 1 TO 10 DO
           BEGIN
            RECTANGLE(a+110,a+70,a+500,a+110);
            DELAY(100);
           END;
      CLEARDEVICE;
      SETCOLOR(15);
      SETTEXTSTYLE(2,0,5);
      Sinais_Indicacao;
      sinais;
    END;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [18..22]) then
    BEGIN
        som_2;
         DONEEVENTS;
         SETCOLOR(0);
         FOR a:= 1 TO 10 DO
           BEGIN
            RECTANGLE(a+110,a+130,a+500,a+170);
            DELAY(100);
           END;
      CLEARDEVICE;
      SETCOLOR(15);
      SETTEXTSTYLE(2,0,5);
      Sinais_Obrigacao;
      sinais;
    END;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [26..30]) then
    BEGIN
        som_2;
         DONEEVENTS;
         SETCOLOR(0);
         FOR a:= 1 TO 10 DO
           BEGIN
            RECTANGLE(a+110,a+190,a+500,a+230);
            DELAY(100);
           END;
      CLEARDEVICE;
      SETCOLOR(15);
      SETTEXTSTYLE(2,0,5);
      Sinais_Proibicao;
      sinais;
    END;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [34..37]) then
    BEGIN
        som_2;
         DONEEVENTS;
         SETCOLOR(0);
         FOR a:= 1 TO 10 DO
           BEGIN
            RECTANGLE(a+110,a+250,a+500,a+290);
            DELAY(100);
           END;
      CLEARDEVICE;
      SETCOLOR(15);
      SETTEXTSTYLE(2,0,5);
      Sinais_Perigo;
      sinais;
    END;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [42..45]) then
    BEGIN
        som_2;
         DONEEVENTS;
         SETCOLOR(0);
         FOR a:= 1 TO 10 DO
           BEGIN
            RECTANGLE(a+110,a+310,a+500,a+350);
            DELAY(100);
           END;
      CLEARDEVICE;
      SETCOLOR(15);
      SETTEXTSTYLE(2,0,5);
      Teste;
      sinais;
    END;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [50..53]) then
    BEGIN
        som_2;
         DONEEVENTS;
         SETCOLOR(0);
         FOR a:= 1 TO 10 DO
           BEGIN
            RECTANGLE(a+110,a+370,a+500,a+410);
            DELAY(100);
           END;
      Menu_Principal;
    END;

 UNTIL (MOUSEBUTTONS=$01) AND (MOUSEWHERE.X+1 IN [15..68]) AND (MOUSEWHERE.Y+1 IN [50..53]);

END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| MENU |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| OPÄôES |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE opcoes;

BEGIN
  CLEARDEVICE;
  SETTEXTSTYLE(1,0,5);
  SETCOLOR(15);
  OUTTEXTXY(225,2,'OPÄôES');
  SETCOLOR(9);
  FOR i:= 1 TO 10 DO
    BEGIN
    RECTANGLE(i+110,i+70, i+500,i+110);
    RECTANGLE(i+110,i+130,i+500,i+170);
    RECTANGLE(i+110,i+190,i+500,i+230);
    RECTANGLE(i+110,i+250,i+500,i+290);
    RECTANGLE(i+110,i+310,i+500,i+350);
    END;
  SETTEXTSTYLE(1,0,4);
  SETCOLOR(2);
  OUTTEXTXY(175,77,'Alterar  a  Data');
  OUTTEXTXY(175,137,'Alterar  a  Hora');
  OUTTEXTXY(175,197,'Alterar o C¢digo');
  OUTTEXTXY(177,257,'   InformaáÑo');
  OUTTEXTXY(177,317,'      Sair');
 REPEAT;
   INITEVENTS;
   actua_som;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [10..14]) then
    BEGIN
             som_2;
         DONEEVENTS;
             setcolor(0);
              FOR i:= 1 TO 10 DO
                BEGIN
                  RECTANGLE(i+110,i+70, i+500,i+110);
                  DELAY(100);
                END;
             alterdata;
    END;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [18..22]) then
    BEGIN
             som_2;
         DONEEVENTS;
             setcolor(0);
              FOR i:= 1 TO 10 DO
                BEGIN
                   RECTANGLE(i+110,i+130,i+500,i+170);
                   DELAY(100);
                END;
             alterhora;
    END;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [26..30]) then
    BEGIN
             som_2;
         DONEEVENTS;
             setcolor(0);
             FOR i:= 1 TO 10 DO
               BEGIN
                 RECTANGLE(i+110,i+190,i+500,i+230);
                 DELAY(100);
               END;
             altercod;
    END;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [34..37]) then
    BEGIN
        som_2;
         DONEEVENTS;
         SETCOLOR(0);
         FOR a:= 1 TO 10 DO
           BEGIN
            RECTANGLE(a+110,a+250,a+500,a+290);
            DELAY(100);
           END;
      Informacao;
    END;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [42..45]) then
    BEGIN
        som_2;
         DONEEVENTS;
         SETCOLOR(0);
         FOR a:= 1 TO 10 DO
           BEGIN
            RECTANGLE(a+110,a+310,a+500,a+350);
            DELAY(100);
           END;
      Menu_Principal;
    END;

 UNTIL (MOUSEBUTTONS=$01) AND (MOUSEWHERE.X+1 IN [15..68]) AND (MOUSEWHERE.Y+1 IN [42..45]);

END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| MENU |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| JOGOS  |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

PROCEDURE jogos;

var
  ProgramName, CmdLine: string;

BEGIN
  CLEARDEVICE;
  SETTEXTSTYLE(1,0,5);
  SETCOLOR(15);
  OUTTEXTXY(227,1,'JOGOS');
  SETCOLOR(9);
  FOR i:= 1 TO 10 DO
    BEGIN
    RECTANGLE(i+110,i+70, i+500,i+110);
    RECTANGLE(i+110,i+130,i+500,i+170);
    END;
  SETTEXTSTYLE(1,0,4);
  SETCOLOR(2);
  OUTTEXTXY(225,77,'Galo');
  OUTTEXTXY(177,137,'      Sair');
 REPEAT;
   INITEVENTS;
   actua_som;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [10..14]) then
    BEGIN
             som_2;
         DONEEVENTS;
             setcolor(0);
              FOR i:= 1 TO 10 DO
                BEGIN
                  RECTANGLE(i+110,i+70, i+500,i+110);
                  DELAY(100);
                END;
               CLOSEGRAPH;
               Galo;
               INITGRAPH(gd,gm,'');
    END;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [18..22]) then
    BEGIN
        som_2;
         DONEEVENTS;
         SETCOLOR(0);
         FOR a:= 1 TO 10 DO
           BEGIN
            RECTANGLE(a+110,a+130,a+500,a+170);
            DELAY(100);
           END;
      Menu_Principal;
    END;
 UNTIL (MOUSEBUTTONS=$01) AND (MOUSEWHERE.X+1 IN [15..68]) AND (MOUSEWHERE.Y+1 IN [18..22]);

END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| MENU |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| MñSICA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE musica;

BEGIN
  CLEARDEVICE;
  SETTEXTSTYLE(1,0,5);
  SETCOLOR(15);
  OUTTEXTXY(225,1,'MUSICA');
  SETCOLOR(9);
  FOR i:= 1 TO 10 DO
    BEGIN
    RECTANGLE(i+110,i+70, i+500,i+110);
    RECTANGLE(i+110,i+130,i+500,i+170);
    RECTANGLE(i+110,i+190,i+500,i+230);
    END;
  SETTEXTSTYLE(1,0,4);
  SETCOLOR(2);
  OUTTEXTXY(179,77,'       Mix');
  OUTTEXTXY(175,137,'     Piano');
  OUTTEXTXY(177,197,'      Sair');
 REPEAT;
   INITEVENTS;
   actua_som;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [10..14]) then
    BEGIN
      SND(1000,100);
      NOSOUND;
    END;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [18..22]) then
    BEGIN
             som_2;
         DONEEVENTS;
             setcolor(0);
              FOR i:= 1 TO 10 DO
                BEGIN
                   RECTANGLE(i+110,i+130,i+500,i+170);
                   DELAY(100);
                END;
             piano;
    END;
 IF (mousebuttons=$01) AND (mousewhere.x+1 IN [15..68]) AND (mousewhere.y+1 IN [26..30]) then
    BEGIN
             som_2;
         DONEEVENTS;
             setcolor(0);
             FOR i:= 1 TO 10 DO
               BEGIN
                 RECTANGLE(i+110,i+190,i+500,i+230);
                 DELAY(100);
               END;
             menu_principal;
    END;

 UNTIL (MOUSEBUTTONS=$01) AND (MOUSEWHERE.X+1 IN [15..68]) AND (MOUSEWHERE.Y+1 IN [26..30]);

END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*|  MENU  |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| PRINCIPAL |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE Menu_principal;


BEGIN
 CLEARDEVICE;
 Ve_hora;
 FOR a:=1 TO 10 DO
 BEGIN
 SETCOLOR(9);
 RECTANGLE(a+10,a+30,a+170,a+70);
 RECTANGLE(a+215,a+30,a+385,a+70);
 RECTANGLE(a+430,a+30,a+600,a+70);
 RECTANGLE(a+10,a+370,a+170,a+410);
 RECTANGLE(a+430,a+370,a+600,a+410);
 END;
 DELAY(1000);
 SETCOLOR(2);
 SETTEXTSTYLE(1,0,4);
 OUTTEXTXY(50,40,'Sinais');
 OUTTEXTXY(255,40,'Opáîes');
 OUTTEXTXY(475,40,'Jogos');
 OUTTEXTXY(45,380,'M£sica');
 OUTTEXTXY(475,380,'Sair');
 SETTEXTSTYLE(1,0,3);
 GETDATE(ano,mes,dia,d_s);
 SETCOLOR(15);
 OUTTEXTXY(250,230,''+dias[d_s]+'');
 SETCOLOR(8);
 OUTTEXTXY(227,263,intostr(dia,2)+'/'+intostr(mes,2)+'/'+intostr(ano,4));
REPEAT
 INITEVENTS;
 actua_hora;
  IF (mousebuttons=$01) AND (mousewhere.x+1 IN [2..22]) AND (mousewhere.y+1 IN [5..9]) then
        BEGIN
           som_2;
          DONEEVENTS;
          SETCOLOR(0);
          FOR a:= 1 TO 10 DO
           BEGIN
             RECTANGLE(a+10,a+30,a+170,a+70);
             DELAY(100);
           END;
          sinais;
         end;
  IF (mousebuttons=$01) AND (mousewhere.x+1 IN [28..48]) AND (mousewhere.y+1 IN [5..9]) then
     BEGIN
          som_2;
          DONEEVENTS;
          SETCOLOR(0);
          FOR a:= 1 TO 10 DO
            BEGIN
              RECTANGLE(a+215,a+30,a+385,a+70);
              DELAY(100);
            END;
          opcoes;
     END;
  IF (mousebuttons=$01) AND (mousewhere.x+1 IN [54..74]) AND (mousewhere.y+1 IN [5..9]) then
    BEGIN
         som_2;
          DONEEVENTS;
          SETCOLOR(0);
          FOR a:= 1 TO 10 DO
           BEGIN
             RECTANGLE(a+430,a+30,a+600,a+70);
             DELAY(100);
           END;
          jogos;
    END;
  IF (mousebuttons=$01) AND (mousewhere.x+1 IN [2..22]) AND (mousewhere.y+1 IN [48..52]) then
    BEGIN
         som_2;
         DONEEVENTS;
         SETCOLOR(0);
         FOR a:= 1 TO 10 DO
           BEGIN
             RECTANGLE(a+10,a+370,a+170,a+410);
             DELAY(100);
           END;
         musica;
     END;

  IF (mousebuttons=$01) AND (mousewhere.x+1 IN [54..74]) AND (mousewhere.y+1 IN [48..52]) then
    BEGIN
        som_2;
         DONEEVENTS;
         SETCOLOR(0);
         FOR a:= 1 TO 10 DO
           BEGIN
            RECTANGLE(a+430,a+370,a+600,a+410);
            DELAY(100);
           END;
          fim;
    END;
 UNTIL (mousebuttons=$01) AND (mousewhere.x+1 IN [54..74]) AND (mousewhere.y+1 IN [48..52]) ;

END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| OLÜ  |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE Bemvindo;
BEGIN
   som_1;
   SETTEXTSTYLE(1,0,5);
   SETCOLOR(1);
   OUTTEXTXY(250,180,'Ol†');
   SETCOLOR(14);
   OUTTEXTXY(200,250,''+nome_s+'');
   DELAY(4000);
   Menu_principal;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE CüDIGO |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| DE ENTRADA |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE pass_entrada;

CONST
      nomearq = 'gercod.dat';
TYPE
    registro = RECORD
    nome :STRING[10];
    codigo :STRING[5];
END;

VAR
    arquivo :FILE OF registro;
    reg :registro;


BEGIN
   IF keypressed then LimpTec;
   CLEARDEVICE;
   ASSIGN(arquivo,nomearq);
   {$I-}
   RESET(arquivo);
   {$I+}
   IF IORESULT <> 0
     THEN
   BEGIN
   fim_cod;
   EXIT;
   END
     ELSE
   SETCOLOR(2);
   SETTEXTSTYLE(1,0,2);
   OUTTEXTXY(100,1,' Escreva o seu nome (m†ximo 10 letras)   ');
   SETCOLOR(15);
   WRITELN('');
   WRITELN('');
   WRITE('              ');
   READLN(nome_s);
   SETCOLOR(2);
   OUTTEXTXY(100,50,' Escreva o c¢digo ');
   SETCOLOR(15);
   WRITELN('');
   WRITELN('');
   WRITE('              ');
   READLN(codigo_s);
   READ(arquivo,reg);
   IF reg.codigo <> codigo_s
     THEN
   Uti_nao_auto
     ELSE
   Bemvindo
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| CORPO |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| DO |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROGRAMA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

BEGIN
  CHECKBREAK:=FALSE;
  SETCBREAK(CHECKBREAK);
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
  Intro;
  pass_entrada;
  fim;
END.
