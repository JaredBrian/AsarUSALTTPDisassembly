
; ==============================================================================

; $0F2AA7-$0F2AF3 JUMP LOCATION
Sprite_StalfosKnight:
{
    LDA.w $0D80, X : BNE .visible
    
    JSL Sprite_PrepOamCoordLong
    
    BRA .not_visible
    
    .visible
    
    JSR StalfosKnight_Draw
    
    .not_visible
    
    JSR Sprite3_CheckIfActive
    
    LDA.w $0EF0, X : AND.b #$7F : CMP.b #$01 : BNE .BRANCH_GAMMA
    
    STZ.w $0EF0, X
    
    LDA.b #$06 : STA.w $0D80, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    STZ.w $0D50, X
    STZ.w $0D40, X
    
    LDA.b #$02 : STA.l $7F6918
    
    .BRANCH_GAMMA
    
    JSR Sprite3_CheckIfRecoiling
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw StalfosKnight_WaitingForPlayer
    dw StalfosKnight_Falling
    dw $AB5C ; = $F2B5C*
    dw $ABA6 ; = $F2BA6*
    dw $ABD6 ; = $F2BD6*
    dw $ABF6 ; = $F2BF6*
    dw $AC77 ; = $F2C77*
    dw $ACD8 ; = $F2CD8*
}

; ==============================================================================

; $0F2AF4-$0F2B26 JUMP LOCATION
StalfosKnight_WaitingForPlayer:
{
    LDA.b #$09 : STA.w $0F60, X : STA.w $0BA0, X
    
    ; Temporarily make the sprite harmless since it's not technically
    ; on screen yet.
    LDA.w $0E4040, X : PHA
    ORA.b #$80   : STA.w $0E40, X
    
    JSR Sprite3_CheckDamageToPlayer
    
    PLA : STA.w $0E40, X : BCC .didnt_touch
    
    ; As soon as Link gets close enough, the Stalfos knight reveals itself
    ; by falling from the ceiling.
    LDA.b #$90 : STA.w $0F70, X
    
    INC.w $0D80, X
    
    LDA.b #$02 : STA.w $0EB0, X
    
    LDA.b #$02 : STA.w $0DC0, X
    
    LDA.b #$20 : JSL Sound_SetSfx2PanLong
    
    .didnt_touch
    
    RTS
}

; ==============================================================================

; $0F2B27-$0F2B59 JUMP LOCATION
StalfosKnight_Falling:
{
    LDA.w $0F70, X : PHA
    
    JSR Sprite3_MoveAltitude
    
    LDA.w $0F80, X : CMP.b #$C0 : BMI .at_terminal_falling_speed
    
    SEC : SBC.b #$03 : STA.w $0F80, X
    
    .at_terminal_falling_speed
    
    PLA : EOR.w $0F70, X : BPL .not_sign_change
    
    LDA.w $0F70, X : BPL .in_air
    
    ; $0F2B46 ALTERNATE ENTRY POINT
    
    LDA.b #$02 : STA.w $0D80, X
    
    STZ.w $0BA0, X
    
    STZ.w $0F70, X
    
    STZ.w $0F80, X
    
    LDA.b #$3F : STA.w $0DF0, X
    
    .in_air
    .no_sign_change
    
    RTS
}

; ==============================================================================

; $0F2B5A-$0F2B5B DATA
{
    .animation_states
    db 0, 1
}

; ==============================================================================

; $0F2B5C-$0F2B95 JUMP LOCATION
{
    LDA.b #$00 : STA.l $7F6918
    
    JSR Sprite3_CheckDamage
    
    LDA.w $0DF0, X : BNE .delay
    
    LDA.b #$03 : STA.w $0D80, X
    
    JSL GetRandomInt : AND.b #$3F : STA.w $0DA0, X
    
    LDA.b #$7F : STA.w $0DF0, X
    
    RTS
    
    .delay
    
    LSR #5 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    LDA .animation_states, Y : STA.w $0DB0, X
    
    LDA.b #$02 : STA.w $0EB0, X
    
    RTS
}

; ==============================================================================

; $0F2B96-$0F2BA5 DATA
{
    ; TODO: Label this data.
    db  0,  0,  0,  2,  1,  1,  1,  2
    db  0,  0,  0,  2,  1,  1,  1,  2
}

; ==============================================================================

