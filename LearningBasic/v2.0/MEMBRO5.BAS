    FOR i% = 1 TO 181
        GOSUB Quadrado
    NEXT i%
    END

Quadrado:
   
    PRINT i%, i% * i%
    RETURN

