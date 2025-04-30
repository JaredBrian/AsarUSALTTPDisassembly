; ==============================================================================

; $035DAF-$035DB6 DATA
Pool_Sprite_StalfosHead:
{
    ; $035DAF
    .h_flip
    db $00, $00, $00, $40
    
    ; $035DB3
    .animation_states
    db 0, 1, 2, 1
}

; $035DB7-$035E4C JUMP LOCATION
Sprite_StalfosHead:
{
    ; Force the sprite's layer to be that of the player's.
    ; NOTE: This is somewhat unusual.
    LDA.b $EE : STA.w $0F20, X
    
    LDA.w $0E00, X : BEQ .use_typical_OAM_region
        LDA.b #$08 : JSL.l OAM_AllocateFromRegionC
    
    .use_typical_OAM_region
    
    LDA.w $0E80, X : LSR #3 : AND.b #$03 : TAY
    
    LDA.w $0F50, X : AND.b #$BF : ORA Pool_Sprite_StalfosHead_h_flip, Y : STA.w $0F50, X
    
    LDA.w Pool_Sprite_StalfosHead_animation_states, Y : STA.w $0DC0, X
    
    LDA.b #$30 : STA.w $0B89, X
    
    JSR.w Sprite_PrepAndDrawSingleLarge
    JSR.w Sprite_CheckIfActive
    JSR.w Sprite_CheckIfRecoiling
    JSR.w Sprite_CheckDamage
    
    LDA.w $0EA0, X : BEQ .not_recoiling
        ; This sprite can't be recoiled by hitting it. That's part of why
        ; they're annoying.
        JSR.w Sprite_Zero_XY_Velocity
    
    .not_recoiling
    
    JSR.w Sprite_Move
    
    INC.w $0E80, X
    
    LDA.w $0DF0, X : BEQ .flee_from_player
        AND.b #$01 : BNE  .return
            LDA.b #$10 : JSR.w Sprite_ProjectSpeedTowardsPlayer
            
            .approach_target_speed
            
            LDA.w $0D40, X : CMP $00 : BEQ .at_target_x_speed
                BPL .above_target_x_speed
                    INC.w $0D40, X
                    
                    BRA .check_y_speed
                
                .above_target_x_speed
                
                DEC.w $0D40, X
                
            .at_target_x_speed
            .check_y_speed
            
            LDA.w $0D50, X : CMP $01 : BEQ  .return
                BPL .above_target_y_speed
                    INC.w $0D50, X
                    
                    BRA  .return
                
                .above_target_y_speed
                
                DEC.w $0D50, X
            
        .return
        
        RTS
    
    .flee_from_player
    
    TXA : EOR.b $1A : AND.b #$03 : BNE .return
        LDA.b #$10
        
        JSR.w Sprite_ProjectSpeedTowardsPlayer
        
        LDA.b $00 : EOR.b #$FF : INC A : STA.b $00
        LDA.b $01 : EOR.b #$FF : INC A : STA.b $01
        
        BRA .approach_target_speed
}

; ==============================================================================
