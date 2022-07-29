.device ATmega328p
.org 0x00

RJMP INIT

INIT:
     LDI R16, HIGH(RAMEND)
     OUT SPH, R16
     LDI R16, LOW(RAMEND)
     OUT SPL, R16
     RJMP SUB1

THIRD_DELAY:

      INC R24;

      CP R21, R24
      BREQ PISCA_LED
      RJMP THIRD_DELAY


SECOND_DELAY:
      INC R23;

      CP R21, R23
      BREQ THIRD_DELAY
      RJMP SECOND_DELAY

DELAY:

      INC R22;

      CP R21, R22
      BREQ SECOND_DELAY
      RJMP DELAY


TURN_ON:

        OUT DDRB, R16;
        OUT PORTB, R16;

        ; reinicia os contadores do loop
        LDI R23, 0x00
        LDI R22, 0x00
        LDI R24, 0x00

        RJMP DELAY


TURN_OFF:

         OUT DDRB, R17;
         OUT PORTB, R17;

         LDI R23, 0x00
         LDI R22, 0x00
         LDI R24, 0x00

         RJMP DELAY

PISCA_LED:

          IN R19, PINB; lê o estado atual
          CP R19, R16
          BREQ TURN_OFF
          RJMP TURN_ON

SUB1:
     LDI R16, 0x20; pino 5 ligado
     LDI R17, 0x00; pinos desligados

     LDI R19, 0x00; conterá o estado atual do LED

     LDI R21, 0xAA; tempo de delay
     LDI R22, 0x00; contador do delay
     LDI R23, 0x00; contador do delay
     LDI R24, 0x00; contador do delay


     ; Configuração inicial do LED

     RJMP TURN_ON

     RJMP LOOP



LOOP: RJMP LOOP


