Program CubeRot; { Testing 2D/3D Demo -- Cube Rotation }

{ The Original Code was made by fh94.3 (C) 12/23/1995                        }

{ I just modified and optimized it to work in all Vesa modes. The final use  }
{ of this code is just to demonstrate my VESA unit.                          }
{  Fernando J.A. Silva  ( ^Magico^ )       13/Oct/1997                       }

  Uses
    Crt, Vbe20;

  Const
    Cube : Array [0..23] OF Real = { 8 points * 3 coords(X,Y,Z) = 24 numbers }
                                  (-1,-1,-1,
                                   -1,-1, 1,
                                   -1, 1,-1,
                                   -1, 1, 1,
                                    1,-1,-1,
                                    1,-1, 1,
                                    1, 1,-1,
                                    1, 1, 1); { Coords of the objects (like  }
    { point1_x, point1_y, point1_z, point2_x, point2_y, ...)                 }
    LineIndex : Array [0..23] OF Integer = { 12 lines * 2 points per line =  }
                                           { = 24 numbers                    }
                                          (0,1,
                                           0,4,
                                           0,2,
                                           1,3,
                                           1,5,
                                           2,3,
                                           2,6,
                                           3,7,
                                           4,5,
                                           4,6,
                                           5,7,
                                           6,7); { Index of the lines, it    }
    { sets how the points are connected together (point #0 to point #1, ...) }
  Var
    Xt, Yt, Zt : Real; { Temp Points }
    Xan, Yan, Zan : Real; { Angles for axis X,Y,Z }
    sX,sY,sX1,sY1, P, Zoom : Integer; { Screen coords X,Y }
    MaxX, MaxY : Integer; { Screen resolution }
    Ticks : Longint;
    Seconds : Integer;

PROCEDURE Draw(Color : Longint); { Procedure to draw a cube }

  Begin
    FOR P := 0 TO 11 DO
      Begin { Loops for all 12 lines }
        sX := Round(Zoom * Cube[LineIndex[P * 2] * 3]) + (MaxX DIV 2); { X coord for point #1          }
        sY := Round(Zoom * Cube[LineIndex[P * 2] * 3 + 1]) + (MaxY DIV 2); { Y coord for point #1      }
        sX1 := Round(Zoom * Cube[LineIndex[P * 2 + 1] * 3]) + (MaxX DIV 2); { X coord for point #2     }
        sY1 := Round(Zoom * Cube[LineIndex[P * 2 + 1] * 3 + 1]) + (MaxY DIV 2); { Y coord for point #2 }
        DrawLine(sX,sY,sX1,sY1,Color); { Draw it in current color                                      }
      End;
  End; { Draw }

PROCEDURE Calc; { Calculates new values after rotate step }

  Begin
    FOR P := 0 TO 7 DO
      Begin { Repeats for all 8 points }
        Yt := Cube[P * 3 + 1] * COS(Xan) - cube[P * 3 + 2] * SIN(Xan); { Read old values from the table of coord, }
        Zt := Cube[P * 3 + 1] * SIN(Xan) + cube[P * 3 + 2] * COS(Xan); { Rotating about x axis                    }
        Cube[P * 3 + 1] := Yt; { Writes the new values back to the table                                          }
        Cube[P * 3 + 2] := Zt;
        Xt := Cube[P * 3] * COS(Yan) - Cube[P * 3 + 2] * SIN(Yan); { Same as above, for Y axis                    }
        Zt := Cube[P * 3] * SIN(Yan) + Cube[P * 3 + 2] * COS(Yan);
        Cube[P * 3] := Xt;
        Cube[P * 3 + 2] := Zt;
        Xt := Cube[P * 3] * COS(Zan) - Cube[P * 3 + 1] * SIN(Zan); { About Z axis                                 }
        Yt := Cube[P * 3] * SIN(Zan) + Cube[P * 3 + 1] * COS(Zan);
        Cube[P * 3] := Xt;
        Cube[P * 3 + 1] := Yt;
      End;
  End; { Calc }

Begin
  VBEInit(800,600,8);
  MaxX := ModeInfo.XResolution;
  MaxY := ModeInfo.YResolution;
  Zan :=  0.1;  { Rotation about Z axis by this angle }
  Yan :=  0.02; { Rotation about Y axis by this angle }
  Xan :=  0.02; { Rotation about X axis by this angle }
  Zoom := 60;   { Size of the cube                    }
  Draw(100);     { Draws the cube                      }
  InitFramesCounter;
  Repeat        { Loops ...                           }
    Draw(0);    { Undraws the cube                    }
    Retrace;
    Calc;       { Calculates the new coords           }
    Delay(10);  { Wait a sec!                         }
    Draw(100);   { Draws it again                      }
    Retrace;
    Delay(10);  { Wait a sec!                         }
    CheckFramesCounter;
  Until KeyPressed; { ... 'till you press something   }
  CloseVbeMode;
  WriteLn('Frames/sec : ',StopFramesCounter(Ticks,Seconds):3:2);
End.