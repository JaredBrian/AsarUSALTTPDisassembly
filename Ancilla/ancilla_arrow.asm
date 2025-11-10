; ==============================================================================

; $042121-$042130 DATA
Pool_Ancilla_Arrow:
{
    ; $042121
    .y_offsets
    dw -4,  2,  0,  0
    
    ; $042125
    .x_offsets
    dw  0,  0, -4,  4
}

; $042131-$04224D JUMP LOCATION
Ancilla_Arrow:
{
    LDA.b $11 : BEQ .normal_submode
        BRL .just_draw
    
    .normal_submode
    
    DEC.w $0C5E, X
    LDA.w $0C5E, X : BMI .timer_elapsed
        CMP.b #$04 : BCC .begin_moving
            ; The object doesn't even start being drawn until this timer counts
            ; down.
            BRL .do_nothing
    
    .timer_elapsed
    
    LDA.b #$FF : STA.w $0C5E, X
    
    .begin_moving
    
    JSR.w Ancilla_MoveVert
    JSR.w Ancilla_MoveHoriz
    
    LDA.l $7EF340 : AND.b #$04 : BEQ .dont_spawn_sparkle
        LDA.b $1A : AND.b #$01 : BNE .dont_spawn_sparkle
            PHX
            
            JSL.l AddSilverArrowSparkle
            
            PLX
    
    .dont_spawn_sparkle
    
    LDA.b #$FF : STA.w $03A9, X
    
    JSR.w Ancilla_CheckSpriteCollision : BCS .sprite_collision
        JSR.w Ancilla_CheckTileCollision : BCS .tile_collision
            BRL .draw
        
        .tile_collision
        
        TYA : STA.w $03C5, X
        
        LDA.w $0C72, X : AND.b #$03 : ASL : TAY
        LDA.w Pool_Ancilla_Arrow_y_offsets+0, Y : CLC : ADC.w $0BFA, X : STA.w $0BFA, X

        LDA.w Pool_Ancilla_Arrow_y_offsets+1, Y       : ADC.w $0C0E, X : STA.w $0C0E, X
        LDA.w Pool_Ancilla_Arrow_x_offsets+0, Y : CLC : ADC.w $0C04, X : STA.w $0C04, X

        LDA.w Pool_Ancilla_Arrow_x_offsets+1, Y : ADC.w $0C18, X : STA.w $0C18, X
        
        STZ.w $0B88
        
        BRA .transmute_to_halted_arrow
    
    .sprite_collision
    
    LDA.w $0C04, X : SEC : SBC.w $0D10, Y : STA.w $0C2C, X
    
    LDA.w $0BFA, X : SEC : SBC.w $0D00, Y : CLC : ADC.w $0F70, Y : STA.w $0C22, X
    
    TYA : STA.w $03A9, X
    
    LDA.w $0E20, Y : CMP.b #$65 : BNE .not_archery_game_sprite
        LDA.w $0D90, Y : CMP.b #$01 : BNE .not_archery_target_mop
            LDA.b #$2D : STA.w $012F
            
            ; Set a delay for the archery game proprietor and set a timer for
            ; the target that was hit (indicating it was hit).
            LDA.b #$80 : STA.w $0E10, Y
                         STA.w $0F10
            
            ; \tcrf In conjunction with the ArcheryGameGuy sprite code, this is
            ; another lead the suggested that there were 9 game prize values
            ; instead of just the normal 5.
            LDA.w $0B88 : CMP.b #$09 : BCS .prize_index_maxed_out
                INC.w $0B88
            
            .prize_index_maxed_out
            
            LDA.w $0B88 : STA.w $0DA0, Y
            
            LDA.w $0ED0, Y : INC : STA.w $0ED0, Y
            
            BRA .transmute_to_halted_arrow
        
        .not_archery_target_mop
        
        LDA.b #$04 : STA.w $0EE0, Y
    
    .not_archery_game_sprite
    
    STZ.w $0B88
    
    .transmute_to_halted_arrow
    
    LDA.w $0E20, Y : CMP.b #$1B : BEQ .hit_enemy_arrow_no_SFX
        LDA.b #$08
        JSR.w Ancilla_DoSFX2
    
    .hit_enemy_arrow_no_SFX
    
    STZ.w $0C5E, X
    
    LDA.b #$0A : STA.w $0C4A, X
    LDA.b #$01 : STA.w $03B1, X
    
    LDA.w $03C5, X : BEQ .draw
        REP #$20
        
        LDA.b $E0 : SEC : SBC.b $E2 : CLC : ADC.w $0C04, X : STA.b $00
        LDA.b $E6 : SEC : SBC.b $E8 : CLC : ADC.w $0BFA, X : STA.b $02
        
        SEP #$20
        
        LDA.b $00 : STA.w $0C04, X
        LDA.b $02 : STA.w $0BFA, X
        
        BRA .draw
        
        .do_nothing
        
        RTS
    
    .draw
    
    BRL Arrow_Draw
}

; ==============================================================================

