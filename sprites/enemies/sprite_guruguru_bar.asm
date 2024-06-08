
; ==============================================================================

; $0F5012-$0F5019 DATA
Pool_Sprite_GuruguruBar:
{
    .offsets_low
    db -2, 2
    db -1, 1
    
    .offsets_high
    db -1, 0
    db -1, 0
}

; ==============================================================================

; $0F501A-$0F5048 JUMP LOCATION
Sprite_GuruguruBar:
{
    JSR GuruguruBar_Main
    JSR Sprite3_CheckIfActive
    
    INC.w $0E80, X
    
    LDA.w $0E20, X : SEC : SBC.b #$7E : TAY
    
    ; \hardcoded
    LDA.w $040C : CMP.b #$12 : BNE .not_in_ice_palace
    
    INY #2
    
    .not_in_ice_palace
    
    LDA.w $0D90, X : CLC : ADC .offsets_low, Y               : STA.w $0D90, X
    
    LDA.w $0DA0, X : ADC .offsets_high, Y : AND.b #$01 : STA.w $0DA0, X
    
    RTS
}

; ==============================================================================

; $0F5049-$0F51CC LOCAL JUMP LOCATION
GuruguruBar_Main:
{
    JSR Sprite3_PrepOamCoord
    
    LDA $05 : STA.w $0FB6
    
    LDA $00 : STA.w $0FA8
    
    LDA $02 : STA.w $0FA9
    
    LDA.w $0D90, X : STA $00
    
    LDA.w $0DA0, X : STA $01
    
    LDA.b #$40 : STA $0F
    
    PHX
    
    REP #$30
    
    LDA $00 : AND.w #$01FF : LSR #6 : STA $0A
    
    LDA $00 : CLC : ADC.w #$0080 : AND.w #$01FF : STA $02
    
    LDA $00 : AND.w #$00FF : ASL A : TAX
    
    LDA.l $04E800, X : STA $04
    
    LDA $02 : AND.w #$00FF : ASL A : TAX
    
    LDA.l $04E800, X : STA $06
    
    SEP #$30
    
    PLX
    
    LDA $04 : STA.w $4202
    
    LDA $0F
    
    LDY $05 : BNE .BRANCH_ALPHA
    
    STA.w $4203
    
    JSR Sprite3_DivisionDelay
    
    ASL.w $4216
    
    LDA.w $4217 : ADC.b #$00
    
    .BRANCH_ALPHA
    
    STA $0E
    
    LSR $01 : BCC .BRANCH_BETA
    
    EOR.b #$FF : INC A
    
    .BRANCH_BETA
    
    STA $04
    
    LDA $06 : STA.w $4202
    
    LDA $0F
    
    LDY $07 : BNE .BRANCH_GAMMA
    
    STA.w $4203
    
    JSR Sprite3_DivisionDelay
    
    ASL.w $4216
    
    LDA.w $4217 : ADC.b #$00
    
    .BRANCH_GAMMA
    
    STA $0F
    
    LSR $03 : BCC .BRANCH_DELTA
    
    EOR.b #$FF : INC A
    
    .BRANCH_DELTA
    
    STA $06
    
    LDA.w $0E80, X : ASL #4 : AND.b #$C0 : ORA.w $0FB6 : STA $0D
    
    LDY.b #$00
    
    ; Draw base segment.
    LDA $04    : CLC : ADC.w $0FA8       : STA ($90), Y
    LDA $06    : CLC : ADC.w $0FA9 : INY : STA ($90), Y
    LDA.b #$28             : INY : STA ($90), Y
    LDA $0D                : INY : STA ($90), Y
    
    LDA.b #$02 : STA ($92)
    
    LDY.b #$04
    
    PHX
    
    LDX.b #$02
    
    .draw_segments_loop
    
    LDA $0E             : STA.w $4202
    LDA .multipliers, X : STA.w $4203
    
    JSR Sprite3_DivisionDelay
    
    LDA $04 : ASL A : LDA.w $4217 : BCC .BRANCH_EPSILON
    
    EOR.b #$FF : INC A
    
    .BRANCH_EPSILON
    
    CLC : ADC.w $0FA8 : STA ($90), Y
    
    LDA $0F             : STA.w $4202
    LDA .multipliers, X : STA.w $4203
    
    JSR Sprite3_DivisionDelay
    
    LDA $06 : ASL A : LDA.w $4217 : BCC .BRANCH_ZETA
    
    EOR.b #$FF : INC A
    
    .BRANCH_ZETA
    
    CLC : ADC.w $0FA9  : INY : STA ($90), Y
    LDA.b #$28 : INY : STA ($90), Y
    LDA $0D    : INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY : INY
    
    DEX : BPL .draw_segments_loop
    
    PLX
    
    LDY.b #$FF
    LDA.b #$03
    
    JSL Sprite_CorrectOamEntriesLong
    
    TXA : EOR $1A : AND.b #$03 : ORA $11
                                 ORA.w $0FC1 : BNE .damage_to_player_inhibit
    
    LDY.b #$00
    
    .check_damage_to_player_loop
    
    PHY : TYA : LSR #2 : TAY
    
    ; Check if offscreen per x coordinate.
    LDA ($92), Y : PLY : AND.b #$01 : BNE .no_player_collision
    
    LDA ($90), Y : CLC : ADC $E2 : SEC : SBC $22
    
    CLC : ADC.b #$0C : CMP.b #$18 : BCS .no_player_collision
    
    INY
    
    ; Check if offscreen per y coordinate.
    LDA ($90), Y : DEY : CMP.b #$F0 : BCS .no_player_collision
    
    CLC : ADC $E8 : SEC : SBC $20 : CLC : ADC.b #$04 : CMP.b #$10 : BCS .no_player_collision
    
    PHY
    
    JSL Sprite_AttemptDamageToPlayerPlusRecoilLong
    
    PLY
    
    .no_player_collision

    INY #4 : CPY.b #$10 : BCC .check_damage_to_player_loop

    .damage_to_player_inhibit

    RTS
    
    .multipliers
    db $40, $80, $C0
}

; ==============================================================================
