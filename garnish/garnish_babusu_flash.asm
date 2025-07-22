; ==============================================================================

; $04B496-$04B49D DATA
Pool_Garnish_BabusuFlash:
{
    ; $04B496
    .chr
    db $A8, $8A, $86, $86
    
    ; $04B49A
    .properties
    db $2D, $2C, $2C, $2C
}

; ==============================================================================

; $04B49E-$04B4BF LOCAL JUMP LOCATION
Garnish_BabusuFlash:
{
    JSR.w Garnish_PrepOamCoord
    
    LDA.b $00       : STA.b ($90), Y
    LDA.b $02 : INY : STA.b ($90), Y
    
    LDA.l $7FF90E, X : LSR #3
    
    PHX
    
    TAX
    
    LDA.w Pool_Garnish_BabusuFlash_chr, X : INY : STA.b ($90), Y
    
    LDA.w Pool_Garnish_BabusuFlash_properties, X
    
    PLX
    
    JMP Garnish_SetOamPropsAndLargeSize
}

; ==============================================================================
