'
'   Microsoft RemLine - Utilit rio de Remo‡ao de N£meros de Linha
'   Copyright (C) Microsoft Corporation 1985-1990
'
'   REMLINE.BAS ‚ um programa que remove n£meros de linhas dos programas
'   do Microsoft Basic. Este remove apenas os n£meros de linhas que nao
'   sao definidos em uma das seguintes instru‡oes: GOSUB, RETURN, GOTO,
'   THEN,ELSE, RESUME, RESTORE ou RUN.
'
'   Quando o REMLINE for executado, o mesmo solicitar  o nome do arquivo a
'   ser executado e o nome do arquivo ou dispositivo a receber a sa¡da
'   reformatada. Se nenhuma extensao for fornecida, a extensao ser  .BAS
'   (exceto para dispositivos de sa¡da). Se nomes de arquivo nao forem
'   fornecidos, REMLINE solicita pelos mesmos. Se os nomes de arquivo
'   forem iguais, REMLINE salva o arquivo original com a extensao .BAK.
'
'   REMLINE assume o seguinte em rela‡ao ao programa:
'
'     1. O programa deve estar sintaticamente correto e deve ser executado
'        no interpretador BASICA ou GW-BASIC.
'     2. H  um limite de 400 linhas. Para executar arquivos muito longos,
'        altere a constante MaxLines.
'     3. O primeiro n£mero encontrado em uma linha ‚ considerado um n£mero
'        de linha; assim algumas linhas de continua‡ao (em uma estrutura
'        espec¡ficade compila‡ao) pode nao ser manipulada corretamente.
'     4. REMLINE pode manipular instru‡oes simples que testam a fun‡ao ERL
'        usando operadores relacionais como =, <, and >. Por exemplo, a
'        seguinte instru‡ao ‚ manipulada corretamente:
'
'             IF ERL = 100 THEN END
'
'        A linha 100 nao ‚ removida do c¢digo de origem. Entretanto, as
'        expressoes mais complexas que contem os operadores +, -, AND, OR,
'        XOR, EQV, MOD, ou IMP podem nao ser manipulados corretamente. Por
'        exemplo, a instru‡ao REMLINE abaixo nao reconhece a linha 105 como
'        um n£mero de linha referenciado e o remove do c¢digo de origem:
'
'             IF ERL + 5 = 105 THEN END
'
'   Se nao gostar do modo que o REMLINE formata sua sa¡da, vocˆ pode modificar
'   as linhas de sa¡da em SUB GenOutFile.Um exemplo ‚ mostrado em coment rios.
DEFINT A-Z

' Declara‡oes de Fun‡oes e Subprocedimentos
DECLARE FUNCTION GetToken$ (Search$, Delim$)
DECLARE FUNCTION StrSpn% (InString$, Separator$)
DECLARE FUNCTION StrBrk% (InString$, Separator$)
DECLARE FUNCTION IsDigit% (Char$)
DECLARE SUB GetFileNames ()
DECLARE SUB BuildTable ()
DECLARE SUB GenOutFile ()
DECLARE SUB InitKeyTable ()

' Dados e constantes globais
CONST TRUE = -1
CONST false = 0
CONST MaxLines = 400

DIM SHARED LineTable!(MaxLines)
DIM SHARED LineCount
DIM SHARED Seps$, InputFile$, OutputFile$, TmpFile$

'Procura de palavras-chave
CONST KeyWordCount = 9
DIM SHARED KeyWordTable$(KeyWordCount)

KeyData:
   DATA THEN, ELSE, GOSUB, GOTO, RESUME, RETURN, RESTORE, RUN, ERL, ""

' In¡cio de c¢digo de programa de n¡vel m¢dulo
   Seps$ = " ,:=<>()" + CHR$(9)
   InitKeyTable
   GetFileNames
   ON ERROR GOTO FileErr1
   OPEN InputFile$ FOR INPUT AS 1
   ON ERROR GOTO 0
   COLOR 7: PRINT "Processando"; : COLOR 23: PRINT " . . .": COLOR 7: PRINT
   BuildTable
   CLOSE #1
   OPEN InputFile$ FOR INPUT AS 1
   ON ERROR GOTO FileErr2
   OPEN OutputFile$ FOR OUTPUT AS 2
   ON ERROR GOTO 0
   GenOutFile
   CLOSE #1, #2
   IF OutputFile$ <> "CON" THEN CLS

