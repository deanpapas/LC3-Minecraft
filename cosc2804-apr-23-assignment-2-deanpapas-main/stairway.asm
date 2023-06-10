.ORIG x3000

TRAP x31
AND R3, R3, #0 ; Clear R3
ADD R3, R3, #1 ; Set BLock to Stone
LD R4, STAIRS_LENGTH ; X Counter
LD R5, STAIRS_WIDTH ; Z Counter
LD R6, STAIRS_HEIGHT ; Y Counter
; Move to the starting position
ADD R0, R0, #1 ; Increment X Pos
ADD R2, R2, #1 ; Increment X Pos
ST R0, START_X_POS ; Save X Pos
ST R2, START_Z_POS ; Save Z Pos
TRAP x36

BUILD_PLATFORM
    TRAP x34    
    ADD R0, R0, #1 ; Increment X Pos
    ADD R5, R5, #-1 ; Decrement X Counter
    BRp BUILD_PLATFORM
        LD R5, STAIRS_WIDTH ; Reset X Counter
        LD R0, START_X_POS ; Reset X Pos
        ADD R2, R2, #1 ; Increment Z Pos
        ADD R4, R4, #-1 ; Decrement Z Counter
        BRp BUILD_PLATFORM
            LD R5, STAIRS_WIDTH ; Reset X Counter
            LD R0, START_X_POS ; Reset X Pos
            LD R4, STAIRS_LENGTH ; Reset Z Counter
            LD R2, START_Z_POS ; Reset Z Pos

            ADD R4, R4, #-1 ; Decrement Stair Length
            ST R4, STAIRS_LENGTH ; Save Stair Length
            ADD R2, R2, #1 ; Increment Z Pos
            ST R2, START_Z_POS ; Save Z Pos

            ADD R1, R1, #1 ; Increment Y Pos
            ADD R6, R6, #-1 ; Decrement Y Counter
            BRp BUILD_PLATFORM
            HALT

; Note: Please do not change the names of the constants below
STAIRS_WIDTH .FILL #2
STAIRS_LENGTH .FILL #4
STAIRS_HEIGHT .FILL #3
START_X_POS .FILL x3100
START_Z_POS .FILL x3101
.END


