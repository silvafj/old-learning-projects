unit Config;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Buttons, Registry, FileCtrl;

type
  TConfigWnd = class(TForm)
    PathNesticle: TEdit;
    BrowseBtn1: TBitBtn;
    PathRoms: TEdit;
    BrowseBtn3: TBitBtn;
    PathItens: TEdit;
    BrowseBtn4: TBitBtn;
    OpenDialog1: TOpenDialog;
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure BrowseBtn1Click(Sender: TObject);
    procedure BrowseBtn2Click(Sender: TObject);
    procedure BrowseBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    BackgroundBitmap : TBitmap;
    Registry : TRegistry;
  public
    { Public declarations }
  end;

var
  ConfigWnd: TConfigWnd;

implementation

{$R *.DFM}

procedure TConfigWnd.FormDestroy(Sender: TObject);
begin
  BackgroundBitmap.Free;
end;

procedure TConfigWnd.FormPaint(Sender: TObject);
var
 Rect : TRect;
begin
  Rect.TopLeft.x := 0;
  Rect.TopLeft.y := 0;
  Rect.BottomRight.x := 326;
  Rect.BottomRight.y := 136;
  Canvas.StretchDraw(Rect,BackgroundBitmap);
//  Canvas.Draw(0,0,BackgroundBitmap);
end;

procedure TConfigWnd.BrowseBtn1Click(Sender: TObject);
begin
  If (PathNesticle.Text <> '') then OpenDialog1.InitialDir := PathNesticle.Text;
  If OpenDialog1.Execute then
  PathNesticle.Text := OpenDialog1.FileName;
end;

procedure TConfigWnd.BrowseBtn2Click(Sender: TObject);
var
  dir : string;

begin
  dir := PathRoms.Text;
  if not DirectoryExists(dir) then dir :='.';
  if SelectDirectory(dir,[sdAllowCreate,sdPerformCreate,
                          sdPrompt],0) then
    PathRoms.Text := dir;
end;

procedure TConfigWnd.BrowseBtn3Click(Sender: TObject);
var
  dir : string;
begin
  dir := PathItens.Text;
  if not DirectoryExists(dir) then dir :='.';
  if SelectDirectory(dir,[sdAllowCreate,sdPerformCreate,
                          sdPrompt],0) then
    PathItens.Text := dir;
end;

procedure TConfigWnd.FormCreate(Sender: TObject);
begin

  BackgroundBitmap := TBitmap.Create;
  BackgroundBitmap.LoadFromFile('BACK.BMP');

  Registry := TRegistry.Create;
  Registry.OpenKey('\Software\Fernando Silva (aka ^Magico^)\SSE NESticle Manager',TRUE);
  If (Not Registry.ValueExists('PathNesticle')) or
     (Not Registry.ValueExists('PathRoms')) or
     (Not Registry.ValueExists('PathItens')) then
     begin
       PathNesticle.Text := '';
       PathRoms.Text     := '';
       PathItens.Text    := '';
     end
  Else
    begin
      PathNesticle.Text := Registry.ReadString('PathNesticle');
      PathRoms.Text     := Registry.ReadString('PathRoms');
      PathItens.Text    := Registry.ReadString('PathItens');
    end;
  Registry.Free;
  end;

procedure TConfigWnd.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TConfigWnd.BtnOKClick(Sender: TObject);
begin
  Registry := TRegistry.Create;
  Registry.OpenKey('\Software\Fernando Silva (aka ^Magico^)\SSE NESticle Manager',TRUE);
  If not FileExists(PathNesticle.Text) then
    MessageDlg('Invalid Path for Nesticle',mtError,[mbOK],0)
  Else
    begin
      Registry.WriteString('PathNesticle',PathNesticle.Text);
      If not DirectoryExists(PathRoms.Text) then
        MessageDlg('Invalid Roms Directory',mtError,[mbOK],0)
      Else
        begin
          Registry.WriteString('PathRoms',PathRoms.Text);
          If not DirectoryExists(PathItens.Text) then
            MessageDlg('Invalid Itens Directory',mtError,[mbOK],0)
          Else
            begin
              Registry.WriteString('PathItens',PathItens.Text);
              Registry.Free;
              Close;
            end;
        end;
    end;
end;

procedure TConfigWnd.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := TRUE;
end;


end.
