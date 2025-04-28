; ==============================================================================

; $04422F-$04425E DATA
Pool_Ancilla_SwordCeremony:
{
    ; $04422F
    .y_offsets
    dw 1, 1, 9, 9
    dw 1, 1, 9, 9
    
    ; $04423F
    .x_offsets
    dw -1,  8, -1,  8
    dw  0,  7,  0,  7
    
    ; $04424F
    .chr
    db $86, $86, $96, $96
    db $87, $87, $97, $97
    
    ; $044257
    .properties
    db $01, $41, $01, $41
    db $01, $41, $01, $41
}

; Special object 0x35 - Master Sword Ceremony
; $04425F-$0442DC JUMP LOCATION
Ancilla_SwordCeremony:
{
    LDA.w $0C68, X : BNE .delay
        STZ.w $0C4A, X
        
        RTS
    
    .delay
    
    DEC.w $03B1, X : BPL .dont_advance_animation_index
        LDA.w $0C5E, X : INC A : CMP.b #$03 : BNE .dont_reset_animation_index
            LDA.b #$00
        
        .dont_reset_animation_index
        
        STA.w $0C5E, X
    
    .dont_advance_animation_index
    
    JSR.w Ancilla_PrepOamCoord
    
    REP #$20
    
    LDA.b $00 : STA.b $04
    LDA.b $02 : STA.b $06
    
    SEP #$20
    
    PHX
    
    STZ.b $08
    
    LDA.w $0C5E, X : BEQ .nothing_to_draw
        DEC A : ASL #2 : TAX
        
        LDY.b #$00
        
        .next_OAM_entry
        
            PHX : TXA : ASL A : TAX
            
            REP #$20
            
            LDA.b $04
            CLC : ADC Pool_Ancilla_SwordCeremony_y_offsets, X : STA.b $00

            LDA.b $06
            CLC : ADC Pool_Ancilla_SwordCeremony_x_offsets, X : STA.b $02
            
            SEP #$20
            
            PLX
            
            JSR.w Ancilla_SetOam_XY
            
            LDA.w Pool_Ancilla_SwordCeremony_chr, X : STA ($90), Y : INY
            
            LDA.w Pool_Ancilla_SwordCeremony_properties, X : AND.b #$CF
            
            ORA.b #$04 : ORA.b $65 : STA ($90), Y : INY
            
            PHY
            
            TYA : SEC : SBC.b #$04 : LSR #2 : TAY
            
            LDA.b #$00 : STA ($92), Y
            
            PLY
            
            INX
        INC.b $08 : LDA.b $08 : CMP.b #$04 : BNE .next_OAM_entry
    
    .nothing_to_draw
    
    PLX
    
    RTS
}

; ==============================================================================
