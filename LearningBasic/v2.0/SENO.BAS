10
REM Simula‡ao das transferencias de energia no movimento
REM de queda livre de uma bola da altura h
REM dados
dt = .01
tmax = 2
xmax = 2
escala = 150
r = 1

SCREEN 12
LOCATE 28, 50: PRINT "t"
LOCATE 27, 12: PRINT 0: LOCATE 27, 62: PRINT tmax
LOCATE 10, 8: PRINT "E"
LOCATE 25, 10: PRINT 0: LOCATE 6, 10: PRINT escala
FOR t = 0 TO tmax STEP 10
    
    
     PSET (t, t)
NEXT t




