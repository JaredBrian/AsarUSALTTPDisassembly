; ==============================================================================

; $0F1460-$0F149D JUMP LOCATION
Sprite_KholdstareShell:
{
    JSR.w Sprite3_CheckIfActive_permissive
    JSR.w Sprite3_DirectionToFacePlayer
    
    LDA.b $0F : CLC : ADC.b #$20 : CMP.b #$40 : BCS .player_not_close
        LDA.b $0E : CLC : ADC.b #$20 : CMP.b #$40 : BCS .player_not_close
            JSL.l Sprite_NullifyHookshotDrag
            JSL.l Sprite_RepelDashAttackLong
    
    .player_not_close
    
    JSL.l Sprite_CheckDamageFromPlayerLong
    
    LDA.w $0D80, X : BNE KholdstareShell_PhaseOut
        LDA.w $0DD0, X : CMP.b #$06 : BNE KholdstareShell_ShakeFromDamage
            LDA.b #$C0 : STA.w $0E60, X
            
            INC.w $0D80, X
            
            LDA.b #$09 : STA.w $0DD0, X
            
            RTS
}

; ==============================================================================

; $0F149E-$0F14A1 DATA
Pool_KholdstareShell_ShakeFromDamage:
{
    ; $0F149E
    .x_offsets
    db $01, $FF
    
    ; $0F14A0
    .y_offsets
    db $00, $FF        
}

; $0F14A2-$0F14C0 BRANCH LOCATION
KholdstareShell_ShakeFromDamage:
{
    LDA.w $0EF0, X : BEQ .not_in_recoil_state
        AND.b #$02 : LSR : TAY
        
        LDA Pool_KholdstareShell_ShakeFromDamage_x_offsets, Y : STA.w $0422
        
        LDA Pool_KholdstareShell_ShakeFromDamage_y_offsets, Y : STA.w $0423
        
        LDA.b #$01 : STA.w $0428
        
        RTS
    
    .not_in_recoil_state
    
    STZ.w $0428
    
    RTS
}

; ==============================================================================

; \tcrf(verified, submitted)
; It would seem that the GBA version corrected the faulty implementation of the
; SNES version. In the SNES version, the shell just abruptly disappears, but
; this is due to the fact that they were filtering the wrong palette. If the
; relevant code in bank 0x00 is changed so that the color data changed exists at
; indices 0xA0 to 0xAF instead of 0x80 to 0x8F, this effect will display
; properly. To summarize, it needs to filter the first half of BP-5 instead of
; the first half of BP-4. I have performed this modification ad-hoc style and it
; does indeed work as expected.
; $0F14C1-$0F14DC BRANCH LOCATION
KholdstareShell_PhaseOut:
{
    INC.w $0D80, X
    
    CMP.b #$12 : BEQ .split_eyeball_into_three
        PHX
        
        JSL.l KholdstareShell_PaletteFiltering
        
        PLX
        
        RTS
    
    .split_eyeball_into_three
    
    STZ.w $0DD0, X
    
    LDA.b #$02 : STA.w $0D82
    
    LDA.b #$80 : STA.w $0DF2
    
    RTS
}

; ==============================================================================

; $0F14DD-$0F1517 LOCAL JUMP LOCATION
IceBallGenerator_DoYourOnlyJob:
{
    INC.w $0E80, X
    
    LDA.w $0E80, X : AND.b #$7F : ORA.w $0E00, X : BNE .cant_spawn
        LDA.b #$A4
        
        JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            LDA.b $22 : STA.w $0D10, Y
            LDA.b $23 : STA.w $0D30, Y
            
            LDA.b $20 : STA.w $0D00, Y
            LDA.b $21 : STA.w $0D20, Y
            
            LDA.b #$E0 : STA.w $0F70, Y
                        STA.w $0DB0, Y
            
            PHX
            
            TYX
            
            LDA.b #$20 : JSL.l Sound_SetSfx2PanLong
            
            PLX
        
        .spawn_failed
    .cant_spawn
    
    RTS
}

; ==============================================================================

