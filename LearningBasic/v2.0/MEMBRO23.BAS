10 CLS
SCREEN 12
REM Simula‡ao das transferencias de energia na queda
REM de um para-quedista
REM dados
h = 3000
v = 0
vterminal = 55
g = 10
m = 70
dt = .1
tmax = 50
escala = 3000000
Fgrav = -m * g
k = (m * g) / (vterminal ^ 2)
a = -g
Epinicial = m * g * h
SCREEN 12
VIEW (100, 100)-(500, 400), 0, 2
WINDOW (0, 0)-(tmax, escala)
LOCATE 28, 50: PRINT "t(s)"
LOCATE 12, 5: PRINT "E(J)"
LOCATE 27, 12: PRINT 0: LOCATE 27, 61: PRINT tmax
LOCATE 25, 10: PRINT 0: LOCATE 6, 8: PRINT escala

FOR t = 0 TO tmax STEP dt
        Ec = (1 / 2) * m * v ^ 2
        Ep = m * g * h
        Em = Ec + Ep
        Ed = Epinicial - Em
        v = v + a * dt
        h = h + v * dt
        Fresistencia = k * (v ^ 2)
        Fresultante = Fresistencia + Fgrav
        a = Fresultante / m
        PSET (t, Ec), 4
        PSET (t, Ep), 5
        PSET (t, Em), 6
        PSET (t, Ed), 7
        PSET (t, Em + Ed), 8
        LOCATE 2, 25: COLOR 2: PRINT USING "t=###"; t
        LOCATE 3, 25: COLOR 4: PRINT USING "Ec=#######"; Ec
        LOCATE 4, 25: COLOR 5: PRINT USING "Ep=#######"; Ep
        LOCATE 5, 25: COLOR 6: PRINT USING "Em=#######"; Em
        LOCATE 6, 25: COLOR 7: PRINT USING "Ed=#######"; Ed
        LOCATE 6, 45: COLOR 8: PRINT USING "Etotal=########"; Em + Ed
NEXT t
15  LOCATE 28, 3: INPUT "Deseja visualizar outra vez (S/N)"; F$
        IF F$ = "S" OR F$ = "s" THEN GOTO 10
        IF F$ = "N" OR F$ = "n" THEN CHAIN "A:\A1B1C1.AúC"
        GOTO 15



