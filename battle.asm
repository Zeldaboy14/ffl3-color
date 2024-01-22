
;2120 load enemy tiles
;01:6066 erase background for battle
;0f:7966 erase enemy after dying
;D000 enemy tiles
;0B:42D5 loads sequential tiles for enemies into d000 block

;Stack when loading enemies:
;$0B:$400D
;$0B:$4093



.BANK $00 SLOT 0
.ORGA $2120
.SECTION "EnemyLoadToVRAM_Hook" OVERWRITE
	;Enemies are always a multiple of 5 tiles wide?
	call EnemyLoad5ToVRAM
.ENDS

.BANK $0B SLOT 1
.ORGA $42D5
.SECTION "EnemyLoadToRam_Hook" OVERWRITE
	call EnemyLoadToRam
.ENDS

.SECTION "Battle_Code" FREE	
EnemyLoadToRam:
	push af
	ld a, WRAM_BATTLE_BANK
	ldh (<SVBK), a

	;For now, always palette 6.
	ld a, 6
	ld (hl), a

	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a
	pop af

	;Currently this just replicates the three bytes that the call above overwrote
	ldi (hl), a
	inc a
	dec c
	ret
.ENDS

.BANK $00 SLOT 0
.SECTION "BattleBase_Code" FREE
EnemyLoad5ToVRAM:
;NOTE: This code must be FAST to eliminate a race condition on the last boss.
;The Xagor effect removes the vblank hook and before it puts a new one in, vblank has happened.
;This hook currently has to check to see if its writing enemy tiles - we should probably figure
;out how to hook someplace that we can be certain already is doing enemy tiles.  But as it is now,
;checking the range ONCE for five writes is avoiding the crash.
;NOTE: This may also have been the crash on the Analogue Pocket.

	ld a, h
	cp $D0
	jr lst, _no
	ld a, d
	cp $98
	jr lst, _no

	ld a, WRAM_BATTLE_BANK
	ldh (<SVBK), a
	ld a, 1
	ldh (<VBK), a
	push hl
	push de

	ldi a, (hl)
	ld (de), a
	inc de
	ldi a, (hl)
	ld (de), a
	inc de
	ldi a, (hl)
	ld (de), a
	inc de
	ldi a, (hl)
	ld (de), a
	inc de
	ldi a, (hl)
	ld (de), a

	pop de
	pop hl

	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a
	ld a, 0
	ldh (<VBK), a
_no:
	;Currently this just replicates the three bytes that the call above overwrote
	ldi a, (hl)
	ld (de), a
	inc de

	ret
.ENDS