; NOTE: $0D90, X is used for the direction of the actual eyeball portion
; of the sprite. (90% certain.)
; $0F1518-$0F156E JUMP LOCATION
Sprite_Kholdstare:
{
    JSL.l Kholdstare_Draw
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0D80, X : CMP.b #$02 : BCS .no_garnish
        JSR.w Kholdstare_SpawnNebuleGarnish
        
        LDA.b $1A : AND.b #$07 : BNE .garnish_delay
            LDA.b #$02 : STA.w $012E
        
        .garnish_delay
    .no_garnish
    
    JSR.w Sprite3_CheckIfRecoiling
    
    DEC.w $0E80, X : BPL .animation_cycle_delay
        LDA.b #$0A : STA.w $0E80, X
        
        LDA.w $0DC0, X : INC : AND.b #$03 : STA.w $0DC0, X
    
    .animation_cycle_delay
    
    LDA.b $1A : AND.b #$03 : BNE .dont_adjust_eye_direction
        LDA.b #$1F : JSL.l Sprite_ProjectSpeedTowardsPlayerLong
        
        JSL.l Sprite_ConvertVelocityToAngle : STA.w $0D90, X
    
    .dont_adjust_eye_direction
    
    JSR.w Sprite3_Move
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Kholdstare_Accelerate ; 0x00 - $956F
    dw Kholdstare_Decelerate ; 0x01 - $95E5
    dw Kholdstare_Triplicate ; 0x02 - $964C
    dw Kholdstare_DoNothing  ; 0x03 - $9694
}

; ==============================================================================

; $0F156F-$0F15A9 JUMP LOCATION
Kholdstare_Accelerate:
{
    JSR.w Sprite3_CheckDamage
    
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        JSL.l GetRandomInt : AND.b #$3F : ADC.b #$20 : STA.w $0DF0, X
        
        RTS
    
    .delay
    
    LDA.w $0D50, X : CMP.w $0F80, X : BEQ .x_speed_at_target
        BPL .x_speed_greater_than_target
            INC.w $0D50, X
            
            BRA .check_y_speed
        
        .x_speed_greater_than_target
        
        DEC.w $0D50, X
    
    .x_speed_at_target
    .check_y_speed
    
    LDA.w $0D40, X : CMP.w $0F90, X : BEQ .y_speed_at_target
        BPL .y_speed_greater_than_target
            INC.w $0D40, X
            
            BRA .check_tile_collision
        
        .y_speed_greater_than_target
        
        DEC.w $0D40, X
    
    .y_speed_at_target
    .check_tile_collision

    ; Bleeds into the next function.
}
    
; $0F15AA-$0F15DC JUMP LOCATION
Kholstare_CheckTileCollision:
{
    JSR.w Sprite3_CheckTileCollision : AND.b #$03 : BEQ .no_horiz_collision
        LDA.w $0D50, X : EOR.b #$FF : INC : STA.w $0D50, X
        
        LDA.w $0F80, X : EOR.b #$FF : INC : STA.w $0F80, X
    
    .no_horiz_collision
    
    LDA.w $0E70, X : AND.b #$0C : BEQ .no_vert_collision
        LDA.w $0D40, X : EOR.b #$FF : INC : STA.w $0D40, X
        
        LDA.w $0F90, X : EOR.b #$FF : INC : STA.w $0F90, X
    
    .no_vert_collision
    
    RTS
}

; ==============================================================================

; $0F15DD-$0F15E4 DATA
Pool_KholdStare_Decelerate:
{
    ; $0F15DD
    .x_speed_limits
    db  16,  16, -16, -16
    
    ; $0F15E0
    .y_speed_limits
    db -16,  16,  16, -16
}

; $0F15E5-$0F1645 JUMP LOCATION
Kholdstare_Decelerate:
{
    JSR.w Sprite3_CheckDamage
    
    LDA.w $0DF0, X : BNE .delay
        STZ.w $0D80, X
        
        JSL.l GetRandomInt : AND.b #$3F : ADC.b #$60 : STA.w $0DF0, X
        
        JSL.l GetRandomInt : PHA : AND.b #$03 : TAY
        
        LDA Pool_KholdStare_Decelerate_x_speed_limits, Y : STA.w $0F80, X
        
        LDA Pool_KholdStare_Decelerate_y_speed_limits, Y : STA.w $0F90, X
        
        PLA : AND.b #$1C : BNE .stick_with_random_direction
            LDA.b #$18
            
            JSL.l Sprite_ProjectSpeedTowardsPlayerLong
            
            LDA.b $00 : STA.w $0F90, X
            LDA.b $01 : STA.w $0F80, X
        
        .stick_with_random_direction
        
        RTS
    
    .delay
    
    LDA.w $0D50, X : BEQ .x_speed_at_zero
        BPL .x_speed_nonzero
            INC.w $0D50, X
            
            BRA .check_y_speed
        
        .x_speed_nonzero
        
        DEC.w $0D50, X
    
    .x_speed_at_zero
    .check_y_speed
    
    LDA.w $0D40, X : BEQ .y_speed_at_zero
        BPL .y_speed_nonzero
            INC.w $0D40, X
            
            BRA .check_tile_collision
        
        .y_speed_nonzero
        
        DEC.w $0D40, X
    
    .y_speed_at_zero
    .check_tile_collision
    
    JMP Kholstare_CheckTileCollision
}

