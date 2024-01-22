;Both buffers can occupy the same high byte block, because the MT buffer starts at $80
.DEFINE METATILE_BUFFER_H $DF
.DEFINE METATILE_STAGE_H $DF

;Game draws 24 tiles into the vram bg map for columns or rows, rather than all 32
;tilemap itself is loaded at d000 block
;All game metatiles are in ROM06, and our palette attribution information is in ROM16

;Writes Metatile data into first output buffer
;0a78 = load metatile to c880 when moving right
;0b2c = load metatile to c880 when moving left
;0a79~0aac is identical to 0b2d~0b60
;0be0 = load metatile to c880 when moving up
;0c99 = load metatile to c880 when moving down
;0be0~0c19 is identical to 0c9a~0cd2

.BANK 0 SLOT 0
.ORG $0A78
.SECTION "LoadMetatileToBufferRight_Hook" OVERWRITE
	call LoadMetatileColumnToBuffer
.ENDS
.ORG $0B2C
.SECTION "LoadMetatileToBufferLeft_Hook" OVERWRITE
	call LoadMetatileColumnToBuffer
.ENDS
.ORG $0BE0
.SECTION "LoadMetatileToBufferUp_Hook" OVERWRITE
	call LoadMetatileRowToBuffer
.ENDS
.ORG $0C99
.SECTION "LoadMetatileToBufferDown_Hook" OVERWRITE
	call LoadMetatileRowToBuffer
.ENDS

.SECTION "LoadMetatileToBuffer_Code" FREE
;Overrides original code that reads a metatile from de (<- ROM6) and into hl (-> $C880).
;Stores palette attribute data to block beginning at WRAM_METATILE_BANK::D880.
LoadMetatileRowToBuffer:
	push hl
	push de
	push bc
	push af
	
	ld h, METATILE_BUFFER_H
	
	ld a, $16
	ld (CHANGE_BANK), a
	ld a, WRAM_METATILE_BANK
	ldh (<SVBK), a
	
	ld a, (de)
	ldi (hl), a
	inc de
	inc de
	ld a, (de)
	ld (hl), a
	dec de
	ld bc, $0017
	add hl, bc
	ld a, (de)
	ldi (hl), a
	inc de
	inc de
	ld a, (de)
	ld (hl), a

	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a
	ld a, $06
	ld (CHANGE_BANK), a

	pop af
	pop bc
	pop de
	pop hl

	;Replicates the three bytes that this call replaced above
	ld a, (de)
	ldi (hl), a
	inc de
	ret

;Overrides original code that reads a metatile from de (<- ROM6) and into hl (-> $C880).
;Stores palette attribute data to block beginning at WRAM_METATILE_BANK::D880.
LoadMetatileColumnToBuffer:
	push hl
	push de
	push bc
	push af
	
	ld h, METATILE_BUFFER_H

	ld a, $16
	ld (CHANGE_BANK), a
	ld a, WRAM_METATILE_BANK
	ldh (<SVBK), a

	ld a, (de)
	ldi (hl), a
	inc de
	ld a, (de)
	ld (hl), a
	inc de
	ld bc, $0015
	add hl, bc
	ld a, (de)
	ldi (hl), a
	inc de
	ld a, (de)
	ld (hl), a

	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a
	ld a, $06
	ld (CHANGE_BANK), a

	pop af
	pop bc
	pop de
	pop hl

	;Replicates the three bytes that this call replaced above
	ld a, (de)
	ldi (hl), a
	inc de
	ret
.ENDS

;Write single tile data into second output buffer
;396D = load tile row IDs into C103~C11A from C880~C897
;399C = load tile col IDs into C103~C11A from C880~C897

.BANK 0 SLOT 0
.ORG $396D
.SECTION "LoadBufferToStageRow_Hook" OVERWRITE
	call LoadBufferToStage
.ENDS
.ORG $399C
.SECTION "LoadBufferToStageCol_Hook" OVERWRITE
	call LoadBufferToStage
.ENDS

.BANK $00 SLOT 0
.SECTION "LoadBufferToStage_Code" FREE
LoadBufferToStage:
	push hl
	push af
	push de
	ld d, METATILE_BUFFER_H
	ld h, METATILE_STAGE_H
	
	ld a, WRAM_METATILE_BANK
	ldh (<SVBK), a
	
_loop:
	ld a, (de)
	ldi (hl), a

	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a

	pop de
	pop af
	pop hl
	
	;Currently this just replicates the three bytes that the call above overwrote
	ld a, (de)
	ldi (hl), a
	inc de
	ret
