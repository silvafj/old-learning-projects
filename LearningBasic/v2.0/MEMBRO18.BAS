    PALETTE 0, 1
    SCREEN 1
    FOR i% = 0 TO 3: a%(i%) = i%: NEXT i%
    LINE (138, 35)-(288, 165), 3, BF
    LINE (20, 10)-(160, 100), 2, BF
    DO
        FOR i% = 0 TO 3
            a%(i%) = (a%(i%) + 1) MOD 16
        NEXT i%
        PALETTE USING a%(0)
    LOOP UNTIL INKEY$ = CHR$(71)

