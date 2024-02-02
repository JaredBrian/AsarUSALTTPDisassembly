
; ==============================================================================

; $02EEA6-$02EEA6 JUMP LOCATION
SpritePrep_FakeSword:
{
    RTL
}

; ==============================================================================

; $02EEA7-$02EEAE LONG JUMP LOCATION
Sprite_FakeSwordLong:
{
    ; Fake Master Sword (0xE8)
    
    PHB : PHK : PLB
    
    JSR Sprite_FakeSword
    
    PLB
    
    RTL
}

; ==============================================================================

; $02EEAF-$02EED5 LOCAL JUMP LOCATION
Sprite_FakeSword:
{
    JSR FakeSword_Draw
    JSR Sprite2_CheckIfActive.permissive
    
    LDA $7FFA1C, X : CMP.b #$03 : BNE .player_is_holding
    
    LDA $0DB0, X : BNE .ignore_message
    
    INC $0DB0, X
    
    ; "This is it! The Master Sword! (...) No, this can't be it..."
    LDA.b #$6F
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    .ignore_message
    
    RTS
    
    .player_is_holding
    
    JSR Sprite2_Move
    JSL ThrownSprite_TileAndPeerInteractionLong
    
    RTS
}

; ==============================================================================

; $02EED6-$02EEE5 DATA
pool FakeSword_Draw:
{
    .animation_states
    db $04, $00, $00, $00, $F4, $00, $00, $00
    db $04, $00, $08, $00, $F5, $00, $00, $00    
}

; ==============================================================================

; $02EEE6-$02EEF8 LOCAL JUMP LOCATION
FakeSword_Draw:
{
    LDA.b #$02 : STA $06
                 STZ $07
    
    LDA.b #(.animation_states >> 0) : STA $08
    LDA.b #(.animation_states >> 8) : STA $09
    
    JSL Sprite_DrawMultiple.player_deferred
    
    RTS
}

; ==============================================================================

