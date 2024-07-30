
; ==============================================================================

; $02A377-$02A379 DATA
Pool_Lanmola_FinishInitialization:
{
    ; Seems hard coded for 3 Lanmolas... here at least.
    .starting_delay
    db $80, $CF, $FF
}

; ==============================================================================

; $02A37A-$02A39F LONG JUMP LOCATION
Lanmola_FinishInitialization:
{
    LDA.l .starting_delay, X : STA.w $0DF0, X
    
    LDA.b #$FF : STA.w $0F70, X
    
    PHX
    
    LDY.b #$3F
    
    LDA .sprite_regions, X : TAX
    
    LDA.b #$FF
    
    .reset_extended_sprites
    
    STA.l $7FFE00, X
    
    INX
    
    DEY : BPL .reset_extended_sprites
    
    PLX
    
    LDA.b #$07 : STA.l $7FF81E, X
    
    RTL
}

; ==============================================================================

; $02A3A0-$02A3A1 DATA (UNUSED)
Pool_Sprite_Lanmola:
{
    .unused
    db 24, -24
}

; ==============================================================================

; $02A3A2-$02A3BE JUMP LOCATION
Sprite_Lanmola:
{
    JSL Sprite_PrepOamCoordLong
    JSR Lanmola_Draw
    JSR Sprite2_CheckIfActive.permissive
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    ; TODO: Name these ai states.
    dw Lanmola_Wait   ; 0x00 ; = $2A3BF*
    dw Lanmola_Mound: ; 0x01 ; = $2A3E6*
    dw Lanmola_Fly    ; 0x02 ; = $2A431*
    dw Lanmola_Dive   ; 0x03 ; = $2A4CB*
    dw Lanmola_Reset  ; 0x04 ; = $2A4F2*
    dw Lanmola_Death  ; 0x05 ; = $2A529*
}

; ==============================================================================

; $02A3BF-$02A3D5 JUMP LOCATIONLanmola_Wait: ; 0x00
{
    LDA.w $0DF0, X : ORA.w $0F00, X : BNE .delay
    
    LDA.b #$7F : STA.w $0DF0, X
    
    INC.w $0D80, X
    
    ; Play rumbling sound
    LDA.b #$35 : JSL Sound_SetSfx2PanLong
    
    .delay
    
    RTS
}

; ==============================================================================

; $02A3D6-$02A3E5 DATA
Pool_Lanmola_Mound
{
    .randXPos
    db $58, $50, $60, $70, $80, $90, $A0, $98
    
    ; $2A3DE
    .randYPos
    db $68, $60, $70, $80, $90, $A0, $A8, $B0
}

; ==============================================================================

; $02A3E6-$02A42E JUMP LOCATION
Lanmola_Mound: ; 0x01
{
    LDA.w $0DF0, X : BNE .alpha
    
    JSL Lanmola_SpawnShrapnel
    
    LDA.b #$13 : STA.w $012D
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA .randXPos, Y : STA.w $0DA0, X ; $A3D6
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA .randYPos, Y : STA.w $0DB0, X ; $A3DE
    
    INC.w $0D80, X
    
    LDA.b #$18 : STA.w $0F80, X
    
    STZ.w $0EC0, X
    STZ.w $0ED0, X
    
    ; $02A41C ALTERNATE ENTRY POINT
    shared Lanmola_SetScatterSandPosition:
    
    LDA.w $0D10, X : STA.w $0DE0, X
    LDA.w $0D00, X : STA.w $0E70, X
    
    LDA.b #$4A : STA.w $0E00, X
    
    RTS
    
    .alpha
    
    RTS
}

; ==============================================================================

; $02A42F-$02A430 DATA
Pool_Lanmola_Fly:
{
    .y_speed_slope
    db 2, -2
}

; ==============================================================================

