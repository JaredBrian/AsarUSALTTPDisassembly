; ==============================================================================

; $0F5310-$0F532F DATA
Pool_Sprite_Agahnim:
{
    ; $0F5310
    .Direction
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $05, $05, $00, $01, $01, $04
    db $04, $00, $02, $02, $04, $04, $03, $02
    db $02

    ; $0F5329
    .DirectionStepOffset
    db $02, $0A, $08, $00, $04, $06, $FA
}

; $0F5330-$0F536E JUMP LOCATION
Sprite_Agahnim:
{
    JSR.w AgahDraw
    
    LDA.w $0F00, X : BEQ .BRANCH_ALPHA
        LDA.b #$20 : STA.w $0DF0, X
        
        LDA.b #$00 : STA.w $0DC0, X
        
        LDA.b #$03 : STA.w $0DE0, X
    
    .BRANCH_ALPHA
    
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckIfRecoiling
    
    LDA.b #$01 : STA.w $0BA0, X
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Agah1or2                 ; 0x00 - $D4EC
    dw Agah1Inro                ; 0x01 - $D4F6
    dw Agahnim_EmergeFromShadow ; 0x02 - $D524
    dw AttachThenFadeToBlack    ; 0x03 - $D566
    dw Agahnim_ChooseWarpSpot   ; 0x04 - $D630
    dw ShadowSneak              ; 0x05 - $D708
    dw Agahnim_HelloDarkWorld   ; 0x06 - $D45E
    dw Agahnim_CreateClones     ; 0x07 - $D47C
    dw Agahnim_ExorciseGanon    ; 0x08 - $D3DA
    dw Agahnim_UncloneSelf      ; 0x09 - $D408
    dw Agahnim_SpinToPyramid    ; 0x0A - $D376
}

; ==============================================================================

; $0F536F-$0F5375 DATA
Agahnim_SpinToPyramid_animation_states:
{
    db 0, 8, 10, 2, 2, 6, 4
}

; $0F5376-$0F53D9 JUMP LOCATION
Agahnim_SpinToPyramid:
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA ; Is the timer still going?
        ; Time is done. Kill Agahnim.
        PHX
        
        STZ.w $0DD0, X
        
        JSL.l PrepDungeonExit
        
        PLX
    
    .BRANCH_ALPHA
    
    ; If Timer > #$10, branch:
    LDA.w $0DF0, X : CMP.b #$10 : BCS .BRANCH_BETA
        LDA.b #$7F : STA.b $9A
        
        LDA.b #$06 : STA.b $1C
        LDA.b #$10 : STA.b $1D
        
        PHX
        
        JSL.l Palette_Filter_SP5F
        
        PLX
    
    .BRANCH_BETA
    
    LDA.w $0DF0, X : AND.b #$00 : BNE .BRANCH_GAMMA
        LDA.w $0F80, X : CMP.b #$FF : BEQ .BRANCH_GAMMA
            CLC : ADC.b #$01 : STA.w $0F80, X
    
    .BRANCH_GAMMA
    
    LDA.w $0F90, X : CLC : ADC.w $0F80, X : STA.w $0F90, X : BCC .BRANCH_DELTA
        INC.w $0E80, X : LDA.w $0E80, X : CMP.b #$07 : BNE .BRANCH_DELTA
            STZ.w $0E80, X
            
            LDA.b #$04 : JSL.l Sound_SetSfx2PanLong
        
    .BRANCH_DELTA
    
    LDY.w $0E80, X
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F53DA-$0F5407 JUMP LOCATION
Agahnim_ExorciseGanon:
{
    LDA.b #$02 : STA.w $0FFC
    
    STZ.w $0EB0, X
    
    LDA.w $0DF0, X : CMP.b #$40 : BCC .BRANCH_ALPHA
        LDA.w $0EF0, X : ORA.b #$E0 : STA.w $0EF0, X
        
        RTS
    
    .BRANCH_ALPHA
    
    CMP.b #$01 : BNE .BRANCH_BETA
        JSL.l Sprite_SpawnPhantomGanon
        
        LDA.b #$1D : STA.w $012C
    
    .BRANCH_BETA
    
    STZ.w $0EF0, X
    
    LDA.b #$11 : STA.w $0DC0, X
    
    RTS
}

