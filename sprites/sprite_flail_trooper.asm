
; ==============================================================================

; $02B019-$02B01A DATA (UNUSED)
Pool_Sprite_ChainBallTrooper:
{
    .spin_speeds
    db $22, $10
}

; ==============================================================================

; $02B01B-$02B07C JUMP LOCATION
Sprite_ChainBallTrooper:
{
    JSR.w $B144 ; $02B144 IN ROM
    
    LDA.w $0D80, X : CMP.b #$02 : BCS .alpha
    
    LDA.b #$80 : STA.w $0FAB
    
    .alpha
    
    JSR Sprite2_CheckIfActive
    JSL.l $06EB5E ; $036B5E IN ROM
    
    LDY.w $0D80, X
    
    LDA .spin_speeds - 2, Y : CLC : ADC.w $0D90, X              : STA.w $0D90, X
    LDA.w $0DA0, X            : ADC.b #$00   : AND.b #$01 : STA.w $0DA0, X
    
    JSR Sprite2_CheckIfRecoiling
    JSR Sprite2_CheckTileCollision
    JSR Sprite2_Move
    JSL Sprite_CheckDamageToPlayerLong
    
    TXA : EOR.b $1A : AND.b #$0F : BNE .no_head_direction_change
    
    JSR Sprite2_DirectionToFacePlayer : TYA : STA.w $0EB0, X
    
    .no_head_direction_change
    
    LDA.w $0D80, X : REP #$30 : AND.w #$00FF : ASL A : TAY
    
    LDA .states, Y : DEC A : PHA
    
    SEP #$30
    
    RTS
    
    .states
    
    db FlailTrooper_ApproachPlayer
    db FlailTrooper_ShortHalting
    db FlailTrooper_Attack
    db FlailTrooper_WindingDown
}

; ==============================================================================

; $02B07D-$02B0C6 JUMP LOCATION
FlailTrooper_ApproachPlayer:
{
    TXA : EOR.b $1A : AND.b #$0F : BNE .delay
    
    ; Make body match head direction
    LDA.w $0EB0, X : STA.w $0DE0, X
    
    LDA.b $0E : CLC : ADC.b #$40 : CMP.b #$68 : BCS .player_not_close
    
    LDA.b $0F : CLC : ADC.b #$30 : CMP.b #$60 : BCS .player_not_close
    
    ; Start swinging the ball and chain.
    INC.w $0D80, X
    
    LDA.b #$18 : STA.w $0DF0, X
    
    RTS
    
    .beta
    
    LDA.b #$08 : JSL Sprite_ApplySpeedTowardsPlayerLong
    
    .delay
    
    shared FlailTrooper_Animate:
    
    LDA.w $0DE0, X : ASL #3 : STA.b $00
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR #2 : AND.b #$07 : ORA.b $00 : TAY
    
    LDA.w Pool_FlailTrooper_Animate_animation_states, Y : STA.w $0DC0, X
    
    RTS
}
    
; $02B0C7-$02B0E6 DATA
Pool_FlailTrooper_Animate:
Pool_Sprite_PsychoTrooper:
{
    .animation_states
    db $10, $11, $12, $13, $10, $11, $12, $13
    db $06, $07, $08, $09, $06, $07, $08, $09
    db $00, $01, $02, $03, $00, $01, $04, $05
    db $0A, $0B, $0C, $0D, $0A, $0B, $0E, $0F
}

; ==============================================================================

