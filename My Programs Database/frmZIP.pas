unit frmZIP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ZipMstr, Grids, SortGrid, TB97, TB97Tlbr, TB97Ctls, StdCtrls, BrowseDr,
  Menus;

type
  TWndZIPList = class(TForm)
    SortGrid: TSortGrid;
    Dock97: TDock97;
    Toolbar97: TToolbar97;
    TBBtn97Add: TToolbarButton97;
    TBBtn97Extract: TToolbarButton97;
    Label1: TLabel;
    Memo: TMemo;
    TBBtn97View: TToolbarButton97;
    ZipMaster: TZipMaster;
    ZipMasterSource: TZipMaster;
    TBBtn97Close: TToolbarButton97;
    DlgDirectory: TBrowseDirectoryDlg;
    PopupMenu: TPopupMenu;
    PMFiles: TMenuItem;
    PMDirectories: TMenuItem;
    PMZip: TMenuItem;
    procedure ZipMasterProgress(Sender: TObject; ProgrType: ProgressType;
      Filename: string; FileSize: Integer);
    procedure ZipMasterDirUpdate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TBBtn97CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ZipMasterSourceCopyZipOverwrite(Sender: TObject;
      ForFile: string; var DoOverwrite: Boolean);
    procedure ZipMasterSourceDirUpdate(Sender: TObject);
    procedure PMDirectoriesClick(Sender: TObject);
    procedure PMFilesClick(Sender: TObject);
    procedure PMZipClick(Sender: TObject);
    procedure TBBtn97ExtractClick(Sender: TObject);
  private
    { Private declarations }
    TotalSizeToProcess, TotalProgress: Int64;
    procedure FillGrid;
  public
    { Public declarations }
    BaseDir: string; // String a  ser retirada do path
    CopyList: TStringList; // List that will contain the files to be coppied
  end;

var
  WndZIPList: TWndZIPList;

implementation

{$R *.DFM}

uses
  frmMain;

procedure TWndZIPList.ZipMasterProgress(Sender: TObject;
  ProgrType: ProgressType; Filename: string; FileSize: Integer);
begin
  case ProgrType of
    TotalSize2Process:
      begin
        // ZipMaster1Message( self, 0, 'in OnProgress type TotalBytes, size= ' + IntToStr( FileSize ) );
        { Desactiva o Menu e activa a Progress Bar}
//        MIFile.Visible := FALSE;
//        MIEdit.Visible := FALSE;
//        ProgressBar.Visible := TRUE;
//        ProgressBar.Position := 0;
        TotalSizeToProcess := FileSize;
      end;
    ProgressUpdate:
      begin
        // ZipMaster1Message( self, 0, 'in OnProgress type Update, size= ' + IntToStr( FileSize ) );
        // FileSize gives now the bytes processed since the last call.
        TotalProgress := TotalProgress + FileSize;
//        ProgressBar.Position := Round((TotalProgress / TotalSizeToProcess) * 100);
      end;
    EndOfBatch: // Reset the progress bar and filename.
      begin
        TotalProgress := 0;
        // ZipMaster1Message( self, 0, 'in OnProgress type EndOfBatch' );
        { Activa o Menu e desactiva a Progress Bar}
//        MIFile.Visible := TRUE;
//        MIEdit.Visible := TRUE;
//        ProgressBar.Visible := FALSE;
//        ProgressBar.Position := 0;
        { Informação na status }
//        StatusBar.Panels[1].Text := '';
      end;
  end; // EOF Case
end;

procedure TWndZIPList.FillGrid;
var
  i, ControlRow: Integer;
  so: TSortOptions;

begin
  ControlRow := 0; // Controling row, actual row
  SortGrid.RowCount := 2; // Numbers of display rows
  if ZipMaster.Count = 0 then Exit;
  { Start listing all files, except Directory Separators }
  for i := 0 to ZipMaster.Count - 1 do
  begin
    with ZipDirEntry(ZipMaster.ZipContents[i]^) do
    begin
      if ExtractFileName(FileName) <> '' then // if is not a separator
      begin
        with SortGrid do
        begin
          RowCount := RowCount + 1; // Refresh number of rows
          Inc(ControlRow); // New row
          Cells[0, ControlRow] := ExtractFileName(FileName);
          Cells[1, ControlRow] := FormatDateTime('ddddd  t', FileDateToDateTime(DateTime));
          Cells[2, ControlRow] := IntToStr(UncompressedSize);
          if UncompressedSize <> 0 then Cells[3, ControlRow] := IntToStr(Round((1 - (CompressedSize / UnCompressedSize)) * 100)) + '% '
          else Cells[3, ControlRow] := '0% ';
          Cells[4, ControlRow] := IntToStr(CompressedSize);
          Cells[5, ControlRow] := ExtractFilePath(FileName);
        end; // end with
      end; // end if
    end; // end with
  end; // end for
  so.SortDirection := sdAscending;
  so.SortStyle := ssAutomatic;
  so.SortCaseSensitive := False;
  SortGrid.SortByColumn(SortGrid.SortColumn, so);
  SortGrid.Row := 1;
  SortGrid.RowCount := SortGrid.RowCount - 1; // Refresh number of rows
end;

procedure TWndZIPList.ZipMasterDirUpdate(Sender: TObject);
begin
  FillGrid;
end;

procedure TWndZIPList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ZipMaster.ZipComment := Memo.Lines.CommaText;
end;

procedure TWndZIPList.TBBtn97CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TWndZIPList.FormCreate(Sender: TObject);
begin
  ZipMaster.Load_Zip_Dll;
  ZipMaster.Load_Unz_Dll;
end;

