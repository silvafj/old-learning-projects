{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{|  PROGRAMA            => Lissajous V3.0                                  |}
{*  PROGRAMADO EM       => Turbo Pascal 6.0                                *}
{|  AUTOR               => Fernando Jorge de Almeida da Silva              |}
{*  ENDERE€O            => Juncal - Assequins 3750 †gueda                  *}
{|  TELEFONE            => (034) 602800                                    |}
{*  DATA DA PROGRAMA€ŽO => Fevereiro/96                                    *}
{|  FUN€ŽO DO PROGRAMA  => Programa Principal                              |}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
PROGRAM Lissajous;
{$M 10000,100000,180000}
USES
   Crt,Dos,Graph,Tpmouse,Grafica,Apresent,Glib1,GoldPlay;

{===================================> Tipos <================================}

TYPE
    registro = RECORD
  END;

{============================> Vari veis do programa <=======================}

VAR
   arq : FILE OF registro;
   reg : registro;
   cont,cor,x,y:integer;
   i,impy,coor1,coor2:integer;
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
   a_cor:INTEGER;
   escreve_cor:STRING;
   escreve_cor_fundo:STRING;
   out : BYTE;

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

{================> Imprime a Vers„o e o autor nos cantos do ecran <==========}

PROCEDURE Versao;

    BEGIN
      setcolor(14);
      Line(1,40,639,40);
      Line(1,440,639,440);
      settextstyle(3,0,1);
      settextjustify(0,2);
      outtextxy(10,10,'Lissajous  V3.0');
      outtextxy(480,10,'Fevereiro  1996');
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
      repeat
         valora:= RStrN(100,50,3,4,'3','Valor A (m ximo 9)',out,False);
         valora:= RStrN(100,50,3,4,'3','Valor A (m ximo 9)',out,True);
         val(valora,a,erro);
      until (erro=0) and (a>0) and (a<=9);
      repeat
         valorb:= RStrN(100,100,3,4,'5','Valor B (m ximo 9)',out,False);
         valorb:= RStrN(100,100,3,4,'5','Valor B (m ximo 9)',out,True);
         val(valorb,b,erro);
      until (erro=0) and (b>0) and (b<=9);
      repeat
         valorc:= RStrN(100,150,3,4,'8','Valor C (m ximo 9)',out,False);
         valorc:= RStrN(100,150,3,4,'8','Valor C (m ximo 9)',out,True);
         val(valorc,c,erro);
      until (erro=0) and (c>0) and (c<=9);
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
      StartPlaying;
      MasterVolume(64);
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
       StopPlaying;
       Setbkcolor(1);
       Menu_Principal;
  END;

{========> Avisa o utilizador caso este introduza parametros errados <=======}

PROCEDURE Sintax;
begin
   Writeln;
   Writeln('GL corporation     Lissajous V3.0');
   Writeln;
   Writeln('Sintax: LISSAJOU <Ficheiro MOD> <Tempo de Atraso>');
   Writeln('        (O nome do ficheiro deve ser inserido sem extens„o)');
   Writeln('        (O Tempo de atraso tem que ser menor do que 100)');

   Writeln;
end;

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
     sound(500);
     delay(75);
     nosound;
   END;

{========================> Sobe uma op‡„o nos menus <========================}

PROCEDURE Atrasa(cor:word);

   BEGIN
     activimp(cor);
     impy:=impy+40;
     activimp(1);
     impy:=impy-40;
     sound(500);
     delay(75);
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
     Settextstyle(1,0,2);
     Settextjustify(1,2);
     Setcolor(15);
     If Cores_aleatorias ='' then begin
       If (desenha_cor = 0) then escreve_cor :='Preto';
       If (desenha_cor = 1) then escreve_cor :='Azul';
       If (desenha_cor = 2) then escreve_cor :='Verde';
       If (desenha_cor = 3) then escreve_cor :='Ciano';
       If (desenha_cor = 4) then escreve_cor :='Vermelho';
       If (desenha_cor = 5) then escreve_cor :='Magenta';
       If (desenha_cor = 6) then escreve_cor :='Castanho';
       If (desenha_cor = 7) then escreve_cor :='Cinza Claro';
       If (desenha_cor = 8) then escreve_cor :='Cinza';
       If (desenha_cor = 9) then escreve_cor :='Azul Claro';
       If (desenha_cor = 10) then escreve_cor :='Verde Claro';
       If (desenha_cor = 11) then escreve_cor :='Ciano Claro';
       If (desenha_cor = 12) then escreve_cor :='Vermelho Claro';
       If (desenha_cor = 13) then escreve_cor :='Magenta Claro';
       If (desenha_cor = 14) then escreve_cor :='Amarelo';
       If (desenha_cor = 15) then escreve_cor :='Branco';
       Setcolor(15);
       Outtextxy(320,180,'C“r : '+escreve_cor);
       Outtextxy(320,220,'Aleat¢rias');
      end
      else
        begin
          Outtextxy(320,180,'C“r');
          Outtextxy(320,220,'Aleat¢rias  *');
        end;
     Outtextxy(320,260,'Voltar ao Menu Anterior');
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
             sound(500);
             delay(75);
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
             sound(500);
             delay(75);
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
                   mouse.hide;
                   If desenha_cor = 0 then desenha_cor := 16;
                   Desenha_cor := desenha_cor - 1;
                   Cores_aleatorias :='';
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   coor2:=180;
                   setlinestyle(0,0,3);
                   settextstyle(1,0,2);
                   repeat
                     botao(coor2,9,1,3,1,14);
                     coor2:=coor2+40;
                   until coor2=300;
                   If (desenha_cor = 0) then escreve_cor :='Preto';
                   If (desenha_cor = 1) then escreve_cor :='Azul';
                   If (desenha_cor = 2) then escreve_cor :='Verde';
                   If (desenha_cor = 3) then escreve_cor :='Ciano';
                   If (desenha_cor = 4) then escreve_cor :='Vermelho';
                   If (desenha_cor = 5) then escreve_cor :='Magenta';
                   If (desenha_cor = 6) then escreve_cor :='Castanho';
                   If (desenha_cor = 7) then escreve_cor :='Cinza Claro';
                   If (desenha_cor = 8) then escreve_cor :='Cinza';
                   If (desenha_cor = 9) then escreve_cor :='Azul Claro';
                   If (desenha_cor = 10) then escreve_cor :='Verde Claro';
                   If (desenha_cor = 11) then escreve_cor :='Ciano Claro';
                   If (desenha_cor = 12) then escreve_cor :='Vermelho Claro';
                   If (desenha_cor = 13) then escreve_cor :='Magenta Claro';
                   If (desenha_cor = 14) then escreve_cor :='Amarelo';
                   If (desenha_cor = 15) then escreve_cor :='Branco';
                   Setcolor(15);
                   Outtextxy(320,180,'C“r : '+escreve_cor);
                   Outtextxy(320,220,'Aleat¢rias');
                   Outtextxy(320,260,'Voltar ao Menu Anterior');
                 end;
             220:begin
                   mouse.hide;
                   Desenha_cor := 16;
                   Cores_aleatorias :='RANDOM(15)';
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   coor2:=180;
                   setlinestyle(0,0,3);
                   settextstyle(1,0,2);
                   repeat
                     botao(coor2,9,1,3,1,14);
                     coor2:=coor2+40;
                   until coor2=300;
                   Setcolor(15);
                   Outtextxy(320,180,'C“r');
                   Outtextxy(320,220,'Aleat¢rias  *');
                   Outtextxy(320,260,'Voltar ao Menu Anterior');
                 end;
            260:begin
                   mouse.hide;
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   For a_cor:=0 to 15 do
                     begin
                       setcolor(a_cor);
                       Outtextxy(320,260,'Voltar ao Menu Anterior');
                       delay(25);
                     end;
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
     Settextstyle(1,0,2);
     Settextjustify(1,2);
     Setcolor(15);
     If Cores_aleatorias_de_fundo ='' then begin
       If (cor_de_fundo = 0) then escreve_cor_fundo :='Preto';
       If (cor_de_fundo = 1) then escreve_cor_fundo :='Azul';
       If (cor_de_fundo = 2) then escreve_cor_fundo :='Verde';
       If (cor_de_fundo = 3) then escreve_cor_fundo :='Ciano';
       If (cor_de_fundo = 4) then escreve_cor_fundo :='Vermelho';
       If (cor_de_fundo = 5) then escreve_cor_fundo :='Magenta';
       If (cor_de_fundo = 6) then escreve_cor_fundo :='Castanho';
       If (cor_de_fundo = 7) then escreve_cor_fundo :='Cinza Claro';
       If (cor_de_fundo = 8) then escreve_cor_fundo :='Cinza';
       If (cor_de_fundo = 9) then escreve_cor_fundo :='Azul Claro';
       If (cor_de_fundo = 10) then escreve_cor_fundo :='Verde Claro';
       If (cor_de_fundo = 11) then escreve_cor_fundo :='Ciano Claro';
       If (cor_de_fundo = 12) then escreve_cor_fundo :='Vermelho Claro';
       If (cor_de_fundo = 13) then escreve_cor_fundo :='Magenta Claro';
       If (cor_de_fundo = 14) then escreve_cor_fundo :='Amarelo';
       If (cor_de_fundo = 15) then escreve_cor_fundo :='Branco';
       Setcolor(15);
       Outtextxy(320,180,'C“r : '+escreve_cor_fundo);
       Outtextxy(320,220,'Aleat¢rias');
      end
      else
       begin
         Outtextxy(320,180,'C“r');
         Outtextxy(320,220,'Aleat¢rias  *');
       end;
     Outtextxy(320,260,'Voltar ao Menu Anterior');
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
             sound(500);
             delay(75);
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
             sound(500);
             delay(75);
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
                   mouse.hide;
                   If cor_de_fundo = 15 then cor_de_fundo := -1;
                   Cor_de_fundo := cor_de_fundo + 1;
                   Cores_aleatorias_de_fundo :='';
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   coor2:=180;
                   setlinestyle(0,0,3);
                   settextstyle(1,0,2);
                   repeat
                     botao(coor2,9,1,3,1,14);
                     coor2:=coor2+40;
                   until coor2=300;
                   If (cor_de_fundo = 0) then escreve_cor_fundo :='Preto';
                   If (cor_de_fundo = 1) then escreve_cor_fundo :='Azul';
                   If (cor_de_fundo = 2) then escreve_cor_fundo :='Verde';
                   If (cor_de_fundo = 3) then escreve_cor_fundo :='Ciano';
                   If (cor_de_fundo = 4) then escreve_cor_fundo :='Vermelho';
                   If (cor_de_fundo = 5) then escreve_cor_fundo :='Magenta';
                   If (cor_de_fundo = 6) then escreve_cor_fundo :='Castanho';
                   If (cor_de_fundo = 7) then escreve_cor_fundo :='Cinza Claro';
                   If (cor_de_fundo = 8) then escreve_cor_fundo :='Cinza';
                   If (cor_de_fundo = 9) then escreve_cor_fundo :='Azul Claro';
                   If (cor_de_fundo = 10) then escreve_cor_fundo :='Verde Claro';
                   If (cor_de_fundo = 11) then escreve_cor_fundo :='Ciano Claro';
                   If (cor_de_fundo = 12) then escreve_cor_fundo :='Vermelho Claro';
                   If (cor_de_fundo = 13) then escreve_cor_fundo :='Magenta Claro';
                   If (cor_de_fundo = 14) then escreve_cor_fundo :='Amarelo';
                   If (cor_de_fundo = 15) then escreve_cor_fundo :='Branco';
                   Setcolor(15);
                   Outtextxy(320,180,'C“r : '+escreve_cor_fundo);
                   Outtextxy(320,220,'Aleat¢rias');
                   Outtextxy(320,260,'Voltar ao Menu Anterior');
                 end;
             220:begin
                   mouse.hide;
                   Cor_de_fundo := 0;
                   Cores_aleatorias_de_fundo :='RANDOM(15)';
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   coor2:=180;
                   setlinestyle(0,0,3);
                   settextstyle(1,0,2);
                   repeat
                     botao(coor2,9,1,3,1,14);
                     coor2:=coor2+40;
                   until coor2=300;
                   Setcolor(15);
                   Outtextxy(320,180,'C“r');
                   Outtextxy(320,220,'Aleat¢rias  *');
                   Outtextxy(320,260,'Voltar ao Menu Anterior');
                 end;
            260:begin
                   mouse.hide;
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   For a_cor:=0 to 15 do
                     begin
                       setcolor(a_cor);
                       Outtextxy(320,260,'Voltar ao Menu Anterior');
                       delay(25);
                     end;
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
     menu_configuracao;
     closegraph;
     halt(1);
   END;

{========================> Menu do Modo de desenho <=========================}

PROCEDURE Modo_de_desenho;

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
     Settextstyle(1,0,2);
     Settextjustify(1,2);
     Setcolor(15);
     If desenho_com_modo = 'Automatico' then
       Begin
        Outtextxy(320,180,'Autom tico  *');
        Outtextxy(320,220,'Manual       ');
       end
      else
       Begin
        Outtextxy(320,180,'Autom tico   ');
        Outtextxy(320,220,'Manual      *');
       end;
     Outtextxy(320,260,'Voltar ao Menu Anterior');
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
             sound(500);
             delay(75);
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
             sound(500);
             delay(75);
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
                   mouse.hide;
                   desenho_com_modo := 'Automatico';
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   coor2:=180;
                   setlinestyle(0,0,3);
                   settextstyle(1,0,2);
                   repeat
                     botao(coor2,9,1,3,1,14);
                     coor2:=coor2+40;
                   until coor2=300;
                   Setcolor(15);
                   Outtextxy(320,180,'Autom tico  *');
                   Outtextxy(320,220,'Manual       ');
                   Outtextxy(320,260,'Voltar ao Menu Anterior');
                 end;
             220:begin
                   mouse.hide;
                   desenho_com_modo := 'Manual';
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   coor2:=180;
                   setlinestyle(0,0,3);
                   settextstyle(1,0,2);
                   repeat
                     botao(coor2,9,1,3,1,14);
                     coor2:=coor2+40;
                   until coor2=300;
                   Setcolor(15);
                   Outtextxy(320,180,'Autom tico   ');
                   Outtextxy(320,220,'Manual      *');
                   Outtextxy(320,260,'Voltar ao Menu Anterior');
                  end;
            260:begin
                   mouse.hide;
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   For a_cor:=0 to 15 do
                     begin
                       setcolor(a_cor);
                       Outtextxy(320,260,'Voltar ao Menu Anterior');
                       delay(25);
                     end;
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
     menu_configuracao;
     closegraph;
     halt(1);
   END;



{=============================> Menu da Configura‡„o <=======================}

PROCEDURE Menu_configuracao;

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
     Settextstyle(1,0,2);
     Settextjustify(1,2);
     Setcolor(15);
     Outtextxy(320,180,'C“r');
     Outtextxy(320,220,'C“r de Fundo');
     Outtextxy(320,260,'Desenho');
     Outtextxy(320,300,'Voltar ao Menu Anterior');
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
             sound(500);
             delay(75);
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
             sound(500);
             delay(75);
             nosound;
          end
          else
            atrasa(7);
            mouse.show;
       end;
       if car = 27 then begin
         activimp(1);
         car:=13;
         impy:=300;
       end;
       if car = 13 then begin
          case impy of
             180:begin
                   mouse.hide;
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   For a_cor:=0 to 15 do
                     begin
                       setcolor(a_cor);
                       Outtextxy(320,180,'C“r');
                       delay(25);
                     end;
                   Menu_cores;
                   Menu_principal;
                   closegraph;
                   halt;
                 end;
             220:begin
                   mouse.hide;
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   For a_cor:=0 to 15 do
                     begin
                       setcolor(a_cor);
                       Outtextxy(320,220,'C“r de Fundo');
                       delay(25);
                     end;
                   Menu_cores_de_fundo;
                   Menu_principal;
                   closegraph;
                   halt(1);
                 end;
            260:begin
                   mouse.hide;
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   For a_cor:=0 to 15 do
                     begin
                       setcolor(a_cor);
                       Outtextxy(320,260,'Desenho');
                       delay(25);
                     end;
                  Modo_de_desenho;
                  Menu_principal;
                  closegraph;
                  halt(1);
                end;
            300:begin
                   mouse.hide;
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   For a_cor:=0 to 15 do
                     begin
                       setcolor(a_cor);
                       Outtextxy(320,300,'Voltar ao Menu Anterior');
                       delay(25);
                     end;
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
     menu_principal;
     closegraph;
     halt(1);
   END;

{=========================> Finaliza‡„o do programa <========================}

PROCEDURE Sair;

   BEGIN
     DeAlloc;
     RemoveOvl;
     closegraph;
     halt;
   END;

{==============================> Menu Principal <============================}

PROCEDURE Menu_principal;

   VAR
     i,y,car,x: integer;

   BEGIN
      if keypressed then limptec;
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
      Settextstyle(1,0,2);
      Settextjustify(1,2);
      Setcolor(15);
      Outtextxy(320,180,'Lissajous');
      Outtextxy(320,220,'Configura‡„o');
      Outtextxy(320,260,'Sair');
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
              sound(500);
              delay(75);
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
             sound(500);
             delay(75);
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
                   mouse.hide;
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   For a_cor:=0 to 15 do
                     begin
                       setcolor(a_cor);
                       Outtextxy(320,180,'Lissajous');
                       delay(25);
                     end;
                   Desenha_lissajous;
                   closegraph;
                   halt(1);
                 end;

             220:begin
                   Mouse.hide;
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   For a_cor:=0 to 15 do
                     begin
                       setcolor(a_cor);
                       Outtextxy(320,220,'Configura‡„o');
                       delay(25);
                     end;
                   Menu_configuracao;
                   closegraph;
                   halt(1);
                 end;
            260:begin
                   Mouse.hide;
                   Settextstyle(1,0,2);
                   Settextjustify(1,2);
                   For a_cor:=0 to 15 do
                     begin
                       setcolor(a_cor);
                       Outtextxy(320,260,'Sair');
                       delay(25);
                     end;
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
  assign(arq,'AXEL.MOD');
  {$I-}
  reset(arq);
  {$I+}
  if ioresult <> 0
   then
     begin
       writeln('Faltando ficheiro de m£sica (Default  AXEL.MOD)');
       delay(2000);
       halt;
     end;
  close(arq);
  If paramcount > 2 then
    begin
      writeln('Demasiados parametros');
      halt;
    end;
  If paramcount=0 then
    begin
      LoadOvl('GOLDPLAY.OVL');
      AskInit;
      Initialize;
      LoadModule('AXEL.MOD');
      tempo_de_atraso:=0;
    end
  else
   begin
     LoadOvl('GOLDPLAY.OVL');
     AskInit;
     Initialize;
     LoadModule(PARAMSTR(1)+'.MOD');
     If Error<>0 then
       begin;
         Writeln;
         Sintax;
         Writeln('Modulo n„o encontrado ( ',PARAMSTR(1),'.MOD ).');
         Writeln;
         Halt;
       End;
     val(paramstr(2),tempo_de_atraso,erro);
     If (erro <> 0) and (tempo_de_atraso > 100) then
       begin
         Sintax;
         delay(100);
         halt;
       end;
   end;
  Inicia_graficos;
  Apresentacao;
  Cleardevice;
  Setbkcolor(1);
  mouse.init;
  f:=mouse.setup;
  mouse.hide;
  Cores_aleatorias :='';
  Cores_aleatorias_de_fundo :='';
  desenha_cor := 15;
  cor_de_fundo := 0;
  desenho_com_modo := 'Automatico';
  Menu_Principal;
  Closegraph;
  Halt;
END.