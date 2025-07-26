; ==============================================================================

; $03394C-$033961 JUMP LOCATION
Sprite_BugNetKid:
{
    JSL.l BugNetKid_Draw
    JSR.w Sprite_CheckIfActive
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw BugNetKid_Resting       ; 0x00 - $B962
    dw BugNetKid_PerkUp        ; 0x01 - $B9A0
    dw BugNetKid_GrantBugNet   ; 0x02 - $B9C6
    dw BugNetKid_BackToResting ; 0x03 - $B9C6
}

; ==============================================================================

; $033962-$033990 JUMP LOCATION
BugNetKid_Resting:
{
    JSL.l Sprite_CheckIfPlayerPreoccupied : BCS .dont_awaken
        JSR.w Sprite_CheckDamageToPlayer_same_layer : BCC .dont_awaken
            LDA.l $7EF35C : ORA.l $7EF35D : ORA.l $7EF35E : ORA.l $7EF35F
            CMP.b #$02 : BCC .gotsNoBottles
                INC.w $0D80, X
                
                INC.w $02E4
        
    .dont_awaken
    
    RTS
    
    .gotsNoBottles
    
    ; "... Do you have a bottle to keep a bug in? ... I see. You don't..."
    LDA.b #$04
    LDY.b #$01
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $033991-$03399F DATA
Pool_BugNetKid_PerkUp:
{
    ; $033991
    .animation_states
    db 0,  1,  0,  1, 0, 1, 2, 255
    
    ; $033999
    .delay_timers
    db 8, 12, 8, 12, 8, 96, 16
}

; $0339A0-$0339C5 JUMP LOCATION
BugNetKid_PerkUp:
{
    LDA.w $0DF0, X : BNE .delay
        LDY.w $0D90, X
        LDA.w Pool_BugNetKid_PerkUp_animation_states, Y : BMI .invalid_animation_state
            STA.w $0DC0, X
            
            LDA.w Pool_BugNetKid_PerkUp_delay_timers, Y : STA.w $0DF0, X
            
            INC.w $0D90, X
    
    .delay
    
    RTS
    
    .invalid_animation_state
    
    ; "I can't go out 'cause I'm sick. ... This is my bug catching net..."
    LDA.b #$05
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $0339C6-$0339D7 JUMP LOCATION
BugNetKid_GrantBugNet:
{
    ; Give Link the Bug catching net.
    LDY.b #$21
    
    STZ.w $02E9
    
    PHX
    
    JSL.l Link_ReceiveItem
    
    PLX
    
    INC.w $0D80, X
    
    STZ.w $02E4
    
    RTS
}

; ==============================================================================

; $0339D8-$0339E5 JUMP LOCATION
BugNetKid_BackToResting:
{
    LDA.b #$01 : STA.w $0DC0, X
    
    ; "Sniffle... I hope I get well soon. Cough cough."
    LDA.b #$06
    LDY.b #$01
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================
