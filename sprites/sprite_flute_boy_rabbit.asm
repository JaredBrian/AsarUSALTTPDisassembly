
; ==============================================================================

; $0F1A6B-$0F1A6C DATA
Pool_FluteBoyAnimal:
{
    .vh_flip
    db $40, $00
}

; ==============================================================================

; $0F1A6D-$0F1A89 JUMP LOCATION
Sprite_FluteBoyRabbit:
{
    LDY.w $0DE0, X
    
    LDA.w $0F50, X : AND.b #$BF : ORA FluteBoyAnimal.vh_flip, Y : STA.w $0F50, X
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw FluteBoyRabbit_Chillin
    dw FluteBoyRabbit_RunAway
}

; ==============================================================================

; $0F1A8A-$0F1AAB JUMP LOCATION
FluteBoyRabbit_Chillin:
{
    LDA.b #$03 : STA.w $0DC0, X
    
    LDA.w $0FDD : BEQ .dont_run_away
    
    INC.w $0D80, X
    
    LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X : TAY
    
    LDA Sprite3_Shake.x_speeds, Y : STA.w $0D50, X
    
    LDA.b #$F8 : STA.w $0D40, X
    
    .dont_run_away
    
    RTS
}

; ==============================================================================

; $0F1AAC-$0F1AAE DATA
Pool_FluteBoyRabbit_RunAway:
{
    .animation_states
    db 0, 1, 2
}

; ==============================================================================

; $0F1AAF-$0F1AEB JUMP LOCATION
FluteBoyRabbit_RunAway:
{
    JSR Sprite3_MoveXyz
    
    DEC.w $0F80, X : DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .aloft
    
    ; Hop again!
    LDA.b #$18 : STA.w $0F80, X
    
    STZ.w $0F70, X
    
    STZ.w $0E80, X
    
    STZ.w $0D90, X
    
    .aloft
    
    INC.w $0E80, X : LDA.w $0E80, X : AND.b #$03 : BNE .delay_animation_tick
    
    LDA.w $0D90, X : CMP.b #$02 : BEQ .animation_counter_maxed
    
    INC.w $0D90, X
    
    .animation_counter_maxed
    .delay_animation_tick
    
    LDY.w $0D90, X
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

