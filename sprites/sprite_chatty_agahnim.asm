; ==============================================================================

!is_altar_zelda = $0D90

; ==============================================================================

; $0ED1FD-$0ED233 LONG JUMP LOCATION
ChattyAgahnim_SpawnZeldaOnAltar:
{
    LDA.w $0D10, X : CLC : ADC.b #$08 : STA.w $0D10, X
    
    LDA.w $0D00, X : CLC : ADC.b #$06 : STA.w $0D00, X
    
    ; Spawn the Zelda companion sprite so Agahnim has something to teleport.
    LDA.b #$C1 : JSL.l Sprite_SpawnDynamically
    
    LDA.b #$01 : STA !is_altar_zelda, Y
                 STA.w $0BA0, Y
    
    JSL.l Sprite_SetSpawnedCoords
    
    LDA.b $02 : CLC : ADC.b #$28 : STA.w $0D00, Y
    
    LDA.b #$00 : STA.w $0E40, Y
    
    LDA.b #$0C : STA.w $0F50, Y
    
    RTL
}

; ==============================================================================

; $0ED234-$0ED23E JUMP LOCATION
Sprite_ChattyAgahnim:
{
    LDA !is_altar_zelda, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw ChattyAgahnim_Main ; 0x00 - $D23F
    dw Sprite_AltarZelda  ; 0x01 - $D57D
}

; ==============================================================================

; $0ED23F-$0ED284 JUMP LOCATION
ChattyAgahnim_Main:
{
    LDA.w $0DB0, X : BEQ .not_afterimage
        LDA !timer_0, X : BNE .delay_self_termination
            STZ.w $0DD0, X
        
        .delay_self_termination
        
        AND.b #$01 : BNE .dont_draw
            JSR.w ChattyAgahnim_Draw
        
        .dont_draw
        
        RTS
        
    .not_afterimage
    
    JSR.w ChattyAgahnim_Draw
    JSR.w ChattyAgahnim_DrawTelewarpSpell
    
    ; Basically checking if off screen or in transition?
    ; Update: This gives the player time enough to walk up the stairs to see
    ; Zelda. Otherwise Agahnim would just start blabbing right away and
    ; begin the teleport sequence. TODO: Add telewarp to the list.
    LDA.w $0F00, X : BEQ .not_paused
        STZ.w $0D80, X
        STZ.w $0DA0, X
        STZ.w $0DC0, X
        
        LDA.b #$40 : STA !timer_0, X
    
    .not_paused
    
    JSR.w Sprite4_CheckIfActive
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw ChattyAgahnim_Problab                ; 0x00 - $D285
    dw ChattyAgahnim_LevitateZelda          ; 0x01 - $D2A5
    dw ChattyAgahnim_DoTelewarpSpell        ; 0x02 - $D2EF
    dw ChattyAgahnim_CompleteTelewarpSpell  ; 0x03 - $D322
    dw ChattyAgahnim_Epiblab                ; 0x04 - $D34F
    dw ChattyAgahnim_TeleportTowardCurtains ; 0x05 - $D36B
    dw ChattyAgahnim_LingerThenTerminate    ; 0x06 - $D3B9
}

; ==============================================================================

; $0ED285-$0ED2A0 JUMP LOCATION
ChattyAgahnim_Problab:
{
    LDA !timer_0, X : BNE .delay_message
        LDA.b #$01 : STA.w $02E4
        
        ; "Ahah... [Name]! I have been waiting for you! Heh heh heh..."
        LDA.b #$3D : STA.w $1CF0
        LDA.b #$01 : STA.w $1CF1
        JSL.l Sprite_ShowMessageMinimal
        
        INC.w $0D80, X
        
    .delay_message
    
    RTS
}

; ==============================================================================

; $0ED2A1-$0ED2A4 DATA
Pool_ChattyAgahnim_LevitateZelda_animation_states:
{
    db 2, 0, 3, 0
}

