
; =============================================================================

; $0F326F-$0F3296 JUMP LOCATION
Sprite_Terrorpin:
{
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite3_CheckTileCollision
    JSR Sprite3_CheckIfActive
    JSR Sprite3_CheckIfRecoiling
    
    LDA.w $0E10, X : BNE .invulnerable
    
    JSL Sprite_CheckDamageFromPlayerLong
    
    .invulnerable
    
    JSR Terrorpin_CheckHammerHitNearby
    JSR Sprite3_MoveXyz
    
    LDA.w $0DA0, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Terrorpin_Upright
    dw Terrorpin_Overturned
    
    .unused
    
    RTS
}

; =============================================================================

; $0F3297-$0F32A6 DATA
Pool_Terrorpin_Upright:
{
    .x_speeds
    db $08, $F8, $00, $00
    db $0C, $F4, $00, $00
    
    .y_speeds
    db $00, $00, $08, $F8
    db $00, $00, $0C, $F4
}

; =============================================================================

; $0F32A7-$0F330D JUMP LOCATION
Terrorpin_Upright:
{
    LDA.w $0F10, X : BNE .delay
    
    JSL GetRandomInt : AND.b #$1F : ADC.b #$20 : STA.w $0F10, X
    
    AND.b #$03 : STA.w $0DE0, X
    
    ; \note Label so named because it clearly can never happen if there
    ; was a logical and with 0x03 immediately preceding this.
    AND.b #$30 : BNE .never_branch
    
    JSR Sprite3_DirectionToFacePlayer
    
    TYA : STA.w $0DE0, X
    
    .never_branch
    .delay
    
    LDA.w $0DE0, X : CLC : ADC.w $0ED0, X : TAY
    
    LDA .x_speeds, Y : STA.w $0D50, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    LDA.w $0F80, X : DEC #2 : STA.w $0F80, X
    
    LDA.w $0F70, X : BPL .in_air
    
    STZ.w $0F70, X
    STZ.w $0F80, X
    
    .in_air
    
    LDA $1A
    
    LDY.w $0ED0, X : BNE .moving_faster
    
    LSR A
    
    .moving_faster
    
    LSR #2 : AND.b #$01 : STA.w $0DC0, X
    
    LDA.w $0E60, X : ORA.b #$40 : STA.w $0E60, X
    
    LDA.b #$04 : STA.w $0CAA, X
    
    JSR Sprite3_CheckDamageToPlayer
    
    RTS
}

; =============================================================================

; $0F330E-$0F33A2 JUMP LOCATION
Terrorpin_Overturned:
{
    ; Remove invulnerability.
    LDA.w $0E60, X : AND.b #$BF : STA.w $0E60, X
    
    ; Don't make little hit effect when hit by hammer and sword.
    STZ.w $0CAA, X
    
    LDA.w $0F10, X : BNE .delay
    
    STZ.w $0DA0, X
    
    LDA.b #$20 : STA.w $0F80, X
    
    LDA.b #$40 : STA.w $0F10, X
    
    RTS
    
    .delay
    
    LDA.w $0F80, X : DEC #2 : STA.w $0F80, X
    
    LDA.w $0F70, X : BPL .in_air
    
    STZ.w $0F70, X
    
    LDA.w $0F80, X : EOR.b #$FF : INC A : LSR A
    
    CMP.b #$09 : BCS .bounced
    
    LDA.b #$00
    
    .bounced
    
    STA.w $0F80, X
    
    ; This operation arithmetically shifts right to reduce the x velocity.
    LDA.w $0D50, X : ASL A : ROR.w $0D50, X
    
    LDA.w $0D50, X : CMP.b #$FF : BNE .dont_zero_x_speed
    
    STZ.w $0D50, X
    
    .dont_zero_x_speed
    
    ; This operation arithmetically shifts right to reduce the y velocity.
    LDA.w $0D40, X : ASL A : ROR.w $0D40, X
    
    LDA.w $0D40, X : CMP.b #$FF : BNE .dont_zero_y_speed
    
    STZ.w $0D40, X
    
    .dont_zero_x_speed
    .in_air
    
    LDA.w $0F10, X : CMP.b #$40 : BCS .not_struggling_hard_yet
    
    LSR A : AND.b #$01 : TAY
    
    LDA .shake_x_speeds, Y : STA.w $0D50, X
    
    INC.w $0E80, X
    
    .not_struggling_hard_yet
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR #3 : AND.b #$01 : TAY
    
    LDA.b #$02 : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$BF : ORA .h_flip, Y : STA.w $0F50, X
    
    RTS
    
    .h_flip
    db $00, $40
    
    .shake_x_speeds
    db $08, $F8
}

; =============================================================================

; $0F33A3-$0F3404 LOCAL JUMP LOCATION
Terrorpin_CheckHammerHitNearby:
{
    LDA.w $0F70, X : ORA.w $0E10, X : BNE .cant_overturn
    
    LDA $EE : CMP.w $0F20, X : BNE .cant_overturn
    
    LDA.w $0044 : CMP.b #$80 : BEQ .cant_overturn
    LDA.w $0301 : AND.b #$0A : BEQ .cant_overturn
    
    JSL Player_SetupActionHitBoxLong
    JSR Terrorpin_FormHammerHitBox
    
    JSL Utility_CheckIfHitBoxesOverlapLong : BCC .didnt_hit_within_box
    
    LDA.w $0D50, X : EOR.b #$FF : INC A : STA.w $0D50, X
    
    LDA.w $0D40, X : EOR.b #$FF : INC A : STA.w $0D40, X
    
    LDA.b #$20 : STA.w $0E10, X
    
    LDA.b #$20 : STA.w $0F80, X
    
    LDA.b #$04 : STA.w $0ED0, X
    
    LDA.w $0DA0, X : EOR.b #$01 : STA.w $0DA0, X
    
    CMP.b #$01 : LDA.b #$FF : BCS .to_overturned_state
    
    LDA.b #$40
    
    .to_overturned_state
    
    STA.w $0F10, X
    
    .didnt_hit_within_box
    .cant_overturn
    
    STZ.w $0EB0, X
    
    RTS
}

; =============================================================================

; $0F3405-$0F3429 LOCAL JUMP LOCATION
Terrorpin_FormHammerHitBox:
{
    LDA.w $0D10, X : SEC : SBC.b #$10 : STA $04
    LDA.w $0D30, X : SBC.b #$00 : STA $0A
    
    LDA.w $0D00, X : SEC : SBC.b #$10 : STA $05
    LDA.w $0D20, X : SBC.b #$00 : STA $0B
    
    LDA.b #$30 : STA $06
                 STA $07
    
    RTS
}

; ==============================================================================
