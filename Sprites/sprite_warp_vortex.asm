; ==============================================================================

; $02AF71-$02AF74 DATA
Sprite_WarpVortex_vh_flip_states:
{
    db $00, $40, $C0, $80
}

; Warp Vortex (Sprite 0x6C)
; $02AF75-$02B018 JUMP LOCATION
Sprite_WarpVortex:
{
    LDA.l $7EF3CA : BNE .self_terminate
        LDA.b $8A : CMP.b #$80 : BCC .in_normal_area
            RTS
            
        .in_normal_area
        
        LDA.b $11 : CMP.b #$23 : BEQ .gamma
            LDA.w $0FC6 : CMP.b #$03 : BCS .gamma
                JSL.l Sprite_PrepAndDrawSingleLargeLong
            
        .gamma
        
        JSR.w Sprite2_CheckIfActive
        
        LDA.b $1A : LSR : LSR : AND.b #$03 : TAY
        LDA.w $0F50, X : AND.b #$3F : ORA.w .vh_flip_states, Y : STA.w $0F50, X
        
        JSL.l Sprite_CheckIfPlayerPreoccupied : BCS .delta
            JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .epsilon
                LDA.w $0D90, X : BEQ .zeta
                    LDA.w $037B : ORA.w $031F : BNE .zeta
                        LDA.w $02E4 : BNE .zeta
                            LDA.b #$23 : STA.b $11
                            
                            LDA.b #$01 : STA.w $02DB
                            
                            STZ.b $B0
                            STZ.b $27
                            STZ.b $28
                            
                            LDA.b #$14 : STA.b $5D
                            
                            LDA.b $8A : AND.b #$40 : STA.b $7B
            
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
    LDA.w $1AEF       : ADC.b #$00 : STA.w $0D20, X
    
    .delta
    
    RTS
}

; ==============================================================================
