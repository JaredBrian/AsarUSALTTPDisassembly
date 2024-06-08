
; ==============================================================================

; $02E62B-$02E632 LONG JUMP LOCATION
Sprite_ArrowTriggerLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_ArrowTrigger
    
    PLB
    
    RTL
}

; ==============================================================================

; $02E633-$02E655 LOCAL JUMP LOCATION
Sprite_ArrowTrigger:
{
    LDA.w $0DA0, X : BNE .alpha
    
    JSL Sprite_PrepOamCoordLong
    JSR Sprite2_CheckIfActive
    
    JSR Sprite2_DirectionToFacePlayer : CPY.b #$02 : BNE .alpha
    
    LDA.w $0BB0, X : CMP.b #$09 : BNE .alpha
    
    INC.w $0642
    
    LDA.b #$01 : STA.w $0DA0, X
    
    .alpha
    
    RTS
}

; ==============================================================================

; $02E656-$02E656 LONG (UNUSED)
ArrowTrigger_Unused:
{
    RTL
}

; ==============================================================================
