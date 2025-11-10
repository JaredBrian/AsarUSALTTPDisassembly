; ==============================================================================

; $0F7603-$0F7631 JUMP LOCATION
Sprite_DrinkingGuy:
{
    JSL.l DrinkingGuy_Draw
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    JSL.l GetRandomInt : BNE .dont_set_timer
        LDA.b #$20 : STA.w $0DF0, X
    
    .dont_set_timer
    
    STZ.w $0DC0, X
    
    LDA.w $0DF0, X : BEQ .not_other_animation_state
        INC.w $0DC0, X
    
    .not_other_animation_state
    
    LDA.b #$75
    LDY.b #$01
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
        STZ.w $0DC0, X
    
    .didnt_speak
    
    RTS
}

; ==============================================================================
