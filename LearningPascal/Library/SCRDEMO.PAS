Program ScreenDemo;

  Uses
    CRT,Math,StrsUse,Screen,Keyboard,Menus;

Var
  New5:TCharShape;
  VideoMem:Integer;
  A : byte;
  Page,test:ScreenPtr;
  B:Integer;
  valor:integer;
  finished:boolean;

Begin
  InitCol;
  Repeat
  FadeOut(10);
  Delay(20);
  FadeIn(10);
  Until Keypressed;
{  SetBrightNess(250);}
{  New5[0] :=Bin2Dec('00000000');
  New5[1] :=Bin2Dec('00000000');
  New5[2] :=Bin2Dec('00011000');
  New5[3] :=Bin2Dec('00111100');
  New5[4] :=Bin2Dec('01100110');
  New5[5] :=Bin2Dec('11000011');
  New5[6] :=Bin2Dec('11000011');
  New5[7] :=Bin2Dec('11111111');
  New5[8] :=Bin2Dec('11000011');
  New5[9] :=Bin2Dec('11000011');
  New5[10]:=Bin2Dec('11000011');
  New5[11]:=Bin2Dec('11000011');
  New5[12]:=Bin2Dec('00000000');
  New5[13]:=Bin2Dec('00000000');
  New5[14]:=Bin2Dec('00000000');
  New5[15]:=Bin2Dec('00000000');
  CheckSnow:=FALSE;
  BkColor:=5;
  ClrScr;
  Case VideoCard(VideoMem) OF
    None      : Write(1,1,1,'None Card');
    MDA       : Write(1,1,1,'MDA Card');
    CGA       : Write(1,1,1,'CGA Card');
    EGAMono   : Write(1,1,1,'EGA Mono Card');
    EGAColor  : Write(1,1,1,'EGA Color Card');
    VGAMono   : Write(1,1,1,'VGA Mono Card');
    VGAColor  : Write(1,1,1,'VGA Color Card');
    MCGAMono  : Write(1,1,1,'MCGA Mono Card');
    MCGAColor : Write(1,1,1,'MCGA Color Card');
  End;
  BkColor:=3;
  Write(WhereX,WhereY,1,Num2Str(VideoMem)+'k');
  ReplaceChar(ord('A'), @New5);}
  InitPages(Page,100);
  Finished:=false;
  B:=0;
  While MemAvail > {150000}8000 DO
    Begin
      crt.ClrScr; { fazer clrscr tÆo r pido como este }
      system.write(' Tamanho do Record : ');
      system.writeln(SizeOf(ScreenRec));
      system.write(' Mem¢ria existente : ');
      system.writeln(MemAvail);
      system.write(' Ecrƒ N§ : ');
      system.writeln(B);
      StorePage(Page,1,1,80,25,B);
      Inc(B);
    End;
{  Delay(2000);
  B:=0;
  While MemAvail > 5000 DO
    Begin
      crt.ClrScr; { fazer clrscr tÆo r pido como este }
{
      system.write(' Tamanho do Record : ');
      system.writeln(SizeOf(ScreenRec));
      system.write(' Mem¢ria existente : ');
      system.writeln(MemAvail);
      system.write(' Ecrƒ N§ : ');
      system.writeln(B);
      StorePage(test,1,1,80,25,B);
      Inc(B);
    End;}
  repeat
   system.writeln;
   GotoXY(10,10);
   system.write(' Introduza valor : ');
   readln(valor);
   restorepage(Page,valor);
   if valor=1 then finished:=true;
  until finished;
  system.writeln;
  system.writeln(' Releasing Pages .....');
  ReleasePages(Page);
  system.write(' Mem¢ria existente : ');
  system.writeln(MaxAvail);
{  system.writeln;
  system.writeln(' Releasing Pages .....');
  ReleasePages(test);
  system.write(' Mem¢ria existente : ');
  system.writeln(MaxAvail); }
  Repeat Until KeyPressed;
End.