{$A+} { Align Data Switch }
{$B-} { Boolean Evaluation Switch }
{$D-} { Debug Information Switch }
{$E-} { Emulation Switch - this doesn't affect a unit only a program }
{$F+} { Force Far Calls Switch }
{$G+} { Generate 80286 Code Switch }
{$I-} { Input/Output-Checking Switch }
{$I Defines.INC} { This file is used to define some conditionals according   }
{ with user preferences.                                                     }
{$L-} { Local Symbol Information Switch }
{$M 3072,0,7168}
{$N+} { Numeric Coprocessor Switch }
{$Q-} { Overflow Checking Switch }
{$R-} { Range-Checking Switch }
{$S-} { Stack-Overflow Checking Switch }
{$V-} { Var-String Checking Switch }
{$Y+} { Symbol Reference Information Switch - just afect the Unit size, and }
      { it's very good when you run BP, because you can go directly to the  }
      { line where the source begins! Study, to know more!!!                }
PROGRAM TSR_CDPlayer;

  Uses
    Crt, Screen, Math, StrsUse, Keyboard, CDROM, TSR;

PROCEDURE InitCDPlayer;

  Var
    Key : Word;
    ScreenGroup : ScreenPtr;
    X,Y : Byte;
    On : Boolean;
    a: byte;
    NewCD : Boolean;

  Begin
    X := WhereX;
    Y := WhereY;
    On := CursorIsOn;
    NewCD := TRUE;
    InitPages(ScreenGroup,1);
    StorePage(ScreenGroup,1,1,80,25,1); { Store the first Page }
    ClrScr;
    CursorOn(False);
    CDAudioDiskInfo;
    IF NOT AudioDiskInfo.Playing Then ResetCD;
    CDQChannelInfo;
    CreateTracksRecord;
    QChannelInfo.Track := AudioDiskInfo.LowestTrack;
        WriteCenterText(40,2,Attribute(15,0),'CDPlayer TSR v1.0 ');
        WriteCenterText(40,3,Attribute(11,0),'Copyright (c) 1995-1997 by ^Magico^');
        WriteCenterText(40,4,Attribute(11,0),'All Rights Reserved');
        Horizontal(1,79,3,12,0,'Ä');
        For a:= 0 to 18 do
          begin
            WriteCenterText(40,4+a,Attribute(11,0),Replicate(79,' '));
            Vertical(4,4+a,40,12,0,'³');
            Horizontal(1,79,5+a,12,0,'Ä');
            WriteCenterText(40,6+a,Attribute(11,0),'Copyright (c) 1995-1997 by ^Magico^');
            WriteCenterText(40,7+a,Attribute(11,0),'All Rights Reserved');
            Delay(30);
          end;
      { Help Window }
        FastWrite(42,5,Attribute(14,0),'TSR Control');
        FastWrite(44,6,Attribute(13,0),'Ctrl + R');
        FastWrite(54,6,Attribute(12,0),'Remove the TSR from memory');
        FastWrite(54,7,Attribute(12,0),'if allowed');
        FastWrite(44,8,Attribute(13,0),'Esc');
        FastWrite(54,8,Attribute(12,0),'Exit');
        FastWrite(42,10,Attribute(14,0),'CDROM Drive Control');
        FastWrite(44,11,Attribute(13,0),'Shift + O');
        FastWrite(54,11,Attribute(12,0),'Open CDROM drive door');
        FastWrite(44,12,Attribute(13,0),'Shift + C');
        FastWrite(54,12,Attribute(12,0),'Close CDROM drive door');
        FastWrite(42,14,Attribute(14,0),'CD Control');
        FastWrite(44,15,Attribute(13,0),'Shift + P');
        FastWrite(57,15,Attribute(12,0),'Play/Pause');
        FastWrite(44,16,Attribute(13,0),'Shift + S');
        FastWrite(57,16,Attribute(12,0),'Stop Playing');
        FastWrite(44,17,Attribute(13,0),'Right Arrow');
        FastWrite(57,17,Attribute(12,0),'Forward');
        FastWrite(44,18,Attribute(13,0),'Left Arrow');
        FastWrite(57,18,Attribute(12,0),'BackWard');
        FastWrite(44,19,Attribute(13,0),'Up Arrow');
        FastWrite(57,19,Attribute(12,0),'Next song');
        FastWrite(44,20,Attribute(13,0),'Down Arrow');
        FastWrite(57,20,Attribute(12,0),'Previous song');
        FastWrite(44,21,Attribute(13,0),'Shift + L');
        FastWrite(57,21,Attribute(12,0),'Create a playlist');
      { Information Window }
        FastWrite(2,5,Attribute(14,0),'Track Information');
        FastWrite(7,7,Attribute(3,0),'Playing Track : ');
        FastWrite(23,7,Attribute(13,0),'xx');
        FastWrite(7,9,Attribute(3,0),'Track Total Time : ');
        FastWrite(26,9,Attribute(15,0),'xx:xx');
        FastWrite(7,11,Attribute(3,0),'Time elapsed : ');
        FastWrite(22,11,Attribute(15,0),'xx:xx');
        FastWrite(2,13,Attribute(14,0),'Disc Information');
        FastWrite(7,15,Attribute(3,0),'Total Tracks : ');
        FastWrite(22,15,Attribute(15,0),'xx');
        FastWrite(7,17,Attribute(3,0),'Disc Total Time : ');
        FastWrite(25,17,Attribute(15,0),'xx:xx');
        FastWrite(7,19,Attribute(3,0),'Disc Time elapsed : ');
        FastWrite(27,19,Attribute(15,0),'xx:xx');
        Repeat
          CDQChannelInfo;
          CDAudioStatusInfo;
          DeviceStatus;
          IF NewCD AND (Not CDROMDrive.DeviceParameters.DoorOpen) AND (AudioDiskInfo.HighestTrack > 1) Then
            Begin
              NewCD := False;
              FillChar (TrackInfo, SizeOf (TrackInfo), #0);
              CDQChannelInfo;
              CDAudioStatusInfo;
              CreateTracksRecord;
              DeviceStatus;
              QChannelInfo.Track := AudioDiskInfo.LowestTrack;
            End;
          IF CDROMDrive.DeviceParameters.DoorOpen OR (AudioDiskInfo.HighestTrack < 2) Then
            Begin
              NewCD := True;
              FastWrite(8,21,Attribute(12,0)+Blink,'Not an Audio CD inserted');
              FastWrite(23,7,Attribute(13,0),'00');
              FastWrite(22,15,Attribute(7,0),'00');
              FastWrite(22,11,Attribute(13,0),'00');
              FastWrite(25,11,Attribute(13,0),'00');
              FastWrite(26,9,Attribute(7,0),'00');
              FastWrite(29,9,Attribute(7,0),'00');
              FastWrite(25,17,Attribute(7,0),'00');
              FastWrite(28,17,Attribute(7,0),'00');
              FastWrite(27,19,Attribute(13,0),'00');
              FastWrite(30,19,Attribute(13,0),'00');
            End
          Else
            Begin
              FastWrite(8,21,Attribute(0,0),'Not an Audio CD inserted');
              FastWrite(23,7,Attribute(13,0),PadRight(Num2Str(QChannelInfo.Track),2,'0'));
              FastWrite(22,15,Attribute(7,0),PadRight(Num2Str(AudioDiskInfo.HighestTrack),2,'0'));
              FastWrite(22,11,Attribute(13,0),PadRight(Num2Str(QChannelInfo.TMinutes),2,'0'));
              FastWrite(25,11,Attribute(13,0),PadRight(Num2Str(QChannelInfo.TSeconds),2,'0'));
              FastWrite(26,9,Attribute(7,0),PadRight(Num2Str(TrackInfo[QChannelInfo.Track]^.TMin),2,'0'));
              FastWrite(29,9,Attribute(7,0),PadRight(Num2Str(TrackInfo[QChannelInfo.Track]^.TSec),2,'0'));
              FastWrite(25,17,Attribute(7,0),PadRight(Num2Str(TrackInfo[AudioDiskInfo.HighestTrack]^.DMinutes),2,'0'));
              FastWrite(28,17,Attribute(7,0),PadRight(Num2Str(TrackInfo[AudioDiskInfo.HighestTrack]^.DSeconds),2,'0'));
              FastWrite(27,19,Attribute(13,0),PadRight(Num2Str(QChannelInfo.DMinutes),2,'0'));
              FastWrite(30,19,Attribute(13,0),PadRight(Num2Str(QChannelInfo.DSeconds),2,'0'));
            End;
          IF Keypressed Then
            Begin
              Key := GetScanCodeW;
              Case Key Of
                kb_Ctrl_R : Begin
                              IF CheckIntVectors = True Then
                                Begin
                                  RestorePage(ScreenGroup,1);
                                  ReleasePages(ScreenGroup);
                                  GotoXY(X,Y);
                                  CursorOn(On);
                                  ClrScr;
                                  TextColor(11);
                                  System.Writeln('CDPlayer TSR v1.0');
                                  TextColor(15);
                                  System.Writeln('Removed from memory');
                                  RemoveTSR;
                                End;
                            End;
                kb_Shift_O : Begin
                               DeviceStatus;
                               NewCD := True;
                               Stop_play;
                               Eject;
                             End;
                kb_Shift_C : Begin
                               DeviceStatus;
                               IF CDROMDrive.DeviceParameters.DoorOpen Then
                                 Begin
                                   CloseTray;
                                   Delay(4000);
                                   ResetCD;
                                   NewCD := True;
                                   DeviceStatus;
                                 End;
                             End;
                Kb_Shift_S : Begin
                               Stop_Play;
                             End;
                Kb_Shift_P : Begin
                              IF AudioDiskInfo.Playing Then Pause_Audio
                              Else
                              IF AudioDiskInfo.Paused Then Resume_Play
                              Else Play_Audio(trackinfo [QChannelInfo.Track{AudioDiskInfo. LowestTrack}]^. startpoint,
                                              trackinfo [AudioDiskInfo. HighestTrack]^. endpoint);
                            End;
                kb_Up : Begin
                         IF QChannelInfo.Track < AudioDiskInfo.HighestTrack Then
                                   Play_Audio(trackinfo [QChannelInfo.Track + 1]^. startpoint,
                                              trackinfo [AudioDiskInfo. HighestTrack]^. endpoint);
                        End;
                kb_Down : IF QChannelInfo.Track >= 2 Then
                                   Play_Audio(trackinfo [QChannelInfo.Track - 1]^. startpoint,
                                              trackinfo [AudioDiskInfo. HighestTrack]^. endpoint);
                kb_Left : Begin
                          End;
              End; { Case }
            End;
        Until Key = Kb_Esc;
    RestorePage(ScreenGroup,1);
    ReleasePages(ScreenGroup);
    GotoXY(X,Y);
    CursorOn(On);
  End; { InitCDPlayer }


var
  a: byte;

  Begin  { Main Program }
    Keysc := _i;
    keyflag := Alt;
    SetUserSignature($ae34,$5511);
    ClrScr;
    IF ParamCount > 0 Then
      Begin
        IF ParamStr(1) = '/l' Then
          Begin
            IF InstallationCheck = True Then
              Begin
                TextColor(11);
                System.Writeln('CDPlayer TSR v1.0');
                TextColor(15);
                System.Writeln('Already installed');
                System.Writeln('ALT + I   To activate');
                Halt;
              End;
            TextColor(11);
            System.Writeln('CDPlayer TSR v1.0');
            TextColor(15);
            System.Writeln('Installed');
            System.Writeln('ALT + I   To activate');
            InstallTSR(InitCDPlayer);
          End;
      End
    Else
      Begin
        ClrScr;
        TextColor(11);
        System.Writeln('CDPlayer TSR v1.0');
        TextColor(15);
        System.Writeln('     /l   Load the program into memory');
      End;
{
  InitCDPlayer;
}
  End.
