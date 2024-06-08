
; ==============================================================================

; $0318E0-$0318E3 DATA
Pool_Moblin_Walk:
{
    db 6, 4, 0, 2
}

; ==============================================================================

; $0318E4-$031902 JUMP LOCATION
Sprite_Moblin:
{
    JSR Moblin_Draw
    JSR Sprite_CheckIfActive
    JSR Sprite_CheckIfRecoiling
    JSR Sprite_CheckDamage
    JSR Sprite_Move
    JSR Sprite_CheckTileCollision
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Moblin_SelectDirection
    dw Moblin_Walk
    dw Moblin_ThrowSpear
}

; ==============================================================================

; $031903-$031906 DATA
Pool_Moblin_SelectDirection:
{
    .timers
    db 16, 32, 48, 64
}

; ==============================================================================

; $031907-$03192F JUMP LOCATION
Moblin_SelectDirection:
{
    LDA.w $0DF0, X : BNE .direction_change_delay
    
    JSL GetRandomInt : AND.b #$03 : TAY
    
    LDA .timers, Y : STA.w $0DF0, X
    
    INC.w $0D80, X
    
    LDA.w $0EB0, X : STA.w $0DE0, X : TAY
    
    LDA.w $9615, Y : STA.w $0D50, X
    
    LDA.w $9617, Y : STA.w $0D40, X
    
    .direction_change_delay
    
    RTS
}

; ==============================================================================

; $031930-$031937 DATA
Pool_Moblin_Walk:
{
    db 2, 3, 2, 3, 0, 1, 0, 1
}

; ==============================================================================

; $031938-$0319A8 JUMP LOCATION
Moblin_Walk:
{
    LDA.w $0E80, X : AND.b #$01
    
    LDY.w $0DE0, X
    
    CLC : ADC .animation_states, Y : STA.w $0DC0, X
    
    LDA.b #$0C
    
    LDY.w $0E70, X : BNE .tile_collision
    
    LDA.w $0DF0, X : BNE .direction_logic_delay
    
    JSR Sprite_DirectionToFacePlayer
    
    TYA : CMP.w $0DE0, X : BNE .not_already_facing_player
    
    ; Chuck a spear at the poor player if the moblin is facing them.
    INC.w $0D80, X
    
    LDA.b #$20 : STA.w $0DF0, X
    
    BRA .skip_direction_change_logic
    
    .not_already_facing_player
    
    LDA.b #$10
    
    .tile_collision
    
    STA.w $0DF0, X
    
    JSL GetRandomInt : AND.b #$01 : STA.b $00
    
    LDA.w $0DE0, X : ASL A : ORA.b $00 : TAY
    
    LDA.w $9930, Y : STA.w $0EB0, X
    
    STZ.w $0D80, X
    
    INC.w $0DB0, X : LDA.w $0DB0, X : CMP.b #$04 : BNE .anoface_player
    
    ; After however many random selections of a new direction, explicitly
    ; face the player.
    STZ.w $0DB0, X
    
    JSR Sprite_DirectionToFacePlayer
    
    TYA : STA.w $0EB0, X
    
    .anoface_player
    .skip_direction_change_logic
    
    JSR Sprite_Zero_XYZ_Velocity
    
    RTS
    
    .direction_logic_delay
    
    DEC.w $0E90, X : BPL .animation_tick_delay
    
    LDA.b #$0B : STA.w $0E90, X
    
    INC.w $0E80, X
    
    .animation_tick_delay
    
    RTS
}

; ==============================================================================

; $0319A9-$0319B0 DATA
Pool_Moblin_ThrowSpear:
{
    .animation_states
    db 11, 10,  8,  9
    db  7,  5,  0,  2
}

; ==============================================================================

