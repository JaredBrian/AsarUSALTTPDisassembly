; ==============================================================================

; $035853-$03588A JUMP LOCATION
Sprite_Octospawn:
{
    LDA.w $0E80, X : BNE .still_alive
        STZ.w $0DD0, X
    
    .still_alive
    
    CMP.b #$40 : BCS .not_blinking
        AND.b #$01 : BNE .dont_draw_this_frame
    
    .not_blinking
    
    JSR.w Sprite_PrepAndDrawSingleSmall
    
    .dont_draw_this_frame
    
    JSR.w Sprite_CheckIfActive
    
    DEC.w $0E80, X
    
    JSR.w Sprite_CheckIfRecoiling
    
    DEC.w $0F80, X
    
    JSR.w Sprite_MoveAltitude
    
    LDA.w $0F70, X : BPL .not_grounded
        STZ.w $0F70, X
        
        LDA.b #$10 : STA.w $0F80, X
    
    .not_grounded
    
    JSR.w Sprite_Move
    JSR.w Sprite_CheckTileCollision
    JSR.w Sprite_WallInducedSpeedInversion

    ; Bleeds into the next function.
}
    
; $03588B-$035891 JUMP LOCATION
Sprite_CheckDamage:
{
    JSR.w Sprite_CheckDamageFromPlayer
    JSR.w Sprite_CheckDamageToPlayer
    
    RTS
}

; ==============================================================================
