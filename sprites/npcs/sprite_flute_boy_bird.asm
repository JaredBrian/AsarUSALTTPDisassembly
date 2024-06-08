
; ==============================================================================

; $0F1AEC-$0F1B2B JUMP LOCATION
Sprite_FluteBoyBird:
{
    LDA.w $0DC0, X : CMP.b #$03 : BNE .not_blinking
    
    JSR FluteBoyBird_DrawBlink
    
    .not_blinking
    
    LDY.w $0DE0, X
    
    LDA.w $0F50, X : AND.b #$BF : ORA FluteBoyAnimal.vh_flip, Y : STA.w $0F50, X
    
    REP #$20
    
    LDA $90 : CLC : ADC.w #$0004 : STA $90
    
    INC $92
    
    SEP #$20
    
    DEC.w $0E40, X
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    INC.w $0E40, X
    
    JSR Sprite3_MoveXyz
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw FluteBoyBird_Chillin
    dw FluteBoyBird_Rising
    dw FluteBoyBird_Falling
}

; ==============================================================================

; $0F1B2C-$0F1B60 JUMP LOCATION
FluteBoyBird_Chillin:
{
    LDY.b #$00
    
    LDA $1A : AND.b #$18 : BNE .other_animation_state
    
    LDY.b #$03
    
    .other_animation_state
    
    TYA : STA.w $0DC0, X
    
    LDA.w $0FDD : BEQ .dont_run_away
    
    INC.w $0D80, X
    
    LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X : TAY
    
    LDA Sprite3_Shake.x_speeds, Y : STA.w $0D50, X
    
    LDA.b #$20 : STA.w $0DF0, X
    
    LDA.b #$10 : STA.w $0F80, X
    
    LDA.b #$F8 : STA.w $0D40, X
    
    .dont_run_away
    
    RTS
}

; ==============================================================================

; $0F1B61-$0F1B83 JUMP LOCATION
FluteBoyBird_Rising:
{
    LDA.w $0DF0, X : BNE .delay
    
    LDA.w $0F80, X : CLC : ADC.b #$02 : STA.w $0F80, X
    
    CMP.b #$10 : BMI .below_rise_speed_limit
    
    INC.w $0D80, X
    
    .below_rise_speed_limit
    .delay
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR A : AND.b #$01 : INC A : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F1B84-$0F1B99 JUMP LOCATION
FluteBoyBird_Falling:
{
    LDA.b #$01 : STA.w $0DC0, X
    
    LDA.w $0F80, X : SEC : SBC.b #$01 : STA.w $0F80, X
    
    CMP.b #$F1 : BPL .above_fall_speed_limit
    
    DEC.w $0D80, X
    
    .above_fall_speed_limit
    
    RTS
}

; ==============================================================================

; $0F1B9A-$0F1B9B DATA
Pool_FluteBoyBird_DrawBlink:
{
    .x_offsets
    $08, $00
}

; ==============================================================================

; $0F1B9C-$0F1BC7 LOCAL JUMP LOCATION
FluteBoyBird_DrawBlink:
{
    JSR Sprite3_PrepOamCoord
    
    PHX
    
    LDA.w $0DE0, X : TAX
    
    LDA $00 : CLC : ADC .x_offsets, X                    : STA ($90), Y
    LDA $02                                  : INY : STA ($90), Y
    LDA.b #$AE                               : INY : STA ($90), Y
    LDA $05 : ORA FluteBoyAnimal.vh_flip, X  : INY : STA ($90), Y
    
    PLX
    
    LDY.b #$00
    LDA.b #$00
    
    JSL Sprite_CorrectOamEntriesLong
    
    RTS
}

; ==============================================================================

