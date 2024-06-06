;-------------------------------------------------------------------------------
; ALU Logic Exercise
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
main:
			MOV.B	#10101010b, R4
			INV.B	R4						; Invert Bits

			MOV.B	#11110000b, R5
			AND.B	#00111111b, R5			; Clear bits marked 0 in mask

			MOV.B	#00010000b, R6
			AND.B	#10000000b, R6			; Test if Bit7 is a 1, Z=1 -> no

			MOV.B	#00010000b, R7
			AND.B	#00010000b, R7			; Test if Bit4 is a 1, Z=0 -> yes

			MOV.B	#11000001b, R8
			OR.B	#00011111b, R8			; Set Bits5-0 as 1

			MOV.B	#01010101b, R9
			XOR.B	#11110000b, R9			; Invert Bits7-4
			XOR.B	#00001111b, R9			; Invert Bits3-0

			JMP		main

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
            
