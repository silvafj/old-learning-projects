{******************************************************************************}
{                                                                              }
{  ChgFileName - Change FileName                                               }
{  Unit Principal do programa.                                                 }
{                                                                              }
{  Copyright (c) 1999 Fernando J.A. Silva (aka ^Magico^)                       }
{                                                                              }
{      Todos os direitos reservados                                            }
{                                                                              }
{******************************************************************************}
unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, fmxUtils, BrowseDr;

type
  TWndMain = class(TForm)
    EditDir: TEdit;
    BtnBrowse: TButton;
    BtnProcess: TButton;
    ActualFile: TLabel;
    Memo: TMemo;
    BrowseDirectoryDlg: TBrowseDirectoryDlg;
    OldFile: TLabel;
    procedure BtnBrowseClick(Sender: TObject);
    procedure BtnProcessClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    // Usado para fazer a animação da form
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private declarations }
    Total : integer; // Total de ficheiros processados
    // Usado para fazer a animação da form
    procedure Animate(var Msg: TWMSYSCOMMAND); message WM_SYSCOMMAND;
    procedure FindAndChange(MainDir: string);
  public
    { Public declarations }
  end;

var
  WndMain: TWndMain;

implementation

{$R *.DFM}

{******************************************************************************}
{   W N D M A I N - Events                                                     }
{******************************************************************************}

{------------------------------------------------------------------------------}
{ FormCreate (OnCreate)                                                        }
{------------------------------------------------------------------------------}

procedure TWndMain.FormCreate(Sender: TObject);
begin
  // Usado para animação
  Windows.SetParent(WndMain.Handle, GetDesktopWindow);
end;

{******************************************************************************}
{   B U T T O N S                                                              }
{******************************************************************************}

{------------------------------------------------------------------------------}
{ BtnBrowse                                                                    }
{------------------------------------------------------------------------------}
procedure TWndMain.BtnBrowseClick(Sender: TObject);
begin
  if BrowseDirectoryDlg.Execute then
    EditDir.Text := BrowseDirectoryDlg.Selection;
end;

{------------------------------------------------------------------------------}
{ BtnProcess                                                                   }
{------------------------------------------------------------------------------}
procedure TWndMain.BtnProcessClick(Sender: TObject);
var
  TempDir: string;

begin
  if (EditDir.Text <> '') and DirectoryExists(EditDir.Text) then
  begin
    Total := 0;
    // Desliga
    EditDir.Enabled := FALSE;
    BtnBrowse.Enabled := FALSE;
    BtnProcess.Enabled := FALSE;
    // Começa o processamento
    TempDir := EditDir.Text;
    if TempDir[Length(TempDir)] <> '\' then
      TempDir := TempDir + '\';
    FindAndChange(TempDir);
    // Liga
    EditDir.Enabled := TRUE;
    BtnBrowse.Enabled := TRUE;
    BtnProcess.Enabled := TRUE;
    MessageDlg('Total Files Processed : '+IntToStr(Total),mtInformation,[mbOK],0);
  end;
end;

{******************************************************************************}
{   P R I V A T E  D E C L A R A T I O N S                                     }
{******************************************************************************}

{------------------------------------------------------------------------------}
{ Rotina usada na animação da form                                             }
{------------------------------------------------------------------------------}
procedure TWndMain.Animate(var Msg: TWMSYSCOMMAND);
begin
  Msg.Result := DefWindowProc(Handle,
    WM_SYSCOMMAND,
    TMESSAGE(Msg).wParam,
    TMESSAGE(Msg).lParam);
end;

{------------------------------------------------------------------------------}
{ Rotina usada na animação da form                                             }
{------------------------------------------------------------------------------}
procedure TWndMain.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := 0;
end;

{------------------------------------------------------------------------------}
{ Rotina de processamento dos ficheiros com recursividade de directórios       }
{------------------------------------------------------------------------------}
procedure TWndMain.FindAndChange(MainDir: string);
var
  SearchRec: TSearchRec;
  I: Integer;
  MyFileName: string;
  DirList: TStringList;

begin
  DirList := TStringList.Create;
  DirList.Clear;
  FindFirst(MainDir + '*.*', faAnyFile, SearchRec);
  while FindNext(SearchRec) = 0 do
  begin
    if ((SearchRec.Attr and faDirectory) > 0) and
      (SearchRec.Name <> '..') and (SearchRec.Name <> '.') then
      DirList.Add(MainDir + SearchRec.Name + '\')
    else
    begin
      OldFile.Caption := MainDir + SearchRec.Name;
      OldFile.Refresh;
      MyFileName := StringReplace(SearchRec.Name, '_', ' ', [rfReplaceAll, rfIgnoreCase]);
      RenameFile(MainDir + SearchRec.Name, MainDir + MyFileName);
      ActualFile.Caption := MainDir + MyFileName;
      ActualFile.Refresh;
      Inc(Total);
    end;
  end;
  FindClose(SearchRec);
  if DirList.Count > 0 then
  begin
    for I := 0 to DirList.Count - 1 do
      FindAndChange(DirList.Strings[I]);
  end;
  DirList.Free;
end;

end.

