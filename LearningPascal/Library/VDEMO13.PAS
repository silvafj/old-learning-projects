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
Program VDemo13;

Uses
   Vesa;

Var
  Mode : Word;

Procedure TestLines;

  Const
    r = 5;
    g = 7;
    b = 11;
    rd = 2;
    gd = 3;
    bd = 4;

  Var
    Pal : PaletteType;
    x1, x2, y1, y2, xd1, xd2, yd1, yd2, c, hue : Integer;

  Begin
    FOR C := 0 TO 127 DO
      Begin
	rd = (r > 61) ? -rd : (r < 2) ? -rd : rd;
	gd = (g > 60) ? -gd : (g < 3) ? -gd : gd;
	bd = (b > 59) ? -bd : (b < 4) ? -bd : bd;
	pal[255 - c][0] = pal[c][0] = (unsigned char)(r += rd);
	pal[255 - c][1] = pal[c][1] = (unsigned char)(g += gd);
	pal[255 - c][2] = pal[c][2] = (unsigned char)(b += bd);
      End;
    x1 = x2 = y1 = y2 = xd1 = xd2 = yd1 = yd2 = rnd(2) + 2;
	while(*((char far*)0x0041000aL) == *((char far*)0x0041000cL))
	{
		c = (c % 255) + 1;
		r = pal[255][0];
		g = pal[255][1];
		b = pal[255][2];
		while(!(inp(0x3da) & 8));
		while(inp(0x3da) & 8);
		for(hue = 255; hue > 0; hue--)
		 Begin
                   SetColor(hue,pal[hue][0] := pal[hue - 1][0]);
			outp(0x3c9, pal[hue][1] = pal[hue - 1][1]);
			outp(0x3c9, pal[hue][2] = pal[hue - 1][2]);
		 End;
		pal[0][0] = (unsigned char)r;
		pal[0][1] = (unsigned char)g;
		pal[0][2] = (unsigned char)b;
		y1 += yd1 = (y1 > 638) ? -(rnd(2) + 2) :
			(y1 < 1) ? rnd(2) + 2 : yd1;
		y2 += yd2 = (y2 > 638) ? -(rnd(2) + 2) :
			(y2 < 1) ? rnd(2) + 2 : yd2;
		x1 += xd1 = (x1 > 478) ? -(rnd(2) + 2) :
			(x1 < 1) ? rnd(2) + 2 : xd1;
		x2 += xd2 = (x2 > 478) ? -(rnd(2) + 2) :
			(x2 < 1) ? rnd(2) + 2 : xd2;
		bresenham_line(y1, x1, y2, x2, c);
	}
}


Begin
  Mode := $103;
  IF Not SetMode(Mode) Then
    Begin
      System.Write('Error setting the mode');
      Halt;
    End;

End.


void bresenham_line(int x, int y, int x2, int y2, int c)
{
	int i, steep = 0, sx, sy, dx, dy, e, ex, ey;
	dx = abs(x2 - x);
	sx = ((x2 - x) > 0) ? 1 : -1;
	dy = abs(y2 - y);
	sy = ((y2 - y) > 0) ? 1 : -1;
	if(dy > dx)
	{
		steep =  x;
		x =  y;
		y = steep;  /* swap  x and  y */
		steep = dx;
		dx = dy;
		dy = steep;  /* swap dx and dy */
		steep = sx;
		sx = sy;
		sy = steep;  /* swap sx and sy */
		steep = 1;
	}
	e = 2 * dy - dx;
	ex = dx << 1;
	ey = dy << 1;
	for(i = 0; i < dx; i++)
	{
		if(steep)
			plotdot(y, x, c);
		else
			plotdot(x, y, c);
		while(e >= 0)
		{
			y += sy;
			e -= ex;
		}
		x += sx;
		e += ey;
	}
	plotdot(x2, y2, c);
}
int rnd(int max)
{
	return (int) ( ((long)rand() * (long)max) / RAND_MAX);
}
void testlines(void)
{
	unsigned char pal[256][3];
	int x1, x2, y1, y2, xd1, xd2, yd1, yd2, c, hue,
		r = 5, g = 7, b = 11, rd = 2, gd = 3, bd = 4;
	for(c = 0; c < 128; c++)
	{
		rd = (r > 61) ? -rd : (r < 2) ? -rd : rd;
		gd = (g > 60) ? -gd : (g < 3) ? -gd : gd;
		bd = (b > 59) ? -bd : (b < 4) ? -bd : bd;
		pal[255 - c][0] = pal[c][0] = (unsigned char)(r += rd);
		pal[255 - c][1] = pal[c][1] = (unsigned char)(g += gd);
		pal[255 - c][2] = pal[c][2] = (unsigned char)(b += bd);
	}
	x1 = x2 = y1 = y2 = xd1 = xd2 = yd1 = yd2 = rnd(2) + 2;
	while(*((char far*)0x0041000aL) == *((char far*)0x0041000cL))
	{
		c = (c % 255) + 1;
		r = pal[255][0];
		g = pal[255][1];
		b = pal[255][2];
		while(!(inp(0x3da) & 8))
		;
		while(inp(0x3da) & 8)
		;
		for(hue = 255; hue > 0; hue--)
		{
			outp(0x3c8, hue);
			outp(0x3c9, pal[hue][0] = pal[hue - 1][0]);
			outp(0x3c9, pal[hue][1] = pal[hue - 1][1]);
			outp(0x3c9, pal[hue][2] = pal[hue - 1][2]);
		}
		pal[0][0] = (unsigned char)r;
		pal[0][1] = (unsigned char)g;
		pal[0][2] = (unsigned char)b;
		y1 += yd1 = (y1 > 638) ? -(rnd(2) + 2) :
			(y1 < 1) ? rnd(2) + 2 : yd1;
		y2 += yd2 = (y2 > 638) ? -(rnd(2) + 2) :
			(y2 < 1) ? rnd(2) + 2 : yd2;
		x1 += xd1 = (x1 > 478) ? -(rnd(2) + 2) :
			(x1 < 1) ? rnd(2) + 2 : xd1;
		x2 += xd2 = (x2 > 478) ? -(rnd(2) + 2) :
			(x2 < 1) ? rnd(2) + 2 : xd2;
		bresenham_line(y1, x1, y2, x2, c);
	}
}
void Vmode(int m)
{
	_asm{
		mov ax, m;
		int 10h;
	}
}
void vesamode(int mode)
{
	_asm {
		mov ax, 4F02h;
		mov bx, mode;
		int 10h;
	}
}
int main(void)
{
	srand((unsigned)time(NULL));
	vesamode(0x101);
	testlines();
	getch();
	Vmode(0x03);
	return 0;
}
/*_|_|   end   SVGA_XTC.C   */

