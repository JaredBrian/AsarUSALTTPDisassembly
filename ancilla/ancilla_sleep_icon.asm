; ==============================================================================

; $044091-$044093 DATA
Ancilla_SleepIcon_tileset:
{
    db $44, $43, $42
}

; Special object 0x21 (Link's Zs while he's sleeping)
; $044094-$044106 JUMP LOCATION
Ancilla_SleepIcon:
{
    DEC.w $03B1, X : BPL .delay
        ; Don't increment the object's state beyond the value 2.
        LDA.w $0C5E, X : INC A : CMP.b #$03 : BEQ .at_last_state
            STA.w $0C5E, X
            
        .at_last_state
        
        LDA.b #$07 : STA.w $03B1, X
    
    .delay
    
    LDA.w $0C2C, X : CLC : ADC.w $0C54, X : STA.w $0C2C, X : BPL .positive_x_speed
        EOR.b #$FF : INC A
        
    .positive_x_speed
    
    CMP.b #$08 : BCC .dont_reverse_x_acceleration
        LDA.w $0C54, X : EOR.b #$FF : INC A : STA.w $0C54, X
        
    .dont_reverse_x_acceleration
    
    JSR.w Ancilla_MoveVert
    JSR.w Ancilla_MoveHoriz
    
    LDA.w $0BFA, X : STA.b $00
    LDA.w $0C0E, X : STA.b $01
    
    REP #$20
    
    LDA.b $20 : SEC : SBC.w #$0018 : CMP $00 : BCC .still_close_enough_to_player
        SEP #$20
        
        ; Self terminate if the Z gets too far away from the player.
        STZ.w $0C4A, X
    
    .still_close_enough_to_player
    
    SEP #$20
    
    LDY.w $0C5E, X
    
    ; This variable is used every NMI to update a small portion of the
    ; tiles available in VRAM. This essentially causes the 'Z's to
    ; cycle through different animation states.
    LDA.w .tileset, Y : STA.w $0109
    
    JSR.w Ancilla_PrepOamCoord
    
    LDY.b #$00
    
    JSR.w Ancilla_SetOam_XY
    
    LDA.b #$09 : STA ($90), Y : INY
    LDA.b #$24 : STA ($90), Y
    
    LDA.b #$00 : STA ($92)
    
    RTS
}

; ==============================================================================