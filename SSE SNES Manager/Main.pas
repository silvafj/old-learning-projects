unit Main;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   StdCtrls, Buttons, ExtCtrls, CoolForm, Registry, Fmxutils, ZipMstr, Database;

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
      CoolForm1: TCoolForm;
      Label4: TLabel;
    ImageGorilla: TImage;
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
    Label17: TLabel;
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
   private
      { Private declarations }
      ActiveCloseButton: Boolean;
      Registry : TRegistry;
   public
      { Public declarations }
   end;

const
  Company = 'NightSpy';
  Product = 'SSE SNES Manager';

var
   MainWnd: TMainWnd;
   Prog_dir : string;
   RomsPath, EmulatorPath : string;

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
   If Not ActiveCloseButton then ImgClose.Picture.Bitmap.LoadFromFile(Prog_Dir+'\Close2.BMP');
   ActiveCloseButton := TRUE;
end;

procedure TMainWnd.FormCreate(Sender: TObject);
var
  Found : integer;
  SearchRec : TSearchRec;
  Game : string;

begin
   ActiveCloseButton := FALSE;
   Prog_dir := ExtractFileDir(ParamStr(0));
   // Load Database
   Database.ReadDatabase(Prog_Dir+'\Roms.DAT');
   // Scan ROMS
   Registry := TRegistry.Create; // Init Registry
   Registry.OpenKey('\Software\'+company+'\'+product,TRUE);
   RomsPath := Registry.ReadString('PathRoms');
   Registry.Free;
   // Find SNES Zip files
   Found := FindFirst(RomsPath+'\*.ZIP',faAnyFile,SearchRec);
   while Found = 0 do
     begin
       Game := SearchRec.Name;
       Game := StrPas(PChar(Game));
       Delete(Game,Pos('.zip',Game),4);
//  MessageDlg(IntToStr(Pos('.zip',Game)),mtError,[mbOK],0);
       MainWnd.ListBoxGames.Items.Add(Game);
       Found := FindNext(SearchRec);
     end;
   FindClose(SearchRec);
   LabelGames.Caption := InttoStr(ListBoxGames.Items.Count);
end;

procedure TMainWnd.CoolForm1MouseMove(Sender: TObject; Shift: TShiftState;
X, Y: Integer);
begin
   If ActiveCloseButton then ImgClose.Picture.Bitmap.LoadFromFile(Prog_Dir+'\Close1.BMP');
   ActiveCloseButton := FALSE;
end;

procedure TMainWnd.BtnConfigClick(Sender: TObject);
var
  ConfigWnd : TConfigWnd;
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
  SelectedGame : string;
  ZIPFile, GameFile : string;
  ExtrPath : String;
  OutputFile : TextFile;
  pgr : PROMsRec;
  CommandLine : string;

begin
  If ListBoxGames.ItemIndex >= 0 then
    begin
      Registry := TRegistry.Create;
      Registry.OpenKey('\Software\'+company+'\'+product,TRUE);
      RomsPath := Registry.ReadString('PathRoms');
      EmulatorPath := Registry.ReadString('PathEmulator');
      CommandLine := Registry.ReadString('CmdLine');
      Registry.Free;
      SelectedGame := ListBoxGames.Items[ListBoxGames.ItemIndex];

      pgr := FindRecord(SelectedGame);
      // Procura na base de dados **** para mudar
      ZIPFile := RomsPath+'\'+SelectedGame + '.zip';
      GameFile := pgr^.FileName;

      ExtrPath := ExtractFileDir(EmulatorPath);
      AssignFile(OutputFile,ExtrPath+'\Run.Bat');
      ReWrite(OutputFile);
      WriteLn(OutputFile,'@echo off');
      WriteLn(OutputFile,'echo '+SelectedGame);
      WriteLn(OutputFile,'"'+EmulatorPath+'"'+CommandLine+' "'+GameFile+'"');
      // Start extraction
      ZipMaster.ZipFilename := ZIPFile;
      ZipMaster.ExtrBaseDir := ExtrPath+'\';
      ZipMaster.FSpecArgs.Add(GameFile);
      ZipMaster.Password := 'future123098';
      ZipMaster.Extract;
      // Extraction finished
      WriteLn(OutputFile,'del "'+GameFile+'"');
      WriteLn(OutputFile,'exit');
      CloseFile(OutputFile);
      ExecuteFile(ExtrPath+'\Run.Bat','','',SW_SHOWMAXIMIZED);
    end;
end; { TMainWnd.BtnRunClick }

procedure TMainWnd.ListBoxGamesClick(Sender: TObject);
begin
  LabelGame.Caption := ListBoxGames.Items[ListBoxGames.ItemIndex];
  If FileExists(RomsPath+'\Images\'+ListBoxGames.Items[ListBoxGames.ItemIndex]+'.bmp') then
    ImageGame.Picture.LoadFromFile(RomsPath+'\Images\'+ListBoxGames.Items[ListBoxGames.ItemIndex]+'.bmp')
  else
    ImageGame.Picture.LoadFromFile(RomsPath+'\Images\NoPreview.bmp');
end;

procedure TMainWnd.ListBoxGamesDblClick(Sender: TObject);
begin
  MainWnd.BtnRunClick(self);
end;

end.

