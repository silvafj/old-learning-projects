PROGRAM VirtualRunners;
USES
   Crt,Dos;

VAR
   ch:BYTE;
   HoraInicial:WORD;
   Nivel:BYTE;
   MinJogo,SegJogo:WORD;
   PosX,PosY:BYTE;
   Fim:boolean;
   Minas:INTEGER;
   Morte:BOOLEAN;
   s1:STRING;
   keyb:BOOLEAN;
   a:INTEGER;

   PROCEDURE Menu;FORWARD;
   PROCEDURE TempoDecrescente;FORWARD;
   PROCEDURE IniciaJogo;FORWARD;
   PROCEDURE KorJ;FORWARD;

{********}
PROCEDURE WriteXY(X,Y:INTEGER;Text:STRING);
BEGIN
GotoXY(X,Y);
Write(Text);
END;

{*****}
  FUNCTION ReadNewKey(Tipo:BYTE):BYTE;
   { Indicates the char value of the Key }

    VAR
      Ch1,Ch2: CHAR;
      Continua: BOOLEAN;
    BEGIN
      CASE Tipo OF
      1:BEGIN
          Continua:= FALSE;
          Ch1:=ReadKey;
          IF Ch1 = #0 THEN
          BEGIN
            Continua:=TRUE;
            Ch2:=ReadKey;
          END;
          ReadNewKey:=ORD(Ch1);
          IF Continua THEN ReadNewKey:=ORD(Ch2);
        END;
      2:BEGIN
          IF Keypressed THEN
          BEGIN
          Continua:= FALSE;
          Ch1:=ReadKey;
          IF Ch1 = #0 THEN
          BEGIN
            Continua:=TRUE;
            Ch2:=ReadKey;
          END;
          ReadNewKey:=ORD(Ch1);
          IF Continua THEN ReadNewKey:=ORD(Ch2);
          END;
        END;
      END;
    END; { ReadNewKey }

{********}
FUNCTION LerDaPpAL:BYTE;
var
   regs:registers;
   a:byte;

BEGIN
asm
	push bx
	push cx
	push dx

	mov dx,0379h
	in al,dx
	mov cl,3
	shr al,cl
	mov bl,al
	mov dx,037ah
	in al,dx

	 mov cl,5
	shl al,cl
	or al,bl
	;pop cx

	 rcl al,1
	 cmc
	 rcr al,1

	push ax
	mov cl,4
	shr al,cl
	not al
	and al,0fh
	shl al,cl
	mov cl,al
	pop ax
	and al,0fh
	or al,cl

        mov a,al

	pop dx
	pop cx
	pop bx

end;
Lerdappal:=a;
END;

{********}
PROCEDURE EnviarParaPpAL(valor:BYTE);
var
   regs:registers;

BEGIN
asm
	push dx
        mov al,valor
	mov dx,378h
	out dx,al
	pop dx
end;
END;

{*******}
FUNCTION VerificaPpPosicao(valor:BYTE):BYTE;
VAR
   a:BYTE;

BEGIN
a:=0;
asm
   MOV al,valor
   Test al,00000001b
   JZ @B
   MOV a,1
   JMP @Fim
@B:
   Test al,00000010b
   JZ @C
   MOV a,2
   JMP @Fim
@C:
   Test al,00000100b
   JZ @D
   MOV a,3
   JMP @Fim
@D:
   Test al,00001000b
   JZ @B
   MOV a,4
@Fim:
END;
VerificaPpPosicao:=a;
END;

{********}
PROCEDURE CursorOff;
VAR
   Regs:Registers;

BEGIN
   Regs.AH:=$01;
   Regs.CH:=$7;
   Regs.CL:=$0;
   Intr($10,Regs);
END;

{********}
PROCEDURE IniciaTempoDecrescente;
VAR
  hora,minuto,segundo,hund : Word;
BEGIN
  GetTime(Hora,Minuto,Segundo,hund);
  HoraInicial:=(Hora*60*60)+(Minuto*60)+Segundo;
END;

{********}
PROCEDURE TempoDecrescente;
VAR
   a,b,c,HoraFinal,h,m,s,hund:WORD;
   MJogo,SJogo,HFin,MFin,SFin:INTEGER;

