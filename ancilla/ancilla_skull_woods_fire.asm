; ==============================================================================

; $046EDE-$046F99 DATA
Pool_Ancilla_SkullWoodsFire:
{
    ; $046EDE
    .flame_y_offsets_low
    db 0, 0, 0, -3
    
    ; $046EE2
    .flame_y_offsets_high
    db 0, 0, 0, -1
    
    ; $046EE6
    .flame_chr
    db $8E, $A0, $A2, $A4
    
    ; $046EEA
    .flame_properties
    db $02, $02, $02, $00
    
    ; $046EEE
    .blast_chr
    db $86, $86, $86, $FF, $FF, $FF
    db $86, $86, $86, $86, $86, $86
    db $8A, $8A, $8A, $8A, $8A, $8A
    db $9B, $9B, $9B, $9B, $9B, $9B
    
    ; $046F06
    .blast_properties
    db $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00
    db $80, $40, $40, $80, $40, $00
    
    ; $046F1E
    .blast_oam_sizes
    db $02, $02, $02, $02, $01, $01
    db $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02
    db $00, $00, $00, $00, $00, $00
    
    ; $046F36
    .blast_y_offsets
    dw -31, -24, -22,  -1,  -1,  -1
    dw -37, -32, -32, -23, -16, -14
    dw -37, -32, -32, -23, -16, -14
    dw -35, -29, -28, -20, -13, -11
    
    ; $046F66
    .blast_x_offsets
    dw -13, -21, -10,  -1,  -1,  -1
    dw -16, -27,  -4, -16,  -6, -25
    dw -16, -27,  -4, -16,  -6, -25
    dw -13,  -5, -27, -11, -22,  -3
    
    ; $046F96
    .blast_data_offsets
    db 0, 6, 12, 18
}

; ==============================================================================

