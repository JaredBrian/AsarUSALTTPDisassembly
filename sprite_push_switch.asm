; ==============================================================================

; $0339E6-$0339F9 DATA
Pool_WaterSwitch:
{
    ; $0339E6
    .Timer
    db 40,  6,  3,  3,  3,  5,  1,  1,  3, 12
    
    ; $0339F0
    .Position
    db  0,  1,  2,  3,  4,  5,  5,  6,  7,  6
}

; ==============================================================================

; $0339FA-$033A0F JUMP LOCATION
Sprite_PushSwitch:
{
    JSR.w WaterSwitch_Main
    JSR.w Sprite_CheckIfActive
    
    LDA.w $0D80, X : CMP.b #$02 : BEQ .Inert
        JSL.l UseImplicitRegIndexedLocalJumpTable
        dw WaterSwitch_Untoggled   ; 0x00 - $BA10
        dw WaterSwitch_ReleaseGate ; 0x01 - $BA33

    .Inert

    RTS
}

; ==============================================================================

; $033A10-$033A32 JUMP LOCATION
WaterSwitch_Untoggled:
{
    LDA.w $0DB0, X : BEQ .BRANCH_ALPHA
        DEC.w $0DA0, X : LDA.w $0DA0, X : BNE .BRANCH_BETA
            INC.w $0D80, X
        
        .BRANCH_BETA
        
        LDA.b $1A : AND.b #$03 : BNE .BRANCH_GAMMA
            LDA.b #$22 : JSL.l Sound_SetSfx2PanLong
        
        .BRANCH_GAMMA
        
        RTS
        
    .BRANCH_ALPHA
    
    LDA.b #$30 : STA.w $0DA0, X
    
    RTS
}

; $033A33-$033A61 JUMP LOCATION
WaterSwitch_ReleaseGate:
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        INC.w $0D90, X : LDY.w $0D90, X : CPY.b #$0A : BNE .BRANCH_BETA
            INC.w $0D80, X
            
            INC.w $0642
            
            LDA.b #$25 : JSL.l Sound_SetSfx3PanLong
            
            RTS
        
        .BRANCH_BETA
        
        LDA.w Pool_WaterSwitch_Timer, Y    : STA.w $0DF0, X
        LDA.w Pool_WaterSwitch_Position, Y : STA.w $0DE0, X
        
        LDA.b #$22 : JSL.l Sound_SetSfx2PanLong
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $033A62- DATA
WaterSwitch_OAMData:
{
    ; $033A62
    .step_0
    db $04, $14, $DC, $20
    db $04, $0C, $DD, $20
    db $04, $0C, $DD, $20
    db $04, $0C, $DD, $20
    db $00, $00, $CA, $20

    ; $033A76
    .step_1
    db $03, $0C, $DD, $20
    db $03, $14, $DC, $20
    db $03, $14, $DC, $20
    db $03, $14, $DC, $20
    db $00, $00, $CA, $20

    ; $033A8A
    .step_2
    db $F8, $08, $EA, $20
    db $00, $08, $EB, $20
    db $F8, $10, $FA, $20
    db $00, $10, $FB, $20
    db $00, $00, $CA, $20

    ; $033A9E
    .step_3
    db $F4, $04, $CC, $20
    db $FC, $04, $CD, $20
    db $FC, $04, $CD, $20
    db $FC, $04, $CD, $20
    db $00, $00, $CA, $20

    ; $033AB2
    .step_4
    db $F6, $04, $CC, $20
    db $FC, $04, $CD, $20
    db $FC, $04, $CD, $20
    db $FC, $04, $CD, $20
    db $00, $00, $CA, $20

    ; $033AC6
    .step_5
    db $F8, $04, $CC, $20
    db $FC, $04, $CD, $20
    db $FC, $04, $CD, $20
    db $FC, $04, $CD, $20
    db $00, $00, $CA, $20

    ; $033ADA
    .step_6
    db $04, $03, $E2, $20
    db $FA, $04, $CC, $20
    db $FC, $04, $CD, $20
    db $FC, $04, $CD, $20
    db $00, $00, $CA, $20

    ; $033AEE
    .step_7
    db $04, $03, $F1, $20
    db $FA, $04, $CC, $20
    db $FC, $04, $CD, $20
    db $FC, $04, $CD, $20
    db $00, $00, $CA, $20
}

