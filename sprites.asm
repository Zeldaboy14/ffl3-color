
.BANK 0 SLOT 0
.ORGA $3B33
.SECTION "SpriteLoad_Hook" OVERWRITE
	call SpriteSetPalette
	nop
.ENDS

.SECTION "MenuLoad_Code" FREE	
SpriteSetPalette:
	and a, $E0
	ld (de), a
	inc e
	ldh a, ($97)
	ret
.ENDS
