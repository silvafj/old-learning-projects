PROGRAM Lissajous;
{$M 8192,0,21000}
USES
   crt,dos,graph,grafica;

TYPE
    registro = RECORD
  END;

 CONST
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

VAR
   arq : FILE OF registro;
   a,b,c,f,rx,ry:INTEGER;
   x,y:REAL;

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

PROCEDURE EXECUTE(COMMAND:STRING);
BEGIN
     IF COMMAND<>'' THEN COMMAND:='/C '+COMMAND;
     SWAPVECTORS;
     EXEC(GETENV('COMSPEC'),COMMAND);
     SWAPVECTORS;
     IF DOSERROR<>0 THEN WRITELN('N„o foi poss¡vel executar o COMMAND.COM');
     DELAY(2000);
END;


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

PROCEDURE Desenha;
  VAR
    valora,valorb,valorc:string;
    erro:integer;

 BEGIN
   Setbkcolor(1);
   Setcolor(15);
   Settextstyle(3,0,1);
   Settextjustify(1,2);
   Outtextxy(320,1,'Introduza o valor de A (m ximo 9)');
   repeat
      moveto(300,20);
      setfillstyle(0,1);
      bar(0,27,640,40);
      readstr(valora,1,1);
      val(valora,a,erro);
   until (erro=0) and (a>0) and (a<=50);
   Outtextxy(320,45,'Introduza o valor de B (m ximo 9)');
   repeat
      moveto(300,65);
      setfillstyle(0,1);
      bar(0,71,640,85);
      readstr(valorb,1,1);
      val(valorb,b,erro);
   until (erro=0) and (b>0) and (b<=50);
   Outtextxy(320,85,'Introduza o valor de C (m ximo 9)');
   repeat
      moveto(300,105);
      setfillstyle(0,1);
      bar(0,110,640,125);
      readstr(valorc,1,1);
      val(valorc,c,erro);
   until (erro=0) and (c>0) and (c<=50);
   Cleardevice;
   Setbkcolor(0);
   For f:=0 to 500 do
   BEGIN
     y:=220+220*SIN(c+a*PI*f/100);
     x:=300+200*SIN(b*PI*f/100);
     ry:=ROUND(y);
     rx:=ROUND(x);
     Putpixel(rx,ry,15);
   END;
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
  execute('apre_lis LISúsajous');
  Inicia_graficos;
  Cleardevice;
  Desenha;
  Readln;
  Closegraph;
END.