PROGRAM Keyboard_Demo;
Uses
   Crt,Screen, Keyboard;

Const
   TF : Array[0..1] of Boolean = (False,True);

Begin
  Randomize;
  Repeat
    CapsLockOn(TF[Random(2)]);
    Delay(100);
    NumLockOn(TF[Random(2)]);
    Delay(100);
    ScrollLockOn(TF[Random(2)]);
    Delay(100);
  Until Keypressed;
  InitNewKeyInt;
  Repeat
    IF Keydown[scanof('A')] and KeyDown[scanOF('B')] then system.writeln('A e B');
  Until Keydown[scanof('C')];
  SetOldKeyInt;
  repeat
  system.write('gfjh');
  until keypressed;
End.