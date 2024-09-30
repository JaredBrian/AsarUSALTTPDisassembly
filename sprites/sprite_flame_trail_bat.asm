; ==============================================================================

; $0E8B49-$0E8B51 JUMP LOCATION
Sprite_FlameTrailBat:
{
    JSR.w FireBat_Draw
    JSR.w Sprite4_CheckIfActive
    JMP.w FireBat_Move
}

; ==============================================================================
