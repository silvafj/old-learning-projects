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
Program Vesa_Demo_6; { Testing 2D/3D Demo -- Any Object Rotation }

{ The Original Code was made by fh94.3 (C) 1/1/1996                          }

{ I just modified and optimized it to work in all Vesa modes. The final use  }
{ of this code is just to demonstrate my VESA unit.                          }
{  Fernando J.A. Silva  ( ^Magico^ )       15/Oct/1997                                                }

  Uses
    Crt, Keyboard, Vesa;

  Const
    Sin005 : Real = 0.049979169;
    Cos005 : Real = 0.99875026;

  Var
    Ch : Word; { For key you want to press }
    objname: string[20]; { Just a junk }
    Zoom: integer;
    points,lines:word; {nr. of points and lines of the object}
    obj : array[0..255] of real; {object to rotate (max 256 points)}
    lobj: array[0..511] of integer; {line index of object (max 512)}
    xsin,ysin,zsin,xcos,ycos,zcos: real; {some help variables}

PROCEDURE Intro;

  Begin
    Textcolor(15);
    writeln('3d Rotation v0.3 (interactive)');
    writeln('Made by fh94.3 (C) 1/1/1996.');
    writeln('Modified and Optimized to work with VESA modes by ^Magico^ (C) 15/Oct/1997');
    writeln;
    writeln(' Name of object: ',objname);
    writeln(' Nr. of points:  ',points);
    writeln(' Nr. of lines:   ',lines);
    textcolor(7);
    writeln;
    writeln(' Keyz: x      - rotates around X axis,');
    writeln('       y      - rotates around Y axis,');
    writeln('       z      - rotates around Z axis,');
    writeln('       UP     - moves the object up,');
    writeln('       DOWN   - moves the object down,');
    writeln('       LEFT   - moves the object left,');
    writeln('       RIGHT  - moves the object right,');
    writeln('       PGUP   - moves the object to the front,');
    writeln('       PGDOWN - moves the object to the back,');
    writeln('       +      - increases the size of the object,');
    writeln('       -      - decreases the size of the object,');
    writeln('       r      - resets the values.');
    writeln;
    writeln('Press a key to continue ...');
    Repeat Until Keypressed;
  End;

PROCEDURE ReadData;

  Var
    f : Text;
    P,P1 : integer;

  Begin
    IF ParamCount <> 1 Then
      Begin
        writeln('Usage: VDEMO6 datafile');
        halt(0);
      End;
    assign(F,Paramstr(1));
    reset(F);
    readln(F,objname);
    readln(F,points,lines);
    p1:=0;
    FOR P:=1 TO Points DO
      Begin
        readln(F,obj[p1],obj[p1+1],obj[p1+2]);
        p1:=p1+3;
      End;
    p1:=0;
    FOR P:=1 TO Lines DO
      Begin
        readln(F,lobj[p1],lobj[p1+1]);
        p1:=p1+2;
      End;
    Close(F);
  End;

PROCEDURE Draw(color : Byte); { Procedure to draw a cube }

  Var
    sX,sY,sX1,sY1 : Integer;
    P : integer;

  Begin
    FOR P:=0 TO Lines-1 DO
      Begin { loops for all lines }
        sx:=round(zoom*obj[lobj[p*2]*3])+320; {x coord for point1}
        sy:=round(zoom*obj[lobj[p*2]*3+1])+240; {y coord for point1}
        sx1:=round(zoom*obj[lobj[p*2+1]*3])+320; {x coord for point2}
        sy1:=round(zoom*obj[lobj[p*2+1]*3+1])+240; {y coord for point2}
        drawlineClip(SX,SY,sx1,sy1,color); {draw line between points 1&2 in current color}
      End;
  End;

PROCEDURE Calc; {calculates new values after rotate step}

  Var
    Xt,Yt,Zt : Real; { Temp points }
    P : integer;

  Begin
    FOR p:=0 TO points-1 DO
      Begin {repeats for all points}
        Yt := obj[p*3+1] * xCOS - obj[p*3+2] * xsin; {read old values from the table of coord,}
        Zt := obj[p*3+1] * xsin + obj[p*3+2] * xcos; {rotating about x axis}
        obj[p*3+1] := Yt; {writes the new values back to the table}
        obj[p*3+2] := Zt;
        Xt := obj[p*3] * ycos - obj[p*3+2] * ySIN; {same as above, for Y axis}
        Zt := obj[p*3] * ySIN + obj[p*3+2] * yCOS;
        obj[p*3] := Xt;
        obj[p*3+2] := Zt;
        Xt := obj[p*3] * zCOS - obj[p*3+1] * zSIN; {about Z axis}
        Yt := obj[p*3] * zSIN + obj[p*3+1] * zCOS;
        obj[p*3] := Xt;
        obj[p*3+1] := Yt;
      End;
  End;

PROCEDURE Move(xp,yp,zp:real);

  Var
    P : integer;

  Begin
    for p:=0 to points-1 do
      Begin {repeats for all points}
        obj[p*3]:=obj[p*3]+xp; {add xp to the X coord (even if it is less then 0)}
        obj[p*3+1]:=obj[p*3+1]+yp; {add yp to the Y coord}
        obj[p*3+2]:=obj[p*3+2]+zp; {...i think you've got the idea}
      End;
  End;

Begin
  ReadData;
  Intro;
  SetMode($103);
  Zoom := 30; { Size of the object }
  FillScreen(0);
  Draw(15);
  Repeat
    ch := GetScanCodeW;
    draw(0);
    xsin:=0; {'cause sin(0)=0}
    ysin:=0; {...}
    zsin:=0; {...}
    xcos:=1; {'cause cos(0)=1}
    ycos:=1; {...}
    zcos:=1; {...}
    case ch of
      kb_X,
      kb_Shift_x : Begin
                     xsin := sin005; {rotates around X}
	             xcos:=cos005;
                   End;
      kb_Y,
      kb_Shift_y : Begin
                     ysin:=sin005; {...}
	             ycos:=cos005;
                   End;
      kb_Z,
      kb_Shift_z : Begin
                     zsin:=sin005;
	             zcos:=cos005;
                   End;
      kb_plus,
      kb_pad_plus  : zoom:=zoom+5;       {bigger}
      kb_minus,
      kb_pad_minus : zoom:=zoom-5;       {smaller}
      kb_right,
      kb_pad_right : move(0.1,0,0);      {move right}
      kb_up,
      kb_pad_up    : move(0,-0.1,0);     {move up}
      kb_left,
      kb_pad_left  : move(-0.1,0,0);     {move left}
      kb_down,
      kb_pad_down  : move(0,0.1,0);      {move down}
      kb_pgup,
      kb_pad_pgup  : Begin
                       move(0,0,-0.1);
                       zoom:=zoom+5;
                     End; {move to front} {or no?}
      kb_pgdown,
      kb_pad_pgdown : Begin
                        move(0,0,0.1);
                        zoom:=zoom-5;
                      End;  {move to back}
      kb_shift_r,
      kb_r : readdata;           {resets the values}
    End;
    calc;         {calculates the new coords}
    draw(15);     {draws it again}
    delay(20);
  until ch=kb_esc;
  CloseVesaMode;
End.