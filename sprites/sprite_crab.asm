; ==============================================================================

; $0294AF-$0294B4 DATA
Pool_Sprite_Crab:
{
    ; $0294AF
    .x_speeds
    db $1C, $E4
    
    ; $0294B1
    .y_speeds
    db $00, $00, $0C, $F4
}

; $0294B5-$0294FF JUMP LOCATION
Sprite_Crab:
{
    JSR.w Crab_Draw
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_CheckIfRecoiling
    JSR.w Sprite2_CheckDamage
    JSR.w Sprite2_Move
    
    JSR.w Sprite2_CheckTileCollision : BNE .collided
        LDA.w $0DF0, X : BNE .dont_change_direction
    
    .collided
    
    JSL.l GetRandomInt : AND.b #$3F : ADC.b #$20 : STA.w $0DF0, X
    
    AND.b #$03 : STA.w $0DE0, X
    
    .dont_change_direction
    
    LDY.w $0DE0, X
    
    LDA Pool_Sprite_Crab_x_speeds, Y : STA.w $0D50, X
    
    LDA Pool_Sprite_Crab_y_speeds, Y : STA.w $0D40, X
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR
    
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
    ; $029500
    .x_offsets
    dw -8, 8
    dw -8, 8
    
    ; $029504
    .chr
    db $8E, $8E
    db $AE, $AE
    
    ; $029508
    .vh_flip
    db $00, $40
    db $00, $40
}

; $029510-$02956C LOCAL JUMP LOCATION
Crab_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDA.w $0DC0, X : ASL : STA.b $06
    
    PHX
    
    LDX.b #$01
    
    .next_subsprite
        
        PHX
        
        TXA : CLC : ADC.b $06 : PHA : ASL : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC Pool_Crab_Draw_x_offsets, X : STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02 : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .alpha
            LDA.b #$F0 : STA ($90), Y
        
        .alpha
        
        PLX
        
        LDA Pool_Crab_Draw_chr, X                 : INY : STA ($90), Y
        LDA Pool_Crab_Draw_vh_flip, X : ORA.b $05 : INY : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b #$02 : ORA.b $0F : STA ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .next_subsprite
    
    PLX
    
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
