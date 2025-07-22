; ==============================================================================

; $0E9C7A-$0E9C7F DATA
Swamola_InitSegments_WRAM_offsets:
{
    db $00, $20, $40, $60, $80, $A0
}

; $0E9C80-$0E9CAC LONG JUMP LOCATION
Swamola_InitSegments:
{
    PHX : TXY
    
    ; BUG: (confirmed) This loads from the wrong bank when this function
    ; is called.
    LDA.w .WRAM_offsets, X : TAX
    
    LDA.b #$1F : STA.b $00
    
    .next_segment
    
        LDA.w $0D10, Y : STA.l $7FFA5C, X
        LDA.w $0D30, Y : STA.l $7FFB1C, X
        
        LDA.w $0D00, Y : STA.l $7FFBDC, X
        LDA.w $0D20, Y : STA.l $7FFC9C, X
        
        INX
    DEC.b $00 : BPL .next_segment
    
    PLX
    
    RTL
}

; ==============================================================================

; UNUSED: This pool seems to be completely unused.
; $0E9CAD-$0E9CAF DATA
Pool_Sprite_Swamola:
{
    db $00, $10, $F0
}

; $0E9CB0-$0E9CEC JUMP LOCATION
Sprite_Swamola:
{
    LDA.w $0D80, X : BEQ .dont_draw
        BPL .not_ripples
            JMP Sprite_SwamolaRipples
        
        .not_ripples
        
        JSR.w Swamola_Draw
    
    .dont_draw
    
    JSL.l Sprite_Get_16_bit_CoordsLong
    JSR.w Sprite4_CheckIfActive
    
    INC.w $0E80, X
    
    JSR.w Sprite4_CheckDamage
    
    LDA.w $0D40, X : PHA : CLC : ADC.w $0F80, X : STA.w $0D40, X
    
    JSR.w Sprite4_Move
    
    PLA : STA.w $0D40, X
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Swamola_Emerge              ; 0x00 - $9D19
    dw Swamola_Ascending           ; 0x01 - $9D67
    dw Swamola_WiggleTowardsTarget ; 0x02 - $9DA7
    dw Swamola_Descending          ; 0x03 - $9E32
    dw Swamola_Submerge            ; 0x04 - $9E62
}

; ==============================================================================

; $0E9CED-$0E9D18 DATA
Pool_Swamola_Submerged:
{
    ; $0E9CED
    .x_offsets_low
    db   0,   0,  32,  32,  32,   0, -32, -32
    db -32
    
    ; $0E9CF6
    .x_offsets_high
    db   0,   0,   0,   0,   0,   0,  -1,  -1
    db  -1
    
    ; $0E9CFF
    .x_offsets_low
    db   0, -32, -32,   0,  32,  32,  32,   0
    db -32
    
    ; $0E9D08
    .y_offsets_high
    db   0,  -1,  -1,   0,   0,   0,   0,   0
    db  -1
    
    ; $0E9D11
    .directions
    db 1, 2, 3, 4, 5, 6, 7, 8
}

; $0E9D19-$0E9D66 JUMP LOCATION
Swamola_Emerge:
{
    LDA.w $0DF0, X : BNE .delay
        JSL.l GetRandomInt : AND.b #$07 : TAY
        
        ; Seems like a staggering mechanism.
        LDA.w .directions, Y : CMP.w $0DE0, X : BEQ .direction_mismatch
            TAY
            
            LDA.w $0D90, X : CLC : ADC .x_offsets_low,  Y : STA.l $7FFD5C, X
            LDA.w $0DA0, X       : ADC .x_offsets_high, Y : STA.l $7FFD62, X
            
            LDA.w $0DB0, X : CLC : ADC .y_offsets_low,  Y : STA.l $7FFD68, X
            LDA.w $0EB0, X       : ADC .y_offsets_high, Y : STA.l $7FFD6E, X
            
            INC.w $0D80, X
            
            JSR.w Sprite4_Zero_XY_Velocity
            
            LDA.b #$F1 : STA.w $0F80, X
            
            JSR.w Swamola_SpawnRipples
            
        .direction_mismatch
    .delay
    
    RTS
}

; ==============================================================================

; $0E9D67-$0E9D7F JUMP LOCATION
Swamola_Ascending:
{
    LDA.w $0E80, X : AND.b #$03 : BNE .delay_upward_acceleration
        INC.w $0F80, X : BNE .delay_state_transition
            INC.w $0D80, X
        
        .delay_state_transition
    .delay_upward_acceleration
    
    ; Delay_speed_checks
    LDA.w $0E80, X : AND.b #$03 : BNE Swamola_ApproachPursuitSpeed_return
        JSR.w Swamola_PursueTargetCoord

        ; Bleeds into the next function.
}
    
