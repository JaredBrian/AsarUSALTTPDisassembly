
; ==============================================================================

; $0F0DD2-$0F0DE6 JUMP LOCATION
Sprite_Bomber:
{
    LDA.b #$30 : STA.w $0B89, X
    
    LDA.w $0D90, X : BEQ Bomber_Main
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw BomberPellet_Falling
    dw BomberPellet_Exploding
}

; ==============================================================================

; $0F0DE7-$0F0E13 JUMP LOCATION
BomberPellet_Falling:
{
    JSL Sprite_PrepAndDrawSingleSmallLong
    JSR Sprite3_CheckIfActive
    JSR Sprite3_Move
    JSR Sprite3_MoveAltitude
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .aloft
    
    STZ.w $0F70, X
    
    INC.w $0D80, X
    
    LDA.b #$13 : STA.w $0DF0, X
    
    INC.w $0E40, X
    
    LDA.b #$0C : JSL Sound_SetSfx2PanLong
    
    .aloft
    
    RTS
}

; ==============================================================================

; $0F0E14-$0F0E28 JUMP LOCATION
BomberPellet_Exploding:
{
    JSL BomberPellet_DrawExplosion
    JSR Sprite3_CheckIfActive
    
    LDA $1A : AND.b #$03 : BNE .dont_rewind_timer
    
    INC.w $0DF0, X
    
    .dont_rewind_timer
    
    JSL Sprite_CheckDamageToPlayerLong
    
    RTS
}

; ==============================================================================

; $0F0E29-$0F0E30 DATA
Pool_Bomber_Main:
{
    .z_speed_step
    db $01, $FF
    
    .z_speed_limit
    db $08, $F8
    
    .animation_states
    db $09, $0A, $08, $07
}

; ==============================================================================

; $0F0E31-$0F0ED1 BRANCH LOCATION
Bomber_Main:
{
    LDA.w $0E00, X : BEQ .direction_lock_inactive
    
    LDY.w $0DE0, X
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    .direction_lock_inactive
    
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSL Bomber_Draw
    JSR Sprite3_CheckIfActive
    JSR Sprite3_CheckIfRecoiling
    
    LDA.w $0E00, X : CMP.b #$08 : BNE .direction_lock_active
    
    JSR Bomber_SpawnPellet
    
    .direction_lock_active
    
    JSR Sprite3_CheckDamage
    
    LDA $1A : AND.b #$01 : BNE .delay
    
    LDA.w $0ED0, X : AND.b #$01 : TAY
    
    LDA.w $0F80, X : CLC : ADC .z_speed_step, Y : STA.w $0F80, X
    
    CMP .z_speed_limit, Y : BNE .not_at_speed_limit
    
    ; invert polarity of motion in the z axis. (gives an undulation effect.)
    INC.w $0ED0, X
    
    .not_at_speed_limit
    .delay
    
    JSR Sprite3_MoveAltitude
    JSR Sprite3_DirectionToFacePlayer
    
    LDA $0E : CLC : ADC.b #$28 : CMP.b #$50 : BCS .player_not_close
    
    LDA $0F : CLC : ADC.b #$28 : CMP.b #$50 : BCS .player_not_close
    
    LDA $44 : CMP.b #$80 : BEQ .player_not_attacking
    
    LDA.w $0372 : BNE .dodge_player_attack
    
    LDA $3C : CMP.b #$09 : BPL .player_not_attacking
    
    .dodge_player_attack
    
    LDA.b #$30 : JSL Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA $01 : EOR.b #$FF : INC A : STA.w $0D50, X
    
    LDA $00 : EOR.b #$FF : INC A : STA.w $0D40, X
    
    LDA.b #$08 : STA.w $0DF0, X
    
    LDA.b #$02 : STA.w $0D80, X
    
    .player_not_attacking
    .player_not_close
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
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
    
    JSR Bomber_MoveAndAnimate
    
    RTS
}

; ==============================================================================

