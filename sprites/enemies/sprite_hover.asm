
; ==============================================================================

; $0F4C02-$0F4C42 JUMP LOCATION
Sprite_Hover:
{
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite3_CheckIfActive
    
    LDA.w $0EA0, X : BEQ .not_in_recoil
    
    STZ.w $0D80, X
    
    .not_in_recoil
    
    JSR Sprite3_CheckIfRecoiling
    JSR Sprite3_CheckDamage
    
    LDA.w $0E70, X : BNE .collided_with_tile
    
    JSR Sprite3_Move
    
    .collided_with_tile
    
    JSR Sprite3_CheckTileCollision
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR #3 : AND.b #$02 : STA.w $0DC0, X
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Hover_Stopped
    dw Hover_Moving
}

; ==============================================================================

; $0F4C43-$0F4C46 DATA
Pool_Hover_Stopped:
{
    .vh_flip
    db $40, $00, $40, $00
}

; ==============================================================================

; $0F4C47-$0F4C78 JUMP LOCATION
Hover_Stopped:
{
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    ; \note $0DE0, X is used atypically here as a bitfield rather than
    ; a discrete direction. This allows it to move in both directions at
    ; once, but also restricts it to diagonal movement.
    JSR Sprite3_IsToRightOfPlayer
    
    STY.b $0C
    
    JSR Sprite3_IsBelowPlayer
    
    TYA : ASL A : ORA.b $0C : STA.w $0DE0, X : TAY
    
    LDA.w $0F50, X : AND.b #$BF : ORA .vh_flip, Y : STA.w $0F50, X
    
    JSL GetRandomInt : AND.b #$0F : ADC.b #$0C : STA.w $0DF0, X
    
    JSR Sprite3_Zero_XY_Velocity
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F4C79-$0F4C88 DATA
Pool_Hover_Moving:
{
    .x_acceleration_step
    db $01, $FF, $01, $FF
    
    .y_acceleration_step
    db $01, $01, $FF, $FF
    
    .x_deceleration_step
    db $FF, $01, $FF, $01
    
    .y_deceleration_step
    db $FF, $FF, $01, $01        
}

; ==============================================================================

; $0F4C89-$0F4CD2 JUMP LOCATION
Hover_Moving:
{
    LDA.w $0DF0, X : BEQ .timer_elapsed
    
    LDY.w $0DE0, X
    
    ; Accelerate until timer elapses.
    LDA.w $0D50, X : CLC : ADC.w $CC79, Y : STA.w $0D50, X
    
    LDA.w $0D40, X : CLC : ADC.w $CC7D, Y : STA.w $0D40, X
    
    LDA.w $0E80, X : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
    
    .timer_elapsed
    
    LDY.w $0DE0, X
    
    ; Decelerate until stopped.
    LDA.w $0D50, X : CLC : ADC.w $CC81, Y : STA.w $0D50, X
    
    LDA.w $0D40, X : CLC : ADC.w $CC85, Y : STA.w $0D40, X : BNE .still_decelerating
    
    STZ.w $0D80, X
    
    LDA.b #$40 : STA.w $0DF0, X
    
    .still_declerating
    
    RTS
}

; ==============================================================================