END

FileErr1:
   CLS
   PRINT "      Nome de arquivo inv lido": PRINT
   INPUT "      Novo nome arquivo de entrada (ENTER - finaliza): ", InputFile$
   IF InputFile$ = "" THEN END
FileErr2:
   INPUT "      Nome arquivo de sa¡da (ENTER - imprime na tela) :", OutputFile$
   PRINT
   IF (OutputFile$ = "") THEN OutputFile$ = "CON"
   IF TmpFile$ = "" THEN
      RESUME
   ELSE
      TmpFile$ = ""
      RESUME NEXT
   END IF

'
' BuildTable:
'   Verifica todo o arquivo de texto a procura de n£meros de linha que
'   tenham as instru‡oes GOTO, GOSUB, etc. A medida que cada um ‚ encontrado,
'   este ‚ inserido em uma tabela de n£meros de linha. A tabela ‚ usada
'   durante a segunda passagem (see GenOutFile), quando todos os n£meros de
'   linha nao contidos na lista sao removidos.
' Entrada:
'   Usa vari veis globais KeyWordTable$, KeyWordCount e Seps$
' Sa¡da:
'   Modifica LineTable! e LineCount
'
SUB BuildTable STATIC

   DO WHILE NOT EOF(1)
      ' Ler linha e obter primeiro valor
      LINE INPUT #1, InLin$
      Token$ = GetToken$(InLin$, Seps$)
      DO WHILE (Token$ <> "")
         FOR KeyIndex = 1 TO KeyWordCount
            ' Verificar se calor ‚ uma palavra-chave
            IF (KeyWordTable$(KeyIndex) = UCASE$(Token$)) THEN
               ' Obter n£mero de linha poss¡vel ap¢s palavra-chave
               Token$ = GetToken$("", Seps$)
               ' Verificar cada valor para ver se ‚ um n£mero de linha
               ' (O LOOP ‚ necess rio para os n£meros m£ltiplos de lihas
               ' de ON GOSUB ou ON GOTO). Um valor nao num‚rico finaliza
               ' a procura.
               DO WHILE (IsDigit(LEFT$(Token$, 1)))
                  LineCount = LineCount + 1
                  LineTable!(LineCount) = VAL(Token$)
                  Token$ = GetToken$("", Seps$)
                  IF Token$ <> "" THEN KeyIndex = 0
               LOOP
            END IF
         NEXT KeyIndex
         ' Get next token
         Token$ = GetToken$("", Seps$)
      LOOP
   LOOP

END SUB

'
' GenOutFile:
'  Gera um arquivo de sa¡da com n£meros de linha nao referenciados removidos.
' Entrada:
'  Usa vari veis globais LineTable!, LineCount e Seps$
' Sa¡da:
'  Arquivo executado
'
SUB GenOutFile STATIC

   ' Aumenta a velocidade eliminando a v¡rgula e dois-pontos
   ' (nao se pode separar o primeiro valor)
   Sep$ = " " + CHR$(9)
   DO WHILE NOT EOF(1)
      LINE INPUT #1, InLin$
      IF (InLin$ <> "") THEN
         ' Obter o primeiro valor e processar se este for um n£mero de linha
         Token$ = GetToken$(InLin$, Sep$)
         IF IsDigit(LEFT$(Token$, 1)) THEN
            LineNumber! = VAL(Token$)
            FoundNumber = false
            ' Veja se o n£mero da linha est  na tabela dos numeros de linha
            ' referenciados
            FOR index = 1 TO LineCount
               IF (LineNumber! = LineTable!(index)) THEN
                  FoundNumber = TRUE
               END IF
            NEXT index
            ' Modificar sequˆncias de linha
            IF (NOT FoundNumber) THEN
               Token$ = SPACE$(LEN(Token$))
               MID$(InLin$, StrSpn(InLin$, Sep$), LEN(Token$)) = Token$
            END IF
              
            ' Vocˆ pode substituir as linhas anteriores pelo seu pr¢prio
            ' c¢digo para reformatar a sa¡da. Por exemplo, tente estas linhas:
               
            'TmpPos1 = StrSpn(InLin$, Sep$) + LEN(Token$)
            'TmpPos2 = TmpPos1 + StrSpn(MID$(InLin$, TmpPos1), Sep$)
            '
            'IF FoundNumber THEN
            '   InLin$ = LEFT$(InLin$, TmpPos1 - 1) + CHR$(9) + MID$(InLin$, TmpPos2)
            'ELSE
            '   InLin$ = CHR$(9) + MID$(InLin$, TmpPos2)
            'END IF

         END IF
      END IF
      ' Imprime linha para o arquivo ou console (PRINT ‚ mais r pido que o
      ' dispositivo de console)
      IF OutputFile$ = "CON" THEN
         PRINT InLin$
      ELSE
         PRINT #2, InLin$
      END IF
   LOOP

