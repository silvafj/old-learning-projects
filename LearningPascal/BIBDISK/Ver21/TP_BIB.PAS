{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{|  PROGRAMA            => TP_BIB                                          |}
{*  PROGRAMADO EM       => Turbo Pascal 6.0                                *}
{|  AUTOR               => Fernando Jorge de Almeida da Silva              |}
{*  ENDERE€O            => Juncal - Assequins 3750 †gueda                  *}
{|  TELEFONE            => (034) 602800                                    |}
{*  DATA DA PROGRAMA€ŽO => Dezembro/95                                     *}
{|  FUN€ŽO DO PROGRAMA  => Unit para o Bibdisk V2.0                        |}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
UNIT TP_BIB;

INTERFACE

USES
    crt,dos;

{===================================> Tipos <================================}

TYPE
    TMEM_VID=RECORD
                   CAR:CHAR;
                   ATT:BYTE;
             END;

{============================> Vari veis do programa <=======================}

VAR
   I,J,AH,AL:LONGINT;
   CH:CHAR;
   S,R:STRING;
   LOG:BOOLEAN;
   REGS:REGISTERS;
   SCREEN:ARRAY[1..80,1..25] OF TMEM_VID ABSOLUTE $B800:0000;

{==========================> Nomes dos procedimentos <=======================}

PROCEDURE LN(X:BYTE);
PROCEDURE NORM;
PROCEDURE OFF;
PROCEDURE FILLSCR(X1,Y1,X2,Y2,FUNDO:BYTE);
PROCEDURE DARKER(X1,Y1,X2,Y2,TEXTO,FUNDO:BYTE);
PROCEDURE WRITEXY(FRASE:STRING;X,Y:BYTE);
PROCEDURE PRINTXY(FRASE:STRING;VEL,X,Y:BYTE;SND:BOOLEAN);
PROCEDURE PRINTDN(FRASE:STRING;VEL,X,Y:BYTE;SND:BOOLEAN);
PROCEDURE EXECUTE(COMMAND:STRING);
PROCEDURE SND(FREQ,DEL:WORD);
PROCEDURE NO(DEL:WORD);
PROCEDURE HORIZONTAL(X,Y,COMP:BYTE;S1:STRING);
PROCEDURE VERTICAL(X,Y,COMP,INT:BYTE;S1:STRING);
PROCEDURE Inicia(PROGRAMA:STRING;ANO:STRING);
PROCEDURE delaypress(tempo:integer);
PROCEDURE centra(linha:byte;frase:string);

{============================> Procedimentos <===============================}

IMPLEMENTATION

{==============================> Posiciona-se <==============================}

PROCEDURE LN(X:BYTE);
BEGIN
     GOTOXY(X,WHEREY+1);
END;

{===============================> Visualiza cursor <=========================}

PROCEDURE NORM;

   BEGIN
        REGS.AH:=$01;
        REGS.CH:=$06;
        REGS.CL:=$07;
        INTR($10,REGS);
   END;

{===============================> Apaga cursor <=============================}

PROCEDURE OFF;

   BEGIN
        REGS.AH:=$01;
        REGS.CH:=$70;
        REGS.CL:=$00;
        INTR($10,REGS);
   END;

{=================> Preenche o ecran com uma c“r determinada <===============}

PROCEDURE FILLSCR(X1,Y1,X2,Y2,FUNDO:BYTE);
{$S-}
BEGIN
     TEXTBACKGROUND(FUNDO);
     WINDOW(X1,Y1,X2,Y2);
     CLRSCR;
END;

{=====================> Desliga o ecran aos quadradinhos <===================}

PROCEDURE DARKER(X1,Y1,X2,Y2,TEXTO,FUNDO:BYTE);
VAR
   X3,Y3:BYTE;
BEGIN
     FOR Y3:=Y1 TO Y2 DO
         FOR X3:=X1 TO X2 DO
             SCREEN[X3,Y3].ATT:=16*FUNDO+TEXTO;
END;

{==================> Escreve uma frase num local especificado <==============}

PROCEDURE WRITEXY(FRASE:STRING;X,Y:BYTE);
{$S-}
BEGIN
     GOTOXY(X,Y);
     WRITE(FRASE);
END;

{=========> Escreve uma frase num local especificado tipo impressora<========}

PROCEDURE PRINTXY(FRASE:STRING;VEL,X,Y:BYTE;SND:BOOLEAN);
VAR
   X1,V:BYTE;
BEGIN
     GOTOXY(X,Y);
     V:=VEL;
     FOR X1:=1 TO LENGTH(FRASE) DO
         BEGIN
              IF KEYPRESSED THEN V:=2;
              WRITE(FRASE[X1]);
              IF SND THEN SOUND(RANDOM(VEL*2*X1));
              DELAY(V);
              IF SND THEN NOSOUND;
         END;
END;

{===============> Semelhante ao anterior s¢ que no eixo dos YY <=============}

PROCEDURE PRINTDN(FRASE:STRING;VEL,X,Y:BYTE;SND:BOOLEAN);
VAR
   Y1,V:BYTE;
BEGIN
     V:=VEL;
     GOTOXY(X,Y);
     FOR Y1:=1 TO LENGTH(FRASE) DO
         BEGIN
              IF KEYPRESSED THEN V:=2;
              WRITE(FRASE[Y1]);
              LN(X);
              IF SND THEN SOUND(RANDOM(VEL*2*Y1));
              DELAY(V);
              IF SND THEN NOSOUND;
         END;
END;

{=======================> Executa algo determinado <=========================}

PROCEDURE EXECUTE(COMMAND:STRING);
BEGIN
     IF COMMAND<>'' THEN COMMAND:='/C '+COMMAND;
     SWAPVECTORS;
     EXEC(GETENV('COMSPEC'),COMMAND);
     SWAPVECTORS;
     IF DOSERROR<>0 THEN WRITELN('N„o foi poss¡vel executar o COMMAND.COM');
     DELAY(2000);
END;

{=================> A procedure SOUND do PASCAL "encurtada" <================}

PROCEDURE SND(FREQ,DEL:WORD);
BEGIN
     SOUND(FREQ);
     DELAY(DEL);
END;

{================> A procedure NOSOUND do PASCAL "encurtada" <===============}

PROCEDURE NO(DEL:WORD);
BEGIN
     NOSOUND;
     DELAY(DEL);
END;

{==> Escreve um caracter ASCII numa posi‡„o com um determinado comprimento <=}

PROCEDURE HORIZONTAL(X,Y,COMP:BYTE;S1:STRING);
VAR
   CONT:BYTE;
BEGIN
     GOTOXY(X,Y);
     FOR CONT:=X TO X+COMP DO
         WRITE(S1);
END;

{=======================> Igual ao anterior na vertical <====================}

PROCEDURE VERTICAL(X,Y,COMP,INT:BYTE;S1:STRING);
VAR
   CONT:BYTE;
BEGIN
     FOR CONT:=Y TO Y+COMP DO
         BEGIN
              GOTOXY(X,CONT);
              WRITE(S1);
              CONT:=CONT+INT;
         END;
END;

{====================> Inicia os ecrans do programa <========================}

PROCEDURE Inicia(PROGRAMA:STRING;ANO:STRING);
VAR
   a:INTEGER;

BEGIN
       clrscr;
       fillscr(1,1,80,25,1);
       textcolor(15);
       writexy(PROGRAMA,3,2);
       writexy('Fernando Jorge Almeida Silva',3,25);
       writexy('GL corporation',62,25);
       writexy(ANO,65,2);
       textcolor(14);
       horizontal(1,3,79,'Ä');
       horizontal(1,24,79,'Ä');
END;

{=======> Produz uma pausa com uma sa¡da caso seja premida uma tecla <=======}

Procedure delaypress(tempo:integer);
  var cont:integer;
      c:char;
  begin
    for cont:=1 to tempo do begin
      delay(1);
      if keypressed then exit;
    end;
  end;

{=======================> Centra uma frase numa linha <======================}

PROCEDURE centra(linha:byte;frase:string);
begin
gotoxy((80-length(frase))div 2,linha);
write(frase);
end;



BEGIN

END.