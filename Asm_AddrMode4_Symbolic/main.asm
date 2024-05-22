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
main:
			MOV.W	Const1, R4				; Copy contents from address 2000h into R4
			MOV.W	R4, &2004h				; Copy contents from R4 into address 2004h

			MOV.W	Const2, R5				; Copy contents from address 2002h into R5
			MOV.W	R5, &2006h				; Copy contents from R5 into address 2006h

			JMP		main

;-------------------------------------------------------------------------------
; Memorly Allocation
;-------------------------------------------------------------------------------
			.data							; goto data memory (2000h)
			.retain							; keep this section, even if not used
											; (could otherwise be removed by optimizer)

Const1:		.short	1234h					; init 1st word to 1234h
Const2:		.short	0CAFEh					; init 2nd word to CAFEh

Var1:		.space	2						; reserve 3rd word
Var2:		.space	2						; reserve 4th word

                                            

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
            
