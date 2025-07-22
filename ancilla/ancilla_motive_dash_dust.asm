; ==============================================================================

; $04ADF1-$04ADF3 DATA
Ancilla_MotiveDashDust_chr:
{
    db $A9, $CF, $DF
}

; $04ADF4-$04AE3D LONG JUMP LOCATION
Ancilla_MotiveDashDust:
{
    PHB : PHK : PLB
    
    LDA.w $0C68, X : BNE .delay
        LDA #$03 : STA.w $0C68, X
        
        INC.w $0C5E, X : LDA.w $0C5E, X : CMP.b #$03 : BNE .delay
            STZ.w $0C4A, X
            
            BRA .return
        
    .delay
    
    LDA.b $2F : CMP.b #$02 : BNE .not_behind_player
        LDA.b #$04 : JSL.l OAM_AllocateFromRegionB
        
    .not_behind_player
    
    JSL.l Ancilla_PrepOamCoordLong
    
    PHX
    
    LDA.w $0C5E, X : TAX
    
    LDY.b #$00
    
    JSL.l Ancilla_SetOam_XY_Long
    
    LDA.w .chr, X          : STA.b ($90), Y : INY
    LDA.b #$04 : ORA.b $65 : STA.b ($90), Y
    
    LDA.b #$00 : STA.b ($92)
    
    PLX
    
    .return
    
    PLB
    
    RTL
}

; ==============================================================================
