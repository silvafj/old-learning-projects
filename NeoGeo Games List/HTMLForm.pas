unit HTMLForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  HTMLLite;

type
  THTMLWnd = class(TForm)
    HTMLite: ThtmlLite;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HTMLWnd: THTMLWnd;

implementation

{$R *.DFM}

procedure THTMLWnd.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//  CanClose := FALSE;
end;

end.
