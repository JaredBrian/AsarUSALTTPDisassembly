
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
    LDA $0E20, X : SEC : SBC.b #$CB
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw TrinexxHead_Initialize
    dw $AD67 ; = $EAD67*
    dw $AD70 ; = $EAD70*
}

; ==============================================================================

; $0EAD26-$0EAD66 JUMP LOCATION
TrinexxHead_Initialize:
{
    LDA $0D10, X : CLC : ADC.b #$08 : STA $0D10, X
    LDA $0D00, X : CLC : ADC.b #$10 : STA $0D00, X
    
    JSR $AD8C   ; $0EAD8C IN ROM
    
    STZ $0B0A
    STZ $0B0B
    STZ $0B0D
    STZ $0B0F
    STZ $0B10
    
    LDA.b #$FF : STA $0B0E
    
    ; $0EAD4F ALTERNATE ENTRY POINT
    
    LDA $0D90, X : STA $0D10, X
    
    LDA $0DB0, X : CLC : ADC.b #$0C : STA $0D00, X
    LDA $0ED0, X : ADC.b #$00 : STA $0D20, X
    
    RTS
}

; ==============================================================================

; $0EAD67-$0EADA4 JUMP LOCATION
{
    LDA.b #$03 : STA $0DC0, X
    
    LDA.b #$80
    
    BRA .BRANCH_ALPHA
    
    ; $0EAD70 ALTERNATE ENTRY POINT
    
    LDA.b #$FF
    
    .BRANCH_ALPHA
    
    STA $0DF0, X
    
    LDY.b #$1A
    
    .BRANCH_BETA
    
    LDA.b #$40 : STA $1D10, Y
    
    LDA.b #$00 : STA $1D30, Y
                 STA $1D50, Y
    
    DEY : BPL .BRANCH_BETA
    
    LDA.b #$01 : STA $0E80, X
    
    ; $0EAD8C ALTERNATE ENTRY POINT
    
    LDA $0D10, X : STA $0D90, X
    LDA $0D30, X : STA $0DA0, X
    
    LDA $0D00, X : STA $0DB0, X
    LDA $0D20, X : STA $0ED0, X
    
    RTS
}

; ==============================================================================

; $0EADB5-$0EAE64 LOCAL JUMP LOCATION
{
    LDA $0D40, X : STA $00
    
    LDA $0D50, X : STA $01
    
    JSL Sprite_ConvertVelocityToAngle : LSR A : TAY
    
    LDA.w $ADA5, Y : STA $0DC0, X
    
    LDY $0E00, X : BEQ .BRANCH_ALPHA
    
    TAY
    
    LDA.w $ADAD, Y : STA $0DC0, X
    
    .BRANCH_ALPHA
    
    JSR $AF84   ; $0EAF84 IN ROM
    JSR Sprite4_CheckIfActive
    
    LDA $0D80, X : BPL .BRANCH_BETA
    
    LDA $0DF0, X : PHA : ORA.b #$E0 : STA $0EF0, X
    
    PLA : BNE .BRANCH_GAMMA
    
    LDA.b #$0C : STA $0DF0, X
    
    LDA $0EC0, X : BNE .BRANCH_DELTA
    
    LDA.b #$FF : STA $0EF0, X
    
    JMP Sprite_ScheduleBossForDeath
    
    .BRANCH_DELTA
    
    DEC $0EC0, X
    
    JSL Sprite_MakeBossDeathExplosion
    
    .BRANCH_GAMMA
    
    RTS
    
    .BRANCH_BETA
    
    LDA $1A : AND.b #$07 : BNE .BRANCH_EPSILON
    
    LDA.b #$31 : JSL Sound_SetSfx3PanLong
    
    .BRANCH_EPSILON
    
    PHX : TXY
    
    INC $0E80, X : LDA $0E80, X : AND.b #$7F : TAX
    
    LDA $0D10, Y : STA $7FFC00, X
    LDA $0D00, Y : STA $7FFD00, X
    LDA $0D30, Y : STA $7FFC80, X
    LDA $0D20, Y : STA $7FFD80, X
    
    PLX
    
    LDA $0EA0, X : CMP.b #$0E : BNE .BRANCH_ZETA
    
    LDA.b #$08 : STA $0EA0, X
    
    LDA $0D80, X : CMP.b #$00 : BNE .BRANCH_ZETA
    
    LDA.b #$02 : STA $0D80, X
    
    .BRANCH_ZETA
    
    JSR Sprite4_Move
    JSR Sprite4_CheckDamage
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $AE6D ; = $EAE6D*
    dw $AEF5 ; = $EAEF5*
}

