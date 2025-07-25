; ==============================================================================

; $02DA29-$02DA30 LONG JUMP LOCATION
SpritePrep_UncleAndSageLong:
{
    PHB : PHK : PLB
    
    JSR.w SpritePrep_UncleAndSage
    
    PLB
    
    RTL
}

; ==============================================================================

; $02DA31-$02DA3C DATA
Pool_SpritePrep_UncleAndSage:
{
    ; $02DA31
    .x_offsets
    dw -6, -6, -6
    
    ; $02DA37
    .y_offsets
    dw  0, -9,  0
}

; $02DA3D-$02DB22 LOCAL JUMP LOCATION
SpritePrep_UncleAndSage:
{
    LDA.b $A0 : CMP.b #$12 : BEQ .in_sanctuary
        JMP .not_sage
        
    .in_sanctuary
    
    JSR.w Sage_SpawnMantle
    
    LDA.l $7EF3C5 : CMP.b #$03 : BCC .agahnim_not_defeated
        LDA.l $7EF3C6 : ORA.b #$02 : STA.l $7EF3C6
        
    .agahnim_not_defeated
    
    LDA.l $7EF3C6 : AND.b #$02 : BEQ .priest_not_already_dead
        STZ.w $0DD0, X
        
        RTS
    
    .priest_not_already_dead
    
    LDA.b #$01 : STA.w $0E90, X
    
    LDA.w $0E40, X : AND.b #$F0 : ORA.b #$02 : STA.w $0E40, X
    
    LDA.b #$03 : STA.w $0F60, X
    
    LDA.l $7EF359 : CMP.b #$02 : BCC .dontHaveMasterSword
        LDA.b #$04 : STA.w $0DE0, X
        
        STZ.w $0DC0, X
        
        LDA.b #$00
        
        BRA .epsilon
    
    .dontHaveMasterSword
    
    JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03
    
    STA.w $0EB0, X : STA.w $0DE0, X
    
    LDA.l $7EF3CC : CMP.b #$01 : BNE .iota
        LDA.l $7EF3C6 : ORA.b #$04 : STA.l $7EF3C6
        LDA.l $7EF29B : ORA.b #$20 : STA.l $7EF29B
        
        LDA.b #$AA : STA.w $0DF0, X
        
        LDA.b #$01
        
        BRA .epsilon
        
    .iota
    
    LDA.b #$02
    
    .epsilon
    
    STA.w $0E80, X
    
    ASL : TAY
    LDA.w .x_offsets+0, Y : CLC : ADC.w $0D10, X : STA.w $0D10, X
    LDA.w .x_offsets+1, Y       : ADC.w $0D30, X : STA.w $0D30, X
    
    LDA.w .y_offsets+0, Y : CLC : ADC.w $0D00, X : STA.w $0D00, X
    LDA.w .y_offsets+1, Y       : ADC.w $0D20, X : STA.w $0D20, X
    
    INC.w $0BA0, X
    
    LDA.b #$00 : STA.l $7FFE01
    
    RTS
    
    .not_sage
    
    CMP.b #$04 : BNE .not_in_links_house
        ; Has your Uncle left to go get owned by two measley low rank green
        ; soldiers?
        LDA.l $7EF3C6 : AND.b #$10 : BNE .self_terminate
            LDA.w $0D10, X : CLC : ADC.b #$08 : STA.w $0D10, X
            
            RTS
            
    .not_in_links_house
    
    ; Poor dying bastard already gave you his gear?
    LDA.l $7EF3C6 : AND.b #$01 : BNE .self_terminate
        LDA.b #$03 : STA.w $0DE0, X
        LSR        : STA.w $0E80, X
        
        RTS
        
    .self_terminate
    
    STZ.w $0DD0, X
    
    RTS
}

; ==============================================================================

; $02DB23-$02DB26 DATA
Pool_Sage_SpawnMantle:
{
    ; $02DB23
    .x_coord
    dw $04F0
    
    ; $02DB25
    .y_coord
    dw $0237
}

