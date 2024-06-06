
; ==============================================================================

; $042AA0-$042B5A LOCAL JUMP LOCATION
Ancilla_EtherSpell:
{
    ; Special object 0x18 (Ether effect)
    
    LDA $11 : BEQ .normal_submode
    
    ; This object is not drawn in other submodes than 0.
    BRL .return
    
    .normal_submode
    
    ; This designates a step in the animation
    ; Is it the first step? (yes)
    LDA $0C54, X : BEQ .no_palette_manipulation
    
    LDA $031D : BNE .lightning_finished_descending
    
    INC $0BF0, X : LDA $0BF0, X : AND.b #$04 : BEQ .flash_bgs_white
    
    BRA .undo_bgs_whitening
    
    .lightning_finished_descending
    
    LDA $031D : CMP.b #$0B : BNE .check_timer
    
    .flash_bgs_white
    
    PHX
    
    JSL Palette_ElectroThemedGear
    JSL Filter_Majorly_Whiten_Bg
    
    PLX
    
    BRA .rotation_query
    
    .undo_bgs_whitening
    
    PHX
    
    JSL LoadActualGearPalettes
    JSL Palette_Restore_BG_From_Flash
    
    PLX
    
    .no_palette_manipulation
    .rotation_query
    
    ; Only rotate the balls during state 2?
    LDA $0C54, X : CMP.b #$02 : BNE .check_timer
    
    DEC $03B1, X : BPL .delay
    
    ; Cause a minor delay before the ether balls form.
    LDA.b #$02 : STA $03B1, X
    
    ; Has to do with the tile set for the effect.
    LDA $0C5E, X : INC A : STA $0C5E, X : CMP.b #$02 : BNE .delay
    
    ; Set it back down to #$01
    DEC $0C5E, X
    
    ; Set it so that the balls are going outward.
    LDA.b #$10 : STA $0C2C, X
    
    ; Set it to ball rotation state.
    LDA.b #$03 : STA $0C54, X
    
    .delay
    
    ; Increment the (speed counter?)
    LDA $0C2C, X : CLC : ADC.b #$01 : STA $0C2C, X
    
    BRL EtherSpell_RadialStates
    
    .check_timer
    
    DEC $03B1, X : BPL .dont_toggle_ball_chr
    
    LDA.b #$02 : STA $03B1, X
    
    ; switch the tile set between one or the other.
    LDA $0C5E, X : EOR.b #$01 : STA $0C5E, X
    
    .dont_toggle_ball_chr
    
    LDA $0C54, X : BEQ .lightning_descends
    CMP.b #$01   : BEQ .pulsing_blitz_orb
    CMP.b #$03   : BEQ .radial_states
    CMP.b #$04   : BEQ .calm_before_ball_scatter
    
    LDA $0C2C, X : CLC : ADC.b #$10 : BPL .radial_speed_not_maxed
    
    LDA.b #$7F
    
    .radial_speed_not_maxed
    
    ; Reset it back to 0x7F if it's positive.
    STA $0C2C, X
    
    BRL .radial_states
    
    .lightning_descends
    
    BRA EtherSpell_LightningDescends
    
    .pulsing_blitz_orb
    
    BRL EtherSpell_PulsingBlitzOrb
    
    .calm_before_ball_scatter
    
    ; ... Count down a timer before entering the final state of the spell.
    LDA.l $7F5812 : DEC A : STA.l $7F5812 : BNE .radial_states
    
    LDA.b #$05 : STA $0C54, X
    
    .radial_states
    
    BRL EtherSpell_RadialStates
    
    .return
    
    RTS
}

; ==============================================================================

    ; \unused Doesn't seem referenced in the rom...
; $042B5B-$042B62 DATA
Pool_EtherSpell_LightningDescends:
{
    db $E0, $00, $E8, $E8, $00, $20, $18, $18
}

; ==============================================================================

    ; 0th state of the ether spell.
; $042B63-$042BA6 BRANCH LOCATION
EtherSpell_LightningDescends:
{
    JSR Ancilla_MoveVert
    
    LDA $0C0E, X : STA $01
    LDA $0BFA, X : STA $00
    
    AND.b #$F0 : CMP.l $7F580C : BEQ .dont_add_lightning_segment
    
    STA.l $7F580C
    
    ; Add another lightning segment.
    INC $03C2, X
    
    .dont_add_lightning_segment
    
    REP #$20
    
    ; \wtf What's so special about 0xE000? Is this a cheat code
    ; or something to prematurely end the spell?
    LDA $00 : CMP.w #$E000 : BCS .delay
    
    LDA.l $7F580A : CMP.w #$E000 : BCS .at_target_coord
    
    ; Move on to the next state when the object's y coordinate is lower on
    ; the screen or exactly at the target point set during the init routine.
    LDA.l $7F580A : CMP $00 : BEQ .at_target_coord
                            BCS .delay
    
    .at_target_coord
    
    SEP #$20
    
    LDA.b #$01 : STA $0C54, X
    
    .delay
    
    SEP #$20
    
    BRL EtherSpell_DrawBlitzSegments
}

