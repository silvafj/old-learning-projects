{******************************************************************************}
{                                                                              }
{  RSIF - Replace Strings Inside Files                                         }
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
  StdCtrls, ComCtrls;

type
  TWndMain = class(TForm)
    LabelFiles: TLabel;
    LabelResults: TLabel;
    Label1: TLabel;
    EditFind: TEdit;
    Label2: TLabel;
    EditReplace: TEdit;
    BtnBrowse: TButton;
    BtnScan: TButton;
    RichEditResults: TRichEdit;
    OpenDialog: TOpenDialog;
    MemoFiles: TMemo;
    CheckBoxCase: TCheckBox;
    procedure BtnBrowseClick(Sender: TObject);
    procedure BtnScanClick(Sender: TObject);
  private
    { Private declarations }
    procedure ImprimeResultado(Ficheiro: string; Resultado, Efectuadas: integer);
  public
    { Public declarations }
  end;

var
  WndMain: TWndMain;

implementation

{$R *.DFM}

procedure TWndMain.BtnBrowseClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    MemoFiles.Lines.Clear;
    MemoFiles.Lines.Assign(OpenDialog.Files);
  end;
end;

procedure TWndMain.ImprimeResultado(Ficheiro: string; Resultado, Efectuadas: integer);
begin
  case resultado of
    0:
      begin
        RichEditResults.SelAttributes.Color := clLime;
        RichEditResults.SelAttributes.Style := [fsBold];
        RichEditResults.Lines.Add('Sucessful  ' + Ficheiro);
        RichEditResults.SelAttributes.Style := [];
        RichEditResults.Lines.Add('Replaced strings: ' + IntToStr(Efectuadas));
      end;
  else
    begin
      RichEditResults.SelAttributes.Color := clRed;
      RichEditResults.SelAttributes.Style := [fsBold];
      RichEditResults.Lines.Add('NOT Sucessful  ' + Ficheiro);
    end;
  end;
end;

function StringReplace(const S, OldPattern, NewPattern: string;
  var Number : integer; Flags: TReplaceFlags): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then
  begin
    SearchStr := AnsiUpperCase(S);
    Patt := AnsiUpperCase(OldPattern);
  end else
  begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do
  begin
    Offset := AnsiPos(Patt, SearchStr);
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    Inc(Number);
    if not (rfReplaceAll in Flags) then
    begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;

procedure TWndMain.BtnScanClick(Sender: TObject);

var
  I, L: Integer;
  Resultado: integer;
  Efectuadas: integer;
  F: TextFile;
  StringList : TStringList;
  ReplaceFlags : TReplaceFlags;

begin
  if EditFind.Text <> '' then
    if MemoFiles.Lines.Count > 0 then
    begin
      // Disable
      MemoFiles.Enabled := FALSE;
      EditFind.Enabled := FALSE;
      EditReplace.Enabled := FALSE;
      CheckBoxCase.Enabled := FALSE;
      BtnBrowse.Enabled := FALSE;
      BtnScan.Enabled := FALSE;
      // Limpa e cria
      RichEditResults.Lines.Clear;
      StringList := TStringList.Create;
      if not CheckBoxCase.Checked then ReplaceFlags := [rfReplaceAll, rfIgnoreCase]
      else ReplaceFlags := [rfReplaceAll];
      // Start Scan and replacing
      for I := 0 to MemoFiles.Lines.Count - 1 do
      begin
        Efectuadas := 0;
        // Load File
{$I-}
        AssignFile(F, MemoFiles.Lines.Strings[I]);
        FileMode := 0; { Read only}
        Reset(F);
{$I+}
        if IOResult = 0 then
        begin
          CloseFile(F);
          StringList.Clear;
          StringList.LoadFromFile(MemoFiles.Lines.Strings[I]);
          Resultado := 0;
          // process file
          RichEditResults.SelAttributes.Color := clLime;
          for L := 0 to StringList.Count - 1 do
//            begin
             StringList.Strings[L] := StringReplace(StringList.Strings[L], EditFind.Text, EditReplace.Text, Efectuadas, ReplaceFlags);
//             RichEditResults.Lines.Add(StringList.Strings[L]);
//            end;
          // Save File
          StringList.SaveToFile(MemoFiles.Lines.Strings[I]);
        end
        else Resultado := 1;
        ImprimeResultado(MemoFiles.Lines.Strings[I], Resultado, Efectuadas);
      end;
      StringList.Free;
      // Enable
      MemoFiles.Enabled := TRUE;
      EditFind.Enabled := TRUE;
      EditReplace.Enabled := TRUE;
      CheckBoxCase.Enabled := TRUE;
      BtnBrowse.Enabled := TRUE;
      BtnScan.Enabled := TRUE;
    end
    else MessageDlg('There are no defined files to replace strings.', mtError, [mbOK], 0)
  else MessageDlg('There is no defined text to find.', mtError, [mbOK], 0);
end;

end.

