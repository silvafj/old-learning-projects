10 CLS
   SCREEN 9
   COLOR 14: LOCATE 1, 20: PRINT "CINTICA QUIMICA - Reac‡ao de primeira ordem"
   COLOR 15: PSET (100, 300): DRAW "R400;U200;L400;D200"
   LOCATE 3, 21: PRINT "REAC€AO A +2B -> PRODUTOS V=K.(A)"
   LOCATE 9, 9: PRINT "(A)"
   LOCATE 23, 56: PRINT "TEMPO,t"
   LINE (100, 200)-(105, 200)
   LOCATE 8, 9: PRINT "200"
   LOCATE 5, 13: PRINT "Vamos variar k e observar o efeito: k=3, 11, 19 e 27"
    COLOR 14: LOCATE 6, 13: INPUT "Escolhe a concentra‡ao inicial de A (0-200 mol/mL)"; A
    FOR K = 3 TO 27 STEP 8
    FOR T = 0 TO 50 STEP 3
    PSET (100 + 8 * T, 300 - A / EXP(T * K / 100)), K / 5 + 8
    NEXT T
    NEXT K
    LOCATE 10, 40: PRINT "K=3"
    LOCATE 11, 40: PRINT "K=11"
    LOCATE 12, 40: PRINT "K=19"
    LOCATE 13, 40: PRINT "K=27"
    LINE (350, 130)-(400, 130), 9
    LINE (350, 145)-(400, 145), 10
    LINE (350, 160)-(400, 350), 12
    LINE (350, 175)-(400, 175), 5
20  LOCATE 25, 3: INPUT " Deseja visualizar outra vez (S/N)"; F$
    IF F$ = "S" OR F$ = "s" THEN GOTO 10
    IF F$ = "N" OR F$ = "n" THEN CHAIN "A:\A1B1C1.AúC"
    GOTO 20

