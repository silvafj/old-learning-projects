PROGRAM calculos;
USES
   CRT,DOS,TP;

 VAR
    U,I,P,f,S,FI,SFI,Q,Z,R,XL,L:REAL;


BEGIN
    Inicializa_1('Calculos  V1.0','1995');
    textcolor(15);
    writexy('C A L C U L O S',26,5);
    textcolor(8);
    writexy('Apenas com a introdu‡„o de alguns valores este programa calcula',10,7);
    writexy('outros valores num circuito indutivo',10,8);
    textcolor(14);
    writexy('Introduza o valor da tens„o (em VOLTS) : ',8,12);
    textcolor(15);
    readln(U);
    textcolor(14);
    writexy('Introduza o valor da corrente (em AMP’RES) : ',8,14);
    textcolor(15);
    readln(I);
    textcolor(14);
    writexy('Introduza o valor da potˆncia activa (em WATTS) : ',8,16);
    textcolor(15);
    readln(P);
    textcolor(14);
    writexy('Introduza o valor da frequˆncia (em HERTZ) : ',8,18);
    textcolor(15);
    readln(f);
    Inicializa_2('Calculos  V1.0','1995');
    {Calcula potˆncia aparente (S)}
    S := U * I;
    {Calcula o factor de potˆncia (cos fi)}
    FI := P / S;
    {Calcula a impedƒncia (Z)}
    Z := U / I;
    {Calcula a resistˆncia (R)}
    R := Z * FI;
    {Calcula a reactƒncia indutiva (XL)}
    XL := SQRT(SQR(Z) - SQR(R));
    {Calcula o seno}
    SFI := XL / Z;
    {Calcula a potˆncia reactiva (Q)}
    Q := U * I * SFI;
    {Calcula o coeficiente de auto-indu‡„o (L)}
    L := XL / (2 * PI * f);
    gotoxy(10,6);
    write('Tens„o (U) :',U:6:2,'V');
    gotoxy(10,7);
    write('Corrente (I) :',I:6:2,'A');
    gotoxy(10,8);
    write('Potˆncia activa (P) :',P:6:2,'W');
    gotoxy(10,9);
    write('Frequˆncia (f) :',f:6:2,'Hz');
    gotoxy(10,10);
    write('Potˆncia aparente (S) :',S:6:2,'VA');
    gotoxy(10,11);
    write('Factor de potˆncia (cos ë) :',FI:6:2);
    gotoxy(10,12);
    write('Potˆncia reactiva (Q) :',Q:6:2,'VAr');
    gotoxy(10,13);
    write('Impedƒncia (Z) :',Z:6:2,'ê');
    gotoxy(10,14);
    write('Resistˆncia (R) :',R:6:2,'ê');
    gotoxy(10,15);
    write('Reactƒncia indutiva (XL) :',XL:6:2,'ê');
    gotoxy(10,16);
    write('Coeficiente de auto-indu‡„o (L) :',L:6:2,'H');

readln;

END.