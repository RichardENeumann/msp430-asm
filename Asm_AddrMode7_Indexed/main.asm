;--------------------------------------
; Indexed Mode Addressing Demo Program
;--------------------------------------
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

;----------------
; Main loop here
;----------------
main:
			MOV.W	#Block1, R4				; Put the value 2000h into R4

			MOV.W	0(R4),	8(R4)			; Copy 1st word from Block1 into 1st word of Block2
											; (8 = 9th word counting from address pointed at in R4)
			MOV.W	2(R4), 10(R4)			; Copy 2nd word from Block1 into 2nd Word of Block2
			MOV.W	4(R4), 12(R4)			; Copy 3rd word from Block1 into 3rd Word of Block2
			MOV.W	6(R4), 14(R4)			; Copy 4th word from Block1 into 4th Word of Block2

			JMP		main

;------------------
; Memory Allocation
;------------------
			.data							; Go to address 2000h
			.retain

Block1:		.short	0AAAAh, 0BBBBh, 0CCCCh, 0DDDDh	; define alias Block1, put 4 words in a row
Block2:		.space	8								; define alias Block2 as 4 words (8 Bytes) of empty space

;--------------------------
; Stack Pointer definition
;--------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------
; Interrupt Vectors
;-------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
