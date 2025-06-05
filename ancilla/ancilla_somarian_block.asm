; ==============================================================================

;   $0394[0x05]
;       When the block is spawned, this timer is set and prevents any
;       interaction with the object until it counts down.

; ==============================================================================

; $0462F9-$046364 DATA
Pool_Ancilla_SomarianBlock:
{
    ; $0462F9
    .properties
    db $00, $40, $00, $C0
    
    ; TODO: check if these are ever used.
    db $00, $40, $00, $C0
    db $00, $40, $00, $C0
    
    ; $046305
    .y_offsets
    dw -8, -8,  0,  0
    dw  0,  0,  0,  0
    dw  0,  0,  0,  0
    
    ; $046305
    .x_offsets
    dw -8,  0, -8,  0
    dw  0,  0,  0,  0
    dw  0,  0,  0,  0
    
    ; $04631D
    .node_check_y_offsets
    dw -8,  8,  0,  0
    dw  0,  0,  0,  0
    dw -8,  8, -8,  8
    
    ; $046335
    .node_check_x_offsets
    dw  0,  0, -8,  8
    dw  0,  0,  0,  0
    dw  8, -8, -8,  8
}

; $046365-$0465D7 JUMP LOCATION
Ancilla_SomarianBlock:
{
    DEC.w $0394, X : BPL Ancilla_SetupBasicHitBox_return
        STZ.w $0394, X
        
        LDA.w $03C5, X : BNE .bouncing
            LDA.b $11  : BEQ .full_execute
            CMP.b #$08 : BEQ .full_execute
            CMP.b #$10 : BNE .partial_execute
                .full_execute
                
                JSR.w Ancilla_LiftableObjectLogic
                
                BRA .held_logic
            
            .partial_execute
            
            TXA : INC : CMP.w $02EC : BNE .pretrigger_logic
                LDA.w $0380, X : BEQ .pretrigger_logic
                    CMP.b #$03 : BEQ .assert_fully_held_position
                        LDY.b #$03
                        
                        JSR.w Ancilla_PegCoordsToPlayer
                        JSR.w Ancilla_PegAltitudeAbovePlayer
                        
                        LDA.b #$03 : STA.w $0380, X
                        
                    .assert_fully_held_position
                    
                    JSR.w Ancilla_SetPlayerHeldPosition
            
            .pretrigger_logic
            
            LDA.b $1B : BEQ .outdoors
            
                LDA.w $0380, X : BNE .unset_trigger_if_player_holding
                    BIT.w $0308 : BMI .unset_trigger_if_player_holding
                        LDA.w $029E, X : BEQ .trigger_logic
                            CMP.b #$FF : BEQ .trigger_logic
            
                .unset_trigger_if_player_holding
        .bouncing
        
        TXA : INC : CMP.w $02EC : BNE .anounset_trigger_tile
            STZ.w $0646
            
        .anounset_trigger_tile

        .outdoors
        
        BRL .tile_collision_logic
        
        .trigger_logic
        
        ; WTF: What this indicates to me is that using a somarian block
        ; as a platform generator and as a tile trigger cover is mutually
        ; exclusive in a given room.
        LDA.w $03F4 : BEQ .no_tranit_tiles_available
            LDA.b $1A : AND.b #$03 : ASL : TAY
            
            .find_transit_node_nearby
            
            LDA.w $0BFA, X
            CLC : ADC Pool_Ancilla_SomarianBlock_node_check_y_offsets+0, Y
            STA.b $00 : STA.b $72

            LDA.w $0C0E, X
                  ADC Pool_Ancilla_SomarianBlock_node_check_y_offsets+1, Y
            STA.b $01 : STA.b $73
            
            LDA.w $0C04, X
            CLC : ADC Pool_Ancilla_SomarianBlock_node_check_x_offsets+0, Y
            STA.b $02 : STA.b $74

            LDA.w $0C18, X
                  ADC Pool_Ancilla_SomarianBlock_node_check_x_offsets+1, Y
            STA.b $03 : STA.b $75
            
            PHY
            
            LDA.w $0280, X : PHA
            
            JSR.w Ancilla_CheckTargetedTileCollision
            
            PLA : STA.w $0280, X
            
            PLY
            
            ; These are the '?' transit tile nodes.
            LDA.w $03E4, X : CMP.b #$B6 : BEQ .attempt_platform_spawn
                             CMP.b #$BC : BEQ .attempt_platform_spawn
            
                TYA : CLC : ADC.b #$08 : TAY
                CPY.b #$18 : BCS .tile_collision_logic
                    BRA .find_transit_node_nearby
                
            .attempt_platform_spawn
            
            LDA.b $72 : STA.w $0BFA, X
            LDA.b $73 : STA.w $0C0E, X
            
            LDA.b $74 : STA.w $0C04, X
            LDA.b $75 : STA.w $0C18, X
            
            JSL.l AddSomarianPlatformPoof
            
            TXA : INC : CMP.w $02EC : BNE .reset_nearest_flag_near_platform
                STZ.w $02EC
            
            .reset_nearest_flag_near_platform
            
            RTS
        
        .no_tranit_tiles_available
        
        ; WTF: Does this routine check against star tiles? Could I use this
        ; to trigger doors in dungeon by putting a block on a star tile?
        ; (or whatever 0x3B is?)
        JSR.w SomarianBlock_CheckCoveredTileTrigger : BCS .tile_collision_logic
            LDA.w $029E, X : BEQ .set_tile_trigger_flag
                CMP.b #$FF : BNE .tile_collision_logic
            
            .set_tile_trigger_flag
            
            INC.w $0646
            
        .tile_collision_logic
        
        JSR.w Ancilla_Adjust_Y_CoordByAltitude
        
        LDA.w $0C72, X : STA.b $74
        LDA.w $0280, X : STA.b $75
        
        STZ.w $0280, X
        
        JSR.w Ancilla_CheckTileCollision_Class2
        
        PHP
        
        LDA.b $1B : BEQ .dont_transition_to_bg1
            LDA.w $0385, X : BEQ .dont_transition_to_bg1
                LDA.w $03E4, X : CMP.b #$1C : BNE .dont_transition_to_bg1
                    LDA.b #$01 : STA.w $03D5, X
        
        .dont_transition_to_bg1
        
        PLP : BCC .no_tile_collision
            .wall_bounce_logic
            
            ; If we reach this point the somarian block is touching a wall
            ; tile and requires collision handling.
            BIT.w $0308 : BPL .not_being_held_so_can_bounce
                LDA.w $0309 : BEQ .no_tile_collision
            
            .not_being_held_so_can_bounce
            
            ; Super priority means ignore all collision.
            LDA.b $75 : BNE .end_tile_collision_logic
                LDA.w $0BF0, X : BNE .end_tile_collision_logic
                    LDA.w $029E, X : BEQ .end_tile_collision_logic
                        LDA.b #$01 : STA.w $0BF0, X
                        
                        LDA.b #$04 : STA.b $0E
                        
                        ; What is the obsession with the down direction? It
                        ; uses less of a wall bounce magnitude.
                        LDA.w $0C72, X : CMP.b #$01 : BNE .use_small_bounce_magnitude
                            LDA.b #$10 : STA.b $0E
                            
                            LDY.b #$F0
                            
                            BRA .check_vertical_speed
                            
                        .use_small_bounce_magnitude
                        
                        LDY.b #$FC
                        
                        .check_vertical_speed
                        
                        LDA.w $0C22, X : BEQ .at_rest_y
                            BPL .bounce_upward
                                LDY.b $0E
                            
                            .bounce_upward
                            
                            TYA : STA.w $0C22, X
                        
                        .at_rest_y
                        
                        LDY.b #$FC
                        
                        LDA.w $0C2C, X : BEQ .at_rest_x
                            BPL .bounce_leftward
                                LDY.b #$04
                            
                            .bounce_leftward
                            
                            TYA : STA.w $0C2C, X
                        
                        .at_rest_x
                        
                        LDA.w $0C72, X : CMP.b #$01 : BNE .end_tile_collision_logic
                            INC : STA.w $0385, X
                            
                            LDA.b #$FC : STA.w $0C22, X
                    
            .end_tile_collision_logic

            .dont_process_ground_touch_logic
            
            BRL .damage_logic
        
        .no_tile_collision
        
        BIT.w $0308 : BMI .end_tile_collision_logic
            LDA.w $029E, X : BEQ .touching_ground
                CMP.b #$FF : BNE .dont_process_ground_touch_logic
            
            .touching_ground
            
            LDA.b #$10 : STA.w $0C72, X
            
            LDA.w $0280, X : PHA
            
            JSR.w Ancilla_CheckTileCollision
            
            PLA : STA.w $0280, X
            
            LDA.w $03E4, X
            
            CMP.b #$26 : BEQ .in_floor_staircase_boundary
                CMP.b #$0C : BEQ .niche_collision_tiles
                CMP.b #$1C : BEQ .niche_collision_tiles
                    CMP.b #$20 : BEQ .pit_tiles
                        CMP.b #$08 : BEQ .deep_water_tile
                            CMP.b #$68 : BEQ .conveyor_belt_tiles
                            CMP.b #$69 : BEQ .conveyor_belt_tiles
                            CMP.b #$6A : BEQ .conveyor_belt_tiles
                            CMP.b #$6B : BEQ .conveyor_belt_tiles
                                CMP.b #$B6 : BEQ .transit_tiles
                                CMP.b #$BC : BEQ .transit_tiles
                                
                                ; WTF:... is this accurate disassembly?
                                AND.b #$F0 : CMP.b #$B0 : BNE .tile_pit
                                
                    .pit_tiles
                    
                    BRL .pit_tile_logic
            
            .in_floor_staircase_boundary
            
            BRL .wall_bounce_logic
            
            .conveyor_belt_tiles
            
            BRL .apply_conveyor_movement_to_object
            
            .transit_tiles
            
            STZ.w $0C68, X
            
            LDA.w $0385, X : ORA.w $03C5, X : BNE .bouncing_and_or_airborn
                LDA.b #$02 : STA.w $0C68, X
            
            .bouncing_and_or_airborn

            .delay_reckoning
                
                BRL .damage_logic
                
                .deep_water_tile
                
                ; If a bomb falls into deep water it disappears and makes
                ; a splash.
                TXA : INC : CMP.w $02EC : BNE .water_tile_reset_player_proximity
                    STZ.w $02EC
                
                .water_tile_reset_player_proximity
            LDA.w $0C68, X : BNE .delay_reckoning
            
            LDA.w $0BFA, X : CLC : ADC.b #$E8 : STA.w $0BFA, X
            LDA.w $0C0E, X       : ADC.b #$FF : STA.w $0C0E, X
            
            BRL Ancilla_TransmuteToObjectSplash

            .tile_pit

            LDA.w $0308 : BMI Ancilla_Bomb_state_logic
                STX.b $04

                LDA.w $02EC : DEC : CMP.b $04 : BNE .water_reset_b
                    STZ.w $02EC

                .water_reset_b

                LDA.w $0C68,X : BNE .bounce_to_state_handler
                    BRL Ancilla_DeleteSelf
                
                .niche_collision_tiles
                
                LDA.w $046C : CMP.b #$03 : BEQ .moving_floor_collision
                    LDA.w $0C7C, X : BNE .damage_logic
                        LDA.w $029E, X : BEQ .damage_logic
                            CMP.b #$FF : BEQ .damage_logic
                                LDA.b #$01 : STA.w $0C7C, X
                                
                                BRL .damage_logic
                    
                .moving_floor_collision
                
                ; Handle bomb on a moving floor.
                LDA.w $0BFA, X : CLC : ADC.w $0310 : STA.b $72
                LDA.w $0C0E, X       : ADC.w $0311 : STA.b $73
                
                LDA.w $0C04, X : CLC : ADC.w $0312 : STA.w $0C04, X
                LDA.w $0C18, X       : ADC.w $0313 : STA.w $0C18, X
                
                BRA .damage_logic
                
                .apply_conveyor_movement_to_object
                
                JSR.w Ancilla_ConveyorBeltVelocityOverride
                
                BRA .damage_logic
                
            .pit_tile_logic
                
            LDA.w $0308 : BMI .damage_logic
                TXA : INC : CMP.w $02EC : BNE .pit_tile_reset_player_proximity 
                    STZ.w $02EC
                    
                .pit_tile_reset_player_proximity
                    
                LDA.w $0C68, X : BNE .damage_logic
                    LDA.b $5E : CMP.b #$12 : BNE Ancilla_SelfTerminate
                        STZ.b $5E
                        STZ.b $48

                        ; Bleeds into the next function.
}
        
