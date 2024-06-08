
; ==============================================================================

; $0EAD0E-$0EAD15 LONG JUMP LOCATION
TrinexxComponents_InitializeLong:
{
    PHB : PHK : PLB
    
    JSR TrinexxComponents_Initialize
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EAD16-$0EAD25 LOCAL JUMP LOCATION
TrinexxComponents_Initialize:
{
    LDA.w $0E20, X : SEC : SBC.b #$CB
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw TrinexxHead_Initialize
    dw $AD67 ; = $EAD67*
    dw $AD70 ; = $EAD70*
}

; ==============================================================================

; $0EAD26-$0EAD66 JUMP LOCATION
TrinexxHead_Initialize:
{
    LDA.w $0D10, X : CLC : ADC.b #$08 : STA.w $0D10, X
    LDA.w $0D00, X : CLC : ADC.b #$10 : STA.w $0D00, X
    
    JSR.w $AD8C   ; $0EAD8C IN ROM
    
    STZ.w $0B0A
    STZ.w $0B0B
    STZ.w $0B0D
    STZ.w $0B0F
    STZ.w $0B10
    
    LDA.b #$FF : STA.w $0B0E
    
    ; $0EAD4F ALTERNATE ENTRY POINT
    
    LDA.w $0D90, X : STA.w $0D10, X
    
    LDA.w $0DB0, X : CLC : ADC.b #$0C : STA.w $0D00, X
    LDA.w $0ED0, X : ADC.b #$00 : STA.w $0D20, X
    
    RTS
}

; ==============================================================================

; $0EAD67-$0EADA4 JUMP LOCATION
{
    LDA.b #$03 : STA.w $0DC0, X
    
    LDA.b #$80
    
    BRA .BRANCH_ALPHA
    
    ; $0EAD70 ALTERNATE ENTRY POINT
    
    LDA.b #$FF
    
    .BRANCH_ALPHA
    
    STA.w $0DF0, X
    
    LDY.b #$1A
    
    .BRANCH_BETA
    
    LDA.b #$40 : STA.w $1D10, Y
    
    LDA.b #$00 : STA.w $1D30, Y
                 STA.w $1D50, Y
    
    DEY : BPL .BRANCH_BETA
    
    LDA.b #$01 : STA.w $0E80, X
    
    ; $0EAD8C ALTERNATE ENTRY POINT
    
    LDA.w $0D10, X : STA.w $0D90, X
    LDA.w $0D30, X : STA.w $0DA0, X
    
    LDA.w $0D00, X : STA.w $0DB0, X
    LDA.w $0D20, X : STA.w $0ED0, X
    
    RTS
}

; ==============================================================================

; $0EADB5-$0EAE64 LOCAL JUMP LOCATION
{
    LDA.w $0D40, X : STA.b $00
    
    LDA.w $0D50, X : STA.b $01
    
    JSL Sprite_ConvertVelocityToAngle : LSR A : TAY
    
    LDA.w $ADA5, Y : STA.w $0DC0, X
    
    LDY.w $0E00, X : BEQ .BRANCH_ALPHA
    
    TAY
    
    LDA.w $ADAD, Y : STA.w $0DC0, X
    
    .BRANCH_ALPHA
    
    JSR.w $AF84   ; $0EAF84 IN ROM
    JSR Sprite4_CheckIfActive
    
    LDA.w $0D80, X : BPL .BRANCH_BETA
    
    LDA.w $0DF0, X : PHA : ORA.b #$E0 : STA.w $0EF0, X
    
    PLA : BNE .BRANCH_GAMMA
    
    LDA.b #$0C : STA.w $0DF0, X
    
    LDA.w $0EC0, X : BNE .BRANCH_DELTA
    
    LDA.b #$FF : STA.w $0EF0, X
    
    JMP Sprite_ScheduleBossForDeath
    
    .BRANCH_DELTA
    
    DEC.w $0EC0, X
    
    JSL Sprite_MakeBossDeathExplosion
    
    .BRANCH_GAMMA
    
    RTS
    
    .BRANCH_BETA
    
    LDA.b $1A : AND.b #$07 : BNE .BRANCH_EPSILON
    
    LDA.b #$31 : JSL Sound_SetSfx3PanLong
    
    .BRANCH_EPSILON
    
    PHX : TXY
    
    INC.w $0E80, X : LDA.w $0E80, X : AND.b #$7F : TAX
    
    LDA.w $0D10, Y : STA.l $7FFC00, X
    LDA.w $0D00, Y : STA.l $7FFD00, X
    LDA.w $0D30, Y : STA.l $7FFC80, X
    LDA.w $0D20, Y : STA.l $7FFD80, X
    
    PLX
    
    LDA.w $0EA0, X : CMP.b #$0E : BNE .BRANCH_ZETA
    
    LDA.b #$08 : STA.w $0EA0, X
    
    LDA.w $0D80, X : CMP.b #$00 : BNE .BRANCH_ZETA
    
    LDA.b #$02 : STA.w $0D80, X
    
    .BRANCH_ZETA
    
    JSR Sprite4_Move
    JSR Sprite4_CheckDamage
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $AE6D ; = $EAE6D*
    dw $AEF5 ; = $EAEF5*
}

; ==============================================================================

; $0EAE6D-$0EAEA7 JUMP LOCATION
{
    LDA.w $0E80, X : AND.b #$00 : BNE .BRANCH_ALPHA
    
    DEC.w $0D90, X : BNE .BRANCH_ALPHA
    
    INC.w $0D80, X
    
    LDA.b #$C0 : STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    JSL Sprite_Get_16_bit_CoordsLong
    
    JSR Sprite4_CheckTileCollision : BEQ .BRANCH_BETA
    
    LDA.w $0DE0, X : INC A : AND.b #$03 : STA.w $0DE0, X
    
    LDA.b #$08 : STA.w $0E00, X
    
    .BRANCH_BETA
    
    LDY.w $0DE0, X
    
    LDA.w $AE65, Y : STA.w $0D50, X
    
    LDA.w $AE69, Y : STA.w $0D40, X
    
    RTS
}

; ==============================================================================

    ; \unused Try to confirm this. \task try to confirm this.
; $0EAEA8-$0EAEF4 UNUSED?
{
    LDA.w $0DF0, X : BNE .alpha
    
    INC.w $0D80, X
    
    .alpha
    
    LDA.b #$1F
    
    JSL Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA.b $00 : STA.w $0D50, X
    
    LDA.b $01 : EOR.b #$FF : INC A : STA.w $0D40, X
    
    LDA.b $0E : CLC : ADC.b #$28 : CMP.b #$50 : BCS .beta
    
    LDA.b $0F : CLC : ADC.b #$28 : CMP.b #$50 : BCS .beta
    
    RTS
    
    .beta
    
    LDA.b $00 : ASL.b $00 : PHP : ROR A
                        PLP : ROR A : CLC : ADC.w $0D40, X : STA.w $0D40, X
    
    LDA.b $01 : ASL.b $01 : PHP : ROR A
                        PLP : ROR A : CLC : ADC.w $0D50, X : STA.w $0D50, X
    
    RTS
}

; ==============================================================================

; $0EAEF5-$0EAF23 JUMP LOCATION
{
    LDA.b $1A : AND.b #$01 : BNE .BRANCH_ALPHA
    
    LDA.b #$1F
    
    JSL Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA.w $0D50, X : CMP $01 : BEQ .BRANCH_BETA  BPL .BRANCH_GAMMA
    
    INC.w $0D50, X
    
    BRA .BRANCH_BETA

    .BRANCH_GAMMA

    DEC.w $0D50, X

    .BRANCH_BETA

    LDA.w $0D40, X : CMP $00 : BEQ .BRANCH_ALPHA  BPL .BRANCH_DELTA
    
    INC.w $0D40, X
    
    BRA .BRANCH_ALPHA

    .BRANCH_DELTA

    DEC.w $0D40, X

    .BRANCH_ALPHA

    RTS
}

; $0EAF84-$0EB078 LOCAL JUMP LOCATION
{
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X

    JSR TrinexxHeadAndSnakeDraw ; $B560 ; $0EB560 IN ROM
    
    LDA.b #$00 : STA.w $0FB6

; $0EAF94 ALTERNATE ENTRY POINT

    LDY.w $0FB6
    
    TYA : CMP.w $0EC0, X : BNE .BRANCH_ALPHA
    
    RTS

.BRANCH_ALPHA

    PHX
    
    LDA.w $0E80, X : SEC : SBC.w $AF24, Y : AND.b #$7F : TAX
    
    LDA.l $7FFC00, X : STA.w $0FD8
    LDA.l $7FFC80, X : STA.w $0FD9
    LDA.l $7FFD00, X : STA.w $0FDA
    LDA.l $7FFD80, X : STA.w $0FDB
    
    PLX
    
    PHY : TYA : ASL A : TAY
    
    REP #$20
    
    LDA.b $22                 : SEC : SBC.w $0FD8 : CLC : ADC.w #$0008
                                        CMP.w #$0010 : BCS .BRANCH_BETA
    
    LDA.b $20 : CLC : ADC.w #$0008 : SEC : SBC.w $0FDA : CLC : ADC.w #$0008
                                        CMP.w #$0010 : BCS .BRANCH_BETA
    
    SEP #$20
    
    LDA.w $0D80, X : BMI .BRANCH_BETA
    
    LDA.w $031F : ORA.w $037B : ORA.b $11 : ORA.w $0FC1 : BNE .BRANCH_BETA

    LDA.b #$01 : STA.b $4D
    
    LDA.b #$08 : STA.w $0373
    
    LDA.b #$10 : STA.b $46
    
    LDA.b $28 : EOR.b #$FF : STA.b $28
    LDA.b $27 : EOR.b #$FF : STA.b $27
    
    REP #$20

.BRANCH_BETA

    LDA.b $90 : CLC : ADC.w $AF54, Y : STA.b $90
    
    LDA.w $AF54, Y : LSR #2 : CLC : ADC.b $92 : STA.b $92
    
    SEP #$20
    
    PLY
    
    LDA.b #$01 : STA.w $0F50, X
    
    CPY.b #$04 : BNE .BRANCH_GAMMA
    
    LDA.w $0D80, X : CMP.b #$01 : BCC .BRANCH_GAMMA
    
    PHY
    
    JSR.w $B079 ; $0EB079 IN ROM
    
    LDA.w $0E80, X : AND.b #$06 : EOR.w $0F50, X : STA.w $0F50, X
    
    PLY

.BRANCH_GAMMA

    LDA.w $AF3C, Y : STA.w $0DC0, X : CMP.b #$03 : BEQ .BRANCH_DELTA
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    BRA .BRANCH_EPSILON

.BRANCH_DELTA

    LDA.b #$08 : STA.w $0DC0, X
    
    JSR TrinexxHeadAndSnakeDraw ; $B560 ; $0EB560 IN ROM

.BRANCH_EPSILON

    INC.w $0FB6 : LDA.w $0FB6 : CMP.w $0EC0, X : BEQ .BRANCH_ZETA
    
    JMP.w $AF94   ; $0EAF94 IN ROM

.BRANCH_ZETA

    RTS
}

; $0EB079-$0EB0C7 LOCAL JUMP LOCATION
{
    LDA.w $0D10, X : PHA
    LDA.w $0D30, X : PHA
    LDA.w $0D00, X : PHA
    LDA.w $0D20, X : PHA
    
    LDA.w $0FD8 : STA.w $0D10, X
    LDA.w $0FD9 : STA.w $0D30, X
    
    LDA.w $0FDA : STA.w $0D00, X
    LDA.w $0FDB : STA.w $0D20, X
    
    LDA.b #$80 : STA.w $0CAA, X
    
    STZ.w $0E60, X
    
    JSL Sprite_CheckDamageFromPlayerLong
    
    LDA.b #$84 : STA.w $0CAA, X
    
    LDA.b #$40 : STA.w $0E60, X
    
    PLA : STA.w $0D20, X
    PLA : STA.w $0D00, X
    PLA : STA.w $0D30, X
    PLA : STA.w $0D10, X
    
    RTS
}

; ==============================================================================

; $0EB0C8-$0EB0C9 JUMP LOCATION
{
    ; \task this routine / pool.
    .animation_states
    db 7, 1
}

; ==============================================================================

; $0EB0CA-$0EB1B0 JUMP LOCATION
Sprite_Trinexx:
{
    LDA.w $0B10 : BEQ .BRANCH_ALPHA
    
    JMP.w $ADB5   ; $0EADB5 IN ROM
    
    .BRANCH_ALPHA
    
    LDA.b #$17 : STA.b $1C
                 STZ.b $1D
    
    JSR.w $B587   ; $0EB587 IN ROM
    JSR Sprite4_CheckIfActive
    
    LDA.w $0D80, X : BMI .BRANCH_BETA
    
    JMP.w $B1D1   ; $0EB1D1 IN ROM
    
    .BRANCH_BETA
    
    STA.w $0FFC
    
    LDA.w $0DF0, X : BNE .BRANCH_GAMMA
    
    INC.w $0B10
    
    JSL Sprite_InitializedSegmented
    
    STZ.w $0E80, X
    STZ.w $0EB0, X
    
    LDA.w $0E60, X : AND.b #$BF : STA.w $0E60, X
    
    LDA.b #$80 : STA.w $0CAA, X
    
    STZ.w $0D80, X
    
    STZ.w $0DE0, X
    
    LDA.b #$00 : STA.w $0D90, X
    
    LDA.b #$10 : STA.w $0EC0, X
    
    JSR Sprite4_Zero_XY_Velocity
    
    LDA.b #$80 : STA.w $0D90, X
    
    LDA.b #$FF : STA.w $0311
    
    RTS
    
    .BRANCH_GAMMA
    
    CMP.b #$FF : BCS .BRANCH_DELTA
    CMP.b #$E0 : BCC .BRANCH_EPSILON
    AND.b #$03 : BNE .BRANCH_ZETA
    
    LDA.b #$FF : STA.w $0311
    
    LDA.b #$FF : STA.w $0310
    
    LDA.b #$01 : STA.w $0428
    
    .BRANCH_ZETA
    
    LDA.b #$F8 : STA.w $0D40, X
    
    JSR Sprite4_MoveVert
    JSR.w $AD8C ; $0EAD8C IN ROM
    
    LDA.w $0D00, X : SEC : SBC.b #$0C : STA.w $0DB0, X
    
    INC.w $0B0F : INC.w $0B0F
    
    .BRANCH_DELTA
    
    RTS
    
    .BRANCH_EPSILON
    
    PHA : AND.b #$03 : BNE .BRANCH_THETA
    
    LDA.b #$0C : JSL Sound_SetSfx2PanLong
    
    .BRANCH_THETA
    
    PLA : AND.b #$01 : BNE .BRANCH_IOTA
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA.w $0D10, X : CLC : ADC.w $B1B1, Y : STA.w $0FD8
    LDA.w $0D30, X : ADC.w $B1B9, Y : STA.w $0FD9
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA.w $0D00, X : CLC : ADC.w $B1C1, Y : PHP : SEC : SBC.b #$08   : STA.w $0FDA
    LDA.w $0D20, X : SBC.b #$00   : PLP : ADC.w $B1C9, Y : STA.w $0FDB
    
    JSL Sprite_MakeBossDeathExplosion.silent
    
    .BRANCH_IOTA
    
    LDA.b #$FF : STA.w $0EB0, X
    
    RTS
}

; $0EB1D1-$0EB249 LOCAL JUMP LOCATION
{
    LDA.w $0DD1 : ORA.w $0DD2 : BNE .BRANCH_ALPHA
    
    LDA.w $0D80, X : CMP.b #$02 : BCS .BRANCH_ALPHA
    
    LDA.b #$FF : STA.w $0DF0, X
    
    LDA #$FF : STA.w $0D80, X
    
    ; play boss dying noise.
    LDA.b #$22 : STA.w $012F
    
    RTS
    
    .BRANCH_ALPHA
    
    JSR.w $B3B5 ; $0EB3B5 IN ROM
    JSR.w $B3E6 ; $0EB3E6 IN ROM
    JSR Sprite4_CheckDamage
    
    LDA.b $1A : AND.b #$3F : BNE .BRANCH_BETA
    
    JSR Sprite4_IsToRightOfPlayer
    
    LDA.b $0F : CLC : ADC.b #$18 : CMP.b #$30 : LDA.b #$00 : BCC .BRANCH_GAMMA
    
    LDA.w $B0C8, Y
    
    .BRANCH_GAMMA
    
    STA.w $0DC0, X
    
    .BRANCH_BETA
    
    LDA.w $0B0E : BEQ .BRANCH_DELTA
    
    LDA.b $1A : AND.b #$01 : BNE .BRANCH_EPSILON
    
    DEC.w $0B0E
    
    .BRANCH_EPSILON
    
    RTS
    
    .BRANCH_DELTA
    
    LDA.w $0DD1 : BEQ .BRANCH_ZETA
    
    LDA.w $0D81 : CMP.b #$03 : BEQ .return
    
    .BRANCH_ZETA
    
    LDA.w $0DD2 : BEQ .BRANCH_THETA
    
    LDA.w $0D82 : CMP.b #$03 : BEQ .return
    
    .BRANCH_THETA
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $B252 ; = $EB252* ; Roll the dice to see what to do.
    dw $B2A1 ; = $EB2A1* ; Walk around.
    dw $B369 ; = $EB369* ; Fast tail wiggle.
    dw $B388 ; = $EB388* ; Extendo Neck.
    
    .return
    
    RTS
}

; ==============================================================================

; $0EB24A-$0EB251 DATA
{
    ; \task Name this routine / pool.
    .unknown_0
    db $60, $78, $78, $90
    
    .unknown_1
    db $80, $70, $60, $80
}

; ==============================================================================

; $0EB252-$0EB2A0 JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    LDA.w $0E30, X : AND.b #$7F : STA.b $00
    
    JSL GetRandomInt : AND.b #$03 : TAY : CMP $00 : BEQ .BRANCH_ALPHA
    
    INC.w $0EC0, X : LDA.w $0EC0, X : CMP.b #$02 : BNE .BRANCH_BETA
    
    STZ.w $0EC0, X
    
    LDA.b #$02 : STA.w $0D80, X
    
    LDA.b #$50 : STA.w $0DF0, X
    
    RTS
    
    .BRANCH_BETA
    
    LDA.w $B24A, Y : STA.w $0B08
    
    LDA.w $B24E, Y : STA.w $0B09
    
    JSL GetRandomInt : AND.b #$03 : CMP.b #$01 : TYA : BCS .BRANCH_GAMMA
    
    ORA.b #$80
    
    .BRANCH_GAMMA
    
    STA.w $0E30, X
    
    INC.w $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0EB2A1-$0EB368 JUMP LOCATION
{
    LDA.w $0E30, X : CMP.b #$FF : BNE .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BEQ .BRANCH_BETA
    
    JSR Sprite4_IsBelowPlayer
    
    CPY.b #$00 : BNE .BRANCH_ALPHA
    
    .BRANCH_BETA
    
    STZ.w $0E30, X
    
    JMP.w $B33D   ; $0EB33D IN ROM
    
    .BRANCH_ALPHA
    
    LDA.w $0B08    : STA.b $04
    LDA.w $0D30, X : STA.b $05
    
    LDA.w $0B09    : STA.b $06
    LDA.w $0D20, X : STA.b $07
    
    LDA.b #$08
    
    LDY.w $0E30, X : BPL .BRANCH_GAMMA
    
    LDA.b #$10
    
    .BRANCH_GAMMA
    
    JSL Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    
    LDA.b $01 : STA.w $0D5050, X
    
    LDA.w $0D10, X : PHA
    LDA.w $0D00, X : PHA
    
    JSR Sprite4_Move
    
    PLA : LDY.b #$00 : SEC : SBC.w $0D00, X : STA.w $0310 : BPL .BRANCH_DELTA
    
    DEY
    
    .BRANCH_DELTA
    
    STY.w $0311
    
    PLA
    
    LDY.b #$00
    
    SEC : SBC.w $0D10, X : STA.w $0312 : BPL .BRANCH_EPSILON
    
    DEY
    
    .BRANCH_EPSILON
    
    STY.w $0313
    
    LDA.b #$01 : STA.w $0428
    
    JSR.w $AD8C ; $0EAD8C IN ROM
    
    LDA.w $0D00, X : SEC : SBC.b #$0C : STA.w $0DB0, X
    
    LDA.w $0B08 : SEC : SBC.w $0D10, X : CLC : ADC.b #$02 : CMP.b #$04 : BCS .BRANCH_ZETA
    
    LDA.w $0B09 : SEC : SBC.w $0D00, X : CLC : ADC.b #$02 : CMP.b #$04 : BCS .BRANCH_ZETA
    
    ; $0EB33D ALTERNATE ENTRY POINT
    
    STZ.w $0D80, X
    
    LDA.b #$30 : STA.w $0DF0, X
    
    .BRANCH_ZETA
    
    LDA.w $0E30, X : BPL .BRANCH_THETA
    
    JSR.w $B34D ; $0EB34D IN ROM
    
    ; $0EB34D ALTERNATE ENTRY POINT
    .BRANCH_THETA
    
    LDA.w $0E80, X
    
    LDY.w $0D50, X : BMI .BRANCH_IOTA
    
    SEC : SBC.b #$02
    
    .BRANCH_IOTA
    
    CLC : ADC.b #$01 : STA.w $0E80, X : AND.b #$0F : BNE .BRANCH_KAPPA
    
    LDA.b #$21 : JSL Sound_SetSfx2PanLong
    
    .BRANCH_KAPPA
    
    RTS
}

; $0EB369-$0EB387 JUMP LOCATION
{
    JSR.w $B3B5   ; $0EB3B5 IN ROM
    JSR.w $B3B5   ; $0EB3B5 IN ROM
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    INC.w $0D80, X
    
    LDA.b #$30
    
    JSL Sprite_ApplySpeedTowardsPlayerLong
    
    LDA.b #$40 : STA.w $0DF0, X
    
    LDA.b #$26 : STA.w $012F
    
    .BRANCH_ALPHA
    
    RTS
}

; $0EB388-$0EB3B2 JUMP LOCATION
{
    JSR Sprite4_Move
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    JSR.w $AD4F   ; $0EAD4F IN ROM
    
    STZ.w $0D80, X
    
    LDA.b #$30 : STA.w $0DF0, X
    
    RTS
    
    .BRANCH_ALPHA
    
    CMP.b #$20 : BNE .BRANCH_BETA
    
    LDA.w $0D50, X : EOR.b #$FF : INC A : STA.w $0D50, X
    
    LDA.w $0D40, X : EOR.b #$FF : INC A : STA.w $0D40, X
    
    .BRANCH_BETA
    
    RTS
}

; ==============================================================================

; $0EB3B3-$0EB3B4 DATA
{
    ; \task Name this routine / pool.
    .unknown_0
    db 6, 0
}

; ==============================================================================

; $0EB3B5-$0EB3E5 LOCAL JUMP LOCATION
{
    LDA.w $0B0D : BNE .BRANCH_ALPHA
    
    INC.w $0B0C : LDA.w $0B0C : AND.b #$03 : BNE .BRANCH_BETA
    
    LDA.w $0B0B : AND.b #$01 : TAY
    
    LDA.w $0B0A : CLC : ADC.w $8000, Y : STA.w $0B0A
    
    CMP .unknown_0, Y : BNE .BRANCH_BETA
    
    INC.w $0B0B
    
    LDA.b #$08 : STA.w $0B0D
    
    .BRANCH_BETA
    
    RTS
    
    .BRANCH_ALPHA
    
    DEC.w $0B0D
    
    RTS
}

; $0EB3E6-$0EB43F LOCAL JUMP LOCATION
{
    LDA.w $0D90, X : STA.b $04
    LDA.w $0DA0, X : STA.b $05
    LDA.w $0DB0, X : STA.b $06
    LDA.w $0ED0, X : STA.b $07
    
    REP #$20
    
    LDA.b $04 : SEC : SBC.b $22 : CLC : ADC.w #$0028 : CMP.w #$0050 : BCS .BRANCH_ALPHA
    
    LDA.b $06 : SEC : SBC.b $20 : CLC : ADC.w #$0010 : CMP.w #$0040 : BCS .BRANCH_ALPHA
    
    SEP #$20
    
    LDA.w $031F : ORA.w $037B : BNE .BRANCH_ALPHA
    
    LDA.b #$01 : STA.b $4D
    
    LDA.b #$08 : STA.w $0373
    
    LDA.b #$10 : STA.b $46
    
    LDA #$20
    
    JSL Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA.b $00 : STA.b $27
    LDA.b $01 : STA.b $28
    
    .BRANCH_ALPHA
    
    SEP #$20
    
    RTS
}

; $0EB440-$0EB55F DATA
DrawData:
{
    .pool
    dw $FFF8, $FFF8, $40C0, $0200, $0008, $FFF8, $00C0, $0200
    dw $FFF8, $0008, $40E0, $0200, $0008, $0008, $00E0, $0200
    dw $FFF8, $FFF8, $0000, $0200, $0008, $FFF8, $0002, $0200
    dw $FFF8, $0008, $0020, $0200, $0008, $0008, $0022, $0200
    dw $FFF8, $FFF8, $00C2, $0200, $0008, $FFF8, $00C4, $0200
    dw $FFF8, $0008, $80C2, $0200, $0008, $0008, $80C4, $0200
    dw $FFF8, $FFF8, $8020, $0200, $0008, $FFF8, $8022, $0200
    dw $FFF8, $0008, $8000, $0200, $0008, $0008, $8002, $0200
    dw $FFF8, $FFF8, $C0E0, $0200, $0008, $FFF8, $80E0, $0200
    dw $FFF8, $0008, $C0C0, $0200, $0008, $0008, $80C0, $0200
    dw $FFF8, $FFF8, $C022, $0200, $0008, $FFF8, $C020, $0200
    dw $FFF8, $0008, $C002, $0200, $0008, $0008, $C000, $0200
    dw $FFF8, $FFF8, $40C4, $0200, $0008, $FFF8, $40C2, $0200
    dw $FFF8, $0008, $C0C4, $0200, $0008, $0008, $C0C2, $0200
    dw $FFF8, $FFF8, $4002, $0200, $0008, $FFF8, $4000, $0200
    dw $FFF8, $0008, $4022, $0200, $0008, $0008, $4020, $0200
    dw $FFF8, $FFF8, $0026, $0200, $0008, $FFF8, $4026, $0200
    dw $FFF8, $0008, $8026, $0200, $0008, $0008, $C026, $0200
}

; $0EB560-$0EB586 LOCAL JUMP LOCATION
TrinexxHeadAndSnakeDraw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : REP #$20 : ASL #5 : ADC.w #$B440 : STA.b $08
    
    SEP #$20
    
    LDA.w $0D80, X : BMI .BRANCH_ALPHA
    
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    .BRANCH_ALPHA
    
    LDA.b #$04
    
    JSR Sprite4_DrawMultiple
    
    RTS
}

