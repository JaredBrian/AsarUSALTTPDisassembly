; ==============================================================================

; Variables / aliases specific to Blind.
    
; NOTE: Overrides typical usage.
; When set, prevents Blind from firing his laser for a while.
!laser_inhibit = $0B58
    
; How many extra heads have been spawned.
!extra_head_counter = $0B6A
    
; NOTE: Overrides typical usage.
; Timer that, When set, will count down and fire a laser when nearly expired.
!fire_laser = $0D80
    
; 0x00 - Blind
; 0x01 - BlindPoof
; 0x02 - BlindHead
; 0x80 - BlindLaser
!blind_subtype = $0D90
    
; If even, accelerate downward, and accelerate upward if odd.
!y_accel_polarity = $0DA0
    
!blind_ai_state = $0DB0
    
; NOTE: Overrides typical usage.
; 0x02 - Facing down
; 0x03 - Facing up
; Other values are invalid..
!blind_direction = $0DE0
    
; NOTE: Overrides conventional use of this variable.
!head_rotate_delay = $0E30
    
; For this sprite it acts as a 8-bit timer that ticks up every frame. When
; it overflows to zero it just keeps going without end. Some logic uses
; this as a mask to stagger certain behaviors between frames. There is also
; some code that bitwise ANDs this with 0x00 and then checks for a nonzero
; value, branching if so. This is considered to be debug code that never
; got taken out. Or rather, 0x00 was a symbolic constant that at one point
; might not have been 0x00.
!forward_timer = $0E80
    
; For Blind, this actually is a timer for how long it takes to rotate the
; head. Its value is reset from !head_rotate_delay.
!head_rotate_timer = $0E90
    
; Controls the angle that the head is looking towards. Goes in 16ths of
; a full circle. It's not documented yet what each value (0x00 to 0x0f)
; corresponds to in terms of conventional angles.
!head_angle = $0EB0
    
; If even, accelerate downward, and accelerate upward if odd.
!head_y_accel_polarity = $0EC0
    
; If even, accelerate rightward, and accelerate leftward if odd.
; BlindHead also uses this, but its y acceleration variable is a different
; address.
!x_accel_polarity      = $0ED0
!head_x_accel_polarity = $0ED0

; NOTE: Overrides typical usage.
; BlindHead uses this to delay fireballs that are actually aimed at the
; player.
!fireball_aim_delay = $0F90
    
; NOTE: Overrides typical usage.
; Counts how many times the current head has been hit. Once this reaches
; 3 it detaches and swirls around the room launching fireballs.
!hit_counter = $0F90
    
; ==============================================================================

; $0EA03C-$0EA080 LONG JUMP LOCATION
Blind_SpawnFromMaidenTagalong:
{
    LDX.b #$00
    
    LDA.b #$09 : STA.w $0DD0, X
    
    LDA #$CE : STA.w $0E20, X
    
    LDA.b $00 : STA.w $0D10, X
    LDA.b $01 : STA.w $0D30, X
    
    LDA.b $02 : SEC : SBC.b #$10 : STA.w $0D00, X
    LDA.b $03                    : STA.w $0D20, X
    
    JSL.l Sprite_LoadProperties
    
    LDA.b #$C0 : STA.w $0E10, X
    
    LDA.b #$15 : STA.w $0DC0, X
    
    LDA.b #$02 : STA.w !blind_direction, X
                 STA.w $0BA0, X
    
    LDA.w $0403 : ORA.b #$20 : STA.w $0403
    
    STZ.w $0B69
    
    RTL
}

; ==============================================================================

; $0EA081-$0EA0B0 LONG JUMP LOCATION
Blind_Initialize:
{
    LDA.l $7EF3CC : CMP.b #$06 : BEQ .self_terminate
        ; Check if the floor above this room has been bombed out.
        ; HARDCODED:
        LDA.w $0403 : AND.b #$20 : BEQ .self_terminate
            LDA.b #$60 : STA.w $0E10, X
            
            LDA.b #$01 : STA.w !blind_ai_state, X
            
            LDA.b #$02 : STA.w !blind_direction, X
            
            LDA.b #$04 : STA.w !head_angle, X
            
            LDA.b #$07 : STA.w $0DC0, X
            
            STZ.w $0B69
            
            RTL
    
    .self_terminate
    
    STZ.w $0DD0, X
    
    RTL
}

; ==============================================================================

; $0EA0B1-$0EA10F LOCAL JUMP LOCATION
BlindLaser_SpawnTrailGarnish:
{
    ; NOTE: Must have been some kind of development test code that never
    ; got edited out.
    LDA.w !forward_timer, X : AND.b #$00 : BNE .never
        PHX : TXY
        
        LDX.b #$1D
        
        .next_slot
        
            LDA.l $7FF800, X : BEQ .empty_slot
        DEX : BPL .next_slot
        
        DEC.w $0FF8 : BPL .no_garnish_slot_underflow
            LDA.b #$1D : STA.w $0FF8
        
        .no_garnish_slot_underflow
        
        LDX.w $0FF8
        
        .empty_slot
        
        ; TODO: Name this value with an enumeration when it becomes available.
        LDA.b #$0F : STA.l $7FF800, X
                     STA.w $0FB4
        
        LDA.w $0DC0, Y : STA.l $7FF9FE, X
        
        TYA : STA.l $7FF92C, X
        
        LDA.w $0D10, Y : STA.l $7FF83C, X
        LDA.w $0D30, Y : STA.l $7FF878, X
        
        LDA.w $0D00, Y : CLC : ADC.b #$10 : STA.l $7FF81E, X
        LDA.w $0D20, Y :       ADC.b #$00 : STA.l $7FF85A, X
        
        LDA.b #$0A : STA.l $7FF90E, X
        
        PLX
    
    .never
    
    RTS
}

; ==============================================================================

; $0EA110-$0EA117 DATA
Pool_Sprite_BlindHead:
{
    ; $0EA110
    .x_speed_limits
    db 32, -32
    
    ; $0EA112
    .x_pos_limits
    db $98, $58
    
    ; $0EA114
    .y_speeds_limits
    db 24, -24
    
    ; $0EA116
    .y_pos_limits
    db $B0, $50
}

