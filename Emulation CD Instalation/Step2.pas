unit Step2;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, FileCtrl, ZipMstr, Registry,
  ShlObj, ActiveX, ComObj;

type
  TStep2Wnd = class(TForm)
    Label7: TLabel;
    NextButton: TButton;
    EditDir: TEdit;
    BtnBrowse: TButton;
    ZipMaster: TZipMaster;
    procedure BtnBrowseClick(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
    procedure AddToStartMenu(Application, Arguments, ShortcutName, DirName : string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  const
  Company = 'NightSpy';
  Product = 'Emulation CD';
  Product1 = 'SSE SNES Manager';
  Product2 = 'SSE NeoGeo Manager';

var
  Step2Wnd: TStep2Wnd;

implementation

{$R *.DFM}

procedure TStep2Wnd.BtnBrowseClick(Sender: TObject);
var
  dir : string;
begin
  Dir := EditDir.Text;
  if SelectDirectory(dir,[sdAllowCreate,sdPerformCreate,
                          sdPrompt],0) then
  EditDir.Text := dir;
end;

procedure TStep2Wnd.NextButtonClick(Sender: TObject);
var
  Prog_Dir : String;
  Registry : TRegistry;

begin
  If NextButton.Caption = 'Close' then Close
  Else
    Begin
      If Not DirectoryExists(EditDir.Text) then CreateDir(EditDir.Text);
      Step2Wnd.Caption := 'Decompressing and installing... wait... 3 files';
      NextButton.Enabled := FALSE;
      BtnBrowse.Enabled := FALSE;
      EditDir.Enabled := FALSE;
      // Create Directories
      CreateDir(EditDir.Text+'\NightSpy');
      CreateDir(EditDir.Text+'\NightSpy\SSE SNES Manager');
      CreateDir(EditDir.Text+'\NightSpy\SSE NeoGeo Manager');
      CreateDir(EditDir.Text+'\Callus Manager 95');
      // Extract...
      Prog_Dir := ExtractFileDrive(ParamStr(0));
      ZipMaster.ZipFilename := Prog_Dir+'\Emulators\Callus Manager 95.ZIP';
      ZipMaster.ExtrBaseDir := EditDir.Text+'\Callus Manager 95';
      ZipMaster.Extract;
      Step2Wnd.Caption := 'Decompressing and installing... wait... 2 files';
      ZipMaster.ZipFilename := Prog_Dir+'\Emulators\SSE SNES Manager 1.0.ZIP';
      ZipMaster.ExtrBaseDir := EditDir.Text+'\NightSpy\SSE SNES Manager';
      ZipMaster.Extract;
      Step2Wnd.Caption := 'Decompressing and installing... wait... 1 files';
      ZipMaster.ZipFilename := Prog_Dir+'\Emulators\SSE NeoGeo Manager 1.0.ZIP';
      ZipMaster.ExtrBaseDir := EditDir.Text+'\NightSpy\SSE NeoGeo Manager';
      ZipMaster.Extract;
      Step2Wnd.Caption := 'Decompression Finished';
      // Create Registry
      Registry := TRegistry.Create;
      Registry.OpenKey('\Software\'+company+'\'+product1,TRUE);
      Registry.WriteString('PathEmulator',EditDir.Text+'\NightSpy\SSE SNES Manager\SNES9x.exe');
      Registry.Free;
      Registry := TRegistry.Create;
      Registry.OpenKey('\Software\'+company+'\'+product2,TRUE);
      Registry.WriteString('PathEmulator',EditDir.Text+'\NightSpy\SSE NeoGeo Manager\Neorage.exe');
      Registry.Free;
      Registry := TRegistry.Create;
      Registry.OpenKey('\Software\P.O.W.\Callus Manager 95',TRUE);
      Registry.WriteString('img_doswin','1');
      Registry.WriteString('L_CAL',EditDir.Text+'\Callus Manager 95');
      Registry.WriteString('L_SF',EditDir.Text+'\Callus Manager 95\Saves');
      Registry.WriteString('L_PF',EditDir.Text+'\Callus Manager 95\Pcx');
      Registry.WriteString('L_RF',Prog_Dir+'\Roms\Callus');
      Registry.WriteString('L_LF',EditDir.Text+'\Callus Manager 95\Logs');
      Registry.WriteString('SE_AJR','1024');
      Registry.WriteString('CB_ACINET','0');
      Registry.Free;
      // Create Icons
      Step2Wnd.Caption := 'Creating Icons';
      AddToStartMenu(EditDir.Text+'\Callus Manager 95\CalMan95.EXE','', 'Callus Manager 95', 'Emulation CD');
      AddToStartMenu(EditDir.Text+'\NightSpy\SSE SNES Manager\SNESMan.EXE','', 'SSE SNES Manager', 'Emulation CD');
      AddToStartMenu(EditDir.Text+'\NightSpy\SSE NeoGeo Manager\NGeoMan.EXE','', 'SSE NeoGeo Manager', 'Emulation CD');
      // Finish
      Step2Wnd.Caption := 'Finished';
      NextButton.Caption := 'Close';
      NextButton.Enabled := TRUE;
      BtnBrowse.Enabled := TRUE;
      EditDir.Enabled := TRUE;
    End;
end;

procedure TStep2Wnd.AddToStartMenu(Application, Arguments, ShortcutName, DirName : string);
var
  MyObject  : IUnknown;
  MySLink   : IShellLink;
  MyPFile   : IPersistFile;
  FileName  : String;
  Directory : String;
  WFileName : WideString;
  MyReg     : TRegIniFile;

begin
  MyObject := CreateComObject(CLSID_ShellLink);
  MySLink := MyObject as IShellLink;
  MyPFile := MyObject as IPersistFile;
  FileName := Application;
  with MySLink do
    begin
      SetArguments(PChar(Arguments));
      SetPath(PChar(FileName));
      SetWorkingDirectory(PChar(ExtractFilePath(FileName)));
    end;
  MyReg := TRegIniFile.Create('Software\MicroSoft\Windows\CurrentVersion\Explorer');
  // Use the next line of code to put the shortcut on your desktop
  // Directory := MyReg.ReadString('Shell Folders','Desktop','');

  // Use the next three lines to put the shortcut on your start menu
  Directory := MyReg.ReadString('Shell Folders','Start Menu','')+'\Programs\'+DirName;
  CreateDir(Directory);

  WFileName := Directory+'\'+ShortcutName+'.LNK';
  MyPFile.Save(PWChar(WFileName),False);
  MyReg.Free;
end;

end.

