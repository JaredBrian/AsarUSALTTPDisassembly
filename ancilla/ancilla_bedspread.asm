
; ==============================================================================

; $044003-$044012 DATA
Pool_Ancilla_BedSpread:
{
    .chr
    db $0A, $0A, $0A, $0A
    db $0C, $0C, $0A, $0A
    
    .properties
    db $00, $60, $A0, $E0
    db $00, $60, $A0, $E0
}

; ==============================================================================

; $044013-$044090 JUMP LOCATION
Ancilla_BedSpread:
{
    JSR.w Ancilla_PrepOamCoord
    
    REP #$20
    
    LDA $00 : STA $04
    LDA $02 : STA $06 : STA $08
    
    SEP #$20
    
    PHX
    
    LDA.w $037D : BNE .player_eyes_not_shut
        LDA.b #$10 : JSL.l OAM_AllocateFromRegionB
        
        BRA .oam_allocation_set
    
    .player_eyes_not_shut
    
    LDA.b #$10 : JSL.l OAM_AllocateFromRegionA
    
    .oam_allocation_set
    
    LDA.w $037D : BEQ .player_eyes_shut
        LDA.b #$04
    
    .player_eyes_shut
    
    TAX
    
    LDA.b #$03 : STA $0A
    
    LDY.b #$00
    
    .next_oam_entry
    
            JSR.w Ancilla_SetOam_XY
            
            LDA.w .chr, X : STA ($90), Y : INY
            
            LDA.w .properties, X : ORA.b #$0D : ORA $65 : STA ($90), Y : INY
            
            PHY
            
            TYA : SEC : SBC.b #$04 : LSR #2 : TAY
            
            LDA.b #$02 : STA ($92), Y
            
            PLY
            
            INX
            
            REP #$20
            
            LDA $06 : CLC : ADC.w #$0010 : STA $02
            
            SEP #$20
            
            DEC $0A : BMI .done_drawing
        LDA $0A : CMP.b #$01 : BNE .next_oam_entry
        
        REP #$20
        
        LDA $06 : STA $02
        
        LDA $04 : CLC : ADC.w #$0008 : STA $00
        
        SEP #$20
    BRA .next_oam_entry
    
    .done_drawing
    
    PLX
    
    RTS
}

; ==============================================================================
