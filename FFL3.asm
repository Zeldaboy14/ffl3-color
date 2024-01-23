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
.CARTRIDGETYPE $1B				; MBC5 + RAM + Battery
.COMPUTEGBCOMPLEMENTCHECK       ; Computes the ROM complement check ($014D)
.COMPUTEGBCHECKSUM              ; Computes the ROM checksum ($014E-$014F)

.BACKGROUND "Final Fantasy Legend III (USA).gb"        ; This loads the ROM so we can write directly into it
.UNBACKGROUND $3E70 $3FFF       ; Free space in bank $00
.UNBACKGROUND $FF14 $FFFF       ; Free space in bank $03
.UNBACKGROUND $1BFD2 $1BFFF     ; Free space in bank $06
.UNBACKGROUND $1FFF0 $1FFFF     ; Free space in bank $07
.UNBACKGROUND $23FB2 $23FFF     ; Free space in bank $08
.UNBACKGROUND $27E98 $27FFF     ; Free space in bank $09
.UNBACKGROUND $2BD9A $2BFFF     ; Free space in bank $0A
.UNBACKGROUND $2FF74 $2FFFF     ; Free space in bank $0B
.UNBACKGROUND $33FB2 $33FFF     ; Free space in bank $0C
.UNBACKGROUND $37FE8 $37FFF     ; Free space in bank $0D
.UNBACKGROUND $3BF66 $3BFFF     ; Free space in bank $0E
.UNBACKGROUND $3FFCE $3FFFF     ; Free space in bank $0F
; ...

.include "definitions.asm"		; Definitions
.include "macros.asm"			; Macros 
.include "palettes.asm"

.include "metatileattr.asm"
.include "map.asm"
.include "textbox.asm"
.include "font.asm"
.include "fade.asm"
.include "battle.asm"
.include "system.asm"

.BANK 0 SLOT 0
.ORG $0201
.SECTION "DxInitHook" OVERWRITE
	call DxInit
.ENDS

.BANK $00 SLOT 0
.SECTION "Init" FREE
DxInit:
	;Set Fast CPU from main bank
	ld a, 1
	ldh ($4D), a
	stop
	nop

	ld a, 0x10
	ld (CHANGE_BANK), a

	call InitializeWRAM
	call InitializePalettes
    call CopyFarCodeToRAM

	ld a, 0x1
	ld (CHANGE_BANK), a

    call $374A          ; Replaced code
    ret
.ENDS

.BANK $1F SLOT 1
.ORGA $7FFF
.SECTION "The End" OVERWRITE
    .db $FF
.ENDS

;00000 Main code
;04000 Unknown
;08000 Art
;0c000 font, etc
;10000 Sprites
;14000 Tiles
;18000 Metatile data (and map data?)
;1C000 Metatile and map data?
;20000 Metatile and map data?
;24000 Unknown
;28000 Unknown
;2C000 Unknown
;30000 Unknown
;34000 Unknown
;38000 Unknown
;3C000 Unknown
