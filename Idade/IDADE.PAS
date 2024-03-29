Program IDADE; { A nossa idade... }

Uses
  Crt;

Const
  NumDias : Array [1..12] OF Integer = (31, 28, 31, 30, 31, 30, 31,
                                        31, 30, 31, 30, 31);
{ Este array contem os dias correspondentes aos meses. Em rela��o ao
  m�s 2 'Fevereiro' o numero de dias vai ser calculado mais � frente
  atrav�s do calculo do ano bisexto }
  DiaDaSemana : Array [0..6] OF String = ('Domingo',
                                          'Segunda-feira',
                                          'Ter�a-feira',
                                          'Quarta-feira',
                                          'Quinta-feira',
                                          'Sexta-feira',
                                          'S�bado');
{ Este array contem os dias da semana indexados de modo a poder converter
  o dia da semana (numero) mais facilmente em extenso }
  NomeDoMes : Array [1..12] OF String = ('Janeiro',
                                         'Fevereiro',
                                         'Mar�o',
                                         'Abril',
                                         'Maio',
                                         'Junho',
                                         'Julho',
                                         'Agosto',
                                         'Setembro',
                                         'Outubro',
                                         'Novembro',
                                         'Dezembro');
{ Este array � exactamente o mesmo que o anterior, s� que neste caso � para
  os meses }

Var
  Dia, Mes, Ano, AnoFuturo : Integer;
  DiaSemana : String;
  TempStr : String; { String temporaria quando se l� do teclado }
  Error : Integer; { Variavel usada para verificar se a opera��o
                     de conver��o foi bem sucedida ou n�o }

Function DayOfWeek(y, m, d : Integer) : Integer;
{ Esta fun��o vai utilizar os valores 'y', 'm' e 'd' para dar o valor da
semana, sendo o 0 = Domingo. O algoritmo utilizado... }
{ 'y' tem de ser superior a 1752, pois foi a partir deste ano que foi
implementado o calend�rio Gregoriano, pelo qual trabalhamos actualmente. }

Const
t : Array [1..12] OF Integer = (0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4);

Begin
  If m < 3 Then dec(y);
  DayOfWeek := (y + (y DIV 4) - (y DIV 100) + (y DIV 400) + t[m] + d) MOD 7;
End; { DayOfWeek }

Function IsLeapYear(Year : Integer) : Boolean;
{ Esta fun��o vai verificar se o ano 'Year' � bisexto ou n�o. Para fazer este
c�lculo usa-se a f�rmula universal de c�lculo de anos bisextos, ou seja, um
ano � bisexto se cumprir o seguinte : Ao dividir o ano por 4 d� resto 0 (por
exemplo 1996) E se ao dividir o ano por 100 o resto seja diferente de 0 OU
ao dividi-lo por 400 d� resto 0 (por exemplo 2000) }
{ O algoritmo � bem bem explicito... }

Begin
  If ((Ano MOD 4) = 0) AND (((Ano MOD 100) <> 0) OR ((Ano MOD 400) = 0)) Then
    IsLeapYear := TRUE
  Else IsLeapYear := FALSE;
End; { IsLeapYear }

Function ReadValue(Limite : integer) : integer;
{ Esta fun��o � utilizada para ler do teclado somente numeros. �
impossibilitada a introdu��o de letras ou quaisquers outros caracteres.
  Existe ainda a op��o de limitar o numero de algarismos a introduzir. Esse
valor � o 'Limite'.
  Esta fun��o tem o objectivo de substituir a fun��o standard 'ReadLn', devido
a esta ser incompleta para controlar teclas.
  Com a 'ReadValue' temos a capacidade de controlar toda a opera��o de teclas
principalmente o facto de querermos sair do programa a qualquer altura. }

Const
  Key_Enter = 13; { Valor inteiro correspondente ao enter }
  Key_Esc = 27; { ... para o Esc }
  Key_BackSpace = 8; { ... BackSpace }
  Key_0 = 48; { ... '0' }
  Key_9 = 57; { ... '9' }

