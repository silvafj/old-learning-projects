{*********************************************************}
{                                                         }
{  Putdate                                                }
{   - Form principal do programa -                        }
{                                                         }
{     Copyright (c) 1993-1999 Fernando J.A. Silva         }
{     All rights reserved                                 }
{                                                         }
{*********************************************************}
unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TMainWnd = class(TForm)
    AnoEdit: TEdit;
    Label1: TLabel;
    OpenDialog: TOpenDialog;
    BrowseBtn: TButton;
    ChangeBtn: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit2: TEdit;
    Label5: TLabel;
    Edit3: TEdit;
    Label6: TLabel;
    Edit4: TEdit;
    Label7: TLabel;
    Edit5: TEdit;
    procedure BrowseBtnClick(Sender: TObject);
    procedure ChangeBtnClick(Sender: TObject);
    function SetFileDateTime(const FileName: string;var yyyy,mm,dd,h,m,s: word): boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainWnd: TMainWnd;

implementation

{$R *.DFM}




procedure TMainWnd.BrowseBtnClick(Sender: TObject);
begin
  OpenDialog.Execute;
end;

procedure TMainWnd.ChangeBtnClick(Sender: TObject);
var
  i : integer;
  error : integer;
//  ADateAndTime: TDateTime;
//  FileDateAndTime : integer;
//  FileHandle : integer;
  ano, mes, dia, hh, mm, ss : word;

begin
 If OpenDialog.Files.Count > 0 then
   begin
     for i := 0 to OpenDialog.Files.Count - 1 do
       begin
         Label2.Caption := OpenDialog.Files.Strings[i];
         Val(AnoEdit.Text,ano,error);
         Val(Edit1.Text,mes,error);
         Val(Edit2.Text,dia,error);
         Val(Edit3.Text,hh,error);
         Val(Edit4.Text,mm,error);
         Val(Edit5.Text,ss,error);
         SetFileDateTime(OpenDialog.Files.Strings[i],
                         ano,mes,dia,hh,mm,ss);
//         ADateAndTime := StrToDateTime(DateEdit.Text);
//         FileDateAndTime := DateTimeToFileDate(ADateAndTime);
//         FileHandle := FileOpen(OpenDialog.Files.Strings[i],fmOpenReadWrite or fmShareDenyNone);
//         FileSetDate(FileHandle,FileDateAndTime);
//         FileClose(FileHandle);
//         MessageDlg(OpenDialog.Files.Strings[i],mtError,[mbOK],0);
       end;
   end;

end;

function TMainWnd.SetFileDateTime(const FileName: string;
                                       var yyyy,mm,dd,h,m,s: word):
boolean;
{sets Created, Modified & LastAccessed file date/times}
var
  SrchHdl: THandle;
  FileHdl: HFile;
  FindData: TWin32FindData;
  wDate,wTime: word;
  LocalFileTime, NewFileTime: TFileTime;
begin
  result := false;
  SrchHdl := FindFirstFile(PChar(FileName), FindData);
  if SrchHdl <> INVALID_HANDLE_VALUE then begin
    Windows.FindClose(SrchHdl);
    {if not a directory then ...}
    if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
begin
      wTime := (h shl 11) + (m shl 5) + (m div 2);
      wDate := (dd) + (mm shl 5)+ ((yyyy-1980) shl 9);

      DosDateTimeToFileTime(wDate,wTime,LocalFileTime);
      LocalFileTimeToFileTime(LocalFileTime, NewFileTime);
      FileHdl := _lopen(PChar(FileName), OF_WRITE);
      if FileHdl <> HFILE_ERROR then begin
        if SetFileTime(FileHdl,@NewFileTime,@NewFileTime,@NewFileTime) then
            result := true;
        _lclose(FileHdl);
      end;
    end;
  end;
end;







end.
