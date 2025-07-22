; ==============================================================================

; $04B33F-$04B34E DATA
Pool_Garnish_Trinexxice:
{
    ; $04B33F
    .chr
    db $e8, $e8, $E6, $E6, $E4, $E4, $E4, $E4
    db $E4, $E4, $E4, $E4
    
    ; $04B34B
    .properties
    db $00, $40, $C0, $80
}

; Special animation 0x0C
; $04B34F-$04B3B5 JUMP LOCATION
Garnish_TrinexxIce:
{
    LDA.l $7FF90E, X : CMP.b #$50 : BNE .dont_update_tiles
        LDA.b $11 : ORA.w $0FC1 : BNE .dont_update_tiles
            PHA
            
            LDA.l $7FF83C, X : STA.b $00
            LDA.l $7FF878, X : STA.b $01
            
            LDA.l $7FF81E, X : SEC : SBC.b #$10 : STA.b $02
            LDA.l $7FF85A, X       : SBC.b #$00 : STA.b $03
            
            LDY.b #$12 : JSL.l Dungeon_SpriteInducedTilemapUpdate
            
            PLA
        
    .dont_update_tiles
    
    LDA.l $7FF90E, X : LSR : LSR : AND.b #$03 : TAY
    
    LDA.w Pool_Garnish_Trinexxice_properties, Y : STA.b $04
    
    JSR.w Garnish_PrepOamCoord
    
    LDA.b $00       : STA.b ($90), Y
    LDA.b $02 : INY : STA.b ($90), Y
    
    ; WTF: NOP? hrm...
    LDA.l $7FF90E, X : LSR #4 : NOP : PHX : TAX
    
    LDA.w Pool_Garnish_Trinexxice_chr, X : INY : STA.b ($90), Y
    
    LDA.b #$35 : ORA.b $04 : PLX
    
    JMP Garnish_SetOamPropsAndLargeSize
}
    
; $04B3B6-$04B3B8 JUMP LOCATION
UNUSED_09B3B6:
{
    JMP Garnish_CheckPlayerCollision
}

; ==============================================================================
