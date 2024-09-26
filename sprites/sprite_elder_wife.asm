; ==============================================================================

; $02F469-$02F470 LONG JUMP LOCATION
Sprite_ElderWifeLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_ElderWife
    
    PLB
    
    RTL
}

; ==============================================================================

; Namely, I think it seems implied that this is Sahasralah's wife.
; $02F471-$02F489 LOCAL JUMP LOCATION
Sprite_ElderWife:
{
    JSR.w ElderWife_Draw
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw ElderWife_Initial                ; 0x00 - $F48A
    dw ElderWife_TellLegend             ; 0x01 - $F4B5
    dw ElderWife_LoopUntilPlayerNotDumb ; 0x02 - $F4C1
    dw ElderWife_GoAwayFindTheOldMan    ; 0x03 - $F4DB
}

; ==============================================================================

; $02F48A-$02F49E JUMP LOCATION
ElderWife_Initial:
{
    LDA.l $7EF359 : CMP.b #$02 : BCS MrsSahasrahla_DiscussMasterSword
        ; "... Oh, it's you, [Name]!What can I do for you, young man?"
        LDA.b #$2B
        LDY.b #$00
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .animate
            INC.w $0D80, X
        
        .animate

        ; Bleeds into the next function.
}
    
; $02F49F-$02F4AA JUMP LOCATION
ElderWife_UpdateAnimationState:
{
    LDA.b $1A : LSR #4 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}
    
; $02F4AB-$02F4B4 JUMP LOCATION
MrsSahasrahla_DiscussMasterSword:
{
    ; ...You've changed! You look marvelous... Please save us..."
    LDA.b #$2E
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    BRA .animate
}

; ==============================================================================

; $02F4B5-$02F4C0 JUMP LOCATION
ElderWife_TellLegend:
{
    ; Long ago, a prosperous people known as the Hylia inhabited this..."
    LDA.b #$2C
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $02F4C1-$02F4DA JUMP LOCATION
ElderWife_LoopUntilPlayerNotDumb:
{
    LDA.w $1CE8 : BNE .player_requested_repeat
        INC.w $0D80, X
        
        ; Anyway, look for the elder. There must be someone in the village..."
        LDA.b #$2D
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        RTS
        
    .player_requested_repeat
    
    ; Long ago, a prosperous people known as the Hylia inhabited this..."
    ; (Repeat of the previous message ad nauseum).
    LDA.b #$2C
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    RTS
}

; ==============================================================================

; $02F4DB-$02F4E4 JUMP LOCATION
ElderWife_GoAwayFindTheOldMan:
{
    ; Anyway, look for the elder. There must be someone in the village..."
    LDA.b #$2D
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    BRA ElderWife_UpdateAnimationState
}

; ==============================================================================

; $02F4E5-$02F504 DATA
ElderWife_Draw_oam_groups:
{
    dw 0, -5 : db $8E, $00, $00, $02
    dw 0,  5 : db $28, $00, $00, $02
    
    dw 0, -4 : db $8E, $00, $00, $02
    dw 0,  5 : db $28, $40, $00, $02
}

; $02F505-$02F520 LOCAL JUMP LOCATION
ElderWife_Draw:
{
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DC0, X : ASL #4
    
    ADC.b ((.oam_groups >> 0 & $FF))              : STA.b $08
    LDA.b ((.oam_groups >> 8 & $FF)) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    
    RTS
}

; ==============================================================================
