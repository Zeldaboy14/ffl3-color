.DEFINE WRAM_TITLE_CODE WRAM1 + $0200
.DEFINE WRAM_TITLE_DATA WRAM1 + $0400

;01:7D04 - this is the fade in call, replace with code to load title palette
.BANK $01 SLOT 1
.ORGA $7D04 ;Normal call to fade in title
.SECTION "InitializeTitle_Hook" OVERWRITE
	call InitializeTitle
.ENDS

.BANK $01 SLOT 1
.ORGA $7D28 ;Normal call to fade out title
.SECTION "DestroyTitle_Hook" OVERWRITE
	call DestroyTitle
.ENDS

.BANK $00 SLOT 0
.SECTION "Title_Code" FREE
InitializeTitle:
	push af
	FARCALL(WRAM_MENU_BANK, WRAM_TITLE_CODE + InitializeTitle_Far - TITLE_CODE_START)
	pop af
	ret

DestroyTitle:
	push af
	FARCALL(WRAM_MENU_BANK, WRAM_TITLE_CODE + DestroyTitle_Far - TITLE_CODE_START)
	pop af
	ret
.ENDS

.BANK $10 SLOT 1
.SECTION "Title" FREE
TITLE_CODE_START:
InitializeTitle_Far:
	push hl
	push de
	push bc
	push af

	ld hl, $9D60
	ld c, $01
	SET_VRAMBANK 1
_loopMapRow:
	ld b, $20
_loopMapColumn:
	WAITBLANK
	ld a, c
	ldi (hl), a
	dec b
	jr nz, _loopMapColumn
	inc c
	cp $07
	jr lst, _loopMapRow
	RESET_VRAMBANK

	ld de, $8000
	ld bc, $0200
_clearMushrooms:
	WAITBLANK
	xor a
	ld (de), a
	inc de
	dec bc
	;dec bc does not set the z flag for some dumb reason, so oring b and c here
	ld a, b
	or c
	jr nz, _clearMushrooms

	ld hl, WRAM_TITLE_DATA + SwordTiles - TITLE_DATA_START
	ld de, $8300
	ld bc, SwordTilesEnd - SwordTiles
_loopSpriteTiles:
	WAITBLANK
	ldi a, (hl)
	ld (de), a
	inc de
	dec bc
	;dec bc does not set the z flag for some dumb reason, so oring b and c here
	ld a, b
	or c
	jr nz, _loopSpriteTiles

	ld hl, WRAM_TITLE_DATA + SwordOAM - TITLE_DATA_START
	ld de, $C000
	ld bc, SwordOAMEnd - SwordOAM
_loopSpriteOAM:
	WAITBLANK
	ldi a, (hl)
	ld (de), a
	inc de
	dec bc
	;dec bc does not set the z flag for some dumb reason, so oring b and c here
	ld a, b
	or c
	jr nz, _loopSpriteOAM

	ld hl, WRAM_TITLE_DATA + TitlePal - TITLE_DATA_START
	ld a, $80            ; Set index to first color + auto-increment
	ldh (<BCPS),a       
	ld b, 64             ; 32 color entries=0x40 bytes
_loopTitlePalette:
	WAITBLANK
	ldi a, (hl)
	ldh (<BCPD),a
	dec b
	jr nz, _loopTitlePalette

	ld hl, WRAM_TITLE_DATA + SwordPalette - TITLE_DATA_START
	ld a, $80       ; Set index to second palette + auto-increment
	ldh (<OCPS), a
	ld b, 40
_loopSpritePalette:
	WAITBLANK
	ldi a, (hl)
	ldh (<OCPD), a
	dec b
	jr nz, _loopSpritePalette

	pop af
	pop bc
	pop de
	pop hl
	ret

DestroyTitle_Far:
	ld hl, WRAM_TITLE_DATA + TitlePal - TITLE_DATA_START
	ld a, $80            ; Set index to first color + auto-increment
	ldh (<BCPS),a       
	ld b, 64             ; 32 color entries=0x40 bytes
_loopBlackBGPalette:
	WAITBLANK
	xor a
	ldh (<BCPD),a
	dec b
	jr nz, _loopBlackBGPalette

	ld hl, WRAM_TITLE_DATA + SwordPalette - TITLE_DATA_START
	ld a, $80       ; Set index to second palette + auto-increment
	ldh (<OCPS), a
	ld b, 40
_loopBlackSpritePalette:
	WAITBLANK
	xor a
	ldh (<OCPD), a
	dec b
	jr nz, _loopBlackSpritePalette

	ld de, $C000
	ld bc, SwordOAMEnd - SwordOAM
