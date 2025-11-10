; ==============================================================================

; $046BE3-$046C12 DATA
Pool_Ancilla_LampFlame:
{
    ; $046BE3
    .chr
    db $9C, $9C, $FF, $FF
    db $A4, $A5, $B2, $B3
    db $E3, $F3, $FF, $FF
    
    ; $046BEF
    .y_offsets_low
    db -3,  0,  0,  0
    db  0,  0,  8,  8
    db  0,  8,  0,  0
    
    ; $046BEB
    .y_offsets_high
    db -1,  0,  0,  0
    db  0,  0,  0,  0
    db  0,  0,  0,  0
    
    ; $046BE7
    .x_offsets_low
    db 4, 10, 0, 0
    db 1,  9, 2, 7
    db 4,  4, 0, 0    
}

; $046C13-$046C76 JUMP LOCATION
Ancilla_LampFlame:
{
    JSR.w Ancilla_PrepAdjustedOamCoord
    
    LDA.b $00 : STA.b $06
    LDA.b $01 : STA.b $07
    
    LDY.b #$00
    
    LDA.w $0C68, X : BNE .termination_delay
        STZ.w $0C4A, X
        
        RTS
        
    .termination_delay
    
    AND.b #$F8 : LSR : TAX
    
    .next_OAM_entry
    
        LDA.w Pool_Ancilla_LampFlame_chr, X : CMP.b #$FF : BEQ .skip_OAM_entry
            LDA.w Pool_Ancilla_LampFlame_y_offsets_low, X : CLC : ADC.b $06 : STA.b $00
            LDA.b $07 : ADC.w Pool_Ancilla_LampFlame_y_offsets_high, X : STA.b $01
            
            LDA.w Pool_Ancilla_LampFlame_x_offsets_low, X : CLC : ADC.b $04 : STA.b $02
            LDA.b $05 : ADC.b #$00 : STA.b $03
            
            JSR.w Ancilla_SetOam_XY
            
            LDA.w Pool_Ancilla_LampFlame_chr, X : STA.b ($90), Y

            INY
            LDA.b #$02 : ORA.b $65 : STA.b ($90), Y

            INY : PHY
            TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
            LDA.b #$00 : STA.b ($92), Y
            
            PLY
        
        .skip_OAM_entry
    INX : TXA : AND.b #$03 : BNE .next_OAM_entry
    
    BRL Ancilla_RestoreIndex
}

; ==============================================================================
