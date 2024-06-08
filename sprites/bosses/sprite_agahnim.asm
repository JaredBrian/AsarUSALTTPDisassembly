
; ==============================================================================

; $0F5310-$0F532F DATA
{
    ; \task Split up and name labels later.
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $05, $05, $00, $01, $01, $04
    db $04, $00, $02, $02, $04, $04, $03, $02
    db $02, $02, $0A, $08, $00, $04, $06, $FA    
    
}

; ==============================================================================

; $0F5330-$0F536E JUMP LOCATION
Sprite_Agahnim:
{
    JSR AgahDraw ; $D978 ; $0F5978 IN ROM
    
    LDA.w $0F00, X : BEQ .BRANCH_ALPHA
    LDA.b #$20 : STA.w $0DF0, X
    
    LDA.b #$00 : STA.w $0DC0, X
    
    LDA.b #$03 : STA.w $0DE0, X
    
    .BRANCH_ALPHA
    
    JSR Sprite3_CheckIfActive
    JSR Sprite3_CheckIfRecoiling
    
    LDA.b #$01 : STA.w $0BA0, X
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Agah1or2               ; 0x00 $D4EC = $F54EC*
    dw Agah1Inro              ; 0x01 $D4F6 = $F54F6*
    dw WaitToAttack           ; 0x02 $D524 = $F5524*
    dw AttachThenFadeToBlack  ; 0x03 $D566 = $F5566*
    dw SetTargetPos           ; 0x04 $D630 = $F5630*
    dw ShadowSneak            ; 0x05 $D708 = $F5708*
    dw $D45E ; 0x06 = $F545E*
    dw $D47C ; 0x07 = $F547C*
    dw $D3DA ; 0x08 = $F53DA*
    dw $D408 ; 0x09 = $F5408*
    dw $D376 ; 0x0A = $F5376*
}

; ==============================================================================

; $0F536F-$0F5375 DATA
{
    ; \task Name this routine / pool.
    .animation_states
    db 0, 8, 10, 2, 2, 6, 4
}

; ==============================================================================

; $0F5376-$0F53D9 JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA ; Is the timer still going?
    
    ; Time is done. Kill Agahnim.
    PHX
    
    STZ.w $0DD0, X
    
    JSL PrepDungeonExit
    
    PLX
    
    .BRANCH_ALPHA
    
    ; If Timer > #$10, branch
    LDA.w $0DF0, X : CMP.b #$10 : BCS .BRANCH_BETA
    
    LDA.b #$7F : STA $9A
    
    LDA.b #$06 : STA $1C
    LDA.b #$10 : STA $1D
    
    PHX
    
    JSL Palette_Filter_SP5F
    
    PLX
    
    .BRANCH_BETA
    
    LDA.w $0DF0, X : AND.b #$00 : BNE .BRANCH_GAMMA
    
    LDA.w $0F80, X : CMP.b #$FF : BEQ .BRANCH_GAMMA
    
    CLC : ADC.b #$01 : STA.w $0F80, X
    
    .BRANCH_GAMMA
    
    LDA.w $0F90, X : CLC : ADC.w $0F80, X : STA.w $0F90, X : BCC .BRANCH_DELTA
    
    INC.w $0E80, X : LDA.w $0E80, X : CMP.b #$07 : BNE .BRANCH_DELTA
    
    STZ.w $0E80, X
    
    LDA.b #$04 : JSL Sound_SetSfx2PanLong
    
    .BRANCH_DELTA
    
    LDY.w $0E80, X
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F53DA-$0F5407 JUMP LOCATION
{
    LDA.b #$02 : STA.w $0FFC
    
    STZ.w $0EB0, X
    
    LDA.w $0DF0, X : CMP.b #$40 : BCC .BRANCH_ALPHA
    
    LDA.w $0EF0, X : ORA.b #$E0 : STA.w $0EF0, X
    
    RTS
    
    .BRANCH_ALPHA
    
    CMP.b #$01 : BNE .BRANCH_BETA
    
    JSL Sprite_SpawnPhantomGanon
    
    LDA.b #$1D : STA.w $012C
    
    .BRANCH_BETA
    
    STZ.w $0EF0, X
    
    LDA.b #$11 : STA.w $0DC0, X
    
    RTS
}

