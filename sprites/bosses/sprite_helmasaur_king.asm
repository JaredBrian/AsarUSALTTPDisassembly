
; ==============================================================================

; \task These might need reinitialization, we should check up on what their
; specific function is.
; $0F0000-$0F0038 LONG JUMP LOCATION
HelmasaurKing_Initialize:
{
    LDA.b #$30 : STA.w $0B2F
    
    LDA.b #$80 : STA.w $0B2D
    
    STZ.w $0B2E
    STZ.w $0B30
    STZ.w $0B33
    STZ.w $0B31
    STZ.w $0B32

    ; $0F0019 ALTERNATE ENTRY POINT
    shared HelmasaurKing_Reinitialize:

    PHB : PHK : PLB : PHX
    
    LDA.w $0E80, X : STA $00 ; jump here
    
    LDY.b #$03
    
    .next_whatever
    
    LDA $00 : CLC : ADC.w $829C, Y : AND.b #$1F : TAX
    
    LDA.w $827C, X : STA.w $0B08, Y
    
    DEY : BPL .next_whatever
    
    PLX : PLB
    
    RTL
}

; ==============================================================================

; $0F0039-$0F0109 JUMP LOCATION
Sprite_HelmasaurKing:
{
    LDA.w $0DB0, X : BPL .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BEQ .BRANCH_BETA
    DEC A        : BNE .BRANCH_BETA
    
    STZ.w $0DD0, X
    
    .BRANCH_BETA
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite3_CheckIfActive
    
    LDA $1A : AND.b #$07 : ORA.w $0E00, X : BNE .BRANCH_GAMMA
    
    LDA.w $0F50, X : EOR.b #$40 : STA.w $0F50, X
    
    .BRANCH_GAMMA
    
    JSR Sprite3_MoveXyz
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .BRANCH_DELTA
    
    STZ.w $0F70, X
    
    LDA.b #$0C : STA.w $0DF0, X
    LDA.b #$18 : STA.w $0F80, X
    LDA.b #$06 : STA.w $0DC0, X
    
    .BRANCH_DELTA
    
    RTS
    
    .BRANCH_ALPHA
    
    CMP.b #$03 : BCS .BRANCH_EPSILON
    
    LDA.w $0B89, X : AND.b #$F1 : STA.w $0B89, X
    
    LDA.b #$0A : STA.w $0B6B, X
    
    BRA .BRANCH_ZETA
    
    .BRANCH_EPSILON
    
    LDA.b #$1F : STA.w $0F60, X
    LDA.b #$02 : STA.w $0B6B, X
    
    .BRANCH_ZETA
    
    JSR.w $853B   ; $0F053B IN ROM
    
    LDA.w $0DD0, X : CMP.b #$06 : BNE .BRANCH_$F0117
    
    LDA.w $0DF0, X : BNE .BRANCH_THETA
    
    LDA.b #$04 : STA.w $0DD0, X
    
    STZ.w $0D90, X
    
    LDA.b #$E0 : STA.w $0DF0, X
    
    RTS
    
    .BRANCH_THETA
    
    PHA
    
    ORA.b #$F0 : STA.w $0EF0, X
    
    PLA : CMP.b #$80 : BCS .BRANCH_IOTA
    
    AND.b #$07 : BNE .BRANCH_IOTA
    
    LDY.w $0B33 : CPY.b #$10 : BEQ .BRANCH_IOTA
    
    INC.w $0B33
    
    STZ $00
    
    LDA.w $0B0D, Y : BPL .BRANCH_KAPPA
    
    DEC $00
    
    .BRANCH_KAPPA
    
    CLC : ADC.w $0D10, X : STA.w $0FD8
    
    LDA.w $0D30, X : ADC $00 : STA.w $0FD9
    
    STZ $00
    
    LDA.w $0B1D, Y : BPL .BRANCH_LAMBDA
    
    DEC $00
    
    .BRANCH_LAMBDA
    
    CLC : ADC.w $0D00, X : STA.w $0FDA
    
    LDA.w $0D20, X : ADC $00 : STA.w $0FDB
    
    JSL Sprite_MakeBossDeathExplosion
    
    .BRANCH_IOTA
    
    RTS
}

