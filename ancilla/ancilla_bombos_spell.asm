; ==============================================================================

; $042F56-$042F65 DATA
Pool_AddBombosSpell:
{
    ; $042F56
    .y_offsets
    dw   16,   24, -128,  -16
    
    ; $042F5E
    .x_offsets
    dw  -16, -128,    0,  128
}

; Adds the bombos effect in response to getting it for the first time.
; The ether medallion doesn't use this approach so I wonder why the diff?
; $042F66-$0430CD LONG JUMP LOCATION
AddBombosSpell:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_Spawn : BCC .spawn_succeeded
        BRL .spawn_failed
    
    .spawn_succeeded
    
    LDA.b #$03
    
    STA.l $7F5800 : STA.l $7F5801 : STA.l $7F5802 : STA.l $7F5803
    STA.l $7F5804 : STA.l $7F5805 : STA.l $7F5806 : STA.l $7F5807
    STA.l $7F5808 : STA.l $7F5809
    
    STA.l $7F5945 : STA.l $7F5946 : STA.l $7F5947 : STA.l $7F5948
    STA.l $7F5949 : STA.l $7F594A : STA.l $7F594B : STA.l $7F594C
    
    LDA.b #$00
    
    STA.l $7F5810 : STA.l $7F5811 : STA.l $7F5812 : STA.l $7F5813
    STA.l $7F5814 : STA.l $7F5815 : STA.l $7F5816 : STA.l $7F5817
    STA.l $7F5818 : STA.l $7F5819
    
    STA.l $7F5935 : STA.l $7F5936 : STA.l $7F5937 : STA.l $7F5938
    STA.l $7F5939 : STA.l $7F593A : STA.l $7F593B : STA.l $7F593C
    STA.l $7F5934
    
    STA.l $7F5A56
    
    ; Set an overall timer for the effect? \warning Set this below 0x40,
    ; and the game will go into an infinite loop due to particularities
    ; of this ancillary object's code.
    LDA.b #$80 : STA.l $7F5A55
    LDA.b #$10 : STA.l $7F5820
    
    LDA.b #$0B : STA.w $0AAA
    
    LDA.b #$01 : STA.w $0112
    
    STZ.w $0C54, X
    STZ.w $0C5E, X
    
    LDA.b #$2A : JSR.w Ancilla_DoSfx2_NearPlayer
    
    PHX
    
    LDY $1A
    
    LDA $21 : STA.l $7F5956
    LDA $23 : STA.l $7F59D6
    
    ; WTF: this points to a nonexistent data table. Is this on purpose?
    ; (It points to the beginning of the boomerang ancilla code.
    ; BUG: Could be considered a bug, hard to say.
    LDA.w Ancilla_Boomerang, Y : CMP.b #$E0 : BCC .wtf
        AND.b #$7F
    
    .wtf
    
    STA.l $7F5955 : STA.l $7F59D5
    
    LDX.b #$00 : STX $72
    
    .never
    
        REP #$20
        
        LDA $20 : CLC : ADC Pool_AddBombosSpell_y_offsets, X : STA.l $7F5924, X
        LDA $22 : CLC : ADC Pool_AddBombosSpell_x_offsets, X : STA.l $7F592C, X
        
        SEP #$20
        
        PHX
        
        TXA : LSR : TAX
        
        LDA.b #$10 : STA $08 : STA.l $7F5A57
        
        LDA.l $7F5820, X
        
        PLX
        
        JSR.w Ancilla_GetRadialProjection
        
        REP #$20
        
        LDA $00
        
        LDY $02 : BEQ .positive_x_projection
            EOR.w #$FFFF : INC A
        
        .positive_x_projection
        
        CLC : ADC.l $7F5924, X : STA $00
        
        LDA $04
        
        LDY $06 : BEQ .positive_y_projection
            EOR.w #$FFFF : INC A
        
        .positive_y_projection
        
        CLC : ADC.l $7F592C, X : STA $04
        
        SEP #$20
        
        PHX
        
        LDX $72
        
        LDA $00 : STA.l $7F5824, X
        LDA $01 : STA.l $7F5864, X
        
        LDA $04 : STA.l $7F58A4, X
        LDA $05 : STA.l $7F58E4, X
        
        PLX
        
        LDA $72 : SEC : SBC.b #$10 : STA $72
    DEX #2 : BPL .never
    
    PLX
    
    .spawn_failed
    
    PLB
    
    RTL
}

