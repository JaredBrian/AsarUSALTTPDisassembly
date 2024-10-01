; ==============================================================================

; $04B284-$04B2B1 DATA
Pool_Garnish_GanonBatFlame:
{
    ; $04B284
    .chr
    db $AC, $AE, $66, $66, $8E, $A0, $A2
    
    ; $04B28B
    .properties
    db $01, $41, $01, $41, $00, $00, $00
    
    ; $04B292
    .chr_indices
    db 7, 6, 5, 4, 5, 4, 5, 4
    db 5, 4, 5, 4, 5, 4, 5, 4
    db 5, 4, 5, 4, 5, 4, 5, 4
    db 5, 4, 5, 4, 5, 4, 5, 4
}

; ==============================================================================

; NOTE: The last several frames of the GanonBatFlame object will look
; like this and will not damage the player.
; Special animation 0x11
; $04B2B2-$04B305 JUMP LOCATION
Garnish_GanonBatFlameout:
{
    LDA.b $11 : ORA.w $0FC1 : BNE .pause_movement
        LDA.l $7FF81E, X : SEC : SBC.b #$01 : STA.l $7FF81E, X
        LDA.l $7FF85A, X       : SBC.b #$00 : STA.l $7FF85A, X
        
    .pause_movement
    
    JSR.w Garnish_PrepOamCoord
    
    REP #$10
    
    LDY.b $90
    
    LDA.b $00         : STA.w $0000, Y
    CLC : ADC.b #$08  : STA.w $0004, Y
    LDA.b $02         : STA.w $0001, Y : STA.w $0005, Y
    LDA.b #$A4        : STA.w $0002, Y
    INC A             : STA.w $0006, Y
    LDA.b #$22        : STA.w $0003, Y : STA.w $0007, Y 
    
    LDY.b $92
    
    LDA.b #$00 : STA.w $0000, Y : STA.w $0001, Y
    
    SEP #$10
    
    RTS
}

; ==============================================================================

; Special animation 0x10
; $04B306-$04B33E JUMP LOCATION
Garnish_GanonBatFlame:
{
    LDA.l $7FF90E, X : CMP.b #$08 : BNE .dont_transmute
        LDA.b #$11 : STA.l $7FF800, X
    
    .dont_transmute
    
    JSR.w Garnish_PrepOamCoord
    
    LDA.b $00       : STA ($90), Y
    LDA.b $02 : INY : STA ($90), Y
    
    LDA.l $7FF90E, X : LSR #3 : PHX : TAX
    
    LDA.w Pool_Garnish_GanonBatFlame_chr_indices, X : TAX
    
    LDA.w Pool_Garnish_GanonBatFlame_chr, X : INY : STA ($90), Y
    
    LDA.b #$22 : ORA Pool_Garnish_GanonBatFlame_properties, X
    
    PLX
    
    JSR.w Garnish_SetOamPropsAndLargeSize
    
    JMP Garnish_CheckPlayerCollision
}

; ==============================================================================
