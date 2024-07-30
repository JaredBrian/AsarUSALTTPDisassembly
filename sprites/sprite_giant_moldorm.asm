
; ==============================================================================

; $0ED6D1-$0ED6F5 LONG JUMP LOCATION
Sprite_InitializedSegmented:
{
    PHX : TXY
    
    LDX.b #$7F
    
    .init_segment_loop
    
    LDA.w $0D10, Y : STA.l $7FFC00, X
    LDA.w $0D30, Y : STA.l $7FFC80, X
    
    LDA.w $0D00, Y : STA.l $7FFD00, X
    LDA.w $0D20, Y : STA.l $7FFD80, X
    
    DEX : BPL .init_segment_loop
    
    PLX
    
    RTL
}

; ==============================================================================

; $0ED6F6-$0ED6FD LONG JUMP LOCATION
Sprite_GiantMoldormLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_GiantMoldorm
    
    PLB
    
    RTL
}

; ==============================================================================

; $0ED6FE-$0ED74D DATA
Pool_Sprite_GiantMoldorm:
{
    .x_speeds
    db  24,  22,  17,   9,   0,   -9, -17, -22
    db -24, -22, -17,  -9,   0,    9,  17,  22
    db  36,  33,  25,  13,   0,  -13, -25, -33
    db -36, -33, -25, -13,   0,   13,  25,  33
    
    .y_speeds
    db   0,   9,  17,  22,  24,  22,  17,   9
    db   0,  -9, -17, -22, -24, -22, -17,  -9
    db   0,  13,  25,  33,  36,  33,  25,  13
    db   0, -13, -25, -33, -36, -33, -25, -13
    
    .direction
    db  8,  9, 10, 11, 12, 13, 14, 15
    db  0,  1,  2,  3,  4,  5,  6,  7
}

; ==============================================================================

; $0ED74E-$0ED7FD LOCAL JUMP LOCATION
Sprite_GiantMoldorm:
{
    JSR GiantMoldorm_Draw
    JSR Sprite4_CheckIfActive
    
    LDA.w $0D80, X : CMP.b #$03 : BNE .not_scheduled_for_death
    
    JMP GiantMoldorm_AwaitDeath
    
    .not_scheduled_for_death
    
    JSL Sprite_CheckDamageFromPlayerLong
    
    LDA.b #$07
    
    LDY.w $0E50, X : CPY.b #$03 : BCS .not_desperate_yet
    
    INC.w $0E80, X
    
    LDA.b #$03
    
    .not_desperate_yet
    
    INC.w $0E80, X
    
    AND.b $1A : BNE .skip_sound_effect_this_frame
    
    LDA.b #$31 : JSL Sound_SetSfx3PanLong
    
    .skip_sound_effect_this_frame
    
    LDA.w $0EA0, X : BEQ .not_stunned_from_damage
    
    LDA.b #$40 : STA !timer_2, X
    
    LDA.b $1A : AND.b #$03 : BNE .stun_timer_delay
    
    DEC.w $0EA0, X
    
    .stun_timer_delay
    
    RTS
    
    .not_stunned_from_damage
    
    LDA.b $46 : BNE .dont_repulse_player
    
    JSL Sprite_CheckDamageToPlayerLong : BCC .dont_repulse_player
    
    JSL Player_HaltDashAttackLong
    
    LDA.b #$28 : JSL Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA.b $00 : STA.b $27
    
    LDA.b $01 : STA.b $28
    
    LDA.b #$18 : STA.b $46
    
    LDA.b #$30 : STA !timer_1, X
    
    ; Wait... how does this work? This value gets overriden by the call...
    ; I think this may be a certified BUG:
    LDA.b #$32 : JSL Sound_SetSfxPan : STA.w $012F
    
    .dont_repulse_player
    
    LDY.w $0DE0, X
    
    LDA.w $0E50, X : CMP.b #$03 : BCS .not_desperate_2
    
    TYA : CLC : ADC.b #$10 : TAY
    
    .not_desperate_2
    
    LDA .x_speeds, Y : STA.w $0D50, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    JSR Sprite4_Move
    
    JSR Sprite4_CheckTileCollision : BEQ .no_tile_collision
    
    LDY.w $0DE0, X
    
    LDA .directions, Y : STA.w $0DE0, X
    
    ; I guess... this is where the ticking sound comes from?
    LDA.b #$21 : JSL Sound_SetSfx2PanLong
    
    .no_tile_collision
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw GiantMoldorm_StraightPath
    dw GiantMoldorm_SpinningMeander
    dw GiantMoldorm_LungeAtPlayer
}