; $0ED2A5-$0ED2EE JUMP LOCATION
ChattyAgahnim_LevitateZelda:
{
    INC.w $0DA0, X : LDA.w $0DA0, X : PHA : LSR #5 : AND.b #$03 : TAY
    
    LDA.w .animation_states, Y
    
    ; HARDCODED: This Agahnim sprite is laboring under the assumption that
    ; the altar zelda sprite is in slot 0x0F. While this works, adding
    ; even one more sprite to the room would break it.
    LDY.w $0F7F : CPY.b #$10 : BCC .use_variable_animation_state
        LDA.b #$01
    
    .use_variable_animation_state
    
    STA.w $0DC0, X
    
    PLA : AND.b #$0F : BNE .anoincrement_zelda_altitude
        ; Set Zelda's animation state a certain way.
        ; HARDCODED: Same as above.
        LDA.b #$01 : STA.w $0DCF
        
        ; HARDCODED: Same as above.
        INC.w $0F7F : LDA.w $0F7F : CMP.b #$16 : BNE .delay_telewarp_spell
            LDY.b #$27 : STY.w $012F
            
            INC.w $0D80, X
            
            LDA.b #$FF : STA !timer_0, X
            
            LDA.b #$02 : STA.w $0E80, X
            
            LDA.b #$FF : STA.w $0E30, X
        
        .delay_telewarp_spell
    .anoincrement_zelda_altitude
    
    RTS
}

; ==============================================================================

; $0ED2EF-$0ED321 JUMP LOCATION
ChattyAgahnim_DoTelewarpSpell:
{
    LDA !timer_0, X : BEQ .advance_ai_state
        CMP.b #$78 : BEQ .start_flash_effect
            CMP.b #$80 : BCS .anoplay_spell_SFX
                AND.b #$03 : BNE .anoplay_spell_SFX
                    LDA.b #$2B : STA.w $012F
                    
                    LDA.w $0E80, X : CMP.b #$0E : BEQ .anoplay_spell_SFX
                        CLC : ADC.b #$04 : STA.w $0E80, X
                
            .anoplay_spell_SFX
            
            RTS
            
        .start_flash_effect
        
        LDA.b #$78 : STA.w $0FF9
        
        RTS
        
    .advance_ai_state
    
    INC.w $0D80, X
    
    LDA.b #$50 : STA !timer_0, X
    
    RTS
}

; ==============================================================================

; $0ED322-$0ED34E JUMP LOCATION
ChattyAgahnim_CompleteTelewarpSpell:
{
    LDA !timer_0, X : BEQ .finish_warping_zelda
        AND.b #$03 : BNE .return
            LDA.w $0E30, X : CMP.b #$09 : BEQ .return
                CLC : ADC.b #$02 : STA.w $0E30, X
                
                RTS
            
    .finish_warping_zelda
    
    ; HARDCODED: Starts Zelda's timer to make her into a warping sprite.
    LDA.b #$13 : STA.w $0DFF
    
    INC.w $0D80, X
    
    LDA.b #$50 : STA !timer_0, X
    
    STZ.w $0E80, X
    
    LDA.b #$33 : STA.w $012E
    
    .return
    
    RTS
}

; ==============================================================================

; $0ED34F-$0ED36A JUMP LOCATION
ChattyAgahnim_Epiblab:
{
    LDA !timer_0, X : BNE .delay_message
        ; "... With this, the seal of the seven wise men is at last broken..."
        LDA.b #$3E : STA.w $1CF0
        LDA.b #$01 : STA.w $1CF1
        JSL.l Sprite_ShowMessageMinimal
        
        INC.w $0D80, X
        
        LDA.b #$02 : STA !timer_0, X
        
    .delay_message
    
    RTS
}

; ==============================================================================

; $0ED36B-$0ED391 JUMP LOCATION
ChattyAgahnim_TeleportTowardCurtains:
{
    LDA !timer_0, X : DEC : BNE .delay_SFX
        LDA.b #$28 : STA.w $012F
    
    .delay_SFX
    
    LDA.b #$E0 : STA.w $0D40, X
    
    JSR.w Sprite4_MoveVert
    
    LDA.w $0D00, X : CMP.b #$30 : BCS .spawn_afterimage
        ; Set a timer to remain near the entrance for a bit once he reaches it.
        LDA.b #$42 : STA.w $0F10, X
        
        INC.w $0D80, X
    
    .spawn_afterimage
    
    JSL.l Sprite_SpawnAgahnimAfterImage
    
    RTS
}

