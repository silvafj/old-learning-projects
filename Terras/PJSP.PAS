Unit PJSP;
Interface
Uses Crt, Dos, Graph;

Function  UpperCase( StrIn : String )                   : String;
Procedure EscreveEm( X, Y: Byte; StrIn: String );
Function  ReadString( X, Y, Tamanho: Integer; Tipo: Char):String;
Function  ReadNum( X, Y, Tamanho: Integer; Tipo: Char):String;
Function  ReadInt( x, y, Tamanho: Integer; Tipo: Char):String;
Function  ReadStringG( X, Y, Tamanho: Integer ):String;
Function  ReadNumG( X, Y, Tamanho: Integer ):String;
Function  ReadIntG( x1,y1,x2,y2,nH,nV,Tamanho,Cor,CorF: Word):String;
Function  ReadIntX( X, Y, Tam: Byte; Car: Char ): String;
Function  Real_Em_Str( rIn: Real ): String;
Function  Int_Em_Tam( n: Byte; Valor: Word ): String;
Function  Str_Em_Tam( n: Byte; StrIn: String ): String;
Function  Num_Em_Str( Valor: Integer ): String;
Function  Long_Em_Str( Valor: LongInt; Var L: Byte ): String;
Function  Str_Em_Num( StrIn: String ): Word;
Function  Str_Em_Long( StrIn: String ): LongInt;
Function Existe_Ficheiro( NomeF: String ) : Boolean;
Function Divide_em_Milhares( Valor: String; Virgula: Char ): String;
Function Le_Teclado: String;
Procedure Data(Var Ds: String; Var Dia,Mes,Ano:Word);

Implementation
Type
  po     = ^Jan;
  Jan    = Record
             Atrib : Word;
             Prox   : Po;
           End;
  Sp     = ^Stack;
  Stack  = Record
             x1, y1, x2, y2: Byte;
             Sombra, Borda : Boolean;
             Pont          : Po;
             Prox          : Sp;
           End;

Var
  Sp1      : Sp;
  Registos : Registers;


Function UpperCase( StrIn : String ): String;
Var
  Aux : String;
  Loop: Integer;
Begin
  Aux := '';
  For Loop := 1 To Length( StrIn ) Do
    Aux := Aux + UpCase( StrIn[ Loop ] );
  UpperCase := Aux;
end;

Procedure EscreveEm( X, Y: Byte; StrIn: String );
Begin
  GoToXY( X, Y );
  Write( StrIn );
End; { Procedure EscreveEm }

Procedure Inicia( X1, Y1, Tam : Integer; Tip : Char);
Var
  V : Integer;

Begin
  For V := 1 To Tam Do
  Begin
    GoToXY( X1 - 1 + V , Y1 );
    Write( Tip );
  End;
  GoToXY( X1 , Y1 );
End;


Function ReadString( X, Y, Tamanho: Integer; Tipo: Char):String;

Var
  C     : Char;
  S     : String[ 80 ];
  N1, n : Integer;
  Ac    : Array[ 1..80 ] of Char;
  Loop  : Integer;

Begin
  N := 0;
  Inicia( X, Y, Tamanho, Tipo );
  Repeat
    C := ReadKey;
    If (C in [' '..'z']) Then
    Begin
      If n >= Tamanho Then n := n - 1;
      GoToXY( X + n , Y );
      Write( C );
      N := N + 1;
      Ac[ N ] := C;
    End;
    If ( C = Char( 8 ) ) And ( n > 0 ) Then
    Begin
      GoToXY( X + N - 1, Y );
      Write( Tipo );
      GoToXY( X + N - 1, Y );
      Ac[ N ] := ' ';
      N := N - 1;
    End;
  Until C= Char( 13 );
  S := '';
  For N1 := 1 To N  Do S := S + Ac[N1];
  ReadString := S;
  For Loop := 1 To Tamanho Do
  Begin
    GoToXY( X + Loop - 1, Y );
    Write(' ');
  End;
    {GoToXY( X + Tamanho - Length( S ), Y );
    Write( S );}
end;


Function ReadNum( x, y, Tamanho: Integer; Tipo: Char):String;
Var
  C     : Char;
  S     : String[60];
  N1, n : Integer;
  Ac    : Array[ 1..80 ] of Char;
  Virg, VirgPos : integer;

Procedure Recua;
begin
  GoToXY( X + n - 1, Y );
  Write( Tipo );
  GoToXY( X + n - 1, Y );
  Ac[n] := ' ';
  n := n - 1;
end;

Procedure Escreve;
begin
  If n >= Tamanho Then n := n - 1;
  GoToXY( X + n , Y );
  Write( C );
  n := n + 1;
  Ac[n] := C;
end;

