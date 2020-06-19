; Implements integer I/O utilities.
; CSC 225, Assignment 4
; Given code, Winter '20

        .ORIG x5000     ; NOTE: Do not alter these addresses. They are
        .FILL GETI      ;       hardcoded within "calculator.asm", since the
        .FILL OUTI      ;       assembler cannot resolve cross-file labels.

; Reads one integer in the range {-9, ..., 9}.
;  Takes no arguments.
;  Returns the read integer in R0.
GETI    ST R2, SAVER2			;save the registers used in this routine
        ST R3, SAVER3
        ST R6, SAVER6
        AND R6, R6, #0			;clear R6 so it can be used as a counter
        LOOP    GETC			;prompts for user input
                LD R2, ASCII_HYPHEN	;ASCII num for hyphen char
                ADD R6, R6, #1		;incrememnt counter
                ADD R2, R2, R0		;check if the input is a hyphen
                BRz LOOP		;if input isnt a hyphen loop back
        LD R3, ASCII_TO_INT
        ADD R6, R6, #-2
        BRnp ELSE			;check if our counter from loop is 2
        ADD R0, R0, R3			;turn ASCII val to int
        NOT R0, R0			;negate our int
        ADD R0, R0, #1			;add 1 to int, turns our int to negative
        BRnzp DONE
        ELSE    ADD R0, R0, R3		;turn our ASCII val to int
                BRnzp DONE
        DONE    LD R2, SAVER2		;restore all registers used 
                LD R3, SAVER3
                LD R6, SAVER6
                RET			;return to main
                        

; Prints one integer in the range {-9, ..., 9}.
;  Takes the integer in R0.
;  Returns no values.
OUTI    ST R2, SAVER2_2		;save all registers used in subroutine
        ST R3, SAVER3_2
	ST R4, SAVER4
        AND R4, R4, #0
        ADD R4, R0, R4
        ADD R0, R0, #0		;touch R0
        BRzp DONE3		;if our int is >= 0, skip to DONE3
        NOT R0, R0		;next 5 instructions change our int to negative
        ADD R0, R0, #1
        AND R3, R3, #0
        ADD R3, R0, R3
        AND R0, R0, #0
        LD R2, ASCII_HYPHEN_POS
        ADD R0, R0, R2		;put hyphen ASCII val in R0
        OUT			;print out hyphen char
        AND R0, R0, #0		;clear R0
        ADD R0, R0, R3		;put our int in R0
        LD R2, ASCII_TO_INT_POS
        ADD R0, R0, R2		;change ASCII val to int
        OUT			;print out our int
        BRnzp DONE2             ;jump to end of loop
        DONE3   LD R2, ASCII_TO_INT_POS
                ADD R0, R0, R2	;change ASCII val to int
                OUT		;print out our int
        DONE2   AND R0, R0, #0
                ADD R0, R4, R0
                LD R2, SAVER2_2	;restore registers
                LD R3, SAVER3_2
                LD R4, SAVER4
                RET		;return to main
                
SAVER2 .FILL x0000
SAVER3 .FILL x0000
SAVER2_2 .FILL x0000
SAVER3_2 .FILL x0000
SAVER4 .FILL x0000
SAVER6 .FILL x0000
ASCII_TO_INT .FILL xFFD0
ASCII_HYPHEN .FILL xFFD3
ASCII_HYPHEN_POS .FILL x002D
ASCII_TO_INT_POS .FILL x0030

        .END
