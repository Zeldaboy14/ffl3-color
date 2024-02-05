.BANK $9 SLOT 1
.ORGA $40F7
.SECTION "MenuSpriteLoad_Hook" OVERWRITE
	call MenuSpriteLoad
.ENDS

.SECTION "MenuSprite_Code" FREE
;a = attribute
;b = remaining count
;c = tile index
;hl = destination
MenuSpriteLoad:
	push af
	push bc
	push hl
	
	;Switch banks
	di
	ld a, WRAM_SPRITE_BANK
	ldh (<SVBK), a

	call WRAM_SPRITE_CODE + (MenuSpriteFarCode - SPRITECODE_FAR_START)
	
	;Switch banks back
	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a
	ei

	;Replaces Original code
	pop hl
	ld a, b
	ldi (hl), a

	pop bc
	pop af

	inc c
	dec b
	ret
.ENDS