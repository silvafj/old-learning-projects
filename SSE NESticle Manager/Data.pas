unit Data;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry;

type
  TEmulator = class(TDataModule)
    procedure EmulatorCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Registry : TRegistry;
    FGamesList : TList;
    procedure FreeGamesRecord;
    procedure AddRecord(Name, ZipFileName, GameFileName : string);  { create a new record }
    function FindGameFile(Game : String; ZipOrFile : integer) : string;
//    procedure List;
  end;

type GamesRec = packed record
  Index    : Byte;    //(1)
  GameName     : String;  // variable size
  ZipFileName : String;  // variable size
  GameFileName : String;
end;

type
  PGamesRec = ^GamesRec;

var
  Emulator : TEmulator;

implementation

uses Config;

{$R *.DFM}

procedure TEmulator.EmulatorCreate(Sender: TObject);
var
  ConfigWnd : TConfigWnd;
begin
  Registry := TRegistry.Create;
  Registry.OpenKey('\Software\Fernando Silva (aka ^Magico^)\Nes Manager',TRUE);
  If (Not Registry.ValueExists('PathNesticle')) or
     (Not Registry.ValueExists('PathRoms')) or
     (Not Registry.ValueExists('PathItens')) then
    begin
      Registry.Destroy;
      ConfigWnd := TConfigWnd.Create(Application);
      try
        ConfigWnd.ShowModal;
      finally
        ConfigWnd.Free;
      end;
    end;
  FGamesList := TList.Create;
end;


procedure TEmulator.FreeGamesRecord;
var
   i: Integer;
begin
   if FGamesList.Count = 0 then Exit;
   for i := (FGamesList.Count - 1) downto 0 do
   begin
      if Assigned(FGamesList[i]) then
         // dispose of the memory pointed-to by this entry
         Dispose( PGamesRec(FGamesList[i]));
      FGamesList.Delete(i); // delete the TList pointer itself
   end; { end for }
   // The caller will free the FZipContents TList itself, if needed
end;

procedure TEmulator.AddRecord(Name, ZipFileName, GameFileName : string);  { create a new record }

var
  pgr : PGamesRec;

begin
  { zero out any previous entries }
//  FreeGamesRecord;
  // Create a new GamesRec pointer and add it to our contents table.
  New(pgr);  // These will be deleted in: FreeGamesRec.
  FGamesList.Add(pgr);
  pgr^.GameName := Name;
  pgr^.ZipFileName := ZipFileName;
  pgr^.GameFileName := GameFileName;
  pgr^.Index := FGamesList.Count - 1;
end;

function TEmulator.FindGameFile(Game : String; ZipOrFile : integer) : string;
var
   i: Integer;

begin
   if FGamesList.Count = 0 then result := 'Game Not Found';
   for i := 0 to FGamesList.Count - 1 do
     begin
       with GamesRec(Emulator.FGamesList[i]^) do
        begin
          if StrComp(PChar(GameName),PChar(Game)) = 0 then
            case ZipOrFile of
              0 : result := ZipFileName;
              1 : result := GameFileName;
            else
              result := '';
            end;
       end;
   // The caller will free the FZipContents TList itself, if needed
  end;
end;

end.
