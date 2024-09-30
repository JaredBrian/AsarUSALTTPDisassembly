; ==============================================================================

; $032ABE-$032ADF DATA
Pool_Sprite_ThrowableScenery:
{
    ; $032ABE
    .chr
    db $42, $44, $46, $00, $46, $44, $42, $44
    db $44, $00, $46, $44
    
    ; $032ACA
    .palettes
    db $0C, $0C, $0C, $00, $00, $00
    
    ; $032AD0
    .main_oam_table_offsets
    dw $08B0, $08B4, $08B8, $08BC
    
    ; $032AD8
    .high_oam_table_offsets
    dw $0A4C, $0A4D, $0A4E, $0A4F
}

; ==============================================================================

; $032AE0-$032B59 JUMP LOCATION
Sprite_ThrowableScenery:
{
	; If($0FC6 >= 0x03)
    LDA.w $0FC6 : CMP.b #$03 : BCS .cant_draw
        LDA.w $0FB3 : BEQ .dont_use_reserved_oam_slots
            LDA.w $0F20, X : BEQ .dont_use_reserved_oam_slots
                TXA : AND.b #$03 : ASL A : TAY
                
                REP #$20
                
                LDA.w .main_oam_table_offsets, Y : STA.b $90
                
                LDA.w .high_oam_table_offsets, Y : STA.b $92
                
                SEP #$20
                
        .dont_use_reserved_oam_slots
        
        LDA.w $0DD0, X : STA.w $0BA0, X
        
        ; If(object != bigass_object)
        LDA.w $0DB0, X : CMP.b #$06 : BCC .not_bigass_scenery
            JSR.w ThrowableScenery_DrawLarge
            
            BRA .done_drawing
            
        .not_bigass_scenery
        
        JSR.w Sprite_PrepAndDrawSingleLarge
        
        PHX
        
        ; Checks to see if you're indoors in the dark world.
        LDA.b $1B : CLC : ADC.w $0FFF : CMP.b #$02
        
        LDA.w $0DB0, X : PHA : BCC .not_indoors_in_dark_world
            ADC.b #$05
        
        .not_indoors_in_dark_world
        
        TAX
        
        LDA.w Pool_Sprite_ThrowableScenery_chr, X : LDY.b #$02 : STA ($90), Y : INY
        
        LDA ($90), Y : AND.b #$F0
        PLX : ORA.w Pool_Sprite_ThrowableScenery_palettes, X : STA ($90), Y
        
        PLX
        
        AND.b #$0F : STA.b $00
        
        LDA.w $0F50, X : AND.b #$C0 : ORA.b $00 : STA.w $0F50, X
        
        .done_drawing
    .cant_draw
    
    LDA.w $0DD0, X : CMP.b #$09 : BNE .skip_collision_logic
        JSR.w Sprite_CheckIfActive
        JSR.w ThrowableScenery_InteractWithSpritesAndTiles
        
    .skip_collision_logic
    
    RTS
}

; ==============================================================================

; $032B5A-$032B75 DATA
Pool_ThrowableScenery_DrawLarge:
{
    ; $032B5A
    .x_offsets
    dw  -8,   8,  -8,   8
    
    ; $032B62
    .y_offsets
    dw -14, -14,   2,   2
    
    ; $032B6A
    .vh_flip
    db $00, $40, $80, $C0
    
    ; $032B6E
    .shadow_x_offsets
    dw -6,  0,  6
    
    ; $032B74
    .palettes
    dw 12
}

; $032B76-$032C30 LOCAL JUMP LOCATION
ThrowableScenery_DrawLarge:
{
    LDY.w $0DB0, X
    
    ; NOTE: They did it this way because it's assumed that $0DB0, X is
    ; >= 0x06 here.
    LDA.w Pool_ThrowableScenery_DrawLarge_palettes-$06, Y : STA.w $0F50, X
    
    JSR.w Sprite_PrepOamCoord
    
    PHX
    
    LDX.b #$03
    
    .next_oam_entry
    
        PHX
        
        TXA : ASL A : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC Pool_ThrowableScenery_DrawLarge_x_offsets, X
        STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02 : CLC : ADC Pool_ThrowableScenery_DrawLarge_y_offsets, X
        INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
            LDA.b #$F0 : STA ($90), Y
        
        .on_screen_y
        
        PLX
        
        LDA.b #$4A : INY : STA ($90), Y

        LDA.w Pool_ThrowableScenery_DrawLarge_vh_flip, X
        INY : ORA.b $05 : STA ($90), Y
        
        PHY
        
        TYA : LSR #2 : TAY
        
        LDA.b #$02 : ORA.b $0F : STA ($92), Y
        
        PLY : INY
    DEX : BPL .next_oam_entry
    
    PLX
    
    LDA.b #$0C : JSL.l OAM_AllocateFromRegionB
    
    LDY.b #$00
    
    LDA.w $0D00, X : SEC : SBC.b $E8 : STA.b $02
    LDA.w $0D20, X       : SBC.b $E9 : STA.b $03
    
    PHX
    
    LDX.b #$02
    
    .next_shadow_oam_entry
    
        PHX
        
        TXA : ASL A : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC Pool_ThrowableScenery_DrawLarge_x_offsets, X
        STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02 : CLC : ADC.w #$000C : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .shadow_on_screen_y
            LDA.b #$F0 : STA ($90), Y
        
        .shadow_on_screen_y
        
        PLX
        
        LDA.b #$6C : INY : STA ($90), Y
        LDA.b #$24 : INY : STA ($90), Y
        
        PHY
        
        TYA : LSR #2 : TAY
        
        LDA.b #$02 : ORA.b $0F : STA ($92), Y
        
        PLY : INY
    DEX : BPL .next_shadow_oam_entry
    
    PLX
    
    RTS
}

