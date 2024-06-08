
; ==============================================================================

; $04B6E1-$04B713 JUMP LOCATION
Garnish_MothulaBeamTrail:
{
    LDY.b #$00
    
    LDA.l $7FF83C, X : SEC : SBC.b $E2                    : STA ($90), Y
    LDA.l $7FF81E, X : SEC : SBC.b $E8 : INY              : STA ($90), Y
                               INY : LDA.b #$AA : STA ($90), Y
    
    LDA.l $7FF92C, X
    
    PHY
    
    LDA.l $7FF92C, X : TAY
    
    ; Copy palette and other property info from the parent sprite object.
    LDA.w $0F50, Y : ORA.w $0B89, Y
    
    PLY
    
    ; $04B70C ALTERNATE ENTRY POINT
    shared Garnish_SetOamPropsAndLargeSize:
    
    INY : STA ($90), Y
    
    LDA.b #$02 : STA ($92)
    
    RTS
}

; ==============================================================================
