Program VBETest1;

Uses
  crt,Dpmi,Vbe20, Math;

  const
    MaxX = 640;
    MaxY = 480;
    MaxColor = {32278}256;

  var
    a,c : integer;
    b:longint;
    rx,ry,r,x,y,x1,y1,x2,y2 : word;
    color : longint;

{
    axreg, bxreg, sireg : word;
    clreg, dhreg, dlreg : byte;
}

Begin
   randomize;
   VBEInit(640,480,8);
   InitFramesCounter;
    Repeat

      x := random(MaxX);
      y := random(MaxY);
      color := random(MaxColor);

      DrawPixel(x,y,color);

{
      x1 := random(MaxX);
      y1 := random(MaxY);
      x2 := random(MaxX);
      y2 := random(MaxY);
      color := random(MaxColor);
      drawline(x1,y1,x2,y2,color);
}
{
      drawline(1,1,x,y,color);
      drawline(MaxX,1,MaxX-x,MaxY-y,color);
      drawline(1,MaxY,MaxX-x,MaxY-y,color);
      drawline(MaxX,MaxY,MaxX-x,MaxY-y,color);
}
{
      x1 := random(MaxX);
      y1 := random(MaxY);
      x2 := random(MaxX);
      y2 := random(MaxY);
      color := random(MaxColor);
      DrawRectangle(X1,Y1,X2,Y2,Color);
}
{
      x1 := random(MaxX);
      y1 := random(MaxY);
      r := random(MaxX);
      color := random(MaxColor);
      DrawCircle(X1,Y1,r,Color);
}
{
      x1 := random(MaxX);
      y1 := random(MaxY);
      rx := random(MaxX);
      ry := random(MaxY);
      color := random(MaxColor);
      DrawEllipse(rx,ry,x1, y1,color);
}
      CheckFramesCounter;
    Until keypressed;
    CloseVbeMode;
    write(StopFramesCounter(b,c):3:2);
(*
    asm
      mov     ax, 1687h
      int     2Fh
      mov     axreg, ax
      mov     bxreg, bx
      mov     clreg, cl
      mov     dhreg, dh
      mov     dlreg, dl
      mov     sireg, si
    end;
    write('DPMI Detected : ');
    IF axreg = 0 then writeln('YES')
    Else writeln('NO');
    write('32-bit programs supported : ');
    IF Testbit(0,bxreg,1) Then writeln('YES')
    Else writeln('NO');
    write('Processor type : ');
    writeln(clreg);
    write('DPMI Version : ');
    writeln(dhreg,'.',dlreg);
    write('number of paragraphs of DOS extender private data : ');
    writeln(sireg);
    asm
      mov    ax,$1686
      int    $2f
      mov    axreg,ax
    end;
    write('Is operating under DPMI : ');
    IF axreg = 0 then writeln('YES')
    Else writeln('NO');
    asm
      mov    ax,$F100
      int    $2F
      mov    axreg,ax
    end;
    write('DOS Extender present : ');
    IF axreg = $FF then writeln('YES')
    Else writeln('NO');
*)
End.