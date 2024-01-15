; ****************************************
; *** DEFINITIONS & ROM INITIALIZATION ***
; ****************************************

.MEMORYMAP
    DEFAULTSLOT 1
    SLOTSIZE $4000
    SLOT 0 $0000
    SLOT 1 $4000
.ENDME

.ROMBANKSIZE $4000
.ROMBANKS 32                    ; 32 banks
.ROMSIZE 4
.ROMGBCONLY                     ; Writes $C0 ("GBC only") into $0143 (CGB flag)
.COMPUTEGBCOMPLEMENTCHECK       ; Computes the ROM complement check ($014D)
.COMPUTEGBCHECKSUM              ; Computes the ROM checksum ($014E-$014F)

.BACKGROUND "Final Fantasy Legend III (USA).gb"        ; This loads the ROM so we can write directly into it
.UNBACKGROUND $3E70 $3FFF       ; Free space in bank $00
; ...

.include "definitions.asm"		; Definitions
.include "macros.asm"			; Macros 

.BANK 0 SLOT 0
.ORG $0201
.SECTION "DxInitHook" OVERWRITE
	call DxInit
.ENDS

.BANK $00 SLOT 0
.SECTION "Init" FREE
 DxInit:
	push af
	ld a, 1
	ldh ($4D), a
	stop
	nop
	pop af

    push hl
    ld hl,InitBGPal
    call SET_BGPAL
    ld hl,InitOBJPal
    call SET_OBJPAL
    pop hl
    call $374A          ; Replaced code
    ret
 InitBGPal:
    .db $D6,$5A,$FF,$7F,$5A,$6B,$00,$00,$FF,$7F,$76,$53,$4F,$37,$00,$00,$FF,$7F,$53,$73,$2D,$6A,$00,$00
 InitOBJPal:
    .db $FF,$7F,$9F,$76,$DE,$71,$00,$00,$77,$77,$FF,$7F,$2D,$6A,$00,$00,$77,$77,$FF,$7F,$7B,$0E,$00,$00
.ENDS

.BANK 0 SLOT 0
.SECTION "BasicFunctions" FREE
 ; **SET BACKGROUND PALETTES**
 ; Writes $40 bytes located at HL to the BG Palette.
 SET_BGPAL:
    ld a,$80            ; Set index to first color + auto-increment
    ldh (<BCPS),a       
    ld b,64             ; 64=0x40 bytes
    
 ; Checks if $FF69 is accessible:
 LoopBGPAL:
    WAITBLANK
    
    ; Sets BG Palettes:
    ldi a,(hl)
    ldh (<BCPD),a
    dec b
    jr nz,LoopBGPAL
    ret

 ; **SET SPRITE PALETTES**
 ; Same as before but with the Sprites/OBJ Palette. 
 SET_OBJPAL:
    ld a, $80           ; Set index to first color + auto-increment
    ldh (<OCPS), a  ; 
    ld b, 64                ; 64=0x40 bytes
    
 ; Checks if $FF69 is accessible:
 LoopOBJPAL:
    WAITBLANK
    
    ; Sets OBJ Palettes:
    ldi a,(hl)
    ldh (<OCPD),a
    dec b
    jr nz,LoopOBJPAL
    ret
.ENDS

;data at ROM6:4700 is meta tiles... specifically the grass one?

.BANK 22 SLOT 1
.ORGA $4700
.SECTION "Metatile Attributes" OVERWRITE
MetatileAttr:
    .db $01,$01,$01,$01
.ENDS

.BANK 31 SLOT 1
.ORGA $7FFF
.SECTION "The End" OVERWRITE
    .db $FF
.ENDS

;00000 Main code
;04000 Unknown
;08000 Metatile and map data?
;0c000 string table?
;10000 Unknown
;14000 Unknown
;18000 Metatile and map data?
;1C000 Metatile and map data?
;20000 Metatile and map data?
;24000 Unknown
;28000 Unknown
;2C000 Unknown
;30000 Unknown
;34000 Unknown
;38000 Unknown
;3C000 Unknown

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
	
	ld a, 1 ;Todo: Replace this with useful color data from someplace!
	ldi (hl), a
	inc de
	inc de
	ld a, 1 ;Todo: Replace this with useful color data from someplace!
	ld (hl), a
	dec de
	ld bc, $0017
	add hl, bc
	ld a, 1 ;Todo: Replace this with useful color data from someplace!
	ldi (hl), a
	inc de
	inc de
	ld a, 1 ;Todo: Replace this with useful color data from someplace!
	ld (hl), a

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
	
	ld a, 1 ;Todo: Replace this with useful color data from someplace!
	ldi (hl), a
	inc de
	ld a, 1 ;Todo: Replace this with useful color data from someplace!
	ld (hl), a
	inc de
	ld bc, $0015
	add hl, bc
	ld a, 1 ;Todo: Replace this with useful color data from someplace!
	ldi (hl), a
	inc de
	ld a, 1 ;Todo: Replace this with useful color data from someplace!
	ld (hl), a

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
 LoadBufferToStage: ;TODO: Once we start doing actual tile data this will need to be a different call
	push hl
	push af
	inc d ;C9 block instead of C8
	
	;Add $80 for attributes
	ld a, l
	add a, $80
	ld l, a
	
_loop:
	ld a, (de)
	ldi (hl), a ;Todo: Replace this with useful color data from someplace!

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
