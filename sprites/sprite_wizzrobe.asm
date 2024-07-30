
; ==============================================================================

    ; UNUSED: Not certain yet, but seems to be the case.
; $0F1D17-$0F1D1A DATA
Pool_Sprite_WizzrobeAndBeam:
{
    db $03, $43, $C3, $83
}

; ==============================================================================

; $0F1D1B-$0F1D45 JUMP LOCATION
Sprite_WizzrobeAndBeam:
{
    LDA.w $0DB0, X : BEQ Sprite_Wizzrobe
    
    ; NOTE: Not invoked, just put in to be informative.
    shared Sprite_Wizzbeam:
    
    JSL Wizzbeam_Draw
    JSR Sprite3_CheckIfActive
    
    ; Toggle palette each frame.
    LDA.w $0F50, X : EOR.b #$06 : STA.w $0F5050, X
    
    INC.w $0E80, X
    
    ; \tcrf(unconfirmed) Is this a debug thing where they made impotent
    ; wizzbeams at one point?
    LDA.w $0D80, X : BNE .harmless
    
    JSR Sprite3_CheckDamageToPlayer
    
    .harmless
    
    JSR Sprite3_Move
    
    JSR Sprite3_CheckTileCollision : BEQ .dont_self_terminate
    
    STZ.w $0DD0, X
    
    .dont_self_terminate
    
    RTS
}

; ==============================================================================

; $0F1D46-$0F1D79 BRANCH LOCATION
Sprize_Wizzrobe:
{
    LDA.w $0D80, X : BEQ .invisible
    AND.b #$01   : BEQ .draw
    
    ; (That is, draw every other frame)
    LDA.w $0DF0, X : AND.b #$01 : BEQ .flicker_draw
    
    .invisible
    
    JSL Sprite_PrepOamCoordLong
    
    BRA .skip_draw_logic
    
    .draw
    .flicker_draw
    
    JSL Wizzrobe_Draw
    
    .skip_draw_logic
    
    JSR Sprite3_CheckIfActive
    JSR Sprite3_CheckIfRecoiling
    
    ; NOTE: Interesting. If we removed this they could possibly be
    ; vulnerable even when invisible?
    LDA.b #$01 : STA.w $0BA0, X
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Wizzrobe_Cloaked
    dw Wizzrobe_PhasingIn
    dw Wizzrobe_Attack
    dw Wizzrobe_PhasingOut
}

; ==============================================================================

; $0F1D7A-$0F1D7D DATA
Pool_Wizzrobe_Cloaked:
{
    ; TODO: Name this routine / pool.
    .animation_states
    db 4, 2, 0, 6
}

; ==============================================================================

; $0F1D7E-$0F1DA9 JUMP LOCATION
Wizzrobe_Cloaked:
{
    ; NOTE: Worth mentioning that it's also invincible in this state.
    
    LDA.w $0DF0, X : BNE .delay
    
    ; Check tile collision just to the right and up.
    LDA.b #$01 : STA.w $0D50, X
                 STA.w $0D40, X
    
    JSR Sprite3_CheckTileCollision : BNE .self_terminate
    
    INC.w $0D80, X
    
    LDA.b #$3F : STA.w $0DF0, X
    
    JSR Sprite3_DirectionToFacePlayer
    
    TYA : STA.w $0DE0, X
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
    
    .self_terminate
    
    STZ.w $0DD0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F1DAA-$0F1DB7 JUMP LOCATION
Wizzrobe_PhasingIn:
{
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$3F : STA.w $0DF0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F1DB8-$0F1DC3 DATA
Pool_Wizzrobe_Attack:
{
    .animation_states
    db 0, 1, 1, 1, 1, 1, 1, 0
    
    .animation_state_offsets
    db 4, 2, 0, 6
}

; ==============================================================================

; $0F1DC4-$0F1DF2 JUMP LOCATION
Wizzrobe_Attack:
{
    STZ.w $0BA0, X
    
    JSR Sprite3_CheckDamage
    
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$3F : STA.w $0DF0, X
    
    RTS
    
    .delay
    
    CMP.b #$20 : BNE .dont_shoot_beam
    
    PHA
    
    JSR Wizzrobe_SpawnBeam
    
    PLA
    
    .dont_shoot_beam
    
    LSR #3 : TAY
    
    LDA .animation_states, Y
    
    LDY.w $0DE0, X
    
    CLC : ADC .animation_state_offsets, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F1DF3-$0F1E0E JUMP LOCATION
Wizzrobe_PhasingOut:
{
    LDA.w $0DF0, X : BNE .delay
    
    LDA.w $0DA0, X : BEQ .persistent
    
    ; Some overlords generate temporary Wizzrobes that don't respawn in
    ; the same location when they phase out. This ensures they don't phase
    ; back in. The overlord would set this variable to a nonzero value.
    STZ.w $0DD0, X
    
    .persistent
    
    STZ.w $0D80, X
    
    JSL GetRandomInt : AND.b #$1F : ADC.b #$20 : STA.w $0DF0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F1E0F-$0F1E14 DATA
Pool_Wizzrobe_SpawnBeam:
{
    .x_speeds length 4
    db $20, $E0
    
    .y_speeds
    db $00, $00, $20, $E0
}

; ==============================================================================

; $0F1E15-$0F1E7A LOCAL JUMP LOCATION
Wizzrobe_SpawnBeam:
{
    LDA.b #$9B : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA.b #$36 : JSL Sound_SetSfx3PanLong
    
    LDA.b #$01 : STA.w $0DB0, Y
                 STA.w $0BA0, Y
    
    LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
    LDA.b $01 : ADC.b #$00 : STA.w $0D30, Y
    
    LDA.b $02 : CLC : ADC.b #$00 : STA.w $0D00, Y
    LDA.b $03 : ADC.b #$00 : STA.w $0D20, Y
    
    PHX
    
    LDA.w $0DE0, X : TAX
    
    LDA .x_speeds, X : STA.w $0D50, Y
    
    LDA .y_speeds, X : STA.w $0D40, Y
    
    LDA.b #$48 : STA.w $0CAA, Y
    
    LDA.b #$02 : STA.w $0F50, Y
    
    ; \item
    LDA.l $7EF35A : TAX
    
    LDA.b #$00
    
    CPX.b #$03 : BNE .player_lacks_mirror_shield
    
    ; Indicate to the beam that it's blockable by shield. durp.
    LDA.b #$20
    
    .player_lacks_mirror_shield
    
    STA.w $0BE0, Y
    
    PLX
    
    LDA.b #$14 : STA.w $0F60, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================
