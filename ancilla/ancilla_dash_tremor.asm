; ==============================================================================

; $043BBC-$043BF3 JUMP LOCATION
Ancilla_DashTremor:
{
    LDA $11 : BNE .just_alert_sprites
        DEC.w $0C5E, X : BPL .delay
            STZ.w $011A
            STZ.w $011B
            STZ.w $011C
            STZ.w $011D
            
            STZ.w $0C4A, X
            
            RTS
            
        .delay
        
        JSL.l DashTremor_TwiddleOffset
        
        LDA $00 : STA.w $011A, Y
        LDA $01 : STA.w $011B, Y
        
        TYA : LSR A : EOR.b #$01 : TAY
        
        LDA.w $0030, Y : CLC : ADC $00 : STA.w $0030, Y
        
    .just_alert_sprites
    
    BRL Ancilla_AlertSprites
}

; ==============================================================================
