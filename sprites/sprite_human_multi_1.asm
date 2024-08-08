
; ==============================================================================

; $06C2D1-$06C2D8 LONG JUMP LOCATION
Sprite_HumanMulti_1_Long:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_HumanMulti_1
    
    PLB
    
    RTL
}

; ==============================================================================

; $06C2D9-$06C2E5 LOCAL JUMP LOCATION
Sprite_HumanMulti_1:
{
    LDA.w $0E80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Sprite_FluteBoyFather
    dw Sprite_ThiefHideoutGuy
    dw Sprite_BlindHideoutGuy
}

; ==============================================================================

; $06C2E6-$06C307 JUMP LOCATION
Sprite_BlindHideoutGuy:
{
    JSR.w BlindHideoutGuy_Draw
    JSR.w Sprite5_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    JSL.l Sprite_MakeBodyTrackHeadDirection
    
    STZ.w $0EB0, X
    
    ; "Yo [Name]! This house used to be a hideout for a gang of thieves..."
    LDA.b #$72
    LDY.b #$01
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
    
    STA.w $0DE0, X
    STA.w $0EB0, X
    
    .didnt_speak
    
    RTS
}

; ==============================================================================

; $06C308-$06C342 JUMP LOCATION
Sprite_ThiefHideoutGuy:
{
    LDA.b $1A : AND.b #$03 : BNE .delay_head_direction_change
    
    LDA.b #$02 : STA.w $0DC0, X
    
    JSL.l Sprite_DirectionToFacePlayerLong : CPY.b #$03 : BNE .not_up
    
    LDY.b #$02
    
    .not_up
    
    TYA : STA.w $0EB0, X
    
    .delay_head_direction_change
    
    LDA.b #$0F : STA.w $0F50, X
    
    JSL.l Sprite_OAM_AllocateDeferToPlayerLong
    JSL.l Thief_Draw
    JSR.w Sprite5_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    ; "Hey kid, this is a secret hide-out for a gang of thieves! ..."
    LDA.b #$71
    LDY.b #$01
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    LDA.b #$02 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $06C343-$06C3B0 JUMP LOCATION
Sprite_FluteBoyFather:
{
    JSR.w FluteBoyFather_Draw
    JSR.w Sprite5_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.b $1A : CMP.b #$30 : BCS .dozing
    
    LDA.b #$02
    
    BRA .not_dozing
    
    .dozing
    
    ASL A : ROL A : AND.b #$01
    
    .not_dozing
    
    STA.w $0DC0, X
    
    LDA.w $0D80, X : BNE .knows_what_happened_to_son
    
    LDA.l $7EF34C : CMP.b #$02 : BCS .player_has_flute
    
    ; "... My son really liked to play the flute, ..."
    LDA.b #$A1
    LDY.b #$00
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
    
    .didnt_speak
    
    RTS
    
    .player_has_flute
    
    ; "Zzzzzzz  Zzzzzzzz ...  ...  ... Snore  Zzzzzz  Zzzzzz"
    LDA.b #$A4
    LDY.b #$00
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak_2
    
    RTS
    
    .didnt_speak_2
    
    LDA.w $0202 : CMP.b #$0D : BNE .flute_usage_undetected
    
    BIT.b $F0 : BVC .flute_usage_not_detected
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong
    
    BCC .flute_usage_not_detected
    
    ; "... Oh? This is my son's flute...! Did you meet my son? ..."
    LDA.b #$A2
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    LDA.b #$02 : STA.w $0DC0, X
    
    .flute_usage_not_detected
    
    RTS
    
    .knows_what_happened_to_son
    
    ; "... And will you play its sweet melody for the bird in the (...)?"
    LDA.b #$A3
    LDY.b #$00
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    LDA.b #$02 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $06C3B1-$06C3E0 DATA
Pool_FluteBoyFather_Draw:
{
    .oam_groups
    dw 0, -7 : db $86, $00, $00, $02
    dw 0,  0 : db $88, $00, $00, $02
    
    dw 0, -6 : db $86, $00, $00, $02
    dw 0,  0 : db $88, $00, $00, $02
    
    dw 0, -8 : db $84, $00, $00, $02
    dw 0,  0 : db $88, $00, $00, $02
}

; ==============================================================================

; $06C3E1-$06C400 LOCAL JUMP LOCATION
FluteBoyFather_Draw:
{
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DC0, X : ASL #4
    
    ADC.b #(.oam_groups >> 0)              : STA.b $08
    LDA.b #(.oam_groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================

; $06C401-$06C480 DATA
Pool_BlindHideoutGuy_Draw:
{
    .oam_groups
    dw 0, -8 : db $0C, $00, $00, $02
    dw 0,  0 : db $CA, $00, $00, $02
    
    dw 0, -8 : db $0C, $00, $00, $02
    dw 0,  0 : db $CA, $40, $00, $02
    
    dw 0, -8 : db $0C, $00, $00, $02
    dw 0,  0 : db $CA, $00, $00, $02
    
    dw 0, -8 : db $0C, $00, $00, $02
    dw 0,  0 : db $CA, $40, $00, $02
    
    dw 0, -8 : db $0E, $00, $00, $02
    dw 0,  0 : db $CA, $00, $00, $02
    
    dw 0, -8 : db $0E, $00, $00, $02
    dw 0,  0 : db $CA, $40, $00, $02
    
    dw 0, -8 : db $0E, $00, $00, $02
    dw 0,  0 : db $CA, $00, $00, $02
    
    dw 0, -8 : db $0E, $00, $00, $02
    dw 0,  0 : db $CA, $40, $00, $02
}

; ==============================================================================

; $06C481-$06C4A4 LOCAL JUMP LOCATION
BlindHideoutGuy_Draw:
{
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DE0, X : ASL A : ADC.w $0DC0, X : ASL #4
    
    ADC.b #(.oam_groups >> 0)              : STA.b $08
    LDA.b #(.oam_groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================

