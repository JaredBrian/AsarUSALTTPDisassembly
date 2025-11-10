; ==============================================================================

; $04698E-$0469B1 DATA
Pool_Ancilla_SomarianBlockFizzle:
{
    ; $04698E
    .y_offsets
    dw -4, -1, -4, -4, -4, -4
    
    ; $04699A
    .x_offsets
    dw -4, -1, -8,  0, -6, -2
    
    ; $0469A6
    .chr
    db $92, $FF, $F9, $F9, $F9, $F9
    
    ; $0469AC
    .properties
    db $06, $FF, $86, $C6, $86, $C6
}

; $0469B2-$0469E7 BRANCH LOCATION
Ancilla_TransmuteToSomarianBlockFizzle:
{
    LDA.b $5E : CMP.b #$12 : BNE .player_not_slowed_down
        STZ.b $48
        STZ.b $5E
        
    .player_not_slowed_down
    
    STZ.w $0646
    
    LDA.b #$2D : STA.w $0C4A, X
    
    STZ.w $03B1, X
    STZ.w $0C54, X
    STZ.w $0C5E, X
    STZ.w $039F, X
    STZ.w $03A4, X
    STZ.w $03EA, X
    
    TXA : INC : CMP.w $02EC : BNE .player_wasnt_carrying_block
        STZ.w $02EC
        
        LDA.w $0308 : AND.b #$80 : STA.w $0308
        
    .player_wasnt_carrying_block

    ; Bleeds into the next function.
}
    
; $0469E8-$046A7E BRANCH LOCATION
Ancilla_SomarianBlockFizzle:
{
    DEC.w $03B1, X : BPL .animation_delay
        LDA.b #$03 : STA.w $03B1, X
        
        LDA.w $0C5E, X : INC : STA.w $0C5E, X
        CMP.b #$03 : BNE .animation_delay
            STZ.w $0C4A, X
            
            RTS
    
    .animation_delay
    
    JSR.w Ancilla_PrepAdjustedOamCoord
    
    LDY.b #$00
    
    LDA.w $029E, X : CMP.b #$FF : BNE .coerce_above_ground
        LDA.b #$00
    
    .coerce_above_ground
    
    STA.b $04 : BPL .sign_ext_z_coord
        LDY.b #$FF
    
    .sign_ext_z_coord
    
    STY.b $05
    
    REP #$20
    
    LDA.b $04 : EOR.w #$FFFF : INC : CLC : ADC.b $00 : STA.b $04
    
    LDA.b $02 : STA.b $06
    
    SEP #$20
    
    PHX
    
    LDA.w $0C5E, X : ASL : TAX
    
    LDY.b #$00 : STY.b $08
    
    .next_OAM_entry
    
        LDA.w .chr, X : CMP.b #$FF : BEQ .skip_OAM_entry
            REP #$20
            
            PHX : TXA : ASL : TAX
            LDA.b $04
            CLC : ADC Pool_Ancilla_SomarianBlockFizzle_y_offsets, X : STA.b $00
            LDA.b $06
            CLC : ADC Pool_Ancilla_SomarianBlockFizzle_x_offsets, X : STA.b $02
            
            PLX
            
            SEP #$20
            
            JSR.w Ancilla_SetOam_XY
            
            LDA.w Pool_Ancilla_SomarianBlockFizzle_chr, X : STA.b ($90), Y

            INY
            LDA.w Pool_Ancilla_SomarianBlockFizzle_properties, X
            AND.b #$CF : ORA.b $65 : STA.b ($90), Y

            INY : PHY
            TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
            LDA.b #$00 : STA.b ($92), Y
            
            PLY
            
        .skip_OAM_entry
        
        INX
    INC.b $08
    LDA.b $08 : CMP.b #$02 : BNE .next_OAM_entry
    
    PLX
    
    RTS
}

; ==============================================================================
