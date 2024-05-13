
; ==============================================================================

; $04B4C0-$04B4C5 DATA
Pool_Garnish_Nebule:
{
    .xy_offsets
    db -1, -1, 0
    
    .chr
    db $9C, $9D, $8D
}

; ==============================================================================

; $04B4C6-$04B4FA JUMP LOCATION
Garnish_Nebule:
{
    ; Special animation 0x07
    
    JSR Garnish_PrepOamCoord
    
    PHX
    
    LDA $7FF90E, X : LSR #2 : TAX
    
    LDA $00 : CLC : ADC .xy_offsets, X       : STA ($90), Y
    LDA $02 : CLC : ADC .xy_offsets, X : INY : STA ($90), Y
    
    LDA .chr, X : INY : STA ($90), Y
    
    PLX
    
    PHY
    
    LDA $7FF92C, X : TAY
    
    LDA $0F50, Y : ORA $0B89, Y : AND.W #$7AFE
    
    JMP Garnish_SetOamPropsAndSmallSize
}

; ==============================================================================
