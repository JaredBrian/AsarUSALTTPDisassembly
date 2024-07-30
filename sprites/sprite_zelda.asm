
; ==============================================================================

; $02EBC7-$02EBCE LONG JUMP LOCATION
SpritePrep_ZeldaLong:
{
    ; Sprite Prep for Princess Zelda (0x76)
    
    PHB : PHK : PLB
    
    JSR SpritePrep_Zelda
    
    PLB
    
    RTL
}

; ==============================================================================

; $02EBCF-$02EC4B LOCAL JUMP LOCATION
SpritePrep_Zelda:
{
    LDA.l $7EF359 : CMP.b #$02 : BCS .hasMasterSword
    
    INC.w $0BA0, X
    
    JSR Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03
    
    STA.w $0EB0, X : STA.w $0DE0, X
    
    LDA.l $7EF3CC : PHA
    
    LDA.b #$01 : STA.l $7EF3CC
    
    PHX
    
    JSL Tagalong_LoadGfx
    
    PLX
    
    PLA : STA.l $7EF3CC
    
    LDA.b $A0 : CMP.b #$12 : BNE .notInSanctuary
    
    LDA.b #$02 : STA.w $0E80, X
    
    LDA.l $7EF3C6 : AND.b #$04 : BNE .been_brought_to_sanctuary_already
    
    .hasMasterSword
    
    STZ.w $0DD0D0, X
    
    RTS
    
    .been_brought_to_sanctuary_already
    
    LDA.w $0D00, X : CLC : ADC.b #$0F : STA.w $0D00, X
    LDA.w $0D20, X : ADC.b #$00 : STA.w $0D20, X
    
    LDA.w $0D10, X : CLC : ADC.b #$06 : STA.w $0D10, X
    
    LDA.b #$03 : STA.w $0F60, X
    
    RTS
    
    .notInSanctuary
    
    LDA.b #$00 : STA.w $0E80, X
    
    LDA.l $7EF3CC : CMP.b #$01 : BEQ .delta
    
    LDA.l $7EF3C6 : AND.b #$04 : BEQ .epsilon
    
    .delta
    
    STZ.w $0DD0, X
    
    .epsilon
    
    RTS
}

; ==============================================================================

; $02EC4C-$02EC8D LOCAL JUMP LOCATION
Zelda_TransitionFromTagalong:
{
    ; Transition princess Zelda back into a sprite from the tagalong
    ; state (the sage's sprite is doing this).
    
    LDA.b #$76 : JSL Sprite_SpawnDynamically
    
    PHX
    
    LDX.w $02CF
    
    LDA.w $1A64, X : AND.b #$03 : STA.w $0EB0, Y : STA.w $0DE0, Y
    
    LDA.b $20 : STA.w $0D00, Y
    LDA.b $21 : STA.w $0D20, Y
    
    LDA.b $22 : STA.w $0D10, Y
    LDA.b $23 : STA.w $0D30, Y
    
    LDA.b #$01 : STA.w $0E80, Y
    
    LDA.b #$00 : STA.l $7EF3CC
    
    LDA.w $0BA0, Y : INC A : STA.w $0BA0, Y
    
    LDA.b #$03 : STA.w $0F60, Y
    
    PLX
    
    RTS
}

; ==============================================================================

; $02EC8E-$02EC95 DATA
Pool_Sprite_Zelda:
{
    .x_speeds
    db $00, $00, $F7, $09
    
    .y_speeds
    db $F7, $09, $00, $00
}


; ==============================================================================

; $02EC96-$02EC9D LONG JUMP LOCATION
Sprite_ZeldaLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_Zelda
    
    PLB
    
    RTL
}

; ==============================================================================

; $02EC9E-$02ECBE LOCAL JUMP LOCATION
Sprite_Zelda:
{
    JSL CrystalMaiden_Draw
    JSR Sprite2_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    JSL Sprite_MakeBodyTrackHeadDirection : BCC .cant_move
    
    JSR Sprite2_Move
    
    .cant_move
    
    LDA.w $0E80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Zelda_InPrison
    dw Zelda_EnteringSanctuary
    dw Zelda_AtSanctuary
}

; ==============================================================================

; $02ECBF-$02ECD8 JUMP LOCATION
Zelda_InPrison:
{
    ; Wonder if she made a shank?
    
    JSR Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Zelda_AwaitingRescue
    dw Zelda_ApproachingPlayer
    dw Zelda_TheWizardIsBadMkay
    dw Zelda_WaitUntilPlayerPaysAttention
    dw Zelda_TransitionToTagalong
}

; ==============================================================================

; $02ECD9-$02ECF9 JUMP LOCATION
Zelda_AwaitingRescue:
{
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .player_not_close
    
    INC.w $0D80, X
    
    INC.w $02E4
    
    LDY.w $0EB0, X
    
    LDA Sprite_Zelda.x_speeds, Y : STA.w $0D50, X
    
    LDA Sprite_Zelda.y_speeds, Y : STA.w $0D40, X
    
    LDA.b #$10 : STA.w $0DF0, X
    
    .player_not_close
    
    RTS
}

; ==============================================================================

