; ==============================================================================

; $0428E3-$0428E4 JUMP LOCATION
Ancilla_Unused_25:
Ancilla_HitStars_chr:
{
    db $90, $91
}

; Special object 0x16 - hammer stars
; $0428E5-$042996 ALTERNATE ENTRY POINT
Ancilla_HitStars:
{
    DEC.w $039F, X : BMI .begin_doing_stuff
        ; Do nothing for the first couple frames, not even drawing.
        RTS
    
    .begin_doing_stuff
    
    STZ.w $039F, X
    
    LDA $11 : BNE .just_draw
        DEC.w $03B1, X : BPL .delay
            STZ.w $03B1, X
            
            LDA.b #$01 : STA.w $0C5E, X
        
        .delay
        
        LDA.w $0C5E, X : BEQ .just_draw
            LDA.w $0C22, X : CLC : ADC.b #$FC : STA.w $0C22, X : STA.w $0C2C, X
            
            CMP.b #$E8 : BCS .dont_self_terminate
                STZ.w $0C4A, X
                
                RTS
            
            .dont_self_terminate
            
            JSR.w Ancilla_MoveVert
            JSR.w Ancilla_MoveHoriz
    
    .just_draw
    
    JSR.w Ancilla_PrepOamCoord
    
    LDA.w $0C04, X : STA $06
    LDA.w $0C18, X : STA $07
    
    LDA.w $038A, X : STA $72
    LDA.w $038F, X : STA $73
    
    REP #$20
    
    LDA $72 : SEC : SBC $06 : STA $08
    
    LDA $72 : CLC : ADC $08 : SEC : SBC.w #$0008 : SEC : SBC $E2 : STA $08
    
    SEP #$20
    
    LDA.w $0C54, X : CMP.b #$02 : BNE .dont_alter_oam_allocation
        LDA.b #$08 : JSR.w Ancilla_AllocateOam_B_or_E
    
    .dont_alter_oam_allocation
    
    PHX
    
    LDA.b #$01 : STA $72
    
    LDA.w $0C5E, X : TAX
    
    LDY.b #$00 : STY $73
    
    .next_oam_entry
    
        JSR.w Ancilla_SetOam_XY
        
        LDA.w .chr, X : STA ($90), Y : INY
        
        LDA.b #$04 : ORA $65 : ORA $73 : STA ($90), Y : INY
        
        PHY
        
        TYA : SEC : SBC.b #$04 : LSR #2 : TAY
        
        LDA.b #$00 : STA ($92), Y
        
        PLY
        
        JSR.w HitStars_UpdateOamBufferPosition
        
        ; Adjust the hflip on the second iteration.
        LDA.b #$40 : STA $73
        
        ; Use a different x coordinate on the second iteration. (One which
        ; is in a different direction from the first).
        LDA $08 : STA $02
    DEC $72 : BPL .next_oam_entry
    
    PLX
    
    RTS
}

; ==============================================================================
