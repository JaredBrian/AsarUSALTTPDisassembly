
; ==============================================================================

; $04F7DE-$04F81C LONG JUMP LOCATION
Polyhedral_InitThread:
{
    PHP : PHB
    
    REP #$30
    
    PHA : PHX : PHY
    
    LDA.w #$0000 : STA.l $001F00
    LDX.w #$1F00
    LDY.w #$1F02
    
    ; Initialization.
    LDA.w #$00FD
    
    MVN.l $00,$00
    
    LDA.w #$1F31 : STA.w $1F0A
    
    LDA.w #$000C
    LDX.w #.thread_init_state
    LDY.w #$1F32
    
    MVN.l $09,$00
    
    PLY : PLX : PLA 
    
    PLB : PLP
    
    RTL
    
    .thread_init_state
    db $09          ; For B register
    dw $1F00        ; For D register
    dw $0000        ; For Y register
    dw $0000        ; For X register
    dw $0000        ; For A register
    db $30          ; Status register at return addres location.
    dl $09F81D      ; Return address in helper thread
}
    
; ==============================================================================

; $04F81D-$04F83C
{
    ; Polyhedral thread entry point
    
    .wait
    
    LDA.b $00 : BEQ .wait
    LDA.b $0C : BNE .wait
    
    JSL.l $09FD04 ; $04FD04 in ROM
    
    JSR.w $F83D ; $04F83D in Rom.
    JSR.w $F864 ; $04F864 in Rom.
    JSR.w $F8FB ; $04F8FB in Rom.
    JSR.w $FA4F ; $04FA4F in Rom.
    
    STZ.b $00
    
    LDA.b #$FF : STA.b $0C
    
    BRA .wait
}

; $04F83D-$04F863 LOCAL JUMP LOCATION
{
    REP #$30
    
    LDA.b $02 : AND.w #$00FF : ASL A : ADC.w #$0080 : STA.b $08
    
    LDA.w $1F03 : AND.w #$00FF : ASL A : STA.b $B0
    
    ; X = ( 0xFF8C + ($1F03 * 6) ).
    ; Note that $1F03 seems to always be 0 or 1
    ASL A : ADC.b $B0 : ADC.w #$FF8C : TAX
    
    LDY.w #$1F3F
    LDA.w #$0005
    
    MVN.l $09,$09
    
    RTS
}

; $04F864-$04F8FA LOCAL JUMP LOCATION
{
    SEP #$30
    
    LDY.b $04
    
    LDA.w $FB6D, Y : STA.b $50
    
    CMP.b #$80 : SBC.b $50 : EOR.b #$FF : STA.b $51
    
    LDA.w $FBAD, Y : STA.b $52
    
    CMP.b #$80 : SBC.b $52 : EOR.b #$FF : STA.b $53
    
    LDY.b $05
    
    LDA.w $FB6D, Y : STA.b $54
    
    CMP.b #$80 : SBC.b $54 : EOR.b #$FF : STA.b $55
    
    LDA.w $FBAD, Y : STA.b $56
    
    CMP.b #$80 : SBC.b $56 : EOR.b #$FF : STA.b $57
    
    REP #$20
    
    SEI
    
    LDX.b $54 : STX.w $211B
    LDX.b $55 : STX.w $211B
    LDX.b $50 : STX.w $211C
    
    LDA.w $2135 : ASL #2 : STA.b $58
    
    LDX.b $56 : STX.w $211B
    LDX.b $57 : STX.w $211B
    LDX.b $52 : STX.w $211C
    
    LDA.w $2135 : ASL #2 : STA.b $5E
    
    LDX.b $56 : STX.w $211B
    LDX.b $57 : STX.w $211B
    LDX.b $50 : STX.w $211C
    
    LDA.w $2135 : ASL #2 : STA.b $5A
    
    LDX.b $54 : STX.w $211B
    LDX.b $55 : STX.w $211B
    LDX.b $52 : STX.w $211C
    
    LDA.w $2135 : ASL #2 : STA.b $5C
    
    CLI
    
    RTS
}

; $04F8FB-$04F930
{
    SEP #$30
    
    LDA.b $3F : TAX
    
    ; Y = 3 * $3F
    ASL A : ADC.b $3F : TAY
    
    .alpha
    
    DEX
    
    DEY
    
    LDA ($41), Y : STA.b $47
    
    DEY
    
    LDA ($41), Y : STA.b $46
    
    DEY
    
    LDA ($41), Y : STA.b $45
    
    PHY
    
    REP #$20
    
    JSR.w $F931 ; $04F931 in rom.
    JSR.w $F9D6 ; $04F9D6 in Rom.
    
    SEP #$20
    
    CLC : LDA.b $06 : ADC.b $48 : STA.b $60, X
    SEC : LDA.b $07 : SBC.b $4A : STA.b $88, X
    
    PLY : BNE .alpha
    
    RTS
}
    
