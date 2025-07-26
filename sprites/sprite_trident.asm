; ==============================================================================

; $0E8AB6-$0E8AE3 JUMP LOCATION
Sprite_Trident:
{
    JSR.w Trident_Draw
    JSR.w Sprite4_CheckIfActive
    JSR.w Sprite4_CheckDamage
    JSR.w Sprite_PeriodicWhirringSfx
    JSR.w Sprite4_Move
    
    DEC.w $0E80, X
    LDA.w $0E80, X : LSR : LSR : AND.b #$07 : TAY
    LDA.w GanonTrident_Timers_facing_down, Y : STA.w $0ED0, X
    
    LDA.w $0DF0, X : BEQ Trident_AimForParentPosition
        LSR : BCS GanonTrident_AdjustVelocity_exit
            LDA.b #$20
            JSL.l Sprite_ProjectSpeedTowardsPlayerLong

            ; Bleeds into the next function.
}

; $0E8AE4-$0E8B06 JUMP LOCATION
GanonTrident_AdjustVelocity:
{
    LDA.b $00 : CMP.w $0D40, X : BEQ .BRANCH_BETA
        BPL .BRANCH_GAMMA   
            DEC.w $0D40, X
                
            BRA .BRANCH_BETA
                
        .BRANCH_GAMMA
                
        INC.w $0D40, X
                
    .BRANCH_BETA
            
    LDA.b $01 : CMP.w $0D50, X : BEQ .exit
        BPL .BRANCH_DELTA   
            DEC.w $0D50, X
                
            BRA .exit
                
        .BRANCH_DELTA
                
        INC.w $0D50, X
            
    .exit
        
    RTS
}

; ==============================================================================

; $0E8B07-$0E8B0A DATA
Pool_Trident_AimForParentPosition:
{
    ; $0E8B07
    .offset_x_low
    db 24, -16

    ; $0E8B09
    .offset_x_high
    db  0,  -1
}

; $0E8B0B-$0E8B48 BRANCH LOCATION
Trident_AimForParentPosition:
{
    LDY.w $0DE0
    LDA.w $0D10 : CLC : ADC.w Pool_Trident_AimForParentPosition_offset_x_low, Y
    STA.b $04
    
    LDA.w $0D30 :       ADC.w Pool_Trident_AimForParentPosition_offset_x_high, Y
    STA.b $05
    
    LDA.w $0D00 : CLC : ADC.b #$F0 : STA.b $06
    LDA.w $0D20 :       ADC.b #$FF : STA.b $07
    
    JSR.w Ganon_CheckEntityProximity : BCS .BRANCH_ALPHA
        STZ.w $0DD0, X
        
        LDA.b #$03 : STA.w $0D80
        
        LDA.b #$10 : STA.w $0DF0
    
    .BRANCH_ALPHA
    
    LDA.b #$20
    JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    JMP.w GanonTrident_AdjustVelocity
}

; ==============================================================================
