Program IDADE; { A nossa idade... }

Uses
  Crt;

Const
  NumDias : Array [1..12] OF Integer = (31, 28, 31, 30, 31, 30, 31,
                                        31, 30, 31, 30, 31);
{ Este array contem os dias correspondentes aos meses. Em relaá∆o ao
  màs 2 'Fevereiro' o numero de dias vai ser calculado mais † frente
  atravÇs do calculo do ano bisexto }
  DiaDaSemana : Array [0..6] OF String = ('Domingo',
                                          'Segunda-feira',
                                          'Teráa-feira',
                                          'Quarta-feira',
                                          'Quinta-feira',
                                          'Sexta-feira',
                                          'S†bado');
{ Este array contem os dias da semana indexados de modo a poder converter
  o dia da semana (numero) mais facilmente em extenso }
  NomeDoMes : Array [1..12] OF String = ('Janeiro',
                                         'Fevereiro',
                                         'Maráo',
                                         'Abril',
                                         'Maio',
                                         'Junho',
                                         'Julho',
                                         'Agosto',
                                         'Setembro',
                                         'Outubro',
                                         'Novembro',
                                         'Dezembro');
{ Este array Ç exactamente o mesmo que o anterior, s¢ que neste caso Ç para
  os meses }

Var
  Dia, Mes, Ano, AnoFuturo : Integer;
  DiaSemana : String;
  TempStr : String; { String temporaria quando se là do teclado }
  Error : Integer; { Variavel usada para verificar se a operaá∆o
                     de converá∆o foi bem sucedida ou n∆o }

Function DayOfWeek(y, m, d : Integer) : Integer;
{ Esta funá∆o vai utilizar os valores 'y', 'm' e 'd' para dar o valor da
semana, sendo o 0 = Domingo. O algoritmo utilizado... }
{ 'y' tem de ser superior a 1752, pois foi a partir deste ano que foi
implementado o calend†rio Gregoriano, pelo qual trabalhamos actualmente. }

Const
t : Array [1..12] OF Integer = (0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4);

Begin
  If m < 3 Then dec(y);
  DayOfWeek := (y + (y DIV 4) - (y DIV 100) + (y DIV 400) + t[m] + d) MOD 7;
End; { DayOfWeek }

Function IsLeapYear(Year : Integer) : Boolean;
{ Esta funá∆o vai verificar se o ano 'Year' Ç bisexto ou n∆o. Para fazer este
c†lculo usa-se a f¢rmula universal de c†lculo de anos bisextos, ou seja, um
ano Ç bisexto se cumprir o seguinte : Ao dividir o ano por 4 d† resto 0 (por
exemplo 1996) E se ao dividir o ano por 100 o resto seja diferente de 0 OU
ao dividi-lo por 400 dà resto 0 (por exemplo 2000) }
{ O algoritmo Ç bem bem explicito... }

Begin
  If ((Ano MOD 4) = 0) AND (((Ano MOD 100) <> 0) OR ((Ano MOD 400) = 0)) Then
    IsLeapYear := TRUE
  Else IsLeapYear := FALSE;
End; { IsLeapYear }

Function ReadValue(Limite : integer) : integer;
{ Esta funá∆o Ç utilizada para ler do teclado somente numeros. ê
impossibilitada a introduá∆o de letras ou quaisquers outros caracteres.
  Existe ainda a opá∆o de limitar o numero de algarismos a introduzir. Esse
valor Ç o 'Limite'.
  Esta funá∆o tem o objectivo de substituir a funá∆o standard 'ReadLn', devido
a esta ser incompleta para controlar teclas.
  Com a 'ReadValue' temos a capacidade de controlar toda a operaá∆o de teclas
principalmente o facto de querermos sair do programa a qualquer altura. }

Const
  Key_Enter = 13; { Valor inteiro correspondente ao enter }
  Key_Esc = 27; { ... para o Esc }
  Key_BackSpace = 8; { ... BackSpace }
  Key_0 = 48; { ... '0' }
  Key_9 = 57; { ... '9' }

