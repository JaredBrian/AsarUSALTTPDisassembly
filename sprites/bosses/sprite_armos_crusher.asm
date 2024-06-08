
; ==============================================================================

; \note Looks like a handler for the lone pissed off armos knight after
; you kill all his bros.
; $0EEF76-$0EEF7D LONG JUMP LOCATION
Sprite_ArmosCrusherLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_ArmosCrusher
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EEF7E-$0EEFAB LOCAL JUMP LOCATION
Sprite_ArmosCrusher:
{
    ; Spotted in changing the Armos palette for the last one.
    LDA.b #$07 : STA.w $0F50, X
    
    STZ.w $011C
    STZ.w $011D
    
    ; Has the Armos Knight crashed down? 
    LDA.w $0F10, X : BEQ .dont_shake_environment
    
    ; Otherwise, shake the ground.
    AND.b #$01 : TAY
    
    LDA Sprite_ApplyConveyorAdjustment.x_shake_values, Y : STA.w $011C
    
    LDA Sprite_ApplyConveyorAdjustment.y_shake_values, Y : STA.w $011D
    
    .dont_shake_environment
    
    LDA.w $0ED0, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw ArmosCrusher_RetargetPlayer
    dw ArmosCrusher_ApproachTargetCoords
    dw ArmosCrusher_Hover
    dw ArmosCrusher_Crush
}

; ==============================================================================

; $0EEFAC-$0EEFDF JUMP LOCATION
ArmosCrusher_RetargetPlayer:
{
    JSR Sprite4_CheckDamage
    
    LDA.w $0DF0, X : ORA.w $0F70, X : BNE .delay
    
    LDA.b #$20 : JSL Sprite_ApplySpeedTowardsPlayerLong
    
    LDA.b #$20 : STA.w $0F80, X
    
    INC.w $0ED0, X
    
    LDA.b $22 : STA.w $0DA0, X
    LDA.b $23 : STA.w $0DB0, X
    
    LDA.b $20 : STA.w $0E90, X
    LDA.b $21 : STA.w $0EB0, X
    
    LDA.b #$20 : JSL Sound_SetSfx2PanLong
    
    .delay
    
    RTS
}

; ==============================================================================

; $0EEFE0-$0EF038 JUMP LOCATION
ArmosCrusher_ApproachTargetCoords:
{
    LDA.w $0F80, X : CLC : ADC.b #$03 : STA.w $0F80, X
    
    JSR Sprite4_CheckTileCollision : BNE .collided_with_tile
    
    JSL Sprite_Get_16_bit_CoordsLong
    
    LDA.w $0DA0, X : STA.b $00
    LDA.w $0DB0, X : STA.b $01
    
    LDA.w $0E90, X : STA.b $02
    LDA.w $0EB0, X : STA.b $03
    
    REP #$20
    
    LDA.b $00 : SEC : SBC.w $0FD8 : CLC : ADC.w #$0010
    
    CMP.w #$0020 : BCS .not_close_enough_to_player
    
    LDA.b $02 : SEC : SBC.w $0FDA : CLC : ADC.w #$0010
    
    CMP.w #$0020 : BCS .not_close_enough_to_player
    
    SEP #$20
    
    .collided_with_tile
    
    INC.w $0ED0, X
    
    LDA.b #$10 : STA.w $0DF0, X
    
    STZ.w $0D50, X
    STZ.w $0D40, X
    
    .not_close_enough_to_player
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0EF039-$0EF044 JUMP LOCATION
ArmosCrusher_Hover:
{
    STZ.w $0F80, X
    
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0ED0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0EF045-$0EF062 JUMP LOCATION
ArmosCrusher_Crush:
{
    LDA.b #-$68 : STA.w $0F80, X
    
    ; \wtf Um.... why check for negative exactly?
    LDA.w $0F70, X : BMI .not_done_crushing
    
    LDA.b #$20 : STA.w $0DF0, X
    
    STZ.w $0ED0, X
    
    LDA.b #$0C : JSL Sound_SetSfx2PanLong
    
    LDA.b #$20 : STA.w $0F10, X
    
    .not_done_crushing
    
    RTS
}

; ==============================================================================
