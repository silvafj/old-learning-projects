program NesMan10;

{$I Defines.PAS}

uses
  Forms,
  {$ifdef CDEmul} Registry, Dialogs, {$endif}
  Main in 'Main.pas' {MainWnd},
  Config in 'Config.pas' {ConfigWnd},
  Emulation in 'Emulation.pas' {MAGDataList: TDataModule},
  About in 'About.pas' {AboutWnd},
  About2 in 'About2.pas' {About2Wnd},
  Security in 'Security.pas' {Algorithm: TDataModule};
{$R *.RES}

{$ifdef CDEmul}
var
  Reg : TRegistry;
  Code : String;
  Algorithm : TAlgorithm;
{$endif}

begin
  Application.Initialize;
  Application.Title := 'SSE NESticle Manager';
  Application.HintColor := $0000FF00;
  Application.HintHidePause := 5000;
  Application.CreateForm(TMainWnd, MainWnd);
  {$ifdef CDEmul}
  Reg := TRegistry.Create;
  Reg.CloseKey;
  Reg.OpenKey('\Software\Fernando Silva (aka ^Magico^)\Emulation',TRUE);
  If Not Reg.ValueExists('Code') then
    begin
      MessageDlg('Código não encontrado. Por favor instale o programa principal do CD.',mtError,[mbOK],0);
      Exit;
    end
  else
    begin
      Code := Reg.ReadString('Code');
      Algorithm := TAlgorithm.Create(Application);
      if not Algorithm.CorrectCode(Code) then
        begin
          MessageDlg('Código Incorrecto. Contacte o seu vendedor.',mtError,[mbOK],0);
          Exit;
        end;
    end;
  Reg.Free;
  {$endif}
  Application.Run;
end.
