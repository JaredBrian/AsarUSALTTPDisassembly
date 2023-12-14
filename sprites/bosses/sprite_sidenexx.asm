
; ==============================================================================

; $0EB897-$0EB92A JUMP LOCATION
Sprite_Sidenexx:
{
    ; One of the two side heads?
Sprite_CC_TrinexxBreath_FireHead:
    LDA $0E90, X : BEQ Sidenexx
    
    JMP TrinexxBreath_fire ; $0EBDC6 IN ROM
    
    ; $0EB89F ALTERNATE ENTRY POINT
    Sprite_CD_TrinexxBreath_IceHead
    ; One of the two side heads?
    
    LDA $0E90, X : BEQ Sidenexx
    
    JMP TrinexxBreath_ice ; $0EBD28 IN ROM
    
Sidenexx:
    
    LDA $0E20, X : SEC : SBC.b #$CC : TAY
    
    LDA $0D90 : CLC : ADC $B88A, Y : STA $0D90, X
    LDA $0DA0 : ADC $B88C, Y : STA $0DA0, X
    
    LDA $0DB0 : SEC : SBC.b #$20 : STA $0DB0, X
    
    LDA $0ED0 : SBC.b #$00 : STA $0ED0, X
    
    LDA $0B89, X : ORA.b #$30 : STA $0B89, X
    
    JSR $BB70 ; $0EBB70 IN ROM
    JSR Sprite4_CheckIfActive
    
    LDA $0D80, X : BPL .BRANCH_BETA
    
    STA $0BA0, X
    
    JMP $BB3F ; $0EBB3F IN ROM
    
    .BRANCH_BETA
    
    LDA $0EF0, X : BEQ .BRANCH_GAMMA
    
    LDA $0D80, X : CMP.b #$04 : BEQ .BRANCH_GAMMA
    
    STZ $0EF0, X
    
    LDA.b #$80 : STA $0DF0, X
    LDA.b #$04 : STA $0D80, X
    
    LDA $0F50, X : STA $0F80, X
    
    LDA.b #$03 : STA $0F50, X
    
    .BRANCH_GAMMA
    
    JSR Sprite4_CheckDamage
    
    LDA $0CAA, X : ORA.b #$04 : STA $0CAA, X
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Sidenexx_Dormant ; = $EB986*
    dw Sidenexx_Think   ; = $EB9A6*
    dw Sidenexx_Move    ; = $EB9F2*
    dw Sidenexx_Breathe ; = $EBA70*
    dw Sidenexx_Stunned ; = $EB92B*
}

; $0EB92B-$0EB985 JUMP LOCATION
Sidenexx_Stunned:
{
    LDA $0CAA, X : AND.b #$FB : STA $0CAA, X
    
    STZ $0E30, X
    
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    PHA
    
    LDA.b #$01 : STA $0D80, X
    LDA.b #$20 : STA $0DF0, X
    
    LDA $0F80, X : STA $0F50, X
    
    STZ $0EF0, X
    
    PLA

    .BRANCH_ALPHA

    CMP.b #$0F : BCC .BRANCH_BETA
    CMP.b #$4E : BCS .BRANCH_GAMMA
    CMP.b #$3F : BCC .BRANCH_GAMMA
    
    LDA $0E20, X : CMP.b #$CD : BNE .BRANCH_DELTA
    
    PHX
    
    JSL PaletteFilter_IncreaseTrinexxBlue
    
    PLX
    
    RTS

    .BRANCH_DELTA

    PHX
    
    JSL PaletteFilter_IncreaseTrinexxRed
    
    PLX

    .BRANCH_GAMMA

    RTS

    .BRANCH_BETA

    LDA $0E20, X : CMP.b #$CD : BNE .BRANCH_EPSILON
    
    PHX
    
    JSL PaletteFilter_RestoreTrinexxBlue
    
    PLX
    
    RTS

    .BRANCH_EPSILON

    PHX
    
    JSL PaletteFilter_RestoreTrinexxRed
    
    PLX
    
    RTS
}

