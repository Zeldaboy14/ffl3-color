
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
	
	ld a, l
	sub a, $b4
	jr nc, _notzero
	ld a, 0
_notzero:
	srl a
	srl a
	inc a
	ld c, a
	
    ld hl, InitBGPal
	
	;0 10110 10110 10110
	;0 01011 01011 01011
	;0 00101 00001 00101

	ld a, $80            ; Set index to first color + auto-increment
    ldh (<BCPS),a       
    ld b, 32             ; 32 color entries=0x40 bytes

_LoopBGPAL:
	ldi a, (hl)
	ld e, a
	ldi a, (hl)
	ld d, a
	push bc
 _loop:
	dec c
	jp z, _done
	ld a, d
	and a, $7B
	srl a
	ld d, a
	ld a, e
	rr a
	and a, $EF
	ld e, a
	jr _loop
_done:
	WAITBLANK

	ld a, e
    ldh (<BCPD),a
	ld a, d
    ldh (<BCPD),a

	pop bc

    dec b
    jr nz,_LoopBGPAL

	pop hl
	pop de
	pop bc
	pop af
	
	call $1F8D
	ret
.ENDS

; 0RRRRRGG GGGBBBBB
; 0RRRR0GG GG0BBBB0