; ==============================================================================

; $0430CE-$043109 JUMP LOCATION
Ancilla_BombosSpell:
{
    LDA.l $7F5934 : BNE .not_spawning_new_columns
        LDA $11 : BNE .just_draw_flame_columns
            JMP Bombos_ExecuteFlameColumns
        
        .just_draw_flame_columns
        
        LDY.b #$00
        LDX.b #$09
        
        .next_fire_column
        
            JSR.w BombosSpell_DrawFireColumn
        DEX : BPL .next_fire_column
        
        RTS
    
    .not_spawning_new_columns
    
    LDA.l $7F5934 : CMP.b #$02 : BEQ .in_blast_stage
        LDA $11 : BNE .just_draw_flame_columns
            JSR.w BombosSpell_WrapUpFlameColumns
            
            RTS
            
    .in_blast_stage
    
    LDA $11 : BEQ .dont_just_draw_blasts
        PHX
        
        LDA.w $0C54, X : TAX
        
        .draw_next_blast
        
            JSR.w BombosSpell_DrawBlast
        DEX : BPL .draw_next_blast
        
        PLX
        
        RTS
    
    .dont_just_draw_blasts
    
    JMP BombosSpell_ExecuteBlasts
}

; ==============================================================================

; $04310A-$043235 JUMP LOCATION
Bombos_ExecuteFlameColumns:
{
    PHX
    
    LDA.w $0C5E, X : STA $73
    
    LDA.w $0C54, X : STA $72 : TAX
    
    LDY.b #$00
    
    .next_column
        
    LDA.l $7F5810, X : CMP.b #$0D : BNE .active_column
        .inactive_column
        .done_activating_columns
        BRL .advance_to_next_column
    
    .active_column
    
    LDA.l $7F5800, X : DEC : STA.l $7F5800, X : BMI .timer_expired
        .dont_activate_another_column
        
        BRL .just_draw_column
    
    .timer_expired
    
    LDA.b #$03 : STA.l $7F5800, X
    
    LDA.l $7F5810, X : INC : STA.l $7F5810, X
    
    CMP.b #$0D : BEQ .inactive_column
        CMP.b #$02 : BNE .dont_activate_another_column
            ; WTF: I don't think this branch is ever taken.
            LDA $73 : BNE .done_activating_columns
                PHX
                
                LDA $72 : CMP.b #$09 : BNE .increment_column_count
                    LDX.b #$09
                    
                    .find_inactive_column_loop
                    
                        LDA.l $7F5810, X : CMP.b #$0D : BNE .column_not_ready_for_reset
                            LDA.b #$00 : STA.l $7F5810, X
                            
                            BRA .set_radial_distance_and_angle
                        
                        .column_not_ready_for_reset
                    DEX : BPL .find_inactive_column_loop
                
                .increment_column_count
                
                LDX $72 : INX : CPX.b #$0A : BNE .columns_not_maxed_out
                    LDX.b #$09
                
                .columns_not_maxed_out
                
                STX $72
                
                .set_radial_distance_and_angle
                
                TXA : CLC : ADC.b #$00 : STA $74
                
                .never
                    
                    LDA $74 : LSR #4 : TAX
                    
                    ; (proj = projection)
                    LDA.l $7F5A57 : CLC : ADC.b #$03 : CMP.b #$D0 : BCC .proj_distance_not_maxed
                        LDA.b #$CF
                    
                    .proj_distance_not_maxed
                    
                    STA.l $7F5A57 : STA $08
                    
                    LDA.l $7F5820, X : CLC : ADC.b #$06 : STA.l $7F5820, X
                    AND.b #$3F
                    
                    JSR.w Ancilla_GetRadialProjection
                    
                    TXA : ASL : TAX
                    
                    REP #$20
                    
                    PHY
                    
                    LDA $00
                    
                    LDY $02 : BEQ .positive_y_projection
                        EOR.w #$FFFF : INC A
                    
                    .positive_y_projection
                    
                    CLC : ADC.l $7F5924, X : STA $00
                    
                    LDA $04
                    
                    LDY $06 : BEQ .positive_x_projection
                        EOR.w #$FFFF : INC A
                    
                    .positive_x_projection
                    
                    CLC : ADC.l $7F592C, X : STA $04
                    
                    PLY
                    
                    SEP #$20
                    
                    LDX $74
                    
                    LDA $00 : STA.l $7F5824, X
                    LDA $01 : STA.l $7F5864, X
                    
                    LDA $04 : STA.l $7F58A4, X
                    LDA $05 : STA.l $7F58E4, X
                    
                    ; WTF: Okay.... seriously I think that either the Bombos
                    ; person was smoking crack or there was some earlier
                    ; version of this spell that employed more sprites. Or it
                    ; was differently implemented maybe. With a limit of 10
                    ; blasts, we're certainly never going to branch here.
                LDA $74 : SEC : SBC.b #$10 : STA $74 : BPL .never
                
                REP #$20
                
                LDA $04 : SEC : SBC $E2 : CLC : ADC.w #$0008 : STA $04
                
                SEP #$20
                
                LDA $05 : BNE .not_flame_SFX
                    LDA $04 : LSR #5 : TAX
                    
                    LDA.l AncillaPanValues, X : ORA.b #$2A : STA.w $012E
                
                .not_flame_SFX
                
                PLX
        
        .just_draw_column
        
        JSR.w BombosSpell_DrawFireColumn
    
    .advance_to_next_column
    
    DEX : BMI .handled_all_active_columns
        BRL .next_column
    
    .handled_all_active_columns
    
    PLX
    
    ; Checks if the first column slot's angle ever exceeds or meets 0x80.
    ; If so, move on to the next state that will phase out the flame
    ; columns.
    LDA.l $7F5820 : CMP.b #$80 : BCS .initiate_flame_column_wrap_up
        BRA .update_active_column_count
    
    .initiate_flame_column_wrap_up
    
    LDA.b #$01 : STA.l $7F5934
    
    .update_active_column_count
    
    LDA $72 : STA.w $0C54, X
    
    RTS
}