Var
  TempStr : String; { String usada para opera��es tempor�rias }
  TempInt : integer; { Integer usado para o mesmo que t� em cima }
  Ch : Char; { Valor utilizado para ler a tecla que foi pressionada }
  Key : Integer; { O mesmo de cima mas neste caso contem o valor num�rico da tecla }
  i : integer; { Valor tempor�rio de controle, para controlar o numero de
                algarismos a ler do teclado }
  X, Y : byte; { Onde est� o Wally? hmmmm... onde est� o cursor? }
  error : integer; { Valor utilizado para controle de convers�es }
  Finish : Boolean; { Valor para saber se podemos sair ou n�o }

Begin
  i := 1; { inicializa a vari�vel. Vai ser introduzido um algarismo inicial }
  TempStr := ''; { Inicializa a vari�vel }
  X := WhereX; { Onde est� o cursor (posi��o X) }
  Y := WhereY; { Onde est� o cursor (posi��o Y)}
  Finish := FALSE; { A leitura ainda n�o acabou. Nem sequer come�ou.... }
  While Not Finish Do { Enquanto n�o acaba... }
    Begin
      If Keypressed Then { Se uma tecla for pressionada ... }
        Begin
          Ch := ReadKey; { Guarda o valor da tecla na vari�vel ... }
          Key := Ord(Ch); { Converte para valor num�rico... }
          If (Key >= Key_0) AND (Key <= Key_9) AND (i <= limite) then
            { Se a tecla est� entre '0' e '9' ent�o � um algarismo, e se
             ainda n�o atingimos o limite... }
            Begin
              TempStr := TempStr + Ch; { Guarda a tecla na string tempor�ria }
              Write(Ch); { E escreve o char no ecr� ... }
              Inc(i); { Ahhh... como j� introduzimos um algarismo, temos de
              { incrementar o valor do algarismo actual a introduzir... }
            End; { If Key .... }
          If Key = Key_Esc Then Halt(0); { Foi pressionada a tecla ESC ? Sim...
          { Ent�o vai embora pr� ..... quer dizer xauzinho... volta sempre }
          If (Key = Key_BackSpace) AND (X < WhereX) Then
          { Enganou-se na introdu��o do algarismo ? Ent�o vamos apagar...
            Mas s� at� ao sitio onde come�ou a introduzir }
            Begin
              { Apaga o char do ecr�... }
              GotoXY(WhereX-1,Y); { Volta um espa�o para tr�s ... }
              Write(' '); { Apaga o char... avan�o auutom�tico... }
              GotoXY(WhereX-1,Y); { Retorna para tr�s ... }
              Dec(i); { Actualiza o valor actual do algarismo a introduzir }
              { Apaga o char da 'TempStr' ... }
              Delete(TempStr,Length(TempStr),1); { Vamos ent�o apagar da
              string 'TempStr' a ultima posi��o (correspondendo ao tamanho
              actual da string 'Length'), e vamos apagar somente 1 char }
            End; { If BackSpace }
          If Key = Key_Enter Then Finish := TRUE; { ENTER... ok... finish }
        End; { If Keypressed... }
    End; { While }
  Val(TempStr,TempInt,error); { Converter a string para integer... s� para o
  compilador n�o nos chatear com erros }
  ReadValue := TempInt; { A fun��o vai retornar o valor do 'TempInt'. O valor
  obtido da convers�o do 'TempStr'. }
  WriteLn; { Avan�amos uma linha... para ser esteticamente como o 'ReadLn' }
End; { ReadValue }

BEGIN { E aqui come�a a hist�ria deste programa... � muito tempo numa terra
longiqua a princesa.... hmmmm.... avan�ando que isto n�o � daqui... }
  ClrScr; { Limpa o ecr�. As coisas devem come�ar limpinhas }
  Dia := 0; { Inicializa vari�veis... }
  Mes := 0;
  Ano := 0;
  AnoFuturo := 0;
  { Come�a a chatear o utilizador a pedir-lhe informa��es }
  WriteLn('Este programa informa qual o dia de anivers�rio de uma pessoa num ano futuro.');
  WriteLn('Para sair do programa prima a tecla ESC.');
  WriteLn('(No canto superior esquerdo, para quem n�o sabe. Sim essa a� em cima...) ');
  WriteLn;
  While (Ano < 1752) DO
  { O ano em que se adoptou o calend�rio Gregoriano }
    Begin
      Write('Introduza o ano de nascimento : ');
      { Auto-explicativo }
      Ano := ReadValue(4); { Vamos ler no m�ximo 4 algarismos pr� 'ano'.
      Suponho que n�o querem testar alguem que nas�a no ano 10000... quem sabe }
      If (Ano < 1752) Then WriteLn('O ano ',Ano,' � inv�lido.');
    End; { While ano .... }
  If IsLeapYear(Ano) Then NumDias[2] := 29; { Se � um ano bisexto ent�o
  o m�s de Fevereiro no nosso array (matriz para quem n�o sabe) ter� 29 dias }
  While (Mes > 12) OR (Mes < 1) DO
  { Alguem quer criar mais meses para cada ano ? }
    Begin
      Write('Introduza o m�s de nascimento (1 a 12) : ');
      Mes := ReadValue(2); { Cada m�s � constituido no m�ximo por 2 algarismos }
      If (Mes > 12) OR (Mes < 1) Then WriteLn('O m�s ',Mes,' � inv�lido.');
    End; { While mes... }
  While (Dia < 1) OR (Dia > NumDias[Mes]) DO
  { Dias de cada m�s ... }
    Begin
      Write('Introduza o dia de nascimento (1 a ',NumDias[Mes],') : ');
      Dia := ReadValue(2);
      If (Dia < 1) OR (dia > NumDias[mes]) Then WriteLn('O dia ',Dia,' � inv�lido.');
    End; { While dia ... }
  While (Ano >= AnoFuturo) DO
  { O 'AnoFuturo' � maior que o 'Ano' inicial }
    Begin
      Write('Introduza o ano futuro (a partir de ',Ano,') : ');
      AnoFuturo := ReadValue(4);
      If (Ano >= AnoFuturo) Then WriteLn('O ano futuro ',AnoFuturo,' � inv�lido.');
    End; { While anofuturo... }
  ClrScr;
  WriteLn('Voc� nasceu : ', DiaDaSemana[DayOfWeek(Ano,Mes,Dia)],
                            ', ', Dia, ' de ', NomeDoMes[Mes],' de ', Ano);
  WriteLn('Voc� ter� ', AnoFuturo - Ano, ' anos no dia : ',
                        DiaDaSemana[DayOfWeek(AnoFuturo,Mes,Dia)], ', ',
                        Dia, ' de ', NomeDoMes[Mes], ' de ', AnoFuturo);
  WriteLn;
  WriteLn;
  WriteLn;
  WriteLn('Idade v1.0 Copyright 1998');
  WriteLn('Gama� (aka Leandro Ribeiro Gama) Turma 2  --  N� 303/98');
  WriteLn('xxx                              Turma 2  --  N� xxx/98');
  WriteLn;
  WriteLn('Agradecimentos : ');
  WriteLn('Quero agradecer aos meus f�s por me apoiarem entusiasticamente.');
  WriteLn('Obrigado � claque feminina que me apoiou naquelas horas de madrugada');
  WriteLn('quando eu estava a progredir neste programa "magnifico".');
  WriteLn('Obrigado, �s raparigas do Alternativa por me darem energia suficiente');
  WriteLn('para mais programas (mas estes programas n�o s�o os de programa��o).');
  WriteLn;
  WriteLn('E FINALMENTE (desculpem tar a gritar) tenho de agradecer �s ajudas');
  WriteLn('divinas que ainda existem por a�... obrigado a todos os ^Magico^''s');
  WriteLn('deste pa�s!!!');
  Halt(0); { Vamos sair em grande com a certeza de que tudo correu bem. Caso
  o valor retornado pelo programa seja diferente de 0, ent�o podemos ter a
  certeza de que o programa teve problemas e devemos corrigir os BUGS. Para
  quem n�o sabe o BUG � um insecto, e este nome deve-se ao facto de quando
  se come�aram a criar os computadores, os cientistas tiveram uns pequenos
  problemas, e verificaram que o problema era um pequeno insecto no meio das
  v�lvulas. Por isso se come�ou a dizer que sempre que h� problemas com o
  software ou o hardware, s�o BUGS que existem.
  BUG tb � o nome dum jogo... querem mais explica��es hist�ricas ? }
END. { Buh bye... "Don't imitate... Inovate", quer dizer, n�o copiem... criem }

