; ==============================================================================

; TODO: These might need reinitialization, we should check up on what their
; specific function is.
; $0F0000-$0F0018 LONG JUMP LOCATION
HelmasaurKing_Initialize:
{
    LDA.b #$30 : STA.w $0B2F
    
    LDA.b #$80 : STA.w $0B2D
    
    STZ.w $0B2E
    STZ.w $0B30
    STZ.w $0B33
    STZ.w $0B31
    STZ.w $0B32

    ; Bleeds into the next function.
}

; $0F0019-$0F0038 LONG JUMP LOCATION
HelmasaurKing_Reinitialize:
{
    PHB : PHK : PLB : PHX
    
    LDA.w $0E80, X : STA.b $00
    
    LDY.b #$03
    
    .next_whatever
    
        LDA.b $00 : CLC : ADC.w Pool_HelmasaurKing_Initialize, Y
        AND.b #$1F : TAX
        LDA.w HelmasaurKingLeg_Offset_Y, X : STA.w $0B08, Y
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
            DEC : BNE .BRANCH_BETA
                STZ.w $0DD0, X
            
        .BRANCH_BETA
        
        JSL.l Sprite_PrepAndDrawSingleLargeLong
        JSR.w Sprite3_CheckIfActive
        
        LDA.b $1A : AND.b #$07 : ORA.w $0E00, X : BNE .BRANCH_GAMMA
            LDA.w $0F50, X : EOR.b #$40 : STA.w $0F50, X
        
        .BRANCH_GAMMA
        
        JSR.w Sprite3_MoveXyz
        
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
    
    JSR.w SpriteDraw_KingHelmasaur
    
    LDA.w $0DD0, X : CMP.b #$06 : BNE HelmasaurKing_Alive
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
                    
                    STZ.b $00
                    
                    LDA.w $0B0D, Y : BPL .BRANCH_KAPPA
                        DEC.b $00
                    
                    .BRANCH_KAPPA
                    
                    CLC : ADC.w $0D10, X : STA.w $0FD8
                    
                    LDA.w $0D30, X : ADC.b $00 : STA.w $0FD9
                    
                    STZ.b $00
                    
                    LDA.w $0B1D, Y : BPL .BRANCH_LAMBDA
                        DEC.b $00
                    
                    .BRANCH_LAMBDA
                    
                    CLC : ADC.w $0D00, X : STA.w $0FDA
                    
                    LDA.w $0D20, X : ADC.b $00 : STA.w $0FDB
                    
                    JSL.l Sprite_MakeBossDeathExplosion
        
        .BRANCH_IOTA
        
        RTS
}

; ==============================================================================

; $0F010A-$0F0116 DATA
HelmasaurKing_Alive_phase_hp:
{
    db $03, $03, $03, $03, $03, $03, $03, $03
    db $02, $02, $01, $01, $00
}

; $0F0117-$0F018B BRANCH LOCATION
HelmasaurKing_Alive:
{
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0E50, X : LSR : LSR : TAY
    LDA.w .phase_hp, Y : STA.w $0DB0, X
    CMP.b #$03 : BNE .BRANCH_ALPHA
        CMP.w $0E90, X : BEQ .BRANCH_BETA
            STZ.w $0EF0, X
            
            JSR.w HelmasaurKing_ExplodeMask
            
            BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    CMP.w $0E90, X : BEQ .BRANCH_BETA
        JSR.w HelmasaurKing_ChipAwayAtMask
    
    .BRANCH_BETA
    
    LDA.w $0DB0, X : STA.w $0E90, X
    
    JSL.l Sprite_CheckDamageFromPlayerLong
    JSR.w HelmasaurKing_SwingTail
    JSR.w HelmasaurKing_AttemptDamage
    JSR.w HelmasaurKing_CheckMaskDamageFromHammer
    
    LDA.w $0E00, X : BEQ .BRANCH_GAMMA
        CMP.b #$60 : BEQ .BRANCH_DELTA
        
        RTS
    
    .BRANCH_GAMMA
    
    LDA.w $0E10, X : BEQ .BRANCH_EPSILON
        CMP.b #$40 : BNE .BRANCH_ZETA
            JSR.w HelmasaurKing_SpitFireball
            
            LDA.w $0DB0, X : CMP.b #$03 : BCC .BRANCH_ZETA
                .BRANCH_DELTA
                
                LDA.w $0EC0, X : BNE .BRANCH_ZETA
                    INC.w $0EC0, X
                    
                    LDA.b #$20 : STA.w $0EE0, X
        
        .BRANCH_ZETA
        
        RTS
    
    .BRANCH_EPSILON
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw HelmasaurKing_DecisionHome   ; 0x00 - $819C
    dw HelmasaurKing_WalkToLocation ; 0x01 - $81D5
    dw HelmasaurKing_DecisionAway   ; 0x02 - $8210
    dw HelmasaurKing_WalkBackHome   ; 0x03 - $8242
}

