unit Security;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, DiskCaps;

type
  TAlgorithm = class(TDataModule)
  private
    { Private declarations }
    DiskInfo : TDiskCaps;
  public
    { Public declarations }
    function CorrectCode(CodeIn : String) : Boolean;
  end;

implementation

{$R *.DFM}

function TAlgorithm.CorrectCode(CodeIn : String) : Boolean;
var
  Code : String;
  Temp : Integer;
  I : Integer;

begin
  DiskInfo := TDiskCaps.Create(Application);
  DiskInfo.Drive := 'C';
  DiskInfo.ExamineDrive;
  Code := '';
  Temp := 0;
  for i := 1 to StrLen(PChar(DiskInfo.DiskSerial)) do
    begin
      Temp := Temp + ((Ord(DiskInfo.DiskSerial[i])*123987456) div 3);
    end;
  Code := Code + IntToStr(Temp);
  if CodeIn = Code then Result := TRUE
  else Result := FALSE;
  DiskInfo.Destroy;
end;
end.
