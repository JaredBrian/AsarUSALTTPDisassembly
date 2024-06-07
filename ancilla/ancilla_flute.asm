
; ==============================================================================

; $044FA6-$044FA9 DATA
Pool_Ancilla_Flute:
{
    .bounce_z_speeds
    db 24, 16, 10, 0
}

; ==============================================================================

; $044FAA-$04503C JUMP LOCATION
Ancilla_Flute:
{
    LDA $11 : BNE .dont_check_player_collision
    
    LDA.w $0C54, X : CMP.b #$03 : BEQ .check_player_collision
    
    LDA.w $0294, X : SEC : SBC.b #$02 : STA.w $0294, X
    
    JSR Ancilla_MoveHoriz
    JSR Ancilla_MoveAltitude
    
    LDA.w $029E, X : BPL .dont_check_player_collision
    
    CMP.b #$F0 : BCC .dont_check_player_collision
    
    INC.w $0C54, X : LDY.w $0C54, X
    
    LDA.w $CFA6, Y : STA.w $0294, X
    
    STZ.w $029E, X
    
    .dont_check_player_collision
    
    BRA .draw
    
    .check_player_collision
    
    LDY.b #$02
    
    JSR Ancilla_CheckPlayerCollision : BCC .player_didnt_acquire
    
    LDA.w $037E : BNE .player_didnt_acquire
    
    LDA $4D : BNE .player_didnt_acquire
    
    PHX
    
    STZ.w $0C4A, X
    STZ.w $02E9
    
    LDY.b #$14 : JSL Link_ReceiveItem
    
    PLX
    
    RTS
    
    .draw
    .player_didnt_acquire
    
    JSR Ancilla_PrepAdjustedOamCoord
    
    REP #$20
    
    LDA.w $029E, X : AND.w #$00FF : CMP.w #$0080 : BCC .sign_ext_z_coord
    
    ORA.w #$FF00
    
    .sign_ext_z_coord
    
    EOR.w #$FFFF : INC A : CLC : ADC $00 : STA $00
    
    SEP #$20
    
    PHX
    
    LDY.b #$00
    
    JSR Ancilla_SetOam_XY
    
    LDA.b #$24           : STA ($90), Y : INY
    LDA.b #$04 : ORA $65 : STA ($90), Y
    
    LDA.b #$02 : STA ($92)
    
    PLX
    
    LDY.b #$01 : LDA ($90), Y : CMP.b #$F0 : BNE .on_screen_y
    
    STZ.w $0C4A, X
    
    .on_screen_y
    .return
    
    RTS
}

; ==============================================================================
