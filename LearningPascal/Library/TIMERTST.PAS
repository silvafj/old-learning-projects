{---------------------------------- CUT HERE -------------------------------}

program timertst;

uses timerint, crt;

var
  a: longint;

procedure toggle_light(x, y: byte);
const screen = $B800;
      lchr   = $0CFE;
      dchr   = $04FE;
var   adr    : word;
begin
   adr := (y*80+x)*2;
   if(memW[screen:adr] <> lchr) then memW[screen:adr] := lchr
      else memW[screen:adr] := dchr;
end;

procedure test1; far;
begin
   toggle_light(5,5);
end;

procedure test2; far;
begin
   toggle_light(13,5);
end;

procedure test3; far;
begin
   toggle_light(21,5);
end;

procedure test4; far;
begin
   toggle_light(29,5);
end;

procedure test5; far;
begin
   inc(a);
   toggle_light(37,5);
end;

begin
   clrscr;
   writeln('+------------------------------------------+');
   writeln('|           TIMERINT UNIT EXAMPLE          |');
   writeln('+------------------------------------------+');
   writeln('|   1 Hz    2 Hz    5 Hz    10 Hz   100 Hz |');
   writeln('|   +-+     +-+     +-+     +-+     +-+    |');
   writeln('|   | |     | |     | |     | |     | |    |');
   writeln('|   +-+     +-+     +-+     +-+     +-+    |');
   writeln('+------------------------------------------+');
   a := 0;
   install_handler(@test1, 1);
   install_handler(@test2, 2);
   install_handler(@test3, 5);
   install_handler(@test4, 10);
   install_handler(@test5, 100);

   repeat
   until keypressed;
   system.writeln(a/100);
end.