; ==============================================================================

; $0ED7FE-$0ED82C JUMP LOCATION
GiantMoldorm_StraightPath:
{
    LDA !timer_0, X : BNE .wait
    
    LDA.b #$01
    
    INC.w $0ED0, X : LDY.w $0ED0, X : CPY.b #$03 : BNE .beta
    
    STZ.w $0ED0, X
    
    LDA.b #$02
    
    .beta
    
    STA.w $0D80, X
    
    ; NOTE: Resultant value is either 1 or -1.
    JSL GetRandomInt : AND.b #$02 : DEC A : STA.w $0EB0, X
    
    JSL GetRandomInt : AND.b #$1F : ADC.b #$20 : STA !timer_0, X
    
    .wait
    
    RTS
}

; ==============================================================================

; $0ED82D-$0ED851 JUMP LOCATION
GiantMoldorm_SpinningMeander:
{
    LDA !timer_0, X : BNE .wait
    
    JSL GetRandomInt : AND.b #$0F : ADC.b #$08 : STA !timer_0, X
    
    STZ.w $0D80, X
    
    RTS
    
    .wait
    
    AND.b #$03 : BNE .dont_adjust_direction
    
    LDA.w $0DE0, X : CLC : ADC.w $0EB0, X : AND.b #$0F : STA.w $0DE0, X
    
    .dont_adjust_direction
    
    RTS
}

; ==============================================================================

; $0ED852-$0ED880 JUMP LOCATION
GiantMoldorm_LungeAtPlayer:
{
    TXA : EOR.b $1A : AND.b #$03 : BNE .frame_delay
    
    LDA.b #$1F : JSL Sprite_ApplySpeedTowardsPlayerLong
    
    JSL Sprite_ConvertVelocityToAngle
    
    CMP.w $0DE0, X : BNE .current_direction_doesnt_match
    
    STZ.w $0D80, X
    
    LDA.b #$30 : STA !timer_0, X
    
    RTS
    
    .current_direction_doesnt_match
    
    PHP : LDA.w $0DE0, X : PLP : BMI .rotate_one_way
    
    ; rotate the other way... don't know if it's clockwise or counter
    ; clockwise.
    INC #2
    
    .rotate_one_way
    
    DEC A : AND.b #$0F : STA.w $0DE0, X
    
    .frame_delay
    
    RTS
}

; ==============================================================================

; $0ED881-$0ED8F1 LOCAL JUMP LOCATION
GiantMoldorm_Draw:
{
    JSR Sprite4_PrepOamCoord
    
    LDA.b #$0B : STA.w $0F50, X
    
    JSR GiantMoldorm_DrawEyeballs
    
    REP #$20
    
    LDA.b $90 : CLC : ADC.w #$0008 : STA.b $90
    
    INC.b $92 : INC.b $92
    
    SEP #$20
    
    PHX : TXY
    
    LDA.w $0E80, X : AND.b #$7F : TAX
    
    LDA.w $0D10, Y : STA.l $7FFC00, X
    LDA.w $0D00, Y : STA.l $7FFD00, X
    
    LDA.w $0D30, Y : STA.l $7FFC80, X
    LDA.w $0D20, Y : STA.l $7FFD80, X
    
    PLX
    
    JSR GiantMoldorm_DrawHead
    
    LDA.w $0DA0, X : CMP.b #$04 : BCS .dont_draw_segment
    
    JSR GiantMoldorm_DrawSegment_A
    
    LDA.w $0DA0, X : CMP.b #$03 : BCS .dont_draw_segment
    
    JSR GiantMoldorm_DrawSegment_B
    
    LDA.w $0DA0, X : CMP.b #$02 : BCS .dont_draw_segment
    
    JSR GiantMoldorm_DrawSegment_C
    
    LDA.w $0DA0, X : BNE .dont_draw_segment
    
    JSR GiantMoldorm_Tail
    
    .dont_draw_segment
    
    JSR GiantMoldorm_IncrementalSegmentExplosion
    JSL Sprite_Get_16_bit_CoordsLong
    
    RTS
}

