; ==============================================================================

; $0323F9-$032408 DATA
Sprite_Helmasaur:
{
    .animation_states
    db 3, 4, 3, 4, 2, 2, 5, 5
    
    .h_flip
    db $40, $40, $00, $00, $00, $40, $40, $00
}

; ==============================================================================

; $032409-$0324D1 JUMP LOCATION
Sprite_Helmasaur:
{
    LDA.w $0DE0, X : ASL A : STA $00
    
    LDA.w $0E80, X : LSR #2 : AND.b #$01 : ORA $00 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$BF : ORA .h_flip, Y : STA.w $0F50, X
    
    TXA : EOR $1A : AND.b #$0F : BNE .delay_direction_selection_logic
    
    LDA.w $0D50, X : BPL .abs_x_speed
    
    EOR.b #$FF : INC A

    .abs_x_speed

    STA $00
    
    LDA.w $0D40, X : BPL .abs_y_speed
    
    EOR.b #$FF : INC A

    .abs_y_speed

    STA $01
    
    LDA $00 : CMP $01
    
    LDA.b #$00
    
    LDY.w $0D50, X
    
    BCS .x_speed_magnitude_greater_or_equal
    
    LDA.b #$02
    
    LDY.w $0D40, X
    
    .x_speed_magnitude_greater_or_equal
    
    BPL .winning_speed_is_not_negative
    
    INC A
    
    .winning_speed_is_not_negative
    
    STA.w $0DE0, X
    
    .delay_direction_selection_logic
    
    JSR Sprite_PrepAndDrawSingleLarge
    
    BRA .done_drawing
    
    ; $032460 ALTERNATE ENTRY POINT
    shared Sprite_HardHatBeetle:
    
    LDA.w $0E80, X : LSR #2 : AND.b #$01 : STA.w $0DC0, X
    
    JSR HardHatBeetle_Draw

    .done_drawing

    JSR Sprite_CheckIfActive
    
    INC.w $0E80, X
    
    JSR Sprite_CheckIfRecoiling
    JSR Sprite_CheckDamage
    
    LDA.w $0E70, X : AND.b #$0F : BEQ .no_tile_collision
    
    AND.b #$03 : BEQ .no_horizontal_tile_collision
    
    STZ.w $0D50, X
    
    .no_horizontal_tile_collision
    
    ; \wtf Seems like not really a bug, but a quirk. If it hit tiles it
    ; always zeroes its y velocity, but conditionally zeroes the x velocity.
    STZ.w $0D40, X
    
    BRA .dont_move
    
    .no_tile_collision
    
    JSR Sprite_Move
    
    .dont_move
    
    JSR Sprite_CheckTileCollision
    
    TXA : EOR $1A : AND.b #$1F : BNE .project_speed_delay
    
    LDA.w $0D90, X
    
    JSR Sprite_ProjectSpeedTowardsPlayer
    
    LDA $00 : STA.w $0DA0, X
    
    LDA $01 : STA.w $0DB0, X
    
    .project_speed_delay
    
    TXA : EOR $1A : AND.w $0D80, X : BNE .acceleration_delay
    
    LDA.w $0D40, X : CMP.w $0DA0, X : BPL .y_speed_maxed
    
    INC.w $0D40, X
    
    BRA .check_x_speed
    
    .y_speed_maxed
    
    DEC.w $0D40, X
    
    .check_x_speed
    
    LDA.w $0D50, X : CMP.w $0DB0, X : BPL .x_speed_maxed
    
    INC.w $0D50, X
    
    BRA .return
    
    .x_speed_maxed
    
    DEC.w $0D50, X
    
    .return
    .acceleration_delay
    
    RTS
}

; ==============================================================================

; $0324D2-$0324F1 DATA
{
    .oam_groups
    dw 0, -4 : db $40, $01, $00, $02
    dw 0,  2 : db $42, $01, $00, $02
    
    dw 0, -5 : db $40, $01, $00, $02
    dw 0,  2 : db $44, $01, $00, $02
}

; ==============================================================================

; $0324F2-$03250B LOCAL JUMP LOCATION
HardHatBeetle_Draw:
{
    LDA.w $0DC0, X : ASL #4
    
    ADC.b #.oam_groups                 : STA $08
    LDA.b #.oam_groups>>8 : ADC.b #$00 : STA $09
    
    LDA.b #$02 : JSL Sprite_DrawMultiple
    
    JMP Sprite_DrawShadowRedundant
}

; ==============================================================================