BEGIN
  GetTime(h,m,s,hund);
  HoraFinal:=(h*60*60)+(m*60)+s;
  a:=HoraFinal-HoraInicial;
  MFin:=a DIV 60;
  SFin:=a MOD 60;
  MJogo:=MinJogo-MFin;
  SJogo:=SegJogo-SFin;
  TextColor(15);
  GotoXY(64,2);
  Write(MJogo,':',SJogo,'   ');
  GotoXY(20,2);
  Write(Nivel);
END;

{********}
PROCEDURE GameStory;
BEGIN
   ClrScr;
   TextMode(co80);
   CursorOff;
   Window(0,0,80,25);
   TextBackground(0);
   TextColor(15);
   Writeln('                    (E) (A) (V) (V) (A) (E)');
   Writeln('            (E)                              (E)');
   Writeln('         (A)                                    (A)');
   Writeln('            (V)                              (V)');
   Writeln('  ');
   Writeln('                                               ');
   Writeln('      Lado Esquerdo       Em Frente       Lado Direito');
   Writeln('  ');
   Writeln('  ');
   Writeln('  ');
   Writeln('  ');
   Writeln('  ');
   Writeln('  ');
   Writeln('  ');
   Writeln('  ');
   Writeln('  ');
   Writeln('  ');
   Writeln('  ');
   Repeat Until Keypressed;
   Menu;
END;

{********}
PROCEDURE Menu;
VAR
   a:INTEGER;

BEGIN
   Morte:=FALSE;
   Nivel:=1;
   MinJogo:=2;
   SegJogo:=59;
   PosX:=78;
   PosY:=13;
   Minas:=100;
   ClrScr;
   TextMode(co40);
   CursorOff;
   Window(0,0,40,25);
   TextBackground(3);
   ClrScr;
   TextColor(10);
   WriteXY(13,7,'Virtual Runners');
   WriteXY(13,8,'---------------');
   TextColor(1);
   WriteXY(15,11,'(P)lay');
   WriteXY(12,13,'(G)ame Story');
   WriteXY(15,15,'(E)xit');
   TextColor(12);
   WriteXY(15,11,'(P)');
   WriteXY(12,13,'(G)');
   WriteXY(15,15,'(E)');
   a:=0;
   repeat
   ch:=ReadNewKey(2);
   IF (ch=ORD('P')) OR (ch=ORD('p')) THEN
   BEGIN
   KorJ;
   IniciaJogo;
   END;
   IF (ch=ORD('G')) OR (ch=ORD('g')) THEN GameStory;
   IF (ch=ORD('E')) OR (ch=ORD('e')) THEN
   BEGIN
   TextMode(Co80);
   ClrScr;
   Halt;
   END;
   until false;
END;

{**********}
PROCEDURE EspalhaMinas(Num:INTEGER);
VAR
   a,b,c:INTEGER;

BEGIN
Randomize;
FOR a:=0 to Num DO
BEGIN
  B:=RANDOM(77)+2;
  C:=RANDOM(21)+4;
  If B=79 THEN B:=78;
  TextColor(15);
  WriteXY(B,C,'*');
END;
END;

{**********}
PROCEDURE PiscaParedeDireita;
BEGIN
for a:=0 to 3 do
begin
enviarparappal($90);
delay(100);
end;
END;

{**********}
PROCEDURE PiscaParedeEsquerda;
BEGIN
for a:=0 to 3 do
begin
enviarparappal($3);
delay(100);
end;
END;

{**********}
PROCEDURE PiscaPerdeu;
BEGIN
for a:=0 to 255 do
begin
enviarparappal(a);
delay(10);
end;
END;

{**********}
FUNCTION VerificaChar(X,Y:BYTE;cha:byte):BOOLEAN;
  var
    regs:registers;

BEGIN
   VerificaChar:=FALSE;
   GotoXY(X,Y);
   regs.ah:=$08;
   regs.bh:=0;
   intr(16,regs);
   IF regs.al=cha then VerificaChar:=True;
END;

{**********}
PROCEDURE DesenhaBoneco(Xa,Ya,X,Y:INTEGER);
BEGIN
IF (Xa<>X) or (Ya<>Y) THEN
BEGIN
IF NOT VerificaChar(X,Y,ORD('*')) THEN
BEGIN
GotoXY(Xa,Ya);
TextColor(0);
Write('');
GotoXY(X,Y);
TextColor(10);
Write('');
END;
END;
END;

{**********}
PROCEDURE PassouNivel;
var
   a:byte;

