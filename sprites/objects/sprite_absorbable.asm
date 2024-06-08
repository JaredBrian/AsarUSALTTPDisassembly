
; ==============================================================================

; $035030-$035031 DATA
Pool_Sprite_Key:
    parallel pool Key_AbsorptionByPlayer:
    ; \task Another routine uses this data array, please name it.
{
    .flag_masks
    db $40, $20
}

; ==============================================================================

; $035032-$0350EC JUMP LOCATION
Sprite_Key:
    shared Sprite_BigKey:
{
    LDY.w $0CBA, X
    
    LDA.w $0403 : AND.w $D030, Y : BEQ .keyNotObtainedYet
    
    ; Kill the key, as it's already been obtained
    STZ.w $0DD0, X
    
    RTS
    
    .keyNotObtainedYet
    
    JSL Sprite_DrawRippleIfInWater
    JSR Sprite_DrawAbsorbable
    
    BRA .draw_logic_finished
    
    ; $03504A ALTERNATE ENTRY POINT
    ; \task A lot of other refill / pickup sprites map to this location
    ; carefully ensure they all get named right, and perhaps with distinct
    ; names would be safer.
    shared Sprite_GreenRupee:
    shared Sprite_BlueRupee:
    shared Sprite_RedRupee:
    shared Sprite_OneBombRefill:
    shared Sprite_FourBombRefill:
    shared Sprite_EightBombRefill:
    shared Sprite_SmallMagicRefill:
    shared Sprite_FullMagicRefill:
    shared Sprite_FiveArrowRefill:
    shared Sprite_TenArrowRefill:
    shared Sprite_ShieldPickup:
    
    JSL Sprite_DrawRippleIfInWater
    JSR Sprite_DrawTransientAbsorbable
    
    .draw_logic_finished
    
    JSR Sprite_CheckIfActive
    JSR Sprite_MoveAltitude
    JSR Sprite_Move
    
    LDA !timer_3, X : BNE .skip_tile_collision_logic
    
    JSR Sprite_CheckTileCollision
    JSR Sprite_WallInducedSpeedInversion
    
    .skip_tile_collision_logic
    
    ; Simulates gravity for the sprite.
    LDA.w $0F80, X : SEC : SBC.b #$02 : STA.w $0F80, X
    
    LDA.w $0F70, X : BPL .aloft
    
    STZ.w $0F70, X
    
    ; Is this equivalent to an arithmetic shift right? Interesting.
    LDA.w $0D50, X : ASL A : ROR.w $0D50, X
    
    LDA.w $0D40, X : ASL A : ROR.w $0D40, X
    
    LDA.w $0F80, X : EOR.b #$FF : INC A : LSR A
    
    CMP.b #$09 : BCS .enough_z_speed_for_bounce
    
    JSR Sprite_Zero_XYZ_Velocity
    
    BRA .finished_bounce_logic
    
    .enough_z_speed_for_bounce
    
    STA.w $0F80, X
    
    LDA.l $7FF9C2, X : CMP.b #$08 : BEQ .water_tile
                     CMP.b #$09 : BNE .not_water_tile
    
    .water_tile
    
    STZ.w $0F80, X
    
    JSL Sprite_SpawnSmallWaterSplash : BMI .finished_bounce_logic
    
    LDA.w $0E60, X : AND.b #$20 : BEQ .finished_bounce_logic
    
    ; Adjust water splash coordinates, but only if this flag is set?
    ; \task Investigate, and if this is true, document it in ram doc.
    LDA.w $0D10, Y : SBC.b #$04 : STA.w $0D10, Y
    LDA.w $0D30, Y : SBC.b #$00 : STA.w $0D30, Y
    
    LDA.w $0D00, Y : SBC.b #$04 : STA.w $0D00, Y
    LDA.w $0D20, Y : SBC.b #$00 : STA.w $0D20, Y
    
    BRA .finished_bounce_logic
    
    .not_water_tile
    
    ; Is the sprite an item or other upper echelon sprite?
    LDA.w $0E20, X : CMP.b #$E4 : BCC .dont_play_clink_sfx
    
    LDA $1B : BEQ .dont_play_clink_sfx
    
    LDA.b #$05 : JSL Sound_SetSfx2PanLong
    
    .dont_play_clink_sfx
    .finished_bounce_logic
    .aloft
    
    JSR Sprite_HandleDraggingByAncilla
    JSR Sprite_CheckAbsorptionByPlayer
    
    RTS
}

