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
    JSR $BB22   ; $033B22 IN ROM
    JSR Sprite_CheckIfActive
    
    LDA $0D80, X : CMP.b #$02 : BEQ PushSwitch_Inert
    
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
    LDA $0DB0, X : BEQ .BRANCH_ALPHA
    
    DEC $0DA0, X : LDA $0DA0, X : BNE .BRANCH_BETA
    
    INC $0D80, X
    
    .BRANCH_BETA
    
    LDA $1A : AND.b #$03 : BNE .BRANCH_GAMMA
    
    LDA.b #$22 : JSL Sound_SetSfx2PanLong
    
    .BRANCH_GAMMA
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$30 : STA $0DA0, X
    
    RTS
}

; $033A33-$033A61 JUMP LOCATION
{
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    INC $0D90, X : LDY $0D90, X : CPY.b #$0A : BNE .BRANCH_BETA
    
    INC $0D80, X
    
    INC $0642
    
    LDA.b #$25 : JSL Sound_SetSfx3PanLong
    
    RTS
    
    .BRANCH_BETA
    
    LDA.w $B9E6, Y : STA $0DF0, X
    
    LDA.w $B9F0, Y : STA $0DE0, X
    
    LDA.b #$22 : JSL Sound_SetSfx2PanLong
    
    .BRANCH_ALPHA
    
    RTS
}

; $033B22-$033CAB LOCAL JUMP LOCATION
{
    JSR OAM_AllocateDeferToPlayer
    JSR Sprite_PrepOamCoord
    
    LDA $0F50, X
    
    LDY $0ABD : BEQ .BRANCH_ALPHA
    
    ORA.b #$0E
    
    BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    AND.b #$F1
    
    .BRANCH_BETA
    
    STA $0F50, X : STA $02
    
    LDA $0DA0, X : LSR #2 : AND.b #$03 : STA $01
    
    LDA.b #$00 : XBA
    
    LDA $0DE0, X : ASL A
    
    PHX
    
    REP #$31
    
    PHB
    
    TAY
    
    LDX.w $BB12, Y
    
    LDA $90 : ADC.w #$0004 : STA $90 : TAY
    
    INC $92
    
    LDA.w #$0013
    
    MVN $06, $00
    
    PLB
    
    SEP #$20
    
    LDY $90
    
    LDA $01 : EOR.b #$FF : INC A : CLC : ADC $0FA8 : TAX
    
          CLC : ADC $0000, Y : STA $0000, Y
    TXA : CLC : ADC $0004, Y : STA $0004, Y
    TXA : CLC : ADC $0008, Y : STA $0008, Y
    TXA : CLC : ADC $000C, Y : STA $000C, Y
    
    LDA $0FA8 : CLC : ADC $0010, Y : STA $0010, Y
    
    LSR $01
    
    LDA $0FA9 : SEC : SBC $01 : TAX
    
          CLC : ADC $0001, Y : STA $0001, Y
    TXA : CLC : ADC $0005, Y : STA $0005, Y
    TXA : CLC : ADC $0009, Y : STA $0009, Y
    TXA : CLC : ADC $000D, Y : STA $000D, Y
    
    LDA $0FA9 : CLC : ADC $0011, Y : STA $0011, Y
    
    LDA $02 : ORA $0003, Y : STA $0003, Y
    LDA $02 : ORA $0007, Y : STA $0007, Y
    LDA $02 : ORA $000B, Y : STA $000B, Y
    LDA $02 : ORA $000F, Y : STA $000F, Y
    LDA $02 : ORA $0013, Y : STA $0013, Y
    
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
    
    LDA $0F20, X : CMP $EE : BEQ .BRANCH_GAMMA
    
    JMP $BCAB   ; $033CAB IN ROM
    
    .BRANCH_GAMMA
    
    STZ $0DB0, X
    
    LDA $0DE0, X : ASL #4 : TAY
    
    LDA.w $BA62, Y : CLC : ADC $0D10, X : STA $04
    
    STZ $0A
    
    LDA.w $BA62, Y : BPL .BRANCH_DELTA
    
    DEC $0A
    
    .BRANCH_DELTA
    
    LDA $0A : ADC $0D30, X : STA $0A
    
    LDA.w $BA63, Y : CLC : ADC $0D00, X : STA $05
    
    STZ $0B
    
    LDA.w $BA63, Y : BPL .BRANCH_EPSILON
    
    DEC $0B
    
    .BRANCH_EPSILON
    
    LDA $0B : ADC $0D20, X : STA $0B
    
    LDA $0DE0, X : ASL A : TAY
    
    LDA.w $BB02, Y : STA $06
    LDA.w $BB03, Y : STA $07
    
    JSR $F70A   ; $03770A IN ROM
    
    JSR Utility_CheckIfHitBoxesOverlap : BCC .BRANCH_ZETA
    
    LDA $0D00, X : PHA : CLC : ADC.b #$13 : STA $0D00, X
    LDA $0D20, X : PHA : ADC.b #$00 : STA $0D20, X
    
    JSR Sprite_DirectionToFacePlayer
    
    PLA : STA $0D20, X
    PLA : STA $0D00, X
    
    CPY.b #$00 : BNE .BRANCH_THETA
    
    LDA $2F : CMP.b #$04 : BNE .BRANCH_THETA
    
    INC $0DB0, X
    
    BRA .BRANCH_THETA
    
    .BRANCH_ZETA
    
    JSR Sprite_CheckDamageToPlayer_same_layer : BCC .BRANCH_IOTA
    
    .BRANCH_THETA
    
    JSL Sprite_NullifyHookshotDrag
    
    STZ $5E
    
    JSL Sprite_RepelDashAttackLong
    
    ; $033CAB ALTERNATE ENTRY POINT
    .BRANCH_IOTA
    
    RTS
}

; ==============================================================================    