; $0465D8-$0465DC JUMP LOCATION
Ancilla_SelfTerminate:
{
    STZ.w $0C4A, X
        
    RTS
}

; $0465DC-$04661A JUMP LOCATION
Ancilla_SomarianBlock_damage_logic:
{
    LDA.b $75 : ORA.w $0280, X : STA.b $75
        
    LDA.w $0308 : BMI .dont_fizzle
        DEC.w $03A9, X : LDA.w $03A9, X : BNE .dont_fizzle
                    INC.w $03A9, X
            
            STZ.w $0280, X
            
            JSR.w Ancilla_CheckBasicSpriteCollision : BCC .dont_fizzle
                LDA.b #$07 : STA.w $03A9, X
                
                LDA.w $0C54, X : INC : STA.w $0C54, X
                CMP.b #$05 : BNE .dont_fizzle
                    BRL Ancilla_TransmuteToSomarianBlockFizzle
        
    .dont_fizzle
        
    LDA.b $74 : STA.w $0C72, X
    LDA.b $75 : STA.w $0280, X
        
    JSR.w Ancilla_Set_Y_Coord

    ; Bleeds into the next function.
}
        
; $04661B-$04674B JUMP LOCATION
SomarianBlock_Draw:
{
    TXY : INY : CPY.w $02EC : BNE .no_special_OAM_allocation
        LDA.w $0308 : BPL .no_special_OAM_allocation
            LDA.w $0380, X : CMP.b #$03 : BEQ .no_special_OAM_allocation
                LDA.b $2F : BNE .no_special_OAM_allocation
                    LDA.w $0C90, X : JSR.w Ancilla_AllocateOam_B_or_E
                    
                    BRA .prep_coords
                
    .no_special_OAM_allocation
        
    LDA.w $0FB3 : BEQ .prep_coords
        LDA.w $0C7C, X : BEQ .prep_coords
            LDA.w $0385, X : BNE .other_special_allocation_if_airborn
                TXY : INY : CPY.w $02EC : BNE .prep_coords
            
                LDA.w $0308 : BPL .prep_coords
                
             .other_special_allocation_if_airborn
                
            REP #$20
                
            LDA.w #$00D0 : CLC : ADC.w #$0800 : STA.b $90
            LDA.w #$0034 : CLC : ADC.w #$0A20 : STA.b $92
                
            SEP #$20
            
    .prep_coords
        
    JSR.w Ancilla_PrepAdjustedOamCoord
        
    REP #$20
        
    LDA.w $029E, X : AND.w #$00FF : CMP.w #$0080 : BCC .sign_ext_z_coord
        ORA.w #$FF00
        
    .sign_ext_z_coord
        
    STA.b $04 : BEQ .anoset_max_priority
    CMP.w #$FFFF : BEQ .anoset_max_priority
        ; OPTIMIZE: Use bit instruction instead?
        LDA.w $0380, X : AND.w #$00FF : CMP.w #$0003 : BEQ .anoset_max_priority
            ; OPTIMIZE: Use bit instruction instead?
            LDA.w $0280, X : AND.w #$00FF : BEQ .anoset_max_priority
                LDA.w #$3000 : STA.b $64
        
    .anoset_max_priority
        
    LDA.w #$0000 : CLC : ADC.b $04 : EOR.w #$FFFF : INC : CLC : ADC.b $00 : STA.b $04
        
    LDA.b $02 : STA.b $06
        
    SEP #$20
        
    STZ.b $08
        
    PHX
        
    LDA.b #$02 : STA.b $72
        
    LDA.w $03A4, X : ASL #2 : TAX
        
    LDY.b #$00
        
    .next_OAM_entry
        
        REP #$20
        
        STZ.b $74
        
        PHX : TXA : ASL : TAX
        
        LDA.b $04 : CLC : ADC .y_offsets, X : STA.b $00
        LDA.b $06 : CLC : ADC .x_offsets, X : STA.b $02
        
        PLX
        
        SEP #$20
        
        JSR.w Ancilla_SetSafeOam_XY
        
        ; NOTE: Really? This is made out of 4 little sprites and not 1 big one?
        ; I doesn't computer this amdfpaiosdfjadsofja. (Maybe it was a space
        ; limitation, but still...)
        LDA.b #$E9 : STA ($90), Y
        INY

        LDA.w .properties, X : AND.b #$CF : ORA.b $72 : ORA.b $65 : STA ($90), Y
        INY
        
        PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
        
        ; WTF:(unconfirmed) .... compile time constant?
        LDA.b #$00 : ORA.b $75 : STA ($92), Y
        
        PLY
        
        INX
    INC.b $08 : LDA.b $08 : AND.b #$03 : BNE .next_OAM_entry
        
    PLX
        
    ; Don't self terminate if in the player's hands.
    LDA.w $0380, X : CMP.b #$03 : BEQ .return
        
        LDY.b #$01
        
        .find_on_screen_y_OAM_entry
        
            LDA ($90), Y : CMP.b #$F0 : BNE .OAM_entry_not_off_screen_y
        INY #4 : CPY.b #$11 : BNE .find_on_screen_y_OAM_entry
        
        BRA .terminate_per_off_screen
        
        .OAM_entry_not_off_screen_y
        
        LDY.b #$00
        
        .find_on_screen_x_OAM_entry
        
            LDA ($92), Y : AND.b #$01 : BEQ .return
        INY : CPY.b #$04 : BNE .find_on_screen_x_OAM_entry
        
        .terminate_per_off_screen
        
        STZ.w $0646
        
        ; The block self terminates and unsets the 'switch set' status variable.
        STZ.w $0C4A, X
        
        TXA : INC : CMP.w $02EC : BNE .return
            STZ.w $02EC
            
            LDA.w $0308 : AND.b #$80 : BEQ .return
                ; Reset player carrying status.
                STZ.w $0308
        
    .return
        
    RTS
}

