
    !is_nucleus_expelled = $0D90

; ==============================================================================

; $0ECCDB-$0ECCDE DATA
Pool_Sprite_GiboNucleus:
{
    .vh_flip
    db $00, $40, $C0, $80
}

; ==============================================================================

; $0ECCDF-$0ECCE0 DATA
Pool_Gibo_Draw:
{
    .palettes
    db $0B, $07
}

; ==============================================================================

; $0ECCE1-$0ECD11 JUMP LOCATION
Sprite_Gibo:
{
    LDA.w $0DA0, X : BEQ Gibo_Main
    
    shared Sprite_GiboNucleus:
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite4_CheckIfActive
    JSR Sprite4_CheckDamage
    
    INC.w $0E80, X
    
    LDA.w $0E80, X : LSR #2 : AND.b #$03 : TAY
    
    LDA.w $0F50, X : AND.b #$3F : ORA .vh_flip, Y : STA.w $0F50, X
    
    LDA !timer_0, X : BEQ .halt_movement
    
    JSR Sprite4_Move
    JSR Sprite4_BounceFromTileCollision
    
    .halt_movement
    
    RTS
}

; ==============================================================================

; $0ECD12-$0ECD61 BRANCH LOCATION
Gibo_Main:
{
    JSR Gibo_Draw
    JSR Sprite4_CheckIfActive
    
    INC.w $0EC0, X
    
    LDY.w $0EB0, X
    
    LDA.w $0DD0, Y : CMP.b #$06 : BNE .nucleus_not_dying
    
    STA.w $0DD0, X
    
    LDA !timer_0, Y : STA !timer_0, X
    
    LDA.w $0E40, X : CLC : ADC.b #$04 : STA.w $0E40, X
    
    RTS
    
    .nucleus_not_dying
    
    LDA.b $1A : LSR #3 : AND.b #$03 : STA.w $0E80, X
    
    LDA.b $1A : AND.b #$3F : BNE .dont_pursue_player
    
    JSR Sprite4_IsToRightOfPlayer
    
    TYA : ASL #2 : STA.w $0DE0, X
    
    .dont_pursue_player
    
    JSL Sprite_CheckDamageToPlayerLong
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Gibo_ExpelNucleus
    dw Gibo_DelayPursuit
    dw Gibo_PursueNucleus
}

; ==============================================================================

; $0ECD62-$0ECD71 DATA
Pool_Gibo_ExpelNucleus:
{
    .x_speeds
    db  16,  16,   0, -16, -16, -16,   0,  16
    
    .y_speeds
    db   0,   0,  16, -16,  16,  16, -16, -16
}

; ==============================================================================

; $0ECD72-$0ECDE1 JUMP LOCATION
Gibo_ExpelNucleus:
{
    LDA !timer_0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$30 : STA !timer_0, X
    
    INC !is_nucleus_expelled, X
    
    ; BUG: Maybe. What if the nucleus fails to spawn? Will the thing
    ; just break completely? It's good that they check the return value,
    ; but it shouldn't advance to the next AI state, imo.
    LDA.b #$C3 : JSL Sprite_SpawnDynamically : BMI .nucleus_spawn_failed
    
    JSL Sprite_SetSpawnedCoords
    
    ; Store the index of the spawned child sprite (Gibo nucleus).
    TYA : STA.w $0EB0, X
    
    LDA.b #$01 : STA.w $0E40, Y
                 STA.w $0DA0, Y
    
    LDA.b #$10 : STA.w $0E60, Y
    
    LDA.w $0ED0, X : STA.w $0E50, Y
    
    LDA.b #$07 : STA.w $0F50, Y
    
    LDA.b #$30 : STA !timer_0, Y
    
    PHX
    
    INC.w $0DB0, X : LDA.w $0DB0, X : CMP.b #$03 : BNE .pick_random_direction
    
    ; Otherwise pursue the player? TODO: confirm that it's not fleeing
    ; in this case.
    STZ.w $0DB0, X
    
    PHY
    
    JSR Sprite4_DirectionToFacePlayer : TYX
    
    PLY
    
    BRA .set_xy_speeds
    
    .pick_random_direction
    
    JSL GetRandomInt : AND.b #$07 : TAX
    
    .set_xy_speeds
    
    LDA .x_speeds, X : STA.w $0D50, Y
    
    LDA .y_speeds, X : STA.w $0D40, Y
    
    PLX
    
    .nucleus_spawn_failed
    
    RTS
    
    .delay
    
    ; TODO: Terrible branch name, but maybe semiaccurate.
    CMP.b #$20 : BNE .dont_special_draw
    
    STA !timer_1, X
    
    .dont_special_draw
    
    RTS
}

; ==============================================================================

