
; ==============================================================================

; \unused(suspected, but not fully confirmed yet)
; $0D79E6-$0D7A0B LONG JUMP LOCATION
Cukeman_Unused:
{
    LDY.b #$00
    
    CMP.b #$00 : BPL .sign_extend
    
    DEY
    
    .sign_extend
    
          CLC : ADC.w $0FDA : STA.w $0FDA
    TYA : ADC.w $0FDB : STA.w $0FDB
    
    LDA.w $0F50, X : PHA
    
    JSL Sprite_Cukeman
    
    PLA : STA.w $0F50, X
    
    JSL Sprite_Get_16_bit_CoordsLong
    
    RTL
}

; ==============================================================================

; $0D7A0C-$0D7A7D LONG JUMP LOCATION
Sprite_Cukeman:
{
    LDA.w $0EB0, X : BEQ .not_transformed
    
    LDA.w $0DD0, X : CMP.b #$09 : BNE .dont_speak
    
    LDA.b $11 : ORA.w $0FC1 : BNE .dont_speak
    
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.b $22 : CLC : ADC.w #$0018 : CMP.w #$0030 : BCS .dont_speak
    
    LDA.b $20 : SEC : SBC.w $0FDA : CLC : ADC.w #$0020 : CMP.w #$0030 : BCS .dont_speak
    
    SEP #$20
    
    LDA.b $F6 : BPL .dont_speak
    
    LDA.w $0E30, X : INC.w $0E30, X : AND.b #$01
    
    CLC : ADC.b #$7A : STA.w $1CF0
    LDA.b #$01 : STA.w $1CF1
    
    JSL Sprite_ShowMessageMinimal
    
    .dont_speak
    
    SEP #$20
    
    PHB : PHK : PLB
    
    LDA.w $0F50, X : AND.b #$F0 : PHA
    
    ORA.b #$08 : STA.w $0F50, X
    
    JSR Cukeman_Draw
    
    PLA : ORA.b #$0D : STA.w $0F50, X
    
    LDA.b #$10 : JSL OAM_AllocateFromRegionA
    
    PLB
    
    RTL
    
    .not_transformed
    
    RTL
}

; ==============================================================================

; $0D7A7E-$0D7B0D DATA
Pool_Cukeman_Draw:
{
    dw  0,  0 : db $F3, $01, $00, $00
    dw  7,  0 : db $F3, $41, $00, $00
    dw  4,  7 : db $E0, $07, $00, $00
    
    dw -1,  2 : db $F3, $01, $00, $00
    dw  6,  1 : db $F3, $41, $00, $00
    dw  4,  8 : db $E0, $07, $00, $00
    
    dw  1,  1 : db $F3, $01, $00, $00
    dw  8,  2 : db $F3, $41, $00, $00
    dw  4,  8 : db $E0, $07, $00, $00
    
    dw -2,  0 : db $F3, $01, $00, $00
    dw 10,  0 : db $F3, $41, $00, $00
    dw  4,  7 : db $E0, $07, $00, $00
    
    dw  0,  0 : db $F3, $01, $00, $00
    dw  8,  0 : db $F3, $41, $00, $00
    dw  4,  6 : db $E0, $07, $00, $00
    
    dw -5,  0 : db $F3, $01, $00, $00
    dw 16,  0 : db $F3, $41, $00, $00
    dw  4,  8 : db $E0, $07, $00, $00
}

; ==============================================================================

; $0D7B0E-$0D7B2B LOCAL JUMP LOCATION
Cukeman_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : REP #$20 : ASL #3 : STA.b $00
    
    ASL A : ADC.b $00 : ADC.w #.oam_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$03 : JSL Sprite_DrawMultiple
    
    RTS
}

; ==============================================================================
