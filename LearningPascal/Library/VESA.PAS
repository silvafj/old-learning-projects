                                                                                (*
         VESA Version 1.0 -- Access and Use of VESA graphics modes
         Copyright 1995-1997 by Fernando J.A. Silva   ( ^Magico^ )

      *                                                            *
                              aaaaaaaaaaaaaaaa               *
                          aaaaaaaaaaaaaaaaaaaaaaaa
                       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                     aaaaaaaaaaaaaaaaa           aaaaaa
                   aaaaaaaaaaaaaaaa                  aaaa
                  aaaaaaaaaaaaa aa                      aa
 *               aaaaaaaa      aa                         a
                 aaaaaaa aa aaaa
           *    aaaaaaaaa    aaaa
                aaaaaaaaaaa aaaaaaa                               *
                aaaaaaa    aaaaaaaaaa
                aaaaaa a aaaaaa aaaaaa
                 aaaaaaa  aaaaaaa
                 aaaaaaaa                                 a
                  aaaaaaaaaa                            aa
                   aaaaaaaaaaaaaaaa                  aaaa
                     aaaaaaaaaaaaaaaaa           aaaaaa        *
       *               aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                          aaaaaaaaaaaaaaaaaaaaaaaa
                       *      aaaaaaaaaaaaaaaa

[ This came from: Ric.Hotchkiss@sdrc.com                                     ]
[ All that big nigths working... Cool.                                       ]
                                                                                *)

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
Unit VESA;

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE

  Type
    ModeList = Array[1..32] Of Word;  { List of VESA mode numbers              }

    TVesaMode = Record { List of all information about a specific mode       }
                  Attr     : Word; { Mode Attributes                         }
                  WinA     : Byte; { Window A attributes                     }
                  WinB     : Byte; { Window B attributes                     }
                  Gran     : Word; { Window granularity in K bytes           }
                  WinSiz   : Word; { Size of window in K bytes               }
                  SegA     : Word; { Segment address of window A             }
                  SegB     : Word; { Segment address of window B             }
                  WinFunc  : Procedure; { Windows positioning function       }
                  Bytes    : Word; { Number of bytes per line                }
                  Width    : Word; { Number of horizontal pixels             }
                  Height   : Word; { Number of vertical pixels               }
                  CharW    : Byte; { Width of character cell                 }
                  CharH    : Byte; { Height of character cell                }
                  Planes   : Byte; { Number of memory planes                 }
                  Bits     : Byte; { Number of bits per pixel                }
                  nBanks   : Byte; { Number of banks        (not used)       }
                  Model    : Byte; { Memory model type                       }
                  Banks    : Byte; { Size of bank           (not used)       }
                  Pages    : Byte; { Number of image pages                   }
                  Reserved : Byte; { The following are for 15,16,24,32 bit colour modes }
                  RedMaskSize   : Byte; { Size of Red mask in bits           }
                  RedFieldPos   : Byte; { Bit position of LSB of Red mask    }
                  GreenMaskSize : Byte; { Size of Green mask in bits         }
                  GreenFieldPos : Byte; { Bit position of LSB of Green mask  }
                  BlueMaskSize  : Byte; { Size of Blue mask in bits          }
                  BlueFieldPos  : Byte; { Bit position of LSB of Blue mask   }
                  RsvdMaskSize  : Byte; { Size of Reserved mask in bits      }
                  RsvdFieldPos  : Byte; { Bit pos. of LSB of Reserved mask   }
                  DirColModeInf : Byte; { Direct Colour mode attributes      }
                  Filler   : Array[0..215] Of Byte; { Not used - filler      }
                End; { TVesaMode Record }

    TVesaInfo = Record
                  Signature : Array[1..4] OF Byte; { Signature - "VESA"      }
                  Version   : Word; { VESA Version number                    }
                  OEMName   : PChar; { Pointer to manufacturer name          }
                  Capabilities : Longint; { Capabilities       (Not used)    }
                  List         : ^ModeList; { Pointer to list of VESA modes  }
                  TotalMemory  : Word; { Number of 64k memory blocks on card }
                  { VBE 2.0 }
                  OEMSoftVersion : Word; { OEM Software Version              }
                  Vendor   : PChar; { Pointer to Vendor Name                 }
                  Product  : PChar; { Pointer to product name                }
                  revision : PChar; { Pointer to product revision string     }
                  Reserved : Array[1..222] of Byte; { Reserved               }
                  Scratch  : Array[1..256] of Byte; { OEM scratchpad         }
                End; { TVesaInfo Record }

    PaletteType = Array[0..255,0..2] Of Byte;


  Var
    VesaMode : TVesaMode; { Contains all info needed for drawing on the screen }
    VesaInfo : TVesaInfo; { Contains info on the VESA BIOS Extensions }
    MaxX, MaxY : Word; { Max Resolution. These variables are used to know the}
                       { actual maximum values of a window, clipped or not   }
                       { clipped.                                            }
    ClippingOn : Boolean;

