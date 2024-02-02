
; ==============================================================================

; $02A377-$02A379 DATA
pool Lanmola_FinishInitialization:
{
    ; Seems hard coded for 3 Lanmolas... here at least.
    .starting_delay
    db $80, $CF, $FF
}

; ==============================================================================

; $02A37A-$02A39F LONG
Lanmola_FinishInitialization:
{
    LDA.l .starting_delay, X : STA $0DF0, X
    
    LDA.b #$FF : STA $0F70, X
    
    PHX
    
    LDY.b #$3F
    
    LDA .sprite_regions, X : TAX
    
    LDA.b #$FF
    
    .reset_extended_sprites
    
    STA $7FFE00, X
    
    INX
    
    DEY : BPL .reset_extended_sprites
    
    PLX
    
    LDA.b #$07 : STA $7FF81E, X
    
    RTL
}

; ==============================================================================

; $02A3A0-$02A3A1 DATA (UNUSED)
pool Sprite_Lanmola:
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
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    ; \task Name these ai states.
    dw Lanmola_Wait   ; 0x00 ; = $2A3BF*
    dw Lanmola_Mound: ; 0x01 ; = $2A3E6*
    dw Lanmola_Fly    ; 0x02 ; = $2A431*
    dw Lanmola_Dive   ; 0x03 ; = $2A4CB*
    dw Lanmola_Reset  ; 0x04 ; = $2A4F2*
    dw Lanmola_Death  ; 0x05 ; = $2A529*
}

; ==============================================================================

; $02A3BF-$02A3D5 JUMP LOCATION
    Lanmola_Wait: ; 0x00
{
    LDA $0DF0, X : ORA $0F00, X : BNE .delay
    
    LDA.b #$7F : STA $0DF0, X
    
    INC $0D80, X
    
    ; Play rumbling sound
    LDA.b #$35 : JSL Sound_SetSfx2PanLong
    
    .delay
    
    RTS
}

; ==============================================================================

; $02A3D6-$02A3E5 DATA
    pool Lanmola_Mound
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
    LDA $0DF0, X : BNE .alpha
    
    JSL Lanmola_SpawnShrapnel
    
    LDA.b #$13 : STA $012D
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA .randXPos, Y : STA $0DA0, X ; $A3D6
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA .randYPos, Y : STA $0DB0, X ; $A3DE
    
    INC $0D80, X
    
    LDA.b #$18 : STA $0F80, X
    
    STZ $0EC0, X
    STZ $0ED0, X
    
    ; $02A41C ALTERNATE ENTRY POINT
    shared Lanmola_SetScatterSandPosition:
    
    LDA $0D10, X : STA $0DE0, X
    LDA $0D00, X : STA $0E70, X
    
    LDA.b #$4A : STA $0E00, X
    
    RTS
    
    .alpha
    
    RTS
}

; ==============================================================================

; $02A42F-$02A430 DATA
pool Lanmola_Fly:
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
    LDA $0EC0, X : BNE .alpha
    
    LDA $0F80, X : SEC : SBC.b #$01 : STA $0F80, X : BNE .beta
    
    INC $0EC0, X
    
    .beta
    
    BRA .dontSwitchDirections
    
    .alpha
    
    ; Use the Y speed to bob up and down
    LDA $1A : AND.b #$01 : BNE .dontSwitchDirections ; Every other frame.
    
    LDA $0ED0, X : AND.b #$01 : TAY
    
    LDA $0F80, X : CLC : ADC .y_speed_slope, Y : STA $0F80, X : CMP $95FC, Y : BNE .dontSwitchDirections
    
    INC $0ED0, X ; Switch direction
    
    .dontSwitchDirections
    
    LDA $0DA0, X : STA $04
    LDA $0D30, X : STA $05
    LDA $0DB0, X : STA $06
    LDA $0D20, X : STA $07
    LDA $0D10, X : STA $00
    LDA $0D30, X : STA $01
    LDA $0D00, X : STA $02
    LDA $0D20, X : STA $03
    
    REP #$20
    
    ; If our position is 0x0002 away from the random X and Y pos we chose earlier go to the next stage.
    LDA $00 : SEC : SBC $04 : CLC : ADC.w #$0002 : CMP.w #$0004            : BCS .notCloseEnough
    LDA $02 : SEC : SBC $06 : CLC : ADC.w #$0002 : CMP.w #$0004 : SEP #$20 : BCS .notCloseEnough
    
    INC $0D80, X
    
    .notCloseEnough
    
    SEP #$20
    
    LDA.b #$0A
    
    JSL Sprite_ProjectSpeedTowardsEntityLong
    
    LDA $00 : STA $0D40, X
    LDA $01 : STA $0D50, X
    
    JSR Sprite2_Move
    
    RTS
}