; $0F5408-$0F545D JUMP LOCATION
{
    STZ.w $0EB0, X
    
    LDA.w $0D10 : STA $04
    LDA.w $0D30 : STA $05
    
    LDA.w $0D00 : STA $06
    LDA.w $0D20 : STA $07
    
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC $04 : CLC : ADC.w #$0004 : CMP.w #$0008 : BCS .BRANCH_ALPHA
    
    LDA.w $0FDA : SEC : SBC $06 : CLC : ADC.w #$0004 : CMP.w #$0008 : BCS .BRANCH_ALPHA
    
    SEP #$20
    
    STZ.w $0DD0, X
    
    .BRANCH_ALPHA
    
    SEP #$20
    
    LDA.b #$20
    
    JSL Sprite_ProjectSpeedTowardsEntityLong
    
    LDA $00 : STA.w $0D40, X
    
    LDA $01 : STA.w $0D50, X
    
    JSR Sprite3_Move
    JSL Sprite_SpawnAgahnimAfterImage
    
    RTS
}

; ==============================================================================

; $0F545E-$0F5479 JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .delay
    
    ; "I'm very happy to see you again... but you better believe we will"
    ; "will not have a third meeting! ..."
    LDA.b #$41 : STA.w $1CF0
    LDA.b #$01 : STA.w $1CF1
    
    JSL Sprite_ShowMessageMinimal
    
    INC.w $0D80, X
    
    LDA.b #$50 : STA.w $0DF0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F547A-$0F547B DATA
{
    .x_speeds
    db 32, -32
}

; ==============================================================================

; $0F547C-$0F54A6 JUMP LOCATION
{
    LDA.w $0EC0, X : BEQ .BRANCH_$F54A9
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    JMP.w $D509 ; $0F5509 IN ROM
    
    .BRANCH_ALPHA
    
    ; Each of the clones has its own x speed at the start... I guess
    ; that's what is going on here.
    LDA.w $D479, X : STA.w $0D50, X
    
    ; And speed up the y velocity.
    LDA.w $0D40, X : CLC : ADC.b #$02 : STA.w $0D40, X
    
    JSR Sprite3_Move
    
    JSL Sprite_SpawnAgahnimAfterImage : BMI .BRANCH_BETA
    
    LDA.b #$04 : STA.w $0F50, Y
    
    .BRANCH_BETA
    
    RTS
}

; ==============================================================================

; $0F54A7-$0F54A8 DATA
{
    ; \task Name this routine / pool.
    .special_properties
    db $09, $0B
}

; ==============================================================================

; $0F54A9-$0F54E9 BRANCH LOCATION
{
    LDA.w $0DF0, X : BNE .ai_transition_delay
    
    JMP.w $D509 ; $0F5509 IN ROM
    
    .ai_transition_delay
    
    CMP.b #$40 : BNE .cloning_delay
    
    LDA.b #$28 : STA.w $012F
    
    LDA.b #$01 : STA.w $0FB5
    
    .clone_spawn_loop
    
    LDA.b #$7A
    LDY.b #$02
    
    JSL Sprite_SpawnDynamically.arbitrary
    JSL Sprite_SetSpawnedCoords
    
    LDA .special_properties, Y : STA.w $0E60, Y
    
    AND.b #$0F : STA.w $0F50, Y : STA.w $0EC0, Y
    
    LDA.w $0D80, X : STA.w $0D80, Y
    
    LDA.b #$20 : STA.w $0DF0, Y
    
    DEC.w $0FB5 : BPL .clone_spawn_loop
    
    .cloning_delay
    
    RTS
}

; ==============================================================================

; $0F54EA-$0F54EB DATA
{
    .ai_states
    db 1, 6
}

; ==============================================================================

; $0F54EC-$0F54F5 JUMP LOCATION
Agah1or2:
{
    ; Check if we are in the LW or DW. If dark world go to agah 2 instead.
    LDY.w $0FFF
    
    LDA .ai_states, Y : STA.w $0D80, X
    
    RTS
}

