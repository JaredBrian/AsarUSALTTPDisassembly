; ==============================================================================

; $02BE0A-$02BE48 LOCAL JUMP LOCATION
Sprite_BombTrooper:
{
    LDA.w $0DB0, X : BNE .is_bomb
        JMP BombTrooper_Main
    
    .is_bomb
    
    CMP.b #$02 : BCS .flashing_or_exploding
        JMP EnemyBomb_ExplosionImminent
    
    .flashing_or_exploding
    
    BNE .exploding
        LDY.b #$0F
        
        .next_sprite
            
            CPY.w $0FA0 : BEQ .dont_damage
            LDA.w $0DD0, Y : CMP.b #$09 : BCC .dont_damage
            TYA : EOR.b $1A : AND.b #$07 : ORA.w $0EF0, Y : BNE .dont_damage
                JSR.w EnemyBomb_CheckDamageToSprite
            
            .dont_damage
        DEY : BPL .next_sprite
        
        JSL.l Sprite_CheckDamageToPlayerLong
    
    .exploding
    
    JSR.w EnemyBomb_DrawExplosion
    
    LDA.w $0E00, X : BNE .dont_self_terminate
        STZ.w $0DD0, X
    
    .dont_self_terminate
    
    RTS
}
    
; ==============================================================================

; $02BE49-$02BED2 LOCAL JUMP LOCATION
EnemyBomb_CheckDamageToSprite:
{
    LDA.w $0D10, X : SEC : SBC.b #$10 : STA.b $00
    LDA.w $0D30, X :       SBC.b #$00 : STA.b $08
    
    LDA.b #$30 : STA.b $02 : STA.b $03
    
    LDA.w $0D00, X : SEC : SBC.b #$10 : STA.b $01
    LDA.w $0D20, X :       SBC.b #$00 : STA.b $09
    
    PHX
    
    TYX
    
    JSL.l Sprite_SetupHitBoxLong
    
    PLX
    
    JSL.l Utility_CheckIfHitBoxesOverlapLong : BCC .dont_damage
        LDA.w $0E20, Y : CMP.b #$11 : BEQ .dont_damage
            PHX
            
            TYX : PHY
            
            LDA.b #$08 : JSL.l Ancilla_CheckSpriteDamage_preset_class
            
            PLY : PLX
            
            LDA.w $0D10, X : STA.b $00
            LDA.w $0D30, X : STA.b $01
            
            LDA.w $0D00, X : SEC : SBC.w $0F70, X : STA.b $02
            LDA.w $0D20, X :       SBC.b #$00 : STA.b $03
            
            LDA.w $0D10, Y : STA.b $04
            LDA.w $0D30, Y : STA.b $05
            
            LDA.w $0D00, Y : SEC : SBC.w $0F70, Y : STA.b $06
            LDA.w $0D20, Y :       SBC.b #$00 : STA.b $07
            
            PHY
            
            LDA.b #$20 : JSL.l Sprite_ProjectSpeedTowardsEntityLong
            
            PLY
            
            LDA.b $00 : STA.w $0F30, Y
            LDA.b $01 : STA.w $0F40, Y
    
    .dont_damage
    
    RTS
}
    
; ==============================================================================

; *$2BED3-2BF50 LOCAL JUMP LOCATION
EnemyBomb_ExplosionImminent:
{
    LDA.w $0E90, X : BEQ .iota
        LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    .iota
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    
    LDA.w $0EF0, X : BNE .kappa
        LDA.w $0E00, X : CMP.b #$40 : BCS .lambda
            CMP.b #$01 : BNE .mu

    .kappa

    STZ.w $0EF0, X
    
    LDA.w $0DD0, X : CMP.b #$0A : BNE .nu
        STZ.w $0309
        STZ.w $0308

    .nu

    LDA.b #$0C : JSL.l Sound_SetSfx2PanLong
    
    INC.w $0DB0, X
    
    LDA.b #$09 : STA.w $0F60, X
    LDA.b #$02 : STA.w $0F50, X
    LDA.b #$1F : STA.w $0E00, X
    LDA.b #$06 : STA.w $0DD0, X
    LDA.b #$03 : STA.w $0E40, X
    
    RTS
    
    .mu
    
    LSR : AND.b #$0E : STA.b $00
    
    LDA.w $0F50, X : AND.b #$F1 : ORA.b $00 : STA.w $0F50, X
    
    .lambda
    
    JSR.w Sprite2_CheckIfActive
    
    LDA.w $0EE0, X : BNE .xi
        JSL.l Sprite_CheckDamageFromPlayerLong
    
    .xi
    
    JSR.w Sprite2_Move
    
    LDA.b $1B : BEQ .omicron
        JSR.w Sprite2_CheckTileCollision
    
    .omicron
    
    JSL.l ThrownSprite_TileAndPeerInteractionLong
    
    RTS
}

