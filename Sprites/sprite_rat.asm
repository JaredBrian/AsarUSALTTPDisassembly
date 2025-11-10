; ==============================================================================

; $02A880-$02A8AF DATA
Pool_Sprite_Rat:
{
    ; $02A880
    .animation_states
    db $00, $00, $03, $03, $01, $02, $04, $04
    db $01, $02, $04, $05, $00, $00, $03, $03
    
    ; $02A890
    .vh_flip
    db $00, $40, $00, $40, $00, $00, $00, $00
    db $40, $40, $40, $40, $80, $C0, $80, $C0
    
    ; $02A8A0
    .stationary_states
    db $0A, $0B, $06, $07, $02, $03, $0E, $0F
    
    ; $02A8A8
    .moving_states
    db $08, $09, $04, $05, $00, $01, $0C, $0D
}

; $02A8B0-$02A90A JUMP LOCATION
Sprite_Rat:
{
    LDY.w $0D90, X
    LDA.w Pool_Sprite_Rat_animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$3F : ORA.w Pool_Sprite_Rat_vh_flip, Y : STA.w $0F50, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_CheckIfRecoiling
    JSR.w Sprite2_CheckDamage
    JSR.w Sprite2_Move
    JSR.w Sprite2_CheckTileCollision
    
    LDA.w $0D80, X : BNE Rat_Moving
        JSR.w Sprite2_ZeroVelocity
        
        LDA.w $0DF0, X : BNE .no_new_direction
            ; Select a new direction and change to the moving state.
            
            JSL.l GetRandomInt : PHA
            AND.b #$03         : STA.w $0DE0, X
            
            INC.w $0D80, X
            
            PLA : AND.b #$7F : ADC.b #$40 : STA.w $0DF0, X
        
        .no_new_direction
        
        ; OPTIMIZE: What?
        LDA.b $1A : LSR #4
        
        LDA.w $0DE0, X : ROL : TAY
        LDA.w Pool_Sprite_Rat_stationary_states, Y : STA.w $0D90, X
        
        RTS
}

; ==============================================================================

; $02A90B-$02A916 DATA
Pool_Rat_Moving:
{
    ; $02A90B
    .x_speeds
    db  24, -24,   0,   0
    
    ; $02A90F
    .y_speeds
    db   0,   0,  24, -24
    
    ; $02A913
    .next_direction
    db 2, 3, 0, 1
}

; $02A917-$02A95A BRANCH LOCATION
Rat_Moving:
{
    LDA.w $0DF0, X : BNE .sound_wait
        LDA.w $0FFF : BNE .in_dark_world
            LDA.b #$17
            JSL.l Sound_SetSFX3PanLong
        
        .in_dark_world
        
        STZ.w $0D80, X
        
        LDA.b #$50 : STA.w $0DF0, X
        
    .sound_wait
    
    LDY.w $0DE0, X
    
    LDA.w $0E70, X : BEQ .no_wall_collision
        LDA.w Pool_Rat_Moving_next_direction, Y : STA.w $0DE0, X
                                                  TAY
    
    .no_wall_collision
    
    LDA.w Pool_Rat_Moving_x_speeds, Y : STA.w $0D50, X
    LDA.w Pool_Rat_Moving_y_speeds, Y : STA.w $0D40, X
    
    ; OPTIMIZE: What?
    LDA.b $1A : LSR #3
    
    LDA.w $0DE0, X : ROL : TAY
    LDA.w Sprite_Rat_moving_states, Y : STA.w $0D90, X
    
    RTS
}

; ==============================================================================
