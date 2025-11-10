; ==============================================================================

; $0342E5-$034308 JUMP LOCATION
Sprite_WeathervaneTrigger:
{
    JSR.w Sprite_PrepOamCoordSafeWrapper
    JSR.w Sprite_CheckIfActive
    
    LDA.b $8A : CMP.b #$18 : BNE .outside_village
        ; \item
        LDA.l $7EF34C : CMP.b #$03 : BNE .player_lacks_bird_enabled_flute
            STZ.w $0DD0, X
        
        .player_lacks_bird_enabled_flute
        
        RTS
        
    .outside_village
    
    ; What to do in an area outside of the village.
    
    ; \item
    LDA.l $7EF34C : AND.b #$02 : BEQ .player_lacks_flute_completely
        ; Suicide if the flute value is less than 2 (no flute or just the shovel).
        STZ.w $0DD0, X
        
    .player_lacks_flute_completely
    
    RTS
}

; ==============================================================================
