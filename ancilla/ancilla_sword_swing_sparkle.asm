; ==============================================================================

; NOTE: Each of these groupings corresponds to a different direction.
; Interestingly enough, I think the chr and properties are identical
; for all 3 directions. No surprise there, I guess.
; $045596-$045659 DATA
Pool_Ancilla_SwordSwingSparkle:
{
    ; $045596
    .chr
    db $B7, $B7, $FF
    db $80, $80, $B7
    db $83, $83, $80
    db $83, $FF, $FF
    
    db $B7, $B7, $FF
    db $80, $80, $B7
    db $83, $83, $80
    db $83, $FF, $FF
    
    db $B7, $B7, $FF
    db $80, $80, $B7
    db $83, $83, $80
    db $83, $FF, $FF
    
    db $B7, $B7, $FF
    db $80, $80, $B7
    db $83, $83, $80
    db $83, $FF, $FF
    
    ; $0455C6
    .properties
    db $00, $00, $FF
    db $00, $00, $00
    db $80, $80, $00
    db $80, $FF, $FF
    
    db $00, $00, $FF
    db $00, $00, $00
    db $80, $80, $00
    db $80, $FF, $FF
    
    db $00, $00, $FF
    db $00, $00, $00
    db $80, $80, $00
    db $80, $FF, $FF
    
    db $00, $00, $FF
    db $00, $00, $00
    db $80, $80, $00
    db $80, $FF, $FF
    
    ; $0455F6
    .y_offsets
    db -22, -18,  -1
    db -22, -18, -17
    db -22, -18, -17
    db -17,  -1,  -1
    
    db  35,  40,  -1
    db  35,  40,  37
    db  35,  40,  37
    db  37,  -1,  -1
    
    db   2,   7,  -1
    db   2,   7,  19
    db   2,   7,  19
    db  19,  -1,  -1
    
    db   2,   7,  -1
    db   2,   7,  19
    db   2,   7,  19
    db  19,  -1,  -1
    
    ; $045626
    .y_offsets
    db   5,  10,  -1
    db   5,  10,  -4
    db   5,  10,  -4
    db  -4,  -1,  -1
    
    db   0,   5,  -1
    db   0,   5,  14
    db   0,   5,  14
    db  14,  -1,  -1
    
    db -23, -27,  -1
    db -23, -27, -22
    db -23, -27, -22
    db -22,  -1,  -1
    
    db  32,  35,  -1
    db  32,  35,  30
    db  32,  35,  30
    db  30,  -1,  -1    
    
    ; $045656
    .directed_OAM_group
    db 0, 12, 24, 36
}

; $04565A-$045703 JUMP LOCATION
Ancilla_SwordSwingSparkle:
{
    DEC.w $03B1, X : BPL .termination_delay
        LDA.b #$00 : STA.w $03B1, X
        
        INC.w $0C5E, X : LDA.w $0C5E, X : CMP.b #$04 : BNE .termination_delay
            STZ.w $0C4A, X
            
            RTS
    
    .termination_delay
    
    PHX
    
    LDA.b $20 : STA.w $0BFA, X
    LDA.b $21 : STA.w $0C0E, X
    
    LDA.b $22 : STA.w $0C04, X
    LDA.b $23 : STA.w $0C18, X
    
    JSR.w Ancilla_PrepOamCoord
    
    REP #$20
    
    LDA.b $00 : STA.b $04
    LDA.b $02 : STA.b $06
    
    SEP #$20
    
    ; Number of sprites to draw.
    LDA.b #$02 : STA.b $08
    
    LDY.w $0C72, X
    
    LDA.w $0C5E, X : ASL : CLC : ADC.w $0C5E, X
    CLC : ADC Pool_Ancilla_SwordSwingSparkle_directed_OAM_group, Y : TAX
    
    LDY.b #$00
    
    .next_OAM_entry
        
        LDA.w Pool_Ancilla_SwordSwingSparkle_chr, X : CMP.b #$FF : BEQ .skip_OAM_entry
        
            REP #$20
            
            LDA.w Pool_Ancilla_SwordSwingSparkle_y_offsets, X
            AND.w #$00FF : CMP.w #$0080 : BCC .positive_y_offset
                ORA.w #$FF00
                
            .positive_y_offset
            
            CLC : ADC.b $04 : STA.b $00
            
            LDA.w Pool_Ancilla_SwordSwingSparkle_x_offsets, X
            AND.w #$00FF : CMP.w #$0080 : BCC .positive_x_offset
                ORA.w #$FF00
            
            .positive_x_offset
            
            CLC : ADC.b $06 : STA.b $02
            
            SEP #$20
            
            JSR.w Ancilla_SetOam_XY
            
            LDA.w Pool_Ancilla_SwordSwingSparkle_chr, X : STA ($90), Y : INY

            LDA.w Pool_Ancilla_SwordSwingSparkle_properties, X
            ORA.b #$04 : ORA.b $65 : STA ($90), Y : INY
            
            PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
            
            LDA.b #$00 : STA ($92), Y
            
            PLY
        
        .skip_OAM_entry
        
        INX
    
    DEC.b $08 : BPL .next_OAM_entry
    
    PLX
    
    RTS
}

; ==============================================================================
