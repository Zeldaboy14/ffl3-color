.DEFINE WRAM_DEFAULT_BANK		0x01
.DEFINE WRAM_PALETTE_BANK 		0x02
.DEFINE WRAM_PALETTE_ADDR 		WRAM1
.DEFINE WRAM_BGPALETTE_ADDR 	WRAM1 + (InitialBGPal - ROM1)
.DEFINE WRAM_OBJPALETTE_ADDR 	WRAM1 + (InitialOBJPal - ROM1)


.BANK $10 SLOT 1
.SECTION "System_Code" FREE	
InitializePalettes:
	ld hl, InitialPal
	ld c, InitialPalEnd - InitialPal
	ld de, WRAM_PALETTE_ADDR
	ld a, WRAM_PALETTE_BANK
	ldh (<SVBK), a
_InitPaletteLoop:
	ldi a, (hl)
	ld (de), a
	inc de
	dec c
	jp nz, _InitPaletteLoop
	
    call InitializeBGPalettes
    call InitializeOBJPalettes

InitializeBGPalettes:
	di
	PUSH_ALL
	
	ld a, WRAM_PALETTE_BANK
	ldh (<SVBK), a

    ld hl,WRAM_BGPALETTE_ADDR
    ld a,$80            ; Set index to first color + auto-increment
    ldh (<BCPS),a       
    ld b,64             ; 64=0x40 bytes
_BGLoop:
    WAITBLANK    
    ; Sets BG Palettes:
    ldi a,(hl)
    ldh (<BCPD),a
    dec b
    jr nz,_BGLoop
	
	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a

	POP_ALL
	ei
    ret

InitializeOBJPalettes:
	di
	PUSH_ALL
	
	ld a, WRAM_PALETTE_BANK
	ldh (<SVBK), a

    ld hl,WRAM_OBJPALETTE_ADDR
    ld a, $80           ; Set index to first color + auto-increment
    ldh (<OCPS), a  ; 
    ld b, 64                ; 64=0x40 bytes
_OBJLoop:
    WAITBLANK
    ; Sets OBJ Palettes:
    ldi a,(hl)
    ldh (<OCPD),a
    dec b
    jr nz,_OBJLoop
	
	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a

	POP_ALL
	ei
    ret
.ENDS
