.ORIG x3000
TRAP x31
ADD R1, R1, #-1
TRAP x33 ; Get block id -> R3

; Clear registers
AND R0, R0, #0
ADD R0, R0, R3 ; R0 = R3 ; R0 = block id copy
TRAP x36

DIV_LOOP
    ADD R0, R0, #-2
    BRz EVEN
    BRn ODD
    BRnzp DIV_LOOP

EVEN
    ADD R3, R3, #-10
    BRzp UNDER_10
    LEA R0, evenString0
    TRAP x30
    HALT
    
UNDER_10
    LEA R0, evenString1
    TRAP x30
    HALT

ODD 
    LEA R0, oddString
    TRAP x30
    HALT


evenString0 .STRINGZ "The block beneath the player tile is even numbered and less than 10."
evenString1 .STRINGZ "The block beneath the player tile is even numbered and greater than or equal to 10."
oddString .STRINGZ "The block beneath the player tile is odd numbered."
.END
