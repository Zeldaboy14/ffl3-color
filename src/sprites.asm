.include "spriteattr.asm"

.DEFINE WRAM_SPRITE_IDS		WRAM1 + $0000
.DEFINE WRAM_SPRITE_ATTR 	WRAM1 + $0200
.DEFINE WRAM_SPRITE_CODE 	WRAM1 + $0C00

;The function at 07:7F00 loads all the default sprites - all(?) the sprites that appear on the world map and other common ones.
;07:7F09 loads Talon into VRAM at $8100
;07:7F11 loads floating island into VRAM at $8200
;07:7F19 loads some sort of obelisk and ship into VRAM at $8300 and $8400
;07:7F21 loads the elder into VRAM at $8500
;07:7F29 loads a boulder, a dept sign, something? and a fire a into VRAM at $8600
;07:7F31 loads a person into VRAM at $8700
;07:7F39 loads closed and open treasure into VRAM at $8740
;07:7F41 loads a shadow into VRAM at $87C0
;07:7F4C loads the pointer into VRAM at $87E0

;00:047C loads townspeople
;00:04C2 loads the player

.BANK 0 SLOT 0
.ORGA $0018
.SECTION "SpriteLoadTile_Hook" OVERWRITE
	call SpriteRecordAddrRST18
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

.ORGA $23F4
.SECTION "SpriteUpperLeftSetXFlip_Replacement23F6" OVERWRITE
	call SetFlipX
.ENDS

.ORGA $23FB
.SECTION "SpriteLowerLeftSetXFlip_Replacement23FB" OVERWRITE
	call SetFlipX
.ENDS

.ORGA $2403
.SECTION "SpriteUpperRightSetXFlip_Replacement2403" OVERWRITE
	call SetFlipX
.ENDS

.ORGA $240A
.SECTION "SpriteLowerRightSetXFlip_Replacement240A" OVERWRITE
	call SetFlipX
.ENDS

.ORGA $3B33
.SECTION "NPCSpriteAttribute_Hook" OVERWRITE
	;This might just be non-humanoid sprites?  At one point I was just cleaning the palette here, but I think
	;this is an okay place to set it.
	call NPCSpriteAttribute
	nop
.ENDS

.ORGA $3BFA ;Sets sprite attribute for players and/or NPCs
.SECTION "PlayerNPCSpriteAttribute_Hook" OVERWRITE
	call PlayerNPCSpriteAttribute
.ENDS

.SECTION "SetFlipX" FREE
SetFlipX:
	inc hl
	ldi (hl), a
	set 5, (hl)
	ret
.ENDS

.BANK $02 SLOT 1
.ORGA $4163 ;Battle menu sprite apply attribute
.SECTION "BattleSpriteLoad_Hook" OVERWRITE
	call BattleSpriteAttribute
.ENDS

.ORGA $41CA ;Effect sprite record addr
.SECTION "SpriteRecordAddr_Hook" OVERWRITE
	call SpriteRecordAddrBank2
.ENDS

.ORGA $42A8
.SECTION "EffectSpriteAttributes_Hook" OVERWRITE
	call EffectSpriteAttributes
	and a, $07
.ENDS

.ORGA $4F11
.SECTION "BigEffectSpriteAttributes_Hook" OVERWRITE
	call BigEffectSpriteAttributes
.ENDS

.BANK $03 SLOT 1
.ORGA $79CE ;Default set effect sprite record addr
.SECTION "SpriteRecordAddrBank3_Hook" OVERWRITE
	call SpriteRecordAddrBank3
.ENDS

.BANK $09 SLOT 1
.ORGA $40F7 ;Sets sprite attributes for sprites on the menu window
.SECTION "WindowSpriteAttribute_Hook" OVERWRITE
	call WindowSpriteAttribute
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

.BANK $00 SLOT 0
.SECTION "Sprite_Code" FREE	
;Original code loads tiles into VRAM, additionally we record where they came from to 05:D000 block
;BC is byte count
;DE is destination, must be $8000~$87FF
;HL is source
SpriteRecordAddrRST18:
	push af
	ld a, d
	and $F8
	cp $80
	jp neq, _no
_yes:
    FARCALL(WRAM_SPRITE_BANK, WRAM_SPRITE_CODE + SpriteRecordAddrRST18_Far - SPRITE_CODE_START)
_no:
	pop af
	ret