; ==============================================================================

; $043236-$043288 LOCAL JUMP LOCATION
BombosSpell_WrapUpFlameColumns:
{
    PHX
    
    LDA.w $0C54, X : TAX
    
    LDY.b #$00
    
    .next_fire_column
    
        LDA.l $7F5800, X : DEC : STA.l $7F5800, X
        BPL .delay
            LDA.b #$03 : STA.l $7F5800, X
            
            LDA.l $7F5810, X : INC : STA.l $7F5810, X
            CMP.b #$0D : BCC .not_inactive
                ; Keep the flame column inactive if it has already reached
                ; that state.
                LDA.b #$0D : STA.l $7F5810, X

            .not_inactive
        .delay
        
        JSR.w BombosSpell_DrawFireColumn
    DEX : BPL .next_fire_column
    
    LDX.b #$09
    
    .find_active_column_loop
    
        LDA.l $7F5810, X : CMP.b #$0D : BNE .not_all_inactive
    DEX : BPL .find_active_column_loop
    
    STZ $72
    
    ; Increment the overall effect state to begin displaying blasts.
    LDA.b #$02 : STA.l $7F5934
    
    PLX : PHX
    
    JSL.l Medallion_CheckSpriteDamage
    
    PLX
    
    STZ.w $0C54, X
    
    RTS
    
    .not_all_inactive
    
    PLX
    
    RTS
}

; ==============================================================================

