.device ATmega328p
.org 0x00

RJMP INIT

INIT:
     LDI R16, HIGH(RAMEND)
     OUT SPH, R16
     LDI R16, LOW(RAMEND)
     OUT SPL, R16
     RJMP SUB1

SR_THIRD_DELAY:
         INC R24

         CP R24, R21
         BRNE SR_THIRD_DELAY
         LDI R24, 0x00
         RET

SR_SECOND_DELAY:
         INC R23

         CALL SR_THIRD_DELAY

         CP R23, R21
         BRNE SR_SECOND_DELAY
         LDI R23, 0x00
         RET

SR_DELAY:
         INC R22

         CALL SR_SECOND_DELAY

         CP R22, R21
         BRNE SR_DELAY
         LDI R22, 0x00
         RET

SR_TOGGLE_LED:
           OUT PORTB, R19

           CALL SR_DELAY
           RET

SR_TURN_ON:
        MOV R19, R18
        CALL SR_TOGGLE_LED
        RET

SR_TURN_OFF:
        MOV R19, R17
        CALL SR_TOGGLE_LED
        RET

PISCA_LED:
          CP R19, R18; VERIFICA SE LIGADO
          BREQ TO
          CALL SR_TURN_ON
          RJMP PISCA_LED
          TO:
             CALL SR_TURN_OFF
          RJMP PISCA_LED

SUB1:
     LDI R16, 0x20; pino 5
     LDI R17, 0x00; pino 5 desligado
     LDI R18, 0x20; pinqo 5 ligado
     MOV R19, R17; seta o primeiro estado como desligado

     LDI R21, 0xFF; tempo de delay

     ; contadores de delay
     LDI R24, 0x00
     LDI R23, 0x00
     LDI R22, 0x00

     ; configura porta 13 como saída (apenas escrita)
     OUT DDRB, R16
     OUT PORTB, R19

     RJMP PISCA_LED



LOOP: RJMP LOOP
