
; ==============================================================================

; $034F64-$034F93 LOCAL JUMP LOCATION
Sprite_HandleDraggingByAncilla:
{
    ; The ancillae in question would most likely be the boomerang or
    ; hookshot. I can't think of any others that induce this sort of
    ; behavior.
    
    LDA.w $0DA0, X : BEQ .not_ancilla_slave
    
    TAY : DEY
    
    LDA.w $0C4A, Y : BEQ .ancilla_not_active
    
    LDA.w $0C04, Y : STA.w $0D10, X
    LDA.w $0C18, Y : STA.w $0D30, X
    
    LDA.w $0BFA, Y : STA.w $0D00, X
    LDA.w $0C0E, Y : STA.w $0D20, X
    
    STZ.w $0F70, X
    
    .terminate_caller
    
    PLA : PLA
    
    .not_ancilla_slave
    
    RTS
    
    .ancilla_not_active
    
    JSL.l Sprite_HandleAbsorptionByPlayerLong
    
    BRA .terminate_caller
}

; ==============================================================================

; $034F94-$034FBA JUMP LOCATION
Sprite_Fairy:
{
    LDA.b #$01 : STA.w $0BA0, X
    
    LDA.w $0D80, X : BNE .being_captured
    
    LDA.b $1B : BNE .indoors
    
    LDA.b #$30 : STA.w $0B89, X
    
    .indoors
    
    JSR.w Sprite_DrawTransientAbsorbable
    
    .being_captured
    
    JSR.w Fairy_CheckForTemporaryUntouchability
    JSR.w Sprite_CheckIfActive
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Fairy_Normal
    dw Fairy_HandleCapture
}

; ==============================================================================

; $034FBB-$034FE3 JUMP LOCATION
Fairy_Normal:
{
    LDA.w $0F10, X : BNE .cant_touch_this
    
    JSR.w Sprite_CheckDamageToPlayer : BCC .no_player_collision
    
    JSL.l Sprite_HandleAbsorptionByPlayerLong
    
    BRA .return
    
    .no_player_collision
    
    JSR.w Sprite_CheckDamageFromPlayer : BEQ .not_bugnetted
    
    INC.w $0D80, X
    
    ; "You caught a fairy! What will you do?"
    ; " > Keep it in a bottle..."
    LDA.b #$C9
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional
    
    RTS
    
    .return
    .not_bugnetted
    .cant_touch_this
    
    JSR.w Sprite_HandleDraggingByAncilla
    JSL.l Fairy_HandleMovementLong
    
    RTS
}

; ==============================================================================

; $034FE4-$035010 LOCAL JUMP LOCATION
Fairy_HandleCapture:
{
    LDA.w $1CE8 : BNE .was_released
    
    JSL.l Sprite_GetEmptyBottleIndex : BMI .no_empty_bottle
    
    PHX
    
    TAX
    
    LDA.b #$06 : STA.l $7EF35C, X
    
    JSL.l HUD.RefreshIconLong
    
    PLX
    
    ; Apparently indicates this bottle is full.
    STZ.w $0DD0, X
    
    RTS
    
    .no_empty_bottle
    
    ; "Get an empty bottle, you dummy."
    LDA.b #$CA
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional
    
    .was_released
    
    LDA.b #$30 : STA.w $0F10, X
    
    STZ.w $0D80, X
    
    RTS
}

; ==============================================================================

; $035011-$03502F LOCAL JUMP LOCATION
Fairy_CheckForTemporaryUntouchability:
{
    LDA.b $11 : CMP.b #$02 : BNE .not_in_text_mode
    
    REP #$20
    
    LDA.w $1CF0 : CMP.w #$00C9 : BEQ .grant_untouchability
                CMP.w #$00CA : BNE .still_touchable
    
    .grant_untouchability
    
    SEP #$30
    
    LDA.b #$28 : STA.w $0F10, X
    
    .still_touchable
    .not_in_text_mode
    
    SEP #$30
    
    RTS
}

; ==============================================================================
