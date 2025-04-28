; ==============================================================================

; $040CD9-$040D18 DATA
Pool_Ancilla_BeamHit:
{
    ; $040CD9
    .x_offsets
    db -12,  20, -12,  20
    db  -8,  16,  -8,  16
    db  -4,  12,  -4,  12
    db   0,   8,   0,   8
     
    ; $040CE9
    .y_offsets
    db -12,  -12, 20,  20
    db  -8,  -8,  16,  16
    db  -4,  -4,  12,  12
    db   0,   0,   8,   8
    
    ; $040CF9
    .chr
    db $53, $53, $53, $53
    db $53, $53, $53, $53
    db $53, $53, $53, $53
    db $54, $54, $54, $54
    
    ; $040D09
    .properties
    db $40, $00, $C0, $80
    db $40, $00, $C0, $80
    db $40, $00, $C0, $80
    db $00, $40, $80, $C0
}

; $040D19-$040D67 JUMP LOCATION
Ancilla_BeamHit:
{
    JSR.w Ancilla_BoundsCheck
    
    LDA.w $0C68, X : BNE .delay
        BRL Ancilla_SelfTerminate
    
    .delay
    
    LSR A : STA $02
    
    ; Draw four sprites moving in away from another in a square pattern.
    LDX.b #$03
    LDY.b #$00
    
    .next_OAM_entry
    
        STX $03
        
        LDA $02 : ASL #2 : ADC $03 : TAX
        
        LDA $00
        CLC : ADC Pool_Ancilla_BeamHit_x_offsets, X       : STA ($90), Y

        LDA $01
        CLC : ADC Pool_Ancilla_BeamHit_y_offsets, X : INY : STA ($90), Y

        LDA.w Pool_Ancilla_BeamHit_chr, X
        CLC : ADC.b #$82 : INY : STA ($90), Y

        LDA.w Pool_Ancilla_BeamHit_properties, X
        ORA.b #$02 : ORA $04 : INY : STA ($90), Y
        
        INY
    LDX $03 : DEX : BPL .next_OAM_entry
    
    LDX.w $0FA0
    
    LDY.b #$00
    LDA.b #$03
    
    BRL BeamHit_Unknown
}

; ==============================================================================