; ==============================================================================

; $0ED392-$0ED3B8 LONG JUMP LOCATION
Sprite_SpawnAgahnimAfterImage:
{
    LDY.b #$FF
    
    LDA.b $1A : AND.b #$03 : BNE .spawn_delay
        LDA.b #$C1 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            JSL.l Sprite_SetSpawnedCoords
            
            LDA.w $0DC0, X : STA.w $0DC0, Y
            
            LDA.b #$20 : STA !timer_0, Y
                         STA.w $0BA0, Y
                         STA.w $0DB0, Y
    
        .spawn_failed
    .spawn_delay
    
    TYA
    
    RTL
}

; ==============================================================================

; $0ED3B9-$0ED3D0 JUMP LOCATION
ChattyAgahnim_LingerThenTerminate:
{
    LDA.w $0F10, X : BNE .delay_self_termination
        STZ.w $02E4
        
        STZ.w $0DD0, X
        
        JSL.l Dungeon_ManuallySetSpriteDeathFlag
        
        LDA.w $0403 : ORA.b #$40 : STA.w $0403
        
    .delay_self_termination
    
    RTS
}

; ==============================================================================

; $0ED3D1-$0ED450 DATA
ChattyAgahnim_Draw_OAM_groups:
{
    dw -8, -8 : db $82, $0B, $00, $02
    dw  8, -8 : db $82, $4B, $00, $02
    dw -8,  8 : db $A2, $0B, $00, $02
    dw  8,  8 : db $A2, $4B, $00, $02
    
    dw -8, -8 : db $80, $0B, $00, $02
    dw  8, -8 : db $80, $4B, $00, $02
    dw -8,  8 : db $A0, $0B, $00, $02
    dw  8,  8 : db $A0, $4B, $00, $02
    
    dw -8, -8 : db $80, $0B, $00, $02
    dw  8, -8 : db $82, $4B, $00, $02
    dw -8,  8 : db $A0, $0B, $00, $02
    dw  8,  8 : db $A2, $4B, $00, $02
    
    dw -8, -8 : db $82, $0B, $00, $02
    dw  8, -8 : db $80, $4B, $00, $02
    dw -8,  8 : db $A2, $0B, $00, $02
    dw  8,  8 : db $A0, $4B, $00, $02
}

; $0ED451-$0ED48C LOCAL JUMP LOCATION
ChattyAgahnim_Draw:
{
    LDA.w $0F10, X : AND.b #$01 : BNE .dont_draw
        LDA.w $0DB0, X : STA.b $00
                         STZ.b $01
        
        LDA.b #$00 : XBA
        
        LDA.w $0DC0, X : REP #$20 : ASL #5 : ADC.w #.OAM_groups : STA.b $08
        
        LDA.b $00 : BNE .typical_OAM_positioning
            ; Use special position for OAM (for after image version of the guy).
            ; HARDCODED: Assumes these OAM slots are unoccupied.
            LDA.w #$0900 : STA.b $90
            
            LDA.w #$0A60 : STA.b $92
            
        .typical_OAM_positioning
        
        SEP #$20
        
        LDA.b #$04 : JSR.w Sprite4_DrawMultiple
        
        LDA.b #$12 : JSL.l Sprite_DrawShadowLong_variable
    
    .dont_draw
    
    RTS
}

; ==============================================================================

