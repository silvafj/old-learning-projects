DEFINT A-Z
DECLARE SUB Center (row%, text$)
280 CLS
    SCREEN 9
    PALETTE 0, 8
    COLOR 7
    PSET (1, 1): DRAW "D300;R638;U300;L638"
    PSET (1, 30): DRAW "R638"
    PSET (2, 2): DRAW "D298;R636;U298;L636"
    PSET (1, 31): DRAW "R638"
    PSET (3, 3): DRAW "D296;R634;U296;L634"
    PSET (1, 32): DRAW "R638"
    PSET (4, 4): DRAW "D294;R632;U294;L632"
    PSET (1, 33): DRAW "R638"
    PSET (5, 5): DRAW "D292;R630;U292;L630"
    PSET (1, 34): DRAW "R638"
    PSET (6, 6): DRAW "D290;R628;U290;L628"
    PSET (1, 34): DRAW "R638"
    PSET (4, 4): DRAW "R638"
    COLOR 12
    Center 2, "Indice ----- GERAL "
330 LOCATE 2, 3: COLOR 2: PRINT TIME$
    LOCATE 2, 68: COLOR 2: PRINT DATE$
    COLOR 13
    LOCATE 4, 30: PRINT "A ----------"
    LOCATE 5, 30: PRINT "B -------------"
    LOCATE 6, 30: PRINT "C -----------"
    LOCATE 7, 30: PRINT "D ---------"
    LOCATE 8, 30: PRINT "E ------------"
    LOCATE 9, 30: PRINT "F ----------"
    LOCATE 10, 30: PRINT "G ----------"
    LOCATE 11, 30: PRINT "H -----------"
    LOCATE 12, 30: PRINT "I -----"
    LOCATE 13, 30: PRINT "J --------"
    LOCATE 14, 30: PRINT "K --"
    LOCATE 15, 30: PRINT "L ---"
    LOCATE 16, 30: PRINT "M -"
    LOCATE 17, 30: PRINT "N -"
    LOCATE 20, 30: PRINT "1 --------------"
    COLOR 1
    Center 4, "---------- GRµFICOS"
    Center 5, "------------- JOGOS"
    Center 6, "----------- QUÖMICA"
    Center 7, "--------- GEOMETRIA"
    Center 8, "------------ MéSICA"
    Center 9, "---------- CALCULOS"
    Center 10, "---------- ECONOMIA"
    Center 11, "----------- IMAGENS"
    Center 12, "----- ELECTRICIDADE"
    Center 13, "-------- INFORMA€ÇO"
    Center 14, "-- ??? MISTRIO ???"
    Center 15, "--- TRANSFORMADORES"
    Center 16, "- MOTORES ***** C.C"
    Center 17, "- MOTORES ***** C.A"
    Center 20, "-------------- SAIR"
    COLOR 15
    Center 24, "COLOCA A LETRA DO ITEM PRETENDIDO E PRESSIONA ENTER"
    LOCATE 24, 70: INPUT ; D$
    D$ = UCASE$(D$)
    IF D$ = "A" THEN GOTO 810
    IF D$ = "B" THEN GOTO 2010
    IF D$ = "C" THEN GOTO 3505
    IF D$ = "D" THEN GOTO 5120
    IF D$ = "E" THEN GOTO 5560
    IF D$ = "F" THEN CHAIN "MEMBRO30.BAS"
    IF D$ = "G" THEN GOTO 7660
    IF D$ = "H" THEN GOTO 7700
    IF D$ = "I" THEN GOTO 7860
    IF D$ = "J" THEN GOTO 7098
    IF D$ = "K" THEN CHAIN "MEMBRO26.BAS"
    IF D$ = "L" THEN CHAIN "MEMBRO27.BAS"
    IF D$ = "M" THEN CHAIN "MEMBRO28.BAS"
    IF D$ = "N" THEN CHAIN "MEMBRO29.BAS"
    IF D$ = "1" THEN CHAIN "FIM.BAS"
    GOTO 330
810 CLS
    SCREEN 9
    COLOR 10
830 Center 10, "Escolhes-te o item ®GRµFICOS¯"
    Center 11, "Desejas continuar (S/N)"
    LOCATE 11, 53: INPUT ; a$
    a$ = UCASE$(a$)
    IF a$ = "N" THEN GOTO 280
    IF a$ = "S" THEN GOTO 860
    GOTO 830
