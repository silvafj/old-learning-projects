unit frmNew;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids;

type
  TWndNew = class(TForm)
    DBGrid: TDBGrid;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WndNew: TWndNew;

implementation

{$R *.DFM}

uses
  frmDataModule;

procedure TWndNew.FormResize(Sender: TObject);
begin
  DBGrid.Columns[0].Width := WndNew.Width div 3;
end;

procedure TWndNew.FormCreate(Sender: TObject);
begin
  DBGrid.Width := WndNew.Width;
end;

end.
