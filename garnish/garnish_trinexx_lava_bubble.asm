; ==============================================================================

; $04B559-$04B55C DATA
Garnish_TrinexxLavaBubble_chr:
{
    db $83, $C7, $80, $9D
}

; $04B55D-$04B58C JUMP LOCATION
Garnish_TrinexxLavaBubble:
{
    JSR.w Garnish_PrepOamCoord
    
    LDA.b $00       : STA.b ($90), Y
    LDA.b $02 : INY : STA.b ($90), Y
    
    LDA.l $7FF90E, X : LSR #3 : PHX : TAX
    
    LDA.w .chr, X : PLX : INY : STA.b ($90), Y
    
    PHY
    
    LDA.l $7FF92C, X : TAY
    
    ; Copy palette and other OAM properties from the parent sprite object.
    LDA.w $0F50, Y : ORA.w $0B89, Y : AND.b #$F0 : ORA.b #$0E
    
    PLY
    
    JMP Garnish_SetOamPropsAndSmallSize
}

; ==============================================================================