; ==============================================================================

; $0EAE6D-$0EAEA7 JUMP LOCATION
{
    LDA $0E80, X : AND.b #$00 : BNE .BRANCH_ALPHA
    
    DEC $0D90, X : BNE .BRANCH_ALPHA
    
    INC $0D80, X
    
    LDA.b #$C0 : STA $0DF0, X
    
    .BRANCH_ALPHA
    
    JSL Sprite_Get_16_bit_CoordsLong
    
    JSR Sprite4_CheckTileCollision : BEQ .BRANCH_BETA
    
    LDA $0DE0, X : INC A : AND.b #$03 : STA $0DE0, X
    
    LDA.b #$08 : STA $0E00, X
    
    .BRANCH_BETA
    
    LDY $0DE0, X
    
    LDA.w $AE65, Y : STA $0D50, X
    
    LDA.w $AE69, Y : STA $0D40, X
    
    RTS
}

; ==============================================================================

    ; \unused Try to confirm this. \task try to confirm this.
; $0EAEA8-$0EAEF4 UNUSED?
{
    LDA $0DF0, X : BNE .alpha
    
    INC $0D80, X
    
    .alpha
    
    LDA.b #$1F
    
    JSL Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA $00 : STA $0D50, X
    
    LDA $01 : EOR.b #$FF : INC A : STA $0D40, X
    
    LDA $0E : CLC : ADC.b #$28 : CMP.b #$50 : BCS .beta
    
    LDA $0F : CLC : ADC.b #$28 : CMP.b #$50 : BCS .beta
    
    RTS
    
    .beta
    
    LDA $00 : ASL $00 : PHP : ROR A
                        PLP : ROR A : CLC : ADC $0D40, X : STA $0D40, X
    
    LDA $01 : ASL $01 : PHP : ROR A
                        PLP : ROR A : CLC : ADC $0D50, X : STA $0D50, X
    
    RTS
}

; ==============================================================================

; $0EAEF5-$0EAF23 JUMP LOCATION
{
    LDA $1A : AND.b #$01 : BNE .BRANCH_ALPHA
    
    LDA.b #$1F
    
    JSL Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA $0D50, X : CMP $01 : BEQ .BRANCH_BETA  BPL .BRANCH_GAMMA
    
    INC $0D50, X
    
    BRA .BRANCH_BETA

    .BRANCH_GAMMA

    DEC $0D50, X

    .BRANCH_BETA

    LDA $0D40, X : CMP $00 : BEQ .BRANCH_ALPHA  BPL .BRANCH_DELTA
    
    INC $0D40, X
    
    BRA .BRANCH_ALPHA

    .BRANCH_DELTA

    DEC $0D40, X

    .BRANCH_ALPHA

    RTS
}

