unit Main;

{$I Defines.PAS}

interface

uses
  { Default Units}
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,
  { Other Units }
  Registry,
  { Forms }
  Config,
  { Code Units}
  Emulation, ZipMstr, FMXUtils,
  {$ifndef CDEmul} About;
  {$else} About2, Security;
  {$endif}

type
  TMainWnd = class(TForm)
    ListGames: TListBox;
    BtnRun: TBitBtn;
    BtnConfig: TBitBtn;
    BtnScan: TBitBtn;
    ImgBackground: TImage;
    NumGames: TEdit;
    ZipMaster: TZipMaster;
    AboutBtn: TBitBtn;
    procedure BtnScanClick(Sender: TObject);
    procedure ListGamesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BtnRunClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListGamesDblClick(Sender: TObject);
    procedure AboutBtnClick(Sender: TObject);
    procedure BtnConfigClick(Sender: TObject);
  private
    { Private declarations }
    Registry : TRegistry;
    {$ifdef CDEmul} Algorithm : TAlgorithm; {$endif}
  public
    { Public declarations }
  end;

var
  MainWnd: TMainWnd;

implementation

{$R *.DFM}

{ When executing it will Scan all files for all games}
procedure TMainWnd.BtnScanClick(Sender: TObject);
var
  RomsPath : string;
  Found : integer;
  SearchRec : TSearchRec;
  Game : string;
  i : integer;

begin
  ListGames.Clear; // Clear Form List
  FreeGamesRecord; // Clear Data record
  Registry := TRegistry.Create; // Init Registry
  Registry.OpenKey('\Software\Fernando Silva (aka ^Magico^)\SSE NESticle Manager',TRUE);
  RomsPath := Registry.ReadString('PathRoms');
  Registry.Free;
  // Find individual NES files
  Found := FindFirst(RomsPath+'\*.NES',faAnyFile,SearchRec);
  while Found = 0 do
    begin
      Game := GetGameName(SearchRec.Name);
      AddRecord(Game,'',RomsPath+'\'+SearchRec.Name);
      Found := FindNext(SearchRec);
    end;
  FindClose(SearchRec);
  // Find ZIP files, for search for compacted NES files
  Found := FindFirst(RomsPath+'\*.ZIP',faAnyFile,SearchRec);
  while Found = 0 do
    begin
      ZipMaster.ZipFilename := RomsPath+'\'+SearchRec.Name;
      For i:=0 to ZipMaster.ZipContents.Count-2 do
         begin
           with ZipDirEntry(ZipMaster.ZipContents[i]^) do
             begin
               Game := GetGameName(FileName);
               If (Game <> '') then AddRecord(Game,ZipMaster.ZipFilename,FileName);
             end;
         end;
      Found := FindNext(SearchRec);
    end;
  FindClose(SearchRec);
  for i:=0 to GamesList.Count - 1 do
    begin
      with GamesRec(GamesList[i]^) do
        begin
          MainWnd.ListGames.Items.Add(GameName);
        end;
    end;
  NumGames.Text := InttoStr(ListGames.Items.Count);
end; { TMainWnd.BtnScanClick }

{ When mouse is moving, it will check the hint }
procedure TMainWnd.ListGamesMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  Game : String;

begin
  If (ListGames.ItemIndex < 0) then ListGames.Hint := 'All Games Found'
  Else
    begin
      Game := ListGames.Items[ListGames.ItemIndex];
      ListGames.Hint := Game;
    end;
end; { TMainWnd.ListGamesMouseMove }

{ Will run the game }
procedure TMainWnd.BtnRunClick(Sender: TObject);
var
  Game, Nesticle, ExtrPath, ZIPFile,
  GameFile, ItensPath : String;
  OutputFile : TextFile;

begin
  If ListGames.ItemIndex >= 0 then
    begin
      Registry := TRegistry.Create;
      Registry.OpenKey('\Software\Fernando Silva (aka ^Magico^)\SSE NESticle Manager',TRUE);
      Nesticle := Registry.ReadString('PathNesticle');
      ItensPath := Registry.ReadString('PathItens');
      Registry.Free;
      Game := ListGames.Items[ListGames.ItemIndex];
      ZIPFile := FindGameFile(Game,0);
      GameFile := FindGameFile(Game,1);
      ExtrPath := ExtractFileDir(Nesticle);
      AssignFile(OutputFile,ExtrPath+'\Run.Bat');
      ReWrite(OutputFile);
      WriteLn(OutputFile,'@echo off');
      WriteLn(OutputFile,'echo '+Game);
      WriteLn(OutputFile,'"'+Nesticle+'" '+'-run '+GameFile);
      If (ZIPFile <> '') then
        begin
          ZipMaster.ZipFilename := ZIPFile;
          ZipMaster.ExtrBaseDir := ExtrPath;
          ZipMaster.FSpecArgs.Add(GameFile);
          {$ifdef CDEmul}
          ZipMaster.Password := 'abc1234567890xyzMAGICO';
          {$endif}
          ZipMaster.Extract;
          WriteLn(OutputFile,'del '+GameFile);
        end;
     WriteLn(OutputFile,'exit');
     CloseFile(OutputFile);
     AssignFile(OutputFile,ExtrPath+'\NESticle.cmd');
     ReWrite(OutputFile);
     WriteLn(OutputFile,'-savedir '+ItensPath);
     WriteLn(OutputFile,'-pcxdir '+ItensPath);
     WriteLn(OutputFile,'-logdir '+ItensPath);
     WriteLn(OutputFile,'-patchdir '+ItensPath);
     CloseFile(OutputFile);
     ExecuteFile(ExtrPath+'\Run.Bat','','',SW_SHOWMAXIMIZED);
    end;
end; { TMainWnd.BtnRunClick }

{ The same as above, but when double clicking }
procedure TMainWnd.ListGamesDblClick(Sender: TObject);
begin
  BtnRunClick(BtnRun);
end; { TMainWnd.ListGamesDblClick }

{ Init all we really need }
procedure TMainWnd.FormCreate(Sender: TObject);
var
  ConfigWnd : TConfigWnd;

begin
  Registry := TRegistry.Create;
  Registry.OpenKey('\Software\Fernando Silva (aka ^Magico^)\SSE NESticle Manager',TRUE);
  If (Not Registry.ValueExists('PathNesticle')) or
     (Not Registry.ValueExists('PathRoms')) or
     (Not Registry.ValueExists('PathItens')) then
     begin
       Registry.Free;
       ConfigWnd := TConfigWnd.Create(Application);
       try
         ConfigWnd.ShowModal;
       finally
         ConfigWnd.Free;
       end;
     end;
  FreeGamesRecord;
  MainWnd.BtnScanClick(BtnScan);
end; { TMainWnd.FormCreate }

{ Show About Dialog Box }
procedure TMainWnd.AboutBtnClick(Sender: TObject);
var
  {$ifndef CDEmul}
  AboutWnd : TAboutWnd;
  {$else}
  About2Wnd : TAbout2Wnd;
  {$endif}
begin
  {$ifndef CDEmul}
  AboutWnd := TAboutWnd.Create(Application);
  try
    AboutWnd.ShowModal;
  finally
    AboutWnd.Free;
  end;
  {$else}
  About2Wnd := TAbout2Wnd.Create(Application);
  try
    About2Wnd.ShowModal;
  finally
    About2Wnd.Free;
  end;
  {$endif}
end; { TMainWnd.AboutBtnClick }

{ Show Config Dialog Box }
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

end. { FINISH }
