.DEFINE WRAM_PALETTE_ADDR       WRAM1
.DEFINE WRAM_PALETTE_SIZE       $40
.DEFINE WRAM_PALETTE_FADECOUNT  $04
.DEFINE WRAM_BGPALETTE_ADDR     WRAM1
.DEFINE WRAM_OBJPALETTE_ADDR    WRAM1 + WRAM_PALETTE_SIZE
.DEFINE WRAM_BATTLEPALETTE_ADDR WRAM1 + WRAM_PALETTE_SIZE * 2
.DEFINE WRAM_TITLEPALETTE_ADDR  WRAM1 + WRAM_PALETTE_SIZE * 3
.DEFINE WRAM_PALETTE_LOOKUP     WRAM1 + $0300
.DEFINE WRAM_PALETTE_CODE       WRAM1 + $0400

.BANK $0F SLOT 1
.ORGA $7EBC
.SECTION "SetFade_Hook7EBC" OVERWRITE
    call SetFadeWithHL
.ENDS

.BANK 0 SLOT 0
.ORGA $39EA
.SECTION "SetFade_Hook39EA" OVERWRITE
    call SetFadeWithHL
.ENDS

.BANK $00 SLOT 0
.SECTION "Fade_Code" FREE
SetFadeWithHL:
    ld a, (hl)
    call SetFade

    ;Call the code replaced by the hook above
    call $1F8D

    ret

;a = Gameboy BGP Value
SetFade:
    FARCALL(WRAM_PALETTE_BANK, WRAM_PALETTE_CODE + SetFade_Far - PALETTE_CODE_START)
    ret
.ENDS

.BANK $10 SLOT 1
.SECTION "Palettes" FREE
InitialPal:
InitialBGPal:
    .dw $5A54,$7FFF,$6AD8,$0000
    .dw $2110,$295F,$2538,$0000
    .dw $2A2A,$5376,$2351,$0000
    .dw $6A2D,$7FFF,$7353,$4100
    .dw $110C,$535C,$3214,$0000
    .dw $3A56,$6B9E,$5B1A,$0000
    .dw $723A,$7FFF,$6A9F,$0000
    .dw $2108,$4000,$5AD6,$7FFF
InitialOBJPal:
    .dw $7FFF,$7FFF,$6B5A,$0000
    .dw $7FFF,$7FFF,$211F,$0000
    .dw $7FFF,$7FFF,$031F,$0000
    .dw $7FFF,$7FFF,$2390,$0000
    .dw $7FFF,$7FFF,$7353,$0000
    .dw $7FFF,$7FFF,$7E88,$0000
    .dw $7FFF,$7FFF,$7E1C,$0000
    .dw $7FFF,$7FFF,$3214,$0000
InitialBattlePal:
    .dw $5AD6,$7FFF,$6B5A,$0000
    .dw $0010,$7FFF,$211F,$0000
    .dw $01B4,$7FFF,$031F,$0000
    .dw $2200,$7FFF,$2390,$0000
    .dw $6A2D,$7FFF,$7353,$0000
    .dw $7000,$7FFF,$7E88,$0000
    .dw $7010,$7FFF,$7E1C,$0000
    .dw $2108,$4000,$5AD6,$7FFF
InitialTitlePal:
    .dw $1578,$4008,$1090,$129F
    .dw $0000,$3827,$1090,$7FFF
    .dw $0000,$3026,$1090,$7FFF
    .dw $0000,$2825,$1090,$7FFF
    .dw $0000,$2024,$1090,$4210
    .dw $0000,$1803,$1090,$4210
    .dw $0000,$1002,$1090,$4210
    .dw $0000,$0801,$1090,$4210
InitialPalEnd:

PaletteLookup:
    .db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    .db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    .db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    .db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    .db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    .db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    .db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    .db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
    .db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
    .db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
    .db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
    .db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
    .db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    .db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
    .db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
.ENDS

.BANK $10 SLOT 1
.SECTION "PaletteCode" FREE
;Initialize fade lookup tables
InitializeFadeLookup:
    di
    PUSH_ALL
        
    SET_WRAMBANK WRAM_PALETTE_BANK

    ld hl, WRAM_PALETTE_ADDR
    ld c, 1 
    ld b, $FF
    call LoadFadeLevel

    ld hl, WRAM_BGPALETTE_ADDR + (WRAM_PALETTE_SIZE * 8)
    ld b, $FF
    call LoadFadeBlack

    RESET_WRAMBANK

    POP_ALL
    ei
    ret

