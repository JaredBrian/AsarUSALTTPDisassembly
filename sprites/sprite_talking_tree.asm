
; ==============================================================================

; $0EF943-$0EF94A LONG JUMP LOCATION
Sprite_TalkingTreeLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_TalkingTree
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EF94B-$0EF955 LOCAL JUMP LOCATION
Sprite_TalkingTree:
{
    LDA.w $0E80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw $F956 ; = $EF956*
    dw $FB0A ; = $EFB0A*
}

; ==============================================================================

; $0EF956-$0EF96D JUMP LOCATION
{
    JSR.w $FADB ; $0EFADB IN ROM
    JSR.w Sprite4_CheckIfActive
    
    STZ.w $0F60, X
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw $F96E ; = $EF96E*
    dw $F99C ; = $EF99C*
    dw $F9B4 ; = $EF9B4*
    dw $F9E2 ; = $EF9E2*
}

; ==============================================================================

; $0EF96E-$0EF99B JUMP LOCATION
{
    STZ.w $0DC0, X
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .BRANCH_ALPHA
    
    JSL.l Player_HaltDashAttackLong
    
    LDA.b #$10 : STA.b $46
    
    LDA.b #$30
    
    JSL.l Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA.b $00 : STA.b $27
    LDA.b $01 : STA.b $28
    
    LDA.b #$32 : JSL.l Sound_SetSfx3PanLong
    
    INC.w $0D80, X
    
    LDA.b #$30 : STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0EF99C-$0EF9AF JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    INC.w $0D80, X
    
    LDA.b #$08 : STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    LSR A : AND.b #$03 : STA.w $0DC0, X

    RTS
}

; ==============================================================================

; $0EF9B0-$0EF9B3 DATA
{
    ; TODO: Name this routine / pool
    
    .animation_states
    db 0, 2, 3, 1
}

; ==============================================================================

; $0EF9B4-$0EF9D1 JUMP LOCATION
{
    LDA.w $0DF0, X : LSR A : TAY
    
    LDA.w .animation_states, X : STA.w $0DC0, X
    
    LDA.w $0DF0, X : CMP.b #$07 : BNE .BRANCH_ALPHA
    
    JSR.w $FA4E ; $0EFA4E IN ROM
    
    .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BNE .BRANCH_BETA
    
    INC.w $0D80, X
    
    .BRANCH_BETA
    
    RTS
} 

; ==============================================================================

; $0EF9D2-$0EF9E1 DATA
{
    ; TODO: Name this routine / pool
    
    .animation_states
    db  1,  2,  3,  1,  3,  1,  2,  3
    
    .timers
    db 13, 13, 13, 11, 11,  6, 16,  8
}

; ==============================================================================

; $0EF9E2-$0EFA00 JUMP LOCATION
{
    JSR.w $FA03 ; $0EFA03 IN ROM
    
    LDA.w $0DF0, X : BNE .countingDown
    
    LDA.w $0DA0, X : INC A : AND.b #$07 : STA.w $0DA0, X : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    LDA.w .timers, Y : STA.w $0DF0, X
    
    .countingDown
    
    RTS
}

; ==============================================================================

; $0EFA01-$0EFA02 DATA
{
    ; TODO: Name this routine / pool.
    .message_ids
    db $82, $7D
}

; ==============================================================================

; $0EFA03-$0EFA2A LOCAL JUMP LOCATION
{
    LDA.b #$07 : STA.w $0F6060, X
    
    LDA.w $0D9090, X : BNE .BRANCH_EFA33
    
    LDA.w $0D10, X : LSR #4 : AND.b #$01 : EOR.b #$01 : STA.w $0D90, X : TAY
    
    LDA.w .message_ids, Y
    LDY.b #$00
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCS .didnt_solicit
    
    STZ.w $0D90, X
    
    .didnt_solicit
    
    RTS
}

; ==============================================================================

; $0EFA2B-$0EFA32 DATA
{
    ; TODO: Label routine / pool.
    
    .message_ids
    db $7E, $7F, $80, $81
    
    .areas
    db $58, $5D, $72, $6B
}

; ==============================================================================

