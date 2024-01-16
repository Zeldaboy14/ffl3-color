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
.UNBACKGROUND $3FFCE $3FFFF     ; Free space in bank $0F
; ...

.include "definitions.asm"		; Definitions
.include "macros.asm"			; Macros 
.include "metatileattr.asm"
.include "map.asm"
.include "textbox.asm"
.include "font.asm"

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
    .db $D6,$5A,$FF,$7F,$5A,$6B,$00,$00
	.db $DC,$22,$0A,$10,$96,$11,$00,$00
	.db $2A,$2A,$76,$53,$51,$23,$0A,$01
	.db $53,$73,$96,$6B,$2D,$6A,$00,$41
	.db $0C,$11,$5C,$53,$14,$32,$0A,$01
	.db $56,$3A,$9E,$6B,$1A,$5B,$00,$00
	.db $53,$73,$FF,$7F,$2D,$6A,$00,$00
	.db $08,$21,$00,$40,$D6,$5A,$FF,$7F
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

.BANK $1F SLOT 1
.ORGA $7FFF
.SECTION "The End" OVERWRITE
    .db $FF
.ENDS

;00000 Main code
;04000 Unknown
;08000 Metatile and map data?
;0c000 font, etc
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
