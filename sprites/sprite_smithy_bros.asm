; ==============================================================================

; $0331DE-$0331ED DATA
Pool_Smithy_Main:
{
    ; $0331DE
    .animation_states
    db  0,  1,  2,  3,  3,  2,  1,  0
    
    ; $0331D6
    .animation_timers
    db 24,  4,  1, 16, 16,  5, 10, 16
}

; ==============================================================================

; $0331EE-$0331FC JUMP LOCATION
Sprite_SmithyBros:
{
    LDA.w $0E80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Smithy_Main          ; 0x00 - $B34E
    dw SmithySpark_Main     ; 0x01 - $B6A3
    dw SmithyFrog_Main      ; 0x02 - $B274
    dw ReturningSmithy_Main ; 0x03 - $B1FD
}

; ==============================================================================

; $0331FD-$03320D JUMP LOCATION
ReturningSmithy_Main:
{
    JSR.w ReturningSmithy_Draw
    JSR.w Sprite_CheckIfActive
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw ReturningSmithy_ApproachTheBench  ; 0x00 - $B21B
    dw ReturningSmithy_CopiouslyThankful ; 0x01 - $B255
}

; ==============================================================================

; $03320E-$03321A DATA
Pool_ReturningSmithy_ApproachTheBench:
{
    ; $03320E
    .timers
    db $68, $0C
    
    ; $033210
    .directions
    db $00, $02, $FF
    
    ; $033213
    .x_speeds
    db   0,   0, -13,  13
    
    ; $033217
    .y_speeds
    db -13,  13,   0,   0
}

; $03321B-$033254 JUMP LOCATION
ReturningSmithy_ApproachTheBench:
{
    JSR.w Sprite_Move
    
    LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
        LDA.w $0DF0, X : BNE .direction_change_delay
            LDA.w $0D90, X : TAY
            INC            : STA.w $0D90, X
            
            LDA.w Pool_ReturningSmithy_ApproachTheBench_timers, Y : STA.w $0DF0, X
            
            LDA.w Pool_ReturningSmithy_ApproachTheBench_directions, Y : BMI .done_walking
                STA.w $0DE0, X
                TAY
                LDA.w Pool_ReturningSmithy_ApproachTheBench_x_speeds, Y : STA.w $0D50, X
                LDA.w Pool_ReturningSmithy_ApproachTheBench_y_speeds, Y : STA.w $0D40, X
        
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
    JSL.l Sprite_PlayerCantPassThrough
    
    ; Smithy bros. saying "thank you!"
    LDA.b #$E3
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
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
    JSR.w SmithyFrog_Draw
    JSR.w Sprite_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    JSR.w Sprite_MoveAltitude
    
    LDA.w $0F70, X : BPL .ano_reset_hop
        STZ.w $0F70, X
        
        LDA.b #$10 : STA.w $0F80, X
    
    .ano_reset_hop
    
    LDA.w $0D80, X : BNE .transition_to_tagalong
        LDA.b #$01 : STA.w $0DE0, X
        
        ; "Ribbit Ribbit! Your body did not change!..."
        LDA.b #$E1
        LDY.b #$00
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .player_not_close_enough
            INC.w $0D80, X
        
        .player_not_close_enough
        
        RTS
    
    .transition_to_tagalong
    
    ; Set tagalong to missing dwarf in Dark World (smithy frog).
    LDA.b #$07 : STA.l $7EF3CC
    
    PHX
    
    JSL.l Tagalong_LoadGfx
    JSL.l Tagalong_SpawnFromSprite
    
    PLX
    
    STZ.w $0DD0, X
    
    RTS
}

; ==============================================================================

; $0332C0-$033307 DATA
Pool_ReturningSmithy_Draw:
{
    ; $0332C0
    .OAM_groups
    dw 0, 0 : db $22, $41, $00, $02
    dw 0, 0 : db $22, $01, $00, $02
    dw 0, 0 : db $22, $41, $00, $02
    dw 0, 0 : db $22, $01, $00, $02
    dw 0, 0 : db $22, $01, $00, $02
    dw 0, 0 : db $22, $01, $00, $02
    dw 0, 0 : db $22, $41, $00, $02
    dw 0, 0 : db $22, $41, $00, $02
    
    ; $033300
    .VRAM_source_offsets
    db $C0, $C0, $A0, $A0, $80, $60, $80, $60
}

