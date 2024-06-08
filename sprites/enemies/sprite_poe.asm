
; ==============================================================================

; $031686-$031687 DATA
Pool_Sprite_Poe:
{
    .h_flip
    db $40, $00
}

; ==============================================================================

; $031688-$03171E JUMP LOCATION
Sprite_Poe:
{
    ; Derive orientation (for h_flip) from the sign of the x velocity.
    LDA.w $0D50, X : ASL A : ROL A : AND.b #$01 : STA.w $0DE0, X : TAY
    
    LDA.w $0F50, X : AND.b #$BF : ORA .h_flip, Y : STA.w $0F50, X
    
    ; If this branch is taken, it means that the Poe is rising from a
    ; grave in the light world.
    LDA.w $0E90, X : BNE .dont_use_super_priority
    
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    .dont_use_super_priority
    
    JSR Poe_Draw
    
    REP #$20
    
    LDA $90 : CLC : ADC.w #$0004 : STA $90
    
    INC $92
    
    SEP #$20
    
    DEC.w $0E40, X
    
    JSR Sprite_PrepAndDrawSingleLarge
    
    INC.w $0E40, X
    
    JSR Sprite_CheckIfActive
    JSR Sprite_CheckIfRecoiling
    
    LDA.w $0E90, X : BEQ .not_rising_from_grave
    
    ; The Poe can't do anything else while it is rising from a grave. It
    ; just gets drawn and rises until it reaches a height of 12 pixels.
    INC.w $0F70, X
    
    LDA.w $0F70, X : CMP.b #12 : BNE .not_at_target_altitude
    
    STZ.w $0E90, X
    
    .not_at_target_altitude
    
    RTS
    
    .not_rising_from_grave
    
    JSR Sprite_CheckDamage
    
    INC.w $0E80, X
    
    JSR Sprite_Move
    
    LDA $1A : LSR A : BCS .z_speed_adjustment_delay
    
    LDA.w $0ED0, X : AND.b #$01 : TAY
    
    LDA.w $0F80, X : CLC : ADC .acceleration, Y : STA.w $0F80, X
    
    CMP .z_speed_limits, Y : BNE .z_speed_not_at_max
    
    INC.w $0ED0, X
    
    .z_speed_not_at_max
    .z_speed_adjustment_delay
    
    JSR Sprite_MoveAltitude
    
    STZ.w $0D40, X
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Poe_SelectVerticalDirection
    dw Poe_Roaming

    parallel Pool_Poe_Roaming:
    
    .acceleration
    db 1, -1
    
    ; \note These accelerations are use only for the x velocity and only
    ; in the dark world, making the poes slightly different there.
    db 2, -2
    
    .x_speed_limits
    db 16, -16, 28, -28
    
    .z_speed_limits
    db 8, -8
}

; ==============================================================================

; $03171F-$03173E JUMP LOCATION
Poe_SelectVerticalDirection:
{
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    ; Generate one random int and check its bit content.
    JSL GetRandomInt : AND.b #$0C : BNE .flip_a_coin
    
    ; In this case the player's relative position is used to set the
    ; y direction.
    JSR Sprite_IsBelowPlayer : TYA
    
    BRA .set_y_direction
    
    .flip_a_coin
    
    ; And in this case it's just a fifty fifty chance of going one way
    ; or thw other, vertically.
    JSL GetRandomInt : AND.b #$01
    
    .set_y_direction
    
    STA.w $0EB0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $03173F-$031740 DATA
Pool_Poe_Roaming:
{
    .y_speeds
    db 8, -8
}

; ==============================================================================

; $031741-$03177D JUMP LOCATION
Poe_Roaming:
{
    LDA.w $001A : LSR A : BCS .adjust_speed_delay
    
    ; Why are we adding the light world / dark world distinctifier?
    LDA.w $0EC0, X : AND.b #$01 : CLC : ADC.w $0FFF : ADC.w $0FFF : TAY
    
    LDA.w $0D50, X : CLC : ADC .acceleration, Y : STA.w $0D50, X
    
    CMP .x_speed_limits, Y : BNE .x_speed_maxed_out
    
    ; Speed limit reached, time to switch direction.
    INC.w $0EC0, X
    
    STZ.w $0D80, X
    
    JSL GetRandomInt : AND.b #$1F : ADC.b #$10 : STA.w $0DF0, X
    
    .adjust_speed_delay
    .x_speed_maxed_out
    
    LDY.w $0EB0, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    RTS
}

; ==============================================================================

; $03177E-$031785 DATA
Pool_Poe_Draw:
{
    .x_offsets
    db 9, 0, -1, -1
    
    .chr
    db $7C, $80, $B7, $80
}

; ==============================================================================

; $031786-$0317D7 LOCAL JUMP LOCATION
Poe_Draw:
{
    JSR Sprite_PrepOamCoord
    
    LDA.w $0E80, X : LSR #3 : AND.b #$03 : STA $06
    
    LDA.w $0DE0, X : ASL A : PHX : TAX
    
    REP #$20
    
    LDA $00 : CLC : ADC .x_offsets, X : STA ($90), Y
    
    CLC : ADC.w #$0100 : STA $0E
    
    LDA $02 : CLC : ADC.w #$0009 : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
    
    LDA.b #$F0 : STA ($90), Y
    
    .on_screen_y
    
    LDX $06
    
    LDA .chr, X                       : INY : STA ($90), Y
    LDA $05 : AND.b #$F0 : ORA.b #$02 : INY : STA ($90), Y
    
    LDA $0F : STA ($92)
    
    PLX
    
    RTS
}

; ==============================================================================