; $02A431-$02A4CA JUMP LOCATION
Lanmola_Fly: ; 0x03
{
    JSR Sprite2_CheckDamage
    JSR Sprite2_MoveAltitude
    
    ; Slowly decrease the Y speed when first coming out of the ground
    LDA.w $0EC0, X : BNE .alpha
    
    LDA.w $0F80, X : SEC : SBC.b #$01 : STA.w $0F80, X : BNE .beta
    
    INC.w $0EC0, X
    
    .beta
    
    BRA .dontSwitchDirections
    
    .alpha
    
    ; Use the Y speed to bob up and down
    LDA.b $1A : AND.b #$01 : BNE .dontSwitchDirections ; Every other frame.
    
    LDA.w $0ED0, X : AND.b #$01 : TAY
    
    LDA.w $0F80, X : CLC : ADC .y_speed_slope, Y : STA.w $0F80, X : CMP.w $95FC, Y : BNE .dontSwitchDirections
    
    INC.w $0ED0, X ; Switch direction
    
    .dontSwitchDirections
    
    LDA.w $0DA0, X : STA.b $04
    LDA.w $0D30, X : STA.b $05
    LDA.w $0DB0, X : STA.b $06
    LDA.w $0D20, X : STA.b $07
    LDA.w $0D10, X : STA.b $00
    LDA.w $0D30, X : STA.b $01
    LDA.w $0D00, X : STA.b $02
    LDA.w $0D20, X : STA.b $03
    
    REP #$20
    
    ; If our position is 0x0002 away from the random X and Y pos we chose earlier go to the next stage.
    LDA.b $00 : SEC : SBC.b $04 : CLC : ADC.w #$0002 : CMP.w #$0004            : BCS .notCloseEnough
    LDA.b $02 : SEC : SBC.b $06 : CLC : ADC.w #$0002 : CMP.w #$0004 : SEP #$20 : BCS .notCloseEnough
    
    INC.w $0D80, X
    
    .notCloseEnough
    
    SEP #$20
    
    LDA.b #$0A
    
    JSL Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    LDA.b $01 : STA.w $0D50, X
    
    JSR Sprite2_Move
    
    RTS
}

; $02A4CB-$02A4F1 JUMP LOCATION
Lanmola_Dive: ; 0x03
{
    JSR Sprite2_CheckDamage
    JSR Sprite2_Move
    JSR Sprite2_MoveAltitude
    
    LDA.w $0F80, X : CMP.b #$EC : BMI .alpha
    
    SEC : SBC.b #$01 : STA.w $0F80, X
    
    .alpha
    
    LDA.w $0F70, X : BPL .notUnderGroundYet
    
    INC.w $0D80, X
    
    LDA.b #$80 : STA.w $0DF0, X
    
    JSR Lanmola_SetScatterSandPosition
    
    .notUnderGroundYet
    
    RTS
}

; ==============================================================================

; $02A4F2-$02A514 JUMP LOCATION
Lanmola_Reset: ; 0x04
{
    LDA.w $0DF0, X : BNE .wait
    
    STZ.w $0D80, X
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA Lanmola_Mound_randXPos, Y : STA.w $0D10, X ; $A3D6
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA Lanmola_Mound_randYPos, Y : STA.w $0D00, X ; $A3DE
    
    .wait
    
    parallel Pool_Lanmola_Death:
    
    .easy_out
    
    RTS
}

; ==============================================================================

; $02A515-$02A51C DATA
{
    ; TODO: Name this routine / pool.
    db 0,  8, 16, 24, 32, 40, 48, 56
}

; ==============================================================================

; $02A51D-$02A528 LONG JUMP LOCATION
Sprite_SpawnFallingItem:
{
    ; Triggers falling item special object apparently?
    
    PHX
    
    TAX
    
    LDY.b #$04 ; Try to load the effect into slot 4.
    LDA.b #$29 ; Trigger a falling item effect.
    
    JSL AddPendantOrCrystal
    
    PLX
    
    RTL
}

; ==============================================================================

; $02A529-$02A5D9 JUMP LOCATION
Lanmola_Death: ; 0x05
{
    LDY.w $0DF0, X : BNE .alpha
    
    STZ.w $0DD0, X
    
    JSL Sprite_VerifyAllOnScreenDefeated : BCC .alpha
    
    ; Lanmolas are dead, spawn heart container
    LDA.b #$EA : JSL Sprite_SpawnDynamically
    
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$20 : STA.w $0F80, Y
    LDA.b #$03 : STA.w $0D90, Y
    
    .alpha
    
    LDA.w $0DF0, X : CMP.b #$20 : BCC .easy_out
                   CMP.b #$A0 : BCS .easy_out
                   AND.b #$0F : BNE .easy_out
    
    LDA.l $7FF81E, X : TAY
    
    LDA.w $0E80, X : SEC : SBC.w $A515, Y : AND.b #$3F : CLC : ADC .sprite_regions, X : PHX : TAX ; $A5DA
    
    LDA.l $7FFC00, X : SEC : SBC.b $E2                  : STA.b $0A
    LDA.l $7FFD00, X : SEC : SBC.l $7FFE00, X : SEC : SBC.b $E8 : STA.b $0B
    
    PLX
    
    ; Spawn a sprite that instantly dies as a boss explosion?
    LDA.b #$00 : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA.b #$0B : STA.w $0AAA
    
    LDA.b #$04 : STA.w $0DD0, Y
    
    LDA.b #$1F : STA.w $0DF0, Y : STA.w $0D90, Y
    
    LDA.b $0A : CLC : ADC.b $E2    : STA.w $0D10, Y
    LDA.b $E3 : ADC.b #$00 : STA.w $0D30, Y
    LDA.b $0B : CLC : ADC.b $E8    : STA.w $0D00, Y
    LDA.b $E9 : ADC.b #$00 : STA.w $0D20, Y
    
    LDA.b #$03 : STA.w $0E40, Y
    
    LDA.b #$0C : STA.w $0F50, Y
    
    LDA.b #$0C : JSL Sound_SetSfx2PanLong
    
    LDA.l $7FF81E, X : BMI .beta
    
    DEC A : STA.l $7FF81E, X
    
    .spawn_failed
    .beta
    
    RTS
}

