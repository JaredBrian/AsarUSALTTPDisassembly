; ==============================================================================

; Sweeping lady
; $06C4A5-$06C4AC LONG JUMP LOCATION
Sprite_SweepingLadyLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_SweepingLady
    
    PLB
    
    RTL
}

; ==============================================================================

; $06C4AD-$06C4CA LOCAL JUMP LOCATION
Sprite_SweepingLady:
{
    JSR.w SweepingLady_Draw
    JSR.w Sprite5_CheckIfActive
    
    ; "... rumors say you kidnapped the Princess, but I still trust you."
    LDA.b #$A5
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing

    JSL.l Sprite_PlayerCantPassThrough
    
    ; Next section of code simply changes her graphic index.
    
    LDA.b $1A : LSR #4 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $06C4CB-$06C4EA DATA
SweepingLady_Draw_OAM_groups:
{
    dw 0, -7 : db $8E, $00, $00, $02
    dw 0,  5 : db $8A, $00, $00, $02
    
    dw 0, -8 : db $8E, $00, $00, $02
    dw 0,  4 : db $8C, $00, $00, $02
}

; Handles appearance of sprite.
; $06C4EB-$06C50A LOCAL JUMP LOCATION
SweepingLady_Draw:
{
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DC0, X : ASL #4
    ADC.b #(.OAM_groups >> 0)              : STA.b $08
    LDA.b #(.OAM_groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
