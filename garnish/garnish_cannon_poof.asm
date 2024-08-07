
; ==============================================================================

; $04B3E8-$04B3ED DATA
Pool_Garnish_CannonPoof:
{
    .chr
    db $8A, $86
    
    db $20, $10, $30, $30
}

; ==============================================================================

; $04B3EE-$04B418 JUMP LOCATION
Garnish_CannonPoof:
{
    ; special animation 0x0A
    
    JSR.w Garnish_PrepOamCoord
    
    LDA.b $00       : STA ($90), Y
    LDA.b $02 : INY : STA ($90), Y
    
    LDA.l $7FF90E, X : LSR #3 : PHX : TAX
    
    LDA.w .chr, X : INY : STA ($90), Y
    
    PLX 
    
    PHX
    
    LDA.l $7FF92C, X : TAX
    
    LDA.w .properties, X : ORA.b #$04 : PLX
    
    JMP Garnish_SetOamPropsAndLargeSize
}

; ==============================================================================

