unit Security;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry, DiskCaps;

type
  TCheck = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function Code : Boolean;
    function CDROM(var Drv, Ser : String) : Boolean;
  end;

var
  Check: TCheck;

implementation

{$R *.DFM}

function TCheck.Code : Boolean;

const
  Company = 'NightSpy';
  Product = 'Emulation CD';

var
  Registry : TRegistry;
  Temp : Extended;
  I : Integer;
  Name, Morada1, Morada2, Telefone, Serial : String;
  Code : Extended;

begin
  Registry := TRegistry.Create;
  Registry.OpenKey('\Software\'+company+'\'+product,TRUE);
  Name := Registry.ReadString('Name');
  Morada1 := Registry.ReadString('Morada 1');
  Morada2 := Registry.ReadString('Morada 2');
  Telefone :=Registry.ReadString('Telefone');
  Serial := Registry.ReadString('Serial');
  Code := Registry.ReadFloat('Code');
  Registry.Destroy;
  Temp := 0;
  for i := 1 to StrLen(PChar(Name)) do
    begin
      Temp := Temp + ((Ord(Name[i])*564738291) div 6);
    end;
  for i := 1 to StrLen(PChar(Morada1)) do
    begin
      Temp := Temp + ((Ord(Morada1[i])*123459876) div 5);
    end;
  for i := 1 to StrLen(PChar(Morada2)) do
    begin
      Temp := Temp + ((Ord(Morada2[i])*908756431) div 4);
    end;
  for i := 1 to StrLen(PChar(Telefone)) do
    begin
      Temp := Temp + ((Ord(Telefone[i])*564738291) div 3);
    end;
  for i := 1 to StrLen(PChar(Serial)) do
    begin
      Temp := Temp + ((Ord(Serial[i])*123987) div 2);
    end;
  If Code = Temp then Result := TRUE
  else Result := FALSE;
end;

function TCheck.CDROM(var Drv, Ser : String) : Boolean;
const
  Company  = 'NightSpy';
  Product  = 'SSE SNES Manager';
  Product1 = 'Emulation CD';

var
  Disk : TDiskCaps;
  Registry : TRegistry;
  Serial : String;
  DiskDrive : String;
  DiskDriveType : Integer;
  DiskSerial : String;

begin
  Registry := TRegistry.Create;
  Registry.OpenKey('\Software\'+company+'\'+product,TRUE);
  DiskDrive := ExtractFileDrive(Registry.ReadString('PathRoms'));
  Registry.OpenKey('\Software\'+company+'\'+product1,TRUE);
  Serial := Registry.ReadString('Serial');
  Registry.Destroy;
  Disk := TDiskCaps.Create(application);
  Disk.Drive := DiskDrive[1];
  Disk.ExamineDrive;
  DiskSerial := Disk.DiskSerial;
  Insert('-',DiskSerial,5);
  DiskDriveType := Disk.DriveType;
//MessageDlg(IntToStr(DiskDriveType)+' mudar para 5 na ultima compilação',mtCustom,[mbOK],0);
//MessageDlg(DiskSerial,mtCustom,[mbOK],0);
  Disk.Destroy;
  If (DiskSerial <> Serial) OR (DiskDriveType <> 5) then
    Result := FALSE
  else
    Result := TRUE;
  Drv := DiskDrive[1];
  Ser := Serial;
end;

end.
