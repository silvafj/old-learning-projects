{$A+} { Align Data Switch }
{$B-} { Boolean Evaluation Switch }
{$D-} { Debug Information Switch }
{$E-} { Emulation Switch - this doesn't affect a unit only a program }
{$F-} { Force Far Calls Switch }
{$G+} { Generate 80286 Code Switch }
{$I-} { Input/Output-Checking Switch }
{$I Defines.INC} { This file is used to define some conditionals according   }
{ with user preferences.                                                     }
{$L-} { Local Symbol Information Switch }
{$N+} { Numeric Coprocessor Switch }
{$Q-} { Overflow Checking Switch }
{$R-} { Range-Checking Switch }
{$S-} { Stack-Overflow Checking Switch }
{$V-} { Var-String Checking Switch }
{$Y+} { Symbol Reference Information Switch - just afect the Unit size, and }
      { it's very good when you run BP, because you can go directly to the  }
      { line where the source begins! Study, to know more!!!                }
Program Vesa_Demo_3; { Testing Primitives Demo }

  Uses
    Crt, Math, Screen, VESA, Keyboard;

  Type
    ResultsRec = Record
                   PixelsPerSecond : Real;
                   TicksP : Longint;
                   SecondsP : Integer;
                   LinesPerSecond : Real;
                   TicksL : Longint;
                   SecondsL : Integer;
                   RectanglePerSecond : Real;
                   TicksR : Longint;
                   SecondsR : Integer;
                   CirclesPerSecond : Real;
                   TicksC : Longint;
                   SecondsC : Integer;
                   EllipesPerSecond : Real;
                   TicksE : Longint;
                   SecondsE : Integer;
                   ClipPerSecond : Real;
                   TicksCl : Longint;
                   SecondsCl : Integer;
                   FillPerSecond : Real;
                   TicksFill : Longint;
                   SecondsFill : Integer;
                   Fill2PerSecond : Real;
                   TicksFill2 : Longint;
                   SecondsFill2 : Integer;
                 End;

  Var
    Mode : Word;
    MaxColor : Longint;
    Results : ResultsRec;

PROCEDURE TestPoints;

  Var
    X,Y,color : Integer;
    Ch : Word;

  Begin
    Randomize;
    FillScreen(0);
    InitFramesCounter;
    Repeat
      X := Random(MaxX);
      Y := Random(MaxY);
      Color := Random(MaxColor);
      DrawPixel(X,Y,Color);
      CheckFramesCounter;
      IF KeyPressed Then Ch := GetScanCodeW;
    Until Ch = Kb_F1;
    Results.PixelsPerSecond := StopFramesCounter(Results.TicksP,Results.SecondsP);
  End;


PROCEDURE TestLines;

  Var
    X,Y,Color : word;
    Ch : Word;

  Begin
    FillScreen(0);
    InitFramesCounter;
    repeat
      x := random(MaxX);
      y := random(MaxY);
      color := random(MaxColor);
      drawline(1,1,x,y,color);
      drawline(MaxX,1,MaxX-x,MaxY-y,color);
      drawline(1,MaxY,MaxX-x,MaxY-y,color);
      drawline(MaxX,MaxY,MaxX-x,MaxY-y,color);
      CheckFramesCounter;
      IF Keypressed Then Ch := GetScanCodeW;
    Until Ch = kb_F2;
    Results.LinesPerSecond := StopFramesCounter(Results.TicksL,Results.SecondsL);
  End;

PROCEDURE TestRectangle;

  Var
    x1,y1,x2,y2,color : integer;
    Ch : Word;

  Begin
    FillScreen(0);
    InitFramesCounter;
    repeat
      x1 := random(MaxX);
      y1 := random(MaxY);
      x2 := random(MaxX);
      y2 := random(MaxY);
      color := random(MaxColor);
      DrawRectangle(X1,Y1,X2,Y2,Color);
      CheckFramesCounter;
      IF Keypressed Then Ch := GetScanCodeW;
    Until Ch = kb_F3;
    Results.RectanglePerSecond := StopFramesCounter(Results.TicksR,Results.SecondsR);
  End;

PROCEDURE TestCircles;

  Var
    x1,y1,r,color : integer;
    Ch : Word;

  Begin
    FillScreen(0);
    InitFramesCounter;
    repeat
      x1 := random(MaxX);
      y1 := random(MaxY);
      r := random(MaxX);
      color := random(MaxColor);
      DrawCircle(X1,Y1,r,Color);
      CheckFramesCounter;
      IF Keypressed Then Ch := GetScanCodeW;
    Until Ch = kb_F4;
    Results.CirclesPerSecond := StopFramesCounter(Results.TicksC,Results.SecondsC);
  End;

PROCEDURE TestEllipse;

  Var
    x1,y1,rx,ry,color : integer;
    Ch : Word;

  Begin
    FillScreen(0);
    InitFramesCounter;
    repeat
      x1 := random(MaxX);
      y1 := random(MaxY);
      rx := random(MaxX);
      ry := random(MaxY);
      color := random(MaxColor);
      DrawEllipse (rx,ry,x1, y1,color);
      CheckFramesCounter;
      IF Keypressed Then Ch := GetScanCodeW;
    Until Ch = kb_F5;
    Results.EllipesPerSecond := StopFramesCounter(Results.TicksE,Results.SecondsE);
  End;

PROCEDURE TestClipping;

  Const
    Size = 200;
    WinColor = 100;

  Var
    X1,Y1,X2,Y2,rx,ry : Integer;
    Ch : Word;
    color : word;

  Begin
    FillScreen(0);
    InitFramesCounter;
    Repeat
      color := random(65535);
      { clip pixeis }
      SetViewPort(10,10,10+Size,10+Size,WinColor);
      x1 := random(MaxX);
      y1 := random(MaxY);
      DrawPixelClip(X1,Y1,color);
      { clip lines}
      SetViewPort(220,10,220 + Size,10 + Size,WinColor);
      x1 := random(MaxX);
      y1 := random(MaxY);
      drawlineClip(1,1,x1,y1,color);
      drawlineClip(MaxX,1,MaxX-x1,MaxY-y1,color);
      drawlineClip(1,MaxY,MaxX-x1,MaxY-y1,color);
      drawlineClip(MaxX,MaxY,MaxX-x1,MaxY-y1,color);
      { clip rectangles }
      SetViewPort(430,10,430 + Size,10 + Size,WinColor);
      x1 := random(MaxX);
      y1 := random(MaxY);
      x2 := random(MaxX);
      y2 := random(MaxY);
      DrawRectangleClip(X1,Y1,X2,Y2,Color);
      { clip circles }
      SetViewPort(10,220,10+Size,220+Size,WinColor);
      x1 := random(MaxX);
      y1 := random(MaxY);
      rx := random(MaxX);
      DrawCircle(X1,Y1,rx,Color);
      { clip ellipse }
      SetViewPort(220,220,220+Size,220+Size,WinColor);
      x1 := random(MaxX);
      y1 := random(MaxY);
      rx := random(MaxX);
      ry := random(MaxY);
      DrawEllipse (rx,ry,x1, y1,color);
      CheckFramesCounter;
      IF Keypressed Then Ch := GetScanCodeW;
    Until Ch = kb_F6;
    Results.ClipPerSecond := StopFramesCounter(Results.TicksCl,Results.SecondsCl);
  End;

PROCEDURE TestFilling;

  Var
    Ch,Color : Word;

  Begin
    FillScreen(0);
    InitFramesCounter;
    Color := 0;
    Repeat
      FillScreen(Color);
      Inc(Color);
      IF Color = 65535 Then Color := 0;
      CheckFramesCounter;
      IF Keypressed Then Ch := GetScanCodeW;
    Until Ch = kb_F7;
    Results.FillPerSecond := StopFramesCounter(Results.TicksFill,Results.SecondsFill);
  End;

PROCEDURE TestFillingClip;

  Const
    Size = 200;
    WinColor = 100;

  Var
    X1,Y1,X2,Y2,rx,ry : Integer;
    Ch : Word;
    color : word;

  Begin
    FillScreen(0);
    InitFramesCounter;
    Color := 0;
    Repeat
      SetViewPort(10,10,10+Size,10+Size,WinColor);
      FillView(color);
      SetViewPort(220,10,220 + Size,10 + Size,WinColor);
      FillView(color);
      SetViewPort(430,10,430 + Size,10 + Size,WinColor);
      FillView(color);
      SetViewPort(10,220,10+Size,220+Size,WinColor);
      FillView(color);
      SetViewPort(220,220,220+Size,220+Size,WinColor);
      FillView(color);
      CheckFramesCounter;
      Inc(Color);
      IF Color=65535 Then Color:=0;
      IF Keypressed Then Ch := GetScanCodeW;
    Until Ch = kb_F8;
    Results.Fill2PerSecond := StopFramesCounter(Results.TicksFill2,Results.SecondsFill2);
  End;

PROCEDURE DisplayFinalStatus;

  Var
    Ch : Word;

  Begin
    CloseVesaMode;
    system.writeln('                  Final Results');
    system.writeln('Graphic mode used : $',Long2Hex(mode));
    system.writeln('Points results : ');
    system.writeln('  Points/sec : ',Results.PixelsPerSecond:3:2);
    system.writeln('  Total Seconds : ',Results.SecondsP);
    system.writeln('  Total Ticks : ',Results.TicksP);
    system.writeln('Line results : ');
    system.writeln('  Lines/sec : ',Results.LinesPerSecond:3:2);
    system.writeln('  Total Seconds : ',Results.SecondsL);
    system.writeln('  Total Ticks : ',Results.TicksL);
    system.writeln('Rectangle results : ');
    system.writeln('  Rectangles/sec : ',Results.RectanglePerSecond:3:2);
    system.writeln('  Total Seconds : ',Results.SecondsR);
    system.writeln('  Total Ticks : ',Results.TicksR);
    system.writeln('Circle results : ');
    system.writeln('  Circles/sec : ',Results.CirclesPerSecond:3:2);
    system.writeln('  Total Seconds : ',Results.SecondsC);
    system.writeln('  Total Ticks : ',Results.TicksC);
    system.writeln('Ellipse results : ');
    system.writeln('  Ellipses/sec : ',Results.EllipesPerSecond:3:2);
    system.writeln('  Total Seconds : ',Results.SecondsE);
    system.writeln('  Total Ticks : ',Results.TicksE);
    gotoxy(40,2);
    system.write('Clipping results : ');
    gotoxy(40,3);
    system.write('  Frames/sec : ',Results.ClipPerSecond:3:2);
    gotoxy(40,4);
    system.write('  Total Seconds : ',Results.SecondsCl);
    gotoxy(40,5);
    system.write('  Total Ticks : ',Results.TicksCl);
    gotoxy(40,6);
    system.write('Filling results : ');
    gotoxy(40,7);
    system.write('  Fills/sec : ',Results.FillPerSecond:3:2);
    gotoxy(40,8);
    system.write('  Total Seconds : ',Results.SecondsFill);
    gotoxy(40,9);
    system.write('  Total Ticks : ',Results.TicksFill);
    gotoxy(40,10);
    system.write('Clipped Filling results : ');
    gotoxy(40,11);
    system.write('  Fills/sec : ',Results.Fill2PerSecond:3:2);
    gotoxy(40,12);
    system.write('  Total Seconds : ',Results.SecondsFill2);
    gotoxy(40,13);
    system.write('  Total Ticks : ',Results.TicksFill2);
    repeat
      ch := GetScanCodeW;
    Until Ch = kb_Esc;
  End;

Begin
  Mode := $103;
  IF Not SetMode(Mode) Then
    Begin
      System.Write('Error setting the mode');
      Halt;
    End;
  MaxColor := Power(2,VesaMode.Bits);
  TestPoints;
  TestLines;
  TestRectangle;
  TestCircles;
  TestEllipse;
  TestClipping;
  TestFilling;
  TestFillingClip;
  DisplayFinalStatus;
  ClrScr;
End.