; $04F931-$04F9D5
{
    LDY.b $56
    
    SEI
    
              STY.w $211B
    LDY.b $57 : STY.w $211B
    LDY.b $45 : STY.w $211C
    
    LDA.w $2134
    
    LDY.b $54 : STY.w $211B
    LDY.b $55 : STY.w $211B
    LDY.b $47 : STY.w $211C
    
    SEC : SBC.w $2134
    
    CLI
    
    STA.b $48
    
    LDY.b $58
    
    SEI
    
              STY.w $211B
    LDY.b $59 : STY.w $211B
    LDY.b $45 : STY.w $211C
    
    LDA.w $2134
    
    LDY.b $52 : STY.w $211B
    LDY.b $53 : STY.w $211B
    LDY.b $46 : STY.w $211C
    
    CLC : ADC.w $2134
    
    LDY.b $5A : STY.w $211B
    LDY.b $5B : STY.w $211B
    LDY.b $47 : STY.w $211C
    
    CLC : ADC.w $2134
    
    CLI
    
    STA.b $4A
    
    LDY.b $5C
    
    SEI
    
              STY.w $211B
    LDY.b $5D : STY.w $211B
    LDY.b $45 : STY.w $211C
    
    LDA.w $2135
    
    LDY.b $50 : STY.w $211B
    LDY.b $51 : STY.w $211B
    LDY.b $46 : STY.w $211C
    
    SEC : SBC.w $2135
    
    LDY.b $5E : STY.w $211B
    LDY.b $5F : STY.w $211B
    LDY.b $47 : STY.w $211C
    
    CLC : ADC.w $2135
    
    ; Note that this combines a CLC with a CLI
    REP #$05
    
    ADC.b $08 : STA.b $4C
    
    RTS
}

; $04F9D6-$04FA4E
{
    LDA.b $48 : BPL .alpha
    
    EOR.w #$FFFF : INC A
    
    .alpha
    
    STA.b $B2
    
    LDA.b $4C : STA.b $B0
    
    XBA : AND.w #$00FF : BEQ .gamma
    
    .beta
    
    LSR.b $B2
    LSR.b $B0
    
    LSR A : BNE .beta
    
    .gamma
    
    SEI
    
    LDA.b $B2 : STA.w $4204
    LDY.b $B0 : STY.w $4206
    
    NOP #2
    
    LDA.w #$0000
    
    LDY.b $49
    
    SEC
    
    BMI .delta
    
    NOP
    
    LDA.w $4214
    
    BRA .epsilon
    
    .delta
    
    SBC.w $4214
    
    .epsilon
    
    CLI
    
    STA.b $48
    
    ; $4FA12
    
    LDA.b $4A : BPL .zeta
    
    EOR.w #$FFFF : INC A
    
    .zeta
    
    STA.b $B2
    
    LDA.b $4C : STA.b $B0
    
    XBA : AND.w #$00FF : BEQ .iota
    
    .theta
    
    LSR.b $B2
    LSR.b $B0
    
    LSR A : BNE .theta
    
    .iota
    
    SEI
    
    LDA.b $B2 : STA.w $4204
    LDY.b $B0 : STY.w $4206
    
    NOP #2
    
    LDA.w #$0000
    
    LDY.b $4B
    
    SEC
    
    BMI .kappa
    
    NOP
    
    LDA.w $4214
    
    BRA .lamba
    
    .kappa
    
    SBC.w $4214
    
    .lambda
    
    CLI
    
    STA.b $4A
    
    RTS
}