; $02DB27-$02DB85 LOCAL JUMP LOCATION
Sage_SpawnMantle:
{
    INC.w $0DDF
    
    ; Create Sage... actually create the mantle behind him.
    LDA.b #$73
    JSL.l Sprite_SpawnDynamically
    
    STZ.w $0DDF
    
    LDA.w $0E40, Y : AND.b #$F0 : ORA.b #$03 : STA.w $0E40, Y
    
    LDA.w Pool_Sage_SpawnMantle_x_coord+0 : STA.w $0D10, Y
    LDA.w Pool_Sage_SpawnMantle_x_coord+1 : STA.w $0D30, Y
    
    LDA.w Pool_Sage_SpawnMantle_y_coord+0 : STA.w $0D00, Y
    LDA.w Pool_Sage_SpawnMantle_y_coord+1 : STA.w $0D20, Y
    
    LDA.b #$02 : STA.w $0E90, Y
    LDA.b #$0B : STA.w $0F60, Y
    
    LDA.w $0CAA, Y : ORA.b #$20 : STA.w $0CAA, Y
    
    LDA.b #$01 : STA.w $0E80, Y
    
    LDA.w $0D00, Y : STA.b $00
    LDA.w $0D20, Y : STA.b $01
    
    REP #$30
    
    LDA.b $20 : CMP.b $00 : SEP #$30 : BCS .player_below_mantle
        ; Otherwise initialize it as moving to the right (opening up).
        LDA.b #$01 : STA.w $0DB0, Y
        
    .player_below_mantle
    
    RTS
}

; ==============================================================================

; Uncle / Priest
; $02DB86-$02DB8D LONG JUMP LOCATION
Sprite_UncleAndSageLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_UncleAndSage
    
    PLB
    
    RTL
}

; ==============================================================================

; $02DB8E-$02DB9A LOCAL JUMP LOCATION
Sprite_UncleAndSage:
{
    LDA.w $0E90, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Sprite_Uncle  ; 0x00 - $DE2C
    dw Sprite_Sage   ; 0x01 - $DCE6
    dw Sprite_Mantle ; 0x02 - $DB9B
}

; ==============================================================================

; $02DB9B-$02DBBA JUMP LOCATION
Sprite_Mantle:
{
    JSR.w Mantle_Draw
    JSR.w Sprite2_CheckIfActive
    
    LDA.w $0DB0, X : BNE Mantle_SlidingRight
        JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC Mantle_NoPlayerCollision
            JSL.l Sprite_NullifyHookshotDrag
            
            STZ.b $5E
            
            JSL.l Sprite_RepelDashAttackLong
            
            LDA.b #$07 : STA.w $0E00, X

            ; Bleeds into the next function.

}
            
; $02DBBB-$02DBD2 JUMP LOCATION
Mantle_RecentPlayerContact:
{        
    STZ.w $0E80, X
            
    LDA.b #$81 : STA.b $48
            
    LDA.b #$08 : STA.b $5E
            
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw SanctuaryMantle_AttemptCutscene ; 0x00 - $DC00
    dw SanctuaryMantle_InitializeSlide ; 0x01 - $DC39
    dw SanctuaryMantle_SlideToTheRight ; 0x02 - $DC52
}

; ==============================================================================

; $02DBD3-$02DBE2 BRANCH LOCATION
Mantle_NoPlayerCollision:
{
    LDA.w $0E00, X : BNE Mantle_RecentPlayerContact
        LDA.w $0E80, X
        JSL.l UseImplicitRegIndexedLocalJumpTable
        dw SanctuaryMantle_ResetGrabAndSpeed ; 0x00 - $DBF5
        dw Mantle_DoNothing                  ; 0x01 - $DBFF
}

; ==============================================================================

; $02DBE3-$02DBF4 BRANCH LOCATION
Mantle_SlidingRight:
{
    LDA.b #$40 : STA.w $0D90, X
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw SanctuaryMantle_AttemptCutscene ; 0x00 - $DC00
    dw SanctuaryMantle_InitializeSlide ; 0x01 - $DC39
    dw SanctuaryMantle_SlideToTheRight ; 0x02 - $DC52
}

; ==============================================================================

; $02DBF5-$02DBFE JUMP LOCATION
SanctuaryMantle_ResetGrabAndSpeed:
{
    STZ.w $0D90, X
    
    STZ.b $48
    
    STZ.b $5E
    
    INC.w $0E80, X

    ; Bleeds into the next function.
}
    
