{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{|  PROGRAMA            => Geral V3.0  Introdu‡„o                          |}
{*  PROGRAMADO EM       => Turbo Pascal 6.0                                *}
{|  AUTOR               => Fernando Jorge de Almeida da Silva              |}
{*  ENDERE€O            => Juncal - Assequins 3750 †gueda                  *}
{|  TELEFONE            => (034) 602800                                    |}
{*  DATA DA PROGRAMA€ŽO => Setembro/95                                     *}
{|  COM PARTICIPA€ŽO DE =>                                                 |}
{*                                                                         *}
{|  FUN€ŽO DO PROGRAMA  => Programa Principal                              |}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROGRAM Geral_V3_0;
USES

    CRT,GRAPH,DOS,GERINTRO,TPMOUSE;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| CONSTANTES |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| GLOBAIS |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

CONST
      gd   : INTEGER = 9;
      gm   : INTEGER = 2;
      dias :ARRAY[0..6] OF STRING[7] =
      ('Domingo','Segunda','Ter‡a','Quarta','Quinta','Sexta','S bado');
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




{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| VARI†VEIS |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| GLOBAIS |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

VAR
      a,i,x,y,c :INTEGER;
      mouse   :MOUSEOBJ;
      f :BOOLEAN;
      nome_s :STRING[10];
      codigo_s :STRING[5];
      dia,mes,ano,d_s,hora,minuto,segundo,hund:WORD;
      ch       :CHAR;
      tempo    :WORD;
      year,month,day,dow:word;
      s     :STRING;
      cont  :INTEGER;



{*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURES DECLARADAS |*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| MAIS † FRENTE |*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

PROCEDURE Menu_principal;FORWARD;
PROCEDURE musica;FORWARD;
PROCEDURE opcoes;FORWARD;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| SOM |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE som_1;
BEGIN
  DELAY(150);
  SOUND(900);
  DELAY(150);
  SOUND(800);
  DELAY(150);
  SOUND(700);
  DELAY(150);
  SOUND(600);
  DELAY(150);
  SOUND(500);
  DELAY(150);
  SOUND(400);
  DELAY(150);
  SOUND(300);
  DELAY(150);
  SOUND(400);
  DELAY(150);
  SOUND(500);
  DELAY(150);
  SOUND(600);
  DELAY(150);
  SOUND(700);
  DELAY(150);
  SOUND(800);
  DELAY(150);
  SOUND(900);
  DELAY(150);
  SOUND(1000);
  DELAY(150);
  SOUND(1100);
  DELAY(150);
  SOUND(1200);
  DELAY(150);
  SOUND(1300);
  DELAY(150);
  SOUND(1400);
  DELAY(150);
  SOUND(1500);
  DELAY(150);
  NOSOUND;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| SOM 2 |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE som_2;
 BEGIN
  SOUND(200);
  DELAY(150);
  NOSOUND;
 END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE FIM DE |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROGRAMA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE fim;
BEGIN
  CLEARDEVICE;
  som_1;
  SETCOLOR(715);
  SETTEXTSTYLE(2,0,7);
  OUTTEXTXY(10,10,'Obrigado por ter utilizado o GERAL V3.0');
  OUTTEXTXY(10,30,'Fernando Jorge         ** 1995 **');
  DELAY(4000);
  CLOSEGRAPH;
  HALT;
END;

{*-*-*-*-*-*-*-*-*-*-*-| PROCEDURE FIM DE PROGRAMA POR |*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-| NŽO ENCONTRAR ®GERCOD.DAT¯ , FICHEIRO ONDE EST† O CŸDIGO |*-*-*-*-}

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
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-| NŽO AUTORIZADO |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE Uti_nao_auto;
BEGIN
   som_1;
   SETTEXTSTYLE(1,0,5);
   SETCOLOR(15);
   OUTTEXTXY(120,180,'Desculpe !!! Utilizador');
   SETCOLOR(4);
   OUTTEXTXY(160,220,'NŽO AUTORIZADO');
   DELAY(4000);
END;

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
        mouse.hide;
        BAR(250,170,380,210);
        oldh:=h;
        oldm:=m;
        olds:=s;
        SETCOLOR(7);
        mouse.show;
        OUTTEXTXY(255,180,intostr(h,2)+':'+intostr(m,2)+':'+intostr(s,2));
      end;
       UNTIL KEYPRESSED OR mouse.buttonpressed(leftbutton);
END;


Function Bissexto(ano:integer):boolean;
   begin
    if ((ano mod 400)=0) or (((ano mod 4)=0) and ((ano mod 100)<>0)) then
      bissexto:=true
    else
      bissexto:=false;
   end;

{///////////////////////////Fun‡Æo que lˆ uma tecla//////////////////////////}


    Function Kb:integer;
    var ch1,ch2:integer;

    begin
      ch1:=ord(readkey);
      if ch1 = 0 then begin
        ch2 := ord(readkey);
        ch2 := ch2 shl 8;
        ch2 := ch2 or ch1;
        kb:=ch2;
      end
      else
        kb := ch1;
    end;


{//////////////////////Procedure que edita o tipo STRING/////////////////////}


 Procedure ReadStr(var s:string;maxchars:integer;delcolor:word);
  const
    buff2: string[2] = 'c_';
  var
    i, int, currloc, oldcolor: integer;
    view: viewporttype;
    charbuff: string[2];
    ch: char;
  begin
    s[0] := #0;
    currloc := 0;
    charbuff[0] := #1;
    getviewsettings(view);
    if maxchars <= 0 then exit;
    outtextxy(getx,gety,'_');
    int := kb;
    ch:=chr(int);
    ch:=upcase(ch);
    repeat
    while ch <> cr do begin
      if ch=chr(27) then ch:=chr(32);
      if ch=chr(199) then ch:=chr(142);
      if ch=chr(229) then ch:=chr(153);
      if ch=chr(130) then ch:=chr(144);
      if (int=up) or (int=down) or (int=left) or (int=right) or (int=home)
        or (int=ends)or (int=pgup) or (int=pgdown) or (int=insert)
        or (int=delete) then ch:=chr(32);
      if ch = bs then begin
        if currloc > 0 then begin
           if currloc<= maxchars then begin
             oldcolor := getcolor;
             setcolor(delcolor);
             charbuff[1] := s[currloc];
             buff2[1] := s[currloc];
             outtextxy(getx-textwidth(charbuff),gety,buff2);
             setcolor(oldcolor);
             moveto(getx-textwidth(charbuff),gety);
             dec(currloc);
             s[0]:=chr(currloc);
           end;
        end;
      end;
      if ch <> bs then begin
        if currloc < maxchars then begin
          oldcolor := getcolor;
          setcolor(delcolor);
          outtextxy(getx,gety,'_');
          setcolor(oldcolor);
          inc(currloc);
          s[0] := chr(currloc);
          s[currloc] := ch;
          outtext(ch);
        end
        else begin
          sound(200); delay(100); nosound;
        end
      end;
      if currloc <= maxchars then
        outtextxy(getx,gety,'_');
      int := kb;
      ch:=chr(int);
      ch:=upcase(ch);
    end;
    until ch=cr;
    if currloc <= maxchars then begin
      oldcolor := getcolor;
      setcolor(getbkcolor);
      outtextxy(getx,gety,'_');
      setcolor(oldcolor);
    end;
    if length(s) = 0 then begin
       sound(200);
       delay(100);
       nosound;
       readstr(s,maxchars,delcolor);
    end;
  end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PERTENCENTE |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| †S |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| OP€™ES |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}


{( 1 )-*-*-*-*-*-*-*-*-*-*-*-| PROCEDURE DE ALTERA€ŽO |*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| DA DATA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

PROCEDURE alterdata;

VAR
   dia,mes,ano,code1,code2,code3:WORD;
   s,s1,s2,s3:STRING;
   ok:BOOLEAN;

BEGIN
  SETFILLSTYLE(1,0);
  BAR(0,0,640,480);
  SETTEXTSTYLE(4,0,5);
  SETCOLOR(15);
  OUTTEXTXY(320,20,'ALTERAR DATA');
  SETCOLOR(8);
  OUTTEXTXY(320,21,'ALTERAR DATA');
  OUTTEXTXY(320,22,'ALTERAR DATA');
  OUTTEXTXY(320,23,'ALTERAR DATA');
  SETTEXTSTYLE(2,0,6);
  SETCOLOR(1);
  OUTTEXTXY(320,200,'Introduza uma nova data     (actual '+intostr(day,2)
                    +'/'+intostr(month,2)+'/'+intostr(year+1900,4)+')');
  SETTEXTJUSTIFY(1,2);
  SETCOLOR(7);
  RECTANGLE(258,295,377,324);
  REPEAT
    ok:=TRUE;
    SETFILLSTYLE(1,15);
    BAR(260,297,375,322);
    MOVETO(265,300);
    SETCOLOR(1);
    readstr(s,10,15);
    s1:=s[1]+s[2];
    s2:=s[4]+s[5];
    s3:=s[7]+s[8]+s[9]+s[10];
    VAL(s1,dia,code1);
    VAL(s2,mes,code2);
    VAL(s3,ano,code3);
    IF (code1<>0) OR (code2<>0) OR (code3<>0) OR (s[3]<>'/') OR (s[6]<>'/')
         OR (s[0]<chr(10)) THEN ok:=FALSE;
    IF (not bissexto(ano)) AND (mes=2) AND (dia>28) THEN ok:=FALSE;
    IF (mes=2) AND (dia>29) THEN ok:=FALSE;
    IF (odd(mes)) AND (dia>30) THEN ok:=FALSE;
    IF (mes>12) OR (mes<1) THEN ok:=FALSE;
    IF (dia>31) OR (dia<1) THEN ok:=FALSE;
    IF ok=FALSE THEN
      BEGIN
        SETCOLOR(4);
        SETTEXTJUSTIFY(1,1);
        OUTTEXTXY(320,350,'Data Inv lida : sintaxe correcta DD/MM/AAAA');
        DELAY(2000);
        SETCOLOR(0);
        OUTTEXTXY(320,350,'Data Inv lida : sintaxe correcta DD/MM/AAAA');
        SETTEXTJUSTIFY(0,2);
      end;
    UNTIL ok;
     day:=dia;
     month:=mes;
     year:=ano-1900;
     SETDATE(ano,mes,dia);
     opcoes;
END;



{( 2 )-*-*-*-*-*-*-*-*-*-*-*-| PROCEDURE DE ALTERA€ŽO |*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| DA HORA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

PROCEDURE alterhora;
VAR
   h,m,code1,code2:WORD;
   s,s1,s2:STRING;
   ok:BOOLEAN;

BEGIN
  SETFILLSTYLE(1,0);
  BAR(0,0,640,480);
  SETTEXTSTYLE(4,0,5);
  SETCOLOR(15);
  OUTTEXTXY(320,20,'ALTERAR HORA');
  SETCOLOR(8);
  OUTTEXTXY(320,21,'ALTERAR HORA');
  OUTTEXTXY(320,22,'ALTERAR HORA');
  OUTTEXTXY(320,23,'ALTERAR HORA');
  SETTEXTSTYLE(2,0,6);
  OUTTEXTXY(320,200,'Introduza uma nova hora     (actual '+intostr(hora,2)+':'+intostr(minuto,2)+')');
  SETTEXTJUSTIFY(0,2);
  SETCOLOR(7);
  RECTANGLE(283,295,352,324);
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
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PERTENCENTE |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| † |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| M–SICA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

{( 2 )-*-*-*-*-*-*-*-*-*-*| FUNCTION QUE L‰ AS |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-| TECLAS DO PIANO |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

FUNCTION letecla:WORD;
BEGIN
    REPEAT
    ch:=UPCASE(READKEY);
    IF ch = '+'
      THEN
       IF tempo < 800
           THEN
             tempo:=tempo + 50;
    IF ch = '-'
      THEN
       IF tempo >50
            THEN
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

{( 2.1 )-*-*-*-*-*-*-*-*-*-*-*-*| PIANO |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| DIGITAL |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE piano;
BEGIN
  CLEARDEVICE;
  SETTEXTSTYLE(4,0,5);
  SETCOLOR(15);
  OUTTEXTXY(200,1,'Piano Digital');
  SETCOLOR(8);
  OUTTEXTXY(200,2,'Piano Digital');
  OUTTEXTXY(200,3,'Piano Digital');
  OUTTEXTXY(200,4,'Piano Digital');
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
    DELAY(tempo);
    NOSOUND;
  UNTIL ch = #27;
  musica;
end;




{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| MENU |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| SINAIS |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE sinais;

BEGIN
  CLEARDEVICE;
  SETTEXTSTYLE(4,0,5);
  SETCOLOR(15);
  OUTTEXTXY(225,1,'SINAIS');
  SETCOLOR(8);
  OUTTEXTXY(225,2,'SINAIS');
  OUTTEXTXY(225,3,'SINAIS');
  OUTTEXTXY(225,4,'SINAIS');
  SETCOLOR(9);
  FOR i:= 1 TO 10 DO
    BEGIN
    RECTANGLE(i+110,i+70, i+500,i+110);
    RECTANGLE(i+110,i+130,i+500,i+170);
    RECTANGLE(i+110,i+190,i+500,i+230);
    RECTANGLE(i+110,i+250,i+500,i+290);
    RECTANGLE(i+110,i+310,i+500,i+350);
    END;
  SETTEXTSTYLE(2,0,5);
  SETCOLOR(4);
  OUTTEXTXY(300,75,'F1');
  OUTTEXTXY(300,135,'F2');
  OUTTEXTXY(300,195,'F3');
  OUTTEXTXY(300,255,'F4');
  OUTTEXTXY(300,315,'F5');
  SETTEXTSTYLE(1,0,4);
  SETCOLOR(2);
  OUTTEXTXY(175,77,'');
  OUTTEXTXY(175,137,'');
  OUTTEXTXY(175,197,'');
  OUTTEXTXY(177,257,'');
  OUTTEXTXY(177,317,'      Sair');
  WHILE c <> 0  DO
    BEGIN
      mouse.show;
      c:=mouse.waitforinput(leftbutton);
      mouse.hide;
      IF c < 0 THEN
        BEGIN
        mouse.getcoords(x,y);
         IF mouse.inbox(110,310,500,350,x,y) THEN c:=63;
         end;
         case c of
         63:begin
            som_2;
            Menu_principal;
           end;

end;
end;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| MENU |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| OP€™ES |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE opcoes;

BEGIN
  CLEARDEVICE;
  SETTEXTSTYLE(4,0,5);
  SETCOLOR(15);
  OUTTEXTXY(225,1,'OP€™ES');
  SETCOLOR(8);
  OUTTEXTXY(225,2,'OP€™ES');
  OUTTEXTXY(225,3,'OP€™ES');
  OUTTEXTXY(225,4,'OP€™ES');
  SETCOLOR(9);
  FOR i:= 1 TO 10 DO
    BEGIN
    RECTANGLE(i+110,i+70, i+500,i+110);
    RECTANGLE(i+110,i+130,i+500,i+170);
    RECTANGLE(i+110,i+190,i+500,i+230);
    RECTANGLE(i+110,i+250,i+500,i+290);
    RECTANGLE(i+110,i+310,i+500,i+350);
    END;
  SETTEXTSTYLE(2,0,5);
  SETCOLOR(4);
  OUTTEXTXY(300,75,'F1');
  OUTTEXTXY(300,135,'F2');
  OUTTEXTXY(300,195,'F3');
  OUTTEXTXY(300,255,'F4');
  OUTTEXTXY(300,315,'F5');
  SETTEXTSTYLE(1,0,4);
  SETCOLOR(2);
  OUTTEXTXY(175,77,'Alterar  a  Data');
  OUTTEXTXY(175,137,'Alterar  a  Hora');
  OUTTEXTXY(175,197,'Alterar o C¢digo');
  OUTTEXTXY(177,257,'   Informa‡„o');
  OUTTEXTXY(177,317,'      Sair');
  WHILE c <> 0  DO
    BEGIN
      mouse.show;
      c:=mouse.waitforinput(leftbutton);
      mouse.hide;
      IF c < 0 THEN
        BEGIN
        mouse.getcoords(x,y);
         IF mouse.inbox(110,70,500,110,x,y) THEN c:=59;
         IF mouse.inbox(110,130,500,170,x,y) THEN c:=60;
         IF mouse.inbox(110,310,500,350,x,y) THEN c:=63;
         end;
         case c of
         59:begin
             som_2;
             alterdata;
            end;
         60:begin
             som_2;
             alterhora;
            end;
         63:begin
            som_2;
            Menu_principal;
           end;

end;
end;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| MENU |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| JOGOS  |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}

PROCEDURE jogos;

BEGIN
  CLEARDEVICE;
  SETTEXTSTYLE(4,0,5);
  SETCOLOR(15);
  OUTTEXTXY(227,1,'JOGOS');
  SETCOLOR(8);
  OUTTEXTXY(227,2,'JOGOS');
  OUTTEXTXY(227,3,'JOGOS');
  OUTTEXTXY(227,4,'JOGOS');
  SETCOLOR(9);
  FOR i:= 1 TO 10 DO
    BEGIN
    RECTANGLE(i+110,i+70, i+500,i+110);
    RECTANGLE(i+110,i+130,i+500,i+170);
    RECTANGLE(i+110,i+190,i+500,i+230);
    RECTANGLE(i+110,i+250,i+500,i+290);
    RECTANGLE(i+110,i+310,i+500,i+350);
    END;
  SETTEXTSTYLE(2,0,5);
  SETCOLOR(4);
  OUTTEXTXY(300,75,'F1');
  OUTTEXTXY(300,135,'F2');
  OUTTEXTXY(300,195,'F3');
  OUTTEXTXY(300,255,'F4');
  OUTTEXTXY(300,315,'F5');
  SETTEXTSTYLE(1,0,4);
  SETCOLOR(2);
  OUTTEXTXY(175,77,'');
  OUTTEXTXY(175,137,'');
  OUTTEXTXY(175,197,'');
  OUTTEXTXY(177,257,'');
  OUTTEXTXY(177,317,'      Sair');
  WHILE c <> 0  DO
    BEGIN
      mouse.show;
      c:=mouse.waitforinput(leftbutton);
      mouse.hide;
      IF c < 0 THEN
        BEGIN
        mouse.getcoords(x,y);
         IF mouse.inbox(110,310,500,350,x,y) THEN c:=63;
         end;
         case c of
         63:begin
            som_2;
            Menu_principal;
           end;

end;
end;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| MENU |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| F‹SICA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE fisica;

BEGIN
  CLEARDEVICE;
  SETTEXTSTYLE(4,0,5);
  SETCOLOR(15);
  OUTTEXTXY(225,1,'F‹SICA');
  SETCOLOR(8);
  OUTTEXTXY(225,2,'F‹SICA');
  OUTTEXTXY(225,3,'F‹SICA');
  OUTTEXTXY(225,4,'F‹SICA');
  SETCOLOR(9);
  FOR i:= 1 TO 10 DO
    BEGIN
    RECTANGLE(i+110,i+70, i+500,i+110);
    RECTANGLE(i+110,i+130,i+500,i+170);
    RECTANGLE(i+110,i+190,i+500,i+230);
    RECTANGLE(i+110,i+250,i+500,i+290);
    RECTANGLE(i+110,i+310,i+500,i+350);
    END;
  SETTEXTSTYLE(2,0,5);
  SETCOLOR(4);
  OUTTEXTXY(300,75,'F1');
  OUTTEXTXY(300,135,'F2');
  OUTTEXTXY(300,195,'F3');
  OUTTEXTXY(300,255,'F4');
  OUTTEXTXY(300,315,'F5');
  SETTEXTSTYLE(1,0,4);
  SETCOLOR(2);
  OUTTEXTXY(175,77,'');
  OUTTEXTXY(175,137,'');
  OUTTEXTXY(175,197,'');
  OUTTEXTXY(177,257,'');
  OUTTEXTXY(177,317,'      Sair');
  WHILE c <> 0  DO
    BEGIN
      mouse.show;
      c:=mouse.waitforinput(leftbutton);
      mouse.hide;
      IF c < 0 THEN
        BEGIN
        mouse.getcoords(x,y);
         IF mouse.inbox(110,310,500,350,x,y) THEN c:=63;
         end;
         case c of
         63:begin
            som_2;
            Menu_principal;
           end;

end;
end;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| MENU |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| QU‹MICA |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE quimica;

BEGIN
  CLEARDEVICE;
  SETTEXTSTYLE(4,0,5);
  SETCOLOR(15);
  OUTTEXTXY(222,1,'QU‹MICA');
  SETCOLOR(8);
  OUTTEXTXY(222,2,'QU‹MICA');
  OUTTEXTXY(222,3,'QU‹MICA');
  OUTTEXTXY(222,4,'QU‹MICA');
  SETCOLOR(9);
  FOR i:= 1 TO 10 DO
    BEGIN
    RECTANGLE(i+110,i+70, i+500,i+110);
    RECTANGLE(i+110,i+130,i+500,i+170);
    RECTANGLE(i+110,i+190,i+500,i+230);
    RECTANGLE(i+110,i+250,i+500,i+290);
    RECTANGLE(i+110,i+310,i+500,i+350);
    END;
  SETTEXTSTYLE(2,0,5);
  SETCOLOR(4);
  OUTTEXTXY(300,75,'F1');
  OUTTEXTXY(300,135,'F2');
  OUTTEXTXY(300,195,'F3');
  OUTTEXTXY(300,255,'F4');
  OUTTEXTXY(300,315,'F5');
  SETTEXTSTYLE(1,0,4);
  SETCOLOR(2);
  OUTTEXTXY(175,77,'');
  OUTTEXTXY(175,137,'');
  OUTTEXTXY(175,197,'');
  OUTTEXTXY(177,257,'');
  OUTTEXTXY(177,317,'      Sair');
  WHILE c <> 0  DO
    BEGIN
      mouse.show;
      c:=mouse.waitforinput(leftbutton);
      mouse.hide;
      IF c < 0 THEN
        BEGIN
        mouse.getcoords(x,y);
         IF mouse.inbox(110,310,500,350,x,y) THEN c:=63;
         end;
         case c of
         63:begin
            som_2;
            Menu_principal;
           end;

end;
end;
END;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| MENU |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-|  C.C |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE c_c;

BEGIN
  CLEARDEVICE;
  SETTEXTSTYLE(4,0,5);
  SETCOLOR(15);
  OUTTEXTXY(75,1,'CORRENTE CONT‹NUA');
  SETCOLOR(8);
  OUTTEXTXY(75,2,'CORRENTE CONT‹NUA');
  OUTTEXTXY(75,3,'CORRENTE CONT‹NUA');
  OUTTEXTXY(75,4,'CORRENTE CONT‹NUA');
  SETCOLOR(9);
  FOR i:= 1 TO 10 DO
    BEGIN
    RECTANGLE(i+110,i+70, i+500,i+110);
    RECTANGLE(i+110,i+130,i+500,i+170);
    RECTANGLE(i+110,i+190,i+500,i+230);
    RECTANGLE(i+110,i+250,i+500,i+290);
    RECTANGLE(i+110,i+310,i+500,i+350);
    END;
  SETTEXTSTYLE(2,0,5);
  SETCOLOR(4);
  OUTTEXTXY(300,75,'F1');
  OUTTEXTXY(300,135,'F2');
  OUTTEXTXY(300,195,'F3');
  OUTTEXTXY(300,255,'F4');
  OUTTEXTXY(300,315,'F5');
  SETTEXTSTYLE(1,0,4);
  SETCOLOR(2);
  OUTTEXTXY(175,77,'');
  OUTTEXTXY(175,137,'');
  OUTTEXTXY(175,197,'');
  OUTTEXTXY(177,257,'');
  OUTTEXTXY(177,317,'      Sair');
  WHILE c <> 0  DO
    BEGIN
      mouse.show;
      c:=mouse.waitforinput(leftbutton);
      mouse.hide;
      IF c < 0 THEN
        BEGIN
        mouse.getcoords(x,y);
         IF mouse.inbox(110,310,500,350,x,y) THEN c:=63;
         end;
         case c of
         63:begin
            som_2;
            Menu_principal;
           end;

end;
end;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| MENU |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| C.A  |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE c_a;

BEGIN
  CLEARDEVICE;
  SETTEXTSTYLE(4,0,5);
  SETCOLOR(15);
  OUTTEXTXY(50,1,'CORRENTE ALTERNADA');
  SETCOLOR(8);
  OUTTEXTXY(50,2,'CORRENTE ALTERNADA');
  OUTTEXTXY(50,3,'CORRENTE ALTERNADA');
  OUTTEXTXY(50,4,'CORRENTE ALTERNADA');
  SETCOLOR(9);
  FOR i:= 1 TO 10 DO
    BEGIN
    RECTANGLE(i+110,i+70, i+500,i+110);
    RECTANGLE(i+110,i+130,i+500,i+170);
    RECTANGLE(i+110,i+190,i+500,i+230);
    RECTANGLE(i+110,i+250,i+500,i+290);
    RECTANGLE(i+110,i+310,i+500,i+350);
    END;
  SETTEXTSTYLE(2,0,5);
  SETCOLOR(4);
  OUTTEXTXY(300,75,'F1');
  OUTTEXTXY(300,135,'F2');
  OUTTEXTXY(300,195,'F3');
  OUTTEXTXY(300,255,'F4');
  OUTTEXTXY(300,315,'F5');
  SETTEXTSTYLE(1,0,4);
  SETCOLOR(2);
  OUTTEXTXY(175,77,'');
  OUTTEXTXY(175,137,'');
  OUTTEXTXY(175,197,'');
  OUTTEXTXY(177,257,'');
  OUTTEXTXY(177,317,'      Sair');
  WHILE c <> 0  DO
    BEGIN
      mouse.show;
      c:=mouse.waitforinput(leftbutton);
      mouse.hide;
      IF c < 0 THEN
        BEGIN
        mouse.getcoords(x,y);
         IF mouse.inbox(110,310,500,350,x,y) THEN c:=63;
         end;
         case c of
         63:begin
            som_2;
            Menu_principal;
           end;

end;
end;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| MENU |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| M–SICA |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE musica;

BEGIN
  CLEARDEVICE;
  SETTEXTSTYLE(4,0,5);
  SETCOLOR(15);
  OUTTEXTXY(225,1,'M–SICA');
  SETCOLOR(8);
  OUTTEXTXY(225,2,'M–SICA');
  OUTTEXTXY(225,3,'M–SICA');
  OUTTEXTXY(225,4,'M–SICA');
  SETCOLOR(9);
  FOR i:= 1 TO 10 DO
    BEGIN
    RECTANGLE(i+110,i+70, i+500,i+110);
    RECTANGLE(i+110,i+130,i+500,i+170);
    RECTANGLE(i+110,i+190,i+500,i+230);
    END;
  SETTEXTSTYLE(2,0,5);
  SETCOLOR(4);
  OUTTEXTXY(300,75,'F1');
  OUTTEXTXY(300,135,'F2');
  OUTTEXTXY(300,195,'F3');
  SETTEXTSTYLE(1,0,4);
  SETCOLOR(2);
  OUTTEXTXY(179,77,'       Mix');
  OUTTEXTXY(175,137,'     Piano');
  OUTTEXTXY(177,197,'      Sair');
  WHILE c <> 0  DO
    BEGIN
      mouse.show;
      c:=mouse.waitforinput(leftbutton);
      mouse.hide;
      IF c < 0 THEN
        BEGIN
        mouse.getcoords(x,y);
         IF mouse.inbox(110,130,500,170,x,y) THEN c:=60;
         IF mouse.inbox(110,190,500,230,x,y) THEN c:=61;
        end;
         case c of
         60:begin
             som_2;
             piano;
            end;
         61:begin
            som_2;
            Menu_principal;
           end;

end;
end;
END;



{*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*| MENU |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-| PRINCIPAL |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE Menu_principal;

BEGIN
 CLEARDEVICE;
 SETTEXTSTYLE(4,0,5);
 SETCOLOR(15);
 OUTTEXTXY(227,100,'GERAL');
 SETCOLOR(8);
 OUTTEXTXY(227,101,'GERAL');
 OUTTEXTXY(227,102,'GERAL');
 OUTTEXTXY(227,103,'GERAL');
 SETCOLOR(7);
 FOR a:= 1 TO 10 DO
 BEGIN
 SETCOLOR(9);
 RECTANGLE(a+10,a+30,a+170,a+70);
 RECTANGLE(a+215,a+30,a+385,a+70);
 RECTANGLE(a+430,a+30,a+600,a+70);
 RECTANGLE(a+10,a+130,a+170,a+170);
 RECTANGLE(a+10,a+230,a+170,a+270);
 RECTANGLE(a+10,a+330,a+170,a+370);
 RECTANGLE(a+430,a+130,a+600,a+170);
 RECTANGLE(a+430,a+230,a+600,a+270);
 RECTANGLE(a+430,a+330,a+600,a+370);
 RECTANGLE(a+10,a+430,a+600,a+470);
 END;
 DELAY(1000);
 SETCOLOR(4);
 SETTEXTSTYLE(2,0,5);
 OUTTEXTXY(80,35,'F1');
 OUTTEXTXY(290,35,'F2');
 OUTTEXTXY(515,35,'F3');
 OUTTEXTXY(80,135,'F4');
 OUTTEXTXY(515,135,'F5');
 OUTTEXTXY(80,235,'F6');
 OUTTEXTXY(515,235,'F7');
 OUTTEXTXY(80,335,'F8');
 OUTTEXTXY(515,335,'F9');
 OUTTEXTXY(290,435,'Esc');
 SETCOLOR(2);
 SETTEXTSTYLE(1,0,4);
 OUTTEXTXY(50,40,'Sinais');
 OUTTEXTXY(255,40,'Op‡”es');
 OUTTEXTXY(475,40,'Jogos');
 OUTTEXTXY(50,140,'F¡sica');
 OUTTEXTXY(455,140,'Qu¡mica');
 OUTTEXTXY(70,240,'C.C');
 OUTTEXTXY(490,240,'C.A');
 OUTTEXTXY(45,340,'M£sica');
 OUTTEXTXY(460,340,'Calcula');
 OUTTEXTXY(170,440,' Sair para o DOS');
 SETTEXTSTYLE(1,0,3);
 GETDATE(ano,mes,dia,d_s);
 SETCOLOR(15);
 OUTTEXTXY(250,230,''+dias[d_s]+'');
 SETCOLOR(8);
 OUTTEXTXY(227,263,intostr(dia,2)+'/'+intostr(mes,2)+'/'+intostr(ano,4));
 WHILE c<>27 DO
   BEGIN
    mouse.show;
    actua_hora;
    c:=mouse.waitforinput(leftbutton);
    mouse.hide;
    IF c < 0 THEN
       BEGIN
         mouse.getcoords(x,y);
         IF mouse.inbox(10,430,600,470,x,y) THEN c:=27;
         IF mouse.inbox(10,30,170,70,x,y) THEN c:=59;
         IF mouse.inbox(215,30,385,70,x,y) THEN c:=60;
         IF mouse.inbox(430,30,600,70,x,y) THEN c:=61;
         IF mouse.inbox(10,130,170,170,x,y) THEN c:=62;
         IF mouse.inbox(430,130,600,170,x,y) THEN c:=63;
         IF mouse.inbox(10,230,170,270,x,y) THEN c:=64;
         IF mouse.inbox(430,230,600,270,x,y) THEN c:=65;
         IF mouse.inbox(10,330,170,370,x,y) THEN c:=66;
       end;
    case c of
      27:begin
          som_2;
          fim;
         end;
      59:begin
          som_2;
          sinais;
         end;
      60:begin
          som_2;
          opcoes;
         end;
      61:begin
          som_2;
          jogos;
         end;
      62:begin
         som_2;
         fisica;
        end;
      63:begin
         som_2;
         quimica;
        end;
      64:begin
         som_2;
         c_c;
        end;
      65:begin
         som_2;
         c_a;
        end;
      66:begin
         som_2;
         musica;
        end;

end;
end;
END;




{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*| BEMVINDO  |-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

PROCEDURE Bemvindo;
BEGIN
   som_1;
   SETTEXTSTYLE(1,0,5);
   SETCOLOR(1);
   OUTTEXTXY(220,180,'Bemvindo');
   SETCOLOR(14);
   OUTTEXTXY(200,250,''+nome_s+'');
   DELAY(4000);
   Menu_principal;
END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*| PROCEDURE CŸDIGO |*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
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
   SETTEXTSTYLE(4,0,2);
   OUTTEXTXY(100,1,' Escreva o seu nome (m ximo 10 letras)   ');
   SETCOLOR(15);
   WRITELN('');
   WRITELN('');
   WRITE('              ');
   READLN(nome_s);
   SETCOLOR(2);
   OUTTEXTXY(100,50,' Escreva o c¢digo (m ximo 5 caracteres)  ');
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
  Aborta('EGA/VGA');
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
  mouse.init;
  f:=mouse.setup;
  pass_entrada;
  fim;
END.



