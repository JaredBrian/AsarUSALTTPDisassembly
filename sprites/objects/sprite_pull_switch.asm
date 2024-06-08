
; ==============================================================================

; $02D6BC-$02D6D3 LONG JUMP LOCATION
Sprite_PullSwitch:
{
    ; Switch / Lever (0x04, 0x05, 0x06, 0x07) That can be pulled in puzzles.
    PHB : PHK : PLB
    
    LDA.w $0E20, X
    
    CMP.b #$07 : BEQ .bad_switches
    CMP.b #$05 : BNE .good_switch
    
    .bad_switches
    
    JSR Sprite_BadPullSwitch
    
    PLB
    
    RTL
    
    .good_switch
    
    JSR Sprite_GoodPullSwitch
    
    PLB
    
    RTL
}

; ==============================================================================

; $02D6D4-$02D72E LOCAL JUMP LOCATION
Sprite_BadPullSwitch:
{
    JSR.w $D743 ; $02D743 IN ROM
    
    LDY.w $0DC0, X : BEQ .alpha
    CPY.b #$0B   : BEQ .alpha
    
    LDA.w $D738, Y : STA.w $0377
    
    LDA.w $0D00, X : SEC : SBC.b #$13 : STA.b $20
    LDA.w $0D20, X : SBC.b #$00 : STA.b $21
    
    LDA.w $0D10, X : STA.b $22
    LDA.w $0D30, X : STA.b $23
    
    LDA.w $0DF0, X : BNE .alpha
    
    INC.w $0DC0, X : LDY.w $0DC0, X : CPY.b #$0B : BNE .beta
    
    LDA.b #$1B : STA.w $012F
    
    LDA.b #$01 : STA.w $0642
    
    .beta
    
    LDA.w $D72D, Y : STA.w $0DF0, X
    
    BRA .alpha
    
    .alpha
    
    LDA.w $0E20, X : CMP.b #$07 : BEQ .up_facing_switch
    
    JSR BadPullDownSwitch_Draw
    
    RTS
    
    .up_facing_switch
    
    JSR BadPullUpSwitch_Draw
    
    RTS
}

; ==============================================================================

; $02D72F-$02D742 DATA
{
    db 8, 24, 
}

; ==============================================================================

; $02D743-$02D7C9 LOCAL JUMP LOCATION
{
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .alpha
    
    STZ.b $27
    STZ.b $28
    
    JSL Sprite_RepelDashAttackLong
    
    STZ.b $48
    
    LDA.w $0020 : SEC : SBC.w $0D00, X : CMP.b #$02 : BPL .beta
    
    CMP.b #$F4 : BMI .gamma
    
    LDA.w $0022 : CMP.w $0D10, X : BPL .delta
    
    LDA.w $0D10, X : SEC : SBC.b #$10 : STA.b $22
    LDA.w $0D30, X : SBC.b #$00 : STA.b $23

    RTS
    
    .delta
    
    LDA.w $0D10, X : CLC : ADC.b #$0E : STA.b $22
    LDA.w $0D30, X : ADC.b #$00 : STA.b $23
    
    .alpha
    
    RTS
    
    .gamma
    
    INC.w $037979
    
    LDA.b $F2 : BPL .epsilon
    
    LDA.b $F0 : AND.b #$03 : BNE .epsilon
    
    LDA.w $0DC0C0, X : BNE .epsilon
    
    INC.w $0DC0C0, X
    
    LDA.b #$08 : STA.w $0DF0F0, X
    
    LDA.b #$22 : JSL Sound_SetSfx2PanLong
    
    .epsilon
    
    LDA.w $0D0000, X : SEC : SBC.b #$15 : STA.b $20
    LDA.w $0D2020, X : SBC.b #$00 : STA.b $21
    
    RTS
    
    .beta
    
    LDA.w $0D00, X : CLC : ADC.b #$09 : STA.b $20
    LDA.w $0D20, X : ADC.b #$00 : STA.b $21
    
    RTS
} 

; ==============================================================================

    ; \wtf This sprite is an over optimized mess in terms of table space
    ; usage.