; $02A4CB-$02A4F1 JUMP LOCATION
    Lanmola_Dive: ; 0x03
{
    JSR Sprite2_CheckDamage
    JSR Sprite2_Move
    JSR Sprite2_MoveAltitude
    
    LDA $0F80, X : CMP.b #$EC : BMI .alpha
    
    SEC : SBC.b #$01 : STA $0F80, X
    
    .alpha
    
    LDA $0F70, X : BPL .notUnderGroundYet
    
    INC $0D80, X
    
    LDA.b #$80 : STA $0DF0, X
    
    JSR Lanmola_SetScatterSandPosition
    
    .notUnderGroundYet
    
    RTS
}

; ==============================================================================

; $02A4F2-$02A514 JUMP LOCATION
    Lanmola_Reset: ; 0x04
{
    LDA $0DF0, X : BNE .wait
    
    STZ $0D80, X
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA Lanmola_Mound_randXPos, Y : STA $0D10, X ; $A3D6
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA Lanmola_Mound_randYPos, Y : STA $0D00, X ; $A3DE
    
    .wait
    
    parallel pool Lanmola_Death:
    
    .easy_out
    
    RTS
}

; ==============================================================================

; $02A515-$02A51C DATA
{
    ; \task Name this routine / pool.
    db 0,  8, 16, 24, 32, 40, 48, 56
}

; ==============================================================================

; $02A51D-$02A528 LONG
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
    LDY $0DF0, X : BNE .alpha
    
    STZ $0DD0, X
    
    JSL Sprite_VerifyAllOnScreenDefeated : BCC .alpha
    
    ; Lanmolas are dead, spawn heart container
    LDA.b #$EA : JSL Sprite_SpawnDynamically
    
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$20 : STA $0F80, Y
    LDA.b #$03 : STA $0D90, Y
    
    .alpha
    
    LDA $0DF0, X : CMP.b #$20 : BCC .easy_out
                   CMP.b #$A0 : BCS .easy_out
                   AND.b #$0F : BNE .easy_out
    
    LDA $7FF81E, X : TAY
    
    LDA $0E80, X : SEC : SBC $A515, Y : AND.b #$3F : CLC : ADC .sprite_regions, X : PHX : TAX ; $A5DA
    
    LDA $7FFC00, X : SEC : SBC $E2                  : STA $0A
    LDA $7FFD00, X : SEC : SBC $7FFE00, X : SEC : SBC $E8 : STA $0B
    
    PLX
    
    ; Spawn a sprite that instantly dies as a boss explosion?
    LDA.b #$00 : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA.b #$0B : STA $0AAA
    
    LDA.b #$04 : STA $0DD0, Y
    
    LDA.b #$1F : STA $0DF0, Y : STA $0D90, Y
    
    LDA $0A : CLC : ADC $E2    : STA $0D10, Y
    LDA $E3 : ADC.b #$00 : STA $0D30, Y
    LDA $0B : CLC : ADC $E8    : STA $0D00, Y
    LDA $E9 : ADC.b #$00 : STA $0D20, Y
    
    LDA.b #$03 : STA $0E40, Y
    
    LDA.b #$0C : STA $0F50, Y
    
    LDA.b #$0C : JSL Sound_SetSfx2PanLong
    
    LDA $7FF81E, X : BMI .beta
    
    DEC A : STA $7FF81E, X
    
    .spawn_failed
    .beta
    
    RTS
}

; ==============================================================================