860 CLS
    SCREEN 9
    COLOR 7
    PSET (1, 1): DRAW "D300;R638;U300;L638"
    PSET (1, 30): DRAW "R638"
    PSET (2, 2): DRAW "D298;R636;U298;L636"
    PSET (1, 31): DRAW "R638"
    PSET (3, 3): DRAW "D296;R634;U296;L634"
    PSET (1, 32): DRAW "R638"
    PSET (4, 4): DRAW "D294;R632;U294;L632"
    PSET (1, 33): DRAW "R638"
    PSET (5, 5): DRAW "D292;R630;U292;L630"
    PSET (1, 34): DRAW "R638"
    PSET (6, 6): DRAW "D290;R628;U290;L628"
    PSET (1, 34): DRAW "R638"
    PSET (4, 4): DRAW "R638"
900 COLOR 12
    Center 2, "GRµFICOS"
    LOCATE 2, 3: COLOR 2: PRINT TIME$
    LOCATE 2, 68: COLOR 2: PRINT DATE$
    COLOR 13
    LOCATE 4, 3: PRINT "A - "
    LOCATE 5, 3: PRINT "B - "
    LOCATE 6, 3: PRINT "C - "
    LOCATE 7, 3: PRINT "D - "
    LOCATE 8, 3: PRINT "E - "
    LOCATE 9, 3: PRINT "F - "
    LOCATE 20, 3: PRINT "1 - "
    COLOR 1
    LOCATE 4, 4: PRINT " - SIMULA€ÇO 1"
    LOCATE 5, 4: PRINT " - SIMULA€ÇO 2"
    LOCATE 6, 4: PRINT " - SIMULA€ÇO 3"
    LOCATE 7, 4: PRINT " - SIMULA€ÇO 4"
    LOCATE 8, 4: PRINT " - CINTICA"
    LOCATE 9, 4: PRINT " - SIMULA€ÇO 5"
    LOCATE 20, 4: PRINT " - SAIR "
    COLOR 15
    Center 24, "COLOCA A LETRA DO ITEM PRETENDIDO E PRESSIONA ENTER"
    LOCATE 24, 70: INPUT ; F$
    F$ = UCASE$(F$)
    IF F$ = "1" THEN GOTO 280
    IF F$ = "A" THEN GOTO 7650
    IF F$ = "B" THEN GOTO 7900
    IF F$ = "C" THEN GOTO 7910
    IF F$ = "D" THEN GOTO 7920
    IF F$ = "E" THEN GOTO 7940
    IF F$ = "F" THEN GOTO 7950
    GOTO 900
2010 CLS
     SCREEN 9
     COLOR 10
     Center 10, "Escolhes-te o item ®JOGOS¯"
     Center 11, "Desejas continuar (S/N)"
2030 LOCATE 11, 53: INPUT ; G$
     G$ = UCASE$(G$)
     IF G$ = "N" THEN GOTO 280
     IF G$ = "S" THEN GOTO 2080
     GOTO 2030
2080 CLS
     SCREEN 9
    COLOR 7
    PSET (1, 1): DRAW "D300;R638;U300;L638"
    PSET (1, 30): DRAW "R638"
    PSET (2, 2): DRAW "D298;R636;U298;L636"
    PSET (1, 31): DRAW "R638"
    PSET (3, 3): DRAW "D296;R634;U296;L634"
    PSET (1, 32): DRAW "R638"
    PSET (4, 4): DRAW "D294;R632;U294;L632"
    PSET (1, 33): DRAW "R638"
    PSET (5, 5): DRAW "D292;R630;U292;L630"
    PSET (1, 34): DRAW "R638"
    PSET (6, 6): DRAW "D290;R628;U290;L628"
    PSET (1, 34): DRAW "R638"
    PSET (4, 4): DRAW "R638"
    COLOR 12
    Center 2, "JOGOS"
2120    LOCATE 2, 3: COLOR 2: PRINT TIME$
    LOCATE 2, 68: COLOR 2: PRINT DATE$
    COLOR 13
    LOCATE 4, 3: PRINT "A - "
    LOCATE 5, 3: PRINT "B - "
    LOCATE 20, 3: PRINT "1 - "
    COLOR 1
    LOCATE 4, 4: PRINT " - NIBBLES"
    LOCATE 5, 4: PRINT " - GORILA"
    LOCATE 20, 4: PRINT " - SAIR"
    COLOR 15
    Center 24, "COLOCA A LETRA DO ITEM PRETENDIDO E PRESSIONA ENTER"
 LOCATE 24, 70: INPUT ; H$
    H$ = UCASE$(H$)
    IF H$ = "1" THEN GOTO 280
    IF H$ = "A" THEN CHAIN "MEMBRO4.BAS"
    IF H$ = "B" THEN CHAIN "MEMBRO21.BAS"
    GOTO 2120
