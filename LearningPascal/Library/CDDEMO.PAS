{$F+}
Program CDAudioDemo;

  Uses
    Math,Screen,Menus,Windows,Keyboard,CDROM;

  Var
    CodeOfMSCDEX : Byte;
    A : Byte;
    b : longint;
    Paused,Finished : Boolean;
    Track : Byte;
    tecla : word;
(*
PROCEDURE DisplayCDROMInfo;

  Begin
    OpenWindow(2,3,78,20,10,3,2,'CDROM Information',1);
    BkColor := 3;
    Write(4,4,15,'Audio Volume      : ');
    system.write(AudVolume);
    Write(4,5,15,'Is Door Open      : ');
    system.write(DoorOpen);
    Write(4,6,15,'Is Drive Busy     : ');
    system.write(DrvBusy);
    Write(4,7,15,'Is Audio in Pause : ');
    system.write(InPause);
    Write(4,8,15,'Is Drive locked   : ');
    system.write(DoorLocked);
    Write(4,9,15,'The drive supports audio channels   : ');
    system.write(SuppAudChn);
    Write(4,10,15,'The drive supports audio/video tracks   : ');
    system.write(SuppAudVid);
    Write(4,11,15,'Does the drive writable : ');
    system.write(Writable);
  End;

PROCEDURE WriteInfo;

  Begin
    curdiscpos(value);
    gotoxy(10,10);
    system.writeln('       ');
    system.write(value.trk);
    system.writeln('       ');
    system.write(value.min);
    system.writeln('       ');
    system.write(value.sec);
    system.writeln('       ');
    system.write(value.frm);
  End;
*)
Begin
  Finished :=  False;
  Paused := False;
  A := 1;
  ClrScr;