NPCSpriteAttribute:
	FARCALL(WRAM_SPRITE_BANK, WRAM_SPRITE_CODE + NPCSpriteAttribute_Far - SPRITE_CODE_START)
	ret

PlayerNPCSpriteAttribute:
	FARCALL(WRAM_SPRITE_BANK, WRAM_SPRITE_CODE + PlayerNPCSpriteAttribute_Far - SPRITE_CODE_START)
	ret

WindowSpriteAttribute:
	FARCALL(WRAM_SPRITE_BANK, WRAM_SPRITE_CODE + WindowSpriteAttribute_Far - SPRITE_CODE_START)
	ret

SpriteUnsetAttributes:
	ldi (hl), a
	push af

	FARCALL(WRAM_SPRITE_BANK, WRAM_SPRITE_CODE + PlayerSpriteAttribute_Far - SPRITE_CODE_START)

	ld a, (hl)
	and $07
	ld (hl), a
	pop af
	inc a 
	ret
.ENDS

.BANK $02 SLOT 1
.SECTION "SpriteBank02_Code" FREE
SpriteRecordAddrBank2:
	FARCALL(WRAM_SPRITE_BANK, WRAM_SPRITE_CODE + SpriteRecordAddrBank2_Far - SPRITE_CODE_START)
	ret

BattleSpriteAttribute:
	;NOTE: This cannot be in RAM because it accesses D000.
	ldi (hl), a
	push hl

	;load $D000 + A into HL
	ld h, $D0
	ld l, a

	SET_WRAMBANK WRAM_SPRITE_BANK

	;load metatile attribute from (HL) into original HL's (HL)
	ld a, (hl)
	pop hl
	push bc
	ld b, a
	RESET_WRAMBANK
	ld a, b
	ldi (hl), a
	pop bc

	ret;

