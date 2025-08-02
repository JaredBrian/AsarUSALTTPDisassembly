; ==============================================================================

; $04B58D-$04B590 DATA
Garnish_BlindLaserTrail_chr:
{
    db $61, $71, $70, $60
}

; $04B591-$04B5B8
Garnish_BlindLaserTrail:
{
    JSR.w Garnish_PrepOamCoord
    
    LDA.b $00       : STA.b ($90), Y
    LDA.b $02 : INY : STA.b ($90), Y
    
    PHY
    
    ; Get the chr index.
    LDA.l $7FF9FE, X : TAY
    
    ; I guess that this assumes that the chr *index*
    ; is at least 0x07?
    LDA.w .chr-7, Y : PLY : INY : STA.b ($90), Y
    
    PHY
    
    ; Copy palette and other OAM properties from the parent sprite object.
    LDA.l $7FF92C, X : TAY
    LDA.w $0F50, Y : ORA.w $0B89, Y
    
    PLY
    
    BRA Garnish_SetOamPropsAndSmallSize
}

; ==============================================================================