3505 CLS
     SCREEN 9
     COLOR 10
     Center 10, "Escolhes-te o item ®QUIMICA¯"
     Center 11, "Desejas continuar (S/N)"
3510 LOCATE 11, 53: INPUT ; J$
     J$ = UCASE$(J$)
     IF J$ = "N" THEN GOTO 280
     IF J$ = "S" THEN GOTO 3560
     GOTO 3510
3560 CLS
     SCREEN 9
     COLOR 7
    PSET (1, 1): DRAW "D300;R638;U300;L638"
    PSET (1, 30): DRAW "R638"
    PSET (2, 2): DRAW "D298;R636;U298;L636"
    PSET (1, 31): DRAW "R638"
    PSET (3, 3): DRAW "D296;R634;U296;L634"
    PSET (1, 32): DRAW "R638"
    PSET (4, 4): DRAW "D294;R632;U294;L632"
    PSET (1, 33): DRAW "R638"
    PSET (5, 5): DRAW "D292;R630;U292;L630"
    PSET (1, 34): DRAW "R638"
    PSET (6, 6): DRAW "D290;R628;U290;L628"
    PSET (1, 34): DRAW "R638"
    PSET (4, 4): DRAW "R638"
3600    COLOR 12
    Center 2, "QUÖMICA"
    LOCATE 2, 3: COLOR 2: PRINT TIME$
    LOCATE 2, 68: COLOR 2: PRINT DATE$
    COLOR 13
    LOCATE 20, 3: PRINT "1 - "
    LOCATE 4, 3: PRINT "A - "
    LOCATE 5, 3: PRINT "B - "
    LOCATE 6, 3: PRINT "C - "
    LOCATE 7, 3: PRINT "D - "
   
    COLOR 1
    LOCATE 20, 4: PRINT " - SAIR"
    LOCATE 4, 4: PRINT " - CALCULAR PERCENTAGENS"
    LOCATE 5, 4: PRINT " - CALCULAR PERCENTAGENS 2"
    LOCATE 6, 4: PRINT " - CALCULAR PERCENTAGENS 3"
    LOCATE 7, 4: PRINT " - CALCULAR PERCENTAGENS 4"
    COLOR 15
    Center 24, "COLOCA A LETRA DO ITEM PRETENDIDO E PRESSIONA ENTER"
 LOCATE 24, 70: INPUT ; K$
    K$ = UCASE$(K$)
    IF K$ = "1" THEN GOTO 280
    IF K$ = "A" THEN GOTO 4507
    IF K$ = "B" THEN GOTO 4750
    IF K$ = "C" THEN CHAIN "A1B2C2.BúA"
    IF K$ = "D" THEN CHAIN "A1B3C1.EúF"
    GOTO 3600
4507 CLS
     SCREEN 9
     COLOR 10
     Center 10, "Escolhes-te o programa ®CALCULAR PERCENTAGENS¯"
     Center 11, "Neste programa dada a f¢rmula de um hidrocarboneto,"
     Center 12, "calcula as percentagens de C e de H."
     Center 13, "Desejas continuar (S/N)"
4510 LOCATE 13, 70: INPUT ; M$
     M$ = UCASE$(M$)
     IF M$ = "N" THEN GOTO 3600
     IF M$ = "S" THEN GOTO 4580
     GOTO 4510
4580 CLS
     SCREEN 9
     COLOR 11: LOCATE 2, 10: PRINT "PERCENTAGENS DE C E H A PARTIR DAS FORMULAS DOS HIDROCARBONETOS"
     COLOR 10: LOCATE 5, 35: PRINT "F¢rmula CxHy"
     COLOR 15: LOCATE 10, 30: INPUT "QUAL O VALOR (INTEIRO) DE x"; X
     LOCATE 12, 30: INPUT "QUAL O VALOR (INTEIRO) DE y"; Y
     LOCATE 14, 40: PRINT "C="; X
     LOCATE 14, 50: PRINT "H="; Y
     LET Z = 12.011 * X + 1.0079 * Y
     LOCATE 16, 20: PRINT "%C"; INT(1201.1 * X / Z * 100 + .5) / 100
     LOCATE 17, 20: PRINT "%H"; INT(100.79 * Y / Z * 100 + .5) / 100
     LOCATE 19, 40: PRINT "Resultados aproximados …s cent‚simas"
     PSET (110, 200), 14: DRAW "R150;D50;L150;U50"
     COLOR 10
     Center 25, "Deseja mais calculos (S/N)"
