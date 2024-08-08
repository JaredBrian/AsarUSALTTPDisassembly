
; ==============================================================================

; $0F6111-$0F611F JUMP LOCATION
Sprite_BombShopEntity:
{
    ; Bomb Shop Guy
    
    LDA.w $0E80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Sprite_BombShopGuy
    dw Sprite_BombShopBomb
    dw Sprite_BombShopSuperBomb
    dw Sprite_BombShopSnoutPuff
}

; ==============================================================================

; $0F6120-$0F6133 DATA
Pool_Sprite_BombShopGuy:
{
    .messages_low
    db $17, $18
    
    .messages_high
    db $01, $01
    
    .animation_states
    db $00, $01, $00, $01, $00, $01, $00, $01
    
    .timers
    db $FF, $20, $FF, $18, $0F, $18, $FF, $0F
}

; ==============================================================================

; $0F6134-$0F618F JUMP LOCATION
Sprite_BombShopGuy:
{
    JSR.w BombShopEntity_Draw
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0DF0, X : BNE .delay
    
    LDA.w $0E90, X : TAY
    
    INC A : AND.b #$07 : STA.w $0E90, X
    
    LDA.w .timers, Y : STA.w $0DF0, X
    
    LDA.w .animation_states, Y : STA.w $0DC0, X : BNE .play_breathe_in_sound
    
    LDA.b #$11 : JSL.l Sound_SetSfx3PanLong
    
    JSR.w BombShopGuy_SpawnSnoutPuff
    
    BRA .moving_on
    
    .play_breathe_in_sound
    
    LDA.b #$12 : JSL.l Sound_SetSfx3PanLong
    
    .moving_on
    .delay
    
    LDY.b #$00
    
    LDA.l $7EF37A : AND.b #$05 : CMP.b #$05 : BNE .dont_have_super_bomb
    
    LDA.l $7EF3C9 : AND.b #$20 : BEQ .dont_have_super_bomb
    
    ; Change dialogue to reflect that the Super Bomb is present. (Doesn't
    ; actually spawn the super bomb, though. That's done during this
    ; sprite's spawn routine).
    LDY.b #$01
    
    .dont_have_super_bomb
    
    LDA.w .messages_low, Y        : XBA
    LDA.w .messages_high, Y : TAY : XBA
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    JSL.l Sprite_PlayerCantPassThrough
    
    RTS
}

; ==============================================================================

; $0F6190-$0F61DE JUMP LOCATION
Sprite_BombShopBomb:
{
    JSR.w BombShopEntity_Draw
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    JSR.w ShopKeeper_CheckPlayerSolicitedDamage : BCC .didnt_solicit
    
    LDA.l $7EF370 : PHX : TAX
    
    LDA.l $0DDB48, X : PLX : CMP.l $7EF343 : BEQ .dont_need_any_bombs
    
    ; 
    LDA.b #$64
    LDY.b #$00
    
    ; $0F739E IN ROM
    JSR.w $F39E : BCC .player_cant_afford
    
    LDA.b #$1B : STA.l $7EF375
    
    STZ.w $0DD0, X
    
    LDA.b #$19
    LDY.b #$01
    
    JSL.l Sprite_ShowMessageUnconditional
    
    LDY.b #$28
    
    JSR.w $F366 ; $0F7366 IN ROM
    
    .didnt_solicit
    
    RTS
    
    .dont_need_any_bombs
    
    LDA.b #$6E
    LDY.b #$01
    
    JSL.l Sprite_ShowMessageUnconditional
    JSR.w $F38A   ; $0F738A IN ROM
    
    RTS
    
    .player_cant_afford
    
    JMP.w $F1A1 ; $0F71A1 IN ROM
}

; ==============================================================================

; $0F61DF-$0F6215 JUMP LOCATION
Sprite_BombShopSuperBomb:
{
    JSR.w BombShopEntity_Draw
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    JSR.w ShopKeeper_CheckPlayerSolicitedDamage : BCC .didnt_solicit
    
    LDA.b #$64
    LDY.b #$00
    
    ; $0F739E IN ROM
    JSR.w $F39E : BCC .player_cant_afford
    
    LDA.b #$0D : STA.l $7EF3CC ; Super Bomb sprite
    
    PHX
    
    JSL.l Tagalong_LoadGfx
    
    PLX
    
    JSL.l Tagalong_LoadGfx
    JSL.l Tagalong_SpawnFromSprite
    
    STZ.w $0DD0, X
    
    LDA.b #$1A
    LDY.b #$01
    
    JSL.l Sprite_ShowMessageUnconditional
    
    .didnt_solicit
    
    RTS
    
    .player_cant_afford
    
    JMP.w $F1A1 ; $0F71A1 IN ROM
}

; ==============================================================================

; $0F6216-$0F6219 DATA
Pool_Sprite_BombShopSnoutPuff:
{
    .properties
    db $04, $44, $C4, $84
}

; ==============================================================================

; $0F621A-$0F6255 JUMP LOCATION
Sprite_BombShopSnoutPuff:
{
    LDA.b #$04 : JSL.l OAM_AllocateFromRegionC
    
    JSL.l Sprite_PrepAndDrawSingleSmallLong
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0F50, X : AND.b #$30 : STA.w $0F50, X
    
    LDA.b $1A : LSR #2 : AND.b #$03 : TAY
    
    LDA.w $0F50, X : ORA .properties, Y : STA.w $0F50, X
    
    INC.w $0F80, X
    
    JSR.w Sprite3_MoveAltitude
    
    LDA.w $0DF0, X : BNE .dont_self_terminate

    STZ.w $0DD0, X
    
    .dont_self_terminate
    
    LSR #3 : AND.b #$03 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F6256-$0F6295 LOCAL JUMP LOCATION
BombShopGuy_SpawnSnoutPuff:
{
    ; Spawn Bomb salesman or his bombs?
    LDA.b #$B5 : JSL.l Sprite_SpawnDynamically
    
    LDA.b #$03 : STA.w $0E80, Y : STA.w $0BA0, Y
    
    LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
    LDA.b $01              : STA.w $0D30, Y
    
    LDA.b $02 : CLC : ADC.b #$10 : STA.w $0D00, Y
    LDA.b $03              : STA.w $0D20, Y
    
    LDA.b #$04 : STA.w $0F70, Y
    
    LDA.b #$F4 : STA.w $0F80, Y
    
    LDA.b #$17 : STA.w $0DF0, Y
    
    LDA.w $0E60, Y : AND.b #$EE : STA.w $0E60, Y
    
    RTS
}

; ==============================================================================

; $0F6296-$0F62C5 DATA
Pool_BombShopEntity_Draw:
{
    .oam_groups
    db 0, 0, $48, $0A, $00, $02
    
    db 0, 0, $4C, $0A, $00, $02
    
    ; NOTE: label just for informative purposes
    .bomb_groups
    db 0, 0, $C2, $04, $00, $02
    
    db 0, 0, $C2, $04, $00, $02
    
    ; NOTE: label just for informative purposes
    .super_bomb_groups
    db 0, 0, $4E, $08, $00, $02
    
    db 0, 0, $4E, $08, $00, $02
}

; ==============================================================================

; $0F62C6-$0F62E8 LOCAL JUMP LOCATION
BombShopEntity_Draw:
{
    LDA.b #$01 : STA.b $06
                 STZ.b $07
    
    LDA.w $0E80, X : ASL A : ADC.w $0DC0, X : ASL #3
    
    ADC.b #(.oam_groups >> 0)              : STA.b $08
    LDA.b #(.oam_groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
