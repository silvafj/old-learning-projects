Program ModInfor;

  Uses
    Crt,Vbe20,Math;

  Var
    Mode : word;

Begin
  ClrScr;
  GetVbeInfo;
  Mode := SearchMode(320,200,8);
  IF Mode = 0 Then
    Begin
      Writeln('VESA Error : Mode not supported');
      Halt;
    End;
  Case GetVbeModeInfo(Mode) of
    0 : Writeln('þ Mode detected ');
    1 : Begin
          Writeln('VESA Error : Mode with LFB not supported (Try to Load UNIVBE.EXE) ');
          Halt;
        End;
  End;
  writeln('Mode Attributes  : ',ModeInfo.ModeAttributes);
  writeln('Win A Attributes : ',ModeInfo.WinAAttributes);
  writeln('Win B Attributes : ',ModeInfo.WinBAttributes);
  writeln('Win Granularity  : ',ModeInfo.WinGranularity);
  writeln('Win Size         : ',ModeInfo.WinSize);
  writeln('Win A Segment    : ',ModeInfo.WinASegment);
  writeln('Win B Segment    : ',ModeInfo.WinBSegment);
  writeln('X Resolution     : ',ModeInfo.XResolution);
  writeln('Y Resolution     : ',ModeInfo.YResolution);

  writeln('Physical BasePtr : ',ModeInfo.PhysBasePtr);
End.
