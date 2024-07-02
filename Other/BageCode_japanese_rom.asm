; TODO: I'm pretty sure we need to delete this file.

; $01EA1D-$01EAE0 LONG JUMP LOCATION
{
    LDA.b $F2 : AND.b #$10 : BNE .r_button_held
        JMP .fail
    
    .r_button_held
    
    REP #$20
    
    LDA.l $7003D9 : CMP.w #$00AF : BNE .fail
    LDA.l $7003DB : CMP.w #$010A : BNE .fail
    LDA.l $7003DD : CMP.w #$010A : BNE .fail
    LDA.l $7003DF : CMP.w #$010A : BNE .fail
        SEP #$20
        
        ; \wtf 0x0A to this variable seems... bad. More research needed.
        STA.l $7EF37B
        
        LDA.b $F6
        
        JSL .check_button_press
        
        LDA.l $7EF359 : CMP.b #$04 : BNE .not_golden_sword
            LDA.b #$03 : STA.l $7EF35A
            DEC A      : STA.l $7EF35B
        
        .not_golden_sword
        
        LDA.b $F4 : BPL .b_button_not_pressed
            LDA.w $037F : EOR.b #$01 : STA.w $037F
        
        .b_button_not_pressed
        
        BIT.b $F4 : .y_button_not_pressed
            ; refill all hearts, magic, bombs, and arrows
            LDA.w #$FF : STA.l $7EF372
                        STA.l $7EF373
                        STA.l $7EF375
                        STA.l $7EF376
            
            CLC : ADC.l $7EF360 : STA.l $7EF360
            
            LDA.l $7EF361 : ADC.b #$00 : STA.l $7EF361
            
            LDA.b #$09 : STA.l $7EF36F
        
        .y_button_not_pressed
        
        RTL
    
    .fail
    
    SEP #$20
    
    LDA.b $F3 : AND.b #$10 : BEQ .return
        LDA.b $F7 : BPL .return
            LDA.l $7EF359 : INC A : CMP.b #$05 : BCC .valid_sword
                LDA.b #$01 : STA.l $7EF359
            
            .valid_sword
            
            LDA.l $7EF35B : INC A : CMP.b #$03 : BNE .valid_armor
                LDA.b #$00
            
            .valid_armor
            
            LDA.l $7EF35A : INC A : CMP.b #$04 : BNE .valid_shield
                LDA.b #$01
            
            .valid_shield
            
            STA.l $7EF35A
    
    .return
    
    RTL
}