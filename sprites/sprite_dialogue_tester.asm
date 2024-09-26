; ==============================================================================

; Monologue Testing sprite (appears to be a debug artifact)
; $0F6AE7-$0F6B02 JUMP LOCATION
Sprite_DialogueTester:
{
    ; \tcrf (verified, submitted)
    ; The debug monologue sprite is intended to use the same sprite graphics
    ; as the priest, but has grey garb instead of blue, and he doesn't
    ; face the player. His direction is calculated from the current message
    ; he will say modulo 4. Contrary to what has been claimed, this sprite
    ; has no selection menu, that's just a misconception based on some of
    ; the first messages he says after being initialized.
    
    JSL.l Priest_Draw
    JSR.w Sprite3_CheckIfActive
    
    ; Next set up the graphics state for next frame?
    
    LDA.w $0D90, X : AND.b #$03 : STA.w $0DE0, X
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw DialogueTester_Initialize            ; 0x00 - $EB03
    dw DialogueTester_ShowMessage           ; 0x01 - $EB0C
    dw DialogueTester_IncrementMessageIndex ; 0x02 - $EB1C
}

; ==============================================================================

; $0F6B03-$0F6B0B JUMP LOCATION
DialogueTester_Initialize:
{
    ; Set it to the 0th text message.
    STZ.w $0D90, X
    STZ.w $0DA0, X
    
    INC.w $0D80, X

    ; Bleeds into the next function.
}
    
; $0F6B0C-$0F6B1B ALTERNATE ENTRY POINT
DialogueTester_ShowMessage:
{
    LDA.w $0D90, X
    LDY.w $0DA0, X
    
    JSL.l Sprite_ShowMessageFromPlayerContact : BCC .didnt_speak
        INC.w $0D80, X
    
    .didnt_speak
    
    RTS
}

; ==============================================================================

; $0F6B1C-$0F6B32 JUMP LOCATION
DialogueTester_IncrementMessageIndex:
{
    ; Move to the next message.
    LDA.w $0D90, X : CLC : ADC.b #$01 : STA.w $0D90, X
    LDA.w $0DA0, X       : ADC.b #$00 : STA.w $0DA0, X
    
    LDA.b #$01 : STA.w $0D80, X
    
    RTS
}

; ==============================================================================