; ==============================================================================

; $04674C-$04675B DATA
Pool_SomarianBlock_CheckCoveredTileTrigger:
{
    ; OPITIMIZE: Make shared block.
    ; $04674C
    .y_offsets
    dw -4,  4,  0,  0
    
    ; $046754
    .x_offsets
    dw  0,  0, -4,  4
}

; $04675C-$0467BF LOCAL JUMP LOCATION
SomarianBlock_CheckCoveredTileTrigger:
{
    STZ.w $0646
    
    STZ.w $03DB, X
    
    LDY.b #$06
    
    .next_offset
        
        LDA.w $0BFA, X
        CLC : ADC Pool_SomarianBlock_CheckCoveredTileTrigger_y_offsets+0, Y
        STA.b $00 : STA.b $72

        LDA.w $0C0E, X
              ADC Pool_SomarianBlock_CheckCoveredTileTrigger_y_offsets+1, Y
        STA.b $01 : STA.b $73
        
        LDA.w $0C04, X
        CLC : ADC Pool_SomarianBlock_CheckCoveredTileTrigger_x_offsets+0, Y
        STA.b $02 : STA.b $74

        LDA.w $0C18, X
              ADC Pool_SomarianBlock_CheckCoveredTileTrigger_x_offsets+1, Y
        STA.b $03 : STA.b $75
        
        PHY
        
        LDA.w $0280, X : PHA
        
        JSR.w Ancilla_CheckTargetedTileCollision
        
        PLA : STA.w $0280, X
        
        PLY
        
        LDA.w $03E4, X
        
        CMP.b #$23 : BEQ .recognized_tile_attr
        CMP.b #$24 : BEQ .recognized_tile_attr
        CMP.b #$25 : BEQ .recognized_tile_attr
        CMP.b #$3B : BNE .ignored_tile_attr
            .recognized_tile_attr
            
            INC.w $03DB, X
        
        .ignored_tile_attr
    DEY #2 : BPL .next_offset
    
    LDA.w $03DB, X : CMP.b #$04 : BNE .not_full_covering
        CLC
        
        RTS
    
    .not_full_covering
    
    SEC
    
    RTS
}

