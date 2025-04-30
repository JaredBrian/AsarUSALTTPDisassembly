; ==============================================================================

; Octorock rocks sprite.
; $0355B9-$0355F2 JUMP LOCATION
Sprite_Octostone:
{
    LDA.w $0DD0, X : CMP.b #$06 : BNE .not_crumbling
        JSR.w Octostone_DrawCrumbling
        JSR.w Sprite_CheckIfActive_permissive
        
        LDA.w $0DF0, X : CMP.b #$1E : BNE .dont_play_crumble_SFX
            LDA.b #$1F : JSL.l Sound_SetSfx2PanLong
        
        .dont_play_crumble_SFX
        
        RTS
        
    .not_crumbling
    
    JSR.w Sprite_PrepAndDrawSingleLarge
    JSR.w Sprite_CheckIfActive
    JSR.w Sprite_CheckDamageToPlayer
    JSR.w Sprite_Move
    
    TXA : EOR.b $1A : AND.b #$03 : BNE .tile_collision_logic_delay
        JSR.w Sprite_CheckTileCollision
        
        LDA.w $0E70, X : BEQ .no_tile_collision
            JSR.w Sprite_ScheduleForDeath
        
        .no_tile_collision
    .tile_collision_logic_delay
    
    RTS
}

; ==============================================================================

; $0355F3-$035642 DATA
Pool_Octostone_DrawCrumbling:
{
    ; $0355F3
    .x_offsets
    dw   0,   8,   0,   8,  -8,  16,  -8,  16
    dw -12,  20, -12,  20, -14,  22, -14,  22
    
    ; $035613
    .y_offsets
    dw   0,   0,   8,   8,  -8,  -8,  16,  16
    dw -12, -12,  20,  20, -14, -14,  22,  22
    
    ; $035633
    .vh_flip
    db $00, $40, $80, $C0, $00, $40, $80, $C0
    db $00, $40, $80, $C0, $00, $40, $80, $C0
}

; $035643-$0356A1 LOCAL JUMP LOCATION
Octostone_DrawCrumbling:
{
    JSR.w Sprite_PrepOamCoord
    
    PHX
    
    LDA.b #$03 : STA.b $06
    
    LDA.w $0DF0, X : LSR A : AND.b #$0C : EOR.b #$0C : CLC : ADC.b $06 : TAX
    
    .next_OAM_entry
    
        PHX
        
        TXA : ASL A : TAX
        
        REP #$20
        
        LDA.b $00
        CLC : ADC Pool_Octostone_DrawCrumbling_x_offsets, X : STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02
        CLC : ADC Pool_Octostone_DrawCrumbling_y_offsets, X : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP #$0100 : SEP #$20 : BCC .on_screen_y
            LDA.b #$F0 : STA ($90), Y
        
        .on_screen_y
        
        PLX
        
        LDA.b #$BC : INY : STA ($90), Y
        
        LDA.w Pool_Octostone_DrawCrumbling_vh_flip, X : ORA.b #$2D : INY : STA ($90), Y
        
        PHY
        
        TYA : LSR #2 : TAY
        
        LDA.b $0F : STA ($92), Y
        
        PLY : INY
        
        DEX
    DEC.b $06 : BPL .next_OAM_entry
    
    PLX
    
    RTS
}

; ==============================================================================
