; ==============================================================================

; $0EB830-$0EB896 DATA
Pool_Sidenexx:
{
    ; $0EB830
    .segment_boundary_x
    db   64,   64,   64,   64,   64,   64,   64,   64,   64
    db   88,  100,  106,  111,  116,  122,  126, -128, -128
    db   57,   72,   82,   92,  101,  115,  119,  122, -128
    db   30,   36,   41,   46,   52,   58,   68,   77, -128
    db   10,   17,   23,   28,   34,   42,   54,   58, -128

    ; $0EB85D
    .segment_boundary_y
    db   48,   40,   35,   30,   25,   19,   12,    6,    0
    db   47,   38,   33,   29,   24,   18,   12,    6,    0
    db   47,   39,   34,   29,   24,   18,   12,    6,    0
    db   47,   39,   34,   29,   24,   18,   12,    6,    0
    db   72,   58,   50,   41,   34,   25,   16,    7,    0

    ; $0EB88A
    .base_offset_x
    db -14,  13

    ; $0EB88C
    .base_offset_y
    db  -1,   0

    ; $0EB88E
    db   0,   1,  -1,   0,   0,  -1,   0,   1,  -1
}

; $0EB897-$0EB89E JUMP LOCATION
Sidenexx_Breath_FireHead:
{
    LDA.w $0E90, X : BEQ Sidenexx
        JMP TrinexxBreath_fire
}

; $0EB89F-$0EB8A6 JUMP LOCATION
Sidenexx_Breath_IceHead:
{
    LDA.w $0E90, X : BEQ Sidenexx
        JMP TrinexxBreath_ice
}

; $0EB8A7-$0EB92A JUMP LOCATION
Sidenexx:
{
    LDA.w $0E20, X : SEC : SBC.b #$CC : TAY
    
    LDA.w $0D90 : CLC : ADC.w Pool_Sidenexx_base_offset_x, Y
    STA.w $0D90, X

    LDA.w $0DA0 :       ADC.w Pool_Sidenexx_base_offset_y, Y
    STA.w $0DA0, X
    
    LDA.w $0DB0 : SEC : SBC.b #$20 : STA.w $0DB0, X
    
    LDA.w $0ED0 : SBC.b #$00 : STA.w $0ED0, X
    
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSR.w SpriteDraw_Sidenexx
    JSR.w Sprite4_CheckIfActive
    
    LDA.w $0D80, X : BPL .BRANCH_BETA
        STA.w $0BA0, X
        
        JMP.w Sidenexx_Explode
    
    .BRANCH_BETA
    
    LDA.w $0EF0, X : BEQ .BRANCH_GAMMA
        LDA.w $0D80, X : CMP.b #$04 : BEQ .BRANCH_GAMMA
            STZ.w $0EF0, X
            
            LDA.b #$80 : STA.w $0DF0, X
            LDA.b #$04 : STA.w $0D80, X
            
            LDA.w $0F50, X : STA.w $0F80, X
            
            LDA.b #$03 : STA.w $0F50, X
        
    .BRANCH_GAMMA
    
    JSR.w Sprite4_CheckDamage
    
    LDA.w $0CAA, X : ORA.b #$04 : STA.w $0CAA, X
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Sidenexx_Dormant ; 0x00 - $B986
    dw Sidenexx_Think   ; 0x01 - $B9A6
    dw Sidenexx_Move    ; 0x02 - $B9F2
    dw Sidenexx_Breathe ; 0x03 - $BA70
    dw Sidenexx_Stunned ; 0x04 - $B92B
}

