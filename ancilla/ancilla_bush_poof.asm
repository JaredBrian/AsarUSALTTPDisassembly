; ==============================================================================

; $0454B9-$045518 DATA
Pool_Ancilla_BushPoof:
{
    ; $0454B9
    .chr
    db $86, $87, $96, $97
    db $A9, $A9, $A9, $A9
    db $8A, $8B, $9A, $9B
    db $9B, $9B, $9B, $9B
    
    ; $0454C9
    .properties
    db $00, $00, $00, $00
    db $00, $40, $80, $C0
    db $00, $00, $00, $00
    db $C0, $80, $40, $00
    
    ; $0454D9
    .y_offsets_low
    db  0,  0,  8,  8
    db  0,  0,  8,  8
    db  0,  0,  8,  8
    db -2, -2, 10, 10
    
    ; $0454E9
    .y_offsets_high
    db  0,  0,  0,  0
    db  0,  0,  0,  0
    db  0,  0,  0,  0
    db -1, -1,  0,  0
    
    ; $0454F9
    .x_offsets_low
    db  0,  8,  0,  8
    db  0,  8,  0,  8
    db  0,  8,  0,  8
    db -2, 10, -2, 10
    
    ; $045509
    .x_offsets_high
    db  0,  0,  0,  0
    db  0,  0,  0,  0
    db  0,  0,  0,  0
    db -1,  0, -1,  0
}

; $045519-$045595 JUMP LOCATION
Ancilla_BushPoof:
{
    LDA.w $0C68, X : BNE .draw
        LDA.b #$07 : STA.w $0C68, X
        
        INC.w $0C5E, X : LDA.w $0C5E, X : CMP.b #$04 : BNE .draw
            STZ.w $0C4A, X
            
            RTS
    
    .draw
    
    LDA.b #$10 : JSL.l OAM_AllocateFromRegionC
    
    JSR.w Ancilla_PrepOamCoord
    
    LDA $00 : STA $06
    LDA $01 : STA $07
              STZ $08
    
    LDY.b #$00
    
    LDA.w $0C5E, X : ASL #2 : TAX
    
    .next_OAM_entry
    
        LDA $06 : CLC : ADC Pool_Ancilla_BushPoof_y_offsets_low,  X : STA $00
        LDA $07       : ADC Pool_Ancilla_BushPoof_y_offsets_high, X : STA $01
        
        LDA $04 : CLC : ADC Pool_Ancilla_BushPoof_x_offsets_low,  X : STA $02
        LDA $05       : ADC Pool_Ancilla_BushPoof_x_offsets_high, X : STA $03
        
        JSR.w Ancilla_SetOam_XY
        
        LDA.w Pool_Ancilla_BushPoof_chr, X : STA ($90), Y
        INY
        
        LDA.w Pool_Ancilla_BushPoof_properties, X
        ORA.b #$04 : ORA $65 : STA ($90), Y
        INY
        
        PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
        
        LDA.b #$00 : STA ($92), Y
        
        PLY
        
        INX
    INC $08 : LDA $08 : CMP.b #$04 : BNE .next_OAM_entry
    
    BRL Ancilla_RestoreIndex
}

; ==============================================================================