Var
  TempStr : String; { String usada para operaá‰es tempor†rias }
  TempInt : integer; { Integer usado para o mesmo que t† em cima }
  Ch : Char; { Valor utilizado para ler a tecla que foi pressionada }
  Key : Integer; { O mesmo de cima mas neste caso contem o valor numÇrico da tecla }
  i : integer; { Valor tempor†rio de controle, para controlar o numero de
                algarismos a ler do teclado }
  X, Y : byte; { Onde est† o Wally? hmmmm... onde est† o cursor? }
  error : integer; { Valor utilizado para controle de convers‰es }
  Finish : Boolean; { Valor para saber se podemos sair ou n∆o }

Begin
  i := 1; { inicializa a vari†vel. Vai ser introduzido um algarismo inicial }
  TempStr := ''; { Inicializa a vari†vel }
  X := WhereX; { Onde est† o cursor (posiá∆o X) }
  Y := WhereY; { Onde est† o cursor (posiá∆o Y)}
  Finish := FALSE; { A leitura ainda n∆o acabou. Nem sequer comeáou.... }
  While Not Finish Do { Enquanto n∆o acaba... }
    Begin
      If Keypressed Then { Se uma tecla for pressionada ... }
        Begin
          Ch := ReadKey; { Guarda o valor da tecla na vari†vel ... }
          Key := Ord(Ch); { Converte para valor numÇrico... }
          If (Key >= Key_0) AND (Key <= Key_9) AND (i <= limite) then
            { Se a tecla est† entre '0' e '9' ent∆o Ç um algarismo, e se
             ainda n∆o atingimos o limite... }
            Begin
              TempStr := TempStr + Ch; { Guarda a tecla na string tempor†ria }
              Write(Ch); { E escreve o char no ecrÉ ... }
              Inc(i); { Ahhh... como j† introduzimos um algarismo, temos de
              { incrementar o valor do algarismo actual a introduzir... }
            End; { If Key .... }
          If Key = Key_Esc Then Halt(0); { Foi pressionada a tecla ESC ? Sim...
          { Ent∆o vai embora pr¢ ..... quer dizer xauzinho... volta sempre }
          If (Key = Key_BackSpace) AND (X < WhereX) Then
          { Enganou-se na introduá∆o do algarismo ? Ent∆o vamos apagar...
            Mas s¢ atÇ ao sitio onde comeáou a introduzir }
            Begin
              { Apaga o char do ecrÉ... }
              GotoXY(WhereX-1,Y); { Volta um espaáo para tr†s ... }
              Write(' '); { Apaga o char... avanáo auutom†tico... }
              GotoXY(WhereX-1,Y); { Retorna para tr†s ... }
              Dec(i); { Actualiza o valor actual do algarismo a introduzir }
              { Apaga o char da 'TempStr' ... }
              Delete(TempStr,Length(TempStr),1); { Vamos ent∆o apagar da
              string 'TempStr' a ultima posiá∆o (correspondendo ao tamanho
              actual da string 'Length'), e vamos apagar somente 1 char }
            End; { If BackSpace }
          If Key = Key_Enter Then Finish := TRUE; { ENTER... ok... finish }
        End; { If Keypressed... }
    End; { While }
  Val(TempStr,TempInt,error); { Converter a string para integer... s¢ para o
  compilador n∆o nos chatear com erros }
  ReadValue := TempInt; { A funá∆o vai retornar o valor do 'TempInt'. O valor
  obtido da convers∆o do 'TempStr'. }
  WriteLn; { Avanáamos uma linha... para ser esteticamente como o 'ReadLn' }
End; { ReadValue }

BEGIN { E aqui comeáa a hist¢ria deste programa... µ muito tempo numa terra
longiqua a princesa.... hmmmm.... avanáando que isto n∆o Ç daqui... }
  ClrScr; { Limpa o ecrÉ. As coisas devem comeáar limpinhas }
  Dia := 0; { Inicializa vari†veis... }
  Mes := 0;
  Ano := 0;
  AnoFuturo := 0;
  { Comeáa a chatear o utilizador a pedir-lhe informaá‰es }
  WriteLn('Este programa informa qual o dia de anivers†rio de uma pessoa num ano futuro.');
  WriteLn('Para sair do programa prima a tecla ESC.');
  WriteLn('(No canto superior esquerdo, para quem n∆o sabe. Sim essa a° em cima...) ');
  WriteLn;
  While (Ano < 1752) DO
  { O ano em que se adoptou o calend†rio Gregoriano }
    Begin
      Write('Introduza o ano de nascimento : ');
      { Auto-explicativo }
      Ano := ReadValue(4); { Vamos ler no m†ximo 4 algarismos pr¢ 'ano'.
      Suponho que n∆o querem testar alguem que nasáa no ano 10000... quem sabe }
      If (Ano < 1752) Then WriteLn('O ano ',Ano,' ê inv†lido.');
    End; { While ano .... }
  If IsLeapYear(Ano) Then NumDias[2] := 29; { Se Ç um ano bisexto ent∆o
  o màs de Fevereiro no nosso array (matriz para quem n∆o sabe) ter† 29 dias }
  While (Mes > 12) OR (Mes < 1) DO
  { Alguem quer criar mais meses para cada ano ? }
    Begin
      Write('Introduza o màs de nascimento (1 a 12) : ');
      Mes := ReadValue(2); { Cada màs Ç constituido no m†ximo por 2 algarismos }
      If (Mes > 12) OR (Mes < 1) Then WriteLn('O màs ',Mes,' Ç inv†lido.');
    End; { While mes... }
  While (Dia < 1) OR (Dia > NumDias[Mes]) DO
  { Dias de cada màs ... }
    Begin
      Write('Introduza o dia de nascimento (1 a ',NumDias[Mes],') : ');
      Dia := ReadValue(2);
      If (Dia < 1) OR (dia > NumDias[mes]) Then WriteLn('O dia ',Dia,' Ç inv†lido.');
    End; { While dia ... }
  While (Ano >= AnoFuturo) DO
  { O 'AnoFuturo' Ç maior que o 'Ano' inicial }
    Begin
      Write('Introduza o ano futuro (a partir de ',Ano,') : ');
      AnoFuturo := ReadValue(4);
      If (Ano >= AnoFuturo) Then WriteLn('O ano futuro ',AnoFuturo,' Ç inv†lido.');
    End; { While anofuturo... }
  ClrScr;
  WriteLn('Vocà nasceu : ', DiaDaSemana[DayOfWeek(Ano,Mes,Dia)],
                            ', ', Dia, ' de ', NomeDoMes[Mes],' de ', Ano);
  WriteLn('Vocà ter† ', AnoFuturo - Ano, ' anos no dia : ',
                        DiaDaSemana[DayOfWeek(AnoFuturo,Mes,Dia)], ', ',
                        Dia, ' de ', NomeDoMes[Mes], ' de ', AnoFuturo);
  WriteLn;
  WriteLn;
  WriteLn;
  WriteLn('Idade v1.0 Copyright 1998');
  WriteLn('Gama© (aka Leandro Ribeiro Gama) Turma 2  --  Nß 303/98');
  WriteLn('xxx                              Turma 2  --  Nß xxx/98');
  WriteLn;
  WriteLn('Agradecimentos : ');
  WriteLn('Quero agradecer aos meus f∆s por me apoiarem entusiasticamente.');
  WriteLn('Obrigado † claque feminina que me apoiou naquelas horas de madrugada');
  WriteLn('quando eu estava a progredir neste programa "magnifico".');
  WriteLn('Obrigado, †s raparigas do Alternativa por me darem energia suficiente');
  WriteLn('para mais programas (mas estes programas n∆o s∆o os de programaá∆o).');
  WriteLn;
  WriteLn('E FINALMENTE (desculpem tar a gritar) tenho de agradecer †s ajudas');
  WriteLn('divinas que ainda existem por a°... obrigado a todos os ^Magico^''s');
  WriteLn('deste pa°s!!!');
  Halt(0); { Vamos sair em grande com a certeza de que tudo correu bem. Caso
  o valor retornado pelo programa seja diferente de 0, ent∆o podemos ter a
  certeza de que o programa teve problemas e devemos corrigir os BUGS. Para
  quem n∆o sabe o BUG Ç um insecto, e este nome deve-se ao facto de quando
  se comeáaram a criar os computadores, os cientistas tiveram uns pequenos
  problemas, e verificaram que o problema era um pequeno insecto no meio das
  v†lvulas. Por isso se comeáou a dizer que sempre que h† problemas com o
  software ou o hardware, s∆o BUGS que existem.
  BUG tb Ç o nome dum jogo... querem mais explicaá‰es hist¢ricas ? }
END. { Buh bye... "Don't imitate... Inovate", quer dizer, n∆o copiem... criem }

