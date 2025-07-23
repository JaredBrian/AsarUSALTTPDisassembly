; ==============================================================================

; $046C77-$046CAE DATA
Pool_Ancilla_WaterfallSplash:
{
    ; $046C77
    .chr
    db $C0, $FF, $AC, $AC, $AE, $AE, $BF, $BF
    
    ; $046C7F
    .properties
    db $84, $FF, $84, $C4, $84, $C4, $84, $C4
    
    ; $046C87
    .OAM_sizes
    db $02, $FF, $02, $02, $02, $02, $00, $00
    
    ; $046C8F
    .y_offsets_low
    db -4,  0, -5, -5, -3, -3, 12, 12
    
    ; $046C97
    .y_offsets_high
    db -1,  0, -1, -1, -1, -1,  0,  0
    
    ; $046C9F
    .x_offsets_low
    db  0,  0, -4,  4, -7,  7, -9, 17
    
    ; $046CA7
    .x_offsets_high
    db  0,  0, -1,  0, -1,  0, -1,  0
}

; Waterfall splash (special object 0x41)
; $046CAF-$046D88 JUMP LOCATION
Ancilla_WaterfallSplash:
{
    ; Waterfall in the swamp palace.
    LDY.b #$00
    
    LDA.b $1B : BNE .indoors
        ; Waterfall of wishing entrance. There are no other doors / entrances
        ; under falling water in the game.
        LDY.b #$01
    
    .indoors
    
    JSR.w Ancilla_CheckIfEntranceTriggered : BCS .do_splash_sequence
        STZ.w $0C4A, X
        
        RTS
    
    .do_splash_sequence
    
    LDA.b $11 : BNE .no_sound_effect
        LDA.b $1A : AND.b #$07 : BNE .no_sound_effect
            LDA.b #$1C
            JSR.w Ancilla_DoSfx2_NearPlayer
        
    .no_sound_effect
    
    LDA.b #$01 : STA.w $0351
    
    ; WTF: Why would this be necessary?
    LDA.b $2E : SEC : SBC.b #$06 : BMI .dont_reset_player_animation
        STA.b $2E
    
    .dont_reset_player_animation
    
    LDA.w $0C68, X : BNE .animation_delay
        LDA.b #$02 : STA.w $0C68, X
        
        LDA.w $0C5E, X : INC : AND.b #$03 : STA.w $0C5E, X
        
    .animation_delay
    
    LDA.b $1B : BEQ .set_y_coord
        LDA.b $20 : CMP.b #$38 : BCS .set_y_coord
            LDA.b #$38 : STA.w $0BFA, X
            LDA.b #$0D : STA.w $0C0E, X
            
            BRA .set_x_coord
        
    .set_y_coord
    
    LDA.b $20 : STA.w $0BFA, X
    LDA.b $21 : STA.w $0C0E, X
    
    .set_x_coord
    
    LDA.b $22 : STA.w $0C04, X
    LDA.b $23 : STA.w $0C18, X
    
    JSR.w Ancilla_PrepAdjustedOamCoord
    
    LDA.b $24 : BPL .positive_z_player_coord
        LDA.b #$00
    
    .positive_z_player_coord
    
    REP #$20
    
    AND.w #$00FF : EOR.w #$FFFF : INC : CLC : ADC.b $00 : STA.b $00
                                                          STA.b $06
    
    SEP #$20
    
    LDA.w $0C5E, X : ASL : TAX
    
    LDY.b #$00
    
    .next_OAM_entry
    
        LDA.w .chr, X : CMP.b #$FF : BEQ .skip_OAM_entry
            LDA.w Pool_Ancilla_WaterfallSplash_y_offsets_low, X
            CLC : ADC.b $06 : STA.b $00

            LDA.w Pool_Ancilla_WaterfallSplash_y_offsets_high, X
                  ADC.b $07 : STA.b $01
            
            LDA.w Pool_Ancilla_WaterfallSplash_x_offsets_low, X
            CLC : ADC.b $04 : STA.b $02

            LDA.w Pool_Ancilla_WaterfallSplash_x_offsets_high, X
                  ADC.b $05 : STA.b $03
            
            JSR.w Ancilla_SetOam_XY
            
            LDA.w Pool_Ancilla_WaterfallSplash_chr, X : STA.b ($90), Y

            INY
            LDA.w Pool_Ancilla_WaterfallSplash_properties, X 
            ORA.b #$30 : STA.b ($90), Y

            INY : PHY 
            TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
            LDA.w Pool_Ancilla_WaterfallSplash_OAM_sizes, X : STA.b ($92), Y
            
            PLY
            
        .skip_OAM_entry
    INX : TXA : AND.b #$01 : BNE .next_OAM_entry
    
    BRL Ancilla_RestoreIndex
}

; ==============================================================================