; ==============================================================================

; $0467C0-$0467E5 DATA
Pool_SomarianBlock_PlayerInteraction:
Pool_SomarianBlock_InitDashBounce:
{
    ; $0467C0
    .positive_push_speed
    db 16
    
    ; $0467C1
    .negative_push_speed
    db -16
    
    ; $0467C2
    .launch_y_speeds
    db -40,  40,   0,   0
    
    ; UNUSED:
    ; $0467C6
    .unused_y_speeds
    db -32,  32,   0,   0
    db -16,  16,   0,   0
    db  -8,   8,   0,   0
    
    ; $0467D2
    .launch_x_speeds
    db  0,   0, -40,  40
    
    ; UNUSED:
    ; $0467D6
    .unused_y_speeds
    db  0,   0, -32,  32
    db  0,   0, -16,  16
    db  0,   0,  -8,   8
    
    ; $0467E2
    .bounce_rebound_z_speeds
    db 30,  18,  10,   8
}

; ==============================================================================

; $0467E6-$0468F2 LONG JUMP LOCATION
SomarianBlock_PlayerInteraction:
{
    PHB : PHK : PLB
    
    ; Index into the SFX arrays.
    STX.w $0FA0
    
    LDA.w $0394, X : BNE .end_push_logic
        LDA.w $03C5, X : BEQ .not_dash_airborn
            BRL SomarianBlock_ContinueDashBounce
        
        .not_dash_airborn
        
        LDA.b $4D : BNE .end_push_logic
            LDA.w $0308 : AND.b #$01 : BNE .end_push_logic
                LDA.w $029E, X : BEQ .ground_touch
                    CMP.b #$FF : BNE .end_push_logic
                
                .ground_touch
                
                LDA.w $0380, X : BNE .end_push_logic
                    LDA.w $0385, X : BNE .end_push_logic
                        LDA.b $F0 : AND.b #$0F : BNE .dpad_pressed
                            ; Setting these to zero has the affect of not making
                            ; the player look like they're pushing anything.
                            STA.w $039F, X
                            STA.b $48
                            
                            LDA.b #$FF : STA.w $038A, X
                            
                            LDA.w $0372 : BNE .check_player_collision
                            
                            STZ.b $5E
            
    .end_push_logic
    
    BRL .return
    
    .dpad_pressed
    
    CMP.w $039F, X : BNE .different_directions_from_prev_frame 
        LDA.b $5E : CMP.b #$12 : BNE .check_player_collision

            LDA.b #$81 : TSB.b $48
            
            BRA .check_player_collision
    
    .different_directions_from_prev_frame
    
    ; Refresh button directional input?
    STA.w $039F, X
    
    STZ.b $5E
    
    .check_player_collision
    
    LDY.b #$04
    
    JSR.w Ancilla_CheckPlayerCollision : BCC .end_push_logic
        LDA.w $0C7C, X : CMP $EE : BNE .end_push_logic
            LDA.w $0372 : BEQ .not_dash_bounce
                LDA.w $02F1 : CMP.b #$40 : BEQ .not_dash_bounce
                    TXA : INC : CMP.w $02EC : BNE .disable_nearby_status
                        STZ.w $02EC
                    
                    .disable_nearby_status
                    
                    JSL.l Player_HaltDashAttackLong
                    
                    LDA.b #$32 : JSR.w Ancilla_DoSfx3
                    
                    BRL SomarianBlock_InitDashBounce
            
            .not_dash_bounce
            
            STZ.w $0C2C, X
            STZ.w $0C22, X
            
            LDA.b $F0 : AND.b #$0F : STA.w $039F, X
            
            AND.b #$03 : BEQ .vertical_push
                LDY.w .positive_push_speed
                
                AND.b #$01 : BNE .left_push
                    LDY.w .negative_push_speed
                
                .left_push
                
                TYA : STA.w $0C2C, X
                
                LDY.b #$02
                
                CMP .positive_push_speed : BNE .set_direction_indicator
                    INY
                    
                    BRA .set_direction_indicator
            
            .vertical_push
            
            LDY.w .positive_push_speed
            
            LDA.b $F0 : AND.b #$08 : BEQ .upward_push
                LDY.w .negative_push_speed
            
            .upward_push
            
            TYA : STA.w $0C22, X
            
            LDY.b #$00
            
            CMP .positive_push_speed : BNE .set_direction_indicator
                INY
            
            .set_direction_indicator
            
            TYA : STA.w $0C72, X
            
            ; TODO: Or does this mean movement in general?
            LDA.b $27 : BEQ .no_player_recoil
                LDA.b $28 : BNE .player_recoiling
            
            .no_player_recoil
            
            JSR.w Ancilla_CheckTileCollision_Class2 : BCS .no_tile_collision
                JSR.w Ancilla_MoveVert
                JSR.w Ancilla_MoveHoriz
                
                ; TODO: Does this like.... mean if you walk up to a somarian
                ; block while you're holding something else it makes no noise?
                ; TODO: Also, investigate why throwing a block and then dashing
                ; before it stops bouncing slows down the player's dash speed to
                ; that of holding a block and walking.)
                LDA.w $0308 : AND.b #$80 : BNE .no_push_SFX
                    INC.w $038A, X : STA.w $038A, X
                    AND.b #$07 : BNE .no_push_SFX
                        LDA.b $22 : JSR.w Ancilla_DoSfx2
                
                .no_push_SFX
            .no_tile_collision
            
            LDA.b #$81 : STA.b $48
            LDA.b #$12 : STA.b $5E
            
            .player_recoiling
            
            JSL.l Sprite_NullifyHookshotDrag
        
    .return
    
    PLB
    
    RTL
}
    
