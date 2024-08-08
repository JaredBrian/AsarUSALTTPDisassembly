
; ==============================================================================

; $046B3E-$046BE2 JUMP LOCATION
Ancilla_SomarianBlockDivide:
{
    DEC.w $03B1, X : BPL .full_divide_delay
    
    LDA.b #$03 : STA.w $03B1, X
    
    LDA.w $0C5E, X : INC A : STA.w $0C5E, X : CMP.b #$02 : BNE .full_divide_delay
    
    STZ.w $0C4A, X
    
    PHX
    
    JSR.w SomarianBlast_SpawnCentrifugalQuad
    
    PLX
    
    RTS
    
    .full_divide_delay
    
    JSR.w Ancilla_PrepAdjustedOamCoord
    
    LDY.b #$00
    
    ; WTF: Where is this variable actually initialized or  set for this
    ; object?
    LDA.w $0380, X : CMP.b #$03 : BNE .unsigned_player_altitude
    
    LDA.b $24 : CMP.b #$FF : BNE .positive_player_altitude
    
    .unsigned_player_altitude
    
    LDA.b #$00
    
    .positive_player_altitude
    
    CLC : ADC.w $029E, X : STA.b $04 : BPL .positive_object_altitude
    
    LDY.b #$FF
    
    .positive_object_altitude
    
    STY.b $05
    
    REP #$20
    
    LDA.b $04 : EOR.w #$FFFF : INC A : CLC : ADC.b $00 : STA.b $04
    
    LDA.b $02 : STA.b $06
    
    SEP #$20
    
    PHX
    
    LDA.w $0C5E, X : ASL #3 : TAX
    
    LDY.b #$00 : STY.b $08
    
    .next_oam_entry
    
    REP #$20
    
    PHX : TXA : ASL A : TAX
    
    LDA.b $04 : CLC : ADC .y_offsets, X : STA.b $00
    LDA.b $06 : CLC : ADC .x_offsets, X : STA.b $02
    
    PLX
    
    SEP #$20
    
    JSR.w Ancilla_SetOam_XY
    
    LDA.w .chr, X                               : STA ($90), Y : INY
    LDA.w .properties, X : AND.b #$CF : ORA.b $65 : STA ($90), Y : INY
    
    PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$00 : STA ($92), Y
    
    PLY : INX
    
    INC.b $08 : LDA.b $08 : CMP.b #$08 : BNE .next_oam_entry
    
    PLX
    
    RTS
}

; ==============================================================================
