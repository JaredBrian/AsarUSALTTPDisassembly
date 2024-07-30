
; ==============================================================================

; $035892-$035899 DATA
Pool_Sprite_Buzzblob:
{
    .animation_states
    db 0, 1, 0, 2
    
    .buzz_palettes
    db $0A, $02, $08, $02
}

; ==============================================================================

; $03589A-$0358ED JUMP LOCATION
Sprite_Buzzblob:
{
    LDA.w $0E00, X : BEQ .not_buzzing
    
    LSR A : AND.b #$03 : TAY
    
    LDA.w $0B89, X : AND.b #$F1 : ORA.w $D896, Y : STA.w $0B89, X
    
    .not_buzzing
    
    JSL Sprite_Cukeman
    JSR BuzzBlob_Draw
    
    LDA.w $0E80, X : LSR #3 : AND.b #$03 : TAY
    
    LDA .animation_states, Y
    
    LDY.w $0E00, X : BEQ .use_nonbuzzing_animation_states
    
    INC #3
    
    .use_nonbuzzing_animation_states
    
    STA.w $0DC0, X
    
    JSR Sprite_CheckIfActive
    JSR Sprite_CheckIfRecoiling
    
    INC.w $0E80, X
    
    LDA.w $0DF0, X : BNE .change_direction_delay
    
    JSR Buzzblob_SelectNewDirection
    
    .change_direction_delay
    
    LDA.w $0E00, X : BNE .cant_move_when_buzzing
    
    JSR Sprite_Move
    
    .cant_move_when_buzzing
    
    JSR Sprite_CheckTileCollision
    JSR Sprite_WallInducedSpeedInversion
    JMP Sprite_CheckDamage
}

; ==============================================================================

; $0358EE-$035905 DATA
Pool_Buzzblob_SelectNewDirection:
{
    .x_speeds
    db  3,  2, -2, -3, -2,  2,  0,  0
    
    .y_speeds
    db  0,  2,  2,  0, -2, -2,  0,  0
    
    .timers
    db 48, 48, 48, 48, 48, 48, 64, 64
}

; ==============================================================================

; $035906-$03591F LOCAL JUMP LOCATION
Buzzblob_SelectNewDirection:
{
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA.w $D8EE, Y : STA.w $0D50, X
    
    LDA.w $D8F6, Y : STA.w $0D40, X
    
    LDA.w $D8FE, Y : STA.w $0DF0, X
    
    RTS
}

; ==============================================================================

; $035920-$035952 DATA
Pool_Buzzblob_Draw:
{
    .x_offsets
    dw 0, 8, 0
    
    .y_offsets
    dw -8, -8, 0
    
    .chr
    db $F0, $F0, $E1
    db $00, $00, $CE
    db $00, $00, $CE
    db $E3, $E3, $CA
    db $E4, $E5, $CC
    db $E5, $E4, $CC
    
    .properties
    db $00, $40, $00
    db $00, $00, $00
    db $00, $00, $40
    db $00, $40, $00
    db $00, $00, $00
    db $40, $40, $40
    
    .oam_sizes
    db $00, $00, $02
}

; ==============================================================================

; $035953-$0359BF LOCAL JUMP LOCATION
BuzzBlob_Draw:
{
    JSR Sprite_PrepOamCoord
    
    PHX
    
    LDA.w $0DC0, X : ASL A : ADC.w $0DC0, X : STA.b $06
    
    LDX.b #$02
    
    .next_oam_entry
    
    PHX
    
    TXA : ASL A : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC .x_offsets, X : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : CLC : ADC .y_offsets, X : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
    
    LDA.b #$F0 : STA ($90), Y
    
    .on_screen_y
    
    PLX : PHX
    
    TXA : CLC : ADC.b $06 : TAX
    
    INY
    
    LDA .chr, X : STA ($90), Y : BNE .dont_skip_oam_entry
    
    DEY
    
    LDA.b #$F0 : STA ($90), Y
    
    INY
    
    .dont_skip_oam_entry
    
    LDA .properties, X : ORA.b $05 : INY : STA ($90), Y
    
    PLX
    
    PHY
    
    TYA : LSR #2 : TAY
    
    LDA .oam_sizes, X : ORA.b $0F : STA ($92), Y
    
    PLY : INY
    
    DEX : BPL .next_oam_entry
    
    PLX
    
    JMP Sprite_DrawShadow
}

; ==============================================================================
