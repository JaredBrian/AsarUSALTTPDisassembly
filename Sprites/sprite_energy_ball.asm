; ==============================================================================

; $0F5A42-$0F5B43 JUMP LOCATION
Sprite_EnergyBall:
{
    LDA.w $0DA0, X : BEQ .repulsable_energy_ball
        LDA.w $0DF0, X : BEQ .stop_tracking_player
            LDA.b #$20
            JSL.l Sprite_ApplySpeedTowardsPlayerLong
        
        .stop_tracking_player
        
        LDA.b #$05
        
        BRA .set_palette
    
    .repulsable_energy_ball
    
    LDA.b $1A : LSR : AND.b #$02 : INC : INC : ORA.b #$01
    
    .set_palette
    
    STA.w $0F50, X
    
    LDA.w $0D80, X : BEQ .BRANCH_DELTA
        JMP EnergyBall_DrawTrail
    
    .BRANCH_DELTA
    
    LDA.w $0DA0, X : BEQ .not_seeker_2
        JSR.w SeekerEnergyBall_Draw
        
        BRA .BRANCH_ZETA
        
    .not_seeker_2
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    
    .BRANCH_ZETA
    
    JSR.w Sprite3_CheckIfActive
    
    INC.w $0E80, X
    
    JSR.w Sprite3_Move
    
    JSR.w Sprite3_CheckTileCollision : BEQ .no_tile_collision
        STZ.w $0DD0, X
        
        LDA.w $0DA0, X : BNE .is_seeker
        
    .no_tile_collision
    
    LDA.w $0D90, X : BEQ .BRANCH_KAPPA
        LDA.w $0BA0 : BNE .BRANCH_KAPPA
            LDA.w $0D10, X : STA.b $00
            LDA.w $0D30, X : STA.b $08
            
            LDA.b #$0F : STA.b $02 : STA.b $03
            
            LDA.w $0D00, X : STA.b $01
            LDA.w $0D20, X : STA.b $09
            
            PHX
            
            LDX.b #$00
            JSL.l Sprite_SetupHitBoxLong
            
            PLX
            
            JSL.l Utility_CheckIfHitBoxesOverlapLong : BCC .didnt_hit_agahnim
                PHX
                
                LDA.b #$A0 : STA.b $00

                LDA.b #$10
                LDX.b #$00
                JSL.l Sprite_ApplyCalculatedDamage_AgahnimBalls_DamageAgahnim
                
                PLX
                
                STZ.w $0DD0, X
                
                LDA.w $0D50, X : STA.w $0F40
                LDA.w $0D40, X : STA.w $0F30
            
            .didnt_hit_agahnim
            
            BRA .no_player_damage
    
    .BRANCH_KAPPA
    
    JSR.w Sprite3_CheckDamageToPlayer
    
    JSL.l Sprite_CheckDamageFromPlayerLong : BCC .no_player_damage
        LDA.w $0DA0, X : BEQ .not_seeker_3
            STZ.w $0DD0, X
        
            .is_seeker
            
            LDA.b #$36
            JSL.l Sound_SetSFX3PanLong
            
            JSR.w SeekerEnergyBall_SplitIntoSixSmaller
            
            RTS
            
        .not_seeker_3
        
        LDA.b #$05
        JSL.l Sound_SetSFX2PanLong
        
        LDA.b #$29
        JSL.l Sound_SetSFX3PanLong
        
        LDA.b #$30
        JSL.l Sprite_ApplySpeedTowardsPlayerLong
        
        ; Because the sword hits it, invert the speed and make it faster,
        ; hopefully sending it into Agahnim's dumb face.
        LDA.b $01 : EOR.b #$FF : INC : STA.w $0D50, X
        LDA.b $00 : EOR.b #$FF : INC : STA.w $0D40, X
        
        INC.w $0D90, X
    
    .no_player_damage
    
    TXA : EOR.b $1A : AND.b #$03 : ORA.w $0DA0, X : BNE .BRANCH_NU
        LDA.b #$7B
        JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            JSL.l Sprite_SetSpawnedCoords
            
            LDA.b #$0F : STA.w $0DF0, Y
                         STA.w $0D80, Y
            
            LDA.w $0DA0, X : STA.w $0DA0, Y
        
        .spawn_failed
    .BRANCH_NU
    
    RTS
}

