; ==============================================================================

; $0E8BD1-$0E8BD6 DATA
FireBat_OverlordOffset:
{
    ; $0E8BD1
    .x_low
    db  20, -18

    ; $0E8BD3
    .x_high
    db   0,  -1

    ; $0E8BD5
    .y_low
    db -20, -20
}

; ==============================================================================

; $0E8BD7-$0E8BED JUMP LOCATION
Sprite_FireBat:
{
    JSR.w FireBat_Draw
    JSR.w Sprite4_CheckIfActive
    JSL.l Sprite_CheckDamageToPlayerLong
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw FireBat_PositionSelfAndAnimateAndPrepareForLaunch ; 0x00 - $8C17
    dw FireBat_PositionSelfAndAnimate                    ; 0x01 - $8C38
    dw FireBat_LaunchedFlying                            ; 0x02 - $8C55
}

; ==============================================================================

; $0E8BEE-$0E8C16 LOCAL JUMP LOCATION
GetPositionRelativeToTheGreatOverlordGanon:
{
    LDY.w $0DE0
    
    LDA.w $0B10, X : CLC : ADC.w FireBat_OverlordOffset_x_low, Y  : STA.w $0D10, X
    LDA.w $0B20, X       : ADC.w FireBat_OverlordOffset_x_high, Y : STA.w $0D30, X
    
    LDA.w $0B30, X : CLC : ADC.w FireBat_OverlordOffset_y_low, Y  : STA.w $0D00, X
    LDA.w $0B40, X       : ADC.b #$FF     : STA.w $0D20, X
    
    RTS
}

; ==============================================================================

; $0E8C17-$0E8C22 JUMP LOCATION
FireBat_PositionSelfAndAnimateAndPrepareForLaunch:
{
    JSR.w GetPositionRelativeToTheGreatOverlordGanon
    
    LDA.w $0DF0, X : BNE FireBat_AdjustAnimationState
    
        INC.w $0D80, X
        
        RTS
}
    
; $0E8C23-$0E8C2A JUMP LOCATION
FireBat_AdjustAnimationState:
{
    AND.b #$04 : LSR #2 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0E8C2B-$0E8C37 DATA
FireBat_AnimationStates:
{
    ; $0E8C2B
    .launched
    db 4, 4, 4, 3, 3, 3, 2, 2, 2

    ; $0E8C34
    .normal
    db 4, 5, 6, 5
}

; ==============================================================================

; $0E8C38-$0E8C42 JUMP LOCATION
FireBat_PositionSelfAndAnimate:
{
    JSR.w GetPositionRelativeToTheGreatOverlordGanon
    
    INC.w $0E80, X : LDA.w $0E80, X
    
    BRA FireBat_AdjustAnimationState
}

; $0E8C43-$0E8C54 LOCAL JUMP LOCATION
FireBat_Animate:
{
    INC.w $0E80, X : LDA.w $0E80, X : LSR #2 : AND.b #$03 : TAY
    
    LDA.w FireBat_AnimationStates_normal, Y : STA.w $0DC0, X
    
    RTS
}

; $0E8C55-$0E8C8F JUMP LOCATION
FireBat_LaunchedFlying:
{
    JSR.w Sprite4_Move
    
    LDA.b #$40 : STA.w $0CAA, X
    
    LDA.w $0E00, X : BEQ .BRANCH_ALPHA
        CMP.b #$01 : BEQ .BRANCH_BETA
            LSR #2 : TAY
            
            LDA.w FireBat_AnimationStates_launched, Y : STA.w $0DC0, X
            
            RTS
        
    .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BEQ .BRANCH_GAMMA
        DEC A : BNE FireBat_AdjustAnimationState
            LDA.b #$23 : STA.w $0E00, X
            
            BRA FireBat_AdjustAnimationState
            
    .BRANCH_BETA
            
    LDA.b #$30
            
    JSL.l Sprite_ApplySpeedTowardsPlayerLong
            
    LDA.b #$1E : JSL.l Sound_SetSfx3PanLong
    
    .BRANCH_GAMMA
    
    JSR.w FireBat_Animate
    
    BRA FireBat_Animate
}

; ==============================================================================

; $0E8C90-$0E8CA8 DATA
Pool_FireBat_Draw:
{
    ; $0E8C90
    .x_offsets
    db -8, 8
    
    ; These are laid out this way for a reason. The vh_flip data is in pairs
    ; because the sprite consists of pairs of oam entries.
    ; $0E8C92
    .chr
    db $88
    db $88
    db $8A
    db $8C
    db $68
    db $AA
    db $A8
    
    ; $0E8C90
    .vh_flip
    db $00, $C0
    db $80, $40
    db $00, $40
    db $00, $40
    db $00, $40
    db $00, $40
    db $00, $40
}

; $0E8CA9-$0E8D05 LOCAL JUMP LOCATION
FireBat_Draw:
{
    JSR.w Sprite4_PrepOamCoord
    
    LDA.w $0DC0, X : STA.b $07
    
    ASL A : STA.b $06
    
    PHX
    
    LDX.b #$01
    
    .next_oam_entry
        
        PHX
        
        TXA : ASL A : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC Pool_FireBat_Draw_x_offsets, X : STA ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02 : INY : STA ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
            LDA.b #$F0 : STA ($90), Y
        
        .on_screen_y
        
        LDX.b $07
        
        LDA.w Pool_FireBat_Draw_chr, X : INY : STA ($90), Y
        
        PLA : PHA : ORA.b $06 : TAX
        
        LDA.w Pool_FireBat_Draw_vh_flip, X : ORA.b $05 : INY : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b #$02 : ORA.b $0F : STA ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .next_oam_entry
    
    PLX
    
    RTS
}

; ==============================================================================
