; ==============================================================================

; $031686-$031687 DATA
Pool_Sprite_Poe_h_flip:
{
    db $40, $00
}

; $031688-$03171E JUMP LOCATION
Sprite_Poe:
{
    ; Derive orientation (for h_flip) from the sign of the x velocity.
    LDA.w $0D50, X : ASL : ROL : AND.b #$01 : STA.w $0DE0, X : TAY
    
    LDA.w $0F50, X : AND.b #$BF : ORA .h_flip, Y : STA.w $0F50, X
    
    ; If this branch is taken, it means that the Poe is rising from a
    ; grave in the light world.
    LDA.w $0E90, X : BNE .dont_use_super_priority
        LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    .dont_use_super_priority
    
    JSR.w Poe_Draw
    
    REP #$20
    
    LDA.b $90 : CLC : ADC.w #$0004 : STA.b $90
    
    INC.b $92
    
    SEP #$20
    
    DEC.w $0E40, X
    
    JSR.w Sprite_PrepAndDrawSingleLarge
    
    INC.w $0E40, X
    
    JSR.w Sprite_CheckIfActive
    JSR.w Sprite_CheckIfRecoiling
    
    LDA.w $0E90, X : BEQ .not_rising_from_grave
        ; The Poe can't do anything else while it is rising from a grave. It
        ; just gets drawn and rises until it reaches a height of 12 pixels.
        INC.w $0F70, X
        
        LDA.w $0F70, X : CMP.b #12 : BNE .not_at_target_altitude
            STZ.w $0E90, X
        
        .not_at_target_altitude
        
        RTS
        
    .not_rising_from_grave
    
    JSR.w Sprite_CheckDamage
    
    INC.w $0E80, X
    
    JSR.w Sprite_Move
    
    LDA.b $1A : LSR : BCS .z_speed_adjustment_delay
        LDA.w $0ED0, X : AND.b #$01 : TAY
        
        LDA.w $0F80, X : CLC : ADC .acceleration, Y : STA.w $0F80, X
        
        CMP .z_speed_limits, Y : BNE .z_speed_not_at_max
            INC.w $0ED0, X
        
        .z_speed_not_at_max
    .z_speed_adjustment_delay
    
    JSR.w Sprite_MoveAltitude
    
    STZ.w $0D40, X
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Poe_SelectVerticalDirection ; 0x00 - $971F
    dw Poe_ROAMing                 ; 0x00 - $9741

    ; $031715
    .acceleration
    db 1, -1
    
    ; NOTE: These accelerations are use only for the x velocity and only
    ; in the dark world, making the poes slightly different there.
    db 2, -2
    
    ; $031719
    .x_speed_limits
    db 16, -16, 28, -28
    
    ; $03171D
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
        JSL.l GetRandomInt : AND.b #$0C : BNE .flip_a_coin
            ; In this case the player's relative position is used to set the
            ; y direction.
            JSR.w Sprite_IsBelowPlayer : TYA
            
            BRA .set_y_direction
        
        .flip_a_coin
        
        ; And in this case it's just a fifty fifty chance of going one way
        ; or the other, vertically.
        JSL.l GetRandomInt : AND.b #$01
        
        .set_y_direction
        
        STA.w $0EB0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $03173F-$031740 DATA
Poe_ROAMing_y_speeds:
{
    db 8, -8
}

; $031741-$03177D JUMP LOCATION
Poe_ROAMing:
{
    LDA.w $001A : LSR : BCS .adjust_speed_delay
        ; Why are we adding the light world / dark world distinctifier?
        LDA.w $0EC0, X : AND.b #$01 : CLC : ADC.w $0FFF : ADC.w $0FFF : TAY
        
        LDA.w $0D50, X : CLC : ADC.w Sprite_Poe_acceleration, Y : STA.w $0D50, X
        
        CMP.w Sprite_Poe_x_speed_limits, Y : BNE .x_speed_maxed_out
            ; Speed limit reached, time to switch direction.
            INC.w $0EC0, X
            
            STZ.w $0D80, X
            
            JSL.l GetRandomInt : AND.b #$1F : ADC.b #$10 : STA.w $0DF0, X
        .x_speed_maxed_out

    .adjust_speed_delay
    
    LDY.w $0EB0, X
    
    LDA.w .y_speeds, Y : STA.w $0D40, X
    
    RTS
}

; ==============================================================================

; $03177E-$031785 DATA
Pool_Poe_Draw:
{
    ; $03177E
    .x_offsets
    db 9, 0, -1, -1
    
    ; $031782
    .chr
    db $7C, $80, $B7, $80
}

; $031786-$0317D7 LOCAL JUMP LOCATION
Poe_Draw:
{
    JSR.w Sprite_PrepOamCoord
    
    LDA.w $0E80, X : LSR #3 : AND.b #$03 : STA.b $06
    
    LDA.w $0DE0, X : ASL : PHX : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC Pool_Poe_Draw_x_offsets, X : STA ($90), Y
    
    CLC : ADC.w #$0100 : STA.b $0E
    
    LDA.b $02 : CLC : ADC.w #$0009 : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
        LDA.b #$F0 : STA ($90), Y
    
    .on_screen_y
    
    LDX.b $06
    
    LDA.w Pool_Poe_Draw_chr, X          : INY : STA ($90), Y
    LDA.b $05 : AND.b #$F0 : ORA.b #$02 : INY : STA ($90), Y
    
    LDA.b $0F : STA ($92)
    
    PLX
    
    RTS
}

; ==============================================================================
