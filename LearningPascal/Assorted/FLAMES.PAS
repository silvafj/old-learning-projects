Program Flames;

  uses
    Crt, Vbe20;

  const
    altura = 100;
    comprimento = 30;
    StartX = 320;
    StartY = 140;

  var
    c, x, y, z, key : Word;

begin
  randomize;
  VBEInit(800,600,8);
  for x := 1 to 32 do
    begin
      setcolor(x,   x*2-1, 0,     0    );
      setcolor(x+32, 63,   x*2-1, 0    );
      setcolor(x+64, 63,   63,    x*2-1);
      setcolor(x+96, 63,   63,    63   );
    end;
  repeat
    x := StartX;
    repeat
      y := StartY;
      repeat
        c := (getpixel(x,y)+getpixel(x+1,y)+getpixel(x-1,y)+getpixel(x,y+1)) DIV 4;
        if c <> 0 then dec(c);
        drawpixel(x,y-1,(c shl 8) + c);
        drawpixel(x,y,(c shl 8) + c);
        Inc(Y,1);
      until y > StartY + altura;
      Dec(y,1);
      drawpixel(x,y,random(2) * 160);
      Inc(X,1);
    until x >= StartX + comprimento;
  until keypressed;
  CloseVbeMode;
end.
