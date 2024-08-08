; ==============================================================================

; $028084-$02808F DATA
Pool_Sprite_WallCannon:
{
    .cannon_x_speeds
    db $00, $00
    
    .cannon_y_speeds
    db $F0, $10
    
    .cannon_animation_states
    db 0, 0, 2, 2
    
    .vh_flip
    db $40, $00, $00, $80
}

; ==============================================================================

; $028090-$028175 JUMP LOCATION
Sprite_WallCannon:
{
    ; Moving cannon ball shooters
    
    LDY.w $0DE0, X
    
    LDA.w $0E10, X : CMP.b #$01
    
    LDA.w .cannon_animation_states, Y : ADC.b #$00 : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$BF : ORA .vh_flip, Y : STA.w $0F50, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite2_CheckIfActive
    
    LDA.w $0DF0, X : BNE .direction_change_delay
    
    LDA.b #$80 : STA.w $0DF0, X
    
    LDA.w $0D90, X : EOR.b #$01 : STA.w $0D90, X
    
    .direction_change_delay
    
    LDY.w $0D90, X
    
    LDA.w .cannon_x_speeds, Y : STA.w $0D50, X
    
    LDA.w .cannon_y_speeds, Y : STA.w $0D40, X
    
    JSR.w Sprite2_Move
    
    TXA : ASL #2 : CLC : ADC.b $1A : AND.b #$1F : BNE .dont_reset_firing_delay
    
    LDA.b #$10 : STA.w $0E10, X
    
    .dont_reset_firing_delay
    
    LDA.w $0E10, X : CMP.b #$01 : BEQ .possible_to_fire
    
    RTS
    
    .possible_to_fire
    
    LDA.w $0F00, X : BNE .inactive_sprite
    
    ; Spawn cannon ball
    LDA.b #$6B
    LDY.b #$0D
    
    JSL.l Sprite_SpawnDynamically_arbitrary : BMI .spawn_failed
    
    LDA.b #$07 : JSL.l Sound_SetSfx3PanLong
    
    LDA.b #$01 : STA.w $0DB0, Y : STA.w $0DC0, Y
    
    LDA.w $0DE0, X : PHX : TAX
    
    LDA.b $00 : CLC : ADC .x_offsets_low, X  : STA.w $0D10, Y
    LDA.b $01 : ADC .x_offsets_high, X : STA.w $0D30, Y
    
    LDA.b $02 : CLC : ADC .y_offsets_low, X  : STA.w $0D00, Y
    LDA.b $03 : ADC .y_offsets_high, X : STA.w $0D20, Y
    
    LDA.w .cannonball_x_speeds, X : STA.w $0D50, Y
    
    LDA.w .cannonball_y_speeds, X : STA.w $0D40, Y
    
    LDA.w $0E40, Y : AND.b #$F0 : ORA.b #$01 : STA.w $0E40, Y
    
    LDA.w $0E60, Y : ORA.b #$47 : STA.w $0E60, Y
    LDA.w $0CAA, Y : ORA.b #$44 : STA.w $0CAA, Y
    
    LDA.b #$20 : STA.w $0DF0, Y
    
    PLX
    
    .spawn_failed
    .inactive_sprite
    
    RTS
    
    .x_offsets_low
    db 8, -8,  0,  0
    
    .x_offsets_high
    db 0, -1,  0,  0
    
    .y_offsets_low
    db 0,  0,  8, -8
    
    .y_offsets_high
    db 0,  0,  0, -1
    
    .cannonball_x_speeds
    db 24, -24,   0,   0
    
    .cannonball_y_speeds
    db  0,   0,  24, -24
}

; ==============================================================================

