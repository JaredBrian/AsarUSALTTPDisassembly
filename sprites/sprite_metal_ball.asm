; ==============================================================================

; Metal Balls in Eastern Palace (needs official name).
; $02B648-$02B687 JUMP LOCATION
Sprite_MetalBall:
{
    LDA.w $0D80, X : BNE .is_larger_ball
        JSL.l Sprite_PrepAndDrawSingleLargeLong
        
        BRA .moving_on
    
    .is_larger_ball
    
    JSR.w MetalBall_Draw
    
    .moving_on
    
    JSR.w Sprite2_CheckIfActive
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR #2 : AND.b #$01 : STA.w $0DC0, X
    
    JSR.w Sprite2_Move
    
    LDA.w $0DF0, X : BEQ .termination_timer_not_running
        DEC : BNE .dont_self_terminate
            STZ.w $0DD0, X
        
        .dont_self_terminate
        
        RTS
        
    .termination_timer_not_running
    
    JSR.w Sprite2_CheckDamage
    
    LDA.w $0E10, X : BNE .dont_start_timer
        JSR.w Sprite2_CheckTileCollision : BEQ .dont_start_timer
            LDA.b #$10 : STA.w $0DF0, X
    
    .dont_start_timer
    
    RTS
}

; ==============================================================================

; $02B688-$02B6A3 DATA
Pool_MetalBall_DrawLargerVariety:
{
    ; $02B688
    .x_offsets
    dw -8,  8, -8,  8
    
    ; $02B690
    .y_offsets
    dw -8, -8,  8,  8
    
    ; $02B698
    .chr
    db $84, $88, $88, $88
    db $86, $88, $88, $88
    
    ; $02B6A0
    .vh_flip
    db $00, $00, $C0, $80
}

; $02B6A4-$02B702 LOCAL JUMP LOCATION
MetalBall_DrawLargerVariety:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDA.w $0DC0, X : ASL #2 : STA.b $06
    
    PHX
    
    LDX.b #$03
    
    .next_subsprite
    
        PHX
        
        PHX : TXA : ASL : TAX
        
        REP #$20
        
        LDA.b $00
        CLC : ADC Pool_MetalBall_DrawLargerVariety_x_offsets, X : STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02
        CLC : ADC Pool_MetalBall_DrawLargerVariety_y_offsets, X : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
            LDA.b #$F0 : STA ($90), Y
        
        .on_screen_y
        
        PLA : CLC : ADC.b $06 : TAX
        
        LDA.w Pool_MetalBall_DrawLargerVariety_properties, X : INY : STA ($90), Y
        
        PLX
        
        LDA.w Pool_MetalBall_DrawLargerVariety_vh_flip, X : INY : ORA.b $05 : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b $0F : ORA.b #$02 : STA ($92), Y
        
        PLY : INY
    DEX : BPL .next_subsprite
    
    PLX
    
    RTS
}

; ==============================================================================
