.ORIG x3000

TRAP 0x31 ;Get Player Position
ADD R2, R2, #2 ;Add 2 to Z coordinate
TRAP x35 ;Get Height of Block at (X,Y,Z)
ADD R1, R1,#1 ;Add 1 to Y coordinate
LD R3, BLOCK_ID ;Load Block ID
LD R4, HEIGHT ;Load Height/Loop Counter

AND R3, R3, #0 ;Clear R4
ADD R3, R3, #1 ;Starting Block ID

LOOP
JSR PLACE_BLOCK
ADD R4, R4, #-1 ;Decrement Height/Loop Counter
BRz END_LOOP
    BR LOOP

END_LOOP
    HALT

PLACE_BLOCK
    TRAP x34
    ADD R3, R3, #1 ;Increment Block ID
    ADD R1, R1, #1 ;Increment Y coordinate
    RET
    
BLOCK_ID .FILL #1
HEIGHT .FILL #20 ; Note: Please do not change the name of this constant
.END