; ==============================================================================

; $0ED8F2-$0ED912 LOCAL JUMP LOCATION
GiantMoldorm_IncrementalSegmentExplosion:
{
    LDA.w $0DD0, X : CMP.b #$09 : BNE .alive_and_well
    
    LDA !timer_4, X : BEQ .delay_explosion
    CMP.b #$50      : BCS .delay_explosion
    
    AND.b #$0F : ORA.b $11 : ORA.w $0FC1 : BNE .delay_explosion
    
    ; Move on to the next segment.
    INC.w $0DA0, X
    
    JSL Sprite_MakeBossDeathExplosion
    
    .delay_explosion
    .alive_and_well
    
    RTS
}

; ==============================================================================

; $0ED913-$0ED992 DATA
Pool_GiantMoldorm_DrawHead:
{
    .oam_groups
    dw -8, -8 : db $80, $00, $00, $02
    dw  8, -8 : db $82, $00, $00, $02
    dw -8,  8 : db $A0, $00, $00, $02
    dw  8,  8 : db $A2, $00, $00, $02
    
    dw -8, -8 : db $82, $40, $00, $02
    dw  8, -8 : db $80, $40, $00, $02
    dw -8,  8 : db $A2, $40, $00, $02
    dw  8,  8 : db $A0, $40, $00, $02
    
    dw -6, -6 : db $80, $00, $00, $02
    dw  6, -6 : db $82, $00, $00, $02
    dw -6,  6 : db $A0, $00, $00, $02
    dw  6,  6 : db $A2, $00, $00, $02
    
    dw -6, -6 : db $82, $40, $00, $02
    dw  6, -6 : db $80, $40, $00, $02
    dw -6,  6 : db $A2, $40, $00, $02
    dw  6,  6 : db $A0, $40, $00, $02
}

; ==============================================================================

; $0ED993-$0ED9B7 LOCAL JUMP LOCATION
GiantMoldorm_DrawHead:
{
    LDA.b #$00 : XBA
    
    LDA !timer_1, X : AND.b #$02 : STA.b $00
    
    LDA.w $0E80, X : LSR A : AND.b #$01 : ORA.b $00
    
    REP #$20
    
    ASL #5 : ADC.w #.oam_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$04 : JMP Sprite4_DrawMultiple
}

; ==============================================================================

; $0ED9B8-$0ED9F7 DATA
Pool_GiantMoldorm_DrawSegment_A:
{
    .oam_groups
    dw -8, -8 : db $84, $00, $00, $02
    dw  8, -8 : db $86, $00, $00, $02
    dw -8,  8 : db $A4, $00, $00, $02
    dw  8,  8 : db $A6, $00, $00, $02
    
    dw -8, -8 : db $86, $40, $00, $02
    dw  8, -8 : db $84, $40, $00, $02
    dw -8,  8 : db $A6, $40, $00, $02
    dw  8,  8 : db $A4, $40, $00, $02
}

; ==============================================================================

    ; NOTE: The segment nearest the head.
; $0ED9F8-$0EDA4F LOCAL JUMP LOCATION
GiantMoldorm_DrawSegment_A:
{
    TXY
    
    PHX
    
    LDA.w $0E80, X : SEC : SBC.b #$10
    
    ; $0EDA00 ALTERNATE ENTRY POINT
    shared GiantMoldorm_DrawLargeSegment:
    
    AND.b #$7F : TAX
    
    LDA.l $7FFC00, X : STA.w $0FD8
    LDA.l $7FFC80, X : STA.w $0FD9
    
    LDA.l $7FFD00, X : STA.w $0FDA
    LDA.l $7FFD80, X : STA.w $0FDB
    
    PLX
    
    LDA.b #$00 : XBA
    
    LDA.w $0E80, X : LSR A : AND.b #$01
    
    REP #$20
    
    ASL #5 : ADC.w #.oam_groups : STA.b $08
    
    REP #$20
    
    LDA.b $90 : CLC : ADC.w #$0010 : STA.b $90
    
    LDA.b $92 : CLC : ADC.w #$0004 : STA.b $92
    
    SEP #$20
    
    SEP #$20
    
    LDA.b #$04
    
    JMP Sprite4_DrawMultiple
}

