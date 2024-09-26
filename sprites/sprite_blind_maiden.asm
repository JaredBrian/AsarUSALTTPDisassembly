; ==============================================================================

; $0F68B6-$0F68F0 JUMP LOCATION
Sprite_BlindMaiden:
{
    JSL.l CrystalMaiden_Draw
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_MakeBodyTrackHeadDirection
    
    JSR.w Sprite3_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    LDA.w $0D80, X : BNE .switch_to_tagalong
        LDA.b #$22
        LDY.b #$01
        
        JSL.l Sprite_ShowMessageFromPlayerContact : BCC .didnt_speak
            INC.w $0D80, X
        
        .didnt_speak
        
        RTS
    
    .switch_to_tagalong
    
    STZ.w $0DD0, X
    
    ; Set "Blind the Thief (maiden)" as the tagalong.
    LDA.b #$06 : STA.l $7EF3CC
    
    PHX
    
    JSL.l Tagalong_LoadGfx
    
    PLX
    
    JSL.l Tagalong_SpawnFromSprite
    
    RTS
}

; ==============================================================================
