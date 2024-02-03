;Sprite tiles are found roughly between $10000 and $18000 in ROM.  We only care about them in $40 byte blocks

.DEFINE FULL_GRAY	$00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
.DEFINE FULL_RED	$01,$01,$01,$01,$01,$01,$01,$01, $01,$01,$01,$01,$01,$01,$01,$01
.DEFINE FULL_YELLOW	$02,$02,$02,$02,$02,$02,$02,$02, $02,$02,$02,$02,$02,$02,$02,$02
.DEFINE FULL_GREEN	$03,$03,$03,$03,$03,$03,$03,$03, $03,$03,$03,$03,$03,$03,$03,$03
.DEFINE FULL_CYAN	$04,$04,$04,$04,$04,$04,$04,$04, $04,$04,$04,$04,$04,$04,$04,$04
.DEFINE FULL_BLUE	$05,$05,$05,$05,$05,$05,$05,$05, $05,$05,$05,$05,$05,$05,$05,$05
.DEFINE FULL_PURPLE	$06,$06,$06,$06,$06,$06,$06,$06, $06,$06,$06,$06,$06,$06,$06,$06
.DEFINE FULL_BROWN	$07,$07,$07,$07,$07,$07,$07,$07, $07,$07,$07,$07,$07,$07,$07,$07

.BANK $11 SLOT 1
.ORGA $4C80
.SECTION "SpriteBank3_Data" OVERWRITE
SpriteBank3Metadata:
	;08 Invalid
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;09 Red Mage?
	.db FULL_RED
	;0A Elder?
	.db FULL_YELLOW
	;0B Myron?
	.db FULL_BLUE
	;0C Guard?
	.db FULL_GREEN
	;0D Girl
	.db $02,$01,$02,$01,$02,$02,$02,$02, $02,$01,$02,$01,$02,$01,$02,$01
	;0E Man
	.db $07,$05,$07,$05,$07,$05,$07,$05, $07,$05,$07,$05,$07,$05,$07,$05
	;0F Boy
	.db $02,$05,$02,$05,$02,$05,$02,$05, $02,$05,$02,$05,$02,$05,$02,$05
	;10 Grandma
	.db FULL_BROWN
	;11 Grandpa
	.db FULL_BROWN
	;12 Scientist
	.db FULL_BROWN
	;13 Guy from the cave (and treasure box)
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$01,$01,$01,$01
	;14 Menu stuff
	.db $00,$00,$00,$00,$00,$00,$00,$00, $01,$01,$01,$01,$01,$01,$01,$01
	;15 Misc monsters
	.db FULL_BROWN
	;16 Misc monsters
	.db FULL_BROWN
	;17 Misc UI
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;18 Misc
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$01,$01,$01,$01
.ENDS

