unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Step1, Step2;

type
  TMainWnd = class(TForm)
    ImageBackgorund: TImage;
    NextButton: TButton;
    procedure NextButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainWnd: TMainWnd;

implementation

{$R *.DFM}

procedure TMainWnd.NextButtonClick(Sender: TObject);
begin
  Step1Wnd := TStep1Wnd.Create(Application);
  try
    Step1Wnd.ShowModal;
  finally
    Step1Wnd.Free;
    Step2Wnd := TStep2Wnd.Create(Application);
    try
      Step2Wnd.ShowModal;
    finally
      Step2Wnd.Free;
    end;
  end;
  Close;
end;

end.
