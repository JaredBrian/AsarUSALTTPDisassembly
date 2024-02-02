
; ==============================================================================

; $032D6F-$032D99 JUMP LOCATION
Sprite_StoryTeller_1:
{
    JSR StoryTeller_1_Draw
    JSR Sprite_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    LDA $0DF0, X : BNE .countingDown
    
    LDA $1A : LSR #4 : AND.b #$01 : STA $0DC0, X
    
    .countingDown
    
    LDA $0E80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $AD9A ; = $32D9A*
    dw $ADE1 ; = $32DE1*
    dw $AE0A ; = $32E0A*
    dw $AE34 ; = $32E34*
    dw $AE5B ; = $32E5B*
}

; $032D9A-$032DA6 JUMP LOCATION
{
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $ADA7 ; = $32DA7*
    dw $ADBF ; = $32DBF*
    dw $ADB5 ; = $32DB5*
}

; $032DA7-$032DB4 JUMP LOCATION
{
    LDA.b #$FE
    LDY.b #$00
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .BRANCH_ALPHA
    
    INC $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $032DB5-$032DBE JUMP LOCATION
{
    ; Refill all hearts
    LDA.b #$A0 : STA $7EF372
    
    STZ $0D80, X
    
    RTS
}

; $032DBF-$032DE0 JUMP LOCATION
{
    LDA $1CE8 : BNE .BRANCH_ALPHA
    
    ; $032EAB IN ROM
    JSR $AEAB : BCC .BRANCH_ALPHA
    
    LDA.b #$FF
    LDY.b #$00
    
    ; $032DCD ALTERNATE ENTRY POINT
    
    JSL Sprite_ShowMessageUnconditional
    
    INC $0D80, X
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$00
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    STZ $0D80, X
    
    RTS
}

; $032DE1-$032DED JUMP LOCATION
{
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $ADA7 ; = $32DA7*
    dw $ADEE ; = $32DEE*
    dw $ADB5 ; = $32DB5*
}

; $032DEE-$032E09 JUMP TABLE
{
    LDA $1CE8 : BNE .BRANCH_ALPHA
    
    ; $032EAB IN ROM
    JSR $AEAB : BCC .BRANCH_ALPHA
    
    LDA.b #$01
    LDY.b #$01
    
    BRA .BRANCH_$32DCD
    
    .BRANCH_ALPHA
    
    LDA.b #$00
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    STZ $0D80, X
    
    RTS
}

; $032E0A-$032E16 JUMP LOCATION
{
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $ADA7 ; = $32DA7*
    dw $AE17 ; = $32E17*
    dw $ADB5 ; = $32DB5*
}

; $032E17-$032E33 JUMP LOCATION
{
    LDA $1CE8 : BNE .BRANCH_ALPHA
    
    ; $032EAB IN ROM
    JSR $AEAB : BCC .BRANCH_ALPHA
    
    LDA.b #$02
    LDY.b #$01
    
    JMP $ADCD ; $032DCD IN ROM
    
    .BRANCH_ALPHA
    
    LDA.b #$00
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    STZ $0D80, X
    
    RTS
}

; $032E34-$032E5A JUMP LOCATION
{
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    LDA $1A : AND.b #$3F : BNE .BRANCH_BETA
    
    LDA $0F50, X : EOR.b #$40 : STA $0F50, X
    
    .BRANCH_BETA
    
    JSL GetRandomInt : BNE .BRANCH_ALPHA
    
    LDA.b #$20 : STA $0DF0, X
    
    .BRANCH_ALPHA
    
    LDA.b #$49
    LDY.b #$01
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; $032E5B-$032E8D JUMP LOCATION
{
    LDA $1A : LSR A : AND.b #$01 : STA $0DC0, X
    
    JSR Sprite_MoveAltitude
    
    LDA $0F70, X : BPL .BRANCH_ALPHA
    
    STZ $0F70, X
    
    .BRANCH_ALPHA
    
    LDA $0F70, X : CMP.b #$04 : ROL A : AND.b #$01 : TAY
    
    LDA $0F80, X : CLC : ADC $A213, Y : STA $0F80, X
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $ADA7 ; = $32DA7*
    dw $AE8E ; = $32E8E*
    dw $ADB5 ; = $32DB5*
}

; $032E8E-$032EAA JUMP LOCATION
{
    LDA $1CE8 : BNE .BRANCH_ALPHA
    
    ; $032EAB IN ROM
    JSR $AEAB : BCC .BRANCH_ALPHA
    
    LDA.b #$03
    LDY.b #$01
    
    JMP $ADCD   ; $032DCD IN ROM
    
    .BRANCH_ALPHA
    
    LDA.b #$00
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    STZ $0D80, X
    
    RTS
}

; $032EAB-$032EC9 LOCAL JUMP LOCATION
{
    REP #$20
    
    LDA $7EF360 : CMP.w #$0014 : BCC .notEnoughRupees
    
    LDA $7EF360 : SEC : SBC.w #$0014 : STA $7EF360
    
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
pool StoryTeller_1_Draw:
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
    LDA $0E80, X : ASL A : ADC $0DC0, X : ASL #3
    
    ADC.b #.oam_groups                 : STA $08
    LDA.b #.oam_groups>>8 : ADC.b #$00 : STA $09
    
    LDA.b #$01 : STA $06
                 STZ $07
    
    JSL Sprite_DrawMultiple.player_deferred
    JMP Sprite_DrawShadow
}

; ==============================================================================
