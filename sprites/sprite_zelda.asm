; ==============================================================================

; Sprite Prep for Princess Zelda (0x76)
; $02EBC7-$02EBCE LONG JUMP LOCATION
SpritePrep_ZeldaLong:
{
    PHB : PHK : PLB
    
    JSR.w SpritePrep_Zelda
    
    PLB
    
    RTL
}

; ==============================================================================

; $02EBCF-$02EC4B LOCAL JUMP LOCATION
SpritePrep_Zelda:
{
    LDA.l $7EF359 : CMP.b #$02 : BCS .hasMasterSword
        INC.w $0BA0, X
        
        JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03
        
        STA.w $0EB0, X : STA.w $0DE0, X
        
        LDA.l $7EF3CC : PHA
        
        LDA.b #$01 : STA.l $7EF3CC
        
        PHX
        
        JSL.l Tagalong_LoadGfx
        
        PLX
        
        PLA : STA.l $7EF3CC
        
        LDA.b $A0 : CMP.b #$12 : BNE .notInSanctuary
            LDA.b #$02 : STA.w $0E80, X
            
            LDA.l $7EF3C6 : AND.b #$04 : BNE .been_brought_to_sanctuary_already
            
    .hasMasterSword
    
    STZ.w $0DD0, X
    
    RTS
    
    .been_brought_to_sanctuary_already
    
    LDA.w $0D00, X : CLC : ADC.b #$0F : STA.w $0D00, X
    LDA.w $0D20, X       : ADC.b #$00 : STA.w $0D20, X
    
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

; Transition princess Zelda back into a sprite from the tagalong
; state (the sage's sprite is doing this).
; $02EC4C-$02EC8D LOCAL JUMP LOCATION
Zelda_TransitionFromTagalong:
{
    LDA.b #$76 : JSL.l Sprite_SpawnDynamically
    
    PHX
    
    LDX.w $02CF
    
    LDA.w $1A64, X : AND.b #$03 : STA.w $0EB0, Y : STA.w $0DE0, Y
    
    LDA.b $20 : STA.w $0D00, Y
    LDA.b $21 : STA.w $0D20, Y
    
    LDA.b $22 : STA.w $0D10, Y
    LDA.b $23 : STA.w $0D30, Y
    
    LDA.b #$01 : STA.w $0E80, Y
    
    LDA.b #$00 : STA.l $7EF3CC
    
    LDA.w $0BA0, Y : INC : STA.w $0BA0, Y
    
    LDA.b #$03 : STA.w $0F60, Y
    
    PLX
    
    RTS
}

; ==============================================================================

; $02EC8E-$02EC95 DATA
Pool_Sprite_Zelda:
{
    ; $02EC8E
    .x_speeds
    db $00, $00, $F7, $09
    
    ; $02EC92
    .y_speeds
    db $F7, $09, $00, $00
}

; ==============================================================================

; $02EC96-$02EC9D LONG JUMP LOCATION
Sprite_ZeldaLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_Zelda
    
    PLB
    
    RTL
}

; ==============================================================================

; $02EC9E-$02ECBE LOCAL JUMP LOCATION
Sprite_Zelda:
{
    JSL.l CrystalMaiden_Draw
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    JSL.l Sprite_MakeBodyTrackHeadDirection : BCC .cant_move
        JSR.w Sprite2_Move
        
    .cant_move
    
    LDA.w $0E80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Zelda_InPrison          ; 0x00 - $ECBF
    dw Zelda_EnteringSanctuary ; 0x01 - $ED69
    dw Zelda_AtSanctuary       ; 0x02 - $EE0C
}

; ==============================================================================

; $02ECBF-$02ECD8 JUMP LOCATION
Zelda_InPrison:
{
    JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Zelda_AwaitingRescue               ; 0x00 - $ECD9
    dw Zelda_ApproachingPlayer            ; 0x01 - $ECFA
    dw Zelda_TheWizardIsBadMkay           ; 0x02 - $ED20
    dw Zelda_WaitUntilPlayerPaysAttention ; 0x03 - $ED2C
    dw Zelda_TransitionToTagalong         ; 0x04 - $ED43
}

; ==============================================================================

; $02ECD9-$02ECF9 JUMP LOCATION
Zelda_AwaitingRescue:
{
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .player_not_close
        INC.w $0D80, X
        
        INC.w $02E4
        
        LDY.w $0EB0, X
        
        LDA Sprite_Zelda_x_speeds, Y : STA.w $0D50, X
        
        LDA Sprite_Zelda_y_speeds, Y : STA.w $0D40, X
        
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
        JSL.l Sprite_ShowMessageUnconditional
        
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
    JSL.l Sprite_ShowMessageUnconditional
    
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
        JSL.l Sprite_ShowMessageUnconditional
        
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
    
    JSL.l SavePalaceDeaths
    
    LDA.b #$01 : STA.l $7EF3CC
    
    PHX
    
    JSL.l Dungeon_SaveRoomQuadrantData
    JSL.l Tagalong_SpawnFromSprite
    
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
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Zelda_WalkTowardsPriest ; 0x00 - $ED7E
    dw Zelda_RespondToPriest   ; 0x01 - $EDC4
    dw Zelda_BeCarefulOutThere ; 0x02 - $EDEC
}

; ==============================================================================

; $02ED76-$02ED7D DATA
Pool_Zelda_WalkTowardsPriest:
{
    ; $02ED76
    .timers
    db $26, $1A, $2C, $01
    
    ; $02ED7A
    .directions
    db $01, $03, $01, $02
}

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
        
        LDA.w Pool_Zelda_WalkTowardsPriest_timers, Y : STA.w $0DF0, X
            
        LDA.w Pool_Zelda_WalkTowardsPriest_directions, Y
        STA.w $0EB0, X : STA.w $0DE0, X
            
        INC.w $0D90, X
            
        TAY
            
        LDA Sprite_Zelda_x_speeds, Y : STA.w $0D50, X
        LDA Sprite_Zelda_y_speeds, Y : STA.w $0D40, X
        
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
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    LDA.b #$02 : STA.l $7FFE01
    
    LDA.b #$01 : STA.l $7EF3C8
    
    JSL.l SavePalaceDeaths
    
    LDA.b #$02 : STA.l $7EF3C5
    
    PHX
    
    JSL.l Sprite_LoadGfxProperties_justLightWorld
    
    PLX
    
    RTS
}

