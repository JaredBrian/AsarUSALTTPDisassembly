; ==============================================================================

; Special object 0x0A (arrow stuck in something)
; $04245B-$0424DC JUMP LOCATION
Ancilla_HaltedArrow:
{
    ; Set to a sprite index if it collided with a sprite when it was in
    ; motion. Set to 0xFF otherwise.
    LDY.w $03A9, X : BMI .didnt_collide_with_sprite
        LDA.w $0DD0, Y : CMP.b #$09 : BCC .self_terminate
            LDA.w $0F70, Y : BMI .self_terminate
                LDA.w $0BA0, Y : BNE .self_terminate
                    LDA.w $0CAA, Y : AND.b #$02 : BNE .self_terminate
                    
                    STZ $00
                    
                    LDA.w $0C2C, X : BPL .positive_x_speed
                        DEC $00
                    
                    .positive_x_speed
                    
                               CLC : ADC.w $0D10, Y : STA.w $0C04, X
                    LDA.w $0D30, Y : ADC $00        : STA.w $0C18, X
                    
                    STZ $00
                    
                    LDA.w $0C22, X : BPL .positive_y_speed
                        DEC $00
                    
                    .positive_y_speed
                    
                    CLC : ADC.w $0D00, Y : PHP
                    SEC : SBC.w $0F70, Y : STA.w $0BFA, X

                    LDA.w $0D20, Y : SBC.b #$00 : PLP : ADC $00 : STA.w $0C0E, X
    
    .didnt_collide_with_sprite
    
    LDA $11 : BEQ .normal_submode
        BRA .just_draw
    
    .normal_submode
    
    DEC.w $03B1, X : LDA.w $03B1, X : BNE .just_draw
        LDA.b #$02 : STA.w $03B1, X
        
        INC.w $0C5E, X : LDA.w $0C5E, X : CMP.b #$09 : BEQ .self_terminate
            AND.b #$08 : BEQ .just_draw
                LDA.b #$80 : STA.w $03B1, X
            
    .just_draw
    
    JML Arrow_Draw
    
    ; $0424DA ALTERNATE ENTRY POINT
    .self_terminate
    
    BRL Ancilla_SelfTerminate
}

; ==============================================================================
