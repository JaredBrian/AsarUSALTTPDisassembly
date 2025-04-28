; ==============================================================================

; $042997-$0429A8 DATA
Pool_Ancilla_ShovelDirt:
{
    ; $042997
    .xy_offsets
    dw 18, -13
    dw -9, 4
    dw 18, 13
    dw -9, -11    
    
    ; $0429A7
    .chr
    db $40, $50
}

; $0429A9-$042A31 JUMP LOCATION
Ancilla_ShovelDirt:
{
    JSR.w Ancilla_PrepOamCoord
    
    LDA.w $0C68, X : BNE .delay
        LDA.b #$08 : STA.w $0C68, X
        
        INC.w $0C5E, X : LDA.w $0C5E, X : CMP.b #$02 : BNE .delay
            ; Eventually self-terminate.
            STZ.w $0C4A, X
            
            RTS
    
    .delay
    
    LDA.w $0C5E, X : STA.b $0A
    
    ASL #2 : STA.b $08
    
    LDY.b #$00
    
    LDA.b $2F : CMP.b #$04 : BEQ .player_facing_left
        LDY.b #$08
        
    .player_facing_left
    
    TYA : CLC : ADC.b $08 : TAY
    
    REP #$20
    
    LDA.w Pool_Ancilla_ShovelDirt_xy_offsets+0, Y : CLC : ADC.b $00 : STA.b $00
    
    LDA.w Pool_Ancilla_ShovelDirt_xy_offsets+2, Y : CLC : ADC.b $02 : STA.b $02
                                                 CLC : ADC.w #$0008 : STA.b $04
    
    SEP #$20
    
    PHX
    
    LDY.b #$00 : STY.b $72
    
    .next_OAM_entry
        
        JSR.w Ancilla_SetOam_XY
        
        LDX.b $0A
        
        LDA.w Pool_Ancilla_ShovelDirt_chr, X : CLC : ADC.b $72 : STA ($90), Y
        INY

        LDA.b #$04 : ORA.b $65 : STA ($90), Y
        INY
        
        PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
        
        LDA.b #$00 : STA ($92), Y
        
        PLY : JSR.w Ancilla_CustomAllocateOam
        
        LDA.b $04 : STA.b $02
        LDA.b $05 : STA.b $03
    INC.b $72 : LDA.b $72 : CMP.b #$02 : BNE .next_OAM_entry
    
    PLX
    
    RTS
}

; ==============================================================================