; $04224E-$04236D DATA
Pool_Arrow_Draw:
{
    ; $04224E
    .chr_and_properties
    db $2B, $A4
    db $2A, $A4
    db $2A, $24
    db $2B, $24
    db $3D, $64
    db $3A, $64
    db $3A, $24
    db $3D, $24
    db $2B, $A4
    db $FF, $FF
    db $2B, $24
    db $FF, $FF
    db $3D, $64
    db $FF, $FF
    db $3D, $24
    db $FF, $FF
    db $3C, $A4
    db $2C, $A4
    db $3C, $A4
    db $2A, $A4
    db $3C, $A4
    db $2C, $E4
    db $3C, $A4
    db $2A, $A4
    db $2C, $24
    db $3C, $24
    db $2A, $24
    db $3C, $24
    db $2C, $64
    db $3C, $24
    db $2A, $24
    db $3C, $24
    db $3B, $64
    db $2D, $64
    db $3B, $64
    db $3A, $E4
    db $3B, $64
    db $2D, $E4
    db $3B, $64
    db $3A, $E4
    db $2D, $24
    db $3B, $24
    db $3A, $24
    db $3B, $A4
    db $2D, $A4
    db $3B, $24
    db $3A, $24
    db $3B, $A4
    
    ; $0422AE
    .xy_offsets
    dw  0,  0
    dw  8,  0
    dw  0,  0
    dw  8,  0
    dw  0,  0
    dw  0,  8
    dw  0,  0
    dw  0,  8
    dw  0,  0
    dw  0,  0
    dw  0,  0
    dw  0,  0
    dw  0,  0
    dw  0,  0
    dw  0,  0
    dw  0,  0
    dw  0,  1
    dw  8,  1
    dw  0,  0
    dw  8,  0
    dw  0, -1
    dw  8, -2
    dw  0,  0
    dw  8,  0
    dw  0,  1
    dw  8,  1
    dw  0,  0
    dw  8,  0
    dw  0, -2
    dw  8, -1
    dw  0,  0
    dw  8,  0
    dw -1,  0
    dw -1,  8
    dw  0,  0
    dw  0,  8
    dw  0,  0
    dw  1,  8
    dw  0,  0
    dw  0,  8
    dw -1,  0
    dw -1,  8
    dw  0,  0
    dw  0,  8
    dw  1,  0
    dw  0,  8
    dw  0,  0
    dw  0,  8
}

; $04236E-$04245A LONG BRANCH LOCATION
Arrow_Draw:
{
    JSR.w Ancilla_PrepAdjustedOamCoord
    
    LDA.w $0280, X : BEQ .normal_priority
        LDA.b #$30 : STA.b $65
    
    .normal_priority
    
    REP #$20
    
    LDA.b $00 : STA.b $0C
    LDA.b $02 : STA.b $0E
                STA.b $04
    
    LDA.w $03C5, X : AND.w #$00FF : BEQ .basic_collision
        ; Seems like this does special handling for more complex collision
        ; modes.
        LDA.b $E8 : SEC : SBC.b $E6 : CLC : ADC.b $0C : STA.b $0C
        LDA.b $E2 : SEC : SBC.b $E0 : CLC : ADC.b $0E : STA.b $0E
                                                        STA.b $04
    
    .basic_collision
    
    SEP #$20
    
    LDA.w $0C5E, X : STA.b $07
    
    LDA.w $0C72, X : AND.b #$FB : TAY
    
    LDA.w $0C4A, X : CMP.b #$0A : BNE .not_halted_arrow
        LDA.w $0C5E, X : AND.b #$08 : BEQ .use_wiggling_frames
            ; During this frame draw as a straight arrow.
            LDA.b #$01
            
            BRA .chr_index_determined
        
        .use_wiggling_frames
        
        LDA.w $0C5E, X : AND.b #$03
        
        .chr_index_determined
        
        STA.b $0A
        
        TYA : ASL : ASL : CLC : ADC.b #$08 : CLC : ADC.b $0A : TAY
        
        BRA .determine_palette
    
    .not_halted_arrow
    
    LDA.w $0C5E, X : BMI .determine_palette
        TYA : ORA.b #$04 : TAY
    
    .determine_palette
    
    PHX
    
    TYA : ASL : ASL : TAX
    
    LDY.b #$02
    
    ; Use different palette for silver arrow.
    LDA.l $7EF340 : AND.b #$04 : BNE .use_silver_palette
        LDY.b #$04
    
    .use_silver_palette
    
    STY.b $74
    
    LDY.b #$00
    
    STZ.b $06
    
    .next_OAM_entry
    
        LDA.w Pool_Arrow_Draw_chr_and_properties, X : CMP.b #$FF : BEQ .skip_OAM_entry
            STA.b $72
            
            PHX : TXA : ASL : TAX
            
            REP #$20
            
            ; First of each interleaved pair is the y offset, and the second
            ; is the x offset.
            LDA.w Pool_Arrow_Draw_xy_offsets+0, X : CLC : ADC.b $0C : STA.b $00
            LDA.w Pool_Arrow_Draw_xy_offsets+2, X : CLC : ADC.b $0E : STA.b $02
            
            SEP #$20
            
            JSR.w Ancilla_SetOam_XY
            
            PLX
            
            LDA.b $72 : STA.b ($90), Y
            
            INY
            LDA.w Pool_Arrow_Draw_chr_and_properties+1, X : AND.b #$C1
            ORA.b $74 : ORA.b $65 : STA.b ($90), Y
            
            INY : PHY
            TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
            LDA.b #$00 : STA.b ($92), Y
            
            PLY
        
        .skip_OAM_entry
        
        INX : INX
        
        INC.b $06
        LDA.b $06 : CMP.b #$02 : BEQ .finished_drawing
    BRL .next_OAM_entry
    
    .finished_drawing
    
    PLX
    
    ; OPTIMIZE: Just change the address instead of the LDYs.
    LDY.b #$01
    LDA.b ($90), Y : CMP.b #$F0 : BNE .on_screen
        LDY.b #$05
        LDA.b ($90), Y : CMP.b #$F0 : BNE .on_screen
            BRL Ancilla_HaltedArrow_self_terminate
    
    .on_screen
    
    RTS
}

; ==============================================================================
