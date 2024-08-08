; =============================================================================

; NOTE: This sprite uses $0B08[0x05] as some extra scratch ram. This is
; probably ill-advised, but bosses always seem to want to break the rules.
;
; $0B08[0x02] - 
;   Accumulator for angular offset of the Arrgi?
; 
; $0B0A[0x01] - 
;   Radius of Arrgi during the swarm attack.
;
; $0B0B[0x01] - 
;   Counter for number of times Arrghus has accelerated and then
;   decelerated. When it hits 4, it resets to 0, and a swarm attack with
;   the Arrgi occurs.
;
; $0B0C[0x01] - 
;   Amount to increase the angular offset by each frame. Normally 1 unless
;   the swarm attack is in effect, in which it is set to 8 temporarily.

; =============================================================================

; $0F342A-$0F3432 DATA
Sprite_Arrghus_animation_states:
{
    db $01, $01, $01, $02, $02, $01, $01, $00
    db $00
}

; $0F3433-$0F34C9 JUMP LOCATION
Sprite_Arrghus:
{
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSR.w Arrghus_Draw
    
    LDA.w $0DD0, X : CMP.b #$09 : BNE .dying
        LDA.w $0F70, X : CMP.b #$60 : BCS .ignore_activity_check
    
    .dying
    
    JSR.w Sprite3_CheckIfActive
    
    .ignore_activity_check
    
    JSR.w Arrghus_HandlePuffs
    
    LDA.b #$01 : STA.w $0B0C
    
    LDA.w $0EF0, X : AND.b #$7F : CMP.b #$02 : BNE .BRANCH_GAMMA
        JSR.w Arrghus_InitiateJumpWayUp
        
        ; Make it impervious temporarily...
        LDA.b #$40 : STA.w $0E60, X
    
    .BRANCH_GAMMA
    
    JSR.w Sprite3_CheckIfRecoiling
    JSR.w Sprite3_CheckDamageToPlayer
    
    LDA.w $0E80, X : INC.w $0E80, X : AND.b #$03 : BNE .BRANCH_DELTA
        INC.w $0ED0, X : LDA.w $0ED0, X : CMP.b #$09 : BNE .BRANCH_EPSILON
            STZ.w $0ED0, X
        
        .BRANCH_EPSILON
        
        LDY.w $0ED0, X
        
        LDA.w .animation_states, Y : STA.w $0DC0, X
    
    .BRANCH_DELTA
    
    JSR.w Sprite3_CheckTileCollision : BEQ .no_tile_collision
        LDY.w $0D80, X : CPY.b #$05 : BNE .ignore_collision_result
            AND.b #$03 : BEQ .no_horiz_collision
                LDA.w $0D50, X : EOR.b #$FF : INC A : STA.w $0D50, X
                
                BRA .run_subprogram
            
            .no_horiz_collision
            
            LDA.w $0D40, X : EOR.b #$FF : INC A : STA.w $0D40, X
            
            BRA .run_subprogram
        
        .ignore_collision_result
        
        JSR.w Sprite3_Zero_XY_Velocity
        
        .run_subprogram
    .no_tile_collision
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Arrghus_ApproachTargetSpeed ; 0x00 - $B593
    dw Arrghus_MakeDecision        ; 0x01 - $B5C8
    dw Arrghus_PuffAttack          ; 0x02 - $B63D
    dw Arrghus_JumpWayUp           ; 0x03 - $B4CA
    dw Arrghus_SmooshFromAbove     ; 0x04 - $B4EF
    dw Arrghus_SwimFrantically     ; 0x05 - $B532
}

; ==============================================================================