begin
  n := 0;
  Inicia( X, Y, Tamanho, Tipo);
  Virg := 0;
  repeat
    C := ReadKey;
    If ( C in ['0'..'9']) Then Escreve;
    if c = '.' then
    begin
      Virg := Virg + 1;
      If Virg <= 1 Then
      Begin
        Escreve;
        If Virg = 1 Then VirgPos := n;
      end;
    end;
    If ( C = Char(8) ) And ( n > 0 ) Then
    begin
      Recua;
      If n <= VirgPos Then Virg :=  0;
    end;
    If C = '.' Then Virg := virg + 1;
  until c= char(13);
  S := '';
  For N1 := 1 To n Do S := S + Ac[N1];
  ReadNum := S;
  n := 0;
end;

Function ReadInt( x, y, Tamanho: Integer; Tipo: Char):String;
Var
  C     : Char;
  S     : String[60];
  N1, n : Integer;
  Ac    : Array[ 1..80 ] of Char;
  Virg, VirgPos : integer;

Procedure Recua;
begin
  GoToXY( X + n - 1, Y );
  Write( Tipo );
  GoToXY( X + n - 1, Y );
  Ac[n] := ' ';
  n := n - 1;
end;


Procedure Escreve;
begin
  If n >= Tamanho Then n := n - 1;
  GoToXY( X + n , Y );
  Write( C );
  n := n + 1;
  Ac[n] := C;
end;

begin
  n := 0;
  Inicia( X, Y, Tamanho, Tipo);
  Virg := 0;
  repeat
    C := ReadKey;
    If ( C in ['0'..'9']) Then Escreve;
    If ( C = Char(8) ) And ( n > 0 ) Then Recua;
  until c= char(13);
  S := '';
  For N1 := 1 To n Do S := S + Ac[N1];
  ReadInt := S;
  n := 0;
end;

Function PosX( n, Xi: Integer ): Integer;
Var
  Acum, T, Aux : Integer;
Begin
  If n = 1 Then Aux := Xi
  Else
    Begin
      T := TextWidth( '-' );
      Acum := 0;
      Aux := Xi;
      Repeat
        Acum := Acum + 1;
        Aux := Aux + T;
      Until Acum = n-1;
    End;
  PosX := Aux;
End; { Function PosX( n, Xi: Integer ) }

Function ReadStringG( X, Y, Tamanho: Integer):String;
Var
  C, uC : Char;
  S     : String[ 80 ];
  N1, n : Integer;
  Ac    : Array[ 1..80 ] of Char;
  Loop  : Integer;
  Cor, CorF: Word;

Begin
  Cor := GetColor;
  CorF := GetBkColor;
  For Loop := 1 To Tamanho Do OutTextXY( PosX( Loop, X), Y, '_' );
  N := 0;
  Repeat
    SetColor( Cor );
    C := ReadKey;
    If (C in [' '..'z']) Then
    Begin
      If n >= Tamanho Then
      Begin
        n := n - 1;
        SetColor( CorF );
        OutTextXY( PosX( n+1, X), Y, uC );
      End;
      SetColor( CorF );
      OutTextXY( PosX( n+1, X), Y, '_' );
      SetColor( Cor );
      OutTextXY( PosX( n+1, X), Y, C );
      N := N + 1;
      Ac[ N ] := C;
    End;
    If ( C = Char( 8 ) ) And ( n > 0 ) Then
    Begin
      SetColor( CorF );
      OutTextXY( PosX( n, X), Y, Ac[n] );
      SetColor( Cor );
      Ac[ N ] := ' ';
      N := N - 1;
      OutTextXY( PosX( n+1, X), Y, '_' );
    End;
    uC := C;
Until C= Char( 13 );
    S := '';
    SetColor( CorF );
    For N1 := 1 To Tamanho Do OutTextXY( PosX( N1, X ), Y, '_' );
    For N1 := 1 To N Do
    Begin
      OutTextXY( PosX( N1, X ), Y, Ac[N1] );
      S := S + Ac[N1];
    End;
    SetColor( Cor );
    OutTextXY( X, Y, S );
    ReadStringG := S;
End; { Function ReadStringG( X, Y, Tamanho: Integer) }

Function ReadNumG( x, y, Tamanho: Integer):String;
Var
  C, uC : Char;
  S     : String[60];
  N1, n : Integer;
  Ac    : Array[ 1..80 ] of Char;
  Virg, VirgPos : integer;
  Cor, CorF: Word;

Procedure Recua;
Begin
  SetColor( CorF );
  OutTextXY( PosX( n, X ), Y, Ac[n] );
  SetColor( Cor );
  OutTextXY( PosX( n, X ), Y, '_' );
  Ac[n] := ' ';
  n := n - 1;
End; { Procedure Recua }

