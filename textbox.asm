
.BANK 15 SLOT 1
.ORGA $794f
.SECTION "TextboxLoadLine_Hook" OVERWRITE
	call TextboxLoadLine
.ENDS

.SECTION "TextboxDisplay_Code" FREE	
TextboxLoadLine:
	push af
	push bc
	push hl
	
	WAITBLANK
	
	ld a, 1
	ldh (<VBK), a
	
	ld c, 14
	ld a, 7
_loop:
	ldi (hl), a
	dec c
	jr nz, _loop

	ld a, 0
	ldh (<VBK), a
	
	WAITBLANK

	pop hl
	pop bc
	pop af
	
	;Currently this just replicates the three bytes that the call above overwrote
	ldi (hl), a
	ldi (hl), a
	ldi (hl), a
	ret
.ENDS
