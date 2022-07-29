.device ATmega328p
.org 0x00

RJMP INIT

INIT:
     LDI R16, HIGH(RAMEND)
     OUT SPH, R16
     LDI R16, LOW(RAMEND)
     OUT SPL, R16
     RJMP SUB1


SECOND_DELAY:
      INC R23;

      CP R21, R23
      BREQ PISCA_LED
      RJMP SECOND_DELAY

DELAY:

      INC R22;

      CP R21, R22
      BREQ PISCA_LED
      RJMP DELAY


TURN_ON:

        ;OUT DDRB, R16;
        ;OUT PORTB, R16;

        MOV R18, R16

        ; reinicia os contadores do loop
        LDI R23, 0x00
        LDI R22, 0x00

        RJMP DELAY


TURN_OFF:

         ;OUT DDRB, R20;
         ;OUT PORTB, R20;

         MOV R18, R20

         LDI R23, 0x00
         LDI R22, 0x00

         RJMP DELAY

PISCA_LED:

          IN R19, PINB; lê o estado atual
          CP R18, R16
          BREQ TURN_OFF
          CALL TURN_ON

SUB1:
     LDI R16, 0x20; pino 5 ligado
     LDI R17, 0x00; pinos desligados

     LDI R18, 0x00; "LED" de simulate

     LDI R19, 0x00; conterá o estado atual do LED

     LDI R21, 0x03; tempo de delay
     LDI R22, 0x00; contador do delay
     LDI R23, 0x00; contador do delay

     ; Configuração inicial do LED

     CALL TURN_ON

     RJMP LOOP



LOOP: RJMP LOOP


