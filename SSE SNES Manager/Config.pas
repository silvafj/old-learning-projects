unit Config;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Buttons, Registry, FileCtrl, CoolForm, IniFiles;

type
  TConfigWnd = class(TForm)
    OpenDialog: TOpenDialog;
    PageControl: TPageControl;
    TabSheetGraphics: TTabSheet;
    TabSheetSound: TTabSheet;
    TabSheetControls: TTabSheet;
    TabSheetEmulator: TTabSheet;
    LabelSNES9x: TLabel;
    LabelROMs: TLabel;
    EditPathEmulator: TEdit;
    BrowseBtn1: TBitBtn;
    EditPathRoms: TEdit;
    BrowseBtn2: TBitBtn;
    CheckBoxTransparency: TCheckBox;
    CheckBoxBGLayering: TCheckBox;
    CheckBoxWindows: TCheckBox;
    CheckBoxHDMA: TCheckBox;
    CheckBoxVSync: TCheckBox;
    CheckBoxStretch: TCheckBox;
    CheckBoxTVMode: TCheckBox;
    CheckBoxHiRes: TCheckBox;
    CheckBox16bit: TCheckBox;
    ComboBoxScrMode: TComboBox;
    LabelScrMode: TLabel;
    LabelCPUCycles: TLabel;
    LabelSkipFrames: TLabel;
    ComboBoxSkipFrames: TComboBox;
    ComboBoxCPUCycles: TComboBox;
    LabelNTSC: TLabel;
    EditNTSC: TEdit;
    LabelPAL: TLabel;
    EditPAL: TEdit;
    CheckBoxSound: TCheckBox;
    CheckBoxStereo: TCheckBox;
    LabelPlayrate: TLabel;
    ComboBoxPlayrate: TComboBox;
    LabelBuffer: TLabel;
    ComboBoxBuffer: TComboBox;
    CheckBoxVolume: TCheckBox;
    CheckBoxSoundEffects: TCheckBox;
    CheckBoxMasterVolume: TCheckBox;
    CheckBoxSoundCaching: TCheckBox;
    CheckBoxSpeedHacks: TCheckBox;
    LabelSoundSkipping: TLabel;
    ComboBoxSoundSkipping: TComboBox;
    CheckBoxSurround: TCheckBox;
    Bevel2: TBevel;
    Bevel1: TBevel;
    BtnCancel: TBitBtn;
    BtnOK: TBitBtn;
    CheckBoxJoystick: TCheckBox;
    LabelJoyButtons: TLabel;
    ComboBoxJoyButtons: TComboBox;
    Bevel4: TBevel;
    ComboBoxKeyboard: TComboBox;
    ComboBoxKeyUp: TComboBox;
    ComboBoxKeyDiagUpRight: TComboBox;
    ComboBoxKeyDiagUpLeft: TComboBox;
    ComboBoxKeyLeft: TComboBox;
    ComboBoxKeyRight: TComboBox;
    ComboBoxKeyDiagDownLeft: TComboBox;
    ComboBoxKeyDiagDownRight: TComboBox;
    ComboBoxKeyDown: TComboBox;
    ComboBoxKeyL: TComboBox;
    ComboBoxKeyR: TComboBox;
    ComboBoxKeyY: TComboBox;
    ComboBoxKeyStart: TComboBox;
    ComboBoxKeyA: TComboBox;
    ComboBoxKeyB: TComboBox;
    ComboBoxKeySelect: TComboBox;
    ComboBoxKeyX: TComboBox;
    procedure BrowseBtn1Click(Sender: TObject);
    procedure BrowseBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CheckBoxSoundClick(Sender: TObject);
    procedure ComboBoxKeyboardClick(Sender: TObject);
  private
    { Private declarations }
    KeybActual : Integer;
    Registry : TRegistry;
    IniFile : TIniFile;
  public
    { Public declarations }
  end;

const
  Company = 'NightSpy';
  Product = 'SSE SNES Manager';
  Keys : array [0..38] of integer = (30, 48, 46, 32, 18, 33,
                                     34, 35, 23, 36, 37, 38,
                                     50, 49, 24, 25, 16, 19,
                                     31, 20, 22, 47, 17, 45,
                                     21, 44, 71, 72, 73, 75,
                                     76, 77, 79, 80, 81, 82,
                                     83, 57, 28);
  Keys2 : array [16..83] of integer = (16, 22, 04, 17, 19, 24,
                                       20, 08, 14, 15, 99, 99,
                                       38, 99, 00, 18, 03, 05,
                                       06, 07, 09, 10, 11, 99,
                                       99, 99, 99, 99, 25, 23,
                                       02, 21, 01, 13, 12, 99,
                                       99, 99, 99, 99, 99, 37,
                                       99, 99, 99, 99, 99, 99,
                                       99, 99, 99, 99, 99, 99,
                                       99, 26, 27, 28, 99, 29,
                                       30, 31, 99, 32, 33, 34,
                                       35, 36);
