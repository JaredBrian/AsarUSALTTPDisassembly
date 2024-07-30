; ==============================================================================
    
; These are specific to this overlord.
!coordinator_angle = $0B08
    
!radius = $0B0A
    
!overlord_x_low  = $0B08
!overlord_x_high = $0B10
    
!overlord_y_low  = $0B18
!overlord_y_high = $0B20
    
!coordinator_ai_state = $0B28
    
!state_timer = $0B30
    
!angle_step = $0B40
    
; These are indexed for each armos knight.
!puppet_x_low  = $0B10
!pupper_x_high = $0B20
    
!puppet_y_low  = $0B30
!puppet_y_high = $0B40

; ==============================================================================

; $0EEBEB-$0EEBF2 LONG JUMP LOCATION
ArmosCoordinatorLong:
{
    PHB : PHK : PLB
    
    JSR ArmosCoordinator_Main
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EEBF3-$0EEC11 LOCAL JUMP LOCATION
ArmosCoordinator_Main:
{
    LDA !state_timer, X : BEQ .timer_expired
        ; This variable acts as an autotimer for the overlord.
        DEC !state_timer, X
    
    .timer_expired
    
    LDA !coordinator_ai_state, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw ArmosCoordinator_AwaitKnightActivation     ; 0x00 - $EC12
    dw ArmosCoordinator_AwaitKnightsUnderCoercion ; 0x01 - $EC34
    dw ArmosCoordinator_TimedRotateThenTransition ; 0x02 - $ECCC
    dw ArmosCoordinator_RadialContraction         ; 0x03 - $EC96
    dw ArmosCoordinator_TimedRotateThenTransition ; 0x04 - $ECCC
    dw ArmosCoordinator_RadialDilation            ; 0x05 - $ECAB
    dw ArmosCoordinator_OrderKnightsToBackWall    ; 0x06 - $EC48
    dw ArmosCoordinator_CascadeKnightsToFrontWall ; 0x07 - $EC69
}

; ==============================================================================

; $0EEC12-$0EEC33 JUMP LOCATION
ArmosCoordinator_AwaitKnightActivation:
{
    ; Or rather, wait for the first one to ativate, but I think they all
    ; activate at the same time (rumble then start moving).
    LDA.w $0D90 : BEQ .wait_for_knights_to_activate
        LDA.b #$78 : STA !overlord_x_low, X
        
        LDA.b #$FF : STA !angle_step, X
        
        ; HARDCODED: This is.... freaking ridiculous. It assumes that
        ; this overlord is in the last slot and that no others are present
        ; in the room.
        LDA.b #$40 : STA !radius
        
        LDA.b #$C0 : STA !coordinator_angle
        LDA.b #$01 : STA !coordinator_angle+1
        
        JSR ArmosCoordinator_TimedRotateThenTransition
    
    .wait_for_knights_to_activate
    
    RTS
}

; ==============================================================================

; $0EEC34-$0EEC41 JUMP LOCATION
ArmosCoordinator_AwaitKnightsUnderCoercion:
{
    ; Check for alive knights of a certain state?
    JSR ArmosCoordinator_AreAllActiveKnightsSubmissive
    BCC .delay_next_state
    
        INC !coordinator_ai_state, X
        
        LDA.b #$FF : STA !state_timer, X
    
    .delay_next_state
    
    RTS
}

; ==============================================================================

; $0EEC42-$0EEC47 DATA
ArmosCoordinator_OrderKnightsToBackWall_x_positions:
{
    db $31, $4D, $69, $83, $9F, $BB
}

; $0EEC48-$0EEC68 JUMP LOCATION
ArmosCoordinator_OrderKnightsToBackWall:
{
    LDA !state_timer, X : BNE .delay_movement
        JSR ArmosCoordinator_DisableKnights_XY_Coercion
        
        LDY.b #$05
        
        .next_knight
        
            LDA .x_position, Y : STA !puppet_x_low, Y
            
            LDA.b #$30 : STA !puppet_y_low, Y
        DEY : BPL .next_knight
        
        INC !coordinator_ai_state, X
        
        LDA.b #$FF : STA !state_timer, X
    
    .delay_movement
    
    RTS
}

; ==============================================================================

; $0EEC69-$0EEC95 JUMP LOCATION
ArmosCoordinator_CascadeKnightsToFrontWall:
{
    LDA !state_timer, X : BNE .delay_cascade
        LDY.b #$05
        
        .next_knight
        
        LDA !puppet_y_low, Y : INC A : STA !puppet_y_low, Y
        
        ; UNUSED: Wait.... is this at all useful useful?
        CPY.b #$00
        
        CMP.b #$C0 : BNE .not_at_front_wall_yet
            LDA.b #$01 : STA !coordinator_ai_state, X
            
            LDA !angle_step, X : EOR.b #$FF : INC A : STA !angle_step, X
            
            JSR ArmosCoordinator_DisableKnights_XY_Coercion
            JSR ArmosCoordinator_Rotate
            
            RTS
        
        .not_at_front_wall_yet
        
        DEY : BPL .next_knight
    
    .delay_cascade
    
    RTS
}

; ==============================================================================

; $0EEC96-$0EECAA JUMP LOCATION
ArmosCoordinator_RadialContraction:
{
    LDA !radius : DEC A : STA !radius : CMP.b #$20 : BNE .await_contraction
        INC !coordinator_ai_state, X
        
        LDA.b #$40 : STA !state_timer, X
    
    .await_contraction
    
    BRA ArmosCoordinator_Rotate
}

; ==============================================================================

; $0EECAB-$0EECBF JUMP LOCATION
ArmosCoordinator_RadialDilation:
{
    LDA !radius : INC A : STA !radius : CMP.b #$40 : BNE .await_dilation
        INC !coordinator_ai_state, X
        
        LDA.b #$40 : STA !state_timer, X
    
    .await_dilation
    
    BRA ArmosCoordinator_Rotate
}

; ==============================================================================

; $0EECC0-$0EECCB DATA
Pool_ArmosCoordinator_Rotate:
{
    ; NOTE: Multiples of 0x0055, but not strictly in order.
    dw $0000, $01A9, $0154, $00FF, $00AA, $0055
}

; ==============================================================================

; TODO: Maybe rename to something like *..._SetRadialPositions?
; $0EECCC-$0EECD3 JUMP LOCATION
ArmosCoordinator_TimedRotateThenTransition:
{
    LDA !state_timer, X : BNE .delay_transition
        INC !coordinator_ai_state, X
    
    .delay_transition

    ; Bleeds into the next function.
}
    
; $0EECD4-$0EEDB7 JUMP LOCATION
ArmosCoordinator_Rotate:
{
    LDY.b #$00
    
    LDA !angle_step, X : BPL .sign_extend_angle_step
        DEY
    
    .sign_extend_angle_step
    
    CLC : ADC !coordinator_angle+0 : STA !coordinator_angle+0
    TYA : ADC !coordinator_angle+1 : STA !coordinator_angle+1
    
    STZ.w $0FB5
    
    .next_knight
    
        LDA.w $0FB5 : PHA : ASL A : TAY
        
        REP #$20
        
        LDA !coordinator_angle : CLC : ADC.w Pool_ArmosCoordinator_Rotate, Y : STA.b $00
        
        SEP #$20
        
        PLY
        
        LDA !radius : STA.b $0F
        
        PHX
        
        REP #$30
        
        LDA.b $00 : AND.w #$00FF : ASL A : TAX
        
        LDA.l SmoothCurve, X : STA.b $04
        
        LDA.b $00 : CLC : ADC.w #$0080 : STA.b $02
        
        AND.w #$00FF : ASL A : TAX
        
        LDA.l SmoothCurve, X : STA.b $06
        
        SEP #$30
        
        PLX
        
        LDA.b $04 : STA.w $4202
        
        LDA.b $0F
        
        LDY.b $05 : BNE .BRANCH_GAMMA
            STA.w $4203
            
            NOP #8
            
            ; BUG:(maybe) Is $4216 readable? What is the actual point of this?
            ; Whatever is read out is open bus so it would be the value from
            ; $4203, I think...
            ASL.w $4216
            
            LDA.w $4217 : ADC.b #$00
        
        .BRANCH_GAMMA
        
        LSR.b $01 : BCC .BRANCH_DELTA
            EOR.b #$FF : INC A
        
        .BRANCH_DELTA
        
        STZ.b $0A
        
        CMP.b #$00 : BPL .BRANCH_EPSILON
            DEC.b $0A
        
        .BRANCH_EPSILON
        
        CLC : ADC !overlord_x_low, X
        LDY.w $0FB5 : STA !puppet_x_low, Y
        LDA !overlord_x_high, X : ADC.b $0A : STA !pupper_x_high, Y
        
        LDA.b $06 : STA.w $4202
        
        LDA.b $0F
        
        LDY.b $07 : BNE .BRANCH_ZETA
            STA.w $4203
            
            NOP #8
            
            ; BUG:(maybe) Scroll up and read.
            ASL.w $4216
            
            LDA.w $4217 : ADC.b #$00
        
        .BRANCH_ZETA
        
        LSR.b $03 : BCC .BRANCH_THETA
            EOR.b #$FF : INC A
        
        .BRANCH_THETA
        
        STZ.b $0A
        
        CMP.b #$00 : BPL .BRANCH_IOTA
            DEC.b $0A
        
        .BRANCH_IOTA
        
        CLC : ADC !overlord_y_low, X
        LDY.w $0FB5 : STA !puppet_y_low, Y
        LDA !overlord_y_high, X : ADC.b $0A : STA !puppet_y_high, Y
        
        INC.w $0FB5
        
        LDA.w $0FB5 : CMP.b #$06 : BEQ .return
    JMP .next_knight
    
    .return
    
    RTS
}

; ==============================================================================

; $0EEDB8-$0EEDCA LOCAL JUMP LOCATION
ArmosCoordinator_AreAllActiveKnightsSubmissive:
{
    LDY.b #$05
    
    .next_knight
    
        LDA.w $0DD0, Y : BEQ .dead_knight
            LDA.w $0D80, Y : BNE .submissive_knight
                ; If we find a non submissive knight (which means not in
                ; position yet), return a fail status.
                CLC
                
                RTS
            
            .submissive_knight
        .dead_knight
    DEY : BPL .next_knight
    
    SEC
    
    RTS
} 

; ==============================================================================

; Instead of being forced to specific coordinates by the coordinator,
; configure the knights to be guided to specific coordinates.
; $0EEDCB-$0EEDD5 LOCAL JUMP LOCATION
ArmosCoordinator_DisableKnights_XY_Coercion:
{
    LDY.b #$05
    
    .next_knight
    
        LDA.b #$00 : STA.w $0D80, Y
    DEY : BPL .next_knight
    
    RTS
}

; ==============================================================================
