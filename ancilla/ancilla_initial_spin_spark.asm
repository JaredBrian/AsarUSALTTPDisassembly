; ==============================================================================

; $045704-$0457B1 DATA
Pool_Ancilla_InitialSpinSpark:
{
    ; $045704
    .timers
    db 4, 2, 3, 3, 2, 1
    
    ; $04570A
    .chr
    db $92, $FF, $FF, $FF
    db $8C, $8C, $8C, $8C
    db $D6, $D6, $D6, $D6
    db $93, $93, $93, $93
    db $D6, $D6, $D6, $D6
    db $D7, $FF, $FF, $FF
    db $80, $FF, $FF, $FF
    
    ; $045726
    .properties
    db $22, $FF, $FF, $FF
    db $22, $62, $A2, $E2
    db $24, $64, $A4, $E4
    db $22, $62, $A2, $E2
    db $22, $62, $A2, $E2
    db $22, $FF, $FF, $FF
    db $22, $FF, $FF, $FF

    ; $045742
    .offset_y
    dw -4,  0,  0,  0
    dw -8, -8,  0,  0
    dw -8, -8,  0,  0
    dw -8, -8,  0,  0
    dw -8, -8,  0,  0
    dw -4,  0,  0,  0
    dw -4,  0,  0,  0
    
    ; $04577A
    .offset_x
    dw -4,  0,  0,  0
    dw -8,  0, -8,  0
    dw -8,  0, -8,  0
    dw -8,  0, -8,  0
    dw -8,  0, -8,  0
    dw -4,  0,  0,  0
    dw -4,  0,  0,  0
}

; $0457B2-$04584C JUMP LOCATION
Ancilla_InitialSpinSpark:
{
    LDA $11 : BNE .draw
        DEC.w $03B1, X : BPL .draw
            STZ.w $03B1, X
            
            LDA.w $0C68, X : BNE .draw
                LDA.w $0C5E, X : INC A : STA.w $0C5E, X : TAY
                
                LDA.w Pool_Ancilla_InitialSpinSpark_timers, Y : STA.w $0C68, X
                
                CPY.b #$05 : BNE .draw
                    ; WTF: When is this branch ever taken? Perhaps this was test
                    ; code, as the sword beam graphics are similar if not
                    ; identical a spin attack.
                    LDA.w $0C54, X : BNE .spawn_sword_beam
                        BRL InitialSpinSpark_TransmuteToNormalSpinSpark
                    
                    .spawn_sword_beam
                    
                    JSL.l AddSwordBeam
                    
                    RTS
    
    .draw
    
    LDA.w $0C5E, X : BEQ .first_state_invisible
        JSR.w Ancilla_PrepOamCoord
        
        REP #$20
        
        LDA $00 : STA $06
        LDA $02 : STA $08
        
        SEP #$20
        
        PHX
        
        LDY.b #$00 : STY $04
        
        LDA.w $0C5E, X : DEC A : ASL #2 : TAX
        
        ; $045802 ALTERNATE ENTRY POINT
        .OAM_commit_loop
        
        .next_OAM_entry
            
            LDA.w Pool_Ancilla_InitialSpinSpark_chr, X : CMP.b #$FF : BEQ .skip_OAM_entry
                REP #$20
                
                PHX : TXA : ASL A : TAX
                
                LDA $06 : CLC : ADC.w Pool_Ancilla_InitialSpinSpark_offset_y, X
                STA $00

                LDA $08 : CLC : ADC.w Pool_Ancilla_InitialSpinSpark_offset_x, X
                STA $02
                
                PLX
                
                SEP #$20
                
                JSR.w Ancilla_SetOam_XY
                
                LDA.w Pool_Ancilla_InitialSpinSpark_chr, X : STA ($90), Y
                INY

                LDA.w Pool_Ancilla_InitialSpinSpark_properties, X
                AND.b #$CF : ORA $65 : STA ($90), Y
                INY
                
                PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
                
                LDA.b #$00 : STA ($92), Y
                
                PLY
            
            .skip_OAM_entry
            
            INX
        INC $04 : LDA $04 : AND.b #$03 : BNE .next_OAM_entry
        
        PLX
    
    .first_state_invisible
    
    RTS
}

; ==============================================================================

; TTNSS = TransmuteToNormalSpinSpark
; $04584D-$04586C DATA
Pool_InitialSpinSpark_TTNSS:
{
    ; $04584D
    .initial_rotation_states
    db $21, $20, $1F, $1E
    db $03, $02, $01, $00
    db $12, $11, $10, $0F
    db $31, $30, $2F, $2E
    
    ; $04585D
    .player_relative_y_offsets
    dw 28, -2, 24,  6
    
    ; $045865
    .player_relative_x_offsets
    dw -3, 21, 25, -8
}

; $04586D-$0458F5 LONG BRANCH LOCATION
InitialSpinSpark_TransmuteToNormalSpinSpark:
{
    LDA.b #$2B : STA.w $0C4A, X
    
    LDA $2F : ASL A : TAY
    
    LDA.w Pool_InitialSpinSpark_TTNSS_initial_rotation_states, Y : STA.l $7F5800
    LDA.w Pool_InitialSpinSpark_TTNSS_initial_rotation_states, Y : STA.l $7F5801
    LDA.w Pool_InitialSpinSpark_TTNSS_initial_rotation_states, Y : STA.l $7F5802
    LDA.w Pool_InitialSpinSpark_TTNSS_initial_rotation_states, Y : STA.l $7F5803
                                                                   STA.l $7F5804
    
    LDA.b #$02 : STA.w $03B1, X
    LDA.b #$4C : STA.w $0C5E, X
    LDA.b #$08 : STA.w $039F, X
    
    STZ.w $0C54, X
    STZ.w $0385, X
    
    LDA.b #$FF : STA.w $03A4, X
    
    LDA.b #$14 : STA.l $7F5808
    
    LDY $2F
    
    REP #$20
    
    LDA $20 : CLC : ADC.w #$000C : STA.l $7F5810
    LDA $22 : CLC : ADC.w #$0008 : STA.l $7F580E
    
    LDA $20 
    CLC : ADC.w Pool_InitialSpinSpark_TTNSS_player_relative_y_offsets, Y
    STA $00
    
    LDA $22
    CLC : ADC.w Pool_InitialSpinSpark_TTNSS_player_relative_x_offsets, Y
    STA $02
    
    SEP #$20
    
    LDA $00 : STA.w $0BFA, X
    LDA $01 : STA.w $0C0E, X
    
    LDA $02 : STA.w $0C04, X
    LDA $03 : STA.w $0C18, X
    
    BRA Ancilla_SpinSpark
}

; ==============================================================================
