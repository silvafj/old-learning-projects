   FOR t = 0 TO 6.4 STEP .05
   u = PI * 5
   FOR n = 1 TO 20
   u. = u + 10 / n * SIN(n * t)
   NEXT
   PRINT TAB(8); t; "      "; ROUND(u, 3)
   NEXT
            

