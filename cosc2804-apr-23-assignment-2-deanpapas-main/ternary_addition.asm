.ORIG x3000

;Prepare to read line 1
TRAP x31
ST R0, X_POS
ADD R0, R0, #1

; Read Line 1
JSR READ_TERNARY
ST R6, TERNARY_VALUE_0

; Prepare to read line 2
LD R0, X_POS
ADD R0, R0, #1
ADD R2, R2, #1 ; Add 1 to Z

; Read Line 2
JSR READ_TERNARY

; Add the two ternary values together
LD R5, TERNARY_VALUE_0
ADD R4, R5, R6
                        TRAP x36

; Prepare to write the result
LD R0, X_POS
ADD R2, R2, #1 ; Add 1 to Z
JSR WRITE_TERNARY
    
HALT


READ_TERNARY

    ; Store R7 for RET
    ST R7, RETURN_VALUE
    ; = X^Y
    AND R4, R4, #0 ; Clear for X
    AND R5, R5, #0 ; Clear for Y
    ADD R5, R5, #10; Y
    AND R6, R6, #0 ; Clear for Total

    POWER_LOOP
        TRAP x33 ; Get Block
        ADD R7, R4, #0 ; Temp = R4
        BRz STARTING_ZERO
            ADD R4, R4, R7 ; Double R3
            ADD R4, R4, R7 ; Triple R3
            BR MULT
        STARTING_ZERO
            ADD R4, R4, #1 ; Assign R4 to 1
        
        MULT
        AND R7, R7, #0  ; Clear for Temp
        ADD R3, R3, #0 ; Check Block ID
        BRnz ZERO
                ADD R3, R3, #-1 ; Decrement R3
                BRz ONE
                    ADD R3, R3, #1 ; Return R3 to Initial Value
                    MULT_LOOP
                        ADD R7, R7, R4
                        ADD R3, R3, #-1 ; Decrement R3
                        BRz ZERO
                            BR MULT_LOOP    
        ONE
            ADD R7, R7, R4
        
        ZERO
            ADD R6, R6, R7 ; Add to Total
            ADD R0, R0, #1 ; Increment X
            ADD R5, R5, #-1 ; Decrement R5
            BRz END_READ
                BR POWER_LOOP
    END_READ
        LD R7, RETURN_VALUE ; Load RET
        RET

WRITE_TERNARY
    
    ; Store R7 for RET
    ST R7, RETURN_VALUE

    AND R5, R5, #0 ; Clear Y
    ADD R5, R5, #3 ; Copy X to Y

    ; Initialise Result to 0
    AND R6, R6, #0

    ; Setup 10 Counter
    AND R7, R7, #0
    ADD R7, R7, #10

    ; Calculate two's complement of Y (R5)
    NOT R5, R5
    ADD R5, R5, #1

    DIV_LOOP

        ; Increment the counter
        ADD R6, R6, #1

        ; Subtract Y from the remaining amount
        ADD R4, R4, R5

        BRn END_DIV_LOOP ; If negative, end the loop
            BR DIV_LOOP

    END_DIV_LOOP
        ADD R6, R6, #-1 ; Decrement the counter
        ADD R4, R4, #3 ; Add Y back to the remaining amount
        ADD R3, R4, #0 ; Copy the remainder to R3 for block id
        ADD R0, R0, #1 ; Add 1 to X coordinate
        TRAP x34 ; Place block
        AND R3, R3, #0 ; Clear block ID
        AND R4, R4, #0 ; Clear the remainder
        ADD R4, R4, R6 ; Copy the result to R4
        AND R6, R6, #0 ; Clear the result
        ADD R7, R7, #-1 ; Decrement the prompt counter
        BRz END_WRITE ; If zero, halt
            BR DIV_LOOP

    END_WRITE
    LD R7, RETURN_VALUE ; Load RET
        RET



X_POS .FILL x3100
TERNARY_VALUE_0 .FILL x3101
RETURN_VALUE .FILL x3102
.END