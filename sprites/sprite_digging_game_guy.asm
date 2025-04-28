; ==============================================================================

; Diggging game guy's code
; $0EFC38-$0EFC5A JUMP LOCATION
Sprite_DiggingGameGuy:
{
    JSR.w DiggingGameGuy_Draw
    JSR.w Sprite4_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    JSR.w Sprite4_Move
    
    STZ.w $0D50, X
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw DiggingGameGuy_Introduction       ; 0x00 - $FC5B
    dw DiggingGameGuy_DoYouWantToPlay    ; 0x01 - $FC89
    dw DiggingGameGuy_MoveOuttaTheWay    ; 0x02 - $FCE0
    dw DiggingGameGuy_StartMinigameTimer ; 0x03 - $FD0A
    dw DiggingGameGuy_TerminateMinigame  ; 0x04 - $FD18
    dw DiggingGameGuy_ComeBackLater      ; 0x05 - $FD42
}

; ==============================================================================

; $0EFC5B-$0EFC88 JUMP LOCATION
DiggingGameGuy_Introduction:
{
    ; If player is more than 7 pixels away...
    LDA.w $0D00, X : CLC : ADC.b #$07 : CMP $20 : BCS .return 
        ; If Link is not below this sprite...
        JSR.w Sprite4_DirectionToFacePlayer : CPY.b #$02 : BNE .return
            ; Do we have a follower?
            LDA.l $7EF3CC : BNE .freak_out_over_tagalong
                ; "Welcome to the treasure field. The object is to dig as many..."
                LDA.b #$87
                LDY.b #$01
            
                JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .return
                    INC.w $0D80, X
        
    .return
    
    RTS
    
    .freak_out_over_tagalong
    
    ; Not really sure why tagalongs are a big deal to this sprite. I can't
    ; imagine any situations where they'd interfere direction...
    
    ; "I can't tell you details, but it's not a convenient time..."
    LDA.b #$8C
    LDY.b #$01
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $0EFC89-$0EFCDF JUMP LOCATION
DiggingGameGuy_DoYouWantToPlay:
{
    LDA.w $1CE8 : BNE .player_has_no_selected
        REP #$20
        
        ; Do you have eighty rupees?
        LDA.l $7EF360 : CMP.w #$0050 : BCC .player_cant_afford
            ; Subtract the eighty rupees
            SBC.w #$0050 : STA.l $7EF360
            
            SEP #$30
            
            ; "Then I will lend you a shovel. When you have it in your hand..."
            LDA.b #$88
            LDY.b #$01
            JSL.l Sprite_ShowMessageUnconditional
            
            ; Increase the AI pointer.
            INC.w $0D80, X
            
            LDA.b #$01 : STA.w $0DC0, X
            
            LDA.b #$50 : STA.w $0DF0, X
            
            LDA.b #$00 : STA.l $7FFE00 : STA.l $7FFE01
            
            LDA.b #$05 : STA.w $0E00, X
            
            LDA.b #$01
            
            JSL.l Sprite_InitializeSecondaryItemMinigame
            
            ; Play the game time music.
            LDA.b #$0E : STA.w $012C
            
            RTS
        
        .player_cant_afford
    .player_has_no_selected
    
    SEP #$30
    
    ; "You suck for not having enough rupees" msg.
    LDA.b #$89
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    ; Reset the sprite back to it's original state.
    STZ.w $0D80, X
    
    RTS
}

; ==============================================================================

; $0EFCE0-$0EFD09 JUMP LOCATION
DiggingGameGuy_MoveOuttaTheWay:
{
    LDA.w $0DF0, X : BNE .wait_for_next_state
        INC.w $0D80, X
        
        LDA.b #$01 : STA.w $0DC0, X
        
        RTS
    
    .wait_for_next_state
    
    LDA.w $0E00, X : BNE .wait_to_move
        LDA.w $0DC0, X : EOR.b #$03 : STA.w $0DC0, X : AND.b #$01 : BEQ .move_not
            LDA.b #$F0 : STA.w $0D50, X
        
        .move_not
        
        LDA.b #$05 : STA.w $0E00, X
    
    .wait_to_move
    
    RTS
}

; ==============================================================================

; $0EFD0A-$0EFD17 JUMP LOCATION
DiggingGameGuy_StartMinigameTimer:
{
    INC.w $0D80, X
    
    ; Sets up a timer for the mini game.
    LDA.b #$00 : STA.w $04B5
    LDA.b #$1E : STA.w $04B4
    
    RTS
}

; ==============================================================================

; $0EFD18-$0EFD41 JUMP LOCATION
DiggingGameGuy_TerminateMinigame:
{
    LDA.w $04B4 : BEQ .timer_elapsed
        BMI .timer_elapsed
            RTS
    
    .timer_elapsed
    
    LDA.w $037A : AND.b #$01 : BNE .wait_till_shoveling_finished
        LDA.b #$09 : STA.w $012C
        
        INC.w $0D80, X
        
        STZ.w $03FC
        
        ; "OK! Time's up, game over. Come back again. Good bye..."
        LDA.b #$8A : STA.w $1CF0
        LDA.b #$01 : JSR.w Sprite4_ShowMessageMinimal
        
        ; Set the HUD timer to inactive.
        LDA.b #$FE : STA.w $04B4
        
    .wait_till_shoveling_finished
    
    RTS
}

; ==============================================================================

; $0EFD42-$0EFD4A JUMP LOCATION
DiggingGameGuy_ComeBackLater:
{
    ; "Come back again! I will be waiting for you."
    LDA.b #$8B
    LDY.b #$01
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
} 

; ==============================================================================

; $0EFD4B-$0EFD5B LONG JUMP LOCATION
DiggingGameGuy_AttemptPrizeSpawnLong:
{
    PHB : PHK : PLB
    
    LDA.l $7FFE01 : INC A : STA.l $7FFE01
    
    JSR.w DiggingGameGuy_AttemptPrizeSpawn
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EFD5C-$0EFD81 LOCAL JUMP LOCATION
DiggingGameGuy_AttemptPrizeSpawn:
{
    REP #$20
    
    LDA.b $20 : CMP.w #$0B18 : SEP #$30 : BCS DiggingGameGuy_GiveItem_nothing
        JSL.l GetRandomInt : AND.b #$07 : TAY
        
        JSL.l UseImplicitRegIndexedLocalJumpTable
        dw DiggingGameGuy_GiveItem_basic       ; 0x00 - $FD8A
        dw DiggingGameGuy_GiveItem_basic       ; 0x01 - $FD8A
        dw DiggingGameGuy_GiveItem_basic       ; 0x02 - $FD8A
        dw DiggingGameGuy_GiveItem_basic       ; 0x03 - $FD8A
        dw DiggingGameGuy_GiveItem_heart_piece ; 0x04 - $FDAC
        dw DiggingGameGuy_GiveItem_nothing     ; 0x05 - $FD8F
        dw DiggingGameGuy_GiveItem_nothing     ; 0x06 - $FD8F
        dw DiggingGameGuy_GiveItem_nothing     ; 0x07 - $FD8F
}

; ==============================================================================

; $0EFD82-$0EFD89 DATA
Pool_DiggingGameGuy_GiveItem:
{
    ; $0EFD82
    .x_speeds
    db $F0
    db $10
    
    ; $0EFD84
    .x_offsets
    db $00
    db $13
    
    ; $0EFD86
    .basic_types
    db $DB ; Red Rupee
    db $DA ; Blue Rupee
    db $D9 ; Green Rupee
    db $DF ; Small magic refill
}
    
; ==============================================================================

; $0EFD8A-$0EFD8E JUMP LOCATION
DiggingGameGuy_GiveItem_basic:
{
    LDA.w .basic_types, Y 
    
    BRA .spawn_item
}

; $0EFD8F-$0EFD8F JUMP LOCATION
DiggingGameGuy_GiveItem_nothing:
{
    RTS
}

; $0EFD90-$0EFDAB JUMP LOCATION
DiggingGameGuy_GiveItem_heart_piece:
{
    ; \tcrf (verified)
    ; In order to get the heart piece from the digging game,
    ; you must dig at least 25 holes. It is possible to get the heart piece
    ; on the 25th hole, just for clarity. This explains why a lot of people
    ; had trouble getting this heart piece, as it can be quite challenging
    ; to dig a large number of holes in this minigame. I've heard an upper
    ; limit of 35 holes per session which I find believable, but the spawn
    ; rate for the heart piece is also roughly 3%, which means it will
    ; likely take several attempts to get the heart piece.
    LDA.l $7FFE01 : CMP.b #$19 : BCC DiggingGameGuy_GiveItem_nothing
        LDA.l $7FFE00 : BNE DiggingGameGuy_GiveItem_nothing
            JSL.l GetRandomInt : AND.b #$03 : BNE DiggingGameGuy_GiveItem_nothing
                LDA.b #$EB : STA.l $7FFE00

                ; Bleeds into the next function.
}

; $0EFDAC-$0EFE02 JUMP LOCATION
DiggingGameGuy_GiveItem_spawn_item:
{     
    JSL.l Sprite_SpawnDynamically
                
    LDX.b #$00
                
    LDA.b $2F : CMP.b #$04 : BEQ .player_facing_left        
        INX
                
    .player_facing_left
                
    LDA.w .x_speeds, X : STA.w $0D50, Y
                
    LDA.b #$00 : STA.w $0D40, Y
    LDA.b #$18 : STA.w $0F80, Y
    LDA.b #$FF : STA.w $0B58, Y
    LDA.b #$30 : STA.w $0F10, Y
                
    LDA.b $22 : CLC : ADC .x_offsets, X : AND.b #$F0 : STA.w $0D10, Y
    LDA.b $23       : ADC.b #$00                     : STA.w $0D30, Y
                
    LDA.b $20 : CLC : ADC.b #$16 : AND.b #$F0 : STA.w $0D00, Y
    LDA.b $21       : ADC.b #$00              : STA.w $0D20, Y
                
    LDA.b #$00 : STA.w $0F20, Y
                
    TYX
                
    LDA.b #$30 : JSL.l Sound_SetSfx3PanLong
                
    RTS
}

; ==============================================================================

; $0EFE03-$0EFE4A DATA
DiggingGameGuy_Draw_OAM_groups:
{
    dw  0, -8 : db $40, $0A, $00, $02
    dw  4,  9 : db $56, $0C, $00, $00
    dw  0,  0 : db $42, $0A, $00, $02
    
    dw  0, -8 : db $40, $0A, $00, $02
    dw  0,  0 : db $42, $0A, $00, $02
    dw  0,  0 : db $42, $0A, $00, $02
    
    dw -1, -7 : db $40, $0A, $00, $02
    dw -1,  0 : db $44, $0A, $00, $02
    dw -1,  0 : db $44, $0A, $00, $02
}

; $0EFE4B-$0EFE6D LOCAL JUMP LOCATION
DiggingGameGuy_Draw:
{
    LDA.b #$03 : STA.b $06
                 STZ.b $07
    
    ; ptr = 0xFE03 + (i*24);
    LDA.w $0DC0, X : ASL A : ADC.w $0DC0, X : ASL #3
    
    ADC.b #.OAM_groups                 : STA.b $08
    LDA.b #.OAM_groups>>8 : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
