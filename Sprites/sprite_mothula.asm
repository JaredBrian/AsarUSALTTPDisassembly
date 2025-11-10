; ==============================================================================

!spike_activation_timer = $0EB0
!beam_timer             = $0ED0

; ==============================================================================

; $0F3E7E-$0F3E87 JUMP LOCATION
Sprite_Mothula:
{
    JSR.w Mothula_Main
    JSR.w Sprite3_CheckIfActive
    JSR.w Mothula_ActivateMovingSpikeBlock
    
    RTS
}

; ==============================================================================

; $0F3E88-$0F3ED7 LOCAL JUMP LOCATION
Mothula_Main:
{
    JSL.l Mothula_DrawLong
    
    LDA.w $0DD0, X : CMP.b #$0B : BNE .not_stunned
        ; \tcrf(confirmed) I can't get this to ever execute. If you do force
        ; Mothula to a stunned state, it will drop to the floor (like you'd
        ; expect). Also have to set the stun timer for the sprite for that to
        ; work. After Mothula recovers, it sometimes is invisible and probably
        ; invulnerable. It's not clear why, but it suggests that the sprite
        ; originally would have been stunned in this fashion by use of the fire
        ; rod or another special weapon. This is just speculation, though. It
        ; also suggests that they couldn't get it to work properly.
        STZ.w $0D80, X
    
    .not_stunned
    
    JSR.w Sprite3_CheckIfActive
    
    STZ.w $0E60, X
    
    LDA.w $0EE0, X : BEQ .vulnerable
        ; Make sprite impervious (while the above timer ticks down).
        LDA.b #$40 : STA.w $0E60, X
    
    .vulnerable
    
    LDA.w $0EA0, X : BEQ .not_recoiling
        AND.b #$7F : CMP.b #$06 : BNE .early_recover_delay
            ; Mothula apparently recovers slightly earlier from recoil than
            ; typical sprites.
            STZ.w $0EA0, X
            
            ; Make sprite impervious for about a half second.
            LDA.b #$20 : STA.w $0EE0, X
            
            ; And use this AI pointer.
            LDA.b #$02 : STA.w $0D80, X
            
            STZ.w $0DF0, X
            
            LDA.b #$40 : STA.w !beam_timer, X
        
        .early_recover_delay
    .not_recoiling
    
    JSR.w Sprite3_CheckIfRecoiling
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable 
    dw Mothula_Delay
    dw Mothula_Ascend
    dw Mothula_FlyAbout
    dw Mothula_FireBeams
}

; ==============================================================================

; $0F3ED8-$0F3EE0 JUMP LOCATION
Mothula_Delay:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F3EE1-$0F3F06 JUMP LOCATION
Mothula_Ascend:
{
    LDA.b #$08 : STA.w $0F80, X
    
    JSR.w Sprite3_MoveAltitude
    
    STZ.w $0F80, X
    
    LDA.w $0F70, X : CMP.b #$18 : BCC .below_target_altitude
        LDA.b #$80 : STA.w !beam_timer, X
        
        INC.w $0D80, X
        
        ; Make vulnerable to projectiles again (like the fire rod shot).
        STZ.w $0BA0, X
        
        LDA.b #$40 : STA.w $0DF0, X
    
    .below_target_altitude
    
    JSR.w Mothula_FlapWings
    
    RTS
}

; ==============================================================================

; $0F3F07-$0F3F12 DATA
Pool_Mothula_FlyAbout:
{
    ; $0F3F07
    .z_accelerations
    db 1, -1
    
    ; $0F3F09
    .y_speeds length 8
    db -16, -12
    
    ; $0F3F0B
    .x_speeds 
    db 0, 12, 16, 12, 0, -12, -16, -12
}

; ==============================================================================

