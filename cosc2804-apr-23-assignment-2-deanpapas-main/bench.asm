.ORIG x3000

;Defining Starting Coordinates
TRAP x31 ; Get player position coordinates
ADD R0, R0, #1 ; Add 1 to X coordinate
ADD R2, R2, #-8 ; Add -8 to z coordinate (Start Point)

;Defining Bench Count
AND R4, R4, #0 ; Clear R4
ADD R4, R4, #4 ; Bench Count


LOOP
    JSR BUILD_BENCH
    ADD R2, R2, #4 ; Moving to next bench
    ADD R4, R4, #-1 ; Subtract 1 from bench count
    BRn END_LOOP ; If bench count is 0, end loop
        BR LOOP

END_LOOP
    HALT

BUILD_BENCH
    AND R3, R3, #0 ; Clear R3 (BLOCK_ID)
    ADD R3, R3, #1 ; Add STONE to block ID
    TRAP x34; Place block
    ADD R1, R1, #1 ; Add 1 to Y coordinate
    ADD R3, R3, #4 ; Change block ID to WOOD
    TRAP x34 ; Place block
    ADD R0, R0, #1 ; Add 1 to X coordinate
    TRAP x34 ; Place block
    ADD R0, R0, #1 ; Add 1 to X coordinate
    TRAP x34 ; Place block
    AND R3, R3, #-5 ; Change block ID to STONE
    ADD R1, R1, #-1 ; Subtract 1 from Y coordinate
    TRAP x34 ; Place block

    ;Reset X coordinate
    ADD R0, R0, #-2
    RET

.END