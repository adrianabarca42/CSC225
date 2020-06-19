.ORIG x4000

; int fib(int)
; TODO: Implement this function.
FIBFN

    ADD R6, R6, #-1     ;push space for return value
    ADD R6, R6, #-1     ;push space for return address
    STR R7, R6, #0      
    ADD R6, R6, #-1     ;push dynamic link
    STR R5, R6, #0
    ADD R5, R6, #-1     ;set the frame pointer
    ADD R6, R6, #-1     ;push space for 'a'
    ADD R6, R6, #-1     ;push space for 'b'
    
    IFNZ                ;if n <= 0
    LDR R0, R5, #4      ;load into R0 'n'
    BRp ELIF
    AND R0, R0, #0
    BRnzp FIBFN_FIN
    
    ELIF                ;if n == 1
    AND R1, R1, #0
    ADD R1, R1, #-1
    ADD R0, R0, R1
    BRnp ELSE
    ADD R0, R0, #1      ;set return value to 1
    BRnzp FIBFN_FIN
    
    ELSE
    LDR R0, R5, #4
    ADD R0, R0, #-1     ;calculate n-1
    ADD R6, R6, #-1     ;push n-1
    STR R0, R6, #0
    JSR FIBFN           ;call fib(n-1)
    
    LDR R0, R6, #0      ;pop return value
    ADD R6, R6, #1
    ADD R6, R6, #1      ;pop n-1
    STR R0, R5, #0     ;set 'a' equal to the return value
    LDR R0, R5, #4      ;load into R0, 'n'
    ADD R0, R0, #-2     ;set R0 equal to 'n-2'
    ADD R6, R6, #-1     ;push 'n-2' 
    STR R0, R6, #0
    JSR FIBFN           ;call fib(n-2)
    
    LDR R0, R6, #0      ;pop return value
    ADD R6, R6, #1
    ADD R6, R6, #1      ;pop n-2
    STR R0, R5, #-1      ;store return value into 'b'
    LDR R1, R5, #0      ;load 'b'
    LDR R2, R5, #-1     ;load 'a'
    AND R0, R0, #0      
    ADD R0, R2, R1      ;fib(n-1) + fib(n-2) 
    
    FIBFN_FIN
    STR R0, R5, #3      ;store return value
    ADD R6, R6, #1      ;pop local
    ADD R6, R6, #1      ;pop local
    LDR R5, R6, #0      ;pop dynamic link
    ADD R6, R6, #1
    LDR R7, R6, #0      ;pop return address
    ADD R6, R6, #1
    RET

        .END