; $046F9A-$047168 JUMP LOCATION
Ancilla_SkullWoodsFire:
{
    LDA.l $7F0010 : BEQ .blast_inactive
        LDA.w $0C5E, X : CMP.b #$04 : BEQ .blast_inactive
            DEC.w $03B1, X : BPL .blast_state_delay
                LDA.b #$05 : STA.w $03B1, X
                
                INC.w $0C5E, X
                
            .blast_state_delay
    .blast_inactive
    
    LDX.b #$03
    LDY.b #$00
    
    .execute_next_flame
    
        LDA.l $7F0008, X : DEC A : STA.l $7F0008, X
        
        BMI .reset_flame_animation_index
            .flame_permanently_inactive
            .dont_reset_flame_control_index
            
            BRL .draw_flames_logic
        
        .reset_flame_animation_index
        
        LDA.b #$05 : STA.l $7F0008, X
        
        LDA.l $7F0000, X : CMP.b #$80 : BEQ .flame_permanently_inactive
            INC A : STA.l $7F0000, X : BEQ .flame_control_state_reset
                CMP.b #$04 : BNE .dont_reset_flame_control_index
                    LDA.b #$00 : STA.l $7F0000, X
                
            .flame_control_state_reset
            
            REP #$20
            
            LDA.l $7F0018 : SEC : SBC.w #$0008 : STA.l $7F0018
            
            CMP.w #$00C8 : BCS .dont_play_thud_sfx
                LDA.w #$0098 : SEC : SBC.b $E2 : STA.b $00
                
                SEP #$20
                
                LDA.l $7F0010 : CMP.b #$01 : BEQ .dont_play_thud_sfx
                    ; Activate the blast component of this object.
                    LDA.b #$01 : STA.l $7F0010
                    
                    LDA.b $00 : JSR.w Ancilla_SetSfxPan_NearEntity
                    ORA.b #$0C : STA.w $012E
                
            .dont_play_thud_sfx
            
            REP #$20
            
            LDA.l $7F0018 : CMP.w #$00A8 : BCS .dont_permadeativate_flame
                LDA.l $7F0000, X : AND.w #$FF00 : ORA.w #$0080 : STA.l $7F0000, X
                
            .dont_permadeativate_flame
            
            PHX : TXA : ASL A : TAX
            
            LDA.l $7F001A : STA.l $7F0030, X
            LDA.l $7F0018 : STA.l $7F0020, X
            
            PLX
            
            SEP #$20
            
            LDA.w $012E : BNE .sfx2_already_set
                LDA.l $7F001A : SEC : SBC.b $E2
                
                JSR.w Ancilla_SetSfxPan_NearEntity : ORA.b #$2A : STA.w $012E
                
            .sfx2_already_set
        .draw_flames_logic
        
        SEP #$20
        
        PHX
        
        LDA.l $7F0000, X : BPL .active_flame
            BRL .inactive_flame
            
        .active_flame
        
        PHY
        
        TAY
        
        LDA.w Pool_Ancilla_SkullWoodsFire_flame_y_offsets_low,  Y : STA.b $04
        LDA.w Pool_Ancilla_SkullWoodsFire_flame_y_offsets_high, Y : STA.b $05
        LDA.w Pool_Ancilla_SkullWoodsFire_flame_chr, Y            : STA.b $06
        LDA.w Pool_Ancilla_SkullWoodsFire_flame_properties, Y     : STA.b $07
        
        TXA : ASL A : TAX
        
        REP #$20
        
        LDA.l $7F0020, X : SEC : SBC.b $E8 : CLC : ADC.b $04 : STA.b $00
        
        LDA.l $7F0030, X : SEC : SBC.b $E2                   : STA.b $02
        
        CLC : ADC.w #$0008 : STA.b $08
        
        SEP #$20
        
        PLY
        
        JSR.w Ancilla_SetOam_XY
        
        LDA.b $06  : STA ($90), Y : INY
        LDA.b #$32 : STA ($90), Y : INY
        
        PHY
        
        TYA : SEC : SBC.b #$04 : LSR #2 : TAY
        
        LDA.b $07 : STA ($92), Y
        
        PLY
        
        CMP.b #$02 : BEQ .large_oam_entry
            REP #$20
            
            LDA.b $08 : STA.b $02
            
            SEP #$20
            
            JSR.w Ancilla_SetOam_XY
            
            LDA.b $06 : INC A : STA ($90), Y
            
            INY
            
            LDA.b #$32 : STA ($90), Y
            
            INY : PHY
            
            TYA : SEC : SBC.b #$04 : LSR #2 : TAY
            
            LDA.b $07 : STA ($92), Y
            
            PLY
            
        .large_oam_entry

        .inactive_flame
        
        PLX : DEX : BMI .done_executing_flames
    BRL .execute_next_flame
    
    .done_executing_flames
    
    LDX.b #$03
    
    .find_active_flame_loop
        
        LDA.l $7F0000, X : BPL .flames_not_all_inactive
    DEX : BPL .find_active_flame_loop
    
    LDX.w $0FA0
    
    STZ.w $0C4A, X
    
    RTS
    
    .flames_not_all_inactive
    
    LDX.w $0FA0
    
    LDA.l $7F0010 : BEQ .blast_logic_inactive
        LDA.w $0C5E, X : CMP.b #$04 : BEQ .blast_logic_inactive
            TAX
            
            LDA.w .blast_data_offsets, X : TAX
            
            STZ.b $08
            
            .next_blast_oam_entry
                
                LDA.w .blast_chr, X : CMP.b #$FF : BEQ .skip_blast_oam_entry
                    PHX
                    
                    TXA : ASL A : TAX
                    
                    REP #$20
                    
                    LDA.w #$00C8 : SEC : SBC.b $E8
                    CLC : ADC .blast_y_offsets, X : STA.b $00

                    LDA.w #$00A8 : SEC : SBC.b $E2
                    CLC : ADC .blast_x_offsets, X : STA.b $02
                    
                    SEP #$20
                    
                    PLX
                    
                    JSR.w Ancilla_SetOam_XY
                    
                    LDA.w Pool_Ancilla_SkullWoodsFire_blast_chr, X : STA ($90), Y
                    INY
                    
                    LDA.w Pool_Ancilla_SkullWoodsFire_blast_properties, X
                    ORA.b #$30 : ORA.b #$02 : STA ($90), Y
                    
                    INY : PHY
                    
                    TYA : SEC : SBC.b #$04 : LSR #2 : TAY
                    
                    LDA.w Pool_Ancilla_SkullWoodsFire_blast_oam_sizes, X : STA ($92), Y
                    
                    PLY
                    
                .skip_blast_oam_entry
                
                INX
                
                INC.b $08
            LDA.b $08 : CMP.b #$06 : BNE .next_blast_oam_entry
        
    .blast_logic_inactive
    
    BRL Ancilla_RestoreIndex
}

; ==============================================================================
