
; ==============================================================================

; $02E24D-$02E254 LONG JUMP LOCATION
Sprite_PullForRupeesLong:
{
    ; PullForRupees sprite (0x33)
    PHB : PHK : PLB
    
    JSR Sprite_PullForRupeesLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $02E255-$02E28B LOCAL JUMP LOCATION
Sprite_PullForRupees:
{
    JSL Sprite_PrepOamCoordLong
    JSR Sprite2_CheckIfActive
    
    JSL Sprite_CheckIfPlayerPreoccupied : BCS .cant_pull
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .didnt_pull
    
    LDA.b #$01 : STA $03F8 : STA $0D90, X
    
    RTS
    
    .didnt_pull
    
    ; Task, figure out how the pulling triggering works. Doesn't seem
    ; to be handled here directly...
    LDA $0D90, X : BEQ .cant_pull
    
    STZ $03F8
    
    LDA $0308 : AND.b #$01 : BEQ .cant_pull
    
    STZ $0DD0, X
    
    JSL PullForRupees_SpawnRupees
    JSL Sprite_SpawnPoofGarnish
    
    .cant_pull
    
    RTS
}

; ==============================================================================