EffectSpriteAttributes:
	FARCALL(WRAM_SPRITE_BANK, WRAM_SPRITE_CODE + EffectSpriteAttributes_Far - SPRITE_CODE_START
	ret

;c count
;hl source
;de destination
BigEffectSpriteAttributes:
	;NOTE: This cannot be in RAM because it accesses D000.
	push bc

	;Load sprite tile ID from (de) into A
	ld a, (de)
	inc de
	push hl

	;load $D000 + A into HL
	ld h, $D0
	ld l, a

	;load metatile attribute from HL
	SET_WRAMBANK WRAM_SPRITE_BANK
	ld a, (hl)
	ld b, a
	RESET_WRAMBANK
	pop hl

	ldi a, (hl)
	and $E0
	or b
	ld (de), a

	pop bc
	ret

.ENDS

.BANK $03 SLOT 1
.SECTION "SpriteBank03_Code" FREE
SpriteRecordAddrBank3:
	FARCALL(WRAM_SPRITE_BANK, WRAM_SPRITE_CODE + SpriteRecordAddrBank3_Far - SPRITE_CODE_START)
	ret
.ENDS


.BANK $10 SLOT 1
.SECTION "Sprite_FarCode" FREE
SPRITE_CODE_START:

SpriteRecordAddrBank2_Far:
	push af
	ld a, 2
	call WRAM_SPRITE_CODE + SpriteRecordAddr_Far - SPRITE_CODE_START 
	pop af
	call $20FF
	ret

SpriteRecordAddrBank3_Far:
	;original code
	ld bc, $04A0
	push af
	ld a, 3
	call WRAM_SPRITE_CODE + SpriteRecordAddr_Far - SPRITE_CODE_START 
	pop af
	ret

SpriteRecordAddrRST18_Far:
	push af

	;Bank is determined by one of two things - either the high nibble of the byte after the RST $18 call, or ($C0B1) if that was zero.
	push hl
	ld hl, sp+$0C
	ldi a, (hl)
	push af
	ld a, (hl)
	ld h, a
	pop af
	ld l, a
	ld a, (hl)
	pop hl
	swap a
	and $0F
	jr nz, _else
	ld a, ($C0B1)
_else:

	;Make sure it's in range, since our hooks aren't good yet.
	cp 2
	jr lst, _done
	cp 5
	jr geq, _done

	call WRAM_SPRITE_CODE + SpriteRecordAddr_Far - SPRITE_CODE_START 

_done:
	pop af
	ret

;Original code loads tiles into VRAM, additionally we record where they came from to 05:D000 block
;A is bank
;BC is byte count
;DE is destination, must be $8000~$87FF
;HL is source
SpriteRecordAddr_Far:
	push hl
	push de
	push bc
	push af

	;HL = ((HL >> 4) | (BANK << 10)), the index of the 16-byte block in the $4000~$7FFF range.
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
	push af
	sub 2
  	sla a
  	sla a
  	add $D0 ;Table starts at $D200, but in FFL3 we consider it to start at $D000 because the first $200 tiles are code.
  	add a, h
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
	;hl = $D000 | ((DE & $07FF) * $10)
	ld h, d
	ld l, e
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld l, h
	ld h, $D0

	;Pop the old HL (bank<<10|addr>>4) into DE
	pop de
_loop:
	ld a, (de)
	ldi (hl), a
	inc de
	dec b
	jr nz, _loop

	pop af
	pop bc
	pop de
	pop hl
	ret

PlayerNPCSpriteAttribute_Far:
	ld b, a

	;Load sprite tile ID from (hl - 1) into A
	dec hl
	ldi a, (hl)
	push hl

	;load $D000 + A into HL
	ld h, $D0
	ld l, a

	;load metatile attribute from HL
	ld a, (hl)
	or b
	ld b, a
	pop hl

	;Original code, load result into (HL)
	ld a, (de)	
	and $E0
	or b
	ldi (hl), a
	inc de
	ld a, l
	ret

NPCSpriteAttribute_Far:
	push bc
	and a, $E0 
	ld b, a

	;Load sprite tile ID from (de - 1) into A
	dec de
	ld a, (de)
	inc de
	push hl

	;load $D000 + A into HL
	ld h, $D0
	ld l, a

	;load metatile attribute from HL
	ld a, (hl)
	pop hl

	;Original code
	or b
	pop bc
	ld (de), a
	inc e
	ldh a, ($97)
	ret

PlayerSpriteAttribute_Far:
	push bc

	;Load sprite tile ID from (hl - 1) into A
	dec hl
	ldi a, (hl)
	push hl

	;load $D000 + A into HL
	ld h, $D0
	ld l, a

	;load metatile attribute from HL
	ld a, (hl)
	ld b, a
	pop hl

	;Original code
	ld a, (hl)
	and $E0
	or b
	ld (hl), a

	pop bc
	ret

MenuSpriteAttribute_Far:
	;Load sprite tile ID from (hl - 1) into A
	dec hl
	ldi a, (hl)
	push hl

	;load $D000 + A into HL
	ld h, $D0
	ld l, a

	;load metatile attribute from HL
	ld a, (hl)
	pop hl

	;Original code
	ld (hl), a
	ret

WindowSpriteAttribute_Far:
	;Load sprite tile ID from (hl - 1) into A
	dec hl
	ldi a, (hl)
	push hl

	;load $D000 + A into HL
	ld h, $D0
	ld l, a

	;load metatile attribute from HL
	ld a, (hl)
	pop hl

	;Original code
	inc c
	ldi (hl), a
	dec b
	ret

;a is game-native attribute
;c is count
;hl is destination (C000~C09F)
EffectSpriteAttributes_Far:
	;Load sprite tile ID from (hl - 1) into A
	dec hl
	ldi a, (hl)
	push hl

	;load $D000 + A into HL
	ld h, $D0
	ld l, a

	;load metatile attribute from HL
	ld a, (hl)
	pop hl

	or b
	ld b, a
	ld a, ($DE04)
	and a, $10 
	or b
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

;02:41CA looks responsible for loading spell sprites - if we can trap the source
;address we can probably colorize the first 30 OAM entries based on a lookup from
;the source address
;Looks like a lot of the basic spells share the same data block of 658C, each using
;different subsets of the tiles
;02:4FCA loads zero into the attribute byte

;658C: Magma, Quake, Lit 1, Lit 2, Ice 2
;68AC: Durend
;6A2C: Sword
;6AAC: XCalibur
;6ACC: Gungnir
;6C8C: Fatal
;75CC: Aero
;79EC: Flare, Fire 2, LitX
;DE61: Numbers and Missed

.BANK $10 SLOT 1
.SECTION "SpriteFarCodeLoader" FREE APPENDTO "FarCodeLoader"
    ld a, WRAM_SPRITE_BANK
    ld bc, SPRITE_CODE_END - SPRITE_CODE_START
    ld de, WRAM_SPRITE_CODE
    ld hl, SPRITE_CODE_START
    call CopyFarCodeToWRAM
.ENDS
