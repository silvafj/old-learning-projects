10
REM Simula‡ao das transferencias de energia no movimento
REM de queda livre de uma bola da altura h
REM dados
h = 20
g = 10
m = .5
dt = .01
tmax = 2
a = -g
escala = 150

SCREEN 12
VIEW (100, 100)-(500, 400), 0, 2
WINDOW (0, 0)-(tmax, escala)
LOCATE 28, 50: PRINT "t"
LOCATE 27, 12: PRINT 0: LOCATE 27, 62: PRINT tmax
LOCATE 10, 8: PRINT "E"
LOCATE 25, 10: PRINT 0: LOCATE 6, 10: PRINT escala
FOR t = 0 TO tmax STEP dt
        v = a * t
        y = h + (1 / 2) * a * t ^ 2
        Ec = (1 / 2) * m * v ^ 2
        Ep = m * g * y
        Em = Ec + Ep
        PSET (t, Ec), 5
        PSET (t, Ep), 6
        PSET (t, Em), 7
        LOCATE 3, 25: COLOR 5: PRINT USING "Ec = ####"; Ec
        LOCATE 4, 25: COLOR 6: PRINT USING "Ep = ####"; Ep
        LOCATE 5, 25: COLOR 7: PRINT USING "Em = ####"; Em
NEXT t
20 LOCATE 28, 3: INPUT "Deseja visualizar outra vez (S/N)"; F$
 IF F$ = "S" OR F$ = "s" THEN GOTO 10
 IF F$ = "N" OR F$ = "n" THEN CHAIN "A:\A1B1C1.AúC"
GOTO 20