var
  ConfigWnd: TConfigWnd;

implementation

{$R *.DFM}

procedure TConfigWnd.BrowseBtn1Click(Sender: TObject);
begin
  If (EditPathEmulator.Text <> '') then OpenDialog.InitialDir := EditPathEmulator.Text;
  If OpenDialog.Execute then
  EditPathEmulator.Text := OpenDialog.FileName;
end;

procedure TConfigWnd.BrowseBtn2Click(Sender: TObject);
var
  dir : string;

begin
  dir := EditPathRoms.Text;
  if not DirectoryExists(dir) then dir :='.';
  if SelectDirectory(dir,[sdAllowCreate,sdPerformCreate,
                          sdPrompt],0) then
    EditPathRoms.Text := dir;
end;

procedure TConfigWnd.FormCreate(Sender: TObject);
var
  CommandLine : String;

begin
  Registry := TRegistry.Create;
  Registry.OpenKey('\Software\'+company+'\'+product,TRUE);
  If (Not Registry.ValueExists('PathEmulator')) or
     (Not Registry.ValueExists('PathRoms')) then
     begin
       EditPathEmulator.Text := '';
       EditPathRoms.Text     := '';
     end
  Else
    begin
      EditPathEmulator.Text := Registry.ReadString('PathEmulator');
      EditPathRoms.Text     := Registry.ReadString('PathRoms');
    end;
  CommandLine := Registry.ReadString('CmdLine');
  CheckBox16bit.Checked := Boolean(Pos('-16',CommandLine));
  CheckBoxHiRes.Checked := Boolean(Pos('-hires',CommandLine));
  Registry.Free;
  // Initialize Hints
  // Graphics Page
  CheckBoxTransparency.Hint := 'Enable transparency effects, also enabled 16-bit'+
                               ' screen mode selection';
  CheckBoxBGLayering.Hint := 'Swap background layer priorities from background '+
                             'involved in sub-screen addition/subtraction.'+#13+
                             'Can improve some games play-ability, no need to '+
                             'constantly toggle background layers on and off to '+
                             'read text/see maps, etc.'+#13+
                             'Toggle feature on and off during game by pressing '+
                             '"8" key.'+#13+
                             'Not used if transparency effects are enabled.';
  CheckBoxWindows.Hint := 'Disable graphics windows emulation.'+#13+
                          'Use "backspace" key during a game to toggle the emulation '+
                          'on and off.';
  CheckBoxHDMA.Hint := 'Turn on or off H-DMA emulation.'+#13+
                       'Pressing "0" key during a game toggles H-DMA on and off.';
  CheckBoxVSync.Hint := 'Enables Vsync to smoothen graphics. Slowns down emulation though.';
  CheckBoxStretch.Hint := 'Stretch the SNES display to fit the whole of the computer display';
  CheckBoxTVMode.Hint := 'Enables "TV Mode", hires support, 16-bit internal '+
                         'rendering and transparency effects.'+#13+
                         'TV Mode scales the SNES image by x2 by inserting and extra '+
                         'blended pixel between each SNES pixel and 80% brightness '+
                         ' "scan-lines" between each horizontal line.'+#13+
                         'The result looks very nice but needs a fast machine.'+#13+
                         'Use with full-screen X mode and a 15 or 16 depth X server. '+
                         'or the SVGA port for fastest operation.';
  CheckBoxHiRes.Hint := 'Enable support for SNES hi-res and interlace modes.'+#13+
                        'Use only if game requires it (few do) because it really '+
                        'slows down the emulator.';
  CheckBox16bit.Hint := 'Enable 16-bit internal screen rendering, allows palette '+
                        ' changes but no transparency effects.';
  ComboBoxScrMode.Hint := 'Choose the best for you';
  LabelScrMode.Hint := ComboBoxScrMode.Hint;
  ComboBoxSkipFrames.Hint := 'Set this value to deliberately fix the frame skip '+
                             'rate and disable auto speed regulation.';
  LabelSkipFrames.Hint := ComboBoxSkipFrames.Hint;
  ComboBoxCPUCycles.Hint := 'Percentage of CPU Cycles to execute per scanline, '+
                            'decrease value to increase emulation frame rate.'+#13+
                            'Most ROMs work with a value of 85 or above.';
  LabelCPUCycles.Hint := ComboBoxCPUCycles.Hint;
  EditNTSC.Hint := 'If auto-adjust frame skip option is in effect, then the '+
                   'emulator will try to maintain a constant game and music speed '+#13+
                   'locked to this value by skipping the rendering of some frames '+
                   'or waiting until the required time is reached.'+#13+
                   'Increase the value to slow down games, decrease it to speed '+
                   'up games.';
  EditPAL.Hint := EditNTSC.Hint;
  LabelNTSC.Hint := EditNTSC.Hint;
  LabelPAL.Hint := LabelNTSC.Hint;
  // Sound Page
  CheckBoxSound.Hint := 'Disable sound CPU emulation and sound output, usefull for'+#13+
                        'the few ROMs where sound emulation causes them to lock up '+
                        'due to timing errors.';
  CheckBoxStereo.Hint := 'Enable stereo sound output.';
  ComboBoxPlayrate.Hint := 'Sound playback rate/quality.';
  LabelPlayrate.Hint := ComboBoxPlayrate.Hint;
  ComboBoxBuffer.Hint := 'Sound playback buffer size in bytes.';
  LabelBuffer.Hint := ComboBoxBuffer.Hint;
  CheckBoxVolume.Hint := 'Enable volume envelope height reading by the sound CPU.'+#13+
                         'Can cure sound repeat problems with some games (e.g. Mortal Kombat series), '+#13+
                         'while causing others to lock if enabled (e.g. bomberman series).';
  CheckBoxSoundEffects.Hint := 'Sound echo and FIR effects. Processing these effects can really slow down '+#13+
                               'a non-MMX Pentium machine due to the number of calculations required '+#13+
                               'to implement these features.';
  CheckBoxMasterVolume.Hint := 'Sound DSP master volume control.'+#13+
                               'Some ROMs set the volume level very low requiring you to turn '+#13+
                               'up the volume level of your speakers introducing more background noise.'+#13+
                               'Use this option to always have the master volume set on full and to by-pass '+#13+
                               'a bug which prevents the music and sound effects being heard on Turrican.';
  CheckBoxSoundCaching.Hint := 'Decompressing samples takes time, slowing down the emulator.'+#13+
                               'Normally the decompressed samples are saved just in case they '+#13+
                               'need to be played again, but the way samples are stored and played '+#13+
                               'on the SNES, it canresult in a click sound or distortion  when caching '+#13+
                               'samples with loopsin them.';
  CheckBoxSpeedHacks.Hint := 'The hacks boost the speed of many ROMs but cause problems a few ROMs.';
  ComboBoxSoundSkipping.Hint := 'Sound Skipping Waiting Method. DO NOT use if sound output is enabled.';
  LabelSoundSkipping.Hint := ComboBoxSoundSkipping.Hint;
  CheckBoxSurround.Hint := 'Surround sound using 2 speakers. This is best heard using headphones.';
  // Controls Page
  CheckBoxJoystick.Hint := 'Enables joystick, SideWinder, and GrIP detection.'+#13+
                           'Joystick polling on the PC slows the emulator down.';
  ComboBoxJoyButtons.Hint := 'Number of buttons for connectd Joystick.';
  LabelJoyButtons.Hint := ComboBoxJoyButtons.Hint;
  ComboBoxKeyboard.Hint := 'Choose player keyboard';

  // Check initial values
  ComboBoxScrMode.ItemIndex := 13;
  ComboBoxSkipFrames.ItemIndex := 10;
  ComboBoxCPUCycles.ItemIndex := 20;
  ComboBoxPlayrate.ItemIndex := 4;
  ComboBoxBuffer.ItemIndex := 0;
  ComboBoxSoundSkipping.ItemIndex := 0;
  If CheckBoxSound.Checked then
    Begin
      ComboBoxSoundSkipping.ItemIndex := 0;
      ComboBoxSoundSkipping.Enabled := FALSE;
    End;
  ComboBoxJoyButtons.ItemIndex := 0;
  ComboBoxKeyboard.ItemIndex := 0;
  KeybActual := 0;
  ComboBoxKeyLeft.ItemIndex := 0;
  ComboBoxKeyRight.ItemIndex := 0;
  ComboBoxKeyUp.ItemIndex := 0;
  ComboBoxKeyDown.ItemIndex := 0;
  ComboBoxKeyL.ItemIndex := 0;
  ComboBoxKeyR.ItemIndex := 0;
  ComboBoxKeyY.ItemIndex := 0;
  ComboBoxKeyX.ItemIndex := 0;
  ComboBoxKeyA.ItemIndex := 0;
  ComboBoxKeyB.ItemIndex := 0;
  ComboBoxKeyStart.ItemIndex := 0;
  ComboBoxKeySelect.ItemIndex := 0;
  ComboBoxKeyDiagUpLeft.ItemIndex := 0;
  ComboBoxKeyDiagUpRight.ItemIndex := 0;
  ComboBoxKeyDiagDownLeft.ItemIndex := 0;
  ComboBoxKeyDiagDownRight.ItemIndex := 0;
  // Read File for configuartion values
  IniFile := TIniFile.Create(ExtractFileDir(EditPathEmulator.Text)+'\SNES9x.INI');
  // Graphics Page
  // [graphics]
  CheckBoxTransparency.Checked := Boolean(StrToInt(IniFile.ReadString('graphics','Transparency','0')));
  CheckBoxBGLayering.Checked := Boolean(StrToInt(IniFile.ReadString('graphics','BGLayering','0')));
  CheckBoxWindows.Checked := NOT Boolean(StrToInt(IniFile.ReadString('graphics','DisableGraphicWindows','0')));
  CheckBoxHDMA.Checked := NOT Boolean(StrToInt(IniFile.ReadString('graphics','DisableHDMA','0')));
  If IniFile.ReadString('graphics','mode','') = '' then ComboBoxScrMode.ItemIndex := 13
  Else ComboBoxScrMode.ItemIndex := StrToInt(IniFile.ReadString('graphics','mode',''));
  CheckBoxVSync.Checked := Boolean(StrToInt(IniFile.ReadString('graphics','wait_for_vsync','0')));
  CheckBoxStretch.Checked := Boolean(StrToInt(IniFile.ReadString('graphics','stretch','0')));
  CheckBoxTVMode.Checked := Boolean(StrToInt(IniFile.ReadString('graphics','TV','0')));
  // [cpu]
  ComboBoxCpuCycles.ItemIndex := ComboBoxCpuCycles.Items.IndexOf(IniFile.ReadString('cpu','H_Max','100'));
  // [timer]
  If IniFile.ReadString('timer','SkipFrames','') = '' then ComboBoxSkipFrames.ItemIndex := 10
  Else ComboBoxSkipFrames.ItemIndex := StrToInt(IniFile.ReadString('timer','SkipFrames',''));
  EditNTSC.Text := IniFile.ReadString('timer','NTSCtiming','16667');
  EditPAL.Text := IniFile.ReadString('timer','PALtiming','20000');
  // Sound Page
  // [sound]
  CheckBoxSound.Checked := Boolean(StrToInt(IniFile.ReadString('sound','APUEnabled','0')));
  CheckBoxStereo.Checked := Boolean(StrToInt(IniFile.ReadString('sound','Stereo','0')));
  ComboBoxPlayrate.ItemIndex := StrToInt(IniFile.ReadString('sound','SoundPlaybackRate','0'));
  ComboBoxBuffer.ItemIndex := ComboBoxBuffer.Items.IndexOf(IniFile.ReadString('sound','SoundBufferSize','128'));
  CheckBoxVolume.Checked := Boolean(StrToInt(IniFile.ReadString('sound','SoundEnvelopeHeightReading','0')));
  CheckBoxSoundEffects.Checked := NOT Boolean(StrToInt(IniFile.ReadString('sound','DisableSoundEcho','0')));
  CheckBoxMasterVolume.Checked := NOT Boolean(StrToInt(IniFile.ReadString('sound','DisableMasterVolume','0')));
  CheckBoxSoundCaching.Checked := NOT Boolean(StrToInt(IniFile.ReadString('sound','DisableSampleCaching','0')));
  CheckBoxSpeedHacks.Checked := NOT Boolean(StrToInt(IniFile.ReadString('sound','Shutdown','0')));
  ComboBoxSoundSkipping.ItemIndex := ComboBoxSoundSkipping.Items.IndexOf(IniFile.ReadString('sound','SoundSkipMethod','0'));
  CheckBoxSurround.Checked := Boolean(StrToInt(IniFile.ReadString('sound','SurroundSnd','0')));
  // Controls Page
  CheckBoxjoystick.Checked := Boolean(StrToInt(IniFile.ReadString('joystick','JoystickEnabled','0')));
  If IniFile.ReadString('joystick','JoystickButtons','') = '' then ComboBoxJoyButtons.ItemIndex := 0
  Else ComboBoxJoyButtons.ItemIndex := ComboBoxJoyButtons.Items.IndexOf(IniFile.ReadString('joystick','JoystickButtons',''));
  ComboBoxKeyLeft.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','Left',12)];
  ComboBoxKeyRight.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','Right',12)];
  ComboBoxKeyUp.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','Up',12)];
  ComboBoxKeyDown.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','Down',12)];
  ComboBoxKeyL.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','LButton',12)];
  ComboBoxKeyR.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','RButton',12)];
  ComboBoxKeyY.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','YButton',12)];
  ComboBoxKeyX.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','XButton',12)];
  ComboBoxKeyA.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','AButton',12)];
  ComboBoxKeyB.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','BButton',12)];
  ComboBoxKeyStart.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','StartButton',12)];
  ComboBoxKeySelect.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','SelectButton',12)];
  ComboBoxKeyDiagUpLeft.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','DiagUpLeft',12)];
  ComboBoxKeyDiagUpRight.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','DiagUpRight',12)];
  ComboBoxKeyDiagDownLeft.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','DiagDownLeft',12)];
  ComboBoxKeyDiagDownRight.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','DiagDownRight',12)];
  IniFile.Free;
end;

procedure TConfigWnd.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TConfigWnd.BtnOKClick(Sender: TObject);
var
  CommandLine : String;

begin
  Registry := TRegistry.Create;
  Registry.OpenKey('\Software\'+company+'\'+product,TRUE);
  If not FileExists(EditPathEmulator.Text) then
    MessageDlg('Invalid Path for the Emulator',mtError,[mbOK],0)
  Else
    begin
      Registry.WriteString('PathEmulator',EditPathEmulator.Text);
      If not DirectoryExists(EditPathRoms.Text) then
        MessageDlg('Invalid Roms Directory',mtError,[mbOK],0)
      Else
        begin
          Registry.WriteString('PathRoms',EditPathRoms.Text);
        end;
    end;
 If CheckBox16bit.Checked then CommandLine := ' -16';
 If CheckBoxHiRes.Checked then CommandLine := CommandLine + ' -hires';
 Registry.WriteString('CmdLine',CommandLine);
 Registry.Free;
 IniFile := TIniFile.Create(ExtractFileDir(EditPathEmulator.Text)+'\SNES9x.INI');
 // Graphics Page
 // [graphics]
 IniFile.WriteString('graphics','Transparency',IntToStr(Integer(CheckBoxTransparency.Checked)));
 IniFile.WriteString('graphics','BGLayering',IntToStr(Integer(CheckBoxBGLayering.Checked)));
 IniFile.WriteString('graphics','DisableGraphicWindows',IntToStr(Integer(NOT CheckBoxWindows.Checked)));
 IniFile.WriteString('graphics','DisableHDMA',IntToStr(Integer(NOT CheckBoxHDMA.Checked)));
 If ComboBoxScrMode.ItemIndex = 13 then IniFile.WriteString('graphics','mode','')
 Else IniFile.WriteString('graphics','mode',IntToStr(ComboBoxScrMode.ItemIndex));
 IniFile.WriteString('graphics','wait_for_vsync',IntToStr(Integer(CheckBoxVSync.Checked)));
 IniFile.WriteString('graphics','stretch',IntToStr(Integer(CheckBoxStretch.Checked)));
 IniFile.WriteString('graphics','TV',IntToStr(Integer(CheckBoxTVMode.Checked)));
 // [cpu]
 IniFile.WriteString('cpu','H_Max',ComboBoxCpuCycles.Items.Strings[ComboBoxCpuCycles.ItemIndex]);
 // [timer]
 If ComboBoxSkipFrames.ItemIndex = 10 then IniFile.WriteString('timer','SkipFrames','')
 Else IniFile.WriteString('timer','SkipFrames',ComboBoxSkipFrames.Items.Strings[ComboBoxSkipFrames.ItemIndex]);
 IniFile.WriteString('timer','NTSCtiming',EditNTSC.Text);
 IniFile.WriteString('timer','PALtiming',EditPAL.Text);
 // Sound Page
 // [sound]
 IniFile.WriteString('sound','APUEnabled',IntToStr(Integer(CheckBoxSound.Checked)));
 IniFile.WriteString('sound','Stereo',IntToStr(Integer(CheckBoxStereo.Checked)));
 IniFile.WriteString('sound','SoundPlaybackRate',IntToStr(ComboBoxPlayrate.ItemIndex));
 IniFile.WriteString('sound','SoundBufferSize',ComboBoxBuffer.Items.Strings[ComboBoxBuffer.ItemIndex]);
 IniFile.WriteString('sound','SoundEnvelopeHeightReading',IntToStr(Integer(CheckBoxVolume.Checked)));
 IniFile.WriteString('sound','DisableSoundEcho',IntToStr(Integer(NOT CheckBoxSoundEffects.Checked)));
 IniFile.WriteString('sound','DisableMasterVolume',IntToStr(Integer(NOT CheckBoxMasterVolume.Checked)));
 IniFile.WriteString('sound','DisableSampleCaching',IntToStr(Integer(NOT CheckBoxSoundCaching.Checked)));
 IniFile.WriteString('sound','Shutdown',IntToStr(Integer(NOT CheckBoxSpeedHacks.Checked)));
 IniFile.WriteString('sound','SoundSkipMethod',ComboBoxSoundSkipping.Items.Strings[ComboBoxSoundSkipping.ItemIndex]);
 IniFile.WriteString('sound','SurroundSnd',IntToStr(Integer(CheckBoxSurround.Checked)));
 // Controls Page
 IniFile.WriteString('joystick','JoystickEnabled',IntToStr(Integer(CheckBoxjoystick.Checked)));
 If ComboBoxJoyButtons.ItemIndex = 0 then IniFile.WriteString('joystick','JoystickButtons','')
 Else IniFile.WriteString('joystick','JoystickButtons',ComboBoxJoyButtons.Items.Strings[ComboBoxJoyButtons.ItemIndex]);
 If ComboBoxKeyboard.ItemIndex = 0 then
   Begin
     // Grava o que está
     IniFile.WriteInteger('keyboard1','Left',Keys[ComboBoxKeyLeft.ItemIndex]);
     IniFile.WriteInteger('keyboard1','Right',Keys[ComboBoxKeyRight.ItemIndex]);
     IniFile.WriteInteger('keyboard1','Up',Keys[ComboBoxKeyUp.ItemIndex]);
     IniFile.WriteInteger('keyboard1','Down',Keys[ComboBoxKeyDown.ItemIndex]);
     IniFile.WriteInteger('keyboard1','LButton',Keys[ComboBoxKeyL.ItemIndex]);
     IniFile.WriteInteger('keyboard1','RButton',Keys[ComboBoxKeyR.ItemIndex]);
     IniFile.WriteInteger('keyboard1','YButton',Keys[ComboBoxKeyY.ItemIndex]);
     IniFile.WriteInteger('keyboard1','XButton',Keys[ComboBoxKeyX.ItemIndex]);
     IniFile.WriteInteger('keyboard1','AButton',Keys[ComboBoxKeyA.ItemIndex]);
     IniFile.WriteInteger('keyboard1','BButton',Keys[ComboBoxKeyB.ItemIndex]);
     IniFile.WriteInteger('keyboard1','StartButton',Keys[ComboBoxKeyStart.ItemIndex]);
     IniFile.WriteInteger('keyboard1','SelectButton',Keys[ComboBoxKeySelect.ItemIndex]);
     IniFile.WriteInteger('keyboard1','DiagUpLeft',Keys[ComboBoxKeyDiagUpLeft.ItemIndex]);
     IniFile.WriteInteger('keyboard1','DiagUpRight',Keys[ComboBoxKeyDiagUpRight.ItemIndex]);
     IniFile.WriteInteger('keyboard1','DiagDownLeft',Keys[ComboBoxKeyDiagDownLeft.ItemIndex]);
     IniFile.WriteInteger('keyboard1','DiagDownRight',Keys[ComboBoxKeyDiagDownRight.ItemIndex]);
   End
 Else
   Begin
     // Grava o que está
     IniFile.WriteInteger('keyboard2','Left',Keys[ComboBoxKeyLeft.ItemIndex]);
     IniFile.WriteInteger('keyboard2','Right',Keys[ComboBoxKeyRight.ItemIndex]);
     IniFile.WriteInteger('keyboard2','Up',Keys[ComboBoxKeyUp.ItemIndex]);
     IniFile.WriteInteger('keyboard2','Down',Keys[ComboBoxKeyDown.ItemIndex]);
     IniFile.WriteInteger('keyboard2','LButton',Keys[ComboBoxKeyL.ItemIndex]);
     IniFile.WriteInteger('keyboard2','RButton',Keys[ComboBoxKeyR.ItemIndex]);
     IniFile.WriteInteger('keyboard2','YButton',Keys[ComboBoxKeyY.ItemIndex]);
     IniFile.WriteInteger('keyboard2','XButton',Keys[ComboBoxKeyX.ItemIndex]);
     IniFile.WriteInteger('keyboard2','AButton',Keys[ComboBoxKeyA.ItemIndex]);
     IniFile.WriteInteger('keyboard2','BButton',Keys[ComboBoxKeyB.ItemIndex]);
     IniFile.WriteInteger('keyboard2','StartButton',Keys[ComboBoxKeyStart.ItemIndex]);
     IniFile.WriteInteger('keyboard2','SelectButton',Keys[ComboBoxKeySelect.ItemIndex]);
     IniFile.WriteInteger('keyboard2','DiagUpLeft',Keys[ComboBoxKeyDiagUpLeft.ItemIndex]);
     IniFile.WriteInteger('keyboard2','DiagUpRight',Keys[ComboBoxKeyDiagUpRight.ItemIndex]);
     IniFile.WriteInteger('keyboard2','DiagDownLeft',Keys[ComboBoxKeyDiagDownLeft.ItemIndex]);
     IniFile.WriteInteger('keyboard2','DiagDownRight',Keys[ComboBoxKeyDiagDownRight.ItemIndex]);
   End;
 IniFile.Free;
 Close;
end;

procedure TConfigWnd.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := TRUE;
end;

procedure TConfigWnd.CheckBoxSoundClick(Sender: TObject);
begin
  If CheckBoxSound.Checked then
    Begin
      ComboBoxSoundSkipping.ItemIndex := 0;
      ComboBoxSoundSkipping.Enabled := FALSE;
    End
  Else ComboBoxSoundSkipping.Enabled := TRUE;
end;

procedure TConfigWnd.ComboBoxKeyboardClick(Sender: TObject);
begin
  If KeybActual <> ComboBoxKeyboard.ItemIndex  then
    Begin
      IniFile := TIniFile.Create(ExtractFileDir(EditPathEmulator.Text)+'\SNES9x.INI');
      If KeybActual = 0 then
        Begin
          // Grava o que está
          IniFile.WriteInteger('keyboard1','Left',Keys[ComboBoxKeyLeft.ItemIndex]);
          IniFile.WriteInteger('keyboard1','Right',Keys[ComboBoxKeyRight.ItemIndex]);
          IniFile.WriteInteger('keyboard1','Up',Keys[ComboBoxKeyUp.ItemIndex]);
          IniFile.WriteInteger('keyboard1','Down',Keys[ComboBoxKeyDown.ItemIndex]);
          IniFile.WriteInteger('keyboard1','LButton',Keys[ComboBoxKeyL.ItemIndex]);
          IniFile.WriteInteger('keyboard1','RButton',Keys[ComboBoxKeyR.ItemIndex]);
          IniFile.WriteInteger('keyboard1','YButton',Keys[ComboBoxKeyY.ItemIndex]);
          IniFile.WriteInteger('keyboard1','XButton',Keys[ComboBoxKeyX.ItemIndex]);
          IniFile.WriteInteger('keyboard1','AButton',Keys[ComboBoxKeyA.ItemIndex]);
          IniFile.WriteInteger('keyboard1','BButton',Keys[ComboBoxKeyB.ItemIndex]);
          IniFile.WriteInteger('keyboard1','StartButton',Keys[ComboBoxKeyStart.ItemIndex]);
          IniFile.WriteInteger('keyboard1','SelectButton',Keys[ComboBoxKeySelect.ItemIndex]);
          IniFile.WriteInteger('keyboard1','DiagUpLeft',Keys[ComboBoxKeyDiagUpLeft.ItemIndex]);
          IniFile.WriteInteger('keyboard1','DiagUpRight',Keys[ComboBoxKeyDiagUpRight.ItemIndex]);
          IniFile.WriteInteger('keyboard1','DiagDownLeft',Keys[ComboBoxKeyDiagDownLeft.ItemIndex]);
          IniFile.WriteInteger('keyboard1','DiagDownRight',Keys[ComboBoxKeyDiagDownRight.ItemIndex]);
          // Lê o que não está
          ComboBoxKeyLeft.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','Left',12)];
          ComboBoxKeyRight.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','Right',12)];
          ComboBoxKeyUp.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','Up',12)];
          ComboBoxKeyDown.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','Down',12)];
          ComboBoxKeyL.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','LButton',12)];
          ComboBoxKeyR.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','RButton',12)];
          ComboBoxKeyY.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','YButton',12)];
          ComboBoxKeyX.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','XButton',12)];
          ComboBoxKeyA.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','AButton',12)];
          ComboBoxKeyB.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','BButton',12)];
          ComboBoxKeyStart.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','StartButton',12)];
          ComboBoxKeySelect.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','SelectButton',12)];
          ComboBoxKeyDiagUpLeft.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','DiagUpLeft',12)];
          ComboBoxKeyDiagUpRight.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','DiagUpRight',12)];
          ComboBoxKeyDiagDownLeft.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','DiagDownLeft',12)];
          ComboBoxKeyDiagDownRight.ItemIndex := Keys2[IniFile.ReadInteger('keyboard2','DiagDownRight',12)];
        End
      Else
        Begin
          // Grava o que está
          IniFile.WriteInteger('keyboard2','Left',Keys[ComboBoxKeyLeft.ItemIndex]);
          IniFile.WriteInteger('keyboard2','Right',Keys[ComboBoxKeyRight.ItemIndex]);
          IniFile.WriteInteger('keyboard2','Up',Keys[ComboBoxKeyUp.ItemIndex]);
          IniFile.WriteInteger('keyboard2','Down',Keys[ComboBoxKeyDown.ItemIndex]);
          IniFile.WriteInteger('keyboard2','LButton',Keys[ComboBoxKeyL.ItemIndex]);
          IniFile.WriteInteger('keyboard2','RButton',Keys[ComboBoxKeyR.ItemIndex]);
          IniFile.WriteInteger('keyboard2','YButton',Keys[ComboBoxKeyY.ItemIndex]);
          IniFile.WriteInteger('keyboard2','XButton',Keys[ComboBoxKeyX.ItemIndex]);
          IniFile.WriteInteger('keyboard2','AButton',Keys[ComboBoxKeyA.ItemIndex]);
          IniFile.WriteInteger('keyboard2','BButton',Keys[ComboBoxKeyB.ItemIndex]);
          IniFile.WriteInteger('keyboard2','StartButton',Keys[ComboBoxKeyStart.ItemIndex]);
          IniFile.WriteInteger('keyboard2','SelectButton',Keys[ComboBoxKeySelect.ItemIndex]);
          IniFile.WriteInteger('keyboard2','DiagUpLeft',Keys[ComboBoxKeyDiagUpLeft.ItemIndex]);
          IniFile.WriteInteger('keyboard2','DiagUpRight',Keys[ComboBoxKeyDiagUpRight.ItemIndex]);
          IniFile.WriteInteger('keyboard2','DiagDownLeft',Keys[ComboBoxKeyDiagDownLeft.ItemIndex]);
          IniFile.WriteInteger('keyboard2','DiagDownRight',Keys[ComboBoxKeyDiagDownRight.ItemIndex]);
          // Lê o que não está
          ComboBoxKeyLeft.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','Left',12)];
          ComboBoxKeyRight.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','Right',12)];
          ComboBoxKeyUp.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','Up',12)];
          ComboBoxKeyDown.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','Down',12)];
          ComboBoxKeyL.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','LButton',12)];
          ComboBoxKeyR.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','RButton',12)];
          ComboBoxKeyY.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','YButton',12)];
          ComboBoxKeyX.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','XButton',12)];
          ComboBoxKeyA.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','AButton',12)];
          ComboBoxKeyB.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','BButton',12)];
          ComboBoxKeyStart.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','StartButton',12)];
          ComboBoxKeySelect.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','SelectButton',12)];
          ComboBoxKeyDiagUpLeft.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','DiagUpLeft',12)];
          ComboBoxKeyDiagUpRight.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','DiagUpRight',12)];
          ComboBoxKeyDiagDownLeft.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','DiagDownLeft',12)];
          ComboBoxKeyDiagDownRight.ItemIndex := Keys2[IniFile.ReadInteger('keyboard1','DiagDownRight',12)];
        End;
      KeybActual := ComboBoxKeyboard.ItemIndex;
      IniFile.Free;
    End;
end;

end.
