{*********************************************************}
{                                                         }
{  Putdate - Main Project                                 }
{                                                         }
{          Copyright (c) 1993-1999  Fernando J.A. Silva   }
{          All rights reserved                            }
{                                                         }
{*********************************************************}

{* Versões ***********************************************}
{                                                         }
{ 23/Fev/1999  v1.00 - Borland Delphi 4.0 (build 5.37)    }
{  + Primeira versão em windows.                          }
{  -> Programador : Fernando J.A. Silva (aka ^Magico^)    }
{  -> E-mail : magico@GalaxyCorp.com                      }
{*********************************************************}
program PutDate;

uses
  Forms,
  Main in 'Main.pas' {MainWnd};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainWnd, MainWnd);
  Application.Run;
end.
