program NeoGeo;

uses
  Forms,
  MainForm in 'MainForm.pas' {WndMain},
  HTMLForm in 'HTMLForm.pas' {HTMLWnd};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'NeoGeo Games List by ^Magico^';
  Application.CreateForm(TWndMain, WndMain);
  Application.CreateForm(THTMLWnd, HTMLWnd);
  Application.Run;
end.
