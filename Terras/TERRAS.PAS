
PROGRAM Terras;
uses crt, pjsp;
var n:integer;
    r: Real;
    s:String;
Function Formula(nFormula:Byte;Rt,Ro,L,r,h,p: Real): Real;
Var Aux: Real;
Begin
  Case nFormula Of
       1         : Aux:= (2*Pi*Rt*L)/(Ro*Ln(1.5*L/r));
       2         : Aux:= (8*r*Rt)/(Ro*(1+r/(2.5*h+r)));
       3         : Aux:= (1.25*Rt*P)/(Ro*(1+P/(16*h+P)));
       4         : Aux:= (2*Pi*Rt*L)/(Ro*Ln((9*Sqr(L))/(24*r*h)));
       5         : Aux:= (2*Pi*Rt*L)/(Ro*Ln((4*L)/h));
       6         : Aux:= (4*Sqr(Pi)*Rt*r)/(Ro*(Ln(16*r/(2*P))+Ln(4*r/h)));
       7         : Aux:= (4*Pi*Rt*L)/(Ro*(Ln(4*L/(2*r))+Ln(L/h)-0.25*Ln(10)));
       8         : Aux:= (4*Pi*Rt*L)/(Ro*(Ln(4*L/(2*r))+Ln(L/h)+Ln(10)*(0.19*h/L-0.103)));
       9         : Aux:= (6*Pi*Rt*L)/(Ro*(Ln(4*L/(2*r))+Ln(L/h)+Ln(10)*(0.405-0.19*h/L)));
      10         : Aux:= (8*Pi*Rt*L)/(Ro*(Ln(4*L/(2*r))+Ln(L/h)+Ln(10)*(1.265-0.93*h/L)));
      11         : Aux:= (12*Pi*Rt*L)/(Ro*(Ln(4*L/(2*r))+Ln(L/h)+Ln(10)*(2.98-1.36*h/L)));
  End;
  Formula:= Aux;
End;

Function Encontra(nFormula, nCasas:Byte;Rti,Roi,Li,ri,hi,pi: Real): Real;
Var Abaixo, Acima, RAbaixo, RAcima: Real;
    Loop: Byte;

   Procedure Calcula_Limites(Var LimInf,LimSup: Real; n: Byte);
   Var Aux, Valor, Acum, OInf, OSup, Inf, Sup, Rt, Ro, L, r,h,p: Real;
   Begin
     OInf:=0; OSup:=100;
     Inf:= LimInf; Sup:=LimSup;
     Acum:= 1/Exp(n*Ln(10));
     If Loop>1 Then Valor:= LimInf-Acum Else Valor:= 0;
     If Valor<0 Then Valor:= 1*Acum;
     Repeat
       Valor:= Valor+Acum;
       If Rti= 0 Then Begin Rt:=Valor;Ro:=Roi;L:=Li;r:=ri;h:=hi;p:=pi; End
         Else If Roi= 0 Then Begin Rt:=Rti;Ro:=Valor;L:=Li;r:=ri;h:=hi;p:=pi; End
          Else If Li= 0 Then Begin Rt:=Rti;Ro:=Roi;L:=Valor;r:=ri;h:=hi;p:=pi; End
           Else If ri= 0 Then Begin Rt:=Rti;Ro:=Roi;L:=Li;r:=Valor;h:=hi;p:=pi; End
             Else If hi= 0 Then Begin Rt:=Rti;Ro:=Roi;L:=Li;r:=ri;h:=Valor;p:=pi End
               Else If pi= 0 Then Begin Rt:=Rti;Ro:=Roi;L:=Li;r:=ri;h:=hi;p:=valor End;
       Aux:= Formula(nFormula,Rt,Ro,L,r,h,p);
       If (Aux<1) And (Aux>=OInf) Then
         Begin Inf:= Valor; OInf:= Aux End;
       If (Aux>1) And (Aux<=OSup) Then
         Begin Sup:= Valor; OSup:= Aux; End;
     Until Valor>= LimSup;
     LimInf:= Inf; LimSup:=Sup;
   End;
Begin
  Loop:= 1; Abaixo:= 0; Acima:= 1000;
  If nCasas>=10 Then nCasas:= 10;
  Repeat
    Calcula_Limites(Abaixo, Acima,Loop-1);
    Loop:= Loop+1;
  Until Loop= nCasas+1;
  Encontra:= (Abaixo+Acima)/2;
End;
Function Menu1: Integer;
Var menu: Integer;
Begin
  WriteLn('01 - El‚ctrodo Cilindrico Vertial');
  WriteLn('02 - Placa Fina Enterrada (placa redonda)');
  WriteLn('03 - Placa Fina Enterrada (placa quadrada)');
  WriteLn('04 - El‚ctrodo Recitilineo (redondo)');
  WriteLn('05 - El‚ctrodo Recitilineo (barra)');
  WriteLn('06 - El‚ctrodo em Forma de Anel');
  WriteLn('07 - Estrela com 2 Bra‡os a 180ø');
  WriteLn('08 - Estrela com 2 Bra‡os a 90ø');
  WriteLn('09 - Estrela com 3 Bra‡os a 120ø');
  WriteLn('10 - Estrela com 4 Bra‡os a 90ø');
  WriteLn('11 - Estrela com 6 Bra‡os a 360ø');
  WriteLn('12 - SAIR DO PROGRAMA');
  EscreveEm(50,23,'Tipo El‚ctrodo de Terra:');
  Repeat
    Menu:= Str_em_Num(ReadIntX(75,23,2,'_'));
  Until (Menu>0) And (Menu<=12);
  Menu1:= Menu;