_loopDestroySpriteOAM:
	WAITBLANK
	xor a
	ld (de), a
	inc de
	dec bc
	;dec bc does not set the z flag for some dumb reason, so oring b and c here
	ld a, b
	or c
	jr nz, _loopDestroySpriteOAM

	ret

TITLE_CODE_END:
TITLE_DATA_START:
SwordTiles:
	.db $00,$00,$30,$08,$44,$3C,$28,$18,$00,$00,$00,$10,$30,$08,$20,$18
	.db $30,$08,$20,$18,$10,$00,$00,$6C,$10,$44,$00,$D7,$10,$D6,$00,$28
	.db $00,$10,$00,$00,$08,$28,$28,$08,$28,$08,$28,$08,$28,$18,$28,$18
	.db $28,$18,$28,$18,$28,$18,$28,$18,$28,$18,$28,$18,$28,$18,$28,$18
	.db $28,$18,$28,$18,$28,$18,$28,$18,$28,$18,$28,$18,$28,$18,$28,$18
	.db $28,$18,$28,$18,$28,$18,$28,$18,$28,$18,$28,$18,$28,$18,$28,$18
	.db $28,$18,$28,$18,$28,$18,$08,$38,$00,$10,$10,$10,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$10,$00,$0F,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$10,$00,$E0,$00,$00,$00,$00
	.db $38,$38,$44,$44,$82,$82,$44,$44,$38,$38,$28,$28,$44,$44,$44,$44
	.db $44,$44,$44,$44,$6C,$6C,$92,$92,$AB,$AB,$28,$28,$29,$29,$D6,$D6
	.db $6C,$6C,$7C,$7C,$54,$54,$54,$54,$54,$54,$54,$54,$44,$44,$44,$44
	.db $44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44
	.db $44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44
	.db $44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44
	.db $44,$44,$44,$44,$44,$44,$44,$44,$28,$28,$28,$28,$10,$10,$10,$10
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$30,$30,$2F,$2F,$10,$10,$0F,$0F,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$18,$18,$E8,$E8,$10,$10,$E0,$E0,$00,$00
SwordTilesEnd:

SwordOAM:
	.db $18,$6F,$30,$01, $20,$6F,$31,$01, $28,$6F,$32,$02, $30,$6F,$33,$02
	.db $38,$6F,$34,$02, $40,$6F,$35,$02, $48,$6F,$36,$02, $50,$6F,$37,$02
	.db $18,$67,$38,$01, $20,$67,$39,$01, $18,$77,$3A,$01, $20,$77,$3B,$01
	.db $18,$6F,$3C,$03, $20,$6F,$3D,$03, $28,$6F,$3E,$03, $30,$6F,$3F,$03
	.db $38,$6F,$40,$03, $40,$6F,$41,$03, $48,$6F,$42,$03, $50,$6F,$43,$03
	.db $18,$67,$44,$03, $20,$67,$45,$03, $18,$77,$46,$03, $20,$77,$47,$03
	.db $53,$52,$18,$04
SwordOAMEnd:

SwordPalette:
    .dw $7FFF,$7FFF,$6B5A,$0000
	.dw $7FFF,$129F,$1578,$1090
	.dw $7FFF,$7FFF,$7353,$7E88
	.dw $7FFF,$7FFF,$2390,$0000
	.dw $7FFF,$7FFF,$7353,$129F
SwordPaletteEnd:

UndoSwordOAM:
	.db $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00
	.db $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00
	.db $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00
	.db $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00
	.db $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00
	.db $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00
	.db $53,$52,$18,$00
UndoSwordOAMEnd:

TitlePal:
    .dw $1578,$4008,$1090,$129F
    .dw $0000,$3827,$1090,$7FFF
    .dw $0000,$3026,$1090,$7FFF
    .dw $0000,$2825,$1090,$7FFF
    .dw $0000,$2024,$1090,$4210
    .dw $0000,$1803,$1090,$4210
    .dw $0000,$1002,$1090,$4210
    .dw $0000,$0801,$1090,$4210
TitlePalEnd:
TITLE_DATA_END:
.ENDS

.BANK $0 SLOT 0
.ORGA $39C2
.SECTION "DontErase" OVERWRITE
;    ld hl, $C100
 ;   ld bc, $0E00
.ENDS

.SECTION "TitleFarCodeLoader" FREE APPENDTO "FarCodeLoader"
	ld a, WRAM_MENU_BANK
	ld bc, TITLE_CODE_END - TITLE_CODE_START
	ld de, WRAM_TITLE_CODE
	ld hl, TITLE_CODE_START
	call CopyFarCodeToWRAM

	ld a, WRAM_MENU_BANK
	ld bc, TITLE_DATA_END - TITLE_DATA_START
	ld de, WRAM_TITLE_DATA
	ld hl, TITLE_DATA_START
	call CopyFarCodeToWRAM
.ENDS