; $0EFA33-$0EFA4D BRANCH LOCATION
{
    LDY.b #$00
    
    LDA.b $8A
    
    .BRANCH_BETA
    
    CMP .areas, Y : BEQ .BRANCH_ALPHA
    
    INY : BEQ .BRANCH_ALPHA
    
    BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.w .message_ids, Y
    
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D90, X
    
    RTS
}

; ==============================================================================

; $0EFA4E-$0EFA7A LOCAL JUMP LOCATION
{
    LDA.b #$4A : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL.l Sprite_TransmuteToEnemyBomb
    JSL.l Sprite_SetSpawnedCoords
    
    LDA.b $02 : CLC : ADC.b #$28 : STA.b $08
    LDA.b $03 : ADC.b #$00 : STA.b $03
    
    LDA.b #$40 : STA.w $0E00, Y
    
    LDA.b #$18 : STA.w $0D40, Y
    
    LDA.b #$12 : STA.w $0F80, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0EFADB-$0EFAFA LOCAL JUMP LOCATION
{
    LDA.w $0DC0, X : DEC A : BMI .BRANCH_ALPHA
    
    ASL #5     : ADC.b #$7B : STA.b $08
    LDA.b #$FA : ADC.b #$00 : STA.b $09
    
    LDA.b #$04 : STA.b $06
                 STZ.b $07
    
    JSL.l Sprite_DrawMultiple_player_deferred
    
    .BRANCH_ALPHA
    
    RTS
} 

; ==============================================================================

; $0EFAFB-$0EFB09 DATA
{
    ; TODO: Add labels.
    db  9, -9
    db  0, -1
    
    db -2, -1,  0,  1,  2
    db -1, -1,  0,  0,  0
}

; ==============================================================================

; $0EFB0A-$0EFB85 JUMP LOCATION
{
    JSL.l Sprite_PrepAndDrawSingleSmallLong
    JSR.w Sprite4_CheckIfActive
    
    LDY.w $0EB0, X
    
    LDA.w $0D90, X : CLC : ADC.w $FAFB, Y : STA.w $0D10, X
    LDA.w $0DA0, X : ADC.w $FAFD, Y : STA.w $0D30, X
    
    LDA.w $0DB0, X : STA.w $0D00, X
    LDA.w $0E90, X : STA.w $0D20, X
    
    LDA.b #$02
    
    JSL.l Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA.b $00 : BMI .BRANCH_ALPHA
    
    LDA.b $01 : CLC : ADC.b #$02 : STA.w $0DE0, X
    
    BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.w $0DE0, X : CMP.b #$02 : BEQ .BRANCH_BETA
    
    ROL A : AND.b #$01 : TAY
    
    LDA.w $0DE0, X : CLC : ADC.w $8000, Y : STA.w $0DE0, X
    
    .BRANCH_BETA
    
    LDY.w $0DE0, X
    
    LDA.w $0D90, X : CLC : ADC.w $FAFF, Y : STA.w $0D10, X
    LDA.w $0DA0, X : ADC.w $FB04, Y : STA.w $0D30, X
    
    LDA.w $0DB0, X : CLC : ADC.w $FB05, Y : STA.w $0D00, X
    LDA.w $0E90, X : ADC.w $FB05, Y : STA.w $0D20, X
    
    RTS
}

; ==============================================================================

; $0EFB86-$0EFB89 DATA
Pool_TalkingTree_SpawnEyes:
{
    .x_offsets_low
    db $FC, $0E
    
    .x_offsets_high
    db $FF, $00
}

; ==============================================================================

; $0EFB8A-$0EFBCB LONG JUMP LOCATION
TalkingTree_SpawnEyes:
{
    PHX : PHA
    
    LDA.b #$25
    
    JSL.l Sprite_SpawnDynamically
    
    PLA : STA.w $0EB0, Y : TAX
    
    LDA.b $00 : CLC : ADC.l .x_offsets_low, X  : STA.w $0D10, Y : STA.w $0D90, Y
    LDA.b $01 : ADC.l .x_offsets_high, X : STA.w $0D30, Y : STA.w $0DA0, Y
    
    LDA.b $02 : CLC : ADC.b #$F5 : STA.w $0D00, Y : STA.w $0DB0, Y
    LDA.b $03 : ADC.b #$FF : STA.w $0D20, Y : STA.w $0E90, Y
    
    LDA.b #$01 : STA.w $0E80, Y
    
    PLX
    
    RTL
}