; $0EAF84-$0EB078 LOCAL JUMP LOCATION
{
    LDA $0B89, X : ORA.b #$30 : STA $0B89, X

    JSR TrinexxHeadAndSnakeDraw ; $B560 ; $0EB560 IN ROM
    
    LDA.b #$00 : STA $0FB6

; $0EAF94 ALTERNATE ENTRY POINT

    LDY $0FB6
    
    TYA : CMP $0EC0, X : BNE .BRANCH_ALPHA
    
    RTS

.BRANCH_ALPHA

    PHX
    
    LDA $0E80, X : SEC : SBC $AF24, Y : AND.b #$7F : TAX
    
    LDA $7FFC00, X : STA $0FD8
    LDA $7FFC80, X : STA $0FD9
    LDA $7FFD00, X : STA $0FDA
    LDA $7FFD80, X : STA $0FDB
    
    PLX
    
    PHY : TYA : ASL A : TAY
    
    REP #$20
    
    LDA $22                 : SEC : SBC $0FD8 : CLC : ADC.w #$0008
                                        CMP.w #$0010 : BCS .BRANCH_BETA
    
    LDA $20 : CLC : ADC.w #$0008 : SEC : SBC $0FDA : CLC : ADC.w #$0008
                                        CMP.w #$0010 : BCS .BRANCH_BETA
    
    SEP #$20
    
    LDA $0D80, X : BMI .BRANCH_BETA
    
    LDA $031F : ORA $037B : ORA $11 : ORA $0FC1 : BNE .BRANCH_BETA

    LDA.b #$01 : STA $4D
    
    LDA.b #$08 : STA $0373
    
    LDA.b #$10 : STA $46
    
    LDA $28 : EOR.b #$FF : STA $28
    LDA $27 : EOR.b #$FF : STA $27
    
    REP #$20

.BRANCH_BETA

    LDA $90 : CLC : ADC $AF54, Y : STA $90
    
    LDA.w $AF54, Y : LSR #2 : CLC : ADC $92 : STA $92
    
    SEP #$20
    
    PLY
    
    LDA.b #$01 : STA $0F50, X
    
    CPY.b #$04 : BNE .BRANCH_GAMMA
    
    LDA $0D80, X : CMP.b #$01 : BCC .BRANCH_GAMMA
    
    PHY
    
    JSR $B079 ; $0EB079 IN ROM
    
    LDA $0E80, X : AND.b #$06 : EOR $0F50, X : STA $0F50, X
    
    PLY

.BRANCH_GAMMA

    LDA.w $AF3C, Y : STA $0DC0, X : CMP.b #$03 : BEQ .BRANCH_DELTA
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    BRA .BRANCH_EPSILON

.BRANCH_DELTA

    LDA.b #$08 : STA $0DC0, X
    
    JSR TrinexxHeadAndSnakeDraw ; $B560 ; $0EB560 IN ROM

.BRANCH_EPSILON

    INC $0FB6 : LDA $0FB6 : CMP $0EC0, X : BEQ .BRANCH_ZETA
    
    JMP $AF94   ; $0EAF94 IN ROM

.BRANCH_ZETA

    RTS
}