; ==============================================================================

; $0F5B44-$0F5B53 DATA
EnergyBall_DrawTrail_animation_states:
{
    db 2, 2, 2, 2, 2, 2, 2, 1
    db 1, 1, 1, 1, 0, 0, 0, 0
}

; $0F5B54-$0F5B89 LOCAL JUMP LOCATION
EnergyBall_DrawTrail:
{
    LDA.w $0DC0, X : CMP.b #$02 : BEQ .is_small
        JSL.l Sprite_PrepAndDrawSingleLargeLong
        
        BRA .moving_on
    
    .is_small
    
    JSL.l Sprite_PrepAndDrawSingleSmallLong
    
    .moving_on
    
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0DF0, X : STA.w $0BA0, X
    BNE .ano_self_terminate
        STZ.w $0DD0, X
    
    .ano_self_terminate
    
    TAY : CMP.b #$06 : BNE .dont_move
        ; TODO: Figure out what is going on here. Is this
        ; a quick and dirty way to get the trail off screen?
        LDA.b #$40 : STA.w $0D50, X
                     STA.w $0D40, X
        
        JSR.w Sprite3_Move
        
    .dont_move
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F5B8A-$0F5B95 DATA
Pool_SeekerEnergyBall_SplitIntoSixSmaller:
{
    ; $0F5B8A
    .x_speeds
    db   0,  24,  24,   0, -24, -24
    
    ; $0F5B90
    .y_speeds
    db -32, -16,  16,  32,  16, -16
}

; $0F5B96-$0F5BFD LOCAL JUMP LOCATION
SeekerEnergyBall_SplitIntoSixSmaller:
{
    LDA.b #$36
    JSL.l Sound_SetSFX3PanLong
    
    LDA.b #$05 : STA.w $0FB5
    
    .spawn_next
    
        JSR.w .spawn_smaller
    DEC.w $0FB5 : BNE .spawn_next
    
    .spawn_smaller
    
    LDA.b #$55
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
        LDA.b $01 :       ADC.b #$00 : STA.w $0D30, Y
        
        LDA.b $02 : CLC : ADC.b #$04 : STA.w $0D00, Y
        LDA.b $03 :       ADC.b #$00 : STA.w $0D20, Y
        
        LDA.w $0E60, Y : AND.b #$FE : ORA.b #$40 : STA.w $0E60, Y
        
        LDA.b #$04 : STA.w $0F50, Y
                     STA.w $0E00, Y
        
        LDA.b #$14 : STA.w $0F60, Y
                     STA.w $0DB0, Y
                     STA.w $0E90, Y
        
        PHX
        
        LDX.w $0FB5
        LDA.w Pool_SeekerEnergyBall_SplitIntoSixSmaller_x_speeds, X : STA.w $0D50, Y
        LDA.w Pool_SeekerEnergyBall_SplitIntoSixSmaller_y_speeds, X : STA.w $0D40, Y
        
        PLX
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0F5BFE-$0F5C3D DATA
Pool_SeekerEnergyBall_Draw_OAM_groups:
{
    dw  4, -3 : db $CE, $00, $00, $00
    dw 11,  4 : db $CE, $00, $00, $00
    dw  4, 11 : db $CE, $00, $00, $00
    dw -3,  4 : db $CE, $00, $00, $00
    
    dw -1, -1 : db $CE, $00, $00, $00
    dw  9, -1 : db $CE, $00, $00, $00
    dw -1,  9 : db $CE, $00, $00, $00
    dw  9,  9 : db $CE, $00, $00, $00    
}

; $0F5C3E-$0F5C5A LOCAL JUMP LOCATION
SeekerEnergyBall_Draw:
{
    LDA.b #$00 : XBA
    LDA.w $0E80, X : LSR : LSR : AND.b #$01
    
    REP #$20
    
    ASL #5 : ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$04
    JMP Sprite3_DrawMultiple
}

; ==============================================================================