; $0EA118-$0EA1EC LOCAL JUMP LOCATION
Sprite_BlindHead:
{
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    
    PHX
    
    LDY.b #$02
    
    LDA.w !head_angle, X : TAX
    LDA.w Pool_Blind_Draw_chr, X : STA.b ($90), Y
    
    INY
    LDA.b ($90), Y : AND.b #$3F : ORA.w Pool_Blind_Draw_vh_flip, X : STA.b ($90), Y
    
    PLX
    
    JSR.w Sprite4_CheckIfActive
    
    LDA.w $0EA0, X : CMP.b #$0E : BNE .anospeed_up_recoil
        ; Slightly speed up the recoil process? Seems hacky. HARDCODED
        LDA.b #$08 : STA.w $0EA0, X
    
    .anospeed_up_recoil
    
    JSR.w Sprite4_CheckIfRecoiling
    
    DEC.w !head_rotate_delay, X : BPL .anorotate
        LDA.b #$02 : STA.w !head_rotate_delay, X
        
        LDA.w !head_angle, X : INC : AND.b #$0F : STA.w !head_angle, X
    
    .anorotate
    
    ; When the free moving head is spawned, it is immovable at first and
    ; apparently can't cause damage either.
    LDA.w $0DF0, X : BEQ .fully_active
        JMP .return
    
    .fully_active
    
    JSR.w Sprite4_CheckDamage
    
    INC.w !forward_timer, X
    
    ; Spawn semi frequently (every 0x20 frames).
    LDA.b #$1F
    JSR.w Blind_SpawnFireball
    TYA : BMI .spawn_failed
        ; This means that every fifth fireball is directly aimed at the player.
        DEC.w !fireball_aim_delay, X : BPL .not_aimed_at_player
            LDA.b #$04 : STA.w !fireball_aim_delay, X
            
            PHY
            
            LDA.b #$20
            
            JSL.l Sprite_ProjectSpeedTowardsPlayerLong
            
            PLY
            
            LDA.b $00 : STA.w $0D40, Y
            LDA.b $01 : STA.w $0D50, Y
        
        .not_aimed_at_player
    .spawn_failed
    
    ; NOTE: Must be some debug setting that never got edited out.
    LDA.w !forward_timer, X : AND.b #$00 : BNE .never
        LDA.w !head_x_accel_polarity, X : AND.b #$01 : TAY
        LDA.w $0D50, X : CMP.w Pool_Sprite_BlindHead_x_speed_limits, Y : BEQ .anoalter_x_speed
            CLC : ADC.w Pool_Sprite_ApplyConveyorAdjustment_x_shake_values, Y : STA.w $0D50, X
        
        .anoalter_x_speed
    .never
    
    LDA.w $0D10, X : AND.b #$FE
    
    ; HARDCODED: Using specific screen offsets seems kind of like cheating.
    CMP.w Pool_Sprite_BlindHead_x_pos_limits, Y : BNE .anoinvert_x_acceleration
        INC.w !head_x_accel_polarity, X
    
    .anoinvert_x_acceleration
    
    LDA.w !forward_timer, X : AND.b #$00 : BNE .never_2
        LDA.w !head_y_accel_polarity, X : AND.b #$01 : TAY
        LDA.w $0D40, X : CMP.w Pool_Sprite_BlindHead_y_speeds_limits, Y : BEQ .anoalter_y_speed
            CLC : ADC.w Pool_Sprite_ApplyConveyorAdjustment_x_shake_values, Y : STA.w $0D40, X
        
        .anoalter_y_speed
    .never_2

    ; HARDCODED: Same as above comment.
    LDA.w $0D00, X : AND.b #$FE : CMP.w Pool_Sprite_BlindHead_y_pos_limits, Y : BNE .anoinvert_y_accleration
        INC.w !head_y_accel_polarity, X
    
    .anoinvert_y_accleration
    
    LDA.w $0EA0, X : BNE .dont_move
        JSR.w Sprite4_Move
    
    .dont_move
    .return
    
    RTS
}

; ==============================================================================