; $0F34CA-$0F34EE JUMP LOCATION
Arrghus_JumpWayUp:
{
    LDA.b #$78 : STA.w $0F80, X
    
    JSR.w Sprite3_MoveAltitude
    
    LDA.w $0F70, X : CMP.b #$E0 : BCC .continue_rising
        LDA.b #$40 : STA.w $0DF0, X
        
        INC.w $0D80, X
        
        STZ.w $0F80, X
        
        ; Try to plop down on the player by matching their coordinates.
        LDA.b $22 : STA.w $0D10, X
        
        LDA.b $20 : STA.w $0D00, X
    
    .continue_rising
    
    RTS
}

; ==============================================================================

; $0F34EF-$0F3531 JUMP LOCATION
Arrghus_SmooshFromAbove:
{
    LDA.w $0DF0, X : BNE .delay
        LDA.b #$90 : STA.w $0F80, X
        
        LDA.w $0F70, X : PHA
        
        JSR.w Sprite3_MoveAltitude
        
        PLA : EOR.w $0F70, X : BPL .didnt_touch_down
            LDA.w $0F70, X : BPL .didnt_touch_down
                STZ.w $0F70, X
                
                JSL.l Sprite_SpawnSplashRingLong
                
                INC.w $0D80, X
                
                LDA.b #$20 : STA.w $0DF0, X
                
                LDA.b #$03 : JSL.l Sound_SetSfx3PanLong
                
                LDA.b #$20 : STA.w $0D50, X : STA.w $0D40, X
        
        .didnt_touch_down
    .delay
    
    DEC A : BNE .dont_play_falling_sound
        LDA.b #$20 : JSL.l Sound_SetSfx2PanLong
    
    .dont_play_falling_sound
    
    RTS
}

; ==============================================================================

; $0F3532-$0F3592 JUMP LOCATION
Arrghus_SwimFrantically:
{
    LDA.w $0DF0, X : BNE .delay
        ; Unset impervious status.
        STZ.w $0E60, X
        
        JSR.w Sprite3_Move
        JSL.l Sprite_CheckDamageFromPlayerLong
        
        LDA.b $1A : AND.b #$07  BNE .garnish_delay
            LDA.b #$28 : JSL.l Sound_SetSfx2PanLong
            
            PHX : TXY
            
            LDX.b #$1D
            
            LDA.w $0D40, Y : BMI .use_full_range
                LDX.b #$0E
            
            .use_full_range

            .try_another_index
            
                LDA.l $7FF800, X : BNE .slot_in_use
                    LDA.b #$15 : STA.l $7FF800, X : STA.w $0FB4
                    
                    LDA.w $0D10, Y : STA.l $7FF83C, X
                    LDA.w $0D30, Y : STA.l $7FF878, X
                    
                    LDA.w $0D00, Y : CLC : ADC.b #$18 : STA.l $7FF81E, X
                    LDA.w $0D20, Y                    : STA.l $7FF85A, X
                    
                    LDA.b #$0F : STA.l $7FF90E, X
                    
                    PLX
                    
                    RTS
                
                .slot_in_use
            DEX : BPL .try_another_index
            
            PLX
        
        .garnish_delay
    .delay
    
    RTS
}

; ==============================================================================

; $0F3593-$0F35C7 JUMP LOCATION
Arrghus_ApproachTargetSpeed:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$30 : STA.w $0DF0, X
    
    .delay
    
    JSR.w Sprite3_Move
    
    LDA.w $0D50, X : CMP.w $0EB0, X : BEQ .x_speed_matches_target
        BPL .decrease_x_speed
            INC.w $0D50, X
            
            BRA .check_y_speed
        
        .decrease_x_speed
        
        DEC.w $0D50, X
    
    .x_speed_matches_target
    .check_y_speed
    
    LDA.w $0D40, X : CMP.w $0DE0, X : BEQ .y_speed_matches_target
        BPL .decrease_y_speed
            INC.w $0D40, X
            
            BRA .return
        
        .decrease_y_speed
        
        DEC.w $0D40, X
        
        .return
    .y_speed_matches_target
    
    RTS
}

; ==============================================================================

