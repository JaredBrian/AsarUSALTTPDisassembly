; ==============================================================================

; $04B4C0-$04B4C5 DATA
Pool_Garnish_Nebule:
{
    ; $04B4C0
    .xy_offsets
    db -1, -1, 0
    
    ; $04B4C3
    .chr
    db $9C, $9D, $8D
}

; Special animation 0x07
; $04B4C6-$04B4FA JUMP LOCATION
Garnish_Nebule:
{
    JSR.w Garnish_PrepOamCoord
    
    PHX
    
    LDA.l $7FF90E, X : LSR : LSR : TAX
    
    LDA.b $00 : CLC : ADC Pool_Garnish_Nebule_xy_offsets, X       : STA.b ($90), Y
    LDA.b $02 : CLC : ADC Pool_Garnish_Nebule_xy_offsets, X : INY : STA.b ($90), Y
    
    LDA.w Pool_Garnish_Nebule_chr, X : INY : STA.b ($90), Y
    
    PLX
    
    PHY
    
    LDA.l $7FF92C, X : TAY
    
    LDA.w $0F50, Y : ORA.w $0B89, Y : AND.W #$7AFE
    
    JMP Garnish_SetOamPropsAndSmallSize
}

; ==============================================================================
