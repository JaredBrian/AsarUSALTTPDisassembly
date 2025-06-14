; ==============================================================================

; $043BF4-$043C91 DATA
Pool_Ancilla_DashDust:
{
    ; $043BF4
    .y_offsets
    dw -2,  0, -1
    dw -3, -2,  0
    dw -3,  0, -1
    dw -3, -1, -1
    dw -2, -1, -1
    dw -2,  0, -1
    dw -3, -2,  0
    dw -3,  0, -1
    dw -3, -1, -1
    dw -2, -1, -1
    
    ; $043C30
    .x_offsets
    dw 10,  5, -1
    dw  0, 10,  5
    dw  0,  5, -1
    dw  0, -1, -1
    dw  9, -1, -1
    dw 10,  5, -1
    dw  0, 10,  5
    dw  0,  5, -1
    dw  0, -1, -1
    dw  9, -1, -1
    
    ; $043C6C
    .chr
    db $CF, $A9, $FF
    db $A9, $DF, $CF
    db $CF, $DF, $FF
    db $DF, $FF, $FF
    db $A9, $FF, $FF
    db $CF, $CF, $FF
    db $CF, $DF, $CF
    db $CF, $DF, $FF
    db $DF, $FF, $FF
    db $CF, $FF, $FF
    
    ; $043C8A
    .player_relative_offset
    dw 0, 0, 4, -4
}

; $043C92-$043D4B JUMP LOCATION
Ancilla_DashDust:
{
    LDA.w $0C54, X : BEQ .stationary_dust
        JSL.l Ancilla_MotiveDashDust
        
        BRA .return
        
    .stationary_dust
    
    LDA.w $0C68, X : BNE .delay
        LDA.b #$03 : STA.w $0C68, X
        
        LDA.w $0C5E, X : INC : STA.w $0C5E, X
        CMP.b #$05 : BEQ .return
            CMP.b #$06 : BNE .delay
                STZ.w $0C4A, X
            
        .return
        
        RTS
    
    .delay
    
    LDA.w $0C5E, X : CMP.b #$05 : BEQ .return
        JSR.w Ancilla_PrepOamCoord
        
        PHX
        
        LDA $00 : STA $06
        LDA $01 : STA $07
        
        LDA $02 : STA $08
        LDA $03 : STA $09
        
        LDY $2F
        
        LDA.w Pool_Ancilla_DashDust_player_relative_offset+0, Y : STA $0C
        LDA.w Pool_Ancilla_DashDust_player_relative_offset+1, Y : STA $0D
        
        LDY.b #$00
        
        LDA.w $0351 : CMP.b #$01 : BNE .not_standing_in_water
            LDY.b #$05
            
        .not_standing_in_water
        
        STY $04
        
        LDA.w $0C5E, X : CLC : ADC $04 : STA $04
        
        ASL : CLC : ADC $04 : STA $04
        
        LDA.b #$02 : STA $72
        
        LDY.b #$00
        
        .next_OAM_entry
        
            LDX $04
            
            LDA.w Pool_Ancilla_DashDust_chr, X : CMP.b #$FF : BEQ .skip_OAM_entry
                TXA : ASL : TAX
                
                REP #$20
                
                LDA $06
                CLC : ADC Pool_Ancilla_DashDust_y_offsets, X : STA $00

                LDA $08 : CLC : ADC Pool_Ancilla_DashDust_x_offsets, X
                CLC : ADC $0C : STA $02
                
                SEP #$20
                
                JSR.w Ancilla_SetOam_XY
                
                LDX $04
                
                LDA.w Pool_Ancilla_DashDust_chr, X : STA ($90), Y
                INY

                LDA.b #$04 : ORA $65 : STA ($90), Y
                INY
                
                PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
                
                LDA.b #$00 : STA ($92), Y
                
                PLY
            
            .skip_OAM_entry
            
            INC $04
        DEC $72 : BPL .next_OAM_entry
        
        PLX
        
        RTS
}

; ==============================================================================
