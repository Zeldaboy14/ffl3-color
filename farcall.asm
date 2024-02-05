.BANK $0 SLOT 0
.ORGA $0010
.SECTION "FarCall_Rst" OVERWRITE
	jp FarRAMCall
.ENDS

.SECTION "FarCall_Code" FREE
FarRAMCall:
	di

	;Stash args someplace else
	ldh ($F1), a
	ld a, l
	ldh ($F2), a
	ld a, h
	ldh ($F3), a
	;48 cycles

	;Get current return address into HL
	;ld hl, SP+0
	;ldi a, (hl)
	;ld h, (hl)
	;ld l, a
	pop hl
	;60 cycles

	;Get RAMBANK into (<SVBK)
	ldi a, (hl)
	ldh (<SVBK), a
	;80 cycles

	;Get RAMADDR jp command into $F8~FA
	ld a, $C3
	ldh ($F8), a
	ldi a, (hl)
	ldh ($F9), a
	ld a, (hl)
	ldh ($FA), a
	;140 cycles

	;Replace return vector
	ld hl, _ret
	push hl
	;168 cycles

	;Get args back
	ldh a, ($F3)
	ld h, a
	ldh a, ($F2)
	ld l, a
	ldh a, ($F1)
	;212 cycles

	jp $FFF8
	;228 cycles
_ret:
	;Reset the RAMBANK
	xor a
   	ldh (<SVBK), a
  	reti
  	;260 cycles vs approximately 64 cycles for a hard coded RAM call
.ENDS