; $0EB587-$0EB772 LOCAL JUMP LOCATION
{
    LDA.w $0EB0, X : BMI .BRANCH_$EB586 ; (RTS)
    
    JSR TrinexxHeadAndSnakeDraw ; $B560 ; $0EB560 IN ROM
    
    LDA.b $05 : AND.b #$EF : STA.b $05
    
    LDA.w $0D80, X : CMP.b #$03 : BEQ .BRANCH_ALPHA
    
    JMP.w $B641   ; $0EB641 IN ROM

    .BRANCH_ALPHA

    LDA.w $0D90, X : SEC : SBC.w $0D10, X : STA.b $08 : BPL .BRANCH_BETA
    
    EOR.b #$FF : INC A

    .BRANCH_BETA

    STA.b $0A
    
    LDA.w $0DB0, X : SEC : SBC.w $0D00, X : STA.b $09 : BPL .BRANCH_GAMMA
    
    EOR.b #$FF : INC A

    .BRANCH_GAMMA

    STA.b $0B
    
    LDA.b #$07 : STA.w $0FB5
    
    LDA.b #$10 : STA.w $0FB6

    .BRANCH_ZETA

    LDY.w $0FB5
    
    LDA.b $0A : STA.w $4202
    
    LDA.w $B804, Y : STA.w $4203
    
    NOP #8
    
    ASL.w $4216
    
    LDA.w $4217 : ADC.b #$00
    
    LDY.b $08 : BPL .BRANCH_DELTA
    
    EOR.b #$FF : INC A

    .BRANCH_DELTA

    CLC : ADC.b $00
    
    LDY.w $0FB6
    
    STA ($90), Y
    
    LDY.w $0FB5
    
    LDA.b $0B : STA.w $4202
    
    LDA.w $B804, Y : STA.w $4203
    
    NOP #8
    
    ASL.w $4216
    
    LDA.w $4217
    
    ADC.b #$00
    
    LDY.b $09 : BPL .BRANCH_EPSILON
    
    EOR.b #$FF : INC A

    .BRANCH_EPSILON

    CLC : ADC.b $02   : LDY.w $0FB6 : INY : STA ($90), Y
    LDA.b #$28 :             INY : STA ($90), Y
    LDA.b $05    :             INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY : INY : STY.w $0FB6
    
    DEC.w $0FB5 : BPL .BRANCH_ZETA

    ; $0EB641 ALTERNATE ENTRY POINT

    REP #$20
    
    LDA.w #$09F0 : STA.b $90
    
    LDA.w #$0A9C : STA.b $92
    
    SEP #$20
    
    LDA.w $0D90, X : SEC : SBC.b $E2 : STA.b $00
    
    LDA.w $0DB0, X : SEC : SBC.b $E8 : STA.b $02
    LDA.w $0D20, X : SBC.b $E9 : STA.b $03
    
    LDA.b #$01 : STA.w $0FB5
    
    LDA.w $0D50, X : CLC : ADC.b #$03 : CMP.b #$07 : LDA.b #$00 : BCC .BRANCH_THETA
    
    LDA.w $0E80, X : LSR #2 : AND.b #$0F

    .BRANCH_THETA

    STA.b $06
    
    CLC : ADC.b #$08 : AND.b #$0F : STA.b $07
    
    LDA.w $0E80, X : LSR #2 : AND.b #$0F : STA.b $08
    CLC : ADC.b #$08           : AND.b #$0F : STA.b $09
    
    LDY.b #$00
    
    PHX

    .BRANCH_IOTA

    LDA.b $00 : CLC : ADC.w $B80C, X : PHA
    
    LDA.b $06, X : TAX
    
    PLA : CLC : ADC.w $B810, X          : STA ($90), Y
                          INY #4 : STA ($90), Y
    
    LDA.b $02 : CLC : ADC.b #$F8 : PHA
    
    LDX.w $0FB5
    
    LDA.b $08, X : TAX
    
    PLA : CLC : ADC.w $B820, X
    
    DEY #3
    
    STA ($90), Y
    
    CLC : ADC.b #$10 : INY #4 : STA ($90), Y
    
    LDA.b #$0C : DEY #3 : STA ($90), Y
    
    LDA.b #$2A : INY #4 : STA ($90), Y
    
    DEY #3
    
    LDX.w $0FB5
    
    LDA.b $05 : ORA.w $B80E, X : STA ($90), Y
    
    INY #4 : STA ($90), Y
    
    PHY
    
    TYA : LSR #2 : TAY
    
    LDA.b #$02      : STA ($92), Y
                DEY : STA ($92), Y
    
    PLY : INY
    
    DEC.w $0FB5 : BPL .BRANCH_IOTA
    
    LDA.w $0B0A : ASL #2 : ADC.w $0B0A : STA.b $06
    
    LDY.b #$00
    LDX.b #$00

    .BRANCH_LAMBDA

    PHX
    
    TXA : CLC : ADC.b $06 : ASL A : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC.w $B773, X : STA.w $096C, Y
    
    LDA.b $02 : SEC : SBC.w $B7B9, X : SBC.w #$0020 : CLC : ADC.w $0B0F : INY : STA.w $096C, Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .BRANCH_KAPPA
    
    LDA.b #$F0 : STA.w $096C, Y

    .BRANCH_KAPPA

    PLX
    
    LDA.w $B7FF, X : INY : STA.w $096C, Y
    LDA.b $05      : INY : STA.w $096C, Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b #$02 : STA.w $0A7B, Y
    
    PLY : INY
    
    INX : CPX.b #$05 : BNE .BRANCH_LAMBDA
    
    PLX
    
    LDA.b $11 : BEQ .BRANCH_MU
    
    LDY.b #$02
    LDA.b #$03
    
    JSL Sprite_CorrectOamEntriesLong

    .BRANCH_MU

    RTS
}

; ==============================================================================
