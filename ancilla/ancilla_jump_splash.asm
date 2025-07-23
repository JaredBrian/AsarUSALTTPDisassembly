; ==============================================================================

; NOTE: This first label indicates that they probably had one here in the
; original source but never filled anything in. Which would be why the
; pointer table would point to this location is obviously just data,
; instead of the code it's supposed to be.
; So perhaps 'incomplete' would be a better name than unused. Dunno.
; $04280D-$04280E DATA
Ancilla_Unused_14:
Ancilla_JumpSplash_chr:
{
    db $AC, $AE
}

; $04280F-$0428E2 JUMP LOCATION
Ancilla_JumpSplash:
{
    LDA.b $11 : BNE .draw
        DEC.w $03B1, X : BPL .animation_delay
            STZ.w $03B1, X
            
            LDA.b #$01 : STA.w $0C5E, X
            
        .animation_delay
        
        LDA.w $0C5E, X : BEQ .draw
            LDA.w $0C22, X : CLC : ADC.b #$FC : STA.w $0C22, X
                                                STA.w $0C2C, X
            CMP.b #$E8 : BCS .speed_not_maxed
                ; Self terminate once the splash reaches a certain 'speed'.
                STZ.w $0C4A, X
                
                LDA.w $02E0 : BNE .player_is_bunny
                    LDA.b $5D : CMP.b #$04 : BNE .not_swimming
                
                .player_is_bunny
                
                LDA.w $0345 : BEQ .not_touching_deep_water
                    PHX
                    
                    JSL.l Link_CheckSwimCapability
                    
                    PLX
                    
                .not_touching_deep_water

                .not_swimming
                
                RTS
                
            .speed_not_maxed
            
            JSR.w Ancilla_MoveVert
            JSR.w Ancilla_MoveHoriz
    
    .draw
    
    JSR.w Ancilla_PrepOamCoord
    
    LDA.w $0C04, X : STA.b $06
    LDA.w $0C18, X : STA.b $07
    
    REP #$20
    
    LDA.b $22 : SEC : SBC.b $06                   : STA.b $08
    LDA.b $22 : CLC : ADC.b $08 : SEC : SBC.b $E2 : STA.b $08
    
    LDA.b $06 : CLC : ADC.w #$000C : SEC : SBC.b $E2 : STA.b $06
    
    SEP #$20
    
    PHX
    
    LDA.w $0C5E, X : STA.b $0A : TAX
    
    LDA.b #$01 : STA.b $72
    
    LDY.b #$00 : STY.b $0C
    
    .next_OAM_entry
    
        JSR.w Ancilla_SetOam_XY
        
        LDA.w .chr, X          : STA.b ($90), Y
        
        INY
        LDA.b #$24 : ORA.b $0C : STA.b ($90), Y
        
        INY : PHY
        TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
        LDA.b #$02 : STA.b ($92), Y
        
        PLY
        
        JSR.w Ancilla_CustomAllocateOam
        
        LDA.b $08 : STA.b $02
        
        LDA.b #$40 : STA.b $0C
    DEC.b $72 : BPL .next_OAM_entry
    
    ; Commit one more sprite to the OAM buffer.
    LDA.b $06 : STA.b $02
    
    JSR.w Ancilla_SetOam_XY
    
    LDA.b #$C0 : STA.b ($90), Y
    
    INY
    LDA.b #$24 : STA.b ($90), Y
    
    INY : TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
    LDA.b #$02 : STA.b ($92), Y
    
    ; TODO: Figure out what the supposed bug is.
    ; BUG: maybe?
    LDA.b $0A : CMP.b #$01 : BNE .top_x_bit_zero
        STA.b ($92), Y
    
    .top_x_bit_zero
    
    PLX
    
    RTS
}

; ==============================================================================
