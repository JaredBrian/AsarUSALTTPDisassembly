
; ==============================================================================

; $0D75A5-$0D75AC LONG JUMP LOCATION
Sprite_WaterfallLong:
{
    ; Waterfall sprite
    
    PHB : PHK : PLB
    
    JSR.w Sprite_Waterfall
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D75AD-$0D75B7 LOCAL JUMP LOCATION
Sprite_Waterfall:
{
    LDA.w $0E80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Waterfall_Main
    dw Sprite_RetreatBat
}

; ==============================================================================

; $0D75B8-$0D75D4 JUMP LOCATION
Waterfall_Main:
{
    JSR.w Sprite6_CheckIfActive
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_player_collision
    
    LDA.b $8A : CMP.b #$43 : BEQ .ganons_tower_area
    
    PHX
    
    JSL.l AddBreakTowerSeal
    
    PLX
    
    .no_player_collision
    
    RTS
    
    .ganons_tower_area
    
    PHX
    
    JSL.l AddBreakTowerSeal
    
    PLX
    
    RTS
}

; ==============================================================================
