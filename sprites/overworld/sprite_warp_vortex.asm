; ==============================================================================

; $02AF71-$02AF74 DATA
Pool_Sprite_WarpVortex:
{
    .vh_flip_states
    db $00, $40, $C0, $80
}

; ==============================================================================

; $02AF75-$02B018 JUMP LOCATION
Sprite_WarpVortex:
{
    ; Warp Vortex (Sprite 0x6C)
    
    LDA.l $7EF3CA : BNE .self_terminate
    
    LDA $8A : CMP.b #$80 : BCC .in_normal_area
    
    RTS
    
    .in_normal_area
    
    LDA $11 : CMP.b #$23 : BEQ .gamma
    
    LDA.w $0FC6 : CMP.b #$03 : BCS .gamma
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    .gamma
    
    JSR Sprite2_CheckIfActive
    
    LDA $1A : LSR #2 : AND.b #$03 : TAY
    
    LDA.w $0F50, X : AND.b #$3F : ORA .vh_flip_states, Y : STA.w $0F50, X
    
    JSL Sprite_CheckIfPlayerPreoccupied : BCS .delta
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .epsilon
    
    LDA.w $0D90, X : BEQ .zeta
    
    LDA.w $037B : ORA.w $031F : BNE .zeta
    
    LDA.w $02E4 : BNE .zeta
    
    LDA.b #$23 : STA $11
    
    LDA.b #$01 : STA.w $02DB
    
    STZ $B0
    STZ $27
    STZ $28
    
    LDA.b #$14 : STA $5D
    
    LDA $8A : AND.b #$40 : STA $7B
    
    .self_terminate
    
    STZ.w $0DD0, X
    
    BRA .zeta
    
    .epsilon
    
    LDA.b #$01 : STA.w $0D90, X
    
    LDA.w $0F50, X : AND.b #$FF : STA.w $0F50, X
    
    .zeta
    
    INC.w $0DA0, X : BNE .theta
    
    LDA.b #$01 : STA.w $0D90, X
    
    .theta
    
    LDA.w $1ABF : STA.w $0D10, X
    LDA.w $1ACF : STA.w $0D30, X
    
    LDA.w $1ADF : CLC : ADC.b #$08 : STA.w $0D00, X
    LDA.w $1AEF : ADC.b #$00 : STA.w $0D20, X
    
    .delta
    
    RTS
}

; ==============================================================================
