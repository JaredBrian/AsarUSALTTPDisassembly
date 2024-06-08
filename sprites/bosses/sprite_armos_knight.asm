
; ==============================================================================

; $02A031-$02A035 DATA
Pool_Sprite_ArmosKnight:
{
    .death_animation_states
    db $05, $04, $03, $02, $01
}

; ==============================================================================

; $02A036-$02A18E JUMP LOCATION
Sprite_ArmosKnight:
{
    ; Graphic clip array. Determines how it is displayed relative to other
    ; backgrounds.
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSR ArmosKnight_Draw
    JSR Sprite2_CheckIfActive.permissive
    
    LDA.w $0DD0, X : CMP.b #$09 : BEQ .alive
    
    LDA.w $0DF0, X : BNE .still_dying
    
    ; Knock one guy off our boss roster.
    DEC.w $0FF8
    
    ; If there's one Armos left...
    LDA.w $0FF8 : CMP.b #$01 : BNE .more_than_one
    
    ; Change this Armos to the last one, the red pounder one.
    LDY.b #$05
    
    .keep_healing
    
    LDA.b #$30 : STA.w $0E50, Y ; Restore the life of the remaining Armos knights.
    
    LDA.b #$00 : STA.w $0D50, Y : STA.w $0D40, Y : STA.w $0F80, Y
    
    DEY : BPL .keep_healing
    
    .more_than_one:
    
    ; Kill this Armos knight off.
    STZ.w $0DD0, X
    
    JSL Sprite_VerifyAllOnScreenDefeated : BCC .not_all_dead
    
    LDA.b #$EA : JSL Sprite_SpawnDynamically
    
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$20 : STA.w $0F80, Y
    LDA.b #$01 : STA.w $0D90, Y
    
    .not_all_dead
    
    RTS
    
    .still_dying
    
    LSR #3 : TAY
    
    ; Pick the proper graphic for his death! ^_^
    LDA .death_animation_states, Y : STA.w $0DC0, X
    
    RTS
    
    .alive
    
    JSR Sprite2_Move
    JSR Sprite2_MoveAltitude
    
    LDA.w $0F80, X : SEC : SBC.b #$04 : STA.w $0F80, X
    
    LDA.w $0F70, X : BPL .zeta
    
    STZ.w $0F80, X
    STZ.w $0F70, X
    
    LDA.w $0FF8 : CMP.b #$01 : BEQ .zeta
    
    LDA.w $0D90, X : BEQ .zeta
    
    LDA.b #$30 : STA.w $0F80, X
    
    LDA.b #$16 : JSL Sound_SetSfx3PanLong
    
    .zeta
    
    LDA.w $0EA0, X : BEQ .theta
    
    JSR Sprite2_ZeroVelocity
    
    STZ.w $0D80, X
    STZ.w $0ED0, X
    
    .theta
    
    JSR Sprite2_CheckIfRecoiling
    
    LDA.w $0D90, X : BNE .iota
    
    LDA.w $0DF0, X : BNE .kappa
    
    INC.w $0D90, X ; This is the point where the Armos Knights become hittable
    
    ; Make the sprite be harmful now
    LDA.w $0E40, X : AND.b #$7F : DEC #2 : STA.w $0E40, X
    
    ; Make the sprite take damage from a sword
    LDA.w $0CAA, X : AND.b #$FB : STA.w $0CAA, X
    
    ; Make the sprite not invincible 
    LDA.w $0E60, X : AND.b #$BF : STA.w $0E60, X
    
    RTS
    
    .kappa
    
    CMP.b #$40 : BNE .lambda
    
    LDY.b #$35 : STY.w $012E
    
    .lambda
    
    BCS .mu
    
    LSR A : EOR.w $0FA0 : AND.b #$01 : TAY
    
    LDA.w $95FC, Y : STA.w $0D50, X
    
    JSR Sprite2_MoveHoriz
    
    STZ.w $0D50, X
    
    .mu
    
    JSL Sprite_CheckDamageFromPlayerLong
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .nu
    
    JSL Sprite_NullifyHookshotDrag
    JSL Sprite_RepelDashAttackLong
    
    .nu
    
    RTS
    
    .iota
    
    LDA.w $0FF8 : CMP.b #$01 : BEQ .crusher_state
    
    JSR Sprite2_CheckDamage
    
    LDA.w $0D80, X : BNE .omicron
    
    JSR ArmosKnight_ProjectSpeedTowardsTarget
    JSL Sprite_Get_16_bit_CoordsLong
    
    REP #$20
    
    LDA.b $04 : SEC : SBC.w $0FD8 : CLC : ADC.w #2 : CMP.w #4 : BCS .pi
    
    LDA.b $06 : SEC : SBC.w $0FDA : CLC : ADC.w #2 : CMP.w #4 : BCS .pi
    
    SEP #$20
    
    INC.w $0D80, X
    
    .pi
    
    SEP #$20
    
    RTS
    
    .omicron
    
    LDA.w $0B10, X : STA.w $0D10, X
    LDA.w $0B20, X : STA.w $0D30, X
    
    LDA.w $0B30, X : STA.w $0D00, X
    LDA.w $0B40, X : STA.w $0D20, X
    
    RTS
    
    .crusher_state
    
    JSL Sprite_ArmosCrusherLong
    
    RTS
}

