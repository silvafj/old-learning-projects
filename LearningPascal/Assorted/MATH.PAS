                                                                                (*
        Math Version 0.1 -- Access and Use of VBE 2.0 graphics modes
         Copyright 1995-1997 by Fernando J.A. Silva ( aka ^Magico^ )

                              ...,ooooooooo......
                        .o8888888888888888888888888o.
                    .o888888888888888888888888888888888o.
                  o8888888888A88"V888888888888888888888888o
                o88888887"8"  "   V888  88888888888888888888o
              o88888888            V     888888888888888888888o
             o888888888                   888888888888888888888o
            .88888888888                  88888V"  "V88888888888.
            o88888888888v                 8888"  v8  88888888888o
            88888888888v                  8888v  v88 888888888888
            888888888888                  88888v  "88888888888888
             88888888888V                  V88888v  "88888888888
             88888888888v                            "8888888888
  ____________8888888888888v.........................v888888888_____________
  :::::::::::::::::::::::::'                         :::::::::::::::::::::::
  :::::::::::::::::::::::                .:::::::    .::::::::::::::::::::::
  ::::::::::::::::::::::                 :::::::  .:::::::::::::::::::::::::
  :::::::::::::::::::::                  ::::::  ::: :::::::::::::::::::::::
  :::::::::::::::::::::.                 ::::::. :: .:::::::::::::::::::::::
  ::::::::::::::::::::::                 :::::::.  .::::::::::::::::::::::::
  :::::::::::::::::::::.           .     :::::::::::::::::::::::::::::::::::
  :::::::::::::::::::::          :::.   ::::::::::::::::::::::::::::::::::::
  ::::::::::::::::::::::.::.:: :::::::.:::::::::::::::::::::::::::::::::::::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::Meindert+Stewart::::::

[ From: ian@cs.mcgill.ca (Ian Frederic STEWART)                              ]
[ Ian did, here it is. Nice job.                                             ]

                                                                                *)
Unit Math; { Mathematic rotines Unit }

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE
uses
   strsuse;

CONST
  DaysPerYear = 365;

TYPE
  Month = (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dece);
  Date = RECORD
           da: 1..31;
           mo: Month;
           yr: 1..9999
         END;

VAR
  maxDay: ARRAY [Month] OF INTEGER;
  daysBefore: ARRAY [Month] OF INTEGER;


{ -_-_-_-_-_-_-_-_-_-_-_-_-_-_ Public rotines -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-}

  FUNCTION Power(Base,Expoent:Longint):Longint;
  FUNCTION Bin2Dec(Value:String):Integer;
  FUNCTION Dec2Bin(Value:Longint):String;
  FUNCTION Long2Hex(Num : Longint): String;
  FUNCTION TestBit(Bit:Byte;InValue:Longint;WhatToTest:Byte):Boolean;
  PROCEDURE MonthsInit;
  FUNCTION IsLeapYear (CONST yr: INTEGER): BOOLEAN;
  FUNCTION NumOfDays (CONST D: Date): LONGINT;
  FUNCTION Num_Days (CONST D: STRING): LONGINT;
  FUNCTION Num2Str(Number : Longint):String;
  FUNCTION Str2Num(St : String):Longint;
  FUNCTION DelLeftZeros(St : String):String;
  function  bhex(a:byte):string;
  function  whex(a:word):string;
  function  dhex(a:dword):string;
{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }
IMPLEMENTATION

{----------------------------------------------------------------------------}
{                                                                            }
{ Power                                                                      }
{        - Description : Do the mathematical power function                  }
{        - Input       : Base    --> The base number                         }
{                        Expoent --> The expoent                             }
{        - Return      : The power value                                     }
{----------------------------------------------------------------------------}
FUNCTION Power(Base,Expoent:Longint):Longint;

  Var
    a,b:Integer;

  Begin
    b:=Base;
    FOR a:=1 TO Expoent-1 DO b:=b*Base;
    Power:=b;
    IF Expoent=0 THEN Power:=1;
  End; { Power }

{----------------------------------------------------------------------------}
{                                                                            }
{ Bin2Dec                                                                    }
{         - Description : Converts a Binary 'string' to a decimal 'integer'  }
{                         number                                             }
{         - Input       : Value  --> Binary number to be converted           }
{         - Return      : An integer decimal number is returned              }
{----------------------------------------------------------------------------}
FUNCTION Bin2Dec(Value:String):Integer;

  Var
    a,b,Out,Error:Integer;

  Begin
    Bin2Dec:=0;
    b:=0;
    FOR a:=Length(Value) DOWNTO 1 DO
      Begin
        VAL(Value[Length(Value)-a+1],Out,Error);
        b:=b+Out*Power(2,a-1);
      End;
    Bin2Dec:=b;
  End; { Bin2Dec }

{----------------------------------------------------------------------------}
{                                                                            }
{ Dec2Bin                                                                    }
{         - Description : Converts a Decimal 'Longint' to a Binary 'string'  }
{                         number                                             }
{         - Input       : Value  --> Longint number to be converted          }
{         - Return      : An string binary number is returned                }
{----------------------------------------------------------------------------}
FUNCTION Dec2Bin(Value:Longint):String;

  Var
    TempStr:String;
    TempRes:Longint;
    TempValue:Longint;

  Begin
    Dec2Bin:='';
    TempStr:='';
    TempRes:=0;
    TempValue:=Value;
    Repeat
      TempRes := TempValue MOD 2;
      IF (TempRes <= 1) Then Insert(Num2Str(TempRes),TempStr,1);
      TempValue := TempValue DIV 2;
    Until (TempValue <= 1);
    Insert(Num2Str(TempValue),TempStr,1);
    Dec2Bin:=TempStr;
  End; { Bin2Dec }

