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
{$Y+} { Symbol Reference Information Switch - just afect the Unit size, and  }
      { it's very good when you run BP, because you can go directly to the   }
      { line where the source begins! Study, to know more!!!                 }
Program Vesa_Demo_9; { Testing 2D/3D Demo -- Stars III (Classic StarField) }

  Uses
    Crt, Vesa;

  Const
    MaxStars = 200;
    Distance = 2048;

  Var
    Std,ScrnX,ScrnY,ScrnC,Z : Array [1..MaxStars] OF Word;
    X,Y : Array [1..MaxStars] OF Integer;
    I : Word;

PROCEDURE Init;

  Begin
    FOR I := 1 TO MaxStars DO
      Begin
        X[I] := Random(1000)-500;
        Y[I] := Random(800)-500;
        Z[I] := Random(Distance);
        STD[I] := Round(SQR(X[I])+SQR(Y[I]));
      End;
    Port[$3C8]:=1;
    FOR I := 1 TO 255 DO
      Begin
        Port[$3C9] := Round((256-I)/4);
        Port[$3C9] := Round((256-I)/4);
        Port[$3C9] := Round((256-I)/4);
      End;
  End;

PROCEDURE ResetStar;

  Begin
    Z[I] := Distance;
    X[I] := Random(1000)-500;
    Y[I] := Random(800)-500;
    STD[I] := Round(SQR(X[I])+SQR(Y[I]));
  End;

PROCEDURE MoveStars;

  Begin
    Repeat
      FOR I := 1 TO MaxStars DO
        Begin
          DrawPixel(ScrnX[I],ScrnY[I],0);
          Dec(Z[I]);
          IF Z[I] < 2 Then ResetStar;
          ScrnX[I] := (300*X[I]) DIV Z[I]+320;
          ScrnY[I] := (300*Y[I]) DIV Z[I]+240;
          IF ScrnX[I] > 640 Then ResetStar;
          IF ScrnY[I] > 480 Then ResetStar;
          IF ScrnX[I] < 0 Then ResetStar;
          IF ScrnY[I] < 0 Then ResetStar;
          ScrnC[I] := Round(SQRT(SQR(Z[I])+STD[I]) / 9)+1;
          DrawPixel(ScrnX[I],ScrnY[I],ScrnC[I]);
        End;
    Until KeyPressed;
  End;

Begin
  SetMode($103);
  Init;
  MoveStars;
  CloseVesaMode;
End.

{
From: JUSTIN GREER

> I have recently coded a program that gives a three layer starfield
> moving only accross the monitor.  I am looking for some code that
> will give a 'warp' kinda feeling. (The stars coming at you, like that
> windows screen saver.)  Any help, even just some mathematics would be
> greatly appriciated.
> Thanks

Well, a while ago I wrote one of these that seems to work real well...
I just spent a half-hour or so doing it, because the only ones I had
were in future crew type demos, and I wanted a screen saver one... Here
ya' go:

Here's a program I've been working on a little lately--It shows
a 3D star field with 256 colors used.  I haven't seen this particular
type of star program anywhere outside of demos and things, and I thought
it might be helpful.  I haven't had time to really optimize it yet,
and it is pretty math-intensive, so it's not the fastest thing in the
world (even though it's a little too fast on my 486dx2/66 =|).
You can shange most of the variables in the program for different
effects--Things like the maximum stars and stuff.  I am running TP7, and
I have not tried this with other versions, but it should work fine
as far as I know.
}

