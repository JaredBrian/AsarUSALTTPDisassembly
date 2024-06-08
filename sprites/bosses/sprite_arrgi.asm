
; ==============================================================================

; $0F38B4-$0F38BB LONG JUMP LOCATION
{
    PHB : PHK : PLB
    
    JSR.w $B6E9 ; $0F36E9 IN ROM
    
    PLB
    
    RTL
}

; ==============================================================================

; $0F38BC-$0F38C3 DATA
Pool_Sprite_Arrgi:
{
    .animation_states
    db 0, 1, 2, 2, 2, 2, 2, 1
}

; ==============================================================================

; $0F38C4-$0F39A8 JUMP LOCATION
Sprite_Arrgi:
{
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite3_CheckIfActive
    
    INC.w $0E80, X
    
    LDA.w $0E80, X : LSR #3 : AND.b #$07 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0DA0, X : BEQ .BRANCH_ALPHA
    
    TAY : DEY
    
    LDA.w $0C4A, Y : BEQ .BRANCH_BETA
    
    LDA.w $0C04, Y : STA.w $0D10, X
    LDA.w $0C18, Y : STA.w $0D30, X
    LDA.w $0BFA, Y : STA.w $0D00, X
    LDA.w $0C0E, Y : STA.w $0D20, X
    
    LDA.b #$05 : STA.w $0F50, X
    
    LDA.w $0E60, X : AND.b #$BF : STA.w $0E60, X
    
    RTS
    
    .BRANCH_BETA
    
    LDA.b #$01 : STA.w $0D80, X
    
    STZ.w $0DA0, X
    
    LDA.b #$20 : STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BNE .BRANCH_GAMMA
    
    JSR Sprite3_CheckDamageToPlayer
    
    .BRANCH_GAMMA
    
    LDA.w $0D80, X : BNE .BRANCH_DELTA
    
    LDA.w $0B0F, X : STA.w $0D10, X
    LDA.w $0B1F, X : STA.w $0D30, X
    
    LDA.w $0B2F, X : STA.w $0D00, X
    LDA.w $0B3F, X : STA.w $0D20, X
    
    RTS
    
    .BRANCH_DELTA
    
    JSL Sprite_CheckDamageFromPlayerLong
    
    TXA : EOR $1A : AND.b #$03 : BNE .BRANCH_EPSILON
    
    LDA.w $0B0F, X : STA $04
    LDA.w $0B1F, X : STA $05
    LDA.w $0B2F, X : STA $06
    LDA.w $0B3F, X : STA $07
    
    LDA.b #$04
    
    JSL Sprite_ProjectSpeedTowardsEntityLong
    
    LDA $00 : STA.w $0D40, X
    
    LDA $01 : STA.w $0D50, X
    
    LDA.w $0D10, X : SEC : SBC.w $0B0F, X : CLC : ADC.b #$08 : CMP.b #$10 : BCS .BRANCH_EPSILON
    
    LDA.w $0D00, X : SEC : SBC.w $0B2F, X : CLC : ADC.b #$08 : CMP.b #$10 : BCS .BRANCH_EPSILON
    
    STZ.w $0D80, X
    
    LDA.b #$0D : STA.w $0F50, X
    
    LDA.w $0E60, X : ORA.b #$40 : STA.w $0E60, X
    
    .BRANCH_EPSILON
    
    JSR Sprite3_Move
    
    RTS
}

; ==============================================================================
