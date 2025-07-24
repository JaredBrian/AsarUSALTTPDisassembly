; ==============================================================================

; Gargoyle's Domain Entrance (0x14)
; $02E28C-$02E293 LONG JUMP LOCATION
Sprite_GargoyleGrateLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_GargoyleGrate
    
    PLB
    
    RTL
}

; ==============================================================================

; $02E294-$02E2E9 LOCAL JUMP LOCATION
Sprite_GargoyleGrate:
{
    JSL.l Sprite_PrepOamCoordLong
    JSR.w Sprite2_CheckIfActive
    
    JSL.l Sprite_CheckIfPlayerPreoccupied : BCS .dont_open
        JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .player_not_near
            LDA.b #$01 : STA.w $03F8
                         STA.w $0D90, X
            
            RTS
            
        .player_not_near
        
        LDA.w $0D90, X : BEQ .dont_open
            STZ.w $03F8
            
            LDA.w $0308 : AND.b #$01 : BEQ .dont_open
                LDA.b #$1F
                JSL.l Sound_SetSfx2PanLong
                
                PHX
                
                JSL.l Overworld_AlterGargoyleEntrance
                
                PLX
                
                JSR.w MedallionTablet_SpawnDustCloud
                
                LDA.w $0D10, X : STA.w $0D10, Y
                LDA.w $0D30, X : STA.w $0D30, Y
                
                LDA.w $0D00, X : STA.w $0D00, Y
                LDA.w $0D20, X : STA.w $0D20, Y
                
                STZ.w $0DD0, X
    
    .dont_open
    
    RTS
}

; ==============================================================================
