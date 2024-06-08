
; ==============================================================================

; $0F5A42-$0F5B43 JUMP LOCATION
Sprite_EnergyBall:
{
    LDA.w $0DA0, X : BEQ .repulsable_energy_ball ; --
    
    LDA.w $0DF0, X : BEQ .stop_tracking_player
    
    LDA.b #$20 : JSL Sprite_ApplySpeedTowardsPlayerLong
    
    .stop_tracking_player
    
    LDA.b #$05
    
    BRA .set_palette
    
    .repulsable_energy_ball
    
    LDA $1A : LSR A : AND.b #$02 : INC #2 : ORA.b #$01
    
    .set_palette
    
    STA.w $0F50, X
    
    LDA.w $0D80, X : BEQ .BRANCH_DELTA ; --
    
    JMP EnergyBall_DrawTrail
    
    .BRANCH_DELTA
    
    LDA.w $0DA0, X : BEQ .not_seeker_2 ; --
    
    JSR SeekerEnergyBall_Draw
    
    BRA .BRANCH_ZETA
    
    .not_seeker_2
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    .BRANCH_ZETA
    
    JSR Sprite3_CheckIfActive
    
    INC.w $0E80, X
    
    JSR Sprite3_Move
    
    JSR Sprite3_CheckTileCollision : BEQ .no_tile_collision ; --
    
    STZ.w $0DD0, X
    
    LDA.w $0DA0, X : BNE .is_seeker
    
    .no_tile_collision
    
    LDA.w $0D90, X : BEQ .BRANCH_KAPPA  ; --
    
    LDA.w $0BA0 : BNE .BRANCH_KAPPA
    
    LDA.w $0D10, X : STA $00
    LDA.w $0D30, X : STA $08
    
    LDA.b #$0F : STA $02 : STA $03
    
    LDA.w $0D00, X : STA $01
    LDA.w $0D20, X : STA $09
    
    PHX
    
    LDX.b #$00
    
    JSL Sprite_SetupHitBoxLong
    
    PLX
    
    JSL Utility_CheckIfHitBoxesOverlapLong : BCC .didnt_hit_agahnim
    
    PHX
    
    LDA.b #$A0 : STA $00

    LDA.b #$10
    LDX.b #$00
    
    JSL.l $06EDC5 ; $036DC5 IN ROM
    
    PLX
    
    STZ.w $0DD0, X
    
    LDA.w $0D50, X : STA.w $0F40
    
    LDA.w $0D40, X : STA.w $0F30
    
    .didnt_hit_agahnim
    
    BRA .no_player_damage
    
    .BRANCH_KAPPA
    
    JSR Sprite3_CheckDamageToPlayer
    
    JSL Sprite_CheckDamageFromPlayerLong : BCC .no_player_damage ; --
    
    LDA.w $0DA0, X : BEQ .not_seeker_3
    
    STZ.w $0DD0, X
    
    .is_seeker
    
    LDA.b #$36 : JSL Sound_SetSfx3PanLong
    
    JSR SeekerEnergyBall_SplitIntoSixSmaller
    
    RTS
    
    .not_seeker_3
    
    LDA.b #$05 : JSL Sound_SetSfx2PanLong
    
    LDA.b #$29 : JSL Sound_SetSfx3PanLong
    
    LDA.b #$30 : JSL Sprite_ApplySpeedTowardsPlayerLong
    
    ; Because the sword hits it, invert the speed and make it faster,
    ; hopefully sending it into Agahnim's dumb face.
    LDA $01 : EOR.b #$FF : INC A : STA.w $0D50, X
    
    LDA $00 : EOR.b #$FF : INC A : STA.w $0D40, X
    
    INC.w $0D90, X
    
    .no_player_damage
    
    TXA : EOR $1A : AND.b #$03 : ORA.w $0DA0, X : BNE .BRANCH_NU ; --
    
    LDA.b #$7B : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$0F : STA.w $0DF0, Y
                 STA.w $0D80, Y
    
    LDA.w $0DA0, X : STA.w $0DA0, Y
    
    .spawn_failed
    .BRANCH_NU
    
    RTS
}

