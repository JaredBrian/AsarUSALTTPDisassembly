
; ==============================================================================

; $04B5B9-$04B5BA DATA
Pool_Garnish_LaserBeamTrail:
{
    .chr
    ; \note One is horizontal, the other is vertical.
    db $D2, $F3
}

; ==============================================================================

; $04B5BB-$04B5DD JUMP LOCATION
Garnish_LaserBeamTrail:
{
    JSR Garnish_PrepOamCoord
    
    LDA.b $00       : STA ($90), Y
    LDA.b $02 : INY : STA ($90), Y
    
    PHY
    
    LDA.l $7FF9FE, X : TAY
    
    LDA .chr, Y : PLY : INY : STA ($90), Y
    
    LDA.b #$25
    
    ; $04B5D6 ALTERNATE ENTRY POINT
    shared Garnish_SetOamPropsAndSmallSize:
    
    INY : STA ($90), Y
    
    LDA.b #$00 : STA ($92)
    
    RTS
}

; ==============================================================================

