5 CLS
SCREEN 12
REM Simula‡ao da velocidade de um para-quedista
REM dados
h = 3000
v = 0
vterminal = 55
g = 10
m = 70
dt = .1
tmax = 50
escala = 100
Fgrav = -m * g
k = (m * g) / (vterminal ^ 2)
a = -g
CLS
SCREEN 12
VIEW (100, 100)-(500, 400), 0, 2
WINDOW (0, O)-(tmax, escala)
LOCATE 28, 50: PRINT "t(s)"
LOCATE 12, 5: PRINT "v(m/s)"
LOCATE 27, 12: PRINT 0: LOCATE 27, 61: PRINT "tmax"
LOCATE 25, 10: PRINT 0: LOCATE 6, 8: PRINT "escala"
FOR t = 0 TO tmax STEP dt
        v = v + a * dt
        Fresistencia = k * (v ^ 2)
        Fresultante = Fresistencia + Fgrav
        a = Fresultante / m
        vel = ABS(v)
        PSET (t, vel), 4
        LOCATE 2, 25: COLOR 2: PRINT USING "t=###"; t
        LOCATE 3, 25: COLOR 4: PRINT USING "vel=###"; vel
        NEXT t
20 COLOR 10
   LOCATE 28, 14: INPUT "Deseja visualizar outra vez (S/N)"; S$
   S$ = UCASE$(S$)
   IF S$ = "N" THEN CHAIN "A:\A1B1C1.AúC"
   IF S$ = "S" THEN GOTO 10
   GOTO 20
10 CLS
   SLEEP (2)
   GOTO 5

