
; ==============================================================================

; $032D6F-$032D99 JUMP LOCATION
Sprite_StoryTeller_1:
{
    JSR.w StoryTeller_1_Draw
    JSR.w Sprite_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.w $0DF0, X : BNE .countingDown
    
    LDA.b $1A : LSR #4 : AND.b #$01 : STA.w $0DC0, X
    
    .countingDown
    
    LDA.w $0E80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw $AD9A ; = $032D9A
    dw $ADE1 ; = $032DE1
    dw $AE0A ; = $032E0A
    dw $AE34 ; = $032E34
    dw $AE5B ; = $032E5B
}

; $032D9A-$032DA6 JUMP LOCATION
{
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw $ADA7 ; = $032DA7
    dw $ADBF ; = $032DBF
    dw $ADB5 ; = $032DB5
}

; $032DA7-$032DB4 JUMP LOCATION
{
    LDA.b #$FE
    LDY.b #$00
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .BRANCH_ALPHA
    
    INC.w $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $032DB5-$032DBE JUMP LOCATION
{
    ; Refill all hearts
    LDA.b #$A0 : STA.l $7EF372
    
    STZ.w $0D80, X
    
    RTS
}

; $032DBF-$032DE0 JUMP LOCATION
{
    LDA.w $1CE8 : BNE .BRANCH_ALPHA
    
    ; $032EAB IN ROM
    JSR.w $AEAB : BCC .BRANCH_ALPHA
    
    LDA.b #$FF
    LDY.b #$00
    
    ; $032DCD ALTERNATE ENTRY POINT
    
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$00
    LDY.b #$01
    
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
}

; $032DE1-$032DED JUMP LOCATION
{
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw $ADA7 ; = $32DA7*
    dw $ADEE ; = $32DEE*
    dw $ADB5 ; = $32DB5*
}

; $032DEE-$032E09 JUMP TABLE
{
    LDA.w $1CE8 : BNE .BRANCH_ALPHA
    
    ; $032EAB IN ROM
    JSR.w $AEAB : BCC .BRANCH_ALPHA
    
    LDA.b #$01
    LDY.b #$01
    
    BRA .BRANCH_$32DCD
    
    .BRANCH_ALPHA
    
    LDA.b #$00
    LDY.b #$01
    
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
}

; $032E0A-$032E16 JUMP LOCATION
{
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw $ADA7 ; = $32DA7*
    dw $AE17 ; = $32E17*
    dw $ADB5 ; = $32DB5*
}

; $032E17-$032E33 JUMP LOCATION
{
    LDA.w $1CE8 : BNE .BRANCH_ALPHA
    
    ; $032EAB IN ROM
    JSR.w $AEAB : BCC .BRANCH_ALPHA
    
    LDA.b #$02
    LDY.b #$01
    
    JMP.w $ADCD ; $032DCD IN ROM
    
    .BRANCH_ALPHA
    
    LDA.b #$00
    LDY.b #$01
    
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
}

; $032E34-$032E5A JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    LDA.b $1A : AND.b #$3F : BNE .BRANCH_BETA
    
    LDA.w $0F50, X : EOR.b #$40 : STA.w $0F50, X
    
    .BRANCH_BETA
    
    JSL.l GetRandomInt : BNE .BRANCH_ALPHA
    
    LDA.b #$20 : STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    LDA.b #$49
    LDY.b #$01
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; $032E5B-$032E8D JUMP LOCATION
{
    LDA.b $1A : LSR A : AND.b #$01 : STA.w $0DC0, X
    
    JSR.w Sprite_MoveAltitude
    
    LDA.w $0F70, X : BPL .BRANCH_ALPHA
    
    STZ.w $0F70, X
    
    .BRANCH_ALPHA
    
    LDA.w $0F70, X : CMP.b #$04 : ROL A : AND.b #$01 : TAY
    
    LDA.w $0F80, X : CLC : ADC.w $A213, Y : STA.w $0F80, X
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw $ADA7 ; = $32DA7*
    dw $AE8E ; = $32E8E*
    dw $ADB5 ; = $32DB5*
}

; $032E8E-$032EAA JUMP LOCATION
{
    LDA.w $1CE8 : BNE .BRANCH_ALPHA
    
    ; $032EAB IN ROM
    JSR.w $AEAB : BCC .BRANCH_ALPHA
    
    LDA.b #$03
    LDY.b #$01
    
    JMP.w $ADCD   ; $032DCD IN ROM
    
    .BRANCH_ALPHA
    
    LDA.b #$00
    LDY.b #$01
    
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
}

; $032EAB-$032EC9 LOCAL JUMP LOCATION
{
    REP #$20
    
    LDA.l $7EF360 : CMP.w #$0014 : BCC .notEnoughRupees
    
    LDA.l $7EF360 : SEC : SBC.w #$0014 : STA.l $7EF360
    
    SEP #$30
    
    SEC
    
    RTS
    
    .notEnoughRupees
    
    SEP #$30
    
    CLC
    
    RTS
}

; ==============================================================================

; $032ECA-$032F19 DATA
Pool_StoryTeller_1_Draw:
{
    dw 0, 0 : db $4A, $0A, $00, $02
    dw 0, 0 : db $6E, $4A, $00, $02
    dw 0, 0 : db $24, $0A, $00, $02
    dw 0, 0 : db $24, $4A, $00, $02
    dw 0, 0 : db $04, $08, $00, $02
    dw 0, 0 : db $04, $48, $00, $02
    dw 0, 0 : db $6A, $0A, $00, $02
    dw 0, 0 : db $6C, $0A, $00, $02
    dw 0, 0 : db $0E, $0A, $00, $02
    dw 0, 0 : db $2E, $0A, $00, $02       
}

; ==============================================================================

; $032F1A-$032F3A LOCAL JUMP LOCATION
StoryTeller_1_Draw:
{
    LDA.w $0E80, X : ASL A : ADC.w $0DC0, X : ASL #3
    
    ADC.b #.oam_groups                 : STA.b $08
    LDA.b #.oam_groups>>8 : ADC.b #$00 : STA.b $09
    
    LDA.b #$01 : STA.b $06
                 STZ.b $07
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JMP Sprite_DrawShadow
}

; ==============================================================================
