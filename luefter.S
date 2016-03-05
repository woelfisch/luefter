; luefter.S - multi-mode fan controller for fursuit heads
; Copyright (C) 2016, by Joerg Reuter <jreuter@yaina.de>
;
; This program is free software; you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation; either version 2 of the License, or
; (at your option) any later version.
; 
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
; 
; You should have received a copy of the GNU General Public License along
; with this program; if not, write to the Free Software Foundation, Inc.,
; 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
;

#include <avr/io.h>

; Written for and tested on an ATTiny45
; 
; PB0: OCOA / PWM0 out	- Pin 5
; PB1: 0C0B / PWM1 out	- Pin 6
; PB2: INT0 / Switch	- Pin 7
; PB3: (LED)		- Pin 2
; PB4: ADC2 / Temp	- Pin 3
; PB5: -RESET		- Pin 1

.equ IV_TABLE,		0x00
.equ MAIN,		0x1e

.equ STATE_OFF,		0
.equ STATE_AUTO,	(STATE_OFF+1)
.equ STATE_STARTUP,	(STATE_AUTO+1)
.equ STATE_LOW,		(STATE_STARTUP+1)
.equ STATE_MEDIUM,	(STATE_LOW+1)
.equ STATE_HIGH,	(STATE_MEDIUM+1)
.equ STATE_MAX,		STATE_HIGH
.equ STATE_SELFTEST,	255

.equ PWM_OFF,		0
.equ PWM_LOW,		160
.equ PWM_MEDIUM,	208
.equ PWM_HIGH,		255

; prescaler valuse:
;
; 0 0 0  off
; 0 0 1    1
; 0 1 0    8
; 0 1 1   64
; 1 0 0  256
; 1 0 1 1024
;
; on: prescale 256 on both channels(f = 15 Hz)
.equ PWM_CLOCK_OFF,	0
.equ PWM_CLOCK_MODE,	(1<<CS02)|(0<<CS01)|(0<<CS00)|(0<<WGM02)

; on: non-inverting PWM mode on OC0A and OC0B
.equ PWM_MODE_OFF,	0
.equ PWM_MODE_OP,	(1<<COM0A1)|(0<<COM0A0)|(1<<COM0B1)|(0<<COM0B0)|(1<<WGM01)|(1<<WGM00)


.equ THRES_MOTOR_OFF,	112	/* 28 °C */
.equ THRES_MOTOR_ON,	120	/* 30 °C */
.equ ADC_OFFSET,	65	/* 16 °C */


.equ T_SELFTEST, 7	/* 4 sec */

/* registers */
.equ key_pressed,	 8
.equ led,		 9
.equ state,		16
.equ pwm,		17
.equ st_count,		18
.equ sreg_save,		19
.equ adc,		20
.equ val,		21
.equ led_mask,		22
.equ ioval,		25

.macro disable_wdt 
	wdr
	ldi	ioval, (0<<WDRF)
	out	_SFR_IO_ADDR(MCUSR), ioval
	in	ioval, _SFR_IO_ADDR(WDTCR)
	ori	ioval,	(1<<WDCE)|(1<<WDE)
	out	_SFR_IO_ADDR(WDTCR), ioval
	ldi	ioval, (0<<WDE)
	out	_SFR_IO_ADDR(WDTCR), ioval
.endm

.macro enable_wdt
	wdr
	/* setup interrupt on watchdog timeout after 500 msec */
	ldi	ioval, (1<<WDIE)|(1<<WDP2)|(1<<WDP0)
	out	_SFR_IO_ADDR(WDTCR), ioval
.endm

.macro set_idle_mode
	in	ioval, _SFR_IO_ADDR(MCUCR)
	andi	ioval, ~((1<<SM1)|(1<<SM0))
	ori	ioval, (1<<SE)
	out	_SFR_IO_ADDR(MCUCR), ioval
.endm

.macro set_powerdown_mode
	in	ioval, _SFR_IO_ADDR(MCUCR)
	ori	ioval, (1<<SM1)|(1<<SM0)
	out	_SFR_IO_ADDR(MCUCR), ioval
.endm