; $0F35C8-$0F35ED JUMP LOCATION
Arrghus_MakeDecision:
{
    LDA.w $0DF0, X : BNE Arrghus_Decelerate
        STZ.w $0D80, X
        
        ; Checks to see if all his bebehs are ded.
        JSL.l Sprite_VerifyAllOnScreenDefeated : BCS Arrghus_InitiateJumpWayUp
            ; Note: Wtf Arrghus... why you dipping into Overlord memory
            ; regions?
            INC.w $0B0B : LDA.w $0B0B : CMP.b #$04 : BNE Arrghus_TargetLink
                STZ.w $0B0B
                
                LDA.b #$02 : STA.w $0D80, X
                
                LDA.b #$B0 : STA.w $0DF0, X
                
                RTS
}
    
; $0F35EE-$0F35FC JUMP LOCATION
Arrghus_InitiateJumpWayUp:
{
    LDA.b #$03 : STA.w $0D80, X
    
    LDA.b #$32 : JSL.l Sound_SetSfx3PanLong
    
    STZ.w $0E80, X
    
    RTS
}

; $0F35FD-$0F361A JUMP LOCATION
Arrghus_TargetLink:
{
    JSL.l GetRandomInt : AND.b #$3F : ADC.b #$30 : STA.w $0DF0, X
    
    AND.b #$03 : ADC.b #$08 : JSL.l Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA.b $00 : STA.w $0DE0, X
    LDA.b $01 : STA.w $0EB0, X
    
    RTS
}

; $0F361B-$0F363C JUMP LOCATION
Arrghus_Decelerate:
{
    JSR.w Sprite3_Move
    
    LDA.w $0D50, X : BEQ .x_speed_is_zero
        BPL .decrease_x_speed
            INC.w $0D50, X
            
            BRA .decelerate_y_speed
        
        .decrease_x_speed
        
        DEC.w $0D50, X
        
        .declerate_y_speed
    .x_speed_is_zero
    
    LDA.w $0D40, X : BEQ .y_speed_is_zero
        BPL .decrease_y_speed
            INC.w $0D40, X
            
            BRA .return
            
        .decrease_y_speed
        
        DEC.w $0D40, X
        
    .y_speed_is_zero
    .return
    
    RTS
}

; ==============================================================================

; $0F363D-$0F3673 JUMP LOCATION
Arrghus_PuffAttack:
{
    LDA.b #$08 : STA.w $0B0C
    
    LDA.w $0DF0, X : CMP.b #$20 : BCC .decrease_radius
        CMP.b #$60 : BCS .dont_adjust_radius
            INC.w $0B0A
            
            RTS
    
    .decrease_radius
    
    DEC.w $0B0A : BMI .finished_arrgi_attack
        RTS
    
    .dont_adjust_radius
    
    BNE .BRANCH_DELTA
        ; TODO: Figure out if this code is ever reached, and if so, how???!!!
        LDA.b #$26 : BRA .play_sound_effect
    
    .BRANCH_DELTA
    
    AND.b #$0F : BNE .sound_effect_delay
        LDA.b #$06
        
        .play_sound_effect
        
        JSL.l Sound_SetSfx3PanLong
    
    .sound_effect_delay
    
    RTS
    
    .finished_arrgi_attack
    
    STZ.w $0B0A
    
    DEC.w $0D80, X
    
    LDA.b #$70 : STA.w $0DF0, X
    
    RTS
}

; ==============================================================================