; ==============================================================================

; $0350ED-$035115 LOCAL JUMP LOCATION
Sprite_HandleBlinkingPhaseOut:
{
    LDA.w $0B58, X : BEQ .phase_out_not_scheduled
    
    LDA $11 : ORA.w $0FC1 : BNE .dont_blink_at_all
    
    LDA $1A : LSR A : BCS .decrement_blink_timer_delay
    
    DEC.w $0B58, X
    
    .decrement_blink_timer_delay
    
    LDA.w $0B58, X : BNE .self_termination_delay
    
    STZ.w $0DD0, X
    
    .self_termination_delay
    
    CMP.b #$28 : BCS .dont_blink_at_all
    
    LSR A : BCS .visible_this_frame
    
    JSR Sprite_PrepOamCoordSafeWrapper
    
    PLA : PLA
    
    .visible_this_frame
    .dont_blink_at_all
    .not_stunned
    .phase_out_not_scheduled
    
    RTS
}

; ==============================================================================

; $035116-$035124 LOCAL JUMP LOCATION
Sprite_CheckAbsorptionByPlayer:
{
    LDA.w $0F10, X : BNE .sprite_is_paused
    
    JSR Sprite_CheckDamageToPlayer.stagger : BCC .no_player_collision
    
    JSL Sprite_HandleAbsorptionByPlayerLong
    
    .no_player_collision
    .sprite_is_paused
    
    RTS
}

; ==============================================================================

; $035125-$03512C LONG JUMP LOCATION
Sprite_HandleAbsorptionByPlayerLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_HandleAbsorptionByPlayer
    
    PLB
    
    RTL
}

; ==============================================================================

; $03512D-$03513B DATA
Pool_Sprite_HandleAbsorptionByPlayer:
{
    .sfx
    db $0B, $0A, $0A, $0A, $0B, $0B, $0B, $0B
    db $0B, $0B, $0B, $0B, $2F, $2F, $0B
}

; ==============================================================================

; $03513C-$03516F LOCAL JUMP LOCATION
Sprite_HandleAbsorptionByPlayer:
{
    STZ.w $0DD0, X
    
    LDA.w $0E20, X : SEC : SBC.b #$D8 : TAY
    
    LDA .sfx, Y : JSL Sound_SetSfx3PanLong
    
    TYA
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw HeartRefill_AbsorptionByPlayer
    dw GreenRupee_AbsorptionByPlayer
    dw BlueRupee_AbsorptionByPlayer
    dw RedRupee_AbsorptionByPlayer
    dw OneBombRefill_AbsorptionByPlayer
    dw FourBombRefill_AbsorptionByPlayer
    dw EightBombRefill_AbsorptionByPlayer
    dw SmallMagicRefill_AbsorptionByPlayer
    dw FullMagicRefill_AbsorptionByPlayer
    dw FiveArrowRefill_AbsorptionByPlayer
    dw TenArrowRefill_AbsorptionByPlayer
    dw Fairy_AbsorptionByPlayer
    dw Key_AbsorptionByPlayer
    dw BigKey_AbsorptionByPlayer
    dw ShieldPickup_AbsorptionByPlayer
}

; ==============================================================================

; $035170-$035177 JUMP LOCATION
ShieldPickup_AbsorptionByPlayer:
{
    ; recoverable shield (from Pikit, etc)
    LDA.w $0E30, X : STA.l $7EF35A
    
    RTS
}

; ==============================================================================

; $035178-$0351A4 JUMP LOCATION
BigKey_AbsorptionByPlayer:
{
    STZ.w $02E9
    
    LDY.b #$32
    
    PHX
    
    JSL Link_ReceiveItem
    
    PLX
    
    BRA .set_event_flag
    
    ; $035185 ALTERNATE ENTRY POINT
    shared Key_AbsorptionByPlayer:
    
    LDA.l $7EF36F : INC A : STA.l $7EF36F
    
    .set_event_flag
    
    LDA.w $0E30, X : STA.w $0BC0, X
    
    ; Hopefully this is 0 or 1 or else things don't make much sense
    LDY.w $0CBA, X
    
    LDA.w $0403 : ORA.w $D030, Y : STA.w $0403
    
    JSL Dungeon_ManuallySetSpriteDeathFlag
    
    RTS
}

