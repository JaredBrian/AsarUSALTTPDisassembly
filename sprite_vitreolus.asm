; ==============================================================================

; $0EE763-$0EE772 DATA
Pool_Sprite_Vitreolus:
{
    ; $0EE763
    .x_offsets
    dw 1,  0, -1,  0
    
    ; $0EE76B
    .y_offsets
    dw 0,  1,  0, -1
}

; NOTE: I chose this name because it sounds authentic enough and is, as
; best I can tell, a latin diminutive form of vitreous, or close to one.
; correct me if I'm wrong, anyone.
; $0EE773-$0EE7C3 JUMP LOCATION
Sprite_Vitreolus:
{
    ; Allows even numbers from 0 to 6 inclusive.
    LDA.w $0E80, X : LSR #3 : AND.b #$06 : TAY
    
    REP #$20
    
    LDA.w $0FD8 : CLC : ADC Pool_Sprite_Vitreolus_x_offsets, Y : STA.w $0FD8
    
    LDA.w $0FDA : CLC : ADC Pool_Sprite_Vitreolus_y_offsets, Y : STA.w $0FDA
    
    SEP #$20
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite4_CheckIfActive
    
    INC.w $0E80, X
    
    ; NOTE: Interesting... active status indicated by its animation state?
    LDA.w $0DC0, X : BEQ .active
        RTS
    
    .active
    
    JSL.l Sprite_CheckDamageFromPlayerLong
    JSL.l Sprite_CheckDamageToPlayerLong
    
    LDA.w $0EA0, X : CMP.b #$0E : BNE .shorten_recoil_time
        LDA.b #$05 : STA.w $0EA0, X
    
    .shorten_recoil_time
    
    ; OPTIMIZE: Comparison with 0x01 could be changed to "dec a".
    LDA.w $0D80, X : BEQ Vitreolus_TargetPlayerPosition
    CMP.b #$01 : BEQ Vitreolus_PursueTargetPosition
        JMP Vitreolus_ReturnToOrigin
}
    
; ==============================================================================

; $0EE7C4-$0EE7D8 BRANCH LOCATION
Vitreolus_TargetPlayerPosition:
{
    LDA.b $22 : STA.w $0ED0, X
    LDA.b $23 : STA.w $0EB0, X
    
    LDA.b $20 : STA.w $0EC0, X
    LDA.b $21 : STA.w $0E30, X
    
    RTS
}
    
; ==============================================================================

; $0EE7D9-$0EE829 BRANCH LOCATION
Vitreolus_PursueTargetPosition:
{
    JSR.w Sprite4_CheckIfRecoiling
    
    TXA : EOR.b $1A : AND.b #$01 : BNE .stagger_retargeting
        LDA.w $0ED0, X : STA.b $04
        LDA.w $0EB0, X : STA.b $05
        
        LDA.w $0EC0, X : STA.b $06
        LDA.w $0E30, X : STA.b $07
        
        LDA.b #$10 : JSL.l Sprite_ProjectSpeedTowardsEntityLong
        
        LDA.b $00 : STA.w $0D40, X
        
        LDA.b $01 : STA.w $0D50, X
    
    .stagger_retargeting
    
    JSR.w Sprite4_Move
    
    LDA.w $0ED0, X : SEC : SBC.w $0D10, X : CLC : ADC.b #$04
    CMP.b #$08 : BCS .not_at_target_position
        LDA.w $0EC0, X : SEC : SBC.w $0D00, X : CLC : ADC.b #$04
        CMP.b #$08 : BCS .not_at_target_position
            INC.w $0D80, X
    
    .not_at_target_position
    
    RTS
}

; ==============================================================================

; $0EE82A-$0EE892 JUMP LOCATION
Vitreolus_ReturnToOrigin:
{
    JSR.w Sprite4_CheckIfRecoiling
    
    TXA : EOR.b $1A : AND.b #$01 : BNE .stagger_retargeting
        LDA.w $0D90, X : STA.b $04
        LDA.w $0DA0, X : STA.b $05
        
        LDA.w $0DB0, X : STA.b $06
        LDA.w $0DE0, X : STA.b $07
        
        LDA.b #$10 : JSL.l Sprite_ProjectSpeedTowardsEntityLong
        
        LDA.b $00 : STA.w $0D40, X
        
        LDA.b $01 : STA.w $0D50, X
    
    .stagger_retargeting
    
    JSR.w Sprite4_Move
    
    LDA.w $0D90, X : SEC : SBC.w $0D10, X : CLC : ADC.b #$04
    CMP.b #$08 : BCS .not_at_target_position
        LDA.w $0DB0, X : SEC : SBC.w $0D00, X : CLC : ADC.b #$04
        CMP.b #$08 : BCS .not_at_target_position
            LDA.w $0D90, X : STA.w $0D10, X
            LDA.w $0DA0, X : STA.w $0D30, X
            
            LDA.w $0DB0, X : STA.w $0D00, X
            LDA.w $0DE0, X : STA.w $0D20, X
            
            STZ.w $0D80, X
        
    .not_at_target_position
    
    RTS
}

; ==============================================================================
