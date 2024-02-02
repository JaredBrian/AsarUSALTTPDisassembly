
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
    LDA $7EF344 : CMP.b #$02 : BCC .player_lacks_magic_powder
    
    STZ $0DD0, X
    
    RTS
    
    .player_lacks_magic_powder
    
    LDA.b #$00 : STA $0DC0, X
    
    LDA.b #$08 : ORA $0F50, X : STA $0F50, X
    
    INC $0BA0, X
    
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
    
    STZ $0DD0, X
    
    PHX
    
    ; \item(Mushroom)
    LDY.b #$29
    
    STZ $02E9
    
    JSL Link_ReceiveItem
    
    PLX
    
    RTS
    
    .no_player_collision
    
    LDA $1A : AND.b #$1F : BNE .dont_toggle_h_flip
    
    LDA $0F50, X : EOR.b #$40 : STA $0F50, X
    
    .dont_toggle_h_flip
    .player_cant_obtain
    
    RTS
}

; ==============================================================================

