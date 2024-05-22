;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
init:
			BIC.W	#0001h, &PM5CTL0		; Disable the GPIO power-on default high-Z mode

			BIS.B	#BIT0, &P1DIR			; Set P1.0 as an output. (LED1)
			BIS.B	#BIT6, &P6DIR			; Set P6.6. as an output (LED2)

			BIC.B	#BIT0, &P1OUT			; Set P1.0 to low initially (LED1 off)
			BIS.B	#BIT6, &P6OUT			; Set P6.6 to high initially (LED2 on)
main:
			XOR.B	#BIT0, &P1OUT			; Toggle P1.0 (LED1)
			XOR.B	#BIT6, &P6OUT			; Toggle P6.6 (LED2)

			MOV.W	#0FFFFh, R4				; Put a big number into R4
delay:
			DEC.W	R4						; Decrement R4
			JNZ		delay					; Repeat until R4 is 0

			jmp 	main					; Repeat main loop forever
;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
