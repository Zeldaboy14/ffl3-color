;Sprite tiles are found roughly between $10000 and $18000 in ROM.  We only care about them in $40 byte blocks

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
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
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
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;01 Starfish/Pentagon
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;02 F-Drake/F-Liz/Salamand
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;03 Raven/Amprex/Griffon
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;04 Worm/Landworm/Gigaworm
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;05 Turtle/Adamant/Igasaur
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;06 Whisper/Fireball
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;07 BIG EYE/EVIL EYE
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;08 BLACK CAT/MUMMYCAT
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;09 SQUID/AMOEBA
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;0A TIRE/WHEEL/FIREFAN
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;0B BABYWYRM/WYRM KID/WYRM
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;0C WOLF/GREYWOLF/ROMULUS
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;0D RAY/DRAINRAY/BOLTRAY
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;0E D.BONE/D.FOSSIL
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;0F TYPHOON/TEMPEST
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;10 SCORPION/HUNTER
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;11 ANGLER/BULBFISH
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;12 DUALMASK		2D EVILMASK
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;13 GHOST		2F SPECTER
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;14 SNAKE		31 SERPENT		32 HYDRA
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;15 OCTOPUS		34 AMMONITE		35 KRAKEN
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;16 BABY-D		37 YOUNG-D		38 SEI-RYU
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;17 GARGOYLE		3A REMORA		3B GARUDA
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;18 SILVER		3D KELPIE		3E MUSTANG		3F CENTAUR		40 NITEMARE
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;19 ORC-ORC		42 MAD BOAR 	43 PIRATE		44 WEREPIG		45 VIKING
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;1A DIVINER		47 BROOMER		48 WITCH		49 MAGICIAN		4A WIZARD
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;1B SPRITE		4C NYMPH		4D FAIRY		4E PIXIE		4F SYLPH
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;1C MEDUSA		51 LAMIA		52 NAGA			53 SCYLLA		54 ECHIDNA
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;1D FISH MAN 	56 MERMAN		57 NIX			58 SELKIE		59 GILL MAN
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;1E WATCHER		5B HERMIT		5C MAGE			5D SORCERER		5E WARLOCK
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;1F THANOS		60 SOARX		61 SIREN		62 SUCCUBUS		63 SPHINX
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;20 FIGHTER		65 WARRIOR		66 LIZ MAN 		67 LIZ DUKE		68 LIZ KING
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;21 SEAMONK		6A SALTMONK		6B BROODER		6C BIG HEAD 	6D DAGON
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;22 THOTH		6F HORUS		72 OSIRIS		73 SET 			76 ANUBIS
	.db $07,$07,$07,$07,$07,$07,$07,$07, $07,$07,$07,$07,$07,$07,$07,$07
	;23 FAMILIAR		71 FIEND		74 LOKI			75 MEPHISTO		77 AESHMA
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;24 HOOLIGAN		79 THIEF		7A BURGLER		7B BRIGAND		7C OUTLAW
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;25 QUACKY		7E STRANGER		7F IMPOSTER		80 LOONYGUY		81 CRACKER
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;26 SOLDIER		83 TERORIST		84 COMMANDO		85 HIREDGUN		86 SS
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;27 RONIN		88 SAMURAI		89 HATAMOTO		8A DAIMYO		8B SHOGUN
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;28 TALKER		8D BUSYBODY		8E RUMORER		8F TATTLER		90 VIRAGO
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;29 HEADLESS		92 DUKE			93 DULLAHAN		94 BRAIN 		95 REMOVED
	.db $06,$06,$06,$06,$06,$06,$06,$06, $06,$06,$06,$06,$06,$06,$06,$06
	;2A ORB RAT 		97 TOMTOM		98 JERRIT		99 MAITIE		9A SPECTRAT
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;2B FLOWER		9C COSMOS		9D IRONROSE		9E REAPER		9F CACTUS
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;2C GUARD		A1 KEEPER		A2 MONITOR		A3 SEARCHER		A4 ALERT
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;2D BAZOOKA		A6 75MM			A7 105MM		A8 150MM		A9 210MM
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;2E TRIXSTER		AB CON MAN 		AC BEGUILER		AD SWINDLER		AE HUSTLER
	.db $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	;2F AIRMAID		B0 IRONLADY		B1 VALKYRIE		B2 IKEN			B3 VENUS
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
	ld a, $11
	ld ($2100), a

	call SpriteRecordAddr_FarCode
	
	;Switch banks back
	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a
	ld a, ($C0B1)
	ld ($2100), a
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

	call SpriteFarCode
	
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

.BANK $11 SLOT 1
.SECTION "Sprite_FarCode" FREE
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
.ENDS
