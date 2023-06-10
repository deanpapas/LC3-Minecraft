.ORIG x3000

TRAP x31 ;Get Player Position

;Store Player Position                                     
ST R0, Player_X 
ST R1, Player_Y 
ST R2, Player_Z 

;Calculate X
LD R0, Player_X
LD R1, G_X
JSR CALCULATE
ST R0, Player_X
JSR CLEAR_REGISTERS

;Calculate Y
LD R0, Player_Y
LD R1, G_Y
JSR CALCULATE
ST R0, Player_Y
JSR CLEAR_REGISTERS

;Calculate Z
LD R0, Player_Z
LD R1, G_Z
JSR CALCULATE
ST R0, Player_Z
JSR CLEAR_REGISTERS

;Calculate Distance
LD R0, Player_X
LD R1, Player_Y
LD R2, Player_Z
ADD R0, R0, R1
ADD R0, R0, R2
ST R0, CALCULATED_DIST

;Square Goal Distance
LD R0, GOAL_DIST
AND R1, R1, #0
ADD R1, R0, R0
JSR CALCULATE

;Compare Goal Distance to Calculated Distance
LD R1, CALCULATED_DIST
NOT R1, R1
ADD R1, R1, #1
ADD R0, R0, R1
BRp WIN
    LEA R0, LOOSE_STRING
    TRAP x30
    HALT
WIN
    LEA R0, WIN_STRING
    TRAP x30
    HALT


CALCULATE
    NOT R1, R1
    ADD R1, R1, #1
    ADD R0, R0, R1
    BRp POSITIVE
        NOT R0, R0
        ADD R0, R0, #1
        BR SQUARE
    POSITIVE
        BR SQUARE
    SQUARE
        AND R1, R1, #0
        AND R2, R2, #0
        ADD R2, R2, R0
        LOOP
        ADD R1, R1, R0
        ADD R2, R2, #-1
            BRp LOOP
            AND R0, R0, #0
            ADD R0, R0, R1
            RET
CLEAR_REGISTERS
    AND R0, R0, #0
    AND R1, R1, #0
    AND R2, R2, #0
    RET
; Note: Please do not change the names of the constants below
G_X .FILL #7
G_Y .FILL #-8
G_Z .FILL #5
GOAL_DIST .FILL #10
Player_X .FILL x3100
Player_Y .FILL x3101
Player_Z .FILL x3102
CALCULATED_DIST .FILL x3103
WIN_STRING .STRINGZ "The player is within distance of the goal"
LOOSE_STRING .STRINGZ "The player is outside the goal bounds"
.END
