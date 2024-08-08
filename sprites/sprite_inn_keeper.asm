
; ==============================================================================

; $02E3A3-$02E3A6 DATA
Pool_Sprite_InnKeeper:
{
    ; "There is a lake swimming with Zoras at the source of the river...".
    ; "...there was a boy in this village who could talk to animals ..."
    .messages_low
    db $82, $83
    
    .messages_high
    db $01, $01
}

; ==============================================================================

; $02E3A7-$02E3AE LONG JUMP LOCATION
Sprite_InnKeeperLong:
{
    ; Inn Keeper (0x35)
    
    PHB : PHK : PLB
    
    JSR.w Sprite_InnKeeper
    
    PLB
    
    RTL
}

; ==============================================================================

; $02E3AF-$02E3CB LOCAL JUMP LOCATION
Sprite_InnKeeper:
{
    JSR.w InnKeeper_Draw
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.l $7EF356 : TAY
    
    LDA.w .messages_low, Y        : XBA
    LDA.w .messages_high, Y : TAY : XBA
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $02E3CC-$02E3DB DATA
Pool_InnKeeper_Draw:
{
    .animation_states
    dw 0, -8 : db $C4, $00, $00, $02
    dw 0,  0 : db $CA, $00, $00, $02
}

; ==============================================================================

; $02E3DC-$02E3F2 LOCAL JUMP LOCATION
InnKeeper_Draw:
{
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.b #(.animation_states >> 0) : STA.b $08
    LDA.b #(.animation_states >> 8) : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
