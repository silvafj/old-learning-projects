unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, OleCtrls, isp3, ExeInfo;

type
  TAboutWnd = class(TForm)
    OKButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Instructions: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    BackgroundBitmap : TBitmap;
    MAGExeInfo : TMAGExeInfo;
  public
    { Public declarations }
  end;

var
  AboutWnd: TAboutWnd;

implementation

{$R *.DFM}

procedure TAboutWnd.FormCreate(Sender: TObject);
begin
  BackgroundBitmap := TBitmap.Create;
  BackgroundBitmap.LoadFromFile('BACK.BMP');
  MAGExeInfo := TMAGExeInfo.Create(Application);
  MAGExeInfo.GetEXEInfo(ParamStr(0));
  Label1.Caption := MAGExeInfo.FileDescription +' '+
                    MAGExeInfo.ProductVersion+' ';
end;

procedure TAboutWnd.FormDestroy(Sender: TObject);
begin
  BackgroundBitmap.Free;
end;

procedure TAboutWnd.FormPaint(Sender: TObject);
var
 Rect : TRect;
begin
  Rect.TopLeft.x := 0;
  Rect.TopLeft.y := 0;
  Rect.BottomRight.x := 458;
  Rect.BottomRight.y := 267;
  Canvas.StretchDraw(Rect,BackgroundBitmap);
//  Canvas.Draw(0,0,BackgroundBitmap);
end;


end.

