.device ATmega328p
.org 0x00

RJMP INIT

INIT:
     LDI R16, HIGH(RAMEND)
     OUT SPH, R16
     LDI R16, LOW(RAMEND)
     OUT SPL, R16
     RJMP P2

VER:
    LDI R31, 0x01
    LDI R30, 0x00
    CP R18, R31
    BRNE FIB


ONE:
     LDI R21, 0x01
     RJMP LOOP

FIB:
     LDI R20, 0x00; xn
     ADD R20, R16
     ADD R20, R17
     MOV R17, R16; x-2
     MOV R16, R20; x-1

     INC R19
     CP R19, R18
     BRNE FIB
     MOV R21, R16
     RET

P1:
     LDI R16, 0x01; x0
     LDI R17, 0x01; x1
     LDI R18, 0x00; n
     LDI R19, 0x01; i
     LDI R31, 0x01; IF ELSE
     LDI R30, 0x00; IF ELSE

     CP R18, R31
     BRNE IF2
     CALL ONE

     IF2:
         CP R18, R30
         BREQ ONE
         CALL FIB

P2:


LOOP: RJMP LOOP