; $0F018C-$0F019B DATA
Pool_HelmasaurKing_DecisionHome:
{
    ; $0F018C
    .speed_x
    db -12, -12,  -4,   0,   4,  12,  12,   0

    ; $0F0194
    .speed_y
    db   0,   4,  12,  12,  12,   4,   0,  12
}

; $0F019C-$0F01D4 JUMP LOCATION
HelmasaurKing_DecisionHome:
{
    LDA.w $0EF0, X : BNE .BRANCH_ALPHA
        LDA.w $0DF0, X : BNE .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    JSR.w HelmasaurKing_MaybeFireball
    
    JSL.l GetRandomInt : AND.b #$07 : TAY
    LDA.w Pool_HelmasaurKing_DecisionHome_speed_x, Y : STA.w $0D50, X
    LDA.w Pool_HelmasaurKing_DecisionHome_speed_y, Y : STA.w $0D40, X
    
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
HelmasaurKing_WalkToLocation:
{
    JSR.w HelmasaurKing_HandleMovement
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        LDA.b #$20 : STA.w $0DF0, X
        
        INC.w $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}


; $0F01E6-$0F01FF LOCAL JUMP LOCATION
HelmasaurKing_HandleMovement:
{
    JSR.w HelmasaurKing_ShuffleLegs
    
    LDA.b $1A : AND.b #$03 : BNE .BRANCH_ALPHA
        JSR.w HelmasaurKing_ShuffleLegs
    
    .BRANCH_ALPHA
    
    LDA.w $0DB0, X : CMP.b #$03 : BCC .BRANCH_BETA
        JSR.w HelmasaurKing_ShuffleLegs
    
    .BRANCH_BETA
    
    JSR.w Sprite3_Move
    
    RTS
}


; $0F0200-$0F020F LOCAL JUMP LOCATION
HelmasaurKing_ShuffleLegs:
{
    INC.w $0E80, 
    LDA.w $0E80, X : AND.b #$0F : BNE .BRANCH_ALPHA
        LDA.b #$21 : STA.w $012E
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F0210-$0F0241 JUMP LOCATION
HelmasaurKing_DecisionAway:
{
    LDA.w $0EF0, X : BNE .BRANCH_ALPHA
        LDA.w $0DF0, X : BNE .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    JSR.w HelmasaurKing_MaybeFireball
    
    LDA #$40 : STA.w $0DF0, X
    
    LDA.w $0E90, X : CMP.b #$03 : BCC .BRANCH_GAMMA
        LSR.w $0DF0, X
    
    .BRANCH_GAMMA
    
    LDA.w $0D50, X : EOR.b #$FF : INC : STA.w $0D50, X
    
    LDA.w $0D40, X : EOR.b #$FF : INC : STA.w $0D40, X
    
    INC.w $0D80, X
    
    .BRANCH_BETA
    
    RTS
}

; $0F0242-$0F0252 JUMP LOCATION
HelmasaurKing_WalkBackHome:
{
    JSR.w HelmasaurKing_HandleMovement
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        STZ.w $0D80, X
        
        LDA.b #$40 : STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F0253-$0F027B LOCAL JUMP LOCATION
HelmasaurKing_MaybeFireball:
{
    INC.w $0E30, X
    
    LDA.w $0E30, X : CMP.b #$04 : BNE .BRANCH_ALPHA
        PLA : PLA
        
        STZ.w $0E30, X
        
        JSL.l GetRandomInt : AND.b #$01 : BEQ .BRANCH_BETA
            LDA.b #$7F : STA.w $0E10, X
            
            LDA.b #$2A
            JSL.l Sound_SetSFX3PanLong
            
            RTS
        
        .BRANCH_BETA
        
        LDA.b #$A0 : STA.w $0E00, X
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $0F027C-$0F029B DATA
HelmasaurKingLeg_Offset_Y:
{
    db $00, $01, $02, $03, $04, $05, $06, $07
    db $08, $08, $08, $08, $08, $08, $08, $08
    db $08, $08, $08, $08, $08, $08, $08, $08
    db $08, $07, $06, $05, $04, $03, $02, $01
}

; $0F029C-$0F029F DATA
Pool_HelmasaurKing_Initialize:
{
    db 0, 8, 16, 24
}

; ==============================================================================

; $0F02A0-$0F032C LOCAL JUMP LOCATION
HelmasaurKing_SwingTail:
{
    INC.w $0B0C
    
    JSL.l HelmasaurKing_Reinitialize
    
    LDA.b #$01
    
    LDY.w $0EC0, X : BEQ .BRANCH_ALPHA
        LDA.b #$00
    
    .BRANCH_ALPHA
    
    AND.b $1A : BNE .BRANCH_BETA
        LDA.w $0DE0, X : AND.b #$01 : TAY
        LDA.w $0B30 : CLC : ADC.w HelmasaurKing_TailSwingRotationDirection, Y
        STA.w $0B30
        CMP.w Sprite3_Shake_x_speeds, Y : BNE .BRANCH_GAMMA
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
            LDA.b #$06
            JSL.l Sound_SetSFX3PanLong
        
        .BRANCH_ZETA
        
        LDA.w $0EC0, X : CMP.b #$02 : BEQ .do_segment_a
            CMP.b #$03 : BEQ .do_segment_b
                LDA.w $0B30 : ORA.w $0EE0, X : BNE HelmasaurKing_SwingTail_do_segment_b_return
                    LDA.w $0B2E : AND.b #$01 : STA.w $0EB0, X
                    
                    JSR.w Sprite3_IsToRightOfPlayer
                    
                    TYA : EOR.b #$01 : CMP.w $0EB0, X : BNE .BRANCH_EPSILON
                        INC.w $0EC0, X
                        
                        JSL.l Sound_SetSFXPan : ORA.b #$26 : STA.w $012F
    
    .BRANCH_EPSILON
    
    RTS

    ; $0F0327
    .offset_low
    db    4,   -4

    ; $0F0329
    .offset_high
    db    0,   -1

    ; $0F032B
    .limit
    db  124, -124
}

; $0F032D-$0F0356 LOCAL JUMP LOCATION
HelmasaurKing_SwingTail_do_segment_a:
{
    LDY.w $0EB0, X
    
    LDA.w $0B31 : CLC : ADC.w HelmasaurKing_SwingTail_offset_low, Y
    STA.w $0B31 : PHA

    LDA.w $0B32 :       ADC.w HelmasaurKing_SwingTail_offset_high, Y
    STA.w $0B32
    
    PLA : CMP.w HelmasaurKing_SwingTail_limit, Y : BNE .BRANCH_ALPHA
        INC.w $0EC0, X
    
    .BRANCH_ALPHA
    
    LDA.w $0B2F : CLC : ADC.b #$03 : STA.w $0B2F
    
    RTS
}

; $0F0357-$0F0382 BRANCH LOCATION
HelmasaurKing_SwingTail_do_segment_b:
{
    LDA.w $0EB0, X : EOR.b #$01 : TAY
    
    LDA.w $0B31 : CLC : ADC.w HelmasaurKing_SwingTail_offset_low, Y
    STA.w $0B31 : PHA

    LDA.w $0B32 :       ADC.w HelmasaurKing_SwingTail_offset_high, Y
    STA.w $0B32
    
    PLA : CMP.b #$00 : BNE .BRANCH_ALPHA
        STZ.w $0EC0, X
    
    .BRANCH_ALPHA
    
    LDA.w $0B2F : SEC : SBC.b #$03 : STA.w $0B2F

    ; $0F0382 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $0F0383-$0F0384 DATA
HelmasaurKing_TailSwingRotationDirection:
{
    db 1, -1
}

; ==============================================================================

; $0F0385-$0F03EA LOCAL JUMP LOCATION
HelmasaurKing_CheckMaskDamageFromHammer:
{
    LDA.w $0DB0, X : CMP.b #$03 : BCS .BRANCH_ALPHA
        LDA.w $0301 : AND.b #$0A : BEQ .BRANCH_ALPHA
            LDA.b $44 : CMP.b #$80 : BEQ .BRANCH_ALPHA
                JSL.l Player_SetupActionHitBoxLong
                
                LDA.w $0D00, X : PHA
                CLC : ADC.b #$08 : STA.w $0D00, X
                
                JSL.l Sprite_SetupHitBoxLong
                
                PLA : STA.w $0D00, X
                
                JSL.l Utility_CheckIfHitBoxesOverlapLong : BCC .BRANCH_ALPHA
                    DEC.w $0E50, X
                    
                    LDA.b #$21 : STA.w $012F
                    
                    LDA.b #$30
                    JSL.l Sprite_ProjectSpeedTowardsPlayerLong
                    
                    LDA.b $00 : STA.b $27
                    LDA.b $01 : STA.b $28
                    
                    LDA.b #$08 : STA.w $0046
                    
                    LDA.w $0FAC : BNE .BRANCH_BETA
                        LDA.b $00 : STA.w $0FAD
                        LDA.b $01 : STA.w $0FAE
                        
                        LDA.b #$05 : STA.w $0FAC
                    
                    .BRANCH_BETA
                    
                    LDA.b #$05
                    JSL.l Sound_SetSFX2PanLong
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F03EB-$0F0419 LOCAL JUMP LOCATION
HelmasaurKing_AttemptDamage:
{
    LDA.b $1A : AND.b #$07 : BNE .BRANCH_ALPHA
        REP #$20
        
        LDA.b $22 : SEC : SBC.w $0FD8 : CLC : ADC.w #$0024 : CMP.w #$0048 : BCS .BRANCH_ALPHA
            LDA.b $20 : SEC : SBC.w $0FDA : CLC : ADC.w #$0028 : CMP.w #$0040 : BCS .BRANCH_ALPHA
                SEP #$20
                
                JSL.l Sprite_AttemptDamageToPlayerPlusRecoilLong
    
    .BRANCH_ALPHA
    
    SEP #$20
    
    RTS
}

; $0F041A-$0F047E DATA
Pool_HelmasaurKing_SpawnMaskDebris:
{
    ; $0F041A
    .offset_y_low
    db  24,  27,  24,  24,  27,  24,  27,  27,  24,  24

    ; $0F0424
    .offset_y_high
    db   0,   0,   0,   0,   0,   0,   0,   0,   0,   0

    ; $0F042E
    .offset_x_low
    db -16,   0,  16, -16,   0,  16,  -8,   8, -16,  16

    ; $0F0438
    .offset_x_high
    db  -1,   0,   0,  -1,   0,   0,  -1,   0,  -1,   0

    ; $0F0442
    .initial_z
    db  29,  32,  29,  13,  16,  13,   0,   0,  13,  13

    ; $0F044C
    .speed_x
    db -16,  -4,  14, -12,   4,  18,  -2,   2, -12,  18

    ; $0F0456
    .speed_y
    db  -8,  -4,  -6,   4,   2,   7,   6,   8,   4,   7

    ; $0F0460
    .speed_z
    db  32,  40,  36,  37,  39,  34,  30,  33,  37,  34

    ; $0F046A
    .flip
    db $00, $00, $40, $00, $00, $40, $00, $40, $00, $40

    ; $0F0474
    .starting_anim
    db $00, $01, $00, $02, $03, $02, $04, $04, $05, $05
}

; $0F047E-$0F048B LOCAL JUMP LOCATION
HelmasaurKing_ChipAwayAtMask:
{
    LDA.w $0DB0, X : CLC : ADC.b #$07 : STA.w $0FB5
    
    JSR.w HelmasaurKing_SpawnMaskDebris
    
    BRA HelmasaurKing_ExplodeMask_make_SFX
}

; $0F048C-$0F04A9 LOCAL JUMP LOCATION
HelmasaurKing_ExplodeMask:
{
    LDY.b #$0F
    LDA.b #$00
    
    .BRANCH_BETA
    
        STA.w $0DD0, Y
    DEY : BNE .BRANCH_BETA
    
    LDA.b #$07 : STA.w $0FB5
    
    .BRANCH_GAMMA
    
        JSR.w HelmasaurKing_SpawnMaskDebris
    DEC.w $0FB5 : BPL .BRANCH_GAMMA
    
    ; $0F04A3 ALTERNATE ENTRY POINT
    .make_SFX
    
    LDA.b #$1F
    JSL.l Sound_SetSFX2PanLong
    
    RTS
}

; I think this can spawn all of parts of the Helmasaur King's mask
; flying off due to damage...
; $0F04AA-$0F0516 LOCAL JUMP LOCATION
HelmasaurKing_SpawnMaskDebris:
{
    LDA.b #$92
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        PHX
        
        LDX.w $0FB5
        LDA.b $00
        CLC : ADC.w Pool_HelmasaurKing_SpawnMaskDebris_offset_x_low, X : STA.w $0D10, Y

        LDA.b $01
        ADC.w Pool_HelmasaurKing_SpawnMaskDebris_offset_x_high, X : STA.w $0D30, Y
        
        LDA.b $02
        CLC : ADC.w Pool_HelmasaurKing_SpawnMaskDebris_offset_y_low, X : STA.w $0D00, Y

        LDA.b $03
        ADC.w Pool_HelmasaurKing_SpawnMaskDebris_offset_y_high, X : STA.w $0D20, Y
        
        LDA.w Pool_HelmasaurKing_SpawnMaskDebris_initial_z, X : STA.w $0F70, Y
        LDA.w Pool_HelmasaurKing_SpawnMaskDebris_speed_x, X   : STA.w $0D50, Y
        LDA.w Pool_HelmasaurKing_SpawnMaskDebris_speed_y, X   : STA.w $0D40, Y
        LDA.w Pool_HelmasaurKing_SpawnMaskDebris_speed_z, X   : STA.w $0F80, Y
        
        LDA.w Pool_HelmasaurKing_SpawnMaskDebris_flip, X : ORA.b #$0D : STA.w $0F50, Y
        
        LDA.w Pool_HelmasaurKing_SpawnMaskDebris_starting_anim, X : STA.w $0DC0, Y
        
        LDA.b #$80 : STA.w $0DB0, Y
        ASL        : STA.w $0E40, Y
        
        LDA.b #$0C : STA.w $0E00, Y
                     STA.w $0BA0, Y
        
        LDA.w $0FB5 : STA.w $0E30, Y
        
        PLX
    
    .spawn_failed
    
    RTS
}

; $0F0517-$0F053A LOCAL JUMP LOCATION
HelmasaurKing_SpitFireball:
{
    ; Spawn helmasaur king fireball...
    LDA.b #$70
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b $02 : CLC : ADC.b #$1C : STA.w $0D00, Y
        LDA.b $03 :       ADC.b #$00 : STA.w $0D20, Y
        
        LDA.b #$20 : STA.w $0DF0, Y
                     STA.w $0BA0, Y
    
    .spawn_failed
    
    RTS
}

; $0F053B-$0F055E LOCAL JUMP LOCATION
SpriteDraw_KingHelmasaur:
{
    REP #$20
    
    LDA.w #$089C : STA.b $90
    LDA.w #$0A47 : STA.b $92
    
    SEP #$20
    
    JSR.w Sprite3_PrepOamCoord
    JSR.w KingHelmasaur_OperateTail
    JSR.w SpriteDraw_KingHelmasaur_Eyes
    JSR.w KingHelmasaurMask
    JSR.w SpriteDraw_KingHelmasaur_Body
    JSR.w SpriteDraw_KingHelmasaur_Legs
    JSR.w SpriteDraw_KingHelmasaur_Mouth
    
    RTS
}

; ==============================================================================

; $0F055F-$0F056A DATA
Pool_SpriteDraw_KingHelmasaur_Eyes:
{
    ; $0F055F
    .x_offsets
    db -3, 11
    
    ; $0F0561
    .chr
    db $CE, $CF, $DE, $DE, $DE, $DE, $CF, $CE
    
    ; $0F0569
    .properties
    db $3B, $7B
}

; $0F056B-$0F05C5 LOCAL JUMP LOCATION
SpriteDraw_KingHelmasaur_Eyes:
{
    REP #$20
    
    LDA.b $90 : CLC : ADC.w #$0040 : STA.b $90
    LDA.b $92 : CLC : ADC.w #$0010 : STA.b $92
    
    SEP #$20
    
    PHX
    
    LDY.b #$00
    LDX.b #$01
    
    .BRANCH_ALPHA
    
        PHX
        
        LDA.b $00 : CLC : ADC Pool_SpriteDraw_KingHelmasaur_Eyes_x_offsets, X
        STA.b ($90), Y

        LDA.b $02 : CLC : ADC.b #$14 : INY : STA.b ($90), Y
        
        LDA.w $0B0C : LSR : LSR : AND.b #$07 : TAX
        LDA.w Pool_SpriteDraw_KingHelmasaur_Eyes_chr, X : INY : STA.b ($90), Y
        
        PLX
        
        LDA.w Pool_SpriteDraw_KingHelmasaur_Eyes_properties, X : INY : STA.b ($90), Y
        
        PHY
        TYA : LSR : LSR : TAY
        LDA.b #$00 : STA.b ($92), Y
        
        PLY : INY
    DEX : BPL .BRANCH_ALPHA
    
    PLX
    
    LDA.b $11 : BEQ .BRANCH_BETA
        LDY.b #$00
        LDA.b #$01
        JSL.l Sprite_CorrectOamEntriesLong
    
    .BRANCH_BETA
    
    RTS
}

; $0F0686-$0F06E4 LOCAL JUMP LOCATION
KingHelmasaurMask:
{
    LDA.b #$00 : XBA
    LDA.w $0DB0, X
    
    REP #$20
    
    ASL #6 : ADC.w #$85C6 : STA.b $08
    
    LDA.b $90 : CLC : ADC.w #$0008 : STA.b $90
    
    INC.b $92 : INC.b $92
    
    SEP #$20
    
    LDA.w $0DB0, X : CMP.b #$03 : BCS .BRANCH_ALPHA
        LDA.b #$08
        JSR.w Sprite3_DrawMultiple
        
        REP #$20
        
        LDA.b $90 : CLC : ADC.w #$0020 : STA.b $90
        LDA.b $92 : CLC : ADC.w #$0008 : STA.b $92
        
        SEP #$20
        
        LDA.w $0F10, X : BEQ .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    RTS
    
    .BRANCH_BETA
    
    LDY.b #$01
    
    .nextSlot
    
        LDA.w $0C4A, Y : CMP.b #$07 : BNE .notBomb
            LDA.w $0C2C, Y : ORA.w $0C22, Y : BEQ .BRANCH_GAMMA
                JSR.w KingHelmasaur_CheckBombDamage

            .BRANCH_GAMMA
        .notBomb
    DEY : BPL .nextSlot
    
    RTS
}

; Helmasaur king checking for proximity between exploding bombs and its mask,
; probably.
; $0F06E5-$0F074C LOCAL JUMP LOCATION
KingHelmasaur_CheckBombDamage:
{
    JSL.l Sprite_SetupHitBoxLong
    
    LDA.w $0C04, Y : CLC : ADC.b #$06 : STA.b $00
    LDA.w $0C18, Y :       ADC.b #$00 : STA.b $08
    
    LDA.w $0BFA, Y : SEC : SBC.w $029E, Y : STA.b $01
    LDA.w $0C0E, Y :       SBC.b #$00     : STA.b $09
    
    LDA.b #$02 : STA.b $02
    LDA.b #$0F : STA.b $03
    
    JSL.l Utility_CheckIfHitBoxesOverlapLong : BCC .BRANCH_ALPHA
        LDA.w $0C2C, Y : EOR.b #$FF : INC : STA.w $0C2C, Y
        LDA.w $0C22, Y : EOR.b #$FF : INC : STA.b $00
        ASL.b $00 : ROR                   : STA.w $0C22, Y
        
        LDA.b #$20 : STA.w $0F10, X
        
        LDA.b #$05 : STA.w $0FAC
        
        LDA.w $0C04, Y : STA.w $0FAD
        
        LDA.w $0BFA, Y : SEC : SBC.w $029E, Y : STA.w $0FAE
        
        ; Make "clink against wall" noise
        LDA.b #$05 : STA.w $012E
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F07E5-$0F07EF LOCAL JUMP LOCATION
SpriteDraw_KingHelmasaur_Body:
{
    REP #$20
    
    LDA.w #$874D : STA.b $08
    
    SEP #$20
    
    LDA.b #$13
    
    ; Bleeds into the next function.
}

; $0F07F0-$0F07F4 LOCAL JUMP LOCATION
Sprite3_DrawMultiple:
{
    JSL.l Sprite_DrawMultiple
    
    RTS
}

; $0F07F5-$0F0804 DATA
Pool_SpriteDraw_KingHelmasaur_Legs:
{
    ; $0F07F5
    .offset_x
    db -28, -28,  28,  28

    ; $0F07F9
    .offset_y
    db -28,   4, -28,   4

    ; $0F07FD
    .char
    db $A2, $A6, $A2, $A6

    ; $0F0801
    .prop
    db $0B, $0B, $4B, $4B
}

; $0F0805-$0F089B LOCAL JUMP LOCATION
SpriteDraw_KingHelmasaur_Legs:
{
    REP #$20
    
    LDA.b $90 : CLC : ADC.w #$004C : STA.b $90
    LDA.b $92 : CLC : ADC.w #$0013 : STA.b $92
    
    SEP #$20
    
    PHX
    
    LDY.b #$00
    
    LDA.b #$03 : STA.w $0FB5
    
    .BRANCH_ALPHA
    
        LDX.w $0FB5
        
        LDA.b $00 : CLC : ADC.w Pool_SpriteDraw_KingHelmasaur_Legs_offset_x, X
        STA.b ($90), Y
        
        LDA.b $02 : CLC : ADC.w Pool_SpriteDraw_KingHelmasaur_Legs_offset_y, X
        CLC : ADC.w $0B08, X : INY : STA.b ($90), Y

        LDA.w Pool_SpriteDraw_KingHelmasaur_Legs_char, X : INY : STA.b ($90), Y

        LDA.w Pool_SpriteDraw_KingHelmasaur_Legs_prop, X : EOR.b $05 : INY : STA.b ($90), Y
        
        PHY
        TYA : LSR : LSR : TAY
        LDA.b #$02 : STA.b ($92), Y
        
        PLY : INY
        
        LDA.b $00 : CLC : ADC.w Pool_SpriteDraw_KingHelmasaur_Legs_offset_x, X
        STA.b ($90), Y
        
        LDA.b $02 : CLC : ADC.w Pool_SpriteDraw_KingHelmasaur_Legs_offset_y, X
        CLC : ADC.b #$10 : CLC : ADC.w $0B08, X : INY : STA.b ($90), Y

        LDA.w Pool_SpriteDraw_KingHelmasaur_Legs_char, X : CLC : ADC.b #$02
        INY : STA.b ($90), Y

        LDA.w Pool_SpriteDraw_KingHelmasaur_Legs_prop, X : EOR.b $05 : INY : STA.b ($90), Y
        
        PHY
        TYA : LSR : LSR : TAY
        LDA.b #$02 : STA.b ($92), Y
        
        PLY : INY
    DEC.w $0FB5 : BPL .BRANCH_ALPHA
    
    PLX
    
    LDA.b $11 : BEQ .BRANCH_BETA
        LDY.b #$02
        LDA.b #$07
        JSL.l Sprite_CorrectOamEntriesLong

        JSR.w Sprite3_PrepOamCoord
    
    .BRANCH_BETA
    
    RTS
}

; $0F089C-$0F08BB DATA
SpriteDraw_KingHelmasaur_Mouth_offset_y:
{
    db  1,  2,  3,  4,  5,  6,  7,  8
    db  9, 10, 10, 10, 10, 10, 10, 10
    db 10, 10, 10, 10, 10, 10, 10,  9
    db  8,  7,  6,  5,  4,  3,  2,  1
}

; $0F08BC-$0F08EF LOCAL JUMP LOCATION
SpriteDraw_KingHelmasaur_Mouth:
{
    LDA.w $0E10, X : BEQ .BRANCH_ALPHA
        LSR : LSR : TAY
        LDA.w .offset_y, Y : STA.b $06
        
        LDA.b #$04
        JSL.l OAM_AllocateFromRegionB
        
        LDY.b #$00
        LDA.b $00                                       : STA.b ($90), Y
        LDA.b $02  : CLC : ADC.b #$13 : ADC.b $06 : INY : STA.b ($90), Y
        LDA.b #$AA                                : INY : STA.b ($90), Y
        LDA.b $05  : EOR.b #$0B                   : INY : STA.b ($90), Y
        
        LDA.b #$02 : STA.b ($92)
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $0F08F0-$0F091F DATA
Pool_KingHelmasaur_OperateTail:
{
    ; $0F08F0
    .multiplier_a
    db $FF, $F0, $E0, $D0, $C0, $B0, $A0, $90
    db $80, $70, $60, $50, $40, $30, $20, $10

    ; $0F0900
    .multiplier_b
    db $FF, $F8, $F0, $E8, $E0, $D8, $D0, $C8
    db $BC, $B0, $A0, $90, $70, $40, $20, $10

    ; $0F0910
    .multiplier_c
    db $FF, $F0, $E0, $D0, $C0, $B0, $A0, $90
    db $80, $70, $60, $50, $40, $30, $20, $10
}

; $0F0920-$0F0A84 LOCAL JUMP LOCATION
KingHelmasaur_OperateTail:
{
    STZ.w $0FB5
    
    ; $0F0923 ALTERNATE ENTRY POINT
    .next_segment
    
        LDY.w $0FB5 : PHY
        
        LDA.w $0EC0, X : BEQ .BRANCH_ALPHA
            TYA : CLC : ADC.b #$10 : TAY
        
        .BRANCH_ALPHA
        
        REP #$20
        
        LDA.w $0B2D : CLC : ADC.w $0B31 : STA.b $0D
        
        SEP #$20
        
        LDA.b $0E : CMP.b #$01
        
        PHP : PHP
        LDA.b $0D : PLP : BPL .BRANCH_BETA
            EOR.b #$FF : INC
        
        .BRANCH_BETA
        
        STA.w SNES.MultiplicandA
        
        LDA.w Pool_KingHelmasaur_OperateTail_multiplier_a, Y : STA.w SNES.MultiplierB
        
        JSR.w Sprite3_DivisionDelay
        
        LDA.w SNES.RemainderResultHigh : PLP : BPL .BRANCH_GAMMA
            EOR.b #$FF
        
        .BRANCH_GAMMA
        
        STA.b $06
        
        LDA.b $0E : STA.b $07
        
        PLY
        
        LDA.w $0B2F : STA.w SNES.MultiplicandA
        LDA.w Pool_KingHelmasaur_OperateTail_multiplier_c, Y : STA.w SNES.MultiplierB
        
        JSR.w Sprite3_DivisionDelay
        
        LDA.w SNES.RemainderResultHigh : STA.b $0F
        
        PHX
        
        REP #$30
        
        LDA.b $06 : AND.w #$00FF : ASL : TAX
        LDA.l SmoothCurve, X : STA.b $0A
        
        LDA.b $06 : CLC : ADC.w #$0080 : STA.b $08
        AND.w #$00FF : ASL             : TAX
        LDA.l SmoothCurve, X : STA.b $0C
        
        SEP #$30
        
        PLX
        
        LDA.b $0A : STA.w SNES.MultiplicandA
        
        LDA.b $0F
        
        LDY.b $0B : BNE .BRANCH_DELTA
            STA.w SNES.MultiplierB
            
            JSR.w Sprite3_DivisionDelay
            
            ASL.w SNES.RemainderResultLow
            
            LDA.w SNES.RemainderResultHigh : ADC.b #$00
        
        .BRANCH_DELTA
        
        LSR.b $07 : BCC .BRANCH_EPSILON
            EOR.b #$FF : INC
        
        .BRANCH_EPSILON
        
        LDY.w $0FB5
        STA.w $0B0D, Y
        
        LDA.b $0C : STA.w SNES.MultiplicandA
        
        LDA.b $0F
        
        LDY.b $0D : BNE .BRANCH_ZETA
            STA.w SNES.MultiplierB
            
            JSR.w Sprite3_DivisionDelay
            
            ASL.w SNES.RemainderResultLow
            
            LDA.w SNES.RemainderResultHigh : ADC.b #$00
        
        .BRANCH_ZETA
        
        LSR.b $09 : BCC .BRANCH_THETA
            EOR.b #$FF : INC
        
        .BRANCH_THETA
        
        LDY.w $0FB5
        SEC : SBC.b #$28 : STA.w $0B1D, Y
        
        INC.w $0FB5
        LDA.w $0FB5 : CMP.b #$10 : BEQ .BRANCH_IOTA
    JMP.w .next_segment
    
    .BRANCH_IOTA
    
    LDA.w $0EC0, X : STA.b $0A
    
    STZ.b $0F
    
    PHX
    
    LDX.w $0B33 : CPX.b #$10 : BEQ .BRANCH_KAPPA
        LDY.b #$00
        
        .BRANCH_NU
        
            LDA.b $00 : CLC : ADC.w $0B0D, X       : STA.b ($90), Y
                                                     STA.b $08

            LDA.b $02 : CLC : ADC.w $0B1D, X : INY : STA.b ($90), Y
                                                     STA.b $09
            
            LDA.b #$AC
            
            CPY.b #$01 : BNE .BRANCH_LAMBDA
                LDA.b #$E4
            
            .BRANCH_LAMBDA
            
                                     INY : STA.b ($90), Y
            LDA.b $05 : EOR.b #$1B : INY : STA.b ($90), Y
            
            INY
            
            TXA : EOR.b $1A : AND.b #$00 : ORA.w $031F : BNE .BRANCH_MU
                LDA.b $0A : BEQ .BRANCH_MU
                    LDA.b $22 : SBC.b $E2 : SBC.b $08 : ADC.b #$0C
                    CMP.b #$18 : BCS .BRANCH_MU
                        LDA.b $20 : SBC.b $E8 : ADC.b #$08 : SBC.b $09 : ADC.b #$08
                        CMP.b #$10 : BCS .BRANCH_MU
                            INC.b $0F
                            
                            STZ.b $28
                            
                            LDA.b #$38 : STA.b $27
            
            .BRANCH_MU
        INX : CPX.b #$10 : BNE .BRANCH_NU
    
    .BRANCH_KAPPA
    
    PLX
    
    LDA.b $0F : BEQ .BRANCH_XI
        LDA.w $0FFC : BNE .BRANCH_XI
            JSL.l Sprite_AttemptDamageToPlayerPlusRecoilLong
    
    .BRANCH_XI
    
    LDY.b #$02
    LDA.b #$0F
    JSL.l Sprite_CorrectOamEntriesLong
    
    JSR.w Sprite3_PrepOamCoord
    
    RTS
}

; ==============================================================================
