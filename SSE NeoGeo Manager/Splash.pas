unit Splash;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, CoolForm, Registry;

type
  TSplashWnd = class(TForm)
    OKButton: TButton;
    Bevel: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    CoolForm1: TCoolForm;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SplashWnd: TSplashWnd;

implementation

{$R *.DFM}

procedure TSplashWnd.FormCreate(Sender: TObject);
const
  Company = 'NightSpy';
  Product = 'Emulation CD';

var
  Registry : TRegistry;

begin
  Registry := TRegistry.Create;
  Registry.OpenKey('\Software\'+company+'\'+product,TRUE);
  Label2.Caption := Registry.ReadString('Name');
  Label3.Caption := Registry.ReadString('Morada 1');
  Label4.Caption := Registry.ReadString('Morada 2');
  Label5.Caption := 'Tel : '+Registry.ReadString('Telefone');
  Label6.Caption := 'Serial : '+Registry.ReadString('Serial');
  Label7.Caption := 'Code : ' + FloatToStr(Registry.ReadFloat('Code'));
  Registry.Free;
end;



end.
 
