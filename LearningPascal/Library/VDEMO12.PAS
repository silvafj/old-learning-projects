{$A+,B-,D-,E+,F-,G+,I-,L-,N-,O-,P-,Q-,R-,S-,T-,V-,X+,Y-}
{$M 16384,0,655360}

Uses Crt,vesa;

Var
   CTab                         : Array [0..255] of Byte;    { Cosinus table }
   Pos1,Pos2,Pos3,Pos4          : Byte;												{ Current positions }
   Time                         : Longint Absolute $0000:$046c;
   StartTime,EndTime,Frames     : Longint;

{ 2*2 Pixel setzen }
{
Procedure QPixel(x,y:Word;c:Byte);Assembler;
Asm
   mov   ax, $A000
   mov   es, ax
   mov   bx, [y]
   shl   bx, 1
   mov   di, word ptr [YOffset+bx]
   add   di, [x]
   mov   al, [c]
   mov   es:[di], al
   mov   es:[di+1], al
   mov   es:[di+320], al
   mov   es:[di+321], al
End;

{ Converts degrees to radians }

Function Rad(theta:Real):Real;
Begin
     rad:=theta*pi/180
End;

{ Initializes plasma colors and look-up table }

procedure setcol(color,r,g,b : byte);
begin
     port[$3c8]:=color;
     port[$3c9]:=r;
     port[$3c9]:=g;
     port[$3c9]:=b;
end;

Procedure InitPlasma;
Var
   i    : Byte;
Begin
     SetMode($103);
     For pos1:=0 to 127 do
         SetCol(pos1,pos1 shr 1,0,0);
     For pos1:=0 to 127 do
         SetCol(255-pos1,pos1 shr 1,0,0);
     { Set up cosinus look-up table }
     For i:=0 to 255 do
         CTab[i]:=Round(Sin(Rad(i/360*255*2))*31)+32;
End;

{ Draws the plasma on screen }
Procedure DrawPlasma;
Var
   i,j,color,tpos1,tpos2,tpos3,tpos4    : byte;
Begin
     tpos3:=pos3;
     tpos4:=pos4;
     For i:=0 to 159 do
     Begin
          tpos1:=pos1;
          tpos2:=pos2;
          For j:=0 to 99 do
          Begin
               color:=CTab[tpos1]+CTab[tpos2]+CTab[tpos3]+CTab[tpos4]+
                      CTab[i]+CTab[j];
               DrawPixel(i shl 1,j shl 1,color);
               Inc(tpos1,7);
               Inc(Tpos2,4);
          End;
          Inc(tpos3,6);
          Inc(Tpos4,2);
     End;
End;


{ Main plasma routine }

Procedure DoPlasma;
Var
   i    : Byte;
Begin
     { Do the plasma thing }
     Frames:=0;StartTime:=Time;
     Repeat
           Inc(Frames);
           DrawPlasma;
           { Move the plasma left/right/up/down }
           Dec(Pos1,4);
           Inc(Pos3,4);
           Inc(Pos1,Random(1));
           Inc(Pos2,Random(2));
           Inc(Pos3,Random(1));
           Inc(Pos4,Random(2));
	   Retrace; { Use this if you have flicker! }
     Until Keypressed;
     EndTime:=Time;
     While Keypressed do
           Readkey;
     SetMode($3);
     WriteLn((Frames*18.2)/(EndTime-StartTime):2:2,' Frames/s');
End;

Begin
     InitPlasma;
     DoPlasma;
End.