; ==============================================================================

; $042BA7-$042BEE BRANCH LOCATION
EtherSpell_PulsingBlitzOrb:
    
    LDA $03C2, X : BMI .segments_all_terminated
    
    DEC $039F, X : BPL .draw_segments
    
    LDA.b #$03 : STA $039F, X
    
    DEC $03C2, X : BPL .draw_segments
    
    LDA.b #$09 : STA $039F, X
    
    BRA .segments_all_terminated
    
    .draw_segments
    
    BRL EtherSpell_DrawBlitzSegments
    
    .segments_all_terminated
    
    DEC $039F, X : BPL .state_change_delay
    
    LDA.b #$02 : STA $0C54, X
    
    STZ $0C22, X
    
    LDA.b #$10 : STA $0C2C, X
    
    STZ $0C5E, X
    
    LDA.b #$02 : STA $03B1, X
    
    ; Um.... why would this ever happen? It appears to me that the
    ; ether medallion keeps this at a nonzero value until the effect
    ; is completely over...
    LDA $031D : BEQ .dont_damage_sprites
    
    PHX
    
    JSL Medallion_CheckSpriteDamage
    
    PLX
    
    .state_change_delay
    .dont_damage_sprites
    
    LDY.b #$00
    
    BRL EtherSpell_DrawBlitzOrb
}

; ==============================================================================

; $042BEF-$042CEA BRANCH LOCATION
EtherSpell_RadialStates:
{
    LDA $0C54, X : CMP.b #$04 : BNE .no_sound_effect
    
    LDY.b #$2A
    
    LDA $1A : AND.b #$07 : BEQ .play_sound_effect
    
    LDY.b #$AA
    
    CMP.b #$04 : BEQ .play_sound_effect
    
    CMP.b #$07 : BNE .no_sound_effect
    
    LDY.b #$6A
    
    .play_sound_effect
    
    STY $012F
    
    .no_sound_effect
    
    LDA $0C54, X : CMP.b #$04 : BEQ .dont_increase_radius
    
    LDA.l $7F5808 : STA $0C04, X
                  STZ $0C18, X
    
    JSR Ancilla_MoveHoriz
    
    ; Wish I had a better name for this label... but ugh.
    LDA $0C04, X : STA.l $7F5808 : CMP.b #$40 : BNE .not_ready_for_state_4
    
    LDA.b #$04 : STA $0C54, X
    
    .dont_increase_radius
    .not_ready_for_state_4
    
    PHX
    
    LDA $0C54, X : STA $72
    LDA $0C5E, X : STA $73
    
    LDY.b #$00
    LDX.b #$07
    
    .rotate_balls_loop
    
    LDA $72 : CMP.b #$02 : BEQ .dont_rotate_ball
              CMP.b #$05 : BEQ .dont_rotate_ball
    
    ; Increment the angle of the piece.
    LDA.l $7F5800, X : INC A : AND.b #$3F : STA.l $7F5800, X
    
    .dont_rotate_ball
    
    LDA.l $7F5808 : STA $08
    
    LDA.l $7F5800, X
    
    JSR Ancilla_GetRadialProjection
    
    PHX
    
    LDA $72 : CMP.b #$02 : BEQ .still_in_segment_form
    
    JSR EtherSpell_DrawBlitzBall
    
    BRA .moving_on
    
    .still_in_segment_form
    
    JSR EtherSpell_DrawSplittingBlitzSegment
    
    .moving_on
    
    PLX : DEX : BPL .rotate_balls_loop
    
    PLX
    
    ; The balls have been projected far out enough, so it's time to end this
    ; spell.
    LDA.l $7F5808 : CMP.b #$F0 : BCS .self_terminate
    
    LDY.b #$01
    
    .find_on_screen_effect_loop
    
    LDA ($90), Y : CMP.b #$F0 : BNE .return
    
    INY #4 : CPY.b #$21 : BNE .find_on_screen_effect_loop
    
    .self_terminate
    
    STZ $0C4A, X
    
    LDA.b #$01 : STA $0AAA
    
    STZ $0324
    STZ $031C
    STZ $031D
    STZ $50
    STZ $0FC1
    
    ; Checks if we're in the Swamp of Evil.
    LDA $8A : CMP.b #$70 : BNE .untriggered
    
    ; Checks whether the Misery Mire dungeon is revealed yet.
    LDA.l $7EF2F0 : AND.b #$20 : BNE .untriggered
    
    ; We might reveal it, but you have to be in the trigger window.
    LDY.b #$02 : JSR Ancilla_CheckIfEntranceTriggered : BCC .untriggered
    
    ; Do the 3rd animation for opening entrances
    LDA.b #$03 : STA $04C6
    
    STZ $B0 ; reset the sub submodule index
    STZ $C8 ; reset this other index.
    
    .untriggered
    
    LDA $5D : CMP.b #$19 : BEQ .not_spin_attack_revert
    
    LDA.b #$00 : STA $5D
    
    STZ $3D
    
    LDY.b #$00
    
    LDA $3C : BEQ .unknown
    
    LDA $F0 : AND.b #$80 : TAY
    
    .unknown
    
    STY $3A
    
    .not_spin_attack_revert
    
    STZ $5E
    
    ; Debug variable. Has no effect.
    STZ $0325
    
    PHX
    
    JSL LoadActualGearPalettes
    JSL Palette_Restore_BG_And_HUD
    
    PLX
    
    .return
    
    RTS
}

