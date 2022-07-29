.device ATmega328p
.org 0x00

.macro InitializeStack
	ldi R16, HIGH(RAMEND)
	out SPH, R16
	ldi R16, LOW(RAMEND)
	out SPL, R16
.endmacro

rjmp Main

Delay:
	; save R22, R23 and R24 to Stack
	push R22
	push R23
	push R24

	; max counter
	ldi R21, 0xA0

	; initialize delay counters
	LDI R22, 0x00
	LDI R23, 0x00
	LDI R24, 0x00

	; initializes first delay
	first_delay:
		inc R22
		; initializes second delay
		second_delay:
			inc R23
			; initializes third delay
			third_delay:
				inc R24
				cp R24, R21
				brne third_delay ; if third delay counter R24 is different from max counter R21 repeat
				ldi R24, 0x00 ; else reset third delay counter R24

			cp R23, R21
			brne second_delay ; if second delay counter R23 is different from max counter R21 repeat
			ldi R23, 0x00 ; else reset second delay counter R23

		cp R22, R21
		brne first_delay ; if first delay counter R22 is different from max counter R21 repeat
		ldi R22, 0x00 ; else reset second delay counter R22

	; retrieve R23 and R24 to Stack
	pop R24
	pop R23
	pop R22

	ret

ToggleLed:
	out PORTB, R19
	call Delay
	ret

TurnOnLed:
	mov R19, R18
	call ToggleLed
	ret

TurnOffLed:
	mov R19, R17
	call ToggleLed
	ret

Blink:
	cp R19, R18 ; Check if LED State R19 is on
	breq TO ; if on, turn it off
	call TurnOnLed ; else turn it on 
	rjmp Blink
	TO:
		call TurnOffLed
	rjmp Blink

Main:
	InitializeStack
	ldi R16, 0b00100000 ; Only 5-th bit is input (right to left starting with zero)
	ldi R17, 0x00 ; LED off
	ldi R18, 0xFF ; LED on
	mov R19, R17 ; Initializes LED state R19 as off

	; Configure port B
	out DDRB, R16
	; Write to port B
	out PORTB, R19

	rjmp Blink



Loop: rjmp Loop


