
; ==============================================================================

; $0441E4-$0441E9 DATA
Pool_Ancilla_SwordChargeSpark:
{
    .chr
    db $B7, $80, $83
    
    .properties
    db $04, $04, $84
}

; ==============================================================================

; $0441EA-$04422E JUMP LOCATION
Ancilla_SwordChargeSpark:
{
    LDA.b $11 : BNE .draw
    
    LDA.w $0C68, X : BNE .draw
    
    LDA.b #$04 : STA.w $0C68, X
    
    INC.w $0C5E, X : LDA.w $0C5E, X : CMP.b #$03 : BNE .dont_self_terminate
    
    STZ.w $0C4A, X
    
    RTS
    
    .draw
    .dont_self_terminate
    
    PHX
    
    LDA.b #$04
    
    JSR.w Ancilla_AllocateOam
    
    TYA : STA.w $0C86, X
    
    JSR.w Ancilla_PrepOamCoord
    
    LDA.w $0C5E, X : TAX
    
    LDY.b #$00
    
    JSR.w Ancilla_SetOam_XY
    
    LDA.w .chr, X                  : STA ($90), Y : INY
    LDA.w .properties, X : ORA.b $65 : STA ($90), Y
    
    LDA.b #$00 : STA ($92)
    
    PLX
    
    RTS
}

; ==============================================================================
