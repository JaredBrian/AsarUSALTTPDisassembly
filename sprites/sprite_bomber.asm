
; ==============================================================================

; $0F0DD2-$0F0DE6 JUMP LOCATION
Sprite_Bomber:
{
    LDA.b #$30 : STA.w $0B89, X
    
    LDA.w $0D90, X : BEQ Bomber_Main
        LDA.w $0D80, X
        
        JSL.l UseImplicitRegIndexedLocalJumpTable
        
        dw BomberPellet_Falling
        dw BomberPellet_Exploding
}

; ==============================================================================

; $0F0DE7-$0F0E13 JUMP LOCATION
BomberPellet_Falling:
{
    JSL.l Sprite_PrepAndDrawSingleSmallLong
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_Move
    JSR.w Sprite3_MoveAltitude
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .aloft
        STZ.w $0F70, X
        
        INC.w $0D80, X
        
        LDA.b #$13 : STA.w $0DF0, X
        
        INC.w $0E40, X
        
        LDA.b #$0C : JSL.l Sound_SetSfx2PanLong
    
    .aloft
    
    RTS
}

; ==============================================================================

; $0F0E14-$0F0E28 JUMP LOCATION
BomberPellet_Exploding:
{
    JSL.l BomberPellet_DrawExplosion
    JSR.w Sprite3_CheckIfActive
    
    LDA.b $1A : AND.b #$03 : BNE .dont_rewind_timer
        INC.w $0DF0, X
    
    .dont_rewind_timer
    
    JSL.l Sprite_CheckDamageToPlayerLong
    
    RTS
}

; ==============================================================================

; $0F0E29-$0F0E30 DATA
Pool_Bomber_Main:
{
    ; $0F0E29
    .z_speed_step
    db $01, $FF
    
    ; $0F0E2B
    .z_speed_limit
    db $08, $F8
    
    ; $0F0E2D
    .animation_states
    db $09, $0A, $08, $07
}

; $0F0E31-$0F0ED1 BRANCH LOCATION
Bomber_Main:
{
    LDA.w $0E00, X : BEQ .direction_lock_inactive
        LDY.w $0DE0, X
        
        LDA Pool_Bomber_Mainanimation_states, Y : STA.w $0DC0, X
    
    .direction_lock_inactive
    
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSL.l Bomber_Draw
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckIfRecoiling
    
    LDA.w $0E00, X : CMP.b #$08 : BNE .direction_lock_active
        JSR.w Bomber_SpawnPellet
    
    .direction_lock_active
    
    JSR.w Sprite3_CheckDamage
    
    LDA.b $1A : AND.b #$01 : BNE .delay
        LDA.w $0ED0, X : AND.b #$01 : TAY
        
        LDA.w $0F80, X : CLC : ADC Pool_Bomber_Main_z_speed_step, Y : STA.w $0F80, X
        
        CMP Pool_Bomber_Mainz_speed_limit, Y : BNE .not_at_speed_limit
            ; Invert polarity of motion in the z axis. (gives an undulation
            ; effect.)
            INC.w $0ED0, X
        
        .not_at_speed_limit
    .delay
    
    JSR.w Sprite3_MoveAltitude
    JSR.w Sprite3_DirectionToFacePlayer
    
    LDA.b $0E : CLC : ADC.b #$28 : CMP.b #$50 : BCS .player_not_close
        LDA.b $0F : CLC : ADC.b #$28 : CMP.b #$50 : BCS .player_not_close
            LDA.b $44 : CMP.b #$80 : BEQ .player_not_attacking
                LDA.w $0372 : BNE .dodge_player_attack
                    LDA.b $3C : CMP.b #$09 : BPL .player_not_attacking
                
                .dodge_player_attack
                
                LDA.b #$30 : JSL.l Sprite_ProjectSpeedTowardsPlayerLong
                
                LDA.b $01 : EOR.b #$FF : INC A : STA.w $0D50, X
                
                LDA.b $00 : EOR.b #$FF : INC A : STA.w $0D40, X
                
                LDA.b #$08 : STA.w $0DF0, X
                
                LDA.b #$02 : STA.w $0D80, X
            
            .player_not_attacking
    .player_not_close
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Bomber_Hovering
    dw Bomber_Moving
    dw Bomber_Dodge
}

; ==============================================================================

; $0F0ED2-$0F0EE3 JUMP LOCATION
Bomber_Dodge:
{
    LDA.w $0DF0, X : BNE .delay
        STZ.w $0D80, X
    
    .delay
    
    INC.w $0E80, X : INC.w $0E80, X
    
    JSR.w Bomber_MoveAndAnimate
    
    RTS
}

