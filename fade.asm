.DEFINE WRAM_Fadeout WRAM_FADE_CODE + FadeOut_Far - FADECODE_FAR_START

.BANK $0F SLOT 1
.ORGA $7EBC
.SECTION "WarpFadeOut_Hook" OVERWRITE
	call FadeOut
.ENDS

.BANK 0 SLOT 0
.ORGA $39Ea
.SECTION "FadeOut_Hook" OVERWRITE
	call FadeOut
.ENDS

.SECTION "FadeOut_Code" FREE	
FadeOut:
	di
	;push af

	SET_WRAMBANK WRAM_PALETTE_BANK
	call WRAM_Fadeout
	RESET_WRAMBANK

	;pop af
	ei

	;Call the code replaced by the hook above
	call $1F8D

	ret
.ENDS

.BANK $10 SLOT 1
.SECTION "FadeOut_Far" FREE
FADECODE_FAR_START:
FadeOut_Far:
	push af
	push bc
	push de
	push hl
	
	ld a, l
	sub a, $b4
	jr nc, _notzero
	ld a, 0
_notzero:
	srl a
	srl a
	ld c, a

	cp 2
	jr neq, _dontresetpalette
	ld a, 0
	ld ($DFFF), a
	ld a, 7
	ldh ($F0), a
_dontresetpalette:

    ld hl, WRAM_BGPALETTE_ADDR
	ld a, ($DFFF)
	swap a
	sla a
	sla a
	add a, l
	ld l, a

_LoadBGPal:
	;HL = HL + (0x100 * c)
	ld a, c
	add a, h
	ld h, a
	
	ld a, $80            ; Set index to first color + auto-increment
    ldh (<BCPS),a       
    ld b, 64             ; 32 color entries=0x40 bytes
_LoopBGPAL:
	WAITBLANK
	ldi a, (hl)
    ldh (<BCPD),a
    dec b
    jr nz,_LoopBGPAL

_LoadOBJPal:
    ld hl, WRAM_OBJPALETTE_ADDR
	;HL = HL + (0x100 * c)
	ld a, c
	add a, h
	ld h, a

	ld a, $80            ; Set index to first color + auto-increment
    ldh (<OCPS),a       
    ld b, 64             ; 32 color entries=0x40 bytes
_LoopOBJPAL:
	WAITBLANK
	ldi a, (hl)
    ldh (<OCPD),a
    dec b
    jr nz,_LoopOBJPAL
	
	pop hl
	pop de
	pop bc
	pop af
	ret
FADECODE_FAR_END:
.ENDS

; 0RRRRRGG GGGBBBBB
; 0RRRR0GG GG0BBBB0