Procedure Escreve;
Begin
  If n >= Tamanho Then
  Begin
    n := n - 1;
    SetColor( CorF );
    OutTextXY( PosX( n+1, X), Y, uC );
  End;
  n := n + 1;
  SetColor( CorF );
  OutTextXY( PosX( n, X), Y, '_' );
  SetColor( Cor );
  OutTextXY( PosX( n, X ), Y, C );
  Ac[n] := C;
End; { Procedure Escreve }

Begin
  Cor := GetColor;
  CorF := GetBkColor;
  SetColor( Cor );
  For n := 1 To Tamanho Do OutTextXY( PosX( n, X), Y, '_' );
  n := 0;
  Virg := 0;
  Repeat
    C := ReadKey;
    If ( C in ['0'..'9']) Then Escreve;
    If c = '.' Then
    Begin
      Virg := Virg + 1;
      If Virg <= 1 Then
      Begin
        Escreve;
        If Virg = 1 Then VirgPos := n;
      End;
    End;
    If ( C = Char(8) ) And ( n > 0 ) Then
    Begin
      Recua;
      If n <= VirgPos Then Virg :=  0;
    End;
    If C = '.' Then Virg := virg + 1;
    uC := C;
  Until c = Char(13);
  S := '';
  SetColor( CorF );
  For N1 := 1 To Tamanho Do OutTextXY( PosX( N1, X ), Y, '_' );
  For N1 := 1 To N Do
  Begin
    OutTextXY( PosX( N1, X ), Y, Ac[N1] );
    S := S + Ac[N1];
  End;
  SetColor( Cor );
  OutTextXY( X, Y, S );
  ReadNumG := S;
  n := 0;
End; { Function ReadNumG }

Function ReadIntG( x1,y1,x2,y2,nH,nV,Tamanho,Cor,CorF: Word):String;
Var
  C, uC : Char;
  S     : String[60];
  N1, n : Integer;
  Ac    : Array[ 1..80 ] of Char;
  X,Y: Word;

Procedure Recua;
Begin
  SetColor( CorF );
  OutTextXY( PosX( n, X ), Y, Ac[n] );
  SetColor( Cor );
  OutTextXY( PosX( n, X ), Y, '_' );
  Ac[n] := ' ';
  n := n - 1;
End; { Procedure Recua }

Procedure Escreve;
Begin
  If n >= Tamanho Then
  Begin
    n := n - 1;
    SetColor( CorF );
    OutTextXY( PosX( n+1, X), Y, uC );
  End;
  n := n + 1;
  SetColor( CorF );
  OutTextXY( PosX( n, X), Y, '_' );
  SetColor( Cor );
  OutTextXY( PosX( n, X ), Y, C );
  Ac[n] := C;
End; { Procedure Escreve }

Begin
  SetFillStyle(SolidFill, CorF);
  Bar(x1,y1,x2,y2); X:= x1+nH; Y:=y1+nV;
  {For n := 1 To Tamanho Do OutTextXY( PosX( n, X), Y, '_' );}
  n := 0;
  Repeat
    C := ReadKey;
    If ( C in ['0'..'9']) Then Escreve;
    If ( C = Char(8) ) And ( n > 0 ) Then Recua;
    uC := C;
  Until c= char(13);
  S := '';
  SetColor( CorF );
  For N1 := 1 To Tamanho Do OutTextXY( PosX( N1, X ), Y, '_' );
  For N1 := 1 To N Do
  Begin
    OutTextXY( PosX( N1, X ), Y, Ac[N1] );
    S := S + Ac[N1];
  End;
  SetColor( Cor );
  {OutTextXY( X, Y, S );}
  ReadIntG := S;
  n := 0;
End; { Function ReadIntG }

Function ReadIntX( X, Y, Tam: Byte; Car: Char ): String;
Var SAux : String;

Begin
  SAux := ReadInt( X, Y, Tam, Car );
  While Length( SAux ) < Tam Do SAux := '0' + SAux;
  GoToXY( X, Y ); WriteLn( SAux );
  ReadIntX := SAux;
End; { Function ReadIntX }

Function Real_Em_Str( rIn: Real ): String;
   Var TamReal, Ponto: Byte;
       ParteI, ParteD: LongInt;
       SAux: String;
   Begin
     ParteI := Trunc( Int( rIn ));
     ParteD := Round( Frac( rIn ) * 100 );
     sAux := '';
     sAux := Long_Em_Str( ParteI, TamReal );
     sAux := sAux + '.' + Long_Em_Str( ParteD, TamReal );
     TamReal := Length( sAux );
     If TamReal < 5 Then
       Repeat
         sAux := ' ' + sAux;
       Until Length( sAux ) = 5;
     Real_Em_Str := sAux;
   End; { Function Real_Em_Str }

