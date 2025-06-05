; ==============================================================================

; $02F0CD-$02F0D4 LONG JUMP LOCATION
Sprite_ElderLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_Elder
    
    PLB
    
    RTL
}

; ==============================================================================

; $02F0D5-$02F0E9 LOCAL JUMP LOCATION
Sprite_Elder:
{
    JSR.w Elder_Draw
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.w $0E80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Sprite_Sahasrahla ; 0x00 - $F14D
    dw Sprite_Aginah     ; 0x01 - $F0EA
}

; ==============================================================================

; $02F0EA-$02F14C JUMP LOCATION
Sprite_Aginah:
{
    ; Guarantees that this is the first thing he says.
    LDA.l $7EF3C6 : AND.b #$20 : BEQ .alpha
        ; If you don't have the master sword (or better).
        LDA.l $7EF359 : CMP.b #$02 : BCC .beta
            LDA.b #$28
            LDY.b #$01
            JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
            
            BRA .gamma
            
        .beta
        
        LDA.l $7EF374 : AND.b #$07 : CMP.b #$07 : BNE .delta
            LDA.b #$26
            LDY.b #$01
            JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
            
            BRA .gamma
        
        .delta
        
        AND.b #$02 : CMP.b #$02 : BNE .epsilon
            LDA.b #$29
            LDY.b #$01
            JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
            
            BRA .gamma
            
        .epsilon
        
        LDA.l $7EF34E : BEQ .alpha
            LDA.b #$27
            LDY.b #$01
            JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
            
            BRA .gamma
    
    .alpha
    
    ; "I am Aginah..."
    LDA.b #$25
    LDY.b #$01
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    LDA.l $7EF3C6 : ORA.b #$20 : STA.l $7EF3C6
    
    .gamma
    
    JMP Elder_AdvanceAnimationState
}

; ==============================================================================

; $02F14D-$02F15B JUMP LOCATION
Sprite_Sahasrahla:
{
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Sahasrahla_Dialogue                 ; 0x00 - $F160
    dw Sahasrahla_MarkMap                  ; 0x01 - $F1E9
    dw Sahasrahla_GrantBoots               ; 0x02 - $F1FB
    dw Sahasrahla_ShamelesslyPromoteIceRod ; 0x03 - $F20E
}

; ==============================================================================

; $02F15C-$02F15F DATA
Pool_Sahasrahla_Dialogue:
{
    ; "You are correct, young man! I am Sahasrahla, the village elder..."
    ; "Oh!? You got the Pendant Of Courage! Now I will tell you more..."
    ; $02F15C
    .messages_low
    db $39, $38

    ; $02F15E
    .messages_high
    db $00, $00
}

; $02F160-$02F1DB JUMP LOCATION
Sahasrahla_Dialogue:
{
    LDA.l $7EF374 : AND.b #$04 : BNE .has_third_pendant
        ; I am, indeed, Sahasrahla, the village elder and a descendent of..."
        LDA.b #$32
        LDY.b #$00
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .dont_show
            INC.w $0D80, X
        
        .dont_show
        
        BRA .advance_animation_state
    
    .has_third_pendant
    
    LDA.l $7EF355 : BNE .has_boots
        LDA.l $7EF3C7 : CMP.b #$03 : ROL : AND.b #$01 : TAY
        
        LDA.w Pool_Sahasrahla_Dialogue_messages_low, Y  : XBA
        LDA.w Pool_Sahasrahla_Dialogue_messages_high, Y : TAY : XBA
        
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .dont_show_2
            INC.w $0D80, X : INC.w $0D80, X
        
        .dont_show_2
        
        BRA .advance_animation_state
        
    .has_boots
    
    LDA.l $7EF346 : BNE .has_ice_rod
        ; "A helpful item is hidden in the cave on the east side (...) Get it!"
        LDA.b #$37
        LDY.b #$00
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
        
        BRA .advance_animation_state
        
    .has_ice_rod
    
    LDA.l $7EF374 : AND.b #$07 : CMP.b #$07 : BEQ .has_all_pendants
        ; ...relatives of the wise men are hiding (...) should find them."
        LDA.b #$34
        LDY.b #$00
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
        
        BRA .advance_animation_state
        
    .has_all_pendants
    
    LDA.l $7EF359 : CMP.b #$02 : BCS .has_master_sword
        ; Incredible! ... Now, you should go to the Lost Woods..."
        LDA.b #$30
        LDY.b #$00
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
        
        BRA .advance_animation_state
    
    .has_master_sword
    
    ; "I am too old to fight. I can only rely on you."
    LDA.b #$31
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    .advance_animation_state

    ; Bleeds into the next function.
}

; $02F1DC-$02F1E8 JUMP LOCATION
Elder_AdvanceAnimationState:
{
    LDA.b $1A : LSR #5 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02F1E9-$02F1FA JUMP LOCATION
Sahasrahla_MarkMap:
{
    ; "Good. As a test, can you retrieve the Pendant Of Courage (...) ?"
    LDA.b #$33
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    LDA.b #$03 : STA.l $7EF3C7
    
    RTS
}

; ==============================================================================

; $02F1FB-$02F20D JUMP LOCATION
Sahasrahla_GrantBoots:
{
    LDY.b #$4B
    
    STZ.w $02E9
    
    JSL.l Link_ReceiveItem
    
    INC.w $0D80, X
    
    LDA.b #$03 : STA.l $7EF3C7
    
    RTS
}

; ==============================================================================

; $02F20E-$02F219 JUMP LOCATION
Sahasrahla_ShamelesslyPromoteIceRod:
{
    ; "A helpful item is hidden in the cave on the east side (...) Get it!"
    LDA.b #$37
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
}

; ==============================================================================

; $02F21A-$02F239 DATA
Pool_Elder_Draw_animation_states:
{
    dw 0, -9 : db $A0, $00, $00, $02
    dw 0,  0 : db $A2, $00, $00, $02
    
    dw 0, -8 : db $A0, $00, $00, $02
    dw 0,  0 : db $A4, $40, $00, $02        
}

; Sahasralah / Aginah graphics selector
; $02F23A-$02F259 LOCAL JUMP LOCATION
Elder_Draw:
{
    LDA.b #$02 : STA.b $06 : STZ.b $07
    
    LDA.w $0DC0, X : ASL #4
    
    ADC.b #.animation_states                 : STA.b $08
    LDA.b #.animation_states>>8 : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
