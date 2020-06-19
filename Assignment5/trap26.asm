;upports interrupt-driven keyboard input.
; CSC 225, Assignment 5
; Given code, Winter '20

        .ORIG x300
        

; Reads one character, executing a second program while waiting for input:
;  1. Saves the keyboard entry in the IVT.
;  2. Sets the keyboard entry in the IVT to ISR180.
;  3. Enables keyboard interrupts.
;  4. Returns to the second program.
; NOTE: The first program's state must be swapped with the second's.
TRAP26 ; TODO: Implement this service routine.
ST R1, P1R1
ST R2, P1R2
LDR R1, R6, #0
ST R1, P1PC
LDR R2, R6, #1
ST R2, P1PSR
ST R3, P1R3
ST R4, P1R4
ST R5, P1R5
ST R7, P1R7
LD R1, KBIV
LDR R2, R1, #0
ST R2, SAVEIV
LEA R2, ISR180
STI R2, KBIV
LDI R1, KBSR
LD R2, KBIMASK
NOT R1, R1
NOT R2, R2
AND R3, R2, R1
NOT R3, R3
STI R3, KBSR
LD R0, PCSTACK
LD R1, P2PC
LD R2, P2PSR
STR R1, R0, #0
STR R2, R0, #1
LD R0, P2R0
LD R1, P2R1
LD R2, P2R2
LD R3, P2R3
LD R4, P2R4
LD R5, P2R5
LD R7, P2PC
JMP R7



; Responds to a keyboard interrupt:
;  1. Disables keyboard interrupts.
;  2. Restores the keyboard entry in the IVT.
;  3. Places the typed character in R0.
;  4. Returns to the caller of TRAP26.
; NOTE: The second program's state must be swapped with the first's.
ISR180  ; TODO: Implement this service routine.
ST R1, P2R1
ST R2, P2R2
LDR R1, R6, #0
ST R1, P2PC
LDR R2, R6, #1
ST R2, P2PSR
ST R3, P2R3
ST R4, P2R4
ST R5, P2R5
ST R7, P2R7
LDI R0, KBDR
AND R2, R2, #0
STI R2, KBSR
LD R3, P1PC
STR R3, R6, #0
LD R7, PCSTACK
LD R1, P1PC
LD R2, P1PSR
STR R1, R7, #0
STR R2, R7, #1
LD R4, KBIV
LD R5, SAVEIV
STR R5, R4, #0
LD R1, P1R1
LD R2, P1R2
LD R3, P1R3
LD R4, P1R4
LD R5, P1R5
LD R7, P1R7
RTI


; Program 1's data:
P1R1    .FILL x0000     ; TODO: Save the first program's state here.
P1R2    .FILL x0000
P1R3    .FILL x0000
P1R4    .FILL x0000
P1R5    .FILL x0000
P1R7    .FILL x0000
P1PC    .FILL x0000
P1PSR   .FILL x0000

; Program 2's data:
P2R0    .FILL x0000     ; TODO: Save the second program's state here.
P2R1    .FILL x0000
P2R2    .FILL x0000
P2R3    .FILL x0000
P2R4    .FILL x0000
P2R5    .FILL x0000
P2R7    .FILL x0000
P2PC    .FILL x4000     ; Initially, Program 2's PC is 0x4000.
P2PSR   .FILL x8002     ; Initially, Program 2 is unprivileged.

; Shared data:
SAVEIV  .FILL x0000     ; TODO: Save the keyboard's IVT entry here.

; Shared constants:
KBIV    .FILL x0180     ; The keyboard's interrupt vector
KBSR    .FILL xFE00     ; The Keyboard Status Register
KBDR    .FILL xFE02     ; The Keyboard Data Register
KBIMASK .FILL x4000     ; The keyboard interrupt bit's mask
PCSTACK .FILL x2FFE
        .END