; $0319B1-$0319D8 JUMP LOCATION
Moblin_ThrowSpear:
{
    LDY.w $0DE0, X
    
    LDA.w $0DF0, X : BNE .reset_ai_state_delay
    
    STZ.w $0D80, X
    
    .reset_ai_state_delay
    
    CMP #$10 : BCS .just_animate
    CMP #$0F : BNE .anothrow_spear
    
    PHY
    
    JSR Moblin_SpawnThrownSpear
    
    PLY
    
    LDA.b #$20 : STA.w $0E00, X
    
    .anothrow_spear
    
    INY #4
    
    .just_animate
    
    LDA.w $99A9, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0319D9-$0319EA DATA
Pool_Moblin_SpawnThrownSpear:
{
    .x_offsets_low
    db 11,  -2,  -3,  11
    
    .y_offsets_low
    db -3,  -3,   3, -11
    
    .y_offsets_high
    db -1,  -1,   0,  -1
    
    .x_speeds length 4
    db 32, -32
    
    .y_speeds
    db  0,   0,  32, -32
}

; ==============================================================================

; $0319EB-$031A2F JUMP LOCATION
Moblin_SpawnThrownSpear:
{
    LDA.b #$1B : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA.b #$03 : STA.w $0D90, Y
    
    PHX
    
    LDA.w $0DE0, X : STA.w $0DE0, Y : TAX
    
    ; \note Using data from another sprite is legal, but seems kind of
    ; dumb considering all the other space saving measures they could have
    ; done.
    LDA.b $00 : CLC : ADC .x_offsets_low, X       : STA.w $0D10, Y
    LDA.b $01 : ADC Hinox.x_offsets_high, X : STA.w $0D30, Y
    
    LDA.b $02 : CLC : ADC .y_offsets_low, X  : STA.w $0D00, Y
    LDA.b $03 : ADC .y_offsets_high, X : STA.w $0D20, Y
    
    LDA .x_speeds, X : STA.w $0D50, Y
    
    LDA .y_speeds, X : STA.w $0D40, Y
    
    PLX

    .spawn_failed

    RTS
}

; ==============================================================================

; $031A30-$031BC3 DATA
Pool_Moblin_Draw:
{
    .oam_groups
    dw -2,   3 : db $91, $80, $00, $00
    dw -2,  11 : db $90, $80, $00, $00
    dw  0, -10 : db $86, $00, $00, $02
    dw  0,   0 : db $8A, $00, $00, $02
    
    dw -2,   7 : db $91, $80, $00, $00
    dw -2,  15 : db $90, $80, $00, $00
    dw  0, -10 : db $86, $00, $00, $02
    dw  0,   0 : db $8A, $40, $00, $02
    
    dw  0,  -9 : db $84, $00, $00, $02
    dw  0,   0 : db $A0, $00, $00, $02
    dw 11,  -5 : db $90, $00, $00, $00
    dw 11,   3 : db $91, $00, $00, $00
    
    dw  0,  -9 : db $84, $00, $00, $02
    dw  0,   0 : db $A0, $40, $00, $02
    dw 11,  -8 : db $90, $00, $00, $00
    dw 11,   0 : db $91, $00, $00, $00
    
    dw -4,   8 : db $80, $00, $00, $00
    dw  4,   8 : db $81, $00, $00, $00
    dw  0,  -9 : db $88, $00, $00, $02
    dw  0,   0 : db $A6, $00, $00, $02
    
    dw -9,   6 : db $80, $00, $00, $00
    dw -1,   6 : db $81, $00, $00, $00
    dw  0,  -8 : db $88, $00, $00, $02
    dw  0,   0 : db $A4, $00, $00, $02
    
    dw 12,   8 : db $80, $40, $00, $00
    dw  4,   8 : db $81, $40, $00, $00
    dw  0,  -9 : db $88, $40, $00, $02
    dw  0,   0 : db $A6, $40, $00, $02
    
    dw 17,   6 : db $80, $40, $00, $00
    dw  9,   6 : db $81, $40, $00, $00
    dw  0,  -8 : db $88, $40, $00, $02
    dw  0,   0 : db $A4, $40, $00, $02
    
    dw -3,  -5 : db $91, $80, $00, $00
    dw -3,   3 : db $90, $80, $00, $00
    dw  0, -10 : db $86, $00, $00, $02
    dw  0,   0 : db $A8, $00, $00, $02
    
    dw 11, -11 : db $90, $00, $00, $00
    dw 11,  -3 : db $91, $00, $00, $00
    dw  0,  -9 : db $84, $00, $00, $02
    dw  0,   0 : db $82, $40, $00, $02
    
    dw -2,  -3 : db $80, $00, $00, $00
    dw  6,  -3 : db $81, $00, $00, $00
    dw  0,  -9 : db $88, $00, $00, $02
    dw  0,   0 : db $A2, $00, $00, $02
    
    dw 10,  -3 : db $80, $40, $00, $00
    dw  2,  -3 : db $81, $40, $00, $00
    dw  0,  -9 : db $88, $40, $00, $02
    dw  0,   0 : db $A2, $40, $00, $02    
    
    .oam_buffer_offsets
    db $08, $08, $00, $00, $08, $08, $08, $08
    db $08, $08, $08, $08
    
    .chr
    db $88, $88, $86, $84
    
    .h_flip
    db $40, $00, $00, $00
}

; ==============================================================================

; $031BC4-$031C1F LOCAL JUMP LOCATION
Moblin_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X
    
    REP #$20
    
    ASL #5 : ADC.w #.oam_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$04 : JSL Sprite_DrawMultiple
    
    LDA.w $0F00, X : BNE .sprite_is_paused
    
    LDA.w $0E00, X : BEQ .not_throwing_spear
    
    LDY.b #$03
    
    .next_oam_entry
    
    ; This loop tries to identify small oam entries in the oam entries
    ; that make up the moblin, and.... disable them by pushing them
    ; off screen. \wtf Why is this needed?
    
    LDA ($92), Y : AND.b #$02 : BNE .is_large_oam_sprite
    
    PHY
    
    TYA : ASL #2 : TAY
    
    INY
    
    LDA.b #$F0 : STA ($90), Y
    
    PLY
    
    .is_large_oam_sprite
    
    DEY : BPL .next_oam_entry
    
    .not_throwing_spear
    
    LDY.w $0DC0, X
    
    LDA .oam_buffer_offsets, Y : TAY
    
    PHX
    
    LDA.w $0EB0, X : TAX
    
    LDA .chr, X : INY #2 : STA ($90), Y
    
    INY
    
    LDA ($90), Y : AND.b #$BF : ORA .h_flip, X : STA ($90), Y
    
    PLX
    
    JMP Sprite_DrawShadow
    
    .sprite_is_paused
    
    RTS
}

; ==============================================================================