; $04FA4F-$04FAC9
{
    SEP #$30
    
    LDY.b #$00
    
    .delta
    
    LDA ($43), Y : STA.b $4E
    
    AND.b #$7F : STA.b $B0
    
    ASL A : STA.b $C0
    
    INY
    
    LDX.b #$01
    
    .alpha
    
    PHY
    
    LDA ($43), Y : TAY
    
    LDA.w $1F60, Y : STA.b $C0, X
    
    INX
    
    LDA.w $1F88, Y : STA.b $C0, X
    
    INX
    
    PLY : INY
    
    DEC.b $B0 : BNE .alpha
    
    LDA ($43), Y
    
    INY
    
    STA.b $4F
    
    PHY
    
    LDA.b $C0 : CMP.b #$06 : BCC .beta
    
    JSR.w $FB24 : BMI .gamma : BEQ .beta
    
    JSR.w $FACA   ; $04FACA in Rom.
    JSL.l $09FD1E ; $04FD1E in Rom.
    
    .beta
    
    PLY
    
    DEC.b $40 : BNE .delta
    
    RTS
    
    .gamma
    
    LDA.b $4E : BPL .beta
    
    REP #$20
    
    LDA.b $C0 : AND.w #$00FF : TAY
    
    DEY
    
    LDX.b #$01
    
    LSR #2 : STA.b $B0
    
    .epsilon
    
    LDA.b $C0, X : PHA
    
    LDA.w $1FC0, Y : STA.b $C0, X
    
    PLA
    
    STA.w $1FC0, Y
    
    INX #2
    
    DEY #2
    
    DEC.b $B0 : BNE .epsilon
    
    SEP #$20
    
    JSR.w $FAD7   ; $04FAD7 in rom.
    JSL.l $09FD1E ; $04FD1E in Rom.
    
    JMP .beta
}

; $04FACA-$04FAD6 LOCAL JUMP LOCATION
{
    LDA.b $01 : BNE .BRANCH_4FAD7_external_1
    
    LDA.b $4F : AND.b #$07
    
    JSL.l $09FCAE ; $04FCAE in ROM.
    
    RTS
}

; $04FAD7-$04FB23
{
    LDA.b $01 : BNE .alpha
    
    LDA.b $4F : LSR #4 : AND.b #$07
    
    JSL.l $09FCAE ; $04FCAE in ROM.
    
    RTS
    
    .alpha
    
    REP #$20
    
    LDA.b $B0 : EOR.w #$FFFF : INC A
    
    BRA .beta
    
    .external_1
    
    REP #$20
    
    LDA.b $B0
    
    .beta
    
    PHA
    
    LDA.w $1F03 : AND.w #$00FF : BEQ .gamma
    
    LDA.w $1F02 : AND.w #$00FF : LSR #5
    
    .gamma
    
    TAX
    
    PLA
    
    .shift
    
    ASL A
    
    DEX : BPL .shift
    
    SEP #$20
    
    XBA : BNE .delta
    
    LDA.b #$01
    
    BRA .epsilon
    
    .delta
    
    CMP.b #$08 : BCC .epsilon
    
    LDA.b #$07
    
    .epsilon
    
    JSL.l $09FCAE ; $04FCAE in ROM.
    
    RTS
}

; $04FB24-$04FB6C
{
    ; (set I and C flags)
    SEP #$05
    
    LDA.b $C3 : SBC.b $C1 : STA.w $211B
    
    LDA.b #$00 : SBC.b #$00 : STA.w $211B
    
    SEC : LDA.b $C6 : SBC.b $C4 : STA.w $211C
    
    ; apparently it's super important to keep the I flag low
    ; for as little time as possible.
    LDA.w $2134       : STA.b $B0
    LDA.w $2135 : CLI : STA.b $B1
    
    SEP #$05
    
    LDA.b $C5    : SBC.b $C3    : STA.w $211B
    LDA.b #$00 : SBC.b #$00 : STA.w $211B
    
    SEC : LDA.b $C4 : SBC.b $C2 : STA.w $211C
    
    REP #$20
    
    SEC : LDA.b $B0 : SBC.w $2134 : STA.b $B0
    
    SEP #$20
    CLI
    
    RTS
}

; $04FB6D-$04FCAD DATA
{
    ; $4FBAD
}

; $04FCAE-$04FCC3 LONG JUMP LOCATION
{
    PHP
    
    SEP #$30
    
    ASL #2 : TAX
    
    REP #$20
    
    LDA.l $09FCC4, X : STA.b $B5
    LDA.l $09FCC6, X : STA.b $B7
    
    PLP
    
    RTL
}

; $04FCC4-$04FD03 DATA
{
    ; Masks for different bitplanes (0 - 3)?
    dd $00000000
    dd $000000FF
    dd $0000FF00
    dd $0000FFFF
    dd $00FF0000
    dd $00FF00FF
    dd $00FFFF00
    dd $00FFFFFF
    dd $FF000000
    dd $FF0000FF
    dd $FF00FF00
    dd $FF00FFFF
    dd $FFFF0000
    dd $FFFF00FF
    dd $FFFFFF00
    dd $FFFFFFFF
}

