                                                                                (*
      VBE 2.0 Version 0.1 -- Access and Use of VBE 2.0 graphics modes
         Copyright 1995-1997 by Fernando J.A. Silva ( aka ^Magico^ )

          _.--.__                                             _.--.
       ./'       `--.__                                   ..-'   ,'
     ,/               |`-.__                            .'     ./
    :,                 :    `--_    __                .'   ,./'_.....
    :                  :   /    `-:' _\.            .'   ./..-'   _.'
    :                  ' ,'       : / \ :         .'    `-'__...-'
    `.               .'  .        : \@/ :       .'       '------.,
       ._....____  ./    :     .. `     :    .-'      _____.----'
                 `------------' : |     `..-'        `---.
                            .---'  :    ./      _._-----'
   .---------._____________ `-.__/ : /`      ./_-----/':
   `---...--.              `-_|    `.`-._______-'  /  / ,-----.__----.
      ,----' ,__.  .          |   /  `\.________./  ====__....._____.'
      `-___--.-' ./. .-._-'----\.                  ./.---..____.--.
            :_.-' '-'            `..            .-'===.__________.'
                                    `--...__.--'
[ And we must fly with the new tecnology...                                  ]
[ From Paul Desjarlais <paul_desjarlais@pharlap.com>                         ]

                                                                                *)
Unit VBE20; { Video Bios Extension 2.0 Unit }

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE

  Type
    VbeInfoRec = Record
      VBESignature      : Array [0..3] OF Char; { Signature - "VESA"         }
      VbeVersion        : Word;  { VESA Version number                       }
      OEMStringPtr      : PChar; { Pointer to manufacturer name              }
      Capabilities      : DWord; { Capabilities Flags                        }
      VideoModePtrOfs   : Word;  { Pointer to list of VESA modes             }
      VideoModePtrSeg   : Word;  { Pointer to list of VESA modes             }
      TotalMemory       : Word;  { Number of 64k memory blocks on card       }

      { VESA 2.0 }

      OemSoftwareRev    : Word;  { OEM Software Version                      }
      OemVendorNamePtr  : PChar; { Pointer to Vendor Name                    }
      OemProductNamePtr : PChar; { Pointer to product name                   }
      OemProductRevPtr  : PChar; { Pointer to product revision string        }
      InfoReserved      : Array [0..221] OF Byte; { Reserved                 }
      OemData           : Array [0..255] OF Char; { OEM scratchpad           }
    End; { VbeInfoRec }

    ModeInfoRec  = Record

      { Mandatory information for all VBE revisions }

      ModeAttributes      : Word;  { Mode Attributes                         }
      WinAAttributes      : Byte;  { Window A attributes                     }
      WinBAttributes      : Byte;  { Window B attributes                     }
      WinGranularity      : Word;  { Window granularity in K bytes           }
      WinSize             : Word;  { Size of window in K bytes               }
      WinASegment         : Word;  { Segment address of window A             }
      WinBSegment         : Word;  { Segment address of window B             }
      WinFuncPtr          : DWord; { Windows positioning function            }
      BytesPerScanLine    : Word;  { Number of bytes per line                }

      { Mandatory information for VBE 1.2 and above }

      XResolution         : Word;  { Number of horizontal pixels             }
      YResolution         : Word;  { Number of vertical pixels               }
      XCharSize           : Byte;  { Width of character cell                 }
      YCharSize           : Byte;  { Height of character cell                }
      NumberOfPlanes      : Byte;  { Number of memory planes                 }
      BitsPerPixel        : Byte;  { Number of bits per pixel                }
      NumberOfBanks       : Byte;  { Number of banks        (not used)       }
      MemoryModel         : Byte;  { Memory model type                       }
      BankSize            : Byte;  { Size of bank           (not used)       }
      NumberOfImagePages  : Byte;  { Number of image pages                   }
      Reserved            : Byte;  { The following are for 15,16,24,32 bit colour modes }

      { Direct Color fields (required for direct/6 and YUV/7 memory models)  }

      RedMaskSize         : Byte;  { Size of Red mask in bits                }
      RedFieldPosition    : Byte;  { Bit position of LSB of Red mask         }
      GreenMaskSize       : Byte;  { Size of Green mask in bits              }
      GreenFieldPosition  : Byte;  { Bit position of LSB of Green mask       }
      BlueMaskSize        : Byte;  { Size of Blue mask in bits               }
      BlueFieldPosition   : Byte;  { Bit position of LSB of Blue mask        }
      RsvdMaskSize        : Byte;  { Size of Reserved mask in bits           }
      RsvdFieldPosition	  : Byte;  { Bit pos. of LSB of Reserved mask        }
      DirectColorModeInfo : Byte;  { Direct Colour mode attributes           }

      { Mandatory information for VBE 2.0 and above }

      PhysBasePtr         : DWord; { Physical address for flat frame buffer  }
      OffScreenMemOffset  : DWord; { Pointer to start of off screen memory  }
      OffScreenMemSize    : Word;  { Amount of off screen memory in 1k units }
      ModeReserved        : Array [0..205] OF Byte;{ Pad to 256 byte block size }
    End; { ModeInfoRec }

  Var
    VbeInfo  : VbeInfoRec;
    ModeInfo : ModeInfoRec;

{ -_-_-_-_-_-_-_-_-_-_-_-_-_-_ Public rotines -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-}

{ Hardware and information detection rotines }
  FUNCTION GetVbeInfo : Byte;
  FUNCTION GetVbeModeInfo(Mode : Word) : Byte;
  FUNCTION SearchMode(XRes, YRes, BPP : Word) : Word;

{ Accessing VBE rotines }
  PROCEDURE CloseVbeMode;
  FUNCTION  VbeSetMode(Mode : Word) : Byte;
  PROCEDURE VBEInit(XRes,YRes,BPP : Word);

{ Basic usefull rotines }
  PROCEDURE Retrace;

{ Primitive drawing rotines }
  PROCEDURE DrawCircle(X, Y, Radius : Word; Color : Longint);
  PROCEDURE DrawEllipse(X,Y, RadX, RadY : Word; Color: Longint);
  PROCEDURE DrawLine(X1, Y1, X2, Y2 : Integer; Color : Longint);
  PROCEDURE DrawPixel(X, Y : Word; Color : Longint);
  PROCEDURE DrawRectangle(X1, Y1, X2, Y2 : Word; Color : Longint);
  FUNCTION  GetPixel(X,Y:Word) : Longint;


{ Palette and color rotines }
  PROCEDURE SetColor(Color : Longint; Red, Green, Blue : Byte);
  PROCEDURE GetColor(Color : Longint; Var Red, Green, Blue : Byte);

{ Frames counter rotines }
  PROCEDURE CheckFramesCounter;
  PROCEDURE InitFramesCounter;
  FUNCTION  StopFramesCounter(Var TotalTicks : Longint;
                              Var TotalSeconds : Integer) : Real;

{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }
IMPLEMENTATION

  Uses
    Crt,DOS,Math,DPMI;

  Type
    TDrawPixel = Procedure(X, Y : Word; Color : Longint);
    TGetPixel = Function(X,Y:Word):Longint;

  Var
    pBase,
    PageSize : dword;
    lastmode : byte;
    wininit  : boolean;
    pScreen  : dword;
    vesainstalled,
    PModePresent:boolean;
    A, Ticks, TotalSec : Longint;
    t1,t2 : longint;
    VDrawPixel : TDrawPixel;
    VGetPixel : TGetPixel;
    MaxX , MaxY : Word;

{ ======================== Unit                  =========================== }
{ ========================      Internal         =========================== }
{ ========================               Rotines =========================== }
{                         ***********************                            }
  function CheckPModeInterface:Boolean;
    var
      dpmiregs:tdpmiregs;
  begin
    fillchar(dpmiregs,sizeof(dpmiregs),0);
    dpmiregs.eax:=$00004F0A;
    dpmiregs.es :=buf_16;
    dpmiregs.edi:=$00000000;
    callint($10,dpmiregs);
    CheckPModeInterface:=dpmiregs.eax=$0000004F;
  end;

PROCEDURE DrawPixel8(X, Y : Word; Color : Longint);

  Begin { 256 Colors }
    Mem[pScreen + DWord(Y*ModeInfo.BytesPerScanLine + X)] := Color;
  End; { DrawPixel8 }

PROCEDURE DrawPixel16(X, Y : Word; Color : Longint);

  Begin { 32K, 64K Colors }
    MemW[pScreen + DWord(Y*ModeInfo.BytesPerScanLine + X SHL 1)] := Color;
  End; { DrawPixel16 }

PROCEDURE DrawPixel32(X, Y : Word; Color : Longint);

  Begin { 16M Colors + Brigth }
    MemD[pScreen + DWord(Y*ModeInfo.BytesPerScanLine + X SHL 2)] := Color;
  End; { DrawPixel32 }

FUNCTION GetPixel8(X, Y : Word):Longint;

  Begin { 256 Colors }
    GetPixel8 := Mem[pScreen + DWord(Y*ModeInfo.BytesPerScanLine + X)];
  End; { GetPixel8 }

FUNCTION GetPixel16(X, Y : Word):Longint;

  Begin { 32k, 64k colors }
    GetPixel16 := MemW[pScreen + DWord(Y*ModeInfo.BytesPerScanLine + X SHL 1)];
  End; { GetPixel16 }

FUNCTION GetPixel32(X, Y : Word):Longint;

  Begin { 16M Colors + Brigth }
    GetPixel32 := MemD[pScreen + DWord(Y*ModeInfo.BytesPerScanLine + X SHL 2)];
  End; { GetPixel32 }

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

PROCEDURE ErrorMsg(Str : String;Bool : Boolean);

  Begin
    WriteLn(Str);
    IF Bool Then Halt;
  End; { ErrorMsg }

{ ============== Hardware and                               ================ }
{ ==============              Information                   ================ }
{ ==============                          Detection Rotines ================ }
{               ********************************************                 }


{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ GetVbeInfo                                                                 }
{              - Description : Get Information on VBE modes, etc             }
{              - Input       : ----                                          }
{              - Return      : Returns info into the VbeInfo Record, and     }
{                              returns TRUE if VESA is present FALSE if not  }
{----------------------------------------------------------------------------}
FUNCTION GetVbeInfo : Byte;

  Var
    DpmiRegs : tDpmiRegs;

  Begin
    GetVbeInfo := 0;
    VbeInfo.VBESignature:='VBE2';
    Move(VbeInfo,Pointer(Buf_32)^,Sizeof(VbeInfo));
    FillChar(DpmiRegs,Sizeof(DpmiRegs),0);
    DpmiRegs.eax := $00004F00;
    DpmiRegs.es  := Buf_16;
    DpmiRegs.edi := $00000000;
    CallInt($10,DpmiRegs);
    Move(Pointer(Buf_32)^,VbeInfo,Sizeof(VbeInfo));
    With VbeInfo DO
      Begin
        VbeSignature[0] := 'V';
        VbeSignature[1] := 'B';
        VbeSignature[2] := 'E';
        VbeSignature[3] := '2';
      End;
    IF Word(DpmiRegs.eax AND $0000FFFF)<>$004F Then
      Begin
        GetVbeInfo := 1;
        Exit;
      End;
    IF Not ((VbeInfo.VbeSignature[0]='V') AND (VbeInfo.VbeSignature[1]='B') AND
            (VbeInfo.VbeSignature[2]='E') AND (VbeInfo.VbeSignature[3]='2')) Then
      Begin
        GetVbeInfo := 2;
        Exit;
      End;
    IF Hi(VbeInfo.VbeVersion) < 2 Then
      Begin
        GetVbeInfo := 3;
        Exit;
      End;
    IF VbeInfo.TotalMemory < (1024/64) Then
      Begin
        GetVbeInfo := 4;
        Exit;
      End;
  End; { GetVbeInfo }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ GetVbeModeInfo                                                             }
{              - Description : Get Information on a VBE mode                 }
{              - Input       : Mode --> mode to get information              }
{              - Return      : Returns info into the VesaMode Record and     }
{                              returns TRUE if mode available FALSE if not   }
{----------------------------------------------------------------------------}
FUNCTION GetVbeModeInfo(Mode : Word) : Byte;

  Var
    DpmiRegs : tDpmiRegs;

  Begin
    GetVbeModeInfo := 0;
    FillChar(DpmiRegs,Sizeof(DpmiRegs),0);
    DpmiRegs.eax := $00004F01;
    DpmiRegs.ecx := Mode;
    DpmiRegs.es  := Buf_16;
    DpmiRegs.edi := $00000000;
    CallInt($10,DpmiRegs);
    Move(Pointer(Buf_32)^,ModeInfo,Sizeof(ModeInfo));
    IF Word(DpmiRegs.eax AND $0000FFFF)<>$004F Then
      Begin
        GetVbeModeInfo := 1;
        Exit;
      End;
  End; { GetVbeModeInfo }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ SearchMode                                                                 }
{              - Description : Searchs for a mode with specific parameters   }
{              - Input       : XRes --> X Resolution                         }
{                              YRes --> Y Resolution                         }
{                              BPP  --> number of bits for color             }
{              - Return      : The mode available for that parameters.       }
{                              Returns 0 if mode not found.                  }
{----------------------------------------------------------------------------}
FUNCTION SearchMode(XRes, YRes, BPP : Word) : Word;

  Var
    ModeFound : Boolean;
    ListAdr   : DWord;

  Begin
    ModeFound := False;
    ListAdr   := VbeInfo.VideoModePtrSeg SHL 4 + VbeInfo.VideoModePtrOfs;
    While (MemW[ListAdr]<>$FFFF) AND Not ModeFound DO
      Begin
        IF (GetVbeModeInfo(DWord(MemW[ListAdr]))=0) AND
           ((ModeInfo.ModeAttributes AND 1+2+8+16+128) = 1+2+8+16+128) AND
           (ModeInfo.XResolution = XRes) AND
           (ModeInfo.YResolution = YRes) AND
           (ModeInfo.BitsPerPixel = BPP) AND
           (ModeInfo.PhysBasePtr > 0) Then ModeFound := True
        Else
          Inc(ListAdr,2);
      End;
    SearchMode := MemW[ListAdr];
    IF Not ModeFound Then SearchMode := 0;
  End; { SearchMode }

{ ========================= Accessing              ========================= }
{ =========================           Vesa         ========================= }
{ =========================                Rotines ========================= }
{                          ************************                          }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ CloseVbeMode                                                               }
{              - Description : Closes Vesa mode and returns to text mode     }
{              - Input       : ----                                          }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE CloseVbeMode; Assembler;

  Asm
    MOV  AX,$0003; { Standard way of reseting videocard }
    INT  $10;
  End; { CloseVbeMode }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ SetMode                                                                    }
{          - Description : Sets a video mode VESA                            }
{          - Input       : Mode --> Mode to set                              }
{          - Return      : TRUE if sucessufull                               }
{----------------------------------------------------------------------------}
FUNCTION VbeSetMode(Mode : Word) : Byte;

  Var
    Limit,
    LinearAdr : DWord;
    DpmiRegs  : tDpmiRegs;
    i : Word;

  Begin
    VbeSetMode := 0;
    Asm
      mov eax,0
      mov ebx,0
      mov ecx,0
      mov edx,0
      mov bx,[mode]
      mov ax,$4F02
      int 10h
      mov [i],ax
    End;
   IF I<>$004F Then
     Begin
       VbeSetMode := 1;
       Exit;
     End;
   { Map Video Memory }
   LinearAdr := ModeInfo.PhysBasePtr;
   Limit := VbeInfo.TotalMemory*64*1024;
   Asm
     MOV    EAX,$0800
     MOV    EBX,LinearAdr
     MOV    ECX,EBX
     SHR    EBX,16
     AND    ECX,$0000FFFF
     MOV    ESI,Limit
     MOV    EDI,ESI
     SHR    ESI,16
     AND    EDI,$0000FFFF
     INT    $31
     JNC    @Skip
     XOR    EBX,EBX
     XOR    ECX,ECX
    @Skip:
     SHL    EBX,16
     OR     EBX,ECX
     MOV    LinearAdr,EBX
   End;
   IF LinearAdr = 0 Then
     Begin
       VbeSetMode := 2;
       Exit;
     End
   Else
     Begin
       pScreen := LinearAdr;
       pBase   := LinearAdr;
       IF ModeInfo.NumberOfImagePages > 0 Then PageSize := ModeInfo.YResolution*ModeInfo.BytesPerScanLine
       Else PageSize:=0;
       Case ModeInfo.BitsPerPixel OF
         8 : Begin
               VDrawPixel := DrawPixel8;
               VGetPixel := GetPixel8;
             End;
     15,16 : Begin
               VDrawPixel := DrawPixel16;
               VGetPixel := GetPixel16;
             End;
        32 : Begin
               VDrawPixel := DrawPixel32;
               VGetPixel := GetPixel32;
             End;
        End;
   End; { IF LinearAdr = 0 }
  End; { VbeSetMode }

PROCEDURE VBEInit(XRes,YRes,BPP : Word);

  Const
    InitStr    = 'Initializing...';
    ModName    = 'Video Bios Extension 2.0 Module (TMT)';
    ModVersion = '0.1';
    Bool       : Array [0..1] OF String[3] = ('n/a','OK');

    UseLFB  = $4000;

  Var
    Mode : Word;

  Begin
{    InitDpmi; }
    ClrScr;
    WriteLn(InitStr);
    WriteLn('  Module Name               : ',ModName);
    WriteLn('  Module Version            : ',ModVersion);
    Case GetVbeInfo OF
      0 : ErrorMsg('þ VESA 2.0 detected',False);
      1 : ErrorMsg('VESA Error : VESA not available (function $00 is not supported) ',True);
      2 : ErrorMsg('VESA Error : Invalid Block (VESA Signature not found) ',True);
      3 : ErrorMsg('VESA Error : VESA 2.0 not detected (Try to load UNIVBE.EXE) ',True);
      4 : ErrorMsg('VESA Error : You Need At Least 1 Mb of Video Memory',True);
    End;
    Mode := SearchMode(XRes,YRes,BPP);
    IF Mode = 0 Then ErrorMsg('VESA Error : Mode not supported',True);
    Case GetVbeModeInfo(Mode) of
      0 : ErrorMsg('þ Mode detected ',False);
      1 : ErrorMsg('VESA Error : Mode with LFB not supported (Try to Load UNIVBE.EXE) ',True);
    End;
    MaxX := ModeInfo.XResolution;
    MaxY := ModeInfo.YResolution;
    Delay(100);
    Case VbeSetMode(Mode+UseLFB) OF
      1 : Begin asm mov ax,3; int 10h; end; ErrorMsg('VESA Error : Cannot initialise Mode with LFB (Try to load UNIVBE.EXE) ',True); end;
      2 : Begin asm mov ax,3; int 10h; end; ErrorMsg('VESA Error : Cannot remap memory (INT $31,Fct $0800 Error) ',True); End;
    End;
  End; { VBEInit }

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
{              - Description : Draws a circle.                               }
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
        DrawPixel(X, Y, Color);
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
      DrawPixel(X+Xs-1, Y-Ys+1, Color);
      DrawPixel(X-Xs+1, Y-Ys+1, Color);
      DrawPixel(X+Ys-1, Y-Xs+1, Color);
      DrawPixel(X-Ys+1, Y-Xs+1, Color);
      DrawPixel(X+Xs-1, Y+Ys-1, Color);
      DrawPixel(X-Xs+1, Y+Ys-1, Color);
      DrawPixel(X+Ys-1, Y+Xs-1, Color);
      DrawPixel(X-Ys+1, Y+Xs-1, Color);
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
    DrawPixel(X + RadX, Y, Color);
    DrawPixel(X - RadX, Y, Color);
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
        DrawPixel(X1, Y1, Color);
        DrawPixel(X1, Y2, Color);
        DrawPixel(X2, Y1, Color);
        DrawPixel(X2, Y2, Color);
      End;
  End; { DrawEllipse }

PROCEDURE DrawPixel(X, Y : Word; Color : Longint);

  Begin
    IF ((X>0) AND (X<MaxX)) OR ((Y>0) AND (Y<MaxY)) Then VDrawPixel(X,Y,Color);
  End; { DrawPixel }

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

  Var
    Date  : DateTime;
    Dumb  : word;

  Begin
    Inc(Ticks);
{
    GetTime(date.hour,date.min,date.sec,dumb);
    t2 := date.hour*3600+date.min*60+date.sec;
    TotalSec := t2 - t1;
}
  End; { CheckFramesCounter }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ InitFramesCounter                                                          }
{              - Description : Initiates the frames counter                  }
{              - Input       : ----                                          }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE InitFramesCounter;

  Var
    Date  : DateTime;
    Dumb  : word;

  Begin
    Ticks := 0;
    TotalSec := 0;
    GetTime(date.hour,date.min,date.sec,dumb);
    t1 := date.hour*3600+date.min*60+date.sec;
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

  Var
    Date  : DateTime;
    Dumb  : word;

  Begin
    GetTime(date.hour,date.min,date.sec,dumb);
    t2 := date.hour*3600+date.min*60+date.sec;
    TotalSec := t2 - t1;
    TotalTicks := Ticks;
    TotalSeconds := TotalSec;
    StopFramesCounter := Ticks / TotalSec;
  End; { StopFramesCounter }

Begin
End.