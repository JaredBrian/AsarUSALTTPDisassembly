; ==============================================================================

; $0EF943-$0EF94A LONG JUMP LOCATION
Sprite_TalkingTreeLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_TalkingTree
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EF94B-$0EF955 LOCAL JUMP LOCATION
Sprite_TalkingTree:
{
    LDA.w $0E80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw TalkingTree_Mouth ; 0x00 - $F956
    dw TalkingTree_Eye   ; 0x01 - $FB0A
}

; ==============================================================================

; $0EF956-$0EF96D JUMP LOCATION
TalkingTree_Mouth:
{
    JSR.w SpriteDraw_TalkingTree
    JSR.w Sprite4_CheckIfActive
    
    STZ.w $0F60, X
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw TalkingTree_IdleWithBomb    ; 0x00 - $F96E
    dw TalkingTree_DelayBomb       ; 0x01 - $F99C
    dw TalkingTree_SpitBomb        ; 0x02 - $F9B4
    dw TalkingTree_IdleWithoutBomb ; 0x03 - $F9E2
}

; ==============================================================================

; $0EF96E-$0EF99B JUMP LOCATION
TalkingTree_IdleWithBomb:
{
    STZ.w $0DC0, X
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .BRANCH_ALPHA
        JSL.l Player_HaltDashAttackLong
        
        LDA.b #$10 : STA.b $46
        
        LDA.b #$30
        JSL.l Sprite_ProjectSpeedTowardsPlayerLong
        
        LDA.b $00 : STA.b $27
        LDA.b $01 : STA.b $28
        
        LDA.b #$32
        JSL.l Sound_SetSfx3PanLong
        
        INC.w $0D80, X
        
        LDA.b #$30 : STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0EF99C-$0EF9AF JUMP LOCATION
TalkingTree_DelayBomb:
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        INC.w $0D80, X
        
        LDA.b #$08 : STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    LSR : AND.b #$03 : STA.w $0DC0, X

    RTS
}

; ==============================================================================

; $0EF9B0-$0EF9B3 DATA
TalkingTree_SpitBomb_animation_states:
{
    db $00, $02, $03, $01
}

; $0EF9B4-$0EF9D1 JUMP LOCATION
TalkingTree_SpitBomb:
{
    LDA.w $0DF0, X : LSR : TAY
    
    LDA.w .animation_states, X : STA.w $0DC0, X
    
    LDA.w $0DF0, X : CMP.b #$07 : BNE .BRANCH_ALPHA
        JSR.w TalkingTree_SpawnBomb
        
    .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BNE .BRANCH_BETA
        INC.w $0D80, X
    
    .BRANCH_BETA
    
    RTS
} 

; ==============================================================================

; $0EF9D2-$0EF9E1 DATA
Pool_TalkingTree_IdleWithoutBomb:
{
    ; $0EF9D2
    .animation_states
    db  1,  2,  3,  1,  3,  1,  2,  3
    
    ; $0EF9DA
    .timers
    db 13, 13, 13, 11, 11,  6, 16,  8
}

; $0EF9E2-$0EFA00 JUMP LOCATION
TalkingTree_IdleWithoutBomb:
{
    JSR.w TalkingTree_ChooseTalkingPoint
    
    LDA.w $0DF0, X : BNE .countingDown
        LDA.w $0DA0, X : INC : AND.b #$07 : STA.w $0DA0, X
                                            TAY
        LDA.w Pool_TalkingTree_IdleWithoutBomb_animation_states, Y : STA.w $0DC0, X
        LDA.w Pool_TalkingTree_IdleWithoutBomb_timers, Y           : STA.w $0DF0, X
        
    .countingDown
    
    RTS
}

; ==============================================================================

; $0EFA01-$0EFA02 DATA
TalkingTree_Messages_setA:
{
    db $82, $7D
}

; $0EFA03-$0EFA2A LOCAL JUMP LOCATION
TalkingTree_ChooseTalkingPoint:
{
    LDA.b #$07 : STA.w $0F60, X
    
    LDA.w $0D90, X : BNE TalkingTree_use_screen_based_message
        LDA.w $0D10, X : LSR #4 : AND.b #$01 : EOR.b #$01 : STA.w $0D90, X
                                                            TAY
        LDA.w TalkingTree_Messages_setAs, Y
        LDY.b #$00
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCS .didnt_solicit
            STZ.w $0D90, X
        
        .didnt_solicit
        
        RTS
}

; ==============================================================================

; $0EFA2B-$0EFA32 DATA
Pool_TalkingTree_use_screen_based_message:
{
    ; $0EFA2B
    .message_ids
    db $7E, $7F, $80, $81
    
    ; $0EFA2F
    .areas
    db $58 ; OW 58 - Village of Outcasts
    db $5D ; OW 5D - Dark Hylia River Peninsula
    db $72 ; OW 72 - Stumpy Grove Entrance
    db $6B ; OW 6B - West of Bomb Shop
}

; $0EFA33-$0EFA4D BRANCH LOCATION
TalkingTree_use_screen_based_message:
{
    LDY.b #$00
    LDA.b $8A
    
    .BRANCH_BETA
    
        CMP.w Pool_TalkingTree_use_screen_based_message_areas, Y : BEQ .BRANCH_ALPHA
            INY : BEQ .BRANCH_ALPHA
    BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.w Pool_TalkingTree_use_screen_based_message_message_ids, Y
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D90, X
    
    RTS
}