; $0EB079-$0EB0C7 LOCAL JUMP LOCATION
{
    LDA $0D10, X : PHA
    LDA $0D30, X : PHA
    LDA $0D00, X : PHA
    LDA $0D20, X : PHA
    
    LDA $0FD8 : STA $0D10, X
    LDA $0FD9 : STA $0D30, X
    
    LDA $0FDA : STA $0D00, X
    LDA $0FDB : STA $0D20, X
    
    LDA.b #$80 : STA $0CAA, X
    
    STZ $0E60, X
    
    JSL Sprite_CheckDamageFromPlayerLong
    
    LDA.b #$84 : STA $0CAA, X
    
    LDA.b #$40 : STA $0E60, X
    
    PLA : STA $0D20, X
    PLA : STA $0D00, X
    PLA : STA $0D30, X
    PLA : STA $0D10, X
    
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
    LDA $0B10 : BEQ .BRANCH_ALPHA
    
    JMP $ADB5   ; $0EADB5 IN ROM
    
    .BRANCH_ALPHA
    
    LDA.b #$17 : STA $1C
                 STZ $1D
    
    JSR $B587   ; $0EB587 IN ROM
    JSR Sprite4_CheckIfActive
    
    LDA $0D80, X : BMI .BRANCH_BETA
    
    JMP $B1D1   ; $0EB1D1 IN ROM
    
    .BRANCH_BETA
    
    STA $0FFC
    
    LDA $0DF0, X : BNE .BRANCH_GAMMA
    
    INC $0B10
    
    JSL Sprite_InitializedSegmented
    
    STZ $0E80, X
    STZ $0EB0, X
    
    LDA $0E60, X : AND.b #$BF : STA $0E60, X
    
    LDA.b #$80 : STA $0CAA, X
    
    STZ $0D80, X
    
    STZ $0DE0, X
    
    LDA.b #$00 : STA $0D90, X
    
    LDA.b #$10 : STA $0EC0, X
    
    JSR Sprite4_Zero_XY_Velocity
    
    LDA.b #$80 : STA $0D90, X
    
    LDA.b #$FF : STA $0311
    
    RTS
    
    .BRANCH_GAMMA
    
    CMP.b #$FF : BCS .BRANCH_DELTA
    CMP.b #$E0 : BCC .BRANCH_EPSILON
    AND.b #$03 : BNE .BRANCH_ZETA
    
    LDA.b #$FF : STA $0311
    
    LDA.b #$FF : STA $0310
    
    LDA.b #$01 : STA $0428
    
    .BRANCH_ZETA
    
    LDA.b #$F8 : STA $0D40, X
    
    JSR Sprite4_MoveVert
    JSR $AD8C ; $0EAD8C IN ROM
    
    LDA $0D00, X : SEC : SBC.b #$0C : STA $0DB0, X
    
    INC $0B0F : INC $0B0F
    
    .BRANCH_DELTA
    
    RTS
    
    .BRANCH_EPSILON
    
    PHA : AND.b #$03 : BNE .BRANCH_THETA
    
    LDA.b #$0C : JSL Sound_SetSfx2PanLong
    
    .BRANCH_THETA
    
    PLA : AND.b #$01 : BNE .BRANCH_IOTA
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA $0D10, X : CLC : ADC $B1B1, Y : STA $0FD8
    LDA $0D30, X : ADC $B1B9, Y : STA $0FD9
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA $0D00, X : CLC : ADC $B1C1, Y : PHP : SEC : SBC.b #$08   : STA $0FDA
    LDA $0D20, X : SBC.b #$00   : PLP : ADC $B1C9, Y : STA $0FDB
    
    JSL Sprite_MakeBossDeathExplosion.silent
    
    .BRANCH_IOTA
    
    LDA.b #$FF : STA $0EB0, X
    
    RTS
}

