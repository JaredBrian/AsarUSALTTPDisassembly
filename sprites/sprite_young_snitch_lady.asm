; ==============================================================================

; Scared Girl 2 (HM Name) (0x34)
; $02E2EA-$02E2F1 LONG JUMP LOCATION
Sprite_YoungSnitchLadyLong:
{
    PHB : PHK : PLB
    
    JSR.w SpriteYoungSnitchLady
    
    PLB
    
    RTL
}

; ==============================================================================

; $02E2F2-$02E2FE LOCAL JUMP LOCATION
Sprite_YoungSnitchLady:
{
    LDA.w $0D80, X : CMP.b #$02 : BCS .not_visible
        JSR.w YoungSnitchLady_Draw
    
    .not_visible
    
    JMP Sprite_Snitch
}

; ==============================================================================

; $02E2FF-$02E37E DATA
Pool_YoungSnitchLady_Draw_OAM_groups:
{
    dw 0, -8 : db $26, $00, $00, $02
    dw 0,  0 : db $E8, $00, $00, $02
    dw 0, -7 : db $26, $00, $00, $02
    dw 0,  1 : db $E8, $40, $00, $02
    dw 0, -8 : db $24, $00, $00, $02
    dw 0,  0 : db $C2, $00, $00, $02
    dw 0, -7 : db $24, $00, $00, $02
    dw 0,  1 : db $C2, $40, $00, $02
    dw 0, -8 : db $28, $00, $00, $02
    dw 0,  0 : db $E4, $00, $00, $02
    dw 0, -7 : db $28, $00, $00, $02
    dw 0,  1 : db $E6, $00, $00, $02
    dw 0, -8 : db $28, $40, $00, $02
    dw 0,  0 : db $E4, $40, $00, $02
    dw 0, -7 : db $28, $40, $00, $02
    dw 0,  1 : db $E6, $40, $00, $02
}

; $02E37F-$02E3A2 LOCAL JUMP LOCATION
YoungSnitchLady_Draw:
{
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DE0, X : ASL A : ADC.w $0DC0, X : ASL #4
    
    ADC.b #(.OAM_groups >> 0)              : STA.b $08
    LDA.b #(.OAM-groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
