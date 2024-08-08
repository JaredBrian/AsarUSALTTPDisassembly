
; ==============================================================================

; $0F5C5B-$0F5C67 JUMP LOCATION
Sprite_DashBeeHive:
{
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw DashBeeHive_WaitForDash
    dw Bee_Normal
    dw Bee_PutInbottle
}

; ==============================================================================

; $0F5C68-$0F5C7A JUMP LOCATION
DashBeeHive_WaitForDash:
{
    LDA.w $0E90, X : BNE .not_dashed_into_yet
    
    STZ.w $0DD0, X
    
    LDY.b #$0B
    
    .next_spawn_attempt
    
    PHY
    
    JSR.w DashBeeHive_SpawnBee
    
    PLY : DEY : BPL .next_spawn_attempt
    
    .not_dashed_into_yet
    
    RTS
}

; ==============================================================================

; $0F5C7B-$0F5C8E DATA
Pool_Bee:
{
    .speeds
    db $0F, $05, $FB, $F1, $14, $0A, $F6, $EC
    
    .half_speeds
    db $08, $02, $FE, $F8, $0A, $05, $FB, $F6
    
    .timers
    db $40, $40, $FF, $FF    
}

; ==============================================================================

; $0F5C8F-$0F5CCE LOCAL JUMP LOCATION
DashBeeHive_SpawnBee:
{
    LDA.b #$79 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL.l Sprite_SetSpawnedCoords
    
    ; $0F5C9B ALTERNATE ENTRY POINT
    shared DashBeeHive_InitBee:
    
    PHX
    
    LDA.b #$01 : STA.w $0D80, Y
    
    TYA : AND.b #$03 : TAX
    
    LDA.w .timers, X : STA.w $0DF0, Y
                     STA.w $0D90, Y
    
    LDA.b #$60 : STA.w $0F10, Y
    
    JSL.l GetRandomInt : AND.b #$07 : TAX
    
    LDA Bee.speeds, X : STA.w $0D50, Y
    
    JSL.l GetRandomInt : AND.b #$07 : TAX
    
    LDA Bee.speeds, X : STA.w $0D40, Y
    
    PLX
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0F5CCF-$0F5D40 LONG JUMP LOCATION
PlayerItem_ReleaseBee:
{
    PHB : PHK : PLB
    
    LDA.b #$B2 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA.b $EE : STA.w $0F20, Y
    
    LDA.b $22 : CLC : ADC.b #$08 : STA.w $0D10, X
    LDA.b $23 : CLC : ADC.b #$00 : STA.w $0D30, X
    
    LDA.b $20 : CLC : ADC.b #$10 : STA.w $0D00, X
    LDA.b $21 : CLC : ADC.b #$00 : STA.w $0D20, X
    
    PHX
    
    LDX.w $0202
    
    LDA.l $7EF33F, X : TAX
    
    LDA.l $7EF35B, X : CMP.b #$08 : BNE .not_good_bee
    
    LDA.b #$01 : STA.w $0EB0, Y
    
    .not_good_bee
    
    JSR.w DashBeeHive_InitBee
    
    JSL.l GetRandomInt : AND.b #$07 : TAX
    
    LDA Bee.half_speeds, X : STA.w $0D50, Y
    
    JSL.l GetRandomInt : AND.b #$07 : TAX
    
    LDA Bee.half_speeds, X : STA.w $0D40, Y
    
    LDA.b #$40 : STA.w $0DF0, Y
                 STA.w $0D90, Y
    
    PLX
    
    PLB
    
    LDA.b #$00
    
    RTL
    
    .spawn_failed
    
    PLB
    
    LDA.b #$FF
    
    RTL
}

; ==============================================================================

; $0F5D41-$0F5D44 DATA
Pool_Bee_Normal:
{
    .box_sizes
    db 0, 5, 10, 15
}

; ==============================================================================

; $0F5D45-$0F5DF0 JUMP LOCATION
Bee_Normal:
{
    JSR.w Bee_SetAltitude
    JSL.l Sprite_PrepAndDrawSingleSmallLong
    JSR.w Bee_DetermineInteractionStatus
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckIfRecoiling
    
    LDA.w $0EB0, X : BEQ .not_good_bee
    
    JSL.l Sprite_SpawnSparkleGarnish
    
    .not_good_bee
    
    JSR.w Bee_Buzz
    JSR.w Sprite3_Move
    
    TXA : EOR.b $1A : LSR A : AND.b #$01 : STA.w $0DC0, X
    
    LDA.w $0F10, X : BNE .anointeract_with_player
    
    JSR.w Sprite3_CheckDamageToPlayer
    
    JSL.l Sprite_CheckDamageFromPlayerLong : BEQ .anointeract_with_player
    
    ; "You caught a bee! What will you do?"
    ; "> Keep it in a bottle"
    ; "  Set it free"
    LDA.b #$C8
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
    
    .anointeract_with_player
    
    LDA.b $1A : BNE .dont_adjust_timer_supplement
    
    LDA.w $0D90, X : CMP.b #$10 : BEQ .dont_adjust_timer_supplement
    
    SEC : SBC.b #$08 : STA.w $0D90, X
    
    .dont_adjust_timer_supplement
    
    LDA.w $0DF0, X : BNE .delay_direction_change
    
    JSL.l GetRandomInt : AND.b #$03 : TAY
    
    LDA.b $22 : CLC : ADC .box_sizes, Y : STA.b $04
    LDA.b $23 : ADC.b #$00        : STA.b $05
    
    JSL.l GetRandomInt : AND.b #$03 : TAY
    
    LDA.b $20 : CLC : ADC .box_sizes, Y : STA.b $06
    LDA.b $21 : ADC.b #$00        : STA.b $07
    
    LDA.b #$14 : JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    
    LDA.b $01 : STA.w $0D50, X : BPL .set_h_flip_on
    
    LDA.w $0F50, X : AND.b #$BF
    
    BRA .store_h_flip_status
    
    .set_h_flip_on
    
    LDA.w $0F50, X : ORA.b #$40
    
    .store_h_flip_status
    
    STA.w $0F50, X
    
    TXA : CLC : ADC.w $0D90, X : STA.w $0DF0, X
    
    .delay_direction_change
    
    RTS
}

; ==============================================================================

; $0F5DF1-$0F5E2D JUMP LOCATION
Bee_PutInbottle:
{
    JSR.w Bee_DetermineInteractionStatus
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $1CE8 : BNE .was_set_free
    
    JSL.l Sprite_GetEmptyBottleIndex : BMI .no_empty_bottle
    
    LDA.w $0EB0, X : STA.b $00
    
    PHX
    
    TYX
    
    LDA.b #$07 : CLC : ADC.b $00 : STA.l $7EF35C, X
    
    JSL.l HUD.RefreshIconLong
    
    PLX
    
    STZ.w $0DD0, X
    
    RTS
    
    .no_empty_bottle
    
    LDA.b #$CA
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional
    
    .was_set_free:
    
    LDA.b #$40 : STA.w $0F10, X
    
    LDA.b #$01 : STA.w $0D80, X
    
    RTS
}

; ==============================================================================

; $0F5E2E-$0F5E43 LONG JUMP LOCATION
Sprite_GetEmptyBottleIndex:
{
    PHX
    
    LDX.b #$00
    
    .next_bottle
    
    LDA.l $7EF35C, X : CMP.b #$02 : BEQ .empty_bottle
    
    INX : CPX.b #$04 : BCC .next_bottle
    
    LDX.b #$FF
    
    .empty_bottle
    
    TXY
    
    PLX
    
    TYA
    
    RTL
}

; ==============================================================================

; $0F5E44-$0F5E62 LOCAL JUMP LOCATION
Bee_DetermineInteractionStatus:
{
    LDA.b $11 : CMP.b #$02 : BNE .not_in_text_mode
    
    REP #$20
    
    LDA.w $1CF0 : CMP.w #$00C8 : BEQ .player_didnt_capture_bee
                CMP.w #$00CA : BNE .player_captured_bee
    
    .player_didnt_capture_bee
    
    SEP #$30
    
    ; Set an 'ignore interaction' variable for the bee so it can't damage
    ; the player or be caught again for several frames.
    LDA.b #$28 : STA.w $0F10, X
    
    .player_captured_bee
    .not_in_text_mode
    
    SEP #$30
    
    RTS
}

; ==============================================================================

    ; NOTE: This version of the good bee is not general purpose, it's just the
    ; one that appears in the ice cave that can be collected via bug net.
; $0F5E63-$0F5E6F JUMP LOCATION
Sprite_GoodBee:
{
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw GoodBee_WaitingForDash
    dw GoodBee_Activated
    dw Bee_PutInbottle
}

; ==============================================================================

; $0F5E70-$0F5E8F JUMP LOCATION
GoodBee_WaitingForDash:
{
    LDA.w $0E90, X : BNE .not_dashed_into_yet
    
    STZ.w $0DD0, X
    
    ; Apparently the good bee is designed to be 'unique'.
    LDA.l $7EF35C : ORA.l $7EF35D : ORA.l $7EF35E : ORA.l $7EF35F
    
    ; HARDCODED: Checking using this bit pattern is pretty hardcoded. If
    ; more bottled item types were available, this could present a problem.
    AND.b #$08 : BNE .have_one_in_bottle
    
    JSR.w GoodBee_SpawnTangibleVersion
    
    .have_one_in_bottle
    .not_dashed_into_yet
    
    RTS
}

; ==============================================================================

; $0F5E90-$0F5ECF LOCAL JUMP LOCATION
GoodBee_SpawnTangibleVersion:
{
    LDA.b #$79 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL.l Sprite_SetSpawnedCoords
    
    LDA.b #$01 : STA.w $0D80, Y
    
    LDA.b #$40 : STA.w $0DF0, Y
                 STA.w $0D90, Y
    
    LDA.b #$60 : STA.w $0F10, Y
    LDA.b #$01 : STA.w $0EB0, Y
    
    PHX
    
    JSL.l GetRandomInt : AND.b #$07 : TAX
    
    LDA Bee.speeds, X : STA.w $0D50, Y
    
    JSL.l GetRandomInt : AND.b #$07 : TAX
    
    LDA Bee.speeds, X : STA.w $0D40, Y
    
    PLX
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0F5ED0-$0F5ED1 DATA
Pool_GoodBee_Activated:
{
    .unknown_1
    db $0A, $14
}

; ==============================================================================

    ; NOTE: This version of the good bee is not general purpose, it's just the
    ; one that appears in the ice cave that can be collective via bug net.
; $0F5ED2-$0F5F89 JUMP LOCATION
GoodBee_Activated:
{
    LDA.b #$01 : STA.w $0BA0, X
    
    JSR.w Bee_SetAltitude
    JSL.l Sprite_PrepAndDrawSingleSmallLong
    JSR.w Bee_DetermineInteractionStatus
    JSR.w Sprite3_CheckIfActive
    JSR.w Bee_Buzz
    JSR.w Sprite3_Move
    
    TXA : EOR.b $1A : LSR A : AND.b #$01 : STA.w $0DC0, X
    
    ; WTF: It's almost like the devs hadn't decided that only a good bee
    ; could appear in this fashion (as a single bee) from dashing.
    LDA.w $0EB0, X : BEQ .not_good_bee
    
    JSL.l Sprite_SpawnSparkleGarnish
    
    .not_good_bee
    
    ; UNUSED: Unless we can find an instance of this variable changing
    ; for the bee / good bee, I'd currently label this logic as unused.
    ; And therefore OPTIMIZE: (remove it).
    LDA.w $0DA0, X : LDY.w $0EB0, X : CMP .unknown_1, Y : BCC .unknown_0
    
    LDA.b #$40 : STA.w $0CAA, X
    
    RTS
    
    .unknown_0
    
    LDA.w $0F10, X : BNE .return
    
    JSL.l Sprite_CheckDamageFromPlayerLong : BEQ .not_caught_by_player
    
    ; "You caught a bee!..."
    LDA.b #$C8
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
    
    .not_caught_by_player
    
    TXA : EOR.b $1A : AND.b #$03 : BNE .return
    
    JSR.w GoodBee_ScanForTargetableSprites : BCS .pursuing_sprite
    
    TXA : EOR.b $1A : AND.b #$03 : BNE .return
    
    JSL.l GetRandomInt : AND.b #$03 : TAY
    
    LDA.b $22 : CLC : ADC .box_sizes, Y : STA.b $04
    LDA.b $23 : ADC.b #$00        : STA.b $05
    
    JSL.l GetRandomInt : AND.b #$03 : TAY
    
    LDA.b $20 : CLC : ADC .box_sizes, Y : STA.b $06
    LDA.b $21 : ADC.b #$00        : STA.b $07
    
    .pursuing_sprite
    
    TXA : EOR.b $1A : AND.b #$07 : BNE .return
    
    LDA.b #$20
    
    JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    
    LDA.b $01 : STA.w $0D50, X : BPL .pursuing_rightward
    
    LDA.w $0F50, X : AND.b #$BF
    
    BRA .set_h_flip_status
    
    .pursuing_rightward
    
    LDA.w $0F50, X : ORA.b #$40
    
    .set_h_flip_status
    
    STA.w $0F50, X
    
    .return
    
    RTS
}

; ==============================================================================

; $0F5F8A-$0F5FAA LOCAL JUMP LOCATION
Bee_SetAltitude:
{
    LDA.b #$10 : STA.w $0F70, X
    
    LDA.w $0EB0, X : BEQ .not_good_bee
    
    ; NOTE: Now this is interesting... It seems to set the bee's properties
    ; byte using some magic formula... WTF: Is this?
    LDA.w $0F50, X : AND.b #$F1 : STA.b $00
    
    LDA.b $1A : LSR #4 : AND.b #$03 : INC A : ASL A : ORA.b $00 : STA.w $0F50, X
    
    .not_good_bee
    
    RTS
}

; ==============================================================================

; $0F5FAB-$0F602D LOCAL JUMP LOCATION
GoodBee_ScanForTargetableSprites:
{
    LDA.b #$0F : STA.b $00
    
    TXA : ASL #2 : AND.b #$0F : TAY
    
    .next_sprite
    
    CPY.w $0FA0 : BEQ .skip_sprite
    
    LDA.w $0DD0, Y : CMP.b #$09 : BCC .skip_sprite
    
    LDA.w $0F00, Y : BNE .skip_sprite
    
    LDA.w $0E40, Y : BMI .is_npc_sprite
    
    LDA.w $0F20, Y : CMP.w $0F20, X : BNE .skip_sprite
    
    LDA.w $0F60, Y : AND.b #$40 : BNE .skip_sprite
    
    LDA.w $0BA0, Y : BEQ .attack_sprite
    
    BRA .skip_sprite
    
    .attack_sprite
    
    ; WTF: Again, a check of a good bee. Do normal bees ever attack other
    ; sprites? I don't think so?
    LDA.w $0EB0, X : BEQ .skip_sprite
    
    LDA.w $0CD2, Y : AND.b #$40 : BNE .attack_sprite
    
    .skip_sprite
    
    DEY : TYA : AND.b #$0F : TAY
    
    DEC.b $00 : BPL .next_sprite
    
    CLC
    
    RTS
    
    .attack_sprite
    
    JSL.l GoodBee_AttackOtherSprite
    
    PHX
    
    JSL.l GetRandomInt : AND.b #$03 : TAX
    
    LDA.w $0D10, Y : CLC : ADC .box_sizes, X : STA.b $04
    LDA.w $0D30, Y : ADC.b #$00        : STA.b $05
    
    JSL.l GetRandomInt : AND.b #$03 : TAX
    
    LDA.w $0D00, Y : CLC : ADC .box_sizes, X : STA.b $06
    LDA.w $0D20, Y : ADC.b #$00        : STA.b $07
    
    PLX
    
    SEC
    
    RTS
}

; ==============================================================================

; $0F602E-$0F603B LOCAL JUMP LOCATION
Bee_Buzz:
{
    TXA : EOR.b $1A : AND.b #$1F : BNE .delay
    
    LDA.b #$2C : JSL.l Sound_SetSfx3PanLong
    
    .delay
    
    RTS
}

; ==============================================================================
