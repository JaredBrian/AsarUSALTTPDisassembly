; ==============================================================================

; Special Effect 0x08 - Debris from bombing a cave / wall open
; $041FB6-$041FD0 JUMP LOCATION
Ancilla_DoorDebris:
{
    JSR.w DoorDebris_Draw
    
    DEC.w $03C0, X : BPL .delay
        LDA.b #$07 : STA.w $03C0, X
        
        INC.w $03C2, X
        
        LDA.w $03C2, X : CMP.b #$04 : BNE .delay
            ; Self-terminate at this point.
            STZ.w $0C4A, X
        
    .delay
    
    RTS
}

; ==============================================================================

; $041FD1-$042090 DATA
Pool_DoorDebris_Draw:
{
    ; $041FD1
    .xy_offsets
    dw  4,  7,  3, 17,  8,  8,  7, 17
    dw 11,  7, 10, 16, 16,  7, 17, 17
    dw 20,  7, 21, 17, 16,  8, 17, 17
    dw 13,  7, 14, 16,  8,  7,  7, 17
    dw  7,  4, 17,  3,  8,  8, 17,  7
    dw  7, 11, 16, 10,  7, 16, 17, 17
    dw  7, 20, 17, 21,  8, 16, 17, 17
    dw  7, 13, 16, 14,  7,  8, 17,  7
    
    ; $042051
    .chr_and_properties
    db $5E, $20, $5E, $E0, $5E, $A0, $5E, $60
    db $4F, $20, $4F, $20, $4F, $20, $4F, $20
    db $5E, $60, $5E, $60, $5E, $20, $5E, $E0
    db $4F, $60, $4F, $60, $4F, $60, $4F, $60
    db $5E, $20, $5E, $E0, $5E, $A0, $5E, $60
    db $4F, $20, $4F, $E0, $4F, $20, $4F, $20
    db $5E, $60, $5E, $60, $5E, $20, $5E, $E0
    db $4F, $60, $4F, $60, $4F, $60, $4F, $60
}

; $042091-$042120 LOCAL JUMP LOCATION
DoorDebris_Draw:
{
    JSR.w Ancilla_PrepAdjustedOamCoord
    
    TXA : ASL : TAY
    
    REP #$20
    
    LDA.w $03BA, Y : SEC : SBC $E8 : STA $0C
    LDA.w $03B6, Y : SEC : SBC $E2 : STA $0E
    
    SEP #$20
    
    PHX
    
    STZ $06
    
    LDA.w $03C2, X : ASL #2 : STA $04 : STA $08
    
    LDA.w $03BE, X : ASL #4 : STA $0A
    
    CLC : ADC $04 : TAX
    
    LDY.b #$00
    
    .next_OAM_entry
        
        PHX
        
        LDA $0A : ASL : STA $04
        
        LDA $08 : ASL : CLC : ADC $04 : STA $04
        
        LDA $06 : ASL #2 : CLC : ADC $04 : TAX
        
        REP #$20
        
        ; The first entry in each interleaved pair is the y offset and the
        ; second is the x offset.
        LDA.w Pool_DoorDebris_Draw_xy_offsets+0, X : CLC : ADC $0C : STA $00
        LDA.w Pool_DoorDebris_Draw_xy_offsets+2, X : CLC : ADC $0E : STA $02
        
        SEP #$20
        
        PLX
        
        JSR.w Ancilla_SetOam_XY
        
        ; The second entry in each interleaved set is a property, and the first
        ; is a chr value.
        LDA.w Pool_DoorDebris_Draw_chr_and_properties + 0, X : STA ($90), Y
        INY

        LDA.w Pool_DoorDebris_Draw_chr_and_properties + 2, X
        AND.b #$C0 : ORA $65 : STA ($90), Y
        INY
        
        PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
        
        LDA.b #$00 : STA ($92), Y
        
        PLY : JSR.w Ancilla_CustomAllocateOam
        
        INX #2
    LDA $06 : INC : STA $06 : CMP.b #$02 : BNE .next_OAM_entry
    
    PLX
    
    RTS
}

; ==============================================================================

