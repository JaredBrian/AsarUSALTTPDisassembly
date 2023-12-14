
; ==============================================================================

; $0E8B49-$0E8B51 JUMP LOCATION
Sprite_FlameTrailBat:
{
    JSR FireBat_Draw
    JSR Sprite4_CheckIfActive
    JMP $8B90   ; $0E8B90 IN ROM
}

; ==============================================================================

