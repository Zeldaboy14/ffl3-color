.include "spriteattr.asm"

.DEFINE WRAM_SPRITE_IDS		WRAM1 + $0000
.DEFINE WRAM_SPRITE_ATTR 	WRAM1 + $0200
.DEFINE WRAM_SPRITE_CODE 	WRAM1 + $0C00

.BANK 0 SLOT 0
.ORGA $0018
.SECTION "SpriteLoadTile_Hook" OVERWRITE
	call SpriteRecordAddr
	jp $378A
.ENDS

.ORGA $233D
.SECTION "SpriteUnsetAttributes_Hook" OVERWRITE
	call SpriteUnsetAttributes
.ENDS

.ORGA $2387
.SECTION "SpriteLowerLeftResetXFlip_Replacement" OVERWRITE
	res 5, (hl)
.ENDS

.ORGA $2390
.SECTION "SpriteLowerLeftSetXFlip_Replacement" OVERWRITE
	set 5, (hl)
.ENDS

.ORGA $2398
.SECTION "SpriteLowerRightResetXFlip_Replacement" OVERWRITE
	res 5, (hl)
.ENDS

.ORGA $23A0
.SECTION "SpriteLowerRightSetXFlip_Replacement" OVERWRITE
	set 5, (hl)
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

;RST $18 loads sprites, and it modifies the return stack to skip the byte after the RST $18 call, which it uses as the bank (!?)
;047C seems to be responsible for loading NPC sprite tiles to VRAM, using rst $18
;04BF seems to be responsible for loading visible player sprite tiles to VRAM, using rst $18
;07:7F09 seems to be the start of a bunch of other sprite loads... maybe a default set, since it looks hard-coded

;2380 or so seems to be where menu sprites are animated
;09:40f8 might be where they're loaded?

;TODO: Make this write two bytes per tile: BANK, (HL-$4000)/$40

.SECTION "Sprite_Code" FREE	
;Original code loads tiles into VRAM, additionally we record where they came from to 05:D000 block
;BC is byte count
;DE is destination, must be $8000~$87FF
;HL is source
SpriteRecordAddr:
	push af
	ld a, d
	and $F8
	cp $80
	jp neq, _no
_yes:
    FARCALL(WRAM_SPRITE_BANK, WRAM_SPRITE_CODE + SpriteRecordAddr_FarCode - SPRITE_CODE_START)
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
    FARCALL(WRAM_SPRITE_BANK, WRAM_SPRITE_CODE + SpriteFarCode - SPRITE_CODE_START)
	pop af

	;Combine upper metadata from (DE) and combine with lower metadata from B
;	ld a, (de)
	and $E0
	or b

	pop bc

	;Original code, load result into (HL)
	ldi (hl), a
	inc de
	ld a, l
	ret

SpriteUnsetAttributes:
	ldi (hl), a
	push af
	ld a, (hl)
	and $07
	ld (hl), a
	pop af
	inc a 
	ret

.ENDS

.BANK $10 SLOT 1
.SECTION "Sprite_FarCode" FREE
SPRITE_CODE_START:
;Original code loads tiles into VRAM, additionally we record where they came from to 05:D000 block
;BC is byte count
;DE is destination, must be $8000~$87FF
;HL is source
SpriteRecordAddr_FarCode:
	push hl
	push de
	push bc
	push af

	;Bank is determined by one of two things - either the high nibble of the byte after the RST $18 call, or ($C0B1) if that was zero.
	push hl
	ld hl, sp+$10
	ldi a, (hl)
	push af
	ld a, (hl)
	ld h, a
	pop af
	ld l, a
	ld a, (hl)
	swap a
	and $0F
	jr nz, _go
	ld a, ($C0B1)