; $0EB1D1-$0EB249 LOCAL JUMP LOCATION
{
    LDA $0DD1 : ORA $0DD2 : BNE .BRANCH_ALPHA
    
    LDA $0D80, X : CMP.b #$02 : BCS .BRANCH_ALPHA
    
    LDA.b #$FF : STA $0DF0, X
    
    LDA #$FF : STA $0D80, X
    
    ; play boss dying noise.
    LDA.b #$22 : STA $012F
    
    RTS
    
    .BRANCH_ALPHA
    
    JSR $B3B5 ; $0EB3B5 IN ROM
    JSR $B3E6 ; $0EB3E6 IN ROM
    JSR Sprite4_CheckDamage
    
    LDA $1A : AND.b #$3F : BNE .BRANCH_BETA
    
    JSR Sprite4_IsToRightOfPlayer
    
    LDA $0F : CLC : ADC.b #$18 : CMP.b #$30 : LDA.b #$00 : BCC .BRANCH_GAMMA
    
    LDA.w $B0C8, Y
    
    .BRANCH_GAMMA
    
    STA $0DC0, X
    
    .BRANCH_BETA
    
    LDA $0B0E : BEQ .BRANCH_DELTA
    
    LDA $1A : AND.b #$01 : BNE .BRANCH_EPSILON
    
    DEC $0B0E
    
    .BRANCH_EPSILON
    
    RTS
    
    .BRANCH_DELTA
    
    LDA $0DD1 : BEQ .BRANCH_ZETA
    
    LDA $0D81 : CMP.b #$03 : BEQ .return
    
    .BRANCH_ZETA
    
    LDA $0DD2 : BEQ .BRANCH_THETA
    
    LDA $0D82 : CMP.b #$03 : BEQ .return
    
    .BRANCH_THETA
    
    LDA $0D80, X
    
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
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    LDA $0E30, X : AND.b #$7F : STA $00
    
    JSL GetRandomInt : AND.b #$03 : TAY : CMP $00 : BEQ .BRANCH_ALPHA
    
    INC $0EC0, X : LDA $0EC0, X : CMP.b #$02 : BNE .BRANCH_BETA
    
    STZ $0EC0, X
    
    LDA.b #$02 : STA $0D80, X
    
    LDA.b #$50 : STA $0DF0, X
    
    RTS
    
    .BRANCH_BETA
    
    LDA.w $B24A, Y : STA $0B08
    
    LDA.w $B24E, Y : STA $0B09
    
    JSL GetRandomInt : AND.b #$03 : CMP.b #$01 : TYA : BCS .BRANCH_GAMMA
    
    ORA.b #$80
    
    .BRANCH_GAMMA
    
    STA $0E30, X
    
    INC $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0EB2A1-$0EB368 JUMP LOCATION
{
    LDA $0E30, X : CMP.b #$FF : BNE .BRANCH_ALPHA
    
    LDA $0DF0, X : BEQ .BRANCH_BETA
    
    JSR Sprite4_IsBelowPlayer
    
    CPY.b #$00 : BNE .BRANCH_ALPHA
    
    .BRANCH_BETA
    
    STZ $0E30, X
    
    JMP $B33D   ; $0EB33D IN ROM
    
    .BRANCH_ALPHA
    
    LDA $0B08    : STA $04
    LDA $0D30, X : STA $05
    
    LDA $0B09    : STA $06
    LDA $0D20, X : STA $07
    
    LDA.b #$08
    
    LDY $0E30, X : BPL .BRANCH_GAMMA
    
    LDA.b #$10
    
    .BRANCH_GAMMA
    
    JSL Sprite_ProjectSpeedTowardsEntityLong
    
    LDA $00 : STA $0D40, X
    
    LDA $01 : STA $0D50, X
    
    LDA $0D10, X : PHA
    LDA $0D00, X : PHA
    
    JSR Sprite4_Move
    
    PLA : LDY.b #$00 : SEC : SBC $0D00, X : STA $0310 : BPL .BRANCH_DELTA
    
    DEY
    
    .BRANCH_DELTA
    
    STY $0311
    
    PLA
    
    LDY.b #$00
    
    SEC : SBC $0D10, X : STA $0312 : BPL .BRANCH_EPSILON
    
    DEY
    
    .BRANCH_EPSILON
    
    STY $0313
    
    LDA.b #$01 : STA $0428
    
    JSR $AD8C ; $0EAD8C IN ROM
    
    LDA $0D00, X : SEC : SBC.b #$0C : STA $0DB0, X
    
    LDA $0B08 : SEC : SBC $0D10, X : CLC : ADC.b #$02 : CMP.b #$04 : BCS .BRANCH_ZETA
    
    LDA $0B09 : SEC : SBC $0D00, X : CLC : ADC.b #$02 : CMP.b #$04 : BCS .BRANCH_ZETA
    
    ; $0EB33D ALTERNATE ENTRY POINT
    
    STZ $0D80, X
    
    LDA.b #$30 : STA $0DF0, X
    
    .BRANCH_ZETA
    
    LDA $0E30, X : BPL .BRANCH_THETA
    
    JSR $B34D ; $0EB34D IN ROM
    
    ; $0EB34D ALTERNATE ENTRY POINT
    .BRANCH_THETA
    
    LDA $0E80, X
    
    LDY $0D50, X : BMI .BRANCH_IOTA
    
    SEC : SBC.b #$02
    
    .BRANCH_IOTA
    
    CLC : ADC.b #$01 : STA $0E80, X : AND.b #$0F : BNE .BRANCH_KAPPA
    
    LDA.b #$21 : JSL Sound_SetSfx2PanLong
    
    .BRANCH_KAPPA
    
    RTS
}

; $0EB369-$0EB387 JUMP LOCATION
{
    JSR $B3B5   ; $0EB3B5 IN ROM
    JSR $B3B5   ; $0EB3B5 IN ROM
    
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    INC $0D80, X
    
    LDA.b #$30
    
    JSL Sprite_ApplySpeedTowardsPlayerLong
    
    LDA.b #$40 : STA $0DF0, X
    
    LDA.b #$26 : STA $012F
    
    .BRANCH_ALPHA
    
    RTS
}

; $0EB388-$0EB3B2 JUMP LOCATION
{
    JSR Sprite4_Move
    
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    JSR $AD4F   ; $0EAD4F IN ROM
    
    STZ $0D80, X
    
    LDA.b #$30 : STA $0DF0, X
    
    RTS
    
    .BRANCH_ALPHA
    
    CMP.b #$20 : BNE .BRANCH_BETA
    
    LDA $0D50, X : EOR.b #$FF : INC A : STA $0D50, X
    
    LDA $0D40, X : EOR.b #$FF : INC A : STA $0D40, X
    
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
    LDA $0B0D : BNE .BRANCH_ALPHA
    
    INC $0B0C : LDA $0B0C : AND.b #$03 : BNE .BRANCH_BETA
    
    LDA $0B0B : AND.b #$01 : TAY
    
    LDA $0B0A : CLC : ADC $8000, Y : STA $0B0A
    
    CMP .unknown_0, Y : BNE .BRANCH_BETA
    
    INC $0B0B
    
    LDA.b #$08 : STA $0B0D
    
    .BRANCH_BETA
    
    RTS
    
    .BRANCH_ALPHA
    
    DEC $0B0D
    
    RTS
}

; $0EB3E6-$0EB43F LOCAL JUMP LOCATION
{
    LDA $0D90, X : STA $04
    LDA $0DA0, X : STA $05
    LDA $0DB0, X : STA $06
    LDA $0ED0, X : STA $07
    
    REP #$20
    
    LDA $04 : SEC : SBC $22 : CLC : ADC.w #$0028 : CMP.w #$0050 : BCS .BRANCH_ALPHA
    
    LDA $06 : SEC : SBC $20 : CLC : ADC.w #$0010 : CMP.w #$0040 : BCS .BRANCH_ALPHA
    
    SEP #$20
    
    LDA $031F : ORA $037B : BNE .BRANCH_ALPHA
    
    LDA.b #$01 : STA $4D
    
    LDA.b #$08 : STA $0373
    
    LDA.b #$10 : STA $46
    
    LDA #$20
    
    JSL Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA $00 : STA $27
    LDA $01 : STA $28
    
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
    
    LDA $0DC0, X : REP #$20 : ASL #5 : ADC.w #$B440 : STA $08
    
    SEP #$20
    
    LDA $0D80, X : BMI .BRANCH_ALPHA
    
    LDA $0B89, X : ORA.b #$30 : STA $0B89, X
    
    .BRANCH_ALPHA
    
    LDA.b #$04
    
    JSR Sprite4_DrawMultiple
    
    RTS
}

; $0EB587-$0EB772 LOCAL JUMP LOCATION
{
    LDA $0EB0, X : BMI .BRANCH_$EB586 ; (RTS)
    
    JSR TrinexxHeadAndSnakeDraw ; $B560 ; $0EB560 IN ROM
    
    LDA $05 : AND.b #$EF : STA $05
    
    LDA $0D80, X : CMP.b #$03 : BEQ .BRANCH_ALPHA
    
    JMP $B641   ; $0EB641 IN ROM

    .BRANCH_ALPHA

    LDA $0D90, X : SEC : SBC $0D10, X : STA $08 : BPL .BRANCH_BETA
    
    EOR.b #$FF : INC A

    .BRANCH_BETA

    STA $0A
    
    LDA $0DB0, X : SEC : SBC $0D00, X : STA $09 : BPL .BRANCH_GAMMA
    
    EOR.b #$FF : INC A

    .BRANCH_GAMMA

    STA $0B
    
    LDA.b #$07 : STA $0FB5
    
    LDA.b #$10 : STA $0FB6

    .BRANCH_ZETA

    LDY $0FB5
    
    LDA $0A : STA $4202
    
    LDA.w $B804, Y : STA $4203
    
    NOP #8
    
    ASL $4216
    
    LDA $4217 : ADC.b #$00
    
    LDY $08 : BPL .BRANCH_DELTA
    
    EOR.b #$FF : INC A

    .BRANCH_DELTA

    CLC : ADC $00
    
    LDY $0FB6
    
    STA ($90), Y
    
    LDY $0FB5
    
    LDA $0B : STA $4202
    
    LDA.w $B804, Y : STA $4203
    
    NOP #8
    
    ASL $4216
    
    LDA $4217
    
    ADC.b #$00
    
    LDY $09 : BPL .BRANCH_EPSILON
    
    EOR.b #$FF : INC A

    .BRANCH_EPSILON

    CLC : ADC $02   : LDY $0FB6 : INY : STA ($90), Y
    LDA.b #$28 :             INY : STA ($90), Y
    LDA $05    :             INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY : INY : STY $0FB6
    
    DEC $0FB5 : BPL .BRANCH_ZETA

    ; $0EB641 ALTERNATE ENTRY POINT

    REP #$20
    
    LDA.w #$09F0 : STA $90
    
    LDA.w #$0A9C : STA $92
    
    SEP #$20
    
    LDA $0D90, X : SEC : SBC $E2 : STA $00
    
    LDA $0DB0, X : SEC : SBC $E8 : STA $02
    LDA $0D20, X : SBC $E9 : STA $03
    
    LDA.b #$01 : STA $0FB5
    
    LDA $0D50, X : CLC : ADC.b #$03 : CMP.b #$07 : LDA.b #$00 : BCC .BRANCH_THETA
    
    LDA $0E80, X : LSR #2 : AND.b #$0F

    .BRANCH_THETA

    STA $06
    
    CLC : ADC.b #$08 : AND.b #$0F : STA $07
    
    LDA $0E80, X : LSR #2 : AND.b #$0F : STA $08
    CLC : ADC.b #$08           : AND.b #$0F : STA $09
    
    LDY.b #$00
    
    PHX

    .BRANCH_IOTA

    LDA $00 : CLC : ADC $B80C, X : PHA
    
    LDA $06, X : TAX
    
    PLA : CLC : ADC $B810, X          : STA ($90), Y
                          INY #4 : STA ($90), Y
    
    LDA $02 : CLC : ADC.b #$F8 : PHA
    
    LDX $0FB5
    
    LDA $08, X : TAX
    
    PLA : CLC : ADC $B820, X
    
    DEY #3
    
    STA ($90), Y
    
    CLC : ADC.b #$10 : INY #4 : STA ($90), Y
    
    LDA.b #$0C : DEY #3 : STA ($90), Y
    
    LDA.b #$2A : INY #4 : STA ($90), Y
    
    DEY #3
    
    LDX $0FB5
    
    LDA $05 : ORA $B80E, X : STA ($90), Y
    
    INY #4 : STA ($90), Y
    
    PHY
    
    TYA : LSR #2 : TAY
    
    LDA.b #$02      : STA ($92), Y
                DEY : STA ($92), Y
    
    PLY : INY
    
    DEC $0FB5 : BPL .BRANCH_IOTA
    
    LDA $0B0A : ASL #2 : ADC $0B0A : STA $06
    
    LDY.b #$00
    LDX.b #$00

    .BRANCH_LAMBDA

    PHX
    
    TXA : CLC : ADC $06 : ASL A : TAX
    
    REP #$20
    
    LDA $00 : CLC : ADC $B773, X : STA $096C, Y
    
    LDA $02 : SEC : SBC $B7B9, X : SBC.w #$0020 : CLC : ADC $0B0F : INY : STA $096C, Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .BRANCH_KAPPA
    
    LDA.b #$F0 : STA $096C, Y

    .BRANCH_KAPPA

    PLX
    
    LDA.w $B7FF, X : INY : STA $096C, Y
    LDA $05      : INY : STA $096C, Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b #$02 : STA $0A7B, Y
    
    PLY : INY
    
    INX : CPX.b #$05 : BNE .BRANCH_LAMBDA
    
    PLX
    
    LDA $11 : BEQ .BRANCH_MU
    
    LDY.b #$02
    LDA.b #$03
    
    JSL Sprite_CorrectOamEntriesLong

    .BRANCH_MU

    RTS
}

; ==============================================================================
