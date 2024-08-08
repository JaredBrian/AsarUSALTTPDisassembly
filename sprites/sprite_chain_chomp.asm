
; ==============================================================================

; $0EBE3C-$0EBE43 DATA
SpritePrep_ChainChomp_extended_subsprite_offsets:
{
    db $00, $10, $20, $30, $40, $50, $60, $70
}

; $0EBE44-$0EBE7C LONG JUMP LOCATION
SpritePrep_ChainChomp:
{
    PHX
    
    LDY.b #$05
    
    LDA.l .extended_subsprite_offsets, X : TAX
    
    REP #$20
    
    .next_slot
    
        LDA.w $0FD8 : STA.l $7FFC00, X
        LDA.w $0FDA : STA.l $7FFD00, X
        
        INX #2
    DEY : BPL .next_slot
    
    SEP #$20
    
    PLX
    
    LDA.w $0D10, X : STA.w $0D90, X
    LDA.w $0D30, X : STA.w $0DA0, X
    
    LDA.w $0D00, X : STA.w $0DB0, X
    LDA.w $0D20, X : STA.w $0ED0, X
    
    RTL
}

; ==============================================================================

; $0EBE7D-$0EBF09 JUMP LOCATION
Sprite_ChainChomp:
{
    JSR.w SpriteDraw_ChainChomp
    JSR.w Sprite4_CheckIfActive
    JSR.w Sprite4_CheckDamage
    JSR.w ChainChomp_HandleLeash
    
    TXA : EOR.b $1A : AND.b #$03 : BNE .BRANCH_ALPHA
        LDA.w $0D50, X : STA.b $01
        
        LDA.w $0D40, X : STA.b $00 : ORA.b $01 : BEQ .BRANCH_ALPHA
            JSL.l Sprite_ConvertVelocityToAngle : AND.b #$0F : STA.w $0DE0, X
    
    .BRANCH_ALPHA
    
    JSR.w Sprite4_MoveXyz
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .didnt_bounce
        STZ.w $0F70, X
        STZ.w $0F80, X
        
    .didnt_bounce
    
    JSL.l Sprite_Get_16_bit_CoordsLong
    
    LDA.w $0D90, X : STA.b $00
    LDA.w $0DA0, X : STA.b $01
    
    LDA.w $0DB0, X : STA.b $02
    LDA.w $0ED0, X : STA.b $03
    
    STZ.w $0EC0, X
    
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.b $00 : CLC : ADC.w #$0030
    
    CMP.w #$0060 : BCS .too_far_from_origin
        LDA.w $0FDA : SEC : SBC.b $02 : CLC : ADC.w #$0030
        
        CMP.w #$0060 : BCS .too_far_from_origin
            SEP #$20
            
            INC.w $0EC0, X
        
    .too_far_from_origin
    
    SEP #$20
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw ChainChomp_Idle        ; 0x00 - $BF2C
    dw ChainChomp_Meander     ; 0x01 - $BF95
    dw ChainChomp_InvertLunge ; 0x02 - $BFE5
}

; ==============================================================================

; $0EBF0C-$0EBF2B DATA
Pool_ChainChomp_Idle:
{
    ; $0EBF0C
    .lunge_speed_x
    db   0,   8,  11,  14,  16,  14,  11,   8
    db   0,  -8, -11, -14, -16, -14, -11,  -8

    ; $0EBF1C
    .lunge_speed_y
    db -16, -14, -11,  -8,   0,   8,  11,  14
    db  16,  14,  11,   8,   0,  -9, -11, -14
}

; $0EBF2C-$0EBF94 JUMP LOCATION
ChainChomp_Idle:
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        INC.w $0E80, X : LDA.w $0E80, X : CMP.b #$04 : BNE .BRANCH_BETA
            STZ.w $0E80, X
            
            LDA.b #$02 : STA.w $0D80, X
            
            JSL.l GetRandomInt : AND.b #$0F : TAY
            
            LDA.w Pool_ChainChomp_Idle_lunge_speed_x, Y : ASL #2 : STA.w $0D50, X
            
            LDA.w Pool_ChainChomp_Idle_lunge_speed_y, Y : ASL #2 : STA.w $0D40, X
            
            JSL.l GetRandomInt : AND.b #$00 : BNE .BRANCH_GAMMA
                LDA #$40
                
                JSL.l Sprite_ApplySpeedTowardsPlayerLong
                
                LDA.b #$04 : JSL.l Sound_SetSfx3PanLong
            
            .BRANCH_GAMMA
            
            RTS
        
        .BRANCH_BETA
        
        JSL.l GetRandomInt : AND.b #$1F : ADC.b #$10 : STA.w $0DF0, X
        
        JSL.l GetRandomInt : AND.b #$0F : TAY
        
        LDA.w Pool_ChainChomp_Idle_lunge_speed_x, Y : STA.w $0D50, X
        
        LDA.w Pool_ChainChomp_Idle_lunge_speed_y, Y : STA.w $0D40, X
        
        INC.w $0D80, X
        
        RTS
        
    .BRANCH_ALPHA
    
    JSR.w Sprite4_Zero_XY_Velocity
    
    RTS
}

