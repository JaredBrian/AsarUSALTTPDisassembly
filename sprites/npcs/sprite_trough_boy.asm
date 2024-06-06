
; ==============================================================================

; $02FF5E-$02FF65 LONG JUMP LOCATION
Sprite_TroughBoyLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_TroughBoy
    
    PLB
    
    RTL
}

; ==============================================================================

; $02FF66-$02FF9E LOCAL JUMP LOCATION
Sprite_TroughBoy:
{
    JSR TroughBoy_Draw
    JSR Sprite2_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    JSL Sprite_MakeBodyTrackHeadDirection
    
    JSR Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA $0EB0, X
    
    LDA.l $7EF3C7 : CMP.b #$03 : BCS .player_met_sahasralah
    
    ; "Hi [Name]! Elder?  Are you talking about the grandpa?"
    LDA.b #$47
    LDY.b #$01
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_converse
    
    LDA.b #$02 : STA.l $7EF3C7
    
    .didnt_converse
    
    RTS
    
    .player_met_sahasralah
    
    ; "Did you meet the grandpa? If all the bad people go away..."
    LDA.b #$48
    LDY.b #$01
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $02FF9F-$02FFDE LOCAL JUMP LOCATION
Pool_TroughBoy_Draw:
{
    .oam_groups
    dw 0, -8 : db $82, $08, $00, $02
    dw 0,  0 : db $AA, $0A, $00, $02
    
    dw 0, -8 : db $82, $08, $00, $02
    dw 0,  0 : db $AA, $0A, $00, $02
    
    dw 0, -8 : db $80, $48, $00, $02
    dw 0,  0 : db $AA, $0A, $00, $02
    
    dw 0, -8 : db $80, $08, $00, $02
    dw 0,  0 : db $AA, $0A, $00, $02
}

; ==============================================================================

; $02FFDF-$02FFFE LOCAL JUMP LOCATION
TroughBoy_Draw:
{
    LDA.b #$02 : STA $06
                 STZ $07
    
    LDA $0DE0, X : ASL #4
    
    ADC.b #(.oam_groups >> 0)              : STA $08
    LDA.b #(.oam_groups >> 8) : ADC.b #$00 : STA $09
    
    JSL Sprite_DrawMultiple.player_deferred
    JSL Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================

; $02FFFF-$02FFFF NULL
{
    fillbyte $FF
    
    fill 1
}

; ==============================================================================
