; ==============================================================================

; $04260E-$042751 JUMP LOCATION
Ancilla_Unused_0E:
Ancilla_Unused_0F:
Ancilla_Unused_10:
Ancilla_Unused_12:
Ancilla_BlastWall:
{
    LDA.b $11 : BNE .state_logic_finished
        LDA.l $7F0000, X : BEQ .inactive_component
            LDA.l $7F0008, X : DEC : STA.l $7F0008, X
            BNE .state_logic_finished
                LDA.l $7F0000, X : INC : STA.l $7F0000, X
                BEQ .anospawn_fireball
                CMP.b #$09 : BCS .anospawn_fireball
                    PHX
                    
                    TXA : ASL : ASL : STA.b $04
                    
                    LDY.b #$0A
                    LDA.b #$32
                    JSL.l AddBlastWallFireball
                    
                    PLX
                    
                .anospawn_fireball
                
                LDA.l $7F0000, X : CMP.b #$0B : BNE .anoreset_component_state
                    LDA.b #$00 : STA.l $7F0000, X
                                 STA.l $7F0008, X
                    
                    BRA .state_logic_finished
                    
                .anoreset_component_state
                
                ; OPTIMIZE: WTF: This instruction doesn't appear to serve any
                ; useful purpose.
                TAY
                
                LDA.b #$03 : STA.l $7F0008, X
    
    .state_logic_finished
    
    BRL .draw
    
    .inactive_component
    
    ; Switch to the other slot? Why?
    TXA : EOR.b #$01 : TAX
    
    LDA.l $7F0000, X : CMP.b #$06 : BNE .state_logic_finished
        LDA.l $7F0008, X : CMP.b #$02 : BNE .state_logic_finished
            ; WTF:(confirmed) Was the blast wall designed to have more than one
            ; spawn point? Multiple blast wall objects working at once?
            LDX.w $0380
            
            LDA.w $0C5E : INC : CMP.b #$07 : BCC .reset_inactive_component
                BRL .draw
            
            .reset_inactive_component
            
            STA.w $0C5E
            
            LDA.b #$01 : STA.l $7F0000, X
            LDA.b #$03 : STA.l $7F0008, X
            
            PHX
            
            LDA.b #$03 : STA.b $06
            
            .adjust_next_explosion_position
            
                STZ.b $00
                STZ.b $01
                
                STZ.b $02
                STZ.b $03
                
                STX.b $04
                
                LDX.b #$00
                
                ; What was the index into the blast wall data tables that was
                ; used to set this up?
                ; TODO: Check if this branch ever is taken. How many blast
                ; walls are in the game? Skull Woods and Ganon's Tower are all
                ; I can think of at the moment.
                LDA.l $7F001C : CMP.b #$04 : BCS .diverge_vertically
                    ; Diverge horizontally in this case.
                    LDX.b #$02
                
                .diverge_vertically
                
                LDA.b #$0D : STA.b $00, X
                
                LDA.b $06 : AND.b #$02 : BEQ .first_two_adjustments
                    ; Invert the sign of the variable. (Couldn't we just do
                    ; this stuff in 16-bit? Anyways, it looks like the point of
                    ; this is to allow the explosions to diverge out in
                    ; opposing directions.
                    ; OPTIMIZE: Maybe do this in 16-bit logic.
                    LDA.b $00, X : EOR.b #$FF : INC : STA.b $00, X
                    LDA.b #$FF                      : STA.b $01, X
                    
                .first_two_adjustments
                
                LDA.b $04 : ASL #3 : STA.b $08
                
                LDA.b $06 : ASL : CLC : ADC.b $08 : TAX
                
                REP #$20
                
                LDA.l $7F0020, X : CLC : ADC.b $00 : STA.l $7F0020, X
                LDA.l $7F0030, X : CLC : ADC.b $02 : STA.l $7F0030, X
                                   SEC : SBC.b $E2 : STA.b $72
                
                SEP #$20
                
                ; The explosion would be off screen, so don't play the SFX.
                LDA.b $73 : BNE .anoplay_explosion_SFX
                    LDA.b $72
                    JSR.w Ancilla_SetSFXPan_NearEntity
                    ORA.b #$0C : STA.w $012E
                    
                .anoplay_explosion_SFX
                
                LDX.b $04
            DEC.b $06 : BPL .adjust_next_explosion_position
            
            PLX
            
    .draw
    
    LDX.w $0380
    LDA.l $7F0000, X : BEQ .dont_draw_component
        LDY.b #$07
        
        ; As previously noted, this branch should almost certainly never
        ; happen. I would label it as 'never' but there's another branch
        ; that points there and forms a loop, and that would be confusing.
        CPX.b #$01 : BEQ .indexing_second_component
            LDY.b #$03
        
        .indexing_second_component

        .draw_next_explosion
        
            PHY : PHX
            
            TYA : ASL : TAX
            
            REP #$20
            
            LDA.l $7F0020, X : STA.b $00
            LDA.l $7F0030, X : STA.b $02
            
            SEP #$20
            
            PLX : PLY
            
            JSR.w BlastWall_DrawExplosion
            
            SEP #$20
        DEY : TYA : AND.b #$03 : CMP.b #$03 : BNE .draw_next_explosion
    
    .dont_draw_component
    
    LDA.w $0C5E : CMP.b #$06 : BNE Ancilla_RestoreIndex
        LDX.b #$01
        
        .find_active_component
        
            LDA.l $7F0000, X : BNE Ancilla_RestoreIndex
        DEX : BPL .find_active_component
        
        ; Self terminate when there are no active components left.
        STZ.w $0C4A
        
        STZ.w $0C4B
        
        STZ.w $0112

        ; Bleeds into the next function.
}
    
; $042752-$042755 JUMP LOCATION
Ancilla_RestoreIndex:
{
    LDX.w $0FA0
    
    RTS
}

; ==============================================================================

; $042756-$0427AA LOCAL JUMP LOCATION
BlastWall_DrawExplosion:
{
    PHX : PHY
    
    LDA.b #$30 : STA.b $65
                 STZ.b $64
    
    LDA.l $7F0000, X : TAY
    LDA.w Bomb_Draw_num_OAM_entries, Y : STA.b $08
    
    LDA.w Ancilla_Bomb_chr_groups, Y : TAY
    LDA.w Bomb_Draw_chr_start_offset, Y : ASL : TAX
    
    ASL : STA.b $04
          STZ.b $05
    
    STZ.b $0A
    
    LDA.b #$32 : STA.b $0B
    
    STZ.b $06
    STZ.b $07
    
    LDA.b #$18
    
    LDY.w $0FB3 : BEQ .dont_sort_sprites
        JSL.l OAM_AllocateFromRegionD
        
        BRA .finished_allocating
        
    .dont_sort_sprites
    
    JSL.l OAM_AllocateFromRegionA
    
    .finished_allocating
    
    REP #$20
    
    LDA.b $00 : SEC : SBC.b $E8 : STA.b $0C
    LDA.b $02 : SEC : SBC.b $E2 : STA.b $0E
    
    SEP #$20
    
    LDY.b #$00
    JSR.w Bomb_DrawExplosion
    
    PLY : PLX
    
    RTS
}

; ==============================================================================

; $0427AB-$04280C LOCAL JUMP LOCATION
Bomb_DrawExplosion:
{
    .next_OAM_entry
    
        LDA.w Pool_Bomb_Draw_chr, X : CMP.b #$FF : BEQ .skip_OAM_entry
            ; Offset index for placing the sprites?
            STX.b $72
            
            REP #$20
            
            STZ.b $74
            
            LDA.b $06 : ASL : ASL : CLC : ADC.b $04 : TAX
            LDA.w Pool_Bomb_Draw_y_offsets, X : CLC : ADC.b $0C : STA.b $00
            LDA.w Pool_Bomb_Draw_x_offsets, X : CLC : ADC.b $0E : STA.b $02
            
            SEP #$20
            
            LDX.b $72
            JSR.w Ancilla_SetSafeOam_XY
            
            LDA.w Pool_Bomb_Draw_chr, X : STA.b ($90), Y
            
            INY
            LDA.w Pool_Bomb_Draw_properties, X : AND.b #$C1
            ORA.b $65 : ORA.b $0B : STA.b ($90), Y
            
            INY
            
            STY.b $72
            STX.b $73
            
            TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
            
            TXA : LSR : TAX
            LDA.w Pool_Bomb_Draw_OAM_sizes, X : ORA.b $75 : STA.b ($92), Y
            
            LDX.b $73
            LDY.b $72
        
        .skip_OAM_entry
        
        INX : INX
    ; Compare with the number of sprites needed for the bomb.
    INC.b $06
    LDA.b $06 : CMP.b $08 : BNE .next_OAM_entry
    
    RTS
}

; ==============================================================================
