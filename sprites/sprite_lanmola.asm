; ==============================================================================

; $02A377-$02A379 DATA
Lanmola_FinishInitialization_starting_delay:
{
    ; HARDCODED: Seems hard coded for 3 Lanmolas... here at least.
    db $80, $CF, $FF
}

; $02A37A-$02A39F LONG JUMP LOCATION
Lanmola_FinishInitialization:
{
    LDA.l .starting_delay, X : STA.w $0DF0, X
    
    LDA.b #$FF : STA.w $0F70, X
    
    PHX
    
    LDY.b #$3F
    
    LDA Pool_Lanmola_FinishInitialization_sprite_regions, X : TAX
    
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

; UNUSED:
; $02A3A0-$02A3A1 DATA
Pool_Sprite_Lanmola_unused:
{
    db 24, -24
}

; ==============================================================================

; $02A3A2-$02A3BE JUMP LOCATION
Sprite_Lanmola:
{
    JSL.l Sprite_PrepOamCoordLong
    JSR.w Lanmola_Draw
    JSR.w Sprite2_CheckIfActive_permissive
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Lanmola_Wait   ; 0x00 - $A3BF
    dw Lanmola_Mound: ; 0x01 - $A3E6
    dw Lanmola_Fly    ; 0x02 - $A431
    dw Lanmola_Dive   ; 0x03 - $A4CB
    dw Lanmola_Reset  ; 0x04 - $A4F2
    dw Lanmola_Death  ; 0x05 - $A529
}

; ==============================================================================

; 0x00
; $02A3BF-$02A3D5 JUMP LOCATION
Lanmola_Wait:
{
    LDA.w $0DF0, X : ORA.w $0F00, X : BNE .delay
        LDA.b #$7F : STA.w $0DF0, X
        
        INC.w $0D80, X
        
        ; Play rumbling sound.
        LDA.b #$35 : JSL.l Sound_SetSfx2PanLong
    
    .delay
    
    RTS
}

; ==============================================================================

; $02A3D6-$02A3E5 DATA
Pool_Lanmola_Mound:
{
    ; $02A3D6
    .randXPos
    db $58, $50, $60, $70, $80, $90, $A0, $98
    
    ; $02A3DE
    .randYPos
    db $68, $60, $70, $80, $90, $A0, $A8, $B0
}

; 0x01
; $02A3E6-$02A41B JUMP LOCATION
Lanmola_Mound:
{
    LDA.w $0DF0, X : BNE Lanmola_SetScatterSandPosition_exit
        JSL.l Lanmola_SpawnShrapnel
        
        LDA.b #$13 : STA.w $012D
        
        JSL.l GetRandomInt : AND.b #$07 : TAY
        
        LDA Pool_Lanmola_Mound_randXPos, Y : STA.w $0DA0, X
        
        JSL.l GetRandomInt : AND.b #$07 : TAY
        
        LDA Pool_Lanmola_Mound_randYPos, Y : STA.w $0DB0, X
        
        INC.w $0D80, X
        
        LDA.b #$18 : STA.w $0F80, X
        
        STZ.w $0EC0, X
        STZ.w $0ED0, X

        ; Bleeds into the next function.
}
        
; $02A41C-$02A42E JUMP LOCATION
Lanmola_SetScatterSandPosition:
{
    LDA.w $0D10, X : STA.w $0DE0, X
    LDA.w $0D00, X : STA.w $0E70, X
        
    LDA.b #$4A : STA.w $0E00, X
        
    RTS
    
    ; OPTIMIZE: Just use the other RTS.
    .exit
    
    RTS
}

; ==============================================================================

; $02A42F-$02A430 DATA
Lanmola_Fly_y_speed_slope:
{
    db 2, -2
}

; 0x02
; $02A431-$02A4CA JUMP LOCATION
Lanmola_Fly:
{
    JSR.w Sprite2_CheckDamage
    JSR.w Sprite2_MoveAltitude
    
    ; Slowly decrease the Y speed when first coming out of the ground.
    LDA.w $0EC0, X : BNE .alpha
        LDA.w $0F80, X : SEC : SBC.b #$01 : STA.w $0F80, X : BNE .beta
            INC.w $0EC0, X
        
        .beta
        
        BRA .dontSwitchDirections
    
    .alpha
    
    ; Use the Y speed to bob up and down:
    LDA.b $1A : AND.b #$01 : BNE .dontSwitchDirections ; Every other frame.
        LDA.w $0ED0, X : AND.b #$01 : TAY
        
        LDA.w $0F80, X : CLC : ADC .y_speed_slope, Y : STA.w $0F80, X
        CMP.w Pool_Sprite_Lanmolas_x_speeds, Y : BNE .dontSwitchDirections
            INC.w $0ED0, X ; Switch direction.
    
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
    
    ; If our position is 0x0002 away from the random X and Y pos we chose
    ; earlier go to the next stage.
    LDA.b $00 : SEC : SBC.b $04 : CLC : ADC.w #$0002 : CMP.w #$0004 : BCS .notCloseEnough
        LDA.b $02 : SEC : SBC.b $06 : CLC : ADC.w #$0002 : CMP.w #$0004 : SEP #$20 : BCS .notCloseEnough
            INC.w $0D80, X
    
    .notCloseEnough
    
    SEP #$20
    
    LDA.b #$0A
    
    JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    LDA.b $01 : STA.w $0D50, X
    
    JSR.w Sprite2_Move
    
    RTS
}

; 0x03
; $02A4CB-$02A4F1 JUMP LOCATION
Lanmola_Dive:
{
    JSR.w Sprite2_CheckDamage
    JSR.w Sprite2_Move
    JSR.w Sprite2_MoveAltitude
    
    LDA.w $0F80, X : CMP.b #$EC : BMI .alpha
        SEC : SBC.b #$01 : STA.w $0F80, X
    
    .alpha
    
    LDA.w $0F70, X : BPL .notUnderGroundYet
        INC.w $0D80, X
        
        LDA.b #$80 : STA.w $0DF0, X
        
        JSR.w Lanmola_SetScatterSandPosition
    
    .notUnderGroundYet
    
    RTS
}

; ==============================================================================

; 0x04
; $02A4F2-$02A514 JUMP LOCATION
Lanmola_Reset:
{
    LDA.w $0DF0, X : BNE .wait
        STZ.w $0D80, X
        
        JSL.l GetRandomInt : AND.b #$07 : TAY
        
        LDA Lanmola_Mound_randXPos, Y : STA.w $0D10, X
        
        JSL.l GetRandomInt : AND.b #$07 : TAY
        
        LDA Lanmola_Mound_randYPos, Y : STA.w $0D00, X
    
    .wait

    ; Bleeds into the next function:
}

Lanmola_Death_easy_out:
{
    RTS
}

; ==============================================================================

; $02A515-$02A51C DATA
Lanmolas_SegmentOffsets:
{
    db $00, $08, $10, $18, $20, $28, $30, $38
}

; ==============================================================================

; Triggers falling item special object apparently?
; $02A51D-$02A528 LONG JUMP LOCATION
Sprite_SpawnFallingItem:
{
    PHX
    
    TAX
    
    LDY.b #$04 ; Try to load the effect into slot 4.
    LDA.b #$29 ; Trigger a falling item effect.
    
    JSL.l AddPendantOrCrystal
    
    PLX
    
    RTL
}

; ==============================================================================

; 0x05
; $02A529-$02A5D9 JUMP LOCATION
Lanmola_Death:
{
    LDY.w $0DF0, X : BNE .alpha
        STZ.w $0DD0, X
        
        JSL.l Sprite_VerifyAllOnScreenDefeated : BCC .alpha
            ; Lanmolas are dead, spawn heart container.
            LDA.b #$EA : JSL.l Sprite_SpawnDynamically
            
            JSL.l Sprite_SetSpawnedCoords
            
            LDA.b #$20 : STA.w $0F80, Y
            LDA.b #$03 : STA.w $0D90, Y
    
    .alpha
    
    LDA.w $0DF0, X : CMP.b #$20 : BCC .easy_out
                     CMP.b #$A0 : BCS .easy_out
                     AND.b #$0F : BNE .easy_out
    
        LDA.l $7FF81E, X : TAY
        
        LDA.w $0E80, X : SEC : SBC.w Lanmolas_SegmentOffsets, Y : AND.b #$3F
        CLC : ADC Pool_Lanmola_FinishInitialization_sprite_regions, X : PHX : TAX
        
        LDA.l $7FFC00, X : SEC : SBC.b $E2                          : STA.b $0A
        LDA.l $7FFD00, X : SEC : SBC.l $7FFE00, X : SEC : SBC.b $E8 : STA.b $0B
        
        PLX
        
        ; Spawn a sprite that instantly dies as a boss explosion?
        LDA.b #$00 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            LDA.b #$0B : STA.w $0AAA
            
            LDA.b #$04 : STA.w $0DD0, Y
            
            LDA.b #$1F : STA.w $0DF0, Y : STA.w $0D90, Y
            
            LDA.b $0A : CLC : ADC.b $E2  : STA.w $0D10, Y
            LDA.b $E3 :       ADC.b #$00 : STA.w $0D30, Y
            LDA.b $0B : CLC : ADC.b $E8  : STA.w $0D00, Y
            LDA.b $E9 :       ADC.b #$00 : STA.w $0D20, Y
            
            LDA.b #$03 : STA.w $0E40, Y
            
            LDA.b #$0C : STA.w $0F50, Y
            
            LDA.b #$0C : JSL.l Sound_SetSfx2PanLong
            
            LDA.l $7FF81E, X : BMI .beta
                DEC : STA.l $7FF81E, X

            .beta
        .spawn_failed
        
        RTS
}

; ==============================================================================

; $02A5DA-$02A649 DATA
Pool_Lanmola_FinishInitialization:
{
    ; $02A5DA
    .sprite_regions
    db $00, $40, $80, $C0
    
    ; $02A5DE
    .data1
    db $00, $1C
    
    ; $02A5E0
    .data2
    db $01, $F9
}

; ==============================================================================

; $02A5E2-$02A649 DATA
Pool_Lanmola_Draw:
{
    ; $02A5E2
    .chr1
    db $C4, $E2, $C2, $E0, $C0, $E0, $C2, $E2
    db $C4, $E2, $C2, $E0, $C0, $E0, $C2, $E2

    ; $02A5F2
    .chr2
    db $CC, $E4, $CA, $E6, $C8, $E6, $CA, $E4
    db $CC, $E4, $CA, $E6, $C8, $E6, $CA, $E4 

    ; $02A602
    .properties
    db $C0, $C0, $C0, $C0, $80, $80, $80, $80
    db $00, $00, $00, $00, $40, $40, $40, $40

    ; $02A612
    .xDirt
    db $F8, $08, $F6, $0A, $F0, $10, $E8, $20
    
    ; $02A61A
    .yDirt
    db $00, $00, $FF, $FF, $FF, $FF, $03, $03
    
    ; $02A622
    .chrDirt
    db $E8, $E8, $E8, $E8, $EA, $EA, $EA, $EA
    
    ; $02A62A
    .propertiesDirt
    db $00, $40, $00, $40, $00, $40, $00, $40

    ; $02A632
    .sizesDirt
    db $02, $02, $02, $02, $02, $02, $00, $00
       
    ; $02A63A
    .OAMCoord90
    db $30, $09, $F0, $08, $B0, $08, $70, $08

    ; $02A642
    .OAMCoord92
    db $6C, $0A, $5C, $0A, $4C, $0A, $3C, $0A
}

; $02A64A-$02A81F LOCAL JUMP LOCATION
Lanmola_Draw:
{
    TXA : ASL : TAY
    
    REP #$20
    
    LDA Pool_Lanmola_Draw_OAMCoord90, Y : STA.b $90
    LDA Pool_Lanmola_Draw_OAMCoord92, Y : STA.b $92
    
    SEP #$20
    
    LDA.w $0D40, X : SEC : SBC.w $0F80, X : STA.b $00
    LDA.w $0D50, X                        : STA.b $01
    
    JSL.l Sprite_ConvertVelocityToAngle : STA.w $0DC0, X
    
    LDA Pool_Lanmola_FinishInitialization_sprite_regions, X : STA.b $04
    
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
            LDA.w $0E80, X : INC : AND.b #$3F : STA.w $0E80, X
    
    .notActive
    
    LDA.w $0F50, X : ORA.w $0B89, X : STA.b $03
    
    LDA.l $7FF81E, X : BPL .beta
        RTS
    
    .beta
    
    PHX
    
    PHA : STA.b $0E
    
    LDA.w $0D40, X : ASL : ROL : AND.b #$01 : TAX
    
    LDA Pool_Lanmola_FinishInitialization_data2, X : STA.b $0C
    
    LDY Pool_Lanmola_FinishInitialization_data1, X
    
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
            LDA Pool_Lanmola_Draw_chr1, X
            
            BRA .zeta
            
            .epsilon
            
            LDA Pool_Lanmola_Draw_chr2, X
        
        .zeta
        
        PLY                                             : INY : STA ($90), Y
        LDA Pool_Lanmola_Draw_properties, X : ORA.b $03 : INY : STA ($90), Y
        
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
            
            LDA.w $0D40, X : ASL : ROL : ASL : EOR.w $0D80, X : AND.b #$02 : BEQ .nu
                LDA.b #$08 : JSL.l OAM_AllocateFromRegionB
                
                BRA .xi
            
            .nu
            
            LDA.b #$08 : JSL.l OAM_AllocateFromRegionC
            
            .xi
            
            LDY.b #$00
            
            PLA : LSR #2 : AND.b #$03 : EOR.b #$03 : ASL : STA.b $06
            
            LDA.w $0DE0, X : SEC : SBC.b $E2 : STA.b $00
            LDA.w $0E70, X : SEC : SBC.b $E8 : STA.b $02
            
            PHX
            
            LDX.b #$01
            
            .omicron
            
                PHX
                
                TXA : CLC : ADC.b $06 : TAX
                
                LDA.b $00 : CLC : ADC Pool_Lanmola_Draw_xDirt, X
                STA ($90), Y

                LDA.b $02 : CLC : ADC Pool_Lanmola_Draw_yDirt, X
                INY : STA ($90), Y

                LDA Pool_Lanmola_Draw_chrDirt, X
                INY : STA ($90), Y

                LDA Pool_Lanmola_Draw_propertiesDirt, X
                ORA.b #$31 : INY : STA ($90), Y
                
                PHY
                
                TYA : LSR #2 : TAY
                
                LDA Pool_Lanmola_Draw_sizesDirt, X : STA ($92), Y
                
                PLY : INY
            PLX : DEX : BPL .omicron
            
            PLX
    
    .mu
    
    RTS
}

; $02A820-$02A87F LOCAL JUMP LOCATION
Lanmola_DrawMound:
{
    LDA.b #$04 : JSL.l OAM_AllocateFromRegionB
    
    LDA.w $0D10, X : SEC : SBC.b $E2 : STA.b $00
    LDA.w $0D00, X : SEC : SBC.b $E8 : STA.b $02
    
    LDA.w $0DF0, X : LSR #3 : TAY
    
    PHX
    
    LDX.w .frame, Y
    
    LDY.b #$00
    
    LDA.b $00                          : STA ($90), Y
    LDA.b $02                    : INY : STA ($90), Y
    LDA.w .properties, X         : INY : STA ($90), Y
    LDA.w .sizes, X : ORA.b #$31 : INY : STA ($90), Y
    
    TYA : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLX
    
    RTS
    
    ; $02A864
    .properties
    db $EE, $EE, $EC, $EC, $CE, $CE
    
    ; $02A86A
    .sizes
    db $00, $40, $00, $40, $00, $40
    
    ; $02A870
    .frame
    db $04, $05, $04, $05, $04, $05, $04, $05
    db $04, $03, $02, $01, $01, $01, $00, $00
}

; ==============================================================================
