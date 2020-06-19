; Encrypts a string using a Caesar cipher.
; CSC 225, Assignment 3
; Given code, Winter '20

; TODO: Complete this program.

.ORIG x3000
LEA R0, KEY             ;places KEY Address into R0
PUTS                    ;write KEY message to terminal
LEA R4, KEY_STRING
LOOP4 GETC
      OUT                   ;writes user input to terminal
      STR R0, R4, #0
      ADD R4, R4, #1
      ADD R0, R0, #-10
      BRnp LOOP4
     

LEA R0, STRING_PROMPT   ;place STRING_PROMPT address into R0
PUTS                    ;writes STRING_PROMPT to terminal
LEA R4, INPUT_STRING    ;place INPUT_STRING address into R4
LOOP GETC               ;prompts for user input
     OUT                ;writes user input to terminal
     STR R0, R4, #0     ;store address in R0 to R4
     ADD R4, R4, #1     ;incrememnt address
     ADD R0, R0, #-10   ;schecks if the next value in the string is the enter key
     BRnp LOOP          ;loop back if our next char isnt the enter key
     
LEA R5, KEY_STRING 
LD R3, ASCII_TO_INT
LDR R5, R5, #0
ADD R5, R5, R3

LEA R4, INPUT_STRING    ;place INPUT_STRING address into R4
LOOP2 LDR R2, R4, #0    ;load into R2, value at address in R4
      ADD R2, R5, R2    ;here we're adding value of our input string with the encryption key
      STR R2, R4, #0    ;store value of R2, into address in R4
      ADD R4, R4, #1    ;incrememnt the address
      LDR R6, R4, #0    ;copy value to R6
      ADD R6, R6, #-10  ;checks if the next value in the string is the enter key
      BRnp LOOP2        ;loop back if our next char isnt the enter key

LEA R0, ENCRYPTED_PROMPT ;place ENCRYPTED_PROMPT address into R0
PUTS                     ;write ENCRYPTED_PROMPT to terminal
LEA R4, INPUT_STRING     ;place address of INPUT_STRING into R4
LOOP3 LDR R0, R4, #0     ;load into R0, value at address in R4
      OUT                ;print out char in R0 to terminal
      ADD R4, R4, #1     ;incrememnt address
      AND R6, R6, #0     ;clear R6
      LDR R6, R4, #0     ;load into R6, value at address in R4
      ADD R6, R6, #-10   ;checks if the next value in the string is the enter key
      BRnp LOOP3         ;loop back if our next char isnt the enter key


HALT
ASCII_TO_INT .FILL xFFD0
KEY .STRINGZ "Encryption key (0-9): "
STRING_PROMPT .STRINGZ "Unencrypted String: "
ENCRYPTED_PROMPT .STRINGZ "Encrypted String: "
INPUT_STRING .BLKW #32
KEY_STRING .BLKW #2
.END
