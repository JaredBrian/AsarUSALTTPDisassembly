; ==============================================================================

; PullForRupees sprite (0x33)
; $02E24D-$02E254 LONG JUMP LOCATION
Sprite_PullForRupeesLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_PullForRupeesLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $02E255-$02E28B LOCAL JUMP LOCATION
Sprite_PullForRupees:
{
    JSL.l Sprite_PrepOamCoordLong
    JSR.w Sprite2_CheckIfActive
    
    JSL.l Sprite_CheckIfPlayerPreoccupied : BCS .cant_pull
        JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .didnt_pull
            LDA.b #$01 : STA.w $03F8
                         STA.w $0D90, X
            
            RTS
            
            .didnt_pull
            
            ; TODO: Figure out how the pulling triggering works. Doesn't seem
            ; to be handled here directly...
            LDA.w $0D90, X : BEQ .cant_pull
                STZ.w $03F8
                
                LDA.w $0308 : AND.b #$01 : BEQ .cant_pull
                    STZ.w $0DD0, X
                    
                    JSL.l PullForRupees_SpawnRupees
                    JSL.l Sprite_SpawnPoofGarnish
        
    .cant_pull
    
    RTS
}

; ==============================================================================