BEGIN
  Minas:=Minas+40;
  Nivel:=Nivel+1;
  TextColor(3);
  FOR a:=4 TO 24 DO
  BEGIN
    WriteXY(2,a,'Û');
    Enviarparappal($15);
    Delay(100);
    Enviarparappal($0);
    Delay(100);
  END;
  PosX:=78;
  PosY:=13;
  IniciaJogo;
END;

{**********}
PROCEDURE Morreu;
VAR
  c,d,e,f,g:BYTE;
BEGIN
TextColor(12);
WriteXY(PosX,PosY,'þ');
FOR c:=1 TO 10 DO
BEGIN
d:=PosX+c;
e:=PosX-c;
f:=PosY+c;
g:=PosY-c;
IF d>=79 THEN d:=78;
IF e<=1 THEN e:=1;
IF f>=25 THEN f:=24;
IF g<=3 THEN g:=4;
WriteXY(e,PosY,'þ');
WriteXY(e,g,'þ');
WriteXY(PosX,g,'þ');
WriteXY(d,g,'þ');
WriteXY(d,PosY,'þ');
WriteXY(PosX,f,'þ');
WriteXY(d,f,'þ');
WriteXY(e,f,'þ');
Delay(100);
END;
FOR c:=2 TO 78 DO
BEGIN
FOR d:=4 TO 24 DO
BEGIN
WriteXY(c,d,'þ');
Delay(2);
END;
END;
Morte:=TRUE;
END;

{**********}
PROCEDURE AcendeLEDS;

LABEL A,B,C;

BEGIN
{direita}
IF VerificaChar(PosX,PosY-1,ORD('*')) THEN
BEGIN
s1:='1001';
goto a;
END;
IF VerificaChar(PosX,PosY-2,ORD('*')) THEN
BEGIN
s1:='1000';
goto a;
END;
IF VerificaChar(PosX,PosY-3,ORD('*')) THEN
BEGIN
s1:='0001';
goto a;
END;
IF NOT VerificaChar(PosX,PosY-3,ORD('*')) THEN s1:='0001';
a:{frente}
IF VerificaChar(PosX-1,PosY,ORD('*')) THEN
BEGIN
s1:=s1+'11';
goto b;
end;
IF VerificaChar(PosX-2,PosY,ORD('*')) THEN
BEGIN
s1:=s1+'10';
goto b;
END;
IF VerificaChar(PosX-3,PosY,ORD('*')) THEN
BEGIN
s1:=s1+'01';
goto b;
END;
IF NOT VerificaChar(PosX-3,PosY,ORD('*')) THEN s1:=s1+'01';
b:{esquerda}
IF VerificaChar(PosX,PosY+1,ORD('*')) THEN
BEGIN
s1:=s1+'11';
goto c;
END;
IF VerificaChar(PosX,PosY+2,ORD('*')) THEN
BEGIN
s1:=s1+'10';
goto c;
END;
IF VerificaChar(PosX,PosY+3,ORD('*')) THEN
BEGIN
s1:=s1+'01';
goto c;
END;
IF NOT VerificaChar(PosX,PosY+3,ORD('*')) THEN s1:=s1+'01';
c:
END;

{********}
FUNCTION Potencia(valor1,valor2:INTEGER):INTEGER;
VAR
   a,b:INTEGER;
BEGIN
b:=valor1;
FOR a:=1 to valor2-1 DO b:=b*valor1;
Potencia:=b;
IF valor2=0 THEN Potencia:=1;
END;

{********}
FUNCTION BIN2DEC(valor:STRING):INTEGER;
VAR
   a,b,c,sai,erro:INTEGER;

BEGIN
BIN2DEC:=0;
b:=0;
FOR a:=length(valor) downto 1 DO
BEGIN
VAL(valor[length(valor)-a+1],sai,erro);
b:=b+sai*potencia(2,a-1);
END;
Bin2dec:=b;
END;

{**********}
PROCEDURE VerificaPosicao;
VAR
   a,b:INTEGER;
   porta:BYTE;

BEGIN
a:=PosX;
b:=PosY;
IF keyb THEN
BEGIN
ch:=ReadNewkey(2);
CASE ch OF
72: BEGIN  {Tecla cima boneco frente}
       DEC(PosX);
     END;
75: BEGIN  {tecla esquerda boneco esquerda}
       INC(PosY);
     END;
80: BEGIN  {tecla baixo boneco tras}
       INC(PosX);
     END;
77: BEGIN  {tecla direita boneco direita}
       DEC(PosY);
     END;
27: BEGIN
       Menu;
       Halt;
    END;
