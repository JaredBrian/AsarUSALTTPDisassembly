
; ==============================================================================

; $04B33F-$04B34E DATA
Pool_Garnish_Trinexxice:
{
    .chr
    db $e8, $e8, $E6, $E6, $E4, $E4, $E4, $E4
    db $E4, $E4, $E4, $E4
    
    .properties
    db $00, $40, $C0, $80
}

; ==============================================================================

; $04B34F-$04B3B8 JUMP LOCATION
Garnish_TrinexxIce:
{
    ; special animation 0x0C
    
    LDA.l $7FF90E, X : CMP.b #$50 : BNE .dont_update_tiles
    
    LDA.b $11 : ORA.w $0FC1 : BNE .dont_update_tiles
    
    PHA
    
    LDA.l $7FF83C, X : STA.b $00
    LDA.l $7FF878, X : STA.b $01
    
    LDA.l $7FF81E, X : SEC : SBC.b #$10 : STA.b $02
    LDA.l $7FF85A, X : SBC.b #$00 : STA.b $03
    
    LDY.b #$12 : JSL Dungeon_SpriteInducedTilemapUpdate
    
    PLA
    
    .dont_update_tiles
    
    LDA.l $7FF90E, X : LSR #2 : AND.b #$03 : TAY
    
    LDA .properties, Y : STA.b $04
    
    JSR Garnish_PrepOamCoord
    
    LDA.b $00       : STA ($90), Y
    LDA.b $02 : INY : STA ($90), Y
    
    ; WTF: NOP? hrm...
    LDA.l $7FF90E, X : LSR #4 : NOP : PHX : TAX
    
    LDA .chr, X : INY : STA ($90), Y
    
    LDA.b #$35 : ORA.b $04 : PLX
    
    JMP Garnish_SetOamPropsAndLargeSize
    
    .unused
    
    JMP Garnish_CheckPlayerCollision
}

; ==============================================================================