; ==============================================================================

; $032C31-$032C40 DATA
Pool_ThrowableScenery_ScatterIntoDebris:
{
    ; $032C31
    .x_offsets_low
    db -8,  8, -8,  8
    
    ; $032C35
    .x_offsets_high
    db -1,  0, -1,  0
    
    ; $032C39
    .y_offsets_low
    db -8, -8,  8,  8
    
    ; $032C3D
    .y_offsets_high
    db -1, -1,  0,  0
}

; $032C41-$032D02 LOCAL JUMP LOCATION
ThrowableScenery_ScatterIntoDebris:
{
    LDA.w $0DB0, X : BMI .smaller_scenery
    CMP.b #$06     : BCC .smaller_scenery
        LDA.b #$03 : STA.b $0D
        
        .spawn_next_smaller_scenery
        
            LDA.b #$EC : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
                LDA.w $0F70, X : STA.w $0F70, Y
                
                PHX
                
                LDX.b $0D
                
                LDA.b $00
                CLC : ADC Pool_ThrowableScenery_ScatterIntoDebris_x_offsets_low, X
                STA.w $0D10, Y

                LDA.b $01
                ADC Pool_ThrowableScenery_ScatterIntoDebris_x_offsets_high, X
                STA.w $0D30, Y
                
                LDA.b $02
                CLC : ADC Pool_ThrowableScenery_ScatterIntoDebris_y_offsets_low, X
                STA.w $0D00, Y

                LDA.b $03
                ADC Pool_ThrowableScenery_ScatterIntoDebris_y_offsets_high, X
                STA.w $0D20, Y
                
                LDA.b #$01 : STA.w $0DB0, Y
                
                TYX
                
                JSR.w Sprite_ScheduleForBreakage
                
                PLX
                
                LDA.w $0DB0, X : CMP.b #$07 : LDA.b #$00 : BCS .use_default_palette
                    ; 0x06 type scenery uses a palette ot 6 (12 >> 1).
                    LDA.b #$0C
                
                .use_default_palette
                
                STA.w $0F50, Y
            
            .spawn_failed
        DEC.b $0D : BPL .spawn_next_smaller_scenery
        
        STZ.w $0DD0, X
        
        RTS
        
    .smaller_scenery
    
    STZ.w $0DD0, X
    
    JSR.w Sprite_PrepOamCoord
    
    PHX : TXY
    
    LDX.b #$1D
    
    .find_empty_garnish_slot
    
        LDA.l $7FF800, X : BEQ .empty_garnish_slot
    DEX : BPL .find_empty_garnish_slot
    
    INX
    
    .empty_garnish_slot
    
    LDA.b #$16 : STA.l $7FF800, X : STA.w $0FB4
    
    LDA.w $0D10, Y : STA.l $7FF83C, X
    LDA.w $0D30, Y : STA.l $7FF878, X
    
    LDA.w $0D00, Y : SEC : SBC.w $0F70, Y
    
    PHP
    
    CLC : ADC.b #$10 : STA.l $7FF81E, X
    
    LDA.w $0D20, Y : ADC.b #$00
    
    PLP
    
    SBC.b #$00 : STA.l $7FF85A, X
    
    LDA.b $05 : STA.l $7FF9FE, X
    
    LDA.w $0F20, Y : STA.l $7FF968, X
    
    LDA.b #$1F : STA.l $7FF90E, X
    
    LDA.w $0DB0, Y : STA.l $7FF92C, X
    
    PLX
    
    RTS
}

; ==============================================================================
