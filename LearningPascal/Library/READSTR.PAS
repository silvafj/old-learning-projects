
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
Unit ReadStr;

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE

  Const
    Max_End_Keys = 10;

  Type
    ReadType = Record
                 WhiteSpace  : char;        {used to pad input field - default úúúúúúúúúú}
                 AllowEsc    : boolean;     {allow the he user to escape?}
                 Insert      : boolean;     {initially in insert mode?}
                 BegCursor   : boolean;     {place cursor at beginning of line}
                 AllowNull   : boolean;     {allow user to input a '' or null value}
                 RightJustify: Boolean;     {right justify string on termination}
                 EraseDefault: Boolean;     {clear entry of alphanumeric pressed}
                 SuppressZero: Boolean;     {have empty field is value = zero}
                 FCol        : byte;        {normal foreground color of input field}
                 BCol        : byte;        {normal background of input field}
                 HiFCol       : byte;       {highlighted fgnd color for Read_Select}
                 HiBCol       : byte;       {highlighted bgnd color for Read_Select}
                 LoFCol      : byte;        {normal fgnd color for Read_Select}
                 LoBCol      : byte;        {normal bgnd color for Read_Select}
                 PFcol       : byte;        {prompt foreground color}
                 PBCol       : byte;        {prompt background color}
                 BoxFCol     : byte;        {box foreground color}
                 BoxBCol     : byte;        {Box background color}
                 Msg_FCol    : byte;        {Foreground color for error messages}
                 Msg_BCol    : byte;        {Background color for error messages}
                 Msg_Line    : byte;        {line for error messages}
                 Endchars   : Array [1..Max_End_Keys] OF Word; {end of input chars}
                 RealDP      : byte;        {no of decimal places on real}
               End;


  Var
    ReadDisplay : ReadType;

{ Public rotines }
  PROCEDURE DefaultSettings;
  PROCEDURE ReadLine(X,Y,InputLength,MaxStrLength,FColor,BColor,Format:Byte; Var Text:String);
  PROCEDURE ReadString(X,Y,InputLength,MaxStrLength:Byte;Prompt:String;BoxType:Byte;Var Text:String);
  PROCEDURE ReadUpCaseString(X,Y,InputLength,MaxStrLength:Byte;Prompt:String;BoxType:Byte;Var Text:String);
  PROCEDURE ReadPassword(X,Y,InputLength,MaxStrLength:Byte;Prompt:String;BoxType:Byte;Var Text:String);
  PROCEDURE ReadAlpha(X,Y,InputLength,MaxStrLength:Byte;Prompt:String;BoxType:Byte;Var Text:String);
  PROCEDURE ReadYN(X,Y:Byte;Prompt:String;BoxType:Byte;Var Yes:Boolean);
  PROCEDURE ReadNumber(X,Y,InputLength,MaxStrLength:Byte;Prompt:String;BoxType: byte;Min, Max : Longint;Var Value : Longint);

{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }
IMPLEMENTATION

  Uses
    Math,StrsUse,Screen,Keyboard;

  Const
    PassChar = '*';
    ZapKey   = kb_Alt_D;      { Alt+D to delete the field }

  Var
    R_Char : Char;
    R_Null : Boolean;
    ReadStrUnitSaveScreenGroup : ScreenPtr;