; ==============================================================================

; $042CEB-$042CEC DATA
Pool_EtherSpell_DrawBlitzBall:
{
    .chr
    db $68, $6A
}

; ==============================================================================

    ; \note Draws the circular 
; $042CED-$042D48 LOCAL JUMP LOCATION
EtherSpell_DrawBlitzBall:
{
    REP #$20
    
    PHY
    
    LDA $00
    
    LDY $02 : BEQ .positive_y_component
    
    EOR.w #$FFFF : INC A
    
    .positive_y_component
    
    STA $08
    
    CLC : ADC.l $7F5810 : CLC : ADC.w #$FFF8 : SEC : SBC $E8 : STA $00
    
    LDA $04
    
    LDY $06 : BEQ .positive_x_component
    
    EOR.w #$FFFF : INC A
    
    .positive_x_component
    
    STA $0A
    
    CLC : ADC.l $7F580E : CLC : ADC.w #$FFF8 : SEC : SBC $E2 : STA $02
    
    PLY
    
    SEP #$20
    
    JSR Ancilla_SetOam_XY
    
    LDA $73 : TAX
    
    LDA .chr, X  : STA ($90), Y : INY
    LDA.b #$3C   : STA ($90), Y : INY
    
    PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    JSR Ancilla_CustomAllocateOam
    
    PLY
    
    RTS
}

; ==============================================================================

; $042D49-$042DC8 DATA
Pool_EtherSpell_DrawSplittingBlitzSegment:
{
    .chr
    db $40, $42
    db $66, $64
    db $62, $60
    db $64, $66
    db $42, $40
    db $66, $64
    db $60, $62
    db $64, $66
    db $68, $42
    db $68, $64
    db $68, $60
    db $68, $64
    db $68, $40
    db $68, $66
    db $68, $62
    db $68, $64
    
    .properties
    db $3C, $3C
    db $FC, $FC
    db $3C, $3C
    db $BC, $BC
    db $3C, $3C
    db $3C, $3C
    db $3C, $3C
    db $7C, $7C
    db $3C, $7C
    db $3C, $3C
    db $3C, $BC
    db $3C, $7C
    db $3C, $7C
    db $3C, $FC
    db $3C, $BC
    db $3C, $BC
    
    .y_offsets
    dw   8
    dw   0
    dw  -8
    dw -16
    dw -24
    dw -16
    dw  -8
    dw -16
    dw   8
    dw   0
    dw  -8
    dw -16
    dw -24
    dw -16
    dw  -8
    dw   0
    
    .x_offsets
    dw  -8
    dw -16
    dw -24
    dw -16
    dw  -8
    dw   0
    dw   8
    dw -16
    dw  -8
    dw -16
    dw -24
    dw -16
    dw  -8
    dw   0
    dw   8
    dw   0
}

; ==============================================================================

    ; Commits two 16x16 sprites.
    ; Draws the blitz segments still in lightning form as they split away
    ; from the center. Shortly they will become blitz balls.
