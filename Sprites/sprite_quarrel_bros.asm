; ==============================================================================

; $02E00B-$02E012 LONG JUMP LOCATION
Sprite_QuarrelBrosLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_QuarrelBros
    
    PLB
    
    RTL
}

; ==============================================================================

; $02E013-$02E051 LOCAL JUMP LOCATION
Sprite_QuarrelBros:
{
    JSR.w QuarrelBros_Draw
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_MakeBodyTrackHeadDirection
    
    JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    LDA.b $A0 : AND.b #$01 : BNE .is_right_hand_brother
        ; Hey [Name], did you come from my older brother's room?..."
        LDA.b #$31
        LDY.b #$01
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
        
        BRA .moving_on
    
    .is_right_hand_brother
    
    LDA.w $0401 : BNE .door_bombed_open
        ; Yeah [Name], now I'm quarreling with my younger brother. I sealed..."
        LDA.b #$2F
        LDY.b #$01
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
        
        BRA .moving_on
        
    .door_bombed_open
    
    ; "So the doorway is open again... maybe I should make up with my..."
    LDA.b #$30
    LDY.b #$01
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    .moving_on
    
    JSL.l Sprite_PlayerCantPassThrough
    
    RTS
}

; ==============================================================================

; $02E052-$02E062 UNUSED
Sprite_Oprhan1:
{
    JSR.w Sprite2_Move
    
    JSR.w Sprite2_CheckTileCollision
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Orphan1_State1 ; 0x00 - $E06B
    dw Orphan1_State2 ; 0x01 - $E0B6
}

; ==============================================================================

; $02E063-$02E06A UNUSED DATA
Pool_Oprhan1_State1:
{
    ; $02E063
    .x_speeds
    db $00, $00, $F4, $0B
    
    ; $02E067
    .y_speeds
    db $F4, $0B, $00, $00
}

; $02E06B-$02E0B5 UNUSED JUMP LOCATION
Orphan1_State1:
{
    LDA.w $0DF0, X : BNE .delay
        JSL.l GetRandomInt : AND.b #$1F : CLC : ADC.b #$40 : STA.w $0DF0, X
        
        ; Picks a sort of new random direction that will be different from
        ; the previous direction.
        LDA.b $1A : AND.b #$01 : ORA.b #$02 : EOR.w $0DE0, X : STA.w $0DE0, X
        
    .delay
    
    LDA.w $0E70, X : AND.b #$0F : BEQ .no_wall_collision
        INC.w $0D80, X
        
        LDA.b #$60 : STA.w $0DF0, X
    
    .no_wall_collision
    
    TXA : EOR.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    LDY.w $0DE0, X
    LDA.w Pool_Oprhan1_State1_x_speeds, Y : STA.w $0D50, X
    LDA.w Pool_Oprhan1_State1_y_speeds, Y : STA.w $0D40, X
    
    TYA : STA.w $0D90, X
    
    RTS
}

; ==============================================================================

; $02E0B6-$02E0FE UNUSED JUMP LOCATION
Orphan1_State2:
{
    LDA.w $0DF0, X : BNE .delay
        JSL.l GetRandomInt : AND.b #$1F : CLC : ADC.b #$60 : STA.w $0DF0, X
        
        STZ.w $0D80, X
        
        ; Picks a sort of new random direction that will be different from
        ; the previous direction.
        LDA.b $1A : AND.b #$01 : ORA.b #$02 : EOR.w $0DE0, X : STA.w $0DE0, X
        
    .delay
    
    STZ.w $0D50, X
    STZ.w $0D40, X
    
    TXA : EOR.b $1A : LSR #5 : AND.b #03 : STA.b $00
    AND.b #$01 : BNE .skip
        LDA.b $00 : LSR : ORA.b #$02 : EOR.w $0DE0, X : STA.w $0DE0, X
        
        RTS
        
    .skip
    
    LDA.w $0DE0, X : STA.w $0D90, X
    
    RTS
}

; ==============================================================================

; $02E0FF-$02E17E DATA
QuarrelBros_Draw_animation_states:
{
    dw 0, -12 : db $04, $00, $00, $02
    db 0,   0 : db $0A, $00, $00, $02
    db 0, -11 : db $04, $00, $00, $02
    db 0,   1 : db $0A, $40, $00, $02
    db 0, -12 : db $04, $00, $00, $02
    db 0,   0 : db $0A, $00, $00, $02
    db 0, -11 : db $04, $00, $00, $02
    db 0,   1 : db $0A, $40, $00, $02
    db 0, -12 : db $08, $00, $00, $02
    db 0,   0 : db $0A, $00, $00, $02
    db 0, -11 : db $08, $00, $00, $02
    db 0,   1 : db $0A, $40, $00, $02
    db 0, -12 : db $08, $40, $00, $02
    db 0,   0 : db $0A, $00, $00, $02
    db 0, -11 : db $08, $40, $00, $02
    db 0,   1 : db $0A, $40, $00, $02
}

; $02E17F-$02E1A2 LOCAL JUMP LOCATION
QuarrelBros_Draw:
{
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    ; This is using the table at $E0FF.
    LDA.w $0DE0, X : ASL : ADC.w $0DC0, X : ASL #4
    ADC.b #QuarrelBros_Draw_animation_states>>8 : STA.b $08

    LDA.b #QuarrelBros_Draw_animation_states : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