; $0F54F6-$0F551E JUMP LOCATION
Agah1Inro:
{
    LDA.w $0DF0, X : BNE .dontShowIntroMessage ; (RTS)
    
    ; Oh, so?...  You mean to say you would like to be totally destroyed?  Well, I can make your wish come true!
    LDA.b #$3F : STA.w $1CF0
    LDA.b #$01 : STA.w $1CF1
    
    JSL Sprite_ShowMessageMinimal
    
    ; $0F5509 ALTERNATE ENTRY POINT
    
    LDA.b #$03 : STA.w $0D80, X
    
    LDA.b #$20 : STA.w $0DF0, X
    
    RTS

; $0F5514-$0F551E LOCAL JUMP LOCATION

    LDA.b #$02 : STA.w $0D80, X
    
    LDA.b #$27 : STA.w $0DF0, X
    
    .dontShowIntroMessage
    RTS
}

; ==============================================================================

; $0F551F-$0F5523 DATA
{
    ; \task Name this pool / routine.
    .animation_states
    db 12, 13, 14, 15, 16, 
}

; ==============================================================================

; $0F5524-$0F553F JUMP LOCATION
WaitToAttack:
{
    STZ.w $0FF8
    
    LDA.w $0DF0, X : BNE .delay
    INC.w $0D80, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    RTS
    
    .delay
    
    LSR #3 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F5540-$0F5565 DATA
{
    ; \task Name this pool / routine.
    ; $F5540
    db 0, 0, 0, 0, 0, 0, 0, 1
    db 1, 1, 1, 1, 1, 1, 0, 0
    
    ; $F5550
    db 0, 0, 0, 0, 0, 0, 0, 6
    db 5, 4, 3, 2, 1, 0, 0, 0
    
    ; $F5560
    db $1E, $18, $0C, $00, $06, $12
}

; ==============================================================================

; $0F5566-$0F560A JUMP LOCATION
AttachThenFadeToBlack:
{
    LDA.w $0DF0, X : CMP.b #$C0 : BNE .BRANCH_ALPHA
    PHA
    
    LDA.b #$27 : JSL Sound_SetSfx3PanLong
    
    PLA
    
    .BRANCH_ALPHA
    
    CMP.b #$EF : BCS .BRANCH_BETA
    CMP.b #$10 : BCS .BRANCH_GAMMA
    
    .BRANCH_BETA
    
    PHX
    
    LDA.b $0FFF : BNE .inDarkWorld
    ; apparently Agahnim is only in sprite slot 0x01 (of 0x10) in the 
    ; light world
    LDX.b #$02
    
    .inDarkWorld
    
    JSL PaletteFilter_Agahnim
    
    PLX
    
    BRA .BRANCH_EPSILON
    
    .BRANCH_GAMMA
    TXA : BNE .BRANCH_EPSILON
        JSR Sprite3_CheckDamage
    
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
        
    JSL Sprite_ApplySpeedTowardsPlayerLong
        
    LDY $01
        
    LDA $00 : CLC : ADC.b #$02 : STA $02
        
    ASL #2 : ADC $02 : ADC.b #$02 : CLC : ADC $01 : TAY
        
    LDA.w $D310, Y : STA.w $0DE0, X
        
    LDA.b #$20 : JSL Sprite_ApplySpeedTowardsPlayerLong
        
    LDA.w $0E30, X : CMP.b #$04 : BNE .BRANCH_IOTA
        LDA.b #$03 : STA.w $0DE0, X
    
    .BRANCH_IOTA
    
    PLA
    
    .BRANCH_THETA
    
    CMP.b #$70 : BNE .BRANCH_KAPPA
    PHA
    
    JSR DoLightningAttack ; $D67A = $F567A IN ROM
    
    PLA
    
    .BRANCH_KAPPA
    
    LSR #4 : TAY
    
    LDA.w $D540, Y : STA.w $0D90, X
    
    LDA.w $D550, Y : BEQ .BRANCH_LAMBDA
    CLC
    
    LDY.w $0DE0, X
    
    ADC.w $D560, Y
    
    .BRANCH_LAMBDA
    
    STA.w $0EB0, X
    
    LDY.w $0DE0, X
    
    LDA.w $D329, Y : CLC : ADC.w $0D90, X : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F560B-$0F562F DATA
{
    ; \task Name this routine / pool.
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

; ==============================================================================

; $0F5630-$0F5667 JUMP LOCATION
SetTargetPos:
{
    LDA.w $0DF0, X : STA.w $0BA0, X : BNE .delay 
    INC.w $0D80, X
        
    LDY.b #$04
        
    LDA.w $0E30, X : CMP.b #$04 : BEQ .BRANCH_BETA
        JSL GetRandomInt : AND.b #$0F : TAY
    
    .BRANCH_BETA
    
    LDA .targetXPos, Y : STA.w $0DB0, X
    LDA .targetYPos, Y : STA.w $0E90, X
        
    LDA.b #$08 : STA.w $0ED0, X
        
    RTS
    
    .delay
    
    LSR #3 : TAY
    
    LDA.w $D60B, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F5668-$0F5679 DATA
{
    ; \task Name this routine / pool.
    .x_offsets_low
    db  0, 10,  8,  0, -10, -10
    
    .x_offsets_high
    db  0,  0,  0,  0,  -1,  -1
    
    .y_offsets_low
    db -9, -2, -2, -9,  -2,  -2
}

; ==============================================================================

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
    
    LDA.b #$26 : JSL Sound_SetSfx3PanLong
    
    JSR.w $D6A1 ; $0F56A1 IN ROM
    
    ; $0F56A1 ALTERNATE ENTRY POINT
    
    JSL Sprite_SpawnLightning
    JSL Sprite_SpawnLightning
    
    RTS
    
    .BRANCH_BETA
    
    LDA.b #$7B
    
    JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA.b #$29 : JSL Sound_SetSfx3PanLong
    
    PHX
    
    LDA.w $0DE0, X : TAX
    
    LDA $00 : CLC : ADC .x_offsets_low,  X : STA.w $0D10, Y
    LDA $01 : ADC .x_offsets_high, X : STA.w $0D30, Y
    
    LDA $02 : CLC : ADC .y_offsets_low, X : STA.w $0D00, Y
    LDA $03 : ADC.b #$FF   : STA.w $0D20, Y
                             STA.w $0BA0, Y
    
    PLX
    
    LDA.w $0D50, X : STA.w $0D50, Y
    LDA.w $0D40, X : STA.w $0D40, Y
    
    LDA.w $0E30, X : CMP.b #$02 : BCC .BRANCH_GAMMA
    
    JSL GetRandomInt : AND.b #$01 : BNE .BRANCH_GAMMA
    
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
    
    LDA.w $0D10, X : STA $00
    LDA.w $0D30, X : STA $01
               STA $05
    
    LDA.w $0D00, X : STA $02
    LDA.w $0D20, X : STA $03
               STA $07
    
    LDA.w $0DB0, X : STA $04
    LDA.w $0E90, X : STA $06
    
    REP #$20
    
    LDA $00 : SEC : SBC $04 : CLC : ADC.w #$0007 : CMP.w #$000E : BCS .BRANCH_ALPHA
    LDA $02 : SEC : SBC $06 : CLC : ADC.w #$0007 : CMP.w #$000E : BCS .BRANCH_ALPHA
        SEP #$20
    
        LDA.w $0DB0, X : STA.w $0D10, X
        LDA.w $0E90, X : STA.w $0D00, X
    
        JMP.w $D514 ; $0F5514 IN ROM
    
    .BRANCH_ALPHA
    
    SEP #$20
    
    LDA.w $0ED0, X
    
    JSL Sprite_ProjectSpeedTowardsEntityLong
    
    LDA $00 : STA.w $0D40, X
    
    LDA $01 : STA.w $0D50, X
    
    LDA.w $0ED0, X : CMP.b #$40 : BCS .BRANCH_BETA
    INC.w $0ED0, X
    
    .BRANCH_BETA
    
    JSR Sprite3_Move
    
    RTS
}

; ==============================================================================

; $0F577F-$0f5977 DATA
{
    ; TODO: Doccument this.
    F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 F8 08 FA 06 FA 06 F8 08 F8 08 FA 06 FA 06 00 08 00 08 F8 08 F8 08 F8 F8 08 08 F8 F8 08 08 F8 F8 08 08 F8 F8 08 08 F8 F8 08 08 F8 F8 08 08 F8 F8 08 08 F8 F8 08 08 F8 F8 08 08 F8 F8 08 08 F8 F8 08 08 F8 F8 08 08 F8 F8 08 08 FA FA 06 06 F8 F8 08 08 FA FA 06 06 00 00 08 08 08 08 08 08 82 82 A2 A2 80 80 A0 A0 84 84 A4 A4 86 86 A6 A6 88 8A A8 AA 8C 8E AC AE C4 C2 E4 E6 C0 C2 E0 E2 8A 88 AA A8 8E 8C AE AC C2 C4 E6 E4 C2 C0 E2 E0 EC EC EC EC EC EC EC EC EE EE EE EE EE EE EE EE DF DF DF DF 40 42 40 42 00 40 00 40 00 40 00 40 00 40 00 40 00 40 00 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 00 40 80 C0 00 40 80 C0 00 40 80 C0 00 40 80 C0 00 40 80 C0 00 00 00 00 F9 0F F5 0B F5 0B F8 08 FC 04 00 00 F6 FF F2 FB F2 FB F4 F9 F6 F9 F6 F6 10 08 0C 04 0C 04 0A 06 09 07 08 08 FA FA F6 F6 F6 F6 F6 F6 F6 F6 F6 F6 0E 0E 0A 0A 0A 0A 0A 0A 0A 0A 0A 0A F9 0F F5 0B F5 0B F8 08 FC 04 00 00 FB FB F7 F7 F7 F7 F7 F7 F7 F7 F7 F7 FD 09 F9 05 F9 05 FB 03 FD 03 FE FE FD 09 F9 05 F9 05 FB 03 FD 03 FE FE FD 09 F9 05 F9 05 FB 03 FD 03 FE FE FD 09 F9 05 F9 05 FB 03 FD 03 FE FE FB FB F7 F7 F7 F7 F7 F7 F7 F7 F7 F7 CE CC C6 C6 C6 C6 CE CC C6 C6 C6 C6 CE CC C6 C6 C6 C6 CE CC C6 C6 C6 C6 CE CC C6 C6 C6 C6 CE CC C6 C6 C6 C6 00 02 02 02 02 02 00 02 02 02 02 02 00 02 02 02 02 02 00 02 02 02 02 02 00 02 02 02 02 02 00 02 02 02 02 02 60
}

; ==============================================================================

; $0F5978-$0F5A41 LOCAL JUMP LOCATION
AgahDraw:
{
    JSR Sprite3_PrepOamCoord
    
    LDA.w $0DC0, X : ASL #2 : STA $06
    
    PHX
    
    LDX.b #$03
    
    .BRANCH_BETA
    
    PHX
    
    TXA : CLC : ADC $06 : TAX
    
    LDA $00      : CLC : ADC.w $D77F, X       : STA ($90), Y
    LDA $02      : CLC : ADC.w $D7C7, X : INY : STA ($90), Y
    LDA.w $D80F, X                : INY : STA ($90), Y
    LDA.w $D857, X : ORA $05      : INY : STA ($90), Y
    
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
    
    JSL Sprite_DrawShadowLong.variable
    
    .BRANCH_GAMMA
    
    LDA $11 : BEQ .BRANCH_DELTA
    
    LDY.b #$FF
    LDA.b #$03
    
    JSL Sprite_CorrectOamEntriesLong
    
    .BRANCH_DELTA
    
    JSR Sprite3_PrepOamCoord
    
    LDA.b #$08
    
    LDY.w $0DE0, X : BEQ .BRANCH_EPSILON
    
    JSL OAM_AllocateFromRegionC
    
    BRA .BRANCH_ZETA
    
    .BRANCH_EPSILON
    
    JSL OAM_AllocateFromRegionB
    
    .BRANCH_ZETA
    
    LDY.b #$00
    
    LDA.w $0EB0, X : BEQ .BRANCH_THETA
    
    DEC A : STA $0C
    
    ASL A : STA $06
    
    LDA $1A : LSR A : AND.b #$02 : INC #2 : ORA.b #$31 : STA $0D
    
    PHX
    
    LDX.b #$01
    
    .BRANCH_IOTA
    
    PHX
    
    TXA : CLC : ADC $06 : TAX
    
    LDA $00 : CLC : ADC.w $D89F, X       : STA ($90), Y
    LDA $02 : CLC : ADC.w $D8E7, X : INY : STA ($90), Y
    
    LDX $0C
    
    LDA.w $D92F, X : INY : STA ($90), Y
    
    INY
    
    LDA $0D : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.w $D953, X : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .BRANCH_IOTA
    
    PLX
    
    .BRANCH_THETA
    
    RTS
}

; ==============================================================================