; $0E9D80-$0E9DA2 JUMP LOCATION
Swamola_ApproachPursuitSpeed:
{  
    LDA.w $0D40, X : CMP.b $00 : BEQ .at_target_y_speed
        BPL .above_target_y_speed
            INC.w $0D40, X
            
            BRA .check_x_speed
        
        .above_target_y_speed
        
        DEC.w $0D40, X
        
    .at_target_y_speed
    .check_x_speed
    
    LDA.w $0D50, X : CMP.b $01 : BEQ .at_target_x_speed
        BPL .above_target_x_speed
            INC.w $0D50, X
            
            BRA .return
        
        .above_target_x_speed
        
        DEC.w $0D50, X
        
    .at_target_x_speed

    ; $0E9DA2 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $0E9DA3-$0E9DA6 DATA
Pool_Swamola_WiggleTowardsTarget:
{
    ; $0E9DA3
    .z_offsets
    db  2,  -2
    
    ; $0E9DA5
    .z_offset_limits
    db 12, -12
}

; $0E9DA7-$0E9E12 JUMP LOCATION
Swamola_WiggleTowardsTarget:
{
    ; UNUSED: The branch can never be taken (though we will end up there
    ; eventually).
    LDA.w $0E80, X : AND.b #$00 : BNE .never
        LDA.w $0ED0, X : AND.b #$01 : TAY
        
        LDA.w $0F80, X
        CLC : ADC Pool_Swamola_WiggleTowardsTarget_z_offsets, Y : STA.w $0F80, X
        
        CMP .z_offset_limits, Y : BNE .anotoggle_wiggle_direction
            INC.w $0ED0, X
        
        .anotoggle_wiggle_direction
    .never
    
    LDA.l $7FFD5C, X : STA.b $04
    LDA.l $7FFD62, X : STA.b $05
    
    LDA.l $7FFD68, X : STA.b $06
    LDA.l $7FFD6E, X : STA.b $07
    
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.b $04 : CLC : ADC.w #$0008 : CMP.w #$0010 : BCS .not_at_target
        LDA.w $0FDA : SEC : SBC.b $06 : CLC : ADC.w #$0008 : CMP.w #$0010 : BCS .not_at_target
            SEP #$20
            
            INC.w $0D80, X
        
    .not_at_target
    
    SEP #$20
    
    JSR.w Swamola_PursueTargetCoord
    
    LDA.b $00 : STA.w $0D40, X
    LDA.b $01 : STA.w $0D50, X
    
    RTS
}

; ==============================================================================

; $0E9E13-$0E9E31 LOCAL JUMP LOCATION
Swamola_PursueTargetCoord:
{
    LDA.l $7FFD5C, X : STA.b $04
    LDA.l $7FFD62, X : STA.b $05
    
    LDA.l $7FFD68, X : STA.b $06
    LDA.l $7FFD6E, X : STA.b $07
    
    LDA.b #$0F : JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    RTS
}

; ==============================================================================

; $0E9E32-$0E9E61 JUMP LOCATION
Swamola_Descending:
{
    LDA.w $0E80, X : AND.b #$03 : BNE .delay_altitude_check
        INC.w $0F80, X : LDA.w $0F80, X : CMP.b #$10 : BNE .continue_descent
            INC.w $0D80, X
            
            JSR.w Swamola_SpawnRipples
            
            ; Puts the sprite out of harm's way and can't damage the player.
            LDA.b #$80 : STA.w $0D20, X
            LDA.b #$50 : STA.w $0DF0, X
        
        .continue_descent
    .delay_altitude_check
    
    LDA.w $0E80, X : AND.b #$03 : BNE .delay_speed_adjustment
        STZ.b $00
        STZ.b $01
        
        JSR.w Swamola_ApproachPursuitSpeed
    
    .delay_speed_adjustment
    
    RTS
}

; ==============================================================================

; $0E9E62-$0E9EA9 JUMP LOCATION
Swamola_Submerge:
{
    LDA.w $0DF0, X : BNE .delay
        JSL.l GetRandomInt : AND.b #$07 : TAY
        
        LDA Swamola_Emerge_directions, Y : STA.w $0DE0, X : TAY
        
        LDA.w $0D90, X : CLC : ADC Swamola_Emerge_x_offsets_low,  Y : STA.w $0D10, X
        LDA.w $0DA0, X       : ADC Swamola_Emerge_x_offsets_high, Y : STA.w $0D30, X
        
        LDA.w $0DB0, X : CLC : ADC Swamola_Emerge_y_offsets_low,  Y : STA.w $0D00, X
        LDA.w $0EB0, X       : ADC Swamola_Emerge_y_offsets_high, Y : STA.w $0D20, X
        
        STZ.w $0D80, X
        
        LDA.b #$30 : STA.w $0DF0, X
        
        JSR.w Sprite4_Zero_XY_Velocity
        
        STZ.w $0F80, X
        
    .delay
    
    RTS
}

; ==============================================================================

; $0E9EAA-$0E9ECD LOCAL JUMP LOCATION
Swamola_SpawnRipples:
{
    LDA.b #$CF : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b #$80 : STA.w $0D80, Y
        
        LDA.b #$20 : STA.w $0DF0, Y
        
        LDA.b #$04 : STA.w $0F50, Y
                     STA.w $0BA0, Y
        
        LDA.b #$00 : STA.w $0E40, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0E9ECE-$0E9EDC LOCAL JUMP LOCATION
Sprite_SwamolaRipples:
{
    JSR.w SwamolaRipples_Draw
    JSR.w Sprite4_CheckIfActive
    
    LDA.w $0DF0, X : BNE .delay
        STZ.w $0DD0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0E9EDD-$0E9F1C DATA
SwamolaRipples_Draw_OAM_groups:
{
    dw 0, 4 : db $D8, $00, $00, $00
    dw 8, 4 : db $D8, $40, $00, $00
    
    dw 0, 4 : db $D9, $00, $00, $00
    dw 8, 4 : db $D9, $40, $00, $00
    
    dw 0, 4 : db $DA, $00, $00, $00
    dw 8, 4 : db $DA, $40, $00, $00
    
    dw 0, 4 : db $D9, $00, $00, $00
    dw 8, 4 : db $D9, $40, $00, $00
}

; $0E9F1D-$0E9F3B LOCAL JUMP LOCATION
SwamolaRipples_Draw:
{
    LDA.b #$08 : JSL.l OAM_AllocateFromRegionB
    
    LDA.b #$00 : XBA
    LDA.w $0DF0, X : AND.b #$0C : REP #$20 : ASL : ASL
    
    CLC : ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JMP Sprite4_DrawMultiple
}

; ==============================================================================

; $0E9F3C-$0E9F63 DATA
Pool_Swamola_Draw:
{
    ; $0E9F3C
    .unknown_0
    db $08, $10, $16, $1A
    
    ; $0E9F40
    .head_animation_states
    db 7, 6, 5, 4, 3, 4, 5, 6
    db 7, 6, 5, 4, 3, 4, 5, 6
    
    ; BUG: Is that a bug in the last 4 bytes? How irregular.
    ; $0E9F50
    .head_vh_flip
    db $C0, $C0, $C0, $C0, $80, $80, $80, $80
    db $00, $00, $00, $00, $00, $40, $40, $40
    
    ; $0E9F60
    .segment_animation_states
    db 0, 0, 1, 2
}

; $0E9F64-$0EA03B LOCAL JUMP LOCATION
Swamola_Draw:
{
    LDA.w $0D50, X : STA.b $01
    
    LDA.w $0D40, X : CLC : ADC.w $0F80, X : STA.b $00
    
    JSL.l Sprite_ConvertVelocityToAngle : TAY
    
    LDA.w Pool_Swamola_Draw_head_animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0F50, X
    AND.b #$3F : ORA Pool_Swamola_Draw_head_vh_flip, Y : STA.w $0F50, X
    
    ; Draw the head portion.
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    
    PHX : TXY
    
    LDA.w $0E80, X
    AND.b #$1F : CLC : ADC.w Swamola_InitSegments_WRAM_offsets, X : TAX
    
    LDA.w $0D10, Y : STA.l $7FFA5C, X
    LDA.w $0D30, Y : STA.l $7FFB1C, X
    
    LDA.w $0D00, Y : STA.l $7FFBDC, X
    LDA.w $0D20, Y : STA.l $7FFC9C, X
    
    PLX
    
    REP #$20
    
    LDA.w #$0000
    
    LDY.w $0D40, X : BPL .moving_downward
        LDA.w #$0014
    
    .moving_downward
    
    PHA : CLC : ADC.b $90 : STA.b $90
    
    PLA : LSR : LSR : CLC : ADC.b $92 : STA.b $92
    
    SEP #$20
    
    LDA.b #$00 : STA.w $0FB6
    
    .segment_draw_loop
    
        LDY.w $0FB6
        
        LDA.w Pool_Swamola_Draw_segment_animation_states, Y : STA.w $0DC0, X
        
        PHX
        
        LDA.w $0E80, X
        SEC : SBC Pool_Swamola_Draw_unknown_0, Y : AND.b #$1F
        CLC : ADC.w Swamola_InitSegments_WRAM_offsets, X : TAX
        
        LDA.l $7FFA5C, X : STA.w $0FD8
        LDA.l $7FFB1C, X : STA.w $0FD9
        
        LDA.l $7FFBDC, X : STA.w $0FDA
        LDA.l $7FFC9C, X : STA.w $0FDB
        
        PLX
        
        LDA.w $0D40, X : BPL .moving_downward_2
            REP #$20
            
            ; TODO: Subtraction? What is going on here?
            LDA.b $90 : SEC : SBC.w #$0004 : STA.b $90
            
            DEC.b $92
            
            BRA .draw_segment
            
        .moving_downward_2
        
        REP #$20
        
        LDA.b $90 : CLC : ADC.w #$0004 : STA.b $90
        
        INC.b $92
        
        .draw_segment
        
        SEP #$20
        
        JSL.l Sprite_PrepAndDrawSingleLargeLong
    INC.w $0FB6 : LDA.w $0FB6 : CMP.b #$04 : BNE .segment_draw_loop
    
    RTS
}

; ==============================================================================
