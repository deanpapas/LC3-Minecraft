.ORIG x3000

TRAP x31 ; Get Player Pos

LD R4, NUMBER_TO_CONVERT ; Assume this is >= 0
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
    BRz END ; If zero, halt
        BR DIV_LOOP

END
    HALT

NUMBER_TO_CONVERT .FILL #21746 ; Note: Please do not change the name of this constant
.END