; $0EBF95-$0EBFE4 JUMP LOCATION
ChainChomp_Meander:
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        LDA.b #$20 : STA.w $0DF0, X
        
        STZ.w $0D80, X
    
    .BRANCH_ALPHA
    
    AND.b #$0F : BNE .BRANCH_BETA
        JSR.w ChainChomp_MoveChain
    
    .BRANCH_BETA
    
    LDA.w $0F70, X : BNE .BRANCH_GAMMA
        LDA.b #$10 : STA.w $0F80, X
    
    .BRANCH_GAMMA
    
    LDA.w $0EC0, X : BNE .BRANCH_DELTA
        LDA.w $0D90, X : STA.b $04
        LDA.w $0DA0, X : STA.b $05
        LDA.w $0DB0, X : STA.b $06
        LDA.w $0ED0, X : STA.b $07
        
        LDA.b #$10
        
        JSL.l Sprite_ProjectSpeedTowardsEntityLong
        
        LDA.b $00 : STA.w $0D40, X
        
        LDA.b $01 : STA.w $0D50, X
        
        JSR.w Sprite4_Move
        
        LDA.b #$0C : STA.w $0DF0, X
        
    .BRANCH_DELTA
    
    RTS
}

; $0EBFE5-$0EC00B JUMP LOCATION
ChainChomp_InvertLunge:
{
    LDA.w $0EC0, X : BNE .BRANCH_ALPHA
        LDA.w $0D50, X : EOR.b #$FF : INC A : STA.w $0D50, X
        
        LDA.w $0D40, X : EOR.b #$FF : INC A : STA.w $0D40, X
        
        JSR.w Sprite4_Move
        JSR.w Sprite4_Zero_XY_Velocity
        
        INC.w $0D80, X
        
        LDA.b #$30 : STA.w $0E00, X
    
    .BRANCH_ALPHA
    
    BRA ChainChomp_Lunge_handle_chain
}

; $0EC00C-$0EC01F JUMP LOCATION
ChainChomp_Lunge:
{
    LDA.w $0E00, X : BNE .handle_chain
        STZ.w $0D80, X
        
        LDA.b #$30 : STA.w $0DF0, X
        
    .handle_chain
    
    JSR.w ChainChomp_MoveChain
    JSR.w ChainChomp_MoveChain
    
    RTS
}

; ==============================================================================

; $0EC020-$0EC029 DATA
ChainChomp_MoveChain_operand:
{
    db $CD, $00, $9A, $00
    db $66, $00, $33, $00
    db $08, $00
}

; $0EC02A-$0EC0F1 LOCAL JUMP LOCATION
ChainChomp_MoveChain:
{
    LDA.w $0D90, X : STA.b $00
    LDA.w $0DA0, X : STA.b $01
    
    LDA.w $0DB0, X : STA.b $02
    LDA.w $0ED0, X : STA.b $03
    
    PHX
    
    LDA.b #$05 : STA.b $0D
    
    LDA.w SpritePrep_ChainChomp_extended_subsprite_offsets, X : TAX
    
    LDA.l $7FFC00, X : SEC : SBC.b $00 : STA.b $04
    LDA.l $7FFD00, X : SEC : SBC.b $02 : STA.b $05
    
    INX #2

    ; $0EC05B ALTERNATE ENTRY POINT
    .next_link

        LDA.b $04
        
        ; .... okay...?
        PHP
        
        BPL .BRANCH_ALPHA
            EOR.b #$FF : INC A

        .BRANCH_ALPHA

        STA.w SNES.MultiplicandA
        
        PHX : TXA : AND.b #$0F : TAX
        
        LDA.w .operand-2, X : STA.w SNES.MultiplierB
        
        PLX
        
        NOP #7
        
        LDA.w SNES.RemainderResultHigh
        
        LDY.b #$00
        
        PLP : BPL .BRANCH_BETA
            EOR.b #$FF
            
            DEY

        .BRANCH_BETA

            CLC : ADC.b $00 : STA.b $08
        TYA : ADC.b $01 : STA.b $09
        
        LDA.b $05
        
        PHP
        
        BPL .BRANCH_GAMMA
            EOR.b #$FF : INC A

        .BRANCH_GAMMA

        STA.w SNES.MultiplicandA
        
        PHX
        
        TXA : AND.b #$0F : TAX
        
        LDA.w .operand-2, X : STA.w SNES.MultiplierB
        
        PLX
        
        NOP #7
        
        LDA.w SNES.RemainderResultHigh
        
        LDY.b #$00
        
        PLP : BPL .BRANCH_DELTA
            EOR.b #$FF
            
            DEY

        .BRANCH_DELTA

            CLC : ADC.b $02 : STA.b $0A
        TYA : ADC.b $03 : STA.b $0B
        
        REP #$20
        
        LDA.l $7FFC00, X : CMP $08 : BEQ .BRANCH_EPSILON
            BPL .BRANCH_ZETA
                INC #2

            .BRANCH_ZETA

            DEC A : STA.l $7FFC00, X

        .BRANCH_EPSILON

        LDA.l $7FFD00, X : CMP $0A : BEQ .BRANCH_THETA
            BPL .BRANCH_IOTA
                INC #2

            .BRANCH_IOTA

            DEC A : STA.l $7FFD00, X

        .BRANCH_THETA

        SEP #$20
        
        INX #2
        
        DEC.b $0D : BMI .BRANCH_KAPPA
    JMP.w .next_link

    .BRANCH_KAPPA

    PLX
    
    RTS
}

