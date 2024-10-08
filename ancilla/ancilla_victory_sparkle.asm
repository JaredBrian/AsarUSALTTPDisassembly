; ==============================================================================

; $044107-$044166 DATA
Pool_Ancilla_VictorySparkle:
{
    ; $044107
    .y_offsets
    dw -7,  0,  0,  0, -11, -11, -3, -3
    dw -7, -7,  0,  0,  -7,   0,  0,  0
    
    ; $044127
    .x_offsets
    dw 16,  0,  0,  0,  8, 16,  8, 16
    dw  9, 15,  0,  0, 12,  0,  0,  0
    
    ; $044147
    .chr
    db $92, $FF, $FF, $FF, $93, $93, $93, $93
    db $F9, $F9, $FF, $FF, $80, $FF, $FF, $FF
    
    ; $044157
    .properties
    db $00, $FF, $FF, $FF, $00, $40, $80, $C0
    db $00, $40, $FF, $FF, $00, $FF, $FF, $FF
}

!numSprites = $06

; Special object 0x3B (Victory Sparkle)
; $044167-$0441E3 JUMP LOCATION
Ancilla_VictorySparkle:
{
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
    
        LDA.w Pool_Ancilla_VictorySparkle_chr, X : CMP.b #$FF : BEQ .skip_oam_entry
            REP #$20
            
            PHX : TXA : ASL A : TAX
            
            LDA.b $20 : CLC : ADC Pool_Ancilla_VictorySparkle_y_offsets, X
            SEC : SBC.b $E8 : STA.b $00

            LDA.b $22 : CLC : ADC Pool_Ancilla_VictorySparkle_x_offsets, X
            SEC : SBC.b $E2 : STA.b $02
            
            PLX
            
            SEP #$20
            
            JSR.w Ancilla_SetOam_XY
            
            LDA.w Pool_Ancilla_VictorySparkle_chr, X : STA ($90), Y
            INY

            LDA.w Pool_Ancilla_VictorySparkle_properties, X
            ORA.b #$04 : ORA.b $65 : STA ($90), Y
            INY
            
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