; $033308-$033330 JUMP LOCATION
ReturningSmithy_Draw:
{
    LDA.b #$01 : STA.b $06
                 STZ.b $07
    
    ; This sprite apparently VRAM to change appearance rather than using
    ; different sprite tile numbers.
    LDA.w $0DE0, X : ASL : ADC.w $0DC0, X : TAY
    LDA.w Pool_ReturningSmithy_Draw_VRAM_source_offsets, Y : STA.w $0AEA
    
    TYA : ASL #3
    ADC.b #Pool_ReturningSmithy_Draw_OAM_groups                 : STA.b $08
    LDA.b #Pool_ReturningSmithy_Draw_OAM_groups>>8 : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JMP Sprite_DrawShadow
}

; ==============================================================================

; $033331-$033338 DATA
SmithyFrog_Draw_OAM_groups:
{
    dw 0, 0 : db $C8, $00, $00, $02
}

; $033339-$03334D LOCAL JUMP LOCATION
SmithyFrog_Draw:
{
    LDA.b #$01 : STA.b $06
                 STZ.b $07
    
    LDA.b #.OAM_groups    : STA.b $08
    LDA.b #.OAM_groups>>8 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred

    JMP Sprite_DrawShadow
}

; ==============================================================================

; $03334E-$0333E2 JUMP LOCATION
Smithy_Main:
{
    JSR.w Smithy_Draw
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    JSR.w Sprite_MoveAltitude
    
    LDA.w $0F70, X : BPL .aloft
        STZ.w $0F70, X
        STZ.w $0F80, X
    
    .aloft
    
    JSR.w Sprite_CheckIfActive
    
    LDY.w $0E90, X
    LDA.w $0D80, Y : CMP.b #$05 : BEQ .tick_animation_timer
                     CMP.b #$07 : BEQ .tick_animation_timer
                     CMP.b #$09 : BEQ .tick_animation_timer
        ORA.w $0D80, X : BEQ .tick_animation_timer
            LDA.w $0D80, X : CMP.b #$05 : BEQ .tick_animation_timer
                             CMP.b #$07 : BEQ .tick_animation_timer
                             CMP.b #$09 : BNE .dont_do_hammering_animation
        
    .tick_animation_timer
    
    LDA.w $0DA0, X : DEC.w $0DA0, X : CMP.b #$00 : BNE .animation_step_delay
        LDA.w $0D90, X   : TAY
        INC : AND.b #$07 : STA.w $0D90, X
        
        LDA.w Pool_Smithy_Main_animation_states, Y : STA.w $0DC0, X
        LDA.w Pool_Smithy_Main_animation_timers, Y : STA.w $0DA0, X
        
        CPY.b #$01 : BNE .anojump
            LDA.b #$10 : STA.w $0F80, X
        
        .anojump
        
        CPY.b #$03 : BNE .spark_spawn_delay
            JSR.w SmithyBros_SpawnSmithySpark
            
            LDA.b #$05
            JSL.l Sound_SetSFX2PanLong
            
        .spark_spawn_delay
    .animation_step_delay

    .dont_do_hammering_animation
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Smithy_ConversationStart      ; 0x00 - $B3E3
    dw Smithy_ProvideTemperingChoice ; 0x01 - $B45F
    dw Smithy_HandleTemperingChoice  ; 0x02 - $B47C
    dw Smithy_HandleTemperingCost    ; 0x03 - $B4AD
    dw Smithy_TemperingSword         ; 0x04 - $B50E
    dw Smithy_TemperingSword         ; 0x05 - $B50E
    dw Smithy_GrantTemperedSword     ; 0x06 - $B548
    dw Smithy_DoNothing              ; 0x07 - $B569
    dw Smithy_DoNothing              ; 0x08 - $B569
    dw Smithy_DoNothing              ; 0x09 - $B569
    dw Smithy_SpawnReturningSmithy   ; 0x0A - $B56A
    dw Smithy_CopiouslyThankful      ; 0x0B - $B59D

    ; \tcrf Does this hint that there were other items they could temper?
    ; Note the repeat of the tempering sword mode and the three do nothing
    ; states that are not used. Also note that the above code references
    ; these states (7 and 9 being the unused indices).
}

; ==============================================================================