; $042DC9-$042E72 LOCAL JUMP LOCATION
EtherSpell_DrawSplittingBlitzSegment:
{
    REP #$20
    
    PHY
    
    LDA $00
    
    LDY $02 : BEQ .positive_y_component
    
    EOR.w #$FFFF : INC A
    
    .positive_y_component
    
    STA $08
    
    CLC : ADC.l $7F5810 : CLC : ADC.w #$FFF8 : SEC : SBC $E8 : STA $00
    
    LDA $04
    
    LDY $06 : BEQ .positive_x_component
    
    EOR.w #$FFFF : INC A
    
    .positive_x_component
    
    STA $0A
    
    CLC : ADC.l $7F580E : CLC : ADC.w #$FFF8 : SEC : SBC $E2 : STA $02
    
    PLY
    
    SEP #$20
    
    JSR Ancilla_SetOam_XY
    
    LDA $73 : ASL #4 : STA $0E
    
    TXA : ASL A : CLC : ADC $0E : TAX
    
    LDA .chr, X        : STA ($90), Y : INY
    LDA .properties, X : STA ($90), Y : INY
    
    PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY
    
    REP #$20
    
    LDA $08 : CLC : ADC.l $7F5810 : CLC : ADC .y_offsets, X : SEC : SBC $E8 : STA $00
    LDA $0A : CLC : ADC.l $7F580E : CLC : ADC .x_offsets, X : SEC : SBC $E2 : STA $02
    
    SEP #$20
    
    PHX
    
    JSR Ancilla_SetOam_XY
    
    PLX
    
    LDA .chr+1, X        : STA ($90), Y : INY
    LDA .properties+1, X : STA ($90), Y : INY
    
    PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY : JSR Ancilla_CustomAllocateOam
    
    RTS
}

; ==============================================================================

; $042E73-$042E86 DATA
Pool_EtherSpell_DrawBlitzSegments:
    parallel Pool_EtherSpell_DrawBlitzOrb:
{
    .chr
    db $40, $42, $44, $46
    
    .orb_chr
    db $48, $48, $4A, $4A
    db $4C, $4C, $4E, $4E
    
    .properties
    db $3C, $7C, $3C, $7C, $3C, $7C, $3C, $7C
}

; ==============================================================================

    ; \note 'Blitz' is German for lightning, and its shorter in characters,
    ; and I thought it sounded semi-cool to use as a name for the component.
; $042E87-$042EDC LONG BRANCH LOCATION
EtherSpell_DrawBlitzSegments:
{
    JSR Ancilla_PrepOamCoord
    
    LDA $0C5E, X : STA $06
    
    STZ $08
    
    PHX
    
    LDA $03C2, X : TAX
    
    LDY.b #$00
    
    .draw_next_segment
    
    JSR Ancilla_SetOam_XY
    
    PHX
    
    LDA $06 : ASL A : CLC : ADC $08 : TAX
    
    LDA .chr, X : STA ($90), Y
    
    PLX
    
    INY
    
    ; \tcrf The ether spell might have looked slightly different if this
    ; was an indexed load rather than the contrary. Try it out and see
    ; if anything interesting happens.
    LDA .properties : ORA $65 : STA ($90), Y : INY
    
    PHY
    
    SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PHY
    
    REP #$20
    
    LDA $00 : SEC : SBC.w #$0010 : STA $00
    
    SEP #$20
    
    LDA $08 : EOR.b #$01 : STA $08
    
    DEX : BPL .draw_next_segment
    
    PLX
    
    LDA $0C54, X : CMP.b #$01 : BEQ EtherSpell_DrawBlitzOrb
    
    RTS
}

; ==============================================================================

; $042EDD-$042F55 LONG BRANCH LOCATION
EtherSpell_DrawBlitzOrb:
{
    REP #$20
    
    LDA.l $7F5813 : CLC : ADC.w #$FFFF : SEC : SBC $E8 : STA $00
    LDA.l $7F5815 : CLC : ADC.w #$FFF8 : SEC : SBC $E2 : STA $02 : STA $04
    
    STZ $08
    
    SEP #$20
    
    PHX
    
    LDA $0C5E, X : ASL #2 : STA $06
    
    .next_oam_entry
    
    JSR Ancilla_SetOam_XY
    
    LDX $06
    
    LDA .orb_chr, X    : STA ($90), Y : INY
    LDA .properties, X : STA ($90), Y : INY
    
    PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY : JSR Ancilla_CustomAllocateOam
    
    REP #$20
    
    LDA $02 : CLC : ADC.w #$0010 : STA $02
    
    INC $06
    
    INC $08 : LDA $08 : CMP.w #$0004 : BEQ .done_drawing
                        CMP.w #$0002 : BNE .dont_prep_right_half
    
    LDA $00 : CLC : ADC.w #$0010 : STA $00
    
    LDA $04 : STA $02
    
    .dont_prep_right_half
    
    SEP #$20
    
    BRA .next_oam_entry
    
    .done_drawing
    
    SEP #$20
    
    PLX
    
    RTS
}

; ==============================================================================