; ==============================================================================

; $02BF51-$02BFB0 LOCAL JUMP LOCATION
BombTrooper_Main:
{
    JSR.w BombTrooper_Draw
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_CheckDamage
    
    JSR.w Sprite2_DirectionToFacePlayer : TYA : STA.w $0DE0, X : STA.w $0EB0, X
    
    LDA.w $0D80, X : BNE .pi
        LDA.w $0DF0, X : BNE .rho
            INC.w $0D80, X
            
            LDA.b #$70 : STA.w $0DF0, X

        .rho

        RTS

    .pi

    LDA.w $0DF0, X : BNE .sigma
        STZ.w $0D80, X
        
        LDA.b #$20 : STA.w $0DF0, X
        
        RTS

    .sigma

    STZ.w $0E80, X
    
    CMP.b #$50 : BCC .tau
        INC.w $0E80, X

    .tau

    CMP.b #$20 : BNE .upsilon
        PHA
        
        JSR.w BombTrooper_SpawnAndThrowBomb
        
        PLA

    .upsilon

    LSR #4 : STA.b $00
    
    LDA.w $0DE0, X : ASL #3 : ORA.b $00 : CLC : ADC.b #$20 : TAY
    
    LDA.w Pool_JavelinTrooper_Attack_animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02BFB1-$02BFC0 DATA
Pool_BombTrooper_SpawnAndThrowBomb:
{
    ; $02BFB1
    .x_offsets_low
    db $00, $01, $09, $F8
    
    ; $02BFB5
    .x_offsets_high
    db $00, $00, $00, $FF
    
    ; $02BFB9
    .y_offsets_low
    db $F4, $F4, $F1, $F3
    
    ; $02BFBD
    .y_offsets_high
    db $FF, $FF, $FF, $FF
}

; $02BFC1-$02C04A LOCAL JUMP LOCATION
BombTrooper_SpawnAndThrowBomb:
{
    LDA.b #$4A
    
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        PHX
        
        LDA.w $0DE0, X : TAX
        
        LDA.b $00 : CLC : ADC Pool_BombTrooper_SpawnAndThrowBombx_offsets_low, X 
        STA.w $0D10, Y

        LDA.b $01 :       ADC Pool_BombTrooper_SpawnAndThrowBombx_offsets_high, X
        STA.w $0D30, Y
        
        LDA.b $02 : CLC : ADC Pool_BombTrooper_SpawnAndThrowBomby_offsets_low, X 
        STA.w $0D00, Y
        
        LDA.b $03 :       ADC Pool_BombTrooper_SpawnAndThrowBomby_offsets_high, X
        STA.w $0D20, Y
        
        TYX
        
        LDA.b #$10 : JSL.l Sprite_ApplySpeedTowardsPlayerLong
        
        LDA.b #$01 : STA.w $0DB0, X
        
        JSR.w Sprite2_DirectionToFacePlayer
        
        LDA.b $0F : BPL .positive_dx
            EOR.b #$FF : INC
        
        .positive_dx
        
        STA.b $0F
        
        LDA.b $0E : BPL .positive_dy
            EOR.b #$FF : INC
        
        .positive_dy
        
        ORA.b $0F : LSR #4 : TAY
        
        LDA.w .initial_z_velocities, Y : STA.w $0F80, X
        
        LDA.w $0E60, X : AND.b #$EE : ORA.b #$18 : STA.w $0E60, X
        
        LDA.b #$08 : STA.w $0F50, X
        
        LDA.b #$FF : STA.w $0E00, X
        
        STZ.w $0E50, X
        
        LDA.b #$13 : JSL.l Sound_SetSfx3PanLong
        
        PLX
    
    .spawn_failed
    
    RTS
    
    .initial_z_velocities
    db $20, $28, $30, $38, $40, $40, $40, $40
    db $40, $40, $40, $40, $40, $40, $40, $40
}

; ==============================================================================

; $02C04B-$02C068 LOCAL JUMP LOCATION
BombTrooper_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDY.b #$08
    
    JSR.w SpriteDraw_GuardHead
    
    LDY.b #$04
    
    JSR.w SpriteDraw_GuardBody
    
    LDA.w $0DC0, X : CMP.b #$14 : BCS .alpha
        JSR.w BombTrooper_DrawArm
    
    .alpha
    
    LDA.b #$0A
    
    JSL.l Sprite_DrawShadowLong_variable
    
    RTS
}