; $0EA1ED-$0EA23B LOCAL JUMP LOCATION
Blind_SpawnExtraHead:
{
    ; Create a Blind Head sprite.
    LDA.b #$CE : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b #$5B : STA.w $0E60, Y
        
        AND.b #$0F : STA.w $0F50, Y
        
        LDA.b #$04 : STA.w $0CAA, Y
        
        LDA.b #$02 : STA.w !blind_subtype, Y
        
        LDA.b #$01 : STA.w $0E40, Y
        DEC        : STA.w $0F60, Y
                     STA.w $0B6B, Y
        
        LDA.b #$17      : STA.w $0F70, Y
        CLC : ADC.b $02 : STA.w $0D00, Y
        
        LDA.b $00 : ASL : ROL : AND.b #$01 : STA.w !head_x_accel_polarity, Y
        LDA.b $02 : ASL : ROL : AND.b #$01 : STA.w !head_y_accel_polarity, Y
        
        LDA.b #$30 : STA.w $0DF0, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0EA23C-$0EA25B DATA
Pool_Sprite_BlindLaser:
{
    ; $0EA23C
    .animation_states
    db  7,  7,  8,  9, 10,  9,  8,  7
    db  7,  7,  8,  9, 10,  9,  8,  7
    
    ; $0EA24C
    .vh_flip
    db $00, $00, $00, $00, $00, $40, $40, $40
    db $40, $40, $C0, $C0, $80, $80, $80, $80
}
    
; ==============================================================================

; $0EA25C-$0EA262 DATA
Sprite_Blind_animation_states:
{
    db 20, 19, 18, 17, 16, 15, 15
}

; ==============================================================================

; $0EA263-$0EA2CA JUMP LOCATION
Sprite_BlindEntities:
{
    LDA.w !blind_subtype, X : BPL Sprite_Blind
        ; Sprite_BlindLaser

        LDY.w !head_angle, X
        
        LDA.w Pool_Sprite_BlindLaser_animation_states, Y : STA.w $0DC0, X
        
        LDA.w Pool_Sprite_BlindLaser_vh_flip, Y : ORA.b #$03 : STA.w $0F50, X
        
        JSL.l Sprite_PrepOamCoordLong
        JSR.w Sprite4_CheckIfActive
        
        LDA.w $0DF0, X : BEQ .termination_timer_not_set
            CMP.b #$01 : BNE .anoself_terminate
                STZ.w $0DD0, X
            
            .anoself_terminate
            
            RTS
            
        .termination_timer_not_set
        
        JSL.l Sprite_CheckDamageToPlayerSameLayerLong
        
        LDY.b #$00
        
        ; NOTE: This usage of a speed deviates from most sprites in that it is
        ; expressed in pixels rather than 16ths of a pixel.
        LDA.w $0D50, X : BPL .sign_extend_x_speed
            DEY
        
        .sign_extend_x_speed
        
        ; Effectively this is Sprite_MoveHoriz but not in 16ths of a pixel.
        CLC : ADC.w $0D10, X : STA.w $0D10, X
        TYA : ADC.w $0D30, X : STA.w $0D30, X
        
        LDY.b #$00
        
        LDA.w $0D40, X : BPL .sign_extend_y_speed
            DEY
        
        .sign_extend_y_speed
        
        ; Same goes for the y speed (Sprite_MoveVert).
        CLC : ADC.w $0D00, X : STA.w $0D00, X
        TYA : ADC.w $0D20, X : STA.w $0D20, X
        
        JSR.w Sprite4_CheckTileCollision : BEQ .no_tile_collision
            LDA.b #$0C : STA.w $0DF0, X
        
        .no_tile_collision
        
        JSR.w BlindLaser_SpawnTrailGarnish
        
        RTS
}

; ==============================================================================

; $0EA2CB-$0EA3D3 BRANCH LOCATION
Sprite_Blind:
{
    CMP.b #$02 : BNE .not_independent_head
        JMP Sprite_BlindHead
    
    .not_independent_head
    
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSR.w Blind_Draw
    
    LDA.b #$01 : STA.w $0F50, X
    
    JSR.w Sprite4_CheckIfActive
    
    ; NOTE: Blind wasn't designed so that his HP depletes normally.
    LDA.w $0EA0, X : BEQ .not_counterattacking
        DEC.w $0EA0, X
        
        CMP.b #$0B : BNE .skip_damage_logic
            STZ.w $0EF0, X
            STZ.w $0E70, X
            
            LDA.w !timer_4, X : BNE .skip_damage_logic
                LDA.b #$80 : STA.w $0E50, X
                LDA.b #$30 : STA.w !timer_4, X
                
                LDA.w $0F50, X : AND.b #$01 : STA.w $0F50, X
                
                INC.w !hit_counter, X
                LDA.w !hit_counter, X : CMP.b #$03 : BCS .hit_counter_maxed
                    LDA.b #$60 : STA.w $0E70, X
                    
                    LDA.b #$01 : STA.w !head_rotate_delay, X
                    
                    BRA .skip_damage_logic
                
                .hit_counter_maxed
                
                STZ.w !hit_counter, X
                
                INC.w !extra_head_counter
                LDA.w !extra_head_counter : CMP.b #$03 : BNE .spawn_extra_head
                    ; NOTE: Time for Blind and all his pals on screen to die.
                    
                    JSL.l Sprite_SchedulePeersForDeath
                    
                    ; Schedules Blind for death. Pretty sure.
                    JSR.w Sprite_ScheduleBossForDeath
                    
                    LDA.b #$FF : STA.w $0DF0, X
                                 STA.w $0EF0, X
                    
                    INC.w $0FFC
                    
                    LDA.b #$22
                    JSL.l Sound_SetSfx3PanLong
                    
                    RTS
                
                .spawn_extra_head
                
                JSR.w Sprite4_Zero_XY_Velocity
                
                LDA.b #$06 : STA.w !blind_ai_state, X
                
                LDA.b #$FF : STA.w $0E10, X
                             STA.w $0BA0, X
                
                JSR.w Blind_SpawnExtraHead
        
        .skip_damage_logic
    .not_counterattacking
    
    LDA.w !blind_subtype, X : BEQ .not_poof
        LDA.w $0DF0, X : BNE .delay_self_termination
            STZ.w $0DD0, X
        
        .delay_self_termination
        
        LSR #3 : TAY
        LDA.w .animation_states, Y : STA.w $0DC0, X
        
        RTS
    
    .not_poof
    
    ; OPTIMIZE: Slightly faster if we just load, xor with 0x01,
    ; store back, and then check flag. Same size in code.
    INC.w !forward_timer, X
    
    ; NOTE: This extends timer 0 by about 50%. Since it's an 8-bit countdown
    ; timer, this means that it takes a maximum of 0x180 frames to expire
    ; for this sprite. This is not at all typical.
    LDA.w !forward_timer, X : AND.b #$01 : BNE .anopad_timer
        INC.w $0DF0, X
    
    .anopad_timer
    
    LDA.w $0DF0, X : BEQ .skip_damage_to_player_logic
        STZ.w !fire_laser, X
        
        CMP.b #$08 : BNE .anospawn_laser
            JSR.w Blind_SpawnLaser
        
        .anospawn_laser
        
        JMP Blind_CheckBumpDamage
    
    .skip_damage_to_player_logic
    
    ; NOTE: Every time the laser can fire, this increments.
    INC.w $0B69
    
    LDA.w !laser_inhibit, X : BNE .cant_fire
        ; NOTE: The probe sprite that Blind send out brings this flag high,
        ; but Blind has such lousy eyesight that it makes little difference.
        ; *Only* the Probe sprite can do this, by the way.
        LDA.w !fire_laser, X : BEQ .dont_fire
            ; Start a countdown during which Blind will fire a laser from its
            ; eyes.
            LDA.b #$10 : STA.w $0DF0, X
            
            LDA.b #$80 : STA.w !laser_inhibit, X
            
            BRA .unlatch_fire_laser_flag
    
    .cant_fire
    
    DEC.w !laser_inhibit, X
    
    .unlatch_fire_laser_flag
    
    STZ.w !fire_laser, X
    
    .dont_fire
    
    LDA.b $23 : STA.w $0D30, X
    LDA.b $21 : STA.w $0D20, X
    
    LDA.w !blind_ai_state, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Blind_BlindedByTheLight  ; 0x00 - $A4C6
    dw Blind_RetreatToBackWall  ; 0x01 - $A53A
    dw Blind_OscillateAlongWall ; 0x02 - $A56D
    dw Blind_SwitchWalls        ; 0x03 - $A608
    dw Blind_WhirlAround        ; 0x04 - $A667
    dw Blind_FireballReprisal   ; 0x05 - $A465
    dw Blind_BehindTheCurtain   ; 0x06 - $A3D8
    dw Blind_Rerobe             ; 0x07 - $A410
}

; ==============================================================================

; $0EA3D4-$0EA3D7 DATA
Blind_BehindTheCurtain_animation_states:
{
    db 14, 13, 12, 10
}

; $0EA3D8-$0EA40A JUMP LOCATION
Blind_BehindTheCurtain:
{
    ; Prevent death from occurring since Blind can still spawn another head.
    STZ.w $0EF0, X
    
    LDA.b #$0C : STA.w !head_angle, X
    
    LDA.w $0E10, X : BNE .delay_ai_state_transition
        INC.w !blind_ai_state, X
        
        LDA.b #$27 : STA.w $0E10, X
        
        LDA.b #$13
        JSL.l Sound_SetSfx1PanLong
        
        RTS
    
    .delay_ai_state_transition
    
    CMP.b #$E0 : BCC .delay_desheeting
        SBC.b #$E0 : LSR #3 : TAY
        LDA.w .animation_states, Y : STA.w $0DC0, X
        
        RTS
    
    .delay_desheeting
    
    LDA.b #$0E : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0EA40B-$0EA40F DATA
Blind_Rerobe_animation_states:
{
    db 10, 11, 12, 13, 14
}

; $0EA410-$0EA444 JUMP LOCATION
Blind_Rerobe:
{
    LDA.w $0E10, X : BNE .delay_ai_state_transition
        LDA.b #$02 : STA.w !blind_ai_state, X
        
        LDA.b #$80 : STA.w $0DF0, X
        
        ; HARDCODED: It depends upon Blind being in a 1 screen room in a corner.
        ; Set direction based on current Y position (sensible).
        LDA.w $0D00, X : ASL
        ROL : AND.b #$01 : INC : INC : STA.w !blind_direction, X
        
        ; HARDCODED: Also.
        ; Set head orientation based on current X position?
        LDA.w $0D10, X : ASL : ROL : STA.w !x_accel_polarity, X
        
        JSR.w Sprite4_Zero_XY_Velocity
        
        STZ.w $0BA0, X
        
        RTS
        
    .delay_ai_state_transition
    
    LSR #3 : TAY
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0EA445-$0EA464 DATA
Pool_Blind_SpawnFireball:
{
    ; $0EA445
    .x_speeds
    db -32, -28, -25, -16,   0,  16,  24,  28
    db  32,  28,  24,  16,   0, -16, -24, -28
    
    ; $0EA455
    .y_speeds
    db   0,  16,  24,  28,  32,  28,  24,  16
    db   0, -16, -24, -28, -32, -28, -24, -16
}

; $0EA465-$0EA49C JUMP LOCATION
Blind_FireballReprisal:
{
    DEC.w $0E70, X
    
    PHA
    
    AND.b #$07 : SEC : ROL : STA.w $0F50, X
    
    PLA : BNE .zero_length_branch
        ; OPTIMIZE: Zero length branch.

    .zero_length_branch
    
    DEC.w !head_rotate_timer, X : BPL .anorotate_head
        LDA.w !head_rotate_delay, X : STA.w !head_rotate_timer, X
        
        LDA.w !head_angle, X : INC : AND.b #$0F : STA.w !head_angle, X
    
    .anorotate_head
    
    LDA.w !forward_timer, X : AND.b #$1F : BNE .anoadjust_rotation_delay
        LDA.w !head_rotate_delay, X : CMP.b #$05 : BEQ .anoadjust_rotation_delay
            INC.w !head_rotate_delay, X
    
    .anoadjust_rotation_delay
    
    JSR.w Blind_AnimateBody
    
    ; Spawn very frequently (every 0x10 frames).
    LDA.b #$0F

    ; Bleeds into the next function.
}

; $0EA49D-$0EA4C5 JUMP LOCATION
Blind_SpawnFireball:
{
    LDY.b #$FF
    
    AND.w !forward_timer, X : BNE .delay_fireball_spawning
        JSL.l Sprite_SpawnFireball : BMI .spawn_failed
            LDA.b #$19
            JSL.l Sound_SetSfx3PanLong
            
            PHX
            
            LDA.w !head_angle, X : TAX
            LDA.w Pool_Blind_FireballReprisal_x_speeds, X : STA.w $0D50, Y
            LDA.w Pool_Blind_FireballReprisal_y_speeds, X : STA.w $0D40, Y
            
            JSR.w Medusa_ConfigFireballProperties
            
            PLX
        
        .spawn_failed
    .delay_fireball_spawning
    
    RTS
}

; ==============================================================================

; $0EA4C6-$0EA4F8 JUMP LOCATION
Blind_BlindedByTheLight:
{   
    LDA.b #$00 : STA.w $0AE8
    LDA.b #$A0 : STA.w $0AEA
    
    LDA.w $0E10, X : BNE .anoadvance_ai_state
        INC.w !blind_ai_state, X
        
        LDA.b #$60 : STA.w $0E10, X
    
    .anoadvance_ai_state
    
    CMP.b #$50 : BNE .anocomplain
        PHA
        
        ; "Gyaaa! Too bright!"
        LDA.b #$23 : STA.w $1CF0
        LDA.b #$01 : STA.w $1CF1
        
        JSL.l Sprite_ShowMessageMinimal
        
        PLA
    
    .anocomplain
    
    CMP.b #$18 : BNE .anopoof
        JSR.w Blind_SpawnPoof
    
    .anopoof
    
    RTS
}

; ==============================================================================

; $0EA4F9-$0EA539 LOCAL JUMP LOCATION
Blind_SpawnPoof:
{
    LDA.b #$0C : STA.w $012E
    
    LDA.b #$CE
    JSL.l Sprite_SpawnDynamically
    
    LDA.b $00 : CLC : ADC.b #$10 : STA.w $0D10, Y
    LDA.b $01 :       ADC.b #$00 : STA.w $0D30, Y
    
    LDA.b $02 : CLC : ADC.b #$28 : STA.w $0D00, Y
    LDA.b $03 :       ADC.b #$00 : STA.w $0D20, Y
    
    LDA.b #$0F : STA.w $0DC0, Y
    
    LDA.b #$01 : STA.w !blind_subtype, Y
    
    LDA.b #$2F : STA.w $0DF0, Y
    
    LDA.b #$09 : STA.w $0E40, Y
                 STA.w $0BA0, Y
    
    RTS
}

; ==============================================================================

; $0EA53A-$0EA566 JUMP LOCATION
Blind_RetreatToBackWall:
{
    JSR.w Blind_CheckBumpDamage
    
    LDA.b #$09 : STA.w $0DC0, X
    
    LDA.w $0E10, X : BNE .anoadvance_ai_state
        INC.w !blind_ai_state, X
        
        LDA.b #$FF : STA.w $0DF0, X
        
        STZ.w $0BA0, X
    
    .anoadvance_ai_state
    
    CMP.b #$40 : BCS .delay_upward_migration
        LDA.b #-8 : STA.w $0D40, X
        
        JSR.w Sprite4_MoveVert
    
    .delay_upward_migration
    
    JSR.w Blind_Animate
    
    LDA.b #$04 : STA.w !head_angle, X
    
    RTS
}

; ==============================================================================

; $0EA567-$0EA56C DATA
Pool_Blind_OscillateAlongWall:
{
    ; $0EA567
    .y_speed_limits
    db 18, -18
    
    ; $0EA569
    .x_speed_limits
    db 24, -24
    
    ; $0EA56B
    .x_coord_limits
    db $A4, $76
}

; $0EA56D-$0EA601 JUMP LOCATION
Blind_OscillateAlongWall:
{
    JSR.w Blind_CheckBumpDamage
    JSR.w Blind_Animate
    
    LDA.w !forward_timer, X : AND.b #$7F : BNE .ignore_player_position
        JSR.w Sprite4_IsBelowPlayer
        
        ; Results in Y being 2 or 3 (3 if sprite is below player).
        INY : INY
        
        TYA : CMP.w !blind_direction, X : BNE .player_got_behind_us
    
    .ignore_player_position
    
    LDA.w $0DF0, X : BNE .delay_ai_state_transition
        .player_got_behind_us
        
        LDA.w $0D10, X : CMP.b #$78 : BCS .delay_ai_state_transition
            INC.w !blind_ai_state, X
            
            ; WTF: Why... do this exactly?
            LDA.w $0D40, X : AND.b #$FE : STA.w $0D40, X
            
            LDA.w $0D50, X : AND.b #$FE : STA.w $0D50, X
            
            LDA.b #$30 : STA.w $0E10, X
            
            RTS
    
    .delay_ai_state_transition
    
    LDA.w !y_accel_polarity, X : AND.b #$01 : TAY
    LDA.w $0D40, X : CLC : ADC.w Pool_Sprite_ApplyConveyorAdjustment_x_shake_values, Y : STA.w $0D40, X
    CMP.w Pool_Blind_OscillateAlongWall_y_speed_limits, Y : BNE .anoinvert_y_acceleration
        INC.w !y_accel_polarity, X
    
    .anoinvert_y_acceleration
    
    LDA.w !x_accel_polarity, X : AND.b #$01 : TAY
    LDA.w $0D50, X : CMP .x_speed_limits, Y : BEQ .x_speed_maxed
        CLC : ADC.w Pool_Sprite_ApplyConveyorAdjustment_x_shake_values, Y : STA.w $0D50, X
    
    .x_speed_maxed
    
    ; Again... why snap to a grid?
    LDA.w $0D10, X : AND.b #$FE : CMP.w .x_coord_limits, Y : BNE .anoinvert_x_acceleration
        INC.w !x_accel_polarity, X
    
    .anoinvert_x_acceleration
    
    JSR.w Sprite4_Move
    
    LDA.w $0E70, X : BEQ .no_tile_bump
        JMP Blind_FireballReprisal
    
    .no_tile_bump
    
    ; OPTIMIZE: Learn the BIT instruction.
    LDA.w !forward_timer, X : AND.b #$07 : BNE .anospawn_probe
        LDA.w !head_angle, X : ASL : ASL : STA.b $0F
        
        JSL.l Sprite_SpawnProbeAlwaysLong
    
    .anospawn_probe
    
    RTS
}

; ==============================================================================

; $0EA602-$0EA607 DATA
Pool_Blind_SwitchWalls:
{
    ; $0EA602
    .y_accellerations
    db 2, -2
    
    ; $0EA604
    .y_speed_limits
    db 64, -64
    
    ; $0EA606
    .y_pos_limits
    db $90, $50
}

; This state has Blind migrate to the opposite wall from where he's currently at.
; $0EA608-$0EA646 JUMP LOCATION
Blind_SwitchWalls:
{
    JSR.w Blind_CheckBumpDamage
    
    LDA.w $0E10, X : BEQ .stop_decelerating
        JSR.w Blind_Decelerate_X
        JSR.w Sprite4_MoveHoriz
        JMP Blind_Decelerate_Y
    
    .stop_decelerating
    
    LDA.w !blind_direction, X : DEC : DEC : TAY
    LDA.w $0D40, X : CMP.w .y_speed_limits, Y : BEQ .y_speed_maxed
        CLC : ADC.w .y_accelerations, Y : STA.w $0D40, X
    
    .y_speed_maxed
    
    LDA.w $0D00, X : AND.b #$FC : CMP.w .y_pos_limits, Y : BNE .delay_whirl_around
        INC.w !blind_ai_state, X
        
        LDA.w !blind_direction, X : SEC : SBC.b #$01 : STA.w !y_accel_polarity, X
    
    .delay_whirl_around
    
    JSR.w Sprite4_Move

    ; BLeeds into the next function.
}

; $0EA647-$0EA662 JUMP LOCATION
Blind_Decelerate_X:
{
    LDA.w $0D50, X : BEQ .fully_decelerated_x
        BPL .positive_speed_x
            CLC : ADC.b #$04
    
        .positive_speed_x
    
        SEC : SBC.b #$02 : STA.w $0D50, X
    
    .fully_decelerated_x
    
    JSR.w Blind_AnimateBody
    
    LDA.w $0E70, X : BEQ .inactive
        JMP Blind_FireballReprisal
    
    .inactive
    
    RTS
}

; ==============================================================================

; $0EA663-$0EA666 DATA
Pool_Blind_WhirlAround:
{
    ; $0EA663
    .animation_step_directions
    db -1, 1
    
    ; $0EA665
    .animation_limits
    db  0, 9
}

; $0EA667-$0EA6A3 JUMP LOCATION
Blind_WhirlAround:
{
    JSR.w Blind_CheckBumpDamage
    
    LDA.w !forward_timer, X : AND.b #$07 : BNE .delay_animation_adjustment
        LDA.w !blind_direction, X : DEC : DEC : TAY
        LDA.w $0DC0, X : CMP .animation_limits, Y : BNE .not_yet_in_position
            LDA.b #$FE : STA.w $0DF0, X
            
            LDA.b #$02 : STA.w !blind_ai_state, X
            
            LDA.w !blind_direction, X : EOR.b #$01 : STA.w !blind_direction, X
            
            LDA.w $0D10, X : ASL : ROL : AND.b #$01 : STA.w !x_accel_polarity, X
            
            BRA .animation_logic_done
        
        .not_yet_in_position
        
        CLC : ADC .animation_step_directions, Y : STA.w $0DC0, X
        
        .animation_logic_done
    .delay_animation_adjustment

    ; Bleeds into the next function.
}

; $0EA6A4-$0EA6BF JUMP LOCATION
Blind_Decelerate_Y:
{
    LDA.w $0D40, X : BEQ .fully_decelerated_y
        BPL .positive_y_speed
            CLC : ADC.b #$08
        
        .positive_y_speed
        
        SEC : SBC.b #$04 : STA.w $0D40, X
        
    .fully_decelerated_y
    
    JSR.w Sprite4_MoveVert
    
    LDA.w $0E70, X : BEQ .inactive
        JMP Blind_FireballReprisal
    
    .inactive
    
    RTS
}

; ==============================================================================

; $0EA6C0-$0EA6CE LOCAL JUMP LOCATION
Blind_CheckBumpDamage:
{
    LDA.w !timer_4, X : ORA.w $0EA0, X : BNE .temporarily_intouchable
        JSR.w Sprite4_CheckDamage
    
    .temporarily_intouchable
    
    JSR.w Blind_BumpDamageFromBody
    
    RTS
}

; ==============================================================================

; $0EA6CF-$0EA6EE DATA
Pool_Blind_Animate:
{
    ; $0EA6CF
    .robe
    db 7, 8, 9, 8, 0, 1, 2, 1
    
    ; $0EA6D7
    .head_dir
    db 0,  1,  2,  3,  4,  3,  2,  1
    db 0, 15, 14, 13, 12, 13, 14, 15
    
    ; $0EA6E7
    .step
    db 0, 1, 1, 2, 2, 3, 3, 4
}

; $0EA6EF-$0EA728 LOCAL JUMP LOCATION
Blind_Animate:
{
    ; This routine seems to roughly try to track where the player is, but Blind
    ; has bad eyesight so he still kind of haphazardly looks for the player.
    LDA.w $0E70, X : BNE .counterattacking
        ; This logic animates the head loosely based on the player's
        ; X coordinate.
        LDA.b $22 : LSR #5 : TAY
        LDA.w Pool_Blind_Animate_step, Y
        
        LDY.w !blind_direction, X : CPY.b #$03 : BNE .facing_down
            EOR.b #$FF : INC
        
        .facing_down
        
        STA.b $01
        
        ; Results in either 0 or 8.
        TYA : DEC : DEC : ASL #3 : STA.b $00
        
        ; Pad in this .... value that comes from somewhere? A probe?
        LDA.w $0B69 : LSR #3 : AND.b #$07 : ADC.b $00 : TAY
        
        ; Now offset it by another small amount we calculated earlier and...
        ; fire the laser?
        LDA.w Pool_Blind_Animate_head_dir, Y
        CLC : ADC.b $01 : AND.b #$0F : STA.w !head_angle, X
    
    .counterattacking

    ; Bleeds into the next function.
}

; $0EA729-$0EA744 LOCAL JUMP LOCATION
Blind_AnimateBody:
{
    LDA.w !blind_direction, X : DEC : DEC : ASL #4 : STA.b $00
    
    LDA.w !forward_timer, X : LSR #3 : AND.b #$03 : CLC : ADC.b $00 : TAY
    LDA.w Pool_Blind_Animate_robe, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0EA745-$0EA764 DATA
Pool_Blind_SpawnLaser:
{
    ; $0EA745
    .x_speeds
    db -8, -8, -8, -4,  0,  4,  8,  8
    db  8,  8,  8,  4,  0, -4, -8, -8
    
    ; $0EA755
    .y_speeds
    db  0,  0,  4,  8,  8,  8,  4,  0
    db  0,  0, -4, -8, -8, -8, -4,  0    
}

; $0EA765-$0EA7A9 LOCAL JUMP LOCATION
Blind_SpawnLaser:
{
    LDA.b #$CE : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sound_SetSfxPan : ORA.b #$26 : STA.w $012F
        
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
        
        LDA.w !head_angle, X : STA.w !head_angle, Y
        
        PHX
        
        TAX
        LDA.w Pool_Blind_SpawnLaser_x_speeds, X : STA.w $0D50, Y
        LDA.w Pool_Blind_SpawnLaser_y_speeds, X : STA.w $0D40, Y
        
        PLX
        
        LDA.b #$80 : STA.w !blind_subtype, Y
                     STA.w $0BA0, Y
        
        LDA.b #$40 : STA.w $0E40, Y
        
        LDA.b #$14 : STA.w $0F60, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0EA7AA-$0EAAF1 DATA
Blind_Draw_OAM_groups:
{
    dw  -8,   7 : db $8E, $0C, $00, $02
    dw   8,   7 : db $8E, $4C, $00, $02
    dw  -8,  23 : db $A0, $0C, $00, $02
    dw   8,  23 : db $A4, $4C, $00, $02
    dw   0,   0 : db $8C, $0A, $00, $02
    dw -19,   3 : db $A6, $0A, $00, $02
    dw  19,   3 : db $A6, $4A, $00, $02

    dw  -8,   7 : db $8E, $0C, $00, $02
    dw   8,   7 : db $8E, $4C, $00, $02
    dw  -8,  23 : db $A2, $0C, $00, $02
    dw   8,  23 : db $A0, $4C, $00, $02
    dw   0,   0 : db $8C, $0A, $00, $02
    dw -19,   3 : db $A8, $0A, $00, $02
    dw  19,   3 : db $A8, $4A, $00, $02

    dw  -8,   7 : db $8E, $0C, $00, $02
    dw   8,   7 : db $8E, $4C, $00, $02
    dw  -8,  23 : db $A4, $0C, $00, $02
    dw   8,  23 : db $A2, $4C, $00, $02
    dw   0,   0 : db $8C, $0A, $00, $02
    dw -19,   3 : db $AA, $0A, $00, $02
    dw  19,   3 : db $AA, $4A, $00, $02

    dw -15,   5 : db $A6, $0A, $00, $02
    dw  -6,   7 : db $8E, $0C, $00, $02
    dw   6,   7 : db $8E, $4C, $00, $02
    dw  -6,  23 : db $A4, $0C, $00, $02
    dw   6,  23 : db $A0, $4C, $00, $02
    dw   0,   0 : db $8A, $0A, $00, $02
    dw  16,  -1 : db $A6, $4A, $00, $02

    dw -11,   9 : db $A6, $0A, $00, $02
    dw  -4,   7 : db $8E, $0C, $00, $02
    dw   5,   7 : db $8E, $4C, $00, $02
    dw  -4,  23 : db $A4, $0C, $00, $02
    dw   5,  23 : db $A0, $4C, $00, $02
    dw   0,   0 : db $88, $0A, $00, $02
    dw  10,  -2 : db $A6, $4A, $00, $02

    dw   0,   0 : db $84, $0A, $00, $02
    dw  13,   8 : db $A6, $4A, $00, $02
    dw -10,  -2 : db $A6, $0A, $00, $02
    dw  -5,   7 : db $8E, $0C, $00, $02
    dw   5,   7 : db $8E, $4C, $00, $02
    dw  -5,  23 : db $A0, $0C, $00, $02
    dw   5,  23 : db $A4, $4C, $00, $02

    dw   0,   0 : db $82, $0A, $00, $02
    dw  18,   4 : db $A6, $4A, $00, $02
    dw -15,  -1 : db $A6, $0A, $00, $02
    dw  -6,   7 : db $8E, $0C, $00, $02
    dw   6,   7 : db $8E, $4C, $00, $02
    dw  -6,  23 : db $A0, $0C, $00, $02
    dw   6,  23 : db $A4, $4C, $00, $02

    dw   0,   0 : db $80, $0A, $00, $02
    dw -19,   3 : db $A6, $0A, $00, $02
    dw  19,   3 : db $A6, $4A, $00, $02
    dw  -8,   7 : db $8E, $0C, $00, $02
    dw   8,   7 : db $8E, $4C, $00, $02
    dw  -8,  23 : db $A0, $0C, $00, $02
    dw   8,  23 : db $A4, $4C, $00, $02

    dw   0,   0 : db $80, $0A, $00, $02
    dw -19,   3 : db $A8, $0A, $00, $02
    dw  19,   3 : db $A8, $4A, $00, $02
    dw  -8,   7 : db $8E, $0C, $00, $02
    dw   8,   7 : db $8E, $4C, $00, $02
    dw  -8,  23 : db $A2, $0C, $00, $02
    dw   8,  23 : db $A0, $4C, $00, $02

    dw   0,   0 : db $80, $0A, $00, $02
    dw -19,   3 : db $AA, $0A, $00, $02
    dw  19,   3 : db $AA, $4A, $00, $02
    dw  -8,   7 : db $8E, $0C, $00, $02
    dw   8,   7 : db $8E, $4C, $00, $02
    dw  -8,  23 : db $A0, $0C, $00, $02
    dw   8,  23 : db $A4, $4C, $00, $02

    dw  -8,   9 : db $8E, $0C, $00, $02
    dw   8,   9 : db $8E, $4C, $00, $02
    dw  -8,  23 : db $AE, $0C, $00, $02
    dw   8,  23 : db $AE, $4C, $00, $02
    dw   8,  23 : db $AE, $4C, $00, $02
    dw   8,  23 : db $AE, $4C, $00, $02
    dw   0,   2 : db $8C, $0A, $00, $02

    dw  -8,  16 : db $8E, $0C, $00, $02
    dw   8,  16 : db $8E, $4C, $00, $02
    dw  -8,  23 : db $AE, $0C, $00, $02
    dw   8,  23 : db $AE, $4C, $00, $02
    dw   8,  23 : db $AE, $4C, $00, $02
    dw   8,  23 : db $AE, $4C, $00, $02
    dw   0,   9 : db $8C, $0A, $00, $02

    dw  -8,  23 : db $AE, $0C, $00, $02
    dw   8,  23 : db $AE, $4C, $00, $02
    dw   8,  23 : db $AE, $4C, $00, $02
    dw   8,  23 : db $AE, $4C, $00, $02
    dw   8,  23 : db $AE, $4C, $00, $02
    dw   8,  23 : db $AE, $4C, $00, $02
    dw   0,  16 : db $8C, $0A, $00, $02

    dw  -8,  23 : db $AC, $0C, $00, $02
    dw   8,  23 : db $AC, $4C, $00, $02
    dw   8,  23 : db $AC, $4C, $00, $02
    dw   8,  23 : db $AC, $4C, $00, $02
    dw   8,  23 : db $AC, $4C, $00, $02
    dw   8,  23 : db $AC, $4C, $00, $02
    dw   0,  20 : db $8C, $0A, $00, $02

    dw  -8,  23 : db $AC, $0C, $00, $02
    dw   8,  23 : db $AC, $4C, $00, $02
    dw   8,  23 : db $AC, $4C, $00, $02
    dw   8,  23 : db $AC, $4C, $00, $02
    dw   8,  23 : db $AC, $4C, $00, $02
    dw   8,  23 : db $AC, $4C, $00, $02
    dw   0,  23 : db $8C, $0A, $00, $02
}

; $0EAAF2-$0EAC2E DATA
BlindPoof_Draw:
{
    ; $0EAAF2
    .OAM_groups
    .group00
    dw -16, -20 : db $86, $05, $00, $02

    ; $0EAAFA
    .group01
    dw -11, -28 : db $86, $05, $00, $02
    dw -23, -26 : db $86, $05, $00, $02
    dw  -8, -17 : db $86, $05, $00, $02
    dw -20, -13 : db $86, $05, $00, $02

    ; $0EAB1A
    .group02
    dw -16, -37 : db $86, $05, $00, $02
    dw -27, -31 : db $86, $05, $00, $02
    dw -10, -28 : db $86, $05, $00, $02
    dw  -5, -28 : db $86, $05, $00, $02
    dw -20, -27 : db $86, $05, $00, $02
    dw -27, -17 : db $86, $05, $00, $02
    dw  -4, -17 : db $86, $05, $00, $02
    dw -16, -13 : db $86, $05, $00, $02

    ; $0EAB5A
    .group03
    dw -18, -37 : db $8A, $45, $00, $02
    dw  -5, -33 : db $8A, $45, $00, $02
    dw -32, -32 : db $8A, $05, $00, $02
    dw -23, -31 : db $8A, $45, $00, $02
    dw -15, -24 : db $8A, $45, $00, $02
    dw -23, -31 : db $8A, $45, $00, $02
    dw -15, -24 : db $8A, $45, $00, $02
    dw -29, -22 : db $8A, $05, $00, $02
    dw  -5, -22 : db $8A, $05, $00, $02
    dw -16, -14 : db $8A, $05, $00, $02

    ; $0EABAA
    .group04
    dw -12, -32 : db $8A, $45, $00, $02
    dw -26, -29 : db $8A, $45, $00, $02
    dw  -6, -22 : db $8A, $45, $00, $02
    dw -19, -20 : db $8A, $05, $00, $02
    dw -26, -29 : db $8A, $45, $00, $02
    dw  -6, -22 : db $8A, $45, $00, $02
    dw -19, -20 : db $8A, $05, $00, $02

    ; $0EABE2
    .group05
    dw -17, -27 : db $9B, $05, $00, $00
    dw -10, -26 : db $9B, $05, $00, $00
    dw   0, -22 : db $9B, $45, $00, $00
    dw -19, -16 : db $9B, $45, $00, $00
    dw  -6, -12 : db $9B, $05, $00, $00

    ; $0EAC0A
    .group06
    dw   0,  13 : db $20, $0B, $00, $02
    dw   0,  23 : db $22, $0B, $00, $02

    ; $0EAC1A
    .OAM_group_pointer
    dw .group00
    dw .group01
    dw .group02
    dw .group03
    dw .group04
    dw .group05
    dw .group06

    ; $0EAC28
    .OAM_group_size
    db  1 ; Group00
    db  4 ; Group01
    db  8 ; Group02
    db 10 ; Group03
    db  7 ; Group04
    db  5 ; Group05
    db  2 ; Group06
}

; ==============================================================================

; $0EAC2F-$0EAC41 BRANCH LOCATION
BlindPoof_Draw:
{
    PHA
    
    ASL : TAY
    
    REP #$20
    
    LDA.w BlindPoof_Draw_OAM_group_pointer-$1E, Y : STA.b $08
    
    SEP #$20
    
    PLY
    
    LDA.w BlindPoof_Draw_OAM_group_size-$0F, Y
    JMP Sprite4_DrawMultiple
}

; ==============================================================================

; $0EAC42-$0EAC6D DATA
Pool_Blind_Draw:
{
    ; $0EAC42
    .chr_patch_offsets
    db $12, $12, $12, $16, $16, $02, $02, $02
    db $02, $02
    
    ; $0EAC4C
    .chr
    db $86, $86, $84, $82, $80, $82, $84, $86
    db $86, $86, $88, $8A, $8C, $8A, $88, $86
    
    ; $0EAC5C
    .vh_flip
    db $00, $00, $00, $00, $00, $40, $40, $40
    db $40, $40, $40, $40, $00, $00, $00, $00
}

; $0EAC6C-$0EACC7 LOCAL JUMP LOCATION
Blind_Draw:
{
    LDA.b #$00 : XBA
    LDA.w $0DC0, X : CMP.b #$0F : BCS BlindPoof_Draw
        REP #$20
        
        ASL #3                            : STA.b $00
        ASL #3 : SEC : SBC.b $00
                 CLC : ADC.w #.OAM_groups : STA.b $08
        
        SEP #$20
        
        LDA.b #$07
        JSR.w Sprite4_DrawMultiple
        
        LDA.w $0E70, X : BNE .using_fireball_counterattack
            LDA.w !blind_ai_state, X : CMP.b #$06 : BEQ .sheet_is_down
                CMP.b #$04 : BEQ .dont_draw_head
        
        .using_fireball_counterattack
        
        LDY.w $0DC0, X : CPY.b #$0A : BCS .dont_draw_head
            ; These are for patching the head's chr as it 'rotates' as it moves
            ; left or right.
            LDA.w Pool_Blind_Draw_chr_patch_offsets, Y : TAY
            
            PHX
            
            LDA.w !head_angle, X : TAX
            LDA.w Pool_Blind_Draw_chr, X : STA.b ($90), Y
            
            INY
            LDA.b ($90), Y
            AND.b #$3F : ORA.w Pool_Blind_Draw_vh_flip, X : STA.b ($90), Y
            
            PLX
        
        .dont_draw_head
        
        RTS
        
        .sheet_is_down
        
        ; TODO: Disables.... part of the sheet? or the head?
        LDY.b #$19s
        LDA.b #$F0 : STA.b ($90), Y
        
        RTS
}

; ==============================================================================

; TODO: A tentative name. Please make sure this is correct.
; $0EACC8-$0EAD0D LOCAL JUMP LOCATION
Blind_BumpDamageFromBody:
{
    REP #$20
    
    LDA.b $22 : SEC : SBC.w $0FD8 : CLC : ADC.w #$000E : CMP.w #$001C : BCS .dont_damage
        LDA.b $20 : SEC : SBC.w $0FDA : CLC : ADC.w #$0000 : CMP.w #$001C : BCS .dont_damage
            SEP #$20
            
            LDA.w $031F : ORA.w $037B : BNE .dont_damage
                LDA.b #$01 : STA.b $4D
                
                ; Damage player by one heart.
                ; HARDCODED: Ignores armor value.
                LDA.b #$08 : STA.w $0373
                
                LDA.b #$10 : STA.b $46
                
                LDA.b $28 : EOR.b #$FF : STA.b $28
                LDA.b $27 : EOR.b #$FF : STA.b $27
        
    .dont_damage
    
    SEP #$20
    
    RTS
}

; ==============================================================================