END;
END;
IF (NOT keyb) THEN
BEGIN
porta:=lerdappal;
CASE porta OF
$F5: BEGIN  { boneco frente }
       DEC(PosX);
     END;
$E7: BEGIN  { boneco esquerda }
       INC(PosY);
     END;
$F6: BEGIN  { boneco tras }
       INC(PosX);
     END;
$F3: BEGIN  { boneco direita }
       DEC(PosY);
     END;
END;
ch:=ReadNewkey(2);
CASE ch OF
27: BEGIN
       Menu;
       Halt;
    END;
END;
delay(250);
END;
IF PosX=1 THEN PosX:=2;
IF PosX=79 THEN PosX:=78;
IF PosY=3 THEN
BEGIN
PosY:=4;
PiscaParedeDireita;
END;
IF PosY=25 THEN
BEGIN
PosY:=24;
PiscaParedeEsquerda;
END;
DesenhaBoneco(a,b,PosX,PosY);
IF PosX=2 THEN PassouNivel;
IF VerificaChar(PosX,PosY,ORD('*')) THEN
BEGIN
PiscaPerdeu;
Morreu;
END;
IF (MinJogo=0) AND (SegJogo=0) THEN
BEGIN
PiscaPerdeu;
Morreu;
END;
AcendeLEDS;
{writexy(10,10,s1);
writexy(10,11,'--------');
gotoxy(10,11);
write(BIN2DEC(s1));
}
enviarparappal(BIN2DEC(s1));
END;

{**********}
PROCEDURE KorJ;
VAR
   vai:BOOLEAN;

BEGIN
   Vai:=FALSE;
   ClrScr;
   TextColor(1);
   WriteXY(8,11,'(K)eyboard or (J)oystick');
   TextColor(12);
   WriteXY(8,11,'(K)');
   WriteXY(22,11,'(J)');
   repeat
   ch:=ReadNewKey(2);
   IF (ch=ORD('K')) OR (ch=ORD('k')) THEN
   BEGIN
   keyb:=TRUE;
   vai:=TRUE;
   END;
   IF (ch=ORD('J')) OR (ch=ORD('j')) THEN
   BEGIN
   keyb:=FALSE;
   vai:=TRUE;
   END;
   until vai;
END;

{**********}
PROCEDURE IniciaJogo;
BEGIN
   ClrScr;
   TextMode(CO80);
   CursorOff;
   Window(0,0,80,25);
   TextBackground(0);
   ClrScr;
   TextColor(14);
   WriteXY(1,2,'            Nกvel                             Tempo restante                  ');
   TextColor(7);
   WriteXY(1,3,'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
   WriteXY(1,4,'บ                                                                             บ');
   WriteXY(1,5,'บ                                                                             บ');
   WriteXY(1,6,'บ                                                                             บ');
   WriteXY(1,7,'บ                                                                             บ');
   WriteXY(1,8,'บ                                                                             บ');
   WriteXY(1,9,'บ                                                                             บ');
   WriteXY(1,10,'บ                                                                             บ');
   WriteXY(1,11,'บ                                                                             บ');
   WriteXY(1,12,'บ                                                                             บ');
   WriteXY(1,13,'บ                                                                             บ');
   WriteXY(1,14,'บ                                                                             บ');
   WriteXY(1,15,'บ                                                                             บ');
   WriteXY(1,16,'บ                                                                             บ');
   WriteXY(1,17,'บ                                                                             บ');
   WriteXY(1,18,'บ                                                                             บ');
   WriteXY(1,19,'บ                                                                             บ');
   WriteXY(1,20,'บ                                                                             บ');
   WriteXY(1,21,'บ                                                                             บ');
   WriteXY(1,22,'บ                                                                             บ');
   WriteXY(1,23,'บ                                                                             บ');
   WriteXY(1,24,'บ                                                                             บ');
   WriteXY(1,25,'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
   EspalhaMinas(Minas);
   TextColor(10);
   WriteXY(78,13,'');
   DesenhaBoneco(0,0,PosX,PosY);
   IniciaTempoDecrescente;
   repeat
   IF Morte THEN Menu;
   tempodecrescente;
   VerificaPosicao;
   until fim;
END;

BEGIN
Keyb:=FALSE;
Morte:=FALSE;
Nivel:=1;
MinJogo:=2;
SegJogo:=59;
PosX:=78;
PosY:=13;
Minas:=100;
Menu;
END.
