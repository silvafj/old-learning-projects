unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, CoolForm, Registry, Fmxutils, ZipMstr, ComCtrls;

type
  TMainWnd = class(TForm)
    ListBoxGames: TListBox;
    ImageGame: TImage;
    Bevel1: TBevel;
    LabelGame: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Bevel2: TBevel;
    Label4: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    BtnConfig: TBitBtn;
    ImgClose: TImage;
    BtnRun: TBitBtn;
    LabelGames: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    ZipMaster: TZipMaster;
    CoolForm1: TCoolForm;
    Animation: TAnimate;
    Bevel3: TBevel;
    Shape1: TShape;
    Label17: TLabel;
    ProgressBar1: TProgressBar;
    procedure ImgCloseClick(Sender: TObject);
    procedure ImgCloseMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure CoolForm1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BtnConfigClick(Sender: TObject);
    procedure BtnRunClick(Sender: TObject);
    procedure ListBoxGamesClick(Sender: TObject);
    procedure ListBoxGamesDblClick(Sender: TObject);
    procedure ResetBar;
    procedure ZipMasterProgress(Sender: TObject; ProgrType: ProgressType;
      Filename: string; FileSize: Integer);
    function GetShortName(sLongName: string): string;
  private
      { Private declarations }
    ActiveCloseButton: Boolean;
    Registry: TRegistry;
  public
      { Public declarations }
    TotalSize1, TotalProgress1: Comp;
  end;

const
  Company = 'NightSpy';
  Product = 'SSE NeoGeo Manager';

var
  MainWnd: TMainWnd;
  Prog_dir: string;
  RomsPath, EmulatorPath: string;

implementation

uses Config;

{$R *.DFM}

procedure TMainWnd.ImgCloseClick(Sender: TObject);
begin
  MainWnd.Close;
end;

procedure TMainWnd.ImgCloseMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if not ActiveCloseButton then ImgClose.Picture.Bitmap.LoadFromFile(Prog_Dir + '\Close2.BMP');
  ActiveCloseButton := TRUE;
end;

procedure TMainWnd.FormCreate(Sender: TObject);
var
  Found: integer;
  SearchRec: TSearchRec;
  Game: string;

begin
  Animation.Play(1, 101, 0);
  ResetBar;
  ActiveCloseButton := FALSE;
  Prog_dir := ExtractFileDir(ParamStr(0));
   // Load Database
