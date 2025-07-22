; ==============================================================================

; Ancilla 0x42 (rupees thrown into pond of wishing)
; $0447DE-$044818 JUMP LOCATION
Ancilla_HappinessPondRupees:
{
    LDA.b #$02 : STA.w $0309
                 STZ.w $0308
    
    LDX.b #$09
    
    .next_rupee_slot
    
        LDA.l $7F586C, X : BEQ .inactive_rupee
            PHX
            
            JSR.w HappinessPondRupees_ExecuteRupee
            
            PLX
            
            LDA.l $7F58AA, X : CMP.b #$02 : BNE .dont_deactivate_rupee
                LDA.b #$00 : STA.l $7F586C, X
            
            .dont_deactivate_rupee
        .inactive_rupee
    DEX : BPL .next_rupee_slot
    
    LDX.b #$09
    
    .find_active_rupee_loop
    
        LDA.l $7F586C, X : BNE .not_all_inactive
    DEX : BPL .find_active_rupee_loop
    
    LDX.w $0FA0
    
    STZ.w $0C4A, X
    
    RTS
    
    .not_all_inactive
    
    ; WTF: Could be wrong, but this is probably not necessary since
    ; we're done and we'll be moving on to the next Ancilla anyways, so
    ; restoring the index is not useful at all.
    BRL Ancilla_RestoreIndex
}

; ==============================================================================

; $044819-$0448BD LOCAL JUMP LOCATION
HappinessPondRupees_ExecuteRupee:
{
    ; WTF: Wait, why does this need 4 OAM slots exactly?
    LDA.b #$10 : JSR.w Ancilla_AllocateOam
    
    PHX
    
    LDY.w $0FA0
    JSR.w HappinessPondRupee_LoadRupeeeState
    
    TYX
    
    LDA.w $0C54, X : BEQ .not_in_splash_state
        LDA.b $11 : BNE .just_draw_splash
            LDA.w $0C68, X : BNE .just_draw_splash
                LDA.b #$06 : STA.w $0C68, X
                
                INC.w $0C5E, X
                LDA.w $0C5E, X : CMP.b #$05 : BNE .just_draw_splash
                    INC.w $0C54, X
                    
                    BRL .return
            
        .just_draw_splash
        
        JSR.w Ancilla_ObjectSplash_draw
        
        BRA .return
    
    .not_in_splash_state
    
    LDA.b $11 : BNE .just_draw_item
        LDA.w $0C68, X : BNE .just_draw_item
            LDA.w $0294, X : SEC : SBC.b #$02 : STA.w $0294, X
            
            JSR.w Ancilla_MoveVert
            JSR.w Ancilla_MoveHoriz
            JSR.w Ancilla_MoveAltitude
            
            LDA.w $029E, X : BPL .just_draw_item
            CMP.b #$E4 : BCS .just_draw_item
                LDA.b #$E4 : STA.w $029E, X
                
                LDA.w $0BFA, X : CLC : ADC.b #$1E : STA.w $0BFA, X
                LDA.w $0C0E, X       : ADC.b #$00 : STA.w $0C0E, X
                
                LDA.w $0C04, X : CLC : ADC.b #$FC : STA.w $0C04, X
                LDA.w $0C18, X       : ADC.b #$FF : STA.w $0C18, X
                
                STZ.w $0C5E, X
                
                LDA.b #$06 : STA.w $0C68, X
                
                LDA.b #$28
                JSR.w Ancilla_DoSfx2
                
                INC.w $0C54, X
                
                BRA .return
        
    .just_draw_item
    
    LDA.b #$02 : STA.w $0BF0, X
    LDA.b #$00 : STA.w $0C7C, X
    
    JSR.w Ancilla_WishPondItem_draw
    
    .return
    
    TXY
    
    PLX
    
    JSR.w HappinessPondRupees_StoreRupeeState
    
    RTS
}

; ==============================================================================

; $0448BE-$044923 LOCAL JUMP LOCATION
HappinessPondRupees_LoadRupeeeState:
{
    ; WTF: All of these arrays appear to have been allocated 0x0C bytes
    ; apart, except there's a 2 byte gap between the arrays starting at
    ; $7F586C and $7F587A. Why?
    
    LDA.l $7F5824, X : STA.w $0BFA, Y
    LDA.l $7F5830, X : STA.w $0C0E, Y
    
    LDA.l $7F583C, X : STA.w $0C04, Y
    LDA.l $7F5848, X : STA.w $0C18, Y
    
    LDA.l $7F5854, X : STA.w $029E, Y
    
    LDA.l $7F5800, X : STA.w $0C22, Y
    
    LDA.l $7F580C, X : STA.w $0C2C, Y
    
    LDA.l $7F5818, X : STA.w $0294, Y
    
    LDA.l $7F5886, X : STA.w $0C36, Y
    
    LDA.l $7F5892, X : STA.w $0C40, Y
    
    LDA.l $7F589E, X : STA.w $02A8, Y
    
    LDA.l $7F587A, X : STA.w $0C5E, Y
    
    LDA.l $7F58AA, X : STA.w $0C54, Y
    
    LDA.l $7F5860, X : BEQ .timer_expired
        DEC
    
    .timer_expired
    
    STA.w $0C68, Y
    
    RTS
}

; ==============================================================================

; $044924-$044986 LOCAL JUMP LOCATION
HappinessPondRupees_StoreRupeeState:
{
    LDA.w $0BFA, Y : STA.l $7F5824, X
    LDA.w $0C0E, Y : STA.l $7F5830, X
    
    LDA.w $0C04, Y : STA.l $7F583C, X
    LDA.w $0C18, Y : STA.l $7F5848, X
    
    LDA.w $029E, Y : STA.l $7F5854, X
    
    LDA.w $0C22, Y : STA.l $7F5800, X
    
    LDA.w $0C2C, Y : STA.l $7F580C, X
    
    LDA.w $0294, Y : STA.l $7F5818, X
    
    LDA.w $0C36, Y : STA.l $7F5886, X
    
    LDA.w $0C40, Y : STA.l $7F5892, X
    
    LDA.w $02A8, Y : STA.l $7F589E, X
    
    LDA.w $0C5E, Y : STA.l $7F587A, X
    
    LDA.w $0C68, Y : STA.l $7F5860, X
    
    LDA.w $0C54, Y : STA.l $7F58AA, X
    
    RTS
}

; ==============================================================================