; $04FD04-$04FD1D LONG JUMP LOCATION
{
    PHP : PHB
    
    REP #$30
    
    LDA.w #$0000 : STA.l $7EE800
    
    LDX.w #$E800
    LDY.w #$E802
    LDA.w #$07FD
    
    MVN.w $7E7E
    
    PLB : PLP
    
    RTL
}

; $04FD1E-$04FDCE LONG JUMP LOCATION
{
    PHP : PHB
    
    SEP #$30
    
    LDA.b #$7E : PHA : PLB
    
    LDY.b $C0 : TYX
    
    LDA.b $C0, X
    
    .alpha
    
    DEX #2 : BEQ .beta
    
    ; (<= comparison)
    CMP $C0, X : BCC .alpha : BEQ .alpha
    
    TXY
    
    LDA.b $C0, X
    
    BRA .alpha
    
    .beta
    
    AND.b #$07 : ASL A : STA.b $B9
    
    LDA.w $1FC0, Y : AND.b #$38 : BIT.b #$20 : BEQ .gamma
    
    EOR.b #$24
    
    .gamma
    
    LSR #2 : ADC.b #$E8 : STA.b $BA
    
    STY.b $E9 : STY.b $F2
    
    LDA.b $C0 : LSR A : STA.b $E0
    
    LDA.w $1FC0, Y : STA.b $E2 : STA.b $EB
    LDA.w $1FBF, Y : STA.b $E1 : STA.b $EA
    
    JSR.w $FEB4 : BCS .delta
    JSR.w $FF1E : BCC .epsilon
    
    .delta
    
    PLB : PLP
    
    RTL
    
    .epsilon
    
    JSR.w $FDCF ; $04FDCF in Rom.
    
    LDA.b $B9 : INC #2 : CMP.b #$10 : BEQ .zeta
    
    STA.b $B9
    
    BRA .iota
    
    .zeta
    
    LDA.b $BA : INC #2 : BIT.b #$08 : BNE .theta
    
    EOR.b #$19
    
    .theta
    
    STA.b $BA : STZ.b $B9
    
    .iota
    
    LDX.b $E2 : CPX.b $E4 : BNE .kappa
    
    LDX.b $E3 : STX.b $E1
    
    JSR.w $FEB4 : BCS .delta
    
    LDX.b $E2
    
    .kappa
    
    INX : STX.b $E2
    
    LDX.b $EB : CPX.b $ED : BNE .lambda
    
    LDX.b $EC : STX.b $EA
    
    JSR.w $FF1E : BCS .delta
    
    LDX.b $EB
    
    .lambda
    
    INX : STX.b $EB
    
    REP #$21
    
          LDA.b $E5 : ADC.b $E7 : STA.b $E5
    CLC : LDA.b $EE : ADC.b $F0 : STA.b $EE
    
    SEP #$20
    
    BRA .epsilon
    
    .unused_code
    
    PLB : PLP
    
    RTL
}

; $04FDCF-$04FE93 LOCAL JUMP LOCATION
{
    LDA.b $E6 : AND.b #$07 : ASL A : TAY
    
    LDA.b $EF : AND.b #$07 : ASL A : TAX
    
    LDA.b $E6 : AND.b #$38 : STA.b $BC
    
    LDA.b $EF : AND.b #$38 : SEC : SBC.b $BC : BNE .alpha
    
    REP #$30
    
    LDA.l $09FEA4, X : TYX : AND.l $09FE94, X : STA.b $B2
    
    LDA.b $EF : AND.w #$0038 : ASL #2 : ORA.b $B9 : TAY
    
    LDA.b $B5 : EOR.w $0000, Y : AND.b $B2 : EOR.w $0000, Y : STA.w $0000, Y
    LDA.b $B7 : EOR.w $0010, Y : AND.b $B2 : EOR.w $0010, Y : STA.w $0010, Y
    
    .return
    
    SEP #$30
    
    RTS
    
    .alpha
    
    BCC .return
    
    LSR #3 : STA.b $FA : STZ.b $FB
    
    REP #$30
    
    LDA.l $09FEA4, X : STA.b $B2
    
    TYX
    
    LDA.b $EF : AND.w #$0038 : ASL #2 : ORA.b $B9 : TAY
    
    LDA.b $B5 : EOR.w $0000, Y : AND.b $B2 : EOR.w $0000, Y : STA.w $0000, Y
    LDA.b $B7 : EOR.w $0010, Y : AND.b $B2 : EOR.w $0010, Y : STA.w $0010, Y
    
    SEC : TYA : SBC.w #$0020 : TAY
    
    DEC.b $FA : BEQ .beta
    
    .gamma
    
    LDA.b $B5 : STA.w $0000, Y
    LDA.b $B7 : STA.w $0010, Y
    
    TYA : SBC.w #$0020 : TAY
    
    DEC.b $FA : BNE .gamma
    
    .beta
    
    LDA.l $09FE94, X : STA.b $B2
    
    LDA.b $B5 : EOR.w $0000, Y : AND.b $B2 : EOR.w $0000, Y : STA.w $0000, Y
    LDA.b $B7 : EOR.w $0010, Y : AND.b $B2 : EOR.w $0010, Y : STA.w $0010, Y
    
    SEP #$30
    
    RTS
}

