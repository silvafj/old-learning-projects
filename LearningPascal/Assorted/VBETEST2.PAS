Program VBETest2; { Testing Primitives Demo }

  Uses
    Crt, VBE20;

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
    MaxX,MaxY : word;
    Results : ResultsRec;

PROCEDURE TestPoints;

  Var
    X,Y,color : Integer;
    Ch : Word;

  Begin
    Randomize;
    InitFramesCounter;
    Repeat
      X := Random(MaxX);
      Y := Random(MaxY);
      Color := Random(MaxColor);
      DrawPixel(X,Y,Color);
      CheckFramesCounter;
    Until keypressed;
    Results.PixelsPerSecond := StopFramesCounter(Results.TicksP,Results.SecondsP);
  End;

PROCEDURE TestLines;

  Var
    X,Y,Color : word;
    Ch : Word;

  Begin
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
    Until keypressed;
    Results.LinesPerSecond := StopFramesCounter(Results.TicksL,Results.SecondsL);
  End;

PROCEDURE DisplayFinalStatus;

  Var
    Ch : Word;

  Begin
    CloseVbeMode;
    system.writeln('                  Final Results');
    system.writeln('Graphic mode used : *****');
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
    readln;
  End;

Begin
  FillChar(Results,SizeOf(ResultsRec),0);
  SetMode(SearchMode(800,600,15));
  MaxX := ModeInfo.XResolution;
  MaxY := ModeInfo.YResolution;
  MaxColor := {256}32768;
  TestPoints;
  TestLines;
  DisplayFinalStatus;
  ClrScr;
End.