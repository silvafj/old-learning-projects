unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ExtCtrls, DBTables, StdCtrls, ZipMstr, FileCtrl, DBCtrls,
  DBActns, ActnList, ImgList, TB97Tlbr, TB97Ctls, TB97, Mask, Registry,
  HCMngr, ShFileOp, DB, BrowseDr;


type
  TWndMain = class(TForm)
    MainMenu: TMainMenu;
    MIFile: TMenuItem;
    MIView: TMenuItem;
    MIHelp: TMenuItem;
    MIContents: TMenuItem;
    N7: TMenuItem;
    MIAbout: TMenuItem;
    PageControl: TPageControl;
    TSProgram: TTabSheet;
    TSSource: TTabSheet;
    MINew: TMenuItem;
    MIOpen: TMenuItem;
    MISaveAs: TMenuItem;
    MIClose: TMenuItem;
    N2: TMenuItem;
    MIInformation: TMenuItem;
    N3: TMenuItem;
    MIExit: TMenuItem;
    N1: TMenuItem;
    MIProgramInformation: TMenuItem;
    MISourceInformation: TMenuItem;
    N5: TMenuItem;
    MILastRecord: TMenuItem;
    MIFirstRecord: TMenuItem;
    MINextRecord: TMenuItem;
    MIPreviousRecord: TMenuItem;
    MIEdit: TMenuItem;
    MIAddRecord: TMenuItem;
    MIDeleteRecord: TMenuItem;
    MIEditRecord: TMenuItem;
    N4: TMenuItem;
    MIConfiguration: TMenuItem;
    MITools: TMenuItem;
    StatusBar: TStatusBar;
    MISearch: TMenuItem;
    MIReport: TMenuItem;
    DlgSave: TSaveDialog;
    Bevel: TBevel;
    Bevel1: TBevel;
    LabelName: TLabel;
    LabelVersion: TLabel;
    LabelDate: TLabel;
    Bevel2: TBevel;
    LabelLanguage: TLabel;
    LabelOS: TLabel;
    LabelType: TLabel;
    GBDescription: TGroupBox;
    LabelEXE: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    LabelCoder: TLabel;
    LabelCompiler: TLabel;
    GBComments: TGroupBox;
    Bevel5: TBevel;
    LabelFiles: TLabel;
    LabelVCL: TLabel;
    ImageBIN: TImage;
    ImageSRC: TImage;
    ImageVCL: TImage;
    DBTextName: TDBText;
    DBTextDate: TDBText;
    DBTextLanguage: TDBText;
    DBTextOS: TDBText;
    DBTextType: TDBText;
    DBMemoDescription: TDBMemo;
    DBMemoComments: TDBMemo;
    DBTextCoder: TDBText;
    DBTextCompiler: TDBText;
    DBEditName: TDBEdit;
    DBEditDate: TDBEdit;
    DBEditCoder: TDBEdit;
    MIPostRecord: TMenuItem;
    ImageList: TImageList;
    TBDock97: TDock97;
    Toolbar97: TToolbar97;
    ImageBackground: TImage;
    ActionList: TActionList;
    ActionFileNew: TAction;
    TBButton97New: TToolbarButton97;
    TBButton97Open: TToolbarButton97;
    ActionFileOpen: TAction;
    ActionDataSetInsert: TDataSetInsert;
    ActionDataSetEdit: TDataSetEdit;
    ActionDataSetPost: TDataSetPost;
    ActionDataSetDelete: TDataSetDelete;
    ActionDataSetFirst: TDataSetFirst;
    ActionDataSetNext: TDataSetNext;
    ActionDataSetPrior: TDataSetPrior;
    ActionDataSetLast: TDataSetLast;
    ActionFileSaveAs: TAction;
    ActionFileClose: TAction;
    ActionFileInformation: TAction;
    ActionFileExit: TAction;
    ActionEditConfiguration: TAction;
    ActionViewProgramInformation: TAction;
    ActionViewSourceInformation: TAction;
    ActionToolsSearch: TAction;
    ActionToolsReport: TAction;
    ActionHelpContents: TAction;
    ActionHelpAbout: TAction;
    TBButton97Contents: TToolbarButton97;
    TBButton97First: TToolbarButton97;
    TBSep9702: TToolbarSep97;
    TBButton97Prior: TToolbarButton97;
    TBButton97Next: TToolbarButton97;
    TBButton97Last: TToolbarButton97;
    TBButton97Add: TToolbarButton97;
    TBButton97Delete: TToolbarButton97;
    TBButton97Edit: TToolbarButton97;
    TBButton97Refresh: TToolbarButton97;
    ActionDataSetCancel: TDataSetCancel;
    ActionDataSetRefresh: TDataSetRefresh;
    MICancelEdit: TMenuItem;
    MIRefresh: TMenuItem;
    TBButton97Close: TToolbarButton97;
    TBButton97Post: TToolbarButton97;
    TBButton97Information: TToolbarButton97;
    TBSep9701: TToolbarSep97;
    ActionToolsReIndex: TAction;
    ReIndexDatabase1: TMenuItem;
    MIUtilities: TMenuItem;
    MIReIndex: TMenuItem;
    ActionToolsPack: TAction;
    Pack1: TMenuItem;
    DBEditControl: TDBEdit;
    PopupMenu: TPopupMenu;
    PMAdd: TMenuItem;
    PMShowList: TMenuItem;
    PMFiles: TMenuItem;
    PMDirectories: TMenuItem;
    PMZip: TMenuItem;
    DlgOpen: TOpenDialog;
    ActionToolsList: TAction;
    MIList: TMenuItem;
    DBLookupComboBoxLanguage: TDBLookupComboBox;
    DBLookupComboBoxType: TDBLookupComboBox;
    DBLookupComboBoxOS: TDBLookupComboBox;
    DBLookupComboBoxCompiler: TDBLookupComboBox;
    PopupMenuNew: TPopupMenu;
    PMNew: TMenuItem;
    DBEditVersion: TDBEdit;
    DBTextVersion: TDBText;
    procedure FormCreate(Sender: TObject);
    procedure ActionFileNewExecute(Sender: TObject);
    procedure ActionFileOpenExecute(Sender: TObject);
    procedure ActionFileSaveAsExecute(Sender: TObject);
    procedure ActionFileCloseExecute(Sender: TObject);
    procedure ActionFileExitExecute(Sender: TObject);
    procedure ActionViewProgramInformationExecute(Sender: TObject);
    procedure ActionViewSourceInformationExecute(Sender: TObject);
    procedure ActionDataSetInsertExecute(Sender: TObject);
    procedure ActionDataSetEditExecute(Sender: TObject);
    procedure ActionDataSetPostExecute(Sender: TObject);
    procedure ActionDataSetDeleteExecute(Sender: TObject);
    procedure ActionDataSetFirstExecute(Sender: TObject);
    procedure ActionDataSetNextExecute(Sender: TObject);
    procedure ActionDataSetPriorExecute(Sender: TObject);
    procedure ActionDataSetLastExecute(Sender: TObject);
    procedure ActionDataSetCancelExecute(Sender: TObject);
    procedure ActionDataSetRefreshExecute(Sender: TObject);
    procedure ActionHelpAboutExecute(Sender: TObject);
    procedure ActionToolsReIndexExecute(Sender: TObject);
    procedure ActionToolsPackExecute(Sender: TObject);
    procedure ActionFileInformationExecute(Sender: TObject);
    procedure ActionEditConfigurationExecute(Sender: TObject);
    procedure ActionToolsSearchExecute(Sender: TObject);
    procedure ActionToolsReportExecute(Sender: TObject);
    procedure ActionHelpContentsExecute(Sender: TObject);
    procedure ImageBINMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageSRCMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageVCLMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PMShowListClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure PMFilesClick(Sender: TObject);
    procedure PMDirectoriesClick(Sender: TObject);
    procedure PMZipClick(Sender: TObject);
    procedure ActionToolsListExecute(Sender: TObject);
    procedure PMNewClick(Sender: TObject);
    procedure DBLookupComboBoxLanguageMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DBLookupComboBoxOSMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DBLookupComboBoxTypeMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DBLookupComboBoxCompilerMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    Registry: TRegistry;
    FileNoExt: string;
    DBDir: string;
    ActualComboBox: integer;
    procedure RefreshEditFields;
    procedure DeleteDir(const directory: string);
  public
    { Public declarations }
  end;