; $02D7CA-$02D7F8 DATA
{
    .x_offsets
    db -4, 12,  0, -4,  4,  4
    
    .y_offsets
    db -3,  3,  0,  5,  5,  5
    
    .chr
    db $D2, $D2, $C4, $E4, $E4, $E4
    
    .h_flip length 6
    db $40, $00, $00, $40
    
    .properties
    db $00, $00, $02, $02, $02, $02
    
    ; Both draw routines need this data.
    parallel pool BadPullUpSwitch_Draw:
    
    .additional_handle_y_offsets
    db 0, 1, 2, 3, 4, 5, 5
    
    ; $2D7ED
    .additional_handle_y_indices
    db 0, 0, 1, 1, 2, 2, 3, 3, 4, 5, 5, 5
}

; ==============================================================================

; $02D7F9-$02D855 LOCAL JUMP LOCATION
BadPullDownSwitch_Draw:
{
    JSR Sprite2_PrepOamCoord
    JSL Sprite_OAM_AllocateDeferToPlayerLong
    
    LDY.w $0DC0C0, X
    
    LDA .additional_handle_y_indices, Y : TAY
    
    LDA .additional_handle_y_offsets, Y : STA.b $06
    
    PHX
    
    LDX.b #$04
    LDY.b #$00
    
    .next_oam_entry
    
    LDA.b $00 : CLC : ADC.w $D7CA, X          : STA ($90), Y
    LDA.b $02 : CLC : ADC.w $D7D0, X    : INY : STA ($90), Y
    LDA .chr, X                 : INY : STA ($90), Y
    LDA .h_flip, X : ORA.b #$21 : INY : STA ($90), Y
    
    PHY
    
    CPX.b #$02 : BNE .alpha
    
    DEY #2
    
    LDA ($90), Y : SEC : SBC.b $06 : STA ($90), Y
    
    .alpha
    
    TYA : LSR #2 : TAY
    
    LDA .properties, X : STA ($92), Y
    
    PLY : INY
    
    DEX : BPL .next_oam_entry
    
    PLX
    
    LDY.b #$FF
    LDA.b #$04
    
    JSL Sprite_CorrectOamEntriesLong
    
    RTS
}

; ==============================================================================

; $02D856-$02D857 DATA
Pool_BadPullUpSwitch_Draw:
{
    .chr
    db $A2, $A4
}

; ==============================================================================

; $02D858-$02D8B4 LOCAL JUMP LOCATION
BadPullUpSwitch_Draw:
{
    JSR Sprite2_PrepOamCoord
    JSL Sprite_OAM_AllocateDeferToPlayerLong
    
    LDY.w $0DC0, X
    
    LDA .additional_handle_y_indices, Y : TAY
    
    LDA .additional_handle_y_offsets, Y : STA.b $06
                                          STZ.b $07
    
    PHX
    
    LDX.b #$01
    LDY.b #$00
    
    .gamma
    
    REP #$20
    
    LDA.b $00 : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02
    
    CPX.b #$00 : BNE .alpha
    
    SEC : SBC.b $06
    
    .alpha
    
    INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
    
    LDA.b #$F0 : STA ($90), Y
    
    .on_screen_y
    
    LDA .chr, X : INY : STA ($90), Y
    LDA.b $05      : INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b #$02 : ORA.b $0F : STA ($92), Y
    
    PLY : INY
    
    DEX : BPL .gamma
    
    PLX
    
    RTS
}

; ==============================================================================

