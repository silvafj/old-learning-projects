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
{$Y+} { Symbol Reference Information Switch - just afect the Unit size, and  }
      { it's very good when you run BP, because you can go directly to the   }
      { line where the source begins! Study, to know more!!!                 }
Program Vesa_Demo_8; { Testing 2D/3D Demo --
                                           Stars II (Parallax/Multi-Layered) }

{ The Original Code was made by Bernie Pallek                                }

{ I just modified and optimized it to work in all Vesa modes. The final use  }
{ of this code is just to demonstrate my VESA unit.                          }
{  Fernando J.A. Silva  ( ^Magico^ )       15/Oct/1997                                                }

  Uses
    Crt, Keyboard, Vesa;

  Const
    MaxStars = 300;
    StarCol : Array [0..2] OF Longint = (8, 7, 15);

  Type
    StarRec = Record
                X : Integer;
                Y : Integer;
                D : Integer;  { depth }
              End;

  Var
    Stars : Array [0..MaxStars] OF StarRec;
    Xinc, Yinc  : Real;

PROCEDURE InitStars;

  Var
    I : Integer;

  Begin
    For I := 0 TO MaxStars DO
      With Stars[I] DO
        Begin
          X := Random(MaxX);
          y := Random(MaxY);
          d := Random(3);
        End;
  End;

PROCEDURE MoveStars;

  Var
    I : Integer;

  Begin
    For I := 0 TO MaxStars DO
      With Stars[I] DO
        Begin
          DrawPixel(X, Y, 0);
          X := Round(X + Xinc * (d + 1));
          IF (X < 0) Then X := X + MaxX;
          IF (X > MaxX) Then X := X - MaxX;
          Y := Round(Y + Yinc * (d + 1));
          IF (Y < 0) Then Y := Y + MaxY;
          IF (Y > MaxY) Then Y := Y - MaxY;
          DrawPixel(X, Y, StarCol[d]);
        End;
  End;

Begin
  SetMode($103);
  InitStars;
  xinc := -1;
  yinc := 0;
  Repeat
   MoveStars;
   Retrace;
  Until KeyPressed;
  CloseVesaMode;
End.