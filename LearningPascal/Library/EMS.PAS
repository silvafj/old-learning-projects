                                                                                (*
                   EMS Version 1.0 --  LIM EMS Interface
         Copyright 1995-1997 by Fernando J.A. Silva   ( ^Magico^ )

                              ___,--------,____
                      __--~~~~                 ~~---,_
                   ,-'                  __,--,_       `\,___,-,__
                ,-'                 __/'/-~~~\  `  ` . '    , |  `~~\
             _/`      _/~~      '~~   \,_\_ o /        '  '~_/'      `\
           /'        '                   =-'~~  _  /  ~   /'          `\
        _/'  /~                            ,--,____,-----|,_,-,_       `\
    _,/'    '              ,-'      _      `~'------'~~~~~--    `~~~~\  |
 ,-'             /~       '    ,-~~~         _,       ,-=~~~~~~~~~~~~'| |
~              .'             '         ,   '      /~`                |/
                                  /' ,/'       _/~'
                   ,       /    /`          _/~
        /~        /      /`               /'
      .'                                /'
                       /'      .      /'
                      `       /'     |   -Chev
                                    '

 [ From: Knight@info.polymtl.ca (Chevalier)                                 ]
 [ A amazing eagle...                                                       ]
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
{$X+} { Enable extended syntax }
{$Y+} { Symbol Reference Information Switch - just afect the Unit size, and  }
      { it's very good when you run BP, because you can go directly to the   }
      { line where the source begins! Study, to know more!!!                 }
Unit EMS;

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE

  Const
    PageSize = 16384;  { EMS Page size: 16384 bytes }

    { LIM EMS functions result codes }
    EmsrOk            = $00; { Function successful }
    EmsrNotInitd      = $01; { EMS not installed }
    EmsrIntrnlError   = $80; { Internal error }
    EmsrHardwareMalf  = $81; { Hardware malfunction }
    EmsrBadHandle     = $83; { Invalid handle }
    EmsrBadFunction   = $84; { Undefined function requested }
    EmsrNoMoreHandles = $85; { No more handles available }
    EmsrMapContError  = $86; { Error in save or restore of mapping context }
    EmsrMorePagesPhys = $87; { More pages requested than physically exist }
    EmsrMorePagesCurr = $88; { More pages requested than currently available }
    EmsrZeroPages     = $89; { Zero pages requested }
    EmsrBadPageLogNum = $8A; { Invalid page logical number }
    EmsrBadPagePhyNum = $8B; { Invalid page physical number }

{ -_-_-_-_-_-_-_-_-_-_-_-_-_-_ Public rotines -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-}

  FUNCTION AllocEMB(Var Handle, PageSeg : Word; Pages : Word) : Byte;
  FUNCTION FreeEMB(Handle : Word) : Byte;
  FUNCTION GetErrorMsg(ErrorCode : Byte) : String;
  FUNCTION GetMemAvail(Var FreeMem : Word) : Byte;
  FUNCTION GetVersion(Var Version : Byte) : Byte;
  FUNCTION MapPages(Handle, LogicalPage : Word; PhysicalPage : Byte) : Byte;
  FUNCTION Setup : Boolean;

{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }
IMPLEMENTATION

  Const
    { LIM EMS 3+ function numbers }
    EGetPageFrame  = $41;
    EGetPageCount  = $42;
    EAllocPages    = $43;
    EMapPages      = $44;
    EReleasePages  = $45;
    EGetVersion    = $46;

  Var
    EMSInitiated : Boolean;

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ AllocEMB                                                                   }
{              - Description : Allocates specified number of 16 K-byte pages }
{                              and returns handle number in Handle parameter }
{              - Input       : Pages --> Number of pages to be allocated     }
{              - Return      : Handle --> Handle number to the allocated     }
{                                         memory                             }
{                              PageSeg --> Page frame segment address        }
{                              The function returns a function result code   }
{----------------------------------------------------------------------------}
FUNCTION AllocEMB(Var Handle, PageSeg : Word; Pages : Word) : Byte; Assembler;
{ To access data, use the following function :                               }
{     DataPtr := Ptr(PageSeg, PhysicalPageNumber * PageSize)                 }
  Asm
    MOV  AL,EmsrNotInitd { Move EmsrNotInitd value to AL                     }
    CMP  EMSInitiated,False { Compare it to EMSInitiated                     }
    JE   @@2 { If they are equal, EMS is not initiated and jumps to end      }
    MOV  AH,EGetPageFrame { Else Get Page Frame                              }
    INT  $67 { Call EMS Interrupt                                            }
    CMP  AH,0
    JNE  @@1
    LES  DI,PageSeg { Store page frame segment                               }
    MOV  [ES:DI],BX
    MOV  BX,Pages
    MOV  AH,EAllocPages
    INT  $67
    LES  DI,Handle
    MOV  [ES:DI],DX { Store handle number                                    }
   @@1:
    MOV  AL,AH { Return result code                                          }
   @@2:
  End; { AllocEMB }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ FreeEMB                                                                    }
{         - Description : Deallocates (releases) allocated expanded memory   }
{         - Input       : Handle --> The handle of the memory to be released }
{         - Return      : Function result code                               }
{----------------------------------------------------------------------------}
FUNCTION FreeEMB(Handle : Word) : Byte; Assembler;

  Asm
    MOV  AL,emsrNotInitd
    CMP  EMSInitiated,False
    JE   @@1
    MOV  AH,EReleasePages
    MOV  DX,Handle
    INT  $67
    MOV  AL,AH           { Return result code }
   @@1:
  End; { FreeEMB }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ GetErrorMsg                                                                }
{             - Description : Get an error message according to ErrorCode    }
{             - Input       : ErrorCode --> The error code                   }
{             - Return      : The string message                             }
{----------------------------------------------------------------------------}
FUNCTION GetErrorMsg(ErrorCode : Byte) : String;

  Begin
    Case ErrorCode OF
      EmsrNotInitd      : GetErrorMsg := 'EMM not initialized';
      EmsrIntrnlError   : GetErrorMsg := 'Internal error';
      EmsrHardwareMalf  : GetErrorMsg := 'Hardware malfunction';
      EmsrBadHandle     : GetErrorMsg := 'Invalid block handle';
      EmsrBadFunction   : GetErrorMsg := 'Function not implemented';
      EmsrNoMoreHandles : GetErrorMsg := 'No more handles available';
      EmsrMapContError  : GetErrorMsg := 'Error in save or restore of mapping context';
      EmsrMorePagesPhys : GetErrorMsg := 'More pages requested than physically exist';
      EmsrMorePagesCurr : GetErrorMsg := 'More pages requested than currently available';
      EmsrZeroPages     : GetErrorMsg := 'Zero pages requested';
      EmsrBadPageLogNum : GetErrorMsg := 'Invalid page logical number';
      EmsrBadPagePhyNum : GetErrorMsg := 'Invalid page physical number';
      Else GetErrorMsg := 'Unknown error'
    End; { Case }
  End; { GetErrorMsg }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ GetMemAvail                                                                }
{             - Description : Returns free memory                            }
{             - Input       : ----                                           }
{             - Return      : FreeMem --> The free memory                    }
{                             Function result code                           }
{----------------------------------------------------------------------------}
FUNCTION GetMemAvail(Var FreeMem : Word) : Byte; Assembler;

  Asm
    MOV  AL,emsrNotInitd
    CMP  EMSInitiated,False
    JE   @@1
    MOV  AH,EGetPageCount
    INT  $67
    SHL  BX,4            { Got in pages, convert to K-bytes }
    LES  DI,FreeMem
    MOV  [ES:DI],BX      { Store memory available in K-Bytes }
    MOV  AL,AH           { Store result byte }
   @@1:
  End; { GetMemAvail }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ GetVersion                                                                 }
{             - Description : Get Expanded Memory Manager version number     }
{             - Input       : ----                                           }
{             - Return      : Version --> The version number                 }
{                             Function result code                           }
{----------------------------------------------------------------------------}
FUNCTION GetVersion(Var Version : Byte) : Byte; Assembler;

  Asm
    MOV  AL,emsrNotInitd
    CMP  EMSInitiated,False  { If library not initialized by Setup }
    JE   @@1             { then exit }
    MOV  AH,EGetVersion  { Get EMS version }
    INT  $67
    LES  DI,Version
    MOV  [ES:DI],AL      { Store version number }
    MOV  AL,AH           { Store result byte }
   @@1:
  End; { GetVersion }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ MapPages                                                                   }
{         - Description : Maps a logical page number at physical page number }
{         - Input       : Handle --> handle number to the memory that will be}
{                                    mapped                                  }
{                         LogicalPage --> Logical page to be mapped          }
{                         PhysicalPage --> into a physical page              }
{         - Return      : Function result code                               }
{----------------------------------------------------------------------------}
FUNCTION MapPages(Handle, LogicalPage : Word; PhysicalPage : Byte) : Byte; Assembler;

  Asm
    MOV  AL,emsrNotInitd
    CMP  EMSInitiated,False
    JE   @@1
    MOV  AH,EMapPages
    MOV  DX,Handle
    MOV  BX,LogicalPage
    MOV  AL,PhysicalPage
    INT  $67
    MOV  AL,AH
   @@1:
  End; { MapPages }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ Setup                                                                      }
{              - Description : Checks if a EMM manager is installed          }
{              - Input       : ----                                          }
{              - Return      : TRUE --> If it's installed                    }
{----------------------------------------------------------------------------}
FUNCTION Setup : Boolean; Assembler;

  Const
    DeviceDriver : PChar = 'EMMXXXX0';

  Asm
    MOV   EMSInitiated,False { By default EMS is not initialized             }
    PUSH  DS
    MOV   AX,3D02h { DOS function to open the device as file                 }
    LDS   DX,DeviceDriver
    INT   $21
    POP   DS
    JC    @NotInstalled
    PUSH  AX { Store device handle to close the file afterwards              }
    MOV   AX,4407h { DOS function to test device status                      }
    INT   $21
    MOV   EMSInitiated,AL
    POP   BX
    MOV   AH,3Eh { Close the file using it's handle in BX                    }
    INT   $21
  @NotInstalled:
    MOV   AL,EMSInitiated
  End; { Setup }

Begin
  EMSInitiated := False
End.

{ The original code of this unit is Copyright (c) 1994 by Andrew Eigus       }
{ This code is 15% mine : I put many comments in all the code, and I made    }
{ new rotines to optimize memory tranfers                                    }