; $043289-$043372 DATA
Pool_BombosSpell_DrawFireColumn:
{
    ; $043289
    .char
    db $40, $FF, $FF
    db $42, $44, $FF
    db $42, $44, $FF
    db $42, $44, $FF
    db $42, $44, $FF
    db $40, $46, $44
    db $4A, $4A, $48
    db $4C, $4C, $4A
    db $4E, $4C, $4A
    db $4E, $6A, $4C
    db $4E, $68, $FF
    db $6A, $FF, $FF
    db $4E, $FF, $FF

    ; $0432B0
    .prop
    db $3C, $FF, $FF
    db $3C, $3C, $FF
    db $3C, $3C, $FF
    db $7C, $7C, $FF
    db $3C, $7C, $FF
    db $3C, $3C, $3C
    db $BC, $3C, $3C
    db $7C, $3C, $3C
    db $3C, $3C, $7C
    db $3C, $3C, $3C
    db $3C, $3C, $FF
    db $3C, $FF, $FF
    db $3C, $FF, $FF

    ; $0432D7
    .offset_y
    dw   0,  -1,  -1
    dw   0,  -4,  -1
    dw   0,  -8,  -1
    dw   0, -12,  -1
    dw   0, -16,  -1
    dw   0,  -4, -20
    dw   0,  -8, -24
    dw   0, -12, -28
    dw   0, -16, -32
    dw   0, -16, -32
    dw -18, -34,  -1
    dw -35,  -1,  -1
    dw -36,  -1,  -1

    ; $043325
    .offset_x
    dw   0,  -1,  -1
    dw   0,   0,  -1
    dw   0,   0,  -1
    dw   0,   0,  -1
    dw   0,   0,  -1
    dw   0,   0,   0
    dw   0,   0,   0
    dw   0,   0,   0
    dw   0,   0,   0
    dw   0,   0,   0
    dw   0,   0,  -1
    dw   1,  -1,  -1
    dw   2,  -1,  -1
}

; $043373-$04340C LOCAL JUMP LOCATION
BombosSpell_DrawFireColumn:
{
    ; OPTIMIZE: Why add 0? Seems like some testing code here wasn't completely
    ; weeded out. See note near the end of this subroutine.
    TXA : CLC : ADC.b #$00 : STA $75
    
    LDA.b #$10 : JSR.w Ancilla_AllocateOam
    
    LDY.b #$00
    
    .never
    
        PHX
        
        LDA.l $7F5810, X : CMP.b #$0D : BEQ .inactive_flame_column
            ASL : CLC : ADC.l $7F5810, X : CLC : ADC.b #$02 : TAX
            
            STZ $08
            
            .next_OAM_entry
                
                LDA.w Pool_BombosSpell_DrawFireColumn_char, X : CMP.b #$FF : BEQ .skip_OAM_entry
                    PHX
                    
                    LDX $75
                    
                    LDA.l $7F5824, X : STA $00
                    LDA.l $7F5864, X : STA $01
                    
                    LDA.l $7F58A4, X : STA $02
                    LDA.l $7F58E4, X : STA $03
                    
                    PLX : PHX
                    
                    TXA : ASL : TAX
                    
                    REP #$20
                    
                    LDA $00
                    CLC : ADC.w Pool_BombosSpell_DrawFireColumn_offset_y, X
                    SEC : SBC $E8 : STA $00

                    LDA $02
                    CLC : ADC.w Pool_BombosSpell_DrawFireColumn_offset_x, X
                    SEC : SBC $E2 : STA $02
                    
                    SEP #$20
                    
                    JSR.w Ancilla_SetOam_XY
                    
                    PLX
                    
                    LDA.w Pool_BombosSpell_DrawFireColumn_char, X : STA ($90), Y
                    INY

                    LDA.w Pool_BombosSpell_DrawFireColumn_prop, X : STA ($90), Y
                    INY
                    
                    PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
                    
                    LDA.b #$02 : STA ($92), Y
                    
                    PLY
                    
                .skip_OAM_entry
                
                JSR.w Ancilla_CustomAllocateOam
                
                DEX
            INC $08 : LDA $08 : CMP.b #$03 : BNE .next_OAM_entry
        
        .inactive_flame_column
        
        PLX
        
        ; WTF: When would this ever evalute to >= 0?
        ; Debugger testing points to the game always branching here, thus
        ; backing me up on this.
        LDA $75 : SEC : SBC.b #$10 : STA $75
        BMI .always
    BRL .never
    
    .always
    
    RTS
}

