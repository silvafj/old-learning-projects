10  CLS
    SCREEN 1
    CIRCLE (106, 100), 75, 1
    LINE (138, 35)-(288, 165), 1, B
    PAINT (160, 100), 2, 1
    SLEEP (5)
9   LOCATE 25, 2: INPUT "Deseja visualizar outra vez (S/N)"; A$
    IF A$ = "S" OR A$ = "s" THEN GOTO 10
    IF A$ = "N" OR A$ = "n" THEN GOTO 11
    GOTO 9
11 CHAIN "A:\A1B1C1.AúC"

