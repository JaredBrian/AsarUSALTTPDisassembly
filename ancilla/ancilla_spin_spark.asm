
; ==============================================================================

; $0458F6-$0458FC DATA
Pool_Ancilla_SpinSpark:
{
    .spark_chr
    db $D7, $B7, $80, $83
    
    .extra_spark_chr
    db $B7, $80, $83
}

; ==============================================================================

; $0458FD-$045A16 JUMP LOCATION
Ancilla_SpinSpark:
{
    LDA.w $0385, X : BEQ .multi_spark_in_progress
    
    BRL SpinSpark_ExecuteClosingSpark
    
    .multi_spark_in_progress
    
    PHX
    
    ; Normally use palette 1 for the sparks.
    LDA.b #$02 : STA.b $73
    
    LDA.b $11 : BNE .skip_state_logic
    
    ; By default, only draw the lead spark.
    LDY.b #$00
    
    LDA.w $0C5E, X : SEC : SBC.b #$03 : STA.w $0C5E, X
    
    CMP.b #$0D : BCS .dont_transition_to_closing_spark
    
    PLX
    
    LDA.b #$01 : STA.w $03B1, X
                 STA.w $0385, X
    
    STZ.w $0C5E, X
    
    BRL SpinSpark_ExecuteClosingSpark
    
    .dont_transition_to_closing_spark
    
    CMP.b #$42 : BCS .dont_draw_four_sparks
    
    ; Display 4 spark components.
    LDY.b #$03
    
    BRA .set_spark_draw_count
    
    .dont_draw_four_sparks
    
    CMP.b #$46 : BNE .dont_draw_two_sparks
    
    ; Display two spark components.
    LDY.b #$01
    
    .dont_draw_two_sparks
    
    CMP.b #$43 : BNE .dont_draw_three_sparks
    
    LDY.b #$02
    
    .dont_draw_three_sparks
    .set_spark_draw_count
    
    TYA : STA.w $0C54, X
    
    DEC.w $03B1, X : BPL .not_alternate_palette
    
    ; Use palette 2 for the sparks on this frame.
    LDA.b #$04 : STA.b $73
    
    LDA.b #$02 : STA.w $03B1, X
    
    .skip_state_logic
    .not_alternate_palette
    
    LDY.b #$00
    
    LDA.w $0C54, X : TAX
    
    .next_spark
    
    STX.b $72
    
    LDA.b $11 : BNE .dont_advance_spark_rotation
    
    LDA.l $7F5800, X : CLC : ADC.b #$04 : AND.b #$3F : STA.l $7F5800, X
    
    .dont_advance_spark_rotation
    
    PHX : PHY
    
    LDA.l $7F5808 : STA.b $08
    
    LDA.l $7F5800, X
    
    JSR.w Ancilla_GetRadialProjection
    JSL.l Sparkle_PrepOamCoordsFromRadialProjection
    
    PLY
    
    JSR.w Ancilla_SetOam_XY
    
    LDX.b $72
    
    LDA.w .spark_chr, X           : STA ($90), Y : INY
    LDA.b $73           : ORA.b $65 : STA ($90), Y : INY
    
    PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$00 : STA ($92), Y
    
    PLY
    
    PLX : DEX : BPL .next_spark
    
    PLX : PHX
    
    LDA.b $11 : BNE .skip_extra_spark_logic
    
    DEC.w $039F, X : BPL .extra_spark_delay
    
    LDA.b #$00 : STA.w $039F, X
    
    LDA.w $03A4, X : INC A : AND.b #$03 : STA.w $03A4, X
    
    CMP.b #$03 : BNE .extra_spark_rotation_delay
    
    LDA.l $7F5804 : CLC : ADC.b #$09 : AND.b #$3F : STA.l $7F5804
    
    .skip_extra_spark_logic
    .extra_spark_rotation_delay
    
    LDA.w $03A4, X : STA.b $72 : CMP.b #$03 : BEQ .anodraw_extra_spark
    
    PHY
    
    LDA.l $7F5808 : STA.b $08
    
    LDA.l $7F5804
    
    JSR.w Ancilla_GetRadialProjection
    JSL.l Sparkle_PrepOamCoordsFromRadialProjection
    
    PLY
    
    JSR.w Ancilla_SetOam_XY
    
    LDX.b $72
    
    LDA.w .extra_spark_chr, X           : STA ($90), Y : INY
    LDA.b #$04              : ORA.b $65 : STA ($90), Y : INY
    
    TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$00 : STA ($92), Y
    
    .extra_spark_delay
    .anodraw_extra_spark
    
    PLX : PHX
    
    LDA.w $0C5E, X : TAX : CPX.b #$07 : BNE .never
    
    ; WTF:(confirmed that this never seems to execute)
    ; Possibly debug code or a dev dicking around that was never taken
    ; out.
    LDY.b #$03 : LDA.b #$01 : STA ($92), Y
    
    .never
    
    PLX
    
    RTS
}

; ==============================================================================

; NOTE: Takes the calculated radial projection and converts the values
; to screen relative coordinates (oam coordinates)
; $045A17-$045A4B LONG JUMP LOCATION
Sparkle_PrepOamCoordsFromRadialProjection:
{
    REP #$20
    
    LDA.b $00
    
    LDY.b $02 : BEQ .positive_y_projection
    
    EOR.w #$FFFF : INC A
    
    .positive_y_projection
    
    CLC : ADC.l $7F5810 : CLC : ADC.w #$FFFC : SEC : SBC.b $E8 : STA.b $00
    
    LDA.b $04
    
    LDY.b $06 : BEQ .positive_x_projection
    
    EOR.w #$FFFF : INC A
    
    .positive_x_projection
    
    CLC : ADC.l $7F580E : CLC : ADC.w #$FFFC : SEC : SBC.b $E2 : STA.b $02
    
    SEP #$20
    
    RTL
}

; ==============================================================================

; $045A4C-$045A83 LONG BRANCH LOCATION
SpinSpark_ExecuteClosingSpark:
{
    DEC.w $03B1, X : BPL .animation_delay
    
    LDA.b #$01 : STA.w $03B1, X
    
    LDA.w $0C5E, X : INC A : STA.w $0C5E, X
    
    CMP.b #$03 : BNE .termination_delay
    
    STZ.w $0C4A, X
    
    .animation_delay
    .termination_delay
    
    JSR.w Ancilla_PrepOamCoord
    
    REP #$20
    
    LDA.b $00 : STA.b $06
    LDA.b $02 : STA.b $08
    
    SEP #$20
    
    PHX
    
    LDY.b #$00 : STY.b $04
    
    LDA.w $0C5E, X : CLC : ADC.b #$04 : ASL #2 : TAX
    
    BRL Ancilla_InitialSpinSpark_oam_commit_loop
}

; ==============================================================================
