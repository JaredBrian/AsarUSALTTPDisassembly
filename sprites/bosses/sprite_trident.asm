
; ==============================================================================

; $0E8AB6-$0E8B06 JUMP LOCATION
Sprite_Trident:
{
    JSR Trident_Draw
    JSR Sprite4_CheckIfActive
    JSR Sprite4_CheckDamage
    JSR Sprite_PeriodicWhirringSfx
    JSR Sprite4_Move
    
    DEC.w $0E80, X : LDA.w $0E80, X : LSR #2 : AND.b #$07 : TAY
    
    LDA.w $92F7, Y : STA.w $0ED0, X
    
    LDA.w $0DF0, X : BEQ Trident_AimForParentPosition
    LSR A        : BCS .BRANCH_ALPHA
    
    LDA.b #$20
    
    JSL Sprite_ProjectSpeedTowardsPlayerLong
    
    ; $0E8AE4 ALTERNATE ENTRY POINT
    
    LDA.b $00 : CMP.w $0D40, X : BEQ .BRANCH_BETA  BPL .BRANCH_GAMMA
    
    DEC.w $0D40, X
    
    BRA .BRANCH_BETA
    
    .BRANCH_GAMMA
    
    INC.w $0D40, X
    
    .BRANCH_BETA
    
    LDA.b $01 : CMP.w $0D50, X : BEQ .BRANCH_ALPHA  BPL .BRANCH_DELTA
    
    DEC.w $0D50, X
    
    BRA .BRANCH_ALPHA
    
    .BRANCH_DELTA
    
    INC.w $0D50, X
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $0E8B07-$0E8B0A DATA
{
    ; \task Name this routine / pool.
    db 24, -16
    db  0,  -1
}

; ==============================================================================

; $0E8B0B-$0E8B48 BRANCH LOCATION
Trident_AimForParentPosition:
{
    LDY.w $0DE0
    
    LDA.w $0D10 : CLC : ADC.w $8B07, Y : STA.b $04
    LDA.w $0D30 : ADC.w $8B09, Y : STA.b $05
    
    LDA.w $0D00 : CLC : ADC.b #$F0 : STA.b $06
    LDA.w $0D20 : ADC.b #$FF : STA.b $07
    
    JSR Ganon_CheckEntityProximity : BCS .BRANCH_ALPHA
    
    STZ.w $0DD0, X
    
    LDA.b #$03 : STA.w $0D80
    
    LDA.b #$10 : STA.w $0DF0
    
    .BRANCH_ALPHA
    
    LDA.b #$20
    
    JSL Sprite_ProjectSpeedTowardsEntityLong
    JMP.w $8AE4   ; $0E8AE4 IN ROM
}

; ==============================================================================
