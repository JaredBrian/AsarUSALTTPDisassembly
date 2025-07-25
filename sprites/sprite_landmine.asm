; ==============================================================================

; $0E8099-$0E80BA JUMP LOCATION
Sprite_Landmine:
{
    JSR.w Landmine_Draw
    JSR.w Sprite4_CheckIfActive
    
    JSL.l Landmine_CheckDetonationFromHammer : BCS Landmine_Detonating_Instant
        LDA.w $0DF0, X : BNE Landmine_Detonating
            LDA.b #$04 : STA.w $0F50, X
            
            JSL.l Sprite_CheckDamageToPlayerLong : BCC .player_didnt_touch
                LDA.b #$08 : STA.w $0DF0, X
            
            .player_didnt_touch
            
            RTS
}

; ==============================================================================

; $0E80BB-$0E80BE DATA
Landmine_Detonating_palettes:
{
    db $04, $02, $08, $02
}

; $0E80BF-$0E80FB BRANCH LOCATION
Landmine_Detonating:
{
    CMP.b #$01 : BNE .palette_cycle
        ; $0E80C3 ALTERNATE ENTRY POINT
        .Instant

        STZ.w $0DD0, X
        
        JSR.w Sprite_SpawnBomb : BMI .spawn_failed
            LDA.b #$06 : STA.w $0DD0, Y
            
            LDA.b #$02 : STA.w $0DB0, Y
                         STA.w $0F50, Y
            
            LDA.b #$09 : STA.w $0F60, Y
            
            LDA.b #$1F : STA.w $0E00, Y
            
            LDA.b #$03 : STA.w $0E40, Y
            
            JSL.l Sound_SetSfxPan : ORA.b #$0C : STA.w $012E
            
        .spawn_failed
        
        RTS
    
    .palette_cycle
    
    LSR : AND.b #$03 : TAY
    LDA.w .palettes, Y : STA.w $0F50, X
    
    RTS
}

; ==============================================================================

; $0E80FC-$0E810B DATA
Landmine_Draw_OAM_groups:
{
    dw 0, 4 : db $70, $00, $00, $00
    dw 8, 4 : db $70, $40, $00, $00
}

; $0E810C-$0E8128 LOCAL JUMP LOCATION
Landmine_Draw:
{
    LDA.b #$08
    JSL.l OAM_AllocateFromRegionB
    
    LDA.w $0FC6 : CMP.b #$03 : BCS .invalid_GFX_loaded
        REP #$20
        
        LDA.w #.OAM_groups : STA.b $08
        
        SEP #$20
        
        LDA.b #$02
        JSL.l Sprite_DrawMultiple
    
    .invalid_GFX_loaded
    
    RTS
}

; ==============================================================================
