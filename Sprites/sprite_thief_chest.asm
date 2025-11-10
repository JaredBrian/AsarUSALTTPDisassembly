; ==============================================================================

; $0F60DD-$0F6110 JUMP LOCATION
Sprite_ThiefChest:
{
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0D80, X : BNE .transition_to_tagalong
        ; "... the key is locked inside this chest, you can never open it...."
        LDA.b #$16
        LDY.b #$01
        JSL.l Sprite_ShowMessageFromPlayerContact : BCC .didnt_touch
            ; NOTE: This bit of logic is interesting in that the message above
            ; will always trigger from contact with the player but if for
            ; whatever reason they already have a tagalong, you can't get the
            ; chest following you. This gives the impression that the requirement
            ; that the smithy partner be saved first was to avoid that scenario
            ; entirely, rather than being a prerequisite by design. After all,
            ; they don't really have much to do with one another, do they? In
            ; other words, there is no causal relationship there.
            LDA.l $7EF3CC : BNE .already_have_tagalong
                INC.w $0D80, X
            
            .already_have_tagalong
        .didnt_touch
        
        RTS
    
    .transition_to_tagalong
    
    STZ.w $0DD0, X
    
    ; Thief's chest (at smithy house in DW) Set that as the tagalong sprite.
    LDA.b #$0C : STA.l $7EF3CC
    
    PHX
    
    JSL.l Tagalong_LoadGfx
    
    PLX
    
    JSL.l Tagalong_SpawnFromSprite
    
    RTS
}

; ==============================================================================
