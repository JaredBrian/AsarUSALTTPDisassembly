
; ==============================================================================

; $0E8099-$0E80BA JUMP LOCATION
Sprite_Landmine:
{
    JSR Landmine_Draw
    JSR Sprite4_CheckIfActive
    
    JSL Landmine_CheckDetonationFromHammer : BCS Landmine_InstantDetonation
    
    LDA $0DF0, X : BNE Landmine_Detonating
    
    LDA.b #$04 : STA $0F50, X
    
    JSL Sprite_CheckDamageToPlayerLong : BCC .player_didnt_touch
    
    LDA.b #$08 : STA $0DF0, X
    
    .player_didnt_touch
    
    RTS
}

; ==============================================================================

; $0E80BB-$0E80BE DATA
pool Landmine_Detonating:
{
    .palettes
    db $04, $02, $08, $02
}

; ==============================================================================

; $0E80BF-$0E80FB BRANCH LOCATION
Landmine_Detonating:
{
    CMP.b #$01 : BNE .palette_cycle
    
    ; $0E80C3 ALTERNATE ENTRY POINT
    shared Landmine_InstantDetonation:
    
    STZ $0DD0, X
    
    JSR Sprite_SpawnBomb : BMI .spawn_failed
    
    LDA.b #$06 : STA $0DD0, Y
    
    LDA.b #$02 : STA $0DB0, Y : STA $0F50, Y
    
    LDA.b #$09 : STA $0F60, Y
    
    LDA.b #$1F : STA $0E00, Y
    
    LDA.b #$03 : STA $0E40, Y
    
    JSL Sound_SetSfxPan : ORA.b #$0C : STA $012E
    
    .spawn_failed
    
    RTS
    
    .palette_cycle
    
    LSR A : AND.b #$03 : TAY
    
    LDA .palettes, Y : STA $0F50, X
    
    RTS
}

; ==============================================================================

; $0E80FC-$0E810B DATA
pool Landmine_Draw:
{
    .oam_groups
    dw 0, 4 : db $70, $00, $00, $00
    dw 8, 4 : db $70, $40, $00, $00
}

; ==============================================================================

; $0E810C-$0E8128 LOCAL JUMP LOCATION
Landmine_Draw:
{
    LDA.b #$08 : JSL OAM_AllocateFromRegionB
    
    LDA $0FC6 : CMP.b #$03 : BCS .invalid_gfx_loaded
    
    REP #$20
    
    LDA.w #.oam_groups : STA $08
    
    SEP #$20
    
    LDA.b #$02 : JSL Sprite_DrawMultiple
    
    .invalid_gfx_loaded
    
    RTS
}

; ==============================================================================
