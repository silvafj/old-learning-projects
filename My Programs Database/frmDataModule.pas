unit frmDataModule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Bde;

type
  TDBModule = class(TDataModule)
    DSProgram: TDataSource;
    TableProgram: TTable;
    DSControl: TDataSource;
    TableControl: TTable;
    DSLookup: TDataSource;
    TableLookup: TTable;
    procedure DSProgramStateChange(Sender: TObject);
    procedure DSProgramUpdateData(Sender: TObject);
    procedure DSProgramDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DoReindex(Table: TTable);
    procedure PackTable(Table: TTable);
  end;

var
  DBModule: TDBModule;

implementation

{$R *.DFM}

uses
  ProgramVars;

procedure TDBModule.DSProgramStateChange(Sender: TObject);
begin
  case TableProgram.State of
    dsEdit: EditMode := TRUE;
    dsInsert: EditMode := TRUE;
  else EditMode := FALSE;
  end;
end;

procedure TDBModule.DSProgramUpdateData(Sender: TObject);
begin
  FileModified := TRUE;
end;

{ ReIndex a Paradox table }

procedure TDBModule.DoReindex(Table: TTable);
begin
  { Close our table }
  Table.Close;
  { Set exclusive so noone can edit while we reindex }
  Table.Exclusive := TRUE;
  { Open our table }
  Table.Open;

  { Make sure the table is open exclusively so we can get the db handle }
  if not Table.Active then
    raise EDatabaseError.Create('Table must be opened to pack');
  if not Table.Exclusive then
    raise EDatabaseError.Create('Table must be opened exclusively to pack');

  { Allow the BDE to regenerate our indexes }
  Check(DbiRegenIndexes(Table.Handle));

  { Close our table }
  Table.Close;
  { Reset our exclusive mode }
  Table.Exclusive := FALSE;
  { Open our table }
  Table.Open;
end;

{ Pack a Paradox or dBASE table }

procedure TDBModule.PackTable(Table: TTable);
var
  Props: CURProps;
  hDb: hDBIDb;
  TableDesc: CRTblDesc;
begin
  { Close our table }
  Table.Close;
  { Set exclusive so noone can edit while we pack }
  Table.Exclusive := TRUE;
  { Open our table }
  Table.Open;

  { Make sure the table is open exclusively so we can get the db handle }
  if not Table.Active then
    raise EDatabaseError.Create('Table must be opened to pack');
  if not Table.Exclusive then
    raise EDatabaseError.Create('Table must be opened exclusively to pack');

  { Get the table properties to determine table type }
  Check(DbiGetCursorProps(Table.Handle, Props));

  { If the table is a Paradox table, you must call DbiDoRestructure... }
  if (Props.szTableType = szPARADOX) then
  begin
    { Blank out the structure... }
    FillChar(TableDesc, sizeof(TableDesc), 0);
    { Get the database handle from the table's cursor handle... }
    Check(DbiGetObjFromObj(hDBIObj(Table.Handle), objDATABASE, hDBIObj(hDb)));
    { Put the table name in the table descriptor... }
    StrPCopy(TableDesc.szTblName, Table.TableName);
    { Put the table type in the table descriptor... }
    StrPCopy(TableDesc.szTblType, Props.szTableType);
    { Set the Pack option in the table descriptor to TRUE... }
    TableDesc.bPack := True;
    { Close the table so the restructure can complete... }
    Table.Close;
    { Call DbiDoRestructure... }
    Check(DbiDoRestructure(hDb, 1, @TableDesc, nil, nil, nil, False));
  end
  else
    { If the table is a dBASE table, simply call DbiPackTable... }
    if (Props.szTableType = szDBASE) then
      Check(DbiPackTable(Table.DBHandle, Table.Handle, nil, szDBASE, True))
    else
      { Pack only works on PAradox or dBASE; nothing else... }
      raise EDatabaseError.Create('Table must be either of Paradox or dBASE type to pack');

(* Neste momento não é usado aqui, devido ao facto de eu usar uma extensão diferente
  { Close our table }
  Table.Close;
  { Reset our exclusive mode }
  Table.Exclusive := FALSE;
  { Open our table }
  Table.Open;
*)
end;

procedure TDBModule.DSProgramDataChange(Sender: TObject; Field: TField);
begin
  DataAsChanged := TRUE;
end;

end.

