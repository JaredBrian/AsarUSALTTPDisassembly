
; ==============================================================================

; $02E88E-$02E895 LONG JUMP LOCATION
SpritePrep_RunningManLong:
{
    ; Sprite Prep for Red Hat Wussy (0x74)
    
    PHB : PHK : PLB
    
    JSR.w SpritePrep_RunningMan
    
    PLB
    
    RTL
}

; ==============================================================================

; $02E896-$02E8A1 LOCAL JUMP LOCATION
SpritePrep_RunningMan:
{
    LDA.b #$02 : STA.w $0EB0, X
                 STA.w $0DE0, X
    
    INC.w $0BA0, X
    
    RTS
}

; ==============================================================================

; $02E8A2-$02E8A9 LONG JUMP LOCATION
Sprite_RunningManLong:
{
    ; Scared red hat man (0x74)
    
    PHB : PHK : PLB
    
    JSR.w Sprite_RunningMan
    
    PLB
    
    RTL
}

; ==============================================================================

; $02E8AA-$02E8B1 DATA
Pool_RunningMan_RunFullSpeed:
{
    .x_speeds
    db   0,   0, -54,  54
    
    .y_speeds
    db -54,  54,   0,   0
}

; ==============================================================================

; $02E8B2-$02E8F4 LOCAL JUMP LOCATION
Sprite_RunningMan:
{
    ; (Scared red hat man that runs away if you come near.)
    
    JSR.w RunningMan_Draw
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_MakeBodyTrackHeadDirection
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.b #$FF : STA.w $0E30, X ; wtf is this line? changes his own subtype to seemingly never look at it again?
    
    JSR.w Sprite2_CheckTileCollision
    
    LDA.w $0F60, X : PHA
    
    LDA.b #$07 : STA.w $0F60, X
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_player_collision
    
    LDA.w $0D80, X : STA.w $0DB0, X
    
    LDA.b #$03 : STA.w $0D80, X
    
    .no_player_collision
    
    PLA : STA.w $0F60, X
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw RunningMan_Chillin
    dw RunningMan_RunLeft
    dw RunningMan_WindingRunRight
    dw RunningMan_GotCaught
}

; ==============================================================================

; $02E8F5-$02E8F6 DATA
Pool_RunningMan_Chillin:
{
    .x_speeds
    db $E8, $18
}

; ==============================================================================

; $02E8F7-$02E937 JUMP LOCATION
RunningMan_Chillin:
{
    JSL.l Sprite_MakeBodyTrackHeadDirection
    
    JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .player_not_close
    
    JSL.l Player_HaltDashAttackLong
    
    JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0DE0, X
    
    EOR.b #$01 : ORA.b #$02 : STA.w $0EB0, X : TAY
    
    AND.b #$01 : INC A : STA.w $0D80, X
    
    LDA.w .x_speeds - 2, Y : STA.w $0D50, X
    
    LDA.b #$20 : STA.w $0DF0, X
    
    RTS
    
    .player_not_close
    
    STZ.w $0D50, X
    
    STZ.w $0D40, X
    
    RTS
}

; ==============================================================================

; $02E938-$02E945 BRANCH LOCATION
RunningMan_AnimateAndRun:
{
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    JSR.w Sprite2_Move
    
    RTS
}

; ==============================================================================

; $02E946-$02E964 JUMP LOCATION
RunningMan_RunLeft:
{
    LDA.w $0DF0, X : BNE RunningMan_AnimateAndRun
    
    JSR.w RunningMan_AnimateAndMakeDust
    JSR.w RunningMan_RunFullSpeed
    
    LDA.w $0D90, X : BNE .tick_run_countdown_timer
    
    LDA.b #$FF : STA.w $0D90, X
    LDA.b #$02 : STA.w $0EB0, X
    
    RTS

    .tick_run_countdown_timer
    
    ; $02E961 ALTERNATE ENTRY POINT
RunningMan_TickRunCountdownTimer:

    DEC.w $0D90, X
    
    RTS
}

; ==============================================================================

; $02E965-$02E96B BRANCH LOCATION
RunningMan_ResumeChillin:
{
    ; \tcrf(confirmed) While this is never triggered, forcing it to
    ; trigger has the predicted effect of making the running man settle
    ; back down. He will begin running again if you approach him from the
    ; left or right though. Perhaps originally he was supposed to mock
    ; you.
    
    STZ.w $0D80, X
    STZ.w $0E80, X
    
    RTS
}

; ==============================================================================

; $02E96C-$02E972 DATA
Pool_RunningMan_WindingRunRight:
{
    ; TODO: Label this data and the surrounding routines when time avails.
    .timers
    db 120, 24, 128
    
    .directions
    db 3, 1, 3, -1
    
}

; ==============================================================================

; $02E973-$02E997 JUMP LOCATION
RunningMan_WindingRunRight:
{
    LDA.w $0DF0, X : BNE RunningMan_AnimateAndRun
    
    JSR.w RunningMan_AnimateAndMakeDust
    JSR.w RunningMan_RunFullSpeed
    
    LDA.w $0D90, X : BNE RunningMan_TickRunCountdownTimer
    
    LDY.w $0DA0, X : INC.w $0DA0, X
    
    LDA.w .timers, Y : STA.w $0D90, X
    
    LDA.w .direction, Y : BMI RunningMan_ResumeChillin
    
    STA.w $0EB0, X
    
    RTS
}

; ==============================================================================

; $02E998-$02E9AB JUMP LOCATION
RunningMan_GotCaught:
{
    LDA.b #$A6
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional : BCC 
    
    STA.w $0DE0, X
    
    .didnt_speak
    
    LDA.w $0DB0, X : STA.w $0D80, X
    
    RTS
}

; ==============================================================================

; $02E9AC-$02E9B9 LOCAL JUMP LOCATION
RunningMan_AnimateAndMakeDust:
{
    JSL.l RunningMan_SpawnDashDustGarnish
    
    LDA.b $1A : LSR #2 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02E9BA-$02E9CC LOCAL JUMP LOCATION
RunningMan_RunFullSpeed:
{
    LDY.w $0EB0, X
    
    LDA.w .x_speeds, Y : STA.w $0D50, X
    
    LDA.w .y_speeds, Y : STA.w $0D40, X
    
    JSR.w Sprite2_Move
    
    RTS
}

; ==============================================================================

; $02E9CD-$02EA4C DATA
Pool_RunningMan_Draw:
{
    .oam_groups
    dw 0, -8 : db $2C, $00, $00, $02
    dw 0,  0 : db $EE, $08, $00, $02
    
    dw 0, -7 : db $2C, $00, $00, $02
    dw 0,  1 : db $EE, $48, $00, $02
    
    dw 0, -8 : db $2A, $00, $00, $02
    dw 0,  0 : db $CA, $08, $00, $02
    
    dw 0, -7 : db $2A, $00, $00, $02
    dw 0,  1 : db $CA, $48, $00, $02
    
    dw 0, -8 : db $2E, $00, $00, $02
    dw 0,  0 : db $CC, $08, $00, $02
    
    dw 0, -7 : db $2E, $00, $00, $02
    dw 0,  1 : db $CE, $08, $00, $02
    
    dw 0, -8 : db $2E, $40, $00, $02
    dw 0,  0 : db $CC, $48, $00, $02
    
    dw 0, -7 : db $2E, $40, $00, $02
    dw 0,  1 : db $CE, $48, $00, $02
    
}

; ==============================================================================

; $02EA4D-$02EA70 LOCAL JUMP LOCATION
RunningMan_Draw:
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
