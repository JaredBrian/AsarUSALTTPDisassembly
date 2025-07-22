; =============================================================================

; $0F326F-$0F3295 JUMP LOCATION
Sprite_Terrorpin:
{
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite3_CheckTileCollision
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckIfRecoiling
    
    LDA.w $0E10, X : BNE .invulnerable
        JSL.l Sprite_CheckDamageFromPlayerLong
    
    .invulnerable
    
    JSR.w Terrorpin_CheckHammerHitNearby
    JSR.w Sprite3_MoveXyz
    
    LDA.w $0DA0, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Terrorpin_Upright    ; 0x00 - $B2A7
    dw Terrorpin_Overturned ; 0x01 - $B30E
}

; $0F3296-$0F3296 JUMP LOCATION
UNUSED1EB296:
{
    RTS
}

; =============================================================================

; $0F3297-$0F32A6 DATA
Pool_Terrorpin_Upright:
{
    ; $0F3297
    .x_speeds
    db $08, $F8, $00, $00
    db $0C, $F4, $00, $00
    
    ; $0F329F
    .y_speeds
    db $00, $00, $08, $F8
    db $00, $00, $0C, $F4
}

; $0F32A7-$0F330D JUMP LOCATION
Terrorpin_Upright:
{
    LDA.w $0F10, X : BNE .delay
        JSL.l GetRandomInt : AND.b #$1F : ADC.b #$20 : STA.w $0F10, X
        
        AND.b #$03 : STA.w $0DE0, X
        
        ; OPTIMIZE:
        ; NOTE: Label so named because it clearly can never happen if there
        ; was a logical and with 0x03 immediately preceding this.
        AND.b #$30 : BNE .never_branch
            JSR.w Sprite3_DirectionToFacePlayer
            
            TYA : STA.w $0DE0, X
        
        .never_branch
    .delay
    
    LDA.w $0DE0, X : CLC : ADC.w $0ED0, X : TAY
    
    LDA.w Pool_Terrorpin_Upright_x_speeds, Y : STA.w $0D50, X
    
    LDA.w Pool_Terrorpin_Upright_y_speeds, Y : STA.w $0D40, X
    
    LDA.w $0F80, X : DEC : DEC : STA.w $0F80, X
    
    LDA.w $0F70, X : BPL .in_air
        STZ.w $0F70, X
        STZ.w $0F80, X
    
    .in_air
    
    LDA.b $1A
    
    LDY.w $0ED0, X : BNE .moving_faster 
        LSR
    
    .moving_faster
    
    LSR : LSR : AND.b #$01 : STA.w $0DC0, X
    
    LDA.w $0E60, X : ORA.b #$40 : STA.w $0E60, X
    
    LDA.b #$04 : STA.w $0CAA, X
    
    JSR.w Sprite3_CheckDamageToPlayer
    
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
    
    LDA.w $0F80, X : DEC : DEC : STA.w $0F80, X
    
    LDA.w $0F70, X : BPL .in_air
        STZ.w $0F70, X
        
        LDA.w $0F80, X : EOR.b #$FF : INC : LSR
        CMP.b #$09 : BCS .bounced
            LDA.b #$00
        
        .bounced
        
        STA.w $0F80, X
        
        ; This operation arithmetically shifts right to reduce the x velocity.
        LDA.w $0D50, X : ASL : ROR.w $0D50, X
        
        LDA.w $0D50, X : CMP.b #$FF : BNE .dont_zero_x_speed
            STZ.w $0D50, X
        
        .dont_zero_x_speed
        
        ; This operation arithmetically shifts right to reduce the y velocity.
        LDA.w $0D40, X : ASL : ROR.w $0D40, X
        
        LDA.w $0D40, X : CMP.b #$FF : BNE .dont_zero_y_speed
            STZ.w $0D40, X
        
        .dont_zero_y_speed
    .in_air
    
    LDA.w $0F10, X : CMP.b #$40 : BCS .not_struggling_hard_yet
        LSR : AND.b #$01 : TAY
        
        LDA.w .shake_x_speeds, Y : STA.w $0D50, X
        
        INC.w $0E80, X
    
    .not_struggling_hard_yet
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR #3 : AND.b #$01 : TAY
    
    LDA.b #$02 : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$BF : ORA .h_flip, Y : STA.w $0F50, X
    
    RTS
    
    ; $0F339F
    .h_flip
    db $00, $40
    
    ; $0F33A1
    .shake_x_speeds
    db $08, $F8
}

; =============================================================================

; $0F33A3-$0F3404 LOCAL JUMP LOCATION
Terrorpin_CheckHammerHitNearby:
{
    LDA.w $0F70, X : ORA.w $0E10, X : BNE .cant_overturn
        LDA.b $EE : CMP.w $0F20, X : BNE .cant_overturn
            LDA.w $0044 : CMP.b #$80 : BEQ .cant_overturn
                LDA.w $0301 : AND.b #$0A : BEQ .cant_overturn
                    JSL.l Player_SetupActionHitBoxLong
                    JSR.w Terrorpin_FormHammerHitBox
                    
                    JSL.l Utility_CheckIfHitBoxesOverlapLong : BCC .didnt_hit_within_box
                        LDA.w $0D50, X : EOR.b #$FF : INC : STA.w $0D50, X
                        LDA.w $0D40, X : EOR.b #$FF : INC : STA.w $0D40, X
                        
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
    LDA.w $0D10, X : SEC : SBC.b #$10 : STA.b $04
    LDA.w $0D30, X       : SBC.b #$00 : STA.b $0A
    
    LDA.w $0D00, X : SEC : SBC.b #$10 : STA.b $05
    LDA.w $0D20, X       : SBC.b #$00 : STA.b $0B
    
    LDA.b #$30 : STA.b $06
                 STA.b $07
    
    RTS
}

; ==============================================================================
