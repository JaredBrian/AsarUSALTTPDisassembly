; ==============================================================================

; $0F0A8E-$0F0A95 LONG JUMP LOCATION
Sprite_MadBatterBoltLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_MadBatterBolt
    
    PLB
    
    RTL
}

; ==============================================================================

; $0F0A96-$0F0ABA LOCAL JUMP LOCATION
Sprite_MadBatterBolt:
{
    LDA.w $0E80, X : AND.b #$10 : BEQ .in_front_of_player
        ; NOTE: Seems we have some confirmation that this OAM region is for
        ; putting sprites behind the player...
        LDA.b #$04 : JSL.l OAM_AllocateFromRegionB
    
    .in_front_of_player
    
    JSL.l Sprite_PrepAndDrawSingleSmallLong
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0D80, X : BNE MadBatterBold_Active
        JSR.w Sprite3_Move
        
        LDA.w $0DF0, X : BNE .delay
            INC.w $0D80, X
        
        .delay
        
        RTS
}

; ==============================================================================

; $0F0ABB-$0F0ACA DATA
Pool_MadBatterBolt_Active:
{
    ; $0F0ABB
    .x_offsets
    db 0, 4, 8, 12, 12, 4, 8, 0
    
    ; $0F0AC3
    .y_offsets
    db 0, 4, 8, 12, 12, 4, 8, 0
}

; $0F0ACB-$0F0B10 BRANCH LOCATION
MadBatterBolt_Active:
{
    INC.w $0D80, X : BNE .dont_self_terminate
        STZ.w $0DD0, X
    
    .dont_self_terminate
    
    INC.w $0E80, X : LDA.w $0E80, X : PHA : AND.b #$07 : BNE .dont_play_SFX
        LDA.b #$30 : STA.w $012F
    
    .dont_play_SFX
    
    PLA : LSR : LSR : PHA : AND.b #$07 : TAY
    
    LDA.b $22
    CLC : ADC.w Pool_MadBatterBolt_Active_x_offsets, Y : STA.w $0D10, X
    LDA.b $23 : ADC.b #$00 : STA.w $0D30, X
    
    PLA : LSR : LSR : AND.b #$07 : TAY
    
    LDA.b $20
    CLC : ADC.w Pool_MadBatterBolt_Active_y_offsets, Y : STA.w $0D00, X

    LDA.b $21 : ADC.b #$00 : STA.w $0D20, X
    
    RTS
}

; ==============================================================================
