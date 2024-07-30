
; ==============================================================================

; $035853-$035891 JUMP LOCATION
Sprite_Octospawn:
{
    LDA.w $0E80, X : BNE .still_alive
    
    STZ.w $0DD0, X
    
    .still_alive
    
    CMP.b #$40 : BCS .not_blinking
    AND.b #$01 : BNE .dont_draw_this_frame
    
    .not_blinking
    
    JSR Sprite_PrepAndDrawSingleSmall
    
    .dont_draw_this_frame
    
    JSR Sprite_CheckIfActive
    
    DEC.w $0E80, X
    
    JSR Sprite_CheckIfRecoiling
    
    DEC.w $0F80, X
    
    JSR Sprite_MoveAltitude
    
    LDA.w $0F70, X : BPL .not_grounded
    
    STZ.w $0F70, X
    
    LDA.b #$10 : STA.w $0F80, X
    
    .not_grounded
    
    JSR Sprite_Move
    JSR Sprite_CheckTileCollision
    JSR Sprite_WallInducedSpeedInversion
    
    ; $03588B ALTERNATE ENTRY POINT
    shared Sprite_CheckDamage:
    
    JSR Sprite_CheckDamageFromPlayer
    JSR Sprite_CheckDamageToPlayer
    
    RTS
}

; ==============================================================================
