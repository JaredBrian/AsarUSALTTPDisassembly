; ==============================================================================

; $035363-$035376 DATA
Pool_Sprite_Octorock:
{
    ; $035363
    .next_direction
    db   3,   2,   0,   1
    
    ; $035367
    .x_speed
    db  24, -24,   0,   0
    
    ; $03536B
    .y_speed
    db   0,   0,  24, -24
    
    ; Unused?
    ; $03536F
    .unused
    db   1,   2,   4,   8
    
    ; $035373
    .delays
    db  60, -128, -96, -128
}

!ai_state  = $0D80
!graphic   = $0DC0
!direction = $0DE0
!type      = $0E20
!OAM_4     = $0F50
    
; Octorock Routine (Sprites 0x08 and 0x0A)
; $035377-$035450 JUMP LOCATION
Sprite_Octorock:
{
    !force_hflip = $00
    !GFX_vert    = $00
    
    ; ------------------------------
    
    LDY.w !direction, X : PHY
    
    LDA.w $0DF0, X : BEQ .timer_1_elapsed
        LDA.w Pool_Sprite_Octorock_next_direction, Y : STA.w !direction, X
    
    .timer_1_elapsed
    
    STZ.b $00
    
    LDA.w !graphic, X : CMP.b #$07 : BNE .no_forced_hflip
        LDA.b #$40 : STA.b !force_hflip
    
    .no_forced_hflip
    
    LDA.w !OAM_4, X : AND.b #$BF
    ORA.w .h_flip, Y : ORA.b !force_hflip : STA.w !OAM_4, X
    
    JSR.w Octorock_Draw
    
    PLA : STA.w !direction, X
    
    JSR.w Sprite_CheckIfActive
    JSR.w Sprite_CheckIfRecoiling
    JSR.w Sprite_Move
    JSR.w Sprite_CheckDamage
    
    LDA.w !ai_state, X : AND.b #$01 : BNE .stop_and_spit_maybe
        LDA.w !direction, X : AND.b #$02 : ASL : STA.b !GFX_vert
        
        INC.w $0E80, X
        LDA.w $0E80, X : LSR #3 : AND.b #$03 : ORA.b !GFX_vert : STA.w !graphic, X
        
        LDA.w $0DF0, X : BNE .wait_1
            ; Switch to the other main AI state.
            INC.w !ai_state, X
            
            LDY.w !type, X
            LDA.w Pool_Sprite_Octorock_delays-8, Y : STA.w $0DF0, X
            
            RTS
        
        .wait_1

        ; Make this little bugger move.
        LDY.w !direction, X
        LDA.w Pool_Sprite_Octorock_x_speed, Y : STA.w $0D50, X
        LDA.w Pool_Sprite_Octorock_y_speed, Y : STA.w $0D40, X
        
        JSR.w Sprite_CheckTileCollision
        
        LDA.w $0E70, X : BEQ .epsilon
            LDA.w !direction, X : EOR.b #$01 : STA.w !direction, X
            
            BRA .return_2
        
        .epsilon
        
        RTS
    
    .stop_and_spit_maybe
    
    JSR.w Sprite_Zero_XY_Velocity
    
    LDA.w $0DF0, X : BNE .wait_2
        INC.w !ai_state, X
        
        LDA.w !direction, X : PHA
        
        ; Set a new countdown timer and direction slightly at random.
        JSL.l GetRandomInt : AND.b #$3F : ADC.b #$30 : STA.w $0DF0, X
        AND.b #$03                                   : STA.w !direction, X
        
        ; Note this odd... certainty that both outcomes result in the same
        ; branch location.
        PLA : CMP.w !direction, X : BEQ .same_direction
            EOR.w !direction, X : BNE .different_direction
                ; Thus, this line of code is not reachable, as far as I can tell.
                LDA.b #$08 : STA.w $0DF0, X
            
            .different_direction
        .same_direction

        .return_2
        
        RTS
    
    .wait_2
    
    LDA.w !type, X : SEC : SBC.b #$08
    
    REP #$30
    
    AND.w #$00FF : ASL : TAY
    LDA.w Octorock_AI_Table, Y : DEC : PHA
    
    SEP #$30
    
    RTS
    
    ; $03544B
    .handlers
    dw Octorock_Normal      ; 0x00 - $D46F
    dw $0000                ; 0x01 - $0000 NULL
    dw Octorock_FourShooter ; 0x02 - $D48A
}

; ==============================================================================

; $035451-$03546E DATA
Octorock_Normal_mouth_anim_step:
{
    db 0, 2, 2, 2, 1, 1, 1, 0
    db 0, 0, 0, 0, 2, 2, 2, 2
    db 2, 1, 1  0
}
    
; ==============================================================================

; $035465-$03546E DATA
Octorock_FourShooter_mouth_anim_step:
{
    db 2, 2, 2, 2 2, 2, 2, 2, 1, 0
}

; ==============================================================================

; $03546F-$035485 JUMP LOCATION (LOCAL)
Octorock_Normal:
{
    LDA.w $0DF0, X : CMP.b #$1C : BNE .dont_spit_rock
        PHA
        
        JSR.w Octorock_SpitOutRock
        
        PLA
    
    .dont_spit_rock
    
    LSR #3 : TAY
    LDA.w .mouth_anim_step, Y : STA.w $0DB0, X
    
    RTS
}

