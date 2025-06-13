; ==============================================================================

; $0451D4-$0451D7 DATA
Pool_Ancilla_TravelBirdIntro:
{
    ; $0451D4
    .hflip_settings
    db $40, $00
    
    ; NOTE: These are sensitively calibrated values that can look funky or
    ; keep the bird on screen indefinitely if set to other values.
    ; $0451D6
    .swirl_speeds
    db $1C, $3C
}

; $0451D8-$045379 JUMP LOCATION
Ancilla_TravelBirdIntro:
{
    ; Check the frame index.
    LDA.b $1A : AND.b #$1F : BNE .no_flutter_SFX
        LDA.b #$1E : JSR.w Ancilla_DoSfx3
        
    .no_flutter_SFX
    
    DEC.w $039F, X : BPL .flap_delay
        LDA.b #$03 : STA.w $039F, X
        
        ; Controls the flapping of the wings. (The two sprite graphic states.)
        ; Toggle it, basically.
        LDA.w $0380, X : EOR.b #$01 : STA.w $0380, X
        
    .flap_delay
    
    DEC.w $03B1, X : LDA.w $03B1, X : BEQ .movement_logic
        BRL .update_position_draw
        
    .movement_logic
    
    LDA.b #$01 : STA.w $03B1, X
    
    LDA.w $0385, X : BNE .swirling_logic
        DEC.w $0C5E, X : BMI .init_swirling_logic
            LDY.b #$FF
            
            LDA.w $0C54, X : BEQ .accelerate_descent
                ; In this case, accelerate ascent.
                LDY.b #$01
            
            .accelerate_descent
            
            TYA : CLC : ADC.w $0294, X : STA.w $0294, X : BPL .abs_z_speed
                ; Get abs(z speed) so we can check whether to reverse the float
                ; polarity.
                EOR.b #$FF : INC A
                
            .abs_z_speed
            
            CMP.b #$0C : BCC .dont_flip_float_polarity
                LDA.w $0C54, X : EOR.b #$01 : STA.w $0C54, X
                
            .dont_flip_float_polarity
            
            BRL .update_position_and_draw
        
        .init_swirling_logic
        
        STZ.w $0C5E, X
        
        STZ.w $0C54, X
        
        ; Move to the right
        LDA.w Pool_Ancilla_TravelBirdIntro_swirl_speeds : STA.w $0C2C, X
        
        ; Begin falling.
        LDA.b #$F0 : STA.w $0294, X
        
        ; Indicate that swirling logic has begun.
        INC.w $0385, X
        
        LDA.b #$03 : STA.w $0C54, X
    
    .swirling_logic
    
    LDY.b #$FF
    
    LDA.w $0C54, X : AND.b #$01 : BNE .accelerate_left
        ; Or accelerate right in this case.
        LDY.b #$01
        
    .accelerate_left
    
    TYA : CLC : ADC.w $0C2C, X : STA.w $0C2C, X : BPL .abs_x_speed
        EOR.b #$FF : INC A
        
    .abs_x_speed
    
    CMP.b #$00 : BNE .not_x_speed_inflection
        INC.w $0385, X
        LDY.w $0385, X : CPY.b #$07 : BNE .swirl_cycles_not_maxed
            PHA
            
            LDA.b #$01 : STA.w $03A9, X
            
            PLA

        .swirl_cycles_not_maxed
    .not_x_speed_inflection
    
    LDY.w $03A9, X
    
    CMP Pool_Ancilla_TravelBirdIntro_swirl_speeds, Y : BCC .x_speed_not_maxed
        ; WTF: (confirmed) Um, you know you could just xor with 0x03
        ; directly, then store it back and you'd do it in 3 instructions instead
        ; of 8?
        ; OPTIMIZE: See above. (LDA addr : EOR.b #constant : STA addr)
        LDA.w $0C54, X : AND.b #$03 : EOR.b #$03 : STA.b $00
        
        LDA.w $0C54, X : AND.b #$FC : ORA.b $00 : STA.w $0C54, X
        
    .x_speed_not_maxed
    
    LDY.b #$03
    
    LDA.w $0C2C, X : BPL .abs_x_speed_2
        EOR.b #$FF : INC A
        
        LDY.b #$02
        
    .abs_x_speed_2
    
    STA.b $00
    
    ; Set the direction the bird is facing.
    TYA : STA.w $0C72, X
    
    LDY.w $03A9, X
    
    ; NOTE: Seems that the actual z speed determined is actually affected
    ; by the current x speed. Perhaps that's where this ellipsoid behavior
    ; originates from.
    LDA.w Pool_Ancilla_TravelBirdIntro_swirl_speeds, Y
    SEC : SBC.b $00 : LSR : STA.b $00
    
    LDA.w $0C54, X : AND.b #$02 : BEQ .lowering
        ; Or rising, in this case.
        LDA.b $00 : EOR.b #$FF : INC : STA.b $00
        
    .lowering
    
    LDA.b $00 : STA.w $0294, X
    
    .update_position_and_draw
    
    JSR.w Ancilla_MoveHoriz
    JSR.w Ancilla_MoveAltitude
    
    LDY.w $0380, X
    
    ; Indicate which chr to transfer to VRAM for the travel bird. There are
    ; only two states, but this is updated every frame.
    LDA.w Pool_Ancilla_TravelBird_VRAM_offsets+1, Y : STA.w $0AF4
    
    JSR.w Ancilla_PrepOamCoord
    
    LDA.w $0C72, X : AND.b #$01 : TAY
    LDA.w Pool_Ancilla_TravelBirdIntro_hflip_settings, Y : STA.b $08
    
    REP #$20
    
    LDA.w $029E, X : AND.w #$00FF : CMP.w #$0080 : BCC .sign_ext_z_coord
        ORA.w #$FF00
        
    .sign_ext_z_coord
    
    EOR.w #$FFFF : INC : STA.b $04
    
    LDA.b $00 : STA.b $0A
    SEC : SBC.b $04 : STA.b $04
    
    LDA.b $02 : STA.b $06
    
    SEP #$20
    
    PHX
    
    LDY.b #$00
    
    REP #$20
    
    ; Check up on this to work on the bird (Paul).
    LDA.w Pool_Ancilla_TravelBird_y_offsets
    AND.w #$00FF : CLC : ADC.b $04 : STA.b $00

    LDA.w Pool_Ancilla_TravelBird_x_offsets
    AND.w #$00FF : CLC : ADC.b $06 : STA.b $02
    
    SEP #$20
    
    JSR.w Ancilla_SetOam_XY
    
    LDA.w Pool_Ancilla_TravelBird_chr : STA ($90), Y : INY

    LDA.w Pool_Ancilla_TravelBird_properties
    ORA.b #$30 : ORA.b $08 : STA ($90), Y : INY
    
    PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY
    
    REP #$20
    
    LDA.b $0A : CLC : ADC.w #$0030 : STA.b $00
    
    LDA.b $06 : STA.b $02
    
    SEP #$20
    
    LDA.b #$30 : STA.b $04
    
    LDX.b #$01 : JSR.w Ancilla_DrawShadow
    
    PLX
    
    REP #$20
    
    LDA.b $06    : BMI .bird_on_screen_x
    CMP.w #$00F8 : BCC .bird_on_screen_x
        SEP #$20
        
        ; Self terminate.
        STZ.w $0C4A, X
        
        ; Return to normal mode.
        STZ.b $11
        
        ; Give player the Flute 3 item.
        LDA.b #$03 : STA.l $7EF34C
        
    .bird_on_screen_x
    
    SEP #$20
    
    RTS
}

; ==============================================================================
