; ==============================================================================

; $04B51C-$04B51F DATA
Garnish_Sparkle_chr:
{
    db $83, $C7, $80, $B7
}

; $04B520-$04B525 JUMP LOCATION
Garnish_Sparkle:
{
    LDA.l $7FF90E, X
    
    BRA .set_chr_index
}
    
; $04B526-$04B558 JUMP LOCATION
Garnish_SimpleSparkle:
{
    LDA.l $7FF90E, X : LSR
    
    ; $04B52B ALTERNATE ENTRY POINT
    .set_chr_index
    
    LSR #2 : STA.b $0F
    
    JSR.w Garnish_PrepOamCoord
    
    LDA.b $00       : STA ($90), Y
    LDA.b $02 : INY : STA ($90), Y
    
    PHX
    
    LDX.b $0F
    
    LDA.w .chr, X : PLX : INY : STA ($90), Y
    
    PHY
    
    LDA.l $7FF92C, X : TAY
    
    ; Copy palette and other OAM properties from the parent sprite object.
    LDA.w $0F50, Y : ORA.w $0B89, Y : AND.b #$F0 : ORA.b #$04
    
    PLY
    
    JMP Garnish_SetOamPropsAndSmallSize
}

; ==============================================================================