; ==============================================================================

; $0F1646-$0F164B
Pool_Kholdstare_Triplicate:
{
    ; $0F1646
    .x_speed_targets
    db  32, -32,   0
    
    ; $0F1649
    .y_speed_targets
    db -32, -32,  48 
}

; $0F164C-$0F1693 JUMP LOCATION
Kholdstare_Triplicate:
{
    LDA.w $0DF0, X : CMP.b #$01 : BNE .dont_spawn
        ; Clear out the first three sprite entries just in case, because
        ; we certainly want to use them (possibly due to hardcoding).
        STZ.w $0DD0, X
        STZ.w $0DD1, X
        STZ.w $0DD2, X
        
        LDA.b #$02 : STA.w $0FB5
        
        .spawn_next_kholdstare
        
            LDA.b #$A2
            LDY.b #$04
            
            JSL.l Sprite_SpawnDynamically_arbitrary : BMI .spawn_failed
                JSL.l Sprite_SetSpawnedCoords
                
                PHX
                
                LDX.w $0FB5
                
                LDA Pool_Kholdstare_Triplicate_x_speed_targets, X : STA.w $0F80, Y
                
                LDA Pool_Kholdstare_Triplicate_y_speed_targets, X : STA.w $0F90, Y
                
                LDA.b #$20 : STA.w $0DF0, Y
                
                PLX
        DEC.w $0FB5 : BPL .spawn_next_kholdstare
        
        RTS
        
        .spawn_failed
    .dont_spawn
    
    LDA.w $0EF0, X : ORA.b #$E0 : STA.w $0EF0, X
    
    RTS
}

; ==============================================================================

; $0F1694-$0F1694 JUMP LOCATION
Kholdstare_DoNothing:
{
    RTS
}

; ==============================================================================

; $0F1695-$0F16A4 DATA
Pool_Kholdstare_SpawnNebuleGarnish:
{
    ; $0F1695
    .offsets_low
    db $F8, $FA, $FC, $FE, $00, $02, $04, $06
    
    ; $0F169D
    .offsets_high
    db $FF, $FF, $FF, $FF, $00, $00, $00, $00
}