{ -_-_-_-_-_-_-_-_-_-_-_-_-_-_ Public rotines -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-}

{ Hardware and information detection rotines }
  PROCEDURE GetVesaInfo;
  PROCEDURE GetVesaModeInfo(Md : Word);
  FUNCTION  IsVesa : Boolean;

{ Accessing Vesa rotines }
  PROCEDURE CloseVesaMode;
  FUNCTION  GetMode : Word;
  FUNCTION  SetMode(Md : Word) : Boolean;

{ Basic usefull rotines }
  PROCEDURE Retrace;

{ Primitive drawing rotines }
  PROCEDURE DrawCircle(X, Y, Radius : Word; Color : Longint);
  PROCEDURE DrawEllipse(X,Y, RadX, RadY : Word; Color: Longint);
  PROCEDURE DrawLine(X1, Y1, X2, Y2 : Integer; Color : Longint);
  PROCEDURE DrawPixel(X, Y : Word; Color : Longint);
  PROCEDURE DrawRectangle(X1, Y1, X2, Y2 : Word; Color : Longint);
  FUNCTION  GetPixel(X,Y:Word) : Longint;

{ Clipping Rotines }
  PROCEDURE SetViewPort(X1,Y1,X2,Y2 : Word; Color : Longint);
  PROCEDURE RestoreRealViewPort;
  PROCEDURE DrawPixelClip(X, Y : Word; Color : Longint);
  PROCEDURE DrawLineClip(X1, Y1, X2, Y2 : Integer; Color : Longint);
  PROCEDURE DrawRectangleClip(X1, Y1, X2, Y2 : Word; Color : Longint);

{ Fill Routines }
  PROCEDURE FillScreen(Color : Longint);
  PROCEDURE FillView(Color : Longint);
  PROCEDURE FillBar(X1,Y1,X2,Y2 : Word;Color : Longint);
  PROCEDURE FillArea(X,Y : Word;FillColor : Longint);

{ Palette and color rotines }
  PROCEDURE SetColor(Color : Longint; Red, Green, Blue : Byte);
  PROCEDURE GetColor(Color : Longint; Var Red, Green, Blue : Byte);

{ Frames counter rotines }
  PROCEDURE CheckFramesCounter;
  PROCEDURE InitFramesCounter;
  FUNCTION  StopFramesCounter(Var TotalTicks : Longint;
                              Var TotalSeconds : Integer) : Real;



Function  GetLineLength:Word;
          { Returns the current logical scan line length }
Function  SizeOfVideoState:Word;
          { Returns the size of the buffer needed to save the video state }
Procedure SaveVideoState(Var buf);
          { Saves the SVGA video state in the buffer }
Procedure RestoreVideoState(Var buf);
          { Restores the SVGA video state from the buffer}
Procedure SetLineLength(Var len:Word);
          { Sets the logical scan line length, returns the actual length set }
Procedure SetDisplayStart(pixel,line:Word);
          { Sets the first pixel and line on the display }
Procedure GetDisplayStart(Var pixel,line:Word);
          { Returns the first pixel and line on the display }

{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }

IMPLEMENTATION

  Uses
    Dos, Timer;

  Type
    TDrawPixel = Procedure(X, Y : Word; Color : Longint);
    TGetPixel = Function(X,Y:Word):Longint;

  Var
    VDrawPixel : TDrawPixel;
    VGetPixel : TGetPixel;
    Regs : Registers;
    A, Ticks, TotalSec : Longint;
    VesaOn  : Boolean; { Specifies whether a VESA mode is on or not             }
    CurBank : Word; { Number of the Bank in current use                      }
    ClipMinX, ClipMinY, ClipMaxX, ClipMaxY : Word; { Values used to check    }
    { clipped and not clipped windows.                                       }

{ ======================== Unit                  =========================== }
{ ========================      Internal         =========================== }
{ ========================               Rotines =========================== }
{                         ***********************                            }

