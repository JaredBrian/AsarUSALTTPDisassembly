; ==============================================================================

; $044003-$044012 DATA
Pool_Ancilla_BedSpread:
{
    ; $044003
    .chr
    db $0A, $0A, $0A, $0A
    db $0C, $0C, $0A, $0A
    
    ; $04400B
    .properties
    db $00, $60, $A0, $E0
    db $00, $60, $A0, $E0
}

; $044013-$044090 JUMP LOCATION
Ancilla_BedSpread:
{
    JSR.w Ancilla_PrepOamCoord
    
    REP #$20
    
    LDA.b $00 : STA.b $04
    LDA.b $02 : STA.b $06
                STA.b $08
    
    SEP #$20
    
    PHX
    
    LDA.w $037D : BNE .player_eyes_not_shut
        LDA.b #$10
        JSL.l OAM_AllocateFromRegionB
        
        BRA .OAM_allocation_set
    
    .player_eyes_not_shut
    
    LDA.b #$10
    JSL.l OAM_AllocateFromRegionA
    
    .OAM_allocation_set
    
    LDA.w $037D : BEQ .player_eyes_shut
        LDA.b #$04
    
    .player_eyes_shut
    
    TAX
    
    LDA.b #$03 : STA.b $0A
    
    LDY.b #$00
    
    .next_OAM_entry
    
            JSR.w Ancilla_SetOam_XY
            
            LDA.w Pool_Ancilla_BedSpread_chr, X : STA.b ($90), Y

            INY
            LDA.w Pool_Ancilla_BedSpread_properties, X
            ORA.b #$0D : ORA .b$65 : STA.b ($90), Y

            INY : PHY
            
            TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
            LDA.b #$02 : STA.b ($92), Y
            
            PLY
            
            INX
            
            REP #$20
            
            LDA.b $06 : CLC : ADC.w #$0010 : STA.b $02
            
            SEP #$20
            
            DEC.b $0A : BMI .done_drawing
        LDA.b $0A : CMP.b #$01 : BNE .next_OAM_entry
        
        REP #$20
        
        LDA.b $06 : STA.b $02
        
        LDA.b $04 : CLC : ADC.w #$0008 : STA.b $00
        
        SEP #$20
    BRA .next_OAM_entry
    
    .done_drawing
    
    PLX
    
    RTS
}

; ==============================================================================
