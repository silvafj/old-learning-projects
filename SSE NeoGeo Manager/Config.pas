unit Config;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Buttons, Registry, FileCtrl, CoolForm, IniFiles;

type
  TConfigWnd = class(TForm)
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
    CheckBoxVsync: TCheckBox;
    LabelSkipFrames: TLabel;
    ComboBoxSkipFrames: TComboBox;
    BtnCancel: TBitBtn;
    BtnOK: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog: TOpenDialog;
    CheckBoxVGA: TCheckBox;
    CheckBoxCode: TCheckBox;
    CheckBoxScan: TCheckBox;
    CheckBoxScan25: TCheckBox;
    CheckBoxScan50: TCheckBox;
    CheckBoxScan100: TCheckBox;
    CheckBoxModeX: TCheckBox;
    procedure BrowseBtn1Click(Sender: TObject);
    procedure BrowseBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    Registry : TRegistry;
  public
    { Public declarations }
  end;

const
  Company = 'NightSpy';
  Product = 'SSE NeoGeo Manager';

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
  CheckBoxVGA.Checked := Boolean(Pos('-vga',CommandLine));
  If (Pos('-v',CommandLine) <> 0) AND (CommandLine[Pos('-v',CommandLine)+2] <> 'g') then CheckBoxVsync.Checked := TRUE
  Else CheckBoxVsync.Checked := FALSE;
  If Pos('-noanalyse',CommandLine) <> 0 then CheckBoxCode.Checked := FALSE
  Else CheckBoxCode.Checked := TRUE;
  CheckBoxModeX.Checked := Boolean(Pos('-modex',CommandLine));
  If (Pos('-s',CommandLine) <> 0) AND (CommandLine[Pos('-s',CommandLine)+2] = ' ') then CheckBoxScan.Checked := TRUE
  Else CheckBoxScan.Checked := FALSE;
  CheckBoxScan25.Checked := Boolean(Pos('-s25',CommandLine));
  CheckBoxScan50.Checked := Boolean(Pos('-s50',CommandLine));
  CheckBoxScan100.Checked := Boolean(Pos('-s100',CommandLine));
  If (Pos('-f1',CommandLine) <> 0) then ComboBoxSkipFrames.ItemIndex := 1
  Else If (Pos('-f2',CommandLine) <> 0) then ComboBoxSkipFrames.ItemIndex := 2
  Else If (Pos('-f3',CommandLine) <> 0) then ComboBoxSkipFrames.ItemIndex := 3
  Else If (Pos('-f4',CommandLine) <> 0) then ComboBoxSkipFrames.ItemIndex := 4
  Else ComboBoxSkipFrames.ItemIndex := 0;
  Registry.Free;
  // Initialize Hints
  CheckBoxVsync.Hint := 'Enable vsync (disabled by default) Don''t use this if you have slow framerate !';
  CheckBoxVGA.Hint := 'VGA resoloution';
  CheckBoxCode.Hint := 'Enables/disables the code analyse';
  CheckBoxModeX.Hint := 'Modex 320 X 240';
  CheckBoxScan.Hint := 'Scanlines(Vesa)';
  CheckBoxScan25.Hint := '25% thinner scanlines, very slow! (Vesa)';
  CheckBoxScan50.Hint := '50% thinner scanlines, very slow! (Vesa)';
  CheckBoxScan100.Hint := 'No scanlines, doubles every pixel which makes it possible to run'+#13+
                          'without scanlines in res 640x480, very slow! (Vesa)';
  ComboBoxSkipFrames.Hint := 'Frameskip (You can toggle between frameskip settings with numpad keys + and - )';
  LabelSkipFrames.Hint := ComboBoxSkipFrames.Hint;
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
 If CheckBoxVsync.Checked then CommandLine := CommandLine + ' -v';
 If CheckBoxVGA.Checked then CommandLine := CommandLine + ' -vga';
 If NOT CheckBoxCode.Checked then CommandLine := CommandLine + ' -noanalyse';
 If CheckBoxModeX.Checked then CommandLine := CommandLine + ' -modex';
 If CheckBoxScan.Checked then CommandLine := CommandLine + ' -s';
 If CheckBoxScan25.Checked then CommandLine := CommandLine + ' -s25';
 If CheckBoxScan50.Checked then CommandLine := CommandLine + ' -s50';
 If CheckBoxScan100.Checked then CommandLine := CommandLine + ' -s100';
 If ComboBoxSkipFrames.ItemIndex <> 0 then CommandLine := CommandLine + ' -f'+IntToStr(ComboBoxSkipFrames.ItemIndex);
 Registry.WriteString('CmdLine',CommandLine);
 Registry.Free;
 Close;
end;

procedure TConfigWnd.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := TRUE;
end;

end.
