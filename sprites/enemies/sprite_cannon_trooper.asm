; ==============================================================================

; $02AB54-$02AB9B JUMP LOCATION
Sprite_CannonBall:
{
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite2_CheckIfActive
    JSR Sprite2_Move
    
    LDA $0DF0, X : CMP.b #$1E : BNE .dont_poof
    
    PHA
    
    JSL Sprite_SpawnPoofGarnish
    
    PLA
    
    .dont_poof
    
    CMP.b #$00 : BNE .no_tile_collision
    
    JSR Sprite2_CheckTileCollision : BEQ .no_tile_collision
    
    STZ $0DD0, X
    
    LDA $0D10, X : CLC : ADC.b #$04 : STA $0D10, X
    LDA $0D00, X : CLC : ADC.b #$04 : STA $0D00, X
    
    JSL Sprite_PlaceRupulseSpark.coerce
    
    LDA.b #$05 : JSL Sound_SetSfx2PanLong
    
    .no_tile_collision
    
    ; $02AB93 ALTERNATE ENTRY POINT
    shared Sprite2_CheckDamage:
    
    JSL Sprite_CheckDamageFromPlayerLong
    JSL Sprite_CheckDamageToPlayerLong
    
    RTS
}

; ==============================================================================

; $02AB9C-$02ABE3 LONG JUMP LOCATION
Sprite_SpawnPoofGarnish:
{
    ; This routine does that poof of smoke effect when 
    ; fire fairys change into real fairys
    ; (and other cases where a poof is needed)
    
    PHX
    
    TXY
    
    LDX.b #$1D
    
    .nextSlot
    
    ; Look for an empty special sprite slot
    LDA $7FF800, X : BEQ .emptySlot
    
    DEX : BPL .nextSlot
    
    ; use the first slot, if nothing else can be found
    INX
    
    .emptySlot
    
    LDA.b #$0A : STA $7FF800, X : STA $0FB4
    
    LDA $0D10, Y : STA $7FF83C, X
    LDA $0D30, Y : STA $7FF878, X
    
    LDA $0D00, Y : CLC : ADC.b #$10 : STA $7FF81E, X
    LDA $0D20, Y : ADC.b #$00 : STA $7FF85A, X
    
    LDA $0F20, Y : STA $7FF92C, X
    
    LDA.b #$0F : STA $7FF90E, X
    
    TXY
    
    PLX
    
    RTL
}

; ==============================================================================

; $02ABE4-$02AC19 JUMP LOCATION
Sprite_CannonTrooper:
{
    ; Cannon soldier AI (unused in original game)
    
    LDA $0DB0, X : BEQ .not_cannon_ball
    
    JMP Sprite_CannonBall
    
    .not_cannon_ball
    
    LDY $0DE0, X : PHY
    
    LDA $0E00, X : BEQ .beta
    
    LDA.w $B5CB, Y : STA $0DE0, X
    
    .beta
    
    JSR CannonTrooper_Draw
    
    PLA : STA $0DE0, X
    
    JSR Sprite2_CheckIfActive
    JSR Sprite2_CheckDamage
    
    LDA $0D80, X
    
    REP #$30
    
    AND.w #$00FF : ASL A : TAY
    
    ; Hidden table! gah!!!
    LDA.w $AC1A, Y : DEC A : PHA
    
    SEP #$30
    
    RTS
}

; $02AC1A-$02AC23
{
    dw $AC24 ; $2AC24
    dw $AC52 ; $2AC52
    dw $ACF2 ; $2ACF2
    dw $AD12 ; $2AD12
    dw $AD28 ; $2AD28
}

; $02AC24-$02AC51 LOCAL JUMP LOCATION
{
    STZ $0D90, X
    
    LDA $0DF0, X : BNE .delay
    
    INC $0D80, X
    
    LDA.b #$60 : STA $0DF0, X
    
    ; $02AC34 ALTERNATE ENTRY POINT
    shared Trooper_FacePlayer:
    
    LDA $0DE0, X : PHA
    
    JSR Sprite2_DirectionToFacePlayer : TYA : STA $0DE0, X
    
    PLA : CMP $0DE0, X : BEQ .already_facing
    
    EOR $0DE0, X : AND.b #$02 : BNE .direction_lock_not_necessary
    
    LDA.b #$0C : STA $0E00, X
    
    .delay
    .direction_lock_not_necessary
    .already_facing
    
    RTS
}

; ==============================================================================

; $02AC52-$02AC62 JUMP LOCATION
{
    LDA.b #$00
    
    LDY $0DF0, X : BEQ CannonTrooper_SpawnCannonBall
    CPY.b #$30   : BCS .delay
    
    LDA.b #$02
    
    .delay
    
    STA $0D90, X
    
    RTS
}

; ==============================================================================

