1   ON ERROR GOTO 10
    CLS
    INPUT "Digite o nome do arquivo: "; f$
    OPEN f$ FOR BINARY AS #1
    PRINT "Tamanho do arquivo (em BYTES)= "; LOF(1)
    LOCATE 10, 15: PRINT "OPERA��O BEM SUCEDIDA"
9   INPUT "DESEJA FAZER OUTRA OPERA��O (S/N)"; A$
    IF A$ = "S" OR A$ = "s" THEN GOTO 1
    IF A$ = "N" OR A$ = "n" THEN CHAIN "A:\A1B1C1.A�C"
    GOTO 9
10  LOCATE 10, 15: PRINT "ERRO: NOME DO ARQUIVO INV�LIDO"
11  INPUT "DESEJA FAZER OUTRA OPERA��O (S/N)"; A$
    IF A$ = "S" OR A$ = "s" THEN GOTO 1
    IF A$ = "N" OR A$ = "n" THEN CHAIN "A:\A1B1C1.A�C"
    GOTO 11