; $0F3F13-$0F3F9A JUMP LOCATION
Mothula_FlyAbout:
{
    LDA.w !beam_timer, X : BNE .delay_beam_firing_mode
        LDA.b #$3F : STA.w $0DF0, X
        
        INC.w $0D80, X
        
        RTS
    
    .delay_beam_firing_mode
    
    DEC.w !beam_timer, X
    
    JSR.w Mothula_FlapWings
    
    LDA.w $0D90, X : AND.b #$01 : TAY
    LDA.w $0F80, X : CLC : ADC.w .z_accelerations, Y : STA.w $0F80, X
    CMP.w Sprite3_Shake_x_speeds, Y : BNE .anotoggle_z_acceleration_polarity
        INC.w $0D90, X
    
    .anotoggle_z_acceleration_polarity
    
    LDA.w $0DF0, X : BNE .delay_xy_speed_adjustment
        INC.w $0DB0, X
        LDA.w $0DB0, X : CMP.b #$07 : BNE .use_random_xy_speeds
            STZ.w $0DB0, X
            
            BRA .go_towards_player
        
        .use_random_xy_speeds
        
        ; Speeds are randomly selected.
        JSL.l GetRandomInt : AND.b #$07 : TAY
        LDA.w .x_speeds, Y : STA.w $0D50, X
        LDA.w .y_speeds, Y : STA.w $0D40, X
        
        JSL.l GetRandomInt : AND.b #$1F : ADC.b #$40 : STA.w $0DF0, X
        
        BRA .tile_collision_logic
        
        .go_towards_player
        
        LDA.b #$20
        JSL.l Sprite_ApplySpeedTowardsPlayerLong
        
        LDA.b #$80 : STA.w $0DF0, X
        
    .delay_xy_speed_adjustment
    .tile_collision_logic
    
    LDA.w $0E70, X : BNE .move_if_no_tile_collision
        JSR.w Sprite3_Move
    
    .move_if_no_tile_collision
    
    JSR.w Sprite3_MoveAltitude
    
    JSR.w Sprite3_CheckTileCollision : BEQ .no_tile_collision
        ; Immediately do a speed adjustment next frame if we hit a solid tile.
        STZ.w $0DF0, X
    
    .no_tile_collision
    
    JSR.w Sprite3_CheckDamage
    
    INC.w $0E80, X : INC.w $0E80, X
    
    RTS
}

; ==============================================================================

; $0F3F9B-$0F3F9E DATA
Mothula_FlapWings_animation_states:
{
    db 0, 1, 2, 1
}

