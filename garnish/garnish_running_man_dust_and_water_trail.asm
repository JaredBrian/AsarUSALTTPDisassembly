
; ==============================================================================

; $04B3B9-$04B3BB DATA
Pool_Garnish_RunningManDashDust:
{
    .chr.
    db $DF, $CF, $A9
}

; ==============================================================================

; $04B3BC-$04B3E7 JUMP LOCATION
Garnish_RunningManDashDust:
{
    LDA.l $7FF90E, X
    
    BRA .set_chr_index
    
    ; $04B3C2 ALTERNATE ENTRY POINT
    shared Garnish_WaterTrail:
    
    LDA.l $7FF90E, X
    
    LSR A
    
    .set_chr_index
    
    LSR #2 : STA.w $0FB5
    
    JSR.w Garnish_PrepOamCoord
    
    LDA.b $00       : STA ($90), Y
    LDA.b $02 : INY : STA ($90), Y
    
    PHX
    
    LDX.w $0FB5
    
    LDA.w .chr, X : INY : STA ($90), Y
    
    LDA.b #$24
    
    PLX
    
    JMP Garnish_SetOamPropsAndSmallSize
}

; ==============================================================================