END SUB

'
' GetFileNames:
'  Obtem um nome de arquivo atrav‚s da solicita‡ao ao usu rio.
' Entrada:
'  User input
' Sa¡da:
'  Define InputFiles$ e OutputFiles$
'
SUB GetFileNames STATIC

    CLS
    PRINT " Microsoft RemLine: Utilit rio de Remo‡ao de N£mero de Linha"
    PRINT "       (.BAS ‚ assumido se nenhuma extensao ‚ fornecida)"
    PRINT
    INPUT "      Nome de arquivo de entrada (ENTER para finalizar): ", InputFile$
    IF InputFile$ = "" THEN END
    INPUT "      Nome de arquivo de sa¡da (ENTER para imprimir na tela): ", OutputFile$
    PRINT
    IF (OutputFile$ = "") THEN OutputFile$ = "CON"

   IF INSTR(InputFile$, ".") = 0 THEN
      InputFile$ = InputFile$ + ".BAS"
   END IF

   IF INSTR(OutputFile$, ".") = 0 THEN
      SELECT CASE OutputFile$
         CASE "CON", "SCRN", "PRN", "COM1", "COM2", "LPT1", "LPT2", "LPT3"
            EXIT SUB
         CASE ELSE
            OutputFile$ = OutputFile$ + ".BAS"
      END SELECT
   END IF

   DO WHILE InputFile$ = OutputFile$
      TmpFile$ = LEFT$(InputFile$, INSTR(InputFile$, ".")) + "BAK"
      ON ERROR GOTO FileErr1
      NAME InputFile$ AS TmpFile$
      ON ERROR GOTO 0
      IF TmpFile$ <> "" THEN InputFile$ = TmpFile$
   LOOP

END SUB

'
' GetToken$:
'  Extrai valores de uma sequˆncia. Um valor ‚ uma palavra cercada  por
'  separadores, tais como espa‡os ou v¡rgulas. Os valores sao extra¡dos
'  e analizados quando da an lise de senten‡as ou comandos. Para usar a
'  fun‡ao GetToken$, envie a sequˆncia a ser analisada na primeira chamada e,
'  em seguida, passe uma sequˆncia nula em chamadas subsequentes at‚ que a
'  fun‡ao retorne um valor nulo de modo a indicar que toda a sequˆncia j 
'  foi analisada.
' Entrada:
'  Search$ = sequˆncia a ser procurada
'  Delim$  = sequˆncia de separadores
' Sa¡da:
'  GetToken$ = pr¢ximo token
'
FUNCTION GetToken$ (Search$, Delim$) STATIC

   ' Observe que SaveStr$ e BegPos devem ser est ticas entre chamadas
   ' (outras vari veis sao somente est ticas por eficiˆncia).
   ' Se primeira chamada, copiar a sequˆncia
   IF (Search$ <> "") THEN
      BegPos = 1
      SaveStr$ = Search$
   END IF
  
   ' Encontrar o in¡cio do pr¢ximo valor
   NewPos = StrSpn(MID$(SaveStr$, BegPos, LEN(SaveStr$)), Delim$)
   IF NewPos THEN
      ' Definir posi‡ao no in¡cio do valor
      BegPos = NewPos + BegPos - 1
   ELSE
      ' Se nao ‚ novo valor, sair e retornar valor nulo
      GetToken$ = ""
      EXIT FUNCTION
   END IF

   ' Encontrar fim do valor
   NewPos = StrBrk(MID$(SaveStr$, BegPos, LEN(SaveStr$)), Delim$)
   IF NewPos THEN
      ' Definir posi‡ao no final do valor
      NewPos = BegPos + NewPos - 1
   ELSE
      ' Se nao ‚ final de valor, retornar ao final do valor
      NewPos = LEN(SaveStr$) + 1
   END IF
   ' Remover valor da sequˆncia pesquisada
   GetToken$ = MID$(SaveStr$, BegPos, NewPos - BegPos)
   ' Definir nova posi‡ao inicial
   BegPos = NewPos

