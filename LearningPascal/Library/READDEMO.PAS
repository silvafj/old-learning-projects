Program Demo;

Uses
  StrsUse,Screen,Keyboard,Readstr;

var
  Value : String;

Begin
  clrscr;  { X,Y,L,Max .... }
  Value:='Isto ‚ um teste!!!!';
  ReadString(10,5,20,255,'Introduza a string : ',1,Value);
  BkColor:=0;
  write(1,15,15,Value);
  repeat until keypressed;
End.