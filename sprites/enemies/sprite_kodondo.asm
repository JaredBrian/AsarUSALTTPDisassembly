
; ==============================================================================

; $0F4103-$0F411F JUMP LOCATION
Sprite_Kodondo:
{
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite3_CheckIfActive
    JSR Sprite3_CheckIfRecoiling
    JSR Sprite3_CheckDamage
    
    STZ.w $0B6B, X
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Kodondo_ChooseDirection
    dw Kodondo_Move
    dw Kodondo_BreatheFlame
}

; ==============================================================================

; $0F4120-$0F4127 DATA
    Pool_Kodondo_ChooseDirection
{
    .x_speeds
    db $01, $FF, $00, $00
    
    .y_speeds
    db $00, $00, $01, $FF
}

; ==============================================================================

; $0F4128-$0F4167 JUMP LOCATION
Kodondo_ChooseDirection:
{
    INC.w $0D80, X
    
    JSL GetRandomInt : AND.b #$03 : STA.w $0DE0, X
    
    LDA.b #$B0 : STA.w $0B6B, X
    
    .try_another_direction
    
    LDY.w $0DE0, X
    
    LDA .x_speeds, Y : STA.w $0D50, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    JSR Sprite3_CheckTileCollision : BEQ .no_tile_collision
    
    LDA.w $0DE0, X : INC A : AND.b #$03 : STA.w $0DE0, X
    
    ; \bug I'm thinking this could potentially crash the game... (in the
    ; sense that it would be stuck in this loop, not go off the rails
    ; completely)
    BRA .try_another_direction
    
    .no_tile_collision
    
    ; $0F4158 ALTERNATE ENTRY POINT
    shared Kodondo_SetSpeed:
    
    LDY.w $0DE0, X
    
    LDA Sprite3_Shake.x_speeds, Y : STA.w $0D50, X
    
    LDA Sprite3_Shake.y_speeds, Y : STA.w $0D40, X
    
    RTS
}

; ==============================================================================

; $0F4168-$0F4177 DATA
Pool_Kodondo_Move:
{
    .animation_states
    db $02, $02, $00, $05, $03, $03, $00, $05
    
    .vh_flip_override
    db $40, $00, $00, $00, $40, $00, $40, $40
}

; ==============================================================================

; $0F4178-$0F41CD JUMP LOCATION
Kodondo_Move:
{
    JSR Sprite3_Move
    
    JSR Sprite3_CheckTileCollision : BEQ .no_tile_collision
    
    LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
    
    JSR Kodondo_SetSpeed
    
    .no_tile_collision
    
    ; This logic sets up an invisible grid of points at which the Kodondo
    ; can potentially breath flames. It's still semi random as indicated
    ; below, though.
    
    LDA.w $0D10, X : AND.b #$1F : CMP.b #$04 : BNE .dont_breathe_flame
    
    LDA.w $0D00, X : AND.b #$1F : CMP.b #$1B : BNE .dont_breathe_flame
    
    JSL GetRandomInt : AND.b #$03 : BNE .dont_breathe_flame
    
    LDA.b #$6F : STA.w $0DF0, X
    
    INC.w $0D80, X
    
    STZ.w $0D90, X
    
    .dont_breathe_flame
    
    INC.w $0E80, X
    
    LDA.w $0E80, X : AND.b #$04 : ORA.w $0DE0, X : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$BF : ORA .vh_flip_override, Y : STA.w $0F50, X
    
    RTS
}

; ==============================================================================

; $0F41CE-$0F41D5 DATA
Pool_Kodondo_BreatheFlames:
{
    .animation_states
    db $02, $02, $00, $05
    db $04, $04, $01, $06
}

; ==============================================================================

; $0F41D6-$0F4204 JUMP LOCATION
Kodondo_BreatheFlame:
{
    LDA.w $0DF0, X : BNE .dont_revert_yet
    
    STZ.w $0D80, X
    
    .dont_revert_yet
    
    LDY.b #$00
    
    SEC : SBC.b #$20 : CMP.b #$30 : BCS .cant_spawn
    
    LDY.b #$04
    
    .cant_spawn
    
    CPY.b #$04 : BNE .dont_spawn_flame
    
    LDA.w $0DF0, X : AND.b #$0F : BNE .dont_spawn_flame
    
    PHY
    
    JSR Kodondo_SpawnFlames
    
    PLY
    
    ,dont_spawn_flame
    
    TYA : ORA.w $0DE0, X : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F4205-$0F4222 DATA
Pool_Kodondo_SpawnFlames:
{
    .x_offsets_low
    db $08, $F8, $00, $00
    
    .x_offsets_high
    db $00, $FF, $00, $00
    
    .y_offsets_low
    db $00, $00, $08, $F8
    
    .y_offsets_high
    db $00, $00, $00, $FF
    
    .x_speeds
    db $18, $E8, $00, $00
    
    .y_speeds
    db $00, $00, $18, $E8
    
    ; \tcrf Not really major, but curious nonetheless
    .unused
    db $40, $38, $30, $28, $20, $18
}

; ==============================================================================

; $0F4223-$0F4266 LOCAL JUMP LOCATION
Kodondo_SpawnFlames:
{
    LDA.b #$87
    LDY.b #$0D
    
    JSL Sprite_SpawnDynamically_arbitrary : BMI .spawn_failed
    
    PHX
    
    LDA.w $0DE0, X : TAX
    
    LDA $00 : CLC : ADC .x_offsets_low, X  : STA.w $0D10, Y
    LDA $01 : ADC .x_offsets_high, X : STA.w $0D30, Y
    
    LDA $02 : CLC : ADC .y_offsets_low, X  : STA.w $0D00, Y
    LDA $03 : ADC .y_offsets_high, X : STA.w $0D20, Y
    
    LDA .x_speeds, X : STA.w $0D50, Y
    
    LDA .y_speeds, X : STA.w $0D40, Y
    
    LDA.b #$01 : STA.w $0BA0, Y
    
    PLX
    
    .spawn_failed
    
    RTS
} 

; ==============================================================================
