unit frmList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids;

type
  TWndList = class(TForm)
    DBGrid: TDBGrid;
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WndList: TWndList;

implementation

{$R *.DFM}

uses
  frmDataModule; { DBModule }

procedure TWndList.FormResize(Sender: TObject);
begin
  DBGrid.Columns[0].Width := WndList.Width div 3;
  DBGrid.Columns[1].Width := WndList.Width div 3;
  DBGrid.Columns[2].Width := WndList.Width div 3;
end;

end.
