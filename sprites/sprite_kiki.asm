; ==============================================================================

; $0F62E9-$0F62EE DATA
Pool_Kiki_WalkOnRoof2:
{
    ; $0F62E9
    .x_speeds ; Bleeds into the next block. Length 4.
    db  0,  0
    
    ; $0F62EB
    .y_speeds
    db -9,  9,  0,  0
}

; ==============================================================================

; $0F62EF-$0F62FD JUMP LOCATION
Sprite_Kiki:
{
    LDA.w $0E80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Kiki_LyingInWait          ; 0x00 - $E487
    dw Kiki_OfferEntranceService ; 0x01 - $E4C9
    dw Kiki_OfferInitialService  ; 0x02 - $E3AF
    dw Kiki_Fleeing              ; 0x03 - $E2FE
}

; ==============================================================================

; $0F62FE-$0F63AE JUMP LOCATION
Kiki_Fleeing:
{
    JSR.w Kiki_Draw
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0F70, X : BNE .in_air
        REP #$20
        
        LDA.w $0FD8 : SEC : SBC.w #$0C98 : CMP.w #$00D0 : BCS .too_far_away
            LDA.w $0FDA : SEC : SBC.w #$06A5 : CMP.w #$00D0 : BCS .too_far_away
                LDA.w #$FFFF : STA.b $01
            
        .too_far_away
    .in_air
    
    SEP #$30
    
    ; BUG: How is $03 relevant here? This seems well... not good.
    LDA.b $01 : ORA.b $03 : BEQ .dont_self_terminate_yet
        STZ.w $0DD0, X
        
    .dont_self_terminate_yet
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    JSR.w Sprite3_MoveXyz
    
    LDA.w $0F70, X : BPL .no_ground_bounce
        STZ.w $0F70, X
        
        JSL.l GetRandomInt : AND.b #$0F : ORA.b #$10 : STA.w $0F80, X
        
    .no_ground_bounce
    
    LDA.b #$F5 : STA.b $04
    LDA.b #$0C : STA.b $05
    
    LDA.b #$FE : STA.b $06
    LDA.b #$06 : STA.b $07
    
    LDA.b #$10
    JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : ASL : STA.w $0D40, X
    
    LDA.b $01 : ASL : STA.w $0D50, X
    
    LDA.w $02F2 : AND.b #$FC : STA.w $02F2
    
    LDA.b $00 : BPL .x_speed_positive
        EOR.b #$FF : INC : STA.b $00
        
    .x_speed_positive
    
    LDA.b $01 : BPL .y_speed_positive
        EOR.b #$FF : INC
        
    .y_speed_positive
    
    CMP.b $00 : BCC .x_speed_larger
        LDA.w $0D50, X : ROL : ROL : AND.b #$01 : EOR.b #$03
        
        BRA .animate
    
    .x_speed_larger
    
    LDA.w $0D40, X : ROL : ROL : AND.b #$01 : EOR.b #$01
    
    .animate
    
    STA.w $0DE0, X
    
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F63AF-$0F63E7 JUMP LOCATION
Kiki_OfferInitialService:
{
    LDA.w $0D80, X : DEC : DEC : BMI .BRANCH_ALPHA
        JSR.w Kiki_Draw
        
    .BRANCH_ALPHA
    
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_MoveXyz
    
    DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .BRANCH_BETA
        STZ.w $0F80, X
        STZ.w $0F70, X
    
    .BRANCH_BETA
    
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Kiki_OfferToFollow            ; 0x00 - $E3E8
    dw Kiki_OfferToFollowTransaction ; 0x01 - $E3F4
    dw Kiki_MoveTowardsLink          ; 0x02 - $E433
    dw Kiki_WaitABit                 ; 0x03 - $E465
    dw Kiki_EndIntroductionCutscene  ; 0x04 - $E476
}

; $0F63E8-$0F63F3 JUMP LOCATION
Kiki_OfferToFollow:
{
    LDA.b #$1E
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
}

; $0F63F4-$0F6432 JUMP LOCATION
Kiki_OfferToFollowTransaction:
{
    LDA.w $1CE8 : BNE .player_declined
        LDA.b #$0A
        LDY.b #$00
        JSR.w ShopKeeper_TryToGetPaid : BCC .cant_afford
            ; "Ki ki ki ki! Good choice! I will accompany you for a while..."
            LDA.b #$1F
            LDY.b #$01
            JSL.l Sprite_ShowMessageUnconditional
            
            LDA.w $02F2 : ORA.b #$03 : STA.w $02F2
            
            STZ.w $0DD0, X
            
            RTS
            
        .cant_afford
    .player_declined
    
    ; "Ki ki! Harumph! I have no reason to talk to you, then. Bye bye!..."
    LDA.b #$20
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    LDA.w $02F2 : AND.b #$FC : STA.w $02F2
    
    LDA.b #$00 : STA.l $7EF3CC
    
    INC.w $0D80, X
    
    INC.w $02E4
    
    RTS
}

; $0F6433-$0F6464 JUMP LOCATION
Kiki_MoveTowardsLink:
{
    INC.w $0D80, X
    
    LDA.b #$F5 : STA.b $04
    LDA.b #$0C : STA.b $05
    
    LDA.b #$FE : STA.b $06
    LDA.b #$06 : STA.b $07
    
    LDA.b #$09
    JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00                           : STA.w $0D40, X
    LDA.b $01                           : STA.w $0D50, X
    ASL : ROL : AND.b #$01 : EOR.b #$03 : STA.w $0DE0, X
    
    LDA.b #$20 : STA.w $0DF0, X
    
    RTS
}

; $0F6465-$0F6475 JUMP LOCATION
Kiki_WaitABit:
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        INC.w $0D80, X
        
        LDA.b #$10 : STA.w $0F80, X
                     STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F6476-$0F6486 JUMP LOCATION
Kiki_EndIntroductionCutscene:
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        LDA.w $0F70, X : BNE .BRANCH_ALPHA
            STZ.w $0DD0, X
            
            STZ.w $02E4
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $0F6487-$0F64C8 JUMP LOCATION
Kiki_LyingInWait:
{
    JSL.l Sprite_PrepOamCoordLong
    JSR.w Sprite3_CheckIfActive
    
    ; See if Link is a bunny.
    LDA.w $02E0 : BNE .dont_appear
        ; If Link is invincible don't show up either.
        LDA.w $037B : ORA.w $031F : BNE .dont_appear
            ; If Kiki is already following you then do nothing.
            LDA.l $7EF3CC : CMP.b #$0A : BEQ .dont_appear
                PHX
                
                ; If the Dark Palace has already been opened, then also do
                ; nothing.
                LDX.b $8A
                LDA.l $7EF280, X : PLX : AND.b #$20 : BNE .dont_appear
                    ; Detect if Link and Kiki collide within some space.
                    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .dont_appear
                        
                        LDA.b #$0A : STA.l $7EF3CC
                        
                        PHX
                        
                        STZ.w $02F9
                        
                        JSL.l Tagalong_LoadGfx
                        JSL.l Tagalong_Init
                        
                        PLX
                
    .dont_appear
    
    RTS
}

; ==============================================================================

; $0F64C9-$0F64FC JUMP LOCATION
Kiki_OfferEntranceService:
{
    JSR.w Kiki_Draw
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_MoveXyz
    
    DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .BRANCH_ALPHA
        STZ.w $0F80, X
        STZ.w $0F70, X
        
    .BRANCH_ALPHA
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Kiki_OfferToOpenPOD   ; 0x00 - $E4FD
    dw Kiki_VerifyPurchase   ; 0x01 - $E509
    dw Kiki_HopToSpot        ; 0x02 - $E582
    dw Kiki_DartHead         ; 0x03 - $E539
    dw Kiki_HopToSpot        ; 0x04 - $E582
    dw Kiki_DartHead         ; 0x05 - $E539
    dw Kiki_HopToSpot        ; 0x06 - $E582
    dw Kiki_WalkOnRoof       ; 0x07 - $E5EE
    dw Kiki_ReadyButtonPress ; 0x08 - $E640
    dw Kiki_SlamButton       ; 0x09 - $E657
    dw Kiki_IdleOnRoof       ; 0x0A - $E66A
}

; $0F64FD-$0F6508 JUMP LOCATION
Kiki_OfferToOpenPOD:
{
    LDA.b #$1B
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
}

; $0F6509-$0F6536 JUMP LOCATION
Kiki_VerifyPurchase:
{
    LDA.w $1CE8 : BEQ .player_agreed
        .cant_afford
        
        LDA.b #$1C
        LDY.b #$01
        JSL.l Sprite_ShowMessageUnconditional
        
        LDA.b #$03 : STA.w $0E80, X
        
        RTS
    
    .player_agreed
    
    LDA.b #$64
    LDY.b #$00
    
    JSR.w ShopKeeper_TryToGetPaid : BCC .cant_afford
        LDA.b #$1D
        LDY.b #$01
        JSL.l Sprite_ShowMessageUnconditional
        
        INC.w $02E4
        
        INC.w $0D80, X
        
        STZ.w $0DE0, X
        
        RTS
}

; ==============================================================================

; $0F6537-$0F6538 DATA
Kiki_DartHead_jump_heights:
{
    db 32, 28
}

; $0F6539-$0F6575 JUMP LOCATION
Kiki_DartHead:
{
    LDA.w $0E00, X : BNE .BRANCH_ALPHA
        LDA.w $0D80, X : INC.w $0D80, X : LSR : AND.b #$01 : TAY
        LDA.w .jump_heights, Y : STA.w $0F80, X
        
        LDA.b #$20
        JSL.l Sound_SetSfx2PanLong
        
        LDA.w $0D80, X : LSR : AND.b #$01 : ORA.b #$04 : STA.w $0DE0, X
        
        RTS
        
    .BRANCH_ALPHA
    
    LDA.w $0D80, X : LSR : AND.b #$01 : ORA.b #$06 : STA.w $0DE0, X
    
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F6576-$0F6581 DATA
Pool_Kiki_HopToSpot:
{
    ; $0F6576
    .y_targets
    db $61, $06, $4C, $06, $24, $06
    
    ; $0F657C
    .x_targets
    db $4F, $0F, $70, $0F, $5D, $0F
}

; $0F6582-$0F65E8 JUMP LOCATION
Kiki_HopToSpot:
{
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    LDA.w $0D80, X : SEC : SBC.b #$02 : TAY
    LDA.w Pool_Kiki_HopToSpot_x_targets, Y : SEC : SBC.w $0D10, X
    CLC : ADC.b #$02 : CMP.b #$04 : BCS .BRANCH_ALPHA
        LDA.w Pool_Kiki_HopToSpot_y_targets, Y : SEC : SBC.w $0D00, X
        CLC : ADC.b #$02 : CMP.b #$04 : BCS .BRANCH_ALPHA
            INC.w $0D80, X
            
            STZ.w $0D40, X
            STZ.w $0D50, X
            
            LDA.b #$20 : STA.w $0E00, X
            
            LDA.b #$21
            JSL.l Sound_SetSfx2PanLong
            
            RTS
    
    .BRANCH_ALPHA
    
    LDA.w Pool_Kiki_HopToSpot_x_targets+0, Y : STA.b $04
    LDA.w Pool_Kiki_HopToSpot_x_targets+1, Y : STA.b $05
    
    LDA.w Pool_Kiki_HopToSpot_y_targets+0, Y : STA.b $06
    LDA.w Pool_Kiki_HopToSpot_y_targets+1, Y : STA.b $07
    
    LDA.b #$09
    JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    
    LDA.b $01 : STA.w $0D50, X
    
    RTS
}

; ==============================================================================

; $0F65E9-$0F65ED DATA
Pool_Kiki_WalkOnRoof:
{
    ; $0F65E9
    .directions
    db 2, 1, -1
    
    ; $0F65EC
    .timers
    db $52, $00
}

; $0F65EE-$0F663F JUMP LOCATION
Kiki_WalkOnRoof:
{
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    LDA.w $0F70, X : BNE .BRANCH_ALPHA
        LDA.w $0DF0, X : BNE .BRANCH_ALPHA
            LDA.w $0D90, X : TAY
            INC.w $0D90, X
            
            LDA.w Pool_Kiki_WalkOnRoof_directions, Y : BMI .BRANCH_BETA
                PHA : STA.w $0DE0, X
                
                LDA.w Pool_Kiki_WalkOnRoof_timers, Y : STA.w $0DF0, X
                
                ; OPTIMIZE: Why not just PLY?
                PLA : TAY
                LDA.w Pool_Kiki_WalkOnRoof2_x_speeds, Y : STA.w $0D50, X
                LDA.w Pool_Kiki_WalkOnRoof2_y_speeds, Y : STA.w $0D40, X
                
    .BRANCH_ALPHA
    
    RTS
    
    .BRANCH_BETA
    
    INC.w $0D80, X
    
    STZ.w $0D50, X
    STZ.w $0D40, X
    
    ; Initiate the palace of darkness opening animation.
    LDA.b #$01 : STA.w $04C6
    
    STZ.b $B0
    STZ.b $C8
    
    STZ.w $0DE0, X
    
    STZ.w $02E4
    
    RTS
}

; $0F6640-$0F6656 JUMP LOCATION
Kiki_ReadyButtonPress:
{
    LDA.b #$08 : STA.w $0DE0, X
    
    STZ.w $0DC0, X
    
    JSL.l GetRandomInt : AND.b #$0F : ADC.b #$10 : STA.w $0F80, X
    
    INC.w $0D80, X
    
    RTS
}

; $0F6657-$0F6669 JUMP LOCATION
Kiki_SlamButton:
{
    LDA.w $0F80, X : BPL .BRANCH_ALPHA
        LDA.w $0F70, X : BNE .BRANCH_ALPHA
            INC.w $0D80, X
            
            LDA.b #$25
            JSL.l Sound_SetSfx3PanLong
            
    .BRANCH_ALPHA

    ; Bleeds into the next function.
}

; $0F666A-$0F666A JUMP LOCATION
Kiki_IdleOnRoof:
{
    RTS
} 

; ==============================================================================

; $0F666B-$0F6679 LONG JUMP LOCATION
Kiki_InitiatePalaceOpeningProposal:
{
    JSR.w Kiki_TransitionFromTagalong
    
    LDA.b #$01 : STA.w $0E80, Y
    
    LDA.b #$00 : STA.l $7EF3CC
    
    RTL
}

; ==============================================================================

; $0F667A-$0F66C6 LOCAL JUMP LOCATION
Kiki_TransitionFromTagalong:
{
    PHA
    
    LDA.b #$B6
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        PLA : PHX
        
        TAX
        
        LDA.w $1A64, X : AND.b #$03 : STA.w $0EB0, Y
                                      STA.w $0DE0, Y
        
        LDA.w $1A00, X : CLC : ADC.b #$02 : STA.w $0D00, Y
        LDA.w $1A14, X       : ADC.b #$00 : STA.w $0D20, Y
        
        LDA.w $1A28, X : CLC : ADC.b #$02 : STA.w $0D10, Y
        LDA.w $1A3C, X       : ADC.b #$00 : STA.w $0D30, Y
        
        LDA.b $EE : STA.w $0F20, Y
        
        LDA.b #$01 : STA.w $0BA0, Y
        INC        : STA.w $0F20, Y
        
        STZ.b $5E
        
        PLX
        
        RTS
    
    .spawn_failed
    
    PLA
    
    RTS
}

; ==============================================================================

; $0F66C7-$0F66CF LONG JUMP LOCATION
Kiki_InitiateFirstBeggingSequence:
{
    JSR.w Kiki_TransitionFromTagalong
    
    LDA.b #$02 : STA.w $0E80, Y
    
    RTL
}

; ==============================================================================

; $0F66D0-$0F66E8 LONG JUMP LOCATION
Kiki_AbandonDamagedPlayer:
{
    JSR.w Kiki_TransitionFromTagalong
    
    LDA.b #$01 : STA.w $0F70, Y
    
    LDA.b #$10 : STA.w $0F80, Y
    
    LDA.b #$03 : STA.w $0E80, Y
       
    LDA.b #$00 : STA.l $7EF3CC
    
    RTL
}

; ==============================================================================

; $0F66E9-$0F6858 DATA
Pool_Kiki_Draw:
{
    ; $0F66E9
    .source_offsets
    dw $C020, $C020, $A000, $A000, $8040, $6040, $8040, $6040
    
    ; $0F66F9
    .OAM_groups
    dw  0, -6 : db $20, $00, $00, $02
    dw  0,  0 : db $22, $00, $00, $02
    dw  0, -6 : db $20, $00, $00, $02
    dw  0,  0 : db $22, $40, $00, $02
    dw  0, -6 : db $20, $00, $00, $02
    dw  0,  0 : db $22, $00, $00, $02
    dw  0, -6 : db $20, $00, $00, $02
    dw  0,  0 : db $22, $40, $00, $02
    dw -1, -6 : db $20, $00, $00, $02
    dw  0,  0 : db $22, $00, $00, $02
    dw -1, -6 : db $20, $00, $00, $02
    dw  0,  0 : db $22, $00, $00, $02
    dw  1, -6 : db $20, $40, $00, $02
    dw  0,  0 : db $22, $40, $00, $02
    dw  1, -6 : db $20, $40, $00, $02
    dw  0,  0 : db $22, $40, $00, $02
    dw  0, -6 : db $CE, $01, $00, $02
    dw  0,  0 : db $EE, $01, $00, $02
    dw  0, -6 : db $CE, $01, $00, $02
    dw  0,  0 : db $EE, $01, $00, $02
    dw  0, -6 : db $CE, $41, $00, $02
    dw  0,  0 : db $EE, $41, $00, $02
    dw  0, -6 : db $CE, $41, $00, $02
    dw  0,  0 : db $EE, $41, $00, $02
    dw -1, -6 : db $CE, $01, $00, $02
    dw  0,  0 : db $EC, $01, $00, $02
    dw -1, -6 : db $CE, $41, $00, $02
    dw  0,  0 : db $EC, $01, $00, $02
    dw  1, -6 : db $CE, $41, $00, $02
    dw  0,  0 : db $EC, $41, $00, $02
    dw  1, -6 : db $CE, $01, $00, $02
    dw  0,  0 : db $EC, $41, $00, $02
    
    ; $0F67F9
    .OAM_groups_2
    dw 0, -6 : db $CA, $01, $00, $00
    dw 8, -6 : db $CA, $41, $00, $00
    dw 0,  2 : db $DA, $01, $00, $00
    dw 8,  2 : db $DA, $41, $00, $00
    dw 0, 10 : db $CB, $01, $00, $00
    dw 8, 10 : db $CB, $41, $00, $00
    dw 0, -6 : db $DB, $01, $00, $00
    dw 8, -6 : db $DB, $41, $00, $00
    dw 0,  2 : db $CC, $01, $00, $00
    dw 8,  2 : db $CC, $41, $00, $00
    dw 0, 10 : db $DC, $01, $00, $00
    dw 8, 10 : db $DD, $41, $00, $00     
}

; $0F6859-$0F68B5 LOCAL JUMP LOCATION
Kiki_Draw:
{
    ; TODO: Figure out the semantics of $0DE0 for this sprite.
    LDA.w $0DE0, X : CMP.b #$08 : BCS .unknown
        LDA.w $0DE0, X : ASL : ADC.w $0DC0, X : ASL : TAY
        LDA.w Pool_Kiki_Draw_source_offsets+0, Y : STA.w $0AE8
        LDA.w Pool_Kiki_Draw_source_offsets+1, Y : STA.w $0AEA
        
        TYA : ASL #3
        ADC.b #(Pool_Kiki_Draw_OAM_groups >> 8)              : STA.b $08
        LDA.b #(Pool_Kiki_Draw_OAM_groups >> 8) : ADC.b #$00 : STA.b $09
        
        LDA.b #$02
        JSR.w Sprite3_DrawMultiple
        
        LDA.w $0F00, X : BNE .paused
            JSL.l Sprite_DrawShadowLong
            
        .paused
        
        RTS
    
    .unknown
    
    LDA.w $0DC0, X : ASL : ADC.w $0DC0, X : ASL #4
    ADC.b #(Pool_Kiki_Draw_OAM_groups_2 >> 0)              : STA.b $08
    LDA.b #(Pool_Kiki_Draw_OAM_groups_2 >> 8) : ADC.b #$00 : STA.b $09
    
    LDA.b #$06
    JSR.w Sprite3_DrawMultiple
    
    LDA.w $0F00, X : BNE .paused_2
        JSL.l Sprite_DrawShadowLong
        
    .paused_2
    
    RTS
}

; ==============================================================================
