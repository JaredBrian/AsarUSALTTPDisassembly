; ==============================================================================

; Switch / Lever (0x04, 0x05, 0x06, 0x07) That can be pulled in puzzles.
; $02D6BC-$02D6D3 LONG JUMP LOCATION
Sprite_PullSwitch:
{
    PHB : PHK : PLB
    
    LDA.w $0E20, X : CMP.b #$07 : BEQ .bad_switches
        CMP.b #$05 : BNE .good_switch
    
    .bad_switches
    
    JSR.w Sprite_BadPullSwitch
    
    PLB
    
    RTL
    
    .good_switch
    
    JSR.w Sprite_GoodPullSwitch
    
    PLB
    
    RTL
}

; ==============================================================================

; $02D6D4-$02D72E LOCAL JUMP LOCATION
Sprite_BadPullSwitch:
{
    JSR.w PullSwitch_HandleUpPulling
    
    LDY.w $0DC0, X : BEQ .alpha
    CPY.b #$0B : BEQ .alpha
        LDA.w .LinkAnimState, Y : STA.w $0377
        
        LDA.w $0D00, X : SEC : SBC.b #$13 : STA.b $20
        LDA.w $0D20, X       : SBC.b #$00 : STA.b $21
        
        LDA.w $0D10, X : STA.b $22
        LDA.w $0D30, X : STA.b $23
        
        LDA.w $0DF0, X : BNE .alpha
            INC.w $0DC0, X
            LDY.w $0DC0, X : CPY.b #$0B : BNE .beta
                LDA.b #$1B : STA.w $012F
                LDA.b #$01 : STA.w $0642
                
            .beta
            
            LDA.w .Timers, Y : STA.w $0DF0, X
            
            ; OPTIMIZE: Useless branch.
            BRA .alpha
        
    .alpha
    
    LDA.w $0E20, X : CMP.b #$07 : BEQ .up_facing_switchs
        JSR.w BadPullDownSwitch_Draw
        
        RTS
        
    .up_facing_switch
    
    JSR.w BadPullUpSwitch_Draw
    
    RTS

    ; $02D72F
    .Timers
    db   8,  24,   4,   4
    db   4,   4,   4,   4
    db   2

    ; $02D738
    .LinkAnimState
    db $0A, $06, $07, $08
    db $08, $08, $08, $08
    db $09, $09, $09
}

; ==============================================================================

; $02D743-$02D7C9 LOCAL JUMP LOCATION
PullSwitch_HandleUpPulling:
{
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .alpha
        STZ.b $27
        STZ.b $28
        
        JSL.l Sprite_RepelDashAttackLong
        
        STZ.b $48
        
        LDA.w $0020 : SEC : SBC.w $0D00, X : CMP.b #$02 : BPL .beta
            CMP.b #$F4 : BMI .gamma
                LDA.w $0022 : CMP.w $0D10, X : BPL .delta
                    LDA.w $0D10, X : SEC : SBC.b #$10 : STA.b $22
                    LDA.w $0D30, X       : SBC.b #$00 : STA.b $23

                    RTS
                
                .delta
                
                LDA.w $0D10, X : CLC : ADC.b #$0E : STA.b $22
                LDA.w $0D30, X       : ADC.b #$00 : STA.b $23
    
    .alpha
    
    RTS
    
    .gamma
    
    INC.w $0379
    
    LDA.b $F2 : BPL .epsilon
        LDA.b $F0 : AND.b #$03 : BNE .epsilon
            LDA.w $0DC0, X : BNE .epsilon
                INC.w $0DC0, X
                
                LDA.b #$08 : STA.w $0DF0, X
                
                LDA.b #$22
                JSL.l Sound_SetSfx2PanLong
    
    .epsilon
    
    LDA.w $0D00, X : SEC : SBC.b #$15 : STA.b $20
    LDA.w $0D20, X       : SBC.b #$00 : STA.b $21
    
    RTS
    
    .beta
    
    LDA.w $0D00, X : CLC : ADC.b #$09 : STA.b $20
    LDA.w $0D20, X       : ADC.b #$00 : STA.b $21
    
    RTS
} 

; ==============================================================================

