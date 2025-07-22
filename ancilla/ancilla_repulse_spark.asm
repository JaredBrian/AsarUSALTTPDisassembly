; ==============================================================================

; $040F82-$040F88 DATA
Pool_Ancilla_RepulseSpark:
{
    ; $040F82
    .chr
    db $93, $82, $81
    
    ; $040F85
    .properties
    db $22, $12, $22, $22
}

; My best guess is that this handles generic hit / spark effects that
; don't fit anywhere else, but $0FAC is quite unfamiliar still. It never
; seems to receive a value higher than 5, but there are checks for
; it as high as 9 and beyond.
; $040F89-$04107F LOCAL JUMP LOCATION
Ancilla_RepulseSpark:
{
    LDA.w $0FAC : BEQ Ancilla_IsBelowPlayer_return
        ; Activate enemies that are listening for sounds?
        LDA.b #$02 : STA.w $0FDC
        
        DEC.w $0FAF : BPL .dont_decrement_state
            DEC.w $0FAC
            
            LDA.b #$01 : STA.w $0FAF
            
        .dont_decrement_state
        
        LDA.b #$10
        
        LDY.w $0FB3 : BEQ .dont_sort_sprites
            LDY.w $0B68 : BNE .on_bg1
                JSL.l OAM_AllocateFromRegionD
                
                BRA .check_if_on_screen
            
            .on_bg1
            
            JSL.l OAM_AllocateFromRegionF
            
            BRA .check_if_on_screen
            
        .dont_sort_sprites
        
        JSL.l OAM_AllocateFromRegionA
        
        .check_if_on_screen
        
        LDA.w $0FAD : SEC : SBC.w $00E2 : CMP.b #$F8 : BCS .off_screen
            STA.b $00
            
            LDA.w $0FAE : SEC : SBC.w $00E8 : CMP.b #$F0 : BCS .off_screen
                STA.b $01
                
                LDA.w $0FAC : CMP.b #$03 : BCC .later_states
                    LDY.b #$00
                    
                    LDA.b $00       : STA.b ($90), Y
                    LDA.b $01 : INY : STA.b ($90), Y
                    
                    LDA.b #$80
                    
                    LDX.w $0FAC : CPX.b #$09 : BCS .use_different_chr
                        LDA.b #$92
                        
                    .use_different_chr
                    
                    INY : STA.b ($90), Y
                    
                    LDX.w $0B68
                    LDA.l .properties, X : INY : STA.b ($90), Y
                    
                    TYA : LSR : LSR : TAY
                    LDA.b #$00 : STA.b ($92), Y
                    
                    RTS
        
        .off_screen
        
        ; Self terminate because the object went off screen.
        STZ.w $0FAC
        
        RTS
        
        .later_states
        
        ; The last three states of this object use more OAM entries than the
        ; earlier ones.
        
        LDA.b $00 : SEC : SBC.b #$04 : LDY.b #$00 : STA.b ($90), Y
                                       LDY.b #$08 : STA.b ($90), Y
                    CLC : ADC.b #$08 : LDY.b #$04 : STA.b ($90), Y
                                       LDY.b #$0C : STA.b ($90), Y
        LDA.b $01 : SEC : SBC.b #$04 : LDY.b #$01 : STA.b ($90), Y
                                       LDY.b #$05 : STA.b ($90), Y
                    CLC : ADC.b #$08 : LDY.b #$09 : STA.b ($90), Y
                                       LDY.b #$0D : STA.b ($90), Y
        
        LDX.w $0B68
        LDA.l .properties, X : LDY.b #$03 : STA.b ($90), Y
        ORA.b #$40           : LDY.b #$07 : STA.b ($90), Y
        ORA.b #$80           : LDY.b #$0F : STA.b ($90), Y
        EOR.b #$40           : LDY.b #$0B : STA.b ($90), Y
        
        LDX.w $0FAC
        
        LDA.w .chr, X : LDY.b #$02 : STA.b ($90), Y
                    LDY.b #$06 : STA.b ($90), Y
                    LDY.b #$0A : STA.b ($90), Y
                    LDY.b #$0E : STA.b ($90), Y
        
        LDY.b #$00
        LDA.b #$00
        
        STA.b ($92), Y : INY
        STA.b ($92), Y : INY
        STA.b ($92), Y : INY
        STA.b ($92), Y
        
        RTS
}

; ==============================================================================