; $0EC0F2-$0EC171 LOCAL JUMP LOCATION
ChainChomp_HandleLeash:
{
    PHX
    
    LDA.w SpritePrep_ChainChomp_extended_subsprite_offsets, X : TAX
    
    REP #$20
    
    STZ.b $00
    
    LDA.w $0FD8 : STA.l $7FFC00, X
    LDA.w $0FDA : STA.l $7FFD00, X
    
    .BRANCH_EPSILON
    
        LDA.l $7FFC00, X : SEC : SBC.l $7FFC02, X
        
        CMP.w #$0008 : BPL .BRANCH_ALPHA
            CMP.w #$FFF8 : BPL .BRANCH_BETA
                LDA.l $7FFC00, X : CLC : ADC.w #$0008 : STA.l $7FFC02, X
                
                BRA .BRANCH_BETA
            
        .BRANCH_ALPHA
        
        LDA.l $7FFC00, X : SEC : SBC.w #$0008 : STA.l $7FFC02, X
        
        .BRANCH_BETA
        
        LDA.l $7FFD00, X : SEC : SBC.l $7FFD02, X
        
        CMP.w #$0008 : BPL .BRANCH_GAMMA
            CMP.w #$FFF8 : BPL .BRANCH_DELTA
                LDA.l $7FFD00, X : CLC : ADC.w #$0008 : STA.l $7FFD02, X
                
                BRA .BRANCH_DELTA
            
        .BRANCH_GAMMA
        
        LDA.l $7FFD00, X : SEC : SBC.w #$0008 : STA.l $7FFD02, X
        
        .BRANCH_DELTA
        
        INX #2
    INC.b $00 : LDA.b $00 : CMP.w #$0006 : BCC .BRANCH_EPSILON
    
    PLX
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0EC172-$0EC191 DATA
Pool_SpriteDraw_ChainChomp:
{
    ; $0EC172
    .animation_states
    db 0, 1, 2, 3, 3, 3, 2, 1
    db 0, 0, 0, 4, 4, 4, 0, 0
    
    ; $0EC182
    .h_flip
    db $40, $40, $40, $40, $00, $00, $00, $00
    db $00, $00, $00, $00, $40, $40, $40, $40
}

; $0EC192-$0EC210 LOCAL JUMP LOCATION
SpriteDraw_ChainChomp:
{
    LDY.w $0DE0, X
    
    LDA Pool_SpriteDraw_ChainChomp_animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$3F : ORA Pool_SpriteDraw_ChainChomp_h_flip, Y
    STA.w $0F50, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    
    LDA.w $0E00, X : AND.b #$01 : CLC : ADC.b #$04 : STA.b $08 : STZ.b $09
    
    LDA.b #$05 : STA.b $0D
    
    PHX
    
    LDA.w SpritePrep_ChainChomp_extended_subsprite_offsets, X : TAX
    
    LDY.b #$04
    
    .BRANCH_BETA
    
        REP #$20
        
        LDA.l $7FFC00, X : CLC : ADC.b $08 : SEC : SBC.b $E2 : STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.l $7FFD00, X : CLC : ADC.b $08 : SEC : SBC.b $E8 : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .BRANCH_ALPHA
            LDA.b #$F0 : STA ($90), Y
        
        .BRANCH_ALPHA
        
        LDA.b #$8B : INY : STA ($90), Y
        
        LDA.b $05 : AND.b #$F0 : ORA.b #$0D : INY : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b $0F : STA ($92), Y
        
        PLY : INY
        
        INX #2
    DEC.b $0D : BPL .BRANCH_BETA
    
    PLX
    
    RTS
}

; ==============================================================================
