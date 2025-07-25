; ==============================================================================

; $0EDD7B-$0EDD82 LONG JUMP LOCATION
Sprite_RavenLong:
{
    PHB : PHK : PLB
    
    JSR.w SpritePrep_Raven
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EDD83-$0EDD84 DATA
Sprite_SetHflip:
{
    db $00, $40
}

; ==============================================================================

; $0EDD85-$0EDDAB LOCAL JUMP LOCATION
Sprite_Raven:
{
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite4_CheckIfActive
    JSR.w Sprite4_CheckIfRecoiling
    JSR.w Sprite4_CheckDamage
    JSR.w Sprite4_Move
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Raven_InWait     ; 0x00 - $DDAE
    dw Raven_Ascend     ; 0x01 - $DDE5
    dw Raven_Attack     ; 0x02 - $DE09
    dw Raven_FleePlayer ; 0x03 - $DE66
}

; ==============================================================================

; $0EDDAC-$0EDDAD DATA
Raven_Ascend_timers:
{
    db $10, $F8
}

; ==============================================================================

; $0EDDAE-$0EDDE4 JUMP LOCATION
Raven_InWait:
{
    JSR.w Sprite4_IsToRightOfPlayer
    JSR.w Raven_SetHflip
    
    REP #$20
    
    LDA.b $22 : SEC : SBC.w $0FD8 : ADC.w #$0050 : CMP.w #$00A0 : BCS .player_too_far
        LDA.b $20 : SEC : SBC.w $0FDA : ADC.w #$0058 : CMP.w #$00A0 : BCS .player_too_far
            SEP #$20
            
            INC.w $0D80, X
            
            LDA.b #$18 : STA.w $0DF0, X
            
            LDA.b #$1E
            JSL.l Sound_SetSfx3PanLong
    
    .player_too_far
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0EDDE5-$0EDE08 JUMP LOCATION
Raven_Ascend:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDY.w $0D90, X
        LDA.w .timers, Y : STA.w $0DF0, X
        
        LDA.b #$20
        JSL.l Sprite_ApplySpeedTowardsPlayerLong
        
    .delay
    
    INC.w $0F70, X
    
    LDA.b $1A : LSR : AND.b #$01 : INC : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0EDE09-$0EDE26 JUMP LOCATION
Raven_Attack:
{
    LDA.w $0DF0, X : BNE .delay_fleeing
        LDA.w $0FFF : BEQ .always_flee_in_light_world
            ; Afaik, all Dark World 'ravens' are fearless. They look like mini-
            ; pterodactyls.
            LDA.w $0D90, X : BNE .is_fearless

        .always_flee_in_light_world
            
        INC.w $0D80, X
            
        .is_fearless
    .delay_fleeing
    
    ; Delay speed analysis.
    TXA : EOR.b $1A : LSR : BCS Raven_Animate
        LDA #$20
        JSL.l Sprite_ProjectSpeedTowardsPlayerLong

        ; Bleeds into the next function.
}

; $0EDE27-$0EDE48 JUMP LOCATION
Raven_AccelerateToTargetSpeed:
{
    LDA.w $0D40, X : CMP.b $00 : BEQ .y_speed_at_target
        BPL .y_speed_above_target
            INC.w $0D40, X
            
            BRA .check_x_speed
        
        .y_speed_above_target
        
        DEC.w $0D40, X
        
    .y_speed_at_target
    .check_x_speed
    
    LDA.w $0D50, X : CMP.b $01 : BEQ .x_speed_at_target
        BPL .x_speed_above_target
            INC.w $0D50, X
    
            BRA .animate
    
        .x_speed_above_target
    
        DEC.w $0D50, X
    
    .x_speed_at_target

    .animate
}

; $0EDE49-$0EDE59 JUMP LOCATION
Raven_Animate:
{
    LDA.b $1A : LSR : AND.b #$01 : INC : STA.w $0DC0, X
    
    LDA.w $0D50, X : ASL : ROL : AND.b #$01 : TAY

    ; Bleeds into the next function.
}
    
; $0EDE5A-$0EDE65 JUMP LOCATION
Raven_SetHflip:
{
    LDA.w $0F50, X : AND.b #$BF : ORA.w Sprite_SetHflip, Y : STA.w $0F50, X
    
    RTS
}

; ==============================================================================

; $0EDE66-$0EDE81 JUMP LOCATION
Raven_FleePlayer:
{
    TXA : EOR.b $1A : LSR : BCS Raven_Animate
        LDA.b #$30
        JSL.l Sprite_ProjectSpeedTowardsPlayerLong
        
        LDA.b $00 : EOR.b #$FF : INC : STA.b $00
        
        LDA.b $01 : EOR.b #$FF : INC : STA.b $01
        
        BRA Raven_AccelerateToTargetSpeed
}

; ==============================================================================
