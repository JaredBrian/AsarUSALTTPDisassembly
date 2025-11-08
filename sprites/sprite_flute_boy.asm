; ==============================================================================

; Flute Boy's Code
; $032F3B-$032F45 JUMP LOCATION
Sprite_FluteBoy:
{
    LDA.w $0EB0, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw FluteBoy_Humanoid ; 0x00 - $AF46
    dw Sprite_FluteNote  ; 0x01 - $B173
}

; ==============================================================================

; $032F46-$032F50 JUMP LOCATION
FluteBoy_Humanoid:
{
    ; In this situation, determines light world / darkworld behavior.
    LDA.w $0E80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw FluteBoy_HumanForm   ; 0x00 - $AF51
    dw Sprite_FluteAardvark ; 0x01 - $B040
}

; ==============================================================================

; $032F51-$032F92 JUMP LOCATION
FluteBoy_HumanForm:
{
    LDA.w $0D80, X : CMP.b #$03 : BEQ .invisible
        JSL.l FluteBoy_Draw
        
        ; What exactly is going on here...?
        LDA.b $01 : ORA.b $03 : STA.w $0DB0, X
        
    .invisible
    
    JSR.w Sprite_CheckIfActive
    
    LDA.w $0DB0, X : BNE .delay_playing_flute_ditty
        LDA.w $0DA0, X : BNE .delay_playing_flute_ditty
            LDA.b #$0B : STA.w $012D
                         STA.w $0DA0, X
            
    .delay_playing_flute_ditty
    
    LDA.b $1A : LSR #5 : AND.b #$01 : STA.w $0DC0, X
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw FluteBoy_Chillin        ; 0x00 - $AF93
    dw FltueBoy_PrepPhaseOut   ; 0x01 - $AFC1
    dw FluteBoy_PhaseOut       ; 0x02 - $AFF2
    dw FluteBoy_FullyPhasedOut ; 0x03 - $B008
}

; ==============================================================================

; $032F93-$032FC0 JUMP LOCATION
FluteBoy_Chillin:
{
    LDA.l $7EF34C : CMP.b #$02 : BCS .player_has_flute
        JSR.w FluteBoy_CheckIfPlayerTooClose : BCS .player_not_too_close
    
    .player_has_flute
    
    INC.w $0D80, X
    
    INC.w $0DE0, X
    
    ; TODO: Why increment this? What effect does it have?
    INC.w $0FDD
    
    LDA.b #$B0 : STA.w $0DF0, X
    
    ; Halt player because he got too close. Flute boy is zapping out.
    LDA.b #$01 : STA.w $02E4
    
    .player_not_too_close
    
    LDA.w $0DF0, X : BNE .spawn_note_delay
        LDA.b #$19 : STA.w $0DF0, X
        
        JSR.w FluteBoy_SpawnFluteNote
        
    .spawn_note_delay
    
    RTS
}

; ==============================================================================

; $032FC1-$032FF1 JUMP LOCATION
FltueBoy_PrepPhaseOut:
{
    LDA.b #$01 : STA.w $02E4
    
    LDA.w $0DF0, X : BNE .delay
        LDA.b #$02 : STA.b $1D
        
        LDA.b #$30 : STA.b $9A
        
        LDA.b #$00 : STA.l $7EC007
                     STA.l $7EC009
        
        PHX
        
        JSL.l Palette_AssertTranslucencySwap
        
        PLX
        
        INC.w $0D80, X
        
        ; .... What? TODO: Does this quiet SFX1 down?
        LDA.b #$80 : STA.w $012D
        
        LDA.b #$33
        JSL.l Sound_SetSFX2PanLong
    
    .delay
    
    RTS
}

; ==============================================================================

; $032FF2-$033007 JUMP LOCATION
FluteBoy_PhaseOut:
{
    LDA.b $1A : AND.b #$0F : BNE .onlyEvery16Frames
        PHX
        
        JSL.l Palette_Filter_SP5F
        
        PLX
        
        LDA.l $7EC007 : BNE .filteringNotDone
            INC.w $0D80, X

        .filteringNotDone
    
    .onlyEvery16Frames
    
    RTS
}

; ==============================================================================

