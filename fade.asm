
.BANK 0 SLOT 0
.ORGA $39Ea
.SECTION "FadeOut_Hook" OVERWRITE
	call FadeOut
.ENDS

.SECTION "FadeOut_Code" FREE	
FadeOut:
	push af
	push bc
	push de
	push hl
	
	di

	ld a, l
	sub a, $b4
	jr nc, _notzero
	ld a, 0
_notzero:
	srl a
	srl a
	ld c, a
		
	ld a, WRAM_PALETTE_BANK
	ldh (<SVBK), a
	
	;Load data from fade cache
    ld hl, WRAM_BGPALETTE_ADDR
	;HL = HL + (c * 0x40)
	ld a, c
	swap a
	sla a
	sla a
	add a, l
	ld l, a
	
	inc c

	ld a, $80            ; Set index to first color + auto-increment
    ldh (<BCPS),a       
    ld b, 64             ; 32 color entries=0x40 bytes

_LoopBGPAL:
	WAITBLANK
	ldi a, (hl)
    ldh (<BCPD),a
    dec b
    jr nz,_LoopBGPAL
	
	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a

	ei

	pop hl
	pop de
	pop bc
	pop af
	
	call $1F8D
	ret
.ENDS

; 0RRRRRGG GGGBBBBB
; 0RRRR0GG GG0BBBB0