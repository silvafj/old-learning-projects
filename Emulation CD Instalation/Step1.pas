unit Step1;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, DiskCaps, Registry;

type
  TStep1Wnd = class(TForm)
    NextButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditNome: TEdit;
    EditCode: TEdit;
    EditMorada1: TEdit;
    EditMorada2: TEdit;
    EditTelefone: TEdit;
    EditSerial: TEdit;
    Label7: TLabel;
    procedure NextButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  Company = 'NightSpy';
  Product = 'Emulation CD';
  Product1 = 'SSE SNES Manager';
  Product2 = 'SSE NeoGeo Manager';

var
  Step1Wnd: TStep1Wnd;

implementation

{$R *.DFM}

procedure TStep1Wnd.NextButtonClick(Sender: TObject);
var
  Code : String;
  Temp : Extended;
  I : Integer;
  registry : TRegistry;
  Prog_Dir : string;

begin
  Code := '';
  Temp := 0;
  Prog_Dir := ExtractFileDir(ParamStr(0));
  for i := 1 to StrLen(PChar(EditNome.Text)) do
    begin
      Temp := Temp + ((Ord(EditNome.Text[i])*564738291) div 6);
    end;
  for i := 1 to StrLen(PChar(EditMorada1.Text)) do
    begin
      Temp := Temp + ((Ord(EditMorada1.Text[i])*123459876) div 5);
    end;
  for i := 1 to StrLen(PChar(EditMorada2.Text)) do
    begin
      Temp := Temp + ((Ord(EditMorada2.Text[i])*908756431) div 4);
    end;
  for i := 1 to StrLen(PChar(EditTelefone.Text)) do
    begin
      Temp := Temp + ((Ord(EditTelefone.Text[i])*564738291) div 3);
    end;
  for i := 1 to StrLen(PChar(EditSerial.Text)) do
    begin
      Temp := Temp + ((Ord(EditSerial.Text[i])*123987) div 2);
    end;
  Code := Code + FloatToStr(Temp);
  If EditCode.Text <> Code then MessageDlg('Invalid Code. Check the back of your CD box',mtError,[mbOK],0)
  Else
    Begin
      Registry := TRegistry.Create;
      Registry.OpenKey('\Software\'+company+'\'+product,TRUE);
      Registry.WriteString('Name',EditNome.Text);
      Registry.WriteString('Morada 1',EditMorada1.Text);
      Registry.WriteString('Morada 2',EditMorada2.Text);
      Registry.WriteString('Telefone',EditTelefone.Text);
      Registry.WriteString('Serial',EditSerial.Text);
      Registry.WriteFloat('Code',StrToFloat(EditCode.Text));
      Registry.Free;
      Registry := TRegistry.Create;
      Registry.OpenKey('\Software\'+company+'\'+product1,TRUE);
      Registry.WriteString('PathRoms',Prog_Dir+'\Roms\Super Nintendo');
      Registry.Free;
      Registry := TRegistry.Create;
      Registry.OpenKey('\Software\'+company+'\'+product2,TRUE);
      Registry.WriteString('PathRoms',Prog_Dir+'\Roms\NeoGeo');
      Registry.Free;
      Close;
    End;
end;

procedure TStep1Wnd.FormCreate(Sender: TObject);
var
  Prog_Dir : string;
  Disk : TDiskCaps;
  DiskSerial : String;
begin
  Prog_Dir := ExtractFileDir(ParamStr(0));
  Disk := TDiskCaps.Create(application);
  Disk.Drive := Prog_Dir[1];
  Disk.ExamineDrive;
  DiskSerial := Disk.DiskSerial;
  Insert('-',DiskSerial,5);
  EditSerial.Text := DiskSerial;
end;

end.

