{******************************************************************************}
{                                                                              }
{  ChgFileName - Change FileName                                               }
{  Programa Principal.                                                         }
{                                                                              }
{  Copyright (c) 1999 Fernando J.A. Silva (aka ^Magico^)                       }
{                                                                              }
{      Todos os direitos reservados                                            }
{                                                                              }
{******************************************************************************}

{* Versões ********************************************************************}
{                                                                              }
{ 01/Setembro/1999  v1.00 - Borland Delphi 4.0 (build 5.37)                    }
{  + Versão Inicial                                                            }
{  -> Programador : Fernando J.A. Silva (aka ^Magico^)                         }
{  -> E-mail : magico@GalaxyCorp.com                                           }
{                                                                              }
{ 16/Setembro/1999  v1.10 - Borland Delphi 4.0 (build 5.37)                    }
{  + Foi adicionada a recursividade de directórios                             }
{  -> Programador : Fernando J.A. Silva (aka ^Magico^)                         }
{  -> E-mail : magico@GalaxyCorp.com                                           }
{                                                                              }
{******************************************************************************}
program ChgFileName;

uses
  Windows,
  Forms,
  frmMain in 'frmMain.pas' {WndMain};

{$R *.RES}

begin
  SetWindowLong(Application.Handle, GWL_EXSTYLE,
    (GetWindowLong(Application.Handle, GWL_EXSTYLE)
    and not (WS_EX_APPWINDOW)) or WS_EX_TOOLWINDOW);
  ShowWindow(Application.Handle, SW_HIDE);
  Application.Initialize;
  Application.Title := 'Change Filename';
  Application.CreateForm(TWndMain, WndMain);
  Application.Run;
end.