var
  WndMain: TWndMain;

implementation

{$R *.DFM}
{$R TABLES.RES}
{$R GRAPHICS.RES}
{$R ZipMsgUS.res}

uses
  ProgramVars,
  frmDataModule,
  frmZIP,
  frmAbout,
  frmList,
  frmNew;

{******************************************************************************}
{   W N D M A I N - Events                                                     }
{******************************************************************************}

{------------------------------------------------------------------------------}
{ FormCreate (OnCreate)                                                        }
{------------------------------------------------------------------------------}

procedure TWndMain.FormCreate(Sender: TObject);
var
  InitialDir: string;

begin
  Registry := TRegistry.Create;
  if Registry.KeyExists('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders') then
  begin
    Registry.OpenKeyReadOnly('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders');
    InitialDir := Registry.ReadString('Personal');
    Registry.CloseKey;
    Registry.Free;
  end
  else
  begin
    MessageDlg('Couldn''t find "My Documents" default directory', mtError, [mbOK], 0);
    InitialDir := ExtractFilePath(ParamStr(0));
  end;
  DlgOpen.InitialDir := InitialDir;
  DlgSave.InitialDir := InitialDir;
  FileModified := FALSE;
  PageControl.ActivePage := TSProgram;
end;

{******************************************************************************}
{   A C T I O N S - Action List                                                }
{******************************************************************************}

{------------------------------------------------------------------------------}
{ File New                                                                     }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionFileNewExecute(Sender: TObject);
const
  DBFiles = 6; // Numero de ficheiros originais da base de dados

var
  ResStream: TResourceStream; // Resource Stream object
  TableFiles: array[1..DBFiles] of string; // Array com a extensão dos ficheiros originais
  I: integer; // variavel de controlo
  TempDBDir: string;
  TempFileNoExt: string;
  MyFile: TextFile;