{$F+}
{ All these internal routines are "far" because they need to be called as    }
{ expression procedures, and because it's faster.                            }

{----------------------------------------------------------------------------}
{ PROCEDURE (Internal)                                                       }
{ SetBank                                                                    }
{              - Description : Set the video bank to draw on                 }
{              - Input       : Bank -> Bank to set                           }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE SetBank(Bank : Word); Assembler;

  Asm
    MOV   AX, Bank
    CMP   CurBank, AX
    JE    @End
    MOV   CurBank, AX
    MOV   AX, 4F05h
    XOR   BX, BX
    MOV   DX, Bank
    CALL  VesaMode.WinFunc
   @End:
  End; { SetBank Internal Routine }

{----------------------------------------------------------------------------}
{ FUNCTION  (Internal)                                                       }
{ GetBank                                                                    }
{              - Description : Gets the current active video bank            }
{              - Input       : ----                                          }
{              - Return      : The current bank                              }
{----------------------------------------------------------------------------}
FUNCTION GetBank : Word;

  Begin
    Regs.AX := $4F05;
    Regs.BX := $100;
    Intr($10,Regs);
    GetBank := Regs.DX;
  End; { GetBank Internal Function }

Procedure DrawHLineClip(x,y,x2: word; color: longint);
var
   a:word;
Begin
  for a := x to x2 do DrawPixelClip(a,y,color);
End;

Procedure DrawVLineClip(x,y,y2: word; color: longint);
var
  a: word;
Begin
  for a := y to y2 do DrawPixelClip(x,a,color);
End;

Procedure DrawHLine(x,y,x2: word; color: longint);
var
   a:word;
Begin
  for a := x to x2 do DrawPixel(a,y,color);
End;

Procedure DrawVLine(x,y,y2: word; color: longint);
var
  a: word;
Begin
  for a := y to y2 do DrawPixel(x,a,color);
End;

procedure timerproc; far;
begin
   Inc(a);
end;

PROCEDURE DrawPixel8(X, Y : Word; Color : Longint);

  Var
    Bank, Remaining : Word;
    I : Longint;

  Begin { 256 Colors }
    I := Longint(Y)*VesaMode.Bytes + Longint(X);
    Bank := I DIV 65536;
    Remaining := I MOD 65536;
    IF Bank <> CurBank Then SetBank(Bank);
    Mem[VesaMode.SegA:Word(Remaining)] := Color;
  End; { DrawPixel8 }

PROCEDURE DrawPixel16(X, Y : Word; Color : Longint);

  Var
    Bank, Remaining : Word;
    I : Longint;

  Begin { 32K, 64K Colors }
    I := Longint(Y)*VesaMode.Bytes + Longint(X SHL 1);
    Bank := I DIV 65536;
    Remaining := I MOD 65536;
    IF Bank <> CurBank Then SetBank(Bank);
    MemW[VesaMode.SegA:Word(Remaining)] := Color;
  End; { DrawPixel16 }

PROCEDURE DrawPixel24(X, Y : Word; Color : Longint);

  Var
    Bank, Remaining : Word;
    I : Longint;

  Begin { 16M Colors }
{ NOT TESTED }
{}  I := Longint(Y)*VesaMode.Bytes + Longint(X*3);
{}  Bank := I DIV 65536;
{}  Remaining := I MOD 65536;
{}  IF Bank <> CurBank Then SetBank(Bank);
{}  MemW[VesaMode.segA:Word(Remaining)] := Color;
{}  Mem[VesaMode.segA:Word(Remaining)+1] := Color;
{ NOT TESTED }
  End; { DrawPixel24 }

PROCEDURE DrawPixel32(X, Y : Word; Color : Longint);

  Var
    Bank, Remaining : Word;
    I : Longint;

  Begin { 16M Colors + Brigth }
    I := Longint(Y)*VesaMode.Bytes + Longint(X SHL 2);
    Bank := I DIV 65536;
    Remaining := I MOD 65536;
    IF Bank <> CurBank Then SetBank(Bank);
    MemL[VesaMode.segA:Word(Remaining)] := Color;
  End; { DrawPixel32 }

FUNCTION GetPixel8(X, Y : Word):Longint;

  Var
    Bank, Remaining : Word;
    I : Longint;

  Begin { 256 Colors }
    I := Longint(Y)*VesaMode.Bytes + Longint(X);
    Bank := I DIV 65536;
    Remaining := I MOD 65536;
    IF Bank <> CurBank Then SetBank(Bank);
    GetPixel8 := Mem[VesaMode.SegA:Word(Remaining)];
  End; { GetPixel8 }

FUNCTION GetPixel16(X, Y : Word):Longint;

  Var
    Bank, Remaining : Word;
    I : Longint;

  Begin { 32K, 64K Colors }
    I := Longint(Y)*VesaMode.Bytes + Longint(X SHL 1);
    Bank := I DIV 65536;
    Remaining := I MOD 65536;
    IF Bank <> CurBank Then SetBank(Bank);
    GetPixel16 := MemW[VesaMode.SegA:Word(Remaining)];
  End; { GetPixel16 }

FUNCTION GetPixel24(X, Y : Word):Longint;

  Var
    Bank, Remaining : Word;
    I : Longint;

  Begin { 16M Colors }
{ NOT TESTED }
{}  I := Longint(Y)*VesaMode.Bytes + Longint(X*3);
{}  Bank := I DIV 65536;
{}  Remaining := I MOD 65536;
{}  IF Bank <> CurBank Then SetBank(Bank);
{}  GetPixel24 := MemW[VesaMode.segA:Word(Remaining)];
{}  GetPixel24 := Mem[VesaMode.segA:Word(Remaining)+1];
{ NOT TESTED }
  End; { GetPixel24 }

FUNCTION GetPixel32(X, Y : Word):Longint;

  Var
    Bank, Remaining : Word;
    I : Longint;

  Begin { 16M Colors + Brigth }
    I := Longint(Y)*VesaMode.Bytes + Longint(X SHL 2);
    Bank := I DIV 65536;
    Remaining := I MOD 65536;
    IF Bank <> CurBank Then SetBank(Bank);
    GetPixel32 := MemL[VesaMode.segA:Word(Remaining)];
  End; { DrawPixel32 }
{$F-}

{ ============== Hardware and                               ================ }
{ ==============              Information                   ================ }
{ ==============                          Detection Rotines ================ }
{               ********************************************                 }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ GetVesaInfo                                                                }
{              - Description : Get Information on VESA modes, etc            }
{              - Input       : ----                                          }
{              - Return      : Returns info into the TVesaInfo Record        }
{----------------------------------------------------------------------------}
PROCEDURE GetVesaInfo;

  Begin
    Regs.AX := $4F00;
    Regs.DI := Ofs(VesaInfo);
    Regs.ES := Seg(VesaInfo);
    Intr($10,Regs);
  End; { GetVesaInfo }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ GetVesaModeInfo                                                            }
{              - Description : Get Information on a VESA mode                }
{              - Input       : Md --> mode to get information                }
{              - Return      : Returns info into the TVesaMode Record        }
{----------------------------------------------------------------------------}
PROCEDURE GetVesaModeInfo(Md : Word);

  Begin
    Regs.AX := $4F01;
    Regs.CX := Md;
    Regs.DI := Ofs(VesaMode);
    Regs.ES := Seg(VesaMode);
    Intr($10,Regs);
  End; { GetVesaModeInfo }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ IsVesa                                                                     }
{          - Description : Detects whether VESA support is present           }
{          - Input       : ----                                              }
{          - Return      : ----                                              }
{----------------------------------------------------------------------------}
FUNCTION IsVesa : Boolean;

  Begin
    Regs.AX := $4F03;
    Intr($10,Regs);
    IsVesa := (Regs.AL = $4F);
  End; { IsVesa }