; ==============================================================================

; $02A5DA-$02A649 DATA
shared Pool_Lanmola_FinishInitialization:
{
    .sprite_regions
    db $00, $40, $80, $C0
    
    ; $2A5DE
    .data1
    db $00, $1C
    
    ; $2A5E0
    .data2
    db $01, $F9
}

; ==============================================================================

; $02A5E2-$02A649 DATA
Pool_Lanmola_Draw:
{
    ; $2A5E2
    .chr1
    db $C4, $E2, $C2, $E0, $C0, $E0, $C2, $E2, $C4, $E2, $C2, $E0, $C0, $E0, $C2, $E2

    ; $2A5F2
    .chr2
    db $CC, $E4, $CA, $E6, $C8, $E6, $CA, $E4, $CC, $E4, $CA, $E6, $C8, $E6, $CA, $E4 

    ; $2A602
    .properties
    db $C0, $C0, $C0, $C0, $80, $80, $80, $80, $00, $00, $00, $00, $40, $40, $40, $40

    ; $2A612
    .xDirt
    db $F8, $08, $F6, $0A, $F0, $10, $E8, $20
    
    ; $2A61A
    .yDirt
    db $00, $00, $FF, $FF, $FF, $FF, $03, $03
    
    ; $2A622
    .chrDirt
    db $E8, $E8, $E8, $E8, $EA, $EA, $EA, $EA
    
    ; $2A62A
    .propertiesDirt
    db $00, $40, $00, $40, $00, $40, $00, $40

    ; $2A632
    .sizesDirt
    db $02, $02, $02, $02, $02, $02, $00, $00
       
    ; $2A63A
    .oamCoord90
    db $30, $09, $F0, $08, $B0, $08, $70, $08

    ; $2A642
    .oamCoord92
    db $6C, $0A, $5C, $0A, $4C, $0A, $3C, $0A
}

 ; ==============================================================================   

