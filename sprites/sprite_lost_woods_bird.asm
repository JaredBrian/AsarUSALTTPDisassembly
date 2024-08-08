
; ==============================================================================

; $02940E-$029467 JUMP LOCATION
Sprite_LostWoodsBird:
{
    LDA.w $0E00, X : BNE .delay
    
    LDA.w $0F50, X : AND.b #$BF
    
    LDY.w $0D50, X : BMI .moving_left
    
    ; set the hflip bit
    ORA.b #$40
    
    .moving_left
    
    STA.w $0F50, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_Move
    JSR.w Sprite2_MoveAltitude
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw .dropping
    dw .still_rising
    
    .dropping
    
    STZ.w $0DC0C0, X
    
    LDA.w $0F80, X : DEC A : STA.w $0F80, X : CMP.b #$F1 : BPL .still_dropping
    
    INC.w $0D80, X
    
    .still_dropping
    .delay
    
    RTS
     
     .rising
     
    LDA.w $0F80, X : INC #2 : STA.w $0F80, X : CMP.b #$10 : BMI .still_rising
    
    STZ.w $0D80, X
    
    .still_rising
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR A : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================