{ ========================= Accessing              ========================= }
{ =========================           Vesa         ========================= }
{ =========================                Rotines ========================= }
{                          ************************                          }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ CloseVesaMode                                                              }
{              - Description : Closes Vesa mode and returns to text mode     }
{              - Input       : ----                                          }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE CloseVesaMode; Assembler;

  Asm
    MOV  AX,$4F03; { Standard way of reseting videocard }
    INT  $10;
    MOV  AX,$0003; { Standard way of reseting videocard }
    INT  $10;
  End; { CloseVesaMode }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ GetMode                                                                    }
{          - Description : Returns the current video mode                    }
{          - Input       : ----                                              }
{          - Return      : The actual VESA mode                              }
{----------------------------------------------------------------------------}
FUNCTION GetMode : Word;

  Begin
    Regs.AX := $4F03;
    Intr($10,Regs);
    GetMode := Regs.BX;
  End; { GetMode }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ SetMode                                                                    }
{          - Description : Sets a video mode VESA                            }
{          - Input       : Md --> Mode to set                                }
{          - Return      : TRUE if sucessufull                               }
{----------------------------------------------------------------------------}
FUNCTION SetMode(Md : Word) : Boolean;

  Var
    A : Byte;
    ModeAvail : Boolean;

  Begin
    SetMode := True;
    VesaOn := True;
    ModeAvail := False;
    For A := 1 TO 32 DO
      IF Md = VesaInfo.List^[A] Then ModeAvail := True;
    IF ((Md > $FF) AND ModeAvail) Then
      Begin
        Regs.BX := Md;
        Regs.AX := $4F02;
        Intr($10,Regs);
        IF Regs.AX <> $4F Then
          Begin
            SetMode := False;
            VesaOn := False;
          End
        Else
          Begin
            GetVesaModeInfo(Md);
            CurBank := 0;
            ClipMinX := 0;
            ClipMinY := 0;
            ClipMaxX := VesaMode.Width;
            ClipMaxY := VesaMode.Height;
            MaxX := VesaMode.Width;
            MaxY := VesaMode.Height;
            Case VesaMode.Bits OF
              8 : Begin
                    VDrawPixel := DrawPixel8;
                    VGetPixel := GetPixel8;
                  End;
          15,16 : Begin
                    VDrawPixel := DrawPixel16;
                    VGetPixel := GetPixel16;
                  End;
             24 : Begin
                    VDrawPixel := DrawPixel24;
                    VGetPixel := GetPixel24;
                  End;
             32 : Begin
                    VDrawPixel := DrawPixel32;
                    VGetPixel := GetPixel32;
                  End;
            End;
          End;
      End
    Else
      Begin
        SetMode := False;
        VesaOn := False;
        IF Not ModeAvail Then System.Writeln('Mode Unavailed');
      End;
  End; { SetMode }