(*
  MenuDisplay.ExecuteExtRotine := True;
  MenuDisplay.Rotine := WriteInfo;
  ClearText(1,1,80,25,1,7,'°');
  menutopics[1]:='\+File';
  menutopics[2]:='E+xit';
  menutopics[3]:='\C+DROM';
  menutopics[4]:='+Information';
  menutopics[5]:='\+CD';
  menutopics[6]:='+Play';
  menutopics[7]:='P+ause';
  menutopics[8]:='+Stop';
  menutopics[9]:='+Forward';
  menutopics[10]:='+BackWard';
  menutopics[11]:='+Next Song';
  menutopics[12]:='P+rev Song';
  menutopics[13]:='-SPACE-';
  menutopics[14]:='+Eject';
  menutopics[15]:='+Insert';
  menutopics[16]:='-SPACE-';
  menutopics[17]:='I+nformation';
  menutopics[18]:='\+Audio';
  menutopics[19]:='+Volume';
  menutopics[20]:='\\';
  Repeat
    A := PullMenu(False);
    Case A OF
      1: Finished := True;
      2: DisplayCDROMInfo;
      3: Begin
           IF InPause AND Paused Then ResumeAudio
           Else PlayTrack(1);
           Paused := False;
         End;
      4: Begin
           PauseAudio;
           Paused := True;
         End;
      5: Begin { StopPlaying } End;
      6: Begin
         {  CurDiscPos(Value);
           SeekPos(Value.Sec + 1);}
         End;
      7: Begin
         {  CurDiscPos(Value);
           SeekPos(Value.Sec + 1);}
         End;
      8: Begin
         {  CurDiscPos(Value);
           SeekPos(Value.Sec + 1);}
         End;
      9: Begin
         {  CurDiscPos(Value);
           SeekPos(Value.Sec + 1);}
         End;
     10: EjectDoor;
     11: InsertDoor;
  {   12: DisplayCDInfo;}
  {   13: SetVolume; }

    End;
  Until Finished;
 {
  writeln('The actual audio volume is : ', AudVolume);
  IF DoorOpen Then writeln('Door is Open. Please insert a CD.');
  IF DrvBusy Then writeln('Drive is busy');
  IF Locked Then writeln('Drive is locked');
  IF NoDisc Then writeln('There is no disc inserted');
  IF Writable Then writeln('The drive can write CD''s');

  CurDiscPos(Value);
  Writeln('Track : ',Value.Trk);
  Repeat Until KeyPressed;
  }
  *)

  repeat
  gotoxy(1,1);

  CodeOfMSCDEX := MSCDEXInstalled;
  Case CodeOfMSCDEX Of
    0 : system.writeln('MSCDEX Not installed, OK to install');
    1 : system.writeln('MSCDEX Not installed, not OK to install');
    2 : system.writeln('Lotus CD/Networker installed');
    3 : system.writeln('MSCDEX installed');
  End;
  system.writeln('Number of CDROM Drives present : ',CDROMDrive.NumCDDrv);
  system.writeln('First CDROM Drive : ',CDROMDrive.FstCDDrv);
  system.writeln('Version of MSCDEX installed : ',CDROMDrive.MSCDEXVersion.Major,'.',CDROMDrive.MSCDEXVersion.Minor);
  system.writeln('Door open : ',CDROMDrive.DeviceParameters.DoorOpen);
  system.writeln('door unlocked : ',CDROMDrive.DeviceParameters.DoorUnLocked);
  system.writeln('supports raw reading in addition to cooked : ',CDROMDrive.DeviceParameters.RawReading);
  system.writeln('writable : ',CDROMDrive.DeviceParameters.Writable);
  system.writeln('can play audio/video tracks : ',CDROMDrive.DeviceParameters.AudioVideoTracks);
  system.writeln('supports interleaving : ',CDROMDrive.DeviceParameters.InterLeaving);
  system.writeln('supports prefetch requests : ',CDROMDrive.DeviceParameters.Prefetch);
  system.writeln('supports audio channel control : ',CDROMDrive.DeviceParameters.AudioChannelControl);
  system.writeln('supports Red Book addressing in addition to HSG : ',CDROMDrive.DeviceParameters.RedBookAddressing);
  system.writeln('no disk in drive : ',CDROMDrive.DeviceParameters.NoDiscInDrive);
  system.writeln('supports R-W subchannels : ',CDROMDrive.DeviceParameters.RWSubChannels);
  IF Keypressed then tecla:=getscancodew;
  until tecla=kb_Esc;
  CDAudioStatusInfo;
  Q_Channel_Info;
  CDAudioStatusInfo;
  CDAudioDiskInfo; { NÆo ‚ necess rio chamar }
  CreateTracksRecord;
  IF Not (AudioDiskInfo.HighestTrack < 1) Then
    Begin
  For a:=1 to 26 do system.write(CDROMDrive.driverlist[a].unitcode);
  system.writeln;
  For a:=1 to 26 do system.write(CDROMDrive.driverlist[a].unitseg);
  system.writeln;
  For a:=1 to 26 do system.write(CDROMDrive.driverlist[a].unitofs);
  system.writeln;
  For a:=1 to 26 do system.write(CDROMDrive.unitlist[a]);
  system.writeln;
  CDAudioDiskInfo;
  system.writeln('Audio Disk Information');
  system.writeln('Lowest Track : ',AudioDiskInfo.LowestTrack);
  system.writeln('Highest Track : ',AudioDiskInfo.HighestTrack);
  system.writeln('LeadOut Track : ',AudioDiskInfo.LeadOutTrack);
  system.writeln('Playing : ',AudioDiskInfo.Playing);
  system.writeln('Paused : ',Paused);
  for a:=1 to 8 do system.write(AudioDiskInfo.VolInfo[a]);
  system.writeln;
  IF Not AudioDiskInfo.Playing Then
  Play_Audio (trackinfo [AudioDiskInfo. LowestTrack]^. startpoint, trackinfo [AudioDiskInfo. HighestTrack]^. endpoint);

  Track := 1;
  system.writeln('Track Information : ',Track);
  system.writeln('Track : ',trackinfo[Track]^.track);
  system.writeln('Start Point : ',trackinfo[Track]^.StartPoint);
  system.writeln('EndPoint : ',trackinfo[Track]^.endpoint);
  system.writeln('Frames : ',trackinfo[Track]^.Dframes);
  system.writeln('Seconds : ',trackinfo[Track]^.Dseconds);
  system.writeln('Minutes : ',trackinfo[Track]^.DMinutes);
  system.writeln('Played Minutes : ',trackinfo[Track]^.TMin);
  system.writeln('Played Seconds : ',trackinfo[Track]^.TSec);
  system.writeln('TrackControl : ',trackinfo[Track]^.TrackControl);

  repeat until getscancodew=kb_F1;
  ClrScr;
  Track := 1;
  repeat
  Q_Channel_Info;
  gotoxy(1,1);
  system.writeln('Control : ',QChannelInfo.Control);
  system.writeln('Track : ',QChannelInfo.Track);
  system.writeln('Index : ',QChannelInfo.Index);
  system.writeln('Track Minutes : ',QChannelInfo.TMinutes);
  system.writeln('Track Seconds : ',QChannelInfo.TSeconds);
  system.writeln('Track Frame : ',QChannelInfo.TFrame);
  system.writeln('Zero  : ',QChannelInfo.Zero);
  system.writeln('Disc Minutes : ',QChannelInfo.DMinutes);
  system.writeln('Disc Seconds : ',QChannelInfo.DSeconds);
  system.writeln('Disc Frame : ',QChannelInfo.DFrame);

  Track := QChannelInfo.Track;
  IF QChannelInfo.Track > AudioDiskInfo.HighestTrack Then Track := QChannelInfo.Track - 6;
  system.writeln('Track Information');
  system.writeln('Track : ',trackinfo[Track]^.track);
  system.writeln('Start Point : ',trackinfo[Track]^.StartPoint);
  system.writeln('EndPoint : ',trackinfo[Track]^.endpoint);
  system.writeln('Disc Frames : ',trackinfo[Track]^.Dframes);
  system.writeln('Disc Seconds : ',trackinfo[Track]^.Dseconds);
  system.writeln('Disc Minutes : ',trackinfo[Track]^.DMinutes);
  system.writeln('Track Minutes : ',trackinfo[Track]^.TMin);
  system.writeln('Track Seconds : ',trackinfo[Track]^.TSec);
  system.writeln('TrackControl : ',trackinfo[Track]^.TrackControl);

  system.writeln('Playing : ',AudioDiskInfo.Playing);
  system.writeln('Paused : ',Paused);
{
  system.writeln('audio is playing : ',DeviceParameters.Playing);
}
  IF Keypressed then
    Begin
      tecla:=getscancodew;
  CASE tecla of
{  kb_ctrl_s : stop_play;}
{
  kb_PgUp : Track:= Track + 1;
  kb_PgDown : Track:=Track - 1;


   kb_PgUp : Play_Audio (trackinfo [QChannelInfo.Track + 1]^. startpoint,
                         trackinfo [AudioDiskInfo. HighestTrack]^. endpoint);
   kb_PgDown : Play_Audio (trackinfo [QChannelInfo.Track - 1]^. startpoint,
                           trackinfo [AudioDiskInfo. HighestTrack]^. endpoint);
}
   kb_PgUp : Play_Audio (trackinfo [Track + 1]^. startpoint,
                         trackinfo [AudioDiskInfo. HighestTrack]^. endpoint);
   kb_PgDown : Play_Audio (trackinfo [Track - 1]^. startpoint,
                           trackinfo [AudioDiskInfo. HighestTrack]^. endpoint);
  end;
  end;
  until tecla=kb_F2;
  End
  Else
  begin
  system.writeln('Not a Audio Disc inserted');
  repeat until keypressed;
  end;
End.