; $0F3674-$0F36E8 DATA
Pool_Arrghus_HandlePuffs:
{
    ; $0F3674
    .angle_offset
    dw $0000, $0040, $0080, $00C0, $0100, $0140, $0180, $01C0
    dw $0000, $0066, $00CC, $0132, $0198
    
    ; $0F368E
    .angle_mask
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $01FF, $01FF, $01FF, $01FF, $01FF
    
    ; $0F36A8
    .pinch
    db $14, $14, $14, $14, $14, $14, $14, $14
    db $0C, $0C, $0C, $0C, $0C
    
    ; $0F36B5
    .some_offset
    db $00, $FF, $FE, $FD, $FC, $FB, $FA, $FA
    db $FB, $FC, $FD, $FE, $FF, $00, $FF, $FE
    db $FD, $FC, $FB, $FA, $FA, $FB, $FC, $FD
    db $FE, $FF, $00, $FF, $FE, $FD, $FC, $FB
    db $FA, $FA, $FB, $FC, $FD, $FE, $FF, $00
    db $FF, $FE, $FD, $FC, $FB, $FA, $FA, $FB
    db $FC, $FD, $FE, $FF
}

; $0F36E9-$0F3817 LOCAL JUMP LOCATION
Arrghus_HandlePuffs:
{
    LDA.w $0B08 : CLC : ADC.w $0B0C : STA.w $0B08
    LDA.w $0B09 :       ADC.b #$00  : STA.w $0B09
    
    LDA.b $1A : AND.b #$03 : BNE .increment_delay
        INC.w $0D90, X : LDA.w $0D90, X : CMP.b #$0D : BNE .anoreset_counter
            STZ.w $0D90, X

        .anoreset_counter
    .increment_delay
    
    
    LDA.b $1A : AND.b #$07 : BNE .increment_delay_2
        INC.w $0DA0, X : LDA.w $0DA0, X : CMP.b #$0D : BNE .anoreset_counter_2
            STZ.w $0DA0, X

        .anoreset_counter_2
    .increment_delay_2

    STZ.w $0FB5
    
    .next_arrgi
    
        LDA.w $0FB5 : PHA : ASL A : TAY
        
        REP #$20
        
        LDA.w $0B08 : CLC : ADC.w Pool_Arrghus_HandlePuffs_angle_offset, Y
        EOR.w Pool_Arrghus_HandlePuffs_angle_mask, Y : STA.b $00
        
        SEP #$20
        
        PLY
        
        LDA.w $0B0A : CLC : ADC.w Pool_Arrghus_HandlePuffs_pinch, Y : STA.b $0E
                                                                      STA.b $0F
        
        LDA.w $0FB5 : STA.b $02
        
        LDA.w $0D90, X : CLC : ADC.b $02 : TAY
        
        LDA.b $0F : CLC : ADC.w Pool_Arrghus_HandlePuffs_some_offset, Y
        STA.b $0F
        
        LDA.w $0DA0, X : CLC : ADC.b $02 : TAY
        
        LDA.b $0E : CLC : ADC.w Pool_Arrghus_HandlePuffs_some_offset, Y
        STA.b $0E
        
        PHX
        
        REP #$30
        
        LDA.b $00 : AND.w #$00FF : ASL A : TAX
        
        LDA.l SmoothCurve, X : STA.b $04
        
        LDA.b $00 : CLC : ADC.w #$0080 : STA.b $02 : AND.w #$00FF : ASL A : TAX
        
        LDA.l SmoothCurve, X : STA.b $06
        
        SEP #$30
        
        PLX
        
        LDA.b $04 : STA.w SNES.MultiplicandA
        
        LDA.b $0F
        
        LDY.b $05 : BNE .BRANCH_GAMMA
            STA.w SNES.MultiplierB
            
            JSR.w Sprite3_DivisionDelay
            
            ASL.w SNES.RemainderResultLow
            
            LDA.w SNES.RemainderResultHigh : ADC.b #$00
        
        .BRANCH_GAMMA
        
        LSR.b $01 : BCC .BRANCH_DELTA
            EOR.b #$FF : INC A
        
        .BRANCH_DELTA
        
        STZ.b $0A
        
        CMP.b #$00 : BPL .x_adjustment_positive
            DEC.b $0A
        
        .x_adjustment_positive
        
        CLC : ADC.w $0D10, X : LDY.w $0FB5 : STA.w $0B10, Y
        LDA.w $0D30, X : ADC.b $0A : STA.w $0B20, Y
        
        LDA.b $06 : STA.w SNES.MultiplicandA
        
        LDA.b $0E
        
        LDY.b $07 : BNE .BRANCH_ZETA
            STA.w SNES.MultiplierB
            
            JSR.w Sprite3_DivisionDelay
            
            ASL.w SNES.RemainderResultLow
            
            LDA.w SNES.RemainderResultHigh : ADC.b #$00
        
        .BRANCH_ZETA
        
        LSR.b $03 : BCC .BRANCH_THETA
            EOR.b #$FF : INC A
        
        .BRANCH_THETA
        
        STZ.b $0A
        
        CMP.b #$00 : BPL .y_adjustment_positive
            DEC.b $0A
        
        .y_adjustment_positive
        
        CLC : ADC.w $0D00, X : PHP : SEC : SBC.b #$10
        LDY.w $0FB5 : STA.w $0B30, Y

        LDA.w $0D20, X : SBC.b #$00 : PLP : ADC.b $0A : STA.w $0B40, Y
        
        ; OPTIMIZE: More of a note, but if our new assembler can handle meta
        ; branch instructions (that can dynamically resize at assembly time), we
        ; could replace this with "BNE .next_arrgi", and remove the JMP
        ; instruction.
        INC.w $0FB5 : LDA.w $0FB5 : CMP.b #$0D : BEQ .return
    JMP .next_arrgi
    
    .return
    
    RTS
}

