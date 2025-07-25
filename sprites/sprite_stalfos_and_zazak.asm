; ==============================================================================

; $0F0FDF-$0F0FFF LOCAL JUMP LOCATION
Sprite_StalfosBone:
{
    JSR.w StalfosBone_Draw
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckDamageToPlayer
    
    INC.w $0E80, X
    
    JSR.w Sprite3_Move
    
    LDA.w $0DF0, X : BNE .dont_self_terminate 
        JSR.w Sprite3_CheckTileCollision : BEQ .dont_self_terminate
            STZ.w $0DD0, X
            
            JSL.l Sprite_PlaceRupulseSpark
        
    .dont_self_terminate
    
    RTS
}

; ==============================================================================

; $0F1000-$0F103F DATA
StalfosBone_Draw_OAM_groups:
{
    dw -4, -2 : db $2F, $80, $00, $00
    dw  4,  2 : db $2F, $40, $00, $00
    
    dw -4,  2 : db $2F, $00, $00, $00
    dw  4, -2 : db $2F, $C0, $00, $00
    
    dw  2, -4 : db $3F, $40, $00, $00
    dw -2,  4 : db $3F, $80, $00, $00
    
    dw -2, -4 : db $3F, $00, $00, $00
    dw  2,  4 : db $3F, $C0, $00, $00
}

; ==============================================================================

; $0F1040-$0F105B LOCAL JUMP LOCATION
StalfosBone_Draw:
{
    LDA.b #$00 : XBA
    LDA.w $0E80, X : LSR : LSR : AND.b #$03
    
    REP #$20
    
    ASL #4 : ADC.w #(.OAM_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$02
    JMP Sprite3_DrawMultiple
}

; ==============================================================================

; $0F105C-$0F106B DATA
Pool_Stalfos:
{
    ; $0F105C
    .timers
    db $10, $20, $40, $20
    
    ; $0F1060
    .animation_states_1
    db $06, $04, $00, $02, $07, $05, $01, $03
    
    ; $0F1068
    .animation_states_2
    db $08, $09, $0A, $0B
}

; $0F106C-$0F10B0 JUMP LOCATION
Sprite_Stalfos:
{
    LDA.w $0D90, X : BEQ .not_bone
        JMP Sprite_StalfosBone
    
    .not_bone
    
    LDA.w $0E90, X : BEQ Stalfos_Visible
        LDA.w $0DF0, X : BNE .delay
            LDA.b #$01 : STA.w $0D50, X : STA.w $0D40, X
            
            JSR.w Sprite3_CheckTileCollision : BEQ .no_tile_collision
                STZ.w $0DD0, X
                
                RTS
            
            .no_tile_collision
            
            STZ.w $0E90, X
            
            LDA.b #$15
            JSL.l Sound_SetSfx2PanLong
            
            JSL.l Sprite_SpawnPoofGarnish
            
            LDA.b #$08 : STA.w $0E10, X
            
            LDA.b #$40 : STA.w $0DF0, X
            
            STZ.w $0D40, X
            
            STZ.w $0D50, X
        
        .delay
        
        JSL.l Sprite_PrepOamCoordLong
        
        RTS
}

; ==============================================================================

; $0F10B1-$0F10B4 DATA
Stalfos_Visible_direction:
{
    db $03, $02, $01, $00
}