; ==============================================================================

; $0EFA4E-$0EFA7A LOCAL JUMP LOCATION
TalkingTree_SpawnBomb:
{
    LDA.b #$4A : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_TransmuteToEnemyBomb
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b $02 : CLC : ADC.b #$28 : STA.b $08
        LDA.b $03       : ADC.b #$00 : STA.b $03
        
        LDA.b #$40 : STA.w $0E00, Y
        
        LDA.b #$18 : STA.w $0D40, Y
        
        LDA.b #$12 : STA.w $0F80, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0EFADB-$0EFAFA LOCAL JUMP LOCATION
SpriteDraw_TalkingTree:
{
    LDA.w $0DC0, X : DEC : BMI .BRANCH_ALPHA
        ASL #5     : ADC.b #$7B : STA.b $08
        LDA.b #$FA : ADC.b #$00 : STA.b $09
        
        LDA.b #$04 : STA.b $06
                     STZ.b $07
        
        JSL.l Sprite_DrawMultiple_player_deferred
        
    .BRANCH_ALPHA
    
    RTS
} 

; ==============================================================================

; $0EFAFB-$0EFB09 DATA
Pool_TalkingTree_Eye:
{
    ; $0EFAFB
    .offset_x
    db  9, -9

    ; $0EFAFD
    .offset_y
    db  0, -1

    ; $0EFAFF
    .pupil_offset_x_low
    db -2, -1,  0,  1,  2

    ; $0EFB04
    .pupil_offset_x_high
    db -1

    ; $0EFB05
    .pupil_offset_y
    db -1,  0,  0,  0, -1
}

; $0EFB0A-$0EFB85 JUMP LOCATION
TalkingTree_Eye:
{
    JSL.l Sprite_PrepAndDrawSingleSmallLong
    JSR.w Sprite4_CheckIfActive
    
    LDY.w $0EB0, X
    LDA.w $0D90, X : CLC : ADC.w Pool_TalkingTree_Eye_offset_x, Y : STA.w $0D10, X
    LDA.w $0DA0, X       : ADC.w Pool_TalkingTree_Eye_offset_y, Y : STA.w $0D30, X
    
    LDA.w $0DB0, X : STA.w $0D00, X
    LDA.w $0E90, X : STA.w $0D20, X
    
    LDA.b #$02
    JSL.l Sprite_ProjectSpeedTowardsPlayerLong
    
    LDA.b $00 : BMI .BRANCH_ALPHA
        LDA.b $01 : CLC : ADC.b #$02 : STA.w $0DE0, X
        
        BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.w $0DE0, X : CMP.b #$02 : BEQ .BRANCH_BETA
        ROL : AND.b #$01 : TAY
        LDA.w $0DE0, X
        CLC : ADC.w Pool_Sprite_ApplyConveyorAdjustment_x_shake_values, Y
        STA.w $0DE0, X
        
    .BRANCH_BETA
    
    LDY.w $0DE0, X
    LDA.w $0D90, X : CLC : ADC.w Pool_TalkingTree_Eye_pupil_offset_x_low, Y
    STA.w $0D10, X

    LDA.w $0DA0, X       : ADC.w Pool_TalkingTree_Eye_pupil_offset_x_high, Y
    STA.w $0D30, X
    
    LDA.w $0DB0, X : CLC : ADC.w Pool_TalkingTree_Eye_pupil_offset_y, Y
    STA.w $0D00, X

    LDA.w $0E90, X       : ADC.w Pool_TalkingTree_Eye_pupil_offset_y, Y
    STA.w $0D20, X
    
    RTS
}

; ==============================================================================

; $0EFB86-$0EFB89 DATA
Pool_TalkingTree_SpawnEyes:
{
    ; $0EFB86
    .x_offsets_low
    db $FC, $0E
    
    ; $0EFB88
    .x_offsets_high
    db $FF, $00
}

; $0EFB8A-$0EFBCB LONG JUMP LOCATION
TalkingTree_SpawnEyes:
{
    PHX : PHA
    
    LDA.b #$25
    JSL.l Sprite_SpawnDynamically
    
    PLA : STA.w $0EB0, Y 
          TAX
    
    ; TODO: OPTIMIZE: Why are these ADCs .l?
    LDA.b $00 : CLC : ADC.l Pool_TalkingTree_SpawnEyes_x_offsets_low, X
    STA.w $0D10, Y
    STA.w $0D90, Y

    LDA.b $01       : ADC.l Pool_TalkingTree_SpawnEyes_x_offsets_high, X
    STA.w $0D30, Y
    STA.w $0DA0, Y
    
    LDA.b $02 : CLC : ADC.b #$F5 : STA.w $0D00, Y
                                   STA.w $0DB0, Y
                                   
    LDA.b $03       : ADC.b #$FF : STA.w $0D20, Y
                                   STA.w $0E90, Y
    
    LDA.b #$01 : STA.w $0E80, Y
    
    PLX
    
    RTL
}

; ==============================================================================
