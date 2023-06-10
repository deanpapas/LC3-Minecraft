.ORIG x3000

AND R0, R0, #0 ; Clear R0
AND R1, R1, #0 ; Clear R1
AND R2, R2, #0 ; Clear R2

TRAP 0x31 ; Get player position
ADD R0, R0, #4 ; Add 4 to x coordinate
TRAP 0x35 ; Get height at new x coordinate
ADD R1, R1, #1; Add 1 to height
LD R3, GLASS_ID ; Load glass ID into R3
TRAP 0x34 ; Place glass at new x coordinate
HALT
GLASS_ID .FILL #20
.END