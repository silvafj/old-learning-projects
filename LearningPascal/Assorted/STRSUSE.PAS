{$A+} { Align Data Switch }
{$B-} { Boolean Evaluation Switch }
{$D-} { Debug Information Switch }
{$F-} { Force Far Calls Switch }
{$I-} { Input/Output-Checking Switch }
{$L-} { Local Symbol Information Switch }
{$Q-} { Overflow Checking Switch }
{$R-} { Range-Checking Switch }
{$S-} { Stack-Overflow Checking Switch }
{$V-} { Var-String Checking Switch }
Unit StrsUse;

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE

{ Public rotines }
  FUNCTION FirstCapitalPos(Str:string): byte;
  FUNCTION FirstCapital(Str:string): char;
  FUNCTION WordCnt(Str:String):byte;
  FUNCTION PosWord(Wordno:byte;Str:string):byte;
  FUNCTION ExtractWords(StartWord,NoWords:byte;Str:String):String;
  Function PadLeft(Str:string;Size:byte;Pad:char):string;
  Function PadCenter(Str:string;Size:byte;Pad:char):string;
  Function PadRight(Str:string;Size:byte;Pad:char):string;
  Function LastPos(C:Char;Str:string):byte;
  Function FindCharPos(C:Char;Number:byte;Str:String):byte;
  Function ChangeString(InputStr,BeforeStr,AfterStr:String):String;
  FUNCTION Replicate(N : byte; Character:char): String;
  FUNCTION UpCase(Ch:Char):Char;
  FUNCTION UpCaseString(S:String):String;
 FUNCTION Encode(CONST s:STRING):REAL;
 FUNCTION Decode(x:REAL; n:BYTE):STRING;

{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }
IMPLEMENTATION

CONST charSet:STRING='ABCDEFGHIJKLMNOPQRSTUVWXYZ ';
      size=27; {=Length(charSet)}
      p:ARRAY[1..size] OF REAL=  (* found empirically *)
       (
        6.1858296469E-02,
        1.1055412402E-02,
        2.6991022453E-02,
        2.6030374520E-02,
        9.2418577127E-02,
        2.1864028512E-02,
        1.4977615842E-02,
        2.8410764564E-02,
        5.5247871050E-02,
        1.3985123226E-03,
        3.8001321554E-03,
        3.2593032914E-02,
        2.1919756707E-02,
        5.2434924064E-02,
        5.7837905257E-02,
        2.0364674693E-02,
        1.0031075103E-03,
        4.9730779744E-02,
        4.8056280170E-02,
        7.2072478498E-02,
        2.0948493879E-02,
        8.2477728625E-03,
        1.0299101184E-02,
        4.7873173243E-03,
        1.3613601926E-02,
        2.7067980437E-03,
        2.3933136781E-01
       );
VAR   psum:ARRAY[1..size] OF REAL;
      i,j:INTEGER;

