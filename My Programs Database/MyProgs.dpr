program MyProgs;

uses
  Forms,
  frmDataModule in 'frmDataModule.pas' {DBModule: TDataModule},
  frmAbout in 'frmAbout.pas' {WndAbout},
  frmZIP in 'frmZIP.pas' {WndZIPList},
  frmList in 'frmList.pas' {WndList},
  frmMain in 'frmMain.pas' {WndMain},
  frmNew in 'frmNew.pas' {WndNew};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'My Programs Database';
  Application.CreateForm(TWndMain, WndMain);
  Application.CreateForm(TWndAbout, WndAbout);
  Application.CreateForm(TWndZIPList, WndZIPList);
  Application.CreateForm(TWndList, WndList);
  Application.CreateForm(TDBModule, DBModule);
  Application.CreateForm(TWndNew, WndNew);
  Application.Run;
end.
