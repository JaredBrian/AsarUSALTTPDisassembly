
; ==============================================================================

; $0F7D12-$0F7D13 DATA
Pool_Fairy_HandleMovement:
{
    .z_speeds
    db 1, -1
}

; ==============================================================================

; $0F7D14-$0F7D1B LONG JUMP LOCATION
Fairy_HandleMovementLong:
{
    ; Some subroutine of a Fairy...
    
    PHB : PHK : PLB
    
    JSR.w Fairy_HandleMovement
    
    PLB
    
    RTL
}

; ==============================================================================

; $0F7D1C-$0F7E32 LOCAL JUMP LOCATION
Fairy_HandleMovement:
{
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    ; Interesting... the outdoor fairys have no regard for walls.
    LDA.b $1B : BEQ .no_wall_bounce_detection
    
    LDA.w $0E00, X : BNE .dont_invert_speeds
    
    JSR.w Sprite3_CheckTileCollision
    
    AND.b #$03 : BEQ .dont_invert_x_speed
    
    LDA.w $0D50, X : EOR.b #$FF : INC A : STA.w $0D50, X
    
    LDA.w $0DE0, X : EOR.b #$FF : INC A : STA.w $0DE0, X
    
    LDA.b #$20 : STA.w $0E00, X
    
    .dont_invert_x_speed
    
    LDA.w $0E70, X : AND.b #$0C : BEQ .dont_invert_y_speed
    
    LDA.w $0D40, X : EOR.b #$FF : INC A : STA.w $0D40, X
    
    LDA.w $0D90, X : EOR.b #$FF : INC A : STA.w $0D90, X
    
    LDA.b #$20 : STA.w $0E00, X
    
    .dont_invert_y_speed
    .no_wall_bounce_detection
    
    LDA.w $0D50, X : BEQ .x_speed_at_zero
                   BPL .positive_x_speed
    
    LDA.w $0F50, X : AND.b #$BF
    
    BRA .set_hflip
    
    .positive_x_speed
    
    LDA.w $0F50, X : ORA.b #$40
    
    .set_hflip
    
    STA.w $0F50, X
    
    .x_speed_at_zero
    
    JSR.w Sprite3_Move
    
    LDA.b $1A : AND.b #$3F : BNE .direction_change_delay
    
    JSL.l GetRandomInt : STA.b $04
    LDA.b $23          : STA.b $05
    
    JSL.l GetRandomInt : STA.b $06
    LDA.b $21          : STA.b $07
    
    LDA.b #$10
    
    JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D90, X
    LDA.b $01 : STA.w $0DE0, X
    
    .direction_change_delay
    
    LDA.b $1A : AND.b #$0F : BNE .delay_speed_averaging
    
    LDA.b #$FF : STA.b $01
                 STA.b $03
    
    LDA.w $0D90, X : STA.b $00 : BMI .negative_y_target_speed
    
    STZ.b $01
    
    .negative_y_target_speed
    
    LDA.w $0D40, X : STA.b $02 : BMI .negative_y_speed
    
    STZ.b $03
    
    .negative_y_speed
    
    REP #$21
    
    ; average the two speeds?
    LDA.b $00 : ADC.b $02 : LSR A : SEP #$30 : STA.w $0D40, X
    
    LDA.b #$FF : STA.b $01
                 STA.b $03
    
    LDA.w $0DE0, X : STA.b $00 : BMI .negative_x_target_speed
    
    STZ.b $01
    
    .negative_x_target_speed
    
    LDA.w $0D50, X : STA.b $02 : BMI .negative_x_speed
    
    STZ.b $03
    
    .negative_x_speed
    
    REP #$21
    
    LDA.b $00 : ADC.b $02 : LSR A : SEP #$30 : STA.w $0D50, X
    
    .delay_speed_averaging
    
    JSR.w Sprite3_MoveAltitude
    
    JSL.l GetRandomInt : AND.b #$01 : TAY
    
    LDA.w .z_speeds, Y : CLC : ADC.w $0F80, X : STA.w $0F80, X
    
    LDA.w $0F70, X
    
    LDY.b #$08
    
    CMP.b #$08 : BCC .too_close_to_ground
    
    LDY.b #$18
    
    CMP.b #$18 : BCC .not_too_elevated
    
    TYA : STA.w $0F70, X
    
    LDA.b #$FB : STA.w $0F80, X
    
    .not_too_elevated
    
    RTS
    
    .too_close_to_ground
    
    TYA : STA.w $0F70, X
    
    LDA.b #$05 : STA.w $0F80, X
    
    RTS
}

; ==============================================================================

; $0F7E33-$0F7E68 LONG JUMP LOCATION
PlayerItem_SpawnFairy:
{
    LDA.b #$E3 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA.b $EE : STA.w $0F20, Y
    
    LDA.b $22 : CLC : ADC.b #$08 : STA.w $0D10, Y
    LDA.b $23 : ADC.b #$00 : STA.w $0D30, Y
    
    LDA.b $20 : CLC : ADC.b #$10 : STA.w $0D00, Y
    LDA.b $21 : ADC.b #$00 : STA.w $0D20, Y
    
    LDA.b #$00 : STA.w $0DE0, Y
    LDA.b #$60 : STA.w $0F10, Y
    
    .spawn_failed
    
    RTL
}

; ==============================================================================
