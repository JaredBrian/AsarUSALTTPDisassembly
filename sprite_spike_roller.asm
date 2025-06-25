; ==============================================================================

; $028DD8-$028DDD DATA
Pool_Sprite_SpikeRoller:
{
    ; $028DD8
    .x_speeds
    db $F0, $10 ; Bleeds into the next block. Length 4
    
    ; $028DDA
    .y_speeds
    db $00, $00, $F0, $10
}

; $028DDE-$028E20 JUMP LOCATION
Sprite_SpikeRoller:
{
    LDA.w $0DE0, X : AND.b #$02 : STA.b $00
    
    ; Animation logic
    LDA.w $0E80, X : LSR : AND.b #$01 : ORA.b $00 : STA.w $0DC0, X
    
    JSR.w SpikeRoller_Draw
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_CheckDamage
    
    LDA.w $0DF0, X : BNE .dont_change_direction
        LDA.b #$70 : STA.w $0DF0, X
        
        LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
    
    .dont_change_direction
    
    LDY.w $0DE0, X
    
    LDA.w Pool_Sprite_SpikeRoller_x_speeds, Y : STA.w $0D50, X
    
    LDA.w Pool_Sprite_SpikeRoller_y_speeds, Y : STA.w $0D40, X
    
    JSR.w Sprite2_Move
    
    ; Step the animation counter.
    INC.w $0E80, X
    
    RTS
}

; ==============================================================================

; $028E21-$028EE2 DATA
Pool_SpikeRoller_Draw:
{
    ; $028E21
    .x_spacing
    dw 0,  0,  0,  0,  0,  0,  0,   0
    dw 0,  0,  0,  0,  0,  0,  0,   0
    dw 0, 16, 32, 48, 64, 80, 96, 112
    dw 0, 16, 32, 48, 64, 80, 96, 112
    
    ; $028E61
    .y_spacing
    dw 0, 16, 32, 48, 64, 80, 96, 112
    dw 0, 16, 32, 48, 64, 80, 96, 112
    dw 0,  0,  0,  0,  0,  0,  0,   0
    dw 0,  0,  0,  0,  0,  0,  0,   0
    
    ; $028EA1
    .chr
    db $8E, $9E, $9E, $9E, $9E, $9E, $9E, $8E
    db $8E, $9E, $9E, $9E, $9E, $9E, $9E, $8E
    db $88, $89, $89, $89, $89, $89, $89, $88
    db $88, $89, $89, $89, $89, $89, $89, $88
    
    ; $028EC1
    .vh_flip
    db $00, $00, $00, $80, $00, $00, $00, $80
    db $40, $40, $40, $C0, $40, $40, $40, $C0
    
    ; $028EE1
    .num_subsprites
    db 3, 7
}

; $028EE3-$028F53 LOCAL JUMP LOCATION
SpikeRoller_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDA.w $0DC0, X : ASL #3 : STA.b $06 : TAY
    
    LDA.w Pool_SpikeRoller_Draw_chr, Y : STA.b $08
    
    PHX
    
    ; Appears that this is the size selector for the spike roller.
    LDY.w $0D80, X
    
    LDX.w Pool_SpikeRoller_Draw_num_subsprites, Y
    LDY.b #$00
    
    .next_subsprite
        
        PHX
        
        TXA : CLC : ADC.b $06 : PHA
        
        ASL : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC Pool_SpikeRoller_Draw_x_spacing, X : STA ($90), Y
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02 : CLC : ADC Pool_SpikeRoller_Draw_y_spacing, X : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
            LDA.b #$F0 : STA ($90), Y
        
        .on_screen_y
        
        PLX
        
        ; After the first segment, the chr progession is specified by a table.
        LDA.b $08 : BNE .use_initial_segment_chr
            LDA.w Pool_SpikeRoller_Draw_chr, X
        
        .use_initial_segment_chr
        
        STZ.b $08
        
        INY : STA ($90), Y
        
        LDA.w Pool_SpikeRoller_Draw_vh_flip, X : ORA.b $05 : INY : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b #$02 : ORA.b $0F : STA ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .next_subsprite
    
    PLX
    
    RTS
}

; ==============================================================================