; $0EB92B-$0EB985 JUMP LOCATION
Sidenexx_Stunned:
{
    LDA.w $0CAA, X : AND.b #$FB : STA.w $0CAA, X
    
    STZ.w $0E30, X
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        PHA
        
        LDA.b #$01 : STA.w $0D80, X
        LDA.b #$20 : STA.w $0DF0, X
        
        LDA.w $0F80, X : STA.w $0F50, X
        
        STZ.w $0EF0, X
        
        PLA

    .BRANCH_ALPHA

    CMP.b #$0F : BCC .BRANCH_BETA
        CMP.b #$4E : BCS .BRANCH_GAMMA
        CMP.b #$3F : BCC .BRANCH_GAMMA
            LDA.w $0E20, X : CMP.b #$CD : BNE .BRANCH_DELTA
                PHX
                
                JSL.l PaletteFilter_IncreaseTrinexxBlue
                
                PLX
                
                RTS

            .BRANCH_DELTA

            PHX
            
            JSL.l PaletteFilter_IncreaseTrinexxRed
            
            PLX

        .BRANCH_GAMMA

        RTS

    .BRANCH_BETA

    LDA.w $0E20, X : CMP.b #$CD : BNE .BRANCH_EPSILON
        PHX
        
        JSL.l PaletteFilter_RestoreTrinexxBlue
        
        PLX
        
        RTS

    .BRANCH_EPSILON

    PHX
    
    JSL.l PaletteFilter_RestoreTrinexxRed
    
    PLX
    
    RTS
}

