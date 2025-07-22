; ==============================================================================
 
; $02A95B-$02A972 DATA
Pool_Sprite_Rope:
{
    ; $02A95B
    .animation_states
    db $00, $00, $02, $03
    db $02, $03, $01, $01
    
    ; $02A963
    .vh_flip
    db $00, $40, $00, $00
    db $40, $40, $00, $40
    
    ; $02A96B
    .animation_control
    db $04, $05, $02, $03
    db $00, $01, $06, $07
}

; $02A973-$02AA2F JUMP LOCATION
Sprite_Rope:
{
    LDY.w $0D90, X
    
    ; Determine which graphic to use
    LDA.w Pool_Sprite_Rope_animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$3F : ORA Pool_Sprite_Rope_vh_flip, Y : STA.w $0F50, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite2_CheckIfActive
    
    LDA.w $0E90, X : BEQ .on_ground
        LDY.b #$03
        
        ; Modify character index.
        LDA.b ($90), Y : ORA.b #$30 : STA.b ($90), Y
        
        LDA.w $0F70, X : PHA
        
        JSR.w Sprite2_MoveAltitude
        
        LDA.w $0F80, X : CMP.b #$C0 : BMI .at_terminal_falling_speed
            ; Terminal altitude velocity?
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
    
    JSR.w Sprite2_CheckIfRecoiling
    JSR.w Sprite2_CheckDamage
    JSR.w Sprite2_Move
    JSR.w Sprite2_CheckTileCollision
    
    LDA.w $0D80, X : BNE Rope_Moving
    
    JSR.w Sprite2_ZeroVelocity
    
    LDA.w $0DF0, X : BNE .delay
        STZ.w $0ED0, X
        
        JSL.l GetRandomInt : PHA : AND.b #$03 : STA.w $0DE0, X
        
        INC.w $0D80, X
        
        PLA : AND.b #$7F : ADC.b #$40 : STA.w $0DF0, X
        
        JSR.w Sprite2_DirectionToFacePlayer
        
        LDA.b $0E : CLC : ADC.b #$10 : CMP.b #$20 : BCC .player_on_sightline
            LDA.b $0F : CLC : ADC.b #$18 : CMP.b #$20 : BCS .player_not_on_sightline
        
        .player_on_sightline
        
        LDA.b #$04 : STA.w $0ED0, X
        
        TYA : STA.w $0DE0, X
        
        .player_not_on_sightline
    .delay
    
    LDA.b $1A : LSR #4 : LDA.w $0DE0, X : ROL : TAY
    
    LDA.w Pool_Sprite_Rope_animation_control, Y : STA.w $0D90, X
    
    RTS
}

; ==============================================================================

; $02AA30-$02AA43 DATA
Pool_Rope_Moving:
{
    ; $02AA30
    .x_speeds
    db $08, $F8, $00, $00
    db $10, $F0, $00, $00
    
    ; $02AA38
    .y_speeds
    db $00, $00, $08, $F8
    db $00, $00, $10, $F0
    
    ; $02AA40
    .reaction_direction
    db $02, $03, $01, $00
}

; $02AA44-$02AA86 BRANCH LOCATION
Rope_Moving:
{
    LDA.w $0DF0, X : BNE delay
        STZ.w $0D80, X
        
        LDA.b #$20 : STA.w $0DF0, X
    
    .delay
    
    LDY.w $0DE0, X
    
    LDA.w $0E70, X : BEQ .no_tile_collision
        LDA.w Pool_Rope_Moving_reaction_direction, Y : STA.w $0DE0, X : TAY
    
    .no_tile_collision
    
    TYA : CLC : ADC.w $0ED0, X : TAY
    
    LDA.w Pool_Rope_Moving_x_speeds, Y : STA.w $0D50, X
    
    LDA.w Pool_Rope_Moving_y_speeds, Y : STA.w $0D40, X
    
    LDA.b $1A
    
    CPY.b #$04 : BCS .moving_fast
        LSR
    
    .moving_fast
    
    LSR : LSR : LDA.w $0DE0, X : ROL : TAY
    
    LDA.w Pool_Rope_Moving_sanimation_control, Y : STA.w $0D90, X
    
    RTS
}

; ==============================================================================