{----------------------------------------------------------------------------}
{                                                                            }
{ Long2Hex                                                                   }
{         - Description : Convert any Longint to hex string                  }
{         - Input       : Number  --> The number to convert                  }
{         - Return      : the string containing the number                   }
{----------------------------------------------------------------------------}
FUNCTION Long2Hex(Num : Longint): String;

  Const
    HexChars : Array[0..15] OF Char = '0123456789ABCDEF';

  Var
    TempStr:String;
    TempRes:Longint;
    TempValue:Longint;

  Begin
    Long2Hex:='';
    TempStr:='';
    TempRes:=0;
    TempValue:=Num;
    Repeat
      TempRes := TempValue MOD 16;
      IF (TempRes <= 15) Then Insert(HexChars[TempRes],TempStr,1);
      TempValue := TempValue DIV 16;
    Until (TempValue <= 1);
    Insert(Num2Str(TempValue),TempStr,1);
    Long2Hex:=TempStr;
  End; { Long2Hex }


FUNCTION TestBit(Bit:Byte;InValue:Longint;WhatToTest:Byte):Boolean;

  Var
    TempStr:String;

  Begin
    TempStr:=Dec2Bin(InValue);
    TestBit:=False;
    IF TempStr[Length(TempStr)-Bit]=Num2Str(WhatToTest) Then TestBit:=True;
  End;


PROCEDURE MonthsInit;
VAR mo: Month;
BEGIN
  maxDay [Jan] := 31;
  maxDay [Feb] := 28;  (* adjust for leap years later *)
  maxDay [Mar] := 31;
  maxDay [Apr] := 30;
  maxDay [May] := 31;
  maxDay [Jun] := 30;
  maxDay [Jul] := 31;
  maxDay [Aug] := 31;
  maxDay [Sep] := 30;
  maxDay [Oct] := 31;
  maxDay [Nov] := 30;
  maxDay [Dece] := 31;

  daysBefore [Jan] := 0;
  FOR mo := Jan TO Nov DO
    daysBefore [Month (Ord (mo) + 1) ] := daysBefore [mo] + maxDay [mo]
END;

FUNCTION IsLeapYear (CONST yr: INTEGER): BOOLEAN;
BEGIN
  IsLeapYear := ((yr MOD 4 = 0) AND (yr MOD 100 <> 0)) OR (yr MOD 400 = 0)
END;

FUNCTION NumOfDays (CONST D: Date): LONGINT;
  (* NumOfDays returns an ordinal value for the date
     with January 1, 0001 assigned the value 1.    *)

VAR result, lYr: LONGINT;
BEGIN
  WITH D DO BEGIN
    lYr := yr - 1;
    result := (da);
    Inc (result, daysBefore [mo]);
    Inc (result, lYr * DaysPerYear);
    Inc (result, ((lYr DIV 4) - (lYr DIV 100) + (lYr DIV 400)));
    IF (mo > Feb) AND IsLeapYear (yr) THEN Inc (result)
  END;
  NumOfDays := result
END;

FUNCTION Num_Days (CONST D: STRING): LONGINT;
VAR
  dateRec : Date;
  Tmonth,
  VErr    : INTEGER;
BEGIN
  WITH dateRec DO BEGIN
    Val (Copy (D, 4, 2), da, VErr);
    Val (Copy (D, 1, 2), Tmonth, VErr);
    mo := Month (TMonth - 1);
    Val (Copy (D, 7, 2), yr, VErr);
    if yr >= 80
      then yr := 1900 + yr  {assume 1980-1999, rather than 2080-2099}
      else yr := 2000 + yr
  END;
  Num_Days := NumOfDays (dateRec);
END;

{----------------------------------------------------------------------------}
{                                                                            }
{ Num2Str                                                                    }
{         - Description : Convert any Number to a string                     }
{         - Input       : Number  --> The number to convert                  }
{         - Return      : the string containing the number                   }
{----------------------------------------------------------------------------}
FUNCTION Num2Str(Number : Longint):String;

  Var
    S : String[11];

  Begin
    Str(Number, S);
    Num2Str := S;
  End; { Int2Str }

{----------------------------------------------------------------------------}
{                                                                            }
{ Str2Num                                                                    }
{         - Description : Convert any string type to a number                }
{         - Input       : St  --> The string to convert                      }
{         - Return      : the number                                         }
{----------------------------------------------------------------------------}
FUNCTION Str2Num(St : String):Longint;

  Var
    Out : Longint;
    Code : Integer;

  Begin
    Val(St,Out,Code);
    IF Code = 0 Then Str2Num:=Out;
  End; { Str2Int }

FUNCTION DelLeftZeros(St : String):String;

  Var
    A:Byte;

  Begin
    For A:=1 To Length(St) Do
      IF St[A]='0' Then Delete(St,1,1);
    DelLeftZeros:=St;
  End;

  function  bhex(a:byte):string;
    const
      HexChars:array [$0..$f] of char = '0123456789ABCDEF';
    var
      i:byte;
  begin
    bhex[0]:=#2;
    for i:=1 to 2 do bhex[i]:=hexchars[(a shr (8-i shl 2)) and $f];
  end;

  function  whex(a:word):string;
  begin
    whex:=bhex(byte(a shr 8))+bhex(byte(a));
  end;

  function  dhex(a:dword):string;
  begin
    dhex:=whex(word(a shr 16))+' '+whex(word(a));
  end;

{ ************************        MAIN         ******************************}
{                         *********************                              }
  Begin
  MonthsInit         { for NumDays procedure }
  End.  { End Everything }