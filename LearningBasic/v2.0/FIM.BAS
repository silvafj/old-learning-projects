DEFINT A-Z
DECLARE SUB Asterisco ()
DECLARE SUB Center (row, text$)
CLS
 SCREEN 9
 PALETTE 0, 7
 COLOR 7
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 15
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 14
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 13
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 12
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 11
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 10
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 9
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 8
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 6
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 5
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 4
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 3
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 2
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 COLOR 1
 Center 10, "OBRIGADO !!!"
 SLEEP (1)
 Center 11, "Pela tua preferˆncia..."
 COLOR 4
 SLEEP (2)
 Center 12, "CARREGA QUALQUER TECLA"
 Asterisco
 CLS
 PALETTE 7, 0

 SHELL

SUB Asterisco
    COLOR 4
    a$ = "*    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    "
    WHILE INKEY$ <> "": WEND 'Clear keyboard buffer

    WHILE INKEY$ = ""
        COLOR 2
        FOR a = 1 TO 5
            LOCATE 1, 1                             'print horizontal sparkles
            PRINT MID$(a$, a, 80);
            LOCATE 22, 1
            PRINT MID$(a$, 6 - a, 80);
          COLOR 4
            FOR b = 2 TO 20                         'Print Vertical sparkles
                c = (a + b) MOD 5
                IF c = 1 THEN
                    LOCATE b, 80
                    PRINT "*";
                    LOCATE 23 - b, 1
                    PRINT "*";
                ELSE
                    LOCATE b, 80
                    PRINT " ";
                    LOCATE 23 - b, 1
                    PRINT " ";
                END IF
            COLOR 4
            NEXT b
        COLOR 2
        NEXT a
    WEND

END SUB

'Center:
'  Centers text on given row
SUB Center (row, text$)
    LOCATE row, 41 - LEN(text$) / 2
    PRINT text$;
END SUB

