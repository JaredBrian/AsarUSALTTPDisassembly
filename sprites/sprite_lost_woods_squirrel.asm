; ==============================================================================

; $029468-$0294AE JUMP LOCATION
Sprite_LostWoodsSquirrel:
{
    LDA.w $0E00, X : BNE .delay
        LDA.w $0F50, X : AND.b #$BF
        
        LDY.w $0D50, X : BMI .moving_left
            ORA.b #$40
        
        .moving_left
        
        STA.w $0F50, X
        
        JSL.l Sprite_PrepAndDrawSingleLargeLong
        JSR.w Sprite2_CheckIfActive
        JSR.w Sprite2_Move
        JSR.w Sprite2_MoveAltitude
        
        LDA.w $0F80, X : DEC #2 : STA.w $0F80, X
        
        LDA.w $0F70, X : BPL .nonnegative_altitude
            ; If the sprite's altitude goes negative, force it back to 0.
            STZ.w $0F70, X
            
            ; And make the squirrel pop up a bit too.
            LDA.b #$10 : STA.w $0F80, X
            LDA.b #$0C : STA.w $0DF0, X
        
        .nonnegative_altitude
        
        LDA.b #$00
        
        LDY.w $0DF0, X : BEQ .falling_graphic
            ; Or the jumping up sprite state.
            INC
            
        .falling_graphic
        
        STA.w $0DC0, X
    
    .delay
    
    RTS
}

; ==============================================================================