; $0ED48D-$0ED515 DATA
Pool_ChattyAgahnim_DrawTelewarpSpell:
{
    ; $0ED48D
    .OAM_groups
    db -10, -16 : db $CE, $06
    db  18,  16 : db $CE, $06
    db  20, -13 : db $26, $06
    db  20,  -5 : db $36, $06
    
    db -12, -13 : db $26, $46
    db -12,  -5 : db $36, $46
    db  18,   0 : db $26, $06
    db  18,   8 : db $36, $06
    
    db -10,   0 : db $26, $46
    db -10,   8 : db $36, $46
    db  -8,   0 : db $22, $06
    db   8,   0 : db $22, $46
    
    db  -8,  16 : db $22, $86
    db   8,  16 : db $22, $C6
    
    ; $0ED4C5
    db -10, -16 : db $CE, $04
    db  18, -16 : db $CE, $04
    db  20, -13 : db $26, $44
    db  20,  -5 : db $36, $44
    
    db -12, -13 : db $26, $04
    db -12,  -5 : db $36, $04
    db  18,   0 : db $26, $44
    db  18,   8 : db $36, $44
    
    db -10,   0 : db $26, $04
    db -10,   8 : db $36, $04
    db  -8,   0 : db $20, $04
    db   8,   0 : db $20, $44
    
    db  -8,  16 : db $20, $84
    db   8,  16 : db $20, $C4
    
    ; $0ED4FD
    .OAM_sizes
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $02, $02, $02, $02
    
    ; $0ED50B
    .OAM_offset
    db $00, $04, $08, $0C, $10, $14, $18, $1C
    db $20, $24, $28
}

; ==============================================================================

; $0ED516-$0ED57C LOCAL JUMP LOCATION
ChattyAgahnim_DrawTelewarpSpell:
{
    LDA.b #$38 : JSL.l OAM_AllocateFromRegionA
    
    LDA.b $1A : LSR #2
    
    REP #$20

    ; OPTIMIZE: Unused branch? theres no , X or , Y so this will always be true?
    LDA.w #$Pool_ChattyAgahnim_DrawTelewarpSpell_OAM_groups : BCS .use_first_OAM_group
        ADC.w #$0038
    
    .use_first_OAM_group
    
    STA.b $08
    
    LDA.w #Pool_ChattyAgahnim_DrawTelewarpSpell_DOAM_sizes : STA.b $0A
    
    SEP #$20
    
    LDA.w $0E80, X : BEQ .dont_draw_spell_at_all
        LDY.w $0E30, X
        
        STY.b $0D
        
        PHX
        
        DEC : TAX
        
        INY
        
        LDA.w Pool_ChattyAgahnim_DrawTelewarpSpell_OAM_offset, Y : TAY
        
        .next_OAM_entry
            
            LDA.b $00 : CLC : ADC ($08), Y : STA ($90), Y
            
            LDA.b $02 : CLC : ADC.b #$F8   : CLC
            INY     : ADC ($08), Y              : STA ($90), Y
            INY     : LDA ($08), Y              : STA ($90), Y
            INY     : LDA ($08), Y : ORA.b #$31 : STA ($90), Y
            
            PHY : TYA : LSR #2 : TAY
            
            ; OPTIMIZE: This test / and branch is useless, A is clobbered again
            ; immediately.
            ; Also UNUSED: (technically speaking)
            LDA.b #$00
            
            CPX.b #$04 : BCS .irrelevant
                LDA.b #$02
            
            .irrelevant
            
            LDA ($0A), Y : STA ($92), Y
            
            PLY : INY
        DEX : CPX.b $0D : BNE .next_OAM_entry
        
        PLX
        
    .dont_draw_spell_at_all
    
    RTS
}

; ==============================================================================

; $0ED57D-$0ED580 JUMP LOCATION
Sprite_AltarZelda:
{
    JSR.w AltarZelda_Main
    
    RTS
}

; ==============================================================================

; $0ED581-$0ED5A0 DATA
AltarZelda_Main_OAM_groups:
{
    dw -4, 0 : db $03, $01, $00, $02
    dw  4, 0 : db $04, $01, $00, $02
    
    dw -4, 0 : db $00, $01, $00, $02
    dw  4, 0 : db $01, $01, $00, $02
}