4710 LOCATE 25, 60: INPUT ; N$
     N$ = UCASE$(N$)
     IF N$ = "S" THEN GOTO 4580
     IF N$ = "N" THEN GOTO 3560
     GOTO 4710
4750 CLS
     SCREEN 9
     COLOR 10
     Center 10, "Vocˆ escolheu o programa ®CALCULAR PERCENTAGENS 2¯"
     Center 11, "Este programa mostra o modo de determinar as"
     Center 12, "percentagens de C e de H num hidrocarboneto a "
     Center 13, "partir das massas de CO2 e H2O formadas na "
     Center 14, "combustao da amostra."
     Center 15, "Deseja continuar o programa (S/N)"
4820 LOCATE 15, 70: INPUT ; P$
     P$ = UCASE$(P$)
     IF P$ = "N" THEN GOTO 3560
     IF P$ = "S" THEN GOTO 4860
     GOTO 4820
4860 CLS
     SCREEN 9
     COLOR 1: LOCATE 1, 16: PRINT "ANALISE ELEMENTAR QUANTITATIVA DE HIDROCARBONETOS"
     LOCATE 17, 30: PRINT "Resultados dos calculos:"
     PSET (140, 240): DRAW "R390;D90;L390;U90"
     LOCATE 3, 18: PRINT "C,H + Oxig‚nio  -->  Di¢xido de carbono +  gua"
     PSET (140, 80), 10: DRAW "R50;U10;R50;D10;R100;D50;R25;U50;R50;D50;R25;U50;R50"
     PSET (140, 83), 10: DRAW "R50;D10;R50;U10;R97;D50;R31;U50;R44;D50;R32;U50;R46"
     LOCATE 8, 7: PRINT "Oxig‚nio            COMBUSTAO"
     LOCATE 5, 33: PRINT "Amostra"
     PSET (50, 81): DRAW "R60;H5;F5;G5"
     PSET (250, 67): DRAW "G20"
     LOCATE 11, 33: PRINT "Absor‡ao de CO2       Absor‡ao de  gua"
     PSET (206, 88): DRAW "R20;D3;L20;U3"
     LOCATE 12, 35: PRINT "(massa x)                (massa y)"
     LOCATE 12, 1: COLOR 15: PRINT "Resultados da an lise:"
     LOCATE 14, 8: INPUT "Massa de CO2 formado =x/g=", X
     LOCATE 15, 8: INPUT "Massa de  gua formada =y/g=", Y
     LET M = INT((12.011 * X / 44.011 + 2.016 * Y / 18.016) * 10000 + .5) / 10000
     LOCATE 19, 20: COLOR 15: PRINT "A massa de amostra utilizada foi de "; M; "g"
     LOCATE 21, 26: PRINT "Percentagens: %C="; INT((12.011 * X / 44.011) / M * 10000 + .5) / 100; ""
     LOCATE 23, 40: PRINT "%H="; INT((2.016 * Y / 18.016) / M * 10000 + .5) / 100
     COLOR 10
     Center 25, "Deseja mais calculos (S/N)"
5080 LOCATE 25, 70: INPUT ; Q$
     Q$ = UCASE$(Q$)
     IF Q$ = "N" THEN GOTO 3560
     IF Q$ = "S" THEN GOTO 4860
     GOTO 5080
5120 CLS
     SCREEN 9
     COLOR 10
     Center 10, "Escolhes-te o item ®GEOMETRIA¯"
     Center 11, "Desejas continuar (S/N)"
5150 LOCATE 11, 53: INPUT ; S$
     S$ = UCASE$(S$)
     IF S$ = "N" THEN GOTO 280
     IF S$ = "S" THEN GOTO 5190
     GOTO 5150
5190 CLS
     SCREEN 9
     COLOR 7
    PSET (1, 1): DRAW "D300;R638;U300;L638"
    PSET (1, 30): DRAW "R638"
    PSET (2, 2): DRAW "D298;R636;U298;L636"
    PSET (1, 31): DRAW "R638"
    PSET (3, 3): DRAW "D296;R634;U296;L634"
    PSET (1, 32): DRAW "R638"
    PSET (4, 4): DRAW "D294;R632;U294;L632"
    PSET (1, 33): DRAW "R638"
    PSET (5, 5): DRAW "D292;R630;U292;L630"
    PSET (1, 34): DRAW "R638"
    PSET (6, 6): DRAW "D290;R628;U290;L628"
    PSET (1, 34): DRAW "R638"
    PSET (4, 4): DRAW "R638"
