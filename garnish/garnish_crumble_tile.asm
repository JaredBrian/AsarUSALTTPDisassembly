
; ==============================================================================

; $04B613-$04B626 DATA
Pool_Garnish_CrumbleTile:
{
    .chr
    db $80, $CC, $CC, $EA, $EA
    
    .properties
    db $30, $31, $31, $31, $31
    
    .oam_sizes
    db $00, $02, $02, $02, $02
    
    ; NOTE: The x and y offset is considered the same for this object, no
    ; fancy stuff going on here.
    .xy_offsets
    db 4, 0, 0, 0, 0
    
}

; ==============================================================================

; $04B627-$04B6BF JUMP LOCATION
Garnish_CrumbleTile:
{
    ; Special animation 0x03
    
    ; Placing the pit tile is only intended to happen on the first
    ; frame that this garnish is active.
    LDA.l $7FF90E, X : CMP.B #$1E : BNE .dont_place_pit_tile
    
    LDA.b $11 : ORA.w $0FC1 : BNE .just_draw
    
    PHA
    
    LDA.l $7FF83C, X : STA.b $00
    LDA.l $7FF878, X : STA.b $01
    
    LDA.l $7FF81E, X : SEC : SBC.b #$10 : STA.b $02
    LDA.l $7FF85A, X : SEC : SBC.b #$00 : STA.b $03
    
    PHX
    
    ; Replace the targeted tile with a pit tile.
    LDY.b #$04 : JSL Dungeon_SpriteInducedTilemapUpdate
    
    PLX : PLA
    
    .dont_place_pit_tile
    .just_draw
    
    LSR #3 : TAY
    
    LDA .chr, Y        : STA.b $03
    LDA .properties, Y : STA.b $05
    LDA .oam_sizes, Y  : STA.b $06
    
    LDA.l $7FF83C, X : SEC : SBC.b $E2    : PHP : CLC : ADC .xy_offsets, Y : STA.b $00
    LDA.l $7FF878, X : ADC.b #$00 : PLP : SBC.b $E3
    
    BNE .off_screen
    
    LDA.l $7FF81E, X : SEC : SBC.b $E8    : PHP : CLC : ADC .xy_offsets, Y : STA.b $02
    LDA.l $7FF85A, X : ADC.b #$00 : PLP : SBC.b $E9
    
    BEQ .on_screen
    
    .off_screen
    
    RTS
    
    .on_screen
    
    LDY.b #$00
    
          LDA.b $00                    : STA ($90), Y
          LDA.b $02 : SEC : SBC.b #$10 : INY : STA ($90), Y
    INY : LDA.b $03                    : STA ($90), Y
    INY : LDA.b $05                    : STA ($90), Y
    
    LDA.b $06 : STA ($92)
    
    RTS
}

; ==============================================================================
