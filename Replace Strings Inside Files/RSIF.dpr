{******************************************************************************}
{                                                                              }
{  RSIF - Replace Strings Inside Files                                         }
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
{******************************************************************************}
program RSIF;

uses
  Forms,
  frmMain in 'frmMain.pas' {WndMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Replace Strings Inside Files';
  Application.CreateForm(TWndMain, WndMain);
  Application.Run;
end.
