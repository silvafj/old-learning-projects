unit About2;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ExeInfo;

type
  TAbout2Wnd = class(TForm)
    OKButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
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
  About2Wnd: TAbout2Wnd;

implementation

{$R *.DFM}

procedure TAbout2Wnd.FormCreate(Sender: TObject);
begin
  BackgroundBitmap := TBitmap.Create;
  BackgroundBitmap.LoadFromFile('BACK.BMP');
  MAGExeInfo := TMAGExeInfo.Create(Application);
  MAGExeInfo.GetEXEInfo(ParamStr(0));
  Label1.Caption := MAGExeInfo.FileDescription +' '+
                    MAGExeInfo.ProductVersion+' ';
end;

procedure TAbout2Wnd.FormDestroy(Sender: TObject);
begin
  BackgroundBitmap.Free;
end;

procedure TAbout2Wnd.FormPaint(Sender: TObject);
var
 Rect : TRect;
begin
  Rect.TopLeft.x := 0;
  Rect.TopLeft.y := 0;
  Rect.BottomRight.x := 306;
  Rect.BottomRight.y := 129;
  Canvas.StretchDraw(Rect,BackgroundBitmap);
//  Canvas.Draw(0,0,BackgroundBitmap);
end;


end.

