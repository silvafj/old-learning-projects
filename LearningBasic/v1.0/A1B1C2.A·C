   ADDRESS = &H300
   TXADDRESS = ADDRESS + 0: REM write transmit buffer
   RXADDRESS = ADDRESS + 0: REM read receive buffer
   CTRLADDRESS = ADDRESS + 1: REM write only
   STATUSADDRESS = ADDRESS + 1: REM read only
   CTRLBYTE = 8 + 16 + 64
                               REM reset tpuart
   CTRLBYTE = CTRLBYTE OR 128
   OUT (CTRLADDRESS), CTRLBYTE
    CTRLBYTE = CTRLBYTE AND 127
    OUT (CTRLADDRESS), CTRLBYTE
    CTRLBYTE = CTRLBYTE OR 128
    OUT (CTRLADDRESS), CTRLBYTE
    CTRLBYTE = CTRLBYTE AND 127
    OUT (CTRLADDRESS), CTRLBYTE
                               REM set cts in rts out and internal clock
    PARITY = 1: REM 0: no parity
    ODD = 0: REM 0: even parit 1: odd parity
    BITS = 1: REM # bits per character 0: 7 bits 1: 8bits
    STOPBITS = 0: REM # of stop bits 0: 1 stop bit and 1 :2 stop bits
    CP1 = 0: REM cp1 as cts input
    CP2IO = 0: REM  as cp2 output
    CP2 = 0: REM cp2 functions as rts output
    CLK = 0: REM internal clock
    MODE = CP1 * 1 + CP2IO * 2 + CP2 * 4 + CLK * 8
    MODE = MODE + PARITY * 16 + ODD * 32 + BITS * 64 + STOPBITS * 128
    OUT (ADDRESS), MODE: REM define outputs and transmit format
    OUT (ADDRESS), &HFF: REM interrupt on all status changes
    OUT (ADDRESS), 5: REM set baudrate to 2400 Bd
    OUT (CTRLADDRESS), CTRLBYTE
    A = INP(STATUSADDRESS): REM dummy read
    CTRLBYTE = CTRLBYTE OR 64: REM reset error bits
    OUT (CTRLADDRESS), CTRLBYTE
    CTRLBYTE = (CTRLBYTE AND (255 - 8 - 16)) OR 38: REM enable communication
    OUT (CTRLADDRESS), CTRLBYTE
360 A = INP(STATUSADDRESS): IF (A AND 128) <> 128 THEN 380
    PRINT A; : A = INP(RXADDRESS): PRINT A: GOTO 360
380 FOR I = 0 TO 255
390 A = INP(STATUSADDRESS): IF (A AND 64) <> 64 THEN 390
    OUT (TXADDRESS), I
410 A = INP(STATUSADDRESS): IF (A AND 128) <> 128 THEN 410
    A = INP(RXADDRESS)
    IF A = I THEN PRINT " "; A; " ";
    IF A <> I THEN PRINT A; " "; I; " error ";
    A$ = INKEY$: IF A$ <> "" THEN END
    NEXT
    GOTO 380













