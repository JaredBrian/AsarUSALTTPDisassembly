; ==============================================================================

; $02940E-$029439 JUMP LOCATION
Sprite_LostWoodsBird:
{
    LDA.w $0E00, X : BNE Sprite_LostWoodsBird_dropping_delay
        LDA.w $0F50, X : AND.b #$BF
        
        LDY.w $0D50, X : BMI .moving_left
            ; Set the hflip bit.
            ORA.b #$40
            
        .moving_left
        
        STA.w $0F50, X
        
        JSL.l Sprite_PrepAndDrawSingleLargeLong
        JSR.w Sprite2_CheckIfActive
        JSR.w Sprite2_Move
        JSR.w Sprite2_MoveAltitude
        
        LDA.w $0D80, X
        JSL.l UseImplicitRegIndexedLocalJumpTable
        dw Sprite_LostWoodsBird_dropping ; 0x00 - $943A
        dw Sprite_LostWoodsBird_rising   ; 0x01 - $944C
}

; $02943A-$02944B LOCAL JUMP LOCATION
Sprite_LostWoodsBird_dropping:
{
    STZ.w $0DC0, X
        
    LDA.w $0F80, X : DEC : STA.w $0F80, X
    CMP.b #$F1 : BPL .still_dropping
        INC.w $0D80, X
        
    .still_dropping

    ; $02944B ALTERNATE ENTRY POINT
    .delay
    
    RTS
}

; $02944C-$029467 LOCAL JUMP LOCATION
Sprite_LostWoodsBird_rising:
{
    LDA.w $0F80, X : INC : INC : STA.w $0F80, X
    CMP.b #$10 : BMI .still_rising
        STZ.w $0D80, X
    
    .still_rising
    
    INC.w $0E80, X
    LDA.w $0E80, X : LSR : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================
