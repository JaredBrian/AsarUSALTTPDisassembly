; ==============================================================================

; $0F4103-$0F411F JUMP LOCATION
Sprite_Kodondo:
{
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckIfRecoiling
    JSR.w Sprite3_CheckDamage
    
    STZ.w $0B6B, X
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Kodondo_ChooseDirection ; 0x00 - $C128
    dw Kodondo_Move            ; 0x01 - $C178
    dw Kodondo_BreatheFlame    ; 0x02 - $C1D6
}

; ==============================================================================

; $0F4120-$0F4127 DATA
Pool_Kodondo_ChooseDirection:
{
    ; $0F4120
    .x_speeds
    db $01, $FF, $00, $00
    
    ; $0F4124
    .y_speeds
    db $00, $00, $01, $FF
}

; $0F4128-$0F4167 JUMP LOCATION
Kodondo_ChooseDirection:
{
    INC.w $0D80, X
    
    JSL.l GetRandomInt : AND.b #$03 : STA.w $0DE0, X
    
    LDA.b #$B0 : STA.w $0B6B, X
    
    .try_another_direction
    
    	LDY.w $0DE0, X
    
    	LDA.w Pool_Kodondo_ChooseDirection_x_speeds, Y : STA.w $0D50, X
    
    	LDA.w Pool_Kodondo_ChooseDirection_y_speeds, Y : STA.w $0D40, X
    
    	JSR.w Sprite3_CheckTileCollision : BEQ .no_tile_collision
    	    LDA.w $0DE0, X : INC A : AND.b #$03 : STA.w $0DE0, X
    
    	; BUG: I'm thinking this could potentially crash the game... (in the
    	; sense that it would be stuck in this loop, not go off the rails
    	; completely)
    BRA .try_another_direction
    
    .no_tile_collision

    ; Bleeds into the next function.
}
    
; $0F4158 ALTERNATE ENTRY POINT
Kodondo_SetSpeed:
{
    LDY.w $0DE0, X
    
    LDA Sprite3_Shake_x_speeds, Y : STA.w $0D50, X
    
    LDA Sprite3_Shake_y_speeds, Y : STA.w $0D40, X
    
    RTS
}

; ==============================================================================

; $0F4168-$0F4177 DATA
Pool_Kodondo_Move:
{
    ; $0F4168
    .animation_states
    db $02, $02, $00, $05, $03, $03, $00, $05
    
    ; $0F4170
    .vh_flip_override
    db $40, $00, $00, $00, $40, $00, $40, $40
}

; $0F4178-$0F41CD JUMP LOCATION
Kodondo_Move:
{
    JSR.w Sprite3_Move
    
    JSR.w Sprite3_CheckTileCollision : BEQ .no_tile_collision
    	LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
    
    	JSR.w Kodondo_SetSpeed
    
    .no_tile_collision
    
    ; This logic sets up an invisible grid of points at which the Kodondo
    ; can potentially breath flames. It's still semi random as indicated
    ; below, though.
    LDA.w $0D10, X : AND.b #$1F : CMP.b #$04 : BNE .dont_breathe_flame
    	LDA.w $0D00, X : AND.b #$1F : CMP.b #$1B : BNE .dont_breathe_flame
    	    JSL.l GetRandomInt : AND.b #$03 : BNE .dont_breathe_flame
    		LDA.b #$6F : STA.w $0DF0, X
    
    		INC.w $0D80, X
    
    		STZ.w $0D90, X
    
    .dont_breathe_flame
    
    INC.w $0E80, X
    
    LDA.w $0E80, X : AND.b #$04 : ORA.w $0DE0, X : TAY
    
    LDA.w ORA Pool_Kodondo_Move_animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$BF
    ORA Pool_Kodondo_Move_vh_flip_override, Y : STA.w $0F50, X
    
    RTS
}

; ==============================================================================

; $0F41CE-$0F41D5 DATA
Kodondo_BreatheFlames_animation_states:
{
    db $02, $02, $00, $05
    db $04, $04, $01, $06
}

; $0F41D6-$0F4204 JUMP LOCATION
Kodondo_BreatheFlame:
{
    LDA.w $0DF0, X : BNE .dont_revert_yet
        STZ.w $0D80, X
    
    .dont_revert_yet
    
    LDY.b #$00
    
    SEC : SBC.b #$20 : CMP.b #$30 : BCS .cant_spawn
        LDY.b #$04
    
    .cant_spawn
    
    CPY.b #$04 : BNE .dont_spawn_flame    
    	LDA.w $0DF0, X : AND.b #$0F : BNE .dont_spawn_flame
    	    PHY
    
    	    JSR.w Kodondo_SpawnFlames
    
    	    PLY
    
    .dont_spawn_flame
    
    TYA : ORA.w $0DE0, X : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F4205-$0F4222 DATA
Pool_Kodondo_SpawnFlames:
{
    ; $0F4205
    .x_offsets_low
    db $08, $F8, $00, $00
    
    ; $0F4209
    .x_offsets_high
    db $00, $FF, $00, $00
    
    ; $0F420D
    .y_offsets_low
    db $00, $00, $08, $F8
    
    ; $0F4211
    .y_offsets_high
    db $00, $00, $00, $FF
    
    ; $0F4215
    .x_speeds
    db $18, $E8, $00, $00
    
    ; $0F4219
    .y_speeds
    db $00, $00, $18, $E8
    
    ; \tcrf Not really major, but curious nonetheless
    ; $0F421D
    .unused
    db $40, $38, $30, $28, $20, $18
}

; $0F4223-$0F4266 LOCAL JUMP LOCATION
Kodondo_SpawnFlames:
{
    LDA.b #$87
    LDY.b #$0D
    
    JSL.l Sprite_SpawnDynamically_arbitrary : BMI .spawn_failed
    	PHX
    
    	LDA.w $0DE0, X : TAX
    
    	LDA.b $00 : CLC : ADC Pool_Kodondo_SpawnFlames_x_offsets_low, X  : STA.w $0D10, Y
    	LDA.b $01 :       ADC Pool_Kodondo_SpawnFlames_x_offsets_high, X : STA.w $0D30, Y
    
    	LDA.b $02 : CLC : ADC Pool_Kodondo_SpawnFlames_y_offsets_low, X  : STA.w $0D00, Y
    	LDA.b $03 :       ADC Pool_Kodondo_SpawnFlames_y_offsets_high, X : STA.w $0D20, Y
    
    	LDA.w Pool_Kodondo_SpawnFlames_x_speeds, X : STA.w $0D50, Y
    
    	LDA.w Pool_Kodondo_SpawnFlames_y_speeds, X : STA.w $0D40, Y
    
    	LDA.b #$01 : STA.w $0BA0, Y
    
    	PLX
    
    .spawn_failed
    
    RTS
} 

; ==============================================================================