; ==============================================================================

; $0F0EE4-$0F0EF7 DATA
Pool_Bomber_Hovering:
{
    ; $0F0EE4
    .x_speeds
    db $10, $0C
    db $00, $F4
    db $F0, $F4
    db $00, $0C
    
    ; $0F0EEC
    .y_speeds
    db $00, $0C
    db $10, $0C
    db $00, $F4
    db $F0, $F4
    
    ; $0F0EF4
    .approach_indices
    db $00, $04, $02, $06
}

; $0F0EF8-$0F0F35 JUMP LOCATION
Bomber_Hovering:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        INC.w $0DA0, X
        LDA.w $0DA0, X : CMP.b #$03 : BNE .choose_random_direction
            STZ.w $0DA0, X
            
            LDA.b #$30 : STA.w $0DF0, X
            
            JSR.w Sprite3_DirectionToFacePlayer
            
            ; TODO: Decide whether this is really approaching the player or just
            ; flanking... confusing the player?
            LDA Pool_Bomber_Hovering_approach_indices, Y
            
            BRA .approach_player
        
        .choose_random_direction
        
        JSL.l GetRandomInt : AND.b #$1F : ORA.b #$20 : STA.w $0DF0, X : AND.b #$07
        
        .approach_player
        
        TAY
        
        LDA Pool_Bomber_Hovering_x_speeds, Y : STA.w $0D50, X
        
        LDA Pool_Bomber_Hovering_y_speeds, Y : STA.w $0D40, X
    
    .delay
    
    BRA Bomber_MoveAndAnimate_just_face_and_animate
}

; $0F0F36-$0F0F70 JUMP LOCATION
Bomber_Moving:
{
    LDA.w $0DF0, X : BNE Bomber_MoveAndAnimate
        STZ.w $0D80, X
        
        LDA.b #$0A : STA.w $0DF0, X
        
        LDY.w $0E20, X : CPY.b #$A8 : BNE .cant_spawn_pellet
        
        ; Only the green bombers can do that, apparently.
        LDA.b #$10 : STA.w $0E00, X
        
        .cant_spawn_pellet
        
        RTS
}
    
; $0F0F50-$0F0F70 JUMP LOCATION
Bomber_MoveAndAnimate:
{
    JSR.w Sprite3_Move
    
    ; $0F0F53 ALTERNATE ENTRY POINT
    .just_face_and_animate
    
    JSR.w Sprite3_DirectionToFacePlayer : TYA : STA.w $0DE0, X
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR #3 : AND.b #$01 : STA.b $00
    
    LDA.w $0DE0, X : ASL A : ORA.b $00 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F0F71-$0F0F80 DATA
Pool_Bomber_SpawnPellet:
{
    ; $0F0F71
    .x_offsets_low
    db $0E, $FA, $04, $04
    
    ; $0F0F75
    .x_offsets_high
    db $00, $FF, $00, $00
    
    ; $0F0F79
    .y_offsets_low
    db $07, $07, $0C, $FC
    
    ; $0F0F7D
    .y_offsets_high
    db $00, $00, $00, $FF
}

; $0F0F81-$0F0FDE LOCAL JUMP LOCATION
Bomber_SpawnPellet:
{
    LDA.b #$A8 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.b #$20 : JSL.l Sound_SetSfx2PanLong
        
        LDA.b $04 : STA.w $0F70, Y
        
        PHX
        
        LDX.w $0DE0, Y
        
        LDA.b $00
        CLC : ADC Pool_Bomber_SpawnPellet_x_offsets_low, X  : STA.w $0D10, Y

        LDA.b $01
              ADC Pool_Bomber_SpawnPellet_x_offsets_high, X : STA.w $0D30, Y
        
        LDA.b $02
        CLC : ADC Pool_Bomber_SpawnPellet_y_offsets_low, X  : STA.w $0D00, Y

        LDA.b $03
              ADC Pool_Bomber_SpawnPellet_y_offsets_hiwh, X : STA.w $0D20, Y
        
        LDA Sprite3_Shake_x_speeds, X : STA.w $0D50, Y
        
        LDA Sprite3_Shake_y_speeds, X : STA.w $0D40, Y
        
        PLX
        
        LDA.b #$01 : STA.w $0D90, Y : STA.w $0BA0, Y
        
        LDA.b #$09 : STA.w $0F60, Y
        
        LDA.b #$33 : STA.w $0E60, Y
        
        AND.b #$0F : STA.w $0F50, Y

    .spawn_failed

    RTS
}

; ==============================================================================
