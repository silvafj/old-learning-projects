    FOR t = 37 TO 32767 STEP 10
    SOUND t, t / 1000
    LOCATE 2, 25: COLOR 2: PRINT USING "s=#####"; t
    NEXT t
    REM a partir dos 15000 n∆o se houve