; ==============================================================================

; $0F010A-$0F0116 DATA
{
    .unknown
    db $03, $03, $03, $03, $03, $03, $03, $03
    db $02, $02, $01, $01, $00
}

; ==============================================================================

; $0F0117-$0F018B BRANCH LOCATION
{
    JSR Sprite3_CheckIfActive
    
    LDA.w $0E50, X : LSR #2 : TAY
    
    LDA.w $810A, Y : STA.w $0DB0, X : CMP.b #$03 : BNE .BRANCH_ALPHA
    
    CMP.w $0E90, X : BEQ .BRANCH_BETA
    
    STZ.w $0EF0, X
    
    JSR.w $848C ; $0F048C IN ROM
    
    BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    CMP.w $0E90, X : BEQ .BRANCH_BETA
    
    JSR.w $847E ; $0F047E IN ROM
    
    .BRANCH_BETA
    
    LDA.w $0DB0, X : STA.w $0E90, X
    
    JSL Sprite_CheckDamageFromPlayerLong
    JSR.w $82A0 ; $0F02A0 IN ROM
    JSR.w $83EB ; $0F03EB IN ROM
    JSR.w $8385 ; $0F0385 IN ROM
    
    LDA.w $0E00, X : BEQ .BRANCH_GAMMA
    CMP.b #$60   : BEQ .BRANCH_DELTA
    
    RTS
    
    .BRANCH_GAMMA
    
    LDA.w $0E10, X : BEQ .BRANCH_EPSILON
    CMP.b #$40   : BNE .BRANCH_ZETA
    
    JSR.w $8517 ; $0F0517 IN ROM
    
    LDA.w $0DB0, X : CMP.b #$03 : BCC .BRANCH_ZETA
    
    .BRANCH_DELTA
    
    LDA.w $0EC0, X : BNE .BRANCH_ZETA
    
    INC.w $0EC0, X
    
    LDA.b #$20 : STA.w $0EE0, X
    
    .BRANCH_ZETA
    
    RTS
    
    .BRANCH_EPSILON
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $819C ; = $F019C*
    dw $81D5 ; = $F01D5*
    dw $8210 ; = $F0210*
    dw $8242 ; = $F0242*
}

; $0F019C-$0F01D4 JUMP LOCATION
{
    LDA.w $0EF0, X : BNE .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BNE .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    JSR.w $8253 ; $0F0253 IN ROM
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA.w $818C, Y : STA.w $0D50, X
    LDA.w $8194, Y : STA.w $0D40, X
    
    LDA.b #$40 : STA.w $0DF0, X
    
    LDA.w $0DB0, X : CMP.b #$03 : BCC .BRANCH_GAMMA
    
    ASL.w $0D50, X
    ASL.w $0D40, X
    
    LSR.w $0DF0, X
    
    .BRANCH_GAMMA
    
    INC.w $0D80, X
    
    .BRANCH_BETA
    
    RTS
}

; $0F01D5-$0F01E5 JUMP LOCATION
{
    JSR.w $81E6 ; $0F01E6 IN ROM
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    LDA.b #$20 : STA.w $0DF0, X
    
    INC.w $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}


; $0F01E6-$0F01FF LOCAL JUMP LOCATION
{
    JSR.w $8200 ; $0F0200 IN ROM
    
    LDA $1A : AND.b #$03 : BNE .BRANCH_ALPHA
    
    JSR.w $8200 ; $0F0200 IN ROM
    
    .BRANCH_ALPHA
    
    LDA.w $0DB0, X : CMP.b #$03 : BCC .BRANCH_BETA
    
    JSR.w $8200 ; $0F0200 IN ROM
    
    .BRANCH_BETA
    
    JSR Sprite3_Move
    
    RTS
}


