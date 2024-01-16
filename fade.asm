
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
	sub a, $b0
	jr nc, _notzero
	ld a, 0
_notzero:
	srl a
	srl a
	add a, 1
	ld d, a
	ld e, a
	
    ld hl, InitBGPal

	ld a, $80            ; Set index to first color + auto-increment
    ldh (<BCPS),a       
    ld b, 32             ; 32 color entries=0x40 bytes
    
 ; Checks if $FF69 is accessible:
 _LoopBGPAL:    
	push de
	
    ; Sets BG Palettes:
    WAITBLANK
    ldi a,(hl)	
_loopA:
	dec d
	jr z, _doneA
	and a, $DE
	srl a
	jr _loopA
_doneA:
    ldh (<BCPD),a

    WAITBLANK
	ldi a, (hl)
_loopB:
	dec e
	jr z, _doneB
	and a, $7B	
	srl a
	jr _loopB
_doneB:
    ldh (<BCPD),a

    dec b
	pop de
    jr nz,_LoopBGPAL

	pop hl
	pop de
	pop bc
	pop af
	ret
.ENDS

; 0RRRRRGG GGGBBBBB
; 0RRRR0GG GG0BBBB0