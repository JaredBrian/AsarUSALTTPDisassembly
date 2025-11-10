; ==============================================================================

; $0F2AA7-$0F2AF3 JUMP LOCATION
Sprite_StalfosKnight:
{
    LDA.w $0D80, X : BNE .visible
        JSL.l Sprite_PrepOamCoordLong
        
        BRA .not_visible
    
    .visible
    
    JSR.w StalfosKnight_Draw
    
    .not_visible
    
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0EF0, X : AND.b #$7F : CMP.b #$01 : BNE .BRANCH_GAMMA
        STZ.w $0EF0, X
        
        LDA.b #$06 : STA.w $0D80, X
        
        LDA.b #$FF : STA.w $0DF0, X
        
        STZ.w $0D50, X
        STZ.w $0D40, X
        
        LDA.b #$02 : STA.l $7F6918
        
    .BRANCH_GAMMA
    
    JSR.w Sprite3_CheckIfRecoiling
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw StalfosKnight_WaitingForPlayer    ; 0x00 - $AAF4
    dw StalfosKnight_Falling             ; 0x01 - $AB27
    dw StalfosKnight_Idle                ; 0x02 - $AB5C
    dw StalfosKnight_ScanForOpponents    ; 0x03 - $ABA6
    dw StalfosKnight_Squat               ; 0x04 - $ABD6
    dw StalfosKnight_HopAround           ; 0x05 - $ABF6
    dw StalfosKnight_Crumble             ; 0x06 - $AC77
    dw StalfosKnight_CelebrateStandingUp ; 0x07 - $ACD8
}

; ==============================================================================

; $0F2AF4-$0F2B26 JUMP LOCATION
StalfosKnight_WaitingForPlayer:
{
    LDA.b #$09 : STA.w $0F60, X
                 STA.w $0BA0, X
    
    ; Temporarily make the sprite harmless since it's not technically
    ; on screen yet.
    LDA.w $0E40, X : PHA
    ORA.b #$80     : STA.w $0E40, X
    
    JSR.w Sprite3_CheckDamageToPlayer
    
    PLA : STA.w $0E40, X
    BCC .didnt_touch
        ; As soon as Link gets close enough, the Stalfos knight reveals itself
        ; by falling from the ceiling.
        LDA.b #$90 : STA.w $0F70, X
        
        INC.w $0D80, X
        
        LDA.b #$02 : STA.w $0EB0, X
        
        LDA.b #$02 : STA.w $0DC0, X
        
        LDA.b #$20
        JSL.l Sound_SetSFX2PanLong
        
    .didnt_touch
    
    RTS
}

; ==============================================================================

; $0F2B27-$0F2B45 JUMP LOCATION
StalfosKnight_Falling:
{
    LDA.w $0F70, X : PHA
    
    JSR.w Sprite3_MoveAltitude
    
    LDA.w $0F80, X : CMP.b #$C0 : BMI .at_terminal_falling_speed
        SEC : SBC.b #$03 : STA.w $0F80, X
    
    .at_terminal_falling_speed
    
    ; Not_sign_change
    PLA : EOR.w $0F70, X : BPL .return
        ; In_air
        LDA.w $0F70, X : BPL .return
            ; Bleeds into the next function.
}

