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
Program Vesa_Demo_4; { Testing 2D/3D Demo -- Point Rotation }

{ The Original Code was made by fh94.3 (C) 12/23/1995                        }

{ I just modified and optimized it to work in all Vesa modes. The final use  }
{ of this code is just to demonstrate my VESA unit.                          }
{  Fernando J.A. Silva  ( ^Magico^ )       10/Oct/1997                       }

  Uses
    Crt, Vesa, Keyboard;

PROCEDURE PointRotation;

  Var
    Xan,Yan,Zan : Real; { Angles For X,Y,Z Axis                              }
    X,Y,Z,Xt,Yt,Zt : Real; { Virtual Points, Temp Points                     }
    MaxX, MaxY, Sx,Sy : Integer; { Screen Coords                                         }

  Begin
    MaxX := VesaMode.Width;
    MaxY := VesaMode.Height;
    Zan := 0.3; { Angle for rotation about Z axis                            }
    Yan := 0.1; { Angle for rotation about Y axis                            }
    Xan := 0.1; { Angle for rotation about X axis                            }
    X := 10 * 2;{ Coord of point on X axis                                   }
    Y := 20 * 2;{ Coord of point on Y axis                                   }
    Z := 20 * 2;{ Coord of point on Z axis                                   }
    Repeat
      DrawPixel(Sx,Sy,0); { Clears the point                                  }
      Yt := Y * COS(Xan) - Z * SIN(Xan); { Calculates position after rotating}
      Zt := Y * SIN(Xan) + Z * COS(Xan); { About the X axis                  }
      Y := Yt;
      Z := Zt;
      Xt := X * COS(Yan) - Z * SIN(Xan); { Calculates position after rotating}
      Zt := X * SIN(Yan) + Z * COS(Xan); { About the Y axis                  }
      X := Xt;
      Z := Zt;
      Xt := X * COS(Zan) - Y * SIN(Zan); { Calculates position after rotating}
      Yt := X * SIN(Zan) + Y * COS(Zan); { About the Z axis                  }
      X := Xt;
      Y := Yt;
      Sx := Round(X) + (MaxX DIV 2); { Converts REAL to INTEGER and centers  }
      Sy := Round(Y) + (MaxY DIV 2); { the point in ANY VESA screen          }
      DrawPixel(Sx,Sy,32767); { Draws the point, with the maximum color       }
      Retrace; { Waits for retrace                                           }
      Delay(20); { Waits a little more                                       }
    Until KeyPressed; { Loops until you press a key                          }
  End; { RunPoint }

Begin
  SetMode($113);
  PointRotation;
  CloseVesaMode;
End.