; ==============================================================================

; $0356A2-$0356A9 DATA
Sprite_Octoballoon_altitudes:
{
    db 16, 17, 18, 19, 20, 19, 18, 17
}

; $0356AA-$03572A JUMP LOCATION
Sprite_Octoballoon:
{
    LDA.w $0E80, X : LSR #3 : AND.b #$07 : TAY
    
    LDA.w .altitudes, Y : STA.w $0F70, X
    
    JSR.w Octoballoon_Draw
    JSR.w Sprite_CheckIfActive
    
    LDA.w $0DF0, X : BNE .delay_bursting
        LDA.b #$03 : STA.w $0DF0, X
        
        ; NOTE: Interesting thing about this loop is that it seems to assume
        ; that at one point the game devs designed for more than one Octoballoon
        ; being on screen at a time. However, I tried it out and having two
        ; of these things burst at once is a recipe for some pretty good
        ; slowdown.
        LDY.b #$0F
        
        .search_for_octobabies
        
            LDA.w $0DD0, Y : BEQ .inactive_sprite
                LDA.w $0E20, Y : CMP.b #$10 : BEQ .delay_bursting
            
            .inactive_sprite
        DEY : BPL .search_for_octobabies
        
        LDA.b #$06 : STA.w $0DD0, X
        
        JMP Octoballoon_ScheduleForDeath
    
    .delay_bursting
    
    JSR.w Sprite_CheckIfRecoiling
    
    INC.w $0E80, X
    
    TXA : EOR.b $1A : AND.b #$0F : BNE .skip_speed_check_logic
        LDA.b #$04 : JSR.w Sprite_ProjectSpeedTowardsPlayer
        
        LDA.w $0D40, X : CMP $00 : BEQ .at_target_y_speed
            BPL .above_target_y_speed
                INC.w $0D40, X
                
                BRA .check_x_speed
            
            .above_target_y_speed
            
            DEC.w $0D40, X
            
        .at_target_y_speed
        .check_x_speed
        
        LDA.w $0D50, X : CMP $01 : BEQ .at_target_x_speed
            BPL .above_target_x_speed
                INC.w $0D50, X
                
                BRA .speed_check_logic_complete
            
            .above_target_x_speed
            
            DEC.w $0D50, X
            
        .at_target_x_speed
        .speed_check_logic_complete
    .skip_speed_check_logic
    
    JSR.w Sprite_Move
    
    ; NOTE: The Octoballoon can't actually damage the player, only its
    ; spawn can.
    JSR.w Sprite_CheckDamageToPlayer : BCC .no_player_collision
        JSR.w Octoballoon_ApplyRecoilToPlayer
    
    .no_player_collision
    
    JSR.w Sprite_CheckDamageFromPlayer
    JSR.w Sprite_CheckTileCollision
    JSR.w Sprite_WallInducedSpeedInversion
    
    RTS
}

; ==============================================================================

; $03572B-$03573B LOCAL JUMP LOCATION
Octoballoon_ApplyRecoilToPlayer:
{
    LDA.b $46 : BNE .player_invulnerable_right_now
        LDA.b #$04 : STA.b $46
        
        LDA.b #$10 : JSR.w Sprite_ApplyRecoilToPlayer
        
        JSR.w Sprite_Invert_XY_Speeds
        
    .player_invulnerable_right_now
    
    RTS
}

; ==============================================================================

; $03573C-$035783 DATA
Pool_Octoballoon_Draw:
{
    ; $03573C
    .offset_x
    dw  -4,   4,  -4,   4
    dw  -8,   8,  -8,   8
    dw  -4,   4,  -4,   4

    ; $035754
    .offset_y
    dw  -4,  -4,   4,   4
    dw  -8,  -8,   8,   8
    dw  -4,  -4,   4,   4

    ; $03576C
    .char
    db $8C, $8C, $9C, $9C
    db $86, $86, $86, $86
    db $86, $86, $86, $86

    ; $035778
    .flip
    db $00, $40, $00, $40
    db $00, $40, $80, $C0
    db $00, $40, $80, $C0
}

; ==============================================================================

; $035784-$035801 LOCAL JUMP LOCATION
Octoballoon_Draw:
{
    STZ.b $0A
    
    LDA.w $0DD0, X : CMP.b #$06 : BNE .not_dying
        LDA.w $0DF0, X : CMP.b #$06 : BNE .dont_spawn_babies
            LDA.b $11 : BNE .dont_spawn_babies
                JSR.w Octoballoon_SpawnTheSpawn
        
        .dont_spawn_babies
        
        LDA.w $0DF0, X : LSR : AND.b #$04 : CLC : ADC.b #$04 : STA.b $0A
    
    .not_dying
    
    JSR.w Sprite_PrepOamCoord
    
    PHX
    
    LDA.b #$03 : STA.b $0B
    
    CLC : ADC.b $0A : TAX
    
    .next_OAM_entry
        
        PHX
        
        TXA : ASL : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC.w Pool_Octoballoon_Draw_offset_x, X : STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02 : CLC : ADC.w Pool_Octoballoon_Draw_offset_y, X : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP #$0100 : SEP #$20 : BCC .on_screen_y
            LDA.b #$F0 : STA ($90), Y
        
        .on_screen_y
        
        PLX
        
        LDA.w Pool_Octoballoon_Draw_char, X             : INY : STA ($90), Y
        LDA.w Pool_Octoballoon_Draw_flip, X : ORA.b $05 : INY : STA ($90), Y
        
        PHY
        
        TYA : LSR #2 : TAY
        
        LDA.b #$02 : ORA.b $0F : STA ($92), Y
        
        PLY : INY
        
        DEX
    DEC.b $0B : BPL .next_OAM_entry
    
    PLX
    
    JMP Sprite_DrawShadow
}

; ==============================================================================

; $035802-$03580D DATA
Pool_Octoballoon_SpawnTheSpawn:
{
    ; $035802
    .x_speeds
    db  16,  11, -11, -16, -11,  11
    
    ; $035808
    .y_speeds
    db   0,  11,  11,   0, -11, -11
}

; $03580E-$035842 LOCAL JUMP LOCATION
Octoballoon_SpawnTheSpawn:
{
    LDA.b #$0C : JSL.l Sound_SetSfx2PanLong
    
    LDA.b #$05 : STA.b $0D
    
    .spawn_loop
    
        LDA.b #$10
        
        JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            JSL.l Sprite_SetSpawnedCoords
            
            PHX
            
            LDX.b $0D
            
            LDA.w Pool_Octoballoon_SpawnTheSpawn_x_speeds, X : STA.w $0D50, Y
            
            LDA.w Pool_Octoballoon_SpawnTheSpawn_y_speeds, X : STA.w $0D40, Y
            
            LDA.b #$30 : STA.w $0F80, Y
            
            LDA.b #$FF : STA.w $0E80, Y
            
            PLX
        
        .spawn_failed
    DEC.b $0D : BPL .spawn_loop
    
    RTS
}

; ==============================================================================
