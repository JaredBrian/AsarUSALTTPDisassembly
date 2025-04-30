; ==============================================================================

; $0EDC72-$0EDC79 LONG JUMP LOCATION
Sprite_VultureLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_Vulture
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EDC7A-$0EDC9B LOCAL JUMP LOCATION
Sprite_Vulture:
{
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSR.w Vulture_Draw
    JSR.w Sprite4_CheckIfActive
    JSR.w Sprite4_CheckIfRecoiling
    JSR.w Sprite4_CheckDamage
    JSR.w Sprite4_Move
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Vulture_Dormant  ; 0x00 - $DC9C
    dw Vulture_Circling ; 0x01 - $DCB9
}

; ==============================================================================

; $0EDC9C-$0EDCB4 JUMP LOCATION
Vulture_Dormant:
{
    INC.w $0E80, X : LDA.w $0E80, X : CMP.b #$A0 : BNE .activation_delay
        INC.w $0D80, X
        
        LDA.b #$1E : JSL.l Sound_SetSfx3PanLong
        
        LDA.b #$10 : STA.w $0DF0, X
    
    .activation_delay
    
    RTS
}

; ==============================================================================

; $0EDCB5-$0EDCB8 DATA
Vulture_Circling_animation_states:
{
    db 1, 2, 3, 2
}

; $0EDCB9-$0EDD1D JUMP LOCATION
Vulture_Circling:
{
    LDA.b $1A : LSR A : AND.b #$03 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0DF0, X : BEQ .finished_ascending
        INC.w $0F70, X
        
        RTS
    
    .finished_ascending
    
    TXA : EOR.b $1A : AND.b #$01 : BNE .dont_adjust_xy_speeds
        TXA : AND.b #$0F : CLC : ADC.b #$18
        
        JSL.l Sprite_ProjectSpeedTowardsPlayerLong
        
        LDA.b $00 : EOR.b #$FF : INC A : STA.w $0D50, X
        
        LDA.b $01 : STA.w $0D40, X
        
        LDA.b $0E : CLC : ADC.b #$28 : CMP.b #$50 : BCS .too_far_from_player
            LDA.b $0F : CLC : ADC.b #$28 : CMP.b #$50 : BCS .too_far_from_player
        
    .dont_adjust_xy_speeds
    
    RTS
    
    .too_far_from_player
    
    ; This mess o' logic keep the vulture from going too far from the
    ; player by apparently reversing somewhat...
    LDA.b $00 : ASL.b $00 : PHP : ROR A : PLP
    ROR A : CLC : ADC.w $0D40, X : STA.w $0D40, X
    
    LDA.b $01 : ASL.b $01 : PHP : ROR A : PLP
    ROR A : CLC : ADC.w $0D50, X : STA.w $0D50, X
    
    RTS
}

; ==============================================================================

; $0EDD1E-$0EDD5D DATA
Vulture_Draw_OAM_groups:
{
    dw -8,  0 : db $86, $00, $00, $02
    dw  8,  0 : db $86, $40, $00, $02
    
    dw -8,  0 : db $80, $00, $00, $02
    dw  8,  0 : db $80, $40, $00, $02
    
    dw -8,  0 : db $82, $00, $00, $02
    dw  8,  0 : db $82, $40, $00, $02
    
    dw -8,  0 : db $84, $00, $00, $02
    dw  8,  0 : db $84, $40, $00, $02
}

; $0EDD5E-$0EDD7A LOCAL JUMP LOCATION
Vulture_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : REP #$20 : ASL #4 : ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JSR.w Sprite4_DrawMultiple
    
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