; ==============================================================================

; $0F5B44-$0F5B53 DATA
Pool_EnergyBall_DrawTrail:
{
    .animation_states
    db 2, 2, 2, 2, 2, 2, 2, 1
    db 1, 1, 1, 1, 0, 0, 0, 0
}

; ==============================================================================

; $0F5B54-$0F5B89 LOCAL JUMP LOCATION
EnergyBall_DrawTrail:
{
    LDA.w $0DC0, X : CMP.b #$02 : BEQ .is_small
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    BRA .moving_on
    
    .is_small
    
    JSL Sprite_PrepAndDrawSingleSmallLong
    
    .moving_on
    
    JSR Sprite3_CheckIfActive
    
    LDA.w $0DF0, X : STA.w $0BA0, X : BNE .ano_self_terminate
    
    STZ.w $0DD0, X
    
    .ano_self_terminate
    
    TAY : CMP.b #$06 : BNE .dont_move
    
    ; \task Figure out what the hell is going on here. Is this
    ; a quick and dirty way to get the trail off screen?
    LDA.b #$40 : STA.w $0D50, X
                 STA.w $0D40, X
    
    JSR Sprite3_Move
    
    .dont_move
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F5B8A-$0F5B95 DATA
Pool_SeekerEnergyBall_SplitIntoSixSmaller:
{
    .x_speeds
    db   0,  24,  24,   0, -24, -24
    
    .y_speeds
    db -32, -16,  16,  32,  16, -16
}

; ==============================================================================

; $0F5B96-$0F5BFD LOCAL JUMP LOCATION
SeekerEnergyBall_SplitIntoSixSmaller:
{
    LDA.b #$36 : JSL Sound_SetSfx3PanLong
    
    LDA.b #$05 : STA.w $0FB5
    
    .spawn_next
    
    JSR .spawn_smaller
    
    DEC.w $0FB5 : BNE .spawn_next
    
    .spawn_smaller
    
    LDA.b #$55 : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
    LDA $01 : ADC.b #$00 : STA.w $0D30, Y
    
    LDA $02 : CLC : ADC.b #$04 : STA.w $0D00, Y
    LDA $03 : ADC.b #$00 : STA.w $0D20, Y
    
    LDA.w $0E60, Y : AND.b #$FE : ORA.b #$40 : STA.w $0E60, Y
    
    LDA.b #$04 : STA.w $0F50, Y : STA.w $0E00, Y
    
    LDA.b #$14 : STA.w $0F60, Y : STA.w $0DB0, Y : STA.w $0E90, Y
    
    PHX
    
    LDX.w $0FB5
    
    LDA .x_speeds, X : STA.w $0D50, Y
    
    LDA .y_speeds, X : STA.w $0D40, Y
    
    PLX
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0F5BFE-$0F5C3D DATA
Pool_SeekerEnergyBall_Draw:
{
    .oam_groups
    dw  4, -3 : db $CE, $00, $00, $00
    dw 11,  4 : db $CE, $00, $00, $00
    dw  4, 11 : db $CE, $00, $00, $00
    dw -3,  4 : db $CE, $00, $00, $00
    
    dw -1, -1 : db $CE, $00, $00, $00
    dw  9, -1 : db $CE, $00, $00, $00
    dw -1,  9 : db $CE, $00, $00, $00
    dw  9,  9 : db $CE, $00, $00, $00    
}

; ==============================================================================

; $0F5C3E-$0F5C5A LOCAL JUMP LOCATION
SeekerEnergyBall_Draw:
{
    LDA.b #$00   : XBA
    LDA.w $0E80, X : LSR #2 : AND.b #$01 : REP #$20 : ASL #5
    
    ADC.w #.oam_groups : STA $08
    
    SEP #$20
    
    LDA.b #$04 : JMP Sprite3_DrawMultiple
}

; ==============================================================================
