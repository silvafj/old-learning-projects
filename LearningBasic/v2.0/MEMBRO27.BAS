DEFINT A-Z
DECLARE SUB Center (row, text$)
CLS
SCREEN 9
PALETTE 0, 1
Center 10, "sdkjgv"
CHAIN "CORPO.BAS"

'Center:
'  Centers text on given row
SUB Center (row, text$)
    LOCATE row, 41 - LEN(text$) / 2
    PRINT text$;


END SUB