; ==============================================================================

; NOTE: Send the Somarian block flying from the impact of the dash attack.
; $0468F3-$046913 BRANCH LOCATION
SomarianBlock_InitDashBounce:
{
    LDA.b $2F : LSR : STA.w $0C72, X : TAY
    
    LDA.w Pool_SomarianBlock_InitDashBounce_launch_y_speeds, Y : STA.w $0C22, X
    
    LDA.w Pool_SomarianBlock_InitDashBounce_launch_x_speeds, Y : STA.w $0C2C, X
    
    ; Not indexed, used the maximum rise available in the array.
    LDA.w Pool_SomarianBlock_InitDashBounce_bounce_rebound_z_speeds
    STA.w $0294, X
    
    LDA.b #$01 : STA.w $03C5, X
    
    STZ.w $029E, X

    ; Bleeds into the next function.
}
    
; $046914-$04698D BRANCH LOCATION
SomarianBlock_ContinueDashBounce:
{
    ; Simulate gravity.
    LDA.w $0294, X : SEC : SBC.b #$02 : STA.w $0294, X
    
    JSR.w Ancilla_MoveVert
    JSR.w Ancilla_MoveHoriz
    JSR.w Ancilla_MoveAltitude
    
    LDA.w $029E, X : BEQ .hit_ground
        CMP.b #$FC : BCC .return
    
    .hit_ground
    
    ; Play plopping on the ground noise when it hits the ground.
    LDA.b #$21 : JSR.w Ancilla_DoSfx2
    
    ; Force altitude to zero.
    STZ.w $029E, X
    
    LDA.w $03C5, X : INC : STA.w $03C5, X
    
    CMP.b #$04 : BNE .bounces_maxed_out
        STZ.w $0BF0, X
        STZ.w $03C5, X
        
        BRA .return
        
    .bounces_maxed_out
    
    TAY
    
    DEX
    
    ; Get different resultant altitude speeds for each bounce.
    LDA.w Pool_SomarianBlock_InitDashBounce_bounce_rebound_z_speeds, Y
    STA.w $0294, X
    
    LDA.b $2F : LSR : STA.b $00
    
    TYA : ASL #2 : CLC : ADC.b $00 : TAY
    
    LDY.b #$00
    
    LDA.w $0C22, X : BPL .abs_y_speed
        LDY.b #$01
        
        EOR.b #$FF : INC A
    
    .abs_y_speed
    
    ; Halve the absolute value of the y speed.
    LSR A
    
    CPY.b #$01 : BNE .restore_y_speed_sign
        EOR.b #$FF : INC A
    
    .restore_y_speed_sign
    
    STA.w $0C22, X
    
    LDY.b #$00
    
    LDA.w $0C2C, X : BPL .abs_x_speed
        LDY.b #$01
        
        EOR.b #$FF : INC A
        
    .abs_x_speed
    
    ; Halve the absolute value of the x speed.
    LSR A
    
    CPY.b #$01 : BNE .restore_x_speed_sign
        EOR.b #$FF : INC A
    
    .restore_x_speed_sign
    
    STA.w $0C2C, X
    
    .return
    
    PLB
    
    RTL
}

; ==============================================================================
