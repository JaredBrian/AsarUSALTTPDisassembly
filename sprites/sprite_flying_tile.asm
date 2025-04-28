; ==============================================================================

; $0F3BB9-$0F3BDA JUMP LOCATION
Sprite_FlyingTile:
{
    LDA.b #$30 : STA.w $0B89, X
    
    JSR.w FlyingTile_Draw
    JSR.w Sprite3_CheckIfActive_permissive
    
    LDA.w $0EF0, X : BNE FlyingTile_Shatter
        LDA.b #$01 : STA.w $0BA0, X
        
        LDA.w $0D80, X
        
        JSL.l UseImplicitRegIndexedLocalJumpTable
        
        dw FlyingTile_EraseTilemapEntries
        dw FlyingTile_RiseUp
        dw FlyingTile_CareenTowardsPlayer
}

; ==============================================================================

; $0F3BDB-$0F3C00 JUMP LOCATION
FlyingTile_EraseTilemapEntries:
{
    LDA.w $0D10, X : STA.b $00
    LDA.w $0D30, X : STA.b $01
    
    LDA.w $0D00, X : CLC : ADC.b #$08 : STA.b $02
    LDA.w $0D20, X                    : STA.b $03
    
    LDY.b #$06 : JSL.l Dungeon_SpriteInducedTilemapUpdate
    
    INC.w $0D80, X
    
    LDA.b #$80 : STA.w $0DF0, X
    
    RTS
}

; ==============================================================================

; $0F3C01-$0F3C2E JUMP LOCATION
FlyingTile_CareenTowardsPlayer:
{
    STZ.w $0BA0, X
    
    ; NOTE: This is why the tiles give up after a short while. These could
    ; be made really nasty with some adjustments...
    LDA.w $0DF0, X : BEQ .dont_refresh_player_tracking
    AND.b #$03     : BNE .dont_refresh_player_tracking
    
        JSR.w FlyingTile_TrackPlayer
    
    .dont_refresh_player_tracking
    
    JSR.w Sprite3_CheckDamage : BCS .shatter
        JSR.w Sprite3_Move
        
        LDA.w $0FDA : SEC : SBC.w $0F70, X : STA.w $0FDA
        LDA.w $0FDB :       SBC.b #$00     : STA.w $0FDB
        
        JSR.w Sprite3_CheckTileCollision
        BEQ FlyingTile_Shatter_no_tile_collision
    
    .shatter

    ; Bleeds into the next function.
}

; $0F3C2F-$0F3C4E JUMP LOCATION
FlyingTile_Shatter:
{
    LDA.b #$1F : JSL.l Sound_SetSfx2PanLong
    
    LDA.b #$06 : STA.w $0DD0, X
    
    LDA.b #$1F : STA.w $0DF0, X
    
    LDA.b #$EC : STA.w $0E20, X
    
    STZ.w $0EF0, X
    
    LDA.b #$80 : STA.w $0DB0, X
    
    RTS
    
    ; $0F3C4D ALTERNATE ENTRY POINT
    .no_tile_collision
    
    BRA FlyingTile_NoisilyAnimate
}

; ==============================================================================

; $0F3C4F-$0F3C5B JUMP LOCATION
FlyingTile_RiseUp:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$10 : STA.w $0DF0, X

        ; Bleeds into the next function.
}

; $0F3C5C-$0F3C62 JUMP LOCATION
FlyingTile_TrackPlayer:
{
    LDA.b #$20
    
    JSL.l Sprite_ApplySpeedTowardsPlayerLong
    
    RTS
}

; $0F3C63-$0F3C6E JUMP LOCATION
FlyingTile_RiseUp_delay:
{
    CMP.b #$40 : BCC .stop_rising
        LDA.b #$04 : STA.w $0F80, X
        
        JSR.w Sprite3_MoveAltitude
        
    .stop_rising

    ; Bleeds into the next function.
}
    
; $0F3C6F-$0F3C89 JUMP LOCATION
FlyingTile_NoisilyAnimate:
{
    INC.w $0E80, X : LDA.w $0E80, X : LSR #2 : AND.b #$01 : STA.w $0DC0, X
    
    TXA : EOR.b $1A : AND.b #$07 : BNE .delay_SFX
        LDA.b #$07 : JSL.l Sound_SetSfx2PanLong
    
    .delay_SFX
    
    RTS
}

; ==============================================================================

; $0F3C8A-$0F3CC9 DATA
FlyingTile_Draw_OAM_groups:
{
    dw 0, 0 : db $D3, $00, $00, $00
    dw 8, 0 : db $D3, $40, $00, $00
    dw 0, 8 : db $D3, $80, $00, $00
    dw 8, 8 : db $D3, $C0, $00, $00
    
    dw 0, 0 : db $C3, $00, $00, $00
    dw 8, 0 : db $C3, $40, $00, $00
    dw 0, 8 : db $C3, $80, $00, $00
    dw 8, 8 : db $C3, $C0, $00, $00
}

; $0F3CCA-$0F3CE7 LOCAL JUMP LOCATION
FlyingTile_Draw:
{
    LDA.b #$00   : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #5 : ADC.w #(.OAM_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$04 : JSR.w Sprite3_DrawMultiple
    
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
