                                                                               (*
            CDROM Version 1.0 -- Digital and Audio CDROM Support
          Copyright 1995-1997 by Fernando J.A. Silva   ( ^Magico^ )

             $$$$$$$$$$$$$$$$""$o$o$o$o$o$oo$$""$$$$$$$$$$$$$$$
             $$$$$$$$$$$$""o$$$$$$$$$$"$"$$$$$$$o$"$$$$$$$$$$$$
             $$$$$$$$$"$o$$$$""$oo $ ""      """$$$oo"$$$$$$$$$
             $$$$$$$"o$$$$"   ""o  $oo o o       ""$$$o"$$$$$$$
             $$$$$"o$$$"       oo$$$$$$$$$$o        "$$$o"$$$$$
             $$$$"o$$$  $  o$$$$$$$$$$$$$$"$$oo       "$$$ $$$$
             $$$"$$$"   "$$$$$$$$$$$$$$$$o$o$$$"        $$$o$$$
             $$ $$$    o$$$$$$$$$$$$$$$$$$$$$$$$o o   o  "$$o"$
             $"$$$"    o$$$$$$$$$"$$$$$$"" "$$$$$$"$$$$$  $$$"$
             $o$$"    o$$$$$$$$$$o""$$$""""ooo"$$$$$$$$"   $$$"
             $o$$"    o$$$$$$$$$$            ""oo"$"$o""   $$$o
             o$$$     o$$$$$$$$$$                """""$    o$$o
             o$$$    o$$$$$$$$$$$$o                   "o "oo$$o
             o$$$  oo$$$$$$$$$$$$$$$$ooooooo$$$$$oo    $"$ "$$o
             o$$$"  ""  $$$$$$$$$$$$$$$$$$$$$$$$$$$$o    " $$$
             $ $$$       "$$$$$$$$$$$$$$$$$$$$$$$$$$$o    o$$"$
             $$"$$o       "$$$$$$$$$$$$$$$$$$$$$$$$$$$o   $$$o$
             $$o$$$o       $$""$$$$$$$$$$$$$$$$$$$$$$$o  $$$ $$
             $$$o"$$o    "$""  "$""$$$$$$$$$$$$$$$$$$$oo$$$"$$$
             $$$$o"$$$o        "     $$$$$$$$$$$$$$$$$o$$"o$$$$
             $$$$$$o"$$$o         oo$$$$$$$$$$$$$$$$$$$$"o$$$$$
             $$$$$$$$o"$$$$ooooo$$$$$$$$$$$$$$$$$$$$$$"o$$$$$$$
             $$$$$$$$$$o""$$$$$$$$$$$$$$$$$$$$$$$$$"oo$$$$$$$$$
             $$$$$$$$$$$$$o$""$$$$$$$$$$$$$$$$$""oo$$$$$$$$$$$$
             $$$$$$$$$$$$$$$$$$o$o$"$"$"$"$oo$o$$$$$$$$$$$$$$$$

   [ This cool dragon symbol came from: jorn@Notwerk.mcs.com (Jorn Barger) ]
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
Unit CDROM;

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE

  Type


{ This record will keep the MSCDEX version.                                  }
    MSCDEXVersionRec = Record
                         Major,        { The major part of the version number}
                         Minor : Byte; { and the minor part of the same.     }
                       End;

    ListBuf    = Record
                   UnitCode : Byte;
                   UnitSeg,
                   UnitOfs  : Word;
                 End;

{ Record to keep the CDROM drive capabilities and status.                    }
    DeviceParametersRec = Record
                            DoorOpen,    { Door Open                         }
                            DoorUnLocked,{ Door Unlocked                     }
                            RawReading,  { Supports RAW reading in addition  }
                                         { to Cooked                         }
                            Writable,    { Writable                          }
                            AudioVideoTracks,{ Can play audio/video tracks   }
                            InterLeaving,    { Supports interleaving         }
                            Prefetch,        { Supports prefetch requests    }
                            AudioChannelControl,{ Supports audio channel     }
                                                { control                    }
                            RedBookAddressing, { Supports Red Book addressing}
                                               { in addition to HSG          }
{ The next is not used. Use "AudioDiskInfo.Playing" instead.                 }
{                           Playing,           { Audio is playing            }
                            NoDiscInDrive,     { No Disk in Drive            }
                            RWSubChannels : Boolean;{ Supports R-W subchannels }
                          End;

{ This record keeps all the related informations with the CDROM drive        }
    CDROMDriveRec = Record
                      NumCDDrv : Byte; { Number of cd-rom drives             }
                      FstCDDrv : Char; { First cd-rom drive letter           }
                      MSCDEXVersion : MSCDEXVersionRec; { See above          }
                      DriverList     : ARRAY [1..26] OF ListBuf;
                      UnitList       : ARRAY [1..26] OF Byte;
                      DeviceParameters : DeviceParametersRec; { See above    }
                    End;

{$IFNDEF NoCDAudioSupport}
  VTOCArray  = ARRAY [1..2048] OF Byte;
  DriveByteArray = ARRAY [1..128] OF Byte;

  AudioDiskInfoRec = RECORD
                       LowestTrack    : Byte;
                       HighestTrack   : Byte;
                       LeadOutTrack   : LongInt;
                       {new!}
                       VolInfo: ARRAY [1..8] OF Byte; { Lautst.-Einstellungen }
                       Playing,
                       Paused         : Boolean;
                     END;

  PAudioTrackInfo   = ^AudioTrackInfoRec;
  AudioTrackInfoRec = RECORD
                        Track           : Integer;
                        StartPoint      : LongInt;
                        EndPoint        : LongInt;
                        DFrames,
                        DSeconds,
                        DMinutes,
                        TMin,
                        TSec,
                        TrackControlInfo    : Byte;
                      END;

  QChannelInfoRec = RECORD
                      Control     : Byte;
                      Track       : Byte;
                      Index       : Byte;
                      TMinutes     : Byte;
                      TSeconds     : Byte;
                      TFrame       : Byte;
                      Zero        : Byte;
                      DMinutes    : Byte;
                      DSeconds    : Byte;
                      DFrame      : Byte;
                    END;
{$ENDIF}

{$IFNDEF NoDigitalCDSupport}
  DirBufRec    = RECORD
                   XAR_Len   : Byte;
                   FileStart : LongInt;
                   BlockSize : Integer;
                   FileLen   : LongInt;
                   DT        : Byte;
                   Flags     : Byte;
                   InterSize : Byte;
                   InterSkip : Byte;
                   VSSN      : Integer;
                   NameLen   : Byte;
                   NameArray : ARRAY [1..38] OF Char;
                   FileVer   : Integer;
                   SysUseLen : Byte;
                   SysUseData: ARRAY [1..220] OF Byte;
                   FileName  : String [38];
                 END;
{$ENDIF}

VAR
  CDROMDrive : CDROMDriveRec;
{$IFNDEF NoCDAudioSupport}
  TrackInfo    : ARRAY [1..18] OF PAudioTrackInfo;
  AudioDiskInfo  : AudioDiskInfoRec;
  QChannelInfo   : QChannelInfoRec;
  AudioChannel   : ARRAY [1..8] OF Byte;
{$ENDIF}
{$IFNDEF NoDigitalCDSupport}
  DirBuf         : DirBufRec;
{$ENDIF}
  Last_Start,
  Last_End       : LongInt;

{ -_-_-_-_-_-_-_-_-_-_-_-_-_-_ Public rotines -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-}

             {----------------------------------------------------}
             {------------ Rotines for all CD's Control ----------}
             {----------------------------------------------------}

{ Drive Status/Capabilities Rotines }
  FUNCTION GetUPCCode : Longint;
  FUNCTION MediaChanged : Boolean;
  FUNCTION MSCDEXInstalled : Byte;
  PROCEDURE DeviceStatus;
{
  FUNCTION File_Name (VAR Code : Integer) : String;
  FUNCTION Read_VTOC (VAR VTOC : VTOCArray; VAR Index : Integer) : Boolean;
}

{ CD-ROM Drive Commands }
  PROCEDURE Lock (LockDrive : Boolean);
  PROCEDURE ResetCD;
  PROCEDURE Eject;
  PROCEDURE CloseTray;

{$IFNDEF NoCDAudioSupport}
             {------------------------------------------------}
             {----- Rotines only for Audio CD's Control ------}
             {------------------------------------------------}

{ Drive Status/Capabilities Rotines }
{
  PROCEDURE Vol_Desc (VAR Code : Integer; VAR ErrCode : Integer);
}

{ Disc/Audio Current Information }
  PROCEDURE AudioChannelInfo;
  PROCEDURE CDAudioDiskInfo;
  PROCEDURE CDAudioStatusInfo;
  PROCEDURE CDQChannelInfo;
  PROCEDURE CreateTracksRecord;

{ Audio CD's Command Rotines }
  PROCEDURE Resume_Play;
  PROCEDURE Pause_Audio;
  PROCEDURE Play_Audio (StartSec, EndSec : LongInt);
  PROCEDURE Stop_Play;
  PROCEDURE PlayTrack(Track : Byte);

{$ENDIF}
{$IFNDEF NoDigitalCDSupport}
        {--------------------------------------------------------}
        {----- Rotines only for Digital Files CD's Control ------}
        {--------------------------------------------------------}

{ Drive Status/Capabilities Rotines }
{
  PROCEDURE Get_Dir_Entry (PathName : String; VAR Format, ErrCode : Integer);
  FUNCTION Volume_Size : LongInt;
}

{ Disc Current Information }
  FUNCTION Sector_Size (ReadMode : Integer) : Word;

{ Digital Files CD's Command Rotines }

(*
Function CD_GetVol:Boolean;
Function CD_SetVol:Boolean;
*)
FUNCTION Head_Location (AddrMode : Byte) : LongInt;
(*
PROCEDURE Read_Drive_Bytes (VAR ReadBytes : DriveByteArray);
PROCEDURE Read_Long (TransAddr : Pointer; StartSec : LongInt);
PROCEDURE SeekSec (StartSec : LongInt);
PROCEDURE Dev_Close;
PROCEDURE Dev_Open;
PROCEDURE OutputFlush;
PROCEDURE Input_Flush;
FUNCTION UPC_Code : String;
*)
{$ENDIF}

{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }
IMPLEMENTATION

  Uses
    Dos,Math;

{      [ The following tables are from "Ralf's Brown Interrupt List" ]       }
{

[ I just copy here the most important tables, please check Ralf's Interrupt  ]
[ List for more informations and tables...                                   ]
}

TYPE

  Req_Hdr    = RECORD { This record is used when sending a request           }
                 Len     : Byte;  { Length of request header                 }
                 SubUnit : Byte;  { Subunit within device driver             }
                 Command : Byte;  { Command code                             }
                 Status  : Word;  { Status (filled in by device driver)      }
                 Reserved: ARRAY [1..8] OF Byte;
               END;
{
 Format of device driver request header:
Offset  Size    Description     (Table 2251)
 00h    BYTE    length of request header
 01h    BYTE    subunit within device driver
 02h    BYTE    command code (see #2249)
 03h    WORD    status (filled in by device driver) (see #2250)
---DOS---
 05h  4 BYTEs   reserved (unused in DOS 2.x and 3.x)
 09h    DWORD   (European MS-DOS 4.0 only) pointer to next request header
                                                                       in
                          device's request queue
                (other versions) reserved (unused in DOS 2.x and 3.x)
---STARLITE architecture---
 05h    DWORD   pointer to next request header
 09h  4 BYTEs   reserved
---command code 00h---
 0Dh    BYTE    (ret) number of units
 0Eh    DWORD   (call) pointer to DOS device helper function (see #2253)
                          (European MS-DOS 4.0 only)
                (call) pointer past end of memory available to driver (DOS
                                                                       5+)
                (ret) address of first free byte following driver
 12h    DWORD   (call) pointer to commandline arguments
                (ret) pointer to BPB array (block drivers) or
                          0000h:0000h (character drivers)
 16h    BYTE    (DOS 3.0+) drive number for first unit of block driver
                                                                 (0=A)
   ---European MS-DOS 4.0---
 17h    DWORD   pointer to function to save registers on stack
   ---DOS 5+ ---
 17h    WORD    (ret) error-message flag
                0001h MS-DOS should display error msg on init failure
---command code 01h---
 0Dh    BYTE    media descriptor
 0Eh    BYTE    (ret) media status
                00h don't know
                01h media has not changed
                FFh media has been changed
 0Fh    DWORD   (ret, DOS 3.0+) pointer to previous volume ID if the
                  OPEN/CLOSE/RM bit in device header is set and disk
                                                             changed
---command code 02h---
 0Dh    BYTE    media descriptor
 0Eh    DWORD   transfer address
                -> scratch sector if NON-IBM FORMAT bit in device header
                                                                     set
                -> first FAT sector otherwise
 12h    DWORD   pointer to BPB (set by driver) (see #1315 at
                                              INT 21/AH=53h)
---command codes 03h,0Ch---
                  (see also INT 21/AX=4402h"DOS 2+",
                               INT 21/AX=4403h"DOS")
 0Dh    BYTE    media descriptor (block devices only)
 0Eh    DWORD   transfer address
 12h    WORD    (call) number of bytes to read/write
                (ret) actual number of bytes read or written
---command codes 04h,08h,09h (except Compaq DOS 3.31, DR DOS 6)---
 0Dh    BYTE    media descriptor (block devices only)
 0Eh    DWORD   transfer address
 12h    WORD    byte count (character devices) or sector count (block
                                                             devices)
 14h    WORD    starting sector number (block devices only)
 16h    DWORD   (DOS 3.0+) pointer to volume ID if error 0Fh returned
 1Ah    DWORD   (DOS 4.0+) 32-bit starting sector number (block devices
                                                                   with
                  device attribute word bit 1 set only) if starting sector
                  number above is FFFFh (see INT 21/AH=52h)
---command codes 04h,08h,09h (Compaq DOS 3.31, DR DOS 6)---
 0Dh    BYTE    media descriptor (block devices only)
 0Eh    DWORD   transfer address
 12h    WORD    byte count (character devices) or sector count (block
                                                             devices)
 14h    DWORD   32-bit starting sector number (block devices only)
        Note:   to reliably determine which variant of the request block
                                                                     for
                  functions 04h,08h,09h has been passed to the driver,
                                                                 check
                  the length field as well as the word at offset 14h.  If
                                                                      the
                  length is 1Eh and 14h=FFFFh, use the DWORD at 1Ah as the
                  starting sector number; if the length is 18h, use the
                                                                  DWORD
                  at 14h; otherwise, use the WORD at 14h.
---command code 05h---
 0Dh    BYTE    byte read from device if BUSY bit clear on return
---command codes 06h,07h,0Ah,0Bh,0Dh,0Eh,0Fh---
 no further fields
---command code 10h---
 0Dh    BYTE    unused
 0Eh    DWORD   transfer address
 12h    WORD    (call) number of bytes to write
                (ret) actual number of bytes written
---command codes 11h,12h---
 0Dh    BYTE    reserved
---command code 15h---
 no further fields
---command codes 13h,19h---
 0Dh    BYTE    category code
                00h unknown
                01h COMn:
                03h CON
                05h LPTn:
                07h mouse (European MS-DOS 4.0)
                08h disk
                9Eh (STARLITE) Media Access Control driver
 0Eh    BYTE    function code
                00h (STARLITE) MAC Bind request
 0Fh    WORD    copy of DS at time of IOCTL call (apparently unused in DOS
                                                                      3.3)
                SI contents (European MS-DOS 4.0)
 11h    WORD    offset of device driver header (see #1298)
                DI contents (European MS-DOS 4.0)
 13h    DWORD   pointer to parameter block from INT 21/AX=440Ch or
                                                          AX=440Dh
---command codes 80h,82h---
 0Dh    BYTE    addressing mode
                00h HSG (default)
                01h Phillips/Sony Red Book
 0Eh    DWORD   transfer address (ignored for command 82h)
 12h    WORD    number of sectors to read
                (if 0 for command 82h, request is an advisory seek)
 14h    DWORD   starting sector number
                logical sector number in HSG mode
                frame/second/minute/unused in Red Book mode
                (HSG sector = minute * 4500 + second * 75 + frame - 150)
 18h    BYTE    data read mode
                00h cooked (2048 bytes per frame)
                01h raw (2352 bytes per frame, including EDC/ECC)
 19h    BYTE    interleave size (number of sectors stored consecutively)
 1Ah    BYTE    interleave skip factor
                (number of sectors between consecutive portions)
---command code 83h---
 0Dh    BYTE    addressing mode
                00h HSG (default)
                01h Phillips/Sony Red Book
 0Eh    DWORD   transfer address (ignored)
 12h    WORD    number of sectors to read (ignored)
 14h    DWORD   starting sector number (see also above)
---command code 84h---
 0Dh    BYTE    addressing mode
                00h HSG (default)
                01h Phillips/Sony Red Book
 0Eh    DWORD   starting sector number (see also above)
 12h    DWORD   number of sectors to play
---command codes 85h,88h---
 no further fields
---command codes 86h,87h---
 0Dh    BYTE    addressing mode
                00h HSG (default)
                01h Phillips/Sony Red Book
 0Eh    DWORD   transfer address (ignored in write mode 0)
 12h    WORD    number of sectors to write
 14h    DWORD   starting sector number (also see above)
 18h    BYTE    write mode
                00h mode 0 (write all zeros)
                01h mode 1 (default) (2048 bytes per sector)
                02h mode 2 form 1 (2048 bytes per sector)
                03h mode 2 form 2 (2336 bytes per sector)
 19h    BYTE    interleave size (number of sectors stored consecutively)
 1Ah    BYTE    interleave skip factor
                (number of sectors between consecutive portions)


(Table 2249)
Values for device driver command code:
 00h    INIT
 01h    MEDIA CHECK (block devices)
 02h    BUILD BPB (block devices)
 03h    IOCTL INPUT
 04h    INPUT
 05h    NONDESTRUCTIVE INPUT, NO WAIT (character devices)
 06h    INPUT STATUS (character devices)
 07h    INPUT FLUSH (character devices)
 08h    OUTPUT
 09h    OUTPUT WITH VERIFY
 0Ah    OUTPUT STATUS (character devices)
 0Bh    OUTPUT FLUSH (character devices)
 0Ch    IOCTL OUTPUT
 0Dh    (DOS 3.0+) DEVICE OPEN
 0Eh    (DOS 3.0+) DEVICE CLOSE
 0Fh    (DOS 3.0+) REMOVABLE MEDIA (block devices)
 10h    (DOS 3.0+) OUTPUT UNTIL BUSY (character devices)
 11h    (European MS-DOS 4.0) STOP OUTPUT (console screen drivers only)
 12h    (European MS-DOS 4.0) RESTART OUTPUT (console screen drivers only)
 13h    (DOS 3.2+) GENERIC IOCTL
 14h    unused
 15h    (European MS-DOS 4.0) RESET UNCERTAIN MEDIA FLAG
 16h    unused
 17h    (DOS 3.2+) GET LOGICAL DEVICE
 18h    (DOS 3.2+) SET LOGICAL DEVICE
 19h    (DOS 5.0+) CHECK GENERIC IOCTL SUPPORT
 80h    (CD-ROM) READ LONG
 81h    (CD-ROM) reserved
 82h    (CD-ROM) READ LONG PREFETCH
 83h    (CD-ROM) SEEK
 84h    (CD-ROM) PLAY AUDIO
 85h    (CD-ROM) STOP AUDIO
 86h    (CD-ROM) WRITE LONG
 87h    (CD-ROM) WRITE LONG VERIFY
 88h    (CD-ROM) RESUME AUDIO


 Bitfields for device request status:
Bit(s)  Description     (Table 2250)
 15     error
 14-11  reserved
 10     ??? set by DOS kernel on entry to some driver calls
 9      busy
 8      done (may be clear on return under European MS-DOS 4.0)
 7-0    error code if bit 15 set (see #2252)
}
  IOControlRec = RECORD { This is the Record used to make the IO Control     }
                   IOReq_Hdr : Req_Hdr;
                   MediaDesc : Byte;
                   TransAddr : Pointer;
                   NumBytes  : Word;
                   StartSec  : Word;
                   ReqVol    : Pointer;
                 END;

{$IFNDEF NoCDAudioSupport}
  AudioPlayRec = RECORD { This is used to acess all audio functions          }
                   APReq    : Req_Hdr;
                   AddrMode : Byte;
                   Start    : LongInt;
                   NumSecs  : LongInt;
                 END;
{$ENDIF}
{$IFNDEF NoDigitalCDSupport}
  ReadControlRec = RECORD
                     IOReq_Hdr : Req_Hdr;
                     AddrMode  : Byte;
                     TransAddr : Pointer;
                     NumSecs   : Word;
                     StartSec  : LongInt;
                     ReadMode  : Byte;
                     IL_Size,
                     IL_Skip   : Byte;
                   END;
{$ENDIF}

  PointerHalfRec = RECORD
                     LoHalf, HiHalf : Word;
                   END;

VAR
  Regs       : Registers;
  DriveBytes : ARRAY [0..129] OF Byte; { This record is used to acess to the }
{ IOCTL INPUT and OUTPUT. The DriveBytes[1] is always the IOCTL command, the }
{ following bytes are the data bytes.                                        }
  IOBlock    : IOControlRec;
{$IFNDEF NoCDAudioSupport}
  AudioPlay : AudioPlayRec;
{$ENDIF}
  Drive,
  SubUnit : Integer;
  Busy : Boolean;

{ ======================== Unit                  =========================== }
{ ========================      Internal         =========================== }
{ ========================               Rotines =========================== }
{                         ***********************                            }

{----------------------------------------------------------------------------}
{ PROCEDURE (Internal)                                                       }
{ ClearRegisters                                                             }
{         - Description : Clear the Regs array                               }
{         - Input       : ----                                               }
{         - Return      : ----                                               }
{----------------------------------------------------------------------------}
PROCEDURE ClearRegisters;

  Begin
    FillChar (Regs, SizeOf (Regs), #0);
  End; { Internal Rotine ClearRegisters }

{----------------------------------------------------------------------------}
{ PROCEDURE (Internal)                                                       }
{ CDDeviceRequest                                                            }
{         - Description : Send's a Device Driver Request                     }
{         - Input       : DevPointer --> Pointer to the Driver Request Record}
{         - Return      : ----                                               }
{----------------------------------------------------------------------------}
PROCEDURE CDDeviceRequest(DevPointer : Pointer);

  Begin
    ClearRegisters;
    Regs.AX := $1510;
    Regs.CX := Drive;
    Regs.ES := PointerHalfRec(DevPointer).HiHalf;
    Regs.BX := PointerHalfRec(DevPointer).LoHalf;
    Intr($2F,Regs);
  End; { CDDeviceRequest Internal Rotine }

{----------------------------------------------------------------------------}
{ PROCEDURE (Internal)                                                       }
{ IOControl                                                                  }
{         - Description : Send's a command to the IO Control                 }
{         - Input       : Command --> Command to execute                     }
{         - Return      : ----                                               }
{----------------------------------------------------------------------------}
PROCEDURE IOControl (Command : Byte);

  Begin
    IOBlock.IOReq_Hdr.Len := 26;
    IOBlock.IOReq_Hdr.SubUnit := SubUnit;
    IOBlock.IOReq_Hdr.Status := 0;
    IOBlock.TransAddr := @DriveBytes;
    IOBlock.IOReq_Hdr.Command := Command;
    FillChar(IOBlock.IOReq_Hdr.Reserved,8,#0);
    CDDeviceRequest(@IOBlock);
    Busy := (IOBlock.IOReq_Hdr.Status AND 512) <> 0;
  End; { IOControl Internal Rotine }

{$IFNDEF NoCDAudioSupport}
{----------------------------------------------------------------------------}
{ PROCEDURE (Internal)                                                       }
{ AudioTrackInfo                                                             }
{         - Description : Returns a track information                        }
{         - Input       : TrackControl --> Number of the track to check      }
{         - Return      : StartPoint and TrackControl                        }
{----------------------------------------------------------------------------}
PROCEDURE AudioTrackInfo(VAR StartPoint : LongInt; VAR TrackControl : Byte);
{ The "TrackControl" variavel is used to two diferent things, first is used  }
{ to call the track that we want to get information, in the return the       }
{ "TrackControl" returns the Track Control Information, see forward.         }
  Const
    IoCtlInput = $03;

  Begin
    FillChar(DriveBytes,SizeOf(DriveBytes),#0); { Clear "DriveBytes" record  }
    DriveBytes[0] := $0B; { Command "Audio Track Info" of the IOCTL INPUT    }
    DriveBytes[1] := TrackControl; { Track number                            }
    IOBlock.NumBytes := 7; { Command : 1 byte; Data Length : 6 bytes         }
{
    01h    BYTE    track number (set by caller)
    02h    DWORD   starting point of track (Red Book format)
    06h    BYTE    track control info
                   bits 15,14,12: track type (notice: bits not contiguous!)
                           000 two audio channels, no pre-emphasis
                           001 two audio channels with pre-emphasis
                           010 data track
                           100 four audio channels, no pre-emphasis
                           101 four audio channels with pre-emphasis
                           other reserved
                   bit 13: digital copy permitted
}
    IOControl(IOCtlInput); { Call the IOCTL INPUT                            }
    Move(DriveBytes[2], StartPoint, 4); { Copy the returned data in the      }
{ "DriveBytes" record to the "StartPoint" variavel                           }
    TrackControl := DriveBytes[6]; { Check the 6th byte in the "DriveBytes"  }
{ record, copying it to "TrackControl"                                       }
    AudioDiskInfo.Playing := Busy; { Is the CDROM Drive busy ?               }
  End; { Internal Rotine AudioTrackInfo }

{----------------------------------------------------------------------------}
{ PROCEDURE (Internal)                                                       }
{ Play                                                                       }
{         - Description : Plays a CD audio from a point to other             }
{         - Input       : StarLoc --> Starting location                      }
{                         NumSec --> Number of seconds to play               }
{         - Return      : Return TRUE if the command was sucessuful          }
{----------------------------------------------------------------------------}
FUNCTION Play (StartLoc, NumSec : LongInt) : Boolean;

  Const
    PlayCD = $84;

  Var
    AudioPlay : AudioPlayRec;

  Begin
    FillChar(AudioPlay, SizeOf(AudioPlayRec), #0); { Clear "AudioPlay" Record}
    AudioPlay.APReq.Command := PlayCD; { The command to Play                 }
    AudioPlay.APReq.Len := 22; { The length of the request data              }
    AudioPlay.APReq.SubUnit := SubUnit;
    AudioPlay.Start := StartLoc; { The starting location to play             }
    AudioPlay.NumSecs := NumSec; { Number of seconds to play                 }
    AudioPlay.AddrMode := 1; { Use addressing mode #1, this one it's on Red  }
{ Book format. The #0 addressing mode is made in HSG mode.                   }
    CDDeviceRequest(@AudioPlay); { Make the Device driver request using      }
{ "AudioPlay" record.                                                        }
    Play := ((AudioPlay.APReq.Status AND 32768) = 0); { Return if the command}
{ was sucessuful or not.                                                     }
  End; { Play Internal Rotine }
{$ENDIF}
             {----------------------------------------------------}
             {----------------------------------------------------}
             {------------ Rotines                      ----------}
             {------------         for all              ----------}
             {------------                 CD's Control ----------}
             {----------------------------------------------------}
             {----------------------------------------------------}

{ =================== Drive                             ==================== }
{ ===================       Status/Capabilities         ==================== }
{ ===================                           Rotines ==================== }
{                    ***********************************                     }

FUNCTION GetUPCCode : Longint;

CONST
  IoCtlInput = $03;

Var
  Temp : Longint;

BEGIN
  FillChar (DriveBytes, SizeOf (DriveBytes), #0);

  DriveBytes [0] := $0E;

  IOBlock. NumBytes := 11;

  IOControl (IOCtlInput);

  Move (DriveBytes [2], Temp, 7);
  GetUPCCode := Temp;
END;

FUNCTION MediaChanged : Boolean;

CONST
  IoCtlInput = $03;

VAR MedChng : Byte;

  {  1  :  Media not changed
  0  :  Don't Know
  -1  :  Media changed
  }
BEGIN
  FillChar (DriveBytes, SizeOf (DriveBytes), #0);

  DriveBytes [0] := 9;

  IOBlock. NumBytes := 2;

  IOControl (IOCtlInput);

  Move (DriveBytes [1], MedChng, 4);
  Inc (MedChng);
  CASE MedChng OF
    2    : MediaChanged := FALSE;
    1, 0  : MediaChanged := TRUE;
  END;
END;

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ MSCDEXInstalled                                                            }
{         - Description : Check if MSCDEX is installed and fill the CDROM    }
{                         record information                                 }
{         - Input       : ----                                               }
{         - Return      : 0 --> Not installed, OK to install                 }
{                         1 --> Not installed, not OK to install             }
{                         2 --> Lotus CD/Networker installed                 }
{                         3 --> MSCDEX installed                             }
{----------------------------------------------------------------------------}
FUNCTION MSCDEXInstalled : Byte;

  Var
    AL_Value : Byte;
    Stack_Value : Word;
    Version : Word;

  Begin
    FillChar(CDROMDrive, SizeOf(CDROMDrive), #0); { Clear "CDROMDrive" record}
    Asm
      MOV   AX,1100h         { Mscdex installation check                     }
      PUSH  SP               { Save stack                                    }
      PUSH  0DADAh           { Subfunction of installation check             }
      INT   2Fh              { Execute interrupt                             }
      POP   SP               { Restore interrupt                             }
      MOV   AL_Value, AL     { Keep AL value                                 }
      MOV   Stack_Value, SP  { Keep actual stack pointer                     }
    End;
    MSCDEXInstalled := AL_Value;
    IF AL_Value = $FF Then
      Begin
        IF Stack_Value = $DADB Then MSCDEXInstalled := 2
        Else MSCDEXInstalled := 3;
        Asm
          MOV   AX,150Ch                     { Version check function        }
          INT   2Fh                          { Execute interrupt             }
          MOV   Version,BX                   { Store version in memory       }
          MOV   AX,1500h                     { CD-ROM information function   }
          XOR   BX,BX                        { BX must be zero               }
          INT   2Fh                          { Execute interrupt             }
          MOV   CDROMDrive.NumCDDrv,BL       { Number of cd-rom drives on system }
          ADD   CL,'A'                       { Number to ascii letter        }
          MOV   CDROMDrive.FstCDDrv,CL       { 1st cd-rom drive letter       }
        End;
        ClearRegisters;
        Regs. AX := $1501;               { Get List of Driver Header Addresses }
        Regs. ES := Seg (CDROMDrive.DriverList);
        Regs. BX := Ofs (CDROMDrive.DriverList);
        Intr($2F,Regs);
        ClearRegisters;
        Regs. AX := $150D;               { Get List of CD-ROM Units }
        Regs. ES := Seg (CDROMDrive.UnitList);
        Regs. BX := Ofs (CDROMDrive.UnitList);
        Intr($2F,Regs);
        CDROMDrive.MSCDEXVersion.Major := Hi(Version);
        CDROMDrive.MSCDEXVersion.Minor := Lo(Version);
        Drive := ORD(CDROMDrive.FstCDDrv) - ORD('A');
        DeviceStatus;
      End;
  End; { MSCDEXInstalled }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ DeviceStatus                                                               }
{         - Description : Fill the device status record with the actual      }
{                         device status information                          }
{         - Input       : ----                                               }
{         - Return      : ----                                               }
{----------------------------------------------------------------------------}
PROCEDURE DeviceStatus;

  Const
    IoCtlInput = $03;

  Begin
    FillChar(DriveBytes, SizeOf(DriveBytes), #0); { Clear "DriveBytes" record}
    DriveBytes[0] := $06;  { Call "Device Status" command of the IOCTL INPUT }
    IOBlock.NumBytes := 5; { Command : 1 byte; Data Lenght : 4 bytes         }
{
    01h    DWORD   device parameters (see #1103)

      Bitfields for CD-ROM device parameters:
    Bit(s)  Description     (Table 1103)
    0      door open
    1      door unlocked
    2      supports raw reading in addition to cooked
    3      writable
    4      can play audio/video tracks
    5      supports interleaving
    6      reserved
    7      supports prefetch requests
    8      supports audio channel control
    9      supports Red Book addressing in addition to HSG
    10     audio is playing
    11     no disk in drive
    12     supports R-W subchannels
}

    IOControl(IOCtlInput); { Call the IOCTL INPUT                            }
{ Then start testing the specified bits of the returned data                 }
    CDROMDrive.DeviceParameters.DoorOpen := TestBit(0,DriveBytes[1],1);
    CDROMDrive.DeviceParameters.DoorUnLocked := TestBit(1,DriveBytes[1],1);
    CDROMDrive.DeviceParameters.RawReading := TestBit(2,DriveBytes[1],1);
    CDROMDrive.DeviceParameters.Writable := TestBit(3,DriveBytes[1],1);
    CDROMDrive.DeviceParameters.AudioVideoTracks := TestBit(4,DriveBytes[1],1);
    CDROMDrive.DeviceParameters.InterLeaving := TestBit(5,DriveBytes[1],1);
    CDROMDrive.DeviceParameters.Prefetch := TestBit(7,DriveBytes[1],1);
    CDROMDrive.DeviceParameters.AudioChannelControl := TestBit(0,DriveBytes[2],1);
    CDROMDrive.DeviceParameters.RedBookAddressing := TestBit(1,DriveBytes[2],1);
{ When I tested this unit I was unable to get a true identification if the   }
{ CD was playing or not playing with the next expression :                   }
{   CDROMDrive.DeviceParameters.Playing := TestBit(2,DriveBytes[3],1);       }
{ Anyway I found other way that return the true information.                 }
    CDROMDrive.DeviceParameters.NoDiscInDrive := TestBit(3,DriveBytes[2],1);
    CDROMDrive.DeviceParameters.RWSubChannels := TestBit(4,DriveBytes[2],1);
  End; { Device Status }

(*
FUNCTION File_Name (VAR Code : Integer) : String;
VAR
  FN : String [38];
BEGIN
  ClearRegisters;
  Regs. AL := Code + 1;
  {
  Copyright Filename     =  1
  Abstract Filename      =  2
  Bibliographic Filename =  3
  }
  Regs. CX := Drive;
  Regs. ES := Seg (FN);
  Regs. BX := Ofs (FN);
  CD_Intr;
  Code := Regs. AX;
  IF (Regs. Flags AND CarryFlag) = 0 THEN
    File_Name := FN
  ELSE
    File_Name := '';
END;

FUNCTION Read_VTOC (VAR VTOC : VTOCArray;
                   VAR Index : Integer) : Boolean;
{ On entry -
     Index = Vol Desc Number to read from 0 to ?
  On return
     Case Index of
            1    : Standard Volume Descriptor
            $FF  : Volume Descriptor Terminator
            0    : All others
}
BEGIN
  ClearRegisters;
  Regs. AL := $05;
  Regs. CX := Drive;
  Regs. DX := Index;
  Regs. ES := Seg (VTOC);
  Regs. BX := Ofs (VTOC);
  CD_Intr;
  Index := Regs. AX;
  IF (Regs. Flags AND CarryFlag) = 0 THEN
    Read_VTOC := TRUE
  ELSE
    Read_VTOC := FALSE;
END;
*)

{ ========================= CD-ROM                 ========================= }
{ =========================        Drive           ========================= }
{ =========================              Commands  ========================= }
{                          ************************                          }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ Eject                                                                      }
{         - Description : Opens the CDROM drive door                         }
{         - Input       : ----                                               }
{         - Return      : ----                                               }
{----------------------------------------------------------------------------}
PROCEDURE Eject;

  Const
    IOCtlOutput = $0C;

  Begin
    FillChar(DriveBytes, SizeOf(DriveBytes), #0); { Clear "DriveBytes" record}
    DriveBytes[0] := $00; { Command "Eject Disk" of the IOCTL OUTPUT         }
    IOBlock.NumBytes := 1; { Just one byte : Command byte                    }
    IOControl(IOCtlOutput); { Call IOCTL OUTPUT                              }
  End; { Eject }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ ResetCD                                                                    }
{         - Description : Resets the CDROM Drive                             }
{         - Input       : ----                                               }
{         - Return      : ----                                               }
{----------------------------------------------------------------------------}
PROCEDURE ResetCD;

  Const
    IOCtlOutput = $0C;

  Begin
    FillChar(DriveBytes, SizeOf(DriveBytes), #0); { Clear "DriveBytes" record}
    DriveBytes[0] := $02; { Command "Reset Drive" of the IOCTL OUTPUT        }
    IOBlock.NumBytes := 1; { Just one byte : command byte                    }
    IOControl(IOCtlOutput); { Call IOCTL OUTPUT                              }
    Busy := TRUE;
  End; { ResetCD }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ Lock                                                                       }
{         - Description : Locks/Unlocks the CDROM Drive door                 }
{         - Input       : LockDrive --> TRUE Locks the drive                 }
{                                       FALSE Unlocks the drive              }
{         - Return      : ----                                               }
{----------------------------------------------------------------------------}
PROCEDURE Lock(LockDrive : Boolean);

  Const
    IOCtlOutput = $0C;

  Begin
    FillChar(DriveBytes, SizeOf(DriveBytes), #0); { Clear "DriveBytes" record}
    DriveBytes[0] := $01; { Command "Lock/Unlock door" of the IOCTL OUTPUT   }
    IF LockDrive Then DriveBytes[1] := 1 { Value #1 locks the door           }
    Else DriveBytes[1] := 0; { Value #0 unlocks the door                     }
    IOBlock.NumBytes := 2; { Command : 1 byte; Data : 1 byte                 }
{
    01h    BYTE    lock function
                   00h unlock door
                   01h lock door
}
    IOControl(IOCtlOutput); { Call IOCTL OUTPUT                              }
  End; { Lock }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ CloseTray                                                                  }
{         - Description : Close the CDROM Drive door                         }
{         - Input       : ----                                               }
{         - Return      : ----                                               }
{----------------------------------------------------------------------------}
PROCEDURE CloseTray;

  Const
    IOCtlOutput = $0C;

  Begin
    FillChar(DriveBytes, SizeOf(DriveBytes), #0); { Clear "DriveBytes" record}
    DriveBytes[0] := $05; { Command "Close Tray" of the IOCTL OUTPUT         }
    IOBlock.NumBytes := 1; { Just one byte : command byte                    }
    IOControl(IOCtlOutput); { Call IOCTL OUTPUT                              }
  End; { CloseTray }

{$IFNDEF NoCDAudioSupport}
             {------------------------------------------------}
             {------------------------------------------------}
             {----- Rotines                             ------}
             {-----         only for                    ------}
             {-----                  Audio CD's Control ------}
             {------------------------------------------------}
             {------------------------------------------------}

{ =================== Drive                             ==================== }
{ ===================       Status/Capabilities         ==================== }
{ ===================                           Rotines ==================== }
{                    ***********************************                     }
(*
PROCEDURE Vol_Desc (VAR Code : Integer;
                   VAR ErrCode : Integer);

  FUNCTION Get_Vol_Desc : Byte;
    BEGIN
      ClearRegisters;
      Regs. CX := Drive;
      Regs. AL := $0E;
      Regs. BX := $0000;
      CD_Intr;
      Code := Regs. AX;
      IF (Regs. Flags AND CarryFlag) <> 0 THEN
        ErrCode := $FF;
      Get_Vol_Desc := Regs. DH;
    END;

BEGIN
  ClearRegisters;
  ErrCode := 0;
  IF Code <> 0 THEN
  BEGIN
    Regs. DH := Code;
    Regs. DL := 0;
    Regs. BX := $0001;
    Regs. AL := $0E;
    Regs. CX := Drive;
    CD_Intr;
    Code := Regs. AX;
    IF (Regs. Flags AND CarryFlag) <> 0 THEN
      ErrCode := $FF;
  END;
  IF ErrCode = 0 THEN
    Code := Get_Vol_Desc;
END;
*)

{ ==================== Disc/Audio                      ===================== }
{ ====================            Current              ===================== }
{ ====================                    Information  ===================== }
{                     *********************************                      }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ AudioChannelInfo                                                           }
{         - Description : Gets the audio channel information                 }
{         - Input       : ----                                               }
{         - Return      : ----                                               }
{----------------------------------------------------------------------------}
PROCEDURE AudioChannelInfo;

  Const
    IoCtlInput = $03;

  Begin
    FillChar(DriveBytes, SizeOf(DriveBytes), #0); { Clear "DriveBytes" record}
    DriveBytes[0] := $04; { Command "Audio Channel Info" of the IOCTL INPUT  }
    IOBlock.NumBytes := 9; { Command : 1 byte; Data : 8 bytes                }
{
    01h    BYTE    input channel (0-3) for output channel 0
    02h    BYTE    volume for output channel 0
    03h    BYTE    input channel (0-3) for output channel 1
    04h    BYTE    volume for output channel 1
    05h    BYTE    input channel (0-3) for output channel 2
    06h    BYTE    volume for output channel 2
    07h    BYTE    input channel (0-3) for output channel 3
    08h    BYTE    volume for output channel 3
  Notes : Output channels 0 and 1 are left and right, 2 and 3 are left prime
         and right prime; a volume of 00h is off.
          The default setting is for each input channel to be assigned to the
         same-numbered output channel at full (FFh) volume.
}
    IOControl(IOCtlInput); { Call IOCTL INPUT                                }
    Move(DriveBytes[1], AudioChannel, 8);{ Copy data returned to "AudioChannel}
  End; { AudioChannelInfo }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ CDAudioDiskInfo                                                            }
{         - Description : Gets CD Audio Disk information                     }
{         - Input       : ----                                               }
{         - Return      : ----                                               }
{----------------------------------------------------------------------------}
PROCEDURE CDAudioDiskInfo;

  Const
    IoCtlInput = $03;

  Begin
    FillChar(DriveBytes, SizeOf(DriveBytes), #0); { Clear "DriveBytes" record}
    DriveBytes[0] := $0A; { Command "Audio Disk Info" of the IOCTL INPUT     }
    IOBlock.NumBytes := 7; { Command : 1 byte; Data : 6 bytes                }
{
    01h    BYTE    lowest audio track number
    02h    BYTE    highest audio track number
    03h    DWORD   start address of lead-out track (Red Book format)
}
    IOControl (IOCtlInput); { Call IOCTL INPUT                               }
    Move(DriveBytes[1], AudioDiskInfo, 6); { Copy returned data to "AudioDiskInfo" record }
    AudioDiskInfo.Playing := Busy; { Check if it is busy or not              }
  End; { CDAudioDiskInfo }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ CDQChannelInfo                                                             }
{         - Description : Gets actual playing information                    }
{         - Input       : ----                                               }
{         - Return      : ----                                               }
{----------------------------------------------------------------------------}
PROCEDURE CDQChannelInfo;

  Const
    IoCtlInput = $03;

  Begin
    IF AudioDiskInfo.Playing AND (Not AudioDiskInfo.Paused) Then
      Begin
        FillChar(DriveBytes, SizeOf(DriveBytes), #0); { Clear "DriveBytes" record }
        DriveBytes[0] := $0C; { Command "Audio Q-Channel Info" of the IOCTL INPUT }
        IOBlock.NumBytes := 11; { Command : 1 byte; Data : 10 bytes               }
{
        01h    BYTE    CONTROL and ADR byte (as received from drive)
        02h    BYTE    track number
        03h    BYTE    point or index
        04h    BYTE    minute  \
        05h    BYTE    second   > running time within track
        06h    BYTE    frame   /
        07h    BYTE    zero
        08h    BYTE    "AMIN" or "PMIN"     \
        09h    BYTE    "ASEC" or "PSEC"      > running time on disk
        0Ah    BYTE    "AFRAME" or "PFRAME" /
}
        IOControl(IOCtlInput); { Call IOCTL INPUT                                 }
        Move(DriveBytes[1], QChannelInfo, 10); { Copy returned data to "QChannelInfo" record }
        IF QChannelInfo.Track >= 10 Then QChannelInfo.Track := QChannelInfo.Track - 6;
      End;
  End; { CDQChannelInfo }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ CDAudioStatusInfo                                                          }
{         - Description : Gets actual playing information                    }
{         - Input       : ----                                               }
{         - Return      : ----                                               }
{----------------------------------------------------------------------------}
PROCEDURE CDAudioStatusInfo;

  Const
    IoCtlInput = $03;

  Begin
    IF AudioDiskInfo.Playing Then
      Begin
        FillChar(DriveBytes, SizeOf(DriveBytes), #0); { Clear "DriveBytes" record }
        DriveBytes[0] := $0F; { Command "Audio Status Info" of the IOCTL INPUT    }
        IOBlock.NumBytes := 11; { Command : 1 byte; Data : 10 bytes               }
{
        ??? documentation not yet available
        01h    WORD    pause status (0000h not paused, 0001h paused)
        03h    DWORD   audio play start address
        07h    DWORD   ??? audio play length or end address
}
        IOControl(IOCtlInput); { Call IOCTL INPUT                                 }
        AudioDiskInfo.Paused := TestBit(0,DriveBytes[1],1); { Check if it's paused }


        Move(DriveBytes[3], Last_Start, 4); { Copy specified values                }
        Move(DriveBytes[7], Last_End, 4);


        AudioDiskInfo.Playing := Busy;
     End;
  End; { CDAudioStatusInfo }

PROCEDURE CreateTracksRecord;

  Var
    I            : Integer;
    SP,
    EP           : LongInt;
    LeadOut,
    StartP : LongInt;
    Track        : Byte;
    StartTrack,
    EndTrack,
    NumTracks    : Integer;

  Begin
  CDAudioDiskInfo;
  LeadOut := AudioDiskInfo. LeadOutTrack;
  StartTrack := AudioDiskInfo. LowestTrack;
  EndTrack := AudioDiskInfo. HighestTrack;
  NumTracks := EndTrack - StartTrack + 1;
  For I := StartTrack To EndTrack Do
  Begin
    Track := I;
    New (TrackInfo [I] );
    FillChar (TrackInfo [I]^, SizeOf (TrackInfo [I]^), #0);
    TrackInfo [I]^. Track := Track;
    AudioTrackInfo(StartP, Track);
    TrackInfo[I]^. StartPoint := StartP;
    TrackInfo[I]^. TrackControlInfo := Track;
  End;

  For I := StartTrack To EndTrack - 1 Do
    TrackInfo [I]^. EndPoint := TrackInfo [I + 1]^. StartPoint - 1;

  TrackInfo [EndTrack]^. EndPoint := AudioDiskInfo. LeadOutTrack - 1;

  For I := StartTrack To EndTrack Do
    Move (TrackInfo [I]^. EndPoint, TrackInfo [I]^. DFrames, 4);

  TrackInfo [StartTrack]^. TMin := TrackInfo [StartTrack]^. DMinutes;
  TrackInfo [StartTrack]^. TSec := TrackInfo [StartTrack]^. DSeconds - 2;

  For I := StartTrack + 1 To EndTrack Do
  Begin
    EP := (TrackInfo [I]^. DMinutes * 60) + TrackInfo [I]^. DSeconds;
    SP := (TrackInfo [I - 1]^. DMinutes * 60) + TrackInfo [I - 1]^. DSeconds;
    EP := EP - SP;
    TrackInfo [I]^. TMin := EP Div 60;
    TrackInfo [I]^. TSec := EP Mod 60;
  End;
 End;

{ ======================= Audio CD's                 ======================= }
{ =======================            Command         ======================= }
{ =======================                    Rotines ======================= }
{                        ****************************                        }

PROCEDURE Play_Audio (StartSec, EndSec : LongInt);
VAR
  SP,
  EP     : LongInt;
  SArray : ARRAY [1..4] OF Byte;
  EArray : ARRAY [1..4] OF Byte;
BEGIN
  Move (StartSec, SArray [1], 4);
  Move (EndSec, EArray [1], 4);
  SP := SArray [3];           { Must use longint or get negative result }
  SP := (SP * 75 * 60) + (SArray [2] * 75) + SArray [1];
  EP := EArray [3];
  EP := (EP * 75 * 60) + (EArray [2] * 75) + EArray [1];
  EP := EP - SP;

  CDAudioStatusInfo;
  AudioDiskInfo.Playing := Play (StartSec, EP);
END;

PROCEDURE Pause_Audio;

CONST
  StopPlay   = 133;

BEGIN
  IF AudioDiskInfo.Playing AND (Not AudioDiskInfo.Paused) THEN
  BEGIN
    FillChar (AudioPlay, SizeOf (AudioPlay), #0);
    AudioPlay. APReq. Command := stopplay; {stopplay}
    AudioPlay. APReq. Len := 13;
    AudioPlay. APReq. SubUnit := SubUnit;
    CDDeviceRequest (@AudioPlay);
    CDAudioStatusInfo;
    AudioDiskInfo.Playing := FALSE;
    AudioDiskInfo.Paused := TRUE;
  END;
END;

PROCEDURE Resume_Play;

CONST
  ResumePlay = 136;

BEGIN
  IF AudioDiskInfo.Paused Then
    Begin
      FillChar (AudioPlay, SizeOf (AudioPlay), #0);
      AudioPlay. APReq. Command := ResumePlay;
      AudioPlay. APReq. Len := 13;
      AudioPlay. APReq. SubUnit := SubUnit;
      CDDeviceRequest (@AudioPlay);
      CDAudioStatusInfo;
      AudioDiskInfo.Playing := TRUE;
      AudioDiskInfo.Paused := FALSE;
    End;
END;

PROCEDURE Stop_Play;

CONST
  StopPlay   = 133;

  Begin
  FillChar (AudioPlay, SizeOf (AudioPlay), #0);
  AudioPlay. APReq. Command := StopPlay;
  AudioPlay. APReq. Len := 13;
  AudioPlay. APReq. SubUnit := SubUnit;
  CDDeviceRequest (@AudioPlay);
  CDDeviceRequest (@AudioPlay);
  CDAudioStatusInfo;
  AudioDiskInfo.Playing := FALSE;
  AudioDiskInfo.Paused := FALSE;
  End;

PROCEDURE PlayTrack(Track : Byte);

  Begin
    Play_Audio(trackinfo [Track]^. startpoint,trackinfo [Track]^. endpoint);
  End;

{$ENDIF}

{$IFNDEF NoDigitalCDSupport}
        {--------------------------------------------------------}
        {--------------------------------------------------------}
        {----- Rotines only                                ------}
        {-----              for                            ------}
        {-----                  Digital Files CD's Control ------}
        {--------------------------------------------------------}
        {--------------------------------------------------------}

{ =================== Drive                             ==================== }
{ ===================       Status/Capabilities         ==================== }
{ ===================                           Rotines ==================== }
{                    ***********************************                     }
(*
PROCEDURE Get_Dir_Entry (PathName : String;
                        VAR Format, ErrCode : Integer);
BEGIN
  FillChar (DirBuf, SizeOf (DirBuf), #0);
  PathName := PathName + #0;
  ClearRegisters;
  Regs. AL := $0F;
  Regs. CL := Drive;
  Regs. CH := 1;
  Regs. ES := Seg (PathName);
  Regs. BX := Ofs (PathName);
  Regs. SI := Seg (DirBuf);
  Regs. DI := Ofs (DirBuf);
  CD_Intr;
  ErrCode := Regs. AX;
  IF (Regs. Flags AND CarryFlag) = 0 THEN
  BEGIN
    Move (DirBuf. NameArray [1], DirBuf. FileName [1], 38);
    DirBuf. FileName [0] := #12; { File names are only 8.3 }
    Format := Regs. AX
  END
  ELSE
    Format := $FF;
END;

FUNCTION Volume_Size : LongInt;
VAR VolSize : LongInt;
BEGIN
  FillChar (DriveBytes, SizeOf (DriveBytes), #0);

  DriveBytes [1] := 8;

  IOBlock. NumBytes := 5;

  IOControl (IOCtlInput);

  Move (DriveBytes [2], VolSize, 4);
  Volume_Size := VolSize;
END;
PROCEDURE Get_Dir_Entry (PathName : String;
                        VAR Format, ErrCode : Integer);
BEGIN
  FillChar (DirBuf, SizeOf (DirBuf), #0);
  PathName := PathName + #0;
  ClearRegisters;
  Regs. AL := $0F;
  Regs. CL := Drive;
  Regs. CH := 1;
  Regs. ES := Seg (PathName);
  Regs. BX := Ofs (PathName);
  Regs. SI := Seg (DirBuf);
  Regs. DI := Ofs (DirBuf);
  CD_Intr;
  ErrCode := Regs. AX;
  IF (Regs. Flags AND CarryFlag) = 0 THEN
  BEGIN
    Move (DirBuf. NameArray [1], DirBuf. FileName [1], 38);
    DirBuf. FileName [0] := #12; { File names are only 8.3 }
    Format := Regs. AX
  END
  ELSE
    Format := $FF;
END;

FUNCTION Volume_Size : LongInt;
VAR VolSize : LongInt;
BEGIN
  FillChar (DriveBytes, SizeOf (DriveBytes), #0);

  DriveBytes [1] := 8;

  IOBlock. NumBytes := 5;

  IOControl (IOCtlInput);

  Move (DriveBytes [2], VolSize, 4);
  Volume_Size := VolSize;
END;
*)

{ ======================= Disc                     ========================= }
{ =======================      Current             ========================= }
{ =======================              Information ========================= }
{                        **************************                          }

FUNCTION Sector_Size (ReadMode : Integer) : Word;

CONST
  IoCtlInput = 3;

VAR SecSize : Word;
BEGIN
  FillChar (DriveBytes, SizeOf (DriveBytes), #0);

  DriveBytes [0] := 7;
  DriveBytes [1] := ReadMode;

  IOBlock. NumBytes := 4;

  IOControl (IOCtlInput);

  Move (DriveBytes [2], SecSize, 2);
  Sector_Size := SecSize;
END;

(*
Function CD_GetVol:Boolean;
begin
  CtlBlk[0] := 4;                           { die Lautstaerke lesen }
  CD_GetVol := CD_IOCtl(IoCtlRead, 8);
  if ((R.Flags and FCARRY) = 0)
   then Move(CtlBlk[1], CD.VolInfo, 8)
   else FillChar( CD.VolInfo, 8, 0)
end;

Function CD_SetVol:Boolean;
begin
  CtlBlk[0] := 3;                          { die Lautstaerke setzen }
  CD_SetVol := CD_IOCtl( IoCtlWrite, 8);
end;

*)
FUNCTION Head_Location (AddrMode : Byte) : LongInt;

CONST
  IoCtlInput = 3;

VAR
  HeadLoc : LongInt;
BEGIN
  FillChar (DriveBytes, SizeOf (DriveBytes), #0);

  DriveBytes [0] := 1;
  DriveBytes [1] := AddrMode;

  IOBlock. NumBytes := 6;

  IOControl (IOCtlInput);

  Move (DriveBytes [2], HeadLoc, 4);
  Head_Location := HeadLoc;
END;
(*
PROCEDURE Read_Drive_Bytes (VAR ReadBytes : DriveByteArray);
BEGIN
  FillChar (DriveBytes, SizeOf (DriveBytes), #0);

  DriveBytes [1] := 5;

  IOBlock. NumBytes := 130;

  IOControl (IOCtlInput);

  Move (DriveBytes [3], ReadBytes, 128);
END;


FUNCTION UPC_Code : String;
VAR
  I, J, K : Integer;
  TempStr : String;
BEGIN
  FillChar (DriveBytes, SizeOf (DriveBytes), #0);
  TempStr := '';
  DriveBytes [1] := 14;

  IOBlock. NumBytes := 11;

  IOControl (IOCtlInput);

  IF ( (IOBlock. IOReq_Hdr. Status AND 32768) = 0) THEN;
  FOR I := 3 TO 9 DO
  BEGIN
    J := DriveBytes [I] AND $0F;
    K := DriveBytes [I] AND $F0;
    TempStr := TempStr + Chr (J + 48);
    TempStr := TempStr + Chr (K + 48);
  END;
  IF Length (TempStr) > 13 THEN
    TempStr [0] := Chr (Ord (TempStr [0] ) - 1);
  UPC_Code := TempStr;
END;


PROCEDURE Read_Long (TransAddr : Pointer; StartSec : LongInt);
VAR
  RL : ReadControl;
  {
  ReadControl = Record
  IOReq_Hdr : Req_Hdr;
  AddrMode  : Byte;
  TransAddr : Pointer;
  NumSecs   : Word;
  StartSec  : LongInt;
  ReadMode  : Byte;
  IL_Size,
  IL_Skip   : Byte;
  End;
  }
BEGIN
  FillChar (RL, SizeOf (RL), #0);
  RL. IOReq_Hdr. Len := 27;
  RL. IOReq_Hdr. SubUnit := SubUnit;
  RL. IOReq_Hdr. Command := ReadLong;
  RL. AddrMode := 1;
  RL. TransAddr := TransAddr;
  RL. NumSecs := 1;
  RL. StartSec := StartSec;
  RL. ReadMode := 0;
  CDDeviceRequest (@RL);
END;

PROCEDURE SeekSec (StartSec : LongInt);
VAR
  RL : ReadControl;

BEGIN
  FillChar (RL, SizeOf (RL), #0);
  RL. IOReq_Hdr. Len := 24;
  RL. IOReq_Hdr. SubUnit := SubUnit;
  RL. IOReq_Hdr. Command := SeekCmd;
  RL. AddrMode := 1;
  RL. StartSec := StartSec;
  RL. ReadMode := 0;
  CDDeviceRequest (@RL);
END;

PROCEDURE Input_Flush;
VAR
  IOReq : Req_Hdr;
BEGIN
  FillChar (IOReq, SizeOf (IOReq), #0);
  WITH IOReq DO
  BEGIN
    Len     := 13;
    SubUnit := SubUnit;
    Command := 7;
    Status  := 0;
  END;
  CDDeviceRequest (@IOReq);
END;

PROCEDURE OutputFlush;
VAR
  IOReq : Req_Hdr;
BEGIN
  FillChar (IOReq, SizeOf (IOReq), #0);
  WITH IOReq DO
  BEGIN
    Len     := 13;
    SubUnit := SubUnit;
    Command := 11;
    Status  := 0;
  END;
  CDDeviceRequest (@IOReq);
END;

PROCEDURE Dev_Open;
VAR
  IOReq : Req_Hdr;
BEGIN
  FillChar (IOReq, SizeOf (IOReq), #0);
  WITH IOReq DO
  BEGIN
    Len     := 13;
    SubUnit := SubUnit;
    Command := 13;
    Status  := 0;
  END;
  CDDeviceRequest (@IOReq);
END;

PROCEDURE Dev_Close;
VAR
  IOReq : Req_Hdr;
BEGIN
  FillChar (IOReq, SizeOf (IOReq), #0);
  WITH IOReq DO
  BEGIN
    Len     := 13;
    SubUnit := SubUnit;
    Command := 14;
    Status  := 0;
  END;
  CDDeviceRequest (@IOReq);
END;

 Main, issued automaticly at unit's startup:
*)
{$ENDIF}
begin
  FillChar (CDROMDrive, SizeOf (CDROMDriveRec), #0);
  MSCDEXInstalled;
end.


{ Well, for now the only thing I have to do is write the list of the guys and}
{ places I look to write this unit. In each unit is the list of the people   }
{ that made the original sources where I look to make the respective unit.   }
{ So, to this unit I read the next people sources and books:                 }

{ From SWAG:                                                                 }
{           - SwagTeam                                                       }
{
I'd like to CONTRIBUTE my own source code of a fully-FUNCTIONal, very
loaded, very FAST (Turbo Pascal's built-in assembler with my unique
techniques to speed up the code), yet very tiny!!! (8192bytes after
compilation), Enhanced CD-ROM AUDIO CONTROL unit.
+The code DOES contain DOZENS of comments, and very good ones indeed!
+The code DOES apply to the common programming rules of formatting.
-The code does NOT contain huge objects/arrays/pointers/heaps/etc...
-The code does NOT contain certain MSCDEX commands known to be
unFUNCTIONal, such as "Get UPC/EAN Stamp", etc...
=====
(*
        unit: Enhanced CD-ROM Audio control unit.
  code: Variane (Yuval Melamed), Israel, 1996.
        base: Ralf Brown's Interrupt List 48.
        date: 5/3/1996, 00:05.
*)
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