; WTF: This sprite is an over optimized mess in terms of table space usage.
; $02D7CA-$02D7F8 DATA
Pool_BadPullDownSwitch_Draw:
{
    ; $02D7CA
    .x_offsets
    db -4, 12,  0, -4,  4,  4
    
    ; $02D7D0
    .y_offsets
    db -3,  3,  0,  5,  5,  5
    
    ; $02D7D6
    .chr
    db $D2, $D2, $C4, $E4, $E4, $E4
    
    ; $02D7DC
    .h_flip ; Bleeds into the next block. Length 6.
    db $40, $00, $00, $40

    ; $02D7E0
    .properties
    db $00, $00, $02, $02, $02, $02
    
    ; $02D7E6
    .additional_handle_y_offsets
    db 0, 1, 2, 3, 4, 5, 5
    
    ; $2D7ED
    .additional_handle_y_indices
    db 0, 0, 1, 1, 2, 2, 3, 3, 4, 5, 5, 5
}

; $02D7F9-$02D855 LOCAL JUMP LOCATION
BadPullDownSwitch_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    JSL.l Sprite_OAM_AllocateDeferToPlayerLong
    
    LDY.w $0DC0, X
    LDA.w Pool_BadPullDownSwitch_Draw_additional_handle_y_indices, Y : TAY
    LDA.w Pool_BadPullDownSwitch_Draw_additional_handle_y_offsets, Y : STA.b $06
    
    PHX
    
    LDX.b #$04
    LDY.b #$00
    
    .next_OAM_entry
        
        LDA.b $00 : CLC : ADC.w Pool_BadPullDownSwitch_Draw_x_offsets, X
        STA.b ($90), Y

        LDA.b $02 : CLC : ADC.w Pool_BadPullDownSwitch_Draw_y_offsets, X
        INY : STA.b ($90), Y

        LDA.w Pool_BadPullDownSwitch_Draw_chr, X : INY : STA.b ($90), Y

        LDA.w Pool_BadPullDownSwitch_Draw_h_flip, X
        ORA.b #$21 : INY : STA.b ($90), Y
        
        PHY
        
        CPX.b #$02 : BNE .alpha
            DEY : DEY
            
            LDA.b ($90), Y : SEC : SBC.b $06 : STA.b ($90), Y
            
        .alpha
        
        TYA : LSR : LSR : TAY
        LDA.w Pool_BadPullDownSwitch_Draw_properties, X : STA.b ($92), Y
        
        PLY : INY
    DEX : BPL .next_OAM_entry
    
    PLX
    
    LDY.b #$FF
    LDA.b #$04
    JSL.l Sprite_CorrectOamEntriesLong
    
    RTS
}

; ==============================================================================

; $02D856-$02D857 DATA
BadPullUpSwitch_Draw_chr:
{
    db $A2, $A4
}

; $02D858-$02D8B4 LOCAL JUMP LOCATION
BadPullUpSwitch_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    JSL.l Sprite_OAM_AllocateDeferToPlayerLong
    
    LDY.w $0DC0, X
    
    LDA.w Pool_BadPullDownSwitch_Draw_additional_handle_y_indices, Y : TAY
    LDA.w Pool_BadPullDownSwitch_Draw_additional_handle_y_offsets, Y : STA.b $06
                                                                       STZ.b $07
    
    PHX
    
    LDX.b #$01
    LDY.b #$00
    
    .gamma
    
        REP #$20
        
        LDA.b $00    : STA.b ($90), Y
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02
        
        CPX.b #$00 : BNE .alpha
            SEC : SBC.b $06
        
        .alpha
        
        INY : STA.b ($90), Y
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
            LDA.b #$F0 : STA.b ($90), Y
        
        .on_screen_y
        
        LDA.w .chr, X : INY : STA.b ($90), Y
        LDA.b $05     : INY : STA.b ($90), Y
        
        PHY
        TYA : LSR : LSR : TAY
        LDA.b #$02 : ORA.b $0F : STA.b ($92), Y
        
        PLY : INY
    DEX : BPL .gamma
    
    PLX
    
    RTS
}

; ==============================================================================

