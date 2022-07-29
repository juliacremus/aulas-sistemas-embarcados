
.device ATmega328p

.DSEG
    po1: .byte 0x00
    maior_v: .byte 0x00
.CSEG

.org 0x00

RJMP INIT

TOMEM:


INIT:
     LDI R16, HIGH(RAMEND)
     OUT SPH, R16
     LDI R16, LOW(RAMEND)
     OUT SPL, R16
     RJMP P1

P1:
     LDI R30, LOW(ARRAY << 1)
     LDI R31, HIGH(ARRAY << 1)

     LDI R16, 0x05;
     LDI R17, 0x00;
     LPM R18, Z

     LDI R26, 0x00
     LDI R27, 0x01

     ST X, R18

     LE:
        CP R17, R16
        BREQ LOOP
        INC R30
        INC R17
        INC R26
        LPM R18, Z; lê o que está na posição Z

        ST X, R18
        RJMP LE

LOOP: RJMP LOOP

ARRAY: .db 0x01, 0x02, 0x05, 0x04, 0x03, 0x00