; ==============================================================================

; $0F3818-$0F383F DATA
Arrghus_Draw_oam_groups:
{
    dw -8, -4 : db $80, $00, $00, $02
    dw  8, -4 : db $80, $40, $00, $02
    dw -8, 12 : db $A0, $00, $00, $02
    dw  8, 12 : db $A0, $40, $00, $02
    dw  0, 24 : db $A8, $00, $00, $02   
}

; $0F3840-$0F38B3 LOCAL JUMP LOCATION
Arrghus_Draw:
{
    REP #$20
    
    LDA.w #(.oam_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$05 : JSR.w Sprite3_DrawMultiple
    
    LDA.w $0DC0, X : ASL A : STA.b $00
    
    LDY.b #$02
    
    .adjust_upper_chr
    
        LDA ($90), Y : CLC : ADC.b $00 : STA ($90), Y
    INY #4 : CPY.b #$12 : BCC .adjust_upper_chr
    
    LDA.w $0D80, X : CMP.b #$05 : BNE .dont_hide_some_portion
        LDY.b #$11 : LDA.b #$F0 : STA ($90), Y
    
    .dont_hide_some_portion
    
    LDA.w $0E80, X : AND.b #$08 : BEQ .dont_hflip_some_portion
        LDY.b #$13 : LDA ($90), Y : ORA.b #$40 : STA ($90), Y
    
    .dont_hflip_some_portion
    
    ; TODO: Verify this assessment, as we're flying blind, somewhat.
    LDA.w $0D80, X : CMP.b #$05 : BEQ .draw_water_ripples
        REP #$20
        
        LDA.b $90 : CLC : ADC.w #$0004 : STA.b $90
        
        INC.b $92
        
        SEP #$20
        
        ; TODO: Also verify this assessment that it controls shadow drawing.
        LDA.w $0F70, X : CMP.b #$A0 : BCS .dont_draw_shadow
            LDA.w $0F50, X : PHA : AND.b #$FE : STA.w $0F50, X
            
            JSL.l Sprite_DrawLargeShadow
            
            PLA : STA.w $0F50, X
        
        .dont_draw_shadow
        
        RTS
    
    .draw_water_ripples
    
    JSL.l Sprite_DrawLargeWaterTurbulence
    
    RTS
}

; ==============================================================================