begin
  { Pede }
  DlgSave.Title := 'New database';
  DlgSave.Filter := 'My Programs Database File (*.PDL)|*.PDL|All files (*.*)|*.*';
  DlgSave.FileName := '';
  if DlgSave.Execute then
  begin
    { Desliga uma possivel database aberta }
    ActionFileCloseExecute(self);
    { Está em Browse mode }
    EditMode := FALSE;
    DataAsChanged := FALSE;
    { Verifica se já existe, para apagar }
    if FileExists(DlgSave.FileName) then
    begin
      { Nome do ficheiro para criar directorio }
      TempDBDir := ExtractFileName(DlgSave.FileName);
      Delete(TempDBDir, Length(TempDBDir) - 3, 4);
      TempFileNoExt := TempDBDir;
      TempDBDir := ExtractFilePath(DlgSave.FileName);
      DeleteDir(TempDBDir);
    end
    else
    begin
      { Nome do ficheiro para criar directorio }
      TempDBDir := ExtractFileName(DlgSave.FileName);
      Delete(TempDBDir, Length(TempDBDir) - 3, 4);
      TempFileNoExt := TempDBDir;
      TempDBDir := ExtractFilePath(DlgSave.FileName) + TempDBDir + '\';
    end;
    ForceDirectories(TempDBDir);
    StatusBar.Panels[1].Text := 'Creating database... ' + TempDBDir + TempFileNoExt + '.PDL';
    { Cria o ficheiro de controlo }
    AssignFile(MyFile, TempDBDir + TempFileNoExt + '.PDL');
    Rewrite(MyFile);
    Writeln(MyFile, 'PDL10');
    CloseFile(MyFile);
    { Cria Tabelas }
    TableFiles[1] := 'CONTROL.DB';
    TableFiles[2] := 'LOOKUP.DB';
    TableFiles[3] := 'PROGRAM.DB';
    TableFiles[4] := 'PROGRAM.MB';
    TableFiles[5] := 'PROGRAM.PX';
    TableFiles[6] := 'PROGRAM.VAL';
    for I := 1 to DBFiles do
    begin
      ResStream := nil;
      try
        ResStream := TResourceStream.CreateFromID(HInstance, I, RT_RCDATA);
        ResStream.SaveToFile(TempDBDir + TableFiles[I]);
      finally
        ResStream.Free;
      end;
    end;
    StatusBar.Panels[1].Text := 'Initiating database...' + TempDBDir + TempFileNoExt + '.PDL'; ;
    DBModule.TableProgram.DatabaseName := TempDBDir;
    DBModule.TableControl.DatabaseName := TempDBDir;
    DBModule.TableLookup.DatabaseName := TempDBDir;
    DBModule.TableProgram.Active := TRUE;
    DBModule.TableControl.Active := TRUE;
    DBModule.TableLookup.Active := TRUE;
    StatusBar.Panels[1].Text := '';
    WndMain.Caption := 'My Programs Database [' + DlgSave.FileName + ']';
    { Activa todos os componentes necessários }
    N1.Visible := TRUE;
    N2.Visible := TRUE;
    ActionFileSaveAs.Visible := TRUE;
    ActionFileClose.Visible := TRUE;
    ActionFileInformation.Visible := TRUE;
    ActionDataSetInsert.Visible := TRUE;
    ActionDataSetEdit.Visible := TRUE;
    ActionDataSetPost.Visible := TRUE;
    ActionDataSetDelete.Visible := TRUE;
    ActionDataSetCancel.Visible := TRUE;
    ActionDataSetRefresh.Visible := TRUE;
    ActionDataSetFirst.Visible := TRUE;
    ActionDataSetPrior.Visible := TRUE;
    ActionDataSetNext.Visible := TRUE;
    ActionDataSetLast.Visible := TRUE;
    N4.Visible := TRUE;
    MITools.Visible := TRUE;
    MIView.Visible := TRUE;
    PageControl.ActivePage := TSProgram;
    PageControl.Visible := TRUE;
    { Associa a database á variável principal }
    DBDir := TempDBDir;
    FileNoExt := TempFileNoExt;
    RefreshEditFields;
  end;
end;

{------------------------------------------------------------------------------}
{ File Open                                                                    }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionFileOpenExecute(Sender: TObject);
var
  TempDBDir: string;
  TempFileNoExt: string;
  MyFile: TextFile;
  Version: string;

