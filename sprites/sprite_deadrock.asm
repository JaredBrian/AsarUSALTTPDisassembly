
; ==============================================================================

; $031478-$031489 DATA
Pool_Sprite_DeadRock:
{
    ; $031478
    .animation_states
    db 0, 1, 0, 1, 2, 2, 3, 3
    db 4
    
    ; $031481
    .h_flip
    db $40, $40, $00, $00, $00, $40, $00, $40
    db $00
}

; Deadrock code (Sprite 0x27)
; $03148A-$0314FF JUMP LOCATION
Sprite_DeadRock:
{
    LDA.w $0E10, X : BEQ .petrification_inactive
        AND.b #$04 : BNE .use_normal_animation_state
            .use_petrified_animation_state
            
            LDY.b #$08
            
            BRA .write_animation_state
        
    .petrification_inactive
    
    LDA.w $0D80, X : CMP.b #$02 : BEQ .use_petrified_animation_state
    
    .use_normal_animation_state
    
    LDY.w $0D90, X
    
    .write_animation_state
    
    LDA Pool_Sprite_DeadRock_animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$BF : ORA Pool_Sprite_DeadRock_h_flip, Y
    STA.w $0F50, X
    
    JSR.w Sprite_PrepAndDrawSingleLarge
    JSR.w Sprite_CheckIfActive
    
    LDA.w $0EA0, X : BNE .anoplay_sfx
        JSR.w Sprite_CheckDamageFromPlayer : BCC .anoplay_sfx
            LDA.w $012E : BNE .anoplay_sfx

                LDA.b #$0B : JSL.l Sound_SetSfx2PanLong
    
    .anoplay_sfx
    
    JSR.w Sprite_CheckDamageToPlayer_same_layer : BCC .no_player_collision
        JSL.l Sprite_NullifyHookshotDrag
        JSL.l Sprite_RepelDashAttackLong
        
    .no_player_collision
    
    LDA.w $0EA0, X : CMP.b #$0E : BNE .dont_activate_petrification
        LDA.b #$02 : STA.w $0D80, X
        
        LDA.b #$FF : STA.w $0E00, X
        
        LDA.b #$40 : STA.w $0E10, X
    
    .dont_activate_petrification
    
    JSR.w Sprite_CheckIfRecoiling
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw DeadRock_PickDirection ; 0x00 - $9506
    dw DeadRock_Walk          ; 0x01 - $9559
    dw DeadRock_Petrified     ; 0x02 - $958F
}

; ==============================================================================

; $031500-$031505 DATA
DeadRockSpeed:
{
    ; $031500
    .X
    db $20, $E0 ; Bleeds into the next block
    
    ; $031502
    .Y
    db $00, $00, $20, $E0
}

; ==============================================================================

; $031506-$031547 JUMP LOCATION
DeadRock_PickDirection:
{
    LDA.w $0DF0, X : BNE DeadRock_SetDirectionAndSpeed_wait
        ASL.w $0E40, X : LSR.w $0E40, X
        
        LDA.w $0CAA, X : AND.b #$FB : STA.w $0CAA, X
        
        LDA.w $0E60, X : AND.b #$BF : STA.w $0E60, X
        
        INC.w $0D80, X
        
        JSL.l GetRandomInt : AND.b #$1F : ADC.b #$20 : STA.w $0DF0, X
        
        INC.w $0DA0, X : LDA.w $0DA0, X : CMP.b #$04 : BNE .use_random_direction
            STZ.w $0DA0, X
            
            JSR.w Sprite_DirectionToFacePlayer
            
            TYA
            
            BRA .set_velocity
        
        .use_random_direction
        
        JSL.l GetRandomInt : AND.b #$03
        
        .set_velocity

        ; Bleeds into the next function.
}
    
; $031548-$031558 JUMP LOCATION
DeadRock_SetDirectionAndSpeed:
{
    STA.w $0DE0, X : TAY
    
    LDA.w DeadRockSpeed_X, Y : STA.w $0D50, X
    LDA.w DeadRockSpeed_Y, Y : STA.w $0D40, X
    
    .wait
    
    RTS
}

; ==============================================================================

; $031559-$03158E JUMP LOCATION
DeadRock_Walk:
{
    LDA.w $0DF0, X : BNE .try_to_move
        STZ.w $0D80, X
        
        LDA.b #$20 : STA.w $0DF0, X
        
        RTS
        
    .try_to_move
    
    JSR.w Sprite_Move
    JSR.w Sprite_CheckTileCollision
    
    LDA.w $0E70, X : BEQ .no_wall_collision
        LDA.w $0DE0, X : EOR.b #$01
        
        BRA DeadRock_SetDirectionAndSpeed
    
    .no_wall_collision
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR #2 : AND.b #$01 : STA.b $00
    
    LDA.w $0DE0, X : ASL A : ORA.b $00 : STA.w $0D90, X
    
    RTS
}

; ==============================================================================

; $03158F-$0315C8 JUMP LOCATION
DeadRock_Petrified:
{
    LDA.w $0E40, X : ORA.b #$80 : STA.w $0E40, X
    
    LDA.w $0CAA, X : ORA.b #$04 : STA.w $0CAA, X
    
    LDA.w $0E60, X : ORA.b #$40 : STA.w $0E60, X
    
    LDA.b $1A : AND.b #$01 : BNE .skip
        LDA.w $0E00, X : BNE .dont_revert
            STZ.w $0D80, X
            
            LDA.b #$10 : STA.w $0DF0, X
            
            RTS
            
        .dont_revert
        
        CMP.b #$20 : BNE .gamma
            LDA.b #$40 : STA.w $0E10, X
        
        .gamma
        
        RTS
    
    .skip
    
    INC.w $0E00, X
    
    RTS
}

; ==============================================================================