// Para fazer numa próxima versão
//   Database.ReadDatabase(Prog_Dir+'\Roms.DAT');
   // Scan ROMS
  Registry := TRegistry.Create; // Init Registry
  Registry.OpenKey('\Software\' + company + '\' + product, TRUE);
  RomsPath := Registry.ReadString('PathRoms');
  Registry.Free;
   // Find SNES Zip files
  Found := FindFirst(RomsPath + '\*.ZIP', faAnyFile, SearchRec);
  while Found = 0 do
  begin
    Game := SearchRec.Name;
    Game := StrPas(PChar(Game));
    Delete(Game, Pos('.zip', Game), 4);
    MainWnd.ListBoxGames.Items.Add(Game);
    Found := FindNext(SearchRec);
  end;
  FindClose(SearchRec);
  LabelGames.Caption := InttoStr(ListBoxGames.Items.Count);
end;

procedure TMainWnd.CoolForm1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if ActiveCloseButton then ImgClose.Picture.Bitmap.LoadFromFile(Prog_Dir + '\Close1.BMP');
  ActiveCloseButton := FALSE;
end;

procedure TMainWnd.BtnConfigClick(Sender: TObject);
var
  ConfigWnd: TConfigWnd;
begin
  ConfigWnd := TConfigWnd.Create(Application);
  try
    ConfigWnd.ShowModal;
  finally
    ConfigWnd.Free;
  end;
end; { TMainWnd.BtnConfigClick }

{ Will run the game }

procedure TMainWnd.BtnRunClick(Sender: TObject);
var
  SelectedGame: string;
  ZIPFile: string;
  ExtrPath: string;
  OutputFile: TextFile;
//  pgr : PROMsRec;
  CommandLine: string;

begin
  if ListBoxGames.ItemIndex >= 0 then
  begin
    Registry := TRegistry.Create;
    Registry.OpenKey('\Software\' + company + '\' + product, TRUE);
    RomsPath := Registry.ReadString('PathRoms');
    EmulatorPath := Registry.ReadString('PathEmulator');
    CommandLine := Registry.ReadString('CmdLine');
    Registry.Free;
    SelectedGame := ListBoxGames.Items[ListBoxGames.ItemIndex];

//      pgr := FindRecord(SelectedGame);
      // Procura na base de dados **** para mudar
    ZIPFile := RomsPath + '\' + SelectedGame + '.zip';
//      GameFile := SelectedGame;

    ExtrPath := ExtractFileDir(EmulatorPath);
    AssignFile(OutputFile, ExtrPath + '\Run.Bat');
    ReWrite(OutputFile);
    WriteLn(OutputFile, '@echo off');
    WriteLn(OutputFile, 'echo ' + SelectedGame);
    WriteLn(OutputFile, 'NeoRage GameDir ' + CommandLine);
      // Start extraction
    ZipMaster.ZipFilename := ZIPFile;
    CreateDir(ExtrPath + '\GameDir');
    ZipMaster.ExtrBaseDir := ExtrPath + '\GameDir';
    ZipMaster.FSpecArgs.Add('*.*');
    ZipMaster.Password := '!!!future123098#**++qwerty$$$!!!';
    ZipMaster.Extract;
      // Extraction finished
    WriteLn(OutputFile, 'Deltree /Y GameDir');
    WriteLn(OutputFile, 'exit');
    CloseFile(OutputFile);
    SetCurrentDir(ExtrPath);
//  MessageDlg(GetCurrentDir,mtError,[mbOK],0);
    ExecuteFile(ExtrPath + '\Run.Bat', '', '', SW_SHOWMAXIMIZED);
  end;
end; { TMainWnd.BtnRunClick }

procedure TMainWnd.ListBoxGamesClick(Sender: TObject);
begin
  LabelGame.Caption := ListBoxGames.Items[ListBoxGames.ItemIndex];
  if FileExists(RomsPath + '\Images\' + ListBoxGames.Items[ListBoxGames.ItemIndex] + '.bmp') then
    ImageGame.Picture.LoadFromFile(RomsPath + '\Images\' + ListBoxGames.Items[ListBoxGames.ItemIndex] + '.bmp')
  else
    ImageGame.Picture.LoadFromFile(RomsPath + '\Images\NoPreview.bmp');
end;

procedure TMainWnd.ListBoxGamesDblClick(Sender: TObject);
begin
  MainWnd.BtnRunClick(self);
end;

procedure TMainWnd.ResetBar;
begin
  with MainWnd.ProgressBar1 do
  begin { reset the bar: make it empty }
    min := 1;
    max := 100;
    step := 1;
    position := min;
  end;
end;

procedure TMainWnd.ZipMasterProgress(Sender: TObject;
  ProgrType: ProgressType; Filename: string; FileSize: Integer);
var
  Step: Integer;
begin
  case ProgrType of
    TotalSize2Process:
      begin
        with ProgressBar1 do
        begin
          Max := 10001;
          Position := 1; // Current position of bar.
          Step := 100;
        end;
        TotalSize1 := FileSize;
        TotalProgress1 := 0;
      end;
    TotalFiles2Process:
      begin
      end;
    NewFile:
      begin
      end;
    ProgressUpdate:
      begin
        TotalProgress1 := TotalProgress1 + FileSize;
        if TotalSize1 <> 0 then
        begin
{$IFDEF VER120} // D4
          Step := 2147483647;
//               Step := Integer( Int64(TotalProgress1) * Int64(10000) div Int64(TotalSize1) );
{$ELSE} // D2 and D3
          try
            Step := 2147483647;
//                  Step := Round( TotalProgress1 * 10000 / TotalSize1 );
          except
            Step := 2147483647;
          end;
{$ENDIF}
          ProgressBar1.Position := 1 + Step;
        end
        else
          ProgressBar1.Position := 10001;
      end;
    EndOfBatch: // Reset the progress bar and filename.
      begin
        ProgressBar1.Position := 1;
      end;
  end; // EOF Case
  Application.ProcessMessages;
end;

function TMainWnd.GetShortName(sLongName: string): string;
var
  sShortName: string;
  nShortNameLen: integer;
begin
  SetLength(sShortName,
    MAX_PATH);

  nShortNameLen :=
    GetShortPathName(
    PChar(sLongName),
    PChar(sShortName),
    MAX_PATH - 1);

  if (0 = nShortNameLen) then
  begin
    // handle errors...
  end;

  SetLength(sShortName,
    nShortNameLen);

  Result := sShortName;
end;

end.

