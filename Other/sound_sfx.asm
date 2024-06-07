
; ==============================================================================

; $06BB5B-$06BB5D DATA TABLE
Pool_Sound_SetSfxPan:
{
    .pan_options
    dw $00, $80, $40
}

; ==============================================================================

; $06BB5E-$06BB66 LONG JUMP LOCATION
Sound_SfxPanObjectCoords:
{
    LDA.w $0C18, X : XBA
    LDA.w $0C04, X
    
    BRA Sound_SetSfxPan.useArbitraryCoords
}

; ==============================================================================

; $06BB67-$06BB6D LONG JUMP LOCATION
Sound_SetSfxPanWithPlayerCoords:
{
    LDA $23 : XBA
    LDA $22
    
    BRA Sound_SetSfxPan.useArbitraryCoords
}

; ==============================================================================

; $06BB6E-$06BB7B LONG JUMP LOCATION
Sound_SetSfx1PanLong:
{
    PHY
    
    LDY.w $012D : BNE .channelInUse
    
    JSR Sound_AddSfxPan
    
    STA.w $012D
    
    .channelInUse
    
    PLY
    
    RTL
}

; ==============================================================================

; $06BB7C-$06BB89 LONG JUMP LOCATION
Sound_SetSfx2PanLong:
{
    PHY
    
    LDY.w $012E : BEQ .channelInUse
    
    JSR Sound_AddSfxPan
    
    STA.w $012E
    
    .channelInUse
    
    PLY
    
    RTL
}

; ==============================================================================

; $06BB8A-$06BB97 LONG JUMP LOCATION
Sound_SetSfx3PanLong:
{
    PHY
    
    ; Is there a sound effect playing on this channel?
    LDY.w $012F : BNE .channelInUse
    
    JSR Sound_AddSfxPan
    
    ; Picked a sound effect, play it.
    STA.w $012F
    
    .channelInUse
    
    PLY
    
    RTL
}

; ==============================================================================

; $06BB98-$06BBA0 LOCAL JUMP LOCATION
Sound_AddSfxPan:
{
    ; Store the sound effect index here temporarily.
    STA $0D : JSL Sound_SetSfxPan : ORA $0D
    
    RTS
}

; ==============================================================================

; $06BBA1-$06BBC7 LONG JUMP LOCATION
Sound_SetSfxPan:
{
    ; Used to determine stereo settings for sound effects
    ; For example, if a bomb is more towards the left of the screen, the sound will mostly
    ; come out of the left speaker. The sound engine knows how to handle these inputs
    
    LDA.w $0D30, X : XBA
    LDA.w $0D10, X
    
    ; $06BBA8 BRANCH LOCATION
    .useArbitraryCoords
    
    REP #$20
    
    PHX
    
    LDX.b #$00
    
    ; A = Sprites X position minus the X coordinate of the scroll register for Layer 2.
    ; If A (unsigned) is less than #$50. A will be #$0.
    SEC : SBC $E2 : SEC : SBC.w #$0050 : CMP.w #$0050 : BCC .panSelected
    
    INX
    
    CMP.w #$0000 : BMI .panSelected
    
    INX ; And if all else fails, A will be #$40.
    
    .panSelected
    
    SEP #$20
    
    LDA .pan_options, X
    
    PLX
    
    RTL
}

; ==============================================================================

; $06BBC8-$06BBCF DATA
Pool_Sound_GetFineSfxPan:
{
    .settings
    db $80, $80, $80, $00, $00, $40, $40, $40
}

; ==============================================================================

; $06BBD0-$06BBDF LONG JUMP LOCATION
Sound_GetFineSfxPan:
{
    SEC : SBC $E2 : LSR #5 : PHX : TAX
    
    LDA .settings, X
    
    PLX
    
    RTL
}

; ==============================================================================

