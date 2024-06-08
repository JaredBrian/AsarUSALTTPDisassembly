
; ==============================================================================

; $0EDD7B-$0EDD82 LONG JUMP LOCATION
Sprite_RavenLong:
{
    PHB : PHK : PLB
    
    JSR SpritePrep_Raven
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EDD83-$0EDD84 DATA
Pool_Sprite_SetHflip:
{
    .h_flip
    db $00, $40
}

; ==============================================================================

; $0EDD85-$0EDDAB LOCAL JUMP LOCATION
Sprite_Raven:
{
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite4_CheckIfActive
    JSR Sprite4_CheckIfRecoiling
    JSR Sprite4_CheckDamage
    JSR Sprite4_Move
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Raven_InWait
    dw Raven_Ascend
    dw Raven_Attack
    dw Raven_FleePlayer
}

; ==============================================================================

; $0EDDAC-$0EDDAD DATA
Pool_Raven_Ascend:
{
    ; \task Name this routine / pool.
    .timers
    db $10, $F8
}

; ==============================================================================

; $0EDDAE-$0EDDE4 JUMP LOCATION
Raven_InWait:
{
    JSR Sprite4_IsToRightOfPlayer
    JSR Raven_SetHflip
    
    REP #$20
    
    LDA $22 : SEC : SBC.w $0FD8 : ADC.w #$0050 : CMP.w #$00A0 : BCS .player_too_far
    
    LDA $20 : SEC : SBC.w $0FDA : ADC.w #$0058 : CMP.w #$00A0 : BCS .player_too_far
    
    SEP #$20
    
    INC.w $0D80, X
    
    LDA.b #$18 : STA.w $0DF0, X
    
    LDA.b #$1E : JSL Sound_SetSfx3PanLong
    
    .player_too_far
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0EDDE5-$0EDE08 JUMP LOCATION
Raven_Ascend:
{
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDY.w $0D90, X
    
    LDA .timers, Y : STA.w $0DF0, X
    
    LDA.b #$20
    
    JSL Sprite_ApplySpeedTowardsPlayerLong
    
    .delay
    
    INC.w $0F70, X
    
    LDA $1A : LSR A : AND.b #$01 : INC A : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0EDE09-$0EDE65 JUMP LOCATION
Raven_Attack:
{
    LDA.w $0DF0, X : BNE .delay_fleeing
    
    LDA.w $0FFF : BEQ .always_flee_in_light_world
    
    ; Afaik, all Dark World 'ravens' are fearless. They look like mini-
    ; pterodactyls.
    LDA.w $0D90, X : BNE .is_fearless
    
    .always_flee_in_light_world
    
    INC.w $0D80, X
    
    .is_fearless
    .delay_fleeing
    
    TXA : EOR $1A : LSR A : BCS .delay_speed_analysis
    
    LDA #$20 : JSL Sprite_ProjectSpeedTowardsPlayerLong
    
    ; $0EDE27 ALTERNATE ENTRY POINT
Raven_AccelerateToTargetSpeed:
    
    LDA.w $0D40, X : CMP $00 : BEQ .y_speed_at_target
                             BPL .y_speed_above_target
    
    INC.w $0D40, X
    
    BRA .check_x_speed
    
    .y_speed_above_target
    
    DEC.w $0D40, X
    
    .y_speed_at_target
    .check_x_speed
    
    LDA.w $0D50, X : CMP $01 : BEQ .x_speed_at_target
                             BPL .x_speed_above_target
    
    INC.w $0D50, X
    
    BRA .animate
    
    .x_speed_above_target
    
    DEC.w $0D50, X
    
    .x_speed_at_target
    .delay_speed_analysis
    .animate
    
    ; $0EDE49 ALTERNATE ENTRY POINT
    shared Raven_Animate:
    
    LDA $1A : LSR A : AND.b #$01 : INC A : STA.w $0DC0, X
    
    LDA.w $0D50, X : ASL A : ROL A : AND.b #$01 : TAY
    
    ; $0EDE5A ALTERNATE ENTRY POINT
    shared Raven_SetHflip:
    
    LDA.w $0F50, X : AND.b #$BF : ORA.w $DD83, Y : STA.w $0F50, X
    
    RTS
}

; ==============================================================================

; $0EDE66-$0EDE81 JUMP LOCATION
Raven_FleePlayer:
{
    TXA : EOR $1A : LSR A : BCS Raven_Animate
    
    LDA.b #$30 : JSL Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA $00 : EOR.b #$FF : INC A : STA $00
    
    LDA $01 : EOR.b #$FF : INC A : STA $01
    
    BRA Raven_AccelerateToTargetSpeed
}

; ==============================================================================
