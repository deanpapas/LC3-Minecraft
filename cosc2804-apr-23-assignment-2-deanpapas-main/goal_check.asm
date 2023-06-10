.ORIG x3000


LOOP
TRAP x31 ;Get Player Postion
LD R1, GOAL_X ;Load Goal X Position
NOT R0, R0 ;Invert x position
ADD R0, R0, #1 
ADD R1, R1, R0 ;Add x position to inverted x position
BRz CHECK_Z ;If x position is equal to goal x position, check z position
    BR LOOP

CHECK_Z
LD R1, GOAL_Z ;Load Goal Z Position
NOT R2, R2 ;Invert z position
ADD R2, R2, #1
ADD R1, R1, R2 ;Add z position to inverted z position
BRz END_LOOP ;If z position is equal to goal z position, end loop
    BR LOOP

END_LOOP
    LEA R0, GOAL_STRING ;Load Goal String
    TRAP x30 ;Print Goal String
    HALT

; Note: Please do not change the names of the constants below
GOAL_X .FILL #4
GOAL_Z .FILL #-5
GOAL_STRING .STRINGZ "goal reached"
.END

