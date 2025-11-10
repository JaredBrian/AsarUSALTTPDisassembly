; ==============================================================================

; $0F181D-$0F1858 JUMP LOCATION
Sprite_Freezor:
{
    JSL.l Freezor_Draw
    
    ; Essentially this is to find out if it was hit with a fire
    ; attack and make it melt instantly in that event.
    LDA.w $0DD0, X : CMP.b #$09 : BEQ .in_basic_active_state
    	LDA.b #$03 : STA.w $0D80, X
    
    	LDA.b #$1F : STA.w $0DF0, X
                     STA.w $0BA0, X
    
    	LDA.b #$09 : STA.w $0DD0, X
    
    	STZ.w $0EF0, X
    
    .in_basic_active_state
    
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0D80, X : CMP.b #$03 : BEQ .ignore_recoil_if_melting
    	JSR.w Sprite3_CheckIfRecoiling
    
    .ignore_recoil_if_melting
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Freezor_Stasis    ; 0x00 - $9859
    dw Freezor_Awakening ; 0x01 - $9871
    dw Freezor_Moving    ; 0x02 - $98D2
    dw Freezor_Melting   ; 0x03 - $9942
}

; ==============================================================================

; $0F1859-$0F1870 JUMP LOCATION
Freezor_Stasis:
{
    INC.w $0BA0, X
    
    JSR.w Sprite3_IsToRightOfPlayer
    
    LDA.b $0F : CLC : ADC.b #$10 : CMP.b #$20 : BCS .player_not_in_horiz_range
    	INC.w $0D80, X
    
    	LDA.b #$20 : STA.w $0DF0, X
    
    .player_not_in_horiz_range
    
    RTS
}

; ==============================================================================

; $0F1871-$0F18B7 JUMP LOCATION
Freezor_Awakening:
{
    LDA.w $0DF0, X : STA.w $0BA0, X
    BNE .shaking
    	INC.w $0D80, X
    
    	LDA.w $0D10, X : SEC : SBC.b #$05 : STA.b $00
    	LDA.w $0D30, X : SEC : SBC.b #$00 : STA.b $01
    
    	LDA.w $0D00, X : STA.b $02
    	LDA.w $0D20, X : STA.b $03
    
    	LDY.b #$08
        JSL.l Dungeon_SpriteInducedTilemapUpdate
    
    	LDA.b #$60 : STA.w $0E00, X
    
    	LDA.b #$02 : STA.w $0DE0, X
    
    	LDA.b #$50 : STA.w $0DF0, X
    
    	RTS
    
    .shaking
    
    AND.b #$01 : TAY
    LDA Sprite3_Shake_x_speeds, Y : STA.w $0D50, X
    
    JSR.w Sprite3_MoveHoriz
    
    RTS
}

; ==============================================================================

; $0F18B8-$0F18D1 DATA
Pool_Freezor_Moving:
{
    ; $0F18B8
    .x_speeds ; Bleeds into the next block
    db $08, $F8
    
    ; $0F18BA
    .y_speeds
    db $00, $00, $12, $EE
    
    ; $0F18BE
    .animation_states
    db $01, $02, $01, $03
    
    ; $0F18C2
    .sparkle_x_offsets_low
    db $FC, $FE, $00, $02, $04, $06, $08, $0A
    
    ; $0F18CA
    .sparkle_x_offsets_high
    db $FF, $FF, $00, $00, $00, $00, $00, $00
}

; $0F18D2-$0F193D JUMP LOCATION
Freezor_Moving:
{
    JSR.w Sprite3_CheckDamageToPlayer
    
    JSL.l Sprite_CheckDamageFromPlayerLong : BCC .no_damage_contact
    	STZ.w $0EF0, X
    
    .no_damage_contact
    
    LDA.w $0E00, X : BEQ .dont_spawn_sparkle
    	TXA : EOR.b $1A : AND.b #$07 : BNE .dont_spawn_sparkle
            JSL.l GetRandomInt : AND.b #$07 : TAY
            LDA.w Pool_Freezor_Moving_sparkle_x_offsets_low, Y  : STA.b $00
            LDA.w Pool_Freezor_Moving_sparkle_x_offsets_high, Y : STA.b $01
        
            LDA.b #$FC : STA.b $02
            LDA.b #$FF : STA.b $03
        
            JSL.l Sprite_SpawnSimpleSparkleGarnish
    
    .dont_spawn_sparkle
    
    LDA.w $0DF0, X : BNE .dont_track_player_yet
    	JSR.w Sprite3_DirectionToFacePlayer : TYA : STA.w $0DE0, X
    
    .dont_track_player_yet
    
    LDY.w $0DE0, X
    
    ; NOTE: The Y speeds are faster than the X speeds.
    LDA.w Pool_Freezor_Moving_x_speeds, Y : STA.w $0D50, X
    LDA.w Pool_Freezor_Moving_y_speeds, Y : STA.w $0D40, X
    
    LDA.w $0E70, X : AND.b #$0F : BNE .tile_collision_occurred
    	JSR.w Sprite3_Move
    
    .tile_collision_occurred
    
    JSR.w Sprite3_CheckTileCollision
    
    TXA : EOR.b $1A : LSR : LSR : AND.b #$03 : TAY
    LDA.w Pool_Freezor_Moving_animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F193E-$0F1941 DATA
Freezor_Melting_animation_states:
{
    db $06, $05, $04, $07
}

; $0F1942-$0F195A JUMP LOCATION
Freezor_Melting:
{
    LDA.w $0DF0, X : BNE .not_dead_yet
    	PHA
    
    	JSL.l Dungeon_ManuallySetSpriteDeathFlag
    
    	STZ.w $0DD0, X
    
    	PLA
    
    .not_dead_yet
    
    LSR #3 : TAY
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================