; ==============================================================================

; $04340D-$043520 LOCAL JUMP LOCATION
BombosSpell_ExecuteBlasts:
{
    PHX
    
    LDY.b #$00
    
    ; Essentially operates as the number of active blasts in play at
    ; the moment.
    LDA.w $0C54, X : STA $72 : TAX
    
    .next_blast
    
        LDA.l $7F5935, X : CMP.b #$08 : BEQ .inactive_blast
            LDA.l $7F5945, X : DEC : STA.l $7F5945, X
            BMI .expired_delay_timer
            
        .inactive_blast
        .dont_activate_new_blast
        
        BRL .just_draw_blast
        
        .expired_delay_timer
        
        LDA.b #$03 : STA.l $7F5945, X
        
        LDA.l $7F5935, X : INC : STA.l $7F5935, X
        
        CMP.b #$01 : BNE .dont_activate_new_blast
            ; This flag indicates that the effect should absolutely not convert
            ; any more blasts to an active state.
            LDA.l $7F5A56 : BNE .dont_activate_new_blast
                PHX
                
                LDA $72 : CMP.b #$0F : BEQ .maxed_blast_count
                    LDA $72 : INC : CMP.b #$10 : BNE .not_maxed_blast_count
                        LDA.b #$0F
                    
                    .not_maxed_blast_count
                    
                    STA $72 : TAX
                    
                    BRA .activate_another_blast
                    
                .maxed_blast_count
                
                LDX.b #$0F
                
                .find_inactive_blast_loop
                
                    LDA.l $7F5935, X : CMP.b #$08 : BEQ .activate_another_blast
                DEX : BPL .find_inactive_blast_loop
                
                .activate_another_blast
                
                LDA.b #$00 : STA.l $7F5935, X
                LDA.b #$03 : STA.l $7F5945, X
                
                PHY
                
                TXA : ASL : TAY
                
                ; Determine the x and y coordinates of the blast. was wondering
                ; where that was done at. This is essentially an even simpler
                ; RNG than the game normally uses.
                LDA $1A : AND.b #$3F : TAX
                
                LDA.l Pool_BombosSpell_ExecuteBlasts_y_offsets, X : STA $00
                STZ $01

                LDA.l Pool_BombosSpell_ExecuteBlasts_x_offsets, X : STA $02
                STZ $03
                
                TYX
                
                REP #$20
                
                LDA $00 : CLC : ADC $E8 : STA.l $7F5955, X
                LDA $02 : CLC : ADC $E2 : STA.l $7F59D5, X
                
                SEP #$20
                
                LDA.l $7F59D5, X : LSR #5 : TAX
                
                LDA.l AncillaPanValues, X : ORA.b #$0C : STA.w $012E
                
                PLY : PLX
            
        .just_draw_blast
        
        JSR.w BombosSpell_DrawBlast
        
        DEX : BMI .handled_all_active_blasts
    BRL .next_blast
    
    .handled_all_active_blasts
    
    LDX.b #$0F
    
    .find_active_blast_loop
    
        LDA.l $7F5935, X : CMP.b #$08 : BNE .not_all_inactive
    DEX : BPL .find_active_blast_loop
    
    ; The bombos spell has run its course, time to self terminate and
    ; clear some of the related player state data.
    
    PLX
    
    STZ.w $0C4A, X
    
    LDA.b #$01 : STA.w $0AAA
    
    STZ.w $0324
    STZ.w $031C
    STZ.w $031D
    STZ $50
    STZ.w $0FC1
    
    LDA $5D : CMP.b #$1A : BEQ .player_in_bombos_mode
        ; If the player for some silly reason is not in bombos mode,
        ; put them back to ground state and reset things like
        ; the button inputs.
        LDA.b #$00 : STA $5D
        
        STZ $3D
        
        LDY.b #$00
        
        LDA $3C : BEQ .spin_attack_inactive
            ; This is to restore the player back to a held charge for spin attack
            ; if they were in that state prior to initiating the Bombos Spell.
            LDA $F0 : AND.b #$80 : TAY
            
        .spin_attack_inactive
        
        STY $3A
    
    .player_in_bombos_mode
    
    STZ $5E
    STZ.w $0325
    
    BRA .tick_blast_timer
    
    .not_all_inactive
    
    PLX
    
    LDA $72 : STA.w $0C54, X
    
    .tick_blast_timer
    
    LDA.l $7F5A55 : DEC : STA.l $7F5A55
    BNE .not_expired
        LDA.b #$01 : STA.l $7F5A56
                     STA.l $7F5A55
    
    .not_expired
    
    RTS
}

