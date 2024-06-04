
    ; \note This file makes use of three sort of 'pseduo'-ancilla objects,
    ; in that they make use of the Ancilla API, but don't really fit into
    ; the normal framework of Ancillae. One of these is a fairy object,
    ; the second is an invisible object that controls the player's altitude
    ; during revival, creating a sort of rising effect that later changes
    ; to a floating effect.
    ; The third object (index 2) is the fairy dust object, which makes use
    ; of the existing magic powder ancillary object's drawing routine, though
    ; it uses a different sound effect.

; ==============================================================================

; $04727C-$047282 DATA
Pool_Ancilla_RevivalFairy:
{
    ; \note The first one probably isn't even used as it's the start state
    .timers
    db $00, $90
    
    .chr
    db $4B, $4D, $49, $47
}

; ==============================================================================

; \note Looks like this animated the fairies during death mode.
; $047283-$0473CE LONG JUMP LOCATION
Ancilla_RevivalFairy:
{
    PHB : PHK : PLB
    
    LDX.b #$00
    
    LDA $0C54, X : BEQ .fairy_emerging
    CMP.b #$03   : BNE .already_emerged
                   BRL .return
    
    .fairy_emerging
    
    DEC $039F, X : LDA $039F, X : BNE .fairy_rising
    
    INC $0C54, X : LDY $0C54, X
    
    LDA .timers, Y : STA $039F, X
    
    STZ $0380, X
    STZ $0294, X
    
    BRL .draw
    
    .fairy_rising
    
    JSR Ancilla_MoveAltitude
    
    BRL .draw
    
    .already_emerged
    
    CMP.b #$01 : BNE .fairy_flying_away
    
    DEC $039F, X : LDA $039F, X : BNE .sprinkling_sequence_running
    
    INC $0C54, X
    
    STZ $0294, X
    STZ $0C2C, X
    
    BRL .draw
    
    .sprinkling_sequence_running
    
    CMP.b #$4F : BEQ .initiate_sprinkle
    CMP.b #$8F : BNE .dont_initiate_sprinkle
    
    .initiate_sprinkle
    
    INC $0385, X
    
    ; Sprinkling fairy dust sound.
    LDA.b #$31 : JSR Ancilla_DoSfx2
    
    .dont_initiate_sprinkle
    
    LDA $0385, X : BEQ .no_sprinkle_animation
    
    DEC $0394, X : BPL .sprinkle_animation_delay
    
    LDA.b #$05 : STA $0394, X
    
    INC $0C5E, X
    
    LDA $0C5E, X : CMP.b #$03 : BNE .sprinkle_animation_incomplete
    
    STZ $0C5E, X
    STZ $0385, X
    
    .no_sprinkle_animation
    .sprinkle_animation_delay
    .sprinkle_animation_incomplete
    
    LDY.b #$FF
    
    LDA $0380, X : BEQ .float_descending
    
    ; and conversely, ascending
    LDY.b #$01
    
    .float_descending
    
    STY $00
    
    LDA $0294, X : CLC : ADC $00 : STA $0294, X : BPL .positive_z_velocity
    
    ; Basically, don't allow the velocity to become negative?
    ; \wtf Does this logic actually work properly in the game?
    EOR.b #$FF : INC A
    
    .positive_z_velocity
    
    CMP.b #$08 : BNE .dont_toggle_float_direction
    
    LDA $0380, X : EOR.b #$01 : STA $0380, X
    
    .dont_toggle_float_direction
    
    JSR Ancilla_MoveAltitude
    
    BRA .draw
    
    .fairy_flying_away
    
    CMP.b #$02 : BNE .draw
    
    LDA $0294, X : CMP.b #$18 : BCS .z_velocity_maxed
    
    CLC : ADC.b #$01 : STA $0294, X
    
    .z_velocity_maxed
    
    LDA $0C2C, X : CMP.b #$10 : BCS .x_velocity_maxed
    
    CLC : ADC.b #$01 : STA $0C2C, X
    
    .x_velocity_maxed
    
    JSR Ancilla_MoveHoriz
    JSR Ancilla_MoveAltitude
    
    .draw
    
    LDA.b #$0C : JSL OAM_AllocateFromRegionC
    
    JSR Ancilla_PrepOamCoord
    
    PHX
    
    STZ $0A
    
    LDA $0C54, X : CMP.b #$01 : BNE .not_sprinkling_dust
    
    LDA $0385, X : BEQ .not_sprinkling_dust
    
    LDA $0C5E, X : INC A : STA $0A
    
    .not_sprinkling_dust
    
    LDY.b #$00
    
    REP #$20
    
    LDA $029E, X : AND.w #$00FF : CMP.w #$0080 : BCC .positive_altitude
    
    ORA.w #$FF00
    
    .positive_altitude
    
    EOR.w #$FFFF : INC A : CLC : ADC $00 : STA $00
    
    SEP #$20
    
    JSR Ancilla_SetOam_XY
    
    LDA $0A : BEQ .fairy_just_flapping
    
    DEC A : CLC : ADC.b #$02 : TAX
    
    BRA .fairy_just_flapping
    
    .fairy_not_sprinkling_dust
    
    ; Just alternate the fairy's chr every 4 frames
    LDA $1A : AND.b #$04 : LSR #2 : TAX
    
    .commit_fairy_chr
    
    LDA .chr, X  : STA ($90), Y : INY
    LDA.b #$74   : STA ($90), Y
    
    TYA : SEC : SBC.b #$03 : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLX
    
    LDY.b #$01
    
    LDA ($90), Y : CMP.b #$F0 : BNE .fairy_not_off_screen
    
    LDA.b #$03 : STA $0C54, X
    
    INC $11
    
    LDA $7EC211 : STA $1C
    
    .return
    .fairy_not_off_screen
    
    JSR RevivalFairy_Dust
    JSR RevivalFairy_MonitorPlayerRecovery
    
    PLB
    
    RTL
}