{ ======================== Basic                 =========================== }
{ ========================       Usefull         =========================== }
{ ========================               Rotines =========================== }
{                         ***********************                            }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ Retrace                                                                    }
{              - Description : Waits for vertical retrace                    }
{              - Input       : ----                                          }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE Retrace; Assembler;

  Asm
    MOV   DX,3DAh
   @Wait:
    IN    AL,DX
    TEST  AL,08h
    JZ    @Wait
   @Retr:
    IN    AL,DX
    TEST  AL,08h
    JNZ   @Retr
  End;  { Retrace }

{ ======================== Primitive                 ======================= }
{ ========================           Drawing         ======================= }
{ ========================                   Rotines ======================= }
{                         ***************************                        }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ DrawCircle                                                                 }
{              - Description : Draws a circle. This rotine draws a circle but}
{                              clipped too                                   }
{              - Input       : X, Y, Radius, Color --> Anyone needs to I     }
{                                                      explain those to you  }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE DrawCircle(X, Y, Radius : Word; Color : Longint);

  Var
    Xs, Ys    : Integer;
    Da, Db, S : Integer;

  Begin
    IF (Radius = 0) Then Exit;
    IF (Radius = 1) Then
      Begin
        DrawPixelClip(X, Y, Color);
        Exit;
      End;
    Xs := 0;
    Ys := Radius;
    Repeat
      Da := (Xs+1)*(Xs+1) + Ys*Ys - Radius*Radius;
      Db := (Xs+1)*(Xs+1) + (Ys - 1)*(Ys - 1) - Radius*Radius;
      S  := Da + Db;
      Xs := Xs + 1;
      IF (S > 0) Then Ys := Ys - 1;
      DrawPixelClip(X+Xs-1, Y-Ys+1, Color);
      DrawPixelClip(X-Xs+1, Y-Ys+1, Color);
      DrawPixelClip(X+Ys-1, Y-Xs+1, Color);
      DrawPixelClip(X-Ys+1, Y-Xs+1, Color);
      DrawPixelClip(X+Xs-1, Y+Ys-1, Color);
      DrawPixelClip(X-Xs+1, Y+Ys-1, Color);
      DrawPixelClip(X+Ys-1, Y+Xs-1, Color);
      DrawPixelClip(X-Ys+1, Y+Xs-1, Color);
    Until (Xs >= Ys);
  End; { DrawCircle }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ DrawEllipse                                                                }
{              - Description : Draws an ellipse and a clipped ellipse too    }
{              - Input       : X, Y, RadX, RadY, Color --> Anyone needs to I }
{                                                      explain those to you  }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE DrawEllipse(X, Y, RadX, RadY : Word; Color: Longint);

  Var
    X1, X2, Y1, Y2 : Integer;
    Aq, Bq, dX, dY, R, rX,rY : Longint;

  Begin
    DrawPixelClip(X + RadX, Y, Color);
    DrawPixelClip(X - RadX, Y, Color);
    X1 := X - RadX;
    Y1 := Y;
    X2 := X + RadX;
    Y2 := Y;
    Aq := Longint(RadX) * RadX; { Calc Sqr }
    Bq := Longint(RadY) * RadY;
    dX := Aq SHL 1; { dX := 2 * RadX * RadX }
    dY := Bq SHL 1; { dY := 2 * RadY * RadY }
    R  := RadX * Bq; { R := RadX * RadY * RadY }
    rX := R SHL 1;   { rX := 2 * RadX * RadY * RadY }
    rY := 0; { Because Y = 0 }
    X := RadX;
    While X > 0 DO
      Begin
        IF R > 0 Then
          Begin { Y + 1 }
            INC(Y1);
            DEC(Y2);
            INC(rY, dX); { rY := dX * Y }
            DEC(R, rY);  { R := R - dX + Y}
          End;
        IF R <= 0 Then
          Begin { X - 1 }
            DEC(X);
            INC(X1);
            DEC(X2);
            DEC(rX, dY); { rX := dY * X }
            INC(R, rX);  { R := R + dY * X }
          End;
        DrawPixelClip(X1, Y1, Color);
        DrawPixelClip(X1, Y2, Color);
        DrawPixelClip(X2, Y1, Color);
        DrawPixelClip(X2, Y2, Color);
      End;
  End; { DrawEllipse }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ DrawLine                                                                   }
{              - Description : Draws a line                                  }
{              - Input       : X1, X2, Y1, Y2, Color --> Anyone needs to I   }
{                                                      explain those to you  }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE DrawLine(X1, Y1, X2, Y2 : Integer; Color : Longint);

  Var
    X, Y, dX, dY, Xs, Ys, Direction : Integer;

  Begin
    IF X1 = X2 Then DrawVline(X1,Y1,Y2,Color)
    Else
      IF Y1 = Y2 Then DrawHline(X1,Y1,X2,Color)
      Else
        Begin
          X := X1;
          Y := Y1;
          Xs := 1;
          Ys := 1;
          IF X1 > X2 Then Xs := -1;
          IF Y1 > Y2 Then Ys := -1;
          dX := Abs(X2 - X1);
          dY := Abs(Y2 - Y1);
          IF dX = 0 Then direction := -1
          Else Direction := 0;
          While NOT ((X = X2) AND (Y = Y2)) DO
            Begin
              DrawPixel(X,Y,Color);
              IF Direction < 0 Then
                Begin
                  Inc(Y,Ys);
                  Inc(Direction,dX);
                End
              Else
                Begin
                  Inc(X,Xs);
                  Dec(Direction,dY);
                End;
            End;
        End;
  End;  { DrawLine }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ DrawPixel                                                                  }
{              - Description : Draws a pixel                                 }
{              - Input       : X, Y, Color --> Anyone needs to I explain     }
{                                              those to you                  }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE DrawPixel(X, Y : Word; Color : Longint);

  Begin
    VDrawPixel(X,Y,Color);
  End; { DrawPixel }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ DrawRectangle                                                              }
{              - Description : Draws a rectangle                             }
{              - Input       : X1, X2, Y1, Y2, Color --> Anyone needs to I   }
{                                                        explain those to you}
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE DrawRectangle(X1, Y1, X2, Y2 : Word; Color : longint);

  Begin
    DrawLine(X1,Y1,X1,Y2,Color); { Vertical 1 }
    DrawLine(X2,Y1,X2,Y2,Color); { Vertical 2 }
    DrawLine(X1,Y1,X2,Y1,Color); { Horizontal 1 }
    DrawLine(X1,Y2,X2,Y2,Color); { Horizontal 2 }
  End; { DrawRectangle }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ GetPixel                                                                   }
{           - Description : Gets the color of a specified pixel              }
{           - Input       : X, Y --> Anyone needs to I explain those to you  }
{           - Return      : The pixel color                                  }
{----------------------------------------------------------------------------}
FUNCTION GetPixel(X, Y : Word):Longint;

  Begin
    GetPixel := VGetPixel(X,Y);
  End; { GetPixel }

