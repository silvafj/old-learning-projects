unit MainFrm2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.Top := Screen.Height div 2 - Form1.Height div 2;
  Form1.Left := Screen.Width div 2 - Form1.Width div 2;
  Label1.Caption := ParamStr(1);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