; $0333E3-$03343C JUMP LOCATION
Smithy_ConversationStart:
{
    STZ.w $0DB0, X
    
    LDA.l $7EF3CC : CMP.b #$08 : BEQ .no_returning_smithy_tagalong
        JSR.w Smithy_NearbyHammerUseListener : BCC .not_hammer_time
            ; "Hey hey, amateurs shouldn't try to do this. ..."
            LDA.b #$E4
            LDY.b #$00
            JSL.l Sprite_ShowMessageUnconditional
            
            LDA.b #$60 : STA.w $0E00, X
            
            INC.w $0DB0, X
            
            RTS
        
        .not_hammer_time
        
        LDA.l $7EF3C9 : AND.b #$20 : BEQ .partner_smithy_still_missing
            ; "Hey you! Welcome! Ask us to do anything!"
            LDA.b #$D8
            LDY.b #$00
            JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .player_didnt_speak
                INC.w $0D80, X
                
                INC.w $0DB0, X
                
            .player_didnt_speak
            
            RTS
            
        .partner_smithy_still_missing
        
        ; "If my lost partner returns, we can temper your sword. ..."
        LDA.b #$DF
        LDY.b #$00
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
        
        RTS
    
    .no_returning_smithy_tagalong
    
    LDA.b $20 : CMP.b #$C2 : BCS .await_closer_player
        ; "Oh! Happy days are here again! You found my partner!..."
        LDA.b #$E0
        LDY.b #$00    
        JSL.l Sprite_ShowMessageUnconditional
        
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
                    JSR.w Sprite_CheckDamageToPlayer_same_layer : BCC .no_collision
                        RTS

                    .no_collision
        .not_using_hammer
    .delay
    
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
        JSL.l Sprite_ShowMessageUnconditional
        
        INC.w $0D80, X
        
        RTS
    
    .player_said_no
    
    ; "Drop by again any time you want to. Hi Ho!..."
    LDA.b #$DC
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
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
            JSL.l Sprite_ShowMessageUnconditional
            
            INC.w $0D80, X
            
            RTS
        
        .tempered_sword_or_better
        
        ; "Well, we can't make it any stronger than that..."
        LDA.b #$DB
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        STZ.w $0D80, X
        
        RTS
    
    .player_said_no
    
    ; "Drop by again any time you want to. Hi Ho!..."
    LDA.b #$DC
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
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
        JSL.l Sprite_ShowMessageUnconditional
        
        STZ.w $0D80, X
        
        RTS
        
    .player_asks_for_tempering
    
    REP #$20
    
    LDA.l $7EF360 : CMP.w #$000A : SEP #$30 : BCS .player_can_afford
        ; "Drop by again any time you want to. Hi Ho!..."
        LDA.b #$DC
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        STZ.w $0D80, X
        
        RTS
        
    .player_can_afford
    
    REP #$20
    
    ; Take my 10 rupees you dirty bastard dwarves.
    LDA.l $7EF360 : SEC : SBC.w #$000A : STA.l $7EF360
    
    SEP #$30
    
    ; "All right, no problem. We'll have to keep your sword..."
    LDA.b #$DD
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    LDY.w $0E90, X
    LDA.b #$05 : STA.w $0D80, Y
                 STA.w $0D80, X
    
    STZ.w $0ABF
    
    ; Make it so Link has no sword (until it gets tempered).
    LDA.b #$FF : STA.l $7EF359
    
    LDA.l $7EF3C9 : ORA.b #$80 : STA.l $7EF3C9
    
    RTS
}

; ==============================================================================

