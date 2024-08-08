
; ==============================================================================

; $02FF5E-$02FF65 LONG JUMP LOCATION
Sprite_TroughBoyLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_TroughBoy
    
    PLB
    
    RTL
}

; ==============================================================================

; $02FF66-$02FF9E LOCAL JUMP LOCATION
Sprite_TroughBoy:
{
    JSR.w TroughBoy_Draw
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    JSL.l Sprite_MakeBodyTrackHeadDirection
    
    JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    LDA.l $7EF3C7 : CMP.b #$03 : BCS .player_met_sahasralah
    
    ; "Hi [Name]! Elder?  Are you talking about the grandpa?"
    LDA.b #$47
    LDY.b #$01
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_converse
    
    LDA.b #$02 : STA.l $7EF3C7
    
    .didnt_converse
    
    RTS
    
    .player_met_sahasralah
    
    ; "Did you meet the grandpa? If all the bad people go away..."
    LDA.b #$48
    LDY.b #$01
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
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
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DE0, X : ASL #4
    
    ADC.b #(.oam_groups >> 0)              : STA.b $08
    LDA.b #(.oam_groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================

; $02FFFF-$02FFFF NULL
{
    fillbyte $FF
    
    fill 1
}

; ==============================================================================
