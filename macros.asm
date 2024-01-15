
; This waits for V-Blank or H-Blank so both OAM and display RAM are accessible
.MACRO WAITBLANK
    wait\@:
    ldh a,(<STAT)
    bit 1,a
    jr nz,wait\@
.ENDM