{ ============================= Clipping         =========================== }
{ =============================          Rotines =========================== }
{                              ******************                            }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ SetViewPort                                                                }
{              - Description : Makes a window where will be drawed the pixels}
{              - Input       : X1,Y1,X2,Y2 --> New range values              }
{                              Color --> Color to design the window limits   }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE SetViewPort(X1,Y1,X2,Y2 : Word; Color : Longint);

  Begin
    DrawRectangle(X1,Y1,X2,Y2,Color);
    ClipMinX := X1;
    ClipMinY := Y1;
    ClipMaxX := X2;
    ClipMaxY := Y2;
    MaxX := X2-X1;
    MaxY := Y2-Y1;
    ClippingOn := TRUE;
  End; { MakeWindow }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ RestoreRealViewPort                                                        }
{              - Description : Restores the real values of the screen        }
{              - Input       : ----                                          }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE RestoreRealViewPort;

  Begin
    ClipMinX := 0;
    ClipMinY := 0;
    ClipMaxX := VesaMode.Width;
    ClipMaxY := VesaMode.Height;
    MaxX := VesaMode.Width;
    MaxY := VesaMode.Height;
    ClippingOn := FALSE;
  End; { RestoreRealWindow }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ DrawPixelClip                                                              }
{              - Description : Draws a pixel but with clip                   }
{              - Input       : X, Y, Color --> Anyone needs to I explain     }
{                                              those to you                  }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE DrawPixelClip(X, Y : Word; Color : Longint);

  Begin
    X := ClipMinX + X;
    Y := ClipMinY + Y;
    IF ((X <= ClipMinX) OR (X >= ClipMaxX)) OR ((Y <= ClipMinY) OR (Y >= ClipMaxY)) OR (Not VesaOn) Then Exit
    Else VDrawPixel(X,Y,Color);
  End; { DrawPixelClip }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ DrawLineClip                                                               }
{              - Description : Draws a line clipped                          }
{              - Input       : X1, X2, Y1, Y2, Color --> Anyone needs to I   }
{                                                      explain those to you  }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE DrawLineClip(X1, Y1, X2, Y2 : Integer; Color : Longint);

  Var
    X, Y, dX, dY, Xs, Ys, Direction : Integer;

  Begin
    IF X1 = X2 Then DrawVlineClip(X1,Y1,Y2,Color)
    Else
      IF Y1 = Y2 Then DrawHlineClip(X1,Y1,X2,Color)
      Else
        Begin
          X := X1;
          Y := Y1;
          Xs := 1;
          Ys := 1;
          IF X1 > X2 Then Xs := -1;
          IF Y1 > Y2 Then Ys := -1;
          dX := Abs(X2 - X1);
          dY := Abs(Y2 - Y1);
          IF dX = 0 Then direction := -1
          Else Direction := 0;
          While NOT ((X = X2) AND (Y = Y2)) DO
            Begin
              DrawPixelClip(X,Y,Color);
              IF Direction < 0 Then
                Begin
                  Inc(Y,Ys);
                  Inc(Direction,dX);
                End
              Else
                Begin
                  Inc(X,Xs);
                  Dec(Direction,dY);
                End;
            End;
        End;
  End;  { DrawLineClip }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ DrawRectangleClip                                                          }
{              - Description : Draws a rectangle clipped                     }
{              - Input       : X1, X2, Y1, Y2, Color --> Anyone needs to I   }
{                                                        explain those to you}
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE DrawRectangleClip(X1, Y1, X2, Y2 : Word; Color : longint);

  Begin
    DrawLineClip(X1,Y1,X1,Y2,Color); { Vertical 1 }
    DrawLineClip(X2,Y1,X2,Y2,Color); { Vertical 2 }
    DrawLineClip(X1,Y1,X2,Y1,Color); { Horizontal 1 }
    DrawLineClip(X1,Y2,X2,Y2,Color); { Horizontal 2 }
  End; { DrawRectangleClip }

