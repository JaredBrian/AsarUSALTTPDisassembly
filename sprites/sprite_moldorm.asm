; ==============================================================================

; Doesn't use $0DC0, so it's oddball in that regard.
!animation_index   = $0E80
    
; NOTE: Rotarity is a term I've created for direction of spin, like
; clockwise vs. counterclockwise. It's a general term that doesn't indicate
; either of these, but rather it as a property.
!rotarity          = $0EB0
    
; Most of the time the sprite picks a random rotarity and timer, but
; every 7th time it will enter a state where it targets the player and
; tries to move toward them.
!seek_delay_counter = $0ED0
    
; ==============================================================================

; $0317D8-$031807 DATA
Pool_Sprite_Moldorm:
{
    ; $0317D8
    .x_speeds
    db  24,  22,  17,   9,   0,  -9, -17, -22
    db -24, -22, -17,  -9,   0,   9,  17,  22
    
    ; $0317E8
    .y_speeds
    db   0,   9,  17,  22,  24,  22,  17,   9
    db   0,  -9, -17, -22, -24, -22, -17,  -9
    
    ; $0317F8
    .next_directions
    db  8,  9, 10, 11, 12, 13, 14, 15
    db  0,  1,  2,  3,  4,  5,  6,  7
}

; $031808-$03185F JUMP LOCATION
Sprite_Moldorm:
{
    JSL.l Moldorm_Draw
    JSR.w Sprite_CheckIfActive
    
    LDA.w $0EA0, X : BEQ .not_recoiling
        JSR.w SpritePrep_Moldorm
    
    .not_recoiling
    
    JSR.w Sprite_CheckIfRecoiling
    JSR.w Sprite_CheckDamage
    
    INC.w !animation_index, X
    
    LDY.w $0DE0, X
    
    LDA.w Pool_Sprite_Moldorm_x_speeds, Y : STA.w $0D50, X
    
    LDA.w Pool_Sprite_Moldorm_y_speeds, Y : STA.w $0D40, X
    
    JSR.w Sprite_Move
    JSR.w Sprite_CheckTileCollision
    
    LDA.w $0E70, X : BEQ .no_tile_collision
        JSL.l GetRandomInt : LSR : BCC .anotoggle_rotarity
            LDA.w !rotarity, X : EOR.b #$FF : INC : STA.w !rotarity, X
        
        .anotoggle_rotarity
        
        LDY.w $0DE0, X
        
        LDA.w Pool_Sprite_Moldorm_next_directions, Y : STA.w $0DE0, X
    
    .no_tile_collision
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Moldorm_ConfigureNextState ; 0x00 - $9860
    dw Moldorm_Meander            ; 0x01 - $988D
    dw Moldorm_SeekPlayer         ; 0x02 - $98B2
}

; ==============================================================================

; $031860-$03188C JUMP LOCATION
Moldorm_ConfigureNextState:
{
    LDA.w $0DF0, X : BNE .delay
        INC
        
        INC.w !seek_delay_counter, X
        
        LDY.w !seek_delay_counter, X : CPY.b #$06 : BNE .anoseek_player
            STZ.w !seek_delay_counter, X
            
            INC
        
        .anoseek_player
        
        STA.w $0D80, X
        
        JSL.l GetRandomInt : AND.b #$02 : DEC : STA.w !rotarity, X
        
        JSL.l GetRandomInt : AND.b #$1F : ADC.b #$20 : STA.w $0DF0, X
        
    .delay
    
    RTS
}

; ==============================================================================

; $03188D-$0318B1 JUMP LOCATION
Moldorm_Meander:
{
    LDA.w $0DF0, X : BNE .delay
        JSL.l GetRandomInt : AND.b #$0F : ADC.b #$08 : STA.w $0DF0, X
        
        STZ.w $0D80, X
        
        RTS
        
    .delay
    
    AND.b #$03 : BNE .anostep_angle
        LDA.w $0DE0, X : CLC : ADC.w !rotarity, X : AND.b #$0F : STA.w $0DE0, X
    
    .anostep_angle
    
    RTS
}

; ==============================================================================

; $0318B2-$0318DF JUMP LOCATION
Moldorm_SeekPlayer:
{
    TXA : EOR.b $1A : AND.b #$03 : BNE .delay
        LDA.b #$1F
        JSR.w Sprite_ApplySpeedTowardsPlayer
        
        JSL.l Sprite_ConvertVelocityToAngle
        
        CMP.w $0DE0, X : BNE .not_at_target_angle
            ; Revert back to the base ai state to select another rotarity and
            ; timer.
            STZ.w $0D80, X
            
            LDA.b #$30 : STA.w $0DF0, X
            
            RTS
            
        .not_at_target_angle
        
        PHP : LDA.w $0DE0, X : PLP : BMI .target_angle_lesser
            INC : INC
        
        .target_angle_lesser
        
        DEC : AND.b #$0F : STA.w $0DE0, X
    
    .delay
    
    RTS
}

; ==============================================================================
