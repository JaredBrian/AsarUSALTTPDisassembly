
; ==============================================================================

; $034F64-$034F93 LOCAL JUMP LOCATION
Sprite_HandleDraggingByAncilla:
{
    ; The ancillae in question would most likely be the boomerang or
    ; hookshot. I can't think of any others that induce this sort of
    ; behavior.
    
    LDA $0DA0, X : BEQ .not_ancilla_slave
    
    TAY : DEY
    
    LDA $0C4A, Y : BEQ .ancilla_not_active
    
    LDA $0C04, Y : STA $0D10, X
    LDA $0C18, Y : STA $0D30, X
    
    LDA $0BFA, Y : STA $0D00, X
    LDA $0C0E, Y : STA $0D20, X
    
    STZ $0F70, X
    
    .terminate_caller
    
    PLA : PLA
    
    .not_ancilla_slave
    
    RTS
    
    .ancilla_not_active
    
    JSL Sprite_HandleAbsorptionByPlayerLong
    
    BRA .terminate_caller
}

; ==============================================================================

; $034F94-$034FBA JUMP LOCATION
Sprite_Fairy:
{
    LDA.b #$01 : STA $0BA0, X
    
    LDA $0D80, X : BNE .being_captured
    
    LDA $1B : BNE .indoors
    
    LDA.b #$30 : STA $0B89, X
    
    .indoors
    
    JSR Sprite_DrawTransientAbsorbable
    
    .being_captured
    
    JSR Fairy_CheckForTemporaryUntouchability
    JSR Sprite_CheckIfActive
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Fairy_Normal
    dw Fairy_HandleCapture
}

; ==============================================================================

; $034FBB-$034FE3 JUMP LOCATION
Fairy_Normal:
{
    LDA $0F10, X : BNE .cant_touch_this
    
    JSR Sprite_CheckDamageToPlayer : BCC .no_player_collision
    
    JSL Sprite_HandleAbsorptionByPlayerLong
    
    BRA .return
    
    .no_player_collision
    
    JSR Sprite_CheckDamageFromPlayer : BEQ .not_bugnetted
    
    INC $0D80, X
    
    ; "You caught a fairy! What will you do?"
    ; " > Keep it in a bottle..."
    LDA.b #$C9
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    RTS
    
    .return
    .not_bugnetted
    .cant_touch_this
    
    JSR Sprite_HandleDraggingByAncilla
    JSL Fairy_HandleMovementLong
    
    RTS
}

; ==============================================================================

; $034FE4-$035010 LOCAL JUMP LOCATION
Fairy_HandleCapture:
{
    LDA $1CE8 : BNE .was_released
    
    JSL Sprite_GetEmptyBottleIndex : BMI .no_empty_bottle
    
    PHX
    
    TAX
    
    LDA.b #$06 : STA $7EF35C, X
    
    JSL HUD.RefreshIconLong
    
    PLX
    
    ; Apparently indicates this bottle is full.
    STZ $0DD0, X
    
    RTS
    
    .no_empty_bottle
    
    ; "Get an empty bottle, you derpshit."
    LDA.b #$CA
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    .was_released
    
    LDA.b #$30 : STA $0F10, X
    
    STZ $0D80, X
    
    RTS
}

; ==============================================================================

; $035011-$03502F LOCAL JUMP LOCATION
Fairy_CheckForTemporaryUntouchability:
{
    LDA $11 : CMP.b #$02 : BNE .not_in_text_mode
    
    REP #$20
    
    LDA $1CF0 : CMP.w #$00C9 : BEQ .grant_untouchability
                CMP.w #$00CA : BNE .still_touchable
    
    .grant_untouchability
    
    SEP #$30
    
    LDA.b #$28 : STA $0F10, X
    
    .still_touchable
    .not_in_text_mode
    
    SEP #$30
    
    RTS
}

; ==============================================================================
