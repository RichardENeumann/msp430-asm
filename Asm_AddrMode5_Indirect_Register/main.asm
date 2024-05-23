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
			MOV.W	#2000h, R4				; put #2000h into R4 to be used as address
			MOV.W	@R4, R5					; copy the contents located at the address held
											; at R4 into R5

			MOV.W	#Const2, R6				; put absolute address of label Const2 into R6
			MOV.W	@R6, R7					; copy the contents located at the address held
											; at R6 into R7
                                            
			JMP		main
;-------------------------------------------------------------------------------
; Memory Allocation
;-------------------------------------------------------------------------------
			.data							; go to data memory (2000h)
			.retain							; keep this section, even if not used

Const1:		.short	0DEADh					; init first word to 0DEADh
Const2:		.short	0BEEFh					; init second word to 0BEEFh

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
            
