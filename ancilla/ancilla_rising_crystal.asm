; ==============================================================================

; NOTE: This object doesn't self terminate. It must be that the
; polyhedral cyrstal submodule in the Dungoen module terminates it
; or related code does when gearing up to the leave the dungeon.
    
; ==============================================================================

; $044BE4-$044BF1 LOCAL JUMP LOCATION
Ancilla_TransmuteToRisingCrystal:
{
    ; Start up 3D crystal effect.
    LDA.b #$3E : STA.w $0C4A, X
    
    STZ.w $0C22, X
    STZ.w $0C2C, X
    STZ.w $0C36, X

    ; Bleeds into the next function.
}
    
; $044BF2-$044C92 LOCAL JUMP LOCATION
Ancilla_RisingCrystal:
{
    STZ.w $029E, X
    
    JSR.w Ancilla_AddSwordChargeSpark
    
    LDA.w $0C22, X : CLC : ADC.b #$FF : CMP.b #$F0 : BCS .ascent_speed_maxed
        LDA.b #$F0
    
    .ascent_speed_maxed
    
    STA.w $0C22, X
    
    JSR.w Ancilla_MoveVert
    
    LDA.w $0BFA, X : STA.b $00
    LDA.w $0C0E, X : STA.b $01
    
    REP #$20
    
    LDA.b $00 : SEC : SBC.w $0122 : CMP.w #$0049 : BCS .below_target_y_position
        ; Keep position fixed at 0x0049.
        LDA.w #$0049 : CLC : ADC.w $0122 : STA.b $00
        
        SEP #$20
        
        LDA.b $00 : STA.w $0BFA, X
        LDA.b $01 : STA.w $0C0E, X
        
        LDA.b $11 : BNE .delay_giving_crystal
            PHX
            
            LDA.w $040C : LSR : TAX
            
            ; Give player the crystal associated with this dungeon.
            LDA.l $7EF37A : ORA.l MilestoneItem_Flags, X : STA.l $7EF37A
            
            LDA.b #$18 : STA.b $11
            
            STZ.b $B0
            
            REP #$20
            
            LDX.b #$00
            LDA.w #$0000
            
            .zero_aux_bg_palettes
            
                STA.l $7EC340, X : STA.l $7EC360, X : STA.l $7EC380, X 
                STA.l $7EC3A0, X : STA.l $7EC3C0, X : STA.l $7EC3E0, X 
            INX : INX : CPX.b #$20 : BNE .zero_aux_bg_palettes
            
            STA.l $7EC007 : STA.l $7EC009
            
            SEP #$20
            
            PLX
            
        .delay_giving_crystal
    .below_target_y_position
    
    SEP #$20
    
    JSR.w Ancilla_PrepAdjustedOamCoord
    
    REP #$20
    
    LDA.b $00 : STA.b $06
    
    SEP #$20
    
    JSR.w Ancilla_ReceiveItem_draw
    
    RTS
}

; ==============================================================================
