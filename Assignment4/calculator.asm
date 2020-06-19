;Performs stack-based arithmetic.
; CSC 225, Assignment 4
; Given code, Winter '20

        .ORIG x3000

MAIN    LEA R1, STACK   ; Initialize R1, the stack pointer.

LOOP    LEA R0, PROMPT  ; Print the prompt.
        PUTS
        GETC            ; Read the command into R0.
        OUT

        ; If the command is an 'a'...
IFP     LD  R3, ASCIIA
        ADD R3, R0, R3
        BRnp ELIFM
        ST R7, SAVER7
        JSR POP		;pop top number to add
        LD R7, SAVER7
        AND R5, R5, #0	;clear R5
        ADD R5, R5, R2	;put popped number in R5
        ST R7, SAVER7
        JSR POP		;pop next number to be added
        LD R7, SAVER7
        ADD R5, R5, R2	;adding the two numbers
        AND R2, R2, #0	;clear R2
        ADD R2, R2, R5	;put result of the addition in R2
        ST R7, SAVER7
        JSR PUSH	;push the result to the stack
        LD R7, SAVER7
        BRnzp ENDIF

        ; Else if the command is an 's'...
ELIFM   LD  R3, ASCIIS
        ADD R3, R0, R3
        BRnp ELIFN
        ST R7, SAVER7
        JSR POP		;pop the subtrahend
        LD R7, SAVER7
        AND R5, R5, #0	;clear R5
        ADD R5, R5, R2	;store subtrahend in R5
        NOT R5, R5	;negate subtrahend
        ADD R5, R5, #1
        ST R7, SAVER7
        JSR POP		;pop the minuend
        LD R7, SAVER7
        ADD R5, R5, R2	;perform the "subtraction"
        AND R2, R2, #0	;clear R2
        ADD R2, R2, R5	;put result of subtraction in R2
        ST R7, SAVER7
        JSR PUSH	;push result to the stack
        LD R7, SAVER7
        BRnzp ENDIF

        ; Else if the command is an 'n'...
ELIFN   LD  R3, ASCIIN
        ADD R3, R0, R3
        BRnp ELIFQ
        ST R7, SAVER7
        JSR POP		;pop the number to be negated
        LD R7, SAVER7
        NOT R2, R2	;negate the number
        ADD R2, R2, #1
        ST R7, SAVER7
        JSR PUSH	;push result to the stack
        LD R7, SAVER7
        BRnzp ENDIF

        ; Else if the command is a 'q'...
ELIFQ   LD R3, ASCIIQ
        ADD R3, R0, R3
        BRNP ELSE
        GETC
        OUT
        JSR DONE

        ; Else, assume the command is '#'...
ELSE    
        ST R7, SAVER7
        JSR GETI	;jump to our input subroutine
        LD R7, SAVER7
        ST R7, SAVER7
        JSR OUTI
        LD R7, SAVER7
        AND R2, R2, #0	;clear R2
        ADD R2, R0, R2	;put into R2 our input
        ST R7, SAVER7
        JSR PUSH	;push the result to the stack
        LD R7, SAVER7

ENDIF   GETC            ; Consume the newline.
        OUT
        BRnzp LOOP      ; Loop back.

DONE    LEA R0, RESSTR  ; Pop and print an integer.
        PUTS
        JSR POP	
        ADD R0, R2, #0
        JSR OUTI
        LEA R0, ENDSTR
        PUTS
        HALT            ; Halt.
        
; Space for a stack with capacity 16:
        .BLKW #16
STACK   .FILL x00

; Shared constants:
PROMPT  .STRINGZ "Enter a command (#N/a/s/n/q): "
RESSTR  .STRINGZ "Value on top of the stack: "
ENDSTR  .STRINGZ "\n"
ASCIIA  .FILL x-61
ASCIIS  .FILL x-73
ASCIIN  .FILL x-6E
ASCIIQ  .FILL x-71

; NOTE: Do not alter the following lines. They allow the subroutines in other
;       files to be called without manually calculating their offsets.

PUSH    ST  R7, PSHR7
        LDI R7, PSHADDR
        JSRR R7
        LD  R7, PSHR7
        RET
PSHR7   .FILL x0000
PSHADDR .FILL x4000

POP     ST  R7, POPR7
        LDI R7, POPADDR
        JSRR R7
        LD  R7, POPR7
        RET
POPR7   .FILL x0000
POPADDR .FILL x4001

GETI    ST  R7, GETR7
        LDI R7, GETADDR
        JSRR R7
        LD  R7, GETR7
        RET
GETR7   .FILL x0000
GETADDR .FILL x5000

OUTI    ST  R7, OUTR7
        LDI R7, OUTADDR
        JSRR R7
        LD  R7, OUTR7
        RET
OUTR7   .FILL x0000
OUTADDR .FILL x5001
SAVER7 .FILL x0000

        .END