End;

Function Le_Valor(Y: Integer; Texto: String; Var Zero:Byte): Real;
Var Code: Integer; Aux: Real;
Begin
  Texto:= texto+': ';
  Repeat
    GoToXY(1,Y); TextColor(Green); Write(Texto); TextColor(White);
    Val(ReadNum(1+Length(Texto)+2,Y, 10,' '),Aux,Code);
  Until Aux >= 0;
  If Aux= 0 Then
  Begin
    Zero:= Succ(Zero); TextColor(White+128);
    GotoXY(1+Length(Texto)+2,Y); WriteLn('Determinar este valor');
  End;
  Le_Valor:= Aux;
End;
Procedure Executa;
Const
    RtT= 'Resitˆncia de Terra (Ohm)';
    RoT= 'Resistividade (Ohm*metro)';
    LT = 'Comprimento do el‚ctrodo (metro)';
    dT = 'Raio do El‚ctrodo (metro)';
    hT = 'Profundidade de enterramento do el‚ctrodo (metro)';
    PT = 'Per¡metro do el‚ctrodo (metro)';

Var Rt, Ro, L, r, h, p: Real;
    Menu, nZeros: Byte;
Begin

  Repeat
    ClrScr; Menu:= Menu1; ClrScr; nZeros:= 0;
    Case Menu Of
        1    : Repeat
                  nZeros:= 0;
                  Rt:= Le_Valor(1,RtT,nZeros);
                  Ro:= Le_Valor(2,RoT,nZeros);
                  L := Le_Valor(3,LT,nZeros);
                  r := Le_Valor(4,dT,nZeros);
                  h:= 1; P:= 1;
                Until nZeros=1;
         2    : Repeat
                  nZeros:= 0;
                  Rt:= Le_Valor(1,RtT,nZeros);
                  Ro:= Le_Valor(2,RoT,nZeros);
                  r := Le_Valor(3,dT,nZeros);
                  h := Le_Valor(4,hT,nZeros);
                  L := 1; P:= 1;
                Until nZeros=1;
         3    : Repeat
                  nZeros:= 0;
                  Rt:= Le_Valor(1,RtT,nZeros);
                  Ro:= Le_Valor(2,RoT,nZeros);
                  P := Le_Valor(3,pT,nZeros);
                  h := Le_Valor(4,hT,nZeros);
                  r:= 1; L := 1;
                Until nZeros=1;
         3    : Repeat
                  nZeros:= 0;
                  Rt:= Le_Valor(1,RtT,nZeros);
                  Ro:= Le_Valor(2,RoT,nZeros);
                  P := Le_Valor(3,pT,nZeros);
                  h := Le_Valor(4,hT,nZeros);
                  r:= 1; L := 1;
                Until nZeros=1;
         4    : Repeat
                  nZeros:= 0;
                  Rt:= Le_Valor(1,RtT,nZeros);
                  Ro:= Le_Valor(2,RoT,nZeros);
                  L := Le_Valor(3,lT,nZeros);
                  r := Le_Valor(4,dT,nZeros);
                  h := Le_Valor(5,hT,nZeros);
                  P:= 1;
                Until nZeros=1;
         5    : Repeat
                  nZeros:= 0;
                  Rt:= Le_Valor(1,RtT,nZeros);
                  Ro:= Le_Valor(2,RoT,nZeros);
                  L := Le_Valor(3,lT,nZeros);
                  h := Le_Valor(4,'Maior largura da barra (metro)',nZeros);
                  r := 1; P:= 1;
                Until nZeros=1;
         6    : Repeat
                  nZeros:= 0;
                  Rt:= Le_Valor(1,RtT,nZeros);
                  Ro:= Le_Valor(2,RoT,nZeros);
                  r:=  Le_Valor(3,dT,nZeros);
                  P:=  Le_Valor(4,'Raio do condutor enterrado (metro)',nZeros);
                  h := Le_Valor(5,hT,nZeros);
                  L := 1;
                Until nZeros=1;
  7,8,9,10,11 : Repeat
                  nZeros:= 0;
                  Rt:= Le_Valor(1,RtT,nZeros);
                  Ro:= Le_Valor(2,RoT,nZeros);
                  L:=  Le_Valor(3,'Comprimento de cada bra‡o (metro)',nZeros);
                  h := Le_Valor(4,hT,nZeros);
                  r:=  Le_Valor(5,'Raio do condutor enterrado (metro)',nZeros);
                  P:= 1;
                Until nZeros=1;
    End;
    TextColor(
    white);
    If Menu<> 12 Then
    Begin
      GotoXY(1,20); Write('Valor Calculado: ');
      WriteLn(Encontra(Menu,5,Rt,Ro,L,r,h,p));
      Repeat until Keypressed;
    End;
  Until Menu= 12;

End;

Begin
  Clrscr;
  Executa;
End.