{ ============================== Fill          ============================= }
{ ==============================      Routines ============================= }
{                               ***************                              }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ FillScreen                                                                 }
{              - Description : Fills the screen with a color                 }
{              - Input       : Color -> Color to fill the screen             }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE FillScreen(Color : Longint);

  Var
     A : Byte;

  Begin
    FOR A := 0 TO VesaInfo.TotalMemory DO
      Begin
        SetBank(A);
        Fillchar(Mem[VesaMode.SegA:0000], $FFFF, Color);
      End;
  End; { FillScreen }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ FillView                                                                   }
{              - Description : Fills the actual clipped window               }
{              - Input       : Color -> Color to fill the clipped window     }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE FillView(Color : Longint);

  Var
     Y : Integer;

  Begin
    FOR Y := 1 TO MaxY DO DrawLineClip(1,Y,MaxX,Y,Color);
  End; { FillView }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ FillBar                                                                    }
{              - Description : Fills a bar                                   }
{              - Input       : Color -> Color to fill the bar                }
{                              X1,Y1,X2,Y2 -> Are you asking me to explain   }
{                                             these to you?                  }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE FillBar(X1,Y1,X2,Y2 : Word;Color : Longint);

  Var
     Y : Integer;

  Begin
    FOR Y := Y1 TO Y2 DO DrawLine(X1,Y,X2,Y,Color);
  End; { FillView }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ FillArea                                                                   }
{              - Description : Fills an area with a specified color          }
{              - Input       : FillColor -> Color to fill the area           }
{                              BorderColor -> Color to check the border      }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE FillArea(X,Y : Word;FillColor : Longint);

  Var
     Xt,Yt : Word;

  Begin
{
    For Xt := X downto ClipMinX Do
}
  End; { FillArea }