.macro set_pwm
	; set PWM speed
	out	_SFR_IO_ADDR(OCR0A), pwm
	out	_SFR_IO_ADDR(OCR0B), pwm

	cpi	pwm, PWM_OFF
	brne	1f

	; turn off PWM
	ldi	ioval, PWM_CLOCK_OFF
	out	_SFR_IO_ADDR(TCCR0B), ioval
	ldi 	ioval, PWM_MODE_OFF
	out	_SFR_IO_ADDR(TCCR0A), ioval

	; set output bits to 0
	in	ioval, _SFR_IO_ADDR(PORTB)
	andi	ioval, ~(1<<PORTB0)|(1<<PORTB1)
	out	_SFR_IO_ADDR(PORTB), ioval
	rjmp	2f

1:
	; turn on PWM 
	ldi 	ioval, PWM_MODE_OP
	out	_SFR_IO_ADDR(TCCR0A), ioval
	ldi	ioval, PWM_CLOCK_MODE
	out	_SFR_IO_ADDR(TCCR0B), ioval
2:
.endm

.macro toggle_led
	eor	led, led_mask
	out	_SFR_IO_ADDR(PORTB), led
.endm
	.text

	.org IV_TABLE
	rjmp main	; 1
	rjmp INT0_vect	; 2
	reti		; 3
	reti		; 4
	reti		; 5
	reti		; 6
	reti		; 7
	reti		; 8
	reti		; 9
	reti		; 10
	reti		; 11
	reti		; 12
	rjmp WDT_vect	; 13
	reti		; 14
	reti		; 15

	.org	MAIN

	.global main
main:
	; clear SREG (disables interrupts, too)
	eor	r8, r8
	out	_SFR_IO_ADDR(SREG), r8
	; set stack
	ldi	ioval, (XRAMEND & 0xff)
	out	_SFR_IO_ADDR(SPL), ioval
#ifdef SPH
	ldi	ioval, (XRAMEND >> 8)
	out	_SFR_IO_ADDR(SPH), ioval
#endif
	; disable watchdog timer
	disable_wdt
	; set initial state
	ldi	state, STATE_SELFTEST
	ldi	pwm, PWM_HIGH

	ldi	led_mask, (1<<PORTB3)
	eor	led, led

	; sleep with interrupts enabled
	set_idle_mode 

	; output for PWM
	ldi	ioval, (1<<DDB0)|(1<<DDB1)  |(1<<DDB3)
	out	_SFR_IO_ADDR(DDRB), ioval

	; pull up input for switch pin
	ldi	ioval, (1<<PORTB2)
	out	_SFR_IO_ADDR(PORTB), ioval
	; interrupt on low
	in	ioval, _SFR_IO_ADDR(MCUCR)
	andi	ioval, ~((1<<ISC01)|(1<<ISC00))
	ori	ioval, (1<<ISC01)|(1<<ISC00)
	out	_SFR_IO_ADDR(MCUCR), ioval
	; enable INT0 interrupt
	ldi	ioval, (1<<INT0)
	out	_SFR_IO_ADDR(GIMSK), ioval

	; 2.56V ref w/o capacitor
	ldi	ioval, (1<<REFS2)|(1<<REFS1)|(0<<REFS0)|(0<<MUX3)|(0<<MUX2)|(1<<MUX1)|(0<<MUX0)
	out	_SFR_IO_ADDR(ADMUX), ioval
	; free running
	ldi	ioval, (0<<ADTS2)|(0<<ADTS1)|(0<<ADTS0)
	out	_SFR_IO_ADDR(ADCSRB), ioval
	; enable and start
	ldi	ioval, (1<<ADEN)|(1<<ADSC)
	out	_SFR_IO_ADDR(ADCSRA), ioval

	; set PWM
	set_pwm

	; start selftest
	ldi	st_count, T_SELFTEST
	sei
	enable_wdt

	toggle_led

loop:
	sleep
	rjmp	loop


; key press interrupt
	.global INT0_vect
INT0_vect:
	in	sreg_save, _SFR_IO_ADDR(SREG)

	; ignore while self test
	cpi	state, STATE_SELFTEST
	breq	int0_out

	; waiting for key press processing?
	or	key_pressed, key_pressed
	brne	int0_out

	toggle_led

	; set key pressed flag
	inc	key_pressed