procedure TWndZIPList.FormDestroy(Sender: TObject);
begin
  ZipMaster.UnLoad_Zip_Dll;
  ZipMaster.UnLoad_Unz_Dll;
end;

procedure TWndZIPList.ZipMasterSourceCopyZipOverwrite(Sender: TObject;
  ForFile: string; var DoOverwrite: Boolean);
begin
  if MessageDlg('File being copied already exists in database.' + #13 +
    'Overwrite ' + ForFile + ' ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    DoOverwrite := TRUE
  else DoOverwrite := FALSE;
end;

procedure TWndZIPList.ZipMasterSourceDirUpdate(Sender: TObject);
var
  i: Integer;

begin
  for i := 0 to ZipMasterSource.Count - 1 do
  begin
    with ZipDirEntry(ZipMasterSource.ZipContents[i]^) do
      CopyList.Add(FileName);
  end; // end for
end;

procedure TWndZIPList.PMDirectoriesClick(Sender: TObject);
var
  OldOptions: AddOpts;

begin
  if DlgDirectory.Execute then
  begin
    WndMain.StatusBar.Panels.Items[2].Text := 'Adding...';
    OldOptions := ZipMaster.AddOptions;
    ZipMaster.AddOptions := ZipMaster.AddOptions + [AddRecurseDirs, AddDirNames];
    ZipMaster.FSpecArgs.Clear;
    ZipMaster.FSpecArgs.Add('*.*');
    SetCurrentDir(DlgDirectory.Selection);
    ZipMaster.Add;
    WndMain.StatusBar.Panels.Items[2].Text := '';
    ZipMaster.AddOptions := OldOptions;
  end;
  FillGrid;
end;

procedure TWndZIPList.PMFilesClick(Sender: TObject);
var
  OldOptions: TopenOptions;

begin
  OldOptions := WndMain.DlgOpen.Options;
  WndMain.DlgOpen.Title := 'Choose the files to be added to the database';
  WndMain.DlgOpen.Filter := 'All Files (*.*)|*.*';
  WndMain.DlgOpen.FileName := '';
  WndMain.DlgOpen.Options := OldOptions + [ofAllowMultiSelect];
  if WndMain.DlgOpen.Execute then
  begin
    WndMain.StatusBar.Panels.Items[2].Text := 'Adding...';
    ZipMaster.FSpecArgs.Clear;
    ZipMaster.FSpecArgs.Assign(WndMain.DlgOpen.Files);
    BaseDir := ExtractFilePath(WndMain.DlgOpen.Files.Strings[0]);
    Delete(BaseDir, 1, 3);
    ZipMaster.Add;
    WndMain.StatusBar.Panels.Items[2].Text := '';
  end;
  WndMain.DlgOpen.Options := OldOptions;
  FillGrid;
end;

procedure TWndZIPList.PMZipClick(Sender: TObject);
var
  OldOptions: TopenOptions;
  StringList: TStringList;
  I: integer;

begin
  OldOptions := WndMain.DlgOpen.Options;
  WndMain.DlgOpen.Title := 'Choose the ZIP files to be copied to the database';
  WndMain.DlgOpen.Filter := 'ZIP Files (*.ZIP)|*.ZIP';
  WndMain.DlgOpen.FileName := '';
  WndMain.DlgOpen.Options := OldOptions + [ofAllowMultiSelect];
  if WndMain.DlgOpen.Execute then
  begin
    WndMain.StatusBar.Panels.Items[2].Text := 'Adding...';
    StringList := TStringList.Create; // Create ZIP files list
    StringList.Assign(WndMain.DlgOpen.Files);
    CopyList := TStringList.Create; // Create list that will contain files to be coppied
    { Load DLL's }
    ZipMasterSource.Load_Zip_Dll;
    ZipMasterSource.Load_Unz_Dll;
    { Select all files to be copied }
    ZipMaster.FSpecArgs.Clear;
    ZipMaster.FSpecArgs.Add('*.*');
    { Start copying }
    for I := 0 to StringList.Count - 1 do
    begin
      // Open File
      ZipMasterSource.ZipFileName := StringList.Strings[I];
      // List files
      ZipMasterSource.FSpecArgs.Clear;
      ZipMasterSource.FSpecArgs.Assign(CopyList);
      // Copy
      ZipMasterSource.CopyZippedFiles(ZipMaster, FALSE, OvrConfirm);
    end;
    WndMain.StatusBar.Panels.Items[2].Text := '';
    StringList.Free;
    { Unload DLL's }
    ZipMasterSource.Unload_Zip_Dll;
    ZipMasterSource.Unload_Unz_Dll;
    WndMain.DlgOpen.Options := OldOptions;
  end;
  FillGrid;
end;

procedure TWndZIPList.TBBtn97ExtractClick(Sender: TObject);
var
  I: integer;

begin
  DlgDirectory.Title := 'Choose the target directory for the extracted files';
  if DlgDirectory.Execute then
  begin
    WndMain.StatusBar.Panels.Items[2].Text := 'Extracting...';
    ZipMaster.FSpecArgs.Clear;
    for i := SortGrid.Selection.Top to SortGrid.Selection.Bottom do
    begin
      if i <> SortGrid.RowCount then
        ZipMaster.FSpecArgs.Add(SortGrid.Cells[5, i] + SortGrid.Cells[0, i]);
    end; { end for }
    ZipMaster.ExtrBaseDir := ZipMaster.AppendSlash(DlgDirectory.Selection);
    ZipMaster.Extract;
    WndMain.StatusBar.Panels.Items[2].Text := '';
  end;
  DlgDirectory.Title := 'Choose the main directory to be added to the database';
end;

end.