END FUNCTION

'
' InitKeyTable:
'  Inicializa uma tabela de palavras-chave. Palavras-chave devem ser
'  determinadas de modo que os n£meros de linha possam ser diferenciados
'  de constantes num‚ricas.
' Entrada:
'  Usa KeyData
' Sa¡da:
'  Modifica matriz global KeyWordTable$
'
SUB InitKeyTable STATIC

   RESTORE KeyData
   FOR Count = 1 TO KeyWordCount
      READ KeyWord$
      KeyWordTable$(Count) = KeyWord$
   NEXT

END SUB

'
' IsDigit:
'  Returna verdadeiro se o caractere passado for um d¡gito decimal. Uma
'  vez que um valor Basic inicia com um d¡gito ‚ um n£mero, a fun‡ao somente
'  verificar  o primeiro d¡gito. Nao verifica por n£meros negativos, uma vez
'  que nao ‚ necess rio.
' Entrada:
'  Char$ - caractere inicial a ser verificado
' Sa¡da:
'  IsDigit - verdadeiro se especificado no intervalo de 0 - 9
'
FUNCTION IsDigit (Char$) STATIC

   IF (Char$ = "") THEN
      IsDigit = false
   ELSE
      CharAsc = ASC(Char$)
      IsDigit = (CharAsc >= ASC("0")) AND (CharAsc <= ASC("9"))
   END IF

END FUNCTION

'
' StrBrk:
'  Procura InString$ de modo a encontrar o primeiro caractere em Separator$.
'  Returna o ¡ndice daquele caractere. Esta fun‡ao pode ser usada para
'  encontrar o final de um valor.
' Entrada:
'  InString$ = sequˆncia a ser procurada
'  Separator$ = caracteres a serem procurados
' Sa¡da:
'  StrBrk = Indice do primeiro caractere em InString$ ou 0 se nao encontrou
'
FUNCTION StrBrk (InString$, Separator$) STATIC

   Ln = LEN(InString$)
   BegPos = 1
   ' Procurar pelo final do valor (primeiro caractere que ‚ um delimitador).
   DO WHILE INSTR(Separator$, MID$(InString$, BegPos, 1)) = 0
      IF BegPos > Ln THEN
         StrBrk = 0
         EXIT FUNCTION
      ELSE
         BegPos = BegPos + 1
      END IF
   LOOP
   StrBrk = BegPos
  
END FUNCTION

'
' StrSpn:
'  Procura InString$ para encontrar o proimeiro caractere que nao ‚ um
'  daqueles em Separator$. Returna o ¡ndice daquele caractere. Esta
'  fun‡ao pode ser usada para encontrar o in¡cio de um valor.
' Entrada:
'  InString$ = sequˆncia a ser procurada
'  Separator$ = caracteres a serem procurados
' Sa¡da:
'  StrSpn = ¡ndice para o primeiro caractere que est  em InString$ ou 0
'           se todos se encontram em InString$
'
FUNCTION StrSpn% (InString$, Separator$) STATIC

   Ln = LEN(InString$)
   BegPos = 1
   ' Procura pelo in¡cio de um valor (caractere que nao ‚ um delimitador).
   DO WHILE INSTR(Separator$, MID$(InString$, BegPos, 1))
      IF BegPos > Ln THEN
         StrSpn = 0
         EXIT FUNCTION
      ELSE
         BegPos = BegPos + 1
      END IF
   LOOP
   StrSpn = BegPos

END FUNCTION

