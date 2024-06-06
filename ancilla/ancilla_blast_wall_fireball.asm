
; ==============================================================================

; $042A32-$042A34 DATA
Pool_Ancilla_BlastWallFireball:
{
    .chr
    db $9D, $9C, $8D
}

; ==============================================================================

; $042A35-$042A9F JUMP LOCATION
Ancilla_BlastWallFireball:
{
    LDA $11 : BNE .just_draw
        LDA $0C5E, X : CLC : ADC.b #$02   : STA $0C5E, X
                       CLC : ADC $0C22, X : STA $0C22, X
        
        JSR Ancilla_MoveVert
        JSR Ancilla_MoveHoriz
        
        LDA.l $7F0040, X : DEC A : STA.l $7F0040, X : BPL .still_active
            STZ $0C4A, X
            
            RTS

        .still_active
    .just_draw
    
    LDA.b #$04
    
    LDY $0FB3 : BEQ .dont_sort_sprites
        JSL OAM_AllocateFromRegionD
        
        BRA .oam_allocation_determined
    
    .dont_sort_sprites
    
    JSL OAM_AllocateFromRegionA
    
    .oam_allocation_determined
    
    LDY.b #$00
    
    LDA.l $7F0040, X : STA $06 : AND.b #$08 : BNE .just_first_chr
        LDY.b #$01
        
        LDA $06 : AND.b #$04 : BNE .use_second_chr
            ; All that leaves is the third possible tile.
            LDY.b #$02
    
    .just_first_chr
    .use_second_chr
    
    LDA .chr, Y : STA $06
    
    JSR Ancilla_PrepOamCoord
    
    LDY.b #$00
    
    JSR Ancilla_SetOam_XY
    
    LDA $06    : STA ($90), Y : INY
    LDA.b #$22 : STA ($90), Y
    
    LDA.b #$00 : STA ($92)
    
    RTS
}

; ==============================================================================