; Generates the puffs of white smoke for the Kholdstare eyeballs.
; $0F16A5-$0F170F LOCAL JUMP LOCATION
Kholdstare_SpawnNebuleGarnish:
{
    TXA : EOR.b $1A : AND.b #$03 : BNE .delay
        PHX
        
        LDX.b #$0E
        
        .next_slot
        
            LDA.l $7FF800, X : BEQ .available_slot
        DEX : BPL .next_slot
        
        PLX
        
        RTS
        
        .available_slot
        
        LDA.b #$07 : STA.l $7FF800, X : STA.w $0FB4
        
        LDA.b #$1F : STA.l $7FF90E, X
        
        JSL.l GetRandomInt : AND.b #$07 : TAY
        
        LDA.w $0FD8
        CLC : ADC.w Pool_Kholdstare_SpawnNebuleGarnish_offsets_low, Y
        STA.l $7FF83C, X

        LDA.w $0FD9
        ADC.w Pool_Kholdstare_SpawnNebuleGarnish_offsets_high, Y
        STA.l $7FF878, X
        
        JSL.l GetRandomInt : AND.b #$07 : TAY
        
        LDA.w $0FDA
        CLC : ADC.w Pool_Kholdstare_SpawnNebuleGarnish_offsets_low, Y
        PHP : CLC : ADC.b #$10 : STA.l $7FF81E, X

        LDA.w $0FDB : ADC.b #$00 : PLP
        ADC.w Pool_Kholdstare_SpawnNebuleGarnish_offset_high, Y
        STA.l $7FF85A, X
        
        LDA.b #$00 : STA.l $7FF968, X
        
    PLX
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F1710-$0F1732 JUMP LOCATION
Sprite_IceBallGenerator:
{
    LDA.w $0DB0, X : BNE Sprite_IceBall
        JSR.w Sprite3_CheckIfActive
        
        LDA.w $0DD2 : CMP.b #$09 : BCS .generate_ice_ball
            LDA.w $0DD3 : CMP.b #$09 : BCS .generate_ice_ball
                LDA.w $0DD4 : CMP.b #$09 : BCS .generate_ice_ball
                    STZ.w $0DD0, X
        
        .generate_ice_ball
        
        JMP IceBallGenerator_DoYourOnlyJob
}

; ==============================================================================

; $0F1733-$0F17BE BRANCH LOCATION
Sprite_IceBall:
{
    LDA.b #$01 : STA.w $0BA0, X
    
    LDA.b #$30 : STA.w $0B89, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    
    LDA.w $0D80, X : BNE .is_ice_ball_piece
        LDA.w $0E60, X : EOR.b #$10 : STA.w $0E60, X
    
    .is_ice_ball_piece
    
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0DF0, X : BEQ .is_falling_ice_ball
        CMP.b #$01 : BNE .not_quite_dead
            STZ.w $0DD0, X
        
        .not_quite_dead
        
        LSR #3 : INC #2 : STA.w $0DC0, X
        
        RTS
        
    .is_falling_ice_ball
    
    JSR.w Sprite3_Move
    
    LDA.w $0D80, X : BEQ .is_falling_ice_ball_2
        JSR.w Sprite3_CheckDamageToPlayer
        
        JSR.w Sprite3_CheckTileCollision : BNE .hit_tile
    
    .is_falling_ice_ball_2
    
    LDA.w $0F70, X : PHA
    
    JSR.w Sprite3_MoveAltitude
    
    LDA.w $0F80, X : CMP.b #$C0 : BMI .at_terminal_fall_speed
        SEC : SBC.b #$03 : STA.w $0F80, X
    
    .at_terminal_fall_speed
    
    PLA : EOR.w $0F70, X : BPL .no_ground_bounce
        LDA.w $0F70, X : BPL .no_ground_bounce
            STZ.w $0F70, X
            
            LDA.w $0D80, X : BNE .is_ice_ball_piece_2
                STZ.w $0DD0, X
                
                JSR.w IceBall_Quadruplicate
                
                RTS
                
            .is_ice_ball_piece_2
            .hit_tile
            
            LDA.b #$0F : STA.w $0DF0, X
            
            LDA.b #$04 : STA.w $0F50, X
            
            LDA.w $012E : BNE .channel_in_use
                LDA.b #$1E : JSL.l Sound_SetSfx2PanLong
                
                LDA.b #$03 : STA.w $0DC0, X
            
            .channel_in_use
    .no_ground_bounce
    
    RTS
}

; ==============================================================================

; $0F17BF-$0F17CE DATA
Pool_IceBall_Quadruplicate:
{
    ; NOTE: the split has two configurations that alternate between diagonal
    ; movement away from the center and movement that is parallel to the x and
    ; y axes.
    ; $0F17BF
    .x_speeds
    db $00, $20, $00, $E0
    db $18, $18, $E8, $E8
    
    ; $0F17C7
    .y_speeds
    db $E0, $00, $20, $00
    db $E8, $18, $E8, $18
}

; $0F17CF-$0F181C LOCAL JUMP LOCATION
IceBall_Quadruplicate:
{
    LDA.b #$1F : JSL.l Sound_SetSfx2PanLong
    
    JSL.l GetRandomInt : AND.b #$04 : STA.b $0D
    
    LDA.b #$03 : STA.w $0FB5
    
    .next_spawn
    
        LDA.b #$A4 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            JSL.l Sprite_SetSpawnedCoords
            
            ; Indicate that it's an iceball and a shard of one, at that.
            LDA.b #$01 : STA.w $0D80, Y : STA.w $0DC0, Y : STA.w $0DB0, Y
            
            LDA.b #$20 : STA.w $0F80, Y
            
            PHX
            
            LDA.w $0FB5 : ORA.b $0D : TAX
            
            LDA Pool_IceBall_Quadruplicate_x_speeds, X : STA.w $0D50, Y
            
            LDA Pool_IceBall_Quadruplicate_y_speeds, X : STA.w $0D40, Y
            
            PLX
            
            LDA.b #$1C : STA.w $0F60, Y
        
        .spawn_failed
    DEC.w $0FB5 : BPL .next_spawn
    
    RTS
}

; ==============================================================================