; $033008-$033018 JUMP LOCATION
FluteBoy_FullyPhasedOut:
{
    PHX
    
    JSL.l Palette_Restore_SP5F
    JSL.l Palette_RevertTranslucencySwap
    
    PLX
    
    STZ.w $0DD0, X
    
    STZ.w $02E4
    
    RTS
}`

; ==============================================================================

; $033019-$03303F DATA
Pool_FluteAardvark_Arborating:
{
    ; $033019
    .animation_states
    db $01, $01, $01, $01, $02, $01, $02, $01
    db $02, $01, $02, $03, $02, $03, $02, $03
    db $02, $03, $02, $FF
    
    ; $03302D
    .timers
    db $FF, $FF, $FF, $10, $02, $0C, $06, $08
    db $0A, $04, $0E, $02, $0A, $06, $06, $0A
    db $02, $0E, $02    
}

; ==============================================================================

; $033040-$033059 JUMP LOCATION
Sprite_FluteAardvark:
{
    JSL.l FluteAardvark_Draw
    JSR.w Sprite_CheckIfActive
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw FluteAardvark_InitialStateFromFluteState  ; 0x00 - $B05A
    dw FluteAardvark_ReactToSupplicationResponse ; 0x01 - $B09E
    dw FluteAardvark_GrantShovel                 ; 0x02 - $B0BB
    dw FluteAardvark_WaitForPlayerMusic          ; 0x03 - $B0CA
    dw FluteAardvark_Arborating                  ; 0x04 - $B0E9
    dw FluteAardvark_FullyArborated              ; 0x05 - $B11E
}

; ==============================================================================

; $03305A-$03306B JUMP LOCATION
FluteAardvark_InitialStateFromFluteState:
{
    ; Flute
    LDA.l $7EF34C : AND.b #$03
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw FluteAardvark_Supplicate         ; 0x00 - $B06C
    dw FluteAardvark_GetMeMyFlute       ; 0x01 - $B07A
    dw FluteAardvark_ThanksButYouKeepIt ; 0x02 - $B083
    dw FluteAardvark_AlreadyArborated   ; 0x03 - $B098
}

; ==============================================================================

; $03306C-$033079 JUMP LOCATION
FluteAardvark_Supplicate:
{
    ; "... I enjoyed playing the flute in the original world..."
    LDA.b #$E5
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
        INC.w $0D80, X
    
    .didnt_speak
    
    RTS
}

; ==============================================================================

; $03307A-$033082 JUMP LOCATION
FluteAardvark_GetMeMyFlute:
{
    ; "Did you find my flute? Please keep looking for it!"
    LDA.b #$E8
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $033083-$033097 JUMP LOCATION
FluteAardvark_ThanksButYouKeepIt:
{
    LDA.b #$01 : STA.w $0DC0, X
    
    ; "Thank you, [Name]. (...) Please take it. ..."
    LDA.b #$E9
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
        LDA.b #$03 : STA.w $0D80, X
    
    .didnt_speak
    
    RTS
}

; ==============================================================================

; $033098-$03309D JUMP LOCATION
FluteAardvark_AlreadyArborated:
{
    LDA.b #$03 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $03309E-$0330BA JUMP LOCATION
FluteAardvark_ReactToSupplicationResponse:
{
    LDA.w $1CE8 : BNE .player_declined
        ; "Then I will lend you my shovel. Good luck!"
        LDA.b #$E6
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        INC.w $0D80, X
        
        RTS
    
    .player_declined
    
    ; "...  ...  ... I see.  I won't ask you again... Good bye."
    LDA.b #$E7
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
}

; ==============================================================================

; $0330BB-$0330C9 JUMP LOCATION
FluteAardvark_GrantShovel:
{
    STZ.w $02E9
    
    ; Give Link the shovel.
    LDY.b #$13
    
    PHX
    
    JSL.l Link_ReceiveItem
    
    PLX
    
    STZ.w $0D80, X
    
    RTS
}

; ==============================================================================

; $0330CA-$0330E8 JUMP LOCATION
FluteAardvark_WaitForPlayerMusic:
{
    LDA.w $0202 : CMP.b #$0D : BNE .flute_not_equipped
        BIT.b $F0 : BVC .y_button_not_held
            INC.w $0D80, X
            
            LDA.b #$F2 : STA.w $012C
            
            STZ.w $012E
            
            LDA.b #$17 : STA.w $012D
            
            INC.w $02E4
        
        .y_button_not_held
    .flute_not_equipped
    
    RTS
}

; ==============================================================================

; $0330E9-$03311D JUMP LOCATION
FluteAardvark_Arborating:
{
    LDA.w $0DF0, X : BNE .delay
        LDA.w $0D90, X : CMP.b #$03 : BCC .anoplay_SFX
            LDA.b #$33
            JSL.l Sound_SetSFX2PanLong
        
        .anoplay_SFX
        
        LDA.w $0D90, X : TAY
        INC            : STA.w $0D90, X
        
        LDA.w Pool_FluteAardvark_Arborating_animation_states, Y : BMI .invalid_state
            STA.w $0DC0, X
            
            LDA.w Pool_FluteAardvark_Arborating_timers, Y : STA.w $0DF0, X
        
    .delay
    
    RTS
    
    .invalid_state
    
    ; Go music back to full volume.
    LDA.b #$F3 : STA.w $012C
    
    INC.w $0D80, X
    
    STZ.w $02E4
    
    RTS
}

; ==============================================================================

; $03311E-$03312D JUMP LOCATION
FluteAardvark_FullyArborated:
{
    LDA.b #$03 : STA.w $0DC0, X
    
    ; Let us know that flute boy has been thoroughly arborated.
    LDA.l $7EF3C9 : ORA.b #$08 : STA.l $7EF3C9
    
    RTS
}

; ==============================================================================

; $03312E-$033170 LOCAL JUMP LOCATION
FluteBoy_CheckIfPlayerTooClose:
{
    LDA.w $0D10, X : STA.b $00
    LDA.w $0D30, X : STA.b $01
    
    LDA.w $0D00, X : STA.b $02
    LDA.w $0D20, X : STA.b $03
    
    REP #$30
    
    LDA.b $02 : SEC : SBC.w #$0010 : STA.b $02
    
    LDA.b $22 : SBC.b $00 : BPL .positive_dx
        EOR.w #$FFFF
    
    .positive_dx
    
    STA.b $00
    
    LDA.b $20 : SBC.b $02 : BPL .positive_dy
        EOR.w #$FFFF
    
    .positive_dy
    
    STA.b $02
    
    LDA.b $00 : CMP.w #$0030 : BCS .far_enough_out
        LDA.b $02 : CMP.w #$0030
    
    .far_enough_out
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $033171-$033172 DATA
Sprite_FluteNote_directions:
{
    db 1, -1
}

; $033173-$0331A4 JUMP LOCATION
Sprite_FluteNote:
{
    JSR.w Sprite_PrepAndDrawSingleSmall
    JSR.w Sprite_CheckIfActive
    JSR.w Sprite_Move
    JSR.w Sprite_MoveAltitude
    
    LDA.w $0DF0, X : BNE .delay
        STZ.w $0DD0, X
    
    .delay
    
    LDA.b $1A : AND.b #$01 : BNE .odd_frame
        LDA.b $1A : LSR #5 : EOR.w $0FA0 : AND.b #$01 : TAY
        LDA.w $0D50, X : CLC : ADC .directions, Y : STA.w $0D50, X
        
    .odd_frame
    
    RTS
}

; ==============================================================================

; $0331A5-$0331DD LOCAL JUMP LOCATION
FluteBoy_SpawnFluteNote:
{
    LDA.b #$2E
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
        LDA.b $01       : ADC.b #$00 : STA.w $0D30, Y
        
        LDA.b $02 : SEC : SBC.b #$04 : STA.w $0D00, Y
        LDA.b $03       : SBC.b #$00 : STA.w $0D20, Y
        
        LDA.b #$01 : STA.w $0EB0, Y
        
        LDA.b #$08 : STA.w $0F80, Y
        
        LDA.b #$60 : STA.w $0DF0, Y
                     STA.w $0BA0, Y
        
    .spawn_failed
    
    RTS
}

; ==============================================================================