; $0F2BA6-$0F2BD5 JUMP LOCATION
{
    JSR Sprite3_CheckDamage
    
    LDA.w $0DF0, X : CMP.w $0DA0, X : BNE .BRANCH_ALPHA
    
    JSR Sprite3_IsToRightOfPlayer
    
    TYA : STA.w $0EB0, X
    
    INC.w $0D80, X
    
    LDA.b #$20 : STA.w $0DF0, X
    
    RTS
    
    .BRANCH_ALPHA
    
    LSR #3 : TAY
    
    LDA.w $AB96, Y : STA.w $0EB0, X
    
    LDA.b #$00 : STA.w $0DB0, X
    
    LDA.b #$00 : STA.w $0DC0, X
    
    RTS
}

; $0F2BD6-$0F2BF5 JUMP LOCATION
{
    JSR Sprite3_CheckDamage
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
    
    INC.w $0D80, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    LDA.b #$20 : STA.w $0E00, X
    
    ; $0F2BEB ALTERNATE ENTRY POINT
    .BRANCH_ALPHA
    
    LDA.b #$01 : STA.w $0DB0, X
    LDA.b #$01 : STA.w $0DC0, X
    
    RTS
}

; $0F2BF6-$0F2C56 JUMP LOCATION
{
    JSR Sprite3_CheckDamage
    
    LDA.w $0E00, X : BEQ .BRANCH_ALPHA
    DEC A        : BNE .BRANCH_BETA
    
    LDA.b #$30 : STA.w $0F80, X
    
    LDA.b #$10
    
    JSL Sprite_ApplySpeedTowardsPlayerLong
    JSR Sprite3_IsToRightOfPlayer
    
    TYA : STA.w $0EB0, X
    
    LDA.b #$13 : JSL Sound_SetSfx3PanLong
    
    .BRANCH_BETA
    
    BRA .BRANCH_$F2BEB
    
    .BRANCH_ALPHA
    
    JSR Sprite3_MoveXyz
    JSR Sprite3_CheckTileCollision
    
    LDA.w $0F80, X : CMP.b #$C0 : BMI .BRANCH_GAMMA
    
    SEC : SBC.b #$02 : STA.w $0F80, X
    
    .BRANCH_GAMMA
    
    LDA.w $0F70, X : DEC A : BPL .BRANCH_DELTA
    
    STZ.w $0F70, X
    STZ.w $0F80, X
    
    LDA.w $0DF0, X : BNE .BRANCH_EPSILON
    
    JMP.w $AB46 ; $0F2B46 IN ROM
    
    .BRANCH_EPSILON
    
    LDA.b #$10 : STA.w $0E00, X
    
    .BRANCH_DELTA
    
    LDY.b #$02
    
    LDA.w $0F80, X : CMP.b #$18 : BMI .BRANCH_ZETA
    
    LDY.b #$00
    
    .BRANCH_ZETA
    
    TYA : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F2C57-$0F2C76 DATA
{
    ; TODO: Label this data
    db  0,  4,  8, 12, 14, 14, 14, 14
    db 14, 14, 14, 14, 14, 14, 14, 14
    db 14, 14, 14, 14, 14, 14, 14, 14
    db 14, 14, 15, 14, 12,  8,  4,  0
}

; ==============================================================================

; $0F2C77-$0F2CD5 JUMP LOCATION
{
    JSR Sprite3_MoveXyz
    JSR Sprite3_CheckTileCollision
    
    LDA.w $0F80, X : CMP.b #$C0 : BMI .BRANCH_ALPHA
    
    SEC : SBC.b #$02 : STA.w $0F80, X
    
    .BRANCH_ALPHA
    
    LDA.w $0F70, X : DEC A : BPL .BRANCH_BETA
    
    STZ.w $0F70, X
    STZ.w $0F80, X
    
    .BRANCH_BETA
    
    LDA.w $0DF0, X : BNE .BRANCH_GAMMA
    
    JSL GetRandomInt : AND.b #$01 : BNE .BRANCH_DELTA
    
    LDA.b #$07 : STA.w $0D80, X
    LDA.b #$50 : STA.w $0DF0, X
    
    RTS
    
    .BRANCH_DELTA
    
    JMP.w $AB46 ; $0F2B46 IN ROM
    
    .BRANCH_GAMMA
    
    CMP.b #$E0 : BCC .BRANCH_EPSILON
    
    PHA : AND.b #$03 : BNE .BRANCH_ZETA
    
    LDA.b #$14 : JSL Sound_SetSfx3PanLong
    
    .BRANCH_ZETA
    
    PLA
    
    .BRANCH_EPSILON
    
    LSR #3 : TAY
    
    LDA.w $AC57, Y : STA.w $0DB0, X
    
    LDA.b #$03 : STA.w $0DC0, X
    
    LDA.b #$02 : STA.w $0EB0, X
    
    RTS
}

; ==============================================================================

; $0F2CD6-$0F2CD7 DATA
{
    ; TODO: Name this routine / pool.
    .animation_states
    db 1, 4
}

; ==============================================================================

; $0F2CD8-$0F2CEB JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .delay
    
    JMP.w $AB46 ; $0F2B46 IN ROM
    
    .delay
    
    LSR #2 : AND.b #$01 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F2CEC-$0F2E03 DATA
Pool_StalfosKnight_Draw:
{
    .oam_groups
    dw -4, -8 : db $64, $00, $00, $00
    dw -4,  0 : db $61, $00, $00, $02
    dw  4,  0 : db $62, $00, $00, $02
    dw -3, 16 : db $74, $00, $00, $00
    dw 11, 16 : db $74, $40, $00, $00
    
    dw -4, -7 : db $64, $00, $00, $00
    dw -4,  1 : db $61, $00, $00, $02
    dw  4,  1 : db $62, $00, $00, $02
    dw -3, 16 : db $65, $00, $00, $00
    dw 11, 16 : db $65, $40, $00, $00
    
    dw -4, -8 : db $48, $00, $00, $02
    dw  4, -8 : db $49, $00, $00, $02
    dw -4,  8 : db $4B, $00, $00, $02
    dw  4,  8 : db $4C, $00, $00, $02
    dw  4,  8 : db $4C, $00, $00, $02
    
    dw -4,  8 : db $68, $00, $00, $02
    dw  4,  8 : db $69, $00, $00, $02
    dw  4,  8 : db $69, $00, $00, $02
    dw  4,  8 : db $69, $00, $00, $02
    dw  4,  8 : db $69, $00, $00, $02
    
    dw 12, -7 : db $64, $40, $00, $00
    dw -4,  1 : db $62, $40, $00, $02
    dw  4,  1 : db $61, $40, $00, $02
    dw -3, 16 : db $65, $00, $00, $00
    dw 11, 16 : db $65, $40, $00, $00
    
    dw 12, -8 : db $64, $40, $00, $00
    dw -4,  0 : db $62, $40, $00, $02
    dw  4,  0 : db $61, $40, $00, $02
    dw -3, 16 : db $74, $00, $00, $00
    dw 11, 16 : db $74, $40, $00, $00
    
    dw -4, -8 : db $49, $40, $00, $02
    dw  4, -8 : db $48, $40, $00, $02
    dw -4,  8 : db $4C, $40, $00, $02
    dw  4,  8 : db $4B, $40, $00, $02
    dw  4,  8 : db $4B, $40, $00, $02
}

; ==============================================================================

; $0F2E04-$0F2E45 LOCAL
StalfosKnight_Draw:
{
    JSR Sprite3_PrepOamCoord
    JSR.w $AE4E ; $0F2E4E IN ROM
    
    LDA.b #$00   : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #3 : STA.b $00 : ASL #2 : ADC.b $00
    
    ADC.w #.oam_groups : STA.b $08
    
    LDA.b $90 : CLC : ADC.w #$0004 : STA.b $90
    
    INC.b $92
    
    SEP #$20
    
    LDA.b #$05 : JSR Sprite3_DrawMultiple
    
    REP #$20
    
    LDA.b $90 : SEC : SBC.w #$0004 : STA.b $90
    
    DEC.b $92
    
    SEP #$20
    
    LDA.b #$12 : JSL Sprite_DrawShadowLong.variable
    
    RTS
}

; ==============================================================================

; $0F2E46-$0F2E4D DATA
{
    ; TODO: Name this Pool_/ routine. Hint: Perhaps it's for the Stalfos knight
    ; head?
    .chr
    db $66, $66, $46, $46
    
    .properties
    db $40, $00, $00, $00
}

; ==============================================================================

; $0F2E4E-$0F2EA3 LOCAL
{
    LDA.w $0DC0, X : CMP.b #$02 : BEQ .dont_draw
    
    LDA.w $0DB0, X : STA.b $06
                   STZ.b $07
    
    LDY.b #$00
    
    PHX
    
    LDA.w $0EB0, X : TAX
    
    REP #$20
    
    LDA.b $00 : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : CLC : ADC.b $06 : SEC : SBC.w #$000C : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen_y
    
    LDA.w #$00F0 : STA ($90), Y
    
    .on_screen_y
    
    SEP #$20
    
    LDA .chr, X        : INY           : STA ($90), Y
    LDA .properties, X : INY : ORA.b $05 : STA ($90), Y
    
    TYA : LSR #2 : TAY
    
    LDA.b #$02 : ORA.b $0F : STA ($92), Y
    
    PLX
    
    .dont_draw:
    
    RTS
}

; ==============================================================================
