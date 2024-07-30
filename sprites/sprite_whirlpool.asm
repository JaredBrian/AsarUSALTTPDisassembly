
; ==============================================================================

; $0F6E56-$0F6E59 DATA
Pool_Sprite_Whirlpool:
{
    .vh_flip
    db $00, $40, $C0, $80
}

; ==============================================================================

; $0F6E5A-$0F6EEE JUMP LOCATION
Sprite_Whirlpool:
{
    LDA.b $8A : CMP.b #$1B : BNE .not_world_warp_gate
    ; NOTE: This is a hardcoded facility of the whirlpool sprite that
    ; forces it to act as a gate to the Dark World after beating Agahnim.
    ; A consequence of this is that one cannot place a whirlpool in the
    ; water of this area.
    
    JSL Sprite_PrepOamCoordLong
    JSR Sprite3_CheckIfActive
    
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.b $22 : CLC : ADC.w #$0040
    
    CMP.w #$0051 : BCS .player_not_close_enough
        LDA.w $0FDA : SEC : SBC.b $20 : CLC : ADC.w #$000F
    
        CMP.w #$0012 : BCS .player_not_close_enough
            SEP #$30
            
            LDA.b #$23 : STA.b $11
            
            LDA.b #$01 : STA.w $02DB
            
            STZ.b $B0
            STZ.b $27
            STZ.b $28
            
            LDA.b #$14 : STA.b $5D
            
            LDA.b $8A : AND.b #$40 : STA.b $7B
    
    .player_not_close_enough
    
    SEP #$30
    
    RTS
    
    .not_world_warp_gate
    
    LDA.w $0F50, X : AND.b #$3F : STA.w $0F50, X
    
    LDA.b $1A : LSR #3 : AND.b #$03 : TAY
    
    LDA .vh_flip, Y : ORA.w $0F50, X : STA.w $0F50, X
    
    LDA.b #$04 : JSL OAM_AllocateFromRegionB
    
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.w #$0005 : STA.w $0FD8
    
    SEP #$30
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite3_CheckIfActive
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .didnt_touch
    ; TODO: Note sure if this name is right, or how this variable could
    ; be set...?
    LDA.w $0D90, X : BNE .temporarily_disabled
        LDA.b #$2E : STA.b $11
        
        STZ.b $B0
    
    .temporarily_disabled
    
    RTS
    
    .didnt_touch
    
    STZ.w $0D90, X
    
    RTS
}

; ==============================================================================
