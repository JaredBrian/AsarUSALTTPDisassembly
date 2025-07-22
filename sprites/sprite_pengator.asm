; ==============================================================================

; $0F2192-$0F2195 DATA
Pool_Sprite_Pengator_animation_states:
{
    db $05, $00, $0A, $0F
}

; $0F2196-$0F21E9 JUMP LOCATION
Sprite_Pengator:
{
    LDY.w $0DE0, X
    
    LDA.w $0D90, X : CLC : ADC .animation_states, Y : STA.w $0DC0, X
    
    JSR.w Pengator_Draw
    
    LDA.w $0EA0, X : BNE .recoiling
        LDA.w $0E70, X : AND.b #$0F : BEQ .no_tile_collision
    
    .recoiling
    
    STZ.w $0D80, X
    STZ.w $0D50, X
    STZ.w $0D40, X
    
    .no_tile_collision
    
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckIfRecoiling
    JSR.w Sprite3_CheckDamage
    JSR.w Sprite3_MoveXyz
    
    ; Apply gravity
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .hasnt_landed
        STZ.w $0F80, X
        
        STZ.w $0F70, X
    
    .hasnt_landed
    
    JSR.w Sprite3_CheckTileCollision
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Pengator_FacePlayer      ; 0x00 - $A1EA
    dw Pengator_SpeedUp         ; 0x01 - $A1FB
    dw Pengator_Jump            ; 0x02 - $A244
    dw Pengator_SlideAndSparkle ; 0x03 - $A271
}

; ==============================================================================