{ ========================= Palette                   ====================== }
{ =========================         And Color         ====================== }
{ =========================                   Rotines ====================== }
{                          ***************************                       }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ SetColor                                                                   }
{              - Description : Changes a color with new RGB values           }
{              - Input       : Color --> the color to change                 }
{                              Red, Green, Blue --> the new values           }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE SetColor(Color : Longint; Red, Green, Blue : Byte);

  Begin
    Port[$3C8] := Color;
    Port[$3C9] := Red;
    Port[$3C9] := Green;
    Port[$3C9] := Blue;
  End; { SetColor }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ GetColor                                                                   }
{              - Description : Gets the RGB values from a color              }
{              - Input       : Color --> the color to get values             }
{              - Return      : Red, Green, Blue --> output values            }
{----------------------------------------------------------------------------}
PROCEDURE GetColor(Color : Longint; Var Red, Green, Blue : Byte);

  Begin
    Port[$3C7] := Color;
    Red   := Port[$3C9];
    Green := Port[$3C9];
    Blue  := Port[$3C9];
  End; { SetColor }

{ ========================== Frames                 ======================== }
{ ==========================        Counter         ======================== }
{ ==========================                Rotines ======================== }
{                           ************************                         }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ CheckFramesCounter                                                         }
{              - Description : Checks and updates the new frames values      }
{              - Input       : ----                                          }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE CheckFramesCounter;

  Begin
    Inc(Ticks);
    IF A = 1 Then
      Begin
        Inc(TotalSec);
        A := 0;
      End;
  End; { CheckFramesCounter }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ InitFramesCounter                                                          }
{              - Description : Initiates the frames counter                  }
{              - Input       : ----                                          }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE InitFramesCounter;

  Begin
    A := 0;
    Ticks := 0;
    TotalSec := 0;
    Install_Handler(@TimerProc, 1);
  End; { InitFramesCounter }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ StopFramesCounter                                                          }
{              - Description : Stops the frames counter and says the values  }
{              - Input       : VAR TotalTicks and TotalSeconds               }
{              - Return      : The frames per second value                   }
{----------------------------------------------------------------------------}
FUNCTION StopFramesCounter(Var TotalTicks : Longint;
                           Var TotalSeconds : Integer) : Real;

  Begin
    TotalTicks := Ticks;
    TotalSeconds := TotalSec;
    StopFramesCounter := Ticks / TotalSec;
    Remove_handler(@TimerProc);
  End; { StopFramesCounter }

















Function SizeOfVideoState:Word;
Begin  { Will save/restore all video states }
  Regs.ax:=$4F04;
  Regs.dl:=0;
  Regs.cx:=$0F;  { hardware, BIOS, DAC & SVGA states }
  Intr($10,Regs);
  SizeOfVideoState:=Regs.bx;
End;

Procedure SaveVideoState(Var buf);
Begin
  Regs.ax:=$4F04;
  Regs.dl:=1;
  Regs.cx:=$0F;
  Regs.es:=Seg(buf);
  Regs.bx:=Ofs(buf);
  Intr($10,Regs);
End;

Procedure RestoreVideoState(Var buf);
Begin
  Regs.ax:=$4F04;
  Regs.dl:=2;
  Regs.cx:=$0F;
  Regs.es:=Seg(buf);
  Regs.bx:=Ofs(buf);
  Intr($10,Regs);
End;

Procedure SetLineLength(Var len:Word);
Begin
  Regs.ax:=$4F06;
  Regs.bl:=0;
  Regs.cx:=len;
  Intr($10,Regs); { dx:=maximum number of scan lines }
  len:=Regs.cx;
End;

Function GetLineLength:Word;
Begin
  Regs.ax:=$4F06;
  Regs.bl:=1;
  Intr($10,Regs); { dx:=maximum number of scan lines }
  GetLineLength:=Regs.cx;
End;

Procedure SetDisplayStart(pixel,line:Word);
Begin
  Regs.ax:=$4F07;
  Regs.bx:=0;
  Regs.cx:=pixel;
  Regs.dx:=line;
  Intr($10,Regs);
End;

Procedure GetDisplayStart(Var pixel,line:Word);
Begin
  Regs.ax:=$4F07;
  Regs.bx:=1;
  Intr($10,Regs);
  pixel:=Regs.cx;
  line:=Regs.dx;
 End;

Begin
  GetVesaInfo;
End.