; $02D8B5-$02D944 LOCAL JUMP LOCATION
Sprite_GoodPullSwitch:
{
    JSR.w $D999 ; $02D999 IN ROM
    
    LDY.w $0DC0, X : BEQ .alpha
    CPY.b #$0D   : BEQ .alpha
    
    LDA .player_pull_poses-1, Y : STA.w $0377
    
    LDA.w $0D00, X : CLC : ADC .player_y_offsets-1, Y : STA.b $20
    LDA.w $0D20, X : ADC.b #$00                 : STA.b $21
    
    LDA.w $0D10, X : STA.b $22
    LDA.w $0D30, X : STA.b $23
    
    LDA.w $0DF0, X : BNE .alpha
    
    INC.w $0DC0, X : LDY.w $0DC0, X : CPY.b #$0D : BNE .set_delay_timer
    
    LDA.w $0E20, X : CMP.b #$06 : BNE .not_trap_switch
    
    ; tell bomb / snake traps in the room to trigger 
    LDA.b #$01 : STA.w $0CF4
    
    ; play error noise
    LDA.b #$3C : STA.w $012E
    
    BRA .set_delay_timer
    
    .not_trap_switch
    
    ; indicates the correct switch was pulled
    LDA.b #$01 : STA.w $0642
    
    ; play puzzle solved noise
    LDA.b #$1B : STA.w $012F
    
    .set_delay_timer
    
    LDA .timers-1, Y : STA.w $0DF0, X
    
    BRA .alpha
    
    .alpha
    
    JSR GoodPUllSwitch_Draw
    
    LDA.w $0F00, X : BEQ .delta
    
    STZ.w $0DC0, X
    
    .delta
    
    ; \wtf Using the RTS as a timer element? Fucking shit...
    .timers length 13
    
    RTS
    
    db  5,  5,  5,  5,  5,  5,  5,  5
    db  5,  5,  5,  5
    
    .player_pull_poses
    db  1,  1,  2,  2,  3,  3,  1,  1
    db  4,  4,  5,  5
    
    .player_y_offsets
    db  9,  9, 10, 10, 11, 11, 12, 12
    db 13, 13, 14, 14
}

; ==============================================================================

; $02D945-$02D952 DATA
Pool_GoodPullSwitch_Draw:
{
    .y_offsets
    db 1, 1, 2, 3, 2, 3, 4, 5
    db 6, 7, 6, 7, 7, 7
}

; ==============================================================================

; $02D953-$02D998 LOCAL JUMP LOCATION
GoodPUllSwitch_Draw:
{
    JSR Sprite2_PrepOamCoord
    JSL Sprite_OAM_AllocateDeferToPlayerLong
    
    LDY.w $0DC0, X
    
    LDA .y_offsets, Y : STA.b $06
    
    LDY.b #$04
    
    LDA.b $00                      : STA ($90), Y
                      LDY.b #$00 : STA ($90), Y
    LDA.b $02 : DEC A : LDY.b #$01 : STA ($90), Y
    CLC : ADC.b $06         : LDY.b #$05 : STA ($90), Y
    LDA.b #$CE      : LDY.b #$06 : STA ($90), Y
    LDA.b #$EE      : LDY.b #$02 : STA ($90), Y
    LDA.b $05         : LDY.b #$03 : STA ($90), Y
                      LDY.b #$07 : STA ($90), Y
    
    LDY.b #$02
    LDA.b #$01
    
    JSL Sprite_CorrectOamEntriesLong
    
    RTS
}

; ==============================================================================

; $02D999-$02DA28 LOCAL JUMP LOCATION
{
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_player_collision
    
    STZ.b $27
    STZ.b $28
    
    JSL Sprite_RepelDashAttackLong
    
    STZ.b $48
    
    LDA.w $0020 : SEC : SBC.w $0D00, X : CMP.b #$02 : BPL .beta
    
    CMP.b #$F4 : BMI .A_button_held
    
    LDA.w $0022 : CMP.w $0D10, X : BPL .delta
    
    LDA.w $0D10, X : SEC : SBC.b #$10 : STA.b $22
    LDA.w $0D30, X : SBC.b #$00 : STA.b $23
    
    .no_player_collision
    
    RTS
    
    .delta
    
    LDA.w $0D10, X : CLC : ADC.b #$0E : STA.b $22
    LDA.w $0D30, X : ADC.b #$00 : STA.b $23
    
    RTS
    
    .A_button_held
    
    LDA.w $0D00, X : SEC : SBC.b #$15 : STA.b $20
    LDA.w $0D20, X : SBC.b #$00 : STA.b $21
    
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
    
    LDA.b #$22 : JSL Sound_SetSfx2PanLong
    
    .epsilon
    
    LDA.w $0D00, X : CLC : ADC.b #$09 : STA.b $20
    LDA.w $0D20, X : ADC.b #$00 : STA.b $21
    
    RTS
}

; ==============================================================================