; $0F0200-$0F020F LOCAL JUMP LOCATION
{
    INC.w $0E80, X : LDA.w $0E80, X : AND.b #$0F : BNE .BRANCH_ALPHA
    
    LDA.b #$21 : STA.w $012E
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F0210-$0F0241 JUMP LOCATION
{
    LDA.w $0EF0, X : BNE .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BNE .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    JSR.w $8253 ; $0F0253 IN ROM
    
    LDA #$40 : STA.w $0DF0, X
    
    LDA.w $0E90, X : CMP.b #$03 : BCC .BRANCH_GAMMA
    
    LSR.w $0DF0, X
    
    .BRANCH_GAMMA
    
    LDA.w $0D50, X : EOR.b #$FF : INC A : STA.w $0D50, X
    
    LDA.w $0D40, X : EOR.b #$FF : INC A : STA.w $0D40, X
    
    INC.w $0D80, X
    
    .BRANCH_BETA
    
    RTS
}

; $0F0242-$0F0252 JUMP LOCATION
{
    JSR.w $81E6 ; $0F01E6 IN ROM
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    STZ.w $0D80, X
    
    LDA.b #$40 : STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F0253-$0F027B LOCAL JUMP LOCATION
{
    INC.w $0E30, X
    
    LDA.w $0E30, X : CMP.b #$04 : BNE .BRANCH_ALPHA
    
    PLA : PLA
    
    STZ.w $0E30, X
    
    JSL GetRandomInt : AND.b #$01 : BEQ .BRANCH_BETA
    
    LDA.b #$7F : STA.w $0E10, X
    
    LDA.b #$2A : JSL Sound_SetSfx3PanLong
    
    RTS
    
    .BRANCH_BETA
    
    LDA.b #$A0 : STA.w $0E00, X
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $0F029C-$0F029F DATA
Pool_HelmasaurKing_Initialize:
{
    db 0, 8, 16, 24
}

; ==============================================================================

; $0F02A0-$0F0326 LOCAL JUMP LOCATION
{
    INC.w $0B0C
    
    JSL HelmasaurKing_Reinitialize
    
    LDA.b #$01
    
    LDY.w $0EC0, X : BEQ .BRANCH_ALPHA
    
    LDA.b #$00
    
    .BRANCH_ALPHA
    
    AND $1A : BNE .BRANCH_BETA
    
    LDA.w $0DE0, X : AND.b #$01 : TAY
    
    LDA.w $0B30 : CLC : ADC.w $8383, Y : STA.w $0B30
    
    CMP Sprite3_Shake.x_speeds, Y : BNE .BRANCH_GAMMA
    
    INC.w $0DE0, X
    
    .BRANCH_GAMMA
    
    LDY.b #$00
    
    LDA.w $0B30 : BPL .BRANCH_DELTA
    
    DEY
    
    .BRANCH_DELTA
    
    CLC : ADC.w $0B2D : STA.w $0B2D
    
    TYA : ADC.w $0B2E : AND.b #$FF : STA.w $0B2E
    
    .BRANCH_BETA
    
    LDA.w $0EC0, X : BEQ .BRANCH_EPSILON
    
    LDA.w $0B30 : BNE .BRANCH_ZETA
    
    LDA.b #$06 : JSL Sound_SetSfx3PanLong
    
    .BRANCH_ZETA
    
    LDA.w $0EC0, X
    
    CMP.b #$02 : BEQ .BRANCH_$F032D
    CMP.b #$03 : BEQ .BRANCH_$F0357
    
    LDA.w $0B30 : ORA.w $0EE0, X : BNE .BRANCH_$F0382 ; (RTS)
    
    LDA.w $0B2E : AND.b #$01 : STA.w $0EB0, X
    
    JSR Sprite3_IsToRightOfPlayer
    
    TYA : EOR.b #$01 : CMP.w $0EB0, X : BNE .BRANCH_EPSILON
    
    INC.w $0EC0, X
    
    JSL Sound_SetSfxPan : ORA.b #$26 : STA.w $012F
    
    .BRANCH_EPSILON
    
    RTS
}

; $0F032D-$0F0356 BRANCH LOCATION
{
    LDY.w $0EB0, X
    
    LDA.w $0B31 : CLC : ADC.w $8327, Y : STA.w $0B31 : PHA
    LDA.w $0B32 : ADC.w $8329, Y  : STA.w $0B32
    
    PLA : CMP.w $832B, Y : BNE .BRANCH_ALPHA
    
    INC.w $0EC0, X
    
    .BRANCH_ALPHA
    
    LDA.w $0B2F : CLC : ADC.b #$03 : STA.w $0B2F
    
    RTS
}

; $0F0357-$0F0382 BRANCH LOCATION
{
    LDA.w $0EB0, X : EOR.b #$01 : TAY
    
    LDA.w $0B31 : CLC : ADC.w $8327, Y : STA.w $0B31 : PHA
    LDA.w $0B32 : ADC.w $8329, Y : STA.w $0B32
    
    PLA : CMP.b #$00 : BNE .BRANCH_ALPHA
    
    STZ.w $0EC0, X
    
    .BRANCH_ALPHA
    
    LDA.w $0B2F : SEC : SBC.b #$03 : STA.w $0B2F
    
    RTS
}

; ==============================================================================

; $0F0383-$0F0384 DATA
{
    ; \task Name this routine / pool
    .unknown_0
    db 1, -1
}

; ==============================================================================

; $0F0385-$0F03EA LOCAL JUMP LOCATION
{
    LDA.w $0DB0, X : CMP.b #$03 : BCS .BRANCH_ALPHA
    
    LDA.w $0301 : AND.b #$0A : BEQ .BRANCH_ALPHA
    
    LDA $44 : CMP.b #$80 : BEQ .BRANCH_ALPHA
    
    JSL Player_SetupActionHitBoxLong
    
    LDA.w $0D00, X : PHA : CLC : ADC.b #$08 : STA.w $0D00, X
    
    JSL Sprite_SetupHitBoxLong
    
    PLA : STA.w $0D00, X
    
    JSL Utility_CheckIfHitBoxesOverlapLong : BCC .BRANCH_ALPHA
    
    DEC.w $0E50, X
    
    LDA.b #$21 : STA.w $012F
    
    LDA.b #$30
    
    JSL Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA $00 : STA $27
    LDA $01 : STA $28
    
    LDA.b #$08 : STA.w $0046
    
    LDA.w $0FAC : BNE .BRANCH_BETA
    
    LDA $00 : STA.w $0FAD
    LDA $01 : STA.w $0FAE
    
    LDA.b #$05 : STA.w $0FAC
    
    .BRANCH_BETA
    
    LDA.b #$05 : JSL Sound_SetSfx2PanLong
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F03EB-$0F0419 LOCAL JUMP LOCATION
{
    LDA $1A : AND.b #$07 : BNE .BRANCH_ALPHA
    
    REP #$20
    
    LDA $22 : SEC : SBC.w $0FD8 : CLC : ADC.w #$0024 : CMP.w #$0048 : BCS .BRANCH_ALPHA
    
    LDA $20 : SEC : SBC.w $0FDA : CLC : ADC.w #$0028 : CMP.w #$0040 : BCS .BRANCH_ALPHA
    
    SEP #$20
    
    JSL Sprite_AttemptDamageToPlayerPlusRecoilLong
    
    .BRANCH_ALPHA
    
    SEP #$20
    
    RTS
}

; $0F047E-$0F04A9 LOCAL JUMP LOCATION
{
    LDA.w $0DB0, X : CLC : ADC.b #$07 : STA.w $0FB5
    
    JSR.w $84AA ; $0F04AA IN ROM
    
    BRA .BRANCH_ALPHA
    
    ; $0F048C ALTERNATE ENTRY POINT
    
    LDY.b #$0F
    LDA.b #$00
    
    .BRANCH_BETA
    
    STA.w $0DD0, Y
    
    DEY : BNE .BRANCH_BETA
    
    LDA.b #$07 : STA.w $0FB5
    
    .BRANCH_GAMMA
    
    JSR.w $84AA ; $0F04AA IN ROM
    
    DEC.w $0FB5 : BPL .BRANCH_GAMMA
    
    .BRANCH_ALPHA
    
    LDA.b #$1F : JSL Sound_SetSfx2PanLong
    
    RTS
}

; $0F04AA-$0F0516 LOCAL JUMP LOCATION
{
    ; I think this can spawn all of parts of the Helmasaur King's mask
    ; flying off due to damage...
    LDA.b #$92 : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    PHX
    
    LDX.w $0FB5
    
    LDA $00 : CLC : ADC.w $842E, X : STA.w $0D10, Y
    LDA $01 : ADC.w $8438, X : STA.w $0D30, Y
    
    LDA $02 : CLC : ADC.w $841A, X : STA.w $0D00, Y
    LDA $03 : ADC.w $8424, X : STA.w $0D20, Y
    
    LDA.w $8442, X : STA.w $0F70, Y
    LDA.w $844C, X : STA.w $0D50, Y
    LDA.w $8456, X : STA.w $0D40, Y
    LDA.w $8460, X : STA.w $0F80, Y
    
    LDA.w $846A, X : ORA.b #$0D : STA.w $0F50, Y
    
    LDA.w $8474, X : STA.w $0DC0, Y
    
    LDA.b #$80 : STA.w $0DB0, Y
    ASL A      : STA.w $0E40, Y
    
    LDA.b #$0C : STA.w $0E00, Y : STA.w $0BA0, Y
    
    LDA.w $0FB5 : STA.w $0E30, Y
    
    PLX
    
    .spawn_failed
    
    RTS
}

; $0F0517-$0F053A LOCAL JUMP LOCATION
{
    ; Spawn helmasaur king fireball...
    LDA.b #$70 : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL Sprite_SetSpawnedCoords
    
    LDA $02 : CLC : ADC.b #$1C : STA.w $0D00, Y
    LDA $03 : ADC.b #$00 : STA.w $0D20, Y
    
    LDA.b #$20 : STA.w $0DF0, Y : STA.w $0BA0, Y
    
    .spawn_failed
    
    RTS
}

; $0F053B-$0F055E LOCAL JUMP LOCATION
{
    REP #$20
    
    LDA.w #$089C : STA $90
    LDA.w #$0A47 : STA $92
    
    SEP #$20
    
    JSR Sprite3_PrepOamCoord
    JSR.w $8920 ; $0F0920 IN ROM
    JSR.w $856B ; $0F056B IN ROM
    JSR.w $8686 ; $0F0686 IN ROM
    JSR.w $87E5 ; $0F07E5 IN ROM
    JSR.w $8805 ; $0F0805 IN ROM
    JSR.w $88BC ; $0F08BC IN ROM
    
    RTS
}

; ==============================================================================

; $0F055F-$0F056A DATA
{
    ; \task Name this routine / pool.
    .x_offsets
    db -3, 11
    
    .chr
    db $CE, $CF, $DE, $DE, $DE, $DE, $CF, $CE
    
    .properties
    db $3B, $7B
}

; ==============================================================================

; $0F056B-$0F05C5 LOCAL JUMP LOCATION
{
    REP #$20
    
    LDA $90 : CLC : ADC.w #$0040 : STA $90
    LDA $92 : CLC : ADC.w #$0010 : STA $92
    
    SEP #$20
    
    PHX
    
    LDY.b #$00
    LDX.b #$01
    
    .BRANCH_ALPHA
    
    PHX
    
    LDA $00 : CLC : ADC .x_offsets, X       : STA ($90), Y
    LDA $02 : CLC : ADC.b #$14        : INY : STA ($90), Y
    
    LDA.w $0B0C : LSR #2 : AND.b #$07 : TAX
    
    LDA .chr, X : INY : STA ($90), Y
    
    PLX
    
    LDA .properties, X : INY : STA ($90), Y
    
    PHY
    
    TYA : LSR #2 : TAY
    
    LDA.b #$00 : STA ($92), Y
    
    PLY : INY
    
    DEX : BPL .BRANCH_ALPHA
    
    PLX
    
    LDA $11 : BEQ .BRANCH_BETA
    
    LDY.b #$00
    LDA.b #$01
    
    JSL Sprite_CorrectOamEntriesLong
    
    .BRANCH_BETA
    
    RTS
}

; $0F0686-$0F06E4 LOCAL JUMP LOCATION
{
    LDA.b #$00 : XBA
    
    LDA.w $0DB0, X
    
    REP #$20
    
    ASL #6 : ADC.w #$85C6 : STA $08
    
    LDA $90 : CLC : ADC.w #$0008 : STA $90
    
    INC $92 : INC $92
    
    SEP #$20
    
    LDA.w $0DB0, X : CMP.b #$03 : BCS .BRANCH_ALPHA
    
    LDA.b #$08
    
    JSR Sprite3_DrawMultiple
    
    REP #$20
    
    LDA $90 : CLC : ADC.w #$0020 : STA $90
    LDA $92 : CLC : ADC.w #$0008 : STA $92
    
    SEP #$20
    
    LDA.w $0F10, X : BEQ .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    RTS
    
    .BRANCH_BETA
    
    LDY.b #$01
    
    .nextSlot
    
    LDA.w $0C4A, Y : CMP.b #$07 : BNE .notBomb
    
    LDA.w $0C2C, Y : ORA.w $0C22, Y : BEQ .BRANCH_GAMMA
    
    JSR.w $86E5   ; $0F06E5 IN ROM
    
    .notBomb
    .BRANCH_GAMMA
    
    DEY : BPL .nextSlot
    
    RTS
}

; $0F06E5-$0F074C LOCAL JUMP LOCATION
{
    ; Helmasaur king checking for proximity between exploding bombs and its mask, probably
    
    JSL Sprite_SetupHitBoxLong
    
    LDA.w $0C04, Y : CLC : ADC.b #$06 : STA $00
    LDA.w $0C18, Y : ADC.b #$00 : STA $08
    
    LDA.w $0BFA, Y : SEC : SBC.w $029E, Y : STA $01
    LDA.w $0C0E, Y : SBC.b #$00   : STA $09
    
    LDA.b #$02 : STA $02
    LDA.b #$0F : STA $03
    
    JSL Utility_CheckIfHitBoxesOverlapLong : BCC .BRANCH_ALPHA
    
    LDA.w $0C2C, Y : EOR.b #$FF : INC A : STA.w $0C2C, Y
    LDA.w $0C22, Y : EOR.b #$FF : INC A : STA $00
    
    ASL $00 : ROR A : STA.w $0C22, Y
    
    LDA.b #$20 : STA.w $0F10, X
    
    LDA.b #$05 : STA.w $0FAC
    
    LDA.w $0C04, Y : STA.w $0FAD
    
    LDA.w $0BFA, Y : SEC : SBC.w $029E, Y : STA.w $0FAE
    
    ; Make "clink against wall" noise
    LDA.b #$05 : STA.w $012E
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F07E5-$0F07F4 LOCAL JUMP LOCATION
{
    REP #$20
    
    LDA.w #$874D : STA $08
    
    SEP #$20
    
    LDA.b #$13
    
    ; $0F07F0 ALTERNATE ENTRY POINT
    shared Sprite3_DrawMultiple:
    
    JSL Sprite_DrawMultiple
    
    RTS
}

; $0F0805-$0F089B LOCAL JUMP LOCATION
{
    REP #$20
    
    LDA $90 : CLC : ADC.w #$004C : STA $90
    
    LDA $92 : CLC : ADC.w #$0013 : STA $92
    
    SEP #$20
    
    PHX
    
    LDY.b #$00
    
    LDA.b #$03 : STA.w $0FB5
    
    .BRANCH_ALPHA
    
    LDX.w $0FB5
    
    LDA $00 : CLC : ADC.w $87F5, X : STA ($90), Y
    
    LDA $02 : CLC : ADC.w $87F9, X : CLC : ADC.w $0B08, X : INY : STA ($90), Y
    LDA.w $87FD, X                          : INY : STA ($90), Y
    LDA.w $8801, X : EOR $05                : INY : STA ($90), Y
    
    PHY
    
    TYA : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY : INY
    
    LDA $00 : CLC : ADC.w $87F5, X : STA ($90), Y
    
    LDA $02 : CLC : ADC.w $87F9, X : CLC : ADC.b #$10 : CLC : ADC.w $0B08, X : INY : STA ($90), Y
    LDA.w $87FD, X : CLC : ADC.b #$02                          : INY : STA ($90), Y
    LDA.w $8801, X : EOR $05                             : INY : STA ($90), Y
    
    PHY
    
    TYA : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY : INY
    
    DEC.w $0FB5 : BPL .BRANCH_ALPHA
    
    PLX
    
    LDA $11 : BEQ .BRANCH_BETA
    
    LDY.b #$02
    LDA.b #$07
    
    JSL Sprite_CorrectOamEntriesLong
    JSR Sprite3_PrepOamCoord
    
    .BRANCH_BETA
    
    RTS
}

; $0F08BC-$0F08EF LOCAL JUMP LOCATION
{
    LDA.w $0E10, X : BEQ .BRANCH_ALPHA
    
    LSR #2 : TAY
    
    LDA.w $889C, Y : STA $06
    
    LDA.b #$04 : JSL OAM_AllocateFromRegionB
    
    LDY.b #$00
    
    LDA $00                                 : STA ($90), Y
    LDA $02    : CLC : ADC.b #$13 : ADC $06 : INY : STA ($90), Y
    LDA.b #$AA                        : INY : STA ($90), Y
    LDA $05    : EOR.b #$0B           : INY : STA ($90), Y
    
    LDA.b #$02 : STA ($92)
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $0F08F0-$0F091F DATA
{
    ; \task Fill in data.
}

; ==============================================================================

; $0F0920-$0F0A84 LOCAL JUMP LOCATION
{
    STZ.w $0FB5
    
    ; $0F0923 ALTERNATE ENTRY POINT
    
    LDY.w $0FB5 : PHY
    
    LDA.w $0EC0, X : BEQ .BRANCH_ALPHA
    
    TYA : CLC : ADC.b #$10 : TAY
    
    .BRANCH_ALPHA
    
    REP #$20
    
    LDA.w $0B2D : CLC : ADC.w $0B31 : STA $0D
    
    SEP #$20
    
    LDA $0E : CMP.b #$01
    
    PHP
    
    PHP : LDA $0D : PLP : BPL .BRANCH_BETA
    
    EOR.b #$FF : INC A
    
    .BRANCH_BETA
    
    STA.w $4202
    
    LDA.w $88F0, Y : STA.w $4203
    
    JSR Sprite3_DivisionDelay
    
    LDA.w $4217 : PLP : BPL .BRANCH_GAMMA
    
    EOR.b #$FF
    
    .BRANCH_GAMMA
    
    STA $06
    
    LDA $0E : STA $07
    
    PLY
    
    LDA.w $0B2F    : STA.w $4202
    LDA.w $8910, Y : STA.w $4203
    
    JSR Sprite3_DivisionDelay
    
    LDA.w $4217 : STA $0F
    
    PHX
    
    REP #$30
    
    LDA $06 : AND.w #$00FF : ASL A : TAX
    
    LDA.l $04E800, X : STA $0A
    
    LDA $06 : CLC : ADC.w #$0080 : STA $08
    
    AND.w #$00FF : ASL A : TAX
    
    LDA.l $04E800, X : STA $0C
    
    SEP #$30
    
    PLX
    
    LDA $0A : STA.w $4202
    
    LDA $0F
    
    LDY $0B : BNE .BRANCH_DELTA
    
    STA.w $4203
    
    JSR Sprite3_DivisionDelay
    
    ASL.w $4216
    
    LDA.w $4217 : ADC.b #$00
    
    .BRANCH_DELTA
    
    LSR $07 : BCC .BRANCH_EPSILON
    
    EOR.b #$FF : INC A
    
    .BRANCH_EPSILON
    
    LDY.w $0FB5
    
    STA.w $0B0D, Y
    
    LDA $0C : STA.w $4202
    
    LDA $0F
    
    LDY $0D : BNE .BRANCH_ZETA
    
    STA.w $4203
    
    JSR Sprite3_DivisionDelay
    
    ASL.w $4216
    
    LDA.w $4217 : ADC.b #$00
    
    .BRANCH_ZETA
    
    LSR $09 : BCC .BRANCH_THETA
    
    EOR.b #$FF : INC A
    
    .BRANCH_THETA
    
    LDY.w $0FB5
    
    SEC : SBC.b #$28 : STA.w $0B1D, Y
    
    INC.w $0FB5 : LDA.w $0FB5 : CMP.b #$10 : BEQ .BRANCH_IOTA
    
    JMP.w $8923 ; $0F0923 IN ROM
    
    .BRANCH_IOTA
    
    LDA.w $0EC0, X : STA $0A
    
    STZ $0F
    
    PHX
    
    LDX.w $0B33 : CPX.b #$10 : BEQ .BRANCH_KAPPA
    
    LDY.b #$00
    
    .BRANCH_NU
    
    LDA $00 : CLC : ADC.w $0B0D, X       : STA ($90), Y : STA $08
    LDA $02 : CLC : ADC.w $0B1D, X : INY : STA ($90), Y : STA $09
    
    LDA.b #$AC
    
    CPY.b #$01 : BNE .BRANCH_LAMBDA
    
    LDA.b #$E4
    
    .BRANCH_LAMBDA
    
                           INY : STA ($90), Y
    LDA $05 : EOR.b #$1B : INY : STA ($90), Y
    
    INY
    
    TXA : EOR $1A : AND.b #$00 : ORA.w $031F : BNE .BRANCH_MU
    
    LDA $0A : BEQ .BRANCH_MU
    
    LDA $22 : SBC $E2 : SBC $08 : ADC.b #$0C : CMP.b #$18 : BCS .BRANCH_MU
    
    LDA $20
    SBC $E8
    ADC #$08
    SBC $09
    ADC #$08
    CMP #$10 : BCS .BRANCH_MU
    
    INC $0F
    
    STZ $28
    
    LDA.b #$38 : STA $27
    
    .BRANCH_MU
    
    INX : CPX.b #$10 : BNE .BRANCH_NU
    
    .BRANCH_KAPPA
    
    PLX
    
    LDA $0F : BEQ .BRANCH_XI
    
    LDA.w $0FFC : BNE .BRANCH_XI
    
    JSL Sprite_AttemptDamageToPlayerPlusRecoilLong
    
    .BRANCH_XI
    
    LDY.b #$02
    LDA.b #$0F
    
    JSL Sprite_CorrectOamEntriesLong
    JSR Sprite3_PrepOamCoord
    
    RTS
}

; ==============================================================================