; ==============================================================================

; $0473CF-$04742F LOCAL JUMP LOCATION
RevivalFairy_Dust:
{
    LDA $0C54, X : BNE .possible_fairy_dust
    
    ; If the fairy object is not at least in state 0x01, do nothing.
    RTS
    
    .possible_fairy_dust
    
    LDX.b #$02
    
    LDA $0C54, X : CMP.b #$02 : BEQ .return
    
    DEC $039F, X : BPL .return
    
    STZ $039F, X
    
    LDA.b #$10
    
    LDY $0FB3 : BNE .sort_sprites
    
    JSL OAM_AllocateFromRegionA
    
    BRA .oam_allocated
    
    .sort_sprites
    
    JSL OAM_AllocateFromRegionD
    
    .oam_allocated
    
    DEC $03B1, X : BPL .animation_delay
    
    LDA.b #$03 : STA $03B1, X
    
    LDY.b #$03
    
    ; probably chr or a grouping state?
    LDA Ancilla_MagicPowder.animation_group_offsets, Y : STA $00
    
    LDA $0C5E, X : INC A : CMP.b #$0A : BNE .powder_not_fully_dispersed
    
    LDA.b #$20 : STA $039F, X
    
    INC $0C54, X
    
    LDA.b #$02 : STA $0C5E, X
    
    BRA .return
    
    .powder_not_fully_dispersed
    
    STA $0C5E, X
    
    CLC : ADC $00 : TAY
    
    ; oam group? or something else...
    LDA.w $B8F4, Y : STA $03C2, X
    
    .animation_delay
    
    JSR MagicPowder_Draw
    
    .return
    
    RTS
} 

; ==============================================================================

; $047430-$0474C9 LOCAL JUMP LOCATION
RevivalFairy_MonitorPlayerRecovery:
{
    LDA $7EF36C : STA $00
    LDA $7EF36D : CMP $00 : BEQ .health_at_capacity
    
    CMP.b #$38 : BNE .below_seven_hearts
    
    .health_at_capacity
    
    LDA $020A : BNE .health_refill_animation_active
    
    LDY.b #$00
    
    LDA $0345 : BEQ .not_swimming
    
    LDY.b #$04
    
    LDA.b #$04 : STA $0340
    
    BRA .set_player_state
    
    .not_swimming
    
    LDA $56 : BEQ .not_bunny
    
    LDY.b #$17
    
    LDA.b #$01 : STA $02E0
    
    .not_bunny
    .set_player_state
    
    STY $5D
    
    STZ $4D
    STZ $036B
    STZ $030D
    STZ $030A
    STZ $24
    STZ $46
    STZ $0C4A
    STZ $0C4B
    STZ $0C4C
    STZ $0C4D
    STZ $0C4E
    
    RTS
    
    .below_seven_hearts
    .health_refill_animation_active
    
    LDX.b #$01
    
    LDA $0C54, X : BNE .player_floating
    
    DEC $039F, X : LDA $039F, X : BNE .delay_altitude_increase
    
    INC $039F, X
    
    LDA.b #$04 : STA $0294, X
    
    JSR Ancilla_MoveAltitude
    
    LDA $029E, X : CMP.b #$10 : BCC .altitude_not_at_target
    
    INC $0C54, X
    
    LDA.b #$02 : STA $0294, X
    
    .delay_altitude_increase
    .altitude_not_at_target
    
    BRA .set_player_altitude
    
    .player_floating
    
    DEC $0380, X : BPL .delay_float_direction_toggle
    
    LDA.b #$20 : STA $0380, X
    
    LDA $0294, X : EOR.b #$FF : INC A : STA $0294, X
    
    .delay_float_direction_toggle
    
    JSR Ancilla_MoveAltitude
    
    .set_player_altitude
    
    LDA $029E, X : STA $24
    
    RTS
}

; ==============================================================================
