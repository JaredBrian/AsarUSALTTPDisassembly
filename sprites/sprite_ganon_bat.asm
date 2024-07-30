; ==============================================================================

; $0E8906-$0E890D DATA
Pool_Sprite_GanonBat:
{
    ; $0E8906
    .animation_states
    db 0, 1, 2, 1
    
    ; $0E890A
    .x_speed_limits
    db 32, -32
    
    ; $0E890C
    .y_speed_limits
    db 16, -16
}

; $0E890E-$0E89BA LOCAL JUMP LOCATION
Sprite_GanonBat:
{
    JSR GanonBat_Draw
    
    LDA.w $0F00, X : BEQ .BRANCH_ALPHA
        STZ.w $0DD0, X
        
        LDA.w $0403 : ORA.b #$80 : STA.w $0403
    
    .BRANCH_ALPHA
    
    JSR Sprite4_CheckIfActive
    
    LDA.b $1A : LSR #2 : AND.b #$03 : TAY
    
    LDA Pool_Sprite_GanonBat_animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0DF0, X : BEQ .BRANCH_BETA
        CMP #$D0 : BCS .BRANCH_GAMMA
            LDA.w $0EB0, X : AND.b #$01 : TAY
            
            ; Is this the kind of ganon bat that spirals out?
            LDA.w $0D40, X
            CLC : ADC.w Pool_Sprite_ApplyConveyorAdjustment_x_shake_values, Y
            STA.w $0D40, X
            
            CMP Pool_Sprite_GanonBat_y_speed_limits, Y : BNE .BRANCH_DELTA
                INC.w $0EB0, X
            
            .BRANCH_DELTA
            
            LDA.w $0DE0, X : AND.b #$01 : TAY
            
            LDA.w $0D50, X
            CLC : ADC.w Pool_Sprite_ApplyConveyorAdjustment_x_shake_values, Y
            STA.w $0D50, X : BNE .BRANCH_EPSILON
                PHA
                
                LDA.b #$1E : JSL Sound_SetSfx3PanLong
                
                PLA
                
            .BRANCH_EPSILON
            
            CMP Pool_Sprite_GanonBat_x_speed_limits, Y : BNE .BRANCH_GAMMA
                INC.w $0DE0, X
        
        .BRANCH_GAMMA
        
        LDA.b #$78 : STA.b $04
        
        LDA.b #$50 : STA.b $06
        
        LDA.b $23 : STA.b $05
        
        LDA.b $21 : STA.b $07
        
        LDA.b #$05 : JSL Sprite_ProjectSpeedTowardsEntityLong
        
        LDA.w $0D50, X : PHA : CLC : ADC.b $01 : STA.w $0D50, X
        
        LDA.w $0D40, X : PHA : CLC : ADC.b $00 : STA.w $0D40, X
        
        JSR Sprite4_Move
        
        PLA : STA.w $0D40, X
        PLA : STA.w $0D50, X
        
        RTS
    
    .BRANCH_BETA
    
    JSR Sprite4_Move
    
    LDA.w $0D50, X : CMP.b #$40 : BEQ .BRANCH_ZETA
        INC.w $0D50, X
        
        DEC.w $0D40, X
    
    .BRANCH_ZETA
    
    RTS
}

; ==============================================================================

; $0E89BB-$0E89EA DATA
GanonBat_Draw_oam_groups:
{
    dw -8, 0 : db $60, $05, $00, $02
    dw  8, 0 : db $60, $45, $00, $02
    
    dw -8, 0 : db $62, $05, $00, $02
    dw  8, 0 : db $62, $45, $00, $02
    
    dw -8, 0 : db $44, $05, $00, $02
    dw  8, 0 : db $44, $45, $00, $02
}

; $0E89EB-$0E8A03 LOCAL JUMP LOCATION
GanonBat_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : REP #$20 : ASL #4 : CLC : ADC.w #.oam_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JMP Sprite4_DrawMultiple
}

; ==============================================================================

