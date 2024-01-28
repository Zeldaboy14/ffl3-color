
.BANK $11 SLOT 1
.SECTION "Sprite_Data" FREE
SpriteMetadata:
	;00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;10
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;20
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;30
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;40
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $02,$01,$02,$01,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;50
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;60
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;70
	.db $01,$05,$01,$05,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
.ENDS

.BANK 0 SLOT 0
.ORGA $0018
.SECTION "SpriteLoadTile_Hook" OVERWRITE
	call SpriteRecordAddr
	jp $378A
.ENDS

.ORGA $3B33
.SECTION "SpriteClean_Hook" OVERWRITE
	;This might just be non-humanoid sprites?
	call SpriteCleanPalette
	nop
.ENDS

.ORGA $3BFA
.SECTION "SpriteLoadAttribute_Hook" OVERWRITE
	call SpriteSetPalette
.ENDS

;01:5460 looks like the function that loads sprites?

;6BCB hero down
;6BDF hero up
;6BEB 6BED 6BEF 6BF1 hero right
;6C07 hero left

;Sprite data appears in 01:6C00 approximately
;6BF0 ???? XYAT XYAT XYAT XYAT ???? ???? XYAT
;6C00 XYAT XYAT XYAT ???? ???? XYAT XYAT XYAT
;6C10 XYAT

;047C seems to be responsible for loading NPC sprite tiles to VRAM, using rst $18
;04BF seems to be responsible for loading visible player sprite tiles to VRAM, using rst $18
;07:7F09 seems to be the start of a bunch of other sprite loads... maybe a default set, since it looks hard-coded

.SECTION "Sprite_Code" FREE	
SpriteRecordAddr:
	push af
	ld a, d
	and $F8
	cp $80
	jp neq, _no
_yes:
	ld a, WRAM_SPRITE_BANK
	ldh (<SVBK), a

	ld a, h

	push hl
	push bc
	ld h, b
	ld l, c
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld b, h

	ld h, d
	ld l, e
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld l, h
	ld h, $D0
_loop:
	ldi (hl), a
	dec b
	jr nz, _loop
	pop bc
	pop hl

	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a
_no:
	pop af
	ret

SpriteCleanPalette:
	and a, $E0
	ld (de), a
	inc e
	ldh a, ($97)
	ret

SpriteSetPalette:
;c is remaining tiles
;de is source
;hl is destination
	push bc

	push af
	
	;Switch banks
	ld a, WRAM_SPRITE_BANK
	ldh (<SVBK), a
	ld a, $11
	ld ($2100), a

	call SpriteFarCode
	
	;Switch banks back
	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a
	ld a, $01
	ld ($2100), a

	pop af

	;Get upper metadata into B
	ld a, (de)
	and $E0
	or b
	pop bc

	ldi (hl), a
	inc de
	ld a, l
	ret
.ENDS

.BANK $11 SLOT 1
.SECTION "Sprite_FarCode" FREE
SpriteFarCode:
	;Load sprite ID from (05:D000 + (L>>2))
	dec hl
	ldi a, (hl)
	push hl
	ld h, $D0
	ld l, a
	ld a, (hl)
	
	;Load metatile data from ($4000 + (spriteID * 4))
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld a, 4
	sub a, c
	add a, l
	ld l, a
	push de
	ld de, SpriteMetadata
	add hl, de
	ld a, (hl)
	pop de

	ld b, a
	pop hl

	ret
.ENDS