; ==============================================================================

; $0351A5-$0351BA JUMP LOCATION
Fairy_AbsorptionByPlayer:
{
    LDA.b #$31 : JSL Sound_SetSfx2PanLong
    
    LDA.b #$38 ; Amount of hearts a Fairy refills (7 hearts).
    
    BRA .apply_refill_amount
    
    ; $0351AF ALTERNATE ENTRY POINT
    shared HeartRefill_AbsorptionByPlayer:
    
    ; Amount of hearts a standard heart refills
    LDA.b #$08
    
    .apply_refill_amount
    
    CLC : ADC.l $7EF372 : STA.l $7EF372
    
    RTS
}

; ==============================================================================

; $0351BB-$0351BD DATA
Pool_GreenRupee_AbsorptionByPlayer:
{
    ; \task Name routines that use these locations.
    .rupee_quantities
    db 1, 5, 20
}

; ==============================================================================

; $0351BE-$0351D4 JUMP LOCATION
GreenRupee_AbsorptionByPlayer:
    shared BlueRupee_AbsorptionByPlayer:
    shared RedRupee_AbsorptionByPlayer:
{
    LDY.w $0E20, X
    
    LDA.b #$00 : XBA
    
    ; (actual useful values start at $351BB)
    ; Give us this many more rupees
    LDA .rupee_quantities-$D9, Y : REP #$20 : CLC : ADC.l $7EF360 : STA.l $7EF360
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0351D5-$0351D7 DATA
Pool_OneBombRefill_AbsorptionByPlayer:
{
    .refill_quantities
    db 1, 4, 8
}

; ==============================================================================

; $0351D8-$0351E7 JUMP LOCATION
OneBombRefill_AbsorptionByPlayer:
    shared FourBombRefill_AbsorptionByPlayer:
    shared EightBombRefill_AbsorptionByPlayer:
{
    LDY.w $0E20, X
    
    ; (actual useful values start at $351D5)
    LDA.w $D0F9, Y : CLC : ADC.l $7EF375 : STA.l $7EF375
    
    RTS
}

; ==============================================================================

; $0351E8-$0351F7 JUMP LOCATION
SmallMagicRefill_AbsorptionByPlayer:
{
    ; small magic decanter
    LDA.l $7EF373 : CLC : ADC.b #$10
    
    BRA .apply_refill_amount
    
    ; $0351F1 ALTERNATE ENTRY POINT
    shared FullMagicRefill_AbsorptionByPlayer:
    
    LDA.b #$80 ; Full magic decanter
    
    .apply_refill_amount
    
    STA.l $7EF373
    
    RTS
}

; ==============================================================================

; $0351F8-$03520C JUMP LOCATION
FiveArrowRefill_AbsorptionByPlayer:
{
    ; Number of arrows is stored as a property for this sprite
    LDA.w $0EB0, X : BNE .apply_refill_amount
    
    LDA.b #$05 ; if zero, give Link 5
    
    BRA .apply_refill_amount
    
    ; $035201 ALTERNATE ENTRY POINT
    shared TenArrowRefill_AbsorptionByPlayer:
    
    LDA.b #$0A ; Different upgrade type, gives 10 arrows
    
    .apply_refill_amount
    
    CLC : ADC.l $7EF376 : STA.l $7EF376
    
    RTS
}

; ==============================================================================

; $03520D-$03522E DATA
Pool_Sprite_DrawTransientAbsorbable:
{
    .unknown_0
    db 0, 1, 1, 1, 2, 2, 2, 0
    db 1, 1, 2, 2, 1, 2, 2
    
    .unknown_1
    db 0, 0, 0, 0, 1, 2, 3, 0
    db 0, 4, 5, 0,  0, 0, 0
    
    .unknown_2
    db 2, 4, 6, 2
}

; ==============================================================================

; $03522F-$035289 LOCAL JUMP LOCATION
Sprite_DrawTransientAbsorbable:
{
    JSR Sprite_HandleBlinkingPhaseOut
    
    ; $035232 ALTERNATE ENTRY POINT
    shared Sprite_DrawAbsorbable:
    
    LDA.w $0FB3 : BNE .dont_use_super_priority
    
    LDA $1B : BEQ .dont_use_super_priority
    
    LDA.b #$30 : STA.w $0B89, X
    
    .dont_use_super_priority
    
    LDA.w $0FC6 : CMP.b #$03 : BCS .improper_graphics_pack_loaded
    
    LDA.w $0E10, X : BEQ .dont_use_special_oam_region
    
    LDA.b #$0C : JSL OAM_AllocateFromRegionC
    
    .dont_use_special_oam_region
    
    ; \task find out under which circumstances this branch would be taken.
    LDA.w $0E90, X : BNE .easly_return_caller
    
    LDY.w $0E20, X
    
    LDA .unknown_1-$D8, Y : BEQ .not_suffixed_with_number
    
    JMP Sprite_DrawNumberedAbsorbable
    
    .not_suffixed_with_number
    
    LDA .unknown_0-$D8, Y : BNE .not_single_small_oam_entry
    
    JMP Sprite_PrepAndDrawSingleSmall
    
    .not_single_small_oam_entry
    
    CMP.b #$02 : BNE .is_thin_and_tall
    
    LDA.w $0E20, X : CMP.b #$E6 : BNE .not_shield_pickup
    
    LDA.w $0E30, X : CMP.b #$01 : BEQ .is_fighter_shield
    
    ; Hero shield (as opposed to fighter shield)?
    LDA.b #$01 : STA.w $0DC0, X
    
    .not_shield_pickup
    
    JMP Sprite_PrepAndDrawSingleLarge
    
    .is_fighter_shield
    .is_thin_and_tall
    
    JMP Sprite_DrawThinAndTall
    
    .easly_return_caller
    
    PLA : PLA
    
    .improper_graphics_pack_loaded
    
    RTS
}

; ==============================================================================

; $03528A-$0352AD DATA
Sprite_DrawNumberedAbsorbable:
{
    .x_offsets
    dw 0, 0, 8, 0, 0, 8, 0, 0
    dw 8, 0, 0, 2, 0, 0, 2, 0
    dw 0, 0
}
    
; ==============================================================================

    ; \wtf How exactly did this data array end up here and not closer
    ; to the octorock's code? Not that it hurts anything, it's just odd...
; $0352AE-$0352B1 DATA
Pool_Sprite_Octorock:
{
    .h_flip
    db $40, $00, $00, $00
}
    
; ==============================================================================

; $0352B2-$0352F9 DATA
Pool_Sprite_DrawNumberedAbsorbable:
{
    .y_offsets
    dw 0, 0, 8, 0, 0, 8, 0, 0
    dw 8, 0, 8, 8, 0, 8, 8, 0
    dw 8, 8
    
    .chr
    db $6E, $6E, $68, $6E, $6E, $78, $6E, $6E
    db $79, $63, $73, $69, $63, $73, $6A, $63
    db $73, $73
    
    .oam_sizes
    db $02, $02, $00, $02, $02, $00, $02, $02
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00
}
    
; ==============================================================================

; $0352FA-$035362 LOCAL JUMP LOCATION
Sprite_DrawNumberedAbsorbable:
{
    DEC A : STA $06
    
    JSR Sprite_PrepOamCoord
    
    ; $06 *= 3;
    LDA $06 : ASL A : ADC $06 : STA $06
    
    PHX
    
    LDA.w $0EB0, X : CMP.b #$01 : LDX.b #$02 : BCC .has_number
    
    ; Think this means that it doesn't have a number (like a single arrow
    ; refill such as one spawned by a thief or a pikit dying). \task
    ; investigate.
    DEX
    
    .has_number
    .next_oam_entry
    
    PHX
    
    TXA : CLC : ADC $06 : PHA
    
    ASL A : TAX
    
    REP #$20
    
    LDA $00 : CLC : ADC .x_offsets, X : STA ($90), Y
    
    AND.w #$0100 : STA $0E
    
    LDA $02 : CLC : ADC .y_offsets, X : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
    
    LDA.b #$F0 : STA ($90), Y
    
    .on_screen_y
    
    PLX
    
    LDA .chr, X : INY           : STA ($90), Y
                  INY : LDA $05 : STA ($90), Y
    
    PHY
    
    TYA : LSR A : LSR A : TAY
    
    LDA .oam_sizes, X : ORA $0F : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .next_oam_entry
    
    PLX
    
    JMP Sprite_DrawShadow
}

; ==============================================================================
