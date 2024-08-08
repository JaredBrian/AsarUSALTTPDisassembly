
; ==============================================================================

; $0F1BC8-$0F1C6A JUMP LOCATION
Sprite_Zoro:
    shared Sprite_Babusu:
{
    LDA.w $0E90, X : BNE .is_zoro
    
    JMP Babusu_Main
    
    .is_zoro
    
    LDA.w $0DB0, X : BNE .initialized
    
    INC.w $0DB0, X
    
    JSR.w Sprite3_IsBelowPlayer
    
    ; 0 - sprite is above or level with player
    ; 1 - sprite is below player
    CPY.b #$00 : BEQ .dont_self_terminate
    
    ; is sprite is below player during the initialization phase, we just
    ; self terminate. This would be after the player enters the door
    ; and enters a different quadrant.
    STZ.w $0DD0, X
    
    RTS
    
    .dont_self_terminate
    .initialized
    
    JSL.l Sprite_PrepAndDrawSingleSmallLong
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckDamage
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR A : AND.b #$01 : STA.w $0DC0, X
    
    LDA.w $0E80, X : LSR #2 : AND.b #$01 : TAY
    
    LDA Sprite3_Shake_x_speeds, Y : STA.w $0D50, X
    
    JSR.w Sprite3_Move
    
    LDA.w $0DF0, X : BNE .dont_self_terminate
    
    JSR.w Sprite3_CheckTileCollision : BEQ .dont_self_terminate
    
    STZ.w $0DD0, X
    
    .dont_self_terminate
    
    LDA.w $0E80, X : AND.b #$03 : BNE .spawn_delay
    
    PHX : TXY
    
    LDX.b #$1D
    
    .next_slot
    
    LDA.l $7FF800, X : BEQ .spawn_zoro_garnish
    
    DEX : BPL .next_slot
    
    PLX
    
    .spawn_delay
    
    RTS
    
    .spawn_zoro_garnish
    
    LDA.b #$06 : STA.l $7FF800, X : STA.w $0FB4
    
    LDA.w $0D10, Y : STA.l $7FF83C, X
    LDA.w $0D30, Y : STA.l $7FF878, X
    
    LDA.w $0D00, Y : CLC : ADC.b #$10 : STA.l $7FF81E, X
    LDA.w $0D20, Y : ADC.b #$00 : STA.l $7FF85A, X
    
    LDA.b #$0A : STA.l $7FF90E, X
    
    TYA : STA.l $7FF92C, X
    
    LDA.w $0F20, Y : STA.l $7FF968, X
    
    PLX
    
    RTS
}

; ==============================================================================

; $0F1C6B-$0F1C80 ALTERNATE ENTRY POINT
Babusu_Main:
{
    JSL.l Babusu_Draw
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Babusu_Reset
    dw Babusu_Hiding
    dw Babusu_TerrorSprinkles
    dw Babusu_ScurryAcross
}

; ==============================================================================

; $0F1C81-$0F1C8E JUMP LOCATION
Babusu_Reset:
{
    INC.w $0D80, X
    
    LDA.b #$80 : STA.w $0DF0, X
    
    LDA.b #$FF : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F1C8F-$0F1C9C JUMP LOCATION
Babusu_Hiding:
{
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$37 : STA.w $0DF0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F1C9D-$0F1CAC DATA
Pool_Babusu_TerrorSprinkles:
{
    .animation_states
    db $05, $04, $03, $02, $01, $00
    
    .animation_adjustments
    db $06, $06, $00, $00
    
    .x_speeds length 4
    db $20, $E0
    
    .y_speeds
    db $00, $00, $20, $E0
}


; ==============================================================================

; $0F1CAD-$0F1CE7 JUMP LOCATION
Babusu_TerrorSprinkles:
{
    LDA.w $0DF0, X : BNE .delay
    
    PHA
    
    INC.w $0D80, X
    
    ; TODO: investigate whether these things can move left or right, and
    ; whether they have any understanding
    LDY.w $0DE0, X
    
    LDA.w .x_speeds, Y : STA.w $0D50, X
    
    LDA.w .y_speeds, Y : STA.w $0D40, X
    
    LDA.b #$20 : STA.w $0DF0, X
    
    PLA
    
    .delay
    
    CMP.b #$20 : BCC .still_hidden
    
    SBC.b #$20 : LSR #2 : TAY
    
                   LDA.w .animation_states, Y      
    LDY.w $0DE0, X : CLC : ADC .animation_adjustments, Y : STA.w $0DC0, X
    
    RTS
    
    .still_hidden
    
    LDA.b #$FF : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F1CE8-$0F1CEB DATA
Pool_Babusu_ScurryAcross:
{
    .animation_states
    db $12, $0E, $0C, $10
}

; ==============================================================================

; $0F1CEC-$0F1D16 JUMP LOCATION
Babusu_ScurryAcross:
{
    JSR.w Sprite3_CheckDamage
    JSR.w Sprite3_Move
    
    LDA.b $1A : LSR A : AND.b #$01
    
    LDY.w $0DE0, X
    
    CLC : ADC .animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0DF0, X : BNE .cant_collide
    
    JSR.w Sprite3_CheckTileCollision : BEQ .didnt_collide
    
    LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
    
    STZ.w $0D80, X

    .didnt_collide
    .cant_collide

    RTS
}

; ==============================================================================