; $0EB986-$0EB9A5 JUMP LOCATION
Sidenexx_Dormant:
{
    LDA.w $0E60, X : ORA.b #$40 : STA.w $0E60, X
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        LDA.b #$02 : STA.w $0D80, X
        LDA.b #$09 : STA.w $0E80, X
        
        LDA.w $0E60, X : AND.b #$BF : STA.w $0E60, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0EB9A6-$0EB9F1 JUMP LOCATION
Sidenexx_Move:
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        LDA.w $0DE0, X : STA.b $00
        
        JSL.l GetRandomInt : AND.b #$07 : INC : CMP.b #$05 : BCS .BRANCH_ALPHA
            CMP.w $0DE0, X : BEQ .BRANCH_ALPHA
                STA.w $0DE0, X
                
                INC.w $0D80, X
                
                LDA.b $00 : CMP.b #$01 : BNE .BRANCH_ALPHA
                    JSL.l GetRandomInt : LSR : BCS .BRANCH_ALPHA
                        LDA.w $0D80 : CMP.b #$02 : BCS .BRANCH_ALPHA   
                            INC.w $0DC0, X : LDA.w $0DC0, X : CMP.b #$06
                            
                            NOP #2
                            
                            STZ.w $0DC0, X
                            
                            LDA.b #$03 : STA.w $0D80, X
                            
                            LDA.b #$7F : STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0EB9F2-$0EBA66 JUMP LOCATION
Sidenexx_Think:
{
    STZ.b $01
    
    LDA.w $0DE0, X : ASL #3 : ADC.w $0DE0, X : TAY
    
    LDA.w Sidenexx_SegmentIndexOffset, X : PHX : TAX
    
    LDA.b #$08 : STA.b $00
    
    .BRANCH_IOTA
    
        LDA.w $1D10, X : CMP.w Pool_Sidenexx_segment_boundary_x, Y : BEQ .BRANCH_ALPHA
            BPL .BRANCH_BETA
                INC.w $1D10, X
                
                INC.b $01
                
                BRA .BRANCH_ALPHA
            
            .BRANCH_BETA
            
            DEC.w $1D10, X
            
            INC.b $01
        
        .BRANCH_ALPHA
        
        LDA.w $1D10, X : CMP.w Pool_Sidenexx_segment_boundary_x, Y : BEQ .BRANCH_GAMMA
            BPL .BRANCH_DELTA
                INC.w $1D10, X
                
                INC.b $01
                
                BRA .BRANCH_GAMMA
            
            .BRANCH_DELTA
            
            DEC.w $1D10, X
            
            INC.b $01
        
        .BRANCH_GAMMA
        
        LDA.b $1A : AND.b #$00 : BNE .BRANCH_EPSILON
            LDA.w $1D50, X : CMP.w Pool_Sidenexx_segment_boundary_y, Y : BEQ .BRANCH_ZETA
                BPL .BRANCH_THETA
                    INC.w $1D50, X
                    
                    INC.b $01
                    
                    BRA .BRANCH_ZETA
                
                .BRANCH_THETA
                
                DEC.w $1D50, X
            
        .BRANCH_EPSILON
        
        INC.b $01
        
        .BRANCH_ZETA
        
        INX
        
        INY
        
    DEC.b $00 : BPL .BRANCH_IOTA
    
    PLX
    
    LDA.b $01 : BNE .BRANCH_KAPPA
        DEC.w $0D80, X
        
        JSL.l GetRandomInt : AND.b #$0F : STA.w $0DF0, X
    
    .BRANCH_KAPPA
    
    RTS
}

; $0EBA68-$0EBA6F DATA
Sidenexx_Breathe_timer_masks:
{
    db $01, $01, $03, $03, $07, $0F, $1F, $1F
}

; $0EBA70-$0EBAE5 JUMP LOCATION
Sidenexx_Breathe:
{
    LDA.w $0DF0, X : BNE .breathe_yes
        STZ.w $0D80, X
        
        LDA.b #$20 : STA.w $0DF0, X
        
        RTS
    
    .breathe_yes
    
    CMP.b #$40 : BNE .dont_breathe
        PHA
        
        JSR.w Sidenexx_ExhaleDanger
        
        PLA
        
    .dont_breathe
    
    CMP.b #$08 : BCC .continue
        CMP.b #$79 : LDA.b #$08 : BCC .continue
            LDA.w $0DF0, X : CLC : ADC.b #$80 : EOR.b #$FF
    
    .continue

    STA.w $0E30, X
    
    LDA.w $0DF0, X : CMP.b #$40 : BCC .exit
        SEC : SBC.b #$40 : LSR #3 : TAY
        
        LDA.b $1A : AND.w .timer_masks, Y : BNE .exit
            JSL.l GetRandomInt : AND.b #$0F : LDY.b #$00
            SEC : SBC.b #$03 STA.b $00 : BPL .positive
                DEY
            
            .positive
            
            STY.b $01
            
            JSL.l GetRandomInt : AND.b #$0F : CLC : ADC.b #$0C : STA.b $02
            STZ.b $03
            
            JSL.l Sprite_SpawnSimpleSparkleGarnish
            
            LDA.w $0E20, X : CMP.b #$CC : BNE .exit
                PHX
                
                LDX.b $0F
                
                LDA.b #$0E : STA.l $7FF800, X
                
                PLX
    
    .exit
    
    RTS
}

; ==============================================================================

; $0EBAE6-$0EBAE7 DATA
SidenexxExhaleDanger_x_accelerations:
{
    db -2, 1
}

; $0EBAE8-$0EBB3E LOCAL JUMP LOCATION
Sidenexx_ExhaleDanger:
{
    LDA.w $0E20, X : CMP.b #$CD : BNE .breathe_fire
        STZ.w $0FB6
        
        JSR.w .breathe_ice
        
        INC.w $0FB6
        
        LDA.b #$CD
        
        ; $0EBAFA ALTERNATE ENTRY POINT
        .breathe_ice
            JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            
            JSL.l Sprite_SetSpawnedCoords
            
            PHX
            
            LDX.w $0FB6
            
            LDA.w .x_accelerations, X : STA.w $0DB0, Y
            
            PLX
            
            LDA.b #$19 : JSL.l Sound_SetSfx3PanLong
            
            BRA .final_adjustments
    
    .breathe_fire
    
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b #$2A : JSL.l Sound_SetSfx2PanLong
        
        .final_adjustments
        
        LDA.b #$01 : STA.w $0E90, Y
                     STA.w $0BA0, Y
        
        LDA.b #$18 : STA.w $0D40, Y
        
        LDA.b #$00 : STA.w $0E40, Y
        
        LDA.b #$40 : STA.w $0E60, Y
    
    .spawn_failed
    
    RTS
}

; $0EBB3F-$0EBB6C LOCAL JUMP LOCATION
Sidenexx_Explode:
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        LDA.b #$0C : STA.w $0DF0, X
        
        LDA.w $0E80, X : CMP.b #$01 : BNE .BRANCH_BETA
            STZ.w $0DD0, X
        
        .BRANCH_BETA
        
        DEC.w $0E80, X
        
        LDA.w $0FD8 : CLC : ADC.b $E2 : STA.w $0FD8
        
        LDA.w $0FDA : CLC : ADC.b $E8 : STA.w $0FDA
        
        JSL.l Sprite_MakeBossDeathExplosion
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $0EBB6D-$0EBB6F DATA
Sidenexx_SegmentIndexOffset:
{
    db 0, 9, 18
}

; ==============================================================================

; $0EBB70-$0EBC8B LOCAL JUMP LOCATION
SpriteDraw_Sidenexx:
{
    LDA.w $0D90, X : STA.w $0D10, X
    
    LDA.w $0DA0, X : STA.w $0D30, X
    
    LDA.w $0DB0, X : STA.w $0D00, X
    
    LDA.w $0ED0, X : STA.w $0D20, X
    
    JSL.l Sprite_Get_16_bit_CoordsLong
    JSR.w Sprite4_PrepOamCoord
    
    STZ.w $0FB5
    STZ.w $0FB6
    
    ; $0EBB95 ALTERNATE ENTRY POINT
    .next_segment
    
        LDY.w $0FB5
        
        TYA : CLC : ADC.w Sidenexx_SegmentIndexOffset, X : TAY
        
        CPX.b #$02 : BEQ .BRANCH_ALPHA
            LDA   $1D10, Y : EOR.b #$FF : INC : STA.b $06
            LDA.b #$01                          : STA.b $07
            
            BRA .BRANCH_BETA
            
        .BRANCH_ALPHA
        
        LDA.w $1D10, Y : STA.b $06 : STZ.b $07
        
        .BRANCH_BETA
        
        LDA.w $1D50, Y : STA.b $0F
        
        PHX
        
        REP #$30
        
        LDA.b $06 : AND.w #$00FF : ASL : TAX
        
        LDA.l SmoothCurve, X : STA.b $0A
        
        LDA.b $06 : CLC : ADC.w #$0080 : STA.b $08
        AND.w #$00FF : ASL : TAX
        
        LDA.l SmoothCurve, X : STA.b $0C
        
        SEP #$30
        
        PLX
        
        LDA.b $0A : STA.w SNES.MultiplicandA
        
        LDA.b $0F
        
        LDY.b $0B : BNE .BRANCH_GAMMA
            STA.w SNES.MultiplierB
            
            NOP #8
            
            ASL.w SNES.RemainderResultLow
            
            LDA.w SNES.RemainderResultHigh : ADC.b #$00
        
        .BRANCH_GAMMA
        
        LSR.b $07 : BCC .BRANCH_DELTA
            EOR.b #$FF : INC A
        
        .BRANCH_DELTA
        
        STA.w $0FA8
        
        LDA.b $0C : STA.w SNES.MultiplicandA
        
        LDA.b $0F
        
        LDY.b $0D : BNE .BRANCH_EPSILON
            STA.w SNES.MultiplierB
            
            NOP #8
            
            ASL.w SNES.RemainderResultLow
            
            LDA.w SNES.RemainderResultHigh : ADC.b #$00
        
        .BRANCH_EPSILON
        
        LSR.b $09 : BCC .BRANCH_ZETA
            EOR.b #$FF : INC A
        
        .BRANCH_ZETA
        
        STA.w $0FA9
        
        LDA.w $0FB5 : BNE .BRANCH_THETA
            JSR.w SpriteDraw_Sidenexx_Head
            
            BRA .BRANCH_IOTA
        
        .BRANCH_THETA
        
        LDA.b $00   : CLC : ADC.w $0FA8 : LDY.w $0FB6       : STA ($90), Y
        STA.w $0FD8

        LDA.w $0FA9 : CLC : ADC.b $02   : LDY.w $0FB6 : INY : STA ($90), Y
        STA.w $0FDA

        LDA.b #$08 : INY : STA ($90), Y
        LDA.b $05  : INY : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b #$02 : STA ($92), Y
        
        PLY : INY : STY.w $0FB6
        
        .BRANCH_IOTA
        
        INC.w $0FB5 : LDA.w $0FB5 : CMP.w $0E80, X : BEQ .BRANCH_KAPPA
    JMP.w .next_segment

    .BRANCH_KAPPA
    
    LDA.b $11 : BEQ .BRANCH_LAMBDA
        LDY.b #$02
        LDA.b #$04
        
        JSL.l Sprite_CorrectOamEntriesLong
    
    .BRANCH_LAMBDA
    
    RTS
}

; $0EBC8C-$0EBC9F DATA
Pool_SpriteDraw_Sidenexx_Head:
{
    ; $0EBC8C
    .offset_x
    db  -8,   8,  -8,   8,   0

    ; $0EBC91
    .offset_y
    db  -8,  -8,   8,   8,   2

    ; $0EBC96
    .char
    db $04, $04, $24, $24, $0A

    ; $0EBC9B
    .flip
    db $40, $00, $40, $00, $00
}

; $0EBCA0-$0EBD25 LOCAL JUMP LOCATION
SpriteDraw_Sidenexx_Head:
{
    LDA.w $0E30, X : STA.b $08
    
    PHX
    
    LDX.b #$00
    
    LDY.w $0FB6
    
    .BRANCH_BETA
        
        LDA.w $0FA8 : CLC : ADC.b $00 : STA.w $0FD8
        
        CLC : ADC.w Pool_SpriteDraw_Sidenexx_Head_offset_x, X : STA ($90), Y
        
        LDA.w $0FA9 : CLC : ADC.b $02 : STA.w $0FDA
        
        CLC : ADC.w Pool_SpriteDraw_Sidenexx_Head_offset_y, X
        
        CPX.b #$04 : BNE .BRANCH_ALPHA
            CLC : ADC.b $08
        
        .BRANCH_ALPHA
        
        INY : STA ($90), Y

        LDA.w Pool_SpriteDraw_Sidenexx_Head_char, X : INY : STA ($90), Y
        LDA.b $05 : ORA.w Pool_SpriteDraw_Sidenexx_Head_flip, X : INY : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b #$02 : STA ($92), Y
        
        PLY : INY
    INX : CPX.b #$05 : BNE .BRANCH_BETA
    
    PLX
    
    LDA.w $0FB6 : CLC : ADC.b #$14 : STA.w $0FB6
    
    LDY.b #$00
    
    LDA.w $0FA8 : BPL .BRANCH_GAMMA
        DEY
    
    .BRANCH_GAMMA
    
    CLC : ADC.w $0D90, X : STA.w $0D10, X
    TYA : ADC.w $0DA0, X : STA.w $0D30, X
    
    LDY.b #$00
    
    LDA.w $0FA9 : BPL .BRANCH_DELTA
        DEY
    
    .BRANCH_DELTA
    
    CLC : ADC.w $0DB0, X : STA.w $0D00, X
    TYA : ADC.w $0ED0, X : STA.w $0D20, X
    
    RTS
}

; ==============================================================================

; $0EBD26-$0EBD27 DATA
TrinexxBreath_x_speed_targets:
{
    db 16, -16
}

; ==============================================================================

; $0EBD28-$0EBD64 LOCAL JUMP LOCATION
TrinexxBreath_ice:
{
    JSL.l Sprite_PrepOamCoordLong
    JSR.w Sprite4_CheckIfActive
    
    LDA.w $0D50, X : PHA : CLC : ADC.w $0DB0, X : STA.w $0D50, X
    
    JSR.w Sprite4_Move
    
    PLA : STA.w $0D50, X
    
    JSR.w AddIceGarnish
    
    ; $0EBD44 ALTERNATE ENTRY POINT
    .finish_up
    
    LDA.b $1A : AND.b #$03 : BNE .no_shake
        JSR.w Sprite4_IsToRightOfPlayer
        
        LDA.w $0D50, X : CMP TrinexxBreath_x_speed_targets, Y : BEQ .no_shake
            CLC : ADC.w Pool_Sprite_ApplyConveyorAdjustment_x_shake_values, Y : STA.w $0D50, X
    
    .no_shake
    
    JSR.w Sprite4_CheckTileCollision : BEQ .BRANCH_BETA
        STZ.w $0DD0, X
    
    .BRANCH_BETA
    
    RTS
}

; $0EBD65-$0EBDC5 LOCAL JUMP LOCATION
AddIceGarnish:
{
    INC.w $0E80, X
    
    LDA.w $0E80, X : AND.b #$07 : BNE .BRANCH_ALPHA
        LDA.b #$14 : JSL.l Sound_SetSfx3PanLong
        
        PHX : TXY
        
        LDX.b #$1D
        
        .BRANCH_GAMMA
        
            LDA.l $7FF800, X : BEQ .BRANCH_BETA
        DEX : BPL .BRANCH_GAMMA
        
        DEC.w $0FF8 : BPL .BRANCH_DELTA
            LDA.b #$1D : STA.w $0FF8
        
        .BRANCH_DELTA
        
        LDX.w $0FF8
        
        .BRANCH_BETA
        
        LDA.b #$0C : STA.l $7FF800, X : STA.w $0FB4
        
        TYA : STA.l $7FF92C, X
        
        LDA.w $0D10, Y :                    STA.l $7FF83C, X
        LDA.w $0D30, Y :                    STA.l $7FF878, X
        LDA.w $0D00, Y : CLC : ADC.b #$10 : STA.l $7FF81E, X
        LDA.w $0D20, Y :       ADC.b #$00 : STA.l $7FF85A, X
        
        LDA.b #$7F : STA.l $7FF90E, X
        
        PLX
        
    .BRANCH_ALPHA
    
    RTS
}

; $0EBDC6-$0EBDD5 JUMP LOCATION
TrinexxBreath_fire:
{
    JSL.l Sprite_PrepOamCoordLong
    JSR.w Sprite4_CheckIfActive
    JSR.w Sprite4_Move
    JSR.w AddFireGarnish

    JMP.w TrinexxBreath_ice_finish_up
}
    
; $0EBDD6-$0EBDE7 JUMP LOCATION
AddFireGarnish:
{
    INC.w $0E80, X
    LDA.w $0E80, X : AND.b #$07 : BNE FireBat_SpawnFireballGarnish_exit
        LDA.b #$2A : JSL.l Sound_SetSfx2PanLong
        
        LDA.b #$1D

        ; Bleeds into the next function.
}
        
; $0EBDE8-$0EBE3B JUMP LOCATION
FireBat_SpawnFireballGarnish:
{
    PHX : TXY
        
    TAX : STA.b $00
        
    .next_slot
        
        LDA.l $7FF800, X : BEQ .BRANCH_BETA
    DEX : BPL .next_slot
        
     DEC.w $0FF8 : BPL .use_search_index
        LDA.b $00 : STA.w $0FF8
        
    .use_search_index
        
    LDX.w $0FF8
        
    .BRANCH_BETA
        
    LDA.b #$10 : STA.l $7FF800, X : STA.w $0FB4
        
    TYA : STA.l $7FF92C, X
        
    LDA.w $0D10, Y : STA.l $7FF83C, X
    LDA.w $0D30, Y : STA.l $7FF878, X
        
    LDA.w $0D00, Y : CLC : ADC.b #$10 : STA.l $7FF81E, X
    LDA.w $0D20, Y :       ADC.b #$00 : STA.l $7FF85A, X
        
    LDA.b #$7F : STA.l $7FF90E, X
        
    STX.b $00
        
    PLX
    
    .exit
    
    RTS
}

; ==============================================================================