; $033B02-$033B11 DATA
WaterSwitch_HitBox:
{
    db $08, $06
    db $10, $10
    db $10, $08
    db $10, $08
    db $10, $08
    db $10, $08
    db $10, $03
    db $10, $08
}

; $033B12-$033B21 DATA
WaterSwitch_OAMDataPointer:
{
    dw WaterSwitch_OAMData_step_0
    dw WaterSwitch_OAMData_step_1
    dw WaterSwitch_OAMData_step_2
    dw WaterSwitch_OAMData_step_3
    dw WaterSwitch_OAMData_step_4
    dw WaterSwitch_OAMData_step_5
    dw WaterSwitch_OAMData_step_6
    dw WaterSwitch_OAMData_step_7
}

; $033B22-$033CAB LOCAL JUMP LOCATION
WaterSwitch_Main:
{
    JSR.w OAM_AllocateDeferToPlayer
    JSR.w Sprite_PrepOamCoord
    
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
    
    LDA.w $0DE0, X : ASL A
    
    PHX
    
    REP #$31
    
    PHB
    
    TAY
    
    LDX.w WaterSwitch_OAMDataPointer, Y
    
    LDA.b $90 : ADC.w #$0004 : STA.b $90 : TAY
    
    INC.b $92
    
    LDA.w #$0013
    
    MVN $06, $00
    
    PLB
    
    SEP #$20
    
    LDY.b $90
    
    LDA.b $01 : EOR.b #$FF : INC : CLC : ADC.w $0FA8 : TAX
    
          CLC : ADC.w $0000, Y : STA.w $0000, Y
    TXA : CLC : ADC.w $0004, Y : STA.w $0004, Y
    TXA : CLC : ADC.w $0008, Y : STA.w $0008, Y
    TXA : CLC : ADC.w $000C, Y : STA.w $000C, Y
    
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
    
    JSR.w Sprite_CorrectOamEntries
    
    LDA.w $0F20, X : CMP $EE : BEQ .BRANCH_GAMMA
        JMP.w WaterSwitch_Main_exit
    
    .BRANCH_GAMMA
    
    STZ.w $0DB0, X
    
    LDA.w $0DE0, X : ASL #4 : TAY
    
    LDA.w WaterSwitch_OAMData+0, Y : CLC : ADC.w $0D10, X : STA.b $04
    
    STZ.b $0A
    
    LDA.w WaterSwitch_OAMData+0, Y : BPL .BRANCH_DELTA
        DEC.b $0A
    
    .BRANCH_DELTA
    
    LDA.b $0A : ADC.w $0D30, X : STA.b $0A
    
    LDA.w WaterSwitch_OAMData+1, Y : CLC : ADC.w $0D00, X : STA.b $05
    
    STZ.b $0B
    
    LDA.w WaterSwitch_OAMData+1, Y : BPL .BRANCH_EPSILON
        DEC.b $0B
    
    .BRANCH_EPSILON
    
    LDA.b $0B : ADC.w $0D20, X : STA.b $0B
    
    LDA.w $0DE0, X : ASL : TAY
    
    LDA.w WaterSwitch_HitBox+0, Y : STA.b $06
    LDA.w WaterSwitch_HitBox+1, Y : STA.b $07
    
    JSR.w Player_SetupHitBox_ignoreImmunity
    
    JSR.w Utility_CheckIfHitBoxesOverlap : BCC .BRANCH_ZETA
        LDA.w $0D00, X : PHA : CLC : ADC.b #$13 : STA.w $0D00, X
        LDA.w $0D20, X : PHA       : ADC.b #$00 : STA.w $0D20, X
        
        JSR.w Sprite_DirectionToFacePlayer
        
        PLA : STA.w $0D20, X
        PLA : STA.w $0D00, X
        
        CPY.b #$00 : BNE .BRANCH_THETA
            LDA.b $2F : CMP.b #$04 : BNE .BRANCH_THETA
                INC.w $0DB0, X
                
                BRA .BRANCH_THETA
    
    .BRANCH_ZETA
    
    JSR.w Sprite_CheckDamageToPlayer_same_layer : BCC .exit
        .BRANCH_THETA
        
        JSL.l Sprite_NullifyHookshotDrag
        
        STZ.b $5E
        
        JSL.l Sprite_RepelDashAttackLong
        
    ; $033CAB ALTERNATE ENTRY POINT
    .exit
    
    RTS
}

; ==============================================================================    
