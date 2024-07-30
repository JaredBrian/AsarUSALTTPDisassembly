
; ==============================================================================

; $0F39A9-$0F39BF JUMP LOCATION
Sprite_Gibdo:
{
    JSR Gibdo_Draw
    JSR Sprite3_CheckIfActive
    JSR Sprite3_CheckIfRecoiling
    JSR Sprite3_CheckDamage
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Gibdo_ApproachTargetDirection
    dw Gibdo_CanMove
}

; ==============================================================================

; $0F39C0-$0F39CB DATA
Pool_Gibdo_ApproachTargetDirection:
{
    .target_direction length 8
    db $02, $06, $04, $00
    
    .animation_states
    db $04, $08, $0B, $0A, $00, $06, $03, $07
}

; ==============================================================================

; $0F39CC-$0F39FF JUMP LOCATION
Gibdo_ApproachTargetDirection:
{
    LDY.w $0DE0, X
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    LDA.b $1A : AND.b #$07 : BNE .delay
    
    LDY.w $0D90, X
    
    LDA.w $0DE0, X : CMP .target_direction, Y
    
    BEQ .reset_timer
    BPL .rotate_towards_target_direction
    
    INC.w $0DE0, X
    
    BRA .return
    
    .rotate_towards_target_direction
    
    DEC.w $0DE0, X
    
    .delay
    .return
    
    RTS
    
    .reset_timer
    
    JSL GetRandomInt : AND.b #$1F : ADC.b #$30 : STA.w $0DF0, X
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $0F3A00-$0F3A11 DATA
Pool_Gibdo_CanMove:
{
    .y_speeds length 8
    db -16,   0
    
    .x_speeds
    db   0,   0,  16,   0,   0,   0, -16,   0
    
    .animation_states
    db 9, 2, 0, 4, 11, 3, 1, 5
}

; ==============================================================================

; $0F3A12-$0F3A5F JUMP LOCATION
Gibdo_CanMove:
{
    LDY.w $0DE0, X
    
    ; Note that half of these states will have a speed of zero, or that the
    ; sprite is standing still. Gibdos are kind of weird in that regard.
    LDA .x_speeds, Y : STA.w $0D50, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    JSR Sprite3_Move
    JSR Sprite3_CheckTileCollision
    
    LDA.w $0DF0, X : BEQ .timer_expired_so_face_player
    
    LDA.w $0E70, X : BEQ .no_tile_collision
    
    .timer_expired_so_face_player
    
    JSR Sprite3_DirectionToFacePlayer
    
    TYA : CMP.w $0D90, X : BEQ .already_facing_player
    
    ; Need to go back to the seeking state to rotate to the direction
    ; that is towards the player.
    STA.w $0D90, X
    
    STZ.w $0D80, X
    
    RTS
    
    .no_tile_collision
    .already_facing_player
    
    DEC.w $0DA0, X : BPL .dont_tick_animation_timer
    
    LDA.b #$0E : STA.w $0DA0, X
    
    INC.w $0E80, X
    
    .dont_tick_animation_timer
    
    LDA.w $0E80, X : ASL #2 : AND.b #$04 : ORA.w $0D90, X : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F3A60-$0F3B1F DATA
Pool_Gibdo_Draw:
{
    .oam_groups
    dw 0, -9 : db $80, $00, $00, $02
    dw 0,  0 : db $8A, $00, $00, $02
    
    dw 0, -8 : db $80, $00, $00, $02
    dw 0,  1 : db $8A, $40, $00, $02
    
    dw 0, -9 : db $82, $00, $00, $02
    dw 0,  0 : db $8C, $00, $00, $02
    
    dw 0, -8 : db $82, $00, $00, $02
    dw 0,  0 : db $8E, $00, $00, $02
    
    dw 0, -9 : db $84, $00, $00, $02
    dw 0,  0 : db $A0, $00, $00, $02
    
    dw 0, -8 : db $84, $00, $00, $02
    dw 0,  1 : db $A0, $40, $00, $02
    
    dw 0, -9 : db $86, $00, $00, $02
    dw 0,  0 : db $A2, $00, $00, $02
    
    dw 0, -9 : db $88, $00, $00, $02
    dw 0,  0 : db $A4, $00, $00, $02
    
    dw 0, -9 : db $88, $40, $00, $02
    dw 0,  0 : db $A4, $40, $00, $02
    
    dw 0, -9 : db $82, $40, $00, $02
    dw 0,  0 : db $8C, $40, $00, $02
    
    dw 0, -9 : db $86, $40, $00, $02
    dw 0,  0 : db $A2, $40, $00, $02
    
    dw 0, -8 : db $82, $40, $00, $02
    dw 0,  1 : db $8E, $40, $00, $02
}
; ==============================================================================

; $0F3B20-$0F3B41 LOCAL JUMP LOCATION
Gibdo_Draw:
{
    LDA.b #$00   : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #4 : ADC.w .oam_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JSR Sprite3_DrawMultiple
    
    LDA.w $0F00, X : BNE .no_shadow
    
    JSL Sprite_DrawShadowLong
    
    .no_shadow
    
    RTS
}

; ==============================================================================