; $02B0E7-$02B0F7 JUMP LOCATION
FlailTrooper_ShortHalting:
{
    JSR Sprite2_ZeroVelocity
    
    LDA.w $0DF0, X : BNE .delay
    
    LDA.b #$30 : STA.w $0DF0, X
    
    INC.w $0D80, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $02B0F8-$02B0FB DATA
Pool_FlailTrooper_Attack:
{
    db $03, $01, $02, $00
}

; ==============================================================================

; $02B0FC-$02B12D JUMP LOCATION
FlailTrooper_Attack:
{
    LDA.w $0DF0, X : BNE .delay
    
    LDA.w $0D90, X : ASL A : LDA.w $0DA0, X : ROL A : TAY
    
    ; Head doesn't match a direction...? what?
    LDA.w $B0F8, Y : CMP.w $0EB0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$1F : STA.w $0E10, X
    
    .delay
    
    shared FlailTrooper_DoubleAnimatePlusSound:
    
    INC.w $0E80, X
    
    JSR FlailTrooper_Animate
    
    TXA : EOR.b $1A : AND.b #$0F : BNE .return
    
    LDA.b #$06 : JSL Sound_SetSfx3PanLong
    
    .return
    
    RTS
}

; ==============================================================================

; $02B12E-$02B143 JUMP LOCATION
FlailTrooper_WindingDown:
{
    JSR Sprite2_ZeroVelocity
    
    LDA.w $0E10, X : BNE .delay
    
    STZ.w $0D80, X
    
    .delay
    
    CMP.b #$10 : BCS FlailTrooper_DoubleAnimatePlusSound
    
    INC.w $0E80, X
    
    JSR FlailTrooper_Animate
    
    RTS
}

; ==============================================================================

; $02B144-$02B155 LOCAL JUMP LOCATION
SpriteDraw_BallNChain:
{
    JSR Sprite2_PrepOamCoord
    JSR ChainBallTrooper_DrawHead
    JSR FlailTrooper_DrawBody
    JSR.w SpriteDraw_BNCFlail
    JSR Sprite2_PrepOamCoord
    JMP.w Guard_DrawShadow
} 

; ==============================================================================

; $02B156-$02B15D DATA
Pool_ChainBallTrooper_DrawHead:
{
    .chr
    db $02, $02, $00, $04
    
    .properties
    db $40, $00, $00, $00
}

; ==============================================================================

; $02B15E-$02B15F LOCAL JUMP LOCATION
ChainBallTrooper_DrawHead:
{
    LDY.b #$18

    ; Bleeds into the next function.
}
    
; $02B160-$02B1A2 LOCAL JUMP LOCATION
SpriteDraw_GuardHead:
{
    PHX
    
    LDA.w $0EB0, X : TAX
    
    REP #$20
    
    LDA.b $00                       : STA ($90), Y
                                    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : SEC : SBC.w #$0009 : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen_y
    
    LDA.w #$00F0 : STA ($90), Y
    
    .on_screen_y
    
    SEP #$20
    
    LDA .chr, X : INY : STA ($90), Y
    
    LDA .properties, X : INY : ORA.b $05 : STA ($90), Y
    
    TYA : LSR #2 : TAY
    
    LDA.b #$02 : ORA.b $0F : STA ($92), Y
    
    PLX
    
    RTS
}

; ==============================================================================

; $02B1A3-$02B3CA DATA
Pool_FlailTrooper_DrawBody:
{
    .x_offsets

    dw -4,  4, 12
    dw -4,  4, 13
    dw -4,  4, 13
    dw -4,  4, 13
    dw -4,  4, 13
    dw -4,  4, 13
    dw  0,  0,  4
    dw  0,  0,  5
    dw  0,  0,  6
    dw  0,  0,  4
    dw -4,  4, -6
    dw -4,  4, -5
    dw -4,  4, -5
    dw -4,  4, -6
    dw -4,  4, -5
    dw -4,  4, -6
    dw  0,  0,  4
    dw  0,  0,  3
    dw  0,  0,  2
    dw  0,  0,  4
    dw  0,  0,  0
    dw  0,  0,  0
    dw -4,  4,  4
    dw -4,  4,  4
    
    .y_offsets
    dw  0,  0, -4
    dw  0,  0, -4
    dw  0,  0, -3
    dw  0,  0, -2
    dw  0,  0, -3
    dw  0,  0, -2
    dw  0,  0,  1
    dw  0,  0,  1
    dw  0,  0,  2
    dw  0,  0,  2
    dw  0,  0, -2
    dw  0,  0, -2
    dw  0,  0, -1
    dw  0,  0, -1
    dw  0,  0, -1
    dw  0,  0, -1
    dw  0,  0,  1
    dw  0,  0,  1
    dw  0,  0,  2
    dw  0,  0,  2
    dw  0,  0,  0
    dw  0,  0,  0
    dw  0,  0,  0
    dw  0,  0,  0
    
    .chr
    db $46, $06, $2F, $46, $06, $2F, $48, $0D
    db $2F, $48, $0D, $2F, $49, $0C, $2F, $49
    db $0C, $2F, $08, $08, $2F, $08, $08, $2F
    db $22, $22, $2F, $22, $22, $2F, $0A, $64
    db $2F, $0A, $64, $2F, $2C, $67, $2F, $2C
    db $67, $2F, $2D, $66, $2F, $2D, $66, $2F
    db $08, $08, $2F, $08, $08, $2F, $22, $22
    db $2F, $22, $22, $2F, $62, $62, $62, $62
    db $62, $62, $46, $4B, $4B, $69, $64, $64
    
    .vh_flip
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $40, $40, $00, $40
    db $40, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $40
    db $40, $00, $40, $40, $00, $00, $40, $00
    db $00, $40, $40, $40, $40, $40, $40, $40
    db $40, $40, $40, $40, $40, $40, $40, $40
    db $40, $40, $40, $40, $40, $40, $40, $00
    db $00, $00, $00, $40, $40, $00, $40, $40
    
    .sizes
    db $02, $02, $00, $02, $02, $00, $02, $02
    db $00, $02, $02, $00, $02, $02, $00, $02
    db $02, $00, $02, $02, $00, $02, $02, $00
    db $02, $02, $00, $02, $02, $00, $02, $02
    db $00, $02, $02, $00, $02, $02, $00, $02
    db $02, $00, $02, $02, $00, $02, $02, $00
    db $02, $02, $00, $02, $02, $00, $02, $02
    db $00, $02, $02, $00, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    
    .num_subsprites
    ; I'm thinking that the last 4 entries are unfinished or unused...
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $01, $01, $01, $01
    
    .oam_offset_adjustment
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $08, $08, $08, $08
}

; ==============================================================================

; $02B3CB-$02B3CC LOCAL JUMP LOCATION
FlailTrooper_DrawBody:
{
    LDY.b #$14
    
    ; I am confuse, as this would certainly overwrite the head portion
    ; in most cases, right? bug?

    ; Bleeds into the next function.
}
    
; $02B3CD-$02B43F LOCAL JUMP LOCATION
SpriteDraw_GuardBody:
{
    LDA.w $0DC0, X : ASL A : ADC.w $0DC0, X : STA.b $06
    
    PHX
    
    LDA.w $0DC0, X : TAX
    
    TYA : CLC : ADC .oam_offset_adjustment, X : TAY
    
    LDA .num_subsprites, X : TAX
    
    .next_subsprite
    
    PHX
    
    TXA : CLC : ADC.b $06 : PHA : ASL A : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC .x_offsets, X       : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : CLC : ADC .y_offsets, X : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .alpha
    
    LDA.w #$00F0 : STA ($90), Y
    
    .alpha
    
    SEP #$20
    
    PLX
    
    LDA .chr, X               : INY : STA ($90), Y
    LDA .vh_flip, X : ORA.b $05 : INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA .sizes, X : ORA.b $0F : STA ($92), Y
    
    PLY : INY
    
    PLX : CPX.b #$02 : BNE .beta
    
    INY #4

    .beta

    DEX : BPL .next_subsprite
    
    PLX
    
    RTS
}

; ==============================================================================

; $02B440-$02B467 DATA
{
    db $10, $12, $14, $16, $18, $1A, $1C, $1E
    db $20, $22, $24, $26, $28, $2A, $2C, $2E
    db $30, $2E, $2C, $2A, $28, $26, $24, $22
    db $20, $1E, $1C, $1A, $18, $16, $14, $12
    
    ; $2B460
    db $04, $04, $0C, $FB
    
    ; $2B464
    db $FE, $FE, $FA, $FC
}

; ==============================================================================

; $02B468-$02B5BD LOCAL JUMP LOCATION
SpriteDraw_BNCFlail:
{
    LDA.b $00 : STA.w $0FA8
    LDA.b $02 : STA.w $0FA9
    
    LDA.w $0D90, X : STA.b $00
    LDA.w $0DA0, X : STA.b $01
    
    LDA.b #$00
    
    LDY.w $0D80, X : CPY.b #$02 : BCC .alpha
    
    LDA.w $0E10, X : TAY
    
    LDA.w $B440, Y
    
    .alpha
    
    STA.b $0F
    
    LDY.w $0DE0, X
    
    LDA.w $B460, Y : STA.b $0C
    LDA.w $B464, Y : STA.b $0D
    
    PHX
    
    REP #$30
    
    LDA.b $00 : AND.w #$01FF : LSR #6 : STA.b $0A
    
    LDA.b $00 : CLC : ADC.w #$0080 : AND.w #$01FF : STA.b $02
    
    LDA.b $00 : AND.w #$00FF : ASL A : TAX
    
    LDA.l $04E800, X : STA.b $04
    
    LDA.b $02 : AND.w #$00FF : ASL A : TAX
    
    LDA.l $04E800, X : STA.b $06
    
    SEP #$30
    
    PLX
    
    LDA.b $04 : STA.w $4202
    
    LDA.b $0F
    
    LDY.b $05 : BNE .beta
    
    STA.w $4203
    
    JSR.w $B5BE ; $02B5BE IN ROM
    
    ASL.w $4216
    
    LDA.w $4217 : ADC.b #$00
    
    .beta
    
    STA.b $0E
    
    LSR.b $01 : BCC .gamma
    
    EOR.b #$FF : INC A
    
    .gamma
    
    STA.b $04
    
    LDA.b $06 : STA.w $4202
    
    LDA.b $0F
    
    LDY.b $07 : BNE .delta
    
    STA.w $4203
    
    JSR.w $B5BE ; $02B5BE IN ROM
    
    ASL.w $4216
    
    LDA.w $4217 : ADC.b #$00
    
    .delta
    
    STA.b $0F
    
    LSR.b $03 : BCC .epsilon
    
    EOR.b #$FF : INC A
    
    .epsilon
    
    STA.b $06
    
    LDY.b #$00
    
    LDA.b $04 : SEC : SBC.b #$04 : CLC : ADC.b $0C : STA.w $0FAB
    
    CLC : ADC.w $0FA8 : STA ($90), Y
    
    LDA.b $06 : SEC : SBC.b #$04 : CLC : ADC.b $0D : STA.w $0FAA
    
    CLC : ADC.w $0FA9  : INY : STA ($90), Y
    LDA.b #$2A : INY : STA ($90), Y
    LDA.b #$2D : INY : STA ($90), Y
    
    LDA.b #$02 : STA ($92)
    
    LDY.b #$04
    
    PHX
    
    LDX.b #$03
    
    .iota
    
    LDA.b $0E      : STA.w $4202
    LDA.w $B5BA, X : STA.w $4203
    
    JSR.w $B5BE ; $02B5BE IN ROM
    
    LDA.b $04 : ASL A
    
    LDA.w $4217 : BCC .zeta
    
    EOR.b #$FF : INC A
    
    .zeta
    
    CLC : ADC.w $0FA8 : CLC : ADC.b $0C : STA ($90), Y
    
    LDA.b $0F : STA.w $4202
    
    LDA .multiplicands, X : STA.w $4203
    
    JSR.w $B5BE ; $02B5BE IN ROM
    
    LDA.b $06 : ASL A
    
    LDA.w $4217 : BCC .theta
    
    EOR.b #$FF : INC A
    
    .theta
    
    CLC : ADC.w $0FA9 : CLC : ADC.b $0D : INY : STA ($90), Y
    LDA.b #$3F          : INY : STA ($90), Y
    LDA.b #$2D          : INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b #$00 : STA ($92), Y
    
    PLY : INY
    
    DEX : BPL .iota
    
    PLX
    
    LDY.b #$FF
    LDA.b #$04
    
    JSL Sprite_CorrectOamEntriesLong
    
    RTS
    
    .multiplicands
    db $33, $66, $99, $CC
}

; ==============================================================================

; $02B5BE-$02B5C2 LOCAL JUMP LOCATION
{
    NOP #4
    
    RTS
}

; ==============================================================================