; ==============================================================================
    
; $02A18F-$02A1B3 LOCAL JUMP LOCATION
ArmosKnight_ProjectSpeedTowardsTarget:
{
    LDA.w $0B10, X : STA.b $04
    LDA.w $0B20, X : STA.b $05
    
    LDA.w $0B30, X : STA.b $06
    LDA.w $0B40, X : STA.b $07
    
    LDA.b #$10
    
    JSL Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    LDA.b $01 : STA.w $0D50, X
    
    RTS
}

; ==============================================================================

; $02A1B4-$02A273 DATA
Pool_ArmosKnight_Draw:
{
    .x_offsets
    dw  -8,  8,  -8,  8
    dw -10, 10, -10, 10
    dw -10, 10, -10, 10
    dw -12, 12, -12, 12
    dw -14, 14, -14, 14
    dw -16, 24, -16, 24
    
    ; $2A1E4
    .y_offsets
    dw  -8,  -8,  8,  8
    dw -10, -10, 10, 10
    dw -10, -10, 10, 10
    dw -12, -12, 12, 12
    dw -14, -14, 14, 14
    dw -16, -16, 24, 24
    
    ; $2A214
    .chr
    db $C0, $C2, $E0, $E2
    db $C0, $C2, $E0, $E2
    db $C4, $C4, $C4, $C4
    db $C6, $C6, $C6, $C6
    db $C8, $C8, $C8, $C8
    db $D8, $D8, $D8, $D8
    
    ; $2A22C
    .properties
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $40, $00, $C0, $80
    db $40, $00, $C0, $80
    db $40, $00, $C0, $80
    db $40, $00, $C0, $80
    
    ; $2A244
    .sizes
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $00, $00, $00, $00
    
    ; $2A25C
    dw $0930, $0938, $0940, $0948, $0950, $0958
    
    ; $2A268
    dw $0A6C, $0A6E, $0A70, $0A72, $0A74, $0A76        
}

; ==============================================================================

; $02A274-$02A376 LOCAL JUMP LOCATION
ArmosKnight_Draw:
{
    JSR Sprite2_PrepOamCoord
    
    LDA.w $0D90, X : BNE .not_first
    
    ; Yeah.... what????
    LDA.b $11 : CMP.b #$07 : BEQ .in_downward_floor_transition
    
    JSL Sprite_OAM_AllocateDeferToPlayerLong
    
    LDY.b #$00
    
    .not_first
    .in_downward_floor_transition
    
    LDA.w $0DC0, X : ASL #2 : STA.b $06
    
    PHX
    
    LDX.b #$03
    
    .next_subsprite
    
    PHX
    
    TXA : CLC : ADC.b $06 : PHA : ASL A : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC .x_offsets, X       : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : CLC : ADC .y_offsets, X : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
    
    LDA.b #$F0 : STA ($90), Y
    
    .on_screen_y
    
    PLX
    
    LDA .chr, X                  : INY : STA ($90), Y
    LDA .properties, X : ORA.b $05 : INY : STA ($90), Y
    
    PHY
    
    TYA : LSR #2 : TAY
    
    LDA .sizes, X : ORA.b $0F : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .next_subsprite
    
    PLX
    
    LDA.w $0DC0, X : BEQ .not_dying
    
    RTS
    
    .not_dying
    
    LDA.w $0D90, X : BEQ .epsilon
    
    TXA : ASL A : TAY
    
    REP #$20
    
    LDA.w $A25C, Y : STA.b $90
    LDA.w $A268, Y : STA.b $92
    
    SEP #$20
    
    .epsilon
    
    LDA.w $0F70, X : CMP.b #$20 : BCC .low_altitude
    
    LDA.b #$20
    
    .low_altitude
    
    LSR #3 : STA.b $07
    
    LDA.w $0D00, X : SEC : SBC.b $E8 : STA.b $02
    LDA.w $0D20, X : SBC.b $E9 : STA.b $03
    
    LDY.b #$10
    
    LDA.b $00 : SEC : SBC.b #$08
    
    PHA              : CLC : ADC.b $07               : STA ($90), Y
    PLA : CLC : ADC.b #$10 : SEC : SBC.b $07 : LDY.b #$14 : STA ($90), Y
    
    REP #$20
    
    LDA.b $02 : CLC : ADC.w #$000C : LDY.b #$11 : STA ($90), Y
                             LDY.b #$15 : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y_2
    
    LDA.b #$F0              : STA ($90), Y
                 LDY.b #$11 : STA ($90), Y
    
    .on_screen_y_2
    
    LDA.b #$E4 : LDY.b #$12 : STA ($90), Y
                 LDY.b #$16 : STA ($90), Y
    LDA.b #$25 : LDY.b #$13 : STA ($90), Y
    ORA.b #$40 : LDY.b #$17 : STA ($90), Y
    
    LDA.b #$02 : LDY.b #$04 : STA ($92), Y
                 INY        : STA ($92), Y
    
    RTS
}

; ==============================================================================
