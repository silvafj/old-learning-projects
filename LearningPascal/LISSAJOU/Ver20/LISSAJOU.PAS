{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{|  PROGRAMA            => Lissajous V2.0                                  |}
{*  PROGRAMADO EM       => Turbo Pascal 6.0                                *}
{|  AUTOR               => Fernando Jorge de Almeida da Silva              |}
{*  ENDERE€O            => Juncal - Assequins 3750 †gueda                  *}
{|  TELEFONE            => (034) 602800                                    |}
{*  DATA DA PROGRAMA€ŽO => Janeiro/96                                      *}
{|  FUN€ŽO DO PROGRAMA  => Programa Principal                              |}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
PROGRAM Lissajous;
{$M 8192,0,21000}
USES
   crt,dos,graph,tpmouse,grafica;


{===================================> Tipos <================================}

TYPE
    registro = RECORD
  END;

    tit = array[1..6] of string;

{=================================> Constantes <=============================}

 CONST
   tab_cores:ARRAY[1..15] of STRING[15] = ('Preto',
                                           'Azul',
                                           'Verde',
                                           'Ciano',
                                           'Vermelho',
                                           'Magenta',
                                           'Castanho',
                                           'Cinza Claro',
                                           'Cinza',
                                           'Azul Claro',
                                           'Verde Claro',
                                           'Ciano Claro',
                                           'Vermelho Claro',
                                           'Amarelo',
                                           'Branco');

   tab_cores_de_fundo:ARRAY[1..15] of STRING[15] = ('Preto',
                                                    'Azul',
                                                    'Verde',
                                                    'Ciano',
                                                    'Vermelho',
                                                    'Magenta',
                                                    'Castanho',
                                                    'Cinza Claro',
                                                    'Cinza',
                                                    'Azul Claro',
                                                    'Verde Claro',
                                                    'Ciano Claro',
                                                    'Vermelho Claro',
                                                    'Amarelo',
                                                    'Branco');

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



{============================> Vari veis do programa <=======================}

VAR
   arq : FILE OF registro;
   reg : registro;
   cont,cor,x,y:integer;
   i,impy,coor1,coor2:integer;
   titulo:string;
   titulos:tit;
   mouse:mouseobj;
   f:boolean;
   a,b,c,g,rx,ry:INTEGER;
   xx,yy:REAL;
   desenha_cor:INTEGER;
   cores_aleatorias:STRING[10];
   cor_de_fundo:INTEGER;
   cores_aleatorias_de_fundo:STRING[10];
   desenho_com_modo:STRING[10];
   tempo_de_atraso:INTEGER;
   erro:INTEGER;

{=====================> Procedures declaradas mais … frente <================}

  Procedure Menu_configuracao;FORWARD;
  Procedure Menu_principal;FORWARD;

{==========================> Fun‡„o que lˆ uma tecla <=======================}

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

{==================> Executa determinados comandos no DOS <==================}

PROCEDURE EXECUTE(COMMAND:STRING);
BEGIN
     IF COMMAND<>'' THEN COMMAND:='/C '+COMMAND;
     SWAPVECTORS;
     EXEC(GETENV('COMSPEC'),COMMAND);
     SWAPVECTORS;
     IF DOSERROR<>0 THEN WRITELN('N„o foi poss¡vel executar o COMMAND.COM');
     DELAY(2000);
END;

{====================> Procedure que edita o tipo STRING <===================}

PROCEDURE ReadStr(var s:string;maxchars:integer;delcolor:word);

  CONST
    buff2: string[2] = 'c_';

  VAR
    i, int, currloc, oldcolor: integer;
    view: viewporttype;
    charbuff: string[2];
    ch: char;

  BEGIN
    S[0] := #0;
    Currloc := 0;
    Charbuff[0] := #1;
    Getviewsettings(view);
    If maxchars <= 0 then exit;
    Outtextxy(getx,gety,'_');
    Int := kb;
    Ch:=chr(int);
    Ch:=upcase(ch);
    Repeat
    While ch <> cr do BEGIN
      If ch=chr(27) then ch:=chr(32);
      If ch=chr(199) then ch:=chr(142);
      If ch=chr(229) then ch:=chr(153);
      If ch=chr(130) then ch:=chr(144);
      If (int=up) or (int=down) or (int=left) or (int=right) or (int=home)
        or (int=ends)or (int=pgup) or (int=pgdown) or (int=insert)
        or (int=delete) then ch:=chr(32);
      If ch = bs then BEGIN
        If currloc > 0 then BEGIN
           If currloc<= maxchars then BEGIN
             Oldcolor := getcolor;
             Setcolor(delcolor);
             Charbuff[1] := s[currloc];
             Buff2[1] := s[currloc];
             Outtextxy(getx-textwidth(charbuff),gety,buff2);
             Setcolor(oldcolor);
             Moveto(getx-textwidth(charbuff),gety);
             Dec(currloc);
             S[0]:=chr(currloc);
           END;
        END;
      END;
      If ch <> bs then BEGIN
        If currloc < maxchars then BEGIN
          Oldcolor := getcolor;
          Setcolor(delcolor);
          Outtextxy(getx,gety,'_');
          Setcolor(oldcolor);
          Inc(currloc);
          S[0] := chr(currloc);
          S[currloc] := ch;
          Outtext(ch);
        END
        ELSE BEGIN
          Sound(200); delay(100); nosound;
        END
      END;
      If currloc <= maxchars then
        Outtextxy(getx,gety,'_');
      Int := kb;
      Ch:=chr(int);
      Ch:=upcase(ch);
    END;
    Until ch=cr;
    If currloc <= maxchars then BEGIN
      Oldcolor := getcolor;
      Setcolor(getbkcolor);
      Outtextxy(getx,gety,'_');
      Setcolor(oldcolor);
    END;
    If length(s) = 0 then BEGIN
       Sound(200);
       Delay(100);
       Nosound;
       Readstr(s,maxchars,delcolor);
    END;
  END;

{================> Imprime a Vers„o e o autor nos cantos do ecran <==========}

PROCEDURE Versao;

    BEGIN
      setcolor(14);
      Line(1,40,639,40);
      Line(1,440,639,440);
      settextstyle(3,0,1);
      settextjustify(0,2);
      outtextxy(10,10,'Lissajous  V2.0');
      outtextxy(500,10,'Janeiro  1996');
      outtextxy(10,450,'Fernando Jorge Almeida Silva');
      outtextxy(500,450,'GL corporation');
    END;

{============================> Desenha o lissajous <=========================}

PROCEDURE Desenha_Lissajous;
  VAR
    valora,valorb,valorc:string;
    erro:integer;

 BEGIN
   If desenho_com_modo = 'Manual' then
    BEGIN
      Cleardevice;
      Setbkcolor(1);
      versao;
      Setcolor(15);
      Settextstyle(3,0,1);
      Settextjustify(1,2);
      Outtextxy(320,50,'Introduza o valor de A (m ximo 9)');
      repeat
         moveto(300,69);
         setfillstyle(0,1);
         bar(0,69,640,89);
         readstr(valora,1,1);
         val(valora,a,erro);
      until (erro=0) and (a>0) and (a<=50);
      Outtextxy(320,94,'Introduza o valor de B (m ximo 9)');
      repeat
         moveto(300,114);
         setfillstyle(0,1);
         bar(0,120,640,134);
         readstr(valorb,1,1);
         val(valorb,b,erro);
      until (erro=0) and (b>0) and (b<=50);
      Outtextxy(320,134,'Introduza o valor de C (m ximo 9)');
      repeat
         moveto(300,154);
         setfillstyle(0,1);
         bar(0,159,640,174);
         readstr(valorc,1,1);
         val(valorc,c,erro);
      until (erro=0) and (c>0) and (c<=50);
      Cleardevice;
      Setbkcolor(cor_de_fundo);
      If cores_aleatorias = 'RANDOM(15)' then
        BEGIN
          For g:=0 to 500 do
           BEGIN
             yy:=220+220*SIN(c+a*PI*g/100);
             xx:=300+200*SIN(b*PI*g/100);
             ry:=ROUND(yy);
             rx:=ROUND(xx);
             Putpixel(rx,ry,RANDOM(15));
             Delay(tempo_de_atraso);
           END;
          Repeat
          Until keypressed;
          Setbkcolor(1);
          Menu_principal;
        END
      ELSE
        BEGIN
          Setbkcolor(cor_de_fundo);
          For g:=0 to 500 do
           BEGIN
             yy:=220+220*SIN(c+a*PI*g/100);
             xx:=300+200*SIN(b*PI*g/100);
             ry:=ROUND(yy);
             rx:=ROUND(xx);
             Putpixel(rx,ry,desenha_cor);
             Delay(tempo_de_atraso);
           END;
          Repeat
          Until keypressed;
          Setbkcolor(1);
          Menu_principal;
        END;
    END
      ELSE
      Cleardevice;
      Randomize;
      Repeat
       Setbkcolor(0);
       Cleardevice;
       a:=RANDOM(9);
       b:=RANDOM(9);
       c:=RANDOM(9);
       For g:=0 to 500 do
         BEGIN
           yy:=220+220*SIN(c+a*PI*g/100);
           xx:=300+200*SIN(b*PI*g/100);
           ry:=ROUND(yy);
           rx:=ROUND(xx);
           Putpixel(rx,ry,15);
           Delay(tempo_de_atraso);
         END;
       Delay(500);
       For g:=0 to 500 do
         BEGIN
           yy:=220+220*SIN(c+a*PI*g/100);
           xx:=300+200*SIN(b*PI*g/100);
           ry:=ROUND(yy);
           rx:=ROUND(xx);
           Putpixel(rx,ry,RANDOM(15));
           Delay(tempo_de_atraso);
         END;
       Delay(500);
       Until keypressed;
       Setbkcolor(1);
       Menu_Principal;
  END;

{=======================> Procedure de ®Trashing¯ do teclado <===============}

PROCEDURE LimpTec;

    VAR
     xpto:integer;

    BEGIN
      xpto:=kb;
    END;

{======================> Bot„o sem aur‚ola de actividade <===================}

PROCEDURE BotaoXY(coor1,tam,larg:integer;cor1,cor2,cor3,cor4,letr1:word);

    BEGIN
      setlinestyle(0,0,3);
      setfillstyle(1,cor1);
      bar(coor1,larg,coor1+tam,larg+30);
      setcolor(cor2);
      line(coor1,larg+30,coor1+tam,larg+30);
      line(coor1+tam,larg,coor1+tam,larg+30);
      setcolor(cor3);
      line(coor1,larg,coor1+tam,larg);
      line(coor1,larg,coor1,larg+30);
      putpixel(coor1+1,larg+30,cor2);
      putpixel(coor1+tam,larg+1,cor2);
      setlinestyle(0,0,1);
    END;

{=======================> Desenha as letras no bot„o <=======================}

PROCEDURE Letras(cont:integer;letr:word);

   BEGIN
      settextstyle(1,0,2);
      coor1:=320;
      case cont of
        3:titulo:=titulos[cont-2];
        4:titulo:=titulos[cont-2];
        5:titulo:=titulos[cont-2];
        6:titulo:=titulos[cont-2];
        7:titulo:=titulos[cont-2];
        8:titulo:=titulos[cont-2];
      end;
      settextjustify(1,2);
      setcolor(letr);
      outtextxy(coor1,coor2,titulo);
      settextjustify(0,2);
   END;

{===========================> Activa | Desactiva bot„o <=====================}

PROCEDURE Activimp(cor:word);

   BEGIN
     setlinestyle(0,0,1);
     setcolor(cor);
     rectangle(112,impy-3,518,33+impy);
   END;

{=============================> Desenha um Bot„o <===========================}

PROCEDURE Botao(coor2:integer;cor1,cor2,cor3,cor4,letr:word);

   BEGIN
     setlinestyle(0,0,3);
     setfillstyle(1,cor1);
     bar(115,coor2,515,30+coor2);
     setcolor(cor2);
     line(115,30+coor2,515,30+coor2);
     line(515,coor2,515,30+coor2);
     setcolor(cor3);
     line(115,coor2,515,coor2);
     line(115,coor2,115,30+coor2);
     putpixel(116,30+coor2,cor2);
     putpixel(515,coor2+1,cor2);
     i:=coor2 div 40;
     letras(i,letr);
     setlinestyle(0,0,1);
     setcolor(cor4);
     rectangle(112,coor2-3,518,33+coor2);
   END;

{=======================> Desce uma op‡„o nos menus <========================}

PROCEDURE Avanca(cor:word);

   BEGIN
     activimp(cor);
     impy:=impy-40;
     activimp(1);
     impy:=impy+40;
     sound(30);
     delay(100);
     nosound;
   END;

{========================> Sobe uma op‡„o nos menus <========================}

PROCEDURE Atrasa(cor:word);

   BEGIN
     activimp(cor);
     impy:=impy+40;
     activimp(1);
     impy:=impy-40;
     sound(30);
     delay(100);
     nosound;
   END;

{====================================> Som <=================================}

PROCEDURE Som;

    BEGIN
      sound(200);
      delay(100);
      nosound;
    END;

{=============================> Menu das Cores <=============================}

PROCEDURE Menu_cores;

   VAR
     i,y,car,x: integer;

   BEGIN
     if keypressed then limptec;
     cleardevice;
     impy:=180;
     setrgbpalette(3,20,30,52);
     setfillstyle(1,0);
     bar(0,0,640,480);
     settextstyle(1,0,5);
     setcolor(14);
     settextjustify(1,2);
     outtextxy(320,80,'Cores');
     versao;
     settextjustify(0,2);
     coor2:=180;
     setlinestyle(0,0,3);
     settextstyle(1,0,2);
     repeat
       botao(coor2,9,1,3,1,14);
       coor2:=coor2+40;
     until coor2=300;
     activimp(7);
     if keypressed then limptec;
     while car <> 27 do begin
       mouse.show;
       car:=mouse.waitforinput(leftbutton);
       if car < 0 then begin
          mouse.getcoords(x,y);
          mouse.hide;
          activimp(7);
          if mouse.inbox (115,180,515,210,x,y) then begin
             activimp(1);
             impy:=180;
             car:=13;
          end;
          if mouse.inbox (115,220,515,250,x,y) then begin
             activimp(1);
             impy:=220;
             car:=13;
          end;
          if mouse.inbox (115,260,515,290,x,y) then begin
             activimp(1);
             impy:=260;
             car:=13;
          end;
          mouse.show;
       end;
       if car = 80 then begin
          mouse.hide;
          impy:=impy+40;
          if impy = 300 then begin
             impy:=impy-40;
             activimp(1);
             impy:=180;
             activimp(7);
             sound(30);
             delay(100);
             nosound;
          end
          else
            avanca(7);
            mouse.show;
       end;
      if car = 72 then begin
         mouse.hide;
         impy:=impy-40;
          if impy=140 then begin
             impy:=impy+40;
             activimp(1);
             impy:=260;
             activimp(7);
             sound(30);
             delay(100);
             nosound;
          end
          else
            atrasa(7);
            mouse.show;
       end;
       if car = 13 then begin
          case impy of
             180:begin
                   som;
                   coor2:=180;
                   mouse.hide;
                   botao(180,9,3,1,7,14);
                   delay(500);
                   botao(180,9,1,3,1,14);
                   If desenha_cor = 1 then desenha_cor := 16;
                   Desenha_cor := desenha_cor - 1;
                   Cores_aleatorias :='';
                   titulos[2]:='C“r : '+tab_cores[desenha_cor - 1];
                 end;

             220:begin
                   som;
                   coor2:=220;
                   mouse.hide;
                   botao(220,9,3,1,7,14);
                   delay(500);
                   botao(220,9,1,3,1,14);
                   Cores_aleatorias :='RANDOM(15)';
                   titulos[2]:='C“r : ';
                   Desenha_cor := 16;
                 end;
            260:begin
                  som;
                  mouse.hide;
                  coor2:=260;
                  botao(260,9,3,1,7,14);
                  delay(500);
                  botao(260,9,1,3,1,14);
                  Menu_configuracao;
                  closegraph;
                  halt(1);
                end;
          end;
          impy:=180;
          activimp(7);
      end;
     end;
     mouse.hide;
     activimp(1);
     impy:=260;
     som;
     activimp(7);
     coor2:=260;
     botao(260,9,3,1,7,14);
     delay(500);
     menu_configuracao;
     closegraph;
     halt(1);
   END;

{=========================> Menu das Cores de Fundo <========================}

PROCEDURE Menu_cores_de_fundo;

   VAR
     i,y,car,x: integer;

   BEGIN
     if keypressed then limptec;
     cleardevice;
     impy:=180;
     setrgbpalette(3,20,30,52);
     setfillstyle(1,0);
     bar(0,0,640,480);
     settextstyle(1,0,5);
     setcolor(14);
     settextjustify(1,2);
     outtextxy(320,80,'Cores de Fundo');
     versao;
     settextjustify(0,2);
     coor2:=180;
     setlinestyle(0,0,3);
     settextstyle(1,0,2);
     repeat
       botao(coor2,9,1,3,1,14);
       coor2:=coor2+40;
     until coor2=300;
     activimp(7);
     if keypressed then limptec;
     while car <> 27 do begin
       mouse.show;
       car:=mouse.waitforinput(leftbutton);
       if car < 0 then begin
          mouse.getcoords(x,y);
          mouse.hide;
          activimp(7);
          if mouse.inbox (115,180,515,210,x,y) then begin
             activimp(1);
             impy:=180;
             car:=13;
          end;
          if mouse.inbox (115,220,515,250,x,y) then begin
             activimp(1);
             impy:=220;
             car:=13;
          end;
          if mouse.inbox (115,260,515,290,x,y) then begin
             activimp(1);
             impy:=260;
             car:=13;
          end;
          mouse.show;
       end;
       if car = 80 then begin
          mouse.hide;
          impy:=impy+40;
          if impy = 300 then begin
             impy:=impy-40;
             activimp(1);
             impy:=180;
             activimp(7);
             sound(30);
             delay(100);
             nosound;
          end
          else
            avanca(7);
            mouse.show;
       end;
      if car = 72 then begin
         mouse.hide;
         impy:=impy-40;
          if impy=140 then begin
             impy:=impy+40;
             activimp(1);
             impy:=260;
             activimp(7);
             sound(30);
             delay(100);
             nosound;
          end
          else
            atrasa(7);
            mouse.show;
       end;
       if car = 13 then begin
          case impy of
             180:begin
                   som;
                   coor2:=180;
                   mouse.hide;
                   botao(180,9,3,1,7,14);
                   delay(500);
                   botao(180,9,1,3,1,14);
                   If cor_de_fundo = 15 then cor_de_fundo := -1;
                   Cor_de_fundo := cor_de_fundo + 1;
                   Cores_aleatorias_de_fundo :='';
                   titulos[2]:='C“r : '+tab_cores_de_fundo[cor_de_fundo - 1];
                 end;

             220:begin
                   som;
                   coor2:=220;
                   mouse.hide;
                   botao(220,9,3,1,7,14);
                   delay(500);
                   botao(220,9,1,3,1,14);
                   Cores_aleatorias_de_fundo :='RANDOM(15)';
                   titulos[2]:='C“r : ';
                   cor_de_fundo := -1;
                 end;
            260:begin
                  som;
                  mouse.hide;
                  coor2:=260;
                  botao(260,9,3,1,7,14);
                  delay(500);
                  botao(260,9,1,3,1,14);
                  Menu_configuracao;
                  closegraph;
                  halt(1);
                end;
          end;
          impy:=180;
          activimp(7);
      end;
     end;
     mouse.hide;
     activimp(1);
     impy:=260;
     som;
     activimp(7);
     coor2:=260;
     botao(260,9,3,1,7,14);
     delay(500);
     menu_configuracao;
     closegraph;
     halt(1);
   END;

{========================> Menu do Modo de desenho <=========================}

PROCEDURE Modo_de_desenho;

   VAR
     i,y,car,x: integer;

   BEGIN
     titulos[4]:='Voltar ao Menu Anterior';
     if keypressed then limptec;
     cleardevice;
     impy:=180;
     setrgbpalette(3,20,30,52);
     setfillstyle(1,0);
     bar(0,0,640,480);
     settextstyle(1,0,5);
     setcolor(14);
     settextjustify(1,2);
     outtextxy(320,80,'Desenho');
     versao;
     settextjustify(0,2);
     coor2:=180;
     setlinestyle(0,0,3);
     settextstyle(1,0,2);
     repeat
       botao(coor2,9,1,3,1,14);
       coor2:=coor2+40;
     until coor2=300;
     activimp(7);
     if keypressed then limptec;
     while car <> 27 do begin
       mouse.show;
       car:=mouse.waitforinput(leftbutton);
       if car < 0 then begin
          mouse.getcoords(x,y);
          mouse.hide;
          activimp(7);
          if mouse.inbox (115,180,515,210,x,y) then begin
             activimp(1);
             impy:=180;
             car:=13;
          end;
          if mouse.inbox (115,220,515,250,x,y) then begin
             activimp(1);
             impy:=220;
             car:=13;
          end;
          if mouse.inbox (115,260,515,290,x,y) then begin
             activimp(1);
             impy:=260;
             car:=13;
          end;
          mouse.show;
       end;
       if car = 80 then begin
          mouse.hide;
          impy:=impy+40;
          if impy = 300 then begin
             impy:=impy-40;
             activimp(1);
             impy:=180;
             activimp(7);
             sound(30);
             delay(100);
             nosound;
          end
          else
            avanca(7);
            mouse.show;
       end;
      if car = 72 then begin
         mouse.hide;
         impy:=impy-40;
          if impy=140 then begin
             impy:=impy+40;
             activimp(1);
             impy:=260;
             activimp(7);
             sound(30);
             delay(100);
             nosound;
          end
          else
            atrasa(7);
            mouse.show;
       end;
       if car = 13 then begin
          case impy of
             180:begin
                   som;
                   coor2:=180;
                   mouse.hide;
                   botao(180,9,3,1,7,14);
                   delay(500);
                   botao(180,9,1,3,1,14);
                   desenho_com_modo := 'Automatico';
                   Menu_configuracao;
                 end;
             220:begin
                   som;
                   coor2:=220;
                   mouse.hide;
                   botao(220,9,3,1,7,14);
                   delay(500);
                   botao(220,9,1,3,1,14);
                   desenho_com_modo := 'Manual';
                   Menu_configuracao;
                  end;
            260:begin
                  som;
                  mouse.hide;
                  coor2:=260;
                  botao(260,9,3,1,7,14);
                  delay(500);
                  botao(260,9,1,3,1,14);
                  Menu_configuracao;
                  closegraph;
                  halt(1);
                end;
          end;
          impy:=180;
          activimp(7);
      end;
     end;
     mouse.hide;
     activimp(1);
     impy:=260;
     som;
     activimp(7);
     coor2:=260;
     botao(260,9,3,1,7,14);
     delay(500);
     menu_configuracao;
     closegraph;
     halt(1);
   END;



{=============================> Menu da Configura‡„o <=======================}

PROCEDURE Menu_configuracao;

   VAR
     i,y,car,x: integer;

   BEGIN
     titulos[2]:='C“r';
     titulos[3]:='C“r de Fundo';
     titulos[4]:='Desenho';
     titulos[5]:='Voltar ao Menu Anterior';
     if keypressed then limptec;
     cleardevice;
     impy:=180;
     setrgbpalette(3,20,30,52);
     setfillstyle(1,0);
     bar(0,0,640,480);
     settextstyle(1,0,5);
     setcolor(14);
     settextjustify(1,2);
     outtextxy(320,80,'Configura‡„o');
     versao;
     settextjustify(0,2);
     coor2:=180;
     setlinestyle(0,0,3);
     settextstyle(1,0,2);
     repeat
       botao(coor2,9,1,3,1,14);
       coor2:=coor2+40;
     until coor2=340;
     activimp(7);
     if keypressed then limptec;
     while car <> 27 do begin
       mouse.show;
       car:=mouse.waitforinput(leftbutton);
       if car < 0 then begin
          mouse.getcoords(x,y);
          mouse.hide;
          activimp(7);
          if mouse.inbox (115,180,515,210,x,y) then begin
             activimp(1);
             impy:=180;
             car:=13;
          end;
          if mouse.inbox (115,220,515,250,x,y) then begin
             activimp(1);
             impy:=220;
             car:=13;
          end;
          if mouse.inbox (115,260,515,290,x,y) then begin
             activimp(1);
             impy:=260;
             car:=13;
          end;
          if mouse.inbox (115,300,515,330,x,y) then begin
             activimp(1);
             impy:=300;
             car:=13;
          end;
          mouse.show;
       end;
       if car = 80 then begin
          mouse.hide;
          impy:=impy+40;
          if impy = 340 then begin
             impy:=impy-40;
             activimp(1);
             impy:=180;
             activimp(7);
             sound(30);
             delay(100);
             nosound;
          end
          else
            avanca(7);
            mouse.show;
       end;
      if car = 72 then begin
         mouse.hide;
         impy:=impy-40;
          if impy=140 then begin
             impy:=impy+40;
             activimp(1);
             impy:=300;
             activimp(7);
             sound(30);
             delay(100);
             nosound;
          end
          else
            atrasa(7);
            mouse.show;
       end;
       if car = 13 then begin
          case impy of
             180:begin
                   som;
                   coor2:=180;
                   mouse.hide;
                   botao(180,9,3,1,7,14);
                   delay(500);
                   botao(180,9,1,3,1,14);
                   titulos[2]:='C“r : '+tab_cores[desenha_cor];
                   titulos[3]:='Aleat¢rias';
                   titulos[4]:='Voltar ao Menu Anterior';
                   Menu_cores;
                   Menu_principal;
                   closegraph;
                   halt;
                 end;

             220:begin
                   som;
                   coor2:=220;
                   mouse.hide;
                   botao(220,9,3,1,7,14);
                   delay(500);
                   botao(220,9,1,3,1,14);
                   titulos[2]:='C“r : '+tab_cores_de_fundo[cor_de_fundo];
                   titulos[3]:='Aleat¢rias';
                   titulos[4]:='Voltar ao Menu Anterior';
                   Menu_cores_de_fundo;
                   Menu_principal;
                   closegraph;
                   halt(1);
                 end;
            260:begin
                  som;
                  mouse.hide;
                  coor2:=260;
                  botao(260,9,3,1,7,14);
                  delay(500);
                  botao(260,9,1,3,1,14);
                  If desenho_com_modo = 'Automatico' then
                    begin
                      titulos[2]:='Autom tico  *';
                      titulos[3]:='Manual';
                    end
                  else
                    begin
                      titulos[2]:='Autom tico';
                      titulos[3]:='Manual  *';
                    end;
                  Modo_de_desenho;
                  Menu_principal;
                  closegraph;
                  halt(1);
                end;
            300:begin
                  som;
                  mouse.hide;
                  coor2:=300;
                  botao(300,9,3,1,7,14);
                  delay(500);
                  botao(300,9,1,3,1,14);
                  Menu_principal;
                  closegraph;
                  halt(1);
                end;
          end;
          impy:=140;
          activimp(7);
       end;
     end;
     mouse.hide;
     activimp(1);
     impy:=300;
     som;
     activimp(7);
     coor2:=300;
     botao(300,9,3,1,7,14);
     delay(500);
     menu_principal;
     closegraph;
     halt(1);
   END;

{=========================> Finaliza‡„o do programa <========================}

PROCEDURE Sair;

   BEGIN
     closegraph;
     halt;
   END;

{==============================> Menu Principal <============================}

PROCEDURE Menu_principal;

   VAR
     i,y,car,x: integer;

   BEGIN
      titulos[2]:='Lissajous';
      titulos[3]:='Configura‡„o';
      titulos[4]:='Sair';
      if keypressed then
        while keypressed do
          limptec;
      cleardevice;
      impy:=180;
      setfillstyle(1,0);
      settextstyle(1,0,5);
      setcolor(14);
      settextjustify(1,2);
      outtextxy(320,70,'MENU PRINCIPAL');
      versao;
      coor2:=180;
      setlinestyle(0,0,3);
      settextstyle(1,0,2);
      repeat
        botao(coor2,9,1,3,1,14);
        coor2:=coor2+40;
      until coor2=300;
      activimp(7);
      if keypressed then limptec;
      while car <> 255 do begin
        mouse.show;
        car:=mouse.waitforinput(leftbutton);
        if car < 0 then begin
           mouse.getcoords(x,y);
           mouse.hide;
           activimp(7);
           if mouse.inbox (115,180,515,210,x,y) then begin
              activimp(1);
              impy:=180;
              car:=13;
           end;
           if mouse.inbox (115,220,515,250,x,y) then begin
              activimp(1);
              impy:=220;
              car:=13;
           end;
           if mouse.inbox (115,260,515,290,x,y) then begin
              activimp(1);
              impy:=260;
              car:=13;
           end;
           mouse.show;
        end;
        if car = 80 then begin
           mouse.hide;
           impy:=impy+40;
           if impy = 300 then begin
              impy:=impy-40;
              activimp(1);
              impy:=180;
              activimp(7);
              sound(30);
              delay(100);
              nosound;
           end
           else
             avanca(7);
             mouse.show;
        end;
       if car = 72 then begin
          mouse.hide;
          impy:=impy-40;
          if impy=140 then begin
             impy:=impy+40;
             activimp(1);
             impy:=260;
             activimp(7);
             sound(30);
             delay(100);
             nosound;
          end
          else
            atrasa(7);
            mouse.show;
       end;
       if car = 27 then begin
         activimp(1);
         car:=13;
         impy:=260;
       end;
       if car = 13 then begin
          case impy of
             180:begin
                   som;
                   coor2:=180;
                   mouse.hide;
                   botao(180,9,3,1,7,14);
                   delay(500);
                   botao(180,9,1,3,1,14);
                   Desenha_Lissajous;
                   closegraph;
                   halt(1);
                 end;

             220:begin
                   som;
                   coor2:=220;
                   mouse.hide;
                   botao(220,9,3,1,7,14);
                   delay(500);
                   botao(220,9,1,3,1,14);
                   Menu_configuracao;
                   closegraph;
                   halt(1);
                 end;
            260:begin
                  som;
                  mouse.hide;
                  coor2:=260;
                  botao(260,9,3,1,7,14);
                  delay(500);
                  botao(260,9,1,3,1,14);
                  Sair;
                  halt;
                  activimp(1);
                end;
          end;
          impy:=180;
          activimp(7);
       end;
     end;
     closegraph;
     halt(1);
   END;

BEGIN
  checkbreak:=false;
  setcbreak(checkbreak);
  assign(arq,'apre_lis.exe');
  {$I-}
  reset(arq);
  {$I+}
  if ioresult <> 0
   then
     begin
       writeln('Faltando ficheiro de apresenta‡„o');
       delay(2000);
       halt;
     end;
  close(arq);
  If paramcount > 1 then
    begin
      writeln('Demasiados parametros');
      halt;
    end;
  If paramcount=0 then
    begin
      tempo_de_atraso:=0;
    end
  else
   begin
     val(paramstr(1),tempo_de_atraso,erro);
     If (erro <> 0) then
       begin
         writeln('Tempo de atraso inv lido !!! Por Favor repita');
         writeln('Por Exemplo:  \LISSAJOU  100');
         delay(100);
         halt;
       end;
   end;
  execute('apre_lis LISúsajous_2');
  Inicia_graficos;
  Cleardevice;
  Setbkcolor(1);
  mouse.init;
  f:=mouse.setup;
  mouse.hide;
  desenha_cor := 15;
  cor_de_fundo := 0;
  desenho_com_modo := 'Automatico';
  Menu_Principal;
  Closegraph;
  Halt;
END.