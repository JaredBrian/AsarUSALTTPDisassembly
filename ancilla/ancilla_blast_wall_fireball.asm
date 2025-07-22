; ==============================================================================

; $042A32-$042A34 DATA
Ancilla_BlastWallFireball_chr:
{
    db $9D, $9C, $8D
}

; $042A35-$042A9F JUMP LOCATION
Ancilla_BlastWallFireball:
{
    LDA.b $11 : BNE .just_draw
        LDA.w $0C5E, X : CLC : ADC.b #$02     : STA.w $0C5E, X
                         CLC : ADC.w $0C22, X : STA.w $0C22, X
        
        JSR.w Ancilla_MoveVert
        JSR.w Ancilla_MoveHoriz
        
        LDA.l $7F0040, X : DEC : STA.l $7F0040, X
        BPL .still_active
            STZ.w $0C4A, X
            
            RTS

        .still_active
    .just_draw
    
    LDA.b #$04
    
    LDY.w $0FB3 : BEQ .dont_sort_sprites
        JSL.l OAM_AllocateFromRegionD
        
        BRA .OAM_allocation_determined
    
    .dont_sort_sprites
    
    JSL.l OAM_AllocateFromRegionA
    
    .OAM_allocation_determined
    
    LDY.b #$00
    
    LDA.l $7F0040, X : STA.b $06
    AND.b #$08 : BNE .just_first_chr
        LDY.b #$01
        
        LDA.b $06 : AND.b #$04 : BNE .use_second_chr
            ; All that leaves is the third possible tile.
            LDY.b #$02

        .use_second_chr
    .just_first_chr
    
    LDA.w .chr, Y : STA.b $06
    
    JSR.w Ancilla_PrepOamCoord
    
    LDY.b #$00
    JSR.w Ancilla_SetOam_XY
    
    LDA.b $06  : STA.b ($90), Y
    
    INY
    LDA.b #$22 : STA.b ($90), Y
    
    LDA.b #$00 : STA.b ($92)
    
    RTS
}

; ==============================================================================
