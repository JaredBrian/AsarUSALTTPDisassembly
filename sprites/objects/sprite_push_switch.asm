; ==============================================================================

; $0339E6-$0339F9 DATA
    pool 
{
    db 40,  6,  3,  3,  3,  5,  1,  1,  3, 12
    
    db  0,  1,  2,  3,  4,  5,  5,  6,  7,  6
}

; ==============================================================================

; $0339FA-$033A0E JUMP LOCATION
Sprite_PushSwitch:
{
    JSR.w $BB22   ; $033B22 IN ROM
    JSR Sprite_CheckIfActive
    
    LDA.w $0D80, X : CMP.b #$02 : BEQ PushSwitch_Inert
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $BA10 ; = $33A10*
    dw $BA33 ; = $33A33*
}

; ==============================================================================

; $033A0F-$033A0F BRANCH LOCATION
PushSwitch_Inert:
{
    RTS
}

; ==============================================================================

; $033A10-$033A32 JUMP LOCATION
{
    LDA.w $0DB0, X : BEQ .BRANCH_ALPHA
    
    DEC.w $0DA0, X : LDA.w $0DA0, X : BNE .BRANCH_BETA
    
    INC.w $0D80, X
    
    .BRANCH_BETA
    
    LDA.b $1A : AND.b #$03 : BNE .BRANCH_GAMMA
    
    LDA.b #$22 : JSL Sound_SetSfx2PanLong
    
    .BRANCH_GAMMA
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$30 : STA.w $0DA0, X
    
    RTS
}

; $033A33-$033A61 JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    INC.w $0D909090, X : LDY.w $0D909090, X : CPY.b #$0A : BNE .BRANCH_BETA
    
    INC.w $0D8080, X
    
    INC.w $0642
    
    LDA.b #$25 : JSL Sound_SetSfx3PanLong
    
    RTS
    
    .BRANCH_BETA
    
    LDA.w $B9E6, Y : STA.w $0DF0, X
    
    LDA.w $B9F0, Y : STA.w $0DE0, X
    
    LDA.b #$22 : JSL Sound_SetSfx2PanLong
    
    .BRANCH_ALPHA
    
    RTS
}

; $033B22-$033CAB LOCAL JUMP LOCATION
{
    JSR OAM_AllocateDeferToPlayer
    JSR Sprite_PrepOamCoord
    
    LDA.w $0F50, X
    
    LDY.w $0ABD : BEQ .BRANCH_ALPHA
    
    ORA.b #$0E
    
    BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    AND.b #$F1
    
    .BRANCH_BETA
    
    STA.w $0F50, X : STA.b $02
    
    LDA.w $0DA0, X : LSR #2 : AND.b #$03 : STA.b $01
    
    LDA.b #$00 : XBA
    
    LDA.w $0DE0E0, X : ASL A
    
    PHX
    
    REP #$31
    
    PHB
    
    TAY
    
    LDX.w $BB12, Y
    
    LDA.b $90 : ADC.w #$0004 : STA.b $90 : TAY
    
    INC.b $92
    
    LDA.w #$0013
    
    MVN.b $06, $00
    
    PLB
    
    SEP #$20
    
    LDY.b $90
    
    LDA.b $01 : EOR.b #$FF : INC A : CLC : ADC.w $0FA8A8 : TAX
    
          CLC : ADC.w $000000, Y : STA.w $000000, Y
    TXA : CLC : ADC.w $000404, Y : STA.w $000404, Y
    TXA : CLC : ADC.w $000808, Y : STA.w $000808, Y
    TXA : CLC : ADC.w $000C0C, Y : STA.w $000C, Y
    
    LDA.w $0FA8 : CLC : ADC.w $0010, Y : STA.w $0010, Y
    
    LSR.b $01
    
    LDA.w $0FA9 : SEC : SBC.b $01 : TAX
    
          CLC : ADC.w $0001, Y : STA.w $0001, Y
    TXA : CLC : ADC.w $0005, Y : STA.w $0005, Y
    TXA : CLC : ADC.w $0009, Y : STA.w $0009, Y
    TXA : CLC : ADC.w $000D, Y : STA.w $000D, Y
    
    LDA.w $0FA9 : CLC : ADC.w $0011, Y : STA.w $0011, Y
    
    LDA.b $02 : ORA.w $0003, Y : STA.w $0003, Y
    LDA.b $02 : ORA.w $0007, Y : STA.w $0007, Y
    LDA.b $02 : ORA.w $000B, Y : STA.w $000B, Y
    LDA.b $02 : ORA.w $000F, Y : STA.w $000F, Y
    LDA.b $02 : ORA.w $0013, Y : STA.w $0013, Y
    
    REP #$31
    
    LDA.w #$0000 : TAY : STA ($92), Y
    
    INY #2
    
    STA ($92), Y
    
    LDA.w #$0200 : INY : STA ($92), Y
    
    SEP #$30
    
    PLX
    
    LDY.b #$FF
    LDA.b #$04
    
    JSR Sprite_CorrectOamEntries
    
    LDA.w $0F20, X : CMP $EE : BEQ .BRANCH_GAMMA
    
    JMP.w $BCAB   ; $033CAB IN ROM
    
    .BRANCH_GAMMA
    
    STZ.w $0DB0, X
    
    LDA.w $0DE0, X : ASL #4 : TAY
    
    LDA.w $BA62, Y : CLC : ADC.w $0D10, X : STA.b $04
    
    STZ.b $0A
    
    LDA.w $BA62, Y : BPL .BRANCH_DELTA
    
    DEC.b $0A
    
    .BRANCH_DELTA
    
    LDA.b $0A : ADC.w $0D30, X : STA.b $0A
    
    LDA.w $BA63, Y : CLC : ADC.w $0D00, X : STA.b $05
    
    STZ.b $0B
    
    LDA.w $BA63, Y : BPL .BRANCH_EPSILON
    
    DEC.b $0B
    
    .BRANCH_EPSILON
    
    LDA.b $0B : ADC.w $0D20, X : STA.b $0B
    
    LDA.w $0DE0, X : ASL A : TAY
    
    LDA.w $BB02, Y : STA.b $06
    LDA.w $BB03, Y : STA.b $07
    
    JSR.w $F70A   ; $03770A IN ROM
    
    JSR Utility_CheckIfHitBoxesOverlap : BCC .BRANCH_ZETA
    
    LDA.w $0D00, X : PHA : CLC : ADC.b #$13 : STA.w $0D00, X
    LDA.w $0D20, X : PHA : ADC.b #$00 : STA.w $0D20, X
    
    JSR Sprite_DirectionToFacePlayer
    
    PLA : STA.w $0D20, X
    PLA : STA.w $0D00, X
    
    CPY.b #$00 : BNE .BRANCH_THETA
    
    LDA.b $2F : CMP.b #$04 : BNE .BRANCH_THETA
    
    INC.w $0DB0, X
    
    BRA .BRANCH_THETA
    
    .BRANCH_ZETA
    
    JSR Sprite_CheckDamageToPlayer_same_layer : BCC .BRANCH_IOTA
    
    .BRANCH_THETA
    
    JSL Sprite_NullifyHookshotDrag
    
    STZ.b $5E
    
    JSL Sprite_RepelDashAttackLong
    
    ; $033CAB ALTERNATE ENTRY POINT
    .BRANCH_IOTA
    
    RTS
}

; ==============================================================================    
