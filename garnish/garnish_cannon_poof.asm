; ==============================================================================

; $04B3E8-$04B3ED DATA
Pool_Garnish_CannonPoof:
{
    ; $04B3E8
    .chr
    db $8A, $86
    
    ; $04B3EA
    .properties
    db $20, $10, $30, $30
}

; Special animation 0x0A
; $04B3EE-$04B418 JUMP LOCATION
Garnish_CannonPoof:
{
    JSR.w Garnish_PrepOamCoord
    
    LDA.b $00       : STA.b ($90), Y
    LDA.b $02 : INY : STA.b ($90), Y
    
    LDA.l $7FF90E, X : LSR #3 : PHX : TAX
    
    LDA.w Pool_Garnish_CannonPoof_chr, X : INY : STA.b ($90), Y
    
    PLX 
    
    PHX
    
    LDA.l $7FF92C, X : TAX
    
    LDA.w Pool_Garnish_CannonPoof_properties, X : ORA.b #$04 : PLX
    
    JMP Garnish_SetOamPropsAndLargeSize
}

; ==============================================================================