; $02A5DA-$02A649 DATA
    shared pool Lanmola_FinishInitialization:
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
pool Lanmola_Draw:
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
    
    LDA .oamCoord90, Y : STA $90 ; $A63A
    LDA .oamCoord92, Y : STA $92 ; $A642
    
    SEP #$20
    
    LDA $0D40, X : SEC : SBC $0F80, X : STA $00
    LDA $0D50, X                : STA $01
    
    JSL Sprite_ConvertVelocityToAngle : STA $0DC0, X
    
    LDA Lanmola_FinishInitialization_sprite_regions, X : STA $04 ; $A5DA
    
    PHX
    
    LDA $0D10, X : PHA
    LDA $0D00, X : PHA
    LDA $0F70, X : PHA
    LDA $0DC0, X : PHA
    
    LDA $0E80, X : STA $02 : STA $05
    
    CLC : ADC $04 : TAX
    
    PLA : STA $7FFF00, X
    PLA : STA $7FFE00, X
    PLA : STA $7FFD00, X
    PLA : STA $7FFC00, X
    
    PLX
    
    LDA $0DD0, X : CMP.b #$09 : BNE .notActive
    
    LDA $11 : ORA $0FC1 : BNE .notActive
    
    LDA $0E80, X : INC A : AND.b #$3F : STA $0E80, X
    
    .notActive
    
    LDA $0F50, X : ORA $0B89, X : STA $03
    
    LDA $7FF81E, X : BPL .beta
    
    RTS
    
    .beta
    
    PHX
    
    PHA : STA $0E
    
    LDA $0D40, X : ASL A : ROL A : AND.b #$01 : TAX
    
    LDA .data2, X : STA $0C ; $A5E0
    
    LDY .data1, X ; $A5DE
    
    PLX
    
    STX $0B
    
    .theta
    
    PHX : STX $0D
    
    LDA $02 : CLC : ADC $04 : TAX
    
    LDA $02 : SEC : SBC.b #$08 : AND.b #$3F : STA $02
    
    LDA $7FFC00, X : SEC : SBC $E2 : STA ($90), Y : INY
    
    LDA $7FFE00, X : BMI .gamma
    
    LDA $7FFD00, X : SEC : SBC $7FFE00, X : SEC : SBC $E8 : STA ($90), Y
    
    .gamma
    
    PHY
    
    LDA $7FFF00, X : TAX
    
    LDY $0D
    
    LDA $0B : CMP.b #$07 : BNE .delta
    
    CPY.b #$00 : BEQ .epsilon
    
    .delta
    
    LDA.b #$C6
    
    CPY $0B : BNE .zeta
    
    LDA .chr1, X ; $A5E2
    
    BRA .zeta
    
    .epsilon
    
    LDA .chr2, X ; $A5F2
    
    .zeta
    
    PLY                          : INY : STA ($90), Y
    LDA .properties, X : ORA $03 : INY : STA ($90), Y ; $A602
    
    TYA : PHY : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLA : CLC : ADC $0C : TAY
    
    PLX : DEX : BPL .theta
    
    LDX $0E
    
    LDY.b #$20
    
    .kappa
    
    PHX
    
    LDA $05 : CLC : ADC $04 : TAX
    
    LDA $05 : SEC : SBC.b #$08 : AND.b #$3F : STA $05
    
    LDA $7FFC00, X : SEC : SBC $E2 : STA ($90), Y
    
    INY
    
    LDA $7FFE00, X : BMI .iota
    
    LDA $7FFD00, X : CLC : ADC.b #$0A : SEC : SBC $E8 : STA ($90), Y
    
    .iota
    
    LDA.b #$6C : INY : STA ($90), Y
    LDA.b #$34 : INY : STA ($90), Y
    
    TYA : PHY : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .kappa
    
    PLX
    
    LDA $0D80, X : CMP.b #$01 : BNE .lambda
    
    JMP Lanmola_DrawMound
    
    .lambda
    
    CMP.b #$05 : BEQ .mu
    
    LDA $0E00, X : BEQ .mu
    
    PHA
    
    LDA $0D40, X : ASL A : ROL A : ASL A : EOR $0D80, X : AND.b #$02 : BEQ .nu
    
    LDA.b #$08 : JSL OAM_AllocateFromRegionB
    
    BRA .xi
    
    .nu
    
    LDA.b #$08 : JSL OAM_AllocateFromRegionC
    
    .xi
    
    LDY.b #$00
    
    PLA : LSR #2 : AND.b #$03 : EOR.b #$03 : ASL A : STA $06
    
    LDA $0DE0, X : SEC : SBC $E2 : STA $00
    LDA $0E70, X : SEC : SBC $E8 : STA $02
    
    PHX
    
    LDX.b #$01
    
    .omicron
    
    PHX
    
    TXA : CLC : ADC $06 : TAX
    
    LDA $00 : CLC : ADC .xDirt, X                    : STA ($90), Y ; $A612
    LDA $02 : CLC : ADC .yDirt, X              : INY : STA ($90), Y ; $A61A
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
    
    LDA $0D10, X : SEC : SBC $E2 : STA $00
    LDA $0D00, X : SEC : SBC $E8 : STA $02
    
    LDA $0DF0, X : LSR #3 : TAY
    
    PHX
    
    LDX .frame, Y ; $A870
    
    LDY.b #$00
    
    LDA $00                          : STA ($90), Y
    LDA $02                    : INY : STA ($90), Y
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
