
; ==============================================================================

; $033DC1-$033DCF JUMP LOCATION
Sprite_HoboEntities:
{
    LDA.w $0E80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Sprite_Hobo
    dw Sprite_HoboBubble
    dw Sprite_HoboFire
    dw Sprite_HoboSmoke
}

; ==============================================================================

; $033DD0-$033DF9 JUMP LOCATION
Sprite_Hobo:
{
    JSL.l Hobo_Draw
    JSR.w Sprite_CheckIfActive
    
    LDA.b #$03 : STA.w $0F60, X
    
    JSR.w Sprite_CheckDamageToPlayer_same_layer : BCC .no_player_collision
    
    JSL.l Sprite_NullifyHookshotDrag
    
    STZ.b $5E
    
    JSL.l Player_HaltDashAttackLong
    
    .no_player_collision
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Hobo_Sleeping
    dw Hobo_WakeUp
    dw Hobo_GrantBottle
    dw Hobo_BackToSleep
}

; ==============================================================================

; $033DFA-$033E29 JUMP LOCATION
Hobo_Sleeping:
{
    LDA.b #$07 : STA.w $0F60, X
    
    JSR.w Sprite_CheckDamageToPlayer_same_layer : BCC .dont_wake_up
    
    LDA.b $F6 : BPL .dont_wake_up
    
    INC.w $0D80, X
    
    LDY.w $0E90, X
    
    LDA.b #$04 : STA.w $0DF0, Y
    
    LDA.b #$01 : STA.w $02E4
    
    .dont_wake_up
    
    LDA.w $0E10, X : BNE .delay_bubble_spawn
    
    LDA.b #$A0 : STA.w $0E10, X
    
    JSR.w Hobo_SpawnBubble
    
    TYA : STA.w $0E90, X
    
    .delay_bubble_spawn
    
    RTS
}

; ==============================================================================

; $033E2A-$033E38 DATA
Pool_Hobo_WakeUp:
{
    .animation_states
    db 0, 1, 0, 1, 0, 1, 2, -1
    
    .timers
    db 6, 2, 6, 6, 2, 100, 30
}

; ==============================================================================

