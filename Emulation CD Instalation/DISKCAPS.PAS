{This simple component encapsulates two API functions:
 GetVolumeInformation and GetDriveType
 It allows to check:

 Drive Volume Label
 Drive Serial Number
 Drive file system type
 Length of directory component (unfortunatelly this function returns
                                255 chars almost always :( even in case of
                                MSDOS 8+3)
 and Drive System Flags (which you have to test by you self - in this version)

 you can also change Drive Volume Label
 ChangeDiskLabel(NewLabel:string);
 and...
 If you enable CheckSNChange property - every time Serial Number of removable
 media changes OnSNChange fires. It is similar to Autorun function in system.

 Brief description of properities:

    property DiskLabel: Volume Label of disk pointed by Drive property.
    property DiskSerial: Serial Number of disk. (In Hexadecimal format)
    property ComponentLen: Length of directory component length.
    property FileSystem: File System of drive NTFS, HPFS...
    property DriveType:  0	The drive type cannot be determined.
                         1	The root directory does not exist.
                         2	The drive can be removed from the drive.
                         3	The disk cannot be removed from the drive.
                         4	The drive is a remote (network) drive.
                         5	The drive is a CD-ROM drive.
                         6	The drive is a RAM disk.
    property Drive:      Drive letter
    property CheckSNChange: Enables checking Drive Serial Number state
                            of selected drive.

    property OnDriveChanged: This event is fired every time you change Drive letter
                             allowing update of connected components
    property OnSNChanged:    This event is fired every time Serial Number changes
                             It happen also when CD ROM is ejected (serial no. becomes 0)

    procedure ExamineDrive: This procedure updates state of component.

    Important: Changing Drive property disables CheckSNChange.

    This component is freeware.
    I guarantee you nothing concering this code, but you can use it as you wish.

    Happy coding

    Radoslaw Przybyl
    PRO-media CD
    Poland

    promedia@lodz.pdi.net
    Any comments will be welcome.
    }

unit DiskCaps;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls;

type
  TDiskCaps = class(TComponent)
  private

    FDiskLabel:string;
    FDiskSerial:string;
    FLastSerial:string;
    FComponentLen:integer;
    FFileSystem:string;
    FDriveType: integer;
    FDrive:Char;
    FDriveFlags: DWord;
    FOnDriveChanged : TNotifyEvent;
    FOnSNChanged : TNotifyEvent;
    FCheckPeriod:integer;
    Timer:TTimer;
    FCheckSNChange:boolean;
    procedure SetCheckSNChange(value: boolean);
    procedure SetDrive(Value: char);

    procedure DriveStateChecker(Sender: TObject);
    procedure SetCheckPeriod(value: integer);
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExamineDrive;
    procedure ChangeDiskLabel(NewLabel:string);
  published
    property DiskLabel: string read FDiskLabel write FDiskLabel;
    property DiskSerial: string read FDiskSerial write FDiskSerial;
    property ComponentLen: integer read FComponentLen write FComponentLen;
    property FileSystem: string read FFilesystem write FFilesystem;
    property DriveType:integer read FDriveType write FDriveType;
    property Drive: Char read FDrive write SetDrive default 'C';
    property DriveFlags: DWord read FDriveFlags write FDriveFlags;
    property OnDriveChanged: TNotifyEvent read FOnDriveChanged
                            write FOnDriveChanged;
    property OnSNChanged: TNotifyEvent read FOnSNChanged
                            write FOnSNChanged;

    property CheckSNChange: boolean read FCheckSNChange write SetCheckSNChange default false;
    property CheckPeriod: integer read FCheckPeriod write SetCheckPeriod default 2000;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TDiskCaps]);
end;

constructor TDiskCaps.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDrive:='C';
  ExamineDrive;
  FCheckSNChange:=false;
  FCheckPeriod:=2000;
end;

destructor TDiskCaps.Destroy;
begin
  Timer.Free;
  inherited Destroy;
end;

procedure TDiskCaps.SetDrive(Value:char);
begin
  if FDrive<>Value then
  begin
    FDrive:=Value;
    ExamineDrive;
    SetCheckSNChange(false);
    if Assigned(FOnDriveChanged) then FOnDriveChanged(Self);
  end;
end;

procedure TDiskCaps.ExamineDrive;
var
  Serial:DWord;
  DirLen: DWord;
  SystemFlags: DWord;
  FileSys:array[0..12] of Char;
  DLabel:array[0..12] of Char;
begin
  GetVolumeInformation(PChar(Drive+':\'),@DLabel,12,@Serial,
                       DirLen,SystemFlags,@FileSys,12);
  FDiskLabel:=DLabel;
  FDiskSerial:=IntToHex(Serial,8);
  FComponentLen:=DirLen;
  FFileSystem:=FileSys;
  FDriveType:=GetDriveType(PChar(Drive+':\'));
  FDriveFlags:=SystemFlags;
end;

procedure TDiskCaps.ChangeDiskLabel(NewLabel:string);
begin
  if FDiskLabel<>NewLabel then
  begin
    SetVolumeLabel(PChar(Drive+':\'),PChar(NewLabel));
    ExamineDrive;
  end;
end;

procedure TDiskCaps.SetCheckSNChange(Value:boolean);
begin
  if FCheckSNChange<>value then
  begin
    FCheckSNChange:= Value;
    ExamineDrive;
    if not Value then
    begin
      Timer.Free;
      Timer := Nil;
    end
    else if (FCheckPeriod > 0) and
            ((FDriveType=DRIVE_REMOVABLE) or (FDriveType=DRIVE_CDROM))then
    begin
      FLastSerial:=FDiskSerial;
      Timer := TTimer.Create(Self);
      Timer.Interval := FCheckPeriod;
      Timer.OnTimer := DriveStateChecker;
    end
    else
      FCheckSNChange:= false;
  end;
end;

procedure TDiskCaps.DriveStateChecker(Sender: TObject);
begin
  ExamineDrive;
  if FLastSerial<>FDiskSerial then
  begin
    FLastSerial:=FDiskSerial;
    if Assigned(FOnSNChanged) then FOnSNChanged(Self);
  end;
end;

procedure TDiskCaps.SetCheckPeriod(value: integer);
begin
if Value <> FCheckPeriod then
  begin
  Timer.Free;
  Timer := Nil;
  if FCheckSNChange and (Value > 0) then
    begin
    Timer := TTimer.Create(Self);
    Timer.Interval := Value;
    Timer.OnTimer := DriveStateChecker;
    end;
  FCheckPeriod := Value;
  end;
end;
end.