; $0ED5A1-$0ED5D8 LOCAL JUMP LOCATION
AltarZelda_Main:
{
    LDA !timer_0, X : BEQ .not_telewarping_zelda
        ; If we end up here, we're drawing the telewarp sprite.
        PHA
        
        JSR.w AltarZelda_DrawWarpEffect
        
        PLA : CMP.b #$01 : BNE .delay_self_termination
            STZ.w $0DD0, X
        
        .delay_self_termination
        
        CMP.b #$0C : BCS .also_draw_zelda_body
            RTS
        
        .also_draw_zelda_body
    .not_telewarping_zelda
    
    LDA.b #$08 : JSL.l OAM_AllocateFromRegionA
    
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : REP #$20 : ASL #4 : ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JSR.w Sprite4_DrawMultiple
    
    JSR.w AltarZelda_DrawBody
    
    RTS
}

; ==============================================================================

; $0ED5D9-$0ED5E8 DATA
AltarZelda_DrawBody_xy_offsets:
{
    db 4, 4, 3, 3, 2, 2, 1, 1
    db 0, 0, 0, 0, 0, 0, 0, 0
}

; ==============================================================================

; $0ED5E9-$0ED660 LOCAL JUMP LOCATION
AltarZelda_DrawBody:
{
    LDA.b #$08 : JSL.l OAM_AllocateFromRegionA
    
    LDA.w $0F70, X : CMP.b #$1F : BCC .z_coord_not_maxed
        ; UNUSED: The code never allows Zelda's altitude to get this high.
        ; OPTIMIZE: Therefore, could take out this whole check.
        LDA.b #$1F
    
    .z_coord_not_maxed
    
    LSR : TAY
    
    LDA.w .xy_offsets, Y : STA.b $07
    
    ; Get 16-bit Y coordinate.
    LDA.w $0D00, X : SEC : SBC.b $E8 : STA.b $02
    LDA.w $0D20, X : SBC.b $E9 : STA.b $03
    
    LDY.b #$00
    
    LDA.b $00 : PHA : CLC : ADC.b $07              : STA ($90), Y
                PLA : SEC : SBC.b $07 : LDY.b #$04 : STA ($90), Y
    
    REP #$20
    
    LDA.b $02 : CLC : ADC.w #$0007 : LDY.b #$01 : STA ($90), Y
                                     LDY.b #$05 : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
        LDA.b #$F0             : STA ($90), Y
                    LDY.b #$01 : STA ($90), Y
        
    .on_screen_y
    
    ; Writ chr and properties bytes to OAM entry.
    LDA.b #$6C : LDY.b #$02 : STA ($90), Y
                 LDY.b #$06 : STA ($90), Y
    LDA.b #$24 : LDY.b #$03 : STA ($90), Y
                 LDY.b #$07 : STA ($90), Y
    
    ; Both are 16x16 sprites.
    LDA.b #$02 : LDY.b #$00 : STA ($92), Y
                 INY        : STA ($92), Y
    
    RTS
}

; ==============================================================================

; $0ED661-$0ED6B0 DATA
AltarZelda_DrawWarpEffect_OAM_groups:
{
    dw  4, 4 : db $80, $04, $00, $00
    dw  4, 4 : db $80, $04, $00, $00
    
    dw  4, 4 : db $B7, $04, $00, $00
    dw  4, 4 : db $B7, $04, $00, $00
    
    dw -6, 0 : db $24, $05, $00, $02
    dw  6, 0 : db $24, $45, $00, $02
    
    dw -8, 0 : db $24, $05, $00, $02
    dw  8, 0 : db $24, $45, $00, $02
    
    dw  0, 0 : db $C6, $05, $00, $02
    dw  0, 0 : db $C6, $05, $00, $02   
}

; $0ED6B1-$0ED6D0 LOCAL JUMP LOCATION
AltarZelda_DrawWarpEffect:
{
    LDA.b #$08 : JSL.l OAM_AllocateFromRegionA
    
    LDA.b #$00 : XBA
    
    LDA !timer_0, X : LSR #2 : REP #$20 : ASL #4
    
    ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JMP Sprite4_DrawMultiple
}

; ==============================================================================
