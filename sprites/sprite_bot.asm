
; ==============================================================================

; $02B80A-$02B88C JUMP LOCATION
Sprite_Bot:
Sprite_Popo:
{
    JSR.w Bot_Draw
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_CheckIfRecoiling
    
    INC.w $0E80, X
    
    LDA.w $0E80, X : LSR #4 : AND.b #$03 : STA.w $0D90, X
    
    JSR.w Sprite2_CheckDamage
    
    LDA.w $0D80, X : CMP.b #$02 : BEQ .alpha
        CMP.b #$01 : BEQ .beta
            LDA.w $0DF0, X : BNE .gamma
                INC.w $0D80, X
                
                LDA.b #$69 : STA.w $0DF0, X
            
            .gamma
            
            RTS
        
        .beta
        
        INC.w $0E80, X
        
        LDA.w $0DF0, X : BNE .delta
            JSL.l GetRandomInt : AND.b #$3F : ADC.b #$80 : STA.w $0DF0, X
            
            INC.w $0D80, X
            
            JSL.l GetRandomInt : AND.b #$0F : TAY
            
            LDA.w Pool_Keese_Agitated_random_x_speeds, Y : ASL #2 : STA.w $0D50, X
            LDA.w Pool_Keese_Agitated_random_y_speeds, Y : ASL #2 : STA.w $0D40, X
        
        .delta
        
        RTS
    
    .alpha
    
    INC.w $0E80, X
    
    LDA.w $0DF0, X : BNE .epsilon

    .theta
        
            STZ.w $0D80, X
                
            LDA.b #$50 : STA.w $0DF0, X
                
            RTS
        
        .epsilon
        
        TXA : EOR.b $1A : AND.w $0DA0, X : BNE .zeta
            JSR.w Sprite2_Move
    
    LDA.w $0E70, X : BNE .theta

    .zeta

    ; Bleeds into the next function.
}
    
; $02B88D-$02B891 JUMP LOCATION
Sprite2_CheckTileCollision:
{
    JSL.l Sprite_CheckTileCollisionLong
    
    RTS
}

; ==============================================================================

; $02B892-$02B899 DATA
Pool_Bot_Draw:
{
    ; $02B892
    .animation_states
    db $00, $01, $00, $01
    
    ; $02B896
    .vh_flip
    db $00, $00, $40, $40
}

; $02B89A-$02B8B2 LOCAL JUMP LOCATION
Bot_Draw:
{
    LDY.w $0D90, X
    
    LDA Pool_Bot_Draw_animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$BF : ORA Pool_Bot_Draw_vh_flip, Y : STA.w $0F50, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    
    RTS
}

; ==============================================================================