.ORGA $5000
.SECTION "SpriteBank4_Data" OVERWRITE
SpriteBank4Metadata:
	;00 Fungus/Mushroom
	.db FULL_BROWN
	;01 Starfish/Pentagon
	.db FULL_PURPLE
	;02 F-Drake/F-Liz/Salamand
	.db FULL_GREEN
	;03 Raven/Amprex/Griffon
	.db FULL_CYAN
	;04 Worm/Landworm/Gigaworm
	.db FULL_YELLOW
	;05 Turtle/Adamant/Igasaur
	.db FULL_GREEN
	;06 Whisper/Fireball
	.db FULL_RED
	;07 BIG EYE/EVIL EYE
	.db FULL_RED
	;08 BLACK CAT/MUMMYCAT
	.db FULL_PURPLE
	;09 SQUID/AMOEBA
	.db FULL_BLUE
	;0A TIRE/WHEEL/FIREFAN
	.db FULL_RED
	;0B BABYWYRM/WYRM KID/WYRM
	.db FULL_YELLOW
	;0C WOLF/GREYWOLF/ROMULUS
	.db FULL_BROWN
	;0D RAY/DRAINRAY/BOLTRAY
	.db FULL_BLUE
	;0E D.BONE/D.FOSSIL
	.db FULL_GRAY
	;0F TYPHOON/TEMPEST
	.db FULL_CYAN
	;10 SCORPION/HUNTER
	.db FULL_YELLOW
	;11 ANGLER/BULBFISH
	.db FULL_CYAN
	;12 DUALMASK/EVILMASK
	.db FULL_RED
	;13 GHOST/SPECTER
	.db FULL_GRAY
	;14 SNAKE/SERPENT/HYDRA
	.db FULL_GREEN
	;15 OCTOPUS/AMMONITE/KRAKEN
	.db FULL_PURPLE
	;16 BABY-D/YOUNG-D/SEI-RYU
	.db FULL_GREEN
	;17 GARGOYLE/REMORA/GARUDA
	.db FULL_GRAY
	;18 SILVER/KELPIE/MUSTANG/CENTAUR/NITEMARE
	.db FULL_YELLOW
	;19 ORC-ORC/MAD BOAR/PIRATE/WEREPIG/VIKING
	.db FULL_YELLOW
	;1A DIVINER/BROOMER/WITCH/MAGICIAN/WIZARD
	.db FULL_PURPLE
	;1B SPRITE/NYMPH/FAIRY/PIXIE/SYLPH
	.db FULL_PURPLE
	;1C MEDUSA/LAMIA/NAGA/SCYLLA/ECHIDNA
	.db FULL_GREEN
	;1D FISH MAN/MERMAN/NIX/SELKIE/GILL MAN
	.db FULL_GREEN
	;1E WATCHER/HERMIT/MAGE/SORCERER/WARLOCK
	.db FULL_PURPLE
	;1F THANOS/SOARX/SIREN/SUCCUBUS/SPHINX
	.db FULL_PURPLE
	;20 FIGHTER/WARRIOR/LIZ MAN/LIZ DUKE/LIZ KING
	.db FULL_GREEN
	;21 SEAMONK/SALTMONK/BROODER/BIG HEAD/DAGON
	.db FULL_CYAN
	;22 THOTH/HORUS/OSIRIS/SET/ANUBIS
	.db FULL_BROWN
	;23 FAMILIAR/FIEND/LOKI/MEPHISTO/AESHMA
	.db FULL_RED
	;24 HOOLIGAN/THIEF/BURGLER/BRIGAND/OUTLAW
	.db FULL_BROWN
	;25 QUACKY/STRANGER/IMPOSTER/LOONYGUY/CRACKER
	.db FULL_GRAY
	;26 SOLDIER/TERORIST/COMMANDO/HIREDGUN/SS
	.db FULL_GREEN
	;27 RONIN/SAMURAI/HATAMOTO/DAIMYO/SHOGUN
	.db FULL_BLUE
	;28 TALKER/BUSYBODY/RUMORER/TATTLER/VIRAGO
	.db FULL_RED
	;29 HEADLESS/DUKE/DULLAHAN/BRAIN/REMOVED
	.db FULL_PURPLE
	;2A ORB RAT/TOMTOM/JERRIT/MAITIE/SPECTRAT
	.db FULL_BROWN
	;2B FLOWER/COSMOS/IRONROSE/REAPER/CACTUS
	.db FULL_GREEN
	;2C GUARD/KEEPER/MONITOR/SEARCHER/ALERT
	.db FULL_GRAY
	;2D BAZOOKA/75MM/105MM/150MM/210MM
	.db FULL_GRAY
	;2E TRIXSTER/CON MAN/BEGUILER/SWINDLER/HUSTLER
	.db FULL_YELLOW
	;2F AIRMAID/IRONLADY/VALKYRIE/IKEN/VENUS
	.db FULL_GRAY
	;30 ARTHUR
	.db $01,$05,$01,$05,$05,$05,$05,$05, $01,$05,$01,$05,$01,$05,$01,$05
	;31 SHARON
	.db $01,$06,$01,$06,$01,$01,$01,$01, $01,$06,$01,$06,$01,$06,$01,$06
	;32 GLORIA
	.db $01,$04,$01,$04,$01,$04,$01,$04, $01,$04,$01,$04,$01,$04,$01,$04
	;33 MYRON
	.db FULL_BLUE
	;34 CURTIS
	.db $02,$03,$02,$03,$02,$03,$02,$03, $02,$03,$02,$03,$02,$03,$02,$03
	;35 LARA?
	.db FULL_RED
	;36 FAYE?
	.db FULL_PURPLE
	;37 BORGIN
	.db FULL_YELLOW
	;38 THE OTHER GUY
	.db FULL_BROWN
	;39 WATERHAG
	.db FULL_BLUE
	;3A DWELG
	.db FULL_BROWN
	;3B PURELAND ISLAND
	.db FULL_BLUE
	;3C FLOAT SPELL
	.db FULL_CYAN
	;3D TALON
	.db FULL_BLUE
	;3E VESSEL
	.db FULL_BLUE
	;3F BOAT
	.db FULL_BROWN
.ENDS

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
;	call SpriteSetPalette
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
	;Switch banks
	di
	ld a, WRAM_SPRITE_BANK
	ldh (<SVBK), a

	call WRAM_SPRITE_CODE + (SpriteRecordAddr_FarCode - SPRITECODE_FAR_START)
	
	;Switch banks back
	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a
	ei
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
	di
	ld a, WRAM_SPRITE_BANK
	ldh (<SVBK), a
	ld a, $11
	ld ($2100), a

	call WRAM_SPRITE_CODE + (SpriteFarCode - SPRITECODE_FAR_START)
	
	;Switch banks back
	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a
	ld a, $01
	ld ($2100), a
	ei

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
SPRITECODE_FAR_START:
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
	ld a, $11
	ld ($2100), a

	;load $D000 + C * 2 into HL
	ld h, $D0
	ld l, c
	sla l

	;load metatile bank from (HL) into HL
	ldi a, (hl)
	ld h, (hl)
	ld l, a
	
	;Load metatile data from metatile rom bank into b
	ld a, (hl)
	ld b, a

	ld a, $09
	ld ($2100), a

	ret

BattleSpriteFarCode:
	push bc
	push af
	ld a, $11
	ld ($2100), a

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

	ld a, $02
	ld ($2100), a
	pop hl

	ld a, b
	pop bc

	ret
SPRITECODE_FAR_END:
.ENDS

.BANK $9 SLOT 1
.ORGA $40F7
.SECTION "MenuSpriteLoad_Hook" OVERWRITE
;	call MenuSpriteLoad
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
;	call BattleSpriteLoad
.ENDS

.BANK 0 SLOT 0
.SECTION "BattleSpriteLoad_Code" FREE
BattleSpriteLoad:
	;original code, writes tile index
	ldi (hl), a

	;Switch banks
	push af
	ld a, WRAM_SPRITE_BANK
	ldh (<SVBK), a
	pop af

	call WRAM_SPRITE_CODE + (BattleSpriteFarCode - SPRITECODE_FAR_START)
	
	;Switch banks back
	push af
	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a
	pop af

	ldi (hl), a

	ret;
.ENDS
