
; ==============================================================================
 
; $02A95B-$02A972 DATA
Pool_Sprite_Rope:
{
    .animation_states
    db $00, $00, $02, $03
    db $02, $03, $01, $01
    
    .vh_flip
    db $00, $40, $00, $00
    db $40, $40, $00, $40
    
    .animation_control
    db $04, $05, $02, $03
    db $00, $01, $06, $07
}

; ==============================================================================

; $02A973-$02AA2F JUMP LOCATION
Sprite_Rope:
{
    LDY.w $0D90, X
    
    ; Determine which graphic to use
    LDA .animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$3F : ORA .vh_flip, Y : STA.w $0F50, X
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite2_CheckIfActive
    
    LDA.w $0E90, X : BEQ .on_ground
    
    LDY.b #$03
    
    ; Modify character index
    LDA ($90), Y : ORA.b #$30 : STA ($90), Y
    
    LDA.w $0F70, X : PHA
    
    JSR Sprite2_MoveAltitude
    
    LDA.w $0F80, X : CMP.b #$C0 : BMI .at_terminal_falling_speed
    
    ; terminal altitude velocity?
    SEC : SBC.b #$02 : STA.w $0F80, X
    
    .at_terminal_falling_speed
    
    PLA : EOR.w $0F70, X : BPL .in_air
    
    LDA.w $0F70, X : BPL .in_air
    
    STZ.w $0F70, X
    STZ.w $0F80, X
    STZ.w $0E90, X
    
    LDA.w $0E60, X : AND.b #$EF : STA.w $0E60, X
    
    .in_air
    
    RTS
    
    .on_ground
    
    STZ.w $0E40, X
    
    JSR Sprite2_CheckIfRecoiling
    JSR Sprite2_CheckDamage
    JSR Sprite2_Move
    JSR Sprite2_CheckTileCollision
    
    LDA.w $0D80, X : BNE Rope_Moving
    
    JSR Sprite2_ZeroVelocity
    
    LDA.w $0DF0, X : BNE .delay
    
    STZ.w $0ED0, X
    
    JSL GetRandomInt : PHA : AND.b #$03 : STA.w $0DE0, X
    
    INC.w $0D80, X
    
    PLA : AND.b #$7F : ADC.b #$40 : STA.w $0DF0, X
    
    JSR Sprite2_DirectionToFacePlayer
    
    LDA $0E : CLC : ADC.b #$10 : CMP.b #$20 : BCC .player_on_sightline
    
    LDA $0F : CLC : ADC.b #$18 : CMP.b #$20 : BCS .player_not_on_sightline
    
    .player_on_sightline
    
    LDA.b #$04 : STA.w $0ED0, X
    
    TYA : STA.w $0DE0, X
    
    .player_not_on_sightline
    .delay
    
    LDA $1A : LSR #4 : LDA.w $0DE0, X : ROL A : TAY
    
    LDA .animation_control, Y : STA.w $0D90, X
    
    RTS
}

; ==============================================================================

; $02AA30-$02AA43 DATA
Pool_Rope_Moving:
{
    .x_speeds
    db $08, $F8, $00, $00
    db $10, $F0, $00, $00
    
    .y_speeds
    db $00, $00, $08, $F8
    db $00, $00, $10, $F0
    
    .reaction_direction
    db $02, $03, $01, $00
}

; ==============================================================================

; $02AA44-$02AA86 BRANCH LOCATION
Rope_Moving:
{
    LDA.w $0DF0, X : BNE delay
    
    STZ.w $0D80, X
    
    LDA.b #$20 : STA.w $0DF0, X
    
    .delay
    
    LDY.w $0DE0, X
    
    LDA.w $0E70, X : BEQ .no_tile_collision
    
    LDA.w $AA40, Y : STA.w $0DE0, X : TAY
    
    .no_tile_collision
    
    TYA : CLC : ADC.w $0ED0, X : TAY
    
    LDA .x_speeds, Y : STA.w $0D50, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    LDA $1A
    
    CPY.b #$04 : BCS .moving_fast
    
    LSR A
    
    .moving_fast
    
    LSR #2 : LDA.w $0DE0, X : ROL A : TAY
    
    LDA .animation_control, Y : STA.w $0D90, X
    
    RTS
}

; ==============================================================================