5240    COLOR 12
    Center 2, "GEOMETRIA"
    LOCATE 2, 3: COLOR 2: PRINT TIME$
    LOCATE 2, 68: COLOR 2: PRINT DATE$
    COLOR 13
    LOCATE 20, 3: PRINT "1 - "
    LOCATE 4, 3: PRINT "A - "
    LOCATE 5, 3: PRINT "B - "
    LOCATE 6, 3: PRINT "C - "
    LOCATE 7, 3: PRINT "D - "
    COLOR 1
    LOCATE 20, 4: PRINT " - SAIR"
    LOCATE 4, 4: PRINT " - CIRCULOS"
    LOCATE 5, 4: PRINT " - PINTURA"
    LOCATE 6, 4: PRINT " - ROTA€AO"
    LOCATE 7, 4: PRINT " - TRACEJADO"
    COLOR 15
    Center 24, "COLOCA A LETRA DO ITEM PRETENDIDO E PRESSIONA ENTER"
    LOCATE 24, 70: INPUT ; T$
    T$ = UCASE$(T$)
    IF T$ = "1" THEN GOTO 280
    IF T$ = "A" THEN GOTO 5250
    IF T$ = "B" THEN CHAIN "A1B5C1.AúZ"
    IF T$ = "C" THEN CHAIN "A1B5C2.AúX"
    IF T$ = "D" THEN CHAIN "A1B1C5.BúC"
    GOTO 5240
5250 CLS
     SCREEN 12
     WINDOW (1, 1)-(638, 441)
     LOCATE 10, 10
     dt = 20
     tmax = 638
     FOR T = 0 TO tmax STEP dt
     a = 1
     CIRCLE (T, a), (50), 0
     CIRCLE (a, T), (50), 9
     CIRCLE (T, a), (150), 1
     CIRCLE (a, T), (150), 10
     CIRCLE (T, a), (250), 2
     CIRCLE (a, T), (250), 11
     CIRCLE (T, a), (350), 3
     CIRCLE (a, T), (350), 12
     CIRCLE (T, a), (450), 4
     CIRCLE (a, T), (450), 13
     CIRCLE (T, a), (550), 5
     CIRCLE (a, T), (550), 14
     CIRCLE (T, a), (650), 6
     CIRCLE (a, T), (650), 15
     NEXT
5520 COLOR 10
     Center 30, "Desejas visualizar outra vez (S/N)"
     LOCATE 30, 70: INPUT ; V$
     V$ = UCASE$(V$)
     IF V$ = "N" THEN GOTO 5190
     IF V$ = "S" THEN GOTO 5250
     GOTO 5520
5560 CLS
     SCREEN 9
     COLOR 10
     Center 10, "Escolhes o item ®MéSICA¯"
     Center 11, "Desejas continuar (S/N)"
5590 LOCATE 11, 53: INPUT ; X$
     X$ = UCASE$(X$)
     IF X$ = "N" THEN GOTO 280
     IF X$ = "S" THEN GOTO 5630
     GOTO 5590
5630 CLS
     SCREEN 9
     COLOR 7
    PSET (1, 1): DRAW "D300;R638;U300;L638"
    PSET (1, 30): DRAW "R638"
    PSET (2, 2): DRAW "D298;R636;U298;L636"
    PSET (1, 31): DRAW "R638"
    PSET (3, 3): DRAW "D296;R634;U296;L634"
    PSET (1, 32): DRAW "R638"
    PSET (4, 4): DRAW "D294;R632;U294;L632"
    PSET (1, 33): DRAW "R638"
    PSET (5, 5): DRAW "D292;R630;U292;L630"
    PSET (1, 34): DRAW "R638"
    PSET (6, 6): DRAW "D290;R628;U290;L628"
    PSET (1, 34): DRAW "R638"
    PSET (4, 4): DRAW "R638"
