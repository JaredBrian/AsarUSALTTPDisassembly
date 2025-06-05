; ==============================================================================

; $02B703-$02B7DE JUMP LOCATION
Sprite_Armos:
{
    JSR.w Armos_Draw
    
    LDA.w $0EA0, X : BEQ .not_recoiling
        JSR.w Sprite2_ZeroVelocity
    
    .not_recoiling
    
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_MoveAltitude
    
    LDA.w $0F80, X : SEC : SBC.b #$02 : STA.w $0F80, X
    
    LDA.w $0F70, X : BPL .beta
        STZ.w $0F70, X
        STZ.w $0F80, X
        
        JSR.w Sprite2_ZeroVelocity
    
    .beta
    
    LDA.w $0D80, X : BEQ .gamma
        JMP .active
    
    .gamma
    
    LDA.w $0E60, X : ORA.b #$40 : STA.w $0E60, X
    
    LDY.w $0DF0, X : CPY.b #$01 : BNE .delta
        AND.b #$BF : STA.w $0E60, X
        
        INC.w $0D80, X
        
        ASL.w $0E40, X : LSR.w $0E40, X
        
        LDA.w $0E60, X : AND.b #$BF : STA.w $0E60, X
        
        LDA.b #$0B : STA.w $0F50, X
        
        RTS
    
    .delta
    
    TXA : EOR.b $1A : AND.b #$03 : BNE .epsilon
        REP #$20
        
        LDA.b $22 : SEC : SBC.w $0FD8 : CLC : ADC.w #$001F : CMP.w #$003E : BCS .epsilon
            ; OPTIMIZE: Can't you just do one 'CLC : ADC.w #$0038' ?
            LDA.b $20 : CLC : ADC.w #$0008 : SEC : SBC.w $0FDA
                        CLC : ADC.w #$0030 : CMP.w #$0058 : BCS .epsilon
                SEP #$20
                
                LDA.w $0DF0, X : BNE .epsilon
                    LDA.b #$30 : STA.w $0DF0, X
                    
                    LDA.b #$22 : JSL.l Sound_SetSfx2PanLong
    
    .epsilon
    
    SEP #$20
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .zeta
        JSL.l Sprite_NullifyHookshotDrag
        JSL.l Sprite_RepelDashAttackLong
    
    .zeta
    
    LDA.w $0DF0, X : BEQ .theta
        LSR : AND.b #$0E : EOR.w $0F50, X : STA.w $0F50, X
    
    .theta
    
    RTS
    
    .active
    
    JSR.w Sprite2_CheckDamage
    JSR.w Sprite2_CheckIfRecoiling
    JSR.w Sprite2_Move
    JSR.w Sprite2_CheckTileCollision
    
    LDA.w $0DF0, X : ORA.w $0F70, X : BNE .iota
        LDA.b #$08 : STA.w $0DF0, X
        
        LDA.b #$10 : STA.w $0F80, X
        
        LDA.b #$0C : JSL.l Sprite_ApplySpeedTowardsPlayerLong
        
    .iota
    
    RTS
}

; ==============================================================================

; $02B7DF-$02B7EE DATA
Armos_Draw_OAM_groups:
{
    dw 0, -16 : db $C0, $00, $00, $02
    dw 0,   0 : db $E0, $00, $00, $02
}

; $02B7EF-$02B809 LOCAL JUMP LOCATION
Armos_Draw:
{
    ; TODO: Find out why it would only prep sometimes. Does it use a
    ; different OAM region when it's not fully activated?
    LDA.w $0D80, X : BNE .use_low_priority_OAM_region
        JSR.w Sprite2_PrepOamCoord
    
    .use_low_priority_OAM_region
    
    REP #$20
    
    LDA.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JSR.w Sprite_DrawMultipleRedundantCall
    
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
