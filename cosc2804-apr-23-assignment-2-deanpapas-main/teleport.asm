.ORIG x3000

TRAP x31
ADD R3,R0,#0 ; Save Original x coordinate
BR CALCNEWX

;Calculate New x coordinate (|z|)
CALCNEWX
    ADD R2, R2, #0
    BRn INVERT ; If z < 0, jump to INVERT
    ADD R0, R2, #0 ; Write new x coordinate to R0
    BR CALCNEWZ

    INVERT
        NOT R2, R2
        ADD R2, R2, #1
        ADD R0, R2, #0 ; Write new x coordinate to R0
        BR CALCNEWZ

;Calculate z coordinate (-x)
CALCNEWZ
    NOT R3, R3
    ADD R3, R3, #1
    ADD R2, R3, #0 ; Write new z coordinate to R2
    BR CALCNEWY

;Calculate y coordinate
CALCNEWY
    AND R3, R3, #0 ; Clear R3
    ADD R3, R1, R1
    ADD R1, R3, R1
    TRAP x32 ; Teleport to new coordinates
    HALT

.END