; ==============================================================================

; $043521-$0435E0 DATA
Pool_BombosSpell_DrawBlast:
{
    ; $043521
    .chr
    db $60, $FF, $FF, $FF
    db $62, $62, $62, $62
    db $64, $64, $64, $64
    db $66, $66, $66, $66
    db $68, $68, $68, $68
    db $68, $68, $68, $68
    db $6A, $6A, $6A, $6A
    db $4E, $4E, $4E, $4E
    
    ; $043541
    .properties
    db $3C, $FF, $FF, $FF
    db $3C, $7C, $BC, $FC
    db $3C, $7C, $BC, $FC
    db $3C, $7C, $BC, $FC
    db $3C, $7C, $BC, $FC
    db $3C, $7C, $BC, $FC
    db $3C, $7C, $BC, $FC
    db $3C, $7C, $BC, $FC
    
    ; $043561
    .y_offsets
    dw  -8,  -1,  -1,  -1
    dw -12, -12,  -4,  -4
    dw -16, -16,   0,   0
    dw -16, -16,   0,   0
    dw -17, -17,   1,   1
    dw -19, -19,   3,   3
    dw -19, -19,   3,   3
    dw -19, -19,   3,   3
    
    ; $0435A1
    .x_offsets
    dw  -8,  -1,  -1,  -1
    dw -12,  -4, -12,  -4
    dw -16,   0, -16,   0
    dw -16,   0, -16,   0
    dw -17,   1, -17,   1
    dw -19,   3, -19,   3
    dw -19,   3, -19,   3
    dw -19,   3, -19,   3
}

; $0435E1-$043669 LOCAL JUMP LOCATION
BombosSpell_DrawBlast:
{
    PHX
    
    LDA.b #$03 : STA $0C
    
    PHX : TXA : ASL : TAX
    
    LDA.l $7F5955, X : STA $08
    LDA.l $7F5956, X : STA $09
    
    LDA.l $7F59D5, X : STA $0A
    LDA.l $7F59D6, X : STA $0B
    
    PLX
    
    LDA.l $7F5935, X : CMP.b #$08 : BEQ .inactive_blast
        LDA.b #$10 : JSR.w Ancilla_AllocateOam
        
        LDY.b #$00
        
        LDA.l $7F5935, X : ASL #2 : CLC : ADC.b #$03 : STA $73 : TAX
        
        .next_OAM_entry
            
            LDA.w Pool_BombosSpell_DrawFireColumn_char, X : CMP.b #$FF : BEQ .skip_OAM_entry
                PHX : TXA : ASL : TAX
                
                REP #$20
                
                LDA.w Pool_BombosSpell_DrawBlast_y_offsets, X
                CLC : ADC $08 : SEC : SBC $E8 : STA $00

                LDA.w Pool_BombosSpell_DrawBlast_x_offsets, X
                CLC : ADC $0A : SEC : SBC $E2 : STA $02
                
                SEP #$20
                
                PLX
                
                JSR.w Ancilla_SetOam_XY
                
                LDA.w Pool_BombosSpell_DrawBlast_chr, X : STA ($90), Y
                INY

                LDA.w Pool_BombosSpell_DrawBlast_properties, X : STA ($90), Y
                INY
                
                PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
                
                LDA.b #$02 : STA ($92), Y
                
                PLY
                
            .skip_OAM_entry
            
            JSR.w Ancilla_CustomAllocateOam
            
            DEX
        DEC $0C : BPL .next_OAM_entry
    
    .inactive_blast
    
    PLX
    
    RTS
}

; ==============================================================================
