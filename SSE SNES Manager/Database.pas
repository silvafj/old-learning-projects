unit Database;

interface
uses
  sysutils, classes;

type TROMsRec = packed record
    // Control
    ZipFileName  : String;
    FileName     : String;
    // ROM
    GameName     : String;
    Country      : Integer;
    Manufacturer : Integer;
    SpecialChip  : Integer;
    GameFormat   : Integer;
    Video        : Integer;
    GameSize     : Integer;
    Header       : Boolean;
    ROM          : Boolean;
    RAM          : Boolean;
    SaveRAM      : Boolean;
    // Other
    GameType     : Integer;
    Reserved_2   : String;
    Reserved_3   : String;
    Reserved_4   : String;
end;

type
  PROMsRec = ^TROMsRec;

var
  ROMsList : TList;

procedure FreeROMsRecord;
function FindRecord(GameNameToFind : string) : pointer;
procedure ReadDatabase(ROMsDatabase : string);

implementation

procedure FreeROMsRecord;
var
   i: Integer;
begin
   ROMsList := TList.Create;
   if ROMsList.Count = 0 then Exit;
   for i := (ROMsList.Count - 1) downto 0 do
   begin
      if Assigned(ROMsList[i]) then
        // dispose of the memory pointed-to by this entry
        Dispose( PROMsRec(ROMsList[i]));
      ROMsList.Delete(i); // delete the TList pointer itself
   end; { end for }
   // The caller will free the FZipContents TList itself, if needed
end;


function AddRecord : pointer;  { create a new record }
var
  pgr : PROMsRec;

begin
//  FreeGamesRecord;
  // Create a new GamesRec pointer and add it to our contents table.
  New(pgr);  // These will be deleted in: FreeGamesRec.
  ROMsList.Add(pgr);
  result := pgr;
end;

function FindRecord(GameNameToFind : string) : Pointer;
var
  i : integer;

begin
  if ROMsList.Count = 0 then result := NIL
  else
    for i := 0 to ROMsList.Count - 1 do
       with TROMsRec(ROMsList[i]^) do
         if StrComp(PChar(GameName),PChar(GameNameToFind)) = 0 then
           begin
             result := ROMsList[i];
             exit;
           end { if... }
          else result := NIL;
end;

procedure ReadDatabase(ROMsDatabase : string);
var
  pgr : PROMsRec;
  ROMRecFile : TextFile;
  Value : integer;

begin
  FreeROMsRecord;
       AssignFile(ROMRecFile,ROMsDatabase);
        Reset(ROMRecFile);
        while not Eof(ROMRecFile) do
          begin
            pgr := AddRecord;
            ReadLn(ROMRecFile,pgr^.ZipFileName);
            ReadLn(ROMRecFile,pgr^.FileName);
            ReadLn(ROMRecFile,pgr^.GameName);
            ReadLn(ROMRecFile,pgr^.Country);
            ReadLn(ROMRecFile,pgr^.Video);
            ReadLn(ROMRecFile,pgr^.Manufacturer);
            ReadLn(ROMRecFile,pgr^.GameSize);
            ReadLn(ROMRecFile,pgr^.SpecialChip);
            ReadLn(ROMRecFile,pgr^.GameFormat);
            ReadLn(ROMRecFile,Value);
            pgr^.Header := Boolean(Value);
            ReadLn(ROMRecFile,Value);
            pgr^.ROM := Boolean(Value);
            ReadLn(ROMRecFile,Value);
            pgr^.RAM := Boolean(Value);
            ReadLn(ROMRecFile,Value);
            pgr^.SaveRAM := Boolean(Value);
          end; { while ... }
        CloseFile(ROMRecFile);
      end; { OpenDialog }
end.
