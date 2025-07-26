; ==============================================================================

; $0F195B-$0F196B JUMP LOCATION
Sprite_FluteBoyOstrich:
{
    JSR.w FluteBoyOstrich_Draw
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw FluteBoyOstrich_Chillin ; 0x00 - $996C
    dw FluteBoyOstrich_RunAway ; 0x01 - $9991
}

; ==============================================================================

; $0F196C-$0F198C JUMP LOCATION
FluteBoyOstrich_Chillin:
{
    LDY.b #$00
    
    LDA.b $1A : AND.b #$18 : BEQ .default_animation_state
        LDY.b #$03
    
    .default_animation_state
    
    TYA : STA.w $0DC0, X
    
    LDA.w $0FDD : BEQ .dont_run_away
        INC.w $0D80, X
        
        LDA.b #$F8 : STA.w $0D40, X
        
        LDA.b #$F0 : STA.w $0D50, X
    
    .dont_run_away
    
    RTS
}

; ==============================================================================

; $0F198D-$0F1990 DATA
FluteBoyOstrich_RunAway_animation_states:
{
    db $00, $01, $00, $02
}

; $0F1991-$0F19CA JUMP LOCATION
FluteBoyOstrich_RunAway:
{
    JSR.w Sprite3_MoveXyz
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .dont_hop_yet
        LDA.b #$20 : STA.w $0F80, X
        
        STZ.w $0F70, X
        
        STZ.w $0E80, X
        
        STZ.w $0D90, X
        
    .dont_hop_yet
    
    INC.w $0E80, X
    LDA.w $0E80, X : AND.b #$07 : BNE .delay_animation_tick
        LDA.w $0D90, X : CMP.b #$03 : BEQ .animation_counter_maxed
            INC.w $0D90, X
        
        .animation_counter_maxed
    .delay_animation_tick
    
    LDY.w $0D90, X
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F19CB-$0F1A4A DATA
FluteBoyOstrich_Draw_OAM_groups:
{
    dw -4, -8 : db $80, $00, $00, $02
    dw  4, -8 : db $81, $00, $00, $02
    dw -4,  8 : db $A3, $00, $00, $02
    dw  4,  8 : db $A4, $00, $00, $02
    
    dw -4, -8 : db $80, $00, $00, $02
    dw  4, -8 : db $81, $00, $00, $02
    dw -4,  8 : db $A0, $00, $00, $02
    dw  4,  8 : db $A1, $00, $00, $02
    
    dw -4, -8 : db $80, $00, $00, $02
    dw  4, -8 : db $81, $00, $00, $02
    dw -4,  8 : db $83, $00, $00, $02
    dw  4,  8 : db $84, $00, $00, $02
    
    dw -4, -7 : db $80, $00, $00, $02
    dw  4, -7 : db $81, $00, $00, $02
    dw -4,  9 : db $A3, $00, $00, $02
    dw  4,  9 : db $A4, $00, $00, $02
}

; $0F1A4B-$0F1A6A LOCAL JUMP LOCATION
FluteBoyOstrich_Draw:
{
    LDA.b #$00 : XBA
    LDA.w $0DC0, X
    
    REP #$20
    
    ASL #5 : ADC.w #(.OAM_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$04
    JSR.w Sprite3_DrawMultiple
    
    LDA.b #$12
    JSL.l Sprite_DrawShadowLong_variable
    
    RTS
}

; ==============================================================================
