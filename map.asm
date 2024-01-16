
;Game draws 24 tiles into the vram bg map for columns or rows, rather than all 32

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

.SECTION "LoadMetatileColumnToBuffer_Code" FREE
 LoadMetatileRowToBuffer:
	push hl
	push de
	push bc
	push af
	inc h ;C9 block instead of C8
	
	ld a, $16
	ld (CHANGE_BANK), a
	
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

.SECTION "LoadMetatileRowToBuffer_Code" FREE
 LoadMetatileColumnToBuffer:
	push hl
	push de
	push bc
	push af
	inc h ;C9 block instead of C8
	
	ld a, $16
	ld (CHANGE_BANK), a

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

;Write tile data into second output buffer
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
	inc d ;C9 block instead of C8
	
	;Add $80 for attributes
	ld a, l
	add a, $80
	ld l, a
	
_loop:
	ld a, (de)
	ldi (hl), a

	dec d
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
	ld a, 1
	ldh (<VBK), a

	;Add $80 for attributes
	ld a, l
	add a, $80
	ld l, a

	ldi a, (hl)
	ld (de), a
	ld a, e

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
	inc d ;C9 block instead of C8
		
	ld a, 1
	ldh (<VBK), a

_loop:
	ld a, (de)
	ldi (hl), a ;Todo: Replace this with useful color data from someplace!

	dec d
	pop af
	pop hl
	
	ld a, 0
	ldh (<VBK), a
	
	;Currently this just replicates the three bytes that the call above overwrote
	ld a, (de)
	ld (hl), a
	inc de
	ret
.ENDS