; ==============================================================================

; $02C069-$02C088 DATA
Pool_SpriteDraw_BombGuard_Arm:
{
    ; $02C069
    .offset_x
    dw  -1,   1,   2,   0
    dw   9,   9,  -8,  -8

    ; $02C079
    .offset_y
    dw -12, -12, -12, -12
    dw -16, -14, -12, -14
}

; $02C089-$02C0D2 LOCAL JUMP LOCATION
BombTrooper_DrawArm:
{
    PHX
    
    LDA.w $0DE0, X : ASL : ORA.w $0E80, X : ASL : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC.w Pool_SpriteDraw_BombGuard_Arm_offset_x, X
    LDY.b #$00 : STA ($90), Y
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : CLC : ADC.w Pool_SpriteDraw_BombGuard_Arm_offset_y, X 
    INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen_y
        LDA.w #$00F0 : STA ($90), Y
    
    .on_screen_y
    
    SEP #$20
    
    LDA.b #$6E                    : INY : STA ($90), Y : INY
    LDA.b $05 : AND.b #$30 : ORA.b #$08 : STA ($90), Y
    
    LDA.b #$02 : ORA.b $0F : STA ($92)
    
    PLX
    
    RTS
}

; ==============================================================================

; $02C0D3-$02C112 DATA
Pool_EnemyBomb_DrawExplosion:
{
    ; $02C0D3
    .x_offsets
    db -12, 12, -12, 12
    db -8,   8,  -8,  8
    db -8,   8,  -8,  8
    db  0,   0,   0,  0
    
    ; $02C0E3
    .y_offsets
    db -12, -12, 12, 12
    db  -8,  -8,  8,  8
    db  -8,  -8,  8,  8
    db   0,   0,  0,  0
    
    ; $02C1F3
    .chr
    db $88, $88, $88, $88, $8A, $8A, $8A, $8A
    db $84, $84, $84, $84, $86, $86, $86, $86
    
    ; $02C103
    .vh_flip
    db $00, $40, $80, $C0, $00, $40, $80, $C0
    db $00, $40, $80, $C0, $00, $00, $00, $00
}

; $02C113-$02C154 LOCAL JUMP LOCATION
EnemyBomb_DrawExplosion:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDA.w $0E00, X : LSR : AND.b #$0C : STA.b $06
    
    PHX
    
    LDX.b #$03
    
    .next_subsprite
        
        PHX
        
        TXA : CLC : ADC.b $06 : TAX
        
        LDA.b $00 : CLC : ADC Pool_EnemyBomb_DrawExplosion_x_offsets, X
            STA ($90), Y

        LDA.b $02 : CLC : ADC Pool_EnemyBomb_DrawExplosion_y_offsets, X
        INY : STA ($90), Y

        LDA Pool_EnemyBomb_DrawExplosion_chr, X
        INY : STA ($90), Y

        LDA Pool_EnemyBomb_DrawExplosion_vh_flip, X : ORA.b $05
        INY : STA ($90), Y
        
        INY
    PLX : DEX : BPL .next_subsprite
    
    PLX
    
    LDY.b #$02
    LDA.b #$03
    
    JSL.l Sprite_CorrectOamEntriesLong
    
    RTS
}

; ==============================================================================
