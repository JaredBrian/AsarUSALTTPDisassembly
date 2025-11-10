; ==============================================================================

; $031F05-$031F2F JUMP LOCATION
Sprite_Hinox:
{
    JSR.w Hinox_Draw
    JSR.w Sprite_CheckIfActive
    
    LDA.w $0EA0, X : BEQ .not_recoiling
    	JSR.w Hinox_FacePlayer
    
    	LDA.b #$02 : STA.w $0D80, X
    	LDA.b #$30 : STA.w $0DF0, X
    
    .not_recoiling
    
    JSR.w Sprite_CheckIfRecoiling
    JSR.w Sprite_CheckDamage
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Hinox_SelectNextDirection ; 0x00 - $9FBC
    dw Hinox_Walk                ; 0x01 - $A029
    dw Hinox_ThrowBomb           ; 0x02 - $9F4A
}

; ==============================================================================

; $031F30-$031F49 DATA
Pool_Hinox_ThrowBomb:
{
    ; $031F30
    .animation_states
    db 11, 10,  8,  9
    db  7,  5,  1,  3
    
    ; $031F38
    .x_offsets_low
    db   8,  -8, -13,  13
    
    ; $031F3C
    .x_offsets_high
    db   0,  -1,  -1,   0
    
    ; $031F40
    .y_offsets_low
    db -11, -11, -16, -16
    
    ; $031F44
    .x_speeds ; Bleeds into the next block. Length 4
    db 24, -24
    
    ; $031F46
    .y_speeds
    db  0    0,  24, -24
}

