; ==============================================================================

; $04B150-$04B177 DATA
Pool_Garnish_ArrghusSplash:
{
    ; $04B150
    .y_offsets
    db -12,  20, -10,  10,  -8,   8,  -4,   4
    
    ; $04B158
    .x_offsets
    db  -4,  -4,  -2,  -2,   0,   0,   0,   0
    
    ; $04B160
    .chr
    db $AE, $AE, $AE, $AE, $AE, $AE, $AC, $AC
    
    ; $04B168
    .properties
    db $34, $74, $34, $74, $34, $74, $34, $74
    
    ; $04B170
    .oam_sizes
    db $00, $00, $02, $02, $02, $02, $02, $02
}

; $04B178-$04B1BC JUMP LOCATION
Garnish_ArrghusSplash:
{
    JSR.w Garnish_PrepOamCoord
    
    LDA.l $7FF90E, X : LSR A : AND.b #$06 : STA.b $06
    
    ; Number of sprites to draw (2).
    LDA.b #$01 : STA.b $07
    
    PHX
    
    .next_oam_entry
        
        LDA.b $06 : ORA.b $07 : TAX
        
        LDA.b $00
        CLC : ADC Pool_Garnish_ArrghusSplash_y_offsets, X       : STA ($90), Y

        LDA.b $02
        CLC : ADC Pool_Garnish_ArrghusSplash_x_offsets, X : INY : STA ($90), Y
        
        LDA.w Pool_Garnish_ArrghusSplash_chr, X        : INY : STA ($90), Y
        LDA.w Pool_Garnish_ArrghusSplash_properties, X : INY : STA ($90), Y
        
        PHY
        
        TYA : LSR #2 : TAY
        
        LDA.w Pool_Garnish_ArrghusSplash_oam_sizes, X : STA ($92), Y
        
        PLY : INY
    DEC.b $07 : BPL .next_oam_entry
    
    PLX
    
    RTS
}

; ==============================================================================