; $02DBFF-$02DBFF JUMP LOCATION
Mantle_DoNothing:
{
    RTS
}

; ==============================================================================

; $02DC00-$02DC38 JUMP LOCATION
SanctuaryMantle_AttemptCutscene:
{
    LDA.w $0D10, X : PHA : CLC : ADC.b #$13 : STA.w $0D10, X
    LDA.w $0D30, X : PHA       : ADC.b #$00 : STA.w $0D30, X
    
    JSR.w Sprite2_DirectionToFacePlayer
    
    PLA : STA.w $0D30, X
    PLA : STA.w $0D10, X
    
    CPY.b #$03 : BEQ .alpha
        CPY.b #$01 : BNE .beta
    
    .alpha
    
    INC.w $0D90, X
    
    LDA.w $0D90, X : CMP.b #$40 : BCC .beta
        INC.w $0D80, X
        
        LDA.b #$01 : STA.w $02E4
    
    .beta
    
    RTS
}

; ==============================================================================

; $02DC39-$02DC51 JUMP LOCATION
SanctuaryMantle_InitializeSlide:
{
    LDA.b #$18 : JSL.l Sound_SetSfx3PanLong
    
    INC.w $0D80, X
    
    LDA.b #$A8 : STA.w $0DF0, X
    
    LDA.b #$03 : STA.w $0D50, X
    
    LDA.b #$02 : STA.w $0E00, X
    
    RTS
}

; ==============================================================================

; $02DC52-$02DC69 JUMP LOCATION
SanctuaryMantle_SlideToTheRight:
{
    JSR.w Sprite2_Move
    
    LDA.w $0DF0, X : BNE .alpha
        STZ.w $02E4
        
        STZ.w $0D50, X
        STZ.w $0DB0, X
        
        RTS
        
    .alpha
    
    LDA.b #$02 : STA.w $0E00, X
    
    RTS
}

; ==============================================================================

; $02DC6A-$02DC89 DATA
Mantle_Draw_animation_states:
{
    db  0,  0 : db $2C, $16, $00, $02
    db 16,  0 : db $2C, $56, $00, $02
    db  0, 16 : db $2E, $06, $00, $02
    db 16, 16 : db $2E, $46, $00, $02
}

; $02DC8A-$02DCA1 LOCAL JUMP LOCATION
Mantle_Draw:
{
    ; $2DC6A
    LDA.b (.animation_states >> 0) : STA.b $08
    LDA.b (.animation_states >> 8) : STA.b $09
    
    LDA.w $0DB0, X : BNE .moving
        LDA.b #$10 : JSL.l OAM_AllocateFromRegionB
        
    .moving
    
    LDA.b #$04
    
    JMP Sprite_DrawMultipleRedundantCall
}

; ==============================================================================

; $02DCA2-$02DCDD LONG JUMP LOCATION
Sprite_MakeBodyTrackHeadDirection:
{
    LDA.w $0DE0, X : CMP.w $0EB0, X : BEQ .set_body_to_head_dir
        LDA.b $1A : AND.b #$1F : BNE .frame_not_multiple_of_32
            ; If only one of them is facing left or right, make the body match.
            LDA.w $0DE0, X : EOR.w $0EB0, X : AND.b #$02 : BNE .set_body_to_head_dir
                ; This seems like an attempt to semi-randomly set the body
                ; orientation to left or right, possibly to recover from an
                ; unusual state?
                TXA : EOR.b $1A : LSR #5 : ORA.b #$02 : AND.b #$03 : STA.w $0DE0, X
                
                ; If the head is facing up or down, this has no effect.
                ; Otherwise, it will force the body to a direction perpendicular
                ; to the head.
                LDA.w $0EB0, X : AND.b #$02 : EOR.w $0DE0, X : STA.w $0DE0, X
                
        .frame_not_multiple_of_32
        
        CLC
        
        RTL
        
    .set_body_to_head_dir
    
    LDA.w $0EB0, X : STA.w $0DE0, X
    
    SEC
    
    RTL
}

; ==============================================================================