; $04FE94-$04FEB3 DATA
{
    dw $FFFF, $7F7F, $3F3F, $1F1F, $0F0F, $0707, $0303, $0101
    
    ; $4FEA4
    
    dw $8080, $C0C0, $E0E0, $F0F0, $F8F8, $FCFC, $FEFE, $FFFF
}

; $04FEB4-$04FF1D LOCAL JUMP LOCATION
{
    .loop
    
    DEC.b $E0 : BPL .alpha
    
    .gamma
    
    SEC
    
    RTS
    
    .alpha
    
    LDX.b $E9 : DEX #2 : BNE .beta
    
    LDX.b $C0
    
    .beta
    
    STA.b $C0, X : CMP $E2 : BCC .gamma : BNE .delta
    
    LDA.b $BF, X : STA.b $E1
    
    STX.b $E9
    
    BRA .loop
    
    .delta
    
    STA.b $E4
    
    LDA.b $BF, X : STA.b $E3
    
    STX.b $E9
    
    LDX.b #$00
    
    SBC.b $E1 : BCS .epsilon
    
    DEX
    
    EOR.b #$FF : INC A
    
    .epsilon
    
    SEI
    
                 STA.l $004205
    LDA.b #$00 : STA.l $004204
    
    SEC : LDA.b $E4 : SBC.b $E2 : STA.l $004206
    
    REP #$20
    
    LDA.b $E0 : AND.w #$FF00 : ORA.w #$0080 : STA.b $E5
    
    LDA.w #$0000
    
    CPX.b #$00 : BNE .zeta
    
    LDA.l $004214
    
    BRA .theta
    
    .zeta
    
    SEC : SBC.l $004214
    
    .theta
    
    CLI
    
    STA.b $E7
    
    SEP #$20
    
    CLC
    
    RTS
}

; $04FF1E-$04FF8B LOCAL JUMP LOCATION
{
    .loop
    
    DEC.b $E0 : BPL .alpha
    
    .delta
    
    SEC
    
    RTS
    
    .alpha
    
    LDX.b $F2 : CPX.b $C0 : BNE .beta
    
    LDX.b #$02
    
    BRA .gamma
    
    .beta
    
    INX #2
    
    .gamma
    
    LDA.b $C0, X : CMP $EB : BCC .delta : BNE .epsilon
    
    LDA.b $BF, X : STA.b $EA
    
    STX.b $F2
    
    BRA .loop
    
    .epsilon
    
    STA.b $ED
    
    LDA.b $BF, X : STA.b $EC
    
    STX.b $F2
    
    LDX.b #$00
    
    SEC : SBC.b $EA : BCS .zeta
    
    DEX
    
    EOR.b #$FF : INC A
    
    .zeta
    
    SEI
    
                 STA.l $004205
    LDA.b #$00 : STA.l $004204
    
    SEC : LDA.b $ED : SBC.b $EB : STA.l $004206
    
    REP #$20
    
    LDA.b $E9 : AND.w #$FF00 : ORA #$0080 : STA.b $EE
    
    LDA.w #$0000
    
    CPX.b #$00 : BNE .theta
    
    LDA.l $004214
    
    BRA .iota
    
    .theta
    
    SEC : SBC.l $004214
    
    .iota
    
    CLI
    
    STA.b $F0
    
    SEP #$20
    
    CLC
    
    RTS
}

; $04FF8C-$04FF97 DATA (rest is not mapped)
{
    ; \task Figure out where this array really ends. Does it cross
    ; bank boundaries?
    db $06, $08
    dw $FF98
    dw $FFAA
    
    db $06, $05
    dw $FFD2
    dw $FFE4
}