.ENDS

;Write tile data into VRAM
;3766 = load bg tile row ids into vram from C103~C11A
;3777 = load bg tile col ids into vram from C103~C11A

.BANK $00 SLOT 0
.ORG $3766
.SECTION "HookUpdateMapVRAMRow" OVERWRITE
	call UpdateMapVRAM
.ENDS
.ORG $3777
.SECTION "HookUpdateMapVRAMCol" OVERWRITE
	call UpdateMapVRAM
.ENDS

.BANK $00 SLOT 0
.SECTION "UpdateMapVRAMCode" FREE
UpdateMapVRAM:
	push hl
	push af

	ld h, METATILE_STAGE_H

	ld a, 1
	ldh (<VBK), a
	ld a, WRAM_METATILE_BANK
	ldh (<SVBK), a

	ldi a, (hl)
	ld (de), a
	ld a, e

	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a
	ld a, 0
	ldh (<VBK), a
	
	pop af
	pop hl
	
	;Currently this just replicates the three bytes that the call above overwrote
	ldi a, (hl)
	ld (de), a
	ld a, e
	ret
.ENDS

; Enter clouds
; 3F6B ld (de) into (hl++) [de = C990, hl = 9F94] (oh hey this is my code isn't it)
; 3F75 ld (de) into (hl), inc de [de = C890, hl = 9F94] (me too)
; 5E09 ld (de) into (hl), ld a from ($c800) [de = 9F94, hl = 9B94]
; 3F6B ld (de) into (hl++) [de = C990, hl = 9F94] (oh hey this is my code isn't it)
; 3F75 ld (de) into (hl), inc de [de = C890, hl = 9F94] (me too)
; 5E09 ld (de) into (hl), ld a from ($c800) [de = 9F94, hl = 9B94]
; Exit clouds
; 3F6B ld (de) into (hl++) [de = C992, hl = 9F94] (oh hey this is my code isn't it)
; 3F75 ld (de) into (hl), inc de [de = C892, hl = 9F94] (me too)
; 5E09 ld (de) into (hl), ld a from ($c800) [de = 9F94, hl = 9B94]
; 3F6B ld (de) into (hl++) [de = C992, hl = 9F94] (oh hey this is my code isn't it)
; 3F75 ld (de) into (hl), inc de [de = C892, hl = 9F94] (me too)
; 5E09 ld (de) into (hl), ld a from ($c800) [de = 9F94, hl = 9B94]

.BANK $01 SLOT 1
.ORGA $5E09
.SECTION "SwapBGAndWindowVRAM_Hook" OVERWRITE
	call SwapBGAndWindowVRAM
	nop
	nop
.ENDS

.BANK $00 SLOT 0
.SECTION "SwapBGAndWindowVRAM_Code" FREE
SwapBGAndWindowVRAM:
	push hl
	push af

	ld a, 1
	ldh (<VBK), a

	ld a, (de)
	ld (hl), a

	ld a, 0
	ldh (<VBK), a
	
	pop af
	pop hl
	
	;Currently this just replicates the five bytes that the call above overwrote
	ld a, (de)
	ld (hl), a
	ld a, ($C800)
	ret
.ENDS

;794f clear screen?

;0E97 load map buffer from 4710?
;0EF5 load vram from buffer?
.BANK $00 SLOT 0
.ORG $0E97
.SECTION "HookLoadMapVRAMRow" OVERWRITE
	call LoadMetatileRowToBuffer
.ENDS
.ORG $0EF5
.SECTION "HookLoadBufferToStageRow" OVERWRITE
	call LoadBufferToVRAM
.ENDS

.SECTION "LoadBufferToVRAM_Code" FREE
 LoadBufferToVRAM:
	push hl
	push af
	push de
	
	ld d, METATILE_BUFFER_H
		
	ld a, 1
	ldh (<VBK), a
	ld a, WRAM_METATILE_BANK
	ldh (<SVBK), a

_loop:
	ld a, (de)
	ldi (hl), a ;Todo: Replace this with useful color data from someplace!

	pop de
	pop af
	pop hl
	
	ld a, WRAM_DEFAULT_BANK
	ldh (<SVBK), a
	ld a, 0
	ldh (<VBK), a
	
	;Currently this just replicates the three bytes that the call above overwrote
	ld a, (de)
	ld (hl), a
	inc de
	ret
.ENDS
