10 CLS
   SCREEN 9
    SCREEN 1
    T$ = "F60 L120 E60 "
 FOR T = 0 TO 100 STEP 10
    DRAW "C15 X" + VARPTR$(T$)
    DRAW "A0 X" + VARPTR$(T$)
    DRAW "A1 X" + VARPTR$(T$)
    DRAW "A2 X" + VARPTR$(T$)
    DRAW "A3 X" + VARPTR$(T$)
    DRAW "A0 X" + VARPTR$(T$)
    CIRCLE (160, 100), (50), 1
  NEXT
    SLEEP (2)
12  LOCATE 1, 1: INPUT "Deseja visualizar outra vez (S/N)"; D$
    IF D$ = "S" OR D$ = "s" THEN GOTO 10
    IF D$ = "N" OR D$ = "n" THEN CHAIN "A:\A1B1C1.AúC"
    GOTO 12