; $0F3F9F-$0F3FB8 LOCAL JUMP LOCATION
Mothula_FlapWings:
{
    INC.w $0E80, X
    LDA.w $0E80, X : LSR : LSR : AND.b #$03 : TAY
    BNE .SFX_delay
        LDA.b #$02
        JSL.l Sound_SetSFX3PanLong
    
    .SFX_delay
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F3FB9-$0F3FD8 JUMP LOCATION
Mothula_FireBeams:
{
    JSR.w Sprite3_CheckDamage
    
    LDA.w $0DF0, X : BNE .delay
        DEC.w $0D80, X
        
        JSL.l GetRandomInt : AND.b #$1F : ORA.b #$40 : STA.w !beam_timer, X
        
        RTS
        
    .delay
    
    CMP.b #$20 : BNE .dont_fire_beam
        JSR.w Mothula_SpawnBeams
    
    .dont_fire_beam
    
    BRA Mothula_FlapWings
}

; ==============================================================================

; $0F3FD9-$0F3FDE DATA
Pool_Mothula_SpawnBeams:
{
    ; NOTE: Yes, they are combined for this routine.
    ; $0F3FD9
    .x_offsets
    .x_speeds
    db -16, 0, 16
    
    ; $0F3FDC
    .y_speeds
    db 24, 32, 24
}

; $0F3FDF-$0F402D BRANCH LOCATION
Mothula_SpawnBeams:
{
    LDA.b #$36
    JSL.l Sound_SetSFX3PanLong
    
    LDA.b #$02 : STA.w $0FB5
    
    .spawn_next_beam
    
        LDA.b #$89
        JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            JSL.l Sprite_SetSpawnedCoords
            
            LDA.b $02 : SEC : SBC.b $04 : CLC : ADC.b #$03 : STA.w $0D00, Y
            
            LDA.b #$10 : STA.w $0DF0, Y
                         STA.w $0BA0, Y
            
            PHX
            
            LDX.w $0FB5
            LDA.b $00
            CLC : ADC.w Pool_Mothula_SpawnBeams_x_offsets, X : STA.w $0D10, Y
            
            LDA.w Pool_Mothula_SpawnBeams_x_speeds, X : STA.w $0D50, Y
            LDA.w Pool_Mothula_SpawnBeams_y_speeds, X : STA.w $0D40, Y
            
            LDA.b #$00 : STA.w $0F70, Y
            
            PLX
        
        .spawn_failed
    DEC.w $0FB5 : BPL .spawn_next_beam
    
    RTS
}

; ==============================================================================

; $0F402E-$0F4087 DATA
Pool_Mothula_ActivateMovingSpikeBlock:
{
    ; $0F402E
    .x_coords_low
    db $38, $48, $58, $68, $88, $98, $A8, $B8
    db $C8, $C8, $C8, $C8, $C8, $C8, $C8, $B8
    db $A8, $98, $78, $68, $58, $48, $38, $28
    db $28, $28, $28, $28, $28, $28
    
    ; $0F404C
    .y_coords_low
    db $38, $38, $38, $38, $38, $38, $38, $38
    db $48, $58, $68, $78, $98, $A8, $B8, $C8
    db $C8, $C8, $C8, $C8, $C8, $C8, $C8, $B8
    db $A8, $98, $78, $68, $58, $48
    
    ; $0F406A
    .directions
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $01, $01, $01, $01, $01, $01, $01, $03
    db $03, $03, $03, $03, $03, $03, $03, $00
    db $00, $00, $00, $00, $00, $00
}

; $0F4088-$0F4102 LOCAL JUMP LOCATION
Mothula_ActivateMovingSpikeBlock:
{
    DEC.w !spike_activation_timer, X : BNE .activation_delay
        ; Set the delay for 64 more frames.
        LDA.b #$40 : STA.w !spike_activation_timer, X
        
        LDA.b #$8A
        JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            PHX
            
            JSL.l GetRandomInt : AND.b #$1F : CMP #$1E : BCC .already_in_range
                SBC.b #$1E
            
            .already_in_range
            
            TAX
            
            LDA.w .x_coords_low, X : STA.w $0D10, Y
                                     STA.w $0D90, Y
            
            LDA.w .y_coords_low, X : DEC : STA.w $0D00, Y
                                           STA.w $0DA0, Y
            
            LDA.w .directions, X : STA.w $0DE0, Y
            
            ; NOTE: Differentiates it from a standard spike block as it will
            ; melt back into the scenery when it collides with tiles.
            LDA.b #$01 : STA.w $0E90, Y
            
                         CLC : ADC.w $0FB0 : STA.w $0D30, Y
            LDA.b #$01 : CLC : ADC.w $0FB1 : STA.w $0D20, Y
            
            TYX
            
            ; NOTE: The collision is being detected from the sprite's spawned
            ; position, which is potentially in the upper left of a bg based
            ; spike block. So it's checking for collision with a spike block
            ; "underneath" it, so to speak.
            LDA.b #$01 : STA.w $0D50, X
            
            JSL.l Sprite_Get_16_bit_CoordsLong
            JSR.w Sprite3_CheckTileCollision
            
            STZ.w $0D50, X
            
            LDA.w $0D90, X : STA.w $0D10, X
            
            LDA.w $0DA0, X : STA.w $0D00, X
            
            LDA.w $0E70, X : BNE .spawning_atop_spike_block
                ; Essentially this code is to prevent the transient spike block
                ; from materializing from thin air / from the floor, however you
                ; want to look at it.
                STZ.w $0DD0, X
                
                PLX
                
                LDA.b #$01 : STA.w !spike_activation_timer, X
                
            RTS
            
            .spawning_atop_spike_block
            
            PLX
        
        .spawn_failed
    .activation_delay
    
    RTS
}

; ==============================================================================
