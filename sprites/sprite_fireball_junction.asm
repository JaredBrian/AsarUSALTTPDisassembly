; ==============================================================================

; $0EC853-$0EC868 JUMP LOCATION
Pool_Sprite_FireballJunction:
{
    ; $0EC853
    .x_offsets_low
    db $0C, $F4, $00, $00
    
    ; $0EC857
    .x_offsets_high
    db $00, $FF, $00, $00
    
    ; $0EC85B
    .y_offsets_low
    db $00, $00, $0C, $F4
    
    ; $0EC85F
    .y_offsets_high
    db $00, $00, $00, $FF
    
    ; $0EC863
    .y_speeds ; Length 4, Bleeds into the next block.
    db $00, $00
    
    ; $0EC865
    .x_speeds
    db $28, $D8, $00, $00
}

; ==============================================================================

; $0EC869-$0EC8CB JUMP LOCATION
Sprite_FireballJunction:
{
    JSL.l Sprite_PrepOamCoordLong
    JSR.w Sprite4_CheckIfActive
    
    LDA.w $0DF0, X : BEQ .check_for_player_sword_usage
        CMP #$18 : BNE .dont_spawn
            JSL.l Sprite_SpawnFireball : BMI .spawn_failed
                JSR.w Medusa_ConfigFireballProperties
                
                PHX
                
                TYX
                
                JSR.w Sprite4_DirectionToFacePlayer
                
                LDA.w Pool_Sprite_FireballJunction_x_speeds, Y : STA.w $0D50, X
                
                LDA.w Pool_Sprite_FireballJunction_y_speeds, Y : STA.w $0D40, X
                
                LDA.w $0D10, X
                CLC : ADC Pool_Sprite_FireballJunction_x_offsets_low, Y
                STA.w $0D10, X

                LDA.w $0D30, X
                ADC Pool_Sprite_FireballJunction_x_offsets_high, Y
                STA.w $0D30, X
                
                LDA.w $0D00, X
                CLC : ADC Pool_Sprite_FireballJunction_y_offsets_low, Y
                STA.w $0D00, X

                LDA.w $0D20, X
                ADC Pool_Sprite_FireballJunction_y_offsets_high, Y
                STA.w $0D20, X
                
                PLX
            
            .spawn_failed
        .dont_spawn
        
        RTS
    
    .check_for_player_sword_usage
    
    LDA.b $3C : BEQ .dont_initiate_spawn
        LDA.w $0F20, X : CMP.b $EE : BNE .dont_initiate_spawn
            LDA.b #$20 : STA.w $0DF0, X
        
    .dont_initiate_spawn
    
    RTS
}

; ==============================================================================
