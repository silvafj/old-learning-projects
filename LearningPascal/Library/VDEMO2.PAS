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
Program Vesa_Demo_2; { Testing Modes Colors Demo }

  Uses
    Crt, Math, Screen, Vesa, Keyboard;

  Var
    Mode : Word;

PROCEDURE TestingBanks;

  Var
    A : Byte;
    ch : word;

  Begin
    FOR A := 0 TO VesaInfo.TotalMemory DO
      Begin
        SetBank(A);
        Fillchar(Mem[VesaMode.SegA:0000], $FFFF, 15+A*2);
      End;
    Repeat
      Ch := getscancodew;
    Until ch=kb_esc;
    CloseVesaMode;
  End;

PROCEDURE Show256Colors;

  Var
    X,Y : Integer;
    Ch : Word;

  Begin
    clrscr;
    writeln('Testing VESA mode 640x480 256 colors');
    writeln('Press a key ...');
    repeat until keypressed;
    mode := $101;
    { 101   640*480  8 bits }
    { 103   800*600  8 bits }
    { 105  1024*768  8 bits }
    SetMode(mode);
    delay(2000);
    for x:=0 to 255 do
    for y:=0 to 255 do Drawpixel(x,y,x);
    CloseVesaMode;
    system.writeln('Mode VESA 101h OK : Press Esc key to quit ...');
  repeat
    ch := getscancodew;
  until ch=kb_esc;
End;

var
  ch : word;

Begin
  Mode := $110;
  Setmode(Mode);
  TestingBanks;
  Show256Colors;
End.

