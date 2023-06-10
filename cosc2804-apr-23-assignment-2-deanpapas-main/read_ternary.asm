.ORIG x3000

TRAP x31 ; Get Player Pos
ADD R0, R0, #1 ; Add 1 to X

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
        BRz END
            BR POWER_LOOP

END
    HALT

.END
