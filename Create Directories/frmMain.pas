{******************************************************************************}
{                                                                              }
{  CreateDirs - Create Directories                                             }
{  Unit principal do programa.                                                 }
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
  StdCtrls, ComCtrls, BrowseDr;

type
  TWndMain = class(TForm)
    BtnCreate: TButton;
    MemoDirectories: TMemo;
    LabelDirectories: TLabel;
    LabelParent: TLabel;
    EditDir: TEdit;
    BtnBrowse: TButton;
    LabelLast: TLabel;
    RichEditResults: TRichEdit;
    BrowseDirectoryDlg: TBrowseDirectoryDlg;
    procedure BtnCreateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure BtnBrowseClick(Sender: TObject);
  private
    { Private declarations }
    procedure Animate(var Msg: TWMSYSCOMMAND); message WM_SYSCOMMAND;
  public
    { Public declarations }
  end;

var
  WndMain: TWndMain;

implementation

{$R *.DFM}

procedure TWndMain.BtnCreateClick(Sender: TObject);

  procedure Imprime(Directory: string; Tipo: string);
  begin
    if Tipo = 'RED' then
    begin
      RichEditResults.SelAttributes.Color := clRed;
      RichEditResults.SelAttributes.Style := [fsBold];
      RichEditResults.Lines.Add('NOT Created   ');
      RichEditResults.SelAttributes.Style := [];
      RichEditResults.Lines.Append(Directory);
    end;

    if Tipo = 'GREEN' then
    begin
      RichEditResults.SelAttributes.Color := clLime;
      RichEditResults.SelAttributes.Style := [fsBold];
      RichEditResults.Lines.Add('Created   ');
      RichEditResults.SelAttributes.Style := [];
      RichEditResults.Lines.Append(Directory);
    end;

    if Tipo = 'YELLOW' then
    begin
      RichEditResults.SelAttributes.Color := clYellow;
      RichEditResults.SelAttributes.Style := [fsBold];
      RichEditResults.Lines.Add('Directory already exists   ');
      RichEditResults.SelAttributes.Style := [];
      RichEditResults.Lines.Append(Directory);
    end;
  end;

var
  I: Integer;
  Criado: Boolean;
  TempDir: string;

begin
  EditDir.Enabled := FALSE;
  BtnBrowse.Enabled := FALSE;
  MemoDirectories.Enabled := FALSE;
  BtnCreate.Enabled := FALSE;
  RichEditResults.Lines.Clear;
  if (EditDir.Text <> '') and DirExists(EditDir.Text) then
  begin
    TempDir := EditDir.Text;
    if TempDir[Length(TempDir)] <> '\' then TempDir := TempDir + '\';
    for I := 0 to MemoDirectories.Lines.Count - 1 do
    begin
      Criado := CreateDir(TempDir + MemoDirectories.Lines.Strings[I]);
      if not Criado then
        if DirExists(TempDir + MemoDirectories.Lines.Strings[I]) then
          Imprime(TempDir + MemoDirectories.Lines.Strings[I], 'YELLOW')
        else Imprime(TempDir + MemoDirectories.Lines.Strings[I], 'RED')
      else Imprime(TempDir + MemoDirectories.Lines.Strings[I], 'GREEN')
    end
  end
  else MessageDlg('Invalid parent directory.', mtError, [mbOK], 0);
  EditDir.Enabled := TRUE;
  BtnBrowse.Enabled := TRUE;
  MemoDirectories.Enabled := TRUE;
  BtnCreate.Enabled := TRUE;
end;


procedure TWndMain.FormCreate(Sender: TObject);
begin
  Windows.SetParent(WndMain.Handle, GetDesktopWindow); // Used to animate form
end;

procedure TWndMain.Animate(var Msg: TWMSYSCOMMAND);
begin
  Msg.Result := DefWindowProc(Handle,
    WM_SYSCOMMAND,
    TMESSAGE(Msg).wParam,
    TMESSAGE(Msg).lParam);
end;

procedure TWndMain.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := 0;
end;

procedure TWndMain.BtnBrowseClick(Sender: TObject);
begin
  if BrowseDirectoryDlg.Execute then
    EditDir.Text := BrowseDirectoryDlg.Selection;
end;

end.

