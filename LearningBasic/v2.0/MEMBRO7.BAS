10  CLS
    SLEEP (1)
    SCREEN 1
    LINE (110, 70)-(190, 120), , B
    LINE (0, 0)-(320, 200), 3, , &HFF00
    SLEEP (2)
9   LOCATE 1, 1: INPUT "Deseja visualizar outra vez (S/N)"; A$
    IF A$ = "S" OR A$ = "s" THEN GOTO 10
    IF A$ = "N" OR A$ = "n" THEN CHAIN "A:\A1B1C1.AúC"
    GOTO 9