; $0F2B46-$0F2B59 JUMP LOCATION
StalfosKnight_EnterIdleState:
{
    LDA.b #$02 : STA.w $0D80, X
            
    STZ.w $0BA0, X
            
    STZ.w $0F70, X
            
    STZ.w $0F80, X
            
    LDA.b #$3F : STA.w $0DF0, X
            
    ; $0F2B59 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; ==============================================================================

; $0F2B5A-$0F2B5B DATA
StalfosKnight_Idle_animation_states:
{
    db 0, 1
}

; $0F2B5C-$0F2B95 JUMP LOCATION
StalfosKnight_Idle:
{
    LDA.b #$00 : STA.l $7F6918
    
    JSR.w Sprite3_CheckDamage
    
    LDA.w $0DF0, X : BNE .delay
        LDA.b #$03 : STA.w $0D80, X
        
        JSL.l GetRandomInt : AND.b #$3F : STA.w $0DA0, X
        
        LDA.b #$7F : STA.w $0DF0, X
        
        RTS
    
    .delay
    
    LSR #5 : TAY
    LDA.w .animation_states, Y : STA.w $0DC0, X
    LDA.w .animation_states, Y : STA.w $0DB0, X
    
    LDA.b #$02 : STA.w $0EB0, X
    
    RTS
}

; ==============================================================================

; $0F2B96-$0F2BA5 DATA
StalfosKnight_ScanForOpponents_head_direction:
{
    db  0,  0,  0,  2,  1,  1,  1,  2
    db  0,  0,  0,  2,  1,  1,  1,  2
}

; $0F2BA6-$0F2BD5 JUMP LOCATION
StalfosKnight_ScanForOpponents:
{
    JSR.w Sprite3_CheckDamage
    
    LDA.w $0DF0, X : CMP.w $0DA0, X : BNE .BRANCH_ALPHA
        JSR.w Sprite3_IsToRightOfPlayer
        
        TYA : STA.w $0EB0, X
        
        INC.w $0D80, X
        
        LDA.b #$20 : STA.w $0DF0, X
        
        RTS
    
    .BRANCH_ALPHA
    
    LSR #3 : TAY
    LDA.w .head_direction, Y : STA.w $0EB0, X
    
    LDA.b #$00 : STA.w $0DB0, X

    ; OPTIMIZE: No need for the second LDA.b #$00
    LDA.b #$00 : STA.w $0DC0, X
    
    RTS
}

; $0F2BD6-$0F2BEA JUMP LOCATION
StalfosKnight_Squat:
{
    JSR.w Sprite3_CheckDamage
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        INC.w $0D80, X
        
        LDA.b #$FF : STA.w $0DF0, X
        
        LDA.b #$20 : STA.w $0E00, X

    .BRANCH_ALPHA

    ; Bleeds into the next function.
}
    
; $0F2BEB-$0F2BF5 JUMP LOCATION
StalfosKnight_PrepJump:
{
    LDA.b #$01 : STA.w $0DB0, X
    LDA.b #$01 : STA.w $0DC0, X
    
    RTS
}

; $0F2BF6-$0F2C56 JUMP LOCATION
StalfosKnight_HopAround:
{
    JSR.w Sprite3_CheckDamage
    
    LDA.w $0E00, X : BEQ .BRANCH_ALPHA
        DEC : BNE .BRANCH_BETA
            LDA.b #$30 : STA.w $0F80, X
            
            LDA.b #$10
            JSL.l Sprite_ApplySpeedTowardsPlayerLong

            JSR.w Sprite3_IsToRightOfPlayer
            
            TYA : STA.w $0EB0, X
            
            LDA.b #$13
            JSL.l Sound_SetSFX3PanLong
        
        .BRANCH_BETA
        
        BRA StalfosKnight_PrepJump
    
    .BRANCH_ALPHA
    
    JSR.w Sprite3_MoveXyz
    JSR.w Sprite3_CheckTileCollision
    
    LDA.w $0F80, X : CMP.b #$C0 : BMI .BRANCH_GAMMA
        SEC : SBC.b #$02 : STA.w $0F80, X
    
    .BRANCH_GAMMA
    
    LDA.w $0F70, X : DEC : BPL .BRANCH_DELTA
        STZ.w $0F70, X
        STZ.w $0F80, X
        
        LDA.w $0DF0, X : BNE .BRANCH_EPSILON
            JMP.w StalfosKnight_EnterIdleState
        
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
StalfosKnight_Crumble_head_anim:
{
    db  0,  4,  8, 12, 14, 14, 14, 14
    db 14, 14, 14, 14, 14, 14, 14, 14
    db 14, 14, 14, 14, 14, 14, 14, 14
    db 14, 14, 15, 14, 12,  8,  4,  0
}

; $0F2C77-$0F2CD5 JUMP LOCATION
StalfosKnight_Crumble:
{
    JSR.w Sprite3_MoveXyz
    JSR.w Sprite3_CheckTileCollision
    
    LDA.w $0F80, X : CMP.b #$C0 : BMI .BRANCH_ALPHA
        SEC : SBC.b #$02 : STA.w $0F80, X
    
    .BRANCH_ALPHA
    
    LDA.w $0F70, X : DEC : BPL .BRANCH_BETA
        STZ.w $0F70, X
        STZ.w $0F80, X
        
    .BRANCH_BETA
    
    LDA.w $0DF0, X : BNE .BRANCH_GAMMA
        JSL.l GetRandomInt : AND.b #$01 : BNE .BRANCH_DELTA
            LDA.b #$07 : STA.w $0D80, X
            LDA.b #$50 : STA.w $0DF0, X
            
            RTS
        
        .BRANCH_DELTA
        
        JMP.w StalfosKnight_EnterIdleState
        
    .BRANCH_GAMMA
    
    CMP.b #$E0 : BCC .BRANCH_EPSILON
        PHA : AND.b #$03 : BNE .BRANCH_ZETA
            LDA.b #$14
            JSL.l Sound_SetSFX3PanLong
        
        .BRANCH_ZETA
        
        PLA
    
    .BRANCH_EPSILON
    
    LSR #3 : TAY
    LDA.w .head_anim, Y : STA.w $0DB0, X
    
    LDA.b #$03 : STA.w $0DC0, X
    LDA.b #$02 : STA.w $0EB0, X
    
    RTS
}

; ==============================================================================

; $0F2CD6-$0F2CD7 DATA
StalfosKnight_CelebrateStandingUp_animation_states:
{
    db 1, 4
}

; $0F2CD8-$0F2CEB JUMP LOCATION
StalfosKnight_CelebrateStandingUp:
{
    LDA.w $0DF0, X : BNE .delay
        JMP.w StalfosKnight_EnterIdleState
    
    .delay
    
    LSR : LSR : AND.b #$01 : TAY
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F2CEC-$0F2E03 DATA
StalfosKnight_Draw_OAM_groups:
{
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

; $0F2E04-$0F2E45 LOCAL
StalfosKnight_Draw:
{
    JSR.w Sprite3_PrepOamCoord
    JSR.w SpriteDraw_StalfosKnight_Head
    
    LDA.b #$00 : XBA
    LDA.w $0DC0, X
    
    REP #$20
    
    ASL #3 : STA.b $00
    ASL : ASL : ADC.b $00 : ADC.w #.OAM_groups : STA.b $08
    
    LDA.b $90 : CLC : ADC.w #$0004 : STA.b $90
    
    INC.b $92
    
    SEP #$20
    
    LDA.b #$05
    JSR.w Sprite3_DrawMultiple
    
    REP #$20
    
    LDA.b $90 : SEC : SBC.w #$0004 : STA.b $90
    
    DEC.b $92
    
    SEP #$20
    
    LDA.b #$12
    JSL.l Sprite_DrawShadowLong_variable
    
    RTS
}

; ==============================================================================

; $0F2E46-$0F2E4D DATA
Pool_SpriteDraw_StalfosKnight_Head:
{
    ; $0F2E4
    .chr
    db $66, $66, $46, $46
    
    ; $0F2E8
    .properties
    db $40, $00, $00, $00
}

; $0F2E4E-$0F2EA3 LOCAL
SpriteDraw_StalfosKnight_Head:
{
    LDA.w $0DC0, X : CMP.b #$02 : BEQ .dont_draw
        LDA.w $0DB0, X : STA.b $06
                         STZ.b $07
        
        LDY.b #$00
        
        PHX
        
        LDA.w $0EB0, X : TAX
        
        REP #$20
        
        LDA.b $00    : STA.b ($90), Y
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02 : CLC : ADC.b $06 : SEC : SBC.w #$000C : INY : STA.b ($90), Y
        CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen_y
            LDA.w #$00F0 : STA.b ($90), Y
        
        .on_screen_y
        
        SEP #$20
        
        LDA.w Pool_SpriteDraw_StalfosKnight_Head_chr, X : INY : STA.b ($90), Y

        LDA.w Pool_SpriteDraw_StalfosKnight_Head_properties, X
        INY : ORA.b $05 : STA.b ($90), Y
        
        TYA : LSR : LSR : TAY
        LDA.b #$02 : ORA.b $0F : STA.b ($92), Y
        
        PLX
    
    .dont_draw
    
    RTS
}

; ==============================================================================
