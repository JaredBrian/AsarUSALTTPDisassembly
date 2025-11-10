; ==============================================================================

; $03250C-$03253F JUMP LOCATION
Sprite_AntiFairy:
{
    JSL.l Sprite_DrawFourAroundOne
    JSR.w Sprite_CheckIfActive
    
    JSR.w Sprite_CheckDamageToPlayer : BCC .anodrain_player_mp
        LDA.w $0DF0, X : BNE .anodrain_player_mp
            LDA.b #$10 : STA.w $0DF0, X
            
            ; \item
            ; Subtract off 8 points of mp.
            LDA.l $7EF36E : SEC : SBC.b #$08 : BCS .player_has_at_least_eight_mp
                LDA.b #$00
                
                BRA .anoplay_drain_SFX
            
            .player_has_at_least_eight_mp
            
            ; Play the magic draining sound.
            LDY.b #$1D : STY.w $012F
            
            .anoplay_drain_SFX
            
            STA.l $7EF36E
    
    .anodrain_player_mp
    
    JSR.w Sprite_Move
    JSL.l Sprite_BounceFromTileCollisionLong
    
    RTS
}

; ==============================================================================
