
; ==============================================================================

; $0315C9-$0315D8 DATA
Pool_Sprite_Sluggula:
{
    .animation_states
    db 0, 1, 0, 1, 2, 3, 4, 5
    
    .h_flip
    db $40, $40, $00, $00, $00, $00, $00, $00
}

; ==============================================================================

; $0315D9-$031614 JUMP LOCATION
Sprite_Sluggula:
{
    LDA.w $0E80, X : AND.b #$08 : LSR #3 : STA.b $00
    
    LDA.w $0DE0, X : ASL A : ORA.b $00 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$BF : ORA .h_flip, Y : STA.w $0F50, X
    
    JSR Sprite_PrepAndDrawSingleLarge
    JSR Sprite_CheckIfActive
    JSR Sprite_CheckIfRecoiling
    JSR Sprite_CheckDamage
    
    INC.w $0E80, X
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Sluggula_Normal
    dw Sluggula_BreakFromBombing:
}

; ==============================================================================

; $031615-$03161A DATA
Pool_Sluggula_Normal:
{
    .x_speeds length 4
    db 16, -16
    
    .y_speeds
    db  0,   0,  16, -16
}

; ==============================================================================

; $03161B-$031672 JUMP LOCATION
Sluggula_Normal:
{
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    JSL GetRandomInt : AND.b #$1F : ADC.b #$20 : STA.w $0DF0, X
    
    AND.b #$03 : STA.w $0DE0, X
    
    .set_speed
    
    TAY
    
    LDA.w $9615, Y : STA.w $0D50, X
    
    LDA.w $9617, Y : STA.w $0D40, X
    
    RTS
    
    .delay
    
    CMP.b #$10 : BNE .return
    
    JSL GetRandomInt : LSR A : BCS .return
    
    JMP Sluggula_LayBomb
    
    ; $03164F ALTERNATE ENTRY POINT
    shared Sluggula_BreakFromBombing:
    
    LDA.w $0DF0, X : BNE .delay_resumption_of_bombing
    
    STZ.w $0D80, X
    
    LDA.b #$20 : STA.w $0DF0, X
    
    .delay_resumption_of_bombing
    
    JSR Sprite_Move
    JSR Sprite_CheckTileCollision
    
    LDA.w $0E70, X : BEQ .return
    
    LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
    
    JMP .set_speed
    
    .return
    
    RTS
}

; ==============================================================================

; $031673-$031685 JUMP LOCATION
Sluggula_LayBomb:
{
    ; Spawn a Red Bomb Soldier...
    LDA.b #$4A
    LDY.b #$0B
    
    JSL Sprite_SpawnDynamically.arbitrary : BMI .spawn_failed
    
    JSL Sprite_SetSpawnedCoords
    
    ; ... but once spawned, transmute it to an enemy bomb.
    JSL Sprite_TransmuteToEnemyBomb
    
    .spawn_failed
    
    RTS
}

; ==============================================================================