; UNUSED:
; $02DCDE-$02DCE5 DATA (UNUSED)
UNUSED_05DCDE:
{
    db $00, $00, $F7, $09, $F7, $09, $00, $00
}

; ==============================================================================

; $02DCE6-$02DD09 JUMP LOCATION
Sprite_Sage:
{
    LDA.w $0D90, X : BNE .dont_draw
        JSL.l Priest_Draw
    
    .dont_draw
    
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    JSL.l Sprite_MakeBodyTrackHeadDirection
    JSR.w Sprite2_Move
    
    LDA.w $0E80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Sage_MortallyWounded     ; 0x00 - $DD0A
    dw Priest_RunRescueCutscene ; 0x01 - $DD63
    dw Priest_Chillin           ; 0x02 - $DDE5
}

; ==============================================================================

; $02DD0A-$02DD1E JUMP LOCATION
Sage_MortallyWounded:
{
    LDA.b #$04 : STA.w $0EB0, X : STA.w $0DE0, X
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Sage_DyingWords ; 0x00 - $DD1F
    dw Sage_DeathFlash ; 0x00 - $DD3F
    dw Sage_Terminate  ; 0x00 - $DD5F
}

; ==============================================================================

; $02DD1F-$02DD3E JUMP LOCATION
Sage_DyingWords:
{
    ; "You are a second too late... I have failed..." message from dying priest.
    LDA.b #$1B
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .textNotTriggered
        INC.w $0D80, X
        
        INC.w $0DC0, X
        
        LDA.l $7EF3C6 : ORA.b #$02 : STA.l $7EF3C6
        
        LDA.b #$80 : STA.w $0E10, X
    
    .textNotTriggered
    
    RTS
}

; ==============================================================================

