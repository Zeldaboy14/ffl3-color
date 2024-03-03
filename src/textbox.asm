.BANK $00 SLOT 0
.ORGA $35B8
.SECTION "TextboxTweak_Hook35B8" OVERWRITE
	ld a, $A6
.ENDS
.ORGA $365E
.SECTION "TextboxTweak_Hook365E" OVERWRITE
	ld a, $A6
.ENDS

.BANK 15 SLOT 1
.ORGA $794f
.SECTION "TextboxLoadLine_Hook" OVERWRITE
	call TextboxLoadLine
.ENDS

.ORGA $7995
.SECTION "TextboxLoadTile_Hook" OVERWRITE
	call TextboxLoadTile
	;Modify the original loop to fit the call
	jr nz, -5
.ENDS

.SECTION "TextboxDisplay_Code" FREE	
TextboxLoadTile:
	ld a, h
	cp $9C
	jr neq, _notTextbox
	SET_VRAMBANK 1	
	ld a, 7
	ld (hl), a
	RESET_VRAMBANK
_notTextbox:
	;Original code
	ld a, d
	ldi (hl), a
	dec c
	ret

TextboxLoadLine:
	push af
	push bc
	push hl
	
	SET_VRAMBANK 1	
	
	ld c, 14
_loop:
	WAITBLANK
	ld a, 7
	ldi (hl), a
	dec c
	jr nz, _loop

	RESET_VRAMBANK
	
	pop hl
	pop bc
	pop af
	
	;Currently this just replicates the three bytes that the call above overwrote
	ldi (hl), a
	ldi (hl), a
	ldi (hl), a
	ret
.ENDS
