; ==============================================================================

; $0331DE-$0331ED DATA
Pool_Smithy_Main:
{
    .animation_states
    db  0,  1,  2,  3,  3,  2,  1,  0
    
    .animation_timers
    db 24,  4,  1, 16, 16,  5, 10, 16
}

; ==============================================================================

; $0331EE-$0331FC JUMP LOCATION
Sprite_SmithyBros:
{
    LDA.w $0E80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Smithy_Main
    dw SmithySpark_Main
    dw SmithyFrog_Main
    dw ReturningSmithy_Main
}

; ==============================================================================

; $0331FD-$03320D JUMP LOCATION
ReturningSmithy_Main:
{
    JSR ReturningSmithy_Draw
    JSR Sprite_CheckIfActive
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw ReturningSmithy_ApproachTheBench
    dw ReturningSmithy_CopiouslyThankful
}

; ==============================================================================

; $03320E-$03321A DATA
Pool_ReturningSmithy_ApproachTheBench:
{
    .timers
    db $68, $0C
    
    .directions
    db $00, $02, $FF
    
    .x_speeds
    db   0,   0, -13,  13
    
    .y_speeds
    db -13,  13,   0,   0
}

; ==============================================================================

; $03321B-$033254 JUMP LOCATION
ReturningSmithy_ApproachTheBench:
{
    JSR Sprite_Move
    
    LDA $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    LDA.w $0DF0, X : BNE .direction_change_delay
    
    LDA.w $0D90, X : TAY
    
    INC A : STA.w $0D90, X
    
    LDA.w $B20E, Y : STA.w $0DF0, X
    
    LDA.w $B210, Y : BMI .done_walking
    
    STA.w $0DE0, X : TAY
    
    LDA.w $B213, Y : STA.w $0D50, X
    
    LDA.w $B217, Y : STA.w $0D40, X
    
    .direction_change_delay
    
    RTS
    
    .done_walking
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $033255-$033273 JUMP LOCATION
ReturningSmithy_CopiouslyThankful:
{
    JSL Sprite_PlayerCantPassThrough
    
    ; Smithy bros. saying "thank you!"
    LDA.b #$E3
    LDY.b #$00
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    STZ.w $02E4
    
    LDA.b #$01 : STA.w $0DE0, X
    
    ; Smithy partner has been saved
    LDA.l $7EF3C9 : ORA.b #$20 : STA.l $7EF3C9
    
    RTS
}

; ==============================================================================

; $033274-$0332BF JUMP LOCATION
SmithyFrog_Main:
{
    JSR SmithyFrog_Draw
    JSR Sprite_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    JSR Sprite_MoveAltitude
    
    LDA.w $0F70, X : BPL .ano_reset_hop
    
    STZ.w $0F70, X
    
    LDA.b #$10 : STA.w $0F80, X
    
    .ano_reset_hop
    
    LDA.w $0D80, X : BNE .transition_to_tagalong
    
    LDA.b #$01 : STA.w $0DE0, X
    
    ; "Ribbit Ribbit! Your body did not change!..."
    LDA.b #$E1
    LDY.b #$00
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    BCC .player_not_close_enough
    
    INC.w $0D80, X
    
    .player_not_close_enough
    
    RTS
    
    .transition_to_tagalong
    
    ; Set tagalong to missing dwarf in Dark World (smithy frog)
    LDA.b #$07 : STA.l $7EF3CC
    
    PHX
    
    JSL Tagalong_LoadGfx
    JSL Tagalong_SpawnFromSprite
    
    PLX
    
    STZ.w $0DD0, X
    
    RTS
}

; ==============================================================================

; $0332C0-$033307 DATA
Pool_ReturningSmithy_Draw:
{
    .oam_groups
    dw 0, 0 : db $22, $41, $00, $02
    
    dw 0, 0 : db $22, $01, $00, $02
    
    dw 0, 0 : db $22, $41, $00, $02
    
    dw 0, 0 : db $22, $01, $00, $02
    
    dw 0, 0 : db $22, $01, $00, $02
    
    dw 0, 0 : db $22, $01, $00, $02
    
    dw 0, 0 : db $22, $41, $00, $02
    
    dw 0, 0 : db $22, $41, $00, $02
    
    .vram_source_offsets
    db $C0, $C0, $A0, $A0, $80, $60, $80, $60
}

; ==============================================================================

; $033308-$033330 JUMP LOCATION
ReturningSmithy_Draw:
{
    LDA.b #$01 : STA $06
                 STZ $07
    
    LDA.w $0DE0, X : ASL A : ADC.w $0DC0, X : TAY
    
    ; This sprite apparently vram to change appearance rather than using
    ; different sprite tile numbers.
    LDA .vram_source_offsets, Y : STA.w $0AEA
    
    TYA : ASL #3
    
    ADC.b #.oam_groups                   : STA $08
    LDA.b #.oam_groups>>8   : ADC.b #$00 : STA $09
    
    JSL Sprite_DrawMultiple.player_deferred
    JMP Sprite_DrawShadow
}

; ==============================================================================

; $033331-$033338 DATA
Pool_SmithyFrog_Draw:
{
    .oam_groups
    dw 0, 0 : db $C8, $00, $00, $02
}

; ==============================================================================

; $033339-$03334D LOCAL JUMP LOCATION
SmithyFrog_Draw:
{
    LDA.b #$01 : STA $06
                 STZ $07
    
    LDA.b #.oam_groups    : STA $08
    LDA.b #.oam_groups>>8 : STA $09
    
    JSL Sprite_DrawMultiple.player_deferred
    JMP Sprite_DrawShadow
}

; ==============================================================================

; $03334E-$0333E2 JUMP LOCATION
Smithy_Main:
{
    JSR Smithy_Draw
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    JSR Sprite_MoveAltitude
    
    LDA.w $0F70, X : BPL .aloft
    
    STZ.w $0F70, X
    STZ.w $0F80, X
    
    .aloft
    
    JSR Sprite_CheckIfActive
    
    LDY.w $0E90, X
    
    LDA.w $0D80, Y
    
    CMP.b #$05 : BEQ .tick_animation_timer
    CMP.b #$07 : BEQ .tick_animation_timer
    CMP.b #$09 : BEQ .tick_animation_timer
    
    ORA.w $0D80, X : BEQ .tick_animation_timer
    
    LDA.w $0D80, X
    
    CMP.b #$05 : BEQ .tick_animation_timer
    CMP.b #$07 : BEQ .tick_animation_timer
    CMP.b #$09 : BNE .dont_do_hammering_animation
    
    .tick_animation_timer
    
    LDA.w $0DA0, X : DEC.w $0DA0, X : CMP.b #$00 : BNE .animation_step_delay
    
    LDA.w $0D90, X : TAY
    
    INC A : AND.b #$07 : STA.w $0D90, X
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    LDA .animation_timers, Y : STA.w $0DA0, X
    
    CPY.b #$01 : BNE .anojump
    
    LDA.b #$10 : STA.w $0F80, X
    
    .anojump
    
    CPY.b #$03 : BNE .spark_spawn_delay
    
    JSR SmithyBros_SpawnSmithySpark
    
    LDA.b #$05 : JSL Sound_SetSfx2PanLong
    
    .spark_spawn_delay
    .animation_step_delay
    .dont_do_hammering_animation
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    ; \tcrf Does this hint that there were other items they could temper?
    ; Note the repeat of the tempering sword mode and the three do nothing
    ; states that are not used. Also note that the above code references
    ; these states (7 and 9 being the unused indices).
    dw Smithy_ConversationStart
    dw Smithy_ProvideTemperingChoice
    dw Smithy_HandleTemperingChoice
    dw Smithy_HandleTemperingCost
    dw Smithy_TemperingSword
    dw Smithy_TemperingSword
    dw Smithy_GrantTemperedSword
    dw Smithy_DoNothing
    dw Smithy_DoNothing
    dw Smithy_DoNothing
    dw Smithy_SpawnReturningSmithy
    dw Smithy_CopiouslyThankful
}

; ==============================================================================

; $0333E3-$03343C JUMP LOCATION
Smithy_ConversationStart:
{
    STZ.w $0DB0, X
    
    LDA.l $7EF3CC : CMP.b #$08 : BEQ .no_returning_smithy_tagalong
    
    JSR Smithy_NearbyHammerUseListener : BCC .not_hammer_time
    
    ; "Hey hey, amateurs shouldn't try to do this. ..."
    LDA.b #$E4
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    LDA.b #$60 : STA.w $0E00, X
    
    INC.w $0DB0, X
    
    RTS
    
    .not_hammer_time
    
    LDA.l $7EF3C9 : AND.b #$20 : BEQ .partner_smithy_still_missing
    
    ; "Hey you! Welcome! Ask us to do anything!"
    LDA.b #$D8
    LDY.b #$00
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .player_didnt_speak
    
    INC.w $0D80, X
    
    INC.w $0DB0, X
    
    .player_didnt_speak
    
    RTS
    
    .partner_smithy_still_missing
    
    ; "If my lost partner returns, we can temper your sword. ..."
    LDA.b #$DF
    LDY.b #$00
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
    
    .no_returning_smithy_tagalong
    
    LDA $20 : CMP.b #$C2 : BCS .await_closer_player
    
    ; "Oh! Happy days are here again! You found my partner!..."
    LDA.b #$E0
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    LDA.b #$0A : STA.w $0D80, X
    
    INC.w $02E4
    
    .await_closer_player
    
    RTS
}

; ==============================================================================

; $03343D-$03345E LOCAL JUMP LOCATION
Smithy_NearbyHammerUseListener:
{
    LDA.w $0E00, X : BNE .delay
    
    LDA.w $0202 : CMP.b #$0C : BNE .not_using_hammer
    
    LDA.w $0301 : AND.b #$02 : BEQ .not_using_hammer
    
    LDA.w $0300 : CMP.b #$02 : BNE .not_using_hammer
    
    JSR Sprite_CheckDamageToPlayer_same_layer : BCC .no_collision
    
    RTS
    
    .delay
    .no_collision
    .not_using_hammer
    
    CLC
    
    RTS
}

; ==============================================================================

; $03345F-$03347B JUMP LOCATION
Smithy_ProvideTemperingChoice:
{
    LDA.w $1CE8 : BNE .player_said_no
    
    ; "I'll give you a big discount! >Sword Tempered >No..."
    LDA.b #$D9
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
    
    .player_said_no
    
    ; "Drop by again any time you want to. Hi Ho!..."
    LDA.b #$DC
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
}

; ==============================================================================

; $03347C-$0334AC JUMP LOCATION
Smithy_HandleTemperingChoice:
{
    LDA.w $1CE8 : BNE .player_said_no
    
    LDA.l $7EF359 : CMP.b #$03 : BCS .tempered_sword_or_better
    
    ; "Tempered, eh? Are you sure? ..."
    LDA.b #$DA
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
    
    .tempered_sword_or_better
    
    ; "Well, we can't make it any stronger than that..."
    LDA.b #$DB
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
    
    .player_said_no
    
    ; "Drop by again any time you want to. Hi Ho!..."
    LDA.b #$DC
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
}

; ==============================================================================

; $0334AD-$03350D JUMP LOCATION
Smithy_HandleTemperingCost:
{
    LDA.w $1CE8 : BEQ .player_asks_for_tempering
    
    ; "Drop by again any time you want to. Hi Ho!..."
    LDA.b #$DC
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
    
    .player_asks_for_tempering
    
    REP #$20
    
    LDA.l $7EF360 : CMP.w #$000A : SEP #$30 : BCS .player_can_afford
    
    ; "Drop by again any time you want to. Hi Ho!..."
    LDA.b #$DC
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
    
    .player_can_afford
    
    REP #$20
    
    ; Take my 10 rupees you dirty bastard dwarves
    LDA.l $7EF360 : SEC : SBC.w #$000A : STA.l $7EF360
    
    SEP #$30
    
    ; "All right, no problem. We'll have to keep your sword..."
    LDA.b #$DD
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    LDY.w $0E90, X 
    
    LDA.b #$05 : STA.w $0D80, Y
                 STA.w $0D80, X
    
    STZ.w $0ABF
    
    ; Make it so Link has no sword (until it gets tempered)
    LDA.b #$FF : STA.l $7EF359
    
    LDA.l $7EF3C9 : ORA.b #$80 : STA.l $7EF3C9
    
    RTS
}

; ==============================================================================

; $03350E-$033547 JUMP LOCATION
Smithy_TemperingSword:
{
    STZ.w $0DB0, X
    
    JSR Smithy_NearbyHammerUseListener : BCC .not_hammer_time
    
    ; "Hey hey, amateurs shouldn't try to do this. You're just getting..."
    LDA.b #$E4
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    LDA.b #$60 : STA.w $0E00, X
    
    INC.w $0DB0, X
    
    RTS
    
    .not_hammer_time
    
    LDA.w $0ABF : BEQ .player_hasnt_changed_overworld_screens
    
    ; "Your sword is tempered up! Now hold it!"
    LDA.b #$DE
    LDY.b #$00
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .no_player_dialogue
    
    INC.w $0D80, X
    
    LDA.b #$04 : STA.w $0DC0, X
    
    .no_player_dialogue
    
    RTS
    
    .player_hasnt_changed_overworld_screens
    
    LDA.b #$E2
    LDY.b #$00
    
    ; "I'm sorry, we're not done yet. Come back after a while."
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $033548-$033568 JUMP LOCATION
Smithy_GrantTemperedSword:
{
    LDY.w $0E90, X
    
    LDA.b #$00 : STA.w $0D80, X
                 STA.w $0D80, Y
    
    ; Give Link the tempered sword
    LDY #$02
    
    STZ.w $02E9
    
    PHX
    
    JSL Link_ReceiveItem
    
    PLX
    
    LDA.l $7EF3C9 : AND.b #$7F : STA.l $7EF3C9
    
    RTS
}

; ==============================================================================

; $033569-$033569 JUMP LOCATION
Smithy_DoNothing:
{
    RTS
}

; ==============================================================================

; $03356A-$03359C JUMP LOCATION
Smithy_SpawnReturningSmithy:
{
    LDA.b #$1A
    
    JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA $22 : STA.w $0D10, Y
    LDA $23 : STA.w $0D30, Y
    
    LDA $20 : STA.w $0D00, Y
    LDA $21 : STA.w $0D20, Y
    
    LDA.b #$03 : STA.w $0E80, Y : STA.w $0BA0, Y
    
    .spawn_failed
    
    INC.w $0D80, X
    
    LDA.b #$00 : STA.l $7EF3CC
    
    LDA.b #$04 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $03359D-$0335A5 JUMP LOCATION
Smithy_CopiouslyThankful:
{
    ; "Thank you! Thank you!"
    LDA.b #$E3
    LDY.b #$00
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $0335A6-$0335D2 LOCAL JUMP LOCATION
Smithy_SpawnOtherSmithy:
{
    LDA.b #$1A
    
    JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    LDA $00 : CLC : ADC.b #$2C : STA.w $0D10, Y
    LDA $01              : STA.w $0D30, Y
    
    LDA $02 : STA.w $0D00, Y
    LDA $03 : STA.w $0D20, Y
    
    LDA.b #$01 : STA.w $0DE0, Y
    
    LDA.b #$04 : STA.w $0D90, Y
                 STA.w $0BA0, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0335D3-$033672 DATA
Pool_Smithy_Draw:
{
    dw   1,   0 : db $40, $40, $00, $02
    dw -11, -10 : db $60, $40, $00, $02
    
    dw  -1,   0 : db $40, $00, $00, $02
    dw  11, -10 : db $60, $00, $00, $02
    
    dw   1,   0 : db $40, $40, $00, $02
    dw  -3, -14 : db $44, $40, $00, $02
    
    dw  -1,   0 : db $40, $00, $00, $02
    dw   3, -14 : db $44, $00, $00, $02
    
    dw   1,   0 : db $42, $40, $00, $02
    dw  11, -10 : db $60, $00, $00, $02
    
    dw  -1,   0 : db $42, $00, $00, $02
    dw -11, -10 : db $60, $40, $00, $02
    
    dw   1,   0 : db $42, $40, $00, $02
    dw  13,   2 : db $62, $40, $00, $02
    
    dw  -1,   0 : db $42, $00, $00, $02
    dw -13,   2 : db $62, $00, $00, $02
    
    dw   0,   0 : db $64, $40, $00, $02
    dw   0,   0 : db $62, $40, $00, $02
    
    dw   0,   0 : db $64, $00, $00, $02
    dw   0,   0 : db $64, $00, $00, $02
}

; ==============================================================================

; $033673-$033695 LOCAL JUMP LOCATION
Smithy_Draw:
{
    LDA.b #$02 : STA $06
                 STZ $07
    
    LDA.w $0DC0, X : ASL A : ADC.w $0DE0, X : ASL #4
    
    ADC.b #$D3              : STA $08
    LDA.b #$B5 : ADC.b #$00 : STA $09
    
    JSL Sprite_DrawMultiple.player_deferred
    JSR Sprite_DrawShadow
    
    RTS
}

; ==============================================================================

; $033696-$0336A2 DATA
Pool_SmithySpark_Main:
{
    .animation_states
    db 0, 1, 2, 1, 2, 1, -1
    
    .timers
    db 4, 1, 3, 2, 1, 1
}

; ==============================================================================

; $0336A3-$0336CA JUMP LOCATION
SmithySpark_Main:
{
    JSR SmithySpark_Draw
    JSR Sprite_CheckIfActive
    
    LDA.w $0DF0, X : BNE .delay
    
    LDA.w $0D90, X : TAY
    
    INC A : AND.b #$07 : STA.w $0D90, X
    
    LDA.w $B696, Y : BMI .self_terminate
    
    STA.w $0DC0, X
    
    LDA.w $B69D, Y : STA.w $0DF0, X
    
    .delay
    
    RTS
    
    .self_terminate
    
    STZ.w $0DD0, X
    
    RTS
}

; ==============================================================================

; $0336CB-$0336CC DATA
Pool_SmithyBros_SpawnSmithySpark:
{
    .x_offsets
    db 15, -15
}

; ==============================================================================

; $0336CD-$0336FB LOCAL JUMP LOCATION
SmithyBros_SpawnSmithySpark:
{
    LDA.b #$1A
    
    JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    PHX
    
    LDA.w $0DE0, X : TAX
    
    LDA $00 : CLC : ADC .x_offsets, X : STA.w $0D10, Y
    LDA $01                    : STA.w $0D30, Y
    
    LDA $02 : CLC : ADC.b #$02 : STA.w $0D00, Y
    LDA $03              : STA.w $0D20, Y
    
    LDA.b #$01 : STA.w $0E80, Y
    
    PLX
    
    .spawn_failed
    
    RTS
} 

; ==============================================================================

; $0336FC-$03372B DATA
Pool_SmithySpark_Draw:
{
    .oam_groups
    dw  0,  3 : db $AA, $41, $00, $02
    dw  0, -1 : db $AA, $41, $00, $02
    
    dw -4,  0 : db $90, $01, $00, $00
    dw 12,  0 : db $90, $41, $00, $00
    
    dw -5, -2 : db $91, $01, $00, $00
    dw 13, -2 : db $91, $01, $00, $00    
}

; ==============================================================================

; $03372C-$033749 LOCAL JUMP LOCATION
SmithySpark_Draw:
{
    LDA.b #$08 : JSL OAM_AllocateFromRegionB
    
    LDA.w $0DC0, X : ASL #4
    
    ADC.b #.oam_groups                 : STA $08
    LDA.b #.oam_groups>>8 : ADC.b #$00 : STA $09
    
    LDA.b #$02 : JSL Sprite_DrawMultiple
    
    RTS
}

; ==============================================================================