; $0F10B5-$0F119E LOCAL JUMP LOCATION
Stalfos_Visible:
{
    LDA.w $0DD0, X : CMP.b #$09 : BNE .dont_dodge
        REP #$20
        
        LDA.b $22 : SEC : SBC.w $0FD8 : CLC : ADC.w #$0028 : CMP.w #$0050 : BCS .dont_dodge
            LDA.b $20 : SEC : SBC.w $0FDA : CLC : ADC.w #$0030 : CMP.w #$0050 : BCS .dont_dodge
                SEP #$20
                
                LDA.b $44 : CMP.b #$80 : BEQ .dont_dodge
                    LDA.w $0F70, X : ORA.w $0F00, X : BNE .dont_dodge
                        LDA.b $EE : CMP.w $0F20, X : BNE .dont_dodge
                            JSR.w Sprite3_DirectionToFacePlayer
                            
                            STY.b $00
                            
                            LDA.w $0372 : BNE .dodge
                                LDA.b $3C : CMP.b #$90 : BCS .face_player_then_dodge
                                    CMP.b #$09 : BPL .dont_dodge
                            .dodge
                                    
                            LDA.b $2F : LSR : TAY
                            LDA.b $00 : CMP.w .direction, Y : BEQ .dont_dodge
                                .face_player_then_dodge
                                
                                LDA.b $00 : STA.w $0DE0, X
                                
                                LDA.b #$20
                                JSL.l Sprite_ProjectSpeedTowardsPlayerLong
                                
                                LDA.b $01 : EOR.b #$FF : INC : STA.w $0D50, X
                                LDA.b $00 : EOR.b #$FF : INC : STA.w $0D40, X
                                
                                LDA.b #$20 : STA.w $0F80, X
                                
                                LDA.b #$13
                                JSL.l Sound_SetSfx3PanLong
                                
                                INC.w $0F70, X
        
    .dont_dodge
    
    SEP #$20
    
    LDA.w $0F70, X : BEQ .not_dodging
        LDY.w $0DE0, X
        LDA Stalfos_animation_states_2, Y : STA.w $0DC0, X
        
        JSL.l Stalfos_Draw
        JSR.w Sprite3_CheckIfActive
        
        LDA.w $0EA0, X : BEQ .not_in_recoil
            STZ.w $0F80, X
        
        .not_in_recoil
        
        JSR.w Sprite3_CheckIfRecoiling
        JSR.w Sprite3_CheckDamage
        JSR.w Sprite3_CheckTileCollision
        
        PHA
        AND.b #$03 : BEQ .no_horiz_tile_collision
            STZ.w $0D50, X
        
        .no_horiz_tile_collision
        
        PLA : AND.b #$0C : BEQ .no_vert_tile_collision
            STZ.w $0D40, X
        
        .no_vert_tile_collision
        
        JSR.w Sprite3_MoveXyz
        
        LDA.w $0F80, X : SEC : SBC.b #$02 : STA.w $0F80, X
        
        LDA.w $0F70, X : DEC : BPL .in_air
            STZ.w $0F70, X
            
            JSR.w Sprite3_Zero_XY_Velocity
            
            LDA.b #$21
            JSL.l Sound_SetSfx2PanLong
            
            LDA.w $0E30, X : BEQ .not_red_stalfos
                ; Throw a bone at the player.
                LDA.b #$10 : STA.w $0EE0, X
                
                STZ.w $0E80, X
            
            .not_red_stalfos
        .in_air
        
        RTS
        
    .not_dodging

    ; Bleeds into the next function.
}

; $0F119F-$0F122A LOCAL JUMP LOCATION
Sprite_Zazak:
{
    LDA.w $0DA0, X : BEQ .not_fire_phlegm
        JSR.w FirePhlegm_Draw
        JSR.w Sprite3_CheckIfActive
        
        LDA.b $1A : LSR : AND.b #$01 : STA.w $0DC0, X
        
        JSR.w Sprite3_CheckDamageToPlayer
        JSR.w Sprite3_Move
        
        JSR.w Sprite3_CheckTileCollision : BEQ .no_repulse_spark 
            STZ.w $0DD0, X
            
            JSL.l Sprite_PlaceRupulseSpark_coerce
            
        .no_repulse_spark
        
        RTS
        
    .not_fire_phlegm
    
    ; NOTE: Due to all this shared code, a Zazak could in theory be made
    ; to throw a bone, and a stalfos could be made to shoot fire phlegm.
    LDA.w $0EE0, X : BEQ .bone_throw_timer_inactive
        PHA
        
        STZ.w $0D80, X
        
        LDA.b #$20 : STA.w $0DF0, X
        
        JSR.w Sprite3_Zero_XY_Velocity
        JSR.w Sprite3_DirectionToFacePlayer
        
        TYA : STA.w $0EB0, X
        
        PLA
        
    .bone_throw_timer_inactive
    
    CMP.b #$01 : BNE .dont_throw_bone
        JSR.w Stalfos_ThrowBoneAtPlayer
        
        LDA.b #$01 : STA.w $0E80, X
        
    .dont_throw_bone
    
    LDA.w $0E80, X : AND.b #$01 : ASL : ASL : ADC.w $0DE0, X : TAY
    LDA.w Stalfos_animation_states_1, Y : STA.w $0DC0, X
    
    LDA.w $0E20, X : CMP.b #$A7 : BNE .not_stalfos
        JSL.l Stalfos_Draw
        JSR.w Sprite3_CheckIfActive
        
        BRA .moving_on
        
    .not_stalfos
    
    JSL.l Zazak_Draw
    JSR.w Sprite3_CheckIfActive
    
    .moving_on
    
    JSR.w Sprite3_CheckIfRecoiling
    JSR.w Sprite3_CheckDamage
    JSR.w Sprite3_Move
    JSR.w Sprite3_CheckTileCollision
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Zazak_WalkThenTrackHead        ; 0x00 - $922B
    dw Zazak_HaltAndPickNextDirection ; 0x01 - $925C
    dw Zazak_ShootFirePhlegm          ; 0x02 - $92D2
}

