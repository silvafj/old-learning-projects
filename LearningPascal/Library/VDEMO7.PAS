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
Program Vesa_Demo_7; { Testing 2D/3D Demo -- Stars I (Rotation Stars) }

{ The Original Code was made by Bas Van Gaalen                               }

{ I just modified and optimized it to work in all Vesa modes. The final use  }
{ of this code is just to demonstrate my VESA unit.                          }
{  Fernando J.A. Silva  ( ^Magico^ )       15/Oct/1997                                                }

  Uses
    Crt, Vesa;

  Const
    NofPoints = 255;
    Speed = 3;
    Xc : real = 0;
    Yc : real = 0;
    Zc : real = 150;
    SinTab : Array [0..255] OF integer = (
      0,2,5,7,10,12,15,17,20,22,24,27,29,31,34,36,38,41,43,45,47,49,52,54,
      56,58,60,62,64,66,67,69,71,73,74,76,78,79,81,82,83,85,86,87,88,90,91,
      92,93,93,94,95,96,97,97,98,98,99,99,99,100,100,100,100,100,100,100,
      100,99,99,99,98,98,97,97,96,95,95,94,93,92,91,90,89,88,87,85,84,83,
      81,80,78,77,75,73,72,70,68,66,65,63,61,59,57,55,53,51,48,46,44,42,40,
      37,35,33,30,28,26,23,21,18,16,14,11,9,6,4,1,-1,-4,-6,-9,-11,-14,-16,
      -18,-21,-23,-26,-28,-30,-33,-35,-37,-40,-42,-44,-46,-48,-51,-53,-55,
      -57,-59,-61,-63,-65,-66,-68,-70,-72,-73,-75,-77,-78,-80,-81,-83,-84,
      -85,-87,-88,-89,-90,-91,-92,-93,-94,-95,-95,-96,-97,-97,-98,-98,-99,
      -99,-99,-100,-100,-100,-100,-100,-100,-100,-100,-99,-99,-99,-98,-98,
      -97,-97,-96,-95,-94,-93,-93,-92,-91,-90,-88,-87,-86,-85,-83,-82,-81,
      -79,-78,-76,-74,-73,-71,-69,-67,-66,-64,-62,-60,-58,-56,-54,-52,-49,
      -47,-45,-43,-41,-38,-36,-34,-31,-29,-27,-24,-22,-20,-17,-15,-12,-10,
      -7,-5,-2,0);

  Type
    PointRec = Record
                 X,Y,Z : integer;
               End;
    PointPos = Array [0..NofPoints] OF PointRec;

  Var
    Point : PointPos;
    MaxX, MaxY : Word;

{----------------------------------------------------------------------------}

PROCEDURE Init;

  Var
    I : Word;

  Begin
    Randomize;
    FOR I := 0 TO NofPoints DO
      Begin
        Point[I].X := random(250)-125;
        Point[I].Y := random(250)-125;
        Point[I].Z := random(250)-125;
      End;
  End;

{----------------------------------------------------------------------------}

PROCEDURE DoRotation;

  Const
    Xstep = 1;
    Ystep = 1;
    Zstep = -2;

  Var
    Xp,Yp : array[0..NofPoints] of word;
    X,Y,Z,X1,Y1,Z1 : real;
    PhiX,PhiY,PhiZ : byte;
    I,Color : Longint;
    CenterX, CenterY : Word;

  FUNCTION Sinus(Idx : byte) : Real;

    Begin
      Sinus := SinTab[Idx]/100;
    End;

  FUNCTION Cosinus(Idx : byte) : Real;

    Begin
      Cosinus := SinTab[(Idx+192) mod 255]/100;
    End;

  Begin
    PhiX := 0;
    PhiY := 0;
    PhiZ := 0;
    CenterX := (MaxX DIV 2);
    CenterY := (MaxY DIV 2);
    Repeat
      While (port[$3da] AND 8) <> 8 DO;
      While (port[$3da] AND 8) = 8 DO;
      FOR I := 0 TO NofPoints DO
        Begin
          IF (Xp[I]+CenterX < MaxX) AND (Yp[I]+CenterY < MaxY) Then
            DrawPixel(Xp[I]+(MaxX DIV 2),Yp[I]+(MaxY DIV 2),0);
          X1 := Cosinus(PhiY)*Point[I].X-Sinus(PhiY)*Point[I].Z;
          Z1 := Sinus(PhiY)*Point[I].X+Cosinus(PhiY)*Point[I].Z;
          X := Cosinus(PhiZ)*X1+Sinus(PhiZ)*Point[I].Y;
          Y1 := Cosinus(PhiZ)*Point[I].Y-Sinus(PhiZ)*X1;
          Z := Cosinus(PhiX)*Z1-Sinus(PhiX)*Y1;
          Y := Sinus(PhiX)*Z1+Cosinus(PhiX)*Y1;
          Xp[I] := round((Xc*Z-X*Zc)/(Z-Zc));
          Yp[I] := round((Yc*Z-Y*Zc)/(Z-Zc));
          IF (Xp[I]+CenterX < MaxX) AND (Yp[I]+CenterY < MaxY) Then
            Begin
              Color := 31+round(Z/7);
              IF Color > 31 Then Color := 31
              Else IF Color < 16 Then Color := 16;
              DrawPixel(Xp[I]+(MaxX DIV 2),Yp[I]+(MaxY DIV 2),Color);
            End;
          Inc(Point[I].Z,Speed);
          IF Point[I].Z > 125 Then Point[I].Z := -125;
        End;
      Inc(PhiX,Xstep);
      Inc(PhiY,Ystep);
      Inc(PhiZ,Zstep);
    Until keypressed;
  End;

{----------------------------------------------------------------------------}

Begin
  SetMode($103);
  MaxX := VesaMode.Width;
  MaxY := VesaMode.Height;
  Init;
  DoRotation;
  CloseVesaMode;
End.