; $02ECFA-$02ED1F JUMP LOCATION
Zelda_ApproachingPlayer:
{
    LDA.w $0DF0, X : BNE .still_approaching
    
    INC.w $0D80, X
    
    ; "Thank you, [Name]. I had a feeling you were getting close."
    LDA.b #$1C
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    STZ.w $0D50, X
    STZ.w $0D40, X
    
    ; Play you saved the day durp durp music.
    LDA.b #$19 : STA.w $012C
    
    .still_approaching
    
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02ED20-$02ED2B JUMP LOCATION
Zelda_TheWizardIsBadMkay:
{
    INC.w $0D80, X
    
    ; "[Name], listen carefully. (...) Do you understand?[Scroll]"
    ; " > Yes"
    ; "   Not at all"
    ; "   ^ Yeah Zelda, I'm really dumb, this could take a while."
    LDA.b #$25
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    RTS
}

; ==============================================================================

; $02ED2C-$02ED42 JUMP LOCATION
Zelda_WaitUntilPlayerPaysAttention:
{
    LDA.w $1CE8 : BNE .sorry_zelda_wasnt_listening
    
    ; "All right, let's get out of here before the wizard notices. ..."
    LDA.b #$24
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
    
    .sorry_zelda_wasnt_listening
    
    LDA.b #$02 : STA.w $0D80, X
    
    RTS
}

; ==============================================================================

; $02ED43-$02ED68 JUMP LOCATION
Zelda_TransitionToTagalong:
{
    STZ.w $02E4
    
    LDA.b #$02 : STA.l $7EF3C8
    
    JSL SavePalaceDeaths
    
    LDA.b #$01 : STA.l $7EF3CC
    
    PHX
    
    JSL Dungeon_SaveRoomQuadrantData
    JSL Tagalong_SpawnFromSprite
    
    PLX
    
    STZ.w $0DD0, X
    
    LDA.b #$10 : STA.w $012C
    
    RTS
}

; ==============================================================================

; $02ED69-$02ED75 JUMP LOCATION
Zelda_EnteringSanctuary:
{
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Zelda_WalkTowardsPriest
    dw Zelda_RespondToPriest
    dw Zelda_BeCarefulOutThere
}

; ==============================================================================

; $02ED76-$02ED7D DATA
Pool_Zelda_WalkTowardsPriest:
{
    .timers
    db $26, $1A, $2C, $01
    
    .directions
    db $01, $03, $01, $02
}

; ==============================================================================

; $02ED7E-$02EDC3 JUMP LOCATION
Zelda_WalkTowardsPriest:
{
    LDA.w $0DF0, X : BNE .walking
    LDY.w $0D90, X : CPY.b #$04 : BCC .beta
        INC.w $0D80, X
        
        STZ.w $0DE0, X
        STZ.w $0EB0, X
        
        STZ.w $0D50, X
        STZ.w $0D40, X
        
        RTS
    
    .beta
    
    LDA .timers, Y : STA.w $0DF0, X
        
    LDA .directions, Y : STA.w $0EB0, X : STA.w $0DE0, X
        
    INC.w $0D90, X
        
    TAY
        
    LDA Sprite_Zelda.x_speeds, Y : STA.w $0D50, X
        
    LDA Sprite_Zelda.y_speeds, Y : STA.w $0D40, X
    
    .walking
    
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02EDC4-$02EDEB JUMP LOCATION
Zelda_RespondToPriest:
{
    ; "Yes, it was [Name] who helped me escape from the dungeon! ..."
    LDA.b #$1D
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    LDA.b #$02 : STA.l $7FFE01
    
    LDA.b #$01 : STA.l $7EF3C8
    
    JSL SavePalaceDeaths
    
    LDA.b #$02 : STA.l $7EF3C5
    
    PHX
    
    JSL Sprite_LoadGfxProperties.justLightWorld
    
    PLX
    
    RTS
}

; ==============================================================================

; $02EDEC-$02EE05 JUMP LOCATION
Zelda_BeCarefulOutThere:
{
    JSR Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    ; "[Name], be careful out there! I know you can save Hyrule!"
    LDA.b #$1E
    LDY.b #$00
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
    
    STA.w $0DE0, X
    STA.w $0EB0, X
    
    .didnt_speak
    
    RTS
}

; ==============================================================================

; $02EE06-$02EE0B DATA
Pool_Zelda_AtSanctuary:
{
    .messages_lower
    
    ; "[Name], be careful out there! I know you can save Hyrule!"
    ; "You should follow the marks the elder made on your map..."
    ; "... Now, you should get the Master Sword. ..."
    db $1E, $26, $27
    
    .messages_upper
    db $00, $00, $00
    
}

; ==============================================================================

; $02EE0C-$02EE4A JUMP LOCATION
Zelda_AtSanctuary:
{
    JSR Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    LDY.b #$00
    
    LDA.l $7EF374 : AND.b #$07 : CMP.b #$07 : BNE .need_moar_pendants
    
    LDY.b #$02
    
    BRA .pick_message
    
    .need_moar_pendants
    
    LDA.l $7EF3C7 : CMP.b #$03 : BCC .pick_message
    
    LDY.b #$01
    
    .pick_message
    
    LDA .messages_low, Y        : XBA
    LDA .messages_high, Y : TAY : XBA
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .no_talky_talky
    
    STA.w $0DE0, X : STA.w $0EB0, X
    
    ; Restore player health completely.
    LDA.b #$A0 : STA.l $7EF372
    
    .no_talky_talky
    
    RTS
}

; ==============================================================================

