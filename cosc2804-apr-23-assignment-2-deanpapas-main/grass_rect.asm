.ORIG x3000

TRAP x31 ; Get Player Coordinates
AND R3, R3, #0 ; Clear R3
ADD R3, R3, #2 ; Set BLOCK ID to Grass
ADD R1, R1, #-1 ; ADD -1 to Y

; Set Starting Position (Bottom Left Corner)
LD R4, X_DIST ; Load X Counter
JSR INVERT_X_COUNTER
ADD R0, R0, R4 ; Add X_DIST to X
LD R5, Z_DIST ; Load Z Counter
JSR INVERT_Z_COUNTER
ADD R2, R2, R5 ; Add Z_DIST to Z

; Prepare Counters for Loop
JSR CALCULATE_X_COUNTER
JSR CALCULATE_Z_COUNTER

Z_LOOP
    ADD R5, R5, #0 ; Check Z Counter
    BRz X_LOOP
        TRAP x34
        ADD R2, R2, #1 ; Increment Z
        ADD R5, R5, #-1 ; Decrement Z Counter
        BR Z_LOOP

X_LOOP
    ADD R4, R4, #-1 ; Decrement X Counter
    ADD R4, R4, #0 ; Check X Counter
    BRz END_LOOP
        ADD R0, R0, #1 ; Increment X
        LD R5, Z_DIST ; Load Z Counter
        JSR CALCULATE_Z_COUNTER ; Calculate Z Counter
        JSR INVERT_Z_COUNTER ; Invert Z Counter
        ADD R2, R2, R5 ; Reset Z Pos
        JSR CALCULATE_Z_COUNTER ; Calculate Z Counter
        BR Z_LOOP

END_LOOP
    HALT


INVERT_X_COUNTER
    NOT R4, R4
    ADD R4, R4, #1
    RET

INVERT_Z_COUNTER
    NOT R5, R5
    ADD R5, R5, #1
    RET

CALCULATE_X_COUNTER
    LD R4, X_DIST
    ADD R4, R4, R4 ; Double X Counter
    ADD R4, R4, #1 ; Add 1 to X Counter
    RET

CALCULATE_Z_COUNTER
    LD R5, Z_DIST
    ADD R5, R5, R5 ; Double Z Counter
    ADD R5, R5, #1 ; Add 1 to Z Counter
    RET



; Note: Please do not change the names of the constants below
X_DIST .FILL #2
Z_DIST .FILL #3
.END