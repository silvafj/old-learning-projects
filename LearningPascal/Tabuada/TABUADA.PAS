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
{$M 2000,0,0}
{$N+} { Numeric Coprocessor Switch }
{$Q-} { Overflow Checking Switch }
{$R-} { Range-Checking Switch }
{$S-} { Stack-Overflow Checking Switch }
{$V-} { Var-String Checking Switch }
{$Y+} { Symbol Reference Information Switch - just afect the Unit size, and }
      { it's very good when you run BP, because you can go directly to the  }
      { line where the source begins! Study, to know more!!!                }
Program Tabuada;
Uses
  Screen,Math;

Var
  a : string[3];
  b : byte;
  c,d,e : byte;

Begin
  ClrScr;
  Randomize;
  Repeat
    c := Random(10);
    d := Random(10);
    e := c * d;
    system.write(c,' * ',d,' = ');
    Readln(a);
    b := Str2Num(a);
    IF b = e Then system.writeln('     Certo')
    Else system.writeln('     Errado. Resposta : ',e);
    IF WhereY = 25 Then ClrScr;
    IF a = 'esc' Then
      Begin
        ClrScr;
        Halt;
      End;
  Until a = 'esc';
End.