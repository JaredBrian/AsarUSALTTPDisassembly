; ==============================================================================

; $041543-$041559 DATA
Pool_Ancilla_Bomb:
{
    ; $041543
    .interstate_intervals
    db 160, 6, 4, 4, 4, 4, 4, 6, 6, 6, 6
    
    ; $04154E
    .chr_groups
    db 0, 1, 2, 3, 2, 3, 4, 5, 6, 7, 8, 9
}

; $04155A-$0417B5 JUMP LOCATION
Ancilla_Bomb:
{
    ; Code for implementing the Bomb Special Effect (0x07).
    LDA.b $11    : BEQ .full_execute
        CMP.b #$08 : BEQ .walking_on_staircase
            CMP.b #$10 : BNE .not_in_room_staircase_submode
        
        .walking_on_staircase
        
        JSR.w Ancilla_LiftableObjectLogic
        
        BRA .just_draw
        
        .not_in_room_staircase_submode
        
        ; Is Link close to the bomb? If not, branch.
        TXA : INC : CMP.w $02EC : BNE .just_draw
            ; Is Link carrying the bomb?
            LDA.w $0380, X : BEQ .just_draw
                CMP.b #$03 : BEQ .player_fully_holding
                    ; Coerce the bomb into the held state immediately.
                    LDY.b #$03
                    
                    JSR.w Ancilla_PegCoordsToPlayer
                    JSR.w Ancilla_PegAltitudeAbovePlayer
                    
                    LDA.b #$03 : STA.w $0380, X
                
                .player_fully_holding
                
                JSR.w Ancilla_SetPlayerHeldPosition
        
        .just_draw
        
        BRL .draw
    
    .full_execute
    
    JSR.w Ancilla_LiftableObjectLogic
    JSR.w Ancilla_Adjust_Y_CoordByAltitude
    
    LDA.w $0C72, X : STA.b $74
    
    LDA.w $0280, X : STA.b $75
    
    STZ.w $0280, X
    
    JSR.w Ancilla_CheckTileCollision_Class2
    
    ; Save the collision flag status.
    PHP
    
    ; Outdoors doesn't use multiple interactive bgs.
    LDA.b $1B : BEQ .dont_coerce_to_bg1
        ; Check to see if the bomb is airborn.
        LDA.w $0385, X : BEQ .dont_coerce_to_bg1
            ; If it hit the top of a 'water staircase', coerce.
            LDA.w $03E4, X : CMP.b #$1C : BNE .dont_coerce_to_bg1
                ; If it's tile type 0x1C (whatever that is), set the transition
                ; flag (to go to BG0).
                LDA.b #$01 : STA.w $03D5, X
        
    .dont_coerce_to_bg1
    
    PLP : BCC .no_tile_collision
            .check_tile_collision

            ; Collision detected with wall.
            BIT.w $0308 : BPL .player_not_holding_anything_yet
                LDA.w $0309 : BEQ .no_tile_collision

            .player_not_holding_anything_yet

            ; Collision detected with wall and link is not holding the bomb in
            ; his hands therefore, collisions matter and we have to handle them.
            LDA.b $75 : BNE .ignore_tile_collision_results
                ; Seemingly flags a collision has been handled and does not need
                ; to be handled again this frame.
                LDA.w $0BF0, X : BNE .ignore_tile_collision_results
                    ; If we reach this point we need to handle a collision.
                    LDA.b #$01 : STA.w $0BF0, X
                    
                    LDA.b #$04 : STA.b $0E
                    
                    LDY.b #-4
                    
                    LDA.w $0C72, X : CMP.b #$01 : BNE .not_oriented_down
                        LDA.b #16 : STA.b $0E
                        
                        LDY.b #-16

                    .not_oriented_down

                    ; Get current y speed.
                    LDA.w $0C22, X : BEQ .at_rest_y
                        BPL .moving_down
                            LDY.b $0E
                        
                        .moving_down
                        
                        ; This is where reversal of y velocity occurs (bounces
                        ; off of a wall).
                        TYA : STA.w $0C22, X
                    
                    .at_rest_y
                    
                    ; Moving left at a rate of 4.
                    LDY.b #-4
                    
                    LDA.w $0C2C, X : BEQ .at_rest_x
                        BPL .moving_right
                            LDY.b #4
                        
                        .moving_right
                        
                        ; This is where reversal of X velocity occurs (bounces
                        ; off of a wall).
                        TYA : STA.w $0C2C, X
                    
                    .at_rest_x
                    
                    ; WTF: I don't know what else to call this label, what are we
                    ; doing here? I realize that the perspective of this game is
                    ; messed up, but what makes the downward physics handling so
                    ; special that it needs all this adjustment?
                    LDA.w $0C72, X : CMP.b #$01 : BNE .dont_fudge_y_velocity
                        LDA.w $029E, X : BEQ .dont_fudge_y_velocity
                            LDA.b #-4 : STA.w $0C22, X
                            
                            LDA.b #$02 : STA.w $0385, X
                        
                    .dont_fudge_y_velocity
            .ignore_tile_collision_results

            .dont_process_ground_touch_logic
            
            BRL .state_logic
        
        .no_tile_collision
        
        ; This branch is taken if collision with a wall was not detected.
        
        TXA : INC : CMP.w $02EC : BNE .player_not_touching_object
            BIT.w $0308 : BMI .ignore_tile_collision_results
        
        .player_not_touching_object
        
        ; Bomb's elevation in pixels.
        LDA.w $029E, X : BEQ .touching_ground
            CMP.b #$FF : BNE .dont_process_ground_touch_logic
        
        .touching_ground
        
        ; Essentially this designates that the bomb has no orientation at the
        ; moment.
        LDA.b #$10 : STA.w $0C72, X
        
        ; Not really sure what purpose saving $0280, X serves...
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
                                ; Checking for any other cane of somaria types.
                                AND.b #$F0 : CMP.b #$B0 : BEQ .pit_tiles
                                
                            .transit_tiles
                            
                            STZ.w $0C68, X
                            
                            ; Check if flying through air:
                            LDA.w $0385, X : BNE .dont_process_ground_touch_logic
                                LDA.b #$02 : STA.w $0C68, X
                                
                                .delay_reckoning
                                
                                BRL .state_logic
                        
                        .conveyor_belt_tiles
                        
                        BRL .apply_conveyor_movement_to_object
            
        .in_floor_staircase_boundary
    
    BRL .check_tile_collision
    
    .niche_collision_tiles
    
    ; Top of water staircase and moving floor tiles end up here.
    BRL .niche_collision_logic
        .deep_water_tile
        
        ; Kills the bomb because it fell in water, then it makes a splash.
        
        TXA : INC : CMP.w $02EC : BNE .water_tile_reset_player_proximity
            ; Don't get the game's hopes up that you can pick up this bomb,
            ; it's set for termination soon!
            STZ.w $02EC
            
        .water_tile_reset_player_proximity
        
        LDA.w $0C68, X : BNE .delay_reckoning
            LDA.w $0BFA, X : CLC : ADC.b #-24     : STA.w $0BFA, X
            LDA.b #-1            : ADC.w $0C0E, X : STA.w $0C0E, X
            
            BRL Ancilla_TransmuteToObjectSplash
            
            .pit_tiles
            
            ; Executed when the bomb falls into a hole.
            LDA.w $0308 : BMI .state_logic
                STX.b $04
                
                LDA.w $02EC : DEC : CMP.b $04 : BNE .pit_tile_reset_player_proximity
                    ; Same as with water tiles, reset this state if necessary.
                    STZ.w $02EC
                    
                .pit_tile_reset_player_proximity
                
                LDA.w $0C68, X : BNE .delay_reckoning
                    BRL Ancilla_SelfTerminate
        
    .niche_collision_logic
    
    LDA.w $046C : CMP.b #$03 : BEQ .moving_floor_collision
        LDA.w $0C7C, X : BNE .state_logic
            ; Check elevation:
            LDA.w $029E, X : BEQ .state_logic ; If zero, branch.
                CMP.b #$FF : BEQ .state_logic ; If it bounced, branch.
                    ; Move the object to BG1.
                    LDA.b #$01 : STA.w $0C7C, X
                    
                    BRA .state_logic
                
    .moving_floor_collision
    
    LDA.w $0310 : CLC : ADC.w $0BFA, X : STA.b $72
    LDA.w $0311 :       ADC.w $0C0E, X : STA.b $73
    
    LDA.w $0312 : CLC : ADC.w $0C04, X : STA.w $0C04, X
    LDA.w $0313 :       ADC.w $0C18, X : STA.w $0C18, X
    
    BRA .state_logic
    
    .apply_conveyor_movement_to_object
    
    JSR.w Ancilla_ConveyorBeltVelocityOverride
    
    ; $041712 ALTERNATE ENTRY POINT
    .state_logic
    
    JSR.w Ancilla_Set_Y_Coord
    
    LDA.b $74 : STA.w $0C72, X
    
    LDA.b $75 : ORA.w $0280, X : STA.w $0280, X
    
    JSR.w Bomb_CheckSpriteAndPlayerDamage
    
    ; Decrement the timer for the bomb.
    DEC.w $039F, X : LDA.w $039F, X : BNE .state_change_delay
        ; Begin the bomb's explosion.
        INC.w $0C5E, X : LDA.w $0C5E, X : CMP.b #$01 : BNE .not_just_exploded
            ; Play the bomb exploding sound.
            LDA.b #$0C : JSR.w Ancilla_DoSfx2
            
            ; Did Link come in contact with the explosion?
            TXA : INC : CMP.w $02EC : BNE .dont_reset_player_lift_state
                ; Link has been hit by this bomb.
                STZ.w $02EC
                
                ; See if he's carrying anything.
                BIT.w $0308 : BPL .dont_reset_player_lift_state
                    ; Make him drop anything he carries.
                    STZ.w $0308
                    
                    ; Unset any flags stopping Link from changing direction.
                    STZ.b $50

            .dont_reset_player_lift_state
        .not_just_exploded

        ; Check the bomb explosion state index (0x01 to 0x0B)
        ; branch if it's not at 0x0B.
        LDA.w $0C5E, X : CMP.b #$0B : BNE .not_fully_exploded
            ; Trigger no special effect... if there's no wall to blow up.
            LDY.b #$00
            
            LDA.w $0C54, X : BEQ .dont_transmute_to_door_debris
                ; Transmute to the door debris special effect.
                LDY.b #$08
            
            .dont_transmute_to_door_debris
            
            TYA : STA.w $0C4A, X
            
            RTS
        
        .not_fully_exploded
        
        ; Explosion states < 0x0B.
        
        ; Y = the explosion state.
        TAY
        
        ; Set a new timer based on which explosion state it is.
        LDA.w .interstate_intervals, Y : STA.w $039F, X
    
    .state_change_delay
    
    LDA.w $0C5E, X : CMP.b #$07 : BNE .draw
        LDA.w $039F, X : CMP.b #$02 : BNE .draw
            PHX
            
            LDA.w $0BFA, X : STA.b $00
            LDA.w $0C0E, X : STA.b $01
            
            LDA.w $0C04, X : STA.b $02
            LDA.w $0C18, X : STA.b $03
            
            STX.b $0E
            
            TXA : ASL : TAX
            
            STZ.w $03B6, X
            STZ.w $03B7, X
            
            JSL.l Bomb_CheckForVulnerableTileObjects
            
            PLX : TXY : TXA : ASL : TAX
            
            LDA.w $03B6, X : ORA.w $03B7, X : BEQ .didnt_blow_open_door
                TYX
                
                ; Set a flag indicating that we need to transmute to the door
                ; debris object when finished exploding.
                LDA.b #$01 : STA.w $0C54, X
                
            .didnt_blow_open_door
            
            TYX
    
    .draw
    
    JSR.w Bomb_Draw
    
    ; 0417B5 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $0417B6-$0417BD DATA
Pool_Ancilla_ConveyorBeltVelocityOverride:
{
    ; $0417B6
    .y_speeds
    db -8,  8,  0,  0
    
    ; $0417BA
    .x_speeds
    db  0,  0, -8,  8
}

; This routine is triggered if a bomb is on a conveyor belt or otherwise
; moving surface.
; $0417BE-$0417E1 LOCAL JUMP LOCATION
Ancilla_ConveyorBeltVelocityOverride:
{
    LDA.w $03E4, X : SEC : SBC.b #$68 : TAY
    
    LDA.w Pool_Ancilla_ConveyorBeltVelocityOverride_y_speeds, Y : STA.w $0C22, X
    LDA.w Pool_Ancilla_ConveyorBeltVelocityOverride_x_speeds, Y : STA.w $0C2C, X
    
    JSR.w Ancilla_MoveVert
    JSR.w Ancilla_MoveHoriz
    
    LDA.w $0BFA, X : STA.b $72
    LDA.w $0C0E, X : STA.b $73
    
    RTS
}

; ==============================================================================

; $0417E2-$041814 DATA
Pool_Bomb_CheckSpriteAndPlayerDamage:
{
    ; $0417E2
    .recoil_magnitudes
    db 32, 32, 32, 32, 32, 32, 28, 28
    db 28, 28, 28, 28, 24, 24, 24, 24
    
    ; $0417F2
    .resistances
    db 16, 16, 16, 16, 16, 16, 12, 12
    db 12, 12,  8   8,  8,  8,  8,  8
    
    ; $041802
    .damage_timers
    db 32, 32, 32, 32, 32, 32, 24, 24
    db 24, 24, 24, 24, 16, 16, 16, 16
    
    ; $041812
    .damage_quantities
    db 8, 4, 2
}

; $041815-$041912 LOCAL JUMP LOCATION
Bomb_CheckSpriteAndPlayerDamage:
{
    ; If the bomb is in state 9 it can do damage.
    LDA.w $0C5E, X : BEQ .dont_damage_anything
        CMP.b #$09 : BCS .dont_damage_anything
            JSR.w Bomb_CheckSpriteDamage
            
            LDA.w $037B : BEQ .player_not_using_invincibility_item
                TXA : INC : CMP.w $02EC : BNE Ancilla_Bomb_return
                    ; If the player is holding the bomb that is exploding, take
                    ; the player out of the "holding something over head" state.
                    LDA.w $0308 : AND.b #$80 : BEQ Ancilla_Bomb_return
                        LDA.w $0308 : AND.b #$7F : STA.w $0308
                        
                        STZ.b $50
            
    .dont_damage_anything
    
    BRL Ancilla_Bomb_return
    
    .player_not_using_invincibility_item
    
    LDA.b $4D : BNE .dont_damage_anything
        LDA.b $46 : BNE .dont_damage_anything
            LDA.w $0C7C, X : CMP.b $EE : BNE .dont_damage_anything
                LDA.b $22 : STA.b $00
                LDA.b $23 : STA.b $08
                LDA.b $20 : STA.b $01
                LDA.b $21 : STA.b $09
                
                LDA.b #$10 : STA.b $02
                LDA.b #$18 : STA.b $03
                
                LDA.w $0C04, X : STA.b $04
                LDA.w $0C18, X : STA.b $05
                
                LDA.w $0BFA, X : STA.b $06
                LDA.w $0C0E, X : STA.b $07
                
                REP #$20
                
                LDA.b $04 : CLC : ADC.w #-16 : STA.b $04
                LDA.b $06 : CLC : ADC.w #-16 : STA.b $06
                
                SEP #$20
                
                LDA.b $05 : STA.b $0A
                LDA.b $06 : STA.b $05
                LDA.b $07 : STA.b $0B
                
                LDA.b #$20 : STA.b $06
                             STA.b $07
                
                JSL.l Utility_CheckIfHitBoxesOverlapLong : BCC .dont_damage_player
                    LDA.w $0C04, X : CLC : ADC.b #$-8 : STA.b $00
                    LDA.w $0C18, X :       ADC.b #$-1 : STA.b $01
                    
                    LDA.w $0BFA, X : CLC : ADC.b #$-12 : STA.b $02
                    LDA.w $0C0E, X :       ADC.b #$-1  : STA.b $03
                    
                    PHX
                    
                    JSR.w Bomb_GetGrossPlayerDistance
                    
                    LDA.w .recoil_magnitudes, Y : TAY
                    
                    JSL.l Bomb_ProjectSpeedTowardsPlayer
                    
                    PLX
                    
                    ; If Link is already flashing he's invulnerable.
                    LDA.w $031F : BNE .dont_damage_player
                        ; Check for the menu being unable to be activated.
                        LDA.w $0FFC : CMP.b #$02 : BEQ .dont_damage_player
                            LDA.b $00 : STA.b $27
                            LDA.b $01 : STA.b $28
                            
                            JSR.w Bomb_GetGrossPlayerDistance
                            
                            LDA.w .resistances, Y : STA.b $29 : STA.w $02C7
                            
                            LDA.w .damage_timers, Y : STA.b $46
                            
                            ; Put Link in recoil mode.
                            LDA.b #$01 : STA.b $4D
                            
                            ; Make Link's sprite blink.
                            LDA.b #$3A : STA.w $031F
                            
                            ; If the boss is beaten Link is invincible!
                            LDA.w $0403 : AND.b #$80 : BNE .dont_damage_player
                                ; Check his armor status:
                                LDA.l $7EF35B : TAY
                                
                                ; Damage Link by this amount.
                                LDA.w .damage_quantities, Y : STA.w $0373
                        
                .dont_damage_player
                
                RTS
}

; ==============================================================================

; $041913-$041975 DATA
Pool_Ancilla_LiftableObjectLogic:
{
    ; $041913
    .player_relative_y_offsets
    dw 16, 8, 4, 4
    dw 8, 2, -1, -1
    dw 2, 2, -1, -1
    
    ; $04192B
    .player_relative_x_offsets
    dw 8, 8, -4, 20
    dw 8, 8, 8, 8
    dw 8, 8, 8, 8
    
    ; $041943
    .lift_timers
    db 16, 8, 9
    
    ; $041946
    .z_offset_player_moving
    dw -2, -1, 0, -2, -1, 0
    
    ; $041952
    .throw_y_speeds
    db -32,  32,   0,   0
    
    ; $041956
    .throw_x_speeds
    db   0,   0, -32,  32
    
    ; UNUSED: Presumably for testing throws and bounces.
    ; $04195A
    .unused_throw_y_speeds
    db   8,   8,   0,   0
    db   4,   4,   0,   0
    
    ; UNUSED: Presumably for testing throws and bounces.
    ; $041962 to $41969
    .unused_throw_x_speeds
    db   0,   0,   8,   8
    db   0,   0,   4,   4
    
    ; $04196A
    .postbounce_z_speeds
    db 16, 16
    
    ; UNUSED: Presumably for testing throws and bounces.
    ; $04196C
    .unused_postbounce_z_speeds
    db 16, 16, 8,  8,  8,  8
    
    ; $041972
    .compatible_lift_directions
    db 0, 2, 4, 6
}

; $041976-$041BEE LOCAL JUMP LOCATION
Ancilla_LiftableObjectLogic:
{
    ; Setting this flag causes player to not be able to pick it up.
    LDA.w $03EA, X : BNE .not_currently_liftable
        ; Is it in motion?
        LDA.w $0385, X : BEQ .not_airborn
            BRL .airborn_logic
            
        .not_airborn
        
        STX.b $00
        
        ; This is set to the special effect index + 1 of a detected collision.
        LDA.w $02EC : BEQ .player_not_near_to_any_object
            ; This branch fails if some other sprite triggered $02EC.
            DEC : CMP.b $00 : BEQ .closest_liftable_object_to_player
                RTS
            
            .closest_liftable_object_to_player
            
            ; Collision detected and it matches this special effect.
            LDY.w $037B : BNE .player_invulnerable
                LDA.b $46 : BNE .not_liftable_per_player_damage_timer
            
            .player_invulnerable
            
            LDA.w $03FD : BNE .travel_bird_in_play
                LDA.b $4D : CMP.b #$01 : BNE .player_not_in_recoil
                    .travel_bird_in_play
                    
                    .not_liftable_per_player_damage_timer
                    
                    LDA.b #$01 : STA.w $03EA, X
                    
                    STZ.w $0294, X
                    
                    ; Set it so there's no possibility of lifting anything
                    ; this frame.
                    STZ.w $02EC
                    
                    STZ.w $0BF0, X
                    
                    BRA .not_currently_liftable
            
            .player_not_in_recoil
            
            ; This code is hit when Link is within range of the bomb.
            LDA.w $0308 : BPL .player_not_holding_anything_yet
                BRL .player_already_carrying_something
        
    .not_currently_liftable
    
    BRL .altitude_physics
    
    .player_not_holding_anything_yet
    .player_not_near_to_any_object
    
    ; Set collision detection to "false".
    STZ.w $02EC
    
    ; Check explosion status (0 = not exploded yet).
    LDA.w $0C5E, X : BNE .not_liftable_2
        ; See if Link is lifting or lifted anything.
        LDA.w $0308 : BNE .not_liftable_2
            LDY.b #$00
            
            JSR.w Ancilla_CheckPlayerCollision : BCC .not_liftable_2
                LDA.w $0C7C, X : CMP.b $EE : BNE .not_liftable_2
                    LDA.b $08 : CMP.b #$10 : BCS .vertical_distance_large
                        LDA.b $0A : CMP.b #$0C : BCC .begin_lifting
                    
                    .vertical_distance_large
                    
                    LDA.b $08 : CMP.b $0A : BCC .vertical_distance_less
                        LDY.b #$00
                        
                        LDA.b $04 : BPL .is_player_direction_suitable_for_lift
                            INY
                            
                            BRA .is_player_direction_suitable_for_lift
                            
                    .vertical_distance_less
                    
                    LDY.b #$02
                    
                    LDA.b $06 : BPL .is_player_direction_suitable_for_lift
                        INY
                    
                    .is_player_direction_suitable_for_lift
                    
                    ; Check if player facing a proper direction for lifting
                    ; the object.
                    LDA.w .compatible_lift_directions, Y : CMP.b $2F : BNE .not_liftable_2
                        .begin_lifting
                        
                        ; Collision detected?
                        TXA : INC : STA.w $02EC
                        
                        STZ.w $0380, X
                        
                        LDA.w .lift_timers : STA.w $03B1, X
                        
                        STZ.w $0385, X
                        STZ.w $029E, X
    
    .not_liftable_2
    
    RTS
    
    .player_already_carrying_something
    
    ; Check if Link is already picking up something or throwing it.
    LDA.w $0309 : CMP.b #$02 : BEQ .throw_logic
        LDA.w $02EC : BEQ .throw_logic
            LDY.w $0380, X : CPY.b #$03 : BEQ .throw_logic
                CPY.b #$00 : BNE .dont_play_lift_SFX
                    LDA.w $03B1, X : CMP.b #$10 : BNE .dont_play_lift_SFX
                        LDA.b #$1D : JSR.w Ancilla_DoSfx2
                    
                .dont_play_lift_SFX
                
                DEC.w $03B1, X : BPL Ancilla_PegCoordsToPlayer
                    ; Make Link pick up the bomb (1 all the way to 3).
                    INY : TYA : STA.w $0380, X
                    
                    LDA.w .lift_timers, Y : STA.w $03B1, X
                    CPY.b #$03 : BNE Ancilla_PegCoordsToPlayer
                        ; $041A4F ALTERNATE ENTRY POINT
                        Ancilla_PegAltitudeAbovePlayer:
                        
                        ; This subsection makes the elevation 0x11, but also
                        ; pushes the y coordinate down 0x11 pixels.
                        ; Altitude += 0x11.
                        LDA.b #$11 : STA.w $029E, X
                        
                        ; y_coord += 0x11.
                        LDA.w $0BFA, X : CLC : ADC.b #$11 : STA.w $0BFA, X
                        LDA.w $0C0E, X       : ADC.b #$00 : STA.w $0C0E, X
                        
                        STZ.w $0280, X
                        
                        ; OPTIMIZE: Just put an RTS here.
                        BRA .cant_throw
                    
                ; $041A6A ALTERNATE ENTRY POINT
                Ancilla_PegCoordsToPlayer:
                
                TYA : ASL #3 : CLC : ADC.b $2F : TAY
                
                LDA.b $20 : CLC : ADC .player_relative_y_offsets+0, Y : STA.w $0BFA, X
                LDA.b $21       : ADC .player_relative_y_offsets+1, Y : STA.w $0C0E, X
                
                LDA.b $22 : CLC : ADC .player_relative_x_offsets+0, Y : STA.w $0C04, X
                LDA.b $23       : ADC .player_relative_x_offsets+1, Y : STA.w $0C18, X
                
                .cant_throw
                
                RTS
    
    .throw_logic
    
    LDA.w $0380, X : CMP.b #$03 : BNE .cant_throw
    
    LDA.w $0309 : CMP.b #$02 : BEQ .throwing_object
        LDA.b $11 : BNE .ignore_throw_logic
            ; Lets you throw the bomb with either the A or B button.
            LDA.b $F6 : ORA.b $F4 : AND.b #$80 : BNE .throwing_object

        .ignore_throw_logic
            
        BRL .player_fall_logic
    
    .throwing_object
    
    LDA.b $2F : LSR : STA.w $0C72, X : TAY
    
    ; Gives the object 0x18 points of lift.
    LDA.b #$18 : STA.w $0294, X
    
    ; Set the Y and X velocity for the bomb.
    LDA.w Pool_Ancilla_LiftableObjectLogic_throw_y_speeds, Y : STA.w $0C22, X
    LDA.w Pool_Ancilla_LiftableObjectLogic_throw_x_speeds, Y : STA.w $0C2C, X
    
    ; Make it look like Link is throwing the object.
    LDA.b #$02 : STA.w $0309
    
    ; Indicate that the object is in motion.
    DEC : STA.w $0385, X
    
    ; Player is not colliding with the object.
    STZ.w $02EC
    
    STZ.w $0BF0, X ; ???
    STZ.w $0380, X ; Set carrying state to zero (not holding it).
    STZ.w $0280, X
    
    LDA.b #$13 : JSR.w Ancilla_DoSfx3
    
    .airborn_logic
    
    LDA.w $0C5E, X : BEQ .airborn_in_ground_state
        ; If the object has exploded or otherwise changed from ground state,
        ; it stops moving, even in the air.
        RTS
        
    .airborn_in_ground_state
    
    ; Simulate gravity.
    LDA.w $0294, X : SEC : SBC.b #$02 : STA.w $0294, X
    
    JSR.w Ancilla_MoveVert
    JSR.w Ancilla_MoveHoriz
    
    LDA.w $029E, X : STA.b $00
    
    JSR.w Ancilla_MoveAltitude
    
    LDA.w $0BF0, X : BEQ .dont_add_altitude_back_to_y_coord
        LDA.w $0C72, X : CMP.b #$01 : BNE .dont_add_altitude_back_to_y_coord
            LDA.w $0BFA, X : STA.b $0C
            LDA.w $0C0E, X : STA.b $0D
            
            LDA.w $029E, X : BMI .dont_add_altitude_back_to_y_coord
                SEC : SBC.b $00 : STA.b $0E
                
                REP #$20
                
                LDA.b $0E : AND.w #$00FF : CMP.w #$0080 : BCC .sign_ext_y_coord
                    ORA.w #$FF00
                
                .sign_ext_y_coord
                
                CLC : ADC.b $0C : STA.b $0C
                
                SEP #$20
                
                LDA.b $0C : STA.w $0BFA, X
                LDA.b $0D : STA.w $0C0E, X
    
    .dont_add_altitude_back_to_y_coord
    
    LDA.w $029E, X : CMP.b #$80 : BCS .negative_altitude
        .didnt_just_hit_ground
        
        RTS
    
    .negative_altitude
    
    CMP.b #$FF : BCS .didnt_just_hit_ground
    
    STZ.w $029E, X
    
    ; Play the "bomb hitting the ground" sound.
    LDA.b #$21 : JSR.w Ancilla_DoSfx2
    
    INC.w $0385, X
    LDA.w $0385, X : CMP.b #$03 : BEQ .bounces_maxed_out
        SEC : SBC.b #$02 : ASL #2 : CLC : ADC.w $0C72, X : TAY
        
        LDY.b #$00
        
        LDA.w $0C22, X : BPL .halve_y_speed_due_to_ground_hit
            LDY.b #$01
            
            EOR.b #$FF : INC A
        
        .halve_y_speed_due_to_ground_hit
        
        LSR A
        
        CPY.b #$01 : BNE .restore_y_speed_sign
            EOR.b #$FF : INC A
        
        .restore_y_speed_sign
        
        STA.w $0C22, X
        
        LDY.b #$00
        
        LDA.w $0C2C, X : BPL .halve_x_speed_due_to_ground_hit
            LDY.b #$01
            
            EOR.b #$FF : INC A
            
        .halve_x_speed_due_to_ground_hit
        
        LSR A
        
        CPY.b #$01 : BNE .restore_x_speed_sign
            EOR.b #$FF : INC A
        
        .restore_x_speed_sign
        
        STA.w $0C2C, X
        
        LDA.w Pool_Ancilla_LiftableObjectLogic_postbounce_z_speeds, Y
        STA.w $0294, X
        
        LDA.w $0BF0, X : BEQ .dont_transition_bg
            ; Reset collision already detected flag.
            STZ.w $0BF0, X
            
            RTS
        
    .bounces_maxed_out
    
    STZ.w $029E, X
    STZ.w $0385, X
    STZ.w $0BF0, X
    STZ.b $5E
    STZ.w $0C22, X
    STZ.w $0C2C, X
    STZ.w $0294, X
    
    LDA.w $03D5, X : BEQ .dont_transition_bg
        ; Performs a transition from BG2 to BG1 for the bomb.
        STA.w $0C7C, X
        
        STZ.w $03D5, X
    
    .dont_transition_bg
    
    RTS
    
    .player_fall_logic

    LDA.w $0C5E, X : BNE .ignore_player_fall_logic
        LDA.b $5B : CMP.b #$02 : BCC .player_not_falling
            STZ.b $5E
            
            TXA : INC : CMP.w $02EC : BNE .player_not_falling_with_this_object
                STZ.w $02EC
                
                ; Just terminate the held ancilla if the player is falling
                ; into a pit.
                STZ.w $0C4A, X
                
            .player_not_falling_with_this_object
            
            RTS
            
        .player_not_falling
        
        ; Are we in water or using the bunny graphics set?
        LDA.w $0345 : ORA.w $02E0 : BEQ Ancilla_SetPlayerHeldPosition
            STZ.w $0308
            
            BRL .throwing_object
}
        
; $041BEF-$041C7E LOCAL JUMP LOCATION
Ancilla_SetPlayerHeldPosition:
{  
    ; Link's animation status.
    LDA.b $2E : ASL : TAY
        
    ; Slow player down because they're carrying something.
    LDA.b #$0C : STA.b $5E
        
    ; Make the floor the player is on the floor that the bomb is on.
    LDA.b $EE : STA.w $0C7C, X
        
    ; Same, but for pseudo-bg.
    LDA.w $0476 : STA.w $03CA, X
        
    REP #$20
        
    LDA.b $24 : CMP.w #$-1 : BNE .player_didnt_just_hit_ground
        LDA.w #$0000
        
    .player_didnt_just_hit_ground
        
    EOR.w #$FFFF : INC A
        
    CLC : ADC.b $20 : CLC : ADC.w .z_offset_player_moving, Y
                    CLC : ADC.w #$0012 : STA.b $00
    LDA.b $22       : CLC : ADC.w #$0008 : STA.b $02
        
    SEP #$20
        
    LDA.b $00 : STA.w $0BFA, X
    LDA.b $01 : STA.w $0C0E, X
        
    LDA.b $02 : STA.w $0C04, X
    LDA.b $03 : STA.w $0C18, X
    
    .ignore_altitude_physics
    .ignore_player_fall_logic
    
    RTS
    
    .altitude_physics
    
    LDA.w $0C5E, X : BNE .ignore_altitude_physics
    
    LDA.w $0380, X : CMP.b #$03 : BNE .restore_liftability
        ; Simulate gravity.
        LDA.w $0294, X : SEC : SBC.b #$02 : STA.w $0294, X
        
        JSR.w Ancilla_MoveAltitude
        
        LDA.w $029E, X : BEQ .on_ground
            CMP.b #$FC : BCC .return
        
        .on_ground
        
        STZ.w $029E, X
        
        INC.w $03EA, X
        LDA.w $03EA, X : CMP.b #$03 : BEQ .bounces_maxed
            LDA.b #$18 : STA.w $0294, X
            
            BRA .return
              
        .bounces_maxed
        
        STZ.w $029E, X
        STZ.w $0380, X
    
    .restore_liftability
    
    ; Make object liftable again.
    STZ.w $03EA, X
    
    STZ.b $5E
    
    .return
    
    RTS
}

; ==============================================================================

; Ancilla routine for adjusting objects for height.
; $041C7F-$041CC2 LOCAL JUMP LOCATION
Ancilla_Adjust_Y_CoordByAltitude:
{
    LDA.w $0BFA, X : STA.b $72
    LDA.w $0C0E, X : STA.b $73
    
    STZ.b $0D
    STZ.b $0C
    
    ; 'Down' here means in the y axis, akin to 'southern direction'.
    LDA.w $0C72, X : ASL : TAY : CMP.b #$02 : BNE .not_oriented_down
        LDA.w $029E, X : STA.b $0C : BPL .positive_altitude
            LDA.b #$FF : STA.b $0D
        
        .positive_altitude
    .not_oriented_down
    
    REP #$20
    
    LDA.b $0C : CMP.w #$FFFF : BNE .not_hitting_ground
        LDA.w #$0000
    
    .not_hitting_ground
    
    EOR.w #$FFFF : INC : CLC : ADC.b $72 : STA.b $0E
    
    SEP #$20
    
    LDA.b $0E : STA.w $0BFA, X
    LDA.b $0F : STA.w $0C0E, X
    
    RTS
}

; ==============================================================================

; $041CC3-$041CCD LOCAL JUMP LOCATION
Ancilla_Set_Y_Coord:
{
    LDA.b $73 : STA.w $0C0E, X
    LDA.b $72 : STA.w $0BFA, X
    
    RTS
}

; ==============================================================================

; NOTE: I'd call this an absolute distance or a euclidean distance, but that
; would be totally wrong. This gets the sum of the difference of delta x
; and delta y of the player and bomb coordinates.
    
; $041CCE-$041D0F LOCAL JUMP LOCATION
Bomb_GetGrossPlayerDistance:
{
    LDA.w $0C04, X : STA.b $06
    LDA.w $0C18, X : STA.b $07
    
    LDA.w $0BFA, X : STA.b $04
    LDA.w $0C0E, X : STA.b $05
    
    REP #$20
    
    ; A = Link's X pos. + 8 - effect's X pos.
    LDA.b $22 : CLC : ADC.w #$0008 : SEC : SBC.b $06 : BPL .abs_delta_x
        ; A = abs(A) [absolute value].
        EOR.w #$FFFF : INC A
    
    .abs_delta_x
    
    STA.b $0A
    
    LDA.b $20 : CLC : ADC.w #$000C : SEC : SBC.b $04 : BPL .abs_delta_y
        ; A = abs(Link's Y pos. + 0x0C - effect's Y pos).
        EOR.w #$FFFF : INC A
    
    .abs_delta_y
    
    ; Add the X and Y absolute distances together, and snap to a
    ; 4 by 4 pixel grid.
    CLC : ADC.b $0A : AND.w #$00FC : LSR #2 : TAY
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $041D10-$041E9D DATA
Pool_Bomb_Draw:
Pool_Bomb_DrawExplosion:
{
    ; $041D10
    .chr_and_properties
    .chr
    
    db $6E
    
    ; $041D11
    .properties
    db $26
    
    db $FF, $FF
    db $FF, $FF
    db $FF, $FF
    db $FF, $FF
    
    db $FF, $FF
    db $8C, $22
    db $8C, $62
    db $8C, $A2
    
    db $8C, $E2
    db $FF, $FF
    db $FF, $FF
    db $84, $22
    
    db $84, $62
    db $84, $A2
    db $84, $E2
    db $FF, $FF
    
    db $FF, $FF
    db $88, $22
    db $88, $62
    db $88, $A2
    
    db $88, $E2
    db $FF, $FF
    db $FF, $FF
    db $86, $22
    db $88, $22
    
    db $88, $62
    db $88, $A2
    db $88, $E2
    db $FF, $FF
    
    db $86, $22
    db $86, $62
    db $86, $E2
    db $86, $E2
    db $FF, $FF
    db $FF, $FF
    
    db $86, $E2
    db $86, $22
    db $86, $22
    db $86, $62
    db $86, $A2
    db $86, $A2
    
    db $8A, $A2
    db $8A, $62
    db $8A, $22
    db $8A, $62
    db $8A, $62
    db $8A, $E2
    
    db $9B, $22
    db $9B, $A2
    db $9B, $62
    db $9B, $E2
    db $9B, $A2
    db $9B, $22
    
    ; $041D7C
    .xy_offsets
    .y_offsets
    dw  -8
    
    .x_offsets
    dw  -8
    
    ; 4x0
    dw   0,   0
    dw   0,   0
    dw   0,   0
    dw   0,   0
    
    ; 4x1
    dw   0,   0
    dw  -8,  -8
    dw  -8,   0
    dw   0,  -8
    
    ; 4x2
    dw   0,   0
    dw   0,   0
    dw   0,   0
    dw -16, -16
    
    ; 4x3
    dw -16,   0
    dw   0, -16
    dw   0,   0
    dw   0,   0
    
    ; 4x4
    dw   0,   0
    dw -16, -16
    dw -16,   0
    dw   0, -16
    
    ; 5x1
    dw   0,   0
    dw   0,   0
    dw   0,   0
    dw  -8,  -8
    dw -21, -22
    
    ; 4x1
    dw -21,   8
    dw   9, -22
    dw   9,   8
    dw   0,   0
    
    ; 6x0
    dw  -6, -15
    dw   0,  -1
    dw -16,  -2
    dw  -8,  -7
    dw   0,   0
    dw   0,   0
    
    ; 6x1
    dw  -9,  -4
    dw -21,  -5
    dw -12, -18
    dw -11,   7
    dw   0, -15
    dw   4,  -2
    
    ; 6x2
    dw  -9,  -4
    dw -22,  -5
    dw -13, -20
    dw -11,   8
    dw   1, -16
    dw   5,  -2
    
    ; NOTE: For future reference, this is used, somehow.
    dw -20,   4
    dw -12, -19
    dw  -9,  16
    dw  -5,  -2
    dw   2,  -9
    dw  10,   6
    
    ; NOTE: The entries that are '1' are designed to push the sprite
    ; off screen, as in disable it from being viewed.
    ; $041E54
    .OAM_sizes
    db 2, 1, 1, 1, 1, 1
    db 0, 0, 0, 0, 1, 1
    db 2, 2, 2, 2, 1, 1
    db 2, 2, 2, 2, 1, 1
    db 2, 2, 2, 2, 2, 1
    db 2, 2, 2, 2, 1, 1
    db 2, 2, 2, 2, 2, 2
    db 2, 2, 2, 2, 2, 2
    db 0, 0, 0, 0, 0, 0        
    
    ; $041E8A
    .chr_start_offset
    db 0, 6, 12, 18, 24, 30, 36, 42, 48
    
    ; $041E93
    .num_OAM_entries
    db 1, 4, 4, 4, 4, 4, 5, 4, 6, 6, 6
}

; $041E9E-$041FB5 LOCAL JUMP LOCATION
Bomb_Draw:
{
    JSR.w Ancilla_PrepAdjustedOamCoord
    
    REP #$20
    
    ; Elevation of the special effect.
    LDA.w $029E, X : AND.w #$00FF : CMP.w #$0080 : BCC .sign_ext_z_coord
        ORA.w #$FF00
    
    .sign_ext_z_coord
    
    STA.b $04 : BEQ .not_max_OAM_priority
        CMP.w #$FFFF : BEQ .not_max_OAM_priority
            LDA.w $0380, X : AND.w #$00FF : CMP.w #$0003 : BEQ .not_max_OAM_priority
                LDA.w $0280, X : AND.w #$00FF : BEQ .not_max_OAM_priority
                    LDA.w #$3000 : STA.b $64
        
    .not_max_OAM_priority
    
    LDA.w #$0000 : CLC : ADC.b $04 : EOR.w #$FFFF : INC : CLC : ADC.b $00 : STA.b $00
    
    SEP #$20
    
    ; Y = bomb state.
    LDY.w $0C5E, X
    
    LDA Ancilla_Bomb_chr_groups, Y : TAY
    
    LDA Bomb_Draw_chr_start_offset, Y : ASL : TAY
    
    ASL : STA.b $04 : STZ.b $05
    
    STZ.b $0A
    
    ; Use palette 1.
    LDA.b #$02 : STA.b $0B
    
    LDA.w $0C5E, X : BNE .dont_palette_cycle
        ; Use palette 2.
        LDA.b #$04 : STA.b $0B
        
        ; Check the timer.
        ; If timer is >= 0x20 branch...
        LDA.w $039F, X : CMP.b #$20 : BCS .dont_palette_cycle
            ; Cycle the palette as it's nearing explosion.
            AND.b #$0E : STA.b $0B
    
    .dont_palette_cycle
    
    ; X is either the first or second bomb (0 or 1).
    PHX : PHY
    
    ; Wxploding state? branch!
    LDA.w $0C5E, X : STA.b $08 : BNE .determine_underside_sprite
        ; Bomb in flight? branch!
        LDA.w $0385, X : BNE .not_player_deference
            LDA.w $0E20 : CMP.b #$92 : BEQ .helmasaur_king_present
                TXY : INY : CPY.w $02EC : BNE .not_player_deference
                
            .helmasaur_king_present
            
            LDA.w $0308 : AND.b #$80 : BEQ .defer_for_uncarrying_player
                LDA.w $0380, X : CMP.b #$03 : BEQ .not_player_deference
                    LDA.b $2F : BNE .not_player_deference
                    
            .defer_for_uncarrying_player
            
            ; This only seems to get called if Link is near the bomb.
            LDA.b #$0C : JSR.w Ancilla_AllocateOam_B_or_E
            
            BRA .determine_underside_sprite
        
        .not_player_deference
        
        LDA.w $0FB3 : BEQ .determine_underside_sprite
            LDA.w $0C7C, X : BEQ .determine_underside_sprite
                LDA.w $0385, X : BNE .use_specific_OAM_region
                    TXY : INY : CPY.w $02EC : BNE .determine_underside_sprite
                        LDA.w $0308 : BPL .determine_underside_sprite
                        
                .use_specific_OAM_region
                
                REP #$20
                
                ; OPTIMIZE: Use constant folding to reduce by two instructions.
                LDA.w #$00D0 : CLC : ADC.w #$0800 : STA.b $90
                LDA.w #$0034 : CLC : ADC.w #$0A20 : STA.b $92
                
                SEP #$20
        
    .determine_underside_sprite
    
    ; Load the current state of the bomb.
    LDY.b $08
    
    LDA.w .num_OAM_entries, Y : STA.b $08
    
    CPY.b #$00 : BNE .no_underside_sprite
        ; Is the type of tile it's standing on a 0x09 type?
        LDA.w $03E4, X : CMP.b #$09 : BEQ .in_deep_water
            CMP.b #$40 : BNE .no_underside_sprite
        
        .in_deep_water
        
        LDY.b #$08
        
        BRA .setup_underside_sprite_coords
        
    .no_underside_sprite
    
    LDY.b #$00
    
    .setup_underside_sprite_coords
    
    LDA.b $00 : STA.b $0C
    LDA.b $01 : STA.b $0D
    
    LDA.b $02 : STA.b $0E
    LDA.b $03 : STA.b $0F
    
    STZ.b $06
    
    PLX ; X = the old Y, which is some value like 0, 6, 18, 24, ??? etc.
    
    JSR.w Bomb_DrawExplosion
    
    PLX ; X = the old index for the bomb (either 0 or 1).
    
    JSL.l Bomb_CheckUndersideSpriteStatus : BCS .dont_draw_shadow
        ; (Aet in the previous routine).
        LDX.b $0A : JSR.w Ancilla_DrawShadow
        
        LDX.w $0FA0
    
    .dont_draw_shadow
    
    RTS
}

; ==============================================================================
