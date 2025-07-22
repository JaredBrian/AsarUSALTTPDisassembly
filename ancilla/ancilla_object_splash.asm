; ==============================================================================

; $044987-$0449CC DATA
Pool_Ancilla_ObjectSplash_Draw:
{
    ; $044987
    .char
    db $C0, $FF
    db $E7, $FF
    db $AF, $BF
    db $80, $80
    db $83, $83

    ; $044991
    .prop
    db $00, $FF
    db $00, $FF
    db $40, $00
    db $40, $00
    db $C0, $80

    ; $04499B
    .offset_x
    dw   0,   0
    dw  -6,   0
    dw -13,  -8
    dw -17,  -4
    dw -17,  -4

    ; $0449AF
    .offset_y
    dw   0,   0
    dw   0,   0
    dw  11,  -3
    dw  15,  -7
    dw  15,  -7

    ; $0449C3
    .size
    db $02, $FF
    db $02, $FF
    db $00, $00
    db $00, $00
    db $00, $00
}

; ==============================================================================

; Turn the current effect into a splash effect (0x3D).
; The rest of the routine initializes the new effect.
; $0449CD-$044A00 BRANCH LOCATION
Ancilla_TransmuteToObjectSplash:
{
    LDA.b #$3D : STA.w $0C4A, X
    
    STZ.w $0C5E, X
    
    LDA.b #$06 : STA.w $0C68, X
    
    LDA.w $0BFA, X : CLC : ADC.b #$0C : STA.w $0BFA, X
    LDA.w $0C0E, X       : ADC.b #$00 : STA.w $0C0E, X
    
    LDA.w $0C04, X : CLC : ADC.b #$F8 : STA.w $0C04, X
    LDA.w $0C18, X       : ADC.b #$FF : STA.w $0C18, X
    
    LDA.b #$28 : JSR.w Ancilla_DoSfx2

    ; Bleeds into the next function.
}
    
; $044A01-$044A21 LOCAL JUMP LOCATION
Ancilla_ObjectSplash:
{
    LDA.b #$08
    
    JSR.w Ancilla_AllocateOam
    
    LDA.b $11 : BNE Ancilla_ObjectSplash_Draw
        LDA.w $0C68, X : BNE .Ancilla_ObjectSplash_Draw
            LDA.b #$06 : STA.w $0C68, X
            
            INC.w $0C5E, X
            LDA.w $0C5E, X : CMP.b #$05 : BNE Ancilla_ObjectSplash_Draw
                STZ.w $0C4A, X
                
                RTS
}
    
; $044A22-$044A84 LOCAL JUMP LOCATION
Ancilla_ObjectSplash_Draw:
{
    JSR.w Ancilla_PrepOamCoord
    
    REP #$20
    
    LDA.b $00 : STA.b $04
    LDA.b $02 : STA.b $06
    
    SEP #$20
    
    PHX
    
    LDY.b #$00
    
    STZ.b $0C
    
    LDA.w $0C5E, X : ASL : TAX
    
    .next_OAM_entry
    
        LDA.w Pool_Ancilla_ObjectSplash_Draw_char, X : CMP.b #$FF : BEQ .skip_OAM_entry
            PHX : TXA : ASL : TAX
            
            REP #$20
            
            LDA.w Pool_Ancilla_ObjectSplash_offset_x, X : CLC : ADC.b $04 : STA.b $00
            LDA.w Pool_Ancilla_ObjectSplash_offset_y, X : CLC : ADC.b $06 : STA.b $02
            
            SEP #$20
            
            PLX
            
            JSR.w Ancilla_SetOam_XY
            
            LDA.w Pool_Ancilla_ObjectSplash_char, X              : STA.b ($90), Y
            INY
            
            LDA.w Pool_Ancilla_ObjectSplash_prop, X : ORA.b #$24 : STA.b ($90), Y
            INY
            
            PHY : TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
            
            LDA.w Pool_Ancilla_ObjectSplash_size, X : STA.b ($92), Y
            
            PLY
        
        .skip_OAM_entry
        
        INX
    INC.b $0C : LDA.b $0C : CMP.b #$02 : BNE .next_OAM_entry
    
    PLX
    
    RTS
}

; ==============================================================================
