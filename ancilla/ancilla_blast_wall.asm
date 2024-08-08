
; ==============================================================================

; $04260E-$042755 JUMP LOCATION
Ancilla_Unused_0E:
Ancilla_Unused_0F:
Ancilla_Unused_10:
Ancilla_Unused_12:
Ancilla_BlastWall:
{
    LDA $11 : BNE .state_logic_finished
    
    LDA.l $7F0000, X : BEQ .inactive_component
    
    LDA.l $7F0008, X : DEC A : STA.l $7F0008, X : BNE .state_logic_finished
    
    LDA.l $7F0000, X : INC A : STA.l $7F0000, X : BEQ .anospawn_fireball
                             CMP.b #$09     : BCS .anospawn_fireball
    
    PHX
    
    TXA : ASL #2 : STA $04
    
    LDY.b #$0A
    LDA.b #$32
    
    JSL.l AddBlastWallFireball
    
    PLX
    
    .anospawn_fireball
    
    LDA.l $7F0000, X : CMP.b #$0B : BNE .anoreset_component_state
    
    LDA.b #$00 : STA.l $7F0000, X : STA.l $7F0008, X
    
    BRA .state_logic_finished
    
    .anoreset_component_state
    
    ; WTF: This instruction doesn't appear to serve any useful purpose.
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
    
    LDA.w $0C5E : INC A : CMP.b #$07 : BCC .reset_inactive_component
    
    BRL .draw
    
    .reset_inactive_component
    
    STA.w $0C5E
    
    LDA.b #$01 : STA.l $7F0000, X
    LDA.b #$03 : STA.l $7F0008, X
    
    PHX
    
    LDA.b #$03 : STA $06
    
    .adjust_next_explosion_position
    
    STZ $00
    STZ $01
    
    STZ $02
    STZ $03
    
    STX $04
    
    LDX.b #$00
    
    ; What was the index into the blast wall data tables that was used
    ; to set this up?
    ; TODO: Check if this branch ever is taken. How many blast walls are
    ; in the game? Skull Woods and Ganon's Tower are all I can think of
    ; at the moment.
    LDA.l $7F001C : CMP.b #$04 : BCS .diverge_vertically
    
    ; (Diverge horizontally in this case.)
    LDX.b #$02
    
    .diverge_vertically
    
    LDA.b #$0D : STA $00, X
    
    LDA $06 : AND.b #$02 : BEQ .first_two_adjustments
    
    ; Invert the sign of the variable. (Couldn't we just do this stuff in
    ; 16-bit? Anyways, it looks like the point of this is to allow the
    ; explosions to diverge out in opposing directions.
    ; OPTIMIZE: Maybe do this in 16-bit logic.
    LDA $00, X : EOR.b #$FF : INC A : STA $00, X
                 LDA.b #$FF         : STA $01, X
    
    .first_two_adjustments
    
    LDA $04 : ASL #3 : STA $08
    
    LDA $06 : ASL A : CLC : ADC $08 : TAX
    
    REP #$20
    
    LDA.l $7F0020, X : CLC : ADC $00 : STA.l $7F0020, X
    LDA.l $7F0030, X : CLC : ADC $02 : STA.l $7F0030, X
    
    SEC : SBC $E2 : STA $72
    
    SEP #$20
    
    ; The explosion would be off screen, so don't play the sfx.
    LDA $73 : BNE .anoplay_explosion_sfx
    
    LDA $72
    
    JSR.w Ancilla_SetSfxPan_NearEntity : ORA.b #$0C : STA.w $012E
    
    .anoplay_explosion_sfx
    
    LDX $04
    
    DEC $06 : BPL .adjust_next_explosion_position
    
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
    
    TYA : ASL A : TAX
    
    REP #$20
    
    LDA.l $7F0020, X : STA $00
    LDA.l $7F0030, X : STA $02
    
    SEP #$20
    
    PLX : PLY
    
    JSR.w BlastWall_DrawExplosion
    
    SEP #$20
    
    DEY : TYA : AND.b #$03 : CMP.b #$03 : BNE .draw_next_explosion
    
    .dont_draw_component
    
    LDA.w $0C5E : CMP.b #$06 : BNE .return
    
    LDX.b #$01
    
    .find_active_component
    
    LDA.l $7F0000, X : BNE .return
    
    DEX : BPL .find_active_component
    
    ; Self terminate when there are no active components left.
    STZ.w $0C4A
    
    STZ.w $0C4B
    
    STZ.w $0112
    
    ; $042752 ALTERNATE ENTRY POINT
    shared Ancilla_RestoreIndex:
    
    .return
    
    LDX.w $0FA0
    
    RTS
}

; ==============================================================================

; $042756-$0427AA LOCAL JUMP LOCATION
BlastWall_DrawExplosion:
{
    PHX : PHY
    
    LDA.b #$30 : STA $65
                 STZ $64
    
    LDA.l $7F0000, X : TAY
    
    LDA Bomb_Draw_num_oam_entries, Y : STA $08
    
    LDA Ancilla_Bomb_chr_groups, Y : TAY
    
    LDA Bomb_Draw_chr_start_offset, Y : ASL A : TAX
    
    ASL A : STA $04
            STZ $05
    
    STZ $0A
    
    LDA.b #$32 : STA $0B
    
    STZ $06
    STZ $07
    
    LDA.b #$18
    
    LDY.w $0FB3 : BEQ .dont_sort_sprites
    
    JSL.l OAM_AllocateFromRegionD
    
    BRA .finished_allocating
    
    .dont_sort_sprites
    
    JSL.l OAM_AllocateFromRegionA
    
    .finished_allocating
    
    REP #$20
    
    LDA $00 : SEC : SBC $E8 : STA $0C
    LDA $02 : SEC : SBC $E2 : STA $0E
    
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
    .next_oam_entry
    
    LDA.w .chr, X : CMP.b #$FF : BEQ .skip_oam_entry
    
    ; offset index for placing the sprites?
    STX $72
    
    REP #$20
    
    STZ $74
    
    LDA $06 : ASL #2 : CLC : ADC $04 : TAX
    
    LDA.w .y_offsets, X : CLC : ADC $0C : STA $00
    LDA.w .x_offsets, X : CLC : ADC $0E : STA $02
    
    SEP #$20
    
    LDX $72
    
    JSR.w Ancilla_SetSafeOam_XY
    
    LDA.w .chr, X : STA ($90), Y : INY
    
    LDA.w .properties, X : AND.b #$C1
                         ORA $65
                         ORA $0B    : STA ($90), Y : INY
    
    STY $72
    STX $73
    
    TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    TXA : LSR A : TAX
    
    LDA.w .oam_sizes, X : ORA $75 : STA ($92), Y
    
    LDX $73
    LDY $72
    
    .skip_oam_entry
    
    INX #2
    
    ; Compare with the number of sprites needed for the bomb
    INC $06 : LDA $06 : CMP $08 : BNE .next_oam_entry
    
    RTS
}

; ==============================================================================
