
; ==============================================================================

; $04B496-$04B49D DATA
Pool_Garnish_BabusuFlash:
{
    .chr
    db $A8, $8A, $86, $86
    
    .properties
    db $2D, $2C, $2C, $2C
}

; ==============================================================================

; $04B49E-$04B4BF
Garnish_BabusuFlash:
{
    JSR Garnish_PrepOamCoord
    
    LDA.b $00       : STA ($90), Y
    LDA.b $02 : INY : STA ($90), Y
    
    LDA.l $7FF90E, X : LSR #3
    
    PHX
    
    TAX
    
    LDA .chr, X : INY : STA ($90), Y
    
    LDA .properties, X
    
    PLX
    
    JMP Garnish_SetOamPropsAndLargeSize
}

; ==============================================================================
