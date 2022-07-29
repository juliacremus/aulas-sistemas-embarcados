.device ATmega328p
.org 0x00

RJMP INIT

INIT:
     LDI R16, HIGH(RAMEND)
     OUT SPH, R16
     LDI R16, LOW(RAMEND)
     OUT SPL, R16
     RJMP P3

SOMA:
     ADD R16, R17
     RET

P1:
     LDI R16, 0x01
     LDI R17, 0x10
     CALL SOMA
     LDI R18, 0x01

POTENCIA:
     LSL R17

     INC R19
     CP R19, R16
     BREQ POTENCIA
     RET


P2:
   LDI R16, 0x02; n
   LDI R17, 0x01; 2^n
   LDI R18, 0x03; x
   LDI R19, 0x01; i = 1
   CALL POTENCIA
   MUL R18, R17

DIVI:
     LSR R18

     INC R19
     CP R19, R16
     BRNE DIVI
     RET

P3:
   LDI R16, 0x04; n
   LDI R18, 0x80; x
   LDI R19, 0x01; i = 1
   CALL DIVI



LOOP:	rjmp LOOP

