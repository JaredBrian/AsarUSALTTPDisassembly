
; ==============================================================================

; $04B559-$04B55C DATA
Pool_Garnish_TrinexxLavaBubble:
{
    .chr
    db $83, $C7, $80, $9D
}

; ==============================================================================

; $04B55D-$04B58C JUMP LOCATION
Garnish_TrinexxLavaBubble:
{
    JSR Garnish_PrepOamCoord
    
    LDA $00       : STA ($90), Y
    LDA $02 : INY : STA ($90), Y
    
    LDA.l $7FF90E, X : LSR #3 : PHX : TAX
    
    LDA .chr, X : PLX : INY : STA ($90), Y
    
    PHY
    
    LDA.l $7FF92C, X : TAY
    
    ; Copy palette and other oam properties from the parent sprite object.
    LDA.w $0F50, Y : ORA.w $0B89, Y : AND.b #$F0 : ORA.b #$0E
    
    PLY
    
    JMP Garnish_SetOamPropsAndSmallSize
}

; ==============================================================================

