.DEFINE WRAM_DEFAULT_BANK		0x01
.DEFINE WRAM_WORKEXT_BANK		0x02
.DEFINE WRAM_PALETTE_BANK 		0x03
.DEFINE WRAM_PALETTE_ADDR 		WRAM1
.DEFINE WRAM_PALETTE_SIZE		0x40
.DEFINE WRAM_PALETTE_FADECOUNT	0x4
.DEFINE WRAM_BGPALETTE_ADDR 	WRAM1
.DEFINE WRAM_OBJPALETTE_ADDR 	WRAM1 + WRAM_PALETTE_SIZE

.BANK $10 SLOT 1
.SECTION "System_Code" FREE	
InitializePalettes:
	ld a, WRAM_PALETTE_BANK
	ldh (<SVBK), a

	ld hl, InitialBGPal
	ld c, WRAM_PALETTE_SIZE
	ld de, WRAM_PALETTE_ADDR
_InitBGPaletteLoop:
	ldi a, (hl)
	ld (de), a
	inc de
	dec c
	jp nz, _InitBGPaletteLoop

	ld hl, InitialOBJPal
	ld c, WRAM_PALETTE_SIZE
	ld de, WRAM_OBJPALETTE_ADDR
_InitOBJPaletteLoop:
	ldi a, (hl)
	ld (de), a
	inc de
	dec c
	jp nz, _InitOBJPaletteLoop
	
    call InitializeBGPalettes
    call InitializeOBJPalettes
	call InitializeFadeLookup
	ret

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

;Initialize fade lookup tables
InitializeFadeLookup:
	di
	PUSH_ALL
		
	ld a, WRAM_PALETTE_BANK
	ldh (<SVBK), a

	ld hl, WRAM_PALETTE_ADDR
	ld c, 1	
	ld b, WRAM_PALETTE_SIZE * 2
	call LoadFadeLevel
	ld hl, WRAM_BGPALETTE_ADDR + (WRAM_PALETTE_SIZE * 8)
	ld b, WRAM_PALETTE_SIZE * 2
	call LoadFadeBlack
	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a

	POP_ALL
	ei
	ret

LoadFadeLevel:
	PUSH_ALL
	inc c
	srl b

_colorLoop:
	ldi a, (hl)
	ld e, a
	ldi a, (hl)
	ld d, a
	push bc
 _fadeLoop:
	dec c
	jp z, _fadeLoopDone
	ld a, d
	and a, $7B
	srl a
	ld d, a
	ld a, e
	rr a
	and a, $EF
	ld e, a
	jr _fadeLoop
_fadeLoopDone:
	pop bc
	push hl

	;HL = HL - 2 + (0x100 * (c - 1))
	ld a, c
	dec a
	add a, h
	ld h, a
	dec l
	dec l
	
	ld a, e
    ldi (hl), a
	ld a, d
    ldi (hl), a
	
	pop hl

    dec b
    jr nz, _colorLoop
	
	POP_ALL
	ret

;Load black palette into cache.  Requires wram bank already set
;@param HL	Target address
;@param B	Count
LoadFadeBlack:
	push af
	push bc

	ld a, 0
@loop:
	ldi (hl), a	
    dec b
    jr nz, @loop
	
	pop bc
	pop af
	ret
.ENDS