; $033E39-$033E5E JUMP LOCATION
Hobo_WakeUp:
{
    LDA.w $0DF0, X : BNE .delay
    
    LDY.w $0D90, X
    
    LDA.w .animation_states, Y : BMI .invalid_state
    
    STA.w $0DC0, X
    
    LDA.w .timers, Y : STA.w $0DF0, X
    
    INC.w $0D90, X
    
    .delay
    
    RTS
    
    .invalid_state
    
    ; "Yo! [Name]! You seem to be in a heap of trouble, ... this is all..."
    LDA.b #$D7
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $033E5F-$033E88 JUMP LOCATION
Hobo_GrantBottle:
{
    INC.w $0D80, X
    
    LDA.b #$01 : STA.w $0DC0, X
    
    PHX
    
    LDX.b $8A
    
    ; \event
    LDA.l $7EF280, X : ORA.b #$20 : STA.l $7EF280, X
    
    LDY.b #$16
    
    STZ.w $02E9
    
    ; \item
    ; Hobo gives you his bottle
    JSL.l Link_ReceiveItem
    
    ; \event
    LDA.l $7EF3C9 : ORA.b #$01 : STA.l $7EF3C9
    
    PLX
    
    RTS
}

; ==============================================================================

; $033E89-$033E9C JUMP LOCATION
Hobo_BackToSleep:
{
    STZ.w $02E4
    
    STZ.w $0DC0, X
    
    LDA.w $0DF0, X : BNE .bubble_spawn_delay
    
    LDA.b #$A0 : STA.w $0DF0, X
    
    JSR.w Hobo_SpawnBubble
    
    .bubble_spawn_delay
    
    RTS
}

; ==============================================================================

    ; NOTE: I know, why would this guy spawn himself? Makes no sense.
; $033E9D-$033EB1 LOCAL JUMP LOCATION
Hobo_SpawnHobo:
{
    LDA.b #$2B : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL.l Sprite_SetSpawnedCoords
    
    LDA.b #$00 : STA.w $0E80, Y
                 STA.w $0BA0, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

    ; UNUSED: Probably speeds. Maybe at one point the bubble bobbed up and down
    ; above the hobo's mouth?
; $033EB2-$033EB3 DATA
Pool_Sprite_HoboBubble:
{
    .unused
    db 1, -1
}

; ==============================================================================

; $033EB4-$033EEC JUMP LOCATION
Sprite_HoboBubble:
{
    LDA.b #$04 : JSL.l OAM_AllocateFromRegionC
    
    JSR.w Sprite_PrepAndDrawSingleSmall
    JSR.w Sprite_CheckIfActive
    
    LDA.b $1A : LSR #4 : AND.b #$01 : INC #2 : STA.w $0DC0, X
    
    LDA.w $0E00, X : BNE .ascend_delay
    
    INC.w $0DC0, X
    
    JSR.w Sprite_MoveAltitude
    
    LDA.w $0DF0, X : BNE .termination_delay
    
    STZ.w $0DD0, X
    
    .ascend_delay
    .termination_delay
    
    LDA.w $0DF0, X : CMP.b #$04 : BCS .anowrap_animation_counter
    
    LDA.b #$03 : STA.w $0DC0, X
    
    .anowrap_animation_state
    
    RTS
}

; ==============================================================================

; $033EED-$033F14 LOCAL JUMP LOCATION
Hobo_SpawnBubble:
{
    ; Spawn the sleep bubble hanging out of the hobo's nose?
    LDA.b #$2B
    
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL.l Sprite_SetSpawnedCoords
    
    LDA.b #$01 : STA.w $0E80, Y
    
    LDA.b #$02 : STA.w $0F80, Y
    
    LDA.b #$60 : STA.w $0DF0, Y
    
    LSR A : STA.w $0E00, Y : STA.w $0BA0, Y
    
    ; $033F0F ALTERNATE ENTRY POINT
    shared Sprite_ZeroOamAllocation:
    
    ; Zeroes out the sprite's oam slot allocation making it impossible to
    ; store any entries to the oam buffer, sort of...
    ; This seems to suggest that sprites that call this have manual
    ; oam allocation somewhere in their logic.
    LDA.b #$00 : STA.w $0E40, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $033F15-$033F4A JUMP LOCATION
Sprite_HoboFire:
{
    JSR.w Sprite_PrepAndDrawSingleSmall
    JSR.w Sprite_CheckIfActive
    
    LDA.b $1A : LSR #3 : AND.b #$03 : STA.b $00
    
    AND.b #$01 : STA.w $0DC0, X
    
    LDA.b $00 : ASL #4 : AND.b #$40 : STA.b $00
    
    ; Toggle... hflip? what? WTF:
    LDA.w $0F50, X : AND.b #$BF : ORA.b $00 : STA.w $0F50, X
    
    LDA.w $0DF0, X : BNE .delay_smoke_spawn
    
    JSR.w HoboFire_SpawnSmoke
    
    LDA.b #$2F : STA.w $0DF0, X
    
    .delay_smoke_spawn
    
    RTS
}

; ==============================================================================

; $033F4B-$033F7C LOCAL JUMP LOCATION
Hobo_SpawnCampfire:
{
    LDA.b #$2B
    
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA.b #$94 : STA.w $0D10, Y
    
    LDA.b #$01 : STA.w $0D30, Y
    
    LDA.b #$3F : STA.w $0D00, Y
    
    LDA.b #$00 : STA.w $0D20, Y
    
    LDA.b #$02 : STA.w $0E80, Y : STA.w $0BA0, Y
    
    JSR.w Sprite_ZeroOamAllocation
    
    LDA.w $0F50, Y : AND.b #$F1 : ORA.b #$02 : STA.w $0F50, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $033F7D-$033F80 DATA
Pool_Sprite_HoboSmoke:
{
    .vh_flip
    db $00, $40, $80, $C0
}

; ==============================================================================

; $033F81-$033FAE JUMP LOCATION
Sprite_HoboSmoke:
{
    LDA.b #$06 : STA.w $0DC0, X
    
    JSR.w Sprite_PrepAndDrawSingleSmall
    JSR.w Sprite_CheckIfActive
    JSR.w Sprite_Move
    JSR.w Sprite_MoveAltitude
    
    LDA.b $1A : LSR #4 : AND.b #$03 : TAY
    
    LDA.w $0F50, X : AND.b #$3F : ORA .vh_flip, Y : STA.w $0F50, X
    
    LDA.w $0DF0, X : BNE .termination_delay
    
    STZ.w $0DD0, X
    
    .termination_delay
    
    RTS
}

; ==============================================================================

; $033FAF-$033FDF LOCAL JUMP LOCATION
HoboFire_SpawnSmoke:
{
    LDA.b #$2B
    
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL.l Sprite_SetSpawnedCoords
    
    LDA.b $02 : SEC : SBC.b #$04 : STA.w $0D00, Y
    LDA.b $03 : SBC.b #$00 : STA.w $0D20, Y
    
    LDA.b #$03 : STA.w $0E80, Y
    
    LDA.b #$07 : STA.w $0F80, Y
    
    LDA.b #$60 : STA.w $0DF0, Y : STA.w $0BA0, Y
    
    JSR.w Sprite_ZeroOamAllocation
    
    .spawn_failed
    
    RTS
}

; ==============================================================================