; $02D8B5-$02D944 LOCAL JUMP LOCATION
Sprite_GoodPullSwitch:
{
    JSR.w PullSwitch_HandleDownPulling
    
    LDY.w $0DC0, X : BEQ .alpha
    CPY.b #$0D : BEQ .alpha
        LDA.w .player_pull_poses-1, Y : STA.w $0377
        
        LDA.w $0D00, X : CLC : ADC.w .player_y_offsets-1, Y : STA.b $20
        LDA.w $0D20, X       : ADC.b #$00                   : STA.b $21
        
        LDA.w $0D10, X : STA.b $22
        LDA.w $0D30, X : STA.b $23
        
        LDA.w $0DF0, X : BNE .alpha
            INC.w $0DC0, X
            LDY.w $0DC0, X : CPY.b #$0D : BNE .set_delay_timer
                LDA.w $0E20, X : CMP.b #$06 : BNE .not_trap_switch
                    ; Tell bomb / snake traps in the room to trigger .
                    LDA.b #$01 : STA.w $0CF4
                    
                    ; Play error noise.
                    LDA.b #$3C : STA.w $012E
                    
                    BRA .set_delay_timer
                
                .not_trap_switch
                
                ; Indicates the correct switch was pulled.
                LDA.b #$01 : STA.w $0642
                
                ; Play puzzle solved noise.
                LDA.b #$1B : STA.w $012F
            
            .set_delay_timer
            
            LDA.w .timers-2, Y : STA.w $0DF0, X
            
            ; OPTIMIZE: Useless branch.
            BRA .alpha
    
    .alpha
    
    JSR.w GoodPUllSwitch_Draw
    
    LDA.w $0F00, X : BEQ .delta
        STZ.w $0DC0, X
    
    .delta
    
    RTS
    
    ; $02D921
    .timers
    db  5,  5,  5,  5,  5,  5,  5,  5
    db  5,  5,  5,  5
    
    ; $02D92C
    .player_pull_poses
    db  1,  1,  2,  2,  3,  3,  1,  1
    db  4,  4,  5,  5
    
    ; $02D938
    .player_y_offsets
    db  9,  9, 10, 10, 11, 11, 12, 12
    db 13, 13, 14, 14
}

; ==============================================================================

; $02D945-$02D952 DATA
GoodPullSwitch_Draw_y_offsets:
{
    db 1, 1, 2, 3, 2, 3, 4, 5
    db 6, 7, 6, 7, 7, 7
}

; $02D953-$02D998 LOCAL JUMP LOCATION
GoodPUllSwitch_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    JSL.l Sprite_OAM_AllocateDeferToPlayerLong
    
    LDY.w $0DC0, X
    LDA.w .y_offsets, Y : STA.b $06
    
    LDY.b #$04
    LDA.b $00                      : STA.b ($90), Y
                        LDY.b #$00 : STA.b ($90), Y
    LDA.b $02 : DEC   : LDY.b #$01 : STA.b ($90), Y
    CLC : ADC.b $06   : LDY.b #$05 : STA.b ($90), Y
    LDA.b #$CE        : LDY.b #$06 : STA.b ($90), Y
    LDA.b #$EE        : LDY.b #$02 : STA.b ($90), Y
    LDA.b $05         : LDY.b #$03 : STA.b ($90), Y
                        LDY.b #$07 : STA.b ($90), Y
    
    LDY.b #$02
    LDA.b #$01
    JSL.l Sprite_CorrectOamEntriesLong
    
    RTS
}

; ==============================================================================

; $02D999-$02DA28 LOCAL JUMP LOCATION
PullSwitch_HandleDownPulling:
{
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_player_collision
        STZ.b $27
        STZ.b $28
        
        JSL.l Sprite_RepelDashAttackLong
        
        STZ.b $48
        
        LDA.w $0020 : SEC : SBC.w $0D00, X : CMP.b #$02 : BPL .beta
            CMP.b #$F4 : BMI .A_button_held
                LDA.w $0022 : CMP.w $0D10, X : BPL .delta
                    LDA.w $0D10, X : SEC : SBC.b #$10 : STA.b $22
                    LDA.w $0D30, X       : SBC.b #$00 : STA.b $23
    
    .no_player_collision
    
    RTS
    
    .delta
    
    LDA.w $0D10, X : CLC : ADC.b #$0E : STA.b $22
    LDA.w $0D30, X       : ADC.b #$00 : STA.b $23
    
    RTS
    
    .A_button_held
    
    LDA.w $0D00, X : SEC : SBC.b #$15 : STA.b $20
    LDA.w $0D20, X       : SBC.b #$00 : STA.b $21
    
    RTS
    
    .beta
    
    INC.w $0379
    
    LDA.b $F2 : BPL .epsilon
        LDA.b $F0 : AND.b #$03 : BNE .epsilon
            INC.w $0377
            
            LDA.b $F0 : AND.b #$04 : BEQ .epsilon
                LDA.w $0DC0, X : BNE .epsilon
                    INC.w $0DC0, X
                    
                    LDA.b #$0C : STA.w $0DF0, X
                    
                    LDA.b #$22
                    JSL.l Sound_SetSfx2PanLong
    
    .epsilon
    
    LDA.w $0D00, X : CLC : ADC.b #$09 : STA.b $20
    LDA.w $0D20, X       : ADC.b #$00 : STA.b $21
    
    RTS
}

; ==============================================================================
