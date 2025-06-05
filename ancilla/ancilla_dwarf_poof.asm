; ==============================================================================

; $04549A-$0454B8 JUMP LOCATION
Ancilla_DwarfPoof:
{
    DEC.w $03B1, X : BPL .draw
        LDA.b #$07 : STA.w $03B1, X
        
        LDA.w $0C5E, X : INC : STA.w $0C5E, X : CMP.b #$03 : BNE .draw
            STZ.w $0C4A, X
            STZ.w $02F9
            
            RTS
            
    .draw
    
    BRL MorphPoof_Draw
}

; ==============================================================================
