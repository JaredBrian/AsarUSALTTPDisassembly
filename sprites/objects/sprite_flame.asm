
; ==============================================================================

; $0F4270-$0F4273 DATA
    pook Sprite_Flame:
{
    .vh_flip
    db $00, $40, $C0, $80
}

; ==============================================================================

; $0F4274-$0F42B3 JUMP LOCATION
Sprite_Flame:
{
    LDA.w $0DF0, X : BNE Flame_Halted
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite3_CheckIfActive
    
    LDA.b $1A : LSR #2 : AND.b #$03 : TAY
    
    LDA.w $0F50, X : AND.b #$3F : ORA .vh_flip, Y : STA.w $0F50, X
    
    JSR Sprite3_CheckDamageToPlayer : BCS .hit_something
    
    JSR Sprite3_Move
    
    JSR Sprite3_CheckTileCollision : BNE .hit_something
    
    RTS
    
    .hit_something
    
    LDA.b #$7F : STA.w $0DF0, X
    
    LDA.w $0F50, X : AND.b #$3F : STA.w $0F50, X
    
    LDA.b #$2A : JSL Sound_SetSfx2PanLong
    
    RTS
}

; ==============================================================================

; $0F42B4-$0F42D3 DATA
Pool_Flame_Halted:
{
    .animation_states
    db $05, $04, $03, $01, $02, $00, $03, $00
    db $01, $02, $03, $00, $01, $02, $03, $00
    db $01, $02, $03, $00, $01, $02, $03, $00
    db $01, $02, $03, $00, $01, $02, $03, $00
}

; ==============================================================================

; $0F42D4-$0F42FB BRANCH LOCATION
Flame_Halted:
{
    ; \task figure out if this can even happen. (player damaging flame)
    JSL Sprite_CheckDamageFromPlayerLong : BCC .player_didnt_damage
    
    DEC.w $0DF0, X : BEQ .self_terminate
    
    .player_didnt_damage
    
    LDA.w $0DF0, X : DEC A : BNE .still_burning
    
    .self_terminate
    
    STZ.w $0DD0, X
    
    .still_burning
    
    LDA.w $0DF0, X : LSR #3 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    JSL Flame_Draw
    JMP Sprite3_CheckDamageToPlayer
}

; ==============================================================================

; $0F42FC-$0F435B DATA
Pool_Flame_Draw:
{
    .oam_groups
    dw 0,  0 : db $8E, $01, $00, $02
    dw 0,  0 : db $8E, $01, $00, $02
    
    dw 0,  0 : db $A0, $01, $00, $02
    dw 0,  0 : db $A0, $01, $00, $02
    
    dw 0,  0 : db $8E, $41, $00, $02
    dw 0,  0 : db $8E, $41, $00, $02
    
    dw 0,  0 : db $A0, $41, $00, $02
    dw 0,  0 : db $A0, $41, $00, $02
    
    dw 0,  0 : db $A2, $01, $00, $02
    dw 0,  0 : db $A2, $01, $00, $02
    
    dw 0, -6 : db $A4, $01, $00, $00
    dw 8, -6 : db $A5, $01, $00, $00
}

; ==============================================================================

; $0F435C-$0F4378 LONG JUMP LOCATION
Flame_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00   : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #4 : ADC.w #(.oam_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JSR Sprite3_DrawMultiple
    
    PLB
    
    RTL
}

; ==============================================================================
