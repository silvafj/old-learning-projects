Program StrsUseDemo;

Uses
  Screen,Keyboard,StrsUse;

CONST
     inp='ABCDEFGHI';
VAR
    r:REAL;

BEGIN
 ClrScr;
 WRITELN('encoding string    : ',inp);
 r:=Encode(inp);
 WRITELN('string is encoded by ',r);
 WRITELN('decoding of r gives: ',Decode(r,Length(inp)));
 repeat until keypressed;
END.