; ==============================================================================

; $0EDA50-$0EDA5A LOCAL JUMP LOCATION
GiantMoldorm_DrawSegment_B:
{
    TXY
    
    PHX
    
    LDA.w $0E80, X : SEC : SBC.b #$1C
    
    JMP GiantMoldorm_DrawLargeSegment
}

; ==============================================================================

; $0EDA5B-$0EDA5E DATA
Pool_GiantMoldorm_DrawSegment_C:
{
    .vh_flip
    db $00, $40, $C0, $80
}

; ==============================================================================

; $0EDA5F-$0EDAB9 LOCAL JUMP LOCATION
GiantMoldorm_DrawSegment_C:
{
    STZ.w $0DC0, X
    
    REP #$20
    
    LDA.b $90 : CLC : ADC.w #$0010 : STA.b $90
    
    LDA.b $92 : CLC : ADC.w #$0004 : STA.b $92
    
    SEP #$20
    
    TXY
    
    PHX
    
    LDA.w $0E80, X : SEC : SBC.b #$28
    
    ; $0EDA7E ALTERNATE ENTRY POINT
    shared GiantMoldorm_PrepAndDrawSingleLargeLong:
    
    AND.b #$7F : TAX
    
    LDA.l $7FFC00, X : STA.w $0FD8
    LDA.l $7FFC80, X : STA.w $0FD9
    
    LDA.l $7FFD00, X : STA.w $0FDA
    LDA.l $7FFD80, X : STA.w $0FDB
    
    PLX
    
    LDA.w $0E80, X : LSR A : AND.b #$03 : TAY
    
    LDA.w $0F50, X : PHA
    
    AND.b #$3F : ORA .vh_flip, Y : STA.w $0F50, X
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    PLA : STA.w $0F50, X
    
    RTS
}

; ==============================================================================

; $0EDABA-$0EDB16 LOCAL JUMP LOCATION
GiantMoldorm_Tail:
{
    JSR GiantMoldorm_DrawTail
    
    LDA !timer_2, X : BNE .temporarily_invulnerable
    
    LDA.b #$01 : STA.w $0D90, X
    
    STZ.w $0F60, X
    STZ.w $0CAA, X
    
    LDA.w $0D10, X : PHA
    LDA.w $0D30, X : PHA
    
    LDA.w $0D00, X : PHA
    LDA.w $0D20, X : PHA
    
    LDA.w $0FD8 : STA.w $0D10, X
    LDA.w $0FD9 : STA.w $0D30, X
    
    LDA.w $0FDA : STA.w $0D00, X
    LDA.w $0FDB : STA.w $0D20, X
    
    JSL Sprite_CheckDamageFromPlayerLong
    
    STZ.w $0D90, X
    
    LDA.b #$09 : STA.w $0F60, X
    LDA.b #$04 : STA.w $0CAA, X
    
    PLA : STA.w $0D20, X
    PLA : STA.w $0D00, X
    
    PLA : STA.w $0D30, X
    PLA : STA.w $0D10, X
    
    .temporarily_invulnerable
    
    RTS
}

; ==============================================================================

; $0EDB17-$0EDB3D LOCAL JUMP LOCATION
GiantMoldorm_DrawTail:
{
    REP #$20
    
    LDA.b $90 : CLC : ADC.w #$0004 : STA.b $90
    
    LDA.b $92 : CLC : ADC.w #$0001 : STA.b $92
    
    SEP #$20
    
    INC.w $0DC0, X
    
    LDA.b #$0D : STA.w $0F50, X
    
    TXY
    PHX
    
    LDA.w $0E80, X : SEC : SBC.b #$30
    
    JMP GiantMoldorm_PrepAndDrawSingleLargeLong
}

