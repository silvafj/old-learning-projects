10
REM Tra�ado de isovolumicas do g�s ideal
REM dados
R = 8.31
n = 1
V1 = .1
V2 = .2
V3 = .3
V4 = .4
Tmin = 200
Tmax = 400
Pmax = 50000

SCREEN 12
VIEW (100, 100)-(500, 400), 0, 2
WINDOW (0, 0)-(Tmax, Pmax)
LOCATE 28, 50: PRINT "T(K)"
LOCATE 12, 5: PRINT "P(Pa)"
LOCATE 27, 12: PRINT 0: LOCATE 27, 61: PRINT Tmax
LOCATE 25, 10: PRINT 0: LOCATE 6, 8: PRINT Pmax

FOR T = Tmin TO Tmax STEP .1
        P1 = n * R * T / V1
        P2 = n * R * 7 / V2
        P3 = n * R * T / V3
        P4 = n * R * T / V4
        PSET (T, P1), 5
        PSET (T, P2), 6
        PSET (T, P3), 7
        PSET (T, P4), 8
 NEXT T
20   LOCATE 28, 3: INPUT "Deseja visualizar outra vez (S/N)"; F$
      IF F$ = "S" OR F$ = "s" THEN GOTO 10
      IF F$ = "N" OR F$ = "n" THEN CHAIN "A:\A1B1C1.A�C"
      GOTO 20

