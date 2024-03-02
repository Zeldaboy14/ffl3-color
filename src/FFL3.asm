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

.BACKGROUND "Final Fantasy Legend III (USA).gb"
.UNBACKGROUND $3E70 $3FFF       ; Free space in bank $00
.UNBACKGROUND $7FF4 $7FFF       ; Free space in bank $01
.UNBACKGROUND $BFAC $BFFF       ; Free space in bank $02 (Including 4 X tiles that don't look important)
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

.include "macros.asm"			; Macros 

.include "definitions.asm"		; Definitions
.include "system.asm"
.include "font.asm"
.include "palettes.asm"
.include "metatiles.asm"
.include "menu.asm"
.include "battle.asm"
.include "sprites.asm"
.include "textbox.asm"
.include "title.asm"

;TODO: Reduce CPU usage when scrolling horizontally - runs slightly under target speed on Analogue Pocket
;TODO: Fix Analogue Pocket battle crash
;TODO: Fix ice spell color
;TODO: Fix dead character color

.BANK $1F SLOT 1
.ORGA $7FFF
.SECTION "The End" OVERWRITE
    .db $FF
.ENDS

;00000 Main code
;04000 Unknown
;08000 Spell sprites
;0c000 font, NPC sprites, effect sprites
;10000 Monster/Player Sprites
;14000 Tiles
;18000 Metatile data (and map data?)
;1C000 Unknown
;20000 Unknown
;24000 Menu code
;28000 Unknown
;2C000 Battle code
;30000 Unknown
;34000 Unknown
;38000 Unknown
;3C000 Textbox code

.BANK 0 SLOT 0
.ORG $0201
.SECTION "DxInitHook" OVERWRITE
	jp DxInitialize
.ENDS

.UNBACKGROUND $0204 $023E

.BANK $00 SLOT 0
.SECTION "Init" FREE
DxInitialize:
	;Set Fast CPU from main bank
	ld a, 1
	ldh ($4D), a
	stop
	nop

Reboot:
	ld sp, $CFFF

	SET_ROMBANK $10
	call InitializeSystem
	SET_ROMBANK $01

    SET_WRAMBANK WRAM_SCRATCH_BANK
    call $D000 + FFL3Initialize - FFL3_CODE_START
    RESET_WRAMBANK

	call $7C79
    jp $023F
.ENDS

.BANK $01 SLOT 1
.ORGA $5eb8
.SECTION "Disable_Battle_Effect_Entirely" OVERWRITE
;	ret
.ENDS

.BANK $01 SLOT 1
.ORGA $5EB8
.SECTION "Disable_Battle_Call_To_6013" OVERWRITE
;	nop;
;	nop
;	nop
.ENDS

.BANK $01 SLOT 1
.ORGA $5F0F
.SECTION "Disable_Battle_Call_To_4006" OVERWRITE
;	nop
;	nop
;	nop
.ENDS

.BANK $01 SLOT 1
.ORGA $603b
.SECTION "Experiment2" OVERWRITE
	call TEST
.ENDS

.BANK $00 SLOT 0
.SECTION "Experiment" FREE
TEST:
	ld a, $E3
	;ldh ($40), a
	ret
.ENDS

;00:10F0 calls the battle transition effect
;01:5EB8 is the battle transition effect
;01:6013 is the initial transition effect setup
;00:3A24 clears every fourth byte C000~C09C (shadow OAM X) hiding all the sprites

;.SECTION "SetIRQRoutines_FixedCode" FREE
;SetIRQRoutines:
;	di
;	jp $1F8D
;.ENDS
;
;.ORGA $1B57
;.SECTION "SetIRQRoutines_Hook1B57" OVERWRITE
;	;call SetIRQRoutines
;	nop
;	nop
;	nop
;
;.ENDS
;.ORGA $1B60
;.SECTION "SetIRQRoutines_Hook1B60" OVERWRITE
;	;call SetIRQRoutines
;		nop
;	nop
;	nop
;
;.ENDS
;.ORGA $1DE5
;.SECTION "SetIRQRoutines_Hook1DE5" OVERWRITE
;;	call SetIRQRoutines
;	nop
;	nop
;	nop
;.ENDS
;.ORGA $1DEE
;.SECTION "SetIRQRoutines_Hook1DEE" OVERWRITE
;;	call SetIRQRoutines
;	nop
;	nop
;	nop
;
;.ENDS
;.ORGA $1E20
;.SECTION "SetIRQRoutines_Hook1E20" OVERWRITE
;	;call SetIRQRoutines
;	nop
;	nop
;	nop
;.ENDS
;.ORGA $1E29
;.SECTION "SetIRQRoutines_Hook1E29" OVERWRITE
;	;call SetIRQRoutines
;	;nop
;	;nop
;	;nop
;.ENDS

;1E06 looks like "Pop IRQ handlers"
;CDD0 = shadow $FFFF
;CDCF = shadow $FF41
;CDCA = shadow $FF45
;1DD0 looks like "Set IRC handlers"
;1E06 again?

.BANK $09 SLOT 1
.ORGA $4ECF
.SECTION "RemoveMBC1Call_00" OVERWRITE
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
.ENDS

.ORGA $4EE0
.SECTION "RemoveMBC1Call_01" OVERWRITE
	nop
	nop
	nop
	nop
	nop
.ENDS

.BANK $00 SLOT 0
.ORGA $39CC
.SECTION "DontInitializeD000" OVERWRITE
	ld hl, $C000
	ld bc, $0100
.ENDS

.BANK $10 SLOT 1
.SECTION "TransplantedCode" FREE
FFL3_CODE_START:
FFL3Initialize:
	call $3727
	call $39B8
	ld   a,$01
	call $3910
;	xor  a
;	ldh  ($47),a
;	ldh  ($48),a
;	ldh  ($49),a
	ld   hl,$9800
	ld   bc,$0800
_loop:
	WAITBLANK
	ld   a,$FF
	ldi (hl), a
	dec bc
	ld a, b
	or c
	jr nz, _loop

	ld   hl,$11A2
	call $3D46
	ld   hl,$11E3
	call $3D5A
	xor  a
	ldh  ($41),a
	ld   a,$01
	ldh  ($FF),a
	ld   a,$C3
	ldh  ($40),a
	ei   
    ret
FFL3_CODE_END:
.ENDS

.SECTION "TransplantedFarCodeLoader" FREE APPENDTO "FarCodeLoader"
    ld a, WRAM_SCRATCH_BANK
    ld bc, FFL3_CODE_END - FFL3_CODE_START
    ld de, $D000
    ld hl, FFL3_CODE_START
    call CopyFarCodeToWRAM
.ENDS
