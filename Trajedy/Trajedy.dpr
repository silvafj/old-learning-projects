program Trajedy;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {MainWnd};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainWnd, MainWnd);
  Application.Run;
end.