{----------------------------------------------------------------------------}
{                                                                            }
{ DefaultSettings                                                            }
{                 - Description : Initializes the default settings           }
{                 - Input       : ----                                       }
{                 - Return      : ----                                       }
{----------------------------------------------------------------------------}
PROCEDURE DefaultSettings;

  Begin
    FillChar(ReadDisplay,Sizeof(ReadDisplay),#0);
    With ReadDisplay DO
      Begin
        WhiteSpace   := ' ';
        BegCursor    := False;
        Insert       := False;
        AllowEsc     := True;
        AllowNull    := True;
        RightJustify := False;
        EraseDefault := False;
        SuppressZero := True;
        RealDP := 2;
        FCol := 15;
        BCol := 1;
        HiFCol := 15;
        HiBCol := 1;
        LoFCol := 7;
        LoBCol := 0;
        PFCol := 15;
        PBCol := 0;
        BoxFCol := 15;
        BoxBCol := 0;
        Msg_FCol := 12;
        Msg_BCol := 0;
        Msg_Line := 24;
        EndChars[1] := Kb_Enter;
        EndChars[2] := Kb_Pad_Enter;
    End;
  End;  { DefaultSettings }

{----------------------------------------------------------------------------}
{                                                                            }
{ ReadLine                                                                   }
{         - Description : This is the main procedure and it will be used to  }
{                         read ALL type of things that you want.             }
{         - Input       : X --> X coord of first character in field          }
{                         Y --> Y coord of field                             }
{                         MaxLength --> the maximum length of the input field}
{                         FColor --> the foreground color                    }
{                         BColor --> the background color                    }
{                         Format Codes:  1   Any String                      }
{                                        2   Force Upper String              }
{                                        3   Yes/No                          }
{                                        4   Alphabetics only                }
{                                        5   Integer                         }
{                                        6   LongInteger                     }
{                                        7   Real                            }
{                                        8   Word                            }
{                                        9   Date    (MM/DD/YY)              }
{                                        10  Date    (DD/MM/YY)              }
{                                        11  Echo a Password                 }
{         - Return      : Text --> A input/output variavel                   }
{----------------------------------------------------------------------------}
PROCEDURE ReadLine(X,Y,InputLength,MaxStrLength,FColor,BColor,Format:Byte; Var Text:String);

  Var
    TempText : String;
    InsertMode,
    Password,
    Alldone : Boolean;
    Top,Down,CursorPos,StrPos : Byte;
    FirstCharPress: Boolean;
    Key : Word;
    Ch:Char;
    CursorX,
    CursorY:Byte;
    A : Byte;
    DoLetter: Boolean;

  PROCEDURE CheckParameters;
    { Internal rotine to check the input parameters }
    Begin
      TempText := Text;
      IF (X + InputLength > 80) OR (Not X IN [1..80]) Then
        Begin
          X := 1;
          InputLength := 10;
        End;
      IF Not Y IN [1..25] Then Y := 1;
      Top := 1;
      IF ReadDisplay.BegCursor Then CursorPos := 1
      Else
        Begin
          IF (Length(TempText) < MaxStrLength) AND (Length(TempText) < InputLength) Then
            CursorPos := Length(TempText) + 1
          Else CursorPos := InputLength;
        End;
      StrPos := CursorPos;
      InsertMode := ReadDisplay.Insert;
      Alldone := False;
      IF Format = 11 Then
        Begin
          Password := True;
          Format := 1;
        End
      Else
        Password := False;
    End;  { Internal Rotine CheckParameters }

  FUNCTION FillWhiteSpace(Str:String):String;
    { This will fill the blank input place with the choosed character to }
    { fill the blank spaces                                              }
    Var
      I : Integer;

    Begin
      IF Password Then Str := Replicate(Length(Str),PassChar);
      While Length(Str) < InputLength DO Str := Str + ReadDisplay.WhiteSpace;
      FillWhiteSpace := Str;
    End; { Internal Rotine FillWhiteSpace }

  PROCEDURE MoveTheCursor;
    { This rotine updates constantly the cursor position }
    Begin
      GotoXY(X+CursorPos-1,Y);
    End;  { Internal Rotine MoveTheCursor }

  PROCEDURE WriteString;
    { Of course this rotine writes the actual string }
    Var
      TempStr:String;

    Begin
        TempStr:=TempText;
        IF Length(TempText) > InputLength Then TempStr := Copy(TempText,Top,InputLength);
        FastWrite(X,Y,Attribute(BColor,BColor),Replicate(InputLength,' '));
        FastWrite(X,Y,Attribute(FColor,BColor),FillWhiteSpace(TempStr));
        MoveTheCursor;
    End;  { Internal Rotine WriteString }

  PROCEDURE EraseField;
    { This erases the input place and writes the actual inputed string }
    Begin
      TempText := '';
      CursorPos := 1;
      Top := 1;
      WriteString;
    End;  { Internal Rotine EraseField }

  PROCEDURE CharBackspace;
    { Do you want to del de last inputed char with the BackSpace Key? }
    Begin
      IF CursorPos > 1 Then
        Begin
          Dec(CursorPos);
          Dec(StrPos);
          Delete(TempText,StrPos,1);
          WriteString;
        End;
    End;  { Internal Rotine CharBackspace }

  PROCEDURE CharDel;
    { So you want to del the char where the cursor is... }
    Begin
      IF Length(TempText) > 1 Then
        Begin
          Delete(TempText,StrPos,1);
          WriteString;
        End;
    End;  { Internal Rotine CharDel }

  PROCEDURE AddChar(Ch:Char);
    { Ok! This will add the char you want }
    Begin
      IF InsertMode Then
        Begin  { InsertMode is On ? Then will insert the char }
          IF Length(TempText) < MaxStrLength Then
            Begin
                Insert(Ch,TempText,Top+CursorPos-1);
                IF CursorPos < InputLength Then
                  Begin
                    Inc(CursorPos);
                    Inc(StrPos);
                  End
                Else
                  Begin
                    CursorPos := InputLength;
                    Inc(Top);
                    Inc(StrPos);
                  End;
            End;
        End
      Else { Not InsertMode! Then will delete the char and put the new one }
        Begin
          IF Length(TempText) < MaxStrLength Then
            Begin
              Delete(TempText,Top+CursorPos-1,1);
              Insert(Ch,TempText,Top+CursorPos-1);
              If CursorPos < InputLength Then
                Begin
                  Inc(CursorPos);
                  Inc(StrPos);
                End
              Else
                Begin
                  CursorPos := InputLength;
                  Inc(Top);
                  Inc(StrPos);
                End;
            End;
        End;
      WriteString;
    End;   { Internal Rotine AddChar }

  Begin  { Main Rotine "ReadLine" }
    DoLetter := True;
    AllDone:= False;
    CheckParameters;
    R_Null := False;
    CursorX:=WhereX;
    CursorY:=WhereY;
    IF ReadDisplay.Insert Then CursorType(3)
    Else CursorType(1);
    WriteString;
    FirstCharPress := True;
    Repeat
      Key := GetScanCodeW;
      Ch := Char(Key AND $00FF);
      IF Format IN [2,3] Then Ch := UpCase(Ch);
      FOR A:=1 TO Max_End_Keys DO
        Begin
          IF ReadDisplay.EndChars[A]=Key Then
            Begin
              AllDone := True;
              IF Key <> kb_Esc Then Text := TempText;
            End;
        End;
      IF Not AllDone Then
        Begin
          Case Key OF
            kb_Right,
            kb_Pad_Right : Begin
                         IF (CursorPos < InputLength) Then
                           Begin
                             Inc(CursorPos);
                             Inc(StrPos);
                             MoveTheCursor;
                           End
                         Else
                           IF StrPos < MaxStrLength Then
                             Begin
                               CursorPos := InputLength;
                               Inc(Top);
                               Inc(StrPos);
                               WriteString;
                             End
                           Else
                             Begin
                               StrPos := MaxStrLength;
                               CursorPos := InputLength;
                               Top := MaxStrLength - InputLength + 1;
                               TempText := Copy(TempText,1,MaxStrLength);
                               WriteString;
                             End;
                         DoLetter := False;
                       End; { RightKey }
           kb_Left,
           kb_Pad_Left : Begin
                         IF (CursorPos > 1) Then
                           Begin
                             Dec(CursorPos);
                             Dec(StrPos);
                             MoveTheCursor;
                           End
                         Else
                           Begin
                             IF Top > 1 Then
                               Begin
                                 Dec(Top);
                                 Dec(StrPos);
                                 WriteString;
                               End;
                           End;
                         DoLetter := False;
                       End; { LeftKey }
           kb_Home,
           kb_Pad_Home : Begin
                         CursorPos := 1;
                         StrPos := 1;
                         MoveTheCursor;
                         Top := 1;
                         WriteString;
                         DoLetter := False;
                       End; { HomeKey }
           kb_Down,
           kb_Pad_Down,
           kb_Up,
           kb_Pad_Up   : Begin
                         End;  { Doesn't do anything !!!! }
           Kb_End,
           kb_Pad_End  : Begin
                           StrPos := Length(TempText);
                           CursorPos := InputLength;
                           Top := MaxStrLength - InputLength + 1;
                           WriteString;
                           DoLetter := False;
                         End; { EndKey }
           kb_Ins : Begin
                         IF Format <> 3 Then   { don't allow insert on Y/N! }
                           Begin
                             InsertMode := Not InsertMode;
                             IF InsertMode Then CursorType(3)
                             Else CursorType(1);
                           End;
                         DoLetter := False;
                       End; { InsKey }
           kb_Del,
           kb_Pad_Del : Begin
                         CharDel;
                         DoLetter := False;
                       End; { DelKey }
           kb_BackSpace : Begin
                         CharBackspace;
                         DoLetter := False;
                       End; { BackSpaceKey }
            ZapKey   : Begin
                         EraseField;
                         DoLetter := False;
                       End; { ZapKey }
            kb_Esc   : Begin
                         IF ReadDisplay.AllowEsc Then Alldone := true;
                         DoLetter := False;
                       End; { EscKey }
            kb_Enter,
            kb_Pad_Enter :  Begin
                          Alldone := True;
                          Text := TempText;
                          DoLetter := False;
                        End; { EnterKey }
          End; { Key Case }
          IF DoLetter Then
            Case Ch OF
              #1 .. #42,   { to * }
              #44,         { , }
              #47,         { / }
              #58 .. #64,  { : to @ }
              #91 .. #96,  { [ to ' }
              #123 .. #127,{ { to  }
              #145..#146,  { ‘ to ’ }
              #155..#159,  { œ to Ÿ }
              #166..#180,  { ¦ to ´ }
              #184..#197,  { ¸ to Å }
              #200..#209,  { È to Ñ }
              #213,        { Õ }
              #217..#221,  { Ù to Ý }
              #223,        { ß }
              #225,        { á }
              #230..#232,  { æ to è }
              #238..#255   : Begin  { î to ÿ}
                               IF (Format IN [1,2]) Then
                                 Begin
                                   IF FirstCharPress AND ReadDisplay.EraseDefault Then
                                     EraseField;
                                   AddChar(Ch);
                                 End;
                             End;
              #43, #45     : Begin
                               IF (Format IN [1,2]) OR  { + - }
                                  ((CursorPos=1) AND (Format IN [5,6,7])) Then
                                 Begin
                                   IF FirstCharPress AND ReadDisplay.EraseDefault Then
                                     EraseField;
                                   AddChar(Ch);
                                 End;
                             End;
              #46          : Begin
                               IF (Format IN [1,2]) OR {.}
                                  ((Pos('.',TempText)=0) AND (Format = 7)) Then
                                 Begin
                                   IF FirstCharPress AND ReadDisplay.EraseDefault Then
                                     EraseField;
                                   AddChar(Ch);
                                 End;
                             End;
              #48..#57     : Begin
                               IF (Format IN [1..2,5..8]) Then {0 to 9}
                                 Begin
                                   IF FirstCharPress AND ReadDisplay.EraseDefault Then
                                     EraseField;
                                   AddChar(Ch);
                                 End;
                             End;
              #32,          {space}
              #65..#77,     {A to M}
              #79..#88,     {O to X}
              #90,          {Z}
              #97..#122,    {a to z}
              #128..#144,   {€ to  }
              #147..#154,   {“ to š}
              #160..#165,   {  to ¥ }
              #181..#183,   {µ to · }
              #198..#199,   { Æ to Ç }
              #210..#212,   {Ò to Ô }
              #214..#216,   {Ö to Ø }
              #224,         { à }
              #226..#229,   { â to å }
              #233..#237   : Begin  { é to í }
                               IF (Format IN [1,2,4]) Then
                                 Begin
                                   IF FirstCharPress AND ReadDisplay.EraseDefault Then
                                     EraseField;
                                   AddChar(Ch);
                                 End;
                             End;
              #78,#89      : Begin
                               IF (Format IN [1..4]) Then   {N Y}
                                 Begin
                                   AddChar(Ch);
                                   IF Format = 3 Then
                                     Begin
                                       Alldone := true;
                                       Text := TempText;
                                     End;
                                 End;
                             End;
            End; { Case ch }
        End; { If not alldone }
      FirstCharPress := false;
      DoLetter:=True;
    Until Alldone;
    IF Length(TempText) > MaxStrLength Then Text:=Copy(TempText,1,MaxStrLength);
    R_Char := Ch;
    IF ReadDisplay.RightJustify AND (Format > 4) Then
      Begin
        Fastwrite(X+1,Y,attribute(FColor,BColor),replicate(InputLength,ReadDisplay.Whitespace));
        IF (InputLength > Length(TempText)) Then Fastwrite(X-Length(TempText),Y,attribute(FColor,BColor),Text)
        Else Fastwrite(X,Y,attribute(FColor,BColor),Copy(Text,Length(Text)-InputLength,InputLength))
      End
    Else
      Fastwrite(X,Y,attribute(FColor,BColor),FillWhiteSpace(Copy(Text,1,InputLength)));
    GotoXY(CursorX,CursorY);
  End;  { ReadLine }


{----------------------------------------------------------------------------}
{                                                                            }
{ DisplayOutBox                                                              }
{         - Description : Ensures that the input will fit on the screen, then}
{                         draws box and prompt                               }
{                         read ALL type of things that you want.             }
{         - Input       : X1 --> X coord                                     }
{                         Y --> Y coord                                      }
{                         BoxType --> What type of box do you want?          }
{                         Prompt --> What do you want to inform to the user  }
{                         MaxLength --> SelfExplained                        }
{         - Return      : X1,Y Input/Output variavels                        }
{----------------------------------------------------------------------------}
PROCEDURE DisplayOutBox(Var X,Y,InputLength:Byte;BoxType:Byte;Prompt:String);

  Const
    Upchar = '^';
    DnChar = '_';

  Var
    P,Width:Byte;
    InBorder : Byte;  { Is title in box border - 0 no, 1 upper, 2 lower }

  Begin
    IF Not ((Y-Ord(BoxType > 0)) IN [1..25] ) Then Y := 2;
    IF (X < 1) Then X := 2;
    IF (InputLength > 79) Then InputLength := 78;
    P := Length(Prompt);
    IF (P > 1) AND (Boxtype > 0) Then    {check and see if prompt is in box}
      Begin
        IF Prompt[1] = Upchar Then
          Begin
            Delete(Prompt,1,1);
            Dec(P);
            InBorder := 1;
          end
        Else
          IF Prompt[1] = DnChar Then
            Begin
              Delete(Prompt,1,1);
              Dec(P);
              InBorder := 2;
            end
          Else
             InBorder := 0;
      End
    Else
      InBorder := 0;
    IF InBorder > 0 Then    {determine dimensions of box}
      Begin
        Width := Succ(InputLength);
      End
    Else Width := Succ(P + InputLength);
    IF Pred(X + Width) > 80 Then X :=  Succ(80 - Width);
    IF BoxType > 0 Then  {draw the box}
      Box(X,Pred(Y),X+Width,Succ(Y),ReadDisplay.BoxFCol,ReadDisplay.BoxBCol,BoxType,False,'');
    IF P > 0 Then    {Draw the prompt}
      Case InBorder OF
        0 : Begin
              IF BoxType> 0 Then
                Fastwrite(Succ(X),Y,Attribute(ReadDisplay.PFcol,ReadDisplay.PBCol),Prompt) {left Justified in upper border}
              Else
                Fastwrite(X,Y,Attribute(ReadDisplay.PFcol,ReadDisplay.PBCol),Prompt);
            End;
        1 : FastWrite(Succ(X),Pred(Y),Attribute(ReadDisplay.PFcol,ReadDisplay.PBCol),Prompt);
        2 : FastWrite(X+Width-P,Succ(Y),Attribute(ReadDisplay.PFcol,ReadDisplay.PBCol),Prompt);{right justified in lower bord}
      End; { Case }
    IF InBorder > 0 Then        {return var X1 adjusted to position of input field}
      Begin
        IF Boxtype > 0 Then X := Succ(X);
      End
    Else
      Begin
        IF Boxtype > 0 Then X := Succ(X) + P
        Else X := X + P;
      End;
  End; { DisplayOutBox }

{----------------------------------------------------------------------------}
{                                                                            }
{ ReadString                                                                 }
{         - Description : This read ANY string                               }
{         - Input       : X --> X coord of first character in field          }
{                         Y --> Y coord of field                             }
{                         MaxLength --> the maximum length of the input field}
{                         Prompt --> what do you want to inform to the user? }
{                         BoxType --> What type of box do you want?          }
{         - Return      : Text --> A input/output variavel                   }
{----------------------------------------------------------------------------}
PROCEDURE ReadString(X,Y,InputLength,MaxStrLength:Byte;Prompt:String;BoxType: byte;Var Text:String);

  Begin
    DisplayOutBox(X,Y,InputLength,Boxtype,Prompt);
    ReadLine(X,Y,InputLength,MaxStrLength,ReadDisplay.FCol,ReadDisplay.BCol,1,Text);
  End; { ReadString }

{----------------------------------------------------------------------------}
{                                                                            }
{ ReadUpCaseString                                                           }
{         - Description : This read ANY string and UpCase it                 }
{         - Input       : X --> X coord of first character in field          }
{                         Y --> Y coord of field                             }
{                         MaxLength --> the maximum length of the input field}
{                         Prompt --> what do you want to inform to the user? }
{                         BoxType --> What type of box do you want?          }
{         - Return      : Text --> A input/output variavel                   }
{----------------------------------------------------------------------------}
PROCEDURE ReadUpCaseString(X,Y,InputLength,MaxStrLength:Byte;Prompt:String;BoxType:Byte;Var Text:String);

  Begin
    Text := UpCaseString(Text);
    DisplayOutBox(X,Y,InputLength,Boxtype,Prompt);
    ReadLine(X,Y,InputLength,MaxStrLength,ReadDisplay.FCol,ReadDisplay.BCol,2,Text);
  End; { ReadUpCaseString }

{----------------------------------------------------------------------------}
{                                                                            }
{ ReadPassword                                                               }
{         - Description : This read a string as a password                   }
{         - Input       : X --> X coord of first character in field          }
{                         Y --> Y coord of field                             }
{                         MaxLength --> the maximum length of the input field}
{                         Prompt --> what do you want to inform to the user? }
{                         BoxType --> What type of box do you want?          }
{         - Return      : Text --> A input/output variavel                   }
{----------------------------------------------------------------------------}
PROCEDURE ReadPassword(X,Y,InputLength,MaxStrLength:Byte;Prompt:String;BoxType:Byte;Var Text:String);

  Begin
    DisplayOutBox(X,Y,InputLength,Boxtype,Prompt);
    ReadLine(X,Y,InputLength,MaxStrLength,ReadDisplay.FCol,ReadDisplay.BCol,11,Text);
  End; { ReadPassword }

{----------------------------------------------------------------------------}
{                                                                            }
{ ReadAlpha                                                                  }
{         - Description : This read only alphabetics                         }
{         - Input       : X --> X coord of first character in field          }
{                         Y --> Y coord of field                             }
{                         MaxLength --> the maximum length of the input field}
{                         Prompt --> what do you want to inform to the user? }
{                         BoxType --> What type of box do you want?          }
{         - Return      : Text --> A input/output variavel                   }
{----------------------------------------------------------------------------}
PROCEDURE ReadAlpha(X,Y,InputLength,MaxStrLength:Byte;Prompt:String;BoxType:Byte;Var Text:String);

  Begin
    DisplayOutBox(X,Y,InputLength,Boxtype,Prompt);
    ReadLine(X,Y,InputLength,MaxStrLength,ReadDisplay.FCol,ReadDisplay.BCol,4,Text);
  End; { ReadAlpha }

{----------------------------------------------------------------------------}
{                                                                            }
{ ReadYN                                                                     }
{         - Description : This read only Y or N                              }
{         - Input       : X --> X coord of first character in field          }
{                         Y --> Y coord of field                             }
{                         MaxLength --> the maximum length of the input field}
{                         Prompt --> what do you want to inform to the user? }
{                         BoxType --> What type of box do you want?          }
{         - Return      : Text --> A input/output variavel                   }
{----------------------------------------------------------------------------}
PROCEDURE ReadYN(X,Y:Byte;Prompt:String;BoxType:Byte;Var Yes:Boolean);

  Var
    Global_Insert : Boolean;
    Txt : String;
    A: Byte;

  Begin
    IF Yes Then
      Txt := 'Y'
    Else
      Txt := 'N';
    Global_Insert := ReadDisplay.Insert;
    ReadDisplay.Insert := False;  {force to overwrite mode}
    A:=1;
    DisplayOutBox(X,Y,A,Boxtype,Prompt);
    ReadLine(X,Y,1,1,ReadDisplay.FCol,ReadDisplay.BCol,3,Txt);
    ReadDisplay.Insert := Global_Insert;    {reset back}
    IF Txt = 'Y' Then
      Yes := True
    Else
      Yes := False;
  End; { ReadYN }

{----------------------------------------------------------------------------}
{                                                                            }
{ ReadNumber                                                                 }
{         - Description : This read a number of type Longint and above       }
{         - Input       : X --> X coord of first character in field          }
{                         Y --> Y coord of field                             }
{                         MaxLength --> the maximum length of the input field}
{                         Prompt --> what do you want to inform to the user? }
{                         BoxType --> What type of box do you want?          }
{                         Min --> Minimal value to read                      }
{                         Max --> Maximal value to read                      }
{         - Return      : Value --> A input/output variavel                  }
{----------------------------------------------------------------------------}
PROCEDURE ReadNumber(X,Y,InputLength,MaxStrLength:Byte;
                     Prompt:String;
                     BoxType: byte;
                     Min, Max : Longint;
                     Var Value : Longint);
  Const
    MaxLongInt:longint  =  2147483647;
    MinLongInt:longint  = -2147483647;

  Var
    Temp : longint;
    Txt : String;
    Valid : boolean;
    Code : integer;
    ChI : char;

  PROCEDURE DisplayInvalidMessage;
    { Internal Rotine to display error message }
    Var
      CursorStatus:Boolean;

    Begin
      CursorStatus:=CursorIsOn;
      CursorOn(False);
      StorePage(ReadStrUnitSaveScreenGroup,1,1,80,25,1);
      BkColor := ReadDisplay.Msg_BCol;
      WriteCenterText(40,ReadDisplay.Msg_Line,ReadDisplay.Msg_Fcol,
                      'Number should be between '+Num2Str(Min)+ ' and '+Num2Str(Max)+' - press any key to resume');
      Repeat Until Keypressed;
      RestorePage(ReadStrUnitSaveScreenGroup,1);
      ReleasePages(ReadStrUnitSaveScreenGroup);
      CursorOn(CursorStatus);
    End; { Internal Rotine DisplayInvalidMessage }

  Begin
    IF Max = 0 Then Max := MaxLongInt;
    IF Min >= Max Then Min := MinLongInt;
    IF (Value < Min) OR (Value > Max) Then Value := Min;
    IF ((Value = 0) AND ReadDisplay.SuppressZero) Then Txt := ''
    Else Txt := Num2Str(Value);
    Temp := Value;
    Valid := False;
    DisplayOutBox(X,Y,InputLength,Boxtype,Prompt);
    Repeat
      ReadLine(X,Y,InputLength,MaxStrLength,ReadDisplay.FCol,ReadDisplay.BCol,5,Txt);
      IF ((R_Char = #027) AND ReadDisplay.AllowEsc) OR ((Txt = '') AND
          (ReadDisplay.AllowNull)) Then
        Begin
          IF Txt = '' Then R_Null := true;
          Exit;
        End
      Else
        Begin
          Val(Txt,Temp,code);
          IF Code <> 0 Then
            Begin
              DisplayInvalidMessage;
              IF ChI = #027 Then Txt := Num2Str(Value);
            End
          Else
            Begin
              IF (Temp < Min) OR (Temp > Max) Then
                Begin
                  DisplayInvalidMessage;
                  IF ChI = #027 Then Txt := Num2Str(Value);
                End
              Else
                Begin
                  Value := temp;
                  Valid := True;
                End;
            End;
        End;
    Until Valid  OR ((R_Char = #027) AND ReadDisplay.AllowEsc);
  End; { ReadNumber }

{ ************************        MAIN         ******************************}
{                         *********************                              }
  Begin
    DefaultSettings;
  End.