{----------------------------------------------------------------------------}
{                                                                            }
{ FirstCapitalPos                                                            }
{           - Description : Returns the position of the first capital letter }
{                           in a string                                      }
{           - Input       : Str --> String                                   }
{           - Return      : The position of the first capital letter, return }
{                           0 if didn't find a capital letter in the string  }
{----------------------------------------------------------------------------}
FUNCTION FirstCapitalPos(Str : String): Byte;

  Var
    StrPos : byte;

  Begin
    StrPos := 1;
    While (StrPos <= length(Str)) AND ((Str[StrPos] IN ['A'..'Z']) = false) DO
      StrPos := Succ(StrPos);
    IF StrPos > Length(Str) Then FirstCapitalPos  := 0
    Else FirstCapitalPos := StrPos;
  End; { FirstCapitalPos }

{----------------------------------------------------------------------------}
{                                                                            }
{ FirstCapital                                                               }
{           - Description : Returns the first capital letter in a string     }
{           - Input       : Str --> String                                   }
{           - Return      : The first capital letter, return #0 if didn't    }
{                           find a capital letter in the string              }
{----------------------------------------------------------------------------}
FUNCTION FirstCapital(Str : String): Char;

  Var
    B : byte;

  Begin
    B := FirstCapitalPos(Str);
    IF B > 0 Then FirstCapital := Str[B]
    Else FirstCapital := #0;
  End; { FirstCapital }

{----------------------------------------------------------------------------}
{                                                                            }
{ WordCnt                                                                    }
{           - Description : Returns the value of words in a string           }
{           - Input       : Str --> String                                   }
{           - Return      : The number of words                              }
{----------------------------------------------------------------------------}
FUNCTION WordCnt(Str:String):byte;

  Var
    W,I: integer;
    SpaceBefore: boolean;

  Begin
    IF Str = '' Then
      Begin
        WordCnt := 0;
        Exit;
      End;
    SpaceBefore := True;
    W := 0;
    FOR  I :=  1 TO Length(Str) DO
      Begin
        IF SpaceBefore AND (Str[I] <> ' ') Then
          Begin
            Inc(W);
            SpaceBefore := False;
          End
        Else
          IF (SpaceBefore = False) AND (Str[I] = ' ') Then SpaceBefore := True;
      End;
    WordCnt := W;
  End;  { WordCnt }

{----------------------------------------------------------------------------}
{                                                                            }
{ LocWord  ( Unit Internal Rotine )                                          }
{           - Description : Locates a Word                                   }
{           - Input       : StartAT -->                                      }
{                           WordNo -->                                       }
{                           Str --> String                                   }
{           - Return      : The localization of the word                     }
{----------------------------------------------------------------------------}
FUNCTION LocWord(StartAT,Wordno:byte;Str:string):Byte;

  Var
    W,L: integer;
    Spacebefore: boolean;

  Begin
    IF (Str = '') OR (WordNo < 1) OR (StartAT > Length(Str)) Then
      Begin
        LocWord := 0;
        Exit;
      End;
    SpaceBefore := True;
    W := 0;
    L := Length(Str);
    Dec(StartAT);
    While (W < Wordno) AND (StartAT <= Length(Str)) DO
      Begin
        Inc(StartAT);
        IF SpaceBefore AND (Str[StartAT] <> ' ') Then
          Begin
            W := succ(W);
            SpaceBefore := false;
          End
        Else
          IF (SpaceBefore = false) AND (Str[StartAT] = ' ') Then SpaceBefore := True;
      End;
    IF W = Wordno Then LocWord := StartAT
    Else LocWord := 0;
  End; { LocWord }

{----------------------------------------------------------------------------}
{                                                                            }
{ PosWord                                                                    }
{           - Description : Returns the position of a word in a string       }
{           - Input       : WordNo --> Word Number?                          }
{                           Str --> String                                   }
{           - Return      : The Word position                                }
{----------------------------------------------------------------------------}
FUNCTION PosWord(Wordno:byte;Str:string):byte;

  Begin
    PosWord := LocWord(1,Wordno,Str);
  End;  { PosWord }

{----------------------------------------------------------------------------}
{                                                                            }
{ ExtractWords                                                               }
{           - Description : Extracts a string containing a specified number  }
{                           of words                                         }
{           - Input       : StartWord --> The word to start extracring       }
{                           NoWords --> The number of words to extract       }
{                           Str --> String                                   }
{           - Return      : The Words extracted                              }
{----------------------------------------------------------------------------}
FUNCTION ExtractWords(StartWord,NoWords:byte;Str:String):String;

  Var
    Start, finish : integer;

  Begin
    IF Str = '' Then
      Begin
        ExtractWords := '';
        Exit;
      End;
    Start := LocWord(1,StartWord,Str);
    IF Start <> 0 Then Finish := LocWord(Start,succ(NoWords),Str)
    Else
      Begin
        ExtractWords := '';
        Exit;
      End;
    IF Finish <> 0 Then
      Repeat
        Dec(finish);
      Until Str[finish] <> ' '
    Else
      Finish := Length(Str);
    ExtractWords := copy(Str,Start,succ(finish-Start));
  End;  { ExtractWords }

Function PadLeft(Str:string;Size:byte;Pad:char):string;
var temp : string;
begin
    Fillchar(Temp[1],Size,Pad);
    Temp[0] := chr(Size);
    If Length(Str) <= Size then
       Move(Str[1],Temp[1],length(Str))
    else
       Move(Str[1],Temp[1],size);
    PadLeft := Temp;
end;

Function PadCenter(Str:string;Size:byte;Pad:char):string;
var temp : string;
L : byte;
begin
    Fillchar(Temp[1],Size,Pad);
    Temp[0] := chr(Size);
    L := length(Str);
    If L <= Size then
       Move(Str[1],Temp[((Size - L) div 2) + 1],L)
    else
       Move(Str[((L - Size) div 2) + 1],Temp[1],Size);
    PadCenter := temp;
end; {center}

Function PadRight(Str:string;Size:byte;Pad:char):string;
var
  temp : string;
  L : integer;
begin
    Fillchar(Temp[1],Size,Pad);
    Temp[0] := chr(Size);
    L := length(Str);
    If L <= Size then
       Move(Str[1],Temp[succ(Size - L)],L)
    else
       Move(Str[1],Temp[1],size);
    PadRight := Temp;
end;

Function LastPos(C:Char;Str:string):byte;
Var I : byte;
begin
    I := succ(Length(Str));
    Repeat
         I := Pred(I);
    Until (I = 0) or (Str[I] = C);
    LastPos := I;
end;  {Func LastPos}

Function FindCharPos(C:Char;Number:byte;Str:String):byte;

  Var
    A,I : byte;

  Begin
    I := 0;
    For A:=1 TO Number DO
      Begin
        Repeat
          Inc(I);
        Until (I = Length(Str)) or (Str[I] = C);
      End;
    FindCharPos := I;
  End;  { FindCharPos }

Function ChangeString(InputStr,BeforeStr,AfterStr:String):String;

  Var
    Position:Byte;

  Begin
    Position:=Pos(BeforeStr,InputStr);
    Delete(InputStr,Position,Length(BeforeStr));
    Insert(AfterStr,InputStr,Position);
    ChangeString := InputStr;
  End; { ChangeString }

{----------------------------------------------------------------------------}
{                                                                            }
{ Replicate                                                                  }
{              - Description : Create a string with a Char replicated        }
{                              a determined value                            }
{              - Input       : N --> The number of times to repeat the Char  }
{                              Character --> The char                        }
{              - Return      : The string created                            }
{----------------------------------------------------------------------------}
FUNCTION Replicate(N : byte; Character:char): String;

  Var
    TempStr : String;

  Begin
    IF N = 0 Then
      TempStr := ''
   Else
     Begin
       IF (N > 80) Then
         N := 1;
       FillChar(Tempstr,N+1,Character);
       Tempstr[0] := Chr(N);
     End;
    Replicate := Tempstr;
  End; { Replicate }

{----------------------------------------------------------------------------}
{                                                                            }
{ UpCase                                                                     }
{        - Description : Returns the UpCase of a char                        }
{        - Input       : Ch --> Input Char                                   }
{        - Return      : A upcased char...                                   }
{----------------------------------------------------------------------------}
FUNCTION UpCase(Ch:Char):Char;

  Begin
    Case ch OF
      'a'..'z' : UpCase := System.UpCase(ch);
      '‡': UpCase:='€';
      ' ': UpCase:='µ';
      '‚': UpCase:='';
      '¡': UpCase:='Ö';
      '¢': UpCase:='à';
      '£': UpCase:='é';
      '…': UpCase:='·';
      'Š': UpCase:='Ô';
      '': UpCase:='Þ';
      '•': UpCase:='ã';
      '—': UpCase:='ë';
      'ƒ': UpCase:='¶';
      'ˆ': UpCase:='Ò';
      'Œ': UpCase:='×';
      '“': UpCase:='â';
      '–': UpCase:='ê';
      'Æ': UpCase:='Ç';
      'ä': UpCase:='å';
      '„': UpCase:='Ž';
      '‰': UpCase:='Ó';
      '‹': UpCase:='Ø';
      '”': UpCase:='™';
      '': UpCase:='š';
      Else UpCase:=Ch;
    End; { Case }
  End; { UpCase }

{----------------------------------------------------------------------------}
{                                                                            }
{ UpCaseString                                                               }
{              - Description : Returns the UpCase of a string                }
{              - Input       : S --> Input string                            }
{              - Return      : A upcased string...                           }
{----------------------------------------------------------------------------}
FUNCTION UpCaseString(S:String):String;

  Var
    I : Byte;

  Begin
    FOR I := 1 TO Length(s) DO S[I] := UpCase(S[I]);
    UpCaseString:=S;
  End; { UpCaseString }

{
Hello Thomas,

On 26.06.94 you wrote in area PASCAL to subject "Arithmetic compression":
TW> But where can we get a discription of this compression method ??
  Michael  Barnsley, Lyman Hurd, "Fractal Image Compression", AK Peters,
  1993
  Mark Nelson, "The Data Compression Book", M&T Books, 1991
  Ian  Witten,  Radford  Neal,  John Cleary, "Arithmetic Coding for Data
  Compression", CACM, Vol. 30, No.6, 1987

  Below  is a small source from the 1st book, translated into Pascal and
  adopted  to  work  on  the uppercase alphabet to demonstrate the basic
  principles.
  For  a  simple  explanation, the program uses the letters of the input
  string  to "drive" the starting point through the real interval 0.0 ..
  1.0
  By  this process, every possible input string stops at a unique point,
  that  is:  a  point  (better: a small interval section) represents the
  whole  string.  To  _decode_  it, you have to reverse the process: you
  start  at  the  given  end point and apply the reverse transformation,
  noting  which intervals you are touching at your voyage throughout the
  computation.
  Due  to the restricted arithmetic resolution of any computer language,
  the  max.  length of a string will be restricted, too (try it out with
  TYPE   REAL=EXTENDED,  for  example);  this  happens  when  the  value
  "underflows" the computers precision. }
 FUNCTION Encode(CONST s:STRING):REAL;
 VAR i,po:INTEGER;
     offset,len:EXTENDED;
 BEGIN
  offset:=0.0;
  len:=1.0;
  FOR i:=1 TO Length(s) DO
   BEGIN
    po:=POS(s[i],charSet);
    IF po<>0
     THEN BEGIN
           offset:=offset+len*psum[po];
           len:=len*p[po]
          END
     ELSE BEGIN
           WRITELN('only input chars ',charSet,' allowed!');
           Halt(1)
          END;
   END;
  Encode:=offset+len/2;
 END;

 FUNCTION Decode(x:REAL; n:BYTE):STRING;
 VAR i,j:INTEGER;
     s:STRING;
 BEGIN
  IF (x<0.0) OR (x>1.0)
   THEN BEGIN
         WRITELN('must lie in the range [0..1]');
         Halt(1)
        END;
  FOR i:=1 TO n DO
   BEGIN
    j:=size;
    WHILE x<psum[j] DO DEC(j);
    s[i]:=charSet[j];
    x:=x-psum[j];
    x:=x/p[j];
   END;
  s[0]:=CHR(n);
  Decode:=s
 END;

{ ************************        MAIN         ******************************}
{                         *********************                              }
  Begin
 FOR i:=1 TO size DO
  BEGIN
   psum[i]:=0.0;
   FOR j:=1 TO i-1 DO
    psum[i]:=psum[i]+p[j];
  END;
  End.
