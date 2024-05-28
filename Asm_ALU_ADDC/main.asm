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


;----------------
; Main loop here
;----------------
main:
			MOV		#Var1, R4
			MOV		#Var2, R5
			MOV		#Sum12, R6

			MOV		0(R4), R7
			MOV		0(R5), R8
			ADD		R7, R8
			MOV		R8,	0(R6)

			MOV		2(R4), R7
			MOV		2(R5), R8
			ADDC	R7, R8
			MOV		R8, 2(R6)

			JMP		main

;-------------------
; Memory Allocation
;-------------------
			.data
			.retain

Var1:		.long	0E371FFFFh
Var2:		.long	11112222h

Sum12:		.space	4

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
            