; $0EB986-$0EB9A5 JUMP LOCATION
Sidenexx_Dormant:
{
    LDA $0E60, X : ORA.b #$40 : STA $0E60, X
    
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    LDA.b #$02 : STA $0D80, X
    LDA.b #$09 : STA $0E80, X
    
    LDA $0E60, X : AND.b #$BF : STA $0E60, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0EB9A6-$0EB9F1 JUMP LOCATION
Sidenexx_Move:
{
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    LDA $0DE0, X : STA $00
    
    JSL GetRandomInt : AND.b #$07 : INC A : CMP.b #$05 : BCS .BRANCH_ALPHA
    
    CMP $0DE0, X : BEQ .BRANCH_ALPHA
    
    STA $0DE0, X
    
    INC $0D80, X
    
    LDA $00 : CMP.b #$01 : BNE .BRANCH_ALPHA
    
    JSL GetRandomInt : LSR A : BCS .BRANCH_ALPHA
    
    LDA $0D80 : CMP.b #$02 : BCS .BRANCH_ALPHA
    
    INC $0DC0, X : LDA $0DC0, X : CMP.b #$06
    
    NOP #2
    
    STZ $0DC0, X
    
    LDA.b #$03 : STA $0D80, X
    
    LDA.b #$7F : STA $0DF0, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0EB9F2-$0EBA66 JUMP LOCATION
Sidenexx_Think:
{
    STZ $01
    
    LDA $0DE0, X : ASL #3 : ADC $0DE0, X : TAY
    
    LDA $BB6D, X : PHX : TAX
    
    LDA.b #$08 : STA $00
    
    .BRANCH_IOTA
    
    LDA $1D10, X : CMP $B830, Y : BEQ .BRANCH_ALPHA  BPL .BRANCH_BETA
    
    INC $1D10, X
    
    INC $01
    
    BRA .BRANCH_ALPHA
    
    .BRANCH_BETA
    
    DEC $1D10, X
    
    INC $01
    
    .BRANCH_ALPHA
    
    LDA $1D10, X : CMP $B830, Y : BEQ .BRANCH_GAMMA  BPL .BRANCH_DELTA
    
    INC $1D10, X
    
    INC $01
    
    BRA .BRANCH_GAMMA
    
    .BRANCH_DELTA
    
    DEC $1D10, X
    
    INC $01
    
    .BRANCH_GAMMA
    
    LDA $1A : AND.b #$00 : BNE .BRANCH_EPSILON
    
    LDA $1D50, X : CMP $B85D, Y : BEQ .BRANCH_ZETA  BPL .BRANCH_THETA
    
    INC $1D50, X
    
    INC $01
    
    BRA .BRANCH_ZETA
    
    .BRANCH_THETA
    
    DEC $1D50, X
    
    .BRANCH_EPSILON
    
    INC $01
    
    .BRANCH_ZETA
    
    INX
    
    INY
    
    DEC $00 : BPL .BRANCH_IOTA
    
    PLX
    
    LDA $01 : BNE .BRANCH_KAPPA
    
    DEC $0D80, X
    
    JSL GetRandomInt : AND.b #$0F : STA $0DF0, X
    
    .BRANCH_KAPPA
    
    RTS
}

; $0EBA70-$0EBAE5 JUMP LOCATION
Sidenexx_Breathe:
{
    LDA $0DF0, X : BNE .breathe_yes
    
    STZ $0D80, X
    
    LDA.b #$20 : STA $0DF0, X
    
    RTS
    
    .breathe_yes
    
    CMP.b #$40 : BNE .dont_breathe
    
    PHA
    
    JSR Sidenexx_ExhaleDanger ; $0EBAE8 IN ROM
    
    PLA
    
    .dont_breathe
    
    CMP.b #$08              : BCC .continue
    CMP.b #$79 : LDA.b #$08 : BCC .continue
    
    LDA $0DF0, X : CLC : ADC.b #$80 : EOR.b #$FF
    
    .continue
    STA $0E30, X
    
    LDA $0DF0, X : CMP.b #$40 : BCC .BRANCH_DELTA
    

    SEC : SBC.b #$40 : LSR #3 : TAY
    
    LDA $1A : AND $BA68, Y : BNE .exit
    
    JSL GetRandomInt : AND.b #$0F : LDY.b #$00 : SEC : SBC.b #$03
                                                  STA $00 : BPL .positive
    
    DEY
    
    .positive
    
    STY $01
    
    JSL GetRandomInt : AND.b #$0F : CLC : ADC.b #$0C : STA $02 : STZ $03
    
    JSL Sprite_SpawnSimpleSparkleGarnish
    
    LDA $0E20, X : CMP.b #$CC : BNE .exit
    
    PHX
    
    LDX $0F
    
    LDA.b #$0E : STA $7FF800, X
    
    PLX
    
    .exit
    RTS
}

; ==============================================================================

; $0EBAE6-$0EBAE7 DATA
pool SidenexxExhaleDanger:
{
    ; \task Name this routine / pool
    .x_accelerations
    db -2, 1
}

; ==============================================================================

; $0EBAE8-$0EBB3E LOCAL
Sidenexx_ExhaleDanger:
{
    LDA $0E20, X : CMP.b #$CD : BNE .breathe_fire
    
    STZ $0FB6
    
    JSR .breathe_ice ; $0EBAFA IN ROM
    
    INC $0FB6
    
    LDA.b #$CD
    
    ; $0EBAFA ALTERNATE ENTRY POINT
    .breathe_ice
    
    JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL Sprite_SetSpawnedCoords
    
    PHX
    
    LDX $0FB6
    
    LDA .x_accelerations, X : STA $0DB0, Y
    
    PLX
    
    LDA.b #$19 : JSL Sound_SetSfx3PanLong
    
    BRA .final_adjustments
    
    .breathe_fire
    
    JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$2A : JSL Sound_SetSfx2PanLong
    
    .final_adjustments
    
    LDA.b #$01 : STA $0E90, Y
                 STA $0BA0, Y
    
    LDA.b #$18 : STA $0D40, Y
    
    LDA.b #$00 : STA $0E40, Y
    
    LDA.b #$40 : STA $0E60, Y
    
    .spawn_failed
    
    RTS
}

; $0EBB3F-$0EBB6C LOCAL
{
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    LDA.b #$0C : STA $0DF0, X
    
    LDA $0E80, X : CMP.b #$01 : BNE .BRANCH_BETA
    
    STZ $0DD0, X
    
    .BRANCH_BETA
    
    DEC $0E80, X
    
    LDA $0FD8 : CLC : ADC $E2 : STA $0FD8
    
    LDA $0FDA : CLC : ADC $E8 : STA $0FDA
    
    JSL Sprite_MakeBossDeathExplosion
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $0EBB6D-$0EBB6F DATA
{
    ; \task Apply labels to this pool / routine.
    db 0, 9, 18
}

; ==============================================================================

; $0EBB70-$0EBC8B LOCAL
SpriteDraw_Sidenexx:
{
    LDA $0D90, X : STA $0D10, X
    
    LDA $0DA0, X : STA $0D30, X
    
    LDA $0DB0, X : STA $0D00, X
    
    LDA $0ED0, X : STA $0D20, X
    
    JSL Sprite_Get_16_bit_CoordsLong
    JSR Sprite4_PrepOamCoord
    
    STZ $0FB5
    STZ $0FB6
    
    ; $0EBB95 ALTERNATE ENTRY POINT
    
    LDY $0FB5
    
    TYA : CLC : ADC $BB6D, X : TAY
    
    CPX.b #$02 : BEQ .BRANCH_ALPHA
    
    LDA   $1D10, Y : EOR.b #$FF : INC A : STA $06
    LDA.b #$01                        : STA $07
    
    BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA $1D10, Y : STA $06 : STZ $07
    
    .BRANCH_BETA
    
    LDA $1D50, Y : STA $0F
    
    PHX
    
    REP #$30
    
    LDA $06 : AND.w #$00FF : ASL A : TAX
    
    LDA $04E800, X : STA $0A
    
    LDA $06 : CLC : ADC.w #$0080 : STA $08
    AND.w #$00FF : ASL A : TAX
    
    LDA $04E800, X : STA $0C
    
    SEP #$30
    
    PLX
    
    LDA $0A : STA $4202
    
    LDA $0F
    
    LDY $0B : BNE .BRANCH_GAMMA
    
    STA $4203
    
    NOP #8
    
    ASL $4216
    
    LDA $4217 : ADC.b #$00
    
    .BRANCH_GAMMA
    
    LSR $07 : BCC .BRANCH_DELTA
    
    EOR.b #$FF : INC A
    
    .BRANCH_DELTA
    
    STA $0FA8
    
    LDA $0C : STA $4202
    
    LDA $0F
    
    LDY $0D : BNE .BRANCH_EPSILON
    
    STA $4203
    
    NOP #8
    
    ASL $4216
    
    LDA $4217 : ADC.b #$00
    
    .BRANCH_EPSILON
    
    LSR $09 : BCC .BRANCH_ZETA
    
    EOR.b #$FF : INC A
    
    .BRANCH_ZETA
    
    STA $0FA9
    
    LDA $0FB5 : BNE .BRANCH_THETA
    
    JSR $BCA0 ; $0EBCA0 IN ROM
    
    BRA .BRANCH_IOTA
    
    .BRANCH_THETA
    
    LDA   $00 : CLC : ADC $0FA8 : LDY $0FB6 : STA ($90), Y : STA $0FD8
    LDA   $0FA9 : CLC : ADC $02 : LDY $0FB6 : INY : STA ($90), Y : STA $0FDA
    LDA.b #$08 : INY : STA ($90),   Y
    LDA   $05 : INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY : INY : STY $0FB6
    
    .BRANCH_IOTA
    
    INC $0FB5 : LDA $0FB5 : CMP $0E80, X : BEQ .BRANCH_KAPPA
    
    JMP $BB95 ; $0EBB95 IN ROM

    .BRANCH_KAPPA
    
    LDA $11 : BEQ .BRANCH_LAMBDA
    
    LDY.b #$02
    LDA.b #$04
    
    JSL Sprite_CorrectOamEntriesLong
    
    .BRANCH_LAMBDA
    
    RTS
}

; $0EBC8C-$0EBC9F DATA
{
    db $F8, $08, $F8, $08, $00, $F8, $F8, $08, $08, $02, $04, $04, $24, $24, $0A 
    
    ; $EBC9B
    .headHFlip
    db $40, $00, $40, $00
    
    .unused? ; Pretty sure its an extra byte.
    db $00
}

; $0EBCA0-$0EBD25 LOCAL
{
    LDA $0E30, X : STA $08
    
    PHX
    
    LDX.b #$00
    
    LDY $0FB6
    
    .BRANCH_BETA
    
    LDA $0FA8 : CLC : ADC $00 : STA $0FD8
    
    CLC : ADC $BC8C, X : STA ($90), Y
    
    LDA $0FA9 : CLC : ADC $02 : STA $0FDA
    
    CLC : ADC $BC91, X
    
    CPX.b #$04 : BNE .BRANCH_ALPHA
    
    CLC : ADC $08
    
    .BRANCH_ALPHA
    
                                  INY : STA ($90), Y
    LDA $BC96, X                : INY : STA ($90), Y
    LDA $05      : ORA $BC9B, X : INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY : INY
    
    INX : CPX.b #$05 : BNE .BRANCH_BETA
    
    PLX
    
    LDA $0FB6 : CLC : ADC.b #$14 : STA $0FB6
    
    LDY.b #$00
    
    LDA $0FA8 : BPL .BRANCH_GAMMA
    
    DEY
    
    .BRANCH_GAMMA
    
    CLC : ADC $0D90, X : STA $0D10, X
    TYA : ADC $0DA0, X : STA $0D30, X
    
    LDY.b #$00
    
    LDA $0FA9 : BPL .BRANCH_DELTA
    
    DEY
    
    .BRANCH_DELTA
    
    CLC : ADC $0DB0, X : STA $0D00, X
    TYA : ADC $0ED0, X : STA $0D20, X
    
    RTS
}

; ==============================================================================

; $0EBD26-$0EBD27 DATA
{
    ; \task Name this routine / pool.
    .x_speed_targets
    db 16, -16
}

; ==============================================================================

; $0EBD28-$0EBD64 LOCAL
TrinexxBreath_ice:
{
    JSL Sprite_PrepOamCoordLong
    JSR Sprite4_CheckIfActive
    
    LDA $0D50, X : PHA : CLC : ADC $0DB0, X : STA $0D50, X
    
    JSR Sprite4_Move
    
    PLA : STA $0D50, X
    
    JSR AddIceGarnish ; $0EBD65 IN ROM
    
    ; $0EBD44 ALTERNATE ENTRY POINT
    
    LDA $1A : AND.b #$03 : BNE .no_shake
    
    JSR Sprite4_IsToRightOfPlayer
    
    LDA $0D50, X : CMP .x_speed_targets, Y : BEQ .no_shake
    
    CLC : ADC.w $8000, Y : STA $0D50, X
    
    .no_shake:
    
    JSR Sprite4_CheckTileCollision : BEQ .BRANCH_BETA
    
    STZ $0DD0, X
    
    .BRANCH_BETA
    
    RTS
}

; $0EBD65-$0EBDC5 LOCAL
AddIceGarnish:
{
    INC $0E80, X
    
    LDA $0E80, X : AND.b #$07 : BNE .BRANCH_ALPHA
    
    LDA.b #$14 : JSL Sound_SetSfx3PanLong
    
    PHX : TXY
    
    LDX.b #$1D
    
    .BRANCH_GAMMA
    
    LDA $7FF800, X : BEQ .BRANCH_BETA
    
    DEX : BPL .BRANCH_GAMMA
    
    DEC $0FF8 : BPL .BRANCH_DELTA
    
    LDA.b #$1D : STA $0FF8
    
    .BRANCH_DELTA
    
    LDX $0FF8
    
    .BRANCH_BETA
    
    LDA.b #$0C : STA $7FF800, X : STA $0FB4
    
    TYA : STA $7FF92C, X
    
    LDA $0D10, Y : STA $7FF83C, X
    LDA $0D30, Y : STA $7FF878, X
    LDA $0D00, Y : CLC : ADC.b #$10 : STA $7FF81E, X
    LDA $0D20, Y : ADC.b #$00 : STA $7FF85A, X
    
    LDA.b #$7F : STA $7FF90E, X
    
    PLX
    
    .BRANCH_ALPHA
    
    RTS
}

; $0EBDC6-$0EBE3B JUMP LOCATION
TrinexxBreath_fire:
{
    JSL Sprite_PrepOamCoordLong
    JSR Sprite4_CheckIfActive
    JSR Sprite4_Move
    JSR AddFireGarnish          ; $0EBDD6 IN ROM
    JMP $BD44                   ; $0EBD44 IN ROM
    
    ; $0EBDD6 ALTERNATE ENTRY POINT
AddFireGarnish:
    INC $0E80, X : LDA $0E80, X : AND.b #$07 : BNE .BRANCH_ALPHA
    
    LDA.b #$2A : JSL Sound_SetSfx2PanLong
    
    LDA.b #$1D
    
    ; $0EBDE8 ALTERNATE ENTRY POINT
    
    PHX : TXY
    
    TAX : STA $00
    
    .next_slot
    
    LDA $7FF800, X : BEQ .BRANCH_BETA
    
    DEX : BPL .next_slot
    
    DEC $0FF8 : BPL .use_search_index
    
    LDA $00 : STA $0FF8
    
    .use_search_index
    
    LDX $0FF8
    
    .BRANCH_BETA
    
    LDA.b #$10 : STA $7FF800, X : STA $0FB4
    
    TYA : STA $7FF92C, X
    
    LDA $0D10, Y : STA $7FF83C, X
    LDA $0D30, Y : STA $7FF878, X
    
    LDA $0D00, Y : CLC : ADC.b #$10 : STA $7FF81E, X
    LDA $0D20, Y : ADC.b #$00 : STA $7FF85A, X
    
    LDA.b #$7F : STA $7FF90E, X
    
    STX $00
    
    PLX
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================
