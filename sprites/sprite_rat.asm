
; ==============================================================================

; $02A880-$02A8AF DATA
Pool_Sprite_Rat:
{
    .animation_states
    db $00, $00, $03, $03, $01, $02, $04, $04
    db $01, $02, $04, $05, $00, $00, $03, $03
    
    .vh_flip
    db $00, $40, $00, $40, $00, $00, $00, $00
    db $40, $40, $40, $40, $80, $C0, $80, $C0
    
    .stationary_states
    db $0A, $0B, $06, $07, $02, $03, $0E, $0F
    
    .moving_states
    db $08, $09, $04, $05, $00, $01, $0C, $0D
}

; ==============================================================================

; $02A8B0-$02A90A JUMP LOCATION
Sprite_Rat:
{
    LDY.w $0D90, X
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$3F : ORA .vh_flip, Y : STA.w $0F50, X
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite2_CheckIfActive
    JSR Sprite2_CheckIfRecoiling
    JSR Sprite2_CheckDamage
    JSR Sprite2_Move
    JSR Sprite2_CheckTileCollision
    
    LDA.w $0D80, X : BNE Rat_Moving
    
    JSR Sprite2_ZeroVelocity
    
    LDA.w $0DF0, X : BNE .no_new_direction
    
    ; Select a new direction and change to the moving state.
    
    JSL GetRandomInt : PHA : AND.b #$03 : STA.w $0DE0, X
    
    INC.w $0D80, X
    
    PLA : AND.b #$7F : ADC.b #$40 : STA.w $0DF0, X
    
    .no_new_direction
    
    LDA.b $1A : LSR #4 : LDA.w $0DE0, X : ROL A : TAY
    
    LDA .stationary_states, Y : STA.w $0D90, X
    
    RTS
}

; ==============================================================================

; $02A90B-$02A916 DATA
Pool_Rat_Moving:
{
    .x_speeds
    db  24, -24,   0,   0
    
    .y_speeds
    db   0,   0,  24, -24
    
    .next_direction
    db 2, 3, 0, 1
}

; ==============================================================================

; $02A917-$02A95A BRANCH LOCATION
Rat_Moving:
{
    LDA.w $0DF0, X : BNE .sound_wait
    
    LDA.w $0FFF : BNE .in_dark_world
    
    LDA.b #$17 : JSL Sound_SetSfx3PanLong
    
    .in_dark_world
    
    STZ.w $0D80, X
    
    LDA.b #$50 : STA.w $0DF0, X
    
    .sound_wait
    
    LDY.w $0DE0, X
    
    LDA.w $0E70, X : BEQ .no_wall_collision
    
    LDA .next_direction, Y : STA.w $0DE0, X : TAY
    
    .no_wall_collision
    
    LDA .x_speeds, Y : STA.w $0D50, X
    LDA .y_speeds, Y : STA.w $0D40, X
    
    LDA.b $1A : LSR #3 : LDA.w $0DE0, X : ROL A : TAY
    
    LDA Sprite_Rat.moving_states, Y : STA.w $0D90, X
    
    RTS
}

; ==============================================================================
