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


;-----------
; main loop
;-----------
main:
         MOV		#0, R4
         INC		R4
         INC 		R4
         INCD		R4
         INCD		R4

         DEC		R4
         DEC		R4
         DECD		R4
         DECD		R4

         MOV		#Consts, R5

         MOV.B		@R5, R6
         INC		R5

         MOV.B		@R5, R7
         INC		R5

         MOV		@R5, R8
         INCD		R5

         MOV		@R5, R9

         JMP		main

;--------
; malloc
;--------
		.data
		.retain

Consts:	.short		1234h
		.short		5678h
		.short		9ABCh

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
            
