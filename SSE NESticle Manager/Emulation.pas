unit Emulation;

interface

uses
  SysUtils, Classes, Registry;

type GamesRec = packed record
  Index        : Byte;   //(1)
  GameName     : String; // variable size
  ZipFileName  : String; // variable size
  GameFileName : String; // variable size
end;

type
  PGamesRec = ^GamesRec;

var
  Reg : TRegistry;
  GamesList : TList;

  function GetGameName(GameIn : string):string;
  procedure FreeGamesRecord;
  procedure AddRecord(Name, ZipFileName, GameFileName : string);  { create a new record }
  function FindGameFile(Game : String; ZipOrFile : integer) : string;

implementation

function GetGameName(GameIn : string):string;
var
  Game : string;
  Posicao, i : integer;

begin
  GameIn := LowerCase(GameIn);
  Posicao := Pos('.nes',GameIn) - 1;
  If (Posicao > 0) then
    begin
      For i:=1 to Posicao do
        begin
          If (GameIn[i] <> '_') then Insert(GameIn[i],Game,i)
          Else
            begin
              Insert(' ',Game,i);
              GameIn[i+1] := UpCase(GameIn[i+1]);
            end;
        end;
    Game[1] := UpCase(Game[1]);
    Result := Game;
    end
  else
    Result := '';
end;

procedure FreeGamesRecord;
var
   i: Integer;
begin
   GamesList := TList.Create;
   if GamesList.Count = 0 then Exit;
   for i := (GamesList.Count - 1) downto 0 do
   begin
      if Assigned(GamesList[i]) then
         // dispose of the memory pointed-to by this entry
         Dispose( PGamesRec(GamesList[i]));
      GamesList.Delete(i); // delete the TList pointer itself
   end; { end for }
   // The caller will free the FZipContents TList itself, if needed
end;

procedure AddRecord(Name, ZipFileName, GameFileName : string);  { create a new record }

var
  pgr : PGamesRec;

begin
  { zero out any previous entries }
//  FreeGamesRecord;
  // Create a new GamesRec pointer and add it to our contents table.
  New(pgr);  // These will be deleted in: FreeGamesRec.
  GamesList.Add(pgr);
  pgr^.GameName := Name;
  pgr^.ZipFileName := ZipFileName;
  pgr^.GameFileName := GameFileName;
  pgr^.Index := GamesList.Count - 1;
end;

function FindGameFile(Game : String; ZipOrFile : integer) : string;
var
   i: Integer;

begin
   if GamesList.Count = 0 then result := 'Game Not Found';
   for i := 0 to GamesList.Count - 1 do
     begin
       with GamesRec(GamesList[i]^) do
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