begin
  { Pede }
  DlgOpen.Title := 'Open database';
  DlgOpen.Filter := 'My Programs Database File (*.PDL)|*.PDL|All files (*.*)|*.*';
  DlgOpen.FileName := '';
  if DlgOpen.Execute then
  begin
    { Desliga uma possivel database aberta }
    ActionFileCloseExecute(self);
    { Está em Browse mode }
    EditMode := FALSE;
    DataAsChanged := FALSE;
    { Abre o ficheiro de controlo }
    if FileExists(DlgOpen.FileName) then
    begin
      AssignFile(MyFile, DlgOpen.FileName);
      Reset(MyFile);
      ReadLn(MyFile, Version);
      CloseFile(MyFile);
      if Version = 'PDL10' then
      begin
        { Inicia a database }
        TempDBDir := ExtractFileName(DlgOpen.FileName);
        Delete(TempDBDir, Length(TempDBDir) - 3, 4);
        TempFileNoExt := TempDBDir;
        TempDBDir := ExtractFilePath(DlgOpen.FileName);
        StatusBar.Panels[1].Text := 'Opening database... ' + TempDBDir + TempFileNoExt + '.PDL';
        { Informação na status }
        StatusBar.Panels[1].Text := 'Initiating database...' + TempDBDir + TempFileNoExt + '.PDL'; ;
        DBModule.TableProgram.DatabaseName := TempDBDir;
        DBModule.TableControl.DatabaseName := TempDBDir;
        DBModule.TableLookup.DatabaseName := TempDBDir;
        DBModule.TableProgram.Active := TRUE;
        DBModule.TableControl.Active := TRUE;
        DBModule.TableLookup.Active := TRUE;
        StatusBar.Panels[1].Text := '';
        WndMain.Caption := 'My Programs Database [' + DlgOpen.FileName + ']';
        { Activa todos os componentes necessários }
        N1.Visible := TRUE;
        N2.Visible := TRUE;
        ActionFileSaveAs.Visible := TRUE;
        ActionFileClose.Visible := TRUE;
        ActionFileInformation.Visible := TRUE;
        ActionDataSetInsert.Visible := TRUE;
        ActionDataSetEdit.Visible := TRUE;
        ActionDataSetPost.Visible := TRUE;
        ActionDataSetDelete.Visible := TRUE;
        ActionDataSetCancel.Visible := TRUE;
        ActionDataSetRefresh.Visible := TRUE;
        ActionDataSetFirst.Visible := TRUE;
        ActionDataSetPrior.Visible := TRUE;
        ActionDataSetNext.Visible := TRUE;
        ActionDataSetLast.Visible := TRUE;
        N4.Visible := TRUE;
        MITools.Visible := TRUE;
        MIView.Visible := TRUE;
        PageControl.Visible := TRUE;
        { Associa a database á variável principal }
        DBDir := TempDBDir;
        FileNoExt := TempFileNoExt;
        RefreshEditFields;
      end; // end version
    end; // end fileexists
  end; // end dlgopen.execute
end;

{------------------------------------------------------------------------------}
{ File Save As                                                                 }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionFileSaveAsExecute(Sender: TObject);
var
  Value: Word;
  TempDBDir: string;
  TempFileNoExt: string;
  Found: Integer; // Usado para a cópia de ficheiros
  SearchRec: TSearchRec; // Usado para a cópia de ficheiros
  TempStr: string; // Usado para a cópia de ficheiros

