                                                                               (*
                _--_                                     _--_
              /#()# #\         0             0         /# #()#\
              |()##  \#\_       \           /       _/#/  ##()|
              |#()##-=###\_      \         /      _/###=-##()#|
               \#()#-=##  #\_     \       /     _/#  ##=-#()#/
                |#()#--==### \_    \     /    _/ ###==--#()#|
                |#()##--=#    #\_   \!!!/   _/#    #=--##()#|
                 \#()##---===####\   O|O   /####===---##()#/
                  |#()#____==#####\ / Y \ /#####==____#()#|
                   \###______######|\/#\/|######______###/
                      ()#O#/      ##\_#_/##      \#O#()
                     ()#O#(__-===###/ _ \###===-__)#O#()
                    ()#O#(   #  ###_(_|_)_###  #   )#O#()
                    ()#O(---#__###/ (_|_) \###__#---)O#()
                    ()#O#( / / ##/  (_|_)  \## \ \ )#O#()
                    ()##O#\_/  #/   (_|_)   \#  \_/#O##()
                     \)##OO#\ -)    (_|_)    (- /#OO##(/
                      )//##OOO*|    / | \    |*OOO##\\(
                      |/_####_/    ( /X\ )    \_####_\|
                     /X/ \__/       \___/       \__/ \X\
                    (#/                               \#)

[ So, do you like this butterfly ? This butterfly is so beautiful as this    ]
[ unit! Yes, a unit that will put on the screen everything you want! This    ]
[ is from vlinders@rcl.wau.nl (Meindert de Jong <^_^>). I think I have to    ]
[ tell you the true. Yes, I get all ASCII art from a file in a College FTP   ]
[ server, and that file has the indication of who sent the picture. But who  ]
[ send the picture, that doesn't mean that he made the picture! So, if anyone]
[ as good ASCII art, please, ALWAYS put your name in it! How? do you ask!    ]
[ In the end of it, of course that there are always some stupid and covetous ]
[ people that probably will clear your name and put their, but fortunally,   ]
[ there are good people (like me) that will keep your name intact!!!!        ]
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
Unit Screen;

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE

  Type
    PCharShape = ^TCharShape;            { Pointer to the caracter array    }
    TCharShape = Array[0..15] OF Byte;   { The array of the caracter        }
    FontBlock    = 0..7;
    ScreenBuff= Array [1..4000] OF Byte; { The array that will contain the  }
                                         { screen data                      }
    ScreenPtr = ^ScreenRec ;  { Pointer to the Screen Record                }
    ScreenRec = Record        { Screen Record containing :                  }
                  Id          :  LongInt;    { The identification,          }
                  X1,Y1,X2,Y2 :  Byte;       { The Window coordenates       }
                  HoldScreen  :  ScreenBuff; { The Screen Data and          }
                  Next        :  ScreenPtr;  { the pointer to the next reg  }
                End;

  Const
    Blink = 128; { The blink value }

  Var
    CheckSnow : Boolean; { CheckSnow variable }
    BkColor   : Byte;    { When you choose to write in the screen a string, }
                         { with the "write" rotine, you should put a        }
                         { background value in this variable, that will be  }
                         { used. Check the rotine "write" for more info.    }
    Error    : Byte;     { When you try to save another screen, if there is }
                         { no more memory available, this variable set TRUE }
                         { This is usefull, because you can know if any     }
                         { error happened, but the program execution is not }
                         { interrupted by the rotine                        }

{ -_-_-_-_-_-_-_-_-_-_-_-_-_-_ Public rotines -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-}

{ Screen Writing rotines }
  PROCEDURE ChangeAttrib(X1,Y1,X2,Y2, NewB,NewF : Byte);
  PROCEDURE ClearText(X1,Y1,X2,Y2, F,B : Byte; Ch : Char);
  PROCEDURE ClrScr;
  PROCEDURE FastWrite(Col, Row, Attr : Byte; Str : String);
  PROCEDURE Horizontal(X1,X2,Y, FColor,BColor : Byte; Ch : Char);
  PROCEDURE SetBlinkBit(OffOn : Boolean);
  PROCEDURE Vertical(Y1,Y2,X, FColor, BColor : Byte; Ch : Char);
  PROCEDURE Write(Col, Row, FColor : Byte; Str : String);
  PROCEDURE WriteCenterText(Col, Row, FColor : Byte; Str : String);
  FUNCTION  Attribute(F,B : Byte) : Byte;
  FUNCTION  GetCharAttribXY(X, Y : Byte) : Word;

{ Cursor Handling }
  PROCEDURE GotoXY(X,Y : Byte);
  PROCEDURE CursorOn(On : Boolean);
  PROCEDURE CursorType(Size: Byte);
  FUNCTION  CursorIsOn : Boolean;
  FUNCTION  WhereX : Byte;
  FUNCTION  WhereY : Byte;

{ Font manipulation }
  PROCEDURE InstallBiosFont;
  PROCEDURE ReplaceChar(Code : Byte; NewChar : PCharShape);

{ Box creation }
  PROCEDURE Shadow(X1,Y1,X2,Y2 : Byte);
  PROCEDURE Box(X1,Y1,X2,Y2, F,B,LineType : Byte; PutName : Boolean; Name : String);

{ Save Screen rotines }
  PROCEDURE ReleasePages(Var WhatGroup : ScreenPtr);
  PROCEDURE RestorePage(Var WhatGroup : ScreenPtr; Identifier : Longint);
  PROCEDURE StorePage(Var WhatGroup : ScreenPtr; TopX,TopY,DownX,DownY : Byte; Identifier : Longint);
  FUNCTION  InitPages(Var WhatGroup : ScreenPtr; Number : Longint) : Boolean;

{ Fade and Palette control }
  PROCEDURE FadeIn(Duration : Byte);
  PROCEDURE FadeOut(Duration : Byte);
  PROCEDURE InitCol;
  PROCEDURE SetBrightness(Brightness : Byte);

{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }
IMPLEMENTATION

  Uses
    Dos,Crt,StrsUse,HardWare;

  type
    TRGB = Record
             R,
             G,
             B : Byte
           End;

  Const
    Bios000 : TCharShape = (000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000); {   }
    Bios001 : TCharShape = (000,000,126,129,165,129,129,189,153,129,129,126,000,000,000,000); {   }
    Bios002 : TCharShape = (000,000,126,255,219,255,255,195,231,255,255,126,000,000,000,000); {  }
    Bios003 : TCharShape = (000,000,000,000,108,254,254,254,124,056,016,000,000,000,000,000); {   }
    Bios004 : TCharShape = (000,000,000,000,016,056,124,254,056,016,000,000,000,000,000,000); {   }
    Bios005 : TCharShape = (000,000,000,024,060,060,231,231,231,024,024,060,000,000,000,000); {   }
    Bios006 : TCharShape = (000,000,000,024,060,126,255,255,126,024,024,060,000,000,000,000); {   }
    Bios007 : TCharShape = (000,000,000,000,000,000,024,060,060,024,000,000,000,000,000,000); {   }
    Bios008 : TCharShape = (255,255,255,255,255,255,231,195,195,231,255,255,255,255,255,255); {   }
    Bios009 : TCharShape = (000,000,000,000,000,060,102,066,066,102,060,000,000,000,000,000); {   }
    Bios010 : TCharShape = (255,255,255,255,255,195,153,189,189,153,195,255,255,255,255,255); {   }
    Newscreen : Boolean  =  True; { Value to check while saving a screen if  }
                                  { it will be a new screen or not           }
    PelIdxR  = $3C7; { Port to read from }
    PelIdxW  = $3C8; { Port to write to }
    PelData  = $3C9; { Dataport }
    Maxreg   = 63;   { Set to 255 for graphmode }
    MaxInten = 63;

  Var
    VideoSeg : Word;  { This will keep the value of memory where the screen  }
                      { "begins"                                             }
    PagesInitiated : Boolean;
    Col : Array [0..MaxReg] OF TRGB; { This is used to control the palette   }

{$IFNDEF NoInternalChecking}
{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ DisplayError ( Unit Internal Rotine )                                      }
{              - Description : Write in the screen the error description     }
{              - Input       : No --> The number of the error                }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
{ This will write in the screen ONLY programming errors, this will not make  }
{ any interference while running the program! This is like a litle checking  }
{ rotine. By default it is enable, but when you finish your program you can  }
{ disable it. To do that you have to define "NoInternalChecking". If you     }
{ don't know what DEFINE is I'll explain it for you. OK, this is very simple,}
{ and if I'm wrong I ask to the BIG experts in the matter to correct me. When}
{ you define a constant, you can do boolean or algebrical operations with it.}
{ So, when you define someting, you can also do bollean evaluations with the }
{ defined expression, the only diference is that this define and the         }
{ evaluating operations will be extremely fast under the compiling execution }
{ and not over the program execution. Is like a compiling option!!!          }
{ So, resuming, the only thing you have to do is: If you don't want that the }
{ source make self check for you, you need to set in the menu                }
{ command ALT+O+C+N                                                          }
{ That is, in the Conditional Defines: NoInternalChecking. Else, if you want }
{ that the source check the source, you don't have to do anything, that is   }
{ you don't have to define "NoInternalChecking".                             }
{ Did you understand? If not, you have just to read some books about         }
{ conditional operations!!! :)  Check Borland Pascal(TM) help                }
{ Off course and as always there are some other ways to do what we want!     }
{ And what I really wanted was to make a simple way to define some           }
{ condtionals in a program that would be used in ALL units, but if we define }
{ a conditional in a program it will not be used in the units used by the    }
{ program. So I created a include file called "Defines.INC" that it's        }
{ included in all units and we can define there ALL conditionals we want!!!  }

PROCEDURE DisplayError(No : Byte);

  Var
    S : String[100]; { The reason why I use String[100] and not just string  }
    { it's because I'm saving memory and speed! When you define some global  }
    { variables, that variables will ocupy space in the data section of the  }
    { program, if you define a string, it will ocupy 256 bytes, but if you   }
    { just use 10 characters, maximum, of that string you are wasting 244    }
    { bytes that could be usefull for other things! But you are asking, "but }
    { this variable is not global, and it's a temporary variable, it will not}
    { ocupy any space?", yes you are rigth, but this is the first ocasion to }
    { talk about that, then I don't have to talk about this no more! AND I   }
    { DON'T WANT TO CLEAR WHAT I WROTE!!!! So, if you want to learn, you have}
    { just to read all the units..................                           }
    { You are probably confused with one thing to: why I'm wasting 244 bytes }
    { if every character ocupy 2 bytes? I don't know but it's what the test  }
    { program says!!!! I don't know everything!!!!                           }
    { Copy the next code and compile it. Then check the code information,    }
    { It's ALT+C+I in Borland Pascal 7.0                                     }
    {
      Unit TestData;
        Interface
          Var
            A : String[255]; (*
                                Change this value and you will learn some
                                interesting things. By the way don't ask me
                                why String[3] ocupy 4 bytes, the same as
                                String[2], I don't have time to explain it to
                                you, because I've to learn to. So if you know
                                write to me....
                             *)

        Implementation

       Begin
       End.
    }
  Begin
    Case No OF
        1 : S := 'Pages not initiated. Use "InitPages".';
        2 : S := 'That BoxType doesn''t exist.';
        3 : S := 'The Box title doesn''t fit in the Box.';
    End;
    BkColor := 0; { Choose Black for Background color }
    Write(1,1,15,S); { Write in the begining of the screen the "S" string    }
                     { with white foreground color                           }
    Halt;  { Exit the program }
  End; { DisplayError (Internal Rotine) }
{$ENDIF}

{ ========================= Screen                 ========================= }
{ =========================        Writing         ========================= }
{ =========================                Rotines ========================= }
{                          ************************                          }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ ChangeAttrib                                                               }
{              - Description : Change the color of all characters that there }
{                              are into specific box co ordinates            }
{              - Input       : X1   --> Upper left X coord                   }
{                              Y1   --> Upper left Y coord                   }
{                              X2   --> Lower right X coord                  }
{                              Y2   --> Lower right Y coord                  }
{                              NewF --> The new foreground color             }
{                              NewB --> The new background color             }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE ChangeAttrib(X1,Y1,X2,Y2, NewB,NewF : Byte);

  Var
    ActualAttr : Word;
    X, Y,
    Caracter,
    NewAttr    : Byte;

  Begin
    FOR X:=X1 TO X2 DO
      FOR Y:=Y1 TO Y2 DO
        Begin
          ActualAttr := GetCharAttribXY(X,Y); { Get the actual code atributte}
                                              { at the specific position     }
          Caracter := ActualAttr AND $FF; { I just want the caracter, so I   }
          { have to separate it from the rest of the attribute composed by   }
          { the actual displaying colors                                     }
          { The first byte is the color atributes, the second byte is the    }
          { character code, so just to get the second I've to make a "AND"   }
          { Many operations, in this and the others units, need a little     }
          { knowledge about bits operations (OR, AND, NOT, SHL, SHR, XOR), so}
          { a advise you (if you don't know) to ask someone, or read some    }
          { books about that!                                                }
          NewAttr := Attribute(NewF,NewB); { Make the new attribute colors   }
          FastWrite(X,Y,NewAttr,Char(Caracter)); { Then write in the screen  }
          { at the same position, the same character, with the new colors    }
        End;
  End; { Change Attrib }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ ClearText                                                                  }
{              - Description : Clear a defined area with a new character     }
{              - Input       : X1, Y1, X2, Y2 --> Area coordenates           }
{                              F,B --> Foreground and Background colors      }
{                              Ch --> New char to use                        }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE ClearText(X1,Y1,X2,Y2, F,B : Byte; Ch : Char);

  Var
    Y : Integer;
    Attrib : Byte;

  Begin
    IF X2 > 80 Then X2 := 80; { Just Check X2 for any wrong value }
    Attrib := Attribute(F,B); { Make the new Atribute             }
    FOR Y := Y1 TO Y2 DO Fastwrite(X1,Y,Attrib,Replicate(X2-X1+1,Ch));
    { Write the new character with the new displaying colors at the specified}
    { position                                                               }
  End;  { ClearText }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ ClrScr                                                                     }
{         - Description : Make a Fast Clear Screen                           }
{         - Input       : ----                                               }
{         - Return      : ----                                               }
{----------------------------------------------------------------------------}
PROCEDURE ClrScr; Assembler;
{ This is probably the fastest away to clear a screen, because this just do  }
{ two things: check the video mode and set the same video mode. This clears  }
{ the screen because, when you set ANY video mode, the screen is ALWAYS      }
{ cleaned!!!                                                                 }
{ The value of the current video mode when you Get the current video mode is }
{ preserved in the AL register and then as already you have it there you can }
{ set the video mode! Easy and quick! Don't you think?                       }
  Asm
    MOV AH,0Fh    { Call function $0F - Get Current Video Mode }
    INT 10h       { Call Interrupt $10                         }
    MOV AH,0      { Call function $0 - Set Video Mode          }
    INT 10h       { Call Interrupt $10                         }
  End; { ClrScr }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ FastWrite                                                                  }
{           - Description : Writes a string directly in video memory         }
{           - Input       : Col  -->  X value                                }
{                           Row  -->  Y value                                }
{                           Attr -->  The attribute of colors                }
{                           Str  -->  The string                             }
{           - Return      : ----                                             }
{----------------------------------------------------------------------------}
{ I got this rotine from SWAG. I just changed a name of a variavel           }
{ "checksnow", but the rest it's the original code! Thanks SWAG, you are     }
{ amazing!!!                                                                 }
PROCEDURE FastWrite(Col, Row, Attr : Byte; Str : String); Assembler;
  Asm
    PUSH   DS           {Save DS}
    MOV    DL,CheckSnow {Save CheckSnow Setting}
    MOV    ES,SegB800   {ES = Colour Screen Segment}
    MOV    SI,SegB000   {SI = Mono Screen Segment}
    MOV    DS,Seg0040   {DS = ROM Bios Segment}
    MOV    BX,[49h]     {BL = CRT Mode, BH = ScreenWidth}
    DEC    Row          {Row = Row - 1}
    MOV    AL,Row       {AL = Row No}
    MUL    BH           {AX = Row * ScreenWidth}
    XOR    CH,CH        {CH = 0}
    DEC    Col          {Col = Col - 1}
    MOV    CL,Col       {CX = Column No}
    ADD    AX,CX        {(Row*ScreenWidth)+Column}
    ADD    AX,AX        {Multiply by 2 (2 Byte per Position)}
    MOV    DI,AX        {DI = Screen Offset}
    CMP    BL,7         {CRT Mode = Mono?}
    JNE    @@DestSet    {No  - Use Colour Screen Segment}
    MOV    ES,SI        {Yes - ES = Mono Screen Segment}
    XOR    DX,DX        {Force jump to FWrite}
  @@DestSet:            {ES:DI = Screen Destination Address}
    LDS    SI,Str       {DS:SI = Source String}
    CLD                 {Move Forward through String}
    LODSB               {Get Length Byte of String}
    MOV    CL,AL        {CX = Input String Length}
    JCXZ   @@Done       {Exit if Null String}
    MOV    AH,Attr      {AH = Attribute}
    OR     DL,DL        {Test Mono/CheckSnow Flag}
    JZ     @@FWrite     {Snow Checking Disabled or Mono - Use FWrite}
{Output during Screen Retrace's}
    MOV    DX,003DAh    {6845 Status Port}
  @@WaitLoop:           {Output during Retrace's}
    MOV    BL,[SI]      {Load Next Character into BL}
    INC    SI           {Update Source Pointer}
    CLI                 {Interrupts off}
  @@Wait1:              {Wait for End of Retrace}
    IN      AL,DX       {Get 6845 status}
    TEST    AL,8        {Vertical Retrace in Progress?}
    JNZ     @@Write     {Yes - Output Next Char}
    SHR     AL,1        {Horizontal Retrace in Progress?}
    JC      @@Wait1     {Yes - Wait until End of Retrace}
  @@Wait2:              {Wait for Start of Next Retrace}
    IN      AL,DX       {Get 6845 status}
    SHR     AL,1        {Horizontal Retrace in Progress?}
    JNC     @@Wait2     {No - Wait until Retrace Starts}
  @@Write:              {Output Char and Attribute}
    MOV     AL,BL       {Put Char to Write into AL}
    STOSW               {Store Character and Attribute}
    STI                 {Interrupts On}
    LOOP   @@WaitLoop   {Repeat for Each Character}
    JMP    @@Done       {Exit}
{Ignore Screen Retrace's}
  @@FWrite:             {Output Ignoring Retrace's}
    TEST   SI,1         {DS:SI an Even Offset?}
    JZ     @@Words      {Yes - Skip (On Even Boundary)}
    LODSB               {Get 1st Char}
    STOSW               {Write 1st Char and Attrib}
    DEC    CX           {Decrement Count}
    JCXZ   @@Done       {Finished if only 1 Char in Str}
  @@Words:              {DS:SI Now on Word Boundary}
    SHR    CX,1         {CX = Char Pairs, Set CF if Odd Byte Left}
    JZ     @@ChkOdd     {Skip if No Pairs to Store}
  @@Loop:               {Loop Outputing 2 Chars per Loop}
    MOV    BH,AH        {BH = Attrib}
    LODSW               {Load 2 Chars}
    XCHG   AH,BH        {AL = 1st Char, AH = Attrib, BH = 2nd Char}
    STOSW               {Store 1st Char and Attrib}
    MOV    AL,BH        {AL = 2nd Char}
    STOSW               {Store 2nd Char and Attrib}
    LOOP   @@Loop       {Repeat for Each Pair of Chars}
  @@ChkOdd:             {Check for Final Char}
    JNC    @@Done       {Skip if No Odd Char to Display}
    LODSB               {Get Last Char}
    STOSW               {Store Last Char and Attribute}
  @@Done:               {Finished}
    POP    DS           {Restore DS}
  End; { FastWrite }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ Horizontal                                                                 }
{            - Description : Write a character from a place to a other in the}
{                            horizontal pos                                  }
{            - Input       : X1    -->  Initial X value                      }
{                            X2    -->  Final X Value                        }
{                            Y    -->  Y value                               }
{                            FColor --> ForeGround color to use              }
{                            BColor --> Background color                     }
{                            Ch    -->  The character                        }
{            - Return      : ------                                          }
{----------------------------------------------------------------------------}
PROCEDURE Horizontal(X1,X2,Y, FColor,BColor : Byte; Ch : Char);

  Var
    X,Attr : Byte;

  Begin
    Attr := Attribute(FColor,BColor);
    For X := X1 TO X2 DO FastWrite(X,Y,Attr,Ch);
   End; { Horizontal }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ SetBlinkBit                                                                }
{             - Description : Procedure to turn the blink bit on/off         }
{             - Input       : OffOn --> TRUE to set the blink Bit on         }
{                                       FALSE to set the blink bit off       }
{             - Return      : ----                                           }
{----------------------------------------------------------------------------}
PROCEDURE SetBlinkBit( OffOn :BOOLEAN ); Assembler;
  Asm
    PUSH AX         { Save AX.                     }
    MOV  AX,1003h   { Video routine to toggle bit. }
    MOV  BL,OffOn   { Move OffOn value in BL.      }
    INT  10h        { Call video Interrupt.        }
    POP  AX         { Restore AX.                  }
  End;  { SetBlinkBit }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ Vertical                                                                   }
{            - Description : Write a character from a place to a other in the}
{                            vertical position                               }
{            - Input       : Y1     -->  Initial Y value                     }
{                            Y2     -->  Final Y value                       }
{                            X      -->  X Value                             }
{                            FColor -->  ForeGround color to use             }
{                            BColor -->  Background color                    }
{                            Ch     -->  The Character                       }
{            - Return      : ----------                                      }
{----------------------------------------------------------------------------}
PROCEDURE Vertical(Y1,Y2,X, FColor, BColor : Byte; Ch : Char);

  Var
    Y,Attr : Byte;

  Begin
    Attr:=Attribute(FColor,BColor);
    FOR Y := Y1 TO Y2 DO FastWrite(X,Y,Attr,Ch);
   End; { Vertical }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ Write                                                                      }
{       - Description : This rotine writes a string and updates the cursor   }
{                       variable.                                            }
{       - Input       : Col    -->  X value                                  }
{                       Row    -->  Y value                                  }
{                       FColor --> ForeGround color to use                   }
{                       Str    -->  The string                               }
{       - Return      : ActualX and ActualY are updated                      }
{----------------------------------------------------------------------------}
PROCEDURE Write(Col,Row, FColor : Byte; Str : String);

  Var
    Attr, ActualX, ActualY : Byte;

  Begin
    Attr := Attribute(FColor,BkColor); { Make the color attribute            }
    FastWrite(Col,Row,Attr,Str);  { Write it to the screen                   }
    ActualX := WhereX;  { Check the actual cursor positions                  }
    ActualY := WhereY;
    ActualX := Col + Length(Str); { And then update it according to the new  }
    ActualY := Row;               { informations                             }
    IF ActualX > 80 THEN   { If there is a value error, it should be         }
      Begin                { corrected                                       }
        ActualX := ActualX - 80;
        Inc(ActualY);
      End;
    GotoXY(ActualX,ActualY); { Update the cursor                             }
   End; { Write }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ WriteCenterText                                                            }
{       - Description : This rotine writes a string centered in a specidied  }
{                       position and updates the cursor variable.            }
{       - Input       : Col    -->  X value                                  }
{                       Row    -->  Y value                                  }
{                       FColor --> ForeGround color to use                   }
{                       Str    -->  The string                               }
{       - Return      : ActualX and ActualY are updated                      }
{----------------------------------------------------------------------------}
PROCEDURE WriteCenterText(Col,Row, FColor : Byte; Str : String);

  Var
    Attr, ActualX, ActualY : Byte;
    X : Byte;

  Begin
    Attr := Attribute(FColor,BkColor);  { This make the same as the behind   }
    { rotine. The only diference is that this rotine centers the string      }
    X := Col - (Length(Str) DIV 2); { Give to X a value that will be rigth   }
                                    { according to our objective             }
    FastWrite(X,Row,Attr,Str);      { Make all the same as the behind rotine }
    ActualX := WhereX;
    ActualY := WhereY;
    ActualX := Col + (Length(Str) DIV 2);
    ActualY := Row;
    IF ActualX > 80 THEN
      Begin
        ActualX:=ActualX-80;
        Inc(ActualY);
      End;
    GotoXY(ActualX,ActualY);
   End; { WriteCenterText }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ Attribute                                                                  }
{         - Description : Converts a foreground and a background colors into }
{                         a combined attribute byte                          }
{         - Input       : F --> Foreground color                             }
{                         B --> Background color                             }
{         - Return      : A combined attribute                               }
{----------------------------------------------------------------------------}
{ When you write a character in the screen, by BIOS or by Memory, the        }
{ character will be always composed by 3 diferent things: The character code,}
{ the foreground color and the background color. This 3 things will ocupy 2  }
{ bytes                                                                      }
FUNCTION Attribute(F,B : Byte) : Byte;

  Begin
      { As I said before the display colors for the character will ocupy 1   }
      { byte. The 4 low bits are the foreground color and the other 4 high   }
      { bits are the background color. So you have just do rotate the        }
      { background value to the left 4 bits (to create the high part of the  }
      { attribute value) and then make a OR with the foreground color! So    }
      { easy, you have just to know some math and bits operations            }
      Attribute := (B SHL 4) OR F;
  End;  { Attr }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ GetCharAttribXY                                                            }
{                 - Description : Get the character and the char attribute   }
{                                 in a specific position                     }
{                 - Input       : X --> Position X                           }
{                                 Y --> Position Y                           }
{                 - Return      : A word representing the Character code     }
{                                 and the attribute of the char              }
{----------------------------------------------------------------------------}
FUNCTION GetCharAttribXY (X, Y : Byte) : Word;

  Begin
    Asm
      MOV AH, 02h       { Call Function $02 - Set Cursor Position          }
      MOV BH, 0         { Set Page 0                                       }
      DEC Y             { Decrement Y                                      }
      MOV DH, Y         { Keep Y in DH                                     }
      DEC X             { Decrement X                                      }
      MOV DL, X         { Keep X in DL                                     }
      INT 10h           { Call Interrupt $10                               }
      MOV AH, $08       { Call function $08 - Read Character and attribute }
                        { at cursor position                               }
      MOV BH, 0         { Set Page 0                                       }
      INT 10h           { Call Interrupt $10                               }
      MOV @Result, AX   { Return the result to the function                }
    End;
  End;  { GetCharAttribXY }


{ ============================ Cursor          ============================= }
{ ============================        Handling ============================= }
{                             *****************                              }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ GotoXY                                                                     }
{         - Description : Puts the cursor in a defined position              }
{         - Input       : X --> The X position                               }
{                         Y --> The Y position                               }
{         - Return      : The cursor position is updated                     }
{----------------------------------------------------------------------------}
PROCEDURE GotoXY(X,Y : Byte); Assembler;

  Asm
    MOV DH, Y  { DH = Row (Y)                        }
    MOV DL, X  { DL = Column (X)                     }
    DEC DH     { Adjust For Zero-based Bios routines }
    DEC DL     { Turbo Crt.GotoXY is 1-based         }
    MOV BH,0   { Display page 0                      }
    MOV AH,2   { Call For Set Cursor Position        }
    INT 10h    { Call Interrupt $10                  }
  { You can do the same, using Direct Memory Access, just do the next things }
  { MemW[Seg0040:$0050] := X;                                                }
  { MemW[Seg0040:$0051] := Y;                                                }
  { By the way, if you use the the behind code for memory access it will work}
  { under protected mode too                                                 }
  End; { GotoXY }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ CursorOn                                                                   }
{           - Description : Shows or Hides cursor                            }
{           - Input       : On --> True the cursor is showed                 }
{                                  False the cursor is hided                 }
{           - Return      : ----                                             }
{----------------------------------------------------------------------------}
PROCEDURE CursorOn(On : Boolean);

  Begin
    IF On Then
      Asm  { ShowCursor }
        MOV  AH, $03
        INT  $10
        MOV  AH, $01
        AND  CH, $1F
        INT  $10
      End
    Else
      Asm  { HideCursor }
        MOV  AH, $03
        INT  $10
        MOV  AH, $01
        OR   CH, $20
        INT  $10
      End;
  End;  { CursorOn }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ CursorType                                                                 }
{            - Description : Defines a cursor style 1-Line 2-Half 3-Block    }
{            - Input       : Size --> The value of the cursor                }
{            - Return      : ----                                            }
{----------------------------------------------------------------------------}
PROCEDURE CursorType(Size: Byte);

  Const
    Line  = 1;
    Half  = 2;
    Block = 3;

  Begin
    Asm
      MOV   AH, $03
      INT   $10
      CMP   Size, Line
      JE    @Line
      CMP   Size, Half
      JE    @Half
      CMP   Size, Block
      JE    @Block
    @Line:
      MOV   CH, $06
      JMP   @Done
    @Half:
      MOV   CH, $04
      JMP   @Done
    @Block:
      MOV   CH, $00
    @Done:
      MOV   CL, $07
      MOV   AH, $01
      INT   $10
    End;
  End;  { CursorType }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ CursorIsOn                                                                 }
{            - Description : Tell if the cursor is in show mode              }
{            - Input       : ----                                            }
{            - Return      : True --> If the cursor is On                    }
{                            False --> If it's Off                           }
{----------------------------------------------------------------------------}
FUNCTION CursorIsOn: Boolean;

  Var
    Yes : Byte;

  Begin
    Yes := 0;
    Asm
      MOV  AH, $03
      INT  $10
      CMP  CH, $20
      JGE  @Hidden
      MOV  Yes, 1;
      JMP  @End
    @Hidden:
      MOV  Yes, 0;
    @End:
    End;
    IF Yes = 1 Then CursorIsOn:=TRUE;
    IF Yes = 0 Then CursorIsOn:=FALSE;
  End;   { CursorHidden }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ WhereX                                                                     }
{         - Description : Returns the actual X cursor position               }
{         - Input       : ----                                               }
{         - Return      : Cursor X position                                  }
{----------------------------------------------------------------------------}
FUNCTION  WhereX : Byte; Assembler;
  Asm
    MOV     AH,3      { Ask For current cursor position                  }
    MOV     BH,0      { On page 0                                        }
    INT     10h       { Return inFormation in DX                         }
    INC     DL        { Bios Assumes Zero-based. Crt.WhereX Uses 1 based }
    MOV     AL, DL    { Return X position in AL For use in Byte Result   }
{   WhereX := MemW[Seg0040:$0050] + 1;                                   }
  End; { WhereX }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ WhereY                                                                     }
{         - Description : Returns the actual Y cursor position               }
{         - Input       : ----                                               }
{         - Return      : Cursor Y position                                  }
{----------------------------------------------------------------------------}
FUNCTION WhereY : Byte; Assembler;
  Asm
    MOV     AH,3     { Ask For current cursor position                  }
    MOV     BH,0     { On page 0                                        }
    INT     10h      { Return inFormation in DX                         }
    INC     DH       { Bios Assumes Zero-based. Crt.WhereY Uses 1 based }
    MOV     AL, DH   { Return Y position in AL For use in Byte Result   }
{   WhereY := MemW[Seg0040:$0051] + 1;                                  }
  End;

{ =========================== Font              ============================ }
{ ===========================      Manipulation ============================ }
{                            *******************                             }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ InstallBiosFont                                                            }
{                 - Description : Install the BIOS ROM Font                  }
{                 - Input       : ----                                       }
{                 - Return      : ----                                       }
{----------------------------------------------------------------------------}
PROCEDURE InstallBiosFont;

  Begin
    ReplaceChar(000, @Bios000);
    ReplaceChar(001, @Bios001);
    ReplaceChar(002, @Bios002);
    ReplaceChar(003, @Bios003);
    ReplaceChar(004, @Bios004);
    ReplaceChar(005, @Bios005);
    ReplaceChar(006, @Bios006);
    ReplaceChar(007, @Bios007);
    ReplaceChar(008, @Bios008);
    ReplaceChar(009, @Bios009);
    ReplaceChar(010, @Bios010);
    { ...
      ...
      ... }
  End; { InstallBiosFont }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ ReplaceChar                                                                }
{             - Description : Replaces a caracter by other represented in a  }
{                             array                                          }
{             - Input       : C       --> Caracter                           }
{                             NewChar --> Pointer to the array of data       }
{             - Return      : ----                                           }
{----------------------------------------------------------------------------}
PROCEDURE ReplaceChar(Code : Byte; NewChar : PCharShape);

  Var
    Points : Word;
    I : Integer;
    Off : Word;
    CharPos : Word;
    PrimFont, SecFont : FontBlock;
    Base : Word;

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ GetFontBlock ( Rotine Internal Rotine )                                    }
{              - Description : Get character map select register:            }
{                               (VGA sequencer port 3C4h/3C5h index 3)       }
{                        7  6  5  4  3  2  1  0                              }
{                        3  3  3  3  3  3                                    }
{                        3  3  3  3  @DDADD   Primary font   (lower 2 bits)  }
{                        3  3  @DDADDDDDDDD   Secondary font (lower 2 bits)  }
{                        3  @DDDDDDDDDDDDDD   Primary font   (high bit)      }
{                        @DDDDDDDDDDDDDDDDD   Secondary font (high bit)      }
{              - Input       : Variable input                                }
{              - Return      : Primary and Secondary type font               }
{----------------------------------------------------------------------------}
PROCEDURE GetFontBlock(Var Primary, Secondary : FontBlock); Assembler;
  Asm
    MOV     AL, 3
    MOV     DX, 3C4h
    OUT     DX, AL
    INC     DX
    IN      AL, DX
    MOV     BL, AL
    PUSH    AX
  { Get secondary font number: add up bits 5, 3 and 2 }
    SHR     AL, 1
    SHR     AL, 1
    AND     AL, 3
    TEST    BL, 00100000b
    JZ      @1
    ADD     AL, 4
 @1:
    LES     DI, Secondary
    STOSB
  { Get primary font number: add up bits 4, 1 and 0 }
    POP     AX
    AND     AL, 3
    TEST    BL, 00010000b
    JZ      @2
    ADD     AL, 4
 @2:
    LES     DI, Primary
    STOSB
  End;  { Sub GetFontBlock }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ PostInc ( Rotine Internal Rotine )                                         }
{         - Description : Increment W                                        }
{         - Input       : Variable  W                                        }
{         - Return      : PostInc := W                                       }
{                         W := W + 1                                         }
{----------------------------------------------------------------------------}
FUNCTION PostInc(Var W : Word) : Word;
  Begin
    PostInc := W;
    Inc(W);
  End; { Sub PostInc }

  Begin  { ReplaceChar }
    IF (Mem[Seg0040:$0084] = 0) THEN  Points := 8  { Call Video Functions to }
       { detect the number of rows in the text mode selected }
   ELSE
    Begin
      IF Mem[Seg0040:$0084] in [42,49] THEN  Points := 13
     Else  Points := Mem[Seg0040:$0085]; { Caracter height in scan-lines }
    End;
    Asm
  { Program the VGA controller }
      PUSHF               { Disable interrupts }
      CLI
      MOV  DX, 03c4h      { Sequencer port address }
      MOV  AX, 0704h      { Sequential addressing }
      OUT  DX, AX
      MOV  DX, 03ceh      { Graphics Controller port address }
      MOV  AX, 0204h      { Select map 2 for CPU reads }
      OUT  DX, AX
      MOV  AX, 0005h      { Disable odd-even addressing }
      OUT  DX, AX
      MOV  AX, 0406h      { Map starts at A000:0000 (64K mode) }
      OUT  DX, AX
      MOV  DX, 03c4h      { Sequencer port address }
      MOV  AX, 0402h      { CPU writes only to map 2 }
      OUT  DX, AX
    End;
  { First get the current font *}
    GetFontBlock(PrimFont, SecFont);
    Base := 8192 * PrimFont;
    Off := 16 - Points;
    CharPos := Code * 32;
    FOR I:=0 TO Points-1 DO
      Begin
        Mem[SegA000:Base+PostInc(CharPos)] := NewChar^[PostInc(Off)];
      End;
  { Ok, put the Sequencer and Graphics Controller back to normal }
    Asm
  { Program the Sequencer }
      PUSHF               { Disable interrupts }
      CLI
      MOV DX, 3c4h        { Sequencer port address }
      MOV AX, 0302h       { CPU writes to maps 0 and 1 }
      OUT DX, ax
      MOV AX, 0304h       { Odd-even addressing }
      OUT DX, AX
  { Program the Graphics Controller }
      MOV DX, 3ceh        { Graphics Controller port address }
      MOV AX, 0004h       { Select map 0 for CPU reads }
      OUT DX, AX
      MOV AX, 1005h       { Enable odd-even addressing }
      OUT DX, AX;
      MOV AX,Seg0040
      MOV ES,AX
      MOV AX, 0e06h       { Map starts at B800:0000 }
      MOV BL, 7
      CMP ES:[49h], BL    { Get current video mode }
      JNE @@NotMono
      MOV AX, 0806h       { Map starts at B000:0000 }
@@NotMono:
      OUT DX, AX;
      POPF;
    End;
  End; { ReplaceChar }

{ ============================== Box          ============================== }
{ ==============================     Creation ============================== }
{                               **************                               }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ Box                                                                        }
{      - Description : Draws a box on the screen                             }
{      - Input       : X1, Y1, X2, Y2 --> Area coordenates                   }
{                      LineType --> Type of line to use                      }
{                      F,B --> Foregound and BackGround Colors               }
{                      PutName --> Put the strinf in the window?             }
{                      Name --> If PutName=True then put Name                }
{      - Return      : ----                                                  }
{----------------------------------------------------------------------------}
PROCEDURE Box(X1,Y1,X2,Y2,
              F,B,
              LineType : Byte;
              PutName : Boolean;
              Name : String);

  Var
    I:integer;
    corner1,corner2,corner3,corner4,
    horizline,
    vertline : char;
    attrib : byte;

  Begin
    Case LineType OF
      0:Begin
            corner1:=' ';
            corner2:=' ';
            corner3:=' ';
            corner4:=' ';
            horizline:=' ';
            vertline:=' ';
        End;
      1:Begin
            corner1:='Ú';
            corner2:='¿';
            corner3:='À';
            corner4:='Ù';
            horizline:='Ä';
            vertline:='³';
        End;
      2:Begin
            corner1:='É';
            corner2:='»';
            corner3:='È';
            corner4:='¼';
            horizline:='Í';
            vertline:='º';
        End;
      {$IFNDEF NoInternalChecking}
      Else DisplayError(2);
      {$ENDIF}
    End; { case }
    ClearText(Succ(X1),Succ(Y1),Pred(X2),Pred(Y2),F,B,' ');
    Attrib := Attribute(F,B);
    FastWrite(X1,Y1,Attrib,Corner1);
    FastWrite(X1+1,Y1,Attrib,Replicate(X2-X1-1,HorizLine));
    FastWrite(X2,Y1,Attrib,Corner2);
    For I := Y1+1 TO Y2-1 DO
      Begin
        FastWrite(X1,I,Attrib,VertLine);
        FastWrite(X2,I,Attrib,VertLine);
      End;
    FastWrite(X1,Y2,Attrib,Corner3);
    FastWrite(X1+1,Y2,Attrib,Replicate(X2-X1-1,HorizLine));
    FastWrite(X2,Y2,Attrib,Corner4);
    IF PutName Then
      Begin
        IF (X2-X1 >= Length(Name)+4) Then
          Begin
            BkColor:=B;
            WriteCenterText(((X2-X1) DIV 2)+X1,Y1,F,' '+Name+' ');
          End
        {$IFNDEF NoInternalChecking}
        Else DisplayError(3);
        {$ENDIF}
      End;
  End; { Box }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ Shadow                                                                     }
{      - Description : Makes a shadow on the screen                          }
{      - Input       : X1, Y1, X2, Y2 --> Area coordenates                   }
{      - Return      : ----                                                  }
{----------------------------------------------------------------------------}
PROCEDURE Shadow(X1,Y1,X2,Y2 : Byte);

  Var
    U2,T2:Byte;

  Begin
    U2:=X2+2;
    T2:=Y2+1;
    IF X2=79 Then U2:=X2+1;
    IF X2=80 Then U2:=X2;
    ChangeAttrib(X2+1,Y1+1,U2,T2,0,7);
    ChangeAttrib(X1+1,T2,U2,T2,0,7);
  End; { Shadow }

{ ========================== Save                 ========================== }
{ ==========================      Screen          ========================== }
{ ==========================             Rotines  ========================== }
{                           **********************                           }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ CheckVidSeg ( Unit Internal Rotine )                                       }
{      - Description : Check the actual screen video segment                 }
{      - Input       : ----                                                  }
{      - Return      : Unit Internal Variable "VideoSeg"                     }
{----------------------------------------------------------------------------}
PROCEDURE CheckVidSeg;

  Var
    Mem : integer;

  Begin
    IF VideoCard(Mem) = VGAMono Then VideoSeg := SegB000
    Else VideoSeg := SegB800;
  End; { CheckVidSeg }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ ReleasePages                                                               }
{      - Description : Release all pages that there are keeped in memory     }
{      - Input       : Var WhatGroup --> Pointer to the record               }
{      - Return      : -------                                               }
{----------------------------------------------------------------------------}
PROCEDURE ReleasePages(Var WhatGroup : ScreenPtr);

  Var
    Holder : ScreenPtr;

  Begin
    IF PagesInitiated Then
      Begin
        IF WhatGroup <> NIL Then
          Repeat
            Holder := WhatGroup^.Next;
            Dispose(WhatGroup);
            WhatGroup := Holder;
          Until WhatGroup = NIL;
      End
    {$IFNDEF NoInternalChecking}
    Else DisplayError(1);
    {$ENDIF}
  End; { ReleasePages }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ RestorePage                                                                }
{      - Description : Restore a page keeped in memory                       }
{      - Input       : Var WhatGroup  --> Pointer to the record              }
{                          Identifier --> The number of the page you want to }
{                                         restore                            }
{      - Return      : -----------                                           }
{----------------------------------------------------------------------------}
PROCEDURE RestorePage(Var WhatGroup : ScreenPtr; Identifier : Longint);

  Var
    Current : ScreenPtr ;
    TopX,TopY,DownX,DownY,
    X,Y : Byte;
    I : Integer;

  Begin
    IF PagesInitiated Then
      Begin
        IF WhatGroup = NIL Then Exit;
        Current := WhatGroup;
        While Current <> NIL DO
          Begin
            IF Current^.Id = Identifier Then
              Begin
                TopX := Current^.X1;
               TopY := Current^.Y1;
               DownX := Current^.X2;
               DownY := Current^.Y2;
               I := 1;
               FOR Y := TopY TO DownY DO
               FOR X := TopX TO DownX DO
                 Begin
                   InLine ($FA);
                   Mem[VideoSeg : (160 * (Y - 1) + 2 * (X - 1) ) ] := Current^.HoldScreen[I];
                   Mem[VideoSeg : (160 * (Y - 1) + 2 * (X - 1) ) + 1] := Current^.HoldScreen [I + 1];
                   InLine ($FB);
                   Inc (I, 2);
                 End;
             End;
             Current := Current^.Next;
         End;
       NewScreen := True;
      End
    {$IFNDEF NoInternalChecking}
    Else DisplayError(1);
    {$ENDIF}
     End; { RestorePage }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ StorePage                                                                  }
{      - Description : Store a page in memory                                }
{      - Input       : Var WhatGroup  --> Pointer to the record              }
{                          TopX  --> Upper Left corner coordinate            }
{                          TopY  --> Upper Left corner coordinate            }
{                          DownX --> Down Rigth corner coordinate            }
{                          DownX --> Down Rigth corner coordinate            }
{                          Identifier --> The number of the page you want to }
{                                         restore                            }
{      - Return      : -----------                                           }
{----------------------------------------------------------------------------}
PROCEDURE StorePage(Var WhatGroup : ScreenPtr;
                        TopX,TopY,DownX,DownY : Byte;
                        Identifier : LongInt);
  Var
    WorkRec  : ScreenRec;
    Current,
    Holder   : ScreenPtr;
    Replaced : Boolean;
    X,Y      : Byte;
    I        : Integer;

  Begin
    IF PagesInitiated Then
      Begin
       Error := 0;
       IF MemAvail > SizeOf(ScreenRec) Then
         Begin
           Replaced := False;
           FillChar(WorkRec,Sizeof(ScreenRec),#0);
           Workrec.X1 := TopX;
           Workrec.Y1 := TopY;
           Workrec.X2 := DownX;
           Workrec.Y2 := DownY;
           I := 1;
           FOR Y := TopY TO DownY DO
           FOR X := TopX TO DownX DO
             Begin
               InLine ($FA);
               Workrec.Holdscreen [I] := Mem[VideoSeg : (160 * (Y - 1) + 2 * (X - 1) ) ];
               Workrec.Holdscreen [I + 1] := Mem[VideoSeg : (160 * (Y - 1) + 2 * (X - 1) ) + 1];
               InLine ($FB);
               Inc (i, 2);
             End;
           Workrec.Id := Identifier;   { a byte "label" }
           IF WhatGroup = NIL Then
             Begin
               New(WhatGroup);
               WorkRec.Next := NIL;
               WhatGroup^ := WorkRec;
             End
           Else
             Begin
               Current := WhatGroup;
               Holder  := WhatGroup;
               Repeat
                 IF Current^.Id = Identifier Then { replace screen already in list }
                   Begin
                     Move(WorkRec.HoldScreen,Current^.HoldScreen,4000);
                     Replaced := True;
                   End;
                 Current := Current^.Next;
               Until (Current=NIL) OR Replaced ;
               IF NOT Replaced Then
                 Begin
                   New(WhatGroup);
                   WorkRec.Next := Holder; { adds record to "start" of list }
                   WhatGroup^ := WorkRec;
                 End;
             End;
         End
       Else Error := 1;
      End
    {$IFNDEF NoInternalChecking}
    Else DisplayError(1);
    {$ENDIF}
  End;  { StorePage }


{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ InitPages                                                                  }
{      - Description : Check if there is enough memory to init some pages    }
{      - Input       : Var WhatGroup --> Pointer to the record               }
{                          Number    --> The number of pages to init         }
{      - Return      : TRUE if there is enough memory                        }
{----------------------------------------------------------------------------}
FUNCTION InitPages(Var WhatGroup : ScreenPtr;Number : Longint) : Boolean;

  Begin
    WhatGroup := NIL;
    InitPages := False;
    IF MemAvail > Number * SizeOf(ScreenRec) Then
      Begin
        PagesInitiated := True;
        InitPages := True;
      End;
  End; { InitPages }

{ ======================== Fade                       ====================== }
{ ========================      And                   ====================== }
{ ========================          Palette           ====================== }
{ ========================                  Control   ====================== }
{                         ****************************                       }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ GetCol ( Unit Internal Rotine )                                            }
{      - Description : Get the actual RGB color state                        }
{      - Input       : ColNr --> Color Number                                }
{                      Var R,G,B --> Color attributes                        }
{      - Return      : --------                                              }
{----------------------------------------------------------------------------}
PROCEDURE GetCol(ColNr : Byte; Var R, G, B : Byte); Assembler;

  Asm
    MOV DX,PelIdxR
    MOV AL,ColNr
    OUT DX,AL
    MOV DX,PelData
    LES SI,R
    IN AL,DX
    MOV BYTE PTR [ES:SI],AL
    LES SI,G
    IN AL,DX
    MOV BYTE PTR [ES:SI],AL
    LES SI,B
    IN AL,DX
    MOV BYTE PTR [ES:SI],AL
  End; { GetCol }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ SetCol ( Unit Internal Rotine )                                            }
{      - Description : Set RGB color state, change just one color            }
{      - Input       : ColNr --> Color Number                                }
{                      Var R,G,B --> Color attributes                        }
{      - Return      : --------                                              }
{----------------------------------------------------------------------------}
PROCEDURE SetCol(ColNr, R, G, B : Byte); Assembler;

  Asm
    MOV DX,PelIdxW
    MOV AL,ColNr
    OUT DX,AL
    MOV DX,PelData
    MOV AL,R
    OUT DX,AL
    MOV AL,G
    OUT DX,AL
    MOV AL,B
    OUT DX,AL
  End; { SetCol }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ FadeIn                                                                     }
{      - Description : Makes the colors appear from nothing to normalized    }
{      - Input       : Duration --> The time that it takes to do             }
{      - Return      : --------                                              }
{----------------------------------------------------------------------------}
PROCEDURE FadeIn(Duration : Byte);

  Var
    I : Byte;

  Begin
    FOR I := 0 TO MaxInten DO
      Begin
        SetBrightness(I);
        Delay(Duration)
      End;
  End; { FadeIn }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ FadeOut                                                                    }
{      - Description : Makes the colors desappear from normal to nothing     }
{      - Input       : Duration --> The time that it takes to do             }
{      - Return      : --------                                              }
{----------------------------------------------------------------------------}
{ By the way, I advise you: evertyme that you made FadeOut, please do a      }
{ FadeIn, because you could have some bad experience. And before you use this}
{ or the FadeIn rotine you have to do "InitCol"                              }
PROCEDURE FadeOut(Duration : Byte);

  Var
    I : Byte;

  Begin
    FOR I := MaxInten DOWNTO 0 DO
      Begin
        SetBrightness(I);
        Delay(Duration)
      end
  End; { FadeOut }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ InitCol                                                                    }
{      - Description : Gets the current palette and saves it                 }
{      - Input       : --------                                              }
{      - Return      : --------                                              }
{----------------------------------------------------------------------------}
PROCEDURE InitCol;

  Var
    I : Byte;

  Begin
    FOR I := 0 TO MaxReg DO GetCol(I, Col[I].R, Col[I].G, Col[I].B)
  End; { InitCol }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ SetBrightness                                                              }
{      - Description : Sets the brightness                                   }
{      - Input       : BrightNess --> The new value for BrigthNess           }
{      - Return      : --------                                              }
{----------------------------------------------------------------------------}
PROCEDURE SetBrightness(BrightNess : Byte);

  Var
    I : Byte;

  Begin
    FOR I := 0 TO MaxReg DO SetCol(I,Col[I].R * Brightness div MaxInten,
                                     Col[I].G * Brightness div MaxInten,
                                     Col[I].B * Brightness div MaxInten);
  End; { SetBrightness }

{ ************************        MAIN         ******************************}
{                         *********************                              }
  Begin  { Run the unit to prepare some default values }
    CheckVidSeg;
    BkColor := 0;
    Error := 0;
  End.  { End Everything }

{ Well, for now the only thing I have to do is write the list of the guys and}
{ places I look to write this unit. In each unit is the list of the people   }
{ that made the original sources where I look to make the respective unit.   }
{ So, to this unit I read the next people sources and books:                 }

{ From SWAG:                                                                 }
{           - SwagTeam                                                       }
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


