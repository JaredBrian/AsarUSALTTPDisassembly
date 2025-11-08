; ==============================================================================

; $047169-$04718C DATA
Pool_Ancilla_SuperBombExplosion:
{
    ; $047169
    .y_offsets
    dw   0, -16, -24, -16,   0,   0,  16,  24,  16
    
    ; $04717B
    .x_offsets
    dw   0, -16,   0,  16, -24,  24, -16,   0,  16
}

; $04718D-$04727B JUMP LOCATION
Ancilla_SuperBombExplosion:
{
    LDA.b $11 : BNE .draw
        DEC.w $039F, X
        LDA.w $039F, X : BNE .draw
            INC.w $0C5E, X
            LDA.w $0C5E, X : CMP.b #$02 : BNE .blast_SFX_delay
                LDA.b #$0C
                JSR.w Ancilla_DoSFX2
            
            .blast_SFX_delay
            
            LDA.w $0C5E, X : CMP.b #$0B : BNE .not_fully_exploded
                STZ.w $0C4A, X
                
                RTS
                
            .not_fully_exploded
            
            TAY 
            LDA.w Ancilla_Bomb_interstate_intervals, Y : STA.w $039F, X
        
    .draw
    
    LDA.b #$08 : STA.b $09
    
    LDA.b #$30 : STA.b $65
                 STZ.b $64
    
                 STZ.b $0A
    LDA.b #$32 : STA.b $0B
    
    LDA.w $0C5E, X : TAY
    LDA.w Bomb_Draw_num_OAM_entries, Y : STA.b $08
    
    LDA.w Ancilla_Bomb_chr_groups, Y : TAY
    LDA.w Bomb_Draw_chr_start_offset, Y : ASL : TAY
    ASL                                       : STA.b $04
                                                STZ.b $05
    
    TYA : STA.w $0C54, X
    
    LDY.b #$00
    
    .next_blast
    
        PHX : PHY
        
        LDA.w $0BFA, X : STA.b $00
        LDA.w $0C0E, X : STA.b $01
        
        LDA.w $0C04, X : STA.b $02
        LDA.w $0C18, X : STA.b $03
        
        LDA.b $09 : ASL : TAY
        
        REP #$20
        
        LDA.b $00 : CLC : ADC.w Pool_Ancilla_SuperBombExplosion_y_offsets, Y
        SEC : SBC.b $E8 : STA.b $00

        LDA.b $02 : CLC : ADC.w Pool_Ancilla_SuperBombExplosion_x_offsets, Y
        SEC : SBC.b $E2 : STA.b $02
        
        SEP #$20
        
        PLY
        
        LDA.w $0C54, X : TAX
        
        LDA.b $01 : BNE .off_screen
            LDA.b $03 : BNE .off_screen
                PHX : PHY
                
                LDA.b #$18
                JSR.w Ancilla_AllocateOam
                
                PLY : PLX
                
                LDA.b $00 : STA.b $0C
                LDA.b $01 : STA.b $0D
                
                LDA.b $02 : STA.b $0E
                LDA.b $03 : STA.b $0F
                
                STZ.b $06
                STZ.b $07
                
                JSR.w Bomb_DrawExplosion
        
        .off_screen
        
        PLX 
    DEC.b $09 : BPL .next_blast
    
    LDA.w $0C5E, X : CMP.b #$03 : BNE .anomute_vulnerable_tiles
        LDA.w $039F, X : CMP.b #$01 : BNE .anomute_vulnerable_tiles
            LDA.w $0BFA, X : STA.b $00
            LDA.w $0C0E, X : STA.b $01
            
            LDA.w $0C04, X : STA.b $02
            LDA.w $0C18, X : STA.b $03
            
            PHX
            
            JSL.l Bomb_CheckForVulnerableTileObjects
            
            PLX
            
            LDA.b #$00 : STA.l $7EF3CC
    
    .anomute_vulnerable_tiles
    
    RTS
}

; ==============================================================================
