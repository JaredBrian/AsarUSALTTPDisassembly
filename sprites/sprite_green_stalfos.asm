
; ==============================================================================

; $0F528D-$0F5298 DATA
Pool_Sprite_GreenStalfos:
{
    ,facing_direction
    db $04, $06, $00, $02
    
    .vh_flip
    db $40, $00, $00, $00
    
    .animation_states
    db $00, $00, $01, $02
}

; ==============================================================================

; $0F5299-$0F530F JUMP LOCATION
Sprite_GreenStalfos:
{
    LDY.w $0DE0, X
    
    LDA.w $0F50, X : AND.b #$BF : ORA .vh_flip, Y : STA.w $0F50, X
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckIfRecoiling
    JSR.w Sprite3_CheckDamage
    
    STZ.w $0D90, X
    
    JSR.w Sprite3_DirectionToFacePlayer
    
    LDA.w .facing_direction, Y : CMP.w $002F : BEQ .player_is_facing
    
    TXA : EOR.b $1A : AND.b #$07 : BNE .delay_for_speedup
    
    JSR.w Sprite3_DirectionToFacePlayer
    
    TYA : STA.w $0DE0, X
    
    LDA.w $0DA0, X : CMP.b #$04 : BEQ .finished_accelerating
    
    INC.w $0DA0, X
    
    .finished_accelerating
    
    JSL.l Sprite_ApplySpeedTowardsPlayerLong
    JSR.w Sprite3_IsToRightOfPlayer
    
    TYA : STA.w $0DE0, X
    
    .delay_for_speedup
    
    JSR.w Sprite3_Move
    
    RTS
    
    .player_is_facing
    
    INC.w $0D90, X
    
    TXA : EOR.b $1A : AND.b #$0F : BNE .delay_for_slowdown
    
    LDA.w $0DA0, X : BEQ .finished_decelerating
    
    DEC.w $0DA0, X
    
    .finished_decelerating
    
    JSL.l Sprite_ApplySpeedTowardsPlayerLong
    JSR.w Sprite3_IsToRightOfPlayer
    
    TYA : STA.w $0DE0, X
    
    .delay_for_slowdown
    
    JSR.w Sprite3_Move
    
    RTS
}

; ==============================================================================

