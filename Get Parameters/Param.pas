unit Param;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
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

procedure TForm1.Button1Click(Sender: TObject);
var
  tempstr : string[50];
  i : integer;

begin
  i := 0;
  tempstr := '';
  Edit1.Text := Format('%d',[ParamCount]);
  If ParamCount > 0 then
    Begin
      For i := 1 to ParamCount do
        tempstr := tempstr + ParamStr(i) + ' ';
    End
  Else tempstr := 'Nenhum parametro inserido';
  Edit2.Text := tempstr;
end;

end.