begin
  { Pede }
  DlgSave.Title := 'Save database as';
  DlgOpen.Filter := 'My Programs Database file (*.PDL)|*.PDL|All files (*.*)|*.*';
  DlgSave.FileName := '';
  if DlgSave.Execute then
  begin
    { Desliga uma possivel database aberta }
    ActionFileCloseExecute(self);
    { Está em Browse mode }
    EditMode := FALSE;
    DataAsChanged := FALSE;
    { Nome do ficheiro para criar directorio }
    TempDBDir := ExtractFileName(DlgSave.FileName);
    Delete(TempDBDir, Length(TempDBDir) - 3, 4);
    TempFileNoExt := TempDBDir;
    TempDBDir := ExtractFilePath(DlgSave.FileName) + TempDBDir + '\';
    if UpperCase(TempDBDir) = UpperCase(DBDir) then Exit;
    if DirectoryExists(TempDBDir) then
    begin
      Value := MessageDlg('Database directory already exists.' + #13 + 'Overwrite?', mtWarning, [mbYes, mbNo], 0);
      case Value of
        mrYes: DeleteDir(TempDBDir);
        mrNo: Exit;
      end;
    end;
    StatusBar.Panels[1].Text := 'Saving database... ' + TempDBDir + TempFileNoExt + '.PDL';
    ForceDirectories(TempDBDir);
    { Inicia a cópia }
    Found := FindFirst(DBDir + '*.*', faArchive, SearchRec);
    while Found = 0 do
    begin
      if Pos('.PDL', SearchRec.Name) > 0 then
      begin
        TempStr := SearchRec.Name;
        Delete(TempStr, Pos('.', SearchRec.Name), 4);
        if UpperCase(TempStr) = UpperCase(FileNoExt) then
          CopyFile(PChar(DBDir + SearchRec.Name), PChar(TempDBDir + TempFileNoExt + ExtractFileExt(SearchRec.Name)), FALSE)
        else
          CopyFile(PChar(DBDir + SearchRec.Name), PChar(TempDBDir + SearchRec.Name), FALSE);
      end
      else CopyFile(PChar(DBDir + SearchRec.Name), PChar(TempDBDir + SearchRec.Name), FALSE);
      Found := FindNext(SearchRec);
    end;
    FindClose(SearchRec);
    { Inicia }
    StatusBar.Panels[1].Text := 'Initiating database...' + TempDBDir + TempFileNoExt + '.PDL'; ;
    DBModule.TableProgram.DatabaseName := TempDBDir;
    DBModule.TableControl.DatabaseName := TempDBDir;
    DBModule.TableProgram.Active := TRUE;
    DBModule.TableControl.Active := TRUE;
    StatusBar.Panels[1].Text := '';
    { Activa todos os componentes necessários }
    N1.Visible := TRUE;
    N2.Visible := TRUE;
    ActionFileSaveAs.Visible := TRUE;
    ActionFileClose.Visible := TRUE;
    ActionFileInformation.Visible := TRUE;
    ActionDataSetInsert.Visible := TRUE;
    ActionDataSetEdit.Visible := TRUE;
    ActionDataSetPost.Visible := TRUE;
    ActionDataSetDelete.Visible := TRUE;
    ActionDataSetCancel.Visible := TRUE;
    ActionDataSetRefresh.Visible := TRUE;
    ActionDataSetFirst.Visible := TRUE;
    ActionDataSetPrior.Visible := TRUE;
    ActionDataSetNext.Visible := TRUE;
    ActionDataSetLast.Visible := TRUE;
    N4.Visible := TRUE;
    MITools.Visible := TRUE;
    MIView.Visible := TRUE;
    PageControl.Visible := TRUE;
    { Associa a database á variável principal }
    DBDir := TempDBDir;
    FileNoExt := TempFileNoExt;
    RefreshEditFields;
  end;
end;

{------------------------------------------------------------------------------}
{ File Close                                                                   }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionFileCloseExecute(Sender: TObject);
begin
  DBModule.TableProgram.Active := FALSE;
  DBModule.TableControl.Active := FALSE;
  WndMain.Caption := 'My Programs Database';
  { Desactiva todos os componentes não necessários }
  N1.Visible := FALSE;
  N2.Visible := FALSE;
  ActionFileSaveAs.Visible := FALSE;
  ActionFileClose.Visible := FALSE;
  ActionFileInformation.Visible := FALSE;
  ActionDataSetInsert.Visible := FALSE;
  ActionDataSetEdit.Visible := FALSE;
  ActionDataSetPost.Visible := FALSE;
  ActionDataSetDelete.Visible := FALSE;
  ActionDataSetCancel.Visible := FALSE;
  ActionDataSetRefresh.Visible := FALSE;
  ActionDataSetFirst.Visible := FALSE;
  ActionDataSetPrior.Visible := FALSE;
  ActionDataSetNext.Visible := FALSE;
  ActionDataSetLast.Visible := FALSE;
  N4.Visible := FALSE;
  MITools.Visible := FALSE;
  MIView.Visible := FALSE;
  PageControl.Visible := FALSE;
  FileModified := FALSE;
end;

{------------------------------------------------------------------------------}
{ File Information                                                             }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionFileInformationExecute(Sender: TObject);
begin
{...}
  ShowMessage('Not Implemented');
{...}
end;

{------------------------------------------------------------------------------}
{ File Exit                                                                    }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionFileExitExecute(Sender: TObject);
begin
  DBModule.TableProgram.Active := FALSE;
  DBModule.TableControl.Active := FALSE;
  Close;
end;

{------------------------------------------------------------------------------}
{ Edit Insert (DataSet)                                                        }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionDataSetInsertExecute(Sender: TObject);
begin
  DBModule.TableProgram.Insert;
  RefreshEditFields;
end;

{------------------------------------------------------------------------------}
{ Edit Edit (DataSet)                                                          }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionDataSetEditExecute(Sender: TObject);
begin
  DBModule.TableProgram.Edit;
  RefreshEditFields;
end;

{------------------------------------------------------------------------------}
{ Edit Post (DataSet)                                                          }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionDataSetPostExecute(Sender: TObject);
var
  Value: LongInt;
  ActualPos: TBookmark;

begin
  Value := 0;
  // Actualiza
  DBModule.TableProgram.Post;
  if DBEditControl.Text = '' then
  begin
    if DBModule.TableControl.RecordCount = 0 then
    begin
        // Vai procurar o integer mais alto
      ActualPos := DBModule.TableProgram.GetBookmark; // Guarda a posição actual
      DBModule.TableProgram.First; // Vai para o primeiro registo
      while not DBModule.TableProgram.Eof do // Enquanto não vai para o fim
      begin
          // Procura todos os valores do registo para verificar se é maior
        if DBModule.TableProgram['ZIP_CONTROL_NUMBER'] > Value then
          Value := DBModule.TableProgram['ZIP_CONTROL_NUMBER'];
          // Vai para o próximo registo
        DBModule.TableProgram.Next;
      end;
        // Volta para o registo onde estava
      DBModule.TableProgram.GotoBookmark(ActualPos);
        // Incrementa o valor a inserir
      Inc(Value);
    end
    else
    begin
        // Vai para a última posição da tabela de controlo
      DBModule.TableControl.Last;
        // Copia o valor
      Value := DBModule.TableControl['USED'];
        // Apaga o registo
      DBModule.TableControl.Delete;
    end;
    DBModule.TableProgram.Edit;
    DBModule.TableProgram['ZIP_CONTROL_NUMBER'] := Value;
    DBModule.TableProgram.Post;
  end;
  RefreshEditFields;
  { Desactiva as bases de dados }
  DBModule.TableProgram.Active := FALSE;
  DBModule.TableControl.Active := FALSE;
  { Activa as bases de dados }
  DBModule.TableProgram.Active := TRUE;
  DBModule.TableControl.Active := TRUE;
  { O processo anterior foi o único encontrado pra resolver o problema }
  { dos updates no file fisicamente. Este processo é necessário, caso  }
  { contrário se existir um GPF na aplicação, da próxima vez os dados  }
  { não existirão na base de dados.                                    }
  { A única desvantagem é o facto de ser lento abrir e fechar a base de}
  { dados.                                                             }
end;

{------------------------------------------------------------------------------}
{ Edit Delete (DataSet)                                                        }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionDataSetDeleteExecute(Sender: TObject);

begin
  // Guarda o valor usado
  DBModule.TableControl.InsertRecord([DBModule.TableProgram['ZIP_CONTROL_NUMBER']]);
  // Apaga o registo
  DBModule.TableProgram.Delete;
  // Refresca os campos
  RefreshEditFields;
end;

{------------------------------------------------------------------------------}
{ Edit Configuration                                                           }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionEditConfigurationExecute(Sender: TObject);
begin
{...}
  ShowMessage('Not Implemented');
{...}
end;

{------------------------------------------------------------------------------}
{ View First (DataSet)                                                         }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionDataSetFirstExecute(Sender: TObject);
begin
  DBModule.TableProgram.First;
  RefreshEditFields;
end;

{------------------------------------------------------------------------------}
{ View Next (DataSet)                                                          }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionDataSetNextExecute(Sender: TObject);
begin
  DBModule.TableProgram.Next;
  RefreshEditFields;
end;

{------------------------------------------------------------------------------}
{ View Prior (DataSet)                                                         }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionDataSetPriorExecute(Sender: TObject);
begin
  DBModule.TableProgram.Prior;
  RefreshEditFields;
end;

{------------------------------------------------------------------------------}
{ View Last (DataSet)                                                          }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionDataSetLastExecute(Sender: TObject);
begin
  DBModule.TableProgram.Last;
  RefreshEditFields;
end;

{------------------------------------------------------------------------------}
{ View Cancel (DataSet)                                                        }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionDataSetCancelExecute(Sender: TObject);
begin
  DBModule.TableProgram.Cancel;
  RefreshEditFields;
end;

{------------------------------------------------------------------------------}
{ View Refresh (DataSet)                                                       }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionDataSetRefreshExecute(Sender: TObject);
begin
  DBModule.TableProgram.Refresh;
  RefreshEditFields;
end;

{------------------------------------------------------------------------------}
{ View Program Information                                                     }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionViewProgramInformationExecute(Sender: TObject);
begin
  if not MIProgramInformation.Checked then
  begin
    PageControl.ActivePage := TSProgram;
    MIProgramInformation.Checked := TRUE;
  end;
end;

{------------------------------------------------------------------------------}
{ View Source Information                                                      }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionViewSourceInformationExecute(Sender: TObject);
begin
  if not MISourceInformation.Checked then
  begin
    PageControl.ActivePage := TSSource;
    MISourceInformation.Checked := TRUE;
  end;
end;

{------------------------------------------------------------------------------}
{ Tools List                                                                   }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionToolsListExecute(Sender: TObject);
begin
  WndList.Show;
end;

{------------------------------------------------------------------------------}
{ Tools Search                                                                 }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionToolsSearchExecute(Sender: TObject);
begin
{...}
  ShowMessage('Not Implemented');
{...}
end;

{------------------------------------------------------------------------------}
{ Tools Report                                                                 }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionToolsReportExecute(Sender: TObject);
begin
{...}
  ShowMessage('Not Implemented');
{...}
end;

{------------------------------------------------------------------------------}
{ Tools ReIndex (Utilities)                                                    }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionToolsReIndexExecute(Sender: TObject);
begin
  DBModule.DoReindex(DBModule.TableProgram);
end;

{------------------------------------------------------------------------------}
{ Tools Pack (Utilities)                                                       }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionToolsPackExecute(Sender: TObject);
begin
  { Compacta a database }
  DBModule.PackTable(DBModule.TableProgram);
  { Como após a compactação é criado um ficheiro com extensão default }
  { Tem de se apagar o antigo e renomear o novo }
  DeleteFile(DBDir + '\' + FileNoExt + '.PDL');
  RenameFile(DBDir + '\' + FileNoExt + '.DB', DBDir + '\' + FileNoExt + '.PDL');
  { Close our table }
  DBModule.TableProgram.Close;
  { Reset our exclusive mode }
  DBModule.TableProgram.Exclusive := FALSE;
  { Open our table }
  DBModule.TableProgram.Open;
end;

{------------------------------------------------------------------------------}
{ Help Contents                                                                }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionHelpContentsExecute(Sender: TObject);
begin
{...}
  ShowMessage('Not Implemented');
{...}
end;

{------------------------------------------------------------------------------}
{ Help About                                                                   }
{------------------------------------------------------------------------------}

procedure TWndMain.ActionHelpAboutExecute(Sender: TObject);
begin
  WndAbout.ShowModal;
end;

{******************************************************************************}
{   P R I V A T E  D E C L A R A T I O N S                                     }
{******************************************************************************}

{------------------------------------------------------------------------------}
{ Refresh Edit Fields and toggle bettween browse and edit fields               }
{------------------------------------------------------------------------------}

procedure TWndMain.RefreshEditFields;

begin
  if EditMode then
  begin
    { Desliga componentes browse mode }
    DBTextName.Visible := FALSE;
    DBTextVersion.Visible := FALSE;
    DBTextDate.Visible := FALSE;
    DBTextLanguage.Visible := FALSE;
    DBTextOS.Visible := FALSE;
    DBTextType.Visible := FALSE;
    DBTextCoder.Visible := FALSE;
    DBTextCompiler.Visible := FALSE;
    { Liga componentes edit mode }
    DBEditName.Visible := TRUE;
    DBEditVersion.Visible := TRUE;
    DBEditDate.Visible := TRUE;
    DBLookupComboBoxLanguage.Visible := TRUE;
    DBLookupComboBoxOS.Visible := TRUE;
    DBLookupComboBoxType.Visible := TRUE;
    DBEditCoder.Visible := TRUE;
    DBLookupComboBoxCompiler.Visible := TRUE;
    DBMemoDescription.BorderStyle := bsSingle;
    DBMemoComments.BorderStyle := bsSingle;
    DBMemoDescription.Color := clWindow;
    DBMemoComments.Color := clWindow;
    DBMemoDescription.ReadOnly := FALSE;
    DBMemoComments.ReadOnly := FALSE;
    { Coloca Focus }
    if PageControl.ActivePage = TSProgram then DBEditName.SetFocus
    else DBEditCoder.SetFocus;
  end
  else
  begin
    { Desliga componentes edit mode }
    DBEditName.Visible := FALSE;
    DBEditVersion.Visible := FALSE;
    DBEditDate.Visible := FALSE;
    DBLookupComboBoxLanguage.Visible := FALSE;
    DBLookupComboBoxOS.Visible := FALSE;
    DBLookupComboBoxType.Visible := FALSE;
    DBEditCoder.Visible := FALSE;
    DBLookupComboBoxCompiler.Visible := FALSE;
    DBMemoDescription.BorderStyle := bsNone;
    DBMemoComments.BorderStyle := bsNone;
    DBMemoDescription.Color := clBtnFace;
    DBMemoComments.Color := clBtnFace;
    DBMemoDescription.ReadOnly := TRUE;
    DBMemoComments.ReadOnly := TRUE;
    { Liga componentes browse mode }
    DBTextName.Visible := TRUE;
    DBTextVersion.Visible := TRUE;
    DBTextDate.Visible := TRUE;
    DBTextLanguage.Visible := TRUE;
    DBTextOS.Visible := TRUE;
    DBTextType.Visible := TRUE;
    DBTextCoder.Visible := TRUE;
    DBTextCompiler.Visible := TRUE;
  end;
  ImageBIN.Picture.Bitmap.LoadFromResourceName(hInstance, 'FILES');
  ImageSRC.Picture.Bitmap.LoadFromResourceName(hInstance, 'FILES');
  ImageVCL.Picture.Bitmap.LoadFromResourceName(hInstance, 'FILES');
{
  if DataAsChanged then
  begin
    if DBEditZipBIN.Text <> '' then
      if FileExists(DBDir + DBEditZipBIN.Text) then
        ImageBIN.Picture.Bitmap.LoadFromResourceName(hInstance, 'FILES')
      else ImageBIN.Picture.Bitmap.LoadFromResourceName(hInstance, 'NOTFILES')
    else ImageBIN.Picture.Bitmap.LoadFromResourceName(hInstance, 'NOTFILES');

    if DBEditZipSRC.Text <> '' then
      if FileExists(DBDir + DBEditZipSRC.Text) then
        ImageSRC.Picture.Bitmap.LoadFromResourceName(hInstance, 'FILES')
      else ImageSRC.Picture.Bitmap.LoadFromResourceName(hInstance, 'NOTFILES')
    else ImageSRC.Picture.Bitmap.LoadFromResourceName(hInstance, 'NOTFILES');

    if DBEditZipVCL.Text <> '' then
      if FileExists(DBDir + DBEditZipVCL.Text) then
        ImageVCL.Picture.Bitmap.LoadFromResourceName(hInstance, 'FILES')
      else ImageVCL.Picture.Bitmap.LoadFromResourceName(hInstance, 'NOTFILES')
    else ImageVCL.Picture.Bitmap.LoadFromResourceName(hInstance, 'NOTFILES');
  end;
}
end;

{------------------------------------------------------------------------------}
{ Delete directory and all files inside                                        }
{------------------------------------------------------------------------------}

procedure TWndMain.DeleteDir(const Directory: string);
var
  Found: Integer;
  SearchRec: TSearchRec;

begin
  Found := FindFirst(Directory + '\*.*', faArchive, SearchRec);
  while Found = 0 do
  begin
    DeleteFile(Directory + '\' + SearchRec.Name);
    Found := FindNext(SearchRec);
  end;
  FindClose(SearchRec);
  RemoveDir(Directory);
end;

procedure TWndMain.ImageBINMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  TempFile: string;

begin
  if DBEditControl.Text <> '' then
  begin
    PopupMenu.AutoPopup := TRUE;
    TempFile := DBDir + IntToHex(StrToInt(DBEditControl.Text), 8) + '_E';
    if WndZIPList.ZipMaster.ZipFileName <> TempFile then
    begin
      WndZIPList.ZipMaster.ZipFileName := TempFile;
      WndZIPList.Caption := 'Executable Files List [' + DBEditName.Text + ' ' + DBEditVersion.Text + ']';
    end;
  end
  else PopupMenu.AutoPopup := FALSE;
end;

procedure TWndMain.ImageSRCMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  TempFile: string;

begin
  if DBEditControl.Text <> '' then
  begin
    PopupMenu.AutoPopup := TRUE;
    TempFile := DBDir + IntToHex(StrToInt(DBEditControl.Text), 8) + '_S';
    if WndZIPList.ZipMaster.ZipFileName <> TempFile then
    begin
      WndZIPList.ZipMaster.ZipFileName := TempFile;
      WndZIPList.Caption := 'Source Files List [' + DBEditName.Text + ' ' + DBEditVersion.Text + ']';
    end;
  end
  else PopupMenu.AutoPopup := FALSE;
end;

procedure TWndMain.ImageVCLMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  TempFile: string;

begin
  if DBEditControl.Text <> '' then
  begin
    PopupMenu.AutoPopup := TRUE;
    TempFile := DBDir + IntToHex(StrToInt(DBEditControl.Text), 8) + '_V';
    if WndZIPList.ZipMaster.ZipFileName <> TempFile then
    begin
      WndZIPList.ZipMaster.ZipFileName := TempFile;
      WndZIPList.Caption := 'VCL Files List [' + DBEditName.Text + ' ' + DBEditVersion.Text + ']';
    end;
  end
  else PopupMenu.AutoPopup := FALSE;
end;

procedure TWndMain.PMShowListClick(Sender: TObject);
begin
  // Disable auto hint
  StatusBar.AutoHint := FALSE;
  WndZIPList.Memo.Lines.CommaText := WndZIPList.ZipMaster.ZipComment;
  // List names
  with WndZIPList.SortGrid do
  begin
   { Make sure "goColMoving" is false in object inspector. This lets the
    TSortGrid use Mouse Clicks on the col headers. }
    RowCount := 2; { first row is fixed, and used for column headers }
    Cells[0, 0] := 'Name';
    Cells[1, 0] := 'Modified';
    Cells[2, 0] := 'Size';
    Cells[3, 0] := 'Ratio';
    Cells[4, 0] := 'Packed';
    Cells[5, 0] := 'Path';
  end;
  // Start list
  WndZIPList.ZipMaster.List;
  // Show and stay
  WndZIPList.ShowModal;
end;

procedure TWndMain.PopupMenuPopup(Sender: TObject);
begin
  if not FileExists(WndZIPList.ZipMaster.ZipFileName) then PMShowList.Enabled := FALSE
  else PMShowList.Enabled := TRUE;
end;

procedure TWndMain.PMFilesClick(Sender: TObject);
begin
  WndZIPList.PMFilesClick(Sender);
end;

procedure TWndMain.PMDirectoriesClick(Sender: TObject);
begin
  WndZIPList.PMDirectoriesClick(Sender);
end;

procedure TWndMain.PMZipClick(Sender: TObject);
begin
  WndZIPList.PMZipClick(Sender);
end;

procedure TWndMain.PMNewClick(Sender: TObject);
begin
  case ActualComboBox of
    2: begin
        WndNew.Caption := 'Languages Database';
        WndNew.DBGrid.Columns.Items[0].Title.Caption := 'Language';
        WndNew.DBGrid.Columns.Items[0].FieldName := 'LANGUAGE';
        WndNew.ShowModal;
      end;
    3: begin
        WndNew.Caption := 'Operating Systems Database';
        WndNew.DBGrid.Columns.Items[0].Title.Caption := 'O. System';
        WndNew.DBGrid.Columns.Items[0].FieldName := 'OS';
        WndNew.ShowModal;
      end;
    4: begin
        WndNew.Caption := 'Program Types Database';
        WndNew.DBGrid.Columns.Items[0].Title.Caption := 'Type';
        WndNew.DBGrid.Columns.Items[0].FieldName := 'TYPE';
        WndNew.ShowModal;
      end;
    5: begin
        WndNew.Caption := 'Compilers Database';
        WndNew.DBGrid.Columns.Items[0].Title.Caption := 'Compiler';
        WndNew.DBGrid.Columns.Items[0].FieldName := 'COMPILER';
        WndNew.ShowModal;
      end;
  end;
end;

procedure TWndMain.DBLookupComboBoxLanguageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ActualComboBox := 2;
end;

procedure TWndMain.DBLookupComboBoxOSMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ActualComboBox := 3;
end;

procedure TWndMain.DBLookupComboBoxTypeMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ActualComboBox := 4;
end;

procedure TWndMain.DBLookupComboBoxCompilerMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ActualComboBox := 5;
end;

end.

