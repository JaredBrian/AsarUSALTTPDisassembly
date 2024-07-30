
; ==============================================================================

; $0EC853-$0EC868 JUMP LOCATION
Pool_Sprite_FireballJunction:
{
    .x_offsets_low
    db $0C, $F4, $00, $00
    
    .x_offsets_high
    db $00, $FF, $00, $00
    
    .y_offsets_low
    db $00, $00, $0C, $F4
    
    .y_offsets_high
    db $00, $00, $00, $FF
    
    .y_speeds length 4
    db $00, $00
    
    .x_speeds
    db $28, $D8, $00, $00
}

; ==============================================================================

; $0EC869-$0EC8CB JUMP LOCATION
Sprite_FireballJunction:
{
    JSL Sprite_PrepOamCoordLong
    JSR Sprite4_CheckIfActive
    
    LDA.w $0DF0, X : BEQ .check_for_player_sword_usage
    CMP #$18     : BNE .dont_spawn
    
    JSL Sprite_SpawnFireball : BMI .spawn_failed
    
    JSR Medusa_ConfigFireballProperties
    
    PHX
    
    TYX
    
    JSR Sprite4_DirectionToFacePlayer
    
    LDA .x_speeds, Y : STA.w $0D50, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    LDA.w $0D10, X : CLC : ADC .x_offsets_low, Y  : STA.w $0D10, X
    LDA.w $0D30, X : ADC .x_offsets_high, Y : STA.w $0D30, X
    
    LDA.w $0D00, X : CLC : ADC .y_offsets_low, Y  : STA.w $0D00, X
    LDA.w $0D20, X : ADC .y_offsets_high, Y : STA.w $0D20, X
    
    PLX
    
    .spawn_failed
    .dont_spawn
    
    RTS
    
    .check_for_player_sword_usage
    
    LDA.b $3C : BEQ .dont_initiate_spawn
    
    LDA.w $0F20, X : CMP $EE : BNE .dont_initiate_spawn
    
    LDA.b #$20 : STA.w $0DF0, X
    
    .dont_initiate_spawn
    
    RTS
}

; ==============================================================================