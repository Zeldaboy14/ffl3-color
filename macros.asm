
; This waits for V-Blank or H-Blank so both OAM and display RAM are accessible
.MACRO WAITBLANK
    wait\@:
    ldh a,(<STAT)
    bit 1,a
    jr nz,wait\@
.ENDM

.MACRO PUSH_ALL
	push af
	push bc
	push de
	push hl
.ENDM

.MACRO POP_ALL
	pop hl
	pop de
	pop bc
	pop af
.ENDM