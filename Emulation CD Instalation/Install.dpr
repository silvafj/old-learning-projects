program Install;

uses
  Forms,
  Main in 'Main.pas' {MainWnd},
  Step1 in 'Step1.pas' {Step1Wnd},
  Step2 in 'Step2.pas' {Step2Wnd};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Emulation CD Installation';
  Application.CreateForm(TMainWnd, MainWnd);
  Application.Run;
end.
