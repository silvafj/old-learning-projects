program SNESMan;

uses
Forms,
  Dialogs,
  Main in 'Main.pas' {MainWnd},
  Config in 'Config.pas' {ConfigWnd},
  Database in 'Database.pas',
  Splash in 'Splash.pas' {SplashWnd},
  Security in 'Security.pas' {Check: TDataModule};

{$R *.RES}
var
  Drive, Serial : String;

begin
  Application.Initialize;
  Application.Title := 'SSE SNES Manager v1.0';
  Application.HintColor := $0000FF00;
  Application.HintHidePause := 10000;
  Check := TCheck.Create(application);
  if Check.Code then
    begin
      if Check.CDROM(Drive, Serial) then
        begin
          SplashWnd := TSplashWnd.Create(Application);
          try
            SplashWnd.ShowModal;
            // Standard Code...
            Application.CreateForm(TMainWnd, MainWnd);
            Application.CreateForm(TCheck, Check);
            SplashWnd.Close;
          finally
            SplashWnd.Free;
          end;
          Application.Run;
        end { if Check.CDROM }
      else
        MessageDlg('Insert Emulation CD with serial '+Serial+' on drive '+Drive,mtCustom,[mbOK],0);
    end { if Check.Code }
  else
    MessageDlg('Invalid software code!!!'+#13+
               'This could be happen because you did a bad install'+#13+
               'or you are trying to do something you shouln''t be doing.'+#13+
               'Contact your vendor to resolve the problem.',mtCustom,[mbOK],0);
end.