; $03350E-$033547 JUMP LOCATION
Smithy_TemperingSword:
{
    STZ.w $0DB0, X
    
    JSR.w Smithy_NearbyHammerUseListener : BCC .not_hammer_time
        ; "Hey hey, amateurs shouldn't try to do this. You're just getting..."
        LDA.b #$E4
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        LDA.b #$60 : STA.w $0E00, X
        
        INC.w $0DB0, X
        
        RTS
        
    .not_hammer_time
    
    LDA.w $0ABF : BEQ .player_hasnt_changed_overworld_screens
        ; "Your sword is tempered up! Now hold it!"
        LDA.b #$DE
        LDY.b #$00
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .no_player_dialogue
            INC.w $0D80, X
            
            LDA.b #$04 : STA.w $0DC0, X
        
        .no_player_dialogue
        
        RTS
    
    .player_hasnt_changed_overworld_screens
    
    ; "I'm sorry, we're not done yet. Come back after a while."
    LDA.b #$E2
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $033548-$033568 JUMP LOCATION
Smithy_GrantTemperedSword:
{
    LDY.w $0E90, X
    
    LDA.b #$00 : STA.w $0D80, X
                 STA.w $0D80, Y
    
    ; Give Link the tempered sword.
    LDY #$02
    
    STZ.w $02E9
    
    PHX
    
    JSL.l Link_ReceiveItem
    
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
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.b $22 : STA.w $0D10, Y
        LDA.b $23 : STA.w $0D30, Y
        
        LDA.b $20 : STA.w $0D00, Y
        LDA.b $21 : STA.w $0D20, Y
        
        LDA.b #$03 : STA.w $0E80, Y
                     STA.w $0BA0, Y
    
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
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $0335A6-$0335D2 LOCAL JUMP LOCATION
Smithy_SpawnOtherSmithy:
{
    LDA.b #$1A
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.b $00 : CLC : ADC.b #$2C : STA.w $0D10, Y
        LDA.b $01                    : STA.w $0D30, Y
        
        LDA.b $02 : STA.w $0D00, Y
        LDA.b $03 : STA.w $0D20, Y
        
        LDA.b #$01 : STA.w $0DE0, Y
        
        LDA.b #$04 : STA.w $0D90, Y
                     STA.w $0BA0, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0335D3-$033672 DATA
Pool_Smithy_Draw_OAM_groups:
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

; $033673-$033695 LOCAL JUMP LOCATION
Smithy_Draw:
{
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DC0, X : ASL : ADC.w $0DE0, X : ASL #4
    ADC.b #OAM_groups                 : STA.b $08
    LDA.b #OAM_groups>>8 : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSR.w Sprite_DrawShadow
    
    RTS
}

; ==============================================================================

; $033696-$0336A2 DATA
Pool_SmithySpark_Main:
{
    ; $033696
    .animation_states
    db 0, 1, 2, 1, 2, 1, -1
    
    ; $03369D
    .timers
    db 4, 1, 3, 2, 1, 1
}

; $0336A3-$0336CA JUMP LOCATION
SmithySpark_Main:
{
    JSR.w SmithySpark_Draw
    JSR.w Sprite_CheckIfActive
    
    LDA.w $0DF0, X : BNE .delay
        LDA.w $0D90, X   : TAY
        INC : AND.b #$07 : STA.w $0D90, X
        
        LDA.w Pool_SmithySpark_Main_animation_states, Y : BMI .self_terminate
            STA.w $0DC0, X
            
            LDA.w Pool_SmithySpark_Main_timers, Y : STA.w $0DF0, X
            
    .delay
    
    RTS
    
    .self_terminate
    
    STZ.w $0DD0, X
    
    RTS
}

; ==============================================================================

; $0336CB-$0336CC DATA
SmithyBros_SpawnSmithySpark_x_offsets:
{
    db 15, -15
}

; $0336CD-$0336FB LOCAL JUMP LOCATION
SmithyBros_SpawnSmithySpark:
{
    LDA.b #$1A
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        PHX
        
        LDA.w $0DE0, X : TAX
        LDA.b $00 : CLC : ADC.w .x_offsets, X : STA.w $0D10, Y
        LDA.b $01                             : STA.w $0D30, Y
        
        LDA.b $02 : CLC : ADC.b #$02 : STA.w $0D00, Y
        LDA.b $03                    : STA.w $0D20, Y
        
        LDA.b #$01 : STA.w $0E80, Y
        
        PLX
    
    .spawn_failed
    
    RTS
} 

; ==============================================================================

; $0336FC-$03372B DATA
SmithySpark_Draw_OAM_groups:
{
    dw  0,  3 : db $AA, $41, $00, $02
    dw  0, -1 : db $AA, $41, $00, $02
    
    dw -4,  0 : db $90, $01, $00, $00
    dw 12,  0 : db $90, $41, $00, $00
    
    dw -5, -2 : db $91, $01, $00, $00
    dw 13, -2 : db $91, $01, $00, $00    
}

; $03372C-$033749 LOCAL JUMP LOCATION
SmithySpark_Draw:
{
    LDA.b #$08
    JSL.l OAM_AllocateFromRegionB
    
    LDA.w $0DC0, X : ASL #4
    ADC.b #.OAM_groups                 : STA.b $08
    LDA.b #.OAM_groups>>8 : ADC.b #$00 : STA.b $09
    
    LDA.b #$02
    JSL.l Sprite_DrawMultiple
    
    RTS
}

; ==============================================================================
