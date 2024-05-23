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
			MOV.W	#Block1, R4				; put value 2000h into R4 to be used as pointer

			MOV.W	@R4+, R5				; put value at 2000h into R5, R4+2
			MOV.W	@R4+, R6				; put value at 2002h into R6, R4+2
			MOV.W	@R4+, R7				; put value at 2004h into R7, R4+2

			MOV.B	@R4+, R8				; put value at 2006h into R8, R4+1
			MOV.B	@R4+, R9				; put value at 2007h into R9, R4+1
			MOV.B	@R4+, R10				; put value at 2008h into R10, R4+1

			JMP		main

;------------------
; Memory Allocation
;------------------
			.data							: goto data section of memory (2000h)
			.retain
Block1:		.short	1122h, 3344h, 5566h, 7788h, 99AAh

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
            
