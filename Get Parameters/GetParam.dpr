program GetParam;

uses
  Forms,
  Param in 'Param.pas' {Form1};

{$R *.RES}
{$D Get ScreenSaver Parameters }

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