; ==============================================================================

; $0EDB3E-$0EDB9D DATA
Pool_GiantMoldorm_DrawEyeballs:
{
    .x_offsets
    dw  16,  15,  12,   6,   0,  -6, -12, -13
    dw -16, -13, -12,  -6,   0,   6,  12,  15
    
    .y_offsets
    dw   0,   6,  12,  15,  16,  15,  12,   6
    dw   0,  -6, -12, -13, -16, -13, -12,  -6
    
    .chr
    db $AA, $AA, $A8, $A8, $8A, $8A, $A8, $A8
    db $AA, $AA, $A8, $A8, $8A, $8A, $A8, $A8
    
    .vh_flip
    db $00, $00, $00, $00, $80, $80, $40, $40
    db $40, $40, $C0, $C0, $00, $00, $80, $80
}

; ==============================================================================

; $0EDB9E-$0EDC10 LOCAL JUMP LOCATION
GiantMoldorm_DrawEyeballs:
{
    STZ.b $07
    
    LDA.w $0EA0, X : BEQ .dont_accelerate_eyerolling
    
    LDA.b $1A : STA.b $07
    
    .dont_accelerate_eyerolling
    
    LDA.w $0DE0, X : CLC : ADC.b #$FF : STA.b $06
    
    PHX
    
    LDX.b #$01
    
    .draw_eyes_loop
    
    LDA.b $06 : AND.b #$0F : ASL A : PHX : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC .x_offsets, X : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : CLC : ADC .y_offsets, X : INY : STA ($90), Y
    
    ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
    
    LDA.b #$F0 : STA ($90), Y
    
    .on_screen_y
    
    LDA.b $06 : CLC : ADC.b $07 : AND.b #$0F : TAX
    
    LDA .chr, X : INY : STA ($90), Y
    
    LDA .vh_flip, X : ORA.b $05 : INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b $0F : ORA.b #$02 : STA ($92), Y
    
    LDA.b $06 : CLC : ADC.b #$02 : STA.b $06
    
    PLY : INY
    
    PLX : DEX : BPL .draw_eyes_loop
    
    PLX
    
    RTS
}

; ==============================================================================

; $0EDC11-$0EDC29 JUMP LOCATION
GiantMoldorm_AwaitDeath:
{
    LDA !timer_4, X : BNE .delay
    
    ; $0EDC16 ALTERNATE ENTRY POINT
Sprite_ScheduleBossForDeath:
    
    LDA.b #$04 : STA.w $0DD0, X
    
    STZ.w $0D90, X
    
    LDA.b #$E0 : STA !timer_0, X
    
    RTS
    
    .delay
    
    ORA.b #$E0 : STA.w $0EF0, X
    
    RTS
}

; ==============================================================================

; $0EDC2A-$0EDC71 LONG JUMP LOCATION
Sprite_MakeBossDeathExplosion:
{
    LDA.b #$0C : JSL Sound_SetSfx2PanLong
    
    ; $0EDC30 ALTERNATE ENTRY POINT
    .silent
    
    ; Spawn a.... raven? What? Oh it's just a dummy sprite that will be
    ; transmuted to an explosion.
    LDA.b #$00 : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA.b #$0B : STA.w $0AAA
    
    LDA.b #$04 : STA.w $0DD0, Y
    LDA.b #$03 : STA.w $0E40, Y
    LDA.b #$0C : STA.w $0F50, Y
    
    LDA.w $0FD8 : STA.w $0D10, Y
    LDA.w $0FD9 : STA.w $0D30, Y
    
    LDA.w $0FDA : STA.w $0D00, Y
    LDA.w $0FDB : STA.w $0D20, Y
    
    LDA.b #$1F : STA !timer_0, Y
                 STA.w $0D90, Y
    
    LDA.b #$02 : STA.w $0F20, Y
    
    .spawn_failed
    
    RTL
}

; ==============================================================================
