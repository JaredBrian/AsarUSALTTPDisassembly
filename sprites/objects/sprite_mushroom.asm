
; ==============================================================================

; $02EE4B-$02EE52 LONG JUMP LOCATION
SpritePrep_MushroomLong:
{
    PHB : PHK : PLB
    
    JSR SpritePrep_Mushroom
    
    PLB
    
    RTL
}

; ==============================================================================

; $02EE53-$02EE6F LOCAL JUMP LOCATION
SpritePrep_Mushroom:
{
    ; \item(Magic powder)
    LDA.l $7EF344 : CMP.b #$02 : BCC .player_lacks_magic_powder
    
    STZ.w $0DD0, X
    
    RTS
    
    .player_lacks_magic_powder
    
    LDA.b #$00 : STA.w $0DC0, X
    
    LDA.b #$08 : ORA.w $0F50, X : STA.w $0F50, X
    
    INC.w $0BA0, X
    
    RTS
}

; ==============================================================================

; $02EE70-$02EE77 LONG JUMP LOCATION
Sprite_MushroomLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_Mushroom
    
    PLB
    
    RTL
}

; ==============================================================================

; $02EE78-$02EEA5 LOCAL JUMP LOCATION
Sprite_Mushroom:
{
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    JSL Sprite_CheckIfPlayerPreoccupied : BCS .player_cant_obtain
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_player_collision
    
    STZ.w $0DD0, X
    
    PHX
    
    ; \item(Mushroom)
    LDY.b #$29
    
    STZ.w $02E9
    
    JSL Link_ReceiveItem
    
    PLX
    
    RTS
    
    .no_player_collision
    
    LDA $1A : AND.b #$1F : BNE .dont_toggle_h_flip
    
    LDA.w $0F50, X : EOR.b #$40 : STA.w $0F50, X
    
    .dont_toggle_h_flip
    .player_cant_obtain
    
    RTS
}

; ==============================================================================

