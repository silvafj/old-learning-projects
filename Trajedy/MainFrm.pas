unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, CoolForm, StdCtrls, Buttons, OleCtrls, isp3, HTTPApp, URLLabel;

type
  TMainWnd = class(TForm)
    CoolForm: TCoolForm;
    LoveBtn: TBitBtn;
    URLLabel: TURLLabel;
    procedure LoveBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainWnd: TMainWnd;

implementation

{$R *.DFM}

procedure TMainWnd.LoveBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TMainWnd.FormCreate(Sender: TObject);
begin
  MainWnd.Top := Screen.Height div 2 - MainWnd.Height div 2;
  MainWnd.Left := Screen.Width div 2 - MainWnd.Width div 2;
end;

end.