; $02A64A-$02A87F LOCAL JUMP LOCATION
Lanmola_Draw:
{
    TXA : ASL A : TAY
    
    REP #$20
    
    LDA .oamCoord90, Y : STA.b $90 ; $A63A
    LDA .oamCoord92, Y : STA.b $92 ; $A642
    
    SEP #$20
    
    LDA.w $0D40, X : SEC : SBC.w $0F80, X : STA.b $00
    LDA.w $0D50, X                : STA.b $01
    
    JSL Sprite_ConvertVelocityToAngle : STA.w $0DC0, X
    
    LDA Lanmola_FinishInitialization_sprite_regions, X : STA.b $04 ; $A5DA
    
    PHX
    
    LDA.w $0D10, X : PHA
    LDA.w $0D00, X : PHA
    LDA.w $0F70, X : PHA
    LDA.w $0DC0, X : PHA
    
    LDA.w $0E80, X : STA.b $02 : STA.b $05
    
    CLC : ADC.b $04 : TAX
    
    PLA : STA.l $7FFF00, X
    PLA : STA.l $7FFE00, X
    PLA : STA.l $7FFD00, X
    PLA : STA.l $7FFC00, X
    
    PLX
    
    LDA.w $0DD0, X : CMP.b #$09 : BNE .notActive
    
    LDA.b $11 : ORA.w $0FC1 : BNE .notActive
    
    LDA.w $0E80, X : INC A : AND.b #$3F : STA.w $0E80, X
    
    .notActive
    
    LDA.w $0F50, X : ORA.w $0B89, X : STA.b $03
    
    LDA.l $7FF81E, X : BPL .beta
    
    RTS
    
    .beta
    
    PHX
    
    PHA : STA.b $0E
    
    LDA.w $0D40, X : ASL A : ROL A : AND.b #$01 : TAX
    
    LDA .data2, X : STA.b $0C ; $A5E0
    
    LDY .data1, X ; $A5DE
    
    PLX
    
    STX.b $0B
    
    .theta
    
    PHX : STX.b $0D
    
    LDA.b $02 : CLC : ADC.b $04 : TAX
    
    LDA.b $02 : SEC : SBC.b #$08 : AND.b #$3F : STA.b $02
    
    LDA.l $7FFC00, X : SEC : SBC.b $E2 : STA ($90), Y : INY
    
    LDA.l $7FFE00, X : BMI .gamma
    
    LDA.l $7FFD00, X : SEC : SBC.l $7FFE00, X : SEC : SBC.b $E8 : STA ($90), Y
    
    .gamma
    
    PHY
    
    LDA.l $7FFF00, X : TAX
    
    LDY.b $0D
    
    LDA.b $0B : CMP.b #$07 : BNE .delta
    
    CPY.b #$00 : BEQ .epsilon
    
    .delta
    
    LDA.b #$C6
    
    CPY.b $0B : BNE .zeta
    
    LDA .chr1, X ; $A5E2
    
    BRA .zeta
    
    .epsilon
    
    LDA .chr2, X ; $A5F2
    
    .zeta
    
    PLY                          : INY : STA ($90), Y
    LDA .properties, X : ORA.b $03 : INY : STA ($90), Y ; $A602
    
    TYA : PHY : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLA : CLC : ADC.b $0C : TAY
    
    PLX : DEX : BPL .theta
    
    LDX.b $0E
    
    LDY.b #$20
    
    .kappa
    
    PHX
    
    LDA.b $05 : CLC : ADC.b $04 : TAX
    
    LDA.b $05 : SEC : SBC.b #$08 : AND.b #$3F : STA.b $05
    
    LDA.l $7FFC00, X : SEC : SBC.b $E2 : STA ($90), Y
    
    INY
    
    LDA.l $7FFE00, X : BMI .iota
    
    LDA.l $7FFD00, X : CLC : ADC.b #$0A : SEC : SBC.b $E8 : STA ($90), Y
    
    .iota
    
    LDA.b #$6C : INY : STA ($90), Y
    LDA.b #$34 : INY : STA ($90), Y
    
    TYA : PHY : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .kappa
    
    PLX
    
    LDA.w $0D80, X : CMP.b #$01 : BNE .lambda
    
    JMP Lanmola_DrawMound
    
    .lambda
    
    CMP.b #$05 : BEQ .mu
    
    LDA.w $0E00, X : BEQ .mu
    
    PHA
    
    LDA.w $0D40, X : ASL A : ROL A : ASL A : EOR.w $0D80, X : AND.b #$02 : BEQ .nu
    
    LDA.b #$08 : JSL OAM_AllocateFromRegionB
    
    BRA .xi
    
    .nu
    
    LDA.b #$08 : JSL OAM_AllocateFromRegionC
    
    .xi
    
    LDY.b #$00
    
    PLA : LSR #2 : AND.b #$03 : EOR.b #$03 : ASL A : STA.b $06
    
    LDA.w $0DE0, X : SEC : SBC.b $E2 : STA.b $00
    LDA.w $0E70, X : SEC : SBC.b $E8 : STA.b $02
    
    PHX
    
    LDX.b #$01
    
    .omicron
    
    PHX
    
    TXA : CLC : ADC.b $06 : TAX
    
    LDA.b $00 : CLC : ADC .xDirt, X                    : STA ($90), Y ; $A612
    LDA.b $02 : CLC : ADC .yDirt, X              : INY : STA ($90), Y ; $A61A
    LDA .chrDirt, X                      : INY : STA ($90), Y ; $A622
    LDA .propertiesDirt,  X : ORA.b #$31 : INY : STA ($90), Y ; $A62A
    
    PHY
    
    TYA : LSR #2 : TAY
    
    LDA .sizesDirt, X : STA ($92), Y ; $A632
    
    PLY : INY
    
    PLX : DEX : BPL .omicron
    
    PLX
    
    .mu
    
    RTS
    
    ; $02A820 ALTERNATE ENTRY POINT
Lanmola_DrawMound:
    
    LDA.b #$04 : JSL OAM_AllocateFromRegionB
    
    LDA.w $0D10, X : SEC : SBC.b $E2 : STA.b $00
    LDA.w $0D00, X : SEC : SBC.b $E8 : STA.b $02
    
    LDA.w $0DF0, X : LSR #3 : TAY
    
    PHX
    
    LDX .frame, Y ; $A870
    
    LDY.b #$00
    
    LDA.b $00                          : STA ($90), Y
    LDA.b $02                    : INY : STA ($90), Y
    LDA .properties, X         : INY : STA ($90), Y ; $A864
    LDA .sizes, X : ORA.b #$31 : INY : STA ($90), Y ; $A86A
    
    TYA : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLX
    
    RTS
    
    ; $2A864
    .properties
    db $EE, $EE, $EC, $EC, $CE, $CE
    
    ; $2A86A
    .sizes
    db $00, $40, $00, $40, $00, $40
    
    ; $2A870
    .frame
    db $04, $05, $04, $05, $04, $05, $04, $05
    db $04, $03, $02, $01, $01, $01, $00, $00
}
