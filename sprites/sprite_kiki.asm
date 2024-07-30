
; ==============================================================================

; $0F62E9-$0F62EE DATA
{
    ; TODO: name this routine / pool.
    .x_speeds length 4
    db  0,  0
    
    .y_speeds
    db -9,  9,  0,  0
}

; ==============================================================================

; $0F62EF-$0F62FD JUMP LOCATION
Sprite_Kiki:
{
    LDA.w $0E80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Kiki_LyingInWait
    dw $E4C9 ; = $F64C9*
    dw $E3AF ; = $F63AF*
    dw Kiki_Fleeing
}

; ==============================================================================

; $0F62FE-$0F63AE JUMP LOCATION
Kiki_Fleeing:
{
    JSR Kiki_Draw
    JSR Sprite3_CheckIfActive
    
    LDA.w $0F70, X : BNE .in_air
    
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.w #$0C98 : CMP.w #$00D0 : BCS .too_far_away
    
    LDA.w $0FDA : SEC : SBC.w #$06A5 : CMP.w #$00D0 : BCS .too_far_away
    
    LDA.w #$FFFF : STA.b $01
    
    .too_far_away
    .in_air
    
    SEP #$30
    
    ; BUG: How is $03 relevant here? This seems well... not good.
    LDA.b $01 : ORA.b $03 : BEQ .dont_self_terminate_yet
    
    STZ.w $0DD0, X
    
    .dont_self_terminate_yet
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    JSR Sprite3_MoveXyz
    
    LDA.w $0F70, X : BPL .no_ground_bounce
    
    STZ.w $0F70, X
    
    JSL GetRandomInt : AND.b #$0F : ORA.b #$10 : STA.w $0F80, X
    
    .no_ground_bounce
    
    LDA.b #$F5 : STA.b $04
    LDA.b #$0C : STA.b $05
    
    LDA.b #$FE : STA.b $06
    LDA.b #$06 : STA.b $07
    
    LDA.b #$10 : JSL Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : ASL A : STA.w $0D40, X
    
    LDA.b $01 : ASL A : STA.w $0D50, X
    
    LDA.w $02F2 : AND.b #$FC : STA.w $02F2
    
    LDA.b $00 : BPL .x_speed_positive
    
    EOR.b #$FF : INC A : STA.b $00
    
    .x_speed_positive
    
    LDA.b $01 : BPL .y_speed_positive
    
    EOR.b #$FF : INC A
    
    .y_speed_positive
    
    CMP $00 : BCC .x_speed_larger
    
    LDA.w $0D50, X : ROL #2 : AND.b #$01 : EOR.b #$03
    
    BRA .animate
    
    .x_speed_larger
    
    LDA.w $0D40, X : ROL #2 : AND.b #$01 : EOR.b #$01
    
    .animate
    
    STA.w $0DE0, X
    
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F63AF-$0F63E7 JUMP LOCATION
{
    LDA.w $0D80, X : DEC #2 : BMI .BRANCH_ALPHA
    
    JSR Kiki_Draw
    
    .BRANCH_ALPHA
    
    JSR Sprite3_CheckIfActive
    JSR Sprite3_MoveXyz
    
    DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .BRANCH_BETA
    
    STZ.w $0F80, X
    STZ.w $0F70, X
    
    .BRANCH_BETA
    
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $E3E8 ; = $F63E8*
    dw $E3F4 ; = $F63F4*
    dw $E433 ; = $F6433*
    dw $E465 ; = $F6465*
    dw $E476 ; = $F6476*
}

; $0F63E8-$0F63F3 JUMP LOCATION
{
    LDA.b #$1E
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
}

; $0F63F4-$0F6432 JUMP LOCATION
{
    LDA.w $1CE8 : BNE .player_declined
    
    LDA.b #$0A
    LDY.b #$00
    
    ; $0F739E IN ROM
    JSR.w $F39E : BCC .cant_afford
    
    ; "Ki ki ki ki! Good choice! I will accompany you for a while..."
    LDA.b #$1F
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    LDA.w $02F2 : ORA.b #$03 : STA.w $02F2
    
    STZ.w $0DD0, X
    
    RTS
    
    .cant_afford
    .player_declined
    
    ; "Ki ki! Harumph! I have no reason to talk to you, then. Bye bye!..."
    LDA.b #$20
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    LDA.w $02F2 : AND.b #$FC : STA.w $02F2
    
    LDA.b #$00 : STA.l $7EF3CC
    
    INC.w $0D80, X
    
    INC.w $02E4
    
    RTS
}

; $0F6433-$0F6464 JUMP LOCATION
{
    INC.w $0D80, X
    
    LDA.b #$F5 : STA.b $04
    LDA.b #$0C : STA.b $05
    
    LDA.b #$FE : STA.b $06
    LDA.b #$06 : STA.b $07
    
    LDA.b #$09 : JSL Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    
    LDA.b $01 : STA.w $0D50, X
    
    ASL A : ROL A : AND.b #$01 : EOR.b #$03 : STA.w $0DE0, X
    
    LDA.b #$20 : STA.w $0DF0, X
    
    RTS
}

; $0F6465-$0F6475 JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    INC.w $0D80, X
    
    LDA.b #$10 : STA.w $0F80, X
                 STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F6476-$0F6486 JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    LDA.w $0F70, X : BNE .BRANCH_ALPHA
    
    STZ.w $0DD0, X
    
    STZ.w $02E4
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $0F6487-$0F64C8 JUMP LOCATION
Kiki_LyingInWait:
{
    JSL Sprite_PrepOamCoordLong
    JSR Sprite3_CheckIfActive
    
    ; See if Link is a bunny.
    LDA.w $02E0 : BNE .dont_appear
    
    ; If Link is invincible don't show up either.
    LDA.w $037B : ORA.w $031F : BNE .dont_appear
    
    ; If Kiki is already following you then do nothing.
    LDA.l $7EF3CC : CMP.b #$0A : BEQ .dont_appear
    
    PHX
    
    LDX.b $8A
    
    ; If the Dark Palace has already been opened, then also do nothing.
    LDA.l $7EF280, X : PLX : AND.b #$20 : BNE .dont_appear
    
    ; Detect if Link and Kiki collide within some space.
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .dont_appear
    
    LDA.b #$0A : STA.l $7EF3CC
    
    PHX
    
    STZ.w $02F9
    
    JSL Tagalong_LoadGfx
    JSL Tagalong_Init
    
    PLX
    
    .dont_appear
    
    RTS
}

; ==============================================================================

; $0F64C9-$0F64FC JUMP LOCATION
{
    JSR Kiki_Draw
    JSR Sprite3_CheckIfActive
    JSR Sprite3_MoveXyz
    
    DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .BRANCH_ALPHA
    
    STZ.w $0F80, X
    STZ.w $0F70, X
    
    .BRANCH_ALPHA
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $E4FD ; = $F64FD*
    dw $E509 ; = $F6509*
    dw $E582 ; = $F6582*
    dw $E539 ; = $F6539*
    dw $E582 ; = $F6582*
    dw $E539 ; = $F6539*
    dw $E582 ; = $F6582*
    dw $E5EE ; = $F65EE*
    dw $E640 ; = $F6640*
    dw $E657 ; = $F6657*
    dw $E66A ; = $F666A* (RTS)
}

; $0F64FD-$0F6508 JUMP LOCATION
{
    LDA.b #$1B
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
}

; $0F6509-$0F6536 JUMP LOCATION
{
    LDA.w $1CE8 : BEQ .player_agreed
    
    .cant_afford
    
    LDA.b #$1C
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    LDA.b #$03 : STA.w $0E80, X
    
    RTS
    
    .player_agreed
    
    LDA.b #$64
    LDY.b #$00
    
    ; $0F739E IN ROM
    JSR.w $F39E : BCC .cant_afford
    
    LDA.b #$1D
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    INC.w $02E4
    
    INC.w $0D80, X
    
    STZ.w $0DE0, X
    
    RTS
}

; ==============================================================================

; $0F6537-$0F6538 DATA
{
    ; TODO: Name this routine / pool.
    .jump_heights
    db 32, 28
}

; ==============================================================================

; $0F6539-$0F6575 JUMP LOCATION
{
    LDA.w $0E00, X : BNE .BRANCH_ALPHA
    
    LDA.w $0D80, X : INC.w $0D80, X : LSR A : AND.b #$01 : TAY
    
    LDA .jump_heights, Y : STA.w $0F80, X
    
    LDA.b #$20 : JSL Sound_SetSfx2PanLong
    
    LDA.w $0D80, X : LSR A : AND.b #$01 : ORA.b #$04 : STA.w $0DE0, X
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.w $0D80, X : LSR A : AND.b #$01 : ORA.b #$06 : STA.w $0DE0, X
    
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F6576-$0F6581 DATA
{
    .y_targets
    db $61, $06, $4C, $06, $24, $06
    
    .x_targets
    db $4F, $0F, $70, $0F, $5D, $0F
}

; ==============================================================================

; $0F6582-$0F65E8 JUMP LOCATION
{
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    LDA.w $0D80, X : SEC : SBC.b #$02 : TAY
    
    LDA.w $E57C, Y : SEC : SBC.w $0D10, X : CLC : ADC.b #$02 : CMP.b #$04 : BCS .BRANCH_ALPHA
    
    LDA.w $E576, Y : SEC : SBC.w $0D00, X : CLC : ADC.b #$02 : CMP.b #$04 : BCS .BRANCH_ALPHA
    
    INC.w $0D80, X
    
    STZ.w $0D40, X
    STZ.w $0D50, X
    
    LDA.b #$20 : STA.w $0E00, X
    
    LDA.b #$21 : JSL Sound_SetSfx2PanLong
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.w $E57C, Y : STA.b $04
    LDA.w $E57D, Y : STA.b $05
    
    LDA.w $E576, Y : STA.b $06
    LDA.w $E577, Y : STA.b $07
    
    LDA.b #$09 : JSL Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    
    LDA.b $01 : STA.w $0D50, X
    
    RTS
}

; ==============================================================================

; $0F65E9-$0F65ED DATA
{
    ; TODO: Name this routine / pool.
    .directions
    db 2, 1, -1
    
    .timers
    db $52, $00
}

; ==============================================================================

; $0F65EE-$0F663F JUMP LOCATION
{
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    LDA.w $0F70, X : BNE .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    LDA.w $0D90, X : TAY
    
    INC.w $0D90, X
    
    LDA .directions, Y : BMI .BRANCH_BETA
    
    PHA : STA.w $0DE0, X
    
    LDA .timers, Y : STA.w $0DF0, X
    
    PLA : TAY
    
    LDA .x_speeds, Y : STA.w $0D50, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    .BRANCH_ALPHA
    
    RTS
    
    .BRANCH_BETA
    
    INC.w $0D80, X
    
    STZ.w $0D50, X
    STZ.w $0D40, X
    
    LDA.b #$01 : STA.w $04C6
    
    STZ.b $B0
    STZ.b $C8
    
    STZ.w $0DE0, X
    
    STZ.w $02E4
    
    RTS
}

; $0F6640-$0F6656 JUMP LOCATION
{
    LDA.b #$08 : STA.w $0DE0, X
    
    STZ.w $0DC0, X
    
    JSL GetRandomInt : AND.b #$0F : ADC.b #$10 : STA.w $0F80, X
    
    INC.w $0D80, X
    
    RTS
}

; $0F6657-$0F666A JUMP LOCATION
{
    LDA.w $0F80, X : BPL .BRANCH_ALPHA
    
    LDA.w $0F70, X : BNE .BRANCH_ALPHA
    
    INC.w $0D80, X
    
    LDA.b #$25 : JSL Sound_SetSfx3PanLong
    
    .BRANCH_ALPHA
    
    RTS
} 

; ==============================================================================

    ; \covered($F666B-$F6EEE)
    
; $0F666B-$0F6679 LONG JUMP LOCATION
Kiki_InitiatePalaceOpeningProposal:
{
    JSR Kiki_TransitionFromTagalong
    
    LDA.b #$01 : STA.w $0E80, Y
    
    LDA.b #$00 : STA.l $7EF3CC
    
    RTL
}

; ==============================================================================

; $0F667A-$0F66C6 LOCAL JUMP LOCATION
Kiki_TransitionFromTagalong:
{
    PHA
    
    LDA.b #$B6 : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    PLA : PHX
    
    TAX
    
    LDA.w $1A64, X : AND.b #$03 : STA.w $0EB0, Y : STA.w $0DE0, Y
    
    LDA.w $1A00, X : CLC : ADC.b #$02 : STA.w $0D00, Y
    LDA.w $1A14, X : ADC.b #$00 : STA.w $0D20, Y
    
    LDA.w $1A28, X : CLC : ADC.b #$02 : STA.w $0D10, Y
    LDA.w $1A3C, X : ADC.b #$00 : STA.w $0D30, Y
    
    LDA.b $EE    : STA.w $0F20, Y
    
    LDA.b #$01 : STA.w $0BA0, Y
    INC A      : STA.w $0F20, Y
    
    STZ.b $5E
    
    PLX
    
    RTS
    
    .spawn_failed
    
    PLA
    
    RTS
}

; ==============================================================================

; $0F66C7-$0F66CF LONG JUMP LOCATION
Kiki_InitiateFirstBeggingSequence:
{
    JSR Kiki_TransitionFromTagalong
    
    LDA.b #$02 : STA.w $0E80, Y
    
    RTL
}

; ==============================================================================

; $0F66D0-$0F66E8 LONG JUMP LOCATION
Kiki_AbandonDamagedPlayer:
{
    JSR Kiki_TransitionFromTagalong
    
    LDA.b #$01 : STA.w $0F70, Y
    
    LDA.b #$10 : STA.w $0F80, Y
    
    LDA.b #$03 : STA.w $0E80, Y
       
    LDA.b #$00 : STA.l $7EF3CC
    
    RTL
}

; ==============================================================================

; $0F66E9-$0F6858 DATA
Pool_Kiki_Draw:
{
    .source_offsets
    dw $C020, $C020, $A000, $A000, $8040, $6040, $8040, $6040
    
    .oam_groups
    dw  0, -6 : db $20, $00, $00, $02
    dw  0,  0 : db $22, $00, $00, $02
    dw  0, -6 : db $20, $00, $00, $02
    dw  0,  0 : db $22, $40, $00, $02
    dw  0, -6 : db $20, $00, $00, $02
    dw  0,  0 : db $22, $00, $00, $02
    dw  0, -6 : db $20, $00, $00, $02
    dw  0,  0 : db $22, $40, $00, $02
    dw -1, -6 : db $20, $00, $00, $02
    dw  0,  0 : db $22, $00, $00, $02
    dw -1, -6 : db $20, $00, $00, $02
    dw  0,  0 : db $22, $00, $00, $02
    dw  1, -6 : db $20, $40, $00, $02
    dw  0,  0 : db $22, $40, $00, $02
    dw  1, -6 : db $20, $40, $00, $02
    dw  0,  0 : db $22, $40, $00, $02
    dw  0, -6 : db $CE, $01, $00, $02
    dw  0,  0 : db $EE, $01, $00, $02
    dw  0, -6 : db $CE, $01, $00, $02
    dw  0,  0 : db $EE, $01, $00, $02
    dw  0, -6 : db $CE, $41, $00, $02
    dw  0,  0 : db $EE, $41, $00, $02
    dw  0, -6 : db $CE, $41, $00, $02
    dw  0,  0 : db $EE, $41, $00, $02
    dw -1, -6 : db $CE, $01, $00, $02
    dw  0,  0 : db $EC, $01, $00, $02
    dw -1, -6 : db $CE, $41, $00, $02
    dw  0,  0 : db $EC, $01, $00, $02
    dw  1, -6 : db $CE, $41, $00, $02
    dw  0,  0 : db $EC, $41, $00, $02
    dw  1, -6 : db $CE, $01, $00, $02
    dw  0,  0 : db $EC, $41, $00, $02
    
    .oam_groups_2
    dw 0, -6 : db $CA, $01, $00, $00
    dw 8, -6 : db $CA, $41, $00, $00
    dw 0,  2 : db $DA, $01, $00, $00
    dw 8,  2 : db $DA, $41, $00, $00
    dw 0, 10 : db $CB, $01, $00, $00
    dw 8, 10 : db $CB, $41, $00, $00
    dw 0, -6 : db $DB, $01, $00, $00
    dw 8, -6 : db $DB, $41, $00, $00
    dw 0,  2 : db $CC, $01, $00, $00
    dw 8,  2 : db $CC, $41, $00, $00
    dw 0, 10 : db $DC, $01, $00, $00
    dw 8, 10 : db $DD, $41, $00, $00     
}

; ==============================================================================

; $0F6859-$0F68B5 LOCAL JUMP LOCATION
Kiki_Draw:
{
    ; TODO: Figure out the symantics of $0DE0 for this sprite.
    LDA.w $0DE0, X : CMP.b #$08 : BCS .unknown
    
    LDA.w $0DE0, X : ASL A : ADC.w $0DC0, X : ASL A : TAY
    
    LDA .source_offsets + 0, Y : STA.w $0AE8
    LDA .source_offsets + 1, Y : STA.w $0AEA
    
    TYA : ASL #3
    
    ADC.b #(.oam_groups >> 8)               : STA.b $08
    LDA.b #(.oam_groups >> 8)  : ADC.b #$00 : STA.b $09
    
    LDA.b #$02 : JSR Sprite3_DrawMultiple
    
    LDA.w $0F00, X : BNE .paused
    
    JSL Sprite_DrawShadowLong
    
    .paused
    
    RTS
    
    .unknown
    
    LDA.w $0DC0, X : ASL A : ADC.w $0DC0, X : ASL #4
    
    ADC.b #(.oam_groups_2 >> 0)              : STA.b $08
    LDA.b #(.oam_groups_2 >> 8) : ADC.b #$00 : STA.b $09
    
    LDA.b #$06
    
    JSR Sprite3_DrawMultiple
    
    LDA.w $0F00, X : BNE .paused_2
    
    JSL Sprite_DrawShadowLong
    
    .paused_2
    
    RTS
}

; ==============================================================================
