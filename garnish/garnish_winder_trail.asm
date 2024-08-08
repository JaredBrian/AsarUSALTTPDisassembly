
; ==============================================================================

; $04B6C0-$04B6E0 JUMP LOCATION
Garnish_WinderTrail:
{
    ; special animation 0x01
    
    JSR.w Garnish_PrepOamCoord
    
    LDA.b $00                    : STA ($90), Y
    LDA.b $02 : INY              : STA ($90), Y
              INY : LDA.b #$28 : STA ($90), Y
    
    PHY
    
    LDA.l $7FF92C, X : TAY
    
    ; Copy palette and other property info from the parent sprite object.
    LDA.w $0F50, Y : ORA.w $0B89, Y
    
    PLY
    
    JMP Garnish_SetOamPropsAndLargeSize
}

; ==============================================================================

