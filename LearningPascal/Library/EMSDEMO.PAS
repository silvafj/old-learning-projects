{ --------------------------   DEMO --------------------------------- }

Program EMSDemo;
{ Copyright (c) 1994 by Andrew Eigus                  FidoNet: 2:5100/33 }
{ LIM EMS Interface V1.01 for Turbo Pascal version 7.0 demonstration program }

(*
  Tested on IBM 486 SX 33Mhz with 4MB RAM with the following configuration:
        HIMEM.SYS  (MS-DOS 6.2 XMS memory manager)
        EMM386.EXE (MS-DOS 6.2 EMS memory manager)

  If any bugs occur in your system while running this demo,
  please inform me:

 AndRew's BBS Phone: 003-712-559777 (Riga, Latvia) 24h 2400bps
 Voice Phone:     003-712-553218
 FidoNet:     2:5100/33
 E-Mail:      aeigus@fgate.castle.riga.lv
*)

{$X+}{$R-} { Enable extended syntax }

uses EMS,Math,Keyboard,Screen;

type TMsg = array[1..13] of Char;

const
  Message1 : TMsg = 'First string ';
  Message2 : TMsg = 'Second string';

var
  Version : byte;
  FreeMemory, Handle, SegAddr, I : word;
  P : pointer;

Function Hex(Num : longint; Places : byte) : string;
const HexTab : array[0..15] of Char = '0123456789ABCDEF';
var
  HS : string[8];
  Digit : byte;
Begin
  HS[0] := Chr(Places);
  for Digit := Places downto 1 do
  begin
    HS[Digit] := HexTab[Num and $0000000F];
    Num := Num shr 4
  end;
  Hex := HS
End; { Hex }

Function Check(Result : byte; Func : string) : byte;
Begin
  if Result <> emsrOk then
    WriteLn(Func, ' returned ',
      Hex(Result, 2), 'h (', Result, '): ', EMS_GetErrorMsg(Result));
  Check := Result
End; { Check }

Procedure PrintFreeMemory;
Begin
  WriteLn;
  if Check(EMS_GetMemAvail(FreeMemory), 'EMS_GetMemAvail') = emsrOk then
    WriteLn('EMS memory available: ', FreeMemory, ' KB');
  WriteLn
End; { PrintFreeMemory }

Begin
  ClrScr;
  WriteLn('LIM EMS Library V1.01 Demonstration program by Andrew Eigus'#10);
  if EMS_Setup then
  begin
    if Check(EMS_GetVersion(Version), 'EMS_GetVersion') = emsrOk then
      WriteLn('EMS driver version ',
        Version shr 4, '.', Version shr 8, ' detected');
    PrintFreeMemory;
    if FreeMemory = 0 then Halt(8);
    if Check(EMS_AllocEMB(Handle, SegAddr, 1), 'EMS_AllocEMB') = emsrOk then
    begin
      WriteLn('Message1: ', Message1);
      WriteLn('Message2: ', Message2);
      WriteLn('16 KB (one page) of EMS allocated. Linear address: ',
        Hex(SegAddr, 8), 'h');
      PrintFreeMemory;
      WriteLn('Transferring Message1 to EMS...');
      for I := 0 to SizeOf(TMsg) - 1 do
        EMS_MapPages(Handle, I, 0);
      P := Ptr(SegAddr, 0);
      Move(Message1, P^, SizeOf(TMsg));
      WriteLn('Transferring Message1 from EMS to Message2...');
      Move(P^, Message2, SizeOf(TMsg));
      WriteLn('Message1: ', Message1);
      WriteLn('Message2: ', Message2);
      if Check(EMS_FreeEMB(Handle), 'EMS_FreeEMB') = emsrOk then
      begin
        WriteLn('Memory deallocated (released). ');
        PrintFreeMemory
      end
    end
  end else
    WriteLn('EMM386 manager not installed.');
  repeat until keypressed;
End.