; $02AC63-$02AC7A DATA
pool CannonTrooper_SpawnCannonBall:
{
    .x_offsets_low
    db 16, -16,   0,   0
    
    .x_offsets_high
    db  0,  -1,   0,   0
    
    .y_offsets_low
    db  0,   0,   8, -16
    
    .y_offsets_high
    db  0,   0,   0,  -1
    
    .x_speeds
    db 24, -24,   0,   0
    
    .y_speeds
    db  0,   0,  24, -24
}

; ==============================================================================

; $02AC7B-$02ACE9 LOCAL JUMP LOCATION
CannonTrooper_SpawnCannonBall:
{
    INC $0D80, X
    
    LDA.b #$04 : STA $0DF0, X
    
    LDA.b #$6B : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA.b #$07 : JSL Sound_SetSfx3PanLong
    
    LDA.b #$01 : STA $0DB0, Y
    
    LDA $0DE0, X : PHX : TAX
    
    LDA $00 : CLC : ADC .x_offsets_low, X  : STA $0D10, Y
    LDA $01 : ADC .x_offsets_high, X : STA $0D30, Y
    
    LDA $02 : CLC : ADC .y_offsets_low, X  : STA $0D00, Y
    LDA $03 : ADC .y_offsets_high, X : STA $0D20, Y
    
    LDA .x_speeds, X : STA $0D50, Y
    
    LDA .y_speeds, X : STA $0D40, Y
    
    LDA $0E40, Y : AND.b #$F0 : ORA.b #$01 : STA $0E40, Y
    
    LDA $0E60, Y : ORA.b #$47 : STA $0E60, Y
    LDA $0CAA, Y : ORA.b #$44 : STA $0CAA, Y
    
    LDA.b #$20 : STA $0DF0, Y
    
    PLX
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $02ACEA-$02ACF1 DATA
{
    .x_speeds
    db -32,  32,   0,   0
    
    .y_speeds
    db   0,   0, -32, 32
}

; ==============================================================================

; $02ACF2-$02AD11 LOCAL JUMP LOCATION
{
    LDA $0DF0, X : BNE .delay
    
    INC $0D80, X
    
    LDA.b #$20 : STA $0DF0, X
    
    .delay
    
    LDY $0DE0, X
    
    LDA .x_speeds, Y : STA $0D50, X
    
    LDA .y_speeds, Y : STA $0D40, X
    
    JSR Sprite2_Move
    
    RTS
}

; ==============================================================================

; $02AD12-$02AD1F LOCAL JUMP LOCATION
{
    LDA $0DF0, X : BNE .delay
    
    INC $0D80, X
    
    LDA.b #$10 : STA $0DF0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $02AD20-$02AD27 DATA
{
    ; \task Name this routine / pool.
    .x_speeds
    db 8, -8,  0,  0
    
    .y_speeds
    db 0,  0,  8, -8
}

; ==============================================================================

; $02AD28-$02AD50 LOCAL JUMP LOCATION
{
    LDA $0DF0, X : BNE .delay_ai_state_reset
    
    STZ $0D80, X
    
    LDA.b #$80 : STA $0DF0, X
    
    .delay_ai_state_reset
    
    LDY $0DE0, X
    
    LDA .x_speeds, Y : STA $0D50, X
    
    LDA .y_speeds, Y : STA $0D40, X
    
    JSR Sprite2_Move
    
    LDA $1A : LSR #2 : AND.b #$01 : STA $0D90, X
    
    RTS
}

; ==============================================================================

; $02AD51-$02AEF8 DATA
{
    ; \task Fill in data and name routine / pool.
}

; ==============================================================================

; $02AEF9-$02AF70 LOCAL JUMP LOCATION
CannonTrooper_Draw:
{
    JSR Sprite2_PrepOamCoord
    
    LDY $0DE0, X
    
    LDA.w $AEF5, Y : CLC : ADC $0D90, X : STA $06
    
    ASL #2 : ADC $06 : STA $06
    
    PHX
    
    LDX.b #$04
    LDY.b #$00
    
    .gamma
    
    PHX
    
    TXA : CLC : ADC $06 : PHA : ASL A : TAX
    
    REP #$20
    
    LDA $00 : CLC : ADC $AD51, X : STA ($90), Y
    
    AND.w #$0100 : STA $0E
    
    LDA $02 : CLC : ADC $ADC9, X : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .alpha
    
    LDA.w #$00F0 : STA ($90), Y
    
    .alpha
    
    SEP #$20
    
    PLX
    
    LDA.w $AE41, X : INY : STA ($90), Y
    
    SEC : SBC.b #$24 : CMP.b #$05
    
    LDA.w $AE7D, X : ORA $05
    
    BCS .beta
    
    AND.b #$F1 : ORA #$06
    
    .beta
    
    INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.w $AEB9, X : ORA $0F : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .gamma
    
    PLX
    
    RTS
}

; ==============================================================================