Function Int_Em_Tam( n: Byte; Valor: Word ): String;
Var SAux: String;
Begin
  Str( Valor, SAux );
  While Length( SAux ) < n Do SAux := '0' + SAux;
  Int_Em_Tam := SAux;
End;{ Function Int_Em_Tam }

Function Str_Em_Tam( n: Byte; StrIn: String ): String;
Begin
  While Length( StrIn ) < n Do StrIn := ' ' + StrIn;
  Str_Em_Tam := StrIn;
End;{ Function Str_Em_Tam }


Function Num_Em_Str( Valor: Integer ): String;
Var SAux: String;
Begin
  Str( Valor, SAux );
  Num_Em_Str := SAux;
End;{ Function Num_Em_Str }

Function Long_Em_Str( Valor: LongInt; Var L: Byte ): String;
Var SAux: String;
Begin
  Str( Valor, SAux );
  Long_Em_Str := SAux;
  L := Length ( sAux );
End;{ Function Long_Em_Str }


Function Str_Em_Num( StrIn: String ): Word;
Var
  Aux   : Integer;
  Code : Integer;
Begin
  Val( StrIn, Aux, Code );
  If Code = 0 Then Str_Em_Num := Aux
  Else Str_Em_Num := 0
End; { Function Str_Em_Num }

Function Str_Em_Long( StrIn: String ): LongInt;
Var
  Aux   : LongInt;
  Code : Integer;
Begin
  Val( StrIn, Aux, Code );
  If Code = 0 Then Str_Em_Long := Aux
  Else Str_Em_Long := 0
End; { Function Str_Em_Num }

Function Existe_Ficheiro( NomeF: String ) : Boolean;
Var f: File;
Begin
  {$I-}
  Assign( f, NomeF );
  Reset( f );
  Close ( f );
  {$I+}
  Existe_Ficheiro := ( IoResult = 0 ) And ( NomeF <> '' );
End; { Function Existe_Ficheiro }

Procedure RepeteEm( X, Y: Byte; StrIn: Char; Vezes: Byte );
Var Loop: Byte;
Begin
  For Loop := 1 To Vezes Do
  Begin
    GoToXY( X + Loop - 1, Y );
    Write( StrIn );
  End;
End; { Procedure RepeteEm }

Function Divide_em_Milhares( Valor: String; Virgula: Char ): String;
Var L : Byte;
    S1: String;
Begin
  S1 := '';
  L := Length( Valor );
  If L <= 3 Then
    Divide_em_Milhares := Valor
  Else
    Begin
      Repeat
        S1 := Virgula + Copy( Valor, L - 2, 3 ) + S1;
        Delete( Valor, L - 2, 3 );
        L := Length( Valor );
      Until L <= 3;
      Divide_Em_Milhares := Valor + S1;
    End;
End; { Function Divide_em_Milhares }

Function Le_Teclado: String;
Var Ch : Char;
    sAux : String;
  Begin
    Ch:=ReadKey;
    case Ch of
      #0: { Function keys }
      begin
        Ch:=ReadKey;
        case Ch of
          #59: sAux := 'F1';
          #60: sAux := 'F2';
          #61: sAux := 'F3';
          #62: sAux := 'F4';
          #63: sAux := 'F5';
          #64: sAux := 'F6';
          #65: sAux := 'F7';
          #66: sAux := 'F8';
          #67: sAux := 'F9';
          #68: sAux := 'F10';
          #71: sAux := 'HOME';
          #79: sAux := 'END';
          #72: sAux := 'UP';  { Up   }
          #75: sAux := 'LFT'; { Left }
          #77: sAux := 'RGT'; { Right }
          #80: sAux := 'DWN'; { Down }
          #73: sAux := 'PGUP'; { PgUp }
          #81: sAux := 'PGDN'; { PgDn }
          #82: sAux := 'INS'; { Ins }
          #83: sAux := 'DEL'; { Del }
        end;
      end;
      #8: sAux := 'BS';  { Back Space }
      #9: sAux := 'TAB';  { Tab }
      #13: sAux := 'CR';  { Enter }
      #27: sAux := 'ESC'; { Esc }
    else
      sAux := Ch;
    end;
    Le_Teclado := sAux;
end; { Function Le_Teclado }

Procedure Data(Var Ds: String; Var Dia,Mes,Ano:Word);
  Var nds: Word;
  Begin
    GetDate(Ano,Mes,Dia,nds);
    Case nds Of
          0   : Ds:= 'Dom';
          1   : Ds:= 'Seg';
          2   : Ds:= 'Ter';
          3   : Ds:= 'Qua';
          4   : Ds:= 'Qui';
          5   : Ds:= 'Sex';
          6   : Ds:= 'Sab';
    End;
  End; {Procedure Data}

Begin
  Sp1 := Nil;
End.