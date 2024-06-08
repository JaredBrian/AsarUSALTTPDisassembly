
; ==============================================================================

; $0294AF-$0294B4 DATA
Pool_Sprite_Crab:
{
    .x_speeds
    db $1C, $E4
    
    .y_speeds
    db $00, $00, $0C, $F4
}

; ==============================================================================

; $0294B5-$0294FF JUMP LOCATION
Sprite_Crab:
{
    JSR Crab_Draw
    JSR Sprite2_CheckIfActive
    JSR Sprite2_CheckIfRecoiling
    JSR Sprite2_CheckDamage
    JSR Sprite2_Move
    
    JSR Sprite2_CheckTileCollision : BNE .collided
    
    LDA.w $0DF0, X : BNE .dont_change_direction
    
    .collided
    
    JSL GetRandomInt : AND.b #$3F : ADC.b #$20 : STA.w $0DF0, X
    
    AND.b #$03 : STA.w $0DE0, X
    
    .dont_change_direction
    
    LDY.w $0DE0, X
    
    LDA .x_speeds, Y : STA.w $0D50, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR A
    
    CPY.b #$02 : BCC .moving_horizontally
    
    LSR #2
    
    .moving_horizontally
    
    AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $029500-$02950F DATA
Pool_Crab_Draw:
{
    .x_offsets
    dw -8, 8
    
    dw -8, 8
    
    .chr
    db $8E, $8E
    
    db $AE, $AE
    
    .vh_flip
    db $00, $40
    
    db $00, $40
}

; ==============================================================================

; $029510-$02956C LOCAL JUMP LOCATION
Crab_Draw:
{
    JSR Sprite2_PrepOamCoord
    
    LDA.w $0DC0, X : ASL A : STA.b $06
    
    PHX
    
    LDX.b #$01
    
    .next_subsprite
    
    PHX
    
    TXA : CLC : ADC.b $06 : PHA : ASL A : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC .x_offsets, X : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .alpha
    
    LDA.b #$F0 : STA ($90), Y
    
    .alpha
    
    PLX
    
    LDA .chr, X               : INY : STA ($90), Y
    LDA .vh_flip, X : ORA.b $05 : INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b #$02 : ORA.b $0F : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .next_subsprite
    
    PLX
    
    JSL Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
