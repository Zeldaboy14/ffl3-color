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
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;0A Elder?
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;0B Myron?
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;0C Guard?
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;0D Girl
	.db $02,$01,$02,$01,$02,$02,$02,$02, $02,$01,$02,$01,$02,$01,$02,$01
	;0E Man
	.db $07,$05,$07,$05,$07,$05,$07,$05, $07,$05,$07,$05,$07,$05,$07,$05
	;0F Boy
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;10 Grandma
	.db $00,$07,$00,$07,$00,$07,$00,$07, $00,$07,$00,$07,$00,$07,$00,$07
	;11 Grandpa
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;12 Scientist
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;13 Guy from the cave
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;14 Menu stuff
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
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
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;1D FISH MAN/MERMAN/NIX/SELKIE/GILL MAN
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;1E WATCHER/HERMIT/MAGE/SORCERER/WARLOCK
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;1F THANOS/SOARX/SIREN/SUCCUBUS/SPHINX
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;20 FIGHTER/WARRIOR/LIZ MAN/LIZ DUKE/LIZ KING
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;21 SEAMONK/SALTMONK/BROODER/BIG HEAD/DAGON
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;22 THOTH/HORUS/OSIRIS/SET/ANUBIS
	.db FULL_BROWN
	;23 FAMILIAR/FIEND/LOKI/MEPHISTO/AESHMA
	.db FULL_RED
	;24 HOOLIGAN/THIEF/BURGLER/BRIGAND/OUTLAW
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;25 QUACKY/STRANGER/IMPOSTER/LOONYGUY/CRACKER
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;26 SOLDIER/TERORIST/COMMANDO/HIREDGUN/SS
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;27 RONIN/SAMURAI/HATAMOTO/DAIMYO/SHOGUN
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;28 TALKER/BUSYBODY/RUMORER/TATTLER/VIRAGO
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;29 HEADLESS/DUKE/DULLAHAN/BRAIN/REMOVED
	.db FULL_PURPLE
	;2A ORB RAT/TOMTOM/JERRIT/MAITIE/SPECTRAT
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;2B FLOWER/COSMOS/IRONROSE/REAPER/CACTUS
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;2C GUARD/KEEPER/MONITOR/SEARCHER/ALERT
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;2D BAZOOKA/75MM/105MM/150MM/210MM
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;2E TRIXSTER/CON MAN/BEGUILER/SWINDLER/HUSTLER
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;2F AIRMAID/IRONLADY/VALKYRIE/IKEN/VENUS
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;30 ARTHUR
	.db $01,$05,$01,$05,$01,$05,$01,$05, $01,$05,$01,$05,$01,$05,$01,$05
	;31 SHARON
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;32 GLORIA
	.db $01,$04,$01,$04,$01,$04,$01,$04, $01,$04,$01,$04,$01,$04,$01,$04
	;33 MYRON
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;34 CURTIS
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;35 LARA?
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;36 FAYE?
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;37 BORGIN
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;38 THE OTHER GUY
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;39 WATERHAG
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;3A DWELG
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;3B PURELAND ISLAND
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;3C FLOAT SPELL
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;3D TALON
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;3E VESSEL
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;3F BOAT
	.db $02,$02,$02,$02,$02,$02,$02,$02, $02,$02,$02,$02,$02,$02,$02,$02
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
	ld a, (de)
	and $E0
	or b

	pop bc

	;Original code, load result into (HL)
	ldi (hl), a
	inc de
	ld a, l
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
  	ld a, ($C0B1)
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
SPRITECODE_FAR_END:
.ENDS
