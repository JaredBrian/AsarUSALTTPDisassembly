
; ==============================================================================

; $0F5012-$0F5019 DATA
Pool_Sprite_GuruguruBar:
{
    ; $0F5012
    .offsets_low
    db -2, 2
    db -1, 1
    
    ; $0F5016
    .offsets_high
    db -1, 0
    db -1, 0
}

; $0F501A-$0F5048 JUMP LOCATION
Sprite_GuruguruBar:
{
    JSR.w GuruguruBar_Main
    JSR.w Sprite3_CheckIfActive
    
    INC.w $0E80, X
    
    LDA.w $0E20, X : SEC : SBC.b #$7E : TAY
    
    ; HARDCODED:
    LDA.w $040C : CMP.b #$12 : BNE .not_in_ice_palace
        INY #2
    
    .not_in_ice_palace
    
    LDA.w $0D90, X : CLC : ADC .offsets_low, Y : STA.w $0D90, X
    
    LDA.w $0DA0, X : ADC Pool_Sprite_GuruguruBar_offsets_high, Y : AND.b #$01 : STA.w $0DA0, X
    
    RTS
}

; ==============================================================================

; $0F5049-$0F51CC LOCAL JUMP LOCATION
GuruguruBar_Main:
{
    JSR.w Sprite3_PrepOamCoord
    
    LDA.b $05 : STA.w $0FB6
    
    LDA.b $00 : STA.w $0FA8
    
    LDA.b $02 : STA.w $0FA9
    
    LDA.w $0D90, X : STA.b $00
    
    LDA.w $0DA0, X : STA.b $01
    
    LDA.b #$40 : STA.b $0F
    
    PHX
    
    REP #$30
    
    LDA.b $00 : AND.w #$01FF : LSR #6 : STA.b $0A
    
    LDA.b $00 : CLC : ADC.w #$0080 : AND.w #$01FF : STA.b $02
    
    LDA.b $00 : AND.w #$00FF : ASL A : TAX
    
    LDA.l SmoothCurve, X : STA.b $04
    
    LDA.b $02 : AND.w #$00FF : ASL A : TAX
    
    LDA.l SmoothCurve, X : STA.b $06
    
    SEP #$30
    
    PLX
    
    LDA.b $04 : STA.w SNES.MultiplicandA
    
    LDA.b $0F
    
    LDY.b $05 : BNE .BRANCH_ALPHA
    	STA.w SNES.MultiplierB
    
    	JSR.w Sprite3_DivisionDelay
    
    	ASL.w SNES.RemainderResultLow
    
    	LDA.w SNES.RemainderResultHigh : ADC.b #$00
    
    .BRANCH_ALPHA
    
    STA.b $0E
    
    LSR.b $01 : BCC .BRANCH_BETA
    	EOR.b #$FF : INC A
    
    .BRANCH_BETA
    
    STA.b $04
    
    LDA.b $06 : STA.w SNES.MultiplicandA
    
    LDA.b $0F
    
    LDY.b $07 : BNE .BRANCH_GAMMA
    	STA.w SNES.MultiplierB
    
    	JSR.w Sprite3_DivisionDelay
    
    	ASL.w SNES.RemainderResultLow
    
    	LDA.w SNES.RemainderResultHigh : ADC.b #$00
    
    .BRANCH_GAMMA
    
    STA.b $0F
    
    LSR.b $03 : BCC .BRANCH_DELTA
    	EOR.b #$FF : INC A
    
    .BRANCH_DELTA
    
    STA.b $06
    
    LDA.w $0E80, X : ASL #4 : AND.b #$C0 : ORA.w $0FB6 : STA.b $0D
    
    LDY.b #$00
    
    ; Draw base segment.
    LDA.b $04    : CLC : ADC.w $0FA8       : STA ($90), Y
    LDA.b $06    : CLC : ADC.w $0FA9 : INY : STA ($90), Y
    LDA.b #$28                       : INY : STA ($90), Y
    LDA.b $0D                        : INY : STA ($90), Y
    
    LDA.b #$02 : STA ($92)
    
    LDY.b #$04
    
    PHX
    
    LDX.b #$02
    
    .draw_segments_loop
    
        LDA.b $0E             : STA.w SNES.MultiplicandA
        LDA.w .multipliers, X : STA.w SNES.MultiplierB
    
        JSR.w Sprite3_DivisionDelay
    
        LDA.b $04 : ASL A : LDA.w SNES.RemainderResultHigh : BCC .BRANCH_EPSILON
            EOR.b #$FF : INC A
    
        .BRANCH_EPSILON
    
    	CLC : ADC.w $0FA8 : STA ($90), Y
    
    	LDA.b $0F             : STA.w SNES.MultiplicandA
    	LDA.w .multipliers, X : STA.w SNES.MultiplierB
    
    	JSR.w Sprite3_DivisionDelay
    
    	LDA.b $06 : ASL A : LDA.w SNES.RemainderResultHigh : BCC .BRANCH_ZETA
    	    EOR.b #$FF : INC A
    
    	.BRANCH_ZETA
    
    	CLC : ADC.w $0FA9 : INY : STA ($90), Y
    	LDA.b #$28        : INY : STA ($90), Y
    	LDA.b $0D         : INY : STA ($90), Y
       
    	PHY : TYA : LSR #2 : TAY
    
    	LDA.b #$02 : STA ($92), Y
    
    	PLY : INY
    DEX : BPL .draw_segments_loop
    
    PLX
    
    LDY.b #$FF
    LDA.b #$03
    JSL.l Sprite_CorrectOamEntriesLong
    
    TXA : EOR.b $1A : AND.b #$03 : ORA.b $11 : ORA.w $0FC1 : BNE .damage_to_player_inhibit
        LDY.b #$00
    
        .check_damage_to_player_loop
    
            PHY : TYA : LSR #2 : TAY
    
            ; Check if offscreen per x coordinate.
            LDA ($92), Y : PLY : AND.b #$01 : BNE .no_player_collision
    	        LDA ($90), Y : CLC : ADC.b $E2 : SEC : SBC.b $22
    
    	        CLC : ADC.b #$0C : CMP.b #$18 : BCS .no_player_collision
    	            INY
    
    	            ; Check if offscreen per y coordinate.
    	            LDA ($90), Y : DEY : CMP.b #$F0 : BCS .no_player_collision
    	    	        CLC : ADC.b $E8 : SEC : SBC.b $20
		        CLC : ADC.b #$04 : CMP.b #$10 : BCS .no_player_collision
    	    	            PHY
    
    	    	            JSL.l Sprite_AttemptDamageToPlayerPlusRecoilLong
      
    	                    PLY
    
            .no_player_collision
        INY #4 : CPY.b #$10 : BCC .check_damage_to_player_loop

    .damage_to_player_inhibit

    RTS
    
    ; $0F51C99
    .multipliers
    db $40, $80, $C0
}

; ==============================================================================
