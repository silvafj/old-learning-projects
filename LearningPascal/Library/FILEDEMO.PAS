
Program Demo;
{$D Demo Program -- Copyright (c) 1995-1997 by Fernando J.A. Silva}

Uses
   dos,StrsUse,Screen,Keyboard,Files;

VAR
   a:integer;
   chosen_file:String;
   errcode:integer;
   regs:registers;

Begin
  clrscr;
{   system.write('Exist DEMO.PAS file : ');
  system.writeln(existfile('Demo.pas'));
  system.writeln('DEMO.PAS has : '+Num2Str(FileSize('demo.pas'))+' bytes');
  system.write('Copying DEMO.PAS --> DEMOTEST.PAS : ');
  Case copyfile('demo.pas','demotest.pas') OF
    0 : system.writeln('OK');
    1 : system.writeln('Source and target are the same');
    2 : system.writeln('Cannot open source file');
    3 : system.writeln('Unnable to create target file');
    4 : system.writeln('Error during copy');
  End;
  system.write('Exist DEMOTEST.PAS file : ');
  system.writeln(existfile('demotest.pas'));
  system.writeln('DEMOTEST.PAS has : '+Num2Str(FileSize('demotest.pas'))+' bytes');}
  Chosen_File := DisplayDirectory('*.* ',Errcode);
  system.write(chosen_file);
  Repeat Until Keypressed;
End.