; $0F0EE4-$0F0EF7 DATA
Pool_Bomber_Hovering:
{
    .x_speeds
    db $10, $0C
    db $00, $F4
    db $F0, $F4
    db $00, $0C
    
    .y_speeds
    db $00, $0C
    db $10, $0C
    db $00, $F4
    db $F0, $F4
    
    .approach_indices
    db $00, $04, $02, $06
}

; ==============================================================================

; $0F0EF8-$0F0F70 JUMP LOCATION
Bomber_Hovering:
{
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    INC.w $0DA0, X : LDA.w $0DA0, X : CMP.b #$03 : BNE .choose_random_direction
    
    STZ.w $0DA0, X
    
    LDA.b #$30 : STA.w $0DF0, X
    
    JSR Sprite3_DirectionToFacePlayer
    
    ; \task Decide whether this is really approaching the player or just
    ; flanking... confusing the player?
    LDA .approach_indices, Y
    
    BRA .approach_player
    
    .choose_random_direction
    
    JSL GetRandomInt : AND.b #$1F : ORA.b #$20 : STA.w $0DF0, X : AND.b #$07
    
    .approach_player
    
    TAY
    
    LDA .x_speeds, Y : STA.w $0D50, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    .delay
    
    BRA .just_face_and_animate
    
    ; $0F0F36 ALTERNATE ENTRY POINT
    shared Bomber_Moving:
    
    LDA.w $0DF0, X : BNE .delay_2
    
    STZ.w $0D80, X
    
    LDA.b #$0A : STA.w $0DF0, X
    
    LDY.w $0E20, X : CPY.b #$A8 : BNE .cant_spawn_pellet
    
    ; Only the green bombers can do that, apparently.
    LDA.b #$10 : STA.w $0E00, X
    
    .cant_spawn_pellet
    
    RTS
    
    .delay_2
    
    ; $0F0F50 ALTERNATE ENTRY POINT
    shared Bomber_MoveAndAnimate:
    
    JSR Sprite3_Move
    
    .just_face_and_animate
    
    JSR Sprite3_DirectionToFacePlayer : TYA : STA.w $0DE0, X
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR #3 : AND.b #$01 : STA $00
    
    LDA.w $0DE0, X : ASL A : ORA $00 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F0F71-$0F0F80 DATA
Pool_Bomber_SpawnPellet:
{
    .x_offsets_low
    db $0E, $FA, $04, $04
    
    .x_offsets_high
    db $00, $FF, $00, $00
    
    .y_offsets_low
    db $07, $07, $0C, $FC
    
    .y_offsets_high
    db $00, $00, $00, $FF
}

; ==============================================================================

; $0F0F81-$0F0FDE LOCAL JUMP LOCATION
Bomber_SpawnPellet:
{
    LDA.b #$A8 : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA.b #$20 : JSL Sound_SetSfx2PanLong
    
    LDA $04 : STA.w $0F70, Y
    
    PHX
    
    LDX.w $0DE0, Y
    
    LDA $00 : CLC : ADC .x_offsets_low, X  : STA.w $0D10, Y
    LDA $01 : ADC .x_offsets_high, X : STA.w $0D30, Y
    
    LDA $02 : CLC : ADC .y_offsets_low, X  : STA.w $0D00, Y
    LDA $03 : ADC .y_offsets_hiwh, X : STA.w $0D20, Y
    
    LDA Sprite3_Shake.x_speeds, X : STA.w $0D50, Y
    
    LDA Sprite3_Shake.y_speeds, X : STA.w $0D40, Y
    
    PLX
    
    LDA.b #$01 : STA.w $0D90, Y : STA.w $0BA0, Y
    
    LDA.b #$09 : STA.w $0F60, Y
    
    LDA.b #$33 : STA.w $0E60, Y
    
    AND.b #$0F : STA.w $0F50, Y

    .spawn-failed

    RTS
}

; ==============================================================================