5640    COLOR 12
    Center 2, "MéSICA"
    LOCATE 2, 3: COLOR 2: PRINT TIME$
    LOCATE 2, 68: COLOR 2: PRINT DATE$
    COLOR 13
    LOCATE 4, 3: PRINT "A - "
    LOCATE 5, 3: PRINT "B - "
    LOCATE 6, 3: PRINT "C - "
    LOCATE 20, 3: PRINT "1 - "
    COLOR 1
    LOCATE 4, 4: PRINT " - SOM 1§"
    LOCATE 5, 4: PRINT " - SOM 2§"
    LOCATE 6, 4: PRINT " - SOM 3§"
    LOCATE 20, 4: PRINT " - SAIR"
    COLOR 15
    Center 24, "COLOCA A LETRA DO ITEM PRETENDIDO E PRESSIONA ENTER"
 LOCATE 24, 70: INPUT ; Y$
    Y$ = UCASE$(Y$)
    IF Y$ = "1" THEN GOTO 280
    IF Y$ = "A" THEN GOTO 7003
    IF Y$ = "B" THEN GOTO 7400
    IF Y$ = "C" THEN GOTO 7520
    GOTO 5640
7003 CLS
     SCREEN 9
     escala$ = "MLAABEDDEABBDEBMLBAADEBBDEADCDEMNFAFBCDCDFGAB"
     PLAY "L16"
     FOR I% = 0 TO 6
     PLAY "O" + STR$(I%)
     PLAY "X" + VARPTR$(escala$)
     NEXT I%
     COLOR 10
     Center 25, "Desejas ouvir mais alguma vez (S/N)"
7070 LOCATE 25, 70: INPUT ; Q$
     Q$ = UCASE$(Q$)
     IF Q$ = "N" THEN GOTO 5630
     IF Q$ = "S" THEN GOTO 7003
     GOTO 7070
7098 CLS
     SCREEN 9
     COLOR 10
     Center 10, "Escolhes-te o item ®INFORMA€ÇO¯"
     Center 11, "Desejas continuar (S/N)"
7100 LOCATE 11, 53: INPUT ; E$
     E$ = UCASE$(E$)
     IF E$ = "N" THEN GOTO 280
     IF E$ = "S" THEN GOTO 7150
     GOTO 7100
7150 CLS
     SCREEN 9
     COLOR 7
    PSET (1, 1): DRAW "D300;R638;U300;L638"
    PSET (1, 30): DRAW "R638"
    PSET (2, 2): DRAW "D298;R636;U298;L636"
    PSET (1, 31): DRAW "R638"
    PSET (3, 3): DRAW "D296;R634;U296;L634"
    PSET (1, 32): DRAW "R638"
    PSET (4, 4): DRAW "D294;R632;U294;L632"
    PSET (1, 33): DRAW "R638"
    PSET (5, 5): DRAW "D292;R630;U292;L630"
    PSET (1, 34): DRAW "R638"
    PSET (6, 6): DRAW "D290;R628;U290;L628"
    PSET (1, 34): DRAW "R638"
    PSET (4, 4): DRAW "R638"
7200    COLOR 12
    Center 2, "INFORMA€ÇO"
    LOCATE 2, 3: COLOR 2: PRINT TIME$
    LOCATE 2, 68: COLOR 2: PRINT DATE$
    COLOR 13
    LOCATE 20, 3: PRINT "1 - "
    LOCATE 4, 3: PRINT "A - "
    COLOR 1
    LOCATE 20, 4: PRINT " - SAIR"
    LOCATE 4, 4: PRINT " - LEIA-ME"
    COLOR 15
    Center 24, "COLOCA A LETRA DO ITEM PRETENDIDO E PRESSIONA ENTER"
 LOCATE 24, 70: INPUT ; Y$
     Y$ = UCASE$(Y$)
     IF Y$ = "1" THEN GOTO 280
     GOTO 7200
7400 CLS
     SCREEN 9
     escala$ = "ABCDEFGGFEDCBAABDCEFAGBCDAEFDEFDAFCDBEABBAFCDE"
     PLAY "L16"
     FOR I% = 0 TO 6
     PLAY "O" + STR$(I%)
     PLAY "X" + VARPTR$(escala$)
     NEXT I%
     COLOR 10
     Center 25, "Desejas ouvir mais alguma vez (S/N)"
7480 LOCATE 25, 52: INPUT ; Q$
     Q$ = UCASE$(Q$)
     IF Q$ = "N" THEN GOTO 5630
     IF Q$ = "S" THEN GOTO 7400
     GOTO 7480
7520 CLS
     SCREEN 9
     escala$ = "MNAAAABCDEFGGFEDMLCBAABDCEFAGBCDAEFDMSEFDAFCDBEABBAFCDE"
     PLAY "L16"
     FOR I% = 0 TO 6
     PLAY "O" + STR$(I%)
     PLAY "X" + VARPTR$(escala$)
     NEXT I%
     COLOR 10
     Center 25, "Desejas ouvir mais alguma vez (S/N)"
