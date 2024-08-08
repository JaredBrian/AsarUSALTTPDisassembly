
; ==============================================================================

; $044107-$044166 DATA
Pool_Ancilla_VictorySparkle:
{
    .y_offsets
    dw -7,  0,  0,  0, -11, -11, -3, -3
    dw -7, -7,  0,  0,  -7,   0,  0,  0
    
    .x_offsets
    dw 16,  0,  0,  0,  8, 16,  8, 16
    dw  9, 15,  0,  0, 12,  0,  0,  0
    
    .chr
    db $92, $FF, $FF, $FF, $93, $93, $93, $93
    db $F9, $F9, $FF, $FF, $80, $FF, $FF, $FF
    
    .properties
    db $00, $FF, $FF, $FF, $00, $40, $80, $C0
    db $00, $40, $FF, $FF, $00, $FF, $FF, $FF
}

; ==============================================================================

; $044167-$0441E3 JUMP LOCATION
Ancilla_VictorySparkle:
{
    ; Special object 0x3B (Victory Sparkle)
    
    !numSprites = $06
    
    LDA.w $03B1, X : BNE .delay
    
    DEC.w $039F, X : BPL .active
    
    LDA.b #$01 : STA.w $039F, X
    
    INC.w $0C5E, X : LDA.w $0C5E, X : CMP.b #$04 : BNE .active
    
    STZ.w $0C4A, X
    
    .delay
    
    DEC.w $03B1, X
    
    RTS
    
    .active
    
    PHX
    
    JSR.w Ancilla_PrepOamCoord
    
    LDA.b #$03 : STA !numSprites
    
    LDA.w $0C5E, X : ASL #2 : TAX
    
    LDY.b #$00
    
    .next_oam_entry
    
    LDA.w $C147, X : CMP.b #$FF : BEQ .skip_oam_entry
    
    REP #$20
    
    PHX : TXA : ASL A : TAX
    
    LDA.b $20 : CLC : ADC .y_offsets, X : SEC : SBC.b $E8 : STA.b $00
    LDA.b $22 : CLC : ADC .x_offsets, X : SEC : SBC.b $E2 : STA.b $02
    
    PLX
    
    SEP #$20
    
    JSR.w Ancilla_SetOam_XY
    
    LDA.w .chr, X                               : STA ($90), Y : INY
    LDA.w .properties, X : ORA.b #$04 : ORA.b $65 : STA ($90), Y : INY
    
    PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$00 : STA ($92), Y
    
    PLY
    
    .skip_oam_entry
    
    INX
    
    DEC !numSprites : BPL .next_oam_entry
    
    PLX
    
    RTS
}

; ==============================================================================