; $0F21EA-$0F21F4 JUMP LOCATION
Pengator_FacePlayer:
{
    JSR.w Sprite3_DirectionToFacePlayer
    
    TYA : STA.w $0DE0, X
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $0F21F5-$0F21FA DATA
Pool_Pengator_SpeedUp:
{
    ; $0F21F5
    .x_speeds ; Bleeds into the next block. Length 4.
    db 1, -1
    
    ; $0F21F7
    .y_speeds
    db 0,  0, 1, -1
}

; $0F21FB-$0F223F JUMP LOCATION
Pengator_SpeedUp:
{
    TXA : EOR.b $1A : AND.b #$03 : BNE .delay
        STZ.b $00
        
        LDY.w $0DE0, X
        
        LDA.w $0D50, X : CMP Sprite3_Shake_x_speeds, Y : BEQ .x_speed_at_target
            CLC : ADC Pool_Pengator_SpeedUp_x_speeds, Y : STA.w $0D50, X
            
            INC.b $00
            
        .x_speed_at_target
        
        LDA.w $0D40, X : CMP Sprite3_Shake_y_speeds, Y : BEQ .y_speed_at_target
            CLC : ADC Pool_Pengator_SpeedUp_y_speeds, Y : STA.w $0D40, X
            
            INC.b $00
        
        .y_speed_at_target
        
        LDA.b $00 : BNE .added_speed_this_frame
            LDA.b #$0F : STA.w $0DF0, X
            
            INC.w $0D80, X
        
        .added_speed_this_frame
    .delay
    
    LDA.b $1A : AND.b #$04 : LSR : LSR : TAY : STA.w $0D90, X
    
    RTS
}

; ==============================================================================

; $0F2240-$0F2243 DATA
Pengator_Jump_animation_states:
{
    db 4, 4, 3, 2
}

; $0F2244-$0F2260 JUMP LOCATION
Pengator_Jump:
{
    LDA.w $0DF0, X : BNE .state_transition_delay
        INC.w $0D80, X
    
    .state_transition_delay
    
    CMP.b #$05 : BNE .anojump
        PHA
        
        LDA.b #$18 : STA.w $0F80, X
        
        PLA
        
    .anojump
    
    LSR : LSR : TAY
    
    LDA.w .animation_states, Y : STA.w $0D90, X
    
    RTS
}

; ==============================================================================

; $0F2261-$0F2270 DATA
Pool_Pengator_SlideAndSparkle:
{
    ; $0F2261
    .random_x_offsets
    db  8, 10, 12, 14
    db 12, 12, 12, 12
    
    ; $0F2269
    .random_y_offsets
    db  4,  4,  4,  4
    db  0,  4,  8, 12
}

; ==============================================================================

; $0F2271-$0F22B4 JUMP LOCATION
Pengator_SlideAndSparkle:
{
    TXA : EOR.b $1A : AND.b #$07 : ORA.w $0F70, X : BNE .still_falling
        LDA.w $0DE0, X : STA.b $06
        
        JSL.l GetRandomInt : AND.b #$03 : TAY
        
        LDA.b $06 : CMP.b #$02 : BCC .vertical_orientation
            INY #4
        
        .vertical_orientation
        
        LDA.w .random_y_offsets, Y : STA.b $00
                                     STZ.b $01
        
        JSL.l GetRandomInt : AND.b #$03 : TAY
        
        LDA.b $06 : CMP.b #$02 : BCC .vertical_orientation_2
            INY #4
        
        .vertical_orientation_2
        
        LDA.w .random_y_offsets, Y : STA.b $02
                                     STZ.b $03
        
        JSL.l Sprite_SpawnSimpleSparkleGarnish_SlotRestricted
        
    .still_falling
    
    RTS
}

; ==============================================================================

; $0F22B5-$0F2414 DATA
Pool_Pengator_Draw:
{
    ; $0F22B5
    .OAM_groups
    dw -1, -8 : db $82, $00, $00, $02
    dw  0,  0 : db $88, $00, $00, $02
    dw -1, -7 : db $82, $00, $00, $02
    dw  0,  0 : db $8A, $00, $00, $02
    dw -3, -6 : db $82, $00, $00, $02
    dw  0,  0 : db $88, $00, $00, $02
    dw -6, -4 : db $82, $00, $00, $02
    dw  0,  0 : db $8A, $00, $00, $02
    dw -4,  0 : db $A2, $00, $00, $02
    dw  4,  0 : db $A3, $00, $00, $02
    dw  1, -8 : db $82, $40, $00, $02
    dw  0,  0 : db $88, $40, $00, $02
    dw  1, -7 : db $82, $40, $00, $02
    dw  0,  0 : db $8A, $40, $00, $02
    dw  3, -6 : db $82, $40, $00, $02
    dw  0,  0 : db $88, $40, $00, $02
    dw  6, -4 : db $82, $40, $00, $02
    dw  0,  0 : db $8A, $40, $00, $02
    dw  4,  0 : db $A2, $40, $00, $02
    dw -4,  0 : db $A3, $40, $00, $02
    dw  0, -7 : db $80, $00, $00, $02
    dw  0,  0 : db $86, $00, $00, $02
    dw  0, -7 : db $80, $40, $00, $02
    dw  0,  0 : db $86, $40, $00, $02
    dw  0, -4 : db $80, $00, $00, $02
    dw  0,  0 : db $86, $00, $00, $02
    dw  0, -1 : db $80, $00, $00, $02
    dw  0,  0 : db $86, $00, $00, $02
    dw -8,  0 : db $8E, $00, $00, $02
    dw  8,  0 : db $8E, $40, $00, $02
    dw  0, -8 : db $84, $00, $00, $02
    dw  0,  0 : db $8C, $00, $00, $02
    dw  0, -8 : db $84, $40, $00, $02
    dw  0,  0 : db $8C, $40, $00, $02
    dw  0, -7 : db $84, $00, $00, $02
    dw  0,  0 : db $8C, $00, $00, $02
    dw  0,  0 : db $8C, $40, $00, $02
    dw  0, -6 : db $84, $40, $00, $02
    dw -8,  0 : db $A0, $00, $00, $02
    dw  8,  0 : db $A0, $40, $00, $02
    
    ; $0F23F5
    .OAM_groups_2
    dw  0, 16 : db $B5, $00, $00, $00
    dw  8, 16 : db $B5, $40, $00, $00
    dw  0, -8 : db $A5, $00, $00, $00
    dw  8, -8 : db $A5, $40, $00, $00
}

; $0F2415-$0F2461 LOCAL JUMP LOCATION
Pengator_Draw:
{
    LDA.b #$00 : XBA
    LDA.w $0DC0, X

    REP #$20
    ASL #4 : ADC.w #Pool_Pengator_Draw_OAM_groups : STA.b $08
    SEP #$20
    
    LDA.b #$02 : JSR.w Sprite3_DrawMultiple
    
    LDY.b #$00
    
    LDA.b #$00   : XBA
    LDA.w $0DC0, X : CMP.b #$0E : BEQ .draw_more_sprites
        INY
        
        CMP.b #$13 : BNE .draw_shadow
    
    ; TODO: Find out exactly what these other sprites are.
    .draw_more_sprites
    
    TYA
    
    REP #$20
    
    ASL #4 : ADC.w #Pool_Pengator_Draw_OAM_groups_2 : STA.b $08
    
    LDA.b $90 : CLC : ADC.w #$0008 : STA.b $90
    
    INC.b $92 : INC.b $92
    
    SEP #$20
    
    LDA.b #$02 : JSR.w Sprite3_DrawMultiple
    
    .draw_shadow
    
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
