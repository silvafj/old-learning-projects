1   ON ERROR GOTO 10
    CLS
    INPUT "Digite o nome do arquivo: "; f$
    OPEN f$ FOR BINARY AS #1
    PRINT "Tamanho do arquivo (em BYTES)= "; LOF(1)
    LOCATE 10, 15: PRINT "OPERA€ÇO BEM SUCEDIDA"
9   INPUT "DESEJA FAZER OUTRA OPERA€ÇO (S/N)"; A$
    IF A$ = "S" OR A$ = "s" THEN GOTO 1
    IF A$ = "N" OR A$ = "n" THEN CHAIN "A:\A1B1C1.AúC"
    GOTO 9
10  LOCATE 10, 15: PRINT "ERRO: NOME DO ARQUIVO INVµLIDO"
11  INPUT "DESEJA FAZER OUTRA OPERA€ÇO (S/N)"; A$
    IF A$ = "S" OR A$ = "s" THEN GOTO 1
    IF A$ = "N" OR A$ = "n" THEN CHAIN "A:\A1B1C1.AúC"
    GOTO 11


