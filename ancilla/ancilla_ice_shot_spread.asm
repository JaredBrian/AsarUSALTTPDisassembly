
; ==============================================================================

; $042536-$042550 JUMP LOCATION
Ancilla_IceShotSpread:
    
    DEC.w $03B1, X : BPL .delay
    
    LDA.b #$07 : STA.w $03B1, X
    
    INC.w $0C5E, X : LDA.w $0C5E, X : CMP.b #$02 : BNE .delay
    
    ; The ice shot self-terminates after it's done spreading.
    STZ.w $0C4A, X
    
    RTS
    
    .delay
    
    BRL IceShotSpread_Draw
}

; ==============================================================================

; $042551-$042570 DATA
Pool_IceShotSpread_Draw:
{
    .chr_and_properties
    db $CF, $24
    db $CF, $24
    db $CF, $24
    db $CF, $24
    db $DF, $24
    db $DF, $24
    db $DF, $24
    db $DF, $24
    
    .offsets_xy
    db  0,  0,  0,  8
    db  8,  0,  8,  8
    
    db -8, -8, -8, 16
    db 16, -8, 16, 16
}

; ==============================================================================

; $042571-$04260D LONG BRANCH LOCATION
IceShotSpread_Draw:
{
    JSR.w Ancilla_PrepOamCoord
    
    PHX
    
    ; Load the amount of OAM ram this object needs.
    LDA.w $0C90, X
    
    JSR.w Ancilla_AllocateOam
    
    LDA.w $0C5E, X : ASL #3 : TAX
    
    LDY.b #$00
    
    STZ $04
    
    .next_oam_entry
    
    REP #$20
    
    ; The x offsets
    LDA.w .offsets_xy, X
    
    AND.w #$00FF : CMP.w #$0080 : BCC .no_x_sign_extend
    
    ORA.w #$FF00
    
    .no_x_sign_extend
    
    CLC : ADC $00 : STA $08
    
    ; The y offsets
    LDA.w .offsets_xy+1, X
    
    AND.w #$00FF : CMP.w #$0080 : BCC .no_y_sign_extend
    
    ORA.w #$FF00
    
    .no_y_sign_extend
    
    CLC : ADC $02 : STA $0A
    
    SEP #$20
    
    PHX
    
    LDX.b #$F0
    
    LDA $09 : BNE .off_screen
    
    LDA $0B : BNE .off_screen
    
    LDA $0A : STA ($90), Y
    
    LDA $08 : CMP.b #$F0 : BCS .off_screen
    
    TAX
    
    .off_screen
    
    INY
    
    TXA : STA ($90), Y : INY
    
    PLX
    
    LDA.w .chr_and_properties,   X                        : STA ($90), Y : INY
    LDA.w .chr_and_properties+1, X : AND.b #$CF : ORA $65 : STA ($90), Y
    
    INY : PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    ; Use small sprites always.
    LDA.b #$00 : STA ($92), Y
    
    PLY : JSR.w Ancilla_CustomAllocateOam
    
    INX #2
    
    INC $04
    
    LDA $04 : CMP.b #$04 : BEQ .done_drawing
    
    BRL .next_oam_entry
    
    .done_drawing
    
    PLX
    
    LDY.b #$01
    
    LDA ($90), Y : CMP.b #$F0 : BNE .not_off_screen
    
    LDY.b #$05
    
    LDA ($90), Y : CMP.b #$F0 : BNE .not_off_screen
    
    ; Self terminate off screen.
    STZ.w $0C4A, X
    
    .not_off_screen
    
    RTS
}

; ==============================================================================