_go:
	pop hl
	push af

	;Switch this to HL >> 4, we want the index of the tiles directly.
	;5:D000 block should just contain 16 bit pointers to the 11:4000 block

	;HL = ((HL >> 4) | (BANK << 12)), the index of the 16-byte block in the $4000~$7FFF range.
	ld a, h
	and $3F
	ld h, a
	srl h
	rr l
	srl h
	rr l
	srl h
	rr l
	srl h
	rr l
  	pop af
  	sla a
  	sla a
  	add a, $40
  	or h
  	ld h, a
  	push hl

	;Get number of tiles into B
	ld h, b
	ld l, c
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld b, h

	;Calculate the destination address in WRAM
	;Divide the tile vram address by $10 (size of a tile) and multiply by two.  Easiest way is to shift left five times and discard the low value.
	;hl = $D000 | ((DE & $07FF) * $20)
	ld h, d
	ld l, e
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld l, h
	ld h, $D0

	;Pop the old HL (bank<<12|addr>>4) into DE
	pop de
_loop:
	ld (hl), e
	inc hl
	ld (hl), d
	inc hl
	inc de
	dec b
	jr nz, _loop
	pop af
	pop bc
	pop de
	pop hl
	ret

SpriteFarCode:
	;Load sprite tile ID from (hl - 1) into A
	dec hl
	ldi a, (hl)
	push hl

	;load $D000 + A * 2 into HL
	ld h, $D0
	sla a
	ld l, a

	;load metatile bank from (HL) into HL
	ldi a, (hl)
	ld h, (hl)
	ld l, a
	
	;Load metatile data from metatile rom bank into b
	ld a, (hl)
	or b
	ld b, a

	pop hl
	ret

MenuSpriteFarCode:
	SET_ROMBANK $11

	;load $D000 + C * 2 into HL
	ld h, $D0
	ld l, c
	sla l

	;load metatile bank from (HL) into HL
	ldi a, (hl)
	ld h, (hl)
	ld l, a

	ld a, h
	cp $40
	jr lst, _cancelMenuSprite
	
	;Load metatile data from metatile rom bank into b
	ld a, (hl)
	ld b, a

	SET_ROMBANK $09
	ret

_cancelMenuSprite:
	;Fixes screwed up sprites in the continue menu, but does not colorize them.
	xor a
	ld b, a
	SET_ROMBANK $09
	ret

BattleSpriteFarCode:
	push bc
	push af
	SET_ROMBANK $11

	;Get the tile number back
	pop af

	;load $D000 + A * 2 into HL
	push hl
	ld h, $D0
	ld l, a
	sla l

	;load metatile bank from (HL) into HL
	ldi a, (hl)
	ld h, (hl)
	ld l, a
	
	;Load metatile data from metatile rom bank into b
	ld a, (hl)
	ld b, a

	SET_ROMBANK $02
	pop hl

	ld a, b
	pop bc

	ret
SPRITE_CODE_END:
.ENDS

;Battle sprite code is very different, uses 8x16 sprites
;02:4164 clears A and loads it into ram that appears to be the upper left of the hero

;02:4128
	;02:4154
		;02:415C
			;Loads $58 into (HL++)   		;Sprite Y Value
			;Loads A (10) into (HL++)		;Sprite X Value
			;Loads C*2 (6C) into (HL++)		;Sprite Tile Index
			;Loads A (0) into (HL++)
		;Same code executes again
		;Loads $58 into (HL++)
		;Loads A (70) into (HL++)
		;Loads C*2 (78) into (HL++)
		;Loads A (0) into (HL++)

.BANK 2 SLOT 1
.ORGA $4163
.SECTION "BattleSpriteLoad_Hook" OVERWRITE
	call BattleSpriteLoad
.ENDS

.BANK 0 SLOT 0
.SECTION "BattleSpriteLoad_Code" FREE
BattleSpriteLoad:
	;original code, writes tile index
	ldi (hl), a
    FARCALL(WRAM_SPRITE_BANK, WRAM_SPRITE_CODE + BattleSpriteFarCode - SPRITE_CODE_START)
	ldi (hl), a
	ret;
.ENDS

.SECTION "SpriteFarCodeLoader" FREE APPENDTO "FarCodeLoader"
    ld a, WRAM_SPRITE_BANK
    ld bc, SPRITE_CODE_END - SPRITE_CODE_START
    ld de, WRAM_SPRITE_CODE
    ld hl, SPRITE_CODE_START
    call CopyFarCodeToWRAM
.ENDS