; ==============================================================================

; $02EDEC-$02EE05 JUMP LOCATION
Zelda_BeCarefulOutThere:
{
    JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    ; "[Name], be careful out there! I know you can save Hyrule!"
    LDA.b #$1E
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
        STA.w $0DE0, X
        STA.w $0EB0, X
        
    .didnt_speak
    
    RTS
}

; ==============================================================================

; $02EE06-$02EE0B DATA
Pool_Zelda_AtSanctuary:
{
    ; "[Name], be careful out there! I know you can save Hyrule!"
    ; "You should follow the marks the elder made on your map..."
    ; "... Now, you should get the Master Sword. ..."
    ; $02EE06
    .messages_lower
    db $1E, $26, $27
    
    ; $02EE09
    .messages_upper
    db $00, $00, $00
}

; $02EE0C-$02EE4A JUMP LOCATION
Zelda_AtSanctuary:
{
    JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    LDY.b #$00
    
    LDA.l $7EF374 : AND.b #$07 : CMP.b #$07 : BNE .need_moar_pendants
        LDY.b #$02
        
        BRA .pick_message
        
    .need_moar_pendants
    
    LDA.l $7EF3C7 : CMP.b #$03 : BCC .pick_message
        LDY.b #$01
        
    .pick_message
    
    LDA.w Pool_Zelda_AtSanctuary_messages_low, Y        : XBA
    LDA.w Pool_Zelda_AtSanctuary_messages_high, Y : TAY : XBA
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .no_talky_talky
        STA.w $0DE0, X : STA.w $0EB0, X
        
        ; Restore player health completely.
        LDA.b #$A0 : STA.l $7EF372
    
    .no_talky_talky
    
    RTS
}

; ==============================================================================