; ==============================================================================

; NOTE: Walks in straight line, ignoring collision, and then uses the
; direction the head is facing as the next direction to walk in (in the
; next state).
; $0F122B-$0F1253 JUMP LOCATION
Zazak_WalkThenTrackHead:
{
    LDA.w $0DF0, X : BNE .delay
        JSL.l GetRandomInt : AND.b #$03 : TAY
        LDA.w Stalfos_timers, Y : STA.w $0DF0, X
        
        INC.w $0D80, X
        
        LDA.w $0EB0, X : STA.w $0DE0, X
                         TAY
        LDA.w Sprite3_Shake_x_speeds, Y : STA.w $0D50, X
        LDA.w Sprite3_Shake_y_speeds, Y : STA.w $0D40, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F1254-$0F125B DATA
Zazak_HaltAndPickNextDirection_head_orientations:
{
    db 2, 3, 2, 3, 0, 1, 0, 1
}

; $0F125C-$0F12BC JUMP LOCATION
Zazak_HaltAndPickNextDirection:
{
    LDA.b #$10
    
    LDY.w $0E70, X : BNE .select_new_direction
        LDA.w $0DF0, X : BNE .just_animate
            LDA.w $0E20, X : CMP.b #$A6 : BNE .not_red_zazak
                JSR.w Sprite3_DirectionToFacePlayer
                TYA : CMP.w $0DE0, X : BNE .dont_shoot_player
                    LDA.b $EE : CMP.w $0F20, X : BNE .dont_shoot_player
                        INC.w $0D80, X
                        
                        LDA.b #$30 : STA.w $0DF0, X
                                     STA.w $0DF0, X
                        
                        BRA .zero_xy_velocity
                
                .dont_shoot_player
                
                LDA.b #$20
                
            .not_red_zazak
    .select_new_direction
    
    STA.w $0DF0, X
    
    ; OPTIMIZE: What?
    JSL.l GetRandomInt : LSR
    
    LDA.w $0DE0, X : ROL : TAY
    LDA.w .head_orientations, Y : STA.w $0EB0, X
    
    STZ.w $0D80, X
    
    INC.w $0DB0, X
    LDA.w $0DB0, X : CMP.b #$04 : BNE .zero_xy_velocity
        STZ.w $0DB0, X
        
        ; In this case, directly face the player and walk towards them.
        JSR.w Sprite3_DirectionToFacePlayer
        
        TYA : STA.w $0EB0, X
        
        LDA.b #$18 : STA.w $0DF0, X
    
    .zero_xy_velocity

    ; Bleeds into the next function.
}
    
; $0F12BD-$0F12D1 JUMP LOCATION
Sprite3_Zero_XY_Velocity:
{
    STZ.w $0D50, X
    STZ.w $0D40, X
    
    RTS
}

; $0F12C4-$0F12D1 JUMP LOCATION
Zazak_HaltAndPickNextDirection_just_animate:
{
    DEC.w $0ED0, X : BPL .animation_timer_not_expired
        LDA.b #$0B : STA.w $0ED0, X
        
        INC.w $0E80, X
        
    .animation_timer_not_expired
    
    RTS
}

; ==============================================================================

; $0F12D2-$0F12E3 JUMP LOCATION
Zazak_ShootFirePhlegm:
{
    LDA.w $0DF0, X : BNE .delay_ai_state_revert
        STZ.w $0D80, X
        
        RTS
        
    .delay_ai_state_revert
    
    CMP.b #$18 : BNE .delay_firing_phlegm
        JSL.l Sprite_SpawnFirePhlegm
    
    .delay_firing_phlegm
    
    RTS
}

; ==============================================================================

; $0F12E4-$0F1378 LONG JUMP LOCATION
Sprite_SpawnFirePhlegm:
{
    PHB : PHK : PLB
    
    LDA.b #$A5
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.b #$05
        JSL.l Sound_SetSfx3PanLong
        
        JSL.l Sprite_SetSpawnedCoords
        
        PHX
        
        LDA.w $0DE0, X : TAX
        LDA.b $00 : CLC : ADC .x_offsets_low,  X : STA.w $0D10, Y
        LDA.b $01       : ADC .x_offsets_high, X : STA.w $0D30, Y
        
        LDA.b $02 : CLC : ADC .y_offsets_low,  X : STA.w $0D00, Y
        LDA.b $03       : ADC .y_offsets_high, X : STA.w $0D20, Y
        
        LDA.w .x_speeds, X : STA.w $0D50, Y
        LDA.w .y_speeds, X : STA.w $0D40, Y
        
        LDA.w $0E60, Y : ORA.b #$40 : STA.w $0E60, Y
        
        LDA.b #$40 : STA.w $0CAA, Y
        
        LDA.b #$21 : STA.w $0E40, Y
                     STA.w $0DA0, Y
        
        LDA.b #$02 : STA.w $0F50, Y
        
        LDA.b #$14 : STA.w $0F60, Y
                     STA.w $0BA0, Y
        
        LDA.b #$25 : STA.w $0CD2, Y
        
        ; Seems counterintuive as the blockable code I thought handles shield
        ; levels on its own, unless this is just to save time.
        LDA.l $7EF35A : CMP.b #$03 : BCC .unblockable
            LDA.b #$20 : STA.w $0BE0, Y
        
        .unblockable
        
        PLX
    
    .spawn_failed
    
    PLB
    
    RTL
    
    ; $0F1363
    .x_speeds ; Bleeds into the next block. Length 4.
    db  48, -48
    
    ; $0F1365
    .y_speeds
    db   0,   0,  48, -48
    
    ; $0F1369
    .x_offsets_low
    db 16, -8,  4,  4
    
    ; $0F136D
    .x_offsets_high
    db  0, -1,  0,  0
    
    ; $0F1371
    .y_offsets_low
    db -2, -2,  8, -4
    
    ; $0F1375
    .y_offsets_high
    db -1, -1,  0,  0
}

; ==============================================================================

; $0F1379-$0F13C2 LOCAL JUMP LOCATION
Stalfos_ThrowBoneAtPlayer:
{
    LDA.b #$A7
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.b #$01 : STA.w $0D90, Y
        
        JSL.l Sprite_SetSpawnedCoords
        
        PHX
        
        TYX
        
        LDA.b #$20
        JSL.l Sprite_ApplySpeedTowardsPlayerLong
        
        LDA.b #$21 : STA.w $0E40, X
                     STA.w $0BA0, X
        
        LDA.w $0E60, X : ORA.b #$40 : STA.w $0E60, X
        
        LDA.b #$48 : STA.w $0CAA, X
        
        LDA.b #$10 : STA.w $0DF0, X
        
        LDA.b #$14 : STA.w $0F60, X
        
        LDA.b #$07 : STA.w $0F50, X
        
        LDA.b #$20 : STA.w $0CD2, X
        
        PLX
        
        LDA.b #$02
        JSL.l Sound_SetSfx2PanLong
        
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0F13C3-$0F1442 DATA
FirePhlegm_Draw_OAM_entries:
{
    dw  0,  0 : db $C3, $00, $00, $00
    dw -8,  0 : db $C2, $00, $00, $00
    
    dw  0,  0 : db $C3, $80, $00, $00
    dw -8,  0 : db $C2, $80, $00, $00
    
    dw  0,  0 : db $C3, $40, $00, $00
    dw  8,  0 : db $C2, $40, $00, $00
    
    dw  0,  0 : db $C3, $C0, $00, $00
    dw  8,  0 : db $C2, $C0, $00, $00
    
    dw  0,  0 : db $D4, $00, $00, $00
    dw  0, -8 : db $D3, $00, $00, $00
    
    dw  0,  0 : db $D4, $40, $00, $00
    dw  0, -8 : db $D3, $40, $00, $00
    
    dw  0,  0 : db $D4, $80, $00, $00
    dw  0,  8 : db $D3, $80, $00, $00
    
    dw  0,  0 : db $D4, $C0, $00, $00
    dw  0,  8 : db $D3, $C0, $00, $00
}

; ==============================================================================

; $0F1443-$0F145F LOCAL JUMP LOCATION
FirePhlegm_Draw:
{
    LDA.b #$00 : XBA
    LDA.w $0DE0, X : ASL : CLC : ADC.w $0DC0, X
    
    REP #$20
    
    ASL #4 : ADC.w #.OAM_entries : STA.b $08
    
    SEP #$20
    
    LDA.b #$02
    JMP Sprite3_DrawMultiple
}

; ==============================================================================