; ==============================================================================

; $035486-$035489 DATA
Octorock_FourShooter_next_direction:
{
    db 2, 3, 1, 0
}

; $03548A-$0354B4 JUMP LOCATION (LOCAL)
Octorock_FourShooter:
{
    LDA.w $0DF0, X : PHA
    CMP.b #$80 : BCS .just_animate
        AND.b #$0F : BNE .dont_rotate
            PHA
            
            LDY.w !direction, X
            LDA.w .next_direction, Y : STA.w !direction, X
            
            PLA
        
        .dont_rotate
        
        CMP.b #$08 : BNE .dont_shoot
            JSR.w Octorock_SpitOutRock
        
        .dont_shoot
    .just_animate
    
    PLA : LSR #4 : TAY
    LDA.w .mouth_anim_step, Y : STA.w $0DB0, X
    
    RTS
}

; ==============================================================================

; $0354B5-$0354CC DATA
Pool_Octorock_SpitOutRock:
{
    ; TODO: Label these sublabels.
    ; $0354B5
    .offset_x_low
    db  12, -12,   0,   0
    
    ; $0354B9
    .offset_x_high
    db   0,  -1,   0,   0
    
    ; $0354BD
    .offset_y_low
    db   4,   4,  12, -12
    
    ; $0354C1
    .offset_y_high
    db   0,   0,   0,  -1
    
    ; $0354C5
    .rock_speed_x
    db  44, -44,   0,   0
    
    ; $0354C9
    .rock_speed_y
    db   0,   0,  44, -44
}

; $0354CD-$035513 LOCAL JUMP LOCATION
Octorock_SpitOutRock:
{
    LDA.b #$07
    JSL.l Sound_SetSFX2PanLong
    
    LDA.b #$0C
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        PHX
        
        ; The position and velocity of the newly created rock depends on the
        ; direction that the Octorok is currently facing.
        LDA.w !direction, X : TAX
        LDA.b $00
        CLC : ADC.w Pool_Octorock_SpitOutRock_offset_x_low, X : STA.w $0D10, Y

        LDA.b $01
              ADC.w Pool_Octorock_SpitOutRock_offset_x_high, X : STA.w $0D30, Y
        
        LDA.b $02
        CLC : ADC.w Pool_Octorock_SpitOutRock_offset_y_low, X : STA.w $0D00, Y

        LDA.b $03
              ADC.w Pool_Octorock_SpitOutRock_offset_y_high, X : STA.w $0D20, Y
        
        LDA.w !direction, Y : TAX
        LDA.w Pool_Octorock_SpitOutRock_rock_speed_x, X : STA.w $0D50, Y
        LDA.w Pool_Octorock_SpitOutRock_rock_speed_y, X : STA.w $0D40, Y
        
        PLX
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $035514-$035549 DATA
Pool_Octorock_Draw:
{
    ; $035514
    .x_offsets
    dw  8,  0,  4,  8,  0,  4,  9, -1,  4
    
    ; $035526
    .y_offsets
    dw  6,  6,  9,  6,  6,  9,  6,  6,  9
    
    ; $035538
    .chr
    db $BB, $BB, $BA, $AB, $AB, $AA, $A9, $A9, $B9
    
    ; $035541
    .properties
    db $65, $25, $25, $65, $25, $25, $65, $25, $25
}

; $03554A-$0355B8 LOCAL JUMP LOCATION
Octorock_Draw:
{
    !top_x_bit_low  = $0E
    !top_x_bit_high = $0F
    
    JSR.w Sprite_PrepOamCoord
    
    ; Perhaps this draws the octorock's snout?
    LDA.w !direction, X : CMP.b #$03 : BEQ .dont_draw_this_part
        ; $07 = [3 * $0DB0, X] + !direction
        LDA.w $0DB0, X : ASL : ADC.w $0DB0, X : ADC.w !direction, X : STA.b $07
        
        PHX : PHA
        
        ASL : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC.w Pool_Octorock_Draw_x_offsets, X : STA.b ($90), Y
        AND.w #$0100 : STA.b !top_x_bit_low
        
        LDA.b $02 : CLC : ADC.w Pool_Octorock_Draw_y_offsets, X : INY : STA.b ($90), Y
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .not_off_screen
            LDA.b #$F0 : STA.b ($90), Y
        
        .not_off_screen
        
        PLX
        
        LDA.w Pool_Octorock_Draw_chr, X        : INY             : STA.b ($90), Y
        LDA.w Pool_Octorock_Draw_properties, X : INY : ORA.b $05 : STA.b ($90), Y
        
        LDA.b !top_x_bit_high : STA.b ($92)
        
        PLX
    
    .dont_draw_this_part
    
    REP #$20
    
    LDA.b $90 : CLC : ADC.w #$0004 : STA.b $90
    
    INC.b $92
    
    SEP #$20
    
    DEC.w $0E40, X
    
    LDY.b #$00
    JSR.w Sprite_PrepAndDrawSingleLarge_just_draw
    
    INC.w $0E40, X
    
    RTS
}

; ==============================================================================