; $031F4A-$031FB5 JUMP LOCATION
Hinox_ThrowBomb:
{
    LDA.w $0DF0, X : BNE .delay_ai_state_reset
    	STZ.w $0D80, X
    
    	LDA.b #$02 : STA.w $0DF0, X
    
        RTS
    
    .delay_ai_state_reset
    
    CMP.b #$20 : BNE .anothrow_bomb
        LDA.b #$4A
        JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    	    JSL.l Sprite_TransmuteToEnemyBomb
    
    	    LDA.b #$40 : STA.w $0E00, Y
    
    	    PHX
    
    	    LDA.w $0DE0, X : TAX
    	    LDA.b $00 : CLC : ADC.w Pool_Hinox_ThrowBomb_x_offsets_low, X  : STA.w $0D10, Y
    	    LDA.b $01 :       ADC.w Pool_Hinox_ThrowBomb_x_offsets_high, X : STA.w $0D30, Y
    
    	    LDA.b $02 : CLC : ADC.w Pool_Hinox_ThrowBomb_y_offsets_low, X  : STA.w $0D00, Y
    	    LDA.b $03 :       ADC.b #$FF                                   : STA.w $0D20, Y
    
    	    LDA.w Pool_Hinox_ThrowBomb_x_speeds, X : STA.w $0D50, Y
    	    LDA.w Pool_Hinox_ThrowBomb_y_speeds, X : STA.w $0D40, Y
    
    	    PLX
    
    	    LDA.b #$28 : STA.w $0F80, Y
    
    	.spawn_failed
    
    	RTS
    
    .anothrow_bomb
    
    LDY.w $0DE0, X
    
    BCS .dont_use_throwing_animation_states
        INY #4
    
    .dont_use_throwing_animation_states
    
    LDA.w Pool_Hinox_ThrowBomb_animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $031FB6-$031FBB DATA
Pool_Hinox_SetExplicitDirection:
{
    ; $031FB6
    .x_speeds ; Bleeds into the next block. Length 4
    db 8, -8
    
    ; $031F8
    .y_speeds
    db 0,  0, 8, -8
}

; $031FBC-$031FE0 JUMP LOCATION
Hinox_SelectNextDirection:
{
    LDA.w $0DF0, X : BNE Hinox_Delay
        JSL.l GetRandomInt : AND.b #$03 : BNE .change_direction
            ; If we got a 0, just throw another bomb while facing the same
            ; direction.
            LDA.b #$02 : STA.w $0D80, X
        
            LDA.b #$40 : STA.w $0DF0, X
        
            RTS
        
        .change_direction
        
        INC.w $0DB0, X
        LDA.w $0DB0, X : CMP.b #$04 : BNE Hinox_SetRandomDirection
            STZ.w $0DB0, X
            
            ; Bleeds into the next function.
}

; $031FE1-$031FEE JUMP LOCATION
Hinox_FacePlayer:
{
    JSR.w Sprite_DirectionToFacePlayer
    
    TYA
    JSR.w Hinox_SetExplicitDirection
    
    ; Speed this motha up.
    ASL.w $0D50, X
    ASL.w $0D40, X
    
    RTS
}

; ==============================================================================

; $031FEF-$031FF6 DATA
Hinox_SetRandomDirection_directions:
{
    db 2, 3, 3, 2, 0, 1, 1, 0
}

; $031FF7-$032003 LOCAL JUMP LOCATION
Hinox_SetRandomDirection:
{
    ; OPTIMIZE: Useless random call and LSR?
    JSL.l GetRandomInt : LSR

    LDA.w $0DE0, X : ROL : TAY
    LDA.w .directions, Y

    ; Bleeds into the next function.
}
    
; $032004-$032023 LOCAL JUMP LOCATION
Hinox_SetExplicitDirection:
{
    STA.w $0DE0, X
    
    JSL.l GetRandomInt : AND.b #$3F : ADC.b #$60 : STA.w $0DF0, X
    
    INC.w $0D80, X
    
    LDY.w $0DE0, X
    LDA.w Pool_Hinox_SetExplicitDirection_x_speeds, Y : STA.w $0D50, X
    LDA.w Pool_Hinox_SetExplicitDirection_y_speeds, Y : STA.w $0D40, X

    ; Bleeds into the next function.
}

; $032024-$032024 LOCAL JUMP LOCATION
Hinox_Delay:
{
    RTS
}

; ==============================================================================

; $032025-$032028 DATA
Hinox_Walk_animation_state_bases:
{
    db 6, 4, 0, 2
}

; $032029-$032064 JUMP LOCATION
Hinox_Walk:
{
    LDA.w $0DF0, X : BNE .delay_ai_state_reset
    	.reset_ai_state
    
    	LDA.b #$10 : STA.w $0DF0, X
    
    	STZ.w $0D80, X
    
    	RTS
    
    .delay_ai_state_reset
    
    DEC.w $0D90, X : BPL .delay_animation_counter_tick
    	LDA.b #$0B : STA.w $0D90, X
    
    	INC.w $0E80, X
    
    .delay_animation_counter_tick
    
    JSR.w Sprite_Move
    JSR.w Sprite_CheckTileCollision
    
    LDA.w $0E70, X : BEQ .no_tile_collision
    	BRA .reset_ai_state
    
    .no_tile_collision
    
    LDA.w $0E80, X : AND.b #$01 : STA.b $00
    
    LDY.w $0DE0, X
    LDA.w .animation_state_bases, Y : CLC : ADC.b $00 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $032065-$0321F8 DATA
Pool_Hinox_Draw:
{
    ; $032065
    .OAM_groups
    dw   0, -13 : db $00, $06, $00, $02
    dw  -8,  -5 : db $24, $06, $00, $02
    dw   8,  -5 : db $24, $46, $00, $02
    dw   0,   1 : db $06, $06, $00, $02
    
    dw   0, -13 : db $00, $06, $00, $02
    dw  -8,  -5 : db $24, $06, $00, $02
    dw   8,  -5 : db $24, $46, $00, $02
    dw   0,   1 : db $06, $46, $00, $02
    
    dw  -8,  -6 : db $24, $06, $00, $02
    dw   8,  -6 : db $24, $46, $00, $02
    dw   0,   0 : db $06, $06, $00, $02
    dw   0, -13 : db $04, $06, $00, $02
    
    dw  -8,  -6 : db $24, $06, $00, $02
    dw   8,  -6 : db $24, $46, $00, $02
    dw   0,   0 : db $06, $46, $00, $02
    dw   0, -13 : db $04, $06, $00, $02
    
    dw  -3, -13 : db $02, $06, $00, $02
    dw   0,  -8 : db $0C, $06, $00, $02
    dw   0,   0 : db $1C, $06, $00, $02
    
    dw  -3, -12 : db $02, $06, $00, $02
    dw   0,  -8 : db $0E, $06, $00, $02
    dw   0,   0 : db $1E, $06, $00, $02
    
    dw   3, -13 : db $02, $46, $00, $02
    dw   0,  -8 : db $0C, $46, $00, $02
    dw   0,   0 : db $1C, $46, $00, $02
    
    dw   3, -12 : db $02, $46, $00, $02
    dw   0,  -8 : db $0E, $46, $00, $02
    dw   0,   0 : db $1E, $46, $00, $02
    
    dw -13, -16 : db $6E, $05, $00, $02
    dw   0, -13 : db $00, $06, $00, $02
    dw  -8,  -5 : db $20, $06, $00, $02
    dw   8,  -5 : db $24, $46, $00, $02
    dw   0,   1 : db $06, $06, $00, $02
    
    dw  -8,  -5 : db $24, $06, $00, $02
    dw   8,  -5 : db $20, $46, $00, $02
    dw   0,   1 : db $06, $06, $00, $02
    dw   0, -13 : db $04, $06, $00, $02
    dw  13, -16 : db $6E, $05, $00, $02
    
    dw  -8, -11 : db $6E, $05, $00, $02
    dw  -3, -13 : db $02, $06, $00, $02
    dw   0,   0 : db $22, $06, $00, $02
    dw   0,  -8 : db $0C, $06, $00, $02
    
    dw   8, -11 : db $6E, $05, $00, $02
    dw   3, -13 : db $02, $46, $00, $02
    dw   0,   0 : db $22, $46, $00, $02
    dw   0,  -8 : db $0C, $46, $00, $02 
    
    ; $0321D5
    .OAM_group_pointers
    dw $A065, $A085, $A0A5, $A0C5, $A0E5, $A0FD, $A115, $A12D
    dw $A145, $A16D, $A195, $A1B5
    
    ; $0321ED
    .num_OAM_entries
    db 4, 4, 4, 4, 3, 3, 3, 3
    db 5, 5, 4, 4
}

; $0321F9-$032212 LOCAL JUMP LOCATION
Hinox_Draw:
{
    LDA.w $0DC0, X : PHA
    
    ASL : TAY
    
    REP #$20
    
    LDA.w Pool_Hinox_Draw_OAM_group_pointers, Y : STA.b $08
    
    SEP #$20
    
    PLY
    
    LDA.w Pool_Hinox_Draw_num_OAM_entries, Y
    JSL.l Sprite_DrawMultiple
    
    JMP Sprite_DrawShadow
}

; ==============================================================================
