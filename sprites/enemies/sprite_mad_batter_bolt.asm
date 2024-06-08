
; ==============================================================================

; $0F0A8E-$0F0A95 LONG JUMP LOCATION
Sprite_MadBatterBoltLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_MadBatterBolt
    
    PLB
    
    RTL
}

; ==============================================================================

; $0F0A96-$0F0ABA LOCAL JUMP LOCATION
Sprite_MadBatterBolt:
{
    LDA.w $0E80, X : AND.b #$10 : BEQ .in_front_of_player
    ; \note Seems we have some confirmation that this oam region is for
    ; putting sprites behind the player...
    LDA.b #$04 : JSL OAM_AllocateFromRegionB
    
    .in_front_of_player
    
    JSL Sprite_PrepAndDrawSingleSmallLong
    JSR Sprite3_CheckIfActive
    
    LDA.w $0D80, X : BNE MadBatterBold_Active
    
    JSR Sprite3_Move
    
    LDA.w $0DF0, X : BNE .delay
    INC.w $0D80, X
    
    .delay:
    
    RTS
}

; ==============================================================================

; $0F0ABB-$0F0ACA DATA
Pool_MadBatterBolt_Active:
{
    .x_offsets
    db 0, 4, 8, 12, 12, 4, 8, 0
    
    .y_offsets
    db 0, 4, 8, 12, 12, 4, 8, 0
}
    
; ==============================================================================

; $0F0ACB-$0F0B10 BRANCH LOCATION
MadBatterBolt_Active:
{
    INC.w $0D80, X : BNE .dont_self_terminate
    STZ.w $0DD0, X
    
    .dont_self_terminate
    
    INC.w $0E80, X : LDA.w $0E80, X : PHA : AND.b #$07 : BNE .dont_play_sfx
    LDA.b #$30 : STA.w $012F
    
    .dont_play_sfx
    
    PLA : LSR #2 : PHA : AND.b #$07 : TAY
    
    LDA $22 : CLC : ADC .x_offsets, Y : STA.w $0D10, X
    LDA $23 : ADC.b #$00        : STA.w $0D30, X
    
    PLA : LSR #2 : AND.b #$07 : TAY
    
    LDA $20 : CLC : ADC .y_offsets, Y : STA.w $0D00, X
    LDA $21 : ADC.b #$00        : STA.w $0D20, X
    
    RTS
}

; ==============================================================================