LoadFadeLevel:
    PUSH_ALL
    inc c
    srl b

_colorLoop:
    ldi a, (hl)
    ld e, a
    ldi a, (hl)
    ld d, a
    push bc
 _fadeLoop:
    dec c
    jp z, _fadeLoopDone
    ld a, d
    and a, $7B
    srl a
    ld d, a
    ld a, e
    rr a
    and a, $EF
    ld e, a
    jr _fadeLoop
_fadeLoopDone:
    pop bc
    push hl

    ;HL = HL - 2 + (0x100 * (c - 1))
    ld a, c
    dec a
    add a, h
    ld h, a
    dec l
    dec l
    
    ld a, e
    ldi (hl), a
    ld a, d
    ldi (hl), a
    
    pop hl

    dec b
    jr nz, _colorLoop
    
    POP_ALL
    ret

;Load black palette into cache.  Requires wram bank already set
;@param HL  Target address
;@param B   Count
LoadFadeBlack:
    push af
    push bc

    ld a, 0
@loop:
    ldi (hl), a 
    dec b
    jr nz, @loop
    
    pop bc
    pop af
    ret
.ENDS

.BANK $10 SLOT 1
.SECTION "PaletteFarCode" FREE
PALETTE_CODE_START:
;a = Gameboy BGP value
SetFade_Far:
    push af
    push bc
    push de
    push hl

    ld hl, WRAM_PALETTE_LOOKUP
    ld l, a
    ld a, (hl)
    
_notzero:
    ld c, a
    ld a, ($DFFE)
    cp c
    jr equ, _done

    ld a, c
    ld ($DFFE), a

    cp 2
    jr neq, _dontresetpalette
    ld a, 0
    ld ($DFFF), a
_dontresetpalette:

    ld hl, WRAM_BGPALETTE_ADDR
    ldh a, ($8B) ;FFL2 battle flag
    and $02
    ld b, a
    ldh a, ($E0) ;Our title screen flag
    add b
    swap a
    sla a
    sla a
    add a, l
    ld l, a

_LoadBGPal:
    ;HL = HL + (0x100 * c)
    ld a, c
    add a, h
    ld h, a
    
    ld a, $80            ; Set index to first color + auto-increment
    ldh (<BCPS),a       
    ld b, 64             ; 32 color entries=0x40 bytes
_LoopBGPAL:
    WAITBLANK
    ldi a, (hl)
    ldh (<BCPD),a
    dec b
    jr nz,_LoopBGPAL

_LoadOBJPal:
    ld hl, WRAM_OBJPALETTE_ADDR
    ;HL = HL + (0x100 * c)
    ld a, c
    add a, h
    ld h, a

    ld a, $80            ; Set index to first color + auto-increment
    ldh (<OCPS),a       
    ld b, 64             ; 32 color entries=0x40 bytes
_LoopOBJPAL:
    WAITBLANK
    ldi a, (hl)
    ldh (<OCPD),a
    dec b
    jr nz,_LoopOBJPAL
    
_done:
    pop hl
    pop de
    pop bc
    pop af
    ret
PALETTE_CODE_END:
.ENDS

.SECTION "PaletteFarCodeLoader" FREE APPENDTO "FarCodeLoader"
    SET_WRAMBANK WRAM_PALETTE_BANK
    xor a
    ld ($DFFF), a

    ld a, WRAM_PALETTE_BANK
    ld bc, InitialPalEnd - InitialPal
    ld de, WRAM_PALETTE_ADDR
    ld hl, InitialPal
    call CopyFarCodeToWRAM

    call InitializeFadeLookup

    ld a, WRAM_PALETTE_BANK
    ld bc, $0100
    ld de, WRAM_PALETTE_LOOKUP
    ld hl, PaletteLookup
    call CopyFarCodeToWRAM

    ld a, WRAM_PALETTE_BANK
    ld bc, PALETTE_CODE_END - PALETTE_CODE_START
    ld de, WRAM_PALETTE_CODE
    ld hl, PALETTE_CODE_START
    call CopyFarCodeToWRAM
.ENDS