; $0F5408-$0F545D JUMP LOCATION
Agahnim_UncloneSelf:
{
    STZ.w $0EB0, X
    
    LDA.w $0D10 : STA.b $04
    LDA.w $0D30 : STA.b $05
    
    LDA.w $0D00 : STA.b $06
    LDA.w $0D20 : STA.b $07
    
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.b $04 : CLC : ADC.w #$0004 : CMP.w #$0008 : BCS .BRANCH_ALPHA
        LDA.w $0FDA : SEC : SBC.b $06 : CLC : ADC.w #$0004 : CMP.w #$0008 : BCS .BRANCH_ALPHA
            SEP #$20
            
            STZ.w $0DD0, X
    
    .BRANCH_ALPHA
    
    SEP #$20
    
    LDA.b #$20
    
    JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    
    LDA.b $01 : STA.w $0D50, X
    
    JSR.w Sprite3_Move
    JSL.l Sprite_SpawnAgahnimAfterImage
    
    RTS
}

; ==============================================================================

; $0F545E-$0F5479 JUMP LOCATION
Agahnim_HelloDarkWorld:
{
    LDA.w $0DF0, X : BNE .delay
        ; "I'm very happy to see you again... but you better believe we will"
        ; "will not have a third meeting! ..."
        LDA.b #$41 : STA.w $1CF0
        LDA.b #$01 : STA.w $1CF1
        
        JSL.l Sprite_ShowMessageMinimal
        
        INC.w $0D80, X
        
        LDA.b #$50 : STA.w $0DF0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F547A-$0F547B DATA
Agahnim_CreateClones_x_speeds:
{
    db 32, -32
}

; $0F547C-$0F54E9 JUMP LOCATION
Agahnim_CreateClones:
{
    LDA.w $0EC0, X : BEQ .spawn_clones
        LDA.w $0DF0, X : BNE .BRANCH_ALPHA
            JMP.w Agahnim_PrepareToAttack
        
        .BRANCH_ALPHA
        
        ; Each of the clones has its own x speed at the start... I guess
        ; that's what is going on here.
        LDA.w x_speeds-1, X : STA.w $0D50, X
        
        ; And speed up the y velocity.
        LDA.w $0D40, X : CLC : ADC.b #$02 : STA.w $0D40, X
        
        JSR.w Sprite3_Move
        
        JSL.l Sprite_SpawnAgahnimAfterImage : BMI .BRANCH_BETA
            LDA.b #$04 : STA.w $0F50, Y
        
        .BRANCH_BETA
        
        RTS

    ; $0F54A7
    .special_properties
    db $09, $0B

    .spawn_clones

    LDA.w $0DF0, X : BNE .ai_transition_delay
        JMP.w Agahnim_PrepareToAttack
    
    .ai_transition_delay
    
    CMP.b #$40 : BNE .cloning_delay
        LDA.b #$28 : STA.w $012F
        
        LDA.b #$01 : STA.w $0FB5
        
        .clone_spawn_loop
        
            LDA.b #$7A
            LDY.b #$02
            
            JSL.l Sprite_SpawnDynamically_arbitrary
            JSL.l Sprite_SetSpawnedCoords
            
            LDA.w .special_properties, Y : STA.w $0E60, Y
            
            AND.b #$0F : STA.w $0F50, Y : STA.w $0EC0, Y
            
            LDA.w $0D80, X : STA.w $0D80, Y
            
            LDA.b #$20 : STA.w $0DF0, Y
        DEC.w $0FB5 : BPL .clone_spawn_loop
    
    .cloning_delay
    
    RTS
}

; ==============================================================================

; $0F54EA-$0F54EB DATA
Agah1or2_ai_states:
{
    db 1, 6
}

; $0F54EC-$0F54F5 JUMP LOCATION
Agah1or2:
{
    ; Check if we are in the LW or DW. If dark world go to agah 2 instead.
    LDY.w $0FFF
    
    LDA.w .ai_states, Y : STA.w $0D80, X
    
    RTS
}

; $0F54F6-$0F551E JUMP LOCATION
Agah1Inro:
{
    LDA.w $0DF0, X : BNE Agahnim_PrepareToEmerge_dontShowIntroMessage
        ; Oh, so?...  You mean to say you would like to be totally destroyed?
        ; Well, I can make your wish come true!
        LDA.b #$3F : STA.w $1CF0
        LDA.b #$01 : STA.w $1CF1
        
        JSL.l Sprite_ShowMessageMinimal
        
        ; Bleeds into the next function.
}

; $0F5509-$0F5513 LOCAL JUMP LOCATION
Agahnim_PrepareToAttack:
{
    LDA.b #$03 : STA.w $0D80, X
        
    LDA.b #$20 : STA.w $0DF0, X
        
    RTS
}

; $0F5514-$0F551E LOCAL JUMP LOCATION
Agahnim_PrepareToEmerge:
{
    LDA.b #$02 : STA.w $0D80, X
        
    LDA.b #$27 : STA.w $0DF0, X
    
    .dontShowIntroMessage

    RTS
}

; ==============================================================================

; $0F551F-$0F5523 DATA
Agahnim_EmergeFromShadow_animation_states:
{
    db 12, 13, 14, 15, 16, 
}

; $0F5524-$0F553F JUMP LOCATION
Agahnim_EmergeFromShadow:
{
    STZ.w $0FF8
    
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$FF : STA.w $0DF0, X
        
        RTS
    
    .delay
    
    LSR #3 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F5540-$0F5565 DATA
Pool_AttachThenFadeToBlack:
{
    ; $0F5540
    .attack_anim_offset
    db 0, 0, 0, 0, 0, 0, 0, 1
    db 1, 1, 1, 1, 1, 1, 0, 0
    
    ; $0F5550
    .attack_anim_ball_step
    db 0, 0, 0, 0, 0, 0, 0, 6
    db 5, 4, 3, 2, 1, 0, 0, 0
    
    ; $0F5560
    .attack_anim_ball_step_offset
    db $1E, $18, $0C, $00, $06, $12
}

; $0F5566-$0F560A JUMP LOCATION
AttachThenFadeToBlack:
{
    LDA.w $0DF0, X : CMP.b #$C0 : BNE .BRANCH_ALPHA
        PHA
        
        LDA.b #$27 : JSL.l Sound_SetSfx3PanLong
        
        PLA
    
    .BRANCH_ALPHA
    
    CMP.b #$EF : BCS .BRANCH_BETA
        CMP.b #$10 : BCS .BRANCH_GAMMA
    
    .BRANCH_BETA
    
    PHX
    
    LDA.b $0FFF : BNE .inDarkWorld
        ; Apparently Agahnim is only in sprite slot 0x01 (of 0x10) in the 
        ; light world.
        LDX.b #$02
    
    .inDarkWorld
    
    JSL.l PaletteFilter_Agahnim
    
    PLX
    
    BRA .BRANCH_EPSILON
    
    .BRANCH_GAMMA
    TXA : BNE .BRANCH_EPSILON
        JSR.w Sprite3_CheckDamage
    
        STZ.w $0BA0, X
    
    .BRANCH_EPSILON
    
    LDA.w $0DF0, X : BNE .BRANCH_ZETA
        INC.w $0D80, X
        
        LDA.b #$27 : STA.w $0DF0, X
        
        RTS
    
    .BRANCH_ZETA
    
    CMP.b #$80 : BCC .BRANCH_THETA  
        PHA
            
        LDA.b #$02
            
        JSL.l Sprite_ApplySpeedTowardsPlayerLong
            
        LDY.b $01
            
        LDA.b $00 : CLC : ADC.b #$02 : STA.b $02
            
        ASL #2 : ADC.b $02 : ADC.b #$02 : CLC : ADC.b $01 : TAY
            
        LDA.w Pool_Sprite_Agahnim_Direction, Y : STA.w $0DE0, X
            
        LDA.b #$20 : JSL.l Sprite_ApplySpeedTowardsPlayerLong
            
        LDA.w $0E30, X : CMP.b #$04 : BNE .BRANCH_IOTA
            LDA.b #$03 : STA.w $0DE0, X
        
        .BRANCH_IOTA
        
        PLA
        
    .BRANCH_THETA
    
    CMP.b #$70 : BNE .BRANCH_KAPPA
        PHA
        
        JSR.w DoLightningAttack
        
        PLA
    
    .BRANCH_KAPPA
    
    LSR #4 : TAY
    
    LDA.w Pool_AttachThenFadeToBlack_attack_anim_offset, Y : STA.w $0D90, X
    
    LDA.w Pool_AttachThenFadeToBlack_attack_anim_ball_step, Y : BEQ .BRANCH_LAMBDA
        CLC
        
        LDY.w $0DE0, X
        
        ADC.w Pool_AttachThenFadeToBlack_attack_anim_ball_step_offset, Y
    
    .BRANCH_LAMBDA
    
    STA.w $0EB0, X
    
    LDY.w $0DE0, X
    
    LDA.w Pool_Sprite_Agahnim_DirectionStepOffset, Y
    CLC : ADC.w $0D90, X : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F560B-$0F562F DATA
Pool_Agahnim_ChooseWarpSpot:
{
    ; TODO: Name this routine / pool.
    ; $0F560B
    .animation_states
     db 16, 15, 14, 13, 12
    
    ; $F5610
    .targetXPos
    db $38, $38, $38, $58, $78, $98, $B8, $B8
    db $B8, $98, $58, $58, $60, $90, $98, $78
    
    ; $F5620
    .targetYPos
    db $B8, $78, $58, $48, $48, $48, $58, $78
    db $B8, $B8, $B8, $90, $70, $70, $90, $A0
}

; $0F5630-$0F5667 JUMP LOCATION
Agahnim_ChooseWarpSpot:
{
    LDA.w $0DF0, X : STA.w $0BA0, X : BNE .delay 
        INC.w $0D80, X
            
        LDY.b #$04
            
        LDA.w $0E30, X : CMP.b #$04 : BEQ .BRANCH_BETA
            JSL.l GetRandomInt : AND.b #$0F : TAY
        
        .BRANCH_BETA
        
        LDA Pool_Agahnim_ChooseWarpSpot_targetXPos, Y : STA.w $0DB0, X
        LDA Pool_Agahnim_ChooseWarpSpot_targetYPos, Y : STA.w $0E90, X
            
        LDA.b #$08 : STA.w $0ED0, X
            
        RTS
        
    .delay
    
    LSR #3 : TAY
    
    LDA.w Pool_Agahnim_ChooseWarpSpot_animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F5668-$0F5679 DATA
Pool_DoLightningAttack:
{
    ; $0F5668
    .x_offsets_low
    db  0, 10,  8,  0, -10, -10
    
    ; $0F566E
    .x_offsets_high
    db  0,  0,  0,  0,  -1,  -1
    
    ; $0F5674
    .y_offsets_low
    db -9, -2, -2, -9,  -2,  -2
}

; $0F567A-$0F5707 LOCAL JUMP LOCATION
DoLightningAttack:
{
    CPX.b #$00 : BNE .BRANCH_ALPHA
        INC.w $0E30, X
        
        LDA.w $0FFF : BEQ .BRANCH_ALPHA
            LDA.w $0E30, X : AND.b #$03 : STA.w $0E30, X
    
    .BRANCH_ALPHA
    
    LDA.w $0E30, X : CMP.b #$05 : BNE .BRANCH_BETA
        STZ.w $0E30, X
        
        LDA.b #$26 : JSL.l Sound_SetSfx3PanLong
        
        JSR.w .spawn_2
        
        ; $0F56A1 ALTERNATE ENTRY POINT
        .spawn_2
        
        JSL.l Sprite_SpawnLightning
        JSL.l Sprite_SpawnLightning
        
        RTS
    
    .BRANCH_BETA
    
    LDA.b #$7B
    
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.b #$29 : JSL.l Sound_SetSfx3PanLong
        
        PHX
        
        LDA.w $0DE0, X : TAX
        
        LDA.b $00 : CLC : ADC .x_offsets_low,  X : STA.w $0D10, Y
        LDA.b $01 :       ADC .x_offsets_high, X : STA.w $0D30, Y
        
        LDA.b $02 : CLC : ADC .y_offsets_low, X : STA.w $0D00, Y
        LDA.b $03 :       ADC.b #$FF            : STA.w $0D20, Y
                                                  STA.w $0BA0, Y
        
        PLX
        
        LDA.w $0D50, X : STA.w $0D50, Y
        LDA.w $0D40, X : STA.w $0D40, Y
        
        LDA.w $0E30, X : CMP.b #$02 : BCC .BRANCH_GAMMA
            JSL.l GetRandomInt : AND.b #$01 : BNE .BRANCH_GAMMA
                LDA.b #$01 : STA.w $0DA0, Y
                LDA.b #$20 : STA.w $0DF0, Y
        
        .BRANCH_GAMMA
    .spawn_failed
    
    RTS
}

; $0F5708-$0F577E JUMP LOCATION
ShadowSneak:
{
    LDA.b #$01 : STA.w $0BA0, X
    
    LDA.w $0D10, X : STA.b $00
    LDA.w $0D30, X : STA.b $01
                     STA.b $05
    
    LDA.w $0D00, X : STA.b $02
    LDA.w $0D20, X : STA.b $03
                     STA.b $07
    
    LDA.w $0DB0, X : STA.b $04
    LDA.w $0E90, X : STA.b $06
    
    REP #$20
    
    LDA.b $00 : SEC : SBC.b $04 : CLC : ADC.w #$0007 : CMP.w #$000E : BCS .BRANCH_ALPHA
        LDA.b $02 : SEC : SBC.b $06 : CLC : ADC.w #$0007 : CMP.w #$000E : BCS .BRANCH_ALPHA
            SEP #$20
        
            LDA.w $0DB0, X : STA.w $0D10, X
            LDA.w $0E90, X : STA.w $0D00, X
        
            JMP.w Agahnim_PrepareToEmerge
    
    .BRANCH_ALPHA
    
    SEP #$20
    
    LDA.w $0ED0, X
    
    JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    
    LDA.b $01 : STA.w $0D50, X
    
    LDA.w $0ED0, X : CMP.b #$40 : BCS .BRANCH_BETA
        INC.w $0ED0, X
    
    .BRANCH_BETA
    
    JSR.w Sprite3_Move
    
    RTS
}

; ==============================================================================

; $0F577F-$0f5976 DATA
Pool_AgahDraw:
{
    ; $0F577F
    .offset_x
    db  -8,   8,  -8,   8
    db  -8,   8,  -8,   8
    db  -8,   8,  -8,   8
    db  -8,   8,  -8,   8
    db  -8,   8,  -8,   8
    db  -8,   8,  -8,   8
    db  -8,   8,  -8,   8
    db  -8,   8,  -8,   8
    db  -8,   8,  -8,   8
    db  -8,   8,  -8,   8
    db  -8,   8,  -8,   8
    db  -8,   8,  -8,   8
    db  -8,   8,  -8,   8
    db  -6,   6,  -6,   6
    db  -8,   8,  -8,   8
    db  -6,   6,  -6,   6
    db   0,   8,   0,   8
    db  -8,   8,  -8,   8

    ; $0F57C7
    .offset_y
    db  -8,  -8,   8,   8
    db  -8,  -8,   8,   8
    db  -8,  -8,   8,   8
    db  -8,  -8,   8,   8
    db  -8,  -8,   8,   8
    db  -8,  -8,   8,   8
    db  -8,  -8,   8,   8
    db  -8,  -8,   8,   8
    db  -8,  -8,   8,   8
    db  -8,  -8,   8,   8
    db  -8,  -8,   8,   8
    db  -8,  -8,   8,   8
    db  -8,  -8,   8,   8
    db  -6,  -6,   6,   6
    db  -8,  -8,   8,   8
    db  -6,  -6,   6,   6
    db   0,   0,   8,   8
    db   8,   8,   8,   8

    ; $0F580F
    .char
    db $82, $82, $A2, $A2
    db $80, $80, $A0, $A0
    db $84, $84, $A4, $A4
    db $86, $86, $A6, $A6
    db $88, $8A, $A8, $AA
    db $8C, $8E, $AC, $AE
    db $C4, $C2, $E4, $E6
    db $C0, $C2, $E0, $E2
    db $8A, $88, $AA, $A8
    db $8E, $8C, $AE, $AC
    db $C2, $C4, $E6, $E4
    db $C2, $C0, $E2, $E0
    db $EC, $EC, $EC, $EC
    db $EC, $EC, $EC, $EC
    db $EE, $EE, $EE, $EE
    db $EE, $EE, $EE, $EE
    db $DF, $DF, $DF, $DF
    db $40, $42, $40, $42

    ; $0F5857
    .flip
    db $00, $40, $00, $40
    db $00, $40, $00, $40
    db $00, $40, $00, $40
    db $00, $40, $00, $40
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $40, $40, $40, $40
    db $40, $40, $40, $40
    db $40, $40, $40, $40
    db $40, $40, $40, $40
    db $00, $40, $80, $C0
    db $00, $40, $80, $C0
    db $00, $40, $80, $C0
    db $00, $40, $80, $C0
    db $00, $40, $80, $C0
    db $00, $00, $00, $00

    ; $0F589F
    .ball_offset_x
    db  -7,  15, -11,  11
    db -11,  11,  -8,   8
    db  -4,   4,   0,   0
    db -10,  -1, -14,  -5
    db -14,  -5, -12,  -7
    db -10,  -7, -10, -10
    db  16,   8,  12,   4
    db  12,   4,  10,   6
    db   9,   7,   8,   8

    db  -6,  -6, -10, -10
    db -10, -10, -10, -10
    db -10, -10, -10, -10
    db  14,  14,  10,  10
    db  10,  10,  10,  10
    db  10,  10,  10,  10
    db  -7,  15, -11,  11
    db -11,  11,  -8,   8
    db  -4,   4,   0,   0

    ; $0F58E7
    .ball_offset_y
    db  -5,  -5,  -9,  -9
    db  -9,  -9,  -9,  -9
    db  -9,  -9,  -9,  -9
    db  -3,   9,  -7,   5
    db  -7,   5,  -5,   3
    db  -3,   3,  -2,  -2
    db  -3,   9,  -7,   5
    db  -7,   5,  -5,   3
    db  -3,   3,  -2,  -2

    db  -3,   9,  -7,   5
    db  -7,   5,  -5,   3
    db  -3,   3,  -2,  -2
    db  -3,   9,  -7,   5
    db  -7,   5,  -5,   3
    db  -3,   3,  -2,  -2
    db  -5,  -5,  -9,  -9
    db  -9,  -9,  -9,  -9
    db  -9,  -9,  -9,  -9

    ; $0F592F
    .ball_char
    db $CE, $CC, $C6, $C6
    db $C6, $C6, $CE, $CC
    db $C6, $C6, $C6, $C6
    db $CE, $CC, $C6, $C6
    db $C6, $C6, $CE, $CC
    db $C6, $C6, $C6, $C6
    db $CE, $CC, $C6, $C6
    db $C6, $C6, $CE, $CC
    db $C6, $C6, $C6, $C6

    ; $0F5953
    .ball_palette
    db $00, $02, $02, $02
    db $02, $02, $00, $02
    db $02, $02, $02, $02
    db $00, $02, $02, $02
    db $02, $02, $00, $02
    db $02, $02, $02, $02
    db $00, $02, $02, $02
    db $02, $02, $00, $02
    db $02, $02, $02, $02
}

; $0F5977-$0F5977 LOCAL JUMP LOCATION
UNREACHABLE_1ED977:
{
    RTS
}

; $0F5978-$0F5A41 LOCAL JUMP LOCATION
AgahDraw:
{
    JSR.w Sprite3_PrepOamCoord
    
    LDA.w $0DC0, X : ASL #2 : STA.b $06
    
    PHX
    
    LDX.b #$03
    
    .BRANCH_BETA
    
        PHX
        
        TXA : CLC : ADC.b $06 : TAX
        
        LDA.b $00 : CLC : ADC.w Pool_AgahDraw_offset_x, X       : STA ($90), Y
        LDA.b $02 : CLC : ADC.w Pool_AgahDraw_offset_y, X : INY : STA ($90), Y
        LDA.w Pool_AgahDraw_char, X                       : INY : STA ($90), Y
        LDA.w Pool_AgahDraw_flip, X : ORA.b $05           : INY : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b #$02
        
        CPX.b #$44 : BCS .BRANCH_ALPHA
            CPX.b #$40 : BCC .BRANCH_ALPHA
                LDA.b #$00
        
        .BRANCH_ALPHA
        
        STA ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .BRANCH_BETA
    
    PLX
    
    LDA.w $0DC0, X : CMP.b #$0C : BCS .BRANCH_GAMMA
        LDA.b #$12
        
        JSL.l Sprite_DrawShadowLong_variable
        
    .BRANCH_GAMMA
    
    LDA.b $11 : BEQ .BRANCH_DELTA
        LDY.b #$FF
        LDA.b #$03
        
        JSL.l Sprite_CorrectOamEntriesLong
    
    .BRANCH_DELTA
    
    JSR.w Sprite3_PrepOamCoord
    
    LDA.b #$08
    
    LDY.w $0DE0, X : BEQ .BRANCH_EPSILON
        JSL.l OAM_AllocateFromRegionC
        
        BRA .BRANCH_ZETA
    
    .BRANCH_EPSILON
    
    JSL.l OAM_AllocateFromRegionB
    
    .BRANCH_ZETA
    
    LDY.b #$00
    
    LDA.w $0EB0, X : BEQ .BRANCH_THETA
        DEC : STA.b $0C
        
        ASL : STA.b $06
        
        LDA.b $1A : LSR : AND.b #$02 : INC #2 : ORA.b #$31 : STA.b $0D
        
        PHX
        
        LDX.b #$01
        
        .BRANCH_IOTA
        
            PHX
            
            TXA : CLC : ADC.b $06 : TAX
            
            LDA.b $00 : CLC : ADC.w Pool_AgahDraw_ball_offset_x, X       : STA ($90), Y
            LDA.b $02 : CLC : ADC.w Pool_AgahDraw_ball_offset_y, X : INY : STA ($90), Y
            
            LDX.b $0C
            
            LDA.w Pool_AgahDraw_ball_char, X : INY : STA ($90), Y
            
            INY
            
            LDA.b $0D : STA ($90), Y
            
            PHY : TYA : LSR #2 : TAY
            
            LDA.w Pool_AgahDraw_ball_palette, X : STA ($92), Y
            
            PLY : INY
        PLX : DEX : BPL .BRANCH_IOTA
        
        PLX
    
    .BRANCH_THETA
    
    RTS
}

; ==============================================================================
