.device ATmega328p

.DSEG
    i: .byte 0x00
    maior_v: .byte 0x00
.CSEG

.org 0x00

RJMP INIT

INIT:
     LDI R16, HIGH(RAMEND)
     OUT SPH, R16
     LDI R16, LOW(RAMEND)
     OUT SPL, R16
     RJMP P1

P1:
      LDI R30, LOW(ARRAY << 1)
      LDI R31, HIGH(ARRAY << 1)

      LDI R16, 0x05; tamanho array - 1
      LDI R17, 0x00; i'
      LDI R18, 0x00; maior_v

      LPM R18, Z; lê o que está na posição Z

      PROCURA:
              CP R17, R16
              BREQ LOOP
              INC R30
              INC R17
              LPM R19, Z; lê o que está na posição Z

              CP R19, R18
              BRLO PROCURA

              MOV R18, R19; carrega valor
              RJMP PROCURA




LOOP: RJMP LOOP

ARRAY: .db 0x01, 0x02, 0x05, 0x04, 0x03, 0x00
