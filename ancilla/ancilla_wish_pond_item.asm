; ==============================================================================

; Special Object 0x28 (item sprite thrown into ponds)
; $0446F2-$0447DD JUMP LOCATION
Ancilla_WishPondItem:
{
    LDA.b #$10
    
    JSR.w Ancilla_AllocateOam
    
    LDA.b $11 : BEQ .execute
        BRL .draw
    
    .execute
    
    LDA.w $0C68, X : BNE .draw
        LDA.b #$02 : STA.w $0309
        
        STZ.w $0308
        
        ; Begin z-deceleation (i.e. simulating gravity).
        LDA.w $0294, X : SEC : SBC.b #$02 : STA.w $0294, X
        
        JSR.w Ancilla_MoveAltitude
        JSR.w Ancilla_MoveVert
        JSR.w Ancilla_MoveHoriz
        
        LDA.w $029E, X : BPL .draw
        CMP.b #$E4 : BCS .draw
            LDA.b #$E4 : STA.w $029E, X
            
            LDY.w $0C5E, X
            
            LDA.w $0BFA, X : CLC : ADC.b #$12 : STA.w $0BFA, X
            LDA.w $0C0E, X       : ADC.b #$00 : STA.w $0C0E, X
            
            LDA.b #$08 : STA.b $00
            
            ; BUG: (confirmed) This is suposed to be a long address mode, not
            ; local. Looks like even the Z3 programmers and their fancy assembler
            ; or compiler or whatever they used, were also fallible.
            ; This particular read indexes into the code region of the
            ; "ice shot sparkle" ancilla, if you beleve that. I suspect that it
            ; was supposed to be $098450 Pool_AddReceiveItem_wide_item_flag.
            LDA.w Ancilla_IceShotSparkle+$1B, Y : BNE .dont_use_4_pixel_offset
                LDA.b #$04 : STA.b $00
            
            .dont_use_4_pixel_offset
            
            LDA.w $0C04, X : CLC : ADC.b $00  : STA.w $0C04, X
            LDA.w $0C18, X       : ADC.b #$00 : STA.w $0C18, X
            
            BRL Ancilla_TransmuteToObjectSplash
    
    ; $044760 ALTERNATE ENTRY POINT
    .draw
    
    JSR.w Ancilla_PrepAdjustedOamCoord
    
    ; WTF:
    ; Looks like this is making a special exception for the master sword
    ; (level 2 only), but I can't say for sure what the purpose of this
    ; is...
    LDA.w $0C5E, X : CMP.b #$01 : BNE .unknown
        LDA.w Pool_Ancilla_ReceiveItem_default_OAM_properties : STA.w $0BF0, X
    
    .unknown
    
    REP #$20
    
    LDA.w $029E, X : AND.w #$00FF : CMP.w #$0080 : BCC .sign_ext_z_coord
        ORA.w #$FF00
    
    .sign_ext_z_coord
    
    STA.b $04
    
    EOR.w #$FFFF : INC : CLC : ADC.b $00 : STA.b $00 : STA.b $06
    
    CLC : ADC.w #$0008 : STA.b $08
    
    SEP #$20
    
    JSR.w Ancilla_ReceiveItem_draw
    
    ; Done throwing?
    LDA.w $0309 : CMP.b #$02 : BNE .return
        LDA.w $0294, X : BMI .draw_shadow
            CMP.b #$02 : BCS .return
        
        .draw_shadow
        
        PHX
        
        LDA.w $0C5E, X : TAX
        
        ; BUG: (Confirmed) Same bug as above.
        LDA.w Ancilla_IceShotSparkle+$1B, X : TAX
        
        REP #$20
        
        LDA.b $06 : CLC : ADC.b $04 : CLC : ADC.w #$0028 : STA.b $00
        
        CPX.b #$02 : BEQ .wide_sprite
            LDA.b $02 : CLC : ADC.w #-4 : STA.b $02
        
        .wide_sprite
        
        SEP #$20
        
        LDA.b #$01
        
        CPX.b #$02 : BEQ .use_wide_shadow
            LDA.b #$02
        
        .use_wide_shadow
        
        TAX
        
        LDA.b $65 : STA.b $04
        
        JSR.w Ancilla_DrawShadow
        
        PLX
    
    .return
    
    RTS
}

; ==============================================================================