7600 LOCATE 25, 52: INPUT ; Q$
     Q$ = UCASE$(Q$)
     IF Q$ = "N" THEN GOTO 5630
     IF Q$ = "S" THEN GOTO 7520
     GOTO 7600
7640 CHAIN "FIM.BAS"
7650 CLS
     COLOR 10
     Center 10, "Este programa simula a velocidade de um para-quedista"
     Center 11, "Para continuar pressiona qualquer tecla"
     SLEEP (2000)
     CHAIN "A:"
7660 CLS
     SCREEN 9
    COLOR 10
    Center 10, "Escolhes-te o item ®ECONOMIA¯"
    Center 11, "Desejas continuar (S/N)"
7670 LOCATE 11, 53: INPUT ; E$
    E$ = UCASE$(E$)
    IF E$ = "N" THEN GOTO 280
    IF E$ = "S" THEN GOTO 7680
    GOTO 7670
7680 CLS
    SCREEN 9
    COLOR 7
    PSET (1, 1): DRAW "D300;R638;U300;L638"
    PSET (1, 30): DRAW "R638"
    PSET (2, 2): DRAW "D298;R636;U298;L636"
    PSET (1, 31): DRAW "R638"
    PSET (3, 3): DRAW "D296;R634;U296;L634"
    PSET (1, 32): DRAW "R638"
    PSET (4, 4): DRAW "D294;R632;U294;L632"
    PSET (1, 33): DRAW "R638"
    PSET (5, 5): DRAW "D292;R630;U292;L630"
    PSET (1, 34): DRAW "R638"
    PSET (6, 6): DRAW "D290;R628;U290;L628"
    PSET (1, 34): DRAW "R638"
    PSET (4, 4): DRAW "R638"
7690    COLOR 12
    Center 2, "ECONOMIA"
    LOCATE 2, 3: COLOR 2: PRINT TIME$
    LOCATE 2, 68: COLOR 2: PRINT DATE$
    COLOR 13
    LOCATE 4, 3: PRINT "A - "
    LOCATE 20, 3: PRINT "1 - "
    COLOR 1
    LOCATE 4, 4: PRINT " - MONEY MANAGER"
    LOCATE 20, 4: PRINT " - SAIR"
    COLOR 15
    Center 24, "COLOCA A LETRA DO ITEM PRETENDIDO E PRESSIONA ENTER"
 LOCATE 24, 70: INPUT ; a$
    a$ = UCASE$(a$)
    IF a$ = "A" THEN CHAIN "membro24.bas"
    IF a$ = "1" THEN GOTO 280
    GOTO 7690
7700 CLS
    SCREEN 9
    COLOR 10
    Center 10, "Escolhes-te o item ®IMAGENS¯"
    Center 11, "Desejas continuar (S/N)"
7710 LOCATE 11, 53: INPUT ; E$
    E$ = UCASE$(E$)
    IF E$ = "N" THEN GOTO 280
    IF E$ = "S" THEN GOTO 7720
    GOTO 7710
7720 CLS
    SCREEN 9
    COLOR 7
    PSET (1, 1): DRAW "D300;R638;U300;L638"
    PSET (1, 30): DRAW "R638"
    PSET (2, 2): DRAW "D298;R636;U298;L636"
    PSET (1, 31): DRAW "R638"
    PSET (3, 3): DRAW "D296;R634;U296;L634"
    PSET (1, 32): DRAW "R638"
    PSET (4, 4): DRAW "D294;R632;U294;L632"
    PSET (1, 33): DRAW "R638"
    PSET (5, 5): DRAW "D292;R630;U292;L630"
    PSET (1, 34): DRAW "R638"
    PSET (6, 6): DRAW "D290;R628;U290;L628"
    PSET (1, 34): DRAW "R638"
    PSET (4, 4): DRAW "R638"
7730    COLOR 12
    Center 2, "IMAGENS"
    LOCATE 2, 3: COLOR 2: PRINT TIME$
    LOCATE 2, 68: COLOR 2: PRINT DATE$
    COLOR 13
    LOCATE 4, 3: PRINT "A - "
    LOCATE 20, 3: PRINT "1 - "
    COLOR 1
    LOCATE 4, 4: PRINT " - PASSAGEM"
    LOCATE 20, 4: PRINT " - SAIR"
    COLOR 15
    Center 24, "COLOCA A LETRA DO ITEM PRETENDIDO E PRESSIONA ENTER"
 LOCATE 24, 70: INPUT ; a$
     a$ = UCASE$(a$)
     IF a$ = "P" THEN GOTO 7740
     IF a$ = "1" THEN GOTO 280
     GOTO 7730