; Because we all know people flash when they die, right?
; $02DD3F-$02DD5E JUMP LOCATION
Sage_DeathFlash:
{
    STZ.w $0DC0, X
    
    LDA.w $0E10, X : BNE .wait
        INC.w $0D80, X
    
    .wait
    
    ; Only draw the sprite every other frame (because he's dying).
    LDA.b $1A : AND.b #$02 : STA.w $0D90, X
    
    LDA.w $0E10, X : AND.b #$07 : BNE .dont_play_sound
        LDA.b #$33 : JSL.l Sound_SetSfx2PanLong
        
    .dont_play_sound
    
    RTS
}

; ==============================================================================

; Well this is pretty pointless, why didn't we just kill him off
; in the previous AI state?
; $02DD5F-$02DD62 JUMP LOCATION
Sage_Terminate:
{
    STZ.w $0DD0, X
    
    RTS
}

; ==============================================================================

; $02DD63-$02DD71 JUMP LOCATION
Priest_RunRescueCutscene:
{
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Priest_WelcomeToSanctuary ; 0x00 - $DD72
    dw Priest_WaitForZelda       ; 0x01 - $DD9F
    dw Priest_MoreTalking        ; 0x02 - $DDB3
    dw Priest_OfferKisses        ; 0x03 - $DDC5
}

; ==============================================================================

; $02DD72-$02DD9E JUMP LOCATION
Priest_WelcomeToSanctuary:
{
    LDA.b #$00 : STA.w $0EB0, X : STA.w $0DE0, X
    
    LDA.w $0DF0, X : BNE .alpha
        ; "Princess Zelda, you are safe! Is this your doing, [Name]?" message
        LDA.b #$17
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        INC.w $0D80, X
        
        LDA.b #$01 : STA.l $7FFE01
        
        JSR.w Zelda_TransitionFromTagalong
        
        LDA.b #$01 : STA.w $02E4
        
        LDA.b #$01 : STA.l $7EF3C7
    
    .alpha
    
    RTS
}

; ==============================================================================

; $02DD9F-$02DDB2 JUMP LOCATION
Priest_WaitForZelda:
{
    LDA.l $7FFE01 : CMP.b #$02 : BNE .alpha
        ; "I sense that a mighty force guides the wizard's actions an
        LDA.b #$18
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        INC.w $0D80, X
    
    .alpha
    
    RTS
}

; ==============================================================================

; $02DDB3-$02DDC4 JUMP LOCATION
Priest_MoreTalking:
{
    LDA.w $1CE8 : BNE .alpha
        INC.w $0D80, X
        
        STZ.w $02E4
        
        RTS
    
    .alpha
    
    LDA.b #$01 : STA.w $0D80, X
    
    RTS
}

; ==============================================================================

; $02DDC5-$02DDDE JUMP LOCATION
Priest_OfferKisses:
{
    JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    LDA.b #$16
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .alpha
        ; "Meet the elder of the village and get the master sword" message
        STA.w $0DE0, X
        STA.w $0EB0, X
    
    .alpha
    
    RTS
}

; ==============================================================================

; $02DDDF-$02DDE4 DATA
Pool_Priest_Chillin:
{
    ; $02DDDF
    .messages_low
    db $16, $19, $1A
    
    ; $02DDE2
    .messages_high
    db $00, $00, $00
}

; $02DDE5-$02DE23 JUMP LOCATION
Priest_Chillin:
{
    JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    LDY.b #$00
    
    LDA.l $7EF374 : AND.b #$07 : CMP.b #$07 : BNE .need_moar_pendants
        LDY.b #$02
        
        BRA .beta
    
    .need_moar_pendants
    
    LDA.l $7EF3C7 : CMP.b #$03 : BCC .beta
        LDY.b #$01
    
    .beta
    
    LDA.w Pool_Priest_Chillin_messages_low, Y        : XBA
    LDA.w Pool_Priest_Chillin_messages_high, Y : TAY : XBA
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .gamma
        STA.w $0DE0, X
        STA.w $0EB0, X
        
        LDA.b #$A0 : STA.l $7EF372
        
    .gamma
    
    RTS
}

; ==============================================================================

; $02DE24-$02DE2B DATA
Pool_Uncle_LeavingHouse:
{
    ; $02DE24
    .x_speeds
    db $00, $00, $F4, $0C
    
    ; $02DE28
    .y_speeds
    db $F4, $0C, $00, $00
}

; ==============================================================================

; $02DE2C-$02DE3D JUMP LOCATION
Sprite_Uncle:
{
    JSL.l Uncle_Draw
    JSR.w Sprite2_CheckIfActive
    
    LDA.w $0E80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Uncle_AtHome          ; 0x00 - $DE3E
    dw Uncle_InSecretPassage ; 0x01 - $DF19
}

; ==============================================================================

; $02DE3E-$02DE51 JUMP LOCATION
Uncle_AtHome:
{
    JSR.w Sprite2_Move
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Uncle_TelepathicZeldaPlea         ; 0x00 - $DE52
    dw Uncle_WakeUpPlayer                ; 0x01 - $DE72
    dw Uncle_TellPlayerToStay            ; 0x02 - $DE9A
    dw Uncle_LeavingHouse                ; 0x03 - $DEB4
    dw Uncle_AttachZeldaTelepathTagalong ; 0x04 - $DEF8
}

; ==============================================================================

; $02DE52-$02DE71 JUMP LOCATION
Uncle_TelepathicZeldaPlea:
{
    ; Set Link's coordinates to this specific position.
    LDA.b #$40 : STA.w $0FC2
    LDA.b #$09 : STA.w $0FC3
    
    LDA.b #$5A : STA.w $0FC4
    LDA.b #$21 : STA.w $0FC5
    
    ; "Help me... Please help me...  I am a prisoner in the dungeon of the
    ; castle..."
    LDA.b #$1F
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; Lighten the screen gradually and then wake Link up partially.
; $02DE72-$02DE99 JUMP LOCATION
Uncle_WakeUpPlayer:
{
    LDA.b $1A : AND.b #$03 : BNE .delay
        LDA.b $9C : CMP.b #$20 : BEQ .colorTargetReached
            DEC.b $9C
            DEC.b $9D
    
    .delay
    
    RTS
    
    .colorTargetReached
    
    INC.w $0D80, X
    
    INC.w $037D
    INC.w $037C
    
    LDA.b #$57 : STA.b $20
    LDA.b #$21 : STA.b $21
    
    LDA.b #$01 : STA.w $02E4
    
    RTS
}

; ==============================================================================

; $02DE9A-$02DEAF JUMP LOCATION
Uncle_TellPlayerToStay:
{
    ; [Name], I'm going out for a while. I'll be back by morning..." message
    LDA.b #$0D
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    ; Play music.
    LDA.b #$03 : STA.w $012C
    
    LDA.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02DEB0-$02DEB3 DATA
Pool_Uncle_LeavingHouse2:
{
    ; $02DEB0
    .timers
    db $40, $E0
    
    ; $02DEB2
    .directions
    db 2, 1
}

; $02DEB4-$02DEF7 JUMP LOCATION
Uncle_LeavingHouse:
{
    LDA.w $0DF0, X : BNE .moving
        LDY.w $0D90, X : BNE .already_stood_up
            ; Do a one time y coord adjustment that basically is your uncle
            ; standing up to leave.
            LDA.w $0D00, X : SEC : SBC #$02 : STA.w $0D00, X
            
        .already_stood_up
        
        LDA.w Pool_Uncle_LeavingHouse2_timers, Y : STA.w $0DF0, X
        
        LDA.w Pool_Uncle_LeavingHouse2_directions, Y : STA.w $0DE0, X : TAY
        
        LDA.w Pool_Uncle_LeavingHouse_x_speeds, Y : STA.w $0D50, X
        LDA.w Pool_Uncle_LeavingHouse_y_speeds, Y : STA.w $0D40, X
        
        INC.w $0D90, X
        
        ; BUG: Confirmed that this is a bug in that it reads past the end of its
        ; designated arrays (.timer, .directions, .x_speeds, .y_speeds) by one
        ; right before the Uncle sprite self terminates. Other than that, it
        ; shouldn't have any negative impact. I'd recommend rewriting it to
        ; avoid this problem, though.
        LDA.w $0D90, X : CMP.b #$03 : BNE .hasnt_fully_left_yet
            INC.w $0D80, X

        .hasnt_fully_left_yet
    .moving

    ; Change animation state every 8 frames...
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02DEF8-$02DF18 JUMP LOCATION
Uncle_AttachZeldaTelepathTagalong:
{
    ; Sets up Zelda to yell at you to get into the castle.
    LDA.b #$05 : STA.l $7EF3CC
    
    LDA.b #$F3 : STA.w $02CD
    LDA.b #$0D : STA.w $02CE
    
    ; Make it so Link's uncle never respawns in the house again.
    LDA.l $7EF3C6 : ORA.b #$10 : STA.l $7EF3C6
    
    STZ.w $0DD0, X
    
    STZ.w $02E4
    
    RTS
}

; ==============================================================================

; $02DF19-$02DF25 JUMP LOCATION
Uncle_InSecretPassage:
{
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Uncle_RemoveZeldaTelepathTagalong ; 0x00 - $DF26
    dw Uncle_GiveSwordAndShield          ; 0x01 - $DF44
    dw Uncle_PassedOut                   ; 0x02 - $DF43
}

; ==============================================================================

; $02DF26-$02DF43 JUMP LOCATION
Uncle_RemoveZeldaTelepathTagalong:
{
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .player_not_close
        JSL.l Player_HaltDashAttackLong
    
    .player_not_close
    
    ; "Unnh... [Name], I didn't want you involved in this..."
    LDA.b #$0E
    LDY.b #$00
    JSL.l Sprite_ShowMessageFromPlayerContact : BCC .player_not_close_2
        ; Your Uncle frees you from Zelda's haunting.
        LDA.b #$00 : STA.l $7EF3CC
        
        INC.w $0D80, X
    
    .player_not_close_2

    ; Bleeds into the next function.
}

; $02DF43-$02DF43 LOCAL JUMP LOCATION
Uncle_PassedOut:
{ 
    RTS
}

; ==============================================================================

; $02DF44-$02DF6B JUMP LOCATION
Uncle_GiveSwordAndShield:
{
    LDY.b #$00
    STZ.w $02E9
    JSL.l Link_ReceiveItem
    
    INC.w $0D80, X
    
    LDA.b #$01 : STA.w $0DC0, X
    
    LDA.b #$03 : STA.l $7EF3C8
    
    LDA.l $7EF3C6 : ORA.b #$01 : STA.l $7EF3C6
    
    LDA.b #$01 : STA.l $7EF3C5
    
    RTS
}

; ==============================================================================
