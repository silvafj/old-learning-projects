DEFINT A-Z
DECLARE SUB Center (row%, text$)
CLS
    SCREEN 9
    PALETTE 0, 7
    PAINT (160, 100), 2
    SCREEN 9
    FOR i% = 255 TO 385
        PSET (i%, 125)
        FOR prazo% = 1 TO 100:  NEXT prazo%
        PRESET (i%, 125)
    NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 126)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 126)
      NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 127)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 127)
     NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 128)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 128)
        NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 129)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 129)
       NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 130)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 130)
        NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 131)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 131)
        NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 132)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 132)
     NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 133)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 133)
    NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 134)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 134)
    NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 135)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 135)
    NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 136)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 136)
    NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 137)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 137)
    NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 138)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 138)
    NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 139)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 139)
    NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 140)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 140)
    NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 141)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 141)
    NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 142)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 142)
    NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 143)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 143)
    NEXT i%
    FOR i% = 255 TO 385
        PSET (i%, 144)
        FOR prazo% = 1 TO 100: NEXT prazo%
        PRESET (i%, 144)
    NEXT i%
COLOR 4
Center 10, "L"
SLEEP (1)
Center 10, "Le"
SLEEP (1)
Center 10, "Len"
SLEEP (1)
Center 10, "Lend"
SLEEP (1)
Center 10, "Lendo"
SLEEP (1)
Center 10, "Lendo ."
SLEEP (1)
Center 10, "Lendo .."
SLEEP (1)
Center 10, "Lendo ..."
SLEEP (1)
CHAIN "CABECA.BAS"

'Center:
'  Centers text on given row
SUB Center (row, text$)
    LOCATE row, 41 - LEN(text$) / 2
    PRINT text$;

END SUB

