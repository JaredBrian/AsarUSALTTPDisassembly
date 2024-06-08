
; ==============================================================================

; $044987-$0449CC DATA
Pool_Ancilla_TransmuteToObjectSplash:
{
}

; ==============================================================================

; $0449CD-$044A84 LONG BRANCH LOCATION
Ancilla_TransmuteToObjectSplash:
{
    ; turn the current effect into a splash effect (0x3D)
    ; the rest of the routine initializes the new effect
    
    LDA.b #$3D : STA.w $0C4A, X
    
    STZ.w $0C5E, X
    
    LDA.b #$06 : STA.w $0C68, X
    
    LDA.w $0BFA, X : CLC : ADC.b #$0C : STA.w $0BFA, X
    LDA.w $0C0E, X : ADC.b #$00 : STA.w $0C0E, X
    
    LDA.w $0C04, X : CLC : ADC.b #$F8 : STA.w $0C04, X
    LDA.w $0C18, X : ADC.b #$FF : STA.w $0C18, X
    
    LDA.b #$28 : JSR Ancilla_DoSfx2
    
    ; $044A01 ALTERNATE ENTRY POINT
    shared Ancilla_ObjectSplash:
    
    LDA.b #$08
    
    JSR Ancilla_AllocateOam
    
    LDA.b $11 : BNE .draw
    
    LDA.w $0C68, X : BNE .draw
    
    LDA.b #$06 : STA.w $0C68, X
    
    INC.w $0C5E, X : LDA.w $0C5E, X : CMP.b #$05 : BNE .draw
    
    STZ.w $0C4A, X
    
    RTS
    
    ; $044A22 ALTERNATE ENTRY POINT
    .draw
    
    JSR Ancilla_PrepOamCoord
    
    REP #$20
    
    LDA.b $00 : STA.b $04
    LDA.b $02 : STA.b $06
    
    SEP #$20
    
    PHX
    
    LDY.b #$00
    
    STZ.b $0C
    
    LDA.w $0C5E, X : ASL A : TAX
    
    .next_oam_entry
    
    LDA.w $C987, X : CMP.b #$FF : BEQ .skip_oam_entry
    
    PHX : TXA : ASL A : TAX
    
    REP #$20
    
    LDA.w $C99B, X : CLC : ADC.b $04 : STA.b $00
    LDA.w $C9AF, X : CLC : ADC.b $06 : STA.b $02
    
    SEP #$20
    
    PLX
    
    JSR Ancilla_SetOam_XY
    
    LDA.w $C987, X              : STA ($90), Y : INY
    LDA.w $C991, X : ORA.b #$24 : STA ($90), Y : INY
    
    PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.w $C9C3, X : STA ($92), Y
    
    PLY
    
    .skip_oam_entry
    
    INX
    
    INC.b $0C : LDA.b $0C : CMP.b #$02 : BNE .next_oam_entry
    
    PLX
    
    RTS
}

; ==============================================================================