; $0ECDE2-$0ECDEA JUMP LOCATION
Gibo_DelayPursuit:
{
    LDA !timer_0, X : BNE .delay
    
    INC.w $0D80, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0ECDEB-$0ECE5D JUMP LOCATION
Gibo_PursueNucleus:
{
    TXA : EOR.b $1A : AND.b #$03 : BNE .stagger_retargeting
    
    ; NOTE: Y was preloaded with the index of the nucleus before calling
    ; this.
    LDA.w $0D10, Y : STA.b $04
    LDA.w $0D30, Y : STA.b $05
    
    LDA.w $0D00, Y : STA.b $06
    LDA.w $0D20, Y : STA.b $07
    
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.b $04 : CLC : ADC.w #$0002 : CMP.w #$0004 : BCS .dont_recombine
    
    LDA.w $0FDA : SEC : SBC.b $06 : CLC : ADC.w #$0002 : CMP.w #$0004 : BCS .dont_recombine
    
    SEP #$20
    
    LDY.w $0EB0, X
    
    ; Terminate the nucleus now that we've recombined (another will spawn
    ; soon).
    LDA.b #$00 : STA.w $0DD0, Y
    
    STZ !is_nucleus_expelled, X
    
    STZ.w $0D80, X
    
    LDA.w $0E50, Y : STA.w $0ED0, X
    
    JSL GetRandomInt : AND.b #$1F : ADC.b #$20 : STA !timer_0, X
    
    RTS
    
    .dont_recombine
    
    SEP #$20
    
    ; Go towards the nucleus.
    LDA.b #$10 : JSL Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    
    LDA.b $01 : STA.w $0D50, X
    
    .stagger_retargeting
    
    JSR Sprite4_Move
    
    RTS
}

; ==============================================================================

; $0ECE5E-$0ECF5D DATA
Pool_Gibo_Draw:
{
    .oam_groups
    dw  4, -4 : db $8A, $40, $00, $02
    dw -4, -4 : db $8F, $40, $00, $00
    dw 12, 12 : db $8E, $40, $00, $00
    dw -4,  4 : db $8C, $40, $00, $02
    
    dw  4, -4 : db $AA, $40, $00, $02
    dw -4, -4 : db $9F, $40, $00, $00
    dw 12, 12 : db $9E, $40, $00, $00
    dw -4,  4 : db $AC, $40, $00, $02
    
    dw  3, -3 : db $AA, $40, $00, $02
    dw -3, -3 : db $9F, $40, $00, $00
    dw 11, 11 : db $9E, $40, $00, $00
    dw -3,  3 : db $AC, $40, $00, $02
    
    dw  3, -3 : db $8A, $40, $00, $02
    dw -3, -3 : db $8F, $40, $00, $00
    dw 11, 11 : db $8E, $40, $00, $00
    dw -3,  3 : db $8C, $40, $00, $02
    
    dw -3, -4 : db $8A, $00, $00, $02
    dw 13, -4 : db $8F, $00, $00, $00
    dw -3, 12 : db $8E, $00, $00, $00
    dw  5,  4 : db $8C, $00, $00, $02
    
    dw -3, -4 : db $AA, $00, $00, $02
    dw 13, -4 : db $9F, $00, $00, $00
    dw -3, 12 : db $9E, $00, $00, $00
    dw  5,  4 : db $AC, $00, $00, $02
    
    dw -2, -3 : db $AA, $00, $00, $02
    dw 12, -3 : db $9F, $00, $00, $00
    dw -2, 11 : db $9E, $00, $00, $00
    dw  4,  3 : db $AC, $00, $00, $02
    
    dw -2, -3 : db $8A, $00, $00, $02
    dw 12, -3 : db $8F, $00, $00, $00
    dw -2, 11 : db $8E, $00, $00, $00
    dw  4,  3 : db $8C, $00, $00, $02
}

; ==============================================================================

; $0ECF5E-$0ECFC2 LOCAL JUMP LOCATION
Gibo_Draw:
{
    LDA !is_nucleus_expelled, X : BNE .is_currently_expelled
    
    LDA.w $0E40, X : PHA
    
    LDA.b #$01 : STA.w $0E40, X
    
    LDA !timer_1, X : AND.b #$04 : LSR #2 : STA.b $00
    
    LDA.w $0EC0, X : LSR #2 : AND.b #$03 : TAY
    
    LDA.w $0F50, X : PHA
    
    LDA Sprite_GiboNucleus.vh_flip, Y
    
    LDY.b $00
    
    ORA .palettes, Y : STA.w $0F50, X
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    PLA : STA.w $0F50, X
    PLA : STA.w $0E40, X
    
    .is_currently_expelled
    
    LDA.b #$00 : XBA
    
    LDA.w $0E80, X : CLC : ADC.w $0DE0, X
    
    REP #$20
    
    ASL #5 : ADC.w #.oam_groups : STA.b $08
    
    REP #$20
    
    LDA.b $90 : CLC : ADC.w #$0008 : STA.b $90
    
    INC.b $92 : INC.b $92
    
    SEP #$20
    
    LDA.b #$04 : JMP Sprite4_DrawMultiple
}

; ==============================================================================