int0_wakup:
	cpi	state, STATE_OFF
	brne	int0_next_state
	enable_wdt
	set_idle_mode

int0_next_state:
	cpi	state, STATE_MAX
	brne	int0_startup
	ldi	state, STATE_OFF
	wdr
	rjmp	int0_out

int0_startup:
	cpi	state, STATE_STARTUP
	brne	int0_inc
	inc	state

int0_inc:
	inc	state
	wdr

int0_out:
	out	_SFR_IO_ADDR(SREG), sreg_save
	reti

; watchdog timeout
	.global WDT_vect
WDT_vect:
	in	sreg_save, _SFR_IO_ADDR(SREG)

	toggle_led

	; key pressed?
	or	key_pressed, key_pressed
	breq	process_mode_auto	
	eor	key_pressed, key_pressed

	cpi	state, STATE_OFF
	brne	process_key_low
	; power down
	disable_wdt
	set_powerdown_mode
	ldi	pwm, PWM_OFF
	rjmp	wdt_set_pwm

process_key_low:
	cpi	state, STATE_STARTUP
	brne	process_key_medium
	; set fan to low speed
	ldi	pwm, PWM_HIGH
	rjmp	wdt_set_pwm

process_key_medium:
	cpi	state, STATE_MEDIUM
	brne	process_key_high
	; set fan to medium speed
	ldi	pwm, PWM_MEDIUM
	rjmp	wdt_set_pwm

process_key_high:
	cpi	state, STATE_HIGH
	brne	process_mode_auto
	; set fan to high speed
	ldi	pwm, PWM_HIGH
	rjmp	wdt_set_pwm

process_mode_auto:
	cpi	state, STATE_AUTO
	brne	process_mode_selftest

	; fan speed ccontrolled by temperature
	; result should be in the range of 0..160
	in	adc, _SFR_IO_ADDR(ADCL)
	in	ioval, _SFR_IO_ADDR(ADCH)
	; set to max speed if larger
	cpi	ioval, 0
	breq	wdt_cont1
	ldi	pwm, PWM_HIGH
	rjmp	wdt_set_pwm

wdt_cont1:
	; switch off motor if adc < THRES_MOTOR_OFF
	cpi	adc, THRES_MOTOR_OFF
	brcc	wdt_cont2
	ldi	pwm, PWM_OFF
	rjmp	wdt_set_pwm

wdt_cont2:
	; motor off?
	cpi	pwm, PWM_OFF
	brne	wdt_cont3
	; threshold reached?
	cpi	adc, THRES_MOTOR_ON
	brcc	wdt_cont3
	rjmp	wdt_out

wdt_cont3:
	; substract offset 
	mov	val, adc
	subi	val, ADC_OFFSET
	; paranoia: avoid negative values
	brcc	wdt_cont4
	ldi	val, 0

wdt_cont4:
	; pwm = 2 * val, clamp to PWM_HIGH if overflow
	mov	pwm, val
	add	pwm, val
	brcc	wdt_cont5
	ldi	pwm, PWM_HIGH
	rjmp	wdt_set_pwm

wdt_cont5:
	; pwm += val, clamp to PWM_HIGH if overflow
	add	pwm, val
	brcc	wdt_set_pwm
	ldi	pwm, PWM_HIGH
	
	; set motor speed
wdt_set_pwm:
	set_pwm
	rjmp	wdt_out

process_mode_selftest:
	cpi	state, STATE_SELFTEST
	brne	process_mode_startup

	; self test on start: set both fans for 4 seconds to high speed
	dec	st_count
	brne	wdt_out
	; finally, go to automatic mode 
	ldi	state, STATE_AUTO
	rjmp	wdt_out

process_mode_startup:
	cpi	state, STATE_STARTUP
	brne	wdt_out
	ldi	state, STATE_LOW
	ldi	pwm, PWM_LOW
	rjmp	wdt_set_pwm

wdt_out:
	out	_SFR_IO_ADDR(SREG), sreg_save
	reti

