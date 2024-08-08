; ==============================================================================

; $02AA87-$02AA8A DATA
Pool_Sprite_Keese:
{
    .starting_speeds_indices
    db $02, $0A, $06, $0E
}

; ==============================================================================

; $02AA8B-$02AAE1 JUMP LOCATION
Sprite_Keese:
{
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_CheckIfRecoiling
    JSR.w Sprite2_CheckDamage
    JSR.w Sprite2_Move
    
    LDA.w $0D80, X : BNE Keese_Agitated
    
    TXA : EOR.b $1A : AND.b #$03 : ORA.w $0DF0, X : BNE .delay
    
    JSR.w Sprite2_DirectionToFacePlayer
    
    LDA.b $0E : CLC : ADC.b #$28 : CMP.b #$50 : BCS .player_not_close
    
    LDA.b $0F : CLC : ADC.b #$28 : CMP.b #$50 : BCS .player_not_close
    
    LDA.b #$1E : JSL.l Sound_SetSfx3PanLong
    
    ; Keese gets mad when you invade its personal space :(.
    INC.w $0D80, X
    
    LDA.b #$40 : STA.w $0DF0, X
                 STA.w $0DA0, X
    
    JSR.w Sprite2_DirectionToFacePlayer
    
    LDA.w .starting_speeds_indices, Y : STA.w $0D90, X
    
    .player_not_close
    .delay
    
    RTS
}

; ==============================================================================

; $02AAE2-$02AB03 DATA
Pool_Keese_Agitated:
{
    ; $02AAE2
    .index_step
    db 1, -1
    
    ; $02AAE4
    .random_x_speeds
    db   0,   8,  11,  14,  16,  14,  11,   8
    db   0,  -8, -11, -14, -16, -14, -11,  -8
    
    ; $02AAF4
    .random_y_speeds
    db -11,  -8, -16, -14, -11,  -8,   0,   8
    db  11,  14,  16,  14,  11,   8,   0,  -9
}

; ==============================================================================

; $02AB04-$02AB53 BRANCH LOCATION
Keese_Agitated:
    shared Keese_JimmiesRustled:
{
    LDA.w $0DF0, X : BNE .still_agitated
    
    STZ.w $0D80, X
    
    LDA.b #$40 : STA.w $0DF0, X
    
    STZ.w $0DC0, X
    
    JSR.w Sprite2_ZeroVelocity
    
    RTS
    
    .still_agitated
    
    AND.b #$07 : BNE .beta
    
    LDA.w $0DA0, X : AND.b #$01 : TAY
    
    LDA.w $0D90, X : CLC : ADC .index_step, Y : STA.w $0D90, X
    
    JSL.l GetRandomInt : AND.b #$03 : BNE .beta
    
    INC.w $0DA0, X
    
    .beta
    
    LDA.w $0D90, X : AND.b #$0F : TAY
    
    LDA.w .random_x_speeds, Y : STA.w $0D50, X
    
    LDA.w .random_y_speeds, Y : STA.w $0D40, X
    
    LDA.b $1A : LSR #2 : AND.b #$01 : INC A : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================