7740 CLS
     Center 15, "ESCREVE ®VPIC¯ E PRESSIONA ENTER"
     Center 16, "NO FIM DO PROGRAMA ESCREVE ®EXIT¯"
     SHELL "COMMAND.COM"
7750 GOTO 280
7860 CLS
     SCREEN 9
    COLOR 10
    Center 10, "Escolheu o item ®ELECTRICIDADE¯"
    Center 11, "Desejas continuar (S/N)"
7870    LOCATE 11, 53: INPUT ; E$
    E$ = UCASE$(E$)
    IF E$ = "N" THEN GOTO 280
    IF E$ = "S" THEN GOTO 7880
    GOTO 7870
7880 CLS
    SCREEN 9
    COLOR 7
    PSET (1, 1): DRAW "D300;R638;U300;L638"
    PSET (1, 30): DRAW "R638"
    PSET (2, 2): DRAW "D298;R636;U298;L636"
    PSET (1, 31): DRAW "R638"
    PSET (3, 3): DRAW "D296;R634;U296;L634"
    PSET (1, 32): DRAW "R638"
    PSET (4, 4): DRAW "D294;R632;U294;L632"
    PSET (1, 33): DRAW "R638"
    PSET (5, 5): DRAW "D292;R630;U292;L630"
    PSET (1, 34): DRAW "R638"
    PSET (6, 6): DRAW "D290;R628;U290;L628"
    PSET (1, 34): DRAW "R638"
    PSET (4, 4): DRAW "R638"
7890    COLOR 12
    Center 2, "ELECTRICIDADE"
    LOCATE 2, 3: COLOR 2: PRINT TIME$
    LOCATE 2, 68: COLOR 2: PRINT DATE$
    COLOR 13
    LOCATE 20, 3: PRINT "1 - "
    LOCATE 4, 3: PRINT "A - "
    LOCATE 5, 3: PRINT "B - "
    COLOR 1
    LOCATE 20, 4: PRINT " - SAIR"
    LOCATE 4, 4: PRINT " - SLIC"
    LOCATE 5, 4: PRINT " - TRANSFORMADORES"
    COLOR 15
    Center 24, "COLOCA A LETRA DO ITEM PRETENDIDO E PRESSIONA ENTER"
 LOCATE 24, 70: INPUT ; H$
    H$ = UCASE$(H$)
    IF H$ = "1" THEN GOTO 280
    IF H$ = "A" THEN CHAIN "A1B5C3.AúY"
    IF H$ = "B" THEN GOTO 7930
    GOTO 7890
7900 CLS
     COLOR 10
     Center 10, "Este programa simula as transferˆncias de energia"
     Center 11, "na queda de um para-quedista"
     Center 12, "Para continuar pressiona ENTER"
     SLEEP (2000)
     CHAIN "A1B3C5.MúN"
7910 CLS
     COLOR 10
     Center 10, "Este programa mostra o tra‡ado de isovol£micas do g s ideal"
     Center 11, "Para continuar pressiona ENTER"
     SLEEP (2000)
     CHAIN "A1B4C1.OúP"
7920 CLS
     COLOR 10
     Center 10, "Este programa mostra o tra‡ado de isot‚rmicas do g s ideal"
     Center 11, "Para continuar pressiona ENTER"
     SLEEP (2000)
     CHAIN "A1B4C2.QúR"
7930 CLS
     COLOR 10
     Center 10, "Este programa calcula valores relativos aos transformadores"
     Center 11, "Para continuar pressiona ENTER"
     SLEEP (2000)
     CHAIN "MEMBRO12.BAS"
7940 CLS
     COLOR 10
     Center 10, "CONTINUA E LÒ..."
     SLEEP (2000)
     CHAIN "A1B2C3.ZúH"
7950 CLS
     COLOR 10
     Center 10, "Este programa simula as transferˆncias de energia"
     Center 11, "no movimento de queda livre de uma bola da altura h"
     Center 12, "Para continuar pressiona ENTER"
     SLEEP (2000)
     CHAIN "A1B3C2.GúH"
7960 CLS
     COLOR 10
     Center 10, "Este programa simula as transferˆncias de energia "
     Center 11, "no movimento de uma bola da altura h"
     Center 12, "Para continuar pressiona ENTER"
     SLEEP (2000)
     CHAIN "A1B3C3.IúJ"

'Center:
'  Centers text on given row
SUB Center (row, text$)
    LOCATE row, 41 - LEN(text$) / 2
    PRINT text$;
END SUB

